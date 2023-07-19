Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7661759186
	for <lists+linux-edac@lfdr.de>; Wed, 19 Jul 2023 11:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGSJ1I (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Jul 2023 05:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGSJ1H (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 19 Jul 2023 05:27:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E792136
        for <linux-edac@vger.kernel.org>; Wed, 19 Jul 2023 02:26:38 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5266C1EC0749;
        Wed, 19 Jul 2023 11:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689758796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RuWwEY8ozVhSJgpHgVIKGv/y+4yzJUxoxm+bWe5PvGQ=;
        b=aF0z+X37nFdlemehpDoAzAw7OZ/Ku92Lq3aAVNgQQXsbkWHuvv4pzWG8fzWSfVpVxt5tcr
        HG+JF3+qDM4CMse5nCstIafF+jKpR8T16fwx3Nxc/oKGX77HrUWUJ89wH9ESCT4FpdL/wO
        nmyyRhgk2iXtnGqp5EVi23lQZcS8xZo=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nAtB7gpW3nf6; Wed, 19 Jul 2023 09:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689758788; bh=RuWwEY8ozVhSJgpHgVIKGv/y+4yzJUxoxm+bWe5PvGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSB+OPf6BFYGCwC+YmUIM2yxxu5+YLmdV05rPw0XgIOsEHddLww3n7vqglDRMw00e
         4lv8j+VjtUmjXrU0w0c2J7+w4Rcb8MdYby126O2BUe+mLxHHIxvgsJXhE1K3hXJ/fs
         LX4R7xhHJjyHZA5nMlXEVZgqqF1AhTx2X0MRqnMCkli/64+O0OEhcUIfshKDrf3Z/F
         U5DJ3+pbm50ph6o0zie9ZiYVjM0ggpBrVNdJ269MuX70wdVzkABQJOvDnbv5itgFix
         Bqjk3r4BKv5KNVcjPkf/bwb3nuR7jsVK2nAIIbvBeURfIFe5f2hQV/rmswzKX7O1DP
         m62EctMCkHeRVXo2RCaV56zTGzrg4FkrdiQUUhCroq542fm568jZwpFnHIJprzN3ry
         i7Fs6bLOObtoubUp7AP83xEfI8i28gFSl3k7E2E/drdE8EnVKCHfH7dT26M/W8epYx
         2qXWVQfNEVDv7J8zSAd512Q2QG+zteX/+hbrDKblZRKGVezQNvOo7TxFUaxshq5dHG
         oNUEPIe16WlhY8QzLvd9p/BjAHcjiGFZGrnWTbDHm3OC7kdnqGDl4poguQ2jP3QmKs
         iLlIZOXVTWjqOuqw47DUu6Uq2QLdsUnFRDaMTZPkqrnB/Ka8YDxofeGqMRPd6IP5jn
         NZCnauAUQikORO9L/HkNuGtA=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F90B40E01EB;
        Wed, 19 Jul 2023 09:26:24 +0000 (UTC)
Date:   Wed, 19 Jul 2023 11:26:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Aristeu Rozanski <aris@ruivo.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "aris@redhat.com" <aris@redhat.com>
Subject: Re: [PATCH v4] mce: prevent concurrent polling of MCE events
Message-ID: <20230719092619.GJZLesOyHrL8JQyDZN@fat_crate.local>
References: <20230717152317.GA94963@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230717152317.GA94963@cathedrallabs.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 17, 2023 at 11:23:17AM -0400, Aristeu Rozanski wrote:
> On Intel microarchitectures that support CMCI but have it disabled (BIOS,
> kernel option or CMCI storm code) the kernel will resort to polling for MCEs.
> In these microarchitectures the IMC registers are shared by all CPUs in the
> same package and despite the fact that the polling is set up in the kernel to
> prevent all CPUs to poll at the same time, it's still possible they'll overlap
> and report the same MCE multiple times.
> 
> This patch fixes this by introducing synchronization during polling only for
> the affected microarchitectures.
> 
> v4: get rid of unneeded variable on intel_cmci_poll_unlock() and simplify unserialize_mc_bank_access()
> v3: add {,un}serialize_mc_bank_access() as intermediate functions as requested by Tony Luck
> 
> Signed-off-by: Aristeu Rozanski <aris@ruivo.org>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Aristeu Rozanski <aris@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: linux-edac@vger.kernel.org
> 
> ---
>  arch/x86/kernel/cpu/mce/core.c     |   18 +++++++++++++++
>  arch/x86/kernel/cpu/mce/intel.c    |   44 +++++++++++++++++++++++++++++++------
>  arch/x86/kernel/cpu/mce/internal.h |    4 +++
>  3 files changed, 59 insertions(+), 7 deletions(-)

Does this work?

---

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 89e2aab5d34d..b8ad5a5b4026 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1608,6 +1608,13 @@ static void __start_timer(struct timer_list *t, unsigned long interval)
 	local_irq_restore(flags);
 }
 
+static void mc_poll_banks_default(void)
+{
+	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+}
+
+void (*mc_poll_banks)(void) = mc_poll_banks_default;
+
 static void mce_timer_fn(struct timer_list *t)
 {
 	struct timer_list *cpu_t = this_cpu_ptr(&mce_timer);
@@ -1618,7 +1625,7 @@ static void mce_timer_fn(struct timer_list *t)
 	iv = __this_cpu_read(mce_next_interval);
 
 	if (mce_available(this_cpu_ptr(&cpu_info))) {
-		machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+		mc_poll_banks();
 
 		if (mce_intel_cmci_poll()) {
 			iv = mce_adjust_timer(iv);
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 95275a5e57e0..f5323551c1a9 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -56,6 +56,13 @@ static DEFINE_PER_CPU(int, cmci_backoff_cnt);
  */
 static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
 
+/*
+ * On systems that do support CMCI but it's disabled, polling for MCEs can
+ * cause the same event to be reported multiple times because IA32_MCi_STATUS
+ * is shared by the same package.
+ */
+static DEFINE_SPINLOCK(cmci_poll_lock);
+
 #define CMCI_THRESHOLD		1
 #define CMCI_POLL_INTERVAL	(30 * HZ)
 #define CMCI_STORM_INTERVAL	(HZ)
@@ -426,12 +433,22 @@ void cmci_disable_bank(int bank)
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 }
 
+/* Bank polling function when CMCI is disabled. */
+static void cmci_mc_poll_banks(void)
+{
+	spin_lock(&cmci_poll_lock);
+	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+	spin_unlock(&cmci_poll_lock);
+}
+
 void intel_init_cmci(void)
 {
 	int banks;
 
-	if (!cmci_supported(&banks))
+	if (!cmci_supported(&banks)) {
+		mc_poll_banks = cmci_mc_poll_banks;
 		return;
+	}
 
 	mce_threshold_vector = intel_threshold_interrupt;
 	cmci_discover(banks);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index d2412ce2d312..ed4a71c0f093 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -274,4 +274,5 @@ static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
 	return 0;
 }
 
+extern void (*mc_poll_banks)(void);
 #endif /* __X86_MCE_INTERNAL_H__ */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
