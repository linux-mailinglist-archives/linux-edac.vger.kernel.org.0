Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC86F49ECA5
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344149AbiA0Ulw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:52 -0500
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com ([40.107.244.59]:41440
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344135AbiA0Ulp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRCU/PGhHHhg1BQeCSz11a/p25yGtUjiXuU/xAIqnmRqO7dPGeITqkorkm3g14XhwP+Z3bdWnbWdqmPMtHbMBOUZ+APG2OfLWBxJ5iszuirIvClVDhaA/QXl/0aeHJUZXwf3bttKtFo0mFMwd8SuTQ8cHzqS/KeFi5cXdXruQehLPs4jELxmod3cczssnAQg0vVSIf/b00zxwrGEE5AHKBeg8fFEEtdT7e3/ANWY6vdsXzB5GCBC/uc5Ew+ma4TYCC6j36EUrru3haVulKUEwITDBil1+Q/Ly6AgWRokgNVdgGMDkWNZK7BOXxRvBVBwL/0cnqjfBg/wmyJf3B/dKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNjJjX8uuea18mo71qrUYE4EumvUeatpTW6zPu0L0EY=;
 b=VUDa/mMnypex8r4BJ2KpO5XIzKJA2cnw1wHtW91ggXMTPgSwwQLpzl+cGRENUONN07jcyjAAowYbEmXDJSOs3Tubcs6R7QDXXAUc9gH4bv+P0QOPrxHDbfDr8ErKCdYmA+PrjJqRZ4chUcCnBlpUIrKp0f2zDQWoxRDRvrDP6x5pCC2IUY7M7nPZGNAxmJGWhgeJIBBCvG2yzRiFYAKvDnTemcgZFXTKhYmm3G4HLuRlGQEjNwTIt62R1gGXPi6Mzv8V6tPXjQdzwRyegutO689Z617Y1GRjNW9vfdG6N6qAiH4HHpyZqPD2H1MnNhXYouEevmINVqsdVaZE0kx5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNjJjX8uuea18mo71qrUYE4EumvUeatpTW6zPu0L0EY=;
 b=rmmOo5MnIUukqukbtbHV0n92Hj0VVijn7eW3Y7T3JVZePs6/kryB94dk4zKnAIVIKq15DXTLENxKVV7oR8xhj+9rkCSllORs76DL/FGJKgjwt2E+uGOJ0ZtZhFGzaSY+/wW9VjpmpPdGTaGX0zl994cpJtsiYRLN7aTmUUggUN4=
Received: from MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::28)
 by MWHPR1201MB0206.namprd12.prod.outlook.com (2603:10b6:301:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 20:41:43 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::7a) by MW4P221CA0023.outlook.office365.com
 (2603:10b6:303:8b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:43 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:39 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 07/24] EDAC/amd64: Define function to dehash address
Date:   Thu, 27 Jan 2022 20:40:58 +0000
Message-ID: <20220127204115.384161-8-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4ca49c76-bbf1-4380-0727-08d9e1d56dd2
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0206:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0206E31C298D975B71527C5EF8219@MWHPR1201MB0206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJa2a1Yh4+cdnAKVDg9yW2sJ56YTvvaf5kGk47TwUH/ydHEKoUR3JZKoxijjSj2NHQPbSNMeBB6oJApvanDB+som9SzOjD7BE9ylG6WSyHWROs0V65uBcmHPZiBI0p3IpiC3VBoCy3hE4zxuKGshI51b5e94usD4SMBBlwIdppZcUhOFaAXFRPV9e7tgK5MWYEjx/5BMYk0RePpIskDBMSd7dSjZOuj5DF8b8YRtM/chkjox8LRnm3QwKx30VuDy7xGt8dSaKCceAyu8IbpTZP+nYub9noDsHZ7HOVSgFZOTyD9VfWzsW2rRRzbQyk7ejaSbMkiHfNCQ0n4XtLLgNlvgf+g9k0jHo9gSqnSlvUaVWYHd+O9mq+0keGptSeVy4kBAgJPR02p2QVHRD5Ap/UvMiQpCHu/KiPAT9LGZ/IGb9/8WEVJTh4HZlRVn41xp8Jgm5Rc2vnCKKO16q5XcM/3BPLJTgpeL2ejQkdOCcSK8B3gR7mNYXwoncX1E3mdQnEr/glUHY/ms4akeOsp8wjZJQDfO9cDahRLVNd5yKKtz07oh9TejP4gaNZ8ddfsX5GywwkTDurvm9xPG6rcqkR623vFPRT9xb0hs+TqR0UTdB8dY4mIpw+to9T0SqgFzCRxmLrZwD0fOaL9Vl6z98SAA18WvChrAFPjTjoHdv33DXHWy+1pymQzQDjIUPDhIKee8vYMYsnr2/3eQi8/jLHme+mgju0upMSUZXHS9hmDRZrUompmYZV9c0B07A4ddWGyuoHhnDx3/RRvq8em6AmXTx0HSHeRuBjVO9Ik9Uis=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(47076005)(2616005)(1076003)(6666004)(508600001)(426003)(86362001)(82310400004)(36756003)(336012)(966005)(186003)(40460700003)(26005)(36860700001)(7696005)(4326008)(16526019)(83380400001)(6916009)(44832011)(8936002)(81166007)(70206006)(356005)(54906003)(5660300002)(8676002)(2906002)(316002)(70586007)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:43.4525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca49c76-bbf1-4380-0727-08d9e1d56dd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0206
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move the dehashing code into a separate helper function. Define a
DF2-specific function for the current code. Specific helper functions
will be added for future DF versions.

The dehashing function used is based on the interleaving mode rather
than the Data Fabric version. So save the function pointer in the
context struct. The use of "df2" in the name of the current function is
only because the interleaving mode using it only appears on Data Fabric
2 systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-12-yazen.ghannam@amd.com

v3->v4:
* Include pr_debug() on failure.

v2->v3:
* Was patch 12 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.
* Add new function pointer in ctx struct.

 drivers/edac/amd64_edac.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 350204eadb27..da2d0d9ce406 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1077,7 +1077,7 @@ struct addr_ctx {
 	u8 map_num;
 	u8 intlv_addr_bit;
 	u8 cs_id;
-	bool hash_enabled;
+	int (*dehash_addr)(struct addr_ctx *ctx);
 };
 
 struct data_fabric_ops {
@@ -1090,13 +1090,29 @@ static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
 	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
 }
 
+static int dehash_addr_df2(struct addr_ctx *ctx)
+{
+	u8 hashed_bit =	(ctx->ret_addr >> 12) ^
+			(ctx->ret_addr >> 18) ^
+			(ctx->ret_addr >> 21) ^
+			(ctx->ret_addr >> 30) ^
+			ctx->cs_id;
+
+	hashed_bit &= BIT(0);
+
+	if (hashed_bit != ((ctx->ret_addr >> ctx->intlv_addr_bit) & BIT(0)))
+		ctx->ret_addr ^= BIT(ctx->intlv_addr_bit);
+
+	return 0;
+}
+
 static int get_intlv_mode_df2(struct addr_ctx *ctx)
 {
 	ctx->intlv_mode = (ctx->reg_base_addr >> 4) & 0xF;
 
 	if (ctx->intlv_mode == 8) {
 		ctx->intlv_mode = DF2_HASH_2CH;
-		ctx->hash_enabled = true;
+		ctx->dehash_addr = dehash_addr_df2;
 	}
 
 	if (ctx->intlv_mode != NONE &&
@@ -1313,7 +1329,6 @@ static int add_base_and_hole(struct addr_ctx *ctx)
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_limit_addr;
-	u8 hashed_bit;
 
 	struct addr_ctx ctx;
 
@@ -1357,18 +1372,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		goto out_err;
 	}
 
-	if (ctx.hash_enabled) {
-		/* Save some parentheses and grab ls-bit at the end. */
-		hashed_bit =	(ctx.ret_addr >> 12) ^
-				(ctx.ret_addr >> 18) ^
-				(ctx.ret_addr >> 21) ^
-				(ctx.ret_addr >> 30) ^
-				ctx.cs_id;
-
-		hashed_bit &= BIT(0);
-
-		if (hashed_bit != ((ctx.ret_addr >> ctx.intlv_addr_bit) & BIT(0)))
-			ctx.ret_addr ^= BIT(ctx.intlv_addr_bit);
+	if (ctx.dehash_addr && ctx.dehash_addr(&ctx)) {
+		pr_debug("Failed to dehash address");
+		goto out_err;
 	}
 
 	/* Is calculated system address is above DRAM limit address? */
-- 
2.25.1

