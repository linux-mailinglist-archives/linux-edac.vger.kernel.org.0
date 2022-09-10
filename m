Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B055B489A
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiIJT5O (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiIJT5K (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:57:10 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD78444572;
        Sat, 10 Sep 2022 12:57:07 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id C66FEDB3;
        Sat, 10 Sep 2022 23:00:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com C66FEDB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662840053;
        bh=wlww8ZkjN/aoPB0dmZO8MZRLajmRztrSeR5eCVXT2u0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=LC9mCobYlQIwLTkLwmogQssLrOrtPz09GVZWYYtgcQfZWpDa8gl8nEwcex4ANb6VL
         8hkpj5hdSLnmnpS1Dq4xj8nXwpLmo/6Se52uTMwEKierd7BSXrXwAMG13ae3d9keLS
         2w6rQCDF1a8ZjLBtWNEINuWS8ZJA9+ZBppiLBoM4=
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
Subject: [PATCH v2 03/15] dt-bindings: memory: snps: Convert the schema to being generic
Date:   Sat, 10 Sep 2022 22:56:47 +0300
Message-ID: <20220910195659.11843-4-Sergey.Semin@baikalelectronics.ru>
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

At the current state the DW uMCTL2 DDRC DT-schema can't be used as the
common one for all the IP-core-based devices due to the compatible string
property constraining the list of the supported device names. In order to
fix that we suggest to update the compatible property constraints so one
would permit having any value aside with the generic device names. At the
same time the generic DT-schema selection must be restricted to the
denoted generic devices only so not to permit the generic fallback
compatibles. Finally since the generic schema will be referenced from the
vendor-specific DT-bindings with possibly non-standard properties defined
it must permit having additional properties specified.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Note alternatively we could drop the "additionalProperties" keyword
modification since currently there is no actual device available with the
properties not listed in the generic DT-schema.

Changelog v2:
- This is a new patch created on v2 cycle of the patchset. (@Krzysztof)
---
 .../memory-controllers/snps,dw-umctl2-ddrc.yaml | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
index e68c4306025a..a3394b4600ef 100644
--- a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
@@ -21,9 +21,21 @@ description: |
   controller. It has an optional SEC/DEC ECC support in 64- and 32-bits
   bus width configurations.
 
+# Please create a separate DT-schema for your DW uMCTL2 DDR controller
+# and make sure it's assigned with the vendor-specific compatible string.
+select:
+  properties:
+    compatible:
+      enum:
+        - snps,ddrc-3.80a
+        - snps,dw-umctl2-ddrc
+        - xlnx,zynqmp-ddrc-2.40a
+  required:
+    - compatible
+
 properties:
   compatible:
-    oneOf:
+    anyOf:
       - deprecated: true
         description: Synopsys DW uMCTL2 DDR controller v3.80a
         const: snps,ddrc-3.80a
@@ -31,6 +43,7 @@ properties:
         const: snps,dw-umctl2-ddrc
       - description: Xilinx ZynqMP DDR controller v2.40a
         const: xlnx,zynqmp-ddrc-2.40a
+      - {}
 
   interrupts:
     description:
@@ -87,7 +100,7 @@ required:
   - reg
   - interrupts
 
-additionalProperties: false
+additionalProperties: true
 
 examples:
   - |
-- 
2.37.2

