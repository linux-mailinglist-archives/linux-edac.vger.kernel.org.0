Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AEB3B2119
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFWTYN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:24:13 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:24416
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231138AbhFWTXo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhadB/maPkvhJ9gHKnhwszKgNEGCNKfZxp6O82awL2S7NPr3JQnEMrzLoTgZWOAn+9HtkymujBxLiJGYgnMt4nSYPRTv9313twWihI4JDow6iljz+m3INDpjxXqQ4s+arUpa+FeB1E8UojxfVd1R+aiK3p/ToSN/mP13J0XfEmUVK4nivBNiuC4ND4p+onZMFMTlbQNAnwom/eV5qJAU6Z788d3BqOrD5Jpzg5sBlygH0akZjYxPzczyLj6gmdDRGHS0CE1qdtpk6MgKbL+F9FlkVD9APpooireWKEqiYYrp34ndhl65rlkKaiaUH0MHdcwXqPhcNmyVpcFo0+DjRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWxulKQ5I8HHxDjlYnoVRTwGuqpTzL+Zrgb52kaj708=;
 b=DZ0u/D+oLeODUGv5mkLo1FgWxeudMzlt9AtDp3sH0UVQQGaKG+A/vM+QYON+s11Y68xmDS5fe1dOBph+PipgrO+U2k53JjHD+tkTeQfHAXQ5xjJ2yMqz80oKe4oOi8+lvdpwEcXR7HP42OdZZffBF/hjeTIEPX6FRz8EwPqKcSPf+0ZbYha1NBuh7oTeUPLyIYNWzPa5TjsuRgcLE9dwmjCu9Nn7de55axkg36zcynhbLXesLpzrzoyncPdRqgUMnV8dG1K9DKacbsVbsGMNQGT8kfJx+MBSdwRw80uVrLEz+5XpNVDhUhMQKAe+NcI6yYcqICykkTWkYMNGjQbhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWxulKQ5I8HHxDjlYnoVRTwGuqpTzL+Zrgb52kaj708=;
 b=bc2E2qSKRLmEVpCdHPjirLMmAnERqQ2IYz2Xr+u9TGYfSmWdQvS9Fz5eMV/tGdNJdGPs3m2hrrdnUjMEIiAZCFyfcAhUj1HrDftU2xXDGHQDnVAdgAcmHh4XUO6PsxuFMzzkRBTWfZYmTCiTHdMNsSV9NoCDjnU4GcU6grOfqbQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3218.namprd12.prod.outlook.com (2603:10b6:408:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 19:21:02 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:21:02 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 27/31] EDAC/amd64: Update CS ID calculation to match reference code
Date:   Wed, 23 Jun 2021 19:19:58 +0000
Message-Id: <20210623192002.3671647-28-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 39e9ecbb-3571-42c5-6fe5-08d9367c0a17
X-MS-TrafficTypeDiagnostic: BN8PR12MB3218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3218BDAF0AC8CFEC93864AB9F8089@BN8PR12MB3218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAh6GoW+JZkyO7Mtdy06U8HWfKa9wYpeH6z4/ImTV43qOCgmY68q+Kwx3Ko4xagZYNdGnV9Bif+GuGI6XsJlhuDg5jhWV0lW9M19Zb090ml3W+J/Yz1utVQQra9ROWFVast0Dr282aUsE89ATaZM2lUpECK+6Q+hdd9gswNCpfLFBTUtegso3fF/Imy97niOVB0EkC0XTt1TZyLs/fuGXlmpdQoYAOaL+ybQU8OOG5hOt0SnerN0w0DpKhFmxYjWmxcQ/rG36nRvJsx1wDW8elmCdgDKO6Yz3tR0tR6ZQZN/Wkw76ytUfZbkWYETjjNrYvX6gky+PTWJOrWjBAj0en2Nxlzz4UkfEKNKpRfb6dvTs8kKzJBDTb0j+Vvo2wSdWOwddysgKwGc9gEEpAy2575Y/QolXffM8AuxEy3c5Tdx0T1G37hLfLapOxgIrjADXUHHZJ2AUSnaXikNEwSngSM5UqamvldAwSng3LfKkH3V6e6c1kkW+EhmbaQ9uiKPTj1P6xp9IDeTSS87n7bTjZM9ZCuJWp97KAv2k1ORAinnuY/riLy9XU0MU4BP1jpYm3wHPPDTh9EdWywZeJN4NXo60ADMNBHDpe/SXRdjHlcCoqdZzKEA/t8ycgPYesL+D4lhonG8lW7sko38EF0eiaplGsj3n7MG3NJGbMetN9U42k2DKC5mtxAdizAnF8WacKOZyVc4fiyDTyQHjLCK+WpYjipYV5J058WIdGn35YgBV9JJOnBga7jH3hivq4sBq3ma68C0zjidKyJKUIVlyGLqbUq5o/ArxTYGgDCKbjBMXsZlc2b1Ixcdpx78JJtJJQa8Tl9eh4j41nGfv+GgEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(316002)(6486002)(6666004)(26005)(16526019)(38100700002)(38350700002)(956004)(44832011)(2616005)(86362001)(2906002)(186003)(1076003)(6916009)(966005)(83380400001)(478600001)(66946007)(5660300002)(7696005)(8676002)(8936002)(36756003)(52116002)(4326008)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oRs/AIYbY3LnVhj7LiEPN9jMfhNspmWqNu4lgcYLEj0YL3aGnPn4rE7ecCxC?=
 =?us-ascii?Q?mYyXi+qMY4tfpMidamaB6S93DYtc99CuzjBE+U7a1HKFgvs0oFn6FQ5o4AxT?=
 =?us-ascii?Q?x0N8QehiEkMfKt/LeH9bIEOJDFY8+ufUzIAQj/d78af0KnV9vsAsOp7avWpk?=
 =?us-ascii?Q?48PTVy/fKFOHdwN011sN/RlpxmTQxaPWfTMT2MLPAKTcTOCDAQROqkP9KuEo?=
 =?us-ascii?Q?XgmURZdGnDMRArjzcF0PoPhYtqqbmjMnMMeKJFlKWVxFwdkFSIUylLu4vqZx?=
 =?us-ascii?Q?iMMSlLaQ4SFkC3wqO7QVJTJ1HLucpWZDFr7EB6w256fSgs8KxJPpgMG/52H+?=
 =?us-ascii?Q?mmDh2pt5W93wtRdaxmbpH1oWuaJ882mOnAaTgdOQece9ISAn1pAR8x4x9rWH?=
 =?us-ascii?Q?XWogGjeg86tcQiiHloCn13pMxW8dDzF8mt/+ziBqO6dd/cJNP8pUptmSh6lC?=
 =?us-ascii?Q?zM9pRsUyO8OsY0qCSkPTakFAT+sgwjCGPC5EVFdsQQN/P1JnJfSIEoRM9Qg+?=
 =?us-ascii?Q?e5JgMwqVe02IHw15fqlliKCVIzvlcy+w2Ub1UxYCgzlRUuVv/IgVt+Bulr5y?=
 =?us-ascii?Q?nhrFEVBMx2D5HK6K07ME5sJGn+dzrbSdB2xLWcTBO0LpjxNJAD85HUHn+0pM?=
 =?us-ascii?Q?J+52qHVv8UYDRMYAN9DsR75/Gx66vjNOQZMFSlNkHAPTwdqoR6sFj2rVaiT7?=
 =?us-ascii?Q?Xypk1s4j8gt7d0/7lvQrak9UKnBrABLDP8FCkzZHOJfdqtZ7f8Vo4+yXLXN+?=
 =?us-ascii?Q?NqX82r5MDpcBSEQLzclwNlOTKaiMIKfxIaiBMUCqsY4OrJBQvxqUCD5noYu2?=
 =?us-ascii?Q?sRXvJhI60zQlzUuS8JpKKy1Km9LmTq4dJncrUxcD5pPVGneCE3dF++SuPaYV?=
 =?us-ascii?Q?82RO9QugInJB2gXNAFQLJJCDQ724px2tPRTx17PO3U4XWJNKV3aVg+6GMn5H?=
 =?us-ascii?Q?PcM75XEDldCfMzYVmz02/ubLaLKJXsz0Tn5f4+Y1zE4zAZMrgb2n1bVICyI5?=
 =?us-ascii?Q?7F9l2d/Tcxp771DX9BmwdPIKRoL0bqcVnTlQkOjVWUlEqI8HkRK2q7+bemXa?=
 =?us-ascii?Q?EeS3se6l2GZFfpTd/+IBZfXnt716erc/NW9hrFWYdqsgbIQTEu8UaTC6qLyf?=
 =?us-ascii?Q?xEqlctuA8G5yi5b/rNeDsHavjVVCNdgV/hBIPSfz8Sz9nj//ngV7Lvxo8o1s?=
 =?us-ascii?Q?2YWxlT4jOdXCM05qgptUcKYvCK4tgUt/LKn2oQktv2nXj6aYIzaAnWjzwyXX?=
 =?us-ascii?Q?yIIJpYqH+UDv8MYVb07K4CHtyPXqzaIlqYz23ppfuuhjs+NU0S2H3IQmSUst?=
 =?us-ascii?Q?TUIYflyffHONNbUWLDT75FjP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e9ecbb-3571-42c5-6fe5-08d9367c0a17
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:21:02.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gl741UvEGJlJNTjMdyvMNYwCa5lMtyojQ7abkWhVDPzmFh5JQdQJE75dyrD3Rnbe3bnD9T5N4WcU/AcONYburg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3218
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Redo the current CS ID calculations to match the reference code. Helper
functions are introduced that will be expanded for future DF versions.

Use u16 type for dst_fabric_id and component_id_mask values to
accommodate larger bitfields in future DF versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-24-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.
* Added functions to data_fabric_ops.

 drivers/edac/amd64_edac.c | 52 ++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fa8046e2b055..fc2cd288df0f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1112,6 +1112,8 @@ struct addr_ctx {
 
 struct data_fabric_ops {
 	u64 (*get_hi_addr_offset)(struct addr_ctx *ctx);
+	u16 (*get_dst_fabric_id)(struct addr_ctx *ctx);
+	u16 (*get_component_id_mask)(struct addr_ctx *ctx);
 	u8 (*get_die_id_shift)(struct addr_ctx *ctx);
 	u8 (*get_socket_id_shift)(struct addr_ctx *ctx);
 	int (*get_intlv_mode)(struct addr_ctx *ctx);
@@ -1230,6 +1232,16 @@ static u8 get_socket_id_shift_df2(struct addr_ctx *ctx)
 	return (ctx->reg_fab_id_mask0 >> 28) & 0xF;
 }
 
+static u16 get_dst_fabric_id_df2(struct addr_ctx *ctx)
+{
+	return ctx->reg_limit_addr & 0xFF;
+}
+
+static u16 get_component_id_mask_df2(struct addr_ctx *ctx)
+{
+	return (~(ctx->socket_id_mask | ctx->die_id_mask)) & 0xFF;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	&get_hi_addr_offset_df2,
 	.get_intlv_mode			=	&get_intlv_mode_df2,
@@ -1239,6 +1251,8 @@ struct data_fabric_ops df2_ops = {
 	.get_masks			=	&get_masks_df2,
 	.get_die_id_shift		=	&get_die_id_shift_df2,
 	.get_socket_id_shift		=	&get_socket_id_shift_df2,
+	.get_dst_fabric_id		=	&get_dst_fabric_id_df2,
+	.get_component_id_mask		=	&get_component_id_mask_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1339,38 +1353,42 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 	}
 }
 
-static int calculate_cs_id(struct addr_ctx *ctx)
+static u8 calc_level_bits(u8 id, u8 level_mask, u8 shift, u8 mask, u8 num_bits)
 {
-	u8 die_id_bit = 0, sock_id_bit, cs_mask = 0;
+	return (((id & level_mask) >> shift) & mask) << num_bits;
+}
 
-	/* If interleaved over more than 1 channel: */
-	if (ctx->intlv_num_chan) {
-		die_id_bit = ctx->intlv_num_chan;
-		cs_mask	   = (1 << die_id_bit) - 1;
-		ctx->cs_id = ctx->cs_fabric_id & cs_mask;
-	}
+static int calculate_cs_id(struct addr_ctx *ctx)
+{
+	u16 dst_fabric_id = df_ops->get_dst_fabric_id(ctx);
+	u16 mask, num_intlv_bits = ctx->intlv_num_chan;
 
-	/* Return early if no die interleaving and no socket interleaving. */
-	if (!(ctx->intlv_num_dies || ctx->intlv_num_sockets))
-		return 0;
+	mask = df_ops->get_component_id_mask(ctx);
+	ctx->cs_id = (ctx->cs_fabric_id & mask) - (dst_fabric_id & mask);
 
-	sock_id_bit = die_id_bit;
+	mask = (1 << num_intlv_bits) - 1;
+	ctx->cs_id &= mask;
 
 	/* If interleaved over more than 1 die: */
 	if (ctx->intlv_num_dies) {
 		u8 die_id_shift = df_ops->get_die_id_shift(ctx);
 
-		sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
-		ctx->cs_id |= ((ctx->cs_fabric_id & ctx->die_id_mask)
-				>> die_id_shift) << die_id_bit;
+		mask = (1 << ctx->intlv_num_dies) - 1;
+
+		ctx->cs_id |= calc_level_bits(ctx->cs_fabric_id, ctx->die_id_mask,
+					      die_id_shift, mask, num_intlv_bits);
+
+		num_intlv_bits += ctx->intlv_num_dies;
 	}
 
 	/* If interleaved over more than 1 socket: */
 	if (ctx->intlv_num_sockets) {
 		u8 socket_id_shift = df_ops->get_socket_id_shift(ctx);
 
-		ctx->cs_id |= ((ctx->cs_fabric_id & ctx->socket_id_mask)
-				>> socket_id_shift) << sock_id_bit;
+		mask = (1 << ctx->intlv_num_sockets) - 1;
+
+		ctx->cs_id |= calc_level_bits(ctx->cs_fabric_id, ctx->socket_id_mask,
+					      socket_id_shift, mask, num_intlv_bits);
 	}
 
 	return 0;
-- 
2.25.1

