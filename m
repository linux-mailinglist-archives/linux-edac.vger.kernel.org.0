Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BC3657438
	for <lists+linux-edac@lfdr.de>; Wed, 28 Dec 2022 09:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiL1IoK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Dec 2022 03:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiL1InP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Dec 2022 03:43:15 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D162EE
        for <linux-edac@vger.kernel.org>; Wed, 28 Dec 2022 00:42:36 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id m4so15484260pls.4
        for <linux-edac@vger.kernel.org>; Wed, 28 Dec 2022 00:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65hsAFSVLExCXYMDq8UQxFyuNWWlmEvo8D8bnHIehrE=;
        b=SsGfrkqinhbP8boq94X/MdsdinZz5T1nd1Zk62Ks/s97gNdsRa7p/R3tbYrDNIIHln
         gGgTvXij3GB+Xw0f2/ELmpPR7SiJ9M1MDvEYE87tm8n29J03+MSWMVZ6cf6wP3MDL+/s
         uAUkCbK1289tWlPYxpVAioLLPaHf/wwbY92ueeAjDyl4v2qo9RUkMqmSmPQM7sBSGf/5
         XAN9HcTN7ZI+JaYilCILDRtqVFG7kfmIocdPo6ZG7c/kCcESqrsLLK1kHNOW7rcdoVF6
         3BySnukO5b+th2813ItZgFMv9zuRRMn7svbVmbtukx3wd/vQd0BHcRFNbbvR8oJGu8xM
         Rs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65hsAFSVLExCXYMDq8UQxFyuNWWlmEvo8D8bnHIehrE=;
        b=QRo1QmsyQeeao4gRYQSoBer1KDdEst4SaPjiHX7bu8Ufr1WFYSnewrMrD4+JhUKYeI
         GEgNRJ91ypw8VwaVX6ZdDVMpa0R83cVnpQi5Iumauo/n+EN1G/TYONmCYhbr4qchXaik
         9uAUPq5/3pSXQStoVvnalobVaCxifwEpyi//+jCQVTLsgv9RHlDwikCoRw97tdc5CmD6
         ocCBkFIhD95AULXOXEV5MvFFCuCx+59nMeSsAFKWdI8/2tRZyxZiYcyfrcXPLP6leibz
         23ZLE+jk6aX/Z6CE4aik8LQLt9qbT+mLGeaNR2sEQjF2LgjaQwiFQTbx2sYExrWpDqw2
         9YdA==
X-Gm-Message-State: AFqh2kq6OtBIgwjBSXDlMQ5BUIONPp+hF6zWu9jz4MZZrM7irO220er7
        6GcUgx6bYmuglhxOdQVgzSI1
X-Google-Smtp-Source: AMrXdXuN+Av3jzzhgvLyAUT/9W6YiSkjN7kWtQWggVQdgi5GFzm3Rb6UVfCiHFuH6swcs8Op9diapA==
X-Received: by 2002:a05:6a20:4904:b0:9d:efbf:8156 with SMTP id ft4-20020a056a20490400b0009defbf8156mr40889302pzb.31.1672216955852;
        Wed, 28 Dec 2022 00:42:35 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id d188-20020a6236c5000000b0057a9b146592sm9786286pfa.186.2022.12.28.00.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:42:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 15/17] qcom: llcc/edac: Fix the base address used for accessing LLCC banks
Date:   Wed, 28 Dec 2022 14:10:26 +0530
Message-Id: <20221228084028.46528-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Qualcomm LLCC/EDAC drivers were using a fixed register stride for
accessing the (Control and Status Registers) CSRs of each LLCC bank.
This stride only works for some SoCs like SDM845 for which driver
support was initially added.

But the later SoCs use different register stride that vary between the
banks with holes in-between. So it is not possible to use a single register
stride for accessing the CSRs of each bank. By doing so could result in a
crash.

For fixing this issue, let's obtain the base address of each LLCC bank from
devicetree and get rid of the fixed stride. This also means, we no longer
need to rely on reg-names property and get the base addresses using index.

First index is LLCC bank 0 and last index is LLCC broadcast. If the SoC
supports more than one bank, then those needs to be defined in devicetree
for index from 1..N-1.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c           | 14 +++---
 drivers/soc/qcom/llcc-qcom.c       | 72 +++++++++++++++++-------------
 include/linux/soc/qcom/llcc-qcom.h |  6 +--
 3 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 3256254c3722..1d3cc1930a74 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -213,7 +213,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 
 	for (i = 0; i < reg_data.reg_cnt; i++) {
 		synd_reg = reg_data.synd_reg + (i * 4);
-		ret = regmap_read(drv->regmap, drv->offsets[bank] + synd_reg,
+		ret = regmap_read(drv->regmaps[bank], synd_reg,
 				  &synd_val);
 		if (ret)
 			goto clear;
@@ -222,8 +222,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 			    reg_data.name, i, synd_val);
 	}
 
-	ret = regmap_read(drv->regmap,
-			  drv->offsets[bank] + reg_data.count_status_reg,
+	ret = regmap_read(drv->regmaps[bank], reg_data.count_status_reg,
 			  &err_cnt);
 	if (ret)
 		goto clear;
@@ -233,8 +232,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 	edac_printk(KERN_CRIT, EDAC_LLCC, "%s: Error count: 0x%4x\n",
 		    reg_data.name, err_cnt);
 
-	ret = regmap_read(drv->regmap,
-			  drv->offsets[bank] + reg_data.ways_status_reg,
+	ret = regmap_read(drv->regmaps[bank], reg_data.ways_status_reg,
 			  &err_ways);
 	if (ret)
 		goto clear;
@@ -296,8 +294,7 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
 
 	/* Iterate over the banks and look for Tag RAM or Data RAM errors */
 	for (i = 0; i < drv->num_banks; i++) {
-		ret = regmap_read(drv->regmap,
-				  drv->offsets[i] + DRP_INTERRUPT_STATUS,
+		ret = regmap_read(drv->regmaps[i], DRP_INTERRUPT_STATUS,
 				  &drp_error);
 
 		if (!ret && (drp_error & SB_ECC_ERROR)) {
@@ -312,8 +309,7 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
 		if (!ret)
 			irq_rc = IRQ_HANDLED;
 
-		ret = regmap_read(drv->regmap,
-				  drv->offsets[i] + TRP_INTERRUPT_0_STATUS,
+		ret = regmap_read(drv->regmaps[i], TRP_INTERRUPT_0_STATUS,
 				  &trp_error);
 
 		if (!ret && (trp_error & SB_ECC_ERROR)) {
diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 23ce2f78c4ed..72f3f2a9aaa0 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -62,8 +62,6 @@
 #define LLCC_TRP_WRSC_CACHEABLE_EN    0x21f2c
 #define LLCC_TRP_ALGO_CFG8	      0x21f30
 
-#define BANK_OFFSET_STRIDE	      0x80000
-
 #define LLCC_VERSION_2_0_0_0          0x02000000
 #define LLCC_VERSION_2_1_0_0          0x02010000
 #define LLCC_VERSION_4_1_0_0          0x04010000
@@ -898,8 +896,8 @@ static int qcom_llcc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
-		const char *name)
+static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev, u8 index,
+					  const char *name)
 {
 	void __iomem *base;
 	struct regmap_config llcc_regmap_config = {
@@ -909,7 +907,7 @@ static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev,
 		.fast_io = true,
 	};
 
-	base = devm_platform_ioremap_resource_byname(pdev, name);
+	base = devm_platform_ioremap_resource(pdev, index);
 	if (IS_ERR(base))
 		return ERR_CAST(base);
 
@@ -927,6 +925,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	const struct llcc_slice_config *llcc_cfg;
 	u32 sz;
 	u32 version;
+	struct regmap *regmap;
 
 	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
 	if (!drv_data) {
@@ -934,21 +933,51 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	drv_data->regmap = qcom_llcc_init_mmio(pdev, "llcc_base");
-	if (IS_ERR(drv_data->regmap)) {
-		ret = PTR_ERR(drv_data->regmap);
+	/* Initialize the first LLCC bank regmap */
+	regmap = qcom_llcc_init_mmio(pdev, 0, "llcc0_base");
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
 		goto err;
 	}
 
-	drv_data->bcast_regmap =
-		qcom_llcc_init_mmio(pdev, "llcc_broadcast_base");
+	cfg = of_device_get_match_data(&pdev->dev);
+
+	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
+	if (ret)
+		goto err;
+
+	num_banks &= LLCC_LB_CNT_MASK;
+	num_banks >>= LLCC_LB_CNT_SHIFT;
+	drv_data->num_banks = num_banks;
+
+	drv_data->regmaps = devm_kcalloc(dev, num_banks, sizeof(*drv_data->regmaps), GFP_KERNEL);
+	if (!drv_data->regmaps) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	drv_data->regmaps[0] = regmap;
+
+	/* Initialize rest of LLCC bank regmaps */
+	for (i = 1; i < num_banks; i++) {
+		char *base = kasprintf(GFP_KERNEL, "llcc%d_base", i);
+
+		drv_data->regmaps[i] = qcom_llcc_init_mmio(pdev, i, base);
+		if (IS_ERR(drv_data->regmaps[i])) {
+			ret = PTR_ERR(drv_data->regmaps[i]);
+			kfree(base);
+			goto err;
+		}
+
+		kfree(base);
+	}
+
+	drv_data->bcast_regmap = qcom_llcc_init_mmio(pdev, i, "llcc_broadcast_base");
 	if (IS_ERR(drv_data->bcast_regmap)) {
 		ret = PTR_ERR(drv_data->bcast_regmap);
 		goto err;
 	}
 
-	cfg = of_device_get_match_data(&pdev->dev);
-
 	/* Extract version of the IP */
 	ret = regmap_read(drv_data->bcast_regmap, cfg->reg_offset[LLCC_COMMON_HW_INFO],
 			  &version);
@@ -957,15 +986,6 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 
 	drv_data->version = version;
 
-	ret = regmap_read(drv_data->regmap, cfg->reg_offset[LLCC_COMMON_STATUS0],
-			  &num_banks);
-	if (ret)
-		goto err;
-
-	num_banks &= LLCC_LB_CNT_MASK;
-	num_banks >>= LLCC_LB_CNT_SHIFT;
-	drv_data->num_banks = num_banks;
-
 	llcc_cfg = cfg->sct_data;
 	sz = cfg->size;
 
@@ -973,16 +993,6 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 		if (llcc_cfg[i].slice_id > drv_data->max_slices)
 			drv_data->max_slices = llcc_cfg[i].slice_id;
 
-	drv_data->offsets = devm_kcalloc(dev, num_banks, sizeof(u32),
-							GFP_KERNEL);
-	if (!drv_data->offsets) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	for (i = 0; i < num_banks; i++)
-		drv_data->offsets[i] = i * BANK_OFFSET_STRIDE;
-
 	drv_data->bitmap = devm_bitmap_zalloc(dev, drv_data->max_slices,
 					      GFP_KERNEL);
 	if (!drv_data->bitmap) {
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index ad1fd718169d..423220e66026 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -120,7 +120,7 @@ struct llcc_edac_reg_offset {
 
 /**
  * struct llcc_drv_data - Data associated with the llcc driver
- * @regmap: regmap associated with the llcc device
+ * @regmaps: regmaps associated with the llcc device
  * @bcast_regmap: regmap associated with llcc broadcast offset
  * @cfg: pointer to the data structure for slice configuration
  * @edac_reg_offset: Offset of the LLCC EDAC registers
@@ -129,12 +129,11 @@ struct llcc_edac_reg_offset {
  * @max_slices: max slices as read from device tree
  * @num_banks: Number of llcc banks
  * @bitmap: Bit map to track the active slice ids
- * @offsets: Pointer to the bank offsets array
  * @ecc_irq: interrupt for llcc cache error detection and reporting
  * @version: Indicates the LLCC version
  */
 struct llcc_drv_data {
-	struct regmap *regmap;
+	struct regmap **regmaps;
 	struct regmap *bcast_regmap;
 	const struct llcc_slice_config *cfg;
 	const struct llcc_edac_reg_offset *edac_reg_offset;
@@ -143,7 +142,6 @@ struct llcc_drv_data {
 	u32 max_slices;
 	u32 num_banks;
 	unsigned long *bitmap;
-	u32 *offsets;
 	int ecc_irq;
 	u32 version;
 };
-- 
2.25.1

