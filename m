Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8704958FA7A
	for <lists+linux-edac@lfdr.de>; Thu, 11 Aug 2022 12:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbiHKKJ4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Aug 2022 06:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiHKKJr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Aug 2022 06:09:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD279352A
        for <linux-edac@vger.kernel.org>; Thu, 11 Aug 2022 03:09:40 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id g13so9613712plo.6
        for <linux-edac@vger.kernel.org>; Thu, 11 Aug 2022 03:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Aj7bIRpBxLE/QbhIHFv2D/FvUghNvupNjdDm/EaW0wk=;
        b=DYDleXwOCYrNafDo5GTknws4qyaWdcZJC5pHMUT6MxD8vLe9dzIv0p5VcCtKAP5NrD
         IOR/4nX6nmc0lHwH7I0gC2+RpzpMmGgF+f4HsAQQNL91gbmXuuhEph1cbfwrK7IZ1BpC
         FutezzNK7GKH5Y5N56WKJAdkxbrWH/RL74Yh0N++x1tH5idG/pkA/JspCYc+4ci8cd11
         1CTU2301kFtSPkNLUXA0fjEqUrNetZwDRrBP8urvs9WBNTDuG6HgknuV37c4mn8iVLRS
         mImomnsYdW7fvliKsGe7LmyTpjJkHoLtt/f+jSybyV7zx/q/iCHdRkviC0xhgABbm6Js
         dIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Aj7bIRpBxLE/QbhIHFv2D/FvUghNvupNjdDm/EaW0wk=;
        b=FMdwbWScmtMrz4iLQ1Pd9L6trQuoRPO9SJqmYIpK5q2PtKDz9cq/qCK3TqHEuvyFGg
         3VXL5f+EVgiTYRwnuUMg12pHO2FLYSpaFupP3Jk0wr7TMFR6Vt93kZ8yWFjokzL1OiYD
         JtwztXV53c9AANCEkEBmlYgMWM1Jfn89QpFLH22E1jFaqE4iLcHPZYm97PQPGrad7xp7
         T0Wm/QgHYvOczffAHCp7ARbD1VSWZ6rzTBYItfrm+8u0ZmNAJhbd2TFwp8b8Cpq8zR2y
         Xp/cKWkftc0/iAu4O9EkVb58LuKwE5grYcf+FHMyw91SRwY8vT4x1Lvo2zBoZvaWJTP6
         7hBQ==
X-Gm-Message-State: ACgBeo13afZ3orB84RmD+IyWWdlGX3NAma1NEM0oPgI4RCTkdGNK4Jsx
        XgYeuESiVSRtNv6hC5ijEpeDHlvKF1L1
X-Google-Smtp-Source: AA6agR5urAjbeR+oCpeOsDAG3lUolXvFDjzepvOgGtvARILTv9Et4w7Z6k7r7s0KasDqImWeJEh2cQ==
X-Received: by 2002:a17:90a:bb96:b0:1f4:414a:d89e with SMTP id v22-20020a17090abb9600b001f4414ad89emr8230563pjr.240.1660212579470;
        Thu, 11 Aug 2022 03:09:39 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.103])
        by smtp.gmail.com with ESMTPSA id 1-20020a621501000000b0052b9351737fsm3714839pfv.92.2022.08.11.03.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 03:09:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org, ckadabi@quicinc.com,
        vnkgutta@quicinc.com, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] soc: qcom: llcc: Pass SoC specific EDAC register offsets to EDAC driver
Date:   Thu, 11 Aug 2022 15:39:23 +0530
Message-Id: <20220811100924.79505-2-manivannan.sadhasivam@linaro.org>
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

The LLCC EDAC register offsets varies between each SoCs. Until now, the
EDAC driver used the hardcoded register offsets. But this caused crash
on SM8450 SoC where the register offsets has been changed.

So to avoid this crash and also to make it easy to accommodate changes for
new SoCs, let's pass the SoC specific register offsets to the EDAC driver.

Currently, two set of offsets are used. One is SM8450 specific and another
one is common to all SoCs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/soc/qcom/llcc-qcom.c | 64 ++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index eecafeded56f..1aedbbb8e96f 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -104,6 +104,7 @@ struct qcom_llcc_config {
 	int size;
 	bool need_llcc_cfg;
 	const u32 *reg_offset;
+	const struct llcc_edac_reg *edac_reg;
 };
 
 enum llcc_reg_offset {
@@ -252,6 +253,60 @@ static const struct llcc_slice_config sm8450_data[] =  {
 	{LLCC_AENPU,     8, 2048, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0 },
 };
 
+static const struct llcc_edac_reg common_edac_reg = {
+	.trp_ecc_error_status0 = 0x20344,
+	.trp_ecc_error_status1 = 0x20348,
+	.trp_ecc_sb_err_syn0 = 0x2304c,
+	.trp_ecc_db_err_syn0 = 0x20370,
+	.trp_ecc_error_cntr_clear = 0x20440,
+	.trp_interrupt_0_status = 0x20480,
+	.trp_interrupt_0_clear = 0x20484,
+	.trp_interrupt_0_enable = 0x20488,
+
+	/* LLCC Common registers */
+	.cmn_status0 = 0x3000c,
+	.cmn_interrupt_0_enable = 0x3001c,
+	.cmn_interrupt_2_enable = 0x3003c,
+
+	/* LLCC DRP registers */
+	.drp_ecc_error_cfg = 0x40000,
+	.drp_ecc_error_cntr_clear = 0x40004,
+	.drp_interrupt_status = 0x41000,
+	.drp_interrupt_clear = 0x41008,
+	.drp_interrupt_enable = 0x4100c,
+	.drp_ecc_error_status0 = 0x42044,
+	.drp_ecc_error_status1 = 0x42048,
+	.drp_ecc_sb_err_syn0 = 0x4204c,
+	.drp_ecc_db_err_syn0 = 0x42070,
+};
+
+static const struct llcc_edac_reg sm8450_edac_reg = {
+	.trp_ecc_error_status0 = 0x20344,
+	.trp_ecc_error_status1 = 0x20348,
+	.trp_ecc_sb_err_syn0 = 0x2034c,
+	.trp_ecc_db_err_syn0 = 0x20370,
+	.trp_ecc_error_cntr_clear = 0x20440,
+	.trp_interrupt_0_status = 0x20480,
+	.trp_interrupt_0_clear = 0x20484,
+	.trp_interrupt_0_enable = 0x20488,
+
+	/* LLCC Common registers */
+	.cmn_status0 = 0x3400c,
+	.cmn_interrupt_0_enable = 0x3401c,
+	.cmn_interrupt_2_enable = 0x3403c,
+
+	/* LLCC DRP registers */
+	.drp_ecc_error_cfg = 0x50000,
+	.drp_ecc_error_cntr_clear = 0x50004,
+	.drp_interrupt_status = 0x50020,
+	.drp_interrupt_clear = 0x50028,
+	.drp_interrupt_enable = 0x5002c,
+	.drp_ecc_error_status0 = 0x520f4,
+	.drp_ecc_error_status1 = 0x520f8,
+	.drp_ecc_sb_err_syn0 = 0x520fc,
+	.drp_ecc_db_err_syn0 = 0x52120,
+};
+
 static const u32 llcc_v1_2_reg_offset[] = {
 	[LLCC_COMMON_HW_INFO]	= 0x00030000,
 	[LLCC_COMMON_STATUS0]	= 0x0003000c,
@@ -267,6 +322,7 @@ static const struct qcom_llcc_config sc7180_cfg = {
 	.size		= ARRAY_SIZE(sc7180_data),
 	.need_llcc_cfg	= true,
 	.reg_offset	= llcc_v1_2_reg_offset,
+	.edac_reg	= &common_edac_reg,
 };
 
 static const struct qcom_llcc_config sc7280_cfg = {
@@ -274,6 +330,7 @@ static const struct qcom_llcc_config sc7280_cfg = {
 	.size		= ARRAY_SIZE(sc7280_data),
 	.need_llcc_cfg	= true,
 	.reg_offset	= llcc_v1_2_reg_offset,
+	.edac_reg	= &common_edac_reg,
 };
 
 static const struct qcom_llcc_config sdm845_cfg = {
@@ -281,6 +338,7 @@ static const struct qcom_llcc_config sdm845_cfg = {
 	.size		= ARRAY_SIZE(sdm845_data),
 	.need_llcc_cfg	= false,
 	.reg_offset	= llcc_v1_2_reg_offset,
+	.edac_reg	= &common_edac_reg,
 };
 
 static const struct qcom_llcc_config sm6350_cfg = {
@@ -288,6 +346,7 @@ static const struct qcom_llcc_config sm6350_cfg = {
 	.size		= ARRAY_SIZE(sm6350_data),
 	.need_llcc_cfg	= true,
 	.reg_offset	= llcc_v1_2_reg_offset,
+	.edac_reg	= &common_edac_reg,
 };
 
 static const struct qcom_llcc_config sm8150_cfg = {
@@ -295,6 +354,7 @@ static const struct qcom_llcc_config sm8150_cfg = {
 	.size           = ARRAY_SIZE(sm8150_data),
 	.need_llcc_cfg	= true,
 	.reg_offset	= llcc_v1_2_reg_offset,
+	.edac_reg	= &common_edac_reg,
 };
 
 static const struct qcom_llcc_config sm8250_cfg = {
@@ -302,6 +362,7 @@ static const struct qcom_llcc_config sm8250_cfg = {
 	.size           = ARRAY_SIZE(sm8250_data),
 	.need_llcc_cfg	= true,
 	.reg_offset	= llcc_v1_2_reg_offset,
+	.edac_reg	= &common_edac_reg,
 };
 
 static const struct qcom_llcc_config sm8350_cfg = {
@@ -309,6 +370,7 @@ static const struct qcom_llcc_config sm8350_cfg = {
 	.size           = ARRAY_SIZE(sm8350_data),
 	.need_llcc_cfg	= true,
 	.reg_offset	= llcc_v1_2_reg_offset,
+	.edac_reg	= &common_edac_reg,
 };
 
 static const struct qcom_llcc_config sm8450_cfg = {
@@ -316,6 +378,7 @@ static const struct qcom_llcc_config sm8450_cfg = {
 	.size           = ARRAY_SIZE(sm8450_data),
 	.need_llcc_cfg	= true,
 	.reg_offset	= llcc_v21_reg_offset,
+	.edac_reg	= &sm8450_edac_reg,
 };
 
 static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
@@ -716,6 +779,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 
 	drv_data->cfg = llcc_cfg;
 	drv_data->cfg_size = sz;
+	drv_data->edac_reg = cfg->edac_reg;
 	mutex_init(&drv_data->lock);
 	platform_set_drvdata(pdev, drv_data);
 
-- 
2.25.1

