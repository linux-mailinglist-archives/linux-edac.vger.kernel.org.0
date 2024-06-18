Return-Path: <linux-edac+bounces-1305-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ED390D7BD
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jun 2024 17:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E655C1C24BB4
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jun 2024 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7B482869;
	Tue, 18 Jun 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mL3up4jb"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524340851;
	Tue, 18 Jun 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725741; cv=fail; b=bm1w9peMIM5jHbpv/MkcT6m+ZUlxG3imBQYB5a0qQ3k6aMDPrCRO5NCzIv+OjUe2UaAf3UEBWquyIStsgImxWRzmRFbOCi4r3p3bdqQXJJphGtV+/dAF9oDziGK/QXe+Wlj/4Kvn605IdPSnx4ZwNBc8NdzMZiaOOyslALIIO2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725741; c=relaxed/simple;
	bh=PSSL7mAIfmYWSlwXigPTYvsj0Ifc/pAr90nK1p/Tgj4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Od6bFEXwOPTbmPrK34V0zDVXcaw3+UCUWs3Bxv1IQxPHLaqe8Q/zRzpJsTDR1a1EDvYM4Z9E5ERFbjBpIRAwL2JfNmdaEbFvlWXf+QHbV5hCy5vvhAEjjRa7B3jNniM8cw743gTwtuxpVdDf5EApqD+Hb2ZvCsbwxKyxk0UuDMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mL3up4jb; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrYweOn18Q1ITFqzXjR/zr6TFRgb8K7pbFP1q+EHQHnPBozpGAH79CtUBBhPWj1q2tQL4LwxtbpXESpc6Tf/7hTueIWz5xtyhyTZldsEuWf+M4p8GQX1S/pJEke1VkS09jZr/BWkgGi92vgsfZlLyvxXDvxBamZzcr96B/hQPXgHXch2UBF8uPCqiyM6W3p5hb6Y0vxMT0y5c2Vmg6E1CKHYDN1zKCMpmLmc/eQmLXFfdoXXz4Snk/8+6lhYp+zdloKzpZRYBfz+Nw6wDaHpkWsYHwS5J4tBoR3F4I/tYa8TDa7n8azapU3kvWBT5ljqNaky9gWGGzBZz+cqTLQ2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ+Mui7B4+tPl1FFOz2Ml6yLbSgZ8yUXnmroXI+bWdk=;
 b=ZWj6YqMq7bartm+/knae5DaQUZHw6sqQ3j20ZGQbqgxO9a0xNgi+hXrJV6dTBsscATs60dXo1gMi6b5oDyyCL+u0tIXvejuGsUChdT94KCwRUDrUxzoDJLRulzVtEQwZ09grwqrBM2F2RKs619d/ThcOPdkzWrtZxeGzs72P/tBcJEUZwSTGXETteDOjS+XjjsjT2Mp5uSiYQnNnb7Gv72CEkFMESI2OfCsOdHY5bqUvLlJ2sjtjC5yip0IgjfEKcMGXdpWRBtjF3gbT8HIQ2+Phfh5/Cj7F4F8w4rP2JYS2uZmHBwg13wYq6HVf7Ynrs3Aq5JtR+1HCM6BjVjg5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ+Mui7B4+tPl1FFOz2Ml6yLbSgZ8yUXnmroXI+bWdk=;
 b=mL3up4jboyp/3FN43Z0fZdn4rMJ67eTuQ2atvi2/qHg07ut7+IuTqZ2JUsVd7oDeofYpgnz57H31crY6EhH21hOJo3O1BFIWPO/RkolxA4yAeXGAMjbPJb1Aa8ujiOjK21bZFOBfJBc4oKKZcF7T7X0B1upcEvlIzDXbCTE/Hapw1dufJAeTaqWlXV9TIqS1aroY8ZGjQleCvygcwaZ+a+i7SDMSNeZSPK1357E3LiOgzlK2zEBrP27nHnER7lI2lwUlMjdY5VFC8pHiANnd1dGQ1YV2cB919bRn5ZN5Gv4FlAJpIT7N13LxoP9V9ntH3sc5OsE5zwIHx/o5pk7atw==
Received: from BL1PR13CA0190.namprd13.prod.outlook.com (2603:10b6:208:2be::15)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 15:48:55 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2be:cafe::25) by BL1PR13CA0190.outlook.office365.com
 (2603:10b6:208:2be::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Tue, 18 Jun 2024 15:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 15:48:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 08:48:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 18 Jun 2024 08:48:34 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 18 Jun
 2024 08:48:33 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
CC: <shravankr@nvidia.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH v2] EDAC/bluefield: Use Arm SMC for EMI access on BlueField-2
Date: Tue, 18 Jun 2024 11:48:19 -0400
Message-ID: <20240618154819.28825-1-davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA0PR12MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0dbfaa-ff61-423d-985e-08dc8fae290f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XxCMdBSVa+wItuC6uSlwwEgLB3TDCvgCKF2JNrojyGja4Euiay8sqrjEeXcO?=
 =?us-ascii?Q?9hs8EGEskOSfn5XsoTnn6jcjrxZvh5AOVieUJW2KZ+/JPjGTO22T5m1ziKqb?=
 =?us-ascii?Q?wVia7bLXOzcAJPL9dhbcRcr9Y6mcq5pQ3VXxM9/+aJeeZCmZFv2tjc12pn5J?=
 =?us-ascii?Q?9njCc50seINuCOfpdr2usCP/Lzac/EwL8xr4fSZ2NcYFAs/85Gmpngvi+Myq?=
 =?us-ascii?Q?vm5X4OLiS/MsxfcknIqPgDiDGN8msA9JAqsYqVuSRSn0jMZRrNdoli0wlvbu?=
 =?us-ascii?Q?9emfNlvXbz2BrCOWpYIMD9qAWq/m5JpJulRC+N+k1A13Dt3a92MyrMx1HMP4?=
 =?us-ascii?Q?9oOVQyRMa2JP9eyzHP9CUaQ+YZQl+NUMyU1Cww3N+vYYL3sgAg/m9b9TJH90?=
 =?us-ascii?Q?r7JMNgrFFofpXZHJBYku4+V1Zadrz2uGOP+wF91ulXJDnCBT7ApteDL/IFyf?=
 =?us-ascii?Q?KW/CWBldngw0nispOxRqX+DKwDq5CNCRnVtCw6snLkvY8UIdAyGczl41EUrZ?=
 =?us-ascii?Q?Zjcli/negbGDJCxdnQ4CJoqrmI6MixFM0qzxWGOTG0EjLdMnwutcc9dOMChk?=
 =?us-ascii?Q?lSzmQ0Vm315f3bfggF4D0CcwYTR3RBv7NhHYVX52agsqHeV33m2Z9Nbyzo0X?=
 =?us-ascii?Q?uzjhEIvgsLKssJRN6flbvbMvhEMKnEx936hudlhOs1uWdYTBr8/E9PUuP97Z?=
 =?us-ascii?Q?WDoHW2bSPFS5fvpxdH9RvAK9vIDmPdWAawUg0Fhvt7gdtTO9gNhbcnWnAEIS?=
 =?us-ascii?Q?mQrAMsjGHRpOps19Mff8wVL63GsElD9e7R4kQzC6LamPf8RzOFBnSw86FRas?=
 =?us-ascii?Q?qK6akSVuN5LCXGTRC66w2IZtpximaf0XCYS4iDl5qHFBpdL9kkD98WAOroAJ?=
 =?us-ascii?Q?T3ie4hdUvxpT3MKykTofKqF6ulyfFkIfQNx2W26Yhtu5cBRU+L056cWG8HHR?=
 =?us-ascii?Q?NZHSDYz4s+jyhgbAlSQCAVzjhCeUztlIrPdf/mQwBZOhLywWRJzb87AGMjac?=
 =?us-ascii?Q?HZLsG/yKJc5jWDWn30np+6l9CaeBybhv8scirZAWL7BSYEXr8pKANlgPNjCV?=
 =?us-ascii?Q?l3eyZZBURWuYu+j82ftS5k14jhuqaFDHx64B42eKO/oQN4r6eTbKA/Cw9+ej?=
 =?us-ascii?Q?iJ5cAetDXqwD1DEpg9FXwcecRLlKYgJ5II1Bobudo39Ddlq1xc4smvALHhfE?=
 =?us-ascii?Q?VHv/g2Ag8yS3o4LJ/4/CvOduYQvywrjTMCZUgLczQh/vwvYN1hLBPNwNHiGr?=
 =?us-ascii?Q?eexOuYKmp7AkiJtjFELX6zPp/NuR+jbYDZ69mam6LyLAVYoytXJuur+w228Y?=
 =?us-ascii?Q?/dEXiZnYmo0hkhjkCB9p1hfItdtMD65lQn3K9jm+S72Cxw0HcGknwVjQr+nx?=
 =?us-ascii?Q?r1/YTBHP6Mn4ZYOgoZxYYHj87h8mMwnzZ0PqttXUSxGzbl4Qwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:48:55.3705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0dbfaa-ff61-423d-985e-08dc8fae290f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982

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


