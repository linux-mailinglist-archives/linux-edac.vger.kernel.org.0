Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 302B4AE986
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2019 13:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfIJLvX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Sep 2019 07:51:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfIJLvX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Sep 2019 07:51:23 -0400
Received: from zn.tnic (p200300EC2F0ABE00B4DC6059A6D53D5D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:be00:b4dc:6059:a6d5:3d5d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DEB3D1EC09F7;
        Tue, 10 Sep 2019 13:51:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568116282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OF2GNeo9EcoV7r2cxiD5XuZ5iJsWKvLEg2fxOrk40c8=;
        b=fLz3HvLx3ynrT+1I5v54lpWSEP0T5DZtDyTIyhmmXWLKHuL1r6rIfCW/9jCtoY3MzqyKYy
        hSkVCejAFaityap4Vi2JjYj5R4mVLRnlmF+WdQ7c7ec0iayRvWnFggfJDZoijnK/8mVzOM
        pIDycg6TvNudv251RJWFzwSVD21fWhw=
Date:   Tue, 10 Sep 2019 13:51:16 +0200
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
Subject: Re: [PATCH v2 1/4] x86/mce: Add Zhaoxin MCE support
Message-ID: <20190910115116.GD23931@zn.tnic>
References: <d2660f92baf04d1f9aef5fedc39d7360@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2660f92baf04d1f9aef5fedc39d7360@zhaoxin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 10, 2019 at 08:19:08AM +0000, Tony W Wang-oc wrote:
> All Zhaoxin newer CPUs support MCE that compatible with Intel's
> "Machine-Check Architecture", so add support for Zhaoxin MCE in
> mce/core.c.
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 743370e..3f878f6 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -488,8 +488,9 @@ int mce_usable_address(struct mce *m)
>  	if (!(m->status & MCI_STATUS_ADDRV))
>  		return 0;
>  
> -	/* Checks after this one are Intel-specific: */
> -	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> +	/* Checks after this one are Intel/Zhaoxin-specific: */
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
> +	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
>  		return 1;
>  
>  	if (!(m->status & MCI_STATUS_MISCV))
> @@ -510,7 +511,8 @@ bool mce_is_memory_error(struct mce *m)
>  	if (m->cpuvendor == X86_VENDOR_AMD ||
>  	    m->cpuvendor == X86_VENDOR_HYGON) {
>  		return amd_mce_is_memory_error(m);
> -	} else if (m->cpuvendor == X86_VENDOR_INTEL) {
> +	} else if (m->cpuvendor == X86_VENDOR_INTEL ||
> +		   m->cpuvendor == X86_VENDOR_ZHAOXIN) {
>  		/*
>  		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
>  		 *

Make that a switch-case for better readability pls.

> @@ -1697,6 +1699,21 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
>  		if (c->x86 == 6 && c->x86_model == 45)
>  			quirk_no_way_out = quirk_sandybridge_ifu;
>  	}
> +
> +	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
> +		/*
> +		 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
> +		 * synchronization with a one second timeout.
> +		 */
> +		if ((c->x86 == 6 && c->x86_model == 0x19 &&
> +			(c->x86_stepping > 3 && c->x86_stepping < 8)) ||
> +		    (c->x86 == 6 && c->x86_model == 0x1f) ||
> +		     c->x86 > 6) {

Can this be simplified into maybe something like this:

	if (c->x86 > 6 || (c->x86_model == 0x19 || c->x86_model == 0x1f))

this is, of course, assuming that Zhaoxin doesn't do family < 6 and that
the other steppings for model 0x19 don't matter because they don't exist
or so...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
