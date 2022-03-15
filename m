Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE904D9432
	for <lists+linux-edac@lfdr.de>; Tue, 15 Mar 2022 06:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbiCOF4m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Mar 2022 01:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiCOF4k (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Mar 2022 01:56:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED623A5C9;
        Mon, 14 Mar 2022 22:55:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h5so14029568plf.7;
        Mon, 14 Mar 2022 22:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QXDQqZpvCdVKtoVqANwNRMstDUhJJwpS39hbEsKoKQs=;
        b=CVIblUDiGw8kYvTInHv32Eli2kEolQo1I7czw54oOSq5u2FpxWy1LjWoyHdFgBu4k8
         e2y2a1DhrLMvRC8Z5/RdBysU2i6K3EDXprmbBm1vyKB7d3xE249itkqLLZOaHrWxAbDC
         oN1cPcgrAGIlPNx4xU6FgTxLoCc/rMB+lt+zAENUOfAIPQdy0VY72Br26Hm8Y9PXxHS9
         oLYBc4vc5ajcuV6OD4ntfTkqRCL0QmDmRQFvF1kTuSKSDBzoCaFW1nmH/Dn5UrnbPRsY
         i/MhDxdhX9xpgONjzGw2aY82nB8s+F/8dQY2j9tAN4nP/t4kGAWE+uL1klLG6AvNokuV
         nxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QXDQqZpvCdVKtoVqANwNRMstDUhJJwpS39hbEsKoKQs=;
        b=oHf4nvG/lgRcZiMRSx7mllONWEpubZm1L7tVKDhOitgrApbi35PdSXafuZn1VsttCk
         AXods77md7ED354qjzIvlE0j+j3oYz+56+mU2hGF0xYrh1hlN1/9ArDawjnRhL0+tXGM
         DCrlY7GWA7us0sB7b3UdzlH2XkLq5fSFeyJL8dIUxCgAkxbObO0sLzdAXsBYERRyHdzh
         SU8LWlo3GgvbKYcT3YGn/x9o8unPAFCIEgpdQjMnOaRHuWw8vxgdtGN8HF+ev2yzyqg3
         VL6AIRONmLTcdz2Smb36aGzuP/uGGo3KEvOuxVS+jkFwm8TRoM4QkORTrQ+uBUsiPKn3
         NYgw==
X-Gm-Message-State: AOAM531MwGIfVaLSneKkah3rAzXEGC2l4fOxaQCBoQogA/+TMRPAeY1c
        /cIE2a/FkG6HAJa8v+OpggY=
X-Google-Smtp-Source: ABdhPJwtZVljF4KXdkFa4DRFgZCtXatbuarB7Sq4rE94lahO0P7dfBA/i9+1Qx78AxAYNpY/gCrTrw==
X-Received: by 2002:a17:90b:f98:b0:1bf:70fe:90af with SMTP id ft24-20020a17090b0f9800b001bf70fe90afmr2773507pjb.6.1647323727442;
        Mon, 14 Mar 2022 22:55:27 -0700 (PDT)
Received: from localhost.localdomain ([116.89.135.255])
        by smtp.gmail.com with ESMTPSA id w21-20020a634755000000b00368f3ba336dsm18679369pgk.88.2022.03.14.22.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 22:55:27 -0700 (PDT)
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
Subject: [PATCH v4 2/3] dt-bindings: edac: nuvoton: add NPCM memory controller
Date:   Tue, 15 Mar 2022 13:55:03 +0800
Message-Id: <20220315055504.27671-3-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220315055504.27671-1-ctcchien@nuvoton.com>
References: <20220315055504.27671-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM memory controller.

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
---
 .../edac/nuvoton,npcm-memory-controller.yaml  | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml

diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
new file mode 100644
index 000000000000..97469294f4ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/nuvoton,npcm-memory-controller.yaml#
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

