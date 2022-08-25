Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC545A080C
	for <lists+linux-edac@lfdr.de>; Thu, 25 Aug 2022 06:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiHYEjQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Aug 2022 00:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiHYEjP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Aug 2022 00:39:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D539D8D1
        for <linux-edac@vger.kernel.org>; Wed, 24 Aug 2022 21:39:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id io24so4220604plb.1
        for <linux-edac@vger.kernel.org>; Wed, 24 Aug 2022 21:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aWppyUtM+Ea1Sr+ncZrJMkFAdR9P7Fn07pUZ4EuIiPw=;
        b=Ohfw9I2Oi0RoWD+PbEpH6aUJtS0tOh4ruoTJ4LwFKthdU9FnM4DnqiOFIYjiDnyExl
         43c4oIGrwWmSQXC1Dy3mgBUAcP+wxzg4hW51gN2+B1M1ED91k63HuMEgKmzxnLPIVbLA
         5+gqqdt0+75xUdDI3VX9LT6cC86s1dOL7HVT/frF22b3NLT3kANaBcKm45urvmNCgli0
         h33NBqk6YCd28ABUllGtvgcE/Id/ZelpWwZngTmBzrQxq4bv8ZucdpS13Lw5kuGNNLGI
         Wn+Q/CdSfmUsVE9WCuxIZf51bEhWefioc8IsY9uG3LfY7VMzjpEoF0bo/98cWuHpR1Ja
         6cDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aWppyUtM+Ea1Sr+ncZrJMkFAdR9P7Fn07pUZ4EuIiPw=;
        b=GANYlmw4JFMU/XeHxbgBa6GMBLqmotv2CdGpJ09PKFzzABK9gSHE5dzAK5jKWAl3zB
         9FApEP9x+XloER/KCdhOZS6pTF4oLagqmzdI5FuAWRF/LXV1gCt0GNk7gZoSU81zpFhQ
         342+/wisTdDLD5JZgLNkNa4Kwo/Aebg9bN9yIKHZVN7pECnq9VO1b0PRrtL+eWG+/wH9
         wY7VSyezaH3nhJV/uPmm8R5I4E8oOS4/KEf3NV5VhqhbQ9r5vIJEi03GKliaTQl2lads
         OoZI3m4EsxrmFUO+ITIu6YtcGvzDGq2JFrHjAMlPyud0Td/K9LXHOP42Z7j68/ikCTgx
         uwOw==
X-Gm-Message-State: ACgBeo3v2SfSjIQYMlulXphufjeNldCWKrX36EP+l36Gu/XOA+8fUxx2
        14I+exEU5yFJq9j1nApNmQUz
X-Google-Smtp-Source: AA6agR7YwTO3FKw89YVvxmLuWLLsTUs4qM9Z8BTuTggXyxmIU27IIrbZFX/+YFTP/wGkSus9OGLRfQ==
X-Received: by 2002:a17:903:245:b0:16f:85be:f33b with SMTP id j5-20020a170903024500b0016f85bef33bmr2214611plh.96.1661402353840;
        Wed, 24 Aug 2022 21:39:13 -0700 (PDT)
Received: from localhost.localdomain ([117.207.24.28])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090a64cb00b001fa9f86f20csm2294296pjm.49.2022.08.24.21.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 21:39:13 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_saipraka@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/5] soc: qcom: llcc: Rename reg_offset structs to reflect LLCC version
Date:   Thu, 25 Aug 2022 10:08:55 +0530
Message-Id: <20220825043859.30066-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
References: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The register offsets used by the LLCC block retains its layout for multiple
versions. For instance, starting from version v1.0.0 to v2.0.1 the offsets
are same. And starting from v2.1.0, the offsets changed.

But the current reg_offset naming convention is confusing. So to reflect
this change correctly in driver, let's encode the start version from which
the offsets got changed in reg_offset struct name. This will be
llcc_v1_reg_offset for v1.0.0 and llcc_v2_1_reg_offset for v2.1.0.
This will allow multiple SoCs to use the same reg_offset clearly.

And in the future if the offsets got changed again, then that specific
version could be encoded in the struct name.

Suggested-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/soc/qcom/llcc-qcom.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 38d7296315a2..0dc2bb0c23cc 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -296,12 +296,14 @@ static const struct llcc_slice_config sm8450_data[] =  {
 	{LLCC_AENPU,     8, 2048, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0 },
 };
 
-static const u32 llcc_v1_2_reg_offset[] = {
+/* LLCC register offset starting from v1.0.0 */
+static const u32 llcc_v1_reg_offset[] = {
 	[LLCC_COMMON_HW_INFO]	= 0x00030000,
 	[LLCC_COMMON_STATUS0]	= 0x0003000c,
 };
 
-static const u32 llcc_v21_reg_offset[] = {
+/* LLCC register offset starting from v2.0.1 */
+static const u32 llcc_v2_1_reg_offset[] = {
 	[LLCC_COMMON_HW_INFO]	= 0x00034000,
 	[LLCC_COMMON_STATUS0]	= 0x0003400c,
 };
@@ -310,70 +312,70 @@ static const struct qcom_llcc_config sc7180_cfg = {
 	.sct_data	= sc7180_data,
 	.size		= ARRAY_SIZE(sc7180_data),
 	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_2_reg_offset,
+	.reg_offset	= llcc_v1_reg_offset,
 };
 
 static const struct qcom_llcc_config sc7280_cfg = {
 	.sct_data	= sc7280_data,
 	.size		= ARRAY_SIZE(sc7280_data),
 	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_2_reg_offset,
+	.reg_offset	= llcc_v1_reg_offset,
 };
 
 static const struct qcom_llcc_config sc8180x_cfg = {
 	.sct_data	= sc8180x_data,
 	.size		= ARRAY_SIZE(sc8180x_data),
 	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_2_reg_offset,
+	.reg_offset	= llcc_v1_reg_offset,
 };
 
 static const struct qcom_llcc_config sc8280xp_cfg = {
 	.sct_data	= sc8280xp_data,
 	.size		= ARRAY_SIZE(sc8280xp_data),
 	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_2_reg_offset,
+	.reg_offset	= llcc_v1_reg_offset,
 };
 
 static const struct qcom_llcc_config sdm845_cfg = {
 	.sct_data	= sdm845_data,
 	.size		= ARRAY_SIZE(sdm845_data),
 	.need_llcc_cfg	= false,
-	.reg_offset	= llcc_v1_2_reg_offset,
+	.reg_offset	= llcc_v1_reg_offset,
 };
 
 static const struct qcom_llcc_config sm6350_cfg = {
 	.sct_data	= sm6350_data,
 	.size		= ARRAY_SIZE(sm6350_data),
 	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_2_reg_offset,
+	.reg_offset	= llcc_v1_reg_offset,
 };
 
 static const struct qcom_llcc_config sm8150_cfg = {
 	.sct_data       = sm8150_data,
 	.size           = ARRAY_SIZE(sm8150_data),
 	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_2_reg_offset,
+	.reg_offset	= llcc_v1_reg_offset,
 };
 
 static const struct qcom_llcc_config sm8250_cfg = {
 	.sct_data       = sm8250_data,
 	.size           = ARRAY_SIZE(sm8250_data),
 	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_2_reg_offset,
+	.reg_offset	= llcc_v1_reg_offset,
 };
 
 static const struct qcom_llcc_config sm8350_cfg = {
 	.sct_data       = sm8350_data,
 	.size           = ARRAY_SIZE(sm8350_data),
 	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v1_2_reg_offset,
+	.reg_offset	= llcc_v1_reg_offset,
 };
 
 static const struct qcom_llcc_config sm8450_cfg = {
 	.sct_data       = sm8450_data,
 	.size           = ARRAY_SIZE(sm8450_data),
 	.need_llcc_cfg	= true,
-	.reg_offset	= llcc_v21_reg_offset,
+	.reg_offset	= llcc_v2_1_reg_offset,
 };
 
 static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
-- 
2.25.1

