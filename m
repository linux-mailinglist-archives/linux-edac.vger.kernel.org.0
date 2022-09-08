Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7585B20FB
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 16:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiIHOoj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiIHOoi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 10:44:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC9EE3A
        for <linux-edac@vger.kernel.org>; Thu,  8 Sep 2022 07:44:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so2580132pjm.1
        for <linux-edac@vger.kernel.org>; Thu, 08 Sep 2022 07:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=1O4MLVbmX/2gc1Qfnxh9Du1G8eStsMcSf2LwqkEqzqw=;
        b=CF4korFnZ5botkl98V+ysIFWWuooEKPxVpYRIYrlQXlJ0Er70IRasrkpMnG9/WD29r
         HmURGNeghbycuovGIHa+Kk7xNgx1ZQ7pVJUGkziOtFTfkHzK1QKnaUKwx8c7n4DnEXFh
         snsW9yyPo7pirx0A4pfzQ388lif5TmabuC39IGnDsAkv48MP4jeXNi5Q4muEu58hq5lE
         j9cl1E/o3UnYAGZhRNfXt9dsXJ5prGoQXcHLDjvyA8HfCmrv4lAW0YKEFnlZNWvG5RB7
         a8McQq+bWHVvIC5i3za6GWi1y7MuJkE1DV7ygt3EOvcpZIIRoBvRVzBKoB399ZUXkWkO
         mhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1O4MLVbmX/2gc1Qfnxh9Du1G8eStsMcSf2LwqkEqzqw=;
        b=tezs42667T6W8gDM1shQ4JGnGTd15CneCea5Ihn75vRqG5/yS82jqknkrJB6z0lxQA
         RrwWm/Ts0/gXG8/iDV4B/SzIliE2DiK0vvkHbLT9vYRC+ErJMOer/AJWTKI9pSJWR046
         I8/njpypilR+g2n7cUX47HWrWSasGtHhCAeiGQOCophKq1q7H9Q3RS3BBShO8GlDN7wk
         5a3Sun6LVuPTTU62NoZsuPRqOOiZdu4HxRFFCikhuFZ3uT6jS3XqzoTGv1P4ZXGb8Xu0
         e61rRlAED0kknhVnGIsvbmVOdiga3/Ho5tyWCb3QnzaiwDXkJqo+1p/ZDqKGezA9uEAq
         egkQ==
X-Gm-Message-State: ACgBeo1HZDujvUUxQB096w8ZMG7SK013GnFHs2SvluDrb3dTBnpSqoiY
        Qo9dgvfQOVQw/yACPWLbOvJjCg==
X-Google-Smtp-Source: AA6agR4fMCwBAw9So2S8D12dXe5cZLB6a/xZwSPlAPYJak+1KFwxCj6yOCUEkLh9GcOh/8oUsn2oiQ==
X-Received: by 2002:a17:903:264e:b0:176:e9d3:64b6 with SMTP id je14-20020a170903264e00b00176e9d364b6mr8255573plb.172.1662648273289;
        Thu, 08 Sep 2022 07:44:33 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d40400b001750361f430sm4484728ple.155.2022.09.08.07.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 07:44:32 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 1/6] dt-bindings: sifive-ccache: change Sifive L2 cache to Composable cache
Date:   Thu,  8 Sep 2022 14:44:19 +0000
Message-Id: <20220908144424.4232-2-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220908144424.4232-1-zong.li@sifive.com>
References: <20220908144424.4232-1-zong.li@sifive.com>
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

