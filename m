Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC7D62C0FD
	for <lists+linux-edac@lfdr.de>; Wed, 16 Nov 2022 15:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiKPOeW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Nov 2022 09:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbiKPOeN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Nov 2022 09:34:13 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CBF115C
        for <linux-edac@vger.kernel.org>; Wed, 16 Nov 2022 06:34:11 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so3855767pjt.0
        for <linux-edac@vger.kernel.org>; Wed, 16 Nov 2022 06:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lhl1Yht7Jl4WGhfsN3KHnbxlZqqtqyTEjZ2u2REimHo=;
        b=NQ/yAKYrWw5ryFKeCE0e7gFddbKS+fcQjrzAGvCCHJx7/OUhpC2Oc+B26Q8hkuNXKG
         TZ46biv4Aj26yUpHbTmcsGXx3+wlGZLaf5iUs1YtpVHuzPFzWzdUCO1V7I+pJX1lTnVX
         +RYT4mzGNjy6zz6klYzy0xiOAV3Be7OxM9wb+X774MAeaOBZTpJP79go/Y2mkHTukv9p
         j0PrUqoNW5MDcAf76OszkkK3zzmY9rrotRmsAAqN1c+KcjtLeBIvas4E6Ev2hqpxnpv4
         h5QUq+qaIc/qnKvh5ZtapY578Si6ijI024NofjRl7c5TKza/infaOmeZ1Psb1f11MBBi
         Q1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lhl1Yht7Jl4WGhfsN3KHnbxlZqqtqyTEjZ2u2REimHo=;
        b=HEp8g0HyAHXnL0cmMcQlDm2ja6LBu6s3z1tSYG7M83uOPpiI7aFnr1c1panMSWbX9C
         HG+qttUGM+G5KmCVe3HTGdeFtFJ5ORVcwoY6ssSvzWrpftLFfr5fPa7cg535wPnSqYKG
         CaAFdmhRBtEFQUiZz+JficT0+bBCgzTCWrEGb1jQ9cwpBgeugqsGHxZABefU1LtQ/ncR
         5aeyF+zYWGiD0ABGV/gsWwmJ2A/oeKcf7bq0ok3KgVO7xztkygQG0N7/WedyiuNCQwL7
         ns+swV8nmsUT8y3BvDRXp7sPeXLwvrhD3DnKq6yDskPPgPqXPGmCZBvhey/CF7vYaA84
         J1pg==
X-Gm-Message-State: ANoB5pnuKzsuTxeJUrSrSNCm0WlxlBzlQzjBid38o6qjMzgHOUoDmXqr
        4oAdlwSHlyIimzQy3Mx+X80f
X-Google-Smtp-Source: AA0mqf7jrrj5npS2T7rtO8L5zePtZFKr1f2c6phSPRL0F+WKl76jwksE+P+kaHC4lT6Q1Edndg0T2Q==
X-Received: by 2002:a17:902:76c4:b0:187:1c65:e208 with SMTP id j4-20020a17090276c400b001871c65e208mr9111929plt.173.1668609251468;
        Wed, 16 Nov 2022 06:34:11 -0800 (PST)
Received: from localhost.localdomain ([59.92.100.153])
        by smtp.gmail.com with ESMTPSA id e8-20020a63e008000000b0043c732e1536sm9560974pgh.45.2022.11.16.06.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:34:10 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_saipraka@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 2/2] EDAC/qcom: Remove extra error no assignment in qcom_llcc_core_setup()
Date:   Wed, 16 Nov 2022 20:03:52 +0530
Message-Id: <20221116143352.289303-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116143352.289303-1-manivannan.sadhasivam@linaro.org>
References: <20221116143352.289303-1-manivannan.sadhasivam@linaro.org>
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

If the ret variable is initialized with -EINVAL, then there is no need to
assign it again in the default case of qcom_llcc_core_setup().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 04df70b7fea3..0b6ca1f20b51 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -126,7 +126,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
 static int
 qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 {
-	int ret = 0;
+	int ret = -EINVAL;
 
 	switch (err_type) {
 	case LLCC_DRAM_CE:
@@ -158,7 +158,6 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 			return ret;
 		break;
 	default:
-		ret = -EINVAL;
 		edac_printk(KERN_CRIT, EDAC_LLCC, "Unexpected error type: %d\n",
 			    err_type);
 	}
-- 
2.25.1

