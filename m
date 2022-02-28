Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134A64C717C
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbiB1QPN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiB1QPM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:15:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3A845069
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JW+HtR2jpUpUz5cDdeVECClLqkAO6USSAnUAuaw9o/tr24AV7KMx3ZyBhdy8TU3JI+0tthAI/6ajOQ0SuiJQuFeYxuNxvP4nfbNnTf7uwQ36Jye5LwuLVl8kWVULWKtqSl1HWHUFS2iiWwSojKZ3YdOMRqMLxZHgIg4VmZXwdhy2jZ9mEf3uXC0xCg6M1uv8aiLNabn5UOeJYZbWS6twwbELQl1VaSS8VyukJROaPh+4Cr4OWciPhDQQjavcG3xSyB0su+QWd/QhWcLr4/nykOEXQtJ5pgQt8jGn2IDBE6Q0LIcBWP/LENzvNKMpxOo/DPdTOhGg37AApewBXILjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZDPnzclktyJm3RC9KXrvAcsUImEf5IehWvyQoGi35M=;
 b=Jn2eRkvusflZBUV6KVb/BOCe2eT6hysVsa3VojGBvx6RGqVkrHH4Q1bxnF4CAzHLhl0spHAA122rj8mdkb77ZECPY9to1FBSyukWdMa5tuBIfzQErZtF54AGp7TJjI/ARZ7ww0CY7yasZENNCL5OrrqpKhKiaoQJZJNDIyoHjPbnb8uxCDKfd61k4L/Gr12whiJ8m+6FnbY4S5P2/v9eaFHSzGa0LPBuMd1LBVO/uT3+GnNW6wfqKo/koGsQfplL2KejY8d7WC/JK8nNbZ1XPyhg2nGYs4SYq6BP8AMNqx7TVxSLy0/xeK9ZGGrhgxWJjicBWb5K9/rC1RE02O/l0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZDPnzclktyJm3RC9KXrvAcsUImEf5IehWvyQoGi35M=;
 b=C2CfTXy7TzMAavV2m29OA9fh85iGM4tLwT6VHwi40r1BxBB5XLxH570T7lDstWqGUaGVM85PJPSyvtyVQ/Pw0SZYFtI4FJPzciSOjB4J3YxInGTV5nQKd7zWcnCjLpXGqWdgQCK5nqVFaUKTkcPBb3ICBaUfHNkZ5nBEovVMJ3U=
Received: from BN9PR03CA0079.namprd03.prod.outlook.com (2603:10b6:408:fc::24)
 by BN8PR12MB3555.namprd12.prod.outlook.com (2603:10b6:408:48::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 16:14:32 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::2a) by BN9PR03CA0079.outlook.office365.com
 (2603:10b6:408:fc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:31 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:28 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 05/14] EDAC/amd64: Add get_ecc_sym_sz() into pvt->ops
Date:   Mon, 28 Feb 2022 21:43:45 +0530
Message-ID: <20220228161354.54923-6-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d54dd3d-7142-4aca-8535-08d9fad56756
X-MS-TrafficTypeDiagnostic: BN8PR12MB3555:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3555C5FA1C71C19BBB5367F0E8019@BN8PR12MB3555.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWEc5HgL8Bvz2dsPcwgJCxNJAZRIygcOcIGJp5UKRh/wum+qFMOgcYe3a1DlFRlj9dS10Q/p854YmwphakzHq9Isqa+Zv1M+wueyKQO7mmY+nbXie4a2ydOemZeEmj9TwraosoFLRmz5E36cAH7cuG/0wSLnavkeCPSXTLU/sxbqhSRWlN0IjP4DYVCLSePD7zW4c18d4gaMuYxDNjWrBfZpwm66GIJRwMWyhQ3RGkH7fIiMl6OhtDOWBJ4crRnSmorPtPxx074MEV72uYYKzsQBd0VAKo0+e0diviplszqpULD0b5ZAPZDsFK5Pq0796ENuRyCgjiYe83mqV6p0y8a/WbdYetQ2hAKZeqRGichZBFSpkPdpnD0t7XR30PEvdyEs6PGyaq6G54vZwJkGW7LCFkdhhTTPNwIRo1sXGFWzSD0iLIELYDR9HMhGAmeSZl8olmdmvcFHvnOdWPR8/+E983QeUF4iYC0rQu7BfNfRNgK906cruXMWR2ekVjtxX6EEqKXkbsLbzZqsWEOWScUnmCn/FqdwjpjuM+xjs27WHyDd8xs1KE7e3jUul1pg+qlGyv3yZzNP41L3/yoceDgDs3LZkCqRnTVNSquq4UMNIcGnuNJkC85FUr60IKvfJiABUvXQllBHqnE1GshnXL4HpmYruUR5LRV9gKRPv0RNJqRf+U5+13494FMdItxKUDK9CeYc2Ql/2c+L+j3Vcs5QvdTM/yV3aula/Jq0NX/DeI+m22Xuy+F1zO06Wk653V8pkOMLxL/hbn9j6Wsgrwd2ueWduQOgTMvX36iVr/M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(316002)(356005)(2906002)(36860700001)(36756003)(8936002)(40460700003)(5660300002)(47076005)(508600001)(83380400001)(2616005)(426003)(336012)(966005)(8676002)(186003)(4326008)(26005)(70586007)(16526019)(6666004)(7696005)(70206006)(82310400004)(6916009)(54906003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:31.7556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d54dd3d-7142-4aca-8535-08d9fad56756
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3555
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

Add function pointer for determine_ecc_sym_sz() in pvt->ops and assign
family specific get_ecc_sym_sz() definitions appropriately.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
This patch is created by splitting the 5/12th patch in series
[v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/

 drivers/edac/amd64_edac.c | 49 ++++++++++++++++++++++++---------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 07428a6c7683..69c33eb17e4f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3176,26 +3176,11 @@ static void free_mc_sibling_devs(struct amd64_pvt *pvt)
 	}
 }
 
-static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
+static void f1x_determine_ecc_sym_sz(struct amd64_pvt *pvt)
 {
 	pvt->ecc_sym_sz = 4;
 
-	if (pvt->umc) {
-		u8 i;
-
-		for_each_umc(i) {
-			/* Check enabled channels only: */
-			if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
-				if (pvt->umc[i].ecc_ctrl & BIT(9)) {
-					pvt->ecc_sym_sz = 16;
-					return;
-				} else if (pvt->umc[i].ecc_ctrl & BIT(7)) {
-					pvt->ecc_sym_sz = 8;
-					return;
-				}
-			}
-		}
-	} else if (pvt->fam >= 0x10) {
+	if (pvt->fam >= 0x10) {
 		u32 tmp;
 
 		amd64_read_pci_cfg(pvt->F3, EXT_NB_MCA_CFG, &tmp);
@@ -3209,6 +3194,26 @@ static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
 	}
 }
 
+static void f17_determine_ecc_sym_sz(struct amd64_pvt *pvt)
+{
+	u8 i;
+
+	pvt->ecc_sym_sz = 4;
+
+	for_each_umc(i) {
+		/* Check enabled channels only: */
+		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
+			if (pvt->umc[i].ecc_ctrl & BIT(9)) {
+				pvt->ecc_sym_sz = 16;
+				return;
+			} else if (pvt->umc[i].ecc_ctrl & BIT(7)) {
+				pvt->ecc_sym_sz = 8;
+				return;
+			}
+		}
+	}
+}
+
 /*
  * Retrieve the hardware registers of the memory controller.
  */
@@ -3312,7 +3317,7 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	pvt->ops->determine_memory_type(pvt);
 	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
 
-	determine_ecc_sym_sz(pvt);
+	pvt->ops->determine_ecc_sym_sz(pvt);
 }
 
 /*
@@ -3786,6 +3791,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_base_mask			= read_dct_base_mask;
 		pvt->ops->prep_chip_selects		= k8_prep_chip_selects;
 		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
+		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
 		break;
 
 	case 0x10:
@@ -3798,6 +3804,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_base_mask			= read_dct_base_mask;
 		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
 		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
+		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
 		break;
 
 	case 0x15:
@@ -3826,6 +3833,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
 		pvt->ops->get_base_mask			= read_dct_base_mask;
 		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
+		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
 		break;
 
 	case 0x16:
@@ -3844,6 +3852,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_base_mask			= read_dct_base_mask;
 		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
 		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
+		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
 		break;
 
 	case 0x17:
@@ -3876,6 +3885,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_base_mask			= read_umc_base_mask;
 		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
 		pvt->ops->determine_memory_type		= f17_determine_memory_type;
+		pvt->ops->determine_ecc_sym_sz		= f17_determine_ecc_sym_sz;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -3914,6 +3924,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_base_mask			= read_umc_base_mask;
 		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
 		pvt->ops->determine_memory_type		= f17_determine_memory_type;
+		pvt->ops->determine_ecc_sym_sz		= f17_determine_ecc_sym_sz;
 		break;
 
 	default:
@@ -3924,7 +3935,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 	/* ops required for all the families */
 	if (!pvt->ops->early_channel_count || !pvt->ops->dbam_to_cs ||
 	    !pvt->ops->get_base_mask || !pvt->ops->prep_chip_selects ||
-	    !pvt->ops->determine_memory_type) {
+	    !pvt->ops->determine_memory_type || !pvt->ops->determine_ecc_sym_sz) {
 		edac_dbg(1, "Common helper routines not defined.\n");
 		return -EFAULT;
 	}
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 4d8830b8afa2..f6769148d8b7 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -467,6 +467,7 @@ struct low_ops {
 	void (*get_base_mask)(struct amd64_pvt *pvt);
 	void (*prep_chip_selects)(struct amd64_pvt *pvt);
 	void (*determine_memory_type)(struct amd64_pvt *pvt);
+	void (*determine_ecc_sym_sz)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

