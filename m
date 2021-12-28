Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592AE480CF3
	for <lists+linux-edac@lfdr.de>; Tue, 28 Dec 2021 21:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbhL1UGh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Dec 2021 15:06:37 -0500
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com ([40.107.244.53]:26017
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237251AbhL1UGg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 28 Dec 2021 15:06:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAfwEYxGC21Vw4CCSVV6y71hpOkZdAo72Kq4Pm1RDKzjdIp12NSKFzpS65qnryEP0RTMJGb1fvwVQlhKAA7s2twq1lZc1dGnHQ1P1J0IJ7XIhlx7u9owhUlFT+zVzg+upqVeNEBTskWFDbrJeqNNtPw+eIa4tx49u4fxEdOP8KQUxaq5EhU2A93DqXkWamd32KE+m5d3nlOIBr5nwB3XKYCHxL5u5cO4w/RbmKqmeU2MUxUJtAzcDWFFHUVFyHMpe6pRU/7lE9w56kDaM+Tsc/DnYk5NlF3K4H9IDByYAfz7amO1OTX32L0dy1KZrHocbDk1ghyzH0c/rdSuv9Z4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+1V9ZGW4tLEjx4wCi8W8t4gvr0f/96HmQ3VH/n0ASM=;
 b=GbxFZtLIJ6WzVBQzn54QXcs3dpbwAIbg4wfw96NQNtk2XUdMKBdRQLJQcuBBjCB8WAvToYFrQdHCdUh+1OIGvKC4b2OBKNmrlZ3GFFzOHFcY7204GhY0MhKzObAJHLzHzkchBRcCMloE5ga+E3jjmQXQjXt6dVMEEME9LNY9XWen4NYwjgTZBsklcqPDY0/PVQPpufORIfCMfybRXjpZErlOPOo2QOfa+IzizZC6phqxU/fpA1fzeZXPB+x9pG1eZ8KISk0+761KxILCMlo20hVA3HjM7w+gutYWJxMsbhM+vZEhD+qB9Qm+VCy4FLHUAbVRl3fqLmNv1oUdyiYO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+1V9ZGW4tLEjx4wCi8W8t4gvr0f/96HmQ3VH/n0ASM=;
 b=IAoZNLVG6Dac44LfHX+S7D7m+xC1cuh0zfaw33NP+ymWqWTRKCfKzs5CZSrcWKPHal7DDZwvFqMEew1bAUxoXRWXp8071fHZwurcVu7Bsx6fy+aFUTdUEHvJ0gtw5fKQDJSDFuP4NnpR66eJ0zkBDTUYPTfwUfU5Ure1qk9umwE=
Received: from BN0PR04CA0070.namprd04.prod.outlook.com (2603:10b6:408:ea::15)
 by CY4PR1201MB0184.namprd12.prod.outlook.com (2603:10b6:910:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Tue, 28 Dec
 2021 20:06:33 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::d3) by BN0PR04CA0070.outlook.office365.com
 (2603:10b6:408:ea::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Tue, 28 Dec 2021 20:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Tue, 28 Dec 2021 20:06:33 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 28 Dec
 2021 14:06:32 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH v3 2/2] EDAC/amd64: Add new register offset support and related changes
Date:   Tue, 28 Dec 2021 20:06:15 +0000
Message-ID: <20211228200615.412999-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211228200615.412999-1-yazen.ghannam@amd.com>
References: <20211228200615.412999-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c81223c-aa00-4882-1583-08d9ca3d8b99
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0184:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01849D5370932C1F35CDE62AF8439@CY4PR1201MB0184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdNGZosRns15Eay1JZ29UwCDsyhO/+NDt160mlYiUaggOQJkaPhhMqSCAIZQbKVEn/HHUWdHBLo1GlOcOZ65cCenIP/NYG3dBouocax++0zHPZwxo2HYLTMsOhqEVle1oVAmrpCfwat8rS68qRCKn6C+LC/pAUYmYj4l9V+w/sZoo+PdkabiasRl+BlGu65T9tYAoL7n0v8Psj+/NFY82lChPoWmOGgobCMOMsF/P+2Cu/U3DsvApilZBitemnLDRWUeA2SypaKGTkSjRTl55jloUNFWUxtyIzFvbJoY1xpj8fDjdMsDzzTVG/S2N/k2W9Y6AZ+Gt1VzwEogRVVAQbRTcODcAUGqr5sil4iQURaYWbZ04xaGcb9k4YfxzvbUlB+y944PGEZMNKHsfaHOd/XhZh45SRC6WJiKRDgH1WFDp9kM8Snf2+JpNeJFMxJmygaafH2Ibm/JY1vh7tbQTZ6En8/R+NWPrcRB3Q8ug/wbUJUN3wVqWkgy3ToocxCIOxhGxwvFlvbbxYPzuM6AxwnUCe3zwxdAYvfoSod+zPWEATtjjHVj8uPZayqGettII+DqQSndvT56LAiWyrYE90Z1W6QDbwJd58Ij7P783v/fMFYu4dZ00gmie5hkLUr8Xxwei55KDoI8SPpKMigKWGIbRqhxjg81ALnoctAcS09x8VSb1+I9skCLaXJTE0OQ+VcE9Bwwp2elJaMyIXG23L+RkyYjg8DSiCDrZLQJkk1YfItKbBIwOWk5TshyBHq4fmqx9k5D9EhOFdJw18Lv5BmyNZy2EJyFrnLThLTwZfW3Yuk/9zLu7iH/pcjzADXqq+YzsNaXUNbslVqFESP51kQgJ9sjsFmy3bBLflkAj/aw5CZz9kSb6xlCYp6v7y6J
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(1076003)(2616005)(40460700001)(6666004)(186003)(70206006)(83380400001)(82310400004)(36860700001)(336012)(316002)(426003)(6916009)(70586007)(54906003)(47076005)(36756003)(86362001)(7696005)(44832011)(356005)(26005)(81166007)(8676002)(8936002)(4326008)(2906002)(5660300002)(966005)(508600001)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2021 20:06:33.3048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c81223c-aa00-4882-1583-08d9ca3d8b99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0184
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

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20211215155309.2711917-3-yazen.ghannam@amd.com

v2->v3:
* Adjust variable names to explicitly show what they represent.
* Update code comment to give more detail on CS/MASK/DIMM layout.

v1->v2:
* Was patch 4 in v1.
* Change "has_ddr5" flag to "zn_regs_v2".
* Drop flag check helper function.
* Update determine_memory_type() to check bitfield for DDR5.
* Update code comments.

 drivers/edac/amd64_edac.c | 79 +++++++++++++++++++++++++++++++++------
 drivers/edac/amd64_edac.h | 14 +++++++
 2 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4db92c77276f..a299c361a904 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -15,6 +15,31 @@ static struct msr __percpu *msrs;
 
 static struct amd64_family_type *fam_type;
 
+/* Family flag helpers */
+static inline u64 get_addr_cfg(void)
+{
+	if (fam_type->flags.zn_regs_v2)
+		return UMCCH_ADDR_CFG_DDR5;
+
+	return UMCCH_ADDR_CFG;
+}
+
+static inline u64 get_addr_mask_sec(void)
+{
+	if (fam_type->flags.zn_regs_v2)
+		return UMCCH_ADDR_MASK_SEC_DDR5;
+
+	return UMCCH_ADDR_MASK_SEC;
+}
+
+static inline u64 get_dimm_cfg(void)
+{
+	if (fam_type->flags.zn_regs_v2)
+		return UMCCH_DIMM_CFG_DDR5;
+
+	return UMCCH_DIMM_CFG;
+}
+
 /* Per-node stuff */
 static struct ecc_settings **ecc_stngs;
 
@@ -1429,8 +1454,10 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
 				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
 
-		if (pvt->dram_type == MEM_LRDDR4) {
-			amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ADDR_CFG, &tmp);
+		if (pvt->dram_type == MEM_LRDDR4 || pvt->dram_type == MEM_LRDDR5) {
+			amd_smn_read(pvt->mc_node_id,
+				     umc_base + get_addr_cfg(),
+				     &tmp);
 			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
 					i, 1 << ((tmp >> 4) & 0x3));
 		}
@@ -1505,7 +1532,7 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 
 		for_each_umc(umc) {
 			pvt->csels[umc].b_cnt = 4;
-			pvt->csels[umc].m_cnt = 2;
+			pvt->csels[umc].m_cnt = fam_type->flags.zn_regs_v2 ? 4 : 2;
 		}
 
 	} else {
@@ -1545,7 +1572,7 @@ static void read_umc_base_mask(struct amd64_pvt *pvt)
 		}
 
 		umc_mask_reg = get_umc_base(umc) + UMCCH_ADDR_MASK;
-		umc_mask_reg_sec = get_umc_base(umc) + UMCCH_ADDR_MASK_SEC;
+		umc_mask_reg_sec = get_umc_base(umc) + get_addr_mask_sec();
 
 		for_each_chip_select_mask(cs, umc, pvt) {
 			mask = &pvt->csels[umc].csmasks[cs];
@@ -1618,6 +1645,20 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 
 static enum mem_type determine_memory_type_df(struct amd64_umc *umc)
 {
+	/*
+	 * Check if the system supports the "DDR Type" field in UMC Config
+	 * and has DDR5 DIMMs in use.
+	 */
+	if (fam_type->flags.zn_regs_v2 && ((umc->umc_cfg & GENMASK(2, 0)) == 0x1)) {
+		if (umc->dimm_cfg & BIT(5))
+			return MEM_LRDDR5;
+
+		if (umc->dimm_cfg & BIT(4))
+			return MEM_RDDR5;
+
+		return MEM_DDR5;
+	}
+
 	if (umc->dimm_cfg & BIT(5))
 		return MEM_LRDDR4;
 
@@ -2153,6 +2194,7 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 {
 	u32 addr_mask_orig, addr_mask_deinterleaved;
 	u32 msb, weight, num_zero_bits;
+	int cs_mask_nr = csrow_nr;
 	int dimm, size = 0;
 
 	/* No Chip Selects are enabled. */
@@ -2168,17 +2210,31 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
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
-	dimm = csrow_nr >> 1;
+	if (!fam_type->flags.zn_regs_v2)
+		cs_mask_nr >>= 1;
 
 	/* Asymmetric dual-rank DIMM support. */
 	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
-		addr_mask_orig = pvt->csels[umc].csmasks_sec[dimm];
+		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
 	else
-		addr_mask_orig = pvt->csels[umc].csmasks[dimm];
+		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
 
 	/*
 	 * The number of zero bits in the mask is equal to the number of bits
@@ -2934,6 +2990,7 @@ static struct amd64_family_type family_types[] = {
 		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F6,
 		.max_mcs = 12,
+		.flags.zn_regs_v2 = 1,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
@@ -3372,7 +3429,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + UMCCH_DIMM_CFG, &umc->dimm_cfg);
+		amd_smn_read(nid, umc_base + get_dimm_cfg(), &umc->dimm_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
 		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 352bda9803f6..4598a5cd0361 100644
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
@@ -480,11 +483,22 @@ struct low_ops {
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

