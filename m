Return-Path: <linux-edac+bounces-2519-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8109C67C8
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 04:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1AC1F25FDF
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 03:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701CA168483;
	Wed, 13 Nov 2024 03:23:33 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224072231C;
	Wed, 13 Nov 2024 03:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731468213; cv=none; b=rs/NSBQySs4XU13Fwf32nVmyj2NFlVuVwFj7HEhcAIlcUocbAq3U257bG4bWAbK0TBfPeAyYQzPEPBNz9MSUyLimvsd5TMvNL7rNuoAWvUc3afzAo0gfHmzVYhHF18KWqwGYWzf3fIt8XEDaF2jxrZIcw4T8GAPQh2EP/BuveFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731468213; c=relaxed/simple;
	bh=jiElLTSf5+3HdH1u3b03iPhKJrCNq1z1FGndFDLmQmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X2i8IIPh0c8+dc1w2wesB/XdGDEc9VBk5Vs9qe+pIBuW9/ZA/lVKDWwDZHF/K/sEXU4dE8IS0QfuL+msnc/IT6E5olhawrt+A/t59NXnimAxlUDz3o9RrYk7f1CAtb/2IKS2GVia0psKJNW4Vb47XnORPsGjHB7qIvPnFaooddQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8Cx766wGzRnJ348AA--.15422S3;
	Wed, 13 Nov 2024 11:23:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front1 (Coremail) with SMTP id qMiowMBx30euGzRnvYZTAA--.14877S2;
	Wed, 13 Nov 2024 11:23:26 +0800 (CST)
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	xry111@xry111.site,
	Markus.Elfring@web.de,
	krzk@kernel.org,
	Zhao Qunqin <zhaoqunqin@loongson.cn>
Subject: [PATCH V8] EDAC: Add EDAC driver for loongson memory controller
Date: Wed, 13 Nov 2024 11:23:26 +0800
Message-Id: <20241113032326.14267-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx30euGzRnvYZTAA--.14877S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxtr1kGFyDGr1kWFyxGrW3Arc_yoW3JFyfpF
	45Aw13Gr4xKr43uws3ArWUuF15uws7Ka42v3y7A3yY93srAryDXryktFW2yFnrCrWkJrW3
	Xa4rKw4DCF4UGwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

Add ECC support for Loongson SoC DDR controller. This
driver reports single bit errors (CE) only.

Only ACPI firmware is supported.

Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
---
Changes in v8:
	- Used readl() instead of readq()
	- Used acpi_device_id instead of of_device_id, then removed
	  dt-bindings

Changes in v7:
       	- Fixed sparse's "incorrect type in assignment"
	- Cleaned up coding style

Changes in v6:
	- Changed the Kconfig name to CONFIG_EDAC_LOONGSON

Changes in v5:
	- Dropepd the loongson_ prefix from all static functions.
	- Aligned function arguments on the opening brace.
	- Dropepd useless comments and useless wrapper. Dropped side
	  comments.
	- Reordered variable declarations.

Changes in v4:
	- None

Changes in v3:
	- Addressed review comments raised by Krzysztof and Huacai

Changes in v2:
	- Addressed review comments raised by Krzysztof

 MAINTAINERS                  |   6 ++
 arch/loongarch/Kconfig       |   1 +
 drivers/edac/Kconfig         |   8 ++
 drivers/edac/Makefile        |   1 +
 drivers/edac/loongson_edac.c | 155 +++++++++++++++++++++++++++++++++++
 5 files changed, 171 insertions(+)
 create mode 100644 drivers/edac/loongson_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e9659a5a7..b36a45051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13397,6 +13397,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
 F:	drivers/thermal/loongson2_thermal.c
 
+LOONGSON EDAC DRIVER
+M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	drivers/edac/loongson_edac.c
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index bb35c34f8..10b9ba587 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -185,6 +185,7 @@ config LOONGARCH
 	select PCI_MSI_ARCH_FALLBACKS
 	select PCI_QUIRKS
 	select PERF_USE_VMALLOC
+	select EDAC_SUPPORT
 	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_ARCH_UNALIGN_ALLOW
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 81af6c344..4dce2b92a 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -564,5 +564,13 @@ config EDAC_VERSAL
 	  Support injecting both correctable and uncorrectable errors
 	  for debugging purposes.
 
+config EDAC_LOONGSON
+	tristate "Loongson Memory Controller"
+	depends on (LOONGARCH && ACPI) || COMPILE_TEST
+	help
+	  Support for error detection and correction on the Loongson
+	  family memory controller. This driver reports single bit
+	  errors (CE) only. Loongson-3A5000/3C5000/3D5000/3A6000/3C6000
+	  are compatible.
 
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index faf310eec..f8bdbc895 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
 obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
 obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
 obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
+obj-$(CONFIG_EDAC_LOONGSON)		+= loongson_edac.o
diff --git a/drivers/edac/loongson_edac.c b/drivers/edac/loongson_edac.c
new file mode 100644
index 000000000..340722db1
--- /dev/null
+++ b/drivers/edac/loongson_edac.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Loongson Technology Corporation Limited.
+ */
+
+#include <linux/acpi.h>
+#include <linux/edac.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include "edac_module.h"
+
+#define ECC_CS_COUNT_REG	0x18
+
+struct loongson_edac_pvt {
+	void __iomem *ecc_base;
+	int last_ce_count;
+};
+
+static int read_ecc(struct mem_ctl_info *mci)
+{
+	struct loongson_edac_pvt *pvt = mci->pvt_info;
+	u32 ecc;
+	int cs;
+
+	if (!pvt->ecc_base)
+		return pvt->last_ce_count;
+
+	ecc = readl(pvt->ecc_base + ECC_CS_COUNT_REG);
+	/* cs0 -- cs3 */
+	cs = ecc & 0xff;
+	cs += (ecc >> 8) & 0xff;
+	cs += (ecc >> 16) & 0xff;
+	cs += (ecc >> 24) & 0xff;
+
+	return cs;
+}
+
+static void edac_check(struct mem_ctl_info *mci)
+{
+	struct loongson_edac_pvt *pvt = mci->pvt_info;
+	int new, add;
+
+	new = read_ecc(mci);
+	add = new - pvt->last_ce_count;
+	pvt->last_ce_count = new;
+	if (add <= 0)
+		return;
+
+	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, add,
+			     0, 0, 0, 0, 0, -1, "error", "");
+	edac_mc_printk(mci, KERN_INFO, "add: %d", add);
+}
+
+static void dimm_config_init(struct mem_ctl_info *mci)
+{
+	struct dimm_info *dimm;
+	u32 size, npages;
+
+	/* size not used */
+	size = -1;
+	npages = MiB_TO_PAGES(size);
+
+	dimm = edac_get_dimm(mci, 0, 0, 0);
+	dimm->nr_pages = npages;
+	snprintf(dimm->label, sizeof(dimm->label),
+		 "MC#%uChannel#%u_DIMM#%u", mci->mc_idx, 0, 0);
+	dimm->grain = 8;
+}
+
+static void pvt_init(struct mem_ctl_info *mci, void __iomem *vbase)
+{
+	struct loongson_edac_pvt *pvt = mci->pvt_info;
+
+	pvt->ecc_base = vbase;
+	pvt->last_ce_count = read_ecc(mci);
+}
+
+static int edac_probe(struct platform_device *pdev)
+{
+	struct edac_mc_layer layers[2];
+	struct mem_ctl_info *mci;
+	void __iomem *vbase;
+	int ret;
+
+	vbase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(vbase))
+		return PTR_ERR(vbase);
+
+	/* allocate a new MC control structure */
+	layers[0].type = EDAC_MC_LAYER_CHANNEL;
+	layers[0].size = 1;
+	layers[0].is_virt_csrow = false;
+	layers[1].type = EDAC_MC_LAYER_SLOT;
+	layers[1].size = 1;
+	layers[1].is_virt_csrow = true;
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
+			    sizeof(struct loongson_edac_pvt));
+	if (mci == NULL)
+		return -ENOMEM;
+
+	mci->mc_idx = edac_device_alloc_index();
+	mci->mtype_cap = MEM_FLAG_RDDR4;
+	mci->edac_ctl_cap = EDAC_FLAG_NONE;
+	mci->edac_cap = EDAC_FLAG_NONE;
+	mci->mod_name = "loongson_edac.c";
+	mci->ctl_name = "loongson_edac_ctl";
+	mci->dev_name = "loongson_edac_dev";
+	mci->ctl_page_to_phys = NULL;
+	mci->pdev = &pdev->dev;
+	mci->error_desc.grain = 8;
+	/* Set the function pointer to an actual operation function */
+	mci->edac_check = edac_check;
+
+	pvt_init(mci, vbase);
+	dimm_config_init(mci);
+
+	ret = edac_mc_add_mc(mci);
+	if (ret) {
+		edac_dbg(0, "MC: failed edac_mc_add_mc()\n");
+		edac_mc_free(mci);
+		return ret;
+	}
+	edac_op_state = EDAC_OPSTATE_POLL;
+
+	return 0;
+}
+
+static void edac_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = edac_mc_del_mc(&pdev->dev);
+
+	if (mci)
+		edac_mc_free(mci);
+}
+
+static const struct acpi_device_id loongson_edac_acpi_match[] = {
+	{"LOON000G", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, loongson_edac_acpi_match);
+
+static struct platform_driver loongson_edac_driver = {
+	.probe		= edac_probe,
+	.remove		= edac_remove,
+	.driver		= {
+		.name	= "loongson-mc-edac",
+		.acpi_match_table = loongson_edac_acpi_match,
+	},
+};
+module_platform_driver(loongson_edac_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Zhao Qunqin <zhaoqunqin@loongson.cn>");
+MODULE_DESCRIPTION("EDAC driver for loongson memory controller");

base-commit: e14232afa94445e03fc3a0291b07a68f3408c120
-- 
2.43.0


