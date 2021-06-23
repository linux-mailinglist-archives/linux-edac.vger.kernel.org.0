Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E893B2127
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFWTZT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:25:19 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:24416
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230503AbhFWTZC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:25:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSgdP6VV+NP6qPEhKV7LNQu8iEYW7f4HFVRjLSP1GH1c86Va9ZCfgunO5UytN7WJKSbPC10R/+Iw1JcCqD98HKXcvnh9KqymJQ37E5Pv+yWV3l/WnY0S6MPdfiYyRUyLGYEJvQuwAzorZEtw5F5Uo7N7z1uOxr0cgVlH2WnqYshSgXBFKIoRG2YjkmWek8somXw/BfZEP5JsZpYj+f/FCJpq3Cg5XjbPJdnUS8qi3ijX09Xb68+X+iOLIXje4z56LQbmX6QyKjtEHx4cuBCKRvMyr6Z7F7TgfdUY/9FBCmJrT9a7eHew+8i3ACPycRX8SXw3sQlfgxPStiiM6y1VeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yr2juxd80Sy4KDP1E9U/zLP1Gd/gCIRocNkbpzttvU=;
 b=kTgqdV7Bv3o92TNZbHPYDAelL+uwyByHZXZEoD4OJEcmf3jCpcJqVUhZ86Wsz1zS2ZTLK8NC2EOe8yxALQovzZhhtlpo/DEx9oBTyP7YhXoWUo2NLa0fP2lLqlNimE+kVJ2p+8iARfVN8a+8W+YIVK1SceaPTaqVKT6SjkJpB8kuAij4cEaHFz5/CneWbeJBXJNI/599PELIqYNYmdXhBHCFWosxq/634a2/yrZyVnZn1tX9vHYGzLjJr1ktuPU/Zv3GRMUCcnzCnLqG7cAy9V3E/z1qNrrtEYBJyfa0diYKJ/jR2D5Ql2Lj8s2+IYQrQL/UNM+D7oU8GzsI8KhRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yr2juxd80Sy4KDP1E9U/zLP1Gd/gCIRocNkbpzttvU=;
 b=QqZt/KELQo3W+zwsXEe44SnvIT4xrB5aF8FBpd++C2aYF4w1ydqJgBgmpBJXUk6a9z5lKdKGtK5SekeMfy3YNFtKjVUk16dDdOsfVm9IbpEAlZbhBrGnyaAKNlqoWPp+qCYfUR5dpyBHw/W/3LgXejUM1MckLLPGh2bOi7wW5Uo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3218.namprd12.prod.outlook.com (2603:10b6:408:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 19:21:35 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:21:35 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 30/31] EDAC/amd64: Add support for address translation on DF3 systems
Date:   Wed, 23 Jun 2021 19:20:01 +0000
Message-Id: <20210623192002.3671647-31-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210623192002.3671647-1-yazen.ghannam@amd.com>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:21:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8e4b337-709e-49d5-c9ea-08d9367c0bce
X-MS-TrafficTypeDiagnostic: BN8PR12MB3218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB321893B9789F55157B46D6ACF8089@BN8PR12MB3218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvlKx8ULE1xnZi8WXr2/pAu2m1aNC7c6uJE7SQdWNlzjXWT8wns71rxL7l8gg8vynVZ3UH+gHOcW68pO0GR64g9xBueTWtIi0lwpaGoVna+kGlNF1c4FWgGIBGgCoU99rzrGAxBNN9kVKoXH7gBUrmnUoiqEdUZFJfj9Wpp6ETakzHB4EZKdl3RWOTJiKomt6zwKS1JUAeDElRs6Fc76Q2cvzHCAEi4/KV9h1p8VMig3h4YJwiIe8wUcxOJpSV3bHr8uElX2HzA51XwWa8WdrvBqgzOVzt/JW8SS84CLJktwZdTh1L2gvlgRxUu2LKwYzwEB/Rrk7arDVuiL79mi3YlQed1I2OMSyq8c55GDPdi2W2amxi7ExVBpPvUEKJJlyLhdBMRGro7HlZIkV3dZVlOCOq65Fk1S8M3GFQHehp0Sp68UzFIOL0QGRn4cTU9tGSmFc39CG3krdWZYD7bdsFyVl8ipPzJN/V90qgYb4Kiazvr469+2MT6MuskY21joo5Kc1FUShPUmGzw+/N1HUpAt2K913igfDvN9JqVGdWqd1MJzvLdzZSTUmvSayp0jQ6DuSAxyEi9zE1HQXxOxXVtNRtTdnSf4j0OWH/AluxdFfDg1aEBTDRM8ojARBgmrEPjBb6Sw8O01I6CB4UWfcXlEZ86bMWeDRZyphR3PWqUrSFIpjEXizL0i+GIpFdc/HNhLEj3I3b3EQU9rw+PDgO4a9WWD7QA/8feEcTmUhXrfhSPbjeRgax/to5g2A787GJYZTPEddhcdvIExe4iSzB0DqU7fLRBk/1CatArthzT2ugNinnEbLJZ1V70HxN+F/gyumdXsIP23OZ5pkfBWdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(316002)(6486002)(6666004)(26005)(16526019)(38100700002)(38350700002)(956004)(44832011)(2616005)(86362001)(2906002)(186003)(1076003)(6916009)(966005)(83380400001)(478600001)(66946007)(5660300002)(7696005)(8676002)(8936002)(36756003)(52116002)(4326008)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iEgUmMfjk2JY06QPCvRO1XKUkmg764BN79kf6BOB0hYcrITY1noT4sYKxQGT?=
 =?us-ascii?Q?ZwrpVMAAdY5zLeZkKVnGkEr6f7Kam4yI207U1ewVV9fraEY1vsGZwYahYKpS?=
 =?us-ascii?Q?v4qFzSeKl1xQx8KFJd1xuVay7eM3LqGZgsDdYX+EnXk5hDRPfU4fyQOj99fv?=
 =?us-ascii?Q?Nc3Tj6nYGl+7KA3tbuAPu8EKt7AKJK9G4vZT2BLIfAqhxUluRFMqcoS/dnLW?=
 =?us-ascii?Q?v4vsuNanA9Y7/csINXbRMvdRzmlX1j9RlPuGeX3yWJP749opboXaUXs3WQIx?=
 =?us-ascii?Q?LKS207z3Gx1BAFRu27eThS7AlL7j0h5kjxTmss9aMIvbxnPfZDQo4JtDx2Xr?=
 =?us-ascii?Q?98shkx4J7of8YVDGoasgyW9dLENQxPz/pjySlNBoloE8srZc6oTjChukuIlG?=
 =?us-ascii?Q?l9PhYDnkiXzni83zFMbvu2UBFWPj12t7Q+7uc7TZhSyENzBJRsUu0VW3Tz5N?=
 =?us-ascii?Q?8Nsh94NQVNo4FBOQl+/x8KhW2tfEG9MWoBV2N/uQuD6xOLLOLpEtMO7g1XKs?=
 =?us-ascii?Q?zK8MLfICN0oBg3ss3eoYaH/pr38KbWzxhp8vaa3rJvuwPTuG0EHr9O/l97qB?=
 =?us-ascii?Q?cLoPyiZvZpJkAuwPixW+RS0NPFhS3RLdnBwkgXxwE/dWbhSZYe5hkGGsSuPL?=
 =?us-ascii?Q?XiQJ3v8rhydsjCZuOwSFlRKOOArWPtnAPU3qAmkIVj+GBa01t0jsrFtqiCeq?=
 =?us-ascii?Q?CqI03JeLUiH+l4MpG6LQgblUbMp8XCKP7ikxICGTumsSZ0vfal4SDvC++x/6?=
 =?us-ascii?Q?jVRNaJNWfrfvStnoaJFd92huTEz1wkPo32helGLKlQPtJ3ScMyaGP3UcHuJd?=
 =?us-ascii?Q?7dLZz0XMD8R6zY4hijYgGiH3XfquzYe8Gos/2UkoxPMOAOC9l20tyxFmXpwj?=
 =?us-ascii?Q?SiaGfh2gsNU4FXen2L/ySK/LcTfux+2v1/QErcAzUDVEzMBntcjwYS3NuAD3?=
 =?us-ascii?Q?RcG4SVD948f0O3Pldr1Ki/9EbnU9yMN3Uax1TCajCJvWrwrlY5cK1t5oBkk4?=
 =?us-ascii?Q?zDx/xTsQRjslzYzEkc8TeDElGAkhms/jk/aZwhKIwtw9YsLioobdnUiI7tLq?=
 =?us-ascii?Q?1qMyxtu0WcRQ1rHsV3xiW2Xc6iZnq/MQ5m1y3DtoqLycvSEsuSb+cDqQHs5r?=
 =?us-ascii?Q?y8BIoqIVSUAav/im7wUuIqajVXa2EgNKiQUykCZB98+NwMiA1tek0uuNl0T4?=
 =?us-ascii?Q?6BPqy7GgSuD5vo2x315D6ENBwDkUOHaSXQCRWQEADgmWKkNjmXKd9OJIm2l2?=
 =?us-ascii?Q?95NYgjdkuWlQVSNQixC9XhlzFNiSESzOLWWkdGbzO9gCOlj1vKLzgm4IPzVe?=
 =?us-ascii?Q?TJdqHLg57ijVs7d1V/ajen2I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e4b337-709e-49d5-c9ea-08d9367c0bce
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:21:05.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWs1h2bZdzn7yIgoKke/stxjCz1Or/z+GHQPUouJ43zB8ns0X7tH61SkdEXfZZkRXDG+Brl8jk5yoYWJqbb21w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3218
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
https://lkml.kernel.org/r/20210507190140.18854-26-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.
* Use function pointers as needed.

 drivers/edac/amd64_edac.c | 189 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 187 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index aa8b8d0b319d..882ac3fbc832 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1059,9 +1059,11 @@ enum df_reg_names {
 	DRAM_BASE_ADDR,
 	DRAM_LIMIT_ADDR,
 	DRAM_OFFSET,
+	DF_GLOBAL_CTL,
 
 	/* Function 1 */
 	SYS_FAB_ID_MASK,
+	SYS_FAB_ID_MASK_1,
 };
 
 static struct df_reg df_regs[] = {
@@ -1075,14 +1077,23 @@ static struct df_reg df_regs[] = {
 	[DRAM_LIMIT_ADDR]	=	{0, 0x114},
 	/* D18F0x1B4 (DramOffset) */
 	[DRAM_OFFSET]		=	{0, 0x1B4},
+	/* D18F0x3F8 (DfGlobalCtrl) */
+	[DF_GLOBAL_CTL]		=	{0, 0x3F8},
 	/* D18F1x208 (SystemFabricIdMask) */
 	[SYS_FAB_ID_MASK]	=	{1, 0x208},
+	/* D18F1x20C (SystemFabricIdMask1) */
+	[SYS_FAB_ID_MASK_1]	=	{1, 0x20C},
 };
 
 /* These are mapped 1:1 to the hardware values. Special cases are set at > 0x20. */
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
 
@@ -1094,6 +1105,7 @@ struct addr_ctx {
 	u32 reg_base_addr;
 	u32 reg_limit_addr;
 	u32 reg_fab_id_mask0;
+	u32 reg_fab_id_mask1;
 	u16 cs_fabric_id;
 	u16 die_id_mask;
 	u16 socket_id_mask;
@@ -1105,6 +1117,7 @@ struct addr_ctx {
 	u8 intlv_num_dies;
 	u8 intlv_num_sockets;
 	u8 cs_id;
+	u8 node_id_shift;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 	void (*make_space_for_cs_id)(struct addr_ctx *ctx);
 	void (*insert_cs_id)(struct addr_ctx *ctx);
@@ -1262,6 +1275,164 @@ struct data_fabric_ops df2_ops = {
 	.get_component_id_mask		=	&get_component_id_mask_df2,
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
+	u32 tmp;
+
+	if (amd_df_indirect_read(0, df_regs[DF_GLOBAL_CTL], DF_BROADCAST, &tmp))
+		return -EINVAL;
+
+	intlv_ctl_64k = !!((tmp >> 20) & 0x1);
+	intlv_ctl_2M  = !!((tmp >> 21) & 0x1);
+	intlv_ctl_1G  = !!((tmp >> 22) & 0x1);
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
+		ctx->make_space_for_cs_id = &make_space_for_cs_id_cod_hash;
+		ctx->insert_cs_id = &insert_cs_id_cod_hash;
+		ctx->dehash_addr = &dehash_addr_df3;
+	} else {
+		ctx->make_space_for_cs_id = &make_space_for_cs_id_simple;
+		ctx->insert_cs_id = &insert_cs_id_simple;
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
+	if (amd_df_indirect_read(0, df_regs[SYS_FAB_ID_MASK_1],
+				 DF_BROADCAST, &ctx->reg_fab_id_mask1))
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
+	.get_hi_addr_offset		=	&get_hi_addr_offset_df3,
+	.get_intlv_mode			=	&get_intlv_mode_df3,
+	.get_intlv_addr_sel		=	&get_intlv_addr_sel_df3,
+	.get_intlv_num_dies		=	&get_intlv_num_dies_df3,
+	.get_intlv_num_sockets		=	&get_intlv_num_sockets_df3,
+	.get_cs_fabric_id		=	&get_cs_fabric_id_df2,
+	.get_masks			=	&get_masks_df3,
+	.get_die_id_shift		=	&get_die_id_shift_df3,
+	.get_socket_id_shift		=	&get_socket_id_shift_df3,
+	.get_dst_fabric_id		=	&get_dst_fabric_id_df3,
+	.get_component_id_mask		=	&get_component_id_mask_df3,
+};
+
 struct data_fabric_ops *df_ops;
 
 static int set_df_ops(struct addr_ctx *ctx)
@@ -1270,6 +1441,11 @@ static int set_df_ops(struct addr_ctx *ctx)
 				 DF_BROADCAST, &ctx->reg_fab_id_mask0))
 		return -EINVAL;
 
+	if ((ctx->reg_fab_id_mask0 & 0xFF) != 0) {
+		df_ops = &df3_ops;
+		return 0;
+	}
+
 	df_ops = &df2_ops;
 
 	return 0;
@@ -1332,8 +1508,8 @@ static int get_intlv_addr_bit(struct addr_ctx *ctx)
 {
 	u8 intlv_addr_sel = df_ops->get_intlv_addr_sel(ctx);
 
-	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
-	if (intlv_addr_sel > 3) {
+	/* {0, 1, 2, 3, 4} map to address bits {8, 9, 10, 11, 12} respectively */
+	if (intlv_addr_sel > 4) {
 		pr_debug("Invalid interleave address select %d.\n", intlv_addr_sel);
 		return -EINVAL;
 	}
@@ -1351,9 +1527,18 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
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
-- 
2.25.1

