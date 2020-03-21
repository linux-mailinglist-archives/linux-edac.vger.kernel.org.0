Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE6A18DF33
	for <lists+linux-edac@lfdr.de>; Sat, 21 Mar 2020 10:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgCUJjI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 21 Mar 2020 05:39:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52296 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgCUJjI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 21 Mar 2020 05:39:08 -0400
Received: from zn.tnic (p200300EC2F1D5B005CBA888EC129B071.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:5b00:5cba:888e:c129:b071])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 904281EC027B;
        Sat, 21 Mar 2020 10:39:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584783546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1LXHYcqyyUW7TLupYbhXwRTRYkd7p90VEn7YEGvIx5g=;
        b=OrXfoR6ByOyIheIBtbxpHAWJCBtmVQhW5YdDzkeavlJYYT6hlzQeLCJ8r5Kv/hufPlHTqv
        ibKE4eUmcIKGF6P/dDJG0ibqndrGnn1f8P0NowVK3VRmKb5piONSA8G4rY2AJWUxxMghcq
        93oBjXU6MJScAgteQLEU6tGcgiGOryU=
Date:   Sat, 21 Mar 2020 10:39:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Wei Huang <wei.huang2@amd.com>
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        yazen.ghannam@amd.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, linux-edac@vger.kernel.org, x86@kernel.org,
        smita.koralahallichannabasappa@amd.com
Subject: Re: [PATCH V2 1/1] x86/mce/amd: Add PPIN support for AMD MCE
Message-ID: <20200321093850.GA17494@zn.tnic>
References: <20200320194305.3532606-1-wei.huang2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200320194305.3532606-1-wei.huang2@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 20, 2020 at 02:43:05PM -0500, Wei Huang wrote:
> Newer AMD CPUs support a feature called protected processor identification
> number (PPIN). This feature can be detected via CPUID_Fn80000008_EBX[23].
> However CPUID alone is not enough to read the processor serial number.
> MSR_AMD_PPIN_CTL also needs to be configured properly. If for any reason
> X86_FEATURE_AMD_PPIN[PPIN_EN] can not be turned on, such as disabled in
> BIOS, we have to clear the CPU capability bit of X86_FEATURE_AMD_PPIN.
> 
> When the X86_FEATURE_AMD_PPIN capability is available, MCE can read the
> serial number to keep track the source of MCE errors.
> 
> Co-developed-by: Smita Koralahalli Channabasappa <smita.koralahallichannabasappa@amd.com>
> Signed-off-by: Smita Koralahalli Channabasappa <smita.koralahallichannabasappa@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Acked-by: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-edac <linux-edac@vger.kernel.org>
> Cc: x86-ml <x86@kernel.org>
> ---
>  arch/x86/include/asm/cpufeatures.h |  1 +
>  arch/x86/kernel/cpu/amd.c          | 26 ++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/mce/core.c     |  2 ++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index f3327cb56edf..4b263ffb793b 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -299,6 +299,7 @@
>  #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
>  #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
>  #define X86_FEATURE_AMD_STIBP_ALWAYS_ON	(13*32+17) /* "" Single Thread Indirect Branch Predictors always-on preferred */
> +#define X86_FEATURE_AMD_PPIN		(13*32+23) /* Protected Processor Inventory Number */
>  #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 1f875fbe1384..9176db4be69b 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -394,6 +394,31 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
>  	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
>  }
>  
> +static void amd_detect_ppin(struct cpuinfo_x86 *c)
> +{
> +	unsigned long long val;
> +
> +	if (cpu_has(c, X86_FEATURE_AMD_PPIN)) {

Flip check:

	if (!cpu_has...
		return;

> +		/* Turn off now until MSR is properly configured */
> +		clear_cpu_cap(c, X86_FEATURE_AMD_PPIN);

What for? You can do the final decision in the end, once, instead of
toggling that bit here.

> +
> +		if (rdmsrl_safe(MSR_AMD_PPIN_CTL, &val))
> +			return;
> +
> +		if ((val & 3UL) == 1UL)
> +			return;
> +
> +		if (!(val & 2UL)) {
> +			wrmsrl_safe(MSR_AMD_PPIN_CTL,  val | 2UL);
> +			rdmsrl_safe(MSR_AMD_PPIN_CTL, &val);
> +		}

Those need comments what they do, like in the Intel variant.

> +
> +		/* MSR_AMD_PPIN_CTL[PPIN_EN] bit is 1, turn feature back on */
> +		if (val & 2UL)
> +			set_cpu_cap(c, X86_FEATURE_AMD_PPIN);

No, keep the feature bit set and clear it only when you determine so
instead of clearing and setting again.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
