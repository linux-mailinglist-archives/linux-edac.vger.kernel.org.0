Return-Path: <linux-edac+bounces-1794-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36393969C57
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 13:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8388DB24D54
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 11:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DC31CB539;
	Tue,  3 Sep 2024 11:46:58 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE91B9832;
	Tue,  3 Sep 2024 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364018; cv=none; b=dIisBitpZNp13FZYar7XWoybYITWnyli6UoOjNwChfHAB67142szj6kvcksKqGYDd5wWwSzgiqzbPJmZmqxdCxteZXRTXaSsURsEayr2DQn2x0b9gXZXMr6YttkSZsM7R88Xdz6QlLHv964cqCDOv/ehZNBbp5aBWT6KtRZgM8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364018; c=relaxed/simple;
	bh=CauLRKl4IZMp81aR69sHirfUgGb4Iz8K/McsZya+AOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1ReWCj79TA10bxBjMn3maJTspkIpd0XVqkRNjfjngpjeCBVHvBiC+OReim9lPkqLnzV6iuic46rqIGDjNNULlQfz+J4uUa1iDwdN1APV3uIlPur3J3Zvq9SAdA9rYHWzG/l1/WJD9vZ1Z58hP4KMMrNjFflXj+uNF+yeCjFoh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8Bxa+ov99ZmNiUpAA--.14512S3;
	Tue, 03 Sep 2024 19:46:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front2 (Coremail) with SMTP id qciowMAxvsUr99ZmONYEAA--.13062S4;
	Tue, 03 Sep 2024 19:46:54 +0800 (CST)
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	chenhuacai@kernel.org
Cc: linux-edac@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@xen0n.name,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	loongarch@lists.linux.dev,
	Zhao Qunqin <zhaoqunqin@loongson.cn>
Subject: [PATCH V3 2/2] Loongarch: EDAC driver for loongson memory controller
Date: Tue,  3 Sep 2024 19:47:14 +0800
Message-Id: <20240903114714.11428-3-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240903114714.11428-1-zhaoqunqin@loongson.cn>
References: <20240903114714.11428-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qciowMAxvsUr99ZmONYEAA--.13062S4
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3ArWUXr18Kr45Jr1DJw15KFX_yoWxZFy5pr
	13A3W3GrWftr13uws3ArWDuF1Yyw4Sva42kay3A3yjkr9xAryDZ34ktFy2yFnrCryDJrW3
	X34rGw4UCF4UGrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUJ529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUhGNtUUUUU

Reports single bit errors (CE) only.

Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
---
 MAINTAINERS                  |   1 +
 arch/loongarch/Kconfig       |   1 +
 drivers/edac/Kconfig         |   8 ++
 drivers/edac/Makefile        |   1 +
 drivers/edac/loongson_edac.c | 182 +++++++++++++++++++++++++++++++++++
 5 files changed, 193 insertions(+)
 create mode 100644 drivers/edac/loongson_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6cc8cfc8f..5b4526638 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13242,6 +13242,7 @@ M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml
+F:	drivers/edac/loongson_edac.c
 
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 70f169210..9c135f1a2 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -181,6 +181,7 @@ config LOONGARCH
 	select PCI_MSI_ARCH_FALLBACKS
 	select PCI_QUIRKS
 	select PERF_USE_VMALLOC
+	select EDAC_SUPPORT
 	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_ARCH_UNALIGN_ALLOW
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 16c8de505..1193e92f6 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -573,5 +573,13 @@ config EDAC_VERSAL
 	  Support injecting both correctable and uncorrectable errors
 	  for debugging purposes.
 
+config EDAC_LOONGSON3
+	tristate "Loongson-3 Memory Controller"
+	depends on LOONGARCH || COMPILE_TEST
+	help
+	  Support for error detection and correction on the Loongson-3
+	  family memory controller. This driver reports single bit
+	  errors (CE) only. Loongson-3A5000/3C5000/3D5000/3C5000L/3A6000/3C6000
+	  are compatible.
 
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 4edfb83ff..7d04ac43d 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -89,3 +89,4 @@ obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
 obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
 obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
 obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
+obj-$(CONFIG_EDAC_LOONGSON3)		+= loongson_edac.o
diff --git a/drivers/edac/loongson_edac.c b/drivers/edac/loongson_edac.c
new file mode 100644
index 000000000..b89d6e0e7
--- /dev/null
+++ b/drivers/edac/loongson_edac.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Loongson Technology Corporation Limited.
+ */
+
+#include <linux/edac.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include "edac_module.h"
+
+enum ecc_index {
+	ECC_SET = 0,
+	ECC_RESERVED,
+	ECC_COUNT,
+	ECC_CS_COUNT,
+	ECC_CODE,
+	ECC_ADDR,
+	ECC_DATA0,
+	ECC_DATA1,
+	ECC_DATA2,
+	ECC_DATA3,
+};
+
+struct loongson_edac_pvt {
+	u64 *ecc_base;
+	int last_ce_count;
+};
+
+static void loongson_update_ce_count(struct mem_ctl_info *mci,
+					int chan,
+					int new)
+{
+	int add;
+	struct loongson_edac_pvt *pvt = mci->pvt_info;
+
+	add = new - pvt->last_ce_count;
+
+	/* Store the new value */
+	pvt->last_ce_count = new;
+
+	/* device resume or any other exceptions*/
+	if (add < 0)
+		return;
+
+	/*updated the edac core */
+	if (add != 0) {
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, add,
+					0, 0, 0,
+					chan, 0, -1, "error", "");
+		edac_mc_printk(mci, KERN_INFO, "add: %d", add);
+	}
+}
+
+static int loongson_read_ecc(struct mem_ctl_info *mci)
+{
+	u64 ecc;
+	int cs = 0;
+	struct loongson_edac_pvt *pvt = mci->pvt_info;
+
+	if (!pvt->ecc_base)
+		return pvt->last_ce_count;
+
+	ecc = pvt->ecc_base[ECC_CS_COUNT];
+	cs += ecc & 0xff;		// cs0
+	cs += (ecc >> 8) & 0xff;	// cs1
+	cs += (ecc >> 16) & 0xff;	// cs2
+	cs += (ecc >> 24) & 0xff;	// cs3
+
+	return cs;
+}
+
+static void loongson_edac_check(struct mem_ctl_info *mci)
+{
+	loongson_update_ce_count(mci, 0, loongson_read_ecc(mci));
+}
+
+static int get_dimm_config(struct mem_ctl_info *mci)
+{
+	u32 size, npages;
+	struct dimm_info *dimm;
+
+	/* size not used */
+	size = -1;
+	npages = MiB_TO_PAGES(size);
+
+	dimm = edac_get_dimm(mci, 0, 0, 0);
+	dimm->nr_pages = npages;
+	snprintf(dimm->label, sizeof(dimm->label),
+			"MC#%uChannel#%u_DIMM#%u",
+			mci->mc_idx, 0, 0);
+	dimm->grain = 8;
+
+	return 0;
+}
+
+static void loongson_pvt_init(struct mem_ctl_info *mci, u64 *vbase)
+{
+	struct loongson_edac_pvt *pvt = mci->pvt_info;
+
+	pvt->ecc_base = vbase;
+	pvt->last_ce_count = loongson_read_ecc(mci);
+}
+
+static int loongson_edac_probe(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci;
+	struct edac_mc_layer layers[2];
+	struct loongson_edac_pvt *pvt;
+	u64 *vbase = NULL;
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
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt));
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
+	mci->edac_check = loongson_edac_check;
+
+	loongson_pvt_init(mci, vbase);
+	get_dimm_config(mci);
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
+static void loongson_edac_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = edac_mc_del_mc(&pdev->dev);
+
+	if (mci)
+		edac_mc_free(mci);
+}
+
+static const struct of_device_id loongson_edac_of_match[] = {
+	{ .compatible = "loongson,ls3a5000-mc-edac", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, loongson_edac_of_match);
+
+static struct platform_driver loongson_edac_driver = {
+	.probe		= loongson_edac_probe,
+	.remove		= loongson_edac_remove,
+	.driver		= {
+		.name	= "loongson-mc-edac",
+		.of_match_table = loongson_edac_of_match,
+	},
+};
+module_platform_driver(loongson_edac_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Zhao Qunqin <zhaoqunqin@loongson.cn>");
+MODULE_DESCRIPTION("EDAC driver for loongson memory controller");
-- 
2.43.0


