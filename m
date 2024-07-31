Return-Path: <linux-edac+bounces-1598-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F88D942D13
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jul 2024 13:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F961C22017
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jul 2024 11:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677411AC433;
	Wed, 31 Jul 2024 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="f7wpcpM6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1AB1A4B34;
	Wed, 31 Jul 2024 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424747; cv=none; b=ON0Dh6FCLQ5y3QQweGL++eCeq2Gy+Ol/vSZp2F3Rx7/AITLx7/c1jqpL9ixW2ina0IYvEcun772URlPrnzr/pt20ch9GMkbS30us5W2QubESNLsJY/gslVa5hqwKVgU8UWKQORevKrEgRNMkiCDgvZlJXVNihykICHE0Lo/+KuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424747; c=relaxed/simple;
	bh=NnJqoMWBO42GjKssuAvj0DZ8MzwvkXONp4bw/7xqhSI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DqfW4nchmCSo7rr2iPtke/bwGhd1OD6Hvndj9R0+iyn3e0eZv863RiYpK8GYDHWJPh6B9UN+GlrGNZBPPusUJkyNJZkqZGf49mnRe7PuR+Ald7HvQyvv63rWXUHK9NAEZa2IB2Jbtjy2eNFvS7knigrztlWFBmBYmQPNRE28Noc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=f7wpcpM6; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V4fQKR026781;
	Wed, 31 Jul 2024 04:18:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Tv48nC3h7jHqsEzYH5qynMn
	mKNnHNV7fO5VvH3mggBo=; b=f7wpcpM6BhCtQDD7BtOjdcj2zDEpBTkP2tlenBc
	7+AJAvF7iV2U0cpUlcvOdyWL/QpGLJ6q5tVL8NUlPNyczMeukq0aceoywZGlX7Zn
	ZMUQy6KS3ITWLHNDx+KGS5WY4vSvw6hGv3nwZDcYRkrRUDDFjK/0IozYS4fUA4ZQ
	SgS7BsPbTR9DFSUHaK8gfhrmCSZfXWcNKP3fblfeaN4WolT65IaQryCaw+GJpouA
	6mZfB0X8V3riyqy+Yagcoq8DRk+ip7VEeyXTGt7sN6smJlgUuf1YbQQgMtowj3gB
	ipqGBH/lTWmOt9wNGV3H2mYvM+QtWyN1jiETS4DyZgSNlpA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40qeeusfk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 04:18:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 31 Jul 2024 04:18:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 31 Jul 2024 04:18:16 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 7F82D5E6869;
	Wed, 31 Jul 2024 04:18:16 -0700 (PDT)
From: Vasyl Gomonovych <vgomonovych@marvell.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <mchehab@kernel.org>, <rric@kernel.org>, <sgoutham@marvell.com>
CC: Vasyl Gomonovych <vgomonovych@marvell.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH] Add EDAC Driver for Marvell OcteonTX2/CN10K SoCs
Date: Wed, 31 Jul 2024 04:17:40 -0700
Message-ID: <20240731111800.2253740-1-vgomonovych@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: U1u6CK_dLbJPcJCUBIUum01f7UxFbwbG
X-Proofpoint-ORIG-GUID: U1u6CK_dLbJPcJCUBIUum01f7UxFbwbG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-30_01,2024-05-17_01

This commit introduces an Error Detection and Correction (EDAC)
driver for Marvell OcteonTX2 and CN10K System on Chips (SoCs).
The driver supports the firmware-first model and
handles error notifications via the
Software Delegated Exception Interface (SDEI).
It also provides error injection capabilities
through System Management Calls (SMC).

Key Features:
 - Support for EDAC-capable on-chip peripherals.
 - Integration with the SDEI for error notification.
 - Error injection via SMC calls.
 - Detailed error reporting and logging.

Signed-off-by: Vasyl Gomonovych <vgomonovych@marvell.com>
---
 drivers/edac/Kconfig         |   10 +
 drivers/edac/Makefile        |    1 +
 drivers/edac/octeontx_edac.c | 1274 ++++++++++++++++++++++++++++++++++
 3 files changed, 1285 insertions(+)
 create mode 100644 drivers/edac/octeontx_edac.c

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 16c8de5050e5..0bbe0d65ee16 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -573,5 +573,15 @@ config EDAC_VERSAL
 	  Support injecting both correctable and uncorrectable errors
 	  for debugging purposes.
 
+config EDAC_OCTEONTX
+	bool "Marvell OcteonTX2 and CN10K SoC EDAC"
+	depends on ARM_SDE_INTERFACE
+	help
+	  Support for error detection and correction on the
+	  Marvell OcteonTX2 and CN10K SoCs.
+	  This driver will allow SECDED errors notify and report in
+	  the firmware first model and reported via SDEI callbacks.
+	  EDAC Driver report Single Bit Errors and Double Bit Errors.
+
 
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 4edfb83ffbee..07dbb6558b6f 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -89,3 +89,4 @@ obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
 obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
 obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
 obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
+obj-$(CONFIG_EDAC_OCTEONTX)		+= octeontx_edac.o
diff --git a/drivers/edac/octeontx_edac.c b/drivers/edac/octeontx_edac.c
new file mode 100644
index 000000000000..3d91b16cbdf2
--- /dev/null
+++ b/drivers/edac/octeontx_edac.c
@@ -0,0 +1,1274 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell OcteonTx2, CN10K EDAC Firmware First RAS driver
+ * The driver supports SDE Interface notification
+ * The driver supports error injection via SMC call
+ *
+ * Copyright (C) 2022 Marvell.
+ */
+
+#include <linux/of_address.h>
+#include <linux/arm_sdei.h>
+#include <linux/arm-smccc.h>
+#include <linux/sys_soc.h>
+#include <linux/cper.h>
+#include "edac_module.h"
+
+#define OCTEONTX2_RING_SIG ((int)'M' << 24 | 'R' << 16 | 'V' << 8 | 'L')
+
+#define PCI_DEVICE_ID_OCTEONTX2_LMC	(0xa022)
+#define PCI_DEVICE_ID_OCTEONTX2_MCC	(0xa070)
+#define PCI_DEVICE_ID_OCTEONTX2_MDC	(0xa073)
+
+#define OCTEONTX2_EDAC_INJECT	(0xc2000c0b)
+#define OCTEONTX2_MDC_EINJ_CAP	(0x10000000)
+#define OCTEONTX2_MCC_EINJ_CAP	(0x40000000)
+
+#define CN10K_EDAC_INJECT	(0xc2000b10)
+#define CN10K_DSS_EINJ_CAP	(0x20000000)
+
+#define SIZE	CPER_REC_LEN
+#define NAME_SZ	8
+
+struct cper_sec_plat_gic {
+	uint8_t validation_bits;
+	uint8_t error_type;
+	uint8_t error_sev;
+	uint8_t reserved0;
+	uint32_t error_code;
+	uint64_t misc0;
+	uint64_t misc1;
+	uint64_t erraddr;
+};
+
+struct cper_sec_platform_err {
+	struct cper_sec_fw_err_rec_ref fwrec;
+	uint32_t module_id;
+	uint32_t reserved0;
+	union {
+		struct cper_sec_plat_gic gic;
+	} perr;
+};
+
+struct processor_error {
+	struct cper_sec_proc_arm desc;
+	struct cper_arm_err_info info;
+};
+
+/* OcteonTX Reporting Error Source Record */
+struct octeontx_res_record {
+	union {
+		struct processor_error  core;
+		struct cper_sec_mem_err mem;
+		struct cper_sec_platform_err gic;
+	};
+	u32 error_severity;
+	char msg[32];
+	u64 syndrome;
+};
+
+/* Reporting Error Source Ring Buffer */
+struct octeontx_res_ring {
+	u32 head;
+	u32 tail;
+	u32 size;
+	u32 sig;
+	u32 reg;
+	struct octeontx_res_record records[0] __aligned(8);
+};
+
+struct octeontx_edac {
+	union {
+		struct mem_ctl_info *mci;
+		struct edac_device_ctl_info *edac_dev;
+	};
+	phys_addr_t ring_pa;
+	struct octeontx_res_ring __iomem *ring;
+	size_t ring_sz;
+	u32 sdei_num;
+	u32 ecc_cap;
+	struct mutex lock;
+	char name[NAME_SZ];
+	struct delayed_work work;
+};
+
+/* List of Hardware Error Sources */
+struct octeontx_res_list {
+	struct octeontx_edac *hes;
+	u32 count;
+};
+
+struct octeontx_edac_pvt {
+	unsigned long inject;
+	unsigned long error_type;
+	unsigned long address;
+	struct octeontx_edac *hes;
+};
+
+static const struct soc_device_attribute cn10_socinfo[] = {
+	{.soc_id = "jep106:0369:00b9", .revision = "0x00000000",},
+	{.soc_id = "jep106:0369:00b9", .revision = "0x00000001",},
+	{.soc_id = "jep106:0369:00b9", .revision = "0x00000008",},
+	{.soc_id = "jep106:0369:00bd",},
+	{.soc_id = "jep106:0369:00ba", .revision = "0x00000000",},
+	{.soc_id = "jep106:0369:00ba", .revision = "0x00000001",},
+	{.soc_id = "jep106:0369:00bc", .revision = "0x00000000",},
+	{.soc_id = "jep106:0369:00bc", .revision = "0x00000008",},
+	{},
+};
+
+static const struct of_device_id octeontx_edac_of_match[] = {
+	{.compatible = "marvell,sdei-ghes",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeontx_edac_of_match);
+
+static const struct of_device_id tad_of_match[] = {
+	{.name = "tad",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, tad_of_match);
+
+static const struct of_device_id dss_of_match[] = {
+	{.name = "dss",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, dss_of_match);
+
+static const struct of_device_id mdc_of_match[] = {
+	{.name = "mdc",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mdc_of_match);
+
+static const struct of_device_id mcc_of_match[] = {
+	{.name = "mcc",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mcc_of_match);
+
+static const struct of_device_id cpu_of_match[] = {
+	{.name = "core",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, cpu_of_match);
+
+static const struct of_device_id gic_of_match[] = {
+	{.name = "gic",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, gic_of_match);
+
+static const struct pci_device_id octeontx_edac_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_OCTEONTX2_LMC) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_OCTEONTX2_MCC) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_OCTEONTX2_MDC) },
+	{ 0, },
+};
+
+static struct octeontx_res_list __ro_after_init edac_list;
+
+#define otx_printk(level, fmt, arg...) edac_printk(level, "octeontx", fmt, ##arg)
+
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+#define TEMPLATE_SHOW(reg)					\
+static ssize_t reg##_show(struct device *dev,			\
+		struct device_attribute *attr,			\
+		char *data)					\
+{								\
+	struct mem_ctl_info *mci = to_mci(dev);			\
+	struct octeontx_edac_pvt *pvt = mci->pvt_info;		\
+	return sprintf(data, "0x%016llx\n", (u64)pvt->reg);	\
+}
+
+#define TEMPLATE_STORE(reg)					\
+static ssize_t reg##_store(struct device *dev,			\
+		struct device_attribute *attr,			\
+		const char *data, size_t count)			\
+{								\
+	struct mem_ctl_info *mci = to_mci(dev);			\
+	struct octeontx_edac_pvt *pvt = mci->pvt_info;		\
+	if (isdigit(*data)) {					\
+		if (!kstrtoul(data, 0, &pvt->reg))		\
+			return count;				\
+	}							\
+	return 0;						\
+}
+
+#define TEMPLATE_DEV_SHOW(reg)					\
+static ssize_t dev_##reg##_show(struct edac_device_ctl_info *dev,\
+		char *data)					\
+{								\
+	struct octeontx_edac_pvt *pvt = dev->pvt_info;		\
+	return sprintf(data, "0x%016llx\n", (u64)pvt->reg);	\
+}
+
+#define TEMPLATE_DEV_STORE(reg)				\
+static ssize_t dev_##reg##_store(struct edac_device_ctl_info *dev,\
+		const char *data, size_t count)			\
+{								\
+	struct octeontx_edac_pvt *pvt = dev->pvt_info;		\
+	if (isdigit(*data)) {					\
+		if (!kstrtoul(data, 0, &pvt->reg))		\
+			return count;				\
+	}							\
+	return 0;						\
+}
+
+
+static const u64 einj_val = 0x5555555555555555;
+static u64 einj_fn(void)
+{
+	return einj_val;
+}
+
+static void octeontx_edac_inject_error(struct octeontx_edac_pvt *pvt)
+{
+	struct arm_smccc_res res;
+	unsigned long arg[8] = {0};
+	bool read = false;
+	bool call = false;
+	u64 val = einj_val;
+	unsigned long error_type = pvt->error_type & 0x0000FFFF;
+
+	if (soc_device_match(cn10_socinfo)) {
+		arg[0] = CN10K_EDAC_INJECT;
+		arg[1] = 0xd;
+		arg[2] = pvt->address;
+		arg[3] = (error_type >> 8) & 1;
+		arg[4] = error_type & 0xFF;
+		arm_smccc_smc(arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], &res);
+	} else {
+		arg[0] = OCTEONTX2_EDAC_INJECT;
+		arg[1] = 0x3;
+		arg[2] = pvt->address;
+		arg[3] = error_type;
+
+		arg[3] &= ~0x100;
+		switch (arg[2]) {
+		case 1 ... 2:
+			arg[2] = (u64)&val;
+			read = true;
+			break;
+		case 5 ... 6:
+			arg[2] = (u64)einj_fn;
+			call = true;
+			break;
+		case 3:
+		case 7:
+			arg[3] |= 0x100;
+			break;
+		}
+
+		arm_smccc_smc(arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], &res);
+
+		if (read && val != einj_val)
+			otx_printk(KERN_DEBUG, "read mismatch\n");
+
+		if (call && einj_fn() != einj_val)
+			otx_printk(KERN_DEBUG, "call mismatch\n");
+	}
+
+	otx_printk(KERN_DEBUG, "Inject: CPU%d: (0x%lx, 0x%lx, 0x%lx, 0x%lx, 0x%lx) 0x%lx\n",
+			smp_processor_id(),
+			arg[0], arg[1], arg[2], arg[3], arg[4], res.a0);
+}
+
+static ssize_t inject(struct octeontx_edac_pvt *pvt,
+		const char *data, size_t count)
+{
+	if (!(pvt->error_type & pvt->hes->ecc_cap))
+		return count;
+
+	if (!isdigit(*data))
+		return count;
+
+	if (kstrtoul(data, 0, &pvt->inject))
+		return count;
+
+	if (pvt->inject != 1)
+		return count;
+
+	pvt->inject = 0;
+
+	octeontx_edac_inject_error(pvt);
+
+	return count;
+}
+
+
+static ssize_t inject_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct octeontx_edac_pvt *pvt = mci->pvt_info;
+
+	return inject(pvt, data, count);
+}
+
+static ssize_t dev_inject_store(struct edac_device_ctl_info *dev,
+		const char *data, size_t count)
+{
+	struct octeontx_edac_pvt *pvt = dev->pvt_info;
+
+	return inject(pvt, data, count);
+}
+
+
+TEMPLATE_SHOW(address);
+TEMPLATE_STORE(address);
+TEMPLATE_SHOW(error_type);
+TEMPLATE_STORE(error_type);
+
+TEMPLATE_DEV_SHOW(address);
+TEMPLATE_DEV_STORE(address);
+TEMPLATE_DEV_SHOW(error_type);
+TEMPLATE_DEV_STORE(error_type);
+
+
+static DEVICE_ATTR_WO(inject);
+static DEVICE_ATTR_RW(error_type);
+static DEVICE_ATTR_RW(address);
+
+static struct attribute *octeontx_dev_attrs[] = {
+	&dev_attr_inject.attr,
+	&dev_attr_error_type.attr,
+	&dev_attr_address.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(octeontx_dev);
+
+static struct edac_dev_sysfs_attribute octeontx_dev_sysfs_attr[] = {
+	{
+		.attr = {
+		.name = "inject",
+		.mode = (0200)
+		},
+		.store = dev_inject_store
+	},
+	{
+		.attr = {
+		.name = "error_type",
+		.mode = (0644)
+		},
+		.show = dev_error_type_show,
+		.store = dev_error_type_store
+	},
+	{
+		.attr = {
+			.name = "address",
+			.mode = (0644)
+		},
+		.show = dev_address_show,
+		.store = dev_address_store},
+	{
+		.attr = {.name = NULL}
+	}
+};
+
+
+static void octeontx_edac_dev_attributes(struct edac_device_ctl_info *edac_dev)
+{
+	struct octeontx_edac_pvt *pvt = edac_dev->pvt_info;
+
+	edac_dev->sysfs_attributes = octeontx_dev_sysfs_attr;
+
+	pvt->inject = 0;
+	pvt->error_type = 0;
+	pvt->address = 0;
+}
+
+static enum hw_event_mc_err_type octeontx_edac_severity(int cper_sev)
+{
+	switch (cper_sev) {
+	case CPER_SEV_CORRECTED:
+		return HW_EVENT_ERR_CORRECTED;
+	case CPER_SEV_RECOVERABLE:
+		return HW_EVENT_ERR_UNCORRECTED;
+	case CPER_SEV_FATAL:
+		return HW_EVENT_ERR_FATAL;
+	case CPER_SEV_INFORMATIONAL:
+		return HW_EVENT_ERR_INFO;
+	}
+
+	return HW_EVENT_ERR_INFO;
+}
+
+static int octeontx_sdei_register(struct octeontx_edac *hes, sdei_event_callback *cb)
+{
+	int err = 0;
+
+	err = sdei_event_register(hes->sdei_num, cb, hes);
+	if (err) {
+		pr_err("Failed to register sdei-event #%d\n", hes->sdei_num);
+		return err;
+	}
+
+	err = sdei_event_enable(hes->sdei_num);
+	if (err) {
+		sdei_event_unregister(hes->sdei_num);
+		pr_err("Failed to enable sdei-event #%d\n", hes->sdei_num);
+		return err;
+	}
+	/*Ensure that reg updated*/
+	wmb();
+
+	return 0;
+}
+
+static void octeontx_sdei_unregister(struct octeontx_edac *hes)
+{
+	int err = 0;
+
+	err = sdei_event_disable(hes->sdei_num);
+	if (err) {
+		pr_err("Failed to disable sdei-event #%d (%pe)\n",
+				hes->sdei_num, ERR_PTR(err));
+		return;
+	}
+
+	err = sdei_event_unregister(hes->sdei_num);
+	if (err)
+		pr_err("Failed to unregister sdei-event #%d (%pe)\n",
+				hes->sdei_num, ERR_PTR(err));
+
+	/*Ensure that reg updated*/
+	wmb();
+}
+
+static int octeontx_mc_sdei_callback(u32 event_id, struct pt_regs *regs, void *arg)
+{
+	struct octeontx_edac *hes = arg;
+	struct mem_ctl_info *mci = hes->mci;
+
+	edac_queue_work(&mci->work, msecs_to_jiffies(0));
+
+	return 0;
+}
+
+static int octeontx_device_sdei_callback(u32 event_id, struct pt_regs *regs, void *arg)
+{
+	struct octeontx_edac *hes = arg;
+	struct edac_device_ctl_info *edac_dev = hes->edac_dev;
+
+	edac_queue_work(&edac_dev->work, msecs_to_jiffies(0));
+
+	return 0;
+}
+
+static int octeontx_cpu_sdei_callback(u32 event_id, struct pt_regs *regs, void *arg)
+{
+	struct octeontx_edac *hes = arg;
+
+	edac_queue_work(&hes->work, msecs_to_jiffies(0));
+
+	return 0;
+}
+
+static void octeontx_edac_mem_msg(struct octeontx_res_record *rec, char msg[SIZE])
+{
+	struct cper_mem_err_compact cmem;
+	struct cper_sec_mem_err *err = &rec->mem;
+	u32 len = SIZE;
+	u32 n = 0;
+
+	cper_mem_err_pack(err, &cmem);
+	n += cper_mem_err_location(&cmem, msg);
+
+	if (err->validation_bits & CPER_MEM_VALID_ERROR_TYPE)
+		n += snprintf(msg + n, len - n, "%s ", cper_mem_err_type_str(err->error_type));
+	msg[n] = '\0';
+}
+
+static void octeontx_edac_gic_msg(struct octeontx_res_record *rec, char msg[SIZE])
+{
+	struct cper_sec_platform_err *plat_err = NULL;
+	struct cper_sec_plat_gic *gicerr = NULL;
+	u32 len = SIZE;
+	u32 n = 0;
+
+	plat_err = &rec->gic;
+	gicerr   = &plat_err->perr.gic;
+
+	n += scnprintf(msg + n, len - n, "vbits=0x%x ", gicerr->validation_bits);
+	n += scnprintf(msg + n, len - n, "type 0x%x sev %d code 0x%x ",
+			gicerr->error_type, gicerr->error_sev, gicerr->error_code);
+	n += scnprintf(msg + n, len - n, "misc0=0x%llx misc1 0x%llx addr 0x%llx ",
+			gicerr->misc0, gicerr->misc1, gicerr->erraddr);
+	msg[n] = '\0';
+}
+
+static void octeontx_edac_cpu_msg(struct octeontx_res_record *rec, char msg[SIZE])
+{
+	struct cper_sec_proc_arm *desc = NULL;
+	struct cper_arm_err_info *info = NULL;
+	u32 len = SIZE;
+	u32 n = 0;
+
+	desc = &rec->core.desc;
+	info = &rec->core.info;
+
+	n += scnprintf(msg + n, len - n, "%s ", rec->msg);
+	n += scnprintf(msg + n, len - n, "midr=0x%llx ", desc->midr);
+	if (desc->validation_bits & CPER_ARM_VALID_MPIDR)
+		n += scnprintf(msg + n, len - n, "mpidr=0x%llx ", desc->mpidr);
+	if (info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR)
+		n += scnprintf(msg + n, len - n, "paddr=0x%llx ", info->physical_fault_addr);
+	if (info->validation_bits & CPER_ARM_INFO_VALID_VIRT_ADDR)
+		n += scnprintf(msg + n, len - n, "vaddr=0x%llx ", info->virt_fault_addr);
+	if (info->validation_bits & CPER_ARM_INFO_VALID_ERR_INFO)
+		n += scnprintf(msg + n, len - n, "info=0x%llx ", info->error_info);
+	msg[n] = '\0';
+}
+
+static void octeontx_edac_mc_wq(struct work_struct *work)
+{
+	struct delayed_work *dw = to_delayed_work(work);
+	struct mem_ctl_info *mci = container_of(dw, struct mem_ctl_info, work);
+	struct octeontx_edac_pvt *pvt = mci->pvt_info;
+	struct octeontx_edac *hes = pvt->hes;
+	struct octeontx_res_ring *ring = hes->ring;
+	struct octeontx_res_record rec;
+	enum hw_event_mc_err_type type;
+	u32 head = 0;
+	u32 tail = 0;
+	char msg[SIZE];
+
+	mutex_lock(&hes->lock);
+
+loop:
+	head = ring->head;
+	tail = ring->tail;
+
+	/*Ensure that head updated*/
+	rmb();
+
+	if (head == tail)
+		goto exit;
+
+	memcpy_fromio(&rec, ring->records + tail, sizeof(rec));
+
+	type = octeontx_edac_severity(rec.error_severity);
+
+	if (type == HW_EVENT_ERR_FATAL || type == HW_EVENT_ERR_UNCORRECTED) {
+		if (IS_ENABLED(CONFIG_MEMORY_FAILURE))
+			memory_failure(PHYS_PFN(rec.mem.physical_addr), 0);
+		else
+			otx_printk(KERN_ALERT, "PFN 0x%lx not offlined/poisoned, kernel might crash!\n",
+				 PHYS_PFN(rec.mem.physical_addr));
+	}
+
+	octeontx_edac_mem_msg(&rec, msg);
+
+	++tail;
+	ring->tail = tail % ring->size;
+
+	/*Ensure that tail updated*/
+	wmb();
+
+	edac_mc_handle_error(type, mci, 1, PHYS_PFN(rec.mem.physical_addr),
+			offset_in_page(rec.mem.physical_addr),
+			rec.syndrome, -1, -1, -1, rec.msg, msg);
+
+	if (head != tail)
+		goto loop;
+
+exit:
+	mutex_unlock(&hes->lock);
+}
+
+static void octeontx_edac_wq_handler(struct octeontx_edac *hes,
+				struct edac_device_ctl_info *edac_dev)
+{
+	struct octeontx_res_ring *ring = hes->ring;
+	struct octeontx_res_record rec;
+	enum hw_event_mc_err_type type;
+	u32 head = 0;
+	u32 tail = 0;
+	u32 inst = 0;
+	char msg[SIZE];
+
+	mutex_lock(&hes->lock);
+
+loop:
+	head = ring->head;
+	tail = ring->tail;
+
+	/*Ensure that head updated*/
+	rmb();
+
+	if (head == tail)
+		goto exit;
+
+	memcpy_fromio(&rec, ring->records + tail, sizeof(rec));
+
+	type = octeontx_edac_severity(rec.error_severity);
+
+	if (!strcmp(hes->name, gic_of_match[0].name)) {
+		octeontx_edac_gic_msg(&rec, msg);
+	} else if (!strcmp(hes->name, tad_of_match[0].name) ||
+			!strcmp(hes->name, mdc_of_match[0].name)) {
+		octeontx_edac_mem_msg(&rec, msg);
+	} else if (!strncmp(hes->name, cpu_of_match[0].name, 4)) {
+		octeontx_edac_cpu_msg(&rec, msg);
+		if (kstrtoint(&hes->name[4], 10, &inst) || inst > 255)
+			inst = 0;
+	}
+
+	++tail;
+	ring->tail = tail % ring->size;
+
+	/*Ensure that tail updated*/
+	wmb();
+
+	if (type == HW_EVENT_ERR_FATAL || type == HW_EVENT_ERR_UNCORRECTED)
+		edac_device_handle_ue(edac_dev, inst, 0, msg);
+	else
+		edac_device_handle_ce(edac_dev, inst, 0, msg);
+
+	if (head != tail)
+		goto loop;
+
+exit:
+	mutex_unlock(&hes->lock);
+}
+
+static void octeontx_edac_device_wq(struct work_struct *work)
+{
+	struct delayed_work *dw = to_delayed_work(work);
+	struct edac_device_ctl_info *edac_dev =
+			container_of(dw, struct edac_device_ctl_info, work);
+	struct octeontx_edac_pvt *pvt = edac_dev->pvt_info;
+	struct octeontx_edac *hes = pvt->hes;
+
+	octeontx_edac_wq_handler(hes, edac_dev);
+}
+
+static void octeontx_edac_cpu_wq(struct work_struct *work)
+{
+	struct delayed_work *dw = to_delayed_work(work);
+	struct octeontx_edac *hes = container_of(dw, struct octeontx_edac, work);
+	struct edac_device_ctl_info *edac_dev = hes->edac_dev;
+
+	octeontx_edac_wq_handler(hes, edac_dev);
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
+	if (soc_device_match(cn10_socinfo))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(octeontx_edac_pci_tbl); i++) {
+		pdevid = &octeontx_edac_pci_tbl[i];
+		pdev = NULL;
+		while ((pdev = pci_get_device(pdevid->vendor, pdevid->device, pdev)))
+			octeontx_edac_enable_msix(pdev);
+	}
+}
+
+static int octeontx_of_match_resource(struct octeontx_res_list *list)
+{
+	struct device_node *root = NULL;
+	struct device_node *node = NULL;
+	struct octeontx_edac *hes = NULL;
+	const __be32 *res = NULL;
+	u64 size = 0;
+	u64 base = 0;
+	size_t count = 0;
+
+	root = of_find_matching_node(NULL, octeontx_edac_of_match);
+	if (!root)
+		return -ENODEV;
+
+	for_each_available_child_of_node(root, node)
+		count++;
+
+	if (!count)
+		return -ENODEV;
+
+	list->count = count;
+	list->hes = NULL;
+
+	list->hes = kcalloc(count, sizeof(struct octeontx_edac), GFP_KERNEL);
+	if (!list->hes)
+		return -ENOMEM;
+
+	hes = list->hes;
+	for_each_available_child_of_node(root, node) {
+
+		strscpy(hes->name, node->name, sizeof(hes->name));
+
+		mutex_init(&hes->lock);
+
+		if (of_property_read_u32(node, "event-id", &hes->sdei_num)) {
+			otx_printk(KERN_ERR, "Unable read SDEI id\n");
+			return -EINVAL;
+		}
+
+		res = of_get_address(node, 2, &size, NULL);
+		base = of_translate_address(node, res);
+		if (base == OF_BAD_ADDR) {
+			otx_printk(KERN_ERR, "Unable translate address\n");
+			return -EINVAL;
+		}
+		hes->ring_pa = (phys_addr_t)base;
+		hes->ring_sz = (size_t)size;
+
+		otx_printk(KERN_DEBUG, "%s 0x%08x: 0x%llx/0x%lx\n",
+				hes->name, hes->sdei_num, hes->ring_pa, hes->ring_sz);
+
+		hes++;
+	}
+
+	return 0;
+}
+
+static struct octeontx_edac *octeontx_edac_get_hes(const char *name)
+{
+	struct octeontx_edac *hes = NULL;
+	u32 i = 0;
+
+	if (!name)
+		return NULL;
+
+	for (i = 0; i < edac_list.count; i++) {
+		hes = &edac_list.hes[i];
+		if (strcmp(name, hes->name) == 0)
+			return hes;
+	}
+
+	return NULL;
+}
+
+static int octeontx_edac_map_resource(struct platform_device *pdev,
+				struct octeontx_edac **src, char *str)
+{
+	struct octeontx_edac *hes = NULL;
+	struct device *dev = &pdev->dev;
+	const char *name = str ? str : dev->driver->of_match_table->name;
+
+	hes = octeontx_edac_get_hes(name);
+	if (!hes) {
+		dev_err(dev, "Unable to find hardware error source\n");
+		return -ENODEV;
+	}
+
+	if (!devm_request_mem_region(dev, hes->ring_pa, hes->ring_sz, hes->name)) {
+		dev_err(dev, "Unable request ring\n");
+		return -EBUSY;
+	}
+
+	hes->ring = devm_ioremap(dev, hes->ring_pa, hes->ring_sz);
+	if (!hes->ring) {
+		dev_err(dev, "Unable map ring\n");
+		return -ENOMEM;
+	}
+
+	if (hes->ring->sig != OCTEONTX2_RING_SIG)
+		return -ENODEV;
+	hes->ring->reg = OCTEONTX2_RING_SIG;
+
+	*src = hes;
+
+	return 0;
+}
+
+static int octeontx_edac_mc_init(struct platform_device *pdev,
+					struct octeontx_edac *hes)
+{
+	struct device *dev = &pdev->dev;
+	struct octeontx_edac_pvt *pvt = NULL;
+	struct mem_ctl_info *mci = NULL;
+	struct edac_mc_layer layers[1] = {0};
+	struct dimm_info *dimm;
+	int ret = 0;
+	int idx = 0;
+
+	idx = edac_device_alloc_index();
+
+	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
+	layers[0].size = 1;
+	layers[0].is_virt_csrow = false;
+
+	mci = edac_mc_alloc(idx, ARRAY_SIZE(layers), layers,
+			sizeof(struct octeontx_edac_pvt));
+	if (!mci) {
+		dev_err(dev, "Unable alloc MC\n");
+		ret = -ENOMEM;
+		goto err0;
+	}
+
+	mci->pdev = dev;
+	pvt = mci->pvt_info;
+	platform_set_drvdata(pdev, mci);
+	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->mod_name = dev->driver->name;
+	mci->ctl_name = hes->name;
+	mci->dev_name = hes->name;
+	mci->scrub_mode = SCRUB_HW_PROG;
+	mci->edac_check = NULL;
+	pvt->hes = hes;
+	hes->mci = mci;
+
+	dimm = edac_get_dimm(mci, 0, 0, 0);
+	dimm->grain = 1;
+
+	ret = edac_mc_add_mc_with_groups(mci, hes->ecc_cap ? octeontx_dev_groups : NULL);
+	if (ret)
+		goto err1;
+
+	INIT_DELAYED_WORK(&mci->work, octeontx_edac_mc_wq);
+	edac_stop_work(&mci->work);
+
+	ret = octeontx_sdei_register(hes, octeontx_mc_sdei_callback);
+	if (ret)
+		goto err1;
+
+	otx_printk(KERN_DEBUG, "Register %s %d/%d/%d\n",
+			hes->name, hes->ring->tail,
+			hes->ring->head, hes->ring->size);
+
+	return 0;
+
+err1:
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+
+err0:
+	dev_err(dev, "Unable register %d\n", ret);
+
+	return ret;
+}
+
+static int octeontx_edac_device_init(struct platform_device *pdev,
+				struct octeontx_edac *hes,
+				char *dev_name, char *blk_name)
+{
+	struct device *dev = &pdev->dev;
+	struct edac_device_ctl_info *edac_dev = NULL;
+	struct octeontx_edac_pvt *pvt = NULL;
+	int idx = 0;
+	int ret = 0;
+
+	idx = edac_device_alloc_index();
+
+	edac_dev = edac_device_alloc_ctl_info(sizeof(*pvt),
+			dev_name, 1, blk_name, 1, 0, NULL, 0, idx);
+	if (!edac_dev)
+		return -ENOMEM;
+
+	edac_dev->dev = dev;
+	pvt = edac_dev->pvt_info;
+	platform_set_drvdata(pdev, edac_dev);
+	edac_dev->mod_name = dev->driver->name;
+	edac_dev->ctl_name = hes->name;
+	edac_dev->dev_name = hes->name;
+	edac_dev->edac_check = NULL;
+	pvt->hes = hes;
+	hes->edac_dev = edac_dev;
+
+	if (hes->ecc_cap)
+		octeontx_edac_dev_attributes(edac_dev);
+
+	if (edac_device_add_device(edac_dev))
+		goto err0;
+
+	INIT_DELAYED_WORK(&edac_dev->work, octeontx_edac_device_wq);
+
+	edac_stop_work(&edac_dev->work);
+
+	ret = octeontx_sdei_register(hes, octeontx_device_sdei_callback);
+	if (ret)
+		goto err0;
+
+	otx_printk(KERN_DEBUG, "Register %s %d/%d/%d\n",
+			hes->name, hes->ring->tail,
+			hes->ring->head, hes->ring->size);
+
+	return 0;
+
+err0:
+	dev_err(dev, "Unable register %d\n", ret);
+	edac_device_free_ctl_info(edac_dev);
+
+	return -ENXIO;
+}
+
+static int octeontx_dss_probe(struct platform_device *pdev)
+{
+	struct octeontx_edac *hes = NULL;
+	int ret = 0;
+
+	ret = octeontx_edac_map_resource(pdev, &hes, NULL);
+	if (ret)
+		return ret;
+
+	hes->ecc_cap = CN10K_DSS_EINJ_CAP;
+
+	ret = octeontx_edac_mc_init(pdev, hes);
+
+	return ret;
+}
+
+static int octeontx_tad_probe(struct platform_device *pdev)
+{
+	struct octeontx_edac *hes = NULL;
+	int ret = 0;
+
+	ret = octeontx_edac_map_resource(pdev, &hes, NULL);
+	if (ret)
+		return ret;
+
+	ret = octeontx_edac_device_init(pdev, hes, "llc", hes->name);
+
+	return ret;
+}
+
+static int octeontx_mdc_probe(struct platform_device *pdev)
+{
+	struct octeontx_edac *hes = NULL;
+	int ret = 0;
+
+	ret = octeontx_edac_map_resource(pdev, &hes, NULL);
+	if (ret)
+		return ret;
+
+	if (soc_device_match(cn10_socinfo))
+		hes->ecc_cap = 0;
+	else
+		hes->ecc_cap = OCTEONTX2_MDC_EINJ_CAP;
+
+	ret = octeontx_edac_device_init(pdev, hes, hes->name, hes->name);
+
+	return ret;
+}
+
+static int octeontx_mcc_probe(struct platform_device *pdev)
+{
+	struct octeontx_edac *hes = NULL;
+	int ret = 0;
+
+	ret = octeontx_edac_map_resource(pdev, &hes, NULL);
+	if (ret)
+		return ret;
+
+	hes->ecc_cap = OCTEONTX2_MCC_EINJ_CAP;
+
+	ret = octeontx_edac_mc_init(pdev, hes);
+
+	return ret;
+}
+
+static int octeontx_cpu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct octeontx_edac *hes = NULL;
+	struct edac_device_ctl_info *edac_dev = NULL;
+	char *name = (char *)dev->driver->of_match_table->name;
+	int idx = 0;
+	int ret = 0;
+	int i = 0;
+	u8 cores = 0;
+
+	for (i = 0; i < edac_list.count; i++) {
+		hes = &edac_list.hes[i];
+		if (!strncmp(name, hes->name, 4))
+			cores++;
+	}
+
+	idx = edac_device_alloc_index();
+
+	edac_dev = edac_device_alloc_ctl_info(0, "cpu", cores, name, 1, 0, NULL, 0, idx);
+	if (!edac_dev)
+		return -ENOMEM;
+
+	edac_dev->dev = dev;
+	platform_set_drvdata(pdev, edac_dev);
+	edac_dev->mod_name = dev->driver->name;
+	edac_dev->ctl_name = name;
+	edac_dev->dev_name = name;
+	edac_dev->edac_check = NULL;
+
+	ret = edac_device_add_device(edac_dev);
+	if (ret)
+		goto err0;
+
+	for (i = 0; i < edac_list.count; i++) {
+		hes = &edac_list.hes[i];
+		if (strncmp(name, hes->name, 4))
+			continue;
+
+		ret = octeontx_edac_map_resource(pdev, &hes, hes->name);
+		if (ret)
+			goto err0;
+
+		hes->edac_dev = edac_dev;
+
+		INIT_DELAYED_WORK(&hes->work, octeontx_edac_cpu_wq);
+		edac_stop_work(&hes->work);
+
+		octeontx_sdei_register(hes, octeontx_cpu_sdei_callback);
+	}
+
+	otx_printk(KERN_DEBUG, "Register %d %s\n", cores, edac_dev->ctl_name);
+
+	return 0;
+
+err0:
+	dev_err(dev, "Unable register %d\n", ret);
+	edac_device_free_ctl_info(edac_dev);
+
+	return ret;
+}
+
+static int octeontx_gic_probe(struct platform_device *pdev)
+{
+	struct octeontx_edac *hes = NULL;
+	int ret = 0;
+
+	ret = octeontx_edac_map_resource(pdev, &hes, NULL);
+	if (ret)
+		return ret;
+
+	ret = octeontx_edac_device_init(pdev, hes, "gic", hes->name);
+
+	return ret;
+}
+
+static int octeontx_device_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_dev = platform_get_drvdata(pdev);
+	struct octeontx_edac_pvt *pvt = edac_dev->pvt_info;
+
+	octeontx_sdei_unregister(pvt->hes);
+	edac_device_del_device(&pdev->dev);
+	edac_device_free_ctl_info(edac_dev);
+	platform_device_unregister(pdev);
+
+	return 0;
+}
+
+static int octeontx_mc_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct octeontx_edac_pvt *pvt = mci->pvt_info;
+
+	octeontx_sdei_unregister(pvt->hes);
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+	platform_device_unregister(pdev);
+
+	return 0;
+}
+
+static int octeontx_cpu_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_dev = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	char *name = (char *)dev->driver->of_match_table->name;
+	struct octeontx_edac *hes = NULL;
+	int i = 0;
+
+	for (i = 0; i < edac_list.count; i++) {
+		hes = &edac_list.hes[i];
+		if (strncmp(name, hes->name, 4))
+			continue;
+		octeontx_sdei_unregister(hes);
+	}
+	edac_device_del_device(&pdev->dev);
+	edac_device_free_ctl_info(edac_dev);
+	platform_device_unregister(pdev);
+
+	return 0;
+}
+
+static struct platform_driver tad_edac_drv = {
+	.probe = octeontx_tad_probe,
+	.remove = octeontx_device_remove,
+	.driver = {
+		.name = "tad_edac",
+		.of_match_table = tad_of_match,
+	},
+};
+
+static struct platform_driver dss_edac_drv = {
+	.probe = octeontx_dss_probe,
+	.remove = octeontx_mc_remove,
+	.driver = {
+		.name = "dss_edac",
+		.of_match_table = dss_of_match,
+	},
+};
+
+static struct platform_driver mdc_edac_drv = {
+	.probe = octeontx_mdc_probe,
+	.remove = octeontx_device_remove,
+	.driver = {
+		.name = "mdc_edac",
+		.of_match_table = mdc_of_match,
+	},
+};
+
+static struct platform_driver mcc_edac_drv = {
+	.probe = octeontx_mcc_probe,
+	.remove = octeontx_mc_remove,
+	.driver = {
+		.name = "mcc_edac",
+		.of_match_table = mcc_of_match,
+	}
+};
+
+static struct platform_driver cpu_edac_drv = {
+	.probe = octeontx_cpu_probe,
+	.remove = octeontx_cpu_remove,
+	.driver = {
+		.name = "cpu_edac",
+		.of_match_table = cpu_of_match,
+	}
+};
+
+static struct platform_driver gic_edac_drv = {
+	.probe = octeontx_gic_probe,
+	.remove = octeontx_device_remove,
+	.driver = {
+		.name = "gic_edac",
+		.of_match_table = gic_of_match,
+	}
+};
+
+static int __init octeontx_edac_init(void)
+{
+	struct platform_device *mdc = NULL;
+	struct platform_device *dss = NULL;
+	struct platform_device *tad = NULL;
+	struct platform_device *mcc = NULL;
+	struct platform_device *cpu = NULL;
+	struct platform_device *gic = NULL;
+	int ret = 0;
+
+	octeontx_edac_msix_init();
+
+	ret = octeontx_of_match_resource(&edac_list);
+	if (ret)
+		goto exit0;
+
+	sdei_init();
+
+	if (soc_device_match(cn10_socinfo)) {
+
+		ret = platform_driver_register(&dss_edac_drv);
+		if (!ret)
+			dss = platform_device_register_simple(dss_edac_drv.driver.name,
+					PLATFORM_DEVID_NONE, NULL, 0);
+		if (!ret && IS_ERR(dss)) {
+			pr_err("Unable register %s %ld\n", dss_edac_drv.driver.name, PTR_ERR(dss));
+			platform_driver_unregister(&dss_edac_drv);
+		}
+
+		ret = platform_driver_register(&tad_edac_drv);
+		if (!ret)
+			tad = platform_device_register_simple(tad_edac_drv.driver.name,
+					PLATFORM_DEVID_NONE, NULL, 0);
+		if (!ret && IS_ERR(tad)) {
+			pr_err("Unable register %s %ld\n", tad_edac_drv.driver.name, PTR_ERR(tad));
+			platform_driver_unregister(&tad_edac_drv);
+		}
+
+		ret = platform_driver_register(&cpu_edac_drv);
+		if (!ret)
+			cpu = platform_device_register_simple(cpu_edac_drv.driver.name,
+					PLATFORM_DEVID_NONE, NULL, 0);
+		if (!ret && IS_ERR(cpu)) {
+			pr_err("Unable register %s %ld\n", cpu_edac_drv.driver.name, PTR_ERR(cpu));
+			platform_driver_unregister(&cpu_edac_drv);
+		}
+
+		ret = platform_driver_register(&gic_edac_drv);
+		if (!ret)
+			gic = platform_device_register_simple(gic_edac_drv.driver.name,
+					PLATFORM_DEVID_NONE, NULL, 0);
+		if (!ret && IS_ERR(gic)) {
+			pr_err("Unable register %s %ld\n", gic_edac_drv.driver.name, PTR_ERR(gic));
+			platform_driver_unregister(&gic_edac_drv);
+		}
+	} else {
+		ret = platform_driver_register(&mcc_edac_drv);
+		if (!ret)
+			mcc = platform_device_register_simple(mcc_edac_drv.driver.name,
+					PLATFORM_DEVID_NONE, NULL, 0);
+		if (!ret && IS_ERR(mcc)) {
+			pr_err("Unable register %s %ld\n", mcc_edac_drv.driver.name, PTR_ERR(mcc));
+			platform_driver_unregister(&mcc_edac_drv);
+		}
+	}
+
+	ret = platform_driver_register(&mdc_edac_drv);
+	if (!ret)
+		mdc = platform_device_register_simple(mdc_edac_drv.driver.name,
+				PLATFORM_DEVID_NONE, NULL, 0);
+	if (!ret && IS_ERR(mdc)) {
+		pr_err("Unable register %s %ld\n", mdc_edac_drv.driver.name, PTR_ERR(mdc));
+		platform_driver_unregister(&mdc_edac_drv);
+	}
+
+	return 0;
+
+exit0:
+	if (ret == -ENODEV)
+		return ret;
+
+	pr_err("OcteonTX edac init failed %d\n", ret);
+	kfree(edac_list.hes);
+
+	return ret;
+}
+
+static void __exit octeontx_edac_exit(void)
+{
+	if (soc_device_match(cn10_socinfo)) {
+		platform_driver_unregister(&dss_edac_drv);
+		platform_driver_unregister(&tad_edac_drv);
+		platform_driver_unregister(&cpu_edac_drv);
+		platform_driver_unregister(&gic_edac_drv);
+	} else {
+		platform_driver_unregister(&mcc_edac_drv);
+	}
+	platform_driver_unregister(&mdc_edac_drv);
+	kfree(edac_list.hes);
+}
+
+late_initcall(octeontx_edac_init);
+module_exit(octeontx_edac_exit);
+
+MODULE_AUTHOR("Vasyl Gomonovych <vgomonovych@marvell.com>");
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_DESCRIPTION("OcteonTX2 / CN10K EDAC driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


