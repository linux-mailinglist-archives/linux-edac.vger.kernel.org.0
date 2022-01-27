Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594D449ECB0
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344201AbiA0Ul4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:56 -0500
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:31584
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344170AbiA0Ult (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc9dMgF0AU9ZKo5OksVNfbB5uUtedmbTX9sZppFR3uoPujLw6nzRaS5dyEkYEcEGRGYNFjATaoJ+NFVZI69drdunNXGXJ+HWy89uuqY/qN1JJCa+AbpTRMOcxJXYYOCm1GclT52wD+qLmM1geKlbnWzaHbW8MR7X5A3SYld0bLC0qyF/FIApXSlcwRdVEY1r56YucFmMJ4dsEae0wyElKOEpLOwEOw03Sl3XmMLX7BZtK+UZIgbKhaDq1pD09SwgDO45DKuchuhXVaIdXgKqxdRyBQjGP7kzpcL7LMuHUc5H+g5HcIaeF8JCgJ88G330vQPnzkyONTK0hPECULdN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jo/Et5VALcn6tpVqXVhBUxbxss74AMhNtlpjV2aYE1A=;
 b=WO/mv3qkYaMyXGH26bVcp3kpM9HjlhwZAFsPxiBXrxJgYOophXxW86GdtnYybTZE5QENKPApdEwJyDLJHqo4COYpIy/yr78hGz8IppOT1FAllkkAeUlcDb8NK3paBNelwNip7WmBmiyC67Dhly548/efig1PmUj4MPPcepJdWJfWyif6y8pSs+Swq4UEku5Z+u6sBWEiLvqS195EzFNxmr5hkdXLfn960z6t/OANatlC3Yw6zzcDKzX4+wpclqcg1bFNH457ZzeubA+hp04XTtk6oFsMwEf0F5HCsexLVIf2e2qNVmgcjwp3N4W1DQncfl6wx2jZmXwtgIDCxYCBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jo/Et5VALcn6tpVqXVhBUxbxss74AMhNtlpjV2aYE1A=;
 b=s9jjhRgbp7C/odQwvofjVM/ei2TMKlIFWmdCa80OVOZJt5BIQ++oz9A6OsjiiqdeIlue6ibBwX1VnvMxpCnTt5eyyvCgfdNkFW8iwcYcrr18l3/2wij1tfOYbu4nXGEUhD7qBtzzCg+rfpg72eyfZK1NMU3mM76//5+g7eJindU=
Received: from MWHPR17CA0084.namprd17.prod.outlook.com (2603:10b6:300:c2::22)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 20:41:46 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::2d) by MWHPR17CA0084.outlook.office365.com
 (2603:10b6:300:c2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:46 +0000
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
Subject: [PATCH v4 12/24] EDAC/amd64: Define function to get number of interleaved channels
Date:   Thu, 27 Jan 2022 20:41:03 +0000
Message-ID: <20220127204115.384161-13-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79944e87-69bc-4276-d024-08d9e1d56fb5
X-MS-TrafficTypeDiagnostic: BY5PR12MB4115:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4115402C142B73D2159C023CF8219@BY5PR12MB4115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JHcvOGvSXIclGDOpobCC503EVg1lZME1Wkq3/e7hjaB4VEff4Rqc+ub7uWl9nDcoaHk5bTAgPrOi/dIiVihQul8p4pAr1wLfyHlT0SLm+jLRfLb/x8sL0PzkBqlaHAQNBD7hO17/kYX9JSTEOoUsj6MC7iACytb3895DCXKVZptB6ukSMN+kXJZIL9cY1j+7U3eK+f0ClmO9W69z/uLTqz6YjJAuCcl1uvFdwXjrLK3Xz4Rzm2VUauT8rvcDIW8Q5sLXPrDHjoUdON4/qw/x03NH+Nb2+/mLaZJF304dGXd8W1Rng0uDqE6zd+2DcKLCRksfJsxOPu0Q3Me7ZEOSDC/DUwZc7C9ttyZ3jtxZx59fzKyNXzEgslhiT+mTB+l4mQ0OxtcI0l0INGgwRI9QCLrMQyn4P/3OKyR3Z/yWgFyKDJ6Sq95fM+CRpXHTqpzgRxXX5HPqTxAmb675o8hxCRR7fOmhd8YiwDtQgPRezu9Gf2inGE3Yed9V1kgZmzOuADxctajrQrIexJWC50KoFHCIFOlsqqQNUuNqIzLwvK6t6ch5kvoG92B2g0s5TkRGJ23P5pw06vyD5BANkQhqweAYvwmfTHSeVziXoOdfVFCp9AVrQrroOqGIEngrBPNyEXGpwCTI7F5SpMHkJ3CC3f7HrmVqrGHPCIEGo/sAs2PhIDtUS+//OZxL56rBcEb8HToVzDVEEK66oC/HIIpiB+sVSbFw5trDS2tounxa7+ayokmDdZzZ1/QA0jx7BPQGLeYbrnppZNhIMS4A0WrbJiCKfJjyQvICiwY2s0Ears=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400004)(2906002)(426003)(186003)(316002)(26005)(5660300002)(47076005)(86362001)(1076003)(2616005)(336012)(6916009)(54906003)(16526019)(83380400001)(4326008)(966005)(36756003)(70206006)(70586007)(356005)(8676002)(6666004)(8936002)(7696005)(44832011)(508600001)(81166007)(40460700003)(36860700001)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:46.6074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79944e87-69bc-4276-d024-08d9e1d56fb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move number of interleaved channel calculation to a separate helper
function. Drop unused cases.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-18-yazen.ghannam@amd.com

v3->v4:
* No change.

v2->v3:
* Was patch 18 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 42 +++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b75311acbe13..87439374a076 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1076,6 +1076,7 @@ struct addr_ctx {
 	u8 inst_id;
 	u8 map_num;
 	u8 intlv_addr_bit;
+	u8 intlv_num_chan;
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 };
@@ -1197,10 +1198,27 @@ static int get_intlv_addr_bit(struct addr_ctx *ctx)
 	return 0;
 }
 
+static void get_intlv_num_chan(struct addr_ctx *ctx)
+{
+	/* Save the log2(# of channels). */
+	switch (ctx->intlv_mode) {
+	case NONE:
+		ctx->intlv_num_chan = 0;
+		break;
+	case NOHASH_2CH:
+	case DF2_HASH_2CH:
+		ctx->intlv_num_chan = 1;
+		break;
+	default:
+		/* Valid interleaving modes where checked earlier. */
+		break;
+	}
+}
+
 static int denormalize_addr(struct addr_ctx *ctx)
 {
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
+	u8 intlv_num_dies, intlv_num_sockets;
 	u8 num_intlv_bits, cs_mask = 0;
 
 	/* Return early if no interleaving. */
@@ -1213,23 +1231,9 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
 	intlv_num_dies	  = (ctx->reg_limit_addr >> 10) & 0x3;
 
-	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
-	switch (intlv_num_chan) {
-	case 0:	intlv_num_chan = 0; break;
-	case 1: intlv_num_chan = 1; break;
-	case 3: intlv_num_chan = 2; break;
-	case 5:	intlv_num_chan = 3; break;
-	case 7:	intlv_num_chan = 4; break;
-
-	case 8: intlv_num_chan = 1;
-		break;
-	default:
-		pr_err("%s: Invalid number of interleaved channels %d.\n",
-			__func__, intlv_num_chan);
-		return -EINVAL;
-	}
+	get_intlv_num_chan(ctx);
 
-	num_intlv_bits = intlv_num_chan;
+	num_intlv_bits = ctx->intlv_num_chan;
 
 	if (intlv_num_dies > 2) {
 		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
@@ -1266,8 +1270,8 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		die_id_bit   = 0;
 
 		/* If interleaved over more than 1 channel: */
-		if (intlv_num_chan) {
-			die_id_bit = intlv_num_chan;
+		if (ctx->intlv_num_chan) {
+			die_id_bit = ctx->intlv_num_chan;
 			cs_mask	   = (1 << die_id_bit) - 1;
 			ctx->cs_id = cs_fabric_id & cs_mask;
 		}
-- 
2.25.1

