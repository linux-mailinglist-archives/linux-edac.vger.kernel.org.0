Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE04D4C2496
	for <lists+linux-edac@lfdr.de>; Thu, 24 Feb 2022 08:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiBXHsd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Feb 2022 02:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiBXHsc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Feb 2022 02:48:32 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB217581C;
        Wed, 23 Feb 2022 23:48:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gi6so1306549pjb.1;
        Wed, 23 Feb 2022 23:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pvhTNW6ZF5aiQvYvNOuVOU64LQHqiZfNbJXRvi8CCvs=;
        b=Dm0ptBvzy6N62bQkkICsiqIgImQSUtHYIyzM5AuBjZ3soDdcXQ3dS9h23M7FZ1FUUp
         tvjqc/7+rwZExI0ExomBpbogCKxUYDsoQyXxPvnVqQ0/NCz5l2B4iQugUSMu8vEg7rXq
         G7pbhuPI2k/gGCYz14DOl+XeUUx9p+8PIwiRXJyK1YeBcsB2Xe8+wK8S3gZTXFVkOC2U
         PdTPi/us1NaeG/p2zww+qz3DGzXX551uMhkaUgbGROOngwA2ZdMADtvRoPFQQwlJyrb9
         LA8SKCi6TZiLmVhTOxA9mscr9ycETwlE+6n7lYgGBaCOI5qQxLfqzByXVs3fFE1r3OKR
         QErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pvhTNW6ZF5aiQvYvNOuVOU64LQHqiZfNbJXRvi8CCvs=;
        b=HVmH/zggFDsmRW1rKSvYhwxO2KBphzuyc2vrDflsV7BpJ7NPe/w878HrXLd6xTSpe7
         bZLzHKSqweWXC52fcpWCpEdQ2ij3PEYjZZ7MBCMxN1z1dtwk/uOUKxwgeJfHLpkgWp1X
         T8zAT+7hdyDUCve3w6t9Hr/OoxzMsr1TYpkX5nCDNp3YTVejJLv8SpHr9SKssC3U0HX/
         hiDGBEH4QQOlPyrSJsiW69vdWwijFfb+kNBfpWtAs8h/nYqYtxTV8VXu67F+yiI1OHlF
         hkIp8ncR8lV58Avw4EI25MyNZANJ7GC0YIyLBTkyYI5WYLjhxgAVEwvvdra0RQK0SozG
         K4Tg==
X-Gm-Message-State: AOAM530S7C1v82RyO7FthcXHB8nsCsyWgbKv09LOlVC/oRItGlvHui1U
        GkrgtlgzjDOv04Z6l1oHdZk=
X-Google-Smtp-Source: ABdhPJyPSahfoResPHUOIHrZRCs5akM2EEtv4OFSYv6SOi5I05lLOhiVd92EsKsdu1xgBDOLlEhk/Q==
X-Received: by 2002:a17:90a:d494:b0:1bc:54d7:9e80 with SMTP id s20-20020a17090ad49400b001bc54d79e80mr13180169pju.4.1645688880885;
        Wed, 23 Feb 2022 23:48:00 -0800 (PST)
Received: from localhost.localdomain ([112.78.94.140])
        by smtp.gmail.com with ESMTPSA id z21sm1616839pgv.21.2022.02.23.23.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 23:48:00 -0800 (PST)
From:   Medad CChien <medadyoung@gmail.com>
X-Google-Original-From: Medad CChien <ctcchien@nuvoton.com>
To:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        Medad CChien <ctcchien@nuvoton.com>
Subject: [PATCH v1 2/3] dt-bindings: edac: npcm-edac.yaml
Date:   Thu, 24 Feb 2022 15:47:28 +0800
Message-Id: <20220224074729.5206-3-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224074729.5206-1-ctcchien@nuvoton.com>
References: <20220224074729.5206-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add the device tree bindings for the EDAC driver npcm-edac.

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
---
 .../devicetree/bindings/edac/npcm-edac.yaml   | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/npcm-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/npcm-edac.yaml b/Documentation/devicetree/bindings/edac/npcm-edac.yaml
new file mode 100644
index 000000000000..228ace1025dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/npcm-edac.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/npcm-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Memory Controller EDAC
+
+maintainers:
+  - Medad CChien <ctcchien@nuvoton.com>
+
+description: |
+  EDAC node is defined to describe on-chip error detection and correction for
+  Nuvoton NPCM Memory Controller.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm8xx-edac
+      - nuvoton,npcm7xx-edac
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: uncorrectable error interrupt
+      - description: correctable error interrupt
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: ue
+      - const: ce
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
+        #address-cells = <2>;
+        #size-cells = <2>;
+        mc: memory-controller@f0824000 {
+            #address-cells = <2>;
+            #size-cells = <2>;
+            reg = <0x0 0xf0824000 0x0 0x1000>;
+            interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+            compatible = "nuvoton,npcm7xx-edac";
+        };
+    };
+
-- 
2.17.1

