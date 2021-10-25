Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E7243994C
	for <lists+linux-edac@lfdr.de>; Mon, 25 Oct 2021 16:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhJYOyF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Oct 2021 10:54:05 -0400
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:37350
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233720AbhJYOyD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 25 Oct 2021 10:54:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1jBsulxaYhXLo4t2oVnOyyb0tfjisB2RVRixO3IuWBXW5aK4OvtFNbniMtJky2pbH3fAbtbz9E7LHaZhy/4NZ1QyfU72FL7Fnn0LY8An9/9xhrZQWK4CEwKv46bkFUOTnKS3bB9AEyjKGsxpWpehlsXV7nEL27IvEbHId0ByobQB/srFSIFR+9qYxDupyxkAMP69a51FBAZLLEseFdDKFZ5HxvDnfwQH6u1/0wnrs1ZS4A7Gbss4Un+3xDriMHbJEIxAk2K7SG4X5Aq4v28sSMFl/AQh0T178E36hv6U3W2b4At5ciSPEuyXKLcWVtxsMvhdW0h/niiKyllQINiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwkxLgb1xFEyTN0WQihNzd4jQ10rrsSUx03vemfeuOw=;
 b=KFmgmlXhV3cuHTsDJSTbM2wUyMs64Jo7aRh6naQUdV9JFqmOwo52LIEowJF4FUBDASI5yk+7RtTaky9X4cN+Ra6ImKhgOGMMSBID1MJ7f4yRD9KTutCc9ABiupKajIkHimp+uNyYd6VohFRZiVaAJlooOZJ0vVSaBwJTt2aGgWKGd+KSMxxIFJnpcvZbihGLbsJGOfGIqw67bujUmDMSdtDmRYE18AGZV0AB74EHgZX3CC7j5WshpXNJb9X1caM8A9rippAfr3CQvrbw60LDqPjc1ozvqOkqICKgqa0xyekW8dW7l7xqKW5hkDA0hjK8Zzbfk2RZS7LdiDPLGFAqFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwkxLgb1xFEyTN0WQihNzd4jQ10rrsSUx03vemfeuOw=;
 b=bUGY4tucfTM/A6FCX8F5hOYoZR/hMZSDo4W259B/6dvMUB58CnxU0Cak3pxfywhPFj/20Rn0qNU6boXXqlMx6mvxC1Ppg1VeygeP4HLifEyGem+/hD95hwOQ5nFlwvpw99CBVeAOb4WnStRAEVwujRjxZ+9P/aMoQMji0ofPSmw=
Received: from MW2PR16CA0060.namprd16.prod.outlook.com (2603:10b6:907:1::37)
 by CH0PR12MB5298.namprd12.prod.outlook.com (2603:10b6:610:d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 14:51:38 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::17) by MW2PR16CA0060.outlook.office365.com
 (2603:10b6:907:1::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 14:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 14:51:37 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 09:51:33 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v5 3/5] EDAC/amd64: Extend family ops functions
Date:   Mon, 25 Oct 2021 20:20:16 +0530
Message-ID: <20211025145018.29985-4-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025145018.29985-1-nchatrad@amd.com>
References: <20211025145018.29985-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83af26f0-428a-4c1b-ac0e-08d997c6f2be
X-MS-TrafficTypeDiagnostic: CH0PR12MB5298:
X-Microsoft-Antispam-PRVS: <CH0PR12MB529825A8E15CAAA0F0044DEAE8839@CH0PR12MB5298.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2yuydhbaK2Ew2dhCodpdJaKARENOej06sHWLAkv0SHW1UIyIlYRP2u2W7eS+ap9L5/Zdtn9vPsrNzwCfIXjo3cpKMny2ED8ucqxp0V4onCeiSQMd8h34SOz9/J3p2hGSTycQVmNrGf1ZI9Z6xzEQwWWMYOhlt9XK2ebSk94DmWOV6KZBB/ketKp3gfs35adkr8w+lbHM48GoizfGSay0QZHHTpWKfTmfU+nT3+VB5uwXyJswMWzU3xllr3veJ2cqFEvi0EEORMirSPV8QZ1lGFXhA1ouiPxhxASw7TMM7qjgLWLYnDPBSJjVkwX81YE1vSNQSCyEWOLpRmzDdr19VHSykuwLnoM3MUSBAtIV17CSAl9y7J4qTRsGWSe/KEsKX+uJ727X1/8C8ol+fIvCo/Fb+rdALzmMNWbQOKETZJPh5qtNNuhFanVeBoL2/t1Cn8iSNFcEC5YfT8gxmkjUcAD2lG/LTHDIfo7gRk8roR2TJwq10OaE8W2X22sVZEGWNEqvLSfI4QylGZHhej6cMj6lJtv87T3bgK1gNQ4Xyks4aMy1M7APLwKw6K9Az15qgQ49juALEgVVZFTCSeDbJpLWBYNhH3f38YZz5vrJz7KUwL4qcAA0rv7NELIgs9mC+q4yoeSi8LoiHqzRF6ggVysyfs4Rj5bwg3dUq9U4X0YE+VCHKYhAOcG07xIhiy4gznqoUaXGlol9EYKZ6mZhIVTFCwmljfbHwM2EjRE3ZRSYXSS7ddOMqqiVBr6Swxv/ndqsZRWVcI6+/Zzx6XNy8Stnn/cBg2sohlrTpRtNEqPd+Y8akqLp9Inj5kEH5j/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(4326008)(110136005)(966005)(508600001)(2906002)(26005)(8936002)(47076005)(5660300002)(316002)(8676002)(6666004)(54906003)(30864003)(16526019)(426003)(70206006)(36756003)(186003)(83380400001)(36860700001)(70586007)(356005)(1076003)(2616005)(336012)(81166007)(7696005)(82310400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 14:51:37.9248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83af26f0-428a-4c1b-ac0e-08d997c6f2be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5298
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Create new family operation routines and define them respectively.
This would simplify adding support for future platforms.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Link: https://lkml.kernel.org/r/20211014185400.10451-4-nchatrad@amd.com
---
Changes since v4:
1. Modified k8_prep_chip_selects for ext_model checks
2. Add read_dct_base_mask to ops
3. Renamed find_umc_channel and addressed minor comments

Changes since v3:
1. Defined new family operation routines

Changs since v2:
1. new patch

 drivers/edac/amd64_edac.c | 236 +++++++++++++++++++++++---------------
 drivers/edac/amd64_edac.h |  10 +-
 2 files changed, 151 insertions(+), 95 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4fce75013674..88d38dbb4e7e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1204,10 +1204,7 @@ static void __dump_misc_regs(struct amd64_pvt *pvt)
 /* Display and decode various NB registers for debug purposes. */
 static void dump_misc_regs(struct amd64_pvt *pvt)
 {
-	if (pvt->umc)
-		__dump_misc_regs_df(pvt);
-	else
-		__dump_misc_regs(pvt);
+	pvt->ops->display_misc_regs(pvt);
 
 	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
 
@@ -1217,28 +1214,39 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
 /*
  * See BKDG, F2x[1,0][5C:40], F2[1,0][6C:60]
  */
-static void prep_chip_selects(struct amd64_pvt *pvt)
+static void k8_prep_chip_selects(struct amd64_pvt *pvt)
 {
 	if (pvt->fam == 0xf && pvt->ext_model < K8_REV_F) {
 		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
 		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 8;
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
-
-	} else {
+	} else if (pvt->fam == 0xf && pvt->ext_model >= K8_REV_F) {
 		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
 		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
 	}
 }
 
+static void f15m30_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
+	pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
+}
+
+static void default_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
+	pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
+}
+
+static void f17_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	int umc;
+
+	for_each_umc(umc) {
+		pvt->csels[umc].b_cnt = 4;
+		pvt->csels[umc].m_cnt = 2;
+	}
+}
+
 static void read_umc_base_mask(struct amd64_pvt *pvt)
 {
 	u32 umc_base_reg, umc_base_reg_sec;
@@ -1297,11 +1305,6 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 {
 	int cs;
 
-	prep_chip_selects(pvt);
-
-	if (pvt->umc)
-		return read_umc_base_mask(pvt);
-
 	for_each_chip_select(cs, 0, pvt) {
 		int reg0   = DCSB0 + (cs * 4);
 		int reg1   = DCSB1 + (cs * 4);
@@ -2512,143 +2515,174 @@ static void debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 	}
 }
 
+/* Prototypes for family specific ops routines */
+static int init_csrows(struct mem_ctl_info *mci);
+static int init_csrows_df(struct mem_ctl_info *mci);
+static void __read_mc_regs_df(struct amd64_pvt *pvt);
+static void update_umc_err_info(struct mce *m, struct err_info *err);
+
+static const struct low_ops k8_ops = {
+	.early_channel_count	= k8_early_channel_count,
+	.map_sysaddr_to_csrow	= k8_map_sysaddr_to_csrow,
+	.dbam_to_cs		= k8_dbam_to_chip_select,
+	.prep_chip_select	= k8_prep_chip_selects,
+	.get_base_mask		= read_dct_base_mask,
+	.display_misc_regs	= __dump_misc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f10_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f10_dbam_to_chip_select,
+	.prep_chip_select	= default_prep_chip_selects,
+	.get_base_mask		= read_dct_base_mask,
+	.display_misc_regs	= __dump_misc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f15_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f15_dbam_to_chip_select,
+	.prep_chip_select	= default_prep_chip_selects,
+	.get_base_mask		= read_dct_base_mask,
+	.display_misc_regs	= __dump_misc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f15m30_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f16_dbam_to_chip_select,
+	.prep_chip_select	= f15m30_prep_chip_selects,
+	.get_base_mask		= read_dct_base_mask,
+	.display_misc_regs	= __dump_misc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f15m60_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f15_m60h_dbam_to_chip_select,
+	.prep_chip_select	= default_prep_chip_selects,
+	.get_base_mask		= read_dct_base_mask,
+	.display_misc_regs	= __dump_misc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f16_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f16_dbam_to_chip_select,
+	.prep_chip_select	= default_prep_chip_selects,
+	.get_base_mask		= read_dct_base_mask,
+	.display_misc_regs	= __dump_misc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f17_ops = {
+	.early_channel_count	= f17_early_channel_count,
+	.dbam_to_cs		= f17_addr_mask_to_cs_size,
+	.prep_chip_select	= f17_prep_chip_selects,
+	.get_base_mask		= read_umc_base_mask,
+	.display_misc_regs	= __dump_misc_regs_df,
+	.get_mc_regs		= __read_mc_regs_df,
+	.populate_csrows	= init_csrows_df,
+	.get_umc_err_info	= update_umc_err_info,
+};
+
 static struct amd64_family_type family_types[] = {
 	[K8_CPUS] = {
 		.ctl_name = "K8",
 		.f1_id = PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP,
 		.f2_id = PCI_DEVICE_ID_AMD_K8_NB_MEMCTL,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= k8_early_channel_count,
-			.map_sysaddr_to_csrow	= k8_map_sysaddr_to_csrow,
-			.dbam_to_cs		= k8_dbam_to_chip_select,
-		}
+		.ops = k8_ops,
 	},
 	[F10_CPUS] = {
 		.ctl_name = "F10h",
 		.f1_id = PCI_DEVICE_ID_AMD_10H_NB_MAP,
 		.f2_id = PCI_DEVICE_ID_AMD_10H_NB_DRAM,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f10_dbam_to_chip_select,
-		}
+		.ops = f10_ops,
 	},
 	[F15_CPUS] = {
 		.ctl_name = "F15h",
 		.f1_id = PCI_DEVICE_ID_AMD_15H_NB_F1,
 		.f2_id = PCI_DEVICE_ID_AMD_15H_NB_F2,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f15_dbam_to_chip_select,
-		}
+		.ops = f15_ops,
 	},
 	[F15_M30H_CPUS] = {
 		.ctl_name = "F15h_M30h",
 		.f1_id = PCI_DEVICE_ID_AMD_15H_M30H_NB_F1,
 		.f2_id = PCI_DEVICE_ID_AMD_15H_M30H_NB_F2,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f16_dbam_to_chip_select,
-		}
+		.ops = f15m30_ops,
 	},
 	[F15_M60H_CPUS] = {
 		.ctl_name = "F15h_M60h",
 		.f1_id = PCI_DEVICE_ID_AMD_15H_M60H_NB_F1,
 		.f2_id = PCI_DEVICE_ID_AMD_15H_M60H_NB_F2,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f15_m60h_dbam_to_chip_select,
-		}
+		.ops = f15m60_ops,
 	},
 	[F16_CPUS] = {
 		.ctl_name = "F16h",
 		.f1_id = PCI_DEVICE_ID_AMD_16H_NB_F1,
 		.f2_id = PCI_DEVICE_ID_AMD_16H_NB_F2,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f16_dbam_to_chip_select,
-		}
+		.ops = f16_ops,
 	},
 	[F16_M30H_CPUS] = {
 		.ctl_name = "F16h_M30h",
 		.f1_id = PCI_DEVICE_ID_AMD_16H_M30H_NB_F1,
 		.f2_id = PCI_DEVICE_ID_AMD_16H_M30H_NB_F2,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f16_dbam_to_chip_select,
-		}
+		.ops = f16_ops,
 	},
 	[F17_CPUS] = {
 		.ctl_name = "F17h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_17H_DF_F6,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
+		.ops = f17_ops,
 	},
 	[F17_M10H_CPUS] = {
 		.ctl_name = "F17h_M10h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
+		.ops = f17_ops,
 	},
 	[F17_M30H_CPUS] = {
 		.ctl_name = "F17h_M30h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
 		.max_mcs = 8,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
+		.ops = f17_ops,
 	},
 	[F17_M60H_CPUS] = {
 		.ctl_name = "F17h_M60h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F6,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
+		.ops = f17_ops,
 	},
 	[F17_M70H_CPUS] = {
 		.ctl_name = "F17h_M70h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
+		.ops = f17_ops,
 	},
 	[F19_CPUS] = {
 		.ctl_name = "F19h",
 		.f0_id = PCI_DEVICE_ID_AMD_19H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_19H_DF_F6,
 		.max_mcs = 8,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
+		.ops = f17_ops,
 	},
 };
 
@@ -2899,10 +2933,13 @@ static inline void decode_bus_error(int node_id, struct mce *m)
  * Currently, we can derive the channel number by looking at the 6th nibble in
  * the instance_id. For example, instance_id=0xYXXXXX where Y is the channel
  * number.
+ *
+ * csrow can be derived from the lower 3 bits of MCA_SYND value.
  */
-static int find_umc_channel(struct mce *m)
+static void update_umc_err_info(struct mce *m, struct err_info *err)
 {
-	return (m->ipid & GENMASK(31, 0)) >> 20;
+	err->channel = (m->ipid & GENMASK(31, 0)) >> 20;
+	err->csrow = m->synd & 0x7;
 }
 
 static void decode_umc_error(int node_id, struct mce *m)
@@ -2924,8 +2961,6 @@ static void decode_umc_error(int node_id, struct mce *m)
 	if (m->status & MCI_STATUS_DEFERRED)
 		ecc_type = 3;
 
-	err.channel = find_umc_channel(m);
-
 	if (!(m->status & MCI_STATUS_SYNDV)) {
 		err.err_code = ERR_SYND;
 		goto log_error;
@@ -2940,7 +2975,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 			err.err_code = ERR_CHANNEL;
 	}
 
-	err.csrow = m->synd & 0x7;
+	pvt->ops->get_umc_err_info(m, &err);
 
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
@@ -3106,8 +3141,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 		edac_dbg(0, "  TOP_MEM2 disabled\n");
 	}
 
-	if (pvt->umc) {
-		__read_mc_regs_df(pvt);
+	if (pvt->ops->get_mc_regs) {
+		pvt->ops->get_mc_regs(pvt);
+
 		amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
 
 		goto skip;
@@ -3154,7 +3190,10 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	}
 
 skip:
-	read_dct_base_mask(pvt);
+	pvt->ops->prep_chip_select(pvt);
+
+	if (pvt->ops->get_base_mask)
+		pvt->ops->get_base_mask(pvt);
 
 	determine_memory_type(pvt);
 	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
@@ -3277,9 +3316,6 @@ static int init_csrows(struct mem_ctl_info *mci)
 	int nr_pages = 0;
 	u32 val;
 
-	if (pvt->umc)
-		return init_csrows_df(mci);
-
 	amd64_read_pci_cfg(pvt->F3, NBCFG, &val);
 
 	pvt->nbcfg = val;
@@ -3703,6 +3739,20 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		return NULL;
 	}
 
+	/* ops required for all the families */
+	if (!pvt->ops->early_channel_count || !pvt->ops->dbam_to_cs ||
+	    !pvt->ops->prep_chip_select || !pvt->ops->get_base_mask ||
+	    !pvt->ops->display_misc_regs || !pvt->ops->populate_csrows) {
+		edac_dbg(1, "Common helper routines not defined.\n");
+		return NULL;
+	}
+
+	/* ops required for families 17h and later */
+	if (pvt->fam >= 0x17 && (!pvt->ops->get_umc_err_info || !pvt->ops->get_mc_regs)) {
+		edac_dbg(1, "Platform specific helper routines not defined.\n");
+		return NULL;
+	}
+
 	return fam_type;
 }
 
@@ -3786,7 +3836,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 
 	setup_mci_misc_attrs(mci);
 
-	if (init_csrows(mci))
+	if (pvt->ops->populate_csrows(mci))
 		mci->edac_cap = EDAC_FLAG_NONE;
 
 	ret = -ENODEV;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 85aa820bc165..c7aeb2c46dc3 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -467,11 +467,17 @@ struct ecc_settings {
  * functions and per device encoding/decoding logic.
  */
 struct low_ops {
-	int (*early_channel_count)	(struct amd64_pvt *pvt);
+	int  (*early_channel_count)	(struct amd64_pvt *pvt);
 	void (*map_sysaddr_to_csrow)	(struct mem_ctl_info *mci, u64 sys_addr,
 					 struct err_info *);
-	int (*dbam_to_cs)		(struct amd64_pvt *pvt, u8 dct,
+	int  (*dbam_to_cs)		(struct amd64_pvt *pvt, u8 dct,
 					 unsigned cs_mode, int cs_mask_nr);
+	void (*prep_chip_select)	(struct amd64_pvt *pvt);
+	void (*get_base_mask)		(struct amd64_pvt *pvt);
+	void (*display_misc_regs)	(struct amd64_pvt *pvt);
+	void (*get_mc_regs)		(struct amd64_pvt *pvt);
+	int  (*populate_csrows)		(struct mem_ctl_info *mci);
+	void (*get_umc_err_info)	(struct mce *m, struct err_info *err);
 };
 
 struct amd64_family_type {
-- 
2.25.1

