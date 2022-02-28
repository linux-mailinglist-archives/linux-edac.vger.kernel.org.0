Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB434C7181
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiB1QPY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237842AbiB1QPW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:15:22 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EC24552E
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmPMnaoPh1GtkuNU4P+iVQTERYRY5sF/bEpMOnY2BR/XNvBVCeNGXq2Ck/FUMJz3il3lG1nAJMA1XBLKhLFrQKa0GfKAVGE22Dq5FjDdszPrLERJwoPyHG5ExircAqMyjJbFPLhNBjtLVns88EqYi8eDpvVcNoV9TpMfcrhxBNtbL+up0nsIPi1RL0Hb56Y5A6JRyQiuINl8wDqyXVoqqIb2JKKBKKGDtkzEy1fnPvWRz2PzEYzTw49Ye1Wxvdw3r1UwWI1mtK3cpnm9CbfTCR9Qe3+SUG5G2YdrNoBteN7Z4CXWYe/s3c1A//zQApVx+eCMw6BP0FaWeinMBPepKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM1ZKUzt7Jg9MdO2fJFgcNGm0Uj0VnCDOQ6o87XbNHs=;
 b=mIbkxZczaQw9plAMtooubphpOIkB1MZtcaJGbiWpSR6W2VySDUhws6yQhaPkdNVH4gUUeqwSn8rO1TMffOHeQfSwCAiC6QRGu0t0put2emYIyLKeD3irA7ITykjIhCw6dJen7v6nLbu6KLcYL2wm1lJgbZAjcAea8UvxvSTLDFaTNCN8E7ShMZgzGVzSYtxyuq60DqjPOOAUg4IOrIhaG/b009Usd5tBVnRtxKveGmD0jVYm7B/tPslBtPvtZ6UR0vR3FWEyxy0E3Bd5jw7i4ij3swmHU0OMTt5eoiOO+jdoM6br7ED6suO+RRo+vEUEaI9nDZjYYsFQfYVc3VZvWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM1ZKUzt7Jg9MdO2fJFgcNGm0Uj0VnCDOQ6o87XbNHs=;
 b=WhSdJ7xExL1L5+b/TitxxuDQvyBiwGY8+i9OyUO/5yzY5G758IeeJ/7wUcVpJlm26xHTdhhB2qYAe1sjNzPgjze+yh3QDDzgOHqxolI3QUXcbV9JHdh8mGK3zxNSKJg7D1pdn1luhA9oApxuRbPft4DXazjErt8OT4J/D42shv4=
Received: from BN8PR15CA0011.namprd15.prod.outlook.com (2603:10b6:408:c0::24)
 by BN6PR12MB1747.namprd12.prod.outlook.com (2603:10b6:404:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 28 Feb
 2022 16:14:41 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::c4) by BN8PR15CA0011.outlook.office365.com
 (2603:10b6:408:c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:41 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:38 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 09/14] EDAC/amd64: Add determine_edac_ctl_cap() into pvt->ops
Date:   Mon, 28 Feb 2022 21:43:49 +0530
Message-ID: <20220228161354.54923-10-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a5d77f04-27c5-437a-a895-08d9fad56d2b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1747:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB17474AACEB5A44D2E91A379EE8019@BN6PR12MB1747.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxTtSYGQx2bdJnzoJhPj2BbElVEPTd3Wpxf+lQgfWicNjCXf5CwO3c/1hO0wkjNJpXyAfQcOUtJcBtRMT2gyjr3/BpChXbR/yQFfaBXV4UByXEdHdeyCczLCIqtzPI5crYjN4Fj52jF45KGVUyvzt0z41lwE5XR9ivEop6NAixm/PrKd7/snTiX5D7JSBr4kcT+NEPjd51NkUQFtBbXMDW1B3g4GO0nhFBTu3qILlSd1S9qYbaMFluO799JG0RvFYDUQE1DVIhlD6jXlrRpptaT0NiBVZn7yOWUPra8usUIP8I57HvIjLj/v5oGtXWI1887gNkwpN+ICsJlXGA+LoFCuAfXDWaVHpX5g00U4glHOaBwWnPibeeeWwDtVM0HFgzvFh+Nk7h6ncHBoor1a5J6TTjL572Wstywrn3KOoIJt5NDCBS/WIc6cRRVfOHe8QL2GFJEkw3EwpYMdIO/lt8ab6k3Fwo55TpFQHAj9Df/FMCh50waR3gH/qxcnk5gy1ql59SxJk0bLx130GP/242ZCpNmmjkWqqE4BBzkd8EdA+JWt6doX38Tis0Nkltake9OyUNp1QvmU9ghufpZoxWDfjH1VE4U2YDk6VdfAnKAwxQi4HWmAN9UsWBoCILHd+W2P+r81pe5BkErK9PD3oVCRQf2nR5FKe+dY2R7jDMd5/xYwzF6GSUeE+K6c2kRWOsKjMRIGIoo9yUm6SGrmDaMa9JX6qDwxbTwmElj1Y7KdLLXbb4SCEdDUQS11qCZ6PWtAGxenBKRjkEwowTtJcWRRScxpSwjIJumqKDTG+4g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(2906002)(966005)(26005)(186003)(316002)(508600001)(16526019)(5660300002)(6916009)(54906003)(4326008)(8676002)(83380400001)(82310400004)(8936002)(7696005)(36860700001)(1076003)(70206006)(356005)(81166007)(70586007)(426003)(40460700003)(36756003)(47076005)(6666004)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:41.5566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d77f04-27c5-437a-a895-08d9fad56d2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1747
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

Add function pointer for determine_edac_ctl_cap() in pvt->ops and assign
family specific determine_edac_ctl_cap() definitions appropriately.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
This patch is created by splitting the 5/12th patch in series
[v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/

 drivers/edac/amd64_edac.c | 30 +++++++++++++++++++-----------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index af6711cf03e9..e3b0a0329f43 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3716,7 +3716,17 @@ static bool f17_ecc_enabled(struct amd64_pvt *pvt)
 }
 
 static inline void
-f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
+f1x_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
+{
+	if (pvt->nbcap & NBCAP_SECDED)
+		mci->edac_ctl_cap |= EDAC_FLAG_SECDED;
+
+	if (pvt->nbcap & NBCAP_CHIPKILL)
+		mci->edac_ctl_cap |= EDAC_FLAG_S4ECD4ED;
+}
+
+static inline void
+f17_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
 {
 	u8 i, ecc_en = 1, cpk_en = 1, dev_x4 = 1, dev_x16 = 1;
 
@@ -3753,15 +3763,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 	mci->mtype_cap		= MEM_FLAG_DDR2 | MEM_FLAG_RDDR2;
 	mci->edac_ctl_cap	= EDAC_FLAG_NONE;
 
-	if (pvt->umc) {
-		f17h_determine_edac_ctl_cap(mci, pvt);
-	} else {
-		if (pvt->nbcap & NBCAP_SECDED)
-			mci->edac_ctl_cap |= EDAC_FLAG_SECDED;
-
-		if (pvt->nbcap & NBCAP_CHIPKILL)
-			mci->edac_ctl_cap |= EDAC_FLAG_S4ECD4ED;
-	}
+	pvt->ops->determine_edac_ctl_cap(mci, pvt);
 
 	mci->edac_cap		= pvt->ops->determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
@@ -3801,6 +3803,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_mc_regs			= read_mc_regs;
 		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
 		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
+		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
 		break;
 
 	case 0x10:
@@ -3817,6 +3820,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_mc_regs			= read_mc_regs;
 		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
 		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
+		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
 		break;
 
 	case 0x15:
@@ -3849,6 +3853,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_mc_regs			= read_mc_regs;
 		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
 		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
+		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
 		break;
 
 	case 0x16:
@@ -3871,6 +3876,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_mc_regs			= read_mc_regs;
 		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
 		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
+		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
 		break;
 
 	case 0x17:
@@ -3907,6 +3913,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_mc_regs			= __read_mc_regs_df;
 		pvt->ops->ecc_enabled			= f17_ecc_enabled;
 		pvt->ops->determine_edac_cap		= f17_determine_edac_cap;
+		pvt->ops->determine_edac_ctl_cap	= f17_determine_edac_ctl_cap;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -3949,6 +3956,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_mc_regs			= __read_mc_regs_df;
 		pvt->ops->ecc_enabled			= f17_ecc_enabled;
 		pvt->ops->determine_edac_cap		= f17_determine_edac_cap;
+		pvt->ops->determine_edac_ctl_cap	= f17_determine_edac_ctl_cap;
 		break;
 
 	default:
@@ -3961,7 +3969,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 	    !pvt->ops->get_base_mask || !pvt->ops->prep_chip_selects ||
 	    !pvt->ops->determine_memory_type || !pvt->ops->determine_ecc_sym_sz ||
 	    !pvt->ops->get_mc_regs || !pvt->ops->ecc_enabled ||
-	    !pvt->ops->determine_edac_cap) {
+	    !pvt->ops->determine_edac_cap || !pvt->ops->determine_edac_ctl_cap) {
 		edac_dbg(1, "Common helper routines not defined.\n");
 		return -EFAULT;
 	}
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 9a789cb01f4d..0e0715a16981 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -471,6 +471,7 @@ struct low_ops {
 	void (*get_mc_regs)(struct amd64_pvt *pvt);
 	bool (*ecc_enabled)(struct amd64_pvt *pvt);
 	unsigned long (*determine_edac_cap)(struct amd64_pvt *pvt);
+	void (*determine_edac_ctl_cap)(struct mem_ctl_info *mci, struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

