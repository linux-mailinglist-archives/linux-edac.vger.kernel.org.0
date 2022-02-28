Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3095D4C717E
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbiB1QPT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiB1QPS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:15:18 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1361845069
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpL+LKsjt1hicbeebgjD5dSdkr9KYpwQeWgbcWMvYrpIrB/FugTb9E6fsUuKIE3TD1ovivukW/H3cW934R9I2r2vL1qIoEcSu3YMwjcCeLjdOEbb0Z22S0t8qR6n0fbOhKl+9Fi/F3kbpukgsgm9vsZObYSKaGak8nq1pAb1FB7VS5pfg1YdLphTjp1fGKZ/Ykcg9CsRTEIgBiN9No2ndADG0l8QBx+Ecq4F8lG61M0Iv2uOSd76NYosxZkdm0d2FRuKwF4wusU3MMCru9vQeHGLGkgTG6NEKCyHu8VePR+L/c0sPc+0lfIAjd2gGZSafONBrM1uCvdqNP7DeVaPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYoOeZopdV4PXJ6zRfd5rie+HrBduS0uH/AkA/y7z0I=;
 b=I/yZgga08OYQRD8V7mPXImgM+qt9oG96/fDAbJdDgCNfFa+GkcpnP6APc2qcc3tCy0eeOIe5coVVfesyTsjBBjGAswq5zslyT8hVeb9JF8Sv5jrInxUvwvL0jPSYkTZjgitVSAog9XfjzTLqmtYngB2YHwtcyRSDvQYg+0LuFZeoLfXZ9gb7wKGOQl2NR+pODa9jRpYdZIlo9MrvXH9COSPBBNHcSY52WpfkTwb3M6LQ7Cm97H0Zll4fnaumGZsW1sxGFw4CzKGzf8ld6aM0X7obv97VFa4oi7aLBPt3/j+V3iS4dGWhveZZ9dln8fn3JzmMujaP+juOEJXCWUq0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYoOeZopdV4PXJ6zRfd5rie+HrBduS0uH/AkA/y7z0I=;
 b=fixpjF5cSQXtGUv4Ql68KbXpRLP9Sjdm7z/8Xw/NHho5OqV8cuYJByESHdqvxRq4wRQh7bqVGk4CoDkadoSxQ7zkBCH5ZCHVVjZ9wD+hEXNbLj+DOHDKWYnAZpkSf2jTVJaZLnZtqIvhhK867eTB4zwlyprH/8R7T1xpzY4dg3w=
Received: from BN9PR03CA0069.namprd03.prod.outlook.com (2603:10b6:408:fc::14)
 by MWHPR12MB1246.namprd12.prod.outlook.com (2603:10b6:300:f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 16:14:36 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::28) by BN9PR03CA0069.outlook.office365.com
 (2603:10b6:408:fc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:36 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:33 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 07/14] EDAC/amd64: Add ecc_enabled() into pvt->ops
Date:   Mon, 28 Feb 2022 21:43:47 +0530
Message-ID: <20220228161354.54923-8-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220228161354.54923-1-nchatrad@amd.com>
References: <20220228161354.54923-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f5e5825-09d2-46a1-fde1-08d9fad56a34
X-MS-TrafficTypeDiagnostic: MWHPR12MB1246:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1246E3A944A076DB6AE752F3E8019@MWHPR12MB1246.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXrsmbgHRHqtyrK4P7+gUGOm83u428uhq/Xe/dQEowINomIdH5QOatJFm01PG+UijTdO3KbAQavY09w2YuuX9UBXu2zYm3P3q3ZcSj49ikuwuCGrjd4s5/Y+v2ZNNvTAclzHemq70SEjpDk8nQRZig1FTqK7wLI9V77tWoiUcuTbNOItP5I22dTAjRam0AjhdlR0XG3AwEUDrSvDMpt2WWh92DJxzoQhYCgFr+cJ4A5nZk50cvJf74v1L2Mazqe2cLga392MquD6v45c08fMQJgmkdXpwbpzwS+cchAVkVLnCDqh2LLqxLFQ+Eqdmy+P1WDZFka/aZeZADYtL+WhTi54QrjLcrs5+3T6whFTMMLWglcMku2LUrNY1hW5lS5dJ06n0fZozueewP5phpJGeWMhlwGyOW22DZTDSgZ/P0/RpvBpoTxQp/F9RgKHHq3n7yyZU74KiBDqFddHclG0t9FDGWQUnjK8O0tPh8R8+6jKnirHLTyBcq8eIvrIzPKj1HErQaEhbTyhmFl4b3MCKawmvccOhsVJsIQtnfzWUldhWv6z3jZTUVRLg+x3noZB1ToOaY9jleymJ9Rc1x7+XLu62yEq94C+Dbtzth66z0AZAmVzLQ+a0SDKXUbkVB3cjinAEV4FXfRAjKM1dwc0etTSq6nyF5nmgoKxtMlEyrSIe5FfoJ2m14P9p0wNUw4m10/8LFKBMJL4Sk6Z64Ihx1QsQVqath9kaZ5SFwCXraeV7Zb35LL5+kH66W49dMdmuRobEmyUQHK/6ZjNrjYwuLpQZq62ReSdBS2NqcaLlQ8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(36860700001)(47076005)(83380400001)(356005)(6666004)(7696005)(8936002)(5660300002)(36756003)(70206006)(70586007)(16526019)(186003)(26005)(336012)(426003)(1076003)(2616005)(508600001)(8676002)(81166007)(4326008)(54906003)(6916009)(82310400004)(316002)(40460700003)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:36.5846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5e5825-09d2-46a1-fde1-08d9fad56a34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1246
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Add function pointer for ecc_enabled() in pvt->ops and assign
family specific ecc_enabled() definitions appropriately.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
This patch is created by splitting the 5/12th patch in series
[v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/

 drivers/edac/amd64_edac.c | 77 ++++++++++++++++++++++++---------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 713ffe763e64..15d775a9ce7e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3649,49 +3649,60 @@ static void restore_ecc_error_reporting(struct ecc_settings *s, u16 nid,
 		amd64_warn("Error restoring NB MCGCTL settings!\n");
 }
 
-static bool ecc_enabled(struct amd64_pvt *pvt)
+static bool f1x_ecc_enabled(struct amd64_pvt *pvt)
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
+static bool f17_ecc_enabled(struct amd64_pvt *pvt)
+{
+	u8 umc_en_mask = 0, ecc_en_mask = 0;
+	u8 ecc_en = 0, i;
+	u16 nid = pvt->mc_node_id;
+	bool nb_mce_en = false;
+	struct amd64_umc *umc;
 
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
+	/* Assume UMC MCA banks are enabled. */
+	nb_mce_en = true;
+
 	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
 
 	if (!ecc_en || !nb_mce_en)
@@ -3784,6 +3795,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
 		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
 		pvt->ops->get_mc_regs			= read_mc_regs;
+		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
 		break;
 
 	case 0x10:
@@ -3798,6 +3810,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
 		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
 		pvt->ops->get_mc_regs			= read_mc_regs;
+		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
 		break;
 
 	case 0x15:
@@ -3828,6 +3841,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
 		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
 		pvt->ops->get_mc_regs			= read_mc_regs;
+		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
 		break;
 
 	case 0x16:
@@ -3848,6 +3862,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
 		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
 		pvt->ops->get_mc_regs			= read_mc_regs;
+		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
 		break;
 
 	case 0x17:
@@ -3882,6 +3897,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_memory_type		= f17_determine_memory_type;
 		pvt->ops->determine_ecc_sym_sz		= f17_determine_ecc_sym_sz;
 		pvt->ops->get_mc_regs			= __read_mc_regs_df;
+		pvt->ops->ecc_enabled			= f17_ecc_enabled;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -3922,6 +3938,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_memory_type		= f17_determine_memory_type;
 		pvt->ops->determine_ecc_sym_sz		= f17_determine_ecc_sym_sz;
 		pvt->ops->get_mc_regs			= __read_mc_regs_df;
+		pvt->ops->ecc_enabled			= f17_ecc_enabled;
 		break;
 
 	default:
@@ -3933,7 +3950,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 	if (!pvt->ops->early_channel_count || !pvt->ops->dbam_to_cs ||
 	    !pvt->ops->get_base_mask || !pvt->ops->prep_chip_selects ||
 	    !pvt->ops->determine_memory_type || !pvt->ops->determine_ecc_sym_sz ||
-	    !pvt->ops->get_mc_regs) {
+	    !pvt->ops->get_mc_regs || !pvt->ops->ecc_enabled) {
 		edac_dbg(1, "Common helper routines not defined.\n");
 		return -EFAULT;
 	}
@@ -4095,7 +4112,7 @@ static int probe_one_instance(unsigned int nid)
 		goto err_enable;
 	}
 
-	if (!ecc_enabled(pvt)) {
+	if (!pvt->ops->ecc_enabled(pvt)) {
 		ret = -ENODEV;
 
 		if (!ecc_enable_override)
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 1b6df33bb0a8..6cc3fc943fcd 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -469,6 +469,7 @@ struct low_ops {
 	void (*determine_memory_type)(struct amd64_pvt *pvt);
 	void (*determine_ecc_sym_sz)(struct amd64_pvt *pvt);
 	void (*get_mc_regs)(struct amd64_pvt *pvt);
+	bool (*ecc_enabled)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1

