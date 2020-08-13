Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9BA243598
	for <lists+linux-edac@lfdr.de>; Thu, 13 Aug 2020 09:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgHMH51 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Aug 2020 03:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgHMH50 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 13 Aug 2020 03:57:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B9DC061757
        for <linux-edac@vger.kernel.org>; Thu, 13 Aug 2020 00:57:26 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1k6872-000413-I4; Thu, 13 Aug 2020 09:57:24 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1k6870-0007Oz-PM; Thu, 13 Aug 2020 09:57:22 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-edac@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        York Sun <york.sun@nxp.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/2] drivers/edac: Add L1 and L2 error detection for A53 and A57
Date:   Thu, 13 Aug 2020 09:57:20 +0200
Message-Id: <20200813075721.27981-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813075721.27981-1-s.hauer@pengutronix.de>
References: <20200813075721.27981-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Cortex A53 and A57 cores have error detection capabilities for the
L1/L2 Caches, this patch adds a driver for them.

Unfortunately there is no robust way to inject errors into the caches,
so this driver doesn't contain any code to actually test it. It has
been tested though with code taken from an older version of this driver
found here: https://lkml.org/lkml/2018/3/14/1203. For reasons stated
in this thread the error injection code is not suitable for mainline,
so it is removed from the driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../bindings/edac/arm,cortex-a5x-edac.yaml    |  32 +++
 drivers/edac/Kconfig                          |   6 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/cortex_arm64_l1_l2.c             | 208 ++++++++++++++++++
 4 files changed, 247 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/arm,cortex-a5x-edac.yaml
 create mode 100644 drivers/edac/cortex_arm64_l1_l2.c

diff --git a/Documentation/devicetree/bindings/edac/arm,cortex-a5x-edac.yaml b/Documentation/devicetree/bindings/edac/arm,cortex-a5x-edac.yaml
new file mode 100644
index 0000000000000..de9325b688a02
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/arm,cortex-a5x-edac.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/arm,cortex-a5x-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM cortex A53/A57 EDAC bindings
+
+description: |+
+  This contains the binding to support error detection for the L1 and L2 caches
+  on ARM Cortex A53 and A57 cores.
+
+properties:
+  compatible:
+    items:
+      - const: arm,cortex-a53-edac
+      - const: arm,cortex-a57-edac
+
+  cpus:
+    minItems: 1
+    description: phandles to the cpu nodes this device handles
+
+required:
+  - compatible
+  - cpus
+
+examples:
+  - |
+    edac-a53 {
+        compatible = "arm,cortex-a53-edac";
+        cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
+    };
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 7b6ec3014ba2d..19501e5529edd 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -530,4 +530,10 @@ config EDAC_DMC520
 	  Support for error detection and correction on the
 	  SoCs with ARM DMC-520 DRAM controller.
 
+config EDAC_CORTEX_ARM64_L1_L2
+	tristate "ARM Cortex A57/A53"
+	depends on ARM64
+	help
+	  Support for error detection on ARM Cortex A57 and A53.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 269e15118ceac..3edba6bea3507 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
 obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
+obj-$(CONFIG_EDAC_CORTEX_ARM64_L1_L2)	+= cortex_arm64_l1_l2.o
diff --git a/drivers/edac/cortex_arm64_l1_l2.c b/drivers/edac/cortex_arm64_l1_l2.c
new file mode 100644
index 0000000000000..12b49a5af3c0f
--- /dev/null
+++ b/drivers/edac/cortex_arm64_l1_l2.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cortex A57 and A53 EDAC L1 and L2 cache error detection
+ *
+ * Copyright (c) 2020 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * Based on Code from:
+ * Copyright (c) 2018, NXP Semiconductor
+ * Author: York Sun <york.sun@nxp.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
+#include <linux/bitfield.h>
+#include <asm/smp_plat.h>
+
+#include "edac_module.h"
+
+#define EDAC_MOD_STR			"cortex_edac_l1_l2"
+
+#define CPUMERRSR_EL1_RAMID		GENMASK(30, 24)
+
+#define CPUMERRSR_EL1_VALID		BIT(31)
+#define CPUMERRSR_EL1_FATAL		BIT(63)
+
+#define L1_I_TAG_RAM			0x00
+#define L1_I_DATA_RAM			0x01
+#define L1_D_TAG_RAM			0x08
+#define L1_D_DATA_RAM			0x09
+#define L1_D_DIRTY_RAM			0x14
+#define TLB_RAM				0x18
+
+#define L2MERRSR_EL1_VALID		BIT(31)
+#define L2MERRSR_EL1_FATAL		BIT(63)
+
+struct arm64_pvt {
+	call_single_data_t __percpu *csd_check;
+	struct cpumask compat_mask;
+};
+
+#define MESSAGE_SIZE 64
+
+static void read_errors(void *data)
+{
+	u64 cpumerr, l2merr;
+	int cpu = smp_processor_id();
+	char msg[MESSAGE_SIZE];
+	struct edac_device_ctl_info *edac_ctl = data;
+
+	/* cpumerrsr_el1 */
+	asm volatile("mrs %0, s3_1_c15_c2_2" : "=r" (cpumerr));
+	asm volatile("msr s3_1_c15_c2_2, %0" :: "r" (0));
+
+	if (cpumerr & CPUMERRSR_EL1_VALID) {
+		const char *str;
+		int fatal = (cpumerr & CPUMERRSR_EL1_FATAL) != 0;
+
+		switch (FIELD_GET(CPUMERRSR_EL1_RAMID, cpumerr)) {
+		case L1_I_TAG_RAM:
+			str = "L1-I Tag RAM";
+			break;
+		case L1_I_DATA_RAM:
+			str = "L1-I Data RAM";
+			break;
+		case L1_D_TAG_RAM:
+			str = "L1-D Tag RAM";
+			break;
+		case L1_D_DATA_RAM:
+			str = "L1-D Data RAM";
+			break;
+		case L1_D_DIRTY_RAM:
+			str = "L1 Dirty RAM";
+			break;
+		case TLB_RAM:
+			str = "TLB RAM";
+			break;
+		default:
+			str = "unknown";
+			break;
+		}
+
+		snprintf(msg, MESSAGE_SIZE, "%s %s error(s) on CPU %d",
+			 str, fatal ? "fatal" : "correctable", cpu);
+
+		if (fatal)
+			edac_device_handle_ue(edac_ctl, 0, 0, msg);
+		else
+			edac_device_handle_ce(edac_ctl, 0, 0, msg);
+	}
+
+	/* l2merrsr_el1 */
+	asm volatile("mrs %0, s3_1_c15_c2_3" : "=r" (l2merr));
+	asm volatile("msr s3_1_c15_c2_3, %0" :: "r" (0));
+
+	if (l2merr & L2MERRSR_EL1_VALID) {
+		int fatal = (l2merr & L2MERRSR_EL1_FATAL) != 0;
+
+		snprintf(msg, MESSAGE_SIZE, "L2 %s error(s) on CPU %d",
+			 fatal ? "fatal" : "correctable", cpu);
+		if (fatal)
+			edac_device_handle_ue(edac_ctl, 0, 1, msg);
+		else
+			edac_device_handle_ce(edac_ctl, 0, 1, msg);
+	}
+}
+
+static void cortex_arm64_edac_check(struct edac_device_ctl_info *edac_ctl)
+{
+	struct arm64_pvt *pvt = edac_ctl->pvt_info;
+	int cpu;
+	call_single_data_t *csd;
+
+	get_online_cpus();
+	for_each_cpu_and(cpu, cpu_online_mask, &pvt->compat_mask) {
+		csd = per_cpu_ptr(pvt->csd_check, cpu);
+		csd->func = read_errors;
+		csd->info = edac_ctl;
+		csd->flags = 0;
+		/* Read CPU L1/L2 errors */
+		smp_call_function_single_async(cpu, csd);
+		/* Wait until flags cleared */
+		smp_cond_load_acquire(&csd->flags, !VAL);
+	}
+	put_online_cpus();
+}
+
+static int cortex_arm64_edac_probe(struct platform_device *pdev)
+{
+	int rc, cpu;
+	struct edac_device_ctl_info *edac_ctl;
+	struct device *dev = &pdev->dev;
+	struct device_node *np, *dn = pdev->dev.of_node;
+	struct of_phandle_iterator it;
+	struct arm64_pvt *pvt;
+
+	edac_ctl = edac_device_alloc_ctl_info(sizeof(*pvt), "cpu_cache",
+					      1, "L", 2, 1, NULL, 0,
+					      edac_device_alloc_index());
+	if (!edac_ctl)
+		return -ENOMEM;
+
+	pvt = edac_ctl->pvt_info;
+	pvt->csd_check = devm_alloc_percpu(dev, call_single_data_t);
+	if (!pvt->csd_check) {
+		rc = -ENOMEM;
+		goto out_dev;
+	}
+
+	of_for_each_phandle(&it, rc, dn, "cpus", NULL, 0) {
+		np = it.node;
+		cpu = of_cpu_node_to_id(np);
+		if (cpu < 0)
+			continue;
+
+		cpumask_set_cpu(cpu, &pvt->compat_mask);
+	}
+
+	edac_ctl->edac_check = cortex_arm64_edac_check;
+	edac_ctl->dev = dev;
+	edac_ctl->mod_name = dev_name(dev);
+	edac_ctl->dev_name = dev_name(dev);
+	edac_ctl->ctl_name = EDAC_MOD_STR;
+	dev_set_drvdata(dev, edac_ctl);
+
+	rc = edac_device_add_device(edac_ctl);
+	if (rc)
+		goto out_dev;
+
+	return 0;
+
+out_dev:
+	edac_device_free_ctl_info(edac_ctl);
+
+	return rc;
+}
+
+static int cortex_arm64_edac_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_ctl = dev_get_drvdata(&pdev->dev);
+
+	edac_device_del_device(edac_ctl->dev);
+	edac_device_free_ctl_info(edac_ctl);
+
+	return 0;
+}
+
+static const struct of_device_id cortex_arm64_edac_of_match[] = {
+	{ .compatible = "arm,cortex-a53-edac" },
+	{ .compatible = "arm,cortex-a57-edac" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cortex_arm64_edac_of_match);
+
+static struct platform_driver cortex_arm64_edac_driver = {
+	.probe = cortex_arm64_edac_probe,
+	.remove = cortex_arm64_edac_remove,
+	.driver = {
+		.name = EDAC_MOD_STR,
+		.of_match_table = cortex_arm64_edac_of_match,
+	},
+};
+module_platform_driver(cortex_arm64_edac_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_DESCRIPTION("Cortex A57 and A53 L1 and L2 cache EDAC driver");
-- 
2.28.0

