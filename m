Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3493A649EE5
	for <lists+linux-edac@lfdr.de>; Mon, 12 Dec 2022 13:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiLLMgD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Dec 2022 07:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiLLMfU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Dec 2022 07:35:20 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7770F12632
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 04:34:41 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g10so11910373plo.11
        for <linux-edac@vger.kernel.org>; Mon, 12 Dec 2022 04:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jie7lgdvEnIQyGE6zlhbT0B1hTmWl4xcVmRV6TIX7Ks=;
        b=eaCgJOSU0Eenl1pCm9rc7ZdHXRGdaf8ehej2UyKExNX14OP9y9q7t6bzQA9F6MFh8Y
         H5ULrBo5EayBNpm/RX2smnE8G548NKB+F/i7bd6N6gqpr21/w2Qd0P8N/nVI+2EMt6rF
         AAlK2EEuSaJIAuKutAfLU9L72haqT/M1tnZ2bOVub6MnlWS+qDQNFOZE/CyiureudYl6
         9FcYjh41G5dtfMEYlWm98BRgL2o/VV5IpCu6tGc4VFD/0yOf4LyBy4Ybbompy1W5lgXb
         CGQ3l29KZo7FTLPLFOP7UcSTCXflCzB4YR7lqMTRmCQVsTMalLhAO8tzybd3nJVE4QwW
         yeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jie7lgdvEnIQyGE6zlhbT0B1hTmWl4xcVmRV6TIX7Ks=;
        b=uB/ItRlIIcmL7zT/saktFId/8TqaED6MZzT2ORLmONExMHPn4qz6Fn25xHwnqvHL6t
         6Vh3zAAsZ1Hb8wJ79kmX9VTq+vabN+qEQIE8Wze+/W/rkPaDNZBo1m6jbo1U4Y6AD6Xp
         TmCekla/HgoSsfcUMckmTfSpDNlBhAEJKnr1pn8LISreznXSjA1JVxmfWZzz/RNtt8La
         8sFtsUDOXEMyPKeUasJIN9e50cPm1wh3ZvzG00bsl1YbtWVu4hiQ6mrzp2yM3g+sJtkB
         hdAZnA6ARb0aeiRh5V0mboR4TSbtx5FnsKXEIOlmEkdzlwn5+uTkZ59R39EyrAWxUtfY
         KXSQ==
X-Gm-Message-State: ANoB5plKuLCZQw/fap240QskRVyf0JnKRtK2U/mE5DZfVRND2hDJFl6y
        eiuIUtEdOAz4v5/K7+ge5fDg
X-Google-Smtp-Source: AA0mqf5LpwGxW+PLMAvFM3kf27MXz56pW7cTMD9M0+puHlZxDzlk3HeUecpzAWk/fLvCVmfLeMnunA==
X-Received: by 2002:a17:902:9891:b0:189:2688:c97f with SMTP id s17-20020a170902989100b001892688c97fmr14982727plp.50.1670848481155;
        Mon, 12 Dec 2022 04:34:41 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.33])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b00189c93ce5easm6252557plx.166.2022.12.12.04.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:34:40 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 13/13] qcom: llcc/edac: Support polling mode for ECC handling
Date:   Mon, 12 Dec 2022 18:03:11 +0530
Message-Id: <20221212123311.146261-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
References: <20221212123311.146261-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Not all Qcom platforms support IRQ mode for ECC handling. For those
platforms, the current EDAC driver will not be probed due to missing ECC
IRQ in devicetree.

So add support for polling mode so that the EDAC driver can be used on all
Qcom platforms supporting LLCC.

The polling delay of 5000ms is chosed based on Qcom downstream/vendor
driver.

Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c     | 37 +++++++++++++++++++++++++-----------
 drivers/soc/qcom/llcc-qcom.c | 13 ++++++-------
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 5be93577fc03..f7afb5375293 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -76,6 +76,8 @@
 #define DRP0_INTERRUPT_ENABLE           BIT(6)
 #define SB_DB_DRP_INTERRUPT_ENABLE      0x3
 
+#define ECC_POLL_MSEC			5000
+
 enum {
 	LLCC_DRAM_CE = 0,
 	LLCC_DRAM_UE,
@@ -283,8 +285,7 @@ dump_syn_reg(struct edac_device_ctl_info *edev_ctl, int err_type, u32 bank)
 	return ret;
 }
 
-static irqreturn_t
-llcc_ecc_irq_handler(int irq, void *edev_ctl)
+static irqreturn_t llcc_ecc_irq_handler(int irq, void *edev_ctl)
 {
 	struct edac_device_ctl_info *edac_dev_ctl = edev_ctl;
 	struct llcc_drv_data *drv = edac_dev_ctl->pvt_info;
@@ -328,6 +329,11 @@ llcc_ecc_irq_handler(int irq, void *edev_ctl)
 	return irq_rc;
 }
 
+static void llcc_ecc_check(struct edac_device_ctl_info *edev_ctl)
+{
+	llcc_ecc_irq_handler(0, edev_ctl);
+}
+
 static int qcom_llcc_edac_probe(struct platform_device *pdev)
 {
 	struct llcc_drv_data *llcc_driv_data = pdev->dev.platform_data;
@@ -356,22 +362,31 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
 	edev_ctl->panic_on_ue = LLCC_ERP_PANIC_ON_UE;
 	edev_ctl->pvt_info = llcc_driv_data;
 
+	/* Check if LLCC driver has passed ECC IRQ */
+	ecc_irq = llcc_driv_data->ecc_irq;
+	if (ecc_irq > 0) {
+		/* Use interrupt mode if IRQ is available */
+		edac_op_state = EDAC_OPSTATE_INT;
+	} else {
+		/* Fall back to polling mode otherwise */
+		edac_op_state = EDAC_OPSTATE_POLL;
+		edev_ctl->poll_msec = ECC_POLL_MSEC;
+		edev_ctl->edac_check = llcc_ecc_check;
+	}
+
 	rc = edac_device_add_device(edev_ctl);
 	if (rc)
 		goto out_mem;
 
 	platform_set_drvdata(pdev, edev_ctl);
 
-	/* Request for ecc irq */
-	ecc_irq = llcc_driv_data->ecc_irq;
-	if (ecc_irq < 0) {
-		rc = -ENODEV;
-		goto out_dev;
-	}
-	rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
+	/* Request ECC IRQ if available */
+	if (ecc_irq > 0) {
+		rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
 			      IRQF_TRIGGER_HIGH, "llcc_ecc", edev_ctl);
-	if (rc)
-		goto out_dev;
+		if (rc)
+			goto out_dev;
+	}
 
 	return rc;
 
diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index a29f22dad7fa..e044e6756415 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -1011,13 +1011,12 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 		goto err;
 
 	drv_data->ecc_irq = platform_get_irq_optional(pdev, 0);
-	if (drv_data->ecc_irq >= 0) {
-		llcc_edac = platform_device_register_data(&pdev->dev,
-						"qcom_llcc_edac", -1, drv_data,
-						sizeof(*drv_data));
-		if (IS_ERR(llcc_edac))
-			dev_err(dev, "Failed to register llcc edac driver\n");
-	}
+
+	llcc_edac = platform_device_register_data(&pdev->dev,
+					"qcom_llcc_edac", -1, drv_data,
+					sizeof(*drv_data));
+	if (IS_ERR(llcc_edac))
+		dev_err(dev, "Failed to register llcc edac driver\n");
 
 	return 0;
 err:
-- 
2.25.1

