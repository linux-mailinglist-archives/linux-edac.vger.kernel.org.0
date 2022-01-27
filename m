Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E749ECB4
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344218AbiA0Ul6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:58 -0500
Received: from mail-dm3nam07on2085.outbound.protection.outlook.com ([40.107.95.85]:24033
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344152AbiA0Ulx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDknd3vntE9C9RGORB15njk0KdTibaVRVc34FofeVMZXxb8b6/akxtXK11TamR4ydoO/dhwAyluXjDF15GR+/C7A2fJmF6qW8V41q91UAI9hVSWnK+W/cOytg0Mr71TF26lRl/akE5uITHU772if3X5rb3b4MdFUvLZeOQIrKho4N9sSr5LVmouAz/mqheu+H8sqmDLq5aQz1DLPcaAFY6kleT+TM57rGuuZmAMqtRnUQAeulW9hjEg4H9gu7XRrKWmZrHeuP5d+uCdlHDYzAFP0fwOrzdItRxhiRT/6VlBlQHTkXEsR2N4CYxDaJ3V+M2YFhq4EPr2gyM26oKlvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuRU05uXLh7sYFRoSUxhrvUgk/kPSebc8ED11vgWSAk=;
 b=BECuMSZy7c2oPW1ftWpLLdlizngNUToifoV+0fR6lFEUT0sHWYA2VmP7J8LG18TkXyMye69SUNvcwYbFk2U2I6XoCmN0P/s5CEsm/KFVrR9VPbf+vlptZ3DEr40Xc16YKT8bi7TuuuJxzxqhnKp3s7xe40L3hHRQh7LCcGXWrfdf2kOx9OdKNG7mm0aqWbvvmRDBlkENzlm0g8qa3LsWtYYyRHGyWgRK5xe+7ET5rYqhHWflmcqxYLnh9nzt86BLrjXh1KGsrqJn5Meo9itHsUsJ/2JT4jiUoitr4Wbrp7+q7k9A18MQ07Yyb/8vWi/ueVb435+SUCqOLIbSJ7Xjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuRU05uXLh7sYFRoSUxhrvUgk/kPSebc8ED11vgWSAk=;
 b=Ydu7RFJF5Mao59AsPeNuTYsXVHAh2J1nZZlTglZoZkVFsL4aHpoI9+tOcJw+fgb45Oysxu+VIgvv0UiBHxx0YyJidIT1raJtJXHjqykRV0BJ0XlDCr+68whcLy3qmiaDLOB8qKff/1SkTekkuVAMuE068i+vCtTCLfIFCQoyVBA=
Received: from MWHPR17CA0096.namprd17.prod.outlook.com (2603:10b6:300:c2::34)
 by BYAPR12MB3191.namprd12.prod.outlook.com (2603:10b6:a03:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Thu, 27 Jan
 2022 20:41:50 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::a8) by MWHPR17CA0096.outlook.office365.com
 (2603:10b6:300:c2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:49 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:44 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 18/24] EDAC/amd64: Define function to insert CS ID into address
Date:   Thu, 27 Jan 2022 20:41:09 +0000
Message-ID: <20220127204115.384161-19-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2e5786e-c047-48a5-25ad-08d9e1d571bb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3191:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB319111FC9C0EB94631B2D6EDF8219@BYAPR12MB3191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9fXSUCSW572x5KNkNIfNdmLnTKBDxp/W9/9x2Jam/Ewn/Hgdh+LLFeByphpCyA2VROpH7ZDVdNPUR5YARntbubcf+MDNOtKmATIeQUz15RXnlTYCbAgj6A3WsyvaPDsm38MI3KOC9n/R73f6i7J+zSusvFW903T43ZzM1AQBt/c/XOGCyGnfJq7q63f/yo23sHkoNA4IX+JHnQARinz9uvyM3rJ9JmjwCCJVpCor0K6dG40Xsd5hCsrgwzs2pKA5TDpbyiJ60M+MSRrh8wN7NZ7wZ6ustH46bZG6CjvXbLu9ZVBEVLnJ88+P3wG8Y5YJ2DdrVVGrqX0sv301Jl1YXxCkVbwEMp26sveTyuSmRxhSQ4c9Gd3LadD6RrQ74MnSYmr+nAZJMHP5IzcPo/lWZIBbP6ICVYMq1mG9mz+8YkTzo2hstrCkdKSBvnnAS4AIOoMLss6ju+C5VfUTneUpYyW+YKdGo8rgZEOMnAIX9St4UUKNYwCXEAIfJGyTwUMhiSUnDUia+CD8qEggDPrPk+kBzuGbWAUInXPljUa9nzMrBvzORYnRt//OKCaqqkoVyjEv+cIs6iIb3M/cJAoPpaRzuu6nkU4OPQSzIxckhkLmlc2CLdYGNbDj1Qbkm4OWFN3fiImUqsCsgK5SkIosIUAfNMJlfp/3L6GDXa7ghZCCVofO1i7EqeAPOucrss7IzD48c1OcG0zQX9UmQyQK9shuL6NfAUD1k7bI7kmU/sj9nhfCAWy9aiGCZUPqKr9jslNFf8oq5faaT00Cb2ABjEJLGVtbyyuE6jJyhajHQMA/vw0deZJKK/HLdF2yt7JXvcWHUdS/AKDlD0iSw8LR+pa7IO1ZBZGbiUKN7RR99XfBjO3tUQxvSVL9CSrkVhR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700004)(36840700001)(46966006)(83380400001)(16526019)(8936002)(356005)(8676002)(36860700001)(6666004)(40460700003)(82310400004)(47076005)(4326008)(81166007)(2616005)(44832011)(1076003)(336012)(54906003)(426003)(70586007)(316002)(70206006)(26005)(2906002)(186003)(966005)(6916009)(36756003)(7696005)(508600001)(86362001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:49.9978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e5786e-c047-48a5-25ad-08d9e1d571bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3191
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move the code that inserts the CS ID into the address into a separate
helper function.

Save the function pointer in the context struct. It will be set based on
interleaving mode rather than Data Fabric version. This will be expanded
for new interleaving modes added in future Data Fabric versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-24-yazen.ghannam@amd.com

v3->v4:
* No change.

v2->v3:
* Was patch 24 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.
* Added function pointer to ctx struct.

 drivers/edac/amd64_edac.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b2bcd8ea1a06..e3db4e98fe58 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1083,6 +1083,7 @@ struct addr_ctx {
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 	void (*make_space_for_cs_id)(struct addr_ctx *ctx);
+	void (*insert_cs_id)(struct addr_ctx *ctx);
 };
 
 struct data_fabric_ops {
@@ -1115,6 +1116,11 @@ static void make_space_for_cs_id_simple(struct addr_ctx *ctx)
 	expand_bits(ctx->intlv_addr_bit, num_intlv_bits, &ctx->ret_addr);
 }
 
+static void insert_cs_id_simple(struct addr_ctx *ctx)
+{
+	ctx->ret_addr |= (ctx->cs_id << ctx->intlv_addr_bit);
+}
+
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
 {
 	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
@@ -1146,6 +1152,7 @@ static int get_intlv_mode_df2(struct addr_ctx *ctx)
 	}
 
 	ctx->make_space_for_cs_id = make_space_for_cs_id_simple;
+	ctx->insert_cs_id = insert_cs_id_simple;
 
 	if (ctx->intlv_mode != NONE &&
 	    ctx->intlv_mode != NOHASH_2CH &&
@@ -1306,8 +1313,6 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 
 static int denormalize_addr(struct addr_ctx *ctx)
 {
-	u8 num_intlv_bits;
-
 	/* Return early if no interleaving. */
 	if (ctx->intlv_mode == NONE)
 		return 0;
@@ -1326,20 +1331,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		return -EINVAL;
 	}
 
-	if (num_intlv_bits > 0) {
-		u64 temp_addr_i;
-
-		/*
-		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
-		 * where III is the ID for this CS, and XXXXXXYYYYY are the
-		 * address bits from the post-interleaved address.
-		 * "num_intlv_bits" has been calculated to tell us how many "I"
-		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
-		 * there are (where "I" starts).
-		 */
-		temp_addr_i = (ctx->cs_id << ctx->intlv_addr_bit);
-		ctx->ret_addr |= temp_addr_i;
-	}
+	ctx->insert_cs_id(ctx);
 
 	return 0;
 }
-- 
2.25.1

