Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5A43B2109
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhFWTXn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:43 -0400
Received: from mail-dm3nam07on2082.outbound.protection.outlook.com ([40.107.95.82]:56929
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230312AbhFWTXW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXMM7M1DSp9YoMRQDnqQYrIqD5fdITicSqoYNfAzGUs9QJKttBVsjWuvwzxDb6+xgGO5AXGoOqdcV/OdH2VOqcqPWz+0nh/gi0SzAIyeD+ZUgwy/ERfdpGp5iRJRoloZAZVJoZzenWXm55+4hSLHw8I4SxkghTlT140gHEnZLRfS2Kqr6/7HhEF5o/A2AgMshN+XhvsQSUYz9cyOrhT7U9lZd1L998zJuAZNjiRMU6GOzrIZ2d4n7//H6Y8VggRXIAROE7/qQfmMFhRb1am7fEF4UmCAj+fJTi75gp+6NJh4sKsxHQsPmcTmluZsq/CQ2XqWWoIWu/4THADIkKfx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78BKPkIj8X3DKKCSDRPaxEvICraMMvcEwaIpKQYaEtk=;
 b=FSzyLFvnBBpM+LFtNl+4mgpTAq+qOk09PQV5QjkFK+KTNe44LU49veMN78E5DOWHnaqYXObC+2fAbj0oZW+tUy8QnG1CqVEJgap8Ztj4hC05JQHhs+r3HZJ2AiZobZq/GYnnxTiTaFwEmRk5JnnE/RpyQLht6bHCEEvaQi+FskYmUejOyJ4uMJW7GDV13/wsdePNWeWAh5CXflZtsU/fKVDEUsBjlGgEdsYO0l+H9qLdqkEWprau2RgQ9dlfluhSxJR3gE2atP3BvltLgBOiByKkehN3flP1drNvnuuAWz4IkwK0HsWzXNAVJvCtzfZwu0cw/HBuBk9dSsFoO6+CuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78BKPkIj8X3DKKCSDRPaxEvICraMMvcEwaIpKQYaEtk=;
 b=qkVN0dQ2BE9hPJBWJ/S3aTT5pJ+fmJ6P/1na5R6Bg6eeht30SPKRAHkwohwtCnIvwNPCCIDWpmbDVoVYq1G5W3V3ldgp4IuVHNs3b+3p3Ok2fHTr3zJhu/N4za78y4xee85pUnkPsrBYnfyWYVXrkhEPeytuYfQ+le2zCe1Omgs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0211.namprd12.prod.outlook.com (2603:10b6:405:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 19:20:57 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:57 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 22/31] EDAC/amd64: Define function to make space for CS ID
Date:   Wed, 23 Jun 2021 19:19:53 +0000
Message-Id: <20210623192002.3671647-23-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a2525f9-ebb8-4ba7-86b5-08d9367c0731
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0211506E591D692BB8CDFC4AF8089@BN6PR1201MB0211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dq9aHyxT+dM8xKsA8b7g5qTCnZGnrfXG1f44yUcdL6CHx2Jkjjea6Z4O4m25dLDBqEE6R6zfIM6w9jaQdbhBQgTF7O+s8mZjVB8b2EgVFGzbZRsmIjb2p/LiNJrJUfuZwKGxu69ahRczyPAEtbHNWrwwR1V2ycn1/BeKg31aixdIovJ3scnO7zGWQZoeNBSve7P0T37kpc7Ezicq0wYBh7adpguwWaLL1QGAUTVSwfkIlOv7yKfkVPvn8xfdmeg3mc00BN3/qz9SSFB4b40WSmZD3MGIgUnvEmPZ/KALoIDIFRGKX//uxvYa+rluR7MEWZGGo3WYj5aiVzcd6Q0tbM6UQKS3w7s4pTD4ccuBzBDPHQiob359e6I/IMb3QsslNgXTfzXF7f9eOwr6TFgvyyPsHaKFrZU74MyklHOXS9yW/PvdukiP1Tv3g7OXo5tanrQDIMUdRWk4G9rov1yjiOfRpYdgkO1Wraq8QlvXEeJfaNRhh1u+ogHUeUR3v55FlL0MeLNbKEi450Q/Bo4Ek4JUV3O8QBjLfHRsxWypSjeFpm1FPL4AUGkUqy+J/xG+nKRLgxPaBTzH6a+wCBUAMBWU4jrKzVY0zfQxw608f6t6Bmt0ARzf2BMBugLPwjOhRAIeZoF+069OUhiWEoxEOfhvRRJZg5ELjUYOVrXYnaNQfKltHDdTqIRktjJ2idY7JEld2hLjZheX9oK/YOvi7jrzkR+87poSH5ysT+nDxlTkdlSCi5uhxDdTcJNKgWwIB4U0IGB/81PTMoctnpY3Ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(1076003)(6666004)(86362001)(956004)(66946007)(2616005)(36756003)(316002)(5660300002)(83380400001)(6486002)(966005)(38100700002)(478600001)(26005)(16526019)(186003)(7696005)(52116002)(6916009)(8676002)(66556008)(66476007)(4326008)(8936002)(2906002)(38350700002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nmg8m66RrT1xrDOYi1k5QgwHLte5cETYWpaLRKm0nxFeTrprYVL+gQVUk2ky?=
 =?us-ascii?Q?t+8dYca7+5nJwpEmkfA6xzbwgd5ZaKuxfKgkAz/e3LpyjZoSpyF7g9olzBB4?=
 =?us-ascii?Q?NBxREltJ/JF1VnAoicTnaA5p0TKQMUFyzctLezQSYEz3SIMaXhYAj+720M9A?=
 =?us-ascii?Q?NN6MM+fYybDNfiOQ3KyGsDyW8GdVnuJuZKwdiJgC4iULCDeVM0BeenYqtE5w?=
 =?us-ascii?Q?aKwS2u0SIszEKX9QdrgwrKIhm2QSN4RStkQE2RoZfxoImW43qGPNQK7PnyFX?=
 =?us-ascii?Q?gdE1WphiKoYtJ2tbDron8BqPmh9zNB3hiKvz88uMTRYgTib1GaGqH3yi2htN?=
 =?us-ascii?Q?iPzJgGLIFPQ9fSbkE+Quh8w3eO6IrCaQfWK1IMhHFsXQlQTowBR1GiQ2BBkY?=
 =?us-ascii?Q?JHcN1m965CYc4gpJc7NhY4HhPnJoC+Wc/h6JCRvXfklg99Nf+nH5Ihx2Qcbb?=
 =?us-ascii?Q?vYuzHUY3+H9C6wFEivsp58JeeNw23GhPH8TrUkV7EA2EcS5Btzu6jisbvZ/j?=
 =?us-ascii?Q?8OGEixz5cXObQX69lSXXzYHAG6uURz/2uE6Lvjkmp0rXTyASQn7jwFKzZ3EQ?=
 =?us-ascii?Q?q6jc1Wm6gYFa7aMS1PnPBM+5qKPfNUl0f74YQPtjo6rUODb/2wY+BoBWSeGM?=
 =?us-ascii?Q?wkJcsQ22qdSU2Ke7aMkLju0kQmRhntHX03AOTZHRveRVBk/9S17uXrTFudZ1?=
 =?us-ascii?Q?22renOuLig/1bjFaZTugGvWEV2m565WrRLGev50J3ShLfefKqwSFVbx2gDd1?=
 =?us-ascii?Q?VbjT88NxOoFSJ8HjsvsR5Y33qxBDfqy45e3Hy2G/J8Nz01SrM6YQloLIUu2z?=
 =?us-ascii?Q?ca3yWxubPrQhi6+9a49r3s74X8nP9nHRp9Y+UU3kR9RWF+vM2fURMYic3FYC?=
 =?us-ascii?Q?jaChBxiFEbbdPsWuiRwWOuZIEvzPJejYgvQVXAg7ESSR21C67wm8uhtx5Yro?=
 =?us-ascii?Q?X3WphBMDwZ2xfYYvC4V5YLEjTK8cgdIBjZBirdNgbw1cyugFl4ej/biE5INe?=
 =?us-ascii?Q?kgGrjZrJxB5WW/ar7MvtWSxooI//zmpUybKr70Tl+sBXlLielI9Dk3AgPlkQ?=
 =?us-ascii?Q?z89hExUxZIHzwfyy4nhuMdYnq3WSFUPzyyTicZx10qFnTFG7u/+aXrrDvm5P?=
 =?us-ascii?Q?eIkFap9kaG1CMK8Ue1ANaGW23O4MltxZtDxq4cjW53oRM3nLGm3zQdAPuWxl?=
 =?us-ascii?Q?crPNLJNfqj0/5c3lyKeZ4/LgUQ6LXgVeXrvoW4qob3jSFrN9+R+66gCtsMXO?=
 =?us-ascii?Q?38c9hN5N2rdvvGYJ1LGx5fN6uq9F9tfe2u29jxWz90aSuH1NLz/wkLC7x0l9?=
 =?us-ascii?Q?7i109fj5JVc2naI7g2iLccC+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2525f9-ebb8-4ba7-86b5-08d9367c0731
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:57.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJrlVgVcIcibFEBL27c5K4Ups0MlpYn9RrZo0iQOs/ASxHy0a1tdOTPlv799EROUlDQR+BWOMZH/Yyby/kGBMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0211
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move code that makes a gap for the CS ID into a separate helper function.
The exact bits to use vary based on interleaving mode. New interleaving
modes in future DF versions will be added as new cases.

Also, introduce a helper function that does the bit manipulation to make
the gap. The current version of this function is "simple", and future
interleaving modes may reuse this or use a more advanced function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-19-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.
* Added new function pointer to ctx struct.

 drivers/edac/amd64_edac.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index e5c296b00f5c..b497af7c3561 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1102,6 +1102,7 @@ struct addr_ctx {
 	u8 intlv_num_sockets;
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
+	void (*make_space_for_cs_id)(struct addr_ctx *ctx);
 };
 
 struct data_fabric_ops {
@@ -1111,6 +1112,29 @@ struct data_fabric_ops {
 	void (*get_intlv_num_sockets)(struct addr_ctx *ctx);
 };
 
+static void expand_bits(u8 start_bit, u8 num_bits, u64 *value)
+{
+	u64 temp1, temp2;
+
+	if (start_bit == 0) {
+		*value <<= num_bits;
+		return;
+	}
+
+	temp1 = *value & GENMASK_ULL(start_bit - 1, 0);
+	temp2 = (*value & GENMASK_ULL(63, start_bit)) << num_bits;
+	*value = temp1 | temp2;
+}
+
+static void make_space_for_cs_id_simple(struct addr_ctx *ctx)
+{
+	u8 num_intlv_bits = ctx->intlv_num_chan;
+
+	num_intlv_bits += ctx->intlv_num_dies;
+	num_intlv_bits += ctx->intlv_num_sockets;
+	expand_bits(ctx->intlv_addr_bit, num_intlv_bits, &ctx->ret_addr);
+}
+
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
 {
 	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
@@ -1141,6 +1165,8 @@ static int get_intlv_mode_df2(struct addr_ctx *ctx)
 		ctx->dehash_addr = &dehash_addr_df2;
 	}
 
+	ctx->make_space_for_cs_id = &make_space_for_cs_id_simple;
+
 	if (ctx->intlv_mode != NONE &&
 	    ctx->intlv_mode != NOHASH_2CH &&
 	    ctx->intlv_mode != DF2_HASH_2CH)
@@ -1278,13 +1304,11 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	df_ops->get_intlv_num_dies(ctx);
 	df_ops->get_intlv_num_sockets(ctx);
 
-	num_intlv_bits = ctx->intlv_num_chan;
-	num_intlv_bits += ctx->intlv_num_dies;
-	num_intlv_bits += ctx->intlv_num_sockets;
+	ctx->make_space_for_cs_id(ctx);
 
 	if (num_intlv_bits > 0) {
-		u64 temp_addr_x, temp_addr_i, temp_addr_y;
 		u8 die_id_bit, sock_id_bit, cs_fabric_id;
+		u64 temp_addr_i;
 
 		/*
 		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
@@ -1340,11 +1364,8 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
 		 * there are (where "I" starts).
 		 */
-		temp_addr_y = ctx->ret_addr & GENMASK_ULL(ctx->intlv_addr_bit - 1, 0);
 		temp_addr_i = (ctx->cs_id << ctx->intlv_addr_bit);
-		temp_addr_x = (ctx->ret_addr & GENMASK_ULL(63, ctx->intlv_addr_bit))
-			       << num_intlv_bits;
-		ctx->ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
+		ctx->ret_addr |= temp_addr_i;
 	}
 
 	return 0;
-- 
2.25.1

