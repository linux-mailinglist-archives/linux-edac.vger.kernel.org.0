Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC780545F84
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jun 2022 10:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347688AbiFJIn7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Jun 2022 04:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243453AbiFJInz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 Jun 2022 04:43:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1DD205E3;
        Fri, 10 Jun 2022 01:43:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id bo5so23296445pfb.4;
        Fri, 10 Jun 2022 01:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8BinpoYpAj5+YbnUMIdRgheWrCsfK9f4139iiy8RFN8=;
        b=c/XhrBKhkMfgbYzQNN1cSM+1mGAXc418ORaVkct/ctrTy9VIuIp7Y9VDoZlPJ4BIe7
         SQi559COCxa/drLRpqeKa95TZY4rxltATjk0+E5QgtLanoowsHHu1biG3uGXZ6cVtoWQ
         NKMfmQ78Wr64gcJSS5uiFJuy3GjD6N2PKwhqEk9hyUW/qiXwftc1L6NqwiDP6Bp28Mr1
         MzbQNmAR6STG/yAuRWIO0qx3VdmhMD7HNvEfkDGfyygxOK1CNhjrZ9YlOn7T4lbEFqHT
         +yuVnfkO/NoD5xSoJSN8aHlntBkHOSt5SNb9xWgpo7qf7BQCPXpcuKHG1ZZK7Vf+ek3+
         TYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BinpoYpAj5+YbnUMIdRgheWrCsfK9f4139iiy8RFN8=;
        b=BYaY8LdPbEY7yaKKMMaVekAbn+OY51B41WbsRHl6wc4msF4g/Zt3EEozwbA9ZZi8QA
         YHLZPuZZ/D421S54c8x8Hp6DrxvjQ8SD93BjIulIDSaxBdNwCDeeN5OUja8t2lxHRMI6
         rgDFmQR1P9yl7EsqGS7/CUqW3fpsOieuVYM71jtVNBbU7T6QJE7sYAckk5UMOLDygSYP
         mZPSHANsEiSj6mFporydqUA9fTirCtHc4wzNBpD0a6qRfEZN2ejzcEvcS+YDm96I8mdJ
         0VzpFrr7SqEQsIQ4pbSaCC6FQVlvIAvCHfI8dzXhxsTcg3A45AFyWFqStNyHiELz6sXL
         Fp8A==
X-Gm-Message-State: AOAM533/ZylE1tpIBp71pWdD2ODs7UQbFPGdLFSI4FVahie9rauKuxlO
        /u2pqUhMxzsFq3HCiHqm964=
X-Google-Smtp-Source: ABdhPJzdB4xwMzmg+uDv9DIOKt/Wd6Iu7dWq2cb34QW9s0pyIuAflbJsyYnSPJZG1WMApQRvAzwDJA==
X-Received: by 2002:a63:ec14:0:b0:401:9e3e:7d23 with SMTP id j20-20020a63ec14000000b004019e3e7d23mr5871023pgh.235.1654850633659;
        Fri, 10 Jun 2022 01:43:53 -0700 (PDT)
Received: from localhost.localdomain ([1.200.147.12])
        by smtp.gmail.com with ESMTPSA id c28-20020aa7953c000000b0051c01aa7d31sm11703568pfp.46.2022.06.10.01.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:43:53 -0700 (PDT)
From:   medadyoung@gmail.com
X-Google-Original-From: ctcchien@nuvoton.com
To:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v12 1/3] dt-bindings: edac: nuvoton: add NPCM memory controller
Date:   Fri, 10 Jun 2022 16:43:38 +0800
Message-Id: <20220610084340.2268-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610084340.2268-1-ctcchien@nuvoton.com>
References: <20220610084340.2268-1-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Medad CChien <ctcchien@nuvoton.com>

Document devicetree bindings for the Nuvoton BMC NPCM memory controller.

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../edac/nuvoton,npcm-memory-controller.yaml  | 62 +++++++++++++++++++
 MAINTAINERS                                   |  2 +
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml

diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
new file mode 100644
index 000000000000..a5c8d332d1c1
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 4383949ff654..7f832e6ed4e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2367,12 +2367,14 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
+F:	Documentation/devicetree/bindings/*/npcm-memory-controller.yaml
 F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
 F:	drivers/*/*npcm*
 F:	drivers/*/*/*npcm*
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
 
+
 ARM/NUVOTON WPCM450 ARCHITECTURE
 M:	Jonathan Neuschäfer <j.neuschaefer@gmx.net>
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
-- 
2.17.1

