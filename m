Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B537058BD
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 22:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEPUZI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 16:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjEPUYv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 16:24:51 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194A91BC;
        Tue, 16 May 2023 13:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8lEMmJSpf5qIMZi+zT/rEgO+U3tghueoW3r+TQZBKEUcl/X/FEOQzNzB1zV4wgvD/2d0yrX8v2ZjaV1QEfD5brQJOYe1uuYnBpWYvc4gR9pZ/FMz7n7lGc38Fhsxf5DomtDvCZXiHLVBp+LKb1V0AHgS8AmV6xfBp92HkeYOgDqNEIuhC3mTi+FHmcf9FciS4Zu3dZfKYv3/ewtiYPhNurLRuUgd1klkSA7CJ6F7PImKhjkZT6V5LjZKq6AqdltbOY6sKuUofJAO3/ysGs1A+jB4BGovXFYlO7wLysHyMQ0IHlH5wIzewzZCKCt9+sSTazQoa4UTIg8P5ie/cR7Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3ym0DmPkjFkl9juXZIPH/rDRNBtBIuyF5FT0t8j+YE=;
 b=CAAfqEQIQDQiD90gd79F5j1wj8D3LHTpRV/Xy9kx+PfBTjqZlbES+mBnJZ056Roxc71qtWmQSLoeYwnmveXIeiHo4RG8iMDbVGat7alNX2pPxVO1r31QhMjwBojz+kScRNdS8uSH+fmVHDUXV9Ipjr+Xzq3kx8lunWyk/spHSsUW/XNswVs3Ux8XwFVwVFkrZe3HSwBM3whn+DR2PxTm9b/4Wdtknsl2lwRTE/RVKGJl6UpAoiYVtTAoiuJV7KT14o8Up+081LnC7wyvAa4/7bULirfVEm12MfvnsRpXzZdxzgw285ok5Eawh3ItpYT9VtuBjLmngNcyEFxtmfisfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3ym0DmPkjFkl9juXZIPH/rDRNBtBIuyF5FT0t8j+YE=;
 b=rSZ3uCa992akAYtthXW2SP8b2ri8e2gLZ5J+AfLHAQEynA5E5ODhOO8Jactnyxp6bp4KQLdrV2OZB/JrU+oZp33CUgE2aNUbenBq6X7+4Yd8Oh0s0brCHsHvVPbXfDwHLD0M7SCZDErqSC7aBCw6oUkob98yipZWZHSE+2a8Elg=
Received: from BN9PR03CA0404.namprd03.prod.outlook.com (2603:10b6:408:111::19)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 20:24:47 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::fb) by BN9PR03CA0404.outlook.office365.com
 (2603:10b6:408:111::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 20:24:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Tue, 16 May 2023 20:24:46 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 15:24:45 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <markgross@kernel.org>,
        <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-edac@vger.kernel.org>, <clemens@ladisch.de>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <mario.limonciello@amd.com>,
        <babu.moger@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 2/6] EDAC/amd64: Check return value of amd_smn_read()
Date:   Tue, 16 May 2023 15:24:26 -0500
Message-ID: <20230516202430.4157216-3-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 28325957-217f-41df-ca19-08db564b97a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRQWov9CdR1b+A9e5fKNECuQkRLMZxFDnixEl0Qc4IOo+q2tVsrH1qg+UO4H/SA/lzvx2KhdSgvfk+MRAjgIOHgbIDUoHY+9u8GPGleMnjkTR5rKU0bR20r8vo0KcatQ5hwfaSzli5+DU/dyBj0CI36oxb0TKnz4fg1/SIz3EIULQ4O6MxuK3jEb7NmP1s+inr0wJ5+wW7H4mzFHnSHE6h+weDfgBuFlRKDsXTnbKtxDyZfx9anjtMwBr5nsjA2tSwJfVnyYO2/0vkJ8/HzaXwX6hxKeP6VlaQBrL2bMFseGuDB9m3+GmASnNkUOs3pdBrHz6zdoctlcJQI/059aSHGMxvp0XcW9x9O4MaTdhNAjc3kaAfX1LGy5L4EdsuXGxwmGv0EEbgTI3Sk6eKGf++LADDsYCJlL6EmTrYAfplFcc1nuH2XINEt74j8/McrV3l3Kbp4v8VC7jThNvNtzfD+r9PkCVUbelxHhuNIs4UdqdbmYISip92HzQH48pRswYGch8ds4Cn0e6LmnMpgu30FUlLWXmS6De/Lk5jaPbMKXRgdiK3iUkqzF74uRG5EjFMNh/w5VcqB6ERhHKG88eXjxgNPrNWy6YSK7kL2nq0rKTvT6njDfCZHCSclbCPDOMyXNKeaUTz+lkT7kNE3noK/25SsQZPUFimDI/zjCWlMH+5L0xjplENYAbMFQA9Ds2S0PZGipCR4ZdtbmoCB5SEqvjFw30mxGXB3xoVKI1/SAtVsawXk7nmPbWr9va8sVLEvIjvR7ETp/CXaWwNVhug==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(6916009)(4326008)(70206006)(70586007)(478600001)(316002)(54906003)(86362001)(36756003)(7696005)(47076005)(83380400001)(16526019)(1076003)(186003)(426003)(2616005)(26005)(36860700001)(336012)(2906002)(8676002)(8936002)(41300700001)(5660300002)(44832011)(7416002)(6666004)(40480700001)(82310400005)(81166007)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 20:24:46.9283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28325957-217f-41df-ca19-08db564b97a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562
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

Check the return value of amd_smn_read() before saving a value. This
ensures invalid values aren't saved. The struct umc instance is
initialized to 0 during memory allocation. Therefore, a bad read will
keep the value as 0 providing the expected Read-as-Zero behavior.

Furthermore, the __must_check attribute will be added to amd_smn_read().
Therefore, this change is required to avoid compile-time warnings.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/edac/amd64_edac.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fda6537c80be..e9aa54e42edc 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1626,6 +1626,7 @@ static void umc_read_base_mask(struct amd64_pvt *pvt)
 	u32 *base, *base_sec;
 	u32 *mask, *mask_sec;
 	int cs, umc;
+	u32 tmp;
 
 	for_each_umc(umc) {
 		umc_base_reg = get_umc_base(umc) + UMCCH_BASE_ADDR;
@@ -1638,13 +1639,17 @@ static void umc_read_base_mask(struct amd64_pvt *pvt)
 			base_reg = umc_base_reg + (cs * 4);
 			base_reg_sec = umc_base_reg_sec + (cs * 4);
 
-			if (!amd_smn_read(pvt->mc_node_id, base_reg, base))
+			if (!amd_smn_read(pvt->mc_node_id, base_reg, &tmp)) {
+				*base = tmp;
 				edac_dbg(0, "  DCSB%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *base, base_reg);
+			}
 
-			if (!amd_smn_read(pvt->mc_node_id, base_reg_sec, base_sec))
+			if (!amd_smn_read(pvt->mc_node_id, base_reg_sec, &tmp)) {
+				*base_sec = tmp;
 				edac_dbg(0, "    DCSB_SEC%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *base_sec, base_reg_sec);
+			}
 		}
 
 		umc_mask_reg = get_umc_base(umc) + UMCCH_ADDR_MASK;
@@ -1657,13 +1662,17 @@ static void umc_read_base_mask(struct amd64_pvt *pvt)
 			mask_reg = umc_mask_reg + (cs * 4);
 			mask_reg_sec = umc_mask_reg_sec + (cs * 4);
 
-			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask))
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg, &tmp)) {
+				*mask = tmp;
 				edac_dbg(0, "  DCSM%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *mask, mask_reg);
+			}
 
-			if (!amd_smn_read(pvt->mc_node_id, mask_reg_sec, mask_sec))
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg_sec, &tmp)) {
+				*mask_sec = tmp;
 				edac_dbg(0, "    DCSM_SEC%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *mask_sec, mask_reg_sec);
+			}
 		}
 	}
 }
@@ -3074,7 +3083,7 @@ static void umc_read_mc_regs(struct amd64_pvt *pvt)
 {
 	u8 nid = pvt->mc_node_id;
 	struct amd64_umc *umc;
-	u32 i, umc_base;
+	u32 i, tmp, umc_base;
 
 	/* Read registers from each UMC */
 	for_each_umc(i) {
@@ -3082,11 +3091,20 @@ static void umc_read_mc_regs(struct amd64_pvt *pvt)
 		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + get_umc_reg(pvt, UMCCH_DIMM_CFG), &umc->dimm_cfg);
-		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
-		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
-		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
-		amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
+		if (!amd_smn_read(nid, umc_base + get_umc_reg(pvt, UMCCH_DIMM_CFG), &tmp))
+			umc->dimm_cfg = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &tmp))
+			umc->umc_cfg = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &tmp))
+			umc->sdp_ctrl = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &tmp))
+			umc->ecc_ctrl = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &tmp))
+			umc->umc_cap_hi = tmp;
 	}
 }
 
-- 
2.34.1

