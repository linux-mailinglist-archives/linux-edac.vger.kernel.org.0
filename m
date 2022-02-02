Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC484A736E
	for <lists+linux-edac@lfdr.de>; Wed,  2 Feb 2022 15:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbiBBOn1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Feb 2022 09:43:27 -0500
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:63578
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233004AbiBBOn0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 2 Feb 2022 09:43:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4YoZ3D0ViIvB+r0PE8ewRaX699uJenb4d+FCYsjzpInsZuahaT9cxDRYbM9Tzl/+AWRBxvBmJDtzGe6XEIdg7r088WatHN37RwLTD7+N0+9ZTgRoMmC9+hUwGxFu4Qp7/Lee3Q8sVlGmwgX2DuUsZiqI4fDsPvzegdzcNghfHJHrgBfiOi5d+PrQpRo304p6zgAyMM05fdQ8ULl6DOsCuhtMslKk3W7Fxk0Pv5D/VA/oA8ewhWbfJkR7B2P6IcxhFP/y6QcLQDWrlgYswX9OpPEU0cpX63HoS5wilF5fc9Xqk8YwG0aRpDrubzwuF3TkOpuayIe0kFQHmOA7d5GqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FrpNN21TIduNnqpXTFezn7hOidoh1hKe1Jyzd49Qk4=;
 b=Wvx/jmBFM/lM9pOYjT4QTCuVQI1eQPIcbuExvCRWoikKpMNe6E8tPlBZa/yUJ2CqGnUmhE+6ofYYDLO4DoWM1YgdmAm2Pwzf6HNFd+IC+wCvTrdV1EllYKpbuFu/7iki0DynxS/LEgicB8dXU/Yrjf33E1c5fjN6JKTRFGmYFtCKz8nPop7oQR63/yiCZk1p50V3ehsMz/hWkwA13RBmLod/5TvjRWvQxmCBZ7uYO/w/HuT44L2ZmHbL8D6Ge1InpXs+hJhZdQ3bW/WITm5908pCHWOtlhsnBavvtFy3UTEBMujWVeQFEdvmdpyNtKfNe663jeuCJSMBDFSwWoMFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FrpNN21TIduNnqpXTFezn7hOidoh1hKe1Jyzd49Qk4=;
 b=xDxdFsvMCY7xukeDHDxH/FV52kTUw+abNdVxBuq0OMMB6skhc2t9wm5uCTKcuMVjYeBNNVAo1ZQ0C+mABamqsiRikB3zPWi12zLjTh169kS7FrBLyeNLSbLpoRCkZrDuHrJrs760UEK7B3Bid14LaolTVL2N3RFmXNi+4fdug00=
Received: from DM5PR19CA0059.namprd19.prod.outlook.com (2603:10b6:3:116::21)
 by BYAPR12MB2599.namprd12.prod.outlook.com (2603:10b6:a03:6b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 14:43:24 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::5a) by DM5PR19CA0059.outlook.office365.com
 (2603:10b6:3:116::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 2 Feb 2022 14:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Wed, 2 Feb 2022 14:43:23 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Feb
 2022 08:43:22 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH v4 2/2] EDAC/amd64: Add new register offset support and related changes
Date:   Wed, 2 Feb 2022 14:43:07 +0000
Message-ID: <20220202144307.2678405-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202144307.2678405-1-yazen.ghannam@amd.com>
References: <20220202144307.2678405-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 683b6c86-91a2-4f1b-e926-08d9e65a5d77
X-MS-TrafficTypeDiagnostic: BYAPR12MB2599:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB259967D4955544823E3CEE9CF8279@BYAPR12MB2599.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjf6M66n6lohrAClv0d78ITztVeV5/dTJnhPQo+9WIfwbBVpYQ8tWJJVNJwjgWWQ/QYk9pgh/ByPxlCa6M11wXaXuT8184MfsJKr43e7FL/QpCh0wLR4ZuXCsAmEf6bEPrDbn72P0exCGBTVV8KXlpw+CUIVtgKL7qaPIn/FRQNqXpTBCVy0FoFPdfAbovGElAGOwChpkh/AjoqPbYHvdKcplmkA9F2Sg+r+QLsFnwLfE1MtOtxJPuKNqmSoElcs9mn4Iif7kn289g17DbaWOAVqUr6VKdLdAnD2QA7eo03QDbIp29jAxuSmwCXf1yEJfUHHn9xO2uW8VZv93EnYysgiAWFKwxu79ZzjCA1p8tNIKV3O4StZiOtz7i9+WnyAlu/H4BuCe9I19jvMEqdfI3IlTzjqiT8r3egYAfPhqjQFcZ1GBJpWI3QpQ5I/SpWVbtghcnN2JY1D3roRQpA4Rc0AOyVDzjfNcjclWE4W8n9bTtxCBRntDQkkw6BB9/koF8wjt/3FQB3SKBodYakNzheYaGF0A2KD1eiqLJEeyjYL2r8miolTCQWWttDLJqJ/DRqg3atBFJbHaeUEI8+CVCzzVyNRsJyHsYB6Wkd531H5lc0QKqBl2ygdpPFEzkafxOGVauMVH4w4qSwdHFbNxL10i7N1SVNuL7E/5+NrS7UFhW4YJ84FywIJie1ODu+KayE/F4fX/vyjc/VhRSswsc/Bdjn5ul3xd5lkRrComWbzNuXl0xt6pMfEBL5Q+Ohxx+eJbnWAoDNPqK8xqkNh6XgC8XiKhYMbvnmqlw1zsI8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(86362001)(8936002)(356005)(47076005)(81166007)(336012)(966005)(8676002)(70206006)(40460700003)(36756003)(70586007)(4326008)(54906003)(6666004)(6916009)(508600001)(316002)(16526019)(2616005)(5660300002)(1076003)(186003)(26005)(7696005)(426003)(36860700001)(82310400004)(44832011)(83380400001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:43:23.8126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 683b6c86-91a2-4f1b-e926-08d9e65a5d77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2599
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Introduce a "family flags" bitmask that can be used to indicate any
special behavior needed on a per-family basis.

Add a flag to indicate a system uses the new register offsets introduced
with Family 19h Model 10h.

Use this flag to account for register offset changes, a new bitfield
indicating DDR5 use on a memory controller, and to set the proper number
of chip select masks.

Rework f17_addr_mask_to_cs_size() to properly handle the change in chip
select masks. And update code comments to reflect the updated Chip
Select, DIMM, and Mask relationships.

[uninitiliazed variable warning]
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211228200615.412999-3-yazen.ghannam@amd.com

v3->v4:
* Use a single helper function for new register offsets.
* Fix an uninitialized variable warning.

v2->v3:
* Adjust variable names to explicitly show what they represent.
* Update code comment to give more detail on CS/MASK/DIMM layout.

v1->v2:
* Was patch 4 in v1.
* Change "has_ddr5" flag to "zn_regs_v2".
* Drop flag check helper function.
* Update determine_memory_type() to check bitfield for DDR5.
* Update code comments.

 drivers/edac/amd64_edac.c | 80 +++++++++++++++++++++++++++++++--------
 drivers/edac/amd64_edac.h | 14 +++++++
 2 files changed, 78 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 49e384207ce0..5806fe657373 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -15,6 +15,21 @@ static struct msr __percpu *msrs;
 
 static struct amd64_family_type *fam_type;
 
+static inline u32 get_umc_reg(u32 reg)
+{
+	if (!fam_type->flags.zn_regs_v2)
+		return reg;
+
+	switch (reg) {
+	case UMCCH_ADDR_CFG:		return UMCCH_ADDR_CFG_DDR5;
+	case UMCCH_ADDR_MASK_SEC:	return UMCCH_ADDR_MASK_SEC_DDR5;
+	case UMCCH_DIMM_CFG:		return UMCCH_DIMM_CFG_DDR5;
+	}
+
+	WARN_ONCE(1, "%s: unknown register 0x%x", __func__, reg);
+	return 0;
+}
+
 /* Per-node stuff */
 static struct ecc_settings **ecc_stngs;
 
@@ -1429,8 +1444,10 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
 				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
 
-		if (umc->dram_type == MEM_LRDDR4) {
-			amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ADDR_CFG, &tmp);
+		if (umc->dram_type == MEM_LRDDR4 || umc->dram_type == MEM_LRDDR5) {
+			amd_smn_read(pvt->mc_node_id,
+				     umc_base + get_umc_reg(UMCCH_ADDR_CFG),
+				     &tmp);
 			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
 					i, 1 << ((tmp >> 4) & 0x3));
 		}
@@ -1505,7 +1522,7 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 
 		for_each_umc(umc) {
 			pvt->csels[umc].b_cnt = 4;
-			pvt->csels[umc].m_cnt = 2;
+			pvt->csels[umc].m_cnt = fam_type->flags.zn_regs_v2 ? 4 : 2;
 		}
 
 	} else {
@@ -1545,7 +1562,7 @@ static void read_umc_base_mask(struct amd64_pvt *pvt)
 		}
 
 		umc_mask_reg = get_umc_base(umc) + UMCCH_ADDR_MASK;
-		umc_mask_reg_sec = get_umc_base(umc) + UMCCH_ADDR_MASK_SEC;
+		umc_mask_reg_sec = get_umc_base(umc) + get_umc_reg(UMCCH_ADDR_MASK_SEC);
 
 		for_each_chip_select_mask(cs, umc, pvt) {
 			mask = &pvt->csels[umc].csmasks[cs];
@@ -1623,12 +1640,25 @@ static void _determine_memory_type_df(struct amd64_umc *umc)
 		return;
 	}
 
-	if (umc->dimm_cfg & BIT(5))
-		umc->dram_type = MEM_LRDDR4;
-	else if (umc->dimm_cfg & BIT(4))
-		umc->dram_type = MEM_RDDR4;
-	else
-		umc->dram_type = MEM_DDR4;
+	/*
+	 * Check if the system supports the "DDR Type" field in UMC Config
+	 * and has DDR5 DIMMs in use.
+	 */
+	if (fam_type->flags.zn_regs_v2 && ((umc->umc_cfg & GENMASK(2, 0)) == 0x1)) {
+		if (umc->dimm_cfg & BIT(5))
+			umc->dram_type = MEM_LRDDR5;
+		else if (umc->dimm_cfg & BIT(4))
+			umc->dram_type = MEM_RDDR5;
+		else
+			umc->dram_type = MEM_DDR5;
+	} else {
+		if (umc->dimm_cfg & BIT(5))
+			umc->dram_type = MEM_LRDDR4;
+		else if (umc->dimm_cfg & BIT(4))
+			umc->dram_type = MEM_RDDR4;
+		else
+			umc->dram_type = MEM_DDR4;
+	}
 }
 
 static void determine_memory_type_df(struct amd64_pvt *pvt)
@@ -2170,6 +2200,7 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 {
 	u32 addr_mask_orig, addr_mask_deinterleaved;
 	u32 msb, weight, num_zero_bits;
+	int cs_mask_nr = csrow_nr;
 	int dimm, size = 0;
 
 	/* No Chip Selects are enabled. */
@@ -2185,17 +2216,33 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 		return size;
 
 	/*
-	 * There is one mask per DIMM, and two Chip Selects per DIMM.
-	 *	CS0 and CS1 -> DIMM0
-	 *	CS2 and CS3 -> DIMM1
+	 * Family 17h introduced systems with one mask per DIMM,
+	 * and two Chip Selects per DIMM.
+	 *
+	 *	CS0 and CS1 -> MASK0 / DIMM0
+	 *	CS2 and CS3 -> MASK1 / DIMM1
+	 *
+	 * Family 19h Model 10h introduced systems with one mask per Chip Select,
+	 * and two Chip Selects per DIMM.
+	 *
+	 *	CS0 -> MASK0 -> DIMM0
+	 *	CS1 -> MASK1 -> DIMM0
+	 *	CS2 -> MASK2 -> DIMM1
+	 *	CS3 -> MASK3 -> DIMM1
+	 *
+	 * Keep the mask number equal to the Chip Select number for newer systems,
+	 * and shift the mask number for older systems.
 	 */
 	dimm = csrow_nr >> 1;
 
+	if (!fam_type->flags.zn_regs_v2)
+		cs_mask_nr >>= 1;
+
 	/* Asymmetric dual-rank DIMM support. */
 	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
-		addr_mask_orig = pvt->csels[umc].csmasks_sec[dimm];
+		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
 	else
-		addr_mask_orig = pvt->csels[umc].csmasks[dimm];
+		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
 
 	/*
 	 * The number of zero bits in the mask is equal to the number of bits
@@ -2951,6 +2998,7 @@ static struct amd64_family_type family_types[] = {
 		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F6,
 		.max_mcs = 12,
+		.flags.zn_regs_v2 = 1,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
@@ -3389,7 +3437,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + UMCCH_DIMM_CFG, &umc->dimm_cfg);
+		amd_smn_read(nid, umc_base + get_umc_reg(UMCCH_DIMM_CFG), &umc->dimm_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
 		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 09ad28299c57..6f8147abfa71 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -273,8 +273,11 @@
 #define UMCCH_BASE_ADDR_SEC		0x10
 #define UMCCH_ADDR_MASK			0x20
 #define UMCCH_ADDR_MASK_SEC		0x28
+#define UMCCH_ADDR_MASK_SEC_DDR5	0x30
 #define UMCCH_ADDR_CFG			0x30
+#define UMCCH_ADDR_CFG_DDR5		0x40
 #define UMCCH_DIMM_CFG			0x80
+#define UMCCH_DIMM_CFG_DDR5		0x90
 #define UMCCH_UMC_CFG			0x100
 #define UMCCH_SDP_CTRL			0x104
 #define UMCCH_ECC_CTRL			0x14C
@@ -483,11 +486,22 @@ struct low_ops {
 					 unsigned cs_mode, int cs_mask_nr);
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
 struct amd64_family_type {
 	const char *ctl_name;
 	u16 f0_id, f1_id, f2_id, f6_id;
 	/* Maximum number of memory controllers per die/node. */
 	u8 max_mcs;
+	struct amd64_family_flags flags;
 	struct low_ops ops;
 };
 
-- 
2.25.1

