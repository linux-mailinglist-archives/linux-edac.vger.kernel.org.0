Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4AC43E7C1
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhJ1SB3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:29 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:9152
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231411AbhJ1SA5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOrwYOHX8YMeH7zNP3Uai0Lyj5m0uZ/doPcHMxjTOXCLHfl2S0GmvrbwEegvH2JVs2v31vM5WnD0KkvwpNq2RH///oa8gJH47i9XbeS+Yg+Lu+iCMIRIXVXfr4FagV7fal9WVN3ustZCl9v1yrx+9hrZAw+VGmfJQ0gAVH+Cqg0OZmTh77trHXFr5EYaGL9NpriFay7duzLRTxnpNsjaPhjvJ8jsI15ol1Adg7s2IpJ/Pmh2tqR3knsnyx6WAXIGNZFMo8Vld2r8h81zazWjNZmXk4nLrKe/DvVUBawUpJ3UAD7upA+a1SNagmg6ratnzLehxIFgVWSRpXnAYBUm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INzA+Y2CtainXCWNEkHjHyx6Kpr9J39qxKxx/E3nSkE=;
 b=Cozel7nQA3IA1QFVJMSDUYQB/JX4O9IUkVG/rF7m9wtp0tu9acE7g2NS3VY+r9+q1L3tKSF3slnowgJOUhQnlgZlCbEN8ytPkg39rqPbJqnDBgMprj6xqpMlgDprgUf4natdqM7WIRzYvhL9Sl49bm1x6i58qJvzqwEZG877IPTmJHDidO37YnfcTkO+343zvWZFMOriSupQ8swWNz9lYwjsikxysGP8JZSTX4ykvC4A7sN2BPAxM5byIzS6qXaE4yXIUHkH0GYPkx5rg/REeh4S2WXsxk9vKl98VE1P9fii214F+B2Ha0T7tWmyFE0+0EDzTmk03q8Un4MS5SVLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INzA+Y2CtainXCWNEkHjHyx6Kpr9J39qxKxx/E3nSkE=;
 b=GZvzW6WWHZzeZ+UZSEslG4qQ9kQ/khvqMpzONMuUj6ppUce2BdTTTGjcvYZif/h3PavlF0PsF/9/KqK1T6bBheTfKeajv/iuRpDn6OOK8WyupBEWFt/PN8tJPbHYAzl1FOzTugpycKXzwpLofNWLRV1ULJjMTf3+IS2T4hYrJtg=
Received: from CO1PR15CA0102.namprd15.prod.outlook.com (2603:10b6:101:21::22)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 17:58:28 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::8d) by CO1PR15CA0102.outlook.office365.com
 (2603:10b6:101:21::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:27 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:25 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 18/33] EDAC/amd64: Define function to get number of interleaved dies
Date:   Thu, 28 Oct 2021 17:57:13 +0000
Message-ID: <20211028175728.121452-19-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8c72540c-566e-46fa-17b9-08d99a3c8b67
X-MS-TrafficTypeDiagnostic: DM6PR12MB4450:
X-Microsoft-Antispam-PRVS: <DM6PR12MB445015B4317485D215D4E8C4F8869@DM6PR12MB4450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocT73gUS6phm+XOOecTupEP3+Ik3WtcVnuVDNaSKyijF81hcUM9CxfGZCcTfwt94KjN+wu+VdXzd32HbDjN5rBqkgkXcZ1SH+udDwH+jnrIA92c2yy3lOnUGPE80H4SMywVUggyABfz6rWl0MVwYHwbXFs/MR4uVaxV8Od3JaUKUM1rmkXw8lz/Uvz4ESOoE7wrGgMTPk/awCAgDQQ99odKkWqPepbL+2Q9duJB1RzmIiSpzkFoRj5tnaivjG4maBbEnbaHWZ0UmnS/xeEhHZzTNF4laLC9dOLy7zAnToXWlvUWkbrdq4VnkxnUS/a5yFv7mw1vFGeauxtduLLRm8+Ch3oYWFEZnwNS3t2HpLPAvrtJjJ+TmeN7MqJcnBqvs/Q7EEyXVy5472LH09PNzURTLnGTUI1Zog/TKhFGewF1FKegMMW5Qhd1rdlB/BEEJwM1ayo/g3OaNV4RlYcUTKKeHIBQFXp6ZglihGJEj2Ln8i3s8w16VQQjlh2NPCx7McNVU3mYJ3IJJUFb+jwUNDYiJjIanPTqxDJgTVVsgC8ZGAVjr00XtdmZxO1jNU99OEvZykE4rLgZkPJOQgcSZdqPgYv12Y99HP4bAN+1hs1MTT79JLsCFE7324+N1Boy3D61qTp6ELZ8luBcc7WVxQv1vrMbPL8rdlrrVikQjeJE/sBzjFMgGLX0xeGNHc40SO/gMB54toND7p4VBwRTwILzpUK/Ro5S5k0P1TsnWtO/vLrHpUtWlHWGheMLwNuQ+azysLKRNqJw/9WHD+aloZQnvtpeDPZb2gjwHZ16Ac/NJXMOXHh+bCLG/JCrvJVZ0
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(1076003)(8936002)(81166007)(82310400003)(2906002)(6666004)(16526019)(4326008)(36756003)(26005)(316002)(5660300002)(186003)(356005)(54906003)(508600001)(36860700001)(47076005)(83380400001)(8676002)(966005)(2616005)(44832011)(7696005)(6916009)(86362001)(426003)(70586007)(70206006)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:27.5571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c72540c-566e-46fa-17b9-08d99a3c8b67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move parsing of the number of interleaved dies to a separate helper
function. This will be expanded for future DF versions. Also, drop an
unneeded assert to match the reference code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-20-yazen.ghannam@amd.com

v2->v3:
* Was patch 19 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.
* Add new function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 11a54e7a0432..e76aa8ee906a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1069,6 +1069,7 @@ struct addr_ctx {
 	u8 map_num;
 	u8 intlv_addr_bit;
 	u8 intlv_num_chan;
+	u8 intlv_num_dies;
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 };
@@ -1076,6 +1077,7 @@ struct addr_ctx {
 struct data_fabric_ops {
 	u64	(*get_hi_addr_offset)		(struct addr_ctx *ctx);
 	int	(*get_intlv_mode)		(struct addr_ctx *ctx);
+	void	(*get_intlv_num_dies)		(struct addr_ctx *ctx);
 };
 
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
@@ -1116,9 +1118,15 @@ static int get_intlv_mode_df2(struct addr_ctx *ctx)
 	return 0;
 }
 
+static void get_intlv_num_dies_df2(struct addr_ctx *ctx)
+{
+	ctx->intlv_num_dies  = (ctx->reg_limit_addr >> 10) & 0x3;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	get_hi_addr_offset_df2,
 	.get_intlv_mode			=	get_intlv_mode_df2,
+	.get_intlv_num_dies		=	get_intlv_num_dies_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1208,7 +1216,7 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 static int denormalize_addr(struct addr_ctx *ctx)
 {
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_dies, intlv_num_sockets;
+	u8 intlv_num_sockets;
 	u8 num_intlv_bits, cs_mask = 0;
 
 	/* Return early if no interleaving. */
@@ -1219,19 +1227,12 @@ static int denormalize_addr(struct addr_ctx *ctx)
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
@@ -1269,13 +1270,13 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		sock_id_bit = die_id_bit;
 
 		/* Read D18F1x208 (SystemFabricIdMask). */
-		if (intlv_num_dies || intlv_num_sockets)
+		if (ctx->intlv_num_dies || intlv_num_sockets)
 			if (df_indirect_read_broadcast(ctx->nid, 1, 0x208, &ctx->tmp))
 				return -EINVAL;
 
 		/* If interleaved over more than 1 die. */
-		if (intlv_num_dies) {
-			sock_id_bit  = die_id_bit + intlv_num_dies;
+		if (ctx->intlv_num_dies) {
+			sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
 			die_id_shift = (ctx->tmp >> 24) & 0xF;
 			die_id_mask  = (ctx->tmp >> 8) & 0xFF;
 
-- 
2.25.1

