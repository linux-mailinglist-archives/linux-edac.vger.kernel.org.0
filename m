Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E71590BCD
	for <lists+linux-edac@lfdr.de>; Fri, 12 Aug 2022 08:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbiHLGGj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 12 Aug 2022 02:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiHLGGf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 12 Aug 2022 02:06:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D67A6F546
        for <linux-edac@vger.kernel.org>; Thu, 11 Aug 2022 23:06:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so43260pjl.0
        for <linux-edac@vger.kernel.org>; Thu, 11 Aug 2022 23:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VqoFvV/TO3y1CIA8M9e5O4ow47FeHucL7PxBzpxC/0w=;
        b=mKRxW8AwG1tdS59Wf/Elqzf3p25sXPbEOn6JDBVfSRhFX9wUnbgYiTbo+lXonc240o
         rTtya6SO0govok7Muu5+ZjLd1o15igqYMoXp/h7kk2DhYPy+GzexbSUNc1kFWL8DvSwO
         u9FoV95XKQUsIV7jYC+49Ji20uojO6hBCrCRf0cXPMiIsprTmiBvkw/WqqyHha338ZV6
         yMjcSCSE2DcA0IWDfMstCIrKd8xTyD0hjOdjud30W4xpWRfiLjhLcsFieNTu8YO45evG
         tzvzba42CpWlJGUWpHCRwXP0pB2CsJZyU0Tex6UkJsWvCex1G2UGRKEvoIckizfu0TYU
         b1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VqoFvV/TO3y1CIA8M9e5O4ow47FeHucL7PxBzpxC/0w=;
        b=KiOvuNrilXxE2R7zW3htAQxBPdG2Uv5ZnpbI7NGKP1g7hy7WDFKKbEC1e3fZkdDgLz
         k0376i3k9ZALwaJQIJs6XxH9vfKxm8DZbuQc0KhIxo4SwZb27NVMJvzN07rEYbRMbSYt
         nw9pZi4PQmbhs/a3XNn5giNF4LX9ZPdn4YTsUcLa1Ca3UVtXhMOpBB84MPHq9EZ09Bfc
         tMP4t9Mej/OVEGC4UDfN9TKpH4aML56g50Iet5slIhevFeC/v/KDHmfQOSVLYaCIFe6S
         PuZFHN3hAE7M62/ZjD/i22cm/CSjte4Xcx5Ozu7owkzw+FA+YotSS6rifGv8XRzZxJla
         Cr9A==
X-Gm-Message-State: ACgBeo1mm8V2M0kK1w+Ws+Ux1AjGRYHJQmOSr/KKfGll3CwljkYmjGyH
        jFBnB3H5FUIbPneJzRsMuji7
X-Google-Smtp-Source: AA6agR79kBzPpdItXrm5o7hoNp8/lQiqeQ5b6uD41yUqGYXm5Y3AB1dkTIUMNBm5keXRO0PV30EdGQ==
X-Received: by 2002:a17:90a:b00b:b0:1f1:6023:dacd with SMTP id x11-20020a17090ab00b00b001f16023dacdmr11951185pjq.184.1660284392390;
        Thu, 11 Aug 2022 23:06:32 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.103])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016c4147e48asm732395pln.219.2022.08.11.23.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 23:06:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/3] MAINTAINERS: Add myself as the maintainer for qcom_edac driver
Date:   Fri, 12 Aug 2022 11:36:02 +0530
Message-Id: <20220812060602.7672-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812060602.7672-1-manivannan.sadhasivam@linaro.org>
References: <20220812060602.7672-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The current maintainers have left Qualcomm and their email addresses were
bouncing. Since I couldn't get hold of them now, I'm volunteering myself
to maintain this driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 491c7842419a..775f81644bfc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7143,8 +7143,7 @@ S:	Maintained
 F:	drivers/edac/pnd2_edac.[ch]
 
 EDAC-QCOM
-M:	Channagoud Kadabi <ckadabi@codeaurora.org>
-M:	Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 L:	linux-edac@vger.kernel.org
 S:	Maintained
-- 
2.25.1

