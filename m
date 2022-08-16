Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A22595613
	for <lists+linux-edac@lfdr.de>; Tue, 16 Aug 2022 11:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiHPJVE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Aug 2022 05:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiHPJU3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Aug 2022 05:20:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD4810C828;
        Tue, 16 Aug 2022 00:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSM3pbPVbY09vaAtL0Ug+cyxEmJmZvJ5sQwjhvXdD9B4kcHcTDVEq5mQYA+rVQSbxdHPTQVY1z3zEL2FtSORKGyhdC1Wkni27fUM11LbzocFLNzSosGsHnDqIQkrXvOA2WeCu7d9YQSC7OfO+67ICh18bEJBRLk3v5bZRXCzotJdzUYILgSjou1qf+2ihb5j4v78q54FuYXq54LA66yyhN5DCgEZhO/ScmgbN3QEygmGBmxYV2HR0iWTfXs7fXT+YxpBGsZi/EKScB2MsD8DXg62XmnOAhjqyFn8/PVTSK4d8BKJxLZeItWKsN7xU2EMDDu+takiTGSxPGjqWwJVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y09d8Jt+oJwYM//gJV1lvETrQaBjU3igy6jLAMLN+cA=;
 b=UwhTSSlm9Ku6YUkT3T6rtxfVbF7vxEFBv0+YfPNbii4CU34Y5OefQ7epDe+Shux2p32nxwtff5PwCnDybpMcqKyCsmOrCuMSXyinv03coQ01ZG6Iz9AP6NcgwuddrmbfP3QUvmvBWnfp1aDF0+phyOnxs8heAlp/uCRUqodWKTYn/7SoJ2lst8SGoxOp5r149SRlpEgB35y0hX7gC2KQvdhfCl+t3TzSiblZ9V2rOJZPnhXceZDx4vAEAgbsU1t3jLsgWXnDGAuWkpdHsjVk5RKKrBPkj1UMVsoH9vrMO4NdMGGMz9FGN/5EgAh2aKfbw9NMB9glO7O49GeKK/c4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y09d8Jt+oJwYM//gJV1lvETrQaBjU3igy6jLAMLN+cA=;
 b=FkpEyEt4aI0PAqvV1mt8NFPYn7rvDW2WKYYmYIb+YbLFbYVzLdfDJ4u/BVpG0TC3ZlVhSV0pSgfGrG1PkBVb5J/rSWxnpWXhlFjWOpQDLunmr94++K63osH6l0npAcfKldbBTn1sJjdKJiH4PhAKqiY2Cl55njmqTCCoO0jl09s=
Received: from DS7PR03CA0217.namprd03.prod.outlook.com (2603:10b6:5:3ba::12)
 by DM6PR12MB2793.namprd12.prod.outlook.com (2603:10b6:5:4f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 07:35:53 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::c6) by DS7PR03CA0217.outlook.office365.com
 (2603:10b6:5:3ba::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Tue, 16 Aug 2022 07:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Tue, 16 Aug 2022 07:35:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 16 Aug
 2022 02:33:53 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 16 Aug 2022 02:33:24 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "Robert Richter" <rric@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <saikrishna12468@gmail.com>, <git@amd.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM
Date:   Tue, 16 Aug 2022 13:02:03 +0530
Message-ID: <20220816073203.27314-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816073203.27314-1-sai.krishna.potthuri@amd.com>
References: <20220816073203.27314-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59c9c060-e0ba-404f-9661-08da7f59f317
X-MS-TrafficTypeDiagnostic: DM6PR12MB2793:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tVN4N/xlGLqcpyYaZtrOXgTzvhDmwdeJ/ns7GoHLJCXQOwXoXOykb11KdPM7adJch8x4dGmcQIF5jQffz03R3fIK8FpN5u736QXZRe5zR91FPnmPaXMQV/960+InwferSlas3X/vVaKTKpSvrqDbuSQNFNDYoxAu3MnWkai8iKzxUxRBhnX0MQNK6ZheDygV05UfNy81arKwTNbQdlVRKRvkbfuGJPTQWGSPpCKDjh9ZwfXLmPmT/TOjSMyGhZWEBqaLa0/rkfNfcB8M1PFHhfgbKlc3RUK7VaLO5hXl9t19aADPtf/Byy5Omc5aESor8yJizZ95DjzskNKluGRVNUefQyNJiBSDWkG+5dqF4IoLQu4tIO31W7wj48rvyLUfDT2FkITrr+ib940dmndIblkdYotob2+sCUQIADy591dfJByAgSGKJ6MUG2DY3gcqn9dJauakCduGzjzAhSXhY7agyvqIyycZ+n18UNOopS6hptEj4qQdJmq/JyeY4CyPfabBeG9ddv2rWHj452J+UZxITVhNr1BF92HU19DWVu4wi/pagePM8jQnmCHdEvN6hXFXkzpC61zkxle6slvpLOD0Hozj5M7NVNqeBNOKgDhFl5mWPLM2BP+ZqY7mxsHqPrteEUIGu6RGbjg/znNu1ZKNuNouBTfCl+LzE6omEeJGnC+bwkOUzZ25xF3uId9TjCCZTDGFruB4GOPXPTLjfDxMnS1dxzmGzK871UPWGnJrocYUfsUchlzGzJXh504EkP97Kcwg8tZzdqz4vL/uannoZLjPEwOnYrwuIBEZCWXHurwEPBL1AJHmCTMNIMjSM1MISjhatdNzMGFC0hjqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(40470700004)(82310400005)(54906003)(356005)(40460700003)(40480700001)(83380400001)(316002)(36756003)(1076003)(41300700001)(47076005)(82740400003)(7416002)(478600001)(2616005)(186003)(6666004)(103116003)(5660300002)(26005)(336012)(426003)(110136005)(8676002)(70206006)(70586007)(2906002)(30864003)(86362001)(36860700001)(81166007)(8936002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 07:35:53.2166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c9c060-e0ba-404f-9661-08da7f59f317
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add EDAC support for Xilinx ZynqMP OCM Controller, this driver
reports CE and UE errors based on the interrupts, and also creates ue/ce
sysfs entries for error injection.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
 MAINTAINERS                    |   7 +
 drivers/edac/Kconfig           |   9 +
 drivers/edac/Makefile          |   1 +
 drivers/edac/zynqmp_ocm_edac.c | 643 +++++++++++++++++++++++++++++++++
 4 files changed, 660 insertions(+)
 create mode 100644 drivers/edac/zynqmp_ocm_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index edc96cdb85e8..cd4c6c90bca3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21692,6 +21692,13 @@ F:	Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
 F:	drivers/dma/xilinx/xilinx_dpdma.c
 F:	include/dt-bindings/dma/xlnx-zynqmp-dpdma.h
 
+XILINX ZYNQMP OCM EDAC DRIVER
+M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
+F:	drivers/edac/zynqmp_ocm_edac.c
+
 XILINX ZYNQMP PSGTR PHY DRIVER
 M:	Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 58ab63642e72..fece60f586af 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -539,4 +539,13 @@ config EDAC_DMC520
 	  Support for error detection and correction on the
 	  SoCs with ARM DMC-520 DRAM controller.
 
+config EDAC_ZYNQMP_OCM
+	tristate "Xilinx ZynqMP OCM Controller"
+	depends on ARCH_ZYNQMP
+	help
+	  Support for error detection and correction on the xilinx ZynqMP OCM
+	  controller.
+	  This driver can also be built as a module. If so, the module
+	  will be called zynqmp_ocm_edac.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 2d1641a27a28..634c1cec1588 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -84,3 +84,4 @@ obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
 obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
+obj-$(CONFIG_EDAC_ZYNQMP_OCM)		+= zynqmp_ocm_edac.o
diff --git a/drivers/edac/zynqmp_ocm_edac.c b/drivers/edac/zynqmp_ocm_edac.c
new file mode 100644
index 000000000000..ee094e983d9b
--- /dev/null
+++ b/drivers/edac/zynqmp_ocm_edac.c
@@ -0,0 +1,643 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx ZynqMP OCM ECC Driver
+ *
+ * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/edac.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include "edac_module.h"
+
+#define ZYNQMP_OCM_EDAC_MSG_SIZE	256
+
+#define ZYNQMP_OCM_EDAC_STRING	"zynqmp_ocm"
+
+/* Controller registers */
+#define CTRL_OFST			0x0
+#define OCM_ISR_OFST		0x04
+#define OCM_IMR_OFST		0x08
+#define OCM_IEN_OFST		0x0C
+#define OCM_IDS_OFST		0x10
+
+/* ECC control register */
+#define ECC_CTRL_OFST		0x14
+
+/* Correctable error info registers */
+#define CE_FFA_OFST			0x1C
+#define CE_FFD0_OFST		0x20
+#define CE_FFD1_OFST		0x24
+#define CE_FFD2_OFST		0x28
+#define CE_FFD3_OFST		0x2C
+#define CE_FFE_OFST			0x30
+
+/* Uncorrectable error info registers */
+#define UE_FFA_OFST			0x34
+#define UE_FFD0_OFST		0x38
+#define UE_FFD1_OFST		0x3C
+#define UE_FFD2_OFST		0x40
+#define UE_FFD3_OFST		0x44
+#define UE_FFE_OFST			0x48
+
+/* ECC control register bit field definitions */
+#define ECC_CTRL_CLR_CE_ERR	0x40
+#define ECC_CTRL_CLR_UE_ERR	0x80
+
+/* Fault injection data and count registers */
+#define OCM_FID0_OFST		0x4C
+#define OCM_FID1_OFST		0x50
+#define OCM_FID2_OFST		0x54
+#define OCM_FID3_OFST		0x58
+#define OCM_FIC_OFST		0x74
+
+#define UE_MAX_BITPOS_LOWER	31
+#define UE_MIN_BITPOS_UPPER	32
+#define UE_MAX_BITPOS_UPPER	63
+
+/* Interrupt masks */
+#define OCM_CEINTR_MASK		BIT(6)
+#define OCM_UEINTR_MASK		BIT(7)
+#define OCM_ECC_ENABLE_MASK	BIT(0)
+#define OCM_CEUE_MASK		GENMASK(7, 6)
+
+#define OCM_FICOUNT_MASK	GENMASK(23, 0)
+#define OCM_BASEVAL			0xFFFC0000
+#define EDAC_DEVICE			"ZynqMP-OCM"
+
+/**
+ * struct ecc_error_info - ECC error log information
+ * @addr:	Fault generated at this address
+ * @data0:	Generated fault data
+ * @data1:	Generated fault data
+ */
+struct ecc_error_info {
+	u32 addr;
+	u32 data0;
+	u32 data1;
+};
+
+/**
+ * struct zynqmp_ocm_ecc_status - ECC status information to report
+ * @ce_cnt:	Correctable error count
+ * @ue_cnt:	Uncorrectable error count
+ * @ceinfo:	Correctable error log information
+ * @ueinfo:	Uncorrectable error log information
+ */
+struct zynqmp_ocm_ecc_status {
+	u32 ce_cnt;
+	u32 ue_cnt;
+	struct ecc_error_info ceinfo;
+	struct ecc_error_info ueinfo;
+};
+
+/**
+ * struct zynqmp_ocm_edac_priv - DDR memory controller private instance data
+ * @baseaddr:	Base address of the DDR controller
+ * @message:	Buffer for framing the event specific info
+ * @stat:	ECC status information
+ * @p_data:	Pointer to platform data
+ * @ce_cnt:	Correctable Error count
+ * @ue_cnt:	Uncorrectable Error count
+ * @ce_bitpos:	Bit position for Correctable Error
+ * @ue_bitpos0:	First bit position for Uncorrectable Error
+ * @ue_bitpos1:	Second bit position for Uncorrectable Error
+ */
+struct zynqmp_ocm_edac_priv {
+	void __iomem *baseaddr;
+	char message[ZYNQMP_OCM_EDAC_MSG_SIZE];
+	struct zynqmp_ocm_ecc_status stat;
+	const struct zynqmp_ocm_platform_data *p_data;
+	u32 ce_cnt;
+	u32 ue_cnt;
+	u8 ce_bitpos;
+	u8 ue_bitpos0;
+	u8 ue_bitpos1;
+};
+
+/**
+ * zynqmp_ocm_edac_geterror_info - Get the current ecc error info
+ * @base:	Pointer to the base address of the ddr memory controller
+ * @p:		Pointer to the ocm ecc status structure
+ * @mask:	Status register mask value
+ *
+ * Determines there is any ecc error or not
+ *
+ */
+static void zynqmp_ocm_edac_geterror_info(void __iomem *base,
+					  struct zynqmp_ocm_ecc_status *p, int mask)
+{
+	if (mask & OCM_CEINTR_MASK) {
+		p->ce_cnt++;
+		p->ceinfo.data0 = readl(base + CE_FFD0_OFST);
+		p->ceinfo.data1 = readl(base + CE_FFD1_OFST);
+		p->ceinfo.addr = (OCM_BASEVAL | readl(base + CE_FFA_OFST));
+		writel(ECC_CTRL_CLR_CE_ERR, base + OCM_ISR_OFST);
+	} else if (mask & OCM_UEINTR_MASK) {
+		p->ue_cnt++;
+		p->ueinfo.data0 = readl(base + UE_FFD0_OFST);
+		p->ueinfo.data1 = readl(base + UE_FFD1_OFST);
+		p->ueinfo.addr = (OCM_BASEVAL | readl(base + UE_FFA_OFST));
+		writel(ECC_CTRL_CLR_UE_ERR, base + OCM_ISR_OFST);
+	}
+}
+
+/**
+ * zynqmp_ocm_edac_handle_error - Handle controller error types CE and UE
+ * @dci:	Pointer to the edac device controller instance
+ * @p:		Pointer to the ocm ecc status structure
+ *
+ * Handles the controller ECC correctable and uncorrectable error.
+ */
+static void zynqmp_ocm_edac_handle_error(struct edac_device_ctl_info *dci,
+					 struct zynqmp_ocm_ecc_status *p)
+{
+	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
+	struct ecc_error_info *pinf;
+
+	if (p->ce_cnt) {
+		pinf = &p->ceinfo;
+		snprintf(priv->message, ZYNQMP_OCM_EDAC_MSG_SIZE,
+			 "\n\rOCM ECC error type :%s\n\r"
+			 "Addr: [0x%X]\n\rFault Data[31:0]: [0x%X]\n\r"
+			 "Fault Data[63:32]: [0x%X]",
+			 "CE", pinf->addr, pinf->data0, pinf->data1);
+		edac_device_handle_ce(dci, 0, 0, priv->message);
+	}
+
+	if (p->ue_cnt) {
+		pinf = &p->ueinfo;
+		snprintf(priv->message, ZYNQMP_OCM_EDAC_MSG_SIZE,
+			 "\n\rOCM ECC error type :%s\n\r"
+			 "Addr: [0x%X]\n\rFault Data[31:0]: [0x%X]\n\r"
+			 "Fault Data[63:32]: [0x%X]",
+			 "UE", pinf->addr, pinf->data0, pinf->data1);
+		edac_device_handle_ue(dci, 0, 0, priv->message);
+	}
+
+	memset(p, 0, sizeof(*p));
+}
+
+/**
+ * zynqmp_ocm_edac_intr_handler - isr routine
+ * @irq:        irq number
+ * @dev_id:     device id pointer
+ *
+ * This is the ISR routine called by edac core interrupt thread.
+ * Used to check and post ECC errors.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise
+ */
+static irqreturn_t zynqmp_ocm_edac_intr_handler(int irq, void *dev_id)
+{
+	struct edac_device_ctl_info *dci = dev_id;
+	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
+	int regval;
+
+	regval = readl(priv->baseaddr + OCM_ISR_OFST);
+	if (!(regval & OCM_CEUE_MASK))
+		return IRQ_NONE;
+
+	zynqmp_ocm_edac_geterror_info(priv->baseaddr,
+				      &priv->stat, regval);
+
+	priv->ce_cnt += priv->stat.ce_cnt;
+	priv->ue_cnt += priv->stat.ue_cnt;
+	zynqmp_ocm_edac_handle_error(dci, &priv->stat);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * zynqmp_ocm_edac_get_eccstate - Return the controller ecc status
+ * @base:	Pointer to the ddr memory controller base address
+ *
+ * Get the ECC enable/disable status for the controller
+ *
+ * Return: ecc status 0/1.
+ */
+static bool zynqmp_ocm_edac_get_eccstate(void __iomem *base)
+{
+	return readl(base + ECC_CTRL_OFST) & OCM_ECC_ENABLE_MASK;
+}
+
+static const struct of_device_id zynqmp_ocm_edac_match[] = {
+	{ .compatible = "xlnx,zynqmp-ocmc-1.0"},
+	{ /* end of table */ }
+};
+
+MODULE_DEVICE_TABLE(of, zynqmp_ocm_edac_match);
+
+/**
+ * zynqmp_ocm_edac_inject_fault_count_show - Shows fault injection count
+ * @dci:        Pointer to the edac device struct
+ * @data:       Pointer to user data
+ *
+ * Shows the fault injection count, once the counter reaches
+ * zero, it injects errors
+ * Return: Number of bytes copied on success else error code.
+ */
+static ssize_t zynqmp_ocm_edac_inject_fault_count_show(struct edac_device_ctl_info *dci,
+						       char *data)
+{
+	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
+
+	return sprintf(data, "FIC: 0x%x\n\r",
+			readl(priv->baseaddr + OCM_FIC_OFST));
+}
+
+/**
+ * zynqmp_ocm_edac_inject_fault_count_store - write fi count
+ * @dci:	Pointer to the edac device struct
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * Update the fault injection count register, once the counter reaches
+ * zero, it injects errors
+ * Return: Number of bytes copied on success else error code.
+ */
+static ssize_t zynqmp_ocm_edac_inject_fault_count_store(struct edac_device_ctl_info *dci,
+							const char *data, size_t count)
+{
+	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
+	u32 ficount;
+
+	if (!data)
+		return -EFAULT;
+
+	if (kstrtouint(data, 0, &ficount))
+		return -EINVAL;
+
+	ficount &= OCM_FICOUNT_MASK;
+	writel(ficount, priv->baseaddr + OCM_FIC_OFST);
+
+	return count;
+}
+
+/**
+ * zynqmp_ocm_edac_inject_cebitpos_show - Shows CE bit position
+ * @dci:        Pointer to the edac device struct
+ * @data:       Pointer to user data
+ *
+ * Shows the Correctable error bit position,
+ * Return: Number of bytes copied on success else error code.
+ */
+static ssize_t zynqmp_ocm_edac_inject_cebitpos_show(struct edac_device_ctl_info
+							*dci, char *data)
+{
+	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
+
+	if (priv->ce_bitpos <= UE_MAX_BITPOS_LOWER)
+		return sprintf(data, "Fault Injection Data Reg: [0x%x]\n\r",
+			((readl(priv->baseaddr + OCM_FID0_OFST))));
+
+	return sprintf(data, "Fault Injection Data Reg: [0x%x]\n\r",
+			((readl(priv->baseaddr + OCM_FID1_OFST))));
+}
+
+/**
+ * zynqmp_ocm_edac_inject_cebitpos_store - Set CE bit position
+ * @dci:	Pointer to the edac device struct
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * Set any one bit to inject CE error
+ * Return: Number of bytes copied on success else error code.
+ */
+static ssize_t zynqmp_ocm_edac_inject_cebitpos_store(struct edac_device_ctl_info *dci,
+						     const char *data, size_t count)
+{
+	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
+
+	if (!data)
+		return -EFAULT;
+
+	if (kstrtou8(data, 0, &priv->ce_bitpos))
+		return -EINVAL;
+
+	if (priv->ce_bitpos <= UE_MAX_BITPOS_LOWER) {
+		writel(1 << priv->ce_bitpos, priv->baseaddr + OCM_FID0_OFST);
+		writel(0, priv->baseaddr + OCM_FID1_OFST);
+	} else if (priv->ce_bitpos <= UE_MAX_BITPOS_UPPER) {
+		writel(1 << (priv->ce_bitpos - UE_MIN_BITPOS_UPPER),
+		       priv->baseaddr + OCM_FID1_OFST);
+		writel(0, priv->baseaddr + OCM_FID0_OFST);
+	} else {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Bit number > 64 is not valid\n");
+	}
+
+	return count;
+}
+
+/**
+ * zynqmp_ocm_edac_inject_uebitpos0_show - Shows UE bit postion0
+ * @dci:        Pointer to the edac device struct
+ * @data:       Pointer to user data
+ *
+ * Shows the one of bit position for UE error
+ * Return: Number of bytes copied on success else error code.
+ */
+static ssize_t zynqmp_ocm_edac_inject_uebitpos0_show(struct edac_device_ctl_info *dci,
+						     char *data)
+{
+	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
+
+	if (priv->ue_bitpos0 <= UE_MAX_BITPOS_LOWER)
+		return sprintf(data, "Fault Injection Data Reg: [0x%x]\n\r",
+			((readl(priv->baseaddr + OCM_FID0_OFST))));
+
+	return sprintf(data, "Fault Injection Data Reg: [0x%x]\n\r",
+			((readl(priv->baseaddr + OCM_FID1_OFST))));
+}
+
+/**
+ * zynqmp_ocm_edac_inject_uebitpos0_store - set UE bit position0
+ * @dci:	Pointer to the edac device struct
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * Set the first bit position for UE Error generation,we need to configure
+ * any two bit positions to inject UE Error
+ * Return: Number of bytes copied on success else error code.
+ */
+static ssize_t zynqmp_ocm_edac_inject_uebitpos0_store(struct edac_device_ctl_info *dci,
+						      const char *data, size_t count)
+{
+	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
+
+	if (!data)
+		return -EFAULT;
+
+	if (kstrtou8(data, 0, &priv->ue_bitpos0))
+		return -EINVAL;
+
+	if (priv->ue_bitpos0 <= UE_MAX_BITPOS_LOWER)
+		writel(1 << priv->ue_bitpos0, priv->baseaddr + OCM_FID0_OFST);
+	else if (priv->ue_bitpos0 <= UE_MAX_BITPOS_UPPER)
+		writel(1 << (priv->ue_bitpos0 - UE_MIN_BITPOS_UPPER),
+		       priv->baseaddr + OCM_FID1_OFST);
+	else
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Bit position > 64 is not valid\n");
+	edac_printk(KERN_INFO, EDAC_DEVICE,
+		    "Set another bit position for UE\n");
+
+	return count;
+}
+
+/**
+ * zynqmp_ocm_edac_inject_uebitpos1_show - Shows UE bit postion1
+ * @dci:        Pointer to the edac device struct
+ * @data:       Pointer to user data
+ *
+ * Shows the second bit position configured for UE error
+ * Return: Number of bytes copied on success else error code.
+ */
+static ssize_t zynqmp_ocm_edac_inject_uebitpos1_show(struct edac_device_ctl_info *dci,
+						     char *data)
+{
+	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
+
+	if (priv->ue_bitpos1 <= UE_MAX_BITPOS_LOWER)
+		return sprintf(data, "Fault Injection Data Reg: [0x%x]\n\r",
+			((readl(priv->baseaddr + OCM_FID0_OFST))));
+
+	return sprintf(data, "Fault Injection Data Reg: [0x%x]\n\r",
+			((readl(priv->baseaddr + OCM_FID1_OFST))));
+}
+
+/**
+ * zynqmp_ocm_edac_inject_uebitpos1_store - Set UE second bit position
+ * @dci:	Pointer to the edac device struct
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * Set the second bit position for UE Error generation,we need to configure
+ * any two bit positions to inject UE Error
+ * Return: Number of bytes copied on success else error code.
+ */
+static ssize_t zynqmp_ocm_edac_inject_uebitpos1_store(struct edac_device_ctl_info *dci,
+						      const char *data, size_t count)
+{
+	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
+	u32 mask;
+
+	if (!data)
+		return -EFAULT;
+
+	if (kstrtou8(data, 0, &priv->ue_bitpos1))
+		return -EINVAL;
+
+	if (priv->ue_bitpos0 == priv->ue_bitpos1) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Bit positions should not be equal\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * If both bit positions are referring to 32 bit data, then configure
+	 * only FID0 register or if it is 64 bit data, then configure only
+	 * FID1 register.
+	 */
+	if (priv->ue_bitpos0 <= UE_MAX_BITPOS_LOWER &&
+	    priv->ue_bitpos1 <= UE_MAX_BITPOS_LOWER) {
+		mask = (1 << priv->ue_bitpos0);
+		mask |= (1 << priv->ue_bitpos1);
+		writel(mask, priv->baseaddr + OCM_FID0_OFST);
+		writel(0, priv->baseaddr + OCM_FID1_OFST);
+	} else if ((priv->ue_bitpos0 >= UE_MIN_BITPOS_UPPER &&
+		    priv->ue_bitpos0 <= UE_MAX_BITPOS_UPPER) &&
+		   (priv->ue_bitpos1 >= UE_MIN_BITPOS_UPPER &&
+		    priv->ue_bitpos1 <= UE_MAX_BITPOS_UPPER)) {
+		mask = (1 << (priv->ue_bitpos0 - UE_MIN_BITPOS_UPPER));
+		mask |= (1 << (priv->ue_bitpos1 - UE_MIN_BITPOS_UPPER));
+		writel(mask, priv->baseaddr + OCM_FID1_OFST);
+		writel(0, priv->baseaddr + OCM_FID0_OFST);
+	}
+
+	/*
+	 * If one bit position is referring a bit in 32 bit data and other in
+	 * 64 bit data, just configure FID0/FID1 based on uebitpos1.
+	 */
+	if (priv->ue_bitpos0 <= UE_MAX_BITPOS_LOWER &&
+	    (priv->ue_bitpos1 >= UE_MIN_BITPOS_UPPER &&
+	     priv->ue_bitpos1 <= UE_MAX_BITPOS_UPPER)) {
+		writel(1 << (priv->ue_bitpos1 - UE_MIN_BITPOS_UPPER),
+		       priv->baseaddr + OCM_FID1_OFST);
+	} else if ((priv->ue_bitpos0 >= UE_MIN_BITPOS_UPPER &&
+		    priv->ue_bitpos0 <= UE_MAX_BITPOS_UPPER) &&
+		   (priv->ue_bitpos1 <= UE_MAX_BITPOS_LOWER)) {
+		writel(1 << priv->ue_bitpos1,
+		       priv->baseaddr + OCM_FID0_OFST);
+	} else {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Bit position > 64 is not valid, Valid bits:[63:0]\n");
+	}
+
+	edac_printk(KERN_INFO, EDAC_DEVICE,
+		    "UE at Bit Position0: %d Bit Position1: %d\n",
+		    priv->ue_bitpos0, priv->ue_bitpos1);
+
+	return count;
+}
+
+static struct edac_dev_sysfs_attribute zynqmp_ocm_edac_sysfs_attributes[] = {
+	{
+		.attr = {
+			.name = "inject_cebitpos",
+			.mode = (0644)
+		},
+		.show = zynqmp_ocm_edac_inject_cebitpos_show,
+		.store = zynqmp_ocm_edac_inject_cebitpos_store},
+	{
+		.attr = {
+			.name = "inject_uebitpos0",
+			.mode = (0644)
+		},
+		.show = zynqmp_ocm_edac_inject_uebitpos0_show,
+		.store = zynqmp_ocm_edac_inject_uebitpos0_store},
+	{
+		.attr = {
+			.name = "inject_uebitpos1",
+			.mode = (0644)
+		},
+		.show = zynqmp_ocm_edac_inject_uebitpos1_show,
+		.store = zynqmp_ocm_edac_inject_uebitpos1_store},
+	{
+		.attr = {
+			.name = "inject_fault_count",
+			.mode = (0644)
+		},
+		.show = zynqmp_ocm_edac_inject_fault_count_show,
+		.store = zynqmp_ocm_edac_inject_fault_count_store},
+	/* End of list */
+	{
+		.attr = {.name = NULL}
+	}
+};
+
+/**
+ * zynqmp_set_ocm_edac_sysfs_attributes - create sysfs attributes
+ * @edac_dev:	Pointer to the edac device struct
+ *
+ * Creates sysfs entries for error injection
+ */
+static void zynqmp_set_ocm_edac_sysfs_attributes(struct edac_device_ctl_info
+						*edac_dev)
+{
+	edac_dev->sysfs_attributes = zynqmp_ocm_edac_sysfs_attributes;
+}
+
+/**
+ * zynqmp_ocm_edac_probe - Check controller and bind driver
+ * @pdev:	Pointer to the platform_device struct
+ *
+ * Probes a specific controller instance for binding with the driver.
+ *
+ * Return: 0 if the controller instance was successfully bound to the
+ * driver; otherwise error code.
+ */
+static int zynqmp_ocm_edac_probe(struct platform_device *pdev)
+{
+	struct zynqmp_ocm_edac_priv *priv;
+	struct edac_device_ctl_info *dci;
+	void __iomem *baseaddr;
+	struct resource *res;
+	int irq, ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	baseaddr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(baseaddr))
+		return PTR_ERR(baseaddr);
+
+	if (!zynqmp_ocm_edac_get_eccstate(baseaddr)) {
+		edac_printk(KERN_INFO, EDAC_DEVICE,
+			    "ECC not enabled - Disabling EDAC driver\n");
+		return -ENXIO;
+	}
+
+	dci = edac_device_alloc_ctl_info(sizeof(*priv), ZYNQMP_OCM_EDAC_STRING,
+					 1, ZYNQMP_OCM_EDAC_STRING, 1, 0, NULL, 0,
+					 edac_device_alloc_index());
+	if (!dci) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Unable to allocate EDAC device\n");
+		return -ENOMEM;
+	}
+
+	priv = dci->pvt_info;
+	platform_set_drvdata(pdev, dci);
+	dci->dev = &pdev->dev;
+	priv->baseaddr = baseaddr;
+	dci->mod_name = pdev->dev.driver->name;
+	dci->ctl_name = ZYNQMP_OCM_EDAC_STRING;
+	dci->dev_name = dev_name(&pdev->dev);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "No irq %d in DT\n", irq);
+		ret = irq;
+		goto free_dev_ctl;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq,
+			       zynqmp_ocm_edac_intr_handler,
+			       0, dev_name(&pdev->dev), dci);
+	if (ret) {
+		edac_printk(KERN_ERR, EDAC_DEVICE, "Failed to request Irq\n");
+		goto free_dev_ctl;
+	}
+
+	writel(OCM_CEUE_MASK, priv->baseaddr + OCM_IEN_OFST);
+
+	zynqmp_set_ocm_edac_sysfs_attributes(dci);
+	ret = edac_device_add_device(dci);
+	if (ret)
+		goto free_dev_ctl;
+
+	return 0;
+
+free_dev_ctl:
+	edac_device_free_ctl_info(dci);
+
+	return ret;
+}
+
+/**
+ * zynqmp_ocm_edac_remove - Unbind driver from controller
+ * @pdev:	Pointer to the platform_device struct
+ *
+ * Return: Unconditionally 0
+ */
+static int zynqmp_ocm_edac_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
+	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
+
+	writel(OCM_CEUE_MASK, priv->baseaddr + OCM_IDS_OFST);
+	edac_device_del_device(&pdev->dev);
+	edac_device_free_ctl_info(dci);
+
+	return 0;
+}
+
+static struct platform_driver zynqmp_ocm_edac_driver = {
+	.driver = {
+		   .name = "zynqmp-ocm-edac",
+		   .of_match_table = zynqmp_ocm_edac_match,
+		   },
+	.probe = zynqmp_ocm_edac_probe,
+	.remove = zynqmp_ocm_edac_remove,
+};
+
+module_platform_driver(zynqmp_ocm_edac_driver);
+
+MODULE_AUTHOR("Advanced Micro Devices, Inc");
+MODULE_DESCRIPTION("ZynqMP OCM ECC driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

