Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD9249ECA3
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbiA0Ulv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:51 -0500
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com ([40.107.223.40]:18688
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344127AbiA0Ulo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMsYAN53973BDywZS+ksbja0X2yl68q9N7QVKnL13r8YtyiI3VLhU2ZocLKWierBQq7xXj5GatBCBe4sDT8GvO7399490TIooyUBIgzKlos1RDTD06p8bMv0Er19B5+pOTCuX/BaBsqEHWj92wH+kTlNvclfSaM4+uCOEFIX+AQXBG/DIi2tW48eIA8TTUV5vERL27bPrm9K6XNk1Kf4uVZmw3WynzW/vBfHtPKQ5YzFkf207TwaExbQB3eCmmxXScN8RogNrD6+1g9WsugCYuOSbeV2l4W1RgKK96LezrLQZt6Nof28Rqcnfm2zuEpI1MPTjASkuB8LNbnOdNSi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPR849nVKplE4VXOfbtINN48xlAm4o3CU5jW6NFKoHM=;
 b=Jkq7zcHKXusI8FiEtTpfd6OJ4WBgrcWlBncUvw6NGXhHyh052xr3AqkNQYWSwBi9tjzzihhHTBh0scELDZVB5NvFe0f0Vz1f37fjQBmR0dNy1k46wRjtzhrw1eWXSKlVS0GAy+o/hOZG9mLOXH2yTZUToEYcgYAkOXSPNlziy9KuIhvoIxKVg22/7ZRyIAG0pPfHTT127My1e+iyZ6HaWv41NxzyhiCCnKrp8JCzbbGdPwOCl0XW76mMQtKoW65o6xSQiXhkhXrSPY4Z8dojgEumAe9IDL+4d8L5UMctaPXXcILgTCcsaUBCseD170i7qQtqV271nDkqJX1nwsxTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPR849nVKplE4VXOfbtINN48xlAm4o3CU5jW6NFKoHM=;
 b=Uy6FUKOwKhlRZe48sOl5/Mxubtc9LLwHhQOGYqbCKXTRWY8cKxHPY9h1gXApN1po8RKdl5rCIzMa75IxQla48hAdFrSRgFYbc42UupU09Pse/Y3SE5JdvBvfZCDqTRoTihYrQruRHUcHfZzXNhfJYddPaX7pjwkK8wb5V3u0gz0=
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by BN8PR12MB2995.namprd12.prod.outlook.com (2603:10b6:408:41::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 20:41:41 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::69) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:40 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:38 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 04/24] EDAC/amd64: Define function to find interleaving mode
Date:   Thu, 27 Jan 2022 20:40:55 +0000
Message-ID: <20220127204115.384161-5-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: edc86d2e-1077-44c4-37a7-08d9e1d56c14
X-MS-TrafficTypeDiagnostic: BN8PR12MB2995:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB29950B0F5FB9915F8976EAD2F8219@BN8PR12MB2995.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMlSvIeZJniqkh/OXawbo6+3+F+asQcZ/7Wd/da9gg/9vpSp8woAXox7e3GbpbKWzHEsvJBkPBbYajXyaEknJslKRjVTAJwA6uqFRvpwFEsFEzabDEEJWbAWoEMMMkLl/c0PTQl8JYAuWPA/JwV5uYukbYFmhckHXjwNUvT+OP+T5fLsbrx80PuBIBWvYerYox2Alwm/3mafQ48OJF0akDn/rjbCScMOJPQzh3qSgWXA4Khw10yoc1WJRuPF4evpTf3U99uX9aOik8ZDZCSUNSaGRaL/Je8d7JhFJhmn0XRh3UbxAuh3CnJ+z00hQaJ8Y6mvDLMvAfGjStwCUDvA8EfWTW+Dsf3Tus1qnvkFUKD9DS+v9UUfZlnxjIas6aWnj4Ib5ZG4Sh2QhZ5x9+YCvoy8VIE8oMwXYbH5iNB9l58zDRVwXkc/0R0JlXMuEe2zFtLfItgaDnvaELfR0IqzcbpmrSLr5bncKiakc5hYk/pmTtcO6Y43csQthcvEcm94jWKnJoyv48ZPEV8VSVmDoE9PLy1HUjW3o0ySmenbC59H3KGU4xL4U6Z2GKb9LAmJ2s40VwgBHKQM077//kesIRDNzZJpo9wyFIZ0MEl6fTZZt7rXZslbvYUcy4+nuMoBPJOSCdwfj0wjDv/2nfUn+kYlRmaI3bYHEkaNrU3rq1IlHIEUGWdMv8aUExHjarhQC/7cCIqIiyTiJVRXqr0vij8XyOjtLm3+1ikISTMD8ZTst2TomJmfbfIchURKGfIsMIrTzD/8q7sMWxWTz+Y+2RC/YqCRFkJ7OAHhebClx9Nt87fZaCY3GYrHqDI/2HU7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(6666004)(82310400004)(26005)(6916009)(54906003)(508600001)(36860700001)(966005)(47076005)(4326008)(70586007)(5660300002)(81166007)(36756003)(2616005)(336012)(426003)(2906002)(356005)(1076003)(186003)(7696005)(86362001)(16526019)(40460700003)(44832011)(83380400001)(70206006)(8676002)(8936002)(37363002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:40.5308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc86d2e-1077-44c4-37a7-08d9e1d56c14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2995
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
https://lore.kernel.org/r/20211028175728.121452-9-yazen.ghannam@amd.com

v3->v4:
* Remove leading whitespace in function pointer definition.
* Include pr_debug() on failure.

v2->v3:
* Was patch 9 in v2.
* Updated commit message.

v1->v2:
* Moved from arch/x86 to EDAC.
* Add new function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index d1af1ce716f9..4e83a9be4724 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1057,8 +1057,16 @@ static int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo)
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
@@ -1067,10 +1075,12 @@ struct addr_ctx {
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
+	bool hash_enabled;
 };
 
 struct data_fabric_ops {
 	u64	(*get_hi_addr_offset)(struct addr_ctx *ctx);
+	int	(*get_intlv_mode)(struct addr_ctx *ctx);
 };
 
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
@@ -1078,8 +1088,26 @@ static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
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
@@ -1146,7 +1174,6 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	u8 num_intlv_bits, hashed_bit;
 	u8 lgcy_mmio_hole_en;
 	u8 cs_mask, cs_id = 0;
-	bool hash_enabled = false;
 
 	struct addr_ctx ctx;
 
@@ -1173,6 +1200,11 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		goto out_err;
 	}
 
+	if (df_ops->get_intlv_mode(&ctx)) {
+		pr_debug("Failed to get interleave mode");
+		goto out_err;
+	}
+
 	lgcy_mmio_hole_en = ctx.reg_base_addr & BIT(1);
 	intlv_num_chan	  = (ctx.reg_base_addr >> 4) & 0xF;
 	intlv_addr_sel	  = (ctx.reg_base_addr >> 8) & 0x7;
@@ -1200,7 +1232,6 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	case 7:	intlv_num_chan = 4; break;
 
 	case 8: intlv_num_chan = 1;
-		hash_enabled = true;
 		break;
 	default:
 		pr_err("%s: Invalid number of interleaved channels %d.\n",
@@ -1302,7 +1333,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
 	}
 
-	if (hash_enabled) {
+	if (ctx.hash_enabled) {
 		/* Save some parentheses and grab ls-bit at the end. */
 		hashed_bit =	(ctx.ret_addr >> 12) ^
 				(ctx.ret_addr >> 18) ^
-- 
2.25.1

