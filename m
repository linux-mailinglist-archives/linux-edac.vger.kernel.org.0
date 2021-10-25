Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB068439951
	for <lists+linux-edac@lfdr.de>; Mon, 25 Oct 2021 16:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhJYOy3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Oct 2021 10:54:29 -0400
Received: from mail-bn8nam11on2052.outbound.protection.outlook.com ([40.107.236.52]:28097
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233327AbhJYOy0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 25 Oct 2021 10:54:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFZQSx4DEB8ZXqisOIAVYkHCJUFbw+KmGOvf89H0nsPh4jZBek/yrbv+/VPKLp0OCw8ysYtH2W/lnWx9EMeu43TcO40hWQQ06XwcUuW921Jtd3Bk+QX7UUKRu0ceOZVoEGvQ3r7HFPW0x7EjjfybYiFeHKBUfgKCGftkmMy3bdxMF6zJzsQkYzhmM3FWlWDXR60+VSJ6SQ+kmBspEMtg3ZASYZsvTJf9bTJ9yvteqvX9FoVif4oWz3WYTIL4eUVGqV88LujvrTPHNsle3l9fdpqM55GoZf3OMapT8fdR2sCowTdy4KhxUUWPWaij+ezsdTbOydd1xQqPiKUqXToyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh4WqSdB2L6qHWIiEQqlsx2CadvKUB8J2Fn/abpVpn0=;
 b=QyVEOg56FukaiccuK413mSDuTPmZJ3B24XahICrfU62Y3FOUkAVcStDzVUSjAeEDRW6Cgkxnk3UEanIjjPVHGZvDuJ28Fr+8m7q4E5/6ihepMUEaTqhaYl770fXQPLPtRMWRqOb21W++a8HX002NBZqH/PIGMjOCHGTRUFKKrpZmSsIHHmvKLlzTrmzA8M2dk6SpkcQyBCKEqzEzjehcDSIBp23mFR/UBJSKGIW8Yp+XFzRVK+qV06KOeLVHgLJu7Ia4oAW2Bwn5BTV2B6uJMJAmvdq8+WXeCdLIdMmHT6yobL+Lcw/nh0QQB1eNEpxrkCZdpTnDHRcCjG9OMQGTCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lh4WqSdB2L6qHWIiEQqlsx2CadvKUB8J2Fn/abpVpn0=;
 b=tb6VfwzMNKL3QME5qApn1KFiIHC4/oBkimTP2PEWVkSDcUR4Ji3FJ/BwfA1MDpSz5BXi/i7L1E9CThjX5eXKaG3f7dOkinJ238GGMacu7Xqnu6jpSiAyUBZMckdu+XaHvJkNEI16ttxp/Hlo1UTT+2iabRMZc/TsI39bKpU173c=
Received: from MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::17)
 by CY4PR12MB1447.namprd12.prod.outlook.com (2603:10b6:910:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 14:52:01 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::3c) by MW4P222CA0012.outlook.office365.com
 (2603:10b6:303:114::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 14:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 14:52:00 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 09:51:53 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH v5 5/5] EDAC/amd64: Enumerate memory on Aldebaran GPU nodes
Date:   Mon, 25 Oct 2021 20:20:18 +0530
Message-ID: <20211025145018.29985-6-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1a09c84f-6df9-425c-b78d-08d997c7006e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1447:
X-Microsoft-Antispam-PRVS: <CY4PR12MB14474491A5235BA24846141DE8839@CY4PR12MB1447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPGBhhco/kvaVHilWhznTENTVj3Hq+8u2jfQMK7fUmilwxYAs3mCNolo5HV0ryHUMCbthr7bHAi/VQDsspmjJcQbJQvfJsDhUETaCWle/VOYqaTwmUAhZmZQ5SCqMrCClL76/dTf9TzNc3oM4DV4/POVmJBaQr/zr5IqUSg9+HSZl9w60J48WbUSaCocVzT12QawzaRU40QlFATo+vjMD3UGoMUB1sgfMdHkBl98ekx5ABebWynoLG13lDSm2HWvnWp9V+cjmG0rsrvMyb78ewejm7KCGCduhRwj2+Nz9sTkmP2vqOMMWJlorV9cGIbLbDM7hT34TDAyGSw7M8TQF+Ep7rCfJN71+Xy5g4jMCZGpuY4rLjs8YQ9JMhbb0ObzKkWGw6Rp6RxhT/hcqEmyN9JDaZ2JSxVGubng1oHQyShNV4JJlLY7zuQUn5QTr0G5gvITwChBplDV5Hm9zJU5Ra8U/dg5Va1k2yg92ghSRSZ1OOdMlUXz6aKQrqq3u9/vgn2OaDNT8COqWjnQez4lDQnNaHraeXZBBnkM+w2RTj7JAdRgCqomjT27Vfhb+5m3S2GnmZDuM5Jnrs4X1YgdZ2ggG7DuQzJrj54IvaLXikfPhtakUh4Ooewu/ys8cyGr+fYQGuChHMP6bbYA4a5n04+5fc1lGhrxXZ9MYM5/tzyVhhU/qf0YH0vhaZu/PlpS49ZbcNj0vH0K1MZRIaYknuMvatUjbTzPLPFYkLHEH3PUCdjmIxN7f9j+5Vp7E5tkpV7XYghD2DchvDI/78m2PsI9ag4rzhqPrfp8CY98gCc+VB0Fnlc7I4YE9h4dTnOf
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(6666004)(70206006)(70586007)(508600001)(316002)(356005)(36756003)(36860700001)(966005)(83380400001)(4326008)(30864003)(110136005)(186003)(54906003)(2906002)(8936002)(336012)(26005)(5660300002)(16526019)(8676002)(47076005)(1076003)(82310400003)(7696005)(2616005)(426003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 14:52:00.9558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a09c84f-6df9-425c-b78d-08d997c7006e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1447
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On newer heterogeneous systems with AMD CPUs, the data fabrics of the GPUs
are connected directly via custom links.

One such system, where Aldebaran GPU nodes are connected to the
Family 19h, model 30h family of CPU nodes, the Aldebaran GPUs can report
memory errors via SMCA banks.

Aldebaran GPU support was added to DRM framework
https://lists.freedesktop.org/archives/amd-gfx/2021-February/059694.html

The GPU nodes comes with HBM2 memory in-built, ECC support is enabled by
default and the UMCs on GPU node are different from the UMCs on CPU nodes.

GPU specific ops routines are defined to extend the amd64_edac
module to enumerate HBM memory leveraging the existing edac and the
amd64 specific data structures.

Note: The UMC Phys on GPU nodes are enumerated as csrows and the UMC
channels connected to HBM banks are enumerated as ranks.

Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Co-developed-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Link: https://lkml.kernel.org/r/20210823185437.94417-4-nchatrad@amd.com
---
Changes since v4:
 Split "f17_addr_mask_to_cs_size" instead as did in 3rd patch earlier

Changes since v3:
1. Bifurcated the GPU code from v2

Changes since v2:
1. Restored line deletions and handled minor comments
2. Modified commit message and some of the function comments
3. variable df_inst_id is introduced instead of umc_num

Changes since v1:
1. Modifed the commit message
2. Change the edac_cap
3. kept sizes of both cpu and noncpu together
4. return success if the !F3 condition true and remove unnecessary validation

 drivers/edac/amd64_edac.c | 302 +++++++++++++++++++++++++++++++++-----
 drivers/edac/amd64_edac.h |  27 ++++
 2 files changed, 293 insertions(+), 36 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fbb1284f3c18..a0dc7ffe63d6 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1121,6 +1121,20 @@ static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
 	}
 }
 
+static void debug_display_dimm_sizes_gpu(struct amd64_pvt *pvt, u8 ctrl)
+{
+	int size, cs = 0, cs_mode;
+
+	edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
+
+	cs_mode = CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
+
+	for_each_chip_select(cs, ctrl, pvt) {
+		size = pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs);
+		amd64_info(EDAC_MC ": %d: %5dMB\n", cs, size);
+	}
+}
+
 static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 {
 	struct amd64_umc *umc;
@@ -1165,6 +1179,27 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 		 pvt->dhar, dhar_base(pvt));
 }
 
+static void __dump_misc_regs_gpu(struct amd64_pvt *pvt)
+{
+	struct amd64_umc *umc;
+	u32 i, umc_base;
+
+	for_each_umc(i) {
+		umc_base = get_umc_base(i);
+		umc = &pvt->umc[i];
+
+		edac_dbg(1, "UMC%d UMC cfg: 0x%x\n", i, umc->umc_cfg);
+		edac_dbg(1, "UMC%d SDP ctrl: 0x%x\n", i, umc->sdp_ctrl);
+		edac_dbg(1, "UMC%d ECC ctrl: 0x%x\n", i, umc->ecc_ctrl);
+		edac_dbg(1, "UMC%d All HBMs support ECC: yes\n", i);
+
+		debug_display_dimm_sizes_gpu(pvt, i);
+	}
+
+	edac_dbg(1, "F0x104 (DRAM Hole Address): 0x%08x, base: 0x%08x\n",
+		 pvt->dhar, dhar_base(pvt));
+}
+
 /* Display and decode various NB registers for debug purposes. */
 static void __dump_misc_regs(struct amd64_pvt *pvt)
 {
@@ -1245,6 +1280,43 @@ static void f17_prep_chip_selects(struct amd64_pvt *pvt)
 	}
 }
 
+static void gpu_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	int umc;
+
+	for_each_umc(umc) {
+		pvt->csels[umc].b_cnt = 8;
+		pvt->csels[umc].m_cnt = 8;
+	}
+}
+
+static void read_umc_base_mask_gpu(struct amd64_pvt *pvt)
+{
+	u32 base_reg, mask_reg;
+	u32 *base, *mask;
+	int umc, cs;
+
+	for_each_umc(umc) {
+		for_each_chip_select(cs, umc, pvt) {
+			base_reg = get_umc_base_gpu(umc, cs) + UMCCH_BASE_ADDR;
+			base = &pvt->csels[umc].csbases[cs];
+
+			if (!amd_smn_read(pvt->mc_node_id, base_reg, base)) {
+				edac_dbg(0, "  DCSB%d[%d]=0x%08x reg: 0x%x\n",
+					 umc, cs, *base, base_reg);
+			}
+
+			mask_reg = get_umc_base_gpu(umc, cs) + UMCCH_ADDR_MASK;
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
@@ -1743,6 +1815,19 @@ static int f17_early_channel_count(struct amd64_pvt *pvt)
 	return channels;
 }
 
+static int gpu_early_channel_count(struct amd64_pvt *pvt)
+{
+	int i, channels = 0;
+
+	/* The memory channels in case of GPUs are fully populated */
+	for_each_umc(i)
+		channels += pvt->csels[i].b_cnt;
+
+	amd64_info("MCT channel count: %d\n", channels);
+
+	return channels;
+}
+
 static int ddr3_cs_size(unsigned i, bool dct_width)
 {
 	unsigned shift = 0;
@@ -1870,11 +1955,46 @@ static int f16_dbam_to_chip_select(struct amd64_pvt *pvt, u8 dct,
 		return ddr3_cs_size(cs_mode, false);
 }
 
+static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
+				  int csrow_nr, int dimm)
+{
+	u32 msb, weight, num_zero_bits;
+	u32 addr_mask_deinterleaved;
+	int size = 0;
+
+	/*
+	 * The number of zero bits in the mask is equal to the number of bits
+	 * in a full mask minus the number of bits in the current mask.
+	 *
+	 * The MSB is the number of bits in the full mask because BIT[0] is
+	 * always 0.
+	 *
+	 * In the special 3 Rank interleaving case, a single bit is flipped
+	 * without swapping with the most significant bit. This can be handled
+	 * by keeping the MSB where it is and ignoring the single zero bit.
+	 */
+	msb = fls(addr_mask_orig) - 1;
+	weight = hweight_long(addr_mask_orig);
+	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
+
+	/* Take the number of zero bits off from the top of the mask. */
+	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
+
+	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
+	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
+	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
+
+	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
+	size = (addr_mask_deinterleaved >> 2) + 1;
+
+	/* Return size in MBs. */
+	return size >> 10;
+}
+
 static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
-	u32 addr_mask_orig, addr_mask_deinterleaved;
-	u32 msb, weight, num_zero_bits;
+	u32 addr_mask_orig;
 	int dimm, size = 0;
 
 	/* No Chip Selects are enabled. */
@@ -1902,33 +2022,15 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	else
 		addr_mask_orig = pvt->csels[umc].csmasks[dimm];
 
-	/*
-	 * The number of zero bits in the mask is equal to the number of bits
-	 * in a full mask minus the number of bits in the current mask.
-	 *
-	 * The MSB is the number of bits in the full mask because BIT[0] is
-	 * always 0.
-	 *
-	 * In the special 3 Rank interleaving case, a single bit is flipped
-	 * without swapping with the most significant bit. This can be handled
-	 * by keeping the MSB where it is and ignoring the single zero bit.
-	 */
-	msb = fls(addr_mask_orig) - 1;
-	weight = hweight_long(addr_mask_orig);
-	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
-
-	/* Take the number of zero bits off from the top of the mask. */
-	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
-
-	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
-	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
-	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
+	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, dimm);
+}
 
-	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
-	size = (addr_mask_deinterleaved >> 2) + 1;
+static int gpu_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
+				    unsigned int cs_mode, int csrow_nr)
+{
+	u32 addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
 
-	/* Return size in MBs. */
-	return size >> 10;
+	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, csrow_nr >> 1);
 }
 
 static void read_dram_ctl_register(struct amd64_pvt *pvt)
@@ -2516,8 +2618,11 @@ static void debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 /* Prototypes for family specific ops routines */
 static int init_csrows(struct mem_ctl_info *mci);
 static int init_csrows_df(struct mem_ctl_info *mci);
+static int init_csrows_gpu(struct mem_ctl_info *mci);
 static void __read_mc_regs_df(struct amd64_pvt *pvt);
+static void __read_mc_regs_gpu(struct amd64_pvt *pvt);
 static void update_umc_err_info(struct mce *m, struct err_info *err);
+static void update_umc_err_info_gpu(struct mce *m, struct err_info *err);
 
 static const struct low_ops k8_ops = {
 	.early_channel_count	= k8_early_channel_count,
@@ -2590,6 +2695,17 @@ static const struct low_ops f17_ops = {
 	.get_umc_err_info	= update_umc_err_info,
 };
 
+static const struct low_ops gpu_ops = {
+	.early_channel_count	= gpu_early_channel_count,
+	.dbam_to_cs		= gpu_addr_mask_to_cs_size,
+	.prep_chip_select	= gpu_prep_chip_selects,
+	.get_base_mask		= read_umc_base_mask_gpu,
+	.display_misc_regs	= __dump_misc_regs_gpu,
+	.get_mc_regs		= __read_mc_regs_gpu,
+	.populate_csrows	= init_csrows_gpu,
+	.get_umc_err_info	= update_umc_err_info_gpu,
+};
+
 static struct amd64_family_type family_types[] = {
 	[K8_CPUS] = {
 		.ctl_name = "K8",
@@ -2682,6 +2798,14 @@ static struct amd64_family_type family_types[] = {
 		.max_mcs = 8,
 		.ops = f17_ops,
 	},
+	[ALDEBARAN_GPUS] = {
+		.ctl_name = "ALDEBARAN",
+		.f0_id = PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0,
+		.f6_id = PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6,
+		.max_mcs = 4,
+		.ops = gpu_ops,
+	},
+
 };
 
 /*
@@ -2940,12 +3064,38 @@ static void update_umc_err_info(struct mce *m, struct err_info *err)
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
+static void update_umc_err_info_gpu(struct mce *m, struct err_info *err)
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
@@ -2975,7 +3125,17 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	pvt->ops->get_umc_err_info(m, &err);
 
-	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
+	/*
+	 * GPU node has #phys[X] which has #channels[Y] each.
+	 * On GPUs, df_inst_id = [X] * num_ch_per_phy + [Y].
+	 * On CPUs, "Channel"="UMC Number"="DF Instance ID".
+	 */
+	if (pvt->is_gpu)
+		df_inst_id = (err.csrow * pvt->channel_count / mci->nr_csrows) + err.channel;
+	else
+		df_inst_id = err.channel;
+
+	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, df_inst_id, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
 	}
@@ -3114,6 +3274,23 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 	}
 }
 
+static void __read_mc_regs_gpu(struct amd64_pvt *pvt)
+{
+	u8 nid = pvt->mc_node_id;
+	struct amd64_umc *umc;
+	u32 i, umc_base;
+
+	/* Read registers from each UMC */
+	for_each_umc(i) {
+		umc_base = get_umc_base_gpu(i, 0);
+		umc = &pvt->umc[i];
+
+		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
+		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
+		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
+	}
+}
+
 /*
  * Retrieve the hardware registers of the memory controller (this includes the
  * 'Address Map' and 'Misc' device regs)
@@ -3196,7 +3373,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	determine_memory_type(pvt);
 	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
 
-	determine_ecc_sym_sz(pvt);
+	/* ECC symbol size is not available on GPU nodes */
+	if (!pvt->is_gpu)
+		determine_ecc_sym_sz(pvt);
 }
 
 /*
@@ -3243,7 +3422,10 @@ static u32 get_csrow_nr_pages(struct amd64_pvt *pvt, u8 dct, int csrow_nr_orig)
 		csrow_nr >>= 1;
 		cs_mode = DBAM_DIMM(csrow_nr, dbam);
 	} else {
-		cs_mode = f17_get_cs_mode(csrow_nr >> 1, dct, pvt);
+		if (pvt->is_gpu)
+			cs_mode = CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
+		else
+			cs_mode = f17_get_cs_mode(csrow_nr >> 1, dct, pvt);
 	}
 
 	nr_pages   = pvt->ops->dbam_to_cs(pvt, dct, cs_mode, csrow_nr);
@@ -3300,6 +3482,35 @@ static int init_csrows_df(struct mem_ctl_info *mci)
 	return empty;
 }
 
+static int init_csrows_gpu(struct mem_ctl_info *mci)
+{
+	struct amd64_pvt *pvt = mci->pvt_info;
+	struct dimm_info *dimm;
+	int empty = 1;
+	u8 umc, cs;
+
+	for_each_umc(umc) {
+		for_each_chip_select(cs, umc, pvt) {
+			if (!csrow_enabled(cs, umc, pvt))
+				continue;
+
+			empty = 0;
+			dimm = mci->csrows[umc]->channels[cs]->dimm;
+
+			edac_dbg(1, "MC node: %d, csrow: %d\n",
+				 pvt->mc_node_id, cs);
+
+			dimm->nr_pages = get_csrow_nr_pages(pvt, umc, cs);
+			dimm->mtype = MEM_HBM2;
+			dimm->edac_mode = EDAC_SECDED;
+			dimm->dtype = DEV_X16;
+			dimm->grain = 64;
+		}
+	}
+
+	return empty;
+}
+
 /*
  * Initialize the array of csrow attribute instances, based on the values
  * from pci config hardware registers.
@@ -3541,6 +3752,10 @@ static bool ecc_enabled(struct amd64_pvt *pvt)
 	u8 ecc_en = 0, i;
 	u32 value;
 
+	/* ECC is enabled by default on GPU nodes */
+	if (pvt->is_gpu)
+		return true;
+
 	if (boot_cpu_data.x86 >= 0x17) {
 		u8 umc_en_mask = 0, ecc_en_mask = 0;
 		struct amd64_umc *umc;
@@ -3624,7 +3839,10 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 	mci->edac_ctl_cap	= EDAC_FLAG_NONE;
 
 	if (pvt->umc) {
-		f17h_determine_edac_ctl_cap(mci, pvt);
+		if (pvt->is_gpu)
+			mci->edac_ctl_cap |= EDAC_FLAG_SECDED;
+		else
+			f17h_determine_edac_ctl_cap(mci, pvt);
 	} else {
 		if (pvt->nbcap & NBCAP_SECDED)
 			mci->edac_ctl_cap |= EDAC_FLAG_SECDED;
@@ -3726,10 +3944,21 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 			pvt->ops = &family_types[F17_M70H_CPUS].ops;
 			pvt->fam_type->ctl_name = "F19h_M20h";
 			break;
+		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
+			if (pvt->mc_node_id >= amd_cpu_node_count()) {
+				pvt->fam_type = &family_types[ALDEBARAN_GPUS];
+				pvt->ops = &family_types[ALDEBARAN_GPUS].ops;
+				pvt->is_gpu = true;
+			} else {
+				pvt->fam_type = &family_types[F19_CPUS];
+				pvt->ops = &family_types[F19_CPUS].ops;
+				family_types[F19_CPUS].ctl_name = "F19h_M30h";
+			}
+		} else {
+			pvt->fam_type	= &family_types[F19_CPUS];
+			pvt->ops	= &family_types[F19_CPUS].ops;
+			family_types[F19_CPUS].ctl_name = "F19h";
 		}
-		pvt->fam_type	= &family_types[F19_CPUS];
-		pvt->ops	= &family_types[F19_CPUS].ops;
-		family_types[F19_CPUS].ctl_name = "F19h";
 		break;
 
 	default:
@@ -3811,9 +4040,10 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	if (pvt->channel_count < 0)
 		return ret;
 
+	/* Define layers for CPU and GPU nodes */
 	ret = -ENOMEM;
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = pvt->csels[0].b_cnt;
+	layers[0].size = pvt->is_gpu ? pvt->fam_type->max_mcs : pvt->csels[0].b_cnt;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 
@@ -3822,7 +4052,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	 * only one channel. Also, this simplifies handling later for the price
 	 * of a couple of KBs tops.
 	 */
-	layers[1].size = pvt->fam_type->max_mcs;
+	layers[1].size = pvt->is_gpu ? pvt->csels[0].b_cnt : pvt->fam_type->max_mcs;
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index d307df58ea1b..82723ae88d2e 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -126,6 +126,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
 #define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
 #define PCI_DEVICE_ID_AMD_19H_DF_F6	0x1656
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0 0x14d0
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6 0x14d6
 
 /*
  * Function 1 - Address Map
@@ -298,6 +300,7 @@ enum amd_families {
 	F17_M60H_CPUS,
 	F17_M70H_CPUS,
 	F19_CPUS,
+	ALDEBARAN_GPUS,
 	NUM_FAMILIES,
 };
 
@@ -391,6 +394,8 @@ struct amd64_pvt {
 	struct amd64_umc *umc;	/* UMC registers */
 
 	struct amd64_family_type *fam_type;
+
+	bool is_gpu;
 };
 
 enum err_codes {
@@ -412,6 +417,28 @@ struct err_info {
 	u32 offset;
 };
 
+static inline u32 get_umc_base_gpu(u8 umc, u8 channel)
+{
+	/*
+	 * On CPUs, there is one channel per UMC, so UMC numbering equals
+	 * channel numbering. On GPUs, there are eight channels per UMC,
+	 * so the channel numbering is different from UMC numbering.
+	 *
+	 * On CPU nodes channels are selected in 6th nibble
+	 * UMC chY[3:0]= [(chY*2 + 1) : (chY*2)]50000;
+	 *
+	 * On GPU nodes channels are selected in 3rd nibble
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

