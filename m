Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030CCAEAB0
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2019 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391051AbfIJMhY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Sep 2019 08:37:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39428 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390519AbfIJMhX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Sep 2019 08:37:23 -0400
Received: from zn.tnic (p200300EC2F0ABE00B4DC6059A6D53D5D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:be00:b4dc:6059:a6d5:3d5d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B5301EC0688;
        Tue, 10 Sep 2019 14:37:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568119042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UB+ywCBDZzQcqqbwU/lk/AhTB7NUtu73VfJbnaCyE3E=;
        b=e7Mg6iEFBimm+vdm/7V/P049hL6H3/rSiLKoPq9saJGcTww9SvQ8ZhRu6wKuC2YBxi8fDK
        H9d6iF3/qFY//Xf4iSWgsSNatIy8J9KUFJBrFFDvFHDq6k0tLiVvedR6F3L/ZfqFMADOUi
        fZpQBJmXEzJLsYOvTPAiSpLij5ZKeVg=
Date:   Tue, 10 Sep 2019 14:37:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: Re: [PATCH v2 3/4] x86/mce: Add Zhaoxin CMCI support
Message-ID: <20190910123720.GF23931@zn.tnic>
References: <e8d11f3ce0f64a9f9a4cefcc8059747b@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e8d11f3ce0f64a9f9a4cefcc8059747b@zhaoxin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 10, 2019 at 08:19:44AM +0000, Tony W Wang-oc wrote:
> @@ -1777,6 +1777,29 @@ static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
>  	}
>  }
>
> +#ifdef CONFIG_CPU_SUP_ZHAOXIN

What's that ifdeffery for since you have it in the header already?

> +void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c)
> +{
> +	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
> +
> +	/*
> +	 * These CPUs bank8 SVAD error may be triggered unexpected when

"These CPUs bank8 SVAD"??

> +	 * bringup virtual machine. it is not hardware bug. Always disable
> +	 * bank8 SVAD error by default.
> +	 */

That comment is incomprehensible. Please rewrite.

> +	if ((c->x86 == 6 && c->x86_model == 0x19 &&
> +		(c->x86_stepping > 3 && c->x86_stepping < 8)) ||
> +	    (c->x86 == 6 && c->x86_model == 0x1f) ||
> +	    (c->x86 == 7 && c->x86_model == 0x1b)) {

As before: potential to simplify the test here?

> +		if (this_cpu_read(mce_num_banks) > 8)
> +			mce_banks[8].ctl = 0;
> +	}
> +
> +	intel_init_cmci();
> +	mce_adjust_timer = cmci_intel_adjust_timer;
> +}
> +#endif
> +
>  static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
>  {
>  	switch (c->x86_vendor) {
> @@ -1798,6 +1821,10 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
>  		mce_centaur_feature_init(c);
>  		break;
>  
> +	case X86_VENDOR_ZHAOXIN:
> +		mce_zhaoxin_feature_init(c);
> +		break;
> +
>  	default:
>  		break;
>  	}
> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index eee4b12..b49cba7 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -85,7 +85,8 @@ static int cmci_supported(int *banks)
>  	 * initialization is vendor keyed and this
>  	 * makes sure none of the backdoors are entered otherwise.
>  	 */

That comment above needs fixing too.

> -	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
> +	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
>  		return 0;

<---- newline here.

>  	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
>  		return 0;
> -- 
> 2.7.4

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
