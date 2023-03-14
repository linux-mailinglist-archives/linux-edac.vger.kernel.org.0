Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9569B6B8A82
	for <lists+linux-edac@lfdr.de>; Tue, 14 Mar 2023 06:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCNFiF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Mar 2023 01:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjCNFiD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Mar 2023 01:38:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFB495BF2
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 22:37:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so4887800pjv.5
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 22:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678772260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2qLWiEu+kwQHNuuyN9RiYgLYwjEZFKFrGhRPUZl538=;
        b=BxxSAemif3HMqEBDGRssBokbkkaHm51vUuIzdJK/3H++ZYNX9HnjmVXIIgCVNGJ4xB
         4JbzAw5ygYQFgdkjMPKz7Cqupde1QscsZt1N28G8TkGyd/ZNg5hhyEw6Uo0ggqBezmVB
         uDYxWI7yt5SO7kwY91lKEVf0+uWmjbBsAsmt9ObcXmF6tYQXI6zRbgjWlJx0PKsus2YW
         5k8r8Vlv4cfKjbAsSgkXKYBv9Bm+9pvKFNBcDYKsXurGSxp4W58YRjERsu9b4IaWGQHq
         2xPs3EB9OBpNz13YCaLeWBP+DlPcTUGEz90Ju0StX8bodB8jJr+dmErzLt6fuFN0F55v
         kLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2qLWiEu+kwQHNuuyN9RiYgLYwjEZFKFrGhRPUZl538=;
        b=putUAVZxtaraYZ/Cfp6v2ZLyGZSlVIC37qbgjQrgwQ5qrCOUwkxKWg5GtxGsutvNwD
         yWcaO1eIT3iVumiVSEdP/dJ5FuVxwf+LLbTWCJD2h9AflYhpE+rFcbGOgUuShh875V4j
         lpkkmAY2xIYAegagD9NlEVWkGjUfhKoeh/IDtQMlv/6mO6TMv/ywVJjt70ekzksPi6yk
         iBKeMf+sNTNfU6usQPRJEjMp3vYxrj9xept2R5Jcd/sR4TE1mWLXLmmW6q1GzeuI48YG
         u6Zg/6wDedW8jdu5w8a/jLs83f3dKp6VFqKmgcdfOgkjWoZlWSBUoYcHQYaU3S2ec6Xs
         O4Ew==
X-Gm-Message-State: AO0yUKVcG5PPHqgbHWIU9DZffPTqA/42TzPZgpBxxOQLLmL09WfWohnm
        cLlDHJKOwF5zr9U7+4lvfm6C
X-Google-Smtp-Source: AK7set/tW8wGTpZIWi5ofRK6X2Wv0YYAJC3DAVTOdzgj/xECKUeNCPyeIhXQ4KNoQxMfnH3fCqvUoQ==
X-Received: by 2002:a17:902:a986:b0:19d:297:f30b with SMTP id bh6-20020a170902a98600b0019d0297f30bmr28982374plb.19.1678772259922;
        Mon, 13 Mar 2023 22:37:39 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id n126-20020a634084000000b005034a46fbf7sm675093pga.28.2023.03.13.22.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:37:39 -0700 (PDT)
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
Subject: [PATCH v7 01/13] dt-bindings: arm: msm: Update the maintainers for LLCC
Date:   Tue, 14 Mar 2023 11:07:13 +0530
Message-Id: <20230314053725.13623-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314053725.13623-1-manivannan.sadhasivam@linaro.org>
References: <20230314053725.13623-1-manivannan.sadhasivam@linaro.org>
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

