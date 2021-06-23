Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0203B2102
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFWTXZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:25 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:24416
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230232AbhFWTXQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XK6bFjtq3cZ58C3wqIJPZmttHEM1heJdmHQ+FMOpkoUyaZvhYYfsGd8kqX92KVWL9D1mlzs0l8CTjD5PKUb9exeXZRAfY0N4HQ4C1CShZg5Uvv8JnWAEGu8yknpRRqaZPutqlIdvPqxjZrdgeH4aql9TGuuQNH0vjrpYlF3vu/REvdzhBS74W9XxeAfhAwVATITks6wOTz1edVFG46dGpYY1+117bUWm1wpru22QwmGqtXDPB8lJz5Ab9IekruhlTCW6YjE3x0ryIgaRZi5YnaXIfzatkwM2nOMWEMpVvsHsGAqFJwe+FUvarntcc1CvMpujIBPrGF34tTeAq3BY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFtaxCgkzTOevnAp/johgkt7aCy6Y1zqUF7KYEJLKGQ=;
 b=Glw7GgeTB3Nygmg89+IVNGllyP1vqPIyil+4lCkqLhvevyawWx1dgtxGOS3Lu/pr7WBnWVjkny53sZ7abdNKcmT2XIcikTFdvpHbha30gtKfmth4xy3LwaJ1tU1WT5LC4XW1p6I/H3sByd3eXy6dgbfX77GTbs64z5biH9U+DY1mHnpfUkslykdAo7Xf8J0nxwvPHbBxvmBQeCp/kBLchTthuUWpClyylY7cLD8hGOE32MnVr68P1F1O1bzQMboD41XCEBQEbm9kbpZpbwZmN3fan0IKGpZBloemEAxlMzzPuJq6GoXZVWshGwIdgGatfsieMNwLskmjWsynYV7CPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFtaxCgkzTOevnAp/johgkt7aCy6Y1zqUF7KYEJLKGQ=;
 b=LLkeg1W5jqYm7rf1SWKQ3a3J7n/qdZWGRkIg2RhnCwIutNGePpLWy7DGg28OkMxEC5ZmLrYo6dpz6rnc7hoj9+rb9N9CTK6gL2V0BCJFSqi8tVftUQTqvaL1vPU77BkgxFveNI41gslQiohknxL9dxupfjKN8OQnhsDlclcu54w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3218.namprd12.prod.outlook.com (2603:10b6:408:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 19:20:55 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:54 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 19/31] EDAC/amd64: Define function to get number of interleaved dies
Date:   Wed, 23 Jun 2021 19:19:50 +0000
Message-Id: <20210623192002.3671647-20-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c836860d-97f4-450c-7ca7-08d9367c059c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB321872EAFC5A13903E5C8460F8089@BN8PR12MB3218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JuAfKC2YsN/X88lSDz73Q4anTwZDWxCdvO3kJC4FEkcPH1owaAD9SwVmw+f9ITAbzgdg+5A3PGEXc4loRcMzxaa97yxvz1RQlsR/OKD1IUEHf4/0GQ/MlKCGbMTmtCGpi1F0CdywKYQaEAoZ/4hBmvVdVLNQKB3qb7Ja0t3ihMlfOefbaack3UezMB+vBGhztGyUkjWpDS36XMB2eaNYrvE/A4buB+6GxF6OlxPoYfLK7Rr9YiAPC4TsG9TkziqppN/F2vdMotuEM4QDZAUjLXg2XrZxxXl6H3cgwrf6V6DVGQdCIVzzYrht0qkpNIKdCIdKxHegXHcXse/yfxUDB6UM3aPgIUxqJP+oiNyAVbnRd6V3QeBsiS80SJBYN486SEEcZ9P5TamewD8fyPOqy3D0L1ATBL2Qj+LJXLOdVufgF+1NtriEBioZS+Omo784PosCr6612C/WVbtGoyp1N+vf9iHM2OGwJ20yLP3AKQNUuMzOT581CNP9or0d33CbJqYa7KtMi9mjB1cNMtnIsP828730lP3CAgbnU8Lg6+7xk0hhipq2BBXHHNrlxwGxw+LdwZ3du/xUa5QG8w/9wA+VKMP9ncxfUM3fRs0dad9+cUS0cEp5cUMGBYz4lRzaxl72MqkveFlnMKUW0vB5H/gWVBRiYFzAL3I37SxMUFGEcBVBfBHeOxhsMRYVYrfF4zGW/0qiATKGniZSyWB3lELBUujsOGzEcuteClWiKh96XPdHAW3m3fyb1c8SwaWFDX7z+Us8L1qG5ZSFOYPfK3ryu5sdLNRG8g/+lR3RiZdZUO1tqd67sS129YIZlmw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(316002)(6486002)(6666004)(26005)(16526019)(38100700002)(38350700002)(956004)(44832011)(2616005)(86362001)(2906002)(186003)(1076003)(6916009)(966005)(83380400001)(478600001)(66946007)(5660300002)(7696005)(8676002)(8936002)(36756003)(52116002)(4326008)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hy1yzkmUAouDCd2C9/xXDYIJVdwx43VQB+KJZPPZlKUizgwLZ7wqFbN5AYp6?=
 =?us-ascii?Q?d1YrnZGBsnr/hvdMEvGDjFyHjLni9sJxTZvktS+JpiIJF0chSGlIDhx+mHLJ?=
 =?us-ascii?Q?uilsJkpJLHhILiBiNSi8nsIKN3LlrGoX12ZqWaFw9GvG/GThqNILJmQqlr7Y?=
 =?us-ascii?Q?8+J3UGRJv4K4YLN/S/eAyxmmgIcONjwgij78qF9d3819xDxEMD0PdYBHEc+c?=
 =?us-ascii?Q?M1Oeecynl4fo50nUPnDspCKTi0g2aFUVj1Sym6qhIvGQ2QiK6BJtOfQxS1Ni?=
 =?us-ascii?Q?BzZuqYGFsZPnUoEZxENe1CqwJAYfpDN9RPQcYTR5kbg3b1Vw2hfgCCK+ygz4?=
 =?us-ascii?Q?Fe/G5M0AW89cZnp1cww8BMhHyGPWQNm9BSQ5OWgY8S/zzE9p/BuJM1vt6s70?=
 =?us-ascii?Q?PkyNsU618CtwYQx3iWVokXZpO3SU5VHfh4y/kswSn019hzPr5SSYi0cWQOVw?=
 =?us-ascii?Q?DeWkkpFR0SuwQ8ZHyCJHZy3Y4ZZwe/McNDpyHgm0ebLWyR36UW7TvVDnyPN2?=
 =?us-ascii?Q?4LH8GDGXnn+UIn9Vv2eyh5qeF9IQgyG76h3F4CKcw32SnsDKLRG8SyrVAUEQ?=
 =?us-ascii?Q?knHhr6Wt1VtBRjoltjLQpbFqY1QlAKV3SpAYLPa8xByjqxwnxjgQD0stIl+4?=
 =?us-ascii?Q?GjUWLzEtWQ1waMjR2heLLAvnJwtPKzstzbJdXnkcamaj7TubgyeI+moiZNGk?=
 =?us-ascii?Q?Pqk2xKPACikAYJPYdhGesKHprUAlZ+b3WC6zUiSZKDdhmqJKKDZ8otBYNuJV?=
 =?us-ascii?Q?ctDO0viukxmoMbCrY+EzXeIBlCSYPtOlF+trPOTM4FMkY2AjlJSQpiWG5Gqz?=
 =?us-ascii?Q?iKAhUrWv6XgYwfvHzffQuabgkNUeclkug+0x9LaVZO5x5+s8VK86HPZRkOnz?=
 =?us-ascii?Q?NCmVjTwjGGOLpUMlS8yBqt5XP84SwIMqUsgmpKO09U1QeUStkrpCt8qmAxWf?=
 =?us-ascii?Q?uvhf0K9iNgSRNu8WmORr0bijNc9mPt4gRFI96dCb+fV4wmOaF/dSLyBQDrYc?=
 =?us-ascii?Q?iSMJk8O4+tOhOZJPAZh2D8YEpMMk6OrTj4WwLqJsrer9t0P9XhdNFk9lksRy?=
 =?us-ascii?Q?ewx80lTkjoM0N5MEHoEuC4JG3ghLI3ClWUnujK4vLbA83S04JxQC5oeyk7R7?=
 =?us-ascii?Q?KoPiEQdre1SwL8wOIF4n/+e1PxDgUX+vuEynzrdUT/LKG0yyULZ1V5lxT0lN?=
 =?us-ascii?Q?Nru0lItZ1DY+jXhFaRzRqEsr511l++8ufZ8pNZTzn39XA6myzTbkNpPrvE6a?=
 =?us-ascii?Q?2UJ+OOEsTd5p2AciltQfaNOusOqRBV8lT+201xP7p2q/VZZXkyqdyU056Y+7?=
 =?us-ascii?Q?yNjeCwXsM+bwOPhU1FK/RB/9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c836860d-97f4-450c-7ca7-08d9367c059c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:54.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmviUMK1iHeYNJ1h+hdtAqG1dIOoIbYlqEgNW96OT194EfeBQqItke3ThpL9QCrSNungs5yyhEa+7eFWdDY0Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3218
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move parsing of the number of interleaved dies to a separate helper
function. This will be expanded for future DF versions. Also, drop an
unneeded assert to match the reference code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-16-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.
* Add new function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 80192a05bb93..360fbecf0d8b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1098,6 +1098,7 @@ struct addr_ctx {
 	u8 map_num;
 	u8 intlv_addr_bit;
 	u8 intlv_num_chan;
+	u8 intlv_num_dies;
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 };
@@ -1105,6 +1106,7 @@ struct addr_ctx {
 struct data_fabric_ops {
 	u64 (*get_hi_addr_offset)(struct addr_ctx *ctx);
 	int (*get_intlv_mode)(struct addr_ctx *ctx);
+	void (*get_intlv_num_dies)(struct addr_ctx *ctx);
 };
 
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
@@ -1145,9 +1147,15 @@ static int get_intlv_mode_df2(struct addr_ctx *ctx)
 	return 0;
 }
 
+static void get_intlv_num_dies_df2(struct addr_ctx *ctx)
+{
+	ctx->intlv_num_dies  = (ctx->reg_limit_addr >> 10) & 0x3;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	&get_hi_addr_offset_df2,
 	.get_intlv_mode			=	&get_intlv_mode_df2,
+	.get_intlv_num_dies		=	&get_intlv_num_dies_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1249,7 +1257,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	u32 tmp;
 
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_dies, intlv_num_sockets;
+	u8 intlv_num_sockets;
 	u8 num_intlv_bits, cs_mask = 0;
 
 	/* Return early if no interleaving. */
@@ -1260,19 +1268,12 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		return -EINVAL;
 
 	intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
-	intlv_num_dies	  = (ctx->reg_limit_addr >> 10) & 0x3;
 
 	get_intlv_num_chan(ctx);
+	df_ops->get_intlv_num_dies(ctx);
 
 	num_intlv_bits = ctx->intlv_num_chan;
-
-	if (intlv_num_dies > 2) {
-		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
-			__func__, intlv_num_dies);
-		return -EINVAL;
-	}
-
-	num_intlv_bits += intlv_num_dies;
+	num_intlv_bits += ctx->intlv_num_dies;
 
 	/* Add a bit if sockets are interleaved. */
 	num_intlv_bits += intlv_num_sockets;
@@ -1310,14 +1311,14 @@ static int denormalize_addr(struct addr_ctx *ctx)
 
 		sock_id_bit = die_id_bit;
 
-		if (intlv_num_dies || intlv_num_sockets)
+		if (ctx->intlv_num_dies || intlv_num_sockets)
 			if (amd_df_indirect_read(ctx->nid, df_regs[SYS_FAB_ID_MASK],
 						 ctx->inst_id, &tmp))
 				return -EINVAL;
 
 		/* If interleaved over more than 1 die. */
-		if (intlv_num_dies) {
-			sock_id_bit  = die_id_bit + intlv_num_dies;
+		if (ctx->intlv_num_dies) {
+			sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
 			die_id_shift = (tmp >> 24) & 0xF;
 			die_id_mask  = (tmp >> 8) & 0xFF;
 
-- 
2.25.1

