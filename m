Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E2D5030D1
	for <lists+linux-edac@lfdr.de>; Sat, 16 Apr 2022 01:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244566AbiDOWgk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 Apr 2022 18:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiDOWgj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 15 Apr 2022 18:36:39 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574C4B89A0;
        Fri, 15 Apr 2022 15:34:08 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23FE3UFD010880;
        Fri, 15 Apr 2022 15:33:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=6cEafjj0YUBgPn4gfCxa6On2ckTp/2PcdL3tApyFEew=;
 b=fQhMeHfg3QNfS3l7VidMsjh3gR7G7LakvrLKXruuqic4y5/eJrkqJR92G2qTH2VyAryH
 RmmnDSR1njCF2z8eraWH6KgMD1WFIwfHpiafSqyZeoZjxts42B5+1497EVZtysiukG2d
 iDvYc9JxnztVHMjMMb4Ae4AEDLMnbLceBUHOJE+gbcUE3pF9dA2FeWmHOUeJU5j4I0H7
 WEGhkAF8BznZxVSRznLh32I98TPx7EFbWQJtmUjYaesveHSWIw4CzTZSfpo5TBUxQuA+
 sW14TpDRCKSpPVMa0I2nQw/bKw0z2TwiNQWPVMhpD2srcRdRYZYQFCiIlcRDb3x0o5Ek EA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3fdw7ekfm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 15:33:37 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 15 Apr
 2022 15:33:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Apr 2022 15:33:35 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 303E73F706F;
        Fri, 15 Apr 2022 15:33:35 -0700 (PDT)
From:   Vasyl Gomonovych <vgomonovych@marvell.com>
To:     <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <mchehab@kernel.org>, <rric@kernel.org>,
        <robert.moore@intel.com>, <rdunlap@infradead.org>,
        <ying.huang@intel.com>, <vgomonovych@marvell.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <devel@acpica.org>
Subject: [PATCH] EDAC: OcteonTX: Add EDAC driver OcteonTX2/Octeon10
Date:   Fri, 15 Apr 2022 15:33:21 -0700
Message-ID: <20220415223325.21953-1-vgomonovych@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 9382zXr2xYAd-342CIYJtmF4g-SNWKcw
X-Proofpoint-ORIG-GUID: 9382zXr2xYAd-342CIYJtmF4g-SNWKcw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-15_09,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Marvell OcteonTX2/Octeon10 (CN10K) SoCs have support for EDAC
capable on-chip peripherals, namely the DRAM controllers
and internal memory controllers for tad/cache diagnostics.
Platforms support correct one bit errors and detect two bit errors.
Driver get notified via SDEI after firmware first handling from TF-ARM
Return the apei_hest_parse function, which we use for error
source enumeration, and adapt the HEST error status
block address after being modified by firmware to satisfy
DRAM property and layout. Revert commit:
commit 06606646af97 ("ACPI: APEI: mark apei_hest_parse() static")

Signed-off-by: Vasyl Gomonovych <vgomonovych@marvell.com>
---
 drivers/acpi/apei/hest.c     |   5 +-
 drivers/edac/Kconfig         |  11 +
 drivers/edac/Makefile        |   1 +
 drivers/edac/octeontx_edac.c | 598 +++++++++++++++++++++++++++++++++++
 drivers/edac/octeontx_edac.h | 102 ++++++
 include/acpi/apei.h          |   3 +
 6 files changed, 717 insertions(+), 3 deletions(-)
 create mode 100644 drivers/edac/octeontx_edac.c
 create mode 100644 drivers/edac/octeontx_edac.h

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 6aef1ee5e1bd..317bba602ad5 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -86,9 +86,7 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
 	return len;
 };
 
-typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
-
-static int apei_hest_parse(apei_hest_func_t func, void *data)
+int apei_hest_parse(apei_hest_func_t func, void *data)
 {
 	struct acpi_hest_header *hest_hdr;
 	int i, rc, len;
@@ -123,6 +121,7 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(apei_hest_parse);
 
 /*
  * Check if firmware advertises firmware first mode. We need FF bit to be set
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 58ab63642e72..bb42d5227954 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -539,4 +539,15 @@ config EDAC_DMC520
 	  Support for error detection and correction on the
 	  SoCs with ARM DMC-520 DRAM controller.
 
+config EDAC_OCTEONTX
+	bool "Marvell OcteonTX2 Octeon10 SoC EDAC"
+	select ARM_SDE_INTERFACE
+	select ACPI_APEI_GHES
+	help
+	  Support for error detection and correction on the
+	  Marvell OcteonTX2 and Octeon10 (CN10K) SoCs.
+	  This driver will allow SECDED errors detected in
+	  the firmware first model and reported via SDEI callbacks.
+	  EDAC Driver report Single Bit Errors and Double Bit Errors.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 2d1641a27a28..dab4438a6c1a 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -84,3 +84,4 @@ obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
 obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
+obj-$(CONFIG_EDAC_OCTEONTX)		+= octeontx_edac.o
diff --git a/drivers/edac/octeontx_edac.c b/drivers/edac/octeontx_edac.c
new file mode 100644
index 000000000000..1b4c15931d3b
--- /dev/null
+++ b/drivers/edac/octeontx_edac.c
@@ -0,0 +1,598 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Marvell.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/of_address.h>
+#include <linux/arm_sdei.h>
+#include "edac_mc.h"
+#include "edac_device.h"
+#include "octeontx_edac.h"
+
+#define DRIVER_NAME	"octeontx-edac-ghes"
+
+#define otx_printk(level, fmt, arg...) edac_printk(level, DRIVER_NAME, fmt, ##arg)
+#define otx_debug(fmt, ...) pr_devel(DRIVER_NAME ":" fmt, __VA_ARGS__)
+
+static const struct of_device_id octeontx_edac_ghes_of_match[] = {
+	{ .compatible = "marvell,sdei-ghes", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, octeontx_edac_ghes_of_match);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id octeontx_edac_ghes_acpi_match[] = {
+	{ "MRVLECC1", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, octeontx_edac_ghes_acpi_match);
+#endif
+
+static const struct pci_device_id octeontx_edac_ghes_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_OCTEONTX2_LMC) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_OCTEONTX2_MCC) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_OCTEONTX2_MDC) },
+	{ 0, },
+};
+
+static int octeontx_mc_sdei_callback(u32 event_id, struct pt_regs *regs, void *arg)
+{
+	struct octeontx_edac_ghes *gsrc;
+
+	if (!arg) {
+		otx_printk(KERN_DEBUG, "%s null ghes", __func__);
+		return -EINVAL;
+	}
+
+	gsrc = arg;
+	schedule_work(&gsrc->mc_work);
+
+	return 0;
+}
+
+extern void cper_estatus_print(const char *pfx,
+		const struct acpi_hest_generic_status *estatus);
+
+static void octeontx_edac_mc_sdei_wq(struct work_struct *work)
+{
+	struct octeontx_edac_ghes_ring_record *ring;
+	struct octeontx_edac_mc_record rec;
+	enum hw_event_mc_err_type type;
+	struct mem_ctl_info *mci;
+	struct octeontx_edac_ghes *gsrc =
+			container_of(work, struct octeontx_edac_ghes, mc_work);
+	u32 head = gsrc->ring->head;
+	u32 tail = gsrc->ring->tail;
+
+	otx_printk(KERN_DEBUG, "%p, head=%d (%p), tail=%d (%p), size=%d, sign=%x\n",
+			gsrc->esb_va, head, &gsrc->ring->head, tail, &gsrc->ring->tail,
+			gsrc->ring->size, *(int *)((&gsrc->ring->size) + 1));
+
+	/*Ensure that head updated*/
+	rmb();
+
+	if (head == tail)
+		return;
+
+	ring = &gsrc->ring->records[tail];
+	mci = gsrc->mci;
+
+	gsrc->esb_va->estatus.error_severity = ring->error_severity;
+	gsrc->esb_va->estatus.block_status = 1;
+	gsrc->esb_va->gdata.error_severity = ring->error_severity;
+	memcpy_fromio(&rec, gsrc->esb_va, sizeof(rec) - sizeof(rec.cper_mem));
+	memcpy_fromio(&rec.gdata.fru_text, ring->fru_text, sizeof(rec.gdata.fru_text));
+	memcpy_fromio(&rec.cper_mem, &ring->u, sizeof(rec.cper_mem));
+
+	type = (ring->error_severity == CPER_SEV_CORRECTED) ?
+			HW_EVENT_ERR_CORRECTED : HW_EVENT_ERR_FATAL;
+
+	edac_mc_handle_error(type, mci, 1, PHYS_PFN(rec.cper_mem.physical_addr),
+			offset_in_page(rec.cper_mem.physical_addr),
+			0, -1, -1, -1, ring->fru_text, mci->ctl_name);
+
+	if (acpi_disabled) {
+		cper_estatus_print(HW_ERR, &rec.estatus);
+	} else {
+		memcpy_toio(gsrc->esb_va->gdata.fru_text, rec.gdata.fru_text,
+				sizeof(rec.gdata.fru_text));
+		memcpy_toio(&gsrc->esb_va->cper_mem, &rec.cper_mem, sizeof(rec.cper_mem));
+	}
+
+	if (++tail >= gsrc->ring->size)
+		tail = 0;
+	gsrc->ring->tail = tail;
+
+	/*Ensure that head updated*/
+	wmb();
+}
+
+static void octeontx_edac_enable_msix(struct pci_dev *pdev)
+{
+	u16 ctrl;
+
+	if ((pdev->msi_enabled) || (pdev->msix_enabled)) {
+		dev_err(&pdev->dev, "MSI(%d) or MSIX(%d) already enabled\n",
+			pdev->msi_enabled, pdev->msix_enabled);
+		return;
+	}
+
+	pdev->msix_cap = pci_find_capability(pdev, PCI_CAP_ID_MSIX);
+	if (pdev->msix_cap) {
+		pci_read_config_word(pdev, pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+		ctrl |= PCI_MSIX_FLAGS_ENABLE;
+		pci_write_config_word(pdev, pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+
+		otx_printk(KERN_DEBUG, "Set MSI-X Enable for PCI dev %04d:%02d.%d\n",
+			pdev->bus->number, PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+	} else {
+		dev_err(&pdev->dev, "PCI dev %04d:%02d.%d missing MSIX capabilities\n",
+			pdev->bus->number, PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+	}
+}
+
+static void octeontx_edac_msix_init(void)
+{
+	const struct pci_device_id *pdevid;
+	struct pci_dev *pdev;
+	size_t i;
+
+	if (MIDR_PARTNUM(read_cpuid_id()) == OCTEON10_CPU_MODEL)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(octeontx_edac_ghes_pci_tbl); i++) {
+		pdevid = &octeontx_edac_ghes_pci_tbl[i];
+		pdev = NULL;
+		while ((pdev = pci_get_device(pdevid->vendor, pdevid->device, pdev)))
+			octeontx_edac_enable_msix(pdev);
+	}
+}
+
+static void octeontx_edac_ghes_driver_init(struct platform_device *pdev)
+{
+	struct octeontx_edac_driver *ghes_drv;
+	struct octeontx_edac_ghes *gsrc;
+	struct device *dev = &pdev->dev;
+	size_t i = 0;
+	int ret = 0;
+
+	ghes_drv = platform_get_drvdata(pdev);
+
+	for (i = 0; i < ghes_drv->source_count; i++) {
+		gsrc = &ghes_drv->source_list[i];
+
+		ret = sdei_event_register(gsrc->id, octeontx_mc_sdei_callback, gsrc);
+		if (ret < 0) {
+			dev_err(dev, "Error %d registering ghes 0x%x (%s)\n",
+				ret, gsrc->id, gsrc->name);
+			continue;
+		}
+
+		ret = sdei_event_enable(gsrc->id);
+		if (ret < 0) {
+			dev_err(dev, "Error %d enabling ghes 0x%x (%s)\n",
+				ret, gsrc->id, gsrc->name);
+			continue;
+		}
+		gsrc->ring->reg = OCTEONTX_GHES_ERR_RING_SIG;
+
+		otx_debug("Register 0x%x (%s) %s [%p, %p, %p]\n", gsrc->id,
+			gsrc->name, "reg", gsrc->esa_va, gsrc->esb_va, gsrc->ring);
+	}
+}
+
+static int octentx_edac_ghes_driver_deinit(struct platform_device *pdev)
+{
+	struct octeontx_edac_driver *ghes_drv;
+	struct device *dev = &pdev->dev;
+	struct octeontx_edac_ghes *gsrc;
+	int ret, i;
+
+	ghes_drv = platform_get_drvdata(pdev);
+
+	for (i = 0; i < ghes_drv->source_count; i++) {
+		gsrc = &ghes_drv->source_list[i];
+
+		gsrc->ring->reg = 0;
+
+		ret = sdei_event_disable(gsrc->id);
+		if (ret < 0)
+			dev_err(dev, "Error %d disabling SDEI gsrc 0x%x (%s)\n",
+				ret, gsrc->id, gsrc->name);
+
+		ret = sdei_event_unregister(gsrc->id);
+		if (ret < 0)
+			dev_err(dev, "Error %d unregistering SDEI gsrc 0x%x (%s)\n",
+				ret, gsrc->id, gsrc->name);
+
+		if (gsrc->mci) {
+			edac_mc_del_mc(&gsrc->dev);
+			edac_mc_free(gsrc->mci);
+			put_device(&gsrc->dev);
+		}
+	}
+
+	return 0;
+}
+
+static int __init octeontx_edac_ghes_of_match_resource(struct platform_device *pdev)
+{
+	struct device_node *of_node;
+	struct device_node *child_node;
+	struct octeontx_edac_driver *ghes_drv;
+	struct octeontx_edac_ghes *gsrc;
+	struct device *dev;
+	const __be32 *res;
+	u64 size;
+	u64 base;
+	const u32 *id;
+	int i = 0;
+
+	dev = &pdev->dev;
+	ghes_drv = platform_get_drvdata(pdev);
+	of_node = of_find_matching_node(NULL, octeontx_edac_ghes_of_match);
+	if (!of_node)
+		return -ENODEV;
+
+	for_each_available_child_of_node(of_node, child_node) {
+		gsrc = &ghes_drv->source_list[i++];
+
+		strncpy(gsrc->name, child_node->name, sizeof(gsrc->name) - 1);
+
+		res = of_get_address(child_node, 0, NULL, NULL);
+		base = of_translate_address(child_node, res);
+		if (base == OF_BAD_ADDR) {
+			dev_err(dev, "ghes cannot map esa addr\n");
+			return -EINVAL;
+		}
+		gsrc->esa_pa = (phys_addr_t)base;
+
+		res = of_get_address(child_node, 1, &size, NULL);
+		base = of_translate_address(child_node, res);
+		if (base == OF_BAD_ADDR) {
+			dev_err(dev, "ghes cannot map esb addr\n");
+			return -EINVAL;
+		}
+		gsrc->esb_pa = (phys_addr_t)base;
+		gsrc->esb_sz = (size_t)size;
+
+		res = of_get_address(child_node, 2, &size, NULL);
+		base = of_translate_address(child_node, res);
+		if (base == OF_BAD_ADDR) {
+			dev_err(dev, "ghes cannot map ring addr\n");
+			return -EINVAL;
+		}
+		gsrc->ring_pa = (phys_addr_t)base;
+		gsrc->ring_sz = (size_t)size;
+
+		id = of_get_property(child_node, "event-id", NULL);
+		if (!id) {
+			dev_err(dev, "ghes cannot get sdei event\n");
+			return -EINVAL;
+		}
+		gsrc->id = be32_to_cpu(*id);
+
+		otx_debug("%s 0x%llx/0x%llx/0x%llx, ID:0x%x)\n", gsrc->name,
+				gsrc->esa_pa, gsrc->esb_pa, gsrc->ring_pa, gsrc->id);
+	}
+
+	return 0;
+}
+
+static int __init hest_estatus_address(struct acpi_hest_header *hest_hdr, void *data)
+{
+	struct acpi_hest_generic *generic = (struct acpi_hest_generic *)hest_hdr;
+	u64 *esrc = data;
+	static int i;
+
+	esrc[i] = generic->error_status_address.address;
+	i++;
+
+	return 0;
+}
+
+static phys_addr_t __init octeontx_edac_ghes_get_address(struct octeontx_edac_driver *ghes_drv)
+{
+	int i = 0;
+	u64 *esrc = NULL;
+	phys_addr_t ret = ~0ULL;
+
+	esrc = kcalloc(ghes_drv->source_count, sizeof(u64 *), GFP_KERNEL);
+	if (!esrc)
+		return 0;
+
+	apei_hest_parse(hest_estatus_address, esrc);
+
+	for (i = 0; i < ghes_drv->source_count; i++)
+		ret = ret > esrc[i] ? esrc[i] : ret;
+
+	kfree(esrc);
+
+	return ret;
+}
+
+static int __init octeontx_edac_ghes_acpi_match_resource(struct platform_device *pdev)
+{
+	struct octeontx_edac_driver *ghes_drv;
+	struct octeontx_edac_ghes *gsrc;
+	struct resource *res;
+	struct device *dev;
+	size_t i = 0;
+	size_t idx = 0;
+	phys_addr_t base = 0;
+	bool octeon10 = (MIDR_PARTNUM(read_cpuid_id()) == OCTEON10_CPU_MODEL);
+
+	dev = &pdev->dev;
+	ghes_drv = platform_get_drvdata(pdev);
+
+	base = octeontx_edac_ghes_get_address(ghes_drv);
+	if (!base)
+		return -EINVAL;
+
+	for (i = 0; i < ghes_drv->source_count; i++) {
+		gsrc = &ghes_drv->source_list[i];
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, idx++);
+		if (!res) {
+			dev_err(dev, "ghes cannot map esa addr\n");
+			return -ENODEV;
+		}
+		gsrc->esa_pa = res->start + base;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, idx++);
+		if (!res) {
+			dev_err(dev, "ghes cannot map esb addr\n");
+			return -ENODEV;
+		}
+		gsrc->esb_pa = res->start + base;
+		gsrc->esb_sz = resource_size(res);
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, idx++);
+		if (!res) {
+			dev_err(dev, "ghes cannot map ring addr\n");
+			return -ENODEV;
+		}
+		gsrc->ring_pa = res->start + base;
+		gsrc->ring_sz = resource_size(res);
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, idx++);
+		if (!res) {
+			dev_err(dev, "ghes cannot get event\n");
+			return -ENODEV;
+		}
+		gsrc->id = res->start;
+
+		if (gsrc->id == OCTEONTX_RAS_MDC_SDEI_EVENT)
+			sprintf(gsrc->name, "mdc");
+		else if (gsrc->id == OCTEONTX_RAS_MCC_SDEI_EVENT)
+			sprintf(gsrc->name, octeon10 ? "dss" : "mcc");
+		else if (gsrc->id == OCTEONTX_RAS_LMC_SDEI_EVENT)
+			sprintf(gsrc->name, octeon10 ? "tad" : "lmc");
+
+		otx_debug("ghes 0x%llx / 0x%llx / 0x%llx, sdei:0x%x)\n",
+				gsrc->esa_pa, gsrc->esb_pa, gsrc->ring_pa, gsrc->id);
+	}
+
+	return 0;
+}
+
+static int octeontx_edac_ghes_setup_resource(struct octeontx_edac_driver *ghes_drv)
+{
+	struct octeontx_edac_ghes *gsrc;
+	struct device *dev = ghes_drv->dev;
+	size_t i = 0;
+
+	for (i = 0; i < ghes_drv->source_count; i++) {
+		gsrc = &ghes_drv->source_list[i];
+
+		if (!devm_request_mem_region(dev, gsrc->esa_pa, sizeof(gsrc->esa_va), gsrc->name))
+			return -EBUSY;
+		gsrc->esa_va = devm_ioremap(dev, gsrc->esa_pa, sizeof(gsrc->esa_va));
+		if (!gsrc->esa_va)
+			return -ENOMEM;
+
+		if (has_acpi_companion(dev)) {
+			*gsrc->esa_va = gsrc->esb_pa;
+			devm_iounmap(ghes_drv->dev, gsrc->esa_va);
+			devm_release_mem_region(ghes_drv->dev, gsrc->esa_pa, sizeof(gsrc->esa_va));
+			acpi_os_map_iomem(gsrc->esa_pa, sizeof(gsrc->esa_pa));
+		}
+
+		if (!devm_request_mem_region(dev, gsrc->esb_pa, gsrc->esb_sz, gsrc->name))
+			return -EBUSY;
+		gsrc->esb_va = devm_ioremap(dev, gsrc->esb_pa, gsrc->esb_sz);
+		if (!gsrc->esb_va)
+			return -ENOMEM;
+
+		if (!devm_request_mem_region(dev, gsrc->ring_pa, gsrc->ring_sz, gsrc->name))
+			return -EBUSY;
+		gsrc->ring = devm_ioremap(dev, gsrc->ring_pa, gsrc->ring_sz);
+		if (!gsrc->ring)
+			return -ENOMEM;
+
+		otx_debug("%s %s-%x %p/%p/%p\n", __func__, gsrc->name, gsrc->id,
+			gsrc->esa_va, gsrc->esb_va, gsrc->ring);
+	}
+
+	return 0;
+}
+
+static int hest_count_ghes(struct acpi_hest_header *hest_hdr, void *data)
+{
+	int *count = data;
+
+	if (hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR ||
+		hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2)
+		(*count)++;
+
+	return 0;
+}
+
+static size_t octeontx_edac_ghes_count(struct octeontx_edac_driver *ghes_drv)
+{
+	size_t count;
+	struct device_node *of_node;
+	struct device_node *child_node;
+	struct device *dev = ghes_drv->dev;
+
+	count = 0;
+	of_node = of_find_matching_node(NULL, octeontx_edac_ghes_of_match);
+
+	if (of_node) {
+		for_each_available_child_of_node(of_node, child_node)
+			count++;
+	} else if (has_acpi_companion(dev)) {
+		count = 0;
+		apei_hest_parse(hest_count_ghes, &count);
+	}
+
+	return count;
+}
+
+static int octeontx_edac_ghes_register_mc(struct octeontx_edac_driver *ghes_drv)
+{
+	struct mem_ctl_info *mci;
+	struct edac_mc_layer layers[1];
+	struct octeontx_edac_ghes *gsrc;
+	int idx = 0;
+	int i = 0;
+	int ret = 0;
+
+	for (i = 0; i < ghes_drv->source_count; i++) {
+		gsrc = &ghes_drv->source_list[i];
+
+		if (IS_NOT_MC_SDEI_EVENT(gsrc->id))
+			continue;
+
+		idx = edac_device_alloc_index();
+
+		device_initialize(&gsrc->dev);
+		dev_set_name(&gsrc->dev, gsrc->name);
+		ret = device_add(&gsrc->dev);
+		if (ret < 0) {
+			dev_err(&gsrc->dev, "add device %s\n", dev_name(&gsrc->dev));
+			put_device(&gsrc->dev);
+			return ret;
+		}
+
+		layers[0].type = EDAC_MC_LAYER_ALL_MEM;
+		layers[0].size = 1;
+		layers[0].is_virt_csrow = false;
+
+		mci = edac_mc_alloc(idx, ARRAY_SIZE(layers), layers, 0);
+		if (!mci)
+			return -ENOMEM;
+
+		mci->pdev = &gsrc->dev;
+		mci->dev_name = dev_name(&gsrc->dev);
+		mci->edac_ctl_cap = EDAC_FLAG_SECDED;
+		mci->mod_name = DRIVER_NAME;
+		mci->ctl_name = gsrc->name;
+		mci->edac_check = NULL;
+		mci->pvt_info = gsrc;
+		INIT_WORK(&gsrc->mc_work, octeontx_edac_mc_sdei_wq);
+
+		ret = edac_mc_add_mc_with_groups(mci, NULL);
+		if (ret) {
+			edac_mc_del_mc(&gsrc->dev);
+			put_device(&gsrc->dev);
+			return ret;
+		}
+
+		gsrc->mci = mci;
+	}
+
+	return 0;
+}
+
+static int __init octeontx_edac_ghes_probe(struct platform_device *pdev)
+{
+	struct octeontx_edac_driver *ghes_drv = NULL;
+	struct device *dev = &pdev->dev;
+	int ret = -ENODEV;
+
+	ghes_drv = devm_kzalloc(dev, sizeof(struct octeontx_edac_driver), GFP_KERNEL);
+	if (!ghes_drv)
+		return -ENOMEM;
+
+	ghes_drv->dev = dev;
+
+	ghes_drv->source_count = octeontx_edac_ghes_count(ghes_drv);
+	if (!ghes_drv->source_count) {
+		dev_err(dev, "Not available ghes.\n");
+		return -EINVAL;
+	}
+	otx_printk(KERN_DEBUG, "%s source count %ld\n", __func__, ghes_drv->source_count);
+
+	ghes_drv->source_list = devm_kcalloc(dev, ghes_drv->source_count,
+			sizeof(struct octeontx_edac_ghes), GFP_KERNEL);
+	if (!ghes_drv->source_list)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ghes_drv);
+
+	if (has_acpi_companion(dev)) {
+		acpi_match_device(dev->driver->acpi_match_table, dev);
+		ret = octeontx_edac_ghes_acpi_match_resource(pdev);
+	} else {
+		acpi_permanent_mmap = true;
+		set_bit(EFI_MEMMAP, &efi.flags);
+		ret = octeontx_edac_ghes_of_match_resource(pdev);
+	}
+	if (ret < 0) {
+		dev_err(dev, "Failed match resources\n");
+		goto exit0;
+	}
+
+	ret = octeontx_edac_ghes_setup_resource(ghes_drv);
+	if (ret)
+		goto exit0;
+
+	octeontx_edac_msix_init();
+
+	octeontx_edac_ghes_driver_init(pdev);
+
+	ret = octeontx_edac_ghes_register_mc(ghes_drv);
+	if (ret)
+		goto exit0;
+
+	return 0;
+
+exit0:
+	dev_err(dev, "Error edac probe\n");
+
+	return ret;
+}
+
+static int octeontx_edac_ghes_remove(struct platform_device *pdev)
+{
+	octentx_edac_ghes_driver_deinit(pdev);
+
+	return 0;
+}
+
+static const struct platform_device_id octeontx_edac_ghes_pdev_match[] = {
+	{ .name = DRIVER_NAME, },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, octeontx_edac_ghes_pdev_match);
+
+static struct platform_driver octeontx_edac_ghes_drv_probe = {
+	.driver = {
+		.name             = DRIVER_NAME,
+		.of_match_table   = of_match_ptr(octeontx_edac_ghes_of_match),
+		.acpi_match_table = ACPI_PTR(octeontx_edac_ghes_acpi_match),
+	},
+	.probe    = octeontx_edac_ghes_probe,
+	.remove   = octeontx_edac_ghes_remove,
+	.id_table = octeontx_edac_ghes_pdev_match,
+};
+module_platform_driver(octeontx_edac_ghes_drv_probe);
+
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_DESCRIPTION("OcteonTX2 / CN10K EDAC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/edac/octeontx_edac.h b/drivers/edac/octeontx_edac.h
new file mode 100644
index 000000000000..f79c182ff0f8
--- /dev/null
+++ b/drivers/edac/octeontx_edac.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2022 Marvell.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __OCTEONTX_EDAC_H__
+#define __OCTEONTX_EDAC_H__
+
+#define OCTEON10_CPU_MODEL		(0xd49)
+#define PCI_DEVICE_ID_OCTEONTX2_LMC	(0xa022)
+#define PCI_DEVICE_ID_OCTEONTX2_MCC	(0xa070)
+#define PCI_DEVICE_ID_OCTEONTX2_MDC	(0xa073)
+
+#define OCTEONTX_RAS_MDC_SDEI_EVENT	(0x40000000)
+#define OCTEONTX_RAS_MCC_SDEI_EVENT	(0x40000001)
+#define OCTEONTX_RAS_LMC_SDEI_EVENT	(0x40000002)
+#define OCTEONTX_RAS_DSS_SDEI_EVENT	(0x40000001)
+#define OCTEONTX_RAS_TAD_SDEI_EVENT	(0x40000002)
+
+#define OCTEONTX_GHES_NAME_MAX_LEN 16
+#define OCTEONTX_GHES_FRU_TEXT_LEN 32
+
+#define OCTEONTX_GHES_ERR_RING_SIG ((int)'M' << 24 | 'R' << 16 | 'V' << 8 | 'L')
+
+#define IS_NOT_MC_SDEI_EVENT(id) ((id != OCTEONTX_RAS_MDC_SDEI_EVENT) && \
+	(id != OCTEONTX_RAS_MCC_SDEI_EVENT) && \
+	(id != OCTEONTX_RAS_LMC_SDEI_EVENT))
+
+struct octeontx_edac_mc_record {
+	struct acpi_hest_generic_status estatus;
+	struct acpi_hest_generic_data   gdata;
+	struct cper_sec_mem_err         cper_mem;
+};
+
+/*
+ * Describes an error source per ACPI (Generic Hardware Error Source).
+ * This produces GHES-compliant error records from data forwarded by the [ATF]
+ * firmware.
+ * There exists one of these for each error source.
+ *
+ * @name:               ghes source name
+ * @id:                 sdei event id
+ * @esa_pa              physical address of Error Status Address register/iomem
+ * @esb_pa:             phys address of Error Status Block follow Error Status Data
+ * @ring_pa:            physical address of Ring of Error Status Blocks
+ * @esa_va:             mapped to Error Status Address point on Error Status Block
+ * @esb_va:             mapped to Error Status Block
+ * @ring:               mapped to Ring of Error Status Blocks
+ * @ring_sz:            ring size
+ * @esb_sz:             esb size
+ * @dev:                memory controller owner device
+ * @mci                 corresponding memory controller
+ * @mc_work             worker for sdei callback
+ */
+struct octeontx_edac_ghes {
+	char                            name[OCTEONTX_GHES_NAME_MAX_LEN];
+	u32                             id;
+	phys_addr_t                     esa_pa;
+	phys_addr_t                     esb_pa;
+	phys_addr_t                     ring_pa;
+	phys_addr_t                     *esa_va;
+	struct octeontx_edac_mc_record     *esb_va;
+	struct octeontx_edac_ghes_ring  *ring;
+	size_t                          ring_sz;
+	size_t                          esb_sz;
+	struct device                   dev;
+	struct mem_ctl_info             *mci;
+	struct work_struct              mc_work;
+};
+
+struct octeontx_edac_driver {
+	struct device             *dev;
+	struct octeontx_edac_ghes *source_list;
+	size_t                    source_count;
+};
+
+struct octeontx_edac_ghes_ring_record {
+	union {
+		struct cper_sec_mem_err mcc;
+		struct cper_sec_mem_err mdc;
+		struct cper_sec_mem_err lmc;
+		struct cper_sec_mem_err tad;
+		struct cper_sec_mem_err dss;
+	} u;
+	uint32_t error_severity;
+	char fru_text[OCTEONTX_GHES_FRU_TEXT_LEN];
+};
+
+struct octeontx_edac_ghes_ring {
+	uint32_t head;
+	uint32_t tail;
+	uint32_t size;
+	uint32_t sig;
+	uint32_t reg;
+	struct octeontx_edac_ghes_ring_record records[0] __aligned(8);
+};
+
+#endif // __OCTEONTX_EDAC_H__
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index afaca3a075e8..4be95ef425c0 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -39,6 +39,9 @@ void __init acpi_hest_init(void);
 static inline void acpi_hest_init(void) { }
 #endif
 
+typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
+int apei_hest_parse(apei_hest_func_t func, void *data);
+
 int erst_write(const struct cper_record_header *record);
 ssize_t erst_get_record_count(void);
 int erst_get_record_id_begin(int *pos);
-- 
2.17.1

