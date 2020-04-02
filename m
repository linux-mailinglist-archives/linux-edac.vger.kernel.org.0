Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC5419B9E8
	for <lists+linux-edac@lfdr.de>; Thu,  2 Apr 2020 03:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733257AbgDBB2d (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Apr 2020 21:28:33 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44344 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgDBB2c (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 1 Apr 2020 21:28:32 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 108141A1104;
        Thu,  2 Apr 2020 03:28:31 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 200031A1103;
        Thu,  2 Apr 2020 03:28:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 65EA5402C1;
        Thu,  2 Apr 2020 09:28:18 +0800 (SGT)
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, frank.li@nxp.com
Subject: [patch v3 3/4] EDAC: synopsys: Add edac driver support for i.MX8MP
Date:   Thu,  2 Apr 2020 09:20:32 +0800
Message-Id: <1585790433-31465-4-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585790433-31465-1-git-send-email-sherry.sun@nxp.com>
References: <1585790433-31465-1-git-send-email-sherry.sun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since i.MX8MP use synopsys ddr controller IP, so add edac support
for i.MX8MP based on synopsys edac driver. i.MX8MP use LPDDR4 and
support interrupts for corrected and uncorrected errors. The main
difference between ZynqMP and i.MX8MP ddr controller is the interrupt
registers. So add another interrupt handler function, enable/disable
interrupt function to distinguish with ZynqMP.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/edac/synopsys_edac.c | 77 +++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 12211dc040e8..bf4202a24683 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -101,6 +101,7 @@
 /* DDR ECC Quirks */
 #define DDR_ECC_INTR_SUPPORT		BIT(0)
 #define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
+#define DDR_ECC_IMX8MP			BIT(2)
 
 /* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
 /* ECC Configuration Registers */
@@ -266,6 +267,11 @@
 
 #define RANK_B0_BASE			6
 
+/* ECCCTL UE/CE Interrupt enable/disable for IMX8MP*/
+#define DDR_CE_INTR_EN_MASK			0x100
+#define DDR_UE_INTR_EN_MASK			0x200
+#define ECC_INTR_MASK				0x10100
+
 /**
  * struct ecc_error_info - ECC error log information.
  * @row:	Row number.
@@ -516,6 +522,54 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 	memset(p, 0, sizeof(*p));
 }
 
+static void enable_intr_imx8mp(struct synps_edac_priv *priv)
+{
+	int regval;
+
+	regval = readl(priv->baseaddr + ECC_CLR_OFST);
+	regval |= (DDR_CE_INTR_EN_MASK | DDR_UE_INTR_EN_MASK);
+	writel(regval, priv->baseaddr + ECC_CLR_OFST);
+}
+
+static void disable_intr_imx8mp(struct synps_edac_priv *priv)
+{
+	int regval;
+
+	regval = readl(priv->baseaddr + ECC_CLR_OFST);
+	regval &= ~(DDR_CE_INTR_EN_MASK | DDR_UE_INTR_EN_MASK);
+	writel(regval, priv->baseaddr + ECC_CLR_OFST);
+}
+
+/* Interrupt Handler for ECC interrupts on imx8mp platform. */
+static irqreturn_t intr_handler_imx8mp(int irq, void *dev_id)
+{
+	const struct synps_platform_data *p_data;
+	struct mem_ctl_info *mci = dev_id;
+	struct synps_edac_priv *priv;
+	int status, regval;
+
+	priv = mci->pvt_info;
+	p_data = priv->p_data;
+
+	regval = readl(priv->baseaddr + ECC_STAT_OFST);
+	if (!(regval & ECC_INTR_MASK))
+		return IRQ_NONE;
+
+	status = p_data->get_error_info(priv);
+	if (status)
+		return IRQ_NONE;
+
+	priv->ce_cnt += priv->stat.ce_cnt;
+	priv->ue_cnt += priv->stat.ue_cnt;
+	handle_error(mci, &priv->stat);
+
+	edac_dbg(3, "Total error count CE %d UE %d\n",
+		 priv->ce_cnt, priv->ue_cnt);
+	enable_intr_imx8mp(priv);
+
+	return IRQ_HANDLED;
+}
+
 /**
  * intr_handler - Interrupt Handler for ECC interrupts.
  * @irq:        IRQ number.
@@ -533,6 +587,9 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	priv = mci->pvt_info;
 	p_data = priv->p_data;
 
+	if (p_data->quirks & DDR_ECC_IMX8MP)
+		return intr_handler_imx8mp(irq, dev_id);
+
 	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 	regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
 	if (!(regval & ECC_CE_UE_INTR_MASK))
@@ -809,7 +866,7 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	platform_set_drvdata(pdev, mci);
 
 	/* Initialize controller capabilities and configuration */
-	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
+	mci->mtype_cap = MEM_FLAG_LRDDR4 | MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
 	mci->scrub_cap = SCRUB_HW_SRC;
 	mci->scrub_mode = SCRUB_NONE;
@@ -834,6 +891,9 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 static void enable_intr(struct synps_edac_priv *priv)
 {
 	/* Enable UE/CE Interrupts */
+	if (priv->p_data->quirks & DDR_ECC_IMX8MP)
+		return enable_intr_imx8mp(priv);
+
 	writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
 }
@@ -841,6 +901,9 @@ static void enable_intr(struct synps_edac_priv *priv)
 static void disable_intr(struct synps_edac_priv *priv)
 {
 	/* Disable UE/CE Interrupts */
+	if (priv->p_data->quirks & DDR_ECC_IMX8MP)
+		return disable_intr_imx8mp(priv);
+
 	writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 }
@@ -890,6 +953,14 @@ static const struct synps_platform_data zynqmp_edac_def = {
 			  ),
 };
 
+static const struct synps_platform_data imx8mp_edac_def = {
+	.get_error_info	= zynqmp_get_error_info,
+	.get_mtype	= zynqmp_get_mtype,
+	.get_dtype	= zynqmp_get_dtype,
+	.get_ecc_state	= zynqmp_get_ecc_state,
+	.quirks         = (DDR_ECC_INTR_SUPPORT | DDR_ECC_IMX8MP),
+};
+
 static const struct of_device_id synps_edac_match[] = {
 	{
 		.compatible = "xlnx,zynq-ddrc-a05",
@@ -899,6 +970,10 @@ static const struct of_device_id synps_edac_match[] = {
 		.compatible = "xlnx,zynqmp-ddrc-2.40a",
 		.data = (void *)&zynqmp_edac_def
 	},
+	{
+		.compatible = "fsl,imx8mp-ddrc",
+		.data = (void *)&imx8mp_edac_def
+	},
 	{
 		/* end of table */
 	}
-- 
2.17.1

