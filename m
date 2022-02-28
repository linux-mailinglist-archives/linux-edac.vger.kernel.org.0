Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE7E4C717D
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiB1QPR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiB1QPQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:15:16 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CE745069
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkBASiHKLYKRfvaopawgbjj+epW/o6NQQGT6ZnCXAOb2PA+Q3vrnSbEDbCUEF28RfmHagv1jNzg1iz3snYonSw/L1U2ZXeZlB3utZFD/3vEnKpHq2iSZE7vTdSWJkZzZWNzHJr9xUD8ZmIOm5hdk5dbuKU4ae8P19XI3M+8m7W7e8iBBxDWNLE5CGcy1ZwK7+jSm4G7Cebw+2wG3Qj7wqn5dNFn4dJJHuKSGV9wn8EUQHOfGrjluxJB5f2ilFIl9+RGZz7dLbPAjEj6rt+6txLNxgVbqFtH0u1xDUFRHa4EaVbGGEa+R3odLJiU9VUel5/HDGuGazxEjfdvDzJKoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGgYa7eerHheslWrLrv+0i/x5ypPSj6vlM630kAJwko=;
 b=FDo1RyEMluTkn6KJJJp6KCRKNXGgnXSxp2SbPB1HlplD6xggZ2x/RRKJneXAB4PfuaxY+LkUUHaD4l1hcDmpIHKtDj4YNPBBFGUIg6dcy2vS5UbUFZERqqkzx2KnIXd813klm9D8YqDvHoNzpdCs/JISbuf2MEs5CQeNN55stYjY3F1/hODNM0YU2fS/RCEA1OiXwQylDgwpF/sZBbAoS0IL1JTT1Bt+wW6jelyW7LpSS0OxSfJGtU1KlXASpOONeWycj5AA83/r8BiE396WmXE3iXa4WQkexoRyq2ywBHh6fPHsAMJcYICE0LvnjQNJx/oPs+dPz+fSsb/4HGTz8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGgYa7eerHheslWrLrv+0i/x5ypPSj6vlM630kAJwko=;
 b=xavsiMzbpgI0QHG8miLieLWyDFkmL4QIdtNhgLWPsRFusulFXZnuKckF+7LRtcZj5mwqA+mEG2/64Y7vE1pBoH8C7f0uB2xB1dErkBMh8yzuCClg8WmvTuQJ04CAJ+rvCAwFjDc4OuBLOV1AxFLptW73IZPvXRbMSSf5NahJnkg=
Received: from BN9PR03CA0915.namprd03.prod.outlook.com (2603:10b6:408:107::20)
 by MN2PR12MB4797.namprd12.prod.outlook.com (2603:10b6:208:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 16:14:34 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::67) by BN9PR03CA0915.outlook.office365.com
 (2603:10b6:408:107::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:34 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:31 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 06/14] EDAC/amd64: Add get_mc_regs() into pvt->ops
Date:   Mon, 28 Feb 2022 21:43:46 +0530
Message-ID: <20220228161354.54923-7-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d657bce7-7171-4516-3edb-08d9fad568af
X-MS-TrafficTypeDiagnostic: MN2PR12MB4797:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4797F0499A172092632EF5EFE8019@MN2PR12MB4797.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ROZ5VvdbrRBerFIvl48yH9GRJJC3VN5bP+WU45ZlRj2mZ4h1QkwyJ+LSyvEbxIfOOuD8QElkmKujs+Jb2o18Mm/WJw0JshhGRUYTUE442o27TyApWrXG3JDmRSFIgVAl+YaFadLsrbxSdHuD9F8GT/XC4tj1xiXCUnilZo0AnOpe24rUYhKCZwJdoj0wZx6a0WwB+XRngUmzSlcINtf5ldjlvs8AoAi1hhYLnUzRtOW2GLsUD+Yyvm9NCSXaujhyb1Gd5AzxcgjiqTS87lB2k9VguYIQkaQeA100nFezhX1M06m1lwfpgoj0CYl+0+qLDK3smrC9lnniOiZh7x2m2HeT6wlCuAgpZkhOAdBrc6TLNimGjwh1WwcRufzMJYzQzs7EcyaRyt8X4uXThCep5bNwPnVuIPKDbmUp7M307dFNxmyccqW2SpJL7y9zEMTXk8NmGyYAwwurRq/8njoDFTdZcDwy0I2OBY3AjAA4g3OV3CFNc0S9ZfP1Gea5ZMxKqnLOAQa3LLZm5rOjm3wJ1Fn8VedRVws+4g1T3aX5jGc0S/V97oUXIWtsnrEQf7tytyYhtn0QsKh+WfCK7ojS9/cvhlQxkBFlK4uH/UZCWV5UMtja2y9IM1hvzSTWyxQq1Uk+VlASr40c6CEwqL+y7rC+xcod0PtK1kO5E6ikzo3bogRd/NqiT6FGhtPCBKXpZjARuwaR+2SoqyoFVDz1cp/AvFHP4jg24xBobO/CvVjYOZW2MpZNKMtFRK67o7XRsgjkWuGZxzLGx6aqR+27CTTniJfG38243KQWDx6J0MA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(81166007)(316002)(356005)(2906002)(36860700001)(47076005)(8936002)(40460700003)(5660300002)(508600001)(83380400001)(2616005)(426003)(336012)(966005)(4326008)(8676002)(186003)(70586007)(26005)(16526019)(6666004)(7696005)(82310400004)(70206006)(6916009)(54906003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:34.0148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d657bce7-7171-4516-3edb-08d9fad568af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4797
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

Add function pointer for get_mc_regs() in pvt->ops and assign
family specific get_mc_regs() definitions appropriately.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
This patch is created by splitting the 5/12th patch in series
[v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/

 drivers/edac/amd64_edac.c | 77 +++++++++++++++++++++------------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 69c33eb17e4f..713ffe763e64 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3214,6 +3214,27 @@ static void f17_determine_ecc_sym_sz(struct amd64_pvt *pvt)
 	}
 }
 
+static void read_top_mem_registers(struct amd64_pvt *pvt)
+{
+	u64 msr_val;
+
+	/*
+	 * Retrieve TOP_MEM and TOP_MEM2; no masking off of reserved bits since
+	 * those are Read-As-Zero.
+	 */
+	rdmsrl(MSR_K8_TOP_MEM1, pvt->top_mem);
+	edac_dbg(0, "  TOP_MEM:  0x%016llx\n", pvt->top_mem);
+
+	/* Check first whether TOP_MEM2 is enabled: */
+	rdmsrl(MSR_AMD64_SYSCFG, msr_val);
+	if (msr_val & BIT(21)) {
+		rdmsrl(MSR_K8_TOP_MEM2, pvt->top_mem2);
+		edac_dbg(0, "  TOP_MEM2: 0x%016llx\n", pvt->top_mem2);
+	} else {
+		edac_dbg(0, "  TOP_MEM2 disabled\n");
+	}
+}
+
 /*
  * Retrieve the hardware registers of the memory controller.
  */
@@ -3235,6 +3256,8 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
 		amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
 	}
+
+	amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
 }
 
 /*
@@ -3244,30 +3267,8 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 static void read_mc_regs(struct amd64_pvt *pvt)
 {
 	unsigned int range;
-	u64 msr_val;
 
-	/*
-	 * Retrieve TOP_MEM and TOP_MEM2; no masking off of reserved bits since
-	 * those are Read-As-Zero.
-	 */
-	rdmsrl(MSR_K8_TOP_MEM1, pvt->top_mem);
-	edac_dbg(0, "  TOP_MEM:  0x%016llx\n", pvt->top_mem);
-
-	/* Check first whether TOP_MEM2 is enabled: */
-	rdmsrl(MSR_AMD64_SYSCFG, msr_val);
-	if (msr_val & BIT(21)) {
-		rdmsrl(MSR_K8_TOP_MEM2, pvt->top_mem2);
-		edac_dbg(0, "  TOP_MEM2: 0x%016llx\n", pvt->top_mem2);
-	} else {
-		edac_dbg(0, "  TOP_MEM2 disabled\n");
-	}
-
-	if (pvt->umc) {
-		__read_mc_regs_df(pvt);
-		amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
-
-		goto skip;
-	}
+	read_top_mem_registers(pvt);
 
 	amd64_read_pci_cfg(pvt->F3, NBCAP, &pvt->nbcap);
 
@@ -3308,16 +3309,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 		amd64_read_dct_pci_cfg(pvt, 1, DCLR0, &pvt->dclr1);
 		amd64_read_dct_pci_cfg(pvt, 1, DCHR0, &pvt->dchr1);
 	}
-
-skip:
-	pvt->ops->prep_chip_selects(pvt);
-
-	pvt->ops->get_base_mask(pvt);
-
-	pvt->ops->determine_memory_type(pvt);
-	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
-
-	pvt->ops->determine_ecc_sym_sz(pvt);
 }
 
 /*
@@ -3792,6 +3783,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->prep_chip_selects		= k8_prep_chip_selects;
 		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
 		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
+		pvt->ops->get_mc_regs			= read_mc_regs;
 		break;
 
 	case 0x10:
@@ -3805,6 +3797,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
 		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
 		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
+		pvt->ops->get_mc_regs			= read_mc_regs;
 		break;
 
 	case 0x15:
@@ -3834,6 +3827,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_base_mask			= read_dct_base_mask;
 		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
 		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
+		pvt->ops->get_mc_regs			= read_mc_regs;
 		break;
 
 	case 0x16:
@@ -3853,6 +3847,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
 		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
 		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
+		pvt->ops->get_mc_regs			= read_mc_regs;
 		break;
 
 	case 0x17:
@@ -3886,6 +3881,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
 		pvt->ops->determine_memory_type		= f17_determine_memory_type;
 		pvt->ops->determine_ecc_sym_sz		= f17_determine_ecc_sym_sz;
+		pvt->ops->get_mc_regs			= __read_mc_regs_df;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -3925,6 +3921,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
 		pvt->ops->determine_memory_type		= f17_determine_memory_type;
 		pvt->ops->determine_ecc_sym_sz		= f17_determine_ecc_sym_sz;
+		pvt->ops->get_mc_regs			= __read_mc_regs_df;
 		break;
 
 	default:
@@ -3935,7 +3932,8 @@ static int per_family_init(struct amd64_pvt *pvt)
 	/* ops required for all the families */
 	if (!pvt->ops->early_channel_count || !pvt->ops->dbam_to_cs ||
 	    !pvt->ops->get_base_mask || !pvt->ops->prep_chip_selects ||
-	    !pvt->ops->determine_memory_type || !pvt->ops->determine_ecc_sym_sz) {
+	    !pvt->ops->determine_memory_type || !pvt->ops->determine_ecc_sym_sz ||
+	    !pvt->ops->get_mc_regs) {
 		edac_dbg(1, "Common helper routines not defined.\n");
 		return -EFAULT;
 	}
@@ -3972,7 +3970,16 @@ static int hw_info_get(struct amd64_pvt *pvt)
 	if (ret)
 		return ret;
 
-	read_mc_regs(pvt);
+	pvt->ops->get_mc_regs(pvt);
+
+	pvt->ops->prep_chip_selects(pvt);
+
+	pvt->ops->get_base_mask(pvt);
+
+	pvt->ops->determine_memory_type(pvt);
+	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
+
+	pvt->ops->determine_ecc_sym_sz(pvt);
 
 	return 0;
 }
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index f6769148d8b7..1b6df33bb0a8 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -468,6 +468,7 @@ struct low_ops {
 	void (*prep_chip_selects)(struct amd64_pvt *pvt);
 	void (*determine_memory_type)(struct amd64_pvt *pvt);
 	void (*determine_ecc_sym_sz)(struct amd64_pvt *pvt);
+	void (*get_mc_regs)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

