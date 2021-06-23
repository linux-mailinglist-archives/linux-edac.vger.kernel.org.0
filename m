Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8B53B210F
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhFWTXr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:47 -0400
Received: from mail-dm3nam07on2069.outbound.protection.outlook.com ([40.107.95.69]:36384
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230241AbhFWTX0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJV5TS3NsDxYtDWqCgOZ3HG8zTIK/TI4ECxJPl/Lonuj2LHTjYF/ulutvAYfbFanOXSQI2cTV8XA8HxAI2X1hfS1hW8yaqvBzDl9WORE1OVIbv6uwNNladwNLW8jMCY9OYEjymKD9iBfvt2AqcYXcpNr0hS90kVAGbFsxxRH+M/2dpfpADX3OGXS8vAnuKTs+E0E1+Hzlhsdu6GlD4zIuoMghiUsDr65TbnoamYRh6h5ubbn6SCix1g0uedBuaKSj9tafwqbpZArsU2ye7PAI1JzeY2iicyEazYSoGszvk5XP6ntjKSe8zS80wthXxrXVicg5Gmmg5dmEDbxeRvrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBntQCmbYa6u+pqJZnRO0gzF5Ml0y/epOyzcJfT0RPU=;
 b=ZErcQWBG2vrlQrjPVt5A2vP9pkT07KgG0g+AIlNBRKy3r59nhHNef9Jv9VRofS27KDTlBqXeog1GY8oNHk6wvTcd2tQWOHQxeKoUcAAWHtBljhgXTAnl3MAMUdEZmNX8xfDkaU/1yxJt4Xagl4M979eGtsW3mxPIV4mOgVmxAryoMcLYPR3sta2LIBRCZY2dR3hozjaxN58N1eCIHHVseMhgCkgwVwMbITqw7VHSwDShiq+olQFkBQmGXr2KJf6rV2aZtSVET0vbliDYzUlhiHk5f5JIaFUrDHJHw/kdH1B/XGLWgBmBS4+ajEfWi8HHDQRUfxs2x7ShjGugKOztxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBntQCmbYa6u+pqJZnRO0gzF5Ml0y/epOyzcJfT0RPU=;
 b=jyO6vwASFJocTPg6XXS/i8s8JMASBbrbakX38L6LWZ9Nq8OW5lI/zPa9eRKA+DrY7hIazb9MvSeMQA1VVCy+5HunS7/zKY1ItN+gmhdkftFpBSR3YwetP0BFSw2CHbaCoqzd76rHQxbGmZo4j5bF+b5O5XCRiv9nMe59Qbj8aKw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0211.namprd12.prod.outlook.com (2603:10b6:405:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 19:21:00 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:21:00 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 25/31] EDAC/amd64: Define function to get CS Fabric ID
Date:   Wed, 23 Jun 2021 19:19:56 +0000
Message-Id: <20210623192002.3671647-26-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:21:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 309f5646-bab4-4334-4150-08d9367c0915
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB021146F7F2E6BAE0170B7F61F8089@BN6PR1201MB0211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygxuvZR1x+qS3tcjSXw2QT0WvqFlwKJl1yow92EgnPf7HLYg73omFmOt6o51x3e0cE3x3onGuU+MZGD8VIRUkjiOXshGcuXv2ltUlWoJjknIuIMG8QkukusJfbv3Pc6GY2gn7IvqxY1ySK0RzGcHl3nT+2GukImTKAK61IMqPqrI08eqreHuGNRxKrxBYLjGgdLwC7l/0gtSxsFeKcaPeB8M1GQF2uxWJrtvR6dP+nbe4AcPmaJAfEpgj/sdGX/bm0WbejTJqBbW8TXc2mQqT4yd43oJD0uZXHCgqBwi+dn8fG6+m5IVUQPXCcK4tXwYG4LyxL5l/N/2PnpbwsLHMdNKR9PQlsmSKWSq1/6r6mA+3tnBlqAZNtyrz9EcMZVM73xM2LKnXKLFdfyVD8XKR3mxTq/qfvJbgwIp9uAnXjUvhGcKFRJiNyfBavnOSxWBh8N8XAz4ZNuEtBH6ORL4a5ivFspyqd9x8DjCZIr3ecLLkmRxNqeCaGftcYR8cJenwAEeuET6CojUnNO9zyw1ba8IYbYqxYJL41gnCD3iU8T3IbhqUGocII+pfXeFJTsT7iNH3M0IufhMwhnI33J5Tai8sDEegK52U8tFISQ0kDS9YF7KXWjwuVTz89E92QxaOiTJ0l73hLzIkDZgO5VTL/x6B/lmpXIrmGHv3XAVziBuQKrYf9VFZXfurJs5CVj2RR//rWUc13fjA7KQWKlSviGqdNCTvc+o8rvlsk4RDIkDZ8BE3NvjHxxeRMZjgWWbUrtiPJG1EgglLn0sdswlUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(1076003)(6666004)(86362001)(956004)(66946007)(2616005)(36756003)(316002)(5660300002)(83380400001)(6486002)(966005)(38100700002)(478600001)(26005)(16526019)(186003)(7696005)(52116002)(6916009)(8676002)(66556008)(66476007)(4326008)(8936002)(2906002)(38350700002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j9E9iNviiGhNUbPqncGeH4PmMa9yfjRR53a1D7NIrqXvaMJNIh8B49fzGEmL?=
 =?us-ascii?Q?wWwLAWS1t0xUtanBL614vPxWxLOohesSb8EE6yRzYrf5bnS/V3CCrFrL6M1H?=
 =?us-ascii?Q?dSAhAsenul3JZgfu2dpFxwypxnGMRDoAsFwKTvESMCF9TxVm2gxn2oeRvvnF?=
 =?us-ascii?Q?3rkTppiPrQnAIKVFXk1VXmCUKSL/4EEGtu6XUM7pUgkG7/vFPWi29wsliEC5?=
 =?us-ascii?Q?3JL1YmG1mqt/a6uaMaphvXVkFzQ/wKilBhoVpoA+syO/qpuZ58Xo7SMcP3H+?=
 =?us-ascii?Q?ZmwhjA4kgdcWBok5vvYIwX1ehU6fMEph+vNCMauisH16DH5bEBdAQ4COtLiK?=
 =?us-ascii?Q?7/dOZFTxoXFv4zxeLnINN0g3kUX6lnmmd+phpy++q+pS1zOcgah3+QMQGcGW?=
 =?us-ascii?Q?9tvbvMyffdJdPi2G8MZ+qAAj4ZEKZMJw2F/DrF8otw/PsBOJrO/KZtzjgAjk?=
 =?us-ascii?Q?+I/I8//Ho4VA1VmpBwaBq2JMBh9wqAz//vX8mAGJNZTj1A4F7lWCqMKyOIsh?=
 =?us-ascii?Q?KebzRbJWN9I+8V7ePkHzwchnYQxGUn2S7T4sAPXvrflAcJRLb9sHZGWmNAV4?=
 =?us-ascii?Q?/aZEZDyb7Wxh+iZhRIs+gV5AaZMfujG6JnbgAgux7aBViCJIJutEzxNwxnmu?=
 =?us-ascii?Q?/JCc6sJ6QSIB3hMdxfSKgbm/Z4ssmQYtEhPc+FAUsqCgLn7ZBmTfm5oQrjsO?=
 =?us-ascii?Q?dAS3Y9kASdmug8aRcorfAf+tqp1Z0tFXQpFCyFt4jQRXARtA5/HAisEDK4bN?=
 =?us-ascii?Q?xm2inOVhb8M3lFVVsc59lvqT2cmpk7kP0pSphRrilLC9+BHMp8yguPhFJ2Nf?=
 =?us-ascii?Q?3m4/+J8WmO/YN5YsnuNLiZwoJr3UgYmN+yj0NwRtH/UT0fJGBhit7F40hpNe?=
 =?us-ascii?Q?z4otSO/0bQFaGjKHsb4G89WJ3CH431sbmQCEGD+0M49tIJj7S7jXkV6rIW3Y?=
 =?us-ascii?Q?lwoNc8M3cv3PLv63zuRq+jna8L8j27Ay3vYsLn7+PPiE47ET2839fX38yRni?=
 =?us-ascii?Q?CCGZzYNRK1EEQtQNtkuEu6OQIeDLZREA+MCkU0ZUlEGaN1Fzcz3AqIsFaqcf?=
 =?us-ascii?Q?n0eI7XHj4aj2q8IafAWgVkxXRX8TjLixS9hGyFmjBPAg4l82Sy8bMLiTi8Iv?=
 =?us-ascii?Q?CkIZwAZustbupM9+9nmi324ySWw7DhY2e7yGzWa1632Skp6mpdPr7o8zmICd?=
 =?us-ascii?Q?j+auOYlnGi/aoNLJeJuWq+ufsyfwpeyw3sKe6ly968//FwZD6BXAb5viaR9i?=
 =?us-ascii?Q?xzn/+yC4rMsK1o88SmBpTD0bHjCEPiHmiTzwYRA1bHyz4B+aWKS0qa/izlEP?=
 =?us-ascii?Q?GPS0MaROvY8qeB8JlLcsUc/V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309f5646-bab4-4334-4150-08d9367c0915
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:21:00.7387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lg5ITha2NCu3wBFkfG1jcShNw2BN5drRy0QckGu/LbS6Rbi74KtTlCjfamwSMinaIS8U0dm7hI9IRGJm00KfVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0211
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move code that gets the CS Fabric ID into a separate helper function.
This will be expanded for future DF versions.

The bitfield used for this value may be larger than the 8 bits currently
used. So make it a u16 type which is large enough to hold all known
sizes of this bitfield across DF versions.

Also, call this function early as future DF versions may need the value
early.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-22-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.
* Added function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index d09a17747abd..f5ac3b63376d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1093,6 +1093,7 @@ struct addr_ctx {
 	u32 reg_dram_offset;
 	u32 reg_base_addr;
 	u32 reg_limit_addr;
+	u16 cs_fabric_id;
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
@@ -1109,6 +1110,7 @@ struct addr_ctx {
 struct data_fabric_ops {
 	u64 (*get_hi_addr_offset)(struct addr_ctx *ctx);
 	int (*get_intlv_mode)(struct addr_ctx *ctx);
+	int (*get_cs_fabric_id)(struct addr_ctx *ctx);
 	void (*get_intlv_num_dies)(struct addr_ctx *ctx);
 	void (*get_intlv_num_sockets)(struct addr_ctx *ctx);
 };
@@ -1192,11 +1194,24 @@ static void get_intlv_num_sockets_df2(struct addr_ctx *ctx)
 	ctx->intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
 }
 
+static int get_cs_fabric_id_df2(struct addr_ctx *ctx)
+{
+	u32 tmp;
+
+	if (amd_df_indirect_read(ctx->nid, df_regs[FAB_BLK_INST_INFO_3], ctx->inst_id, &tmp))
+		return -EINVAL;
+
+	ctx->cs_fabric_id = (tmp >> 8) & 0xFF;
+
+	return 0;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	&get_hi_addr_offset_df2,
 	.get_intlv_mode			=	&get_intlv_mode_df2,
 	.get_intlv_num_dies		=	&get_intlv_num_dies_df2,
 	.get_intlv_num_sockets		=	&get_intlv_num_sockets_df2,
+	.get_cs_fabric_id		=	&get_cs_fabric_id_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1296,20 +1311,16 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 static int calculate_cs_id(struct addr_ctx *ctx)
 {
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 die_id_bit, sock_id_bit, cs_fabric_id, cs_mask = 0;
+	u8 die_id_bit, sock_id_bit, cs_mask = 0;
 	u32 tmp;
 
-	if (amd_df_indirect_read(ctx->nid, df_regs[FAB_BLK_INST_INFO_3], ctx->inst_id, &tmp))
-		return -EINVAL;
-
-	cs_fabric_id = (tmp >> 8) & 0xFF;
 	die_id_bit   = 0;
 
 	/* If interleaved over more than 1 channel: */
 	if (ctx->intlv_num_chan) {
 		die_id_bit = ctx->intlv_num_chan;
 		cs_mask	   = (1 << die_id_bit) - 1;
-		ctx->cs_id = cs_fabric_id & cs_mask;
+		ctx->cs_id = ctx->cs_fabric_id & cs_mask;
 	}
 
 	sock_id_bit = die_id_bit;
@@ -1324,7 +1335,7 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 		die_id_shift = (tmp >> 24) & 0xF;
 		die_id_mask  = (tmp >> 8) & 0xFF;
 
-		ctx->cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+		ctx->cs_id |= ((ctx->cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
 	}
 
 	/* If interleaved over more than 1 socket: */
@@ -1332,7 +1343,8 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 		socket_id_shift	= (tmp >> 28) & 0xF;
 		socket_id_mask	= (tmp >> 16) & 0xFF;
 
-		ctx->cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
+		ctx->cs_id |= ((ctx->cs_fabric_id & socket_id_mask)
+				>> socket_id_shift) << sock_id_bit;
 	}
 
 	return 0;
@@ -1411,6 +1423,9 @@ static int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 umc)
 	if (set_df_ops(&ctx))
 		return -EINVAL;
 
+	if (df_ops->get_cs_fabric_id(&ctx))
+		return -EINVAL;
+
 	if (remove_dram_offset(&ctx))
 		return -EINVAL;
 
-- 
2.25.1

