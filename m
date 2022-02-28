Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555B14C7182
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbiB1QP0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiB1QP0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:15:26 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0972645069
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieQfr9ORJUtswVsfnu8uiD7qBp2K2N5kdi3x+tn2l7zW2PIwr979c4YGlF3fLHRbOuw7QGIqz/zXz0b6T3QzjKjTUK/22g9OHPfZuAf+n4VLRJx1BrMzRQjVE+hzq6OJs14e1XxCLFRwX+QIPixYfYr6B4P4v3/ToL5/kK6XpcP2m4Epa/hnEJLvzlJB6aQiXry663a/CdpfDo+/TXH6VeIDf1DTB6sv84M5n0Pug3tIZOO1XmsElOmT191RfNM5hVSDHBCOi6Saqdpn0IxXfwQxKcaHulhQhVZaJwQmR3DJF2t9hrqTXmNLr4wViPbDz0XyFsbkcLpl69l4Ysrm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SECzATeStlzONTr4DtSWrw0W5IKHe8zt3AMBmILFCw=;
 b=htXwYVnvP0UBLTvdMbwfBPk7jbD3fogr403F/3ReJUcIq6dDtSgKCpiroOYYe5kM27j3GkiehnQA5h8D/gECRo8x7ODXiyRNzFG53NyzsHyrkaRgFZD3w2dG2tb7yxh/ADQkWW/MCGSADpMqKa/a+EWTmOJloq0IhCtsTOi6CZ/CUdguqHPYd8eeDztXyz6hRBehq9K5PwMFturqyrwqEMuJoffaXZVG+KRa9ZRSsBgXazWLTP1uXKd2NnCvODgTd4mCRVWc8H/Vs1i1g7ERCpqhZ9npX6vJL+CCDFfWPR6OGB2YE/2w0yjIaoh3scD0waLfqo0Mzgm6h1eiuTcQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SECzATeStlzONTr4DtSWrw0W5IKHe8zt3AMBmILFCw=;
 b=DowcKAHzcbp4XEneDmIeNUM2HohrNmANfgcljhE4G44M3ot/bShQyjoGMZD7B5NelpJnX1JJ08GOh0bKCNBHxH9J9YTcEf4zN0Z3Exz4b5PmrAqzcRDBhqpnsKBJRRAGIJsfj4r7tUgs5b2OBoRgeu8tQ9BmG3JP/R4W+6kyHMo=
Received: from BN6PR1701CA0007.namprd17.prod.outlook.com
 (2603:10b6:405:15::17) by MN2PR12MB4583.namprd12.prod.outlook.com
 (2603:10b6:208:26e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 16:14:44 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::a0) by BN6PR1701CA0007.outlook.office365.com
 (2603:10b6:405:15::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:44 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:41 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 10/14] EDAC/amd64: Add setup_mci_misc_sttrs() into pvt->ops
Date:   Mon, 28 Feb 2022 21:43:50 +0530
Message-ID: <20220228161354.54923-11-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9ea8f937-9b9f-4b8b-d434-08d9fad56ec5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4583:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4583CD8466BEB5085BFCA078E8019@MN2PR12MB4583.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZK1ZWJ1u/kyKuSvr4X27sxjrUKgPmxKk7d9vixaZGJi2+PhoAME9iYTCaRhm0gDd8PKIzVxCGturce7ilnkcXlZayjSNNw41mhAxZq6aDOCHx2xa9xkqxpalACxHCaCm9DbHLh/Oai8gqzhRdzQ8JfB/LMSnLIE7jin4CHCZqcT69bG5O1w3k5VrWZ84ORL1waM0MRVo+5MYszdhYZPZ4w91QQ5ev5EVLwx0QLz9jP0ZnpdG3Tzywbyqwlt4+6ealN+VqbvJUMSZswkCLSLiZ6QLCqqYwwv/OKS5jcKuaG4UFaMubsProPLRyFjT56abUfPkpa0g3aaX+3Eewc4KlzSYrqPy7M1/we0UyyDlgvDCWM+9ZWQfzTGmbxFo1WYWXvLJnc0Z/zRwy+ISYVQPmMIgrdIEEAsUcMeLlMhcgd0Kx+Rv8ypbaQkmgVU5Hj7WvPh3hdU2e3RCzRRZf5SGTccuY4Jll9r+90IVocFLtXwgjvrg5drqvtTczw/vBORveKJC0fs0Z9CH7jlhAZZEFtkZjOLXn6GVK+/XLf1n4sWkYAHuDwKH4ZjorxuF8DMg/TbI+LH0Bz2AT2ib0KTYENnGC/WFOhlCvgzE438r/7kx6Uqwo3hycUo6c0QT/9awNnQRoKzpVk7DC+pZjXLZdm9NtE7e+zwD9bUG7SPxKf0FIwy+fyvtg5iXqru+bIkAT7nKk5NEVb22XBWu6jtGbTAoUPn9+zOdfR9RnrYv9RkO3xGiqSw9+dNQH4MkrGXAZpa+FsyprN93kCl2zmkkHXQWRf5nQ70d1a2gDeyV/Es=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(356005)(966005)(70206006)(6666004)(316002)(7696005)(6916009)(54906003)(36860700001)(36756003)(47076005)(83380400001)(508600001)(40460700003)(2616005)(8936002)(2906002)(26005)(4326008)(186003)(16526019)(82310400004)(1076003)(8676002)(426003)(336012)(5660300002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:44.2447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea8f937-9b9f-4b8b-d434-08d9fad56ec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4583
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

Add function pointer for setup_mci_misc_sttrs() in pvt->ops and assign
family specific setup_mci_misc_sttrs() definitions appropriately

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
This patch is created by splitting the 5/12th patch in series
[v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/

 drivers/edac/amd64_edac.c | 13 ++++++++++---
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index e3b0a0329f43..c86674c3238d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3756,7 +3756,7 @@ f17_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
 	}
 }
 
-static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
+static void f1x_setup_mci_misc_attrs(struct mem_ctl_info *mci)
 {
 	struct amd64_pvt *pvt = mci->pvt_info;
 
@@ -3804,6 +3804,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
 		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
 		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
+		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		break;
 
 	case 0x10:
@@ -3821,6 +3822,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
 		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
 		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
+		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		break;
 
 	case 0x15:
@@ -3854,6 +3856,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
 		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
 		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
+		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		break;
 
 	case 0x16:
@@ -3877,6 +3880,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
 		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
 		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
+		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		break;
 
 	case 0x17:
@@ -3914,6 +3918,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->ecc_enabled			= f17_ecc_enabled;
 		pvt->ops->determine_edac_cap		= f17_determine_edac_cap;
 		pvt->ops->determine_edac_ctl_cap	= f17_determine_edac_ctl_cap;
+		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -3957,6 +3962,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->ecc_enabled			= f17_ecc_enabled;
 		pvt->ops->determine_edac_cap		= f17_determine_edac_cap;
 		pvt->ops->determine_edac_ctl_cap	= f17_determine_edac_ctl_cap;
+		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		break;
 
 	default:
@@ -3969,7 +3975,8 @@ static int per_family_init(struct amd64_pvt *pvt)
 	    !pvt->ops->get_base_mask || !pvt->ops->prep_chip_selects ||
 	    !pvt->ops->determine_memory_type || !pvt->ops->determine_ecc_sym_sz ||
 	    !pvt->ops->get_mc_regs || !pvt->ops->ecc_enabled ||
-	    !pvt->ops->determine_edac_cap || !pvt->ops->determine_edac_ctl_cap) {
+	    !pvt->ops->determine_edac_cap || !pvt->ops->determine_edac_ctl_cap ||
+	    !pvt->ops->setup_mci_misc_attrs) {
 		edac_dbg(1, "Common helper routines not defined.\n");
 		return -EFAULT;
 	}
@@ -4064,7 +4071,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	mci->pvt_info = pvt;
 	mci->pdev = &pvt->F3->dev;
 
-	setup_mci_misc_attrs(mci);
+	pvt->ops->setup_mci_misc_attrs(mci);
 
 	if (init_csrows(mci))
 		mci->edac_cap = EDAC_FLAG_NONE;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 0e0715a16981..1ffee0009a53 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -472,6 +472,7 @@ struct low_ops {
 	bool (*ecc_enabled)(struct amd64_pvt *pvt);
 	unsigned long (*determine_edac_cap)(struct amd64_pvt *pvt);
 	void (*determine_edac_ctl_cap)(struct mem_ctl_info *mci, struct amd64_pvt *pvt);
+	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

