Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0097B181EDF
	for <lists+linux-edac@lfdr.de>; Wed, 11 Mar 2020 18:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgCKROu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Mar 2020 13:14:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49428 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729675AbgCKROu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 11 Mar 2020 13:14:50 -0400
Received: from zn.tnic (p200300EC2F12AA00280D644233BA3664.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:aa00:280d:6442:33ba:3664])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20F4A1EC0304;
        Wed, 11 Mar 2020 18:14:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583946888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pOIR3Q7MS+lWIofLjdYvowmUr10Fu8TbBWzKCrl1rVA=;
        b=ezMmFg+NM6ZkBHnYwJtIeF9dDV3RY4eUQh+O44OctmClapZxbkZKHf0OC5ckcMzcFfCUZW
        pS99lHQnfKNvGaeMIC4isPhORCQUJoVcfKePh24IeuuoAs1Qv68UtDCnfGhT3FMv3cUk+z
        PvFJbrFKQql3oxi/CxWrApOEB1xP1zs=
Date:   Wed, 11 Mar 2020 18:14:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Joe Perches <joe@perches.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 022/491] X86 MCE INFRASTRUCTURE: Use fallthrough;
Message-ID: <20200311171450.GH3470@zn.tnic>
References: <cover.1583896344.git.joe@perches.com>
 <1dbc36979b08577a2d589b7fe572f83aadf7b5ef.1583896349.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1dbc36979b08577a2d589b7fe572f83aadf7b5ef.1583896349.git.joe@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Mar 10, 2020 at 09:51:36PM -0700, Joe Perches wrote:

> Subject: Re: [PATCH -next 022/491] X86 MCE INFRASTRUCTURE: Use fallthrough;

Make that subject prefix "x86/mce: ..."

> Convert the various uses of fallthrough comments to fallthrough;
> 
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/x86/kernel/cpu/mce/inject.c | 2 +-
>  arch/x86/kernel/cpu/mce/intel.c  | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
> index 3413b41..b5e3bab 100644
> --- a/arch/x86/kernel/cpu/mce/inject.c
> +++ b/arch/x86/kernel/cpu/mce/inject.c
> @@ -199,7 +199,7 @@ static int raise_local(void)
>  			 * calling irq_enter, but the necessary
>  			 * machinery isn't exported currently.
>  			 */
> -			/*FALL THROUGH*/
> +			fallthrough;
>  		case MCJ_CTX_PROCESS:
>  			raise_exception(m, NULL);
>  			break;
> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index d8f9230..5be647 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -192,9 +192,7 @@ unsigned long cmci_intel_adjust_timer(unsigned long interval)
>  		__this_cpu_write(cmci_storm_state, CMCI_STORM_SUBSIDED);
>  		if (!atomic_sub_return(1, &cmci_storm_on_cpus))
>  			pr_notice("CMCI storm subsided: switching to interrupt mode\n");
> -
> -		/* FALLTHROUGH */
> -
> +		fallthrough;
>  	case CMCI_STORM_SUBSIDED:
>  		/*
>  		 * We wait for all CPUs to go back to SUBSIDED state. When that
> -- 

With that:

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
