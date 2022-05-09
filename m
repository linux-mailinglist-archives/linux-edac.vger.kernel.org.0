Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC44520065
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiEIPAR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 11:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbiEIO7z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 10:59:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C790523BB7C;
        Mon,  9 May 2022 07:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uo5IiVpMZ+B9WONVWD1CmyLPURWrbu3cQBRoC5YadhLNvWKA79jSPTAc+1OC95RsXrbpb4eI0x8uwX1DCxk3qCRbNMk0W6UZ3ofnnrexbPX+SVkyNG7WEZPjB5o1B51WlPoSgxCnfUm/jAz9ya+vsTD3g11keLAISa/aL8NXpUqjfEZYfxUvu2UV0wKJDwKKiZ2nrJD8QxIhv556GoRdEpnOi0L3w9PTghF+oXasygzzMCiWmj+3qVcSbRx1xSxE0qzIQZOHaeXK/y+yuA7tF3jYcyp+vQN72fM4lIPWO5H34qCgcdWHJI7ttkWu0Zi3u9TOXwNlnSgDf6VVhd1R0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeW/jIouWBPC4KDzx4GjWvZi70dmkyPlBUSkqgpSvgA=;
 b=kpPwBrd47OkXpZzgvb+q0ZgFzPImIGTsFWCjNuK503RktKrnFjio6tOt5praUEdPwa9SIOzbkB4rFHfcMpc6R9Mqj2GGn92uziJZGVILNYTs0ndJ8Rm8LvgruN35OZSEcxyilbj+8m+FFBJN5BuAduN1gg74lmrnw+HJB8S2e/GPr6TheTaoPFUikNO++z3sHO/h3eqO2hoYnOnfF3FYA8zoxAylP+ORmO1RxrkYcrloGCukcS6Q65HKIo7e+tboIAK5IkCYdadP7oD9hFXWlBPXelSj3nM3w//67X3KppwRaksLuL4yG5vPGeeGPz9kU85ZPWfuEgC+kVKfSLLjlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeW/jIouWBPC4KDzx4GjWvZi70dmkyPlBUSkqgpSvgA=;
 b=gHjc8n5sIhEhxOaqp+Aa+OPUpnvWlsHaJl1vSiIgoUnoCR82BgaKm0G6Lym35L/lA35Xsw87S8N+ryzA0rtqAfzy7jT9lZUl6LvBRJDGWMdM6aD3k1zYWwRFlq8JRlzRh6wf0AV6gvFZIg8CPXaycAulyhok+1NvvlAaWuDBHlI=
Received: from MW4PR03CA0219.namprd03.prod.outlook.com (2603:10b6:303:b9::14)
 by DM5PR12MB1692.namprd12.prod.outlook.com (2603:10b6:4:5::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Mon, 9 May 2022 14:55:57 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::6) by MW4PR03CA0219.outlook.office365.com
 (2603:10b6:303:b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Mon, 9 May 2022 14:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:57 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:49 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 09/18] EDAC/amd64: Add get_ecc_sym_sz() into pvt->ops
Date:   Mon, 9 May 2022 14:55:25 +0000
Message-ID: <20220509145534.44912-10-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9b68fd8b-afac-41e0-b017-08da31cc063f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1692:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB16928B9E2C7E1D91D22D829EF8C69@DM5PR12MB1692.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPrSh9mxuqdlpEa01th0/ComJpxiPIZYYC2ret2xsUlJRGUlzreri9gzhlaFVe803QvrmKtUe30JRIrLMK/mGurf0S4OSJlVGUrHEM8FNLjJLSpdryKZ7YJfarKvcmz2SoNSc8p9T7kVJ+/a+Hv/UkSFW3z8QIclVZ/RamFw55ftysg2z1e/Of700qlA8n8c+MU+01LSu5KvXmC9pWUhFDfn/Eg6bzjkw333Mpy5GwSbXqCMIuNgCpik/zbwB5y3c9pjUrDalgE153q2rdt6OJTNHhcB3nZiHMqC4hLhDqt2czfTxt2HIaD0IuE26Iwg5MS5YmDIUKPv4+I/UZhcJ6fEjSLxHcLxQ/KKysa7BtuVJypT/sHvL/VMLWFkiza57WiebFx1M+J6x+SIZGkt4yOgWVDm0ekOg+XEHzAv/pK4oQDXGNl4a++vJd7roq/o+TVhtQ91f3lAwLv/Y+MIl+W6J/AR7R/WxI1kHDFvjpaOn2BohuTPawhN6MUbIM2zpXWpnCwn2QJgP2mF2Xg5cB8mbJuM+PDGPqgrIIxcbqpwYT96FML5BtUeIJaApjsqq+cfNKsUNPcEDm3hFkBSo7gqKvOVdJ/rEIFNTI5RizbHQpa7Vp0l5Ou6J0GBq/U/o/YLgbXMlFTeQ4sBaareYXwsk5BiWIYhasxa7ZOqPLQjRF1q0TMEk8sVMKFp1oUoINIs9SzAyDoL+NMrFTyXvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(40460700003)(26005)(36860700001)(36756003)(8676002)(4326008)(82310400005)(16526019)(1076003)(47076005)(186003)(426003)(336012)(70206006)(70586007)(110136005)(54906003)(316002)(508600001)(5660300002)(86362001)(6666004)(2906002)(8936002)(7696005)(81166007)(83380400001)(356005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:57.2398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b68fd8b-afac-41e0-b017-08da31cc063f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1692
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

GPU Nodes will need to determine ECC symbol size differently than
existing systems. A function pointer should be used rather than
introduce another branching condition.

Prepare for this by adding get_ecc_sym_sz() to pvt->ops and set it as
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
 drivers/edac/amd64_edac.c | 43 +++++++++++++++++++++++----------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index a767d8a6bfe8..2a3205f1205e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3169,26 +3169,11 @@ static void free_mc_sibling_devs(struct amd64_pvt *pvt)
 	}
 }
 
-static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
+static void dct_determine_ecc_sym_sz(struct amd64_pvt *pvt)
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
@@ -3202,6 +3187,26 @@ static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
 	}
 }
 
+static void umc_determine_ecc_sym_sz(struct amd64_pvt *pvt)
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
 /*
  * Retrieve the hardware registers of the memory controller.
  */
@@ -3303,7 +3308,7 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 
 	pvt->ops->determine_memory_type(pvt);
 
-	determine_ecc_sym_sz(pvt);
+	pvt->ops->determine_ecc_sym_sz(pvt);
 }
 
 /*
@@ -3760,6 +3765,7 @@ static struct low_ops umc_ops = {
 	.prep_chip_selects		= umc_prep_chip_selects,
 	.read_base_mask			= umc_read_base_mask,
 	.determine_memory_type		= umc_determine_memory_type,
+	.determine_ecc_sym_sz		= umc_determine_ecc_sym_sz,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
@@ -3770,6 +3776,7 @@ static struct low_ops dct_ops = {
 	.prep_chip_selects		= dct_prep_chip_selects,
 	.read_base_mask			= dct_read_base_mask,
 	.determine_memory_type		= dct_determine_memory_type,
+	.determine_ecc_sym_sz		= dct_determine_ecc_sym_sz,
 };
 
 static int per_family_init(struct amd64_pvt *pvt)
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index da3db0f4f59b..5e9ff6ea7ebc 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -471,6 +471,7 @@ struct low_ops {
 	void (*prep_chip_selects)(struct amd64_pvt *pvt);
 	void (*read_base_mask)(struct amd64_pvt *pvt);
 	void (*determine_memory_type)(struct amd64_pvt *pvt);
+	void (*determine_ecc_sym_sz)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

