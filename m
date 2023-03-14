Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2946B8A85
	for <lists+linux-edac@lfdr.de>; Tue, 14 Mar 2023 06:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCNFiG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Mar 2023 01:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCNFiE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Mar 2023 01:38:04 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73526A429
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 22:37:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k2so7541993pll.8
        for <linux-edac@vger.kernel.org>; Mon, 13 Mar 2023 22:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678772265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3ynFMYwQcpfXg1vBUZGiwqSjOZbWEHjnhI8PWp4GCE=;
        b=CKgY+Md7XM2Dq1AiLHTRelpqNfgoCLeHgyr5CE0eZGmaoLW0paAx3qE3HR67mx8o27
         RaIdjBQdHGMuUMEWzPyUHya+yzGzgiN6mGSgYqMGb4JwI6wom4ahnePuf+Z9IeoD9+dU
         Lx1L/umvPfmE8LUfWULFgO5dfdDt4by0lxqBnUJ7ILNB1Gvltg0UabJITh+k5VcWOtT8
         +EBQbVhUYEiWj3faoMjM7lZdW2Vn4f03oWYISD4ZL3kCLQiMk5JzgCpY5fIF7/jP5Aqa
         IAa8s5P1mIxzGKyNNpZUbJzkqPhYZTDsY0ykLduyKMAe56pRLRog6fb7kow+lHI/Q2Gz
         cvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678772265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3ynFMYwQcpfXg1vBUZGiwqSjOZbWEHjnhI8PWp4GCE=;
        b=g6DkVTzz4ewCrWEbUppuTZWPmE72DHeBaHEa6fWzYn/CPT3lLrD8R1HLOgLFZE00fV
         7zfHt+l/pS0QSjyreLBsAIrHc0GuS1LqT5uERsi5xK1h+dHKB7nANSp6b87cQ3DW42qN
         n64rJ/lCVG4GDTC2JVbRQ/R4K/RYMie6SL4t74z1uIPuLXH+Lo2vkEbtnTBZXIap5RVF
         AuWcCND5RTL3EN9yAJvrVGV4hnqryOKYaVujolOS4PQFQ4V0dDX8aiXVFPqKW02QT/yw
         Zl6y43YuDxtDF9b7QaaYVvDNUwqpgNJgxC5tUBR0k5BiVOVkzbZ2aPRLGQpM+dRN9dxK
         bklg==
X-Gm-Message-State: AO0yUKXRmf+WwRo6WMvSMtLi93+DsSd5oKnurPeXpiwQW9yTfwNwbUWB
        xTIWNJ1P/xCjC7MJ9/9cmmpn
X-Google-Smtp-Source: AK7set+KJTFlY6G8yvIbPj2Zp9jor9UT9jln0Kx0keXKthTtTYkhhTa8OTt8TJg4VoPbK7U+aDUGgA==
X-Received: by 2002:a17:903:1309:b0:1a0:5d0b:c31e with SMTP id iy9-20020a170903130900b001a05d0bc31emr2332917plb.44.1678772265234;
        Mon, 13 Mar 2023 22:37:45 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id n126-20020a634084000000b005034a46fbf7sm675093pga.28.2023.03.13.22.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:37:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 02/13] dt-bindings: arm: msm: Fix register regions used for LLCC banks
Date:   Tue, 14 Mar 2023 11:07:14 +0530
Message-Id: <20230314053725.13623-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314053725.13623-1-manivannan.sadhasivam@linaro.org>
References: <20230314053725.13623-1-manivannan.sadhasivam@linaro.org>
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
index 6570b808fd0d..93b977428a14 100644
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

