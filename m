Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20E246DA48
	for <lists+linux-edac@lfdr.de>; Wed,  8 Dec 2021 18:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhLHRsB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Dec 2021 12:48:01 -0500
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com ([40.107.236.53]:44576
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235573AbhLHRry (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 8 Dec 2021 12:47:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lS8vy+F/ND503jEwzieshiiNlAn4G15+0d1LFfZNsEgHDammBm2ekI4A5hxePS8G1blPoVQhOKgRIsPWfBdWt+E3rgPjdLv7odX3dPWyf1QLaPe6NK/9uQkYvP1lhACykRLedWNOZkKkfaOnMMYLH9/ouQ08GrQKdlch6/bWBAwKyJaMFFHslEV4eXUIClzPJkfcMVKD02U3UwEzxVdrNKbhAYzAa5w9gCjxYAxwHXa2lh7hOBC4mA0/QqLfQJv8oEgF161uFL5slJym4XZJe+L2z01YuG3KiKLrAA0JqLjlwbpvyEciTS7e7obnw5UvKnjaZiM56eN8WdOYa0qgXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQezkGWWPyx8t+dGm5LeaT4BDtaYa3RIROt8uf4iw9Q=;
 b=SyerqJK8jJtKEbWVYdtzx1Y2/F5zNL6ne2xBRgvoJpSRnoZAFSOMQ06Uy2lVU5Vb1PpowgrQrnUWFUK6aQPkzHWETQStt2eyU7281xMd+x52uIocmeyO1XelTUqU9yrZvfuIvjskAZhmenpvt9PeKW/yq/Vf5E1rY/DKkE3fIWqd4sm4Zmr87RPnENX9adZPJsyPwxgjlPV+W9pt9MGxW3lPkB4RD+/7oydS8gHHnIj13Wgm0r5b57EBUAjSqVCojoPgv6LDIC13ZrWt7NB8uuwWqT6iLZxNIDvMtttSrykegsEel+bvllqMX6Aode+81/tUztBMDB9ugZtT4w927Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQezkGWWPyx8t+dGm5LeaT4BDtaYa3RIROt8uf4iw9Q=;
 b=mYODthAKEFELkILcTW98SNgKaJxejXo1ntap2Kyujvrpbg9jnwpEKnhjTIRKreXN3hYddEgZwrdNLXtmL81FipUR14Ncvr9WCCa1MWVFDFGazOUzIvVM9Co/Ptug8Ta9YxKj6Q6a13cNfzUIp4lhwtH8ZIkEDrATV6VUwgBzZrw=
Received: from MW4PR03CA0210.namprd03.prod.outlook.com (2603:10b6:303:b8::35)
 by MWHPR12MB1311.namprd12.prod.outlook.com (2603:10b6:300:13::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 8 Dec
 2021 17:44:19 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::d4) by MW4PR03CA0210.outlook.office365.com
 (2603:10b6:303:b8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Wed, 8 Dec 2021 17:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 17:44:19 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 11:44:18 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 4/4] EDAC/amd64: Add DDR5 support and related register changes
Date:   Wed, 8 Dec 2021 17:43:56 +0000
Message-ID: <20211208174356.1997855-5-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208174356.1997855-1-yazen.ghannam@amd.com>
References: <20211208174356.1997855-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84e825d9-9b06-4add-0c82-08d9ba725cd6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1311:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB131185767CD02FD992D44D62F86F9@MWHPR12MB1311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHyF1d2sfXtmEqUlP869L3eAfzLF3P+hJ8zrTivmehf+rzpjdPnszHiARBpGExVZlfcG1VxSmpnLn9g/fQqwy+35WuLzLMDzlA3nPrFiD4NaVWxwtCgM7AtxHZi4XzFWqql4QPSLFayIAjiYOS8EzjnhLBlmwZfgy2DeE65ho8SZkJVl1cobgHDVlvvjqWod1664PjfRQo5mf48YCSeThRMgdArnr6mOl0idfpRWAxT5w1B4xV5yxSrxF7iUd9vfPHIchxaq4IA+ZNUUtySMNyS11JI5vECMziVatEF1qoygZtTXBpWM1Vv9dz5Dczh73rKxN9uPA1JZlRUPVeVBK1q1K0MXYxigd/MPHnjZy/9PmVJRyS0pBT4GDuiVA6Q6Pf+CyWt1I09/pS88q+T2wy+yVsjLFxb0293N/On2RTTK9z0CcqCc2TTMrpFj+AF7Yiw0ZvzUVCJDw17tPa0BiDV0AjauOHRoCfqxUDEUccVrVUp7TrW9EgOTMLMLQvRHRYYqfz3l9FLD1vt+U7Rb9aNL9ctv7uzrGh7BgecSwK0s+gQzNWb9OPNjImAkSp3Pcc9vwCl6UtlJbczCNJWuUV+gkdLXADO1zlhfDG2y2gcGu67goiWu6fOirCswNrpkjLRFkKrbDPmjYHK/8Z9a0q+9pYP6q+ksVmQ12qHIa9HOuneePKJeDa7c2PbUQRt9vHI3M1iFZ+lwAaZji3Kr+79034Ra7b5jgBR2fRNBpsCNbGfrs7zfEA5EeTZTjiPTowUoTc8rPithgjp9pYKLYAuc6QEqQMo7fnrV0kUxAsQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(7696005)(8936002)(2616005)(44832011)(36860700001)(82310400004)(70206006)(356005)(70586007)(81166007)(316002)(26005)(54906003)(5660300002)(508600001)(2906002)(6666004)(1076003)(40460700001)(8676002)(426003)(186003)(4326008)(86362001)(83380400001)(336012)(47076005)(16526019)(36756003)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 17:44:19.4643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e825d9-9b06-4add-0c82-08d9ba725cd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1311
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Future AMD systems will support DDR5.

Add support for changes in register addresses for these systems.

Introduce a "family flags" bitmask that can be used to indicate any
special behavior needed on a per-family basis.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 61 +++++++++++++++++++++++++++++++++++----
 drivers/edac/amd64_edac.h | 11 +++++++
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1df763128483..e37a8e0cef7e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -15,6 +15,36 @@ static struct msr __percpu *msrs;
 
 static struct amd64_family_type *fam_type;
 
+/* Family flag helpers */
+static inline bool has_ddr5(void)
+{
+	return fam_type->flags.has_ddr5;
+}
+
+static inline u64 get_addr_cfg(void)
+{
+	if (has_ddr5())
+		return UMCCH_ADDR_CFG_DDR5;
+
+	return UMCCH_ADDR_CFG;
+}
+
+static inline u64 get_addr_mask_sec(void)
+{
+	if (has_ddr5())
+		return UMCCH_ADDR_MASK_SEC_DDR5;
+
+	return UMCCH_ADDR_MASK_SEC;
+}
+
+static inline u64 get_dimm_cfg(void)
+{
+	if (has_ddr5())
+		return UMCCH_DIMM_CFG_DDR5;
+
+	return UMCCH_DIMM_CFG;
+}
+
 /* Per-node stuff */
 static struct ecc_settings **ecc_stngs;
 
@@ -1429,8 +1459,10 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
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
@@ -1505,7 +1537,7 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 
 		for_each_umc(umc) {
 			pvt->csels[umc].b_cnt = 4;
-			pvt->csels[umc].m_cnt = 2;
+			pvt->csels[umc].m_cnt = has_ddr5() ? 4 : 2;
 		}
 
 	} else {
@@ -1545,7 +1577,7 @@ static void read_umc_base_mask(struct amd64_pvt *pvt)
 		}
 
 		umc_mask_reg = get_umc_base(umc) + UMCCH_ADDR_MASK;
-		umc_mask_reg_sec = get_umc_base(umc) + UMCCH_ADDR_MASK_SEC;
+		umc_mask_reg_sec = get_umc_base(umc) + get_addr_mask_sec();
 
 		for_each_chip_select_mask(cs, umc, pvt) {
 			mask = &pvt->csels[umc].csmasks[cs];
@@ -1628,6 +1660,17 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 			dimm_cfg |= pvt->umc[i].dimm_cfg;
 		}
 
+		/* Check if system supports DDR5 and has DDR5 DIMMs in use. */
+		if (has_ddr5() && (umc_cfg & BIT(0))) {
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
@@ -2174,8 +2217,13 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	 * There is one mask per DIMM, and two Chip Selects per DIMM.
 	 *	CS0 and CS1 -> DIMM0
 	 *	CS2 and CS3 -> DIMM1
+	 *
+	 *	Systems with DDR5 support have one mask per Chip Select.
 	 */
-	dimm = csrow_nr >> 1;
+	if (has_ddr5())
+		dimm = csrow_nr;
+	else
+		dimm = csrow_nr >> 1;
 
 	/* Asymmetric dual-rank DIMM support. */
 	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
@@ -2937,6 +2985,7 @@ static struct amd64_family_type family_types[] = {
 		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F6,
 		.max_mcs = 12,
+		.flags.has_ddr5 = 1,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
@@ -3365,7 +3414,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + UMCCH_DIMM_CFG, &umc->dimm_cfg);
+		amd_smn_read(nid, umc_base + get_dimm_cfg(), &umc->dimm_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
 		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 650cab401e21..48cba95451cb 100644
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
@@ -477,11 +480,19 @@ struct low_ops {
 					 unsigned cs_mode, int cs_mask_nr);
 };
 
+struct amd64_family_flags {
+	/* Indicates that the family supports DDR5 and associated register changes. */
+	__u64 has_ddr5		: 1,
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

