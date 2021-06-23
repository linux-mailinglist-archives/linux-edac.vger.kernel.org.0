Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E713B20F6
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhFWTXI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:08 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:25341
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230121AbhFWTXG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQIlmQzfd3G2sl6XCuO9665zYwMNpHWdrlgya3W0F/CmkQme8J93pfy9OK3jBMCPXCOtm/YTue5yyy+2GByOQ4aI0cnLR6P5yVsshGMtZ5jeKOVF3/1BICDEx3Dt4T1BWc2TOVhW+CGG/1s7PAdMFhMrA1ouNiPIUAhGmMwK0k2dfs5Oad6PHSdiHSGAICveGBFm332xMCBWRxxSf7LPsh5BtMtuI1WatKO30H9rEiJE84DjTmP9todLWQlzee/xaql0exo2W6ZhXomIfirRWC8OFH5pyda0aKbBGYfK3aZQe6HhU6pzrLBWgJ/atd5+YoIFNJxPZCu5o5MfiI6bbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyAe7Wdg51pdDCo4Qmslwb22oJN7e+CgjyR382G1zx8=;
 b=Hxv8QUoJJxE+iJxT8gDg3S88YELkPVpM2uu6+uw5fr895XMiLpTTR5MD0l6LiOXirYiFTG7+JrFdIfL/lwrcbVIV+AGwhN6upK4KahWKNwQvXytNg5UmAigvVopPtwsTTe8rez2S0P2WpnJnmJS1/65Y2/gKu0MOo9uWpj3XOt1T0i8biBpX7ut8mZx5sJY9UV0SaXKCMoE2Dg0PfPfjFXJUOntjzmi9ZFZq/clVUM3G6eE5Zi3mrioQwLtYSvzqLTtKZIIaSm08//qRqZvmepSFtHzBNmrRj6jgvkIAB/VJpaSzRqxPhXHTEzdgfjbwMfOvrcFy47/ynRhBTobrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyAe7Wdg51pdDCo4Qmslwb22oJN7e+CgjyR382G1zx8=;
 b=HtTGnptTvvSVEOhZf7koTQWheFNmsQnrZXYFqdjPjfAAFFyyPouwMkzBNAKscGTZ0kHc/kRiX+XhtV4TEzJdjgPUQUi9wJrIMWnlNccuW4YcFFwefTlawcxc4vweaMBJo4oV3vuSgeSVksY/AGmt2Y4u6HyvgcHfn8cPfivWDdY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:46 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:46 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 09/31] EDAC/amd64: Define function to find interleaving mode
Date:   Wed, 23 Jun 2021 19:19:40 +0000
Message-Id: <20210623192002.3671647-10-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98d3f658-2783-4151-6d57-08d9367c0088
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1187DC1237BADE60B1A26848F8089@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVIrasbtS43dmBPxS8ick7fPq9TZHrLrSs9HPNpECBGXVYdlTdPtqex172I5ekKj/ihFWN6NkOfFw2xW4j574YNm5pz6mjmxZosGjAzS7VyAhcPN6Szl8ZJ6eaYqVcMBD4b6RhLQ1MYBBLqp/S3agezO0Ps9yncK3/F4cGkWUscJ+U88e5T+5zXdoxWTtGW6GqDwpbh2i8WlZPF4+2inWK3J5bdrCpsA9vz8GgBF678wFKypTHR8RGdsS9D6EAm4RPljKzTBNZQCIND3OJrcxM/e7Nabus3c4BZq8mUoRkRMEPEvCg15XfXEomR2oQW06TWBDaWS6vuj9TSKguLdvXg5whzR+AwB/BlSeSJh3q6cK6v43FjCnjEVunk89+KSCoTi5OLgxnCHnFfQmcu7TiclOup5jwYDrrydtO+k5/loVrhRka/TzfrLx7qb0V5PVcvDn61aHcZ0D0YL/eQtK5U62ENbcaGDCAnwWWiWOJgdsJSsLX7XMKdRoBvwVPy4QTEEcm4ax0WhoqxlsKO/3t2jbt2qQeqWjjFS+TzmWpB4/RKNG0/OjDwWAf6kcmKrj2PA6yCTo7pjfEIhbatVcnfok3QS/o0YM56Az8gXkUIEC0NDJ7ytyaucdT6tV1oO4rjWvSS9oNSYHgEdUXEzpvXBHcWJDN73ag4SxzSEQ95HbCRDLDpq+H6XEBEjxPjPErJKDs1Rb7u2vyVMHV/SYMkA+4XiJxFFFNl1ol6F/mAvjgmEVDXtCl+SNA19N2hwdw2w0doxSqF8plofB2MXYcGacvld3r/ty1aiaYAHn67n5AcNyHonkYMFSQaEWKKVKxmwldKD/SuYqJsXg8w7XMlf887/Gr5M4yTgW4sG92A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(36756003)(38350700002)(38100700002)(44832011)(83380400001)(6916009)(26005)(7696005)(5660300002)(186003)(16526019)(66946007)(6486002)(4326008)(52116002)(8676002)(478600001)(6666004)(1076003)(2906002)(86362001)(66476007)(2616005)(66556008)(8936002)(316002)(956004)(37363001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lr2Uc98ZhxLqPKz2HEfQ895j5jM10ais5w6D7sESFwwADlgwRojUo7S8yh03?=
 =?us-ascii?Q?3enXITF8776uPivVHZOhd/l07L+CyqFSxplYWYc+Wt3pj/GAwWvpXo8WoV9K?=
 =?us-ascii?Q?A9530TDOjCGamZhfYvxxVLCq6zxaBvWFTq4WiqJOedGSv3pwEWktYmatG3nf?=
 =?us-ascii?Q?zN6GyXke2602BXvngFMCwa9glgujJ4nnheXNzFNGCbhStL/I3pR6R8ZgPkcH?=
 =?us-ascii?Q?s/LyO8uKG3mLtCzv4O0tnaSqkW/JzpMn6UQTnJKsYZvxg897X7190dhZB1Aj?=
 =?us-ascii?Q?NaVjBTmj+fFL/SAULwqIXPYVeRsIh9PqJjfhIlDJDsiQTwDSpRw1AA4+KfxH?=
 =?us-ascii?Q?TriJA0f2QArWmsAuyDFIwWibsQJqbUA/o7mBEicomv1xE9MzM3G8hUblr/ih?=
 =?us-ascii?Q?oZacCtTGRZ/jwCVbX6apbFkIFpyLTRhUK87k+GG2AYgjJxrN8ePkJQuV5hwF?=
 =?us-ascii?Q?lOGvn8K7iBCN3jex/n4ahmLFXzicZAQXxD4M/Qdl25hELndg9fToMkNGokpU?=
 =?us-ascii?Q?IfYZl2lsm5B3xFV3k6BOBctt92PDmSJc/KVf2Kj9sGzQGmUyyXSh2VJ9zptx?=
 =?us-ascii?Q?aNowvXVHhEz4hUG3n+HWkqMOkZY4V72fFM8PKXrY4JJkVi2+SHNppxXv0fcY?=
 =?us-ascii?Q?5HwC1kmtK3YAWMRdKfk+lVMgYhMYiY8/Fet7TmMY5Gd38f3MAmO0Jtv3A+3E?=
 =?us-ascii?Q?IugQazibtzCmZJPzcm8HyOO+5CaCmg4nfC4LahKA5mkUcyVSEr0B8iefkKtv?=
 =?us-ascii?Q?jxGazKvhlP+T2VzhwxaAAUCweJK1vHc/atEE2PPA3NCLAm4AzFsC4bU8SGMi?=
 =?us-ascii?Q?xZsM9C5LOaD094LYcEn4iOk91jZ9IHkEYuiiQeCAn/4YIbYm+ioMB2HYfc4s?=
 =?us-ascii?Q?SHn/cpckBAjGskOcayn3FxHdi98ck9vF815U44bl5ScTKlIEJ+yzoB49N5JH?=
 =?us-ascii?Q?TP0BJ+IPsyZYkQadfFrcJPzK5V+zFsgvyUKfryNViZTqVASgyC2GAF8ZoYSR?=
 =?us-ascii?Q?GOU51+AHplvaZlFxpjXtTwd98mSLvefGmU5x76SV5sH4JeyJhjupgVpL6lyB?=
 =?us-ascii?Q?68fujcrTOlO3Fjnc4VeUA+xnVWEBgXItfW8qaq6bo2ECgfT0eDxZg4kBZFTX?=
 =?us-ascii?Q?iwEPkLNXMljWvzx5CiWJdSbGv4w2bzx0aFL6IKOu5Vwt9jvTJRbZQ5eVj+1N?=
 =?us-ascii?Q?HZpzrwNJU/pNSiAp0CxLwrvWQaIsBnRwSEWHKSB/qdSiwTm4+48z+GugjHX8?=
 =?us-ascii?Q?tg1i0u05skmDdef/QDcb1/JtX5hNQYWdCYQsVd736aVL/j2qYKf9u0Payqg9?=
 =?us-ascii?Q?fbGg3C1lsXeaHJ3/j7O5zJnn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d3f658-2783-4151-6d57-08d9367c0088
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:46.3930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+SCa/yRfZtSIaUpyubsWED3U9rXOy6/f0aya0d1gBctxos9XaovKtFi4dHuy4EKs0RTHJpFo+AqGMU7wgwOZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Define a helper function to find the interleaving mode. Define a
DF2-specific function now. Future DF versions will have their own
functions.

Use an enumeration for the interleaving modes to give a human-readable
value. Save the interleaving mode in the context struct, since this will
be used in multiple functions.

Multiple interleaving modes support hashing, so save a boolean in the
context struct to check if hashing is enabled.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-6-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.
* Add new function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 867ab32caab2..93a4ce9eb735 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1079,8 +1079,16 @@ static struct df_reg df_regs[] = {
 	[SYS_FAB_ID_MASK]	=	{1, 0x208},
 };
 
+/* These are mapped 1:1 to the hardware values. Special cases are set at > 0x20. */
+enum intlv_modes {
+	NONE		= 0x00,
+	NOHASH_2CH	= 0x01,
+	DF2_HASH_2CH	= 0x21,
+};
+
 /* Use "reg_" prefix for raw register values. */
 struct addr_ctx {
+	enum intlv_modes intlv_mode;
 	u64 ret_addr;
 	u32 reg_dram_offset;
 	u32 reg_base_addr;
@@ -1088,10 +1096,12 @@ struct addr_ctx {
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
+	bool hash_enabled;
 };
 
 struct data_fabric_ops {
 	u64 (*get_hi_addr_offset)(struct addr_ctx *ctx);
+	int (*get_intlv_mode)(struct addr_ctx *ctx);
 };
 
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
@@ -1099,8 +1109,26 @@ static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
 	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
 }
 
+static int get_intlv_mode_df2(struct addr_ctx *ctx)
+{
+	ctx->intlv_mode = (ctx->reg_base_addr >> 4) & 0xF;
+
+	if (ctx->intlv_mode == 8) {
+		ctx->intlv_mode = DF2_HASH_2CH;
+		ctx->hash_enabled = true;
+	}
+
+	if (ctx->intlv_mode != NONE &&
+	    ctx->intlv_mode != NOHASH_2CH &&
+	    ctx->intlv_mode != DF2_HASH_2CH)
+		return -EINVAL;
+
+	return 0;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	&get_hi_addr_offset_df2,
+	.get_intlv_mode			=	&get_intlv_mode_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1176,7 +1204,6 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	u8 num_intlv_bits, hashed_bit;
 	u8 lgcy_mmio_hole_en;
 	u8 cs_mask, cs_id = 0;
-	bool hash_enabled = false;
 
 	struct addr_ctx ctx;
 
@@ -1197,6 +1224,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (get_dram_addr_map(&ctx))
 		goto out_err;
 
+	if (df_ops->get_intlv_mode(&ctx))
+		goto out_err;
+
 	lgcy_mmio_hole_en = ctx.reg_base_addr & BIT(1);
 	intlv_num_chan	  = (ctx.reg_base_addr >> 4) & 0xF;
 	intlv_addr_sel	  = (ctx.reg_base_addr >> 8) & 0x7;
@@ -1224,7 +1254,6 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	case 7:	intlv_num_chan = 4; break;
 
 	case 8: intlv_num_chan = 1;
-		hash_enabled = true;
 		break;
 	default:
 		pr_err("%s: Invalid number of interleaved channels %d.\n",
@@ -1325,7 +1354,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
 	}
 
-	if (hash_enabled) {
+	if (ctx.hash_enabled) {
 		/* Save some parentheses and grab ls-bit at the end. */
 		hashed_bit =	(ctx.ret_addr >> 12) ^
 				(ctx.ret_addr >> 18) ^
-- 
2.25.1

