Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D25443E7C8
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhJ1SBx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:53 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:48865
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231464AbhJ1SBB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yd921iHwYyKdQaUvkEERYLxKWN+B6oHQ0yHpbxL0KNPWgJCJkXQjbcCBfLCDOTGJsR2I5uWT9f/lZvZ/VAQDjec4xuwHjk/5e0vmn6nDhAnxAtr2GlIXGe0usbL3PgQ2o0cfYdblcWHVxWXk/dQAOcv0F0E4PZkUnME81XlA2Mrn9WLYOAxfKIH5rT6NjMGcDR6IvzgKur0Upc/yPa0f5ElcsNLGOr0quxKsgOa4mRGAUJ2G4CWmdRyzwPx+mw3c4uDm7IUyhKppkK4KlPsopUYVxBBwGOwhSo+BCf1OKCSnklYSy4RmJLFoLflZNhNOgRCSjHFgi7jIY8OozjdbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbuj3gBbrHvgi6yDN9IAAWceaMRuR2lUMJaDSg2kNAo=;
 b=RoIA3WoCvQLElYVaVhcikCcq2s9+bejRkXQacGh8cdXYdgcK9C5+SZimA+Yh58byFXimjiWCxg65pUg9TwguQOHhks5nlZCkk88iuXA8I3CnzUwxxvKe2gssG8XxJyZ3U7e/y3VxZA+vg1krFCkdESrV+Q1j1ajObpsz+oTEQwQq63r8Ff8wDIu2fHfZjQsbGN9G/QdTrnsyvV/eGhJsDv+h0f0M/ihEUjSrw+pCeEPwH22Gd4iD2306fOfTQqLDswmiweTQt8gZ/cBXNk33UQGCU9uKLYAeeu98K6Q9qI/0RWl5+T8MCGyNAAf59TImzShmw+zGbhGmb1MAcic8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbuj3gBbrHvgi6yDN9IAAWceaMRuR2lUMJaDSg2kNAo=;
 b=XbywNIZz0eY+SOVp+IbmSbM9yMM26Hew1SSDyT9UcMvMWGGqnwc/4HUJWN5L+GPccVzwd9YUWM9LgTsisYzTnxsAqzXFiv7SCHvVG9FX6hDX3L6vHlR1JEwUczkQsbk7SodLvsIsVliXLdCow/HOGTKE/aruBhR5/JKeqOkaz+Y=
Received: from CO1PR15CA0112.namprd15.prod.outlook.com (2603:10b6:101:21::32)
 by CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 17:58:31 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::f4) by CO1PR15CA0112.outlook.office365.com
 (2603:10b6:101:21::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:30 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:26 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 19/33] EDAC/amd64: Define function to get number of interleaved sockets
Date:   Thu, 28 Oct 2021 17:57:14 +0000
Message-ID: <20211028175728.121452-20-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ba75bc57-adb4-41c1-ec77-08d99a3c8d1c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1366:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1366ED3494F7D57AB367ED72F8869@CY4PR12MB1366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ARlVVrrd2YbSXeOZvQEUbUzl3IP3NE5RcwCVEzg6kSZeE2QFf0pEC+q1KRpUTmdrJibXbPNuPR8se84vOVg6kXuIIjLVfr7ycWwAX5RkS88sKFuQUN4mNRX2TQPKGyRMl9B2LsGeNv1/8bpNCiZPq62CjFcYVYozCJzu4vaN1PZitjBT7UE2MeHhwZwW4WxEuLXSTiEmh7COWhZjKJspFMN84/y+tNom90iDb3x5R0QZm2Dx5ML4PDVqMwjOf66nWTKK7yGmKeYHPXLJgJFyBET/bi8qUycXQBGWTnO1j/QUhMtHlxYxUm7azMPTcPjr32h77l89fSyHyEvUq6Dj20/qHrA31rIELZB89/cp6YAtcXfnf2rVj/6jd8/S4a04LTC/Vf5iuHjMpNvXcXFx2EGIGRx7s4sfG6lgpjbyqiJo1qGrIftWlukQ+FZ2U7WoYRHag/Ty301RgyUBST9nE9Ly1bON7JIKp7o17RbV1aZ8LT7990Oa4L4g0CwfKZCP+js8KtNcAD75N8B56hoYUrOUajGNxsP3S4NnISi4dGpDXfqkuhHx10u+AjqHUlGaY6QnqNFHVIZaN6Tn2sQYJbFFV/WFAiBnlWEEm1aUu/YalJMylalLF/YOcsUFTGUybZFqeocUA7RVB3UoVXfKX0+hMvBgpsEtqvj6UmBD2ALAQpuenriUF+2ZV2YjQOsWz0ZfXs7iLoRQnSKu8rgVR9Cmv2ZCeWrY/xh6U0UX+U+8w9DIpdbOyfzQHlYS98psw2ZV7BGbfKRLbHpl+w0kiD2qyE1De/yL5Kkktw2+FCpXhpXr4gy5VMEJh1nDYh0
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(186003)(86362001)(2616005)(16526019)(508600001)(82310400003)(7696005)(316002)(36860700001)(8936002)(8676002)(1076003)(4326008)(5660300002)(6916009)(6666004)(966005)(336012)(2906002)(426003)(81166007)(47076005)(70206006)(54906003)(70586007)(26005)(83380400001)(44832011)(36756003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:30.4255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba75bc57-adb4-41c1-ec77-08d99a3c8d1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1366
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move parsing of the number of interleaved sockets to a separate helper
function. This will be expanded for future DF versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-21-yazen.ghannam@amd.com

v2->v3:
* Was patch 20 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.
* Add new function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index e76aa8ee906a..18e446c59baa 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1070,6 +1070,7 @@ struct addr_ctx {
 	u8 intlv_addr_bit;
 	u8 intlv_num_chan;
 	u8 intlv_num_dies;
+	u8 intlv_num_sockets;
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 };
@@ -1078,6 +1079,7 @@ struct data_fabric_ops {
 	u64	(*get_hi_addr_offset)		(struct addr_ctx *ctx);
 	int	(*get_intlv_mode)		(struct addr_ctx *ctx);
 	void	(*get_intlv_num_dies)		(struct addr_ctx *ctx);
+	void	(*get_intlv_num_sockets)	(struct addr_ctx *ctx);
 };
 
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
@@ -1123,10 +1125,16 @@ static void get_intlv_num_dies_df2(struct addr_ctx *ctx)
 	ctx->intlv_num_dies  = (ctx->reg_limit_addr >> 10) & 0x3;
 }
 
+static void get_intlv_num_sockets_df2(struct addr_ctx *ctx)
+{
+	ctx->intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	get_hi_addr_offset_df2,
 	.get_intlv_mode			=	get_intlv_mode_df2,
 	.get_intlv_num_dies		=	get_intlv_num_dies_df2,
+	.get_intlv_num_sockets		=	get_intlv_num_sockets_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1216,7 +1224,6 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 static int denormalize_addr(struct addr_ctx *ctx)
 {
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_sockets;
 	u8 num_intlv_bits, cs_mask = 0;
 
 	/* Return early if no interleaving. */
@@ -1226,16 +1233,13 @@ static int denormalize_addr(struct addr_ctx *ctx)
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
@@ -1270,7 +1274,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		sock_id_bit = die_id_bit;
 
 		/* Read D18F1x208 (SystemFabricIdMask). */
-		if (ctx->intlv_num_dies || intlv_num_sockets)
+		if (ctx->intlv_num_dies || ctx->intlv_num_sockets)
 			if (df_indirect_read_broadcast(ctx->nid, 1, 0x208, &ctx->tmp))
 				return -EINVAL;
 
@@ -1285,7 +1289,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		}
 
 		/* If interleaved over more than 1 socket. */
-		if (intlv_num_sockets) {
+		if (ctx->intlv_num_sockets) {
 			socket_id_shift	= (ctx->tmp >> 28) & 0xF;
 			socket_id_mask	= (ctx->tmp >> 16) & 0xFF;
 
-- 
2.25.1

