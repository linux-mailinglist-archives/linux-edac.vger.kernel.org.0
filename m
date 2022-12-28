Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F245657287
	for <lists+linux-edac@lfdr.de>; Wed, 28 Dec 2022 05:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiL1E3w (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Dec 2022 23:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL1E3u (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Dec 2022 23:29:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C2AD90;
        Tue, 27 Dec 2022 20:29:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E776612F1;
        Wed, 28 Dec 2022 04:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7E0C433EF;
        Wed, 28 Dec 2022 04:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672201787;
        bh=Ly8R+9IsAyTN0hgxF7QLkgQQAuEFBkp07+3+asBuVk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qm3wP3Czl3FFd/Z1iZRQnshhEEp9rK5B6Ci9uS5vCGoqKmmSpvTQjc+Y1ZqUQxTUr
         mYLJUEKteAHYpUTZluGvlmQVaWX9I8bUy6xJjU9u2/jAlzzuBSn6k7HVVj6p6X0YfK
         uudPXVGOxfP+VbhYJb0AaLVrEcy+Jq8v2nCJFtuGttDWSkNpmWSB8DYBTsTRFkMIdj
         vDJPHU+2jQFLn190ozrDg76SF5naFzjA/SBSGuyoUJbjSMim7yrqMPJMtszOBMaChc
         ZfLAiCU7nBSyAfmCTh+trH9qVjEgdWO3hFMFOqVp/wfFzZ9DpfY3hfuYthqV5aT9dz
         GA6Q05mE8vBXQ==
Date:   Tue, 27 Dec 2022 22:29:44 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bp@alien8.de, tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com, steev@kali.org
Subject: Re: [PATCH v4 15/16] qcom: llcc/edac: Fix the base address used for
 accessing LLCC banks
Message-ID: <20221228042944.g4g6vvaapiln6ces@builder.lan>
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
 <20221222131656.49584-16-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222131656.49584-16-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 22, 2022 at 06:46:55PM +0530, Manivannan Sadhasivam wrote:
> First index is LLCC bank 0 and last index is LLCC broadcast. If the SoC
> supports more than one bank, then those needs to be defined in devicetree
> for index from 1..N-1.
> 

What happened to my request for dropping the reliance on reg-names and
pick reg entries per the logic you describe here?

Was it request just lost or was there a reason why you stuck with the
reg-names?

Regards,
Bjorn

> Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/edac/qcom_edac.c           | 14 +++---
>  drivers/soc/qcom/llcc-qcom.c       | 72 +++++++++++++++++-------------
>  include/linux/soc/qcom/llcc-qcom.h |  6 +--
>  3 files changed, 48 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> index 3256254c3722..1d3cc1930a74 100644
> --- a/drivers/edac/qcom_edac.c
> +++ b/drivers/edac/qcom_edac.c
> @@ -213,7 +213,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
>  
>  	for (i = 0; i < reg_data.reg_cnt; i++) {
>  		synd_reg = reg_data.synd_reg + (i * 4);
> -		ret = regmap_read(drv->regmap, drv->offsets[bank] + synd_reg,
> +		ret = regmap_read(drv->regmaps[bank], synd_reg,
>  				  &synd_val);
>  		if (ret)
>  			goto clear;
> @@ -222,8 +222,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
>  			    reg_data.name, i, synd_val);
>  	}
>  
> -	ret = regmap_read(drv->regmap,
> -			  drv->offsets[bank] + reg_data.count_status_reg,
> +	ret = regmap_read(drv->regmaps[bank], reg_data.count_status_reg,
>  			  &err_cnt);
>  	if (ret)
>  		goto clear;
> @@ -233,8 +232,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
>  	edac_printk(KERN_CRIT, EDAC_LLCC, "%s: Error count: 0x%4x\n",
>  		    reg_data.name, err_cnt);
>  
> -	ret = regmap_read(drv->regmap,
> -			  drv->offsets[bank] + reg_data.ways_status_reg,
> +	ret = regmap_read(drv->regmaps[bank], reg_data.ways_status_reg,
>  			  &err_ways);
>  	if (ret)
>  		goto clear;
> @@ -296,8 +294,7 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
>  
>  	/* Iterate over the banks and look for Tag RAM or Data RAM errors */
>  	for (i = 0; i < drv->num_banks; i++) {
> -		ret = regmap_read(drv->regmap,
> -				  drv->offsets[i] + DRP_INTERRUPT_STATUS,
> +		ret = regmap_read(drv->regmaps[i], DRP_INTERRUPT_STATUS,
>  				  &drp_error);
>  
>  		if (!ret && (drp_error & SB_ECC_ERROR)) {
> @@ -312,8 +309,7 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
>  		if (!ret)
>  			irq_rc = IRQ_HANDLED;
>  
> -		ret = regmap_read(drv->regmap,
> -				  drv->offsets[i] + TRP_INTERRUPT_0_STATUS,
> +		ret = regmap_read(drv->regmaps[i], TRP_INTERRUPT_0_STATUS,
>  				  &trp_error);
>  
>  		if (!ret && (trp_error & SB_ECC_ERROR)) {
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 23ce2f78c4ed..72f3f2a9aaa0 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -62,8 +62,6 @@
>  #define LLCC_TRP_WRSC_CACHEABLE_EN    0x21f2c
>  #define LLCC_TRP_ALGO_CFG8	      0x21f30
>  
> -#define BANK_OFFSET_STRIDE	      0x80000
> -
>  #define LLCC_VERSION_2_0_0_0          0x02000000
>  #define LLCC_VERSION_2_1_0_0          0x02010000
>  #define LLCC_VERSION_4_1_0_0          0x04010000
> @@ -898,8 +896,8 @@ static int qcom_llcc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
> -		const char *name)
> +static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev, u8 index,
> +					  const char *name)
>  {
>  	void __iomem *base;
>  	struct regmap_config llcc_regmap_config = {
> @@ -909,7 +907,7 @@ static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
>  		.fast_io = true,
>  	};
>  
> -	base = devm_platform_ioremap_resource_byname(pdev, name);
> +	base = devm_platform_ioremap_resource(pdev, index);
>  	if (IS_ERR(base))
>  		return ERR_CAST(base);
>  
> @@ -927,6 +925,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  	const struct llcc_slice_config *llcc_cfg;
>  	u32 sz;
>  	u32 version;
> +	struct regmap *regmap;
>  
>  	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
>  	if (!drv_data) {
> @@ -934,21 +933,51 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	drv_data->regmap = qcom_llcc_init_mmio(pdev, "llcc_base");
> -	if (IS_ERR(drv_data->regmap)) {
> -		ret = PTR_ERR(drv_data->regmap);
> +	/* Initialize the first LLCC bank regmap */
> +	regmap = qcom_llcc_init_mmio(pdev, 0, "llcc0_base");
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
>  		goto err;
>  	}
>  
> -	drv_data->bcast_regmap =
> -		qcom_llcc_init_mmio(pdev, "llcc_broadcast_base");
> +	cfg = of_device_get_match_data(&pdev->dev);
> +
> +	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
> +	if (ret)
> +		goto err;
> +
> +	num_banks &= LLCC_LB_CNT_MASK;
> +	num_banks >>= LLCC_LB_CNT_SHIFT;
> +	drv_data->num_banks = num_banks;
> +
> +	drv_data->regmaps = devm_kcalloc(dev, num_banks, sizeof(*drv_data->regmaps), GFP_KERNEL);
> +	if (!drv_data->regmaps) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	drv_data->regmaps[0] = regmap;
> +
> +	/* Initialize rest of LLCC bank regmaps */
> +	for (i = 1; i < num_banks; i++) {
> +		char *base = kasprintf(GFP_KERNEL, "llcc%d_base", i);
> +
> +		drv_data->regmaps[i] = qcom_llcc_init_mmio(pdev, i, base);
> +		if (IS_ERR(drv_data->regmaps[i])) {
> +			ret = PTR_ERR(drv_data->regmaps[i]);
> +			kfree(base);
> +			goto err;
> +		}
> +
> +		kfree(base);
> +	}
> +
> +	drv_data->bcast_regmap = qcom_llcc_init_mmio(pdev, i, "llcc_broadcast_base");
>  	if (IS_ERR(drv_data->bcast_regmap)) {
>  		ret = PTR_ERR(drv_data->bcast_regmap);
>  		goto err;
>  	}
>  
> -	cfg = of_device_get_match_data(&pdev->dev);
> -
>  	/* Extract version of the IP */
>  	ret = regmap_read(drv_data->bcast_regmap, cfg->reg_offset[LLCC_COMMON_HW_INFO],
>  			  &version);
> @@ -957,15 +986,6 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  
>  	drv_data->version = version;
>  
> -	ret = regmap_read(drv_data->regmap, cfg->reg_offset[LLCC_COMMON_STATUS0],
> -			  &num_banks);
> -	if (ret)
> -		goto err;
> -
> -	num_banks &= LLCC_LB_CNT_MASK;
> -	num_banks >>= LLCC_LB_CNT_SHIFT;
> -	drv_data->num_banks = num_banks;
> -
>  	llcc_cfg = cfg->sct_data;
>  	sz = cfg->size;
>  
> @@ -973,16 +993,6 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  		if (llcc_cfg[i].slice_id > drv_data->max_slices)
>  			drv_data->max_slices = llcc_cfg[i].slice_id;
>  
> -	drv_data->offsets = devm_kcalloc(dev, num_banks, sizeof(u32),
> -							GFP_KERNEL);
> -	if (!drv_data->offsets) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> -
> -	for (i = 0; i < num_banks; i++)
> -		drv_data->offsets[i] = i * BANK_OFFSET_STRIDE;
> -
>  	drv_data->bitmap = devm_bitmap_zalloc(dev, drv_data->max_slices,
>  					      GFP_KERNEL);
>  	if (!drv_data->bitmap) {
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> index ad1fd718169d..423220e66026 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -120,7 +120,7 @@ struct llcc_edac_reg_offset {
>  
>  /**
>   * struct llcc_drv_data - Data associated with the llcc driver
> - * @regmap: regmap associated with the llcc device
> + * @regmaps: regmaps associated with the llcc device
>   * @bcast_regmap: regmap associated with llcc broadcast offset
>   * @cfg: pointer to the data structure for slice configuration
>   * @edac_reg_offset: Offset of the LLCC EDAC registers
> @@ -129,12 +129,11 @@ struct llcc_edac_reg_offset {
>   * @max_slices: max slices as read from device tree
>   * @num_banks: Number of llcc banks
>   * @bitmap: Bit map to track the active slice ids
> - * @offsets: Pointer to the bank offsets array
>   * @ecc_irq: interrupt for llcc cache error detection and reporting
>   * @version: Indicates the LLCC version
>   */
>  struct llcc_drv_data {
> -	struct regmap *regmap;
> +	struct regmap **regmaps;
>  	struct regmap *bcast_regmap;
>  	const struct llcc_slice_config *cfg;
>  	const struct llcc_edac_reg_offset *edac_reg_offset;
> @@ -143,7 +142,6 @@ struct llcc_drv_data {
>  	u32 max_slices;
>  	u32 num_banks;
>  	unsigned long *bitmap;
> -	u32 *offsets;
>  	int ecc_irq;
>  	u32 version;
>  };
> -- 
> 2.25.1
> 
