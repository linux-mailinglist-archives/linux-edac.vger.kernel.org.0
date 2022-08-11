Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0DD58FA7C
	for <lists+linux-edac@lfdr.de>; Thu, 11 Aug 2022 12:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiHKKKF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Aug 2022 06:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiHKKJu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Aug 2022 06:09:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2563CAE230
        for <linux-edac@vger.kernel.org>; Thu, 11 Aug 2022 03:09:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso4887733pjo.1
        for <linux-edac@vger.kernel.org>; Thu, 11 Aug 2022 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZUIJNubm1YFy+Fr3W8YleD6wWCQLhDtOJm9t8MCvUKg=;
        b=btqzcFs1NWW2iNyyyuTc82/vWlWUn4ex6tAFAgPh+QLgdlMjJgh0W1Y6uT7zUpFi4u
         u/AxzHm5cboe/W3FzREtfLr14ePTROtzDlhPAEr29tB/sf+S3I/yizUG2S0snkekebKU
         TYufIHH/Wwv2BHNTHui/7xGz6yjpAW8K42Q+QPy3DaVCwAKdyWH2tVAQoCTJPq5ljuSn
         vvW0kRmjwt/f/EMBlSoE4bZuoKrVYOtV3XNMifOM9aNmCXcQcofJJWPkZyiShyPv2tLr
         YRcKZ5nueUVo8Be8S11kkTjeqkNKim/BmTM3Vb+OUikUVtnJuBG/1hsFIy1xOZMP1f1d
         146A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZUIJNubm1YFy+Fr3W8YleD6wWCQLhDtOJm9t8MCvUKg=;
        b=GCszjQxCO9WQOQkw53sHi4QwTNd03/cFty21N2TXOuYybgCJfgN0kSGcPp22Wn+oKT
         e3z9o8wRoK8SMstt2GuloIlxLu6Sh94RvS5wU0gn6poBlJhGSZsWfqLDg5Msg0INwsD3
         OQrgMW6t9dtduC9WGh3aA91vscpKLMABozBPoyGSgJZbO8m+ngg025a+oBgZi/pYfChY
         0LUf5Yx6xxzFfHNzIrkl+55I5XqSYikIqW8kkyDjsPfEwohOx/UNFtJD+xlfWt7jfUYq
         8OACaiBgeKxlbJza9tjF4FQxs354CHzZr2AGE6GfPIomIt+fAJBw14TF2sBFHo5AVf6/
         A5oQ==
X-Gm-Message-State: ACgBeo0GldpstRcT+Q7pIwZHKGr6yC9rBKYy75zJ7V7BJJt4JLucNH2y
        vnH0Os/bUg3YZl7nRBwvmcgxB+AVeEyD
X-Google-Smtp-Source: AA6agR6yH8f8Wltf1MiPbwI9awCDq+qghqNdxLGsnYm54Dmbi7ghO1R44tzny/akQUSkC318S9e0Sw==
X-Received: by 2002:a17:902:6b0c:b0:171:325a:364e with SMTP id o12-20020a1709026b0c00b00171325a364emr8002660plk.150.1660212584184;
        Thu, 11 Aug 2022 03:09:44 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.103])
        by smtp.gmail.com with ESMTPSA id 1-20020a621501000000b0052b9351737fsm3714839pfv.92.2022.08.11.03.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 03:09:43 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org, ckadabi@quicinc.com,
        vnkgutta@quicinc.com, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] EDAC/qcom: Get rid of hardcoded register offsets
Date:   Thu, 11 Aug 2022 15:39:24 +0530
Message-Id: <20220811100924.79505-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811100924.79505-1-manivannan.sadhasivam@linaro.org>
References: <20220811100924.79505-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The LLCC EDAC register offsets varies between each SoC. Hardcoding the
register offsets won't work and will often result in crash due to
accessing the wrong locations.

Hence, get the register offsets from the LLCC driver matching the
individual SoCs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c           | 112 ++++++++++++++---------------
 include/linux/soc/qcom/llcc-qcom.h |  35 +++++++--
 2 files changed, 83 insertions(+), 64 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 97a27e42dd61..500360cc5258 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -21,30 +21,9 @@
 #define TRP_SYN_REG_CNT                 6
 #define DRP_SYN_REG_CNT                 8
 
-#define LLCC_COMMON_STATUS0             0x0003000c
 #define LLCC_LB_CNT_MASK                GENMASK(31, 28)
 #define LLCC_LB_CNT_SHIFT               28
 
-/* Single & double bit syndrome register offsets */
-#define TRP_ECC_SB_ERR_SYN0             0x0002304c
-#define TRP_ECC_DB_ERR_SYN0             0x00020370
-#define DRP_ECC_SB_ERR_SYN0             0x0004204c
-#define DRP_ECC_DB_ERR_SYN0             0x00042070
-
-/* Error register offsets */
-#define TRP_ECC_ERROR_STATUS1           0x00020348
-#define TRP_ECC_ERROR_STATUS0           0x00020344
-#define DRP_ECC_ERROR_STATUS1           0x00042048
-#define DRP_ECC_ERROR_STATUS0           0x00042044
-
-/* TRP, DRP interrupt register offsets */
-#define DRP_INTERRUPT_STATUS            0x00041000
-#define TRP_INTERRUPT_0_STATUS          0x00020480
-#define DRP_INTERRUPT_CLEAR             0x00041008
-#define DRP_ECC_ERROR_CNTR_CLEAR        0x00040004
-#define TRP_INTERRUPT_0_CLEAR           0x00020484
-#define TRP_ECC_ERROR_CNTR_CLEAR        0x00020440
-
 /* Mask and shift macros */
 #define ECC_DB_ERR_COUNT_MASK           GENMASK(4, 0)
 #define ECC_DB_ERR_WAYS_MASK            GENMASK(31, 16)
@@ -60,15 +39,6 @@
 #define DRP_TRP_INT_CLEAR               GENMASK(1, 0)
 #define DRP_TRP_CNT_CLEAR               GENMASK(1, 0)
 
-/* Config registers offsets*/
-#define DRP_ECC_ERROR_CFG               0x00040000
-
-/* Tag RAM, Data RAM interrupt register offsets */
-#define CMN_INTERRUPT_0_ENABLE          0x0003001c
-#define CMN_INTERRUPT_2_ENABLE          0x0003003c
-#define TRP_INTERRUPT_0_ENABLE          0x00020488
-#define DRP_INTERRUPT_ENABLE            0x0004100c
-
 #define SB_ERROR_THRESHOLD              0x1
 #define SB_ERROR_THRESHOLD_SHIFT        24
 #define SB_DB_TRP_INTERRUPT_ENABLE      0x3
@@ -86,9 +56,6 @@ enum {
 static const struct llcc_edac_reg_data edac_reg_data[] = {
 	[LLCC_DRAM_CE] = {
 		.name = "DRAM Single-bit",
-		.synd_reg = DRP_ECC_SB_ERR_SYN0,
-		.count_status_reg = DRP_ECC_ERROR_STATUS1,
-		.ways_status_reg = DRP_ECC_ERROR_STATUS0,
 		.reg_cnt = DRP_SYN_REG_CNT,
 		.count_mask = ECC_SB_ERR_COUNT_MASK,
 		.ways_mask = ECC_SB_ERR_WAYS_MASK,
@@ -96,9 +63,6 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
 	},
 	[LLCC_DRAM_UE] = {
 		.name = "DRAM Double-bit",
-		.synd_reg = DRP_ECC_DB_ERR_SYN0,
-		.count_status_reg = DRP_ECC_ERROR_STATUS1,
-		.ways_status_reg = DRP_ECC_ERROR_STATUS0,
 		.reg_cnt = DRP_SYN_REG_CNT,
 		.count_mask = ECC_DB_ERR_COUNT_MASK,
 		.ways_mask = ECC_DB_ERR_WAYS_MASK,
@@ -106,9 +70,6 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
 	},
 	[LLCC_TRAM_CE] = {
 		.name = "TRAM Single-bit",
-		.synd_reg = TRP_ECC_SB_ERR_SYN0,
-		.count_status_reg = TRP_ECC_ERROR_STATUS1,
-		.ways_status_reg = TRP_ECC_ERROR_STATUS0,
 		.reg_cnt = TRP_SYN_REG_CNT,
 		.count_mask = ECC_SB_ERR_COUNT_MASK,
 		.ways_mask = ECC_SB_ERR_WAYS_MASK,
@@ -116,9 +77,6 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
 	},
 	[LLCC_TRAM_UE] = {
 		.name = "TRAM Double-bit",
-		.synd_reg = TRP_ECC_DB_ERR_SYN0,
-		.count_status_reg = TRP_ECC_ERROR_STATUS1,
-		.ways_status_reg = TRP_ECC_ERROR_STATUS0,
 		.reg_cnt = TRP_SYN_REG_CNT,
 		.count_mask = ECC_DB_ERR_COUNT_MASK,
 		.ways_mask = ECC_DB_ERR_WAYS_MASK,
@@ -126,7 +84,7 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
 	},
 };
 
-static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
+static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_bcast_regmap)
 {
 	u32 sb_err_threshold;
 	int ret;
@@ -135,31 +93,31 @@ static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
 	 * Configure interrupt enable registers such that Tag, Data RAM related
 	 * interrupts are propagated to interrupt controller for servicing
 	 */
-	ret = regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENABLE,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg->cmn_interrupt_2_enable,
 				 TRP0_INTERRUPT_ENABLE,
 				 TRP0_INTERRUPT_ENABLE);
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(llcc_bcast_regmap, TRP_INTERRUPT_0_ENABLE,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg->trp_interrupt_0_enable,
 				 SB_DB_TRP_INTERRUPT_ENABLE,
 				 SB_DB_TRP_INTERRUPT_ENABLE);
 	if (ret)
 		return ret;
 
 	sb_err_threshold = (SB_ERROR_THRESHOLD << SB_ERROR_THRESHOLD_SHIFT);
-	ret = regmap_write(llcc_bcast_regmap, DRP_ECC_ERROR_CFG,
+	ret = regmap_write(llcc_bcast_regmap, drv->edac_reg->drp_ecc_error_cfg,
 			   sb_err_threshold);
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENABLE,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg->cmn_interrupt_2_enable,
 				 DRP0_INTERRUPT_ENABLE,
 				 DRP0_INTERRUPT_ENABLE);
 	if (ret)
 		return ret;
 
-	ret = regmap_write(llcc_bcast_regmap, DRP_INTERRUPT_ENABLE,
+	ret = regmap_write(llcc_bcast_regmap, drv->edac_reg->drp_interrupt_enable,
 			   SB_DB_DRP_INTERRUPT_ENABLE);
 	return ret;
 }
@@ -173,24 +131,24 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 	switch (err_type) {
 	case LLCC_DRAM_CE:
 	case LLCC_DRAM_UE:
-		ret = regmap_write(drv->bcast_regmap, DRP_INTERRUPT_CLEAR,
+		ret = regmap_write(drv->bcast_regmap, drv->edac_reg->drp_interrupt_clear,
 				   DRP_TRP_INT_CLEAR);
 		if (ret)
 			return ret;
 
-		ret = regmap_write(drv->bcast_regmap, DRP_ECC_ERROR_CNTR_CLEAR,
+		ret = regmap_write(drv->bcast_regmap, drv->edac_reg->drp_ecc_error_cntr_clear,
 				   DRP_TRP_CNT_CLEAR);
 		if (ret)
 			return ret;
 		break;
 	case LLCC_TRAM_CE:
 	case LLCC_TRAM_UE:
-		ret = regmap_write(drv->bcast_regmap, TRP_INTERRUPT_0_CLEAR,
+		ret = regmap_write(drv->bcast_regmap, drv->edac_reg->trp_interrupt_0_clear,
 				   DRP_TRP_INT_CLEAR);
 		if (ret)
 			return ret;
 
-		ret = regmap_write(drv->bcast_regmap, TRP_ECC_ERROR_CNTR_CLEAR,
+		ret = regmap_write(drv->bcast_regmap, drv->edac_reg->trp_ecc_error_cntr_clear,
 				   DRP_TRP_CNT_CLEAR);
 		if (ret)
 			return ret;
@@ -203,16 +161,54 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 	return ret;
 }
 
+struct qcom_llcc_syn_regs {
+	u32 synd_reg;
+	u32 count_status_reg;
+	u32 ways_status_reg;
+};
+
+static void get_reg_offsets(struct llcc_drv_data *drv, int err_type,
+			    struct qcom_llcc_syn_regs *syn_regs)
+{
+	const struct llcc_edac_reg *edac_reg = drv->edac_reg;
+
+	switch (err_type) {
+	case LLCC_DRAM_CE:
+		syn_regs->synd_reg = edac_reg->drp_ecc_sb_err_syn0;
+		syn_regs->count_status_reg = edac_reg->drp_ecc_error_status1;
+		syn_regs->ways_status_reg = edac_reg->drp_ecc_error_status0;
+		break;
+	case LLCC_DRAM_UE:
+		syn_regs->synd_reg = edac_reg->drp_ecc_db_err_syn0;
+		syn_regs->count_status_reg = edac_reg->drp_ecc_error_status1;
+		syn_regs->ways_status_reg = edac_reg->drp_ecc_error_status0;
+		break;
+	case LLCC_TRAM_CE:
+		syn_regs->synd_reg = edac_reg->trp_ecc_sb_err_syn0;
+		syn_regs->count_status_reg = edac_reg->trp_ecc_error_status1;
+		syn_regs->ways_status_reg = edac_reg->trp_ecc_error_status0;
+		break;
+	case LLCC_TRAM_UE:
+		syn_regs->synd_reg = edac_reg->trp_ecc_db_err_syn0;
+		syn_regs->count_status_reg = edac_reg->trp_ecc_error_status1;
+		syn_regs->ways_status_reg = edac_reg->trp_ecc_error_status0;
+		break;
+	}
+}
+
 /* Dump Syndrome registers data for Tag RAM, Data RAM bit errors*/
 static int
 dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 {
 	struct llcc_edac_reg_data reg_data = edac_reg_data[err_type];
+	struct qcom_llcc_syn_regs regs = { };
 	int err_cnt, err_ways, ret, i;
 	u32 synd_reg, synd_val;
 
+	get_reg_offsets(drv, err_type, &regs);
+
 	for (i = 0; i < reg_data.reg_cnt; i++) {
-		synd_reg = reg_data.synd_reg + (i * 4);
+		synd_reg = regs.synd_reg + (i * 4);
 		ret = regmap_read(drv->regmap, drv->offsets[bank] + synd_reg,
 				  &synd_val);
 		if (ret)
@@ -223,7 +219,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 	}
 
 	ret = regmap_read(drv->regmap,
-			  drv->offsets[bank] + reg_data.count_status_reg,
+			  drv->offsets[bank] + regs.count_status_reg,
 			  &err_cnt);
 	if (ret)
 		goto clear;
@@ -234,7 +230,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 		    reg_data.name, err_cnt);
 
 	ret = regmap_read(drv->regmap,
-			  drv->offsets[bank] + reg_data.ways_status_reg,
+			  drv->offsets[bank] + regs.ways_status_reg,
 			  &err_ways);
 	if (ret)
 		goto clear;
@@ -297,7 +293,7 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
 	/* Iterate over the banks and look for Tag RAM or Data RAM errors */
 	for (i = 0; i < drv->num_banks; i++) {
 		ret = regmap_read(drv->regmap,
-				  drv->offsets[i] + DRP_INTERRUPT_STATUS,
+				  drv->offsets[i] + drv->edac_reg->drp_interrupt_status,
 				  &drp_error);
 
 		if (!ret && (drp_error & SB_ECC_ERROR)) {
@@ -313,7 +309,7 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
 			irq_rc = IRQ_HANDLED;
 
 		ret = regmap_read(drv->regmap,
-				  drv->offsets[i] + TRP_INTERRUPT_0_STATUS,
+				  drv->offsets[i] + drv->edac_reg->trp_interrupt_0_status,
 				  &trp_error);
 
 		if (!ret && (trp_error & SB_ECC_ERROR)) {
@@ -340,7 +336,7 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
 	int ecc_irq;
 	int rc;
 
-	rc = qcom_llcc_core_setup(llcc_driv_data->bcast_regmap);
+	rc = qcom_llcc_core_setup(llcc_driv_data, llcc_driv_data->bcast_regmap);
 	if (rc)
 		return rc;
 
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index 0bc21ee58fac..a36ed7ffcb28 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -55,9 +55,6 @@ struct llcc_slice_desc {
 /**
  * struct llcc_edac_reg_data - llcc edac registers data for each error type
  * @name: Name of the error
- * @synd_reg: Syndrome register address
- * @count_status_reg: Status register address to read the error count
- * @ways_status_reg: Status register address to read the error ways
  * @reg_cnt: Number of registers
  * @count_mask: Mask value to get the error count
  * @ways_mask: Mask value to get the error ways
@@ -66,9 +63,6 @@ struct llcc_slice_desc {
  */
 struct llcc_edac_reg_data {
 	char *name;
-	u64 synd_reg;
-	u64 count_status_reg;
-	u64 ways_status_reg;
 	u32 reg_cnt;
 	u32 count_mask;
 	u32 ways_mask;
@@ -76,6 +70,34 @@ struct llcc_edac_reg_data {
 	u8  ways_shift;
 };
 
+struct llcc_edac_reg {
+	/* LLCC TRP registers */
+	u32 trp_ecc_error_status0;
+	u32 trp_ecc_error_status1;
+	u32 trp_ecc_sb_err_syn0;
+	u32 trp_ecc_db_err_syn0;
+	u32 trp_ecc_error_cntr_clear;
+	u32 trp_interrupt_0_status;
+	u32 trp_interrupt_0_clear;
+	u32 trp_interrupt_0_enable;
+
+	/* LLCC Common registers */
+	u32 cmn_status0;
+	u32 cmn_interrupt_0_enable;
+	u32 cmn_interrupt_2_enable;
+
+	/* LLCC DRP registers */
+	u32 drp_ecc_error_cfg;
+	u32 drp_ecc_error_cntr_clear;
+	u32 drp_interrupt_status;
+	u32 drp_interrupt_clear;
+	u32 drp_interrupt_enable;
+	u32 drp_ecc_error_status0;
+	u32 drp_ecc_error_status1;
+	u32 drp_ecc_sb_err_syn0;
+	u32 drp_ecc_db_err_syn0;
+};
+
 /**
  * struct llcc_drv_data - Data associated with the llcc driver
  * @regmap: regmap associated with the llcc device
@@ -94,6 +116,7 @@ struct llcc_drv_data {
 	struct regmap *regmap;
 	struct regmap *bcast_regmap;
 	const struct llcc_slice_config *cfg;
+	const struct llcc_edac_reg *edac_reg;
 	struct mutex lock;
 	u32 cfg_size;
 	u32 max_slices;
-- 
2.25.1

