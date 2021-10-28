Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CCF43E7B5
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhJ1SBO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:14 -0400
Received: from mail-co1nam11on2058.outbound.protection.outlook.com ([40.107.220.58]:52489
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231335AbhJ1SAu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Im6w3VgTl53KxxW/bEQoh0hTkxkTHpaSWxqWauHUa2c1TWT8EAMm6SjPxktgcx1mHu2+TUnSb/fpCZyMVMcLSsG4iHVn6zsysysOheXYexAOZSkT3k4y4l62DI/ypQuE6lK1APcCSerxCIHv3OWjpzcc9ikgTlcd4rHpL4d86cdn95r+FdoWrR7WA0Q3ORXP7yGVtuP7ZjBwfOIJNrHH1gkK6LC67+kqrfWu2U/Fy3KuTkS3/wOOFxQpEGicRsJ+4x8Vutm7nexuPMtQ/dUNOgPATyZpi6DaZbI+qbVWru9ZUUGZSvD/Al2+6KQgYvifi6I1TWaySZ6TNhxV7ViG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IMYpyfFfg9RzW7wLxQnUFzbNho5eiBOXIYnyJOof68=;
 b=XU82MCidi0mos7DVSf1waHXw7Tmv/EYvAF/CnuqprJ5pJerTLxN8zq7GW7I+077zteIt0Yg687WATmrRBU3IrvAOf/l/nZhgSdq5+oIfdUk/LFtfK6iowVB5f1vxw2p8mxoRR1MmCQnFisYpmlTK6PL3x3eHI4tgiRuwaFZcXH+WmtPPI9IIWc3hofyYnh/GAtaIn78t202Wo+2np8Xs7FbW04PeuKJT9gBiZScC6ryulDVaoppfJSY7UFRI0w4JRgf58I1d6CCxYNyrp8lawHs1UPuOSY4pHryNAMqJdrw3gOH6n1RtSlo5TGvGOQ2T2fnXJRWupG0xAg8Lck8zOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IMYpyfFfg9RzW7wLxQnUFzbNho5eiBOXIYnyJOof68=;
 b=U70yY0TAVJd2cUKEaePrp8K+1wYVLs67tULzdmG4plBWgZa5Dojg5CA57zdACufKOKAgBX3y7P5I+QKtiCY5PoIobALbFfShFp1JQfBSs5BfGXYA7HdFy15OcLS8X6t055444rFbwHO6/C+r/wbsU3adeljv2469UVFoH+TKnLs=
Received: from CO1PR15CA0106.namprd15.prod.outlook.com (2603:10b6:101:21::26)
 by MN2PR12MB4605.namprd12.prod.outlook.com (2603:10b6:208:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 17:58:18 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21::4) by CO1PR15CA0106.outlook.office365.com
 (2603:10b6:101:21::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:18 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:15 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 11/33] EDAC/amd64: Define function to dehash address
Date:   Thu, 28 Oct 2021 17:57:06 +0000
Message-ID: <20211028175728.121452-12-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 453883a9-2e35-4dfb-d21e-08d99a3c85c3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4605:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4605286E0B0EE22977727F75F8869@MN2PR12MB4605.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrTt4YenkiAjNKzoMRZhuCjuDq8ISeDA2KyBEEG1lyw+htnFJuIDb0N5+5Wiv4Znn+HN03hz2Oe1Ot7nJWKC/GUOqnpwGKIgH6U9/mAFN47rMUvpoBAkTtpLoqaSHANytjl261JBqO6z97K0v0VBu8tQmTSCFRKVzNLytye+g4RitVQB0H3bil6v4MHzVDLxLQiSwh9q6wCFU2+ciP7Ip/cT6K6+w1PqRs4iInPRx85JioBtm5UPkkGfC5lLhemmRGWknkB2b7YKtlk8N/feXjhOcFk+IlAC1H8mz415daKFKxM0OlmdjuOndbP30UWSgITWy+DRT5Y3GsjnIS44T+i5Jm1HqaU0YKQReY5fErHoWrm3FRKwZ/bj0VRmo7vUPbhSzXeJTGZni0Ncw39SU6Z7IxDGqVaH0fOW2HNC4RoUORy/tuE1EcbN8cmm4/vjEyVM9aY4uiitAZSkXCx47drgf4tTR2iAVCPBRNaGtnd/VJFM7+NjQBEfJyTI00IvT1kTZ2q/Ow064x/Qc3BxyN1DyrGNx3Hic9Ut7WhXAfaWdg6wCfPMfzI4t8LVVW+DPxINfzotlJNwHPgX9j52W5L5rrkSa7t8BCl6KVfEFc0/MjKwQTnsB6BR3KypaVGmdNOHSFFF9Cvtn+mXes0O5H8KpjIAbW9uosKtB1rNNUD8N+hw5FwqIHfteRtPfxar0UQqlsIQoLnzShQCIAwbcfgEKJaxCL4YC45L5Jq3+ZYYGt51qJwUSSNmZo939T2BIM73putJc8kG1Z26jOnOURsABu3452H7nX2cTvAC/iZ47QvXB79MEqrKPtxxs9Wk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(81166007)(82310400003)(356005)(26005)(2616005)(966005)(426003)(336012)(508600001)(1076003)(36860700001)(83380400001)(54906003)(8676002)(316002)(5660300002)(8936002)(44832011)(47076005)(186003)(6916009)(2906002)(7696005)(70206006)(16526019)(4326008)(6666004)(36756003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:18.0955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 453883a9-2e35-4dfb-d21e-08d99a3c85c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4605
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
https://lkml.kernel.org/r/20210623192002.3671647-13-yazen.ghannam@amd.com

v2->v3:
* Was patch 12 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.
* Add new function pointer in ctx struct.

 drivers/edac/amd64_edac.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 64d894d7944a..d7a2f621fdc0 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1069,7 +1069,7 @@ struct addr_ctx {
 	u8 map_num;
 	u8 intlv_addr_bit;
 	u8 cs_id;
-	bool hash_enabled;
+	int (*dehash_addr)(struct addr_ctx *ctx);
 };
 
 struct data_fabric_ops {
@@ -1082,13 +1082,29 @@ static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
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
@@ -1303,7 +1319,6 @@ static int add_base_and_hole(struct addr_ctx *ctx)
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_limit_addr;
-	u8 hashed_bit;
 
 	struct addr_ctx ctx;
 
@@ -1335,19 +1350,8 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (add_base_and_hole(&ctx))
 		goto out_err;
 
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
-	}
+	if (ctx.dehash_addr && ctx.dehash_addr(&ctx))
+		goto out_err;
 
 	/* Is calculated system address is above DRAM limit address? */
 	if (ctx.ret_addr > dram_limit_addr)
-- 
2.25.1

