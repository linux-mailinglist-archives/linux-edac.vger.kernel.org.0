Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28FE316BD72
	for <lists+linux-edac@lfdr.de>; Tue, 25 Feb 2020 10:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgBYJjZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Feb 2020 04:39:25 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:12760 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729455AbgBYJjY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 Feb 2020 04:39:24 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01P9Xlqo023693;
        Tue, 25 Feb 2020 01:39:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=+XzroECOlFHPO4YOMUy8+4qKkxIyCANz7cotinRcLxE=;
 b=ZHQ+IR1fjlZpJeRr63HAoWWD+/d/WT6EP0lCpejg68srzlC3s55+IXmXIWechzsrMnYD
 fIZ1aPluIlKAj4ait+zWmT8U12CwH3G7lnU9q80aXdHnCICFiZfILKC8Gp1bqbOG+nqn
 tMJDYLE8GAVDgObiJbhXp8/LKEhJteliE+6Ochn/giYedeXKRNnChHZQYP60bf14CU6I
 RTn3mtb+bWpefToxxFMGHl0yIG34v5TccaXqcTytt9AxgB4iC4kb4WltYpOkQJOBwAR0
 znt1W6WyTrZ0U8HmCWRNSRNkXwDEGZYqtE9Lm0OYQGY76Zd+LIjQpVZ/JNW+gi9ifZgl IA== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2059.outbound.protection.outlook.com [104.47.44.59])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2yb0s3tx3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 01:39:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzMDM5+H4YWIilIAVBiA0hMhpwJIg7uyt+p2sWeORWrSe+PRMLBqE6KIHfDRw37m0rEmgIoo1zcBWGqk3mk27ddXWo+8r8zvdCTw5xNhtfZ3I0V0kyS/1CipP4sGoci+cuke4pqFut7k4BvpKp8wCesXXotXqQrwg15b/J6AeGUaSIoDVTO0fBPOs2TKy7A3Q+frXz/HSGUgvVn1ETYi2npN6TGwHs4J4ok2/yVu6yA+OkSI73MCEIVKi1eaMFB/fAe8Ld0xKgQDli2ir/jGWub3vDLYiVHask7fzHWqo3d2K42vXJdIYFeXRKnvQsRER3Kiu8z3hx5ZyAG5ud6Z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XzroECOlFHPO4YOMUy8+4qKkxIyCANz7cotinRcLxE=;
 b=RAs/6gk7d7xBGWRfVhu8TCdk/pU5aZd0SOOsqodMmvpfoctlcWrA1w+bsypvt7iy29yqb2rAHuHqjC0bl6nR8lvI0rMXVN258VheELoHTmqPA8oXML5q1Z54xmWohFgvq69qJGx6X4VmOmxwxgAoACKp84WUOtDLpYBANoWXPjzFUZkoPvpO12kf9f9OLCprxMx75ddbuREQ+Sa/S/IW9xUft2AgSGZUio6nQLOKiI+H9om+hK28kFoJkgN2O49IR1mstOwXTYCDeBDSYIFyXDr1/KzvDbrG+odofHPLAq0E/vjMhN9g8t8Exl1q2oIPaXI6ep01lFnZHx255B+7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XzroECOlFHPO4YOMUy8+4qKkxIyCANz7cotinRcLxE=;
 b=thTClq6Vk0uZrXYxL9KVVBF3vtHljwSIxPQ7pCSWC39KTUmta+FgdsG/mWPBjziyS0NcrpGOjDZdXpycPGnSwdW/OrcMX1A85ISyi3Br/bnRvLJ+Wtl3DgQV0a30rORDAUgCSoHSx5DaPIi4YWlMEv43l/MecuMH7+Xr6rc/5mY=
Received: from DM6PR11CA0070.namprd11.prod.outlook.com (2603:10b6:5:14c::47)
 by DM6PR07MB5242.namprd07.prod.outlook.com (2603:10b6:5:2c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 09:39:07 +0000
Received: from DM6NAM12FT005.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::a3) by DM6PR11CA0070.outlook.office365.com
 (2603:10b6:5:14c::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Tue, 25 Feb 2020 09:39:07 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 DM6NAM12FT005.mail.protection.outlook.com (10.13.178.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.6 via Frontend Transport; Tue, 25 Feb 2020 09:39:05 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 01P9d2qR127657
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 01:39:03 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 25 Feb 2020 10:39:01 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 25 Feb 2020 10:39:01 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 01P9d1uH007383;
        Tue, 25 Feb 2020 10:39:01 +0100
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 01P9d14t007382;
        Tue, 25 Feb 2020 10:39:01 +0100
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: [PATCH 1/2] EDAC/Cadence:Add EDAC driver for cadence memory controller
Date:   Tue, 25 Feb 2020 10:38:55 +0100
Message-ID: <20200225093856.7328-2-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200225093856.7328-1-dkangude@cadence.com>
References: <20200225093856.7328-1-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(36092001)(189003)(199004)(6666004)(186003)(81166006)(356004)(1076003)(4326008)(70206006)(107886003)(36906005)(8936002)(86362001)(26005)(2616005)(478600001)(81156014)(30864003)(426003)(5660300002)(2906002)(6916009)(8676002)(54906003)(36756003)(42186006)(70586007)(336012)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5242;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02542b0d-db5e-44e4-7b5f-08d7b9d68e3a
X-MS-TrafficTypeDiagnostic: DM6PR07MB5242:
X-Microsoft-Antispam-PRVS: <DM6PR07MB5242D129F3D44836C5516246CDED0@DM6PR07MB5242.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-Forefront-PRVS: 0324C2C0E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OhXP7LM0PPGais0Jlrjnfk3vsvqb8QbpjDC1DKmmS0UJojFao66Xijm39tpCkUqEy7pqTmcdVU4Jqy9limDGpcnCdbrLpTaFhYKyA+cAlYPt0HIvQQ29NMvL0/uEHzoEAlO1V4MhXXCxScaP2AECmT6+yB+drOg+xxx48hs0DvLyvdIr2aq3EJVtRTeV9a0TBS2EDC53ktfGOZkn0tCfea3mc7B8iW9whemggmTbWTtKU73wrhUzHHqN9rkCRDN2blBlqkB4cLaD7k9V5AMNr5yb5imiiVHBAEWegAtL7Yn/1cY2MN2nOykoPkyb3Ly5w8kKBBvhDH++FXdbMDuURxyBldw8SmZ+g2lMhDH+fvc9b+Hfl9y9iUOUM73G3YlqYhfmbcRk2SZ9Utranc8lRwgxQ7dakUFhGsIkMsdplENKtpSWeIKNRhZD5ccTs/3L5n0Kp7/0HIHDi9oB/tAetqqtIvMk5crTGpae2USNTIFIkAwd4IdwJz5WrwIRsrwb
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 09:39:05.5452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02542b0d-db5e-44e4-7b5f-08d7b9d68e3a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5242
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_02:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 suspectscore=3 clxscore=1011 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250078
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Added edac platform driver for Cadence DDR controller which
notify the ecc events based on the single or double bit errors
during memory operations.

Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
---
 drivers/edac/Kconfig        |    7 +
 drivers/edac/Makefile       |    1 +
 drivers/edac/cadence_edac.c |  615 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 623 insertions(+), 0 deletions(-)
 create mode 100644 drivers/edac/cadence_edac.c

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index fe2eb89..4bea379 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -530,4 +530,11 @@ config EDAC_DMC520
 	  Support for error detection and correction on the
 	  SoCs with ARM DMC-520 DRAM controller.
 
+config EDAC_CADENCE
+	tristate "Candence DDR Memory Controller ECC"
+	help
+	  Support for error detection and correction on the Cadence DDR
+	  memory controller. The driver provide the statistics  for single bit(CE)
+	  and double bit(UE) error correction.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 269e151..a56cf2e 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
 obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
+obj-$(CONFIG_EDAC_CADENCE)		+= cadence_edac.o
diff --git a/drivers/edac/cadence_edac.c b/drivers/edac/cadence_edac.c
new file mode 100644
index 0000000..3887db5
--- /dev/null
+++ b/drivers/edac/cadence_edac.c
@@ -0,0 +1,615 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence DDR4-ECC EDAC Driver.
+ *
+ * * Copyright (C) 2018-2019 Cadence Design Systems.
+ *
+ * * Authors: Dhananjay Kangude <dkangude@cadence.com>,
+ */
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
+#define FORCED_ECC_ERR_EVENT_SUPPORT	1
+/* Number of cs_rows needed per memory controller */
+#define CDNS_EDAC_NR_CSROWS		2
+
+/* Number of channels per memory controller */
+#define CDNS_EDAC_NR_CHANS		1
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
+#define ECC_CTL_INT_STATUS_L		0x310
+#define ECC_CTL_INT_ACK_L		0x330
+#define ECC_CTL_INT_MASK_0_L		0x350
+
+/*ECC Scrub Macros */
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
+char data_synd[] = {
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
+char check_synd[] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};
+
+/**
+ * struct cdns_platform_data -  cadence platform data structure.
+ * @quirks:             To differentiate IP features.
+ */
+struct cdns_platform_data {
+	int quirks;
+};
+
+/**
+ * struct cdns_edac_priv_data - edac device private instance data.
+ * @reg:	        Base address of the DDR controller.
+ * @ce_cnt:             Correctable Error count.
+ * @ue_cnt:             Uncorrectable Error count.
+ */
+struct cdns_edac_priv_data {
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
+	struct cdns_edac_priv_data *priv = mci->pvt_info;
+	struct csrow_info *csi;
+	struct dimm_info *dimm;
+	struct sysinfo inf;
+	enum mem_type mtype;
+	u32 val, width;
+	u32 size, row;
+	u8 j;
+
+	dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, 0, 0, 0);
+
+	si_meminfo(&inf);
+	for (row = 0; row < mci->nr_csrows; row++) {
+		csi = mci->csrows[row];
+		size = inf.totalram * inf.mem_unit;
+
+		for (j = 0; j < csi->nr_channels; j++) {
+			dimm            = csi->channels[j]->dimm;
+			dimm->edac_mode = EDAC_FLAG_SECDED;
+			/* Get memory type by reading hw registers*/
+			val = readl(priv->reg + DDR_CTL_MEM_TYPE_REG);
+			mtype = val & ECC_CTL_MTYPE_MASK;
+
+			if (mtype == MEM_TYPE_DDR4)
+				dimm->mtype = MEM_DDR4;
+			else
+				dimm->mtype = MEM_EMPTY;
+
+			/*Get EDAC devtype width for the current mc*/
+			width = (readl(priv->reg + DDR_CTL_MEM_WIDTH_REG) &
+				       CTL_MEM_MAX_WIDTH_MASK);
+			switch (width) {
+			case WDTH_16:
+				dimm->dtype  = DEV_X2;
+				break;
+			case WDTH_32:
+				dimm->dtype  = DEV_X4;
+				break;
+			case WDTH_64:
+				dimm->dtype  = DEV_X8;
+				break;
+			default:
+				dimm->dtype = DEV_UNKNOWN;
+			}
+
+			dimm->nr_pages  = (size >> PAGE_SHIFT) /
+					   csi->nr_channels;
+			dimm->grain     = CDNS_EDAC_ERR_GRAIN;
+		}
+	}
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
+	struct cdns_edac_priv_data *priv;
+	u32 intr_status;
+	u32 val;
+	u32 sig_val_l, sig_val_h;
+	u32 err_c_id, err_u_id;
+	u32 err_c_synd, err_u_synd;
+	u64 err_c_addr = 0x0, err_u_addr = 0x0;
+	u64 err_c_data = 0x0, err_u_data = 0x0;
+
+	priv = mci->pvt_info;
+
+	/* Check the intr status and confirm ECC error intr */
+	intr_status = readl(priv->reg + ECC_CTL_INT_STATUS_L);
+
+	edac_dbg(3, "InterruptStatus : 0x%x\n", intr_status);
+	val = intr_status & (ECC_INT_CE_UE_MASK);
+	if (!((val & ECC_CE_INTR_MASK) || (val & ECC_UE_INTR_MASK)))
+		return IRQ_NONE;
+
+	if (val & ECC_CE_INTR_MASK) {
+		sig_val_l = readl(priv->reg + ECC_SIG_ECC_C_ADDR_L);
+		sig_val_h = (readl(priv->reg + ECC_SIG_ECC_C_ADDR_H) &
+			     ECC_SIG_ECC_C_ADDR_H_MASK);
+		err_c_addr = (((err_c_addr | sig_val_h) <<
+				CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+		sig_val_l = readl(priv->reg + ECC_SIG_ECC_C_DATA_L);
+		sig_val_h = readl(priv->reg + ECC_SIG_ECC_C_DATA_H);
+		err_c_data = (((err_c_data | sig_val_h) <<
+				CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+		err_c_id = ((readl(priv->reg + ECC_SIG_ECC_C_ID) &
+			     ECC_SIG_ECC_C_ID_MASK) >>
+			     ECC_SIG_ECC_C_ID_SHIFT);
+
+		err_c_synd = ((readl(priv->reg + ECC_SIG_ECC_C_SYND) &
+			       ECC_SIG_ECC_C_SYND_MASK) >>
+			       ECC_SIG_ECC_C_SYND_SHIFT);
+		priv->ce_cnt = priv->ce_cnt + 1;
+
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+				     1,
+				     err_c_addr >> PAGE_SHIFT,
+				     err_c_addr & ~PAGE_MASK,
+				     err_c_synd, 0, 0, -1,
+				     mci->ctl_name, "");
+
+		/* Clear the interrupt source */
+		if (val & ECC_INT_CE_EVENT)
+			writel(ECC_INT_CE_EVENT, priv->reg + ECC_CTL_INT_ACK_L);
+		else if (val & ECC_INT_SECOND_CE_EVENT)
+			writel(ECC_INT_SECOND_CE_EVENT,
+			       priv->reg + ECC_CTL_INT_ACK_L);
+		else
+			edac_printk(KERN_ERR, EDAC_MC, "Failed to clear IRQ\n");
+	}
+
+	if (val & ECC_UE_INTR_MASK) {
+		sig_val_l = readl(priv->reg + ECC_SIG_ECC_U_ADDR_L);
+		sig_val_h = (readl(priv->reg + ECC_SIG_ECC_U_ADDR_H) &
+			     ECC_SIG_ECC_U_ADDR_H_MASK);
+		err_u_addr = (((err_u_addr | sig_val_h) <<
+				CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+		sig_val_l = readl(priv->reg + ECC_SIG_ECC_U_DATA_L);
+		sig_val_h = readl(priv->reg + ECC_SIG_ECC_U_DATA_H);
+		err_u_data = (((err_u_data | sig_val_h) <<
+				CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+		err_u_id = ((readl(priv->reg + ECC_SIG_ECC_U_ID) &
+			     ECC_SIG_ECC_U_ID_MASK) >>
+			     ECC_SIG_ECC_U_ID_SHIFT);
+
+		err_u_synd = ((readl(priv->reg + ECC_SIG_ECC_U_SYND) &
+			       ECC_SIG_ECC_U_SYND_MASK) >>
+			       ECC_SIG_ECC_U_SYND_SHIFT);
+		priv->ue_cnt = priv->ue_cnt + 1;
+
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+				     1,
+				     err_u_addr >> PAGE_SHIFT,
+				     err_u_addr & ~PAGE_MASK,
+				     err_u_synd, 0, 0, -1,
+				     mci->ctl_name, "");
+
+		/* Clear the interrupt source */
+		if (val & ECC_INT_UE_EVENT)
+			writel(ECC_INT_UE_EVENT, priv->reg + ECC_CTL_INT_ACK_L);
+		else if (val & ECC_INT_SECOND_UE_EVENT)
+			writel(ECC_INT_SECOND_UE_EVENT,
+			       priv->reg + ECC_CTL_INT_ACK_L);
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
+	struct cdns_edac_priv_data *priv = mci->pvt_info;
+	int	args_cnt;
+	int	ret;
+	char	**args;
+	char buf[1000];
+	u32	regval;
+	u8	user_word;
+	u8	bit_no;
+
+	/* Read sysfs params into buffer*/
+	snprintf(buf, min_t(size_t, sizeof(buf) - 1, count), "%s\n", data);
+	/*Split string buffer into separate parameters*/
+	args = argv_split(GFP_KERNEL, buf, &args_cnt);
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
+	if (readl(priv->reg + ECC_CTL_CONTROL_0_REG) & ECC_CTL_ECC_ENABLE) {
+		/* Check no write operation pending to controller*/
+		while (readl(priv->reg + DDR_CTL_CONTROLLER_BUSY) &
+			     CTL_CONTROLLER_BUSY_FLAG) {
+			usleep_range(1000, 10000);
+		}
+		/* Write appropriate syndrome to xor_check_bit*/
+		if (!strcmp(args[0], "CE")) {
+			if (!strcmp(args[1], "checkcode")) {
+				regval = readl(priv->reg +
+					       ECC_CTL_CONTROL_1_REG);
+				regval = (regval & ~(ECC_CTL_XOR_BITS_MASK)) |
+					(check_synd[bit_no] <<
+					(USER_WORD_SPLIT_WIDTH * user_word));
+				writel(regval,
+				       priv->reg + ECC_CTL_CONTROL_1_REG);
+			} else if (!strcmp(args[1], "data")) {
+				regval = readl(priv->reg +
+					       ECC_CTL_CONTROL_1_REG);
+				regval = (regval & ~(ECC_CTL_XOR_BITS_MASK)) |
+					(data_synd[bit_no] <<
+					(USER_WORD_SPLIT_WIDTH * user_word));
+				writel(regval,
+				       priv->reg + ECC_CTL_CONTROL_1_REG);
+			}
+			/* Enable the ECC writeback_en for corrected error */
+			regval = readl(priv->reg + ECC_CTL_CONTROL_1_REG);
+			writel((regval | ECC_CTL_AUTO_WRITEBACK_EN),
+			       priv->reg + ECC_CTL_CONTROL_1_REG);
+		} else if (!strcmp(args[0], "UE")) {
+			writel(ECC_DOUBLE_MULTI_ERR_SYND,
+			       priv->reg + ECC_CTL_CONTROL_1_REG);
+		}
+
+		/* Assert fwc */
+		writel((ECC_CTL_FORCE_WC |
+			readl(priv->reg + ECC_CTL_CONTROL_0_REG)),
+			priv->reg + ECC_CTL_CONTROL_0_REG);
+	}
+	return count;
+}
+
+static DEVICE_ATTR_RW(forced_ecc_error);
+static int edac_create_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	int rc;
+
+	rc = device_create_file(&mci->dev, &dev_attr_forced_ecc_error);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+static void edac_remove_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	device_remove_file(&mci->dev, &dev_attr_forced_ecc_error);
+}
+
+#endif
+
+static const struct cdns_platform_data cdns_edac = {
+#ifdef CONFIG_EDAC_DEBUG
+	.quirks = FORCED_ECC_ERR_EVENT_SUPPORT,
+#endif
+};
+
+static const struct of_device_id cdns_edac_of_match[] = {
+	{ .compatible = "cdns,cadence-ddr4-mc-edac", .data = &cdns_edac },
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
+
+static int cdns_edac_mc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *reg;
+	struct mem_ctl_info *mci;
+	struct edac_mc_layer layers[1];
+	const struct of_device_id *id;
+	struct cdns_edac_priv_data *priv_data;
+	int irq, ret = -ENODEV;
+#ifdef CONFIG_EDAC_DEBUG
+	const struct cdns_platform_data *p;
+	struct dentry *root;
+#endif
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
+			    sizeof(struct cdns_edac_priv_data));
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
+			    "irq number not defined for ecc.\n");
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
+	if (p->quirks && FORCED_ECC_ERR_EVENT_SUPPORT) {
+		if (edac_create_sysfs_attributes(mci)) {
+			edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
+				    "Failed to create sysfs entries\n");
+			goto err;
+		}
+	}
+#endif
+	/* Enable & set CE/UE Interrupts for DDR4 Controller */
+	writel(~(ECC_CTL_INT_ENABLE_MASK),
+	       priv_data->reg + ECC_CTL_INT_MASK_0_L);
+
+	/* Start capturing the correctable and uncorrectable errors.
+	 * Write 1 to enable.
+	 */
+	writel(ECC_CTL_ECC_ENABLE, priv_data->reg + ECC_CTL_CONTROL_0_REG);
+	return 0;
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
+
+static int cdns_edac_mc_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct cdns_edac_priv_data *priv = mci->pvt_info;
+
+	/* Disable All ECC Interrupts for DDR4 Controller */
+	writel(ECC_CTL_INT_ENABLE_MASK, priv->reg + ECC_CTL_INT_MASK_0_L);
+
+	/* Disable ecc feature before removing driver by writing 0.*/
+	writel(~(ECC_CTL_ECC_ENABLE), priv->reg + ECC_CTL_CONTROL_0_REG);
+
+#ifdef CONFIG_EDAC_DEBUG
+	edac_remove_sysfs_attributes(mci);
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

