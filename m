Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8936E43E7BD
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhJ1SB1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:27 -0400
Received: from mail-dm6nam10on2072.outbound.protection.outlook.com ([40.107.93.72]:35809
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231388AbhJ1SAz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXKG9kh4HmbKBR4+1iQg3yPv+52bFyullMIj/1EpLu3ArfmbKSpiov6dporzZOfagn6K37cYNaD1c98xgjSdYAIPgDcln7veuD0lgS4r0AVeHPSx0uokyv+VymbJJW2tat/MK39S9IQd+SMFNq8o9EAk7CN1n08Td2xiLmN6qQMYhCFlfkn0t9KWyvQt5NlcstXc8IQE1bYwciS9mCwSUrsha+QgNySKIOJOO6JEwW/VN2G0VpdawIaUnm2UCu0ATDcjbpZ1sooB3/kiVYopugP7ulGitSq2dt+BdwqPK/QOX47ZSNxlj5rZf6/8RNuv+G5TQDRzfSDrpI3TPc5O8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxHNCJrdQP6vM2XGuMPU5snYc1VWRjcp6DyFB20MrIw=;
 b=EcX9FJIjjHR4BDWUbAxCLlUa31UlWShsOR1wZGHYFCMPn0P4IiQ9RdOEIl+gCxp61POrRxQXHmO4L5D5Fa27vrLPMd5rnT9KVtDDyILpzuBhsftobRo/+uLRVTM/1qLVtsUx1+uJmGgHLs8tf2L8PXVzzpRoGSu13aKYS0TDOqWowm9GVGlKDb7Q9KxXUGCJ3Ej8SUeRBMHiVekZldp9D30m+QSigNvCU1v1FE07mVVFPjxfl/jBtWtbpioV436qcVpag9gFHKOKBVfgYVEQEuoADoiEYoFvDjYhTR4D1hHpFoc31kCpZckaHU+e+XRM7w+seZs7towZOTLAvLsBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxHNCJrdQP6vM2XGuMPU5snYc1VWRjcp6DyFB20MrIw=;
 b=0ULYQOu29mb7PrrdvKH4+AJMpdWsECu1Ws8f+2mDbb4XZk9aeMdAJW1NZ8WjM5CUvMZkKGRM2I0+NQEBHmPrKWOg1jvwOGYf5gRpE0LH56BXTDETIynw6saVcIV71Emi7QeAswT13Sg7JK1/Y4e6mCLsmvPASrFMEM3hb9HcvM4=
Received: from CO1PR15CA0097.namprd15.prod.outlook.com (2603:10b6:101:21::17)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 17:58:25 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::21) by CO1PR15CA0097.outlook.office365.com
 (2603:10b6:101:21::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:24 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:21 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 15/33] EDAC/amd64: Define function to get Interleave Address Bit
Date:   Thu, 28 Oct 2021 17:57:10 +0000
Message-ID: <20211028175728.121452-16-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7e29377e-1a7f-41c1-2a18-08d99a3c89df
X-MS-TrafficTypeDiagnostic: DM6PR12MB4404:
X-Microsoft-Antispam-PRVS: <DM6PR12MB440495EA0052B97CEA5765E6F8869@DM6PR12MB4404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/9cXhdLL4r8nRLRDRJ2g3peDWsk5aFuTpd0JYyNoCPblvEOJtsrkoWp9n9kqNP5ch8eicFnxbqB5wZeNAbgzIxJzu2wP2kV1VmJfXape+F1F3RxkuV8Qoc2ZoeiRImItT9bB5b8OISqrBfcHqvw/U2V/m3zIbOFnKyDIqxXUb/YoiO3rfRjiV3HtVy9qEbtzeMdJO4N3CkVW5hrXtg6Wk2EmCrvNBkYp97fj8w5KVYawsSqoYopjmRuiII4K8gaqAeyXzWi4/yn2nuQEurBkwDZ1OikpACBPoCaRIuduhtjEjhvIVUeSEUe9vAN60aavm2koUZ+rbA6skM8kEP3WsZG86n/MAioeM5xK5LVrPN5rM+e692Uu4PGZTBiOGI5jjIMKl27ofs6O+n2GE9rpyi3Kd1sIVg28VVzQbMzQVFkeEF18yu4jwAuJ5aLIfpOIiLK3D037sHi6JPlAwBEXJQ9/jaLkgXYJkjdLN6gLYQNWaYZQzbC9oe0fuvzoNh/CAMAcfbMvGoznFuHO0kk6xXfAEhdQSCFRAUrTIkNaZTttABc6Th1e1R05xHdEQopm426Hg5XfhG6YSHiHnEU1mVzIdd98X/rxijDAtUQ+zaCepHP5uL5JcZoY9Ph4jJZDGjZWux4XWgMjj0bR9153P6YPZTBeqSmj4R66QwXFOZtBthn+ISzZHfHsATmv4xFZhHsfaCsZvrgJ5EmMX5wHDmxZJPzFIvO1a8RLHe+1AckR35Yfjg73PZDeLwKM98YW2zS2avtpKMOyr0ViWlc0FeENPlJwNb2inrwnkLu+8cSvzy1QXv5SlJve3oBTMRa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(86362001)(2906002)(316002)(70586007)(70206006)(82310400003)(54906003)(44832011)(1076003)(6916009)(186003)(8676002)(16526019)(6666004)(8936002)(26005)(5660300002)(336012)(966005)(508600001)(426003)(2616005)(36860700001)(36756003)(7696005)(4326008)(356005)(81166007)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:24.9865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e29377e-1a7f-41c1-2a18-08d99a3c89df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move code to find the interleave address bit into a separate helper
function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-17-yazen.ghannam@amd.com

v2->v3:
* Was patch 16 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f4074bc270ec..6b19fc5cf340 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1172,25 +1172,33 @@ static int get_dram_addr_map(struct addr_ctx *ctx)
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

