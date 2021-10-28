Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D9F43E7A9
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhJ1SAt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:00:49 -0400
Received: from mail-dm3nam07on2065.outbound.protection.outlook.com ([40.107.95.65]:63520
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231248AbhJ1SAl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCFcX0Tw/tmZE1t7pykMUqlrJdEC28IQcvv5IxWAVxu93WLdEB6p5RaG7eckuApkV/C+GsSVluk1VhpNykPkheLXIE4bYVv4c/vs6rPrQWITDKVUN6wNAQquNczibB7bqiQeEnCx3xB+39GKyoIPq7vjRAIGTGyXD45Htzlyk0Jo/zxzXcrSWAorTrZibhmM0v9r4OPX3Z71/gNb6OwNrBtAL7DaK4YrouZZ4r71kKRrQG3MV3s8nl1PrJVb2JzNncqhJbeBJnDP3TOtIEbemfAL+Cnog22ub8Rp+m0RilFF0s4X+CglrmcFUELMyrY1V4IOLzLzAjHMbgQldGmtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osN6zfV1MN03uiBoFXF2ohEC/2mF4o04ShgzF5Y+5Ec=;
 b=bF/hEagb2qNr6dt7ZLqL2Qy8BUKV3J0R5N2VxzajbeGLwdCKW4+3Ss87i2TlUySRrS10Dh/KDYRrmd5Pl+lOts5C1xS8Zlzt2ELj+tfJfqpbNgmiRJQa49HrbRWCnfeKv8b351Zt3RVTcusYdNsuYMBc01v7OZURDs6CAHlI6QDJRpeUAuLITCpXEl/nsYs2kFoMAn2ffo65PO8If5rLeA3QaFE96smObQsaiJkQYlx6eoV7HBT3IDVc8YepaBoBhI3p0MFBbFwkgikQscw1kIdIqTl5LvlalYJ1dNXmltcZt/Gx2QpKwOve3Bs5FUkdVJtBYFX/pf/yXy/E1y/gEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osN6zfV1MN03uiBoFXF2ohEC/2mF4o04ShgzF5Y+5Ec=;
 b=DroPRN5CqqfI8ZepqEVEzBatiA1A/aqZ6BX4nwrJDH4YAogm3D8GkpLHTY9l3gadrkx8jGuY+0Ny3mxAGRhBWQV4zRESIU17xzovaC15BgVcO6T+PPguuoLWL4mjmb5QMZAX9rRZrncd4LP/suP2ECquZpehxZg/RlVx3m3F/Ww=
Received: from MWHPR2001CA0002.namprd20.prod.outlook.com
 (2603:10b6:301:15::12) by BL0PR12MB2419.namprd12.prod.outlook.com
 (2603:10b6:207:44::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Thu, 28 Oct
 2021 17:58:11 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::f) by MWHPR2001CA0002.outlook.office365.com
 (2603:10b6:301:15::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:10 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:08 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 07/33] EDAC/amd64: Define function to read DRAM address map registers
Date:   Thu, 28 Oct 2021 17:57:02 +0000
Message-ID: <20211028175728.121452-8-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c3756fa7-133f-4188-47b2-08d99a3c8120
X-MS-TrafficTypeDiagnostic: BL0PR12MB2419:
X-Microsoft-Antispam-PRVS: <BL0PR12MB241956C93F28B1D3849697E1F8869@BL0PR12MB2419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: II4fEZmO3mGu8kDFhR+0du4q4Ep01+aSPQu2uU2sOf2h0vxkd2jekq1PL6s4++nYx+2uROIztnc0mFLWrHi2BmUKfdoV2fApQkroFCWZJh3MWP2ZmgukNO53m6dBKnFpmWbHVcqPFxDZrkJ1r78wCUNV3i+xqmQm9ut9Al0jhW9gKAWYBXfEHWVw3I9jk+gpKyq7ABoY+95p62GZYw23qKw7McVkrod4h2SrheBBvsE+RTtFGKrRrteyzU5obRKn1cQpOJbZ/b2CUUrSTrcWuJUjc/a9WHVjQi3E48PY+FV75+poUta3Rxs4o7rRa9HB5WYfheI4kOiyw9kJ6G9ER1iUWG5panaGibIY/JFRq5ppQuHlFZ+Xpd935l7nA258SZ/sOsQfQjeTULq1/f+FyN5nJBj2kcDJhvKML1aYi9UysEIn+68+/skA8b3TAtAVWqvpMrbHxvadt/tKa39JBEEnEzPQbpNPmfMbvKhSYBIrN2vKfXTBYxEBH1UjynKE+DLgEqejV1Bg2DWgUWyuzsy0PbwTDnei66IoDQ8/rfzZNxa68/7VcCEHurbiTkB+yk4/slYP8e76E9fCi3vVS4dgXnYuylFOVYKNAgOjc898Np1pGs5haGA8ZGRFig39iXtq6wZ9N3cQxzIlTpnTfNLnv0FlzH9nAMHhujHN5wHQn0WTWPnClj86rnR0g4mEYlukVDc6qoC6thyPyU3tgpgjb1MDU7BhmeYzEEHA5IFf3YAB7v/wZPwAzsKBD9eVfidKjCUxSsiysOz6wR6ZUS6bDgZr+Uzv9alzLOuq5E/iyw8F38XNN5M9Gkg22M/f
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(966005)(82310400003)(81166007)(83380400001)(1076003)(6916009)(7696005)(4326008)(2616005)(36756003)(316002)(356005)(6666004)(54906003)(36860700001)(86362001)(47076005)(8936002)(336012)(2906002)(70206006)(44832011)(186003)(16526019)(26005)(5660300002)(70586007)(426003)(8676002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:10.2978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3756fa7-133f-4188-47b2-08d99a3c8120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2419
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move the reading of the base and limit registers into a helper function.
Save the raw values in the context struct as they will be parsed later.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-9-yazen.ghannam@amd.com

v2->v3:
* Was patch 8 in v2.
* Dropped "df_regs" use.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 51 ++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index d7780e570fd0..9d49e4a91931 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1054,6 +1054,8 @@ struct addr_ctx {
 	u64 ret_addr;
 	u32 tmp;
 	u32 reg_dram_offset;
+	u32 reg_base_addr;
+	u32 reg_limit_addr;
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
@@ -1103,6 +1105,27 @@ static int remove_dram_offset(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int get_dram_addr_map(struct addr_ctx *ctx)
+{
+	/* Read D18F0x110 (DramBaseAddress). */
+	if (df_indirect_read_instance(ctx->nid, 0, 0x110 + (8 * ctx->map_num),
+				      ctx->inst_id, &ctx->reg_base_addr))
+		return -EINVAL;
+
+	/* Check if address range is valid. */
+	if (!(ctx->reg_base_addr & BIT(0))) {
+		pr_debug("Invalid DramBaseAddress range: 0x%x.\n", ctx->reg_base_addr);
+		return -EINVAL;
+	}
+
+	/* Read D18F0x114 (DramLimitAddress). */
+	if (df_indirect_read_instance(ctx->nid, 0, 0x114 + (8 * ctx->map_num),
+				      ctx->inst_id, &ctx->reg_limit_addr))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
@@ -1131,21 +1154,13 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (remove_dram_offset(&ctx))
 		goto out_err;
 
-	/* Read D18F0x110 (DramBaseAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * ctx.map_num), umc, &ctx.tmp))
+	if (get_dram_addr_map(&ctx))
 		goto out_err;
 
-	/* Check if address range is valid. */
-	if (!(ctx.tmp & BIT(0))) {
-		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
-			__func__, ctx.tmp);
-		goto out_err;
-	}
-
-	lgcy_mmio_hole_en = ctx.tmp & BIT(1);
-	intlv_num_chan	  = (ctx.tmp >> 4) & 0xF;
-	intlv_addr_sel	  = (ctx.tmp >> 8) & 0x7;
-	dram_base_addr	  = (ctx.tmp & GENMASK_ULL(31, 12)) << 16;
+	lgcy_mmio_hole_en = ctx.reg_base_addr & BIT(1);
+	intlv_num_chan	  = (ctx.reg_base_addr >> 4) & 0xF;
+	intlv_addr_sel	  = (ctx.reg_base_addr >> 8) & 0x7;
+	dram_base_addr	  = (ctx.reg_base_addr & GENMASK_ULL(31, 12)) << 16;
 
 	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
 	if (intlv_addr_sel > 3) {
@@ -1154,13 +1169,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		goto out_err;
 	}
 
-	/* Read D18F0x114 (DramLimitAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x114 + (8 * ctx.map_num), umc, &ctx.tmp))
-		goto out_err;
-
-	intlv_num_sockets = (ctx.tmp >> 8) & 0x1;
-	intlv_num_dies	  = (ctx.tmp >> 10) & 0x3;
-	dram_limit_addr	  = ((ctx.tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
+	intlv_num_sockets = (ctx.reg_limit_addr >> 8) & 0x1;
+	intlv_num_dies	  = (ctx.reg_limit_addr >> 10) & 0x3;
+	dram_limit_addr	  = ((ctx.reg_limit_addr & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
 
 	intlv_addr_bit = intlv_addr_sel + 8;
 
-- 
2.25.1

