Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB6567EC07
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjA0RGG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjA0RFn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:05:43 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324AC2B091;
        Fri, 27 Jan 2023 09:05:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLadVZwXgcsaRGS5TMx0HlHWgKGpdLzI5QE07PwxUfdWF2hBeNrJgmv/QRdQ3uE5PYihXVPrOzG6OcdyoWa9JnlrYr2DRR026kSg4Sehh/XVOH7RUgdQ66EuQvL8P/jAtlp9hYcZj//gboQ04ovrFw1WebLtdCpw/JpLNVOP8Ycdz+UWapsPwstTHmN0lJjwXrM0v5cYTXymlCeXZMVNm7SMMn627GQFKS+6fZc5ZUf+6x4O5Pp3sgPs+wWFHwLUx37osEz0QEcd9FTeDQ3qXvU+ucNw0cfZKYYBJNbQl2Tg0B/T6z9H6iPv8ghts8xxe7hXJvLm72K4cpU6XhJo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtQ88B/CYW7IbFTwDb4CCHs7CgcGwwqB2yynZOsd8h8=;
 b=b2idTYaqDbg307diyQLfcHmTpGricWWLfOQRnfWJY6JsQXxcl+t5bqOFMYLfwacpyjL3cWlNIxIkMwZqOk7nPgORuCTXyCPDW/Cm4CZZdrSr4Ya8Do/TTTM+It7hyqhRZ4r0zMuVQe5PHYIvOcZWUUrMORCwcesS6Eb7KelnUA2ajGj3bbs1SQ+4ABP2zqYrxnwLFsddQ/EoxkRsHQQLknt9zTk31JiVCFOPbUFjsBpyhEKA7BJbrBiz+Atbl88qORrGkHrfvJMmBhsfS4p8x3NefKcrKJEqRwH8Fb7zhXT0eSwGlfgsOR574DWhxei89RoXEYAqhe1zk8TRrd2R4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtQ88B/CYW7IbFTwDb4CCHs7CgcGwwqB2yynZOsd8h8=;
 b=FPOjXK5TbNouiGDLIQ881t51+pcSOeffWrCg7EtJzQanPLJuviny7vQVMsrIvfmoePRz7qM8S6RK2v29zBHXNjol/+/U0+LXFS2gCyERNVU20L3w9cZHRWt8Ae8vEJUEgwoH7tTcEL+PkzsTx9DcMcGLoD/m7TQYHU37tO52/3E=
Received: from BN9PR03CA0472.namprd03.prod.outlook.com (2603:10b6:408:139::27)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 17:04:38 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::90) by BN9PR03CA0472.outlook.office365.com
 (2603:10b6:408:139::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.23 via Frontend Transport; Fri, 27 Jan 2023 17:04:37 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:37 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 19/22] EDAC/amd64: Split determine_edac_cap() into dct/umc functions
Date:   Fri, 27 Jan 2023 17:04:16 +0000
Message-ID: <20230127170419.1824692-20-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ceb92f-de60-439b-7b10-08db008892b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7LdaOE2oInnS6X7HnjrSywvb7GK+fGJKIZzy5whDFXsMnZmM0WOwvoiC1yAgrbWbrlIVYoiU2BixSOIBeuUtSxo2MAqtmWnLL2Wo14LRcjJJpcbYN78YsJsCezyFJtKREFm7HMOOP9wo9m/1zIncxZVSL5yg2wcnfkmkqJyAvumJBQzZ/Jvb29ZaqrR6j7ruaIL8MmPrMmcGAMASWNk/24+pNauR/95CDZIYgf/oXcNFLGp9D8V2I2jesKkzwSapSjmdutMdxsrzQGmzwX/owO+KLqheNwx1qRELr11uF2faV1g3c0JQlY8xdl2xC841uKlZJin37YNB7E8Th7QZ6bg83nJacDFKGDAXsBu6JYY/eDGvej2/NcOBJ+rim7tY1k7VbhTTTRL970kKMYBpYxIrI3ofhyd08tbodUHv6ysum8geJ6d1lqr2eVpsVWWqhF5qaShB8tiGOryf1pxWm448TPW2mDyTWSWbFbQFBsN9ljExCnCZaL3wtpgb+c8kBifiSFiMJQByR4pkmb0PcWfWWbk/pi6AIj0V0obPBi926D8hjAABM5upUIMWO37IxhNjZMBxI/+62AAtdHX+b6GDwLu3uXVIfTtx2xIyzRVYuHqyDltV4zIkcBnepgTAEWGiHdT+2ozJRIxYg/40gh8H1uNE8xWznPK0lAfoUaITTVvs/wM4I3KgDC+TS+jYOsktAPgGJuv9y0/3ewKcKWbWhfO57E2JBLHVhxxMjjXQCeSq5+AezWjYn29eXqUFfb2HN4TiiQuEnAVxTptIAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(36756003)(7696005)(8676002)(1076003)(86362001)(6666004)(54906003)(316002)(110136005)(478600001)(5660300002)(44832011)(2906002)(4326008)(966005)(70206006)(82740400003)(70586007)(41300700001)(36860700001)(40480700001)(356005)(81166007)(186003)(82310400005)(2616005)(336012)(426003)(16526019)(26005)(8936002)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:37.9704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ceb92f-de60-439b-7b10-08db008892b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

...and call them from their respective setup_mci_misc_attrs() paths.

No functional change is intended.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-13-yazen.ghannam@amd.com

v1->v2:
* Call function directly instead of using pointers.

 drivers/edac/amd64_edac.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1062cb56a462..f1c613107a22 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1256,13 +1256,25 @@ static int get_channel_from_ecc_syndrome(struct mem_ctl_info *, u16);
  * Determine if the DIMMs have ECC enabled. ECC is enabled ONLY if all the DIMMs
  * are ECC capable.
  */
-static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
+static unsigned long dct_determine_edac_cap(struct amd64_pvt *pvt)
 {
 	unsigned long edac_cap = EDAC_FLAG_NONE;
 	u8 bit;
 
-	if (pvt->umc) {
-		u8 i, umc_en_mask = 0, dimm_ecc_en_mask = 0;
+	bit = (pvt->fam > 0xf || pvt->ext_model >= K8_REV_F)
+		? 19
+		: 17;
+
+	if (pvt->dclr0 & BIT(bit))
+		edac_cap = EDAC_FLAG_SECDED;
+
+	return edac_cap;
+}
+
+static unsigned long umc_determine_edac_cap(struct amd64_pvt *pvt)
+{
+	u8 i, umc_en_mask = 0, dimm_ecc_en_mask = 0;
+	unsigned long edac_cap = EDAC_FLAG_NONE;
 
 		for_each_umc(i) {
 			if (!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT))
@@ -1277,14 +1289,6 @@ static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
 
 		if (umc_en_mask == dimm_ecc_en_mask)
 			edac_cap = EDAC_FLAG_SECDED;
-	} else {
-		bit = (pvt->fam > 0xf || pvt->ext_model >= K8_REV_F)
-			? 19
-			: 17;
-
-		if (pvt->dclr0 & BIT(bit))
-			edac_cap = EDAC_FLAG_SECDED;
-	}
 
 	return edac_cap;
 }
@@ -3629,7 +3633,7 @@ static void dct_setup_mci_misc_attrs(struct mem_ctl_info *mci)
 	if (pvt->nbcap & NBCAP_CHIPKILL)
 		mci->edac_ctl_cap |= EDAC_FLAG_S4ECD4ED;
 
-	mci->edac_cap		= determine_edac_cap(pvt);
+	mci->edac_cap		= dct_determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
 	mci->ctl_name		= pvt->ctl_name;
 	mci->dev_name		= pci_name(pvt->F3);
@@ -3649,7 +3653,7 @@ static void umc_setup_mci_misc_attrs(struct mem_ctl_info *mci)
 
 	umc_determine_edac_ctl_cap(mci, pvt);
 
-	mci->edac_cap		= determine_edac_cap(pvt);
+	mci->edac_cap		= umc_determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
 	mci->ctl_name		= pvt->ctl_name;
 	mci->dev_name		= pci_name(pvt->F3);
-- 
2.25.1

