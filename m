Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8376B8C9A
	for <lists+linux-edac@lfdr.de>; Tue, 14 Mar 2023 09:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjCNIH1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Mar 2023 04:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCNIGr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Mar 2023 04:06:47 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1318F97FEC
        for <linux-edac@vger.kernel.org>; Tue, 14 Mar 2023 01:06:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i3so15713216plg.6
        for <linux-edac@vger.kernel.org>; Tue, 14 Mar 2023 01:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfib3mid0RNv0awlNHyD0vxmGxxP3t1h5XoLVgGQYbk=;
        b=yf4ZTxotOIU67QI6f/wXZ/zJYvgr6n43s20tJqrl65vBN3IC13gEOytr6OGzX8+fD1
         0o4CO3msCjAHU1/Dg1lU1YFE9AG9yHSv33akNRqof0AInDypR0SMRDQISBnr1OEpDxRU
         OVCpOUMU3o212GffdTDsPOqRsJga4/nY8eWtiifY3BS4H+5zeuYI4Kgrkyk4mU4T5lEw
         MrfX2AglTYOkmUBFZOe6ydxVSWxjUE17qWREIlOkKr8ZspRKhjm+Ym1w7vlyMNHNr5yH
         WLnUvlbdsNRjOhm35uwDTbyH8eEc82sNNcRYvAr4Rejn046Imzsvcs55nhQ7BcmyMYa4
         rI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfib3mid0RNv0awlNHyD0vxmGxxP3t1h5XoLVgGQYbk=;
        b=8Jxp1dkSpYZsHUYZvgwRF3C/ftSws9H953SJaom08TDZACy/ktOB2rfH2kTQRkuXGr
         I4jM91m9zjiY0brngtnrGlIFNPo/OnFfSwSRa5QXrzD0MnJrFIDUq0sK1uO4ZmZEy2Sq
         ssxJL3+dCUYDW91D74DJXnImoppsh5U5fu/F1xKiCNW8LzDpVZq26btZOZYyc5P1UUe8
         mPYyoPqyWxMAyf5H52Cijg2S3X8q88sXLNJzKOGmZlc6AkupgLpzNdwA9tlOLHG7+dOh
         nwLmTq3VpI17YLsVWku//QiClyuWPj52/eGOIacel+TFaUIFqlJbvqOqYMcfTQ31vvSq
         ZoLw==
X-Gm-Message-State: AO0yUKXYn6jyUa775mU+ONYVJgz+FV1tZs9IQkon6w+lY8X1R8cQI1sm
        bVvE3kwoCAzIEt9cwa7cQ8hA
X-Google-Smtp-Source: AK7set8D0WZOisXVIllIVwyzE9SNHCjSM9A+Uc56ksiGi2TMM4jJ/I7VRFKuvqiAyLOS0SGZXkDSdg==
X-Received: by 2002:a17:902:d50f:b0:19e:aafe:f7e9 with SMTP id b15-20020a170902d50f00b0019eaafef7e9mr40448490plg.25.1678781168473;
        Tue, 14 Mar 2023 01:06:08 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001994a0f3380sm1078022plg.265.2023.03.14.01.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:06:07 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v8 13/14] qcom: llcc/edac: Support polling mode for ECC handling
Date:   Tue, 14 Mar 2023 13:34:42 +0530
Message-Id: <20230314080443.64635-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
References: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
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
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
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

