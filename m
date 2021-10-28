Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D816543E7E3
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 20:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhJ1SCh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:02:37 -0400
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com ([40.107.236.56]:57706
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231348AbhJ1SBT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TatY9g44PakhEHa0LE10Fy8WFqWFB88a894HjjY12bts4qja95qek14VswjARHu1hHdGrDVmcYi9yB0kCvQLkAssbiChqJM91xNMXwZUWFT8k0pqYf/jnlXfBEF2v41Sh+Sbw5LmyJqqPl/gTxJwZ+wd08oZzMJz+qE6zngB0ADpS1d3TXEKTDRaEHGoiK2NH5R25eyMCatBa3n8byteqYOP05ONWydr/B4gF8r9sS0GRQZS6oyQiVkTIJI8BE31ss7HqkT9z9dxaqZ0b+f0cJtuFKIxKKcb4DnK+segr76BdVDpKYxGcZJvwEaiPItfrW/tikbXtcNkn49AxH0zRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5U30FZPq/SOGltpvFF9AqSiVms9wXX02GWSFm6KmSE=;
 b=DR7H4hJwWNIa7CD4H3ohC3RV+FphlHyZJjpMChLENBIR/Hbe87NUktDk3Q9BO6g3e+eGE2rLOFD90SC3FFI/5mu7hgNF5t496z1eeQZPMoS82Fjou3XfLaKhrc8+nhpRRGPgebzBxDBz1iRZyIPxr3qjw6c1z2ZilT4bS/OF67CSJ/HGRmHl1bQSRdU8x00RMg4NmjKYLlgE9Nf2/T4tu3mnO+xcd0KOBi6vsE/gtadtgvcMmOyna144VkOi1DOAz1Yb6YSSsDv9xUoYMOksgz9V5HsjfyrFkp9gqRtmTyahhliInUA71qVdEK7zvQ0pD0ev7dhq/KIN/7cWhkjT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5U30FZPq/SOGltpvFF9AqSiVms9wXX02GWSFm6KmSE=;
 b=tkK4wpV9pXvCTmRSGNaTy7NEjbgKkN++T5xhIF4KyTAoF5YK4BpgcbWXlQHKZnh2AG3X6M4zrwBa49vOW/C6ZbTXkEhihW8MpFHLwWcJI6V4wbPDk3Bw+dPt/3JkrcEebvCbAKKWXVIkZnkq0UyRz8dEmLrk9g9nMnX8IjQPSvk=
Received: from MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::8) by
 CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Thu, 28 Oct 2021 17:58:50 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::91) by MW4P223CA0003.outlook.office365.com
 (2603:10b6:303:80::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:49 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:47 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 32/33] EDAC/amd64: Save the number of block instances
Date:   Thu, 28 Oct 2021 17:57:27 +0000
Message-ID: <20211028175728.121452-33-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: cbe5a2b3-23eb-4f89-74a2-08d99a3c98b1
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5284A155A71D04443EFA40ADF8869@CH0PR12MB5284.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8H1H0TPSks1gXRGWcADM2rKvu/qSLiuBaN5jMGh1/QBVUp2CsvLAUR3cHuzCm9GiCpfm9WuXwgB5axEfCOfWeYoNuqycZrcdJQQumRBoGWpNIXjNPU1DEIFLdX2NRKSE61Gxaf82NUKkfi6xgOKmZ4agGTyF7HZzZPCPnMsVbrH7Jnbuy+V3uyac6TC01QV5pq3uqZvhW9j7AwfStdaKZSyqtTpxc2go1YzvJU+EWOBnGUi3Wg8/lF0lKF4HKo5et8CIZEVsGj01q2WnHrHRKAugLPEprkH57xy6j0NrDsZULG4gV7bdaj3aaL+vvJX61XCcLWO3fEztrF9rQkTyPL3B4zhTQGbg3GzbhWBY8ZD+THR34Rm8uOW8quC3dMGY+2svJ7FVJt4kRLCqQyXFdi9HT2RMTemK6qWv1A0fHj3nqKxL4jnNa4hYhaHmNP3YBebt7BcmACjl7dCi27MlRD9EZ3Das3efhGduSxzb7CrqAmS9eFBxkjWfiljO0XsZvWMtdzSt8qkbP5dfxHWDXsPUQ+t914l8DyT29+6WpEp3T7+1VteJYqHtXzA/bJAnZ6BbwarXehjy3M1D+by1SonQm8wptJ7Q/tyS1UTOviR2oLvNTfT9TJG8+8WceMJBzRL1L9tZkB7CmENHIxMMBF4Yf2l+g4jWRcsZ6aIo5f1/i1TegrPAh2/Q0qmBsWs/Fwj47xxhAcdk9gotnD1/WnUyJyU/v+xble4WHYEMgw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(7696005)(1076003)(5660300002)(70206006)(356005)(81166007)(16526019)(83380400001)(8676002)(186003)(26005)(8936002)(4326008)(54906003)(6666004)(508600001)(316002)(36756003)(2616005)(36860700001)(6916009)(2906002)(44832011)(426003)(82310400003)(336012)(70586007)(86362001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:49.8378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe5a2b3-23eb-4f89-74a2-08d99a3c98b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5284
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Cache the number of block instances. This value is needed by future DF
versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
v2->v3:
* New in v3.

 drivers/edac/amd64_edac.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 07009901a283..bc1aa6292408 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1092,6 +1092,7 @@ struct addr_ctx {
 	u8 intlv_num_sockets;
 	u8 cs_id;
 	u8 node_id_shift;
+	u8 num_blk_instances;
 	bool late_hole_remove;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 	void (*make_space_for_cs_id)(struct addr_ctx *ctx);
@@ -1417,6 +1418,17 @@ struct data_fabric_ops df3_ops = {
 
 struct data_fabric_ops *df_ops;
 
+static int get_blk_inst_cnt(struct addr_ctx *ctx)
+{
+	/* Read D18F0x40 (FabricBlockInstanceCount). */
+	if (df_indirect_read_broadcast(0, 0, 0x40, &ctx->tmp))
+		return -EINVAL;
+
+	ctx->num_blk_instances = ctx->tmp & 0xFF;
+
+	return 0;
+}
+
 static int get_dram_offset_reg(struct addr_ctx *ctx)
 {
 	/* Read D18F0x1B4 (DramOffset) */
@@ -1621,6 +1633,9 @@ static int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 df_inst_id)
 	ctx.nid = nid;
 	ctx.inst_id = df_inst_id;
 
+	if (get_blk_inst_cnt(&ctx))
+		return -EINVAL;
+
 	if (df_ops->get_masks(&ctx))
 		return -EINVAL;
 
-- 
2.25.1

