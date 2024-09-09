Return-Path: <linux-edac+bounces-1827-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4271F970C39
	for <lists+linux-edac@lfdr.de>; Mon,  9 Sep 2024 05:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476BE1C21A48
	for <lists+linux-edac@lfdr.de>; Mon,  9 Sep 2024 03:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EF31AD40B;
	Mon,  9 Sep 2024 03:21:14 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E9C1ACE0B;
	Mon,  9 Sep 2024 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725852074; cv=none; b=fvJXxIPMYuXkq2iYBuX+M+VEy9jaSZtvNz0OoMNCGS8qR5+p0XVf51P2Xq68jkpLmGCnOnglxQP0fzGf8k6o7YH74iQ7KryZsUY+oWrvjS5JtYTZ1kb2LZQebtFqPG2B03Dwj/p1lkNOjR4DXZe60GIHQv0blC/yiU7ieUNKSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725852074; c=relaxed/simple;
	bh=H+ZS4lg2H5C9qRvzSTwqkM9WUFK9+XGek6UF4OvGkqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YpaFqJmWd2vKVvpZuLiKg8zVG4BXhziQ4/NefWP6uanwZn6P/0TK7PAjhV6nSqenAnVpnFtuDEhs74KuNfMl2b9E8rs8CuQEQ0nHkxHeqwGHgJJOGlEmk1Ewql3b+a5bCiTv3mC+/+H0FELIZB9IIBqGgfiCWrJumRXZtzA3VnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8Cxheilad5mFG8CAA--.4652S3;
	Mon, 09 Sep 2024 11:21:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front2 (Coremail) with SMTP id qciowMAxa8adad5msCkCAA--.9833S4;
	Mon, 09 Sep 2024 11:21:06 +0800 (CST)
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
Subject: [PATCH v4 2/2] Loongarch: EDAC driver for loongson memory controller
Date: Mon,  9 Sep 2024 11:21:24 +0800
Message-Id: <20240909032124.18819-3-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240909032124.18819-1-zhaoqunqin@loongson.cn>
References: <20240909032124.18819-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qciowMAxa8adad5msCkCAA--.9833S4
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3ArWUXr18Kr45Jr1DJw1xCrX_yoWxuw47pr
	13A3WfGrWxtr13uws3ArWDuF1Yywsava429ay3A3yY9r98AryDZ3s5tFy2yFsrCrykJrW3
	Xa4rGw4kCF4UGwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

Reports single bit errors (CE) only.

Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
---
Changes in v4:
        - None

Changes in v3:
        - Addressed review comments raised by Krzysztof and Huacai

Changes in v2:
        - Addressed review comments raised by Krzysztof

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
index 81af6c344..719bb6ca7 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -564,5 +564,13 @@ config EDAC_VERSAL
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
index faf310eec..e72ca1be4 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
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


