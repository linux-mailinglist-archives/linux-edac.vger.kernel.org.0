Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE64C7186
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbiB1QPi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiB1QPh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:15:37 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7A24553F
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3GTEQWxZaQ0Q6dJbDrRAi3g4S6ApJGHgfAw2xwbaXzUvQH3aAxNvjjWnSdjFNoWO3qoRDbqqpbg1d692mtn6ahLw9r9JwvSIuiDXtpOCHETeHl3McX3VphciODo7PWy7fjR0u1fBRATx54fAbya0OOBvhLIwnSfIF729RHIxq2jf8ZXxf59WTDeefgGE8kzaxJkAZmmyMtmYo7XotlZ2hclvcrnl8Q7Gt3CqRr6QVbt4WL0dLKJxxOg6vz8NjvMLAGLSResx/b7qLVf/W+GFvqKb8le8kRbiCAWcZgp2GyNDMIBY+mvkR1QeLPICDXdB+llb6MGHpaMxT8BIpUHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsqymEo6PbccYmmtBuMVWeD3iELFzMsP1/fon7T2xCM=;
 b=do4sNG15NvmTDZJjdEjtwt5VdiL0kjEE64z9nRbPt8MQ86GFMxxeToXND3mkUabGBJODnog/2zgJHgFQBqBgYGXMQt9UYRr9SKLyuHC3VbKd1SlKe1wC9XZr9nqsOzPD/F8ZnRYg3n/pYurLg7qiypFVs7GvrjF/ATXI29nTv6LN9CnTShHpWo32yyqxkTuDBPFlsat4JjH9YNn+iPK26MTp9KOLOT20i75MJ50GXF5o6ofa/VykYhEOzP+dlv1ZMD11qa5kJthVVs0d7JdAvd0uw6BuGBmSBzHrND5Ifyd1aMqa0rHfyagVNLy1mw20lFZaOZt+hX+j39HqiFgVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsqymEo6PbccYmmtBuMVWeD3iELFzMsP1/fon7T2xCM=;
 b=S3CDuSn49X7pLBkZLBWPbTBZhbFWXSbmBQVJLeADkaZ5TbC4NKI4QHeV9kzXu1ElKmH2dgb2NLkL30VaanJGTjoJN2BOfm/2wqW4W2MF3pYEAq7dFaORXPOHFnrd6vDPaKB3ZAuodxRkzylvEq0VEgoqQCQT4RN97pY+j+Z+L7Y=
Received: from BN9PR03CA0967.namprd03.prod.outlook.com (2603:10b6:408:109::12)
 by DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Mon, 28 Feb
 2022 16:14:56 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::d4) by BN9PR03CA0967.outlook.office365.com
 (2603:10b6:408:109::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:55 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:51 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 14/14] EDAC/amd64: Add get_umc_error_info() into pvt->ops
Date:   Mon, 28 Feb 2022 21:43:54 +0530
Message-ID: <20220228161354.54923-15-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9f96f25c-2ef6-4a5b-e1c6-08d9fad575bd
X-MS-TrafficTypeDiagnostic: DM4PR12MB5214:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5214CFAC0B4A3E38E995B8ACE8019@DM4PR12MB5214.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9tIm2Le4sbiRW63jygpJD6f+DW0DvDwc6ohlooN1q0rD0Sq+RR4IECOgb/yGhEI41scv/GfdttjbOhG//G75RnhFMNP5l7fho5dG+YUyMd88FWS1TdCpahbm56CRD9hpVSxG13y/6S/yssw1/h1CvOrPq5NMsRTHZQ/VdMhC/gjnZ0Nw8k8QIXPlxK8h9aqemyuUJo5yY7WQIzrr+a8TTe1hnYhLCVg0wTGRox1JiZgyU3wL77aJw+gRig8Ia9WIbLVw+GuMbEpsuFU9ehR6RbDBtqwwvpX+VBDe3H+6T2v1qciqOhEHANMNVLnwzv//Zx5KoYMyC8Lf5YyH2rzqYz2MgiWK2DDpdJP8N+9v2cInSz+sjqa08enOjQCEalAKCwGTN3dl5PpRDqj9naUVfxWEoIznlZg7NMROAIRismrh1C6NRopUNMXfJNd+ktUDh6uu8z8n0KYTqBPFvBY3qalQmO66WKZfS+KPyXI0iG5j4Y4mQdasu01dOoN8VoDDrDdVfWCZOUCGBkE0ypkhz/phkXkawrY0yuAWfM2e+2QywEMwWnpbMovqoZ9yH0R9gruYy/3pdJryEKWgQg1NCO22M73aQRnV6rj17WZ2c2iM4FCEJ6w4pPKFj4mOC66BdwRbstWKQEKuooMOACsboO1aMz2zDgSYeCZ+EMPpUDWHcHB/7LQvlAwHfg5NDLk7Yl6c9wr7Z9ydbCucATJEJpedyBiWwStSZxOohDFHSyr68k3qAkemQB0bP3218S1FwcJEKEUQjZlBEINa4nKFuSFZQuK5KujxfsJdTdSTv4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(356005)(966005)(70206006)(316002)(7696005)(6916009)(54906003)(36860700001)(36756003)(47076005)(83380400001)(508600001)(40460700003)(2616005)(8936002)(2906002)(26005)(4326008)(186003)(16526019)(82310400004)(1076003)(8676002)(426003)(336012)(5660300002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:55.9211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f96f25c-2ef6-4a5b-e1c6-08d9fad575bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
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

Add function pointer for get_umc_error_info() in pvt->ops and assign
family specific get_umc_error_info() definitions appropriately.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
This patch is created by splitting the 5/12th patch in series
[v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/

 drivers/edac/amd64_edac.c | 19 ++++++++++++++-----
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 7a20f8a696de..ab4e16070a02 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3056,10 +3056,13 @@ static inline void decode_bus_error(int node_id, struct mce *m)
  * Currently, we can derive the channel number by looking at the 6th nibble in
  * the instance_id. For example, instance_id=0xYXXXXX where Y is the channel
  * number.
+ *
+ * csrow can be derived from the lower 3 bits of MCA_SYND value.
  */
-static int find_umc_channel(struct mce *m)
+static void f17_umc_err_info(struct mce *m, struct err_info *err)
 {
-	return (m->ipid & GENMASK(31, 0)) >> 20;
+	err->channel = (m->ipid & GENMASK(31, 0)) >> 20;
+	err->csrow = m->synd & 0x7;
 }
 
 static void decode_umc_error(int node_id, struct mce *m)
@@ -3081,8 +3084,6 @@ static void decode_umc_error(int node_id, struct mce *m)
 	if (m->status & MCI_STATUS_DEFERRED)
 		ecc_type = 3;
 
-	err.channel = find_umc_channel(m);
-
 	if (!(m->status & MCI_STATUS_SYNDV)) {
 		err.err_code = ERR_SYND;
 		goto log_error;
@@ -3097,7 +3098,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 			err.err_code = ERR_CHANNEL;
 	}
 
-	err.csrow = m->synd & 0x7;
+	pvt->ops->get_umc_error_info(m, &err);
 
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
@@ -3927,6 +3928,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->populate_csrows		= init_csrows_df;
 		pvt->ops->dump_misc_regs		= __dump_misc_regs_df;
 		pvt->ops->get_cs_mode			= f17_get_cs_mode;
+		pvt->ops->get_umc_error_info		= f17_umc_err_info;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -3974,6 +3976,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->populate_csrows		= init_csrows_df;
 		pvt->ops->dump_misc_regs		= __dump_misc_regs_df;
 		pvt->ops->get_cs_mode			= f17_get_cs_mode;
+		pvt->ops->get_umc_error_info		= f17_umc_err_info;
 		break;
 
 	default:
@@ -3993,6 +3996,12 @@ static int per_family_init(struct amd64_pvt *pvt)
 		return -EFAULT;
 	}
 
+	/* ops required for families 17h and later */
+	if (pvt->fam >= 0x17 && !pvt->ops->get_umc_error_info) {
+		edac_dbg(1, "Platform specific helper routines not defined.\n");
+		return -EFAULT;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 2c93f8e0021a..43d9b11b826d 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -476,6 +476,7 @@ struct low_ops {
 	int  (*populate_csrows)(struct mem_ctl_info *mci);
 	void (*dump_misc_regs)(struct amd64_pvt *pvt);
 	int  (*get_cs_mode)(int dimm, u8 ctrl, struct amd64_pvt *pvt);
+	void (*get_umc_error_info)(struct mce *m, struct err_info *err);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

