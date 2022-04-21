Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977CE509BB1
	for <lists+linux-edac@lfdr.de>; Thu, 21 Apr 2022 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387195AbiDUJDk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Thu, 21 Apr 2022 05:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387204AbiDUJDh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 21 Apr 2022 05:03:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E762B222A4
        for <linux-edac@vger.kernel.org>; Thu, 21 Apr 2022 02:00:38 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1nhSfj-0003ew-9G; Thu, 21 Apr 2022 11:00:19 +0200
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1nhSfh-0005Jj-OZ; Thu, 21 Apr 2022 11:00:17 +0200
Message-ID: <3f092daad178f60e021784d3e398288e15fda4b6.camel@pengutronix.de>
Subject: Re: [PATCH] edac: Make use of the helper function
 devm_platform_ioremap_resource()
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     cgel.zte@gmail.com, bp@alien8.de, mchehab@kernel.org
Cc:     tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Date:   Thu, 21 Apr 2022 11:00:17 +0200
In-Reply-To: <20220421084621.2615517-1-lv.ruyi@zte.com.cn>
References: <20220421084621.2615517-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.0 (by Flathub.org)) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 2022-04-21 at 08:46 +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> Use the devm_platform_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.Make the
> code simpler without functional changes.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Reviewed-by: Jan Luebbe <jlu@pengutronix.de>

Thanks,
Jan

> ---
>  drivers/edac/armada_xp_edac.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
> index b1f46a974b9e..038abbb83f4b 100644
> --- a/drivers/edac/armada_xp_edac.c
> +++ b/drivers/edac/armada_xp_edac.c
> @@ -286,17 +286,10 @@ static int axp_mc_probe(struct platform_device *pdev)
>  	struct edac_mc_layer layers[1];
>  	const struct of_device_id *id;
>  	struct mem_ctl_info *mci;
> -	struct resource *r;
>  	void __iomem *base;
>  	uint32_t config;
>  
> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!r) {
> -		dev_err(&pdev->dev, "Unable to get mem resource\n");
> -		return -ENODEV;
> -	}
> -
> -	base = devm_ioremap_resource(&pdev->dev, r);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base)) {
>  		dev_err(&pdev->dev, "Unable to map regs\n");
>  		return PTR_ERR(base);
> @@ -516,15 +509,8 @@ static int aurora_l2_probe(struct platform_device *pdev)
>  	const struct of_device_id *id;
>  	uint32_t l2x0_aux_ctrl;
>  	void __iomem *base;
> -	struct resource *r;
> -
> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!r) {
> -		dev_err(&pdev->dev, "Unable to get mem resource\n");
> -		return -ENODEV;
> -	}
>  
> -	base = devm_ioremap_resource(&pdev->dev, r);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base)) {
>  		dev_err(&pdev->dev, "Unable to map regs\n");
>  		return PTR_ERR(base);

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
