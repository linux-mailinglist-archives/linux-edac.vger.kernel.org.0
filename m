Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009FC2B04A4
	for <lists+linux-edac@lfdr.de>; Thu, 12 Nov 2020 13:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgKLMBx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Nov 2020 07:01:53 -0500
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:42880
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727147AbgKLMBu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 12 Nov 2020 07:01:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CImiXrdV1zE/TBnDXH9bPxZPJAvk3tE6y1p02BgyLgMdr82qIYc5fBW2ZNhb0Qme2JXt+1hmSkjFURBJPZTWmk7SocDG3bivdLG7n6/BlbCEEZHNF0I5Czo4KC0usEU4bG93aixKZJFDSW/oIQAunJE3yYOUB+LRbjewgoGfHNPbcRvYsYa4AzmHAz+f1OKz9C9ToomG3l+RsgiB+kcD11hpgFRxTgYaQEgNd3g8EKC2MqXyiUKe8dzIe56DcIW0T2Gudy8RqDg/GJATUjrHfKogQINF2EodurOX4vr5aWd5CtpRYQJsyu9ZWLTLVgVzj0XnJpU3AMRYDNtefTVlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMMYti2sAncxNQC++YVn/6QrK6d5QOx7DpOdAZRI5/g=;
 b=i/jfW5qSDPxCdF1v7B3w9VcMQLpusJFm98X2ZOnj8Rdb2CIBn0Idr8eAGTRa68DZxZhGuiLj+YbSUv5ILIwF2POSS1yNkrfI6R/GMO/HY/iiqTmld6oTTqf/2vkhKqmy7tYwLEte/JhSiEjbQUZu7HbJHiAceS3NT3EANJxvp5n4VMLRlsvMYAHoif+uA4ff4kdQ2yfv9o0IL5GmX8a0dKSwyy9AC9C+tu/dbCHXQvnkQgvlj+t5FcJbzxz0Zfj/ifvGDEyIlqxtkdX0RI3MaO/lhPQ6YIGRxL4ES5jKAnVYj6yoeyhn2iN1Aa9Zm2yBkcJgOZ4aCSpt/guVfFQojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMMYti2sAncxNQC++YVn/6QrK6d5QOx7DpOdAZRI5/g=;
 b=KF9Tkw1VyIee6aa32YHkpMjFNXFEyL5IQ5wEpFoj7vvvxh3kGRIPuEhY33VziWCe5qx0DO4AYqT7hSBQ3G+ESFyJ7RDJOdkPRQ/A8vjM9LWnBxzpwDSGEszKCAy8SmRfY3ufBhO2b7PYDd2VZWNs6H0FKBc1BYYliM4xo4YNTrE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BY5PR13MB4453.namprd13.prod.outlook.com (2603:10b6:a03:1d1::19)
 by BYAPR13MB2392.namprd13.prod.outlook.com (2603:10b6:a02:c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Thu, 12 Nov
 2020 12:01:29 +0000
Received: from BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::2c46:9095:ba12:6513]) by BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::2c46:9095:ba12:6513%8]) with mapi id 15.20.3564.021; Thu, 12 Nov 2020
 12:01:29 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     aou@eecs.berkeley.edu, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 2/3] soc: sifive: beu: Add support for SiFive Bus Error Unit
Date:   Thu, 12 Nov 2020 17:30:56 +0530
Message-Id: <1605182457-86046-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605182457-86046-1-git-send-email-yash.shah@sifive.com>
References: <1605182457-86046-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-Originating-IP: [159.117.144.156]
X-ClientProxiedBy: BMXPR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::34) To BY5PR13MB4453.namprd13.prod.outlook.com
 (2603:10b6:a03:1d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by BMXPR01CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 12:01:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 268ed3b7-d3c1-4cab-e73a-08d88702b055
X-MS-TrafficTypeDiagnostic: BYAPR13MB2392:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR13MB2392B95BBD0387CD4D22A27382E70@BYAPR13MB2392.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qqcqc/Oz1j9ZiiNdG8CkAYtIWwzqJsw16vYhzR4JopG0vadARe/WKDOLT5u5DmsRV+skoLIBaozR4XAjpqxelo5XpFLZoXhE2wlTaMTfbNbiE/s+WZAMzJKXq3on1kmqmWlA0J6zoB/I5yzMGZN6H7yAKS+SW/TY5x9Hh2qXNgInLVnfOHi17mRkVLrHVeP8uCQ3I7n62b3XLOsAI/tKSbkeQa9qKslrm81Di5UQ0Rk/PvtFd2bH6d9XLKd6XsrVrNKgzEYaJodK1E64o5chBCVHv8Bseltsaw9vmwpYo0UpL2SF1bFqhnqztLUcmNAhZaTwzLJLyGL2R3dPXxKxGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR13MB4453.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(346002)(376002)(396003)(39850400004)(136003)(366004)(8936002)(42882007)(478600001)(5660300002)(66556008)(66476007)(6666004)(6506007)(316002)(36756003)(66946007)(6512007)(44832011)(26005)(16526019)(52116002)(107886003)(2906002)(6486002)(7416002)(83170400001)(83380400001)(8676002)(4326008)(956004)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dsObYNF+44XeHXK222xv4JzGqVq76A9QDZIFs+0AENd0fvsm0XxLcnnzyegjeFoGOeyn4M42YyNK7HIt5FX8UgWb84T3fMueB5xBQ5fUydrnj+n+9KqUXUqe0NOKmMXxySCBAkeL1rOyEAzxMePLbsiapN2XrzZucUep0hPVIQcOdzFM3UhudJNttDkLHkPCBQ5jU8EVHDEKxeVOa3mT59TOH0UiChq+KcDFjRcRvU7JsK1RwRV8LBvFWpQwyJmEK/xeg7Rpuw1zMr+iq52u6+7n9q+OSXo1+vQpXB/2rWHtEbZcIwByTFQedQV/OsgziD+CfUUzXYex3mcyGXYdRBoHIZ8SRui9EQ/BMBS4yIkvfnSWMyLikQIEX9qFjmhsLns2JZ5ZPbBc4aV+AllYm0QiYcXuajB7vdNHKRCHIYAdilNepu2/Kfe6Vgns2zoe76WTTl7fh61u5tQfeg4E3GBTFuLfl10pEPBK28z3e5cuN1poztiOw95DqA0lIR8k+xPFRO70ClUO2sBiZqLpdKxcEEN98PW0KJunDWNZOmhKRMIt4hLZJvsaWfWpCEiKj3T9UAESaCR2CyuQ7bq0VVBpko9zInxI1CxkU67Y2o3pm/TsBN2r3BXb8twKON01SmtsKwPLiGHSakYCWnu3PbAWfbqkLX0OwI5HUOARc4eWZJrKMr9wrbQLPRQrS3pDRZpLFpl0R93ObGHEwp2UK0k7Jamy40Syde34gP0UugQMGtYtRrtdboe0SV6us/dtYQbXxPHJUw614wKsImtCFdZIx+s89grLlLGSjfHpPIpwthHCFzvV93KbtaJvjLVEU1xz4cWdH1CUj9iEtLMnSZNlVN/Vrv7NQVzSkvJalhpwSO4gUsuamg2htQKodqRWpd2rsfAOFd2xK9bdDc9kOg==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268ed3b7-d3c1-4cab-e73a-08d88702b055
X-MS-Exchange-CrossTenant-AuthSource: BY5PR13MB4453.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 12:01:29.2761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOmMBYmT/HP0HmIvP/qvvSrDVBfXNVuEsoDpoVDV4Kaj1GR+ORTjWWr5HS/Y+e+LfDB4YmCw4UPmoNuXk30LmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2392
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add driver support for Bus Error Unit present in SiFive's FU740 chip.
Currently the driver reports erroneous events only using Platform-level
interrupts. The support for reporting events using hart-local interrupts
can be added in future.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 drivers/soc/sifive/Kconfig      |   5 +
 drivers/soc/sifive/Makefile     |   1 +
 drivers/soc/sifive/sifive_beu.c | 197 ++++++++++++++++++++++++++++++++++++++++
 include/soc/sifive/sifive_beu.h |  16 ++++
 4 files changed, 219 insertions(+)
 create mode 100644 drivers/soc/sifive/sifive_beu.c
 create mode 100644 include/soc/sifive/sifive_beu.h

diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
index 58cf8c4..d575fc1 100644
--- a/drivers/soc/sifive/Kconfig
+++ b/drivers/soc/sifive/Kconfig
@@ -7,4 +7,9 @@ config SIFIVE_L2
 	help
 	  Support for the L2 cache controller on SiFive platforms.
 
+config SIFIVE_BEU
+	bool "Sifive Bus Error Unit"
+	help
+	  Support for the Bus Error Unit on SiFive platforms.
+
 endif
diff --git a/drivers/soc/sifive/Makefile b/drivers/soc/sifive/Makefile
index b5caff7..1b43ecd 100644
--- a/drivers/soc/sifive/Makefile
+++ b/drivers/soc/sifive/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_SIFIVE_L2)	+= sifive_l2_cache.o
+obj-$(CONFIG_SIFIVE_BEU)	+= sifive_beu.o
diff --git a/drivers/soc/sifive/sifive_beu.c b/drivers/soc/sifive/sifive_beu.c
new file mode 100644
index 0000000..87b69ba
--- /dev/null
+++ b/drivers/soc/sifive/sifive_beu.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiFive Bus Error Unit driver
+ * Copyright (C) 2020 SiFive
+ * Author: Yash Shah <yash.shah@sifive.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <soc/sifive/sifive_beu.h>
+
+#define SIFIVE_BEU_CAUSE	0x00
+#define SIFIVE_BEU_VALUE	0x08
+#define SIFIVE_BEU_ENABLE	0x10
+#define SIFIVE_BEU_PLIC_INTR	0x18
+#define SIFIVE_BEU_ACCRUED	0x20
+#define SIFIVE_BEU_LOCAL_INTR	0x28
+
+#define LOCAL_INTERRUPT	0
+#define PLIC_INTERRUPT	1
+#define MAX_ERR_EVENTS	5
+
+enum beu_err_events {
+	RESERVED = -1,
+	NO_ERR,
+	ITIM_CORR_ECC = 2,
+	ITIM_UNCORR_ECC,
+	TILINKBUS_ERR = 5,
+	DCACHE_CORR_ECC,
+	DCACHE_UNCORR_ECC
+};
+
+static
+int err_events[MAX_ERR_EVENTS] = {ITIM_CORR_ECC, ITIM_UNCORR_ECC, TILINKBUS_ERR,
+				  DCACHE_CORR_ECC, DCACHE_UNCORR_ECC};
+
+struct beu_sifive_ddata {
+	void __iomem *regs;
+	int irq;
+};
+
+static int beu_enable_event(struct beu_sifive_ddata *ddata,
+			    int event, int intr_type)
+{
+	unsigned char event_mask = BIT(event), val;
+
+	val = readb(ddata->regs + SIFIVE_BEU_ENABLE);
+	val |= event_mask;
+	writeb(val, ddata->regs + SIFIVE_BEU_ENABLE);
+
+	if (intr_type == PLIC_INTERRUPT) {
+		val = readb(ddata->regs + SIFIVE_BEU_PLIC_INTR);
+		val |= event_mask;
+		writeb(val, ddata->regs + SIFIVE_BEU_PLIC_INTR);
+	} else if (intr_type == LOCAL_INTERRUPT) {
+		val = readb(ddata->regs + SIFIVE_BEU_LOCAL_INTR);
+		val |= event_mask;
+		writeb(event_mask, ddata->regs + SIFIVE_BEU_LOCAL_INTR);
+	}
+
+	return 0;
+}
+
+static ATOMIC_NOTIFIER_HEAD(beu_chain);
+
+int register_sifive_beu_error_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&beu_chain, nb);
+}
+
+int unregister_sifive_beu_error_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&beu_chain, nb);
+}
+
+static irqreturn_t beu_sifive_irq(int irq, void *data)
+{
+	struct beu_sifive_ddata *ddata = data;
+	unsigned char cause, addr;
+
+	addr = readb(ddata->regs + SIFIVE_BEU_VALUE);
+	cause = readb(ddata->regs + SIFIVE_BEU_CAUSE);
+	switch (cause) {
+	case NO_ERR:
+		break;
+	case ITIM_CORR_ECC:
+		pr_err("BEU: ITIM ECCFIX @ %d\n", addr);
+		atomic_notifier_call_chain(&beu_chain, SIFIVE_BEU_ERR_TYPE_CE,
+					   "ITIM ECCFIX");
+		break;
+	case ITIM_UNCORR_ECC:
+		pr_err("BEU: ITIM ECCFAIL @ %d\n", addr);
+		atomic_notifier_call_chain(&beu_chain, SIFIVE_BEU_ERR_TYPE_UE,
+					   "ITIM ECCFAIL");
+		break;
+	case TILINKBUS_ERR:
+		pr_err("BEU: Load or Store TILINK BUS ERR occurred\n");
+		break;
+	case DCACHE_CORR_ECC:
+		pr_err("BEU: DATACACHE ECCFIX @ %d\n", addr);
+		atomic_notifier_call_chain(&beu_chain, SIFIVE_BEU_ERR_TYPE_CE,
+					   "DCACHE ECCFIX");
+		break;
+	case DCACHE_UNCORR_ECC:
+		pr_err("BEU: DATACACHE ECCFAIL @ %d\n", addr);
+		atomic_notifier_call_chain(&beu_chain, SIFIVE_BEU_ERR_TYPE_UE,
+					   "DCACHE ECCFAIL");
+		break;
+	default:
+		pr_err("BEU: Unidentified cause\n");
+		break;
+	}
+	writeb(0, ddata->regs + SIFIVE_BEU_CAUSE);
+	writeb(0, ddata->regs + SIFIVE_BEU_ACCRUED);
+
+	return IRQ_HANDLED;
+}
+
+static int beu_sifive_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct beu_sifive_ddata *ddata;
+	struct resource *res;
+	int ret, i;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ddata->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ddata->regs)) {
+		dev_err(dev, "Unable to map IO resources\n");
+		return PTR_ERR(ddata->regs);
+	}
+
+	ddata->irq = platform_get_irq(pdev, 0);
+	if (ddata->irq < 0) {
+		dev_err(dev, "Unable to find interrupt\n");
+		ret = ddata->irq;
+		return ret;
+	}
+
+	ret = devm_request_irq(dev, ddata->irq, beu_sifive_irq, 0,
+			       dev_name(dev), ddata);
+	if (ret) {
+		dev_err(dev, "Unable to request IRQ\n");
+		return ret;
+	}
+
+	for (i = 0; i < MAX_ERR_EVENTS; i++) {
+		ret = beu_enable_event(ddata, err_events[i], PLIC_INTERRUPT);
+		if (ret) {
+			dev_err(dev, "Unable to register PLIC interrupt\n");
+			return ret;
+		}
+	}
+
+	platform_set_drvdata(pdev, ddata);
+
+	return 0;
+}
+
+static int beu_sifive_remove(struct platform_device *pdev)
+{
+	struct beu_sifive_ddata *ddata = platform_get_drvdata(pdev);
+
+	/* Mask all error events */
+	writeb(0, ddata->regs + SIFIVE_BEU_ENABLE);
+	writeb(0, ddata->regs + SIFIVE_BEU_PLIC_INTR);
+	writeb(0, ddata->regs + SIFIVE_BEU_LOCAL_INTR);
+
+	return 0;
+}
+
+static const struct of_device_id beu_sifive_of_match[] = {
+	{ .compatible = "sifive,beu0" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, beu_sifive_of_match);
+
+static struct platform_driver beu_sifive_driver = {
+	.probe = beu_sifive_probe,
+	.remove = beu_sifive_remove,
+	.driver = {
+		.name = "beu-sifive",
+		.of_match_table = beu_sifive_of_match,
+	},
+};
+module_platform_driver(beu_sifive_driver);
+
+MODULE_DESCRIPTION("SiFive BEU driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/soc/sifive/sifive_beu.h b/include/soc/sifive/sifive_beu.h
new file mode 100644
index 0000000..c2ab688
--- /dev/null
+++ b/include/soc/sifive/sifive_beu.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SiFive Bus Error unit header file
+ *
+ */
+
+#ifndef __SOC_SIFIVE_BEU_H
+#define __SOC_SIFIVE_BEU_H
+
+extern int register_sifive_beu_error_notifier(struct notifier_block *nb);
+extern int unregister_sifive_beu_error_notifier(struct notifier_block *nb);
+
+#define SIFIVE_BEU_ERR_TYPE_CE 0
+#define SIFIVE_BEU_ERR_TYPE_UE 1
+
+#endif /* __SOC_SIFIVE_BEU_H */
-- 
2.7.4

