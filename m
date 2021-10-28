Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E7A43E7AF
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhJ1SBA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:00 -0400
Received: from mail-mw2nam10on2072.outbound.protection.outlook.com ([40.107.94.72]:12065
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231213AbhJ1SAo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZmeMzLCcKE9jKGeugx4dvwNIePfo0KL+pyvk9XzKEQeZ/RKQ8TFJIawdiq+jpnvmL+KZzVp1EfOXHqbBnv9XIpbkQDC5JniSCX6ywiN4NjUhBY4sgw7YtMqDEnBZ+T8SQ0ofT4yP7JuqU1kHA5gLi+jJ7Vne+jvfsOZmWXhFqtWaYp6/cerEbzVIJ70V48hJfs4hIDsjGQqCR9TCeYQJ35cO8JbK5GGzfRnfQ3zOSEGDbLUbsrmh9byWGRTIKPqH7TU4idA+ZZyaT6mOBA7dXiGRFeoY81HEYZJvRlK2mA/k6967B0YTHeGlnaQUJG1qNydqe7RMwj69LGTXiLrMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4z8QIBgvuHVWT/tSZa+ti/mUNcaQpEmDGxVbvZdnDs0=;
 b=YNLXbsMUHLtFkkK8/8MsU+FTxWVV4XY8LytuKJ2KTFPCtsuVUtWISL/WjZSgBWXvDJsrcfWfnfeGgg0QO99VvU+LSyMFoyI2g1UIhG3qE3pvSrsx+YK+V2kfdigMn9z8LpJNMk4DBuSIvhYRWdU2DptD6uwY9ba+dsQJfyhPY3LUTNkiAPQLiX6+B72mWmy6lTBs+mrCycDmsx7eMaVPN6TjCOhR7C+YUiulbYuIszlMQcxqiu6ZsOWfH/NL6rvDxHbld9k1rjT+WJt8eOdtYShaNLIK9wYd/FLwXNIKzZVMU+PZIt+/ZNAeJX4odgGDm4wtkrJlyGpPoWwRXXw0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z8QIBgvuHVWT/tSZa+ti/mUNcaQpEmDGxVbvZdnDs0=;
 b=S/KYDUtuRmr7adEMkhur+Xy9qHJtR0zADpaX0KEBF2f5FCwwYmIE0ju1s9oy3Z9GApcQxVM5yh3+V+e7OP08TMB/kDE0QJdDAnkTjDin+9nH7plWZOwZZtpqSbl/1/ct+VVCYa5cNWB3kfoClgKNBDEvAsBsvDFQu6/C7t/OAvY=
Received: from CO1PR15CA0092.namprd15.prod.outlook.com (2603:10b6:101:21::12)
 by DM5PR12MB1435.namprd12.prod.outlook.com (2603:10b6:3:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 17:58:14 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::a2) by CO1PR15CA0092.outlook.office365.com
 (2603:10b6:101:21::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:13 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:12 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 09/33] EDAC/amd64: Define function to denormalize address
Date:   Thu, 28 Oct 2021 17:57:04 +0000
Message-ID: <20211028175728.121452-10-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028175728.121452-1-yazen.ghannam@amd.com>
References: <20211028175728.121452-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfa8e429-f3de-42db-8023-08d99a3c8348
X-MS-TrafficTypeDiagnostic: DM5PR12MB1435:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1435033D4B54AC9D829E806CF8869@DM5PR12MB1435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WdDdSSPI/cQn7XJqc0B+kLWATZIbNaMo+kbKRRPP7HTDFLJB+MD3EHZA/nMtiKR45n7s5Gttzevh6QO0kTYpih1wli84GwjoEik+iKSMWN3Lr0ZLVrL6M5p9vovI11nzoeeQDvmDIuDx8MH6T8ZRxGVonthTI2+oRdnccerLChQLb6oar6WXsf21qXyHTgVv4fy2A3OEcOLwbRPfphmsHMYxUkig0fkXhZkjHqFRgl7Y8VF4536c/nd5jbQi6SxtDiz8mt7vi/ACC0EFgZURbMXOibgFZyI4z16tmGDXaDj81MNjHvFm8g9sdqKfK78rl0wtqoJwJNvubMYdL6WGwsGSKRxgvMjdqG5L//YPUp+zlUFIrQiKEN42X4aZLX1Wh2KBFSlg3jVb2REJnhv5Tz1Dz0Gw+Zu7wz9NukI25TCxW1wopZJ3dgr/3NxmbrgRxGaw+iQcqI1gvXoHEu/S4l5Br3bn4gTqvnWS5gSfCjrAX6Q4QdYfG1Jl8TnDYdxarW68NI67g+5AjdSV5qRlI2NHzncKlS059n2BDT9xC8nehW2/CxLLToyeG0b6PYY11TiLhOl27lXV2lR2FTtLOsdSo40u51B941kSsoeZOiQc1S5I7ogA0s8V2YUbjgBHauZIK3rcaan0pJWrNO0VvctdTwjHQqemYBHDBA3zb9pkLKJqv/mXrIb8Udzb4VUzSKg8S3Dp6dOTIx8dEGpwU+j4htiWnHKfyYKLRdFfRa/8LTKy1UglJxD323xgXGdFbp3zbGb0acJdMXRc0aRrViUGyadPxRy3YQN23CRkyJWxV5kQTFHojyGoGWV1OJ2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(6916009)(966005)(81166007)(16526019)(86362001)(356005)(186003)(54906003)(316002)(336012)(82310400003)(47076005)(36860700001)(5660300002)(36756003)(70206006)(426003)(70586007)(2616005)(1076003)(7696005)(26005)(83380400001)(508600001)(6666004)(44832011)(2906002)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:13.9318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa8e429-f3de-42db-8023-08d99a3c8348
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1435
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move the address denormalization into a separate helper function. This
will be further refactored in later patches.

Add the interleave address bit and the CS ID to the context struct.
These values will be used by multiple functions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-11-yazen.ghannam@amd.com

v2->v3:
* Was patch 10 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 135 +++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 61 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index bc0ec36fe5bb..b4b7c93a6390 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1067,6 +1067,8 @@ struct addr_ctx {
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
+	u8 intlv_addr_bit;
+	u8 cs_id;
 	bool hash_enabled;
 };
 
@@ -1154,56 +1156,24 @@ static int get_dram_addr_map(struct addr_ctx *ctx)
 	return 0;
 }
 
-static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+static int denormalize_addr(struct addr_ctx *ctx)
 {
-	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
-
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
-	u8 intlv_addr_sel, intlv_addr_bit;
-	u8 num_intlv_bits, hashed_bit;
-	u8 lgcy_mmio_hole_en;
-	u8 cs_mask, cs_id = 0;
-
-	struct addr_ctx ctx;
-
-	if (!df_ops)
-		return -EINVAL;
-
-	memset(&ctx, 0, sizeof(ctx));
-
-	/* We start from the normalized address */
-	ctx.ret_addr = norm_addr;
-
-	ctx.nid = nid;
-	ctx.inst_id = umc;
-
-	if (remove_dram_offset(&ctx))
-		goto out_err;
-
-	if (get_dram_addr_map(&ctx))
-		goto out_err;
-
-	if (df_ops->get_intlv_mode(&ctx))
-		goto out_err;
-
-	lgcy_mmio_hole_en = ctx.reg_base_addr & BIT(1);
-	intlv_num_chan	  = (ctx.reg_base_addr >> 4) & 0xF;
-	intlv_addr_sel	  = (ctx.reg_base_addr >> 8) & 0x7;
-	dram_base_addr	  = (ctx.reg_base_addr & GENMASK_ULL(31, 12)) << 16;
+	u8 intlv_addr_sel = (ctx->reg_base_addr >> 8) & 0x7;
+	u8 num_intlv_bits, cs_mask = 0;
 
 	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
 	if (intlv_addr_sel > 3) {
 		pr_err("%s: Invalid interleave address select %d.\n",
 			__func__, intlv_addr_sel);
-		goto out_err;
+		return -EINVAL;
 	}
 
-	intlv_num_sockets = (ctx.reg_limit_addr >> 8) & 0x1;
-	intlv_num_dies	  = (ctx.reg_limit_addr >> 10) & 0x3;
-	dram_limit_addr	  = ((ctx.reg_limit_addr & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
+	intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
+	intlv_num_dies	  = (ctx->reg_limit_addr >> 10) & 0x3;
 
-	intlv_addr_bit = intlv_addr_sel + 8;
+	ctx->intlv_addr_bit = intlv_addr_sel + 8;
 
 	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
 	switch (intlv_num_chan) {
@@ -1218,7 +1188,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	default:
 		pr_err("%s: Invalid number of interleaved channels %d.\n",
 			__func__, intlv_num_chan);
-		goto out_err;
+		return -EINVAL;
 	}
 
 	num_intlv_bits = intlv_num_chan;
@@ -1226,7 +1196,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (intlv_num_dies > 2) {
 		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
 			__func__, intlv_num_dies);
-		goto out_err;
+		return -EINVAL;
 	}
 
 	num_intlv_bits += intlv_num_dies;
@@ -1238,7 +1208,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (num_intlv_bits > 4) {
 		pr_err("%s: Invalid interleave bits %d.\n",
 			__func__, num_intlv_bits);
-		goto out_err;
+		return -EINVAL;
 	}
 
 	if (num_intlv_bits > 0) {
@@ -1251,41 +1221,43 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		 * umc/channel# as instance id of the coherent slave
 		 * for FICAA.
 		 */
-		if (df_indirect_read_instance(nid, 0, 0x50, umc, &ctx.tmp))
-			goto out_err;
+		if (df_indirect_read_instance(ctx->nid, 0, 0x50, ctx->inst_id, &ctx->tmp))
+			return -EINVAL;
 
-		cs_fabric_id = (ctx.tmp >> 8) & 0xFF;
+		cs_fabric_id = (ctx->tmp >> 8) & 0xFF;
 		die_id_bit   = 0;
 
 		/* If interleaved over more than 1 channel: */
 		if (intlv_num_chan) {
 			die_id_bit = intlv_num_chan;
 			cs_mask	   = (1 << die_id_bit) - 1;
-			cs_id	   = cs_fabric_id & cs_mask;
+			ctx->cs_id = cs_fabric_id & cs_mask;
 		}
 
 		sock_id_bit = die_id_bit;
 
 		/* Read D18F1x208 (SystemFabricIdMask). */
 		if (intlv_num_dies || intlv_num_sockets)
-			if (df_indirect_read_broadcast(nid, 1, 0x208, &ctx.tmp))
-				goto out_err;
+			if (df_indirect_read_broadcast(ctx->nid, 1, 0x208, &ctx->tmp))
+				return -EINVAL;
 
 		/* If interleaved over more than 1 die. */
 		if (intlv_num_dies) {
 			sock_id_bit  = die_id_bit + intlv_num_dies;
-			die_id_shift = (ctx.tmp >> 24) & 0xF;
-			die_id_mask  = (ctx.tmp >> 8) & 0xFF;
+			die_id_shift = (ctx->tmp >> 24) & 0xF;
+			die_id_mask  = (ctx->tmp >> 8) & 0xFF;
 
-			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+			ctx->cs_id |= ((cs_fabric_id & die_id_mask)
+					>> die_id_shift) << die_id_bit;
 		}
 
 		/* If interleaved over more than 1 socket. */
 		if (intlv_num_sockets) {
-			socket_id_shift	= (ctx.tmp >> 28) & 0xF;
-			socket_id_mask	= (ctx.tmp >> 16) & 0xFF;
+			socket_id_shift	= (ctx->tmp >> 28) & 0xF;
+			socket_id_mask	= (ctx->tmp >> 16) & 0xFF;
 
-			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
+			ctx->cs_id |= ((cs_fabric_id & socket_id_mask)
+					>> socket_id_shift) << sock_id_bit;
 		}
 
 		/*
@@ -1296,12 +1268,53 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
 		 * there are (where "I" starts).
 		 */
-		temp_addr_y = ctx.ret_addr & GENMASK_ULL(intlv_addr_bit - 1, 0);
-		temp_addr_i = (cs_id << intlv_addr_bit);
-		temp_addr_x = (ctx.ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
-		ctx.ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
+		temp_addr_y = ctx->ret_addr & GENMASK_ULL(ctx->intlv_addr_bit - 1, 0);
+		temp_addr_i = (ctx->cs_id << ctx->intlv_addr_bit);
+		temp_addr_x = (ctx->ret_addr & GENMASK_ULL(63, ctx->intlv_addr_bit))
+			       << num_intlv_bits;
+		ctx->ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
 	}
 
+	return 0;
+}
+
+static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+{
+	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
+
+	u8 hashed_bit;
+	u8 lgcy_mmio_hole_en;
+
+	struct addr_ctx ctx;
+
+	if (!df_ops)
+		return -EINVAL;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	/* We start from the normalized address */
+	ctx.ret_addr = norm_addr;
+
+	ctx.nid = nid;
+	ctx.inst_id = umc;
+
+	if (remove_dram_offset(&ctx))
+		return -EINVAL;
+
+	if (get_dram_addr_map(&ctx))
+		goto out_err;
+
+	if (df_ops->get_intlv_mode(&ctx))
+		goto out_err;
+
+	if (denormalize_addr(&ctx))
+		goto out_err;
+
+	lgcy_mmio_hole_en = ctx.reg_base_addr & BIT(1);
+	dram_base_addr	  = (ctx.reg_base_addr & GENMASK_ULL(31, 12)) << 16;
+
+	dram_limit_addr	  = ((ctx.reg_limit_addr & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
+
 	/* Add dram base address */
 	ctx.ret_addr += dram_base_addr;
 
@@ -1321,12 +1334,12 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 				(ctx.ret_addr >> 18) ^
 				(ctx.ret_addr >> 21) ^
 				(ctx.ret_addr >> 30) ^
-				cs_id;
+				ctx.cs_id;
 
 		hashed_bit &= BIT(0);
 
-		if (hashed_bit != ((ctx.ret_addr >> intlv_addr_bit) & BIT(0)))
-			ctx.ret_addr ^= BIT(intlv_addr_bit);
+		if (hashed_bit != ((ctx.ret_addr >> ctx.intlv_addr_bit) & BIT(0)))
+			ctx.ret_addr ^= BIT(ctx.intlv_addr_bit);
 	}
 
 	/* Is calculated system address is above DRAM limit address? */
-- 
2.25.1

