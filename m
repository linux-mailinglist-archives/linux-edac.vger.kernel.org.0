Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509216B8B64
	for <lists+linux-edac@lfdr.de>; Tue, 14 Mar 2023 07:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCNGkr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Mar 2023 02:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjCNGkp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Mar 2023 02:40:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0535B96C18
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 23:40:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nn12so14399103pjb.5
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 23:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678776044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRCH94INAYNBTN9UMFfZ73anns3LkZY1R6gty5aOJHg=;
        b=KVpZtTfANzauJj677+bEuT5pejek9GXPcrX4gYrtN6aE6ZBi9dMkJ6895LhooworgT
         NFpFesV2sJzZ+jw6cvrlZvSZ0S47uhTgsgGkIRCSpze+zmXBOYjxyf64K84RG1RTctJP
         AM1Me4tlqlF7bGnBOsjd6z8/mrT+Rp6pYXQFFtmChzPgRk6wnRlREKpvU4+GpmYOWsVC
         At8dM0hPwvHmLicKVewi+MvWWrn7SWJDztrwh+gvYaxzYwehRk0wxJ107EUl9gABmeww
         fJT7mS7IJk7++dSTO1DJ19gpE2vjIRBDJ3SP2rZIbIQT7jKv112P2Sg0RteJAs1cFYyf
         wYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678776044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRCH94INAYNBTN9UMFfZ73anns3LkZY1R6gty5aOJHg=;
        b=OFeWH4QXr4F7LZyqugM5b/AktEpX96czD8xGsm0nNEXwBJrq4g5mrrudUX9Q6DJUng
         WPSfWpQTl8ZbdvbgwaYxy9cwqpHaTtWRMVGfRI7xp8zKRHi5t4hleyjDITciLkf/wMX/
         BsT6QtsYcA9oUAyn9/6Ah44gWNOT9r5XHV8IfqWZE0hC1+NSNay3+tMdc47j6wWIfuOa
         BHK8lCvSn3TYhyhrP+3G9IVaW5QXy0iplj+XmOzm1aM1tcpOS+VkqHJmDccAIK1Ov5CD
         hjfrXoflQz1eFsm3ozQUxfOQk4WL/gtpxWF5kCM1PHE8tfEoA8XNqZfJiy/CcENalYLP
         akXQ==
X-Gm-Message-State: AO0yUKWbJp+wHoySnbEevX6GtRNSpKd2xMwqG9raPVgrm4gpj0OtfvRg
        YldT7yGKKo8afkAuWrCMU39Y
X-Google-Smtp-Source: AK7set+ix9BiSfytmuCN55Am/ioASfvZQ6w9PJHm7Fi+24dp/2ozuLhBqG00daQ893gN+Z6+ymBJUw==
X-Received: by 2002:a17:903:2281:b0:19a:9686:ea85 with SMTP id b1-20020a170903228100b0019a9686ea85mr40126604plh.17.1678776044427;
        Mon, 13 Mar 2023 23:40:44 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b0019f363ed8c0sm897497plg.226.2023.03.13.23.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 23:40:43 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_saipraka@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 1/2] EDAC/qcom: Remove extra error no assignment in qcom_llcc_core_setup()
Date:   Tue, 14 Mar 2023 12:10:31 +0530
Message-Id: <20230314064032.16433-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314064032.16433-1-manivannan.sadhasivam@linaro.org>
References: <20230314064032.16433-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 3256254c3722..9cac49596a6f 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -168,7 +168,7 @@ static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
 static int
 qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 {
-	int ret = 0;
+	int ret = -EINVAL;
 
 	switch (err_type) {
 	case LLCC_DRAM_CE:
@@ -196,7 +196,6 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 			return ret;
 		break;
 	default:
-		ret = -EINVAL;
 		edac_printk(KERN_CRIT, EDAC_LLCC, "Unexpected error type: %d\n",
 			    err_type);
 	}
-- 
2.25.1

