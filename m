Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1B339F2EE
	for <lists+linux-edac@lfdr.de>; Tue,  8 Jun 2021 11:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFHJzk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Jun 2021 05:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhFHJzj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 8 Jun 2021 05:55:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30337C061574;
        Tue,  8 Jun 2021 02:53:47 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bc9005757c3be7e9afbb5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:c900:5757:c3be:7e9a:fbb5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60C0E1EC032C;
        Tue,  8 Jun 2021 11:53:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623146023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sIO4tp9D4s6y/uruWeTeez4givhSC32qFwkGfiSPVXo=;
        b=sSmLg8fmO27pZQXB7ZKC0enN2/bCa4DO+wzxAckghPFrtWAKqDzpf7P6irMrq9MajHeUuG
        M4rw9C8I0ri9Rr0WXgFtRfbLjcIwvkv4Mt7RbSdglTFwIOwxBEuDEIX3FQw3Nc/TcdGghr
        C9TROKIfKsacQogdcANjD2el6ldIzjs=
Date:   Tue, 8 Jun 2021 11:53:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     jlu@pengutronix.de, mchehab@kernel.org, tony.luck@intel.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next,resend] EDAC/armada_xp: Remove redundant dev_err
 call in axp_mc_probe() and aurora_l2_probe()
Message-ID: <YL8+IvruIwjbQDfn@zn.tnic>
References: <20210608084715.1046300-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210608084715.1046300-1-chenxiaosong2@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 08, 2021 at 04:47:15PM +0800, ChenXiaoSong wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
>  drivers/edac/armada_xp_edac.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
> index e3e757513d1b..9661c72e6554 100644
> --- a/drivers/edac/armada_xp_edac.c
> +++ b/drivers/edac/armada_xp_edac.c
> @@ -297,10 +297,8 @@ static int axp_mc_probe(struct platform_device *pdev)
>  	}
>  
>  	base = devm_ioremap_resource(&pdev->dev, r);
> -	if (IS_ERR(base)) {
> -		dev_err(&pdev->dev, "Unable to map regs\n");
> +	if (IS_ERR(base))
>  		return PTR_ERR(base);
> -	}
>  
>  	config = readl(base + SDRAM_CONFIG_REG);
>  	if (!(config & SDRAM_CONFIG_ECC_MASK)) {
> @@ -525,10 +523,8 @@ static int aurora_l2_probe(struct platform_device *pdev)
>  	}
>  
>  	base = devm_ioremap_resource(&pdev->dev, r);
> -	if (IS_ERR(base)) {
> -		dev_err(&pdev->dev, "Unable to map regs\n");
> +	if (IS_ERR(base))
>  		return PTR_ERR(base);
> -	}
>  
>  	l2x0_aux_ctrl = readl(base + L2X0_AUX_CTRL);
>  	if (!(l2x0_aux_ctrl & AURORA_ACR_PARITY_EN))
> --

https://lkml.kernel.org/r/YLT7JOR3fND5Y3K2@zn.tnic

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
