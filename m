Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA674A8AC4
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 18:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbiBCRvA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 12:51:00 -0500
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com ([40.107.243.59]:62369
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353086AbiBCRue (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsGo2JMMYLTqsfzoIrshwXFLwHkas6cD1geLu3XS/Rwi9fO1GEX16/rzqMTHbR0M/+l1Zn29nS0Hevr2xBWTFgeNOr5Uot9Yjfb/o/XPosMJ70cfwwR22OjNDD3kBN8h/b+GQJ9pEGbGakaN2y9kDrrEMQruS1gan+Z9Eg1N3KHwYKFd7yUppqOjQ3Cuon8eMW5c/g8Ojcwx+x3PGMl79isUWpTTu49ns+OrUc6z4aQvSLQ3G1VRsB55L4CrWS1DfSjJP5N7GCRYQzfSrO0+5n9Q2NM6KosaMQoQO01g8UvE9GbDB1PVMveozJHlEe3mO5We2HIlcbghJxSKDzWaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z81QHFc5J6IwgSiGu/++ELVqS2eRhOtUhZtPhuq6WWk=;
 b=IN0ENtaVnHiNz78F2kwRYwqX2dmoCgF5yTaXGBCgkxcLITtBUas11rR35jvom7/iBUYr8vizDkNqad7dw+BCCese3Yu9rc/JIJzoV4jWfysoWCfetYzDSEgVAI6a4ag/SyvSScvY44Duz7NqjUzyTyRZaQTBkIz91dBrg4autDSwoOQo3SLp3UNtLL09e/zRlukA9r01ZA+2WKOjS1nP5XeobIREpp2V02f2c11JSjN3hADwd/k6KIfUGArvj9gBjnIj0pfjdq7E+HOr1p5H8mJCBl4PxNs0KAq47P/I/Ljc3W4Rj4VtBj4oAY2tqS/1qdypbBniTfjTRZfeyhIxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z81QHFc5J6IwgSiGu/++ELVqS2eRhOtUhZtPhuq6WWk=;
 b=Cr1Z+YxpS8sV1Wrj874ZZHnTXHjtJEP3kPPsohOz5tgDjnBxWsY2WZZ+ht4WLsxSKAjR8wOAQCZ/WPgHa5Sv6Bl1eJy2QnIyl8CCzohud6YXsdt029f6qypqr7cwVFaFybDZk0+VIoMopQZIoHOIRZIEVQ0lk3/+icSk90YAxNA=
Received: from MW4PR02CA0005.namprd02.prod.outlook.com (2603:10b6:303:16d::14)
 by CY4PR1201MB0216.namprd12.prod.outlook.com (2603:10b6:910:18::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Thu, 3 Feb
 2022 17:50:31 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::d6) by MW4PR02CA0005.outlook.office365.com
 (2603:10b6:303:16d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Thu, 3 Feb 2022 17:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:50:31 +0000
Received: from node-bp128-r03d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 11:50:28 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v7 11/12] EDAC/amd64: Add address translation support for DF3.5
Date:   Thu, 3 Feb 2022 11:49:41 -0600
Message-ID: <20220203174942.31630-12-nchatrad@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203174942.31630-1-nchatrad@amd.com>
References: <20220203174942.31630-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4457a25-27b7-4463-7d19-08d9e73dac23
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0216:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02161B0C56AA8FAF93487907E8289@CY4PR1201MB0216.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBUdOf5Qvd5SEN4nCT1DKoSmTZGmVeqbdWh0Hufy393fuO844m02XKqbkWvhybUjPnjN0SlvO8r5gZdIWqMHnwdDjLnVvZ4z9iyggVMjyWQ0grHjvH1tWsgpgUSIu+zO9SMNLhEUXCyuOKzASJiZmtbBWSTTTZpWG+PYKRYlfGXXGf04693WT+B6bCcajENWAeFx/DrgyZ3aD7LgKFqfh5yv6ktbmCl8K7XFM4RaiBrVll1Wm3JBv/gjOKeWMyF94WiLu1Pv3MyUcADjXEjCCcQQwTUeoY0xqbfSizmdMLHyxilRTDxONcNW44HCSUg61XRQ6gVx1L44V2hWMwEUexCaWMyMJI9o6BWOFrdSGnwo7xNFrmuEmOr51cGcuHQKk1MZf6V9N7pnF5qSFjnHKpOECRxvFBHmzv3oC6PD6uCfnoBuhwCbbmIhrUqiMRDgSxgNkhOhP11JIzjBJkxygafp+mrcagJeiWLt71BXSJAYiN5EOcagOv0GdXPQG3pdtky2uRTRCXluXLcBjoIKZQabQmDLc5Z9Xdl9vgUwe/spMSbutY4r3R69sRK+NsZX3OirlTs2AZ2fPCBJVN9h42Cu91qi38SaxCZkrAAxZwaPg4kXcCislJuA6Rql4Uk+42lnFSvWTc/vBBB3igRYeIaKf7ruclUlvb0RWkCrU59Bpjgl/UK/xzQoAsMGmw00FDAmDqZyxqOmEPJqEKaH2t73CFZOvzw526CwDyGdazwqCYu2Z7A8Cw0DhDa1iSKyJl1LXofFNfb7lTzOyruGnXZGMsI58ufAQ8Um9WyV7EYEa+/pkmq+seLFHUUSumEZdhBOt36PlNHErkXVFwz3mQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(5660300002)(81166007)(83380400001)(82310400004)(2906002)(356005)(40460700003)(966005)(6666004)(70206006)(16526019)(336012)(186003)(426003)(1076003)(26005)(70586007)(47076005)(2616005)(316002)(36756003)(110136005)(8936002)(7696005)(508600001)(4326008)(8676002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:50:31.4945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4457a25-27b7-4463-7d19-08d9e73dac23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0216
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
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
Link:
https://lkml.kernel.org/r/20211028175728.121452-34-yazen.ghannam@amd.com

v3->v7:
* Was in patch 33 in v3.

v2->v3:
* New in v3. Original version at link above.
* Squashed the following into this patch:
  https://lkml.kernel.org/r/20210630152828.162659-8-nchatrad@amd.com
* Dropped "df_regs" use.
* Set "df_ops" during module init.
* Dropped hard-coded Node ID values.


 drivers/edac/amd64_edac.c | 216 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 209 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 8f2b5c8be651..6e0d617fd95f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1004,6 +1004,7 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 /*
  * Glossary of acronyms used in address translation for Zen-based systems
  *
+ * CCM         =       Cache Coherent Master
  * COD         =       Cluster-on-Die
  * CS          =       Coherent Slave
  * DF          =       Data Fabric
@@ -1084,9 +1085,14 @@ enum intlv_modes {
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
 
@@ -1100,6 +1106,7 @@ struct addr_ctx {
 	u32 reg_limit_addr;
 	u32 reg_fab_id_mask0;
 	u32 reg_fab_id_mask1;
+	u32 reg_fab_id_mask2;
 	u16 cs_fabric_id;
 	u16 die_id_mask;
 	u16 socket_id_mask;
@@ -1436,6 +1443,141 @@ struct data_fabric_ops df3_ops = {
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
+	/* Read D18F1x154 (SystemFabricIdMask1) */
+	if (df_indirect_read_broadcast(0, 1, 0x154, &ctx->reg_fab_id_mask1))
+		return -EINVAL;
+
+	/* Read D18F1x158 (SystemFabricIdMask2) */
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
+static int get_cs_fabric_id_df35(struct addr_ctx *ctx)
+{
+	u16 nid = ctx->nid;
+
+	/* Special handling for GPU nodes.*/
+	if (nid >= amd_nb_num()) {
+		if (get_umc_to_cs_mapping(ctx))
+			return -EINVAL;
+
+		/* Need to convert back to the hardware-provided Node ID. */
+		nid -= amd_nb_num();
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
@@ -1534,8 +1676,17 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
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
@@ -1642,6 +1793,44 @@ static int addr_over_limit(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int find_ccm_instance_id(struct addr_ctx *ctx)
+{
+	u32 temp;
+
+	for (ctx->inst_id = 0; ctx->inst_id < ctx->num_blk_instances; ctx->inst_id++) {
+		/* Read D18F0x44 (FabricBlockInstanceInformation0). */
+		if (df_indirect_read_instance(0, 0, 0x44, ctx->inst_id, &temp))
+			return -EINVAL;
+
+		if (temp == 0)
+			continue;
+
+		if ((temp & 0xF) == 0)
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
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	struct addr_ctx ctx;
@@ -1659,6 +1848,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	ctx.nid = nid;
 	ctx.inst_id = umc;
 
+	if (df_ops == &df3point5_ops)
+		ctx.late_hole_remove = true;
+
 	if (get_blk_inst_cnt(&ctx)) {
 		pr_debug("Failed to get Block Instance Count");
 		return -EINVAL;
@@ -1674,14 +1866,22 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		return -EINVAL;
 	}
 
-	if (remove_dram_offset(&ctx)) {
-		pr_debug("Failed to remove DRAM offset");
-		return -EINVAL;
-	}
+	if (ctx.nid >= amd_nb_num()) {
+		if (find_ccm_instance_id(&ctx))
+			return -EINVAL;
 
-	if (get_dram_addr_map(&ctx)) {
-		pr_debug("Failed to get DRAM address map");
-		return -EINVAL;
+		if (find_map_reg_by_dstfabricid(&ctx))
+			return -EINVAL;
+	} else {
+		if (remove_dram_offset(&ctx)) {
+			pr_debug("Failed to remove DRAM offset");
+			return -EINVAL;
+		}
+
+		if (get_dram_addr_map(&ctx)) {
+			pr_debug("Failed to get DRAM address map");
+			return -EINVAL;
+		}
 	}
 
 	if (df_ops->get_intlv_mode(&ctx)) {
@@ -4756,12 +4956,14 @@ static void per_family_init(struct amd64_pvt *pvt)
 				pvt->ops->populate_csrows	= gpu_init_csrows;
 				pvt->ops->get_umc_err_info	= gpu_update_umc_err_info;
 				pvt->ops->find_umc_inst_id	= gpu_df_inst_id;
+				df_ops				= &df3point5_ops;
 				goto end_fam;
 			} else {
 				pvt->ctl_name		= "F19h_M30h";
 				pvt->f0_id		= PCI_DEVICE_ID_AMD_19H_DF_F0;
 				pvt->f6_id		= PCI_DEVICE_ID_AMD_19H_DF_F6;
 				pvt->max_mcs		= 8;
+				df_ops			= &df3point5_ops;
 			}
 		} else {
 			pvt->ctl_name			= "F19h";
-- 
2.25.1

