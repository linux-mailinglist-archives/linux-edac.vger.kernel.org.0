Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546974A8AB2
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 18:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353091AbiBCRue (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 12:50:34 -0500
Received: from mail-dm6nam12on2084.outbound.protection.outlook.com ([40.107.243.84]:22273
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353108AbiBCRub (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uxtp5IWkVOBakrZ2BUQm0vNq8tr4tW3AjNwiZwJ0V9DdKnUP/qF1yj0Zrq6Pl3DT6ivZey5ibgURckt+ZEOyj8nAMnE+ut83qmgPioxRmzFuNtoysLrwjKCCYyaPb9IcWd2l2VCWUMtKsSy6deH2JsqZnLQBhytZDwpwo9z/7vI4+14dNm8hn/YOBc9nFaFLjPHG4PFQb5JSTTiJCALtDnSzzHdctPBHa26iaWp+x+0es9MCiSZ/yKeCbaoqk/vQMBOMvkNRw7f/Yth5ym2k8Ks3KDl8WfKJBKHYf3WERXMl5OuVV2uinIjo8tHwJ1P6oz4vAvGB/CJOnyS1bzEkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rp/IR2NfxqqJE44ySmGmUUAUyEFaTlJ9/8rCRNmR69w=;
 b=hLUX3z56Ei24wiMjRbKYaE0wDXhcm50+eSEzJBSUQT0CvS786lmRS+Hejv3yhVoQOwlK/xowcCp5VledGD5f0MpQcmfdhYP6rSGq2naPli2D1IWSG5Zpp/pv91dl6RSeb7+wsDycPHShQcq81jN5v7MKsh2OLDpNCZB9ACt5utNxm0moRbycXA+ZXi4BeZWpWztlZSrHl3Sgm65PCnOA5GuBf1Gxw0eWESPrannmNhQ8QH4PDkbIhtOHwlXQJiLvfsAws50PljBDTeYtPnNx0TtsxZmnp95acBX0mOogrNP1uhQtHOztI8+QD5GVJ1HI5Da0dg+tiKzMnYAcNctG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp/IR2NfxqqJE44ySmGmUUAUyEFaTlJ9/8rCRNmR69w=;
 b=o6/UakpRvXTbNypwNkk313ZcuL0LG8uAq2xbp5iF6J1I5ylrkMG6hOKKNYL8gO3FIuMEgvbErHvHO/0yIkQeIKizpNsuZNpHScl/oWf81m6tPtmNSvSX5h6zNuSAvaQPJi0nLXgOwCr82QcOM4b0396JjQ4VNGox3MX0TZlRF1c=
Received: from MW4PR02CA0024.namprd02.prod.outlook.com (2603:10b6:303:16d::9)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Thu, 3 Feb
 2022 17:50:29 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::84) by MW4PR02CA0024.outlook.office365.com
 (2603:10b6:303:16d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 17:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:50:29 +0000
Received: from node-bp128-r03d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 11:50:25 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v7 05/12] EDAC/amd64: Define dynamic family ops routines
Date:   Thu, 3 Feb 2022 11:49:35 -0600
Message-ID: <20220203174942.31630-6-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ecc72cd-809d-4ca9-6ef1-08d9e73daaa8
X-MS-TrafficTypeDiagnostic: MW5PR12MB5649:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB5649C1E3193E559A6EEA2696E8289@MW5PR12MB5649.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvDMr+4M8P9Eveu2L5Ba0IajUxARnKv/Mrpie2r+HWQOmeEQxEv58TECYcyGYgvxgwzY3qL4/SDKAtX0aYSRmD4J2P64oyVGvyQn6I37rKyfD3OUC3vI3LhcdAYR7DZpyvhu9+6p2HJX9rS8QLLCeEkTPRJCsZ/bIKzRF/wBA+OmPkCxPhTamK5OqP81syAjkActCHhBrHnvv4AIDImgn8rBkFtBg280CXXdXwaOkrjxpwrze6dFb0jsTlxue8QSyL8dtccxyjbVPGGPgtsW9sMcdw4VWbxWwt0WNmOSb+HRjrdoKmPGPbkaSkDRN+bx1PUgXL4Paz0ndb1vY2cy7WhAF1+MXdZj56aP+3oYrtdTFoyYVSC95M6kWWmjwt4BSmb+w461jcjApTUXljtv94FMbUGbmv4EcplijHxB216jRlM+4sIFQqBrkTQTwDWqaGdo7DoIaNLarmXPWiI9zU79NZlyI7YVhCaCu3sc1PCySjNmDkeJFCFyWqt1fqrkeoaqzeC06cmw+HY45V6/OQZvOfH00xUyVbyWOC8RZhoZq4xm9ZFHMhRLhy1tEc0WLS2GHJDIRvB9rvA/tImngq93Zw3U8+AkUYSsdLH3Saq0n/919KjCR4P7ChpA5adeyaBGLP+lCIc+P5lVdOgYPKAWO0IjrATSSZV3xFIlOloW70va37fuYZdA1z2v2FM7YU5qXwXWDY9p6oHfLkECVfMd4SJ4ht6KPsUHs435oPtEQZWAN18jCWoNTpba8PcXha/kG08i22zzT+faODwEWlnGvBTeW7G3S9F+sZtIM+Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(316002)(36860700001)(186003)(54906003)(2616005)(110136005)(30864003)(83380400001)(2906002)(336012)(426003)(16526019)(36756003)(1076003)(47076005)(26005)(8936002)(6666004)(4326008)(8676002)(5660300002)(70586007)(40460700003)(70206006)(81166007)(82310400004)(7696005)(356005)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:50:29.0103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecc72cd-809d-4ca9-6ef1-08d9e73daaa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Extending family-specific assignments dynamic.
This would simplify adding support for future platforms.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
Link:
https://lkml.kernel.org/r/20211028130106.15701-4-nchatrad@amd.com

v5->v7:
* None

v4->v5:
* split read_mc_regs for per family ops
* Adjusted and Called dump_misc_regs for family ops

v3->v4:
* Modified k8_prep_chip_selects for ext_model checks
* Add read_dct_base_mask to ops
* Renamed find_umc_channel and addressed minor comments

v2->v3:
* Defined new family operation routines

v1->v2:
* new change


 drivers/edac/amd64_edac.c | 442 ++++++++++++++++++++++++--------------
 drivers/edac/amd64_edac.h |  13 ++
 2 files changed, 297 insertions(+), 158 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4cac43840ccc..babd25f29845 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1695,36 +1695,40 @@ static int get_channel_from_ecc_syndrome(struct mem_ctl_info *, u16);
  * Determine if the DIMMs have ECC enabled. ECC is enabled ONLY if all the DIMMs
  * are ECC capable.
  */
-static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
+static unsigned long f1x_determine_edac_cap(struct amd64_pvt *pvt)
 {
 	unsigned long edac_cap = EDAC_FLAG_NONE;
 	u8 bit;
 
-	if (pvt->umc) {
-		u8 i, umc_en_mask = 0, dimm_ecc_en_mask = 0;
+	bit = (pvt->fam > 0xf || pvt->ext_model >= K8_REV_F)
+		? 19
+		: 17;
 
-		for_each_umc(i) {
-			if (!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT))
-				continue;
+	if (pvt->dclr0 & BIT(bit))
+		edac_cap = EDAC_FLAG_SECDED;
 
-			umc_en_mask |= BIT(i);
+	return edac_cap;
+}
 
-			/* UMC Configuration bit 12 (DimmEccEn) */
-			if (pvt->umc[i].umc_cfg & BIT(12))
-				dimm_ecc_en_mask |= BIT(i);
-		}
+static unsigned long f17_determine_edac_cap(struct amd64_pvt *pvt)
+{
+	u8 i, umc_en_mask = 0, dimm_ecc_en_mask = 0;
+	unsigned long edac_cap = EDAC_FLAG_NONE;
 
-		if (umc_en_mask == dimm_ecc_en_mask)
-			edac_cap = EDAC_FLAG_SECDED;
-	} else {
-		bit = (pvt->fam > 0xf || pvt->ext_model >= K8_REV_F)
-			? 19
-			: 17;
+	for_each_umc(i) {
+		if (!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT))
+			continue;
 
-		if (pvt->dclr0 & BIT(bit))
-			edac_cap = EDAC_FLAG_SECDED;
+		umc_en_mask |= BIT(i);
+
+		/* UMC Configuration bit 12 (DimmEccEn) */
+		if (pvt->umc[i].umc_cfg & BIT(12))
+			dimm_ecc_en_mask |= BIT(i);
 	}
 
+	if (umc_en_mask == dimm_ecc_en_mask)
+		edac_cap = EDAC_FLAG_SECDED;
+
 	return edac_cap;
 }
 
@@ -1771,6 +1775,13 @@ static void debug_dump_dramcfg_low(struct amd64_pvt *pvt, u32 dclr, int chan)
 #define CS_EVEN			(CS_EVEN_PRIMARY | CS_EVEN_SECONDARY)
 #define CS_ODD			(CS_ODD_PRIMARY | CS_ODD_SECONDARY)
 
+static int f1x_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
+{
+	u32 dbam = ctrl ? pvt->dbam1 : pvt->dbam0;
+
+	return DBAM_DIMM(dimm, dbam);
+}
+
 static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 {
 	u8 base, count = 0;
@@ -1907,10 +1918,7 @@ static void __dump_misc_regs(struct amd64_pvt *pvt)
 /* Display and decode various NB registers for debug purposes. */
 static void dump_misc_regs(struct amd64_pvt *pvt)
 {
-	if (pvt->umc)
-		__dump_misc_regs_df(pvt);
-	else
-		__dump_misc_regs(pvt);
+	pvt->ops->dump_misc_regs(pvt);
 
 	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
 
@@ -1920,28 +1928,51 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
 /*
  * See BKDG, F2x[1,0][5C:40], F2[1,0][6C:60]
  */
-static void prep_chip_selects(struct amd64_pvt *pvt)
+static void k8_prep_chip_selects(struct amd64_pvt *pvt)
 {
-	if (pvt->fam == 0xf && pvt->ext_model < K8_REV_F) {
-		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
-		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 8;
-	} else if (pvt->fam == 0x15 && pvt->model == 0x30) {
-		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
-		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
-	} else if (pvt->fam >= 0x17) {
-		int umc;
-
-		for_each_umc(umc) {
-			pvt->csels[umc].b_cnt = 4;
-			pvt->csels[umc].m_cnt = pvt->flags.zn_regs_v2 ? 4 : 2;
-		}
+	if (pvt->ext_model < K8_REV_F) {
+		pvt->csels[0].b_cnt = 8;
+		pvt->csels[1].b_cnt = 8;
 
-	} else {
-		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
-		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
+		pvt->csels[0].m_cnt = 8;
+		pvt->csels[1].m_cnt = 8;
+	} else if (pvt->ext_model >= K8_REV_F) {
+		pvt->csels[0].b_cnt = 8;
+		pvt->csels[1].b_cnt = 8;
+
+		pvt->csels[0].m_cnt = 4;
+		pvt->csels[1].m_cnt = 4;
 	}
 }
 
+static void f15_m30h_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	pvt->csels[0].b_cnt = 4;
+	pvt->csels[1].b_cnt = 4;
+
+	pvt->csels[0].m_cnt = 2;
+	pvt->csels[1].m_cnt = 2;
+}
+
+static void f17_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	int umc;
+
+	for_each_umc(umc) {
+		pvt->csels[umc].b_cnt = 4;
+		pvt->csels[umc].m_cnt = pvt->flags.zn_regs_v2 ? 4 : 2;
+	}
+}
+
+static void default_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	pvt->csels[0].b_cnt = 8;
+	pvt->csels[1].b_cnt = 8;
+
+	pvt->csels[0].m_cnt = 4;
+	pvt->csels[1].m_cnt = 4;
+}
+
 static void read_umc_base_mask(struct amd64_pvt *pvt)
 {
 	u32 umc_base_reg, umc_base_reg_sec;
@@ -2000,11 +2031,6 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
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
@@ -2089,9 +2115,6 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 {
 	u32 dram_ctrl, dcsm;
 
-	if (pvt->umc)
-		return determine_memory_type_df(pvt);
-
 	switch (pvt->fam) {
 	case 0xf:
 		if (pvt->ext_model >= K8_REV_F)
@@ -2141,6 +2164,8 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 		WARN(1, KERN_ERR "%s: Family??? 0x%x\n", __func__, pvt->fam);
 		pvt->dram_type = MEM_EMPTY;
 	}
+
+	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
 	return;
 
 ddr3:
@@ -3513,10 +3538,13 @@ static inline void decode_bus_error(int node_id, struct mce *m)
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
@@ -3538,8 +3566,6 @@ static void decode_umc_error(int node_id, struct mce *m)
 	if (m->status & MCI_STATUS_DEFERRED)
 		ecc_type = 3;
 
-	err.channel = find_umc_channel(m);
-
 	if (!(m->status & MCI_STATUS_SYNDV)) {
 		err.err_code = ERR_SYND;
 		goto log_error;
@@ -3554,7 +3580,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 			err.err_code = ERR_CHANNEL;
 	}
 
-	err.csrow = m->synd & 0x7;
+	pvt->ops->get_umc_err_info(m, &err);
 
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
@@ -3639,26 +3665,11 @@ static void free_mc_sibling_devs(struct amd64_pvt *pvt)
 	}
 }
 
-static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
+static void f1x_determine_ecc_sym_sz(struct amd64_pvt *pvt)
 {
 	pvt->ecc_sym_sz = 4;
 
-	if (pvt->umc) {
-		u8 i;
-
-		for_each_umc(i) {
-			/* Check enabled channels only: */
-			if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
-				if (pvt->umc[i].ecc_ctrl & BIT(9)) {
-					pvt->ecc_sym_sz = 16;
-					return;
-				} else if (pvt->umc[i].ecc_ctrl & BIT(7)) {
-					pvt->ecc_sym_sz = 8;
-					return;
-				}
-			}
-		}
-	} else if (pvt->fam >= 0x10) {
+	if (pvt->fam >= 0x10) {
 		u32 tmp;
 
 		amd64_read_pci_cfg(pvt->F3, EXT_NB_MCA_CFG, &tmp);
@@ -3672,6 +3683,47 @@ static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
 	}
 }
 
+static void f17_determine_ecc_sym_sz(struct amd64_pvt *pvt)
+{
+	u8 i;
+
+	pvt->ecc_sym_sz = 4;
+
+	for_each_umc(i) {
+		/* Check enabled channels only: */
+		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
+			if (pvt->umc[i].ecc_ctrl & BIT(9)) {
+				pvt->ecc_sym_sz = 16;
+				return;
+			} else if (pvt->umc[i].ecc_ctrl & BIT(7)) {
+				pvt->ecc_sym_sz = 8;
+				return;
+			}
+		}
+	}
+}
+
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
@@ -3693,6 +3745,8 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
 		amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
 	}
+
+	amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
 }
 
 /*
@@ -3702,30 +3756,8 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 static void read_mc_regs(struct amd64_pvt *pvt)
 {
 	unsigned int range;
-	u64 msr_val;
 
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
-
-	if (pvt->umc) {
-		__read_mc_regs_df(pvt);
-		amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
-
-		goto skip;
-	}
+	read_top_mem_registers(pvt);
 
 	amd64_read_pci_cfg(pvt->F3, NBCAP, &pvt->nbcap);
 
@@ -3766,16 +3798,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 		amd64_read_dct_pci_cfg(pvt, 1, DCLR0, &pvt->dclr1);
 		amd64_read_dct_pci_cfg(pvt, 1, DCHR0, &pvt->dchr1);
 	}
-
-skip:
-	read_dct_base_mask(pvt);
-
-	determine_memory_type(pvt);
-
-	if (!pvt->umc)
-		edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
-
-	determine_ecc_sym_sz(pvt);
 }
 
 /*
@@ -3814,17 +3836,10 @@ static void read_mc_regs(struct amd64_pvt *pvt)
  */
 static u32 get_csrow_nr_pages(struct amd64_pvt *pvt, u8 dct, int csrow_nr_orig)
 {
-	u32 dbam = dct ? pvt->dbam1 : pvt->dbam0;
 	int csrow_nr = csrow_nr_orig;
 	u32 cs_mode, nr_pages;
 
-	if (!pvt->umc) {
-		csrow_nr >>= 1;
-		cs_mode = DBAM_DIMM(csrow_nr, dbam);
-	} else {
-		cs_mode = f17_get_cs_mode(csrow_nr >> 1, dct, pvt);
-	}
-
+	cs_mode = pvt->ops->get_cs_mode(csrow_nr >> 1, dct, pvt);
 	nr_pages   = pvt->ops->dbam_to_cs(pvt, dct, cs_mode, csrow_nr);
 	nr_pages <<= 20 - PAGE_SHIFT;
 
@@ -3893,9 +3908,6 @@ static int init_csrows(struct mem_ctl_info *mci)
 	int nr_pages = 0;
 	u32 val;
 
-	if (pvt->umc)
-		return init_csrows_df(mci);
-
 	amd64_read_pci_cfg(pvt->F3, NBCFG, &val);
 
 	pvt->nbcfg = val;
@@ -4116,49 +4128,60 @@ static void restore_ecc_error_reporting(struct ecc_settings *s, u16 nid,
 		amd64_warn("Error restoring NB MCGCTL settings!\n");
 }
 
-static bool ecc_enabled(struct amd64_pvt *pvt)
+static bool f1x_check_ecc_enabled(struct amd64_pvt *pvt)
 {
 	u16 nid = pvt->mc_node_id;
 	bool nb_mce_en = false;
-	u8 ecc_en = 0, i;
+	u8 ecc_en = 0;
 	u32 value;
 
-	if (boot_cpu_data.x86 >= 0x17) {
-		u8 umc_en_mask = 0, ecc_en_mask = 0;
-		struct amd64_umc *umc;
+	amd64_read_pci_cfg(pvt->F3, NBCFG, &value);
 
-		for_each_umc(i) {
-			umc = &pvt->umc[i];
+	ecc_en = !!(value & NBCFG_ECC_ENABLE);
 
-			/* Only check enabled UMCs. */
-			if (!(umc->sdp_ctrl & UMC_SDP_INIT))
-				continue;
+	nb_mce_en = nb_mce_bank_enabled_on_node(nid);
+	if (!nb_mce_en)
+		edac_dbg(0, "NB MCE bank disabled, set MSR 0x%08x[4] on node %d to enable.\n",
+			 MSR_IA32_MCG_CTL, nid);
 
-			umc_en_mask |= BIT(i);
+	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
 
-			if (umc->umc_cap_hi & UMC_ECC_ENABLED)
-				ecc_en_mask |= BIT(i);
-		}
+	if (!ecc_en || !nb_mce_en)
+		return false;
+	else
+		return true;
+}
 
-		/* Check whether at least one UMC is enabled: */
-		if (umc_en_mask)
-			ecc_en = umc_en_mask == ecc_en_mask;
-		else
-			edac_dbg(0, "Node %d: No enabled UMCs.\n", nid);
+static bool f17_check_ecc_enabled(struct amd64_pvt *pvt)
+{
+	u16 nid = pvt->mc_node_id;
+	struct amd64_umc *umc;
+	u8 umc_en_mask = 0, ecc_en_mask = 0;
+	bool nb_mce_en = false;
+	u8 ecc_en = 0, i;
 
-		/* Assume UMC MCA banks are enabled. */
-		nb_mce_en = true;
-	} else {
-		amd64_read_pci_cfg(pvt->F3, NBCFG, &value);
+	for_each_umc(i) {
+		umc = &pvt->umc[i];
+
+		/* Only check enabled UMCs. */
+		if (!(umc->sdp_ctrl & UMC_SDP_INIT))
+			continue;
 
-		ecc_en = !!(value & NBCFG_ECC_ENABLE);
+		umc_en_mask |= BIT(i);
 
-		nb_mce_en = nb_mce_bank_enabled_on_node(nid);
-		if (!nb_mce_en)
-			edac_dbg(0, "NB MCE bank disabled, set MSR 0x%08x[4] on node %d to enable.\n",
-				     MSR_IA32_MCG_CTL, nid);
+		if (umc->umc_cap_hi & UMC_ECC_ENABLED)
+			ecc_en_mask |= BIT(i);
 	}
 
+	/* Check whether at least one UMC is enabled: */
+	if (umc_en_mask)
+		ecc_en = umc_en_mask == ecc_en_mask;
+	else
+		edac_dbg(0, "Node %d: No enabled UMCs.\n", nid);
+
+	/* Assume UMC MCA banks are enabled. */
+	nb_mce_en = true;
+
 	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
 
 	if (!ecc_en || !nb_mce_en)
@@ -4168,7 +4191,17 @@ static bool ecc_enabled(struct amd64_pvt *pvt)
 }
 
 static inline void
-f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
+f1x_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
+{
+	if (pvt->nbcap & NBCAP_SECDED)
+		mci->edac_ctl_cap |= EDAC_FLAG_SECDED;
+
+	if (pvt->nbcap & NBCAP_CHIPKILL)
+		mci->edac_ctl_cap |= EDAC_FLAG_S4ECD4ED;
+}
+
+static inline void
+f17_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
 {
 	u8 i, ecc_en = 1, cpk_en = 1, dev_x4 = 1, dev_x16 = 1;
 
@@ -4198,24 +4231,16 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
 	}
 }
 
-static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
+static void f1x_setup_mci_misc_attrs(struct mem_ctl_info *mci)
 {
 	struct amd64_pvt *pvt = mci->pvt_info;
 
 	mci->mtype_cap		= MEM_FLAG_DDR2 | MEM_FLAG_RDDR2;
 	mci->edac_ctl_cap	= EDAC_FLAG_NONE;
 
-	if (pvt->umc) {
-		f17h_determine_edac_ctl_cap(mci, pvt);
-	} else {
-		if (pvt->nbcap & NBCAP_SECDED)
-			mci->edac_ctl_cap |= EDAC_FLAG_SECDED;
+	pvt->ops->determine_edac_ctl_cap(mci, pvt);
 
-		if (pvt->nbcap & NBCAP_CHIPKILL)
-			mci->edac_ctl_cap |= EDAC_FLAG_S4ECD4ED;
-	}
-
-	mci->edac_cap		= determine_edac_cap(pvt);
+	mci->edac_cap		= pvt->ops->determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
 	mci->ctl_name		= pvt->ctl_name;
 	mci->dev_name		= pci_name(pvt->F3);
@@ -4245,6 +4270,18 @@ static void per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->early_channel_count		= k8_early_channel_count;
 		pvt->ops->map_sysaddr_to_csrow		= k8_map_sysaddr_to_csrow;
 		pvt->ops->dbam_to_cs			= k8_dbam_to_chip_select;
+		pvt->ops->prep_chip_selects		= k8_prep_chip_selects;
+		pvt->ops->determine_memory_type		= determine_memory_type;
+		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
+		pvt->ops->ecc_enabled			= f1x_check_ecc_enabled;
+		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
+		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
+		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
+		pvt->ops->get_cs_mode			= f1x_get_cs_mode;
+		pvt->ops->get_base_mask			= read_dct_base_mask;
+		pvt->ops->dump_misc_regs		= __dump_misc_regs;
+		pvt->ops->get_mc_regs			= read_mc_regs;
+		pvt->ops->populate_csrows		= init_csrows;
 		break;
 
 	case 0x10:
@@ -4255,6 +4292,18 @@ static void per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->early_channel_count		= f1x_early_channel_count;
 		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
 		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
+		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
+		pvt->ops->determine_memory_type		= determine_memory_type;
+		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
+		pvt->ops->ecc_enabled			= f1x_check_ecc_enabled;
+		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
+		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
+		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
+		pvt->ops->get_cs_mode			= f1x_get_cs_mode;
+		pvt->ops->get_base_mask			= read_dct_base_mask;
+		pvt->ops->dump_misc_regs		= __dump_misc_regs;
+		pvt->ops->get_mc_regs			= read_mc_regs;
+		pvt->ops->populate_csrows		= init_csrows;
 		break;
 
 	case 0x15:
@@ -4263,11 +4312,13 @@ static void per_family_init(struct amd64_pvt *pvt)
 			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F1;
 			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F2;
 			pvt->ops->dbam_to_cs		= f16_dbam_to_chip_select;
+			pvt->ops->prep_chip_selects	= f15_m30h_prep_chip_selects;
 		} else if (pvt->model == 0x60) {
 			pvt->ctl_name			= "F15h_M60h";
 			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F1;
 			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F2;
 			pvt->ops->dbam_to_cs		= f15_m60h_dbam_to_chip_select;
+			pvt->ops->prep_chip_selects	= default_prep_chip_selects;
 		} else if (pvt->model == 0x13) {
 		/* Richland is only client */
 			return;
@@ -4276,10 +4327,22 @@ static void per_family_init(struct amd64_pvt *pvt)
 			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_NB_F1;
 			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_NB_F2;
 			pvt->ops->dbam_to_cs		= f15_dbam_to_chip_select;
+			pvt->ops->prep_chip_selects	= default_prep_chip_selects;
 		}
 		pvt->max_mcs				= 2;
 		pvt->ops->early_channel_count		= f1x_early_channel_count;
 		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
+		pvt->ops->determine_memory_type		= determine_memory_type;
+		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
+		pvt->ops->ecc_enabled			= f1x_check_ecc_enabled;
+		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
+		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
+		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
+		pvt->ops->get_cs_mode			= f1x_get_cs_mode;
+		pvt->ops->get_base_mask			= read_dct_base_mask;
+		pvt->ops->dump_misc_regs		= __dump_misc_regs;
+		pvt->ops->get_mc_regs			= read_mc_regs;
+		pvt->ops->populate_csrows		= init_csrows;
 		break;
 
 	case 0x16:
@@ -4296,6 +4359,17 @@ static void per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->early_channel_count		= f1x_early_channel_count;
 		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
 		pvt->ops->dbam_to_cs			= f16_dbam_to_chip_select;
+		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
+		pvt->ops->determine_memory_type		= determine_memory_type;
+		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
+		pvt->ops->ecc_enabled			= f1x_check_ecc_enabled;
+		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
+		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
+		pvt->ops->get_cs_mode			= f1x_get_cs_mode;
+		pvt->ops->get_base_mask			= read_dct_base_mask;
+		pvt->ops->dump_misc_regs		= __dump_misc_regs;
+		pvt->ops->get_mc_regs			= read_mc_regs;
+		pvt->ops->populate_csrows		= init_csrows;
 		break;
 
 	case 0x17:
@@ -4334,6 +4408,19 @@ static void per_family_init(struct amd64_pvt *pvt)
 	case 0x18:
 		pvt->ops->early_channel_count		= f17_early_channel_count;
 		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
+		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
+		pvt->ops->determine_memory_type		= determine_memory_type_df;
+		pvt->ops->determine_ecc_sym_sz		= f17_determine_ecc_sym_sz;
+		pvt->ops->ecc_enabled			= f17_check_ecc_enabled;
+		pvt->ops->determine_edac_ctl_cap	= f17_determine_edac_ctl_cap;
+		pvt->ops->determine_edac_cap		= f17_determine_edac_cap;
+		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
+		pvt->ops->get_cs_mode			= f17_get_cs_mode;
+		pvt->ops->get_base_mask			= read_umc_base_mask;
+		pvt->ops->dump_misc_regs		= __dump_misc_regs_df;
+		pvt->ops->get_mc_regs			= __read_mc_regs_df;
+		pvt->ops->populate_csrows		= init_csrows_df;
+		pvt->ops->get_umc_err_info		= update_umc_err_info;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -4376,12 +4463,43 @@ static void per_family_init(struct amd64_pvt *pvt)
 		}
 		pvt->ops->early_channel_count		= f17_early_channel_count;
 		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
+		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
+		pvt->ops->determine_memory_type		= determine_memory_type_df;
+		pvt->ops->determine_ecc_sym_sz		= f17_determine_ecc_sym_sz;
+		pvt->ops->ecc_enabled			= f17_check_ecc_enabled;
+		pvt->ops->determine_edac_ctl_cap	= f17_determine_edac_ctl_cap;
+		pvt->ops->determine_edac_cap		= f17_determine_edac_cap;
+		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
+		pvt->ops->get_cs_mode			= f17_get_cs_mode;
+		pvt->ops->get_base_mask			= read_umc_base_mask;
+		pvt->ops->dump_misc_regs		= __dump_misc_regs_df;
+		pvt->ops->get_mc_regs			= __read_mc_regs_df;
+		pvt->ops->populate_csrows		= init_csrows_df;
+		pvt->ops->get_umc_err_info		= update_umc_err_info;
 		break;
 
 	default:
 		amd64_err("Unsupported family!\n");
 		return;
 	}
+
+	/* ops required for all the families */
+	if (!pvt->ops->early_channel_count || !pvt->ops->dbam_to_cs ||
+	    !pvt->ops->prep_chip_selects || !pvt->ops->determine_memory_type ||
+	    !pvt->ops->ecc_enabled || !pvt->ops->determine_edac_ctl_cap ||
+	    !pvt->ops->determine_edac_cap || !pvt->ops->setup_mci_misc_attrs ||
+	    !pvt->ops->get_cs_mode || !pvt->ops->get_base_mask ||
+	    !pvt->ops->dump_misc_regs || !pvt->ops->get_mc_regs ||
+	    !pvt->ops->populate_csrows) {
+		edac_dbg(1, "Common helper routines not defined.\n");
+		return;
+	}
+
+	/* ops required for families 17h and later */
+	if (pvt->fam >= 0x17 && !pvt->ops->get_umc_err_info) {
+		edac_dbg(1, "Platform specific helper routines not defined.\n");
+		return;
+	}
 }
 
 static const struct attribute_group *amd64_edac_attr_groups[] = {
@@ -4413,7 +4531,15 @@ static int hw_info_get(struct amd64_pvt *pvt)
 	if (ret)
 		return ret;
 
-	read_mc_regs(pvt);
+	pvt->ops->get_mc_regs(pvt);
+
+	pvt->ops->prep_chip_selects(pvt);
+
+	pvt->ops->get_base_mask(pvt);
+
+	pvt->ops->determine_memory_type(pvt);
+
+	pvt->ops->determine_ecc_sym_sz(pvt);
 
 	return 0;
 }
@@ -4462,9 +4588,9 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	mci->pvt_info = pvt;
 	mci->pdev = &pvt->F3->dev;
 
-	setup_mci_misc_attrs(mci);
+	pvt->ops->setup_mci_misc_attrs(mci);
 
-	if (init_csrows(mci))
+	if (pvt->ops->populate_csrows(mci))
 		mci->edac_cap = EDAC_FLAG_NONE;
 
 	ret = -ENODEV;
@@ -4528,7 +4654,7 @@ static int probe_one_instance(unsigned int nid)
 		goto err_enable;
 	}
 
-	if (!ecc_enabled(pvt)) {
+	if (!pvt->ops->ecc_enabled(pvt)) {
 		ret = -ENODEV;
 
 		if (!ecc_enable_override)
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 4e3f9755bc73..07ff2c6c17c5 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -481,6 +481,19 @@ struct low_ops {
 				     struct err_info *err);
 	int  (*dbam_to_cs)(struct amd64_pvt *pvt, u8 dct,
 			   unsigned int cs_mode, int cs_mask_nr);
+	void (*prep_chip_selects)(struct amd64_pvt *pvt);
+	void (*determine_memory_type)(struct amd64_pvt *pvt);
+	void (*determine_ecc_sym_sz)(struct amd64_pvt *pvt);
+	bool (*ecc_enabled)(struct amd64_pvt *pvt);
+	void (*determine_edac_ctl_cap)(struct mem_ctl_info *mci, struct amd64_pvt *pvt);
+	unsigned long (*determine_edac_cap)(struct amd64_pvt *pvt);
+	int  (*get_cs_mode)(int dimm, u8 ctrl, struct amd64_pvt *pvt);
+	void (*get_base_mask)(struct amd64_pvt *pvt);
+	void (*dump_misc_regs)(struct amd64_pvt *pvt);
+	void (*get_mc_regs)(struct amd64_pvt *pvt);
+	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
+	int  (*populate_csrows)(struct mem_ctl_info *mci);
+	void (*get_umc_err_info)(struct mce *m, struct err_info *err);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

