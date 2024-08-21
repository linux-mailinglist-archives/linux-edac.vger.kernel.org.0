Return-Path: <linux-edac+bounces-1704-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FA5959503
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 08:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD261C210F6
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF83DABF6;
	Wed, 21 Aug 2024 06:48:43 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E950121C192;
	Wed, 21 Aug 2024 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222923; cv=none; b=lw7eHqZw60NofrcRkHbEyHQ6zOESTuvFQYdmOMeMp+J6dWalKpQhYjecldoyiT936wSwzg4e9qMbx3yXit82tkYPy+0iqKENdOuK1yyiw5IT4AxRe35syutev9tXG2RpgD+IG7oRg2m04imyHqcfUtzeyzWc0Kc2WCg3iyCgfKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222923; c=relaxed/simple;
	bh=fQTyFTfS0xJcfuNBViPAYJRfqOmXNGXVTYpZvmBNFGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nf29fx10Cyl6CTQh9HDg0A/1DZaWyvYGkNB5dXqz8W4NDzqbt8MfqsfAPxCHy5N65bhlMdShDgeVxsjfTHC0TASSi9zvJ1ScmdfmiZaFLgWh9KXjhoglMVMRxAHqRJsNBY5WDMr8kdoRp8CCFTj6oxZP5beybLmFhiAlJId0iJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8Dx+5rGjcVmfekaAA--.21535S3;
	Wed, 21 Aug 2024 14:48:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front1 (Coremail) with SMTP id qMiowMAxVOCxjcVmQVQcAA--.59935S3;
	Wed, 21 Aug 2024 14:48:37 +0800 (CST)
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	devicetree@vger.kernel.org,
	zhaoqunqin <zhaoqunqin@loongson.cn>
Subject: [PATCH v1 1/2] Loongarch: EDAC driver for loongson memory controller
Date: Wed, 21 Aug 2024 14:47:27 +0800
Message-Id: <20240821064728.8642-2-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240821064728.8642-1-zhaoqunqin@loongson.cn>
References: <20240821064728.8642-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxVOCxjcVmQVQcAA--.59935S3
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxtr4UAryrWF43Xw17CF45urX_yoWxZFWDpF
	13Aw13Gr4rtr13uwsxArWDZF15Awsaqa9Fvay3A3yYk34DAryDZ34ktFy2yF9rCr98GrW3
	X3yrGa1kCFn8GrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8pWlPUUUUU==

From: zhaoqunqin <zhaoqunqin@loongson.cn>

Report single bit errors (CE) only

Signed-off-by: zhaoqunqin <zhaoqunqin@loongson.cn>
---
 arch/loongarch/Kconfig       |   2 +
 drivers/edac/Kconfig         |  10 ++
 drivers/edac/Makefile        |   1 +
 drivers/edac/loongson_edac.c | 208 +++++++++++++++++++++++++++++++++++
 4 files changed, 221 insertions(+)
 create mode 100644 drivers/edac/loongson_edac.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ddc042895..59d47053f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -179,6 +179,8 @@ config LOONGARCH
 	select PCI_QUIRKS
 	select PERF_USE_VMALLOC
 	select RTC_LIB
+	select EDAC_SUPPORT
+	select EDAC
 	select SPARSE_IRQ
 	select SYSCTL_ARCH_UNALIGN_ALLOW
 	select SYSCTL_ARCH_UNALIGN_NO_WARN
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 16c8de505..60b1997f0 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -573,5 +573,15 @@ config EDAC_VERSAL
 	  Support injecting both correctable and uncorrectable errors
 	  for debugging purposes.
 
+config EDAC_LOONGSON
+	tristate "Loongson EDAC"
+	depends on LOONGARCH
+	default m
+	help
+	  Support for error detection and correction on the loongson memory
+	  controller.
+
+	  Report single bit errors (CE) only.
+
 
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 4edfb83ff..d6f2cfe7e 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -89,3 +89,4 @@ obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
 obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
 obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
 obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
+obj-$(CONFIG_EDAC_LOONGSON)		+= loongson_edac.o
diff --git a/drivers/edac/loongson_edac.c b/drivers/edac/loongson_edac.c
new file mode 100644
index 000000000..c639c11ed
--- /dev/null
+++ b/drivers/edac/loongson_edac.c
@@ -0,0 +1,208 @@
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
+static long idx;
+
+struct loongson_edac_pvt {
+	volatile u64 *ecc_base;
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
+	/* Store the new values */
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
+	dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
+			0, 0, 0);
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
+	struct resource *rs;
+	struct mem_ctl_info *mci;
+	struct edac_mc_layer layers[2];
+	struct loongson_edac_pvt *pvt;
+	u64 *vbase = NULL;
+
+	rs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!rs)
+		return -EINVAL;
+	if (rs->start) {
+		vbase = devm_ioremap(&pdev->dev, rs->start, resource_size(rs));
+		if (!vbase)
+			return -ENOMEM;
+	}
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
+	edac_dbg(0, "MC: mci = %p\n", mci);
+
+	mci->mc_idx = idx++;
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
+	if (edac_mc_add_mc(mci)) {
+		edac_dbg(0, "MC: failed edac_mc_add_mc()\n");
+		edac_mc_free(mci);
+	}
+	return 0;
+}
+
+static int loongson_edac_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = edac_mc_del_mc(&pdev->dev);
+
+	if (mci) {
+		edac_mc_free(mci);
+		return 0;
+	}
+	return -ENODEV;
+}
+
+static const struct of_device_id loongson_edac_of_match[] = {
+	{ .compatible = "loongson,ls-mc-edac", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, loongson_edac_of_match);
+
+static struct platform_driver loongson_edac_driver = {
+	.probe		= loongson_edac_probe,
+	.remove		= loongson_edac_remove,
+	.driver		= {
+		.name	= "ls-mc-edac",
+		.owner = THIS_MODULE,
+		.of_match_table = loongson_edac_of_match,
+	},
+};
+
+static int __init loongson_edac_init(void)
+{
+	/* poll only */
+	edac_op_state = EDAC_OPSTATE_POLL;
+
+	return platform_driver_register(&loongson_edac_driver);
+}
+
+static void __exit loongson_edac_exit(void)
+{
+	platform_driver_unregister(&loongson_edac_driver);
+}
+
+module_init(loongson_edac_init);
+module_exit(loongson_edac_exit);
+module_param(edac_op_state, int, 0444);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Zhao Qunqin <zhaoqunqin@loongson.cn>\n");
+MODULE_DESCRIPTION("EDAC driver for loongson memory controller");
-- 
2.31.1


