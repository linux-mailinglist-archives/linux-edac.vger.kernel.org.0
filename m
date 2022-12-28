Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B004657363
	for <lists+linux-edac@lfdr.de>; Wed, 28 Dec 2022 07:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiL1GyG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Dec 2022 01:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiL1GyE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Dec 2022 01:54:04 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271DEE90
        for <linux-edac@vger.kernel.org>; Tue, 27 Dec 2022 22:54:03 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d7so15260457pll.9
        for <linux-edac@vger.kernel.org>; Tue, 27 Dec 2022 22:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TeajCQ9nJ3xMY0Pj1f9Z3uIcTFs/noQ1iKw1tVK+dCM=;
        b=WBAYuB6D5AISA5eBQh64FNoAw0n9C45YO2CClq7whDF922r3dwKQViTvM92sn7OCOG
         vEFcvXmrTl8flM5amvMciNkBSIuKqG88/rGPIbOUYENNhG5GpDtjVkN9IoKYeUsmrz6y
         RDHarozlcknospaVekRVgUPZwMLf02DMeK/je8FFe6oit8ULHf8WX1+mEd52dLWZ3oad
         k8j8b+Apm13m21HcpFjfAbd06JC0iBtJ6pJd+Gy3OXwyW7ClDXyEQscz6KOlfQABoiD7
         kQnFcCLKwtANIwFxO7lyXCDINdwwbjSXgBqQs4D1T3l4/JJ2wNxl5Urvq4r60mMpU8nZ
         hAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeajCQ9nJ3xMY0Pj1f9Z3uIcTFs/noQ1iKw1tVK+dCM=;
        b=UT9lFbRmdH/b956uqQRNw0YrslKb6Dt8RETn4HZOwsoK2pjhmUAsphrjaxkTgi5dHX
         6eIW58yVaMxs8FVOZewgZrtGUI2YRG5TsilmcXttMRLmyrN/AabAyO+euwIA3sNNPAQW
         mIXtwL6eH2B7D0vqrFDHJO8COofMcarVmp3mOB329/IPXkt4j9uFKv+FWzG5z8hIlgTr
         ADqomUiPqp7zJymuhm9+WD2zyk3JnaxGGljR6LG3W20/jCE5v97G0a3bfstzyyqbdkJs
         kp26YlbaKqWgvVxLPdfO7CmKRvHtkXVvNaYgdbAj5uSAbq0eNg8hMEsoNEDsGFoOImGy
         CSqA==
X-Gm-Message-State: AFqh2kq5fGD0D1theVbzWoV7CiHMmdczOY3z3IRgqiRz486Odtg/dQIS
        n9vWV03+qlSXS7czTUeUtZzN
X-Google-Smtp-Source: AMrXdXvHOuXCbhhwZ7dvFcvsADK9ThJTNs9idihgJk0m9Y4HIJDJuvsXS5dd933vHWIv0XDoZkkKKA==
X-Received: by 2002:a17:903:2787:b0:189:7f09:3fbd with SMTP id jw7-20020a170903278700b001897f093fbdmr24561385plb.51.1672210442492;
        Tue, 27 Dec 2022 22:54:02 -0800 (PST)
Received: from thinkpad ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902710900b00186748fe6ccsm10134115pll.214.2022.12.27.22.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 22:54:01 -0800 (PST)
Date:   Wed, 28 Dec 2022 12:23:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        bp@alien8.de, tony.luck@intel.com, quic_saipraka@quicinc.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com, steev@kali.org
Subject: Re: [PATCH v4 15/16] qcom: llcc/edac: Fix the base address used for
 accessing LLCC banks
Message-ID: <20221228065353.GB30143@thinkpad>
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
 <20221222131656.49584-16-manivannan.sadhasivam@linaro.org>
 <20221228042944.g4g6vvaapiln6ces@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221228042944.g4g6vvaapiln6ces@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 27, 2022 at 10:29:44PM -0600, Bjorn Andersson wrote:
> On Thu, Dec 22, 2022 at 06:46:55PM +0530, Manivannan Sadhasivam wrote:
> > First index is LLCC bank 0 and last index is LLCC broadcast. If the SoC
> > supports more than one bank, then those needs to be defined in devicetree
> > for index from 1..N-1.
> > 
> 
> What happened to my request for dropping the reliance on reg-names and
> pick reg entries per the logic you describe here?
> 
> Was it request just lost or was there a reason why you stuck with the
> reg-names?
> 

The driver uses index to map the resources from DT and not using reg-names.
See qcom_llcc_init_mmio().

But the reg-names property is kept in the devicetree as per Krzysztof's
request. I've recorded these in the changelog.

Thanks,
Mani

> Regards,
> Bjorn
> 
> > Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> > Tested-by: Luca Weiss <luca.weiss@fairphone.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/edac/qcom_edac.c           | 14 +++---
> >  drivers/soc/qcom/llcc-qcom.c       | 72 +++++++++++++++++-------------
> >  include/linux/soc/qcom/llcc-qcom.h |  6 +--
> >  3 files changed, 48 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> > index 3256254c3722..1d3cc1930a74 100644
> > --- a/drivers/edac/qcom_edac.c
> > +++ b/drivers/edac/qcom_edac.c
> > @@ -213,7 +213,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
> >  
> >  	for (i = 0; i < reg_data.reg_cnt; i++) {
> >  		synd_reg = reg_data.synd_reg + (i * 4);
> > -		ret = regmap_read(drv->regmap, drv->offsets[bank] + synd_reg,
> > +		ret = regmap_read(drv->regmaps[bank], synd_reg,
> >  				  &synd_val);
> >  		if (ret)
> >  			goto clear;
> > @@ -222,8 +222,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
> >  			    reg_data.name, i, synd_val);
> >  	}
> >  
> > -	ret = regmap_read(drv->regmap,
> > -			  drv->offsets[bank] + reg_data.count_status_reg,
> > +	ret = regmap_read(drv->regmaps[bank], reg_data.count_status_reg,
> >  			  &err_cnt);
> >  	if (ret)
> >  		goto clear;
> > @@ -233,8 +232,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
> >  	edac_printk(KERN_CRIT, EDAC_LLCC, "%s: Error count: 0x%4x\n",
> >  		    reg_data.name, err_cnt);
> >  
> > -	ret = regmap_read(drv->regmap,
> > -			  drv->offsets[bank] + reg_data.ways_status_reg,
> > +	ret = regmap_read(drv->regmaps[bank], reg_data.ways_status_reg,
> >  			  &err_ways);
> >  	if (ret)
> >  		goto clear;
> > @@ -296,8 +294,7 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
> >  
> >  	/* Iterate over the banks and look for Tag RAM or Data RAM errors */
> >  	for (i = 0; i < drv->num_banks; i++) {
> > -		ret = regmap_read(drv->regmap,
> > -				  drv->offsets[i] + DRP_INTERRUPT_STATUS,
> > +		ret = regmap_read(drv->regmaps[i], DRP_INTERRUPT_STATUS,
> >  				  &drp_error);
> >  
> >  		if (!ret && (drp_error & SB_ECC_ERROR)) {
> > @@ -312,8 +309,7 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
> >  		if (!ret)
> >  			irq_rc = IRQ_HANDLED;
> >  
> > -		ret = regmap_read(drv->regmap,
> > -				  drv->offsets[i] + TRP_INTERRUPT_0_STATUS,
> > +		ret = regmap_read(drv->regmaps[i], TRP_INTERRUPT_0_STATUS,
> >  				  &trp_error);
> >  
> >  		if (!ret && (trp_error & SB_ECC_ERROR)) {
> > diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> > index 23ce2f78c4ed..72f3f2a9aaa0 100644
> > --- a/drivers/soc/qcom/llcc-qcom.c
> > +++ b/drivers/soc/qcom/llcc-qcom.c
> > @@ -62,8 +62,6 @@
> >  #define LLCC_TRP_WRSC_CACHEABLE_EN    0x21f2c
> >  #define LLCC_TRP_ALGO_CFG8	      0x21f30
> >  
> > -#define BANK_OFFSET_STRIDE	      0x80000
> > -
> >  #define LLCC_VERSION_2_0_0_0          0x02000000
> >  #define LLCC_VERSION_2_1_0_0          0x02010000
> >  #define LLCC_VERSION_4_1_0_0          0x04010000
> > @@ -898,8 +896,8 @@ static int qcom_llcc_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > -static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
> > -		const char *name)
> > +static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev, u8 index,
> > +					  const char *name)
> >  {
> >  	void __iomem *base;
> >  	struct regmap_config llcc_regmap_config = {
> > @@ -909,7 +907,7 @@ static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
> >  		.fast_io = true,
> >  	};
> >  
> > -	base = devm_platform_ioremap_resource_byname(pdev, name);
> > +	base = devm_platform_ioremap_resource(pdev, index);
> >  	if (IS_ERR(base))
> >  		return ERR_CAST(base);
> >  
> > @@ -927,6 +925,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
> >  	const struct llcc_slice_config *llcc_cfg;
> >  	u32 sz;
> >  	u32 version;
> > +	struct regmap *regmap;
> >  
> >  	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
> >  	if (!drv_data) {
> > @@ -934,21 +933,51 @@ static int qcom_llcc_probe(struct platform_device *pdev)
> >  		goto err;
> >  	}
> >  
> > -	drv_data->regmap = qcom_llcc_init_mmio(pdev, "llcc_base");
> > -	if (IS_ERR(drv_data->regmap)) {
> > -		ret = PTR_ERR(drv_data->regmap);
> > +	/* Initialize the first LLCC bank regmap */
> > +	regmap = qcom_llcc_init_mmio(pdev, 0, "llcc0_base");
> > +	if (IS_ERR(regmap)) {
> > +		ret = PTR_ERR(regmap);
> >  		goto err;
> >  	}
> >  
> > -	drv_data->bcast_regmap =
> > -		qcom_llcc_init_mmio(pdev, "llcc_broadcast_base");
> > +	cfg = of_device_get_match_data(&pdev->dev);
> > +
> > +	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
> > +	if (ret)
> > +		goto err;
> > +
> > +	num_banks &= LLCC_LB_CNT_MASK;
> > +	num_banks >>= LLCC_LB_CNT_SHIFT;
> > +	drv_data->num_banks = num_banks;
> > +
> > +	drv_data->regmaps = devm_kcalloc(dev, num_banks, sizeof(*drv_data->regmaps), GFP_KERNEL);
> > +	if (!drv_data->regmaps) {
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}
> > +
> > +	drv_data->regmaps[0] = regmap;
> > +
> > +	/* Initialize rest of LLCC bank regmaps */
> > +	for (i = 1; i < num_banks; i++) {
> > +		char *base = kasprintf(GFP_KERNEL, "llcc%d_base", i);
> > +
> > +		drv_data->regmaps[i] = qcom_llcc_init_mmio(pdev, i, base);
> > +		if (IS_ERR(drv_data->regmaps[i])) {
> > +			ret = PTR_ERR(drv_data->regmaps[i]);
> > +			kfree(base);
> > +			goto err;
> > +		}
> > +
> > +		kfree(base);
> > +	}
> > +
> > +	drv_data->bcast_regmap = qcom_llcc_init_mmio(pdev, i, "llcc_broadcast_base");
> >  	if (IS_ERR(drv_data->bcast_regmap)) {
> >  		ret = PTR_ERR(drv_data->bcast_regmap);
> >  		goto err;
> >  	}
> >  
> > -	cfg = of_device_get_match_data(&pdev->dev);
> > -
> >  	/* Extract version of the IP */
> >  	ret = regmap_read(drv_data->bcast_regmap, cfg->reg_offset[LLCC_COMMON_HW_INFO],
> >  			  &version);
> > @@ -957,15 +986,6 @@ static int qcom_llcc_probe(struct platform_device *pdev)
> >  
> >  	drv_data->version = version;
> >  
> > -	ret = regmap_read(drv_data->regmap, cfg->reg_offset[LLCC_COMMON_STATUS0],
> > -			  &num_banks);
> > -	if (ret)
> > -		goto err;
> > -
> > -	num_banks &= LLCC_LB_CNT_MASK;
> > -	num_banks >>= LLCC_LB_CNT_SHIFT;
> > -	drv_data->num_banks = num_banks;
> > -
> >  	llcc_cfg = cfg->sct_data;
> >  	sz = cfg->size;
> >  
> > @@ -973,16 +993,6 @@ static int qcom_llcc_probe(struct platform_device *pdev)
> >  		if (llcc_cfg[i].slice_id > drv_data->max_slices)
> >  			drv_data->max_slices = llcc_cfg[i].slice_id;
> >  
> > -	drv_data->offsets = devm_kcalloc(dev, num_banks, sizeof(u32),
> > -							GFP_KERNEL);
> > -	if (!drv_data->offsets) {
> > -		ret = -ENOMEM;
> > -		goto err;
> > -	}
> > -
> > -	for (i = 0; i < num_banks; i++)
> > -		drv_data->offsets[i] = i * BANK_OFFSET_STRIDE;
> > -
> >  	drv_data->bitmap = devm_bitmap_zalloc(dev, drv_data->max_slices,
> >  					      GFP_KERNEL);
> >  	if (!drv_data->bitmap) {
> > diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> > index ad1fd718169d..423220e66026 100644
> > --- a/include/linux/soc/qcom/llcc-qcom.h
> > +++ b/include/linux/soc/qcom/llcc-qcom.h
> > @@ -120,7 +120,7 @@ struct llcc_edac_reg_offset {
> >  
> >  /**
> >   * struct llcc_drv_data - Data associated with the llcc driver
> > - * @regmap: regmap associated with the llcc device
> > + * @regmaps: regmaps associated with the llcc device
> >   * @bcast_regmap: regmap associated with llcc broadcast offset
> >   * @cfg: pointer to the data structure for slice configuration
> >   * @edac_reg_offset: Offset of the LLCC EDAC registers
> > @@ -129,12 +129,11 @@ struct llcc_edac_reg_offset {
> >   * @max_slices: max slices as read from device tree
> >   * @num_banks: Number of llcc banks
> >   * @bitmap: Bit map to track the active slice ids
> > - * @offsets: Pointer to the bank offsets array
> >   * @ecc_irq: interrupt for llcc cache error detection and reporting
> >   * @version: Indicates the LLCC version
> >   */
> >  struct llcc_drv_data {
> > -	struct regmap *regmap;
> > +	struct regmap **regmaps;
> >  	struct regmap *bcast_regmap;
> >  	const struct llcc_slice_config *cfg;
> >  	const struct llcc_edac_reg_offset *edac_reg_offset;
> > @@ -143,7 +142,6 @@ struct llcc_drv_data {
> >  	u32 max_slices;
> >  	u32 num_banks;
> >  	unsigned long *bitmap;
> > -	u32 *offsets;
> >  	int ecc_irq;
> >  	u32 version;
> >  };
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
