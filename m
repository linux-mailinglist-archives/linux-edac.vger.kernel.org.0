Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02F049EC9F
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbiA0Ulm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:42 -0500
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com ([40.107.243.73]:3035
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344106AbiA0Ull (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFlQs9WSFVdB/Fw98vgTcn+MyRzuLxHRTiRxrRFjgcC7MMjcjg2VqHuIz23NbCAp8t74QBuHGHA4y/ZeB9p9D7MJje9fuUpg+/hlWkX7BvefrlFAN/3sBEPmcUT6ngLNP/OmHY4XmAgGrHtE1G9ae3oFehxFzhRtyjMgE8EIkwXYyUavjeyOM/VXgLnbJvRWyrU0z5FYQO3MtVGjvEfqJqsBFSXI+VgPhxDM3FaEskXgytaNftWUstUYAoitdj6CJvkNLktn1nmO9wyXOaB84o8v1jgZRlwNJ4t8Yy9ZHTleiW6+rrm1JU2uI+jMwA9zLkU6CDeuZN0dJyQo7P5nNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkILAmsQ1oRocp91pKDg0qMnUaq4snl4/KvM3FKpCVI=;
 b=bxCafin1ccwKKfgrL3nboxN2gXFofabcMsGPMf4jjKPQIc5gZAs27FjMGjjlTz+xy8WA8tjHmK5cHcahUzPr7HE0H+ZmA4JmpbnJVXoUTr76fq+S8DsrLioW5AM8PKwCKCXvkl/t/K23LZf9Bhw/dtblcNWlc8ntRbFQ2Es/acFLyvkmxYD2ZOejuiYfu9Bh2IJqQnsQ5f87WizsipFrJmbGMXgYhX9WJgBtJM9FiVYGrPujnsaDZLBg6qDUcA6+voZX1/QH0zGP67fN/DrYzLFTpyulv/5LwLskb/PRKt7Xmt1wjXuRkyVCf4ZqE96H0lRPmVbZ5W114yIogg4K9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkILAmsQ1oRocp91pKDg0qMnUaq4snl4/KvM3FKpCVI=;
 b=il9RtIujKbguQdEP16VGql/7TzpMMFcSU9De2GYxYISEGPMKm9uypYPwNEfmWdE5xX8O8JxauU8XwwKZVKMsGNlJvRi4j0DFJ2IoMk5pH54or03YIJhmJ5RIKWRrkVGc1PAD6RmwGKOBi0pcZN2MLETtfy4SpuMhQAvb22VAb+E=
Received: from MW4P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::6) by
 MN2PR12MB3694.namprd12.prod.outlook.com (2603:10b6:208:165::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 20:41:40 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::da) by MW4P221CA0001.outlook.office365.com
 (2603:10b6:303:8b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:39 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:37 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 03/24] EDAC/amd64: Define function to read DRAM address map registers
Date:   Thu, 27 Jan 2022 20:40:54 +0000
Message-ID: <20220127204115.384161-4-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 02362252-403b-4855-dd5d-08d9e1d56b95
X-MS-TrafficTypeDiagnostic: MN2PR12MB3694:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB36941B8B4BEC6F8FFE4F0693F8219@MN2PR12MB3694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNmgHyVrt2quL82bFB/qGqgx2X8SLMUMIWGpa06l3EzJzyzw5WBWys+pOAV0CtYKrPwBjCiYymZmjxNuBTfz2c5KEldxfjjo+F++FxoNF6DrXd+MiUvcx5eK0sG1jr0aZjK9e0LJ1L1ZE8eBFhiHz5OxHff8qbhwSnPNuF9k1kBABJGHouLWD5kuxCUpGBcD7k8WY7phLQvo1YS8kgqT83dAdYLCCikat6MAifqfqpVOgLSThj7lANzfGZFNBqNIfgpswz8jmdosahGT+ywr1Ni2ulmCtm8+Ak/Xjf3owvHpv34HQ7KEsWqRHHq6wq7QllHos6XGNW4Im4dU79NCq3fvj8wAXe4wcMTTKk2zCzCT2xN1BDJjx/SNk+VpLKUdRfXeDxGtD+/PEzWl8j18+FczN2zQqalkNYe8eUY+Z6AgNNIcWtKoyzVZvzYm69Nsec8Gr6alhMMHd3D3jwV0eGSZ47ELZpL7oEGeNB3VD6KW8HvLpSC1fVkWHq1JIE6Yb2imA4WkcBoi91wrGXMoueqm7L0pgdpJTqGKIzajDkqXSGmGPck8YXMx6/tHmUIdj4S+P6NE6H7ZJVm1WYpeG7tLbqbUE/xm1yOLsdGX0d8l6XuBeOBMkTY+WSe5Hh/of0O4Jf3M1dOnEKYmMvwEgZYmixaDcE4n4yjShFA4BtlEHa38/UIJQJjn6G5haLI7JwmIgt8WWJ4T7nHNX8RQ6BKaRBQe9o/4L6UrR/8f1mruU/3qGi/7gIPy34xGQJ1hghsvfsUpK6rH/szAPtaAR454h5N4qNGL3I/XPHHFRy4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(8676002)(54906003)(44832011)(508600001)(8936002)(36756003)(86362001)(966005)(40460700003)(316002)(5660300002)(6916009)(6666004)(7696005)(81166007)(83380400001)(356005)(16526019)(36860700001)(82310400004)(70206006)(26005)(70586007)(2906002)(1076003)(4326008)(186003)(426003)(2616005)(336012)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:39.7028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02362252-403b-4855-dd5d-08d9e1d56b95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3694
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move the reading of the base and limit registers into a helper function.
Save the raw values in the context struct as they will be parsed later.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-8-yazen.ghannam@amd.com

v3->v4:
* Include pr_debug() on failure.

v2->v3:
* Was patch 8 in v2.
* Dropped "df_regs" use.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 51 ++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 837bca7eb1ff..d1af1ce716f9 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1062,6 +1062,8 @@ struct addr_ctx {
 	u64 ret_addr;
 	u32 tmp;
 	u32 reg_dram_offset;
+	u32 reg_base_addr;
+	u32 reg_limit_addr;
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
@@ -1113,6 +1115,27 @@ static int remove_dram_offset(struct addr_ctx *ctx)
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
@@ -1145,21 +1168,15 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		goto out_err;
 	}
 
-	/* Read D18F0x110 (DramBaseAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * ctx.map_num), umc, &ctx.tmp))
-		goto out_err;
-
-	/* Check if address range is valid. */
-	if (!(ctx.tmp & BIT(0))) {
-		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
-			__func__, ctx.tmp);
+	if (get_dram_addr_map(&ctx)) {
+		pr_debug("Failed to get DRAM address map");
 		goto out_err;
 	}
 
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
@@ -1168,13 +1185,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
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

