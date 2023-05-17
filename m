Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FDC706715
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 13:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjEQLqu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 07:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjEQLqt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 07:46:49 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA3030D6
        for <linux-edac@vger.kernel.org>; Wed, 17 May 2023 04:46:48 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53063897412so600203a12.0
        for <linux-edac@vger.kernel.org>; Wed, 17 May 2023 04:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684324008; x=1686916008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwNQCA9ozgCFKqQivomJuANGu4rucg7HtzAq9d/gM0o=;
        b=z3+Ugw4k7EP8q1WKGKC5FCv+BJdDqyFA7a+iyE7kIv60S8X4NnTL1Wo4zmHQ/dGUwG
         TBWUWU5jKvFKU5DmR+vGOBtGJe9qBeGnJ2g6Ce94WiTplmmHuj/ifJLa5xmJ5u7ivgbJ
         3nFXw2G8RwvmuSTyPx3PlwEXpkkoCA4Q0e+wI+yx9EZeWLweViqZ68PPtDH8fFchEuai
         V2uDi3SsrX5bTmaCj+eX5hLHlzxSJ5E9Xuvy1P0i0jkvTogyi7DosRcGQFHAg4+MSAiO
         H/0Nm6oqYo5HKLExVW5ekrChA7JT+AwuqwTXeEB5r6+GzfFyMC0P9Jdu4kB58FoYASKD
         LJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684324008; x=1686916008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwNQCA9ozgCFKqQivomJuANGu4rucg7HtzAq9d/gM0o=;
        b=kmM+zaTu5tc8C3pri2UUaniq4AKeAPdzvHfquL3RsGXNJU9NDPDedzlMw0c7sE4AaO
         uQhmhkFmSaX1DXKBAMBTzyfJJdNOfgGP4w91Ya7k3TvzqJuM2c9VmsEyG1Z764kZLgQP
         DlynZLTuM9B+qm1QulAmHX6y1CNz+mwAaCmckdSp0bWvoBXIqu13xrElgrTWxh3MhpAu
         vtJkI+4KQQ5uCIbgq0yeOvTkBTh5rvjAzMhm33I7VQtbivc3jTAHIY1FzJ1JUiR0hz9w
         lwb4VvsK8ndDO55Y69kvdrGADRQohwLNW44rjFvgkmQ63vchI4dcWcnbh/XCc1qFHcVc
         1Uag==
X-Gm-Message-State: AC+VfDwBCrxXV8WWGDXQUNqpwIzYHekjkZMBIc8FyHHPIOKB7eEiqQBH
        XjfgfYSAHaPFiSjjC9LXjjqu
X-Google-Smtp-Source: ACHHUZ5EYEW/ICrZAuG6MA7oFcdnFAe59sZovawyPXM++2NcP0NFH11weDO7HnaNwSy6kGXljjWi6g==
X-Received: by 2002:a17:90b:33c7:b0:250:69c7:a95e with SMTP id lk7-20020a17090b33c700b0025069c7a95emr33058167pjb.48.1684324008246;
        Wed, 17 May 2023 04:46:48 -0700 (PDT)
Received: from localhost.localdomain ([117.207.26.28])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090aba0c00b0025289bc1ce4sm1366971pjr.17.2023.05.17.04.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:46:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v8 1/2] EDAC/qcom: Remove superfluous return variable assignment in qcom_llcc_core_setup()
Date:   Wed, 17 May 2023 17:16:34 +0530
Message-Id: <20230517114635.76358-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517114635.76358-1-manivannan.sadhasivam@linaro.org>
References: <20230517114635.76358-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

"ret" variable will be assigned on both success and failure cases. So there
is no need to initialize it during start of qcom_llcc_core_setup().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 265e0fb39bc7..6140001f21c4 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -170,7 +170,7 @@ static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
 static int
 qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 {
-	int ret = 0;
+	int ret;
 
 	switch (err_type) {
 	case LLCC_DRAM_CE:
-- 
2.25.1

