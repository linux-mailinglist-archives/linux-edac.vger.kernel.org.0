Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FF643E7D4
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 20:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhJ1SCO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:02:14 -0400
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:22881
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231544AbhJ1SBK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwY1rwkDFTuz/QoLRovZDWy5pJqb0d+nku4aeyC1ouPVkIMkCWOu7gbS2xAnZhv8EbBocI6wsoOVRAYAwbIJqhk3pcQP4SfPX6CtFavYjISywQx8pKAcG0nd0n2Ji+EaXFVlgCSlv/ZhSFDgY7GIPxebjPaamYYj0EaZEeLvXb8nnDxq1eMKLZbQzAekN6yGy+qUnKrusYmiooWULB94lbQ5P/NTEQzCV1AZPHZRQBaa6YNrsy6VjsbVdAi3iIIKVsEBxvcfAWn3KAQg76uuqMYtap9VWJmDKY26ZqZLflZDENUXUWOlaiMq0j1ddhM26yf3gSxvhOXQ5R/p5rsY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZvjylsvEUHpXfLpYIHru+q7OiVMswPlNcrzjap9c10=;
 b=fIF1A8JKx+ek0FwsoHciJKGXy0Yso+BNsPm3TA+FSv1Xk23t40erV2FDxQBHmGHLHPig2Lt4ySXzv5LcojHKJIKQNk69PmVnwDr6BRUrhXx+X2TgprHNm+vpzAZbpBMZu3O73GoZd0YKO98CbVB0GN7mwwy9uPSvyGqWgvAK9k/do0g7Dk8XpGMIdfCoXEXRzGHNbegsDbf79jC5sE/XYwBunbc3a3ooT/0vedUl+JSA94Z2NP9orDSUHV28a7pe0u3Jc0Q6kWrTxVcdQCLSIwL8Vwf+4YDhIleaaYKRfbkU2eI6x0z8nsjFM8PQNnqmzNEatcsQBOOfRDKueVgTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZvjylsvEUHpXfLpYIHru+q7OiVMswPlNcrzjap9c10=;
 b=elZa6rLMAxP7GYjqVZbQ940/7jTVxVbduJ1wbug8wsjKIrk4ptsVD9EdH2RA9TNKuxDvuFKosCxsu8ox1tLgFeuSnNNaICPzErv/9FoKMneTmInTcxq7vLL1L4UW813Cgm1a1TJJObOuoD7bPtnM56Csu97BPBw8Sn/en/UbPLo=
Received: from MW2PR16CA0045.namprd16.prod.outlook.com (2603:10b6:907:1::22)
 by DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 17:58:41 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::e8) by MW2PR16CA0045.outlook.office365.com
 (2603:10b6:907:1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:40 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:38 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 26/33] EDAC/amd64: Update CS ID calculation to match reference code
Date:   Thu, 28 Oct 2021 17:57:21 +0000
Message-ID: <20211028175728.121452-27-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028175728.121452-1-yazen.ghannam@amd.com>
References: <20211028175728.121452-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 931eee8f-4f43-4494-8d7f-08d99a3c934c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5360:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5360A47072BE1FCD6B5C8434F8869@DM4PR12MB5360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAkK81mFUZAQClF/OVy2WocsGRKFSvN10Q6lja/jJnSIzF+irHM7E7Ws94Ep8/RxeXirsQ3pcSGMp9ZXAWeS7yQvbXGdZrQcM4u67pNXko0mawQ2LI4aMEov69wAeb6/+wMnC0VARSlApVBSnuFL0swkFqRnMogk+8UVVFa9VqMzxm81WR/nDGXqv4Vz5sabetS9yFsPtRL54ucjPIWQlK/L/MpA7hLSbyaiILMu3fowknkgr9KqVz+S7WrFthgxYBCfra+R/Jl7hS6AX9JrQrQjONYyxXaxqXzvejETN+P669gKMOHgN1DwGzoaK5znyWgcM/rX1wcR1eY69dcFLBZXIR+pRwZPxLKfMtaxk2/lSLHLprFz2t7tiee6u5ZPjFprz6Iv6Pb1xtjgkL+4PIRuQ9lF5AHrE9rBkSaupQnictEmAkjAoJGEiovqsH7axWWjvIeng6GhFonyQodtvWlFAejXYmqNKrtgAv8PHUWYzjMvexA+lMCFnrmo4g36acW2ZhlXvYPld2/pHKfnM0N8PT1NRQMy8i1Qu33Ir6memEuZmiQ0foLAJQh06l5G5Rfd/tFw2jkM2YMNPWddroZuAaPnN/f6y8TLZ1OHy6QFcSlnWJToD7bLyhQShLZrCjT50gRQmYHl9tLMHEC0aGCV18BZ+XOFLBU+MQp71y+d/hjGITR+2oDN3Efc/pXHL6Ni/i/WanYwWcGBJFVZppTFEEadLevlHTa/n/qvfWdAn9+DI72LjIcPD5chnmXTbCVXGC4gnkCy8PeolEU330rurxWeEEvCRQuEYw4COuGVKKvPqDt4W1NgReLhhMl6
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(83380400001)(5660300002)(1076003)(54906003)(336012)(6916009)(4326008)(82310400003)(36860700001)(26005)(81166007)(7696005)(6666004)(186003)(47076005)(16526019)(86362001)(356005)(70206006)(36756003)(44832011)(8676002)(2906002)(508600001)(70586007)(8936002)(316002)(966005)(2616005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:40.8029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931eee8f-4f43-4494-8d7f-08d99a3c934c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
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
https://lkml.kernel.org/r/20210623192002.3671647-28-yazen.ghannam@amd.com

v2->v3:
* Was patch 27 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.
* Added functions to data_fabric_ops.

 drivers/edac/amd64_edac.c | 52 ++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9312784b2b0f..9c74813c4128 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1083,6 +1083,8 @@ struct addr_ctx {
 
 struct data_fabric_ops {
 	u64	(*get_hi_addr_offset)		(struct addr_ctx *ctx);
+	u16	(*get_dst_fabric_id)		(struct addr_ctx *ctx);
+	u16	(*get_component_id_mask)	(struct addr_ctx *ctx);
 	u8	(*get_die_id_shift)		(struct addr_ctx *ctx);
 	u8	(*get_socket_id_shift)		(struct addr_ctx *ctx);
 	int	(*get_intlv_mode)		(struct addr_ctx *ctx);
@@ -1204,6 +1206,16 @@ static u8 get_socket_id_shift_df2(struct addr_ctx *ctx)
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
 	.get_hi_addr_offset		=	get_hi_addr_offset_df2,
 	.get_intlv_mode			=	get_intlv_mode_df2,
@@ -1213,6 +1225,8 @@ struct data_fabric_ops df2_ops = {
 	.get_masks			=	get_masks_df2,
 	.get_die_id_shift		=	get_die_id_shift_df2,
 	.get_socket_id_shift		=	get_socket_id_shift_df2,
+	.get_dst_fabric_id		=	get_dst_fabric_id_df2,
+	.get_component_id_mask		=	get_component_id_mask_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1299,38 +1313,42 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
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

