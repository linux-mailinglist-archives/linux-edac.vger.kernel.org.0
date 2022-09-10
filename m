Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D795B4849
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiIJToY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIJTnw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:43:52 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CA0548EA9;
        Sat, 10 Sep 2022 12:43:35 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id CBC2EDC3;
        Sat, 10 Sep 2022 22:46:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com CBC2EDC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662839201;
        bh=+5sRCohI9Zb4JCPLb4V2giJHDSyrTGOUV97YitAm6iI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=FPMFIeKEwrQQQd/a2QRtXmsX717B/AQPxSOzqfFIC62G8bYvYDEYCzKL69CtzvDfZ
         ChSnLvSeoE9b2L54zQbj7nitpppbO3AxoOTc2Of7WIuZuzh+ruoW0ZEodYKl9Y7/+I
         1UsZR4NB8dMFLpNjgFjZEZQIhE1fCSWVVPl3xsuM=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:42:51 +0300
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
Subject: [PATCH v2 15/19] dt-bindings: memory: snps: Use more descriptive device name
Date:   Sat, 10 Sep 2022 22:42:33 +0300
Message-ID: <20220910194237.10142-16-Sergey.Semin@baikalelectronics.ru>
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

The DT-schema name and the corresponding generic compatible string look
inappropriate in the current DW uMCTL2 DDRC DT-bindings:
1. DT-schema name contains undefined vendor-prefix. It's supposed to be
"snps", not "synopsys".
2. DT-schema name has "ecc" suffix. That is a device property, and has
nothing to do with the controller actual name.
3. The controller name is different. It's DW uMCTL2 DDRC. Just DDRC
doesn't identify the IP-core in subject.
4. There is no much point in using the IP-core version in the device name
since it can be retrieved from the corresponding device CSR. Moreover the
DW uMCTL2 DDRC driver doesn't differentiate the IP-core version at the
current state.

In order to fix all the inconsistencies described above we suggest to
rename the DT-schema to "snps,dw-umctl2-ddrc.yaml", deprecate the
compatible string "snps,ddrc-3.80a" and define a new generic device
name as "snps,dw-umctl2-ddrc".

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- This is a new patch created on v2 by detaching the DT-schema renaming
  from the previous patch in the series. (@Krzysztof)
- Fix the compatible string name so one would match the new DT-schema
  name.
---
 .../{synopsys,ddrc-ecc.yaml => snps,dw-umctl2-ddrc.yaml}   | 7 +++++--
 MAINTAINERS                                                | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/memory-controllers/{synopsys,ddrc-ecc.yaml => snps,dw-umctl2-ddrc.yaml} (83%)

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
similarity index 83%
rename from Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
rename to Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
index 0be8ecc73d1a..9212dfe6e956 100644
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/memory-controllers/synopsys,ddrc-ecc.yaml#
+$id: http://devicetree.org/schemas/memory-controllers/snps,dw-umctl2-ddrc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Synopsys DesignWare Universal Multi-Protocol Memory Controller
@@ -24,8 +24,11 @@ description: |
 properties:
   compatible:
     oneOf:
-      - description: Synopsys DW uMCTL2 DDR controller v3.80a
+      - deprecated: true
+        description: Synopsys DW uMCTL2 DDR controller v3.80a
         const: snps,ddrc-3.80a
+      - description: Synopsys DW uMCTL2 DDR controller
+        const: snps,dw-umctl2-ddrc
       - description: Xilinx ZynqMP DDR controller v2.40a
         const: xlnx,zynqmp-ddrc-2.40a
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 40e1a146ca61..357230710ed9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3087,6 +3087,7 @@ W:	http://wiki.xilinx.com
 T:	git https://github.com/Xilinx/linux-xlnx.git
 F:	Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
 F:	Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
+F:	Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
 F:	Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
 F:	Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
 F:	arch/arm/mach-zynq/
-- 
2.37.2

