Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72FC4A7368
	for <lists+linux-edac@lfdr.de>; Wed,  2 Feb 2022 15:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241633AbiBBOn1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Feb 2022 09:43:27 -0500
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:46559
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237021AbiBBOn0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 2 Feb 2022 09:43:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AM6X5eDZ08ttcSYS5NziNvDUnMvp0Ux09+5X2yYNXCAWM425DMoqrDAq5FrYpHd/T2/42XhMZn0d+sILuQ0xlGwWB3kPi0lenhD8GCpyxtIpLJAUM3iAZ61mZWlo/4hh7zmr9CW01ELTgrfSPnnEbJ9DuZ4DzLdKq+K3qEtMi10XqeVpNwklB7cUzA5LhPSSvAysWzBYnDzpJasdCLyyHSOvrNJOT4LELlgjqsLuCdZVnEcw3BPwQfTkZ7Io2eyaB7XEu9nKYrNc2DMH38cb8HeGQIkSs2/v4/viilYsFuEBNUyHSUKqqQBGXONPpHz/L8gR3uFXgroLNBLDWNlHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBecPX9RDF1QIniJiMsGTPPoJXrDb+oxXGBhWVQ//nk=;
 b=Q01AYaVFTEL8uRKccij4fjotG9m/VXzaTcgZKdVp9aQ67JdCDph3oX4lOgj6rVrqlFeRO3gpKAJ8DTeKQSKBUpIxA4ulIgiSzA6siFONDbCN250jmJVO28IXdC4SM9UW8BPL2dsHsga+nd/WodKD7LCxamo4RKNYEY7FDNaFIzqRQBIyH4G7RpVOjovaN3gbPVDGhQB3DvTLlpGrVh4a0Ut461do9Fozx/ZQYIb45GyoCrAuI5P79bmaMxfuF0vdmXgMHt3H3pgnEvyv1WRiFgKKVoQ2OPF01HPbo3xUwGC9uWfoB05LxFe4zjzO3ITtfQrOYqoejK2A4FsyhDmocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBecPX9RDF1QIniJiMsGTPPoJXrDb+oxXGBhWVQ//nk=;
 b=sTSttnuixWW26n+u/e7Iu705DItODHzBQsoQZidiKEmpo/w2r2lYUVUWt5J8DOG15RmLz9fy4ZcU3JMitWPnPhjgTQVc6LqadTciL8xVCOU+eTUxLxLhjCOg1l+fcoX9VpAz4ft1hezjQcbFs11RnV/eP+gdC6/oIq/uecHlNYM=
Received: from DM5PR19CA0058.namprd19.prod.outlook.com (2603:10b6:3:116::20)
 by CY4PR1201MB0150.namprd12.prod.outlook.com (2603:10b6:910:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 14:43:23 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::f9) by DM5PR19CA0058.outlook.office365.com
 (2603:10b6:3:116::20) with Microsoft SMTP Server (version=TLS1_2,
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
 2022 08:43:21 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH v4 1/2] EDAC/amd64: Set memory type per DIMM
Date:   Wed, 2 Feb 2022 14:43:06 +0000
Message-ID: <20220202144307.2678405-2-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef5e8d34-d787-40fc-77ab-08d9e65a5d24
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0150:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0150062339B9E6E52E3FD971F8279@CY4PR1201MB0150.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:98;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFJTEwQ178iTfixb8D9ii7qLrckHi/83SQtLFYQNt6F4kMTQrxcqfsjr/GvZSvYVegdSDTT2PpXFxLk9mQiEyjr3121r7BG+4xHofTaIesj3gSeDEdtT5G02Y8dAjTwW3K8Hje8pbmpDbx4LJeuBkjaw0nYbBA07jBwNG8itc1ZD8TuTlgu3ViHpr5iYoBsOesxQcKjwXUzLobQJ0a2r1d1FkNb1xxIaeB2A+LV73UBq62nLPfSCuwgseeseChpd0KxIS4IooDQ+1tlMZ67gXNbFTjUCfizTz8zL580YDEtF+ocGbbUoEMq/flqTzv41peLSnuAZl6X2GEZy31T5Z/eLhAYN1tapZ+HBtJ0NKloOAt+Ou5EIj7eyP70wrVKRBpVuBWCqoTCt44UTNzdIwcLKqtLkkweSqpeQRHeiJRP1wUPelB892pdObPKJMpgqGsZUfLZhge66vh81E3pYidF4cbshQ8WJA/Z+em6VuPxtiZkVm7/OGyLyymGr92vlCM2NbxwapIAPxlZftpLQINLFku067eWyOPJgAkZKjJUGXBF58a74NjJhCycxT3EpTL1OazDZjPE74ly9ybciCANs+3w5EB+rKLImHEGOnc5GfWDU/T8hvJeFclBx0UBA9hJiwBPD8jd+vEw4tmpNwx1V57KTlczdmJmDw7F0ezYZtLrRA/RGp5E74Z2Odb7eJHKEmDJgePkI8a0k7ukyiXllsxUIoYWYNxumEyqywYo2PXM25RU0QzXZvFAzUUJI8UqGx9h1Zyy8soVdARhD1aZEOJLIaBUrtCtfDi9RH2A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(2906002)(81166007)(966005)(16526019)(1076003)(4326008)(186003)(336012)(426003)(26005)(7696005)(44832011)(6666004)(5660300002)(356005)(82310400004)(86362001)(508600001)(36756003)(40460700003)(36860700001)(316002)(6916009)(47076005)(54906003)(70206006)(70586007)(8936002)(83380400001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:43:23.2658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5e8d34-d787-40fc-77ab-08d9e65a5d24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0150
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Current AMD systems allow mixing of DIMM types within a system. However,
DIMMs within a channel, i.e. managed by a single Unified Memory
Controller (UMC), must be of the same type.

Handle this possible configuration by checking and setting the memory
type for each individual "UMC" structure.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211228200615.412999-2-yazen.ghannam@amd.com

v3->v4:
* Cache dram_type in struct umc.

v2->v3:
* Change patch to properly handle systems with different DIMM types.

v1->v2:
* Was patch 3 in v1.
* Update commit message.

 drivers/edac/amd64_edac.c | 47 +++++++++++++++++++++++++++++----------
 drivers/edac/amd64_edac.h |  3 +++
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fba609ada0e6..49e384207ce0 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1429,7 +1429,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
 				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
 
-		if (pvt->dram_type == MEM_LRDDR4) {
+		if (umc->dram_type == MEM_LRDDR4) {
 			amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ADDR_CFG, &tmp);
 			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
 					i, 1 << ((tmp >> 4) & 0x3));
@@ -1616,19 +1616,40 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 	}
 }
 
+static void _determine_memory_type_df(struct amd64_umc *umc)
+{
+	if (!(umc->sdp_ctrl & UMC_SDP_INIT)) {
+		umc->dram_type = MEM_EMPTY;
+		return;
+	}
+
+	if (umc->dimm_cfg & BIT(5))
+		umc->dram_type = MEM_LRDDR4;
+	else if (umc->dimm_cfg & BIT(4))
+		umc->dram_type = MEM_RDDR4;
+	else
+		umc->dram_type = MEM_DDR4;
+}
+
+static void determine_memory_type_df(struct amd64_pvt *pvt)
+{
+	struct amd64_umc *umc;
+	u32 i;
+
+	for_each_umc(i) {
+		umc = &pvt->umc[i];
+
+		_determine_memory_type_df(umc);
+		edac_dbg(1, "  UMC%d DIMM type: %s\n", i, edac_mem_types[umc->dram_type]);
+	}
+}
+
 static void determine_memory_type(struct amd64_pvt *pvt)
 {
 	u32 dram_ctrl, dcsm;
 
-	if (pvt->umc) {
-		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
-			pvt->dram_type = MEM_LRDDR4;
-		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
-			pvt->dram_type = MEM_RDDR4;
-		else
-			pvt->dram_type = MEM_DDR4;
-		return;
-	}
+	if (pvt->umc)
+		return determine_memory_type_df(pvt);
 
 	switch (pvt->fam) {
 	case 0xf:
@@ -3452,7 +3473,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	read_dct_base_mask(pvt);
 
 	determine_memory_type(pvt);
-	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
+
+	if (!pvt->umc)
+		edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
 
 	determine_ecc_sym_sz(pvt);
 }
@@ -3548,7 +3571,7 @@ static int init_csrows_df(struct mem_ctl_info *mci)
 					pvt->mc_node_id, cs);
 
 			dimm->nr_pages = get_csrow_nr_pages(pvt, umc, cs);
-			dimm->mtype = pvt->dram_type;
+			dimm->mtype = pvt->umc[umc].dram_type;
 			dimm->edac_mode = edac_mode;
 			dimm->dtype = dev_type;
 			dimm->grain = 64;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 352bda9803f6..09ad28299c57 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -344,6 +344,9 @@ struct amd64_umc {
 	u32 sdp_ctrl;		/* SDP Control reg */
 	u32 ecc_ctrl;		/* DRAM ECC Control reg */
 	u32 umc_cap_hi;		/* Capabilities High reg */
+
+	/* cache the dram_type */
+	enum mem_type dram_type;
 };
 
 struct amd64_pvt {
-- 
2.25.1

