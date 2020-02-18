Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEA2162A25
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2020 17:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgBRQN1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Feb 2020 11:13:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49904 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgBRQN1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 18 Feb 2020 11:13:27 -0500
Received: from zn.tnic (p200300EC2F0C1F0014C3F76BBACA8B76.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1f00:14c3:f76b:baca:8b76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CA8C1EC0CE8;
        Tue, 18 Feb 2020 17:13:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582042404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gK0g9aNgXw+INNWEyqtkjvbY52B+btC+rjGUIGJd4h0=;
        b=L0pplXre5y5jDvR+LkAlVpEaxzIYoi/nH9H01hGTTnLEYvaVrc472Bygb+98Ql0XwwPjHD
        q6uyS8RAzM0S030u/0+q1EWmWD2jpLxHCyy+1DGpwOa8wq/fTcLTvPOS3RKD9ZYgNZnee5
        56GISZiImCW06j2JRcZOgF6bRU8jXCU=
Date:   Tue, 18 Feb 2020 17:13:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Krupp <centos@akr.yagii.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] x86/mce: Do not log spurious corrected mce errors
Message-ID: <20200218161319.GG14449@zn.tnic>
References: <20200217130659.15895-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200217130659.15895-1-prarit@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 17, 2020 at 08:06:59AM -0500, Prarit Bhargava wrote:
> A user has reported that they are seeing spurious corrected errors on
> their hardware.
> 
> Intel Errata HSD131, HSM142, HSW131, and BDM48 report that
> "spurious corrected errors may be logged in the IA32_MC0_STATUS register
> with the valid field (bit 63) set, the uncorrected error field (bit 61)
> not set, a Model Specific Error Code (bits [31:16]) of 0x000F, and
> an MCA Error Code (bits [15:0]) of 0x0005."
> 
> Block these spurious errors from the console and logs.
> 
> Links to Intel Specification updates:
> HSD131: https://www.intel.com/content/www/us/en/products/docs/processors/core/4th-gen-core-family-desktop-specification-update.html
> HSM142: https://www.intel.com/content/www/us/en/products/docs/processors/core/4th-gen-core-family-mobile-specification-update.html
> HSW131: https://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200v3-spec-update.html
> BDM48: https://www.intel.com/content/www/us/en/products/docs/processors/core/5th-gen-core-family-spec-update.html

My previous review comment still holds:

Those links tend to get stale with time. If you really want to refer to
the PDFs, add a new bugzilla entry on https://bugzilla.kernel.org/, add
them there as an attachment and add the link to the entry to the commit
message.

> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Co-developed-by: Alexander Krupp <centos@akr.yagii.de>

WARNING: Co-developed-by: must be immediately followed by Signed-off-by:
#36:

See Documentation/process/submitting-patches.rst for more detail.

> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-edac@vger.kernel.org
> ---
>  arch/x86/kernel/cpu/mce/core.c     |  2 ++
>  arch/x86/kernel/cpu/mce/intel.c    | 17 +++++++++++++++++
>  arch/x86/kernel/cpu/mce/internal.h |  1 +
>  3 files changed, 20 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 2c4f949611e4..fe3983d551cc 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1877,6 +1877,8 @@ bool filter_mce(struct mce *m)
>  {
>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>  		return amd_filter_mce(m);
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		return intel_filter_mce(m);
>  
>  	return false;
>  }
> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index 5627b1091b85..989148e6746c 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -520,3 +520,20 @@ void mce_intel_feature_clear(struct cpuinfo_x86 *c)
>  {
>  	intel_clear_lmce();
>  }
> +
> +bool intel_filter_mce(struct mce *m)
> +{
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
> +
> +	/* MCE errata HSD131, HSM142, HSW131, BDM48, and HSM142 */
> +	if ((c->x86 == 6) &&
> +	    ((c->x86_model == INTEL_FAM6_HASWELL) ||
> +	     (c->x86_model == INTEL_FAM6_HASWELL_L) ||
> +	     (c->x86_model == INTEL_FAM6_BROADWELL) ||
> +	     (c->x86_model == INTEL_FAM6_HASWELL_G)) &&
> +	    (m->bank == 0) &&
> +	    ((m->status & 0xa0000000ffffffff) == 0x80000000000f0005))
> +		return true;
> +
> +	return false;
> +}
> diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
> index b785c0d0b590..821faba5b05d 100644
> --- a/arch/x86/kernel/cpu/mce/internal.h
> +++ b/arch/x86/kernel/cpu/mce/internal.h
> @@ -175,5 +175,6 @@ extern bool amd_filter_mce(struct mce *m);
>  #else
>  static inline bool amd_filter_mce(struct mce *m)			{ return false; };
>  #endif
> +extern bool intel_filter_mce(struct mce *m);

It doesn't even build:

ld: arch/x86/kernel/cpu/mce/core.o: in function `filter_mce':
/home/boris/kernel/linux/arch/x86/kernel/cpu/mce/core.c:1881: undefined reference to `intel_filter_mce'
make: *** [Makefile:1077: vmlinux] Error 1

Hint: do it like it is done for amd_filter_mce() but in the respective
#ifdef CONFIG_X86_MCE_INTEL place.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
