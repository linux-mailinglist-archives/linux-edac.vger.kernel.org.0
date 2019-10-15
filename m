Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDC2D7627
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2019 14:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbfJOMNK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Oct 2019 08:13:10 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:14668 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfJOMNK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Oct 2019 08:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571141589; x=1602677589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=6rWJ48GA3CVJbNWW0cDVbU4SK59YqeBetz/BK7h5il0=;
  b=RNqqtOGmYtV2szBLdOedBeLD5czCwBZwM5O9dyJAhn3J4OuPYrBGk8lH
   tA4+I8YU0tiC9fB8JYBx8jhzU3xxTOHnavrQTK9y8IzkUPj5mwajotERS
   dPm7k54Lqkt3YCbUVkFjiO1O8ssV1swQGIcxT3xYLsmg9wP0NxNo694l7
   4=;
X-IronPort-AV: E=Sophos;i="5.67,299,1566864000"; 
   d="scan'208";a="429217662"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 15 Oct 2019 12:10:08 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id E07D9A268A;
        Tue, 15 Oct 2019 12:10:03 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 15 Oct 2019 12:10:03 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.162.200) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 15 Oct 2019 12:09:52 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <mark.rutland@arm.com>,
        <james.morse@arm.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <daniel@iogearbox.net>, <paulmck@linux.ibm.com>,
        <Sudeep.Holla@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>
Subject: [PATCH v7 1/3] edac: Add support for Amazon's Annapurna Labs L1 EDAC
Date:   Tue, 15 Oct 2019 13:09:25 +0100
Message-ID: <20191015120927.10470-2-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015120927.10470-1-hhhawa@amazon.com>
References: <20191015120927.10470-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.200]
X-ClientProxiedBy: EX13D25UWB003.ant.amazon.com (10.43.161.33) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Adds support for Amazon's Annapurna Labs L1 EDAC driver to detect and
report L1 errors.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 MAINTAINERS               |   5 +
 drivers/edac/Kconfig      |   8 ++
 drivers/edac/Makefile     |   1 +
 drivers/edac/al_l1_edac.c | 190 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 204 insertions(+)
 create mode 100644 drivers/edac/al_l1_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 77eae44bf5de..7887a62dc843 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -743,6 +743,11 @@ F:	drivers/tty/serial/altera_jtaguart.c
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
index 200c04ce5b0e..e26c54216519 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -74,6 +74,14 @@ config EDAC_GHES
 
 	  In doubt, say 'Y'.
 
+config EDAC_AL_L1
+	tristate "Amazon's Annapurna Labs L1 EDAC"
+	depends on (ARM64 && ARCH_ALPINE) || COMPILE_TEST
+	help
+	  Support for L1 error detection and correction
+	  for Amazon's Annapurna Labs SoCs.
+	  This driver detects errors of L1 caches.
+
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 165ca65e1a3a..caa2dc91e8a0 100644
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
index 000000000000..e363a80b4d13
--- /dev/null
+++ b/drivers/edac/al_l1_edac.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#include <asm/sysreg.h>
+#include <linux/bitfield.h>
+#include <linux/of.h>
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
+	int cpu, i, space, count;
+	u32 ramid, repeat, other, fatal;
+	u64 val;
+	char msg[AL_L1_EDAC_MSG_MAX];
+	char *p;
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
+	for (i = 0; i < repeat; i++) {
+		if (fatal)
+			edac_device_handle_ue(edac_dev, 0, 0, msg);
+		else
+			edac_device_handle_ce(edac_dev, 0, 0, msg);
+	}
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
+	int ret;
+
+	edac_dev = edac_device_alloc_ctl_info(0, DRV_NAME, 1, "L", 1, 1, NULL,
+					      0, edac_device_alloc_index());
+	if (!edac_dev)
+		return -ENOMEM;
+
+	edac_dev->edac_check = al_l1_edac_check;
+	edac_dev->dev = dev;
+	edac_dev->mod_name = DRV_NAME;
+	edac_dev->dev_name = dev_name(dev);
+	edac_dev->ctl_name = "L1_cache";
+	platform_set_drvdata(pdev, edac_dev);
+
+	ret = edac_device_add_device(edac_dev);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	dev_err(dev, "Failed to add L1 edac device (%d)\n", ret);
+	edac_device_free_ctl_info(edac_dev);
+
+	return ret;
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
+	{ .compatible = "al,alpine-v2" },
+	{ .compatible = "amazon,alpine-v3" },
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
+	struct device_node *root = of_find_node_by_path("/");
+	int ret;
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

