Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768835B54BC
	for <lists+linux-edac@lfdr.de>; Mon, 12 Sep 2022 08:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiILGuu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Sep 2022 02:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiILGun (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Sep 2022 02:50:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63D92980C
        for <linux-edac@vger.kernel.org>; Sun, 11 Sep 2022 23:50:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so11411276pjm.1
        for <linux-edac@vger.kernel.org>; Sun, 11 Sep 2022 23:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=BkU0QN86DJwgcVuXYkBLFx05g7OxXCcrOHXHdeHhmx0=;
        b=Ib+puZ5rARxiUnB1p2NCLcaRSUB+/TEIitSizCzyNhsinhuRt2dKCox9IMq3+gt10V
         F1wZbmd37IIJF8EojmeTg1sudw6KI2fspASITQFUNiy7kjmvRsWyIF3cjRaVG+bnGSoW
         jE+gZYtk8mceTCH7seHKd4mol3uKH8w42B2WBrcU+adHuB0XzPUXluhc6EuWS17wAbZA
         9ddbsfpaDhGKPTfMxDuO+HPr4v2+z9V11Rkc0MTMjM6GfezfXBuK4QjBrFfe04KHwyd8
         +2j5akszwmnWfr/sgaUEXc90EsiPnFAcgKPE7QiXZI4KbPnglm/Rsh9BW6ct2IGsNE4q
         ki6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BkU0QN86DJwgcVuXYkBLFx05g7OxXCcrOHXHdeHhmx0=;
        b=c3FsbO8CYvAIrvMsl+MthSzMrG0VGUX+0zqZpIL9Cnr3SY20InidEPYAsXlNL2x/Ic
         PvhMxBb1jtr6sNXhNGDN6uuca4pGvqoMZ0dCym+/LBtQrHA8HlReQT+sFwGfZ8c80BvC
         4L/zxk3rLxQUfG6GuOlNKAkccuchKtrz0ax1We0CKCAj6kX1n7cr4ZSemkzOdDvbmZEd
         Wr39q+CEdlmHrKXzKq4QpZWUdLzs/XYTgxGSCJBl3+SYOoTx9ClhRDJn9UDp79iB1W82
         5BlzjG9PIuHuHqVmK7Rxl4Pjo3DDwbNBCR2LFrrIA9JXxdgoVrq0k55DlOA79pLW84bs
         qQaw==
X-Gm-Message-State: ACgBeo1tJftmE91BbRVRD5GePFRdOyzXK6JOR/XN3v+hdN7BtrBh0qtf
        yTaC+SjBTM9o7sZ+JsVR39JvFw==
X-Google-Smtp-Source: AA6agR7riNz1Xs+gSc8ea9z9GYGR4sY7z+e89rsvqwplrVCGmLPIaUk4E75qwtv6QWMPVVhXntF+ow==
X-Received: by 2002:a17:90b:4ac4:b0:202:6d3d:3b60 with SMTP id mh4-20020a17090b4ac400b002026d3d3b60mr20783390pjb.197.1662965439181;
        Sun, 11 Sep 2022 23:50:39 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id v62-20020a632f41000000b00430c6fd7ffbsm4705716pgv.84.2022.09.11.23.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:50:38 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 1/6] dt-bindings: sifive-ccache: change Sifive L2 cache to Composable cache
Date:   Mon, 12 Sep 2022 06:50:24 +0000
Message-Id: <20220912065029.1793-2-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220912065029.1793-1-zong.li@sifive.com>
References: <20220912065029.1793-1-zong.li@sifive.com>
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

