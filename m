Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CB3645BB9
	for <lists+linux-edac@lfdr.de>; Wed,  7 Dec 2022 15:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiLGOAK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Dec 2022 09:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiLGN7n (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Dec 2022 08:59:43 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634705C0E0
        for <linux-edac@vger.kernel.org>; Wed,  7 Dec 2022 05:59:42 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 124so17553596pfy.0
        for <linux-edac@vger.kernel.org>; Wed, 07 Dec 2022 05:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbt/wWAyXr8PXcpioECD5vFFYMiQG8G3AvxtqAGhEMs=;
        b=kFfZArHTfDZyg80wIAXF2jXhRpajwGRdSNrIM3HfbngbOS0QtYcZPhbpe5uywZzdZH
         eLlbtPhDElNZb29dTOLVwJNEzDn30mD3CXEIsZC1EqXA7i4TtJEXPnRNU9X8C3UG0fKo
         KcSbcpLX7VnuZANz8Rgq16oceq0ru5Utg4qYw4uQ3nYv3iefE53We/AJ4t+7fHjE5BE2
         PGUVRG8oikyKil9hkWrvppK+FobpOF6g9wGO0xzvgulFp4SpAZ8v+N1EuhVcS+YPNfkX
         YE3gQ5SGN1O8QrWsZkLUlL2+on8lIO3jvDSHWU2o9l6gqXAFf5z1edVF5e4BwwNyiGlD
         vgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbt/wWAyXr8PXcpioECD5vFFYMiQG8G3AvxtqAGhEMs=;
        b=a+a/mG+8ffW1YvwOddLij0zHIp2lA3j9kGsqZJBrNb3OlhINQKv1+09OmLGj99LTid
         K6NdvAArZ8vp8TW+rfNMHgOMp6nSibBQ+JD+r2IsRHKmx3kNuOCtrZ2ooqqHbm0DrMas
         kMUlncvOGJHk6CbtfHXM1yF1RaBP3UJkQ1vL0aKOsK8wMAHofjkdDrCvBTU6YWrhcVEo
         AvfO7EiK6vMT4ueuXiUfD/TVbSzxcoY2sXjn0jExpd8N6ITle9R65uh+FqnEMTTXdp2K
         LQ7d6mR3jsUgVPB2H+duaRYFZCGthvzUZCS9ZpbBKUOQ6EWqvDvj85Mfg0gOo0zoEcfA
         FLJA==
X-Gm-Message-State: ANoB5pnpwmqKrPMaMRN7xcrAef114K4koVfjStbtwcIsGxGVNjb7x/uG
        eJ3J0kpqwQemUyoGHdqfeLQo
X-Google-Smtp-Source: AA0mqf4QQLyq9qg7F06RacynLG0Ato69wyZRZbPYGStTm+etW2JDllqAdNf2n23oFnUs7Rv+XpRwpg==
X-Received: by 2002:a05:6a00:2883:b0:572:7b49:4f47 with SMTP id ch3-20020a056a00288300b005727b494f47mr76693326pfb.16.1670421581852;
        Wed, 07 Dec 2022 05:59:41 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.5])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b00186b69157ecsm14720160plg.202.2022.12.07.05.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 05:59:40 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 01/12] dt-bindings: arm: msm: Update the maintainers for LLCC
Date:   Wed,  7 Dec 2022 19:29:10 +0530
Message-Id: <20221207135922.314827-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
References: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
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

Rishabh Bhatnagar has left Qualcomm, and there is no evidence of him
maintaining with a new identity. So his entry needs to be removed.

Also, Sai Prakash Ranjan's email address should be updated to use
quicinc domain.

Cc: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
index 38efcad56dbd..d1df49ffcc1b 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
@@ -7,8 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Last Level Cache Controller
 
 maintainers:
-  - Rishabh Bhatnagar <rishabhb@codeaurora.org>
-  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
+  - Sai Prakash Ranjan <quic_saipraka@quicinc.com>
 
 description: |
   LLCC (Last Level Cache Controller) provides last level of cache memory in SoC,
-- 
2.25.1

