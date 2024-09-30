Return-Path: <linux-edac+bounces-1936-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574F098A855
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 17:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133EA28397C
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A89D18FDDA;
	Mon, 30 Sep 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ao1o70s0"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6206E20B0F;
	Mon, 30 Sep 2024 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709670; cv=fail; b=KAZpmYpioEhmnn+I0P5/pfYRHQ9sHXdq0/soYfGTluMVDx25QGuMHFxQ13/iG8i8saqoCNcYPlShwE4HUCaVSzM9YnKb733m/6JO6yejab9fQdRIqPCVpWMwgaXXoIQ+3qbGz6Ta6bRNr2da73lCEoDtyKuVQ7C2Kf6Ga7YPSuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709670; c=relaxed/simple;
	bh=PSSL7mAIfmYWSlwXigPTYvsj0Ifc/pAr90nK1p/Tgj4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iflnl9CI+Lewn2RCpzCuSopxFS+jg+hyXrH0CJiSkqFVqOUqCKVqFH5t4u6ISqWhoKbh+RJXO4ECrfahXelBxGW4KPqq0KFBq5fgswXXNzZaSMCBZ5KFUmmcIzS10ba7OBGxozT1mrLfZFy/keIEoJo+Yi4CT1Dzo3hrrMEEzEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ao1o70s0; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDYw8Vn3SSGC70H7QnMV1Pz1kpr7LKyCHhsPAVWj6tltordg5nYtDe/1vPVg8GX0EDnrulJRlWeA/BTRJTvXOMSKNcMNmsU8Y+iVoJym2XduyKN0XS7xtXmG2wXk630RgWcoh2rFn4eAc+w5E0ekqs/D9XhMg1dB7GML9/w2HeTxtQExR+k+eO2n8gSMD4uteuITBoMDBIaX08UWY047rm/Ys0C740wIKA07fy7/u9OSLTk/GeSDrUEZR2PVu0I9U1fs+CiEX6Q+w9CnZh+5mWV4abr2VXGOJ3FZBF6WEiX/mwCq9J1i6+eQe+SNonoKPsHtlZHsrfENLI50cjCBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ+Mui7B4+tPl1FFOz2Ml6yLbSgZ8yUXnmroXI+bWdk=;
 b=bVEAQ6UnQ7On8TUJQVBfjTuypevooaINWmOIaXm0cGEL9gilM1bTaFumDjIojjNx2quveFyOHIOtZ/9RNVdgzQ+CHBit3yYAoESXHQ6H2aPLgx73dtPaPaaga76kI4YJn4zQ/KQK6xuYxV/1/MuecLc3LsSugAwknW0IwQFxxQFkrzqLraSeyXcLsGMnlRLOd2pqKZtNd9RML3FxdTOF0t/dYz0zUJu94ttPOEV9YQGCuBOTZZE8nTiukdBLVsqHY4G0kg4Nq1Zm0v19Vew8N+C9JknjEkH0aIGn6tGqqT7RGrlKbfA1trsEgzBzeP7uG121EHueIXiouQ7dy5bkCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ+Mui7B4+tPl1FFOz2Ml6yLbSgZ8yUXnmroXI+bWdk=;
 b=Ao1o70s0EsagCBYUEEIrxpLoEXwOFYE2nJfrTHwQhDSR6ZJA9aJeNx4jXqgKJG1TGKkCEfEOXCAEn4Incopjq6ZBrOCAmkOK+8f84oEXsb55UI90bnkOodKC1a8Lq8wp9EPChbOPEhvc0Qst0LxvJ1MFisKM4XPjlvTLiR1uae+6ADdh7LUcvL6LCsWjX9+sdgnGMzNOv74DJGqHXhhlrmu0d1ErNDeEd5BoO0PDDimNWs5DqpIsGalSzyvzfZITK9VzDuPmv7J4Gc298sOY9vUjYU/jit5m/0tww0sZh0sjCOD/ysFECSuwDm5eW5zEWv4xoZ/x+jCjppI7GlyqYQ==
Received: from MN0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:52f::18)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:21:02 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::f9) by MN0PR03CA0016.outlook.office365.com
 (2603:10b6:208:52f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 15:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 15:21:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 08:20:33 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 08:20:33 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 30 Sep
 2024 08:20:31 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>, <linux-edac@vger.kernel.org>
CC: <shravankr@nvidia.com>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: [PATCH v2 RESEND] EDAC/bluefield: Use Arm SMC for EMI access on BlueField-2
Date: Mon, 30 Sep 2024 11:20:30 -0400
Message-ID: <20240930152030.11773-1-davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 057a05c8-a40b-4dd8-2b10-08dce1637e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mXL9LPlKwPaQANTa9t0i2ws1hZh81tV9JadymJmrP9U+hHxBlnteMFcFUEdD?=
 =?us-ascii?Q?amGbD2RyHkg87qSYdRk9OUVJsogjSJ4NgeXEEJB0ns7Od+p6fD06nXPrIZuA?=
 =?us-ascii?Q?bP7lTmfcuHXp45zN1H0CtIDB9UfQD76AmTvCQeAwTQu9LC0Vxvvpn4nFzfBH?=
 =?us-ascii?Q?YaFnCjqsmKhZ3etV80Avnzu+naTjXADMKiRMhp67cRDjz7jIOE9UW2+bklvl?=
 =?us-ascii?Q?wHXwc+nEEXjeshXzIV1CaDROgyqaoOKkWIU42Sk7qksKFq7+2QuPEK0bTgAx?=
 =?us-ascii?Q?7/pu57KgnOLC8SWGeQYY4o6RXowDLZcF0bM8kKSQGl1uIz/fAK8RTLAjwbE1?=
 =?us-ascii?Q?P0ZggYTVk+rajfBV9IWFe9wLSRGCoYYUg4JMp6lpgX5Q+aVBGz/sxTCAO8Ha?=
 =?us-ascii?Q?nxO3qZpGmfDgLSckq7EndeG+8pxJebnIB7tR5tbkAWWaUqweSvWfE2xge+BU?=
 =?us-ascii?Q?TFIXyEAvGmAO62deqPZtc54YqtYxnfC2jGxG+Vr97BqRDk9Y1oP8QePAy9Vi?=
 =?us-ascii?Q?e6ksnBcZ7ksb4lrvMRta/jELtxZGAd24jy0XmvecxsSsuz6suVt4ytoLkRHJ?=
 =?us-ascii?Q?QfIAOEP0TBosabxS+OGF0P9XfhpLhicEgeFy5nnmuEbNdg4Dq9Z+tR6ZwyuC?=
 =?us-ascii?Q?HRb7AVOiJC6VW72YLouKgo2p5d4UvpSQrCcokWd9/7JDJa+P1ZwKRh5m4k93?=
 =?us-ascii?Q?18ltFYTfTC8QyWUwAn61VOJ2NSDZUScDNv6/6/9VkyELvxd3zXo8FM+ndMIP?=
 =?us-ascii?Q?GkYhgmhnBeLJENqlmTpBmXuBLM3dhhIo2EepduelKvCiTT8U/gQ2y4z1Hf2U?=
 =?us-ascii?Q?2UX8uyz6jNGutzFWjSiTXeFgbl2lKEggHbH1zhJ/x8TFCi6zOJ5qUgOt/jDz?=
 =?us-ascii?Q?yQR3RdfXJF1W36g9pzEyq7NMX1Nw72dBBdmY1jmIltlGJOrMe84oO68FIc/c?=
 =?us-ascii?Q?WfPocCwS8JRyCY7mlRm2B7PhtaBU2bSmLjRLq3gJnIqg2nVM34ZGuY64JBf7?=
 =?us-ascii?Q?4xG6n0g3Css7525NYjxEGAGMjg2AD1BeGyvKQNrkHvqkaBsfj9hUWvTgmWGU?=
 =?us-ascii?Q?4+VS1PJ0k2/aVIJgoU61BeFpDFmngnnROvEAs2vbR6HOBHWUg7i0fUfqHeq6?=
 =?us-ascii?Q?QqaO151KV368KDST4wC89HxTxL3bOjlEM1XWeu8jderQ+a7Y6o7Ap1lH0uev?=
 =?us-ascii?Q?qFtrj9LSZDYPEao0/iTXXQOtiPzDE/CbO6Cjhhp+ElJ5/OoTfFlThBxo406d?=
 =?us-ascii?Q?yNNwVd0s3xnSTRNFmM+nH/e9Zh+OotpItiM/0btaSZYjp8GuB3NqeiggNHAv?=
 =?us-ascii?Q?HI1KwLJDBNzMga0scHqyNdP+l1r3SVugu3WNKRm0LcpvrBLF+/MiVEDl6DxH?=
 =?us-ascii?Q?rKoLs4cjfriSVpfrRqXRnbFmHG4A?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:21:01.6136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 057a05c8-a40b-4dd8-2b10-08dce1637e60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299

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


