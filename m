Return-Path: <linux-edac+bounces-1649-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2A3953C2B
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 22:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBCB1C22A0F
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 20:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006E14F9D9;
	Thu, 15 Aug 2024 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o+paYvTT"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295314EC7D;
	Thu, 15 Aug 2024 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755000; cv=fail; b=SWubaq6z1hXFC7lvmcx9W+AIJ3jJqWgdQ8CAUO6HqJzPHqcodTcdntc7aLPvtXqaGKLTVtFTxXcZ2sBvJ08xc3lwGUjlmBvXIh1bi5Jtb2B9ljUnTREuArOrWyX8KTQceKdBJc+tWakTPHw6TKLJ26vdvxLAW7QFYISOrvESd5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755000; c=relaxed/simple;
	bh=PSSL7mAIfmYWSlwXigPTYvsj0Ifc/pAr90nK1p/Tgj4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YWmG7jOrcZ8JMhpH3eixRcpMsrCyN/QDBo0sBEvqhMclTzAIm7QaAgOrKF2OOXZayUmo5yOhn/52ebC05aWXBP74K6qGx2qR2UlXzDr+kHmaU1pplgMV9/tPqdgkSqj44hsMZTUjTvFQjd4ll42Y2eSbRjKwT1Qf3GBYCoJczB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o+paYvTT; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6JcqIJDN2n8T3AGrwAmKJ4PLfv04T6SzeB0gmMr4dKeVfORFyQq/wQmPoubb593/Cv/xxM4K8RHjYz41fZkut1UdQPGhpo8KLidpzW3nMeMsWim68uzSdiG7WUKiSOHlwCbnZLoZ1fvSZmq00Fm10xglSns+mQcrfrneqavxUZtytuTPBK4p2w2xWPzgQS57D6OmYRpEJ/1aTNnpJLCmydhRIh3CKoqd8OM4cIgRX5hBx6o9fYKqBKjFb88j/WpsK9iNLnuURJdfFScRFGq3jJltUa3wDL1w9qY1DovZwdeeJb5ZXw2nII2w80QAqOxe9GKONLIvRtUzo9CW/sR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ+Mui7B4+tPl1FFOz2Ml6yLbSgZ8yUXnmroXI+bWdk=;
 b=W+DjeQoGl7l5Xh6e8K35I3ikbEsxHWkXoWiJ+14VoklqaTU7lgBRT1nNvDmn1HtLsQRPEEeRfFt6923o/ZYNe8NMeoQdqgqiq+OxKyxho6oIyTuxg8lAYXKlz0okaCaGM3BK+pLdyo7gMq6ZlWZ3TFq7mmAIf/S3Z6e6Bq7Elv5ZjEd4diAE2wBli2x1agUkFrHLSvapiU5b60j0i4cc+IhdxAAfhtx3ODyY6Nd3XowGJ3qZKe2RzTfbeyvr6ZYJkAvKS7rlLW6VEJKfYfbP1RtS70hYEzlEuAjjBYUnTDiCDq3cEYOlufy/KEKpsVOTllVr3kWlKtalg93SYOXnFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ+Mui7B4+tPl1FFOz2Ml6yLbSgZ8yUXnmroXI+bWdk=;
 b=o+paYvTTcrcmcwvdjP5l8dabqWi9J0S97XqyDumTBgGyCpKDCtV3Lj7LxGnAkJhzC/wKOwrGX+6gEJZrg7tEE9IG23jDBBZfiwp1J1klTWZMjuOKHUSwsOlfn0YBu3nlQ2B1IG8YC2+1jQ4Z+YToaDcsJSVwuJCHV7cEirGrTEIlaYU19HhWOZcz7rbDWBLeAc4bWlAZ1XmAJB0M1RvPVePJ7DxnzJgYumN8Xk1yPm++34CJDVzCy4F98S8hp+xzztW4QUeBRK4VcIWR5qWRKcjF43ZfOqkbh6i/id38FOD5rhOzvA1fM8SKvdSqiu13kgNblMj12rKAClC/Ov4/1w==
Received: from CH5PR03CA0005.namprd03.prod.outlook.com (2603:10b6:610:1f1::24)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 20:49:51 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::f5) by CH5PR03CA0005.outlook.office365.com
 (2603:10b6:610:1f1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 20:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 20:49:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 13:49:32 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 13:49:31 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 15 Aug
 2024 13:49:30 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
CC: <linux-edac@vger.kernel.org>, <shravankr@nvidia.com>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [v2, RESEND] EDAC/bluefield: Use Arm SMC for EMI access on BlueField-2
Date: Thu, 15 Aug 2024 16:49:28 -0400
Message-ID: <20240815204928.7333-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 760954d0-41de-4d51-1107-08dcbd6bce6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qOU05vr5l/ggsLIps0jLlsijETCTJCjX9x3Hzo7bPf2iMlHYCKYmmzGgJTD5?=
 =?us-ascii?Q?2xCl6/gSGBpmpXadApP41B7drhrx3re+tfEEdEMJabf+f8l5yo5CLVC+IlEH?=
 =?us-ascii?Q?9MI+TmMoiM8EugHGsES8xDxu5Pg7TEOAGAdkbbOFvkHOixNrl3Z9HU6u6IFQ?=
 =?us-ascii?Q?c05JqMIRQbfTTxbeFRok/Iu5HIkiOAonv4KgXsfwmq8na3sJ6gTH79ZYXOz6?=
 =?us-ascii?Q?mCKRxAxWKPvhqYI3Us6U2Ozhm+zQ+eZJGaYIya55O/g83Mze97yGEawiKpAh?=
 =?us-ascii?Q?oxXbwlogJscgd24Melqlt9ZPuicwJQbr8pksFSdjtIjqqpipNP+pcyy3JuoQ?=
 =?us-ascii?Q?psKPbQhJ9RL80YTX200X38gFN8DnpJkEtEuiiM4QscWMfrwqy+QqfG4Evs86?=
 =?us-ascii?Q?LZSe7eA+8p2K8pe9c+C7Ww66P8brd3pPQdnRDSb6+XynwAtwjzh8gqgA2Hyl?=
 =?us-ascii?Q?O2eFWxZFJlS2o2utvriEqwcM72e7+cS6+OYwd8xIRlM4GU1Or1kZZ0bohDf/?=
 =?us-ascii?Q?LOBaWHNiORWOk7VaKKIddmZOvKxygAYAaC/dagQFSBH+P5dlXrHVoQjXgH4e?=
 =?us-ascii?Q?0I5Zg7kVSPV5yNmkUH6hiE9+eFeVARhO3Yk7kdTBoDZv6EflDE26kFH3iWag?=
 =?us-ascii?Q?NL60X6AKfp3HS41osICQCATTTfibPwUCPhbT3AQEzh/YsBndQaN6nlilenk7?=
 =?us-ascii?Q?Ky+XrxUiAtE5TQhSkhHJJIlJwNV9eoVgDhWgw/IAMpwMlIQTXeOITGoBn8Zu?=
 =?us-ascii?Q?09+iyPuv53LmWr4mCJtT51/gd18hF30d41eGJRVbb/hxn2b5BtfXXtPBrYw4?=
 =?us-ascii?Q?7s7KCGRqv+G1ViQVgfcEMVEwEfvhOVm67Se0X+VszwBoW4W4mZ49WAVl67cm?=
 =?us-ascii?Q?3cvTmWv+LI+zt1btGZpQVMlyds8ALzEi34QWvZF1aiNdPwqSlRdT+UktPnh/?=
 =?us-ascii?Q?PFiTRJ+tESSZM33yri54d9DK6jE6uDAg0kcUb8anHCGKbYLXtO5qae1QJNgH?=
 =?us-ascii?Q?iKXhm9UYBUXmVzbO5Q9SbOT/Ca4f51pDK0rC5sYsUQ+IMM3X2c69nHDMUA8a?=
 =?us-ascii?Q?qa+ERrVH9A6IYdeQw0lqssTMGEHsK3UZ6HjBrIN9LcSUJEyVV0WKKUs9chBy?=
 =?us-ascii?Q?g8aea1RwHXtdIzhD+eBhs93sy6pI8sv5RYHePMIihDFpGWFtXhcIZgVdLp7Y?=
 =?us-ascii?Q?ZeP/pFw8tii3WeI6oXAzVv48DCxmvMP/vP6Ds2oY5BWL4u9l/AZEVZx6MoOR?=
 =?us-ascii?Q?Ftmjw43HDKQPwoMGX66rbRvSg+Gmwh35gtiVSNW8SNkBvlVUiPCLpClWthN1?=
 =?us-ascii?Q?czjyNZP79IECKCOsrWIYLq5MPhbfkcSqsU4xVPv4JytogpZSH14zmZxD0pMG?=
 =?us-ascii?Q?M+0Ab35+HdiQapcUdUjd+2Zj5h4qbOetyHtEWOcfFRPGrNbK81WXaGW4idSt?=
 =?us-ascii?Q?ml3BP1vmX34b6QPXFaPhy6SV27ujBJIp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 20:49:50.0141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 760954d0-41de-4d51-1107-08dcbd6bce6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228

The BlueField EDAC driver supports the first generation BlueField-1 SoC,
but not the second generation BlueField-2 SoC.  The BlueField-2 SoC is
different in that only secure accesses are allowed to the External Memory
Interface (EMI) register block. On BlueField-2, all read/write accesses
from Linux to EMI registers are routed via Arm Secure Monitor Call (SMC)
through Arm Trusted Firmware (ATF), which runs at EL3 privileged state.

On BlueField-1, EMI registers are mapped and accessed directly. In order
to support BlueField-2, the driver's read and write access methods must
be extended with additional logic to include secure access to the EMI
registers via SMCs.

The driver's probe routine must check the ACPI table for presence of
the "sec_reg_block" property and ensure the minimum required SMC service
version is present before enabling the BlueField-2 secure access methods.
The "sec_reg_block" property is only present in BlueField-2 ACPI table,
not the BlueField-1 ACPI table.

Also, the bluefield_edac driver needs two coding style fixes: one fix
addresses an issue raised by checkpatch, and the other fix provides
consistency in declaration of #defines.

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
v1 -> v2
a) removed #defines for SMC function IDs that are not used
b) added "bluefield_edac_" prefix to "secure_readl/writel" functions
c) added "bluefield_" prefix to "edac_readl/writel" functions
d) changed logic to use "uN" typedefs instead of "uintN_t"
e) added initialization of "priv->dev" in probe()
f) added more details to commit message

v0 -> v1
Updated commit message
---
 drivers/edac/bluefield_edac.c | 174 ++++++++++++++++++++++++++++++----
 1 file changed, 155 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index 5b3164560648..4e0db1cbfbe7 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -47,13 +47,22 @@
 #define MLXBF_EDAC_MAX_DIMM_PER_MC	2
 #define MLXBF_EDAC_ERROR_GRAIN		8
 
+#define MLXBF_WRITE_REG_32		(0x82000009)
+#define MLXBF_READ_REG_32		(0x8200000A)
+#define MLXBF_SIP_SVC_VERSION		(0x8200ff03)
+
+#define MLXBF_SMCCC_ACCESS_VIOLATION	(-4)
+
+#define MLXBF_SVC_REQ_MAJOR		0
+#define MLXBF_SVC_REQ_MINOR		3
+
 /*
- * Request MLNX_SIP_GET_DIMM_INFO
+ * Request MLXBF_SIP_GET_DIMM_INFO
  *
  * Retrieve information about DIMM on a certain slot.
  *
  * Call register usage:
- * a0: MLNX_SIP_GET_DIMM_INFO
+ * a0: MLXBF_SIP_GET_DIMM_INFO
  * a1: (Memory controller index) << 16 | (Dimm index in memory controller)
  * a2-7: not used.
  *
@@ -61,7 +70,7 @@
  * a0: MLXBF_DIMM_INFO defined below describing the DIMM.
  * a1-3: not used.
  */
-#define MLNX_SIP_GET_DIMM_INFO		0x82000008
+#define MLXBF_SIP_GET_DIMM_INFO		0x82000008
 
 /* Format for the SMC response about the memory information */
 #define MLXBF_DIMM_INFO__SIZE_GB GENMASK_ULL(15, 0)
@@ -72,9 +81,12 @@
 #define MLXBF_DIMM_INFO__PACKAGE_X GENMASK_ULL(31, 24)
 
 struct bluefield_edac_priv {
+	struct device *dev;
 	int dimm_ranks[MLXBF_EDAC_MAX_DIMM_PER_MC];
 	void __iomem *emi_base;
 	int dimm_per_mc;
+	bool svc_sreg_support;
+	u32 sreg_tbl_edac;
 };
 
 static u64 smc_call1(u64 smc_op, u64 smc_arg)
@@ -86,6 +98,71 @@ static u64 smc_call1(u64 smc_op, u64 smc_arg)
 	return res.a0;
 }
 
+static int bluefield_edac_secure_readl(void __iomem *addr, u32 *result, u32 sreg_tbl)
+{
+	struct arm_smccc_res res;
+	int status;
+
+	arm_smccc_smc(MLXBF_READ_REG_32, sreg_tbl, (uintptr_t)addr,
+		      0, 0, 0, 0, 0, &res);
+
+	status = res.a0;
+
+	switch (status) {
+	case SMCCC_RET_NOT_SUPPORTED:
+	case MLXBF_SMCCC_ACCESS_VIOLATION:
+		return -1;
+	default:
+		*result = (u32)res.a1;
+		return 0;
+	}
+}
+
+static int bluefield_edac_secure_writel(void __iomem *addr, u32 data, u32 sreg_tbl)
+{
+	struct arm_smccc_res res;
+	int status;
+
+	arm_smccc_smc(MLXBF_WRITE_REG_32, sreg_tbl, data, (uintptr_t)addr,
+		      0, 0, 0, 0, &res);
+
+	status = res.a0;
+
+	switch (status) {
+	case SMCCC_RET_NOT_SUPPORTED:
+	case MLXBF_SMCCC_ACCESS_VIOLATION:
+		return -1;
+	default:
+		return 0;
+	}
+}
+
+static int bluefield_edac_readl(void __iomem *addr, u32 *result,
+				bool sreg_support, u32 sreg_tbl)
+{
+	int err = 0;
+
+	if (sreg_support)
+		err = bluefield_edac_secure_readl(addr, result, sreg_tbl);
+	else
+		*result = readl(addr);
+
+	return err;
+}
+
+static int bluefield_edac_writel(void __iomem *addr, u32 data,
+				 bool sreg_support, u32 sreg_tbl)
+{
+	int err = 0;
+
+	if (sreg_support)
+		err = bluefield_edac_secure_writel(addr, data, sreg_tbl);
+	else
+		writel(data, addr);
+
+	return err;
+}
+
 /*
  * Gather the ECC information from the External Memory Interface registers
  * and report it to the edac handler.
@@ -99,7 +176,7 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 	u32 ecc_latch_select, dram_syndrom, serr, derr, syndrom;
 	enum hw_event_mc_err_type ecc_type;
 	u64 ecc_dimm_addr;
-	int ecc_dimm;
+	int ecc_dimm, err;
 
 	ecc_type = is_single_ecc ? HW_EVENT_ERR_CORRECTED :
 				   HW_EVENT_ERR_UNCORRECTED;
@@ -109,14 +186,22 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 	 * registers with information about the last ECC error occurrence.
 	 */
 	ecc_latch_select = MLXBF_ECC_LATCH_SEL__START;
-	writel(ecc_latch_select, priv->emi_base + MLXBF_ECC_LATCH_SEL);
+	err = bluefield_edac_writel(priv->emi_base + MLXBF_ECC_LATCH_SEL,
+				    ecc_latch_select, priv->svc_sreg_support,
+				    priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "ECC latch select write failed.\n");
 
 	/*
 	 * Verify that the ECC reported info in the registers is of the
 	 * same type as the one asked to report. If not, just report the
 	 * error without the detailed information.
 	 */
-	dram_syndrom = readl(priv->emi_base + MLXBF_SYNDROM);
+	err = bluefield_edac_readl(priv->emi_base + MLXBF_SYNDROM, &dram_syndrom,
+				   priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "DRAM syndrom read failed.\n");
+
 	serr = FIELD_GET(MLXBF_SYNDROM__SERR, dram_syndrom);
 	derr = FIELD_GET(MLXBF_SYNDROM__DERR, dram_syndrom);
 	syndrom = FIELD_GET(MLXBF_SYNDROM__SYN, dram_syndrom);
@@ -127,13 +212,24 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 		return;
 	}
 
-	dram_additional_info = readl(priv->emi_base + MLXBF_ADD_INFO);
+	err = bluefield_edac_readl(priv->emi_base + MLXBF_ADD_INFO, &dram_additional_info,
+				   priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "DRAM additional info read failed.\n");
+
 	err_prank = FIELD_GET(MLXBF_ADD_INFO__ERR_PRANK, dram_additional_info);
 
 	ecc_dimm = (err_prank >= 2 && priv->dimm_ranks[0] <= 2) ? 1 : 0;
 
-	edea0 = readl(priv->emi_base + MLXBF_ERR_ADDR_0);
-	edea1 = readl(priv->emi_base + MLXBF_ERR_ADDR_1);
+	err = bluefield_edac_readl(priv->emi_base + MLXBF_ERR_ADDR_0, &edea0,
+				   priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "Error addr 0 read failed.\n");
+
+	err = bluefield_edac_readl(priv->emi_base + MLXBF_ERR_ADDR_1, &edea1,
+				   priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "Error addr 1 read failed.\n");
 
 	ecc_dimm_addr = ((u64)edea1 << 32) | edea0;
 
@@ -147,6 +243,7 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 {
 	struct bluefield_edac_priv *priv = mci->pvt_info;
 	u32 ecc_count, single_error_count, double_error_count, ecc_error = 0;
+	int err;
 
 	/*
 	 * The memory controller might not be initialized by the firmware
@@ -155,7 +252,11 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 	if (mci->edac_cap == EDAC_FLAG_NONE)
 		return;
 
-	ecc_count = readl(priv->emi_base + MLXBF_ECC_CNT);
+	err = bluefield_edac_readl(priv->emi_base + MLXBF_ECC_CNT, &ecc_count,
+				   priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "ECC count read failed.\n");
+
 	single_error_count = FIELD_GET(MLXBF_ECC_CNT__SERR_CNT, ecc_count);
 	double_error_count = FIELD_GET(MLXBF_ECC_CNT__DERR_CNT, ecc_count);
 
@@ -172,8 +273,12 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 	}
 
 	/* Write to clear reported errors. */
-	if (ecc_count)
-		writel(ecc_error, priv->emi_base + MLXBF_ECC_ERR);
+	if (ecc_count) {
+		err = bluefield_edac_writel(priv->emi_base + MLXBF_ECC_ERR, ecc_error,
+					    priv->svc_sreg_support, priv->sreg_tbl_edac);
+		if (err)
+			dev_err(priv->dev, "ECC Error write failed.\n");
+	}
 }
 
 /* Initialize the DIMMs information for the given memory controller. */
@@ -189,7 +294,7 @@ static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
 		dimm = mci->dimms[i];
 
 		smc_arg = mem_ctrl_idx << 16 | i;
-		smc_info = smc_call1(MLNX_SIP_GET_DIMM_INFO, smc_arg);
+		smc_info = smc_call1(MLXBF_SIP_GET_DIMM_INFO, smc_arg);
 
 		if (!FIELD_GET(MLXBF_DIMM_INFO__SIZE_GB, smc_info)) {
 			dimm->mtype = MEM_EMPTY;
@@ -244,6 +349,7 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	struct bluefield_edac_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct edac_mc_layer layers[1];
+	struct arm_smccc_res res;
 	struct mem_ctl_info *mci;
 	struct resource *emi_res;
 	unsigned int mc_idx, dimm_count;
@@ -279,13 +385,44 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv = mci->pvt_info;
+	priv->dev = dev;
+
+	/*
+	 * The "sec_reg_block" property in the ACPI table determines the method
+	 * the driver uses to access the EMI registers:
+	 * a) property is not present - directly access registers via readl/writel
+	 * b) property is present - indirectly access registers via SMC calls
+	 *    (assuming required Silicon Provider service version found)
+	 */
+	if (device_property_read_u32(dev,
+				     "sec_reg_block", &priv->sreg_tbl_edac)) {
+		priv->svc_sreg_support = false;
+	} else {
+		/*
+		 * Check for minimum required Arm Silicon Provider (SiP) service
+		 * version, ensuring support of required SMC function IDs.
+		 */
+		arm_smccc_smc(MLXBF_SIP_SVC_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
+		if (res.a0 == MLXBF_SVC_REQ_MAJOR &&
+		    res.a1 >= MLXBF_SVC_REQ_MINOR) {
+			priv->svc_sreg_support = true;
+		} else {
+			dev_err(dev, "Required SMCs are not supported.\n");
+			ret = -EINVAL;
+			goto err;
+		}
+	}
 
 	priv->dimm_per_mc = dimm_count;
-	priv->emi_base = devm_ioremap_resource(dev, emi_res);
-	if (IS_ERR(priv->emi_base)) {
-		dev_err(dev, "failed to map EMI IO resource\n");
-		ret = PTR_ERR(priv->emi_base);
-		goto err;
+	if (!priv->svc_sreg_support) {
+		priv->emi_base = devm_ioremap_resource(dev, emi_res);
+		if (IS_ERR(priv->emi_base)) {
+			dev_err(dev, "failed to map EMI IO resource\n");
+			ret = PTR_ERR(priv->emi_base);
+			goto err;
+		}
+	} else {
+		priv->emi_base = (void __iomem *)emi_res->start;
 	}
 
 	mci->pdev = dev;
@@ -320,7 +457,6 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	edac_mc_free(mci);
 
 	return ret;
-
 }
 
 static void bluefield_edac_mc_remove(struct platform_device *pdev)
-- 
2.30.1


