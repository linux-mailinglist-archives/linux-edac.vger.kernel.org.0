Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38A4251CD5
	for <lists+linux-edac@lfdr.de>; Tue, 25 Aug 2020 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgHYQDg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Aug 2020 12:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgHYQDC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Aug 2020 12:03:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0D1C061797
        for <linux-edac@vger.kernel.org>; Tue, 25 Aug 2020 09:02:54 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ep8so1462348pjb.3
        for <linux-edac@vger.kernel.org>; Tue, 25 Aug 2020 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8dg/pzOfoX090vr3MKkHjKruXnSLmOH8ps44bLz/Dy8=;
        b=hXOK3FZKFyQj/sHxEuzwTLPUAfnjY4BAK3nuyhFK3MF88zZxMd+AM8t0VCZQIN0m6G
         eMTZg8PnWcTQzr8VXu7dWK/B74r6Amm0iz8hSl9QMjOjTM26S3fLC/XVdt5Df4f2ieYK
         +C7wqXIJZYyobUZfK4XfTvBUt0g9uhkaYqQcQOrXaG6m3oww8yqsO26jkL250zgfD+Ib
         dGIJ0rVowMRkkbcrIav0O244s0Gc4ORvkNwWW2yLLmQgwtimRx/JdnEwy5baDxz8n84X
         jzsCF5JmhhBBz9N7MXaIGQ9szn9SDO5UDCzqOi8ktSUTFEtmRm5hYXLeeedt+y1dgqm3
         WPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8dg/pzOfoX090vr3MKkHjKruXnSLmOH8ps44bLz/Dy8=;
        b=QjUhseuo67wKX19Da6UodOtGaIKj1TdPh29o0hMd2e3JBZfYlWSnQyP9rPx7o67gHG
         PBi4t4GcIFvlZ3LTUfNaNujmbZ/0fOowKFQu9+ouvJw+kMErTLFQWWL1EzFtJQPZHYPj
         VGLpv0ntV7oRjan8A8TXw1G7gxr6iYvH3Mryl9kuHFExCSc4fI2QzNdHPiPsFb9IB7Up
         EPU9qZRUspRjBXLVNPUzPWuyfdIzPMoOZ6meoG1sIQGk0cpZJxm8l9GtX4Fac+tO0UaP
         z9uXNUdeybEJ+DONbczNQEc+UkKg2louOpbe3ZFbdXqLs1SkZNwAoPI2R3AmEHREmMiJ
         FArA==
X-Gm-Message-State: AOAM532+aP9T8KNS1Hmn2k8vOqaFPdATR9AZa559KAiVB+mWOPcSZc8T
        ZZQKfN3pfJD4rqjmCjQecVWaew==
X-Google-Smtp-Source: ABdhPJw0IKBPCBHyT7FsIFni4cECCusosYELl80aL9fXYDOXbNFYC5Ncy0w6whnQ0XoeA0abk/V0qg==
X-Received: by 2002:a17:90a:9405:: with SMTP id r5mr2240530pjo.74.1598371373730;
        Tue, 25 Aug 2020 09:02:53 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d4sm3078303pju.56.2020.08.25.09.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:02:53 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:02:53 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Aug 2020 08:49:54 PDT (-0700)
Subject:     Re: [PATCH 3/3] edac: sifive: Add EDAC support for Memory Controller in SiFive SoCs
In-Reply-To: <1598357182-4226-4-git-send-email-yash.shah@sifive.com>
CC:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        aou@eecs.berkeley.edu, james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com, yash.shah@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     yash.shah@sifive.com
Message-ID: <mhng-42bbb651-211f-4899-8839-5b6bc8e3db78@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 25 Aug 2020 05:06:22 PDT (-0700), yash.shah@sifive.com wrote:
> Add Memory controller EDAC support in exisiting SiFive platform EDAC
> driver. It registers for notifier events from the SiFive DDR controller
> driver for DDR ECC events.
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  drivers/edac/Kconfig       |   2 +-
>  drivers/edac/sifive_edac.c | 117 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 118 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 7b6ec30..f8b3b53 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -462,7 +462,7 @@ config EDAC_ALTERA_SDMMC
>
>  config EDAC_SIFIVE
>  	bool "Sifive platform EDAC driver"
> -	depends on EDAC=y && SIFIVE_L2
> +	depends on EDAC=y && (SIFIVE_L2 || SIFIVE_DDR)
>  	help
>  	  Support for error detection and correction on the SiFive SoCs.
>
> diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
> index 3a3dcb1..cf032685 100644
> --- a/drivers/edac/sifive_edac.c
> +++ b/drivers/edac/sifive_edac.c
> @@ -11,14 +11,120 @@
>  #include <linux/platform_device.h>
>  #include "edac_module.h"
>  #include <soc/sifive/sifive_l2_cache.h>
> +#include <soc/sifive/sifive_ddr.h>
>
>  #define DRVNAME "sifive_edac"
> +#define SIFIVE_EDAC_MOD_NAME "Sifive ECC Manager"
>
>  struct sifive_edac_priv {
>  	struct notifier_block notifier;
>  	struct edac_device_ctl_info *dci;
>  };
>
> +struct sifive_edac_mc_priv {
> +	struct notifier_block notifier;
> +	struct mem_ctl_info *mci;
> +};
> +
> +/**
> + * EDAC MC error callback
> + *
> + * @event: non-zero if unrecoverable.
> + */
> +static
> +int ecc_mc_err_event(struct notifier_block *this, unsigned long event, void *ptr)
> +{
> +	struct sifive_ddr_priv *priv = ptr;
> +	struct sifive_edac_mc_priv *p;
> +
> +	p = container_of(this, struct sifive_edac_mc_priv, notifier);
> +	if (event == SIFIVE_DDR_ERR_TYPE_UE) {
> +		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, p->mci,
> +				     priv->error_count, priv->page_frame_number,
> +				     priv->offset_in_page, priv->syndrome,
> +				     priv->top_layer, priv->mid_layer,
> +				     priv->low_layer, p->mci->ctl_name, "");
> +	} else if (event == SIFIVE_DDR_ERR_TYPE_CE) {
> +		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, p->mci,
> +				     priv->error_count, priv->page_frame_number,
> +				     priv->offset_in_page, priv->syndrome,
> +				     priv->top_layer, priv->mid_layer,
> +				     priv->low_layer, p->mci->ctl_name, "");
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int ecc_mc_register(struct platform_device *pdev)
> +{
> +	struct sifive_edac_mc_priv *p;
> +	struct edac_mc_layer layers[1];
> +	int ret;
> +
> +	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	p->notifier.notifier_call = ecc_mc_err_event;
> +	platform_set_drvdata(pdev, p);
> +
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = 1;
> +	layers[0].is_virt_csrow = true;
> +
> +	p->mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
> +	if (!p->mci) {
> +		dev_err(&pdev->dev, "Failed mem allocation for mc instance\n");
> +		return -ENOMEM;
> +	}
> +
> +	p->mci->pdev = &pdev->dev;
> +	/* Initialize controller capabilities */
> +	p->mci->mtype_cap = MEM_FLAG_DDR4;
> +	p->mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
> +	p->mci->edac_cap = EDAC_FLAG_SECDED;
> +	p->mci->scrub_cap = SCRUB_UNKNOWN;
> +	p->mci->scrub_mode = SCRUB_HW_PROG;
> +	p->mci->ctl_name = dev_name(&pdev->dev);
> +	p->mci->dev_name = dev_name(&pdev->dev);
> +	p->mci->mod_name = SIFIVE_EDAC_MOD_NAME;
> +	p->mci->ctl_page_to_phys = NULL;
> +
> +	/* Interrupt feature is supported by cadence mc */
> +	edac_op_state = EDAC_OPSTATE_INT;
> +
> +	ret = edac_mc_add_mc(p->mci);
> +	if (ret) {
> +		edac_printk(KERN_ERR, SIFIVE_EDAC_MOD_NAME,
> +			    "Failed to register with EDAC core\n");
> +		goto err;
> +	}
> +
> +#ifdef CONFIG_SIFIVE_DDR
> +	register_sifive_ddr_error_notifier(&p->notifier);
> +#endif
> +
> +	return 0;
> +
> +err:
> +	edac_mc_free(p->mci);
> +
> +	return -ENXIO;
> +}
> +
> +static int ecc_mc_unregister(struct platform_device *pdev)
> +{
> +	struct sifive_edac_mc_priv *p = platform_get_drvdata(pdev);
> +
> +#ifdef CONFIG_SIFIVE_DDR
> +	unregister_sifive_ddr_error_notifier(&p->notifier);
> +#endif
> +	edac_mc_del_mc(&pdev->dev);
> +	edac_mc_free(p->mci);
> +
> +	return 0;
> +}
> +
>  /**
>   * EDAC error callback
>   *
> @@ -67,7 +173,9 @@ static int ecc_register(struct platform_device *pdev)
>  		goto err;
>  	}
>
> +#ifdef CONFIG_SIFIVE_L2
>  	register_sifive_l2_error_notifier(&p->notifier);
> +#endif
>
>  	return 0;
>
> @@ -81,7 +189,9 @@ static int ecc_unregister(struct platform_device *pdev)
>  {
>  	struct sifive_edac_priv *p = platform_get_drvdata(pdev);
>
> +#ifdef CONFIG_SIFIVE_L2
>  	unregister_sifive_l2_error_notifier(&p->notifier);
> +#endif
>  	edac_device_del_device(&pdev->dev);
>  	edac_device_free_ctl_info(p->dci);
>
> @@ -102,12 +212,19 @@ static int __init sifive_edac_init(void)
>  	if (ret)
>  		platform_device_unregister(sifive_pdev);
>
> +	ret = ecc_mc_register(sifive_pdev);
> +	if (ret) {
> +		ecc_unregister(sifive_pdev);
> +		platform_device_unregister(sifive_pdev);
> +	}
> +
>  	return ret;
>  }
>
>  static void __exit sifive_edac_exit(void)
>  {
>  	ecc_unregister(sifive_pdev);
> +	ecc_mc_unregister(sifive_pdev);
>  	platform_device_unregister(sifive_pdev);
>  }

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
