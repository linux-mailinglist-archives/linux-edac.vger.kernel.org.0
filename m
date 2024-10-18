Return-Path: <linux-edac+bounces-2135-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFD89A3232
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 03:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C6E1C22A0E
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 01:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0AD13A244;
	Fri, 18 Oct 2024 01:45:44 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F472E64A;
	Fri, 18 Oct 2024 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215944; cv=none; b=LFgLCpXhuGYNyQvsJy0mWWtj8s93gS2PM3T5tH+v8KvalUymXdEiiXw3LxkfzUg7rRYaqfCAmKS2N5BYW46an7mft4MQlWJ5Hiq2d9KUT0YWBGiN26CMKXtmGzOKeWHXRpcOaieiUlFmSVE3xJyYfyWIvtkLtx+g6fAIXZcPVpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215944; c=relaxed/simple;
	bh=ExdNWHNzkd5pS53sl8d0jjJJ/SMyEYWzXyVEg3EQa7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9cl9htXYyuZt1vT/gsC8J3RSxfcE0cerqpFtFengaRJpbtWVlL5rNYYThb9NWkhzP63yhQjsWDYcQHnZ7FTLttwOTGX/UgY4/d0nOv4JAYI+AEROB0TcVGx4dA4ImZ+tawz705CKextkY+i6mjZu/XPGH8+nn/CTI6HGVNqI2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8Bx22rDvRFnUjcjAA--.51174S3;
	Fri, 18 Oct 2024 09:45:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front2 (Coremail) with SMTP id qciowMCxSsa7vRFngI0yAA--.18897S4;
	Fri, 18 Oct 2024 09:45:38 +0800 (CST)
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	chenhuacai@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org
Cc: linux-edac@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev,
	Jonathan.Cameron@Huawei.com,
	Zhao Qunqin <zhaoqunqin@loongson.cn>
Subject: [PATCH v6 RESEND 2/2] EDAC: Add EDAC driver for loongson memory controller
Date: Fri, 18 Oct 2024 09:45:42 +0800
Message-Id: <20241018014542.27283-3-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241018014542.27283-1-zhaoqunqin@loongson.cn>
References: <20241018014542.27283-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qciowMCxSsa7vRFngI0yAA--.18897S4
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3ArWUXr18Kr45Jr1fKFy5ZFc_yoWxur13pF
	15Aw1fGrW8tr13uws3ZrWUuF15Cws2ga42y3y3A3yY93srAryDZr95tFy2yFnrCrykGrW3
	Xa4rKw4DuF4DGwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
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
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

Reports single bit errors (CE) only.

Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
---
Changes in v6:
	- Change the Kconfig name to CONFIG_EDAC_LOONGSON

Changes in v5:
	- Drop the loongson_ prefix from all static functions.
	- Align function arguments on the opening brace.
	- Drop useless comments and useless wrapper. Drop side comments.
	- Reorder variable declarations.

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
 drivers/edac/loongson_edac.c | 168 +++++++++++++++++++++++++++++++++++
 5 files changed, 179 insertions(+)
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
index 81af6c344..1cf432102 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -564,5 +564,13 @@ config EDAC_VERSAL
 	  Support injecting both correctable and uncorrectable errors
 	  for debugging purposes.
 
+config EDAC_LOONGSON
+	tristate "Loongson Memory Controller"
+	depends on LOONGARCH || COMPILE_TEST
+	help
+	  Support for error detection and correction on the Loongson
+	  family memory controller. This driver reports single bit
+	  errors (CE) only. Loongson-3A5000/3C5000/3D5000/3C5000L/3A6000/3C6000
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
index 000000000..2721dfba5
--- /dev/null
+++ b/drivers/edac/loongson_edac.c
@@ -0,0 +1,168 @@
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
+static int read_ecc(struct mem_ctl_info *mci)
+{
+	struct loongson_edac_pvt *pvt = mci->pvt_info;
+	u64 ecc;
+	int cs;
+
+	if (!pvt->ecc_base)
+		return pvt->last_ce_count;
+
+	ecc = pvt->ecc_base[ECC_CS_COUNT];
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
+static int get_dimm_config(struct mem_ctl_info *mci)
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
+
+	return 0;
+}
+
+static void pvt_init(struct mem_ctl_info *mci, u64 *vbase)
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
+	struct loongson_edac_pvt *pvt;
+	struct mem_ctl_info *mci;
+	u64 *vbase;
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
+	mci->edac_check = edac_check;
+
+	pvt_init(mci, vbase);
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
+static void edac_remove(struct platform_device *pdev)
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
+	.probe		= edac_probe,
+	.remove		= edac_remove,
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


