Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4152B4E3727
	for <lists+linux-edac@lfdr.de>; Tue, 22 Mar 2022 04:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiCVDDs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Mar 2022 23:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbiCVDDs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 21 Mar 2022 23:03:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086503153C;
        Mon, 21 Mar 2022 20:02:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v4so14583039pjh.2;
        Mon, 21 Mar 2022 20:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xJ9GfFhZddrKv5u5rmWflw0LJ2oRtvcB/gDMBiL/rp4=;
        b=M8P1oLahsOLmJTBWPq6/rIKRcHQ7HtBE1Imq6Cr/Wbqea6x0iHQIheO0+NBo6TX8ds
         lEPh6RUteANxutB9Kg+HGuMLHmq74rVfWmzWh3qoAYEP/5BzUuWd1s4T+GN1msD9AXEl
         N0/L+JchOwoAL9CKwtuFMyBy8oWR4+jcBE350hgylL0HRRcEZN2mikFiLnt2ItJRxDwJ
         E33bTj+I74uYJyAb1fPVJiXDmInACOsu/xuIKITq4GbUu6UF7JNmRekYkVSl8HREDeZi
         ueHQ7kFOwcK3eHzjpPI3HSQbJNmbnRw4nF6QDYBfwRJ3fbKqxQrAG0S1CQ+QRPJTTSTu
         CQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xJ9GfFhZddrKv5u5rmWflw0LJ2oRtvcB/gDMBiL/rp4=;
        b=FnW3/t8buGYrQz48ynNPUi1xDsTkD9g4Az+hwfdLrCIf8YbUO3wsgEev0bnNGisDRv
         FsnjSNZuFKH+K1fHeLniJv6l9mG+22y78Eq9Ei3VZ1VebTyJ2E1DvsAc9lXLa1HoFKca
         JvvNKdU4gPwEU/nolkOiaFubKt7fem+MRvTq2oKMk3w+2DzRQet8jw6giCo1uY1cI/x+
         B1/GF2WQI/dxloBw6VcRm+ZznKFVyAH/71qsSnm257f1Gq5+xRRt0z/vywhbHcTVvcJ2
         zrvSDLgo0a5VvPJtOOcDzeVa5WVoEtbD0PmrnT6Av3dG8tgQPHU9vTY37gtSm2Mqo25N
         4htA==
X-Gm-Message-State: AOAM533d5FFiZp3Xw4ilhSICXNJzuzDzu7hXngvrGSSWcsd1juA4yj6a
        CI3G7UFFxPtPXJ1cAxQHBJQ=
X-Google-Smtp-Source: ABdhPJxejzOS7CmfYnr2p9hbK5RbYdFK7B1XowQFBemWphsmp6UG/GFFh1k8JhjVutbh78bBFULRMA==
X-Received: by 2002:a17:902:d4cc:b0:154:3174:e4ff with SMTP id o12-20020a170902d4cc00b001543174e4ffmr13652769plg.134.1647918135489;
        Mon, 21 Mar 2022 20:02:15 -0700 (PDT)
Received: from localhost.localdomain ([180.217.158.152])
        by smtp.gmail.com with ESMTPSA id f14-20020a056a0022ce00b004fabe9fac23sm16660pfj.151.2022.03.21.20.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 20:02:14 -0700 (PDT)
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
Subject: [PATCH v6 2/3] dt-bindings: edac: nuvoton: add NPCM memory controller
Date:   Tue, 22 Mar 2022 11:01:51 +0800
Message-Id: <20220322030152.19018-3-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220322030152.19018-1-ctcchien@nuvoton.com>
References: <20220322030152.19018-1-ctcchien@nuvoton.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

