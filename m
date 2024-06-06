Return-Path: <linux-edac+bounces-1230-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 226698FF5F2
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 22:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0211F23A3F
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 20:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61146198E7D;
	Thu,  6 Jun 2024 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HlPSXZJv"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935BB13AD0D;
	Thu,  6 Jun 2024 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706037; cv=fail; b=SEaguQtX06buxbN8+8/aiVYrai25omWPK1wTln6ce0E9mPrpV7CQt5c2u8HVeA30/+MQ/0ZU33EUVshlXzhFMVSwer42GQUvU8WwDWD1sZNvmPTdQILTyDpVBpu0SIWB09WFqdMkO0x8xiNzBlp+uRsulKjkObbEOm8dQY3VqE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706037; c=relaxed/simple;
	bh=HZS3q81HvKzpBK/eoctUUdf2QF03WCm8mxKNH7UQUe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSJaQQ0u82OL5kITlA6ap8UX3AGMH1u41AC4JN05mYW96aAdASa19EoGZXdiG2pdHC01pgd+gfxcsAvUiNX58g67bRYqdWxrVmj0N9yzAG8tUdPUARWtVSs9Qy+c3z1FxbG7jkjnxi2905WFsld5f+a6dwV3wjwSEpYq9PqL/mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HlPSXZJv; arc=fail smtp.client-ip=40.107.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZitRzY53uqE19ma40NmVKVx6j+AKWWZSgN+oDe2qbj/EKtIBAfZW6DUnZu4qKQ//zcgFTB3AhEeiV6p5wUMq1YgCdvfmJoqdBTURqBWnQ8xriVczhugFZHjk7KF4TEATHY7ZIxEmoUv/UoKTBd7ftuXzRH0jQECW5by3ANgfG7DwpFquiL2U1NxKEjp73X5+drSjzM9unyZcwZ6eFUlF3MfwyebX27cl2MCqvwaOsb1QwFtssff583N+8ySrLxwcBeOPso8v9SjMxQehd8NlGih1Au0BauMEdQzC472hlSeLmp0RH2Jasojnuq/60d6BCDiRPj0nbgrCMlby11vbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKRi2p3riJkhUvf2EOJ0WSO41tYfx7BRyhFmYSJqblE=;
 b=m3QY+e7W0CLiI3M00GQDVb66UGxJ6NTJtV3lE/CMi1Sq4loQkz13nXtosqxAt/yWmldGTpQIWWX/dc3+cGOSBt2t0qNe9Su6qSfmUrerWEyN18g8EknT003iAHQgRwqoHPfTJi9X/dMBIacoiBDVOTt5Iybe8VL5PLS962NkrRKaGC3zQIJOZRsV0xp6UdFJL0b7KD/BehSRV5TQtCV78yxbCm9PRohA3vZ1swC4GXZiWPXLrEksGDkUcj9F2buBHbVmI95uO1613SroGwGMjFHNzwaoJRh1eC9NUD7cteZskLGUKgzuLTCku3YgMJpwx0cwvUlKdln823viPasPww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKRi2p3riJkhUvf2EOJ0WSO41tYfx7BRyhFmYSJqblE=;
 b=HlPSXZJv7meMyIWp6I3fDtOmFCc+i0v/0Og4DjjrVApmjv/A3l6syNaAqIhI2p7k+Nn5fJ6cz7KEJJ6l78rlDtRM6rQ4BgWJehEwBjW6vMSr25Rz0ov/QYsI/mLRc86cCQIF5POxnIQxvM9WH4Rf0/YqID3awh4rRXnh98S5ngA=
Received: from CH2PR18CA0016.namprd18.prod.outlook.com (2603:10b6:610:4f::26)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 20:33:53 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::b3) by CH2PR18CA0016.outlook.office365.com
 (2603:10b6:610:4f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Thu, 6 Jun 2024 20:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 20:33:52 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 15:33:51 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v5 4/6] RAS/AMD/ATL: Validate address map when information is gathered
Date: Thu, 6 Jun 2024 20:33:11 +0000
Message-ID: <20240606203313.51197-5-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4aa912-1f67-4822-0d36-08dc8667fae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RTrtLZzdEAbT2vmXWZgN9pwTbXKuDqo7er7bF0pBcwxxE0zTcBLkxmM7RDWY?=
 =?us-ascii?Q?Bmem3h7hE1lUbw1cbdqWMISnbH9dVW5qJAVDVaf+Lm/JpExgVomFgyMCoN4c?=
 =?us-ascii?Q?OtL6HdY7lBvZePt2LUCFuTRClCKc9tMTafk3X7UOHC32U9j7XfaQHTI2C6LW?=
 =?us-ascii?Q?a5fPwpZ6ezMJfnb5MCdnw6aWfuX7HW8QMVypA6D6hrQXRHPVH3f8i6XtHCjt?=
 =?us-ascii?Q?pRreuzh0QblXDKSL1f3G8GX/7QQ/BUfEyneCrzjT8lVD66CTudysqHj/YEwg?=
 =?us-ascii?Q?EsrmTJhK9T5yqrL5EmvRz54aqnDsREiY8YueTngisRCx4k+HZ+kFwJTHbza0?=
 =?us-ascii?Q?wxpnDfJEqxVjloD/CKSHINxlLZEfEq83k57wI/aaaOG9IVOWQeotg23+bP5T?=
 =?us-ascii?Q?Z3TP/sHkoFGktYn079k9RQ1BrXu7WVnmb9hVDyJJwvAs1TL96t1i+G6NYuvt?=
 =?us-ascii?Q?2MTzhDHMg+5Waj2U+0OGnK+HmRfgciDloB3LxU6eB6k4fNi38jUEH4iAzjbe?=
 =?us-ascii?Q?kspC/mkxnugtrR2V3vUO4SDC4oD/YO4kNdtMtkkmsUbj8Qqi4hv/qtsXQyrz?=
 =?us-ascii?Q?rSILJ6gX4SOMwKs+2ci3JQ8edY7p/H3C19UZDBdbLu95hAL++qAfi9r6uM6p?=
 =?us-ascii?Q?65U9aty5+lIgjm76f70Bf30a7HctNPhvVBezeHoy8VegWobP9LfzG2I+YEgq?=
 =?us-ascii?Q?/Q232gKpAfoYqzO6AsqSqMMP9dFqjtoO4LrfRcrj6FSuPJjCzIlvbBuYdXfH?=
 =?us-ascii?Q?FCyyTJTPRVfBE9c+mkG7oZjxybGGpdrMCJDzlYYnKCiGS2cBMDXrwwh+RC04?=
 =?us-ascii?Q?TW6pEgJR1jgUKYDE1adWR1ND8EUWcLkB9MpyiW+l3JvF+k7LVBkkWkFSFrIe?=
 =?us-ascii?Q?PlEgY06yZQd4NpZ5pYKtY/yeUEm8lCE6NT2GQW/aZGpGE+lRR+FcD702KyaE?=
 =?us-ascii?Q?47K2i8JHsNiNbmlAygOrLtjS2WDuraH46qOCkHkcajX0yAobFyGIUd61NtWG?=
 =?us-ascii?Q?oAIeTltcyllT17mxnRczBhuAZSrlZLfY3O7H+zrnY8TFabMVPcRkalUh8p1i?=
 =?us-ascii?Q?Yq0Wc9BtBzFUPTORlAUEOQC37nFPdv0mqSc3fqWD/KanXkJO1sT2Wew5CqVm?=
 =?us-ascii?Q?iuXU0wTo+lR90Tu6/mwwSZW0Rt2f7vUt5JcbUn6ZZzgBVALyAWl9OfjvS5dV?=
 =?us-ascii?Q?aaXFvBsvZYv+IGgT00E8FC6IuNLuaZVcHelNkTANAV814PFiUv0xVmTnkk7t?=
 =?us-ascii?Q?8WJ4qVREXT/iLNbL1ueItk69JGznIo7cotVtZickCokfMKH+Ps0xMQnofVPO?=
 =?us-ascii?Q?xSUlBMUZSioblHVBbmG4m8a/nMRYiE7geJeolc3ToCOsG68fJUS+CMtkZoOg?=
 =?us-ascii?Q?GiOydnnDEm1xf5r8kHLs47QN7wfhY4hZtNP/YAee6kcnFxz7EA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:33:52.8186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4aa912-1f67-4822-0d36-08dc8667fae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931

Validate address maps at the time the information is gathered as the
address map will not change during translation.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - New in v2.
v3:
  - Move DF 4.5 np2 validation to patch 4.
  - Update commit description.
v4:
  - Merge common cases in map validation function.
  - Fix map validation for cases that don't have explicit checks.
v5:
  - Rename "out" label to "err".
---
 drivers/ras/amd/atl/dehash.c | 43 --------------------
 drivers/ras/amd/atl/map.c    | 77 ++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 43 deletions(-)

diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
index 4ea46262c4f5..d4ee7ecabaee 100644
--- a/drivers/ras/amd/atl/dehash.c
+++ b/drivers/ras/amd/atl/dehash.c
@@ -12,41 +12,10 @@
 
 #include "internal.h"
 
-/*
- * Verify the interleave bits are correct in the different interleaving
- * settings.
- *
- * If @num_intlv_dies and/or @num_intlv_sockets are 1, it means the
- * respective interleaving is disabled.
- */
-static inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
-				  u8 num_intlv_dies, u8 num_intlv_sockets)
-{
-	if (!(ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)) {
-		pr_debug("Invalid interleave bit: %u", ctx->map.intlv_bit_pos);
-		return false;
-	}
-
-	if (ctx->map.num_intlv_dies > num_intlv_dies) {
-		pr_debug("Invalid number of interleave dies: %u", ctx->map.num_intlv_dies);
-		return false;
-	}
-
-	if (ctx->map.num_intlv_sockets > num_intlv_sockets) {
-		pr_debug("Invalid number of interleave sockets: %u", ctx->map.num_intlv_sockets);
-		return false;
-	}
-
-	return true;
-}
-
 static int df2_dehash_addr(struct addr_ctx *ctx)
 {
 	u8 hashed_bit, intlv_bit, intlv_bit_pos;
 
-	if (!map_bits_valid(ctx, 8, 9, 1, 1))
-		return -EINVAL;
-
 	intlv_bit_pos = ctx->map.intlv_bit_pos;
 	intlv_bit = !!(BIT_ULL(intlv_bit_pos) & ctx->ret_addr);
 
@@ -67,9 +36,6 @@ static int df3_dehash_addr(struct addr_ctx *ctx)
 	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
 	u8 hashed_bit, intlv_bit, intlv_bit_pos;
 
-	if (!map_bits_valid(ctx, 8, 9, 1, 1))
-		return -EINVAL;
-
 	hash_ctl_64k = FIELD_GET(DF3_HASH_CTL_64K, ctx->map.ctl);
 	hash_ctl_2M  = FIELD_GET(DF3_HASH_CTL_2M, ctx->map.ctl);
 	hash_ctl_1G  = FIELD_GET(DF3_HASH_CTL_1G, ctx->map.ctl);
@@ -171,9 +137,6 @@ static int df4_dehash_addr(struct addr_ctx *ctx)
 	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
 	u8 hashed_bit, intlv_bit;
 
-	if (!map_bits_valid(ctx, 8, 8, 1, 2))
-		return -EINVAL;
-
 	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K, ctx->map.ctl);
 	hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M, ctx->map.ctl);
 	hash_ctl_1G  = FIELD_GET(DF4_HASH_CTL_1G, ctx->map.ctl);
@@ -247,9 +210,6 @@ static int df4p5_dehash_addr(struct addr_ctx *ctx)
 	u8 hashed_bit, intlv_bit;
 	u64 rehash_vector;
 
-	if (!map_bits_valid(ctx, 8, 8, 1, 2))
-		return -EINVAL;
-
 	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K, ctx->map.ctl);
 	hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M, ctx->map.ctl);
 	hash_ctl_1G  = FIELD_GET(DF4_HASH_CTL_1G, ctx->map.ctl);
@@ -360,9 +320,6 @@ static int mi300_dehash_addr(struct addr_ctx *ctx)
 	bool hashed_bit, intlv_bit, test_bit;
 	u8 num_intlv_bits, base_bit, i;
 
-	if (!map_bits_valid(ctx, 8, 8, 4, 1))
-		return -EINVAL;
-
 	hash_ctl_4k  = FIELD_GET(DF4p5_HASH_CTL_4K, ctx->map.ctl);
 	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
 	hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
index 8b908e8d7495..04419923f088 100644
--- a/drivers/ras/amd/atl/map.c
+++ b/drivers/ras/amd/atl/map.c
@@ -642,6 +642,79 @@ static int get_global_map_data(struct addr_ctx *ctx)
 	return 0;
 }
 
+/*
+ * Verify the interleave bits are correct in the different interleaving
+ * settings.
+ *
+ * If @num_intlv_dies and/or @num_intlv_sockets are 1, it means the
+ * respective interleaving is disabled.
+ */
+static inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
+				  u8 num_intlv_dies, u8 num_intlv_sockets)
+{
+	if (!(ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)) {
+		pr_debug("Invalid interleave bit: %u", ctx->map.intlv_bit_pos);
+		return false;
+	}
+
+	if (ctx->map.num_intlv_dies > num_intlv_dies) {
+		pr_debug("Invalid number of interleave dies: %u", ctx->map.num_intlv_dies);
+		return false;
+	}
+
+	if (ctx->map.num_intlv_sockets > num_intlv_sockets) {
+		pr_debug("Invalid number of interleave sockets: %u", ctx->map.num_intlv_sockets);
+		return false;
+	}
+
+	return true;
+}
+
+static int validate_address_map(struct addr_ctx *ctx)
+{
+	switch (ctx->map.intlv_mode) {
+	case DF2_2CHAN_HASH:
+	case DF3_COD4_2CHAN_HASH:
+	case DF3_COD2_4CHAN_HASH:
+	case DF3_COD1_8CHAN_HASH:
+		if (!map_bits_valid(ctx, 8, 9, 1, 1))
+			goto err;
+		break;
+
+	case DF4_NPS4_2CHAN_HASH:
+	case DF4_NPS2_4CHAN_HASH:
+	case DF4_NPS1_8CHAN_HASH:
+	case DF4p5_NPS4_2CHAN_1K_HASH:
+	case DF4p5_NPS4_2CHAN_2K_HASH:
+	case DF4p5_NPS2_4CHAN_1K_HASH:
+	case DF4p5_NPS2_4CHAN_2K_HASH:
+	case DF4p5_NPS1_8CHAN_1K_HASH:
+	case DF4p5_NPS1_8CHAN_2K_HASH:
+	case DF4p5_NPS1_16CHAN_1K_HASH:
+	case DF4p5_NPS1_16CHAN_2K_HASH:
+		if (!map_bits_valid(ctx, 8, 8, 1, 2))
+			goto err;
+		break;
+
+	case MI3_HASH_8CHAN:
+	case MI3_HASH_16CHAN:
+	case MI3_HASH_32CHAN:
+		if (!map_bits_valid(ctx, 8, 8, 4, 1))
+			goto err;
+		break;
+
+	/* Nothing to do for modes that don't need special validation checks. */
+	default:
+		break;
+	}
+
+	return 0;
+
+err:
+	atl_debug(ctx, "Inconsistent address map");
+	return -EINVAL;
+}
+
 static void dump_address_map(struct dram_addr_map *map)
 {
 	u8 i;
@@ -678,5 +751,9 @@ int get_address_map(struct addr_ctx *ctx)
 
 	dump_address_map(&ctx->map);
 
+	ret = validate_address_map(ctx);
+	if (ret)
+		return ret;
+
 	return ret;
 }
-- 
2.34.1


