Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701ED4450F0
	for <lists+linux-edac@lfdr.de>; Thu,  4 Nov 2021 10:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhKDJQB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Nov 2021 05:16:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55704 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230344AbhKDJQA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 4 Nov 2021 05:16:00 -0400
Received: from zn.tnic (p200300ec2f0f2b00be75243ef2b4b032.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:be75:243e:f2b4:b032])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E10741EC03AD;
        Thu,  4 Nov 2021 10:13:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636017202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=e+bRCE0bEiDfnPvVhMBEe7oNINpfGFQpszyM3GzJe2k=;
        b=MJIstnRzAtZAnNOaiM1WQgZPBRsd8uHnYzSjr8wVgkp1rOxXYsCQ2PJy1ycbJz6cDaw+Gn
        CWveqcASyuQZYj0C8eh9gSnaGkU4LSNLIm130e/Zj1EE5lOXRPzEE9DrGcDrBiuE1IZ3x1
        cMaaQQwIuq+lPOn7Grm+ij4kvTof0zQ=
Date:   Thu, 4 Nov 2021 10:13:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhaolong Zhang <zhangzl2013@126.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: correct cpu_missing reporting in mce_timed_out
Message-ID: <YYOkKm8UmmIxSdXF@zn.tnic>
References: <20211104074431.1091525-1-zhangzl2013@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211104074431.1091525-1-zhangzl2013@126.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 04, 2021 at 03:44:31PM +0800, Zhaolong Zhang wrote:
> set cpu_missing before mce_panic() so that it prints correct msg.
> 
> Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 50a3e455cded..ccefe131ab55 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -903,13 +903,13 @@ static int mce_timed_out(u64 *t, const char *msg)
>  	if (!mca_cfg.monarch_timeout)
>  		goto out;
>  	if ((s64)*t < SPINUNIT) {
> +		cpu_missing = 1;
>  		if (mca_cfg.tolerant <= 1) {
>  			if (cpumask_and(&mce_missing_cpus, cpu_online_mask, &mce_missing_cpus))
>  				pr_emerg("CPUs not responding to MCE broadcast (may include false positives): %*pbl\n",
>  					 cpumask_pr_args(&mce_missing_cpus));
>  			mce_panic(msg, NULL, NULL);
>  		}
> -		cpu_missing = 1;
>  		return 1;
>  	}
>  	*t -= SPINUNIT;
> -- 

Frankly, we might just as well kill that cpu_missing thing because we
already say that some CPUs are not responding.

And that "Some CPUs didn't answer in synchronization" is not really
telling me a whole lot.

Tony, do you see any real need to keep it?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
