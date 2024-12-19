Return-Path: <linux-edac+bounces-2746-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFCE9F7BCE
	for <lists+linux-edac@lfdr.de>; Thu, 19 Dec 2024 13:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979C2163A82
	for <lists+linux-edac@lfdr.de>; Thu, 19 Dec 2024 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB62223C7F;
	Thu, 19 Dec 2024 12:48:58 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D272236FE;
	Thu, 19 Dec 2024 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734612538; cv=none; b=jqynRXGk6H4hIshnJabrmKynRt7ib+FZWrZrOgsgz3LsI4gQknv5f1SqBrAMkEfMhKF+tMp4WLn6U3rWXQKeWzHfVooltFGTkBFT9rk64b9nh24eSlS5IV7qjaECvu1hArMWBryv4m1SBJ6dMbXz2HCyVZ/diWSf4QPgiuWrsmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734612538; c=relaxed/simple;
	bh=SUJh2J52I7Va85yiCI6niwZdWang6L2hrljs4Zze7fA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G8FEFcP01yNzEy3MoQK1s66VsrLVTJs4hylxvBz8gPANYXbmmlKd5I910tcke2zoEVDJ6pnrRetTOvQyJso37m7o0wC0F8hgbhKhP3Syd9M8PhGaku3nEd3t2iNY8BJdZ+CzKlInrhvb1rWiN5DHlZTbIH06Jlb0iehdFYz8eNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8BxuuAzFmRng45YAA--.43901S3;
	Thu, 19 Dec 2024 20:48:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front1 (Coremail) with SMTP id qMiowMCxbccxFmRnx2cCAA--.14834S2;
	Thu, 19 Dec 2024 20:48:49 +0800 (CST)
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
To: bp@alien8.de
Cc: chenhuacai@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@xen0n.name,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	loongarch@lists.linux.dev,
	xry111@xry111.site,
	Markus.Elfring@web.de,
	Jonathan.Cameron@Huawei.com,
	Zhao Qunqin <zhaoqunqin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V11] EDAC: Add EDAC driver for loongson memory controller
Date: Thu, 19 Dec 2024 20:48:46 +0800
Message-Id: <20241219124846.1876-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxbccxFmRnx2cCAA--.14834S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxtr1kGFyDGr1kGFWkKFW3urX_yoW3GF4DpF
	45Cw1fGr48Kr43Can3ArWUuF15uwsa9a42vFW7A3yj93srAryDXr97tFW2yFnrCrWDtrW3
	Xa4fCw4DCF4UGwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

Add ECC support for Loongson SoC DDR controller. This
driver reports single bit errors (CE) only.

Only ACPI firmware is supported.

Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
Changes in v11:
	- Removed useless comments 
	- Removed the check for whether ecc_base is NULL
	- Removed COMPILE_TEST cause there may be build errors
	  on other arches

Changes in v10:
	- Changed acpi_device_id to "LOON0010"

Changes in v9:
	- Still using readq() and included "linux/io-64-nonatomic-lo-hi.h"
	  to avoid the compiler's waring.
	- Used alpha-betical order when selecting symbol and including
	  header file.

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

 MAINTAINERS                  |   6 ++
 arch/loongarch/Kconfig       |   1 +
 drivers/edac/Kconfig         |   8 ++
 drivers/edac/Makefile        |   1 +
 drivers/edac/loongson_edac.c | 150 +++++++++++++++++++++++++++++++++++
 5 files changed, 166 insertions(+)
 create mode 100644 drivers/edac/loongson_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 17daa9ee9..4adedd051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13544,6 +13544,12 @@ S:	Maintained
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
index dae3a9104..28acd0b04 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -81,6 +81,7 @@ config LOONGARCH
 	select BUILDTIME_TABLE_SORT
 	select COMMON_CLK
 	select CPU_PM
+	select EDAC_SUPPORT
 	select EFI
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 06f7b43a6..0d0017607 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -546,5 +546,13 @@ config EDAC_VERSAL
 	  Support injecting both correctable and uncorrectable errors
 	  for debugging purposes.
 
+config EDAC_LOONGSON
+	tristate "Loongson Memory Controller"
+	depends on LOONGARCH && ACPI
+	help
+	  Support for error detection and correction on the Loongson
+	  family memory controller. This driver reports single bit
+	  errors (CE) only. Loongson-3A5000/3C5000/3D5000/3A6000/3C6000
+	  are compatible.
 
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index f9cf19d8d..bb980ec63 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -86,3 +86,4 @@ obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
 obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
 obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
 obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
+obj-$(CONFIG_EDAC_LOONGSON)		+= loongson_edac.o
diff --git a/drivers/edac/loongson_edac.c b/drivers/edac/loongson_edac.c
new file mode 100644
index 000000000..e267b526b
--- /dev/null
+++ b/drivers/edac/loongson_edac.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Loongson Technology Corporation Limited.
+ */
+
+#include <linux/acpi.h>
+#include <linux/edac.h>
+#include <linux/init.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/module.h>
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
+	u64 ecc;
+	int cs;
+
+	ecc = readq(pvt->ecc_base + ECC_CS_COUNT_REG);
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
+	{"LOON0010", 0},
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

base-commit: 584e09743d2f44905290b0dbf3215064d2a1888c
-- 
2.43.0


