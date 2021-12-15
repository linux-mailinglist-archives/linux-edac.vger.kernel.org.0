Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31BF475C4D
	for <lists+linux-edac@lfdr.de>; Wed, 15 Dec 2021 16:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244208AbhLOPx7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Dec 2021 10:53:59 -0500
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:57466
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244199AbhLOPx6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Dec 2021 10:53:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG224ivbGPVjdn2thirLvh2b8cG7nYS3YPmPvCvh0GKDa1dM5eSpxuHvHaq4IYScd+TOQNqpf+WZ4lhB/ruVlyjD/C4tM5vC5seaNjirbvX2l5Zr1+awc+qqMjIoIMmHBgoovfE4AMhlkM97vf429Gbjyq+iBc69JRNIzPS+w64ADd6urSO5g1O1qSMF6i/VYhj4gS5X2sA8y/eCJ1DBYThiFIlzlLmt8vX4JCk3cEdjjMzg0G504xDLicZN+OeFKdhv5M4xLVgLAxxZRB6pg6kVOP+Tttic/H1aO8bSuSOJY7TB8rxsQCpwDnFOuz1Z2a982R66IOZqO5YNqMsUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcgOg1QhN9XlsVLPyfsom0Nl0AfmQOuSf9mEtgPjK/A=;
 b=NPljaO0PQy7t+xFz6Nxic2dHjsXr5iUy6wAvN2pYq/TOeWNCuB9+v2Prpk7jwOiYRrUb3m7Q6V3VCAFwGIKTpI6DEIOWV3i3yskv34TVlDHY+Nm5N0FYVD/Ng5FoWUGXLHbrTAr5cmZbrH96g0ahwbiKJNpbmjuNmuYONWTiXBo7oiCHQHmq2rEnhU9WJUnsnSnI5P6TheaBJsbwjNPx6WJtmhCowNqN3wI2esqQ32Oac8aGivPThxMsENhDsMOVuADVbEsmcl2m5bsop0WsrZz4Q0AQVUdZ+ytD03MXtNGgAzZ9gLSnBG5reUbE5TXkw34+ZVMXqL5sTkAwwVMYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcgOg1QhN9XlsVLPyfsom0Nl0AfmQOuSf9mEtgPjK/A=;
 b=ZLPeDTOYm0qWYn9GAcEld4nLqR2VB93bemVD78tC/PcGPXkk81lDp+69oF3EK4SoI4esn4XwNI9hAitEVrzfkoDN0zLiwBTda1xVcAwv2zfqpUpKWTr0hdLcAx0cxe8Bokbzt7jo6xDTJxneP0sS/k61UovRuiHu0V+Kr6Up95I=
Received: from BN9PR03CA0863.namprd03.prod.outlook.com (2603:10b6:408:13d::28)
 by DM6PR12MB3723.namprd12.prod.outlook.com (2603:10b6:5:1c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 15:53:56 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::13) by BN9PR03CA0863.outlook.office365.com
 (2603:10b6:408:13d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Wed, 15 Dec 2021 15:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 15:53:55 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 09:53:55 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH v2 2/2] EDAC/amd64: Add new register offset support and related changes
Date:   Wed, 15 Dec 2021 15:53:09 +0000
Message-ID: <20211215155309.2711917-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215155309.2711917-1-yazen.ghannam@amd.com>
References: <20211215155309.2711917-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2ecf879-7793-4f54-8d8f-08d9bfe319c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3723:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3723DBAAD2710DBF7CBCD382F8769@DM6PR12MB3723.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5yOMQqIPZuEIxgBug++Ne9grJn4ji7qFQPWdOSz2eJpr5/u+aTBQaiafhmg2iAGDXKc7IRsNDRxsEvrib2vzBd7hasWBUw7I5LPshARZq/qSLAtxxaDGt/7m58Ev3Kc9TB4KHov2Iy88wONwa4r8SYOh8vKWDbA3fH1JQdOxCLfa4sWykWt2USCdkT0QRjc/JwlMiG0iLxF95drU5pVciQieHMd5nGCmyKqEsBaQdNRhxwFSGNqQkrQ7ZvnXFTH2PMgy5bz4OPUcWjxcZ1Ij8hIq8H5eP8y+87d8bEZOawpzh8Lu2PTgMgJVq3oL1lC8KsEVcF8Kl5GxfK+B5u7NTfRnxsrfbMEXzCOxFkTjIzCo1XlZGYFWVNKrxv66e30eDbzWvxMgPT2cam57cxFYwE5w+bJU79i4D1yVrYUFJframupJ+v8TZkIZw9asRHe5t6vh1QFbCgeWygeLzOVFhzsDKZjZiua6PdVHD37fNQnxPw8LICCWNk6vxPrpbmVNUIIumHEIJuqaNQDtsh2qCEe0NCrybilFqMyrMrMi8bxxY6F6Q9ZTgVUjyfnyJBZXVS/288znH4xos3fuQIsEW9lnt1AqEzvuyQ1tEniodaNhOniHWPbxu5APeiybpy3MpeLE2Ls/mYq11YLbU1gSBd+K18Hkh+v5a9YSKT8YNur0sJV3D4iGp4n5uFhqhFkxlJbFpT6QFehCPCC0lkgoFSU///UFHeAk3A5hZq8zEyM1sUVARyPeDVjNV1dLhulL+a8oV/fiLAAgPkpQEx0zjI03QyEmzuqax8QnIkSDDTJzWD7YL4VbB0pZun2gtOLp315F5ZmlLumUxFIJ5ugUfsvWFsK3H43YndhCQmUyh+yeow18PvB0i/bzMq/12W43
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(7696005)(36756003)(508600001)(47076005)(26005)(4326008)(966005)(81166007)(36860700001)(6666004)(54906003)(426003)(83380400001)(356005)(86362001)(5660300002)(8676002)(44832011)(316002)(2616005)(40460700001)(2906002)(8936002)(186003)(16526019)(1076003)(6916009)(70586007)(70206006)(336012)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 15:53:55.9763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ecf879-7793-4f54-8d8f-08d9bfe319c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3723
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

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20211208174356.1997855-5-yazen.ghannam@amd.com

v1->v2:
* Was patch 4 in v1.
* Change "has_ddr5" flag to "zn_regs_v2".
* Drop flag check helper function.
* Update determine_memory_type() to check bitfield for DDR5.
* Update code comments.

 drivers/edac/amd64_edac.c | 59 +++++++++++++++++++++++++++++++++++----
 drivers/edac/amd64_edac.h | 14 ++++++++++
 2 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1df763128483..b7dd87636155 100644
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
@@ -1628,6 +1655,20 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 			dimm_cfg |= pvt->umc[i].dimm_cfg;
 		}
 
+		/*
+		 * Check if the system supports the "DDR Type" field in UMC Config
+		 * and has DDR5 DIMMs in use.
+		 */
+		if (fam_type->flags.zn_regs_v2 && ((umc_cfg & GENMASK(2, 0)) == 0x1)) {
+			if (dimm_cfg & BIT(5))
+				pvt->dram_type = MEM_LRDDR5;
+			else if (dimm_cfg & BIT(4))
+				pvt->dram_type = MEM_RDDR5;
+			else
+				pvt->dram_type = MEM_DDR5;
+			return;
+		}
+
 		if (dimm_cfg & BIT(5))
 			pvt->dram_type = MEM_LRDDR4;
 		else if (dimm_cfg & BIT(4))
@@ -2174,8 +2215,13 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	 * There is one mask per DIMM, and two Chip Selects per DIMM.
 	 *	CS0 and CS1 -> DIMM0
 	 *	CS2 and CS3 -> DIMM1
+	 *
+	 *	Systems with newer register layout have one mask per Chip Select.
 	 */
-	dimm = csrow_nr >> 1;
+	if (fam_type->flags.zn_regs_v2)
+		dimm = csrow_nr;
+	else
+		dimm = csrow_nr >> 1;
 
 	/* Asymmetric dual-rank DIMM support. */
 	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
@@ -2937,6 +2983,7 @@ static struct amd64_family_type family_types[] = {
 		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F6,
 		.max_mcs = 12,
+		.flags.zn_regs_v2 = 1,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
@@ -3365,7 +3412,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + UMCCH_DIMM_CFG, &umc->dimm_cfg);
+		amd_smn_read(nid, umc_base + get_dimm_cfg(), &umc->dimm_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
 		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 650cab401e21..39ecb77873db 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -271,8 +271,11 @@
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
@@ -477,11 +480,22 @@ struct low_ops {
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

