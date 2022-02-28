Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB8A4C717B
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbiB1QPM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiB1QPL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:15:11 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41B245069
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQufOrGPTlBkLHxwqNEuFlwieHNEony6okxyjaBvfA3hLB89r1Zjt0Y/ExeOyeWJTCqTW5m1/031Iz0C9UF+SG94xoDKCSLRjeTrlO4O25W9Ca5lFrLCsRz6rqDjFiBj9f7/O1Hc6P4JE8JcEbq8GHpjWp+MfacZoo4+UtssaMusw1cn9cruMAHy5P5kz1HSSryCr/+IJSYDMUYUN6eW25AZifbrYJyh9oHZ2t+RNPDIMXqnaTXdTf84VxMw9C12pxFJM9aWtbsjyvjsdPDQFTLPgF518Np0765tVu/2o4kcRGgDEQSn8kRGF9y4PPyOysNX/zJt031mcEQI4WBXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELwwyrTK/loTXxwLWj3vh9eOpjPhvD0rWoA6MHUk0EY=;
 b=Z8kPE9JmLEdnJK353+W6HAPDQbv7GLxbTWYmS0nBInbE0Disa8Gp6ofo+xuEYtJkW8MbkB0Ttwj8J7SvKVwFkenS1JfzMUwXPrF3gwUDF17PqIoC0rNTE0KUGxpnFhTDTvQbxZwJ2PTrSdU6J7oLwBxzL7rUr8Cbw+Ow5io7896x7I42P34ZINvBEkc83bn7lJAvJSpcyTIUXebX/g5iUCiMi+Mi1mERLQXhpVGyf2tL/vOcjcKEfVSeE43B9o22yOkBJa2oo4f4MGDB8+oG6qRxT0y9C8PdXYa5TNbmIyQ24n6wTaGuH8wtsm+CMCNDYQsn3J14/C3lDaXNFb6dgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELwwyrTK/loTXxwLWj3vh9eOpjPhvD0rWoA6MHUk0EY=;
 b=T3IvnrX7a+QBFjfyfOThdnISI+DQqQjnT+dN+WHwfUGLwgYsoL7rMQ386Xb74HVfh1NbRAkC10ZtPHSP0sYqd4pPt5DZMn/9fbKWQiOtnkH/4zSXMVwO1jhR097wqJAVjQfbt+Do7bx7ddNTHfFjJFife/MuwtHw0+QEI5tolyw=
Received: from BN0PR04CA0198.namprd04.prod.outlook.com (2603:10b6:408:e9::23)
 by BYAPR12MB2998.namprd12.prod.outlook.com (2603:10b6:a03:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 16:14:26 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::81) by BN0PR04CA0198.outlook.office365.com
 (2603:10b6:408:e9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:26 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:23 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 03/14] EDAC/amd64: Add prep_chip_selects() into pvt->ops
Date:   Mon, 28 Feb 2022 21:43:43 +0530
Message-ID: <20220228161354.54923-4-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a135b692-48d2-45a5-07a7-08d9fad5640b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2998:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2998440D44CE69855981B964E8019@BYAPR12MB2998.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hB+8seHmwbOO+FBy0c4ksw7QZfAPdg8vr6hx41zwMAsoI2JZHSIERNBxXszZXypi5g0tbBtV1S9+Dp0g7fYPqmbmcvh1oFPH5+cPwE8EraI41MFvJ45EqYYDBz4+IBdGIh4X3hfU+65uzuKL4HebcukADG3dIWiWSt++vIrkGAiptsbTQOnjFmpAIKtR1AefGWRf9keaZKSAYk1fqC8md50Xt1TXmvXnLiDayTmZyRN8c6flZ7fNt/8JlwXm5y4TbTP/VZzBdl4fjKKgkxBsVDSigAb1nVPw6b52Ne+QGUC8pPO8BI6FquhU8QWlzImpleqWIBfqXNYq7mHg9d/7sWNB/+cQSK7zf+CVFUHlm4fggOC8hz5YxvzyQD8XZ4ihKYpCsgOqwuAnfmDLc5wGc3Cu3KdjEL5/gCulHKMcA0OmxMgD/DBmmTvSVqWKWzW98jWkxNHQz2lOUuRxiD+FWvCdZgoZTHRBff3LtPAjgm8/LDmNY1WPh/XGvGw6cnjd7cAXQdnwfJmzC8hEfz9gdsOqWICbppiFqgr/lzU0WnFCWZww6FJD5KNLImpE+Z0InJmHDIelITnW3a0GZ1Mu5T3CNCulxBtmynlxkjGoEL/eXEv4kisjcwfM4I4oFahhXuC1EJ5tYx942NY0tGocUsu3t1aIGMgnPLjfqbjNMH5Lsamod4qkBJLNYfsOQdtTJGJ/vwRILtBTOIwmjmx9OIDUHrx9xFEYWhscOEBgT8WabDP/OHeBPcdeZd4AcrLO9xWPG2yfE5SG3ZtOXJK1XNK+jFHzylgj+XfQeL1v9t4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(47076005)(40460700003)(316002)(2616005)(1076003)(7696005)(16526019)(6916009)(26005)(426003)(336012)(186003)(6666004)(54906003)(83380400001)(36860700001)(4326008)(70206006)(70586007)(81166007)(8676002)(82310400004)(2906002)(356005)(508600001)(966005)(5660300002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:26.2277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a135b692-48d2-45a5-07a7-08d9fad5640b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2998
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

Add function pointer for prep_chip_selects() in pvt->ops and assign
family specific prep_chip_selects() definitions appropriately.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
This patch is created by splitting the 5/12th patch in series
[v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/

 drivers/edac/amd64_edac.c | 68 ++++++++++++++++++++++++++++-----------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 985c59d23a20..708c4bbc0d1c 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1490,28 +1490,51 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
 /*
  * See BKDG, F2x[1,0][5C:40], F2[1,0][6C:60]
  */
-static void prep_chip_selects(struct amd64_pvt *pvt)
+static void k8_prep_chip_selects(struct amd64_pvt *pvt)
 {
-	if (pvt->fam == 0xf && pvt->ext_model < K8_REV_F) {
-		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
-		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 8;
-	} else if (pvt->fam == 0x15 && pvt->model == 0x30) {
-		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
-		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
-	} else if (pvt->fam >= 0x17) {
-		int umc;
-
-		for_each_umc(umc) {
-			pvt->csels[umc].b_cnt = 4;
-			pvt->csels[umc].m_cnt = 2;
-		}
+	if (pvt->ext_model < K8_REV_F) {
+		pvt->csels[0].b_cnt = 8;
+		pvt->csels[1].b_cnt = 8;
+
+		pvt->csels[0].m_cnt = 8;
+		pvt->csels[1].m_cnt = 8;
+	} else if (pvt->ext_model >= K8_REV_F) {
+		pvt->csels[0].b_cnt = 8;
+		pvt->csels[1].b_cnt = 8;
+
+		pvt->csels[0].m_cnt = 4;
+		pvt->csels[1].m_cnt = 4;
+	}
+}
 
-	} else {
-		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
-		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
+static void f15_m30h_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	pvt->csels[0].b_cnt = 4;
+	pvt->csels[1].b_cnt = 4;
+
+	pvt->csels[0].m_cnt = 2;
+	pvt->csels[1].m_cnt = 2;
+}
+
+static void f17_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	int umc;
+
+	for_each_umc(umc) {
+		pvt->csels[umc].b_cnt = 4;
+		pvt->csels[umc].m_cnt = 2;
 	}
 }
 
+static void default_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	pvt->csels[0].b_cnt = 8;
+	pvt->csels[1].b_cnt = 8;
+
+	pvt->csels[0].m_cnt = 4;
+	pvt->csels[1].m_cnt = 4;
+}
+
 static void read_umc_base_mask(struct amd64_pvt *pvt)
 {
 	u32 umc_base_reg, umc_base_reg_sec;
@@ -3282,7 +3305,7 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	}
 
 skip:
-	prep_chip_selects(pvt);
+	pvt->ops->prep_chip_selects(pvt);
 
 	pvt->ops->get_base_mask(pvt);
 
@@ -3761,6 +3784,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->map_sysaddr_to_csrow		= k8_map_sysaddr_to_csrow;
 		pvt->ops->dbam_to_cs			= k8_dbam_to_chip_select;
 		pvt->ops->get_base_mask			= read_dct_base_mask;
+		pvt->ops->prep_chip_selects		= k8_prep_chip_selects;
 		break;
 
 	case 0x10:
@@ -3771,6 +3795,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
 		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
 		pvt->ops->get_base_mask			= read_dct_base_mask;
+		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
 		break;
 
 	case 0x15:
@@ -3779,11 +3804,13 @@ static int per_family_init(struct amd64_pvt *pvt)
 			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F1;
 			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F2;
 			pvt->ops->dbam_to_cs		= f16_dbam_to_chip_select;
+			pvt->ops->prep_chip_selects	= f15_m30h_prep_chip_selects;
 		} else if (pvt->model == 0x60) {
 			pvt->ctl_name			= "F15h_M60h";
 			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F1;
 			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F2;
 			pvt->ops->dbam_to_cs		= f15_m60h_dbam_to_chip_select;
+			pvt->ops->prep_chip_selects	= default_prep_chip_selects;
 		} else if (pvt->model == 0x13) {
 		/* Richland is only client */
 			return -ENODEV;
@@ -3812,6 +3839,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
 		pvt->ops->dbam_to_cs			= f16_dbam_to_chip_select;
 		pvt->ops->get_base_mask			= read_dct_base_mask;
+		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
 		break;
 
 	case 0x17:
@@ -3842,6 +3870,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->early_channel_count		= f17_early_channel_count;
 		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
 		pvt->ops->get_base_mask			= read_umc_base_mask;
+		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -3878,6 +3907,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->early_channel_count		= f17_early_channel_count;
 		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
 		pvt->ops->get_base_mask			= read_umc_base_mask;
+		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
 		break;
 
 	default:
@@ -3887,7 +3917,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 
 	/* ops required for all the families */
 	if (!pvt->ops->early_channel_count || !pvt->ops->dbam_to_cs ||
-	    !pvt->ops->get_base_mask) {
+	    !pvt->ops->get_base_mask || !pvt->ops->prep_chip_selects) {
 		edac_dbg(1, "Common helper routines not defined.\n");
 		return -EFAULT;
 	}
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index cf38367e3aa1..cca59a1b3021 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -465,6 +465,7 @@ struct low_ops {
 	int  (*dbam_to_cs)(struct amd64_pvt *pvt, u8 dct,
 			   unsigned int cs_mode, int cs_mask_nr);
 	void (*get_base_mask)(struct amd64_pvt *pvt);
+	void (*prep_chip_selects)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

