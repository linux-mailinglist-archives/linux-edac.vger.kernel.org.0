Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65B443E7AA
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhJ1SAu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:00:50 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:59137
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231260AbhJ1SAm (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTjvQrl34p0Tv1EWfYb7SA84exzHPI1iDRQtLBZD8LrxCfZlkSgwAf+n+Z7IbRNInqvdIZ1B9XGkwiCvVCBbywaAffQjnKnLBR/9nA6GoMeDScU8kFz6DZEI172P/tv5kwHVarCzwAA/y5CUfOly0/Oo7Bg68l06RgK6UWJbwtAKIQSuRtt3CGesLH5aykdEnOFJ1IPre/JzH6Aay2qckFi8JFyHVnPaavqgKqzBmw66FiPkpiX+BIpNwjCAHhfFwzUBfe3KG3Fxe4pRKUPA6Rd1L4otpywus9QUEo2DzIhx8kCINZ8c4pCbJrKadnTazxOhSs5wG3dIVdXgxm8/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzig5E8FJk7xKgJgtIWeHPMmJn9kiusowra7EgOTliE=;
 b=NnQ0ZxysMsFtaKmWHSzYQjqkTLeS6xC1ekKF9A4b7YQLdA587mC15UAcF9SM8wczKofIhdXUFSNvcHUBnnvSHZrNbKMY3E913faALTb0buolTrqQxuAXo5T+wNfjEh2Y7oEaGpwnijt0XkQWt+nCFFA/QAavx1jTA2/AltmGgzYBmmY2o/uEzbGoi/kTwTyKt4ZqOxexmH2IiM0uN34OWUT++i6cTGKx9zeg8SxTnVbeXhLv7Eh1LPjK1K7MrU3fjfVng+tNzcpQHThNFZpoU/JT6qkAha1SSMYFyyikKAXQYAUY5ME7M8zqVj4nD7sJZb4pIw45UoH012jvuv8Zhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzig5E8FJk7xKgJgtIWeHPMmJn9kiusowra7EgOTliE=;
 b=dUIgdKGxS0BYWnFlVPv6SHNPpDHpFgCYFbbonYr+TStiKD+nl/2Jp0Mk0/zfF3Nee6nIxIDjNAZQ71YV7LURpCneir9KN41BCFeyf7dmM9iEF8vtNBC69Agd5JreoLXKZGHzQdbZ0IV8Y5cc5Gh2UyKz+qCip/BYhqXO+c0idJI=
Received: from MWHPR2001CA0021.namprd20.prod.outlook.com
 (2603:10b6:301:15::31) by MN2PR12MB3504.namprd12.prod.outlook.com
 (2603:10b6:208:d1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 17:58:12 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::f8) by MWHPR2001CA0021.outlook.office365.com
 (2603:10b6:301:15::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:11 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:10 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 08/33] EDAC/amd64: Define function to find interleaving mode
Date:   Thu, 28 Oct 2021 17:57:03 +0000
Message-ID: <20211028175728.121452-9-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 34407f5a-0476-48d9-c2bc-08d99a3c8209
X-MS-TrafficTypeDiagnostic: MN2PR12MB3504:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3504E5F09986B407B44992F2F8869@MN2PR12MB3504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GXj9v/ucN0E4SV83ZaTPLD0QuOh3HzPWWPnTlNsCjUN8DKBy5ww74V2O+2ljEvXwtNuIy6xDIGOjYzH67HPk7VDTR68S/itHfstBphCzOA9hEg1v5DQGM5IEItqv6Mln5XhyWmQ/fGgkieiEVqVX1yoopzQhvRJKFj139FdoTNtBJhVFVVawvH8FwXe2fTU/6q5Ole6x1v8uUAh5YIPqsqKOQh43NQHgAYntDjoCrRRBorbOaKZ0vKdLUFT2ZAPTlVRrUqV+bxCST6WGNpyMO+PEDRgb68gHhuWtWZjSVmUtNkNAZG3wkRP/7A/8cYkIAFrHMAiQSNRBO9NrNsvnyrjLbWu0cIpZEpnDM1MlnnDPb60TtXGf0eGihKF0ntDgodnFrpYSHPD096mwR3AVrxASa/tkRssZRt2ROJKcsP2E/ynvwkzwJqN6gRGXcOaE0jl84FndhB87ZwLpsC/Pg+XFd/ObWUytj1+U0DXoNYMsWiYvT1vwu9UyUcqkqS0YsfH9lTY/QmngVEQwW4ENpi0El8ysyHmmSZli+GPAyCOTsy33jJpq7Gs9cF6X/TojhdJtALXfuja8laxFPF3FmzqgTnRWqq/KD19F9F9pwlVsozywlhj4z+VQNJOckd+PLoRYJ7p7C/0NZdkoXuxWB3uob++03wNyu+KJ2C8inFZP6hs2K0nccMaI+FsnZKN/aBWibWworVGUUpTTrtXMxDJ/fSosI0S9nYeZrJ5x1LWauLtIFtmCLnC7eCf28nzxbzod7uFrV7MP7ubJju41YddqWL+8PP7GhSG2KpCqDptOHWOA5SJBybPWAJjJEOF6m/JzURy4M1Xwl/KLu8GocEFiGYCDk5aMLueW4YeOKZQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(6916009)(966005)(81166007)(356005)(186003)(16526019)(86362001)(54906003)(316002)(336012)(82310400003)(36756003)(36860700001)(5660300002)(70206006)(2906002)(70586007)(2616005)(1076003)(426003)(83380400001)(508600001)(6666004)(26005)(44832011)(47076005)(8676002)(8936002)(7696005)(37363002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:11.8299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34407f5a-0476-48d9-c2bc-08d99a3c8209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3504
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Define a helper function to find the interleaving mode. Define a
DF2-specific function now. Future DF versions will have their own
functions.

Use an enumeration for the interleaving modes to give a human-readable
value. Save the interleaving mode in the context struct, since this will
be used in multiple functions.

Multiple interleaving modes support hashing, so save a boolean in the
context struct to check if hashing is enabled. This boolean will be
replaced with a function pointer in a later patch.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-10-yazen.ghannam@amd.com

v2->v3:
* Was patch 9 in v2.
* Updated commit message.

v1->v2:
* Moved from arch/x86 to EDAC.
* Add new function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9d49e4a91931..bc0ec36fe5bb 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1049,8 +1049,16 @@ static int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo)
 	return __df_indirect_read(node, func, reg, DF_BROADCAST, lo);
 }
 
+/* These are mapped 1:1 to the hardware values. Special cases are set at > 0x20. */
+enum intlv_modes {
+	NONE		= 0x00,
+	NOHASH_2CH	= 0x01,
+	DF2_HASH_2CH	= 0x21,
+};
+
 /* Use "reg_" prefix for raw register values. */
 struct addr_ctx {
+	enum intlv_modes intlv_mode;
 	u64 ret_addr;
 	u32 tmp;
 	u32 reg_dram_offset;
@@ -1059,10 +1067,12 @@ struct addr_ctx {
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
+	bool hash_enabled;
 };
 
 struct data_fabric_ops {
 	u64	(*get_hi_addr_offset)		(struct addr_ctx *ctx);
+	int	(*get_intlv_mode)		(struct addr_ctx *ctx);
 };
 
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
@@ -1070,8 +1080,26 @@ static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
 	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
 }
 
+static int get_intlv_mode_df2(struct addr_ctx *ctx)
+{
+	ctx->intlv_mode = (ctx->reg_base_addr >> 4) & 0xF;
+
+	if (ctx->intlv_mode == 8) {
+		ctx->intlv_mode = DF2_HASH_2CH;
+		ctx->hash_enabled = true;
+	}
+
+	if (ctx->intlv_mode != NONE &&
+	    ctx->intlv_mode != NOHASH_2CH &&
+	    ctx->intlv_mode != DF2_HASH_2CH)
+		return -EINVAL;
+
+	return 0;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	get_hi_addr_offset_df2,
+	.get_intlv_mode			=	get_intlv_mode_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1136,7 +1164,6 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	u8 num_intlv_bits, hashed_bit;
 	u8 lgcy_mmio_hole_en;
 	u8 cs_mask, cs_id = 0;
-	bool hash_enabled = false;
 
 	struct addr_ctx ctx;
 
@@ -1157,6 +1184,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (get_dram_addr_map(&ctx))
 		goto out_err;
 
+	if (df_ops->get_intlv_mode(&ctx))
+		goto out_err;
+
 	lgcy_mmio_hole_en = ctx.reg_base_addr & BIT(1);
 	intlv_num_chan	  = (ctx.reg_base_addr >> 4) & 0xF;
 	intlv_addr_sel	  = (ctx.reg_base_addr >> 8) & 0x7;
@@ -1184,7 +1214,6 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	case 7:	intlv_num_chan = 4; break;
 
 	case 8: intlv_num_chan = 1;
-		hash_enabled = true;
 		break;
 	default:
 		pr_err("%s: Invalid number of interleaved channels %d.\n",
@@ -1286,7 +1315,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
 	}
 
-	if (hash_enabled) {
+	if (ctx.hash_enabled) {
 		/* Save some parentheses and grab ls-bit at the end. */
 		hashed_bit =	(ctx.ret_addr >> 12) ^
 				(ctx.ret_addr >> 18) ^
-- 
2.25.1

