Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF4143E7B0
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhJ1SBC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:02 -0400
Received: from mail-bn7nam10on2060.outbound.protection.outlook.com ([40.107.92.60]:26880
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231295AbhJ1SAq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNZitqiOxKqRiW2JDK8N8A/3vQ8V2799ORIZcIW8MQk7Q4Gd4HAcxK+d76ji0aIS2xZzikQ4cKCbrRUnPkgBWy/jOE4PRkGaBzwzqunTUAJeeo0zXJVAEWNkPu728JiNDIbUrWSCibdNk5/8Sz80uCUiIkjdGUrQ9jVgSBpaRgHXEQXDtX6Eyt/mnrTdYrkS7Z6qs/RVkf9bqdKEsTiO7vKOlMzZ//ICaDe/f0rRp8gypVOozwyvm1+e9xzDJcFKvM2XfyTZSQXeLE8+BS767arJaDnLQMhINOKAo+Nawid5S7S9CpwlrZLweHO+DsrscYauGCfLMvynKLxmx+nd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr5+9l+DMOaLOQ+LObHRNaM2G1An5Oxz5JUQCR4pG64=;
 b=DaMxqIZnwcXLZWSMT8WM+iQ6cVrjztz3gdigEAxh0F1WBEtex69zdEfsP6XVa079Q5hXh1K91ZpRqGDRWL7zwn0akO+oDRORGnKeTXpqCPf0XHx9QN7b2ytPrI0WkteAojwyZpj3bWAcAYuLYaRRExT2XDAUpiD0NOtdhhPJwvWb6i5Qjp1NZJ6QHiqyVXjGWfXTs0IkbocmGFGL3mHcf/eJUR1QiUNIhPMWQewhYWTxJDhSqE8vXLOfT9t795ZUUMsG3frcE+YFXwhSBtP+YWhMM8HtjYTrBMAhacb2GfCIQCU3udtEHO3+adrrcbLrBf7YzGN+Gxx1fwSTK48+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr5+9l+DMOaLOQ+LObHRNaM2G1An5Oxz5JUQCR4pG64=;
 b=vgLSRwBNHm7r8Ia6gDdcKILpZYsIemhPgh25igw7Jbr3PTqt4DJUT2UVwdJhyZXlGU8LbdQvcKdcBlAqOhhW/bfpGMQSzHU+j6m+43UTqkKKWBKNqRiZ2Ir1CSj7TsIY6eJZHWLAWpuz0j+P6oFcra2L3EQy7DN5T6K0YQ+xSQY=
Received: from CO1PR15CA0109.namprd15.prod.outlook.com (2603:10b6:101:21::29)
 by BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 17:58:17 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::12) by CO1PR15CA0109.outlook.office365.com
 (2603:10b6:101:21::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:14 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:13 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 10/33] EDAC/amd64: Define function to add DRAM base and hole
Date:   Thu, 28 Oct 2021 17:57:05 +0000
Message-ID: <20211028175728.121452-11-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: fe9da657-4987-473a-0aaf-08d99a3c83cb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5079:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5079AE450AF52F3EEF6445DBF8869@BL1PR12MB5079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zuIK2F7a/P9bUMsFKTopU6UkfylNzRUdedNYTudRy5mERIYrMaZh3P/v9ZG7Kjg+wbtH7huAbES1MfYBLKHorbqY1G1cuvNH9v4vcAkl6lrOFFj43E7k65XG0Z8r3GRWsUik8qzHwb5zjZjgG6n5k9E+Mtuz6YjmVSHHhtMbc7loE2u5nH7cmQvHv50LnH4QDwJU+S6XF7dCoxAYMH5YnQvDonWvR8WgX4JbbNeNQB6NJFCY2zcSHIllORs3LFs2zfTwjZkI6WOuXeWGfG8AdKc7Pu+qvPOvBKHtJVGj3IScPY/gtaQoXb/AeI8/omcw2Ku0dncE2tdffJ4Nky6Ao7o9AficBh0uhIKnf5hlHvKoZtALJeVQSk49hTCwhCqhRseKzeorG11d7ac3r7DOarDmU0DS2X20TLKhM9dXyYyzHk0qYzFpjkKj+cgGR2MNSPq5v8w04C+TeozOwNcXj6a7t57oevYwn2qKk55wjebnAzm/WZzpf8Z6WVUJWz1gPtv/e0dwBdrMr6Kihd3w0PApqHesjZxrQnBz12LrRlDORhxXOeqi6eaPkQQWUTCwd3BVIO/6gvAV8ktl8sCeQCs6A3+R/QpFogPEdOE3poPuAfT8MXyf8iSbOuepAC51BuLUWunH3g/eCptyJaU9DQwHUwk2dHqHgpSzawGDoeL6RUU3QqyYTU/PaFo+Tped0DTLrUO9xiM25E8D5gfx6r1MBPKL/vdPbjvihCn/vK8MtUuKKprnnjFPBij+zDrj5eTTEYKrsIVC5nWgFAv/fK/87uyI6QSEEV7EHI3C0NmnH+tEthv11F7x4/asfDKF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2616005)(8936002)(83380400001)(47076005)(336012)(356005)(44832011)(426003)(6666004)(5660300002)(8676002)(36860700001)(6916009)(54906003)(86362001)(4326008)(36756003)(316002)(70206006)(508600001)(2906002)(1076003)(7696005)(70586007)(966005)(82310400003)(26005)(81166007)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:14.7873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9da657-4987-473a-0aaf-08d99a3c83cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move adding of DRAM base and hole into a separate helper function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-12-yazen.ghannam@amd.com

v2->v3:
* Was patch 11 in v2.


v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 43 +++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b4b7c93a6390..64d894d7944a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1278,12 +1278,32 @@ static int denormalize_addr(struct addr_ctx *ctx)
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
+
+static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+{
+	u64 dram_limit_addr;
 	u8 hashed_bit;
-	u8 lgcy_mmio_hole_en;
 
 	struct addr_ctx ctx;
 
@@ -1310,23 +1330,10 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (denormalize_addr(&ctx))
 		goto out_err;
 
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
-	}
+	if (add_base_and_hole(&ctx))
+		goto out_err;
 
 	if (ctx.hash_enabled) {
 		/* Save some parentheses and grab ls-bit at the end. */
-- 
2.25.1

