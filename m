Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF5543E7DB
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhJ1SC0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:02:26 -0400
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com ([40.107.237.69]:42721
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231321AbhJ1SBO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjybmDRo5ViNd01Hz928mLUC0p225xtcnbSJQJftmoCw4UPELu8DYn9UpgkNLzyo63xakU31VRXI7VDEumCRjiZcRv/+fGuCDTtrjDzQt9idQszKW8/oDT84qPhra6xGk48ca902nIBcZguXy+1V5XVVgEEgogHjs8kjHqNSECDy9hgy5h9QyIJzPpeIZwbXg1cYl9+z4oB70Vz/iWzS50VyGpheIIAWYLRL5AGJbjt0Cvh+6ViZ/DvhUK35nDBV9d/2r3Rr0viTuQ9Cgh2y6M8WFdVSVw5yJhiqOrc2CBqYXPxzi1ocPYNhF5sN4ziMQZRsGXtm7D1QUMVeKembqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jEETVgUBbJq/zvUDZedZdRIGRg+1+xuUj8MYAPDcY8=;
 b=VSuvCwj6ZkXv/s1eqQSbdiAMbeOv5XhBtmm3N7Ck4hlOspKo2lwaM2hO8gaWfaMC3Pjeie+HgGuDdZIlC8BErwSrTyylFiBLhMtLQnl2Q6Wzx823LmaXAcF3fK+R+k/PqTQMx+U4eVUBI0tJk9zPT1n4Yli5XLxxLarJDCXJpNvZVMS0XS5/bAXMPz8EXJJa1PytclGRBZQAqxmfXztgUXvRXEDflaw/UampP3eZ02NmXbvyko7KpXxJl3T/ugZFNXJ4AT41FobO9FTT2oevjbSY8Ybuq64vaeYbl4SQn6aPoRStdgaENBL5x569539YUSoFPGiHAz4v/UNmTcvNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jEETVgUBbJq/zvUDZedZdRIGRg+1+xuUj8MYAPDcY8=;
 b=zVJ7DgYK3Mp/JcCh3DhXnMBpM8xVETYX9WuytxC+vtZYh6cs4W8FSC5uv573Fub+zspeFjhjzijIB1YUiBQAqEW5JLHOhzSK3IeuGVcI7AL7ILMlCOy1+fHXR+gH3JLYNtERjLl344FhUFRWTgpW65w7+S9JrEXz5Nj3+r+VePQ=
Received: from MW4PR03CA0257.namprd03.prod.outlook.com (2603:10b6:303:b4::22)
 by CH0PR12MB5057.namprd12.prod.outlook.com (2603:10b6:610:e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 17:58:45 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::b8) by MW4PR03CA0257.outlook.office365.com
 (2603:10b6:303:b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:44 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:43 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 29/33] EDAC/amd64: Add support for address translation on DF3 systems
Date:   Thu, 28 Oct 2021 17:57:24 +0000
Message-ID: <20211028175728.121452-30-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec82d90b-6fe0-4b06-bed1-08d99a3c957b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5057:
X-Microsoft-Antispam-PRVS: <CH0PR12MB505724A996C1EE7B8A21B3D0F8869@CH0PR12MB5057.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lupimC2FoEYByR5RZ9UUO0bOlsYL0KXWP3UsnGQ8UdKfT4LvBBbCcUUiYil0Aj0VEtzthubTRfNHm1xwTxV8BuyKOaM7iPduI6xDvBmGJPbUoQuplP58KgSXbToVIC+vBja8wJVcVMc+/gu00qlUb9q98NrBi5kwVfbGdsVSh9elKiLgnh6K2b2Uga9hrwgsasSIvOUEivVQGVevhvbnzJdoWcVf+LNYVmEGfx8fgiOeFx7PHX/W2tTKv9WrXaeWdTIB+eTazd6ZvK+O2TgVaBzrR3IVwEsah8NsQGzrT1aSCu4VlJnafE182g+Cc73mkiMyLtacct0WHjrVg4OgKRhCVv8XEUG7V949FkbiRsn70vmzpKik04rFKecJ/QBGsGQqaM53jKO1IHFderhJ29XyRSHY+Tkh9imqPPpojdzlE+22mfdd0aQSyl6ntozAaPTJZPE7mfRECOt3Or4Yb+laTvSefZCw2bzUQ89LauuyTzZa9MO9hHHGJettfk6+OF6iwEmg85V2PACLXDHH6Pkjmz66jlglMk3HIFD/xCnCLlJwfAOmmllaX3xYqlrlBqFGtDgWyGqoaYHWmGPV5z7b46nGLX4m9wFmeEzdV30BIqzmdd+YLjtYGmTq50E83u8G/F3vTUVUml0iRrgkVa75C1FPyOMf6iAprSJvgK1cOki7rrWVulJpTotdzAxdiMFNd9nWTiXDASAge0TqD5ZWtjsbuRlOynzS7VY1KFlwGcMNFKUFIDZmehaW4yh8n0m7bEYlmXq8XyEaIaTqdteQucEEKa9IKE5uX0xWl/8z6w8QU61V2zg3iflcvOq6
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(1076003)(7696005)(5660300002)(316002)(356005)(26005)(81166007)(16526019)(83380400001)(8676002)(186003)(8936002)(4326008)(54906003)(6666004)(508600001)(82310400003)(86362001)(966005)(36860700001)(2616005)(70586007)(70206006)(44832011)(6916009)(36756003)(426003)(2906002)(47076005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:44.4676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec82d90b-6fe0-4b06-bed1-08d99a3c957b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5057
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
https://lkml.kernel.org/r/20210623192002.3671647-31-yazen.ghannam@amd.com

v2->v3:
* Was patch 30 in v2.
* Drop "df_regs" use.
* Set "df_ops" during module init.

v1->v2:
* Moved from arch/x86 to EDAC.
* Use function pointers as needed.

 drivers/edac/amd64_edac.c | 187 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index cf5849a9a969..c97b336361bc 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1053,6 +1053,11 @@ static int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo)
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
 
@@ -1065,6 +1070,7 @@ struct addr_ctx {
 	u32 reg_base_addr;
 	u32 reg_limit_addr;
 	u32 reg_fab_id_mask0;
+	u32 reg_fab_id_mask1;
 	u16 cs_fabric_id;
 	u16 die_id_mask;
 	u16 socket_id_mask;
@@ -1076,6 +1082,7 @@ struct addr_ctx {
 	u8 intlv_num_dies;
 	u8 intlv_num_sockets;
 	u8 cs_id;
+	u8 node_id_shift;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 	void (*make_space_for_cs_id)(struct addr_ctx *ctx);
 	void (*insert_cs_id)(struct addr_ctx *ctx);
@@ -1236,6 +1243,168 @@ struct data_fabric_ops df2_ops = {
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
@@ -1292,8 +1461,8 @@ static int get_intlv_addr_bit(struct addr_ctx *ctx)
 {
 	u8 intlv_addr_sel = df_ops->get_intlv_addr_sel(ctx);
 
-	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
-	if (intlv_addr_sel > 3) {
+	/* {0, 1, 2, 3, 4} map to address bits {8, 9, 10, 11, 12} respectively */
+	if (intlv_addr_sel > 4) {
 		pr_debug("Invalid interleave address select %d.\n", intlv_addr_sel);
 		return -EINVAL;
 	}
@@ -1311,9 +1480,18 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
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
@@ -4398,14 +4576,17 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
 			pvt->fam_type = &family_types[F17_M30H_CPUS];
 			pvt->ops = &family_types[F17_M30H_CPUS].ops;
+			df_ops	 = &df3_ops;
 			break;
 		} else if (pvt->model >= 0x60 && pvt->model <= 0x6f) {
 			pvt->fam_type = &family_types[F17_M60H_CPUS];
 			pvt->ops = &family_types[F17_M60H_CPUS].ops;
+			df_ops	 = &df3_ops;
 			break;
 		} else if (pvt->model >= 0x70 && pvt->model <= 0x7f) {
 			pvt->fam_type = &family_types[F17_M70H_CPUS];
 			pvt->ops = &family_types[F17_M70H_CPUS].ops;
+			df_ops	 = &df3_ops;
 			break;
 		}
 		fallthrough;
@@ -4423,6 +4604,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 			pvt->fam_type = &family_types[F17_M70H_CPUS];
 			pvt->ops = &family_types[F17_M70H_CPUS].ops;
 			pvt->fam_type->ctl_name = "F19h_M20h";
+			df_ops	 = &df3_ops;
 			break;
 		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
 			if (pvt->mc_node_id >= amd_cpu_node_count()) {
@@ -4438,6 +4620,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 			pvt->fam_type	= &family_types[F19_CPUS];
 			pvt->ops	= &family_types[F19_CPUS].ops;
 			family_types[F19_CPUS].ctl_name = "F19h";
+			df_ops		= &df3_ops;
 		}
 		break;
 
-- 
2.25.1

