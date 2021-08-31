Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0233FCE1D
	for <lists+linux-edac@lfdr.de>; Tue, 31 Aug 2021 22:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbhHaUEf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 31 Aug 2021 16:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239662AbhHaUEe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 31 Aug 2021 16:04:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7133960238;
        Tue, 31 Aug 2021 20:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630440219;
        bh=vRW9bfliGgi3M2Pqi3B8DPXC75HrCI/z3OLaZgRrVm4=;
        h=From:To:Cc:Subject:Date:From;
        b=c+n2C2uXjpsgG+IMvy7GFarjuyy9OOh88JPopnrmM35XUt2kVJLSW0TqcN0C4t5+H
         LpygCEwaDdIkUIgSIqInztLZy9fnac8wWg+YrRfeETvap2T2/iySy+ZyvFW48jCDhe
         UPSWmECNnA8+QXePzRs/O7cgRK9XfTb/sfKjS9JJB/l7s/MNVTv9B3OubY7/HHnor7
         SvxYhbBpCNqFfrsciovk8c2h73yCkqORUSPm6L6MGMBx713OQe9Q4CwKPCBoiBIvbm
         EMIoIIaICTARiBGN8INkzBo0Wm/PNT7JHl62l8zL2F74TJMck3eRx5lUOZdkQY7sjs
         0aInPP90zpCMA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     michal.simek@xilinx.com
Cc:     dinguyen@kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: [PATCH 1/2] EDAC/synopsys: add support for version 3 of the Synopsys EDAC DDR
Date:   Tue, 31 Aug 2021 15:03:15 -0500
Message-Id: <20210831200316.3208310-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch adds support for version 3.80a of the Synopsys DDR controller
with EDAC. This version of the controller has the following differences:

- UE/CE are auto cleared
- Interrupts are supported by default

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/synopsys_edac.c | 53 ++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 7e7146b22c16..297845e65b65 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -101,6 +101,7 @@
 /* DDR ECC Quirks */
 #define DDR_ECC_INTR_SUPPORT		BIT(0)
 #define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
+#define DDR_ECC_INTR_SELF_CLEAR		BIT(2)
 
 /* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
 /* ECC Configuration Registers */
@@ -171,6 +172,10 @@
 #define DDR_QOS_IRQ_EN_OFST		0x20208
 #define DDR_QOS_IRQ_DB_OFST		0x2020C
 
+/* DDR QOS Interrupt register definitions */
+#define DDR_UE_MASK			0x200
+#define DDR_CE_MASK			0x100
+
 /* ECC Corrected Error Register Mask and Shifts*/
 #define ECC_CEADDR0_RW_MASK		0x3FFFF
 #define ECC_CEADDR0_RNK_MASK		BIT(24)
@@ -533,10 +538,16 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	priv = mci->pvt_info;
 	p_data = priv->p_data;
 
-	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
-	regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
-	if (!(regval & ECC_CE_UE_INTR_MASK))
-		return IRQ_NONE;
+	/*
+	 * v3.0 of the controller has the ce/ue bits cleared automatically
+	 * cleared, so this condition does not apply.
+	 */
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
+		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+		regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
+		if (!(regval & ECC_CE_UE_INTR_MASK))
+			return IRQ_NONE;
+	}
 
 	status = p_data->get_error_info(priv);
 	if (status)
@@ -548,7 +559,9 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 
 	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
-	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	/* v3.0 of the controller does not have this register */
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
+		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 	return IRQ_HANDLED;
 }
 
@@ -834,8 +847,13 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 static void enable_intr(struct synps_edac_priv *priv)
 {
 	/* Enable UE/CE Interrupts */
-	writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
-			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
+		writel(DDR_UE_MASK | DDR_CE_MASK,
+		       priv->baseaddr + ECC_CLR_OFST);
+	else
+		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
+		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+
 }
 
 static void disable_intr(struct synps_edac_priv *priv)
@@ -890,6 +908,19 @@ static const struct synps_platform_data zynqmp_edac_def = {
 			  ),
 };
 
+static const struct synps_platform_data synopsys_edac_def = {
+	.get_error_info	= zynqmp_get_error_info,
+	.get_mtype	= zynqmp_get_mtype,
+	.get_dtype	= zynqmp_get_dtype,
+	.get_ecc_state	= zynqmp_get_ecc_state,
+	.quirks         = (DDR_ECC_INTR_SUPPORT | DDR_ECC_INTR_SELF_CLEAR
+#ifdef CONFIG_EDAC_DEBUG
+			  | DDR_ECC_DATA_POISON_SUPPORT
+#endif
+			  ),
+};
+
+
 static const struct of_device_id synps_edac_match[] = {
 	{
 		.compatible = "xlnx,zynq-ddrc-a05",
@@ -899,6 +930,10 @@ static const struct of_device_id synps_edac_match[] = {
 		.compatible = "xlnx,zynqmp-ddrc-2.40a",
 		.data = (void *)&zynqmp_edac_def
 	},
+	{
+		.compatible = "snps,ddrc-3.80a",
+		.data = (void *)&synopsys_edac_def
+	},
 	{
 		/* end of table */
 	}
@@ -1352,8 +1387,8 @@ static int mc_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "xlnx,zynqmp-ddrc-2.40a"))
+	if (!of_device_is_compatible(pdev->dev.of_node,
+				    "xlnx,zynq-ddrc-a05"))
 		setup_address_map(priv);
 #endif
 
-- 
2.25.1

