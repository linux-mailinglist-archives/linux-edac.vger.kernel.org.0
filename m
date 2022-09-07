Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFA85B02AE
	for <lists+linux-edac@lfdr.de>; Wed,  7 Sep 2022 13:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiIGLRN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Sep 2022 07:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiIGLQp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Sep 2022 07:16:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12B2A723A;
        Wed,  7 Sep 2022 04:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7ElhP5fWNV2s9+4z+v9ENr9Os1642R6w9ZPXew6PbyjVFZywGILbwOA8C9BXLntIo61b3VVJ48yeFxNpwfCZ+qNmdg1nRRKiqNtJqw0Gi7crIRs4/LmEfERacGCgXtMXUs6Kr0MUdih1K1NStRrY6n9KZftHkcWAPffyRhmxq2iGrz1+I51bzqJ9docoCZC42c0cJHXqPiPiRj5zJ3vj4tS4tvxt4MQHgkO2wvdNf1Gl78aPGJ1VmSBqxLrqRlND9nVSGk8EYOA4IlJJSACMtF3tQWarFTpVOswJjoyOjApwyOgjJvn7IB7vvsv5abqODAL+d/jFPOnJLZ4HAW/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BVGDE4UA5oR2PAKTM0LcoFMCPFSa18JCXhLFpeEYVE=;
 b=asCk+fOrMvR9rUGiHQqnJf1ukWjBFvQuaWmM0nUAYJQs7Sm0GWODe/8KQL6uFzUCsz9tBeqAh9MLAUDBhc9woSPUxnowStyAkzJmUnmjzjA7QfNf+Whf14axFaDMrMiHLo+doUS4W+iaK6xf3UucBAUclFjYi5aeqU6RmG39bphjWx430qYSwGrEVhbEW3JUx0ZOjxv/XYsObSUzI4Z9W2n1VkEeEWRsSUr859QmTff0exGm0UIKJb4QzB57z5IfyJh0NHYyt76gI/N8P/l+FYZW2VKFQuQyP/cTZEgON1xZFkp6IiAHISkMsx+x1Xx/ffSVK4wdh5F3clyEElarkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BVGDE4UA5oR2PAKTM0LcoFMCPFSa18JCXhLFpeEYVE=;
 b=0CE0d2K1Cs2ipqX6iLKJmaCuQ5wc7ceRQ2zRgFGjYAfeFOZNcJmwdngZYyqhqJp0gLPG1ILt367V0k7eHQo9p3tp8AFtZqLmDT6ak7Px/HMHszyTcgFgKasl4hy+O9K0vknfVVp9AjoxNTJBWQ9bcVrgTbYkmz+QW2LI7XR0x6s=
Received: from DS7PR05CA0089.namprd05.prod.outlook.com (2603:10b6:8:56::6) by
 CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 11:16:31 +0000
Received: from DS1PEPF0000B078.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::a5) by DS7PR05CA0089.outlook.office365.com
 (2603:10b6:8:56::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5 via Frontend
 Transport; Wed, 7 Sep 2022 11:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B078.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.11 via Frontend Transport; Wed, 7 Sep 2022 11:16:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 06:16:28 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 7 Sep 2022 06:16:23 -0500
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
Subject: [PATCH v4 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM
Date:   Wed, 7 Sep 2022 16:45:31 +0530
Message-ID: <20220907111531.703-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907111531.703-1-sai.krishna.potthuri@amd.com>
References: <20220907111531.703-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B078:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 828f08ec-2b39-4651-1a3a-08da90c26af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQ3daSMkh+w3ANi50ahGbU0RdJ+nGsEaIyht8QLy3C1Z43CgPgkNFcMmp0xTOacsJKJLqSRZQ6WDIb6x0doAJ50QEx1nxn4H5kcYfAh+9S6VD+P3z521gBDTkaYBg+HttC0nKYJU6Xfgf6bSJ1B/CkShj5V05v55ymI6Fuc1R3bFYC0JLZIxnVu8/VJcBqK/xP7ejUFWRmFOgLp6cHNxJaJdm6xhNzJq2rK42hwffSxFDWaObYq0KlMa67pBOBkVDoEZDHCPLwOzkrkJrMzYQ4C1JIGF2y9IVguO4JJfezqvz5/FvSck4M60SamPrLwMImc17clTdENHkgxRbxznIQZ3z2T0X+rWmKCwSHMMt5qy1A946S8CgaueSloC+XU3rBxsWSJKENc5jBdQ2Qe3I0qZeXlrvf2L9VrxoNdGRRJ+IuYKTkbfQ3vrhD+9QKI+cE0hAxfCuwPVvMktZfzO1IXXKnvHETtQqhnNBgVXoU9p58104dfO4xDXTNNfKhUfhh3TDHVibxHSZHob0VxCWsEteENR0SqTST2/2lDwDxC+x3h942NFYhv5pV75vTF0OC6+ZF91+Q7u8Ryg8amBZSgOaCTfdK9I4hadxdraUJbPOR7uSeUqUt1lZRsNVUAL4sV1ga2Lgh+WVvYTQ9X0OcvVMAmBD5wCN18XotDgoc33CcwGYbGd6NAdCfZDssJLLwsTdxgJLuxYP2YfUsjBzlSOTkQBQQJF7vEyWbY0T02KPTrpiYSrX3nbxX8ALrdknXW5peUa+USYm8O6pZ+CeMGuL2knI5M4td8/MAqy558=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(40470700004)(26005)(86362001)(82310400005)(6666004)(356005)(41300700001)(478600001)(40480700001)(2616005)(40460700003)(81166007)(83380400001)(82740400003)(47076005)(336012)(186003)(426003)(316002)(36860700001)(2906002)(103116003)(110136005)(4326008)(8676002)(30864003)(70206006)(54906003)(70586007)(36756003)(7416002)(1076003)(5660300002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 11:16:31.7559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 828f08ec-2b39-4651-1a3a-08da90c26af2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B078.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/edac/zynqmp_ocm_edac.c | 622 +++++++++++++++++++++++++++++++++
 4 files changed, 639 insertions(+)
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
index 58ab63642e72..08adedfd42b5 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -539,4 +539,13 @@ config EDAC_DMC520
 	  Support for error detection and correction on the
 	  SoCs with ARM DMC-520 DRAM controller.
 
+config EDAC_ZYNQMP_OCM
+	tristate "Xilinx ZynqMP OCM Controller"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
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
index 000000000000..a8da94f3e067
--- /dev/null
+++ b/drivers/edac/zynqmp_ocm_edac.c
@@ -0,0 +1,622 @@
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
+			 "\nOCM ECC error type :%s\n"
+			 "Addr: [0x%X]\nFault Data[31:0]: [0x%X]\n"
+			 "Fault Data[63:32]: [0x%X]",
+			 "CE", pinf->addr, pinf->data0, pinf->data1);
+		edac_device_handle_ce(dci, 0, 0, priv->message);
+	}
+
+	if (p->ue_cnt) {
+		pinf = &p->ueinfo;
+		snprintf(priv->message, ZYNQMP_OCM_EDAC_MSG_SIZE,
+			 "\nOCM ECC error type :%s\n"
+			 "Addr: [0x%X]\nFault Data[31:0]: [0x%X]\n"
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
+	return sprintf(data, "FIC: 0x%x\n",
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
+		return sprintf(data, "Fault Injection Data Reg: [0x%x]\n",
+			((readl(priv->baseaddr + OCM_FID0_OFST))));
+
+	return sprintf(data, "Fault Injection Data Reg: [0x%x]\n",
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
+		return sprintf(data, "Fault Injection Data Reg: [0x%x]\n",
+			((readl(priv->baseaddr + OCM_FID0_OFST))));
+
+	return sprintf(data, "Fault Injection Data Reg: [0x%x]\n",
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
+		return sprintf(data, "Fault Injection Data Reg: [0x%x]\n",
+			((readl(priv->baseaddr + OCM_FID0_OFST))));
+
+	return sprintf(data, "Fault Injection Data Reg: [0x%x]\n",
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
+static int zynqmp_ocm_edac_probe(struct platform_device *pdev)
+{
+	struct zynqmp_ocm_edac_priv *priv;
+	struct edac_device_ctl_info *dci;
+	void __iomem *baseaddr;
+	struct resource *res;
+	int irq, ret;
+
+	baseaddr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(baseaddr))
+		return PTR_ERR(baseaddr);
+
+	if (!zynqmp_ocm_edac_get_eccstate(baseaddr)) {
+		edac_printk(KERN_INFO, EDAC_DEVICE,
+			    "ECC not enabled\n");
+		return -ENXIO;
+	}
+
+	dci = edac_device_alloc_ctl_info(sizeof(*priv), ZYNQMP_OCM_EDAC_STRING,
+					 1, ZYNQMP_OCM_EDAC_STRING, 1, 0, NULL, 0,
+					 edac_device_alloc_index());
+	if (!dci)
+		return -ENOMEM;
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
+static const struct of_device_id zynqmp_ocm_edac_match[] = {
+	{ .compatible = "xlnx,zynqmp-ocmc-1.0"},
+	{ /* end of table */ }
+};
+
+MODULE_DEVICE_TABLE(of, zynqmp_ocm_edac_match);
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
+MODULE_DESCRIPTION("Xilinx ZynqMP OCM ECC driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

