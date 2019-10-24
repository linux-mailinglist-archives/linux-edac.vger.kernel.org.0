Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B889E34A2
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2019 15:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393778AbfJXNqb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Oct 2019 09:46:31 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:52769 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393672AbfJXNqb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Oct 2019 09:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571924791; x=1603460791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9shMXuVkQ6HwQupiq3hiv7uWUB3vmGLNiOIYQyaGocc=;
  b=OrodthEEnxdJ9iHqnnvh+aFZkapq0Ii+yhzr23sDjD17kQZnt821HHqs
   IqlW6OxuewQqUmhPJedUVhOi6uVpRc5MvpJahBsUcHD0Si/3axWFZXJN+
   pp9vJu0xzixG5gjFi7TOhG8nvDqmv4Gys/qFOBZFjdSxvtz8F3/LZMTc4
   4=;
X-IronPort-AV: E=Sophos;i="5.68,224,1569283200"; 
   d="scan'208";a="762793042"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 24 Oct 2019 13:46:30 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id B86C3A2B87;
        Thu, 24 Oct 2019 13:46:26 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 13:46:25 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.34) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 13:46:16 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <talel@amazon.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v7 2/2] soc: amazon: al-pos-edac: Introduce Amazon's Annapurna Labs POS EDAC driver
Date:   Thu, 24 Oct 2019 16:45:46 +0300
Message-ID: <1571924746-8107-3-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571924746-8107-1-git-send-email-talel@amazon.com>
References: <1571924746-8107-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D21UWA004.ant.amazon.com (10.43.160.252) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Amazon's Annapurna Labs SoCs include a Point of Serialization error logging
unit that reports an error when a write error occurs (e.g. attempt to
write to a read only register).
This error shall be reported via the EDAC subsystem as uncorrectable-error.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 MAINTAINERS                |   7 ++
 drivers/edac/Kconfig       |   6 ++
 drivers/edac/Makefile      |   1 +
 drivers/edac/al_pos_edac.c | 174 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 188 insertions(+)
 create mode 100644 drivers/edac/al_pos_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 55199ef..30b39bd 100644
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
+F:	drivers/edac/al_pos_edac.c
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
index 00000000..8124e05
--- /dev/null
+++ b/drivers/edac/al_pos_edac.c
@@ -0,0 +1,174 @@
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
+static void devm_al_pos_edac_free(void *data)
+{
+	edac_device_free_ctl_info(data);
+}
+
+static void devm_al_pos_edac_del(void *data)
+{
+	edac_device_del_device(data);
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
+	ret = devm_add_action(&pdev->dev, devm_al_pos_edac_free, edac_dev);
+	if (ret) {
+		edac_device_free_ctl_info(edac_dev);
+		return ret;
+	}
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
+	edac_dev->ctl_name = "AL_POS";
+
+	ret = edac_device_add_device(edac_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add edac device\n");
+		return ret;
+	}
+
+	ret = devm_add_action(&pdev->dev, devm_al_pos_edac_del, edac_dev->dev);
+	if (ret) {
+		edac_device_del_device(edac_dev->dev);
+		return ret;
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
+			return ret;
+		}
+	}
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

