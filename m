Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFA749ECBA
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344288AbiA0UmF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:42:05 -0500
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com ([40.107.244.54]:37152
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344189AbiA0Uly (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfHJGUqem2Sd1C4Ou7XyaYV1Sj9sm4z2PWqr3L0x/e68dFrd+YW3SLQY3n2mnQ8tuXrg9H0iuTtDaGKnXDKYiT1eEPVB/gcDsHMNoA6kKTPSb3hWbhUkTpPWh/TgaJ6jhEVNjSaGcdC4wxcJQZJgdKqob67jXgJfb9bA32BTenYA8LaV40NJR9POC5o4DbAVC+MDgzb/gu3INnUePS93A4HUysmPgSlo6f34jRFYOWsW+hYamjD/cR8WmI4HIsNbB/FtqYcKPAcKmxDH4m6Rc6Wdbu+hof3eBUtTIzQ618mYVAHKEmOvsP69X7oMTEjS3D4H+OKHzDRzP7f3YYdl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsAgl5IzAguiZ4HVqyiWLCVQ2XppYBxPAYdfYIPTvY8=;
 b=B4lGCYi7cSPs4DydlSvMfg67SFV9Qngq0F3ezfRCAZjgqoGNrswrvlrCGd3IrZLgMItsahjmHU/ies0d2z052RORHeaV+QbRBJ77Tk8rPsVEqJASR1yqVOJE/H73zJ0pqDIuKONij9BNzS4/WLWQ/duG2UZiCHFN3s/6rG4JIFs49ksk0EFbly/KGhQvTkWzTRO82v3h7Y7cUv4xPbXpIoQcXG2xNzPxRLGC0/6ZhMe2MelSlxOGPR3uHy17quZRvwmYJJpHjLPHT0IHaCoQzAseAV7hRK28xuapsfHUgCen/t6rXZOb3MALl0G+kfJn86ECW7tq6u3K4xuZ/TFhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsAgl5IzAguiZ4HVqyiWLCVQ2XppYBxPAYdfYIPTvY8=;
 b=fcRQxvhIDODDWDraARUMdqu9Z37W+aogoNIMRF2zx2W8RRHFQDDk0640iMAQFbIFOgywY4bSzssg7YzLrD7HWn9cznY9JMJJW2PYIWKWDqoSC+dUyLZpfcL19NGd4uV9wPb+2jTPiWyrHaVRDjy/3joBcXfjGIyV/ZJnOpjNcy0=
Received: from MWHPR17CA0076.namprd17.prod.outlook.com (2603:10b6:300:c2::14)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 27 Jan
 2022 20:41:53 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::ae) by MWHPR17CA0076.outlook.office365.com
 (2603:10b6:300:c2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:52 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:47 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 24/24] EDAC/amd64: Add support for address translation on DF3 systems
Date:   Thu, 27 Jan 2022 20:41:15 +0000
Message-ID: <20220127204115.384161-25-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 39f3dd8b-c110-4068-0e36-08d9e1d5732f
X-MS-TrafficTypeDiagnostic: PH0PR12MB5403:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5403F3DCB6FB5AEF0D94D1F9F8219@PH0PR12MB5403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiwT/OUBwsZvTqdmllbHQt/BSldy4T5PhKyRj8bw9SJnFRbhZHdhLOJUX1QzP8ZZVS5POyNzPUMnZ0FENgFXcKG2sFHzsmdE5jCuV3mCHrM6RYa1EBUYlP3FGhki0bcnpQeEEHsOAHQqrhdf8/tGdWmsllTsPuuRF101N97wYGXkQMh36C5/2VM2Q4i9+YUvo5m81d3nhs9TTZtM0MrwudjOVmwVoSlcuBpnRh9NOq1UDTdl91x/HSxYqLKz/3bl6fsPh8Zjy9qV5HhE8bgYWMyZTNFmjdbIiVaBXWX4g2B8jC0jyV4zA7b91NubDswnoBZIvZFHQHZiynCbNetHwTB7WQ2AfjO5375MxbpEgtcslI2SPqRdz0d48iPFj7zAVR5skR7+UvpZgeeukOGfM3O8nnqn+w4hUEf2xURrn2nXDs3RsJnpblCtgHthnfvmW83ZBSKWQvkXY3fgpvSDODF1nguE4oy7P6p4YJ2I7TQDvucUQYEc1xzE3lttf+VC4VpmgBnYO7fwORDEI2jbu32AimuTBPqbw4Lv0xh1j3/gJzrCVnda4pWTrS6uf17SRPqlfCtbKVrjvkU4huNTnGhjc5auls8Jp7T7CtpPlZFU2u1gE9DSX/77MV1YO1XcuqDmUHZQAK6nPBbuwvrjC+7e9Qw5OT16PDuoKBdtThlSwodK2BownJ0bCZ7wHU+1E1EHyDWlcdyf6qYm5Je1xkapweZqMispHcrhDqTucFdT9kM4q8mtzmBvV0BpR8KS9PBUAboVqIgq7raWM5NjDXF45ftaiIq4bWF9LGdRGy+hzpB2B9Qaso/TbI1zYIunTVP1Bre7ZHQ0i0XyMclHy1rBenWvMck/wb6IvFGUHY/XStEPR5sQqKth0tfd17+k
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700004)(46966006)(356005)(1076003)(508600001)(70586007)(5660300002)(82310400004)(40460700003)(26005)(316002)(36756003)(6666004)(6916009)(44832011)(8676002)(7696005)(2616005)(86362001)(966005)(2906002)(4326008)(70206006)(36860700001)(81166007)(54906003)(16526019)(8936002)(186003)(47076005)(83380400001)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:52.4352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f3dd8b-c110-4068-0e36-08d9e1d5732f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

DF3-based systems (Rome and later) support new interleaving modes and a
number of bit fields have changed or moved entirely. Add support for
these new modes and fields.

Refactoring should be minimal due to earlier changes, and most updates
will be additions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-30-yazen.ghannam@amd.com

v3->v4:
* Added glossary entry.

v2->v3:
* Was patch 30 in v2.
* Drop "df_regs" use.
* Set "df_ops" during module init.

v1->v2:
* Moved from arch/x86 to EDAC.
* Use function pointers as needed.

 drivers/edac/amd64_edac.c | 188 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 186 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 34405c8940fb..d213f9ecab16 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -991,6 +991,7 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 /*
  * Glossary of acronyms used in address translation for Zen-based systems
  *
+ * COD         =       Cluster-on-Die
  * CS          =       Coherent Slave
  * DF          =       Data Fabric
  */
@@ -1062,6 +1063,11 @@ static int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo)
 enum intlv_modes {
 	NONE		= 0x00,
 	NOHASH_2CH	= 0x01,
+	NOHASH_4CH	= 0x03,
+	NOHASH_8CH	= 0x05,
+	HASH_COD4_2CH	= 0x0C,
+	HASH_COD2_4CH	= 0x0D,
+	HASH_COD1_8CH	= 0x0E,
 	DF2_HASH_2CH	= 0x21,
 };
 
@@ -1074,6 +1080,7 @@ struct addr_ctx {
 	u32 reg_base_addr;
 	u32 reg_limit_addr;
 	u32 reg_fab_id_mask0;
+	u32 reg_fab_id_mask1;
 	u16 cs_fabric_id;
 	u16 die_id_mask;
 	u16 socket_id_mask;
@@ -1085,6 +1092,7 @@ struct addr_ctx {
 	u8 intlv_num_dies;
 	u8 intlv_num_sockets;
 	u8 cs_id;
+	u8 node_id_shift;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 	void (*make_space_for_cs_id)(struct addr_ctx *ctx);
 	void (*insert_cs_id)(struct addr_ctx *ctx);
@@ -1245,6 +1253,168 @@ struct data_fabric_ops df2_ops = {
 	.get_component_id_mask		=	get_component_id_mask_df2,
 };
 
+static u64 get_hi_addr_offset_df3(struct addr_ctx *ctx)
+{
+	return (ctx->reg_dram_offset & GENMASK_ULL(31, 12)) << 16;
+}
+
+static void make_space_for_cs_id_cod_hash(struct addr_ctx *ctx)
+{
+	u8 num_intlv_bits = ctx->intlv_num_chan;
+
+	num_intlv_bits += ctx->intlv_num_sockets;
+	expand_bits(ctx->intlv_addr_bit, 1, &ctx->ret_addr);
+	if (num_intlv_bits > 1)
+		expand_bits(12, num_intlv_bits - 1, &ctx->ret_addr);
+}
+
+static void insert_cs_id_cod_hash(struct addr_ctx *ctx)
+{
+	ctx->ret_addr |= ((ctx->cs_id & 0x1) << ctx->intlv_addr_bit);
+	ctx->ret_addr |= ((ctx->cs_id & 0xE) << 11);
+}
+
+static int dehash_addr_df3(struct addr_ctx *ctx)
+{
+	u8 hashed_bit, intlv_ctl_64k, intlv_ctl_2M, intlv_ctl_1G;
+
+	/* Read D18F0x3F8 (DfGlobalCtrl). */
+	if (df_indirect_read_broadcast(0, 0, 0x3F8, &ctx->tmp))
+		return -EINVAL;
+
+	intlv_ctl_64k = !!((ctx->tmp >> 20) & 0x1);
+	intlv_ctl_2M  = !!((ctx->tmp >> 21) & 0x1);
+	intlv_ctl_1G  = !!((ctx->tmp >> 22) & 0x1);
+
+	hashed_bit =	(ctx->ret_addr >> 14) ^
+			((ctx->ret_addr >> 18) & intlv_ctl_64k) ^
+			((ctx->ret_addr >> 23) & intlv_ctl_2M) ^
+			((ctx->ret_addr >> 32) & intlv_ctl_1G) ^
+			(ctx->ret_addr >> ctx->intlv_addr_bit);
+
+	hashed_bit &= BIT(0);
+
+	if (hashed_bit != ((ctx->ret_addr >> ctx->intlv_addr_bit) & BIT(0)))
+		ctx->ret_addr ^= BIT(ctx->intlv_addr_bit);
+
+	if (ctx->intlv_mode != HASH_COD2_4CH &&
+	    ctx->intlv_mode != HASH_COD1_8CH)
+		return 0;
+
+	hashed_bit =	(ctx->ret_addr >> 12) ^
+			((ctx->ret_addr >> 16) & intlv_ctl_64k) ^
+			((ctx->ret_addr >> 21) & intlv_ctl_2M) ^
+			((ctx->ret_addr >> 30) & intlv_ctl_1G);
+
+	hashed_bit &= BIT(0);
+
+	if (hashed_bit != ((ctx->ret_addr >> 12) & BIT(0)))
+		ctx->ret_addr ^= BIT(12);
+
+	if (ctx->intlv_mode != HASH_COD1_8CH)
+		return 0;
+
+	hashed_bit =	(ctx->ret_addr >> 13) ^
+			((ctx->ret_addr >> 17) & intlv_ctl_64k) ^
+			((ctx->ret_addr >> 22) & intlv_ctl_2M) ^
+			((ctx->ret_addr >> 31) & intlv_ctl_1G);
+
+	hashed_bit &= BIT(0);
+
+	if (hashed_bit != ((ctx->ret_addr >> 13) & BIT(0)))
+		ctx->ret_addr ^= BIT(13);
+
+	return 0;
+}
+
+static int get_intlv_mode_df3(struct addr_ctx *ctx)
+{
+	ctx->intlv_mode = (ctx->reg_base_addr >> 2) & 0xF;
+
+	if (ctx->intlv_mode == HASH_COD4_2CH ||
+	    ctx->intlv_mode == HASH_COD2_4CH ||
+	    ctx->intlv_mode == HASH_COD1_8CH) {
+		ctx->make_space_for_cs_id	= make_space_for_cs_id_cod_hash;
+		ctx->insert_cs_id		= insert_cs_id_cod_hash;
+		ctx->dehash_addr		= dehash_addr_df3;
+	} else {
+		ctx->make_space_for_cs_id	= make_space_for_cs_id_simple;
+		ctx->insert_cs_id		= insert_cs_id_simple;
+	}
+
+	return 0;
+}
+
+static u8 get_intlv_addr_sel_df3(struct addr_ctx *ctx)
+{
+	return (ctx->reg_base_addr >> 9) & 0x7;
+}
+
+static void get_intlv_num_dies_df3(struct addr_ctx *ctx)
+{
+	ctx->intlv_num_dies  = (ctx->reg_base_addr >> 6) & 0x3;
+}
+
+static void get_intlv_num_sockets_df3(struct addr_ctx *ctx)
+{
+	ctx->intlv_num_sockets = (ctx->reg_base_addr >> 8) & 0x1;
+}
+
+static u8 get_die_id_shift_df3(struct addr_ctx *ctx)
+{
+	return ctx->node_id_shift;
+}
+
+static u8 get_socket_id_shift_df3(struct addr_ctx *ctx)
+{
+	return ((ctx->reg_fab_id_mask1 >> 8) & 0x3) + ctx->node_id_shift;
+}
+
+static int get_masks_df3(struct addr_ctx *ctx)
+{
+	/* Read D18F1x208 (SystemFabricIdMask). */
+	if (df_indirect_read_broadcast(ctx->nid, 1, 0x208, &ctx->reg_fab_id_mask0))
+		return -EINVAL;
+
+	/* Read D18F1x20C (SystemFabricIdMask1) */
+	if (df_indirect_read_broadcast(0, 1, 0x20C, &ctx->reg_fab_id_mask1))
+		return -EINVAL;
+
+	ctx->node_id_shift = ctx->reg_fab_id_mask1 & 0xF;
+
+	ctx->die_id_mask = (ctx->reg_fab_id_mask1 >> 16) & 0x7;
+	ctx->die_id_mask <<= ctx->node_id_shift;
+
+	ctx->socket_id_mask = (ctx->reg_fab_id_mask1 >> 24) & 0x7;
+	ctx->socket_id_mask <<= ctx->node_id_shift;
+
+	return 0;
+}
+
+static u16 get_dst_fabric_id_df3(struct addr_ctx *ctx)
+{
+	return ctx->reg_limit_addr & 0x3FF;
+}
+
+static u16 get_component_id_mask_df3(struct addr_ctx *ctx)
+{
+	return ctx->reg_fab_id_mask0 & 0x3FF;
+}
+
+struct data_fabric_ops df3_ops = {
+	.get_hi_addr_offset		=	get_hi_addr_offset_df3,
+	.get_intlv_mode			=	get_intlv_mode_df3,
+	.get_intlv_addr_sel		=	get_intlv_addr_sel_df3,
+	.get_intlv_num_dies		=	get_intlv_num_dies_df3,
+	.get_intlv_num_sockets		=	get_intlv_num_sockets_df3,
+	.get_cs_fabric_id		=	get_cs_fabric_id_df2,
+	.get_masks			=	get_masks_df3,
+	.get_die_id_shift		=	get_die_id_shift_df3,
+	.get_socket_id_shift		=	get_socket_id_shift_df3,
+	.get_dst_fabric_id		=	get_dst_fabric_id_df3,
+	.get_component_id_mask		=	get_component_id_mask_df3,
+};
+
 struct data_fabric_ops *df_ops;
 
 static int get_dram_offset_reg(struct addr_ctx *ctx)
@@ -1303,8 +1473,8 @@ static int get_intlv_addr_bit(struct addr_ctx *ctx)
 {
 	u8 intlv_addr_sel = df_ops->get_intlv_addr_sel(ctx);
 
-	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
-	if (intlv_addr_sel > 3) {
+	/* {0, 1, 2, 3, 4} map to address bits {8, 9, 10, 11, 12} respectively */
+	if (intlv_addr_sel > 4) {
 		pr_debug("Invalid interleave address select %d.\n", intlv_addr_sel);
 		return -EINVAL;
 	}
@@ -1322,9 +1492,18 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 		ctx->intlv_num_chan = 0;
 		break;
 	case NOHASH_2CH:
+	case HASH_COD4_2CH:
 	case DF2_HASH_2CH:
 		ctx->intlv_num_chan = 1;
 		break;
+	case NOHASH_4CH:
+	case HASH_COD2_4CH:
+		ctx->intlv_num_chan = 2;
+		break;
+	case NOHASH_8CH:
+	case HASH_COD1_8CH:
+		ctx->intlv_num_chan = 3;
+		break;
 	default:
 		/* Valid interleaving modes where checked earlier. */
 		break;
@@ -4197,14 +4376,17 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
 			fam_type = &family_types[F17_M30H_CPUS];
 			pvt->ops = &family_types[F17_M30H_CPUS].ops;
+			df_ops	 = &df3_ops;
 			break;
 		} else if (pvt->model >= 0x60 && pvt->model <= 0x6f) {
 			fam_type = &family_types[F17_M60H_CPUS];
 			pvt->ops = &family_types[F17_M60H_CPUS].ops;
+			df_ops	 = &df3_ops;
 			break;
 		} else if (pvt->model >= 0x70 && pvt->model <= 0x7f) {
 			fam_type = &family_types[F17_M70H_CPUS];
 			pvt->ops = &family_types[F17_M70H_CPUS].ops;
+			df_ops	 = &df3_ops;
 			break;
 		}
 		fallthrough;
@@ -4226,6 +4408,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 			fam_type = &family_types[F17_M70H_CPUS];
 			pvt->ops = &family_types[F17_M70H_CPUS].ops;
 			fam_type->ctl_name = "F19h_M20h";
+			df_ops	 = &df3_ops;
 			break;
 		} else if (pvt->model >= 0x50 && pvt->model <= 0x5f) {
 			fam_type = &family_types[F19_M50H_CPUS];
@@ -4241,6 +4424,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		fam_type	= &family_types[F19_CPUS];
 		pvt->ops	= &family_types[F19_CPUS].ops;
 		family_types[F19_CPUS].ctl_name = "F19h";
+		df_ops		= &df3_ops;
 		break;
 
 	default:
-- 
2.25.1

