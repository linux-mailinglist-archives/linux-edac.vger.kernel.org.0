Return-Path: <linux-edac+bounces-4375-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB725B0820B
	for <lists+linux-edac@lfdr.de>; Thu, 17 Jul 2025 03:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8BA582EC9
	for <lists+linux-edac@lfdr.de>; Thu, 17 Jul 2025 01:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D391C5F13;
	Thu, 17 Jul 2025 01:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S3b6yANo"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC26155A59;
	Thu, 17 Jul 2025 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714393; cv=none; b=BeyWTgF+vqeOtMBsRtchfpdjMsjQSB3VqhAZoccQGoraoEriElb+VviDWJ41jizP/XVuxUw4YzWDhhxp19c3RCw/ScSuWYn/bxsCif7IjqonTXGBVAQpJw5tPZ6T9Accrf5Yh6Y5IUrC1ta9acVMtbZkcCsBmkcWYivU7JjfBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714393; c=relaxed/simple;
	bh=wNXNBa2+6VUHJc2N0VOBdHjgf+1Mfqg34l1/RVdDCko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uh3NoycWyNOlG6Ya/fGEmIwiIpnNtjR6RvieutcqVSsOrJJpoJwVmLLCcoPqGn07k/YDPYpE2MKqWt4QsRLbwiRCoNCt9zDQzINOaTig012mejl+N38DfZ3cXZGW208WBlIPlgt8Efj6ecaollbrnTLii7e3UphOZRHIY/LPFUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S3b6yANo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1053)
	id BDD7F2116DAD; Wed, 16 Jul 2025 18:06:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BDD7F2116DAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752714390;
	bh=QrGKpaaboXr1gILf224niZQSDfh2vuRWiZExmrVTUG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S3b6yANol8rGKSM/kEtyOH+S9CbEvzWdomRqUr+g1k6wRR43vxDAav6yFtDRn6k8f
	 j5qfSUsUyN7cTHBm4yUqaOybd0C1qm+rsf6zxRVRwVoiba3K1UKeyc6M793d0dQfSY
	 R1zazzMIdoI2TPSGZyUHP3dyhUECU2bK9qKDalfM=
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tyler Hicks <code@tyhicks.com>,
	Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org,
	Vijay Balakrishna <vijayb@linux.microsoft.com>
Subject: [v12 PATCH 1/2] EDAC: Add EDAC driver for ARM Cortex A72 cores
Date: Wed, 16 Jul 2025 18:06:29 -0700
Message-Id: <1752714390-27389-2-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752714390-27389-1-git-send-email-vijayb@linux.microsoft.com>
References: <1752714390-27389-1-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

From: Sascha Hauer <s.hauer@pengutronix.de>

The driver is designed to support error detection and reporting for
Cortex A72 cores, specifically within their L1 and L2 cache systems.
The errors are detected by reading CPU/L2 memory error syndrome
registers.

Unfortunately there is no robust way to inject errors into the caches,
so this driver doesn't contain any code to actually test it. It has
been tested though with code taken from an older version [1] of this
driver. For reasons stated in thread [1], the error injection code is
not suitable for mainline, so it is removed from the driver.

[1] https://lore.kernel.org/all/1521073067-24348-1-git-send-email-york.sun@nxp.com/#t

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Co-developed-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
---
 MAINTAINERS             |   7 ++
 drivers/edac/Kconfig    |   8 ++
 drivers/edac/Makefile   |   1 +
 drivers/edac/a72_edac.c | 227 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 243 insertions(+)
 create mode 100644 drivers/edac/a72_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c3f7fbd0d67a..d237ab92fdb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8588,6 +8588,13 @@ F:	Documentation/driver-api/edac.rst
 F:	drivers/edac/
 F:	include/linux/edac.h
 
+EDAC-A72
+M:	Vijay Balakrishna <vijayb@linux.microsoft.com>
+M:	Tyler Hicks <code@tyhicks.com>
+L:	linux-edac@vger.kernel.org
+S:	Supported
+F:	drivers/edac/a72_edac.c
+
 EDAC-DMC520
 M:	Lei Wang <lewan@microsoft.com>
 L:	linux-edac@vger.kernel.org
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 19ad3c3b675d..b824472208c4 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -576,4 +576,12 @@ config EDAC_LOONGSON
 	  errors (CE) only. Loongson-3A5000/3C5000/3D5000/3A6000/3C6000
 	  are compatible.
 
+config EDAC_CORTEX_A72
+	tristate "ARM Cortex A72"
+	depends on ARM64
+	help
+	  Support for L1/L2 cache error detection for ARM Cortex A72 processor.
+	  The detected and reported errors are from reading CPU/L2 memory error
+	  syndrome registers.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index a8f2d8f6c894..c1736f264320 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
 obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
 obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
 obj-$(CONFIG_EDAC_LOONGSON)		+= loongson_edac.o
+obj-$(CONFIG_EDAC_CORTEX_A72)		+= a72_edac.o
diff --git a/drivers/edac/a72_edac.c b/drivers/edac/a72_edac.c
new file mode 100644
index 000000000000..997dc9547637
--- /dev/null
+++ b/drivers/edac/a72_edac.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cortex A72 EDAC L1 and L2 cache error detection
+ *
+ * Copyright (c) 2020 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
+ * Copyright (c) 2025 Microsoft Corporation, <vijayb@linux.microsoft.com>
+ *
+ * Based on Code from:
+ * Copyright (c) 2018, NXP Semiconductor
+ * Author: York Sun <york.sun@nxp.com>
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/bitfield.h>
+#include <asm/smp_plat.h>
+
+#include "edac_module.h"
+
+#define DRVNAME			"a72-edac"
+
+#define SYS_CPUMERRSR_EL1	sys_reg(3, 1, 15, 2, 2)
+#define SYS_L2MERRSR_EL1	sys_reg(3, 1, 15, 2, 3)
+
+#define CPUMERRSR_EL1_RAMID	GENMASK(30, 24)
+#define L2MERRSR_EL1_CPUID_WAY	GENMASK(21, 18)
+
+#define CPUMERRSR_EL1_VALID	BIT(31)
+#define CPUMERRSR_EL1_FATAL	BIT(63)
+#define L2MERRSR_EL1_VALID	BIT(31)
+#define L2MERRSR_EL1_FATAL	BIT(63)
+
+#define L1_I_TAG_RAM		0x00
+#define L1_I_DATA_RAM		0x01
+#define L1_D_TAG_RAM		0x08
+#define L1_D_DATA_RAM		0x09
+#define TLB_RAM			0x18
+
+#define MESSAGE_SIZE		64
+
+struct mem_err_synd_reg {
+	u64 cpu_mesr;
+	u64 l2_mesr;
+};
+
+static struct cpumask compat_mask;
+
+static void report_errors(struct edac_device_ctl_info *edac_ctl, int cpu,
+			  struct mem_err_synd_reg *mesr)
+{
+	u64 cpu_mesr = mesr->cpu_mesr;
+	u64 l2_mesr = mesr->l2_mesr;
+	char msg[MESSAGE_SIZE];
+
+	if (cpu_mesr & CPUMERRSR_EL1_VALID) {
+		const char *str;
+		bool fatal = cpu_mesr & CPUMERRSR_EL1_FATAL;
+
+		switch (FIELD_GET(CPUMERRSR_EL1_RAMID, cpu_mesr)) {
+		case L1_I_TAG_RAM:
+			str = "L1-I Tag RAM";
+			break;
+		case L1_I_DATA_RAM:
+			str = "L1-I Data RAM";
+			break;
+		case L1_D_TAG_RAM:
+			str = "L1-D Tag RAM";
+			break;
+		case L1_D_DATA_RAM:
+			str = "L1-D Data RAM";
+			break;
+		case TLB_RAM:
+			str = "TLB RAM";
+			break;
+		default:
+			str = "Unspecified";
+			break;
+		}
+
+		snprintf(msg, MESSAGE_SIZE, "%s %s error(s) on CPU %d",
+			 str, fatal ? "fatal" : "correctable", cpu);
+
+		if (fatal)
+			edac_device_handle_ue(edac_ctl, cpu, 0, msg);
+		else
+			edac_device_handle_ce(edac_ctl, cpu, 0, msg);
+	}
+
+	if (l2_mesr & L2MERRSR_EL1_VALID) {
+		bool fatal = l2_mesr & L2MERRSR_EL1_FATAL;
+
+		snprintf(msg, MESSAGE_SIZE, "L2 %s error(s) on CPU %d CPUID/WAY 0x%lx",
+			 fatal ? "fatal" : "correctable", cpu,
+			 FIELD_GET(L2MERRSR_EL1_CPUID_WAY, l2_mesr));
+		if (fatal)
+			edac_device_handle_ue(edac_ctl, cpu, 1, msg);
+		else
+			edac_device_handle_ce(edac_ctl, cpu, 1, msg);
+	}
+}
+
+static void read_errors(void *data)
+{
+	struct mem_err_synd_reg *mesr = data;
+
+	mesr->cpu_mesr = read_sysreg_s(SYS_CPUMERRSR_EL1);
+	if (mesr->cpu_mesr & CPUMERRSR_EL1_VALID) {
+		write_sysreg_s(0, SYS_CPUMERRSR_EL1);
+		isb();
+	}
+	mesr->l2_mesr = read_sysreg_s(SYS_L2MERRSR_EL1);
+	if (mesr->l2_mesr & L2MERRSR_EL1_VALID) {
+		write_sysreg_s(0, SYS_L2MERRSR_EL1);
+		isb();
+	}
+}
+
+static void a72_edac_check(struct edac_device_ctl_info *edac_ctl)
+{
+	struct mem_err_synd_reg mesr;
+	int cpu;
+
+	cpus_read_lock();
+	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
+		smp_call_function_single(cpu, read_errors, &mesr, true);
+		report_errors(edac_ctl, cpu, &mesr);
+	}
+	cpus_read_unlock();
+}
+
+static int a72_edac_probe(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_ctl;
+	struct device *dev = &pdev->dev;
+	int rc;
+
+	edac_ctl = edac_device_alloc_ctl_info(0, "cpu",
+					      num_possible_cpus(), "L", 2, 1,
+					      edac_device_alloc_index());
+	if (!edac_ctl)
+		return -ENOMEM;
+
+	edac_ctl->edac_check = a72_edac_check;
+	edac_ctl->dev = dev;
+	edac_ctl->mod_name = dev_name(dev);
+	edac_ctl->dev_name = dev_name(dev);
+	edac_ctl->ctl_name = DRVNAME;
+	dev_set_drvdata(dev, edac_ctl);
+
+	rc = edac_device_add_device(edac_ctl);
+	if (rc)
+		goto out_dev;
+
+	return 0;
+
+out_dev:
+	edac_device_free_ctl_info(edac_ctl);
+
+	return rc;
+}
+
+static void a72_edac_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_ctl = dev_get_drvdata(&pdev->dev);
+
+	edac_device_del_device(edac_ctl->dev);
+	edac_device_free_ctl_info(edac_ctl);
+}
+
+static const struct of_device_id cortex_arm64_edac_of_match[] = {
+	{ .compatible = "arm,cortex-a72" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cortex_arm64_edac_of_match);
+
+static struct platform_driver a72_edac_driver = {
+	.probe = a72_edac_probe,
+	.remove = a72_edac_remove,
+	.driver = {
+		.name = DRVNAME,
+	},
+};
+
+static struct platform_device *a72_pdev;
+
+static int __init a72_edac_driver_init(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct device_node *np __free(device_node) =
+				of_cpu_device_node_get(cpu);
+
+		if (np) {
+			if (of_match_node(cortex_arm64_edac_of_match, np) &&
+			    of_property_read_bool(np, "edac-enabled")) {
+				cpumask_set_cpu(cpu, &compat_mask);
+			}
+		} else {
+			pr_warn("failed to find device node for CPU %d\n", cpu);
+		}
+	}
+
+	if (cpumask_empty(&compat_mask))
+		return 0;
+
+	a72_pdev = platform_device_register_simple(DRVNAME, -1, NULL, 0);
+	if (IS_ERR(a72_pdev)) {
+		pr_err("failed to register a72 edac device\n");
+		return PTR_ERR(a72_pdev);
+	}
+
+	return platform_driver_register(&a72_edac_driver);
+}
+
+static void __exit a72_edac_driver_exit(void)
+{
+	platform_device_unregister(a72_pdev);
+	platform_driver_unregister(&a72_edac_driver);
+}
+
+module_init(a72_edac_driver_init);
+module_exit(a72_edac_driver_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_DESCRIPTION("Cortex A72 L1 and L2 cache EDAC driver");
-- 
2.49.0


