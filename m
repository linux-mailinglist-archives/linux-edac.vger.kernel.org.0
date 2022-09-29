Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585B55F183D
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 03:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiJABPw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 21:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiJABPD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 21:15:03 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5096845075;
        Fri, 30 Sep 2022 18:14:26 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 0A0B9E0ECD;
        Fri, 30 Sep 2022 02:27:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=UzRs7FcO/lpt1w1HBG/bRjrxScHVgwRdl8t3RlwNPKY=; b=SeSjeNRgJQJi
        snzBHCPxOVVrv/n7PVutd2Jx0uEPRiK+AVLIzdsvmRm0rp9HAfSYowig76H9ZJyJ
        WxRR9I31wgAE0UvgJflVZgoAoV1vG6hhKr7DgHbU1YDmUTD4P/QuZLGU4ufBt9kw
        y01cnDr/wUyzaSmzP9DGqz7rK2UXr1c=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id EF491E0E6B;
        Fri, 30 Sep 2022 02:27:34 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:27:35 +0300
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
Subject: [PATCH RESEND v3 15/17] EDAC/synopsys: Drop unused platform-specific setup API
Date:   Fri, 30 Sep 2022 02:27:10 +0300
Message-ID: <20220929232712.12202-16-Sergey.Semin@baikalelectronics.ru>
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

The driver now works with the Synopys DW uMCTL2 DDR IP-core only (Xilinx
Zynq A05 DDRc support has been moved to the dedicated driver). Pretty much
all the currently available IP-core revisions have got the same ECC and
main DDR-config CSRs map. Thus there is no point in supporting the no
longer used platform-specific API like the callbacks responsible for
getting the ECC errors info, memory and device types, ECC state. All of
that data can be retrieved in the same way on all the Synopys DW uMCTL2
DDR controller versions. Similarly there is no longer need in the
DDR_ECC_INTR_SUPPORT and DDR_ECC_DATA_POISON_SUPPORT quirk flags since DW
uMCTL2 always supports IRQs and data poisoning. Let's drop that
infrastructure for good then.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Drop the no longer used "priv" pointer from the mc_init() function.
  (@tbot)
---
 drivers/edac/synopsys_edac.c | 197 +++++++++--------------------------
 1 file changed, 51 insertions(+), 146 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index f48b3a2938f7..26694f4fa162 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -32,9 +32,7 @@
 #define SYNPS_EDAC_MOD_VER		"1"
 
 /* DDR ECC Quirks */
-#define DDR_ECC_INTR_SUPPORT		BIT(0)
-#define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
-#define SYNPS_ZYNQMP_IRQ_REGS		BIT(2)
+#define SYNPS_ZYNQMP_IRQ_REGS		BIT(0)
 
 /* Synopsys DDR memory controller registers that are relevant to ECC */
 
@@ -279,28 +277,20 @@ struct synps_edac_priv {
 };
 
 /**
- * struct synps_platform_data -  synps platform data structure.
- * @get_error_info:	Get EDAC error info.
- * @get_mtype:		Get mtype.
- * @get_dtype:		Get dtype.
- * @get_ecc_state:	Get ECC state.
- * @quirks:		To differentiate IPs.
+ * struct synps_platform_data - Synopsys uMCTL2 DDRC platform data.
+ * @quirks:	IP-core specific quirks.
  */
 struct synps_platform_data {
-	int (*get_error_info)(struct synps_edac_priv *priv);
-	enum mem_type (*get_mtype)(const void __iomem *base);
-	enum dev_type (*get_dtype)(const void __iomem *base);
-	bool (*get_ecc_state)(void __iomem *base);
-	int quirks;
+	u32 quirks;
 };
 
 /**
- * zynqmp_get_error_info - Get the current ECC error info.
+ * synps_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
  *
  * Return: one if there is no error otherwise returns zero.
  */
-static int zynqmp_get_error_info(struct synps_edac_priv *priv)
+static int synps_get_error_info(struct synps_edac_priv *priv)
 {
 	struct synps_ecc_status *p;
 	u32 regval, clearval;
@@ -375,17 +365,11 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
-		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08x",
-				 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
-				 pinf->bitpos, pinf->data);
-		} else {
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Row %d Bank %d Col %d Bit: %d Data: 0x%08x",
-				 pinf->row, pinf->bank, pinf->col,
-				 pinf->bitpos, pinf->data);
-		}
+
+		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+			 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08x",
+			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
+			 pinf->bitpos, pinf->data);
 
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
 				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
@@ -394,15 +378,10 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
-		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Row %d Col %d Bank %d Bank Group %d",
-				 pinf->row, pinf->col, pinf->bank, pinf->bankgrp);
-		} else {
-			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "Row %d Bank %d Col %d",
-				 pinf->row, pinf->bank, pinf->col);
-		}
+
+		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+			 "Row %d Col %d Bank %d Bank Group %d",
+			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp);
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
@@ -461,13 +440,11 @@ static void disable_intr(struct synps_edac_priv *priv)
  */
 static irqreturn_t intr_handler(int irq, void *dev_id)
 {
-	const struct synps_platform_data *p_data;
 	struct mem_ctl_info *mci = dev_id;
 	struct synps_edac_priv *priv;
 	int status, regval;
 
 	priv = mci->pvt_info;
-	p_data = priv->p_data;
 
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
 		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
@@ -476,7 +453,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 			return IRQ_NONE;
 	}
 
-	status = p_data->get_error_info(priv);
+	status = synps_get_error_info(priv);
 	if (status)
 		return IRQ_NONE;
 
@@ -490,34 +467,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 }
 
 /**
- * check_errors - Check controller for ECC errors.
- * @mci:	EDAC memory controller instance.
- *
- * Check and post ECC errors. Called by the polling thread.
- */
-static void check_errors(struct mem_ctl_info *mci)
-{
-	const struct synps_platform_data *p_data;
-	struct synps_edac_priv *priv;
-	int status;
-
-	priv = mci->pvt_info;
-	p_data = priv->p_data;
-
-	status = p_data->get_error_info(priv);
-	if (status)
-		return;
-
-	priv->ce_cnt += priv->stat.ce_cnt;
-	priv->ue_cnt += priv->stat.ue_cnt;
-	handle_error(mci, &priv->stat);
-
-	edac_dbg(3, "Total error count CE %d UE %d\n",
-		 priv->ce_cnt, priv->ue_cnt);
-}
-
-/**
- * zynqmp_get_dtype - Return the controller memory width.
+ * synps_get_dtype - Return the controller memory width.
  * @base:	DDR memory controller base address.
  *
  * Get the EDAC device type width appropriate for the current controller
@@ -525,7 +475,7 @@ static void check_errors(struct mem_ctl_info *mci)
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type zynqmp_get_dtype(const void __iomem *base)
+static enum dev_type synps_get_dtype(const void __iomem *base)
 {
 	u32 regval;
 
@@ -549,14 +499,14 @@ static enum dev_type zynqmp_get_dtype(const void __iomem *base)
 }
 
 /**
- * zynqmp_get_ecc_state - Return the controller ECC enable/disable status.
+ * synps_get_ecc_state - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
  *
  * Get the ECC enable/disable status for the controller.
  *
  * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
-static bool zynqmp_get_ecc_state(void __iomem *base)
+static bool synps_get_ecc_state(void __iomem *base)
 {
 	u32 regval;
 
@@ -580,7 +530,7 @@ static u32 get_memsize(void)
 }
 
 /**
- * zynqmp_get_mtype - Returns controller memory type.
+ * synps_get_mtype - Returns controller memory type.
  * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
@@ -588,7 +538,7 @@ static u32 get_memsize(void)
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type zynqmp_get_mtype(const void __iomem *base)
+static enum mem_type synps_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -617,14 +567,11 @@ static enum mem_type zynqmp_get_mtype(const void __iomem *base)
 static void init_csrows(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
-	const struct synps_platform_data *p_data;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
 	u32 size, row;
 	int j;
 
-	p_data = priv->p_data;
-
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
 		size = get_memsize();
@@ -632,10 +579,10 @@ static void init_csrows(struct mem_ctl_info *mci)
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_SECDED;
-			dimm->mtype	= p_data->get_mtype(priv->baseaddr);
+			dimm->mtype	= synps_get_mtype(priv->baseaddr);
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= p_data->get_dtype(priv->baseaddr);
+			dimm->dtype	= synps_get_dtype(priv->baseaddr);
 		}
 	}
 }
@@ -651,10 +598,7 @@ static void init_csrows(struct mem_ctl_info *mci)
  */
 static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 {
-	struct synps_edac_priv *priv;
-
 	mci->pdev = &pdev->dev;
-	priv = mci->pvt_info;
 	platform_set_drvdata(pdev, mci);
 
 	/* Initialize controller capabilities and configuration */
@@ -668,12 +612,7 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	mci->dev_name = SYNPS_EDAC_MOD_STRING;
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
-	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
-		edac_op_state = EDAC_OPSTATE_INT;
-	} else {
-		edac_op_state = EDAC_OPSTATE_POLL;
-		mci->edac_check = check_errors;
-	}
+	edac_op_state = EDAC_OPSTATE_INT;
 
 	mci->ctl_page_to_phys = NULL;
 
@@ -705,47 +644,6 @@ static int setup_irq(struct mem_ctl_info *mci,
 	return 0;
 }
 
-static const struct synps_platform_data zynqmp_edac_def = {
-	.get_error_info	= zynqmp_get_error_info,
-	.get_mtype	= zynqmp_get_mtype,
-	.get_dtype	= zynqmp_get_dtype,
-	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks         = (DDR_ECC_INTR_SUPPORT | SYNPS_ZYNQMP_IRQ_REGS
-#ifdef CONFIG_EDAC_DEBUG
-			  | DDR_ECC_DATA_POISON_SUPPORT
-#endif
-			  ),
-};
-
-static const struct synps_platform_data synopsys_edac_def = {
-	.get_error_info	= zynqmp_get_error_info,
-	.get_mtype	= zynqmp_get_mtype,
-	.get_dtype	= zynqmp_get_dtype,
-	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks         = (DDR_ECC_INTR_SUPPORT
-#ifdef CONFIG_EDAC_DEBUG
-			  | DDR_ECC_DATA_POISON_SUPPORT
-#endif
-			  ),
-};
-
-
-static const struct of_device_id synps_edac_match[] = {
-	{
-		.compatible = "xlnx,zynqmp-ddrc-2.40a",
-		.data = (void *)&zynqmp_edac_def
-	},
-	{
-		.compatible = "snps,ddrc-3.80a",
-		.data = (void *)&synopsys_edac_def
-	},
-	{
-		/* end of table */
-	}
-};
-
-MODULE_DEVICE_TABLE(of, synps_edac_match);
-
 #ifdef CONFIG_EDAC_DEBUG
 
 /**
@@ -1136,7 +1034,7 @@ static int mc_probe(struct platform_device *pdev)
 	if (!p_data)
 		return -ENODEV;
 
-	if (!p_data->get_ecc_state(baseaddr)) {
+	if (!synps_get_ecc_state(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -1163,11 +1061,9 @@ static int mc_probe(struct platform_device *pdev)
 
 	mc_init(mci, pdev);
 
-	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
-		rc = setup_irq(mci, pdev);
-		if (rc)
-			goto free_edac_mc;
-	}
+	rc = setup_irq(mci, pdev);
+	if (rc)
+		goto free_edac_mc;
 
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
@@ -1177,17 +1073,13 @@ static int mc_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_EDAC_DEBUG
-	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
-		rc = edac_create_sysfs_attributes(mci);
-		if (rc) {
-			edac_printk(KERN_ERR, EDAC_MC,
-					"Failed to create sysfs entries\n");
-			goto free_edac_mc;
-		}
+	rc = edac_create_sysfs_attributes(mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to create sysfs entries\n");
+		goto free_edac_mc;
 	}
 
-	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
-		setup_address_map(priv);
+	setup_address_map(priv);
 #endif
 
 	return rc;
@@ -1209,12 +1101,10 @@ static int mc_remove(struct platform_device *pdev)
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 	struct synps_edac_priv *priv = mci->pvt_info;
 
-	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
-		disable_intr(priv);
+	disable_intr(priv);
 
 #ifdef CONFIG_EDAC_DEBUG
-	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT)
-		edac_remove_sysfs_attributes(mci);
+	edac_remove_sysfs_attributes(mci);
 #endif
 
 	edac_mc_del_mc(&pdev->dev);
@@ -1223,6 +1113,21 @@ static int mc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct synps_platform_data zynqmp_edac_def = {
+	.quirks = SYNPS_ZYNQMP_IRQ_REGS,
+};
+
+static const struct synps_platform_data synopsys_edac_def = {
+	.quirks = 0,
+};
+
+static const struct of_device_id synps_edac_match[] = {
+	{ .compatible = "xlnx,zynqmp-ddrc-2.40a", .data = &zynqmp_edac_def },
+	{ .compatible = "snps,ddrc-3.80a", .data = &synopsys_edac_def },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, synps_edac_match);
+
 static struct platform_driver synps_edac_mc_driver = {
 	.driver = {
 		   .name = "synopsys-edac",
-- 
2.37.3


