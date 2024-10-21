Return-Path: <linux-edac+bounces-2172-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDA09A9430
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 01:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C821C214E4
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 23:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB9A1E377A;
	Mon, 21 Oct 2024 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YghvGEG0"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D11A41;
	Mon, 21 Oct 2024 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553442; cv=fail; b=solDXrBe9fxF018CtdZKHQ/u7jpwXkkTEEGIe0ioChS0p8t3Meyr/ZQ73uQca9FixW6L1Gk1c70EuF7kXK+R8TKxxI/bwJy4i3y9eEfyhq6FjJy7cuy5EJ0CO3qi6dtWtdESmiI2K9U2tqrdKXgN9TiLDetBqttKxIpf2068yss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553442; c=relaxed/simple;
	bh=oYd7XUBVchdXpWkDZUMBwSvsIr5LVoNr8JE9I9EcfY8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PTdMAPppps71+XOqEXhf/P5PjRL7bR5U7CoGZMp0jon/2t8TjxyFGvB2CFEyjs6cSJ/q9i1Ermn2nrgo90G/EGSdlDpxnwJt3dqL8i/32muSi6IiLAbVQLDwKfI3BlAuzPXNmSAf1wyCKXh0Hi5aQLfoLvgMt0k+sLSPI5St3zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YghvGEG0; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2yHMvOg1dQt6WCU6uS4izZjhO330hW30BIQAvAfcCeAwE4vCeT9KvKzm6PdKD1yJOWCWXysrEZZ+fkYedpEbwXDB4udvRxIJV7awTOEcwbwMNK5p1+npdGtbMqdsl9iT+Cb7VEK/191p27WSzL8/Le9/Bb+GDWCL4mYmXxAMayXti7mo7OoEiRO6kxdk4K/ajfKqZinGP847dnzGsthAMDrwjihbjetwsWkWAQMHwVCphpXG80MCk0gxnR/jKLuKzGzsY5TeEbNbAYyrA7klFCTs7WqO02pzQ33S8m+SkDwZVd4xPo996Xh6eXTiNxJdBt/ZmymdQoTKVn/sC/izw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYI9f8K+Q8lseIZt6X2HmGR2a8Sd90fmGbbfJNArUvo=;
 b=FD9LQPXOpl1krB3caHMrL4lOA6OOWxHPfeP47SYlxRrE4wwdpHstbI7Dm/VXepD8nao3+5t3tiGZbi/f2b7E55dYSFX05Ttl232jKXpj5RCyoOI058eULeUEdiffJ6MNfFiTmN14PxK9Uat+uVEfIJy3eNinpWt4P/Iggyj2Gl2Pg6koSAccifsGf6oLaIcuy+mVmcJ7mUvu+RVmCPFoWdTpBwAnoIbAieDzgczV1/ZR0OMl/a8npDi8b6UaeVGG5bwpEXCp0QpQ9Tmtu+jZ4i3WZ43xZwe3G2/Q2HVWYjQQRhNbue+8zmNvZY12PCsVJjS+yHdu5wee6f2G4KXdhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYI9f8K+Q8lseIZt6X2HmGR2a8Sd90fmGbbfJNArUvo=;
 b=YghvGEG0mRtMzlWBGUV8bBB0lcvcqOwc30Ytmg4n4EDb7nuk426TMpNo9RWqkNPfKbO+WsUz9WSVuFLWbt5TCqPuHYcitultTknrW4YV0yHnCOcxjQ6ShhnZ7wqTV5jXDMsQlSLNKc1PEZDOpjrs8yCJUmtdy00SuKfh5V7wyMgtTM0RywKTxyQDwh0yiu04USGwp6d4i6811MjaS+gvcJka7Xhk+AbHJtuCJ9lbJVEnvMQAEmtpeKna17OU3EQVmDJ+pDNViwkbxozJA4UdSsRYBrRnmZ64iyXO9BEBDluSgR//JDgshhpL7K0TWUcckFs+OSnPruM/XPSCFRwtGg==
Received: from BN0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:141::15)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 23:30:36 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::19) by BN0PR07CA0003.outlook.office365.com
 (2603:10b6:408:141::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 23:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 23:30:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 16:30:16 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 16:30:16 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 21 Oct
 2024 16:30:15 -0700
From: David Thompson <davthompson@nvidia.com>
To: <shravankr@nvidia.com>, <bp@alien8.de>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Thompson" <davthompson@nvidia.com>
Subject: [PATCH v3] EDAC/bluefield: Use Arm SMC for EMI access on BlueField-2
Date: Mon, 21 Oct 2024 19:30:13 -0400
Message-ID: <20241021233013.18405-1-davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac04805-fd4e-4c12-0950-08dcf2285d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2sYZ7f+EgBtgTDEhJ0VpRwnWjFApcPwxpRyc7ErRoPZVHDLbTQyMxxfH8/GZ?=
 =?us-ascii?Q?4MJsO5/4bkBRRi9pCOXRfgHzmXiWadrIiG3iGoOBXkvBR3VYG0N6vZRXS0se?=
 =?us-ascii?Q?wGZ6Qar4C8A79Fun4JJgTAxh+nNR3Tg6fkvjIbb4c6sD8wA8sVC48HchW8yP?=
 =?us-ascii?Q?0CJxNBCgPS1mpoQRU0gb6TYPJZ3ATKc/wf1/t4nNUMLm9iKYp4YI5E7cJZ/F?=
 =?us-ascii?Q?oDophXSP5OmlzFQe2nerbo8Sdp4mOxTj2UfbzX7wCx2IE7ZHpAQ2/vTA/Vbu?=
 =?us-ascii?Q?fZR55o371ns+gtHrDf2zRAPwzhlgRJIGOZFesO0oDQUWkgs5tSRf8x1q0RaC?=
 =?us-ascii?Q?BfdTp0rMYngvjGvUNupGztiLmZt1lXH/h1Mh+yLsY2K1MDYw4C39fNaMYYjG?=
 =?us-ascii?Q?hn4vHxotYVzVDGk0r/h0rU0M75zqvt3Qo1lkeEHz/XoQEVUfTURezVWaFxVY?=
 =?us-ascii?Q?hejX+Er3JPTu7wnz+j6kT4bQ3bhRCBPq6ZlG99SiW6n6IGp8as35CZsmuzMF?=
 =?us-ascii?Q?jdgvdXo/edeUP9nMEV1zx0uH/YE5av0UCRFb4obnqI7buXHBtltZ8qYIwo6t?=
 =?us-ascii?Q?/s/xillFru3SeNcQAh6BgnlTxWVcMlIAX2Gx7ECHkJRrRyu6mQOrV1KELaZG?=
 =?us-ascii?Q?xxWl2b9rab0uH31WXg9a1nIaPv1B8Yw3kBU8fF3/t06wC8yaBEmbEDLJSCOO?=
 =?us-ascii?Q?CBAWkrjmwu8z03mnDMza8IfsxQBM5ErGNpBV8VcOrlWrYUMvHx3btkqftzQG?=
 =?us-ascii?Q?gB7utJT/qouotctClK7XSns+HsKgGW3iwdeC+/uAzYj0WeW3FayTl4XYnSae?=
 =?us-ascii?Q?qm9wzJ5UFXgArbY2nYK7oDb5cTPe+iWzIdos5AQJSfD5gfVWSlZOBD8iyspd?=
 =?us-ascii?Q?JRXR3vPjoUk/j5EuBdPLSEuJHg/b9uMnObVMnumcTPSPw23dzgiMbDp6fAA8?=
 =?us-ascii?Q?8W+jQqmQRl8wrFf3c3lzXE8T+3IwV1vursDXipMrtMUQm3pbXJ298dTzSaGH?=
 =?us-ascii?Q?nYGp+ZcNk5BakARZa8OOONtuMb8c3nscf1D2xCfCaiOuNlFBrF/WPRVYtaQt?=
 =?us-ascii?Q?050ca/JBBu/LLv4bnVmPq15Wy43FQ2iWI3hDkCsB/jNS8/626O63uG7xaFbV?=
 =?us-ascii?Q?ckwr7UWf5fZQY4NGMlcDsrGP+N4TcNNnShF2dCWahzfqxk3uE0tZUIp2QnQG?=
 =?us-ascii?Q?MTQflzd5mdLDKvivXNA3W4F6oLVH0DtwGlLE32+4+9+Ef5H6AtC1ZJ9+Ld9x?=
 =?us-ascii?Q?ahS+lqVm61Q1ji33ViZPIAqzy0VU0eCf5TrbXsIMPn1ywc0eyMa7+jruttg3?=
 =?us-ascii?Q?+Ueke4Y1V53ivoNlNWTsBVZAMcazwJcaESkW3s+lrXafiDEeGzoB4wboLwxj?=
 =?us-ascii?Q?5I3GH+EUsKtY+JZQBFLQ8rPOBAI57E8B3H7QmbHzR/5KvTQS7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 23:30:35.2967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac04805-fd4e-4c12-0950-08dcf2285d26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954

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

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
v2 -> v3
a) added comments for new members of bluefield_edac_priv structure
b) renamed static functions "bluefield_edac_secure_[readl|writel]"
   to "secure_[readl|writel]". Note: the static functions
   "bluefield_edac_[readl|writel]" are not renamed to "readl|writel"
   because that would conflict with IO primitives in kernel.
c) re-wrote switch statements in "secure_[readl|writel]" to if-else
d) re-wrote function signature of "bluefield_edac_[readl|writel]"
   so that "priv" is first argument
e) fixed line break in "bluefield_edac_mc_probe"
f) re-worded commit message to focus on the patch's reason

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
 drivers/edac/bluefield_edac.c | 169 ++++++++++++++++++++++++++++++----
 1 file changed, 150 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index 0e539c107351..6d52f129f914 100644
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
+	struct device *dev;  /* pointer to device structure */
 	int dimm_ranks[MLXBF_EDAC_MAX_DIMM_PER_MC];
 	void __iomem *emi_base;
 	int dimm_per_mc;
+	bool svc_sreg_support; /* access to secure regs supported */
+	u32 sreg_tbl_edac;     /* SMC table# for secure regs access */
 };
 
 static u64 smc_call1(u64 smc_op, u64 smc_arg)
@@ -86,6 +98,75 @@ static u64 smc_call1(u64 smc_op, u64 smc_arg)
 	return res.a0;
 }
 
+static int secure_readl(void __iomem *addr, u32 *result, u32 sreg_tbl)
+{
+	struct arm_smccc_res res;
+	int status;
+
+	arm_smccc_smc(MLXBF_READ_REG_32, sreg_tbl, (uintptr_t)addr,
+		      0, 0, 0, 0, 0, &res);
+
+	status = res.a0;
+
+	if (status == SMCCC_RET_NOT_SUPPORTED ||
+	    status == MLXBF_SMCCC_ACCESS_VIOLATION)
+		return -1;
+
+	*result = (u32)res.a1;
+	return 0;
+}
+
+static int secure_writel(void __iomem *addr, u32 data, u32 sreg_tbl)
+{
+	struct arm_smccc_res res;
+	int status;
+
+	arm_smccc_smc(MLXBF_WRITE_REG_32, sreg_tbl, data, (uintptr_t)addr,
+		      0, 0, 0, 0, &res);
+
+	status = res.a0;
+
+	if (status == SMCCC_RET_NOT_SUPPORTED ||
+	    status == MLXBF_SMCCC_ACCESS_VIOLATION)
+		return -1;
+	else
+		return 0;
+}
+
+static int bluefield_edac_readl(struct bluefield_edac_priv *priv, u32 offset, u32 *result)
+{
+	bool sreg_support = priv->svc_sreg_support;
+	u32 sreg_tbl = priv->sreg_tbl_edac;
+	void __iomem *addr;
+	int err = 0;
+
+	addr = priv->emi_base + offset;
+
+	if (sreg_support)
+		err = secure_readl(addr, result, sreg_tbl);
+	else
+		*result = readl(addr);
+
+	return err;
+}
+
+static int bluefield_edac_writel(struct bluefield_edac_priv *priv, u32 offset, u32 data)
+{
+	bool sreg_support = priv->svc_sreg_support;
+	u32 sreg_tbl = priv->sreg_tbl_edac;
+	void __iomem *addr;
+	int err = 0;
+
+	addr = priv->emi_base + offset;
+
+	if (sreg_support)
+		err = secure_writel(addr, data, sreg_tbl);
+	else
+		writel(data, addr);
+
+	return err;
+}
+
 /*
  * Gather the ECC information from the External Memory Interface registers
  * and report it to the edac handler.
@@ -99,7 +180,7 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 	u32 ecc_latch_select, dram_syndrom, serr, derr, syndrom;
 	enum hw_event_mc_err_type ecc_type;
 	u64 ecc_dimm_addr;
-	int ecc_dimm;
+	int ecc_dimm, err;
 
 	ecc_type = is_single_ecc ? HW_EVENT_ERR_CORRECTED :
 				   HW_EVENT_ERR_UNCORRECTED;
@@ -109,14 +190,19 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 	 * registers with information about the last ECC error occurrence.
 	 */
 	ecc_latch_select = MLXBF_ECC_LATCH_SEL__START;
-	writel(ecc_latch_select, priv->emi_base + MLXBF_ECC_LATCH_SEL);
+	err = bluefield_edac_writel(priv, MLXBF_ECC_LATCH_SEL, ecc_latch_select);
+	if (err)
+		dev_err(priv->dev, "ECC latch select write failed.\n");
 
 	/*
 	 * Verify that the ECC reported info in the registers is of the
 	 * same type as the one asked to report. If not, just report the
 	 * error without the detailed information.
 	 */
-	dram_syndrom = readl(priv->emi_base + MLXBF_SYNDROM);
+	err = bluefield_edac_readl(priv, MLXBF_SYNDROM, &dram_syndrom);
+	if (err)
+		dev_err(priv->dev, "DRAM syndrom read failed.\n");
+
 	serr = FIELD_GET(MLXBF_SYNDROM__SERR, dram_syndrom);
 	derr = FIELD_GET(MLXBF_SYNDROM__DERR, dram_syndrom);
 	syndrom = FIELD_GET(MLXBF_SYNDROM__SYN, dram_syndrom);
@@ -127,13 +213,21 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 		return;
 	}
 
-	dram_additional_info = readl(priv->emi_base + MLXBF_ADD_INFO);
+	err = bluefield_edac_readl(priv, MLXBF_ADD_INFO, &dram_additional_info);
+	if (err)
+		dev_err(priv->dev, "DRAM additional info read failed.\n");
+
 	err_prank = FIELD_GET(MLXBF_ADD_INFO__ERR_PRANK, dram_additional_info);
 
 	ecc_dimm = (err_prank >= 2 && priv->dimm_ranks[0] <= 2) ? 1 : 0;
 
-	edea0 = readl(priv->emi_base + MLXBF_ERR_ADDR_0);
-	edea1 = readl(priv->emi_base + MLXBF_ERR_ADDR_1);
+	err = bluefield_edac_readl(priv, MLXBF_ERR_ADDR_0, &edea0);
+	if (err)
+		dev_err(priv->dev, "Error addr 0 read failed.\n");
+
+	err = bluefield_edac_readl(priv, MLXBF_ERR_ADDR_1, &edea1);
+	if (err)
+		dev_err(priv->dev, "Error addr 1 read failed.\n");
 
 	ecc_dimm_addr = ((u64)edea1 << 32) | edea0;
 
@@ -147,6 +241,7 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 {
 	struct bluefield_edac_priv *priv = mci->pvt_info;
 	u32 ecc_count, single_error_count, double_error_count, ecc_error = 0;
+	int err;
 
 	/*
 	 * The memory controller might not be initialized by the firmware
@@ -155,7 +250,10 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 	if (mci->edac_cap == EDAC_FLAG_NONE)
 		return;
 
-	ecc_count = readl(priv->emi_base + MLXBF_ECC_CNT);
+	err = bluefield_edac_readl(priv, MLXBF_ECC_CNT, &ecc_count);
+	if (err)
+		dev_err(priv->dev, "ECC count read failed.\n");
+
 	single_error_count = FIELD_GET(MLXBF_ECC_CNT__SERR_CNT, ecc_count);
 	double_error_count = FIELD_GET(MLXBF_ECC_CNT__DERR_CNT, ecc_count);
 
@@ -172,8 +270,11 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 	}
 
 	/* Write to clear reported errors. */
-	if (ecc_count)
-		writel(ecc_error, priv->emi_base + MLXBF_ECC_ERR);
+	if (ecc_count) {
+		err = bluefield_edac_writel(priv, MLXBF_ECC_ERR, ecc_error);
+		if (err)
+			dev_err(priv->dev, "ECC Error write failed.\n");
+	}
 }
 
 /* Initialize the DIMMs information for the given memory controller. */
@@ -189,7 +290,7 @@ static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
 		dimm = mci->dimms[i];
 
 		smc_arg = mem_ctrl_idx << 16 | i;
-		smc_info = smc_call1(MLNX_SIP_GET_DIMM_INFO, smc_arg);
+		smc_info = smc_call1(MLXBF_SIP_GET_DIMM_INFO, smc_arg);
 
 		if (!FIELD_GET(MLXBF_DIMM_INFO__SIZE_GB, smc_info)) {
 			dimm->mtype = MEM_EMPTY;
@@ -244,6 +345,7 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	struct bluefield_edac_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct edac_mc_layer layers[1];
+	struct arm_smccc_res res;
 	struct mem_ctl_info *mci;
 	struct resource *emi_res;
 	unsigned int mc_idx, dimm_count;
@@ -279,13 +381,43 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
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
+	if (device_property_read_u32(dev, "sec_reg_block", &priv->sreg_tbl_edac)) {
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
@@ -320,7 +452,6 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	edac_mc_free(mci);
 
 	return ret;
-
 }
 
 static void bluefield_edac_mc_remove(struct platform_device *pdev)
-- 
2.30.1


