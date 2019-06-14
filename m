Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB874679D
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 20:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfFNSgV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 14:36:21 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:44181 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725886AbfFNSgU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 14 Jun 2019 14:36:20 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from sramani@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 14 Jun 2019 21:36:15 +0300
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x5EIaEPI028587;
        Fri, 14 Jun 2019 14:36:14 -0400
Received: (from sramani@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x5EIaEvL017812;
        Fri, 14 Jun 2019 14:36:14 -0400
From:   Shravan Kumar Ramani <sramani@mellanox.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     Shravan Kumar Ramani <sramani@mellanox.com>,
        Liming Sun <lsun@mellanox.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] EDAC, mellanox: Add ECC support for BlueField DDR4
Date:   Fri, 14 Jun 2019 14:35:53 -0400
Message-Id: <f320d7926e2a87449c99ca43e8ac2ff52996a6c0.1560536708.git.sramani@mellanox.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <cover.1560536708.git.sramani@mellanox.com>
References: <cover.1560536708.git.sramani@mellanox.com>
In-Reply-To: <cover.1560536708.git.sramani@mellanox.com>
References: <cover.1560536708.git.sramani@mellanox.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add ECC support for Mellanox BlueField SoC DDR controller.
This requires SMC to the running Arm Trusted Firmware to report
what is the current memory configuration.

Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
---
 MAINTAINERS                   |   5 +
 drivers/edac/Kconfig          |   7 +
 drivers/edac/Makefile         |   1 +
 drivers/edac/bluefield_edac.c | 404 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 417 insertions(+)
 create mode 100644 drivers/edac/bluefield_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496c..9d04cc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5669,6 +5669,11 @@ S:	Supported
 F:	drivers/edac/aspeed_edac.c
 F:	Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
 
+EDAC-BLUEFIELD
+M:	Shravan Kumar Ramani <sramani@mellanox.com>
+S:	Supported
+F:	drivers/edac/bluefield_edac.c
+
 EDAC-CALXEDA
 M:	Robert Richter <rric@kernel.org>
 L:	linux-edac@vger.kernel.org
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 5e2e034..43df551 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -504,4 +504,11 @@ config EDAC_ASPEED
 	  First, ECC must be configured in the bootloader. Then, this driver
 	  will expose error counters via the EDAC kernel framework.
 
+config EDAC_BLUEFIELD
+	tristate "Mellanox BlueField Memory ECC"
+	depends on ARM64 && ((MELLANOX_PLATFORM && ACPI) || COMPILE_TEST)
+	help
+	  Support for error detection and correction on the
+	  Mellanox BlueField SoCs.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 89ad4a84..0294a67 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -84,3 +84,4 @@ obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
 obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
 obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
+obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
new file mode 100644
index 0000000..9c69033
--- /dev/null
+++ b/drivers/edac/bluefield_edac.c
@@ -0,0 +1,404 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Bluefield-specific EDAC driver.
+ *
+ * Copyright (c) 2019 Mellanox Technologies.
+ */
+
+#include <linux/acpi.h>
+#include <linux/arm-smccc.h>
+#include <linux/edac.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "edac_module.h"
+
+#define DRIVER_NAME		"bluefield-edac"
+
+/*
+ * Mellanox BlueField EMI (External Memory Interface) register definitions.
+ */
+
+#define MLXBF_EMI_DRAM_ECC_COUNT 0x340
+#define MLXBF_EMI_DRAM_ECC_COUNT__LENGTH 0x0001
+
+#define MLXBF_EMI_DRAM_ECC_COUNT__SINGLE_ERROR_COUNT_SHIFT 0
+#define MLXBF_EMI_DRAM_ECC_COUNT__SINGLE_ERROR_COUNT_RMASK 0xffff
+
+#define MLXBF_EMI_DRAM_ECC_COUNT__DOUBLE_ERROR_COUNT_SHIFT 16
+#define MLXBF_EMI_DRAM_ECC_COUNT__DOUBLE_ERROR_COUNT_RMASK 0xffff
+
+#define MLXBF_EMI_DRAM_ECC_ERROR 0x348
+
+#define MLXBF_EMI_DRAM_ECC_ERROR__DRAM_ECC_SINGLE_SHIFT 0
+#define MLXBF_EMI_DRAM_ECC_ERROR__DRAM_ECC_SINGLE_RMASK 0x1
+
+#define MLXBF_EMI_DRAM_ECC_ERROR__DRAM_ECC_DOUBLE_SHIFT 16
+#define MLXBF_EMI_DRAM_ECC_ERROR__DRAM_ECC_DOUBLE_RMASK 0x1
+
+#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT 0x354
+
+#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT__DRAM_ECC_FIRST_SHIFT 0
+#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT__DRAM_ECC_FIRST_RMASK 0x1
+
+#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT__EDGE_SEL_SHIFT 16
+#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT__EDGE_SEL_RMASK 0xf
+
+#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT__START_SHIFT 24
+#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT__START_RMASK 0x1
+
+#define MLXBF_EMI_DRAM_ERR_ADDR_0 0x358
+
+#define MLXBF_EMI_DRAM_ERR_ADDR_1 0x37c
+
+#define MLXBF_EMI_DRAM_SYNDROM 0x35c
+#define MLXBF_EMI_DRAM_SYNDROM__LENGTH 0x0001
+
+#define MLXBF_EMI_DRAM_SYNDROM__DERR_SHIFT 0
+#define MLXBF_EMI_DRAM_SYNDROM__DERR_RMASK 0x1
+
+#define MLXBF_EMI_DRAM_SYNDROM__SERR_SHIFT 1
+#define MLXBF_EMI_DRAM_SYNDROM__SERR_RMASK 0x1
+
+#define MLXBF_EMI_DRAM_SYNDROM__SYNDROM_SHIFT 16
+#define MLXBF_EMI_DRAM_SYNDROM__SYNDROM_RMASK 0x3ff
+
+#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0 0x364
+
+#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_BANK_SHIFT 0
+#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_BANK_RMASK 0xf
+
+#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_LRANK_SHIFT 4
+#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_LRANK_RMASK 0x3
+
+#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_PRANK_SHIFT 8
+#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_PRANK_RMASK 0x3
+
+#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_EDGE_SHIFT 16
+#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_EDGE_RMASK 0xff
+
+#define MLXBF_EDAC_MAX_DIMM_PER_MC	2
+#define MLXBF_EDAC_ERROR_GRAIN		8
+
+/*
+ * Request MLNX_SIP_GET_DIMM_INFO
+ *
+ * Retrieve information about DIMM on a certain slot.
+ *
+ * Call register usage:
+ * a0: MLNX_SIP_GET_DIMM_INFO
+ * a1: (Memory controller index) << 16 | (Dimm index in memory controller)
+ * a2-7: not used.
+ *
+ * Return status:
+ * a0: dimm_info_smc union defined below describing the DIMM.
+ * a1-3: not used.
+ */
+#define MLNX_SIP_GET_DIMM_INFO		0x82000008
+
+/* Format for the SMC response about the memory information */
+union dimm_info_smc {
+	struct {
+		unsigned long size_GB : 16;
+		unsigned long is_rdimm : 1;
+		unsigned long is_lrdimm : 1;
+		unsigned long is_nvdimm : 1;
+		unsigned long __reserved0 : 2;
+		unsigned long ranks : 3;
+		unsigned long package_X : 8;	/* Bits per memory package */
+		unsigned long __reserved1 : 32;
+	};
+	unsigned long val;
+};
+
+struct bluefield_edac_priv {
+	int dimm_ranks[MLXBF_EDAC_MAX_DIMM_PER_MC];
+	void __iomem *emi_base;
+	int dimm_per_mc;
+};
+
+static unsigned long smc_call1(unsigned long smc_op, unsigned long smc_arg)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(smc_op, smc_arg, 0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+/*
+ * Gather the ECC information from the External Memory Interface registers
+ * and report it to the edac handler.
+ */
+static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
+					int error_cnt,
+					int is_single_ecc)
+{
+	struct bluefield_edac_priv *priv = mci->pvt_info;
+	u32 dram_additional_info, err_prank;
+	u32 ecc_latch_select = 0, dram_syndrom = 0, serr, derr, syndrom;
+	enum hw_event_mc_err_type ecc_type;
+	unsigned long ecc_dimm_addr;
+	int ecc_dimm;
+	u32 edea0;
+	u32 edea1;
+
+	ecc_type = is_single_ecc ? HW_EVENT_ERR_CORRECTED :
+				   HW_EVENT_ERR_UNCORRECTED;
+
+	/*
+	 * Tell the External Memory Interface to populate the relevant
+	 * registers with information about the last ECC error occurrence.
+	 */
+	ecc_latch_select |= 1 << MLXBF_EMI_DRAM_ECC_LATCH_SELECT__START_SHIFT;
+	writel(ecc_latch_select,
+	       priv->emi_base + MLXBF_EMI_DRAM_ECC_LATCH_SELECT);
+
+	/*
+	 * Verify that the ECC reported info in the registers is of the
+	 * same type as the one asked to report. If not, just report the
+	 * error without the detailed information.
+	 */
+	dram_syndrom = readl(priv->emi_base + MLXBF_EMI_DRAM_SYNDROM);
+	serr = (dram_syndrom >> MLXBF_EMI_DRAM_SYNDROM__SERR_SHIFT) &
+		MLXBF_EMI_DRAM_SYNDROM__SERR_RMASK;
+	derr = (dram_syndrom >> MLXBF_EMI_DRAM_SYNDROM__DERR_SHIFT) &
+		MLXBF_EMI_DRAM_SYNDROM__DERR_RMASK;
+	syndrom = (dram_syndrom >> MLXBF_EMI_DRAM_SYNDROM__SYNDROM_SHIFT) &
+		   MLXBF_EMI_DRAM_SYNDROM__SYNDROM_RMASK;
+
+	if ((is_single_ecc && !serr) || (!is_single_ecc && !derr)) {
+		edac_mc_handle_error(ecc_type, mci, error_cnt, 0, 0, 0,
+				     0, 0, -1, mci->ctl_name, "");
+		return;
+	}
+
+	dram_additional_info = readl(priv->emi_base +
+				     MLXBF_EMI_DRAM_ADDITIONAL_INFO_0);
+	err_prank = (dram_additional_info >>
+		     MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_PRANK_SHIFT) &
+		     MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_PRANK_RMASK;
+
+	ecc_dimm = err_prank >= 2 && priv->dimm_ranks[0] <= 2;
+
+	edea0 = readl(priv->emi_base + MLXBF_EMI_DRAM_ERR_ADDR_0);
+	edea1 = readl(priv->emi_base + MLXBF_EMI_DRAM_ERR_ADDR_1);
+
+	ecc_dimm_addr = ((unsigned long)edea1 << 32) | edea0;
+
+	edac_mc_handle_error(ecc_type, mci, error_cnt,
+			     PFN_DOWN(ecc_dimm_addr), ecc_dimm_addr & PAGE_MASK,
+			     syndrom, ecc_dimm, 0, 0, mci->ctl_name, "");
+}
+
+static void bluefield_edac_check(struct mem_ctl_info *mci)
+{
+	struct bluefield_edac_priv *priv = mci->pvt_info;
+	u32 ecc_count, single_error_count, double_error_count, ecc_error = 0;
+
+	/*
+	 * The memory controller might not be initialized by the firmware
+	 * when there isn't memory, which may lead to bad register readings.
+	 */
+	if (mci->edac_cap == EDAC_FLAG_NONE)
+		return;
+
+	ecc_count = readl(priv->emi_base + MLXBF_EMI_DRAM_ECC_COUNT);
+	single_error_count =
+		(ecc_count >>
+		 MLXBF_EMI_DRAM_ECC_COUNT__SINGLE_ERROR_COUNT_SHIFT) &
+		 MLXBF_EMI_DRAM_ECC_COUNT__SINGLE_ERROR_COUNT_RMASK;
+	double_error_count =
+		(ecc_count >>
+		 MLXBF_EMI_DRAM_ECC_COUNT__DOUBLE_ERROR_COUNT_SHIFT) &
+		 MLXBF_EMI_DRAM_ECC_COUNT__DOUBLE_ERROR_COUNT_RMASK;
+
+	if (single_error_count) {
+		ecc_error |=
+			1 << MLXBF_EMI_DRAM_ECC_ERROR__DRAM_ECC_SINGLE_SHIFT;
+
+		bluefield_gather_report_ecc(mci, single_error_count, 1);
+	}
+
+	if (double_error_count) {
+		ecc_error |=
+			1 << MLXBF_EMI_DRAM_ECC_ERROR__DRAM_ECC_DOUBLE_SHIFT;
+
+		bluefield_gather_report_ecc(mci, double_error_count, 0);
+	}
+
+	/* Write to clear reported errors. */
+	if (ecc_count)
+		writel(ecc_error, priv->emi_base + MLXBF_EMI_DRAM_ECC_ERROR);
+}
+
+/* Initialize the DIMMs information for the given memory controller. */
+static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
+{
+	struct bluefield_edac_priv *priv = mci->pvt_info;
+	int mem_ctrl_idx = mci->mc_idx;
+	union dimm_info_smc smc_info;
+	struct dimm_info *dimm;
+	unsigned long smc_arg;
+	int is_empty = 1;
+	int i;
+
+	for (i = 0; i < priv->dimm_per_mc; i++) {
+		dimm = mci->dimms[i];
+
+		smc_arg = mem_ctrl_idx << 16 | i;
+		smc_info = (union dimm_info_smc) {
+			.val = smc_call1(MLNX_SIP_GET_DIMM_INFO, smc_arg),
+		};
+
+		if (!smc_info.size_GB) {
+			dimm->mtype = MEM_EMPTY;
+			continue;
+		}
+
+		is_empty = 0;
+
+		dimm->edac_mode = EDAC_SECDED;
+
+		if (smc_info.is_nvdimm)
+			dimm->mtype = MEM_NVDIMM;
+		else if (smc_info.is_lrdimm)
+			dimm->mtype = MEM_LRDDR4;
+		else if (smc_info.is_rdimm)
+			dimm->mtype = MEM_RDDR4;
+		else
+			dimm->mtype = MEM_DDR4;
+
+		dimm->nr_pages = smc_info.size_GB * (SZ_1G / PAGE_SIZE);
+		dimm->grain = MLXBF_EDAC_ERROR_GRAIN;
+
+		/* Mem controller for BlueField only supports x4, x8 and x16 */
+		if (smc_info.package_X == 4)
+			dimm->dtype = DEV_X4;
+		else if (smc_info.package_X == 8)
+			dimm->dtype = DEV_X8;
+		else if (smc_info.package_X == 16)
+			dimm->dtype = DEV_X16;
+		else
+			dimm->dtype = DEV_UNKNOWN;
+
+		priv->dimm_ranks[i] = smc_info.ranks;
+	}
+
+	if (is_empty)
+		mci->edac_cap = EDAC_FLAG_NONE;
+	else
+		mci->edac_cap = EDAC_FLAG_SECDED;
+}
+
+static int bluefield_edac_mc_probe(struct platform_device *pdev)
+{
+	struct bluefield_edac_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct edac_mc_layer layers[1];
+	struct mem_ctl_info *mci;
+	struct resource *emi_res;
+	unsigned int mc_idx, dimm_count;
+	int rc, ret;
+
+	/* Read the MSS (Memory SubSystem) index from ACPI table. */
+	if (device_property_read_u32(dev, "mss_number", &mc_idx)) {
+		dev_warn(dev, "bf_edac: MSS number unknown\n");
+		return -EINVAL;
+	}
+
+	/* Read the MSS (Memory SubSystem) index from ACPI table. */
+	if (device_property_read_u32(dev, "dimm_per_mc", &dimm_count)) {
+		dev_warn(dev, "bf_edac: DIMMs per MC unknown\n");
+		return -EINVAL;
+	}
+
+	emi_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!emi_res)
+		return -EINVAL;
+
+	layers[0].type = EDAC_MC_LAYER_SLOT;
+	layers[0].size = dimm_count;
+	layers[0].is_virt_csrow = true;
+
+	mci = edac_mc_alloc(mc_idx, ARRAY_SIZE(layers), layers, sizeof(*priv));
+	if (!mci)
+		return -ENOMEM;
+
+	priv = mci->pvt_info;
+
+	priv->dimm_per_mc = dimm_count;
+	priv->emi_base = devm_ioremap_resource(dev, emi_res);
+	if (IS_ERR(priv->emi_base)) {
+		dev_err(dev, "failed to map EMI IO resource\n");
+		ret = PTR_ERR(priv->emi_base);
+		goto err;
+	}
+
+	mci->pdev = dev;
+	mci->mtype_cap = MEM_FLAG_DDR4 | MEM_FLAG_RDDR4 |
+			 MEM_FLAG_LRDDR4 | MEM_FLAG_NVDIMM;
+	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
+
+	mci->mod_name = DRIVER_NAME;
+	mci->ctl_name = "BlueField_Memory_Controller";
+	mci->dev_name = dev_name(dev);
+	mci->edac_check = bluefield_edac_check;
+
+	/* Initialize mci with the actual populated DIMM information. */
+	bluefield_edac_init_dimms(mci);
+
+	platform_set_drvdata(pdev, mci);
+
+	/* Register with EDAC core */
+	rc = edac_mc_add_mc(mci);
+	if (rc) {
+		dev_err(dev, "failed to register with EDAC core\n");
+		ret = rc;
+		goto err;
+	}
+
+	/* Only POLL mode supported so far. */
+	edac_op_state = EDAC_OPSTATE_POLL;
+
+	return 0;
+
+err:
+	edac_mc_free(mci);
+
+	return ret;
+
+}
+
+static int bluefield_edac_mc_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+
+	return 0;
+}
+
+static const struct acpi_device_id bluefield_mc_acpi_ids[] = {
+	{"MLNXBF08", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(acpi, bluefield_mc_acpi_ids);
+
+static struct platform_driver bluefield_edac_mc_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.acpi_match_table = bluefield_mc_acpi_ids,
+	},
+	.probe = bluefield_edac_mc_probe,
+	.remove = bluefield_edac_mc_remove,
+};
+
+module_platform_driver(bluefield_edac_mc_driver);
+
+MODULE_DESCRIPTION("Mellanox BlueField memory edac driver");
+MODULE_AUTHOR("Mellanox Technologies");
+MODULE_LICENSE("GPL v2");
-- 
2.1.2

