Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F7B43E7A7
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhJ1SAs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:00:48 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:46176
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231244AbhJ1SAk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1P+Qg4cBGMP55GyceMMDVTmk0RkAyvXIzsTogbdJlgnIi9W0/f14SrbnSW8spBBRgd1AqHZ9Htn84KwPE+sd4MHPJaqhVc5i4pPhzIXkNe1C5hl4K9g55XFcNFAPmxE9OChwFMGkuG4yw22LNd7oK0PM/E91rI0hi47l6sOemVgs/0r8tFLwqOd2bEZIOu0VaetLDKEa5T1IYq40kA7EXLlesgjICI1BT/XSHUMy5gnTK+l+D+GeCPvO9OEo6XwCWxz8ImA69Mbowlfu4tq4JFty5XieWgIw7QwzxupSt34rsoIyBsLyqqgxQA2q8rBgVdfB4oreyGy/OaQAnPIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSPDosYIjuToZ7jK7FPvIcG5SytH3TKeUvi57zIJSMo=;
 b=fQBtWNQgVeRw8np/lPk2OmDCbseYEKwygPrhtG3bKICX4DEsqaQ+1wGZW5m9rL+n82DfQDNcjamgzze2A7dbU+ykpbOBndkRWX1/EIcLFiAsqsYvCsbi2/7dbqec/qYQKP7YOQw9zbXf9Qarq/rhBJ2HNzFZK4fHaP3dNwxU/OlmHooBQbfFXj5pzeonAYvW/gxPxvlBn0MKhmuw0WIYZX4lNizisxXLF7xLZfTalt8rv2tB+9MbZSw4LWwf2si3VCT8PwJrERTA95Ydn88UfGZhjfAXE3l2tkM0ohzcq7yu3wc390MgJn/elj8IEmzocFraVAmDiXAIAJ824vuT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSPDosYIjuToZ7jK7FPvIcG5SytH3TKeUvi57zIJSMo=;
 b=bZHMsV31x8PaVl65p/w5VQ3evb0lTNyJGI5up/emiHzGpYB4DSCNBunZH9haqoD56UTYVXFdgO3l9cCcF4qgYbLNPr2NVbjswXjP3smR83/cAjJoANZHYdFUckHcC+ENaXYS1hDx2ETilwyCXtyfGKhH3a2xAsecatywcNooHFE=
Received: from MWHPR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:301:15::13) by MWHPR1201MB2478.namprd12.prod.outlook.com
 (2603:10b6:300:e5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 17:58:10 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::51) by MWHPR2001CA0003.outlook.office365.com
 (2603:10b6:301:15::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:09 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:07 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 06/33] EDAC/amd64: Define functions for DramOffset
Date:   Thu, 28 Oct 2021 17:57:01 +0000
Message-ID: <20211028175728.121452-7-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4786ad81-9f34-4e51-3f8a-08d99a3c8098
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2478:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2478C1BB2D0C31230AAB414CF8869@MWHPR1201MB2478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cf8vGmm8dumyxvbCUPQO61mMGhb0UZZdlsfquUrksRS4BQtCCk6c5i2Bc6s67She90xJVF0EwuhlLUHFbG1GAYapb3kzpz2pPmCRhlA5lDt2Vl+iQCHavF4c12UunYem7EX9CvGr3Ic3tmZu5qIGUfp7iWlbE8eS67HLAvNmud92YeZW3r/5NBTqiC9w4VcOGxnQI76ZFI06cCqOnPDOdVDvLM0aBe/FUquLsW5xv7QDAqC2NY67nXVTTWfnqB8mMGoyWd7xJ1y4pcTWWttEP+TLgcyVBLSPgE0eixMx3+SKXkpqTfUOLuk3VWDz+xKXYgJHk/F2zuKCsiXlmu8bd9hVc0ZONXO4zjktuwnDCMxJBrsbAcqv8jR+YwcOstS3OReHtlYdOwKNqiY7q2DJsC86UfitRZ07snbZ0XxWHd1g7zbreYXlg8n0oI5QsdXvZX65iOQS1KcLStn6Zakg44Pf4TQcUDtoLOLAvlNIedEIa+tvzKNERpm7KC3TTer2h+5tJHz7wJB/MjzfbTjw29Khy5gr3mwfiPBGv3uPJG5Q+PaGyektWjsF9voRecpoTbjStNGlAUWIxn6IPhtBI3kK8fObMr6SpaVjGrkZVVgNEufqX5Z5xSrj8J5BQ9A8efRe9HFlhZPs2C4EzCza/Mo+OrToL8XA8jgOosuGH7CpHx+BIMWRLjK2Ys6LiShwG4EvdnXNo86iKDS0LYjmm8ZZGQZWn3jx5fMJjjBt63NsNrMXKtrKwM7qKg2+Cqi6mPhFfngsTKpBXENFvh2pcJjhcCXfuOLF1DKssiftBWxsH8ChWAB72dgC8dq8r8Vg
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36756003)(5660300002)(7696005)(4326008)(47076005)(356005)(54906003)(508600001)(44832011)(81166007)(316002)(70206006)(70586007)(1076003)(8936002)(6666004)(336012)(36860700001)(86362001)(2906002)(82310400003)(26005)(8676002)(83380400001)(6916009)(426003)(966005)(186003)(2616005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:09.3613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4786ad81-9f34-4e51-3f8a-08d99a3c8098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2478
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add helper functions to read the DramOffset register and to remove the
offset from the calculated address.

The helper functions will be expanded in future DF versions.

Rename the "base" variable to "map_num" to indicate that this is the
address map number. An address map is defined with a base and limit
value. The map_num variable is used to select the proper base and limit
registers to use for the address translation.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-8-yazen.ghannam@amd.com

v2->v3:
* Was patch 7 in v2.
* Dropped "df_regs" use.

v1->v2:
* Moved from arch/x86 to EDAC.
* Add function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 58 +++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f83f9813294d..d7780e570fd0 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1049,21 +1049,60 @@ static int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo)
 	return __df_indirect_read(node, func, reg, DF_BROADCAST, lo);
 }
 
+/* Use "reg_" prefix for raw register values. */
 struct addr_ctx {
 	u64 ret_addr;
 	u32 tmp;
+	u32 reg_dram_offset;
 	u16 nid;
 	u8 inst_id;
+	u8 map_num;
 };
 
 struct data_fabric_ops {
+	u64	(*get_hi_addr_offset)		(struct addr_ctx *ctx);
 };
 
+static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
+{
+	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
+}
+
 struct data_fabric_ops df2_ops = {
+	.get_hi_addr_offset		=	get_hi_addr_offset_df2,
 };
 
 struct data_fabric_ops *df_ops;
 
+static int get_dram_offset_reg(struct addr_ctx *ctx)
+{
+	/* Read D18F0x1B4 (DramOffset) */
+	if (df_indirect_read_instance(ctx->nid, 0, 0x1B4, ctx->inst_id, &ctx->reg_dram_offset))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int remove_dram_offset(struct addr_ctx *ctx)
+{
+	if (get_dram_offset_reg(ctx))
+		return -EINVAL;
+
+	ctx->map_num = 0;
+
+	/* Remove HiAddrOffset from normalized address, if enabled: */
+	if (ctx->reg_dram_offset & BIT(0)) {
+		u64 hi_addr_offset = df_ops->get_hi_addr_offset(ctx);
+
+		if (ctx->ret_addr >= hi_addr_offset) {
+			ctx->ret_addr -= hi_addr_offset;
+			ctx->map_num = 1;
+		}
+	}
+
+	return 0;
+}
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
@@ -1072,7 +1111,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
 	u8 intlv_addr_sel, intlv_addr_bit;
 	u8 num_intlv_bits, hashed_bit;
-	u8 lgcy_mmio_hole_en, base = 0;
+	u8 lgcy_mmio_hole_en;
 	u8 cs_mask, cs_id = 0;
 	bool hash_enabled = false;
 
@@ -1089,22 +1128,11 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	ctx.nid = nid;
 	ctx.inst_id = umc;
 
-	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
-	if (df_indirect_read_instance(nid, 0, 0x1B4, umc, &ctx.tmp))
+	if (remove_dram_offset(&ctx))
 		goto out_err;
 
-	/* Remove HiAddrOffset from normalized address, if enabled: */
-	if (ctx.tmp & BIT(0)) {
-		u64 hi_addr_offset = (ctx.tmp & GENMASK_ULL(31, 20)) << 8;
-
-		if (norm_addr >= hi_addr_offset) {
-			ctx.ret_addr -= hi_addr_offset;
-			base = 1;
-		}
-	}
-
 	/* Read D18F0x110 (DramBaseAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * base), umc, &ctx.tmp))
+	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * ctx.map_num), umc, &ctx.tmp))
 		goto out_err;
 
 	/* Check if address range is valid. */
@@ -1127,7 +1155,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	}
 
 	/* Read D18F0x114 (DramLimitAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x114 + (8 * base), umc, &ctx.tmp))
+	if (df_indirect_read_instance(nid, 0, 0x114 + (8 * ctx.map_num), umc, &ctx.tmp))
 		goto out_err;
 
 	intlv_num_sockets = (ctx.tmp >> 8) & 0x1;
-- 
2.25.1

