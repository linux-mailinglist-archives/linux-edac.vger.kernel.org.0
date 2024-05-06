Return-Path: <linux-edac+bounces-1007-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BF88BD1BE
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 17:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257A3B245DC
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 15:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2CE15622E;
	Mon,  6 May 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HYqEsQD4"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E5156221;
	Mon,  6 May 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010402; cv=fail; b=Dv9w57J2sZlNPqwHpRZ2Qg9g7s4UgpIHF6yG3qjWKD9KciOMIanyQPrAxO+Y/Xbbvb5c9YFMDi2bbpV+5qERmZsV7Pye++/9aixHLxgtSMrCaXztTwFBuBnkygSBtq5iFgzyW2a9rcYRxbmRoeA9UjLrtoOWmcVJN8mkLVqtEWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010402; c=relaxed/simple;
	bh=yhtCngxHbz0rXw/GdAeKx9lLD1WrcrBZTh6DkbrtfbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPhjgF4UN3TUWMYzwo7UIdkLgNt7ElknsmVRrK68476IGvfI+9yB1RZP72XLRCxTRH6UWAorJfom8/rN/J0YQOZbjw1qyzxCVbzMnDw1dqGS9XL/p6uZH2RzCkF7e98GMUEuFiQCG5ZD+hejTfWbXcRfFk5to4ZV+LEaQ8wFN30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HYqEsQD4; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILn0Q+r86Qq21/Cy+9XREA/K6sm+UPY1xtdCkg3hyi7pOQ7NV5QpUHksCSTUnc6iOZ1XioSiLvywqU2YhHnr6ogdWsH/Nx9JgSURra6T4BE1hzShdV8U5sKkhndbNGZg+CCuskTBUhVUrztA/7WIvsbSnuuq4MGwQf7Goxr66viHxNOUwv/F2Yq0KX9UJfYvGxAG9PH08L+vpG4doWOWsJ/ASNQquiVI5+9MH5EVg/UWukDuMvzQGkV3MlAuWYBH9kOBsm7sSkap5oDpDuzFQw19UN9mJ6odtV+Hl6fnrnJp/+PVvmz0UOaKJFG58gebagY6RmEjXVNdaqrQCTsNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfLnlJzbbXvMNCyuD8vNbNgd+UUvalGT49WBrAohze4=;
 b=KboWR4W8GbZiU7Gm6F8ufsdoD4eWPiFDOaGrXakFYV6iUZLul/750jRvRLt0JnO7l4aHv6xiHR4CVcRRxl06EX4E+ZvM9hR/A9ZHqJSNFRl4JP2AWZrGxF1utqKk/ySxhv9q54SAzJ5cbRvSCBMBu9KOB6dNL9HgCiH2AgqBv5s1hYi5sVx4SgcQWnScMu89QDUtG7GIAOV36Ot4cO/NGA9a7+cGib0FK94rOrevBjL9r5CW0q210u45bILXM2Nd7csqZeT3ILshzx0I354P1B+yC0AvIEkY7AWoPEN9elXyQFMXEUlentpU8+rb5w2W6XCWhxr4MjnjII7A7YMtIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfLnlJzbbXvMNCyuD8vNbNgd+UUvalGT49WBrAohze4=;
 b=HYqEsQD47PoEPMGj3es5OLwdMR/gl89Pyf3NWlbpGXKZQ/PannVcDCosL3xiwvDjNxYtJI08J3VpjDDIWIEiiSTd5H3tCVV6dbhz7TMO3fZ/y+/W0FjksTD8mJ82epGyLE2SeBhRVND/FrWCTIAkpkHKzKJjHdUcVFtOqcoyu34=
Received: from SA9PR13CA0036.namprd13.prod.outlook.com (2603:10b6:806:22::11)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Mon, 6 May
 2024 15:46:37 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::48) by SA9PR13CA0036.outlook.office365.com
 (2603:10b6:806:22::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 15:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 15:46:36 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 10:46:35 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v4 3/4] RAS/AMD/ATL: Validate address map when information is gathered
Date: Mon, 6 May 2024 15:46:04 +0000
Message-ID: <20240506154605.71814-4-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 4698e121-8659-42e3-1201-08dc6de3b6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CrPDgywWeJRelUpZ/vDsH41qI8Knevgez/hU942O3j6M5aK9n8E/Q3caKfOu?=
 =?us-ascii?Q?brhX5i0nC5Jw8+RINAtiMBnRx5FVzoB04DKn0w8KgcJNLe4GM5XuTv42T1D3?=
 =?us-ascii?Q?7iYiEjPiLIL+Q0N9JqCTpMXtLlbi+FrZj5QWQh7osh5qwq4MPiydjoRUoGgB?=
 =?us-ascii?Q?bMs+liM91yZXkA2qIu0MEZNnAB+Hj4BbMo1uiEShZAN/cs5mgLK65a5Xtjun?=
 =?us-ascii?Q?Xz09Grh1F+zdC6j3nvAoOmpYxExhP4QFhUDrBFMwS6Dxidri1DxUKOX1anOC?=
 =?us-ascii?Q?ORplzngV3bi2gv+R9CCbj3kaRNSmRyJQSGl8axdYqGN24SenwaXmnz8ybczU?=
 =?us-ascii?Q?Eas5y/xHDiHPpyg1n1x1dPdQsY3hFNPBxszl/iL6Pd9BcYqwgDsYxgpxcl/b?=
 =?us-ascii?Q?arafsX6lkD+wlcWQqYjr2Cok28tJiQl41HZLzScvSyqKNaNH9WjnbfhXfpME?=
 =?us-ascii?Q?6pVwQ3dI/NugsIvvfIqbVwQYasA48KZgqlRD2nfiCdBeXNmfh7C/fBDxSkJE?=
 =?us-ascii?Q?vypZ7KovRrD2OlEOANV2AtHd4dY86rNebWqhYtCpDkswDNDrdDE8dTGRuZpa?=
 =?us-ascii?Q?g6wEs2QsWJ65JR+iRn72kNsyhv7yhnhPs+kNzm0zbZBtOWv9PGaPka+wzSRk?=
 =?us-ascii?Q?ORdPP94gROZeO0/hMLv9MIy/jbE2i7kvAQXU7rjw236XXOuLJ1CRiXI1vinI?=
 =?us-ascii?Q?1S7W57AYQR2ntNflBZ6V4EfrSk1FYP2oqogTBwZYHKOyzl9NAfAWrJtbvleq?=
 =?us-ascii?Q?iyspdG6gkrYdtKi2XqDImurhri4oDdVXsA3WQHv3vrqRmFmaRV1oW3ayQbg4?=
 =?us-ascii?Q?U90dY+Kpm7xlGbBfsO1o/NFiQvKBe0C8gJ9uU2WOXBqqv7hZJ6IOC8Po9kLT?=
 =?us-ascii?Q?bDVM32xGrJ5msOI4lN8jd2Nhl1qJ1nE3sH/32zDqQU89Nb7mvJUZnD99SRcU?=
 =?us-ascii?Q?a1/miw9V7c0tiK7Q2Ti8KdPQdh8iHBrSjUPSpidHgfo2FcQAF3sr95/hTK/X?=
 =?us-ascii?Q?uns2jwdeOL25Tbarb99K1ManMHHPUpEaTisamjdyLcypbCc0IeQGAUmho9vs?=
 =?us-ascii?Q?7rsBcoB6+ZYZHEitt6Br7kU5iIj3a/d1WVP7JprkRU0USFhRWajdWB1Wq6i7?=
 =?us-ascii?Q?PsJHeJPkQd0cNrFb0chF1gUn0SB9CwbQ/lkal2yEyZWqj+HKwFx3LNERPl9P?=
 =?us-ascii?Q?DOHWCDloeI9JmY3GLFtDVJE9N2DomdbM1V3xZRGx78hHsCrDhEH9MBIMrcoF?=
 =?us-ascii?Q?/1NYejMX6VGx7YXLo51oegockcaZx4Q/GpjafWSE+avHy6sWHCTmJ4yT/7DM?=
 =?us-ascii?Q?0qSDpWNPcqxKxnPlBpY6GQJE0bugi4W1iquVgfgkEdy+xTjjV2b+qWyPaYbP?=
 =?us-ascii?Q?MAO52jriDaOjYqsbNncWkS0JP37N?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 15:46:36.8090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4698e121-8659-42e3-1201-08dc6de3b6a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593

Validate address maps at the time the information is gathered as the
address map will not change during translation.

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
index 8b908e8d7495..e58b29e890c4 100644
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
+			goto out;
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
+			goto out;
+		break;
+
+	case MI3_HASH_8CHAN:
+	case MI3_HASH_16CHAN:
+	case MI3_HASH_32CHAN:
+		if (!map_bits_valid(ctx, 8, 8, 4, 1))
+			goto out;
+		break;
+
+	/* Nothing to do for modes that don't need special validation checks. */
+	default:
+		break;
+	}
+
+	return 0;
+
+out:
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


