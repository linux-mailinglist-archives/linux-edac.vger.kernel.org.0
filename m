Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E6C376A6B
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhEGTEn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:04:43 -0400
Received: from mail-eopbgr770081.outbound.protection.outlook.com ([40.107.77.81]:44439
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229670AbhEGTEZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:04:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc+/jHYP/zRUJXX20YTI8xzauaTwAjaJq0jS347PZGzmTszU03rqIPGy1Mv+UEsTRcF+HGqpDdZnPpYbaelsRe/eiknQYBXncx6IU2vn1JhKb1jF5hWGDYSdiFMIjfcs/C3YY7yIZV9zN2rAz4rdF9YadiHljOeegx+Unfqeo+kPLXc4xPy1V7GD5Ig9M1FT87PY8rDPE9wXZqhtPmVh71Q9a7xFUg8b+nJ1yJ3nEcsl80QqeopWAzsMgJvYmKjgQgogX/RUc/n+C3KD7islrf0kkUCgLtT0pnRznHJtxhek4a6qGFVwKuT0Rw9SwKYxJEguow5Qt8ZykiSJTcFLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV3PNOoTlKkA+rjwbCXyznFMWc4esXOeA69SQUo1Ht4=;
 b=GGVkIEIQe8OLr1+oy/5uYWNk6KaGcNFuwn69nhhQBYdX1nn8cvKyOsGY0LT/ZloM7wLA9/lr2vb38/GxqUbfHvkLOJkiqZfN6kqMiVMktlnz3jBPTvvKK5od9WUHMwHJLiMkjvhOsGyKP5VrnNuhzkeXxAIc9K6tCN9sN0bG3/QAGYWFqCw0DntZu8huFIro/E61vGFA7eJoHXMkjKdFg3EuW8AXoL1LiW0CWKpSVhv4c+FyuPUXUbQlbYNXJ9Iw4jqXtbzKi/mKiqlAGYzsDKXFgu0LKO7eis+7yk+dyKpDs4ghcrtIE709dyLAZNryg0JMtDP9Op6NWbv/iyVAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV3PNOoTlKkA+rjwbCXyznFMWc4esXOeA69SQUo1Ht4=;
 b=2eTSBZvXsoXXgkg0c+4BZEOBX4sG/dF9nEDQHmYMUKvZ981LOMLfJ/UucQj8vTAJL2QWAA2IF/LL+pVWSs1e8s3chdQ+TR7sfeVIvJBaie6lSXLdTTrSth9QnvPVSH46a8oBLc9tCvZ3oyvqMJtcOfZ5keThVqjvY7nb61+Y8sk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 19:02:16 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:16 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 22/25] x86/MCE/AMD: Define function to find shift and mask values
Date:   Fri,  7 May 2021 15:01:37 -0400
Message-Id: <20210507190140.18854-23-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 616b161e-84d5-43ab-cd82-08d9118aa161
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1620715A27E86CBEDE866179F8579@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRBI+7fnrJhBlMHRIcDUUy6HE2mAxOrQ5gWVvQoczxpimpV+jh13ak3tyDfJQbQBpOupoyVnCl0DBIswXwaV0xdUpCnvoxxVi28QITJ/ceo0hllGBzZKnWakQwh80y5yEMBqVNj+nbsxsV1s0grhHfjvNOgQogVJ4qam2DcYDOZQjE5/ceQDv4D5v8fPXY4WGAzYJIePggLfHMbz1sKC0HMz0bsypaggUbEditll5r4TXRQM8WoOab6R+EtxQDbyjzXdCeOheT7FHLDx5eDZVKUx3j1ToJ5NSerAn9JPsBzbHE1C4509VheWIT84+FOg5Ppum6jES7/dDQMEaQd2pYZGDGpnaVZpTAgA1MjcnGSt53F/TqWeRwoj+MFzsB2P15P43K7iIZUeMkyFq7WwsiTWFsRpDeWHcnIaLpBfm1sVHlx2ApsSXB8fQRDw1CW2EFFSnVdfefHTLsC0mzsH7ta3/r1mgkvE/C3chqQ/HG+1n1FIQTiNLUMNIwyOIXg1FK8siGi6V04UQbYusPGtmpMPUXD1CBe506T3NYaLsOUCQjFwqpVJyVwUGItPrn1XLl1ajMqfZV4Z2eA3Cd/U4QXAp53OhoeyjCL4byA3GhEF4f4Q2nEGqrw7GQkr8dr4Z65Vq4UZcWAnVmDbHETdCANs4Ujg568fKdAzxqKmC0VFzMSgJt2mxsFtEefWg6ww
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(4326008)(6666004)(38350700002)(38100700002)(66556008)(2906002)(26005)(6486002)(66476007)(1076003)(16526019)(86362001)(6916009)(66946007)(2616005)(956004)(186003)(5660300002)(36756003)(478600001)(316002)(52116002)(7696005)(8676002)(83380400001)(8936002)(37363001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?R3Ozrm4lNYUAM/Q+g/3uuUmHA66Lh/4umQbfsyiDN7YhgzZgrwEuvn91ZjBK?=
 =?us-ascii?Q?jBfdJqkgmA4rEMWgtn6Ef2JzHQQ0V7LbN/Z3xFYiLZXjRPwZSVUuJiUb35/8?=
 =?us-ascii?Q?+dZvi23AR9xVgvxyWPP7lyzuo1Z+NloIntb96Gh48w6ajBov7ogRiFsxR/CX?=
 =?us-ascii?Q?k3y54xfyfVTtS2nJmCWHi2xFmRVBpKQ5jKxE3dZ4RyX/WUZGh5w/DJSEFmv5?=
 =?us-ascii?Q?mJvXVV+1h6g9cU5KfwLxaMT4BmjwQOb+VoPgHGen6EgSR9Znc/3/ytnY4fwq?=
 =?us-ascii?Q?tZlkhx+4pTDlW0Y4NIeUrMyBcR5wTfGlJ3wtws6xu7QXMSASE4Xt+RR8lF7i?=
 =?us-ascii?Q?K/I5A1EuE1/2v52tO3cpismRh9ZCL6EEe1dclnv8oXDXm/iuwBu6f38ceGEn?=
 =?us-ascii?Q?LcpaRfqjxBhH86P/4ixRQbqUilsCOXZRiRukSUpqMBTaOIOnfu0uGRn0nSM1?=
 =?us-ascii?Q?rai8YDE5jZ0m6MBSdB/6zzFh6w39vveROhKH1apjYAne1c9OMIRPZPgYfInr?=
 =?us-ascii?Q?GiSXznK9wDno3QJctridhxDv4gShHe8+xV8bU55WGcAc8EojwgwMhk6Bq28f?=
 =?us-ascii?Q?5uCSH1iQphSPL6nKiKn7HHZxPZ6QragZRzctA2LIEOqwtw+urjDWYjomafey?=
 =?us-ascii?Q?rEBPW7jPuIxTwQNP4vBREPhsv9ZLdRA5Q2DOa7CsA46Zr1d44QfgDsKOywO4?=
 =?us-ascii?Q?vyX6ktGIdCfX3PKAjRku394CdX57j66WfEZ74ohJswzEDBqv40YbwTJikJzP?=
 =?us-ascii?Q?N+WjCDJ37CLbbrB+tR5gsVct7kTjswZ69mzOI1/1KuHKnC2kFCjZ2iUohzMx?=
 =?us-ascii?Q?KA1vWbWEvRxkN6GPe9x/zOkz4yxWN4pAET7ZDpHhlhr0TeGFBB/KJAc0pMX1?=
 =?us-ascii?Q?9knWZNOLDgWsPk1XBAOrJ8MjHsaGQ6l2S2GrljmkDJsc1NQJrx+0zlPGEDIs?=
 =?us-ascii?Q?ExdMH0rZkN37N2ujkXLpVP5ievjqfzrG5C4IZ9OT8hBjlq9hPNDybXYI7ORi?=
 =?us-ascii?Q?awxMF7BeBOis346OpIO0WAXxJtoJdQQQhc/2c/8PdfCYlfNvtzOJiJWQcBz6?=
 =?us-ascii?Q?o9zNYCxw3VBkU8DbDr69TMolarIg4jHjXpd8BbnKgrQJSiiYTxKdm3GeimTB?=
 =?us-ascii?Q?mlLhq8dWkhElUhmEtOLcpc83rGmleclKZxLfoVy6jrCzO8WGUSloH6sLay7/?=
 =?us-ascii?Q?Mt0Ey1/F0n6ufZ4DwL/HM2HuTniG5Gxc11bVMs/HlqF82XxV8LgS2sPmmQyu?=
 =?us-ascii?Q?x9FiUtssuQeH/v4D2p6d+Rb3GI880qqoBAbHy8pxuw2Lhs/vCd1iauRnEI3I?=
 =?us-ascii?Q?63IltUdOvWFMdF/57be7nk8D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616b161e-84d5-43ab-cd82-08d9118aa161
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:16.2564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXyBJQGAsDRwzIdZ4ttdVxxqy3XDub3BBmiPAJ5lWnZOkyakJOHGBuB2s/6wbwubFnFWP298zdbOWO7AzzqOjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Move code to find the shift and mask values used in die and socket
interleaving into separate helper functions. These will be expanded for
future DF versions.

Also, move reading of the System Fabric ID Mask register into a helper
function and call this early. This will be expanded for future DF
versions and will be used to determine DF version levels.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 56 +++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6980c5c62f49..01931f98c6d9 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -725,6 +725,7 @@ struct addr_ctx {
 	u32 reg_dram_offset;
 	u32 reg_base_addr;
 	u32 reg_limit_addr;
+	u32 reg_fab_id_mask0;
 	u16 nid;
 	u8 umc;
 	u8 map_num;
@@ -734,6 +735,8 @@ struct addr_ctx {
 	u8 intlv_num_sockets;
 	u8 cs_id;
 	u8 cs_fabric_id;
+	u8 die_id_mask;
+	u8 socket_id_mask;
 	bool hash_enabled;
 };
 
@@ -905,15 +908,31 @@ static int get_cs_fabric_id(struct addr_ctx *ctx)
 	return 0;
 }
 
+static void get_masks(struct addr_ctx *ctx)
+{
+	ctx->die_id_mask    = (ctx->reg_fab_id_mask0 >> 8) & 0xFF;
+	ctx->socket_id_mask = (ctx->reg_fab_id_mask0 >> 16) & 0xFF;
+}
+
+static u8 get_die_id_shift(struct addr_ctx *ctx)
+{
+	return (ctx->reg_fab_id_mask0 >> 24) & 0xF;
+}
+
+static u8 get_socket_id_shift(struct addr_ctx *ctx)
+{
+	return (ctx->reg_fab_id_mask0 >> 28) & 0xF;
+}
+
 static int calculate_cs_id(struct addr_ctx *ctx)
 {
-	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
 	u8 die_id_bit, sock_id_bit, cs_mask = 0;
-	u32 tmp;
 
 	if (get_cs_fabric_id(ctx))
 		return -EINVAL;
 
+	get_masks(ctx);
+
 	die_id_bit   = 0;
 
 	/* If interleaved over more than 1 channel: */
@@ -923,27 +942,26 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 		ctx->cs_id = ctx->cs_fabric_id & cs_mask;
 	}
 
-	sock_id_bit = die_id_bit;
+	/* Return early if no die interleaving and no socket interleaving. */
+	if (!(ctx->intlv_num_dies || ctx->intlv_num_sockets))
+		return 0;
 
-	if (ctx->intlv_num_dies || ctx->intlv_num_sockets)
-		if (amd_df_indirect_read(ctx->nid, df_regs[SYS_FAB_ID_MASK], ctx->umc, &tmp))
-			return -EINVAL;
+	sock_id_bit = die_id_bit;
 
 	/* If interleaved over more than 1 die: */
 	if (ctx->intlv_num_dies) {
-		sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
-		die_id_shift = (tmp >> 24) & 0xF;
-		die_id_mask  = (tmp >> 8) & 0xFF;
+		u8 die_id_shift = get_die_id_shift(ctx);
 
-		ctx->cs_id |= ((ctx->cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+		sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
+		ctx->cs_id |= ((ctx->cs_fabric_id & ctx->die_id_mask)
+				>> die_id_shift) << die_id_bit;
 	}
 
 	/* If interleaved over more than 1 socket: */
 	if (ctx->intlv_num_sockets) {
-		socket_id_shift	= (tmp >> 28) & 0xF;
-		socket_id_mask	= (tmp >> 16) & 0xFF;
+		u8 socket_id_shift = get_socket_id_shift(ctx);
 
-		ctx->cs_id |= ((ctx->cs_fabric_id & socket_id_mask)
+		ctx->cs_id |= ((ctx->cs_fabric_id & ctx->socket_id_mask)
 				>> socket_id_shift) << sock_id_bit;
 	}
 
@@ -1037,6 +1055,15 @@ static int addr_over_limit(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int get_fabric_id_mask_reg(struct addr_ctx *ctx)
+{
+	if (amd_df_indirect_read(ctx->nid, df_regs[SYS_FAB_ID_MASK],
+				 ctx->umc, &ctx->reg_fab_id_mask0))
+		return -EINVAL;
+
+	return 0;
+}
+
 int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 umc)
 {
 	struct addr_ctx ctx;
@@ -1049,6 +1076,9 @@ int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 umc)
 	ctx.nid = nid;
 	ctx.umc = umc;
 
+	if (get_fabric_id_mask_reg(&ctx))
+		return -EINVAL;
+
 	ctx.df_type = get_df_type(&ctx);
 
 	if (remove_dram_offset(&ctx))
-- 
2.25.1

