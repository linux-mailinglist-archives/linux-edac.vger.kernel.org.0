Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C20ABE2E18
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2019 12:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393179AbfJXKER (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Oct 2019 06:04:17 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:23260 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJXKEQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Oct 2019 06:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571911453; x=1603447453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4KCMMZpS2yWJwSgaBYVhsBq4iT8r+FqZuYshqZbmTH4=;
  b=Z4AHFa54xy03robqGtdYoImYJMKxL1VPkgq00Ji7RfFmue/4TOwR/mcn
   8pDKJyt/6RDfwtcPOD5086suSa+tZNPV9WS9zUPvwf6PVhbj2vMW+6mtg
   rSp/AOumi1bC8dHNWY58X2TQgqGrnh23Qf+gb1Ar1dNhIVzw57UekUs2G
   M=;
X-IronPort-AV: E=Sophos;i="5.68,224,1569283200"; 
   d="scan'208";a="762728989"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 24 Oct 2019 10:04:12 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 1C6B1A33E6;
        Thu, 24 Oct 2019 10:04:08 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 10:04:08 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.162.31) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Oct 2019 10:03:58 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <talel@amazon.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v5 2/2] EDAC: al-mc-edac: Introduce Amazon's Annapurna Labs Memory Controller EDAC
Date:   Thu, 24 Oct 2019 13:03:27 +0300
Message-ID: <1571911407-29379-3-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571911407-29379-1-git-send-email-talel@amazon.com>
References: <1571911407-29379-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.31]
X-ClientProxiedBy: EX13D17UWB001.ant.amazon.com (10.43.161.252) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Amazon's Annapurna Labs Memory Controller EDAC supports ECC capability
for error detection and correction (Single bit error correction, Double
detection). This driver introduces EDAC driver for that capability.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 MAINTAINERS               |   7 +
 drivers/edac/Kconfig      |   7 +
 drivers/edac/Makefile     |   1 +
 drivers/edac/al_mc_edac.c | 355 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 370 insertions(+)
 create mode 100644 drivers/edac/al_mc_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 55199ef..d431e8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -757,6 +757,13 @@ F:	drivers/tty/serial/altera_jtaguart.c
 F:	include/linux/altera_uart.h
 F:	include/linux/altera_jtaguart.h
 
+AMAZON ANNAPURNA LABS MEMORY CONTROLLER EDAC
+M:	Talel Shenhar <talel@amazon.com>
+M:	Talel Shenhar <talelshenhar@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
+F:	drivers/edac/al_mc_edac.c
+
 AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
 M:	Talel Shenhar <talel@amazon.com>
 S:	Maintained
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 417dad6..8c7fb73 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -100,6 +100,13 @@ config EDAC_AMD64_ERROR_INJECTION
 	  In addition, there are two control files, inject_read and inject_write,
 	  which trigger the DRAM ECC Read and Write respectively.
 
+config EDAC_AL_MC
+	tristate "Amazon's Annapurna Lab EDAC Memory Controller"
+	depends on (ARCH_ALPINE || COMPILE_TEST)
+	help
+	  Support for error detection and correction for Amazon's Annapurna
+	  Labs Alpine chips which allows 1 bit correction and 2 bits detection.
+
 config EDAC_AMD76X
 	tristate "AMD 76x (760, 762, 768)"
 	depends on PCI && X86_32
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index d77200c..5288329 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_EDAC_GHES)			+= ghes_edac.o
 edac_mce_amd-y				:= mce_amd.o
 obj-$(CONFIG_EDAC_DECODE_MCE)		+= edac_mce_amd.o
 
+obj-$(CONFIG_EDAC_AL_MC)		+= al_mc_edac.o
 obj-$(CONFIG_EDAC_AMD76X)		+= amd76x_edac.o
 obj-$(CONFIG_EDAC_CPC925)		+= cpc925_edac.o
 obj-$(CONFIG_EDAC_I5000)		+= i5000_edac.o
diff --git a/drivers/edac/al_mc_edac.c b/drivers/edac/al_mc_edac.c
new file mode 100644
index 00000000..b9ef7dd
--- /dev/null
+++ b/drivers/edac/al_mc_edac.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/edac.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include "edac_module.h"
+
+/* Registers Offset */
+#define AL_MC_MSTR		0x00
+#define AL_MC_ECC_CFG		0x70
+#define AL_MC_ECC_CLEAR		0x7c
+#define AL_MC_ECC_ERR_COUNT	0x80
+#define AL_MC_ECC_CE_ADDR0	0x84
+#define AL_MC_ECC_CE_ADDR1	0x88
+#define AL_MC_ECC_UE_ADDR0	0xa4
+#define AL_MC_ECC_UE_ADDR1	0xa8
+#define AL_MC_ECC_CE_SYND0	0x8c
+#define AL_MC_ECC_CE_SYND1	0x90
+#define AL_MC_ECC_CE_SYND2	0x94
+#define AL_MC_ECC_UE_SYND0	0xac
+#define AL_MC_ECC_UE_SYND1	0xb0
+#define AL_MC_ECC_UE_SYND2	0xb4
+
+/* Registers Fields */
+#define AL_MC_MSTR_DEV_CFG		GENMASK(31, 30)
+#define AL_MC_MSTR_RANKS		GENMASK(27, 24)
+#define AL_MC_MSTR_DATA_BUS_WIDTH	GENMASK(13, 12)
+#define AL_MC_MSTR_DDR4			BIT(4)
+#define AL_MC_MSTR_DDR3			BIT(0)
+
+#define AL_MC_ECC_CFG_SCRUB_DISABLED	BIT(4)
+#define AL_MC_ECC_CFG_ECC_MODE		GENMASK(2, 0)
+
+#define AL_MC_ECC_CLEAR_UE_COUNT	BIT(3)
+#define AL_MC_ECC_CLEAR_CE_COUNT	BIT(2)
+#define AL_MC_ECC_CLEAR_UE_ERR		BIT(1)
+#define AL_MC_ECC_CLEAR_CE_ERR		BIT(0)
+
+#define AL_MC_ECC_ERR_COUNT_UE		GENMASK(31, 16)
+#define AL_MC_ECC_ERR_COUNT_CE		GENMASK(15, 0)
+
+#define AL_MC_ECC_CE_ADDR0_RANK		GENMASK(25, 24)
+#define AL_MC_ECC_CE_ADDR0_ROW		GENMASK(17, 0)
+
+#define AL_MC_ECC_CE_ADDR1_BG		GENMASK(25, 24)
+#define AL_MC_ECC_CE_ADDR1_BANK		GENMASK(18, 16)
+#define AL_MC_ECC_CE_ADDR1_COLUMN	GENMASK(11, 0)
+
+#define AL_MC_ECC_UE_ADDR0_RANK		GENMASK(25, 24)
+#define AL_MC_ECC_UE_ADDR0_ROW		GENMASK(17, 0)
+
+#define AL_MC_ECC_UE_ADDR1_BG		GENMASK(25, 24)
+#define AL_MC_ECC_UE_ADDR1_BANK		GENMASK(18, 16)
+#define AL_MC_ECC_UE_ADDR1_COLUMN	GENMASK(11, 0)
+
+/* Registers Values */
+#define AL_MC_MSTR_DEV_CFG_X4	0
+#define AL_MC_MSTR_DEV_CFG_X8	1
+#define AL_MC_MSTR_DEV_CFG_X16	2
+#define AL_MC_MSTR_DEV_CFG_X32	3
+#define AL_MC_MSTR_RANKS_MAX 4
+#define AL_MC_MSTR_DATA_BUS_WIDTH_X64	0
+
+#define DRV_NAME "al_mc_edac"
+#define AL_MC_EDAC_MSG_MAX 256
+#define AL_MC_EDAC_MSG(message, buffer_size, type,			\
+		       rank, row, bg, bank, column, syn0, syn1, syn2)	\
+	snprintf(message, buffer_size,					\
+		 "%s rank=0x%x row=0x%x bg=0x%x bank=0x%x col=0x%x "	\
+		 "syn0: 0x%x syn1: 0x%x syn2: 0x%x",			\
+		 type == HW_EVENT_ERR_UNCORRECTED ? "UE" : "CE",	\
+		 rank, row, bg, bank, column, syn0, syn1, syn2)
+
+struct al_mc_edac {
+	void __iomem *mmio_base;
+	spinlock_t lock;
+	int irq_ce;
+	int irq_ue;
+};
+
+static int al_mc_edac_handle_ce(struct mem_ctl_info *mci)
+{
+	struct al_mc_edac *al_mc = mci->pvt_info;
+	u32 eccerrcnt, ecccaddr0, ecccaddr1, ecccsyn0, ecccsyn1, ecccsyn2, row;
+	u16 ce_count, column;
+	u8 rank, bg, bank;
+	char msg[AL_MC_EDAC_MSG_MAX];
+	unsigned long flags;
+
+	eccerrcnt = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_ERR_COUNT);
+	ce_count = FIELD_GET(AL_MC_ECC_ERR_COUNT_CE, eccerrcnt);
+	if (!ce_count)
+		return 0;
+
+	ecccaddr0 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_CE_ADDR0);
+	ecccaddr1 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_CE_ADDR1);
+	ecccsyn0 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND0);
+	ecccsyn1 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND1);
+	ecccsyn2 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND2);
+
+	writel_relaxed(AL_MC_ECC_CLEAR_CE_COUNT | AL_MC_ECC_CLEAR_CE_ERR,
+		       al_mc->mmio_base + AL_MC_ECC_CLEAR);
+
+	dev_dbg(mci->pdev, "eccuaddr0=0x%08x eccuaddr1=0x%08x\n",
+		ecccaddr0, ecccaddr1);
+
+	rank = FIELD_GET(AL_MC_ECC_CE_ADDR0_RANK, ecccaddr0);
+	row = FIELD_GET(AL_MC_ECC_CE_ADDR0_ROW, ecccaddr0);
+
+	bg = FIELD_GET(AL_MC_ECC_CE_ADDR1_BG, ecccaddr1);
+	bank = FIELD_GET(AL_MC_ECC_CE_ADDR1_BANK, ecccaddr1);
+	column = FIELD_GET(AL_MC_ECC_CE_ADDR1_COLUMN, ecccaddr1);
+
+	AL_MC_EDAC_MSG(msg, sizeof(msg), HW_EVENT_ERR_CORRECTED,
+		       rank, row, bg, bank, column,
+		       ecccsyn0, ecccsyn1, ecccsyn2);
+
+	spin_lock_irqsave(&al_mc->lock, flags);
+	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+			     ce_count, 0, 0, 0, 0, 0, -1, mci->ctl_name, msg);
+	spin_unlock_irqrestore(&al_mc->lock, flags);
+
+	return ce_count;
+}
+
+static int al_mc_edac_handle_ue(struct mem_ctl_info *mci)
+{
+	struct al_mc_edac *al_mc = mci->pvt_info;
+	u32 eccerrcnt, eccuaddr0, eccuaddr1, eccusyn0, eccusyn1, eccusyn2, row;
+	u16 ue_count, column;
+	u8 rank, bg, bank;
+	char msg[AL_MC_EDAC_MSG_MAX];
+	unsigned long flags;
+
+	eccerrcnt = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_ERR_COUNT);
+	ue_count = FIELD_GET(AL_MC_ECC_ERR_COUNT_UE, eccerrcnt);
+	if (!ue_count)
+		return 0;
+
+	eccuaddr0 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_ADDR0);
+	eccuaddr1 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_ADDR1);
+	eccusyn0 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND0);
+	eccusyn1 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND1);
+	eccusyn2 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND2);
+
+	writel_relaxed(AL_MC_ECC_CLEAR_UE_COUNT | AL_MC_ECC_CLEAR_UE_ERR,
+		       al_mc->mmio_base + AL_MC_ECC_CLEAR);
+
+	dev_dbg(mci->pdev, "eccuaddr0=0x%08x eccuaddr1=0x%08x\n",
+		eccuaddr0, eccuaddr1);
+
+	rank = FIELD_GET(AL_MC_ECC_UE_ADDR0_RANK, eccuaddr0);
+	row = FIELD_GET(AL_MC_ECC_UE_ADDR0_ROW, eccuaddr0);
+
+	bg = FIELD_GET(AL_MC_ECC_UE_ADDR1_BG, eccuaddr1);
+	bank = FIELD_GET(AL_MC_ECC_UE_ADDR1_BANK, eccuaddr1);
+	column = FIELD_GET(AL_MC_ECC_UE_ADDR1_COLUMN, eccuaddr1);
+
+	AL_MC_EDAC_MSG(msg, sizeof(msg), HW_EVENT_ERR_UNCORRECTED,
+		       rank, row, bg, bank, column,
+		       eccusyn0, eccusyn1, eccusyn2);
+
+	spin_lock_irqsave(&al_mc->lock, flags);
+	edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+			     ue_count, 0, 0, 0, 0, 0, -1, mci->ctl_name, msg);
+	spin_unlock_irqrestore(&al_mc->lock, flags);
+
+	return ue_count;
+}
+
+static void al_mc_edac_check(struct mem_ctl_info *mci)
+{
+	struct al_mc_edac *al_mc = mci->pvt_info;
+
+	if (al_mc->irq_ue <= 0)
+		al_mc_edac_handle_ue(mci);
+
+	if (al_mc->irq_ce <= 0)
+		al_mc_edac_handle_ce(mci);
+}
+
+static irqreturn_t al_mc_edac_irq_handler_ue(int irq, void *info)
+{
+	struct platform_device *pdev = info;
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+
+	if (al_mc_edac_handle_ue(mci))
+		return IRQ_HANDLED;
+	return IRQ_NONE;
+}
+
+static irqreturn_t al_mc_edac_irq_handler_ce(int irq, void *info)
+{
+	struct platform_device *pdev = info;
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+
+	if (al_mc_edac_handle_ce(mci))
+		return IRQ_HANDLED;
+	return IRQ_NONE;
+}
+
+static enum scrub_type al_mc_edac_get_scrub_mode(void __iomem *mmio_base)
+{
+	u32 ecccfg0;
+
+	ecccfg0 = readl(mmio_base + AL_MC_ECC_CFG);
+
+	if (FIELD_GET(AL_MC_ECC_CFG_SCRUB_DISABLED, ecccfg0))
+		return SCRUB_NONE;
+	else
+		return SCRUB_HW_SRC;
+}
+
+static void devm_al_mc_edac_del(void *data)
+{
+	edac_mc_del_mc(data);
+}
+
+static void devm_al_mc_edac_free(void *data)
+{
+	edac_mc_free(data);
+}
+
+static int al_mc_edac_probe(struct platform_device *pdev)
+{
+	void __iomem *mmio_base;
+	struct edac_mc_layer layers[1];
+	struct mem_ctl_info *mci;
+	struct al_mc_edac *al_mc;
+	int ret;
+
+	mmio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mmio_base)) {
+		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
+			PTR_ERR(mmio_base));
+		return PTR_ERR(mmio_base);
+	}
+
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = 1;
+	layers[0].is_virt_csrow = false;
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
+			    sizeof(struct al_mc_edac));
+	if (!mci)
+		return -ENOMEM;
+
+	ret = devm_add_action(&pdev->dev, devm_al_mc_edac_free, mci);
+	if (ret) {
+		edac_mc_free(mci);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, mci);
+	al_mc = mci->pvt_info;
+
+	al_mc->mmio_base = mmio_base;
+
+	al_mc->irq_ue = of_irq_get_byname(pdev->dev.of_node, "ue");
+	if (al_mc->irq_ue <= 0)
+		dev_dbg(&pdev->dev,
+			"no irq defined for ue - falling back to polling\n");
+
+	al_mc->irq_ce = of_irq_get_byname(pdev->dev.of_node, "ce");
+	if (al_mc->irq_ce <= 0)
+		dev_dbg(&pdev->dev,
+			"no irq defined for ce - falling back to polling\n");
+
+	if (al_mc->irq_ue <= 0 || al_mc->irq_ce <= 0)
+		edac_op_state = EDAC_OPSTATE_POLL;
+	else
+		edac_op_state = EDAC_OPSTATE_INT;
+
+	spin_lock_init(&al_mc->lock);
+
+	mci->edac_check = al_mc_edac_check;
+	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
+	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->mod_name = DRV_NAME;
+	mci->ctl_name = "al_mc";
+	mci->pdev = &pdev->dev;
+	mci->scrub_mode = al_mc_edac_get_scrub_mode(mmio_base);
+
+	ret = edac_mc_add_mc(mci);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"fail to add memory controller device (%d)\n",
+			ret);
+		return ret;
+	}
+
+	ret = devm_add_action(&pdev->dev, devm_al_mc_edac_del, &pdev->dev);
+	if (ret) {
+		edac_mc_del_mc(&pdev->dev);
+		return ret;
+	}
+
+	if (al_mc->irq_ue > 0) {
+		ret = devm_request_irq(&pdev->dev,
+				       al_mc->irq_ue,
+				       al_mc_edac_irq_handler_ue,
+				       IRQF_SHARED,
+				       pdev->name,
+				       pdev);
+		if (ret != 0) {
+			dev_err(&pdev->dev,
+				"failed to request ue irq %d (%d)\n",
+				al_mc->irq_ue, ret);
+			return ret;
+		}
+	}
+
+	if (al_mc->irq_ce > 0) {
+		ret = devm_request_irq(&pdev->dev,
+				       al_mc->irq_ce,
+				       al_mc_edac_irq_handler_ce,
+				       IRQF_SHARED,
+				       pdev->name,
+				       pdev);
+		if (ret != 0) {
+			dev_err(&pdev->dev,
+				"failed to request ce irq %d (%d)\n",
+				al_mc->irq_ce, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id al_mc_edac_of_match[] = {
+	{ .compatible = "amazon,al-mc-edac", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, al_mc_edac_of_match);
+
+static struct platform_driver al_mc_edac_driver = {
+	.probe = al_mc_edac_probe,
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = al_mc_edac_of_match,
+	},
+};
+
+module_platform_driver(al_mc_edac_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Talel Shenhar");
+MODULE_DESCRIPTION("Amazon's Annapurna Lab's Memory Controller EDAC Driver");
-- 
2.7.4

