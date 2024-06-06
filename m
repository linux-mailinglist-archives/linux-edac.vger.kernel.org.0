Return-Path: <linux-edac+bounces-1231-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C188FF5F4
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 22:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B039AB22735
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 20:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A65219AD6F;
	Thu,  6 Jun 2024 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b+HFwjhj"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3919AD64;
	Thu,  6 Jun 2024 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706042; cv=fail; b=k5d8cqOB1tq1bNTcXoYt5c1mxGs5v9cMlrAsDsgr/TO5alOXBZFJqm1Y3nmIHNwLtWSqD5p8P8YLIh1w3jns0qmUxQmZiFCzslvOJho6XLcG6EyYaDt2Com/JrhcFFdsqf/IHWDIyYL27LZPWbOgT34laX262T/MKkJzAxTCbGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706042; c=relaxed/simple;
	bh=eAWb7WkzuMa0uv8d/SidCwyDs4Ngu7vb8BAnqvhOR+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0f9AE9bI+WPzE3iCez8xSh2rPPCN/J0s4Bkpoy9wPVpgBo2pM7jZIap5y5xPNVTWawDENCcgk+xm8+8PEsjJdm4G26bWaZjnSgJChTpWK/tnmZwp7Xs2qQL63fVaL2kp986+tnHn84gTcUqvLpwyMv4LouMb1hEpiko9ATddH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b+HFwjhj; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHD/Dxt8Y/LtG+mRAYkxq0Mvec6xAhcGxNkIDdnnxeaF95rcCO7iX90H8SYUDQvYmeYt9cAgSPwzsmsJ2kKpxtHTjNSkgY1R6kKSbm8fJSxvWK4vDGr/w1HyTiEufpFUSo5NnrdOumiSJc0EpbW2Sa0q7IvK5vkflD7SXB/1IYJKEXKm2rxhWozE6jvNN3JSH9sJZE85/BZ3EAVjCKLk6oC4uHtoDzThpJS85taCP7mWNLkjyAginjpppT8OVAaE8p3DLvrFzfwtGbrczos6nQ09a/XPg2A+0u3dGhHE+pu3sWgpif81viv0FNh8/J8gzzzFR2wY+glltqHs1/jP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOCfvWhm6ib3Sq/M4H+4rNFDKcZh1Xpj/OCyUUYJZe4=;
 b=Wld0l1PNqbPRmvI2qpP7AQAyefLQXfYDhHJl0SshO1WALbseuWIbywA6P+DC1hTMfudEZvwZGrYRRa0bZE4K5cRclrJBDxhT+qWN3QRkY0fWMz8dl9PmtRUo3oBECU3YCc4B29pYxptoLAZVCFx8vZ5Hz4jvhSyl8GOtSTnX6UTFyhl64o0NFjKY8YAKU+diIGtKJXOQ1rE7Tll3MRSrHf2frOl6RqhgrMGJqFxXTL+GETgRArupi9+YPHePkPcBoQQoO8BXUJbXvoL/Eat1WGFEwZHirTlfoJeuepC1MAsxTaoC3S2KibmqK8IgKKRUTyXaF+kgGHfFhmyrY5juJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOCfvWhm6ib3Sq/M4H+4rNFDKcZh1Xpj/OCyUUYJZe4=;
 b=b+HFwjhj0Ddk5bbSKejpY7/Y4LlzcqX1ZU19hKsq1d/BHtlZW///hO/yVLd5zXOu5CElH/EeF9ay/BLAFdQ+NCe5OkTuBvde7vlcYZ9nOnkn9ci7ipIEayY6j1bS4hZ6x5crNw6MHHaW7o29AFuTwvWLKVHDoiclMGc7Fepzq5U=
Received: from CH0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:610:b0::29)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 20:33:51 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::59) by CH0PR03CA0024.outlook.office365.com
 (2603:10b6:610:b0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 20:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 20:33:48 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 15:33:47 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v5 3/6] RAS/AMD/ATL: Expand helpers for adding and removing base and hole
Date: Thu, 6 Jun 2024 20:33:10 +0000
Message-ID: <20240606203313.51197-4-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: b53e999b-bba6-4337-0a49-08dc8667f880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qpFOvEfxS828mNnW6znTNjLYlz2YiFD3sNbhwuQj4a9R5+gOIofdbNnoJesw?=
 =?us-ascii?Q?7O0Rb3EbXp9Uu+PuvgdOj/1NuZVGL+XOQCwG7HIJbb8/uoKBPavZ0qHJujHA?=
 =?us-ascii?Q?UUkERxEHOVGvLW1iWx5trwJBmIr0vDCVFN5Q9Cm3p/d3y7RfejLe4aAe/9sY?=
 =?us-ascii?Q?Mx/FgK3Mdnjzc1zYYdqJDcGrbXW6ZH1Xo1uTGmoDG+WsdrYPaQZ6Qud0SjTK?=
 =?us-ascii?Q?A3fvCQH3981rW4hB4MbfT1ed3UFi+EFrmeqZXXkd3PWQhqTEdlT+VxyFMZ2v?=
 =?us-ascii?Q?gckdnfNjnKl3VbvMKv4fnGlc0/zPQgnhrOqNuzqh3dNRJZ/Sc5zso6KG41WE?=
 =?us-ascii?Q?WT7Ol2Xp33/L2rt+zTwL/ET4NEP5cx9dsFiNp3xNMGOXMeO78KFkt8sJPjGI?=
 =?us-ascii?Q?+6gJZKjmDKpHq/6hndNHTdy7FE7Kq21KrdVIB2vXEHll9zjyB/lM5hL61z2N?=
 =?us-ascii?Q?PPRcnsHMvRsw2xSjdv+/V5zle1hvSuqBehbS9fHIlUyOG2rXjemRDRW2u6qD?=
 =?us-ascii?Q?g9CS2c4EipxKyZ7V+GEeYZAHwk3yigH2fZb0wE7xroFJymKo92DRTRzG3mVN?=
 =?us-ascii?Q?dwDhH0ELRsWTlxsqgV4CIV2UqFLok9ATKWVfFV0WhgUWOeOgo2WYeH81sKCY?=
 =?us-ascii?Q?yWX1/n7AKtlTLUW6rj6ywEkJeKvv/wAWVorGW7/KdMHyX9/ombAGaJdg/TYw?=
 =?us-ascii?Q?UZmfdYD8siypNVjRphHddDxHterE2Cs8EFZ7iiaUsC8dGPFf6uLxuKZZJ5Ni?=
 =?us-ascii?Q?F6g6V9um5inn9pKOoyOgzJc1Es2GMCoUbevHahkUuHKmAKNCoLcn6fV5GDTR?=
 =?us-ascii?Q?zjySpccb5b21tzr2mqDA0fYt6UQaetL74qFVbAjYxnlYFugtFK93B83v19ND?=
 =?us-ascii?Q?Pi7qPGxgOxchNjPVZdK+5XLWCNPe7eUdUdzCM4BGyvJF8WCO9CnX+7nmvDzQ?=
 =?us-ascii?Q?WXkLVERtR/uPtO7AyZnA125EY5VVSkVkFv1StRLa9K0AF+XG+9O6mEc0d2xT?=
 =?us-ascii?Q?UhwQ3ZsyOq8jU4kOeZQ9vgstfFnw1HI1U9lapIunB0FtRjxYrMwwXKwB2Eba?=
 =?us-ascii?Q?BG/hxZIf0/e+xf4T1F0qOWVf1TltgF5oC5imt8F17k97FR7gePGpsVpsYtPK?=
 =?us-ascii?Q?t5kBkrtCAQZSa9oTH2iaXiZoJcdegJ+1sHYw02IUGzYxLPJvdCWN2+27IGZS?=
 =?us-ascii?Q?aG41qdE/lIrPK+RoYfZn32Hs4x/v/YFOBi46jaPPURJ8uL0E7rU3QDVzegsE?=
 =?us-ascii?Q?L+58SWa39HI/srOL1TFciAcrpVsGm8vdvHMLSw7/eJPcvwG88xnbixNYFQCw?=
 =?us-ascii?Q?BVTwIGLzVopec4fl1qQO7PMnEpT4sxCuKJ/1Zu9QDMnZBy2KndovmAjIm/1/?=
 =?us-ascii?Q?Vp5Kf+KkQtS8Dal/Sg1yT5AKq1jTAV8doAH2+B+ngsVJ6W+t2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:33:48.7880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b53e999b-bba6-4337-0a49-08dc8667f880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308

The ret_addr field in struct addr_ctx contains the intermediate value of
the returned address as it passes through multiple steps in the
translation process. Currently, adding the DRAM base and legacy hole
is only done once, so it operates directly on the intermediate value.

However, for DF 4.5 non-power-of-2 denormalization, adding and removing
the DRAM base and legacy hole needs to be done for multiple temporary
address values. During this process, the intermediate value should not be
lost so the ret_addr value can't be reused.

Update the existing 'add' helper to operate on an arbitrary address
and introduce a new 'remove' helper to do the inverse operations.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - Make remove_base_and_hole the inverse of add_base_and_hole, removing
    the hole first and then removing the base.
  - Improve commit description.
v3:
  - Rewrite commit description.
  - Fix bug in remove_base_and_hole.
v5:
  - Simplify add_base_and_hole and remove_base_and_hole.
---
 drivers/ras/amd/atl/core.c     | 41 +++++++++++++++++++++-------------
 drivers/ras/amd/atl/internal.h |  3 +++
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 82f77f129d54..7cdf7769c189 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -49,15 +49,26 @@ static bool legacy_hole_en(struct addr_ctx *ctx)
 	return FIELD_GET(DF_LEGACY_MMIO_HOLE_EN, reg);
 }
 
-static int add_legacy_hole(struct addr_ctx *ctx)
+static u64 add_legacy_hole(struct addr_ctx *ctx, u64 addr)
 {
 	if (!legacy_hole_en(ctx))
-		return 0;
+		return addr;
 
-	if (ctx->ret_addr >= df_cfg.dram_hole_base)
-		ctx->ret_addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
+	if (addr >= df_cfg.dram_hole_base)
+		addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
 
-	return 0;
+	return addr;
+}
+
+static u64 remove_legacy_hole(struct addr_ctx *ctx, u64 addr)
+{
+	if (!legacy_hole_en(ctx))
+		return addr;
+
+	if (addr >= df_cfg.dram_hole_base)
+		addr -= (BIT_ULL(32) - df_cfg.dram_hole_base);
+
+	return addr;
 }
 
 static u64 get_base_addr(struct addr_ctx *ctx)
@@ -72,14 +83,14 @@ static u64 get_base_addr(struct addr_ctx *ctx)
 	return base_addr << DF_DRAM_BASE_LIMIT_LSB;
 }
 
-static int add_base_and_hole(struct addr_ctx *ctx)
+u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr)
 {
-	ctx->ret_addr += get_base_addr(ctx);
-
-	if (add_legacy_hole(ctx))
-		return -EINVAL;
+	return add_legacy_hole(ctx, addr + get_base_addr(ctx));
+}
 
-	return 0;
+u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr)
+{
+	return remove_legacy_hole(ctx, addr) - get_base_addr(ctx);
 }
 
 static bool late_hole_remove(struct addr_ctx *ctx)
@@ -126,14 +137,14 @@ unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsig
 	if (denormalize_address(&ctx))
 		return -EINVAL;
 
-	if (!late_hole_remove(&ctx) && add_base_and_hole(&ctx))
-		return -EINVAL;
+	if (!late_hole_remove(&ctx))
+		ctx.ret_addr = add_base_and_hole(&ctx, ctx.ret_addr);
 
 	if (dehash_address(&ctx))
 		return -EINVAL;
 
-	if (late_hole_remove(&ctx) && add_base_and_hole(&ctx))
-		return -EINVAL;
+	if (late_hole_remove(&ctx))
+		ctx.ret_addr = add_base_and_hole(&ctx, ctx.ret_addr);
 
 	if (addr_over_limit(&ctx))
 		return -EINVAL;
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 3596ad5ca3e0..f623ac23e4b9 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -239,6 +239,9 @@ int dehash_address(struct addr_ctx *ctx);
 unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
 unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
 
+u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
+u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
+
 /*
  * Make a gap in @data that is @num_bits long starting at @bit_num.
  * e.g. data		= 11111111'b
-- 
2.34.1


