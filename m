Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F278964A473
	for <lists+linux-edac@lfdr.de>; Mon, 12 Dec 2022 16:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiLLPxx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Dec 2022 10:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiLLPxw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Dec 2022 10:53:52 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A87664CB
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 07:53:51 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id u19so10658974ejm.8
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 07:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sU26h7ISGDjyHbgt2m+/ybACjVhO2GW4px5ta3RiyaE=;
        b=36SO6GMz7L4vPlYlmziJri1BXEmxrk9bMJFdxWwfMpKw+n4X/jkbFndih2YeTWTIS3
         jlYRQrOMtG+doRt7bI/dquqhUjgv8zrSGpor9dW9N4SPiWv+uje5+f5Ue51gBR2kcpbX
         AZkbP829krC+hiJS6BVC2OMVdIDN2zRdk91lVUEuUXR4FjlqkpTnNrLlyjyetPcYZZlj
         kjW6HGGXLFox1QFJ1Q27QUwO0mm/kxEcbocXir1Ilp0Jq/nnC904Qg/igWQz/pazRjLJ
         lBoOIxq+ikg5ozXHChl01vIbq3EgBpKezsWoxHYo4bngJa2pXmva1PW5kdFZ9erkAaxF
         +Ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sU26h7ISGDjyHbgt2m+/ybACjVhO2GW4px5ta3RiyaE=;
        b=61dak2uDwq9nrllsyL2Gw6XZTA0FVcjbqK537s0wYAO6mxCV/ZLGoz+7Lis1UjavRS
         EAunFagvA7XhZfMCwTYevEM9X8At6AH404aN8yLHj7OxZmRiNplpG3gxsD98coKz8aHy
         bW7hauxAoH4L2lTwsolXUZ8Xs/W4nnfWqx8ioX05vYUlrYniaepv/7SpgqZa7G1kdAG3
         oWV027OvOlyVEcfi4+nO7MCYOHX4l/th4HQZPv+NSiWFMexynZ1gUsQ7YBkI8hq2Om3O
         JYwHFtIWGNFDnJP5v0O0vmYLoEM5caGWKRFf7Jru43Zw3sWh342wBEQqNHf7UtuMNlVM
         ml6A==
X-Gm-Message-State: ANoB5plHBDgPpR+0SXPHsk+CaMbWnhPZ6yh6PmVD9W56lhokdYUrs9jI
        SSrS9mxqpVoPZvPZk8JQDatarQ==
X-Google-Smtp-Source: AA0mqf5Zg1Ozrr8THrUoCfJfV68huVE0hUW60bMLlSIO9EryWHWHUJALQtR8QgmPEWYlZQ4WefDHZA==
X-Received: by 2002:a17:907:d049:b0:7c1:5467:39af with SMTP id vb9-20020a170907d04900b007c1546739afmr8795295ejc.37.1670860429931;
        Mon, 12 Dec 2022 07:53:49 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906300d00b00741a251d9e8sm3487278ejz.171.2022.12.12.07.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 07:53:49 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Dec 2022 16:53:49 +0100
Message-Id: <COZYL8MWN97H.MROQ391BGA09@otso>
Cc:     <quic_saipraka@quicinc.com>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>,
        <linux-edac@vger.kernel.org>, <quic_ppareek@quicinc.com>
Subject: Re: [PATCH v2 13/13] qcom: llcc/edac: Support polling mode for ECC
 handling
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <bp@alien8.de>,
        <tony.luck@intel.com>
X-Mailer: aerc 0.13.0
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
 <20221212123311.146261-14-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20221212123311.146261-14-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Manivannan,

On Mon Dec 12, 2022 at 1:33 PM CET, Manivannan Sadhasivam wrote:
> Not all Qcom platforms support IRQ mode for ECC handling. For those
> platforms, the current EDAC driver will not be probed due to missing ECC
> IRQ in devicetree.
>
> So add support for polling mode so that the EDAC driver can be used on al=
l
> Qcom platforms supporting LLCC.
>
> The polling delay of 5000ms is chosed based on Qcom downstream/vendor
> driver.

I think it does work for me on SM6350, I get this in dmesg:

[    0.054608] EDAC MC: Ver: 3.0.0
[    0.273913] EDAC DEVICE0: Giving out device to module qcom_llcc_edac con=
troller llcc: DEV qcom_llcc_edac (POLLED)

What I've noticed though is that the 5000ms poll you defined in the
driver doesn't seem to be reflected at runtime? Or am I looking at
different things?

/ # cat /sys/devices/system/edac/qcom-llcc/poll_msec=20
1000

Regards
Luca

>
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/edac/qcom_edac.c     | 37 +++++++++++++++++++++++++-----------
>  drivers/soc/qcom/llcc-qcom.c | 13 ++++++-------
>  2 files changed, 32 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> index 5be93577fc03..f7afb5375293 100644
> --- a/drivers/edac/qcom_edac.c
> +++ b/drivers/edac/qcom_edac.c
> @@ -76,6 +76,8 @@
>  #define DRP0_INTERRUPT_ENABLE           BIT(6)
>  #define SB_DB_DRP_INTERRUPT_ENABLE      0x3
> =20
> +#define ECC_POLL_MSEC			5000
> +
>  enum {
>  	LLCC_DRAM_CE =3D 0,
>  	LLCC_DRAM_UE,
> @@ -283,8 +285,7 @@ dump_syn_reg(struct edac_device_ctl_info *edev_ctl, i=
nt err_type, u32 bank)
>  	return ret;
>  }
> =20
> -static irqreturn_t
> -llcc_ecc_irq_handler(int irq, void *edev_ctl)
> +static irqreturn_t llcc_ecc_irq_handler(int irq, void *edev_ctl)
>  {
>  	struct edac_device_ctl_info *edac_dev_ctl =3D edev_ctl;
>  	struct llcc_drv_data *drv =3D edac_dev_ctl->pvt_info;
> @@ -328,6 +329,11 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
>  	return irq_rc;
>  }
> =20
> +static void llcc_ecc_check(struct edac_device_ctl_info *edev_ctl)
> +{
> +	llcc_ecc_irq_handler(0, edev_ctl);
> +}
> +
>  static int qcom_llcc_edac_probe(struct platform_device *pdev)
>  {
>  	struct llcc_drv_data *llcc_driv_data =3D pdev->dev.platform_data;
> @@ -356,22 +362,31 @@ static int qcom_llcc_edac_probe(struct platform_dev=
ice *pdev)
>  	edev_ctl->panic_on_ue =3D LLCC_ERP_PANIC_ON_UE;
>  	edev_ctl->pvt_info =3D llcc_driv_data;
> =20
> +	/* Check if LLCC driver has passed ECC IRQ */
> +	ecc_irq =3D llcc_driv_data->ecc_irq;
> +	if (ecc_irq > 0) {
> +		/* Use interrupt mode if IRQ is available */
> +		edac_op_state =3D EDAC_OPSTATE_INT;
> +	} else {
> +		/* Fall back to polling mode otherwise */
> +		edac_op_state =3D EDAC_OPSTATE_POLL;
> +		edev_ctl->poll_msec =3D ECC_POLL_MSEC;
> +		edev_ctl->edac_check =3D llcc_ecc_check;
> +	}
> +
>  	rc =3D edac_device_add_device(edev_ctl);
>  	if (rc)
>  		goto out_mem;
> =20
>  	platform_set_drvdata(pdev, edev_ctl);
> =20
> -	/* Request for ecc irq */
> -	ecc_irq =3D llcc_driv_data->ecc_irq;
> -	if (ecc_irq < 0) {
> -		rc =3D -ENODEV;
> -		goto out_dev;
> -	}
> -	rc =3D devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
> +	/* Request ECC IRQ if available */
> +	if (ecc_irq > 0) {
> +		rc =3D devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
>  			      IRQF_TRIGGER_HIGH, "llcc_ecc", edev_ctl);
> -	if (rc)
> -		goto out_dev;
> +		if (rc)
> +			goto out_dev;
> +	}
> =20
>  	return rc;
> =20
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index a29f22dad7fa..e044e6756415 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -1011,13 +1011,12 @@ static int qcom_llcc_probe(struct platform_device=
 *pdev)
>  		goto err;
> =20
>  	drv_data->ecc_irq =3D platform_get_irq_optional(pdev, 0);
> -	if (drv_data->ecc_irq >=3D 0) {
> -		llcc_edac =3D platform_device_register_data(&pdev->dev,
> -						"qcom_llcc_edac", -1, drv_data,
> -						sizeof(*drv_data));
> -		if (IS_ERR(llcc_edac))
> -			dev_err(dev, "Failed to register llcc edac driver\n");
> -	}
> +
> +	llcc_edac =3D platform_device_register_data(&pdev->dev,
> +					"qcom_llcc_edac", -1, drv_data,
> +					sizeof(*drv_data));
> +	if (IS_ERR(llcc_edac))
> +		dev_err(dev, "Failed to register llcc edac driver\n");
> =20
>  	return 0;
>  err:
> --=20
> 2.25.1

