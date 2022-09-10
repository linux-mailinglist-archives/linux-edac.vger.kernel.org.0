Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C8F5B4899
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIJT5w (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiIJT5X (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:57:23 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90A5245F7F;
        Sat, 10 Sep 2022 12:57:06 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 26BFFDA8;
        Sat, 10 Sep 2022 23:00:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 26BFFDA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662840053;
        bh=C1cHVya5vTRX4BQybgGAblj68eUfTg6JA+yP2FgH028=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=jFNNMjAMSit/oQmQ5gkfa1u0hXBIhLI/13fYl3wrKOEDQgeh6/fXXPA2oDFd2ES9y
         GHdpsp7WtcaZ3jlrktQwnOCDs+bq46Z0lXP7Eb3ZJyC942JMg0eqC8e5TDBA6RB+Fx
         KEin80j9t7fyxHBXMbeMeUr2c5Sqb3UHxczRufS4=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:57:02 +0300
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
Subject: [PATCH v2 02/15] dt-bindings: memory: snps: Extend schema with IRQs/resets/clocks props
Date:   Sat, 10 Sep 2022 22:56:46 +0300
Message-ID: <20220910195659.11843-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
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

First of all the DW uMCTL2 DDRC IP-core supports the individual IRQ lines
for each standard event: ECC Corrected Error, ECC Uncorrected Error, ECC
Address Protection, Scrubber-Done signal, DFI Parity/CRC Error. It's
possible that the platform engineers merge them up in the IRQ controller
level. So let's add both configuration support to the DT-schema.

Secondly the DW uMCTL2 DDRC IP-core can have clock sources like APB
reference clock, AXI-ports clock, main DDRC core reference clock and
Scrubber low-power clock. In addition to that each clock domain can have a
dedicated reset signal. Let's add the properties for at least the denoted
clock sources and the corresponding reset controls.

Note the IRQs and the phandles order is deliberately not fixed since some
of the sources may be absent depending on the IP-core synthesize
parameters and the particular platform setups.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Replace "snps,ddrc-3.80a" compatible string with "snps,dw-umctl2-ddrc"
  in the example.
- Move unrelated changes in to the dedicated patches. (@Krzysztof)
- Use the IRQ macros in the example. (@Krzysztof)
---
 .../snps,dw-umctl2-ddrc.yaml                  | 61 ++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
index fb571d3d665d..e68c4306025a 100644
--- a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
@@ -33,11 +33,55 @@ properties:
         const: xlnx,zynqmp-ddrc-2.40a
 
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
@@ -55,5 +99,20 @@ examples:
 
       interrupt-parent = <&gic>;
       interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "ecc";
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    memory-controller@3d400000 {
+      compatible = "snps,dw-umctl2-ddrc";
+      reg = <0x3d400000 0x400000>;
+
+      interrupts = <147 IRQ_TYPE_LEVEL_HIGH>, <148 IRQ_TYPE_LEVEL_HIGH>,
+                   <149 IRQ_TYPE_LEVEL_HIGH>, <150 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "ecc_ce", "ecc_ue", "ecc_sbr", "dfi_e";
+
+      clocks = <&pclk>, <&aclk>, <&core_clk>, <&sbr_clk>;
+      clock-names = "pclk", "aclk", "core", "sbr";
     };
 ...
-- 
2.37.2

