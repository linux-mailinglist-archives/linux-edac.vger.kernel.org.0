Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B97058BA
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 22:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjEPUYu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 16:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEPUYt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 16:24:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200311717;
        Tue, 16 May 2023 13:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7BXCUXy5wmBPr3HXhuf+rx62SjAb9bvyD6jO04dBaxgVXyps44DQL4KSzLjGCIvAXt2e19Z4mkMeBhKVnJ5gN1CnuiPmd0xklvcqrmrxt44nT52qrszfy6xHnu00Mxat7aLYVGylTmdrXIUEbRSnxABA7wiRCKFRJH/F+NW95+qDME840kKyjOqu7OraTzJ7tSeJ8svcMgZKZb+m84EAfla/Bp1++Aw9MPA3Megh5PKtb9jIGP2ypMK1FSSjehyGhjcRVBs1gnIdpUJ0HQs84FfhAJKgJneSQ4gbgxK3ad6xcya1oRSvtCBUbtc0Yd7kVMLEFHAx5S2ELn2VECMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkEwh9HfAWv7u9CsXT/BePK4o1Goki4vrlncZTzHYmM=;
 b=aMs4LiFm6znKLi278+pgoMe/jbQZRkXaO2f/EIVO5VM5lIrk0LqPjeuYCpiug+PbhBO1l8oDIy8Nj6uXztQuvSjeejThINJm5k93mzTOe6MceTIlB7/Npbulzhxkim6uBv79CECM+iIzc0UGYXQsX1FOAoR6A6A78jtACh8VxnSyy9+Bik+T+DoRGQBOvdBDT012Tyj9aJ9tqX5yEfuzEarZ8B7QZA/pbm7w1Y1jH1MXB3vEO4s247xOi3EaEmA1Gf5rapaaAt5QrvdHlXPvplfTVesiZfn1bMlvZdrLqliqcOHlxSoHNmJRLx3iiKQtM06N5RkkD0kkIgQvMX8+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkEwh9HfAWv7u9CsXT/BePK4o1Goki4vrlncZTzHYmM=;
 b=0EgbkKcsA+Nx/C09ct78SrpGg2Aa23j+et9F4IFP3Q3w248KbSyS3dKDUMLuoXJHA6GZ98qfVhDEg7cnADIUinHf1vifRMqx8x5RUSWY8WQbm87OPndKqpHSKTKBGYyrsytjtfnHa1VqkRuPszl0sUyUgvJ/2jQHr2FrOqHnY1g=
Received: from BN7PR06CA0047.namprd06.prod.outlook.com (2603:10b6:408:34::24)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 20:24:46 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::a5) by BN7PR06CA0047.outlook.office365.com
 (2603:10b6:408:34::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 20:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 20:24:45 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 15:24:44 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <markgross@kernel.org>,
        <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-edac@vger.kernel.org>, <clemens@ladisch.de>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <mario.limonciello@amd.com>,
        <babu.moger@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 1/6] EDAC/amd64: Remove unused register accesses
Date:   Tue, 16 May 2023 15:24:25 -0500
Message-ID: <20230516202430.4157216-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516202430.4157216-1-yazen.ghannam@amd.com>
References: <20230516202430.4157216-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|CO6PR12MB5458:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7341db-1685-43c8-216f-08db564b96f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQM+uTdMTQeFALC6X1WjROUCqJsxRvT7dTiuK/GF3VwOo0wgSXaxI6xj1edXCxInSEAb3zsQI7AeqIq6vfbED9wHsZGoKP0AWG9bNQuYrnaMc3KniSACRIjv+y1L0Dn0vX6zJH62L68fbQIFxCJ3H1//peEjJUm1B9+wH2rltg8I6jzexD7Wom5H1GmfNZQh79gnauimjvFq/AB6uG2OcZVYATob3nLydeUBxBE1EQwYzWguCB7W1d9XQDR+LUC1lagvsBA4pyROdm0kIbq81cMKMgMtQO5CoPxvXQvME82AcwPL9SHNSNV2F1LSEHZULO1OcCDXKRv1/9J9Q4mVMO5WIgIKwdQQpk9pMnN9QrDg7lKzCj3LHoo1S04f8c/AtbH8Q1g7FeWNwB5LE5eEMlmbDBtQqqGZPDV6dPhZDiJtwbONUssvzQC3aDYqKWx6+CTcPzKIHeyzMOpQvxg4i4i4Y3F/kxOLc7rZTLHYILKEepObv6B6QVNFiEz5FoXrfSGcgk2D+UPyKkyIodciIKrLp34iePMExVx4hAkljjU7tTY2YkFlh1mhj7UlJ3W8J2+OAfDbVPME+qOIdNbWY38EgOB4EFD5+4cTaIadExFeTXvQ/hOpwcT4vQVubLDHeBAm6xFlzNtf+ZVl6lxh1yPIqNjP9GI1Q8GSrWZ/of9yiP1CNr/MT6nrY5v1VRDCAVN2OcG/Rs1ZMThdLYg9knFBB98UCAVnqsKwS2oPtFXEcV6CfURM4jowaVRxgR92QWZ8TRYdAEw8ut5LWMs9vA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(316002)(8676002)(8936002)(4326008)(6916009)(70206006)(5660300002)(86362001)(82310400005)(7416002)(70586007)(356005)(54906003)(81166007)(44832011)(82740400003)(2906002)(41300700001)(478600001)(6666004)(7696005)(36756003)(1076003)(36860700001)(26005)(336012)(426003)(16526019)(40460700003)(186003)(83380400001)(47076005)(40480700001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 20:24:45.8033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7341db-1685-43c8-216f-08db564b96f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/edac/amd64_edac.c | 17 +----------------
 drivers/edac/amd64_edac.h |  4 ----
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index de3ea2c1807d..fda6537c80be 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -19,7 +19,6 @@ static inline u32 get_umc_reg(struct amd64_pvt *pvt, u32 reg)
 		return reg;
 
 	switch (reg) {
-	case UMCCH_ADDR_CFG:		return UMCCH_ADDR_CFG_DDR5;
 	case UMCCH_ADDR_MASK_SEC:	return UMCCH_ADDR_MASK_SEC_DDR5;
 	case UMCCH_DIMM_CFG:		return UMCCH_DIMM_CFG_DDR5;
 	}
@@ -1528,7 +1527,7 @@ static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 static void umc_dump_misc_regs(struct amd64_pvt *pvt)
 {
 	struct amd64_umc *umc;
-	u32 i, tmp, umc_base;
+	u32 i, umc_base;
 
 	for_each_umc(i) {
 		umc_base = get_umc_base(i);
@@ -1538,12 +1537,6 @@ static void umc_dump_misc_regs(struct amd64_pvt *pvt)
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
@@ -1556,14 +1549,6 @@ static void umc_dump_misc_regs(struct amd64_pvt *pvt)
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
index 0bde0db76f7a..a6cd42731e30 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -255,15 +255,11 @@
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

