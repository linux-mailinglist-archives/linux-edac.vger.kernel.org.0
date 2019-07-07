Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6472614D8
	for <lists+linux-edac@lfdr.de>; Sun,  7 Jul 2019 13:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfGGL66 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 7 Jul 2019 07:58:58 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:5068 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfGGL66 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 7 Jul 2019 07:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562500736; x=1594036736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=60X891scMhbmjUoeEckMBvX4630ty+8QYuK2MOZwV4o=;
  b=NX6D7Ld6LyIorpcEYjEljQF9ClqoxuY11vn4ubqlTx+UFl6CI9CwUKCs
   4a2PWJvEuEirKMiwz20QhGVIWzoci81xuipSYlsHfaAfkUUt44//kSCW7
   EHtHdlx8q4G0/KRoS/+wIAWXFEhgQEYYLRHtfuZ/+Gk0LxhPd3xvbywG/
   E=;
X-IronPort-AV: E=Sophos;i="5.62,462,1554768000"; 
   d="scan'208";a="773526838"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 07 Jul 2019 11:58:54 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id E6B2BA074E;
        Sun,  7 Jul 2019 11:58:50 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 7 Jul 2019 11:58:50 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.161.16) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 7 Jul 2019 11:58:40 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <nicolas.ferre@microchip.com>,
        <paulmck@linux.ibm.com>
CC:     <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <hhhawa@amazon.com>
Subject: [PATCH v2 4/4] edac: Add support for Amazon's Annapurna Labs L2 EDAC
Date:   Sun, 7 Jul 2019 14:57:38 +0300
Message-ID: <1562500658-14717-5-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562500658-14717-1-git-send-email-hhhawa@amazon.com>
References: <1562500658-14717-1-git-send-email-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.16]
X-ClientProxiedBy: EX13D12UWC004.ant.amazon.com (10.43.162.182) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Adds support for Amazon's Annapurna Labs L2 EDAC driver to detect and
report L2 errors.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 MAINTAINERS               |   6 ++
 drivers/edac/Kconfig      |   8 ++
 drivers/edac/Makefile     |   1 +
 drivers/edac/al_l2_edac.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 200 insertions(+)
 create mode 100644 drivers/edac/al_l2_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fd29ea6..a6dcf3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -749,6 +749,12 @@ S:	Maintained
 F:	drivers/edac/al_l1_edac.c
 F:	Documentation/devicetree/bindings/edac/amazon,al-l1-edac.txt
 
+AMAZON ANNAPURNA LABS L2 EDAC
+M:	Hanna Hawa <hhhawa@amazon.com>
+S:	Maintained
+F:	drivers/edac/al_l2_edac.c
+F:	Documentation/devicetree/bindings/edac/amazon,al-l2-edac.txt
+
 AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
 M:	Talel Shenhar <talel@amazon.com>
 S:	Maintained
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 58b92bc..8bbb745 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -82,6 +82,14 @@ config EDAC_AL_L1
 	  for Amazon's Annapurna Labs SoCs.
 	  This driver detects errors of L1 caches.
 
+config EDAC_AL_L2
+	bool "Amazon's Annapurna Labs L2 EDAC"
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
index caa2dc9..60a6b8b 100644
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
index 0000000..4db6b66
--- /dev/null
+++ b/drivers/edac/al_l2_edac.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/of.h>
+
+#include "edac_device.h"
+#include "edac_module.h"
+
+/* Same bit assignments of L2MERRSR_EL1 in ARM CA57/CA72 */
+#define ARM_CA57_L2MERRSR_EL1			sys_reg(3, 1, 15, 2, 3)
+#define ARM_CA57_L2MERRSR_RAMID			GENMASK(30, 24)
+#define  ARM_CA57_L2_TAG_RAM			0x10
+#define  ARM_CA57_L2_DATA_RAM			0x11
+#define  ARM_CA57_L2_SNOOP_RAM			0x12
+#define  ARM_CA57_L2_DIRTY_RAM			0x14
+#define  ARM_CA57_L2_INC_PF_RAM			0x18
+#define ARM_CA57_L2MERRSR_VALID			GENMASK(31, 31)
+#define ARM_CA57_L2MERRSR_REPEAT		GENMASK(39, 32)
+#define ARM_CA57_L2MERRSR_OTHER			GENMASK(47, 40)
+#define ARM_CA57_L2MERRSR_FATAL			GENMASK(63, 63)
+
+#define AL_L2_EDAC_MSG_MAX			256
+
+struct al_l2_edac {
+	cpumask_t cluster_cpus;
+};
+
+static void al_l2_edac_l2merrsr(void *arg)
+{
+	struct edac_device_ctl_info *edac_dev = arg;
+	int cpu, i;
+	u32 ramid, repeat, other, fatal;
+	u64 val = read_sysreg_s(ARM_CA57_L2MERRSR_EL1);
+	char msg[AL_L2_EDAC_MSG_MAX];
+	int space, count;
+	char *p;
+
+	if (!(FIELD_GET(ARM_CA57_L2MERRSR_VALID, val)))
+		return;
+
+	cpu = smp_processor_id();
+	ramid = FIELD_GET(ARM_CA57_L2MERRSR_RAMID, val);
+	repeat = FIELD_GET(ARM_CA57_L2MERRSR_REPEAT, val);
+	other = FIELD_GET(ARM_CA57_L2MERRSR_OTHER, val);
+	fatal = FIELD_GET(ARM_CA57_L2MERRSR_FATAL, val);
+
+	space = sizeof(msg);
+	p = msg;
+	count = snprintf(p, space, "CPU%d L2 %serror detected", cpu,
+			 (fatal) ? "Fatal " : "");
+	p += count;
+	space -= count;
+
+	switch (ramid) {
+	case ARM_CA57_L2_TAG_RAM:
+		count = snprintf(p, space, " RAMID='L2 Tag RAM'");
+		break;
+	case ARM_CA57_L2_DATA_RAM:
+		count = snprintf(p, space, " RAMID='L2 Data RAM'");
+		break;
+	case ARM_CA57_L2_SNOOP_RAM:
+		count = snprintf(p, space, " RAMID='L2 Snoop RAM'");
+		break;
+	case ARM_CA57_L2_DIRTY_RAM:
+		count = snprintf(p, space, " RAMID='L2 Dirty RAM'");
+		break;
+	case ARM_CA57_L2_INC_PF_RAM:
+		count = snprintf(p, space, " RAMID='L2 internal metadat'");
+		break;
+	default:
+		count = snprintf(p, space, " RAMID='unknown'");
+		break;
+	}
+
+	p += count;
+	space -= count;
+
+	count = snprintf(p, space,
+			 " repeat=%d, other=%d (L2MERRSR_EL1=0x%llx)",
+			 repeat, other, val);
+
+	for (i = 0; i < repeat; i++) {
+		if (fatal)
+			edac_device_handle_ue(edac_dev, 0, 0, msg);
+		else
+			edac_device_handle_ce(edac_dev, 0, 0, msg);
+	}
+
+	write_sysreg_s(0, ARM_CA57_L2MERRSR_EL1);
+}
+
+static void al_l2_edac_check(struct edac_device_ctl_info *edac_dev)
+{
+	struct al_l2_edac *al_l2 = edac_dev->pvt_info;
+
+	smp_call_function_any(&al_l2->cluster_cpus, al_l2_edac_l2merrsr,
+			      edac_dev, 1);
+}
+
+static int al_l2_edac_probe(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_dev;
+	struct al_l2_edac *al_l2;
+	struct device *dev = &pdev->dev;
+	int ret, i;
+
+	edac_dev = edac_device_alloc_ctl_info(sizeof(*al_l2),
+					      (char *)dev_name(dev), 1, "L", 1,
+					      2, NULL, 0,
+					      edac_device_alloc_index());
+	if (IS_ERR(edac_dev))
+		return -ENOMEM;
+
+	al_l2 = edac_dev->pvt_info;
+	edac_dev->edac_check = al_l2_edac_check;
+	edac_dev->dev = dev;
+	edac_dev->mod_name = dev_name(dev);
+	edac_dev->dev_name = dev_name(dev);
+	edac_dev->ctl_name = dev_name(dev);
+	platform_set_drvdata(pdev, edac_dev);
+
+	for_each_online_cpu(i) {
+		struct device_node *cpu;
+		struct device_node *cpu_cache, *l2_cache;
+
+		cpu = of_get_cpu_node(i, NULL);
+		cpu_cache = of_find_next_cache_node(cpu);
+		l2_cache = of_parse_phandle(dev->of_node, "l2-cache", 0);
+
+		if (cpu_cache == l2_cache)
+			cpumask_set_cpu(i, &al_l2->cluster_cpus);
+	}
+
+	if (cpumask_empty(&al_l2->cluster_cpus)) {
+		dev_err(dev, "CPU mask is empty for this L2 cache\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = edac_device_add_device(edac_dev);
+	if (ret) {
+		dev_err(dev, "Failed to add L2 edac device\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
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
+	{ .compatible = "amazon,al-l2-edac" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, al_l2_edac_of_match);
+
+static struct platform_driver al_l2_edac_driver = {
+	.probe = al_l2_edac_probe,
+	.remove = al_l2_edac_remove,
+	.driver = {
+		.name = "al_l2_edac",
+		.of_match_table = al_l2_edac_of_match,
+	},
+};
+module_platform_driver(al_l2_edac_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Hanna Hawa <hhhawa@amazon.com>");
+MODULE_DESCRIPTION("Amazon's Annapurna Lab's L2 EDAC Driver");
-- 
2.7.4

