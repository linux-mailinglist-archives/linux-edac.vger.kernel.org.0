Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78FF6541C1
	for <lists+linux-edac@lfdr.de>; Thu, 22 Dec 2022 14:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbiLVNTl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Dec 2022 08:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiLVNTG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Dec 2022 08:19:06 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAECB2B603
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:19:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so5689970pjj.2
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mWLM+xjtkcHtTlHLK0FQlJaaC6ncfnZviWhmaPi0lM=;
        b=TOarD5uKYzdGzBgkCMjwru8cWoEMQy/+vSrMtukdY8EyEsh+D35kd+S7H09cmg6j/Z
         DULe/DTL/oabOivkhr0/PVxddgKe+CvaCfRUv51KVMkEO6qSZ2RIQfMckDB40BJ6vV0B
         Ht/puy0DpzttOPl6aeL42ts38AjAOjpblgt8ubv8vSNOc7PTw3CcfEXIkesR1nzJpnny
         vsPVbWDC+0gKgkSu+UkM+PTw5QswbD718pxnahHcR/Na/mw2cTS6K+WYZyhQZPz87Klt
         2iAXonIw9nblXUEpjN5t0nuHlMDysNnt/BtGaZxPOXXc1jhqjuw1LjF+5WdRMt5MpDJM
         P0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mWLM+xjtkcHtTlHLK0FQlJaaC6ncfnZviWhmaPi0lM=;
        b=qEuc2AWvsRTO6nxtit8JdUH4zwIsH/MRiTTIL+7Q2SLqIxlRlgqYbGyeX3vKbRkPus
         NKCmvu7UeAej/nF5DjWE9bQVdeELaWSPwS4NSToH3Ikkpp6RBNc/sUBXoqnhiJITdAe6
         AVFA9fLs3G1F0wOnoapbg4RySOlkQHy4UDa+7M20VoMCE3Y3RSpXYS3vm/RcbOzsAb2T
         3i0Tk/S9Fj6K3QEylz4Gg3HgK3kyX9HbXi/8tU4oEfACEcBQ5S4wbbiR7rHYcQi5NIM+
         4xflC9bcNPoYXK/xuP+ysvwJTWVlr/yY8ZoiG8DrnZWYGO/2ZRcDJgY2fOfuHZeKQj6t
         guEA==
X-Gm-Message-State: AFqh2krkA/xnpEKb3qYCg73sHiII3q63lyYGoCJn6XNanL3Ghcdpc0qq
        aoHeKJtb2JP/ldFP7uDlmvO9
X-Google-Smtp-Source: AMrXdXudkSeoeZwsmTfGklt2Kh/SAQNWHjc6/RvV92AIBr1XEprSb9dEjdUIK+mW5midVbFz3uGWww==
X-Received: by 2002:a17:902:8bc6:b0:187:16c2:d52c with SMTP id r6-20020a1709028bc600b0018716c2d52cmr6442361plo.50.1671715144171;
        Thu, 22 Dec 2022 05:19:04 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:19:03 -0800 (PST)
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
Subject: [PATCH v4 13/16] EDAC/qcom: Add platform_device_id table for module autoloading
Date:   Thu, 22 Dec 2022 18:46:53 +0530
Message-Id: <20221222131656.49584-14-manivannan.sadhasivam@linaro.org>
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

