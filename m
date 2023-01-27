Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2051F67EC08
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjA0RGI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjA0RFn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:05:43 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6513656187;
        Fri, 27 Jan 2023 09:05:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGfEIpKpm2l7dEdJvSjU3HsFdzqa7gBCVNxQE8qTteNG6p3YEitLLQQKd4g6B8vHa1jicHRdF7+URizNNx2I9dvqM9K/dm4kw2bYL/DTkjQOZsju8aPFOkNLVCBwcl82yERzr6/xIxQb37holR1lrKQsACLBoHSKxNAVLnEKWxwrKOvk4EmWhYHuW5q7GRv1Cs/WeH8uIe+qqlQ6E9iTQKcnM1uYDvetSJaA1KnWbgHuVo/oXOjod1I9Nmb2KfW7fMpYQ8zc+t0Epn2ESCiy3FUvOIFrNMN+K8DuVzIREFwzJ7ixDro7pz2noprExIrkM0zCVd1RchxPbxmKcndt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psKvRlbNDQC+N/zEsDTcdWaxGyXR/5GhHXvH7tWsFtE=;
 b=XHlOhdJ2Eca8sjNiZMHBZc90ETXGiIkZb6csZODKTN1LoEo/Bagh0LMLWZHL40me32lFJ9yJUbokTK3Rb/w07YCT8hyoV4rB7V0t6wFN/DHwwBCbZN+OYoADlNm6TRzoijbbQ1QbICgVojguqzv/DRI1PPXEsoaPsjiv2QuyXATPVzalsv4dJF+eGDCdTEKJVCMWlFkdMPXLtdAn2xtNdLRCQJYn+Q2x1dQHTSm1SYSVHiRAH6mf8TX/e9n6PC9JGgY4pGPAYgypeg/KEBFTs48fXjgFe+g4DDYVWZ4/VSSkazLayX8bNZd0FYQhBU0GnCucqa/wOBE32TY+pj4EMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psKvRlbNDQC+N/zEsDTcdWaxGyXR/5GhHXvH7tWsFtE=;
 b=ZGuBP8/hdUKZxbi7J3O6dGpM/pJMxH5QvBGrGYI+6cPidIGlPTd8XGnQpP/91qi0LshW6Qh47LSkSlU++2QJTYVCiFBkBVGDcc8p7QIsYYs/+KdxYalHROPOpNropkLb7ejP7dAnhfVjeHVTrhfDVPZPxZtAg19lL6rFHZQRr7Y=
Received: from BN8PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:d4::21)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 17:04:36 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::72) by BN8PR04CA0047.outlook.office365.com
 (2603:10b6:408:d4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:36 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:34 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 12/22] EDAC/amd64: Split prep_chip_selects() into dct/umc functions
Date:   Fri, 27 Jan 2023 17:04:09 +0000
Message-ID: <20230127170419.1824692-13-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127170419.1824692-1-yazen.ghannam@amd.com>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: cc00c3f5-bfd7-404d-ad42-08db008891e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIBx6AFCJ6zoAQODIy/lg+cT03VxXE9bRJJySxnlWTJ9ySmj7buAv7hcjAuuEyb50h7aRf+jMGhZ/9jJWdKsaLLpPnHok0r450WI+JzaunQLbkF5yqFMW+Sxa2JaxPSjg0cbWWxUrLOv48sdzSl7UqFRhFtmvw3gzY9rVkIJwnddq4ibCk6tN0zzFi4djGSdAa4OWpTnihVfSERZRaif7GmJSov5y64oOvsELfvzmve4epetKNZdMAzWeHOMScPsOih5Uc+dTQ6GrEADVgqOHF7M4k+l6M1ueaHcdzaDFu5fRo6REpPC8Gq2i72wRmSFrh+UV/g788cwFicFMfU489tS5dXbk9XvNhL2U3DHnt6QJ8RUNGkqazfEcmaG42GlxlfZ/Po0rvoFlt7N5wLq0Q5JYxD8tCc7a3E4yHUZ2Aw42XdDifzgj/yCBCuht0IUaA1NgMYq5eHCWferbNGcDiQOvGMNBjV7aGfAOWBPOn3jySuCJ1Sqg53BDwEZyLBsoJKHKGTvjOpr36lnAdqTmBS2G6cv+/32zskL6Q8xrx5iWzMcQzGunlyG3p9iCvFmw/uumIzkF3UX/rr0f5DkVCd26csqV0KtrSCZ+y74P8x8jSFNeYcI1TlKSx5qY/xZN4RvJQ2UM0TzTPRHgQQ1U7BxQ/5pruULOrCNqwa0opjIf5+hF4e14D0S6KIWPcuU01wdT883ysbWYtkoDRAiusilGQdKDhnddJq0AWICk9aT8Yy11NAyi76jb/QjD0TPtk3dI9g19mZE/HBM1P+PCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199018)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(356005)(44832011)(426003)(336012)(83380400001)(86362001)(40480700001)(81166007)(40460700003)(26005)(6666004)(82310400005)(70206006)(478600001)(966005)(41300700001)(7696005)(1076003)(70586007)(36860700001)(8676002)(2616005)(16526019)(47076005)(186003)(8936002)(316002)(110136005)(36756003)(4326008)(54906003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:36.6085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc00c3f5-bfd7-404d-ad42-08db008891e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

...and call them from their respective hw_info_get() function.
This avoids the need for family/model-based function pointers.

Add the calls before reading hardware registers from the memory
controllers, since the number of chip select bases and masks needs to be
known first.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-7-yazen.ghannam@amd.com

v1->v2:
* Call functions directly instead of using pointers.

 drivers/edac/amd64_edac.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 3830b0a4b5dc..fc15b6dea177 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1614,7 +1614,7 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
 /*
  * See BKDG, F2x[1,0][5C:40], F2[1,0][6C:60]
  */
-static void prep_chip_selects(struct amd64_pvt *pvt)
+static void dct_prep_chip_selects(struct amd64_pvt *pvt)
 {
 	if (pvt->fam == 0xf && pvt->ext_model < K8_REV_F) {
 		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
@@ -1622,20 +1622,22 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 	} else if (pvt->fam == 0x15 && pvt->model == 0x30) {
 		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
 		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
-	} else if (pvt->fam >= 0x17) {
-		int umc;
-
-		for_each_umc(umc) {
-			pvt->csels[umc].b_cnt = 4;
-			pvt->csels[umc].m_cnt = pvt->flags.zn_regs_v2 ? 4 : 2;
-		}
-
 	} else {
 		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
 		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
 	}
 }
 
+static void umc_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	int umc;
+
+	for_each_umc(umc) {
+		pvt->csels[umc].b_cnt = 4;
+		pvt->csels[umc].m_cnt = pvt->flags.zn_regs_v2 ? 4 : 2;
+	}
+}
+
 static void read_umc_base_mask(struct amd64_pvt *pvt)
 {
 	u32 umc_base_reg, umc_base_reg_sec;
@@ -1694,8 +1696,6 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 {
 	int cs;
 
-	prep_chip_selects(pvt);
-
 	if (pvt->umc)
 		return read_umc_base_mask(pvt);
 
@@ -3665,6 +3665,7 @@ static int dct_hw_info_get(struct amd64_pvt *pvt)
 	if (ret)
 		return ret;
 
+	dct_prep_chip_selects(pvt);
 	read_mc_regs(pvt);
 
 	return 0;
@@ -3676,6 +3677,7 @@ static int umc_hw_info_get(struct amd64_pvt *pvt)
 	if (!pvt->umc)
 		return -ENOMEM;
 
+	umc_prep_chip_selects(pvt);
 	read_mc_regs(pvt);
 
 	return 0;
-- 
2.25.1

