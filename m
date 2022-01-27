Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37D349ECB1
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344151AbiA0Ul5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:57 -0500
Received: from mail-sn1anam02on2063.outbound.protection.outlook.com ([40.107.96.63]:15973
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344167AbiA0Ult (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7BrCM5wWNjHvcK0qcWtzyoIe6zCKjLabroXRBf3XhypUtnTcXnfOwVGzdDDr7RY54ndJqEvH1mehmRjsAlHBT93KkyQGDZPU6x4u76Or6RH0SywkzG1iLQc166ls2nWSdUkCbuJH3j5tJpGbxC7Pg2qJXiDfzN3+XSCBFPwm+qjm8gBKSOdAbsbWNDJYa2lisp593O3QULAo7R+nmYc6tm3bxtXcdL6gdjAiWlsQw1GZZ8NXO49AGlHZ4PehDZBl9CoJBALckEbCfobTDgW9HtS1xpmiPeTcqo9HMSBHJPNM3GTh/H0T8LAXYSYbewJrsrYF07ICfw1Q9Z1kCwKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2k5RH0xDD5PmnNqMWa784AFiIaZh/HozpAT5x1Sbzs=;
 b=mPNdsEXFz33nipoyzRbYvfoJeYPLafa2ptJchG9ylBzM47i3qsSwlxNeixOGjhNKurAs14RzkRF3plZ6UN+CikgMNo1tgvP/h9sHw5Ivzf0ZaebacghO1ek9Hir2pH+1LagTf93/9GBETVa1VFmxOY6JyBskmDAvxNIQVb8erw+IMApsknkwDUR3EZ/DhpUm4TXRNYamAKAth51c2qUSDoKGBot/Jul8y6M9kwmRHTDwW7mEnkJma/6U5ofZDC/+YlN+JjqqaHnTkXJ6uTBCd9O8bDMk4NYYWKP0TNCwKbLjS8fNDUtvcpHHiTHlo5NJA+1+ApA7d1bPKPpT+iGp5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2k5RH0xDD5PmnNqMWa784AFiIaZh/HozpAT5x1Sbzs=;
 b=bu8rG0++oZFqLwPEAeqisYoSlOt2T2BLipi0DROTMkR7Gzno1FpiZ+4mABEnrGmLxEaoqHvAwZp45txJVEBPHw7eFLg4OMTtTX2VepPqLIOUtWkj92svRB2CwNg+E+ssd3fMlXZJrYRTrTcFGd1/ExIBDLHLz2rm7fegXdEHJE8=
Received: from MWHPR17CA0076.namprd17.prod.outlook.com (2603:10b6:300:c2::14)
 by BYAPR12MB2790.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Thu, 27 Jan
 2022 20:41:47 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::f6) by MWHPR17CA0076.outlook.office365.com
 (2603:10b6:300:c2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:47 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:42 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 14/24] EDAC/amd64: Define function to get number of interleaved sockets
Date:   Thu, 27 Jan 2022 20:41:05 +0000
Message-ID: <20220127204115.384161-15-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e577b19c-dd83-4e99-67f8-08d9e1d57010
X-MS-TrafficTypeDiagnostic: BYAPR12MB2790:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB279007BBB6CC27F5673A42CAF8219@BYAPR12MB2790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3e43JqwW9NL87Ija0JSiHOJ6rHc7CaDayslL7ERmvxMSRE6MEjUse0zSPJ4XD65yER4SwprUJoIYzEJq9N3eeyaCQLlLfLjpHhOqZl4UeZsUjBbuY0xGJ6udaYTSDOSB+T/d8hH+FfAFye+HSCEisUWA+KclNOlVekh7PgjVJddJ7IEf13QJfkgpiyty3qfPyeVhht2ZzDqRK+i1GDpOHJUVH1Sbt/rZrv+JxbBwSHriAltnOrjnT//iN0oEtmu2YXaz1cc1w5mTp8icaMX/hfXsU1VSLWa+NmAYaiz/xZPbXmrdUeltIZ3olPcsU6V62hNPMGqDpuciURxeY3fiMvZXMR41+Jw2tYJ67dqPTMWE8jAOcIXr5d9wZHoY5ryNWOtdu6zoFkiXYPQrGHntBbwNBwh7EbexFkEJ/Y1ydygY5mlV4+ezUgGC4JnTL62lV4sFr0qwIbMnJYCm/BrmqYu8c3puMy+VeNo6sBYQjJBXpfoBJyP8hfUS6K6RBapI4bPxC3a222lml8XDIwMpQbVX1xE755WaSYiIzTyVTnzpevtedjcLct+SK9Q5TAzLBL7kNnPg7lOABHAii+WjZR+2FbjSRj3DbvfSTfbPDKrsMNoIzAvXvms4qqbEl5d0Tg+cwoaCtvK5ed5dHpzRhr7SW/iOhKfXrr4e2dn5h8TXdjs2MTCoT2ONL9mQ/l+uBt2PZ48b4LfaR1DO+aOAK5mH+ONyZ705f2ey0/e1IaP/AUxebfd3f1UMgYZHg/ib8qjX0t09Bb70aHAmaADxvcMSEd94TWL3pm8IG4X38bkdjMwJ0MBus9YHJpFmvC9rIST9Hf3fAtQNO701H9y7eQ6A8H26Q/cgn3ZQw9GfFmc7gvHxNnN2VRQTKAuMzsvg
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700004)(36840700001)(70586007)(26005)(2906002)(47076005)(2616005)(7696005)(36756003)(508600001)(356005)(8676002)(54906003)(40460700003)(5660300002)(82310400004)(4326008)(316002)(86362001)(36860700001)(6666004)(966005)(8936002)(16526019)(70206006)(81166007)(44832011)(6916009)(426003)(83380400001)(186003)(1076003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:47.2011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e577b19c-dd83-4e99-67f8-08d9e1d57010
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2790
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move parsing of the number of interleaved sockets to a separate helper
function. This will be expanded for future DF versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-20-yazen.ghannam@amd.com

v3->v4:
* Remove leading whitespace in function pointer.

v2->v3:
* Was patch 20 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.
* Add new function to data_fabric_ops.

 drivers/edac/amd64_edac.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2973b7b5e8a2..898f53eaaff3 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1078,6 +1078,7 @@ struct addr_ctx {
 	u8 intlv_addr_bit;
 	u8 intlv_num_chan;
 	u8 intlv_num_dies;
+	u8 intlv_num_sockets;
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 };
@@ -1086,6 +1087,7 @@ struct data_fabric_ops {
 	u64	(*get_hi_addr_offset)(struct addr_ctx *ctx);
 	int	(*get_intlv_mode)(struct addr_ctx *ctx);
 	void	(*get_intlv_num_dies)(struct addr_ctx *ctx);
+	void	(*get_intlv_num_sockets)(struct addr_ctx *ctx);
 };
 
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
@@ -1131,10 +1133,16 @@ static void get_intlv_num_dies_df2(struct addr_ctx *ctx)
 	ctx->intlv_num_dies  = (ctx->reg_limit_addr >> 10) & 0x3;
 }
 
+static void get_intlv_num_sockets_df2(struct addr_ctx *ctx)
+{
+	ctx->intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
+}
+
 struct data_fabric_ops df2_ops = {
 	.get_hi_addr_offset		=	get_hi_addr_offset_df2,
 	.get_intlv_mode			=	get_intlv_mode_df2,
 	.get_intlv_num_dies		=	get_intlv_num_dies_df2,
+	.get_intlv_num_sockets		=	get_intlv_num_sockets_df2,
 };
 
 struct data_fabric_ops *df_ops;
@@ -1226,7 +1234,6 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 static int denormalize_addr(struct addr_ctx *ctx)
 {
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_sockets;
 	u8 num_intlv_bits, cs_mask = 0;
 
 	/* Return early if no interleaving. */
@@ -1236,16 +1243,13 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	if (get_intlv_addr_bit(ctx))
 		return -EINVAL;
 
-	intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
-
 	get_intlv_num_chan(ctx);
 	df_ops->get_intlv_num_dies(ctx);
+	df_ops->get_intlv_num_sockets(ctx);
 
 	num_intlv_bits = ctx->intlv_num_chan;
 	num_intlv_bits += ctx->intlv_num_dies;
-
-	/* Add a bit if sockets are interleaved. */
-	num_intlv_bits += intlv_num_sockets;
+	num_intlv_bits += ctx->intlv_num_sockets;
 
 	/* Assert num_intlv_bits <= 4 */
 	if (num_intlv_bits > 4) {
@@ -1280,7 +1284,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		sock_id_bit = die_id_bit;
 
 		/* Read D18F1x208 (SystemFabricIdMask). */
-		if (ctx->intlv_num_dies || intlv_num_sockets)
+		if (ctx->intlv_num_dies || ctx->intlv_num_sockets)
 			if (df_indirect_read_broadcast(ctx->nid, 1, 0x208, &ctx->tmp))
 				return -EINVAL;
 
@@ -1295,7 +1299,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		}
 
 		/* If interleaved over more than 1 socket. */
-		if (intlv_num_sockets) {
+		if (ctx->intlv_num_sockets) {
 			socket_id_shift	= (ctx->tmp >> 28) & 0xF;
 			socket_id_mask	= (ctx->tmp >> 16) & 0xFF;
 
-- 
2.25.1

