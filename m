Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0F625F2CD
	for <lists+linux-edac@lfdr.de>; Mon,  7 Sep 2020 07:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgIGFsy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Sep 2020 01:48:54 -0400
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com ([40.107.236.63]:41069
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727066AbgIGFss (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 7 Sep 2020 01:48:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuZXndPndLRZ8D6mYn3HCBHhSWd5HcKTqGyHQVAEEXA+Bypo3WV9lrBvOTOk9ZxL/3xSDCE2Zmu/9spsICH+27XlwQlV7AxNSAQI9dCQYr1hsiy63Zdcm/Mq2Xv+szkTbAPvJWNBYKScGapkAYWUjHGVZjuBH0yVGaPWlAWkVx5Oul2LLCe3ie/fAMjf9/pFYsEZfRnQDN2fLm7yVHG2pmOH739nVhitx1V0uPirvkRBtgGThIjvaFaZ+W/7QvbgZcp9jSInNP0Xp2dkAKOw1vlnwVtb5lDEQ6Gwm1a74jKfFjj4DxNLcWZVaMbQG1Pik7yHepOFffra9vPa2+DQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpubuCbL4VQt18Oxxy6rwh4I3ZJds0rj0xSlxasm8YU=;
 b=HoFZ5RdqhaK6U3hmFXGxCmA2p7l7Ji+oUT77XJEBAWEdNZH/2Drou+Eccwysp+zmycJHbo8Sr4U97yUfynXoYkPOaFH/M4Y9YjvTXkSjcNzJVOME0h+m+IwKk0diMOBecUL9p//BllzUTzCF448dvVu1m52EukFNqNpUSuj0tC8G3vvCEeT8ICYOF9QDELTjjVeCSKgE5G/W6gmHJb9b/Gw6KXBcOYsZga2jfkg8C/eGkd8iAlyCf5W8QiunqAx5feMooVKcASpKZ3O4C1t/6FVEK5uhecyZZ00zu6Cle2jcOGk8fvfL2m3cdwdbMES3Lnc9k1dQ6m6Il2+tZbU6Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpubuCbL4VQt18Oxxy6rwh4I3ZJds0rj0xSlxasm8YU=;
 b=JKhaxh3fnjuKVT0RN37ra2qomsyjt4oLH+NskUCLF7S8pzVuWAHaVJ3t1p6RQY3lwLsTwwX8e4BirBP3BAv6ejRpQRjf7jY1mPd4HrzdZtlTv5avuteDajX6gjK6x3rNop0urGlaVxZkRwlJufSm1SO8GFhg2twnSzTgmABz2Fw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34) by BN6PR13MB1569.namprd13.prod.outlook.com
 (2603:10b6:404:119::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7; Mon, 7 Sep
 2020 05:48:40 +0000
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::4596:33b0:db2c:dea]) by BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::4596:33b0:db2c:dea%3]) with mapi id 15.20.3370.011; Mon, 7 Sep 2020
 05:48:40 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com
Cc:     aou@eecs.berkeley.edu, james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2 3/3] EDAC/sifive: Add EDAC support for Memory Controller in SiFive SoCs
Date:   Mon,  7 Sep 2020 11:17:59 +0530
Message-Id: <1599457679-8947-4-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599457679-8947-1-git-send-email-yash.shah@sifive.com>
References: <1599457679-8947-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::35) To BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by BM1PR01CA0141.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:40::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 05:48:36 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc91f0bb-0604-40ae-320e-08d852f1ac15
X-MS-TrafficTypeDiagnostic: BN6PR13MB1569:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR13MB1569743D1E2CCCF5676B7DB182280@BN6PR13MB1569.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RitRN3eVLW6s5Lwc68201e1OEzny2sh0VlS1M5XIb+AIRXNzbf85FW+ufdJXmA6muY4fOi1yy2d9csOy/4YvYuGV3DLcNci+ZmGk3iyWP1glMHKig+R7TLTNImfWJ6av1rFBBYrPjbgHxRJys8YskcVv7Dh232rGfv8ZGcYFatSWTe4aJtmu60zXcMblI2Sp1++Rdv+ERNQ8QLCyDREK/F3gYrb5zdESNhRmAWVq4RCRfYINGrBLIV2cq+wB1lg2SW0CVujQaLBgaLyTZBa/sOjb+pVU/tEBfwpdp8SLYnYKG1KaSuRHh25+gB3s0ebv2X1LLi0K8hUxAkwrHkLDMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1301MB2020.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(376002)(396003)(136003)(366004)(39840400004)(346002)(83380400001)(44832011)(5660300002)(6506007)(2906002)(36756003)(6512007)(4326008)(6666004)(16526019)(186003)(8676002)(316002)(2616005)(956004)(52116002)(8936002)(6486002)(26005)(66476007)(107886003)(66556008)(66946007)(83170400001)(7416002)(478600001)(42882007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BimS8HKQJF5eyyvaNNGwq1jT9ra3CgIMIxtWfLGLU/fgyIKaBj1Lqpik0c+/XgV6y0p3XtA7qqs0zW2hR5Ka0WTkXqzvuJCHsTEOo9QEPhZkMjoNDSXLpd77snIR04lJunpOqnJv6uXgJBicjkPZz1n2p7PITjJ4EgdMDNCI1SLTL8t6vMXGbbxTq2IMGYVWRBjfnmdzXCuT2nBLrH3WcYO61g0TaxKYA/lzhJndm7bJlk2PRnspp40rPvhoGHGOb51l2bCbxe2v2zw7UsZimJj3wnvIycEWL07PNiiR/BWpDnVGavz07/K9YBUCMhu56sXEkltMRkm5R1Tgzs43TFVZ9M0Bj3YthHuanA3SzA6HdPgO3uD7PUActoVtMVZCew8oqf8+UCZD/EwcJlBbSeTghfMic1Kig4VKpJumo9QvvfC2X2bi4XJ7IGrSTD9tX2+s/QFL/WM7xwcRO7YyuYssQsVdaDDjWCHbrKeVyLf4OjrP4z6E92E+rgDR8n1zAxzeDE98ipr/cRFkakwLp70aCC6cwJW4X92afqXfbjEoQjXaDEqn1wgzsJgWEPlR5iM/UElPrSEPndoKKcXSUeugPEVqXs9/DQOtmkaY6NiMbxPKG1bc3FOElQds5SM4gOOPDlK0t2hlgpzPrF/7pA==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc91f0bb-0604-40ae-320e-08d852f1ac15
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1301MB2020.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 05:48:40.2180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udXjNsrrW8zZNq8Zm89mh8JS4DSVLfoYbHmKTy5JrKEUK1VHynmzetoOHSS66G/ZPTv4uy7VhAPa6m5YPwXZ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1569
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add Memory controller EDAC support to the SiFive platform EDAC driver.
It registers for ECC notifier events from the memory controller.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 drivers/edac/Kconfig       |   2 +-
 drivers/edac/sifive_edac.c | 119 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 7b6ec30..f8b3b53 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -462,7 +462,7 @@ config EDAC_ALTERA_SDMMC
 
 config EDAC_SIFIVE
 	bool "Sifive platform EDAC driver"
-	depends on EDAC=y && SIFIVE_L2
+	depends on EDAC=y && (SIFIVE_L2 || SIFIVE_DDR)
 	help
 	  Support for error detection and correction on the SiFive SoCs.
 
diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
index 3a3dcb1..17dd556 100644
--- a/drivers/edac/sifive_edac.c
+++ b/drivers/edac/sifive_edac.c
@@ -11,14 +11,119 @@
 #include <linux/platform_device.h>
 #include "edac_module.h"
 #include <soc/sifive/sifive_l2_cache.h>
+#include <soc/sifive/sifive_ddr.h>
 
 #define DRVNAME "sifive_edac"
+#define EDAC_MOD_NAME "Sifive ECC Manager"
 
 struct sifive_edac_priv {
 	struct notifier_block notifier;
 	struct edac_device_ctl_info *dci;
 };
 
+struct sifive_edac_mc_priv {
+	struct notifier_block notifier;
+	struct mem_ctl_info *mci;
+};
+
+/**
+ * EDAC MC error callback
+ *
+ * @event: non-zero if unrecoverable.
+ */
+static
+int ecc_mc_err_event(struct notifier_block *this, unsigned long event, void *ptr)
+{
+	struct sifive_ddr_priv *priv = ptr;
+	struct sifive_edac_mc_priv *p;
+
+	p = container_of(this, struct sifive_edac_mc_priv, notifier);
+	if (event == SIFIVE_DDR_ERR_TYPE_UE) {
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, p->mci,
+				     priv->error_count, priv->page_frame_number,
+				     priv->offset_in_page, priv->syndrome,
+				     priv->top_layer, priv->mid_layer,
+				     priv->low_layer, p->mci->ctl_name, "");
+	} else if (event == SIFIVE_DDR_ERR_TYPE_CE) {
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, p->mci,
+				     priv->error_count, priv->page_frame_number,
+				     priv->offset_in_page, priv->syndrome,
+				     priv->top_layer, priv->mid_layer,
+				     priv->low_layer, p->mci->ctl_name, "");
+	}
+
+	return NOTIFY_OK;
+}
+
+static int ecc_mc_register(struct platform_device *pdev)
+{
+	struct sifive_edac_mc_priv *p;
+	struct edac_mc_layer layers[1];
+	int ret;
+
+	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	p->notifier.notifier_call = ecc_mc_err_event;
+	platform_set_drvdata(pdev, p);
+
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = 1;
+	layers[0].is_virt_csrow = true;
+
+	p->mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
+	if (!p->mci) {
+		dev_err(&pdev->dev, "Failed mem allocation for mc instance\n");
+		return -ENOMEM;
+	}
+
+	p->mci->pdev = &pdev->dev;
+	/* Initialize controller capabilities */
+	p->mci->mtype_cap = MEM_FLAG_DDR4;
+	p->mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
+	p->mci->edac_cap = EDAC_FLAG_SECDED;
+	p->mci->scrub_cap = SCRUB_UNKNOWN;
+	p->mci->scrub_mode = SCRUB_HW_PROG;
+	p->mci->ctl_name = dev_name(&pdev->dev);
+	p->mci->dev_name = dev_name(&pdev->dev);
+	p->mci->mod_name = EDAC_MOD_NAME;
+	p->mci->ctl_page_to_phys = NULL;
+
+	/* Interrupt feature is supported by cadence mc */
+	edac_op_state = EDAC_OPSTATE_INT;
+
+	ret = edac_mc_add_mc(p->mci);
+	if (ret) {
+		edac_printk(KERN_ERR, EDAC_MOD_NAME,
+			    "Failed to register with EDAC core\n");
+		goto err;
+	}
+
+	if (IS_ENABLED(CONFIG_SIFIVE_DDR))
+		register_sifive_ddr_error_notifier(&p->notifier);
+
+	return 0;
+
+err:
+	edac_mc_free(p->mci);
+
+	return -ENXIO;
+}
+
+static int ecc_mc_unregister(struct platform_device *pdev)
+{
+	struct sifive_edac_mc_priv *p = platform_get_drvdata(pdev);
+
+	if (IS_ENABLED(CONFIG_SIFIVE_DDR))
+		unregister_sifive_ddr_error_notifier(&p->notifier);
+
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(p->mci);
+
+	return 0;
+}
+
 /**
  * EDAC error callback
  *
@@ -67,7 +172,8 @@ static int ecc_register(struct platform_device *pdev)
 		goto err;
 	}
 
-	register_sifive_l2_error_notifier(&p->notifier);
+	if (IS_ENABLED(CONFIG_SIFIVE_L2))
+		register_sifive_l2_error_notifier(&p->notifier);
 
 	return 0;
 
@@ -81,7 +187,9 @@ static int ecc_unregister(struct platform_device *pdev)
 {
 	struct sifive_edac_priv *p = platform_get_drvdata(pdev);
 
-	unregister_sifive_l2_error_notifier(&p->notifier);
+	if (IS_ENABLED(CONFIG_SIFIVE_L2))
+		unregister_sifive_l2_error_notifier(&p->notifier);
+
 	edac_device_del_device(&pdev->dev);
 	edac_device_free_ctl_info(p->dci);
 
@@ -102,12 +210,19 @@ static int __init sifive_edac_init(void)
 	if (ret)
 		platform_device_unregister(sifive_pdev);
 
+	ret = ecc_mc_register(sifive_pdev);
+	if (ret) {
+		ecc_unregister(sifive_pdev);
+		platform_device_unregister(sifive_pdev);
+	}
+
 	return ret;
 }
 
 static void __exit sifive_edac_exit(void)
 {
 	ecc_unregister(sifive_pdev);
+	ecc_mc_unregister(sifive_pdev);
 	platform_device_unregister(sifive_pdev);
 }
 
-- 
2.7.4

