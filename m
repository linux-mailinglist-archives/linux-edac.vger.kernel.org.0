Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C03FC2513
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2019 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfI3QZz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 Sep 2019 12:25:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49572 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfI3QZy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 30 Sep 2019 12:25:54 -0400
Received: from zn.tnic (p200300EC2F058B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:8b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4890E1EC05A1;
        Mon, 30 Sep 2019 18:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569860753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6QDt9s55OymqHMPI6kw6Cuu+S3BVbgVjYt3QSGWORhc=;
        b=c/g2jkI4HcwijJ9goKtRTgWFBhdFy+8Skn1j7QXnxOsuMEZJymasodY3oouMlSXFL/RfYq
        kxx8h+7elqHM8noEQtfkangLVTDCMewnggWE2NzOx8YiA1G3pqQJ23fPRP846HMGe7HwVG
        zztTvdMu5xYlCqmoGvaKpGaEmZ226nk=
Date:   Mon, 30 Sep 2019 18:25:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
        vishal.l.verma@intel.com, qiuxu.zhuo@intel.com,
        DavidWang@zhaoxin.com, CooperYan@zhaoxin.com,
        QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com
Subject: Re: [PATCH v4 2/4] x86/mce: Make 3 functions non-static
Message-ID: <20190930162551.GA31926@zn.tnic>
References: <1568787573-1297-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <1568787573-1297-2-git-send-email-TonyWWang-oc@zhaoxin.com>
 <1568787573-1297-3-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1568787573-1297-3-git-send-email-TonyWWang-oc@zhaoxin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 18, 2019 at 02:19:31PM +0800, Tony W Wang-oc wrote:
> These functions are declared static and cannot be used in others
> .c source file. this commit removes the static attribute and adds
> the declaration to the header for these functions.
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  arch/x86/kernel/cpu/mce/intel.c    | 6 +++---
>  arch/x86/kernel/cpu/mce/internal.h | 6 ++++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index 88cd959..70799a5 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -423,7 +423,7 @@ void cmci_disable_bank(int bank)
>  	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
>  }
>  
> -static void intel_init_cmci(void)
> +void intel_init_cmci(void)
>  {
>  	int banks;
>  
> @@ -442,7 +442,7 @@ static void intel_init_cmci(void)
>  	cmci_recheck();
>  }
>  
> -static void intel_init_lmce(void)
> +void intel_init_lmce(void)
>  {
>  	u64 val;
>  
> @@ -455,7 +455,7 @@ static void intel_init_lmce(void)
>  		wrmsrl(MSR_IA32_MCG_EXT_CTL, val | MCG_EXT_CTL_LMCE_EN);
>  }
>  
> -static void intel_clear_lmce(void)
> +void intel_clear_lmce(void)
>  {
>  	u64 val;
>  
> diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
> index 43031db..842b273 100644
> --- a/arch/x86/kernel/cpu/mce/internal.h
> +++ b/arch/x86/kernel/cpu/mce/internal.h
> @@ -45,11 +45,17 @@ unsigned long cmci_intel_adjust_timer(unsigned long interval);
>  bool mce_intel_cmci_poll(void);
>  void mce_intel_hcpu_update(unsigned long cpu);
>  void cmci_disable_bank(int bank);
> +void intel_init_cmci(void);
> +void intel_init_lmce(void);
> +void intel_clear_lmce(void);
>  #else
>  # define cmci_intel_adjust_timer mce_adjust_timer_default
>  static inline bool mce_intel_cmci_poll(void) { return false; }
>  static inline void mce_intel_hcpu_update(unsigned long cpu) { }
>  static inline void cmci_disable_bank(int bank) { }
> +static inline void intel_init_cmci(void) { }
> +static inline void intel_init_lmce(void) { }
> +static inline void intel_clear_lmce(void) { }
>  #endif
>  
>  void mce_timer_kick(unsigned long interval);
> -- 

I don't think you understood what I meant last time:

"This can easily be missed because you're exporting them in one patch
and using them in another. Do the exports in the same patch where you
use them for the first time."

Anyway, I dropped this patch and exported the functions in the
respective patches where you use the functions.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
