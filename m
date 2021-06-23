Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A1F3B210E
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhFWTXp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:45 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:24416
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230357AbhFWTXY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8BMx1RQaOUV2IZqcPZM164nowdECEjJ9kNKolkBgLOtvMnPOQir7z2lbPhPZ6hhVbHkOH0YgrtO+FyV812OkHozd+1qJswHBNoi+d92gRZcY579jLs/9avYHS8iTRqTwjAq1m6UJVJULhNo5HEoAMsHeP3A2mN+lG9/9+ht/LSUZgEWw3/tKXfOvYDm05W3RvoIMmQTKN/mZgElojfvAl+TBKZLiJfk2/XCBb+UlMr50darArT5gxlW4+k5B9iGrPy9JX3Z5ZMe757BlvBHrQvmllljG28UANQlJpwshmLONBJ4eZSlAizK3uAz0FKHByM7IPHHo7hVStfC+JP3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKpZ++iLGBTm/PfPe7a3yquXm/W6vyQt/gFHJGFuhL0=;
 b=JXQDY9llVWCyFnE6wFcbJtOF2NOqKcjtZEC0vo/cx56BRMD6YcTvQ17m0723as9V+AolfY8cQZjZiZ/CztP4HT2uQtqLDsiq6UteODSkAE0gff96qg1lENnTV7/pJYki6GWbhtCRDnTyxMX0JsucTA2G++bz+/2YXarzXi5nEMaNPpKs3/vQTxagBkQodinDPMfctRysfxEPy5blOTByfV4HNatgnS33LkFkCSKNQFCBoDfdGxIVcQdTkxjU3t1x3FNTi2n3vM82+OrM+PkSMCYAVfPdL+BkHGevatA7gP8FgwalmyrpuzQNVYUOfMoUGtze5XNMKPauYY0NIueZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKpZ++iLGBTm/PfPe7a3yquXm/W6vyQt/gFHJGFuhL0=;
 b=OsckuvDYDaaNLezMEo4BoJWXga0HLIPTWC6gniBuVeUHj1nkYkFHyp8mItOkUqKGRakFmIjkCzLQIqcjO+DUXCo5k4Bsmx0f+/+hjm05D3YSgVe1seAxPWTn/tz+8C42JWyQDFTrtgLyogalCEOfnZvfnHpmwBPs1oD2vJ4U2zU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3218.namprd12.prod.outlook.com (2603:10b6:408:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 19:21:01 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:21:01 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 26/31] EDAC/amd64: Define function to find shift and mask values
Date:   Wed, 23 Jun 2021 19:19:57 +0000
Message-Id: <20210623192002.3671647-27-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:21:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3338df13-5549-4be1-113c-08d9367c0993
X-MS-TrafficTypeDiagnostic: BN8PR12MB3218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3218A8651785041805EC0A5BF8089@BN8PR12MB3218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOS8OF8kRgi0mtv/YF6FxhXjNZfkQIukdwTr/OIVCt8ShKhMBWtyyuUqN3oJar8PeBgPogiIaChKXcexO482u/O9pFPpwUGDO/XBQqnwGKllNMCEhnj+eJXGEfrMazOcb0ntthZN4LTmeaCub/EBy81bJcV9gVyL9591daJ8UD8CotLhTXWM6ArU6BV0tkA6bQ/sIHs+aocvsAoE5+fEqizq1slF6gSqTIqlIducJeYI3pp8im+snaMAkW2Me+W0eLHtW3/5LwcM3YYwGFpjDix/poNJ3vMstJsSx3DEEEAVy7uBLaH+oZQgj2r1o166lw19bD1oPa5vd6eXATNq8N2uG5UandtTHf0XqQGn/5odLbdYYKZhdK9XU9ZBVaBD0SKlYw56UXmznSxBRPWg7im+qf0/M91uOsgU7TSufl5m07+YHIg/c321q5Dd/EA2GnS0JJ3qyMgOY30nOZUbgTqRyfTlXTzXCvLn9XwVqoowVtxPZ6w5dUoyzC0Pi0KzIr9Liv2smXliWz+zb0CF1+wQMJRsgakSnGeSDkkOsWThgR3WJNqaVnHPFRCbQrMoinYrBnfSHqe+bGrl4mk5hF13pLVnJ3DsdP/bxBfzPcZwwdxV9gqDh1Svjiog1wS0npMOZUg2lZNRN51TRCYaTgW2Nou3mQz/xVcW9spoTGz3ks5PY459mFSkY/Y+9kTFF+OFg4fVV3WN5C1Hy6YgEaAKZfYSQ7YjHHLR15gHgN24zwnpZcSGBPvfY0PLpubFpwkUuV1Pnuoi/hd8cfFXP1WzRjtv0G+bMbgSk7G6GYjWxw1PHJG0WUJQ2UiBsgFT8g2c06PXvVgYaluvp/QGaRyHcvrHoQ27NdUTCznnWtA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(316002)(6486002)(6666004)(26005)(16526019)(38100700002)(38350700002)(956004)(44832011)(2616005)(86362001)(2906002)(186003)(1076003)(6916009)(966005)(83380400001)(478600001)(66946007)(5660300002)(7696005)(8676002)(8936002)(36756003)(52116002)(4326008)(66556008)(66476007)(37363001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/J/HDx5P+i+HrMOmzH4YhH+/RNVSJ2vmaezv9sFZD/Z8umA93GbjztINRkE2?=
 =?us-ascii?Q?i7NrmcaqAJ05XYlEWNsKkX4RSgyIjHazW1cZ2Fns4c2msaSpwmpQ6XcKcj+u?=
 =?us-ascii?Q?GX08Wcpe0n7dd666rgyOgoCpM/PZ+6+jlGcJQf3PZwnlnylxQKQmiPP6dz2w?=
 =?us-ascii?Q?LovrvJUXHzXB9MN8KB9WHTIri3OuW/8mKDqSxQEGUILFlgxdtmpC8CeYN2QK?=
 =?us-ascii?Q?Ccar3CT4tuuFqPhcLeJgwCPgfxAmn7uGAnPWCv6Ez8xN/dmwiemSIxOBH1Tl?=
 =?us-ascii?Q?L3/1hMzpjOWOVjE7n8SDntU++Yw1SLzsVgg5GvpBgb/ddY01pSt5FWUW81AP?=
 =?us-ascii?Q?YtWOZdidTv2zAsGgtG8mGZc3G1Y2D8cdMPxbGsS7snVQV2xj7B/KBjYgPwGs?=
 =?us-ascii?Q?fsjokeU4vnupy4SRVEwr2taONQ2ljAC4iflNfO7BLccfwCFy/rn3qaNuTLV5?=
 =?us-ascii?Q?1tJcSvTJjHWx6iVKWQGFbkWwvRmyv//zMJHa8HMgtn7MQqK6+C5WLcH60TRv?=
 =?us-ascii?Q?PhlfQLHStLhDf6vzFrGJvtrE5JcnRdmNkZ4hQT8UE9tvVTUXZCXRYZuryu+T?=
 =?us-ascii?Q?HG2mAjjDo+EUubHf67o0imwT6nhmIbQYUX6TXHIJvH/P0KN6bM7i1WOIKz1E?=
 =?us-ascii?Q?j+JYStJk/qGPVqGJG/xO4Us4faN7NDP9sfNrjsMogmbGMSGWEF0xE8e7wxex?=
 =?us-ascii?Q?2Szf2JaSZ1KTKbFVQDM/6q4TE0lhhyCt4Dpl49CW5RZHfhVl30rlQsrGRMP8?=
 =?us-ascii?Q?ZOHfiR/P2D9PSnanFeQYtOZRufXnQ3eOikUPJe2i6d/Y8CDnXvBd8ZLl8+Yk?=
 =?us-ascii?Q?rEr9m54PoOvtfNlcKy7pj/nqK5Cx9pgicGr4W7sJVmJX1rx+CzThj6HUbJxj?=
 =?us-ascii?Q?JZLLYfDi5UYnAV+UXiWa/+l8e9ie7urDWzxMu/g3BzG/ov5Lu7l9s0z/nyVc?=
 =?us-ascii?Q?CG0BO1nsKrpBmerl+OvmbjlqlrsMMOo7OAX/WAmvOhGQIHyaM6bbARiCGotK?=
 =?us-ascii?Q?+I2F+4LYyMkpYMFvFjpK2vSHLeBj2QSBV7zcEUiLFT1DlfmTRlu1BjKIxrxm?=
 =?us-ascii?Q?fGqyl7zr3DEAHDbpHGtmj4+n/dn+ZqvpjLFfGTcHk1J8AxiIXB8xhtnw3hh/?=
 =?us-ascii?Q?gOkeExPVrlKWQ3pBzWy/huGvbAGdKqY5+S1+0eooC4/3O9mbjKhRWQP746uB?=
 =?us-ascii?Q?qUQvIO8KiWwhIg9xPktlAoH65ftg3VXfC21frVqAeu91CCMhsVW/GJvQkRLZ?=
 =?us-ascii?Q?oI4lUB0qwAA03Ey84sf0xrxzt70tWs0AKxkVqNSmUXATDlZ9QPkpnPg95mam?=
 =?us-ascii?Q?XlgxgTIHGuV2zJcxribFuOTJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3338df13-5549-4be1-113c-08d9367c0993
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:21:01.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLaWjLiSqXbKZrMmZFdTS3Rr6EgwHBOmDs/LPz4ThlqAUGxzDja1qofCeddDqCEa/EYDw4DrXbSd1HIFWwDcGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3218
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move code to find the shift and mask values used in die and socket
interleaving into separate helper functions. These will be expanded for
future DF versions. Make the die_id_mask and socket_id_mask values u16
type to accommodate larger bitfields in future DF versions.

Also, move reading of the System Fabric ID Mask register into
set_df_ops(). This will be expanded for future DF versions and will be
used to determine DF version levels.

And call this function early since future DF versions may need these
values early.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-23-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.
* Added functions to data_fabric_ops.

 drivers/edac/amd64_edac.c | 61 +++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f5ac3b63376d..fa8046e2b055 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1093,7 +1093,10 @@ struct addr_ctx {
 	u32 reg_dram_offset;
 	u32 reg_base_addr;
 	u32 reg_limit_addr;
+	u32 reg_fab_id_mask0;
 	u16 cs_fabric_id;
+	u16 die_id_mask;
+	u16 socket_id_mask;
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
@@ -1109,8 +1112,11 @@ struct addr_ctx {
 
 struct data_fabric_ops {
 	u64 (*get_hi_addr_offset)(struct addr_ctx *ctx);
+	u8 (*get_die_id_shift)(struct addr_ctx *ctx);
+	u8 (*get_socket_id_shift)(struct addr_ctx *ctx);
 	int (*get_intlv_mode)(struct addr_ctx *ctx);
 	int (*get_cs_fabric_id)(struct addr_ctx *ctx);
+	int (*get_masks)(struct addr_ctx *ctx);
 	void (*get_intlv_num_dies)(struct addr_ctx *ctx);
 	void (*get_intlv_num_sockets)(struct addr_ctx *ctx);
 };
@@ -1206,18 +1212,43 @@ static int get_cs_fabric_id_df2(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int get_masks_df2(struct addr_ctx *ctx)
+{
+	ctx->die_id_mask    = (ctx->reg_fab_id_mask0 >> 8) & 0xFF;
+	ctx->socket_id_mask = (ctx->reg_fab_id_mask0 >> 16) & 0xFF;
+
+	return 0;
+}
+
+static u8 get_die_id_shift_df2(struct addr_ctx *ctx)
+{
+	return (ctx->reg_fab_id_mask0 >> 24) & 0xF;
+}
+
+static u8 get_socket_id_shift_df2(struct addr_ctx *ctx)
+{
+	return (ctx->reg_fab_id_mask0 >> 28) & 0xF;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	&get_hi_addr_offset_df2,
 	.get_intlv_mode			=	&get_intlv_mode_df2,
 	.get_intlv_num_dies		=	&get_intlv_num_dies_df2,
 	.get_intlv_num_sockets		=	&get_intlv_num_sockets_df2,
 	.get_cs_fabric_id		=	&get_cs_fabric_id_df2,
+	.get_masks			=	&get_masks_df2,
+	.get_die_id_shift		=	&get_die_id_shift_df2,
+	.get_socket_id_shift		=	&get_socket_id_shift_df2,
 };
 
 struct data_fabric_ops *df_ops;
 
 static int set_df_ops(struct addr_ctx *ctx)
 {
+	if (amd_df_indirect_read(0, df_regs[SYS_FAB_ID_MASK],
+				 DF_BROADCAST, &ctx->reg_fab_id_mask0))
+		return -EINVAL;
+
 	df_ops = &df2_ops;
 
 	return 0;
@@ -1310,11 +1341,7 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 
 static int calculate_cs_id(struct addr_ctx *ctx)
 {
-	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 die_id_bit, sock_id_bit, cs_mask = 0;
-	u32 tmp;
-
-	die_id_bit   = 0;
+	u8 die_id_bit = 0, sock_id_bit, cs_mask = 0;
 
 	/* If interleaved over more than 1 channel: */
 	if (ctx->intlv_num_chan) {
@@ -1323,27 +1350,26 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 		ctx->cs_id = ctx->cs_fabric_id & cs_mask;
 	}
 
-	sock_id_bit = die_id_bit;
+	/* Return early if no die interleaving and no socket interleaving. */
+	if (!(ctx->intlv_num_dies || ctx->intlv_num_sockets))
+		return 0;
 
-	if (ctx->intlv_num_dies || ctx->intlv_num_sockets)
-		if (amd_df_indirect_read(ctx->nid, df_regs[SYS_FAB_ID_MASK], ctx->inst_id, &tmp))
-			return -EINVAL;
+	sock_id_bit = die_id_bit;
 
 	/* If interleaved over more than 1 die: */
 	if (ctx->intlv_num_dies) {
-		sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
-		die_id_shift = (tmp >> 24) & 0xF;
-		die_id_mask  = (tmp >> 8) & 0xFF;
+		u8 die_id_shift = df_ops->get_die_id_shift(ctx);
 
-		ctx->cs_id |= ((ctx->cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+		sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
+		ctx->cs_id |= ((ctx->cs_fabric_id & ctx->die_id_mask)
+				>> die_id_shift) << die_id_bit;
 	}
 
 	/* If interleaved over more than 1 socket: */
 	if (ctx->intlv_num_sockets) {
-		socket_id_shift	= (tmp >> 28) & 0xF;
-		socket_id_mask	= (tmp >> 16) & 0xFF;
+		u8 socket_id_shift = df_ops->get_socket_id_shift(ctx);
 
-		ctx->cs_id |= ((ctx->cs_fabric_id & socket_id_mask)
+		ctx->cs_id |= ((ctx->cs_fabric_id & ctx->socket_id_mask)
 				>> socket_id_shift) << sock_id_bit;
 	}
 
@@ -1423,6 +1449,9 @@ static int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 umc)
 	if (set_df_ops(&ctx))
 		return -EINVAL;
 
+	if (df_ops->get_masks(&ctx))
+		return -EINVAL;
+
 	if (df_ops->get_cs_fabric_id(&ctx))
 		return -EINVAL;
 
-- 
2.25.1

