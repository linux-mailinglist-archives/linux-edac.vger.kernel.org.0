Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE1BBAEAB2
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2019 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390519AbfIJMhp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Sep 2019 08:37:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39492 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390009AbfIJMhp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Sep 2019 08:37:45 -0400
Received: from zn.tnic (p200300EC2F0ABE00B4DC6059A6D53D5D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:be00:b4dc:6059:a6d5:3d5d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A39811EC0688;
        Tue, 10 Sep 2019 14:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568119063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5FBeehAo9pc5CgZTj0+q999A32D9UmnfBNu8W+HSco4=;
        b=TpbVM2u4W//8pc1HRoJHGnPgZ0FyfRMYT+4ukSUd143i4tw7P37/VSaZlSpuaMsPT0GIFc
        t24qlw22B1TvyYHvxphd7y/ZXPFmianN2IKfDrYpLyQ279mwLwz2F6CfwBb0NJu9L3LYCO
        dCWA2hVXsMcieoyma/Qg6lwdBT2TGt8=
Date:   Tue, 10 Sep 2019 14:37:42 +0200
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
Subject: Re: [PATCH v2 2/4] x86/mce: Make 4 functions non-static
Message-ID: <20190910123741.GG23931@zn.tnic>
References: <5b5bf41a26674a1c9d67cd7b3822a304@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b5bf41a26674a1c9d67cd7b3822a304@zhaoxin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 10, 2019 at 08:19:20AM +0000, Tony W Wang-oc wrote:
> These functions are declared static and cannot be used in others
> .c source file. this commit removes the static attribute and adds
> the declaration to the header for these functions.
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  arch/x86/kernel/cpu/mce/intel.c    | 8 ++++----
>  arch/x86/kernel/cpu/mce/internal.h | 8 ++++++++
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index 88cd959..eee4b12 100644
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
> @@ -467,7 +467,7 @@ static void intel_clear_lmce(void)
>  	wrmsrl(MSR_IA32_MCG_EXT_CTL, val);
>  }
>  
> -static void intel_ppin_init(struct cpuinfo_x86 *c)
> +void intel_ppin_init(struct cpuinfo_x86 *c)

That one doesn't need to get exported.

This can easily be missed because you're exporting them in one patch and
using them in another. Do the exports in the same patch where you use
them for the first time.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
