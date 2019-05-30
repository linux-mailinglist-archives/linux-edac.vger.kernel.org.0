Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282B22FA1C
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2019 12:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfE3KQK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 May 2019 06:16:10 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:55872 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfE3KQK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 30 May 2019 06:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559211369; x=1590747369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=zE0rdgbrpn1eR+Et05y8JTYfDTo5QX77POVHs+Yb6L0=;
  b=ueCZNiqQt8QpagcebTxRk92zlEScR7BsmAsoFAuRnqap+HEEq+iS/tYV
   lsnZ8EY9SpKw4DZl8RI+BcGsM/pHaV2V9Fxf2T/RuoNARRSGJsslNiTZq
   13mq3h1qZZ0zn9jf4+Rz1JqiqqWcoUEPkXUMPyL1PcypHXjHQwX3gnS7M
   8=;
X-IronPort-AV: E=Sophos;i="5.60,530,1549929600"; 
   d="scan'208";a="768245376"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 30 May 2019 10:16:08 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 027FDA20F3;
        Thu, 30 May 2019 10:16:07 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 10:16:07 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.160.237) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 10:15:58 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <paulmck@linux.ibm.com>, <dwmw@amazon.co.uk>, <benh@amazon.com>
CC:     <ronenk@amazon.com>, <talel@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-edac@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
Date:   Thu, 30 May 2019 13:15:29 +0300
Message-ID: <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.237]
X-ClientProxiedBy: EX13D23UWC001.ant.amazon.com (10.43.162.196) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add support for error detection and correction for Amazon's Annapurna
Labs SoCs for L1/L2 caches.

Amazon's Annapurna Labs SoCs based on ARM CA57 and CA72, the driver
support both cortex based on compatible string.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 MAINTAINERS                        |   7 +
 drivers/edac/Kconfig               |   9 ++
 drivers/edac/Makefile              |   1 +
 drivers/edac/amazon_al_ca57_edac.c | 283 +++++++++++++++++++++++++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100644 drivers/edac/amazon_al_ca57_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4..87fab6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5645,6 +5645,13 @@ S:	Supported
 F:	Documentation/filesystems/ecryptfs.txt
 F:	fs/ecryptfs/
 
+EDAC-AMAZON-AL
+M:	Hanna Hawa <hhhawa@amazon.com>
+L:	linux-edac@vger.kernel.org
+S:	Supported
+F:	drivers/edac/amazon_al_ca57_edac.c
+F:	Documentation/devicetree/bindings/edac/amazon-al-edac.txt
+
 EDAC-AMD64
 M:	Borislav Petkov <bp@alien8.de>
 L:	linux-edac@vger.kernel.org
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 5e2e034..1a982f8 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -504,4 +504,13 @@ config EDAC_ASPEED
 	  First, ECC must be configured in the bootloader. Then, this driver
 	  will expose error counters via the EDAC kernel framework.
 
+config EDAC_AMAZON_AL
+	tristate "Amazon AL EDAC"
+	depends on ARCH_ALPINE
+	help
+	  Support for error detection and correction for
+	  Amazon's Annapurna Labs SoCs.
+
+	  This driver detect errors on L1/L2 caches.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 89ad4a84..7e08974 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -84,3 +84,4 @@ obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
 obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
 obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
+obj-$(CONFIG_EDAC_AMAZON_AL)		+= amazon_al_ca57_edac.o
diff --git a/drivers/edac/amazon_al_ca57_edac.c b/drivers/edac/amazon_al_ca57_edac.c
new file mode 100644
index 0000000..08237c0
--- /dev/null
+++ b/drivers/edac/amazon_al_ca57_edac.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#include <linux/atomic.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "edac_device.h"
+#include "edac_module.h"
+
+#define DRV_NAME				"al_cache_edac"
+
+/* Same bit assignments of CPUMERRSR_EL1 and L2MERRSR_EL1 in ARM CA57/CA72 */
+#define ARM_CA57_CPUMERRSR_INDEX_OFF		(0)
+#define ARM_CA57_CPUMERRSR_INDEX_MASK		(0x3FFFF)
+#define ARM_CA57_CPUMERRSR_BANK_WAY_OFF		(18)
+#define ARM_CA57_CPUMERRSR_BANK_WAY_MASK	(0x1F)
+#define ARM_CA57_CPUMERRSR_RAM_ID_OFF		(24)
+#define ARM_CA57_CPUMERRSR_RAM_ID_MASK		(0x7F)
+#define  ARM_CA57_L1_I_TAG_RAM			0x00
+#define  ARM_CA57_L1_I_DATA_RAM			0x01
+#define  ARM_CA57_L1_D_TAG_RAM			0x08
+#define  ARM_CA57_L1_D_DATA_RAM			0x09
+#define  ARM_CA57_TLB_RAM			0x18
+#define ARM_CA57_CPUMERRSR_VALID_OFF		(31)
+#define ARM_CA57_CPUMERRSR_VALID_MASK		(0x1)
+#define ARM_CA57_CPUMERRSR_REPEAT_OFF		(32)
+#define ARM_CA57_CPUMERRSR_REPEAT_MASK		(0xFF)
+#define ARM_CA57_CPUMERRSR_OTHER_OFF		(40)
+#define ARM_CA57_CPUMERRSR_OTHER_MASK		(0xFF)
+#define ARM_CA57_CPUMERRSR_FATAL_OFF		(63)
+#define ARM_CA57_CPUMERRSR_FATAL_MASK		(0x1)
+
+#define ARM_CA57_L2MERRSR_INDEX_OFF		(0)
+#define ARM_CA57_L2MERRSR_INDEX_MASK		(0x3FFFF)
+#define ARM_CA57_L2MERRSR_CPUID_WAY_OFF		(18)
+#define ARM_CA57_L2MERRSR_CPUID_WAY_MASK	(0xF)
+#define ARM_CA57_L2MERRSR_RAMID_OFF		(24)
+#define ARM_CA57_L2MERRSR_RAMID_MASK		(0x7F)
+#define  ARM_CA57_L2_TAG_RAM			0x10
+#define  ARM_CA57_L2_DATA_RAM			0x11
+#define  ARM_CA57_L2_SNOOP_RAM			0x12
+#define  ARM_CA57_L2_DIRTY_RAM			0x14
+#define  ARM_CA57_L2_INC_PLRU_RAM		0x18
+#define ARM_CA57_L2MERRSR_VALID_OFF		(31)
+#define ARM_CA57_L2MERRSR_VALID_MASK		(0x1)
+#define ARM_CA57_L2MERRSR_REPEAT_OFF		(32)
+#define ARM_CA57_L2MERRSR_REPEAT_MASK		(0xFF)
+#define ARM_CA57_L2MERRSR_OTHER_OFF		(40)
+#define ARM_CA57_L2MERRSR_OTHER_MASK		(0xFF)
+#define ARM_CA57_L2MERRSR_FATAL_OFF		(63)
+#define ARM_CA57_L2MERRSR_FATAL_MASK		(0x1)
+
+static inline u64 read_cpumerrsr_el1(void)
+{
+	u64 val;
+
+	asm volatile("mrs %0, s3_1_c15_c2_2" : "=r" (val));
+
+	return val;
+}
+
+static inline void write_cpumerrsr_el1(u64 val)
+{
+	asm volatile("msr s3_1_c15_c2_2, %0" :: "r" (val));
+}
+
+static inline u64 read_l2merrsr_el1(void)
+{
+	u64 val;
+
+	asm volatile("mrs %0, s3_1_c15_c2_3" : "=r" (val));
+
+	return val;
+}
+
+static inline void write_l2merrsr_el1(u64 val)
+{
+	asm volatile("msr s3_1_c15_c2_3, %0" :: "r" (val));
+}
+
+static void al_a57_edac_cpumerrsr(void *arg)
+{
+	struct edac_device_ctl_info *edac_dev =
+		(struct edac_device_ctl_info *)arg;
+	int cpu;
+	u32 index, way, ramid, repeat, other, fatal;
+	u64 val = read_cpumerrsr_el1();
+
+	/* Return if no valid error */
+	if (!((val >> ARM_CA57_CPUMERRSR_VALID_OFF) &
+	      ARM_CA57_CPUMERRSR_VALID_MASK))
+		return;
+
+	cpu = smp_processor_id();
+	index = (val >> ARM_CA57_CPUMERRSR_INDEX_OFF) &
+		ARM_CA57_CPUMERRSR_INDEX_MASK;
+	way = (val >> ARM_CA57_CPUMERRSR_BANK_WAY_OFF) &
+		ARM_CA57_CPUMERRSR_BANK_WAY_MASK;
+	ramid = (val >> ARM_CA57_CPUMERRSR_RAM_ID_OFF) &
+		ARM_CA57_CPUMERRSR_RAM_ID_MASK;
+	repeat = (val >> ARM_CA57_CPUMERRSR_REPEAT_OFF) &
+		ARM_CA57_CPUMERRSR_REPEAT_MASK;
+	other = (val >> ARM_CA57_CPUMERRSR_OTHER_OFF) &
+		ARM_CA57_CPUMERRSR_OTHER_MASK;
+	fatal = (val >> ARM_CA57_CPUMERRSR_FATAL_OFF) &
+		ARM_CA57_CPUMERRSR_FATAL_MASK;
+
+	edac_device_handle_ce(edac_dev, 0, 0, "L2 Error");
+	edac_printk(KERN_CRIT, DRV_NAME, "CPU%d L1 %serror detected\n",
+		    cpu, (fatal) ? "Fatal " : "");
+	edac_printk(KERN_CRIT, DRV_NAME, "RAMID=");
+
+	switch (ramid) {
+	case ARM_CA57_L1_I_TAG_RAM:
+		pr_cont("'L1-I Tag RAM' index=%d way=%d", index, way);
+		break;
+	case ARM_CA57_L1_I_DATA_RAM:
+		pr_cont("'L1-I Data RAM' index=%d bank= %d", index, way);
+		break;
+	case ARM_CA57_L1_D_TAG_RAM:
+		pr_cont("'L1-D Tag RAM' index=%d way=%d", index, way);
+		break;
+	case ARM_CA57_L1_D_DATA_RAM:
+		pr_cont("'L1-D Data RAM' index=%d bank=%d", index, way);
+		break;
+	case ARM_CA57_TLB_RAM:
+		pr_cont("'TLB RAM' index=%d", index);
+		break;
+	default:
+		pr_cont("'unknown'");
+		break;
+	}
+
+	pr_cont(", repeat=%d, other=%d (CPUMERRSR_EL1=0x%llx)\n", repeat, other,
+		val);
+
+	write_cpumerrsr_el1(0);
+}
+
+static void al_a57_edac_l2merrsr(void *arg)
+{
+	struct edac_device_ctl_info *edac_dev =
+		(struct edac_device_ctl_info *)arg;
+	int cpu;
+	u32 index, way, ramid, repeat, other, fatal;
+	u64 val = read_l2merrsr_el1();
+
+	/* Return if no valid error */
+	if (!((val >> ARM_CA57_L2MERRSR_VALID_OFF) &
+	      ARM_CA57_L2MERRSR_VALID_MASK))
+		return;
+
+	cpu = smp_processor_id();
+	index = (val >> ARM_CA57_L2MERRSR_INDEX_OFF) &
+		ARM_CA57_L2MERRSR_INDEX_MASK;
+	way = (val >> ARM_CA57_L2MERRSR_CPUID_WAY_OFF) &
+		ARM_CA57_L2MERRSR_CPUID_WAY_MASK;
+	ramid = (val >> ARM_CA57_L2MERRSR_RAMID_OFF) &
+		ARM_CA57_L2MERRSR_RAMID_MASK;
+	repeat = (val >> ARM_CA57_L2MERRSR_REPEAT_OFF) &
+		ARM_CA57_L2MERRSR_REPEAT_MASK;
+	other = (val >> ARM_CA57_L2MERRSR_OTHER_OFF) &
+		ARM_CA57_L2MERRSR_OTHER_MASK;
+	fatal = (val >> ARM_CA57_L2MERRSR_FATAL_OFF) &
+		ARM_CA57_L2MERRSR_FATAL_MASK;
+
+	edac_device_handle_ce(edac_dev, 0, 0, "L2 Error");
+	edac_printk(KERN_CRIT, DRV_NAME, "CPU%d L2 %serror detected\n",
+		    cpu, (fatal) ? "Fatal " : "");
+	edac_printk(KERN_CRIT, DRV_NAME, "RAMID=");
+
+	switch (ramid) {
+	case ARM_CA57_L2_TAG_RAM:
+		pr_cont("'L2 Tag RAM'");
+		break;
+	case ARM_CA57_L2_DATA_RAM:
+		pr_cont("'L2 Data RAM'");
+		break;
+	case ARM_CA57_L2_SNOOP_RAM:
+		pr_cont("'L2 Snoop RAM'");
+		break;
+	case ARM_CA57_L2_DIRTY_RAM:
+		pr_cont("'L2 Dirty RAM'");
+		break;
+	case ARM_CA57_L2_INC_PLRU_RAM:
+		pr_cont("'L2 Inclusion PLRU RAM'");
+		break;
+	default:
+		pr_cont("'unknown'");
+		break;
+	}
+
+	pr_cont(", cpuid/way=%d, repeat=%d, other=%d (L2MERRSR_EL1=0x%llx)\n",
+		way, repeat, other, val);
+
+	write_l2merrsr_el1(0);
+}
+
+static void al_a57_edac_check(struct edac_device_ctl_info *edac_dev)
+{
+	int cpu, cluster, last_cluster = -1;
+
+	/*
+	 * Use get_online_cpus/put_online_cpus to prevent the online CPU map
+	 * changing while reads the L1/L2 error status
+	 */
+	get_online_cpus();
+	for_each_online_cpu(cpu) {
+		/* Check L1 errors */
+		smp_call_function_single(cpu, al_a57_edac_cpumerrsr, edac_dev,
+					 0);
+		cluster = topology_physical_package_id(cpu);
+		/* Only single CPU will read the L2 error status */
+		if (cluster != last_cluster) {
+			smp_call_function_single(cpu, al_a57_edac_l2merrsr,
+						 edac_dev, 0);
+			last_cluster = cluster;
+		}
+	}
+	put_online_cpus();
+}
+
+static int al_a57_edac_probe(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_dev;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	/* Polling mode is supported */
+	edac_op_state = EDAC_OPSTATE_POLL;
+
+	edac_dev = edac_device_alloc_ctl_info(0, DRV_NAME, 1, "L", 2, 1, NULL,
+					      0, edac_device_alloc_index());
+	if (IS_ERR(edac_dev))
+		return -ENOMEM;
+
+	edac_dev->edac_check = al_a57_edac_check;
+	edac_dev->dev = dev;
+	edac_dev->mod_name = dev_name(dev);
+	edac_dev->dev_name = dev_name(dev);
+	edac_dev->ctl_name = dev_name(dev);
+	platform_set_drvdata(pdev, edac_dev);
+
+	ret = edac_device_add_device(edac_dev);
+	if (ret)
+		edac_device_free_ctl_info(edac_dev);
+
+	return ret;
+}
+
+static int al_a57_edac_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_dev = platform_get_drvdata(pdev);
+
+	edac_device_del_device(edac_dev->dev);
+	edac_device_free_ctl_info(edac_dev);
+
+	return 0;
+}
+
+static const struct of_device_id al_a57_edac_of_match[] = {
+	{ .compatible = "amazon,al-cortex-a57-edac" },
+	{ .compatible = "amazon,al-cortex-a72-edac" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, al_a57_edac_of_match);
+
+static struct platform_driver al_a57_edac_driver = {
+	.probe = al_a57_edac_probe,
+	.remove = al_a57_edac_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = al_a57_edac_of_match,
+	},
+};
+module_platform_driver(al_a57_edac_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Hanna Hawa <hhhawa@amazon.com>");
-- 
2.7.4

