Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6DB43E7D2
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhJ1SCM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:02:12 -0400
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com ([40.107.93.47]:62351
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231530AbhJ1SBI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEGbbq3PWso2A/LiWBfrOhjc+DYeYdKxRhvb9PeI7mjlyFHEVGKyfWM0/jL8S0Ei0CX4g+9LuhkNt4SG6B9svkPjXi2xXglKi48r34e7LC2yNahEPLslXnfBQIDKL8a8lj0EyCgnIxziM8eGXKkQcskPcHJRH86CRA7qTw5bQo+EE9/qCb54zCg7o9n0UeT2Z9dpCzE18bjP4kJjL1zzRakeJnbbsHf9qS9O7aHee/aYAlWfZApJn62N9wBoxIsoFnGWC6Pv7oXiEOkNrSQcCX+A2vKi4W98xsi6XgHF8+ggahvkSbCABTCI02Jx1X6gv2wWvgHDVtrvhCZH+osLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4JRRPLRFoFj6dV1+dDLLLgqe8V9aPW2YYNhHMEPwr0=;
 b=WFHWPN1/6znBx2KL80/rxWoqvietYi4kGOFmKXbHvnViGGV0CGrugMcbAS5M6F1cCYJNGIBXvdSciDGCV/UpOK/Pchl3cSWcd6UpvDvTc5ruBy53GhfrGNeaiSO5kyTFGBAFX06/vmJ/ztf49DV1uAJlQRAZM8DIT2//2jGwifQMxWDLXpfDbmbiMlX08dHChzZtHCRFf46RJ1pgbYD/armj9Kj51yCsujIELL7T6GUeLXCLQq+dNwZwt7zt11U64TyB91ECMNCQKg08BKYm9DqSdIJQgNymZnIiv1ZzCkeNOPCRcknl6F+pJk2ZnFMrwJ9sdLXh5JhuBeYULJQoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4JRRPLRFoFj6dV1+dDLLLgqe8V9aPW2YYNhHMEPwr0=;
 b=jyIrvjucDWiK05mkXkQFQiDrYhiwoqZnY/+gP7esk51R8Kud2C24TPcJideTH88DEwXydojwoYRZRI4pmzPyhHGN0kevgZC36LYeLeegIAG4Q9ueuqhMjTCiEo9L4uMetuLFoomhyYSnWZ+dBb/mKaPtQSu/HHNEejTX1OEkm9M=
Received: from MW2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:907:1::23)
 by SN6PR12MB2735.namprd12.prod.outlook.com (2603:10b6:805:69::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 17:58:38 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::ea) by MW2PR16CA0046.outlook.office365.com
 (2603:10b6:907:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:37 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:35 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 24/33] EDAC/amd64: Define function to get CS Fabric ID
Date:   Thu, 28 Oct 2021 17:57:19 +0000
Message-ID: <20211028175728.121452-25-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 14c99eff-4329-490c-7772-08d99a3c9180
X-MS-TrafficTypeDiagnostic: SN6PR12MB2735:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2735EE1DB06662A3445F615DF8869@SN6PR12MB2735.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJGuDMFkbNHlUtoJAWpqvqMrKIhxYNz/MgbMmKu+fFu+xO2g9Q/kUKxCz5+xMyrpb9IP3U1aiAnyiOYFGDFIDe5jh7H2lsW+en4P7gUoE5B0wUipJqzP9Yf4qNaLLdptGbfV7jL0tcjwTtCf/MVXaeFy5RfmOj0k2nOB3T8Y9DxbvQoiO+qykmqE3bfYVZlZeaa26RVcIWoQL52nObNc6YGt4PVB0/EcLSz6mKPjpMovY/LS51hQn9Cn9jgM5zDzurMnnu72+xGF8gDNbTi+Naj37qHhusvPM6i24wGIOvkNwYRxf3NXFXhmX8slBDi9pDeWONwn3ZGGO3eUzFkBkKTUp22o4BIhZSailgBvQIp0297Daw5FMrL56ZLJ5486a6/2B7BlNCYWdX0rX6rVD+SRgKr7Tdit5OUT81JYdSEkUyTVU0gK6jmXt43dpjynAuCw8wxGz0RBBjd0UqmRFAMv83eRgBNfxJgmT0+ZNfD9hRzRqerCdp/Rqq+HDP8NgoX7UcMFzx4RvettqW2IExMsSkonePdxzBDEijgH85GKguWDfDUXLfsZsGM8/UkAVqfeG3gEwYjE1ui4MkXLRz0/U/Q5gbJHyqqwDhrVfho42rWzMzdNiXkAIWNtD9kc57lNnlDoEzMP7kgmAJ5VSLMYFZX9E517JkO9xeiC2nDapnUMxtbrEPfUIL87jOGDXhQgKE78FpDoOE2x/1yVkO9ietn/MRzohculDr1Vy9H94+MnovcrB75pqd6lj5eWSHdbdovgVGE8bUGTUOSEgMx3NIA0XzidoaCwJHukG9jfIqVRJhYlf2WMsgNFFMO/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8676002)(8936002)(7696005)(356005)(508600001)(36860700001)(86362001)(70586007)(82310400003)(70206006)(83380400001)(426003)(54906003)(26005)(966005)(44832011)(47076005)(336012)(316002)(36756003)(81166007)(1076003)(6666004)(6916009)(16526019)(2906002)(5660300002)(2616005)(4326008)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:37.7867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c99eff-4329-490c-7772-08d99a3c9180
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2735
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
https://lkml.kernel.org/r/20210623192002.3671647-26-yazen.ghannam@amd.com

v2->v3:
* Was patch 25 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.
* Added function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index a36df70910aa..5aae735f1389 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1064,6 +1064,7 @@ struct addr_ctx {
 	u32 reg_dram_offset;
 	u32 reg_base_addr;
 	u32 reg_limit_addr;
+	u16 cs_fabric_id;
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
@@ -1080,6 +1081,7 @@ struct addr_ctx {
 struct data_fabric_ops {
 	u64	(*get_hi_addr_offset)		(struct addr_ctx *ctx);
 	int	(*get_intlv_mode)		(struct addr_ctx *ctx);
+	int	(*get_cs_fabric_id)		(struct addr_ctx *ctx);
 	void	(*get_intlv_num_dies)		(struct addr_ctx *ctx);
 	void	(*get_intlv_num_sockets)	(struct addr_ctx *ctx);
 };
@@ -1163,11 +1165,23 @@ static void get_intlv_num_sockets_df2(struct addr_ctx *ctx)
 	ctx->intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
 }
 
+static int get_cs_fabric_id_df2(struct addr_ctx *ctx)
+{
+	/* Read D18F0x50 (FabricBlockInstanceInformation3). */
+	if (df_indirect_read_instance(ctx->nid, 0, 0x50, ctx->inst_id, &ctx->tmp))
+		return -EINVAL;
+
+	ctx->cs_fabric_id = (ctx->tmp >> 8) & 0xFF;
+
+	return 0;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	get_hi_addr_offset_df2,
 	.get_intlv_mode			=	get_intlv_mode_df2,
 	.get_intlv_num_dies		=	get_intlv_num_dies_df2,
 	.get_intlv_num_sockets		=	get_intlv_num_sockets_df2,
+	.get_cs_fabric_id		=	get_cs_fabric_id_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1257,20 +1271,13 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 static int calculate_cs_id(struct addr_ctx *ctx)
 {
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 die_id_bit, sock_id_bit, cs_fabric_id, cs_mask = 0;
-
-	/* Read D18F0x50 (FabricBlockInstanceInformation3). */
-	if (df_indirect_read_instance(ctx->nid, 0, 0x50, ctx->inst_id, &ctx->tmp))
-		return -EINVAL;
-
-	cs_fabric_id = (ctx->tmp >> 8) & 0xFF;
-	die_id_bit   = 0;
+	u8 die_id_bit = 0, sock_id_bit, cs_mask = 0;
 
 	/* If interleaved over more than 1 channel: */
 	if (ctx->intlv_num_chan) {
 		die_id_bit = ctx->intlv_num_chan;
 		cs_mask	   = (1 << die_id_bit) - 1;
-		ctx->cs_id = cs_fabric_id & cs_mask;
+		ctx->cs_id = ctx->cs_fabric_id & cs_mask;
 	}
 
 	sock_id_bit = die_id_bit;
@@ -1286,7 +1293,7 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 		die_id_shift = (ctx->tmp >> 24) & 0xF;
 		die_id_mask  = (ctx->tmp >> 8) & 0xFF;
 
-		ctx->cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+		ctx->cs_id |= ((ctx->cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
 	}
 
 	/* If interleaved over more than 1 socket: */
@@ -1294,7 +1301,8 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 		socket_id_shift	= (ctx->tmp >> 28) & 0xF;
 		socket_id_mask	= (ctx->tmp >> 16) & 0xFF;
 
-		ctx->cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
+		ctx->cs_id |= ((ctx->cs_fabric_id & socket_id_mask)
+				>> socket_id_shift) << sock_id_bit;
 	}
 
 	return 0;
@@ -1372,6 +1380,9 @@ static int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 df_inst_id)
 	ctx.nid = nid;
 	ctx.inst_id = df_inst_id;
 
+	if (df_ops->get_cs_fabric_id(&ctx))
+		return -EINVAL;
+
 	if (remove_dram_offset(&ctx))
 		return -EINVAL;
 
-- 
2.25.1

