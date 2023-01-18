Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D76720AE
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jan 2023 16:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjARPJv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Jan 2023 10:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjARPJo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Jan 2023 10:09:44 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302A12B601
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:09:42 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id b12so24714475pgj.6
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXuVNaTN8VlggSdcrqnxpaEGm5VyBVkNPNZuLm2UVUQ=;
        b=eXeh3yGVsH9ffM3jicbIsyf8jsrDa5kqR1E3UQGIGTQKTitp9gSaGd/JMuK3t0iLYV
         KkFtkPPrZx/r5KylQPaS0s9oAh/m3W3HdLeoW8VFxGfXHDRQdsmTCFO0av+fur/vi1TX
         RLqXV/qF4sBk0DEHhysTXbZ/LYRTl9CkwQEGhiOaZCVbohgbfATxUbeeJxB2Xnl7hban
         d7yprmgPtYXdFxIhx8pJQ9fhGzxuyFtIj4Rk9lB/bi1hhoZGyNvW8ijm3c2fwvLk25jF
         PeDCF6M0So7AyXvaNw0N9vI/Khm4ATbMS/SKqzlIzWvh/eUTxDR/zJ8VJ5EDM7Z5Opjx
         VjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXuVNaTN8VlggSdcrqnxpaEGm5VyBVkNPNZuLm2UVUQ=;
        b=w0QkT/rFlFFhslhHObyMilTkIBBN1mokm5mGn5yhJ7oA1bwOKnMit2s3j+mfJdWU3W
         WLyUvBHh78yOB7B+aiQ9ijrScJiV3jD4V2Uz0Big7E2ypDBuG/a5qi5smAkeI7APnSQb
         yiS7krn/ZQPK9N3eBkAQKLr5Nj7MQ6eRNBJTryozsMsJNYyvn0ybVQ2VTNU4McT0JWCX
         ObMnq0I5gb5IsdAsVLLnMwJnIUKvlQgo4r2XG6cKkHlnp+zys9KVVwgDFftnBM3lpl8I
         TL53ONcvHlIFX2rFbgGFYxtKTVMWF2rZxDzJ3OQSr2v+rJWdO5Y1xKF/ZC1psN2cGTmx
         M8gQ==
X-Gm-Message-State: AFqh2kp7rgMxPJEkP20VMLeuRthpaUhTOkZ0I4Z2XCnpzObcfETnlgD6
        DXurYk05S6Zw8lZ27GVOSglm
X-Google-Smtp-Source: AMrXdXupg+FJU9gCGZn0pA4MSvTGTZj/iNGqwm+Tn9dHNYuSRVGDFJsSd2WJPflryOxKI2zn2RlM1w==
X-Received: by 2002:a05:6a00:3390:b0:58c:6ba1:58dd with SMTP id cm16-20020a056a00339000b0058c6ba158ddmr8010503pfb.11.1674054581652;
        Wed, 18 Jan 2023 07:09:41 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.61])
        by smtp.gmail.com with ESMTPSA id i15-20020aa796ef000000b0058d9623e7f1sm6721544pfq.73.2023.01.18.07.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:09:40 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 05/17] dt-bindings: arm: msm: Fix register regions used for LLCC banks
Date:   Wed, 18 Jan 2023 20:38:52 +0530
Message-Id: <20230118150904.26913-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
References: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
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

Register regions of the LLCC banks are located at different addresses.
Currently, the binding just lists the LLCC0 base address and tries to
cover all the banks using a single size. This is entirely wrong as there
are other register regions that happen to lie inside the size covered by
the binding such as the memory controller and holes.

So this needs to be fixed by specifying the base address of individual
LLCC banks. This approach will break the existing users of this binding
as the register regions are split and the drivers now cannot use
LLCC0 register region for accessing rest of the banks (which is wrong
anyway).

But considering the fact that the binding was wrong from the day one and
also the device drivers going wrong by the binding, this breakage is
acceptable.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/arm/msm/qcom,llcc.yaml           | 125 ++++++++++++++++--
 1 file changed, 114 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
index d1df49ffcc1b..050e21d4a03e 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
@@ -33,14 +33,12 @@ properties:
       - qcom,sm8550-llcc
 
   reg:
-    items:
-      - description: LLCC base register region
-      - description: LLCC broadcast base register region
+    minItems: 2
+    maxItems: 9
 
   reg-names:
-    items:
-      - const: llcc_base
-      - const: llcc_broadcast_base
+    minItems: 2
+    maxItems: 9
 
   interrupts:
     maxItems: 1
@@ -50,15 +48,120 @@ required:
   - reg
   - reg-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7180-llcc
+              - qcom,sm6350-llcc
+    then:
+      properties:
+        reg:
+          items:
+            - description: LLCC0 base register region
+            - description: LLCC broadcast base register region
+        reg-names:
+          items:
+            - const: llcc0_base
+            - const: llcc_broadcast_base
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-llcc
+    then:
+      properties:
+        reg:
+          items:
+            - description: LLCC0 base register region
+            - description: LLCC1 base register region
+            - description: LLCC broadcast base register region
+        reg-names:
+          items:
+            - const: llcc0_base
+            - const: llcc1_base
+            - const: llcc_broadcast_base
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8180x-llcc
+              - qcom,sc8280xp-llcc
+    then:
+      properties:
+        reg:
+          items:
+            - description: LLCC0 base register region
+            - description: LLCC1 base register region
+            - description: LLCC2 base register region
+            - description: LLCC3 base register region
+            - description: LLCC4 base register region
+            - description: LLCC5 base register region
+            - description: LLCC6 base register region
+            - description: LLCC7 base register region
+            - description: LLCC broadcast base register region
+        reg-names:
+          items:
+            - const: llcc0_base
+            - const: llcc1_base
+            - const: llcc2_base
+            - const: llcc3_base
+            - const: llcc4_base
+            - const: llcc5_base
+            - const: llcc6_base
+            - const: llcc7_base
+            - const: llcc_broadcast_base
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm845-llcc
+              - qcom,sm8150-llcc
+              - qcom,sm8250-llcc
+              - qcom,sm8350-llcc
+              - qcom,sm8450-llcc
+    then:
+      properties:
+        reg:
+          items:
+            - description: LLCC0 base register region
+            - description: LLCC1 base register region
+            - description: LLCC2 base register region
+            - description: LLCC3 base register region
+            - description: LLCC broadcast base register region
+        reg-names:
+          items:
+            - const: llcc0_base
+            - const: llcc1_base
+            - const: llcc2_base
+            - const: llcc3_base
+            - const: llcc_broadcast_base
+
 additionalProperties: false
 
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-    system-cache-controller@1100000 {
-      compatible = "qcom,sdm845-llcc";
-      reg = <0x1100000 0x200000>, <0x1300000 0x50000> ;
-      reg-names = "llcc_base", "llcc_broadcast_base";
-      interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        system-cache-controller@1100000 {
+            compatible = "qcom,sdm845-llcc";
+            reg = <0 0x01100000 0 0x50000>, <0 0x01180000 0 0x50000>,
+                <0 0x01200000 0 0x50000>, <0 0x01280000 0 0x50000>,
+                <0 0x01300000 0 0x50000>;
+            reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+                "llcc3_base", "llcc_broadcast_base";
+            interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
+        };
     };
-- 
2.25.1

