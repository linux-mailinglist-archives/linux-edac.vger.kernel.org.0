Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BA55B487F
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiIJTui (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIJTub (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:50:31 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C55D231EE4;
        Sat, 10 Sep 2022 12:50:27 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 9984BDBA;
        Sat, 10 Sep 2022 22:54:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 9984BDBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662839652;
        bh=1xxLSuVi2eit1FCXXEZw+6RcgU2hIKI6SUdKvOMAaE0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=fAhmOrrpHQRYKUj4fIL/rGU8mJZagmyRlSLuzUOKYJQZwRtKgellu0aVyx6HeaIbi
         FNggoS+YdeFejAG3hOrjPAKQ1jkiiFDRUz2ibZ6ghrf5o5F/d1Fq6zhi1Yph7pptjk
         eaoiEaEygfWddUq/VxPQ82NafU4YPGm3wKysYMQA=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:50:21 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v2 05/18] EDAC/synopsys: Add DDRC basic parameters infrastructure
Date:   Sat, 10 Sep 2022 22:49:54 +0300
Message-ID: <20220910195007.11027-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910195007.11027-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910195007.11027-1-Sergey.Semin@baikalelectronics.ru>
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

Currently the driver supports a single DW uMCTL2 DDRC IP-core: 64-bit DQ
bus, ECC SEC/DED with always on Scrub (HW-src scrub). This makes the
driver application being very limited. In addition to that lacking of any
controller capabilities/parameters infrastructure makes it harder to add
optional features support. Let's overcome all of that by adding a simple
DW uMCTL2 DDRC IP-core parameters infrastructure. It's made of the
snps_ddrc_info structure and a new method snps_get_ddrc_info() introduced
to fill the structure fields in. The structure contains the IP-core
parameters needed to create a more comprehensive driver and will be used
in the driver to activate/de-activate various features:
- ECC Mode: SEC/DED or Advanced X4/X8 ECC features. (Currently SEC/DED is
  only supported.)
- SDRAM mode: (LP)DDR[2-4] memory interfaces. (Required for the HIF/SDRAM
  address translation.)
- Memory Device config: Memory chips detected on the platform. (Applicable
  for DDR4 setups only.)
- DQ-bus width: Maximal DQ-bus width utilized by the device. (Required for
  the Application/HIF address translation.)
- DQ-bus mode: Actual DQ-bus width used to access the memory devices.
  (Required for the HIF/SDRAM address translation and ECC grain calc.)
- HIF/SDRAM burst length: Required for the Scrubber bandwidth
  calculation.
- HIF/SDRAM frequency ratio: Required for the SDRAM bandwidth
  calculation.
- SDRAM ranks number: Required for the Application/HIF address
  translation.

The list can be easily updated should any additional features support is
required to be added in future, but at this stage the driver is fixed in a
few places to have the new infrastructure utilized: SDRAM column address
mapper, MCI csrows initialization.

Note getting all of these parameters in a single method is very suitable
from two perspectives. First it localizes the IP-core parameters detection
thus improving the code readability and maintainability. Second it's very
suitable for the platform-specific quirks implementation. Since some of
the IP-core parameters can't be auto-detected at run-time, they will be
able to be fixed right in the parameters getter by means of the platform
quirks.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 268 +++++++++++++++++++++++++++--------
 1 file changed, 211 insertions(+), 57 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index f2f83b24d62c..b4db70224ee9 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
@@ -87,16 +88,21 @@
 /* DDR Software control register */
 #define DDR_SWCTL			0x320
 
+/* ECC Poison pattern registers */
+#define ECC_POISONPAT0_OFST		0x37C
+#define ECC_POISONPAT1_OFST		0x380
+#define ECC_POISONPAT2_OFST		0x384
+
 /* DDR Master Register 0 definitions */
 #define DDR_MSTR_DEV_CFG_MASK		GENMASK(31, 30)
 #define DDR_MSTR_DEV_X4			0x0
 #define DDR_MSTR_DEV_X8			0x1
 #define DDR_MSTR_DEV_X16		0x2
 #define DDR_MSTR_DEV_X32		0x3
+#define DDR_MSTR_ACT_RANKS_MASK		GENMASK(27, 24)
+#define DDR_MSTR_FREQ_RATIO11		BIT(22)
+#define DDR_MSTR_BURST_RDWR		GENMASK(19, 16)
 #define DDR_MSTR_BUSWIDTH_MASK		GENMASK(13, 12)
-#define DDRCTL_EWDTH_16			2
-#define DDRCTL_EWDTH_32			1
-#define DDRCTL_EWDTH_64			0
 #define DDR_MSTR_MEM_MASK		GENMASK(5, 0)
 #define DDR_MSTR_MEM_DDR2		0
 #define DDR_MSTR_MEM_DDR3		BIT(0)
@@ -108,7 +114,6 @@
 
 /* ECC CFG0 register definitions */
 #define ECC_CFG0_MODE_MASK		GENMASK(2, 0)
-#define ECC_CFG0_MODE_SECDED		0x4
 
 /* ECC status register definitions */
 #define ECC_STAT_UE_MASK		GENMASK(23, 16)
@@ -206,6 +211,91 @@
 
 #define RANK_B0_BASE			6
 
+/**
+ * enum snps_dq_width - SDRAM DQ bus width (ECC capable).
+ * SNPS_DQ_32:	32-bit memory data width.
+ * SNPS_DQ_64:	64-bit memory data width.
+ */
+enum snps_dq_width {
+	SNPS_DQ_32 = 2,
+	SNPS_DQ_64 = 3,
+};
+
+/**
+ * enum snps_dq_mode - SDRAM DQ bus mode.
+ * @SNPS_DQ_FULL:	Full DQ bus width.
+ * @SNPS_DQ_HALF:	Half DQ bus width.
+ * @SNPS_DQ_QRTR:	Quarter DQ bus width.
+ */
+enum snps_dq_mode {
+	SNPS_DQ_FULL = 0,
+	SNPS_DQ_HALF = 1,
+	SNPS_DQ_QRTR = 2,
+};
+
+/**
+ * enum snps_burst_length - HIF/SDRAM burst transactions length.
+ * @SNPS_DDR_BL2:	Burst length 2xSDRAM-words.
+ * @SNPS_DDR_BL4:	Burst length 4xSDRAM-words.
+ * @SNPS_DDR_BL8:	Burst length 8xSDRAM-words.
+ * @SNPS_DDR_BL16:	Burst length 16xSDRAM-words.
+ */
+enum snps_burst_length {
+	SNPS_DDR_BL2 = 2,
+	SNPS_DDR_BL4 = 4,
+	SNPS_DDR_BL8 = 8,
+	SNPS_DDR_BL16 = 16,
+};
+
+/**
+ * enum snps_freq_ratio - HIF:SDRAM frequency ratio mode.
+ * @SNPS_FREQ_RATIO11:	1:1 frequency mode.
+ * @SNPS_FREQ_RATIO12:	1:2 frequency mode.
+ */
+enum snps_freq_ratio {
+	SNPS_FREQ_RATIO11 = 1,
+	SNPS_FREQ_RATIO12 = 2,
+};
+
+/**
+ * enum snps_ecc_mode - ECC mode.
+ * @SNPS_ECC_DISABLED:	ECC is disabled/unavailable.
+ * @SNPS_ECC_SECDED:	SEC/DED over 1 beat ECC (SideBand/Inline).
+ * @SNPS_ECC_ADVX4X8:	Advanced ECC X4/X8 (SideBand).
+ */
+enum snps_ecc_mode {
+	SNPS_ECC_DISABLED = 0,
+	SNPS_ECC_SECDED = 4,
+	SNPS_ECC_ADVX4X8 = 5,
+};
+
+/**
+ * struct snps_ddrc_info - DDR controller platform parameters.
+ * @caps:		DDR controller capabilities.
+ * @sdram_mode:		Current SDRAM mode selected.
+ * @dev_cfg:		Current memory device config (if applicable).
+ * @dq_width:		Memory data bus width (width of the DQ signals
+ *			connected to SDRAM chips).
+ * @dq_mode:		Proportion of the DQ bus utilized to access SDRAM.
+ * @sdram_burst_len:	SDRAM burst transaction length.
+ * @hif_burst_len:	HIF burst transaction length (Host Interface).
+ * @freq_ratio:		HIF/SDRAM frequency ratio mode.
+ * @ecc_mode:		ECC mode enabled for the DDR controller (SEC/DED, etc).
+ * @ranks:		Number of ranks enabled to access DIMM (1, 2 or 4).
+ */
+struct snps_ddrc_info {
+	unsigned int caps;
+	enum mem_type sdram_mode;
+	enum dev_type dev_cfg;
+	enum snps_dq_width dq_width;
+	enum snps_dq_mode dq_mode;
+	enum snps_burst_length sdram_burst_len;
+	enum snps_burst_length hif_burst_len;
+	enum snps_freq_ratio freq_ratio;
+	enum snps_ecc_mode ecc_mode;
+	unsigned int ranks;
+};
+
 /**
  * struct snps_ecc_error_info - ECC error log information.
  * @row:	Row number.
@@ -240,6 +330,7 @@ struct snps_ecc_status {
 
 /**
  * struct snps_edac_priv - DDR memory controller private data.
+ * @info:		DDR controller config info.
  * @pdev:		Platform device.
  * @baseaddr:		Base address of the DDR controller.
  * @lock:		Concurrent CSRs access lock.
@@ -254,6 +345,7 @@ struct snps_ecc_status {
  * @rank_shift:		Bit shifts for rank bit.
  */
 struct snps_edac_priv {
+	struct snps_ddrc_info info;
 	struct platform_device *pdev;
 	void __iomem *baseaddr;
 	spinlock_t lock;
@@ -492,23 +584,19 @@ static struct snps_edac_priv *snps_create_data(struct platform_device *pdev)
 
 /**
  * snps_get_dtype - Return the controller memory width.
- * @base:	DDR memory controller base address.
+ * @mstr:	Master CSR value.
  *
  * Get the EDAC device type width appropriate for the current controller
  * configuration.
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type snps_get_dtype(const void __iomem *base)
+static inline enum dev_type snps_get_dtype(u32 mstr)
 {
-	u32 regval;
-
-	regval = readl(base + DDR_MSTR_OFST);
-	if (!(regval & DDR_MSTR_MEM_DDR4))
+	if (!(mstr & DDR_MSTR_MEM_DDR4))
 		return DEV_UNKNOWN;
 
-	regval = FIELD_GET(DDR_MSTR_DEV_CFG_MASK, regval);
-	switch (regval) {
+	switch (FIELD_GET(DDR_MSTR_DEV_CFG_MASK, mstr)) {
 	case DDR_MSTR_DEV_X4:
 		return DEV_X4;
 	case DDR_MSTR_DEV_X8:
@@ -522,24 +610,6 @@ static enum dev_type snps_get_dtype(const void __iomem *base)
 	return DEV_UNKNOWN;
 }
 
-/**
- * snps_get_ecc_state - Return the controller ECC enable/disable status.
- * @base:	DDR memory controller base address.
- *
- * Get the ECC enable/disable status for the controller.
- *
- * Return: a ECC status boolean i.e true/false - enabled/disabled.
- */
-static bool snps_get_ecc_state(void __iomem *base)
-{
-	u32 regval;
-
-	regval = readl(base + ECC_CFG0_OFST);
-	regval = FIELD_GET(ECC_CFG0_MODE_MASK, regval);
-
-	return (regval == ECC_CFG0_MODE_SECDED);
-}
-
 /**
  * snps_get_memsize - Read the size of the attached memory device.
  *
@@ -556,21 +626,16 @@ static u32 snps_get_memsize(void)
 
 /**
  * snps_get_mtype - Returns controller memory type.
- * @base:	Synopsys ECC status structure.
+ * @mstr:	Master CSR value.
  *
  * Get the EDAC memory type appropriate for the current controller
  * configuration.
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type snps_get_mtype(const void __iomem *base)
+static inline enum mem_type snps_get_mtype(u32 mstr)
 {
-	u32 regval;
-
-	regval = readl(base + DDR_MSTR_OFST);
-	regval = FIELD_GET(DDR_MSTR_MEM_MASK, regval);
-
-	switch (regval) {
+	switch (FIELD_GET(DDR_MSTR_MEM_MASK, mstr)) {
 	case DDR_MSTR_MEM_DDR2:
 		return MEM_DDR2;
 	case DDR_MSTR_MEM_DDR3:
@@ -590,6 +655,69 @@ static enum mem_type snps_get_mtype(const void __iomem *base)
 	return MEM_RESERVED;
 }
 
+/**
+ * snps_get_ddrc_info - Get the DDR controller config data.
+ * @priv:	DDR memory controller private data.
+ *
+ * Return: negative errno if no ECC detected, otherwise - zero.
+ */
+static int snps_get_ddrc_info(struct snps_edac_priv *priv)
+{
+	int (*init_plat)(struct snps_edac_priv *priv);
+	u32 regval;
+
+	/* Before getting the DDRC parameters make sure ECC is enabled */
+	regval = readl(priv->baseaddr + ECC_CFG0_OFST);
+
+	priv->info.ecc_mode = FIELD_GET(ECC_CFG0_MODE_MASK, regval);
+	if (priv->info.ecc_mode != SNPS_ECC_SECDED) {
+		edac_printk(KERN_INFO, EDAC_MC, "SEC/DED ECC not enabled\n");
+		return -ENXIO;
+	}
+
+	/* Auto-detect the basic HIF/SDRAM bus parameters */
+	regval = readl(priv->baseaddr + DDR_MSTR_OFST);
+
+	priv->info.sdram_mode = snps_get_mtype(regval);
+	priv->info.dev_cfg = snps_get_dtype(regval);
+
+	priv->info.dq_mode = FIELD_GET(DDR_MSTR_BUSWIDTH_MASK, regval);
+
+	/*
+	 * Assume HIF burst length matches the SDRAM burst length since it's
+	 * not auto-detectable
+	 */
+	priv->info.sdram_burst_len = FIELD_GET(DDR_MSTR_BURST_RDWR, regval) << 1;
+	priv->info.hif_burst_len = priv->info.sdram_burst_len;
+
+	/* Retrieve the current HIF/SDRAM frequency ratio: 1:1 vs 1:2 */
+	priv->info.freq_ratio = !(regval & DDR_MSTR_FREQ_RATIO11) + 1;
+
+	/* Activated ranks field: set bit corresponds to populated rank */
+	priv->info.ranks = FIELD_GET(DDR_MSTR_ACT_RANKS_MASK, regval);
+	priv->info.ranks = hweight_long(priv->info.ranks);
+
+	/* Auto-detect the DQ bus width by using the ECC-poison pattern CSR */
+	writel(0, priv->baseaddr + DDR_SWCTL);
+
+	/*
+	 * If poison pattern [32:64] is changeable then DQ is 64-bit wide.
+	 * Note the feature has been available since IP-core v2.51a.
+	 */
+	regval = readl(priv->baseaddr + ECC_POISONPAT1_OFST);
+	writel(~regval, priv->baseaddr + ECC_POISONPAT1_OFST);
+	if (regval != readl(priv->baseaddr + ECC_POISONPAT1_OFST)) {
+		priv->info.dq_width = SNPS_DQ_64;
+		writel(regval, priv->baseaddr + ECC_POISONPAT1_OFST);
+	} else {
+		priv->info.dq_width = SNPS_DQ_32;
+	}
+
+	writel(1, priv->baseaddr + DDR_SWCTL);
+
+	return 0;
+}
+
 /**
  * snps_init_csrows - Initialize the csrow data.
  * @mci:	EDAC memory controller instance.
@@ -612,10 +740,10 @@ static void snps_init_csrows(struct mem_ctl_info *mci)
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_SECDED;
-			dimm->mtype	= snps_get_mtype(priv->baseaddr);
+			dimm->mtype	= priv->info.sdram_mode;
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain	= SNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= snps_get_dtype(priv->baseaddr);
+			dimm->dtype	= priv->info.dev_cfg;
 		}
 	}
 }
@@ -729,6 +857,33 @@ static int snps_setup_irq(struct mem_ctl_info *mci)
 
 #define SNPS_DBGFS_BUF_LEN 128
 
+static int snps_ddrc_info_show(struct seq_file *s, void *data)
+{
+	struct mem_ctl_info *mci = s->private;
+	struct snps_edac_priv *priv = mci->pvt_info;
+
+	seq_printf(s, "SDRAM: %s\n", edac_mem_types[priv->info.sdram_mode]);
+
+	seq_printf(s, "DQ bus: %u/%s\n", (BITS_PER_BYTE << priv->info.dq_width),
+		   priv->info.dq_mode == SNPS_DQ_FULL ? "Full" :
+		   priv->info.dq_mode == SNPS_DQ_HALF ? "Half" :
+		   priv->info.dq_mode == SNPS_DQ_QRTR ? "Quarter" :
+		   "Unknown");
+	seq_printf(s, "Burst: SDRAM %u HIF %u\n", priv->info.sdram_burst_len,
+		   priv->info.hif_burst_len);
+
+	seq_printf(s, "Ranks: %u\n", priv->info.ranks);
+
+	seq_printf(s, "ECC: %s\n",
+		   priv->info.ecc_mode == SNPS_ECC_SECDED ? "SEC/DED" :
+		   priv->info.ecc_mode == SNPS_ECC_ADVX4X8 ? "Advanced X4/X8" :
+		   "Unknown");
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(snps_ddrc_info);
+
 /**
  * snps_data_poison_setup - Update poison registers.
  * @priv:		DDR memory controller private instance data.
@@ -850,12 +1005,8 @@ static void snps_setup_row_address_map(struct snps_edac_priv *priv, u32 *addrmap
 
 static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
-	u32 width, memtype;
 	int index;
 
-	memtype = readl(priv->baseaddr + DDR_MSTR_OFST);
-	width = FIELD_GET(DDR_MSTR_BUSWIDTH_MASK, memtype);
-
 	priv->col_shift[0] = 0;
 	priv->col_shift[1] = 1;
 	priv->col_shift[2] = (addrmap[2] & COL_MAX_VAL_MASK) + COL_B2_BASE;
@@ -879,8 +1030,8 @@ static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addr
 	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
 			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
 					COL_MAX_VAL_MASK) + COL_B9_BASE);
-	if (width == DDRCTL_EWDTH_64) {
-		if (memtype & DDR_MSTR_MEM_LPDDR3) {
+	if (priv->info.dq_mode == SNPS_DQ_FULL) {
+		if (priv->info.sdram_mode == MEM_LPDDR3) {
 			priv->col_shift[10] = ((addrmap[4] &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				((addrmap[4] & COL_MAX_VAL_MASK) +
@@ -899,8 +1050,8 @@ static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addr
 				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
 				 COL_B11_BASE);
 		}
-	} else if (width == DDRCTL_EWDTH_32) {
-		if (memtype & DDR_MSTR_MEM_LPDDR3) {
+	} else if (priv->info.dq_mode == SNPS_DQ_HALF) {
+		if (priv->info.sdram_mode == MEM_LPDDR3) {
 			priv->col_shift[10] = (((addrmap[3] >> 24) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
@@ -920,7 +1071,7 @@ static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addr
 				 COL_B10_BASE);
 		}
 	} else {
-		if (memtype & DDR_MSTR_MEM_LPDDR3) {
+		if (priv->info.sdram_mode == MEM_LPDDR3) {
 			priv->col_shift[10] = (((addrmap[3] >> 16) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
@@ -941,10 +1092,11 @@ static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addr
 		}
 	}
 
-	if (width) {
-		for (index = 9; index > width; index--) {
-			priv->col_shift[index] = priv->col_shift[index - width];
-			priv->col_shift[index - width] = 0;
+	if (priv->info.dq_mode) {
+		for (index = 9; index > priv->info.dq_mode; index--) {
+			priv->col_shift[index] =
+				priv->col_shift[index - priv->info.dq_mode];
+			priv->col_shift[index - priv->info.dq_mode] = 0;
 		}
 	}
 
@@ -1106,6 +1258,9 @@ static void snps_create_debugfs_nodes(struct mem_ctl_info *mci)
 
 	snps_setup_address_map(priv);
 
+	edac_debugfs_create_file("ddrc_info", 0400, mci->debugfs, mci,
+				 &snps_ddrc_info_fops);
+
 	edac_debugfs_create_file("inject_data_error", 0600, mci->debugfs, mci,
 				 &snps_inject_data_error);
 
@@ -1138,10 +1293,9 @@ static int snps_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
 
-	if (!snps_get_ecc_state(baseaddr)) {
-		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
-		return -ENXIO;
-	}
+	rc = snps_get_ddrc_info(priv);
+	if (rc)
+		return rc;
 
 	mci = snps_mc_create(priv);
 	if (IS_ERR(mci))
-- 
2.37.2

