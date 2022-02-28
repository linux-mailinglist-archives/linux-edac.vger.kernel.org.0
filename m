Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E547A4C7184
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbiB1QPh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiB1QPg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:15:36 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A10245069
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPxg2qvOpVHyeGDoikOlwIXKc1POdxOjFNUmLmYh1Bq845hOs7Id87kr6831N3axk8UjbRc7AAbdsXbqpIgTaljCQnniJXaEezXNwnKCMX1YFGl12ZSUN1wBZ85tO6vjSbOHtaak/pVoPR6UQkCkJNJk8V0qHl7lavg8NWfW6cdTlbnn14FG9oIz6V+WAzs7pBLMPkUS89AgbFbbnV4vgPO0dCr+B7YFWYiD5fAeqB00MrnfkHGH6fDxKJ09u8gcv9Pms2XnUTYL0VzB6A8tbKABVtMpZZ/m+i5NnHG38cAMk951Ja4bBJRpAUotGsqFkRsQbIq9Km2Xc6S8U0DsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MbhHKtlC4/ySWqXa1uX66hdcybLYLHnsgmmJaaS/RI=;
 b=il+3L+NTfLthu9ccqtWeDPkIzgq8p+IvidYw9e5bTsvKB64czpznHFRK4rjMz/Sv4L84D124rJKM+iU9I55HeEpJobqxlRzMBo824yrcCj6dHnTmGYOIFqfkMufbVhOdtWZ9BjOyN79DHQ3nXlezLRcqTJLGQMoq0yq8ArNZVPod6tjTWfq2P8x//sbVDdl6wP/UgcBwuj/plsrIDugo6mj5i+ugIqKtdTDiG/4N8p3tUyIFXGiDaD+Hol2bJbtXX84teNsoQ91lBquSjOEWLoYcLZXjFmasgNHZruMGlF0FUfHj6LexlXB4TOavhT5KKhW9pbVdcx26lhl6vRv8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MbhHKtlC4/ySWqXa1uX66hdcybLYLHnsgmmJaaS/RI=;
 b=s9Yt47ZdeXUoLj4uzo3R47XS+4BZATboR7CGE00L2702oesudibLy4Q5k2GrIE9eVeZFbSvImlehIqL/kLZIu5jBJvUE2OZ/vkodqH/5AuV/7g/5sr3nV4/is88R+udsRlTuG6As+gS8xC27DY3IAyrwt80GH4x+jFSlsS/SW/k=
Received: from BN9PR03CA0979.namprd03.prod.outlook.com (2603:10b6:408:109::24)
 by BN8PR12MB2995.namprd12.prod.outlook.com (2603:10b6:408:41::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 28 Feb
 2022 16:14:50 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::94) by BN9PR03CA0979.outlook.office365.com
 (2603:10b6:408:109::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:50 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:46 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 12/14] EDAC/amd64: Add dump_misc_regs() into pvt->ops
Date:   Mon, 28 Feb 2022 21:43:52 +0530
Message-ID: <20220228161354.54923-13-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 75f32d0b-55b7-4430-ef98-08d9fad57271
X-MS-TrafficTypeDiagnostic: BN8PR12MB2995:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB29957FC4BBAA9DF6581AAF39E8019@BN8PR12MB2995.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5m80/bk/4nzcIJXT4Fn2mR5DLlPkt2k77M0SxV9wkU81fPtrOSdj/it++0fihQE5v/N+oWeBcMm2/UIbgyXuRRCZMnqx4BRwDAMk5y3ok/cSYdqPjnYBObnrxNEBPO75/kt4eqfA/1gAPAkZhBZiQpnxsr69oaPNg6pvSVIwgnTRR4CgHA2MAX34+47AkxZX31IiTCGparkrsI20aIek9Io2foBESlX8AfGoflgWIrnjDJWWrTivzWjPmtSplXfFzUzETDZciAUB+yWxM9XL0HhSKFtw47cJ7/YsdSATjCZaqi8nrFyhLFyySzKgIB2nMk3sHCZFBMBHsDPJZ/EquKRVl1ZIUO0pAmXyN/iiLh4KMP/670KhhMzvIAaFRBUSjoR72YtJuaNiMcxNmfdvTtWT2305n2T+xXMpe2RwaJ/1K7tIv8wl+CrK9Z+bq62YbjUR/BJvYhzXT05vC9nCnaIzzbw6uq8NFcu/TpO9jTFt5amXEonzoGuG9DJbuWpuhtLZUHG55uRViY2I13NbuF+OzWed65EkKXu5M0V5O9UzjQooqAveSNgLWsrZHiGenaWNEgvF4N6n1eRK7aeCwvWr0kwnWmcNZlIE2aTMb6TJ2FHNX4pp9avWCVDXewaRCto9nHjkkoF2zCt9yKsbrRzFHh8dEX8CcuqfjrR/1/gXyP/Qc6hXrDKRp6fUUTyQmFz1N1CYWb73IR/WiqXj2I1DUbr5SxC7G63H+K20bVm+Y9gjVNEknnfki0UXXLdtbnUdzslcKFfiTdpfpPzTQsbsRatArqLcqzU4PzBMmrk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(6666004)(36756003)(508600001)(8676002)(7696005)(82310400004)(26005)(186003)(54906003)(6916009)(2616005)(966005)(316002)(83380400001)(1076003)(356005)(81166007)(2906002)(5660300002)(36860700001)(47076005)(8936002)(16526019)(70586007)(70206006)(4326008)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:50.4058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f32d0b-55b7-4430-ef98-08d9fad57271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2995
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

Add function pointer for dump_misc_regs() in pvt->ops and assign
family specific dump_misc_regs() definitions appropriately.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
This patch is created by splitting the 5/12th patch in series
[v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/

 drivers/edac/amd64_edac.c | 25 ++++++++++++++-----------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index a799594c9574..1063dda20ce9 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1442,6 +1442,10 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 
 	edac_dbg(1, "F0x104 (DRAM Hole Address): 0x%08x, base: 0x%08x\n",
 		 pvt->dhar, dhar_base(pvt));
+
+	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
+
+	amd64_info("using x%u syndromes.\n", pvt->ecc_sym_sz);
 }
 
 /* Display and decode various NB registers for debug purposes. */
@@ -1476,15 +1480,6 @@ static void __dump_misc_regs(struct amd64_pvt *pvt)
 	/* Only if NOT ganged does dclr1 have valid info */
 	if (!dct_ganging_enabled(pvt))
 		debug_dump_dramcfg_low(pvt, pvt->dclr1, 1);
-}
-
-/* Display and decode various NB registers for debug purposes. */
-static void dump_misc_regs(struct amd64_pvt *pvt)
-{
-	if (pvt->umc)
-		__dump_misc_regs_df(pvt);
-	else
-		__dump_misc_regs(pvt);
 
 	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
 
@@ -3803,6 +3798,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		pvt->ops->populate_csrows		= init_csrows;
+		pvt->ops->dump_misc_regs		= __dump_misc_regs;
 		break;
 
 	case 0x10:
@@ -3822,6 +3818,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		pvt->ops->populate_csrows		= init_csrows;
+		pvt->ops->dump_misc_regs		= __dump_misc_regs;
 		break;
 
 	case 0x15:
@@ -3857,6 +3854,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		pvt->ops->populate_csrows		= init_csrows;
+		pvt->ops->dump_misc_regs		= __dump_misc_regs;
 		break;
 
 	case 0x16:
@@ -3882,6 +3880,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		pvt->ops->populate_csrows		= init_csrows;
+		pvt->ops->dump_misc_regs		= __dump_misc_regs;
 		break;
 
 	case 0x17:
@@ -3921,6 +3920,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_edac_ctl_cap	= f17_determine_edac_ctl_cap;
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		pvt->ops->populate_csrows		= init_csrows_df;
+		pvt->ops->dump_misc_regs		= __dump_misc_regs_df;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -3966,6 +3966,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_edac_ctl_cap	= f17_determine_edac_ctl_cap;
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		pvt->ops->populate_csrows		= init_csrows_df;
+		pvt->ops->dump_misc_regs		= __dump_misc_regs_df;
 		break;
 
 	default:
@@ -3979,7 +3980,8 @@ static int per_family_init(struct amd64_pvt *pvt)
 	    !pvt->ops->determine_memory_type || !pvt->ops->determine_ecc_sym_sz ||
 	    !pvt->ops->get_mc_regs || !pvt->ops->ecc_enabled ||
 	    !pvt->ops->determine_edac_cap || !pvt->ops->determine_edac_ctl_cap ||
-	    !pvt->ops->setup_mci_misc_attrs || !pvt->ops->populate_csrows) {
+	    !pvt->ops->setup_mci_misc_attrs || !pvt->ops->populate_csrows ||
+	    !pvt->ops->dump_misc_regs) {
 		edac_dbg(1, "Common helper routines not defined.\n");
 		return -EFAULT;
 	}
@@ -4169,7 +4171,8 @@ static int probe_one_instance(unsigned int nid)
 
 	amd64_info("%s detected (node %d).\n", pvt->ctl_name, pvt->mc_node_id);
 
-	dump_misc_regs(pvt);
+	/* Display and decode various NB registers for debug purposes. */
+	pvt->ops->dump_misc_regs(pvt);
 
 	return ret;
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index c762b341650f..7b377dba0dc7 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -474,6 +474,7 @@ struct low_ops {
 	void (*determine_edac_ctl_cap)(struct mem_ctl_info *mci, struct amd64_pvt *pvt);
 	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
 	int  (*populate_csrows)(struct mem_ctl_info *mci);
+	void (*dump_misc_regs)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

