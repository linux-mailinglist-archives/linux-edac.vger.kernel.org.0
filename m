Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295666720DF
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jan 2023 16:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjARPOa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Jan 2023 10:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjARPM6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Jan 2023 10:12:58 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DE43EC45
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:10:42 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 207so10317372pfv.5
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBoPP7la/ua1BtGy3Yfc6n2eJd1xV8oYEaGxzVQpNAQ=;
        b=ZnK7pMoFfj0Q4BnzQsiP1CHVWDjNgmQ8FXq58kmPVMdFll8MoE2KqeWeaIkeHTxYcW
         pwh9KGanvj7rvTSLAnkb5rUQqwvSNiBFDNNGyNmjMAVkdmaAYiqYhV2ka1dCnSboam4u
         VJvTrvdoN0pF1Ao4FXUphf3oeNOooK63ysbEBNDG6gUDyiHWUqSIsnIOP3qMU8Zlpbrh
         FpK/HyQnSOX6/2wRb5/xS3aV7xjx3v1weSO93quF+CxQT1CNIRX5GuAfYHB2KzjOp0Dt
         FhiFmW2gYVMyvGl3urrSTNsMWdAP61fWiiki98tWc66HGc7ZoxelMGV3vkopeVi4Al+c
         lbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBoPP7la/ua1BtGy3Yfc6n2eJd1xV8oYEaGxzVQpNAQ=;
        b=dmq42med3rnOGfSIYotoLQk9+ctv9Q1ZLeLUONa5sgiLIAvXe9EjnRgbiffYhN4jqY
         M8vcfEpTOtyW0S3ziPaOu6ZI6aFxfNmcOebRtfLOjLTLAhnooe1qyV57Lmk1n7VdfkRQ
         8xPMQWprjLjeWLGPKMXkBb4GiwcljGmODdi0KfIbvIpql5yvSInH19LjQzqbCrzfQgUs
         2Veux43tuokgI0KRy4nclt61RUgtnHCwAzQuGMqMu5wFIe93T2qZ40+sbp+ggXn0pgUm
         N+U+2yDScicHYRIzz/M8qGh+LHy0sNMFgcv3IZgo6BwZoVRO8Zq1szY4yY0Ta2+r8PrP
         bfqw==
X-Gm-Message-State: AFqh2ko4UeIZzjEeg8kGn4ieI7GF5ppb9HfkTK1RGkxy2XMXtRCd7eRi
        0sSvtOeoK24lcstshK6yXyN1
X-Google-Smtp-Source: AMrXdXtFaaSpmV09mTvFJv0Gz128qzLxFEa/pu4HlDABsDLfiy+TK224ddY2VzOvh/mlq+gUp2jr7A==
X-Received: by 2002:aa7:854f:0:b0:58b:b9ce:cda1 with SMTP id y15-20020aa7854f000000b0058bb9cecda1mr7521532pfn.28.1674054642343;
        Wed, 18 Jan 2023 07:10:42 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.61])
        by smtp.gmail.com with ESMTPSA id i15-20020aa796ef000000b0058d9623e7f1sm6721544pfq.73.2023.01.18.07.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:10:41 -0800 (PST)
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
Subject: [PATCH v6 16/17] qcom: llcc/edac: Support polling mode for ECC handling
Date:   Wed, 18 Jan 2023 20:39:03 +0530
Message-Id: <20230118150904.26913-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
References: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
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

Not all Qcom platforms support IRQ mode for ECC handling. For those
platforms, the current EDAC driver will not be probed due to missing ECC
IRQ in devicetree.

So add support for polling mode so that the EDAC driver can be used on all
Qcom platforms supporting LLCC.

The polling delay of 5000ms is chosen based on Qcom downstream/vendor
driver.

Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c     | 50 +++++++++++++++++++++---------------
 drivers/soc/qcom/llcc-qcom.c | 13 +++++-----
 2 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 1d3cc1930a74..265e0fb39bc7 100644
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
 	struct llcc_drv_data *drv = edac_dev_ctl->dev->platform_data;
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
@@ -355,29 +361,31 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
 	edev_ctl->ctl_name = "llcc";
 	edev_ctl->panic_on_ue = LLCC_ERP_PANIC_ON_UE;
 
-	rc = edac_device_add_device(edev_ctl);
-	if (rc)
-		goto out_mem;
-
-	platform_set_drvdata(pdev, edev_ctl);
-
-	/* Request for ecc irq */
+	/* Check if LLCC driver has passed ECC IRQ */
 	ecc_irq = llcc_driv_data->ecc_irq;
-	if (ecc_irq < 0) {
-		rc = -ENODEV;
-		goto out_dev;
-	}
-	rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
+	if (ecc_irq > 0) {
+		/* Use interrupt mode if IRQ is available */
+		rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
 			      IRQF_TRIGGER_HIGH, "llcc_ecc", edev_ctl);
-	if (rc)
-		goto out_dev;
+		if (!rc) {
+			edac_op_state = EDAC_OPSTATE_INT;
+			goto irq_done;
+		}
+	}
 
-	return rc;
+	/* Fall back to polling mode otherwise */
+	edev_ctl->poll_msec = ECC_POLL_MSEC;
+	edev_ctl->edac_check = llcc_ecc_check;
+	edac_op_state = EDAC_OPSTATE_POLL;
 
-out_dev:
-	edac_device_del_device(edev_ctl->dev);
-out_mem:
-	edac_device_free_ctl_info(edev_ctl);
+irq_done:
+	rc = edac_device_add_device(edev_ctl);
+	if (rc) {
+		edac_device_free_ctl_info(edev_ctl);
+		return rc;
+	}
+
+	platform_set_drvdata(pdev, edev_ctl);
 
 	return rc;
 }
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

