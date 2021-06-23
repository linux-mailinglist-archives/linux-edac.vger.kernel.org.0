Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6F63B2121
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFWTYj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:24:39 -0400
Received: from mail-dm3nam07on2069.outbound.protection.outlook.com ([40.107.95.69]:36384
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231139AbhFWTYN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:24:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0j3TRzFfEeEFQHokqnKKQ7eOvA4QwED8sAdfxrjvUuE940fREX/VagSz6K6F6xOPlssnqZVCd8x5iMT9M3pyJ+j/DGa3Ty+REECyAeKemw1oEdUn0Zg1OITqV58ENXxRmQ3NuGhERb1b/nhpvcA5J8Cxe6PPyfJ6pRXfVBnRVQcK5q6pSdR0Ta7nAcnBDS19gRxx17lNKTv99QLgAyfMtw4UkGXkm/2eb8HXAa3bACXTQEm26IDGYPO3dvJGygpZ9blGVHO9fKINyQsPLtPI6Cy3ylDhbzhduDlwuKPibNN20vVFghTwLyrFdzqm7KxbIRp0Do/DqPOhqQGP3fZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFCpIRWmCgCTVNtOPk2t6FpxOn5rsEw3G1lVWdOGfPE=;
 b=IowgP/wAS9mrzkhxvs5ay5FkgOWmsJfhHPrOk997pw43fhW//S6cK24bM8ZzIklwvijU7dcZN2XXn+OhRwENulH5eU1H7tQ0CFgtvbGqaU/nEvdMFQON4K7OWdCEmv6PGLDe3kYNGMMn4gOyvTmNssfTXDyRzPp+PNGEsFVvRD7436o/kvP/EnIV7xAZkVHtj60S2bW5IOYI9o0l52sndprj5445jmKzUU+5z79IM1qast3EEmlPdT2KGyF2tFL44xE2Gu2ugAnp6qpGJ272SSWhFX4+vRxy91aUEM53A5ngwhqzHfxZ0eF0aGaRQSFZJZ6iGv1xBvY3jDvzFPzEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFCpIRWmCgCTVNtOPk2t6FpxOn5rsEw3G1lVWdOGfPE=;
 b=Se2aPeSR/yTr7Of5lpGnwVZ+c4m8OEBU0tMNv2GOmtjCTmAW0D6PjL9UNJOPsAuztHtbFWnJWuHYYZye/fOUnqSl70IZ0YSIoY758AYmilGreenHuPmo1baMc1EwAGqgqMH8c/cOxYEL2iDJ2XEbHqxj0ZfhRKJ3+KSkpWCqgr4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0211.namprd12.prod.outlook.com (2603:10b6:405:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 19:20:56 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:55 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 20/31] EDAC/amd64: Define function to get number of interleaved sockets
Date:   Wed, 23 Jun 2021 19:19:51 +0000
Message-Id: <20210623192002.3671647-21-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42ac9c85-c533-4a17-48c5-08d9367c0613
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02115586DE3B21ABADE929C6F8089@BN6PR1201MB0211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vuQ+yGdOA9aeFR+8yIDlwAiO3N3DLE6MuQTGdCOIQ8lESWl4GVBK5gc6gjW7KTNrCUY+/Mz08KOy9937GrTcTaXrFxd99KwgYBtto2uKoMdm2yQjGPCQaIqp9J+HSzj4Emo4pIp2W7Y7sKtat5QaHbFz1fPRDM9aMTuiqgRh0IrKzDdXde6ODoYd6tbgYbSCqtqeyPpOfAPn13zUzRmDCBkTbB/6m2ALwDcppSUC/3MpavrcZqTpZacB29FtwdwoQXCj5mK5MhQPmBFKg5uEUe/vbV4msXZgd0/tiQlmPDt8oPUWOqEsYz2fpANOJ991intkYR1x53m2bcwDUId3Na1gfsi1oDPfYfFjvcD9vo9CWEzpUi29QninbCiRqwZDT+1BT7irWbodNjsgg6oqTdyDC5ot+jAbNY0u0x2y+1wpYHY8xmX1kJGp7MJGaQwIEkG7kKz1htmTo/x0ZpYWQZCw2VuZWGJWp241WARkUjS1Ru1JfLFLwZCJ9Id5tAzStpMJ2HND28Uu3DEQ3gmvEhkTT+H/7PMgLKdm1IisqW+byhWIRbb/nBirv4BQc2Z9lKKLMxe/SdJoPa3XLjRRLOFBaTrd+DNjnzmWXwZuUJzQo3IT8YYZoE54DJYimj4GsvglvYU6pCH1yIgiyAYpo4KYxgDuuoSBV8rl8uJxUtoLIMJk2lptoRnSorW4HO/2wxqUtsVSAz3Fl9ToebuO2qcuYI19Zdv1AgNL+mu1+DB9f7YxvJKkMhfs/W4ZtWk+F+l3VTtsa3YwEvTvDQAbNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(1076003)(6666004)(86362001)(956004)(66946007)(2616005)(36756003)(316002)(5660300002)(83380400001)(6486002)(966005)(38100700002)(478600001)(26005)(16526019)(186003)(7696005)(52116002)(6916009)(8676002)(66556008)(66476007)(4326008)(8936002)(2906002)(38350700002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?72hw71TZcti1wdv7VBlWHVr4DFmIoiCT/wGZSYJ95lxuv6sqpHspcIH0W9d/?=
 =?us-ascii?Q?bMQlCYU5Bi7AgG5rPyiFRy0R9XQc0bjBjZYo3LVQ+VRE37xqA2aQ/s4izkm7?=
 =?us-ascii?Q?2lhhsL1GIRnMOiikT+72lTuQBqXMUdubeON5jrVKA0RYo9s/yLoL0eplgJUb?=
 =?us-ascii?Q?k4v4EY5hruxjJbu3sCYCgOBFJDjgxHqFZhAoSyexw0v37nwFrc8/1ONFAxSP?=
 =?us-ascii?Q?Z6NtuIFx35ORaaOnCEjZjTBMV2nZmGOFjQlzyC/I0dfFQyugZsQVUVXy5P6o?=
 =?us-ascii?Q?xk0y7WrBCuJrECY1GIV5mz0Y6q1HiLaIe2wwvpd0Y0mKfh7Lb/T9/O89C6wL?=
 =?us-ascii?Q?kdNXwMCIq75UL+l/GCXkjC/ZVmes+QwBSBQzCkofkgDkUwk2rHyUbotuZbU7?=
 =?us-ascii?Q?YL9op3SP/ITr95PhfmKo77a504RMExP8Tb2FCKH5JmMAcyqnIdHRqihNSkHg?=
 =?us-ascii?Q?Wa+20+/8nxbzRnRHMCN90PU9m0/LbcprD2C+5NxRSULD7I2ZB1EBhyMijgox?=
 =?us-ascii?Q?Tyeqeve9Ew5wbirHu4AgKlTDidGDcFpZxS9imtgZ1eOzaw0zusOqw0/Tu4LZ?=
 =?us-ascii?Q?nFnuKB7u7GT++gZK4DFWO+Eac/Xh7nP7/9eiMrs39ylrjgZjuC6cQQ/RxlIn?=
 =?us-ascii?Q?7yIoy84Y0hRQD3kerODlo5HEOsh3XKEvK4MnxhgplP30c/A0YOsexM3tUexY?=
 =?us-ascii?Q?ylzNf/GUgxbCEMyDZLxzMwehXlKx3e8Kz2s6mjUEas79UCSPrnoJNj7lVX4T?=
 =?us-ascii?Q?w2McZwZD0Vvj1jdBaEMk/mahRqF013VVgDbpPGSC7yQg+ZNHTUxmJiSgfimk?=
 =?us-ascii?Q?wWaqnNLH630Ck9AClKBCYfXuHp2VM8qVEyalaC+OS5O3nK//g/iuihf74hdN?=
 =?us-ascii?Q?+f5PCbzte3bwJjMISCwNR8LtSkQdk/X2omJ3xK+lX/G56R1NV5R0lky/QWhc?=
 =?us-ascii?Q?U2JyqlPwensGqVPU23odhjms3I8+v6fbTrNg3kNdGK4Mw8EbXIWbcOZxvdNy?=
 =?us-ascii?Q?N2eZ92iO+WxEtvzCz97/UPQYUWHpr/ewzm8/9InZ8taWzq02UmFdpAC1VQw4?=
 =?us-ascii?Q?YDju/qGfH0djwyy0wz6SVeLjyR4A8T999VVm2LsVR7EXPi+2QXx0jZtJrtNC?=
 =?us-ascii?Q?bgv6S9MxNe/5vsbvLbrdyZDhR7dLlycmMkxlWMD3ugs2CSCkEWD2keStcEre?=
 =?us-ascii?Q?iq1jmJt99OX49khXwSf2mdC4MvqI6Y6DUVpAmH38eeOm+O6bFtWd1iIIkvV7?=
 =?us-ascii?Q?WkH7RZEqrTJsY04640dkf1zb5B5UaQIlYxyUBxm733XpQR+nw/VvZ1SJz7XQ?=
 =?us-ascii?Q?AspkqQGl62snDFcK0JittKiC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ac9c85-c533-4a17-48c5-08d9367c0613
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:55.6946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYCDA834nBfx5Bfjyn2jOM+HZyGTp1RV9RbmHDNKgX67o0GssPH+oyHXHfZ51kDFIM6kOe1WvSDNbN32mPzh7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0211
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move parsing of the number of interleaved sockets to a separate helper
function. This will be expanded for future DF versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-17-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.
* Add new function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 360fbecf0d8b..09cdc0466ae2 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1099,6 +1099,7 @@ struct addr_ctx {
 	u8 intlv_addr_bit;
 	u8 intlv_num_chan;
 	u8 intlv_num_dies;
+	u8 intlv_num_sockets;
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 };
@@ -1107,6 +1108,7 @@ struct data_fabric_ops {
 	u64 (*get_hi_addr_offset)(struct addr_ctx *ctx);
 	int (*get_intlv_mode)(struct addr_ctx *ctx);
 	void (*get_intlv_num_dies)(struct addr_ctx *ctx);
+	void (*get_intlv_num_sockets)(struct addr_ctx *ctx);
 };
 
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
@@ -1152,10 +1154,16 @@ static void get_intlv_num_dies_df2(struct addr_ctx *ctx)
 	ctx->intlv_num_dies  = (ctx->reg_limit_addr >> 10) & 0x3;
 }
 
+static void get_intlv_num_sockets_df2(struct addr_ctx *ctx)
+{
+	ctx->intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	&get_hi_addr_offset_df2,
 	.get_intlv_mode			=	&get_intlv_mode_df2,
 	.get_intlv_num_dies		=	&get_intlv_num_dies_df2,
+	.get_intlv_num_sockets		=	&get_intlv_num_sockets_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1257,7 +1265,6 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	u32 tmp;
 
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_sockets;
 	u8 num_intlv_bits, cs_mask = 0;
 
 	/* Return early if no interleaving. */
@@ -1267,16 +1274,13 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	if (get_intlv_addr_bit(ctx))
 		return -EINVAL;
 
-	intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
-
 	get_intlv_num_chan(ctx);
 	df_ops->get_intlv_num_dies(ctx);
+	df_ops->get_intlv_num_sockets(ctx);
 
 	num_intlv_bits = ctx->intlv_num_chan;
 	num_intlv_bits += ctx->intlv_num_dies;
-
-	/* Add a bit if sockets are interleaved. */
-	num_intlv_bits += intlv_num_sockets;
+	num_intlv_bits += ctx->intlv_num_sockets;
 
 	/* Assert num_intlv_bits <= 4 */
 	if (num_intlv_bits > 4) {
@@ -1311,7 +1315,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
 
 		sock_id_bit = die_id_bit;
 
-		if (ctx->intlv_num_dies || intlv_num_sockets)
+		if (ctx->intlv_num_dies || ctx->intlv_num_sockets)
 			if (amd_df_indirect_read(ctx->nid, df_regs[SYS_FAB_ID_MASK],
 						 ctx->inst_id, &tmp))
 				return -EINVAL;
@@ -1327,7 +1331,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		}
 
 		/* If interleaved over more than 1 socket. */
-		if (intlv_num_sockets) {
+		if (ctx->intlv_num_sockets) {
 			socket_id_shift	= (tmp >> 28) & 0xF;
 			socket_id_mask	= (tmp >> 16) & 0xFF;
 
-- 
2.25.1

