Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9204C717A
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbiB1QPL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiB1QPK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:15:10 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097024552E
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHzBO0ZPGRwnT4WekDeJeuACgLQQLhiA6+iI5WG9BbEHLuHioBB7zSASFrrBpxX1ld95KnVhPvCKg6gWcCsRj/IdQ50bNGYSi2TJCW0lF5Adwsdo9mqdIbDHaaDMC4O/JCAziT9mKiLj6z4a4NzJZ0UnUCU/+elnGPtUhN7dzLH02xvNOeSua5r5pLQ5yYJp9EHPNlZ2ZGIc+gKrKEhnyNjlAQWdFdX4o1gh9jyF4gFI7ANZ3kcTme98K7K8PzO6lH95Av5i51mlcRbV4znraxl2JhlzPvHeFV5sjNe4gcZbfKEBXeguDzS7nvZSbsiVdJF46QyF3Bt5VujkYzWPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLfYqXiRMVVUCn65g27HBErUApmgpVy+1mS+2yHEvE8=;
 b=e5a8FhekpZmJ4fz6Q+xohwdUyGpyK+3D7S/5GD+to4ZnirdvyJXLlGzFOx4n6r6Slt5GfKs076YhOTApafDPhgfpoRkz/2Oj5kpIlLfsT+zH7E6zX17yn6l0p4VWL/+hbiP9iedxE+/vzc9F0PdGKzDW/Rl6SkTrvfv8zzYI5Jbw5yO9ExH4G0eFRWrvx4RgNkr8YrAaGPx7U5r+4n046up7XgSW+hOfFxKBLYfL1MutFPuJAUDEig4yc2do+65T15TzVbLLpIJcHIaqK12KPb7s7XmBctwwV2HQdKK4mi40jV9D/gmHqmp8140JeyFegJpRNWbRabPdoLGPYM8nRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLfYqXiRMVVUCn65g27HBErUApmgpVy+1mS+2yHEvE8=;
 b=BJ51vcc13zBhMUV6C1NVVKix/YX8XFWfLoUe6HV/AXYeiWRdSRdPuVCgNXJ51/N+I4FmTsJ6NMnIlruSt/yTZ9qf0kHfWhKMdQru/CeX07VDcLthikCMk6y0H6xexfelOpDDCteVBtNH9iuYvzpTahhcxY6j/0JSOlNQ1Bb098o=
Received: from BN9PR03CA0918.namprd03.prod.outlook.com (2603:10b6:408:107::23)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 16:14:28 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::64) by BN9PR03CA0918.outlook.office365.com
 (2603:10b6:408:107::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:28 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:26 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 04/14] EDAC/amd64: Add determine_memory_type() into pvt->ops
Date:   Mon, 28 Feb 2022 21:43:44 +0530
Message-ID: <20220228161354.54923-5-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220228161354.54923-1-nchatrad@amd.com>
References: <20220228161354.54923-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b1aad82-b7ad-4e70-bd9e-08d9fad56596
X-MS-TrafficTypeDiagnostic: MN0PR12MB5980:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5980D084D42D33EF0DB685C1E8019@MN0PR12MB5980.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZgwDiyq+JSm8DobSHNt2vEEj05v+is0mmS/b2J+W4QAgXrpnMTmva6dnOEZUtTJEUFhHCP2IHY9/70y9KySjaemVWf70PKf3uxngywEjGkwofkNgksYK7zpSMrNEy1fUcLWLY19iY7Wo8DnTsmA/jsjIOiSbLd+iRNLpsYTWDcQ+eePomZ5vKzX05OxpSiFYoHTDjVGhbYpLaFXbYrS4lu8HLb1H4UterLZDNLyMqZ6njCnTMoSAavUNAF9qSa0Q/pYtL/j4KLy6pGY/8hYMQ8PLR11NBbp3Wg95Xk+07wUCO5tRxvIQeueCk5ZS3QzkvwwdEG88WNE9jsoOzMzOp/k/vxbTOmzCE/lkBcBed+Q8d7+ja/OcH3MyOHjmUT7NCpKy+BvFgo3x6wX4NvlAFPkDXK36y7iTTS7L2wc+jurJ+zgOWSZ1bd8VkFB1ptfRtasfUQCvF8Tp/41Jb8CEHYZN01subxq4jcQA/dLliskB4EQwSNPjHtLYWflgRk+ahCPe28p+vJxPUkqy61eBgUt432IhgmaHUNAV+W7AiLp2RAlhnrIU+haDAK0m0v08c9C+9gK2vMF6DKH2UG4ZSi+s6OlX2IraoeBS4gI43D1p0G+Dj9LjSjD+/Pu0kJ9BvVKF99Wmh7A/M6Xv8xhW9qN/PrMR3+0X/lx2WEoWWnkiwt7ecgIkLcQFR0vmIMgG6GC5Io2Vh96LDphQIhV0d9Y67wd1eflxw8foRYa0wdv/DT5zkrm7b4iHcBJfIIOPya1JHZhc223hujd8kEttiapWDZSrAboBmD8q+Ndenc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(83380400001)(186003)(356005)(1076003)(81166007)(8936002)(2906002)(70586007)(5660300002)(36756003)(26005)(70206006)(4326008)(426003)(336012)(8676002)(2616005)(508600001)(6916009)(316002)(54906003)(82310400004)(6666004)(7696005)(40460700003)(36860700001)(966005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:28.8366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1aad82-b7ad-4e70-bd9e-08d9fad56596
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Add function pointer for determine_memory_type() in pvt->ops and
assign family specific determine_memory_type() definitions
appropriately.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
This patch is created by splitting the 5/12th patch in series
[v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/

 drivers/edac/amd64_edac.c | 33 ++++++++++++++++++++-------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 708c4bbc0d1c..07428a6c7683 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1632,20 +1632,10 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 	}
 }
 
-static void determine_memory_type(struct amd64_pvt *pvt)
+static void f1x_determine_memory_type(struct amd64_pvt *pvt)
 {
 	u32 dram_ctrl, dcsm;
 
-	if (pvt->umc) {
-		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
-			pvt->dram_type = MEM_LRDDR4;
-		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
-			pvt->dram_type = MEM_RDDR4;
-		else
-			pvt->dram_type = MEM_DDR4;
-		return;
-	}
-
 	switch (pvt->fam) {
 	case 0xf:
 		if (pvt->ext_model >= K8_REV_F)
@@ -1701,6 +1691,16 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 	pvt->dram_type = (pvt->dclr0 & BIT(16)) ? MEM_DDR3 : MEM_RDDR3;
 }
 
+static void f17_determine_memory_type(struct amd64_pvt *pvt)
+{
+	if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
+		pvt->dram_type = MEM_LRDDR4;
+	else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
+		pvt->dram_type = MEM_RDDR4;
+	else
+		pvt->dram_type = MEM_DDR4;
+}
+
 /* Get the number of DCT channels the memory controller is using. */
 static int k8_early_channel_count(struct amd64_pvt *pvt)
 {
@@ -3309,7 +3309,7 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 
 	pvt->ops->get_base_mask(pvt);
 
-	determine_memory_type(pvt);
+	pvt->ops->determine_memory_type(pvt);
 	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
 
 	determine_ecc_sym_sz(pvt);
@@ -3785,6 +3785,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->dbam_to_cs			= k8_dbam_to_chip_select;
 		pvt->ops->get_base_mask			= read_dct_base_mask;
 		pvt->ops->prep_chip_selects		= k8_prep_chip_selects;
+		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
 		break;
 
 	case 0x10:
@@ -3796,6 +3797,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
 		pvt->ops->get_base_mask			= read_dct_base_mask;
 		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
+		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
 		break;
 
 	case 0x15:
@@ -3823,6 +3825,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->early_channel_count		= f1x_early_channel_count;
 		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
 		pvt->ops->get_base_mask			= read_dct_base_mask;
+		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
 		break;
 
 	case 0x16:
@@ -3840,6 +3843,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->dbam_to_cs			= f16_dbam_to_chip_select;
 		pvt->ops->get_base_mask			= read_dct_base_mask;
 		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
+		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
 		break;
 
 	case 0x17:
@@ -3871,6 +3875,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
 		pvt->ops->get_base_mask			= read_umc_base_mask;
 		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
+		pvt->ops->determine_memory_type		= f17_determine_memory_type;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -3908,6 +3913,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
 		pvt->ops->get_base_mask			= read_umc_base_mask;
 		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
+		pvt->ops->determine_memory_type		= f17_determine_memory_type;
 		break;
 
 	default:
@@ -3917,7 +3923,8 @@ static int per_family_init(struct amd64_pvt *pvt)
 
 	/* ops required for all the families */
 	if (!pvt->ops->early_channel_count || !pvt->ops->dbam_to_cs ||
-	    !pvt->ops->get_base_mask || !pvt->ops->prep_chip_selects) {
+	    !pvt->ops->get_base_mask || !pvt->ops->prep_chip_selects ||
+	    !pvt->ops->determine_memory_type) {
 		edac_dbg(1, "Common helper routines not defined.\n");
 		return -EFAULT;
 	}
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index cca59a1b3021..4d8830b8afa2 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -466,6 +466,7 @@ struct low_ops {
 			   unsigned int cs_mode, int cs_mask_nr);
 	void (*get_base_mask)(struct amd64_pvt *pvt);
 	void (*prep_chip_selects)(struct amd64_pvt *pvt);
+	void (*determine_memory_type)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

