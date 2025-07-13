Return-Path: <linux-edac+bounces-4349-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C6DB02EA4
	for <lists+linux-edac@lfdr.de>; Sun, 13 Jul 2025 07:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338F34A13CC
	for <lists+linux-edac@lfdr.de>; Sun, 13 Jul 2025 05:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7959433B1;
	Sun, 13 Jul 2025 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0KZFXI54"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0537E7F9;
	Sun, 13 Jul 2025 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752383296; cv=fail; b=eSAyzZSSKOOIhNN0O7cT3GKJjSKkSbnBY9ZNxRdNvoxSU5QjPfM0PEhDamEn8yAlqk3igb3qgujgF7mHDv2hZnzaBPoqZXt6NshuEHctmjJVpKS9Fouco2deOED6sZ++G5i4SD6XHso0vBGLbUyT603ZJFNHsv17485VYFhmaCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752383296; c=relaxed/simple;
	bh=g4iB9RQYmDUTh9JfxrAbcdEfDwu3oOGVViwjW+/kExY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lZyK0/oS0n+Aa4PraWCSRVlNpB/Icsv9W5ELIo3a5eOau2ibERK63Xx9ZRpZcSJaw+jIexOl4mC8q44IjKTeJUGPMlfvUqQZ51ZpSCmd/tuoULIC3pT3dcZiBrsO5dnStA2b0Itla1JpeIeismO2Xu+5TfvPuf4VYzlTn03Hces=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0KZFXI54; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aes/MEtv80OyGifOysZ0bDWxlAN8lllXEwWQRccRUdpRbUlOofvkg1QvUCqWcHZOwL0GXP3ptM6X+eChd97bHX0qOTxs0gDa+9vwvp76XdrM2dMPifU59bQsvaW8Ul2GqyrTTo8Yo3e2zy8/7/Zh3AnMHyhrVobQAu/fbq8H5RePNjLfrbd4iO5ilf1Lrm1vrNth+mZAuIzHxzsywYWZu9qDSzZYm0p+Odf6/sB+ePRgVQSno/aCsMuijt/BhNI1rmww9hEkYQrA+fYis0Bp/Pgb7i+mN9KIl2ZfR5dXz91dSAOKyST6F7FG54O3LXWacYi2KPjOwyXZS42rq9Dhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB1esfw+AQn4L71LKtEI7G5IsHxU90+3ESmgRJhLOjg=;
 b=xVTk/cMA0hIYmcQCKbFI3+TBSvbq4kmrpM3RtXAU5hHyFjnBTx5VbqJ9QBxu1bOYJu/Tiic6TtLg2EPbi2+W78DHCWqw8yfVRiqgbeol7hCh2B6vd5WUgLiUNNfy0kILascHFIk/tExWyRFVMI8r5Z+3p1r0oMEv/qRg/epOSGN/nCn7WyDoEpVU8wK7IzaX/vNyrMzD+DMMkoUl4IIGXcMlRsBYNpL8Hrq/NyiSkeIhzwcZQs4kqG8S1tmcEhmrc2pFFMgEBo35M6hknRjHoNi1UEM9oCw1y68Jd93Iz0w8YL+3exurK9pSoz8jMsUMsA5NONATxs3m7tium8Cbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB1esfw+AQn4L71LKtEI7G5IsHxU90+3ESmgRJhLOjg=;
 b=0KZFXI54tek1nImpJ61rkxkGJ5/9/JEJ0xi/+/T6phZmrVsVulvbNyhRU5YkZeu5V8ivdzhosOmJh9e7loBKiyD83nEhYhTO/ukRiM2yA+fQXDhQtdT9TA4J12qvbn6fRy/J2O6BL3jf4ywu+ODT8AP5kwV4m+1qab/8qr/MezE=
Received: from SJ0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:a03:33e::6)
 by PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Sun, 13 Jul
 2025 05:08:10 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ad) by SJ0PR03CA0031.outlook.office365.com
 (2603:10b6:a03:33e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Sun,
 13 Jul 2025 05:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Sun, 13 Jul 2025 05:08:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Jul
 2025 00:08:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Jul
 2025 00:08:02 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 13 Jul 2025 00:07:59 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <shubhrajyoti.datta@gmail.com>, Michal Simek
	<michal.simek@amd.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] EDAC/synopsys: Clear the ECC counters at init
Date: Sun, 13 Jul 2025 10:37:53 +0530
Message-ID: <20250713050753.7042-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|PH7PR12MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 58bac77e-3405-4cf6-627a-08ddc1cb4296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cIaNAtjVIkFMYiYGILX9Z7VyI7HlGyz0jV3YqYpfIaBkiNMlyB5kobwPWder?=
 =?us-ascii?Q?QK1ibl7efG4vrJoweyGyzhpUERyvBqMUvs/awgItYvTYGsiwUs84cHsYDKSX?=
 =?us-ascii?Q?2pWp0XUvwbIOoMChYX+2QcrjLGWEwhJ+GfshbiJX3ZWpqNwYaXJFaHSzMffT?=
 =?us-ascii?Q?ALF6ad46Wt2JUCpGhMrG9+Pnqef7ki/I5GEmAUIyHm1KHxR4AqjrzxQRjcRv?=
 =?us-ascii?Q?zflkShoBWbdgFVrKZHR7f8HzS5oTaOZ26diLkCzL+I4Hiprt1dy5+Oe7YXJK?=
 =?us-ascii?Q?IP1Wnf5GbBDrCPqfS8/P6+b4Vp1aWCf5q5XqrQ5JRYSW6rnyx8g0E2hVvd2E?=
 =?us-ascii?Q?T+3WYULgshjXgaR6sUwtqDYdgv1uhAGphP8qKxC2ftpVqU/Qhhmabhc+XpTb?=
 =?us-ascii?Q?M9Bmyhz4Dglgg9YxYk/Sq1GKdP7RiL7Fgq4hIJS02oXyHBM76iN0mfR6Wk+c?=
 =?us-ascii?Q?/AurGL6ow6yKxnKqCqgJK1wHGzD7mrh6giKCPq/02e5G2CvDnYe7Q6b+z0D9?=
 =?us-ascii?Q?eZi4sK8nwUiJWwZZVIvpLC38TWUFHxgJF0vZKf9ECmU8G0HPjvlopl71P0qB?=
 =?us-ascii?Q?8c6M0/TkB2MyyOk+FDvFJCpY8TxskWw4zxVKT5kRI1OJIg4JE8nZbHMtevys?=
 =?us-ascii?Q?AD7z60YCLgFqGiMAbC9655vAzklD57iKBtBrruj63pbg/AUtHzNZxznkyJye?=
 =?us-ascii?Q?BVrpxRxexBgBHpyiWS9HWP/TRw19QzE3b7X5s8Ti2TJudeTe45bntTNZbZVV?=
 =?us-ascii?Q?nNacvKO4QH7GesIsXjxjdknHzA1GLcrpTdjycUiGjLQ1EYkwRSoXky9Q/ajg?=
 =?us-ascii?Q?yBBV3GWuH0msAnjpn5QGbJux4WpRP9QvNEPrU8gHlgQ5pgACGVueBjNphKnM?=
 =?us-ascii?Q?BHaWuSZD0BcX3IwNFrpeKGW5O0Z55Lt3XnzDtF2qNDLP/Jy/ueoLKy8p3+I5?=
 =?us-ascii?Q?RaAJj1nQSMkY2lnHAWXYoNV2dS7+HO2EligrtHe+CRPNdAm2eJj2oK8x8WM2?=
 =?us-ascii?Q?c1x6bdpoeBn5weNX5FW8bGJ/rNz0JHRRWQhv1hZuNeZDP0zXD825gjmvuMge?=
 =?us-ascii?Q?oJs7/+g4mvsxQUss97rl2mCdakwVKhDAnvTy81JhCBEa4FHloiY9vWmXWZyn?=
 =?us-ascii?Q?6biF/PSZ6bK3pCvBky50i63EjBo/+wz2nCqedvwDWNpYpTEhy2k8cu57+Jyk?=
 =?us-ascii?Q?nlZOaC5XcdjdtWV/4DhI4NDa3Fs/it8fqIO+pWuxnFUxwJ+eUyvx9Pl6hOpw?=
 =?us-ascii?Q?86cQ/ZyEafe2ByISEQugSI8CHhEglPU/cIjKkNPZqCpXI1dnfuxxOJf63gXN?=
 =?us-ascii?Q?7nL35buk31dDYENK9LmaqJ/mAWh8Km9hw/zhb1CTqndAeZg42TukAs/GgihI?=
 =?us-ascii?Q?Dd+hvAhlKwe0AEvnbKklt5QVZx7HFTATTWJQt96dnwtIXUf18NhRyjsQsjjt?=
 =?us-ascii?Q?yCTuhhCZeYj5cQpIN3Y4TQUrlN4AKljI4DbNJw16OHY/unrbot90tkFn0ZTH?=
 =?us-ascii?Q?Us2+NcuMzWen+DeJmtD1KlcZ32XVMeb5/+9G?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 05:08:09.4794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bac77e-3405-4cf6-627a-08ddc1cb4296
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113

Clear ECC error and counter registers during initialization/ probe
to avoid reporting stale errors that may have occurred before EDAC
registration.

Key changes
- Introduced a unified `get_ecc_state()` function that handles ECC state detection
  and register clearing for both Zynq and ZynqMP platforms.
- Removed platform-specific `get_ecc_state` function pointers from the platform
  data structures.
- Added a new `platform` enum field to `synps_platform_data` to identify the
  target hardware platform.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v2:
- Update the commit message
- Add the zynq reset changes
- remove the function pointer
- Use a plat field instead of the quirk

 drivers/edac/synopsys_edac.c | 96 +++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 51 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 5ed32a3299c4..a0d101aa15f7 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -332,20 +332,26 @@ struct synps_edac_priv {
 #endif
 };
 
+enum synps_platform_type {
+	ZYNQ,
+	ZYNQMP,
+	SYNPS,
+};
+
 /**
  * struct synps_platform_data -  synps platform data structure.
+ * @platform:		Identifies the target hardware platform
  * @get_error_info:	Get EDAC error info.
  * @get_mtype:		Get mtype.
  * @get_dtype:		Get dtype.
- * @get_ecc_state:	Get ECC state.
  * @get_mem_info:	Get EDAC memory info
  * @quirks:		To differentiate IPs.
  */
 struct synps_platform_data {
+	enum synps_platform_type platform;
 	int (*get_error_info)(struct synps_edac_priv *priv);
 	enum mem_type (*get_mtype)(const void __iomem *base);
 	enum dev_type (*get_dtype)(const void __iomem *base);
-	bool (*get_ecc_state)(void __iomem *base);
 #ifdef CONFIG_EDAC_DEBUG
 	u64 (*get_mem_info)(struct synps_edac_priv *priv);
 #endif
@@ -720,51 +726,38 @@ static enum dev_type zynqmp_get_dtype(const void __iomem *base)
 	return dt;
 }
 
-/**
- * zynq_get_ecc_state - Return the controller ECC enable/disable status.
- * @base:	DDR memory controller base address.
- *
- * Get the ECC enable/disable status of the controller.
- *
- * Return: true if enabled, otherwise false.
- */
-static bool zynq_get_ecc_state(void __iomem *base)
+static bool get_ecc_state(struct synps_edac_priv *priv)
 {
+	u32 ecctype, clearval;
 	enum dev_type dt;
-	u32 ecctype;
-
-	dt = zynq_get_dtype(base);
-	if (dt == DEV_UNKNOWN)
-		return false;
 
-	ecctype = readl(base + SCRUB_OFST) & SCRUB_MODE_MASK;
-	if ((ecctype == SCRUB_MODE_SECDED) && (dt == DEV_X2))
-		return true;
-
-	return false;
-}
-
-/**
- * zynqmp_get_ecc_state - Return the controller ECC enable/disable status.
- * @base:	DDR memory controller base address.
- *
- * Get the ECC enable/disable status for the controller.
- *
- * Return: a ECC status boolean i.e true/false - enabled/disabled.
- */
-static bool zynqmp_get_ecc_state(void __iomem *base)
-{
-	enum dev_type dt;
-	u32 ecctype;
-
-	dt = zynqmp_get_dtype(base);
-	if (dt == DEV_UNKNOWN)
-		return false;
-
-	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
-	if ((ecctype == SCRUB_MODE_SECDED) &&
-	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
-		return true;
+	if (priv->p_data->platform == ZYNQ) {
+		dt = zynq_get_dtype(priv->baseaddr);
+		if (dt == DEV_UNKNOWN)
+			return false;
+
+		ecctype = readl(priv->baseaddr + SCRUB_OFST) & SCRUB_MODE_MASK;
+		if (ecctype == SCRUB_MODE_SECDED && dt == DEV_X2) {
+			clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_UE_ERR;
+			writel(clearval, priv->baseaddr + ECC_CTRL_OFST);
+			writel(0x0, priv->baseaddr + ECC_CTRL_OFST);
+			return true;
+		}
+	} else {
+		dt = zynqmp_get_dtype(priv->baseaddr);
+		if (dt == DEV_UNKNOWN)
+			return false;
+
+		ecctype = readl(priv->baseaddr + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
+		if (ecctype == SCRUB_MODE_SECDED &&
+		    (dt == DEV_X2 || dt == DEV_X4 || dt == DEV_X8)) {
+			clearval = readl(priv->baseaddr + ECC_CLR_OFST) |
+			ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT |
+			ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+			writel(clearval, priv->baseaddr + ECC_CLR_OFST);
+			return true;
+		}
+	}
 
 	return false;
 }
@@ -934,18 +927,18 @@ static int setup_irq(struct mem_ctl_info *mci,
 }
 
 static const struct synps_platform_data zynq_edac_def = {
+	.platform = ZYNQ,
 	.get_error_info	= zynq_get_error_info,
 	.get_mtype	= zynq_get_mtype,
 	.get_dtype	= zynq_get_dtype,
-	.get_ecc_state	= zynq_get_ecc_state,
 	.quirks		= 0,
 };
 
 static const struct synps_platform_data zynqmp_edac_def = {
+	.platform = ZYNQMP,
 	.get_error_info	= zynqmp_get_error_info,
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
-	.get_ecc_state	= zynqmp_get_ecc_state,
 #ifdef CONFIG_EDAC_DEBUG
 	.get_mem_info	= zynqmp_get_mem_info,
 #endif
@@ -957,10 +950,10 @@ static const struct synps_platform_data zynqmp_edac_def = {
 };
 
 static const struct synps_platform_data synopsys_edac_def = {
+	.platform = SYNPS,
 	.get_error_info	= zynqmp_get_error_info,
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
-	.get_ecc_state	= zynqmp_get_ecc_state,
 	.quirks         = (DDR_ECC_INTR_SUPPORT | DDR_ECC_INTR_SELF_CLEAR
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
@@ -1390,10 +1383,6 @@ static int mc_probe(struct platform_device *pdev)
 	if (!p_data)
 		return -ENODEV;
 
-	if (!p_data->get_ecc_state(baseaddr)) {
-		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
-		return -ENXIO;
-	}
 
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
 	layers[0].size = SYNPS_EDAC_NR_CSROWS;
@@ -1413,6 +1402,11 @@ static int mc_probe(struct platform_device *pdev)
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
 	priv->p_data = p_data;
+	if (!get_ecc_state(priv)) {
+		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
+		goto free_edac_mc;
+	}
+
 	spin_lock_init(&priv->reglock);
 
 	mc_init(mci, pdev);
-- 
2.17.1


