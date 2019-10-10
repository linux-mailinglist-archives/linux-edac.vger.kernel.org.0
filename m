Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F72D285F
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 13:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfJJLus (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 07:50:48 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:11643 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfJJLus (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Oct 2019 07:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570708245; x=1602244245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=XO2XVNBmGjOlX7Ad5DAyl4l7CYojTTUvKxCHs6QuMb4=;
  b=vE8I8Fi8Eku4P7nHZ2+lwTMhwojJhL2M1xgy7lbfac01D0gH4S0Hyz80
   GvUBJ4BLX+v8waF1QqHpI4PvKTFDudmrzZlRl+sV4uAMUxpgZdw6LPPGf
   4uG5yuIxqjCW8OzCLogvjqwu+h9X/LfJM0328yBWc6zFO5P/ZYPcWib2T
   s=;
X-IronPort-AV: E=Sophos;i="5.67,280,1566864000"; 
   d="scan'208";a="840492863"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 10 Oct 2019 11:43:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 8A832A1D44;
        Thu, 10 Oct 2019 11:42:01 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 10 Oct 2019 11:42:00 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.160.153) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 10 Oct 2019 11:41:51 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
        <arnd@arndb.de>, <bp@alien8.de>, <mchehab@kernel.org>,
        <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <paulmck@linux.ibm.com>,
        <talel@amazon.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v6 2/2] soc: amazon: al-pos-edac: Introduce Amazon's Annapurna Labs POS EDAC driver
Date:   Thu, 10 Oct 2019 14:41:21 +0300
Message-ID: <1570707681-865-3-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570707681-865-1-git-send-email-talel@amazon.com>
References: <1570707681-865-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.153]
X-ClientProxiedBy: EX13D21UWA001.ant.amazon.com (10.43.160.154) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Amazon's Annapurna Labs SoCs includes Point Of Serialization error
logging unit that reports an error in case write error (e.g . Attempt to
write to a read only register).
This error shall be reported to EDAC subsystem as uncorrectable-error.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 MAINTAINERS                |   7 ++
 drivers/edac/Kconfig       |   6 ++
 drivers/edac/Makefile      |   1 +
 drivers/edac/al_pos_edac.c | 173 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+)
 create mode 100644 drivers/edac/al_pos_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 55199ef..a77d554 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -757,6 +757,13 @@ F:	drivers/tty/serial/altera_jtaguart.c
 F:	include/linux/altera_uart.h
 F:	include/linux/altera_jtaguart.h
 
+AMAZON ANNAPURNA LABS POS EDAC DRIVER
+M:	Talel Shenhar <talel@amazon.com>
+M:	Talel Shenhar <talelshenhar@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
+F:	drivers/edac/al-pos-edac.c
+
 AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
 M:	Talel Shenhar <talel@amazon.com>
 S:	Maintained
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 417dad6..bad1c09 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -100,6 +100,12 @@ config EDAC_AMD64_ERROR_INJECTION
 	  In addition, there are two control files, inject_read and inject_write,
 	  which trigger the DRAM ECC Read and Write respectively.
 
+config EDAC_AL_POS
+	tristate "Amazon's Annapurna Labs POS EDAC driver"
+	depends on (ARCH_ALPINE || COMPILE_TEST)
+	help
+	  Include support for the SoC POS EDAC error capability.
+
 config EDAC_AMD76X
 	tristate "AMD 76x (760, 762, 768)"
 	depends on PCI && X86_32
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index d77200c..7f6d958 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_EDAC_GHES)			+= ghes_edac.o
 edac_mce_amd-y				:= mce_amd.o
 obj-$(CONFIG_EDAC_DECODE_MCE)		+= edac_mce_amd.o
 
+obj-$(CONFIG_EDAC_AL_POS)		+= al_pos_edac.o
 obj-$(CONFIG_EDAC_AMD76X)		+= amd76x_edac.o
 obj-$(CONFIG_EDAC_CPC925)		+= cpc925_edac.o
 obj-$(CONFIG_EDAC_I5000)		+= i5000_edac.o
diff --git a/drivers/edac/al_pos_edac.c b/drivers/edac/al_pos_edac.c
new file mode 100644
index 00000000..a85ab67
--- /dev/null
+++ b/drivers/edac/al_pos_edac.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+#include <linux/bitfield.h>
+#include <linux/edac.h>
+#include <linux/of_irq.h>
+#include "edac_module.h"
+
+#define DRV_NAME "al_pos_edac"
+#define AL_POS_EDAC_MSG_MAX 256
+
+/* Registers Offset */
+#define AL_POS_ERROR_LOG_1	0x0
+#define AL_POS_ERROR_LOG_0	0x4
+
+/* Registers Fields */
+#define AL_POS_ERROR_LOG_1_VALID	BIT(31)
+#define AL_POS_ERROR_LOG_1_BRESP	GENMASK(18, 17)
+#define AL_POS_ERROR_LOG_1_REQUEST_ID	GENMASK(16, 8)
+#define AL_POS_ERROR_LOG_1_ADDR_HIGH	GENMASK(7, 0)
+
+#define AL_POS_ERROR_LOG_0_ADDR_LOW	GENMASK(31, 0)
+
+struct al_pos_edac {
+	struct edac_device_ctl_info *edac_dev;
+	void __iomem *mmio_base;
+	int irq;
+};
+
+static int al_pos_handle(struct al_pos_edac *al_pos)
+{
+	u32 log0, log1;
+	u64 addr;
+	u16 request_id;
+	u8 bresp;
+	char msg[AL_POS_EDAC_MSG_MAX];
+
+	log1 = readl_relaxed(al_pos->mmio_base + AL_POS_ERROR_LOG_1);
+	if (!FIELD_GET(AL_POS_ERROR_LOG_1_VALID, log1))
+		return 0;
+
+	log0 = readl_relaxed(al_pos->mmio_base + AL_POS_ERROR_LOG_0);
+	writel_relaxed(0, al_pos->mmio_base + AL_POS_ERROR_LOG_1);
+
+	addr = FIELD_GET(AL_POS_ERROR_LOG_0_ADDR_LOW, log0);
+	addr |= (((u64)FIELD_GET(AL_POS_ERROR_LOG_1_ADDR_HIGH, log1)) << 32);
+	request_id = FIELD_GET(AL_POS_ERROR_LOG_1_REQUEST_ID, log1);
+	bresp = FIELD_GET(AL_POS_ERROR_LOG_1_BRESP, log1);
+
+	snprintf(msg, sizeof(msg),
+		 "addr=0x%llx request_id=0x%x bresp=0x%x\n",
+		 addr, request_id, bresp);
+
+	edac_device_handle_ue(al_pos->edac_dev, 0, 0, msg);
+
+	return 1;
+}
+
+static void al_pos_edac_check(struct edac_device_ctl_info *edac_dev)
+{
+	struct al_pos_edac *al_pos = edac_dev->pvt_info;
+
+	al_pos_handle(al_pos);
+}
+
+static irqreturn_t al_pos_irq_handler(int irq, void *info)
+{
+	struct platform_device *pdev = info;
+	struct al_pos_edac *al_pos = platform_get_drvdata(pdev);
+
+	if (al_pos_handle(al_pos))
+		return IRQ_HANDLED;
+	return IRQ_NONE;
+}
+
+static int al_pos_probe(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edac_dev;
+	struct al_pos_edac *al_pos;
+	int ret;
+
+	edac_dev = edac_device_alloc_ctl_info(sizeof(*al_pos), DRV_NAME, 1,
+					      DRV_NAME, 1, 0, NULL, 0,
+					      edac_device_alloc_index());
+	if (!edac_dev)
+		return -ENOMEM;
+
+	al_pos = edac_dev->pvt_info;
+	al_pos->edac_dev = edac_dev;
+	platform_set_drvdata(pdev, al_pos);
+
+	al_pos->mmio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(al_pos->mmio_base)) {
+		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
+			PTR_ERR(al_pos->mmio_base));
+		return PTR_ERR(al_pos->mmio_base);
+	}
+
+	al_pos->irq = platform_get_irq(pdev, 0);
+	if (al_pos->irq <= 0)
+		edac_dev->edac_check = al_pos_edac_check;
+
+	edac_dev->dev = &pdev->dev;
+	edac_dev->mod_name = DRV_NAME;
+	edac_dev->dev_name = dev_name(&pdev->dev);
+	edac_dev->ctl_name = "POS";
+
+	ret = edac_device_add_device(edac_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add edac device\n");
+		goto err_free_edac;
+	}
+
+	if (al_pos->irq > 0) {
+		ret = devm_request_irq(&pdev->dev,
+				       al_pos->irq,
+				       al_pos_irq_handler,
+				       0,
+				       pdev->name,
+				       pdev);
+		if (ret != 0) {
+			dev_err(&pdev->dev,
+				"failed to register to irq %d (%d)\n",
+				al_pos->irq, ret);
+			goto err_remove_edac;
+		}
+	}
+
+	return 0;
+
+err_remove_edac:
+	edac_device_del_device(edac_dev->dev);
+err_free_edac:
+	edac_device_free_ctl_info(edac_dev);
+
+	return ret;
+}
+
+static int al_pos_remove(struct platform_device *pdev)
+{
+	struct al_pos_edac *al_pos = platform_get_drvdata(pdev);
+
+	if (al_pos->irq > 0)
+		devm_free_irq(&pdev->dev, al_pos->irq, pdev);
+
+	edac_device_del_device(al_pos->edac_dev->dev);
+	edac_device_free_ctl_info(al_pos->edac_dev);
+
+	return 0;
+}
+
+static const struct of_device_id al_pos_of_match[] = {
+	{ .compatible = "amazon,al-pos-edac", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, al_pos_of_match);
+
+static struct platform_driver al_pos_driver = {
+	.probe = al_pos_probe,
+	.remove = al_pos_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = al_pos_of_match,
+	},
+};
+
+module_platform_driver(al_pos_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Talel Shenhar");
+MODULE_DESCRIPTION("Amazon's Annapurna Labs POS driver");
-- 
2.7.4

