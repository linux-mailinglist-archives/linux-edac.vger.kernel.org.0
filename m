Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F259C892
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238511AbiHVTVl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbiHVTU6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:20:58 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55AF8FD17;
        Mon, 22 Aug 2022 12:20:17 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 9495DDA3;
        Mon, 22 Aug 2022 22:23:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 9495DDA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661196208;
        bh=IGQU0ypa1PF4qcU+f0QqtuUCDe4v6kRCgIcvDETuAXs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=FqpLIxXjIw/4SRaZkPtgL+Rx0x7c1NPfQO0dYCv7PIy/VP8QVJ9dKvzqjR3o5fste
         k+aW6TbAgH7X1gFp4kf8R7fHtVNLLm+D49fZejVkz1ORUHRrkyegJa5kNVLI3S+atc
         EHMohewPQxKEIFwHaIQouweD4S4BFLgCtuA6Emis=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:20:14 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Michal Simek <michal.simek@xilinx.com>,
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
Subject: [PATCH 01/13] dt-bindings: memory: snps: Extend schema with IRQs/resets/clocks props
Date:   Mon, 22 Aug 2022 22:19:44 +0300
Message-ID: <20220822191957.28546-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
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

First of all the DW uMCTL2 DDRC IP-core supports the individual IRQ lines
for each standard event: ECC Corrected Error, ECC Uncorrected Error, ECC
Address Protection, Scrubber-Done signal, DFI Parity/CRC Error. It's
possible that the platform engineers merge them up in the IRQ controller
level. So let's add both configuration support to the DT-schema.

Secondly each IP-core interface is supplied with a clock source like APB
reference clock, AXI-ports clock, main DDRC core reference clock and
Scrubber low-power clock. In addition to that each clock domain can have a
dedicated reset signal. Let's add the properties for at least the denoted
clock sources and the corresponding reset controls.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 .../snps,dw-umctl2-ddrc.yaml                  | 65 +++++++++++++++++--
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
index 787d91d64eee..8db92210cfe1 100644
--- a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
@@ -13,13 +13,13 @@ maintainers:
 
 description: |
   Synopsys DesignWare Enhanced uMCTL2 DDR Memory Controller is cappable of
-  working with DDR devices up to (LP)DDR4 protocol. It can be equipped
+  working with DDR devices upporting to (LP)DDR4 protocol. It can be equipped
   with SEC/DEC ECC feature if DRAM data bus width is either 16-bits or
   32-bits or 64-bits wide.
 
-  The ZynqMP DDR controller is based on the DW uMCTL2 v2.40a controller.
-  It has an optional SEC/DEC ECC support in 64-bit and 32-bit bus width
-  configurations.
+  For instance the ZynqMP DDR controller is based on the DW uMCTL2 v2.40a
+  controller. It has an optional SEC/DEC ECC support in 64-bit and 32-bit
+  bus width configurations.
 
 properties:
   compatible:
@@ -28,11 +28,55 @@ properties:
       - xlnx,zynqmp-ddrc-2.40a
 
   interrupts:
-    maxItems: 1
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
 
   reg:
     maxItems: 1
 
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
 required:
   - compatible
   - reg
@@ -48,4 +92,15 @@ examples:
       interrupt-parent = <&gic>;
       interrupts = <0 112 4>;
     };
+  - |
+    memory-controller@fd070000 {
+      compatible = "snps,ddrc-3.80a";
+      reg = <0x3d400000 0x400000>;
+
+      interrupts = <0 147 4>, <0 148 4>, <0 149 4>, <0 150 4>;
+      interrupt-names = "ecc_ce", "ecc_ue", "ecc_sbr", "dfi_e";
+
+      clocks = <&rcu 0>, <&rcu 5>, <&rcu 6>, <&rcu 7>;
+      clock-names = "pclk", "aclk", "core", "sbr";
+    };
 ...
-- 
2.35.1

