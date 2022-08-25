Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E27E5A0814
	for <lists+linux-edac@lfdr.de>; Thu, 25 Aug 2022 06:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiHYEjw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Aug 2022 00:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiHYEjb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Aug 2022 00:39:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC929E0D7
        for <linux-edac@vger.kernel.org>; Wed, 24 Aug 2022 21:39:26 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id io24so4220915plb.1
        for <linux-edac@vger.kernel.org>; Wed, 24 Aug 2022 21:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Lhl1Yht7Jl4WGhfsN3KHnbxlZqqtqyTEjZ2u2REimHo=;
        b=Y5clFA9Qhlx4aAJ2EtZraQ5ch9vTS1PtfnJYSQ2wzZ5G5wAVNOws1oAOD7nOm5efyL
         tS7f1Te4AoSP9NKm1liC3n4PGsttlJKhH4DzxI/67aX+87Pa9ttzoNzz9ESyBV1QXc5B
         qbjnFKxMlbLW/Fa4RkDrS0ImIqD2pinp1FZ/E7ftWE/CTvGq0udvQJkjv/HUU3irw8L2
         gkTbgMCyyg3xjtdUwh3WgubRjfPggv8Py27thCYXOSo3i2jo8FmTQvlYLPpZ74qrFiZV
         sEp0Si3GKZsIINZuGASxmnV9ZIyLPdPJ4n9YyRPvWHadGwrW/H4p1WN13JqNppXFYrJv
         OAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Lhl1Yht7Jl4WGhfsN3KHnbxlZqqtqyTEjZ2u2REimHo=;
        b=e7YzwVTbpVTHIXwlpgfYDp15IKBMBAQJtUwFn0m6/ccLn6atLUnMo8Ox6G+eraFq2X
         +9Bv5Ky1iqW3fUg+aREdf/Hmys8WoBryX0zFDuzA5ko/hPSfaEcI5e8jJBzGnodvEIVG
         OYcA0rg6482UiLO2JghvWTbT9+j0X3Ic64sUEApq1P9ofL6C1V+qTF117W0vvEbLLcnh
         z2ZnSkB1c/YvioeEoQaRmKDrE8dr6l35sNziTeVWk8TP3M6b/JDjhMygbAxRXOp84oav
         70FErfs69wo7suvRU62SR4uXyTSVrBdSTBOZQaRgZ6uw6Zg9fmrQCvsJJqTOzd3jywt9
         iIlA==
X-Gm-Message-State: ACgBeo2KdoCw1wm6++husrUw/zFfxsdCMRVwergnQba9bZRwLsR+9zzj
        6DwpcKvWtplW168H2TAiratH
X-Google-Smtp-Source: AA6agR4/4AMEDDRstoYe13HeN/V9B58rl7YK1TZPIgNU6QkUhjRRfZTDmNeGn88tUp9dGoAo6nei8A==
X-Received: by 2002:a17:90a:604e:b0:1fa:c865:eabb with SMTP id h14-20020a17090a604e00b001fac865eabbmr2687475pjm.46.1661402366334;
        Wed, 24 Aug 2022 21:39:26 -0700 (PDT)
Received: from localhost.localdomain ([117.207.24.28])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090a64cb00b001fa9f86f20csm2294296pjm.49.2022.08.24.21.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 21:39:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_saipraka@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 4/5] EDAC/qcom: Remove extra error no assignment in qcom_llcc_core_setup()
Date:   Thu, 25 Aug 2022 10:08:58 +0530
Message-Id: <20220825043859.30066-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
References: <20220825043859.30066-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

If the ret variable is initialized with -EINVAL, then there is no need to
assign it again in the default case of qcom_llcc_core_setup().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 04df70b7fea3..0b6ca1f20b51 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -126,7 +126,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
 static int
 qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 {
-	int ret = 0;
+	int ret = -EINVAL;
 
 	switch (err_type) {
 	case LLCC_DRAM_CE:
@@ -158,7 +158,6 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 			return ret;
 		break;
 	default:
-		ret = -EINVAL;
 		edac_printk(KERN_CRIT, EDAC_LLCC, "Unexpected error type: %d\n",
 			    err_type);
 	}
-- 
2.25.1

