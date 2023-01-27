Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A199467EC00
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjA0RFs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjA0RFf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:05:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F75B4F353;
        Fri, 27 Jan 2023 09:05:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HA6OdXntSpgM+tF8J6bCP0vlUbsEKV/nQxoOQ59TpXhzmGH2a/drVQutbmIsvEPq/EHFQrYQOMR3WMflg8RRCGsa3I8gsmDdgG7dfQVPJUbcneWXmONcMcISJykxJtzL1tyHGuh/0kv7eq7nPcqWRdP31vCKvMP6nkiqx/2psxH3jtiCpjt739zxc6cu5zoZC0Fzhys3FvwvyCBkRYhN+xMaDKjoRssFEc4JXlYwMWL3KkugCn2PbL2jwx9dJjNOKSjXFAnnLossv0OTHID5FnrMvnEq4Q6dpuWq6lNePmYoAAeV/1LABAgSRssZ12AL0mSdk0fotUH5qNX6+Am49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7w12skH6KD0cJOo1BHf+ijczs+5VKURFoXGVYzrId0=;
 b=ek9RkDnXcS+B0Fv+4wNZvLiJQIVgAuGsH2d9exvJuL3BByD9K7uQLNINSrw/ABSUqXY0rfbrMz8MzwxArsVvB8wC/NVxygBb/h2zOuRMeU1a6vQhhi8Cl6RRvkcaNwj5PK19iTVBaWYbN2qBXH900nr9aWgwe49xG0QRh1op2DlpD1lJ0mfcv/rCa0aODe70U9oOto2ecrCxt3AbDax5vyVsb3TQVKVc5SEV/jNN8BW2rX+NQyWCzRU4uNuUXNEku/DfcZTtirPX9Po62f+EYgdGkibxh1EiZPar8jPAfVh3hiObgr2iG8CH7ykMID2D2BLD4KdP3fN34/G8qwXh0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7w12skH6KD0cJOo1BHf+ijczs+5VKURFoXGVYzrId0=;
 b=se0X02cTCERhbHsyMvk9i8YbJDaUu/+lrifMTZquYP4rNxD5RBMHPQE8qiaJ1UGP8kowBQLgurkU3wKH3LGWfVuUhC57ePvVvehMWfBCkl8t9riT+BBCGm4JPo/PpWZobGbmD6aIpDqKcrFsfFwMOklHITHNm2dxIws/RpgM73o=
Received: from BN9PR03CA0477.namprd03.prod.outlook.com (2603:10b6:408:139::32)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 17:04:37 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::6f) by BN9PR03CA0477.outlook.office365.com
 (2603:10b6:408:139::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:37 +0000
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
 2023 11:04:36 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 16/22] EDAC/amd64: Split ecc_enabled() into dct/umc functions
Date:   Fri, 27 Jan 2023 17:04:13 +0000
Message-ID: <20230127170419.1824692-17-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0c78a5-6ea7-4bd4-1e98-08db00889259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWJ3glBxyPM4Avt9XevRke0EPbSa6cZDXR8eF5L7exAxT7Bw66Wx6+qgDRh1lBOzIEtiv5/k3ww+l+ykjNOZbHwmruYGj7vs/aK2zkaDfcIKKIa0gAkdMPZ07f51VTCD7ALpczjAXrZ2iOepP5CBB9jXFB93I+s69W/c6LsPFLofzG0svsg3XQjjfo26lhVZU1N0Vj2zG/EXio9hLMLp0FuVbSe/+lx8uCLdFkIAcufskHT3m8JhLfETDZumFhuL+OTjUhHbzGE8lt73cJQYDtCtZ6+sIjL9JgH9DhMGUiEXaWTKzyrFze2zjORQqQ/D7AJDbykA2BsdGUl3OKyvdy5/J/+zphuBVrCk54hodpsAtfieIrn6gW9wa6gwyJgeGJyMIDLwqAKJPUDkM18U0IxxOY4iYnMcxTZ5Cd1AD2/eHTU5pCl0d0zqJhDroMGN5u0zTq500Rw/M36LiGzn0zFz4fBSG326Um533NxM+VEEo62Vd4+rB32QkRZwS7wAo29NhAfVW/gfdrETzoR83AwQQusBlw1RhOWw24JY4SnjC8tJJ/l3sTiuQzVC0vP8znKwnok1kdLFu39AbPhUn55X78fkn7Y7lxrPWWK3M4Pp5/krtaWL22KqgCHLvqznBscr3PuSck8oTJsD5DzMcmRXF0XMpN/gOT5p5usI12tWg91sicvW3kg7BMOdSRJ6Ntp3z0xXF5MkXv5NiHVBTK62lH7/E1OfVNk5Ogp1LyCERfNvKa+xxFL1ftPGsis6WR0yJ/I5b3k0ZKpp38uEHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(40470700004)(36840700001)(46966006)(7696005)(16526019)(186003)(26005)(478600001)(966005)(47076005)(2616005)(336012)(82310400005)(426003)(83380400001)(6666004)(316002)(54906003)(41300700001)(8676002)(81166007)(356005)(1076003)(70206006)(82740400003)(110136005)(8936002)(44832011)(40460700003)(86362001)(4326008)(5660300002)(70586007)(36756003)(40480700001)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:37.3454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0c78a5-6ea7-4bd4-1e98-08db00889259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

...and call them using a function pointer in pvt->ops. The "ECC enabled"
check is done outside of the hardware information gathering done in
hw_info_get(). So a high-level function pointer is needed to separate
the legacy and modern paths.

No functional change is intended.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-12-yazen.ghannam@amd.com

v1->v2:
* Update commit message.

 drivers/edac/amd64_edac.c | 69 ++++++++++++++++++++++-----------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 757d35fad2a6..ecffe2f1ea9a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3527,52 +3527,59 @@ static void restore_ecc_error_reporting(struct ecc_settings *s, u16 nid,
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
@@ -3678,6 +3685,7 @@ static void hw_info_put(struct amd64_pvt *pvt)
 
 static struct low_ops umc_ops = {
 	.hw_info_get			= umc_hw_info_get,
+	.ecc_enabled			= umc_ecc_enabled,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
@@ -3685,6 +3693,7 @@ static struct low_ops dct_ops = {
 	.map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow,
 	.dbam_to_cs			= f16_dbam_to_chip_select,
 	.hw_info_get			= dct_hw_info_get,
+	.ecc_enabled			= dct_ecc_enabled,
 };
 
 static int per_family_init(struct amd64_pvt *pvt)
@@ -3910,7 +3919,7 @@ static int probe_one_instance(unsigned int nid)
 		goto err_enable;
 	}
 
-	if (!ecc_enabled(pvt)) {
+	if (!pvt->ops->ecc_enabled(pvt)) {
 		ret = -ENODEV;
 
 		if (!ecc_enable_override)
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 00b3f32e3cbb..103cd38a6302 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -467,6 +467,7 @@ struct low_ops {
 	int  (*dbam_to_cs)(struct amd64_pvt *pvt, u8 dct,
 			   unsigned int cs_mode, int cs_mask_nr);
 	int (*hw_info_get)(struct amd64_pvt *pvt);
+	bool (*ecc_enabled)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

