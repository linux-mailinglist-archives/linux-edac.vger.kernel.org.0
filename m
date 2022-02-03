Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2CE4A8AC2
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 18:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiBCRu7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 12:50:59 -0500
Received: from mail-bn8nam12on2072.outbound.protection.outlook.com ([40.107.237.72]:40033
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353119AbiBCRue (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z41XN6Fmkz7g2KgovNpylNOzQtKGyeqLB6ucLhBMta2du9xm0Fy54vh4eR/AoS5bjNNu5GyXEJQdgPE1SZsKtyWpsZ0UopDMZFnwY0aqt6Jnxy8icOWQiq1t4DuV/ovH0lzmyM9hy6LXwFMGCjdg/7MEuyO2I9Hua7ndjxhzTB+c3fi6RXRzCFJh8c2XnrX/6HY2mpmgqs+rcDoa14qdL8sJwgb2eOuJbs9jg8ZWgBQ9jjcHOr7bU+IKOiOrspEe2BNW3CaB/ZQHcOvEzx9Q26XccRQKoC8+xTgFFPaQ1Vom/Pr/AwXsjbrUf0yhjCDVH7hMVSx70uuxPQwJB7j6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSp5AyC1NrGmgO1uYNL2peQXGZdt8Hpz6j6UM+TB490=;
 b=Y9bKlX6DZUlOKRWfTw/Q+AheAPNUiR/oBQK21y+eiPLHr1fp3kBk1Ai50jOXZBl8e8/QZbYXjNq0oe6rEvTnUGNwVwN4P9YHZkcMc2VVfAYiEbGrMB0n9fi6bggLMqnW1F7lE+HBhfNGejZfFXDkhttVLHHRKnQAhJvHV7QDVrTaeHedQzYEsBgMeojwleZ7DdYObiqakrOnIk19v5qKjpQicVhcUpPHPnuHnK+VSuqAweNWjVuQQW/wFXIE/36sRhPXbZlZJb1GX5t8vGSW2Mboy5h9+gJrwT31j2LqgDL2mEcOoe4sDEY8qEO7whrzCJJm/hzA+TN5QS5OnlG1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSp5AyC1NrGmgO1uYNL2peQXGZdt8Hpz6j6UM+TB490=;
 b=p/NsdTThZ+j9ojg0Huj7JoUnj0z636KYh8rZ1ZKh/DoVgY8MIV9v4IIj8ZRCadf3ZaCgIzQ5deyrnmzikRBZudjre8wx0vsAzKpvpAdhu8PcFxk5MMGX3GW0cCxpxpK2yiGCq+VnBhK+iO35A4UmhaLOpFRKTiozLkgZsXkVM+E=
Received: from MW4PR02CA0021.namprd02.prod.outlook.com (2603:10b6:303:16d::31)
 by BY5PR12MB3746.namprd12.prod.outlook.com (2603:10b6:a03:1a7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 17:50:30 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::3b) by MW4PR02CA0021.outlook.office365.com
 (2603:10b6:303:16d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Thu, 3 Feb 2022 17:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:50:30 +0000
Received: from node-bp128-r03d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 11:50:27 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH v7 08/12] EDAC/amd64: Add Family ops to update GPU csrow and channel info
Date:   Thu, 3 Feb 2022 11:49:38 -0600
Message-ID: <20220203174942.31630-9-nchatrad@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203174942.31630-1-nchatrad@amd.com>
References: <20220203174942.31630-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5414c88-6b47-4416-c4e1-08d9e73dab64
X-MS-TrafficTypeDiagnostic: BY5PR12MB3746:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3746B6D34F7CF1F77EFD7201E8289@BY5PR12MB3746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZVBLebseeFDdcBdq8ausGYN5vloXcOOG2d5QwNYpcUFiH+8QzxccY08gK/ZGB6EDI2N+QaHUuYnVAlqrczzSayxqTx++hbvqOE3EYT4LRydfj6HdEeJ4tCrnP+CG9mGwLmFAus1b9SaIsqsaWogO5GkRpcZ6uhcoi6EfFKffVMKKqFBfVPAPdYXjru8E2zHoJajFBfzwVYEKmYCxjwCGEAHqfWn+vwbZfCYpkZUroq8zyWuFXKJTJl+k+H9tCTZLXlxPBAcuDIpQcv6lzGpV/TYsM2YK4L2QGG3putddM3WTQkKpqxNPmfWg/mhqpkiVtflSvAdVqcXdYr9/nh09oH2RZ3EH44ggBac+EQRydmpR3wPIMWhVjdaSNKaYmd73mfecUzkBawhIr9AY9WI9ZkcSNtCfp1I/MQ1hQ3tnpitJS6spH84YMn4uSLWLaoae58r2Co2q/7eNHswGWkLMn2NLjzLYFcgT2UJRMQPZ69FuP16y4imrhm9vc3D/hSaVYp6N+h+v7Mncyg7d18qJGEjypaiPGeXH8GjlsNegTFi6HmIqcmtPUHdh/ucml2welYHcNPtH3BTAkLBXnsUR7G5OgepDnXWTg6sIRDlESMSLUQI06u4cbcYnGxffbHLBKj7U0t8t5nVMDvoK05qp+bhRt5on9K3rrjNGbExtTcPQ914aOqdmTos+lpMYywZBuhe/JkN4OvezfUVEPf0vg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(15650500001)(82310400004)(8936002)(426003)(2906002)(7696005)(8676002)(2616005)(5660300002)(70206006)(70586007)(4326008)(6666004)(47076005)(40460700003)(508600001)(336012)(356005)(186003)(83380400001)(81166007)(26005)(36756003)(316002)(54906003)(16526019)(1076003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:50:30.2290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5414c88-6b47-4416-c4e1-08d9e73dab64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3746
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

GPU node has 'X' number of PHYs and 'Y' number of channels.
This results in 'X*Y' number of instances in the Data Fabric.
Therefore the Data Fabric ID of an instance in GPU as below:
  df_inst_id = 'X' * number of channels per PHY + 'Y'

On CPUs the Data Fabric ID of an instance on a CPU is equal to the
UMC number. since the UMC number and channel are equal in CPU nodes,
the channel can be used as the Data Fabric ID of the instance.

Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Co-developed-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
v1->v7:
* New change in v7

 drivers/edac/amd64_edac.c | 60 +++++++++++++++++++++++++++++++++++++--
 drivers/edac/amd64_edac.h |  2 ++
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 10efe726a959..241419a0be93 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3653,6 +3653,30 @@ static inline void decode_bus_error(int node_id, struct mce *m)
 	__log_ecc_error(mci, &err, ecc_type);
 }
 
+/*
+ * On CPUs, The Data Fabric ID of an instance is equal to the UMC number.
+ * And since the UMC number and channel are equal in CPU nodes, the channel can be used
+ * as the Data Fabric ID of the instance.
+ */
+static int f17_df_inst_id(struct mem_ctl_info *mci, struct amd64_pvt *pvt,
+			  struct err_info *err)
+{
+	return err->channel;
+}
+
+/*
+ * A GPU node has 'X' number of PHYs and 'Y' number of channels.
+ * This results in 'X*Y' number of instances in the Data Fabric.
+ * Therefore the Data Fabric ID of an instance can be found with the following formula:
+ * df_inst_id = 'X' * number of channels per PHY + 'Y'
+ *
+ */
+static int gpu_df_inst_id(struct mem_ctl_info *mci, struct amd64_pvt *pvt,
+			  struct err_info *err)
+{
+	return (err->csrow * pvt->channel_count / mci->nr_csrows) + err->channel;
+}
+
 /*
  * To find the UMC channel represented by this bank we need to match on its
  * instance_id. The instance_id of a bank is held in the lower 32 bits of its
@@ -3670,12 +3694,38 @@ static void update_umc_err_info(struct mce *m, struct err_info *err)
 	err->csrow = m->synd & 0x7;
 }
 
+/*
+ * The CPUs have one channel per UMC, So  UMC number is equivalent to a
+ * channel number. The GPUs have 8 channels per UMC, so the UMC number no
+ * longer works as a channel number.
+ * The channel number within a GPU UMC is given in MCA_IPID[15:12].
+ * However, the IDs are split such that two UMC values go to one UMC, and
+ * the channel numbers are split in two groups of four.
+ *
+ * Refer comment on get_umc_base_gpu() from amd64_edac.h
+ *
+ * For example,
+ * UMC0 CH[3:0] = 0x0005[3:0]000
+ * UMC0 CH[7:4] = 0x0015[3:0]000
+ * UMC1 CH[3:0] = 0x0025[3:0]000
+ * UMC1 CH[7:4] = 0x0035[3:0]000
+ */
+static void gpu_update_umc_err_info(struct mce *m, struct err_info *err)
+{
+	u8 ch = (m->ipid & GENMASK(31, 0)) >> 20;
+	u8 phy = ((m->ipid >> 12) & 0xf);
+
+	err->channel = ch % 2 ? phy + 4 : phy;
+	err->csrow = phy;
+}
+
 static void decode_umc_error(int node_id, struct mce *m)
 {
 	u8 ecc_type = (m->status >> 45) & 0x3;
 	struct mem_ctl_info *mci;
 	struct amd64_pvt *pvt;
 	struct err_info err;
+	u8 df_inst_id;
 	u64 sys_addr;
 
 	mci = edac_mc_find(node_id);
@@ -3705,7 +3755,9 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	pvt->ops->get_umc_err_info(m, &err);
 
-	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
+	df_inst_id = pvt->ops->find_umc_inst_id(mci, pvt, &err);
+
+	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, df_inst_id, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
 	}
@@ -4625,6 +4677,7 @@ static void per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_mc_regs			= __read_mc_regs_df;
 		pvt->ops->populate_csrows		= init_csrows_df;
 		pvt->ops->get_umc_err_info		= update_umc_err_info;
+		pvt->ops->find_umc_inst_id		= f17_df_inst_id;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -4678,6 +4731,8 @@ static void per_family_init(struct amd64_pvt *pvt)
 				pvt->ops->dump_misc_regs	= gpu_dump_misc_regs;
 				pvt->ops->get_mc_regs		= gpu_read_mc_regs;
 				pvt->ops->populate_csrows	= gpu_init_csrows;
+				pvt->ops->get_umc_err_info	= gpu_update_umc_err_info;
+				pvt->ops->find_umc_inst_id	= gpu_df_inst_id;
 				goto end_fam;
 			} else {
 				pvt->ctl_name		= "F19h_M30h";
@@ -4707,6 +4762,7 @@ static void per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_mc_regs			= __read_mc_regs_df;
 		pvt->ops->populate_csrows		= init_csrows_df;
 		pvt->ops->get_umc_err_info		= update_umc_err_info;
+		pvt->ops->find_umc_inst_id		= f17_df_inst_id;
  end_fam:
 		break;
 
@@ -4728,7 +4784,7 @@ static void per_family_init(struct amd64_pvt *pvt)
 	}
 
 	/* ops required for families 17h and later */
-	if (pvt->fam >= 0x17 && !pvt->ops->get_umc_err_info) {
+	if (pvt->fam >= 0x17 && (!pvt->ops->get_umc_err_info || !pvt->ops->find_umc_inst_id)) {
 		edac_dbg(1, "Platform specific helper routines not defined.\n");
 		return;
 	}
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 71df08a496d2..b6177bd5d5ba 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -496,6 +496,8 @@ struct low_ops {
 	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
 	int  (*populate_csrows)(struct mem_ctl_info *mci);
 	void (*get_umc_err_info)(struct mce *m, struct err_info *err);
+	int  (*find_umc_inst_id)(struct mem_ctl_info *mci, struct amd64_pvt *pvt,
+				 struct err_info *err);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

