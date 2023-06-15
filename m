Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E91B731D4B
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 18:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFOQDs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 12:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFOQDr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 12:03:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED03F273E;
        Thu, 15 Jun 2023 09:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItjQ1oh2hfVs+eOQJYXKSwY6+tfBvQZ2MKlPLFBhpAXN1dJjevCEJud9ULRN7pjzkiDixV/995GyKVyMqdB0d3z+9n0n2CM/Q2vrM0/B8+e6+1DpW2B2iVbiDOKxTJzDlzicFZEljck1D6LntAABEkQQtvoPPAwam4ubwKu6+KetVTEvbO0xVDYdiNyTWf1nDzA+gLId1MN9AhfKoKd/Uv0wM7YOFIfKuZmfSXN3CGJZXf8Zs/4tErpB6ro1RlvTb/HSpSbCHN7uQfuKF6JwDrprFlP7GoLIEBHXKkDBc335ugDW/annq6hFwHIhHLFvGrh9CwYAUO3qYbBDKd/Jzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpO0lnvUMogbOpycuhb4m1lVwO3CTOkHVKveGcjGPjw=;
 b=PiJMK3B1jAoYguwX4O5YqyeKmZav3UETdru3X5X1DHtTPGqfMUwmajIrCR0qI3btJc2RRI2rE7mABnSSWIObfrQx8ZJ7Ti5boNCg4QTWZDql9Zw28xUNHIiVIalThdJssJuYeFZ4D4yRyeCje2alodET4O/RkWMipQDIMQ32MdoJtIlQkgypvqe3g5hNMkZk60yMxxUG0g2eaWW9pIqfr89vtmEsOyKEZrjgjcNYCjrOMwuCGg75c+iYynweXbJABhQVFFLVTBOMoUjfOudyBy41Okr/ZpmrkkBI9aI74hJ4Fi5IurlWE1EbYPx9oOlU0EFtZncpNPDW/nxKgiUMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpO0lnvUMogbOpycuhb4m1lVwO3CTOkHVKveGcjGPjw=;
 b=URmhxBKBeWTt4VabO6v9jJl1edAnqzkvIpcGGOQhds6T47tyQ5D5hbI5+XDSp072nN4BiNNwgug4MQnfayT5VC7gnro/1779J+JmgoZ3ffSPLLWgB25eILiMZgwiqsK7NTH/5zqXY2zk/0N0NjL2aEfwfNiYcVg51jAggfQoI5g=
Received: from MW4PR03CA0245.namprd03.prod.outlook.com (2603:10b6:303:b4::10)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 16:03:43 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::7) by MW4PR03CA0245.outlook.office365.com
 (2603:10b6:303:b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Thu, 15 Jun 2023 16:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 16:03:43 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 11:03:41 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <markgross@kernel.org>,
        <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-edac@vger.kernel.org>, <clemens@ladisch.de>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <mario.limonciello@amd.com>,
        <babu.moger@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 1/6] EDAC/amd64: Remove unused register accesses
Date:   Thu, 15 Jun 2023 11:03:23 -0500
Message-ID: <20230615160328.419610-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615160328.419610-1-yazen.ghannam@amd.com>
References: <20230615160328.419610-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: a0377efe-e404-4d59-f6e3-08db6dba17d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YbnHz1ryxcw3gf/QhvyXRKslBq5Bt+qC+BKJrNGIUBiPPj2bBb6r9qYwj5XmnktkI1vSKmun7qxw+GlDSymy5XWzNjBGOmdKcy85j5aalnrsb9Z7epg2B09p+d56txyoa7eaf+I24ZBMmnG2bLOONqQ+hAd2H2RODfIUReanKoH3cJxBhi6kfjfo5aU7Qu034ZcW/HvLpRoEobj6qcbZWNaQE8E+86EEXeOkbLIIXH01rBLQ+PXF9kPELuvYVBeO6SQ8h8zU80fPLBQT4/9biQbvOulZ0MysFhnWg7iEs5lIMRffrJVM6ThbMI2+NAJ7Yt3Ar6EaO0eGhStkDhQdJ97d1S7z6kDytiWG8+PQGfzqCTxbgBpjmlOnG5fMwwrvbWGdnR9IVjvwAld5skT0Kvkew47uGE7eLSUjhny9gc6+jif6fSg+MmS1AXNARqYe1Ga2KZduOKcRmVUl1tfEI3M7Zn4VhgxDrQKOIms2i9XkP8WjwrPWLanjd6v1qmZR6rgjbw+wXxTYgWHeKD3BHT+8etwc287EJOO9GltG5KDOO1RhiKlfOD8e8kccHIBr8Ssp4vjF+Clp5toxElFfJmmwbPNPqqRalwoc00ZWs+Qc7UihwnQ7DNs73B8xBWkHtnrUqVZ+bSZTTE9mEocV36FYL+PVTmkRfiJ5b7WKimAZWn8aMcBK3FWrhibxS4hzsRGViQgDOkG45JqXPzos2mmVyj5+GJTK49egKG8OTqOpk0x4awOUJUJhFR34ZLWN0SPu977fxAEd7/kQN9hKiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(5660300002)(82740400003)(966005)(81166007)(356005)(336012)(2616005)(83380400001)(426003)(1076003)(186003)(16526019)(2906002)(26005)(36860700001)(7416002)(47076005)(44832011)(478600001)(40480700001)(6916009)(70206006)(316002)(6666004)(8936002)(8676002)(41300700001)(7696005)(86362001)(82310400005)(70586007)(36756003)(4326008)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:03:43.2475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0377efe-e404-4d59-f6e3-08db6dba17d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

A number of UMC registers are read only for the purpose of debug
printing. They are not used in any calculations. Nor do they have any
specific debug value.

Remove these register accesses.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
Link:
https://lore.kernel.org/r/20230516202430.4157216-2-yazen.ghannam@amd.com

v1->v2:
* No changes.

 drivers/edac/amd64_edac.c | 17 +----------------
 drivers/edac/amd64_edac.h |  4 ----
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 5d7c080d96a2..67feebc1eafe 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -19,7 +19,6 @@ static inline u32 get_umc_reg(struct amd64_pvt *pvt, u32 reg)
 		return reg;
 
 	switch (reg) {
-	case UMCCH_ADDR_CFG:		return UMCCH_ADDR_CFG_DDR5;
 	case UMCCH_ADDR_MASK_SEC:	return UMCCH_ADDR_MASK_SEC_DDR5;
 	case UMCCH_DIMM_CFG:		return UMCCH_DIMM_CFG_DDR5;
 	}
@@ -1605,7 +1604,7 @@ static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 static void umc_dump_misc_regs(struct amd64_pvt *pvt)
 {
 	struct amd64_umc *umc;
-	u32 i, tmp, umc_base;
+	u32 i, umc_base;
 
 	for_each_umc(i) {
 		umc_base = get_umc_base(i);
@@ -1615,12 +1614,6 @@ static void umc_dump_misc_regs(struct amd64_pvt *pvt)
 		edac_dbg(1, "UMC%d UMC cfg: 0x%x\n", i, umc->umc_cfg);
 		edac_dbg(1, "UMC%d SDP ctrl: 0x%x\n", i, umc->sdp_ctrl);
 		edac_dbg(1, "UMC%d ECC ctrl: 0x%x\n", i, umc->ecc_ctrl);
-
-		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ECC_BAD_SYMBOL, &tmp);
-		edac_dbg(1, "UMC%d ECC bad symbol: 0x%x\n", i, tmp);
-
-		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_UMC_CAP, &tmp);
-		edac_dbg(1, "UMC%d UMC cap: 0x%x\n", i, tmp);
 		edac_dbg(1, "UMC%d UMC cap high: 0x%x\n", i, umc->umc_cap_hi);
 
 		edac_dbg(1, "UMC%d ECC capable: %s, ChipKill ECC capable: %s\n",
@@ -1633,14 +1626,6 @@ static void umc_dump_misc_regs(struct amd64_pvt *pvt)
 		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
 				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
 
-		if (umc->dram_type == MEM_LRDDR4 || umc->dram_type == MEM_LRDDR5) {
-			amd_smn_read(pvt->mc_node_id,
-				     umc_base + get_umc_reg(pvt, UMCCH_ADDR_CFG),
-				     &tmp);
-			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
-					i, 1 << ((tmp >> 4) & 0x3));
-		}
-
 		umc_debug_display_dimm_sizes(pvt, i);
 	}
 }
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 5a4e4a59682b..ce08b99c6523 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -256,15 +256,11 @@
 #define UMCCH_ADDR_MASK			0x20
 #define UMCCH_ADDR_MASK_SEC		0x28
 #define UMCCH_ADDR_MASK_SEC_DDR5	0x30
-#define UMCCH_ADDR_CFG			0x30
-#define UMCCH_ADDR_CFG_DDR5		0x40
 #define UMCCH_DIMM_CFG			0x80
 #define UMCCH_DIMM_CFG_DDR5		0x90
 #define UMCCH_UMC_CFG			0x100
 #define UMCCH_SDP_CTRL			0x104
 #define UMCCH_ECC_CTRL			0x14C
-#define UMCCH_ECC_BAD_SYMBOL		0xD90
-#define UMCCH_UMC_CAP			0xDF0
 #define UMCCH_UMC_CAP_HI		0xDF4
 
 /* UMC CH bitfields */
-- 
2.34.1

