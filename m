Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98042E1B8
	for <lists+linux-edac@lfdr.de>; Thu, 14 Oct 2021 20:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhJNS5C (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Oct 2021 14:57:02 -0400
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com ([40.107.93.54]:15712
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232319AbhJNS5B (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Oct 2021 14:57:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qgk3Ju+Nnrv9/hXgSsWoltl1KXz7uNDgBXR5wdU4e4s+mdNifSsLUjAnWdrggU962oDSAwGvrcHWVniH5UwOVTCchQWewQW4v5wynmqhR1bYIWKUMZPfsCviPbzYIZ9ymw/l6FGVV0w/PzA5GFSQTckuEScsz7lnT9+Rb5vnr/qSSDjyRNH4AgTm/qmHNzquy6llUC2Xv0T31TBekU+T9DxpsIWd04QhtZ4xlcGE/Pgy1MPAlcZV73FJNjvkRm+bqTfehIEyjPaMHe0yQoR0pjWwacT5EL9/tb8Myu48/+9V5im2otAl+s34ChJMDQaqU6nU8Bfd61R7aZhjKJU50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14MHjlX3sRKE8ZFjcwF4Z/ofGJ6RUOy2udBtPpFjJxI=;
 b=CsagnEXLZhbPlqC5bjJgM+Eo/y3FOVEp0rEyVjECXQPNNId4ZNnoDapz+50duROZI8+DVd9k5uD23endwIqcy79RP6qvi1b+2RgIBclidK7YmYkxxccvRdVQtS3Tq4fBfV/G9QGWFSEnLtv6qeU/Jbkdxu4Tc0I2JK4UeyNb5XAX4nn5/p1leRXFO8L1ja1V2lP7J8kqg/Ox9yBNumgFXF7I+Ux79/rV9LGFCXKcac9nfKcXTNGWMUQJLtc1Q9YArnctWfbLmXjdTbPG8mA3j9sZr93fPzXBrc7JdZ97UMZWySR1FIzeWrGpptMaAvOYuPlj2zaNTYqx5CtYF1n7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14MHjlX3sRKE8ZFjcwF4Z/ofGJ6RUOy2udBtPpFjJxI=;
 b=j/OXS+Ae+G+jtQw1mLeF+5OAgL2jCUrAnGYNd+e9Nk+qy3enj3rul71ywtBWHEoJDeweT0HJhTriVGBtfsKFAYg43EPCUh/Lw74gmXKjGf8UIdDWY3/3xuCwP4NBdurIr9FxKKDh5Nrjk1KRfEMxM+I6tuAmloRNK2KAh06cS5Q=
Received: from MW4PR03CA0045.namprd03.prod.outlook.com (2603:10b6:303:8e::20)
 by MWHPR12MB1182.namprd12.prod.outlook.com (2603:10b6:300:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 14 Oct
 2021 18:54:53 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::7d) by MW4PR03CA0045.outlook.office365.com
 (2603:10b6:303:8e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Thu, 14 Oct 2021 18:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 18:54:52 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 13:54:48 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v4 3/4] EDAC/amd64: Extend family ops functions
Date:   Fri, 15 Oct 2021 00:23:59 +0530
Message-ID: <20211014185400.10451-4-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211014185400.10451-1-nchatrad@amd.com>
References: <20210823185437.94417-1-nchatrad@amd.com>
 <20211014185400.10451-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d94f74c1-55ae-464c-d0e2-08d98f441b58
X-MS-TrafficTypeDiagnostic: MWHPR12MB1182:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1182B45A9D43254E158A3B89E8B89@MWHPR12MB1182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1oItOEK6muqCeGxZ2FQpNVari/cdb70ETsOUmnlsQ8oY++fYtjSBqYscOykg8lLKfat1r/sgEgOm4gN9G/y3wCph5rJi/RqqIRRjF0dYGaBeZ9YZ5+4aEH7qsCnb4v9tDW1/C13roWteo3vW4k0rQiWeUiq9XAEREQTAufGifd1rBQyRHRc7jRc3EiI5w/o56qjzdE/WC8MLG26CEpgdHLxfZcNjUjtw2/+57ay5ZWt+mnq4p5C1HckCJbq+2dG6X1Tn7pzisI213Yk4+z30sTAqV5zUxqX2GjnEWRtxvU+76shfgcpZO2Lxeb5BBMl0dVUTRRodiuJpqPAP6R2EH8TfbivengIVxjC3RzxK3IBPRrskSa2cZjPux5Ku0bFn1YWm3TdEF2j543tHEGUpht2XaeUX2vXvKzSRLH4NVBKji1DDy3Hkt+m+MSqka3tVPdE/+RIebOXOpDFeaCscYq/UwrxvCfeiobJbN7mMUiu5Z98Nufc30jmpSSlvbGDsL6KK8wttaRYDuWDQXtE8S7UG7ImzbLCrvS+MeFtL8BqWDPwHoOAhPyY853MgOflkwfRIC8hWZ1WT+c2snVjbEkZQXlhKMB2m5wpDtQKSY4gu7GCUhE75pE+XWIO08jFdL90LKod4KpypDkyByoIq6exONPRnqpy1FtvyTAS4GgQ6W79+5VXeKdKFxFDca4eyaFr5IWgLIzjICTjQU6d4jjbgP7xVRNwaCIWVPSEXf7I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8676002)(336012)(6666004)(54906003)(36860700001)(47076005)(2616005)(110136005)(82310400003)(426003)(81166007)(70206006)(26005)(186003)(70586007)(5660300002)(7696005)(508600001)(356005)(2906002)(4326008)(8936002)(36756003)(316002)(1076003)(83380400001)(16526019)(30864003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 18:54:52.7540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d94f74c1-55ae-464c-d0e2-08d98f441b58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1182
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Create new family operation routines and define them respectively.
This would simplify adding support for future platforms.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
Changes since v3:
1. Defined new family operation routines

Changs since v2:
1. new patch

 drivers/edac/amd64_edac.c | 291 ++++++++++++++++++++++----------------
 drivers/edac/amd64_edac.h |   6 +
 2 files changed, 174 insertions(+), 123 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4fce75013674..131ed19f69dd 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1204,10 +1204,7 @@ static void __dump_misc_regs(struct amd64_pvt *pvt)
 /* Display and decode various NB registers for debug purposes. */
 static void dump_misc_regs(struct amd64_pvt *pvt)
 {
-	if (pvt->umc)
-		__dump_misc_regs_df(pvt);
-	else
-		__dump_misc_regs(pvt);
+	pvt->ops->display_misc_regs(pvt);
 
 	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
 
@@ -1217,25 +1214,31 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
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
-			pvt->csels[umc].m_cnt = 2;
-		}
+	pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
+	pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 8;
+}
 
-	} else {
-		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
-		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
+static void f15m30_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
+	pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
+}
+
+static void fmisc_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
+	pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
+}
+
+static void f17_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	int umc;
+
+	for_each_umc(umc) {
+		pvt->csels[umc].b_cnt = 4;
+		pvt->csels[umc].m_cnt = 2;
 	}
 }
 
@@ -1297,10 +1300,10 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 {
 	int cs;
 
-	prep_chip_selects(pvt);
+	pvt->ops->prep_chip_select(pvt);
 
-	if (pvt->umc)
-		return read_umc_base_mask(pvt);
+	if (pvt->ops->get_base_mask)
+		return pvt->ops->get_base_mask(pvt);
 
 	for_each_chip_select(cs, 0, pvt) {
 		int reg0   = DCSB0 + (cs * 4);
@@ -1869,37 +1872,12 @@ static int f16_dbam_to_chip_select(struct amd64_pvt *pvt, u8 dct,
 		return ddr3_cs_size(cs_mode, false);
 }
 
-static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
-				    unsigned int cs_mode, int csrow_nr)
+static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
+				  int csrow_nr, int dimm)
 {
-	u32 addr_mask_orig, addr_mask_deinterleaved;
 	u32 msb, weight, num_zero_bits;
-	int dimm, size = 0;
-
-	/* No Chip Selects are enabled. */
-	if (!cs_mode)
-		return size;
-
-	/* Requested size of an even CS but none are enabled. */
-	if (!(cs_mode & CS_EVEN) && !(csrow_nr & 1))
-		return size;
-
-	/* Requested size of an odd CS but none are enabled. */
-	if (!(cs_mode & CS_ODD) && (csrow_nr & 1))
-		return size;
-
-	/*
-	 * There is one mask per DIMM, and two Chip Selects per DIMM.
-	 *	CS0 and CS1 -> DIMM0
-	 *	CS2 and CS3 -> DIMM1
-	 */
-	dimm = csrow_nr >> 1;
-
-	/* Asymmetric dual-rank DIMM support. */
-	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
-		addr_mask_orig = pvt->csels[umc].csmasks_sec[dimm];
-	else
-		addr_mask_orig = pvt->csels[umc].csmasks[dimm];
+	u32 addr_mask_deinterleaved;
+	int size = 0;
 
 	/*
 	 * The number of zero bits in the mask is equal to the number of bits
@@ -1930,6 +1908,40 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	return size >> 10;
 }
 
+static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
+				    unsigned int cs_mode, int csrow_nr)
+{
+	u32 addr_mask_orig;
+	int dimm, size = 0;
+
+	/* No Chip Selects are enabled. */
+	if (!cs_mode)
+		return size;
+
+	/* Requested size of an even CS but none are enabled. */
+	if (!(cs_mode & CS_EVEN) && !(csrow_nr & 1))
+		return size;
+
+	/* Requested size of an odd CS but none are enabled. */
+	if (!(cs_mode & CS_ODD) && (csrow_nr & 1))
+		return size;
+
+	/*
+	 * There is one mask per DIMM, and two Chip Selects per DIMM.
+	 *	CS0 and CS1 -> DIMM0
+	 *	CS2 and CS3 -> DIMM1
+	 */
+	dimm = csrow_nr >> 1;
+
+	/* Asymmetric dual-rank DIMM support. */
+	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
+		addr_mask_orig = pvt->csels[umc].csmasks_sec[dimm];
+	else
+		addr_mask_orig = pvt->csels[umc].csmasks[dimm];
+
+	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, dimm);
+}
+
 static void read_dram_ctl_register(struct amd64_pvt *pvt)
 {
 
@@ -2512,143 +2524,168 @@ static void debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 	}
 }
 
+/* Prototypes for family specific ops routines */
+static int init_csrows(struct mem_ctl_info *mci);
+static int init_csrows_df(struct mem_ctl_info *mci);
+static void __read_mc_regs_df(struct amd64_pvt *pvt);
+static void find_umc_channel(struct mce *m, struct err_info *err);
+
+static const struct low_ops k8_ops = {
+	.early_channel_count	= k8_early_channel_count,
+	.map_sysaddr_to_csrow	= k8_map_sysaddr_to_csrow,
+	.dbam_to_cs		= k8_dbam_to_chip_select,
+	.prep_chip_select	= k8_prep_chip_selects,
+	.display_misc_regs	= __dump_misc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f10_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f10_dbam_to_chip_select,
+	.prep_chip_select	= fmisc_prep_chip_selects,
+	.display_misc_regs	= __dump_misc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f15_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f15_dbam_to_chip_select,
+	.prep_chip_select	= fmisc_prep_chip_selects,
+	.display_misc_regs	= __dump_misc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f15m30_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f16_dbam_to_chip_select,
+	.prep_chip_select	= f15m30_prep_chip_selects,
+	.display_misc_regs	= __dump_misc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f16_x_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f15_m60h_dbam_to_chip_select,
+	.prep_chip_select	= fmisc_prep_chip_selects,
+	.display_misc_regs	= __dump_misc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f16_ops = {
+	.early_channel_count	= f1x_early_channel_count,
+	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
+	.dbam_to_cs		= f16_dbam_to_chip_select,
+	.prep_chip_select	= fmisc_prep_chip_selects,
+	.display_misc_regs	= __dump_misc_regs,
+	.populate_csrows	= init_csrows,
+};
+
+static const struct low_ops f17_ops = {
+	.early_channel_count	= f17_early_channel_count,
+	.dbam_to_cs		= f17_addr_mask_to_cs_size,
+	.prep_chip_select	= f17_prep_chip_selects,
+	.get_base_mask		= read_umc_base_mask,
+	.display_misc_regs	= __dump_misc_regs_df,
+	.get_mc_regs		= __read_mc_regs_df,
+	.populate_csrows	= init_csrows_df,
+	.get_umc_err_info	= find_umc_channel,
+};
+
 static struct amd64_family_type family_types[] = {
 	[K8_CPUS] = {
 		.ctl_name = "K8",
 		.f1_id = PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP,
 		.f2_id = PCI_DEVICE_ID_AMD_K8_NB_MEMCTL,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= k8_early_channel_count,
-			.map_sysaddr_to_csrow	= k8_map_sysaddr_to_csrow,
-			.dbam_to_cs		= k8_dbam_to_chip_select,
-		}
+		.ops = k8_ops,
 	},
 	[F10_CPUS] = {
 		.ctl_name = "F10h",
 		.f1_id = PCI_DEVICE_ID_AMD_10H_NB_MAP,
 		.f2_id = PCI_DEVICE_ID_AMD_10H_NB_DRAM,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f10_dbam_to_chip_select,
-		}
+		.ops = f10_ops,
 	},
 	[F15_CPUS] = {
 		.ctl_name = "F15h",
 		.f1_id = PCI_DEVICE_ID_AMD_15H_NB_F1,
 		.f2_id = PCI_DEVICE_ID_AMD_15H_NB_F2,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f15_dbam_to_chip_select,
-		}
+		.ops = f15_ops,
 	},
 	[F15_M30H_CPUS] = {
 		.ctl_name = "F15h_M30h",
 		.f1_id = PCI_DEVICE_ID_AMD_15H_M30H_NB_F1,
 		.f2_id = PCI_DEVICE_ID_AMD_15H_M30H_NB_F2,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f16_dbam_to_chip_select,
-		}
+		.ops = f15m30_ops,
 	},
 	[F15_M60H_CPUS] = {
 		.ctl_name = "F15h_M60h",
 		.f1_id = PCI_DEVICE_ID_AMD_15H_M60H_NB_F1,
 		.f2_id = PCI_DEVICE_ID_AMD_15H_M60H_NB_F2,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f15_m60h_dbam_to_chip_select,
-		}
+		.ops = f16_x_ops,
 	},
 	[F16_CPUS] = {
 		.ctl_name = "F16h",
 		.f1_id = PCI_DEVICE_ID_AMD_16H_NB_F1,
 		.f2_id = PCI_DEVICE_ID_AMD_16H_NB_F2,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f16_dbam_to_chip_select,
-		}
+		.ops = f16_ops,
 	},
 	[F16_M30H_CPUS] = {
 		.ctl_name = "F16h_M30h",
 		.f1_id = PCI_DEVICE_ID_AMD_16H_M30H_NB_F1,
 		.f2_id = PCI_DEVICE_ID_AMD_16H_M30H_NB_F2,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f16_dbam_to_chip_select,
-		}
+		.ops = f16_ops,
 	},
 	[F17_CPUS] = {
 		.ctl_name = "F17h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_17H_DF_F6,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
+		.ops = f17_ops,
 	},
 	[F17_M10H_CPUS] = {
 		.ctl_name = "F17h_M10h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
+		.ops = f17_ops,
 	},
 	[F17_M30H_CPUS] = {
 		.ctl_name = "F17h_M30h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
 		.max_mcs = 8,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
+		.ops = f17_ops,
 	},
 	[F17_M60H_CPUS] = {
 		.ctl_name = "F17h_M60h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F6,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
+		.ops = f17_ops,
 	},
 	[F17_M70H_CPUS] = {
 		.ctl_name = "F17h_M70h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
 		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
+		.ops = f17_ops,
 	},
 	[F19_CPUS] = {
 		.ctl_name = "F19h",
 		.f0_id = PCI_DEVICE_ID_AMD_19H_DF_F0,
 		.f6_id = PCI_DEVICE_ID_AMD_19H_DF_F6,
 		.max_mcs = 8,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
+		.ops = f17_ops,
 	},
 };
 
@@ -2900,9 +2937,10 @@ static inline void decode_bus_error(int node_id, struct mce *m)
  * the instance_id. For example, instance_id=0xYXXXXX where Y is the channel
  * number.
  */
-static int find_umc_channel(struct mce *m)
+static void find_umc_channel(struct mce *m, struct err_info *err)
 {
-	return (m->ipid & GENMASK(31, 0)) >> 20;
+	err->channel = (m->ipid & GENMASK(31, 0)) >> 20;
+	err->csrow = m->synd & 0x7;
 }
 
 static void decode_umc_error(int node_id, struct mce *m)
@@ -2924,7 +2962,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 	if (m->status & MCI_STATUS_DEFERRED)
 		ecc_type = 3;
 
-	err.channel = find_umc_channel(m);
+	pvt->ops->get_umc_err_info(m, &err);
 
 	if (!(m->status & MCI_STATUS_SYNDV)) {
 		err.err_code = ERR_SYND;
@@ -2940,8 +2978,6 @@ static void decode_umc_error(int node_id, struct mce *m)
 			err.err_code = ERR_CHANNEL;
 	}
 
-	err.csrow = m->synd & 0x7;
-
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
@@ -3106,8 +3142,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 		edac_dbg(0, "  TOP_MEM2 disabled\n");
 	}
 
-	if (pvt->umc) {
-		__read_mc_regs_df(pvt);
+	if (pvt->ops->get_mc_regs) {
+		pvt->ops->get_mc_regs(pvt);
+
 		amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
 
 		goto skip;
@@ -3277,9 +3314,6 @@ static int init_csrows(struct mem_ctl_info *mci)
 	int nr_pages = 0;
 	u32 val;
 
-	if (pvt->umc)
-		return init_csrows_df(mci);
-
 	amd64_read_pci_cfg(pvt->F3, NBCFG, &val);
 
 	pvt->nbcfg = val;
@@ -3703,6 +3737,17 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		return NULL;
 	}
 
+	/* ops required for all the families */
+	if (!pvt->ops->early_channel_count | !pvt->ops->prep_chip_select |
+	    !pvt->ops->display_misc_regs | !pvt->ops->dbam_to_cs |
+	    !pvt->ops->populate_csrows)
+		return NULL;
+
+	/* ops required for families 17h and later */
+	if (pvt->fam >= 0x17 && (!pvt->ops->get_base_mask |
+	    !pvt->ops->get_umc_err_info | !pvt->ops->get_mc_regs))
+		return NULL;
+
 	return fam_type;
 }
 
@@ -3786,7 +3831,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 
 	setup_mci_misc_attrs(mci);
 
-	if (init_csrows(mci))
+	if (pvt->ops->populate_csrows(mci))
 		mci->edac_cap = EDAC_FLAG_NONE;
 
 	ret = -ENODEV;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 85aa820bc165..ce21b3cf0825 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -472,6 +472,12 @@ struct low_ops {
 					 struct err_info *);
 	int (*dbam_to_cs)		(struct amd64_pvt *pvt, u8 dct,
 					 unsigned cs_mode, int cs_mask_nr);
+	void (*prep_chip_select)(struct amd64_pvt *pvt);
+	void (*get_base_mask)(struct amd64_pvt *pvt);
+	void (*display_misc_regs)(struct amd64_pvt *pvt);
+	void (*get_mc_regs)(struct amd64_pvt *pvt);
+	int (*populate_csrows)(struct mem_ctl_info *mci);
+	void (*get_umc_err_info)(struct mce *m, struct err_info *err);
 };
 
 struct amd64_family_type {
-- 
2.25.1

