Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E365952008C
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbiEIPAB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 11:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbiEIO7y (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 10:59:54 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2045.outbound.protection.outlook.com [40.107.102.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E035B286F7;
        Mon,  9 May 2022 07:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKqdYVlJZXGYJeJ7TNT6waB8v3e2VEVpCoRqSew+u2C1TH2hXjKHx7lqT5hYMEwW4GpQCaCz8WcH0Thw7WWtdo0E0K8Li7SEUxT5v5oVGH0ouULzVZ4hRjWqQFxW6LhWfwP4lv5In2dFrrirIgidWhyaogHs0lezEk8p9OkuKOcw0VvJI+oWTSDuFYpb7NwmGPYNa0Wfv88Tc/G9Zba4DqC+yZCFcO4kPQRLd6Z/mL/bdCTQPAweiiCfUlkKikXnZT9STjoRxZ0XRm5GTy7kWN5kSoRDNxZp3bqVqfc3vCj3VzcGomAOAFgSXVsRyMwlimqGQo+quD59GE7tUMtC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YebxQgAHXOBxSeIMDxtNq1N4eqMyZybm+4tR4mO5C68=;
 b=HJlcJ3dyxUQLDCFAJpzh0+c5hwhlN/n3MN5KJiwJg/IyRZ3gt5yD8r6abHtAli4kL6ayumEFYb3yf6kSddGaLch5ESMn5MxF1dGhCesVTexWkG4frPmzYLkNhPYr5My3pBHJMUP3xxJ82TOuHKQHQF4XPV3ZqPo76UMnvqIDMP5hriEeq5lLTUjOmBzXFc2Rw6KZ73mBXmCXrLT9T8RXpg2LrU2AoC7y2IfJH3oqR9IHIJg35o7s9KjtkRboS4qfHtRI+5oBf4ZYLYBMoGsE4H8mn9K7iYr0jH3uJZYNGp/ocVx07NmyHQ5CNireiVL2in+V2x/EEeXZkOuW6E50Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YebxQgAHXOBxSeIMDxtNq1N4eqMyZybm+4tR4mO5C68=;
 b=GmQJp8ybbE2DLvH1dY51W/hmbDgQZKB0+262VLgPCoZT/RwCU0iNIEU6c7vsNrwfJYZNGKYNx2R7lkjQGWQ9doFIuuOO7yEsGJQJDEsgPDk7ovosR0xa2AhrCeiqMUGlDDtiOX60VJIwS2MK3hASkkjw3qB/EbRWY6bdfMHfjQY=
Received: from MW4PR03CA0008.namprd03.prod.outlook.com (2603:10b6:303:8f::13)
 by DM6PR12MB2890.namprd12.prod.outlook.com (2603:10b6:5:15e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 14:55:56 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::61) by MW4PR03CA0008.outlook.office365.com
 (2603:10b6:303:8f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Mon, 9 May 2022 14:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:56 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:49 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 10/18] EDAC/amd64: Add read_mc_regs() into pvt->ops
Date:   Mon, 9 May 2022 14:55:26 +0000
Message-ID: <20220509145534.44912-11-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509145534.44912-1-yazen.ghannam@amd.com>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81efa8d4-8866-47c4-2039-08da31cc05de
X-MS-TrafficTypeDiagnostic: DM6PR12MB2890:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2890598AE599124F46AA07C1F8C69@DM6PR12MB2890.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASB3G/UEmBaZfS7pf8HJ7GQHiIxlRjqKOG9J8isu9YZtomdvmJ33XUX4gx6XyHlXlhjnvtL94zdDM/9Gb2+/2575S3R2k0eCYDuSV2rnM3OBOzD8Uzb3/dR3hM5CPag9ze0lmu+4nXOBr8b/6C+NLXDbxcBdJcAGItsIJ+QobwvPPHCzBLleTusn00DltThx//Yi1nDaXlrBcizEt9KBJ0W0usw6SrzWlS5uMpZVW7SD9EziB1NSOwO1dXM/k8xa0TQCXA2kgqRUY84vTy3UGLkkMUl4WSR/nkSy21sbnIDmKxdLtFOa+7+n0+uJH0h6Cf49E306kjn0m4fmF4A2puslwXR08xea8tDng4ij0QyNPp4qWTmc0K1bivhXKq274OxFyhfVHHS6EtzXeqZcb7jeLdXV0AGJSGdhCgF+Xeq0/1rjEXB6wHAfa5gVCx36acZJ9IVgbo3rT9606KbpC/D8fyTEPIUhbwzTlaHybG1CKwzWRQoYJnnvYhqXzyWPJyo05O0auuAHrlq+YbNQqHr8j86Uqa5ikj7ymA0zWC13EUA4bnpoEeW/oS6n9tw/TXw1NJ+BjihZwq9yu/lSlSrA2/vEpS1jH1ed1xGnAROoYmjfIcuxh7KtxehfexwSHZOsHejEhaerv2SZDRREU+iRYboUGXJ5eb10fjxlpxULT4Rq+5E29V5StdwsT58JdZgWKDqh3mUyqbTxl5hDYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(110136005)(54906003)(508600001)(7696005)(70586007)(86362001)(82310400005)(356005)(316002)(6666004)(81166007)(2906002)(36756003)(16526019)(336012)(70206006)(186003)(47076005)(426003)(40460700003)(26005)(5660300002)(83380400001)(2616005)(1076003)(8676002)(4326008)(44832011)(36860700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:56.5848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81efa8d4-8866-47c4-2039-08da31cc05de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2890
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

GPU Nodes will read a different set of memory controller values
compared than existing systems. A function pointer should be used
rather than introduce another branching condition.

Prepare for this by adding read_mc_regs() to pvt->ops and set it as
needed based on currently supported systems.

Reading the TOM/TOM2 registers is preserved in the legacy function and
removed for the modern function. The values don't seem useful for the
EDAC module on modern systems. But they are kept for legacy systems in
case there was a need for them.

Use a "umc" prefix for modern systems, since these use Unified Memory
Controllers (UMCs).

Use a "dct" prefix for newly-defined legacy functions, since these
systems use DRAM Controllers (DCTs).

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 31 +++++++++++++------------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2a3205f1205e..1bf1660fe8f3 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3210,7 +3210,7 @@ static void umc_determine_ecc_sym_sz(struct amd64_pvt *pvt)
 /*
  * Retrieve the hardware registers of the memory controller.
  */
-static void __read_mc_regs_df(struct amd64_pvt *pvt)
+static void umc_read_mc_regs(struct amd64_pvt *pvt)
 {
 	u8 nid = pvt->mc_node_id;
 	struct amd64_umc *umc;
@@ -3234,7 +3234,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
  * Retrieve the hardware registers of the memory controller (this includes the
  * 'Address Map' and 'Misc' device regs)
  */
-static void read_mc_regs(struct amd64_pvt *pvt)
+static void dct_read_mc_regs(struct amd64_pvt *pvt)
 {
 	unsigned int range;
 	u64 msr_val;
@@ -3255,12 +3255,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 		edac_dbg(0, "  TOP_MEM2 disabled\n");
 	}
 
-	if (pvt->umc) {
-		__read_mc_regs_df(pvt);
-
-		goto skip;
-	}
-
 	amd64_read_pci_cfg(pvt->F3, NBCAP, &pvt->nbcap);
 
 	read_dram_ctl_register(pvt);
@@ -3300,15 +3294,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 		amd64_read_dct_pci_cfg(pvt, 1, DCLR0, &pvt->dclr1);
 		amd64_read_dct_pci_cfg(pvt, 1, DCHR0, &pvt->dchr1);
 	}
-
-skip:
-	pvt->ops->prep_chip_selects(pvt);
-
-	pvt->ops->read_base_mask(pvt);
-
-	pvt->ops->determine_memory_type(pvt);
-
-	pvt->ops->determine_ecc_sym_sz(pvt);
 }
 
 /*
@@ -3766,6 +3751,7 @@ static struct low_ops umc_ops = {
 	.read_base_mask			= umc_read_base_mask,
 	.determine_memory_type		= umc_determine_memory_type,
 	.determine_ecc_sym_sz		= umc_determine_ecc_sym_sz,
+	.read_mc_regs			= umc_read_mc_regs,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
@@ -3777,6 +3763,7 @@ static struct low_ops dct_ops = {
 	.read_base_mask			= dct_read_base_mask,
 	.determine_memory_type		= dct_determine_memory_type,
 	.determine_ecc_sym_sz		= dct_determine_ecc_sym_sz,
+	.read_mc_regs			= dct_read_mc_regs,
 };
 
 static int per_family_init(struct amd64_pvt *pvt)
@@ -3938,7 +3925,15 @@ static int hw_info_get(struct amd64_pvt *pvt)
 	if (ret)
 		return ret;
 
-	read_mc_regs(pvt);
+	pvt->ops->read_mc_regs(pvt);
+
+	pvt->ops->prep_chip_selects(pvt);
+
+	pvt->ops->read_base_mask(pvt);
+
+	pvt->ops->determine_memory_type(pvt);
+
+	pvt->ops->determine_ecc_sym_sz(pvt);
 
 	return 0;
 }
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 5e9ff6ea7ebc..25d0dcc5c480 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -472,6 +472,7 @@ struct low_ops {
 	void (*read_base_mask)(struct amd64_pvt *pvt);
 	void (*determine_memory_type)(struct amd64_pvt *pvt);
 	void (*determine_ecc_sym_sz)(struct amd64_pvt *pvt);
+	void (*read_mc_regs)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

