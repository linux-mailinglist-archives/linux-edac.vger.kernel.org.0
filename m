Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B3565419A
	for <lists+linux-edac@lfdr.de>; Thu, 22 Dec 2022 14:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiLVNSP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Dec 2022 08:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiLVNRv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Dec 2022 08:17:51 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF7C2B611
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:17:43 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso5664675pjp.4
        for <linux-edac@vger.kernel.org>; Thu, 22 Dec 2022 05:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp5/r4pBB7Qfe42Kb/SOy1gZ4/1fvqqZd0eC3Bvgy/g=;
        b=d9BHDr+PPsP+TSxNM0CJCIKo120fJMIwSZS2m3BjHORr7CsHkePASymtvGUYq1l26s
         e2NehLvgfNB2lCBjW2Cp3xzQqtqN5EgUPxl3oz3bBZQayLBdX9W6TDBvkEy6myiFB8Xb
         o5b2OzN5eIGZCA6Z85W7H8uvFBNNRNfbjJiBUMyN0fTXNVx0+8TRLcvgsq0HXosY0meT
         gHvTlOsPZIA3Xkt4gmBlmcPyOk0HLziwmQggcZTCtYYbdroLxyULzVnZzsAoN4Si7s/K
         tdXvty4i4Zt8tWrce/NkQkCRxgxgXYXRJ1tlOpJ79I7q8TegUQ2fgUslis3r5MSGNuA0
         nrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bp5/r4pBB7Qfe42Kb/SOy1gZ4/1fvqqZd0eC3Bvgy/g=;
        b=EPwdnTSx9cGTQaRMPrqtSm8cP/u8a2d7gt9Sukqwz35mEMBGLDdlhLKMQzyndcID2q
         OMheSd/A6q1e1fKfOOOmiTWbRT1B8GoEp53TWj5S5XwirGUVj2jVEUsn/PCdsRrwOhnf
         nnib9krE2RPcFmgSiefVCmDYzoXWo1ujUkyX8Y3InELZYC2UI5Do2IjrEjX4AmCIq7yT
         Xuj+/JGn/TlMgz/Rdh4FgIKlGqjqkaN1S9pMKoo6x9jnbhtkhHjzaevjjtPhWkNvIDlT
         7fPSDTwpyKePDj9agSMDklG8zuAYKyTsfZ3w3mmq5DcBUGjpYHN/L22KS/Wdrawo3XVZ
         3GTw==
X-Gm-Message-State: AFqh2krxcnrCREAFIFX+OPd125J9RNDX+XviQ9W4dds87Umztk7eF83V
        Z6PWjrX77g3EXs6q3c4DBVBQ
X-Google-Smtp-Source: AMrXdXsQhOnQuBfMe9o2xBz7j7/zdg6xem8ycEmxGz9ThgatyoZwCGcCPjtTrgEvSDBztznOKlPJQw==
X-Received: by 2002:a17:903:2444:b0:190:f82f:c937 with SMTP id l4-20020a170903244400b00190f82fc937mr8523352pls.42.1671715062372;
        Thu, 22 Dec 2022 05:17:42 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:17:41 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 02/16] dt-bindings: arm: msm: Fix register regions used for LLCC banks
Date:   Thu, 22 Dec 2022 18:46:42 +0530
Message-Id: <20221222131656.49584-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
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
as the register regions are splitted and the drivers now cannot use
LLCC0 register region for accessing rest of the banks (which is wrong
anyway).

But considering the fact that the binding was wrong from the day one and
also the device drivers going wrong by the binding, this breakage is
acceptable.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
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

