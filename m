Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC2F43E188
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 15:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhJ1NEY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 09:04:24 -0400
Received: from mail-mw2nam08on2063.outbound.protection.outlook.com ([40.107.101.63]:33761
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230367AbhJ1NEX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 09:04:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jpm3N53dSnoNXRrviggHWN6tnRKLcgWGtNgqeimN2zfOs4muGIiyAsoXCKtPYvMS0FrszeLVd8VuEQOcSu5LEn46850xQlfpWMOb0+wntNGTorsm2gmoenoD5pchHqIm5RtW0y9EHebXIaMLOZ6Vv07Eyh6fH8zewVE1pDvKTI74/zEkbRKHnG7WNP6obj/ipBwXk3uUWakAtrSP7KTSU0ohx0B+kxnvLEfRIoh2TBplw9ae3DRORAq/6q2Rka2dTEip8mepJ48pPDAXZNlFJTMvZY6cwG6bQq+qv4gDTfFsrDwswHjyVdjOdV7tCSdBNhbmszoLaTL8NsTCoxGk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJO2gyLOaneYxbxlQb8NrBnRLBIeATD4B/NEEwusg4I=;
 b=gH6es2K8Iz3VdS4zc2A8QuwPNXAn6Aqsmsog5fc4jqyfdseAbTG9k0922d9+4miHo9N3eYotd8Tw1RIcwBO6VxV4eq41WKcnglQaL3EAYxKLTxRyeNVasiwc6FYSHsjsFNR86774uizLaUscH/i4lY93/eJhz+O7cEgGnjUhH17kBAi7/KWx89fOrjlbjZ5ceBdTE6CjC1VvvIG+rAkV858qzZshEORXGMRx+RL4rSbPzys0ohpyVSYbeEvQY97XnUReWNuOQzYbDoHQ+z+YYUwKU10n9NAQTuMJ5cvkuJ56XolX1nHWiS0D34cL1ovqFqi6Z96rHe0iRlgm677rqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJO2gyLOaneYxbxlQb8NrBnRLBIeATD4B/NEEwusg4I=;
 b=cb+lHWtFbPh4UEvskDuCq3d79/9SdhWMaFMjea23oNslI5mB+/8aWd5futZwu373FMbfE+xZRJuV+qJTK1Fjq1BaSdptKJdsfkVko22ZeweoObapoWJBKlxu+goIXXCKG0/p+X8ITtksIezkNolKPQDEURAWe234teLk04hC+8Y=
Received: from DS7PR03CA0210.namprd03.prod.outlook.com (2603:10b6:5:3b6::35)
 by CH0PR12MB5313.namprd12.prod.outlook.com (2603:10b6:610:d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 28 Oct
 2021 13:01:54 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::ca) by DS7PR03CA0210.outlook.office365.com
 (2603:10b6:5:3b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 13:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 13:01:53 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 08:01:50 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v6 3/5] EDAC/amd64: Extend family ops functions
Date:   Thu, 28 Oct 2021 18:31:04 +0530
Message-ID: <20211028130106.15701-4-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211028130106.15701-1-nchatrad@amd.com>
References: <20211028130106.15701-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 092abd0c-3b5f-4eeb-7715-08d99a131d89
X-MS-TrafficTypeDiagnostic: CH0PR12MB5313:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5313D4ACEA248A08CD4898A9E8869@CH0PR12MB5313.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u76hDsTrMxMGSF/aB3xcCBwa4w3A4dKdqiUtqH+hfawQNkxOSROKcjWZIHF55MTJC0/rOcgvOqvhKUm43fyhA4hvzllmKNA4PZ6/ABoxFAc1X+JIPReaAT6CBCl9lrtyMkfmyYRnSkcy3J+FP1QOgasIDPUaPlo4bdW201Re+2RVO/RbynNdgC6jpah6s2oxM4RpyqWBfb4KH/KHrcOYK6Dj4Imx4RKk8U4sAMKdGZxT2KkBANNlFHUi8tbVDm9N0G0c/WZiqryDU7WXDXbiXpFquL4R3wpF/1/+sxyJPSYPKMMIaSXvF+Rrg2sk3UHiyEEl/XMgrLVtGFQMapMpz+nx4/0b9fBAQLjqYDoHpg1hcgvAAJ9hi6MbcKsrX9sKOlILasQtjQkxpqsXqsxezsX66rM1wkBEtHBlcmfDmDZEDlO30LjbURxSw8I6UPF3SqRiFCuYDbJPdN3OANn5xqN3zAJJ+Kssc/KY1HYDKv5eRd4Zn2wkHdFgq52Wide11noWIJX/ug+Gp/heBDIgVCTOCsjP/fjNYn3GASGAfsFJIFNWFQCcn9ZdgWbPuFhSXp1Jm1/d0Mm46tcxMgNZ2HF8wlyVvflYhcg7BIi+uNjh3F7ugylysXjgA0kx1hh40ba9zOi+XK2M5xoG8E8Tyg5yMdrer1k/cJLeq8AuQTDNtmBSUxAnL1bNdBeJTwbKI0WdSZvlVfwmG0d2e6QqRODy/GIjTPx8t6o7TNKBTjzg/1yTa2s+UTc6LIGyPh//N4h0ogorKTxpF0qbLZjGpcCzM3DJ1whSPXWubXw6S7e2JEwiUQlCxwIm4p9eXzr3
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(26005)(356005)(81166007)(2906002)(70586007)(47076005)(16526019)(2616005)(426003)(966005)(186003)(70206006)(83380400001)(336012)(8936002)(5660300002)(8676002)(7696005)(316002)(36860700001)(36756003)(82310400003)(508600001)(30864003)(1076003)(6666004)(110136005)(54906003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 13:01:53.9190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 092abd0c-3b5f-4eeb-7715-08d99a131d89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5313
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
Changes since v5:
split read_mc_regs for per family ops
Adjusted and Called dump_misc_regs for family ops

Changes since v4:
1. Modified k8_prep_chip_selects for ext_model checks
2. Add read_dct_base_mask to ops
3. Renamed find_umc_channel and addressed minor comments

Changes since v3:
1. Defined new family operation routines

Changs since v2:
1. new patch

 drivers/edac/amd64_edac.c | 302 +++++++++++++++++++++++---------------
 drivers/edac/amd64_edac.h |  10 +-
 2 files changed, 188 insertions(+), 124 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4fce75013674..1029fe84ba2e 100644
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
+	pvt->ops->get_misc_regs(pvt);
 
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
@@ -2512,143 +2515,181 @@ static void debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 	}
 }
 
+/* Prototypes for family specific ops routines */
+static int init_csrows(struct mem_ctl_info *mci);
+static int init_csrows_df(struct mem_ctl_info *mci);
+static void read_mc_regs(struct amd64_pvt *pvt);
+static void __read_mc_regs_df(struct amd64_pvt *pvt);
+static void update_umc_err_info(struct mce *m, struct err_info *err);
+
+static const struct low_ops k8_ops = {
+	.early_channel_count	= k8_early_channel_count,
+	.map_sysaddr_to_csrow	= k8_map_sysaddr_to_csrow,
+	.dbam_to_cs		= k8_dbam_to_chip_select,
+	.prep_chip_select	= k8_prep_chip_selects,
+	.get_base_mask		= read_dct_base_mask,
+	.get_misc_regs		= __dump_misc_regs,
+	.get_mc_regs		= read_mc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f10_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f10_dbam_to_chip_select,
+	.prep_chip_select	= default_prep_chip_selects,
+	.get_base_mask		= read_dct_base_mask,
+	.get_misc_regs		= __dump_misc_regs,
+	.get_mc_regs		= read_mc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f15_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f15_dbam_to_chip_select,
+	.prep_chip_select	= default_prep_chip_selects,
+	.get_base_mask		= read_dct_base_mask,
+	.get_misc_regs		= __dump_misc_regs,
+	.get_mc_regs		= read_mc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f15m30_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f16_dbam_to_chip_select,
+	.prep_chip_select	= f15m30_prep_chip_selects,
+	.get_base_mask		= read_dct_base_mask,
+	.get_misc_regs		= __dump_misc_regs,
+	.get_mc_regs		= read_mc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f15m60_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f15_m60h_dbam_to_chip_select,
+	.prep_chip_select	= default_prep_chip_selects,
+	.get_base_mask		= read_dct_base_mask,
+	.get_misc_regs		= __dump_misc_regs,
+	.get_mc_regs		= read_mc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f16_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f16_dbam_to_chip_select,
+	.prep_chip_select	= default_prep_chip_selects,
+	.get_base_mask		= read_dct_base_mask,
+	.get_misc_regs		= __dump_misc_regs,
+	.get_mc_regs		= read_mc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f17_ops = {
+	.early_channel_count	= f17_early_channel_count,
+	.dbam_to_cs		= f17_addr_mask_to_cs_size,
+	.prep_chip_select	= f17_prep_chip_selects,
+	.get_base_mask		= read_umc_base_mask,
+	.get_misc_regs		= __dump_misc_regs_df,
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
 
@@ -2899,10 +2940,13 @@ static inline void decode_bus_error(int node_id, struct mce *m)
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
@@ -2924,8 +2968,6 @@ static void decode_umc_error(int node_id, struct mce *m)
 	if (m->status & MCI_STATUS_DEFERRED)
 		ecc_type = 3;
 
-	err.channel = find_umc_channel(m);
-
 	if (!(m->status & MCI_STATUS_SYNDV)) {
 		err.err_code = ERR_SYND;
 		goto log_error;
@@ -2940,7 +2982,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 			err.err_code = ERR_CHANNEL;
 	}
 
-	err.csrow = m->synd & 0x7;
+	pvt->ops->get_umc_err_info(m, &err);
 
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
@@ -3058,6 +3100,27 @@ static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
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
@@ -3067,6 +3130,8 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 	struct amd64_umc *umc;
 	u32 i, umc_base;
 
+	read_top_mem_registers(pvt);
+
 	/* Read registers from each UMC */
 	for_each_umc(i) {
 
@@ -3079,6 +3144,8 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
 		amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
 	}
+
+	amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
 }
 
 /*
@@ -3088,30 +3155,8 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 static void read_mc_regs(struct amd64_pvt *pvt)
 {
 	unsigned int range;
-	u64 msr_val;
-
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
 
-	if (pvt->umc) {
-		__read_mc_regs_df(pvt);
-		amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
-
-		goto skip;
-	}
+	read_top_mem_registers(pvt);
 
 	amd64_read_pci_cfg(pvt->F3, NBCAP, &pvt->nbcap);
 
@@ -3152,14 +3197,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 		amd64_read_dct_pci_cfg(pvt, 1, DCLR0, &pvt->dclr1);
 		amd64_read_dct_pci_cfg(pvt, 1, DCHR0, &pvt->dchr1);
 	}
-
-skip:
-	read_dct_base_mask(pvt);
-
-	determine_memory_type(pvt);
-	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
-
-	determine_ecc_sym_sz(pvt);
 }
 
 /*
@@ -3277,9 +3314,6 @@ static int init_csrows(struct mem_ctl_info *mci)
 	int nr_pages = 0;
 	u32 val;
 
-	if (pvt->umc)
-		return init_csrows_df(mci);
-
 	amd64_read_pci_cfg(pvt->F3, NBCFG, &val);
 
 	pvt->nbcfg = val;
@@ -3703,6 +3737,21 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		return NULL;
 	}
 
+	/* ops required for all the families */
+	if (!pvt->ops->early_channel_count || !pvt->ops->dbam_to_cs ||
+	    !pvt->ops->prep_chip_select || !pvt->ops->get_base_mask ||
+	    !pvt->ops->get_misc_regs || !pvt->ops->get_mc_regs ||
+	    !pvt->ops->populate_csrows) {
+		edac_dbg(1, "Common helper routines not defined.\n");
+		return NULL;
+	}
+
+	/* ops required for families 17h and later */
+	if (pvt->fam >= 0x17 && !pvt->ops->get_umc_err_info) {
+		edac_dbg(1, "Platform specific helper routines not defined.\n");
+		return NULL;
+	}
+
 	return fam_type;
 }
 
@@ -3735,7 +3784,16 @@ static int hw_info_get(struct amd64_pvt *pvt)
 	if (ret)
 		return ret;
 
-	read_mc_regs(pvt);
+	pvt->ops->get_mc_regs(pvt);
+
+	pvt->ops->prep_chip_select(pvt);
+
+	pvt->ops->get_base_mask(pvt);
+
+	determine_memory_type(pvt);
+	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
+
+	determine_ecc_sym_sz(pvt);
 
 	return 0;
 }
@@ -3786,7 +3844,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 
 	setup_mci_misc_attrs(mci);
 
-	if (init_csrows(mci))
+	if (pvt->ops->populate_csrows(mci))
 		mci->edac_cap = EDAC_FLAG_NONE;
 
 	ret = -ENODEV;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 85aa820bc165..881ff6322bc9 100644
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
+	void (*get_misc_regs)		(struct amd64_pvt *pvt);
+	void (*get_mc_regs)		(struct amd64_pvt *pvt);
+	int  (*populate_csrows)		(struct mem_ctl_info *mci);
+	void (*get_umc_err_info)	(struct mce *m, struct err_info *err);
 };
 
 struct amd64_family_type {
-- 
2.25.1

