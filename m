Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1C6651212
	for <lists+linux-edac@lfdr.de>; Mon, 19 Dec 2022 19:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiLSSeW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Dec 2022 13:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiLSSdo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Dec 2022 13:33:44 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5290C14D31
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 10:31:53 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u5so9948965pjy.5
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 10:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAhD4QYewlPD8zViG7wcd+O4QOzC8E05GpctTZjGEWs=;
        b=DQENHD3a54VmP805WbROmXJdgPwrUvjbNGaqG9P7zCIZ2AxPxNw1qsI9bmp7ZEiJWq
         EyRFXmkbmGHIKu/2MklMP0Z0rrZXksYozWsPTzB4ve6WN56unZDfWdASgsodZ8lqp5Lc
         lmTx6dUCYzbUWmyp2m5mmInCF9+9bvp+37ou7LvOgAnp+GY6KuGwgNN+BIEb19doaNQC
         8SMI5Jy+5b80XpjGTVojROIyUE/KmVCeR9VajCVPaNZUhd4pPERbhgqdHW7ruuIkJIyW
         8soZ9c9h13fJSt+kVck33CDGGG/sHcZuA9JsvCnsQ8XAQnZauxSrTZcvodT+uqDZADeh
         IZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAhD4QYewlPD8zViG7wcd+O4QOzC8E05GpctTZjGEWs=;
        b=ERP+YPn1+pgn51ubkBXaMyFBsySuhggymELka2SX0ehzT0RFzQrAIOxinxG3rJWbAY
         SaVlhIIZo8MxqOcT6oP/ta3WrqDsIvgcxMWJAdFyNZROX3HV+JrPocpfoQjwA04jQrsc
         1vmki8uF8yOvtVXM5QQ5+HYJBXeWvPav6baebIE/naPeZLqwLD4MJJgi148TNZslUVOI
         pNq3H1I5URLLQpOBbRf6j3CYRU7wDRU4MTcCmXv5FbSE3tlNBbM9wTPvO4ZADovxK0b3
         Ojbd3WqqBkYhX/esL3A51kibhX1RHFvqh1norWEjbQp2c7lGMpODqw9ie06TXr44fgQy
         1J3g==
X-Gm-Message-State: AFqh2krgokZVRE606KdEUD6CW4HWd4eX7J+9Cbg+GMVPGsd18ge3TXXX
        IQrnkre9in67ui7c/kksZFxd
X-Google-Smtp-Source: AMrXdXsJ3fbsg8BfmB6PDsoehMnfBnm2358uyS0Atl35IannK5L2b3OWfsHA+zQkhglyOv6lMqZ3Cw==
X-Received: by 2002:a17:903:48c:b0:189:6c9a:7d8b with SMTP id jj12-20020a170903048c00b001896c9a7d8bmr10162628plb.32.1671474712975;
        Mon, 19 Dec 2022 10:31:52 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b00186e34524e3sm7480979plh.136.2022.12.19.10.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:31:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 15/15] qcom: llcc/edac: Support polling mode for ECC handling
Date:   Mon, 19 Dec 2022 23:59:58 +0530
Message-Id: <20221219182958.476231-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
References: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
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

The polling delay of 5000ms is chosen based on Qcom downstream/vendor
driver.

Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c     | 37 +++++++++++++++++++++++++-----------
 drivers/soc/qcom/llcc-qcom.c | 13 ++++++-------
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index f40bb49bccd4..672a09f3b4cb 100644
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
index 72f3f2a9aaa0..7b7c5a38bac6 100644
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

