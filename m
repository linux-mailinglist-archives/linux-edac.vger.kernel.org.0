Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2572ACE730
	for <lists+linux-edac@lfdr.de>; Mon,  7 Oct 2019 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfJGPSc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Oct 2019 11:18:32 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:15087 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfJGPSb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Oct 2019 11:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570461509; x=1601997509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Y5PrgZ6JN7DSaQFWnn+Na5nfcZQNr2KKrNhnjmAb9bQ=;
  b=FgAGWg+z3l7Xu+cWtvcCJ8d4qPsT8xO0n5dZPzxkUzqD1D3PeZTp7od5
   8ATOHUYDbEJvAg0MyxVbSYasvw8/U2gK/8XiZsARlYz4zu6ZsM6uk4khJ
   QbqB3joIDyipzcqNz0ViEDj1X1Mey07J8fBfPDOT9KftI0dELN+mtlZ5b
   0=;
X-IronPort-AV: E=Sophos;i="5.67,268,1566864000"; 
   d="scan'208";a="756223131"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 07 Oct 2019 15:18:27 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 7A1DB247E3C;
        Mon,  7 Oct 2019 15:18:22 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 7 Oct 2019 15:18:21 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.162.116) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 7 Oct 2019 15:18:12 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <mark.rutland@arm.com>,
        <james.morse@arm.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <daniel@iogearbox.net>, <paulmck@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>
Subject: [PATCH v6 3/3] edac: Add support for Amazon's Annapurna Labs L2 EDAC
Date:   Mon, 7 Oct 2019 16:17:30 +0100
Message-ID: <20191007151730.7705-4-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007151730.7705-1-hhhawa@amazon.com>
References: <20191007151730.7705-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.116]
X-ClientProxiedBy: EX13D03UWC002.ant.amazon.com (10.43.162.160) To
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
 drivers/edac/al_l2_edac.c | 251 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 265 insertions(+)
 create mode 100644 drivers/edac/al_l2_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7887a62dc843..0eabcfcf91a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -748,6 +748,11 @@ M:	Hanna Hawa <hhhawa@amazon.com>
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
index e8161d7c7469..cb394aff1cab 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -82,6 +82,14 @@ config EDAC_AL_L1
 	  for Amazon's Annapurna Labs SoCs.
 	  This driver detects errors of L1 caches.
 
+config EDAC_AL_L2
+	tristate "Amazon's Annapurna Labs L2 EDAC"
+	depends on ARCH_ALPINE
+	help
+	  Support for L2 error detection and correction
+	  for Amazon's Annapurna Labs SoCs.
+	  This driver detects errors of L2 caches.
+
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index caa2dc91e8a0..60a6b8bbe2f8 100644
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
index 000000000000..156610c85591
--- /dev/null
+++ b/drivers/edac/al_l2_edac.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#include <asm/sysreg.h>
+#include <linux/bitfield.h>
+#include <linux/cpumask.h>
+#include <linux/of.h>
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
+};
+
+static void al_l2_edac_l2merrsr_read_status(void *arg)
+{
+	struct edac_device_ctl_info *edac_dev = arg;
+	int cpu, i, space, count;
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
+	for (i = 0; i < repeat; i++) {
+		if (fatal)
+			edac_device_handle_ue(edac_dev, 0, 0, msg);
+		else
+			edac_device_handle_ce(edac_dev, 0, 0, msg);
+	}
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
+	INIT_LIST_HEAD(&al_l2->l2_caches);
+
+	for_each_possible_cpu(i) {
+		struct device_node *cpu;
+		struct device_node *cpu_cache;
+		struct al_l2_cache *l2_cache;
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
+	{ .compatible = "al,alpine-v2" },
+	{ .compatible = "amazon,alpine-v3" },
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
+	struct device_node *root = of_find_node_by_path("/");
+	int ret;
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

