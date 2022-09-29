Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065425F180A
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 03:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiJABO0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 21:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiJABOU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 21:14:20 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E54021B9C4;
        Fri, 30 Sep 2022 18:14:12 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id C57D6E0EC0;
        Fri, 30 Sep 2022 02:27:25 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=lm5LL8kY8kQ4OnI9A4Rer43zqRodegSDSnCK9gejy9A=; b=k8mubSC4x27h
        cCi2cHvbFGDU1Plfqx9a3LqxhpHu6d6tKEA9fU0JKIlapzrpbA6oAC+66AZ9/WVQ
        1VfmlMCa73J2X94iyYzq+dZ/NJn15WrSmA6W+bCYUR6E0KmpgxZ4v3X3pysG6dDT
        IswIOrcuvN4HSGZvw2thgkjbHSbz22k=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id B4854E0E6B;
        Fri, 30 Sep 2022 02:27:25 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:27:26 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH RESEND v3 02/17] EDAC/synopsys: Fix generic device type detection procedure
Date:   Fri, 30 Sep 2022 02:26:57 +0300
Message-ID: <20220929232712.12202-3-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

First of all the enum dev_type constants define the Memory devices, i.e.
DRAM chips, DQ-bus width (see the enumberation kdoc for details). So what
is returned from the zynqmp_get_dtype() procedure is definitely wrong.
Secondly the DRAM chips type has nothing to do with the data bus width
specified in the MSTR.data_bus_width CSR field. The later one just
determines the part of the whole DQ-bus used to access the data from the
all DRAM chips. So it doesn't indicate the individual chips type. Thirdly
the DRAM chips type can be determined only in case of the DDR4 protocol by
means of the MSTR.device_config field state (it is supposed to be set by
the system firmware). Finally the DW uMCTL2 DDRC ECC capability doesn't
depend on the memory chips type. Moreover it doesn't depend on the data
bus width in runtime either. The IP-core reference manual says in [1,2]
that the ECC support can't be enabled during the IP-core synthesizes for
the DRAM data bus widths other than 16, 32 or 64. At the same time the
bus width mode (MSTR.data_bus_width) doesn't change the ECC feature
availability. Thus it was wrong to determine the ECC state with respect to
the DQ-bus width mode.

Let's fix all of the mistakes above in the zynqmp_get_dtype() and
zynqmp_get_ecc_state() methods. In accordance with the DW uMCTL2 DDRC
nature the DRAM chips type in most of the cases will be unknown except
when DDR4 protocol is utilized. ECC availability will be determined by the
ECCCFG0.ecc_mode field state only.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p. 421.
[2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p. 633.

Fixes: b500b4a029d5 ("EDAC, synopsys: Add ECC support for ZynqMP DDR controller")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Include "linux/bitfield.h" header file to get the FIELD_GET macro
  definition. (@tbot)
---
 drivers/edac/synopsys_edac.c | 57 +++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index c78fb5781ff9..17960f7ca29b 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2012 - 2014 Xilinx, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -142,7 +143,12 @@
 #define ECC_CTRL_EN_CE_IRQ		BIT(8)
 #define ECC_CTRL_EN_UE_IRQ		BIT(9)
 
-/* DDR Control Register width definitions  */
+/* DDR Master Register 0 definitions */
+#define DDR_MSTR_DEV_CFG_MASK		GENMASK(31, 30)
+#define DDR_MSTR_DEV_X4			0x0
+#define DDR_MSTR_DEV_X8			0x1
+#define DDR_MSTR_DEV_X16		0x2
+#define DDR_MSTR_DEV_X32		0x3
 #define DDRCTL_EWDTH_16			2
 #define DDRCTL_EWDTH_32			1
 #define DDRCTL_EWDTH_64			0
@@ -671,26 +677,25 @@ static enum dev_type zynq_get_dtype(const void __iomem *base)
  */
 static enum dev_type zynqmp_get_dtype(const void __iomem *base)
 {
-	enum dev_type dt;
-	u32 width;
-
-	width = readl(base + CTRL_OFST);
-	width = (width & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
-	switch (width) {
-	case DDRCTL_EWDTH_16:
-		dt = DEV_X2;
-		break;
-	case DDRCTL_EWDTH_32:
-		dt = DEV_X4;
-		break;
-	case DDRCTL_EWDTH_64:
-		dt = DEV_X8;
-		break;
-	default:
-		dt = DEV_UNKNOWN;
+	u32 regval;
+
+	regval = readl(base + DDR_MSTR_OFST);
+	if (!(regval & MEM_TYPE_DDR4))
+		return DEV_UNKNOWN;
+
+	regval = FIELD_GET(DDR_MSTR_DEV_CFG_MASK, regval);
+	switch (regval) {
+	case DDR_MSTR_DEV_X4:
+		return DEV_X4;
+	case DDR_MSTR_DEV_X8:
+		return DEV_X8;
+	case DDR_MSTR_DEV_X16:
+		return DEV_X16;
+	case DDR_MSTR_DEV_X32:
+		return DEV_X32;
 	}
 
-	return dt;
+	return DEV_UNKNOWN;
 }
 
 /**
@@ -727,19 +732,11 @@ static bool zynq_get_ecc_state(void __iomem *base)
  */
 static bool zynqmp_get_ecc_state(void __iomem *base)
 {
-	enum dev_type dt;
-	u32 ecctype;
+	u32 regval;
 
-	dt = zynqmp_get_dtype(base);
-	if (dt == DEV_UNKNOWN)
-		return false;
+	regval = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
 
-	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
-	if ((ecctype == SCRUB_MODE_SECDED) &&
-	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
-		return true;
-
-	return false;
+	return (regval == SCRUB_MODE_SECDED);
 }
 
 /**
-- 
2.37.3


