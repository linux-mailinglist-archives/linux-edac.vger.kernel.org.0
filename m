Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D6F14D16B
	for <lists+linux-edac@lfdr.de>; Wed, 29 Jan 2020 20:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgA2Tvn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 Jan 2020 14:51:43 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:14511 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgA2Tvn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 29 Jan 2020 14:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580327503; x=1611863503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=i/nBBfbDeEICg3VTcKwXM1ZYECpQAjRa/n5qmbLJDmE=;
  b=RZp+K2thwy0mnpTktBf6p81ROncmLMBnSMaD8aL3eExf2tHFhFcikTQb
   YbxDRvHaxoqt8nRgRAtx5XW1cBU8DX8u7qmKWhXQrGB5VdKMjGbTBwi/p
   1IBtU1XV/agGgSWo9QcaOs50orj+7ntL3JwF5LaHlE14RCpxJFN1c8vdr
   k=;
IronPort-SDR: dpmK1LU7VGMFlNb6xly/NhDj1ZajyVB6ePFrUMfQLLc6J5JlDeENQhaKNYbGtmorGGzcKQ/HJ1
 6ffgfQ6D3lwg==
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="21883415"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 29 Jan 2020 19:51:25 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 393CAA22E9;
        Wed, 29 Jan 2020 19:51:23 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 29 Jan 2020 19:51:22 +0000
Received: from u8a88181e7b2355.ant.amazon.com (10.43.162.50) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 Jan 2020 19:51:12 +0000
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
Subject: [PATCH v9 3/3] edac: Add support for Amazon's Annapurna Labs L2 EDAC
Date:   Wed, 29 Jan 2020 21:50:16 +0200
Message-ID: <20200129195016.956-4-hhhawa@amazon.com>
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

Adds support for Amazon's Annapurna Labs L2 EDAC driver to detect and
report L2 errors.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 MAINTAINERS               |   5 +
 drivers/edac/Kconfig      |   8 ++
 drivers/edac/Makefile     |   1 +
 drivers/edac/al_l2_edac.c | 270 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 284 insertions(+)
 create mode 100644 drivers/edac/al_l2_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 649ff0d314e5..5dd8a14e2a30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -768,6 +768,11 @@ M:	Hanna Hawa <hhhawa@amazon.com>
 S:	Maintained
 F:	drivers/edac/al_l1_edac.c
 
+AMAZON ANNAPURNA LABS L2 EDAC
+M:	Hanna Hawa <hhhawa@amazon.com>
+S:	Maintained
+F:	drivers/edac/al_l2_edac.c
+
 AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
 M:	Talel Shenhar <talel@amazon.com>
 S:	Maintained
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 0ea9439749ab..f22c875f61bb 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -82,6 +82,14 @@ config EDAC_AL_L1
 	  for Amazon's Annapurna Labs SoCs.
 	  This driver detects errors of L1 caches.
 
+config EDAC_AL_L2
+	tristate "Amazon's Annapurna Labs L2 EDAC"
+	depends on ARM64 && (ARCH_ALPINE || COMPILE_TEST)
+	help
+	  Support for L2 error detection and correction
+	  for Amazon's Annapurna Labs SoCs.
+	  This driver detects errors of L2 caches.
+
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 7d67433b683a..ae48f8fccec3 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -23,6 +23,7 @@ edac_mce_amd-y				:= mce_amd.o
 obj-$(CONFIG_EDAC_DECODE_MCE)		+= edac_mce_amd.o
 
 obj-$(CONFIG_EDAC_AL_L1)		+= al_l1_edac.o
+obj-$(CONFIG_EDAC_AL_L2)		+= al_l2_edac.o
 obj-$(CONFIG_EDAC_AMD76X)		+= amd76x_edac.o
 obj-$(CONFIG_EDAC_CPC925)		+= cpc925_edac.o
 obj-$(CONFIG_EDAC_I5000)		+= i5000_edac.o
diff --git a/drivers/edac/al_l2_edac.c b/drivers/edac/al_l2_edac.c
new file mode 100644
index 000000000000..147094efb6fd
--- /dev/null
+++ b/drivers/edac/al_l2_edac.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#include <asm/sysreg.h>
+#include <linux/bitfield.h>
+#include <linux/cpumask.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/smp.h>
+
+#include "edac_device.h"
+#include "edac_module.h"
+
+#define DRV_NAME				"al_l2_edac"
+
+/* Same bit assignments of L2MERRSR_EL1 in ARM CA57/CA72 */
+#define ARM_CA57_L2MERRSR_EL1			sys_reg(3, 1, 15, 2, 3)
+#define ARM_CA57_L2MERRSR_RAMID			GENMASK(30, 24)
+#define  ARM_CA57_L2_TAG_RAM			0x10
+#define  ARM_CA57_L2_DATA_RAM			0x11
+#define  ARM_CA57_L2_SNOOP_RAM			0x12
+#define  ARM_CA57_L2_DIRTY_RAM			0x14
+#define  ARM_CA57_L2_INC_PF_RAM			0x18
+#define ARM_CA57_L2MERRSR_VALID			BIT(31)
+#define ARM_CA57_L2MERRSR_REPEAT		GENMASK_ULL(39, 32)
+#define ARM_CA57_L2MERRSR_OTHER			GENMASK_ULL(47, 40)
+#define ARM_CA57_L2MERRSR_FATAL			BIT_ULL(63)
+
+#define AL_L2_EDAC_MSG_MAX			256
+
+struct al_l2_cache {
+	cpumask_t cluster_cpus;
+	struct list_head list_node;
+	struct device_node *of_node;
+};
+
+struct al_l2_edac {
+	struct list_head l2_caches;
+	spinlock_t lock;
+};
+
+static void al_l2_edac_l2merrsr_read_status(void *arg)
+{
+	struct edac_device_ctl_info *edac_dev = arg;
+	struct al_l2_edac *al_l2 = edac_dev->pvt_info;
+	int cpu, space, count;
+	u32 ramid, repeat, other, fatal;
+	u64 val;
+	char msg[AL_L2_EDAC_MSG_MAX];
+	char *p;
+
+	val = read_sysreg_s(ARM_CA57_L2MERRSR_EL1);
+	if (!(FIELD_GET(ARM_CA57_L2MERRSR_VALID, val)))
+		return;
+
+	write_sysreg_s(0, ARM_CA57_L2MERRSR_EL1);
+
+	cpu = smp_processor_id();
+	ramid = FIELD_GET(ARM_CA57_L2MERRSR_RAMID, val);
+	repeat = FIELD_GET(ARM_CA57_L2MERRSR_REPEAT, val);
+	other = FIELD_GET(ARM_CA57_L2MERRSR_OTHER, val);
+	fatal = FIELD_GET(ARM_CA57_L2MERRSR_FATAL, val);
+
+	space = sizeof(msg);
+	p = msg;
+	count = scnprintf(p, space, "CPU%d L2 %serror detected", cpu,
+			  (fatal) ? "Fatal " : "");
+	p += count;
+	space -= count;
+
+	switch (ramid) {
+	case ARM_CA57_L2_TAG_RAM:
+		count = scnprintf(p, space, " RAMID='L2 Tag RAM'");
+		break;
+	case ARM_CA57_L2_DATA_RAM:
+		count = scnprintf(p, space, " RAMID='L2 Data RAM'");
+		break;
+	case ARM_CA57_L2_SNOOP_RAM:
+		count = scnprintf(p, space, " RAMID='L2 Snoop Tag RAM'");
+		break;
+	case ARM_CA57_L2_DIRTY_RAM:
+		count = scnprintf(p, space, " RAMID='L2 Dirty RAM'");
+		break;
+	case ARM_CA57_L2_INC_PF_RAM:
+		count = scnprintf(p, space, " RAMID='L2 internal metadata'");
+		break;
+	default:
+		count = scnprintf(p, space, " RAMID='unknown'");
+		break;
+	}
+
+	p += count;
+	space -= count;
+
+	count = scnprintf(p, space,
+			  " repeat=%d, other=%d (L2MERRSR_EL1=0x%llx)",
+			  repeat, other, val);
+
+	spin_lock(&al_l2->lock);
+	if (fatal)
+		edac_device_handle_ue_count(edac_dev, repeat, 0, 0, msg);
+	else
+		edac_device_handle_ce_count(edac_dev, repeat, 0, 0, msg);
+	spin_unlock(&al_l2->lock);
+}
+
+static void al_l2_edac_check(struct edac_device_ctl_info *edac_dev)
+{
+	struct al_l2_edac *al_l2 = edac_dev->pvt_info;
+	struct al_l2_cache *l2_cache;
+
+	list_for_each_entry(l2_cache, &al_l2->l2_caches, list_node)
+		smp_call_function_any(&l2_cache->cluster_cpus,
+				      al_l2_edac_l2merrsr_read_status,
+				      edac_dev, 1);
+}
+
+static int al_l2_edac_probe(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_dev;
+	struct al_l2_edac *al_l2;
+	struct al_l2_cache *l2_cache;
+	struct device *dev = &pdev->dev;
+	int ret, i;
+
+	edac_dev = edac_device_alloc_ctl_info(sizeof(*al_l2), DRV_NAME, 1, "L",
+					      1, 2, NULL, 0,
+					      edac_device_alloc_index());
+	if (!edac_dev)
+		return -ENOMEM;
+
+	al_l2 = edac_dev->pvt_info;
+	edac_dev->edac_check = al_l2_edac_check;
+	edac_dev->dev = dev;
+	edac_dev->mod_name = DRV_NAME;
+	edac_dev->dev_name = dev_name(dev);
+	edac_dev->ctl_name = "L2_cache";
+	platform_set_drvdata(pdev, edac_dev);
+
+	spin_lock_init(&al_l2->lock);
+	INIT_LIST_HEAD(&al_l2->l2_caches);
+
+	for_each_possible_cpu(i) {
+		struct device_node *cpu;
+		struct device_node *cpu_cache;
+		bool found = false;
+
+		cpu = of_get_cpu_node(i, NULL);
+		if (!cpu)
+			continue;
+
+		cpu_cache = of_find_next_cache_node(cpu);
+		list_for_each_entry(l2_cache, &al_l2->l2_caches, list_node) {
+			if (l2_cache->of_node == cpu_cache) {
+				found = true;
+				break;
+			}
+		}
+
+		if (found) {
+			cpumask_set_cpu(i, &l2_cache->cluster_cpus);
+			of_node_put(cpu_cache);
+		} else {
+			l2_cache = devm_kzalloc(dev, sizeof(*l2_cache),
+						GFP_KERNEL);
+			l2_cache->of_node = cpu_cache;
+			list_add(&l2_cache->list_node, &al_l2->l2_caches);
+			cpumask_set_cpu(i, &l2_cache->cluster_cpus);
+		}
+
+		of_node_put(cpu);
+	}
+
+	list_for_each_entry(l2_cache, &al_l2->l2_caches, list_node)
+		of_node_put(l2_cache->of_node);
+
+	if (list_empty(&al_l2->l2_caches)) {
+		dev_err(dev, "L2 Cache list is empty for EDAC device\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = edac_device_add_device(edac_dev);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	dev_err(dev, "Failed to add L2 edac device (%d)\n", ret);
+	edac_device_free_ctl_info(edac_dev);
+
+	return ret;
+}
+
+static int al_l2_edac_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_dev = platform_get_drvdata(pdev);
+
+	edac_device_del_device(edac_dev->dev);
+	edac_device_free_ctl_info(edac_dev);
+
+	return 0;
+}
+
+static const struct of_device_id al_l2_edac_of_match[] = {
+	/*
+	 * "al,alpine-v2", and "amazon,al-alpine-v3" are machine compatible
+	 * strings which have Cortex-A57/A72 configured with this support,
+	 * and access to L2MERRSR_EL1 register is enabled in firmware.
+	 */
+	{ .compatible = "al,alpine-v2" },
+	{ .compatible = "amazon,al-alpine-v3" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, al_l2_edac_of_match);
+
+static struct platform_driver al_l2_edac_driver = {
+	.probe = al_l2_edac_probe,
+	.remove = al_l2_edac_remove,
+	.driver = {
+		.name = DRV_NAME,
+	},
+};
+
+static struct platform_device *edac_l2_device;
+
+static int __init al_l2_init(void)
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
+	if (!of_match_node(al_l2_edac_of_match, root))
+		return 0;
+
+	ret = platform_driver_register(&al_l2_edac_driver);
+	if (ret) {
+		pr_err("Failed to register %s (%d)\n", DRV_NAME, ret);
+		return ret;
+	}
+
+	edac_l2_device = platform_device_register_simple(DRV_NAME, -1, NULL, 0);
+	if (IS_ERR(edac_l2_device)) {
+		pr_err("Failed to register EDAC AL L2 platform device\n");
+		return PTR_ERR(edac_l2_device);
+	}
+
+	return 0;
+}
+
+static void __exit al_l2_exit(void)
+{
+	platform_device_unregister(edac_l2_device);
+	platform_driver_unregister(&al_l2_edac_driver);
+}
+
+late_initcall(al_l2_init);
+module_exit(al_l2_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Hanna Hawa <hhhawa@amazon.com>");
+MODULE_DESCRIPTION("Amazon's Annapurna Lab's L2 EDAC Driver");
-- 
2.17.1

