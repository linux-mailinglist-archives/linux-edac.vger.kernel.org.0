Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D061105989
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2019 19:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfKUS33 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Nov 2019 13:29:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:51962 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUS33 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 21 Nov 2019 13:29:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 10:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,226,1571727600"; 
   d="scan'208";a="381823410"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga005.jf.intel.com with ESMTP; 21 Nov 2019 10:29:27 -0800
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com
Cc:     Meng.Li@windriver.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv2 3/3] EDAC/altera: Use the Altera System Manager driver
Date:   Thu, 21 Nov 2019 12:30:48 -0600
Message-Id: <1574361048-17572-4-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574361048-17572-1-git-send-email-thor.thayer@linux.intel.com>
References: <1574361048-17572-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Simplify the EDAC file by using the Altera System Manager driver that
abstracts the differences between ARM32 and ARM64. Also allows the
removal of the Arria10 test function since this is handled by the System
Manager driver.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
V2 Rebase on top of fast IO fix.
---
 drivers/edac/altera_edac.c | 132 +++------------------------------------------
 1 file changed, 8 insertions(+), 124 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 3e86cf327ad0..e91cf1147a4e 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/kernel.h>
+#include <linux/mfd/altera-sysmgr.h>
 #include <linux/mfd/syscon.h>
 #include <linux/notifier.h>
 #include <linux/of_address.h>
@@ -275,7 +276,6 @@ static int a10_unmask_irq(struct platform_device *pdev, u32 mask)
 	return ret;
 }
 
-static int socfpga_is_a10(void);
 static int altr_sdram_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *id;
@@ -399,7 +399,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
 		goto err;
 
 	/* Only the Arria10 has separate IRQs */
-	if (socfpga_is_a10()) {
+	if (of_machine_is_compatible("altr,socfpga-arria10")) {
 		/* Arria10 specific initialization */
 		res = a10_init(mc_vbase);
 		if (res < 0)
@@ -502,69 +502,6 @@ module_platform_driver(altr_sdram_edac_driver);
 
 #endif	/* CONFIG_EDAC_ALTERA_SDRAM */
 
-/**************** Stratix 10 EDAC Memory Controller Functions ************/
-
-/**
- * s10_protected_reg_write
- * Write to a protected SMC register.
- * @context: Not used.
- * @reg: Address of register
- * @value: Value to write
- * Return: INTEL_SIP_SMC_STATUS_OK (0) on success
- *	   INTEL_SIP_SMC_REG_ERROR on error
- *	   INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION if not supported
- */
-static int s10_protected_reg_write(void *context, unsigned int reg,
-				   unsigned int val)
-{
-	struct arm_smccc_res result;
-	unsigned long offset = (unsigned long)context;
-
-	arm_smccc_smc(INTEL_SIP_SMC_REG_WRITE, offset + reg, val, 0, 0,
-		      0, 0, 0, &result);
-
-	return (int)result.a0;
-}
-
-/**
- * s10_protected_reg_read
- * Read the status of a protected SMC register
- * @context: Not used.
- * @reg: Address of register
- * @value: Value read.
- * Return: INTEL_SIP_SMC_STATUS_OK (0) on success
- *	   INTEL_SIP_SMC_REG_ERROR on error
- *	   INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION if not supported
- */
-static int s10_protected_reg_read(void *context, unsigned int reg,
-				  unsigned int *val)
-{
-	struct arm_smccc_res result;
-	unsigned long offset = (unsigned long)context;
-
-	arm_smccc_smc(INTEL_SIP_SMC_REG_READ, offset + reg, 0, 0, 0,
-		      0, 0, 0, &result);
-
-	*val = (unsigned int)result.a1;
-
-	return (int)result.a0;
-}
-
-static const struct regmap_config s10_sdram_regmap_cfg = {
-	.name = "s10_ddr",
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = 0xffd12228,
-	.reg_read = s10_protected_reg_read,
-	.reg_write = s10_protected_reg_write,
-	.use_single_read = true,
-	.use_single_write = true,
-	.fast_io = true,
-};
-
-/************** </Stratix10 EDAC Memory Controller Functions> ***********/
-
 /************************* EDAC Parent Probe *************************/
 
 static const struct of_device_id altr_edac_device_of_match[];
@@ -1009,11 +946,6 @@ static int __maybe_unused altr_init_memory_port(void __iomem *ioaddr, int port)
 	return ret;
 }
 
-static int socfpga_is_a10(void)
-{
-	return of_machine_is_compatible("altr,socfpga-arria10");
-}
-
 static __init int __maybe_unused
 altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 			u32 ecc_ctrl_en_mask, bool dual_port)
@@ -1029,34 +961,10 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 	/* Get the ECC Manager - parent of the device EDACs */
 	np_eccmgr = of_get_parent(np);
 
-	if (socfpga_is_a10()) {
-		ecc_mgr_map = syscon_regmap_lookup_by_phandle(np_eccmgr,
-							      "altr,sysmgr-syscon");
-	} else {
-		struct device_node *sysmgr_np;
-		struct resource res;
-		uintptr_t base;
-
-		sysmgr_np = of_parse_phandle(np_eccmgr,
-					     "altr,sysmgr-syscon", 0);
-		if (!sysmgr_np) {
-			edac_printk(KERN_ERR, EDAC_DEVICE,
-				    "Unable to find altr,sysmgr-syscon\n");
-			return -ENODEV;
-		}
+	ecc_mgr_map =
+		altr_sysmgr_regmap_lookup_by_phandle(np_eccmgr,
+						     "altr,sysmgr-syscon");
 
-		if (of_address_to_resource(sysmgr_np, 0, &res)) {
-			of_node_put(sysmgr_np);
-			return -ENOMEM;
-		}
-
-		/* Need physical address for SMCC call */
-		base = res.start;
-
-		ecc_mgr_map = regmap_init(NULL, NULL, (void *)base,
-					  &s10_sdram_regmap_cfg);
-		of_node_put(sysmgr_np);
-	}
 	of_node_put(np_eccmgr);
 	if (IS_ERR(ecc_mgr_map)) {
 		edac_printk(KERN_ERR, EDAC_DEVICE,
@@ -2171,33 +2079,9 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, edac);
 	INIT_LIST_HEAD(&edac->a10_ecc_devices);
 
-	if (socfpga_is_a10()) {
-		edac->ecc_mgr_map =
-			syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-							"altr,sysmgr-syscon");
-	} else {
-		struct device_node *sysmgr_np;
-		struct resource res;
-		uintptr_t base;
-
-		sysmgr_np = of_parse_phandle(pdev->dev.of_node,
-					     "altr,sysmgr-syscon", 0);
-		if (!sysmgr_np) {
-			edac_printk(KERN_ERR, EDAC_DEVICE,
-				    "Unable to find altr,sysmgr-syscon\n");
-			return -ENODEV;
-		}
-
-		if (of_address_to_resource(sysmgr_np, 0, &res))
-			return -ENOMEM;
-
-		/* Need physical address for SMCC call */
-		base = res.start;
-
-		edac->ecc_mgr_map = devm_regmap_init(&pdev->dev, NULL,
-						     (void *)base,
-						     &s10_sdram_regmap_cfg);
-	}
+	edac->ecc_mgr_map =
+		altr_sysmgr_regmap_lookup_by_phandle(pdev->dev.of_node,
+						     "altr,sysmgr-syscon");
 
 	if (IS_ERR(edac->ecc_mgr_map)) {
 		edac_printk(KERN_ERR, EDAC_DEVICE,
-- 
2.7.4

