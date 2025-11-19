Return-Path: <linux-edac+bounces-5472-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A2EC6F319
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 15:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CC78501FC2
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728D03624D0;
	Wed, 19 Nov 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8Nd1A75"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE835F8C5;
	Wed, 19 Nov 2025 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560370; cv=none; b=WDomiAefMnqRhdKZUiwA8G3YKYrcUh48eX7bAy9G3m+kmj4KNy72v01nr32y0gEVDX6Usc3eQ7zsU+HIdEE0rCXnKdxnLowN26cBqH2FWOL84k63us/8/9KtOAaVBuzX5gQHNDHjUwTLF4e3Ntmoi5946U5JJ8i7qT/TmcC6Kbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560370; c=relaxed/simple;
	bh=VBcGO2lBpS7mQszR6C3qaM4J0ffu0bVGyhSa2FplPwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTFb0ztN097LWNq9gfZ8dOq1QCsWm7TbUITfzi310xc+bYn7dmVvsc0aIgoo+iZKNlSrkwvuSSIaA1oywnSGAQ+nw6ZRkx3pb2tzLEGSDNJOu0EPPDsr6+pdK7Vdn5o5VIJo38Zn524Rt/YZL9AEgTS/5GUYPt9OAGFuVKNCIXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8Nd1A75; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763560368; x=1795096368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VBcGO2lBpS7mQszR6C3qaM4J0ffu0bVGyhSa2FplPwU=;
  b=m8Nd1A75VZBpRdRtRxn17DVluNY//ORn/2fTrTO9URMNueXjCyUM34oU
   7dGWIzc9SR52PsWI9J1aTLE/1oKR9UMBMO54XEaAypnR6KZumDH/0NgOW
   WtFSYEqUuhP1dnp6Hw25aYFydNicqxENthn7m7O3/0qjZLCVLv39q9Vqp
   a7dIH2Z3ythafJCGlhOW80SsSiy3Z+INLUKA6Q022SLHv6SKmHGdYGFGT
   xPhBIxIRemveWAcb0NaL0E5z4TlL7Q1gayZT5d1dgigS6b8vwReZqe6Sk
   pJoojgI1gH8u/i4lqjP6rN/3dqphWSvlryD1ptV+SoKngbgDTVYgJ4Hpg
   w==;
X-CSE-ConnectionGUID: etetPlpgTAib/ThB17lwNw==
X-CSE-MsgGUID: EWe5lXc1QZSP4lqcDPqFcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="64607393"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="64607393"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:52:48 -0800
X-CSE-ConnectionGUID: AOne8lksROi5rJKBRQ1d3Q==
X-CSE-MsgGUID: IhIarCsQToK5gmMefl1+lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="214439614"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:52:45 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] EDAC/{skx_common,imh}: Add EDAC driver for Intel Diamond Rapids servers
Date: Wed, 19 Nov 2025 21:41:28 +0800
Message-ID: <20251119134132.2389472-5-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
References: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Diamond Rapids CPUs include Integrated Memory and I/O Hubs (IMH).
The memory controllers within the IMHs provide memory stacks to the
processor. Create a new driver for this IMH-based memory controllers
rather than applying additional patches to the existing i10nm_edac.c
for the following reasons:

1) The memory controllers are not presented as PCI devices; instead,
   the detection and all their registers have been transitioned to
   MMIO-based memory spaces.

2) Validation processes are costly. Modifications to i10nm_edac would
   require extensive validation checks against multiple platforms,
   including Ice Lake, Sapphire Rapids, Emerald Rapids, Granite Rapids,
   Sierra Forest, and Grand Ridge.

3) Future Intel CPUs will likely only need patches on top of this new
   EDAC driver. Validation can be limited to Diamond Rapids servers
   and future Intel CPU generations.

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/Kconfig      |  10 +
 drivers/edac/Makefile     |   3 +
 drivers/edac/imh_base.c   | 562 ++++++++++++++++++++++++++++++++++++++
 drivers/edac/skx_common.c |   8 +-
 drivers/edac/skx_common.h |  89 ++++--
 5 files changed, 646 insertions(+), 26 deletions(-)
 create mode 100644 drivers/edac/imh_base.c

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 39352b9b7a7e..dbdfc86656d1 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -291,6 +291,16 @@ config EDAC_I10NM
 	  system has non-volatile DIMMs you should also manually
 	  select CONFIG_ACPI_NFIT.
 
+config EDAC_IMH
+	tristate "Intel Integrated Memory/IO Hub MC"
+	depends on X86_64 && X86_MCE_INTEL && ACPI
+	select ACPI_ADXL
+	help
+	  Support for error detection and correction the Intel
+	  Integrated Memory/IO Hub Memory Controller. This MC IP is
+	  first used on the Diamond Rapids servers but may appear on
+	  others in the future.
+
 config EDAC_PND2
 	tristate "Intel Pondicherry2"
 	depends on PCI && X86_64 && X86_MCE_INTEL
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 1c14796410a3..8429b1e856bc 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -65,6 +65,9 @@ obj-$(CONFIG_EDAC_SKX)			+= skx_edac.o skx_edac_common.o
 i10nm_edac-y				:= i10nm_base.o
 obj-$(CONFIG_EDAC_I10NM)		+= i10nm_edac.o skx_edac_common.o
 
+imh_edac-y				:= imh_base.o
+obj-$(CONFIG_EDAC_IMH)			+= imh_edac.o skx_edac_common.o
+
 obj-$(CONFIG_EDAC_HIGHBANK_MC)		+= highbank_mc_edac.o
 obj-$(CONFIG_EDAC_HIGHBANK_L2)		+= highbank_l2_edac.o
 
diff --git a/drivers/edac/imh_base.c b/drivers/edac/imh_base.c
new file mode 100644
index 000000000000..9c1a17c53ec1
--- /dev/null
+++ b/drivers/edac/imh_base.c
@@ -0,0 +1,562 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Intel(R) servers with Integrated Memory/IO Hub-based memory controller.
+ * Copyright (c) 2025, Intel Corporation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+#include <asm/mce.h>
+#include <asm/cpu.h>
+#include "edac_module.h"
+#include "skx_common.h"
+
+#define IMH_REVISION	"v0.0.1"
+#define EDAC_MOD_STR	"imh_edac"
+
+/* Debug macros */
+#define imh_printk(level, fmt, arg...)	\
+	edac_printk(level, "imh", fmt, ##arg)
+
+/* Configuration Agent(Ubox) */
+#define MMIO_BASE_H(reg)		(((u64)GET_BITFIELD(reg, 0, 29)) << 23)
+#define SOCKET_ID(reg)			GET_BITFIELD(reg, 0, 3)
+
+/* PUNIT */
+#define DDR_IMC_BITMAP(reg)		GET_BITFIELD(reg, 23, 30)
+
+/* Memory Controller */
+#define ECC_ENABLED(reg)		GET_BITFIELD(reg, 2, 2)
+#define DIMM_POPULATED(reg)		GET_BITFIELD(reg, 15, 15)
+
+/* System Cache Agent(SCA) */
+#define TOLM(reg)			(((u64)GET_BITFIELD(reg, 16, 31)) << 16)
+#define TOHM(reg)			(((u64)GET_BITFIELD(reg, 16, 51)) << 16)
+
+/**
+ * struct local_reg - A register as described in the local package view.
+ *
+ * @pkg (input)      : The package where the register is located.
+ * @pbase (input)    : The IP MMIO base physical address in the local package view.
+ * @size (input)     : The IP MMIO size.
+ * @offset (input)   : The register offset from the IP MMIO base @pbase.
+ * @width (input)    : The register width in byte.
+ * @vbase (internal) : The IP MMIO base virtual address.
+ * @val (output)     : The register value.
+ */
+struct local_reg {
+	int pkg;
+	u64 pbase;
+	u32 size;
+	u32 offset;
+	u8  width;
+	void __iomem *vbase;
+	u64 val;
+};
+
+#define DEFINE_LOCAL_REG(name, cfg, package, north, ip_name, ip_idx, reg_name)	\
+	struct local_reg name = {						\
+		.pkg	= package,						\
+		.pbase	= (north ? (cfg)->mmio_base_l_north :			\
+			  (cfg)->mmio_base_l_south) +				\
+			  (cfg)->ip_name##_base +				\
+			  (cfg)->ip_name##_size * (ip_idx),			\
+		.size	= (cfg)->ip_name##_size,				\
+		.offset	= (cfg)->ip_name##_reg_##reg_name##_offset,		\
+		.width	= (cfg)->ip_name##_reg_##reg_name##_width,		\
+	}
+
+static u64 readx(void __iomem *addr, u8 width)
+{
+	switch (width) {
+	case 1:
+		return readb(addr);
+	case 2:
+		return readw(addr);
+	case 4:
+		return readl(addr);
+	case 8:
+		return readq(addr);
+	default:
+		imh_printk(KERN_ERR, "Invalid reg 0x%p width %d\n", addr, width);
+		return 0;
+	}
+}
+
+static void __read_local_reg(void *reg)
+{
+	struct local_reg *r = (struct local_reg *)reg;
+
+	r->val = readx(r->vbase + r->offset, r->width);
+}
+
+/* Read a local-view register. */
+static bool read_local_reg(struct local_reg *reg)
+{
+	int cpu;
+
+	/* Get the target CPU in the package @reg->pkg. */
+	for_each_online_cpu(cpu) {
+		if (reg->pkg == topology_physical_package_id(cpu))
+			break;
+	}
+
+	if (cpu >= nr_cpu_ids)
+		return false;
+
+	reg->vbase = ioremap(reg->pbase, reg->size);
+	if (!reg->vbase) {
+		imh_printk(KERN_ERR, "Failed to ioremap 0x%llx\n", reg->pbase);
+		return false;
+	}
+
+	/* Get the target CPU to read the register. */
+	smp_call_function_single(cpu, __read_local_reg, reg, 1);
+	iounmap(reg->vbase);
+
+	return true;
+}
+
+/* Get the bitmap of memory controller instances in package @pkg. */
+static u32 get_imc_bitmap(struct res_config *cfg, int pkg, bool north)
+{
+	DEFINE_LOCAL_REG(reg, cfg, pkg, north, pcu, 0, capid3);
+
+	if (!read_local_reg(&reg))
+		return 0;
+
+	edac_dbg(2, "Pkg%d %s mc instances bitmap 0x%llx (reg 0x%llx)\n",
+		 pkg, north ? "north" : "south",
+		 DDR_IMC_BITMAP(reg.val), reg.val);
+
+	return DDR_IMC_BITMAP(reg.val);
+}
+
+static void imc_release(struct device *dev)
+{
+	edac_dbg(2, "imc device %s released\n", dev_name(dev));
+	kfree(dev);
+}
+
+static int __get_ddr_munits(struct res_config *cfg, struct skx_dev *d,
+			    bool north, int lmc)
+{
+	unsigned long size = cfg->ddr_chan_mmio_sz * cfg->ddr_chan_num;
+	unsigned long bitmap = get_imc_bitmap(cfg, d->pkg, north);
+	void __iomem *mbase;
+	struct device *dev;
+	int i, rc, pmc;
+	u64 base;
+
+	for_each_set_bit(i, &bitmap, sizeof(bitmap) * 8) {
+		base  = north ? d->mmio_base_h_north : d->mmio_base_h_south;
+		base += cfg->ddr_imc_base + size * i;
+
+		edac_dbg(2, "Pkg%d mc%d mmio base 0x%llx size 0x%lx\n",
+			 d->pkg, lmc, base, size);
+
+		/* Set up the imc MMIO. */
+		mbase = ioremap(base, size);
+		if (!mbase) {
+			imh_printk(KERN_ERR, "Failed to ioremap 0x%llx\n", base);
+			return -ENOMEM;
+		}
+
+		d->imc[lmc].mbase = mbase;
+		d->imc[lmc].lmc = lmc;
+
+		/* Create the imc device instance. */
+		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+		if (!dev)
+			return -ENOMEM;
+
+		dev->release = imc_release;
+		device_initialize(dev);
+		rc = dev_set_name(dev, "0x%llx", base);
+		if (rc) {
+			imh_printk(KERN_ERR, "Failed to set dev name\n");
+			put_device(dev);
+			return rc;
+		}
+
+		d->imc[lmc].dev = dev;
+
+		/* Set up the imc index mapping. */
+		pmc = north ? i : 8 + i;
+		skx_set_mc_mapping(d, pmc, lmc);
+
+		lmc++;
+	}
+
+	return lmc;
+}
+
+static bool get_ddr_munits(struct res_config *cfg, struct skx_dev *d)
+{
+	int lmc = __get_ddr_munits(cfg, d, true, 0);
+
+	if (lmc < 0)
+		return false;
+
+	lmc = __get_ddr_munits(cfg, d, false, lmc);
+	if (lmc <= 0)
+		return false;
+
+	return true;
+}
+
+static bool get_socket_id(struct res_config *cfg, struct skx_dev *d)
+{
+	DEFINE_LOCAL_REG(reg, cfg, d->pkg, true, ubox, 0, socket_id);
+	u8 src_id;
+	int i;
+
+	if (!read_local_reg(&reg))
+		return false;
+
+	src_id = SOCKET_ID(reg.val);
+	edac_dbg(2, "socket id 0x%x (reg 0x%llx)\n", src_id, reg.val);
+
+	for (i = 0; i < cfg->ddr_imc_num; i++)
+		d->imc[i].src_id   = src_id;
+
+	return true;
+}
+
+/* Get TOLM (Top Of Low Memory) and TOHM (Top Of High Memory) parameters. */
+static bool imh_get_tolm_tohm(struct res_config *cfg, u64 *tolm, u64 *tohm)
+{
+	DEFINE_LOCAL_REG(reg, cfg, 0, true, sca, 0, tolm);
+
+	if (!read_local_reg(&reg))
+		return false;
+
+	*tolm = TOLM(reg.val);
+	edac_dbg(2, "tolm 0x%llx (reg 0x%llx)\n", *tolm, reg.val);
+
+	DEFINE_LOCAL_REG(reg2, cfg, 0, true, sca, 0, tohm);
+
+	if (!read_local_reg(&reg2))
+		return false;
+
+	*tohm = TOHM(reg2.val);
+	edac_dbg(2, "tohm 0x%llx (reg 0x%llx)\n", *tohm, reg2.val);
+
+	return true;
+}
+
+/* Get the system-view MMIO_BASE_H for {north,south}-IMH. */
+static int imh_get_all_mmio_base_h(struct res_config *cfg, struct list_head *edac_list)
+{
+	int i, n = topology_max_packages(), imc_num = cfg->ddr_imc_num + cfg->hbm_imc_num;
+	struct skx_dev *d;
+
+	for (i = 0; i < n; i++) {
+		d = kzalloc(struct_size(d, imc, imc_num), GFP_KERNEL);
+		if (!d)
+			return -ENOMEM;
+
+		DEFINE_LOCAL_REG(reg, cfg, i, true, ubox, 0, mmio_base);
+
+		/* Get MMIO_BASE_H for the north-IMH. */
+		if (!read_local_reg(&reg) || !reg.val) {
+			kfree(d);
+			imh_printk(KERN_ERR, "Pkg%d has no north mmio_base_h\n", i);
+			return -ENODEV;
+		}
+
+		d->mmio_base_h_north = MMIO_BASE_H(reg.val);
+		edac_dbg(2, "Pkg%d north mmio_base_h 0x%llx (reg 0x%llx)\n",
+			 i, d->mmio_base_h_north, reg.val);
+
+		/* Get MMIO_BASE_H for the south-IMH (optional). */
+		DEFINE_LOCAL_REG(reg2, cfg, i, false, ubox, 0, mmio_base);
+
+		if (read_local_reg(&reg2)) {
+			d->mmio_base_h_south = MMIO_BASE_H(reg2.val);
+			edac_dbg(2, "Pkg%d south mmio_base_h 0x%llx (reg 0x%llx)\n",
+				 i, d->mmio_base_h_south, reg2.val);
+		}
+
+		d->pkg = i;
+		d->num_imc = imc_num;
+		skx_init_mc_mapping(d);
+		list_add_tail(&d->list, edac_list);
+	}
+
+	return 0;
+}
+
+/* Get the number of per-package memory controllers. */
+static int imh_get_imc_num(struct res_config *cfg)
+{
+	int imc_num = hweight32(get_imc_bitmap(cfg, 0, true)) +
+		      hweight32(get_imc_bitmap(cfg, 0, false));
+
+	if (!imc_num) {
+		imh_printk(KERN_ERR, "Invalid mc number\n");
+		return -ENODEV;
+	}
+
+	if (cfg->ddr_imc_num != imc_num) {
+		/*
+		 * Update the configuration data to reflect the number of
+		 * present DDR memory controllers.
+		 */
+		cfg->ddr_imc_num = imc_num;
+		edac_dbg(2, "Set ddr mc number %d\n", imc_num);
+	}
+
+	return 0;
+}
+
+/* Get all memory controllers' parameters. */
+static int imh_get_munits(struct res_config *cfg, struct list_head *edac_list)
+{
+	struct skx_imc *imc;
+	struct skx_dev *d;
+	u8 mc = 0;
+	int i;
+
+	list_for_each_entry(d, edac_list, list) {
+		if (!get_ddr_munits(cfg, d)) {
+			imh_printk(KERN_ERR, "No mc found\n");
+			return -ENODEV;
+		}
+
+		if (!get_socket_id(cfg, d)) {
+			imh_printk(KERN_ERR, "Failed to get socket id\n");
+			return -ENODEV;
+		}
+
+		for (i = 0; i < cfg->ddr_imc_num; i++) {
+			imc = &d->imc[i];
+			if (!imc->mbase)
+				continue;
+
+			imc->chan_mmio_sz = cfg->ddr_chan_mmio_sz;
+			imc->num_channels = cfg->ddr_chan_num;
+			imc->num_dimms    = cfg->ddr_dimm_num;
+			imc->mc		  = mc++;
+		}
+	}
+
+	return 0;
+}
+
+/* Helpers to read memory controller registers */
+static u64 read_imc_reg(struct skx_imc *imc, int chan, u32 offset, u8 width)
+{
+	return readx(imc->mbase + imc->chan_mmio_sz * chan + offset, width);
+}
+
+static u32 read_imc_mcmtr(struct res_config *cfg, struct skx_imc *imc, int chan)
+{
+	return (u32)read_imc_reg(imc, chan, cfg->ddr_reg_mcmtr_offset, cfg->ddr_reg_mcmtr_width);
+}
+
+static u32 read_imc_dimmmtr(struct res_config *cfg, struct skx_imc *imc, int chan, int dimm)
+{
+	return (u32)read_imc_reg(imc, chan, cfg->ddr_reg_dimmmtr_offset +
+				 cfg->ddr_reg_dimmmtr_width * dimm,
+				 cfg->ddr_reg_dimmmtr_width);
+}
+
+static bool ecc_enabled(u32 mcmtr)
+{
+	return (bool)ECC_ENABLED(mcmtr);
+}
+
+static bool dimm_populated(u32 dimmmtr)
+{
+	return (bool)DIMM_POPULATED(dimmmtr);
+}
+
+/* Get each DIMM's configurations of the memory controller @mci. */
+static int imh_get_dimm_config(struct mem_ctl_info *mci, struct res_config *cfg)
+{
+	struct skx_pvt *pvt = mci->pvt_info;
+	struct skx_imc *imc = pvt->imc;
+	struct dimm_info *dimm;
+	u32 mcmtr, dimmmtr;
+	int i, j, ndimms;
+
+	for (i = 0; i < imc->num_channels; i++) {
+		if (!imc->mbase)
+			continue;
+
+		mcmtr = read_imc_mcmtr(cfg, imc, i);
+
+		for (ndimms = 0, j = 0; j < imc->num_dimms; j++) {
+			dimmmtr = read_imc_dimmmtr(cfg, imc, i, j);
+			edac_dbg(1, "mcmtr 0x%x dimmmtr 0x%x (mc%d ch%d dimm%d)\n",
+				 mcmtr, dimmmtr, imc->mc, i, j);
+
+			if (!dimm_populated(dimmmtr))
+				continue;
+
+			dimm = edac_get_dimm(mci, i, j, 0);
+			ndimms += skx_get_dimm_info(dimmmtr, 0, 0, dimm,
+						    imc, i, j, cfg);
+		}
+
+		if (ndimms && !ecc_enabled(mcmtr)) {
+			imh_printk(KERN_ERR, "ECC is disabled on mc%d ch%d\n",
+				   imc->mc, i);
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+/* Register all memory controllers to the EDAC core. */
+static int imh_register_mci(struct res_config *cfg, struct list_head *edac_list)
+{
+	struct skx_imc *imc;
+	struct skx_dev *d;
+	int i, rc;
+
+	list_for_each_entry(d, edac_list, list) {
+		for (i = 0; i < cfg->ddr_imc_num; i++) {
+			imc = &d->imc[i];
+			if (!imc->mbase)
+				continue;
+
+			rc = skx_register_mci(imc, imc->dev,
+					      dev_name(imc->dev),
+					      "Intel IMH-based Socket",
+					      EDAC_MOD_STR,
+					      imh_get_dimm_config, cfg);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
+static struct res_config dmr_cfg = {
+	.type				= DMR,
+	.support_ddr5			= true,
+	.mmio_base_l_north		= 0xf6800000,
+	.mmio_base_l_south		= 0xf6000000,
+	.ddr_chan_num			= 1,
+	.ddr_dimm_num			= 2,
+	.ddr_imc_base			= 0x39b000,
+	.ddr_chan_mmio_sz		= 0x8000,
+	.ddr_reg_mcmtr_offset		= 0x360,
+	.ddr_reg_mcmtr_width		= 4,
+	.ddr_reg_dimmmtr_offset		= 0x370,
+	.ddr_reg_dimmmtr_width		= 4,
+	.ubox_base			= 0x0,
+	.ubox_size			= 0x2000,
+	.ubox_reg_mmio_base_offset	= 0x580,
+	.ubox_reg_mmio_base_width	= 4,
+	.ubox_reg_socket_id_offset	= 0x1080,
+	.ubox_reg_socket_id_width	= 4,
+	.pcu_base			= 0x3000,
+	.pcu_size			= 0x10000,
+	.pcu_reg_capid3_offset		= 0x290,
+	.pcu_reg_capid3_width		= 4,
+	.sca_base			= 0x24c000,
+	.sca_size			= 0x2500,
+	.sca_reg_tolm_offset		= 0x2100,
+	.sca_reg_tolm_width		= 8,
+	.sca_reg_tohm_offset		= 0x2108,
+	.sca_reg_tohm_width		= 8,
+};
+
+static const struct x86_cpu_id imh_cpuids[] = {
+	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X, &dmr_cfg),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, imh_cpuids);
+
+static struct notifier_block imh_mce_dec = {
+	.notifier_call	= skx_mce_check_error,
+	.priority	= MCE_PRIO_EDAC,
+};
+
+static int __init imh_init(void)
+{
+	const struct x86_cpu_id *id;
+	struct list_head *edac_list;
+	struct res_config *cfg;
+	const char *owner;
+	u64 tolm, tohm;
+	int rc;
+
+	edac_dbg(2, "\n");
+
+	if (ghes_get_devices())
+		return -EBUSY;
+
+	owner = edac_get_owner();
+	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+		return -EBUSY;
+
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return -ENODEV;
+
+	id = x86_match_cpu(imh_cpuids);
+	if (!id)
+		return -ENODEV;
+	cfg = (struct res_config *)id->driver_data;
+	skx_set_res_cfg(cfg);
+
+	if (!imh_get_tolm_tohm(cfg, &tolm, &tohm))
+		return -ENODEV;
+
+	skx_set_hi_lo(tolm, tohm);
+
+	rc = imh_get_imc_num(cfg);
+	if (rc < 0)
+		goto fail;
+
+	edac_list = skx_get_edac_list();
+
+	rc = imh_get_all_mmio_base_h(cfg, edac_list);
+	if (rc)
+		goto fail;
+
+	rc = imh_get_munits(cfg, edac_list);
+	if (rc)
+		goto fail;
+
+	rc = imh_register_mci(cfg, edac_list);
+	if (rc)
+		goto fail;
+
+	rc = skx_adxl_get();
+	if (rc)
+		goto fail;
+
+	opstate_init();
+	mce_register_decode_chain(&imh_mce_dec);
+
+	imh_printk(KERN_INFO, "%s\n", IMH_REVISION);
+
+	return 0;
+fail:
+	skx_remove();
+	return rc;
+}
+
+static void __exit imh_exit(void)
+{
+	edac_dbg(2, "\n");
+
+	mce_unregister_decode_chain(&imh_mce_dec);
+	skx_adxl_put();
+	skx_remove();
+}
+
+module_init(imh_init);
+module_exit(imh_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Qiuxu Zhuo");
+MODULE_DESCRIPTION("MC Driver for Intel servers using IMH-based memory controller");
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index e45abd0008ef..32a4ef27a987 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -124,7 +124,7 @@ void skx_adxl_put(void)
 }
 EXPORT_SYMBOL_GPL(skx_adxl_put);
 
-static void skx_init_mc_mapping(struct skx_dev *d)
+void skx_init_mc_mapping(struct skx_dev *d)
 {
 	/*
 	 * By default, the BIOS presents all memory controllers within each
@@ -135,6 +135,7 @@ static void skx_init_mc_mapping(struct skx_dev *d)
 	for (int i = 0; i < d->num_imc; i++)
 		d->imc[i].mc_mapping = i;
 }
+EXPORT_SYMBOL_GPL(skx_init_mc_mapping);
 
 void skx_set_mc_mapping(struct skx_dev *d, u8 pmc, u8 lmc)
 {
@@ -823,6 +824,9 @@ void skx_remove(void)
 			if (d->imc[i].mbase)
 				iounmap(d->imc[i].mbase);
 
+			if (d->imc[i].dev)
+				put_device(d->imc[i].dev);
+
 			for (j = 0; j < d->imc[i].num_channels; j++) {
 				if (d->imc[i].chan[j].cdev)
 					pci_dev_put(d->imc[i].chan[j].cdev);
@@ -846,7 +850,7 @@ EXPORT_SYMBOL_GPL(skx_remove);
 /*
  * Debug feature.
  * Exercise the address decode logic by writing an address to
- * /sys/kernel/debug/edac/{skx,i10nm}_test/addr.
+ * /sys/kernel/debug/edac/{skx,i10nm,imh}_test/addr.
  */
 static struct dentry *skx_test;
 
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 86a883d3c2a4..39a3462ede28 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -121,20 +121,33 @@ struct reg_rrl {
  * memory controllers on the die.
  */
 struct skx_dev {
-	struct list_head list;
+	/* {skx,i10nm}_edac */
 	u8 bus[4];
 	int seg;
 	struct pci_dev *sad_all;
 	struct pci_dev *util_all;
-	struct pci_dev *uracu; /* for i10nm CPU */
-	struct pci_dev *pcu_cr3; /* for HBM memory detection */
+	struct pci_dev *uracu;
+	struct pci_dev *pcu_cr3;
 	u32 mcroute;
+
+	/* imh_edac */
+	/* System-view MMIO base physical addresses. */
+	u64 mmio_base_h_north;
+	u64 mmio_base_h_south;
+	int pkg;
+
 	int num_imc;
+	struct list_head list;
 	struct skx_imc {
+		/* i10nm_edac */
+		struct pci_dev *mdev;
+
+		/* imh_edac */
+		struct device *dev;
+
 		struct mem_ctl_info *mci;
-		struct pci_dev *mdev; /* for i10nm CPU */
-		void __iomem *mbase;  /* for i10nm CPU */
-		int chan_mmio_sz;     /* for i10nm CPU */
+		void __iomem *mbase;
+		int chan_mmio_sz;
 		int num_channels; /* channels per memory controller */
 		int num_dimms; /* dimms per channel */
 		bool hbm_mc;
@@ -178,7 +191,8 @@ enum type {
 	SKX,
 	I10NM,
 	SPR,
-	GNR
+	GNR,
+	DMR,
 };
 
 enum {
@@ -237,10 +251,6 @@ struct pci_bdf {
 
 struct res_config {
 	enum type type;
-	/* Configuration agent device ID */
-	unsigned int decs_did;
-	/* Default bus number configuration register offset */
-	int busno_cfg_offset;
 	/* DDR memory controllers per socket */
 	int ddr_imc_num;
 	/* DDR channels per DDR memory controller */
@@ -258,23 +268,53 @@ struct res_config {
 	/* Per HBM channel memory-mapped I/O size */
 	int hbm_chan_mmio_sz;
 	bool support_ddr5;
-	/* SAD device BDF */
-	struct pci_bdf sad_all_bdf;
-	/* PCU device BDF */
-	struct pci_bdf pcu_cr3_bdf;
-	/* UTIL device BDF */
-	struct pci_bdf util_all_bdf;
-	/* URACU device BDF */
-	struct pci_bdf uracu_bdf;
-	/* DDR mdev device BDF */
-	struct pci_bdf ddr_mdev_bdf;
-	/* HBM mdev device BDF */
-	struct pci_bdf hbm_mdev_bdf;
-	int sad_all_offset;
 	/* RRL register sets per DDR channel */
 	struct reg_rrl *reg_rrl_ddr;
 	/* RRL register sets per HBM channel */
 	struct reg_rrl *reg_rrl_hbm[2];
+	union {
+		/* {skx,i10nm}_edac */
+		struct {
+			/* Configuration agent device ID */
+			unsigned int decs_did;
+			/* Default bus number configuration register offset */
+			int busno_cfg_offset;
+			struct pci_bdf sad_all_bdf;
+			struct pci_bdf pcu_cr3_bdf;
+			struct pci_bdf util_all_bdf;
+			struct pci_bdf uracu_bdf;
+			struct pci_bdf ddr_mdev_bdf;
+			struct pci_bdf hbm_mdev_bdf;
+			int sad_all_offset;
+		};
+		/* imh_edac */
+		struct {
+			/* MMIO base physical address in local package view */
+			u64 mmio_base_l_north;
+			u64 mmio_base_l_south;
+			u64 ddr_imc_base;
+			u64 ddr_reg_mcmtr_offset;
+			u8  ddr_reg_mcmtr_width;
+			u64 ddr_reg_dimmmtr_offset;
+			u8  ddr_reg_dimmmtr_width;
+			u64 ubox_base;
+			u32 ubox_size;
+			u32 ubox_reg_mmio_base_offset;
+			u8  ubox_reg_mmio_base_width;
+			u32 ubox_reg_socket_id_offset;
+			u8  ubox_reg_socket_id_width;
+			u64 pcu_base;
+			u32 pcu_size;
+			u32 pcu_reg_capid3_offset;
+			u8  pcu_reg_capid3_width;
+			u64 sca_base;
+			u32 sca_size;
+			u32 sca_reg_tolm_offset;
+			u8  sca_reg_tolm_width;
+			u32 sca_reg_tohm_offset;
+			u8  sca_reg_tohm_width;
+		};
+	};
 };
 
 typedef int (*get_dimm_config_f)(struct mem_ctl_info *mci,
@@ -287,6 +327,7 @@ void skx_adxl_put(void);
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log);
 void skx_set_mem_cfg(bool mem_cfg_2lm);
 void skx_set_res_cfg(struct res_config *cfg);
+void skx_init_mc_mapping(struct skx_dev *d);
 void skx_set_mc_mapping(struct skx_dev *d, u8 pmc, u8 lmc);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
-- 
2.43.0


