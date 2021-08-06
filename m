Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D212B3E23B0
	for <lists+linux-edac@lfdr.de>; Fri,  6 Aug 2021 09:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243532AbhHFHEj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Aug 2021 03:04:39 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:27616
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243526AbhHFHEi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 6 Aug 2021 03:04:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq7y3IbDigPJQl6ym9FvnvJxlEidC5Bom5PGzohb5zpYddYvk2/A4aPSEG/7URWvBgw1k5iSdosNY5TI3zZGtOueyWVUwvelt+PmM5I4+bdGWRYYxMzGikIle/8VhRGyyrNWkAo5eeaF8m5oNmvQk+Sz88gWx7rzHQP/N+u5U1VIRs1j5/vQuUBNc1MKpcdMq6U7ghak1+hoRBLSrGWhFVdjdgL/CZiCh5gAfF0bLeSUs7NAj3MNdL9387t47vT+xunQ0srh4MS/JrlJ4RSc3MiLxa6hKtqQ3UL+hHYHum2hYTE8yvMzZjcdSRY8z889tUHLmZKvkcukDgu+iMpyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixlm3OF40ktlKzOwJX7eJL+QCCfmmM6fDB9gK4hMRY4=;
 b=O7QNgG4QDQYzRlcTKuXF52QBq/S8j7Q2agPRn23wSDCdqplbgivsA3v1U36C/SwptaF+uA9j7gNhkSt86OK8pcxUAFYHWZ5tWHWvbAEPqY4aABzw1B7HjiQG1C8u9IrJ/hvnTcaC56VPEy3g8lB6+sSCsZ2WEXHXmjAjewxz1pCItZgpNvtYE1vhiyYEJsgL2mS53rDrO9Udht+JV4xeWgo1wm8CUwCOhmT0tl8Pcs+uSQGSyXPdlmqdHyi1yMrB8LhKwcCKYYR3O9I8Q++sGIpGVdDFGK/hhMo6Vh5k84PKnRFbBGLAPMWz5x2z85W1R/9RxUiJlVnTk3rwAwYbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixlm3OF40ktlKzOwJX7eJL+QCCfmmM6fDB9gK4hMRY4=;
 b=w6jttSAb8SBWLiMy+3XPxu2vcxeiXJFdZ1IGGNJvgXNengug0+3F7Q6RnlR9stu3dmboDuxM96gu81Xl4Z5zGTATn761LbPtTJuD+8LoMyWBcgSUHzoYFTTav9BFpCzJjuNimxGUs4qzvvaCffp/0OpAvKXGq3MfpIqmUtg48Ig=
Received: from DM5PR16CA0017.namprd16.prod.outlook.com (2603:10b6:3:c0::27) by
 DM5PR12MB2344.namprd12.prod.outlook.com (2603:10b6:4:b2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.25; Fri, 6 Aug 2021 07:04:21 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::e5) by DM5PR16CA0017.outlook.office365.com
 (2603:10b6:3:c0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Fri, 6 Aug 2021 07:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 07:04:21 +0000
Received: from SLES15.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 02:04:12 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH v2 3/3] EDAC/amd64: Enumerate memory on noncpu nodes
Date:   Fri, 6 Aug 2021 13:13:50 +0530
Message-ID: <20210806074350.114614-4-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210806074350.114614-1-nchatrad@amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210806074350.114614-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 640ff3c2-b860-4c78-257d-08d958a86a75
X-MS-TrafficTypeDiagnostic: DM5PR12MB2344:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2344749040EBA240E4794967E8F39@DM5PR12MB2344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:210;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gkd+7geSIvrCypP1QalGSayPBECa9KKHQOR7vNR5plE/Jgb0ixKsRib3LGPiI254fW/Bw5eVSVbH8+Vkb2mm63/odXG4jb2tYCTFdiwO/gLx395x4A7p4rqhOBwjI1uJ/5+EEzlT5E8cVr//Z+d6KYaJYoLYrUNJ/+4qaOkDC+OAfv4jxiTOYknhNo7sOaLe63UDI9XR3NivhxgIGyCkSppeB7vdqqNT9cxmibrG3huPAz52ViAkBgOBtP9pbBHlsvSvOL1aZd6MShyfOGB4ZznAZwRgTv7oijj+1dsAhSL/zy5xjH+t6v/lOz+5rQPS32XpTG5Kfh9dLSjyuT75aqaSWWqfS1RPvmxOoK3P1fbc1dFIE7LpEoUcR+fojpi5FpB31/C/xTv1EvupZMYYQxWUBltnJTTh2an/b8UxX6lEY7g5ApIMqVA4U78T06K1y/NTmdeV4kKSeJ/VU1xIEC8vNtY8/zs+AX8uikjzPWRXcnncs0Lu2k8W+prETQEdUX4b4w3SIT9QM/sUE0QarTW/+sBT95kBseTgUQq3AOAh/Q3/r950Z/G/pTdx+mGirkgyiugGbmU6E54pbtF6EW33L/N4IqEgEvApE29OsVLPc8x+yT14wzXM+WLq1NoSXJG6jwdmkxFuDDp7XBOCkZzNZYrhnQyLEa/VPsLHrAmf7P6Q0iVFb0SXzMWaww1g3zXG4XUagT/WzaTb/4o+3cTIzhQJh1yyAPhbNM65SAM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(36840700001)(4326008)(5660300002)(30864003)(70206006)(336012)(6666004)(7696005)(70586007)(1076003)(478600001)(426003)(26005)(82740400003)(8936002)(36756003)(54906003)(2906002)(81166007)(2616005)(83380400001)(186003)(356005)(47076005)(36860700001)(8676002)(110136005)(16526019)(82310400003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 07:04:21.2488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640ff3c2-b860-4c78-257d-08d958a86a75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2344
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On newer heterogeneous systems from AMD with GPU nodes interfaced
with HBM2 memory are connected to the CPUs via custom links.

This patch modifies the amd64_edac module to handle the HBM memory
enumeration leveraging the existing edac and the amd64 specific data
structures.

This patch does the following for non-cpu nodes:
1. Define PCI IDs and ops for Aldeberarn GPUs in family_types array.
2. The UMC Phys on GPU nodes are enumerated as csrows and the UMC channels
   connected to HBMs are enumerated as ranks.
3. Define a function to find the UMCv2 channel number
4. Define a function to calculate base address of the UMCv2 registers
5. Add debug information for UMCv2 channel registers.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
Changes since v1:
1. Modifed the commit message
2. Change the edac_cap
3. kept sizes of both cpu and noncpu together
4. return success if the !F3 condition true and remove unnecessary validation
5. declared is_noncpu as bool
6. modified the condition from channel/4 to channel>=4
7. Rearranged debug information for noncpu umcch registers

 drivers/edac/amd64_edac.c | 202 +++++++++++++++++++++++++++++++++-----
 drivers/edac/amd64_edac.h |  27 +++++
 2 files changed, 202 insertions(+), 27 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b03c33240238..2dd77a828394 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1979,6 +1979,9 @@ static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
 
 		if (umc_en_mask == dimm_ecc_en_mask)
 			edac_cap = EDAC_FLAG_SECDED;
+
+		if (pvt->is_noncpu)
+			edac_cap = EDAC_FLAG_SECDED;
 	} else {
 		bit = (pvt->fam > 0xf || pvt->ext_model >= K8_REV_F)
 			? 19
@@ -2037,6 +2040,9 @@ static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 {
 	int cs_mode = 0;
 
+	if (pvt->is_noncpu)
+		return CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
+
 	if (csrow_enabled(2 * dimm, ctrl, pvt))
 		cs_mode |= CS_EVEN_PRIMARY;
 
@@ -2056,6 +2062,15 @@ static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
 
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
@@ -2080,10 +2095,15 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
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
@@ -2108,6 +2128,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 					i, 1 << ((tmp >> 4) & 0x3));
 		}
 
+ dimm_size:
 		debug_display_dimm_sizes_df(pvt, i);
 	}
 
@@ -2175,10 +2196,14 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
 	} else if (pvt->fam >= 0x17) {
 		int umc;
-
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
@@ -2187,6 +2212,31 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
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
+			if (!amd_smn_read(pvt->mc_node_id, base_reg, base))
+				edac_dbg(0, "  DCSB%d[%d]=0x%08x reg: 0x%x\n",
+					 umc, cs, *base, base_reg);
+
+			mask_reg = get_noncpu_umc_base(umc, cs) + UMCCH_ADDR_MASK;
+			mask = &pvt->csels[umc].csmasks[cs];
+
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask))
+				edac_dbg(0, "  DCSM%d[%d]=0x%08x reg: 0x%x\n",
+					 umc, cs, *mask, mask_reg);
+		}
+	}
+}
+
 static void read_umc_base_mask(struct amd64_pvt *pvt)
 {
 	u32 umc_base_reg, umc_base_reg_sec;
@@ -2247,8 +2297,12 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 
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
@@ -2294,6 +2348,10 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 	u32 dram_ctrl, dcsm;
 
 	if (pvt->umc) {
+		if (pvt->is_noncpu) {
+			pvt->dram_type = MEM_HBM2;
+			return;
+		}
 		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
 			pvt->dram_type = MEM_LRDDR4;
 		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
@@ -2683,7 +2741,10 @@ static int f17_early_channel_count(struct amd64_pvt *pvt)
 
 	/* SDP Control bit 31 (SdpInit) is clear for unused UMC channels */
 	for_each_umc(i)
-		channels += !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
+		if (pvt->is_noncpu)
+			channels += pvt->csels[i].b_cnt;
+		else
+			channels += !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
 
 	amd64_info("MCT channel count: %d\n", channels);
 
@@ -2824,6 +2885,12 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
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
@@ -2849,6 +2916,7 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	else
 		addr_mask_orig = pvt->csels[umc].csmasks[dimm];
 
+ skip_noncpu:
 	/*
 	 * The number of zero bits in the mask is equal to the number of bits
 	 * in a full mask minus the number of bits in the current mask.
@@ -3594,6 +3662,16 @@ static struct amd64_family_type family_types[] = {
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
@@ -3849,6 +3927,19 @@ static int find_umc_channel(struct mce *m)
 	return (m->ipid & GENMASK(31, 0)) >> 20;
 }
 
+/*
+ * The HBM memory managed by the UMCCH of the noncpu node
+ * can be calculated based on the [15:12]bits of IPID as follows
+ */
+static int find_umc_channel_noncpu(struct mce *m)
+{
+	u8 umc, ch;
+
+	umc = find_umc_channel(m);
+	ch = ((m->ipid >> 12) & 0xf);
+	return umc % 2 ? (ch + 4) : ch;
+}
+
 static void decode_umc_error(int node_id, struct mce *m)
 {
 	u8 ecc_type = (m->status >> 45) & 0x3;
@@ -3856,6 +3947,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 	struct amd64_pvt *pvt;
 	struct err_info err;
 	u64 sys_addr = m->addr;
+	u8 umc_num;
 
 	mci = edac_mc_find(node_id);
 	if (!mci)
@@ -3868,7 +3960,17 @@ static void decode_umc_error(int node_id, struct mce *m)
 	if (m->status & MCI_STATUS_DEFERRED)
 		ecc_type = 3;
 
-	err.channel = find_umc_channel(m);
+	if (pvt->is_noncpu) {
+		/* The UMCPHY is reported as csrow in case of noncpu nodes */
+		err.csrow = find_umc_channel(m) / 2;
+		/* UMCCH is managing the HBM memory */
+		err.channel = find_umc_channel_noncpu(m);
+		umc_num = err.csrow * 8 + err.channel;
+	} else {
+		err.channel = find_umc_channel(m);
+		err.csrow = m->synd & 0x7;
+		umc_num = err.channel;
+	}
 
 	if (!(m->status & MCI_STATUS_SYNDV)) {
 		err.err_code = ERR_SYND;
@@ -3884,9 +3986,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 			err.err_code = ERR_CHANNEL;
 	}
 
-	err.csrow = m->synd & 0x7;
-
-	if (umc_normaddr_to_sysaddr(&sys_addr, pvt->mc_node_id, err.channel)) {
+	if (umc_normaddr_to_sysaddr(&sys_addr, pvt->mc_node_id, umc_num)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
 	}
@@ -4013,15 +4113,20 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 
 	/* Read registers from each UMC */
 	for_each_umc(i) {
+		if (pvt->is_noncpu)
+			umc_base = get_noncpu_umc_base(i, 0);
+		else
+			umc_base = get_umc_base(i);
 
-		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
-
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
 
@@ -4103,7 +4208,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	determine_memory_type(pvt);
 	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
 
-	determine_ecc_sym_sz(pvt);
+	/* ECC symbol size is not available on NONCPU nodes */
+	if (!pvt->is_noncpu)
+		determine_ecc_sym_sz(pvt);
 }
 
 /*
@@ -4191,15 +4298,21 @@ static int init_csrows_df(struct mem_ctl_info *mci)
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
@@ -4464,7 +4577,9 @@ static bool ecc_enabled(struct amd64_pvt *pvt)
 
 			umc_en_mask |= BIT(i);
 
-			if (umc->umc_cap_hi & UMC_ECC_ENABLED)
+			/* ECC is enabled by default on NONCPU nodes */
+			if (pvt->is_noncpu ||
+			    (umc->umc_cap_hi & UMC_ECC_ENABLED))
 				ecc_en_mask |= BIT(i);
 		}
 
@@ -4500,6 +4615,11 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
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
@@ -4530,7 +4650,11 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
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
@@ -4635,11 +4759,24 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
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
@@ -4707,9 +4844,10 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	if (pvt->channel_count < 0)
 		return ret;
 
+	/* Define layers for CPU and NONCPU nodes */
 	ret = -ENOMEM;
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = pvt->csels[0].b_cnt;
+	layers[0].size = pvt->is_noncpu ? fam_type->max_mcs : pvt->csels[0].b_cnt;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 
@@ -4718,7 +4856,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	 * only one channel. Also, this simplifies handling later for the price
 	 * of a couple of KBs tops.
 	 */
-	layers[1].size = fam_type->max_mcs;
+	layers[1].size = pvt->is_noncpu ? pvt->csels[0].b_cnt : fam_type->max_mcs;
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
@@ -4763,6 +4901,9 @@ static int probe_one_instance(unsigned int nid)
 	struct ecc_settings *s;
 	int ret;
 
+	if (!F3)
+		return 0;
+
 	ret = -ENOMEM;
 	s = kzalloc(sizeof(struct ecc_settings), GFP_KERNEL);
 	if (!s)
@@ -4774,6 +4915,9 @@ static int probe_one_instance(unsigned int nid)
 	if (!pvt)
 		goto err_settings;
 
+	if (nid >= NONCPU_NODE_INDEX)
+		pvt->is_noncpu = true;
+
 	pvt->mc_node_id	= nid;
 	pvt->F3 = F3;
 
@@ -4847,6 +4991,10 @@ static void remove_one_instance(unsigned int nid)
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
index 85aa820bc165..c5532a6f0c34 100644
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
@@ -410,6 +416,27 @@ struct err_info {
 	u32 offset;
 };
 
+static inline u32 get_noncpu_umc_base(u8 umc, u8 channel)
+{
+	/*
+	 * On the NONCPU nodes, base address is calculated based on
+	 * UMC channel and the HBM channel.
+	 *
+	 * UMC channels are selected in 6th nibble
+	 * UMC chY[3:0]= [(chY*2 + 1) : (chY*2)]50000;
+	 *
+	 * HBM channels are selected in 3rd nibble
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

