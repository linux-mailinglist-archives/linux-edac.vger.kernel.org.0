Return-Path: <linux-edac+bounces-1814-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D00396C905
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2024 22:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7511F2625A
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2024 20:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F145A13B780;
	Wed,  4 Sep 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sejuKX8o"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C401F146A79;
	Wed,  4 Sep 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725483410; cv=none; b=XNBeO/SVpI0/6wm/UuxPTzbK8TKFZd0QRrbKLTCklH0L3Tq8igbW6hWsoHjriaxXhG4WV4dPkywpJpGnTuHEQwRup+xesNdwWb8wreJ0DDYoHBWULRiRDBKckx0zgyutUp/5WIc6CGKQRdua0O6xtPaYI5JauP2Z/E78SfRFBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725483410; c=relaxed/simple;
	bh=ClR4OguZqjgD0a6zLxgiWicsv8WlX2RtmMFEul90H0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhRpbezzJqJZOXCPD6RckSEN0lM0s4tcy1lv3xKtFa+uLs19A2wZhwg4aaCdlaTT6Jpa89DNbdgBMOycrcGBaqxjBNwhOSPpq/Rg/g7YW4JEkEtavt4aW8QlapiS4vnTiaEEL9DTwv61XMqhKub98xVvEcNkw+TbeZZRkg5CqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sejuKX8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87BFC4CEC2;
	Wed,  4 Sep 2024 20:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725483410;
	bh=ClR4OguZqjgD0a6zLxgiWicsv8WlX2RtmMFEul90H0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sejuKX8o1CnnV9DTmEWu+PWGchsAIgOFc4wewuD+QgNeXYNqm3Dd5Zo9nja1TS2YN
	 Yw2DQD2g5lkJNh1MYmOfUF7qTKn/sDxonCVrSMkmAae8u9fVXRp/p+8ybHoz6Dkux8
	 oFXnSaXHd6gcTN1Uvl6+A7ZCYT5jrrNI3nhH4Ukv+RESjfO/mjhE9+DXWqO1jwPasw
	 BVxvl7pqV8gGIN5SoUBwKiNl4C8ZpufKrvEGfR2VdznT1jyL716xE0pccrm2a756Od
	 rqJx5Ru4oEaVopjY2cPVukeUB1pBVFazv/d4EKNkk2wVOeq+y4sYPueV+RlIamMw9E
	 vDJwiF3S7A12A==
Date: Wed, 4 Sep 2024 15:56:47 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, bp@alien8.de, tony.luck@intel.com, 
	mchehab@kernel.org, rric@kernel.org, konradybcio@kernel.org, quic_sibis@quicinc.com, 
	abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/qcom: Make irq configuration optional
Message-ID: <3rcpcypiv2cr3s66tz56lui57f7turqriwku3tvukwcejr6kh4@fkk5tyk3qgta>
References: <20240903101510.3452734-1-quic_rjendra@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903101510.3452734-1-quic_rjendra@quicinc.com>

On Tue, Sep 03, 2024 at 03:45:10PM GMT, Rajendra Nayak wrote:
> On most modern qualcomm SoCs, the configuration necessary to enable the
> Tag/Data RAM related irqs being propagated to the SoC irq controller is
> already done in firmware (in DSF or 'DDR System Firmware')
> 
> On some like the x1e80100, these registers aren't even accesible to the
> kernel causing a crash when edac device is probed.
> 
> Hence, make the irq configuration optional in the driver and mark x1e80100
> as the SoC on which this should be avoided.
> 
> Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Mani, would you like me to pick this through the qcom tree?

Regards,
Bjorn

> ---
> v2: 
> Minor typo fixed in changelog
> 
>  drivers/edac/qcom_edac.c           | 8 +++++---
>  drivers/soc/qcom/llcc-qcom.c       | 3 +++
>  include/linux/soc/qcom/llcc-qcom.h | 2 ++
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> index d3cd4cc54ace..96611ca09ac5 100644
> --- a/drivers/edac/qcom_edac.c
> +++ b/drivers/edac/qcom_edac.c
> @@ -342,9 +342,11 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
>  	int ecc_irq;
>  	int rc;
>  
> -	rc = qcom_llcc_core_setup(llcc_driv_data, llcc_driv_data->bcast_regmap);
> -	if (rc)
> -		return rc;
> +	if (!llcc_driv_data->ecc_irq_configured) {
> +		rc = qcom_llcc_core_setup(llcc_driv_data, llcc_driv_data->bcast_regmap);
> +		if (rc)
> +			return rc;
> +	}
>  
>  	/* Allocate edac control info */
>  	edev_ctl = edac_device_alloc_ctl_info(0, "qcom-llcc", 1, "bank",
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 8fa4ffd3a9b5..b1c0ae9991d6 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -139,6 +139,7 @@ struct qcom_llcc_config {
>  	int size;
>  	bool need_llcc_cfg;
>  	bool no_edac;
> +	bool irq_configured;
>  };
>  
>  struct qcom_sct_config {
> @@ -718,6 +719,7 @@ static const struct qcom_llcc_config x1e80100_cfg[] = {
>  		.need_llcc_cfg	= true,
>  		.reg_offset	= llcc_v2_1_reg_offset,
>  		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +		.irq_configured = true,
>  	},
>  };
>  
> @@ -1345,6 +1347,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  	drv_data->cfg = llcc_cfg;
>  	drv_data->cfg_size = sz;
>  	drv_data->edac_reg_offset = cfg->edac_reg_offset;
> +	drv_data->ecc_irq_configured = cfg->irq_configured;
>  	mutex_init(&drv_data->lock);
>  	platform_set_drvdata(pdev, drv_data);
>  
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> index 9e9f528b1370..acad1f4cf854 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -125,6 +125,7 @@ struct llcc_edac_reg_offset {
>   * @num_banks: Number of llcc banks
>   * @bitmap: Bit map to track the active slice ids
>   * @ecc_irq: interrupt for llcc cache error detection and reporting
> + * @ecc_irq_configured: 'True' if firmware has already configured the irq propagation
>   * @version: Indicates the LLCC version
>   */
>  struct llcc_drv_data {
> @@ -139,6 +140,7 @@ struct llcc_drv_data {
>  	u32 num_banks;
>  	unsigned long *bitmap;
>  	int ecc_irq;
> +	bool ecc_irq_configured;
>  	u32 version;
>  };
>  
> -- 
> 2.34.1
> 

