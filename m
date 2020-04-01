Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF3619A680
	for <lists+linux-edac@lfdr.de>; Wed,  1 Apr 2020 09:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbgDAHrZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Apr 2020 03:47:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50922 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732060AbgDAHrY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 1 Apr 2020 03:47:24 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E4BE1A0CF5;
        Wed,  1 Apr 2020 09:47:21 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 904CA1A0D14;
        Wed,  1 Apr 2020 09:47:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1C33F402C1;
        Wed,  1 Apr 2020 15:47:09 +0800 (SGT)
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        frank.li@nxp.com
Subject: [PATCH v2 4/4] EDAC: synopsys: Add useful debug and output information for 64bit systems
Date:   Wed,  1 Apr 2020 15:39:09 +0800
Message-Id: <1585726749-13039-5-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585726749-13039-1-git-send-email-sherry.sun@nxp.com>
References: <1585726749-13039-1-git-send-email-sherry.sun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Now the synopsys_edac driver only support to output the 32-bit error
data, but for 64 bit systems, such as i.MX8MP, 64 bit error data is
needed. At the same time, when CE/UE happens, syndrome data is also
useful to showed to user. So here add data_high and syndrome data for
64-bit systems.

And in order to distinguish 64-bit systems and other systems, here
adjust the position of the zynqmp_get_dtype(), so we can called
this function to distinguish it. To ensure that functions of the same
function are in the same position, here adjust the position of the
zynq_get_dtype() too.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/edac/synopsys_edac.c | 182 ++++++++++++++++++++---------------
 1 file changed, 102 insertions(+), 80 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index bf4202a24683..e8c3631ddff4 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -278,18 +278,22 @@
  * @col:	Column number.
  * @bank:	Bank number.
  * @bitpos:	Bit position.
- * @data:	Data causing the error.
+ * @data_low:	Low bit data causing the error.
+ * @data_high:	High bit data causing the error(used for 64 bit systems).
  * @bankgrpnr:	Bank group number.
  * @blknr:	Block number.
+ * @syndrome:	Syndrome of the error.
  */
 struct ecc_error_info {
 	u32 row;
 	u32 col;
 	u32 bank;
 	u32 bitpos;
-	u32 data;
+	u32 data_low;
+	u32 data_high;
 	u32 bankgrpnr;
 	u32 blknr;
+	u32 syndrome;
 };
 
 /**
@@ -354,6 +358,70 @@ struct synps_platform_data {
 	int quirks;
 };
 
+/**
+ * zynq_get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the EDAC device type width appropriate for the current controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type zynq_get_dtype(const void __iomem *base)
+{
+	enum dev_type dt;
+	u32 width;
+
+	width = readl(base + CTRL_OFST);
+	width = (width & CTRL_BW_MASK) >> CTRL_BW_SHIFT;
+
+	switch (width) {
+	case DDRCTL_WDTH_16:
+		dt = DEV_X2;
+		break;
+	case DDRCTL_WDTH_32:
+		dt = DEV_X4;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
+
+	return dt;
+}
+
+/**
+ * zynqmp_get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the EDAC device type width appropriate for the current controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type zynqmp_get_dtype(const void __iomem *base)
+{
+	enum dev_type dt;
+	u32 width;
+
+	width = readl(base + CTRL_OFST);
+	width = (width & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+	switch (width) {
+	case DDRCTL_EWDTH_16:
+		dt = DEV_X2;
+		break;
+	case DDRCTL_EWDTH_32:
+		dt = DEV_X4;
+		break;
+	case DDRCTL_EWDTH_64:
+		dt = DEV_X8;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
+
+	return dt;
+}
+
 /**
  * zynq_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
@@ -385,9 +453,9 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
 	p->ceinfo.row = (regval & ADDR_ROW_MASK) >> ADDR_ROW_SHIFT;
 	p->ceinfo.col = regval & ADDR_COL_MASK;
 	p->ceinfo.bank = (regval & ADDR_BANK_MASK) >> ADDR_BANK_SHIFT;
-	p->ceinfo.data = readl(base + CE_DATA_31_0_OFST);
+	p->ceinfo.data_low = readl(base + CE_DATA_31_0_OFST);
 	edac_dbg(3, "CE bit position: %d data: %d\n", p->ceinfo.bitpos,
-		 p->ceinfo.data);
+		 p->ceinfo.data_low);
 	clearval = ECC_CTRL_CLR_CE_ERR;
 
 ue_err:
@@ -399,7 +467,7 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
 	p->ueinfo.row = (regval & ADDR_ROW_MASK) >> ADDR_ROW_SHIFT;
 	p->ueinfo.col = regval & ADDR_COL_MASK;
 	p->ueinfo.bank = (regval & ADDR_BANK_MASK) >> ADDR_BANK_SHIFT;
-	p->ueinfo.data = readl(base + UE_DATA_31_0_OFST);
+	p->ueinfo.data_low = readl(base + UE_DATA_31_0_OFST);
 	clearval |= ECC_CTRL_CLR_UE_ERR;
 
 out:
@@ -443,10 +511,14 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
 					ECC_CEADDR1_BNKGRP_SHIFT;
 	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
-	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
-	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
-		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
-		 readl(base + ECC_CSYND2_OFST));
+	p->ceinfo.data_low = readl(base + ECC_CSYND0_OFST);
+	if (zynqmp_get_dtype(base) == DEV_X8) {
+		p->ceinfo.data_high = readl(base + ECC_CSYND1_OFST);
+		p->ceinfo.syndrome = readl(base + ECC_CSYND2_OFST);
+		edac_dbg(2, "CE data_low: 0x%08X data_high: 0x%08X syndrome: 0x%08X\n",
+			 p->ceinfo.data_low, p->ceinfo.data_high,
+			 p->ceinfo.syndrome);
+	}
 ue_err:
 	if (!p->ue_cnt)
 		goto out;
@@ -459,7 +531,14 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
 					ECC_CEADDR1_BNKNR_SHIFT;
 	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
-	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
+	p->ueinfo.data_low = readl(base + ECC_UESYND0_OFST);
+	if (zynqmp_get_dtype(base) == DEV_X8) {
+		p->ueinfo.data_high = readl(base + ECC_UESYND1_OFST);
+		p->ueinfo.syndrome = readl(base + ECC_UESYND2_OFST);
+		edac_dbg(2, "UE data_low: 0x%08X data_high: 0x%08X syndrome: 0x%08X\n",
+			 p->ueinfo.data_low, p->ueinfo.data_high,
+			 p->ueinfo.syndrome);
+	}
 out:
 	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
 	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
@@ -480,20 +559,27 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
 	struct ecc_error_info *pinf;
+	int n;
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->bank,
-				 pinf->bankgrpnr, pinf->blknr,
-				 pinf->bitpos, pinf->data);
+			n = snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				     "DDR ECC error type:%s Row %d Bank %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
+				     "CE", pinf->row, pinf->bank,
+				     pinf->bankgrpnr, pinf->blknr,
+				     pinf->bitpos, pinf->data_low);
+
+			if (zynqmp_get_dtype(priv->baseaddr) == DEV_X8)
+				snprintf(priv->message + n,
+					 SYNPS_EDAC_MSG_SIZE - n,
+					 " Data_high: 0x%08x Syndrome: 0x%08x",
+					 pinf->data_high, pinf->syndrome);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
 				 "CE", pinf->row, pinf->bank, pinf->col,
-				 pinf->bitpos, pinf->data);
+				 pinf->bitpos, pinf->data_low);
 		}
 
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
@@ -636,70 +722,6 @@ static void check_errors(struct mem_ctl_info *mci)
 		 priv->ce_cnt, priv->ue_cnt);
 }
 
-/**
- * zynq_get_dtype - Return the controller memory width.
- * @base:	DDR memory controller base address.
- *
- * Get the EDAC device type width appropriate for the current controller
- * configuration.
- *
- * Return: a device type width enumeration.
- */
-static enum dev_type zynq_get_dtype(const void __iomem *base)
-{
-	enum dev_type dt;
-	u32 width;
-
-	width = readl(base + CTRL_OFST);
-	width = (width & CTRL_BW_MASK) >> CTRL_BW_SHIFT;
-
-	switch (width) {
-	case DDRCTL_WDTH_16:
-		dt = DEV_X2;
-		break;
-	case DDRCTL_WDTH_32:
-		dt = DEV_X4;
-		break;
-	default:
-		dt = DEV_UNKNOWN;
-	}
-
-	return dt;
-}
-
-/**
- * zynqmp_get_dtype - Return the controller memory width.
- * @base:	DDR memory controller base address.
- *
- * Get the EDAC device type width appropriate for the current controller
- * configuration.
- *
- * Return: a device type width enumeration.
- */
-static enum dev_type zynqmp_get_dtype(const void __iomem *base)
-{
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
-	}
-
-	return dt;
-}
-
 /**
  * zynq_get_ecc_state - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
-- 
2.17.1

