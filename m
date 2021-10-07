Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2248A4259C4
	for <lists+linux-edac@lfdr.de>; Thu,  7 Oct 2021 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbhJGRuy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Oct 2021 13:50:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48728 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242884AbhJGRuy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Oct 2021 13:50:54 -0400
Received: from zn.tnic (p200300ec2f1265004099ae2673030416.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:6500:4099:ae26:7303:416])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12F141EC04B9;
        Thu,  7 Oct 2021 19:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633628939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hygKBk5L/FUKOt+z5yZ44i+gNTXn0Uj/GbXvJEigZgM=;
        b=Cdy0vYl4zZpwlxXqq9EI0z5cTXmKsCiFbakeli6+D3A8OZ1x4Q54gffxpHwp2z39G9scop
        p5XYMMIXTeW7JA+ZHMyiDAHxKqE4PzfILL8G4vhZInnkf2E1IOkJm023s3ARNFeCGmnkR3
        6OQ+XVIIKXQeHBc1NOrnWa/aJgNF3hA=
Date:   Thu, 7 Oct 2021 19:48:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     kristo@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/ti: Remove redundant error messages
Message-ID: <YV8zBqHzL7lcbQUQ@zn.tnic>
References: <20210811112626.27848-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210811112626.27848-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 11, 2021 at 07:26:26PM +0800, Tang Bin wrote:
> In the function ti_edac_probe, devm_ioremap_resource() and
> platform_get_irq() have already contains error message, so
> remove the redundant error messages.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/edac/ti_edac.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
> index 169f96e51..6971ded59 100644
> --- a/drivers/edac/ti_edac.c
> +++ b/drivers/edac/ti_edac.c
> @@ -245,11 +245,8 @@ static int ti_edac_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	reg = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(reg)) {
> -		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> -			    "EMIF controller regs not defined\n");
> +	if (IS_ERR(reg))
>  		return PTR_ERR(reg);
> -	}
>  
>  	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
>  	layers[0].size = 1;
> @@ -281,8 +278,6 @@ static int ti_edac_probe(struct platform_device *pdev)
>  	error_irq = platform_get_irq(pdev, 0);
>  	if (error_irq < 0) {
>  		ret = error_irq;
> -		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> -			    "EMIF irq number not defined.\n");
>  		goto err;
>  	}
>  
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
