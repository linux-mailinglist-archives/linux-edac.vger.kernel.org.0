Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3BD376A70
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhEGTE5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:04:57 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:47105
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229524AbhEGTEn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:04:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFByIwK4y1skAlYPFr4vlsGUniAK1CvgR16rSe1ZX4weA+FtSrBuXqQRK2czM7CqzNeZrLgVLYUsRNNdUbXH+LhODMDEPvqpCBF7R0nDy7VGmcPdIXvq/RNgHoAGN+vW/MWAzBQbBA/qRcbBup+uB2Bq9C8ncrWV6bm9562+NDU2gG/cgdpFKnuZ1uzss6oJtFR86DKrJ9V4Czy75rOzsdLr5HikEhwwTz/q9M3+4laXGrcmgSEINBgdXqPQ5qEQwHQ8q63rpLbecqFCku0xhXfqIdLk5kcPqipT1arrg7Khle1IR38hvrgvIVMCpNWbcRT8IXVonrQhIVKqtQ1uwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MowLG4pc3Cv7Iu2+U9IBlBT6WV1b8EXd6OTID5R7VZo=;
 b=nQKtYbyVqDwd0gY7Fhrs7vWFaOg3M/184rN9cGAdvYz3AHcc/ZK5ZVfRGsbRvdfdR9ac5wtfPLCdLGe19w9juBPPdFON2wXRrkCAKYi6Sh+IWAGTKVqXQ42dR19Fg1gfr/zD8NHjFxIT7vS7HDDCDwkuprUa1P22tySiDtg1JExukS1F7/GZpFk9sqKoVM+9OuwoLYxAwAI1tegQumThKVon+cJxL4ir9rDWzjHx03Q8EqZUSfMLfmrenGkctgbpqrtV4t/eR7VWODNj/gDu7XpBu+p3TajR1e2L8pTEoyWeU6hcXqUCQCISO2D9dgvXe8xpj72KOFxoOV41nER96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MowLG4pc3Cv7Iu2+U9IBlBT6WV1b8EXd6OTID5R7VZo=;
 b=kgOwegKypxnJeYVcFPjVYfWHFBN3hyqZntNbHL8PvdLNvN+HPR6YwGHHLjgSN45lQ1Z2/toZi/EhkbN96ZbqY/MTm4wyR237c2V0qNHKeo38gS256lwZaHYx0hNfISmdvmz2iNjc9vZodDZPPkwkLtxQNf78hDyISSL1ttW/z9A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 19:02:20 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:20 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 25/25] x86/MCE/AMD: Add support for address translation on DF3 systems
Date:   Fri,  7 May 2021 15:01:40 -0400
Message-Id: <20210507190140.18854-26-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN6PR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:404:8e::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 164fe0a8-6178-4464-1ead-08d9118aa35a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB162091E5587C2F5C25591C5DF8579@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tAvyeFuWD6ixOE4vwK+JWM95QW1GHGZT0XKr9lK8mMtFbBMrZoCOXyCNsGWVxr/UPWkunme3R6mefrLMc1ZsGShvUhfewLQuT7vpoWMFUevT4fGCIqTcDNJymmdDO/bpmhoOqr2WRiYwRsg/8Az/L2mU4hkvhGiXADtHt0QH3pOdsaSp5YU/yLPi3m5Xyjv0sByLrjVunGol0z4EdN/BoS6DSxcMxu8c8hU1VW7pESGV0nA+SLNL/0AXTpXSf7ad0vSnemWSxKXnGpGe4UFphg0RitMlSIdXl0oechgx6/534W/33XKml9pqOdS5OTSiW0EL2sS6LXmS1o5O1tdInOxsYQ7hphtQsW2w/2grfUzsWxbm2pXAE7rutLP3ocQovyCJM7zieps0RhbVoOZ4PNrkPgMMgR8XWSBwAJTRpJNPJhM554W97+5pNr1/PxC601IjH6jjeAVAmbSu+WY2uiShW8e9TvnJuHGFzEc4cqI5ILUYJky6b8APR+1CAO8LSot4lFSgFtz/tI8LIoDMhkzmMN1aMngVgg2xsdmI9atO239OL7R+i4ZyPbqHqtBrv5w1fMI6fE98F9yUR58oVmxs3KXTfG5wPPR96WutaOcrEw0vDHlFE+1AO+owNQnClUB3tzKnjg292bgS76ds5ltriTzx37/KPnefyw/GukA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(4326008)(6666004)(38350700002)(38100700002)(66556008)(2906002)(26005)(6486002)(66476007)(1076003)(16526019)(86362001)(6916009)(66946007)(2616005)(956004)(186003)(5660300002)(36756003)(478600001)(316002)(52116002)(7696005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IxxqRRu3ugvPizndNNZLIhlZ6xa3WliulFMq25dKOqD151UUEpm1LXK/nZWH?=
 =?us-ascii?Q?8fTmW5ze8Gahrad1A4XQYiZB/Fhea6R/63cXQnUkzSM0OaKA4z5iTV58wZpu?=
 =?us-ascii?Q?+ADEqfzfdUAiliRNv7URkD/DKAAwzNbas7KmPN2p5K4PoVHECGf+GYuS+1KE?=
 =?us-ascii?Q?fvQrdYTkeKM1ky7LZRHu/VoCH1WnpXLix12unwFRm0ipvpXjrhkxWhD0MdFN?=
 =?us-ascii?Q?4mJ5tvW/XJAPzc1QKLUZhCzg80HnLq0Ht/zF/kO677xSWVcex3k6GXc+7HNy?=
 =?us-ascii?Q?YTpWbuvxtoX5fijZ4aP39m+2GpMsB8wwEuj5ebZpaRl+fFwTSv1wS98k1iXH?=
 =?us-ascii?Q?zZcgSCBoRxZwOk3HdSd2SXNsbORPrjeOwbHR7MESJx9jLv6QzQaT0KS32Gje?=
 =?us-ascii?Q?3/cxFRVqyktAje28DAfQcvk6NFRHSYgj4HcKsDqEiIOuMtI7EqcaLvw72n32?=
 =?us-ascii?Q?Y0rAd40Z+K5kYzCDkL9f7+7M/s1ItIEXLMtwfOUunhUF9qa8EmqusvFQl4yh?=
 =?us-ascii?Q?8YM4Wq/nhsowDcetw/45UgXHgUMiKifswMPRA9bdd7vhI+mpILW875Lu9QKv?=
 =?us-ascii?Q?onS5G0+MycC+lKDfw60TwYzXKczvKtX6kRo8pzZQEavq5nJqrZaWwiT4SKIL?=
 =?us-ascii?Q?inQvhsV8aBbCjtzy/AIlKin8Xn/DlIsAReFFN9mA0unAaWZettsxeatqAQpv?=
 =?us-ascii?Q?Mxp71Rp8tlWOsPUXz8dvuMZ0nwwscs7Mi83Xg+OMtCXliQeGobTEVWT5uHv/?=
 =?us-ascii?Q?MJt2VcyppcRNGuGUpiSeCMIn+0HeJLuDn1Si8c1IAYFG10RSJFUY29S3ghYe?=
 =?us-ascii?Q?vkqlb8k/5mWS7L6KRRe9XOqhvo5s3Xl1teAyNS6LaPTXYws1IZy99vM7i+6A?=
 =?us-ascii?Q?LoWbYrIU7AVWAWz2ptWU6S8Ryj+GfnlvUVldEgL55dgtxIPHikXVHNtbJi8J?=
 =?us-ascii?Q?ZPYwvz+TDDm/SzcqlBPAWUEeD4TBTTxQFiUXtT21jipzfhcKbqFp5RF+eSXj?=
 =?us-ascii?Q?8TU6gmM0U/qhV4xcRNfwqjRdl0JEZoJURb7czsS/fC14djB/oBrO4k+9GkUb?=
 =?us-ascii?Q?9uxL0/LSKKZ/QnVfNx9KIW2Pum3vygGUN/xrOTGPVAN2fzeEc2LmRr/gbSW0?=
 =?us-ascii?Q?vtlxeLnQa48htnKhFHQ0BF7P3Cn7gbqz0/NjoXlyfELvuLg0Ms00Z+OorVbI?=
 =?us-ascii?Q?5VBTDqExZYRh507l5xwY2Mqntdzjng1TSfZXyFchyAPSILIN8GkN9UuZO3YF?=
 =?us-ascii?Q?m/WaSbTAV/+o9mgzCKAcc+HLpZRq798aMT0i9lpBwf0t/qNqQ0IwG3f7bzRr?=
 =?us-ascii?Q?nNId51VmI2+5OEW/pzP/m09v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164fe0a8-6178-4464-1ead-08d9118aa35a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:20.0363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JeD+w7dHzRayCi+wR5GGIP1QVBu2dygB3MVmPztPtiyhxOGYvsufxXVfz8p9q6ksr0X+lovRw3R0XNJaUofhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

DF3-based systems (Rome and later) support new interleaving modes and a
number of bit fields have changed or moved entirely. Add support for
these new modes and fields.

Refactoring should be minimal due to earlier changes, and most updates
will be additions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 183 +++++++++++++++++++++++++++++++---
 1 file changed, 171 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index b3bfdc42dcaa..a165706c04f1 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -684,9 +684,11 @@ enum df_reg_names {
 	DRAM_BASE_ADDR_1,
 	DRAM_LIMIT_ADDR_1,
 	DRAM_OFFSET,
+	DF_GLOBAL_CTL,
 
 	/* Function 1 */
 	SYS_FAB_ID_MASK,
+	SYS_FAB_ID_MASK_1,
 };
 
 static struct df_reg df_regs[] = {
@@ -702,18 +704,28 @@ static struct df_reg df_regs[] = {
 	[DRAM_LIMIT_ADDR_1]	=	{0, 0x11C},
 	/* D18F0x1B4 (DramOffset) */
 	[DRAM_OFFSET]		=	{0, 0x1B4},
+	/* D18F0x3F8 (DfGlobalCtrl) */
+	[DF_GLOBAL_CTL]		=	{0, 0x3F8},
 	/* D18F1x208 (SystemFabricIdMask) */
 	[SYS_FAB_ID_MASK]	=	{1, 0x208},
+	/* D18F1x20C (SystemFabricIdMask1) */
+	[SYS_FAB_ID_MASK_1]	=	{1, 0x20C},
 };
 
 enum df_types {
 	DF2,
+	DF3,
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
 
@@ -726,6 +738,7 @@ struct addr_ctx {
 	u32 reg_base_addr;
 	u32 reg_limit_addr;
 	u32 reg_fab_id_mask0;
+	u32 reg_fab_id_mask1;
 	u16 nid;
 	u8 umc;
 	u8 map_num;
@@ -737,11 +750,15 @@ struct addr_ctx {
 	u8 cs_fabric_id;
 	u8 die_id_mask;
 	u8 socket_id_mask;
+	u8 node_id_shift;
 	bool hash_enabled;
 };
 
 static enum df_types get_df_type(struct addr_ctx *ctx)
 {
+	if ((ctx->reg_fab_id_mask0 & 0xFF) != 0)
+		return DF3;
+
 	return DF2;
 }
 
@@ -762,8 +779,23 @@ static int get_intlv_mode_df2(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int get_intlv_mode_df3(struct addr_ctx *ctx)
+{
+	ctx->intlv_mode = (ctx->reg_base_addr >> 2) & 0xF;
+
+	if (ctx->intlv_mode == HASH_COD4_2CH ||
+	    ctx->intlv_mode == HASH_COD2_4CH ||
+	    ctx->intlv_mode == HASH_COD1_8CH)
+		ctx->hash_enabled = true;
+
+	return 0;
+}
+
 static int get_intlv_mode(struct addr_ctx *ctx)
 {
+	if (ctx->df_type == DF3)
+		return get_intlv_mode_df3(ctx);
+
 	return get_intlv_mode_df2(ctx);
 }
 
@@ -777,6 +809,9 @@ static int get_dram_offset_reg(struct addr_ctx *ctx)
 
 static u64 get_hi_addr_offset(struct addr_ctx *ctx)
 {
+	if (ctx->df_type == DF3)
+		return (ctx->reg_dram_offset & GENMASK_ULL(31, 12)) << 16;
+
 	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
 }
 
@@ -823,10 +858,15 @@ static int get_dram_addr_map(struct addr_ctx *ctx)
 
 static int get_intlv_addr_bit(struct addr_ctx *ctx)
 {
-	u8 intlv_addr_sel = (ctx->reg_base_addr >> 8) & 0x7;
+	u8 intlv_addr_sel;
+
+	if (ctx->df_type == DF3)
+		intlv_addr_sel = (ctx->reg_base_addr >> 9) & 0x7;
+	else
+		intlv_addr_sel = (ctx->reg_base_addr >> 8) & 0x7;
 
-	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
-	if (intlv_addr_sel > 3) {
+	/* {0, 1, 2, 3, 4} map to address bits {8, 9, 10, 11, 12} respectively */
+	if (intlv_addr_sel > 4) {
 		pr_err("%s: Invalid interleave address select %d.\n",
 			__func__, intlv_addr_sel);
 		return -EINVAL;
@@ -845,9 +885,18 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
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
@@ -856,12 +905,18 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 
 static void get_intlv_num_dies(struct addr_ctx *ctx)
 {
-	ctx->intlv_num_dies  = (ctx->reg_limit_addr >> 10) & 0x3;
+	if (ctx->df_type == DF3)
+		ctx->intlv_num_dies  = (ctx->reg_base_addr >> 6) & 0x3;
+	else
+		ctx->intlv_num_dies  = (ctx->reg_limit_addr >> 10) & 0x3;
 }
 
 static void get_intlv_num_sockets(struct addr_ctx *ctx)
 {
-	ctx->intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
+	if (ctx->df_type == DF3)
+		ctx->intlv_num_sockets = (ctx->reg_base_addr >> 8) & 0x1;
+	else
+		ctx->intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
 }
 
 static void expand_bits(u8 start_bit, u8 num_bits, u64 *value)
@@ -884,12 +939,22 @@ static void make_space_for_cs_id(struct addr_ctx *ctx)
 
 	switch (ctx->intlv_mode) {
 	case NOHASH_2CH:
+	case NOHASH_4CH:
+	case NOHASH_8CH:
 	case DF2_HASH_2CH:
 		num_intlv_bits = ctx->intlv_num_chan;
 		num_intlv_bits += ctx->intlv_num_dies;
 		num_intlv_bits += ctx->intlv_num_sockets;
 		expand_bits(ctx->intlv_addr_bit, num_intlv_bits, &ctx->ret_addr);
 		break;
+	case HASH_COD4_2CH:
+	case HASH_COD2_4CH:
+	case HASH_COD1_8CH:
+		num_intlv_bits = ctx->intlv_num_chan;
+		num_intlv_bits += ctx->intlv_num_sockets;
+		expand_bits(ctx->intlv_addr_bit, 1, &ctx->ret_addr);
+		if (num_intlv_bits > 1)
+			expand_bits(12, num_intlv_bits - 1, &ctx->ret_addr);
 	default:
 		/* Valid interleaving modes where checked earlier. */
 		break;
@@ -908,29 +973,56 @@ static int get_cs_fabric_id(struct addr_ctx *ctx)
 	return 0;
 }
 
-static void get_masks(struct addr_ctx *ctx)
-{
-	ctx->die_id_mask    = (ctx->reg_fab_id_mask0 >> 8) & 0xFF;
-	ctx->socket_id_mask = (ctx->reg_fab_id_mask0 >> 16) & 0xFF;
-}
-
 static u8 get_die_id_shift(struct addr_ctx *ctx)
 {
+	if (ctx->df_type == DF3)
+		return ctx->node_id_shift;
+
 	return (ctx->reg_fab_id_mask0 >> 24) & 0xF;
 }
 
 static u8 get_socket_id_shift(struct addr_ctx *ctx)
 {
+	if (ctx->df_type == DF3)
+		return ((ctx->reg_fab_id_mask1 >> 8) & 0x3) + ctx->node_id_shift;
+
 	return (ctx->reg_fab_id_mask0 >> 28) & 0xF;
 }
 
+static void get_node_id_shift(struct addr_ctx *ctx)
+{
+	ctx->node_id_shift = ctx->reg_fab_id_mask1 & 0xF;
+}
+
+static void get_masks(struct addr_ctx *ctx)
+{
+	if (ctx->df_type == DF3) {
+		get_node_id_shift(ctx);
+
+		ctx->die_id_mask = (ctx->reg_fab_id_mask1 >> 16) & 0x7;
+		ctx->die_id_mask <<= ctx->node_id_shift;
+
+		ctx->socket_id_mask = (ctx->reg_fab_id_mask1 >> 24) & 0x7;
+		ctx->socket_id_mask <<= ctx->node_id_shift;
+	} else {
+		ctx->die_id_mask    = (ctx->reg_fab_id_mask0 >> 8) & 0xFF;
+		ctx->socket_id_mask = (ctx->reg_fab_id_mask0 >> 16) & 0xFF;
+	}
+}
+
 static u8 get_dst_fabric_id(struct addr_ctx *ctx)
 {
+	if (ctx->df_type == DF3)
+		return ctx->reg_limit_addr & 0x1FF;
+
 	return ctx->reg_limit_addr & 0xFF;
 }
 
 static u8 get_component_id_mask(struct addr_ctx *ctx)
 {
+	if (ctx->df_type == DF3)
+		return ctx->reg_fab_id_mask0 & 0x1FF;
+
 	return (~(ctx->socket_id_mask | ctx->die_id_mask)) & 0xFF;
 }
 
@@ -982,7 +1074,14 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 
 static void insert_cs_id(struct addr_ctx *ctx)
 {
-	ctx->ret_addr |= (ctx->cs_id << ctx->intlv_addr_bit);
+	if (ctx->intlv_mode == HASH_COD4_2CH ||
+	    ctx->intlv_mode == HASH_COD2_4CH ||
+	    ctx->intlv_mode == HASH_COD1_8CH) {
+		ctx->ret_addr |= ((ctx->cs_id & 0x1) << ctx->intlv_addr_bit);
+		ctx->ret_addr |= ((ctx->cs_id & 0xE) << 11);
+	} else {
+		ctx->ret_addr |= (ctx->cs_id << ctx->intlv_addr_bit);
+	}
 }
 
 static int denormalize_addr(struct addr_ctx *ctx)
@@ -1047,11 +1146,67 @@ static int dehash_addr_df2(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int dehash_addr_df3(struct addr_ctx *ctx)
+{
+	u8 hashed_bit, intlv_ctl_64k, intlv_ctl_2M, intlv_ctl_1G;
+	u32 tmp;
+
+	if (amd_df_indirect_read(ctx->nid, df_regs[DF_GLOBAL_CTL], ctx->umc, &tmp))
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
 static int dehash_addr(struct addr_ctx *ctx)
 {
 	if (!ctx->hash_enabled)
 		return 0;
 
+	if (ctx->df_type == DF3)
+		return dehash_addr_df3(ctx);
+
 	return dehash_addr_df2(ctx);
 }
 
@@ -1073,6 +1228,10 @@ static int get_fabric_id_mask_reg(struct addr_ctx *ctx)
 				 ctx->umc, &ctx->reg_fab_id_mask0))
 		return -EINVAL;
 
+	if (amd_df_indirect_read(ctx->nid, df_regs[SYS_FAB_ID_MASK_1],
+				 ctx->umc, &ctx->reg_fab_id_mask1))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.25.1

