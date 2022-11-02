Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF0E615E30
	for <lists+linux-edac@lfdr.de>; Wed,  2 Nov 2022 09:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiKBIq3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Nov 2022 04:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiKBIq0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Nov 2022 04:46:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8A227CC1;
        Wed,  2 Nov 2022 01:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZCOo4Pcqdj8StsiMTM15rX9BI9OGkqzxtc6Vbe+eti57cHeac00iVfCOD31kXwGUeETUYqoWE7b0p3ZOtwVdY9ZvZjn0ZYmo5gzO6ifmBxwV0JAYuQrFZkkxMt2F39eDbj4wzRiF7HC/59A8ZLUAhsyCNh9x1LYHUE4njfNHd+b4C7m5Ygo5HlT9OMNa8Ch9CTEsCgwH5fc2OPsoLpXUX/lmVwlKxw4c4kSyrdb5zWBurdVPuqM9/1Om0SQHoPQfV5OV6qHBYTcozFHKMEDslhc61Xd+94ShCMh+nW9MeXMdSy6JASa13G2bn98W2hUhOp8OFYg0Knc/TPfYeii/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4E6EUIPtcsGKZyPjPceVajI5hemZzyfjkW9jZ//tgE=;
 b=fTjn13UOkmrkHt65Dz3mDwknUVFADiZn+5fclSVaVPLekHxGL3CI2r5w6Pwj6yOvSIGi7zGOhWdzkDVeHTYWihuqFKZfC+HtBktoDTbiyrQGkksC1YvrSwnqpHrkf0xAt6M6y4zWSoaJLLZV/oobJhnhW+MS5R2cnKjLwbbWQin2y8Tz7AeHppVZ6C+auFAZDihT/Lm+RFYcYfY9PDf3tzEh8Cbcqlv8uUopqbGNAWe9RuVo5iP+J2N0MYcxvTKXsM5XGgYXd2k/oV8TcFoakjsCZWLt5rRn481FeelVTiOCfB4fJQUCKeLzCCMg0eHxbWICgmRrvY+9YO5oQKjaEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4E6EUIPtcsGKZyPjPceVajI5hemZzyfjkW9jZ//tgE=;
 b=jsDAOg6PcpmeGTZ4rdg4gxIBpmUCDqNHPA8VnO/rS6YpKyPbipz9J0FaQUuOMHfUXiOQEUDUiopVwLDl6a+TdBRT+FhjXFuRDR7xzoZtQMAIEpWlefYbUCoc2DK3cOH9PaaIg79AosodIFCRmNqgLLpjR/hpgtxrr5Zs44lH1zI=
Received: from BL1P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::25)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Wed, 2 Nov
 2022 08:46:20 +0000
Received: from BL02EPF0000C404.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::55) by BL1P221CA0029.outlook.office365.com
 (2603:10b6:208:2c5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Wed, 2 Nov 2022 08:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000C404.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.17 via Frontend Transport; Wed, 2 Nov 2022 08:46:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 03:46:18 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 03:46:15 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>,
        <michal.simek@xilinx.com>, <rric@kernel.org>,
        <james.morse@arm.com>, <tony.luck@intel.com>, <mchehab@kernel.org>,
        <bp@alien8.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] edac: xilinx: Added EDAC support for Xilinx DDR controller
Date:   Wed, 2 Nov 2022 14:16:08 +0530
Message-ID: <20221102084608.28894-3-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221102084608.28894-1-shubhrajyoti.datta@amd.com>
References: <20221102084608.28894-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C404:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: 16afc157-cc6a-4256-76d2-08dabcaeb69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FiZJ3M6eI+UeQ5lyRceogKrmgJewnCyiE37isEOQIn82/Ru1i9psRiKEatGIveefVDlFCnQDyfhbDwUkxPla8UG27ZWCYLCfkRj4WoC93/gjdPDEgYQWsmr89sVuHxbLET3XbOCQP9MIbjRnUKU15je/q26JklNNedlaEdb4KJUhbXRK2VHAj51JvYl+7+OGzWkTeskZoIX8+9aI8Q1zbZPbDqq4cSAZP0aRnkhPWVNVojmsL3jRAykccf4h6CZo2vfmnlLiBGVx9ubJgQFB3LjKn+8zlskM1quD6iABDX7XhsGzO80Bg8wQADGHjTr7j96A4TFBumT9UOC/kksofjQ+ZO2qCTnJP/EHsPFsUA45Yts0Bgj3Okc9hkHV52gbmgEbCJyD9yNsv+GQagPH4Z+gPMONkLtUNSAZ8XGjNRGkWrH3Ymdi5f6kAVtGX2CRqi/jnWaVj5Z+KvAyCuO+yuQo8aXnDGpD0AEs8dlzgOz24LNKu+CYfEuMnAmZTlZgvDsm27oLn+Dn4S1VNlMDLYNDz/4sXRM0vN04LHp9BVknVsrCsHl8A2JqwxFCXFzKQ8xmh3lK6xsEF1/zAdS6GaV9PI86kVDoeI0u9uq5ougCNw4mD9Yx8U2DF1wS5xhIcyDblX2YyGNJPzfQSaC6XGGRsYXlWvrEG9yXaVwCJ75HJP3BvVhK9GWTy0iepFeChDgoVbs09IvKSYKoc6SRBwW9q99kMcHJ2Nq6nTLL08pcuKsNZotSyIE93uSzx4n5iZSjThEKUZDwQrjh60WB2W7zdW6UpzG91XA+DDkoui8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(26005)(6666004)(83380400001)(316002)(54906003)(6916009)(82310400005)(36860700001)(478600001)(336012)(356005)(40460700003)(40480700001)(2616005)(82740400003)(81166007)(36756003)(186003)(1076003)(426003)(47076005)(86362001)(2906002)(4326008)(70586007)(70206006)(8676002)(30864003)(41300700001)(8936002)(44832011)(5660300002)(36900700001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 08:46:19.9850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16afc157-cc6a-4256-76d2-08dabcaeb69b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C404.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch adds EDAC support for Xilinx DDR Controller, this driver
reports Correctable and Uncorrectable errors , and also creates
debugfs entries for error injection.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 MAINTAINERS                      |    7 +
 drivers/edac/Kconfig             |   11 +
 drivers/edac/Makefile            |    1 +
 drivers/edac/xilinx_ddrmc_edac.c | 1250 ++++++++++++++++++++++++++++++
 4 files changed, 1269 insertions(+)
 create mode 100644 drivers/edac/xilinx_ddrmc_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..cfeece1d75c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22631,6 +22631,13 @@ S:	Maintained
 F:	drivers/soc/xilinx/xlnx_event_manager.c
 F:	include/linux/firmware/xlnx-event-manager.h
 
+XILINX VERSAL DDRMC EDAC DRIVER
+M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
+F:	drivers/edac/xilinx_ddrmc_edac.c
+
 XILLYBUS DRIVER
 M:	Eli Billauer <eli.billauer@gmail.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 456602d373b7..6c32fa4b980d 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -541,4 +541,15 @@ config EDAC_DMC520
 	  Support for error detection and correction on the
 	  SoCs with ARM DMC-520 DRAM controller.
 
+config EDAC_XILINX_DDR
+	tristate "Xilinx Versal DDR Memory Controller"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	help
+	  Support for error detection and correction on the Xilinx Versal DDR
+	  memory controller.
+
+	  Report both Single Bit Errors (CE) and Double Bit Errors (UE).
+	  Support injecting both Correctable and UnCorrectable errors for debug
+	  purpose using sysfs entries.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 2d1641a27a28..2f20e0f53ca6 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -83,4 +83,5 @@ obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
 obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
+obj-$(CONFIG_EDAC_XILINX_DDR)		+= xilinx_ddrmc_edac.o
 obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
diff --git a/drivers/edac/xilinx_ddrmc_edac.c b/drivers/edac/xilinx_ddrmc_edac.c
new file mode 100644
index 000000000000..1e12c6ffacf7
--- /dev/null
+++ b/drivers/edac/xilinx_ddrmc_edac.c
@@ -0,0 +1,1250 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Versal DDRC ECC Driver
+ * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/edac.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/sizes.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/firmware/xlnx-error-events.h>
+#include <linux/firmware/xlnx-event-manager.h>
+#include <linux/debugfs.h>
+
+#include "edac_module.h"
+
+/* Granularity of reported error in bytes */
+#define XDDR_EDAC_ERR_GRAIN			1
+
+#define XDDR_EDAC_MSG_SIZE			256
+
+#define XDDR_PCSR_OFFSET			0xC
+#define XDDR_ISR_OFFSET				0x14
+#define XDDR_IRQ_EN_OFFSET			0x20
+#define XDDR_IRQ1_EN_OFFSET			0x2C
+#define XDDR_IRQ_DIS_OFFSET			0x24
+#define XDDR_IRQ_CE_MASK			GENMASK(18, 15)
+#define XDDR_IRQ_UE_MASK			GENMASK(14, 11)
+
+#define XDDR_REG_CONFIG0_OFFSET			0x258
+#define XDDR_REG_CONFIG0_BUS_WIDTH_MASK		GENMASK(19, 18)
+#define XDDR_REG_CONFIG0_BUS_WIDTH_SHIFT	18
+#define XDDR_REG_CONFIG0_NUM_CHANS_MASK		BIT(17)
+#define XDDR_REG_CONFIG0_NUM_CHANS_SHIFT	17
+#define XDDR_REG_CONFIG0_NUM_RANKS_MASK		GENMASK(15, 14)
+#define XDDR_REG_CONFIG0_NUM_RANKS_SHIFT	14
+#define XDDR_REG_CONFIG0_SIZE_MASK		GENMASK(10, 8)
+#define XDDR_REG_CONFIG0_SIZE_SHIFT		8
+
+#define XDDR_REG_PINOUT_OFFSET			0x25C
+#define XDDR_REG_PINOUT_ECC_EN_MASK		GENMASK(7, 5)
+
+#define ECCW0_FLIP_CTRL				0x109C
+#define ECCW0_FLIP0_OFFSET			0x10A0
+#define ECCW1_FLIP_CTRL				0x10AC
+#define ECCW1_FLIP0_OFFSET			0x10B0
+#define ECCR0_CERR_STAT_OFFSET			0x10BC
+#define ECCR0_CE_ADDR_LO_OFFSET			0x10C0
+#define ECCR0_CE_ADDR_LO_OFFSET			0x10C0
+#define ECCR0_CE_ADDR_HI_OFFSET			0x10C4
+#define ECCR0_CE_DATA_LO_OFFSET			0x10C8
+#define ECCR0_CE_DATA_HI_OFFSET			0x10CC
+#define ECCR0_CE_DATA_PAR_OFFSET		0x10D0
+
+#define ECCR0_UERR_STAT_OFFSET			0x10D4
+#define ECCR0_UE_ADDR_LO_OFFSET			0x10D8
+#define ECCR0_UE_ADDR_HI_OFFSET			0x10DC
+#define ECCR0_UE_DATA_LO_OFFSET			0x10E0
+#define ECCR0_UE_DATA_HI_OFFSET			0x10E4
+#define ECCR0_UE_DATA_PAR_OFFSET		0x10E8
+
+#define ECCR1_CERR_STAT_OFFSET			0x10F4
+#define ECCR1_CE_ADDR_LO_OFFSET			0x10F8
+#define ECCR1_CE_ADDR_HI_OFFSET			0x10FC
+#define ECCR1_CE_DATA_LO_OFFSET			0x1100
+#define ECCR1_CE_DATA_HI_OFFSET			0x110C
+#define ECCR1_CE_DATA_PAR_OFFSET		0x1108
+
+#define ECCR1_UERR_STAT_OFFSET			0x110C
+#define ECCR1_UE_ADDR_LO_OFFSET			0x1110
+#define ECCR1_UE_ADDR_HI_OFFSET			0x1114
+#define ECCR1_UE_DATA_LO_OFFSET			0x1118
+#define ECCR1_UE_DATA_HI_OFFSET			0x111C
+#define ECCR1_UE_DATA_PAR_OFFSET		0x1120
+
+#define XDDR_NOC_REG_ADEC4_OFFSET		0x44
+#define RANK_0_MASK				GENMASK(5, 0)
+#define RANK_1_MASK				GENMASK(11, 6)
+#define RANK_1_SHIFT				6
+#define LRANK_0_MASK				GENMASK(17, 12)
+#define LRANK_0_SHIFT				12
+#define LRANK_1_MASK				GENMASK(23, 18)
+#define LRANK_1_SHIFT				18
+#define LRANK_2_MASK				GENMASK(29, 24)
+#define LRANK_2_SHIFT				24
+
+#define XDDR_NOC_REG_ADEC5_OFFSET		0x48
+#define ROW_0_MASK				GENMASK(5, 0)
+#define ROW_1_MASK				GENMASK(11, 6)
+#define ROW_1_SHIFT				6
+#define ROW_2_MASK				GENMASK(17, 12)
+#define ROW_2_SHIFT				12
+#define ROW_3_MASK				GENMASK(23, 18)
+#define ROW_3_SHIFT				18
+#define ROW_4_MASK				GENMASK(29, 24)
+#define ROW_4_SHIFT				24
+
+#define XDDR_NOC_REG_ADEC6_OFFSET		0x4C
+#define ROW_5_MASK				GENMASK(5, 0)
+#define ROW_6_MASK				GENMASK(11, 6)
+#define ROW_6_SHIFT				6
+#define ROW_7_MASK				GENMASK(17, 12)
+#define ROW_7_SHIFT				12
+#define ROW_8_MASK				GENMASK(23, 18)
+#define ROW_8_SHIFT				18
+#define ROW_9_MASK				GENMASK(29, 24)
+#define ROW_9_SHIFT				24
+
+#define XDDR_NOC_REG_ADEC7_OFFSET		0x50
+#define ROW_10_MASK				GENMASK(5, 0)
+#define ROW_11_MASK				GENMASK(11, 6)
+#define ROW_11_SHIFT				6
+#define ROW_12_MASK				GENMASK(17, 12)
+#define ROW_12_SHIFT				12
+#define ROW_13_MASK				GENMASK(23, 18)
+#define ROW_13_SHIFT				18
+#define ROW_14_MASK				GENMASK(29, 24)
+#define ROW_14_SHIFT				24
+
+#define XDDR_NOC_REG_ADEC8_OFFSET		0x54
+#define ROW_15_MASK				GENMASK(5, 0)
+#define ROW_16_MASK				GENMASK(11, 6)
+#define ROW_16_SHIFT				6
+#define ROW_17_MASK				GENMASK(17, 12)
+#define ROW_17_SHIFT				12
+#define ROW_18_MASK				GENMASK(23, 18)
+#define ROW_18_SHIFT				18
+#define COL_0_MASK				GENMASK(29, 24)
+#define COL_0_SHIFT				24
+
+#define XDDR_NOC_REG_ADEC9_OFFSET		0x58
+#define COL_1_MASK				GENMASK(5, 0)
+#define COL_2_MASK				GENMASK(11, 6)
+#define COL_2_SHIFT				6
+#define COL_3_MASK				GENMASK(17, 12)
+#define COL_3_SHIFT				12
+#define COL_4_MASK				GENMASK(23, 18)
+#define COL_4_SHIFT				18
+#define COL_5_MASK				GENMASK(29, 24)
+#define COL_5_SHIFT				24
+
+#define XDDR_NOC_REG_ADEC10_OFFSET		0x5C
+#define COL_6_MASK				GENMASK(5, 0)
+#define COL_7_MASK				GENMASK(11, 6)
+#define COL_7_SHIFT				6
+#define COL_8_MASK				GENMASK(17, 12)
+#define COL_8_SHIFT				12
+#define COL_9_MASK				GENMASK(23, 18)
+#define COL_9_SHIFT				18
+#define BANK_0_MASK				GENMASK(29, 24)
+#define BANK_0_SHIFT				24
+
+#define XDDR_NOC_REG_ADEC11_OFFSET		0x60
+#define BANK_1_MASK				GENMASK(5, 0)
+#define GRP_0_MASK				GENMASK(11, 6)
+#define GRP_0_SHIFT				6
+#define GRP_1_MASK				GENMASK(17, 12)
+#define GRP_1_SHIFT				12
+#define CH_0_MASK				GENMASK(23, 18)
+#define CH_0_SHIFT				18
+
+#define XDDR_NOC_REG_ADEC12_OFFSET		0x71C
+#define XDDR_NOC_REG_ADEC13_OFFSET		0x720
+
+#define XDDR_NOC_REG_ADEC14_OFFSET		0x724
+#define XDDR_NOC_ROW_MATCH_MASK			GENMASK(17, 0)
+#define XDDR_NOC_COL_MATCH_MASK			GENMASK(27, 18)
+#define XDDR_NOC_COL_MATCH_SHIFT		18
+#define XDDR_NOC_BANK_MATCH_MASK		GENMASK(29, 28)
+#define XDDR_NOC_BANK_MATCH_SHIFT		28
+#define XDDR_NOC_GRP_MATCH_MASK			GENMASK(31, 30)
+#define XDDR_NOC_GRP_MATCH_SHIFT		30
+
+#define XDDR_NOC_REG_ADEC15_OFFSET		0x728
+#define XDDR_NOC_RANK_MATCH_MASK		GENMASK(1, 0)
+#define XDDR_NOC_LRANK_MATCH_MASK		GENMASK(4, 2)
+#define XDDR_NOC_LRANK_MATCH_SHIFT		2
+#define XDDR_NOC_CH_MATCH_MASK			BIT(5)
+#define XDDR_NOC_CH_MATCH_SHIFT			5
+#define XDDR_NOC_MOD_SEL_MASK			BIT(6)
+#define XDDR_NOC_MATCH_EN_MASK			BIT(8)
+
+#define ECCR_UE_CE_ADDR_LO_BP_MASK		GENMASK(2, 0)
+#define ECCR_UE_CE_ADDR_LO_LRANK_MASK		GENMASK(5, 3)
+#define ECCR_UE_CE_ADDR_LO_LRANK_SHIFT		3
+#define ECCR_UE_CE_ADDR_LO_RANK_MASK		GENMASK(7, 6)
+#define ECCR_UE_CE_ADDR_LO_RANK_SHIFT		6
+#define ECCR_UE_CE_ADDR_LO_GRP_MASK		GENMASK(9, 8)
+#define ECCR_UE_CE_ADDR_LO_GRP_SHIFT		8
+#define ECCR_UE_CE_ADDR_LO_BANK_MASK		GENMASK(11, 10)
+#define ECCR_UE_CE_ADDR_LO_BANK_SHIFT		10
+#define ECCR_UE_CE_ADDR_LO_COL_MASK		GENMASK(21, 12)
+#define ECCR_UE_CE_ADDR_LO_COL_SHIFT		12
+#define ECCR_UE_CE_ADDR_LO_ROW_MASK		GENMASK(31, 22)
+#define ECCR_UE_CE_ADDR_LO_ROW_SHIFT		22
+#define ECCR_UE_CE_ADDR_HI_ROW_MASK		GENMASK(7, 0)
+#define ECCR_UE_CE_ADDR_HI_ROW_SHIFT		10
+
+#define XDDR_EDAC_NR_CSROWS			1
+#define XDDR_EDAC_NR_CHANS			1
+
+#define XDDR_BUS_WIDTH_64			0
+#define XDDR_BUS_WIDTH_32			1
+#define XDDR_BUS_WIDTH_16			2
+
+#define ECC_CEPOISON_MASK			0x1
+#define ECC_UEPOISON_MASK			0x3
+
+#define XDDR_MAX_ROW_CNT			18
+#define XDDR_MAX_COL_CNT			10
+#define XDDR_MAX_RANK_CNT			2
+#define XDDR_MAX_LRANK_CNT			3
+#define XDDR_MAX_BANK_CNT			2
+#define XDDR_MAX_GRP_CNT			2
+
+#define PCSR_UNLOCK_VAL				0xF9E8D7C6
+#define XDDR_ERR_TYPE_CE			0
+#define XDDR_ERR_TYPE_UE			1
+
+#define XILINX_DRAM_SIZE_4G			0
+#define XILINX_DRAM_SIZE_6G			1
+#define XILINX_DRAM_SIZE_8G			2
+#define XILINX_DRAM_SIZE_12G			3
+#define XILINX_DRAM_SIZE_16G			4
+#define XILINX_DRAM_SIZE_32G			5
+
+#define XDDR_CE_TRIGGER_CHAR            'C'
+/**
+ * struct ecc_error_info - ECC error log information.
+ * @rank:		Rank number.
+ * @lrank:		Logical Rank number.
+ * @row:		Row number.
+ * @col:		Column number.
+ * @bank:		Bank number.
+ * @group:		Group number.
+ * @burstpos:		Burst position.
+ */
+struct ecc_error_info {
+	u32 rank;
+	u32 lrank;
+	u32 row;
+	u32 col;
+	u32 bank;
+	u32 group;
+	u32 burstpos;
+};
+
+/**
+ * struct ecc_status - ECC status information to report.
+ * @ceinfo:	Correctable error log information.
+ * @ueinfo:	Uncorrectable error log information.
+ * @channel:	Channel number.
+ * @error_type:	Error type information.
+ */
+struct ecc_status {
+	struct ecc_error_info ceinfo[2];
+	struct ecc_error_info ueinfo[2];
+	u32 channel;
+	u8 error_type;
+};
+
+/**
+ * struct edac_priv - DDR memory controller private instance data.
+ * @ddrmc_baseaddr:	Base address of the DDR controller.
+ * @ddrmc_noc_baseaddr:	Base address of the DDRMC NOC.
+ * @message:		Buffer for framing the event specific info.
+ * @mc_id:		Memory controller ID.
+ * @ce_cnt:		Correctable error count.
+ * @ue_cnt:		UnCorrectable error count.
+ * @stat:		ECC status information.
+ * @lrank_bit:		Bit shifts for lrank bit.
+ * @rank_bit:		Bit shifts for rank bit.
+ * @row_bit:		Bit shifts for row bit.
+ * @col_bit:		Bit shifts for column bit.
+ * @bank_bit:		Bit shifts for bank bit.
+ * @grp_bit:		Bit shifts for group bit.
+ * @ch_bit:		Bit shifts for channel bit.
+ * @err_inject_addr:	Data poison address.
+ * @debugfs:		Debugfs handle.
+ */
+struct edac_priv {
+	void __iomem *ddrmc_baseaddr;
+	void __iomem *ddrmc_noc_baseaddr;
+	char message[XDDR_EDAC_MSG_SIZE];
+	u32 mc_id;
+	u32 ce_cnt;
+	u32 ue_cnt;
+	struct ecc_status stat;
+	u32 lrank_bit[3];
+	u32 rank_bit[2];
+	u32 row_bit[18];
+	u32 col_bit[10];
+	u32 bank_bit[2];
+	u32 grp_bit[2];
+	u32 ch_bit;
+#ifdef CONFIG_EDAC_DEBUG
+	u32 err_inject_addr;
+#endif
+	struct dentry *debugfs;
+};
+
+static struct dentry *xddr_debugfs;
+
+/**
+ * get_error_info - Get the current ECC error info.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Return: one if there is no error otherwise returns zero.
+ */
+static int get_error_info(struct edac_priv *priv)
+{
+	u32 eccr0_ceval, eccr1_ceval, eccr0_ueval, eccr1_ueval, regval;
+	void __iomem *ddrmc_base;
+	struct ecc_status *p;
+
+	ddrmc_base = priv->ddrmc_baseaddr;
+	p = &priv->stat;
+
+	eccr0_ceval = readl(ddrmc_base + ECCR0_CERR_STAT_OFFSET);
+	eccr1_ceval = readl(ddrmc_base + ECCR1_CERR_STAT_OFFSET);
+	eccr0_ueval = readl(ddrmc_base + ECCR0_UERR_STAT_OFFSET);
+	eccr1_ueval = readl(ddrmc_base + ECCR1_UERR_STAT_OFFSET);
+
+	if (!eccr0_ceval && !eccr1_ceval && !eccr0_ueval && !eccr1_ueval)
+		return 1;
+	else if (!eccr0_ceval && !eccr1_ceval)
+		goto ue_err;
+	else if (!eccr0_ceval)
+		p->channel = 1;
+	else
+		p->channel = 0;
+
+	p->error_type = XDDR_ERR_TYPE_CE;
+	regval = readl(ddrmc_base + ECCR0_CE_ADDR_LO_OFFSET);
+	p->ceinfo[0].burstpos = (regval & ECCR_UE_CE_ADDR_LO_BP_MASK);
+	p->ceinfo[0].lrank = (regval & ECCR_UE_CE_ADDR_LO_LRANK_MASK) >>
+					ECCR_UE_CE_ADDR_LO_LRANK_SHIFT;
+	p->ceinfo[0].rank = (regval & ECCR_UE_CE_ADDR_LO_RANK_MASK) >>
+					ECCR_UE_CE_ADDR_LO_RANK_SHIFT;
+	p->ceinfo[0].group = (regval & ECCR_UE_CE_ADDR_LO_GRP_MASK) >>
+					ECCR_UE_CE_ADDR_LO_GRP_SHIFT;
+	p->ceinfo[0].bank = (regval & ECCR_UE_CE_ADDR_LO_BANK_MASK) >>
+					ECCR_UE_CE_ADDR_LO_BANK_SHIFT;
+	p->ceinfo[0].col = (regval & ECCR_UE_CE_ADDR_LO_COL_MASK) >>
+					ECCR_UE_CE_ADDR_LO_COL_SHIFT;
+	p->ceinfo[0].row = (regval & ECCR_UE_CE_ADDR_LO_ROW_MASK) >>
+					ECCR_UE_CE_ADDR_LO_ROW_SHIFT;
+	regval = readl(ddrmc_base + ECCR0_CE_ADDR_HI_OFFSET);
+	p->ceinfo[0].row |= ((regval & ECCR_UE_CE_ADDR_HI_ROW_MASK) <<
+					ECCR_UE_CE_ADDR_HI_ROW_SHIFT);
+
+	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",
+		 readl(ddrmc_base + ECCR0_CE_DATA_LO_OFFSET),
+		 readl(ddrmc_base + ECCR0_CE_DATA_HI_OFFSET),
+		 readl(ddrmc_base + ECCR0_CE_DATA_PAR_OFFSET));
+
+	regval = readl(ddrmc_base + ECCR1_CE_ADDR_LO_OFFSET);
+	p->ceinfo[1].burstpos = (regval & ECCR_UE_CE_ADDR_LO_BP_MASK);
+	p->ceinfo[1].lrank = (regval & ECCR_UE_CE_ADDR_LO_LRANK_MASK) >>
+					ECCR_UE_CE_ADDR_LO_LRANK_SHIFT;
+	p->ceinfo[1].rank = (regval & ECCR_UE_CE_ADDR_LO_RANK_MASK) >>
+					ECCR_UE_CE_ADDR_LO_RANK_SHIFT;
+	p->ceinfo[1].group = (regval & ECCR_UE_CE_ADDR_LO_GRP_MASK) >>
+					ECCR_UE_CE_ADDR_LO_GRP_SHIFT;
+	p->ceinfo[1].bank = (regval & ECCR_UE_CE_ADDR_LO_BANK_MASK) >>
+					ECCR_UE_CE_ADDR_LO_BANK_SHIFT;
+	p->ceinfo[1].col = (regval & ECCR_UE_CE_ADDR_LO_COL_MASK) >>
+					ECCR_UE_CE_ADDR_LO_COL_SHIFT;
+	p->ceinfo[1].row = (regval & ECCR_UE_CE_ADDR_LO_ROW_MASK) >>
+					ECCR_UE_CE_ADDR_LO_ROW_SHIFT;
+	regval = readl(ddrmc_base + ECCR1_CE_ADDR_HI_OFFSET);
+	p->ceinfo[1].row |= ((regval & ECCR_UE_CE_ADDR_HI_ROW_MASK) <<
+					ECCR_UE_CE_ADDR_HI_ROW_SHIFT);
+
+	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",
+		 readl(ddrmc_base + ECCR1_CE_DATA_LO_OFFSET),
+		 readl(ddrmc_base + ECCR1_CE_DATA_HI_OFFSET),
+		 readl(ddrmc_base + ECCR1_CE_DATA_PAR_OFFSET));
+ue_err:
+	if (!eccr0_ueval && !eccr1_ueval)
+		goto out;
+	else if (!eccr0_ueval)
+		p->channel = 1;
+	else
+		p->channel = 0;
+
+	p->error_type = XDDR_ERR_TYPE_UE;
+	regval = readl(ddrmc_base + ECCR0_UE_ADDR_LO_OFFSET);
+	p->ueinfo[0].burstpos = (regval & ECCR_UE_CE_ADDR_LO_BP_MASK);
+	p->ueinfo[0].lrank = (regval & ECCR_UE_CE_ADDR_LO_LRANK_MASK) >>
+					ECCR_UE_CE_ADDR_LO_LRANK_SHIFT;
+	p->ueinfo[0].rank = (regval & ECCR_UE_CE_ADDR_LO_RANK_MASK) >>
+					ECCR_UE_CE_ADDR_LO_RANK_SHIFT;
+	p->ueinfo[0].group = (regval & ECCR_UE_CE_ADDR_LO_GRP_MASK) >>
+					ECCR_UE_CE_ADDR_LO_GRP_SHIFT;
+	p->ueinfo[0].bank = (regval & ECCR_UE_CE_ADDR_LO_BANK_MASK) >>
+					ECCR_UE_CE_ADDR_LO_BANK_SHIFT;
+	p->ueinfo[0].col = (regval & ECCR_UE_CE_ADDR_LO_COL_MASK) >>
+					ECCR_UE_CE_ADDR_LO_COL_SHIFT;
+	p->ueinfo[0].row = (regval & ECCR_UE_CE_ADDR_LO_ROW_MASK) >>
+					ECCR_UE_CE_ADDR_LO_ROW_SHIFT;
+	regval = readl(ddrmc_base + ECCR0_UE_ADDR_HI_OFFSET);
+	p->ueinfo[0].row |= ((regval & ECCR_UE_CE_ADDR_HI_ROW_MASK) <<
+					ECCR_UE_CE_ADDR_HI_ROW_SHIFT);
+
+	edac_dbg(2, "ERR DATA LOW: 0x%08X ERR DATA HIGH: 0x%08X ERR DATA PARITY: 0x%08X\n",
+		 readl(ddrmc_base + ECCR0_UE_DATA_LO_OFFSET),
+		 readl(ddrmc_base + ECCR0_UE_DATA_HI_OFFSET),
+		 readl(ddrmc_base + ECCR0_UE_DATA_PAR_OFFSET));
+
+	regval = readl(ddrmc_base + ECCR1_UE_ADDR_LO_OFFSET);
+	p->ueinfo[1].burstpos = (regval & ECCR_UE_CE_ADDR_LO_BP_MASK);
+	p->ueinfo[1].lrank = (regval & ECCR_UE_CE_ADDR_LO_LRANK_MASK) >>
+					ECCR_UE_CE_ADDR_LO_LRANK_SHIFT;
+	p->ueinfo[1].rank = (regval & ECCR_UE_CE_ADDR_LO_RANK_MASK) >>
+					ECCR_UE_CE_ADDR_LO_RANK_SHIFT;
+	p->ueinfo[1].group = (regval & ECCR_UE_CE_ADDR_LO_GRP_MASK) >>
+					ECCR_UE_CE_ADDR_LO_GRP_SHIFT;
+	p->ueinfo[1].bank = (regval & ECCR_UE_CE_ADDR_LO_BANK_MASK) >>
+					ECCR_UE_CE_ADDR_LO_BANK_SHIFT;
+	p->ueinfo[1].col = (regval & ECCR_UE_CE_ADDR_LO_COL_MASK) >>
+					ECCR_UE_CE_ADDR_LO_COL_SHIFT;
+	p->ueinfo[1].row = (regval & ECCR_UE_CE_ADDR_LO_ROW_MASK) >>
+					ECCR_UE_CE_ADDR_LO_ROW_SHIFT;
+	regval = readl(ddrmc_base + ECCR1_UE_ADDR_HI_OFFSET);
+	p->ueinfo[1].row |= ((regval & ECCR_UE_CE_ADDR_HI_ROW_MASK) <<
+					ECCR_UE_CE_ADDR_HI_ROW_SHIFT);
+
+	edac_dbg(2, "ERR DATA LOW: 0x%08X ERR DATA HIGH: 0x%08X ERR DATA PARITY: 0x%08X\n",
+		 readl(ddrmc_base + ECCR1_UE_DATA_LO_OFFSET),
+		 readl(ddrmc_base + ECCR1_UE_DATA_HI_OFFSET),
+		 readl(ddrmc_base + ECCR1_UE_DATA_PAR_OFFSET));
+
+out:
+	/* Unlock the PCSR registers */
+	writel(PCSR_UNLOCK_VAL, ddrmc_base + XDDR_PCSR_OFFSET);
+
+	writel(0, ddrmc_base + ECCR0_CERR_STAT_OFFSET);
+	writel(0, ddrmc_base + ECCR1_CERR_STAT_OFFSET);
+	writel(0, ddrmc_base + ECCR0_UERR_STAT_OFFSET);
+	writel(0, ddrmc_base + ECCR1_UERR_STAT_OFFSET);
+
+	/* Lock the PCSR registers */
+	writel(1, ddrmc_base + XDDR_PCSR_OFFSET);
+
+	return 0;
+}
+
+/**
+ * convert_to_physical - Convert to physical address.
+ * @priv:	DDR memory controller private instance data.
+ * @pinf:	ECC error info structure.
+ *
+ * Return: Physical address of the DDR memory.
+ */
+static ulong convert_to_physical(struct edac_priv *priv,
+				 struct ecc_error_info pinf)
+{
+	ulong err_addr = 0;
+	u32 index;
+
+	for (index = 0; index < XDDR_MAX_ROW_CNT; index++) {
+		err_addr |= (pinf.row & BIT(0)) << priv->row_bit[index];
+		pinf.row >>= 1;
+	}
+
+	for (index = 0; index < XDDR_MAX_COL_CNT; index++) {
+		err_addr |= (pinf.col & BIT(0)) << priv->col_bit[index];
+		pinf.col >>= 1;
+	}
+
+	for (index = 0; index < XDDR_MAX_BANK_CNT; index++) {
+		err_addr |= (pinf.bank & BIT(0)) << priv->bank_bit[index];
+		pinf.bank >>= 1;
+	}
+
+	for (index = 0; index < XDDR_MAX_GRP_CNT; index++) {
+		err_addr |= (pinf.group & BIT(0)) << priv->grp_bit[index];
+		pinf.group >>= 1;
+	}
+
+	for (index = 0; index < XDDR_MAX_RANK_CNT; index++) {
+		err_addr |= (pinf.rank & BIT(0)) << priv->rank_bit[index];
+		pinf.rank >>= 1;
+	}
+
+	for (index = 0; index < XDDR_MAX_LRANK_CNT; index++) {
+		err_addr |= (pinf.lrank & BIT(0)) << priv->lrank_bit[index];
+		pinf.lrank >>= 1;
+	}
+
+	err_addr |= (priv->stat.channel & BIT(0)) << priv->ch_bit;
+
+	return err_addr;
+}
+
+/**
+ * handle_error - Handle Correctable and Uncorrectable errors.
+ * @mci:	EDAC memory controller instance.
+ * @stat:	ECC status structure.
+ *
+ * Handles ECC correctable and uncorrectable errors.
+ */
+static void handle_error(struct mem_ctl_info *mci, struct ecc_status *stat)
+{
+	struct edac_priv *priv = mci->pvt_info;
+	struct ecc_error_info pinf;
+
+	if (stat->error_type == XDDR_ERR_TYPE_CE) {
+		priv->ce_cnt++;
+		pinf = stat->ceinfo[stat->channel];
+		snprintf(priv->message, XDDR_EDAC_MSG_SIZE,
+			 "Error type:%s MC ID: %d Addr at %lx Burst Pos: %d\n",
+			 "CE", priv->mc_id,
+			 convert_to_physical(priv, pinf), pinf.burstpos);
+
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+				     priv->ce_cnt, 0, 0, 0, 0, 0, -1,
+				     priv->message, "");
+	}
+
+	if (stat->error_type == XDDR_ERR_TYPE_UE) {
+		priv->ue_cnt++;
+		pinf = stat->ueinfo[stat->channel];
+		snprintf(priv->message, XDDR_EDAC_MSG_SIZE,
+			 "Error type:%s MC ID: %d Addr at %lx Burst Pos: %d\n",
+			 "UE", priv->mc_id,
+			 convert_to_physical(priv, pinf), pinf.burstpos);
+
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+				     priv->ue_cnt, 0, 0, 0, 0, 0, -1,
+				     priv->message, "");
+	}
+
+	memset(stat, 0, sizeof(*stat));
+}
+
+/**
+ * intr_handler - Interrupt Handler for ECC interrupts.
+ * @irq:	IRQ number
+ * @dev_id:	Device ID
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
+ */
+static irqreturn_t intr_handler(int irq, void *dev_id)
+{
+	struct mem_ctl_info *mci = dev_id;
+	struct edac_priv *priv;
+	int status, regval;
+
+	priv = mci->pvt_info;
+	regval = readl(priv->ddrmc_baseaddr + XDDR_ISR_OFFSET);
+	regval &= (XDDR_IRQ_CE_MASK | XDDR_IRQ_UE_MASK);
+	if (!regval)
+		return IRQ_NONE;
+
+	/* Unlock the PCSR registers */
+	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+
+	/* Clear the ISR */
+	writel(regval, priv->ddrmc_baseaddr + XDDR_ISR_OFFSET);
+
+	/* Lock the PCSR registers */
+	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+
+	status = get_error_info(priv);
+	if (status)
+		return IRQ_NONE;
+
+	handle_error(mci, &priv->stat);
+
+	edac_dbg(3, "Total error count CE %d UE %d\n",
+		 priv->ce_cnt, priv->ue_cnt);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * err_callback - Handle Correctable and Uncorrectable errors.
+ * @payload:	payload data.
+ * @data:	mci controller data.
+ *
+ * Handles ECC correctable and uncorrectable errors.
+ */
+static void err_callback(const u32 *payload, void *data)
+{
+	struct mem_ctl_info *mci = (struct mem_ctl_info *)data;
+	struct edac_priv *priv;
+	struct ecc_status *p;
+	int status, regval;
+
+	priv = mci->pvt_info;
+	p = &priv->stat;
+
+	regval = readl(priv->ddrmc_baseaddr + XDDR_ISR_OFFSET);
+	regval &= (XDDR_IRQ_CE_MASK | XDDR_IRQ_UE_MASK);
+	if (!regval)
+		return;
+
+	/* Unlock the PCSR registers */
+	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+
+	/* Clear the ISR */
+	writel(regval, priv->ddrmc_baseaddr + XDDR_ISR_OFFSET);
+	/* Lock the PCSR registers */
+
+	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	if (payload[2] == XPM_EVENT_ERROR_MASK_DDRMC_CR)
+		p->error_type = XDDR_ERR_TYPE_CE;
+	if (payload[2] == XPM_EVENT_ERROR_MASK_DDRMC_NCR)
+		p->error_type = XDDR_ERR_TYPE_UE;
+
+	status = get_error_info(priv);
+	if (status)
+		return;
+
+	handle_error(mci, &priv->stat);
+
+	edac_dbg(3, "Total error count CE %d UE %d\n",
+		 priv->ce_cnt, priv->ue_cnt);
+}
+
+/**
+ * get_dwidth - Return the controller memory width.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the EDAC device type width appropriate for the controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type get_dwidth(const void __iomem *base)
+{
+	enum dev_type dt;
+	u32 regval;
+
+	regval = readl(base + XDDR_REG_CONFIG0_OFFSET);
+	regval = (regval & XDDR_REG_CONFIG0_BUS_WIDTH_MASK) >>
+				XDDR_REG_CONFIG0_BUS_WIDTH_SHIFT;
+	switch (regval) {
+	case XDDR_BUS_WIDTH_16:
+		dt = DEV_X2;
+		break;
+	case XDDR_BUS_WIDTH_32:
+		dt = DEV_X4;
+		break;
+	case XDDR_BUS_WIDTH_64:
+		dt = DEV_X8;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
+
+	return dt;
+}
+
+/**
+ * get_ecc_state - Return the controller ECC enable/disable status.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the ECC enable/disable status for the controller.
+ *
+ * Return: a ECC status boolean i.e true/false - enabled/disabled.
+ */
+static bool get_ecc_state(void __iomem *base)
+{
+	enum dev_type dt;
+	u32 ecctype;
+
+	dt = get_dwidth(base);
+	if (dt == DEV_UNKNOWN)
+		return false;
+
+	ecctype = readl(base + XDDR_REG_PINOUT_OFFSET);
+	ecctype &= XDDR_REG_PINOUT_ECC_EN_MASK;
+	if (ecctype)
+		return true;
+
+	return false;
+}
+
+/**
+ * get_memsize - Get the size of the attached memory device.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Return: the memory size in bytes.
+ */
+static u64 get_memsize(struct edac_priv *priv)
+{
+	u32 regval;
+	u64 size;
+
+	regval = readl(priv->ddrmc_baseaddr + XDDR_REG_CONFIG0_OFFSET) &
+				XDDR_REG_CONFIG0_SIZE_MASK;
+	regval >>= XDDR_REG_CONFIG0_SIZE_SHIFT;
+	switch (regval) {
+	case XILINX_DRAM_SIZE_4G:
+		size = (4U * SZ_1G);
+		break;
+	case XILINX_DRAM_SIZE_6G:
+		size = (6U * SZ_1G);
+		break;
+	case XILINX_DRAM_SIZE_8G:
+		size = (8U * SZ_1G);
+		break;
+	case XILINX_DRAM_SIZE_12G:
+		size = (12U * SZ_1G);
+		break;
+	case XILINX_DRAM_SIZE_16G:
+		size = (16U * SZ_1G);
+		break;
+	case XILINX_DRAM_SIZE_32G:
+		size = (32U * SZ_1G);
+		break;
+	default:
+		/* Invalid configuration */
+		size = 0;
+		break;
+	}
+
+	return size;
+}
+
+/**
+ * init_csrows - Initialize the csrow data.
+ * @mci:	EDAC memory controller instance.
+ *
+ * Initialize the chip select rows associated with the EDAC memory
+ * controller instance.
+ */
+static void init_csrows(struct mem_ctl_info *mci)
+{
+	struct edac_priv *priv = mci->pvt_info;
+	struct csrow_info *csi;
+	struct dimm_info *dimm;
+	unsigned long size;
+	u32 row;
+	int ch;
+
+	size = get_memsize(priv);
+	for (row = 0; row < mci->nr_csrows; row++) {
+		csi = mci->csrows[row];
+		for (ch = 0; ch < csi->nr_channels; ch++) {
+			dimm = csi->channels[ch]->dimm;
+			dimm->edac_mode	= EDAC_SECDED;
+			dimm->mtype = MEM_DDR4;
+			dimm->nr_pages = (size >> PAGE_SHIFT) /
+						csi->nr_channels;
+			dimm->grain = XDDR_EDAC_ERR_GRAIN;
+			dimm->dtype = get_dwidth(priv->ddrmc_baseaddr);
+		}
+	}
+}
+
+/**
+ * mc_init - Initialize one driver instance.
+ * @mci:	EDAC memory controller instance.
+ * @pdev:	platform device.
+ *
+ * Perform initialization of the EDAC memory controller instance and
+ * related driver-private data associated with the memory controller the
+ * instance is bound to.
+ */
+static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
+{
+	mci->pdev = &pdev->dev;
+	platform_set_drvdata(pdev, mci);
+
+	/* Initialize controller capabilities and configuration */
+	mci->mtype_cap = MEM_FLAG_DDR4;
+	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
+	mci->scrub_cap = SCRUB_HW_SRC;
+	mci->scrub_mode = SCRUB_NONE;
+
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->ctl_name = "xlnx_ddr_controller";
+	mci->dev_name = dev_name(&pdev->dev);
+	mci->mod_name = "xlnx_edac";
+
+	edac_op_state = EDAC_OPSTATE_INT;
+
+	init_csrows(mci);
+}
+
+static void enable_intr(struct edac_priv *priv)
+{
+	/* Unlock the PCSR registers */
+	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+
+	/* Enable UE and CE Interrupts to support the interrupt case */
+	writel(XDDR_IRQ_CE_MASK | XDDR_IRQ_UE_MASK,
+	       priv->ddrmc_baseaddr + XDDR_IRQ_EN_OFFSET);
+
+	writel(XDDR_IRQ_UE_MASK,
+	       priv->ddrmc_baseaddr + XDDR_IRQ1_EN_OFFSET);
+	/* Lock the PCSR registers */
+	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+}
+
+static void disable_intr(struct edac_priv *priv)
+{
+	/* Unlock the PCSR registers */
+	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+
+	/* Disable UE/CE Interrupts */
+	writel(XDDR_IRQ_CE_MASK | XDDR_IRQ_UE_MASK,
+	       priv->ddrmc_baseaddr + XDDR_IRQ_DIS_OFFSET);
+
+	/* Lock the PCSR registers */
+	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+}
+
+static int setup_irq(struct mem_ctl_info *mci, struct platform_device *pdev)
+{
+	int ret, irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "No IRQ %d in DT\n", irq);
+		return irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, intr_handler,
+			       IRQF_SHARED, dev_name(&pdev->dev), mci);
+	if (ret < 0) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_EDAC_DEBUG
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+/**
+ * poison_setup - Update poison registers.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Update poison registers as per DDR mapping.
+ * Return: none.
+ */
+static void poison_setup(struct edac_priv *priv)
+{
+	u32 col = 0, row = 0, bank = 0, grp = 0, rank = 0, lrank = 0, ch = 0;
+	u32 index, regval;
+
+	for (index = 0; index < XDDR_MAX_ROW_CNT; index++) {
+		row |= (((priv->err_inject_addr >> priv->row_bit[index]) &
+						BIT(0)) << index);
+	}
+
+	for (index = 0; index < XDDR_MAX_COL_CNT; index++) {
+		col |= (((priv->err_inject_addr >> priv->col_bit[index]) &
+						BIT(0)) << index);
+	}
+
+	for (index = 0; index < XDDR_MAX_BANK_CNT; index++) {
+		bank |= (((priv->err_inject_addr >> priv->bank_bit[index]) &
+						BIT(0)) << index);
+	}
+
+	for (index = 0; index < XDDR_MAX_GRP_CNT; index++) {
+		grp |= (((priv->err_inject_addr >> priv->grp_bit[index]) &
+						BIT(0)) << index);
+	}
+
+	for (index = 0; index < XDDR_MAX_RANK_CNT; index++) {
+		rank |= (((priv->err_inject_addr >> priv->rank_bit[index]) &
+						BIT(0)) << index);
+	}
+
+	for (index = 0; index < XDDR_MAX_LRANK_CNT; index++) {
+		lrank |= (((priv->err_inject_addr >> priv->lrank_bit[index]) &
+						BIT(0)) << index);
+	}
+
+	ch = (priv->err_inject_addr >> priv->ch_bit) & BIT(0);
+	if (ch)
+		writel(0xFF, priv->ddrmc_baseaddr + ECCW1_FLIP_CTRL);
+	else
+		writel(0xFF, priv->ddrmc_baseaddr + ECCW0_FLIP_CTRL);
+
+	writel(0, priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC12_OFFSET);
+	writel(0, priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC13_OFFSET);
+
+	regval = (row & XDDR_NOC_ROW_MATCH_MASK);
+	regval |= (col << XDDR_NOC_COL_MATCH_SHIFT) & XDDR_NOC_COL_MATCH_MASK;
+	regval |= (bank << XDDR_NOC_BANK_MATCH_SHIFT) &
+			XDDR_NOC_BANK_MATCH_MASK;
+	regval |= (grp << XDDR_NOC_GRP_MATCH_SHIFT) & XDDR_NOC_GRP_MATCH_MASK;
+	writel(regval, priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC14_OFFSET);
+
+	regval = (rank & XDDR_NOC_RANK_MATCH_MASK);
+	regval |= (lrank << XDDR_NOC_LRANK_MATCH_SHIFT) &
+			XDDR_NOC_LRANK_MATCH_MASK;
+	regval |= (ch << XDDR_NOC_CH_MATCH_SHIFT) & XDDR_NOC_CH_MATCH_MASK;
+	regval |= (XDDR_NOC_MOD_SEL_MASK | XDDR_NOC_MATCH_EN_MASK);
+	writel(regval, priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC15_OFFSET);
+}
+
+static ssize_t xddr_inject_data_poison_store(struct mem_ctl_info *mci,
+					     const char __user *data)
+{
+	struct edac_priv *priv = mci->pvt_info;
+	u8 trig_type;
+
+	writel(0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
+	writel(0, priv->ddrmc_baseaddr + ECCW1_FLIP0_OFFSET);
+
+	if (!data || get_user(trig_type, data))
+		return -EFAULT;
+
+	if (trig_type == XDDR_CE_TRIGGER_CHAR) {
+		writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
+		       ECCW0_FLIP0_OFFSET);
+		writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
+		       ECCW1_FLIP0_OFFSET);
+	} else {
+		writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
+		       ECCW0_FLIP0_OFFSET);
+		writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
+		       ECCW1_FLIP0_OFFSET);
+	}
+
+	/* Lock the PCSR registers */
+	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	return 0;
+}
+
+static ssize_t inject_data_poison_store(struct file *file, const char __user *data,
+					size_t count, loff_t *ppos)
+{
+	struct device *dev = file->private_data;
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct edac_priv *priv = mci->pvt_info;
+
+	/* Unlock the PCSR registers */
+	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_UNLOCK_VAL, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+
+	poison_setup(priv);
+
+	/* Lock the PCSR registers */
+	writel(1, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+
+	xddr_inject_data_poison_store(mci, data);
+
+	return count;
+}
+
+static const struct file_operations xddr_inject_enable_fops = {
+	.open = simple_open,
+	.write = inject_data_poison_store,
+	.llseek = generic_file_llseek,
+};
+
+static int edac_create_debugfs_attributes(struct mem_ctl_info *mci)
+{
+	struct edac_priv *priv = mci->pvt_info;
+
+	priv->debugfs = debugfs_create_dir(mci->dev.kobj.name, xddr_debugfs);
+	edac_debugfs_create_file("inject_error", 200, priv->debugfs,
+				 &mci->dev, &xddr_inject_enable_fops);
+	edac_debugfs_create_x32("address", 644, priv->debugfs,
+				&priv->err_inject_addr);
+	mci->debugfs = priv->debugfs;
+	return 0;
+}
+
+static void setup_row_address_map(struct edac_priv *priv)
+{
+	u32 regval;
+
+	regval = readl(priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC5_OFFSET);
+	priv->row_bit[0] = regval & ROW_0_MASK;
+	priv->row_bit[1] = (regval & ROW_1_MASK) >> ROW_1_SHIFT;
+	priv->row_bit[2] = (regval & ROW_2_MASK) >> ROW_2_SHIFT;
+	priv->row_bit[3] = (regval & ROW_3_MASK) >> ROW_3_SHIFT;
+	priv->row_bit[4] = (regval & ROW_4_MASK) >> ROW_4_SHIFT;
+
+	regval = readl(priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC6_OFFSET);
+	priv->row_bit[5] = regval & ROW_5_MASK;
+	priv->row_bit[6] = (regval & ROW_6_MASK) >> ROW_6_SHIFT;
+	priv->row_bit[7] = (regval & ROW_7_MASK) >> ROW_7_SHIFT;
+	priv->row_bit[8] = (regval & ROW_8_MASK) >> ROW_8_SHIFT;
+	priv->row_bit[9] = (regval & ROW_9_MASK) >> ROW_9_SHIFT;
+
+	regval = readl(priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC7_OFFSET);
+	priv->row_bit[10] = regval & ROW_10_MASK;
+	priv->row_bit[11] = (regval & ROW_11_MASK) >> ROW_11_SHIFT;
+	priv->row_bit[12] = (regval & ROW_12_MASK) >> ROW_12_SHIFT;
+	priv->row_bit[13] = (regval & ROW_13_MASK) >> ROW_13_SHIFT;
+	priv->row_bit[14] = (regval & ROW_14_MASK) >> ROW_14_SHIFT;
+
+	regval = readl(priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC8_OFFSET);
+
+	priv->row_bit[15] = regval & ROW_15_MASK;
+	priv->row_bit[16] = (regval & ROW_16_MASK) >> ROW_16_SHIFT;
+	priv->row_bit[17] = (regval & ROW_17_MASK) >> ROW_17_SHIFT;
+}
+
+static void setup_column_address_map(struct edac_priv *priv)
+{
+	u32 regval;
+
+	regval = readl(priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC8_OFFSET);
+	priv->col_bit[0] = (regval & COL_0_MASK) >> COL_0_SHIFT;
+
+	regval = readl(priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC9_OFFSET);
+	priv->col_bit[1] = (regval & COL_1_MASK);
+	priv->col_bit[2] = (regval & COL_2_MASK) >> COL_2_SHIFT;
+	priv->col_bit[3] = (regval & COL_3_MASK) >> COL_3_SHIFT;
+	priv->col_bit[4] = (regval & COL_4_MASK) >> COL_4_SHIFT;
+	priv->col_bit[5] = (regval & COL_5_MASK) >> COL_5_SHIFT;
+
+	regval = readl(priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC10_OFFSET);
+	priv->col_bit[6] = (regval & COL_6_MASK);
+	priv->col_bit[7] = (regval & COL_7_MASK) >> COL_7_SHIFT;
+	priv->col_bit[8] = (regval & COL_8_MASK) >> COL_8_SHIFT;
+	priv->col_bit[9] = (regval & COL_9_MASK) >> COL_9_SHIFT;
+}
+
+static void setup_bank_grp_ch_address_map(struct edac_priv *priv)
+{
+	u32 regval;
+
+	regval = readl(priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC10_OFFSET);
+	priv->bank_bit[0] = (regval & BANK_0_MASK) >> BANK_0_SHIFT;
+
+	regval = readl(priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC11_OFFSET);
+	priv->bank_bit[1] = (regval & BANK_1_MASK);
+	priv->grp_bit[0] = (regval & GRP_0_MASK) >> GRP_0_SHIFT;
+	priv->grp_bit[1] = (regval & GRP_1_MASK) >> GRP_1_SHIFT;
+	priv->ch_bit = (regval & CH_0_MASK) >> CH_0_SHIFT;
+}
+
+static void setup_rank_lrank_address_map(struct edac_priv *priv)
+{
+	u32 regval;
+
+	regval = readl(priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC4_OFFSET);
+	priv->rank_bit[0] = (regval & RANK_0_MASK);
+	priv->rank_bit[1] = (regval & RANK_1_MASK) >> RANK_1_SHIFT;
+	priv->lrank_bit[0] = (regval & LRANK_0_MASK) >> LRANK_0_SHIFT;
+	priv->lrank_bit[1] = (regval & LRANK_1_MASK) >> LRANK_1_SHIFT;
+	priv->lrank_bit[2] = (regval & LRANK_2_MASK) >> LRANK_2_SHIFT;
+}
+
+/**
+ * setup_address_map - Set Address Map by querying ADDRMAP registers.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Set Address Map by querying ADDRMAP registers.
+ *
+ * Return: none.
+ */
+static void setup_address_map(struct edac_priv *priv)
+{
+	setup_row_address_map(priv);
+
+	setup_column_address_map(priv);
+
+	setup_bank_grp_ch_address_map(priv);
+
+	setup_rank_lrank_address_map(priv);
+}
+#endif /* CONFIG_EDAC_DEBUG */
+
+static const struct of_device_id xlnx_edac_match[] = {
+	{ .compatible = "xlnx,versal-ddrmc-edac", },
+	{
+		/* end of table */
+	}
+};
+
+MODULE_DEVICE_TABLE(of, xlnx_edac_match);
+static u32 emif_get_id(struct device_node *node)
+{
+	u32 addr, my_addr, my_id = 0;
+	struct device_node *np;
+	const __be32 *addrp;
+
+	addrp = of_get_address(node, 0, NULL, NULL);
+	my_addr = (u32)of_translate_address(node, addrp);
+
+	for_each_matching_node(np, xlnx_edac_match) {
+		if (np == node)
+			continue;
+
+		addrp = of_get_address(np, 0, NULL, NULL);
+		addr = (u32)of_translate_address(np, addrp);
+
+		edac_printk(KERN_INFO, EDAC_MC,
+			    "addr=%x, my_addr=%x\n",
+			    addr, my_addr);
+
+		if (addr < my_addr)
+			my_id++;
+	}
+
+	return my_id;
+}
+
+static int mc_probe(struct platform_device *pdev)
+{
+	void __iomem *ddrmc_baseaddr, *ddrmc_noc_baseaddr;
+	struct edac_mc_layer layers[2];
+	struct mem_ctl_info *mci;
+	u8 num_chans, num_csrows;
+	struct edac_priv *priv;
+	u32 edac_mc_id, regval;
+	int rc;
+
+	ddrmc_baseaddr = devm_platform_ioremap_resource_byname(pdev, "ddrmc_base");
+	if (IS_ERR(ddrmc_baseaddr))
+		return PTR_ERR(ddrmc_baseaddr);
+
+	ddrmc_noc_baseaddr = devm_platform_ioremap_resource_byname(pdev, "ddrmc_noc_base");
+	if (IS_ERR(ddrmc_noc_baseaddr))
+		return PTR_ERR(ddrmc_noc_baseaddr);
+
+	if (!get_ecc_state(ddrmc_baseaddr))
+		return -ENXIO;
+
+	/* Allocate ID number for our EMIF controller */
+	edac_mc_id = emif_get_id(pdev->dev.of_node);
+	if (edac_mc_id < 0)
+		return -EINVAL;
+
+	regval = readl(ddrmc_baseaddr + XDDR_REG_CONFIG0_OFFSET);
+	num_chans = (regval & XDDR_REG_CONFIG0_NUM_CHANS_MASK) >>
+			XDDR_REG_CONFIG0_NUM_CHANS_SHIFT;
+	num_chans++;
+
+	num_csrows = (regval & XDDR_REG_CONFIG0_NUM_RANKS_MASK) >>
+			XDDR_REG_CONFIG0_NUM_RANKS_SHIFT;
+	num_csrows *= 2;
+	if (!num_csrows)
+		num_csrows = 1;
+
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = num_csrows;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = num_chans;
+	layers[1].is_virt_csrow = false;
+
+	mci = edac_mc_alloc(edac_mc_id, ARRAY_SIZE(layers), layers,
+			    sizeof(struct edac_priv));
+	if (!mci) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Failed memory allocation for mc instance\n");
+		return -ENOMEM;
+	}
+
+	priv = mci->pvt_info;
+	priv->ddrmc_baseaddr = ddrmc_baseaddr;
+	priv->ddrmc_noc_baseaddr = ddrmc_noc_baseaddr;
+	priv->ce_cnt = 0;
+	priv->ue_cnt = 0;
+	priv->mc_id = edac_mc_id;
+
+	mc_init(mci, pdev);
+
+	rc = edac_mc_add_mc(mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Failed to register with EDAC core\n");
+		goto free_edac_mc;
+	}
+
+#ifdef CONFIG_EDAC_DEBUG
+	if (edac_create_debugfs_attributes(mci)) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Failed to create debugfs entries\n");
+		goto del_edac_mc;
+	}
+
+	setup_address_map(priv);
+#endif
+
+	rc = xlnx_register_event(PM_NOTIFY_CB, XPM_NODETYPE_EVENT_ERROR_PMC_ERR1,
+				 XPM_EVENT_ERROR_MASK_DDRMC_CR | XPM_EVENT_ERROR_MASK_DDRMC_NCR,
+				 false, err_callback, mci);
+	if (rc == -ENODEV) {
+		rc = setup_irq(mci, pdev);
+		if (rc)
+			goto del_edac_debugfs;
+	}
+	if (rc) {
+		if (rc == -EACCES)
+			rc = -EPROBE_DEFER;
+
+		goto del_edac_debugfs;
+	}
+
+	enable_intr(priv);
+	return rc;
+
+del_edac_debugfs:
+	edac_debugfs_remove_recursive(xddr_debugfs);
+del_edac_mc:
+	edac_mc_del_mc(&pdev->dev);
+free_edac_mc:
+	edac_mc_free(mci);
+
+	return rc;
+}
+
+static int mc_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct edac_priv *priv = mci->pvt_info;
+
+	disable_intr(priv);
+
+#ifdef CONFIG_EDAC_DEBUG
+	edac_debugfs_remove_recursive(xddr_debugfs);
+#endif
+
+	xlnx_unregister_event(PM_NOTIFY_CB, XPM_NODETYPE_EVENT_ERROR_PMC_ERR1,
+			      XPM_EVENT_ERROR_MASK_DDRMC_CR |
+			      XPM_EVENT_ERROR_MASK_DDRMC_NCR, err_callback, mci);
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+
+	return 0;
+}
+
+static struct platform_driver xilinx_ddr_edac_mc_driver = {
+	.driver = {
+		.name = "xilinx-ddrmc-edac",
+		.of_match_table = xlnx_edac_match,
+	},
+	.probe = mc_probe,
+	.remove = mc_remove,
+};
+
+module_platform_driver(xilinx_ddr_edac_mc_driver);
+
+MODULE_AUTHOR("AMD Inc");
+MODULE_DESCRIPTION("Xilinx DDRMC ECC driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

