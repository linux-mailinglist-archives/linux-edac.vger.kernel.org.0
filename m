Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73E166ABA7
	for <lists+linux-edac@lfdr.de>; Sat, 14 Jan 2023 14:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjANNgU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 14 Jan 2023 08:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjANNgT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 14 Jan 2023 08:36:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFD05243;
        Sat, 14 Jan 2023 05:36:18 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A977F1EC03D6;
        Sat, 14 Jan 2023 14:36:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673703376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DEFsrMm3DLTdKh3zb7F3HNijkt8nR2QiS45lmW3e2VY=;
        b=EzuDwkn+pg0pF4E9/A31/WQ7r1mZ6Om+kkQ94XyavGyp7ulEsVZUyLry2AtVt2ICrB+ZHh
        oaW9r+H5tOxcBNGaLaqD3I1ls4+jqM+NR29UBlYyQlblkLmom+zY0Js1Hs6I781fWNYNEy
        x2dAQv2azjJR33ZbNW/5jk6S5d4DZpM=
Date:   Sat, 14 Jan 2023 14:36:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony.luck@intel.com,
        quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org
Subject: Re: [PATCH v5 16/17] qcom: llcc/edac: Support polling mode for ECC
 handling
Message-ID: <Y8Kv0GIk69MhcOjT@zn.tnic>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
 <20221228084028.46528-17-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221228084028.46528-17-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 28, 2022 at 02:10:27PM +0530, Manivannan Sadhasivam wrote:
>  static int qcom_llcc_edac_probe(struct platform_device *pdev)
>  {
>  	struct llcc_drv_data *llcc_driv_data = pdev->dev.platform_data;
> @@ -355,22 +361,31 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
>  	edev_ctl->ctl_name = "llcc";
>  	edev_ctl->panic_on_ue = LLCC_ERP_PANIC_ON_UE;
>  
> +	/* Check if LLCC driver has passed ECC IRQ */
> +	ecc_irq = llcc_driv_data->ecc_irq;
> +	if (ecc_irq > 0) {
> +		/* Use interrupt mode if IRQ is available */
> +		edac_op_state = EDAC_OPSTATE_INT;
> +	} else {
> +		/* Fall back to polling mode otherwise */
> +		edac_op_state = EDAC_OPSTATE_POLL;
> +		edev_ctl->poll_msec = ECC_POLL_MSEC;
> +		edev_ctl->edac_check = llcc_ecc_check;
> +	}
> +
>  	rc = edac_device_add_device(edev_ctl);
>  	if (rc)
>  		goto out_mem;
>  
>  	platform_set_drvdata(pdev, edev_ctl);
>  
> -	/* Request for ecc irq */
> -	ecc_irq = llcc_driv_data->ecc_irq;
> -	if (ecc_irq < 0) {
> -		rc = -ENODEV;
> -		goto out_dev;
> -	}
> -	rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
> +	/* Request ECC IRQ if available */
> +	if (ecc_irq > 0) {
> +		rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
>  			      IRQF_TRIGGER_HIGH, "llcc_ecc", edev_ctl);

You need to request the IRQ first and then set edac_op_state above. I.e., this
devm_request_irq() needs to move in the if (ecc_irq > 0) branch above.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
