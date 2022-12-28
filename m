Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15F657439
	for <lists+linux-edac@lfdr.de>; Wed, 28 Dec 2022 09:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiL1IoY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Dec 2022 03:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiL1In1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Dec 2022 03:43:27 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57731004C
        for <linux-edac@vger.kernel.org>; Wed, 28 Dec 2022 00:42:43 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 7so10205858pga.1
        for <linux-edac@vger.kernel.org>; Wed, 28 Dec 2022 00:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dmgmy1WkNpy5rN0a0WaCg+UaF5eldkFegxv86WikVN4=;
        b=pVHwuZ2c7VrUE5Wd2ya4PpcVuLE6eNZ6ATLAbSIPuSaAUeIDwYtrZggSCCm2gmA8qH
         JTWC5T1yfXtnVTlvKQethFlb0qfZF8bYG6sKsZLFnxRFA5SUKm/En1vFVuX2j65a/OY3
         IL/4uGH5m+ZfdPLzyDy9Z7ovx80C/GorxXYlXkXep0wCXiIeAxrOd/X+XbIPoFekW736
         ydBVY0pcv1Wi9WmO8SmlHhLpa7ddE4XPFkR5dJ2GXFf8gGG2N7uI7cpsPGuMWnEhE3yU
         A1P2pdkm0woo+8+YjRKLZJJk+8U7Q1LmwE+DLx8d8VgHS/gZPlUrc3gHhs+iZEeymP6s
         gytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dmgmy1WkNpy5rN0a0WaCg+UaF5eldkFegxv86WikVN4=;
        b=Rv3AKlVC9kQBG4XKNmylE0R1z1raHyA2j4bHHnBzFvZwTG4S5GGzZcGjxc+kKYMxcR
         xAuR9sTKb8/Sm96GjfuW8pQ8tGLl8BbH7zH+1cz4Fo0jO5FsYjkdN9vnSQGGBiU0Kcp7
         jYDevp2gKubbFj2SkB8p7rNdbGMe7W6T6SgZYKSMnH/iTuTdFGJ1X6RNYJ46bwmB+LpY
         JmxFI2WR1r9CYwGeW3pGYVqtuG+grIiJCtnZnzzciK4kLE3Piq/kAV93URQ15YA41YcT
         OOiVKXznmQI1l/RhwTJcXyXvdhz35gWBw0lYmmib30xu75d042/TgFhIbnI4VeT991cT
         PQ0g==
X-Gm-Message-State: AFqh2kqU6zYqfl54DmPJgvQs7B+Bd/LmwAfw+/ujLfberQWNOZVmXSB7
        tWj1l4/IHOL8US+2wBK1/qFI
X-Google-Smtp-Source: AMrXdXtJKvkLftrOG21ijD/t8yxigqDi4l4ZJej4ePx4o5qxlVks6rYjVxk7w2Wg5P1VmHt8j+zPYw==
X-Received: by 2002:a05:6a00:414c:b0:581:7c46:debd with SMTP id bv12-20020a056a00414c00b005817c46debdmr3704718pfb.24.1672216963254;
        Wed, 28 Dec 2022 00:42:43 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id d188-20020a6236c5000000b0057a9b146592sm9786286pfa.186.2022.12.28.00.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:42:42 -0800 (PST)
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
Subject: [PATCH v5 16/17] qcom: llcc/edac: Support polling mode for ECC handling
Date:   Wed, 28 Dec 2022 14:10:27 +0530
Message-Id: <20221228084028.46528-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
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
Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
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

