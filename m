Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D766520067
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbiEIO75 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 10:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiEIO7w (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 10:59:52 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F838268E8E;
        Mon,  9 May 2022 07:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnL/RZXHkhVMpokc8i5i3aDl3Ul1FrUiK7Qk3O5tcORPIPzdvi9MW8B/ennxjp9Mao+gIBOd7pRixShAiWXQddw7nIa8HSJeOygBR4m84Z+gMuSqWw7YaEUWfDE6iWaeRfHlNteCVgegnDkzsNgMPqRhG+FztP2CfilydvIIdirbXRg7UDo0OFOwDQhQWmu19bJuLI1rbQTkfgUz11+0utKh11A2Oo8UQSNYwdncAg7B6x7O+Ze7TH+fra0M+ox+Wa7q/xEaWGdYrpDswphoQn3vLWd7YQkWIUAUxbzkh+FtYjz2cyJ5K+PRox4S2Vtkava7TsceRg6XyHYHhWHnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTV4kOvmAPz8ymyzx0EcyPZFuHzGTaxJlCcMO/JUQhE=;
 b=cwiPxpbEyKLXu6fNStcj4LUiCujBw1pUaqq3N5I3w6DTquw3z2fuwsCQ6zu9EI5XwNQgeMAW+JAMF9EM4hgJ5SorrhvcT37mNAJbY2DTBcieItbCqi8nCXG/JgmmWofGE3cZOYvoWOmQGpfttMzja+LY9I++OaTeQp89gCpCrhcbzVFBWIeKvYkdk08RPEHB4NDDSO7TPB0hrPSeA5xZiJP+VKFOp8B0OvVzyw7Jtcsc7sTESoe7PkTgF/qM/5d75/b4q7+rWB2UqNtON9UzHSpP/eMUaOk+IaUdOS/EmEceE3hVWQOi+hr9g7Q/5IpgIYtdpK1OVJ6jxD34RI7hwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTV4kOvmAPz8ymyzx0EcyPZFuHzGTaxJlCcMO/JUQhE=;
 b=o+GrLuVOaCq+Vl/JAwa1wr+ewYDAilQ+NQy6szHbt7oG5QeDNo5Lcx14vvnt9hyokNg1l5+qa2jDbYqTzOT7ayRvkIX+NhKX1j0vp9NljSn/uTgFCegQN79jABLEdfX7V45CZDSBHPaItVVsuQVvR7R49oXN5Uck7QQ7GwxuzSA=
Received: from MW4PR03CA0302.namprd03.prod.outlook.com (2603:10b6:303:dd::7)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 14:55:56 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::d7) by MW4PR03CA0302.outlook.office365.com
 (2603:10b6:303:dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Mon, 9 May 2022 14:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:55 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:48 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 08/18] EDAC/amd64: Add determine_memory_type() into pvt->ops
Date:   Mon, 9 May 2022 14:55:24 +0000
Message-ID: <20220509145534.44912-9-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 84e6ef3e-585e-4a3f-94b5-08da31cc056a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4296:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB429679ED9BED53A99AACF7B2F8C69@CH2PR12MB4296.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qU6ULGF3JOrkHQzmPKoNazHaEyp9yblMM7vGCk7Ixtqcwj3fFHcBvkG43dFVplEJIgRs+p78arf9vABjawgOJasZa7Cp1xFUAzUoHdoCjqSrtP0cVJCYdrMUHsk8FzEHu3CAK94TAvmr5+cx8x1cj8QlZkJG+yQEj95OrwjA2DhWMAKVL9ONPpatY/ZJlH9UdmAyeqzGwvZhIwg1NHuhwOIiDAX/CwkS0/AHIse0zJcjAsm25XYbaaAqbWRjLmQt7fZGdLxrdDknqZI5djSt5+OeUQcqNRW6WHyp2qB05uSGKVHXMK1Rvxw7l+OKuvl95+HNjz75iu1oZNa32/nT4+DHlRqsoPglsp0wjj700UJdrPBigvq/c25Qh6ZRjXfjcwKPW0bt1ih7/pxwuvKDUDka8IgcqhUdYCpB1WxuuYiQ84RnS7HG+5iPCCTxtPKtd8nikxUh5SHYDUGNvoaJsw6WYIOp0f3yaW+5anbinrInlceevLYTdq6LiNv92coq0rKeQEW4l8hOwpfGR1lbP/q8pQTHMJ7kS5eBEUuR6pa0lT/SooE8X+mUN3W/rlJIWJd2Hnjn2S+DjCFSHRpxJWYZ9MJIEWq8mkS6nk/pSeqTyiXoXj8F0f0LmWC7S8vTsGsL87zHNHezMsOs36HMx5IchTvgTzlcuL2y07FRZtagSOy+sc0HCR+UmS8HVoxVTpqvIWJHJMUCaKKrcpkkZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(8676002)(83380400001)(70206006)(70586007)(81166007)(40460700003)(2906002)(356005)(336012)(110136005)(36756003)(54906003)(508600001)(6666004)(7696005)(316002)(36860700001)(82310400005)(2616005)(26005)(1076003)(5660300002)(186003)(16526019)(86362001)(8936002)(44832011)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:55.8431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e6ef3e-585e-4a3f-94b5-08da31cc056a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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

GPU Nodes will need to set the EDAC memory type differently than
existing systems. A function pointer should be used rather than introduce
another branching condition.

Prepare for this by adding determine_memory_type() to pvt->ops and set it
as needed based on currently supported systems.

Use a "umc" prefix for modern systems, since these use Unified Memory
Controllers (UMCs).

Use a "dct" prefix for newly-defined legacy functions, since these
systems use DRAM Controllers (DCTs).

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 16 +++++++---------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 6e26bbb73f81..a767d8a6bfe8 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1604,7 +1604,7 @@ static void dct_read_base_mask(struct amd64_pvt *pvt)
 	}
 }
 
-static void determine_memory_type_df(struct amd64_pvt *pvt)
+static void umc_determine_memory_type(struct amd64_pvt *pvt)
 {
 	struct amd64_umc *umc;
 	u32 i;
@@ -1641,13 +1641,10 @@ static void determine_memory_type_df(struct amd64_pvt *pvt)
 	}
 }
 
-static void determine_memory_type(struct amd64_pvt *pvt)
+static void dct_determine_memory_type(struct amd64_pvt *pvt)
 {
 	u32 dram_ctrl, dcsm;
 
-	if (pvt->umc)
-		return determine_memory_type_df(pvt);
-
 	switch (pvt->fam) {
 	case 0xf:
 		if (pvt->ext_model >= K8_REV_F)
@@ -1697,6 +1694,8 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 		WARN(1, KERN_ERR "%s: Family??? 0x%x\n", __func__, pvt->fam);
 		pvt->dram_type = MEM_EMPTY;
 	}
+
+	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
 	return;
 
 ddr3:
@@ -3302,10 +3301,7 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 
 	pvt->ops->read_base_mask(pvt);
 
-	determine_memory_type(pvt);
-
-	if (!pvt->umc)
-		edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
+	pvt->ops->determine_memory_type(pvt);
 
 	determine_ecc_sym_sz(pvt);
 }
@@ -3763,6 +3759,7 @@ static struct low_ops umc_ops = {
 	.dbam_to_cs			= umc_addr_mask_to_cs_size,
 	.prep_chip_selects		= umc_prep_chip_selects,
 	.read_base_mask			= umc_read_base_mask,
+	.determine_memory_type		= umc_determine_memory_type,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
@@ -3772,6 +3769,7 @@ static struct low_ops dct_ops = {
 	.dbam_to_cs			= f16_dbam_to_chip_select,
 	.prep_chip_selects		= dct_prep_chip_selects,
 	.read_base_mask			= dct_read_base_mask,
+	.determine_memory_type		= dct_determine_memory_type,
 };
 
 static int per_family_init(struct amd64_pvt *pvt)
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index c81cc7f5fc96..da3db0f4f59b 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -470,6 +470,7 @@ struct low_ops {
 			   unsigned int cs_mode, int cs_mask_nr);
 	void (*prep_chip_selects)(struct amd64_pvt *pvt);
 	void (*read_base_mask)(struct amd64_pvt *pvt);
+	void (*determine_memory_type)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

