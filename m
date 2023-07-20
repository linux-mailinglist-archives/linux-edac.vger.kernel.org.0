Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4231775AEC3
	for <lists+linux-edac@lfdr.de>; Thu, 20 Jul 2023 14:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjGTMx4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 20 Jul 2023 08:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGTMxz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 20 Jul 2023 08:53:55 -0400
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DE62135
        for <linux-edac@vger.kernel.org>; Thu, 20 Jul 2023 05:53:54 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 4F47952C15; Thu, 20 Jul 2023 08:53:53 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id AD0C35297F;
        Thu, 20 Jul 2023 08:53:34 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id 13C2E220030; Thu, 20 Jul 2023 08:53:34 -0400 (EDT)
Date:   Thu, 20 Jul 2023 08:53:34 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "aris@redhat.com" <aris@redhat.com>
Subject: Re: [PATCH] x86/mce: Prevent duplicate error records
Message-ID: <20230720125334.GD94963@cathedrallabs.org>
References: <20230717152317.GA94963@cathedrallabs.org>
 <20230719092619.GJZLesOyHrL8JQyDZN@fat_crate.local>
 <20230719180723.GB94963@cathedrallabs.org>
 <20230720054908.GAZLjK1CSIrioNSI/f@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720054908.GAZLjK1CSIrioNSI/f@fat_crate.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jul 20, 2023 at 07:49:08AM +0200, Borislav Petkov wrote:
> A legitimate use case of the MCA infrastructure is to have the firmware
> log all uncorrectable errors and also, have the OS see all correctable
> errors.
> 
> The uncorrectable, UCNA errors are usually configured to be reported
> through an SMI. CMCI, which is the correctable error reporting
> interrupt, uses SMI too and having both enabled, leads to unnecessary
> overhead.
> 
> So what ends up happening is, people disable CMCI in the wild and leave
> on only the UCNA SMI.
> 
> When CMCI is disabled, the MCA infrastructure resorts to polling the MCA
> banks. If a MCA MSR is shared between the logical threads, one error
> ends up getting logged multiple times as the polling runs on every
> logical thread.
> 
> Therefore, introduce locking on the Intel side of the polling routine to
> prevent such duplicate error records from appearing.
> 
> Based on a patch by Aristeu Rozanski <aris@ruivo.org>.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Link: https://lore.kernel.org/r/20230515143225.GC4090740@cathedrallabs.org
> ---
>  arch/x86/kernel/cpu/mce/core.c     |  9 ++++++++-
>  arch/x86/kernel/cpu/mce/intel.c    | 19 ++++++++++++++++++-
>  arch/x86/kernel/cpu/mce/internal.h |  1 +
>  3 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 89e2aab5d34d..b8ad5a5b4026 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1608,6 +1608,13 @@ static void __start_timer(struct timer_list *t, unsigned long interval)
>  	local_irq_restore(flags);
>  }
>  
> +static void mc_poll_banks_default(void)
> +{
> +	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
> +}
> +
> +void (*mc_poll_banks)(void) = mc_poll_banks_default;
> +
>  static void mce_timer_fn(struct timer_list *t)
>  {
>  	struct timer_list *cpu_t = this_cpu_ptr(&mce_timer);
> @@ -1618,7 +1625,7 @@ static void mce_timer_fn(struct timer_list *t)
>  	iv = __this_cpu_read(mce_next_interval);
>  
>  	if (mce_available(this_cpu_ptr(&cpu_info))) {
> -		machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
> +		mc_poll_banks();
>  
>  		if (mce_intel_cmci_poll()) {
>  			iv = mce_adjust_timer(iv);
> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index 95275a5e57e0..f5323551c1a9 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -56,6 +56,13 @@ static DEFINE_PER_CPU(int, cmci_backoff_cnt);
>   */
>  static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
>  
> +/*
> + * On systems that do support CMCI but it's disabled, polling for MCEs can
> + * cause the same event to be reported multiple times because IA32_MCi_STATUS
> + * is shared by the same package.
> + */
> +static DEFINE_SPINLOCK(cmci_poll_lock);
> +
>  #define CMCI_THRESHOLD		1
>  #define CMCI_POLL_INTERVAL	(30 * HZ)
>  #define CMCI_STORM_INTERVAL	(HZ)
> @@ -426,12 +433,22 @@ void cmci_disable_bank(int bank)
>  	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
>  }
>  
> +/* Bank polling function when CMCI is disabled. */
> +static void cmci_mc_poll_banks(void)
> +{
> +	spin_lock(&cmci_poll_lock);
> +	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
> +	spin_unlock(&cmci_poll_lock);
> +}
> +
>  void intel_init_cmci(void)
>  {
>  	int banks;
>  
> -	if (!cmci_supported(&banks))
> +	if (!cmci_supported(&banks)) {
> +		mc_poll_banks = cmci_mc_poll_banks;
>  		return;
> +	}
>  
>  	mce_threshold_vector = intel_threshold_interrupt;
>  	cmci_discover(banks);
> diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
> index d2412ce2d312..ed4a71c0f093 100644
> --- a/arch/x86/kernel/cpu/mce/internal.h
> +++ b/arch/x86/kernel/cpu/mce/internal.h
> @@ -274,4 +274,5 @@ static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
>  	return 0;
>  }
>  
> +extern void (*mc_poll_banks)(void);
>  #endif /* __X86_MCE_INTERNAL_H__ */

Acked-by: Aristeu Rozanski <aris@ruivo.org>

-- 
Aristeu

