Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4086770F7
	for <lists+linux-edac@lfdr.de>; Fri, 26 Jul 2019 20:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfGZSIB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Jul 2019 14:08:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:34946 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfGZSIB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 26 Jul 2019 14:08:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 11:08:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="173110623"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga003.jf.intel.com with ESMTP; 26 Jul 2019 11:07:59 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv3] EDAC, altera: Move Stratix10 SDRAM ECC to peripheral
Date:   Fri, 26 Jul 2019 13:09:58 -0500
Message-Id: <1564164598-20927-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

ARM32 SoCFPGAs had separate IRQs for SDRAM. ARM64 SoCFPGAs
send all DBEs to SError so filtering by source is necessary.

The Stratix10 SDRAM ECC is a better match with the generic
Altera peripheral ECC framework because the linked list can
be searched to find the ECC block offset and printout
the DBE Address.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Acked-by: James Morse <james.morse@arm.com>
---
v2 Use existing device tree bindings for SDRAM discovery.
v3 Replace multiple of_device_is_compatible() with of_match_node()
---
 drivers/edac/altera_edac.c | 61 ++++++++++++++++++++++++++++++++++++----------
 drivers/edac/altera_edac.h | 25 ++++++++++++++++++-
 2 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index c2e693e34d43..055eae1a8332 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -222,7 +222,6 @@ static unsigned long get_total_mem(void)
 static const struct of_device_id altr_sdram_ctrl_of_match[] = {
 	{ .compatible = "altr,sdram-edac", .data = &c5_data},
 	{ .compatible = "altr,sdram-edac-a10", .data = &a10_data},
-	{ .compatible = "altr,sdram-edac-s10", .data = &a10_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, altr_sdram_ctrl_of_match);
@@ -1170,6 +1169,24 @@ static int __init __maybe_unused altr_init_a10_ecc_device_type(char *compat)
 	return 0;
 }
 
+/*********************** SDRAM EDAC Device Functions *********************/
+
+#ifdef CONFIG_EDAC_ALTERA_SDRAM
+
+static const struct edac_device_prv_data s10_sdramecc_data = {
+	.setup = altr_check_ecc_deps,
+	.ce_clear_mask = ALTR_S10_ECC_SERRPENA,
+	.ue_clear_mask = ALTR_S10_ECC_DERRPENA,
+	.ecc_enable_mask = ALTR_S10_ECC_EN,
+	.ecc_en_ofst = ALTR_S10_ECC_CTRL_SDRAM_OFST,
+	.ce_set_mask = ALTR_S10_ECC_TSERRA,
+	.ue_set_mask = ALTR_S10_ECC_TDERRA,
+	.set_err_ofst = ALTR_S10_ECC_INTTEST_OFST,
+	.ecc_irq_handler = altr_edac_a10_ecc_irq,
+	.inject_fops = &altr_edac_a10_device_inject_fops,
+};
+#endif /* CONFIG_EDAC_ALTERA_SDRAM */
+
 /*********************** OCRAM EDAC Device Functions *********************/
 
 #ifdef CONFIG_EDAC_ALTERA_OCRAM
@@ -1759,6 +1776,9 @@ static const struct of_device_id altr_edac_a10_device_of_match[] = {
 #ifdef CONFIG_EDAC_ALTERA_SDMMC
 	{ .compatible = "altr,socfpga-sdmmc-ecc", .data = &a10_sdmmcecca_data },
 #endif
+#ifdef CONFIG_EDAC_ALTERA_SDRAM
+	{ .compatible = "altr,sdram-edac-s10", .data = &s10_sdramecc_data },
+#endif
 	{},
 };
 MODULE_DEVICE_TABLE(of, altr_edac_a10_device_of_match);
@@ -1889,6 +1909,10 @@ static int validate_parent_available(struct device_node *np)
 	struct device_node *parent;
 	int ret = 0;
 
+	/* SDRAM must be present for Linux (implied parent) */
+	if (of_device_is_compatible(np, "altr,sdram-edac-s10"))
+		return 0;
+
 	/* Ensure parent device is enabled if parent node exists */
 	parent = of_parse_phandle(np, "altr,ecc-parent", 0);
 	if (parent && !of_device_is_available(parent))
@@ -1898,6 +1922,22 @@ static int validate_parent_available(struct device_node *np)
 	return ret;
 }
 
+static int get_s10_sdram_edac_resource(struct device_node *np,
+				       struct resource *res)
+{
+	struct device_node *parent;
+	int ret;
+
+	parent = of_parse_phandle(np, "altr,sdr-syscon", 0);
+	if (!parent)
+		return -ENODEV;
+
+	ret = of_address_to_resource(parent, 0, res);
+	of_node_put(parent);
+
+	return ret;
+}
+
 static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 				    struct device_node *np)
 {
@@ -1925,7 +1965,11 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 	if (!devres_open_group(edac->dev, altr_edac_a10_device_add, GFP_KERNEL))
 		return -ENOMEM;
 
-	rc = of_address_to_resource(np, 0, &res);
+	if (of_device_is_compatible(np, "altr,sdram-edac-s10"))
+		rc = get_s10_sdram_edac_resource(np, &res);
+	else
+		rc = of_address_to_resource(np, 0, &res);
+
 	if (rc < 0) {
 		edac_printk(KERN_ERR, EDAC_DEVICE,
 			    "%s: no resource address\n", ecc_name);
@@ -2224,20 +2268,11 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		if (!of_device_is_available(child))
 			continue;
 
-		if (of_device_is_compatible(child, "altr,socfpga-a10-l2-ecc") || 
-		    of_device_is_compatible(child, "altr,socfpga-a10-ocram-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-eth-mac-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-nand-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-dma-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-usb-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-qspi-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-sdmmc-ecc"))
-
+		if (of_match_node(altr_edac_a10_device_of_match, child))
 			altr_edac_a10_device_add(edac, child);
 
 #ifdef CONFIG_EDAC_ALTERA_SDRAM
-		else if ((of_device_is_compatible(child, "altr,sdram-edac-a10")) ||
-			 (of_device_is_compatible(child, "altr,sdram-edac-s10")))
+		else if (of_device_is_compatible(child, "altr,sdram-edac-a10"))
 			of_platform_populate(pdev->dev.of_node,
 					     altr_sdram_ctrl_of_match,
 					     NULL, &pdev->dev);
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 55654cc4bcdf..3727e72c8c2e 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -289,6 +289,29 @@ struct altr_sdram_mc_data {
 #define ALTR_A10_ECC_INIT_WATCHDOG_10US      10000
 
 /************* Stratix10 Defines **************/
+#define ALTR_S10_ECC_CTRL_SDRAM_OFST      0x00
+#define ALTR_S10_ECC_EN                   BIT(0)
+
+#define ALTR_S10_ECC_ERRINTEN_OFST        0x10
+#define ALTR_S10_ECC_ERRINTENS_OFST       0x14
+#define ALTR_S10_ECC_ERRINTENR_OFST       0x18
+#define ALTR_S10_ECC_SERRINTEN            BIT(0)
+
+#define ALTR_S10_ECC_INTMODE_OFST         0x1C
+#define ALTR_S10_ECC_INTMODE              BIT(0)
+
+#define ALTR_S10_ECC_INTSTAT_OFST         0x20
+#define ALTR_S10_ECC_SERRPENA             BIT(0)
+#define ALTR_S10_ECC_DERRPENA             BIT(8)
+#define ALTR_S10_ECC_ERRPENA_MASK         (ALTR_S10_ECC_SERRPENA | \
+					   ALTR_S10_ECC_DERRPENA)
+
+#define ALTR_S10_ECC_INTTEST_OFST         0x24
+#define ALTR_S10_ECC_TSERRA               BIT(0)
+#define ALTR_S10_ECC_TDERRA               BIT(8)
+#define ALTR_S10_ECC_TSERRB               BIT(16)
+#define ALTR_S10_ECC_TDERRB               BIT(24)
+
 #define ALTR_S10_DERR_ADDRA_OFST          0x2C
 
 /* Stratix10 ECC Manager Defines */
@@ -300,7 +323,7 @@ struct altr_sdram_mc_data {
 #define S10_SYSMGR_UE_ADDR_OFST           0x224
 
 #define S10_DDR0_IRQ_MASK                 BIT(16)
-#define S10_DBE_IRQ_MASK                  0x3FE
+#define S10_DBE_IRQ_MASK                  0x3FFFE
 
 /* Define ECC Block Offsets for peripherals */
 #define ECC_BLK_ADDRESS_OFST              0x40
-- 
2.7.4

