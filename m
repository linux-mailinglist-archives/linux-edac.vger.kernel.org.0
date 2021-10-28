Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F96843E7A3
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhJ1SAn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:00:43 -0400
Received: from mail-dm6nam12on2044.outbound.protection.outlook.com ([40.107.243.44]:38368
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231139AbhJ1SAf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgZAaGkIpqghe47dsYVTyyqyq97fy3r1YZFIRuhrmbO800gLgJn/N4AmV0vUvZbzhIhPnOVY9aqQp9Pkx443D9joBrd/yqzfdmJfMgY3APSfyoYDUWMv/i/ll9vK0BDD5GQ9ZdzQb9bb9B/uxfGkXFs0MUvXvDg7ZlPBI9Hz1DYujEHsEgGLuiyoUUheBiU76Fd+IZO4eXlYgc80icB4DRXEhW4BdSsMW0Z24AWCwQHfff9zW+6lzlPxCILmkhxM/pdJ4HC/NB4+k2fyEj0T9M2UmvG3pIyAVC3ZifAdvYeNI212ruATr9y60pp0bw3/Q/bPlliQAljL26W1PQNOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSIVCGv6kJsJApyA0S4O30vPpjkC87V0Djf3fui7UcE=;
 b=jl6yCxLv3s5xFba/zc7c+00mmzUSW+IfQekWvVHyDmSzK8NiSiNHb6xS5r+VFhs1nYg8+i2UrqP/1c/5XM442L5moXfz/nl9kMYMFr/NAuOkkhT6Owp9fSmPgUaB1zSWKKdgsvTGwWtBdS1N3s9TfXJ8x9VBJsOnnu+JQckhs5URMx0Lc75VKSLmswX9RcXt2xiqENHE+BG2dK7dHPQ8zn5eFFSF3177HGf3qTywwN0n8lBM11UgaFpYxnaGZo9WHj3g9avVGr+80PSnqEgOQCjRsABu1m4AzQxv2fm9VRAyGOfnceDM22ey8u2Oc7VnpcyTfEnozMVxGf3xKmn6Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSIVCGv6kJsJApyA0S4O30vPpjkC87V0Djf3fui7UcE=;
 b=05VUgZfmiGBDaxL66i8FlNR1O79ziIuxeJM8On5B4Cf5qcYEHgowZXodvZcyvnxA+VhnyiKhUTncIl0tjQqMNs+65XGBGuuK1B9Bs2qLUsexGFE6VRpATMfm3zI67NQxl2j2lE9DI7cAEHs4g6yXlMN43flGznJimWqoa2b46g0=
Received: from CO2PR05CA0084.namprd05.prod.outlook.com (2603:10b6:102:2::52)
 by MN2PR12MB3136.namprd12.prod.outlook.com (2603:10b6:208:d1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 17:58:06 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::bd) by CO2PR05CA0084.outlook.office365.com
 (2603:10b6:102:2::52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:04 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:03 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 04/33] EDAC/amd64: Add context struct
Date:   Thu, 28 Oct 2021 17:56:59 +0000
Message-ID: <20211028175728.121452-5-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b9484b83-30d7-4ac6-b042-08d99a3c7de1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3136:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3136E8913CD9F1A5691A8DBEF8869@MN2PR12MB3136.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+1NPjip4HNU15aNmEpJy3HgQZeQ6iVK07EuEinJzTK8O7nxPuXooOz3J9XwWva5TcU7FkOTq7CKZC+UyrB2yahd1TIJUX7oF2uldwjXXmw+Amyl2cQ+XrE2EGeuz8ONACOypI4ryCMUIBzt/lfIAbYUG+xZ60Ohrda6pNYI3vxcDAZryhwkFMXrZXhj/T8R1DlXjXN+zbxbWbATmvVonC+T1ZJSmmDnV2qmrh85QAi/yO6JAWI+BtBcobXyPMSWhaiW4H1n2XfCG0QMvYW/L71BiCVkjdNukbiEXQX68lXa/OTtfe4y9WbIyDhp1YNMTftTuk4PdRrWpBzeD6HkZ7/C8WGlX5E4YTKiauVaGPiSQORIf8DG47AzLIpCRl3ngZ6XvR4P+cC8ooZruNZCt89MfdRt10i5kUW9BiufxTYlhAFIoCwXg4ZlRqACNDncbN5wUuOkfXKW3qAA0+1/V0XCC6LixTKKDaUYbJaIurQQzxBd9plM/3E9RJHuDZWdwQBrS63KA5qTuJrVcbL4Gf6q5rzltson8z1iiUtM86csbI7BjzpdnmcuwzyzzkCTLANqeNsoua5NoanCWLtHaFt8eXyiZs9Z3gGJ4LvgCJoAgpgySh8yX3xVOCjAWd2AYQNHfgvsgo3cHBr9fQdRClAIArx5XfRbWTjWro6qBWuDWoVMnHCVLc0tHgd5ChqRNzstLUPwTAefviV4SZsvQlbYzKjdOV6sqj8Fpe3TkC5bUDqVYY1JzcZSM5oGTEX/lJKJL5bpLlvoW1KvEkFetHH+ygo4j9i8ZCLZLI+5vzPvjCMPxOcE/vV9ibchhmkF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2616005)(336012)(47076005)(7696005)(426003)(966005)(36756003)(44832011)(6916009)(8936002)(508600001)(8676002)(1076003)(26005)(5660300002)(16526019)(186003)(70206006)(70586007)(4326008)(316002)(2906002)(82310400003)(83380400001)(86362001)(36860700001)(6666004)(54906003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:04.8704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9484b83-30d7-4ac6-b042-08d99a3c7de1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3136
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Define an address translation context struct. This will hold values that
will be passed between multiple functions.

Save return address, Node ID, and the Instance ID number to start.
Currently, the UMC number is used as the Instance ID, but future DF
versions may use another value.

Also include a "tmp" field to use when reading registers. This is to
avoid having to define a temporary variable in multiple functions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-6-yazen.ghannam@amd.com

v2->v3:
* Was patch 5 in v2.
* Included a "tmp" field.

v1->v2:
* Moved from arch/x86 to EDAC.
* Changed "umc" variable to "inst_id".
* Drop df_types enum.

 drivers/edac/amd64_edac.c | 97 ++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index bad230745d60..3fb137ea74b3 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1049,13 +1049,16 @@ static int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo)
 	return __df_indirect_read(node, func, reg, DF_BROADCAST, lo);
 }
 
+struct addr_ctx {
+	u64 ret_addr;
+	u32 tmp;
+	u16 nid;
+	u8 inst_id;
+};
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
-	/* We start from the normalized address */
-	u64 ret_addr = norm_addr;
-
-	u32 tmp;
 
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
@@ -1065,35 +1068,45 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	u8 cs_mask, cs_id = 0;
 	bool hash_enabled = false;
 
+	struct addr_ctx ctx;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	/* We start from the normalized address */
+	ctx.ret_addr = norm_addr;
+
+	ctx.nid = nid;
+	ctx.inst_id = umc;
+
 	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
-	if (df_indirect_read_instance(nid, 0, 0x1B4, umc, &tmp))
+	if (df_indirect_read_instance(nid, 0, 0x1B4, umc, &ctx.tmp))
 		goto out_err;
 
 	/* Remove HiAddrOffset from normalized address, if enabled: */
-	if (tmp & BIT(0)) {
-		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
+	if (ctx.tmp & BIT(0)) {
+		u64 hi_addr_offset = (ctx.tmp & GENMASK_ULL(31, 20)) << 8;
 
 		if (norm_addr >= hi_addr_offset) {
-			ret_addr -= hi_addr_offset;
+			ctx.ret_addr -= hi_addr_offset;
 			base = 1;
 		}
 	}
 
 	/* Read D18F0x110 (DramBaseAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * base), umc, &tmp))
+	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * base), umc, &ctx.tmp))
 		goto out_err;
 
 	/* Check if address range is valid. */
-	if (!(tmp & BIT(0))) {
+	if (!(ctx.tmp & BIT(0))) {
 		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
-			__func__, tmp);
+			__func__, ctx.tmp);
 		goto out_err;
 	}
 
-	lgcy_mmio_hole_en = tmp & BIT(1);
-	intlv_num_chan	  = (tmp >> 4) & 0xF;
-	intlv_addr_sel	  = (tmp >> 8) & 0x7;
-	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
+	lgcy_mmio_hole_en = ctx.tmp & BIT(1);
+	intlv_num_chan	  = (ctx.tmp >> 4) & 0xF;
+	intlv_addr_sel	  = (ctx.tmp >> 8) & 0x7;
+	dram_base_addr	  = (ctx.tmp & GENMASK_ULL(31, 12)) << 16;
 
 	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
 	if (intlv_addr_sel > 3) {
@@ -1103,12 +1116,12 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	}
 
 	/* Read D18F0x114 (DramLimitAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x114 + (8 * base), umc, &tmp))
+	if (df_indirect_read_instance(nid, 0, 0x114 + (8 * base), umc, &ctx.tmp))
 		goto out_err;
 
-	intlv_num_sockets = (tmp >> 8) & 0x1;
-	intlv_num_dies	  = (tmp >> 10) & 0x3;
-	dram_limit_addr	  = ((tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
+	intlv_num_sockets = (ctx.tmp >> 8) & 0x1;
+	intlv_num_dies	  = (ctx.tmp >> 10) & 0x3;
+	dram_limit_addr	  = ((ctx.tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
 
 	intlv_addr_bit = intlv_addr_sel + 8;
 
@@ -1159,10 +1172,10 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		 * umc/channel# as instance id of the coherent slave
 		 * for FICAA.
 		 */
-		if (df_indirect_read_instance(nid, 0, 0x50, umc, &tmp))
+		if (df_indirect_read_instance(nid, 0, 0x50, umc, &ctx.tmp))
 			goto out_err;
 
-		cs_fabric_id = (tmp >> 8) & 0xFF;
+		cs_fabric_id = (ctx.tmp >> 8) & 0xFF;
 		die_id_bit   = 0;
 
 		/* If interleaved over more than 1 channel: */
@@ -1176,22 +1189,22 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 
 		/* Read D18F1x208 (SystemFabricIdMask). */
 		if (intlv_num_dies || intlv_num_sockets)
-			if (df_indirect_read_broadcast(nid, 1, 0x208, &tmp))
+			if (df_indirect_read_broadcast(nid, 1, 0x208, &ctx.tmp))
 				goto out_err;
 
 		/* If interleaved over more than 1 die. */
 		if (intlv_num_dies) {
 			sock_id_bit  = die_id_bit + intlv_num_dies;
-			die_id_shift = (tmp >> 24) & 0xF;
-			die_id_mask  = (tmp >> 8) & 0xFF;
+			die_id_shift = (ctx.tmp >> 24) & 0xF;
+			die_id_mask  = (ctx.tmp >> 8) & 0xFF;
 
 			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
 		}
 
 		/* If interleaved over more than 1 socket. */
 		if (intlv_num_sockets) {
-			socket_id_shift	= (tmp >> 28) & 0xF;
-			socket_id_mask	= (tmp >> 16) & 0xFF;
+			socket_id_shift	= (ctx.tmp >> 28) & 0xF;
+			socket_id_mask	= (ctx.tmp >> 16) & 0xFF;
 
 			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
 		}
@@ -1204,44 +1217,44 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
 		 * there are (where "I" starts).
 		 */
-		temp_addr_y = ret_addr & GENMASK_ULL(intlv_addr_bit-1, 0);
+		temp_addr_y = ctx.ret_addr & GENMASK_ULL(intlv_addr_bit - 1, 0);
 		temp_addr_i = (cs_id << intlv_addr_bit);
-		temp_addr_x = (ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
-		ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
+		temp_addr_x = (ctx.ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
+		ctx.ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
 	}
 
 	/* Add dram base address */
-	ret_addr += dram_base_addr;
+	ctx.ret_addr += dram_base_addr;
 
 	/* If legacy MMIO hole enabled */
 	if (lgcy_mmio_hole_en) {
-		if (df_indirect_read_broadcast(nid, 0, 0x104, &tmp))
+		if (df_indirect_read_broadcast(nid, 0, 0x104, &ctx.tmp))
 			goto out_err;
 
-		dram_hole_base = tmp & GENMASK(31, 24);
-		if (ret_addr >= dram_hole_base)
-			ret_addr += (BIT_ULL(32) - dram_hole_base);
+		dram_hole_base = ctx.tmp & GENMASK(31, 24);
+		if (ctx.ret_addr >= dram_hole_base)
+			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
 	}
 
 	if (hash_enabled) {
 		/* Save some parentheses and grab ls-bit at the end. */
-		hashed_bit =	(ret_addr >> 12) ^
-				(ret_addr >> 18) ^
-				(ret_addr >> 21) ^
-				(ret_addr >> 30) ^
+		hashed_bit =	(ctx.ret_addr >> 12) ^
+				(ctx.ret_addr >> 18) ^
+				(ctx.ret_addr >> 21) ^
+				(ctx.ret_addr >> 30) ^
 				cs_id;
 
 		hashed_bit &= BIT(0);
 
-		if (hashed_bit != ((ret_addr >> intlv_addr_bit) & BIT(0)))
-			ret_addr ^= BIT(intlv_addr_bit);
+		if (hashed_bit != ((ctx.ret_addr >> intlv_addr_bit) & BIT(0)))
+			ctx.ret_addr ^= BIT(intlv_addr_bit);
 	}
 
 	/* Is calculated system address is above DRAM limit address? */
-	if (ret_addr > dram_limit_addr)
+	if (ctx.ret_addr > dram_limit_addr)
 		goto out_err;
 
-	*sys_addr = ret_addr;
+	*sys_addr = ctx.ret_addr;
 	return 0;
 
 out_err:
-- 
2.25.1

