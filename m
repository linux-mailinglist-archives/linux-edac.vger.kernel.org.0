Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7182649ECA7
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344187AbiA0Ulx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:53 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:50912
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344130AbiA0Ulp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cu172d39rSmtzXtjdCMFt/jhOWZb6d9NuXxZ+ZmzuWn7crPL9KI5VJyjKWOMFG2634z3QTAM8+MbQNQEvjEZMGRet3EWkwy0GJcOkqi/PPlEmQIe18e6QWdqt2Odknl9PFRtYM0hLZV9vSvsadVMFQkC/baKPlQiEk/vgj72zZSGQEHZ9Lye5GlYMWwXuJ7VU6HuF7S6n6J/jZjkwZfuzGJJrleFgBNg6GEK9qUh4HX3bYKhysgh/4qQyfC8SVlFwRD7QvAWDYKTfs2mr+U2eTYGY+Jv/lt1sZ0UKGOZf+ApBanK+89x20bCYGx/8oJT1rOltng3qMI78Plh9YFqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIItoB4O5A4fequkqbJr7XycrtyOwA2kp2GXm2APyes=;
 b=iILl3pb5oTxALpWrdc3MLy+Qr49/x8BZSETwAqCQu4rvmU9Q8HcGbkTdTKR+NcgBtASZJNaudnDXfu1p88YW4ppzK0yRpIidvo8Ygm4VrRQFJjsuumtybvL8I+QWHF4sYFX/gKBmgJd7Rv8PbQz7vhH1tBTqQgjNUPzVm6uhDbTAoVjsSBhjVa+wgamN/vT5l2EVFwHVLOalkGpJoXG6MQkpFJjKBHP1PQGNPNYTqjz8L9/XTDS5qQ6xZU544NgsT2vIDp7gLy6bb989IHxYci07PnBsrC12igEH7M5aejsfkb2fPsucZiGXUamGKuJRySLouorXPRwJtDwXwwTLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIItoB4O5A4fequkqbJr7XycrtyOwA2kp2GXm2APyes=;
 b=KSlKw8IbwD7KNAezs4Mqs8/v8tvittzLNDDoH9EwMcVI8FF+cHlyZ/CvV8B+JAMbXzELzO+3MR2MkwTHGi5FoXtLho/bVyfoj2OH8Z6Ajj6x4D50G09ogoB7pugwId4z0NHi5nRfG/PdgYG0vcFhaUFMi7rJjUpridjCAa3haxo=
Received: from MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::22)
 by MWHPR12MB1199.namprd12.prod.outlook.com (2603:10b6:300:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 20:41:43 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::6d) by MW4P221CA0017.outlook.office365.com
 (2603:10b6:303:8b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
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
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:42 +0000
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
Subject: [PATCH v4 06/24] EDAC/amd64: Define function to add DRAM base and hole
Date:   Thu, 27 Jan 2022 20:40:57 +0000
Message-ID: <20220127204115.384161-7-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea53beee-c25b-436b-3414-08d9e1d56d7c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1199:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1199E6279A4B14C7AC2053FBF8219@MWHPR12MB1199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPKIJGjIs5DW7Z5CT2vARsYJdZQabSZzhUrXHTa2G6DIwHbQmNGHypKr0fjZP0l96wMFVcPSzNAF3VxT2so/YFCGwmV0AkVtwwzyA7HNEuYDKHTUEtVDtoli+pmXVqK+PV8VkfMT8SSWxmp3jSXR5k14okTMRFWjc8IlmYS0qHTy6WzzXbhL/lH5voCOTc9X1dTyE24iB7XWwld4lrLn9HweESllz8a5BmFcgfQ3h12Jmxh0FmJna/QJ2FCnBCTfo3a+K8VQR5+1XtwY9OaQgcN5oregU3SCA+xuYqhCI+Ip56A+iZNWb+pLVgT1P4+WbQTUPZ75FR3Ui40x1UoSIUQcJIbAp/jy//POtLGSeWO7IEDNzdXuoyFMWKDzfBhixHlRDhAm/+Z6Q5elcYS6NtK2IlU2flvzhNkB4w8/rE1emcYfWxGXqMg4UmYcrxZw5zZfsu9Qbg3YUjO6Hll4zoutzWQ0whPntLzJ2XiomQRYDtLX8fPs2qRxM29dFyamtVUY3k6ZzZZ/hRaDa0+iNCcPORJ2mXijvEBjvx1ArrhuUJH9r4yXscmIc6G+JJzn43RsAbDaJzQXuFvKkIvE5G09+QVrS91LqMvO0wP6KfXJtpFZvT40T4qkQMz0iVYI85w1IVUUHwUkyzPeLkJc3CtTBpst3LBE79hnkDooVv+sF5OnJ1vikXt5i9melO/BijOBRbcliKCNccm8d8hpt6K3gbWNnmwXyqkWk7EsE82NNpfFPAQb6QkhtnZcs4anIXjwActNr5UfN5vHAi/ylVLQmtMyc3WZG/snA6Vkaqk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(44832011)(82310400004)(2906002)(83380400001)(8676002)(4326008)(36756003)(70206006)(70586007)(8936002)(2616005)(186003)(426003)(336012)(1076003)(16526019)(81166007)(26005)(86362001)(36860700001)(47076005)(40460700003)(356005)(6666004)(7696005)(508600001)(6916009)(54906003)(316002)(966005)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:42.8900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea53beee-c25b-436b-3414-08d9e1d56d7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1199
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move adding of DRAM base and hole into a separate helper function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-11-yazen.ghannam@amd.com

v3->v4:
* Include pr_debug() on failure.

v2->v3:
* Was patch 11 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 43 +++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9c61e3fa231a..350204eadb27 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1288,12 +1288,32 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	return 0;
 }
 
-static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+static int add_base_and_hole(struct addr_ctx *ctx)
 {
-	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
+	u64 dram_base_addr = (ctx->reg_base_addr & GENMASK_ULL(31, 12)) << 16;
+
+	/* Add dram base address */
+	ctx->ret_addr += dram_base_addr;
+
+	/* If legacy MMIO hole enabled */
+	if (ctx->reg_base_addr & BIT(1)) {
+		u32 dram_hole_base;
+
+		if (df_indirect_read_broadcast(ctx->nid, 0, 0x104, &dram_hole_base))
+			return -EINVAL;
+
+		dram_hole_base &= GENMASK(31, 24);
+		if (ctx->ret_addr >= dram_hole_base)
+			ctx->ret_addr += (BIT_ULL(32) - dram_hole_base);
+	}
+
+	return 0;
+}
 
+static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+{
+	u64 dram_limit_addr;
 	u8 hashed_bit;
-	u8 lgcy_mmio_hole_en;
 
 	struct addr_ctx ctx;
 
@@ -1330,22 +1350,11 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		goto out_err;
 	}
 
-	lgcy_mmio_hole_en = ctx.reg_base_addr & BIT(1);
-	dram_base_addr	  = (ctx.reg_base_addr & GENMASK_ULL(31, 12)) << 16;
-
 	dram_limit_addr	  = ((ctx.reg_limit_addr & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
 
-	/* Add dram base address */
-	ctx.ret_addr += dram_base_addr;
-
-	/* If legacy MMIO hole enabled */
-	if (lgcy_mmio_hole_en) {
-		if (df_indirect_read_broadcast(nid, 0, 0x104, &ctx.tmp))
-			goto out_err;
-
-		dram_hole_base = ctx.tmp & GENMASK(31, 24);
-		if (ctx.ret_addr >= dram_hole_base)
-			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
+	if (add_base_and_hole(&ctx)) {
+		pr_debug("Failed to add DRAM base address and hole");
+		goto out_err;
 	}
 
 	if (ctx.hash_enabled) {
-- 
2.25.1

