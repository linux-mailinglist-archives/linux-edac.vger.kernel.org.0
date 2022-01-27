Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCF649ECA8
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbiA0Ulx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:53 -0500
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:55008
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344150AbiA0Ulr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiVpun23tLwqn3c3kWNwJ82mGtNTa4OGvq3Xg9C4JE/eMZb+L5Q0zBETLs5VZxsn+eAG1F2wdTh6sTAzUkNzuXjlXXt7oYe/iIMFW5Kw4I5Yk/AzTJHvLJzjJHMHeeWbnkbsdVw+95MyFz5g7nLDtOwyD7sJSCalT7AgTetIftqTvRRMOFu7ZLMuqjL3026kZgg3BzeuyKAD9G1rYvdXaVE8KPTlw9bUzdgDQEMbvJNvdiBRRuigFZ0SDGVsDJhKSRBVqAN4pj/9k/Lc0atfUBd417nD2TxgzNufaGXK29hlKuKqQL1aSlI9H/nVtxlaeHgfgNvnmFxOXs1KjiEneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6i8etN7xUscmHlPUCXecT9Uana7wKxVAsgjFnwAsFDw=;
 b=l/MYFTQR7SUPrUarjj87kg284q2aWp2aFqRJYF2ww2KrqJPLiSsgKf1KklsCs9+K+u1l3Do4aL+y63I/GZiYiO1fHGfgukuvGLtKxO1eQAsFYsUXiPWQl8zmc3QcrElBkXAd/nvxRWO3QlioYdBIoVAWK8al/ro6U0hY7j0st4gavWAi7VJPpu/5qKf4dUg9tdYxNvcrMgAgrQ84wLORXRXTJlC63ws+Un4uimZz51ox24PhY0Lj3AODEg2hzBCFC95xSwf/XqU6VHqT5V3EQnXifyCP73H5WBS9f0T/CI0wNUVsnL/562Eqe/wF0SlYScWlEfHejD35GGzMLTqdMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6i8etN7xUscmHlPUCXecT9Uana7wKxVAsgjFnwAsFDw=;
 b=ZwoSToi+I5bghxgsVfdmsb0tax2Mray8C1ZSeN2kxySwpxHDpkcZANNEMiRqy6gYIZ2uBsIfCxrsqx9tzCbQdR2ibcm5Adp/lQ4Zef2pn9OODmE1uQri8GUcvpNLkEgKJPqpBtgBjldPZBcytRjI8MO2AGTWoQnybGkYVcgY6qM=
Received: from MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::23)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 20:41:46 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::e4) by MW4P221CA0018.outlook.office365.com
 (2603:10b6:303:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:45 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:41 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 10/24] EDAC/amd64: Define function to get Interleave Address Bit
Date:   Thu, 27 Jan 2022 20:41:01 +0000
Message-ID: <20220127204115.384161-11-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 678671f8-5ad9-4536-c82d-08d9e1d56f3e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4418:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB441842690F2CD294BAFBE255F8219@DM6PR12MB4418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhEdCuTeId93Mi8HUqEgqw2J+gJT9ELS93QJZ7ch4zalRt+DTqwOXq/Ouo10mWBQpfy/ymFmKSh6vcuVxhA5xndWnj6wj7lw7AZLyw1zOy+vN6FHucEz6MpJBFmap/LfhjaONr7EIzxFXe90U2RZemcmUE+ljzr44SrPyZlboh0Ue/ac/WOryJPSLva1OWlJHEqejR0jbkXxAIa6ny69d+XMjtwUHa06OYQZeveXzjLWpzTASE1WWZK39GEA7xp0RhV/ViQyyxHBlOtrcV/XobnJOdPzbs65h3ETR5L+0Yc+5Tq0eebSPak6DuuIFk8FrH+ks1VX+1v5l7gW6Yo/E8wyTsrRvX7MUEGLDJ3VOKB2BwkDvIaDZHhmgU4Oj5Z0FhKGzMCob1sfttCGEuptLFIXCwhqS2L656WBZKi7cNYdbPsMsWlBk1Y/7iqR2e8j2rsH5SVoD3pT1nYUNrj7hUrZ7lZ9vQ6vLAUi6Dq5nzZ3FB2nUXbt/wFSnDfhrOHADyJVKu8RkqhdWQTUHbNmqAlPm9MiTVUGxN0nAY2pJYclpNQ3iM2wIpzVnh/yCoTgZCjpYWbzrri438z/6g46qIT7kgtbpar+OTj9QaQrmS2OR9JtSmpVoubnj84AwQFh8i5bjnYa9f/zqtmwWZyWGdtWRvZqvE0jA5mbZFOp0d0y/hZcMDLKWu3IIUmTgRiDv6niwuuXxLvBAthfCPLlomlWlOSvJjfilmBjzF0Xzya82cyQ08/MZotw7RGS0xJUxdRK+VL16e8wfKt4NLMRV59fgipIT0LCo7ynLCRc3ks=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8676002)(36756003)(4326008)(70206006)(70586007)(8936002)(47076005)(5660300002)(6916009)(44832011)(40460700003)(316002)(36860700001)(54906003)(82310400004)(83380400001)(81166007)(356005)(186003)(7696005)(86362001)(2616005)(26005)(6666004)(16526019)(426003)(336012)(1076003)(966005)(2906002)(508600001)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:45.8430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 678671f8-5ad9-4536-c82d-08d9e1d56f3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move code to find the interleave address bit into a separate helper
function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-16-yazen.ghannam@amd.com

v3->v4:
* No change.

v2->v3:
* Was patch 16 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index d568ad886d35..53d9c4b1c233 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1182,25 +1182,33 @@ static int get_dram_addr_map(struct addr_ctx *ctx)
 	return 0;
 }
 
-static int denormalize_addr(struct addr_ctx *ctx)
+static int get_intlv_addr_bit(struct addr_ctx *ctx)
 {
-	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
 	u8 intlv_addr_sel = (ctx->reg_base_addr >> 8) & 0x7;
-	u8 num_intlv_bits, cs_mask = 0;
 
 	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
 	if (intlv_addr_sel > 3) {
-		pr_err("%s: Invalid interleave address select %d.\n",
-			__func__, intlv_addr_sel);
+		pr_debug("Invalid interleave address select %d.\n", intlv_addr_sel);
 		return -EINVAL;
 	}
 
+	ctx->intlv_addr_bit = intlv_addr_sel + 8;
+
+	return 0;
+}
+
+static int denormalize_addr(struct addr_ctx *ctx)
+{
+	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
+	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
+	u8 num_intlv_bits, cs_mask = 0;
+
+	if (get_intlv_addr_bit(ctx))
+		return -EINVAL;
+
 	intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
 	intlv_num_dies	  = (ctx->reg_limit_addr >> 10) & 0x3;
 
-	ctx->intlv_addr_bit = intlv_addr_sel + 8;
-
 	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
 	switch (intlv_num_chan) {
 	case 0:	intlv_num_chan = 0; break;
-- 
2.25.1

