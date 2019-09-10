Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D84BAEAAA
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2019 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404855AbfIJMhE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Sep 2019 08:37:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39350 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404281AbfIJMhE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Sep 2019 08:37:04 -0400
Received: from zn.tnic (p200300EC2F0ABE00B4DC6059A6D53D5D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:be00:b4dc:6059:a6d5:3d5d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D5E731EC09F7;
        Tue, 10 Sep 2019 14:37:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568119023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iRKPqdcLM+kIMKQijSuNX/Hkh1U20nQQOR1J17cSy3o=;
        b=fIIKNGJ1id/7q2ZxU9h9Q2i1Be7Ply8kVNK7bzSWUuq0YJSynP+6Em41TvF/fBf1/kUv/p
        lT2WQBuZpSVnJi5+NbHo8uUn61BuYtDMQnp9DsgXsrym1+bdLCblJRmgf19HdAqliQWvji
        0agAQ+vWhqJu7f8YegZ35lX1Dhrq9Rc=
Date:   Tue, 10 Sep 2019 14:36:57 +0200
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
Subject: Re: [PATCH v2 4/4] x86/mce: Add Zhaoxin LMCE support
Message-ID: <20190910123657.GE23931@zn.tnic>
References: <5f4f8dee1fb24d38aa0ee136c5e98c72@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f4f8dee1fb24d38aa0ee136c5e98c72@zhaoxin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 10, 2019 at 08:20:07AM +0000, Tony W Wang-oc wrote:
> Zhaoxin newer CPUs support LMCE that compatible with Intel's
> "Machine-Check Architecture", so add support for Zhaoxin LMCE
> in mce/core.c.
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
> v1->v2:
>  - Fix redefinition of "mce_zhaoxin_feature_clear"
> 
>  arch/x86/include/asm/mce.h     |  2 ++
>  arch/x86/kernel/cpu/mce/core.c | 25 +++++++++++++++++++++++--
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 0986a11..01840ec 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -352,8 +352,10 @@ static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_am
>  
>  #ifdef CONFIG_CPU_SUP_ZHAOXIN
>  void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c);
> +void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c);
>  #else
>  static inline void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c) { }
> +static inline void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c) { }
>  #endif
>  
>  #endif /* _ASM_X86_MCE_H */
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 8a36833..595d3af7ac 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1129,6 +1129,17 @@ static bool __mc_check_crashing_cpu(int cpu)
>  		u64 mcgstatus;
>  
>  		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
> +
> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
> +			if (mcgstatus & MCG_STATUS_LMCES) {
> +				return false;
> +			} else {
> +				if (mcgstatus & MCG_STATUS_RIPV)
> +					mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
> +				return true;
> +			}
> +		}

Simplify:

                if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
                        if (mcgstatus & MCG_STATUS_LMCES)
                                return false;
		}

		<--- Now here, on your CPUs which don't set MCG_STATUS_LMCES,
it will fallback to clearing the status register. I.e., what you do in the else
clause.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
