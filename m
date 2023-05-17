Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C8E705FEA
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 08:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjEQGYl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 02:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjEQGYe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 02:24:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB0530DF
        for <linux-edac@vger.kernel.org>; Tue, 16 May 2023 23:24:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24e0c29733fso467113a91.2
        for <linux-edac@vger.kernel.org>; Tue, 16 May 2023 23:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684304673; x=1686896673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfKdoeG8mu6zu/394MW7KJlMb3XJq7sqRyZaWwU7lKw=;
        b=LthWTdYNEHl//JSltdWk6o4MZfNEHIaNGaUvCCXZYbeJF733AaYRuqtb+nfPPRW0kk
         tQi/Ynm9/+RqdtDkeb9Dhwqr0kI9+35GVjH3k0X6uFb916LUQAfbQCvxGQHtwOsUcBt/
         C/fDbm+RWl0c6njfv540SHGchbkG7zlvxoZbamN1Asktng4PH5X4Zod96okvPIfNQLH+
         KnGDcIrEJPn4vnl9N615WDmBSqUrKtneDlZPLp3tss2QppTJEPfFduZ4dYyW1oox2bvk
         IZXpCIqmWpM1x6PjEbLseafyinWRE5ZasmttDD5qJ9q9GXBiGCNCRaQEhf1uiDc3a1SQ
         NoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684304673; x=1686896673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfKdoeG8mu6zu/394MW7KJlMb3XJq7sqRyZaWwU7lKw=;
        b=fidJPP/KjJbn0ijdo+PLlsr9uUTd3TiACQIqSLYbwPxNKI/fYG0wP9G/oflK6Ofrv1
         Y4Itu+El9QXN3/FiA1T6ouE1rRwHlUSwYNLN9CRCpDIPTuQEIBGiMpL1YESmUH4Jb/Cr
         Te8ClBGF4cd1FxEBvuGfK8oTqbHwfyt3Bvq9BamyGQ0XbjzEGR8BBYRyzKeFDIW5rsdo
         Cojqgs9c0Tn6id9so57I/OJxLoXoyXeBE4Bo6s3b+ZMbPg+NuC4MIe6GoH18Xn0BagbX
         d8F48m+75v9ypSmRj8Q3e515RQcGglGCqcdD/bTqFoMPVLPI/mWJGRUHBxQbCTDCfGw2
         /ODA==
X-Gm-Message-State: AC+VfDyYrknmdTPfqr8plWLAjBBWagtfX51yaLzfSjv6Uus5UbB0vh+2
        IoA/+0jjUSar94m84lh51UrZ
X-Google-Smtp-Source: ACHHUZ7qPiZFvMENE+qrkdJFxvEhxBUWv6GWj5OFTtoSWNkxuB+w5W56ExURaU55ZWmVj8d4MaPA+A==
X-Received: by 2002:a17:90a:ce87:b0:250:2d62:d3e2 with SMTP id g7-20020a17090ace8700b002502d62d3e2mr38404744pju.22.1684304673008;
        Tue, 16 May 2023 23:24:33 -0700 (PDT)
Received: from localhost.localdomain ([59.92.102.59])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090acb1600b002508f0ac3edsm693282pjt.53.2023.05.16.23.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:24:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 1/2] EDAC/qcom: Remove extra error no assignment in qcom_llcc_core_setup()
Date:   Wed, 17 May 2023 11:54:19 +0530
Message-Id: <20230517062421.56970-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517062421.56970-1-manivannan.sadhasivam@linaro.org>
References: <20230517062421.56970-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 265e0fb39bc7..53d666ffcb1f 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -170,7 +170,7 @@ static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
 static int
 qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 {
-	int ret = 0;
+	int ret = -EINVAL;
 
 	switch (err_type) {
 	case LLCC_DRAM_CE:
@@ -198,7 +198,6 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 			return ret;
 		break;
 	default:
-		ret = -EINVAL;
 		edac_printk(KERN_CRIT, EDAC_LLCC, "Unexpected error type: %d\n",
 			    err_type);
 	}
-- 
2.25.1

