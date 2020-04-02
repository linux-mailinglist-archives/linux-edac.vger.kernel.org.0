Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03DD419B9E6
	for <lists+linux-edac@lfdr.de>; Thu,  2 Apr 2020 03:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbgDBB2f (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Apr 2020 21:28:35 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39028 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733265AbgDBB2f (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 1 Apr 2020 21:28:35 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6AD49200F89;
        Thu,  2 Apr 2020 03:28:33 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 79A49200A6C;
        Thu,  2 Apr 2020 03:28:27 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4289C402C8;
        Thu,  2 Apr 2020 09:28:20 +0800 (SGT)
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com,
        manish.narani@xilinx.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, frank.li@nxp.com
Subject: [patch v3 4/4] EDAC: synopsys: Add useful debug and output information for 64bit systems
Date:   Thu,  2 Apr 2020 09:20:33 +0800
Message-Id: <1585790433-31465-5-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585790433-31465-1-git-send-email-sherry.sun@nxp.com>
References: <1585790433-31465-1-git-send-email-sherry.sun@nxp.com>
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
Changes since v2:
- Use u64 data instead u32 data_low and u32 data_high as robert suggested.
- Add edac_dbg() for the != DEV_X8 cases in zynqmp_get_error_info()
- Change the format of the output data to avoid build warnings.

---
 drivers/edac/synopsys_edac.c | 171 ++++++++++++++++++++---------------
 1 file changed, 96 insertions(+), 75 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index bf4202a24683..2bfab62bce1b 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -281,15 +281,17 @@
  * @data:	Data causing the error.
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
+	u64 data;
 	u32 bankgrpnr;
 	u32 blknr;
+	u32 syndrome;
 };
 
 /**
@@ -354,6 +356,70 @@ struct synps_platform_data {
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
@@ -386,7 +452,7 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
 	p->ceinfo.col = regval & ADDR_COL_MASK;
 	p->ceinfo.bank = (regval & ADDR_BANK_MASK) >> ADDR_BANK_SHIFT;
 	p->ceinfo.data = readl(base + CE_DATA_31_0_OFST);
-	edac_dbg(3, "CE bit position: %d data: %d\n", p->ceinfo.bitpos,
+	edac_dbg(3, "CE bit position: %d data: %lld\n", p->ceinfo.bitpos,
 		 p->ceinfo.data);
 	clearval = ECC_CTRL_CLR_CE_ERR;
 
@@ -444,9 +510,13 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 					ECC_CEADDR1_BNKGRP_SHIFT;
 	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
-	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
-		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
-		 readl(base + ECC_CSYND2_OFST));
+	edac_dbg(2, "CE data_low: 0x%08X \n", (u32)(p->ceinfo.data));
+	if (zynqmp_get_dtype(base) == DEV_X8) {
+		p->ceinfo.data |= ((u64)readl(base + ECC_CSYND1_OFST)) << 32;
+		p->ceinfo.syndrome = readl(base + ECC_CSYND2_OFST);
+		edac_dbg(2, "data_high: 0x%08X syndrome: 0x%08X\n",
+			 (u32)(p->ceinfo.data >> 32), p->ceinfo.syndrome);
+	}
 ue_err:
 	if (!p->ue_cnt)
 		goto out;
@@ -460,6 +530,13 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 					ECC_CEADDR1_BNKNR_SHIFT;
 	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
+	edac_dbg(2, "UE data_low: 0x%08X \n", (u32)(p->ueinfo.data));
+	if (zynqmp_get_dtype(base) == DEV_X8) {
+		p->ueinfo.data |= ((u64)readl(base + ECC_UESYND1_OFST)) << 32;
+		p->ueinfo.syndrome = readl(base + ECC_UESYND2_OFST);
+		edac_dbg(2, "data_high: 0x%08X syndrome: 0x%08X\n",
+			 (u32)(p->ueinfo.data >> 32), p->ueinfo.syndrome);
+	}
 out:
 	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
 	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
@@ -480,20 +557,28 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
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
+				     pinf->bitpos, (u32)(pinf->data));
+
+			if (zynqmp_get_dtype(priv->baseaddr) == DEV_X8)
+				snprintf(priv->message + n,
+					 SYNPS_EDAC_MSG_SIZE - n,
+					 " Data_high: 0x%08x Syndrome: 0x%08x",
+					 (u32)(pinf->data >> 32),
+					 pinf->syndrome);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
 				 "CE", pinf->row, pinf->bank, pinf->col,
-				 pinf->bitpos, pinf->data);
+				 pinf->bitpos, (u32)(pinf->data));
 		}
 
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
@@ -636,70 +721,6 @@ static void check_errors(struct mem_ctl_info *mci)
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

