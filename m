Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8652814D168
	for <lists+linux-edac@lfdr.de>; Wed, 29 Jan 2020 20:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgA2Tvd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 Jan 2020 14:51:33 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:45587 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgA2Tvd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 29 Jan 2020 14:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580327493; x=1611863493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=TbB+jBt8mnZXZ2q7mxRA2aBOSfZD6RHSVrjulqcbQVQ=;
  b=F1MCISvZ+LDAPC+jLsbvJfK9W+vQ2Ogx2TzRmSt3qVAv3Zkz++IlDe+R
   PrcACPvG8BZkvUrFDDaDLrP6vxUUBO/9kPvV+ep9ybqXBWPyN+sUTkK4B
   XU4LK7TtJso29TmdAiWoRz0PmaXTY2/eQrzjjSuRnw8wJa02MvTo91mY9
   w=;
IronPort-SDR: F1IH8FOrrH0Q8S93xJqtUlJ54a/HBRkX40YN/9VTUqRzWsQ1JQGOgTCahFT/Tqq2wsUJikyJNd
 HbjqeyKGYfCQ==
X-IronPort-AV: E=Sophos;i="5.70,379,1574121600"; 
   d="scan'208";a="13482775"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 29 Jan 2020 19:51:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id D22E5A1E3A;
        Wed, 29 Jan 2020 19:51:02 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 29 Jan 2020 19:51:02 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.50) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 Jan 2020 19:50:51 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rrichter@marvell.com>, <hhhawa@amazon.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <Jonathan.Cameron@huawei.com>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v9 1/3] edac: Add support for Amazon's Annapurna Labs L1 EDAC
Date:   Wed, 29 Jan 2020 21:50:14 +0200
Message-ID: <20200129195016.956-2-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129195016.956-1-hhhawa@amazon.com>
References: <20200129195016.956-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.50]
X-ClientProxiedBy: EX13D13UWB003.ant.amazon.com (10.43.161.233) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Adds support for Amazon's Annapurna Labs L1 EDAC driver to detect and
report L1 errors.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 MAINTAINERS               |   5 +
 drivers/edac/Kconfig      |   8 ++
 drivers/edac/Makefile     |   1 +
 drivers/edac/al_l1_edac.c | 207 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 221 insertions(+)
 create mode 100644 drivers/edac/al_l1_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bd5847e802de..649ff0d314e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -763,6 +763,11 @@ F:	drivers/tty/serial/altera_jtaguart.c
 F:	include/linux/altera_uart.h
 F:	include/linux/altera_jtaguart.h
 
+AMAZON ANNAPURNA LABS L1 EDAC
+M:	Hanna Hawa <hhhawa@amazon.com>
+S:	Maintained
+F:	drivers/edac/al_l1_edac.c
+
 AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
 M:	Talel Shenhar <talel@amazon.com>
 S:	Maintained
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 37027c298323..0ea9439749ab 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -74,6 +74,14 @@ config EDAC_GHES
 
 	  In doubt, say 'Y'.
 
+config EDAC_AL_L1
+	tristate "Amazon's Annapurna Labs L1 EDAC"
+	depends on ARM64 && (ARCH_ALPINE || COMPILE_TEST)
+	help
+	  Support for L1 error detection and correction
+	  for Amazon's Annapurna Labs SoCs.
+	  This driver detects errors of L1 caches.
+
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index d77200c9680b..7d67433b683a 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_EDAC_GHES)			+= ghes_edac.o
 edac_mce_amd-y				:= mce_amd.o
 obj-$(CONFIG_EDAC_DECODE_MCE)		+= edac_mce_amd.o
 
+obj-$(CONFIG_EDAC_AL_L1)		+= al_l1_edac.o
 obj-$(CONFIG_EDAC_AMD76X)		+= amd76x_edac.o
 obj-$(CONFIG_EDAC_CPC925)		+= cpc925_edac.o
 obj-$(CONFIG_EDAC_I5000)		+= i5000_edac.o
diff --git a/drivers/edac/al_l1_edac.c b/drivers/edac/al_l1_edac.c
new file mode 100644
index 000000000000..723b35b18f5b
--- /dev/null
+++ b/drivers/edac/al_l1_edac.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#include <asm/sysreg.h>
+#include <linux/bitfield.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/smp.h>
+
+#include "edac_device.h"
+#include "edac_module.h"
+
+#define DRV_NAME				"al_l1_edac"
+
+/* Same bit assignments of CPUMERRSR_EL1 in ARM CA57/CA72 */
+#define ARM_CA57_CPUMERRSR_EL1			sys_reg(3, 1, 15, 2, 2)
+#define ARM_CA57_CPUMERRSR_RAM_ID		GENMASK(30, 24)
+#define  ARM_CA57_L1_I_TAG_RAM			0x00
+#define  ARM_CA57_L1_I_DATA_RAM			0x01
+#define  ARM_CA57_L1_D_TAG_RAM			0x08
+#define  ARM_CA57_L1_D_DATA_RAM			0x09
+#define  ARM_CA57_L2_TLB_RAM			0x18
+#define ARM_CA57_CPUMERRSR_VALID		BIT(31)
+#define ARM_CA57_CPUMERRSR_REPEAT		GENMASK_ULL(39, 32)
+#define ARM_CA57_CPUMERRSR_OTHER		GENMASK_ULL(47, 40)
+#define ARM_CA57_CPUMERRSR_FATAL		BIT_ULL(63)
+
+#define AL_L1_EDAC_MSG_MAX			256
+
+static void al_l1_edac_cpumerrsr_read_status(void *arg)
+{
+	struct edac_device_ctl_info *edac_dev = arg;
+	int cpu, space, count;
+	u32 ramid, repeat, other, fatal;
+	u64 val;
+	char msg[AL_L1_EDAC_MSG_MAX];
+	char *p;
+	spinlock_t *lock;
+
+	val = read_sysreg_s(ARM_CA57_CPUMERRSR_EL1);
+	if (!(FIELD_GET(ARM_CA57_CPUMERRSR_VALID, val)))
+		return;
+
+	write_sysreg_s(0, ARM_CA57_CPUMERRSR_EL1);
+
+	cpu = smp_processor_id();
+	ramid = FIELD_GET(ARM_CA57_CPUMERRSR_RAM_ID, val);
+	repeat = FIELD_GET(ARM_CA57_CPUMERRSR_REPEAT, val);
+	other = FIELD_GET(ARM_CA57_CPUMERRSR_OTHER, val);
+	fatal = FIELD_GET(ARM_CA57_CPUMERRSR_FATAL, val);
+
+	space = sizeof(msg);
+	p = msg;
+	count = scnprintf(p, space, "CPU%d L1 %serror detected", cpu,
+			  (fatal) ? "Fatal " : "");
+	p += count;
+	space -= count;
+
+	switch (ramid) {
+	case ARM_CA57_L1_I_TAG_RAM:
+		count = scnprintf(p, space, " RAMID='L1-I Tag RAM'");
+		break;
+	case ARM_CA57_L1_I_DATA_RAM:
+		count = scnprintf(p, space, " RAMID='L1-I Data RAM'");
+		break;
+	case ARM_CA57_L1_D_TAG_RAM:
+		count = scnprintf(p, space, " RAMID='L1-D Tag RAM'");
+		break;
+	case ARM_CA57_L1_D_DATA_RAM:
+		count = scnprintf(p, space, " RAMID='L1-D Data RAM'");
+		break;
+	case ARM_CA57_L2_TLB_RAM:
+		count = scnprintf(p, space, " RAMID='L2 TLB RAM'");
+		break;
+	default:
+		count = scnprintf(p, space, " RAMID='unknown'");
+		break;
+	}
+
+	p += count;
+	space -= count;
+	count = scnprintf(p, space,
+			  " repeat=%d, other=%d (CPUMERRSR_EL1=0x%llx)",
+			  repeat, other, val);
+
+	lock = edac_dev->pvt_info;
+	spin_lock(lock);
+	if (fatal)
+		edac_device_handle_ue_count(edac_dev, repeat, 0, 0, msg);
+	else
+		edac_device_handle_ce_count(edac_dev, repeat, 0, 0, msg);
+	spin_unlock(lock);
+}
+
+static void al_l1_edac_check(struct edac_device_ctl_info *edac_dev)
+{
+	on_each_cpu(al_l1_edac_cpumerrsr_read_status, edac_dev, 1);
+}
+
+static int al_l1_edac_probe(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_dev;
+	struct device *dev = &pdev->dev;
+	spinlock_t *lock;
+	int ret;
+
+	edac_dev = edac_device_alloc_ctl_info(sizeof(*lock), DRV_NAME, 1, "L",
+					      1, 1, NULL, 0,
+					      edac_device_alloc_index());
+	if (!edac_dev)
+		return -ENOMEM;
+
+	edac_dev->edac_check = al_l1_edac_check;
+	edac_dev->dev = dev;
+	edac_dev->mod_name = DRV_NAME;
+	edac_dev->dev_name = dev_name(dev);
+	edac_dev->ctl_name = "L1_cache";
+	platform_set_drvdata(pdev, edac_dev);
+	lock = edac_dev->pvt_info;
+
+	spin_lock_init(lock);
+
+	ret = edac_device_add_device(edac_dev);
+	if (ret) {
+		dev_err(dev, "Failed to add L1 edac device (%d)\n", ret);
+		edac_device_free_ctl_info(edac_dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int al_l1_edac_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_dev = platform_get_drvdata(pdev);
+
+	edac_device_del_device(edac_dev->dev);
+	edac_device_free_ctl_info(edac_dev);
+
+	return 0;
+}
+
+static const struct of_device_id al_l1_edac_of_match[] = {
+	/*
+	 * "al,alpine-v2", and "amazon,al-alpine-v3" are machine compatible
+	 * strings which have Cortex-A57/A72 configured with this support,
+	 * and access to CPUMERRSR_EL1 register is enabled in firmware.
+	 */
+	{ .compatible = "al,alpine-v2" },
+	{ .compatible = "amazon,al-alpine-v3" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, al_l1_edac_of_match);
+
+static struct platform_driver al_l1_edac_driver = {
+	.probe = al_l1_edac_probe,
+	.remove = al_l1_edac_remove,
+	.driver = {
+		.name = DRV_NAME,
+	},
+};
+
+static struct platform_device *edac_l1_device;
+
+static int __init al_l1_init(void)
+{
+	struct device_node *root;
+	int ret;
+
+	root = of_find_node_by_path("/");
+	if (!root) {
+		pr_debug("Can't find root node!\n");
+		return 0;
+	}
+
+	if (!of_match_node(al_l1_edac_of_match, root))
+		return 0;
+
+	ret = platform_driver_register(&al_l1_edac_driver);
+	if (ret) {
+		pr_err("Failed to register %s (%d)\n", DRV_NAME, ret);
+		return ret;
+	}
+
+	edac_l1_device = platform_device_register_simple(DRV_NAME, -1, NULL, 0);
+	if (IS_ERR(edac_l1_device)) {
+		pr_err("Failed to register EDAC AL L1 platform device\n");
+		return PTR_ERR(edac_l1_device);
+	}
+
+	return 0;
+}
+
+static void __exit al_l1_exit(void)
+{
+	platform_device_unregister(edac_l1_device);
+	platform_driver_unregister(&al_l1_edac_driver);
+}
+
+late_initcall(al_l1_init);
+module_exit(al_l1_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Hanna Hawa <hhhawa@amazon.com>");
+MODULE_DESCRIPTION("Amazon's Annapurna Lab's L1 EDAC Driver");
-- 
2.17.1

