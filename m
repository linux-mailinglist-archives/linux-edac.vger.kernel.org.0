Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA1E4A8AB8
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 18:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353141AbiBCRug (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 12:50:36 -0500
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:11873
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353111AbiBCRuc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I58p0OGsu7SJgiSDq6lw9XpFSOZKUDpmjifiKuK9IeOry0G8M+/p37+jeZCeGjHF072+dE5ePbHG34qwJWS+du+6kYGvWHuB3hUfDX9srYLCDee74KfEcFlCuk+gsFFKEtkEtC6gUo6weUdceju+FAXEvInT9SFTvG3eoe3z8t/Q8fh9RoXDsgJB7/9UD8mdDVjjz0+/OK7vd1oUmTxh9a268aOMza2eIUjx8Ty7LOBNhw3O38OGsi1De93HkL5MJUHellqdC3NdrLIeV6GkmwUBsLbRaaFumSCx2QHfLkT8PfXpvdWQVUImFj+AWrBv/mXg02O85zDLm+hyjCp79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHnfsBmE4N6OLz+pgjV7A7BZmQF1PrIQYQWIQZoL2iU=;
 b=Zl1Rwh88oVzfQAHhobAO6a98YzMw3FtC6TWLTc6JDdQnfLtrtWKRGTpaTePaoE401km0BCPxoD0PmBjXsdwRr9pShJZQx+yTdfcg1XAm/7GA2pW3u8ulZzxVWEhyLa2pNubD4dS58Dnu5UJ5633LkEDdbsmy+jIAJ6K6DKIynufanwCZf+Cd4F3aa9tR6J/tso3agvOpfVYVMpY/0A9aGiypRBnLAgOyXw7uyi2qs9PZHa0egXSx/saPs82oHIQpJs9+n7f5nzJ/QunaFfantnFdchXS/V4xu12L7KLdWvthvVXJkUClOOJNSIOqtg3tsSLsNkSi5QUTfdU0TXSmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHnfsBmE4N6OLz+pgjV7A7BZmQF1PrIQYQWIQZoL2iU=;
 b=UhVs4Yw0d7oSbIPAqqAaN7MLulU8k6gbqVKdC6niqe1IG4mtZ3zgU+1WPcFiz9osbHaFwoNHxvm9IqBXSvj+rHmo8xV+Jl67k83FBspstavsQdIpd7lMk4JVZSSz52q3HX1pODMk9xbuyhvuRt3rm0gAvTELWgp5KYlm6vBhDX4=
Received: from MW4PR04CA0311.namprd04.prod.outlook.com (2603:10b6:303:82::16)
 by DM5PR12MB1756.namprd12.prod.outlook.com (2603:10b6:3:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 17:50:29 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::d8) by MW4PR04CA0311.outlook.office365.com
 (2603:10b6:303:82::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Thu, 3 Feb 2022 17:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:50:28 +0000
Received: from node-bp128-r03d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 11:50:24 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH v7 04/12] EDAC/amd64: Move struct fam_type variables into amd64_pvt structure
Date:   Thu, 3 Feb 2022 11:49:34 -0600
Message-ID: <20220203174942.31630-5-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6b84956f-cc56-41de-99d8-08d9e73daaa1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1756:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1756A44AABE32A31A84CF3BEE8289@DM5PR12MB1756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HckCeAxpttPxg+y2RharpEll+EXU9TaNpTB43inC+66M3lim59BqBun/dUC9KuIepJ705lu7QKrP1uqRGdF+oDDj2KUdja+glmH68E/XOYjxlmye9k75Q/jqNxrI6e+7Ts8DWjWHiOGMA2/TcZ/1dM42unf00nE86Yxd0m3H+O+lp2PrRzUqbrl/VQhUizmkpPZLkw/RI89rhkphSE6qReSI7MZFRrUMEXKK8ARAcQMIDAlyO4VzEKpeubaBKf48Oex0aot2FvSLJ48ngbKP9MF/cUNtvsvjsVJ9xeBdprcWH189Qisnmb8dyVMzJgKfdgbSgKoUIJjc/E4vKgb+eOuVGVsIJS0Ux7Zj80w+DVf6LMIR3SoLZhjoo1AYnjy6QpxNq4mQOMjCIgLRNZvRCiDaHS7LXm55KcjFfXTiTwlNW3V7TFM3xdBYFmaaHqfqhGzOUOKFmu0DyZrRswB1BLJ75W9bPal9ujbwaroWwH70b+jRhuAw+tLzm4r7CcjF3de+C9UKAJkjOIP8mNEWfqxccIME+qw9IQV1kPqp/mUwlUkrOviPp6EaaJgFTmwZaweApIf5BtXRCHyhqnImZQGwmS/dtUuE5Iub8+XJ4c6SxVVT6E5deLOx/1zEier4+oLVKNM5mvYCn4zH99oHFg6+eilL6r8R6ijK0ByeS1UfVA5PmPHXuOywf62HaIcMjDKq7EXgFtq2BPcYK/IusR0iazfFM/Xs3IXyaAjxBQa5h2SpHkXt4aTxqmnptmq6H3yhhAgWwpjadwD/z16FyVvRoYiGdnzLFL7NJgIqT7313wpuOE7JYDCXDoQKodXSY4MGCWso7uWB/3HM2OjP7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(83380400001)(26005)(1076003)(186003)(16526019)(2616005)(426003)(47076005)(36756003)(36860700001)(316002)(2906002)(30864003)(5660300002)(8936002)(4326008)(8676002)(40460700003)(82310400004)(70586007)(70206006)(508600001)(81166007)(54906003)(6666004)(7696005)(966005)(110136005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:50:28.9499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b84956f-cc56-41de-99d8-08d9e73daaa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1756
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

On heterogeneous systems, the GPU nodes are probed after the CPU
nodes and will overwrites the family type set by CPU nodes.

Removed struct fam_type and made all family-specific assignments
dynamic and get rid of static definitions of family_types and ops,
This would simplify adding support for future platforms.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
---
Link:
https://lkml.kernel.org/r/20211028130106.15701-5-nchatrad@amd.com

v6->v7:
* rebased on top of\
  https://lore.kernel.org/all/20220202144307.2678405-1-yazen.ghannam@amd.com/

v4->v5:
* Added reviewed by Yazen

v1->v4:
* New change in v4


 drivers/edac/amd64_edac.c | 384 +++++++++++++-------------------------
 drivers/edac/amd64_edac.h |  64 +++----
 2 files changed, 153 insertions(+), 295 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 782e286d5390..4cac43840ccc 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -13,11 +13,9 @@ module_param(ecc_enable_override, int, 0644);
 
 static struct msr __percpu *msrs;
 
-static struct amd64_family_type *fam_type;
-
-static inline u32 get_umc_reg(u32 reg)
+static inline u32 get_umc_reg(u32 reg, struct amd64_pvt *pvt)
 {
-	if (!fam_type->flags.zn_regs_v2)
+	if (!pvt->flags.zn_regs_v2)
 		return reg;
 
 	switch (reg) {
@@ -463,7 +461,7 @@ static void get_cs_base_and_mask(struct amd64_pvt *pvt, int csrow, u8 dct,
 	for (i = 0; i < pvt->csels[dct].m_cnt; i++)
 
 #define for_each_umc(i) \
-	for (i = 0; i < fam_type->max_mcs; i++)
+	for (i = 0; i < pvt->max_mcs; i++)
 
 /*
  * @input_addr is an InputAddr associated with the node given by mci. Return the
@@ -1859,7 +1857,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 
 		if (umc->dram_type == MEM_LRDDR4 || umc->dram_type == MEM_LRDDR5) {
 			amd_smn_read(pvt->mc_node_id,
-				     umc_base + get_umc_reg(UMCCH_ADDR_CFG),
+				     umc_base + get_umc_reg(UMCCH_ADDR_CFG, pvt),
 				     &tmp);
 			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
 					i, 1 << ((tmp >> 4) & 0x3));
@@ -1935,7 +1933,7 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 
 		for_each_umc(umc) {
 			pvt->csels[umc].b_cnt = 4;
-			pvt->csels[umc].m_cnt = fam_type->flags.zn_regs_v2 ? 4 : 2;
+			pvt->csels[umc].m_cnt = pvt->flags.zn_regs_v2 ? 4 : 2;
 		}
 
 	} else {
@@ -1975,7 +1973,7 @@ static void read_umc_base_mask(struct amd64_pvt *pvt)
 		}
 
 		umc_mask_reg = get_umc_base(umc) + UMCCH_ADDR_MASK;
-		umc_mask_reg_sec = get_umc_base(umc) + get_umc_reg(UMCCH_ADDR_MASK_SEC);
+		umc_mask_reg_sec = get_umc_base(umc) + get_umc_reg(UMCCH_ADDR_MASK_SEC, pvt);
 
 		for_each_chip_select_mask(cs, umc, pvt) {
 			mask = &pvt->csels[umc].csmasks[cs];
@@ -2046,7 +2044,7 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 	}
 }
 
-static void _determine_memory_type_df(struct amd64_umc *umc)
+static void _determine_memory_type_df(struct amd64_pvt *pvt, struct amd64_umc *umc)
 {
 	if (!(umc->sdp_ctrl & UMC_SDP_INIT)) {
 		umc->dram_type = MEM_EMPTY;
@@ -2057,7 +2055,7 @@ static void _determine_memory_type_df(struct amd64_umc *umc)
 	 * Check if the system supports the "DDR Type" field in UMC Config
 	 * and has DDR5 DIMMs in use.
 	 */
-	if (fam_type->flags.zn_regs_v2 && ((umc->umc_cfg & GENMASK(2, 0)) == 0x1)) {
+	if (pvt->flags.zn_regs_v2 && ((umc->umc_cfg & GENMASK(2, 0)) == 0x1)) {
 		if (umc->dimm_cfg & BIT(5))
 			umc->dram_type = MEM_LRDDR5;
 		else if (umc->dimm_cfg & BIT(4))
@@ -2082,7 +2080,7 @@ static void determine_memory_type_df(struct amd64_pvt *pvt)
 	for_each_umc(i) {
 		umc = &pvt->umc[i];
 
-		_determine_memory_type_df(umc);
+		_determine_memory_type_df(pvt, umc);
 		edac_dbg(1, "  UMC%d DIMM type: %s\n", i, edac_mem_types[umc->dram_type]);
 	}
 }
@@ -2648,7 +2646,7 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	 */
 	dimm = csrow_nr >> 1;
 
-	if (!fam_type->flags.zn_regs_v2)
+	if (!pvt->flags.zn_regs_v2)
 		cs_mask_nr >>= 1;
 
 	/* Asymmetric dual-rank DIMM support. */
@@ -3268,167 +3266,6 @@ static void debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 	}
 }
 
-static struct amd64_family_type family_types[] = {
-	[K8_CPUS] = {
-		.ctl_name = "K8",
-		.f1_id = PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP,
-		.f2_id = PCI_DEVICE_ID_AMD_K8_NB_MEMCTL,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= k8_early_channel_count,
-			.map_sysaddr_to_csrow	= k8_map_sysaddr_to_csrow,
-			.dbam_to_cs		= k8_dbam_to_chip_select,
-		}
-	},
-	[F10_CPUS] = {
-		.ctl_name = "F10h",
-		.f1_id = PCI_DEVICE_ID_AMD_10H_NB_MAP,
-		.f2_id = PCI_DEVICE_ID_AMD_10H_NB_DRAM,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f10_dbam_to_chip_select,
-		}
-	},
-	[F15_CPUS] = {
-		.ctl_name = "F15h",
-		.f1_id = PCI_DEVICE_ID_AMD_15H_NB_F1,
-		.f2_id = PCI_DEVICE_ID_AMD_15H_NB_F2,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f15_dbam_to_chip_select,
-		}
-	},
-	[F15_M30H_CPUS] = {
-		.ctl_name = "F15h_M30h",
-		.f1_id = PCI_DEVICE_ID_AMD_15H_M30H_NB_F1,
-		.f2_id = PCI_DEVICE_ID_AMD_15H_M30H_NB_F2,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f16_dbam_to_chip_select,
-		}
-	},
-	[F15_M60H_CPUS] = {
-		.ctl_name = "F15h_M60h",
-		.f1_id = PCI_DEVICE_ID_AMD_15H_M60H_NB_F1,
-		.f2_id = PCI_DEVICE_ID_AMD_15H_M60H_NB_F2,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f15_m60h_dbam_to_chip_select,
-		}
-	},
-	[F16_CPUS] = {
-		.ctl_name = "F16h",
-		.f1_id = PCI_DEVICE_ID_AMD_16H_NB_F1,
-		.f2_id = PCI_DEVICE_ID_AMD_16H_NB_F2,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f16_dbam_to_chip_select,
-		}
-	},
-	[F16_M30H_CPUS] = {
-		.ctl_name = "F16h_M30h",
-		.f1_id = PCI_DEVICE_ID_AMD_16H_M30H_NB_F1,
-		.f2_id = PCI_DEVICE_ID_AMD_16H_M30H_NB_F2,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f16_dbam_to_chip_select,
-		}
-	},
-	[F17_CPUS] = {
-		.ctl_name = "F17h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_DF_F6,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F17_M10H_CPUS] = {
-		.ctl_name = "F17h_M10h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F17_M30H_CPUS] = {
-		.ctl_name = "F17h_M30h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
-		.max_mcs = 8,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F17_M60H_CPUS] = {
-		.ctl_name = "F17h_M60h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F6,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F17_M70H_CPUS] = {
-		.ctl_name = "F17h_M70h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F19_CPUS] = {
-		.ctl_name = "F19h",
-		.f0_id = PCI_DEVICE_ID_AMD_19H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_19H_DF_F6,
-		.max_mcs = 8,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F19_M10H_CPUS] = {
-		.ctl_name = "F19h_M10h",
-		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F6,
-		.max_mcs = 12,
-		.flags.zn_regs_v2 = 1,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F19_M50H_CPUS] = {
-		.ctl_name = "F19h_M50h",
-		.f0_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F6,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-};
-
 /*
  * These are tables of eigenvectors (one per line) which can be used for the
  * construction of the syndrome tables. The modified syndrome search algorithm
@@ -3850,7 +3687,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + get_umc_reg(UMCCH_DIMM_CFG), &umc->dimm_cfg);
+		amd_smn_read(nid, umc_base + get_umc_reg(UMCCH_DIMM_CFG, pvt), &umc->dimm_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
 		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
@@ -4380,7 +4217,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 
 	mci->edac_cap		= determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
-	mci->ctl_name		= fam_type->ctl_name;
+	mci->ctl_name		= pvt->ctl_name;
 	mci->dev_name		= pci_name(pvt->F3);
 	mci->ctl_page_to_phys	= NULL;
 
@@ -4392,7 +4229,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 /*
  * returns a pointer to the family descriptor on success, NULL otherwise.
  */
-static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
+static void per_family_init(struct amd64_pvt *pvt)
 {
 	pvt->ext_model  = boot_cpu_data.x86_model >> 4;
 	pvt->stepping	= boot_cpu_data.x86_stepping;
@@ -4401,109 +4238,150 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 
 	switch (pvt->fam) {
 	case 0xf:
-		fam_type	= &family_types[K8_CPUS];
-		pvt->ops	= &family_types[K8_CPUS].ops;
+		pvt->ctl_name				= "K8";
+		pvt->f1_id				= PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP;
+		pvt->f2_id				= PCI_DEVICE_ID_AMD_K8_NB_MEMCTL;
+		pvt->max_mcs				= 2;
+		pvt->ops->early_channel_count		= k8_early_channel_count;
+		pvt->ops->map_sysaddr_to_csrow		= k8_map_sysaddr_to_csrow;
+		pvt->ops->dbam_to_cs			= k8_dbam_to_chip_select;
 		break;
 
 	case 0x10:
-		fam_type	= &family_types[F10_CPUS];
-		pvt->ops	= &family_types[F10_CPUS].ops;
+		pvt->ctl_name				= "F10h";
+		pvt->f1_id				= PCI_DEVICE_ID_AMD_10H_NB_MAP;
+		pvt->f2_id				= PCI_DEVICE_ID_AMD_10H_NB_DRAM;
+		pvt->max_mcs				= 2;
+		pvt->ops->early_channel_count		= f1x_early_channel_count;
+		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
+		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
 		break;
 
 	case 0x15:
 		if (pvt->model == 0x30) {
-			fam_type = &family_types[F15_M30H_CPUS];
-			pvt->ops = &family_types[F15_M30H_CPUS].ops;
-			break;
+			pvt->ctl_name			= "F15h_M30h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F2;
+			pvt->ops->dbam_to_cs		= f16_dbam_to_chip_select;
 		} else if (pvt->model == 0x60) {
-			fam_type = &family_types[F15_M60H_CPUS];
-			pvt->ops = &family_types[F15_M60H_CPUS].ops;
-			break;
-		/* Richland is only client */
+			pvt->ctl_name			= "F15h_M60h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F2;
+			pvt->ops->dbam_to_cs		= f15_m60h_dbam_to_chip_select;
 		} else if (pvt->model == 0x13) {
-			return NULL;
+		/* Richland is only client */
+			return;
 		} else {
-			fam_type	= &family_types[F15_CPUS];
-			pvt->ops	= &family_types[F15_CPUS].ops;
+			pvt->ctl_name			= "F15h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_NB_F2;
+			pvt->ops->dbam_to_cs		= f15_dbam_to_chip_select;
 		}
+		pvt->max_mcs				= 2;
+		pvt->ops->early_channel_count		= f1x_early_channel_count;
+		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
 		break;
 
 	case 0x16:
 		if (pvt->model == 0x30) {
-			fam_type = &family_types[F16_M30H_CPUS];
-			pvt->ops = &family_types[F16_M30H_CPUS].ops;
-			break;
+			pvt->ctl_name			= "F16h_M30h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_16H_M30H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_16H_M30H_NB_F2;
+		} else {
+			pvt->ctl_name			= "F16h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_16H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_16H_NB_F2;
 		}
-		fam_type	= &family_types[F16_CPUS];
-		pvt->ops	= &family_types[F16_CPUS].ops;
+		pvt->max_mcs				= 2;
+		pvt->ops->early_channel_count		= f1x_early_channel_count;
+		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
+		pvt->ops->dbam_to_cs			= f16_dbam_to_chip_select;
 		break;
 
 	case 0x17:
 		if (pvt->model >= 0x10 && pvt->model <= 0x2f) {
-			fam_type = &family_types[F17_M10H_CPUS];
-			pvt->ops = &family_types[F17_M10H_CPUS].ops;
-			df_ops	 = &df2_ops;
-			break;
+			pvt->ctl_name			= "F17h_M10h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M10H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M10H_DF_F6;
+			pvt->max_mcs			= 2;
+			df_ops				= &df2_ops;
 		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
-			fam_type = &family_types[F17_M30H_CPUS];
-			pvt->ops = &family_types[F17_M30H_CPUS].ops;
-			df_ops	 = &df3_ops;
-			break;
+			pvt->ctl_name			= "F17h_M30h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M30H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M30H_DF_F6;
+			pvt->max_mcs			= 8;
+			df_ops				= &df3_ops;
 		} else if (pvt->model >= 0x60 && pvt->model <= 0x6f) {
-			fam_type = &family_types[F17_M60H_CPUS];
-			pvt->ops = &family_types[F17_M60H_CPUS].ops;
-			df_ops	 = &df3_ops;
-			break;
+			pvt->ctl_name			= "F17h_M60h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M60H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M60H_DF_F6;
+			pvt->max_mcs			= 2;
+			df_ops				= &df3_ops;
 		} else if (pvt->model >= 0x70 && pvt->model <= 0x7f) {
-			fam_type = &family_types[F17_M70H_CPUS];
-			pvt->ops = &family_types[F17_M70H_CPUS].ops;
-			df_ops	 = &df3_ops;
-			break;
+			pvt->ctl_name			= "F17h_M70h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M70H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M70H_DF_F6;
+			pvt->max_mcs			= 2;
+			df_ops				= &df3_ops;
+		} else {
+			pvt->ctl_name			= "F17h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_DF_F6;
+			pvt->max_mcs			= 2;
+			df_ops				= &df2_ops;
 		}
 		fallthrough;
 	case 0x18:
-		fam_type	= &family_types[F17_CPUS];
-		pvt->ops	= &family_types[F17_CPUS].ops;
-		df_ops		= &df2_ops;
-
-		if (pvt->fam == 0x18)
-			family_types[F17_CPUS].ctl_name = "F18h";
+		pvt->ops->early_channel_count		= f17_early_channel_count;
+		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
+
+		if (pvt->fam == 0x18) {
+			pvt->ctl_name			= "F18h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_DF_F6;
+			pvt->max_mcs			= 2;
+			df_ops				= &df2_ops;
+		}
 		break;
 
 	case 0x19:
 		if (pvt->model >= 0x10 && pvt->model <= 0x1f) {
-			fam_type = &family_types[F19_M10H_CPUS];
-			pvt->ops = &family_types[F19_M10H_CPUS].ops;
-			break;
+			pvt->ctl_name			= "F19h_M10h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F6;
+			pvt->max_mcs			= 12;
+			pvt->flags.zn_regs_v2		= 1;
 		} else if (pvt->model >= 0x20 && pvt->model <= 0x2f) {
-			fam_type = &family_types[F17_M70H_CPUS];
-			pvt->ops = &family_types[F17_M70H_CPUS].ops;
-			fam_type->ctl_name = "F19h_M20h";
-			df_ops	 = &df3_ops;
-			break;
+			pvt->ctl_name			= "F19h_M20h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M70H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M70H_DF_F6;
+			pvt->max_mcs			= 2;
+			df_ops				= &df3_ops;
 		} else if (pvt->model >= 0x50 && pvt->model <= 0x5f) {
-			fam_type = &family_types[F19_M50H_CPUS];
-			pvt->ops = &family_types[F19_M50H_CPUS].ops;
-			fam_type->ctl_name = "F19h_M50h";
-			break;
+			pvt->ctl_name			= "F19h_M50h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_M50H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_19H_M50H_DF_F6;
+			pvt->max_mcs			= 2;
 		} else if (pvt->model >= 0xa0 && pvt->model <= 0xaf) {
-			fam_type = &family_types[F19_M10H_CPUS];
-			pvt->ops = &family_types[F19_M10H_CPUS].ops;
-			fam_type->ctl_name = "F19h_MA0h";
-			break;
+			pvt->ctl_name			= "F19h_M10h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F6;
+			pvt->max_mcs			= 2;
+		} else {
+			pvt->ctl_name			= "F19h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_19H_DF_F6;
+			pvt->max_mcs			= 8;
+			df_ops				= &df3_ops;
 		}
-		fam_type	= &family_types[F19_CPUS];
-		pvt->ops	= &family_types[F19_CPUS].ops;
-		family_types[F19_CPUS].ctl_name = "F19h";
-		df_ops		= &df3_ops;
+		pvt->ops->early_channel_count		= f17_early_channel_count;
+		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
 		break;
 
 	default:
 		amd64_err("Unsupported family!\n");
-		return NULL;
+		return;
 	}
-
-	return fam_type;
 }
 
 static const struct attribute_group *amd64_edac_attr_groups[] = {
@@ -4520,15 +4398,15 @@ static int hw_info_get(struct amd64_pvt *pvt)
 	int ret;
 
 	if (pvt->fam >= 0x17) {
-		pvt->umc = kcalloc(fam_type->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
+		pvt->umc = kcalloc(pvt->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
 		if (!pvt->umc)
 			return -ENOMEM;
 
-		pci_id1 = fam_type->f0_id;
-		pci_id2 = fam_type->f6_id;
+		pci_id1 = pvt->f0_id;
+		pci_id2 = pvt->f6_id;
 	} else {
-		pci_id1 = fam_type->f1_id;
-		pci_id2 = fam_type->f2_id;
+		pci_id1 = pvt->f1_id;
+		pci_id2 = pvt->f2_id;
 	}
 
 	ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
@@ -4574,7 +4452,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	 * only one channel. Also, this simplifies handling later for the price
 	 * of a couple of KBs tops.
 	 */
-	layers[1].size = fam_type->max_mcs;
+	layers[1].size = pvt->max_mcs;
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
@@ -4604,7 +4482,7 @@ static bool instance_has_memory(struct amd64_pvt *pvt)
 	bool cs_enabled = false;
 	int cs = 0, dct = 0;
 
-	for (dct = 0; dct < fam_type->max_mcs; dct++) {
+	for (dct = 0; dct < pvt->max_mcs; dct++) {
 		for_each_chip_select(cs, dct, pvt)
 			cs_enabled |= csrow_enabled(cs, dct, pvt);
 	}
@@ -4633,10 +4511,12 @@ static int probe_one_instance(unsigned int nid)
 	pvt->mc_node_id	= nid;
 	pvt->F3 = F3;
 
+	pvt->ops = kzalloc(sizeof(*pvt->ops), GFP_KERNEL);
+	if (!pvt->ops)
+		goto err_out;
+
 	ret = -ENODEV;
-	fam_type = per_family_init(pvt);
-	if (!fam_type)
-		goto err_enable;
+	per_family_init(pvt);
 
 	ret = hw_info_get(pvt);
 	if (ret < 0)
@@ -4674,8 +4554,8 @@ static int probe_one_instance(unsigned int nid)
 		goto err_enable;
 	}
 
-	amd64_info("%s %sdetected (node %d).\n", fam_type->ctl_name,
-		     (pvt->fam == 0xf ?
+	amd64_info("%s %sdetected (node %d).\n", pvt->ctl_name,
+		   (pvt->fam == 0xf ?
 				(pvt->ext_model >= K8_REV_F  ? "revF or later "
 							     : "revE or earlier ")
 				 : ""), pvt->mc_node_id);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 6a112270a84b..4e3f9755bc73 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -291,25 +291,6 @@
 
 #define UMC_SDP_INIT			BIT(31)
 
-enum amd_families {
-	K8_CPUS = 0,
-	F10_CPUS,
-	F15_CPUS,
-	F15_M30H_CPUS,
-	F15_M60H_CPUS,
-	F16_CPUS,
-	F16_M30H_CPUS,
-	F17_CPUS,
-	F17_M10H_CPUS,
-	F17_M30H_CPUS,
-	F17_M60H_CPUS,
-	F17_M70H_CPUS,
-	F19_CPUS,
-	F19_M10H_CPUS,
-	F19_M50H_CPUS,
-	NUM_FAMILIES,
-};
-
 /* Error injection control structure */
 struct error_injection {
 	u32	 section;
@@ -352,6 +333,16 @@ struct amd64_umc {
 	enum mem_type dram_type;
 };
 
+struct amd64_family_flags {
+	/*
+	 * Indicates that the system supports the new register offsets, etc.
+	 * first introduced with Family 19h Model 10h.
+	 */
+	__u64 zn_regs_v2	: 1,
+
+	      __reserved	: 63;
+};
+
 struct amd64_pvt {
 	struct low_ops *ops;
 
@@ -394,6 +385,12 @@ struct amd64_pvt {
 	/* x4, x8, or x16 syndromes in use */
 	u8 ecc_sym_sz;
 
+	const char *ctl_name;
+	u16 f0_id, f1_id, f2_id, f6_id;
+	/* Maximum number of memory controllers per die/node. */
+	u8 max_mcs;
+
+	struct amd64_family_flags flags;
 	/* place to store error injection parameters prior to issue */
 	struct error_injection injection;
 
@@ -479,30 +476,11 @@ struct ecc_settings {
  * functions and per device encoding/decoding logic.
  */
 struct low_ops {
-	int (*early_channel_count)	(struct amd64_pvt *pvt);
-	void (*map_sysaddr_to_csrow)	(struct mem_ctl_info *mci, u64 sys_addr,
-					 struct err_info *);
-	int (*dbam_to_cs)		(struct amd64_pvt *pvt, u8 dct,
-					 unsigned cs_mode, int cs_mask_nr);
-};
-
-struct amd64_family_flags {
-	/*
-	 * Indicates that the system supports the new register offsets, etc.
-	 * first introduced with Family 19h Model 10h.
-	 */
-	__u64 zn_regs_v2	: 1,
-
-	      __reserved	: 63;
-};
-
-struct amd64_family_type {
-	const char *ctl_name;
-	u16 f0_id, f1_id, f2_id, f6_id;
-	/* Maximum number of memory controllers per die/node. */
-	u8 max_mcs;
-	struct amd64_family_flags flags;
-	struct low_ops ops;
+	int  (*early_channel_count)(struct amd64_pvt *pvt);
+	void (*map_sysaddr_to_csrow)(struct mem_ctl_info *mci, u64 sys_addr,
+				     struct err_info *err);
+	int  (*dbam_to_cs)(struct amd64_pvt *pvt, u8 dct,
+			   unsigned int cs_mode, int cs_mask_nr);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

