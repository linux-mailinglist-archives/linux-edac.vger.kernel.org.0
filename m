Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670B24A8ACC
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 18:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbiBCRvC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 12:51:02 -0500
Received: from mail-mw2nam08on2076.outbound.protection.outlook.com ([40.107.101.76]:29312
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353123AbiBCRue (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLGCiudrrFG2TLk5Uwgiv8qQHJpXTN5KfCor+h0H3ShZv+09zyNIWlM6y4RbreDdusDv/zw4QogpjhA3+L9fLOjas0SpXWbwTQGfQO9oAxDE51OBjv20zvrIEXkLSxildxZ2TDGmcqngEXJRLaZr09XS6qgOBcysnc4mSM7aNMdyxIMg4QDEiy2rX0Gk135h/iJvLcgXxp4wcIHYKLBOg7nffAnJj5oAdQtsP/U95hdOOWZB6P62EMS0gJ5DKZ4FY6zb6DIXJeOby8E9LX3b0uXJnqbQjv3sl4LrOIrQ/TG/EN7HXr5x9Iq3A012K8LYld2mISMyIuWwp11k22FzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0na8pE85ewegPop5SuJcM8lD8Rd2Om0ZDs9i85errHM=;
 b=U0/HvqExzsS6KnzVvFNpSWg3zoecFYzjRttqCf5j8KMiiRaOz7Z4SJOnAIOxAFEYm6f3PUIVMZ3q3WKRzkfEmBXE5G5OhnwPmdyv9ycvjhPE/iRnPk1K7BYEc2u+b13ZdOAqL5DYtolP/fC5hsbM4gsW4Im0EbgskfXfjNX3eMdZmgte5c695sFqlZDR/o7CKR9Owa3IGsfYEBEuoLb7s5yH6QGT/EZiX9/TklZxD2ETAPDbMVg9tu/xa/YX+KIwzTXQypJVqwm4i9kbYhEobpSBJqm6BPOd11PyUpd/4gmFPYXzgLuDoVmJbO2p5ObAf82dnmRMzg75MG7nGWJ23Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0na8pE85ewegPop5SuJcM8lD8Rd2Om0ZDs9i85errHM=;
 b=EuSDrCAFeRWvd4Liu+Kdjf79YlmmMFoiq6G9xrBLjPd/DVD9AoT4540txgh+NKFAKxQhRGgcFUurlRLNZXb2V20548PD9RyvFQguFWpOhFAkUHkRXCtqLR5MYMxxOHYWpdb2SFPENsEYLVKZQ0oBRzXKMQPw6J7RzZoDO9X5WxM=
Received: from MW4PR04CA0301.namprd04.prod.outlook.com (2603:10b6:303:82::6)
 by BN6PR12MB1747.namprd12.prod.outlook.com (2603:10b6:404:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 17:50:31 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::a1) by MW4PR04CA0301.outlook.office365.com
 (2603:10b6:303:82::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Thu, 3 Feb 2022 17:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:50:31 +0000
Received: from node-bp128-r03d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 11:50:28 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v7 10/12] EDAC/amd64: Save the number of block instances
Date:   Thu, 3 Feb 2022 11:49:40 -0600
Message-ID: <20220203174942.31630-11-nchatrad@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203174942.31630-1-nchatrad@amd.com>
References: <20220203174942.31630-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c313758-e2c6-4041-5a77-08d9e73dac0e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1747:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1747270B93420E07234A491BE8289@BN6PR12MB1747.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +18qSuedfKmjPiT5wR2b3SNnRmgCMnXjoTNVb2FXS4CBPje4cClPATsvZu3n+2oC99lJ4ylkT5N5KvOHJzCj1OwpZ6EDp69a6DCz3Ejks5J/Bv7pzOwDYsKA6GucnYbMSAl9GR0tS2OFGudpGHVX3aOoeQrM/sOloqXPInH2aA9OQefTKnZVJookcMDp+qR7neDILVBU8q70Rl9WQKnlaHJvw7O5d4Gx2F3TwbXte2eK4qNYHzcAyDchPD0IFhsjLxSmSsQCSXDVOVsn/Np28DTE2Z0v3lKMl/osaMfYYV1B2O65Ea8PULBDDm8RkLqTYmItKGZa+VY78fNLS84cAMejUV9dj/IKWgcYHizDPB7vM+OjKJzFDaoFG8IhxmOZpb6f55q+1+AxtYI9ftNBIEpFArjRxAYYBSg4s03tvYXAIA8QJwlIwjmqmhfkG/ewh4Zv5c5gauhHli5LUjQZBNzvDbBAAEMLzKgOCP2rvY6yr91XPYBWfK9ofAD7YDWl/WYdRrfbRVyM04vmhMXe2GFbZ6LZqSOGx/naoAn1pxcl569mgb19cz9DAOJFFcJeGe+TkGYjvmFSSv4Aak4q2ei/Tda3jBrtgsVjCwpY+zX9OaKM8JWCchqy0dOw25kuu4/l7ScGHpq4VQdwVtmo0+A6ajfeMMiAHsJ8Isp8N5m3b8ccdGQa4JBa6gVV50KdRjsg/ROAPk/yP7YYHkHDYwR/ErmA18GmfDZGxT1TcTp0wAGSInoZFEoeEYYx7ewJPVKSW1G/1Ue2QuhQ/wKSmVa769OM0XrWPpJAuq68xgQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(966005)(5660300002)(40460700003)(54906003)(47076005)(110136005)(316002)(83380400001)(36756003)(4326008)(70586007)(70206006)(82310400004)(356005)(6666004)(7696005)(8936002)(8676002)(508600001)(36860700001)(2616005)(186003)(336012)(426003)(16526019)(26005)(81166007)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:50:31.3560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c313758-e2c6-4041-5a77-08d9e73dac0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1747
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Cache the number of block instances. This value is needed by future DF
versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
Link:
https://lkml.kernel.org/r/20211028175728.121452-33-yazen.ghannam@amd.com

v3->v7:
* Was in patch 32 in v3.

v2->v3:
* New in v3.


 drivers/edac/amd64_edac.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 0f35c8519555..8f2b5c8be651 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1112,6 +1112,7 @@ struct addr_ctx {
 	u8 intlv_num_sockets;
 	u8 cs_id;
 	u8 node_id_shift;
+	u8 num_blk_instances;
 	bool late_hole_remove;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 	void (*make_space_for_cs_id)(struct addr_ctx *ctx);
@@ -1437,6 +1438,17 @@ struct data_fabric_ops df3_ops = {
 
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
@@ -1647,6 +1659,11 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	ctx.nid = nid;
 	ctx.inst_id = umc;
 
+	if (get_blk_inst_cnt(&ctx)) {
+		pr_debug("Failed to get Block Instance Count");
+		return -EINVAL;
+	}
+
 	if (df_ops->get_masks(&ctx)) {
 		pr_debug("Failed to get masks");
 		return -EINVAL;
-- 
2.25.1

