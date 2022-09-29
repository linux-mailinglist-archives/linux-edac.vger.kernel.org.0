Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD55F1830
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 03:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiJABPZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 21:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiJABOl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 21:14:41 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E9A21B9C3;
        Fri, 30 Sep 2022 18:14:19 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id AFCF7E0ECE;
        Fri, 30 Sep 2022 02:27:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=DZzUjoXWg2WqISfYl0i0cmuSZ1xotghInRjtzKxrSc0=; b=LAQoY8Q2dql+
        oQ7Sk6iDI0QFobSdr5Spg3Z41+MSSlVNp/t5ZgNqyS6xD/u55yzyFZkn+mUf/7hE
        eycFl+T0OS+3vbjn6rpLWJeeuPAM9/m9ohf/1TzhmrRHrWi/MOUv3X1pK2htcrIk
        noR1OrOSVj19k65Zken8oPCD7xJosSU=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 9F1E5E0E6B;
        Fri, 30 Sep 2022 02:27:35 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:27:36 +0300
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
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3 16/17] EDAC/synopsys: Unify the driver entities naming
Date:   Fri, 30 Sep 2022 02:27:11 +0300
Message-ID: <20220929232712.12202-17-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
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

Currently the driver naming schema is kind of random. There are structures
and methods with the "synps" prefix, there are structures and methods
with no driver-specific prefix, there are methods with the "edac" prefix,
there are structure instances with "zynqmp" and "synopsys" prefixes, there
are macros with "SYNPS", "ECC" and "DDR" prefixes. Moreover some time ago
some of function names were shortened out by completely removing the
vendor-specific prefixes thus leaving the driver with no strict entities
naming convention (see commit bb894bc46ed0 ("EDAC, synopsys: Shorten
static function names")).

All of that makes the code much harder to read for no much reason (except
shorter names utilization) since there is no easy way to distinguish now
the local, EDAC core and global name spaces right from the code context.
Similarly the kernel code index services (like elixir) gets to find the
different functions with the same name, which harden the kernel hacking.

Let's fix all of that by unifying the driver local entity names like
functions, structures and non-CSR-related macros especially seeing the
same approach has been used in the most of the EDAC LLDD. We suggest to
use the "snps" prefix here as the shortest version of the controller
vendor name. While at it add a more detailed controller name (DW uMCTL2
DDRC) to the driver comments and string literals where it's appropriate.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Note "dw" prefix would be even shorter alternative. But we decided to
stick with "snps" since "synopsys" has already been used in the module
name.

Changelog v2:
- Forgot to fix some of the SYNPS_ZYNQMP_IRQ_REGS macro utilizations.
  (@tbot)
---
 drivers/edac/synopsys_edac.c | 240 +++++++++++++++++------------------
 1 file changed, 120 insertions(+), 120 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 26694f4fa162..49bb28af448b 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Synopsys DDR ECC Driver
+ * Synopsys DW uMCTL2 DDR ECC Driver
  * This driver is based on ppc4xx_edac.c drivers
  *
  * Copyright (C) 2012 - 2014 Xilinx, Inc.
@@ -18,23 +18,23 @@
 #include "edac_module.h"
 
 /* Number of cs_rows needed per memory controller */
-#define SYNPS_EDAC_NR_CSROWS		1
+#define SNPS_EDAC_NR_CSROWS		1
 
 /* Number of channels per memory controller */
-#define SYNPS_EDAC_NR_CHANS		1
+#define SNPS_EDAC_NR_CHANS		1
 
 /* Granularity of reported error in bytes */
-#define SYNPS_EDAC_ERR_GRAIN		1
+#define SNPS_EDAC_ERR_GRAIN		1
 
-#define SYNPS_EDAC_MSG_SIZE		256
+#define SNPS_EDAC_MSG_SIZE		256
 
-#define SYNPS_EDAC_MOD_STRING		"synps_edac"
-#define SYNPS_EDAC_MOD_VER		"1"
+#define SNPS_EDAC_MOD_STRING		"snps_edac"
+#define SNPS_EDAC_MOD_VER		"1"
 
 /* DDR ECC Quirks */
-#define SYNPS_ZYNQMP_IRQ_REGS		BIT(0)
+#define SNPS_ZYNQMP_IRQ_REGS		BIT(0)
 
-/* Synopsys DDR memory controller registers that are relevant to ECC */
+/* Synopsys uMCTL2 DDR controller registers that are relevant to ECC */
 
 /* DDRC master0 Register */
 #define DDR_MSTR_OFST			0x0
@@ -215,7 +215,7 @@
 #define RANK_B0_BASE			6
 
 /**
- * struct ecc_error_info - ECC error log information.
+ * struct snps_ecc_error_info - ECC error log information.
  * @row:	Row number.
  * @col:	Column number.
  * @bank:	Bank number.
@@ -223,7 +223,7 @@
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
  */
-struct ecc_error_info {
+struct snps_ecc_error_info {
 	u32 row;
 	u32 col;
 	u32 bank;
@@ -233,21 +233,21 @@ struct ecc_error_info {
 };
 
 /**
- * struct synps_ecc_status - ECC status information to report.
+ * struct snps_ecc_status - ECC status information to report.
  * @ce_cnt:	Correctable error count.
  * @ue_cnt:	Uncorrectable error count.
  * @ceinfo:	Correctable error log information.
  * @ueinfo:	Uncorrectable error log information.
  */
-struct synps_ecc_status {
+struct snps_ecc_status {
 	u32 ce_cnt;
 	u32 ue_cnt;
-	struct ecc_error_info ceinfo;
-	struct ecc_error_info ueinfo;
+	struct snps_ecc_error_info ceinfo;
+	struct snps_ecc_error_info ueinfo;
 };
 
 /**
- * struct synps_edac_priv - DDR memory controller private instance data.
+ * struct snps_edac_priv - DDR memory controller private data.
  * @baseaddr:		Base address of the DDR controller.
  * @lock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
@@ -260,12 +260,12 @@ struct synps_ecc_status {
  * @bankgrp_shift:	Bit shifts for bank group bit.
  * @rank_shift:		Bit shifts for rank bit.
  */
-struct synps_edac_priv {
+struct snps_edac_priv {
 	void __iomem *baseaddr;
 	spinlock_t lock;
-	char message[SYNPS_EDAC_MSG_SIZE];
-	struct synps_ecc_status stat;
-	const struct synps_platform_data *p_data;
+	char message[SNPS_EDAC_MSG_SIZE];
+	struct snps_ecc_status stat;
+	const struct snps_platform_data *p_data;
 #ifdef CONFIG_EDAC_DEBUG
 	ulong poison_addr;
 	u32 row_shift[18];
@@ -277,22 +277,22 @@ struct synps_edac_priv {
 };
 
 /**
- * struct synps_platform_data - Synopsys uMCTL2 DDRC platform data.
+ * struct snps_platform_data - Synopsys uMCTL2 DDRC platform data.
  * @quirks:	IP-core specific quirks.
  */
-struct synps_platform_data {
+struct snps_platform_data {
 	u32 quirks;
 };
 
 /**
- * synps_get_error_info - Get the current ECC error info.
+ * snps_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
  *
  * Return: one if there is no error otherwise returns zero.
  */
-static int synps_get_error_info(struct synps_edac_priv *priv)
+static int snps_get_error_info(struct snps_edac_priv *priv)
 {
-	struct synps_ecc_status *p;
+	struct snps_ecc_status *p;
 	u32 regval, clearval;
 	unsigned long flags;
 	void __iomem *base;
@@ -352,21 +352,21 @@ static int synps_get_error_info(struct synps_edac_priv *priv)
 }
 
 /**
- * handle_error - Handle Correctable and Uncorrectable errors.
+ * snps_handle_error - Handle Correctable and Uncorrectable errors.
  * @mci:	EDAC memory controller instance.
  * @p:		Synopsys ECC status structure.
  *
  * Handles ECC correctable and uncorrectable errors.
  */
-static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
+static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *p)
 {
-	struct synps_edac_priv *priv = mci->pvt_info;
-	struct ecc_error_info *pinf;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	struct snps_ecc_error_info *pinf;
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
 
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
 			 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08x",
 			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
 			 pinf->bitpos, pinf->data);
@@ -379,7 +379,7 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
 
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
 			 "Row %d Col %d Bank %d Bank Group %d",
 			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp);
 
@@ -391,12 +391,12 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 	memset(p, 0, sizeof(*p));
 }
 
-static void enable_intr(struct synps_edac_priv *priv)
+static void snps_enable_irq(struct snps_edac_priv *priv)
 {
 	unsigned long flags;
 
 	/* Enable UE/CE Interrupts */
-	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
+	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
 
@@ -412,12 +412,12 @@ static void enable_intr(struct synps_edac_priv *priv)
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
-static void disable_intr(struct synps_edac_priv *priv)
+static void snps_disable_irq(struct snps_edac_priv *priv)
 {
 	unsigned long flags;
 
 	/* Disable UE/CE Interrupts */
-	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
+	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 
@@ -432,42 +432,42 @@ static void disable_intr(struct synps_edac_priv *priv)
 }
 
 /**
- * intr_handler - Interrupt Handler for ECC interrupts.
+ * snps_irq_handler - Interrupt Handler for ECC interrupts.
  * @irq:        IRQ number.
  * @dev_id:     Device ID.
  *
  * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
  */
-static irqreturn_t intr_handler(int irq, void *dev_id)
+static irqreturn_t snps_irq_handler(int irq, void *dev_id)
 {
 	struct mem_ctl_info *mci = dev_id;
-	struct synps_edac_priv *priv;
+	struct snps_edac_priv *priv;
 	int status, regval;
 
 	priv = mci->pvt_info;
 
-	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
+	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS) {
 		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 		regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
 		if (!(regval & ECC_CE_UE_INTR_MASK))
 			return IRQ_NONE;
 	}
 
-	status = synps_get_error_info(priv);
+	status = snps_get_error_info(priv);
 	if (status)
 		return IRQ_NONE;
 
-	handle_error(mci, &priv->stat);
+	snps_handle_error(mci, &priv->stat);
 
 
-	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS)
+	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS)
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 
 	return IRQ_HANDLED;
 }
 
 /**
- * synps_get_dtype - Return the controller memory width.
+ * snps_get_dtype - Return the controller memory width.
  * @base:	DDR memory controller base address.
  *
  * Get the EDAC device type width appropriate for the current controller
@@ -475,7 +475,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type synps_get_dtype(const void __iomem *base)
+static enum dev_type snps_get_dtype(const void __iomem *base)
 {
 	u32 regval;
 
@@ -499,14 +499,14 @@ static enum dev_type synps_get_dtype(const void __iomem *base)
 }
 
 /**
- * synps_get_ecc_state - Return the controller ECC enable/disable status.
+ * snps_get_ecc_state - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
  *
  * Get the ECC enable/disable status for the controller.
  *
  * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
-static bool synps_get_ecc_state(void __iomem *base)
+static bool snps_get_ecc_state(void __iomem *base)
 {
 	u32 regval;
 
@@ -516,11 +516,11 @@ static bool synps_get_ecc_state(void __iomem *base)
 }
 
 /**
- * get_memsize - Read the size of the attached memory device.
+ * snps_get_memsize - Read the size of the attached memory device.
  *
  * Return: the memory size in bytes.
  */
-static u32 get_memsize(void)
+static u32 snps_get_memsize(void)
 {
 	struct sysinfo inf;
 
@@ -530,7 +530,7 @@ static u32 get_memsize(void)
 }
 
 /**
- * synps_get_mtype - Returns controller memory type.
+ * snps_get_mtype - Returns controller memory type.
  * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
@@ -538,7 +538,7 @@ static u32 get_memsize(void)
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type synps_get_mtype(const void __iomem *base)
+static enum mem_type snps_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -558,15 +558,15 @@ static enum mem_type synps_get_mtype(const void __iomem *base)
 }
 
 /**
- * init_csrows - Initialize the csrow data.
+ * snps_init_csrows - Initialize the csrow data.
  * @mci:	EDAC memory controller instance.
  *
  * Initialize the chip select rows associated with the EDAC memory
  * controller instance.
  */
-static void init_csrows(struct mem_ctl_info *mci)
+static void snps_init_csrows(struct mem_ctl_info *mci)
 {
-	struct synps_edac_priv *priv = mci->pvt_info;
+	struct snps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
 	u32 size, row;
@@ -574,21 +574,21 @@ static void init_csrows(struct mem_ctl_info *mci)
 
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
-		size = get_memsize();
+		size = snps_get_memsize();
 
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_SECDED;
-			dimm->mtype	= synps_get_mtype(priv->baseaddr);
+			dimm->mtype	= snps_get_mtype(priv->baseaddr);
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
-			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= synps_get_dtype(priv->baseaddr);
+			dimm->grain	= SNPS_EDAC_ERR_GRAIN;
+			dimm->dtype	= snps_get_dtype(priv->baseaddr);
 		}
 	}
 }
 
 /**
- * mc_init - Initialize one driver instance.
+ * snps_mc_init - Initialize one driver instance.
  * @mci:	EDAC memory controller instance.
  * @pdev:	platform device.
  *
@@ -596,7 +596,7 @@ static void init_csrows(struct mem_ctl_info *mci)
  * related driver-private data associated with the memory controller the
  * instance is bound to.
  */
-static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
+static void snps_mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 {
 	mci->pdev = &pdev->dev;
 	platform_set_drvdata(pdev, mci);
@@ -608,21 +608,22 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	mci->scrub_mode = SCRUB_NONE;
 
 	mci->edac_cap = EDAC_FLAG_SECDED;
-	mci->ctl_name = "synps_ddr_controller";
-	mci->dev_name = SYNPS_EDAC_MOD_STRING;
-	mci->mod_name = SYNPS_EDAC_MOD_VER;
+	mci->ctl_name = "snps_umctl2_ddrc";
+	mci->dev_name = SNPS_EDAC_MOD_STRING;
+	mci->mod_name = SNPS_EDAC_MOD_VER;
 
 	edac_op_state = EDAC_OPSTATE_INT;
 
 	mci->ctl_page_to_phys = NULL;
 
-	init_csrows(mci);
+	snps_init_csrows(mci);
 }
 
-static int setup_irq(struct mem_ctl_info *mci,
-		     struct platform_device *pdev)
+
+
+static int snps_setup_irq(struct mem_ctl_info *mci, struct platform_device *pdev)
 {
-	struct synps_edac_priv *priv = mci->pvt_info;
+	struct snps_edac_priv *priv = mci->pvt_info;
 	int ret, irq;
 
 	irq = platform_get_irq(pdev, 0);
@@ -632,14 +633,14 @@ static int setup_irq(struct mem_ctl_info *mci,
 		return irq;
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq, intr_handler,
+	ret = devm_request_irq(&pdev->dev, irq, snps_irq_handler,
 			       0, dev_name(&pdev->dev), mci);
 	if (ret < 0) {
 		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
 		return ret;
 	}
 
-	enable_intr(priv);
+	snps_enable_irq(priv);
 
 	return 0;
 }
@@ -647,13 +648,13 @@ static int setup_irq(struct mem_ctl_info *mci,
 #ifdef CONFIG_EDAC_DEBUG
 
 /**
- * ddr_poison_setup -	Update poison registers.
+ * snps_data_poison_setup - Update poison registers.
  * @priv:		DDR memory controller private instance data.
  *
  * Update poison registers as per DDR mapping.
  * Return: none.
  */
-static void ddr_poison_setup(struct synps_edac_priv *priv)
+static void snps_data_poison_setup(struct snps_edac_priv *priv)
 {
 	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
 	int index;
@@ -711,7 +712,7 @@ static ssize_t inject_data_error_show(struct device *dev,
 				      char *data)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
-	struct synps_edac_priv *priv = mci->pvt_info;
+	struct snps_edac_priv *priv = mci->pvt_info;
 
 	return sprintf(data, "Poison0 Addr: 0x%08x\n\rPoison1 Addr: 0x%08x\n\r"
 			"Error injection Address: 0x%lx\n\r",
@@ -725,12 +726,12 @@ static ssize_t inject_data_error_store(struct device *dev,
 				       const char *data, size_t count)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
-	struct synps_edac_priv *priv = mci->pvt_info;
+	struct snps_edac_priv *priv = mci->pvt_info;
 
 	if (kstrtoul(data, 0, &priv->poison_addr))
 		return -EINVAL;
 
-	ddr_poison_setup(priv);
+	snps_data_poison_setup(priv);
 
 	return count;
 }
@@ -740,7 +741,7 @@ static ssize_t inject_data_poison_show(struct device *dev,
 				       char *data)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
-	struct synps_edac_priv *priv = mci->pvt_info;
+	struct snps_edac_priv *priv = mci->pvt_info;
 
 	return sprintf(data, "Data Poisoning: %s\n\r",
 			(((readl(priv->baseaddr + ECC_CFG1_OFST)) & 0x3) == 0x3)
@@ -752,7 +753,7 @@ static ssize_t inject_data_poison_store(struct device *dev,
 					const char *data, size_t count)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
-	struct synps_edac_priv *priv = mci->pvt_info;
+	struct snps_edac_priv *priv = mci->pvt_info;
 
 	writel(0, priv->baseaddr + DDR_SWCTL);
 	if (strncmp(data, "CE", 2) == 0)
@@ -767,7 +768,7 @@ static ssize_t inject_data_poison_store(struct device *dev,
 static DEVICE_ATTR_RW(inject_data_error);
 static DEVICE_ATTR_RW(inject_data_poison);
 
-static int edac_create_sysfs_attributes(struct mem_ctl_info *mci)
+static int snps_create_sysfs_attributes(struct mem_ctl_info *mci)
 {
 	int rc;
 
@@ -780,13 +781,13 @@ static int edac_create_sysfs_attributes(struct mem_ctl_info *mci)
 	return 0;
 }
 
-static void edac_remove_sysfs_attributes(struct mem_ctl_info *mci)
+static void snps_remove_sysfs_attributes(struct mem_ctl_info *mci)
 {
 	device_remove_file(&mci->dev, &dev_attr_inject_data_error);
 	device_remove_file(&mci->dev, &dev_attr_inject_data_poison);
 }
 
-static void setup_row_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+static void snps_setup_row_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
 	u32 addrmap_row_b2_10;
 	int index;
@@ -845,7 +846,7 @@ static void setup_row_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 				ROW_MAX_VAL_MASK) + ROW_B17_BASE);
 }
 
-static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
 	u32 width, memtype;
 	int index;
@@ -947,7 +948,7 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 
 }
 
-static void setup_bank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+static void snps_setup_bank_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
 	priv->bank_shift[0] = (addrmap[1] & BANK_MAX_VAL_MASK) + BANK_B0_BASE;
 	priv->bank_shift[1] = ((addrmap[1] >> 8) &
@@ -959,7 +960,7 @@ static void setup_bank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 
 }
 
-static void setup_bg_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+static void snps_setup_bg_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
 	priv->bankgrp_shift[0] = (addrmap[8] &
 				BANKGRP_MAX_VAL_MASK) + BANKGRP_B0_BASE;
@@ -969,7 +970,7 @@ static void setup_bg_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 
 }
 
-static void setup_rank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+static void snps_setup_rank_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
 	priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
 				RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
@@ -977,14 +978,14 @@ static void setup_rank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 }
 
 /**
- * setup_address_map -	Set Address Map by querying ADDRMAP registers.
+ * snps_setup_address_map -	Set Address Map by querying ADDRMAP registers.
  * @priv:		DDR memory controller private instance data.
  *
  * Set Address Map by querying ADDRMAP registers.
  *
  * Return: none.
  */
-static void setup_address_map(struct synps_edac_priv *priv)
+static void snps_setup_address_map(struct snps_edac_priv *priv)
 {
 	u32 addrmap[12];
 	int index;
@@ -996,20 +997,20 @@ static void setup_address_map(struct synps_edac_priv *priv)
 		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
 	}
 
-	setup_row_address_map(priv, addrmap);
+	snps_setup_row_address_map(priv, addrmap);
 
-	setup_column_address_map(priv, addrmap);
+	snps_setup_column_address_map(priv, addrmap);
 
-	setup_bank_address_map(priv, addrmap);
+	snps_setup_bank_address_map(priv, addrmap);
 
-	setup_bg_address_map(priv, addrmap);
+	snps_setup_bg_address_map(priv, addrmap);
 
-	setup_rank_address_map(priv, addrmap);
+	snps_setup_rank_address_map(priv, addrmap);
 }
 #endif /* CONFIG_EDAC_DEBUG */
 
 /**
- * mc_probe - Check controller and bind driver.
+ * snps_mc_probe - Check controller and bind driver.
  * @pdev:	platform device.
  *
  * Probe a specific controller instance for binding with the driver.
@@ -1017,11 +1018,11 @@ static void setup_address_map(struct synps_edac_priv *priv)
  * Return: 0 if the controller instance was successfully bound to the
  * driver; otherwise, < 0 on error.
  */
-static int mc_probe(struct platform_device *pdev)
+static int snps_mc_probe(struct platform_device *pdev)
 {
-	const struct synps_platform_data *p_data;
+	const struct snps_platform_data *p_data;
 	struct edac_mc_layer layers[2];
-	struct synps_edac_priv *priv;
+	struct snps_edac_priv *priv;
 	struct mem_ctl_info *mci;
 	void __iomem *baseaddr;
 	int rc;
@@ -1034,20 +1035,20 @@ static int mc_probe(struct platform_device *pdev)
 	if (!p_data)
 		return -ENODEV;
 
-	if (!synps_get_ecc_state(baseaddr)) {
+	if (!snps_get_ecc_state(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
 
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = SYNPS_EDAC_NR_CSROWS;
+	layers[0].size = SNPS_EDAC_NR_CSROWS;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-	layers[1].size = SYNPS_EDAC_NR_CHANS;
+	layers[1].size = SNPS_EDAC_NR_CHANS;
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers,
-			    sizeof(struct synps_edac_priv));
+			    sizeof(struct snps_edac_priv));
 	if (!mci) {
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "Failed memory allocation for mc instance\n");
@@ -1059,9 +1060,9 @@ static int mc_probe(struct platform_device *pdev)
 	priv->p_data = p_data;
 	spin_lock_init(&priv->lock);
 
-	mc_init(mci, pdev);
+	snps_mc_init(mci, pdev);
 
-	rc = setup_irq(mci, pdev);
+	rc = snps_setup_irq(mci, pdev);
 	if (rc)
 		goto free_edac_mc;
 
@@ -1073,13 +1074,13 @@ static int mc_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_EDAC_DEBUG
-	rc = edac_create_sysfs_attributes(mci);
+	rc = snps_create_sysfs_attributes(mci);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC, "Failed to create sysfs entries\n");
 		goto free_edac_mc;
 	}
 
-	setup_address_map(priv);
+	snps_setup_address_map(priv);
 #endif
 
 	return rc;
@@ -1091,20 +1092,20 @@ static int mc_probe(struct platform_device *pdev)
 }
 
 /**
- * mc_remove - Unbind driver from controller.
+ * snps_mc_remove - Unbind driver from device.
  * @pdev:	Platform device.
  *
  * Return: Unconditionally 0
  */
-static int mc_remove(struct platform_device *pdev)
+static int snps_mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
-	struct synps_edac_priv *priv = mci->pvt_info;
+	struct snps_edac_priv *priv = mci->pvt_info;
 
-	disable_intr(priv);
+	snps_disable_irq(priv);
 
 #ifdef CONFIG_EDAC_DEBUG
-	edac_remove_sysfs_attributes(mci);
+	snps_remove_sysfs_attributes(mci);
 #endif
 
 	edac_mc_del_mc(&pdev->dev);
@@ -1113,32 +1114,31 @@ static int mc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct synps_platform_data zynqmp_edac_def = {
-	.quirks = SYNPS_ZYNQMP_IRQ_REGS,
+static const struct snps_platform_data zynqmp_edac_def = {
+	.quirks = SNPS_ZYNQMP_IRQ_REGS,
 };
 
-static const struct synps_platform_data synopsys_edac_def = {
+static const struct snps_platform_data snps_edac_def = {
 	.quirks = 0,
 };
 
-static const struct of_device_id synps_edac_match[] = {
+static const struct of_device_id snps_edac_match[] = {
 	{ .compatible = "xlnx,zynqmp-ddrc-2.40a", .data = &zynqmp_edac_def },
-	{ .compatible = "snps,ddrc-3.80a", .data = &synopsys_edac_def },
+	{ .compatible = "snps,ddrc-3.80a", .data = &snps_edac_def },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, synps_edac_match);
+MODULE_DEVICE_TABLE(of, snps_edac_match);
 
-static struct platform_driver synps_edac_mc_driver = {
+static struct platform_driver snps_edac_mc_driver = {
 	.driver = {
-		   .name = "synopsys-edac",
-		   .of_match_table = synps_edac_match,
+		   .name = "snps-edac",
+		   .of_match_table = snps_edac_match,
 		   },
-	.probe = mc_probe,
-	.remove = mc_remove,
+	.probe = snps_mc_probe,
+	.remove = snps_mc_remove,
 };
-
-module_platform_driver(synps_edac_mc_driver);
+module_platform_driver(snps_edac_mc_driver);
 
 MODULE_AUTHOR("Xilinx Inc");
-MODULE_DESCRIPTION("Synopsys DDR ECC driver");
+MODULE_DESCRIPTION("Synopsys uMCTL2 DDR ECC driver");
 MODULE_LICENSE("GPL v2");
-- 
2.37.3


