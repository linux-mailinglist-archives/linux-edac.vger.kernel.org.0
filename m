Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F793B20F3
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhFWTXF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:05 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:25341
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230082AbhFWTXE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVdGeR5GVFKO/O0R2D9K5q5PZYmbYjw7hy8rEohzyC63BgkwOt3MEJWV1KJ9jZgS1AHB8dCsetblObc9PnYKjtRIc8/nNqczwlNQJ5YoqA3WFgjXx55mzHULJ8dUadXafKtSHszRWA7D7Isr6LcZIXzxTkdfW1Wwhvmr6rPiOfk+k0AE5lCkUi8sguxY1RBFfDEjxZz6LHwd1M5HPBDmwaeYdCj5TXq6AS43J1imTtircReuQcmQg9GsA/qoa7316W41hM8Jde4Pg9LW2ObxbTckw3b6S45wY2s+lvfOP28OZv9PNCj+GFsm5MiYN8RP4NDLpdfvqYUbw4wPddoOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Bd1eO8CQRbB5Vx69SoTmzAQUbszYFB5td1TIOu4JvE=;
 b=H/722UES/L5801ddlzQT4QxQ2f0qWeZtHRmBLECrMyuGUQB2kHi4WIwYfHYM3kis1WkDyMsdFoS6/WYCvApU3Gc2TGZZR7+7p3+UjQWRU69Zbuxico4bPPn88Zj/0V5kow4CI7BjTMX48lB3SAf2fm8HFKnd125G6c3IyoAbpuXkJA4dlpiWLLu2urd4URdzhySak434igo0+5Mek8MZKoBeBJzF/yZvgecV/CiVyJmK4niIYFp6y/k2v5oUFYwiLAum7pUU6DMWE/FHbPBwzJrxtkBVwZcc42t3aOr75JYLfrYdnX5/j1cIE7YexmDbPU4G9g9YwBGBxJNbT6iXlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Bd1eO8CQRbB5Vx69SoTmzAQUbszYFB5td1TIOu4JvE=;
 b=ex85ZfSiX43NZnbWh8JYs277Tf0AkWeXDQ/TvP8ViJoBPJYx3bfPh3e1oWxAk06dhJwK79q3CrvHWrjs/lyTau+ktAxPkU/sKmZ/TZ+RUKD3y2oAX2q3gsGsH1prZAvDeqn1NuapsMrvDYFQftbSw5jBsw5F5RukNSEiTsdllBM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:44 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:44 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 07/31] EDAC/amd64: Define functions for DramOffset
Date:   Wed, 23 Jun 2021 19:19:38 +0000
Message-Id: <20210623192002.3671647-8-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b4b0f75-ec82-4a95-d008-08d9367bff68
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB11872BD6DF3C119EBFF65B96F8089@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjOxRnwf6wjwSU9fS5cXAOLdXPdT2KHSb/sWcaMfcJ9sTUgcZgPWq/Mtp0nUZxigz8fMlx8lCdgi22Az6MjJbEDGhTeH86P+xgSYVfbMKSC0QqONFg/HTFei8nyxzQQyPLEPnKWnKOM9kF/kh0Uh+mrQzQK75PnekptQfsDz1xik0zIh3tJQAAMLR6JVj+2CjOJP56YaVvUZHRHB6tL7YWw/nYSp9wgewTEJVsWUMayIe4E7mxNrovynIjau2WN3gDixfgPOHSl7pyq6uDuNRpvZbJtE4SS7Un+AdNzFd8qMljIfwax+OWMH7es8bxcEhz4Y8GB4dRWWk07fwUrBBgNooBd6OjVgA2Rk8A4Oer5M/NUm0rh56rwsUtEUx4Ktcv0RXZiS+4pZ19ofeNEbnFiwTUPALo18Zigokbcv3fT3sOmre41H5EG3PSNznTGcR7WxFbzkejSRffyifBkovN+US9WR42Tr+gfcpyQH4TTcW91ftKT8F1YpWOu9XDa8G0vSBUr+hWb3+iAexQwya/bDltotBsyJ0pMRyTwpi4gaDCHEP2wpkVWGDRsR7dWjRntJBSTLiYnTuzcWbmwtWvuvtbt9X+fKNw6OqBD1EbQ6i0nDMdbq3ziNKt6VjcQ5bJaxfT79UkliOmxycukFtZVjp2+6LNADASag6McGfZEYqZGcdiKAENcq3c8+jb4zREYY72jZNa8o/xPvwIV1Y0vHbagtJNyyiW1fgMBaDtXkh5j3+zkXuDLIHxIwvaz37qq5oBvRGqSMhvbTGjPq9ecRwyO7TiCTQomckAJlYOROAx9Ze+7KKpLE1/OSJXfItWNNXbuJo8Cf5VQb3Fu2sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(36756003)(38350700002)(38100700002)(44832011)(83380400001)(6916009)(26005)(7696005)(5660300002)(186003)(16526019)(66946007)(6486002)(4326008)(52116002)(8676002)(478600001)(6666004)(1076003)(2906002)(86362001)(66476007)(2616005)(66556008)(8936002)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jOJ9dJqbHEF7HuQF4iMdt/a3vu0D7GlE1PdMiqbBZ+mGl80TdBi5uvw4yesq?=
 =?us-ascii?Q?n+61oFprFExmtYzpRQnlHn1eCwqQhyBlFTRAH9AMZ0ZHF9oUteKRMUlHvcBW?=
 =?us-ascii?Q?5NrRn2O8+/nsc1P29RjSC04MCsiamxhNihmCtiLrcsdO6Crz/b0OaglBEi/c?=
 =?us-ascii?Q?/I4u34PkcidxKQ+ZudgB2K3G3AUVo3201ThQLUr9NkJ15znQHq/Q2V3jXEcD?=
 =?us-ascii?Q?M7fiBhN4fxbruaytS6c3A041H1O9bP8ljg+qOAiMuLLl7Cb2YYJ9QuEbxfSK?=
 =?us-ascii?Q?/SBatAK+jUyCdiWqx7sR7l1SNnWqfaeePWXmu5r4bZYMDoQfDK3aElZWeiek?=
 =?us-ascii?Q?C5Py5auLnqo10bsY5RaamQsCbXn9RkQ7/gT8Id31fFYklKwLTvaZFxT1uuyK?=
 =?us-ascii?Q?dzWz34jX0i4gq1O3GsZwM2eBtg6XuzG8i5Z0VrcxO6hIzk+KhX8Nt4+QaZ9C?=
 =?us-ascii?Q?lKHq1sW24Klku1HhKbna0sDVcmLmDB0y5jtuRqMMW92VNGUvpgu3JdvxodVw?=
 =?us-ascii?Q?RZphu/uGjphEESR9qBuEbTy1wK95C0BR+tZPzWDQ0QaNCsYT2gW+SEEBjONv?=
 =?us-ascii?Q?Q1lnjWwchQ9g0gf13sue6+0sMkBpJW/lXoiC9S+KJMbyZ7onC1Ch1PFRRUUX?=
 =?us-ascii?Q?xRXDykB3WgmNbTu5SMVYa+FsXpFEiUj98E5k0H167Qs8W7ivK0F7HOQgj9OO?=
 =?us-ascii?Q?rs3e+7gbvMsRBctcbOpWKOONy8ra+5OP51b1vg5LDU2Rn+QHVRn85vmDQvvA?=
 =?us-ascii?Q?gwoROMvIzR8gWKaWN4Xkrk7yxGivr5rKP9o1bUmsImKMfaYTGGJFC6RuHAYC?=
 =?us-ascii?Q?KOPCwiC+W9e9Pzh1V0Z/zeNIZOBpqOJniJXSKNvXgH6B90P6I0TF3qWBl+EJ?=
 =?us-ascii?Q?cdjUYovmwanvEoaJR4Qq9fyPel0HtZUZbMJna723owhRsg8WSiaDLdS1doHJ?=
 =?us-ascii?Q?dDpMCJyjrhwTwzFhlFJhvNeeuCiDGsxu6GQkUi8MVDJ6F1dm/2sEOLlUmfpF?=
 =?us-ascii?Q?4Q0DZy+jxABAB4ErF7fmrGlENhnupY4ByxHVUBdu6QBnUMtlCSnuMiQiiqs4?=
 =?us-ascii?Q?zcXU9BoRECXAz/PQjaZk6kT0mXZImDQWkVQQduymWhb31DLYgYEIGWKaE4B2?=
 =?us-ascii?Q?MzMsODzwSxCZo5qBf64aZyJ4Rojgu6E40IMBOa3lpIGgAZKafzngNNQZ2Q6I?=
 =?us-ascii?Q?Q8p/y78vGujmxYFMOMiLxG6s4Mza3dgjIqr508IxdaUaAi0xLfOq2K94FogC?=
 =?us-ascii?Q?FP1p0TnkyDMGTrEpSorZgwERU6qmlmrFIIRaCkGWqapEc2A+uB+iCOwjB4jg?=
 =?us-ascii?Q?8HQKaac5cS64F0nB4k99fzwi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4b0f75-ec82-4a95-d008-08d9367bff68
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:44.5551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YoM36TgHgsxjjR8N6quUo8JvbjppoPwk70hfvDiMzbFYO2UiOD7TtoZKseIIeiY9OkqbAmF06vDv+Wr+yVVppg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
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
https://lkml.kernel.org/r/20210507190140.18854-4-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.
* Add function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 57 +++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f769353ef7e4..389f0621e885 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1079,16 +1079,26 @@ static struct df_reg df_regs[] = {
 	[SYS_FAB_ID_MASK]	=	{1, 0x208},
 };
 
+/* Use "reg_" prefix for raw register values. */
 struct addr_ctx {
 	u64 ret_addr;
+	u32 reg_dram_offset;
 	u16 nid;
 	u8 inst_id;
+	u8 map_num;
 };
 
 struct data_fabric_ops {
+	u64 (*get_hi_addr_offset)(struct addr_ctx *ctx);
 };
 
+static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
+{
+	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
+}
+
 struct data_fabric_ops df2_ops = {
+	.get_hi_addr_offset		=	&get_hi_addr_offset_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1100,6 +1110,35 @@ static int set_df_ops(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int get_dram_offset_reg(struct addr_ctx *ctx)
+{
+	if (amd_df_indirect_read(ctx->nid, df_regs[DRAM_OFFSET],
+				 ctx->inst_id, &ctx->reg_dram_offset))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int remove_dram_offset(struct addr_ctx *ctx)
+{
+	if (get_dram_offset_reg(ctx))
+		return -EINVAL;
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
@@ -1109,7 +1148,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
 	u8 intlv_addr_sel, intlv_addr_bit;
 	u8 num_intlv_bits, hashed_bit;
-	u8 lgcy_mmio_hole_en, base = 0;
+	u8 lgcy_mmio_hole_en;
 	u8 cs_mask, cs_id = 0;
 	bool hash_enabled = false;
 
@@ -1128,21 +1167,11 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (set_df_ops(&ctx))
 		return -EINVAL;
 
-	if (amd_df_indirect_read(nid, df_regs[DRAM_OFFSET], umc, &tmp))
+	if (remove_dram_offset(&ctx))
 		goto out_err;
 
-	/* Remove HiAddrOffset from normalized address, if enabled: */
-	if (tmp & BIT(0)) {
-		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
-
-		if (norm_addr >= hi_addr_offset) {
-			ctx.ret_addr -= hi_addr_offset;
-			base = 1;
-		}
-	}
-
 	reg = df_regs[DRAM_BASE_ADDR];
-	reg.offset += base * 8;
+	reg.offset += ctx.map_num * 8;
 	if (amd_df_indirect_read(nid, reg, umc, &tmp))
 		goto out_err;
 
@@ -1166,7 +1195,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	}
 
 	reg = df_regs[DRAM_LIMIT_ADDR];
-	reg.offset += base * 8;
+	reg.offset += ctx.map_num * 8;
 	if (amd_df_indirect_read(nid, reg, umc, &tmp))
 		goto out_err;
 
-- 
2.25.1

