Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3D82E76F3
	for <lists+linux-edac@lfdr.de>; Wed, 30 Dec 2020 09:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgL3IQX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Dec 2020 03:16:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34614 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgL3IQX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 30 Dec 2020 03:16:23 -0500
Received: from zn.tnic (p200300ec2f0ae9002293c057202a1917.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e900:2293:c057:202a:1917])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4EB3F1EC0513;
        Wed, 30 Dec 2020 09:15:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609316142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uI6jUEBXx3dgS1ABqv+Yi4YcXAMzRepG8Y+o4rruDJ0=;
        b=iGdiAhSOs8EhM5J8a74dhjFcHDgBIMyUQh1aAWWkKqdU2TjIurH5aLRmPiAq8W0LFEojQp
        R/GwCTEq4DT0lkq0Zk99GwYfUnDiB9aNhJ/hN0ZjK4qGz4bL/R9eQWMOzD2kSvNjIMoBZg
        hZZrmCb78C5xAvPd9W3ChjBdvH9S/qs=
Date:   Wed, 30 Dec 2020 09:15:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] edac: ppc4xx_edac: convert comma to semicolon
Message-ID: <20201230081539.GD22022@zn.tnic>
References: <20201216131846.14937-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201216131846.14937-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 16, 2020 at 09:18:46PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/edac/ppc4xx_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
> index 677095769182..6793f6d799e7 100644
> --- a/drivers/edac/ppc4xx_edac.c
> +++ b/drivers/edac/ppc4xx_edac.c
> @@ -1058,7 +1058,7 @@ static int ppc4xx_edac_mc_init(struct mem_ctl_info *mci,
>  	/* Initialize strings */
>  
>  	mci->mod_name		= PPC4XX_EDAC_MODULE_NAME;
> -	mci->ctl_name		= ppc4xx_edac_match->compatible,
> +	mci->ctl_name		= ppc4xx_edac_match->compatible;
>  	mci->dev_name		= np->full_name;
>  
>  	/* Initialize callbacks */
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
