Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4465959E2
	for <lists+linux-edac@lfdr.de>; Tue, 16 Aug 2022 13:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiHPLW5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Aug 2022 07:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiHPLWi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Aug 2022 07:22:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B4C32BAF;
        Tue, 16 Aug 2022 02:47:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x23so8726397pll.7;
        Tue, 16 Aug 2022 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=EV5sK3QQtGgn7So87fXJ03JNW1+XthKqQRby1y0/cak=;
        b=VUj/qPg97/Aym7V7pQMhB1tQQp0Q1hE9MgTiSxCePvmuvEzFzM18gqPRk0JBuRKTi1
         eDP0UvlsiqOK6XlXgzMErEy/SieDfOE+sz0DhjETl/6IAloIQcVC2T4Zk8020C5WbZan
         rovVumk0nMBnhUfZtNnnkBCf4LywMKnedsU+IhzuFjnEQ1HsscVqfkuG8aKP7gbSNWTD
         xiYRc39HMHXMHB5nbvJqd0JM2t2+j7iajceVM/R43Dj0KJI6TnzCj1gx61YJL312GUCa
         oCvHZJFuKSr7MLZ3AUDA4d5yzvlx4miOnkdRrDSnssrBf5OAitRu/9nE77GMlCppWgfx
         v4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=EV5sK3QQtGgn7So87fXJ03JNW1+XthKqQRby1y0/cak=;
        b=XE8vUabP2JgguTNk5ljWigx3AO3w3Tfz/5wja3ZddhBAw/++aXijybObq5Gg6eU+HV
         lTKzoz9vHL23cFoihAjry+I7Qk4qJw2WcGJA+vsmuXCZD/hrQVm2htsXw+zTaV0Ru4cJ
         eGMJFVRCru9oZO7j/pzutCwdw43JyuVwA3cy7361JoDIdUw7xfrLY57W5jkSZYsySARQ
         xuCvht+uW6Mip2kryCzOSz+pGmJYFeLy/CCwYtICU4tac0hS5G46uoejlt2JUqZD6+jR
         obK6EaeWjKZ252oX/JBmCBD/n2QVpHmuEfuHmoQYbzQnbSUmb4A1ozIH12z1NCz8UbB6
         Jtlg==
X-Gm-Message-State: ACgBeo2AETr1Jt4T5IYtcC9HMYHisGZYih30KhR4eCeVSBzWEt298cFL
        /6u9qeU4cVpnDPHUPSTQWJZ63nHTSf5mGg==
X-Google-Smtp-Source: AA6agR6CBTT93XajfwIxe6VR4/Aw1ACc0P0Iib3jKiNRtPezhumdNiwtMYXSWsl4CDUBFe7q3AlmFg==
X-Received: by 2002:a17:90b:3ec1:b0:1f5:15a6:aaf5 with SMTP id rm1-20020a17090b3ec100b001f515a6aaf5mr22866488pjb.123.1660643226167;
        Tue, 16 Aug 2022 02:47:06 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902e98c00b0016bee668a5asm8578767plb.161.2022.08.16.02.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 02:47:05 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     linux-edac@vger.kernel.org, rric@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, mchehab@kernel.org, bp@alien8.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v13 2/3] dt-bindings: edac: nuvoton: Add document for NPCM memory controller
Date:   Tue, 16 Aug 2022 17:46:40 +0800
Message-Id: <20220816094641.8484-3-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816094641.8484-1-milkfafa@gmail.com>
References: <20220816094641.8484-1-milkfafa@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add dt-bindings document for Nuvoton NPCM memory controller.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 .../edac/nuvoton,npcm-memory-controller.yaml  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml

diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
new file mode 100644
index 000000000000..d5ef7e7a65f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/nuvoton,npcm-memory-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Memory Controller Device Tree Bindings
+
+maintainers:
+  - Marvin Lin <kflin@nuvoton.com>
+  - Stanley Chu <yschu@nuvoton.com>
+
+description: |
+  The Nuvoton BMC SoC supports DDR4 memory with and without ECC (error
+  correction check).
+
+  The memory controller supports single bit error correction, double bit
+  error detection (in-line ECC in which a section (1/8th) of the memory
+  device used to store data is used for ECC storage).
+
+  Note, the bootloader must configure ECC mode for the memory controller.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-memory-controller
+      - nuvoton,npcm845-memory-controller
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    ahb {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        mc: memory-controller@f0824000 {
+            compatible = "nuvoton,npcm750-memory-controller";
+            reg = <0xf0824000 0x1000>;
+            interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.17.1

