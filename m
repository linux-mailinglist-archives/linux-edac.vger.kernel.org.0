Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9893365120B
	for <lists+linux-edac@lfdr.de>; Mon, 19 Dec 2022 19:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiLSSdt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Dec 2022 13:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiLSScx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Dec 2022 13:32:53 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2E4140DF
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 10:31:40 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w20so3276710ply.12
        for <linux-edac@vger.kernel.org>; Mon, 19 Dec 2022 10:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mWLM+xjtkcHtTlHLK0FQlJaaC6ncfnZviWhmaPi0lM=;
        b=qZ0DvYBLrUPKCItDG/754HTBRDZshK7oQme3AAh5u9MJcyEo9DpFvFWLCor+S5AkX+
         OhTdL8gEbszkP7lyRdCbap2/6+1yQrFS3x9xCvH4+RGMPXfFnn1SCf0lv9y/mZ5JsTW4
         b8nv6GP929ZKxgu+tEFRKz7wor582zzTRHERLtFa4NSOdFJToPXKQxbmB+Y5o3KXEbfw
         Zp3TwqN4C22wdmth7phpaCUnjJL89Y/xuiornJ8jZ5J4OfNWZrNZgiQ8Yk2fg+TYVX+X
         69f/U1j+SPZJrRLtpaN245C9QOLBdAPE76PCnHA3s73j0fWvewj0XSXW3MVKDxO8tBEs
         qxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mWLM+xjtkcHtTlHLK0FQlJaaC6ncfnZviWhmaPi0lM=;
        b=eh428yuzuhHPBA6d/F9hUMA38oAjMcjfGDHK0LICf7Al2wHEuWhDbgclFau9vI+Xlo
         PMyOVJx1/4jsfaCThshZfgi0VbY7cBUin069Uxm/8yUTr6TKEbZDw6QvbOIeD66r5vSL
         nO/ZXgevc0t9wASStAR0IOQbHgV1b8r9AqxFKtHmOrq1bba0LdSYmOXYvJD/iCQLtahy
         5tN4vGCnVBtTk7kj76k8QvGwnYUrveFGzaQmumxoe16mLYaSZlp13fkWw39wub3++MNf
         3df/WdPO1V/DWsO4AsYb5L9VPfoCtqN2/LM4N5IDJ2+gEcvAlQAIZls4Fn8H/DMq4CW4
         ReaQ==
X-Gm-Message-State: ANoB5pkuHUfd4l1m5ObQRtQ5BSWHVWljz/BA4mRfa7bYmd1gh12Bj19V
        LNN1tr1cgYqfqxsGXaRkXHA1
X-Google-Smtp-Source: AA0mqf55NYWXIIemHerLmljoYqXyTYYTKw+2SQmde47ZvnjotMfseOOnCrPdpivq4q+wuMescLn8uQ==
X-Received: by 2002:a17:902:9a43:b0:187:16c2:d52c with SMTP id x3-20020a1709029a4300b0018716c2d52cmr40519635plv.50.1671474699946;
        Mon, 19 Dec 2022 10:31:39 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b00186e34524e3sm7480979plh.136.2022.12.19.10.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:31:38 -0800 (PST)
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
Subject: [PATCH v3 13/15] EDAC/qcom: Add platform_device_id table for module autoloading
Date:   Mon, 19 Dec 2022 23:59:56 +0530
Message-Id: <20221219182958.476231-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
References: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
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

platform_device_id table needs to be added so that the driver can be
autoloaded when the associated platform device gets registered.

Reported-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 97a27e42dd61..9e77fa84e84f 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -397,12 +397,19 @@ static int qcom_llcc_edac_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id qcom_llcc_edac_id_table[] = {
+	{ .name = "qcom_llcc_edac" },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, qcom_llcc_edac_id_table);
+
 static struct platform_driver qcom_llcc_edac_driver = {
 	.probe = qcom_llcc_edac_probe,
 	.remove = qcom_llcc_edac_remove,
 	.driver = {
 		.name = "qcom_llcc_edac",
 	},
+	.id_table = qcom_llcc_edac_id_table,
 };
 module_platform_driver(qcom_llcc_edac_driver);
 
-- 
2.25.1

