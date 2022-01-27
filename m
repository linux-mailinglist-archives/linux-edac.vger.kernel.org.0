Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758B449EC9E
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344107AbiA0Ulm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:42 -0500
Received: from mail-mw2nam12on2055.outbound.protection.outlook.com ([40.107.244.55]:43855
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344098AbiA0Ull (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTGdn5RtO3tEj1GKgtbGe8jwXX6vSerc5cyZPImVt8jUItg/2a+8ZgH6xKzTvt286sMRSgPW0qNwrfpb55W55Lb/p4Jq9KORZ599z1R1Vd1FwK1HoTRGxTLG5cqhyAiWbLDYiv6Zb8AV1hxVunADjt3+pKQgg0akgYjIfaggUkKCW741oqw7RyZkMyfbgfC0n7auqLOoptcteQs0HLlSkHXvPm2BiMixReTjM+rqggHPt0VVp37s+9TMwC4zuezUpjn9F7RzeZPm33uKnc4DENoAcxAtpGoqmdWnOPmk7DgOaCNVaGDC/Ku9mc+ehuL9wzrNeUwCzPXxzj8W2dyPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaau8j8mz1VKvS54rIPbY6XGmtfiN0bZVuri4JnLClM=;
 b=NdU8z6gJkuhD3gXjfpQYjPASfP0fsDOfddzAOrCIbtnVOZ1FUiBxqga5l/b3K0qlt7uc/oxxqQK44nHz/JFE4bI/7sxMKwRTkiV+zI6V9TruAoCHgguoTNYsbqsvlKtMv2I4TUQsrKYrVA2ZlTvEMEb4mNQbAvKNYlKunrYd2wD/gtoWrkb/QOnzHlPfkzHRPxvrhJADnh2BDjEGvzSUb6GazmivWY8c2/TAjRB1T2JL/JEXv2PsO0511UMj/htPbIgj3hb0g6qU3GSY/V1zUHNd6zD+OjiRYNGTMNZYL1Vv9W1E3lNMOgSrIBNRGYU0LkF53XeBCDi8sXYKqqahjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaau8j8mz1VKvS54rIPbY6XGmtfiN0bZVuri4JnLClM=;
 b=WYU5IuPfdWDS5XThnZT3HRivXRq0KQhieC28o0Ds0fUN6LVrFyZIDxgdeLmP9dZ6DRsDBSFfeIp17nnvA3/njiKmjfEAmJH7NdkEomaRtzdiHMkKc2X8HkDbmlAVXFjV0PsYY6p7YAMU6FspJsSc60DnkLzpeYzA3KDNUcNCYKk=
Received: from MW4P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::6) by
 DM5PR12MB1499.namprd12.prod.outlook.com (2603:10b6:4:8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Thu, 27 Jan 2022 20:41:39 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::8d) by MW4P221CA0001.outlook.office365.com
 (2603:10b6:303:8b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:38 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:37 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 02/24] EDAC/amd64: Define functions for DramOffset
Date:   Thu, 27 Jan 2022 20:40:53 +0000
Message-ID: <20220127204115.384161-3-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3689b4b9-385b-4add-47af-08d9e1d56b1c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1499:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1499C066F23ED74E1ACA84D8F8219@DM5PR12MB1499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m3xSwejO64rx8vft4xGdOYOGDD6XZpZq9Lko7HhRVKSf3QsQalA4xkTjn6XOFqewtNx/cmzU9TbUc9etFeIge08erP0qsQzcWeG5tozetIKampHpJWsekkewJJqKkZNu9Kqcj4AlkruNTe9Rh++qyU5Dtuk0CyQ4EaAEajlqXUOp/KQnmoHk+41L0GOPewfOdaIe66CbKcn9epHtT3PmzzEAaAYdSMYy959QjF6ic6/7k2nzZx/fhyQ97gNMqtBQxbsg8+WTcgBoM0dJgHkxnaHHRdcn5eS2V/3Je4cqkDGvgzDvc8z6Toahdm7yGt1n/RKTe+lBncwqptnAhpL4y6SITX+uVWkKusF8Da2cGZ+CS1Qr6vyeTms38z2tqEkElh5bgCz8L4Z07iLi23/ladDLVAM1+sO0slVGJjbIRm8Oqa+ya9FnUb6OalXN0woHfmo9iHQEfW6uPJhkdSUU0t+I2zVk/v6PSimNXA4TXkoBjUKBXOPb/CI3DgueJy3+Es4bQfZsRJy/EHL9QgjvmlGKHiU/tZGBTixcW3fvQ+sj7FGfZpD28Ybdkqw0jtIngiBssPCVVqo7n8QauDHorFaS3pF8gEdU/ptyQ1g2HBgh+g3Er4bf4mJlmUiYL9qEe+CqvdwO6cRkFEoPizR9qMazd24nnTLBmSNnd3lzLAS6Blchz2jKYcxyV14SnEf85u9MUtv0N+W0xoMJWbVg1iHdZYBLYSQCh4CHvCN76PFd3yHUB9yCW7FAnR2lTrTrtk5hehI/1WoVwI/C+sV5pzWX55CPncnqSEXp8H+05Ho=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(7696005)(6666004)(44832011)(356005)(8936002)(5660300002)(70586007)(70206006)(8676002)(4326008)(82310400004)(2906002)(86362001)(508600001)(316002)(47076005)(40460700003)(36860700001)(966005)(83380400001)(16526019)(426003)(336012)(186003)(6916009)(54906003)(1076003)(26005)(36756003)(2616005)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:38.9060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3689b4b9-385b-4add-47af-08d9e1d56b1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1499
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add helper functions to read the DramOffset register and to remove the
offset from the calculated address.

The helper functions will be expanded in future DF versions.

Rename the "base" variable to "map_num" to indicate that this is the
address map number. An address map is defined with a base and limit
value. The map_num variable is used to select the proper base and limit
registers to use for the address translation.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-7-yazen.ghannam@amd.com

v3->v4:
* Include pr_debug() on failure.
* Remove leading whitespace in function pointer.

v2->v3:
* Was patch 7 in v2.
* Dropped "df_regs" use.

v1->v2:
* Moved from arch/x86 to EDAC.
* Add function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 60 ++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 639dfbea3348..837bca7eb1ff 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1057,21 +1057,62 @@ static int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo)
 	return __df_indirect_read(node, func, reg, DF_BROADCAST, lo);
 }
 
+/* Use "reg_" prefix for raw register values. */
 struct addr_ctx {
 	u64 ret_addr;
 	u32 tmp;
+	u32 reg_dram_offset;
 	u16 nid;
 	u8 inst_id;
+	u8 map_num;
 };
 
 struct data_fabric_ops {
+	u64	(*get_hi_addr_offset)(struct addr_ctx *ctx);
 };
 
+static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
+{
+	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
+}
+
 struct data_fabric_ops df2_ops = {
+	.get_hi_addr_offset		=	get_hi_addr_offset_df2,
 };
 
 struct data_fabric_ops *df_ops;
 
+static int get_dram_offset_reg(struct addr_ctx *ctx)
+{
+	/* Read D18F0x1B4 (DramOffset) */
+	if (df_indirect_read_instance(ctx->nid, 0, 0x1B4, ctx->inst_id, &ctx->reg_dram_offset))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int remove_dram_offset(struct addr_ctx *ctx)
+{
+	if (get_dram_offset_reg(ctx)) {
+		pr_debug("Failed to get DRAM Offset register");
+		return -EINVAL;
+	}
+
+	ctx->map_num = 0;
+
+	/* Remove HiAddrOffset from normalized address, if enabled: */
+	if (ctx->reg_dram_offset & BIT(0)) {
+		u64 hi_addr_offset = df_ops->get_hi_addr_offset(ctx);
+
+		if (ctx->ret_addr >= hi_addr_offset) {
+			ctx->ret_addr -= hi_addr_offset;
+			ctx->map_num = 1;
+		}
+	}
+
+	return 0;
+}
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
@@ -1080,7 +1121,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
 	u8 intlv_addr_sel, intlv_addr_bit;
 	u8 num_intlv_bits, hashed_bit;
-	u8 lgcy_mmio_hole_en, base = 0;
+	u8 lgcy_mmio_hole_en;
 	u8 cs_mask, cs_id = 0;
 	bool hash_enabled = false;
 
@@ -1099,22 +1140,13 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	ctx.nid = nid;
 	ctx.inst_id = umc;
 
-	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
-	if (df_indirect_read_instance(nid, 0, 0x1B4, umc, &ctx.tmp))
+	if (remove_dram_offset(&ctx)) {
+		pr_debug("Failed to remove DRAM offset");
 		goto out_err;
-
-	/* Remove HiAddrOffset from normalized address, if enabled: */
-	if (ctx.tmp & BIT(0)) {
-		u64 hi_addr_offset = (ctx.tmp & GENMASK_ULL(31, 20)) << 8;
-
-		if (norm_addr >= hi_addr_offset) {
-			ctx.ret_addr -= hi_addr_offset;
-			base = 1;
-		}
 	}
 
 	/* Read D18F0x110 (DramBaseAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * base), umc, &ctx.tmp))
+	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * ctx.map_num), umc, &ctx.tmp))
 		goto out_err;
 
 	/* Check if address range is valid. */
@@ -1137,7 +1169,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	}
 
 	/* Read D18F0x114 (DramLimitAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x114 + (8 * base), umc, &ctx.tmp))
+	if (df_indirect_read_instance(nid, 0, 0x114 + (8 * ctx.map_num), umc, &ctx.tmp))
 		goto out_err;
 
 	intlv_num_sockets = (ctx.tmp >> 8) & 0x1;
-- 
2.25.1

