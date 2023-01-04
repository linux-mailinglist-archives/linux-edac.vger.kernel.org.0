Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C535565CEB0
	for <lists+linux-edac@lfdr.de>; Wed,  4 Jan 2023 09:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjADIrx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Jan 2023 03:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbjADIqX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Jan 2023 03:46:23 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0F81A212;
        Wed,  4 Jan 2023 00:46:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaG+XKrbgICFjcVrj5lMPfWmU3MrvqbFQ1Z0KKbYBe/D96DldHXT6GnZnMmV3Ld7eBAASD5AJBjcCb+q0SneOVcVTJLgygsQa2hEVrIgvqIxusQdXBpZNJ3/Q/h99awkvUHhoTOOXTqHBepM0YlHceYEYPWRm8syZqDlyPeUYZscavmaGeG+BhxYoHZgKcEWBjd2u/XX4H9N9n6a7O9/ddYlQjlRfdpPaQUc7JYC9qPqY/VrkrBRFdY2Njqu3HrhiOarxRdkKAH5iybED9fJVi8hcOS9CNu/bAHMPwgDA17sy4USIknJlj3bitaBgEvOO/aWdisjoSCenua0CACcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LAlgaDiFBuoBrt/h4a+gzpNU/00O6LTwddxJLOvbzk=;
 b=ORj3tJJlZ0CwY1ca5y1UJdIO5nPcX7uveN1fMSLz2So8xbfl8ZBx1isV7Fgl6EErcUOW+OQaJLNuovxFdFEDYUoxpSvgt/d6linMx/Cov7DVSgRzF7eFVV7G37laBCRFrf8GOdeafpPRHdtU/V4ruc5ZnLQdpIf+mhl9ccMgTbdnNSwksVagK2IY1PzduFqVokS6Jv6pD4UBfYfvGPJ9NtVcxci0bN7lqglWZG58SqEJUQU97XMNt6GbsFSQmgiBwSpfbbr3Fly74dZSvjh+xzm/WjcoJBdkU/nrYvg9hJs0vxY4Cdzwz+BUb/jDLzCi/YROOa/LaRfTMsy7SbHzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LAlgaDiFBuoBrt/h4a+gzpNU/00O6LTwddxJLOvbzk=;
 b=ZMIUpCOOq8FE7J1akCq9HKyL4bhSeXcCEajcH6ICVjlOttpSsp7wsiyVCLzE1E1LGYXcqRWv3dRAVk/rJF/ndh/AzpuEFNaMSOD1DyYbvVRLx/x48vANYrCgTv3/qP6Fi4Jo8Xjlt9eI2eB6kdps1Q+e2CtIGnkfBL1V3iTUfmo=
Received: from MW2PR16CA0045.namprd16.prod.outlook.com (2603:10b6:907:1::22)
 by PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 08:46:18 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::cc) by MW2PR16CA0045.outlook.office365.com
 (2603:10b6:907:1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Wed, 4 Jan 2023 08:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.17 via Frontend Transport; Wed, 4 Jan 2023 08:46:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 02:46:13 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 02:46:00 -0600
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 4 Jan 2023 02:45:56 -0600
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
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v7 2/2] EDAC/zynqmp: Add EDAC support for Xilinx ZynqMP OCM
Date:   Wed, 4 Jan 2023 14:15:12 +0530
Message-ID: <20230104084512.1855243-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230104084512.1855243-1-sai.krishna.potthuri@amd.com>
References: <20230104084512.1855243-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT035:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: c870512d-f052-4658-a2a9-08daee302565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cR7z7CBXLsUOKbsV9DskgAKhyiRLGpBEfjf9N9DLc9ku3BP912Z2y7DyIqgVnuEgjqOih6DxuHOqY0SfQpt/ibBa5tbj0SRETBBCBQi/raq86b6Qh6KJEJRucLZwiKHjVFuAANhSgxgwuDRGnTZHUZXA10Ukfm7TeFDNoHw5Co71JFG/VDiYTPbwQ9WNL+qEbuYY73q61JWBIyssB4OGUo2mk8wxekyXU4Pm95RXSyjZG1hyPh/NKrrnR87px0qN0Qi59pT1W8hyT7CWnDHqTVtOLZJNornLjAbyStxbeSO7jb3DCjOeFjxnSVJt6wmR6S0hVixe8RqFsmCdrAh10TYG1dtCG01NuA5gUwFeKi9WCAJYkjOdxvQtIxPcepJjEjSxryj9mHwGoGwJYKdua09gUJuvo90VN+xQ40PCXI/Gl46CkPY7IYQo8SxIyMc419zfRqoxzkTr6ky+yoo57+fyvOn2JaDem0lzPd9riTGf/0CMGeU+edmBUAgLolh1AH+K6UEbQJ4ZRl4ILylOmTBUf4mKNnBfLFNuAPoH7xrUatIQy5yYudcvIKmLjROMjJuWp/4R6u56noJuT173EfPOH9rqFQjVlOrDo5zNzEHiQU7T5tAwYH48fvantP/FIhRvtBe0OCGdzkMDNIgsR9U/k0CHbAtY1ACMYhmBdtzfqcFy41YchLDwNiObWSY5vkwzrYbyd6XBPCHvV/HxGlIXCZG9j8tLM5u5+Eu/fkI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(8676002)(4326008)(5660300002)(70206006)(6666004)(40460700003)(70586007)(316002)(8936002)(41300700001)(7416002)(54906003)(110136005)(2906002)(103116003)(478600001)(356005)(82740400003)(81166007)(186003)(26005)(2616005)(336012)(47076005)(1076003)(426003)(36860700001)(36756003)(86362001)(40480700001)(30864003)(82310400005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 08:46:17.7886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c870512d-f052-4658-a2a9-08daee302565
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add EDAC support for Xilinx ZynqMP OCM Controller, so this driver
reports CE and UE errors upon interrupt generation, and also creates UE/CE
debugfs entries for error injection.
On Xilinx ZynqMP platform, both OCM Controller driver(zynqmp_edac) and
DDR Memory Controller driver(synopsys_edac) co-exist which means both
can be loaded at a time. This scenario is tested on Xilinx ZynqMP
platform.

Fix following issue reported by the robot.
"MAINTAINERS references a file that doesn't exist:
Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml"

Co-developed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 MAINTAINERS                |   7 +
 drivers/edac/Kconfig       |   9 +
 drivers/edac/Makefile      |   1 +
 drivers/edac/zynqmp_edac.c | 465 +++++++++++++++++++++++++++++++++++++
 4 files changed, 482 insertions(+)
 create mode 100644 drivers/edac/zynqmp_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index edc96cdb85e8..2b6e74025549 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21692,6 +21692,13 @@ F:	Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
 F:	drivers/dma/xilinx/xilinx_dpdma.c
 F:	include/dt-bindings/dma/xlnx-zynqmp-dpdma.h
 
+XILINX ZYNQMP OCM EDAC DRIVER
+M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml
+F:	drivers/edac/zynqmp_edac.c
+
 XILINX ZYNQMP PSGTR PHY DRIVER
 M:	Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 58ab63642e72..7944e40c67da 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -539,4 +539,13 @@ config EDAC_DMC520
 	  Support for error detection and correction on the
 	  SoCs with ARM DMC-520 DRAM controller.
 
+config EDAC_ZYNQMP_OCM
+	tristate "Xilinx ZynqMP OCM Controller"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	help
+	  This driver supports error detection and correction for the
+	  Xilinx ZynqMP OCM (On Chip Memory) controller.
+	  This driver can also be built as a module. If so, the module
+	  will be called zynqmp_ocm_edac.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 2d1641a27a28..47cbda06d7b0 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -84,3 +84,4 @@ obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
 obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
+obj-$(CONFIG_EDAC_ZYNQMP_OCM)		+= zynqmp_edac.o
diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
new file mode 100644
index 000000000000..69069028457b
--- /dev/null
+++ b/drivers/edac/zynqmp_edac.c
@@ -0,0 +1,465 @@
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
+/* Error/Interrupt registers */
+#define ERR_CTRL_OFST		0x0
+#define OCM_ISR_OFST		0x04
+#define OCM_IMR_OFST		0x08
+#define OCM_IEN_OFST		0x0C
+#define OCM_IDS_OFST		0x10
+
+/* ECC control register */
+#define ECC_CTRL_OFST		0x14
+
+/* Correctable error info registers */
+#define CE_FFA_OFST		0x1C
+#define CE_FFD0_OFST		0x20
+#define CE_FFD1_OFST		0x24
+#define CE_FFD2_OFST		0x28
+#define CE_FFD3_OFST		0x2C
+#define CE_FFE_OFST		0x30
+
+/* Uncorrectable error info registers */
+#define UE_FFA_OFST		0x34
+#define UE_FFD0_OFST		0x38
+#define UE_FFD1_OFST		0x3C
+#define UE_FFD2_OFST		0x40
+#define UE_FFD3_OFST		0x44
+#define UE_FFE_OFST		0x48
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
+
+#define OCM_FICOUNT_MASK	GENMASK(23, 0)
+#define OCM_NUM_UE_BITPOS	2
+#define OCM_BASEVAL		0xFFFC0000
+#define EDAC_DEVICE		"ZynqMP-OCM"
+
+/**
+ * struct ecc_error_info - ECC error log information
+ * @addr:	Fault generated at this address
+ * @fault_lo:	Generated fault data (lower 32-bit)
+ * @fault_hi:	Generated fault data (upper 32-bit)
+ */
+struct ecc_error_info {
+	u32 addr;
+	u32 fault_lo;
+	u32 fault_hi;
+};
+
+/**
+ * struct ecc_status - ECC status information to report
+ * @ce_cnt:	Correctable error count
+ * @ue_cnt:	Uncorrectable error count
+ * @ceinfo:	Correctable error log information
+ * @ueinfo:	Uncorrectable error log information
+ */
+struct ecc_status {
+	u32 ce_cnt;
+	u32 ue_cnt;
+	struct ecc_error_info ceinfo;
+	struct ecc_error_info ueinfo;
+};
+
+/**
+ * struct edac_priv - OCM private instance data
+ * @baseaddr:	Base address of the OCM
+ * @message:	Buffer for framing the event specific info
+ * @stat:	ECC status information
+ * @ce_cnt:	Correctable Error count
+ * @ue_cnt:	Uncorrectable Error count
+ * @debugfs_dir:	Directory entry for debugfs
+ * @ce_bitpos:	Bit position for Correctable Error
+ * @ue_bitpos:	Array to store UnCorrectable Error bit positions
+ * @fault_injection_cnt: Fault Injection Counter value
+ */
+struct edac_priv {
+	void __iomem *baseaddr;
+	char message[ZYNQMP_OCM_EDAC_MSG_SIZE];
+	struct ecc_status stat;
+	u32 ce_cnt;
+	u32 ue_cnt;
+#ifdef CONFIG_EDAC_DEBUG
+	struct dentry *debugfs_dir;
+	u8 ce_bitpos;
+	u8 ue_bitpos[OCM_NUM_UE_BITPOS];
+	u32 fault_injection_cnt;
+#endif
+};
+
+/**
+ * get_error_info - Get the current ECC error info
+ * @base:	Pointer to the base address of the OCM
+ * @p:		Pointer to the OCM ECC status structure
+ * @mask:	Status register mask value
+ *
+ * Determines there is any ECC error or not
+ *
+ */
+static void get_error_info(void __iomem *base, struct ecc_status *p, int mask)
+{
+	if (mask & OCM_CEINTR_MASK) {
+		p->ce_cnt++;
+		p->ceinfo.fault_lo = readl(base + CE_FFD0_OFST);
+		p->ceinfo.fault_hi = readl(base + CE_FFD1_OFST);
+		p->ceinfo.addr = (OCM_BASEVAL | readl(base + CE_FFA_OFST));
+		writel(ECC_CTRL_CLR_CE_ERR, base + OCM_ISR_OFST);
+	} else {
+		p->ue_cnt++;
+		p->ueinfo.fault_lo = readl(base + UE_FFD0_OFST);
+		p->ueinfo.fault_hi = readl(base + UE_FFD1_OFST);
+		p->ueinfo.addr = (OCM_BASEVAL | readl(base + UE_FFA_OFST));
+		writel(ECC_CTRL_CLR_UE_ERR, base + OCM_ISR_OFST);
+	}
+}
+
+/**
+ * handle_error - Handle error types CE and UE
+ * @dci:	Pointer to the EDAC device instance
+ * @p:		Pointer to the OCM ECC status structure
+ *
+ * Handles the ECC correctable and uncorrectable error.
+ */
+static void handle_error(struct edac_device_ctl_info *dci, struct ecc_status *p)
+{
+	struct edac_priv *priv = dci->pvt_info;
+	struct ecc_error_info *pinf;
+
+	if (p->ce_cnt) {
+		pinf = &p->ceinfo;
+		snprintf(priv->message, ZYNQMP_OCM_EDAC_MSG_SIZE,
+			 "\nOCM ECC error type :%s\nAddr: [0x%x]\nFault Data[0x%08x%08x]",
+			 "CE", pinf->addr, pinf->fault_hi, pinf->fault_lo);
+		edac_device_handle_ce(dci, 0, 0, priv->message);
+	}
+
+	if (p->ue_cnt) {
+		pinf = &p->ueinfo;
+		snprintf(priv->message, ZYNQMP_OCM_EDAC_MSG_SIZE,
+			 "\nOCM ECC error type :%s\nAddr: [0x%x]\nFault Data[0x%08x%08x]",
+			 "UE", pinf->addr, pinf->fault_hi, pinf->fault_lo);
+		edac_device_handle_ue(dci, 0, 0, priv->message);
+	}
+
+	memset(p, 0, sizeof(*p));
+}
+
+/**
+ * intr_handler - ISR routine
+ * @irq:        irq number
+ * @dev_id:     device id pointer
+ *
+ * Return: IRQ_NONE, if CE/UE interrupt not set or IRQ_HANDLED otherwise
+ */
+static irqreturn_t intr_handler(int irq, void *dev_id)
+{
+	struct edac_device_ctl_info *dci = dev_id;
+	struct edac_priv *priv = dci->pvt_info;
+	int regval;
+
+	regval = readl(priv->baseaddr + OCM_ISR_OFST);
+	if (!(regval & (OCM_CEINTR_MASK | OCM_UEINTR_MASK))) {
+		WARN_ONCE(1, "Unhandled IRQ%d.", irq);
+		return IRQ_NONE;
+	}
+
+	get_error_info(priv->baseaddr, &priv->stat, regval);
+
+	priv->ce_cnt += priv->stat.ce_cnt;
+	priv->ue_cnt += priv->stat.ue_cnt;
+	handle_error(dci, &priv->stat);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * get_eccstate - Return the ECC status
+ * @base:	Pointer to the OCM base address
+ *
+ * Get the ECC enable/disable status
+ *
+ * Return: ECC status 0/1.
+ */
+static bool get_eccstate(void __iomem *base)
+{
+	return readl(base + ECC_CTRL_OFST) & OCM_ECC_ENABLE_MASK;
+}
+
+#ifdef CONFIG_EDAC_DEBUG
+/**
+ * write_fault_count - write fault injection count
+ * @priv:	Pointer to the EDAC private struct
+ *
+ * Update the fault injection count register, once the counter reaches
+ * zero, it injects errors
+ */
+static void write_fault_count(struct edac_priv *priv)
+{
+	u32 ficount = priv->fault_injection_cnt;
+
+	if (ficount & ~OCM_FICOUNT_MASK) {
+		ficount &= OCM_FICOUNT_MASK;
+		edac_printk(KERN_INFO, EDAC_DEVICE,
+			    "Fault injection count value truncated to %d\n", ficount);
+	}
+
+	writel(ficount, priv->baseaddr + OCM_FIC_OFST);
+}
+
+/*
+ * To get the Correctable Error injected, the following steps are needed:
+ * - Setup the optional Fault Injection Count:
+ *	echo <fault_count val> > /sys/kernel/debug/edac/ocm/inject_fault_count
+ * - Write the Correctable Error bit position value:
+ *	echo <bit_pos val> > /sys/kernel/debug/edac/ocm/inject_ce_bitpos
+ */
+static ssize_t inject_ce_write(struct file *file, const char __user *data,
+			       size_t count, loff_t *ppos)
+{
+	struct edac_device_ctl_info *edac_dev = file->private_data;
+	struct edac_priv *priv = edac_dev->pvt_info;
+	int ret;
+
+	if (!data)
+		return -EFAULT;
+
+	ret = kstrtou8_from_user(data, count, 0, &priv->ce_bitpos);
+	if (ret)
+		return ret;
+
+	if (priv->ce_bitpos > UE_MAX_BITPOS_UPPER)
+		return -EINVAL;
+
+	if (priv->ce_bitpos <= UE_MAX_BITPOS_LOWER) {
+		writel(BIT(priv->ce_bitpos), priv->baseaddr + OCM_FID0_OFST);
+		writel(0, priv->baseaddr + OCM_FID1_OFST);
+	} else {
+		writel(BIT(priv->ce_bitpos - UE_MIN_BITPOS_UPPER),
+		       priv->baseaddr + OCM_FID1_OFST);
+		writel(0, priv->baseaddr + OCM_FID0_OFST);
+	}
+
+	write_fault_count(priv);
+
+	return count;
+}
+
+static const struct file_operations inject_ce_fops = {
+	.open = simple_open,
+	.write = inject_ce_write,
+	.llseek = generic_file_llseek,
+};
+
+/*
+ * To get the Uncorrectable Error injected, the following steps are needed:
+ * - Setup the optional Fault Injection Count:
+ *      echo <fault_count val> > /sys/kernel/debug/edac/ocm/inject_fault_count
+ * - Write the Uncorrectable Error bit position values:
+ *      echo <bit_pos0 val>,<bit_pos1 val> > /sys/kernel/debug/edac/ocm/inject_ue_bitpos
+ */
+static ssize_t inject_ue_write(struct file *file, const char __user *data,
+			       size_t count, loff_t *ppos)
+{
+	struct edac_device_ctl_info *edac_dev = file->private_data;
+	struct edac_priv *priv = edac_dev->pvt_info;
+	char buf[6], *pbuf, *token[2];
+	u64 ue_bitpos;
+	int i, ret;
+	u8 len;
+
+	if (!data)
+		return -EFAULT;
+
+	len = min_t(size_t, count, sizeof(buf));
+	if (copy_from_user(buf, data, len))
+		return -EFAULT;
+
+	buf[len] = '\0';
+	pbuf = &buf[0];
+	for (i = 0; i < OCM_NUM_UE_BITPOS; i++)
+		token[i] = strsep(&pbuf, ",");
+
+	ret = kstrtou8(token[0], 0, &priv->ue_bitpos[0]);
+	if (ret)
+		return ret;
+
+	ret = kstrtou8(token[1], 0, &priv->ue_bitpos[1]);
+	if (ret)
+		return ret;
+
+	ue_bitpos = BIT(priv->ue_bitpos[0]) | BIT(priv->ue_bitpos[1]);
+
+	if (priv->ue_bitpos[0] == priv->ue_bitpos[1]) {
+		edac_printk(KERN_ERR, EDAC_DEVICE, "Bit positions should not be equal\n");
+		return -EINVAL;
+	}
+
+	if (priv->ue_bitpos[0] > UE_MAX_BITPOS_UPPER ||
+	    priv->ue_bitpos[1] > UE_MAX_BITPOS_UPPER)
+		return -EINVAL;
+
+	writel((u32)ue_bitpos, priv->baseaddr + OCM_FID0_OFST);
+	writel((u32)(ue_bitpos >> 32), priv->baseaddr + OCM_FID1_OFST);
+
+	write_fault_count(priv);
+
+	return count;
+}
+
+static const struct file_operations inject_ue_fops = {
+	.open = simple_open,
+	.write = inject_ue_write,
+	.llseek = generic_file_llseek,
+};
+
+static void setup_debugfs(struct edac_device_ctl_info *edac_dev)
+{
+	struct edac_priv *priv = edac_dev->pvt_info;
+
+	priv->debugfs_dir = edac_debugfs_create_dir("ocm");
+	if (!priv->debugfs_dir)
+		return;
+
+	edac_debugfs_create_x32("inject_fault_count", 0644, priv->debugfs_dir,
+				&priv->fault_injection_cnt);
+	edac_debugfs_create_file("inject_ue_bitpos", 0644, priv->debugfs_dir,
+				 edac_dev, &inject_ue_fops);
+	edac_debugfs_create_file("inject_ce_bitpos", 0644, priv->debugfs_dir,
+				 edac_dev, &inject_ce_fops);
+}
+#endif
+
+static int edac_probe(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *dci;
+	struct edac_priv *priv;
+	void __iomem *baseaddr;
+	struct resource *res;
+	int irq, ret;
+
+	baseaddr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(baseaddr))
+		return PTR_ERR(baseaddr);
+
+	if (!get_eccstate(baseaddr)) {
+		edac_printk(KERN_INFO, EDAC_DEVICE, "ECC not enabled\n");
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
+	ret = devm_request_irq(&pdev->dev, irq, intr_handler, 0,
+			       dev_name(&pdev->dev), dci);
+	if (ret) {
+		edac_printk(KERN_ERR, EDAC_DEVICE, "Failed to request Irq\n");
+		goto free_dev_ctl;
+	}
+
+	/* Enable UE, CE interrupts */
+	writel((OCM_CEINTR_MASK | OCM_UEINTR_MASK), priv->baseaddr + OCM_IEN_OFST);
+
+	if (IS_ENABLED(CONFIG_EDAC_DEBUG))
+		setup_debugfs(dci);
+
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
+static int edac_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
+	struct edac_priv *priv = dci->pvt_info;
+
+	/* Disable UE, CE interrupts */
+	writel((OCM_CEINTR_MASK | OCM_UEINTR_MASK), priv->baseaddr + OCM_IDS_OFST);
+
+	if (IS_ENABLED(CONFIG_EDAC_DEBUG))
+		debugfs_remove_recursive(priv->debugfs_dir);
+
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
+	.probe = edac_probe,
+	.remove = edac_remove,
+};
+
+module_platform_driver(zynqmp_ocm_edac_driver);
+
+MODULE_AUTHOR("Advanced Micro Devices, Inc");
+MODULE_DESCRIPTION("Xilinx ZynqMP OCM ECC driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

