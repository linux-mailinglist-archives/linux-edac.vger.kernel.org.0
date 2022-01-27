Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3239049ECB5
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbiA0UmA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:42:00 -0500
Received: from mail-bn8nam12on2050.outbound.protection.outlook.com ([40.107.237.50]:48352
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344106AbiA0Ulx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHtc25ypmwE0Z/LEuiQtlre/uBiUcTRqbp5nzbir2GSuohIh/V8XJYefK4WpuAXD7zqlJPT+YtzUl0im5aQuENw2Hq1CejuCqVhBbCBFhxUZ2y4k1xwL4qOKZw/zg3QL+XUOJxYS74p0GH/c6dXP1G4Vg/zBD4+NcrFX1uxmb8FESyMVK9EahQRx5aPB5DTSONWjekWvfo97/wtgcK3C8lKT7Z0EcRUNKSNbGW8S071OOd/b0gkGqKYA0MvEmnFB/AHt+ENKobDpFjvs1CwZT4mbDAMWzHI5sEV/mqYLr/cwPqtU0bupbTRe69WLrAEny575UcWH4ddVyBgYCNvNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clL+xtDpOALo/XDwO3QqUpRPuQEZPD2/bL+erk1ov0Q=;
 b=irlBdsvBLq65VmO/xsdA8bDERwPmBLMIZbzA+aBo9+1hNtD5LGE3bRNM5k0EUXJ4kM6dV7/8wYrJWHhr8leYkMlxdR+YAOxeQUvY4mbKvCU7IS3DOxwc6FKdKCR4eSfH3vHKPKzfqSam6nVAlkU0Q1U5bHWQ+hcIB0Bm1FQzIrHpoCPnqqdGrNm9U0knH/Syfb+0PkysaRnliq0zVCcr7qVSKDt6P+v1LTvZoMbhhhgAeodZNfoBY3N5P0pNxS7nMw/zeoVwvtIf8/u2ybX9nVdMY7wDuV1uyt9L37lgr+kk/frB1uQw+u3UsslS64pREke2OGNgN36i9ZxvV7/dpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clL+xtDpOALo/XDwO3QqUpRPuQEZPD2/bL+erk1ov0Q=;
 b=NaCzqnpK1YafLbsqHgaYppYJpiYiX4i26criw+vgjsE2waKL50JRF9VC5fYB8WqnTeYJHfwlfY66yVfleJBdS6I5WaJhfs1hUX/xIcyrCgv9icO6ExTKVDvMhdWDlcEZ81n/bsFFQU3yB8YQlojGKUb7wzmVg5btIzTjM9M42o0=
Received: from MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::20)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 20:41:51 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::e8) by MW4P221CA0015.outlook.office365.com
 (2603:10b6:303:8b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:51 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:45 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 20/24] EDAC/amd64: Define function to find shift and mask values
Date:   Thu, 27 Jan 2022 20:41:11 +0000
Message-ID: <20220127204115.384161-21-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5b0642f1-89c6-452d-463c-08d9e1d57256
X-MS-TrafficTypeDiagnostic: MW3PR12MB4394:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB439426FE6A56A16292E05C38F8219@MW3PR12MB4394.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFx4pLzjPWxRMAYts3H0e9/TUpNJnPyUAdoyHLSezZu3dbDQr1sO9mxqHlB3XdpdtIy8yHLCu4N5zejj/2I5OH84Kn1caQv/T9e+aQc68yndBUYS7RmlligD0bC2xyd2b1WHUgdimx1aoB7bY7B2vWTb5OoxOzhkzWigz16m9ReNl0RkL9oheFr7maESs8Aim6IMjWsfNlQwqvx8wBoAzDLk1TgVjxxJ0+t+gQOx5aLzjwF3FluQnZW4aLn86hKngLBmiMWEHiJvB05GG7GEDQMr5XB8xI8xFYFPRl6UdwWGF+8j3+4W7KyTPeKtmKBWQ/kMjXPRHquqRHoO6lOyETDn1hT+dFkPpc+dRCRai/VMhLlVAbTnO6OA9fRhHRdBtQ5+iANe0QJMB8u4+IlDaRMjjk+9ZSibgpKEj7b2vF7+I2kspud5eXUvIWTq4XvUPQFrR0kt19ItRhJktkg8VbBLXHCtbmCevog0TltT14i9Fvpw4PVJPHFUMpLTKg975HpQDUsgNXZ2M+0ouPMY/7GxegSz6l96k0FF9kAFIOCpeYAKjpnYCPTxlEwmshBwWDafkJnv7crS66zNt0VK8YdaV8TEQyHR7hqqlmMucnnyg4ca1p0T4b/WXuaRQbiHyMjOMapQ+cZHGNyR2d5e62/tB6qw+NXN3R6MWx2ghQs3TA8qQBdjLT7yPYQRd10ZXj8GqO7eX1BHGIEsa8HaD0xyAROcUcm0LXpve3OZsavwaC12/0CRXyWWa9fj68FxCbPLSE6Gx5LDNs1C2Z7U5dlTb9Xb8WzFxOTJwSInTqpv5LXsvHR1KuF6b6qztcZO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(81166007)(82310400004)(356005)(47076005)(6666004)(7696005)(26005)(44832011)(966005)(36756003)(5660300002)(2616005)(54906003)(2906002)(6916009)(186003)(508600001)(40460700003)(1076003)(16526019)(4326008)(8936002)(8676002)(70586007)(70206006)(83380400001)(316002)(86362001)(336012)(426003)(37363002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:51.0301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0642f1-89c6-452d-463c-08d9e1d57256
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move code to find the shift and mask values used in die and socket
interleaving into separate helper functions. These will be expanded for
future DF versions. Make the die_id_mask and socket_id_mask values u16
type to accommodate larger bitfields in future DF versions.

Also, move reading of the System Fabric ID Mask register into
get_masks(). This will be expanded for future DF versions.

Call get_masks() early since future DF versions may need these values
early.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-26-yazen.ghannam@amd.com

v3->v4:
* Remove leading whitespace in function pointers.
* Include pr_debug() in failure.

v2->v3:
* Was patch 26 in v2.
* Remove early code related to "df_ops".

v1->v2:
* Moved from arch/x86 to EDAC.
* Added functions to data_fabric_ops.

 drivers/edac/amd64_edac.c | 59 ++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 7891c2e93d53..ac7919010063 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1073,7 +1073,10 @@ struct addr_ctx {
 	u32 reg_dram_offset;
 	u32 reg_base_addr;
 	u32 reg_limit_addr;
+	u32 reg_fab_id_mask0;
 	u16 cs_fabric_id;
+	u16 die_id_mask;
+	u16 socket_id_mask;
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
@@ -1089,8 +1092,11 @@ struct addr_ctx {
 
 struct data_fabric_ops {
 	u64	(*get_hi_addr_offset)(struct addr_ctx *ctx);
+	u8	(*get_die_id_shift)(struct addr_ctx *ctx);
+	u8	(*get_socket_id_shift)(struct addr_ctx *ctx);
 	int	(*get_intlv_mode)(struct addr_ctx *ctx);
 	int	(*get_cs_fabric_id)(struct addr_ctx *ctx);
+	int	(*get_masks)(struct addr_ctx *ctx);
 	void	(*get_intlv_num_dies)(struct addr_ctx *ctx);
 	void	(*get_intlv_num_sockets)(struct addr_ctx *ctx);
 };
@@ -1185,12 +1191,37 @@ static int get_cs_fabric_id_df2(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int get_masks_df2(struct addr_ctx *ctx)
+{
+	/* Read D18F1x208 (SystemFabricIdMask). */
+	if (df_indirect_read_broadcast(ctx->nid, 1, 0x208, &ctx->reg_fab_id_mask0))
+		return -EINVAL;
+
+	ctx->die_id_mask    = (ctx->reg_fab_id_mask0 >> 8) & 0xFF;
+	ctx->socket_id_mask = (ctx->reg_fab_id_mask0 >> 16) & 0xFF;
+
+	return 0;
+}
+
+static u8 get_die_id_shift_df2(struct addr_ctx *ctx)
+{
+	return (ctx->reg_fab_id_mask0 >> 24) & 0xF;
+}
+
+static u8 get_socket_id_shift_df2(struct addr_ctx *ctx)
+{
+	return (ctx->reg_fab_id_mask0 >> 28) & 0xF;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	get_hi_addr_offset_df2,
 	.get_intlv_mode			=	get_intlv_mode_df2,
 	.get_intlv_num_dies		=	get_intlv_num_dies_df2,
 	.get_intlv_num_sockets		=	get_intlv_num_sockets_df2,
 	.get_cs_fabric_id		=	get_cs_fabric_id_df2,
+	.get_masks			=	get_masks_df2,
+	.get_die_id_shift		=	get_die_id_shift_df2,
+	.get_socket_id_shift		=	get_socket_id_shift_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1281,7 +1312,6 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 
 static int calculate_cs_id(struct addr_ctx *ctx)
 {
-	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
 	u8 die_id_bit = 0, sock_id_bit, cs_mask = 0;
 
 	/* If interleaved over more than 1 channel: */
@@ -1291,28 +1321,26 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 		ctx->cs_id = ctx->cs_fabric_id & cs_mask;
 	}
 
-	sock_id_bit = die_id_bit;
+	/* Return early if no die interleaving and no socket interleaving. */
+	if (!(ctx->intlv_num_dies || ctx->intlv_num_sockets))
+		return 0;
 
-	/* Read D18F1x208 (SystemFabricIdMask). */
-	if (ctx->intlv_num_dies || ctx->intlv_num_sockets)
-		if (df_indirect_read_broadcast(ctx->nid, 1, 0x208, &ctx->tmp))
-			return -EINVAL;
+	sock_id_bit = die_id_bit;
 
 	/* If interleaved over more than 1 die: */
 	if (ctx->intlv_num_dies) {
-		sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
-		die_id_shift = (ctx->tmp >> 24) & 0xF;
-		die_id_mask  = (ctx->tmp >> 8) & 0xFF;
+		u8 die_id_shift = df_ops->get_die_id_shift(ctx);
 
-		ctx->cs_id |= ((ctx->cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+		sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
+		ctx->cs_id |= ((ctx->cs_fabric_id & ctx->die_id_mask)
+				>> die_id_shift) << die_id_bit;
 	}
 
 	/* If interleaved over more than 1 socket: */
 	if (ctx->intlv_num_sockets) {
-		socket_id_shift	= (ctx->tmp >> 28) & 0xF;
-		socket_id_mask	= (ctx->tmp >> 16) & 0xFF;
+		u8 socket_id_shift = df_ops->get_socket_id_shift(ctx);
 
-		ctx->cs_id |= ((ctx->cs_fabric_id & socket_id_mask)
+		ctx->cs_id |= ((ctx->cs_fabric_id & ctx->socket_id_mask)
 				>> socket_id_shift) << sock_id_bit;
 	}
 
@@ -1395,6 +1423,11 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	ctx.nid = nid;
 	ctx.inst_id = umc;
 
+	if (df_ops->get_masks(&ctx)) {
+		pr_debug("Failed to get masks");
+		return -EINVAL;
+	}
+
 	if (df_ops->get_cs_fabric_id(&ctx)) {
 		pr_debug("Failed to get CS Fabric ID");
 		return -EINVAL;
-- 
2.25.1

