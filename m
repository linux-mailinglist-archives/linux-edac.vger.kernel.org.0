Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252AD5B67B2
	for <lists+linux-edac@lfdr.de>; Tue, 13 Sep 2022 08:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIMGSb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Sep 2022 02:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiIMGS2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Sep 2022 02:18:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31DE5726F
        for <linux-edac@vger.kernel.org>; Mon, 12 Sep 2022 23:18:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fv3so10288130pjb.0
        for <linux-edac@vger.kernel.org>; Mon, 12 Sep 2022 23:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=BkU0QN86DJwgcVuXYkBLFx05g7OxXCcrOHXHdeHhmx0=;
        b=byruooSXjxanC2WKqwYGjjup7+zSxnsY6qM7gRY7oF8vX+RlTHULq4L4HqHoFA/YU1
         BFhkc0GKe7oG1ktodZpQo9u1Kma0LUeLmCW2mCrABOPYNpNMS77fOY33Sw6b4ikYLNKV
         qB+H5bxtAep3WFbBbTKuCrmRCDLQlNf6Xk1fhvg7YWV3V7syjwhVXG5UWuz8j6A+j3VS
         m9CtJfKL4ihqkkLEQJcUSKZZvxjIx1GW6PWNedr5CUl7qoGqYFUaPFiYm0/0nJO/SErc
         QSzAXwSBAfz5loaizCaq4+vSJDekrVd8K18Ry8aoxDrnaD88hG+jUPFwQQUTnLzhTYaw
         JsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BkU0QN86DJwgcVuXYkBLFx05g7OxXCcrOHXHdeHhmx0=;
        b=M1JreYrxSwSL/o5orPUOM0MpZe4cqJGXAfw+wTieXnrN2yQ4iCDQfPWzz11EKOQFsz
         /nz/03UGgaRNrfoTCdC81kOOKrHUKIKJYcCjDuiZzwlIDJFEhbJeRJmIfpAOBYYlZlX5
         ibGHOqKWuudvaAJzezfAotSgDHXmcergSQbuGhNZJlqhbhzfqo0SbEnPOVilY1UNg88O
         FuTcE1C3Qs9z3rM/ENwknx1P+zPQtyvKzk0mFXXHz+DRVetL8EanajBbOlZ8rfQuhWx0
         Z0Hhhi/1zPqHVV9ysgs54uL+++RcK+M8BVhRixyXNK6VYAREL1zftQfSJ+aYLk3SffEp
         LrQA==
X-Gm-Message-State: ACgBeo24EDfWDTxAofg4+jjKchgk2ipPBc/NZ5xE7zEixkl7Sq7TTX6D
        kQ/zE6pz5KJDh5lPY0HupNy8UA==
X-Google-Smtp-Source: AA6agR71/x637VLoOitLNPRbvBMn4pFyl+GH1k75dmYQ8qdnNj8sE9cFc/sHeApHkFyW7heqG5PqlQ==
X-Received: by 2002:a17:902:6b4c:b0:171:38ab:e762 with SMTP id g12-20020a1709026b4c00b0017138abe762mr30297830plt.42.1663049907158;
        Mon, 12 Sep 2022 23:18:27 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id z11-20020a170902cccb00b00173cfaed233sm7296332ple.62.2022.09.12.23.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 23:18:26 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 1/7] dt-bindings: sifive-ccache: change Sifive L2 cache to Composable cache
Date:   Tue, 13 Sep 2022 06:18:11 +0000
Message-Id: <20220913061817.22564-2-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913061817.22564-1-zong.li@sifive.com>
References: <20220913061817.22564-1-zong.li@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

