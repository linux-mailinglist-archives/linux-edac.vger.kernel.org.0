Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FCF43E7E6
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 20:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhJ1SCr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:02:47 -0400
Received: from mail-dm6nam12on2069.outbound.protection.outlook.com ([40.107.243.69]:57605
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231627AbhJ1SBW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAzgzfU9vM+G28nrGu5kMZQBN1gWjeWcNPTyrif8dmniYuUBQCHAfBmIqChZOVoCmitqul5XoDZspcP62GpWmCkeJlRMn6rba6q//R3HU9m3X1ROmE9xuzcoJ53WeBlANA+48tfcqlm+qHCCLxfchHkv+zScW4fGTWWlT+0CFg3M0SxjFi54BueXKibKQTQFdRYIO0l6VUf8O27hciYhwL7wftG70eZLWPNnHSepmK/zHXcn493NI4FnYMWrQKlXNMsqoBzZrU9bpl+9h/lcaLNVs4MmArHFvkk2C5u0pmNIvlwaiwesHRtlQe8uknCxHprNdzs85N4VGtnrJtRibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dv9LD9uaDDCKxEGGT17rB4HxQRkXtoZ7/rVibEQ4+8E=;
 b=XXv1dbuX1mVycVNPx/wu4BhT+BCoMWOH58dDU4Y+yb1aAvlB9/uAFociCzGDziZruUyGkL3lTYYzBPJkTaoqyyZWBQodqCl7wgysQ/Ta9R3UY/WkGf/viSWAbmwGBGGGtwgwZ96Y4f6vi4UB2m64j6ep3402T4LYKeyvmmb2sNkFkzcIQayf3m6j39cvvJtzduN7mu+lkWKWQZJvAL796UPPO2nUo3szeqEcMpTDVIz2ULaN+dzS35IDtHLydrF6WF3tJxtJdWzEVxdv/6olt5KQjbWVFYhPrbxctYIu1ClwNuHGtjTCXAw8/PXcUd3UGw4dfCspWUzu79A/ugDP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv9LD9uaDDCKxEGGT17rB4HxQRkXtoZ7/rVibEQ4+8E=;
 b=I6KyNcs2I5sj3Ax2XFIHz8ScML/KsmjF9jGUKZZwS9a8z8oRztRXjmDfBA/eWRp6R3lTj4uW1DzR6hK8aHHJVb7XPhoeBycmtyygTHQ4B1+rrmtmEYohXotdIvuBUf3oP96BEP+EgbJudY6n8/j4y2y0Vv068ecfL7/PtsukA1M=
Received: from MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::21)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 17:58:51 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::f8) by MW4P223CA0016.outlook.office365.com
 (2603:10b6:303:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:50 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:49 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 33/33] EDAC/amd64: Add address translation support for DF3.5
Date:   Thu, 28 Oct 2021 17:57:28 +0000
Message-ID: <20211028175728.121452-34-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4692cb02-6ac7-4076-257f-08d99a3c9946
X-MS-TrafficTypeDiagnostic: MN2PR12MB4471:
X-Microsoft-Antispam-PRVS: <MN2PR12MB44713A2FEE468C655A0489C0F8869@MN2PR12MB4471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfD+nmrMwMVtevOwfj3b5RII1enKckHRngFyOyGlfWs1uWCYqWdG/eb3Gl0gRg68Ve0LP0ZjrRvatOVbSol1le9H9hukBR2SN7Kb/WtuhyFn0/y/NApl0+XcxGJYsTmouz/zBcWVzQQq5CKEq1igXwXE1+tTLlaP7Y7ulqqJKz7WbqfL4g+NER5O4k9eatirhunyTkk/WeVr7a2kMflZSZuo0X0DkVSBXvdk9okOfGWC9ODT1mwkjljXL86H7S6yslOZ7hpDguiLKumsXbLaxQ8zATzzEVF8UIetUUP0N0cnmXZZFbI0cXcNw1cqIRP621fcNQ0uu0dJfGBKwsPFMEvfLcKa7jYGkkzhLuK94hr4yCGzAvQk+pvHMCo3zxyHX+8ryg+rMiNcRMzTXakED2/M8SnK3Fgwq4C3qbz6KO/+qf5skuk1TlceDVD0wmL8+7sMUQZRPYNiYJGbdJWCf7hacX4ncwiCPoe7EuAFli9ckdJFjwfZkN+OhHEV+pYklp8w7XQ0NOX8v+H68Sm8hkiWhbNN1cXVOEE6jh35QiAHT4ihOlbiFmSJqVYnvZ2eETvPwTLTWm8uFYbxeuJc18Esuh5f8eY7GmcrOikualA5+HlghNMtXyFu+eI0FQ8ei3j/i6mtfbKkUa5E+ESHyJt8fC+ohXb9GmPcaReExWaMpA38C2t1ovAaEwXhgf8S24hdSZHOY/ZFS1BuUwS1OkLWc01NuaylOpA9l1axUxh57WEnABkKFleYO2ojdMJi266VPE+2VZYp1BCbrPPLrlT/yM7ZyLt4+N5pzt0Qrb1EfbwlyTjpJIsJPhVHOtIzZF8FQ+KQT56jLx6WoeoERS9ID/OEKxk4Rn7ohEng/xA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8676002)(1076003)(186003)(6916009)(5660300002)(356005)(508600001)(2616005)(426003)(47076005)(316002)(86362001)(966005)(36756003)(54906003)(16526019)(4326008)(336012)(36860700001)(82310400003)(44832011)(7696005)(81166007)(26005)(70206006)(8936002)(6666004)(2906002)(83380400001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:50.8123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4692cb02-6ac7-4076-257f-08d99a3c9946
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Add support for address translation on Data Fabric version 3.5.

Add new data fabric ops and interleaving modes. Also, adjust how the
DRAM address maps are found early in the translation for certain cases.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210630152828.162659-7-nchatrad@amd.com

v2->v3:
* New in v3. Original version at link above.
* Squashed the following into this patch:
  https://lkml.kernel.org/r/20210630152828.162659-8-nchatrad@amd.com
* Dropped "df_regs" use.
* Set "df_ops" during module init.
* Dropped hard-coded Node ID values.

 drivers/edac/amd64_edac.c | 224 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 220 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index bc1aa6292408..9728571f9d67 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -989,6 +989,7 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 /*
  * Glossary of acronyms used in address translation for Zen-based systems
  *
+ * CCM		=	CPU Core Coherent Module
  * COD		=	Cluster-on-Die
  * CS		=	Coherent Slave
  * DF		=	Data Fabric
@@ -1064,9 +1065,14 @@ enum intlv_modes {
 	NOHASH_2CH	= 0x01,
 	NOHASH_4CH	= 0x03,
 	NOHASH_8CH	= 0x05,
+	NOHASH_16CH	= 0x07,
+	NOHASH_32CH	= 0x08,
 	HASH_COD4_2CH	= 0x0C,
 	HASH_COD2_4CH	= 0x0D,
 	HASH_COD1_8CH	= 0x0E,
+	HASH_8CH	= 0x1C,
+	HASH_16CH	= 0x1D,
+	HASH_32CH	= 0x1E,
 	DF2_HASH_2CH	= 0x21,
 };
 
@@ -1080,6 +1086,7 @@ struct addr_ctx {
 	u32 reg_limit_addr;
 	u32 reg_fab_id_mask0;
 	u32 reg_fab_id_mask1;
+	u32 reg_fab_id_mask2;
 	u16 cs_fabric_id;
 	u16 die_id_mask;
 	u16 socket_id_mask;
@@ -1416,6 +1423,157 @@ struct data_fabric_ops df3_ops = {
 	.get_component_id_mask		=	get_component_id_mask_df3,
 };
 
+static int dehash_addr_df35(struct addr_ctx *ctx)
+{
+	u8 hashed_bit, intlv_ctl_64k, intlv_ctl_2M, intlv_ctl_1G;
+	u8 num_intlv_bits = ctx->intlv_num_chan;
+	u32 i;
+
+	/* Read D18F0x3F8 (DfGlobalCtrl). */
+	if (df_indirect_read_broadcast(0, 0, 0x3F8, &ctx->tmp))
+		return -EINVAL;
+
+	intlv_ctl_64k = !!((ctx->tmp >> 20) & 0x1);
+	intlv_ctl_2M  = !!((ctx->tmp >> 21) & 0x1);
+	intlv_ctl_1G  = !!((ctx->tmp >> 22) & 0x1);
+
+	/*
+	 * CSSelect[0] = XOR of addr{8,  16, 21, 30};
+	 * CSSelect[1] = XOR of addr{9,  17, 22, 31};
+	 * CSSelect[2] = XOR of addr{10, 18, 23, 32};
+	 * CSSelect[3] = XOR of addr{11, 19, 24, 33}; - 16 and 32 channel only
+	 * CSSelect[4] = XOR of addr{12, 20, 25, 34}; - 32 channel only
+	 */
+	for (i = 0; i < num_intlv_bits; i++) {
+		hashed_bit =	((ctx->ret_addr >> (8 + i)) ^
+				((ctx->ret_addr >> (16 + i)) & intlv_ctl_64k) ^
+				((ctx->ret_addr >> (21 + i)) & intlv_ctl_2M) ^
+				((ctx->ret_addr >> (30 + i)) & intlv_ctl_1G));
+
+		hashed_bit &= BIT(0);
+		if (hashed_bit != ((ctx->ret_addr >> (8 + i)) & BIT(0)))
+			ctx->ret_addr ^= BIT(8 + i);
+	}
+
+	return 0;
+}
+
+static int get_intlv_mode_df35(struct addr_ctx *ctx)
+{
+	ctx->intlv_mode = (ctx->reg_base_addr >> 2) & 0x1F;
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
+		ctx->dehash_addr		= dehash_addr_df35;
+	}
+
+	return 0;
+}
+
+static void get_intlv_num_dies_df35(struct addr_ctx *ctx)
+{
+	ctx->intlv_num_dies  = (ctx->reg_base_addr >> 7) & 0x1;
+}
+
+static u8 get_die_id_shift_df35(struct addr_ctx *ctx)
+{
+	return ctx->node_id_shift;
+}
+
+static u8 get_socket_id_shift_df35(struct addr_ctx *ctx)
+{
+	return (ctx->reg_fab_id_mask1 >> 8) & 0xF;
+}
+
+static int get_masks_df35(struct addr_ctx *ctx)
+{
+	/* Read D18F1x150 (SystemFabricIdMask0). */
+	if (df_indirect_read_broadcast(0, 1, 0x150, &ctx->reg_fab_id_mask0))
+		return -EINVAL;
+
+	/* Read D18F1x154 (SystemFabricIdMask1). */
+	if (df_indirect_read_broadcast(0, 1, 0x154, &ctx->reg_fab_id_mask1))
+		return -EINVAL;
+
+	/* Read D18F1x158 (SystemFabricIdMask2). */
+	if (df_indirect_read_broadcast(0, 1, 0x158, &ctx->reg_fab_id_mask2))
+		return -EINVAL;
+
+	ctx->node_id_shift = ctx->reg_fab_id_mask1 & 0xF;
+
+	ctx->die_id_mask = ctx->reg_fab_id_mask2 & 0xFFFF;
+
+	ctx->socket_id_mask = (ctx->reg_fab_id_mask2 >> 16) & 0xFFFF;
+
+	return 0;
+}
+
+static u16 get_dst_fabric_id_df35(struct addr_ctx *ctx)
+{
+	return ctx->reg_limit_addr & 0xFFF;
+}
+
+/* Aldebaran nodes have an arbitrary UMC to CS mapping based on physical layout. */
+u8 umc_to_cs_mapping_aldebaran[] = {	28, 20, 24, 16, 12, 4, 8, 0,
+					6, 30, 2, 26, 22, 14, 18, 10,
+					19, 11, 15, 7, 3, 27, 31, 23,
+					9, 1, 5, 29, 25, 17, 21, 13};
+
+int get_umc_to_cs_mapping(struct addr_ctx *ctx)
+{
+	if (ctx->inst_id >= sizeof(umc_to_cs_mapping_aldebaran))
+		return -EINVAL;
+
+	ctx->inst_id = umc_to_cs_mapping_aldebaran[ctx->inst_id];
+
+	return 0;
+}
+
+static int get_cs_fabric_id_df35(struct addr_ctx *ctx)
+{
+	u16 nid = ctx->nid;
+
+	/* Special handling for GPU nodes.*/
+	if (nid >= amd_cpu_node_count()) {
+		if (get_umc_to_cs_mapping(ctx))
+			return -EINVAL;
+
+		/* Need to convert back to the hardware-provided Node ID. */
+		nid -= amd_cpu_node_count();
+		nid += amd_gpu_node_start_id();
+	}
+
+	ctx->cs_fabric_id = ctx->inst_id | (nid << ctx->node_id_shift);
+
+	return 0;
+}
+
+static u16 get_component_id_mask_df35(struct addr_ctx *ctx)
+{
+	return ctx->reg_fab_id_mask0 & 0xFFFF;
+}
+
+struct data_fabric_ops df3point5_ops = {
+	.get_hi_addr_offset		=	get_hi_addr_offset_df3,
+	.get_intlv_mode			=	get_intlv_mode_df35,
+	.get_intlv_addr_sel		=	get_intlv_addr_sel_df3,
+	.get_intlv_num_dies		=	get_intlv_num_dies_df35,
+	.get_intlv_num_sockets		=	get_intlv_num_sockets_df3,
+	.get_masks			=	get_masks_df35,
+	.get_die_id_shift		=	get_die_id_shift_df35,
+	.get_socket_id_shift		=	get_socket_id_shift_df35,
+	.get_dst_fabric_id		=	get_dst_fabric_id_df35,
+	.get_cs_fabric_id		=	get_cs_fabric_id_df35,
+	.get_component_id_mask		=	get_component_id_mask_df35,
+};
+
 struct data_fabric_ops *df_ops;
 
 static int get_blk_inst_cnt(struct addr_ctx *ctx)
@@ -1512,8 +1670,17 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 		break;
 	case NOHASH_8CH:
 	case HASH_COD1_8CH:
+	case HASH_8CH:
 		ctx->intlv_num_chan = 3;
 		break;
+	case NOHASH_16CH:
+	case HASH_16CH:
+		ctx->intlv_num_chan = 4;
+		break;
+	case NOHASH_32CH:
+	case HASH_32CH:
+		ctx->intlv_num_chan = 5;
+		break;
 	default:
 		/* Valid interleaving modes where checked earlier. */
 		break;
@@ -1618,6 +1785,42 @@ static int addr_over_limit(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int find_ccm_instance_id(struct addr_ctx *ctx)
+{
+	for (ctx->inst_id = 0; ctx->inst_id < ctx->num_blk_instances; ctx->inst_id++) {
+		/* Read D18F0x44 (FabricBlockInstanceInformation0). */
+		if (df_indirect_read_instance(0, 0, 0x44, ctx->inst_id, &ctx->tmp))
+			return -EINVAL;
+
+		if (ctx->tmp == 0)
+			continue;
+
+		if ((ctx->tmp & 0xF) == 0)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+#define DF_NUM_DRAM_MAPS_AVAILABLE  16
+static int find_map_reg_by_dstfabricid(struct addr_ctx *ctx)
+{
+	u16 node_id_mask = (ctx->reg_fab_id_mask0 >> 16) & 0xFFFF;
+	u16 dst_fabric_id;
+
+	for (ctx->map_num = 0; ctx->map_num < DF_NUM_DRAM_MAPS_AVAILABLE ; ctx->map_num++) {
+		if (get_dram_addr_map(ctx))
+			continue;
+
+		dst_fabric_id = df_ops->get_dst_fabric_id(ctx);
+
+		if ((dst_fabric_id & node_id_mask) == (ctx->cs_fabric_id & node_id_mask))
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 df_inst_id)
 {
 	struct addr_ctx ctx;
@@ -1633,6 +1836,9 @@ static int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 df_inst_id)
 	ctx.nid = nid;
 	ctx.inst_id = df_inst_id;
 
+	if (df_ops == &df3point5_ops)
+		ctx.late_hole_remove = true;
+
 	if (get_blk_inst_cnt(&ctx))
 		return -EINVAL;
 
@@ -1642,11 +1848,20 @@ static int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 df_inst_id)
 	if (df_ops->get_cs_fabric_id(&ctx))
 		return -EINVAL;
 
-	if (remove_dram_offset(&ctx))
-		return -EINVAL;
+	/* Special handling for GPU nodes.*/
+	if (ctx.nid >= amd_cpu_node_count()) {
+		if (find_ccm_instance_id(&ctx))
+			return -EINVAL;
 
-	if (get_dram_addr_map(&ctx))
-		return -EINVAL;
+		if (find_map_reg_by_dstfabricid(&ctx))
+			return -EINVAL;
+	} else {
+		if (remove_dram_offset(&ctx))
+			return -EINVAL;
+
+		if (get_dram_addr_map(&ctx))
+			return -EINVAL;
+	}
 
 	if (df_ops->get_intlv_mode(&ctx))
 		return -EINVAL;
@@ -4644,6 +4859,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 				pvt->ops = &family_types[F19_CPUS].ops;
 				family_types[F19_CPUS].ctl_name = "F19h_M30h";
 			}
+			df_ops	= &df3point5_ops;
 		} else {
 			pvt->fam_type	= &family_types[F19_CPUS];
 			pvt->ops	= &family_types[F19_CPUS].ops;
-- 
2.25.1

