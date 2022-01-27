Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B63A49ECB6
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbiA0UmB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:42:01 -0500
Received: from mail-dm6nam12on2069.outbound.protection.outlook.com ([40.107.243.69]:31360
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344166AbiA0Uly (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMY7D/w5L7wPLlnq3QbkB4jW5HrGqsj5Z1vwtjSyoLI9jC58dUP3y4w+k37Y5bVfqDz89dQEhSkwqN/bjCfjc6Ctm6xbtqsxAk6UudiOeVbc64cvZqiUMnoqskN7Nk0Uv4XziM6xTYiQPA7QhJpNVidW+SpngRN5JJnhZQBScntEwtAmPwmoQaBQGeL62+7BPBNkfuP0dPi30/x6SqHE1LGk/hZM5scDFPBATQWon8ZLduEvdUCWm4XiPGvX6mL8jUyikp0hWxsEVY0LjztYXQaRhZWmrGVHaNRQY/ixStWpt7z6Mc9TsqlxSNhV6KTe9vkal75za8OZYd2hfkSkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rar7/cDyMbjETAmhVbmutqlb77s6xTf4p9SjhqMLs4Q=;
 b=AZmCBbXqZjTgz81t+gsKI1CjCMx9A883dokZPJW5Noki0YQ7HjOBNXocxly2FFVYiPcCBb2sNYa5k4zynFlbDAXFr4x0TZfbnAxZkkpaBLTBQWVm8QXdwwnTndyGoKk7P3qmtPLCrSPQfFaWVoX4q84ZVyMot/F87jiVTsArYOo7gEsclDkFObK0isX+NIjnRviduU+A5XymRuCqPl5BOblfG+DFNGNWlXcSynK4y5atPtjwRcX0Tq3QHOPo06pRsjEFPBcyPPaumPYYaPhwKKax8Q8WXz2OmMjz9S+E1rEUzQVE6Q+pAIgLNMZnAbyyfq/+8BbpGRcItWmqzqdFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rar7/cDyMbjETAmhVbmutqlb77s6xTf4p9SjhqMLs4Q=;
 b=vTLZvvududuU6XjHMjZg4utngZP/DiDTl7SEo4osGSwMImSxlc/4fm9k3kcPbLaVcP9+hHtNUQoD9ducTq2R0CBF8CvXNe0NVcg6i9uiH1RKI5TT1Okgg8arGH96pejIxa9EcbfNfD7eBDJ0Hx18A0x+IvqobhIwyQ81W2GfUYQ=
Received: from MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::30)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 20:41:50 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::1d) by MW4P221CA0025.outlook.office365.com
 (2603:10b6:303:8b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:50 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:45 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 19/24] EDAC/amd64: Define function to get CS Fabric ID
Date:   Thu, 27 Jan 2022 20:41:10 +0000
Message-ID: <20220127204115.384161-20-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127204115.384161-1-yazen.ghannam@amd.com>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bafc23e4-6016-4c6b-b093-08d9e1d571dc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4256:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4256B3BB866CD15E09330221F8219@MN2PR12MB4256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0qFxMkIMCov/vf9xgAQ2uoAkv20X4fRHuxwUVo9/G9NRQwaoOXjSi4BeE4dcj7qtmR0dVRwoYZ9xa9v6aN+obs0m6NOt2TC1MjBYwcdffkzGJXVFPsfMLFk6oFizhbnZIXe4pHbEp/aeOntv4oe7K8mqaebbCswma8zoD60d2Lm5Ju/AMK2IOGywkpfnbYUIsfXyILXDaBRq9F/xCS1Tgn51HgEKcH+F4wckHTGZM4JYLjO/URatVEO/MN2/skJfUhzf3ynm09qv1IIwzjNMLdI2idBl3BXGaDgmnUOu+1fvaLjQkUPX9gD0HeHTHGEwBXC83Lm/ryQtT7pu+DzStRRcQlZvEbuHQr5ju0XZ6uMJcJK/aoyz6wPXU4bClpDEAdHYox7urCXxCY/J57HpIVEVk4By1Bzb6/C/m06AuZIdrRoOxn6KwlthvPIJv0dCf3thZRImcgaScgJcdV761RY0Sk/n3MSWPFw1CvA0n0vN5jV/feEhus0bWgpnNb2qbOefoYU8xuMaNJvfJBiGqVZEG2SdgtJs9bID88jysPjn5dslhGlxfVInnsJOwyz7kS7Ut/Y5FFLbzmDP4QP46t6Bs/aoR2m7UXrkr+p9RFgOYOYQjlvwrmgYsuQ6l6DV2+ItSJER4lPzqDrX77VjhOYnMmAwpiCPpw3IOV+PqPeK4idMEDMc+Di0wunKiuQKlc4MbIi0GGc5DpAxTPmxgSBY/SLwOuV6oDu9qY51oyIW4GRKjuJGwlQnKsyDw99dU22Giejw/et642w7iYxMZ0DEMpRGNwpKnZWI7dAb50=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(54906003)(8936002)(508600001)(70586007)(4326008)(8676002)(426003)(316002)(82310400004)(336012)(70206006)(86362001)(83380400001)(966005)(5660300002)(6916009)(26005)(44832011)(40460700003)(47076005)(186003)(36756003)(1076003)(16526019)(81166007)(36860700001)(356005)(6666004)(2616005)(7696005)(2906002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:50.2333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bafc23e4-6016-4c6b-b093-08d9e1d571dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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
https://lore.kernel.org/r/20211028175728.121452-25-yazen.ghannam@amd.com

v3->v4:
* Remove leading whitespace in function pointer.
* Include pr_debug() in failure.

v2->v3:
* Was patch 25 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.
* Added function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index e3db4e98fe58..7891c2e93d53 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1073,6 +1073,7 @@ struct addr_ctx {
 	u32 reg_dram_offset;
 	u32 reg_base_addr;
 	u32 reg_limit_addr;
+	u16 cs_fabric_id;
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
@@ -1089,6 +1090,7 @@ struct addr_ctx {
 struct data_fabric_ops {
 	u64	(*get_hi_addr_offset)(struct addr_ctx *ctx);
 	int	(*get_intlv_mode)(struct addr_ctx *ctx);
+	int	(*get_cs_fabric_id)(struct addr_ctx *ctx);
 	void	(*get_intlv_num_dies)(struct addr_ctx *ctx);
 	void	(*get_intlv_num_sockets)(struct addr_ctx *ctx);
 };
@@ -1172,11 +1174,23 @@ static void get_intlv_num_sockets_df2(struct addr_ctx *ctx)
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
@@ -1268,20 +1282,13 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
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
@@ -1297,7 +1304,7 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 		die_id_shift = (ctx->tmp >> 24) & 0xF;
 		die_id_mask  = (ctx->tmp >> 8) & 0xFF;
 
-		ctx->cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+		ctx->cs_id |= ((ctx->cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
 	}
 
 	/* If interleaved over more than 1 socket: */
@@ -1305,7 +1312,8 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 		socket_id_shift	= (ctx->tmp >> 28) & 0xF;
 		socket_id_mask	= (ctx->tmp >> 16) & 0xFF;
 
-		ctx->cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
+		ctx->cs_id |= ((ctx->cs_fabric_id & socket_id_mask)
+				>> socket_id_shift) << sock_id_bit;
 	}
 
 	return 0;
@@ -1387,6 +1395,11 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	ctx.nid = nid;
 	ctx.inst_id = umc;
 
+	if (df_ops->get_cs_fabric_id(&ctx)) {
+		pr_debug("Failed to get CS Fabric ID");
+		return -EINVAL;
+	}
+
 	if (remove_dram_offset(&ctx)) {
 		pr_debug("Failed to remove DRAM offset");
 		return -EINVAL;
-- 
2.25.1

