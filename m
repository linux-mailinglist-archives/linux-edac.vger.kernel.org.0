Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E1B49ECA4
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344116AbiA0Ulw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:52 -0500
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com ([40.107.223.84]:41569
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344097AbiA0Ulo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcFMw49gbnIms7cvQi6pr90LYvSTfZ+EaWLmOLCGZD8t1v2jNCJhQ8oDBty51X7qMhzFOZj35cuknBCueSRca9Pwm7KiFHb6zqLlg7+ATLk7z5fJlYP6Kmz1irLOu7fVTcqFr060LmViMglINZ8m/XEexxU33C1rTTVbYW5ZPU1sy9FWfW+YJP2n8gvr5sUno1Y0GLbEqT/3G6CdEVf3FWHLYGEvT+VRz0jE3cakGUpp+SBavCQAcC0Zz38OPeDSoHG5h0mOI31HnjGmj8OMKfYR0MsCD4RI9DJhi28hZuVkrSGqttFNW6TNDa5aigTfbQEnD0WuTfNpBnE9k54yMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVRGfDAl8+JqU/mi1WEbTRo69GZ7ley5L2VdbqXWzrU=;
 b=EWedz0+nUNPRMe9QzR6w60rnHjd5sW/v+0jQJZGftsX++toOUAx4QJYABzIwoe8bNlXaeXHOMTHYJhxuGIiFYnLWM+BUxUo5gCS7KQG3INmtDvlkTjsYXFHaUTE/siV5KWtrGrMJwSjjMyPH8mOXlnevTEwphjc0bKpyjrHFgSMg+crkNFD5yw4/a73DcPMicw0xbrvMtFc/4wtXsykOTqzVtY5WpdeMVyxJZYWu/LDeUADk7kT2BTkAJq8AQyudF+jxDectt3I8YlkOtSEQPoOpTrvI2dulEQx9YgAATjuK9RWGTeYgYD6wVQL5KVKYcZ3uXXg+aFaJmZjFKK12MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVRGfDAl8+JqU/mi1WEbTRo69GZ7ley5L2VdbqXWzrU=;
 b=lL3YTMY/ayWqGwwiqTyR/tIjOImlSUME+77IIAT6YeSYobwNMLCHPL26AzYq/OZobUT18ELG60GjBzVTc1kTEKazL/4Bov6NUt7CsJ+2FWTnJ9fe8swh++tLZhh0s0o6wHn5OyfcP3ZI+i7EdU0uiR2UQHYXCp0dbWkWHc855YM=
Received: from MW4P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::35)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 27 Jan
 2022 20:41:42 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::aa) by MW4P221CA0030.outlook.office365.com
 (2603:10b6:303:8b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:42 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:38 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 05/24] EDAC/amd64: Define function to denormalize address
Date:   Thu, 27 Jan 2022 20:40:56 +0000
Message-ID: <20220127204115.384161-6-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127204115.384161-1-yazen.ghannam@amd.com>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6d2f354-bbb4-483e-3c13-08d9e1d56d00
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB406303EDF318AF531AF015BCF8219@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDTuMCs+pGuhNKVAUuDdiT+Cv5gXQ4z3Hzq8yuAKVK8no51hVfxTKbI7CrH/kcdMYaBISKkZGFR8n0gxQZ8zI0DIYkQzcO0E2M8PbUGGYIRnmkH+2B9hqwhYMeyzI/uHJV3+hf4mj33QmQ6ZGem6ZDAShDTuVRJOjTSBaLEgOdqcIDtbhKxattjVpXIGrYmWW8/q2ELuUhs0pkd4DgyzWzoUpvgF3QxsqNzE9X4mdDvxrzp3R+DciK5cLZrj5yXAeUSozMuSKgoMZUhomMC9zKHzCkV5mcDXlk5xlYVhX0/59TGTQ/m7HakKeNFQxj/bVNL0LY9cI3rDJhRY+YB4ItA4RAPpBXnd1jYZQMR6D9iDAwX9SG5JlXBjl7CJiG6lVItb2fduEXbvx6ZB/h7zgdQvGArhyqh+Q4nwGVeeGWD1zLpMaMS+Dji6/LVndv5yfYn0WdwRyehUdSBiJL6rOYjzfu13kk+OOFsqpcTD6shc9lB6AqsCBC3kI0FKDDKWwdSz1TDptIy0Y7ydGyN3BOLC/C2oZ3wI4w6WnR35UFt/wjyeNlQlXHzI5b7RFkGjvPduOx25dvJLd0GkDBPTwzoym641n90op6mV17ozfpm9IaSofRaYQJlg42kuNqj2CRFszFXs/mhPRY68zWFcPIcrD1Pp69o0C3oaQ6+Si3BS3LAJWp5CcCslHlfIE3AkY93+kM2uwyabylKQRHNwiPRsc2zztdNG+5GlxLHK3Qz9AtqsZsnD7dFICaZyBxjPNPY6TcRxgShHZ7MbaZ5xXT2qvHtUA5PHs/fCUV1YJZIKsupIBucY5axf2jZ7zBn43W50aTjRbKtFWePPsFs1/WQfEMK/xFR+uPdALmm7K/q0WKDJHkwV1lqhxtQjmqIq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700004)(36756003)(82310400004)(86362001)(5660300002)(70206006)(2616005)(83380400001)(6916009)(8936002)(26005)(2906002)(966005)(47076005)(6666004)(336012)(36860700001)(54906003)(356005)(316002)(44832011)(7696005)(4326008)(426003)(81166007)(508600001)(1076003)(40460700003)(70586007)(16526019)(186003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:42.0776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d2f354-bbb4-483e-3c13-08d9e1d56d00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
https://lore.kernel.org/r/20211028175728.121452-10-yazen.ghannam@amd.com

v3->v4:
* Include pr_debug() on failure.

v2->v3:
* Was patch 10 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 153 +++++++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 69 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4e83a9be4724..9c61e3fa231a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1075,6 +1075,8 @@ struct addr_ctx {
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
+	u8 intlv_addr_bit;
+	u8 cs_id;
 	bool hash_enabled;
 };
 
@@ -1164,64 +1166,24 @@ static int get_dram_addr_map(struct addr_ctx *ctx)
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
-	if (!df_ops) {
-		pr_debug("Data Fabric Operations not set");
-		return -EINVAL;
-	}
-
-	memset(&ctx, 0, sizeof(ctx));
-
-	/* Start from the normalized address */
-	ctx.ret_addr = norm_addr;
-
-	ctx.nid = nid;
-	ctx.inst_id = umc;
-
-	if (remove_dram_offset(&ctx)) {
-		pr_debug("Failed to remove DRAM offset");
-		goto out_err;
-	}
-
-	if (get_dram_addr_map(&ctx)) {
-		pr_debug("Failed to get DRAM address map");
-		goto out_err;
-	}
-
-	if (df_ops->get_intlv_mode(&ctx)) {
-		pr_debug("Failed to get interleave mode");
-		goto out_err;
-	}
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
@@ -1236,7 +1198,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	default:
 		pr_err("%s: Invalid number of interleaved channels %d.\n",
 			__func__, intlv_num_chan);
-		goto out_err;
+		return -EINVAL;
 	}
 
 	num_intlv_bits = intlv_num_chan;
@@ -1244,7 +1206,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (intlv_num_dies > 2) {
 		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
 			__func__, intlv_num_dies);
-		goto out_err;
+		return -EINVAL;
 	}
 
 	num_intlv_bits += intlv_num_dies;
@@ -1256,7 +1218,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (num_intlv_bits > 4) {
 		pr_err("%s: Invalid interleave bits %d.\n",
 			__func__, num_intlv_bits);
-		goto out_err;
+		return -EINVAL;
 	}
 
 	if (num_intlv_bits > 0) {
@@ -1269,41 +1231,43 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
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
@@ -1314,12 +1278,63 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
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
+	if (!df_ops) {
+		pr_debug("Data Fabric Operations not set");
+		return -EINVAL;
+	}
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	/* We start from the normalized address */
+	ctx.ret_addr = norm_addr;
+
+	ctx.nid = nid;
+	ctx.inst_id = umc;
+
+	if (remove_dram_offset(&ctx)) {
+		pr_debug("Failed to remove DRAM offset");
+		goto out_err;
+	}
+
+	if (get_dram_addr_map(&ctx)) {
+		pr_debug("Failed to get DRAM address map");
+		goto out_err;
+	}
+
+	if (df_ops->get_intlv_mode(&ctx)) {
+		pr_debug("Failed to get interleave mode");
+		goto out_err;
+	}
+
+	if (denormalize_addr(&ctx)) {
+		pr_debug("Failed to denormalize address");
+		goto out_err;
+	}
+
+	lgcy_mmio_hole_en = ctx.reg_base_addr & BIT(1);
+	dram_base_addr	  = (ctx.reg_base_addr & GENMASK_ULL(31, 12)) << 16;
+
+	dram_limit_addr	  = ((ctx.reg_limit_addr & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
+
 	/* Add dram base address */
 	ctx.ret_addr += dram_base_addr;
 
@@ -1339,12 +1354,12 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
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

