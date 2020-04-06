Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 374FB19F68F
	for <lists+linux-edac@lfdr.de>; Mon,  6 Apr 2020 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgDFNOI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Apr 2020 09:14:08 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:16188 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728387AbgDFNOC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 6 Apr 2020 09:14:02 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036D5AiG016521;
        Mon, 6 Apr 2020 06:13:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=ec0MUIkNeP53RpMFp44TreMV7Pj0N8NnHzE1flghV+4=;
 b=ULlYgqGsservtqhYXDUlx2eBmUi0LZMhSVRY4TYI8IhSi+tkNeDPhggvUvsiPyUn7N3s
 fNGprtxCHAoQ+zzxg6qVc6jDARnxSWnzBu4W216AL2bxM4L/YwbhHvVn9+MQR/cMVxYG
 ODK0d8N+kbCDs9MMSHP3OGDLD1I4c29r+Ipc/WamQq2572ZAemn7LKymSsFVJngV9gSz
 W3j0TM3h5l3On5nz5CC7p40jd33LRRaCby+HFU6TXtZpY5K/eT/Jd7GqUa66+NTmuF/z
 iMU1/z8h9ZQHGqjRd2hVhUlr/KGNnRMB60qdrSlvc/posGDdipwVB/Z/w7ajsjzPJmiX mQ== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 306ntxxmbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 06:13:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFjNsRLdBJUn9MoS12/KMeuYbyt+y6emNqx9R8crWFmlrlC7pv1rRLsyWk7fQp3SK6TQDrA3MD7Zz1rAA0sWa8LjuXIFqjEulYzNq9ajEms49Q5cZ4OsIWdDLt6/qu66pzJBCGkw1pcHTY9nMPZu9sSRIwoeYAdJBITzZ2F0lf66z2FKtJckthHVymRi7MvtyBjHpJAuKr6KsUbMsRpgrNJ299raKK+68vXbWhoN1CReP3KLTaMkFmnrsKrp9U3djjU3VGQ/zG+VtBRtr2VkPBULHVZpoWJlrSarxDteRT7t4tYVMkFttaQRlCxmTCK5FfYngK9Ej6BfluueHpgL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ec0MUIkNeP53RpMFp44TreMV7Pj0N8NnHzE1flghV+4=;
 b=PcANcjrHHp3qFS89/pUKTn/pC5m1JJgarkTF9xFnWzE3QAZuCcBgW3dQPrTfYPMsvLP1A86Z8MJ+0YV0n1JeN7OKofzH3GF+JRa/FgDIIMNFPyHsbfDiSZTRpyHh5xjBAAZakwQqx2Xr2+ERFMMPnScIRrJRSdHqoLjsnwzCT4rFIGpCnpBV/waeCWCvZeeIOsZotM7aAopE3Zqsk/J82GcdjEBYrEhq9ZQF5D19WN0j/jMXMQ6G6r3jVJOOpijBHnfY6LGdxF0lfCv5ztN4itCl5y0KcZkmT8zc2urcym0jTjOMEG6daQ4qT4siLeRc859obV2+1upioWG12N6KJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ec0MUIkNeP53RpMFp44TreMV7Pj0N8NnHzE1flghV+4=;
 b=osM2T3trL5GjJE5KfndllzjVJduPyvKuJbUhphX/VWEft6tqNczN5OZYUlk1G+IbULXrb62S/Sfm6jeeCJTadwboP4Lb7LfFlG6oenc4fAxbfg+ElkGCeTFULANke8PsToKZBvWRxnL9AoCnSWxQpdCvXgk5CcF4N4z+5WPnz1Y=
Received: from DM6PR02CA0129.namprd02.prod.outlook.com (2603:10b6:5:1b4::31)
 by BYAPR07MB5319.namprd07.prod.outlook.com (2603:10b6:a03:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Mon, 6 Apr
 2020 13:13:49 +0000
Received: from DM6NAM12FT049.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::9f) by DM6PR02CA0129.outlook.office365.com
 (2603:10b6:5:1b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Mon, 6 Apr 2020 13:13:49 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT049.mail.protection.outlook.com (10.13.178.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.9 via Frontend Transport; Mon, 6 Apr 2020 13:13:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 036DDiTe018857
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 6 Apr 2020 06:13:47 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 6 Apr 2020 15:13:44 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 6 Apr 2020 15:13:44 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 036DDiJw001342;
        Mon, 6 Apr 2020 15:13:44 +0200
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 036DDiYH001341;
        Mon, 6 Apr 2020 15:13:44 +0200
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: [PATCH v3 2/2] EDAC/Cadence:Add EDAC driver for cadence memory controller
Date:   Mon, 6 Apr 2020 15:13:41 +0200
Message-ID: <20200406131341.1253-3-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200406131341.1253-1-dkangude@cadence.com>
References: <20200406131341.1253-1-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.cadence.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(36092001)(46966005)(426003)(336012)(86362001)(8676002)(26826003)(2616005)(186003)(30864003)(47076004)(36756003)(107886003)(36906005)(1076003)(42186006)(4326008)(478600001)(54906003)(2906002)(316002)(5660300002)(82740400003)(356004)(6666004)(6916009)(70586007)(70206006)(26005)(8936002)(7636002)(246002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fc76ac6-32b6-47f8-891a-08d7da2c5853
X-MS-TrafficTypeDiagnostic: BYAPR07MB5319:
X-Microsoft-Antispam-PRVS: <BYAPR07MB53198BE99F2D7BD020350C74CDC20@BYAPR07MB5319.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-Forefront-PRVS: 0365C0E14B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOqqxwWd97LLi4Podm3O9RmMfzonyI3zUzKLU7BnhZHt9ygX0ibgX92FtVKkT0EroaQQzzLVqaURGnXRARZosz6UwDJ1qq6A2ctAieIlUE5AvLDiLHjDGf2tfcVQmk4FV4Is/KyHjzU+woT/JjKACgTm0BxCzkOAjfOBI39Ip+bAmZQCDbB9FGM8Gr1HpH+byRLOVUXtCskLCnuIDJqasL91ZLtrICD0Yn4xLmRdvELj0y2JF0KCTQl7D908MQwdqAyEMx3bLJqlLNAfIVmeNvllrcHcp6hpmDKyP7sdPeFmbTUKgn4Ey547fVpJZNrLhYiCT6wprP+4GXp1OHPingIoF2aFBBCrUEgEXunHpAlSfDGEqGYPPd63g+nThsMmPPTdyQwGZyR56O3ytaw3nZoSYUimc3fSPfCzrwOOwMw6kceFHv7sWxw2OY/flWGVt54b70Dzd5ZO6UqAwevm1VeIJo/+AnvIijTj3RDR/VaQnmcyu9e1MhF/5XIO/te7+lnPlqsp4jXB36yO2FqCnCAQ8s8YTUksnvLMcjnUdsY=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 13:13:48.9891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc76ac6-32b6-47f8-891a-08d7da2c5853
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5319
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_07:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 suspectscore=3 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060112
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Added edac platform driver for Cadence DDR controller which
notify the ecc events based on the single or double bit errors
during memory operations.

Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
---
 drivers/edac/Kconfig        |    8 +
 drivers/edac/cadence_edac.c |  641 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 649 insertions(+), 0 deletions(-)
 create mode 100644 drivers/edac/cadence_edac.c

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index fe2eb89..d5bb399 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -530,4 +530,12 @@ config EDAC_DMC520
 	  Support for error detection and correction on the
 	  SoCs with ARM DMC-520 DRAM controller.
 
+config EDAC_CADENCE
+	tristate "Candence DDR Memory Controller ECC"
+	depends on ARM
+	help
+	  Support for error detection and correction on the Cadence DDR
+	  memory controller. The driver reports correctable and uncorrectable
+	  memory errors.
+
 endif # EDAC
diff --git a/drivers/edac/cadence_edac.c b/drivers/edac/cadence_edac.c
new file mode 100644
index 0000000..3aecc9a
--- /dev/null
+++ b/drivers/edac/cadence_edac.c
@@ -0,0 +1,641 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence DDR4-ECC EDAC Driver.
+ *
+ * Copyright (C) 2019-2020 Cadence Design Systems.
+ *
+ * Authors: Dhananjay Kangude <dkangude@cadence.com>,
+ */
+
+#include <linux/init.h>
+#include <linux/edac.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/delay.h>
+#include "edac_module.h"
+
+#define CDNS_EDAC_MOD_NAME "cadence-edac"
+#define FORCED_ECC_ERR_EVENT_SUPPORT	BIT(1)
+
+/* Granularity of reported error in bytes */
+#define CDNS_EDAC_ERR_GRAIN		1
+
+#define MEM_TYPE_DDR4			0xA
+/* CDNS DDR4 Controller Registers */
+#define DDR_CTL_MEM_TYPE_REG		0x000
+#define DDR_CTL_MEM_WIDTH_REG		0x00c
+#define DDR_CTL_CONTROLLER_BUSY		0x2f0
+
+/* ECC Controller Registers */
+#define ECC_CTL_CONTROL_0_REG		0x254
+#define ECC_CTL_CONTROL_1_REG		0x258
+
+#define ECC_CTL_SCRUB_CONTROL_0		0x280
+#define ECC_CTL_SCRUB_CONTROL_1		0x284
+#define ECC_CTL_SCRUB_CONTROL_2		0x288
+#define ECC_CTL_SCRUB_START_ADDR_L	0x28c
+#define ECC_CTL_SCRUB_START_ADDR_H	0x290
+#define ECC_CTL_SCRUB_END_ADDR_L	0x294
+#define ECC_CTL_SCRUB_END_ADDR_H	0x298
+
+#define ECC_SIG_ECC_C_ADDR_L		0x26c
+#define ECC_SIG_ECC_C_ADDR_H		0x270
+#define ECC_SIG_ECC_C_DATA_L		0x274
+#define ECC_SIG_ECC_C_DATA_H		0x278
+#define ECC_SIG_ECC_C_ID		0x27c
+#define ECC_SIG_ECC_C_SYND		0x270
+#define ECC_SIG_ECC_U_ADDR_L		0x25c
+#define ECC_SIG_ECC_U_ADDR_H		0x25c
+#define ECC_SIG_ECC_U_DATA_L		0x264
+#define ECC_SIG_ECC_U_DATA_H		0x268
+#define ECC_SIG_ECC_U_ID		0x27c
+#define ECC_SIG_ECC_U_SYND		0x260
+
+#define ECC_CTL_INT_STATUS		0x310
+#define ECC_CTL_INT_ACK			0x330
+#define ECC_CTL_INT_MASK		0x350
+
+/* ECC Scrub Macros */
+#define ECC_SCRUB_IN_PROGRESS		BIT(8)
+#define ECC_SCRUB_MODE			BIT(0)
+#define ECC_SCRUB_START			BIT(0)
+#define ECC_SCRUB_LEN_SHIFT		(16)
+#define ECC_SCRUB_IDLE_CNT		GENMASK(15, 0)
+#define ECC_SCRUB_LEN			GENMASK(27, 16)
+#define ECC_CTL_SCRUB_ADDR_L_MASK	GENMASK(31, 0)
+#define ECC_CTL_SCRUB_ADDR_H_MASK	GENMASK(1, 0)
+
+/* Control register width definitions */
+#define WDTH_16				(2)
+#define WDTH_32				(1)
+#define WDTH_64				(0)
+#define CTL_REG_WIDTH_SHIFT		(32)
+#define USER_WORD_SPLIT_WIDTH		(8)
+#define CTL_CONTROLLER_BUSY_FLAG	BIT(16)
+#define CTL_MEM_MAX_WIDTH_MASK		GENMASK(4, 0)
+
+/* ECC Control Macros */
+#define ECC_CTL_FORCE_WC		BIT(16)
+#define ECC_CTL_AUTO_CURRUPT_DISABLE	BIT(16)
+#define ECC_CTL_AUTO_WRITEBACK_EN	BIT(24)
+#define ECC_CTL_ECC_ENABLE		GENMASK(9, 8)
+#define ECC_CTL_MTYPE_MASK		GENMASK(11, 8)
+#define ECC_CTL_XOR_BITS_MASK		GENMASK(15, 0)
+
+/* ECC Status Macros */
+
+/* ECC IRQ Macros */
+#define ECC_INT_CE_EVENT		BIT(0)
+#define ECC_INT_SECOND_CE_EVENT		BIT(1)
+#define ECC_INT_UE_EVENT		BIT(2)
+#define ECC_INT_SECOND_UE_EVENT		BIT(3)
+#define ECC_INT_WRITEBACK_UNHANDLED	BIT(6)
+#define ECC_INT_SCRUB_DONE		BIT(7)
+#define ECC_INT_SCRUB_CE_EVENT		BIT(8)
+#define ECC_INT_MASK_ALL_H		BIT(8)
+#define ECC_INT_CE_UE_MASK		GENMASK(3, 0)
+#define ECC_CE_INTR_MASK		GENMASK(1, 0)
+#define ECC_UE_INTR_MASK		GENMASK(3, 2)
+#define ECC_CTL_INT_ENABLE_MASK		GENMASK(15, 0)
+/* ECC Signature Macros */
+#define ECC_SIG_ECC_C_ID_SHIFT		8
+#define ECC_SIG_ECC_C_SYND_SHIFT	8
+#define ECC_SIG_ECC_C_ADDR_H_MASK	GENMASK(1, 0)
+#define ECC_SIG_ECC_C_ID_MASK		GENMASK(31, 16)
+#define ECC_SIG_ECC_C_SYND_MASK		GENMASK(15, 8)
+
+#define ECC_SIG_ECC_U_ID_SHIFT		0
+#define ECC_SIG_ECC_U_SYND_SHIFT	8
+#define ECC_SIG_ECC_U_ADDR_H_MASK	GENMASK(1, 0)
+#define ECC_SIG_ECC_U_ID_MASK		GENMASK(15, 0)
+#define ECC_SIG_ECC_U_SYND_MASK		GENMASK(15, 8)
+
+/* Syndrome values */
+#define ECC_DOUBLE_MULTI_ERR_SYND	0x03
+
+static char data_synd[] = {
+			0xf4, 0xf1, 0xec, 0xea, 0xe9, 0xe6, 0xe5, 0xe3,
+			0xdc, 0xda, 0xd9, 0xd6, 0xd5, 0xd3, 0xce, 0xcb,
+			0xb5, 0xb0, 0xad, 0xab, 0xa8, 0xa7, 0xa4, 0xa2,
+			0x9d, 0x9b, 0x98, 0x97, 0x94, 0x92, 0x8f, 0x8a,
+			0x75, 0x70, 0x6d, 0x6b, 0x68, 0x67, 0x64, 0x62,
+			0x5e, 0x5b, 0x58, 0x57, 0x54, 0x52, 0x4f, 0x4a,
+			0x34, 0x31, 0x2c, 0x2a, 0x29, 0x26, 0x25, 0x23,
+			0x1c, 0x1a, 0x19, 0x16, 0x15, 0x13, 0x0e, 0x0b
+		  };
+
+static char check_synd[] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};
+
+/**
+ * struct cdns_platform_data -  cadence platform data structure.
+ * @ip_features:	To differentiate IP features.
+ */
+struct cdns_platform_data {
+	int ip_features;
+};
+
+/**
+ * struct priv_data - edac device private instance data.
+ * @reg:	        Base address of the DDR controller.
+ * @ce_cnt:             Correctable Error count.
+ * @ue_cnt:             Uncorrectable Error count.
+ */
+struct priv_data {
+	void __iomem *reg;
+	u32 ce_cnt;
+	u32 ue_cnt;
+#ifdef CONFIG_EDAC_DEBUG
+	struct cdns_platform_data *p;
+#endif
+};
+
+/**
+ * init_mem_layout -  Set address Map as per the mc design.
+ * @mci:   memory controller information.
+ *
+ * Set Address Map as per mc instance .
+ *
+ * Return: none.
+ */
+static void init_mem_layout(struct mem_ctl_info *mci)
+{
+	struct priv_data *priv = mci->pvt_info;
+	struct csrow_info *csi;
+	struct dimm_info *dimm;
+	struct sysinfo inf;
+	enum mem_type mtype;
+	u32 val, width;
+	u32 size, row;
+	u8 j;
+
+	dimm = edac_get_dimm(mci, 0, 0, 0);
+	if (!dimm) {
+		si_meminfo(&inf);
+		for (row = 0; row < mci->nr_csrows; row++) {
+			csi = mci->csrows[row];
+			size = inf.totalram * inf.mem_unit;
+
+			for (j = 0; j < csi->nr_channels; j++) {
+				dimm            = csi->channels[j]->dimm;
+				dimm->edac_mode = EDAC_FLAG_SECDED;
+				/* Get memory type by reading hw registers*/
+				val = readl(priv->reg + DDR_CTL_MEM_TYPE_REG);
+				mtype = val & ECC_CTL_MTYPE_MASK;
+
+				if (mtype == MEM_TYPE_DDR4)
+					dimm->mtype = MEM_DDR4;
+				else
+					dimm->mtype = MEM_EMPTY;
+
+				/*Get EDAC devtype width for the current mc*/
+				width = readl(priv->reg + DDR_CTL_MEM_WIDTH_REG)
+					      & CTL_MEM_MAX_WIDTH_MASK;
+				switch (width) {
+				case WDTH_16:
+					dimm->dtype  = DEV_X2;
+					break;
+				case WDTH_32:
+					dimm->dtype  = DEV_X4;
+					break;
+				case WDTH_64:
+					dimm->dtype  = DEV_X8;
+					break;
+				default:
+					dimm->dtype = DEV_UNKNOWN;
+				}
+
+				dimm->nr_pages  = (size >> PAGE_SHIFT) /
+					csi->nr_channels;
+				dimm->grain     = CDNS_EDAC_ERR_GRAIN;
+			}
+		}
+	}
+}
+
+/**
+ * handle_ce - Handle corrected errors and notify to
+ *             edac layer by reading appropriate hw registers
+ * @mci:   memory controller information.
+ * Return: void.
+ */
+static void handle_ce(struct mem_ctl_info *mci)
+{
+	struct priv_data *priv;
+	u64 err_c_addr = 0x0;
+	u64 err_c_data = 0x0;
+	u32 err_c_synd, err_c_id;
+	u32 sig_val_l, sig_val_h;
+
+	priv = mci->pvt_info;
+
+	sig_val_l = readl(priv->reg + ECC_SIG_ECC_C_ADDR_L);
+	sig_val_h = (readl(priv->reg + ECC_SIG_ECC_C_ADDR_H) &
+			ECC_SIG_ECC_C_ADDR_H_MASK);
+	err_c_addr = (((err_c_addr | sig_val_h) <<
+				CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+	sig_val_l = readl(priv->reg + ECC_SIG_ECC_C_DATA_L);
+	sig_val_h = readl(priv->reg + ECC_SIG_ECC_C_DATA_H);
+	err_c_data = (((err_c_data | sig_val_h) <<
+				CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+	err_c_id = ((readl(priv->reg + ECC_SIG_ECC_C_ID) &
+				ECC_SIG_ECC_C_ID_MASK) >>
+			ECC_SIG_ECC_C_ID_SHIFT);
+
+	err_c_synd = ((readl(priv->reg + ECC_SIG_ECC_C_SYND) &
+				ECC_SIG_ECC_C_SYND_MASK) >>
+			ECC_SIG_ECC_C_SYND_SHIFT);
+
+	priv->ce_cnt = priv->ce_cnt + 1;
+
+	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+			     1,
+			     err_c_addr >> PAGE_SHIFT,
+			     err_c_addr & ~PAGE_MASK,
+			     err_c_synd, 0, 0, -1,
+			     mci->ctl_name, "");
+}
+
+/**
+ * handle_ue -	Handle uncorrected errors and notify to
+ *		edac layer by reading appropriate hw registers
+ * @mci:   memory controller information.
+ * Return: void.
+ */
+static void handle_ue(struct mem_ctl_info *mci)
+{
+	struct priv_data *priv;
+	u64 err_u_addr = 0x0;
+	u64 err_u_data = 0x0;
+	u32 err_u_synd, err_u_id;
+	u32 sig_val_l, sig_val_h;
+
+	priv = mci->pvt_info;
+	sig_val_l = readl(priv->reg + ECC_SIG_ECC_U_ADDR_L);
+	sig_val_h = (readl(priv->reg + ECC_SIG_ECC_U_ADDR_H) &
+			ECC_SIG_ECC_U_ADDR_H_MASK);
+	err_u_addr = (((err_u_addr | sig_val_h) <<
+				CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+	sig_val_l = readl(priv->reg + ECC_SIG_ECC_U_DATA_L);
+	sig_val_h = readl(priv->reg + ECC_SIG_ECC_U_DATA_H);
+	err_u_data = (((err_u_data | sig_val_h) <<
+				CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+	err_u_id = ((readl(priv->reg + ECC_SIG_ECC_U_ID) &
+				ECC_SIG_ECC_U_ID_MASK) >>
+			ECC_SIG_ECC_U_ID_SHIFT);
+
+	err_u_synd = ((readl(priv->reg + ECC_SIG_ECC_U_SYND) &
+				ECC_SIG_ECC_U_SYND_MASK) >>
+			ECC_SIG_ECC_U_SYND_SHIFT);
+	priv->ue_cnt = priv->ue_cnt + 1;
+
+	edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+			     1,
+			     err_u_addr >> PAGE_SHIFT,
+			     err_u_addr & ~PAGE_MASK,
+			     err_u_synd, 0, 0, -1,
+			     mci->ctl_name, "");
+}
+
+/**
+ * edac_ecc_isr - Interrupt Handler for ECC interrupts.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
+ */
+static irqreturn_t edac_ecc_isr(int irq, void *dev_id)
+{
+	struct mem_ctl_info *mci = dev_id;
+	struct priv_data *priv;
+	u32 intr_status;
+	u32 val;
+
+	priv = mci->pvt_info;
+
+	/* Check the intr status and confirm ECC error intr */
+	intr_status = readl(priv->reg + ECC_CTL_INT_STATUS);
+
+	edac_dbg(3, "InterruptStatus : 0x%x\n", intr_status);
+	val = intr_status & (ECC_INT_CE_UE_MASK);
+	if (!((val & ECC_CE_INTR_MASK) || (val & ECC_UE_INTR_MASK)))
+		return IRQ_NONE;
+
+	if (val & ECC_CE_INTR_MASK) {
+		handle_ce(mci);
+
+		/* Clear the interrupt source */
+		if (val & ECC_INT_CE_EVENT)
+			writel(ECC_INT_CE_EVENT, priv->reg + ECC_CTL_INT_ACK);
+		else if (val & ECC_INT_SECOND_CE_EVENT)
+			writel(ECC_INT_SECOND_CE_EVENT,
+			       priv->reg + ECC_CTL_INT_ACK);
+		else
+			edac_printk(KERN_ERR, EDAC_MC, "Failed to clear IRQ\n");
+	}
+
+	if (val & ECC_UE_INTR_MASK) {
+		handle_ue(mci);
+
+		/* Clear the interrupt source */
+		if (val & ECC_INT_UE_EVENT)
+			writel(ECC_INT_UE_EVENT, priv->reg + ECC_CTL_INT_ACK);
+		else if (val & ECC_INT_SECOND_UE_EVENT)
+			writel(ECC_INT_SECOND_UE_EVENT,
+			       priv->reg + ECC_CTL_INT_ACK);
+		else
+			edac_printk(KERN_ERR, EDAC_MC, "Failed to clear IRQ\n");
+	}
+
+	edac_dbg(3, "Total error count CE %d UE %d\n",
+		 priv->ce_cnt, priv->ue_cnt);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_EDAC_DEBUG
+/**
+ * forced_ecc_error_show/store - Sysfs atrribute functions.
+ * @dev: Pointer to device structure.
+ * @mattr: Pointer to device attributes.
+ * @data : Data send by User space and stored in file.
+ * Return: as SUCCESS,Total number of characters written otherwise
+ *         negative value.
+ */
+static ssize_t forced_ecc_error_show(struct device *dev,
+				     struct device_attribute *mattr,
+				     char *data)
+{
+	return sprintf(data, "CDNS-DDR4 Force Injection Help:\n"
+		       "CE/UE: Corrected/Uncorrected\n"
+		       "checkcode/data:source\n"
+		       "user_word [0-1]:subpart of data\n"
+		       "bit [0-31]:bit number\n");
+}
+
+static ssize_t forced_ecc_error_store(struct device *dev,
+				      struct device_attribute *mattr,
+				      const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct priv_data *priv = mci->pvt_info;
+	int	args_cnt;
+	int	ret;
+	char	**args;
+	u32	regval;
+	u8	user_word;
+	u8	bit_no;
+
+	/* Split string buffer into separate parameters */
+	args = argv_split(GFP_KERNEL, data, &args_cnt);
+
+	ret = kstrtou8(args[2], 0, &user_word);
+	if (ret)
+		return ret;
+
+	ret = kstrtou8(args[3], 0, &bit_no);
+	if (ret)
+		return ret;
+
+	/* Check ecc enabled */
+	if (!readl(priv->reg + ECC_CTL_CONTROL_0_REG) & ECC_CTL_ECC_ENABLE)
+		return count;
+
+	/* Check no write operation pending to controller*/
+	while (readl(priv->reg + DDR_CTL_CONTROLLER_BUSY) &
+			CTL_CONTROLLER_BUSY_FLAG) {
+		usleep_range(1000, 10000);
+	}
+
+	/* Write appropriate syndrome to xor_check_bit*/
+	if (!strcmp(args[0], "CE")) {
+		if (!strcmp(args[1], "checkcode")) {
+			regval = readl(priv->reg + ECC_CTL_CONTROL_1_REG);
+			regval = (regval & ~(ECC_CTL_XOR_BITS_MASK)) |
+				(check_synd[bit_no] <<
+				 (USER_WORD_SPLIT_WIDTH * user_word));
+			writel(regval, priv->reg + ECC_CTL_CONTROL_1_REG);
+		} else if (!strcmp(args[1], "data")) {
+			regval = readl(priv->reg + ECC_CTL_CONTROL_1_REG);
+			regval = (regval & ~(ECC_CTL_XOR_BITS_MASK)) |
+				(data_synd[bit_no] <<
+				 (USER_WORD_SPLIT_WIDTH * user_word));
+			writel(regval, priv->reg + ECC_CTL_CONTROL_1_REG);
+		}
+		/* Enable the ECC writeback_en for corrected error */
+		regval = readl(priv->reg + ECC_CTL_CONTROL_1_REG);
+		writel((regval | ECC_CTL_AUTO_WRITEBACK_EN),
+		       priv->reg + ECC_CTL_CONTROL_1_REG);
+	} else if (!strcmp(args[0], "UE")) {
+		writel(ECC_DOUBLE_MULTI_ERR_SYND,
+		       priv->reg + ECC_CTL_CONTROL_1_REG);
+	}
+
+	/* Assert fwc */
+	writel((ECC_CTL_FORCE_WC | readl(priv->reg + ECC_CTL_CONTROL_0_REG)),
+	       priv->reg + ECC_CTL_CONTROL_0_REG);
+	return count;
+}
+
+static DEVICE_ATTR_RW(forced_ecc_error);
+static int create_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	int rc;
+
+	rc = device_create_file(&mci->dev, &dev_attr_forced_ecc_error);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+static void remove_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	device_remove_file(&mci->dev, &dev_attr_forced_ecc_error);
+}
+
+#endif
+
+static const struct cdns_platform_data cdns_edac = {
+#ifdef CONFIG_EDAC_DEBUG
+	.ip_features = FORCED_ECC_ERR_EVENT_SUPPORT,
+#endif
+};
+
+static const struct of_device_id cdns_edac_of_match[] = {
+	{ .compatible = "cdns,ddr4-mc-edac", .data = &cdns_edac },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, cdns_edac_of_match);
+
+/**
+ * cdns_edac_mc_probe - bind cdns mc controller driver to framework.
+ * @pdev:  platform device.
+ *
+ * Probe a memory controller for binding with the driver.
+ *
+ * Return: 0 if binding of the controller instance is successful;
+ * otherwise, < 0 on error.
+ */
+static int cdns_edac_mc_probe(struct platform_device *pdev)
+{
+#ifdef CONFIG_EDAC_DEBUG
+	const struct cdns_platform_data *p;
+#endif
+	struct device *dev = &pdev->dev;
+	struct edac_mc_layer layers[1];
+	const struct of_device_id *id;
+	struct priv_data *priv_data;
+	struct mem_ctl_info *mci;
+	struct resource *res;
+	void __iomem *reg;
+	int ret = -ENODEV;
+	int irq;
+
+	id = of_match_device(cdns_edac_of_match, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+#ifdef CONFIG_EDAC_DEBUG
+	p = of_device_get_match_data(&pdev->dev);
+	if (!p)
+		return -ENODEV;
+#endif
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg = devm_ioremap_resource(dev, res);
+	if (IS_ERR(reg)) {
+		edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
+			    "cdns DDR4 mc regs are not defined\n");
+		return PTR_ERR(reg);
+	}
+
+	edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
+		    "IO mapped reg addr: %p\n", reg);
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = 1;
+	layers[0].is_virt_csrow = true;
+
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
+			    sizeof(struct priv_data));
+	if (!mci) {
+		edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
+			    "Failed memory allocation for mc instance\n");
+		return -ENOMEM;
+	}
+	mci->pdev = &pdev->dev;
+	priv_data = mci->pvt_info;
+	priv_data->reg = reg;
+	priv_data->ce_cnt = 0;
+	priv_data->ue_cnt = 0;
+	platform_set_drvdata(pdev, mci);
+	/* Initialize controller capabilities */
+	mci->mtype_cap = MEM_FLAG_DDR4;
+	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
+	mci->scrub_cap = SCRUB_UNKNOWN;
+	mci->scrub_mode = SCRUB_HW_PROG;
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->ctl_name = id->compatible;
+	mci->dev_name = dev_name(&pdev->dev);
+	mci->mod_name = CDNS_EDAC_MOD_NAME;
+	mci->ctl_page_to_phys = NULL;
+
+	/* Interrupt feature is supported by cadence mc */
+	edac_op_state = EDAC_OPSTATE_INT;
+	init_mem_layout(mci);
+
+	/* Setup Interrupt handler for ECC */
+	irq = platform_get_irq(pdev, 0);
+	if (!irq) {
+		edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
+			    "irq number not defined for ECC.\n");
+		goto err;
+	}
+	ret = devm_request_irq(dev, irq, edac_ecc_isr, 0,
+			       "cdns-edac-mc-ecc-irq", mci);
+	if (ret) {
+		edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
+			    "request_irq fail for CDNS_EDAC irq\n");
+		goto err;
+	}
+	ret = edac_mc_add_mc(mci);
+	if (ret) {
+		edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
+			    "Failed to register with EDAC core\n");
+		goto err;
+	}
+
+#ifdef CONFIG_EDAC_DEBUG
+	if (p->ip_features & FORCED_ECC_ERR_EVENT_SUPPORT) {
+		if (create_sysfs_attributes(mci)) {
+			edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
+				    "Failed to create sysfs entries\n");
+			goto err1;
+		}
+	}
+#endif
+	/* Enable & set CE/UE Interrupts for DDR4 Controller */
+	writel((unsigned int)(~(ECC_CTL_INT_ENABLE_MASK)),
+	       priv_data->reg + ECC_CTL_INT_MASK);
+
+	/* Start capturing the correctable and uncorrectable errors.
+	 * Write 1 to enable.
+	 */
+	writel(ECC_CTL_ECC_ENABLE, priv_data->reg + ECC_CTL_CONTROL_0_REG);
+	return 0;
+
+err1:
+	edac_mc_del_mc(&pdev->dev);
+
+err:
+	edac_mc_free(mci);
+	return ret;
+}
+
+/**
+ * cdns_edac_mc_remove - Unbind driver from controller.
+ * @pdev:  Platform device.
+ *
+ * Return: 0
+ */
+static int cdns_edac_mc_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct priv_data *priv = mci->pvt_info;
+
+	/* Disable All ECC Interrupts for DDR4 Controller */
+	writel(ECC_CTL_INT_ENABLE_MASK, priv->reg + ECC_CTL_INT_MASK);
+
+	/* Disable ecc feature before removing driver by writing 0 */
+	writel((unsigned int)(~(ECC_CTL_ECC_ENABLE)),
+	       priv->reg + ECC_CTL_CONTROL_0_REG);
+
+#ifdef CONFIG_EDAC_DEBUG
+	remove_sysfs_attributes(mci);
+#endif
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+
+	return 0;
+}
+
+static struct platform_driver cdns_edac_mc_driver = {
+	.driver = {
+		   .name = "cadence-edac",
+		   .of_match_table = cdns_edac_of_match,
+	},
+	.probe = cdns_edac_mc_probe,
+	.remove = cdns_edac_mc_remove,
+};
+
+module_platform_driver(cdns_edac_mc_driver);
+
+MODULE_AUTHOR("Cadence");
+MODULE_DESCRIPTION("Cadence DDR4 Controller ECC driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.1

