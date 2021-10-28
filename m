Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8302843E7CA
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhJ1SBz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:55 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:16352
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231500AbhJ1SBE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRwBR9bO9lASBvGGoFxWVg6RQy6M5h8wXLRBkhZkDrnXkmSPOrwfDImXf/5/fYbb9zRobUm34TMtsdI9knRjVL2D0kXlO7jMNw874Y7iMOawhjd8D1lLnwGLHHbdkThH8RRoQKwFrWc12wUhFCmrcOcjFggXaVwN2WJxTJQn0yZOBc020VnXS4pYDEi0Dz6cP4ie8wBwhgBBBkkty7VbuFBX87wSYYj+8/xBeAr8KG5R3atBnAPzNXGI7BsnU1ilux2RycRvBHhQbtcGU5IwY1J+NC9mzUETPYLUj+xA8wvMcjk5RhWX+9Qk/uZCQP0Yz8GFaR5yZOakAN7URNfv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGIYj1oK/hr0kZHVL5TcYWoxqJCJN6UBSauqrKBFwRQ=;
 b=k0oI2V5hYVtFBm+0MDpZUtoSeuAE5GCt8A8ohGOhm1CPlEikUM9+LBgfD90/CrKBJRTEudCtoM4eRxDtTrYoNp6EEVOxj7O7oeQ0v0jC0ObD134qGJTrV2A8qn3MyrEZORcLEyTST+58g5mZof0lrbgbHMTbfw+uVoVb534VQF+QpScM3NrMbbz477gY0ohFoN0RpCTxwVUaPN1gc4LlHG+ZUxITI1OeVpi8HqFiD/1V1LeybL9ln/DqAKmaO2EXJ7rAO8PZD3zMHOHSeUPYhwSbPGsANhmWi29z94WDMErtOM3k4BZjlTDGr5YpuJ1dlBRDaFgNaqmPA0k1ehGMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGIYj1oK/hr0kZHVL5TcYWoxqJCJN6UBSauqrKBFwRQ=;
 b=SFl3Jl/u1/16mKWyC21huXF0sPBrdWtSr2UowM6jUF6S8fkANAVljbDRMCWFsK+nqUPZ6NjtiLC963GCnbvbCd9F3+uCZTSYdMEeUEFHGz0D1uwYEuv9Pa3/2q1jMn9A5UyST9wyQ0K+C7Q/CODwkSuQuTDVmHmpA2wLLvchIDI=
Received: from CO1PR15CA0109.namprd15.prod.outlook.com (2603:10b6:101:21::29)
 by DM5PR12MB1641.namprd12.prod.outlook.com (2603:10b6:4:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 17:58:34 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::5a) by CO1PR15CA0109.outlook.office365.com
 (2603:10b6:101:21::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:33 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:31 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 21/33] EDAC/amd64: Define function to make space for CS ID
Date:   Thu, 28 Oct 2021 17:57:16 +0000
Message-ID: <20211028175728.121452-22-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0b3e02d4-1374-4c2d-40c9-08d99a3c8f37
X-MS-TrafficTypeDiagnostic: DM5PR12MB1641:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1641F54CB0F0036AB915265DF8869@DM5PR12MB1641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uU/kDT81h6d17S8cRZ0o8H3eMA4F66MXYXL+2YjIRAxbepsXRGyMhgigRT/R5ugzAgZOMWLRZk8woplSLcjk5UrVQtDna+QkrwWomq9TvwPIh1b75qwxRkl146GVTtic0lQdInR7+TPX6dDOTLF76PpYMhvg5hEM6HmzppYMjLTAscgq5EZZjfED78n5uqJsSIrrbDVrg2RxDCCGq2W+Ly/SHDzByqtXkszztJbaM7UUfqp1Aqq0IJ+9AKVynCH0/eajEjaUtd4RePVFTLO++8KHlSWa6C4fjG3AwIlXouZrByjUs2OXcpc1ETc5cPgKtmPo3jwSjMgm48c+cRTc+cMNgdyM5RTB0IfLH8p3Ibq3VveEqj/+brMshsYde3NPH+Xy9KKsApW2Nxog82zb4QmMJOInoJCZfAe5OihGz/YLwhKcnXH6hWlUwSAYurvft+5P48sU91lBd9qtAc5wkBWowLQJzBKQVdxfIvDLTlQSk5s5wCp6Gjl88sjJqdQWZ/Wvr55xYKDAhWaFDoPR/zTmQ4N89RlTJJoLcIp+u6axr8i2DtYrzU3nDAhEMHjIgv4cJWjV1saG/0lJ0qvY2RmwZIXyyCs4ZBQiG6i7rkwdS6bU94OrjgK9CdYQc6s+5advFqSkHUpmxfUoC4zddOT/CsiUm13ACWQtkI0gf78N1iht6GmK1ass9bmXMFhTF4i624GELiul6nINfy/W5iaWbq3+FPJDsY1HxVrWPBkMZ5PdJ+Z1KGLyB5vcrVTpFqZqTeezwXQlRcf0eKxwG//3UlrqNgychGwY8ayCOoON7MH1xPRZvGk/Ef0Yw//D
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(47076005)(70206006)(83380400001)(82310400003)(8676002)(36860700001)(7696005)(70586007)(336012)(2616005)(8936002)(44832011)(426003)(186003)(36756003)(4326008)(1076003)(508600001)(356005)(966005)(5660300002)(16526019)(81166007)(6666004)(54906003)(316002)(26005)(6916009)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:33.9514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3e02d4-1374-4c2d-40c9-08d99a3c8f37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1641
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move code that makes a gap for the CS ID into a separate helper function.
The exact bits to use vary based on interleaving mode. New interleaving
modes in future DF versions will be added as new cases.

Also, introduce a helper function that does the bit manipulation to make
the gap. The current version of this function is "simple", and future
interleaving modes may reuse this or use a more advanced function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-23-yazen.ghannam@amd.com

v2->v3:
* Was patch 22 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.
* Added new function pointer to ctx struct.

 drivers/edac/amd64_edac.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 78b69406b775..9ca822c1ea9c 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1073,6 +1073,7 @@ struct addr_ctx {
 	u8 intlv_num_sockets;
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
+	void (*make_space_for_cs_id)(struct addr_ctx *ctx);
 };
 
 struct data_fabric_ops {
@@ -1082,6 +1083,29 @@ struct data_fabric_ops {
 	void	(*get_intlv_num_sockets)	(struct addr_ctx *ctx);
 };
 
+static void expand_bits(u8 start_bit, u8 num_bits, u64 *value)
+{
+	u64 temp1, temp2;
+
+	if (start_bit == 0) {
+		*value <<= num_bits;
+		return;
+	}
+
+	temp1 = *value & GENMASK_ULL(start_bit - 1, 0);
+	temp2 = (*value & GENMASK_ULL(63, start_bit)) << num_bits;
+	*value = temp1 | temp2;
+}
+
+static void make_space_for_cs_id_simple(struct addr_ctx *ctx)
+{
+	u8 num_intlv_bits = ctx->intlv_num_chan;
+
+	num_intlv_bits += ctx->intlv_num_dies;
+	num_intlv_bits += ctx->intlv_num_sockets;
+	expand_bits(ctx->intlv_addr_bit, num_intlv_bits, &ctx->ret_addr);
+}
+
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
 {
 	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
@@ -1112,6 +1136,8 @@ static int get_intlv_mode_df2(struct addr_ctx *ctx)
 		ctx->dehash_addr = dehash_addr_df2;
 	}
 
+	ctx->make_space_for_cs_id = make_space_for_cs_id_simple;
+
 	if (ctx->intlv_mode != NONE &&
 	    ctx->intlv_mode != NOHASH_2CH &&
 	    ctx->intlv_mode != DF2_HASH_2CH)
@@ -1237,13 +1263,11 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	df_ops->get_intlv_num_dies(ctx);
 	df_ops->get_intlv_num_sockets(ctx);
 
-	num_intlv_bits = ctx->intlv_num_chan;
-	num_intlv_bits += ctx->intlv_num_dies;
-	num_intlv_bits += ctx->intlv_num_sockets;
+	ctx->make_space_for_cs_id(ctx);
 
 	if (num_intlv_bits > 0) {
-		u64 temp_addr_x, temp_addr_i, temp_addr_y;
 		u8 die_id_bit, sock_id_bit, cs_fabric_id;
+		u64 temp_addr_i;
 
 		/*
 		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
@@ -1298,11 +1322,8 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
 		 * there are (where "I" starts).
 		 */
-		temp_addr_y = ctx->ret_addr & GENMASK_ULL(ctx->intlv_addr_bit - 1, 0);
 		temp_addr_i = (ctx->cs_id << ctx->intlv_addr_bit);
-		temp_addr_x = (ctx->ret_addr & GENMASK_ULL(63, ctx->intlv_addr_bit))
-			       << num_intlv_bits;
-		ctx->ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
+		ctx->ret_addr |= temp_addr_i;
 	}
 
 	return 0;
-- 
2.25.1

