Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979FB49ECBD
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344301AbiA0UmJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:42:09 -0500
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com ([40.107.243.86]:33902
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344175AbiA0Uly (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZU73uytRDJpu9CZ98TuJqDQSq9e/vBaVXxLfVgzJxHDgFa9hzns3+0haB3RVxwZBCYspMTCoyoczltMHNBK7Gio1XXVdAIoRtfHxLC/mTQJ4IUKEYiwvp06xOsahnlWyB5WRViOt6BFFeyGb727ffWi6+oT9Wo84Uz9B4D8FEI6ocMOGgZU6gJtbg32uAoihutEVSOPuNb3C+F6sG1jHehPXGnM5rdODntk6OgzfjFNVZUyf+UAhumfQAKMdL37CK3YNKTL8JoNlqkuBAGJ6ZdE3JtXiatEjmospMwFHpncep6JiSpOcTdNRFLYWTccZ9RmIvvhAVKJNJzwL05h/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AIDGn/HJxSy+KH6BelcUoYYdGJEl6keohWsSPNXFME=;
 b=kTo7VbxUqsaWWyK/AjMethsNQ0Wz4PogV3sNJ30x44w6UkuQv30Owa3ij6dxfqWRqTnO3/2ezLEGeyi3P903mrf/soxtH0wz7GUBUkCgGaSXOZSHMidXSbh5IQ6vG/i7BYcRPiTc+ElHlbb8l2WFhIk8RKlseZmhMMVdBX2CHL4KqXkfXyE4yPJ9ytzjTn3s3vFc+V0FtsE/kb6DaKw468+ywn895jGyA9RYPjLUQYEQHSTI+a+JpcPCYa53dAAzKup/4iu5Shtg7GJCEOhhHWZFLEtqHkLjOKH5Ok9fXeQQOVe9OVruQGMsXbH+NS4einbgqMX0/49bRHMRizh32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AIDGn/HJxSy+KH6BelcUoYYdGJEl6keohWsSPNXFME=;
 b=KV88zr59B1QR+nwTxIdX5PecidnZO/vPKlBIScWJbPVPSHySmd/zUvx093Pnbe3dFD2VoBeTPDFXy6znSQL6EjxDb1B+tOB1LV8k1Qe5qXkBoRlIUAscH2URb0UKGPB7rGQHuv03l/buGzge7r1doQHikkb2+g2bLbJHxTNLnSs=
Received: from MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::20)
 by BYAPR12MB5704.namprd12.prod.outlook.com (2603:10b6:a03:9d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Thu, 27 Jan
 2022 20:41:51 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::fa) by MW4P221CA0015.outlook.office365.com
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
Subject: [PATCH v4 21/24] EDAC/amd64: Update CS ID calculation to match reference code
Date:   Thu, 27 Jan 2022 20:41:12 +0000
Message-ID: <20220127204115.384161-22-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 39659b0a-4336-44cd-2dbe-08d9e1d572a0
X-MS-TrafficTypeDiagnostic: BYAPR12MB5704:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB5704E90CEC5FF2F56E36955BF8219@BYAPR12MB5704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CVH0SHHTLqucE2HTIgwbaeaXGFDCUJ5MsjCjtjDLQiTqutFe7vGHpLQDIa88CZZVWOK8yKH6wUqv21Mr26vI7Ng8cJpWEmxeZfNHUoaXNUeUjSb8FIwY7h45zc5w1uYDfKFQBoAGvYt2fxZKtUaGlYRu/x9O5T/RIb5q7TC1TXRt++OekoSTqaJiG5EaaA+gE9Vr9X4sUz+fDGPsEK1aWWAoEVT1Rxb5Z11ID6aB049j0kWTs/2SwuwKlYbsEU1M6wF1x7wK1PpCLoPH7jYLq687WzrjLu6fxIQHc1iOHC6vIwCP7cWKuVTRHFdn2lCdL2mclCWmHVrT9aOIYS0uSe/09b3sdRBCzk0OKMKpHWMx3s/P3xV6ExnZBaEkVpZt9/YtU/MZw6j0ymoMLddguNNOKLh6dwYW+9d3/Uy6VKUex8PEbd+pdhxw3YEistVtu9lwpzpLqmw6RHav8DtZMnFGeXfUneuBsV5D9zs+vW5Eey+hnItS80AWPHroKokq1CtthNwq6/zkcGreKiZb6BvyW+wkkZZewYbwpEEkN6vUvy6mtfTR2sMEd67AWuH2FHmIGgIsxYJkOQgCx2bpNU7nLCCumql7sMeiV8DWj67glkgC4sy2WxDjmxbBibENdORF+iK86aL3YBdPKwE5VQqGh/jqqlnN8ZatTAS7n+nRxLM5h+ZuAsnRG1VtDvKt+Vsix3C3cKbdBqif/qrBdl2IpNUxaj51/pNMkhAuYWvd2CAgT0xaSr9UUTx8cWAzE53h4Ooswtkb+utsIk/rJYEmiSTcrXuVb4l5wDJ8YDUKfIg3Dy6tATxJncV3Urvy1DbGwh8vClZcIi3imoV8w2uEqHuPzs6BlmLKGMcD+Po0gAqbdQNxi/zMnFuQs3mR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700004)(36840700001)(46966006)(7696005)(16526019)(40460700003)(82310400004)(8676002)(83380400001)(186003)(6916009)(26005)(70206006)(86362001)(426003)(36756003)(508600001)(2616005)(4326008)(8936002)(47076005)(966005)(6666004)(70586007)(36860700001)(44832011)(2906002)(1076003)(336012)(316002)(81166007)(54906003)(5660300002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:51.5144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39659b0a-4336-44cd-2dbe-08d9e1d572a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB5704
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Redo the current CS ID calculations to match the reference code. Helper
functions are introduced that will be expanded for future DF versions.

Use u16 type for dst_fabric_id and component_id_mask values to
accommodate larger bitfields in future DF versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-27-yazen.ghannam@amd.com

v3->v4:
* Remove leading whitespace in function pointers.

v2->v3:
* Was patch 27 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.
* Added functions to data_fabric_ops.

 drivers/edac/amd64_edac.c | 52 ++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ac7919010063..e293aefd486e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1092,6 +1092,8 @@ struct addr_ctx {
 
 struct data_fabric_ops {
 	u64	(*get_hi_addr_offset)(struct addr_ctx *ctx);
+	u16	(*get_dst_fabric_id)(struct addr_ctx *ctx);
+	u16	(*get_component_id_mask)(struct addr_ctx *ctx);
 	u8	(*get_die_id_shift)(struct addr_ctx *ctx);
 	u8	(*get_socket_id_shift)(struct addr_ctx *ctx);
 	int	(*get_intlv_mode)(struct addr_ctx *ctx);
@@ -1213,6 +1215,16 @@ static u8 get_socket_id_shift_df2(struct addr_ctx *ctx)
 	return (ctx->reg_fab_id_mask0 >> 28) & 0xF;
 }
 
+static u16 get_dst_fabric_id_df2(struct addr_ctx *ctx)
+{
+	return ctx->reg_limit_addr & 0xFF;
+}
+
+static u16 get_component_id_mask_df2(struct addr_ctx *ctx)
+{
+	return (~(ctx->socket_id_mask | ctx->die_id_mask)) & 0xFF;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	get_hi_addr_offset_df2,
 	.get_intlv_mode			=	get_intlv_mode_df2,
@@ -1222,6 +1234,8 @@ struct data_fabric_ops df2_ops = {
 	.get_masks			=	get_masks_df2,
 	.get_die_id_shift		=	get_die_id_shift_df2,
 	.get_socket_id_shift		=	get_socket_id_shift_df2,
+	.get_dst_fabric_id		=	get_dst_fabric_id_df2,
+	.get_component_id_mask		=	get_component_id_mask_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1310,38 +1324,42 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 	}
 }
 
-static int calculate_cs_id(struct addr_ctx *ctx)
+static u8 calc_level_bits(u8 id, u8 level_mask, u8 shift, u8 mask, u8 num_bits)
 {
-	u8 die_id_bit = 0, sock_id_bit, cs_mask = 0;
+	return (((id & level_mask) >> shift) & mask) << num_bits;
+}
 
-	/* If interleaved over more than 1 channel: */
-	if (ctx->intlv_num_chan) {
-		die_id_bit = ctx->intlv_num_chan;
-		cs_mask	   = (1 << die_id_bit) - 1;
-		ctx->cs_id = ctx->cs_fabric_id & cs_mask;
-	}
+static int calculate_cs_id(struct addr_ctx *ctx)
+{
+	u16 dst_fabric_id = df_ops->get_dst_fabric_id(ctx);
+	u16 mask, num_intlv_bits = ctx->intlv_num_chan;
 
-	/* Return early if no die interleaving and no socket interleaving. */
-	if (!(ctx->intlv_num_dies || ctx->intlv_num_sockets))
-		return 0;
+	mask = df_ops->get_component_id_mask(ctx);
+	ctx->cs_id = (ctx->cs_fabric_id & mask) - (dst_fabric_id & mask);
 
-	sock_id_bit = die_id_bit;
+	mask = (1 << num_intlv_bits) - 1;
+	ctx->cs_id &= mask;
 
 	/* If interleaved over more than 1 die: */
 	if (ctx->intlv_num_dies) {
 		u8 die_id_shift = df_ops->get_die_id_shift(ctx);
 
-		sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
-		ctx->cs_id |= ((ctx->cs_fabric_id & ctx->die_id_mask)
-				>> die_id_shift) << die_id_bit;
+		mask = (1 << ctx->intlv_num_dies) - 1;
+
+		ctx->cs_id |= calc_level_bits(ctx->cs_fabric_id, ctx->die_id_mask,
+					      die_id_shift, mask, num_intlv_bits);
+
+		num_intlv_bits += ctx->intlv_num_dies;
 	}
 
 	/* If interleaved over more than 1 socket: */
 	if (ctx->intlv_num_sockets) {
 		u8 socket_id_shift = df_ops->get_socket_id_shift(ctx);
 
-		ctx->cs_id |= ((ctx->cs_fabric_id & ctx->socket_id_mask)
-				>> socket_id_shift) << sock_id_bit;
+		mask = (1 << ctx->intlv_num_sockets) - 1;
+
+		ctx->cs_id |= calc_level_bits(ctx->cs_fabric_id, ctx->socket_id_mask,
+					      socket_id_shift, mask, num_intlv_bits);
 	}
 
 	return 0;
-- 
2.25.1

