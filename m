Return-Path: <linux-edac+bounces-1229-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 232598FF5F0
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 22:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1461F249A2
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 20:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B719882F;
	Thu,  6 Jun 2024 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pR74VZue"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A7513AD0D;
	Thu,  6 Jun 2024 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706027; cv=fail; b=Ab/77+f1Bqw3w31Wb1riYiV4sWsyIy6aoEAYxpbYuX0UWzAK6bbAxdgiZaOls7Acb+n9y6zEeqhm9fwETei8i6mVLRE4D9B5gsTLZOwEaieMTTaUVaWjPnWr/TQSeW1EKHmpgvSjE7cN9g72mC6vrLSPdQ0IxPxQm7FNMP29xPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706027; c=relaxed/simple;
	bh=ixY3ATydXDQApvU1/2THonIPKkNLWbOdM4kXv/TSnwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnmWzOWTbpuutpJpqq37OOtbUf6rhSgDtu9ogM5zNmaE0tJiQSAqFA+FlbfJcoTM22KVdyjz3poNo/lILRfe/5MYvGa43udVK5e0iR0hILk/v7MZgt+Tb+OB+eBtcvzdT9jNAqhf09IVkhkC7h0Zv3I1CHTtVYdP3DLNC7D3vQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pR74VZue; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYEop3nJkA2miRY+KcS2DmtCmm6aRMj32PZ+oV5wytWvPimAZ6RPuW9iAnApV+OIV3tS4XCR1HajjIcMYWnLktpYG4HrYZEUzzfF+QlHC3gt2B8oYS4Z6swHH/HvCP1a2Zus5KaOy1qPftt4sbaIyPE07xbZ82hjTRLZavfeeaWe7r+27YdQQ7Qsb3uW31w5h9LWuTZHUT/cQoA/yDWyIfKFiXR7Nf9jXbzefOHuRfjs8R4O4jU9VTJAAK2Qchx+zoUZ9a7YUYIiJTFdkMcBTAjevkA76P4rbaOOq9+Xwv2JalZeNqgo2FVS4ubLyAq37RmSQ2MbIrY3L2t3fh2izQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlKt1Jaq3MzbwLZey7d1f47qFEUibfRfXzW7CCeLHa4=;
 b=m2MTq1JAor0Svqr7cSxrChIn6g96ZTlU2Q6HYj9lynCElCHW3SkGG0NiRTmVULkd66cF2pWrWE635v/UaFsJdqCZPbmgyF5C+AlAQYcm4JwkhYf3sZZ2OJ9QwBLRxwpp6JWDX0dfvtQl0gJJ6MeQem+NHxOaZGVFWIw0LXRmzH1CZgxLeHbhXyW8jwAbfNFI1mmVAFrNPJeSVdtUSXpCaqoxrFS2SroJk+fhPu/OnFieHWJizOqFFSCDl24pfhxG+3TVxL8muI3bTH8est1AKqglcQncq/+Imddc4eWSzi4dJKtrBf9fvO7ynzhBify9ODw/l6gx01i2ycE4Xs6wcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlKt1Jaq3MzbwLZey7d1f47qFEUibfRfXzW7CCeLHa4=;
 b=pR74VZueWK+n+q+s3EUFsZl7yfkN63/hrmP178nqGlihSrKNO64xJS8jbGMtX0OdZh+eHm9Yh4QmTnIJzBEz3vEwCRgoB1bQvx8sTJSIiaSWixXzJ32DAP74o+h3uNxFfUURHszUzSAV2YZbnQpNJv1lKSRP+47f3X3T/DJucl4=
Received: from CH2PR19CA0013.namprd19.prod.outlook.com (2603:10b6:610:4d::23)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 20:33:43 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::a3) by CH2PR19CA0013.outlook.office365.com
 (2603:10b6:610:4d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.19 via Frontend
 Transport; Thu, 6 Jun 2024 20:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 20:33:43 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 15:33:42 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v5 2/6] RAS/AMD/ATL: Read DRAM hole base early
Date: Thu, 6 Jun 2024 20:33:09 +0000
Message-ID: <20240606203313.51197-3-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606203313.51197-1-john.allen@amd.com>
References: <20240606203313.51197-1-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: d689fc4c-9e9b-448a-9fde-08dc8667f515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?row+NP2Uv0qa0t1/s6GJdQrhCZXlX9uCFc4Qkl2917SRpURalM1c9evntjhD?=
 =?us-ascii?Q?RiFp7StFAUChifW1Ke6WVgMb6qVCAg1l3fuLOfieyJbM8CjhmR507i6IPW6A?=
 =?us-ascii?Q?qAdejqnegWbQNedIQ0VZLswuUGiUm523ftce6Jxc9JlhlFSa+rr2Rk8/luL9?=
 =?us-ascii?Q?inLgGg2aVmJHaXO9z3NWqNarb/iRjZNibsz1ZtBU1umt7XbN6k6LGc1KWmiL?=
 =?us-ascii?Q?NZsONPyeOhKXP8KY8G2oSTthxbYXOaW5WSTAJ0u6sdk7Jvxn/uRUGVs3RrVG?=
 =?us-ascii?Q?7FQllT/MSrmPr0MQmwu8fDRkJzCahJ4xt9Hs/5Gxpuj5dXNU6S5wGQhDmYS/?=
 =?us-ascii?Q?hbLCyCYfd2eOlM5JnrIhw7JGqdHerfNjhJgTz8mQHMAtOm60Y4RS3O0nq1Ug?=
 =?us-ascii?Q?oIu+hrviOeV8Tk7x7hHxKQRUGEPdJhTHGUt7XPlYoJP+VH4sGKXOjpzbL1bf?=
 =?us-ascii?Q?k6asyNGgWPBixjwozNNFCMArRYa2eJPYAofzSDCf7soEQ6QikCiH9wHA6eey?=
 =?us-ascii?Q?KhyhWAy3g9OIIMmQzY2s10DQxBWjbTAYXOL2qcJ5zBIbVkAOwrcQo/UyO0Io?=
 =?us-ascii?Q?ywlhNB/TbP9sOQ3+sgX7BLNuNBbsnlMkhSG//y6CuDNuOF4PbeDyYm+WXW4j?=
 =?us-ascii?Q?ULwEt3nzQ2cUx4KBzuZzMOUrrDU14+jOiQ8LIb3euk3Nsy/H1A/F/udyDXqm?=
 =?us-ascii?Q?JbWzSwrRmRR3fqBQGNHJeW2Ib9HB9YAGRfklE2DIgmOPMapV09EMEAxxUSJd?=
 =?us-ascii?Q?ffR7gIZhnAMzAH5zj9zulTGAvzEhFTFcGoU2oTwfFFAb38AZXd4Jznelyab7?=
 =?us-ascii?Q?o7NOC8+aXQ/Ph6F/i9PfUkCDIzhIH7ANvPqkSHtASbIyC4EEz53EoKMnY51b?=
 =?us-ascii?Q?d1zMhkahW3MGOeINJrL7Z3ijeLWzWgUccJBJVvb9gt6xSc8EUDVDThygpENy?=
 =?us-ascii?Q?CyMOwFqS30eefc70KIh1eYeUHDyOSFyQjABguKKqX4QRtqNsfVQi8oiN9U9i?=
 =?us-ascii?Q?RWrFg44IRSObYpxvxuNkucuoC0Thz66aw+Bj86OKhWT+LwUdCUk5OyuKWUpF?=
 =?us-ascii?Q?n/m1EvIyIQ72HqkQW1f937bAYnHBbeKnfXIRl1rcB94WDowOFy0QmjupqB1d?=
 =?us-ascii?Q?ry0UEIRS6p9L5kqWJyBLiO+Em/1mhfWyPJ/M69Q0gple8AlTzIaDpcas2rmd?=
 =?us-ascii?Q?IPqo4P13ohGZPsDyEdvUTN3Ees9w3a5tfZy/ViBIDc3yH6/rq6IaeQXcLpX6?=
 =?us-ascii?Q?nTzdHlshcWNQzvxQqXlx6kV4bO9pXuK+V5C5+52ViqZsCPVKy3GniaYYZK0q?=
 =?us-ascii?Q?/DOJNGSaiE6BQ7Mu/iKyQJtxBSTb3ogXdBGGqHuRIGAHW+tRgGJ5ZCHlOXBU?=
 =?us-ascii?Q?O+wlHw/zS+szkXzCJsSsdWRA5nLkyBAxZsVWFAOX3Nicn+BQhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:33:43.0418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d689fc4c-9e9b-448a-9fde-08dc8667f515
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429

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
v5:
  - Don't fail loading the driver if the DRAM hole base can't be read.
    Check if the hole was read properly at the beginning of translation
    and fail there instead.
---
 drivers/ras/amd/atl/core.c     | 18 +++++-------------
 drivers/ras/amd/atl/internal.h |  2 ++
 drivers/ras/amd/atl/system.c   | 19 +++++++++++++++++++
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 7be4982fdf19..82f77f129d54 100644
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
@@ -125,6 +114,9 @@ unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsig
 	ctx.inputs.die_id = die_id;
 	ctx.inputs.coh_st_inst_id = coh_st_inst_id;
 
+	if (legacy_hole_en(&ctx) && !df_cfg.dram_hole_base)
+		return -EINVAL;
+
 	if (determine_node_id(&ctx, socket_id, die_id))
 		return -EINVAL;
 
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index cb0f96040fbd..3596ad5ca3e0 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -135,6 +135,8 @@ struct df_config {
 	/* Number of DRAM Address maps visible in a Coherent Station. */
 	u8 num_coh_st_maps;
 
+	u32 dram_hole_base;
+
 	/* Global flags to handle special cases. */
 	struct df_flags flags;
 };
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index 248ea493b841..8423c9f3a8d2 100644
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
@@ -282,6 +298,9 @@ int get_df_system_info(void)
 
 	get_num_maps();
 
+	if (get_dram_hole_base())
+		pr_warn("Failed to read DRAM hole base");
+
 	dump_df_cfg();
 
 	return 0;
-- 
2.34.1


