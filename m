Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59043E7D7
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 20:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhJ1SCT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:02:19 -0400
Received: from mail-bn8nam11on2086.outbound.protection.outlook.com ([40.107.236.86]:21504
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231558AbhJ1SBL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgMyrfQqeIYLHO7yswHPtPMo1Z0rYkz2bGDVoioZqM3gBXnInGfLGeG6ldl20kYNPNyMPwEp+df6Zk4+ujb9adzeFLiG/L1wlsnvF3yp65Z3LKPRUJAnBjaSr9v7wDa2/HIor3k/zT1SoDnS04HCYVRK8KB6rottIiKJyfsOo43UvHoiMrBPoqdfizaRzY3786cRwESd1WPF02mOueGUSvMSRBXLp7oJh9MorBmyzDIHCrCCAeL5tL5lCgjpzd6QJsZgIMhJ5F+64/tKqn6UQ5CFmxAMLt4IsXvRh9AMEc3aD0u1Ks9pgoXjmSQkJ7gll4Xkp1CGc7RLsFEn3ET2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NruLU/upxbypVshP2W1MRlQ6u250aF6faz+GFygvsK0=;
 b=GIPlDZmnSL1FzyrnIKh6H4yuGV8iLsuDDkTXyXuv4QI8KOVYPr0rC6wB6To7QYjrTBSVIqFI66StfBio3CUuX/7Eb7CQTaRgLZytpFmKp7seFtdWkCWfFSFg4Mlx7w+7baa53GlqUkj7W+DH8QyBfKsfMSvgNup5eI7gve6p2w/oeRGCTHqQmNKdy8oY/pN8+hsLskTsg3r1XDoKvIjj1GB3QMpqg/SRbD2QwvMpPySEDvOwhy6BnMnywKbP4pKxO1pRYF18H8H0JtsCMEX8E+UiZ9PuuG9/lT9oPqGlgU1dAFcSVZqGcLtvDaouBY1+k3uYEzwOCTHql+oc2Svn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NruLU/upxbypVshP2W1MRlQ6u250aF6faz+GFygvsK0=;
 b=VSjaHImbmo5uwilYUshhL0qT2/Xq++wQH9VCJkoqlxrPeNLBza0wknXktP3N0BBp2KkMdFjajhPYA5bH2GEK66EinEFvQPHhl5QYpdPm3XkUgM5jA0vynEp/nPCMTlg4SaJBMj1UqPsF64JE4u7UD4bXPb33LnEFB/Lu4he2DOY=
Received: from MW2PR16CA0038.namprd16.prod.outlook.com (2603:10b6:907:1::15)
 by DM6PR12MB3260.namprd12.prod.outlook.com (2603:10b6:5:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 17:58:39 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::d1) by MW2PR16CA0038.outlook.office365.com
 (2603:10b6:907:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:38 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:37 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 25/33] EDAC/amd64: Define function to find shift and mask values
Date:   Thu, 28 Oct 2021 17:57:20 +0000
Message-ID: <20211028175728.121452-26-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 746f8570-7b46-4590-5593-08d99a3c9223
X-MS-TrafficTypeDiagnostic: DM6PR12MB3260:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32600879A3B01A3C338253AEF8869@DM6PR12MB3260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GcrN4jmAhgkrGdF5ww9pJyjacG21j5fEc0EjsrtERZ5x6FREsKoVv/6/nJiYWy2Nb2OiaIJV0p78wRxd/Dsr0H2wN1e/1viW/T1C4BSPy+uN/2kr6eaEIcgglW5eKtD9pSg3+UDFcc9oTWSOJumOnhDVDvqzI9pjN3HIS0J+EC/92H4YPpIO0xg36y4fuYAL4NY2JCUyDoqm0pJSTkKl3WvGuALShr7f/JmSX753C0O9PUQ3wfBWYAzX05wqmeebPzdkUWN6MIcPa59HP9Cfr9iIgb+WZ/YBVqj9+mmSFAZYyY82NoHpTBu7TkF61+zRKYgLP/SVbCfrXClFfE6WOClTuT63LfeXvQHRGHdrJmXgT9lGGjkeRjGaDTBTL1hStOyxu3E+l2JStHnSQiHFUMTwSWBKLCMjFOaq8iIkNB2ibyfQwJ1e7XlR4mjR+TMVuLebqdw/SdA8OdQgPVPgS/iy0nB+LCvhMORHLQnq6Or36d7cMAD8F7VeeIio1ocfNm39Na78lgZFKmFk/8kUfDNor19ceKNuPSOwFmwhtSgLylYDI8BU7WkpHfb42jJvUrhfY3QaOI0zG5+u33L4XUlfpXHzXSWcU3agt93iJTPb2oiwR/j1emhXLbWz7h0Qr4R7D3uhtSO9BIjwJEdlrXlqF25zObFPMMYcazcrc/ZMkpmT2EDjhskOBUEXGDTxgJgtqtg+Aciar9/q6nwLKxLRRM6yKzaN5uPi22TzAlbw41QSIaqr7qYjQncy1iUiLHpslDogY/DUFPAFoPAm2fHtZPJMlzgj/nyDEcWrwAa84qIE2JJFyTYqrQ87vKlN0A5n7/2GpbB8bsEExyo7sForSWIxpPFW3HXIpZma0jM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(44832011)(70206006)(36860700001)(186003)(8936002)(83380400001)(47076005)(26005)(8676002)(70586007)(356005)(4326008)(36756003)(81166007)(426003)(16526019)(6916009)(5660300002)(316002)(336012)(82310400003)(7696005)(966005)(508600001)(2906002)(54906003)(6666004)(1076003)(86362001)(2616005)(37363002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:38.8551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 746f8570-7b46-4590-5593-08d99a3c9223
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3260
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move code to find the shift and mask values used in die and socket
interleaving into separate helper functions. These will be expanded for
future DF versions. Make the die_id_mask and socket_id_mask values u16
type to accommodate larger bitfields in future DF versions.

Also, move reading of the System Fabric ID Mask register into
get_masks(). This will be expanded for future DF versions.

Call get_masks() early since future DF versions may need these values
early.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-27-yazen.ghannam@amd.com

v2->v3:
* Was patch 26 in v2.
* Remove early code related to "df_ops".

v1->v2:
* Moved from arch/x86 to EDAC.
* Added functions to data_fabric_ops.

 drivers/edac/amd64_edac.c | 57 ++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 5aae735f1389..9312784b2b0f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1064,7 +1064,10 @@ struct addr_ctx {
 	u32 reg_dram_offset;
 	u32 reg_base_addr;
 	u32 reg_limit_addr;
+	u32 reg_fab_id_mask0;
 	u16 cs_fabric_id;
+	u16 die_id_mask;
+	u16 socket_id_mask;
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
@@ -1080,8 +1083,11 @@ struct addr_ctx {
 
 struct data_fabric_ops {
 	u64	(*get_hi_addr_offset)		(struct addr_ctx *ctx);
+	u8	(*get_die_id_shift)		(struct addr_ctx *ctx);
+	u8	(*get_socket_id_shift)		(struct addr_ctx *ctx);
 	int	(*get_intlv_mode)		(struct addr_ctx *ctx);
 	int	(*get_cs_fabric_id)		(struct addr_ctx *ctx);
+	int	(*get_masks)			(struct addr_ctx *ctx);
 	void	(*get_intlv_num_dies)		(struct addr_ctx *ctx);
 	void	(*get_intlv_num_sockets)	(struct addr_ctx *ctx);
 };
@@ -1176,12 +1182,37 @@ static int get_cs_fabric_id_df2(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int get_masks_df2(struct addr_ctx *ctx)
+{
+	/* Read D18F1x208 (SystemFabricIdMask). */
+	if (df_indirect_read_broadcast(ctx->nid, 1, 0x208, &ctx->reg_fab_id_mask0))
+		return -EINVAL;
+
+	ctx->die_id_mask    = (ctx->reg_fab_id_mask0 >> 8) & 0xFF;
+	ctx->socket_id_mask = (ctx->reg_fab_id_mask0 >> 16) & 0xFF;
+
+	return 0;
+}
+
+static u8 get_die_id_shift_df2(struct addr_ctx *ctx)
+{
+	return (ctx->reg_fab_id_mask0 >> 24) & 0xF;
+}
+
+static u8 get_socket_id_shift_df2(struct addr_ctx *ctx)
+{
+	return (ctx->reg_fab_id_mask0 >> 28) & 0xF;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	get_hi_addr_offset_df2,
 	.get_intlv_mode			=	get_intlv_mode_df2,
 	.get_intlv_num_dies		=	get_intlv_num_dies_df2,
 	.get_intlv_num_sockets		=	get_intlv_num_sockets_df2,
 	.get_cs_fabric_id		=	get_cs_fabric_id_df2,
+	.get_masks			=	get_masks_df2,
+	.get_die_id_shift		=	get_die_id_shift_df2,
+	.get_socket_id_shift		=	get_socket_id_shift_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1270,7 +1301,6 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 
 static int calculate_cs_id(struct addr_ctx *ctx)
 {
-	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
 	u8 die_id_bit = 0, sock_id_bit, cs_mask = 0;
 
 	/* If interleaved over more than 1 channel: */
@@ -1280,28 +1310,26 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 		ctx->cs_id = ctx->cs_fabric_id & cs_mask;
 	}
 
-	sock_id_bit = die_id_bit;
+	/* Return early if no die interleaving and no socket interleaving. */
+	if (!(ctx->intlv_num_dies || ctx->intlv_num_sockets))
+		return 0;
 
-	/* Read D18F1x208 (SystemFabricIdMask). */
-	if (ctx->intlv_num_dies || ctx->intlv_num_sockets)
-		if (df_indirect_read_broadcast(ctx->nid, 1, 0x208, &ctx->tmp))
-			return -EINVAL;
+	sock_id_bit = die_id_bit;
 
 	/* If interleaved over more than 1 die: */
 	if (ctx->intlv_num_dies) {
-		sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
-		die_id_shift = (ctx->tmp >> 24) & 0xF;
-		die_id_mask  = (ctx->tmp >> 8) & 0xFF;
+		u8 die_id_shift = df_ops->get_die_id_shift(ctx);
 
-		ctx->cs_id |= ((ctx->cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+		sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
+		ctx->cs_id |= ((ctx->cs_fabric_id & ctx->die_id_mask)
+				>> die_id_shift) << die_id_bit;
 	}
 
 	/* If interleaved over more than 1 socket: */
 	if (ctx->intlv_num_sockets) {
-		socket_id_shift	= (ctx->tmp >> 28) & 0xF;
-		socket_id_mask	= (ctx->tmp >> 16) & 0xFF;
+		u8 socket_id_shift = df_ops->get_socket_id_shift(ctx);
 
-		ctx->cs_id |= ((ctx->cs_fabric_id & socket_id_mask)
+		ctx->cs_id |= ((ctx->cs_fabric_id & ctx->socket_id_mask)
 				>> socket_id_shift) << sock_id_bit;
 	}
 
@@ -1380,6 +1408,9 @@ static int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 df_inst_id)
 	ctx.nid = nid;
 	ctx.inst_id = df_inst_id;
 
+	if (df_ops->get_masks(&ctx))
+		return -EINVAL;
+
 	if (df_ops->get_cs_fabric_id(&ctx))
 		return -EINVAL;
 
-- 
2.25.1

