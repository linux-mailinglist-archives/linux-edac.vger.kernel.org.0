Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C75D67EC15
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjA0RGh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjA0RGN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:06:13 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C7286626;
        Fri, 27 Jan 2023 09:05:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tm1P2uq2RiFtnZPTIMPwDmffvcc9MlVDOuQuYMo0KSRgaXvYNgSgH2k2BnYNZoRrFOJtpQqDT5mnCbM+skP9knUwsB6ZwY8GMCnapHYhQVE9VQAAz0+JZxt6MGjBTUnXUY1ZeUd57zC9/yu8e7kOq8CRO/q+w5XbJ/dUnAXBQ7onhl8IN0HbI+jFx/HX586E4a/fTsb3LbZ7hl3OVz2vn/O/s4BgdwWj18tFhjOiAyMCwAmd3tmen1sDarhTrR3TSn1jzBwX30GcYdePGFrHgUdAPE3MUCPklaD869lM+fcrmPFTFq6mqUZVYKr9lyc/IF0WJ4qmDlNH2qDynPV7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mznSDyF/o/9gP2rhctBMKkk4XOn5d/N1x2XbuK7VV4s=;
 b=jzcgZfgqy69EtwFmra+qUMcnrtroMuCDs8pZAwFu21t3ACJE4igJ2oRYT9XmcRVQe3y9vxwWi8tQB8cGswhyqt/UWpb0yO8pJ83cthMoQhIr8yMo4p76DNalPY6kerXjIBZ925Ihj/axaLou+6lEqvigi6NRz5jvXRKcbedb08C6UXWgE9eZ+mkOwx6t7Vyx1Wy8WDQV7l34yQkPeT/m0Jgh5Y0iRfnBHq9mgyurVWthi+rZEQZsvhbgj9kLfxEdnIsM3wvMk/sTnAVklHTrmjjBVi8vxXE4fN8oL6koX0pJ+xKX2KYqPzvRHshilRNeGVhahJxYm460tvKnVhjsaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mznSDyF/o/9gP2rhctBMKkk4XOn5d/N1x2XbuK7VV4s=;
 b=a+cj8g2pbbj0l7wrOM25FvmxrG2r398ftyI3eKgNLny186STK0Lw9mt2cH4RqJLT0/yCMmr7/ZfSDxf+gJ7AhVmea9hG3lwCKbbpPu8MjZDhWlshrD04aNlVj+N/V085rMOrHRDognvSXSMJj3G6422qUSbltlS/1InSQMTBNNQ=
Received: from BN8PR04CA0037.namprd04.prod.outlook.com (2603:10b6:408:d4::11)
 by SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Fri, 27 Jan
 2023 17:04:36 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::e3) by BN8PR04CA0037.outlook.office365.com
 (2603:10b6:408:d4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:36 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:34 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 10/22] EDAC/amd64: Merge struct amd64_family_type into struct amd64_pvt
Date:   Fri, 27 Jan 2023 17:04:07 +0000
Message-ID: <20230127170419.1824692-11-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127170419.1824692-1-yazen.ghannam@amd.com>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|SA1PR12MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: c657c9c5-4c5e-40ed-da7c-08db00889192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYzB8wBT8aGZ1PU1UVw+/CiOPu8I25jyD+jGAcS9USjegNKfWx08/pwekaEUjJ9HZXeu3OpWxYNt4wzXwzZzpRwVJKAM9rxRxWcwQW811kGtpV2OeuBKrr0auGwq9uChUOfZ/R7NrSUeyJvwihrQtPBnZgjeFjrT84XrZarJZYVfJrO/q+fMvQapNZuqlbw6O0Mh0Zro/0F0zEijSvg7VBPG6IHEOvT/aAjzUr5S8AmdVbEq8A5CEBOCywp3hf6jvln3rNu2iCo49l+MfB/dUTv1r2w+SkaToYO7/J8cWWBM0lnN8dtqDtd6wSzJHRfo+jkH7TrBMw+xTLCh5eyH1dqP/H0N89nBTXnQ5O/P1a5H+O2kJ5BXXgAIVb/scsB4lrA2JtzwRQdj37AKI3urXujHRnc7uCaTRpVOmXS+3tipyOY1lP/OGkx/5iHJ14l5fL12yS+2yvmvph3CCKmfokvpR1aM9RUeMOqe7+DMvWUXAJm8mquY2XRRf6PXR315gIwT3YhieBiAH3XCYbPQ9+qOte4SPCdRaYsBLumacQ/Go5ojxavw1NDwTdfXlokr4ZRhPkUXEgkQiJvnZLxTFgzzQ7pKHd0FsgJAcDaTNrb/WQRo16jXj8LwGAfU9Kt6nc4i+/eBQBjDosHsGfm+pGcQc6Wf9ggkn31jH9VVvvLvjWKny0TVemwRW8g0Va7F2iqoghOazStC3Egh5VJqT5eUkCevhn+4lMl6YDyW/2PJ3Uc3UbwrqRfLYqsDpTzhkboUqkNqfah/S93Of/Ni3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199018)(40470700004)(36840700001)(46966006)(8936002)(426003)(2906002)(44832011)(336012)(356005)(54906003)(81166007)(86362001)(30864003)(82740400003)(40480700001)(41300700001)(966005)(110136005)(70586007)(4326008)(186003)(36860700001)(5660300002)(26005)(16526019)(7696005)(316002)(70206006)(1076003)(82310400005)(47076005)(2616005)(8676002)(478600001)(40460700003)(83380400001)(36756003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:36.0304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c657c9c5-4c5e-40ed-da7c-08db00889192
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Future AMD systems will support heterogeneous "AMD Node" types, e.g.
CPU+GPU. Therefore, a global "family type" shared across all "AMD Nodes"
is no longer appropriate.

Move struct low_ops routines and members of struct amd64_family_type
to struct amd64_pvt.

Currently, there are many code branches that split between "modern" and
"legacy" systems. Another code branch will be needed in order to cover
"GPU" cases. However, rather than introduce another branching case in
multiple functions, the current branching code should be switched to a
set of function pointers. This change makes the code more readable and
simplifies adding support for new families/models.

In order to reuse code, define two sets of function pointers. Use one
for modern systems (Family 17h and later). This will not change between
current CPU families. Use another set of function pointers for legacy
systems (before Family 17h). Use the Family 16h versions as default
for the legacy ops since these are the latest, and adjust the function
pointers as needed for older families.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-6-yazen.ghannam@amd.com

v1->v2:
* Same a v1 patch 5, but rebased on new patches.

 drivers/edac/amd64_edac.c | 308 ++++++++++++++------------------------
 drivers/edac/amd64_edac.h |  62 +++-----
 2 files changed, 133 insertions(+), 237 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1d5c2c97d563..a9b20bc413af 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -13,11 +13,9 @@ module_param(ecc_enable_override, int, 0644);
 
 static struct msr __percpu *msrs;
 
-static struct amd64_family_type *fam_type;
-
-static inline u32 get_umc_reg(u32 reg)
+static inline u32 get_umc_reg(struct amd64_pvt *pvt, u32 reg)
 {
-	if (!fam_type->flags.zn_regs_v2)
+	if (!pvt->flags.zn_regs_v2)
 		return reg;
 
 	switch (reg) {
@@ -437,7 +435,7 @@ static void get_cs_base_and_mask(struct amd64_pvt *pvt, int csrow, u8 dct,
 	for (i = 0; i < pvt->csels[dct].m_cnt; i++)
 
 #define for_each_umc(i) \
-	for (i = 0; i < fam_type->max_mcs; i++)
+	for (i = 0; i < pvt->max_mcs; i++)
 
 /*
  * @input_addr is an InputAddr associated with the node given by mci. Return the
@@ -1464,7 +1462,7 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	 */
 	dimm = csrow_nr >> 1;
 
-	if (!fam_type->flags.zn_regs_v2)
+	if (!pvt->flags.zn_regs_v2)
 		cs_mask_nr >>= 1;
 
 	/* Asymmetric dual-rank DIMM support. */
@@ -1556,7 +1554,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 
 		if (umc->dram_type == MEM_LRDDR4 || umc->dram_type == MEM_LRDDR5) {
 			amd_smn_read(pvt->mc_node_id,
-				     umc_base + get_umc_reg(UMCCH_ADDR_CFG),
+				     umc_base + get_umc_reg(pvt, UMCCH_ADDR_CFG),
 				     &tmp);
 			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
 					i, 1 << ((tmp >> 4) & 0x3));
@@ -1629,7 +1627,7 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 
 		for_each_umc(umc) {
 			pvt->csels[umc].b_cnt = 4;
-			pvt->csels[umc].m_cnt = fam_type->flags.zn_regs_v2 ? 4 : 2;
+			pvt->csels[umc].m_cnt = pvt->flags.zn_regs_v2 ? 4 : 2;
 		}
 
 	} else {
@@ -1669,7 +1667,7 @@ static void read_umc_base_mask(struct amd64_pvt *pvt)
 		}
 
 		umc_mask_reg = get_umc_base(umc) + UMCCH_ADDR_MASK;
-		umc_mask_reg_sec = get_umc_base(umc) + get_umc_reg(UMCCH_ADDR_MASK_SEC);
+		umc_mask_reg_sec = get_umc_base(umc) + get_umc_reg(pvt, UMCCH_ADDR_MASK_SEC);
 
 		for_each_chip_select_mask(cs, umc, pvt) {
 			mask = &pvt->csels[umc].csmasks[cs];
@@ -1757,7 +1755,7 @@ static void determine_memory_type_df(struct amd64_pvt *pvt)
 		 * Check if the system supports the "DDR Type" field in UMC Config
 		 * and has DDR5 DIMMs in use.
 		 */
-		if (fam_type->flags.zn_regs_v2 && ((umc->umc_cfg & GENMASK(2, 0)) == 0x1)) {
+		if (pvt->flags.zn_regs_v2 && ((umc->umc_cfg & GENMASK(2, 0)) == 0x1)) {
 			if (umc->dimm_cfg & BIT(5))
 				umc->dram_type = MEM_LRDDR5;
 			else if (umc->dimm_cfg & BIT(4))
@@ -2739,112 +2737,6 @@ static void f1x_map_sysaddr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr,
 		err->channel = get_channel_from_ecc_syndrome(mci, err->syndrome);
 }
 
-static struct amd64_family_type family_types[] = {
-	[K8_CPUS] = {
-		.ctl_name = "K8",
-		.f1_id = PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP,
-		.f2_id = PCI_DEVICE_ID_AMD_K8_NB_MEMCTL,
-		.max_mcs = 2,
-		.ops = {
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
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f16_dbam_to_chip_select,
-		}
-	},
-	[F17_CPUS] = {
-		.ctl_name = "F17h",
-		.max_mcs = 2,
-	},
-	[F17_M10H_CPUS] = {
-		.ctl_name = "F17h_M10h",
-		.max_mcs = 2,
-	},
-	[F17_M30H_CPUS] = {
-		.ctl_name = "F17h_M30h",
-		.max_mcs = 8,
-	},
-	[F17_M60H_CPUS] = {
-		.ctl_name = "F17h_M60h",
-		.max_mcs = 2,
-	},
-	[F17_M70H_CPUS] = {
-		.ctl_name = "F17h_M70h",
-		.max_mcs = 2,
-	},
-	[F19_CPUS] = {
-		.ctl_name = "F19h",
-		.max_mcs = 8,
-	},
-	[F19_M10H_CPUS] = {
-		.ctl_name = "F19h_M10h",
-		.max_mcs = 12,
-		.flags.zn_regs_v2 = 1,
-	},
-	[F19_M50H_CPUS] = {
-		.ctl_name = "F19h_M50h",
-		.max_mcs = 2,
-	},
-};
-
 /*
  * These are tables of eigenvectors (one per line) which can be used for the
  * construction of the syndrome tables. The modified syndrome search algorithm
@@ -3226,7 +3118,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + get_umc_reg(UMCCH_DIMM_CFG), &umc->dimm_cfg);
+		amd_smn_read(nid, umc_base + get_umc_reg(pvt, UMCCH_DIMM_CFG), &umc->dimm_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
 		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
@@ -3495,7 +3387,7 @@ static int init_csrows(struct mem_ctl_info *mci)
 					: EDAC_SECDED;
 		}
 
-		for (j = 0; j < fam_type->max_mcs; j++) {
+		for (j = 0; j < pvt->max_mcs; j++) {
 			dimm = csrow->channels[j]->dimm;
 			dimm->mtype = pvt->dram_type;
 			dimm->edac_mode = edac_mode;
@@ -3767,7 +3659,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 
 	mci->edac_cap		= determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
-	mci->ctl_name		= fam_type->ctl_name;
+	mci->ctl_name		= pvt->ctl_name;
 	mci->dev_name		= pci_name(pvt->F3);
 	mci->ctl_page_to_phys	= NULL;
 
@@ -3779,114 +3671,145 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 	mci->get_sdram_scrub_rate = get_scrub_rate;
 }
 
-/*
- * returns a pointer to the family descriptor on success, NULL otherwise.
- */
-static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
+static struct low_ops umc_ops = {
+};
+
+/* Use Family 16h versions for defaults and adjust as needed below. */
+static struct low_ops dct_ops = {
+	.map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs			= f16_dbam_to_chip_select,
+};
+
+static int per_family_init(struct amd64_pvt *pvt)
 {
 	pvt->ext_model  = boot_cpu_data.x86_model >> 4;
 	pvt->stepping	= boot_cpu_data.x86_stepping;
 	pvt->model	= boot_cpu_data.x86_model;
 	pvt->fam	= boot_cpu_data.x86;
+	pvt->max_mcs	= 2;
+
+	/*
+	 * Decide on which ops group to use here and do any family/model
+	 * overrides below.
+	 */
+	if (pvt->fam >= 0x17)
+		pvt->ops = &umc_ops;
+	else
+		pvt->ops = &dct_ops;
 
 	switch (pvt->fam) {
 	case 0xf:
-		fam_type	= &family_types[K8_CPUS];
-		pvt->ops	= &family_types[K8_CPUS].ops;
+		pvt->ctl_name				= (pvt->ext_model > K8_REV_F) ?
+							  "K8 revF or later" : "K8 revE or earlier";
+		pvt->f1_id				= PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP;
+		pvt->f2_id				= PCI_DEVICE_ID_AMD_K8_NB_MEMCTL;
+		pvt->ops->map_sysaddr_to_csrow		= k8_map_sysaddr_to_csrow;
+		pvt->ops->dbam_to_cs			= k8_dbam_to_chip_select;
 		break;
 
 	case 0x10:
-		fam_type	= &family_types[F10_CPUS];
-		pvt->ops	= &family_types[F10_CPUS].ops;
+		pvt->ctl_name				= "F10h";
+		pvt->f1_id				= PCI_DEVICE_ID_AMD_10H_NB_MAP;
+		pvt->f2_id				= PCI_DEVICE_ID_AMD_10H_NB_DRAM;
+		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
 		break;
 
 	case 0x15:
-		if (pvt->model == 0x30) {
-			fam_type = &family_types[F15_M30H_CPUS];
-			pvt->ops = &family_types[F15_M30H_CPUS].ops;
+		switch (pvt->model) {
+		case 0x30:
+			pvt->ctl_name			= "F15h_M30h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F2;
 			break;
-		} else if (pvt->model == 0x60) {
-			fam_type = &family_types[F15_M60H_CPUS];
-			pvt->ops = &family_types[F15_M60H_CPUS].ops;
+		case 0x60:
+			pvt->ctl_name			= "F15h_M60h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F2;
+			pvt->ops->dbam_to_cs		= f15_m60h_dbam_to_chip_select;
+			break;
+		case 0x13:
+			/* Richland is only client */
+			return -ENODEV;
+		default:
+			pvt->ctl_name			= "F15h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_NB_F2;
+			pvt->ops->dbam_to_cs		= f15_dbam_to_chip_select;
 			break;
-		/* Richland is only client */
-		} else if (pvt->model == 0x13) {
-			return NULL;
-		} else {
-			fam_type	= &family_types[F15_CPUS];
-			pvt->ops	= &family_types[F15_CPUS].ops;
 		}
 		break;
 
 	case 0x16:
-		if (pvt->model == 0x30) {
-			fam_type = &family_types[F16_M30H_CPUS];
-			pvt->ops = &family_types[F16_M30H_CPUS].ops;
+		switch (pvt->model) {
+		case 0x30:
+			pvt->ctl_name			= "F16h_M30h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_16H_M30H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_16H_M30H_NB_F2;
+			break;
+		default:
+			pvt->ctl_name			= "F16h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_16H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_16H_NB_F2;
 			break;
 		}
-		fam_type	= &family_types[F16_CPUS];
-		pvt->ops	= &family_types[F16_CPUS].ops;
 		break;
 
 	case 0x17:
-		if (pvt->model >= 0x10 && pvt->model <= 0x2f) {
-			fam_type = &family_types[F17_M10H_CPUS];
-			pvt->ops = &family_types[F17_M10H_CPUS].ops;
+		switch (pvt->model) {
+		case 0x10 ... 0x2f:
+			pvt->ctl_name			= "F17h_M10h";
 			break;
-		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
-			fam_type = &family_types[F17_M30H_CPUS];
-			pvt->ops = &family_types[F17_M30H_CPUS].ops;
+		case 0x30 ... 0x3f:
+			pvt->ctl_name			= "F17h_M30h";
+			pvt->max_mcs			= 8;
 			break;
-		} else if (pvt->model >= 0x60 && pvt->model <= 0x6f) {
-			fam_type = &family_types[F17_M60H_CPUS];
-			pvt->ops = &family_types[F17_M60H_CPUS].ops;
+		case 0x60 ... 0x6f:
+			pvt->ctl_name			= "F17h_M60h";
 			break;
-		} else if (pvt->model >= 0x70 && pvt->model <= 0x7f) {
-			fam_type = &family_types[F17_M70H_CPUS];
-			pvt->ops = &family_types[F17_M70H_CPUS].ops;
+		case 0x70 ... 0x7f:
+			pvt->ctl_name			= "F17h_M70h";
+			break;
+		default:
+			pvt->ctl_name			= "F17h";
 			break;
 		}
-		fallthrough;
-	case 0x18:
-		fam_type	= &family_types[F17_CPUS];
-		pvt->ops	= &family_types[F17_CPUS].ops;
+		break;
 
-		if (pvt->fam == 0x18)
-			family_types[F17_CPUS].ctl_name = "F18h";
+	case 0x18:
+		pvt->ctl_name				= "F18h";
 		break;
 
 	case 0x19:
-		if (pvt->model >= 0x10 && pvt->model <= 0x1f) {
-			fam_type = &family_types[F19_M10H_CPUS];
-			pvt->ops = &family_types[F19_M10H_CPUS].ops;
+		switch (pvt->model) {
+		case 0x00 ... 0x0f:
+			pvt->ctl_name			= "F19h";
+			pvt->max_mcs			= 8;
 			break;
-		} else if (pvt->model >= 0x20 && pvt->model <= 0x2f) {
-			fam_type = &family_types[F17_M70H_CPUS];
-			pvt->ops = &family_types[F17_M70H_CPUS].ops;
-			fam_type->ctl_name = "F19h_M20h";
+		case 0x10 ... 0x1f:
+			pvt->ctl_name			= "F19h_M10h";
+			pvt->max_mcs			= 12;
+			pvt->flags.zn_regs_v2		= 1;
 			break;
-		} else if (pvt->model >= 0x50 && pvt->model <= 0x5f) {
-			fam_type = &family_types[F19_M50H_CPUS];
-			pvt->ops = &family_types[F19_M50H_CPUS].ops;
-			fam_type->ctl_name = "F19h_M50h";
+		case 0x20 ... 0x2f:
+			pvt->ctl_name			= "F19h_M20h";
 			break;
-		} else if (pvt->model >= 0xa0 && pvt->model <= 0xaf) {
-			fam_type = &family_types[F19_M10H_CPUS];
-			pvt->ops = &family_types[F19_M10H_CPUS].ops;
-			fam_type->ctl_name = "F19h_MA0h";
+		case 0x50 ... 0x5f:
+			pvt->ctl_name			= "F19h_M50h";
+			break;
+		case 0xa0 ... 0xaf:
+			pvt->ctl_name			= "F19h_MA0h";
+			pvt->max_mcs			= 12;
+			pvt->flags.zn_regs_v2		= 1;
 			break;
 		}
-		fam_type	= &family_types[F19_CPUS];
-		pvt->ops	= &family_types[F19_CPUS].ops;
-		family_types[F19_CPUS].ctl_name = "F19h";
 		break;
 
 	default:
 		amd64_err("Unsupported family!\n");
-		return NULL;
+		return -ENODEV;
 	}
 
-	return fam_type;
+	return 0;
 }
 
 static const struct attribute_group *amd64_edac_attr_groups[] = {
@@ -3903,12 +3826,12 @@ static int hw_info_get(struct amd64_pvt *pvt)
 	int ret;
 
 	if (pvt->fam >= 0x17) {
-		pvt->umc = kcalloc(fam_type->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
+		pvt->umc = kcalloc(pvt->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
 		if (!pvt->umc)
 			return -ENOMEM;
 	} else {
-		pci_id1 = fam_type->f1_id;
-		pci_id2 = fam_type->f2_id;
+		pci_id1 = pvt->f1_id;
+		pci_id2 = pvt->f2_id;
 	}
 
 	ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
@@ -3938,7 +3861,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	layers[0].size = pvt->csels[0].b_cnt;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-	layers[1].size = fam_type->max_mcs;
+	layers[1].size = pvt->max_mcs;
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
@@ -3968,7 +3891,7 @@ static bool instance_has_memory(struct amd64_pvt *pvt)
 	bool cs_enabled = false;
 	int cs = 0, dct = 0;
 
-	for (dct = 0; dct < fam_type->max_mcs; dct++) {
+	for (dct = 0; dct < pvt->max_mcs; dct++) {
 		for_each_chip_select(cs, dct, pvt)
 			cs_enabled |= csrow_enabled(cs, dct, pvt);
 	}
@@ -3997,9 +3920,8 @@ static int probe_one_instance(unsigned int nid)
 	pvt->mc_node_id	= nid;
 	pvt->F3 = F3;
 
-	ret = -ENODEV;
-	fam_type = per_family_init(pvt);
-	if (!fam_type)
+	ret = per_family_init(pvt);
+	if (ret < 0)
 		goto err_enable;
 
 	ret = hw_info_get(pvt);
@@ -4038,11 +3960,7 @@ static int probe_one_instance(unsigned int nid)
 		goto err_enable;
 	}
 
-	amd64_info("%s %sdetected (node %d).\n", fam_type->ctl_name,
-		     (pvt->fam == 0xf ?
-				(pvt->ext_model >= K8_REV_F  ? "revF or later "
-							     : "revE or earlier ")
-				 : ""), pvt->mc_node_id);
+	amd64_info("%s detected (node %d).\n", pvt->ctl_name, pvt->mc_node_id);
 
 	dump_misc_regs(pvt);
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index e4329dff8cf2..8eea15546b9f 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -273,25 +273,6 @@
 
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
@@ -334,6 +315,16 @@ struct amd64_umc {
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
 
@@ -375,6 +366,12 @@ struct amd64_pvt {
 	/* x4, x8, or x16 syndromes in use */
 	u8 ecc_sym_sz;
 
+	const char *ctl_name;
+	u16 f1_id, f2_id;
+	/* Maximum number of memory controllers per die/node. */
+	u8 max_mcs;
+
+	struct amd64_family_flags flags;
 	/* place to store error injection parameters prior to issue */
 	struct error_injection injection;
 
@@ -465,29 +462,10 @@ struct ecc_settings {
  * functions and per device encoding/decoding logic.
  */
 struct low_ops {
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
-	u16 f1_id, f2_id;
-	/* Maximum number of memory controllers per die/node. */
-	u8 max_mcs;
-	struct amd64_family_flags flags;
-	struct low_ops ops;
+	void (*map_sysaddr_to_csrow)(struct mem_ctl_info *mci, u64 sys_addr,
+				     struct err_info *err);
+	int  (*dbam_to_cs)(struct amd64_pvt *pvt, u8 dct,
+			   unsigned int cs_mode, int cs_mask_nr);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

