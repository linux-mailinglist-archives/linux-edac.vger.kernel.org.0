Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6DB43E7B4
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhJ1SBN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:13 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:4320
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230350AbhJ1SAt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEuChZCtiYz3pKcU9PgOZRTN3EKtHOAIwvYVzWMO4ruJ1RwIZi5di/FpRKeSQ8YVEsKV82Gj1FbDH/XKcmGNw+6dlV2GCD7iDhgzDyDSXfmH/LbP7TszkrWXf0fNRDw+IE3iRQ6+e+KOSk2YjC5E1Xx3Cnskb08zKkdJLAcDSEP451Wkj57u/lpoVnZYWlIzxNzjxrGhKSJrQ9HveLxRXzb8+lfPRWTUoCY6f/zGr0uFpIKIIx6pO3oKsIKfqto6VsGWX2pSMkw1RNNur2M/4wF2g85MgBvoYDXIM5LWm151p+osfnACCzRMGtkm0iDQZMeg2jLYOMXgoK9Nu3CyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W40OxyI64+iKz8Sct6DSICrgZptoWQb+GY2VylUBMvk=;
 b=hdJ2sX2E66239TE0dHoir7SXU8FjhaTSAVTUnbonZGf4tlb/ibRI9n/gEpnuicaOlzbQzdGcKjA4m3w0b7odgr/iAJtqj0wxMmfJlnXAkguMFEijrbA/z2RGZlr3QKN5v2+E/DTtxX+6bcicvbC6/P9oUcdAwiCWDm94ZNKfzS5ef/XeOas8TrAgOLMVkbJIJaDD1jSB2w3ZCsNApCfTsVrGfMKXF9x9pBdYXEF1lgD99H9AF0tUYEhkQ2BZmzE4aDdPoGtTf/FlCdEITtyJXqswiJv7AD2PMfZnTtZecDAccHIRcPLLtyt3KuPUnKdHz4k8o/lv7LGZqLP4oHMPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W40OxyI64+iKz8Sct6DSICrgZptoWQb+GY2VylUBMvk=;
 b=gFipbUFoYPywQI9A8tItcvFhCnnpzazXDIf0ZV5tgOhEty2oupIpWaMNZ6tioSiXbEBoFLqgPzdaLxSve5YJRyX83l7vy08S61HebFpJJ707XvV0NqB9UV+oglZX47SkgFRxHDz7amAj/KrAV7iusaLe3p+sW7vqF43Q3ZjhBzg=
Received: from CO1PR15CA0102.namprd15.prod.outlook.com (2603:10b6:101:21::22)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 17:58:20 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::85) by CO1PR15CA0102.outlook.office365.com
 (2603:10b6:101:21::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:19 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:16 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 12/33] EDAC/amd64: Define function to check DRAM limit address
Date:   Thu, 28 Oct 2021 17:57:07 +0000
Message-ID: <20211028175728.121452-13-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec87ffad-ba8a-47aa-0ad7-08d99a3c867c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5099:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5099183C3AE5EA0D0F05D526F8869@BN9PR12MB5099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: abAgYXsbLR+HBpxehYPhJe5iq9HfQcKuI7XK7IP2jOjYNRb4u7ErjnYrw/poUs6Fud97n2O7puEgc8imdXlKCnkeeOnU/G0oWKYV8BC7etcBahPlY5mPiSTlt/U+xNQ4YFPFUiDippqpmwAPv8Bv6ImuC1U4SsJcfOc6y/xOo5wrXMATJaTpc/pU2/plpSHsp1OIsA3mh41mXsVkr9eQXI9U1QwTLMv83eWz+mR+dX7YwnTBr5evTqtifUzyz1ecMZ24XAUPuC6uT6LK0LPi32doUnXAM6a1Bng7aljA1meeWoYrX97TrZcaekhvkxUjku/i5IMn3mmZ0nK9Ao9SrLJAA3GZsZot9/hpLY9R8v1jsF07FJzJ51oI7yIlVxRHemdyZs4DnCSnX8nf5Il8QY0J5EPEeZ4U/UVwhe7QD5ZJjJsnzK5sTIq9VMHB9VcBn9w+NQWFkrMoc3E4/SuPQ+xdO1c3Y0VL+j2WzKF2O5nQ2v0b3XaOGOPrUyKzjuzp+2SOV04cNlCfgA2YcoHnzpSLlXg7djpX8gPjNY1mN3m+B0uiv/DtPeraNCpicJTGfRmWWIw8XPWbJn9UVOXGWl8ruZvWj4Q37HQkyk+QxFvp/tgaf0jmn6CnUfr/06v6cGr8WEAY/QUPqEBnDcaNMs1hppK6Z8+e93oarNyMBTJNwlKmK0Z2OzeF/J8LjUuIzyDjoFjm1Dl+aF22OfJ8bjL6/284P77cjEIqTuEdtt0zkrCwKWCjqToqNk5qDglzU7m2TYQ93YETLsuTvSYUobn42kjtkatdfRmQnsqrnjrlKwsBXzcMsj4qh4HZh6Ko
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(44832011)(8936002)(26005)(5660300002)(82310400003)(2906002)(36860700001)(6916009)(86362001)(356005)(966005)(83380400001)(186003)(508600001)(36756003)(426003)(54906003)(81166007)(4326008)(70586007)(70206006)(6666004)(1076003)(7696005)(8676002)(16526019)(336012)(316002)(2616005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:19.3038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec87ffad-ba8a-47aa-0ad7-08d99a3c867c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move the DRAM limit check into a separate helper function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-14-yazen.ghannam@amd.com

v2->v3:
* Was patch 13 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index d7a2f621fdc0..b0bf9dd0ba34 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1316,10 +1316,20 @@ static int add_base_and_hole(struct addr_ctx *ctx)
 	return 0;
 }
 
-static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+static int addr_over_limit(struct addr_ctx *ctx)
 {
-	u64 dram_limit_addr;
+	u64 dram_limit_addr  = ((ctx->reg_limit_addr & GENMASK_ULL(31, 12)) << 16)
+					| GENMASK_ULL(27, 0);
+
+	/* Is calculated system address above DRAM limit address? */
+	if (ctx->ret_addr > dram_limit_addr)
+		return -EINVAL;
 
+	return 0;
+}
+
+static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+{
 	struct addr_ctx ctx;
 
 	if (!df_ops)
@@ -1345,16 +1355,13 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (denormalize_addr(&ctx))
 		goto out_err;
 
-	dram_limit_addr	  = ((ctx.reg_limit_addr & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
-
 	if (add_base_and_hole(&ctx))
 		goto out_err;
 
 	if (ctx.dehash_addr && ctx.dehash_addr(&ctx))
 		goto out_err;
 
-	/* Is calculated system address is above DRAM limit address? */
-	if (ctx.ret_addr > dram_limit_addr)
+	if (addr_over_limit(&ctx))
 		goto out_err;
 
 	*sys_addr = ctx.ret_addr;
-- 
2.25.1

