Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A855ACDAF
	for <lists+linux-edac@lfdr.de>; Mon,  5 Sep 2022 10:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbiIEIch (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 04:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237771AbiIEIcJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 04:32:09 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2A1F22
        for <linux-edac@vger.kernel.org>; Mon,  5 Sep 2022 01:31:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q15so7965786pfn.11
        for <linux-edac@vger.kernel.org>; Mon, 05 Sep 2022 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=8+7UbJNXJr3orLEQ98ALRb5xPSJtynPRzIcD+aR5ifU=;
        b=mHvU7S5vDDtNt6es0lrJGYL4WrYDvhag9uoc5mOXnDO/l79rg6dEdCGvvOd2jBWCI4
         UKB6cRj2x2rjWxFjE9f/MbS92UEHg0DUrkeqleARbpidc7J7tPvPvwZ9ahge8GwRRvoD
         hxb0TNpuElQC54MIYGW9ou5z273KuhtfxYOBvTEN+/CPKrOMI48gIu2GvviYqyv0I9LL
         L9OTa+EWoC+MH5AyNzeZ/adJEWD+eT2Bh4jqcvokIxm5arNH/COWQFpLDtHlx5n6dLoU
         hx5JCD0kifLVts+jeUlY54kmOb+lGK8JKNaV6nhtYc0Eno9vMuGGjcqAW0ekbsBnsYul
         9ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8+7UbJNXJr3orLEQ98ALRb5xPSJtynPRzIcD+aR5ifU=;
        b=fILWmhBIzL1eYlcekLMfuJm/K8lVVYVH8X6MdRL+C0xJ8Pp61t/aoXiIkLtGN9w+rW
         MrcCpNUGIMKjhwC9+hrgjc7lpRXjIBCARKKyfUq+OEK2cZAQVYMjXagJbTZqlkGJ2X1I
         47uoL2ml675Wj3O3UxPeMPKjG73DY0UgE4KqrDbAY4Ti6SY2j7qKpmIrqkl1iDsbd7n8
         /NnjIEEfQmhHbwp6rNEY86SQLbxbYGyyvLoYLEZxL+2yW2fPjFyM1Yq6fVD4DPOrDxVK
         o4Iqko0rpLoMDpU/5F5xwToYuY97P4KywRDuutdKCIUfHIWLQWM9fUv9E6UuzsBksHov
         WhGg==
X-Gm-Message-State: ACgBeo1bWJBxl/qCn7QuZpbJKdBShCrZ9/L67nDBJusTkPhiM4fZ+gCv
        YJfBSzpl9HniAvYRe4k0+Xwo8A==
X-Google-Smtp-Source: AA6agR7Jtc2YSMuD9owC3LWOBl2oIqLaus6IUSuHxBGJWtpC8+n2PXQ/W1Vg2dwveu+mikWtBuD3Kg==
X-Received: by 2002:a63:8241:0:b0:42b:c6e8:d3e4 with SMTP id w62-20020a638241000000b0042bc6e8d3e4mr35721545pgd.113.1662366694748;
        Mon, 05 Sep 2022 01:31:34 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b00537dfd6e67esm7089721pfo.48.2022.09.05.01.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:31:34 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 1/6] dt-bindings: sifive-ccache: change Sifive L2 cache to Composable cache
Date:   Mon,  5 Sep 2022 08:31:20 +0000
Message-Id: <20220905083125.29426-2-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220905083125.29426-1-zong.li@sifive.com>
References: <20220905083125.29426-1-zong.li@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since composable cache may be L3 cache if private L2 cache exists, we
should use its original name Composable cache to prevent confusion.

Signed-off-by: Zong Li <zong.li@sifive.com>
Suggested-by: Conor Dooley <conor.dooley@microchip.com>
Suggested-by: Ben Dooks <ben.dooks@sifive.com>
---
 ...five-l2-cache.yaml => sifive,ccache0.yaml} | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/riscv/{sifive-l2-cache.yaml => sifive,ccache0.yaml} (83%)

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml
similarity index 83%
rename from Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
rename to Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml
index ca3b9be58058..bf3f07421f7e 100644
--- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml
@@ -2,18 +2,18 @@
 # Copyright (C) 2020 SiFive, Inc.
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/riscv/sifive-l2-cache.yaml#
+$id: http://devicetree.org/schemas/riscv/sifive,ccache0.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: SiFive L2 Cache Controller
+title: SiFive Composable Cache Controller
 
 maintainers:
   - Sagar Kadam <sagar.kadam@sifive.com>
   - Paul Walmsley  <paul.walmsley@sifive.com>
 
 description:
-  The SiFive Level 2 Cache Controller is used to provide access to fast copies
-  of memory for masters in a Core Complex. The Level 2 Cache Controller also
+  The SiFive Composable Cache Controller is used to provide access to fast copies
+  of memory for masters in a Core Complex. The Composable Cache Controller also
   acts as directory-based coherency manager.
   All the properties in ePAPR/DeviceTree specification applies for this platform.
 
@@ -22,6 +22,7 @@ select:
     compatible:
       contains:
         enum:
+          - sifive,ccache0
           - sifive,fu540-c000-ccache
           - sifive,fu740-c000-ccache
 
@@ -33,6 +34,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - sifive,ccache0
               - sifive,fu540-c000-ccache
               - sifive,fu740-c000-ccache
           - const: cache
@@ -45,7 +47,7 @@ properties:
     const: 64
 
   cache-level:
-    const: 2
+    enum: [2, 3]
 
   cache-sets:
     enum: [1024, 2048]
@@ -115,6 +117,22 @@ allOf:
         cache-sets:
           const: 1024
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sifive,ccache0
+
+    then:
+      properties:
+        cache-level:
+          enum: [2, 3]
+
+    else:
+      properties:
+        cache-level:
+          const: 2
+
 additionalProperties: false
 
 required:
-- 
2.17.1

