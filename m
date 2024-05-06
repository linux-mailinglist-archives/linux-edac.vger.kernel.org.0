Return-Path: <linux-edac+bounces-1005-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871138BD1B8
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 17:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047411F243B1
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 15:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B6155728;
	Mon,  6 May 2024 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YZQnpgIK"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F211552FE;
	Mon,  6 May 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010389; cv=fail; b=l8Knf/N5yTteJ7To+teh3oidaIui1zv6NIOmj93UGPtK2Kbk0/RQdTXYJWjCkg1QdHoliBCamXhr7PoiFlIJymOw1FXne7AHUOohA7F3JzhoJA3gLJzc8qAcptQd2tN7fDtu37tFKIl+T6oxmXUqGluDQpflxRzMZutdlUrfQFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010389; c=relaxed/simple;
	bh=nqOYKSB+ZoMZ7w7B7CVjMVQFtupimE29pbNDldp1F0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OF7ed64AfZd6pmsE3Oj686UczvlnoSvarjyhZCPFTCf+2T7SOtRPx4mZeRIcT3RuIPRqVVN/4ionFnTWfphc8RLToU/MLWcUadsDLdGS0+V6s9FHwDYYMt8NekGusTH1uXhAyhuOfvafkYncBX9teMC7FCYn1WxPEi22z76FJZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YZQnpgIK; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6kP0D54OX/kk09GiDxASm/cCniSgdgEcaOd731/joiq82AtJCY0WH1v/WrsiX1uY7lAs56brqDAy9K28Sja6cEtjpTA2gze/iUrFFwqeR3u353ltLHDvOKYlSOzu+hsqNY2x4WpFydkdim2GtjqWTgHNABWuF549+PJDL1rmwRuP1cdo3t11UG0Xq9CfOeZUqGRLEkWaDEzQms1K+1vy0AcRB1Ah053X9XYNmYwAQkLC9cmRfbuqeIFey8PTRvb86z6OYh7BWhpFAb0x8IrFkmbN8x5Vc33Ma9OmW6zfBxVpnzCSZCLoYQGGjM+qkT6V1TepmjFsiWCBJUwr0myZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUYo/w0e7QHmMz8kLIdVA6AkR25hUEhMB+DWEKHiu7U=;
 b=a2DNyusn2JcJPNjOBznAPJW+pp9mp+RqNc3jKSI/XQfbWJnDSjlK8UgqkoBsVuR3AK3Uyk0a/YVJOLfu+QIx7UeQYJa6GLWw8FW9xnjicrfMavlCceu6Ojy5tc0PYOW88RXW/ALIo0F1jPsHSwnwE99jOXhde1EJ6Bx6OJSy4eTFa2c+1W2/d7rURfgLxUj653kh4bpqMVXtkMVz3SCM3h+p5IQ6fTg3USADyYMQS4UHAqrLxqSE9IaDXfC+8pcHtYtZfNxxJ2IOcqQgf0lTJFmghQieZpba0Puiof9bPlW1CkATLFEw4EMFgz7z7uxbqH4sr5b6k7Z8zipzPz/GUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUYo/w0e7QHmMz8kLIdVA6AkR25hUEhMB+DWEKHiu7U=;
 b=YZQnpgIK5b+IJg+lG5OQyz3WsunN/+G4Jgmq3uuoiue0qRulECUfQZ8j32gb9rtOj3Ssu3F7yM45vfSob1PA7+hQYNK4EKmyEcjtM2G81G6I9j2DOj6L/K21CUXM0XyDqsQg0X0IJc2s9YxaeEOFXJ3yXZuQJJ1IaOQzgoNgMdU=
Received: from SA1P222CA0072.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::28)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 15:46:25 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::5e) by SA1P222CA0072.outlook.office365.com
 (2603:10b6:806:2c1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 15:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 15:46:24 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 10:46:23 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v4 1/4] RAS/AMD/ATL: Read DRAM hole base early
Date: Mon, 6 May 2024 15:46:02 +0000
Message-ID: <20240506154605.71814-2-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506154605.71814-1-john.allen@amd.com>
References: <20240506154605.71814-1-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c37b799-7aab-4939-d1a9-08dc6de3af96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ocNT+nMRG8BVNriGGAdPrsuXLrfC2F7rszAcVBejkmzjfQemV8T1YBTAlY0p?=
 =?us-ascii?Q?FqQB9hy3DJ+KGSW6wsGSmrmUzSooMcujhdSpExSCTKMr8o2IPE24lsLRj8UL?=
 =?us-ascii?Q?os9y20WGBxp+OrPmTe7dWuAzgKN3P2q5+qIWJsSCAcavUzJEHZPkwu20mORz?=
 =?us-ascii?Q?y7VEGJjJ8WesK1aP4Jm70/AzmboDgFU2An+4hrnBzgvH2m7zHO4VZWudJcVq?=
 =?us-ascii?Q?xclsJFHs/iixXrRAfbuVf7+/0FvobTbZTQhKtg1lxnmGM3XbNiCZ6ddHmLVa?=
 =?us-ascii?Q?FeQvgxC7DedFz/UwwwUVbEBkr5a9YsvjiBTt0P9WOQd3QsOkeaOkhfx9CmCO?=
 =?us-ascii?Q?lsSGlxcjNadLYCzi1SEeDvU49592e9TeFvPw3iXgZ30/q+l0VNsaIMLrIIn5?=
 =?us-ascii?Q?O71ATfEc7WZQihvMtwaM/eLi3H+EqPLCE6M/sau4wfw4/oZrD8MHKw3/E1/9?=
 =?us-ascii?Q?wNTNDGcwzROXQkmkiWYn3A4wDsu81rH6fmPtMWLw/ZTPZ3VENPGETQ6S3FRk?=
 =?us-ascii?Q?BntyaMbI0x/q3DiHnNPumGpMuLaL98HkoTWJDhjFErPKf5qsCHW3a0nDnx8O?=
 =?us-ascii?Q?Bv9Xcmp3E830FxQ6i5HcDc/6+F6wiBxcQmsRBubUmjMlMV7gG2xxEQ3u0IPg?=
 =?us-ascii?Q?EbmiuY6cF3rG6e+JZopb08Lh+cZAwbumEjd1FK+flelY9tdXA77fzLShH2Ll?=
 =?us-ascii?Q?v5CYhmhymIM3z/2qnO/rcs+PHB/EzvHnBHpgqY9wk2vDhIaYTdWQF5GkXLjb?=
 =?us-ascii?Q?8h7ElBSaN8dh9uCt3HzSyBDyt+RfI+hzMeNVS+xPAoU5myHmwK9g/jkkQ1x7?=
 =?us-ascii?Q?lVrcrpZBOJ9ZYQFwehb5cmbfKwvjI5hD2PGh2Eom/r92M0K9p3lSRQXB8/Fh?=
 =?us-ascii?Q?Bp4ZiLuqvkEug//FE0LJ8dUSN0I6N3mMuBRu5Zkg1xMBA4wsY650xRRVgxi8?=
 =?us-ascii?Q?G/jPmXN3rPvEA0qG/vNlGopMv1R3b/UQ3imVR9p8KfydUNqgEVccHSQkPFFh?=
 =?us-ascii?Q?QrKVT07FBfHgnI3NjjNGCojijZUNlXeEKiUjtM90cRnFi9pkXOgD0W4/g+al?=
 =?us-ascii?Q?aKH7TxD6omxkTMx2xRpnXf4n+HWmHKMoRIppauGygH9b8a5KpKvFqbbjFVD5?=
 =?us-ascii?Q?/bkDVj3dK2qjDxtdDrZ7jyWCV/JPEr7+ge97yZVWjG0KmDpbcKXIb7EtK7/z?=
 =?us-ascii?Q?qlUwSLuULbdbRiRdmDb7CNeJ33QJJTvtspcosou2xB0I2FFGOo5cXULLtmas?=
 =?us-ascii?Q?OfvADLiN8RoMA+cPqJmSrLd8QBPMo3OF9lySKE2QSDZf6H8BEVZ6kMCO+3z4?=
 =?us-ascii?Q?4VqtS6cMF8A3VMO0TLkCts+2/DARUc8Y6twHO7NMukbxmdV8X41jJx8aikqY?=
 =?us-ascii?Q?XsgrBqnlKTpVW/1x8KKcEPzDGg+U?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 15:46:24.9887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c37b799-7aab-4939-d1a9-08dc6de3af96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093

Read DRAM hole base when constructing the address map as the value will
not change during run time.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - Fix compilation error. ctx->addr should read ctx->ret_addr.
  - Improve commit description.
v3:
  - Include "0x" prefix for dram_hole_base print
---
 drivers/ras/amd/atl/core.c     | 15 ++-------------
 drivers/ras/amd/atl/internal.h |  2 ++
 drivers/ras/amd/atl/system.c   | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 6dc4e06305f7..63513d972c07 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -51,22 +51,11 @@ static bool legacy_hole_en(struct addr_ctx *ctx)
 
 static int add_legacy_hole(struct addr_ctx *ctx)
 {
-	u32 dram_hole_base;
-	u8 func = 0;
-
 	if (!legacy_hole_en(ctx))
 		return 0;
 
-	if (df_cfg.rev >= DF4)
-		func = 7;
-
-	if (df_indirect_read_broadcast(ctx->node_id, func, 0x104, &dram_hole_base))
-		return -EINVAL;
-
-	dram_hole_base &= DF_DRAM_HOLE_BASE_MASK;
-
-	if (ctx->ret_addr >= dram_hole_base)
-		ctx->ret_addr += (BIT_ULL(32) - dram_hole_base);
+	if (ctx->ret_addr >= df_cfg.dram_hole_base)
+		ctx->ret_addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
 
 	return 0;
 }
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 5de69e0bb0f9..1413c8ddc6c5 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -132,6 +132,8 @@ struct df_config {
 	/* Number of DRAM Address maps visible in a Coherent Station. */
 	u8 num_coh_st_maps;
 
+	u32 dram_hole_base;
+
 	/* Global flags to handle special cases. */
 	struct df_flags flags;
 };
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index 701349e84942..a4314f5073ab 100644
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -223,6 +223,21 @@ static int determine_df_rev(void)
 	return -EINVAL;
 }
 
+static int get_dram_hole_base(void)
+{
+	u8 func = 0;
+
+	if (df_cfg.rev >= DF4)
+		func = 7;
+
+	if (df_indirect_read_broadcast(0, func, 0x104, &df_cfg.dram_hole_base))
+		return -EINVAL;
+
+	df_cfg.dram_hole_base &= DF_DRAM_HOLE_BASE_MASK;
+
+	return 0;
+}
+
 static void get_num_maps(void)
 {
 	switch (df_cfg.rev) {
@@ -266,6 +281,7 @@ static void dump_df_cfg(void)
 
 	pr_debug("num_coh_st_maps=%u",			df_cfg.num_coh_st_maps);
 
+	pr_debug("dram_hole_base=0x%x",			df_cfg.dram_hole_base);
 	pr_debug("flags.legacy_ficaa=%u",		df_cfg.flags.legacy_ficaa);
 	pr_debug("flags.socket_id_shift_quirk=%u",	df_cfg.flags.socket_id_shift_quirk);
 }
@@ -282,6 +298,11 @@ int get_df_system_info(void)
 
 	get_num_maps();
 
+	if (get_dram_hole_base()) {
+		pr_warn("amd_atl: Failed to read DRAM hole base");
+		return -EINVAL;
+	}
+
 	dump_df_cfg();
 
 	return 0;
-- 
2.34.1


