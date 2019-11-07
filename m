Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58CBEF3913
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2019 20:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfKGT7q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Nov 2019 14:59:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:34947 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfKGT7p (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Nov 2019 14:59:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 11:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,279,1569308400"; 
   d="scan'208";a="233379315"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2019 11:59:44 -0800
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 2/2] EDAC/altera: Use Altera System Manager driver
Date:   Thu,  7 Nov 2019 14:01:30 -0600
Message-Id: <1573156890-26891-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573156890-26891-1-git-send-email-thor.thayer@linux.intel.com>
References: <1573156890-26891-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Simplify the EDAC file by using the Altera System Manager
driver that abstracts the differences between ARM32 and ARM64.
Also allows the removal of the Arria10 test function since
this is handled by the System Manager driver.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/edac/altera_edac.c | 129 +++------------------------------------------
 1 file changed, 8 insertions(+), 121 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e893ff8731cb..0b57b8c831c7 100644
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
@@ -502,66 +502,6 @@ module_platform_driver(altr_sdram_edac_driver);
 
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
-};
-
 /************** </Stratix10 EDAC Memory Controller Functions> ***********/
 
 /************************* EDAC Parent Probe *************************/
@@ -1008,11 +948,6 @@ static int __maybe_unused altr_init_memory_port(void __iomem *ioaddr, int port)
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
@@ -1028,34 +963,10 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
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
@@ -2170,33 +2081,9 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
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

