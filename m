Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240615A5988
	for <lists+linux-edac@lfdr.de>; Tue, 30 Aug 2022 04:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiH3Cui (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 29 Aug 2022 22:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiH3Cug (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 29 Aug 2022 22:50:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C58E74E08;
        Mon, 29 Aug 2022 19:50:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DAE5ACE16D8;
        Tue, 30 Aug 2022 02:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCCAC433D6;
        Tue, 30 Aug 2022 02:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661827831;
        bh=Qibth7K0On2/Izrqj1DrG3Pqxf5F5IFn/kJ54oz3lUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPiubH4qViZdL5yxfHXcS23Z1c/T5gWYLreOrg0iM4gnmoWHQsPUkPfR6vjXJ+uw1
         eovOfHTgnY+6FRJ1fihS3xcixEFmOTiVqq94x0r5iAP+DhMz35DxmcWEU0474GK7gE
         I2Os8Ra5YJ6YRfcr3IEa0v5ZpZOjvQMr6xby22RtPica/ekeh/vkHPg7IKXTFI+Lep
         Eyq7l0/T30xJt5/ADrXXILQr9SI3MPMjMZSih30/uUVNCq5KKB5ojKq6fCVTZO5nMn
         C9uMOGWylqO+UkglW0Csj/snF5D/ZzUrHAwH/9tXccOWmrCyUmITuD44GzhO+Rn/zP
         hLJcDB1UNVzJg==
Date:   Mon, 29 Aug 2022 21:50:28 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bjorn.andersson@linaro.org, bp@alien8.de, mchehab@kernel.org,
        james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_saipraka@quicinc.com
Subject: Re: [PATCH v3 3/5] EDAC/qcom: Get rid of hardcoded register offsets
Message-ID: <20220830025028.2uyipn7aqhwscz6v@builder.lan>
References: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
 <20220825043859.30066-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825043859.30066-4-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 25, 2022 at 10:08:57AM +0530, Manivannan Sadhasivam wrote:
> The LLCC EDAC register offsets varies between each SoC. Hardcoding the
> register offsets won't work and will often result in crash due to
> accessing the wrong locations.
> 
> Hence, get the register offsets from the LLCC driver matching the
> individual SoCs.
> 

I have applied patch 1 and 2 to the Qualcomm tree, please find a tag of
this:

https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
tags/20220825043859.30066-3-manivannan.sadhasivam@linaro.org

Regards,
Bjorn

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/edac/qcom_edac.c           | 116 ++++++++++++++---------------
>  include/linux/soc/qcom/llcc-qcom.h |   6 --
>  2 files changed, 58 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> index 97a27e42dd61..04df70b7fea3 100644
> --- a/drivers/edac/qcom_edac.c
> +++ b/drivers/edac/qcom_edac.c
> @@ -21,30 +21,9 @@
>  #define TRP_SYN_REG_CNT                 6
>  #define DRP_SYN_REG_CNT                 8
>  
> -#define LLCC_COMMON_STATUS0             0x0003000c
>  #define LLCC_LB_CNT_MASK                GENMASK(31, 28)
>  #define LLCC_LB_CNT_SHIFT               28
>  
> -/* Single & double bit syndrome register offsets */
> -#define TRP_ECC_SB_ERR_SYN0             0x0002304c
> -#define TRP_ECC_DB_ERR_SYN0             0x00020370
> -#define DRP_ECC_SB_ERR_SYN0             0x0004204c
> -#define DRP_ECC_DB_ERR_SYN0             0x00042070
> -
> -/* Error register offsets */
> -#define TRP_ECC_ERROR_STATUS1           0x00020348
> -#define TRP_ECC_ERROR_STATUS0           0x00020344
> -#define DRP_ECC_ERROR_STATUS1           0x00042048
> -#define DRP_ECC_ERROR_STATUS0           0x00042044
> -
> -/* TRP, DRP interrupt register offsets */
> -#define DRP_INTERRUPT_STATUS            0x00041000
> -#define TRP_INTERRUPT_0_STATUS          0x00020480
> -#define DRP_INTERRUPT_CLEAR             0x00041008
> -#define DRP_ECC_ERROR_CNTR_CLEAR        0x00040004
> -#define TRP_INTERRUPT_0_CLEAR           0x00020484
> -#define TRP_ECC_ERROR_CNTR_CLEAR        0x00020440
> -
>  /* Mask and shift macros */
>  #define ECC_DB_ERR_COUNT_MASK           GENMASK(4, 0)
>  #define ECC_DB_ERR_WAYS_MASK            GENMASK(31, 16)
> @@ -60,15 +39,6 @@
>  #define DRP_TRP_INT_CLEAR               GENMASK(1, 0)
>  #define DRP_TRP_CNT_CLEAR               GENMASK(1, 0)
>  
> -/* Config registers offsets*/
> -#define DRP_ECC_ERROR_CFG               0x00040000
> -
> -/* Tag RAM, Data RAM interrupt register offsets */
> -#define CMN_INTERRUPT_0_ENABLE          0x0003001c
> -#define CMN_INTERRUPT_2_ENABLE          0x0003003c
> -#define TRP_INTERRUPT_0_ENABLE          0x00020488
> -#define DRP_INTERRUPT_ENABLE            0x0004100c
> -
>  #define SB_ERROR_THRESHOLD              0x1
>  #define SB_ERROR_THRESHOLD_SHIFT        24
>  #define SB_DB_TRP_INTERRUPT_ENABLE      0x3
> @@ -86,9 +56,6 @@ enum {
>  static const struct llcc_edac_reg_data edac_reg_data[] = {
>  	[LLCC_DRAM_CE] = {
>  		.name = "DRAM Single-bit",
> -		.synd_reg = DRP_ECC_SB_ERR_SYN0,
> -		.count_status_reg = DRP_ECC_ERROR_STATUS1,
> -		.ways_status_reg = DRP_ECC_ERROR_STATUS0,
>  		.reg_cnt = DRP_SYN_REG_CNT,
>  		.count_mask = ECC_SB_ERR_COUNT_MASK,
>  		.ways_mask = ECC_SB_ERR_WAYS_MASK,
> @@ -96,9 +63,6 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
>  	},
>  	[LLCC_DRAM_UE] = {
>  		.name = "DRAM Double-bit",
> -		.synd_reg = DRP_ECC_DB_ERR_SYN0,
> -		.count_status_reg = DRP_ECC_ERROR_STATUS1,
> -		.ways_status_reg = DRP_ECC_ERROR_STATUS0,
>  		.reg_cnt = DRP_SYN_REG_CNT,
>  		.count_mask = ECC_DB_ERR_COUNT_MASK,
>  		.ways_mask = ECC_DB_ERR_WAYS_MASK,
> @@ -106,9 +70,6 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
>  	},
>  	[LLCC_TRAM_CE] = {
>  		.name = "TRAM Single-bit",
> -		.synd_reg = TRP_ECC_SB_ERR_SYN0,
> -		.count_status_reg = TRP_ECC_ERROR_STATUS1,
> -		.ways_status_reg = TRP_ECC_ERROR_STATUS0,
>  		.reg_cnt = TRP_SYN_REG_CNT,
>  		.count_mask = ECC_SB_ERR_COUNT_MASK,
>  		.ways_mask = ECC_SB_ERR_WAYS_MASK,
> @@ -116,9 +77,6 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
>  	},
>  	[LLCC_TRAM_UE] = {
>  		.name = "TRAM Double-bit",
> -		.synd_reg = TRP_ECC_DB_ERR_SYN0,
> -		.count_status_reg = TRP_ECC_ERROR_STATUS1,
> -		.ways_status_reg = TRP_ECC_ERROR_STATUS0,
>  		.reg_cnt = TRP_SYN_REG_CNT,
>  		.count_mask = ECC_DB_ERR_COUNT_MASK,
>  		.ways_mask = ECC_DB_ERR_WAYS_MASK,
> @@ -126,7 +84,7 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
>  	},
>  };
>  
> -static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
> +static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_bcast_regmap)
>  {
>  	u32 sb_err_threshold;
>  	int ret;
> @@ -135,31 +93,31 @@ static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
>  	 * Configure interrupt enable registers such that Tag, Data RAM related
>  	 * interrupts are propagated to interrupt controller for servicing
>  	 */
> -	ret = regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENABLE,
> +	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
>  				 TRP0_INTERRUPT_ENABLE,
>  				 TRP0_INTERRUPT_ENABLE);
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_update_bits(llcc_bcast_regmap, TRP_INTERRUPT_0_ENABLE,
> +	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->trp_interrupt_0_enable,
>  				 SB_DB_TRP_INTERRUPT_ENABLE,
>  				 SB_DB_TRP_INTERRUPT_ENABLE);
>  	if (ret)
>  		return ret;
>  
>  	sb_err_threshold = (SB_ERROR_THRESHOLD << SB_ERROR_THRESHOLD_SHIFT);
> -	ret = regmap_write(llcc_bcast_regmap, DRP_ECC_ERROR_CFG,
> +	ret = regmap_write(llcc_bcast_regmap, drv->edac_reg_offset->drp_ecc_error_cfg,
>  			   sb_err_threshold);
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENABLE,
> +	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
>  				 DRP0_INTERRUPT_ENABLE,
>  				 DRP0_INTERRUPT_ENABLE);
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_write(llcc_bcast_regmap, DRP_INTERRUPT_ENABLE,
> +	ret = regmap_write(llcc_bcast_regmap, drv->edac_reg_offset->drp_interrupt_enable,
>  			   SB_DB_DRP_INTERRUPT_ENABLE);
>  	return ret;
>  }
> @@ -173,24 +131,28 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
>  	switch (err_type) {
>  	case LLCC_DRAM_CE:
>  	case LLCC_DRAM_UE:
> -		ret = regmap_write(drv->bcast_regmap, DRP_INTERRUPT_CLEAR,
> +		ret = regmap_write(drv->bcast_regmap,
> +				   drv->edac_reg_offset->drp_interrupt_clear,
>  				   DRP_TRP_INT_CLEAR);
>  		if (ret)
>  			return ret;
>  
> -		ret = regmap_write(drv->bcast_regmap, DRP_ECC_ERROR_CNTR_CLEAR,
> +		ret = regmap_write(drv->bcast_regmap,
> +				   drv->edac_reg_offset->drp_ecc_error_cntr_clear,
>  				   DRP_TRP_CNT_CLEAR);
>  		if (ret)
>  			return ret;
>  		break;
>  	case LLCC_TRAM_CE:
>  	case LLCC_TRAM_UE:
> -		ret = regmap_write(drv->bcast_regmap, TRP_INTERRUPT_0_CLEAR,
> +		ret = regmap_write(drv->bcast_regmap,
> +				   drv->edac_reg_offset->trp_interrupt_0_clear,
>  				   DRP_TRP_INT_CLEAR);
>  		if (ret)
>  			return ret;
>  
> -		ret = regmap_write(drv->bcast_regmap, TRP_ECC_ERROR_CNTR_CLEAR,
> +		ret = regmap_write(drv->bcast_regmap,
> +				   drv->edac_reg_offset->trp_ecc_error_cntr_clear,
>  				   DRP_TRP_CNT_CLEAR);
>  		if (ret)
>  			return ret;
> @@ -203,16 +165,54 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
>  	return ret;
>  }
>  
> +struct qcom_llcc_syn_regs {
> +	u32 synd_reg;
> +	u32 count_status_reg;
> +	u32 ways_status_reg;
> +};
> +
> +static void get_reg_offsets(struct llcc_drv_data *drv, int err_type,
> +			    struct qcom_llcc_syn_regs *syn_regs)
> +{
> +	const struct llcc_edac_reg_offset *edac_reg_offset = drv->edac_reg_offset;
> +
> +	switch (err_type) {
> +	case LLCC_DRAM_CE:
> +		syn_regs->synd_reg = edac_reg_offset->drp_ecc_sb_err_syn0;
> +		syn_regs->count_status_reg = edac_reg_offset->drp_ecc_error_status1;
> +		syn_regs->ways_status_reg = edac_reg_offset->drp_ecc_error_status0;
> +		break;
> +	case LLCC_DRAM_UE:
> +		syn_regs->synd_reg = edac_reg_offset->drp_ecc_db_err_syn0;
> +		syn_regs->count_status_reg = edac_reg_offset->drp_ecc_error_status1;
> +		syn_regs->ways_status_reg = edac_reg_offset->drp_ecc_error_status0;
> +		break;
> +	case LLCC_TRAM_CE:
> +		syn_regs->synd_reg = edac_reg_offset->trp_ecc_sb_err_syn0;
> +		syn_regs->count_status_reg = edac_reg_offset->trp_ecc_error_status1;
> +		syn_regs->ways_status_reg = edac_reg_offset->trp_ecc_error_status0;
> +		break;
> +	case LLCC_TRAM_UE:
> +		syn_regs->synd_reg = edac_reg_offset->trp_ecc_db_err_syn0;
> +		syn_regs->count_status_reg = edac_reg_offset->trp_ecc_error_status1;
> +		syn_regs->ways_status_reg = edac_reg_offset->trp_ecc_error_status0;
> +		break;
> +	}
> +}
> +
>  /* Dump Syndrome registers data for Tag RAM, Data RAM bit errors*/
>  static int
>  dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
>  {
>  	struct llcc_edac_reg_data reg_data = edac_reg_data[err_type];
> +	struct qcom_llcc_syn_regs regs = { };
>  	int err_cnt, err_ways, ret, i;
>  	u32 synd_reg, synd_val;
>  
> +	get_reg_offsets(drv, err_type, &regs);
> +
>  	for (i = 0; i < reg_data.reg_cnt; i++) {
> -		synd_reg = reg_data.synd_reg + (i * 4);
> +		synd_reg = regs.synd_reg + (i * 4);
>  		ret = regmap_read(drv->regmap, drv->offsets[bank] + synd_reg,
>  				  &synd_val);
>  		if (ret)
> @@ -223,7 +223,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
>  	}
>  
>  	ret = regmap_read(drv->regmap,
> -			  drv->offsets[bank] + reg_data.count_status_reg,
> +			  drv->offsets[bank] + regs.count_status_reg,
>  			  &err_cnt);
>  	if (ret)
>  		goto clear;
> @@ -234,7 +234,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
>  		    reg_data.name, err_cnt);
>  
>  	ret = regmap_read(drv->regmap,
> -			  drv->offsets[bank] + reg_data.ways_status_reg,
> +			  drv->offsets[bank] + regs.ways_status_reg,
>  			  &err_ways);
>  	if (ret)
>  		goto clear;
> @@ -297,7 +297,7 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
>  	/* Iterate over the banks and look for Tag RAM or Data RAM errors */
>  	for (i = 0; i < drv->num_banks; i++) {
>  		ret = regmap_read(drv->regmap,
> -				  drv->offsets[i] + DRP_INTERRUPT_STATUS,
> +				  drv->offsets[i] + drv->edac_reg_offset->drp_interrupt_status,
>  				  &drp_error);
>  
>  		if (!ret && (drp_error & SB_ECC_ERROR)) {
> @@ -313,7 +313,7 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
>  			irq_rc = IRQ_HANDLED;
>  
>  		ret = regmap_read(drv->regmap,
> -				  drv->offsets[i] + TRP_INTERRUPT_0_STATUS,
> +				  drv->offsets[i] + drv->edac_reg_offset->trp_interrupt_0_status,
>  				  &trp_error);
>  
>  		if (!ret && (trp_error & SB_ECC_ERROR)) {
> @@ -340,7 +340,7 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
>  	int ecc_irq;
>  	int rc;
>  
> -	rc = qcom_llcc_core_setup(llcc_driv_data->bcast_regmap);
> +	rc = qcom_llcc_core_setup(llcc_driv_data, llcc_driv_data->bcast_regmap);
>  	if (rc)
>  		return rc;
>  
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> index bc2fb8343a94..d5b2d58e8857 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -57,9 +57,6 @@ struct llcc_slice_desc {
>  /**
>   * struct llcc_edac_reg_data - llcc edac registers data for each error type
>   * @name: Name of the error
> - * @synd_reg: Syndrome register address
> - * @count_status_reg: Status register address to read the error count
> - * @ways_status_reg: Status register address to read the error ways
>   * @reg_cnt: Number of registers
>   * @count_mask: Mask value to get the error count
>   * @ways_mask: Mask value to get the error ways
> @@ -68,9 +65,6 @@ struct llcc_slice_desc {
>   */
>  struct llcc_edac_reg_data {
>  	char *name;
> -	u64 synd_reg;
> -	u64 count_status_reg;
> -	u64 ways_status_reg;
>  	u32 reg_cnt;
>  	u32 count_mask;
>  	u32 ways_mask;
> -- 
> 2.25.1
> 
