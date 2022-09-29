Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C085F1734
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiJAAVL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiJAAUj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:20:39 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F34A838A3E;
        Fri, 30 Sep 2022 17:19:16 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id A9AC2E0EE7;
        Fri, 30 Sep 2022 02:41:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=Q+p5cyHkFHTifFFqrZuGSJY9Rdb9qx5V620a6JEjrhQ=; b=ZRSHVvmR2q/P
        41Xnn7wKVlqlvuKF3jbSQbZZHGlEHZnnv9lqP7jEIHfRPwnsSbiCAykQcZ9xNx80
        TOJpqn/dlAISdPf5697EsF4yL6jDJNFhRps+ky+HmZtw/tVAtK37B5S5Q8u7oTjO
        xVPSPSErsa6MbP5VumalPnhUirQlswQ=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 9A5AAE0E70;
        Fri, 30 Sep 2022 02:41:27 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:41:28 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 01/13] dt-bindings: memory: snps: Convert the schema to being generic
Date:   Fri, 30 Sep 2022 02:41:09 +0300
Message-ID: <20220929234121.13955-2-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929234121.13955-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929234121.13955-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

At the current state the DW uMCTL2 DDRC DT-schema can't be used as the
common one for all the IP-core-based devices due to the compatible string
property constraining the list of the supported device names. In order to
fix that let's detach the common properties definition to the separate
schema. The later will be used by the vendor-specific controller
implementations to preserve the DT-bindings convention defined for the DW
uMCTL2 DDR controller. Thus the generic DW uMCTL2 DDRC DT-bindings will be
left with the compatible property definition only and will just refer to
the detached common DT-schema.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- This is a new patch created on v2 cycle of the patchset. (@Krzysztof)

Changelog v3:
- Create common DT-schema instead of using the generic device DT-bindings.
  (@Rob)
---
 .../snps,dw-umctl2-common.yaml                | 75 +++++++++++++++++++
 .../snps,dw-umctl2-ddrc.yaml                  | 57 ++------------
 2 files changed, 81 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-common.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-common.yaml b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-common.yaml
new file mode 100644
index 000000000000..115fe5e8339a
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-common.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/snps,dw-umctl2-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare Universal Multi-Protocol Memory Controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+  - Manish Narani <manish.narani@xilinx.com>
+  - Michal Simek <michal.simek@xilinx.com>
+
+description:
+  Synopsys DesignWare Enhanced uMCTL2 DDR Memory Controller is capable of
+  working with the memory devices supporting up to (LP)DDR4 protocol. It can
+  be equipped with SEC/DEC ECC feature if DRAM data bus width is either
+  16-bits or 32-bits or 64-bits wide.
+
+select: false
+
+properties:
+  interrupts:
+    description:
+      DW uMCTL2 DDRC IP-core provides individual IRQ signal for each event":"
+      ECC Corrected Error, ECC Uncorrected Error, ECC Address Protection,
+      Scrubber-Done signal, DFI Parity/CRC Error. Some platforms may have the
+      signals merged before they reach the IRQ controller or have some of them
+      absent in case if the corresponding feature is unavailable/disabled.
+    minItems: 1
+    maxItems: 5
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 5
+    oneOf:
+      - description: Common ECC CE/UE/Scrubber/DFI Errors IRQ
+        items:
+          - const: ecc
+      - description: Individual ECC CE/UE/Scrubber/DFI Errors IRQs
+        items:
+          enum: [ ecc_ce, ecc_ue, ecc_ap, ecc_sbr, dfi_e ]
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      A standard set of the clock sources contains CSRs bus clock, AXI-ports
+      reference clock, DDRC core clock, Scrubber standalone clock
+      (synchronous to the DDRC clock).
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      enum: [ pclk, aclk, core, sbr ]
+
+  resets:
+    description:
+      Each clock domain can have separate reset signal.
+    minItems: 1
+    maxItems: 4
+
+  reset-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      enum: [ prst, arst, core, sbr ]
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
index e68c4306025a..eee5271684e8 100644
--- a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
@@ -21,6 +21,11 @@ description: |
   controller. It has an optional SEC/DEC ECC support in 64- and 32-bits
   bus width configurations.
 
+allOf:
+  - $ref: /schemas/memory-controllers/snps,dw-umctl2-common.yaml#
+
+# Please create a separate DT-schema for your DW uMCTL2 DDR controller
+# with more detailed properties definition.
 properties:
   compatible:
     oneOf:
@@ -32,62 +37,12 @@ properties:
       - description: Xilinx ZynqMP DDR controller v2.40a
         const: xlnx,zynqmp-ddrc-2.40a
 
-  interrupts:
-    description:
-      DW uMCTL2 DDRC IP-core provides individual IRQ signal for each event":"
-      ECC Corrected Error, ECC Uncorrected Error, ECC Address Protection,
-      Scrubber-Done signal, DFI Parity/CRC Error. Some platforms may have the
-      signals merged before they reach the IRQ controller or have some of them
-      absent in case if the corresponding feature is unavailable/disabled.
-    minItems: 1
-    maxItems: 5
-
-  interrupt-names:
-    minItems: 1
-    maxItems: 5
-    oneOf:
-      - description: Common ECC CE/UE/Scrubber/DFI Errors IRQ
-        items:
-          - const: ecc
-      - description: Individual ECC CE/UE/Scrubber/DFI Errors IRQs
-        items:
-          enum: [ ecc_ce, ecc_ue, ecc_ap, ecc_sbr, dfi_e ]
-
-  reg:
-    maxItems: 1
-
-  clocks:
-    description:
-      A standard set of the clock sources contains CSRs bus clock, AXI-ports
-      reference clock, DDRC core clock, Scrubber standalone clock
-      (synchronous to the DDRC clock).
-    minItems: 1
-    maxItems: 4
-
-  clock-names:
-    minItems: 1
-    maxItems: 4
-    items:
-      enum: [ pclk, aclk, core, sbr ]
-
-  resets:
-    description:
-      Each clock domain can have separate reset signal.
-    minItems: 1
-    maxItems: 4
-
-  reset-names:
-    minItems: 1
-    maxItems: 4
-    items:
-      enum: [ prst, arst, core, sbr ]
-
 required:
   - compatible
   - reg
   - interrupts
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.37.3


