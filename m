Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AFE49ECB7
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344255AbiA0UmC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:42:02 -0500
Received: from mail-bn7nam10on2048.outbound.protection.outlook.com ([40.107.92.48]:20192
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344178AbiA0Ulv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLqjjQaVxd3wJaaXUC2AFWEUrvDkixqIxdYh5aFTinbNIlVO57q1IFryOohdu2Ad1+4rEC6hjEerQxD/yu6LshBG3pE7/mwZxtRMS50O/e17Yk23OqA/BmWrFABLw3vY5bXS4Pi6Tf9J9TRy91Mo9WalfAtAipLhqPDGSAVkQG5YWygw3eS27U/KkKVheCAnT52a2UwdXRnGRkHywIZ0DKn5LucYug1HD+I3GAP4HkH2ZAPa8WE8qcFwM0sJxruJo0wcyW0IGQpSX0NC2AwOrlBDYl+l4RKuGNfhjcHBrCJBNjxSxjAncMDVbcfPLQQZetYTqbyuQYRejm8xedNQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1y8IFmwNgNBTw7DYyoyabirsWA/lcCbFtNrvlMWqsfo=;
 b=aNOP6M7AeFGEHp7mexwQkH4Z+QH2XoQx7MidaYjGOLEUlH+4PA9qGn51/mmzbcF57qDcOXjebOBMYjRl7jTqoD/jWmxGsUZrC6jUK2r1kLvCyaL+lzk4Da+tdYT5WqPK4Aq7TVAxmdb0JMY9Le/slCduxzDWUCGij70YNvRaDAEZQp6lyT77f4nieECXhM3QRzDrMOQkCEuc3/ZgLH4A3dIk16v3tRLsNyjd78mME3/+GTiUs5g0c5C4gyDHBzWz2dpnHFkmsdChM6afE1Hs0HwZ+hk61ntHwSdXS8NZxlek+yfOZkvDZ9ogejliTIQoDgxBs1qxH3DHCfNjPRQcnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1y8IFmwNgNBTw7DYyoyabirsWA/lcCbFtNrvlMWqsfo=;
 b=Lj4GVdgxvCI05DiunKDBzoFxHex807L9R3TOpKuEF+Nmr+D/sECb/BQg6YTsiqusWXFDWzu+R6DMEC7OZI3vjvuHaDLGPFk/J3CRf36NM5Zu6j69jfaU1tS5m1uKrYnZOLpWulWrP4gRaFu3bCks+YUej1lufoUVfrvaWo1Mdqc=
Received: from MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::28)
 by DM6PR12MB4716.namprd12.prod.outlook.com (2603:10b6:5:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 20:41:49 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::39) by MW4P221CA0023.outlook.office365.com
 (2603:10b6:303:8b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:49 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:44 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 17/24] EDAC/amd64: Define function to calculate CS ID
Date:   Thu, 27 Jan 2022 20:41:08 +0000
Message-ID: <20220127204115.384161-18-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ed089ab5-c444-45d5-a419-08d9e1d5716c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4716:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB47166F6618356FFAA68173C9F8219@DM6PR12MB4716.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sc8ZRJTvRrNFxQD8zqTuqeg9gMUvXJBfyJqX5AgUvrADrVJmOosIZlhFLVByOd/am8Ve1vLeZhrXv8/WY/43Qi2V3Ky19qkSN2JE5Hmfs41JJzOZyf6FPYPSOMY6rSsuAirr0WvDbm0kagr3PYMLq2V3SSupjRbVotBMZfPiphPMdeswgxEWCCHEARqLc0cXrHmwMOmg4LrM0INOc7b99bEzmb5R5UIMSMHGpPV7hD/oTwFCmVHDhNeQvzxrZVZZT4JGPYHt8vf55epmKkkAxnBLPGj3uZAFIeMkYgkddnQKaEdzTKX+mEm7GKrHujtFVfQz62WBj2GmNFchQ7DI39FnLqrXuJQ3AepG3k2xv+bnp5b4wA72gEKEUZrfJBfEXo6ctaGEz6DVxIobEHdV+9TRybHxVNCOiZBKPL5uDEFBWax5LHRDLvT9rPANQWl7ZTvZFydI2StIyKOoN67Ye9J8+q2yXLterVp2hOE6+07/e4Y4t5oMoVONDYdavfBP+4Johm+1w6r8LTnA0NX48PBM10XMhSV2fzB+ymiGkk8KzRDJvkRSRMPa0ROtwHfM2+W/GeyQafvNChrmSf5Ac9Yfpqy+PLA8EflfUtIft60rZQF2aS9z++gKOdafEGrMlPMRtHlqvDObY5uSYepNaCRCmXEROPlMs5LVN52pW0IdaoUJAAN77hvqVLlUilIG4n6DBEVIf1ZonaybXh7hhiuoO8Fde8tbwiXgMI/BF7DSbuTnutKSx7MSlXwLrAGtQr5YogX2AUOAIUi6R1uCwl1tI/IH16eTnOXbHJxk02A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(6916009)(2616005)(54906003)(40460700003)(186003)(508600001)(966005)(36756003)(26005)(44832011)(5660300002)(336012)(426003)(86362001)(8936002)(8676002)(70586007)(70206006)(4326008)(1076003)(16526019)(83380400001)(316002)(81166007)(82310400004)(36860700001)(356005)(6666004)(7696005)(47076005)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:49.4989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed089ab5-c444-45d5-a419-08d9e1d5716c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4716
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move code used to calculate the CS ID into a separate helper function.

Drop redundant code comment about reading DF register.

The "num_intlv_bits" variable is left uninitialized as it will be removed
in a later patch.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-23-yazen.ghannam@amd.com

v3->v4:
* Include pr_debug() on failure.

v2->v3:
* Was patch 23 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 100 ++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 48 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f5b1902e04ac..b2bcd8ea1a06 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1258,10 +1258,55 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 	}
 }
 
-static int denormalize_addr(struct addr_ctx *ctx)
+static int calculate_cs_id(struct addr_ctx *ctx)
 {
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 num_intlv_bits, cs_mask = 0;
+	u8 die_id_bit, sock_id_bit, cs_fabric_id, cs_mask = 0;
+
+	/* Read D18F0x50 (FabricBlockInstanceInformation3). */
+	if (df_indirect_read_instance(ctx->nid, 0, 0x50, ctx->inst_id, &ctx->tmp))
+		return -EINVAL;
+
+	cs_fabric_id = (ctx->tmp >> 8) & 0xFF;
+	die_id_bit   = 0;
+
+	/* If interleaved over more than 1 channel: */
+	if (ctx->intlv_num_chan) {
+		die_id_bit = ctx->intlv_num_chan;
+		cs_mask	   = (1 << die_id_bit) - 1;
+		ctx->cs_id = cs_fabric_id & cs_mask;
+	}
+
+	sock_id_bit = die_id_bit;
+
+	/* Read D18F1x208 (SystemFabricIdMask). */
+	if (ctx->intlv_num_dies || ctx->intlv_num_sockets)
+		if (df_indirect_read_broadcast(ctx->nid, 1, 0x208, &ctx->tmp))
+			return -EINVAL;
+
+	/* If interleaved over more than 1 die: */
+	if (ctx->intlv_num_dies) {
+		sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
+		die_id_shift = (ctx->tmp >> 24) & 0xF;
+		die_id_mask  = (ctx->tmp >> 8) & 0xFF;
+
+		ctx->cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+	}
+
+	/* If interleaved over more than 1 socket: */
+	if (ctx->intlv_num_sockets) {
+		socket_id_shift	= (ctx->tmp >> 28) & 0xF;
+		socket_id_mask	= (ctx->tmp >> 16) & 0xFF;
+
+		ctx->cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
+	}
+
+	return 0;
+}
+
+static int denormalize_addr(struct addr_ctx *ctx)
+{
+	u8 num_intlv_bits;
 
 	/* Return early if no interleaving. */
 	if (ctx->intlv_mode == NONE)
@@ -1276,55 +1321,14 @@ static int denormalize_addr(struct addr_ctx *ctx)
 
 	ctx->make_space_for_cs_id(ctx);
 
+	if (calculate_cs_id(ctx)) {
+		pr_debug("Failed to calculate CS ID");
+		return -EINVAL;
+	}
+
 	if (num_intlv_bits > 0) {
-		u8 die_id_bit, sock_id_bit, cs_fabric_id;
 		u64 temp_addr_i;
 
-		/*
-		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
-		 * This is the fabric id for this coherent slave. Use
-		 * umc/channel# as instance id of the coherent slave
-		 * for FICAA.
-		 */
-		if (df_indirect_read_instance(ctx->nid, 0, 0x50, ctx->inst_id, &ctx->tmp))
-			return -EINVAL;
-
-		cs_fabric_id = (ctx->tmp >> 8) & 0xFF;
-		die_id_bit   = 0;
-
-		/* If interleaved over more than 1 channel: */
-		if (ctx->intlv_num_chan) {
-			die_id_bit = ctx->intlv_num_chan;
-			cs_mask	   = (1 << die_id_bit) - 1;
-			ctx->cs_id = cs_fabric_id & cs_mask;
-		}
-
-		sock_id_bit = die_id_bit;
-
-		/* Read D18F1x208 (SystemFabricIdMask). */
-		if (ctx->intlv_num_dies || ctx->intlv_num_sockets)
-			if (df_indirect_read_broadcast(ctx->nid, 1, 0x208, &ctx->tmp))
-				return -EINVAL;
-
-		/* If interleaved over more than 1 die. */
-		if (ctx->intlv_num_dies) {
-			sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
-			die_id_shift = (ctx->tmp >> 24) & 0xF;
-			die_id_mask  = (ctx->tmp >> 8) & 0xFF;
-
-			ctx->cs_id |= ((cs_fabric_id & die_id_mask)
-					>> die_id_shift) << die_id_bit;
-		}
-
-		/* If interleaved over more than 1 socket. */
-		if (ctx->intlv_num_sockets) {
-			socket_id_shift	= (ctx->tmp >> 28) & 0xF;
-			socket_id_mask	= (ctx->tmp >> 16) & 0xFF;
-
-			ctx->cs_id |= ((cs_fabric_id & socket_id_mask)
-					>> socket_id_shift) << sock_id_bit;
-		}
-
 		/*
 		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
 		 * where III is the ID for this CS, and XXXXXXYYYYY are the
-- 
2.25.1

