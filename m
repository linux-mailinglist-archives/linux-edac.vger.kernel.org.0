Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568384D5776
	for <lists+linux-edac@lfdr.de>; Fri, 11 Mar 2022 02:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbiCKBo0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Mar 2022 20:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241401AbiCKBo0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Mar 2022 20:44:26 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5623ED0065;
        Thu, 10 Mar 2022 17:43:24 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z16so6662029pfh.3;
        Thu, 10 Mar 2022 17:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KOp9n98NAfhyBKNJ48in3QCgAV2shS6ukPZvu9G+Pnk=;
        b=LVNOPTeq7yVHxuiYXioKJHB9ftbJssD3GUhDTaUUQvwJVaOwD7Effmc/GApFA9qRQc
         3JUjSyBADkxNqqar/3xfJRKqrlOQFfO2TNUHKMHuU2zD0Cidcs97hUa32b/pWLQ1LPy3
         KJiQkjuKFzB4Vj2bJU2Tji6O5+7FI8jbNOwo04aoH0pquwW6TWiUWOL3MR0QWBce8zl2
         V78dSkfGBG41e/WaJsD9ctEoV85V5VBfiZAl5yCiGaO/nfm4NMZZp5vW9WGyTBmmgNNR
         YrNMVrrmQ1E009r3QvGYjl1RsinRnMAIjMGcZNFeY9yB+HdoG2EPw/wBfhX9YehF8Gau
         iUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KOp9n98NAfhyBKNJ48in3QCgAV2shS6ukPZvu9G+Pnk=;
        b=ER9RICpwpzQJVdaZKTMD9gcwjbFmmBg2qCNt5or0mp8p1lbk/gRJjhOa3qrwEF6zDb
         aGzWQ1PIp33O6jLCmm8gkeV2tuiiIyWkrcABtYzd5Qx/e2IEc9pgTHcT60Pu9eoJtyvE
         T9Z+n4dMnGaZgr+uD2uIxbW4pnp0TViIc+iTvU3tVIv2VBxrMqLAtlZ4bg800Gm5BaYQ
         lCVJ/WkzXNVbBhliYqylDZzifW2BaoBowjZqUJZeEmzm5+WWYTmxwpHdVw/DocEIPYTE
         W7OajMcsxq+h2Cbci37vQuBaUn2dmHmgb18HaRvtqwnPMzeVTIR4+aPl1AmxS1sE49B7
         YMVg==
X-Gm-Message-State: AOAM533vobMY7GW3vVfNwbKkDozZtGmAeg5hG8aUPai0CFYHb2UE9RNL
        7zJYmKH55EzRQO8lHC2udto=
X-Google-Smtp-Source: ABdhPJz0xp+1E5o5x66MsQoneXrCITG2vLyKkPzvEBWwEiFnnp9pgISelPf0lGRATlCjqDxliHoikQ==
X-Received: by 2002:a62:be1a:0:b0:4f4:c50:4209 with SMTP id l26-20020a62be1a000000b004f40c504209mr7642691pff.64.1646962998996;
        Thu, 10 Mar 2022 17:43:18 -0800 (PST)
Received: from localhost.localdomain ([116.89.135.255])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090a6b8500b001bf564e624esm7194383pjj.39.2022.03.10.17.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 17:43:18 -0800 (PST)
From:   Medad CChien <medadyoung@gmail.com>
X-Google-Original-From: Medad CChien <ctcchien@nuvoton.com>
To:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v3 2/3] dt-bindings: edac: nuvoton,npcm-memory-controller.yaml
Date:   Fri, 11 Mar 2022 09:42:44 +0800
Message-Id: <20220311014245.4612-3-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220311014245.4612-1-ctcchien@nuvoton.com>
References: <20220311014245.4612-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add device tree bindings for NPCM memory controller.

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
---
 .../edac/nuvoton,npcm-memory-controller.yaml  | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml

diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
new file mode 100644
index 000000000000..46f61b0806ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/npcm-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Memory Controller
+
+maintainers:
+  - Medad CChien <ctcchien@nuvoton.com>
+
+description: |
+  The Nuvoton BMC SoC supports DDR4 memory with and without ECC (error
+  correction check).
+
+  The memory controller supports single bit error correction, double bit
+  error detection (in-line ECC in which a section (1/8th) of the
+  memory device used to store data is used for ECC storage).
+
+  Note, the bootloader must configure ECC mode for the memory controller.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm845-memory-controller
+      - nuvoton,npcm750-memory-controller
+
+  reg:
+    maxItems: 1
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
+            compatible = "nuvoton,npcm750-memory-controller";
+            reg = <0x0 0xf0824000 0x0 0x1000>;
+            interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+
-- 
2.17.1

