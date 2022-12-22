Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAF26541CC
	for <lists+linux-edac@lfdr.de>; Thu, 22 Dec 2022 14:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiLVNUx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Dec 2022 08:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbiLVNUR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Dec 2022 08:20:17 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957D4303D0
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:19:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u7so1967407plq.11
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbPgua9Rs+Y/jmkHHRB8iBOCSrUJRilLgsafIRoyD0w=;
        b=V+1xpDzJK5x7FCBJez4sQfR8rdWJj1vQ9lRrOrEKRqJZc57KyH4DVPtWM85LfqFP2W
         T5LE7COXtjTKK1fWVeDgH2TEhbHqGe6UG9r/MJgZP+bgAqE6YuK4sbL36dPuJfntCOAZ
         i4xobhCatBteqqm6eQ5YRinJeudnjFU/iLlwQ0eanU9ry6B6dFrD5zOIl/wqEtMUxNI9
         xcpg92Z4yg7pv0YqwW8m1GwFHm8lS4WTzZ7wSK+gDrs/UNRdTgLI5x1GjVxarIErOqlc
         XFad4RLzK1I+8m9Zy/r8iTrm2O1HghUt1zsBtM/ILAhCNFcQIJJv93Hzr9tH082GHz8+
         xW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbPgua9Rs+Y/jmkHHRB8iBOCSrUJRilLgsafIRoyD0w=;
        b=aedjVYYAx1jbmocbOTo9Q33ZN41oC+WTaVHqrAeQRlRjMQ2Hcsm9QN0L1TrhP5ShsE
         WFTfe6SgPH3QKJOlnp/m9qpLr6vq8ha52t0W2geoK1CV52eEesKbrEkRNIP0CoLJOeFu
         FG6fo4XGTBxfzR71IEjiNxwqSL/uyvym2hgFqrMCdda3NqR0gCnrh6pOEWMfV+eFtSKv
         +cnNYXvtkDiKJl6uklOux+qeiHBeJ4RnfgTtzaPlh/jV0zxefo58/n1wND0eqn2ELaUT
         XwMrJkFxU7ioyP8hMJBFHNsfqgay4qgzdUoESsuzyiM20U3dj5QNRa1/K6BsE9MgiPKz
         2qYA==
X-Gm-Message-State: AFqh2kqRoakcQc2aYu9mGqpx5oHSFgsfjDGA3Z/IGJ1R5RGnu28CtuGG
        lEi2k+cMcOhzKSNTkmol0EJg
X-Google-Smtp-Source: AMrXdXveeY7kEuyKhD15VcRWF+Fm6mVBnQfV6NOrNNRz8VI5xwv68Fx04E6C69/sUjakYjWfr8ZCiQ==
X-Received: by 2002:a17:902:e742:b0:189:83bb:646f with SMTP id p2-20020a170902e74200b0018983bb646fmr8000265plf.17.1671715167031;
        Thu, 22 Dec 2022 05:19:27 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:19:26 -0800 (PST)
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
Subject: [PATCH v4 16/16] qcom: llcc/edac: Support polling mode for ECC handling
Date:   Thu, 22 Dec 2022 18:46:56 +0530
Message-Id: <20221222131656.49584-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
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
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c     | 37 +++++++++++++++++++++++++-----------
 drivers/soc/qcom/llcc-qcom.c | 13 ++++++-------
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 1d3cc1930a74..cfcdc35b0373 100644
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
@@ -355,22 +361,31 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
 	edev_ctl->ctl_name = "llcc";
 	edev_ctl->panic_on_ue = LLCC_ERP_PANIC_ON_UE;
 
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

