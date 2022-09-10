Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9F35B481F
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiIJToS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIJTnu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:43:50 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD5134360E;
        Sat, 10 Sep 2022 12:43:32 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 01AC5DC2;
        Sat, 10 Sep 2022 22:46:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 01AC5DC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662839201;
        bh=StKVw2qO0uu/0ycag9W0m4V+DL9YICWUobtjb/FNc8I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=iavZ0ztzUeMuEdSmuIO9ENqf8wNNJYG7W+d0vD7o1pENaQ4duXwt4LtrpDugleG0V
         R0BGsm+y0dCi22tYuUuogItY7HU3DzF0MP1QRZCS24xgw4sa1NZuaXDdkWr0n0XD2j
         ZXCsp/slOFTF0+K7ele8RjjUBAQdszK5EON1rBNw=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:42:50 +0300
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
Subject: [PATCH v2 14/19] dt-bindings: memory: snps: Detach Zynq DDRC controller support
Date:   Sat, 10 Sep 2022 22:42:32 +0300
Message-ID: <20220910194237.10142-15-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Zynq A05 DDRC controller has nothing in common with DW uMCTL2 DDRC:
the CSRs layout is absolutely different and it doesn't support IRQs unlike
DW uMCTL2 DDR controller of all versions (v1.x, v2.x and v3.x). Thus there
is no any reason to have these controllers described in the same bindings.
Let's split the DT-schema up.

Note since the synopsys,ddrc-ecc.yaml schema describes the Synopsys DW
uMCTL2 DDR controller only, we need to accordingly fix the device
descriptions.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Move Synopsys DW uMCTL2 DDRC bindings file renaming to a separate
  patch. (@Krzysztof)
---
 .../memory-controllers/synopsys,ddrc-ecc.yaml | 63 ++++++-------------
 .../xlnx,zynq-ddrc-a05.yaml                   | 38 +++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 59 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml b/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
index f46e95704f53..0be8ecc73d1a 100644
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/memory-controllers/synopsys,ddrc-ecc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Synopsys IntelliDDR Multi Protocol memory controller
+title: Synopsys DesignWare Universal Multi-Protocol Memory Controller
 
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
@@ -12,21 +12,22 @@ maintainers:
   - Michal Simek <michal.simek@xilinx.com>
 
 description: |
-  The ZynqMP DDR ECC controller has an optional ECC support in 64-bit and
-  32-bit bus width configurations.
+  Synopsys DesignWare Enhanced uMCTL2 DDR Memory Controller is capable of
+  working with the memory devices supporting up to (LP)DDR4 protocol. It can
+  be equipped with SEC/DEC ECC feature if DRAM data bus width is either
+  16-bits or 32-bits or 64-bits wide.
 
-  The Zynq DDR ECC controller has an optional ECC support in half-bus width
-  (16-bit) configuration.
-
-  These both ECC controllers correct single bit ECC errors and detect double bit
-  ECC errors.
+  For instance the ZynqMP DDR controller is based on the DW uMCTL2 v2.40a
+  controller. It has an optional SEC/DEC ECC support in 64- and 32-bits
+  bus width configurations.
 
 properties:
   compatible:
-    enum:
-      - snps,ddrc-3.80a
-      - xlnx,zynq-ddrc-a05
-      - xlnx,zynqmp-ddrc-2.40a
+    oneOf:
+      - description: Synopsys DW uMCTL2 DDR controller v3.80a
+        const: snps,ddrc-3.80a
+      - description: Xilinx ZynqMP DDR controller v2.40a
+        const: xlnx,zynqmp-ddrc-2.40a
 
   interrupts:
     maxItems: 1
@@ -37,40 +38,16 @@ properties:
 required:
   - compatible
   - reg
-
-allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - snps,ddrc-3.80a
-              - xlnx,zynqmp-ddrc-2.40a
-    then:
-      required:
-        - interrupts
-    else:
-      properties:
-        interrupts: false
+  - interrupts
 
 additionalProperties: false
 
 examples:
   - |
-    memory-controller@f8006000 {
-        compatible = "xlnx,zynq-ddrc-a05";
-        reg = <0xf8006000 0x1000>;
-    };
-
-  - |
-    axi {
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        memory-controller@fd070000 {
-            compatible = "xlnx,zynqmp-ddrc-2.40a";
-            reg = <0x0 0xfd070000 0x0 0x30000>;
-            interrupt-parent = <&gic>;
-            interrupts = <0 112 4>;
-        };
+    memory-controller@fd070000 {
+      compatible = "xlnx,zynqmp-ddrc-2.40a";
+      reg = <0xfd070000 0x30000>;
+      interrupt-parent = <&gic>;
+      interrupts = <0 112 4>;
     };
+...
diff --git a/Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml b/Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
new file mode 100644
index 000000000000..8f72e2f8588a
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/xlnx,zynq-ddrc-a05.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Zynq A05 DDR Memory Controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+  - Manish Narani <manish.narani@xilinx.com>
+  - Michal Simek <michal.simek@xilinx.com>
+
+description:
+  The Zynq DDR ECC controller has an optional ECC support in half-bus width
+  (16-bit) configuration. It is cappable of correcting single bit ECC errors
+  and detecting double bit ECC errors.
+
+properties:
+  compatible:
+    const: xlnx,zynq-ddrc-a05
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-controller@f8006000 {
+      compatible = "xlnx,zynq-ddrc-a05";
+      reg = <0xf8006000 0x1000>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 9d7f64dc0efe..40e1a146ca61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3087,6 +3087,7 @@ W:	http://wiki.xilinx.com
 T:	git https://github.com/Xilinx/linux-xlnx.git
 F:	Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
 F:	Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
+F:	Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
 F:	Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
 F:	arch/arm/mach-zynq/
 F:	drivers/clocksource/timer-cadence-ttc.c
-- 
2.37.2

