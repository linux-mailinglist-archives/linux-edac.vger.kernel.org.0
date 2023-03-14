Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1516B8C74
	for <lists+linux-edac@lfdr.de>; Tue, 14 Mar 2023 09:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCNIFB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Mar 2023 04:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCNIFB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Mar 2023 04:05:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7121C1ADFE
        for <linux-edac@vger.kernel.org>; Tue, 14 Mar 2023 01:04:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i5so15721852pla.2
        for <linux-edac@vger.kernel.org>; Tue, 14 Mar 2023 01:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2qLWiEu+kwQHNuuyN9RiYgLYwjEZFKFrGhRPUZl538=;
        b=kUttmv50P6JaqbAfZWMvjFT69NXu1Mn44b5z8H5CQIUokMJkaddWBjXPbDl4gno60y
         bzBIGnQNDD5UZSDt3gbM/Izp479BCMnLTG9AfGHJlfC2C6B+iAqZABelML15p2Dzt+b0
         d2Klm4DT5X8GEJLoh9Sc6MyStWYXaOmXq/+e5p1LhRac/IkExM2EQR9XaQ+aSi1MgmTM
         7ynbySiUWnTa8veOsW7b6wy+WRLB7uU0qosh61Ki3QCwzcC6W1ka89KiBkDjqtOCkHcn
         y1MdyIDsSP8mPcxj7zIbI2Grt7m/m9tuuhiTnEkY8LKZ7ghH1MXeo3tOEnw9DdUhwCyW
         330Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2qLWiEu+kwQHNuuyN9RiYgLYwjEZFKFrGhRPUZl538=;
        b=ZbzQH7+Wx12sXbP7zg8GYKuAVXN12KkLNf6ImTWWgmYMPLx05tGiw7r/QkLDRseVUP
         nuBU4huQjMoAhfYU6aN4xXNFTrfO8TYjH5jCAWJsc2D09CLmL2h+5vdY0gJWf0SZL3oU
         ziaRQiSkitj5F+OptD7kInxGyBzOIbRY4iJbC3tL71C2U4Drh8Uzi0bL+Cy/fI3d+HFx
         PFac3zD6mhKBFZbjX3T5Ah6XKLvcxtDgMotSsupqqlmQcZuGNM3+QoJMnzCkL9Rwlmw7
         DAVRTUAQUn4bBxNq9P5rnptntAZTrJazuPp71VB7JtR6IY7CMuAKTquNPhNhhQ1/oi1V
         VNmA==
X-Gm-Message-State: AO0yUKVwT7unkcUzRFRPo426mbrDMrLaamEihsuJAdREV8Ys9DCXl9vV
        QnWCmlmTwZK3EPfly8vh+AxX
X-Google-Smtp-Source: AK7set/Wuc2f6xzJUbp88JtCtHXmKq6x8/IUFkEzI3k5FSxbK7fOxSRzO6ogfiwCrJFmPAUMq5dQpg==
X-Received: by 2002:a17:902:c949:b0:19a:59d1:389e with SMTP id i9-20020a170902c94900b0019a59d1389emr14167228pla.23.1678781098879;
        Tue, 14 Mar 2023 01:04:58 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001994a0f3380sm1078022plg.265.2023.03.14.01.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:04:58 -0700 (PDT)
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
Subject: [PATCH v8 01/14] dt-bindings: arm: msm: Update the maintainers for LLCC
Date:   Tue, 14 Mar 2023 13:34:30 +0530
Message-Id: <20230314080443.64635-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
References: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
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

Both Rishabh and Sai have left Qualcomm, and there is no evidence of them
maintaining with a new identity. So their entry needs to be removed.

Listed Bjorn as the interim maintainer until someone volunteers to maintain
this binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
index 38efcad56dbd..6570b808fd0d 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
@@ -7,8 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Last Level Cache Controller
 
 maintainers:
-  - Rishabh Bhatnagar <rishabhb@codeaurora.org>
-  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
+  - Bjorn Andersson <andersson@kernel.org>
 
 description: |
   LLCC (Last Level Cache Controller) provides last level of cache memory in SoC,
-- 
2.25.1

