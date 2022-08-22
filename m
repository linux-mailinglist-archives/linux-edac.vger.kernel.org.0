Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEAC59C7E5
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbiHVTIS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbiHVTIL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:08:11 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE524165BC;
        Mon, 22 Aug 2022 12:08:09 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 17E6BDA3;
        Mon, 22 Aug 2022 22:10:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 17E6BDA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195458;
        bh=11AHl69seteWDrDYFgf5Uz1P7YvQncvD55F7tkowl1Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=l3JgXpJB/2Yb8ur4z5M0Hav8koGwOJWtI5/rAtdp3liAAEfpkTT1A6+FB3SYeIAVe
         4pZ2rdrF8xvm1w5W0w0GUGyIpF3kg8ISDAR3FK/oSyj52xN376k9Bvwup30azfFsGV
         8GZ7esdRHojYT8iwymCnwqQFiUBa+xvSj0/HfLbI=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:07:43 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 16/20] dt-bindings: memory: snps: Detach Zynq DDRC controller support
Date:   Mon, 22 Aug 2022 22:07:26 +0300
Message-ID: <20220822190730.27277-17-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Zynq A05 DDRC controller has nothing in common with DW uMCTL2 DDRC:
the CSRs layout is absolutely different and it doesn't has IRQ unlike DW
uMCTL2 DDR controller of all versions (v1.x, v2.x and v3.x). Thus there is
no any reason to have these controllers described by the same bindings.
Thus let's split them up.

While at it rename the original Synopsys uMCTL2 DT-schema file to a more
descriptive - snps,dw-umctl2-ddrc.yaml and add a more detailed title and
description of the device bindings.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 .../snps,dw-umctl2-ddrc.yaml                  | 51 +++++++++++++
 .../memory-controllers/synopsys,ddrc-ecc.yaml | 76 -------------------
 .../xlnx,zynq-ddrc-a05.yaml                   | 38 ++++++++++
 MAINTAINERS                                   |  2 +
 4 files changed, 91 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
new file mode 100644
index 000000000000..787d91d64eee
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/snps,dw-umctl2-ddrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare Universal Multi-Protocol Memory Controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+  - Manish Narani <manish.narani@xilinx.com>
+  - Michal Simek <michal.simek@xilinx.com>
+
+description: |
+  Synopsys DesignWare Enhanced uMCTL2 DDR Memory Controller is cappable of
+  working with DDR devices up to (LP)DDR4 protocol. It can be equipped
+  with SEC/DEC ECC feature if DRAM data bus width is either 16-bits or
+  32-bits or 64-bits wide.
+
+  The ZynqMP DDR controller is based on the DW uMCTL2 v2.40a controller.
+  It has an optional SEC/DEC ECC support in 64-bit and 32-bit bus width
+  configurations.
+
+properties:
+  compatible:
+    enum:
+      - snps,ddrc-3.80a
+      - xlnx,zynqmp-ddrc-2.40a
+
+  interrupts:
+    maxItems: 1
+
+  reg:
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
+    memory-controller@fd070000 {
+      compatible = "xlnx,zynqmp-ddrc-2.40a";
+      reg = <0xfd070000 0x30000>;
+      interrupt-parent = <&gic>;
+      interrupts = <0 112 4>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml b/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
deleted file mode 100644
index f46e95704f53..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
+++ /dev/null
@@ -1,76 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/memory-controllers/synopsys,ddrc-ecc.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Synopsys IntelliDDR Multi Protocol memory controller
-
-maintainers:
-  - Krzysztof Kozlowski <krzk@kernel.org>
-  - Manish Narani <manish.narani@xilinx.com>
-  - Michal Simek <michal.simek@xilinx.com>
-
-description: |
-  The ZynqMP DDR ECC controller has an optional ECC support in 64-bit and
-  32-bit bus width configurations.
-
-  The Zynq DDR ECC controller has an optional ECC support in half-bus width
-  (16-bit) configuration.
-
-  These both ECC controllers correct single bit ECC errors and detect double bit
-  ECC errors.
-
-properties:
-  compatible:
-    enum:
-      - snps,ddrc-3.80a
-      - xlnx,zynq-ddrc-a05
-      - xlnx,zynqmp-ddrc-2.40a
-
-  interrupts:
-    maxItems: 1
-
-  reg:
-    maxItems: 1
-
-required:
-  - compatible
-  - reg
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
-
-additionalProperties: false
-
-examples:
-  - |
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
-    };
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
index 9d7f64dc0efe..17f23f810ee4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3086,7 +3086,9 @@ S:	Supported
 W:	http://wiki.xilinx.com
 T:	git https://github.com/Xilinx/linux-xlnx.git
 F:	Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
+F:	Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
 F:	Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
+F:	Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
 F:	Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
 F:	arch/arm/mach-zynq/
 F:	drivers/clocksource/timer-cadence-ttc.c
-- 
2.35.1

