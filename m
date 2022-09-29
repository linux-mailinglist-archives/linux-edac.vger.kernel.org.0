Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E1B5F172E
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiJAAVI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiJAAUi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:20:38 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E8A4AE76;
        Fri, 30 Sep 2022 17:19:15 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 652EDE0EE8;
        Fri, 30 Sep 2022 02:41:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=xmiIsr+CxyYPPPWH+bVVhUhXUf+sRVZYDVhwJrglXds=; b=iTYM1vPERAbu
        ZGSDwGYdkslxEZKrptG2kBp9YNgBavmipdbDr7bX0gZxP964QM3cgeNuLpJLoGdr
        7lvKrz8enEaXChlN/PMb/swnSc028rebGjiIdhzvh55GzztPSOcTwlhk42V0bht+
        3YPR+Pme89UykwOOkIHWmp64gvtO2OY=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 57FAFE0E70;
        Fri, 30 Sep 2022 02:41:28 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:41:29 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 02/13] dt-bindings: memory: Add Baikal-T1 DDRC DT-schema
Date:   Fri, 30 Sep 2022 02:41:10 +0300
Message-ID: <20220929234121.13955-3-Sergey.Semin@baikalelectronics.ru>
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

Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
are individual IRQs for each ECC and DFI events. The dedicated scrubber
clock source is absent since it's fully synchronous to the core clock.
In addition to that the DFI-DDR PHY CSRs can be accessed via a separate
registers space.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v2:
- Keep the alphabetically ordered compatible strings list. (@Krzysztof)
- Fix grammar nitpicks in the patch log. (@Krzysztof)
- Drop the PHY CSR region. (@Rob)
- Move the device bindings to the separate DT-schema.
---
 .../memory-controllers/baikal,bt1-ddrc.yaml   | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml
new file mode 100644
index 000000000000..80353a0a676f
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/baikal,bt1-ddrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Baikal-T1 DDR Controller
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description:
+  Baikal-T1 DDRC is based on the DW uMCTL2 DDRC IP-core v2.51a with DDR2
+  and DDR3 protocol capability, 32-bit data bus + 8-bit ECC + up to 2
+  SDRAM ranks. There are individual IRQs for each ECC and DFI events.
+  The dedicated scrubber clock source is absent since it's fully
+  synchronous to the core clock.
+
+allOf:
+  - $ref: /schemas/memory-controllers/snps,dw-umctl2-common.yaml#
+
+properties:
+  compatible:
+    const: baikal,bt1-ddrc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 4
+
+  interrupt-names:
+    items:
+      - const: dfi_e
+      - const: ecc_ce
+      - const: ecc_ue
+      - const: ecc_sbr
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: aclk
+      - const: core
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: arst
+      - const: core
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+    #include <dt-bindings/clock/bt1-ccu.h>
+    #include <dt-bindings/reset/bt1-ccu.h>
+
+    memory-controller@1f042000 {
+      compatible = "baikal,bt1-ddrc";
+      reg = <0x1f042000 0x1000>;
+
+      interrupts = <GIC_SHARED 96 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SHARED 97 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SHARED 98 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SHARED 99 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "dfi_e", "ecc_ce", "ecc_ue", "ecc_sbr";
+
+      clocks = <&ccu_sys CCU_SYS_APB_CLK>,
+               <&ccu_axi CCU_AXI_DDR_CLK>,
+               <&ccu_pll CCU_DDR_PLL>;
+      clock-names = "pclk", "aclk", "core";
+
+      resets = <&ccu_axi CCU_AXI_DDR_RST>,
+               <&ccu_sys CCU_SYS_DDR_INIT_RST>;
+      reset-names = "arst", "core";
+    };
+...
-- 
2.37.3


