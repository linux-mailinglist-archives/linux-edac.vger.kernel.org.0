Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB4152006A
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbiEIPAB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 11:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237890AbiEIO7y (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 10:59:54 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11BB24D625;
        Mon,  9 May 2022 07:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcB8BthxMk0mNQovMnxevWsHtnVfmvAQu24W5H7vIvVy89qMTxFmeT8oBU/R770EDd4atin5HrHuILoYmhPNlHxiQJsNFV8qQblJdigCZYFAmLmNuv3MvxXUgfd132oQu7grUufAM1KimlGgyp7XRJXNeYQZnjFaaN8JZUysQZy/POPaC0fKDGCA2sKElh51Tnd8dOLM9eCGDEW7Wu9AzFRD97lUpM3Ta+IBjYJL3Hnq81ZDswrVOJS7E+x9yGkhbOUcOdBML9YpkXVglvaBeAu3vdVqJfqSxQv47YEe5ERZ9i33OmU0p1g2a3bnNBjRIaBHX6UvSLBvbxYU0F5rjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp84w/f/1ll8rRuNXNX7kNxM8/ZJrUfBIZsMpfKbGUk=;
 b=CsdZtmvRpKY/Te9N5ZvqmXm95goT+kiYF+SNwVAPlB+mwCWZ5IFuMpMawq2V4E7PIn9nd/epQ8c9QEwvlSLrzxlouniwrx2LtZp/4IrweHU4aAbCM2qgvO4bKV4lQ09z0Q9IZKqni7+uYZqek2GP/QXmhkOjmM0Z+w1idoLrUurwH9o1vDEYQRcpCzaD/YltaLfM7CQSxG6UwXHwyN8Y8YlGWFQabFkYrh/kDxDb7g99TC6DYMUKBTxFkpbCZKOxQlqIB23EVEF6Ce+Nm+SaN4Nmns7i/gz1rgl5+E2StHydU07FZV5saKbv7YCXQxUSp1yaeBxzrh/lNzq1jDmEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp84w/f/1ll8rRuNXNX7kNxM8/ZJrUfBIZsMpfKbGUk=;
 b=30B0pqGUKv0Ylkcdtt3OCLdMlbpqkAFWhOo0mTC0+nW1+uX6/WS76473KEDNFPZpyDaV87j4QmJhWBjuzpgi2q5utv9i6LC15M3WhjVxwS9t4p51xm7QftSpdjg9ur2xsyDPzOSKp9YdcF6bd9eqjv7UMVBIEDk8aE3EX5x/Bx0=
Received: from MW4PR03CA0013.namprd03.prod.outlook.com (2603:10b6:303:8f::18)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 14:55:55 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::42) by MW4PR03CA0013.outlook.office365.com
 (2603:10b6:303:8f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Mon, 9 May 2022 14:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:54 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:47 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 05/18] EDAC/amd64: Merge struct amd64_family_type into struct amd64_pvt
Date:   Mon, 9 May 2022 14:55:21 +0000
Message-ID: <20220509145534.44912-6-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509145534.44912-1-yazen.ghannam@amd.com>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdbb7a10-1f44-4a70-7174-08da31cc0484
X-MS-TrafficTypeDiagnostic: CH2PR12MB4040:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4040741387300B022B4AD942F8C69@CH2PR12MB4040.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlhLkyWSn0ZHHBaEGqj7mXmt+aFGp+T+Jhxka23ppym8Z8lYb9cyqJMqUfYOxu8qJ9eDQRFKdKOdN6eIa3jkmmUO40Ys8MM9B4W4Aiye920uwflQxowIAtfPBIHqFgEk9aPWmULiM/T2F8xNbDi1SbDo9RblhTehFbMMdwCNR1BHmFWk88ZUv9FwQ1IkqV+oVEKlIvx+2FZSmSU8JK8MSYMLyJPXsXs8sgnEx4ONZFIs0RmuRV4dTX7NwVbNGy/fLWaBlra2YPc0ZSdq47+3Z7LuB8Dj6WuSvSmsWIeL0rYySMY+/napAra3kybI47kYXDBISl7ooy7wXVq6+EUk73Xrtb6chgbAsx6tkOCgdGaJjf1yTPc1CuOw1GpkRqbjGZQJuYYhuYHYYdkuy/Pm9oAVZUhlvYrP6ujrqviwQVN9ZRpYvyJEmqKOcNm47Mgpsf7B6+83s0kG6Kmm3MOUzHasHWNrS/EnIQFb1HVyJDtJ2vNVyERHpTvnjzbj/YPs6S46sfZX1ZfwIsQdnKjhYHx96Pt4VCWlUjyuqwqv88kykoalnXm2RpWOOvoD0HwqTsM+zmk5PgOhC0TIQkWoc/Av3r5vnGGHZ8cIFQOI/4ASSvPH/Aq9V2lxAi42DdrcqVZDlq3+8HyqkrLygaZtJcc/XbU3s2LWQTm6Q1Y8DGbhjIk0udEmxMkm6jRP49UUiDr7hUmvHzcNHBLXf19u0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(86362001)(8936002)(7696005)(6666004)(508600001)(44832011)(30864003)(81166007)(83380400001)(356005)(5660300002)(26005)(2616005)(36860700001)(40460700003)(336012)(16526019)(47076005)(1076003)(186003)(426003)(54906003)(70586007)(110136005)(316002)(70206006)(4326008)(82310400005)(36756003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:54.3349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbb7a10-1f44-4a70-7174-08da31cc0484
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Rename the Family 17h functions to use a "umc" prefix. This is to
indicate that the functions apply to all modern CPU familes (17h, 18h,
and 19h) which all have Unified Memory Controllers (UMCs).

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 353 +++++++++++++-------------------------
 drivers/edac/amd64_edac.h |  66 +++----
 2 files changed, 140 insertions(+), 279 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index e0f99b8edc97..3d569290d4cf 100644
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
@@ -442,7 +440,7 @@ static void get_cs_base_and_mask(struct amd64_pvt *pvt, int csrow, u8 dct,
 	for (i = 0; i < pvt->csels[dct].m_cnt; i++)
 
 #define for_each_umc(i) \
-	for (i = 0; i < fam_type->max_mcs; i++)
+	for (i = 0; i < pvt->max_mcs; i++)
 
 /*
  * @input_addr is an InputAddr associated with the node given by mci. Return the
@@ -1425,7 +1423,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 
 		if (umc->dram_type == MEM_LRDDR4 || umc->dram_type == MEM_LRDDR5) {
 			amd_smn_read(pvt->mc_node_id,
-				     umc_base + get_umc_reg(UMCCH_ADDR_CFG),
+				     umc_base + get_umc_reg(pvt, UMCCH_ADDR_CFG),
 				     &tmp);
 			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
 					i, 1 << ((tmp >> 4) & 0x3));
@@ -1498,7 +1496,7 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 
 		for_each_umc(umc) {
 			pvt->csels[umc].b_cnt = 4;
-			pvt->csels[umc].m_cnt = fam_type->flags.zn_regs_v2 ? 4 : 2;
+			pvt->csels[umc].m_cnt = pvt->flags.zn_regs_v2 ? 4 : 2;
 		}
 
 	} else {
@@ -1538,7 +1536,7 @@ static void read_umc_base_mask(struct amd64_pvt *pvt)
 		}
 
 		umc_mask_reg = get_umc_base(umc) + UMCCH_ADDR_MASK;
-		umc_mask_reg_sec = get_umc_base(umc) + get_umc_reg(UMCCH_ADDR_MASK_SEC);
+		umc_mask_reg_sec = get_umc_base(umc) + get_umc_reg(pvt, UMCCH_ADDR_MASK_SEC);
 
 		for_each_chip_select_mask(cs, umc, pvt) {
 			mask = &pvt->csels[umc].csmasks[cs];
@@ -1626,7 +1624,7 @@ static void determine_memory_type_df(struct amd64_pvt *pvt)
 		 * Check if the system supports the "DDR Type" field in UMC Config
 		 * and has DDR5 DIMMs in use.
 		 */
-		if (fam_type->flags.zn_regs_v2 && ((umc->umc_cfg & GENMASK(2, 0)) == 0x1)) {
+		if (pvt->flags.zn_regs_v2 && ((umc->umc_cfg & GENMASK(2, 0)) == 0x1)) {
 			if (umc->dimm_cfg & BIT(5))
 				umc->dram_type = MEM_LRDDR5;
 			else if (umc->dimm_cfg & BIT(4))
@@ -2027,7 +2025,7 @@ static int f1x_early_channel_count(struct amd64_pvt *pvt)
 	return channels;
 }
 
-static int f17_early_channel_count(struct amd64_pvt *pvt)
+static int umc_early_channel_count(struct amd64_pvt *pvt)
 {
 	int i, channels = 0;
 
@@ -2167,7 +2165,7 @@ static int f16_dbam_to_chip_select(struct amd64_pvt *pvt, u8 dct,
 		return ddr3_cs_size(cs_mode, false);
 }
 
-static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
+static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
 	u32 addr_mask_orig, addr_mask_deinterleaved;
@@ -2207,7 +2205,7 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	 */
 	dimm = csrow_nr >> 1;
 
-	if (!fam_type->flags.zn_regs_v2)
+	if (!pvt->flags.zn_regs_v2)
 		cs_mask_nr >>= 1;
 
 	/* Asymmetric dual-rank DIMM support. */
@@ -2827,151 +2825,6 @@ static void debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 	}
 }
 
-static struct amd64_family_type family_types[] = {
-	[K8_CPUS] = {
-		.ctl_name = "K8",
-		.f1_id = PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP,
-		.f2_id = PCI_DEVICE_ID_AMD_K8_NB_MEMCTL,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= k8_early_channel_count,
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
-			.early_channel_count	= f1x_early_channel_count,
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
-			.early_channel_count	= f1x_early_channel_count,
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
-			.early_channel_count	= f1x_early_channel_count,
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
-			.early_channel_count	= f1x_early_channel_count,
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
-			.early_channel_count	= f1x_early_channel_count,
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
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f16_dbam_to_chip_select,
-		}
-	},
-	[F17_CPUS] = {
-		.ctl_name = "F17h",
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F17_M10H_CPUS] = {
-		.ctl_name = "F17h_M10h",
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F17_M30H_CPUS] = {
-		.ctl_name = "F17h_M30h",
-		.max_mcs = 8,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F17_M60H_CPUS] = {
-		.ctl_name = "F17h_M60h",
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F17_M70H_CPUS] = {
-		.ctl_name = "F17h_M70h",
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F19_CPUS] = {
-		.ctl_name = "F19h",
-		.max_mcs = 8,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F19_M10H_CPUS] = {
-		.ctl_name = "F19h_M10h",
-		.max_mcs = 12,
-		.flags.zn_regs_v2 = 1,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F19_M50H_CPUS] = {
-		.ctl_name = "F19h_M50h",
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-};
-
 /*
  * These are tables of eigenvectors (one per line) which can be used for the
  * construction of the syndrome tables. The modified syndrome search algorithm
@@ -3368,7 +3221,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + get_umc_reg(UMCCH_DIMM_CFG), &umc->dimm_cfg);
+		amd_smn_read(nid, umc_base + get_umc_reg(pvt, UMCCH_DIMM_CFG), &umc->dimm_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
 		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
 		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
@@ -3897,7 +3750,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 
 	mci->edac_cap		= determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
-	mci->ctl_name		= fam_type->ctl_name;
+	mci->ctl_name		= pvt->ctl_name;
 	mci->dev_name		= pci_name(pvt->F3);
 	mci->ctl_page_to_phys	= NULL;
 
@@ -3906,114 +3759,149 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 	mci->get_sdram_scrub_rate = get_scrub_rate;
 }
 
-/*
- * returns a pointer to the family descriptor on success, NULL otherwise.
- */
-static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
+static struct low_ops umc_ops = {
+	.early_channel_count		= umc_early_channel_count,
+	.dbam_to_cs			= umc_addr_mask_to_cs_size,
+};
+
+/* Use Family 16h versions for defaults and adjust as needed below. */
+static struct low_ops dct_ops = {
+	.early_channel_count		= f1x_early_channel_count,
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
+		pvt->ops->early_channel_count		= k8_early_channel_count;
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
+			break;
+		case 0x10 ... 0x1f:
+			pvt->ctl_name			= "F19h_M10h";
+			pvt->max_mcs			= 12;
+			pvt->flags.zn_regs_v2		= 1;
 			break;
-		} else if (pvt->model >= 0x20 && pvt->model <= 0x2f) {
-			fam_type = &family_types[F17_M70H_CPUS];
-			pvt->ops = &family_types[F17_M70H_CPUS].ops;
-			fam_type->ctl_name = "F19h_M20h";
+		case 0x20 ... 0x2f:
+			pvt->ctl_name			= "F19h_M20h";
 			break;
-		} else if (pvt->model >= 0x50 && pvt->model <= 0x5f) {
-			fam_type = &family_types[F19_M50H_CPUS];
-			pvt->ops = &family_types[F19_M50H_CPUS].ops;
-			fam_type->ctl_name = "F19h_M50h";
+		case 0x50 ... 0x5f:
+			pvt->ctl_name			= "F19h_M50h";
 			break;
-		} else if (pvt->model >= 0xa0 && pvt->model <= 0xaf) {
-			fam_type = &family_types[F19_M10H_CPUS];
-			pvt->ops = &family_types[F19_M10H_CPUS].ops;
-			fam_type->ctl_name = "F19h_MA0h";
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
@@ -4030,12 +3918,12 @@ static int hw_info_get(struct amd64_pvt *pvt)
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
@@ -4081,7 +3969,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	 * only one channel. Also, this simplifies handling later for the price
 	 * of a couple of KBs tops.
 	 */
-	layers[1].size = fam_type->max_mcs;
+	layers[1].size = pvt->max_mcs;
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
@@ -4111,7 +3999,7 @@ static bool instance_has_memory(struct amd64_pvt *pvt)
 	bool cs_enabled = false;
 	int cs = 0, dct = 0;
 
-	for (dct = 0; dct < fam_type->max_mcs; dct++) {
+	for (dct = 0; dct < pvt->max_mcs; dct++) {
 		for_each_chip_select(cs, dct, pvt)
 			cs_enabled |= csrow_enabled(cs, dct, pvt);
 	}
@@ -4140,9 +4028,8 @@ static int probe_one_instance(unsigned int nid)
 	pvt->mc_node_id	= nid;
 	pvt->F3 = F3;
 
-	ret = -ENODEV;
-	fam_type = per_family_init(pvt);
-	if (!fam_type)
+	ret = per_family_init(pvt);
+	if (ret < 0)
 		goto err_enable;
 
 	ret = hw_info_get(pvt);
@@ -4181,11 +4068,7 @@ static int probe_one_instance(unsigned int nid)
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
index 7cfac50d6558..a4a27208532c 100644
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
@@ -334,11 +315,21 @@ struct amd64_umc {
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
 
 	/* pci_device handles which we utilize */
-	struct pci_dev *F0, *F1, *F2, *F3, *F6;
+	struct pci_dev *F1, *F2, *F3;
 
 	u16 mc_node_id;		/* MC index of this MC node */
 	u8 fam;			/* CPU family */
@@ -376,6 +367,12 @@ struct amd64_pvt {
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
 
@@ -466,30 +463,11 @@ struct ecc_settings {
  * functions and per device encoding/decoding logic.
  */
 struct low_ops {
-	int (*early_channel_count)	(struct amd64_pvt *pvt);
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
+	int  (*early_channel_count)(struct amd64_pvt *pvt);
+	void (*map_sysaddr_to_csrow)(struct mem_ctl_info *mci, u64 sys_addr,
+				     struct err_info *err);
+	int  (*dbam_to_cs)(struct amd64_pvt *pvt, u8 dct,
+			   unsigned int cs_mode, int cs_mask_nr);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

