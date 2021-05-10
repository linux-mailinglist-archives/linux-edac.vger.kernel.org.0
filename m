Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41879377E53
	for <lists+linux-edac@lfdr.de>; Mon, 10 May 2021 10:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhEJIhr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 May 2021 04:37:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52006 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhEJIhr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 10 May 2021 04:37:47 -0400
Received: from zn.tnic (p200300ec2f066d00c3c3b9d774715f25.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:6d00:c3c3:b9d7:7471:5f25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 487AB1EC04A6;
        Mon, 10 May 2021 10:36:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620635801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lKWUtHrdn8WhQE7UfCe0YXghCkTkcq/bmDYMTWW7yow=;
        b=EkAkUyXv5bYLO2N6rxZW6U9gU3fa1hBBhFNRSiZGNr9EoncLWXsLH3U55unvnjMxzwfMYo
        dIhSLhKbw4UoVHoczYaMrasflOjVBWjrctxT7lht/csnFpswYDmmfWWrxSeLwxaDe6CisT
        2M3vwDeN8wOnMmlrEXf+Wwk2vaWoWHs=
Date:   Mon, 10 May 2021 10:36:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     rric@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, s.temerkhanov@gmail.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] EDAC/thunderx: Fix an error message
Message-ID: <YJjwlTI30S9PfD4I@zn.tnic>
References: <0c046ef5cfb367a3f707ef4270e21a2bcbf44952.1620280098.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c046ef5cfb367a3f707ef4270e21a2bcbf44952.1620280098.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 06, 2021 at 07:49:34AM +0200, Christophe JAILLET wrote:
> 'ret' is known to be 0 here.
> No error code is available, so just remove it from the error message.
> 
> Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/edac/thunderx_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
> index 0eb5eb97fd74..f13674081cb6 100644
> --- a/drivers/edac/thunderx_edac.c
> +++ b/drivers/edac/thunderx_edac.c
> @@ -1368,7 +1368,7 @@ static int thunderx_ocx_probe(struct pci_dev *pdev,
>  					      name, 1, "CCPI", 1,
>  					      0, NULL, 0, idx);
>  	if (!edac_dev) {
> -		dev_err(&pdev->dev, "Cannot allocate EDAC device: %d\n", ret);
> +		dev_err(&pdev->dev, "Cannot allocate EDAC device\n");
>  		return -ENOMEM;
>  	}
>  	ocx = edac_dev->pvt_info;
> @@ -1380,7 +1380,7 @@ static int thunderx_ocx_probe(struct pci_dev *pdev,
>  
>  	ocx->regs = pcim_iomap_table(pdev)[0];
>  	if (!ocx->regs) {
> -		dev_err(&pdev->dev, "Cannot map PCI resources: %d\n", ret);
> +		dev_err(&pdev->dev, "Cannot map PCI resources\n");
>  		ret = -ENODEV;
>  		goto err_free;
>  	}
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
