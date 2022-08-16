Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56665957FD
	for <lists+linux-edac@lfdr.de>; Tue, 16 Aug 2022 12:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiHPKUR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Aug 2022 06:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiHPKTs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Aug 2022 06:19:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B5CD31C4
        for <linux-edac@vger.kernel.org>; Tue, 16 Aug 2022 01:06:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e15so13816705lfs.0
        for <linux-edac@vger.kernel.org>; Tue, 16 Aug 2022 01:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qACRoIaUIx4q7Fq4+bP1/fvXnrMmd2GKs256tlkcKt4=;
        b=BBO5LjKSiDFTYMhsWb3L99v5jd7KieKgdC3QskfSxYOOyAE7SNmfZ3GKt8U5fijlz0
         UrobL5lUxrdDbTHHX/KYtanOIdwds87TbKepBUBpVz5HgeANmaBUry+m83dWcePHcQ/W
         NeLyrbRPsqer3RC6HdC8/tti28uRzSYbtQQr5Qjw3mYAaujMqi8CtttKACVyLftkrpT0
         /Jz59nJzkmCkuZ/YQQ126zpBfmWm7/pexFTT/APo1MqLcF2jY4vHas5fgOtWXdGa8xS6
         yKcSy6pdp6TWQFpHW9hYEPXtUSeOoK/Q5aNJJVLlVEAOA4tP1tCvdgTWuJ7OK78K7S9L
         P9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qACRoIaUIx4q7Fq4+bP1/fvXnrMmd2GKs256tlkcKt4=;
        b=TPmckFlirK38y+QR1O2JiWjQvc1erW2WKCRsbcOgZPENu48SRy57rHfiJ2i4bIPPrO
         kBZCvkZWIb7FGWWqgnlC/r+zXXtV3ZBb9r8hhklxXhc0picB114bmqbHbRW3z2n2SuHG
         uHCxFOg5qCIWIO043GCBqJhJp7Ogfj8T7tbpgKNc9LfSnUwa8oxU41ea3aUZz6yyseC7
         kd/RovtP7GUPZQGW7KmvDBDjOtJLasuj43tP48EuBMwAieBrNkYA3dXhjX9Gpiwt/lhy
         Dmo82aFu0e/cF9Xm8hOiSsooDd5Y8q3MiJmSaFH7ALIqLz/FXANARFOX+C84g1XkjAIG
         cT5w==
X-Gm-Message-State: ACgBeo00yAY9nMmUQJnX7UqYy0vuZH+n5ELm/7phUdEZ7So+cWkKCnMF
        KOLBktw60zRvI7YutyZMbJ+6wg==
X-Google-Smtp-Source: AA6agR4ieUtBeNjjuanFgiNBKumVBvcQFgBFOIrRWccADDgSCX1mhvrhAIa2+vNHgbE9eqtjw/zKFg==
X-Received: by 2002:a05:6512:250b:b0:48b:2c5:fe1e with SMTP id be11-20020a056512250b00b0048b02c5fe1emr7294718lfb.598.1660637176012;
        Tue, 16 Aug 2022 01:06:16 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id f26-20020a2e381a000000b0025e2e70b41fsm1696716lja.71.2022.08.16.01.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 01:06:15 -0700 (PDT)
Message-ID: <e1f1be24-7178-ceae-9038-ec90ffd9a28f@linaro.org>
Date:   Tue, 16 Aug 2022 11:06:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        saikrishna12468@gmail.com, git@amd.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
References: <20220816073203.27314-1-sai.krishna.potthuri@amd.com>
 <20220816073203.27314-3-sai.krishna.potthuri@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220816073203.27314-3-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 16/08/2022 10:32, Sai Krishna Potthuri wrote:
> Add EDAC support for Xilinx ZynqMP OCM Controller, this driver
> reports CE and UE errors based on the interrupts, and also creates ue/ce
> sysfs entries for error injection.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

A bit confusing SoB order, although sometimes rational. Are you sure
about authorship here?

> ---
>  MAINTAINERS                    |   7 +
>  drivers/edac/Kconfig           |   9 +
>  drivers/edac/Makefile          |   1 +
>  drivers/edac/zynqmp_ocm_edac.c | 643 +++++++++++++++++++++++++++++++++
>  4 files changed, 660 insertions(+)
>  create mode 100644 drivers/edac/zynqmp_ocm_edac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index edc96cdb85e8..cd4c6c90bca3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21692,6 +21692,13 @@ F:	Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
>  F:	drivers/dma/xilinx/xilinx_dpdma.c
>  F:	include/dt-bindings/dma/xlnx-zynqmp-dpdma.h
>  
> +XILINX ZYNQMP OCM EDAC DRIVER
> +M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> +M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
> +F:	drivers/edac/zynqmp_ocm_edac.c
> +
>  XILINX ZYNQMP PSGTR PHY DRIVER
>  M:	Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 58ab63642e72..fece60f586af 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -539,4 +539,13 @@ config EDAC_DMC520
>  	  Support for error detection and correction on the
>  	  SoCs with ARM DMC-520 DRAM controller.
>  
> +config EDAC_ZYNQMP_OCM
> +	tristate "Xilinx ZynqMP OCM Controller"
> +	depends on ARCH_ZYNQMP

|| COMPILE_TEST


> +	help
> +	  Support for error de


> +/**
> + * zynqmp_ocm_edac_get_eccstate - Return the controller ecc status
> + * @base:	Pointer to the ddr memory controller base address
> + *
> + * Get the ECC enable/disable status for the controller
> + *
> + * Return: ecc status 0/1.
> + */
> +static bool zynqmp_ocm_edac_get_eccstate(void __iomem *base)
> +{
> +	return readl(base + ECC_CTRL_OFST) & OCM_ECC_ENABLE_MASK;
> +}
> +
> +static const struct of_device_id zynqmp_ocm_edac_match[] = {
> +	{ .compatible = "xlnx,zynqmp-ocmc-1.0"},
> +	{ /* end of table */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, zynqmp_ocm_edac_match);

This goes to the end. Do not embed static variables in the middle of the
code.


> +
> +/**
> + * zynqmp_set_ocm_edac_sysfs_attributes - create sysfs attributes
> + * @edac_dev:	Pointer to the edac device struct
> + *
> + * Creates sysfs entries for error injection
> + */
> +static void zynqmp_set_ocm_edac_sysfs_attributes(struct edac_device_ctl_info
> +						*edac_dev)
> +{
> +	edac_dev->sysfs_attributes = zynqmp_ocm_edac_sysfs_attributes;
> +}
> +
> +/**
> + * zynqmp_ocm_edac_probe - Check controller and bind driver
> + * @pdev:	Pointer to the platform_device struct
> + *
> + * Probes a specific controller instance for binding with the driver.
> + *
> + * Return: 0 if the controller instance was successfully bound to the
> + * driver; otherwise error code.
> + */

Drop the kerneldoc for probe(). It's obvious and exactly the same
everywhere. You could keep it if you write something different than theh
same message for 1000 other probes.

> +static int zynqmp_ocm_edac_probe(struct platform_device *pdev)
> +{
> +	struct zynqmp_ocm_edac_priv *priv;
> +	struct edac_device_ctl_info *dci;
> +	void __iomem *baseaddr;
> +	struct resource *res;
> +	int irq, ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	baseaddr = devm_ioremap_resource(&pdev->dev, res);

There is a wrapper for these.

> +	if (IS_ERR(baseaddr))
> +		return PTR_ERR(baseaddr);
> +
> +	if (!zynqmp_ocm_edac_get_eccstate(baseaddr)) {
> +		edac_printk(KERN_INFO, EDAC_DEVICE,
> +			    "ECC not enabled - Disabling EDAC driver\n");

How do you disable the driver? What if there are two devices - how does
this disables the driver for second device?

> +		return -ENXIO;
> +	}
> +
> +	dci = edac_device_alloc_ctl_info(sizeof(*priv), ZYNQMP_OCM_EDAC_STRING,
> +					 1, ZYNQMP_OCM_EDAC_STRING, 1, 0, NULL, 0,
> +					 edac_device_alloc_index());
> +	if (!dci) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "Unable to allocate EDAC device\n");

No ENOMEM prints.

> +		return -ENOMEM;
> +	}
> +
> +	priv = dci->pvt_info;
> +	platform_set_drvdata(pdev, dci);
> +	dci->dev = &pdev->dev;
> +	priv->baseaddr = baseaddr;
> +	dci->mod_name = pdev->dev.driver->name;
> +	dci->ctl_name = ZYNQMP_OCM_EDAC_STRING;
> +	dci->dev_name = dev_name(&pdev->dev);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "No irq %d in DT\n", irq);

The same, no need for printks. Core does it.

> +		ret = irq;
> +		goto free_dev_ctl;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq,
> +			       zynqmp_ocm_edac_intr_handler,
> +			       0, dev_name(&pdev->dev), dci);
> +	if (ret) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE, "Failed to request Irq\n");
> +		goto free_dev_ctl;
> +	}
> +
> +	writel(OCM_CEUE_MASK, priv->baseaddr + OCM_IEN_OFST);
> +
> +	zynqmp_set_ocm_edac_sysfs_attributes(dci);
> +	ret = edac_device_add_device(dci);
> +	if (ret)
> +		goto free_dev_ctl;
> +
> +	return 0;
> +
> +free_dev_ctl:
> +	edac_device_free_ctl_info(dci);
> +
> +	return ret;
> +}
> +
> +/**
> + * zynqmp_ocm_edac_remove - Unbind driver from controller
> + * @pdev:	Pointer to the platform_device struct
> + *
> + * Return: Unconditionally 0
> + */

Same comment for kerneldoc.

> +static int zynqmp_ocm_edac_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
> +	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
> +
> +	writel(OCM_CEUE_MASK, priv->baseaddr + OCM_IDS_OFST);
> +	edac_device_del_device(&pdev->dev);
> +	edac_device_free_ctl_info(dci);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver zynqmp_ocm_edac_driver = {
> +	.driver = {
> +		   .name = "zynqmp-ocm-edac",
> +		   .of_match_table = zynqmp_ocm_edac_match,
> +		   },
> +	.probe = zynqmp_ocm_edac_probe,
> +	.remove = zynqmp_ocm_edac_remove,
> +};
> +
> +module_platform_driver(zynqmp_ocm_edac_driver);
> +
> +MODULE_AUTHOR("Advanced Micro Devices, Inc");
> +MODULE_DESCRIPTION("ZynqMP OCM ECC driver");
> +MODULE_LICENSE("GPL");


Best regards,
Krzysztof
