Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B5B43E7C0
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhJ1SB3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:01:29 -0400
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:18365
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231409AbhJ1SA5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSC7/MN+68zC1EfB5EB0hNHqxNiutKFChks2KUZqzJv5r1yIxIBHEreW0mJ4ViibZ9JVo9/i212fm+RXnp02sAanKKARk0C4ZKaZ7zjQws3vhMmsyAueZiKK6uRiphkfbMeMvTLx14fI414aa+RMA48vaLybS0EnVE1QCA0RQg0K4fpB6Vvqpkiml8mrEKqZJtxQryqXMNeQq7jTEeRyoj+rcuRrrkccxgRWcMaTz7Mudsljsuj9IzJCuS2jXtMnP37e6lrUnRw3o2l2RWGUjvla6mf5tTd/ienWHmgbwbxMDUySetZkXoi+9IDGV3aKAfGn+nC9dzTAk8lFObljeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPHIlopnv0KuPYe9SGFsIr9puPXeQOTnhvXEosJ6zGA=;
 b=O9In1Z8iDW5M42F+1OCoFsCtglooAE6mdhKVl6z3F5yy/J2gD9TrTOELMIJTj+WXeD7ADQD+CiG9tOWV4jYJ+6DrQQQ0vDqsKhH7hgtvrl3O0Qnt1lLruG8130AeryHO85tZsuHVCRLz3cRvBBLchrWzXNgMclRkiHxgeJ2EQQmcTR2RHU/5TEcvFjBcuBDdrsY2AeM/hSB3Xou5LNdWOsKPZZF/Y+alCSRvriBcoC9C4H0th/Hijv8U5RoyVjEW6deUIFmbQ7XsjB2n4p+kpFRtvwRvO1g812DvQUS4jG8WNFy3zWEVT/Ja7zwUVTkWuLF6qQMQi7g5TRIq8duSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPHIlopnv0KuPYe9SGFsIr9puPXeQOTnhvXEosJ6zGA=;
 b=mQfj0DU8jt6GQ5r9C2W1FlpGqQiYshjMpoC42wRc92+/eIQVO2SKQEGBMNBcDX2/Zoc1veT3efZ25UyI/oYk1mdMRWGn+Z3Y+1kAnf+8HCNbgUxH/5+qhPurILux8gc2H8TsqQzGu13d4779F75bytQSk0T/QxhO4bkXi/Nfhtk=
Received: from CO1PR15CA0095.namprd15.prod.outlook.com (2603:10b6:101:21::15)
 by CY4PR1201MB0101.namprd12.prod.outlook.com (2603:10b6:910:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Thu, 28 Oct
 2021 17:58:27 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::2b) by CO1PR15CA0095.outlook.office365.com
 (2603:10b6:101:21::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:26 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:23 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 17/33] EDAC/amd64: Define function to get number of interleaved channels
Date:   Thu, 28 Oct 2021 17:57:12 +0000
Message-ID: <20211028175728.121452-18-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bd52388c-8336-4ee1-9e82-08d99a3c8ae5
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0101:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01011809104BEAC23E10FD0DF8869@CY4PR1201MB0101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CaQDZtvNACn1/jAIHHPocuVmGffO73SuJvfk/tV3ySYqQJM5OibCw8JY+EZkAthq2sHQZMllJyJHgBnY+qrubX4mHf7FHxuODz6SpN5isTb8vGY+11iNF/NgX2h8oU2ZDSz5yhbChTM5xTKJTWRYUThQgZz6PaoD1ZkDhmN+4Y/a5+UEQ5ilM128/bTNDLOhwb7GCO0b80M3cTrUflOzRuWVYMTCzeZxh4aS4FlXm1A8xCntJDXUz4Y15z2ljPcVv+wzXxEmKEK6tsvq70MkXzXRRT3NRav6uOyqXT+SEJcwwiaKT2v5CjUu4TqYbLilDkaHe5at/NgAlW3YTsyNv+kN3jlncocEv3ujqS8+aTzSbKq+8rhUg3OOM6etlSslLjytwG/IxO7e1Y9hqMxnlqkQCj2E1qKy4fYBU5ZtbhyRV/zoMAwk6ngYgjTN4KY/oqhfuIOiO3NkNavHt7z0SHv7/9HJ6J3vhMz7nLQ5PB3K+MXMa28NSU3wJqKGnQqRxFUgmHZPLyZmAWZDX3s/ptxKaSfELDGD+PueLukzsndzbnZdELGEHdwZGlb1IinijGRCUsJjpPqQ6cKmi1YzqosrJgafQUS5WqzO7cIMYUlJSDEMvFw0NHeVWfzvnVJB2+UzFgv7IkRQsajfqHtDnSxTVuKObYgPFPfOjekUvPBBMAqXvoVTGDPuPCdxzxSGGeddLV8gt4gi40HYZHGiCCxVWb1oyL4YZ6X0bDS6m06yTPb6TIQ9YhIGwqg0snHZMSwQbUiGh9Q68FFLoVlNHgIbyc4miW50t6zhFWCscdv89hfN7GTWVp7S49hyIGK/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(1076003)(8936002)(70586007)(83380400001)(81166007)(4326008)(82310400003)(356005)(70206006)(2906002)(6666004)(44832011)(2616005)(7696005)(16526019)(426003)(508600001)(26005)(5660300002)(8676002)(336012)(186003)(54906003)(6916009)(47076005)(86362001)(966005)(316002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:26.7066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd52388c-8336-4ee1-9e82-08d99a3c8ae5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0101
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move number of interleaved channel calculation to a separate helper
function. Drop unused cases.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-19-yazen.ghannam@amd.com

v2->v3:
* Was patch 18 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 42 +++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b6a8366e40ba..11a54e7a0432 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1068,6 +1068,7 @@ struct addr_ctx {
 	u8 inst_id;
 	u8 map_num;
 	u8 intlv_addr_bit;
+	u8 intlv_num_chan;
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 };
@@ -1187,10 +1188,27 @@ static int get_intlv_addr_bit(struct addr_ctx *ctx)
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
@@ -1203,23 +1221,9 @@ static int denormalize_addr(struct addr_ctx *ctx)
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
@@ -1256,8 +1260,8 @@ static int denormalize_addr(struct addr_ctx *ctx)
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

