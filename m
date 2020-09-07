Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01FF25F2C9
	for <lists+linux-edac@lfdr.de>; Mon,  7 Sep 2020 07:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgIGFsp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Sep 2020 01:48:45 -0400
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:38752
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726938AbgIGFsn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 7 Sep 2020 01:48:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmmR6LaurSXgAFm9zA36DZGapkoxZbCu0VpB8DSoXWsOnqn1oHeqj8ojbKcE6BtP25/uXu5LVMywK6/wzzhPwf7lbjNgW4Iw8HRTY1DxAWdJRSjlVDyA0paod3yxws9jLn2aTci7aYjDq/YrBDxnsfuKfA1ix+kqgIaIcIqyp95J+4y9xlnJBXL8kxz1cN8sOsmdT04Lx4atpQOSaV1VRujClMfULaepVsl4nnDJMrs0pS2nTULKrsxa/4MCgmTsP5wfi7BJrpxvf5wOmVWmYki7rl1RGswG4Okmo7amcpmkK7WNZZTpiwcnZEQAZuPpHfsWmZSpbqNgNa4HIkGSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VBaBg4r8bcm4ybHxU5UFq6h4DQIyjQdtEkIHpOgK2g=;
 b=MT7aUHxk1/+sGMxL0WZJbR3QVANoKKY9Bj8xD5Yb79nFD1x8sp7hPc5wbBxIUoaASVWQatqHgT0j2katKKKTsFzt0N3WB/XOynfNCgSzCir2z1KJhtxEFR9ST6P7KzseMuWRMSmsqz82mWCyzSxR0Lv8ILzUDgTLJv3cRVL4gjwyok/POTrtE5DWrG2YjWYir/yifRGex+ktmZOlFeJhQ6B8RinRdDWScBTRzCur2DqS9sdc712R+blir0hNJEpiu7YQPQaOMkM3MdcwRVHb2FPaXra7BmR0az1CUT/VCUucZttdm69reFYcVPS2IBxdco0NmleFUuy5du/c99UGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VBaBg4r8bcm4ybHxU5UFq6h4DQIyjQdtEkIHpOgK2g=;
 b=G5mym+x/V/2O/6/tSaZ3t9PySean7nLil2xOcetvsLhR6bZjQwDMOAvRjBSFuawBTT/11+BhrR+wMYPfVhzttN+B1H01PVmS9tcxWqctKMkbyKXcF5gMOLkcF9TtvSf2Y5wFhG17VPSjhb6uwMjmhpOohpfHiHgt5ctVgFGFh8A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34) by BN6PR13MB1569.namprd13.prod.outlook.com
 (2603:10b6:404:119::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7; Mon, 7 Sep
 2020 05:48:35 +0000
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::4596:33b0:db2c:dea]) by BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::4596:33b0:db2c:dea%3]) with mapi id 15.20.3370.011; Mon, 7 Sep 2020
 05:48:35 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com
Cc:     aou@eecs.berkeley.edu, james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2 2/3] soc: sifive: Add SiFive specific Cadence DDR controller driver
Date:   Mon,  7 Sep 2020 11:17:58 +0530
Message-Id: <1599457679-8947-3-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599457679-8947-1-git-send-email-yash.shah@sifive.com>
References: <1599457679-8947-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::35) To BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by BM1PR01CA0141.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:40::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 05:48:31 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77fadfee-6ee1-462b-2f94-08d852f1a8fe
X-MS-TrafficTypeDiagnostic: BN6PR13MB1569:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR13MB156968F853F7B9AFF776F2D782280@BN6PR13MB1569.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHlaFUHzq7ewvRu7c3z2oNzc5hbm4OGns53FcbDS9sYMlu7l50e1nUIvEuiP6HAlYUtjT/Z4q1am/yaPHvG1bxAihc0ZyarH+qQieuWzvun84X7uUFc0Y9IEU1zLwUCi62rFGVy8oKc++xUTseqUGP1qbgLl/d/X0j/0qJOD45pisDX0OKZ/AgNExZbLyqYD9bhqlgP2rNSF/riqOUxCQXTorRyO/Mv8iTZvNXfQbjjtBbj3fvqDXYW1b989vsDReuKPRc8kLxOkCFAwAQzTz2a49Nm5FOPBsXbyZ4x4p2SSfW7fp/ryzZ4XCf2HrUV0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1301MB2020.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(376002)(396003)(136003)(366004)(39840400004)(346002)(83380400001)(44832011)(5660300002)(6506007)(2906002)(36756003)(6512007)(4326008)(6666004)(16526019)(186003)(8676002)(316002)(2616005)(956004)(52116002)(8936002)(6486002)(26005)(66476007)(107886003)(66556008)(66946007)(83170400001)(7416002)(478600001)(42882007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YU2hC0fASbbwihyt/cpcBDZUR7BpjKa2kvLloy24DWY4ivdjg6UW9NgDDAZ6YlAOkz2vvo9ZlbQf/Jf6mFdZYEhOMFBKPcyb52cnTX/TKPsKV1fl9076gVfvw83QGmUXZj+h1ME6GjL6K+NklUAsByj4ahlt1I8FdtY5NwXd/B6qZof4HKugD+rFnKfHF3JhNwHaCSZddYU/RwJIJeeBeDbE5W8V4HAxqfT8Ls10RnJCcu28uLrOx9tr3LPcChWJS3aBm6azlIIF25D/D/k3T2qDbP4rGI4xwfDco4QZkeYaCGJt9asp+W0beNxzsIhGtiZxs7pmFJUauaQ0r+OZwTCsvJXiSiARW+yuCTryN5+Xq8G93XcGe/iMNAWQ+DV+y2zr9X0mbJ2Dqd2O0RojgMx8hdYxGCDa9Ar34EDLWqnNfiyeVIX/xKY7V8OtZgPbor6KsjkCyWTx2fB2GDm8twEa6rqGV5i8cgRFckIcryMjie1ub5T6MMRBfVTgsOLbDvNA1XqPrPmSdbJV76pbT5k5ACqW9I7LsPHTKHZUJQpE2wW6rAZLjEGdNazaoIN0LaOJfxH9/CLfYbv1dZOJ9BAle+nehyfBvwC9a6TnIYkSSJZYrGst9dinMSrJiFSV+K26HnONO7Vo3BOUCDMBbw==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fadfee-6ee1-462b-2f94-08d852f1a8fe
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1301MB2020.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 05:48:35.2439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+KDsyKopI/0BgtqiKOIlWTdhtOLk9Xs1/LTwyiOymrpYvcmOtlywlgYK92IbmZkDLdqU7o5JutnLlHeVf23mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1569
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add a driver to manage the Cadence DDR controller present on SiFive SoCs
At present the driver manages the EDAC feature of the DDR controller.
Additional features may be added to the driver in future to control
other aspects of the DDR controller.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 drivers/soc/sifive/Kconfig      |   6 ++
 drivers/soc/sifive/Makefile     |   3 +-
 drivers/soc/sifive/sifive_ddr.c | 207 ++++++++++++++++++++++++++++++++++++++++
 include/soc/sifive/sifive_ddr.h |  73 ++++++++++++++
 4 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/sifive/sifive_ddr.c
 create mode 100644 include/soc/sifive/sifive_ddr.h

diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
index 58cf8c4..f41d8fe 100644
--- a/drivers/soc/sifive/Kconfig
+++ b/drivers/soc/sifive/Kconfig
@@ -7,4 +7,10 @@ config SIFIVE_L2
 	help
 	  Support for the L2 cache controller on SiFive platforms.
 
+config SIFIVE_DDR
+	bool "Sifive DDR controller driver"
+	help
+	  Support for the management of cadence DDR controller on SiFive
+	  platforms.
+
 endif
diff --git a/drivers/soc/sifive/Makefile b/drivers/soc/sifive/Makefile
index b5caff7..b4acb5c 100644
--- a/drivers/soc/sifive/Makefile
+++ b/drivers/soc/sifive/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_SIFIVE_L2)	+= sifive_l2_cache.o
+obj-$(CONFIG_SIFIVE_L2)		+= sifive_l2_cache.o
+obj-$(CONFIG_SIFIVE_DDR)	+= sifive_ddr.o
diff --git a/drivers/soc/sifive/sifive_ddr.c b/drivers/soc/sifive/sifive_ddr.c
new file mode 100644
index 0000000..b1b421c
--- /dev/null
+++ b/drivers/soc/sifive/sifive_ddr.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiFive specific cadence DDR controller Driver
+ *
+ * Copyright (C) 2019-2020 SiFive, Inc.
+ *
+ */
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/delay.h>
+#include <soc/sifive/sifive_ddr.h>
+
+static ATOMIC_NOTIFIER_HEAD(ddr_err_chain);
+
+int register_sifive_ddr_error_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&ddr_err_chain, nb);
+}
+EXPORT_SYMBOL_GPL(register_sifive_ddr_error_notifier);
+
+int unregister_sifive_ddr_error_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&ddr_err_chain, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_sifive_ddr_error_notifier);
+
+static void handle_ce(struct sifive_ddr_priv *pv)
+{
+	u64 err_c_addr = 0x0;
+	u64 err_c_data = 0x0;
+	u32 err_c_synd, err_c_id;
+	u32 sig_val_l, sig_val_h;
+
+	sig_val_l = readl(pv->reg + ECC_C_ADDR_L_REG);
+	sig_val_h = (readl(pv->reg + ECC_C_ADDR_H_REG) &
+		     ECC_ADDR_H_MASK);
+	err_c_addr = (((ulong)sig_val_h << CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+	sig_val_l = readl(pv->reg + ECC_C_DATA_L_REG);
+	sig_val_h = readl(pv->reg + ECC_C_DATA_H_REG);
+	err_c_data = (((ulong)sig_val_h << CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+	err_c_id = ((readl(pv->reg + ECC_U_C_ID_REG) &
+		     ECC_C_ID_MASK) >> ECC_C_ID_SHIFT);
+
+	err_c_synd = ((readl(pv->reg + ECC_C_SYND_REG) &
+		      ECC_SYND_MASK) >> ECC_SYND_SHIFT);
+
+	pv->error_count = 1;
+	pv->page_frame_number = err_c_addr >> PAGE_SHIFT;
+	pv->offset_in_page = err_c_addr & ~PAGE_MASK;
+	pv->syndrome = err_c_synd;
+	pv->top_layer = 0;
+	pv->mid_layer = 0;
+	pv->low_layer = -1;
+
+	atomic_notifier_call_chain(&ddr_err_chain, SIFIVE_DDR_ERR_TYPE_CE, pv);
+}
+
+static void handle_ue(struct sifive_ddr_priv *pv)
+{
+	u64 err_u_addr = 0x0;
+	u64 err_u_data = 0x0;
+	u32 err_u_synd, err_u_id;
+	u32 sig_val_l, sig_val_h;
+
+	sig_val_l = readl(pv->reg + ECC_U_ADDR_L_REG);
+	sig_val_h = (readl(pv->reg + ECC_U_ADDR_H_REG) &
+		     ECC_ADDR_H_MASK);
+	err_u_addr = (((ulong)sig_val_h << CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+	sig_val_l = readl(pv->reg + ECC_U_DATA_L_REG);
+	sig_val_h = readl(pv->reg + ECC_U_DATA_H_REG);
+	err_u_data = (((ulong)sig_val_h << CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+	err_u_id = ((readl(pv->reg + ECC_U_C_ID_REG) &
+		    ECC_U_ID_MASK) >> ECC_U_ID_SHIFT);
+
+	err_u_synd = ((readl(pv->reg + ECC_U_SYND_REG) &
+		      ECC_SYND_MASK) >> ECC_SYND_SHIFT);
+
+	pv->error_count = 1;
+	pv->page_frame_number = err_u_addr >> PAGE_SHIFT;
+	pv->offset_in_page = err_u_addr & ~PAGE_MASK;
+	pv->syndrome = err_u_synd;
+	pv->top_layer = 0;
+	pv->mid_layer = 0;
+	pv->low_layer = -1;
+
+	atomic_notifier_call_chain(&ddr_err_chain, SIFIVE_DDR_ERR_TYPE_UE, pv);
+}
+
+static irqreturn_t ecc_isr(int irq, void *ptr)
+{
+	struct sifive_ddr_priv *pv = ptr;
+	u32 intr_status;
+	u32 val;
+
+	/* Check the intr status and confirm ECC error intr */
+	intr_status = readl(pv->reg + ECC_CTL_INT_STATUS_REG);
+
+	dev_dbg(pv->dev, "InterruptStatus : 0x%x\n", intr_status);
+	val = intr_status & (ECC_INT_CE_UE_MASK);
+	if (!((val & ECC_CE_INTR_MASK) || (val & ECC_UE_INTR_MASK)))
+		return IRQ_NONE;
+
+	if (val & ECC_CE_INTR_MASK) {
+		handle_ce(pv);
+
+		/* Clear the interrupt source */
+		if (val & ECC_INT_CE_EVENT)
+			writel(ECC_INT_CE_EVENT,
+			       pv->reg + ECC_CTL_INT_ACK_REG);
+		else if (val & ECC_INT_SECOND_CE_EVENT)
+			writel(ECC_INT_SECOND_CE_EVENT,
+			       pv->reg + ECC_CTL_INT_ACK_REG);
+		else
+			dev_err(pv->dev, "Failed to clear IRQ\n");
+	}
+
+	if (val & ECC_UE_INTR_MASK) {
+		handle_ue(pv);
+
+		/* Clear the interrupt source */
+		if (val & ECC_INT_UE_EVENT)
+			writel(ECC_INT_UE_EVENT,
+			       pv->reg + ECC_CTL_INT_ACK_REG);
+		else if (val & ECC_INT_SECOND_UE_EVENT)
+			writel(ECC_INT_SECOND_UE_EVENT,
+			       pv->reg + ECC_CTL_INT_ACK_REG);
+		else
+			dev_err(pv->dev, "Failed to clear IRQ\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int sifive_ddr_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sifive_ddr_priv *priv;
+	struct resource *res;
+	int ret, irq;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->reg = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->reg))
+		return PTR_ERR(priv->reg);
+
+	irq = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(dev, irq, ecc_isr, 0, "sifive-fu540-ddr", priv);
+	if (ret) {
+		dev_err(dev, "request_irq failed\n");
+		return ret;
+	}
+
+	/* Enable & set CE/UE Interrupts for DDR4 Controller */
+	writel(~(ECC_INT_CE_UE_MASK), priv->reg + ECC_CTL_INT_MASK_REG);
+
+	platform_set_drvdata(pdev, priv);
+	dev_info(dev, "SiFive DDR probe successful\n");
+
+	return 0;
+}
+
+static int sifive_ddr_remove(struct platform_device *pdev)
+{
+	struct sifive_ddr_priv *priv = platform_get_drvdata(pdev);
+
+	/* Disable All ECC Interrupts for DDR4 Controller */
+	writel(ECC_INT_CE_UE_MASK, priv->reg + ECC_CTL_INT_MASK_REG);
+
+	return 0;
+}
+
+static const struct of_device_id sifive_ddr_of_match[] = {
+	{ .compatible = "sifive,fu540-c000-ddr"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, sifive_ddr_of_match);
+
+static struct platform_driver sifive_ddr_driver = {
+	.driver = {
+		.name = "sifive-ddr",
+		.of_match_table = sifive_ddr_of_match,
+	},
+	.probe = sifive_ddr_probe,
+	.remove = sifive_ddr_remove,
+};
+
+module_platform_driver(sifive_ddr_driver);
+
+MODULE_AUTHOR("SiFive");
+MODULE_DESCRIPTION("SiFive DDR Controller driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/soc/sifive/sifive_ddr.h b/include/soc/sifive/sifive_ddr.h
new file mode 100644
index 0000000..2ff8623
--- /dev/null
+++ b/include/soc/sifive/sifive_ddr.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SiFive DDR Controller header file
+ *
+ */
+
+#ifndef __SOC_SIFIVE_DDR_H
+#define __SOC_SIFIVE_DDR_H
+
+int register_sifive_ddr_error_notifier(struct notifier_block *nb);
+int unregister_sifive_ddr_error_notifier(struct notifier_block *nb);
+
+struct sifive_ddr_priv {
+	void __iomem *reg;
+	struct device *dev;
+	u16 error_count;
+	unsigned long page_frame_number;
+	unsigned long offset_in_page;
+	unsigned long syndrome;
+	int top_layer;
+	int mid_layer;
+	int low_layer;
+};
+
+#define SIFIVE_DDR_ERR_TYPE_CE	(0)
+#define SIFIVE_DDR_ERR_TYPE_UE	(1)
+#define SIFIVE_DDR_EDAC_GRAIN	(1)
+#define SIFIVE_MEM_TYPE_DDR4	0xA
+#define SIFIVE_DDR_WIDTH_16	(2)
+#define SIFIVE_DDR_WIDTH_32	(1)
+#define SIFIVE_DDR_WIDTH_64	(0)
+
+#define DDR_CTL_MEM_TYPE_REG	0x000
+#define DDR_CTL_MEM_WIDTH_REG	0x004
+#define ECC_CTL_CONTROL_REG	0x174
+#define ECC_U_ADDR_L_REG	0x180
+#define ECC_U_ADDR_H_REG	0x184
+#define ECC_U_DATA_L_REG	0x188
+#define ECC_U_DATA_H_REG	0x18c
+
+#define ECC_C_ADDR_L_REG	0x190
+#define ECC_C_ADDR_H_REG	0x194
+#define ECC_C_DATA_L_REG	0x198
+#define ECC_C_DATA_H_REG	0x19c
+#define ECC_U_C_ID_REG		0x1A0
+#define ECC_CTL_INT_STATUS_REG	0x210
+#define ECC_CTL_INT_ACK_REG	0x218
+#define ECC_CTL_INT_MASK_REG	0x220
+#define ECC_C_SYND_REG		ECC_C_ADDR_H_REG
+#define ECC_U_SYND_REG		ECC_U_ADDR_H_REG
+
+#define ECC_CTL_MTYPE_MASK	GENMASK(11, 8)
+#define CTL_MEM_MAX_WIDTH_MASK	GENMASK(31, 24)
+#define ECC_ADDR_H_MASK		GENMASK(3, 0)
+#define ECC_INT_CE_UE_MASK	GENMASK(6, 3)
+#define ECC_CE_INTR_MASK	GENMASK(4, 3)
+#define ECC_UE_INTR_MASK	GENMASK(6, 5)
+#define ECC_INT_CE_EVENT	BIT(3)
+#define ECC_INT_SECOND_CE_EVENT	BIT(4)
+#define ECC_INT_UE_EVENT	BIT(5)
+#define ECC_INT_SECOND_UE_EVENT	BIT(6)
+#define ECC_CTL_ECC_ENABLE	BIT(16)
+
+#define ECC_C_ID_MASK		GENMASK(28, 16)
+#define ECC_U_ID_MASK		GENMASK(12, 0)
+#define ECC_C_ID_SHIFT		(16)
+#define ECC_U_ID_SHIFT		(0)
+#define ECC_SYND_MASK		GENMASK(15, 8)
+#define ECC_SYND_SHIFT		(8)
+
+#define CTL_REG_WIDTH_SHIFT	(32)
+
+#endif /* __SOC_SIFIVE_DDR_H */
-- 
2.7.4

