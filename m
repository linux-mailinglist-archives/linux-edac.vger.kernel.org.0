Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9146B8AA9
	for <lists+linux-edac@lfdr.de>; Tue, 14 Mar 2023 06:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCNFjX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Mar 2023 01:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjCNFjM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Mar 2023 01:39:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BBF95E3D
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 22:38:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d13so4257153pjh.0
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 22:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678772321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbWxcznp0VOg1xe9D7780m5fL2MnhbImn1BuxXG45M8=;
        b=f/YuqB9VIVepKA5532aWKRLA3ZbUAfvr/OSkm/1RU/RhHYbq/uRfIben/ZZd4SMu8g
         dFcAnVt6j0yuSjD+Z1t97ZJdmvuarnaCAbTdtRVs9yc8ls6RCArnqUeEhwtUu3LddfyL
         3Wr/l3R/dXpJNNxsQDkJ/Jc+Pxrv3YWmlayyGYv+5XiFZV+iq7lzR12QVGJxS2dhbUvn
         cAfOEkXUyq2sn43d/T8ToV/YsfEmIV7JGvCBXFAykCf5CqiL8OnjXyXU6HtOqd8VkHpW
         jZBn8yxmaVtF4rKQZjU0mxwoubSnJmJwKwXCocr9adTVQeajNCrp+iIgVwaqPSCPRKtv
         V/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbWxcznp0VOg1xe9D7780m5fL2MnhbImn1BuxXG45M8=;
        b=1Laqk5Z8q3jVudr743lquTO1yMFJ1SOXI58pIxYBMOnRxME0twj/j2Gu04E85P9YBs
         CbJhE3M1sYp1OKGSzOkp1ilkv7ZubooXAmdU0n1ewDF8TaKQzxp+qNEkt8xQCO4ARTWQ
         uk4RL6oFTbeCoT716niaB85j706cOUGNT73IDS+xoFd/7pJVklyDEtRglHjuAoB3hWBZ
         zIyBBxQbfhwgKqfu7boU6hoZqcYWt5cL58/6a8VJwUz8io2IAHAlsQLN8Ou16rA4tkwY
         Eg0DVvLSw7ytkfziaEsLWX5ifRsYYFrZ+sJnCYn22QVHd7YZDHploCf2UFBs+ixaadGp
         xynA==
X-Gm-Message-State: AO0yUKUQzqRw49Ryo50BXgY0AyL/+tjw2zTsui17w/Gl2n9JHNXMzJ9B
        Vm3Bb0DD9DkE2l3cG92NBFmf
X-Google-Smtp-Source: AK7set+C7MGAK3C8V8kD1Nc2L5YtcDv1Nxgu4THXg0yaqQya7pcQDbJi2OcqBjF9RDyOjLVqf6cGvg==
X-Received: by 2002:a05:6a20:734e:b0:cc:50cd:e0d7 with SMTP id v14-20020a056a20734e00b000cc50cde0d7mr37105440pzc.52.1678772320993;
        Mon, 13 Mar 2023 22:38:40 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id n126-20020a634084000000b005034a46fbf7sm675093pga.28.2023.03.13.22.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:38:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v7 13/13] soc: qcom: llcc: Do not create EDAC platform device on SDM845
Date:   Tue, 14 Mar 2023 11:07:25 +0530
Message-Id: <20230314053725.13623-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314053725.13623-1-manivannan.sadhasivam@linaro.org>
References: <20230314053725.13623-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The platforms based on SDM845 SoC locks the access to EDAC registers in the
bootloader. So probing the EDAC driver will result in a crash. Hence,
disable the creation of EDAC platform device on all SDM845 devices.

The issue has been observed on Lenovo Yoga C630 and DB845c.

While at it, also sort the members of `struct qcom_llcc_config` to avoid
any holes in-between.

Cc: <stable@vger.kernel.org> # 5.10
Reported-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/soc/qcom/llcc-qcom.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 72f3f2a9aaa0..a5140f19f200 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -120,10 +120,11 @@ struct llcc_slice_config {
 
 struct qcom_llcc_config {
 	const struct llcc_slice_config *sct_data;
-	int size;
-	bool need_llcc_cfg;
 	const u32 *reg_offset;
 	const struct llcc_edac_reg_offset *edac_reg_offset;
+	int size;
+	bool need_llcc_cfg;
+	bool no_edac;
 };
 
 enum llcc_reg_offset {
@@ -452,6 +453,7 @@ static const struct qcom_llcc_config sdm845_cfg = {
 	.need_llcc_cfg	= false,
 	.reg_offset	= llcc_v1_reg_offset,
 	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+	.no_edac	= true,
 };
 
 static const struct qcom_llcc_config sm6350_cfg = {
@@ -1011,7 +1013,14 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 		goto err;
 
 	drv_data->ecc_irq = platform_get_irq_optional(pdev, 0);
-	if (drv_data->ecc_irq >= 0) {
+
+	/*
+	 * On some platforms, the access to EDAC registers will be locked by
+	 * the bootloader. So probing the EDAC driver will result in a crash.
+	 * Hence, disable the creation of EDAC platform device for the
+	 * problematic platforms.
+	 */
+	if (!cfg->no_edac) {
 		llcc_edac = platform_device_register_data(&pdev->dev,
 						"qcom_llcc_edac", -1, drv_data,
 						sizeof(*drv_data));
-- 
2.25.1

