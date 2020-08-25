Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4FE25183F
	for <lists+linux-edac@lfdr.de>; Tue, 25 Aug 2020 14:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgHYMHN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Aug 2020 08:07:13 -0400
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:12232
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730139AbgHYMHD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 Aug 2020 08:07:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZZ/ojJqp6VWtBwgwXupfxeUXDgeGJ6BEy0wcYzr+AjxQYynr++wFMPYEfg++GpOZHnnyHUQLVVOuF/hlenAqb6DEe4xtRqUUGh4+eZuP/p/V5P1C6scO1gHseuPtr31sGAouVtNh9ZOoHufHmhyXnMvMHrnt//3Jw0q+f3tK/fAg/gIpJhpM10FBGI5497gupwN6ncNwdzEn/4BBBUU2LmjEf/3CvC948B35q/iIj4SE335szrKol0NMuIpzLZjSy4H2mGZESzA+UKWPb0WYrh/+OpE6noVwXwatiTa+dUsvmfRJryFG9Lkonj7Z2bleXa6Jg/WvIVO6gQgfXN3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S8xr4KU9pWaehG5jHIU10tawLW5v1xVOP0HDmjBVyw=;
 b=UPZOj4yYyGzqkcZHSiTZMSySSgbWUGVYiBOo0yFbeRG470up1ZF1pBQFuu511ZeEWF7Zb0yPzr2wiyTxbPkOZ9xQM4faqJdjMNgyVBMKdc/pvqBzxMrKhQcedl4QSpZzv9ZOqQFAVvssm3GXAbx8BOADmrmR8HbigI04kpdHtYyc/5dLPuDHHwfsEC2CM/yMTjblo0WbktjVyRW3KzqDRUblnh8qgT05285Ar0z738lvEuuT8qGPsXQv/Rgq+S4l/ypUHaMnvgi3av50LT8wMEmCV9WenYRoTElKyE9Rbs4wh61TIjOuz3ptETgTFTEBTYwkmthxYCsUf4NHeaWO/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S8xr4KU9pWaehG5jHIU10tawLW5v1xVOP0HDmjBVyw=;
 b=RQiMf8hhRKTZQZJ0UUZD1+yNdNGXLGYtveEHLUQTZWXvgfjjLg1yIGmHF7xOx/50uRFoODEBbuPwCK236xbwrYLTzArQ4WRjEhSI1ApSrwbxpP8HaxQhnCYe8EzdDJoNqnwhRJvk3tOFJMJ3hlLOOKv9RtsYWiBo/Z4qq1+oxpA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34) by BN6PR1301MB1873.namprd13.prod.outlook.com
 (2603:10b6:405:34::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.11; Tue, 25 Aug
 2020 12:07:01 +0000
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::a446:9877:b346:93ad]) by BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::a446:9877:b346:93ad%5]) with mapi id 15.20.3326.019; Tue, 25 Aug 2020
 12:07:01 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com
Cc:     aou@eecs.berkeley.edu, james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 3/3] edac: sifive: Add EDAC support for Memory Controller in SiFive SoCs
Date:   Tue, 25 Aug 2020 17:36:22 +0530
Message-Id: <1598357182-4226-4-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598357182-4226-1-git-send-email-yash.shah@sifive.com>
References: <1598357182-4226-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::33) To BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BMXPR01CA0023.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.24 via Frontend Transport; Tue, 25 Aug 2020 12:06:56 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9edb6c62-97f6-4719-b1a2-08d848ef5f70
X-MS-TrafficTypeDiagnostic: BN6PR1301MB1873:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1301MB18732CB33B90AFC1EC511BF682570@BN6PR1301MB1873.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: om6QpE3UacvxvZZMIi0v6Fj83fS2CeCR5RqhsXozTZm5r97RyWqrXkVuVdSRrnsvGtJNN1vKH52qIEYCMb68le/bVoqb+HSl4xEptr6GSB+zVMML2f1RDuJVuBor4cq2rw9U9g81oaVHcc6IXeO6JG1PDfPqejxGKSna1lu6ETejTk45Cd3PpO0ywDJ+frAFvSgftLBiYU44huwNRXKLxzHyaZxlm6wEiL3FEUycwq/TrlZ41ORedw99PNArIFtGBAZt9N0NTGowRNL7Il0Qkta3hVlsSg7vq+PoYeKnkL4cZLJdmVcQRcuC0lDrI0ChWyvCQW9765oWaW5w5Z8U8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1301MB2020.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(396003)(366004)(136003)(346002)(39850400004)(376002)(7416002)(4326008)(6486002)(66556008)(52116002)(26005)(66476007)(186003)(107886003)(8936002)(316002)(83170400001)(16576012)(42882007)(5660300002)(66946007)(6666004)(478600001)(36756003)(2616005)(83380400001)(956004)(2906002)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Z1XsR/JLNSkQT+XdSrC3781XIcdYm5QNYfSHapmuQuJD+FDNgSodcKpgJ1KBKnv3pSnIQn0D+7NUYU28O63wUyOBkw5G8CDJUWsX0lmkEXpCz381AfOiNOgLGXaDg4mGcnCy2LOe7dcorV6y9SL+ZEdSz/EMacbFb8L3Dsj2H6BfECVVCqbwlvyxiIYtX1BtBaV/79Zs51GVjIA75V1UuSuGq73413ddZ8xlcXsk1MFeAia0DQJoKXoyy1ZVfXQriok6GuQIKM9GY2arFsW38GhKq7UTEPBCQ8Tylh83LjfT4EYcB6Q/vCHkbWoC6vppPLeULCGakApv/VBSZP83O+LjL/GCoYk8HuqryFbRePT40SLej8wiZ8F6gVGNa9d7tSfFEC977C4j2tUP8RDB6ogavY0nXaHQ/ggQ+1tNtaNZOyUeYe7qqkmcNyruXds7ZK0ZyLUXXmAwgHap48EgRZMSPoa8MON2ydvjthc85bDuDhkSKgjPAVjDwg0R2WkQdVb5tS1roJ8a1JeBzd6Ho6G3rvcXFg68D0Rjt7XeWySchRKN17WgBSzDldvqMRTiXgF3osrQOeXTy2hhFTBnInI9s4vbzoDLaUwGHeHbdeSY78mTfIVigtljHBZYo4iI+Xs/+3S2JhV4qqzmZs1uyw==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edb6c62-97f6-4719-b1a2-08d848ef5f70
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1301MB2020.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 12:07:01.0468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raWz0BjIDeMQxoz/tEiFAXOrOOta7EMqqsYeLUTKe0yO1NQY93V7akx0Vz+IlE079A8vz38de7N8wVZmyowayA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1301MB1873
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add Memory controller EDAC support in exisiting SiFive platform EDAC
driver. It registers for notifier events from the SiFive DDR controller
driver for DDR ECC events.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 drivers/edac/Kconfig       |   2 +-
 drivers/edac/sifive_edac.c | 117 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+), 1 deletion(-)

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
index 3a3dcb1..cf032685 100644
--- a/drivers/edac/sifive_edac.c
+++ b/drivers/edac/sifive_edac.c
@@ -11,14 +11,120 @@
 #include <linux/platform_device.h>
 #include "edac_module.h"
 #include <soc/sifive/sifive_l2_cache.h>
+#include <soc/sifive/sifive_ddr.h>
 
 #define DRVNAME "sifive_edac"
+#define SIFIVE_EDAC_MOD_NAME "Sifive ECC Manager"
 
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
+	p->mci->mod_name = SIFIVE_EDAC_MOD_NAME;
+	p->mci->ctl_page_to_phys = NULL;
+
+	/* Interrupt feature is supported by cadence mc */
+	edac_op_state = EDAC_OPSTATE_INT;
+
+	ret = edac_mc_add_mc(p->mci);
+	if (ret) {
+		edac_printk(KERN_ERR, SIFIVE_EDAC_MOD_NAME,
+			    "Failed to register with EDAC core\n");
+		goto err;
+	}
+
+#ifdef CONFIG_SIFIVE_DDR
+	register_sifive_ddr_error_notifier(&p->notifier);
+#endif
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
+#ifdef CONFIG_SIFIVE_DDR
+	unregister_sifive_ddr_error_notifier(&p->notifier);
+#endif
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(p->mci);
+
+	return 0;
+}
+
 /**
  * EDAC error callback
  *
@@ -67,7 +173,9 @@ static int ecc_register(struct platform_device *pdev)
 		goto err;
 	}
 
+#ifdef CONFIG_SIFIVE_L2
 	register_sifive_l2_error_notifier(&p->notifier);
+#endif
 
 	return 0;
 
@@ -81,7 +189,9 @@ static int ecc_unregister(struct platform_device *pdev)
 {
 	struct sifive_edac_priv *p = platform_get_drvdata(pdev);
 
+#ifdef CONFIG_SIFIVE_L2
 	unregister_sifive_l2_error_notifier(&p->notifier);
+#endif
 	edac_device_del_device(&pdev->dev);
 	edac_device_free_ctl_info(p->dci);
 
@@ -102,12 +212,19 @@ static int __init sifive_edac_init(void)
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

