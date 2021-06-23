Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B924E3B2100
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFWTXY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:24 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:25341
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230235AbhFWTXQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sjd+h24chr0wxRavw8mGWH5G2CKkrw0wf/G3n2KCRxTb82VfrtfPi34J3TO+7JNjD6OxU5EsRpyhahxohE9VZK6+OEws40R1n5awWhvfGJ8VUfnrkH08kH7p00Rb+1pKQY5+Y2SFjolemNShe4jiPMWe1deDFRdb+0APdWmi+2Qem/HJF0NeyM1NqybT7LBDHeCZNoDvVRTZrtyoQd8Osl57hSKA3L8Bj4askICK03trz7Ln6RLAPfVDZurN/33DMYx2TIV9lsCsv7++LncQRaVBavSTONeJEajz9F22Oe5FtaKCOVb+a4FgGavrkDiWt3J2+5OJ6A8EAkpcSWAVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5XYnTeYPU22+AA8MkCJ9DPq1b6bI3iXpoOQqC7SCNo=;
 b=W13FL4GtASq9n/chLkX5KuzeuPsvzGKJJR2xEamhOZIIlExDq2gsGlIFLXLvV8sVzXREnykS1vF2EUMzNepaP7HHHFqX/vF4tBISkqo0AX4TqVKU75PNr2kpI4r0ZQpdDNoi47VuUe4g56/1vr4a7GtETb8fSCmpYjIFMxAnmYdOIpdC6djODtwNTitxmnLSCjaoxGGD+29Z10HHMMsWymse75qiUyYC+mP8UlvxgoOwx47uwJfM8h7OZxhX1XQIe426jtxWeEn2EKN+NEIuOpcTzg6Qc3JOSLj/RfyPklOBbOzOIe7gegfqkkI0jQCTJE/1pmoSDK3EGxvJYkNgqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5XYnTeYPU22+AA8MkCJ9DPq1b6bI3iXpoOQqC7SCNo=;
 b=jmxGCaFyGOadbt4VJUUfktDAM3Pqqz3jobZjuSTfDPM06xWk5ev53X6/92+c/UtHsGdBBaDQeN2MhQYsEhv1Jk5nqMg4zTe9qKAcDwVxR27nz4ex/GFIoTJfWFR+JWH2Z5mSJXPORpTzGba2oMyjGF5goSQMgYUiAM3mDq14hmI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:49 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:48 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 12/31] EDAC/amd64: Define function to dehash address
Date:   Wed, 23 Jun 2021 19:19:43 +0000
Message-Id: <20210623192002.3671647-13-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6d73653-6272-4b35-cbdf-08d9367c0200
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB11874EFD71E70EC78B1237FFF8089@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vVjBPc/srNvk1m+XBeCutir71mwITSmMNEmQe9GkSgB5McYn2la3k5EB/wjGssOFdk82zH1N/VwtxzeaZNG0ooLJBj/NAL5U2ebQ8r2xYxidMp9D++Z6+/I3k87eyFVOLdQrVGb/pYB4/aB4gTvfskzjecxNxqePL3j9jOXp8dXzUxDEaJgHX10Ep3GhXjbIpg8rw686TB0l9bH1m792HquIQ/8RYKlIv8Vgeottp5xuLe2w4W0JhacxHEW8/XfI8rNRTjdpUu6xRvPW1ugkwpliwmL60j5au25f6mq50zjdGbZdl1IJvttfbX/rHco4W6t2W54ZIvLd2NLKnuLVEpAFkbQTKRic3K22JUKNIip8qbVeS61T3FEHGCbIk7ko1XSzmUV+JEBDTULccZ7a47JR6wf7yHb15E1/BOlgAd2wH/hPIUNKfUpN5P7iaBciuOET9xaXuXci8qp27QOEvpbqwzm5qfSJeoykmUfm8gruoq5g8Bl87nVqxqC/x0yOcZybup8XIIfNtYs43BGJVaIjyPFd4VY1HLicap4ynayoF2PDECHwkSfKjqmGxbTWoybXCSc4Sv6X8C8OI8zqy93GQI4bgJFeiA3vGwQlfz3qNFTTOACkmsTP2QlfYtBLcntzWYv7EvGHPjKcSJsTFvn8eCnjoYnZ2ornYXnUFQjxGJmoZZW3WCVV+TDNuCY1yQCExKWr+a8BdgA5bhPIitrLyN/wwcg6XqQeM9qvJ7g8jzOI/zfOmYTD26VPP/WG9426zkz0WUhuIXvsRHIx9uV6jDDKLR3ztCMLqabSe3+Bb6a+lMaqz396jxM60ZEH5W1ivnTXhq5b2iABIuQEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(36756003)(38350700002)(38100700002)(44832011)(83380400001)(6916009)(26005)(7696005)(5660300002)(186003)(16526019)(66946007)(6486002)(4326008)(52116002)(8676002)(478600001)(6666004)(1076003)(2906002)(86362001)(66476007)(2616005)(66556008)(8936002)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?44SK/AETLKwb++fViIq6Z0ZxQiu7LBD3GzbWzQQu80rwi7m1r6l51sJGOoL4?=
 =?us-ascii?Q?6VHNKEbjXDQQaiPEcTV5AK5RzdsZ6ahIJZzSrP93Y44yfNyFJEezPl5WGDga?=
 =?us-ascii?Q?4RKYOqMVDKYZo3VKzRNW4unG5LrQ5XPDiZA09rWe+J779ISXJCy5l9ZAP0xL?=
 =?us-ascii?Q?8bqTpDF8CQA2DKn4rV3fjMBbySLJuHofTKYeKkQtKy9iGuoJgOIgQFU7gZao?=
 =?us-ascii?Q?6/vh4RrRXAgvMnxpEcfjkP7wYqiC0CU9Se/7gvmn3iH2QGEaCIbiCSCY+gDb?=
 =?us-ascii?Q?5gDXt/yGbhiEdue7dhqXRjcMtzter00G6Mr/07ATb+mLZrC2MzJVYALfTSmJ?=
 =?us-ascii?Q?/rAkEsOkREnzJ9lr4aIjqgGqJjg19R3zO4FyoLemLvSQjsOuEWbKGRi3YTYy?=
 =?us-ascii?Q?kf0bHawUxplP+Mlzc4LV6coWofpJxcKeI83e6XPUluGuUmAFKi4UQehiT7l0?=
 =?us-ascii?Q?YfEnnK9/CwWWb02nXO4UVW4ibd4ae3kkDtK4gCWM275S+Uo49g6W53MkJ5i7?=
 =?us-ascii?Q?5KIm38WiZJ52lhsDb3jCfCBryoS5AsUf5gJ+BqkG554dOBPS80qeODa2dIHr?=
 =?us-ascii?Q?d6cDNE0zHcrQw0b4l8B9FH+P+uM7IitiuiClHNyC0gGCioYvwvOkESIJLBnv?=
 =?us-ascii?Q?8Y8/vQuf16VnCsB5fEw/brjfj7KgR6NjBLdJawtgViDJEO78AEElIjQgcyWq?=
 =?us-ascii?Q?vJ5tsruGjXKdyHMgU87ROoyH960PRz/5Iljlh5pAyBcvrrX95X3ndXHk7NAc?=
 =?us-ascii?Q?7aqwaUZ3aUJaKWT231IpCIMYwJcgGYqsswHOyhiD6adSFgKyS4hg/adRxRaW?=
 =?us-ascii?Q?ob2XCaWR0Nkbwhiyq8CyBfI8EJBGd9Xr/4w9TtrivBC+IFAHZyBySS/7Nabn?=
 =?us-ascii?Q?HVlRQYusuf/9PdRu54mH04LaPAxV80lM5M/u3qcCWw80wVOJNh31k/UjZtgd?=
 =?us-ascii?Q?3f0OOXmI7ZjSYCotzkDAZI/0h1IRHfcTIttJ9rMhHnL9MBgnkWlVu4FEtb9U?=
 =?us-ascii?Q?HxAuv0aJGub3mvq81cRtC6+BUzK3tDpmtblw2UK6CCD6LqH30y0YuD9XwNu1?=
 =?us-ascii?Q?CyByCpg4famyXIFbK3JS1UxxVu87/tqoDkhNAFYwojSGkeAzwbiW9/v58gBS?=
 =?us-ascii?Q?4xFB0LQRLvM1AeBK0+bwvxSXZBsDa9EeaYrCUXwwJh1XMF0zrosRivUQHJ7C?=
 =?us-ascii?Q?mI2p/HsV73YXZ4g+a7taqHAX3DSnwuGjb2ftXqx42+jMHDeUye8aE3o5NWMV?=
 =?us-ascii?Q?Sqo/CsvpCebxm4V5m2Vh/ZziSofWbkQSryXNKYCLwYkohF6UqeDgjfDG4nIJ?=
 =?us-ascii?Q?xlDB8oatVVKrh5r07dAji/jA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d73653-6272-4b35-cbdf-08d9367c0200
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:48.8836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9hVH3e4y3s7P724imFNmE/QoPHOc8zLThUdMXsZq3LBY19zRPPXEeG7r/yQYAwSvlWw7ofTyRxTp5Fx5YY73g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move the dehashing code into a separate helper function. Define a
DF2-specific function for the current code. Specific helper functions
will be added for future DF versions.

The dehashing code is tied to interleaving mode rather than Data Fabric
version, so save the function pointer in the ctx struct. The name
include "df2" because this mode only exists on DF2.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-9-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.
* Add new function pointer in ctx struct.

 drivers/edac/amd64_edac.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 68c4aecd5e7a..46b0279a2e12 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1098,7 +1098,7 @@ struct addr_ctx {
 	u8 map_num;
 	u8 intlv_addr_bit;
 	u8 cs_id;
-	bool hash_enabled;
+	int (*dehash_addr)(struct addr_ctx *ctx);
 };
 
 struct data_fabric_ops {
@@ -1111,13 +1111,29 @@ static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
 	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
 }
 
+static int dehash_addr_df2(struct addr_ctx *ctx)
+{
+	u8 hashed_bit =	(ctx->ret_addr >> 12) ^
+			(ctx->ret_addr >> 18) ^
+			(ctx->ret_addr >> 21) ^
+			(ctx->ret_addr >> 30) ^
+			ctx->cs_id;
+
+	hashed_bit &= BIT(0);
+
+	if (hashed_bit != ((ctx->ret_addr >> ctx->intlv_addr_bit) & BIT(0)))
+		ctx->ret_addr ^= BIT(ctx->intlv_addr_bit);
+
+	return 0;
+}
+
 static int get_intlv_mode_df2(struct addr_ctx *ctx)
 {
 	ctx->intlv_mode = (ctx->reg_base_addr >> 4) & 0xF;
 
 	if (ctx->intlv_mode == 8) {
 		ctx->intlv_mode = DF2_HASH_2CH;
-		ctx->hash_enabled = true;
+		ctx->dehash_addr = &dehash_addr_df2;
 	}
 
 	if (ctx->intlv_mode != NONE &&
@@ -1347,8 +1363,6 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 {
 	u64 dram_limit_addr;
 
-	u8 hashed_bit;
-
 	struct addr_ctx ctx;
 
 	memset(&ctx, 0, sizeof(ctx));
@@ -1379,19 +1393,8 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (add_base_and_hole(&ctx))
 		goto out_err;
 
-	if (ctx.hash_enabled) {
-		/* Save some parentheses and grab ls-bit at the end. */
-		hashed_bit =	(ctx.ret_addr >> 12) ^
-				(ctx.ret_addr >> 18) ^
-				(ctx.ret_addr >> 21) ^
-				(ctx.ret_addr >> 30) ^
-				ctx.cs_id;
-
-		hashed_bit &= BIT(0);
-
-		if (hashed_bit != ((ctx.ret_addr >> ctx.intlv_addr_bit) & BIT(0)))
-			ctx.ret_addr ^= BIT(ctx.intlv_addr_bit);
-	}
+	if (ctx.dehash_addr && ctx.dehash_addr(&ctx))
+		goto out_err;
 
 	/* Is calculated system address is above DRAM limit address? */
 	if (ctx.ret_addr > dram_limit_addr)
-- 
2.25.1

