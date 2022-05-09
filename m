Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916EC52007E
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbiEIPAE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 11:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237895AbiEIO7z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 10:59:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566526A715;
        Mon,  9 May 2022 07:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYmzeKxiAAA5EXbq6RwfFuDmsJvDaIf2e2C41Dk9nZxEwQpHowLju8AmHC3sN9WvTp7P6wqfIVKzKM09TSr46d/eLX8CDDEoadAbHReN3MnwYqNbY144oXGJ+cTztLBCLDd0LXDY+mNgS+cRvVeBSrglMYirKJXemN0/SexP1qbn2SwfFBXLTmoaSj7TwvhdEsIrkDpOh0/UtJH2pQ/uzvG8U2FkPriR0jYrjtCLFZo86GebKNewXqAFxXG3UbWQSU82vQkAlZbA8yQoCgZYPyYyb/fL0wmo/kIa8/c5bX3Tuuz9dJGTVYUNwyAR9sh3q+mnB+UXkFPFDHKVequLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF5dL7VQPwYxcVFH1Wz4ttn9SqPOZc0RihBi9oP5638=;
 b=cFRSEn4aitmZl8mt8eKhkMeu7uZBX56jwCR4iusi1pX/RSxjDdDbuUKzGx20al54SpFqRL1yHSiHdxg3SQrT6KL8+70sP9U0AEZ4etTTown58a1qahTr0RIRlELXK94nNDiuiFCdrhTI37VW+2ZrDydont7En3U1c2F07KuA2nk66lq20n3WIyHDZU2msmDDXRk0V7xy36GxT/T/BAn2SQWtOriABcp9XqPKkDzWJWdw2IqSd2SO8TCKN+RP/P7NXW4LPnCn1zyhQiUXqDwxC2eNNSDfv3GTOeuSDPb8gj4kS4jKMgvZOkS12j8xtkjtINftyi2/91QiaasUnwntBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF5dL7VQPwYxcVFH1Wz4ttn9SqPOZc0RihBi9oP5638=;
 b=ZOQWBaOMxiPGbqr5qUE9rq0M8QEmrAeM+d++KMLafYyKJZIzCuLm5mrDew+5hBXLt1gHb7jeO9Iy7dKV4NsAqLHu5aXPumRZ/Cf5uMz8d5exJ/75LQg/liX3P9KIF6RpZfQ6o1D4e7L3YT2567JLWn/dFDeB1x1BsOl+8d9odNA=
Received: from MW4PR03CA0302.namprd03.prod.outlook.com (2603:10b6:303:dd::7)
 by DM5PR12MB4663.namprd12.prod.outlook.com (2603:10b6:4:a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 14:55:57 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::6e) by MW4PR03CA0302.outlook.office365.com
 (2603:10b6:303:dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Mon, 9 May 2022 14:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:56 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:50 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 11/18] EDAC/amd64: Add ecc_enabled() into pvt->ops
Date:   Mon, 9 May 2022 14:55:27 +0000
Message-ID: <20220509145534.44912-12-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa444070-db9e-49f9-4f9b-08da31cc060a
X-MS-TrafficTypeDiagnostic: DM5PR12MB4663:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB46636A8CCF140B17B6EFE7A6F8C69@DM5PR12MB4663.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vG7Ec8C8EnBh4NE9lsq4f1bdPpGqiRXJGbNCV106naOIao1d0hM2ypD6A+xhFuvgz+jn38QbfqEQ+yMK/dqG54TEG/JPWcaC+Dt+lTTp1z6z9Vgchuc9UDoAPTTEy8Jbx2nriQZsXgaccYneuGm4/OrzDcI1kt9rKSBWq9yPSEDCw2WpQQLBp96T1EliZiQfyPkqv4BQrJ4XPP8a0C+sUtgF7ZpmNQ9YcPA4BLCX3LliIPYSG9RX0iY89F0JZOuW5unLakchQ9r+cBxuQf1VgUg/hB9/4yn5Jih7NQOuO9MmtLeaO1lfIRf8011j1kn8D5N0ho/3nTUsoqmoZDKfkil/dnyE/CA3T5zbNzHwlX4aQe6EPs2Jj888E0w4pWgG+PmQhYJdJCFDvmO2YO5Kb+iFxGLjh9jl6mUoRmlhVKOoGZ/z7omaaIyscA+atToAOuB3dg2VB1L9NvyVq1mUb1I1jcASB8X/xvHaKPuRgrVAuZTdnJ8sibTIH6vjBGMtQC/W+EijZzZNRAQI4wLSf1Yv7/b717vBiGNGiTl6RXtB/6kieRP7K9gFcJ8o2s/H0jjo4gW605Rt/pRHh6Lq2VCygnzo5N3ymFSTfaEB+IOqEuaMmDDnrvPg1LI9F8Vrh9uYV7GqjqSgcDgjTYY+kCSih6MU7UrV703Y9Aa4OjJAGgty0ocmdm5Dwlx/V3UcbAXn7U1DPbzKocpd8M/fuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(336012)(36860700001)(508600001)(426003)(47076005)(2616005)(40460700003)(316002)(2906002)(1076003)(16526019)(186003)(6666004)(7696005)(86362001)(5660300002)(26005)(83380400001)(44832011)(356005)(36756003)(82310400005)(81166007)(54906003)(70586007)(70206006)(4326008)(8676002)(8936002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:56.8900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa444070-db9e-49f9-4f9b-08da31cc060a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4663
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

GPU Nodes will have different criteria for checking if ECC is enabled.
A function pointer should be used rather than introduce another
branching condition.

Prepare for this by adding ecc_enabled() to pvt->ops and set it as
needed based on currently supported systems.

Use a "umc" prefix for modern systems, since these use Unified Memory
Controllers (UMCs).

Use a "dct" prefix for newly-defined legacy functions, since these
systems use DRAM Controllers (DCTs).

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 69 ++++++++++++++++++++++-----------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1bf1660fe8f3..136f2454a502 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3634,52 +3634,59 @@ static void restore_ecc_error_reporting(struct ecc_settings *s, u16 nid,
 		amd64_warn("Error restoring NB MCGCTL settings!\n");
 }
 
-static bool ecc_enabled(struct amd64_pvt *pvt)
+static bool dct_ecc_enabled(struct amd64_pvt *pvt)
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
+static bool umc_ecc_enabled(struct amd64_pvt *pvt)
+{
+	u8 umc_en_mask = 0, ecc_en_mask = 0;
+	u16 nid = pvt->mc_node_id;
+	struct amd64_umc *umc;
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
 	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
 
-	if (!ecc_en || !nb_mce_en)
+	if (!ecc_en)
 		return false;
 	else
 		return true;
@@ -3752,6 +3759,7 @@ static struct low_ops umc_ops = {
 	.determine_memory_type		= umc_determine_memory_type,
 	.determine_ecc_sym_sz		= umc_determine_ecc_sym_sz,
 	.read_mc_regs			= umc_read_mc_regs,
+	.ecc_enabled			= umc_ecc_enabled,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
@@ -3764,6 +3772,7 @@ static struct low_ops dct_ops = {
 	.determine_memory_type		= dct_determine_memory_type,
 	.determine_ecc_sym_sz		= dct_determine_ecc_sym_sz,
 	.read_mc_regs			= dct_read_mc_regs,
+	.ecc_enabled			= dct_ecc_enabled,
 };
 
 static int per_family_init(struct amd64_pvt *pvt)
@@ -4045,7 +4054,7 @@ static int probe_one_instance(unsigned int nid)
 		goto err_enable;
 	}
 
-	if (!ecc_enabled(pvt)) {
+	if (!pvt->ops->ecc_enabled(pvt)) {
 		ret = -ENODEV;
 
 		if (!ecc_enable_override)
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 25d0dcc5c480..99b6ffa21ba5 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -473,6 +473,7 @@ struct low_ops {
 	void (*determine_memory_type)(struct amd64_pvt *pvt);
 	void (*determine_ecc_sym_sz)(struct amd64_pvt *pvt);
 	void (*read_mc_regs)(struct amd64_pvt *pvt);
+	bool (*ecc_enabled)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

