Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2ED3F5029
	for <lists+linux-edac@lfdr.de>; Mon, 23 Aug 2021 20:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhHWSNT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Aug 2021 14:13:19 -0400
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com ([40.107.92.72]:23608
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231960AbhHWSNS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Aug 2021 14:13:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0RuKKF/t26u/TTcbYEzmu9qKzt8sIBpmuoG12qrPDHce4mdsClpo4iouFabslrdybDteMGBkdJwI0AGjzCD0xhQ+qR+kZBg3gZpgY3cpej53N6tVgVXBmnTcs/odRMF/XweSTmqMIMXHQjjtLV0ZmBBkecdoxuqvJ7Vhy5Dq9HR1Ec/rVCu6NeapVVfYs+MR6/DAEiQQrvCw9DYqhGNt5NHDaYSPG4WKUTuNpPVWed3h2yVU5azBde7NeJHUIHDLWVUp9/o+hO46FHOdANBAydF7pqpSjmQH05s6ifln0il0r1FHkl4SxFxjzqTjWCcvMfkhnm4MUazdKorP23ohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6GQhMuKOfnfLrVq3juCJDe3YmGtHxRuu34HkKTKp9I=;
 b=Qy1cJG4eX+qfh6W0m6HO4soFe+3mroYJo2bVQR1zEvy6B91a2sWoHkXKnY2w927djGYQ+zTWmRT9ZRlS107/Kk4cNDiUH/5aO4R2Ywi7V5LYCuhreegv3oiYCFQ84K0OKeJcX5/rpG903WnW+lFtSJW0bFVEKP1KYZgiil3Bq38Q7S3biqvqJ/V2CcLxS00Hys8S8DdssbqdlyVUsaMysQD6N/RMK+yKUs0Lywsti7g7OhumtOszQsf6l83tOFH2UvFhCj8qyXYCEjkUdq+TmrBnHoXBKrPA3gHDYiazp49+3RWkjqb38O3xNanFiOGzoZ8+vdLVbCFRWVCMGqMlsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6GQhMuKOfnfLrVq3juCJDe3YmGtHxRuu34HkKTKp9I=;
 b=eQDTFosX7MkMNLZqPubm0g0d2aFmL7jhsD0eeHQ84FizLE6UhAyq5amZuXEAiC21Fnnl34S3JVtid7okAGusFQcDhq77O+GX0njnqS4LIg4B1G4K0pG3I0NvBtMrHm8A1Ej7z0RP+glAS2OS48NtgzJoideJeNxuGJpdgghJvb8=
Received: from MWHPR17CA0063.namprd17.prod.outlook.com (2603:10b6:300:93::25)
 by SN6PR12MB2655.namprd12.prod.outlook.com (2603:10b6:805:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Mon, 23 Aug
 2021 18:12:33 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::a2) by MWHPR17CA0063.outlook.office365.com
 (2603:10b6:300:93::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend
 Transport; Mon, 23 Aug 2021 18:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:12:32 +0000
Received: from SLES15.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 23 Aug
 2021 13:12:28 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>,
        <Yazen.Ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 3/3] EDAC/amd64: Enumerate memory on noncpu nodes
Date:   Tue, 24 Aug 2021 00:24:37 +0530
Message-ID: <20210823185437.94417-4-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210823185437.94417-1-nchatrad@amd.com>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f775c4d-d65d-416b-b758-08d9666193b1
X-MS-TrafficTypeDiagnostic: SN6PR12MB2655:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2655BD0CEED348555F9F1B4EE8C49@SN6PR12MB2655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:190;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: palPorcAGoYGnD8rAkcp+52igiEfBCW19wSroKewq2BbI1QPTKOxK/EuQPQrP0+eFGapKCR90ppkpISIPiIwrxGLvxBsX4maorKj1yYmYkUTi5iXSlMhqW3mhnskF3MpeHwChxjrLfEZQ425qDyeUHUTB0ker1WdC8oFVehlqRAX5kXj6qoNSnzrjsN7nrsiHJ/OPWcJYVUMaHhwg3CxXCfv56e3I/zzNQfqZYev8y+r2EwDX+8YZWVTMUuM0o1YRierKLgVuO5tkzzSyPNbQd83WX7nYcIOxUim5AvfEbj0IunfjWQgcaE+FaTgW6uK24L2cxfl78fcUMkoFukfYTPjWnBfhixHrR76vjPxzMHgYsmtkApHBovCBbKeq5cuNvKDbMVFWk2WfXe0Z6FHfHToSxYGFG52zc7ETdGBR57ZsWj6shwC4zG8k3JKGnUMPWy+O/JGXenrjPJrFx3sDuSp5Wb2+CmLJnku5TV5ElHlgFpZORbP6CvbQykdICReF5Jk313CKOrq9CY2DaTo6GlRw37J8JvhTp530idjHFJ4WddP153jFZijpWZofmLhfFx7eNQa8WJx9QS+1dwn4HBHEPzJsPu84oEJ2q3QREIBgS/GvE9qPyU1NRB8QPIS+sy8e7RiVSH1M7v4/CS7Gz8QvZPXsDRL4GVNd8Afs2WVZAb/wEKTUy5tkcuukd5+UXIEgN9/byascu9N+O7WN2EMAJdG33rSr3g1UrqXeNpHOk+7kBDzHBE2YkN3L4CfKO50FiIw0GrIpEvyIT7PDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(36840700001)(70206006)(478600001)(316002)(70586007)(36756003)(36860700001)(356005)(4326008)(30864003)(5660300002)(82310400003)(1076003)(34020700004)(8936002)(47076005)(8676002)(82740400003)(83380400001)(7696005)(2906002)(426003)(336012)(186003)(16526019)(26005)(2616005)(110136005)(54906003)(6666004)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:12:32.3835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f775c4d-d65d-416b-b758-08d9666193b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2655
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On newer heterogeneous systems the data fabrics of the CPUs and GPUs
are connected directly via a custom links.

This patch modifies the amd64_edac module to handle the HBM memory
enumeration leveraging the existing edac and the amd64 specific data
structures.

Define PCI IDs and ops for Aldeberarn GPUs in family_types array.
The UMC Phys on GPU nodes are enumerated as csrows and the UMC channels
connected to HBMs are enumerated as ranks.
Define a function to find the UMCv2 channel number.
Define a function to calculate base address of the UMCv2 registers.
ECC is enabled by default on HBM's.
Adds debug information for UMCv2 channel registers.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
---
Changes since v2:
1. Restored line deletions and handled minor comments
2. Modified commit message and some of the function comments
3. variable df_inst_id is introduced instead of umc_num

 drivers/edac/amd64_edac.c | 219 +++++++++++++++++++++++++++++++++-----
 drivers/edac/amd64_edac.h |  28 +++++
 2 files changed, 222 insertions(+), 25 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f0d8f60acee1..452556adc1f9 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1020,6 +1020,9 @@ static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
 
 		if (umc_en_mask == dimm_ecc_en_mask)
 			edac_cap = EDAC_FLAG_SECDED;
+
+		if (pvt->is_noncpu)
+			edac_cap = EDAC_FLAG_SECDED;
 	} else {
 		bit = (pvt->fam > 0xf || pvt->ext_model >= K8_REV_F)
 			? 19
@@ -1078,6 +1081,9 @@ static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 {
 	int cs_mode = 0;
 
+	if (pvt->is_noncpu)
+		return CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
+
 	if (csrow_enabled(2 * dimm, ctrl, pvt))
 		cs_mode |= CS_EVEN_PRIMARY;
 
@@ -1097,6 +1103,15 @@ static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
 
 	edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
 
+	if (pvt->is_noncpu) {
+		cs_mode = f17_get_cs_mode(cs0, ctrl, pvt);
+		for_each_chip_select(cs0, ctrl, pvt) {
+			size0 = pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs0);
+			amd64_info(EDAC_MC ": %d: %5dMB\n", cs0, size0);
+		}
+		return;
+	}
+
 	for (dimm = 0; dimm < 2; dimm++) {
 		cs0 = dimm * 2;
 		cs1 = dimm * 2 + 1;
@@ -1121,10 +1136,15 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
-		edac_dbg(1, "UMC%d DIMM cfg: 0x%x\n", i, umc->dimm_cfg);
+		if (!pvt->is_noncpu)
+			edac_dbg(1, "UMC%d DIMM cfg: 0x%x\n", i, umc->dimm_cfg);
 		edac_dbg(1, "UMC%d UMC cfg: 0x%x\n", i, umc->umc_cfg);
 		edac_dbg(1, "UMC%d SDP ctrl: 0x%x\n", i, umc->sdp_ctrl);
 		edac_dbg(1, "UMC%d ECC ctrl: 0x%x\n", i, umc->ecc_ctrl);
+		if (pvt->is_noncpu) {
+			edac_dbg(1, "UMC%d All HBMs support ECC: yes\n", i);
+			goto dimm_size;
+		}
 
 		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ECC_BAD_SYMBOL, &tmp);
 		edac_dbg(1, "UMC%d ECC bad symbol: 0x%x\n", i, tmp);
@@ -1149,6 +1169,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 					i, 1 << ((tmp >> 4) & 0x3));
 		}
 
+ dimm_size:
 		debug_display_dimm_sizes_df(pvt, i);
 	}
 
@@ -1218,8 +1239,13 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 		int umc;
 
 		for_each_umc(umc) {
-			pvt->csels[umc].b_cnt = 4;
-			pvt->csels[umc].m_cnt = 2;
+			if (pvt->is_noncpu) {
+				pvt->csels[umc].b_cnt = 8;
+				pvt->csels[umc].m_cnt = 8;
+			} else {
+				pvt->csels[umc].b_cnt = 4;
+				pvt->csels[umc].m_cnt = 2;
+			}
 		}
 
 	} else {
@@ -1228,6 +1254,33 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 	}
 }
 
+static void read_noncpu_umc_base_mask(struct amd64_pvt *pvt)
+{
+	u32 base_reg, mask_reg;
+	u32 *base, *mask;
+	int umc, cs;
+
+	for_each_umc(umc) {
+		for_each_chip_select(cs, umc, pvt) {
+			base_reg = get_noncpu_umc_base(umc, cs) + UMCCH_BASE_ADDR;
+			base = &pvt->csels[umc].csbases[cs];
+
+			if (!amd_smn_read(pvt->mc_node_id, base_reg, base)) {
+				edac_dbg(0, "  DCSB%d[%d]=0x%08x reg: 0x%x\n",
+					 umc, cs, *base, base_reg);
+			}
+
+			mask_reg = get_noncpu_umc_base(umc, cs) + UMCCH_ADDR_MASK;
+			mask = &pvt->csels[umc].csmasks[cs];
+
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask)) {
+				edac_dbg(0, "  DCSM%d[%d]=0x%08x reg: 0x%x\n",
+					 umc, cs, *mask, mask_reg);
+			}
+		}
+	}
+}
+
 static void read_umc_base_mask(struct amd64_pvt *pvt)
 {
 	u32 umc_base_reg, umc_base_reg_sec;
@@ -1288,8 +1341,12 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 
 	prep_chip_selects(pvt);
 
-	if (pvt->umc)
-		return read_umc_base_mask(pvt);
+	if (pvt->umc) {
+		if (pvt->is_noncpu)
+			return read_noncpu_umc_base_mask(pvt);
+		else
+			return read_umc_base_mask(pvt);
+	}
 
 	for_each_chip_select(cs, 0, pvt) {
 		int reg0   = DCSB0 + (cs * 4);
@@ -1335,6 +1392,11 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 	u32 dram_ctrl, dcsm;
 
 	if (pvt->umc) {
+		if (pvt->is_noncpu) {
+			pvt->dram_type = MEM_HBM2;
+			return;
+		}
+
 		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
 			pvt->dram_type = MEM_LRDDR4;
 		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
@@ -1724,7 +1786,10 @@ static int f17_early_channel_count(struct amd64_pvt *pvt)
 
 	/* SDP Control bit 31 (SdpInit) is clear for unused UMC channels */
 	for_each_umc(i)
-		channels += !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
+		if (pvt->is_noncpu)
+			channels += pvt->csels[i].b_cnt;
+		else
+			channels += !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
 
 	amd64_info("MCT channel count: %d\n", channels);
 
@@ -1865,6 +1930,12 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	u32 msb, weight, num_zero_bits;
 	int dimm, size = 0;
 
+	if (pvt->is_noncpu) {
+		addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
+		/* The memory channels in case of GPUs are fully populated */
+		goto skip_noncpu;
+	}
+
 	/* No Chip Selects are enabled. */
 	if (!cs_mode)
 		return size;
@@ -1890,6 +1961,7 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	else
 		addr_mask_orig = pvt->csels[umc].csmasks[dimm];
 
+ skip_noncpu:
 	/*
 	 * The number of zero bits in the mask is equal to the number of bits
 	 * in a full mask minus the number of bits in the current mask.
@@ -2635,6 +2707,16 @@ static struct amd64_family_type family_types[] = {
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
+	[ALDEBARAN_GPUS] = {
+		.ctl_name = "ALDEBARAN",
+		.f0_id = PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0,
+		.f6_id = PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6,
+		.max_mcs = 4,
+		.ops = {
+			.early_channel_count	= f17_early_channel_count,
+			.dbam_to_cs		= f17_addr_mask_to_cs_size,
+		}
+	},
 };
 
 /*
@@ -2890,6 +2972,30 @@ static int find_umc_channel(struct mce *m)
 	return (m->ipid & GENMASK(31, 0)) >> 20;
 }
 
+/*
+ * The CPUs have one channel per UMC, So a UMC number is equivalent to a
+ * channel number. The NONCPUs have 8 channels per UMC, so the UMC number no
+ * longer works as a channel number.
+ * The channel number within a NONCPU UMC is given in MCA_IPID[15:12].
+ * However, the IDs are split such that two UMC values go to one UMC, and
+ * the channel numbers are split in two groups of four.
+ *
+ * Refer comment on get_noncpu_umc_base() from amd64_edac.h
+ *
+ * For example,
+ * UMC0 CH[3:0] = 0x0005[3:0]000
+ * UMC0 CH[7:4] = 0x0015[3:0]000
+ * UMC1 CH[3:0] = 0x0025[3:0]000
+ * UMC1 CH[7:4] = 0x0035[3:0]000
+ */
+static int find_umc_channel_noncpu(struct mce *m)
+{
+	u8 umc = find_umc_channel(m);
+	u8 ch = ((m->ipid >> 12) & 0xf);
+
+	return umc % 2 ? (ch + 4) : ch;
+}
+
 static void decode_umc_error(int node_id, struct mce *m)
 {
 	u8 ecc_type = (m->status >> 45) & 0x3;
@@ -2897,6 +3003,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 	struct amd64_pvt *pvt;
 	struct err_info err;
 	u64 sys_addr;
+	u8 df_inst_id;
 
 	mci = edac_mc_find(node_id);
 	if (!mci)
@@ -2909,7 +3016,22 @@ static void decode_umc_error(int node_id, struct mce *m)
 	if (m->status & MCI_STATUS_DEFERRED)
 		ecc_type = 3;
 
-	err.channel = find_umc_channel(m);
+	if (pvt->is_noncpu) {
+		/*
+		 * The NONCPUs have one Chip Select per UMC, so the UMC number
+		 * can used as the Chip Select number. However, the UMC number
+		 * is split in the ID value so it's necessary to divide by 2.
+		 */
+		err.csrow = find_umc_channel(m) / 2;
+		err.channel = find_umc_channel_noncpu(m);
+		/* On NONCPUs, instance id is calculated as below. */
+		df_inst_id = err.csrow * 8 + err.channel;
+	} else {
+		/* On CPUs, "Channel"="UMC Number"="DF Instance ID". */
+		err.channel = find_umc_channel(m);
+		err.csrow = m->synd & 0x7;
+		df_inst_id = err.channel;
+	}
 
 	if (!(m->status & MCI_STATUS_SYNDV)) {
 		err.err_code = ERR_SYND;
@@ -2925,9 +3047,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 			err.err_code = ERR_CHANNEL;
 	}
 
-	err.csrow = m->synd & 0x7;
-
-	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
+	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, df_inst_id, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
 	}
@@ -3054,15 +3174,21 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 
 	/* Read registers from each UMC */
 	for_each_umc(i) {
+		if (pvt->is_noncpu)
+			umc_base = get_noncpu_umc_base(i, 0);
+		else
+			umc_base = get_umc_base(i);
 
-		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + UMCCH_DIMM_CFG, &umc->dimm_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
 		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
-		amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
+
+		if (!pvt->is_noncpu) {
+			amd_smn_read(nid, umc_base + UMCCH_DIMM_CFG, &umc->dimm_cfg);
+			amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
+		}
 	}
 }
 
@@ -3144,7 +3270,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	determine_memory_type(pvt);
 	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
 
-	determine_ecc_sym_sz(pvt);
+	/* ECC symbol size is not available on NONCPU nodes */
+	if (!pvt->is_noncpu)
+		determine_ecc_sym_sz(pvt);
 }
 
 /*
@@ -3232,15 +3360,21 @@ static int init_csrows_df(struct mem_ctl_info *mci)
 				continue;
 
 			empty = 0;
-			dimm = mci->csrows[cs]->channels[umc]->dimm;
+			if (pvt->is_noncpu) {
+				dimm = mci->csrows[umc]->channels[cs]->dimm;
+				dimm->edac_mode = EDAC_SECDED;
+				dimm->dtype = DEV_X16;
+			} else {
+				dimm = mci->csrows[cs]->channels[umc]->dimm;
+				dimm->edac_mode = edac_mode;
+				dimm->dtype = dev_type;
+			}
 
 			edac_dbg(1, "MC node: %d, csrow: %d\n",
 					pvt->mc_node_id, cs);
 
 			dimm->nr_pages = get_csrow_nr_pages(pvt, umc, cs);
 			dimm->mtype = pvt->dram_type;
-			dimm->edac_mode = edac_mode;
-			dimm->dtype = dev_type;
 			dimm->grain = 64;
 		}
 	}
@@ -3505,7 +3639,9 @@ static bool ecc_enabled(struct amd64_pvt *pvt)
 
 			umc_en_mask |= BIT(i);
 
-			if (umc->umc_cap_hi & UMC_ECC_ENABLED)
+			/* ECC is enabled by default on NONCPU nodes */
+			if (pvt->is_noncpu ||
+			    (umc->umc_cap_hi & UMC_ECC_ENABLED))
 				ecc_en_mask |= BIT(i);
 		}
 
@@ -3541,6 +3677,11 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
 {
 	u8 i, ecc_en = 1, cpk_en = 1, dev_x4 = 1, dev_x16 = 1;
 
+	if (pvt->is_noncpu) {
+		mci->edac_ctl_cap |= EDAC_SECDED;
+		return;
+	}
+
 	for_each_umc(i) {
 		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
 			ecc_en &= !!(pvt->umc[i].umc_cap_hi & UMC_ECC_ENABLED);
@@ -3571,7 +3712,11 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 {
 	struct amd64_pvt *pvt = mci->pvt_info;
 
-	mci->mtype_cap		= MEM_FLAG_DDR2 | MEM_FLAG_RDDR2;
+	if (pvt->is_noncpu)
+		mci->mtype_cap = MEM_FLAG_HBM2;
+	else
+		mci->mtype_cap = MEM_FLAG_DDR2 | MEM_FLAG_RDDR2;
+
 	mci->edac_ctl_cap	= EDAC_FLAG_NONE;
 
 	if (pvt->umc) {
@@ -3676,11 +3821,24 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 			fam_type = &family_types[F17_M70H_CPUS];
 			pvt->ops = &family_types[F17_M70H_CPUS].ops;
 			fam_type->ctl_name = "F19h_M20h";
-			break;
+		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
+			if (pvt->is_noncpu) {
+				int tmp = pvt->mc_node_id - NONCPU_NODE_INDEX;
+
+				fam_type = &family_types[ALDEBARAN_GPUS];
+				pvt->ops = &family_types[ALDEBARAN_GPUS].ops;
+				sprintf(pvt->buf, "Aldebaran#%ddie#%d", tmp / 2, tmp % 2);
+				fam_type->ctl_name = pvt->buf;
+			} else {
+				fam_type = &family_types[F19_CPUS];
+				pvt->ops = &family_types[F19_CPUS].ops;
+				fam_type->ctl_name = "F19h_M30h";
+			}
+		} else {
+			fam_type = &family_types[F19_CPUS];
+			pvt->ops = &family_types[F19_CPUS].ops;
+			family_types[F19_CPUS].ctl_name = "F19h";
 		}
-		fam_type	= &family_types[F19_CPUS];
-		pvt->ops	= &family_types[F19_CPUS].ops;
-		family_types[F19_CPUS].ctl_name = "F19h";
 		break;
 
 	default:
@@ -3748,9 +3906,10 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	if (pvt->channel_count < 0)
 		return ret;
 
+	/* Define layers for CPU and NONCPU nodes */
 	ret = -ENOMEM;
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = pvt->csels[0].b_cnt;
+	layers[0].size = pvt->is_noncpu ? fam_type->max_mcs : pvt->csels[0].b_cnt;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 
@@ -3759,7 +3918,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	 * only one channel. Also, this simplifies handling later for the price
 	 * of a couple of KBs tops.
 	 */
-	layers[1].size = fam_type->max_mcs;
+	layers[1].size = pvt->is_noncpu ? pvt->csels[0].b_cnt : fam_type->max_mcs;
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
@@ -3804,6 +3963,9 @@ static int probe_one_instance(unsigned int nid)
 	struct ecc_settings *s;
 	int ret;
 
+	if (!F3)
+		return 0;
+
 	ret = -ENOMEM;
 	s = kzalloc(sizeof(struct ecc_settings), GFP_KERNEL);
 	if (!s)
@@ -3815,6 +3977,9 @@ static int probe_one_instance(unsigned int nid)
 	if (!pvt)
 		goto err_settings;
 
+	if (nid >= NONCPU_NODE_INDEX)
+		pvt->is_noncpu = true;
+
 	pvt->mc_node_id	= nid;
 	pvt->F3 = F3;
 
@@ -3888,6 +4053,10 @@ static void remove_one_instance(unsigned int nid)
 	struct mem_ctl_info *mci;
 	struct amd64_pvt *pvt;
 
+	/* Nothing to remove for the space holder entries */
+	if (!F3)
+		return;
+
 	/* Remove from EDAC CORE tracking list */
 	mci = edac_mc_del_mc(&F3->dev);
 	if (!mci)
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 85aa820bc165..0844f004c90b 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -126,6 +126,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
 #define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
 #define PCI_DEVICE_ID_AMD_19H_DF_F6	0x1656
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0	0x14D0
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6	0x14D6
 
 /*
  * Function 1 - Address Map
@@ -298,6 +300,7 @@ enum amd_families {
 	F17_M60H_CPUS,
 	F17_M70H_CPUS,
 	F19_CPUS,
+	ALDEBARAN_GPUS,
 	NUM_FAMILIES,
 };
 
@@ -389,6 +392,9 @@ struct amd64_pvt {
 	enum mem_type dram_type;
 
 	struct amd64_umc *umc;	/* UMC registers */
+	char buf[20];
+
+	bool is_noncpu;
 };
 
 enum err_codes {
@@ -410,6 +416,28 @@ struct err_info {
 	u32 offset;
 };
 
+static inline u32 get_noncpu_umc_base(u8 umc, u8 channel)
+{
+	/*
+	 * On CPUs, there is one channel per UMC, so UMC numbering equals
+	 * channel numbering. On NONCPUs, there are eight channels per UMC,
+	 * so the channel numbering is different from UMC numbering.
+	 *
+	 * On CPU nodes channels are selected in 6th nibble
+	 * UMC chY[3:0]= [(chY*2 + 1) : (chY*2)]50000;
+	 *
+	 * On NONCPU nodes channels are selected in 3rd nibble
+	 * HBM chX[3:0]= [Y  ]5X[3:0]000;
+	 * HBM chX[7:4]= [Y+1]5X[3:0]000
+	 */
+	umc *= 2;
+
+	if (channel >= 4)
+		umc++;
+
+	return 0x50000 + (umc << 20) + ((channel % 4) << 12);
+}
+
 static inline u32 get_umc_base(u8 channel)
 {
 	/* chY: 0xY50000 */
-- 
2.25.1

