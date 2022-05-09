Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31EA520089
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbiEIO7z (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 10:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbiEIO7v (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 10:59:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7941DF675;
        Mon,  9 May 2022 07:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmPDcfN6UexRa53tyOo1wfkQdsUX4iZCXO08xM2l008ii7Ly6pVmFM6JsvPdTOS1sKufl0E4vdXP1v1wcS4D0+dP9xmMsSw7zzKOMPEIZFHLpsYEfBvAHFm92vfLsVjfWO44oyPaFWktJe5yVGytXfqS8ZksmiVraJd+EHJPubNtahkiZqAsz00bO8BA1WjIc0Q/exPEFBA6Ra0GIIJf+bFncbBKj9TH2ewJMda/IfAy2R0Gf+Qi50SttLnsxNR4z0IlKhVa2dXUSN24rohmyyzEnt92CBna2DjXgdDTnfO0mXVMlMaPB1NiUdHAz8MOcFZjBLddCJmPlVDWtG1sjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMqLXKeMtVGZjtFuvJdOPW1/96HQ5OBKclba9OJjhaM=;
 b=GWETnVDei8Sk3jrRLmsolbHlUmXsLx0y9d2cV/80qMuN+4FMcL+AXQeLa0ieDTGtR0Y0NEVeiybYh9nWBwtBZsPvSSslhnFuky9Ktt1a3RGyvgTjHm0rPaj0XVJKf2RzhK2Nz9mY+qnQrS0d5A7RgjNdsIu4vcJ9GG967QdUspvhZAdHVDUcVEiou8uejoNS2SeQaE9/vbavr9Mwc4Jw7Z/pzwkdGuWtmLeBv5+hjnvUGdpONoctFTGihh/rc90rB1Rl8dkkl7qS5kwJdh63aqZGVhdNMCZgPy6IFbeIWr/dMenPLow3y6Zk4F4F561NuThLCRjImsF5n+OWZJ+ItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMqLXKeMtVGZjtFuvJdOPW1/96HQ5OBKclba9OJjhaM=;
 b=zVJ5kYMMJE+JEdOPZ1V74OKJxYwTz1ptfkgib2ZF5UHTrzFqfpQHlKcrxUPHI5rWJGy1PFDsMg8GJcm1pyBXr5nZAhGJFu5IBrp4CLcCDxYlR52knZeNafRrq8CuMaln2THu6DiwJVL/tH1aeJpiJkRtUNWwgyHwukAJ+bMY8+c=
Received: from MW4PR03CA0319.namprd03.prod.outlook.com (2603:10b6:303:dd::24)
 by BYAPR12MB4982.namprd12.prod.outlook.com (2603:10b6:a03:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Mon, 9 May
 2022 14:55:54 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::e4) by MW4PR03CA0319.outlook.office365.com
 (2603:10b6:303:dd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Mon, 9 May 2022 14:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:54 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:47 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 04/18] EDAC/amd64: Remove PCI Function 0
Date:   Mon, 9 May 2022 14:55:20 +0000
Message-ID: <20220509145534.44912-5-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 731666e1-77e9-4c0c-7d62-08da31cc046b
X-MS-TrafficTypeDiagnostic: BYAPR12MB4982:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4982B2D31DF9768B62139A52F8C69@BYAPR12MB4982.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RS5vQz/zJ6MJdcIhpeVTx292jlLeN9PaKeM4pLADotmUoQGOrY+aMzHALXnF6GuMqr4gFsh5AYIL3qTL/rhBVlkkQiU3WpDkC0/D6p87ikSi7q2Qjl8I8ppCWUxjQIVG18HEN23B8e3rjkUG0+G5+QHVMqsi4EhZjzFlv6ZxKctoeq0GaTLo6j7R7DvqSom23PYRcbnsEqVCiKc0K7gng++5fmM+ojCO1JZUM71Jm43wDpRdnotF3/DDSRYr12s1JTSMciCdg7SBBFlN54Orq7D26HhLl7ZOPsjpLNJft2YhfnQ+Gp10p2Vor4lHfNCG48bchFdhLpz//tp7AP7g9OGeD4vFspEczTIRPCEn4rXbN2i9DE9yyUQ1Ki4fG4qGpjEczpF5QzuovXXOflWIr4Up2IJG4EtPQWiZ4RwI9/mmTVpihXSUCUMXshaCjWbNCvNYA4H1YTPvoVEiIc/dMYvipwEMyanW9QTH/d/x+qPBMKBd2dGHECypZ4Gtu/VjyJs/47Tn0yuW2A3v7/Ht7tL+WIpy3AAsEHpFWHShw5Q1poij1tFzT4TlWEJd5rHPCRK2ImsfJZeoggQOd+yrGB+m5BmlYDKbcJxQGn81LQQEGxnIXjdY0uuKo8dL4ah1ghWaBBoACJ/Qqvcwz0c7C20rTOdNR5BpAHnEOJaQsjxsA6Puuw66MM6DFC75wqruRKpM++XEdlsAjh5d3ADXNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(47076005)(2616005)(16526019)(186003)(1076003)(336012)(6666004)(426003)(7696005)(36756003)(356005)(81166007)(86362001)(40460700003)(83380400001)(82310400005)(54906003)(36860700001)(110136005)(44832011)(5660300002)(508600001)(316002)(70586007)(8676002)(4326008)(2906002)(70206006)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:54.1714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 731666e1-77e9-4c0c-7d62-08da31cc046b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PCI Function 0 is used on Family 17h and later only to read the "dhar"
value. This value is printed and provided through a module-specific
debug sysfs file. The value is not used for any Family 17h and later
code, and it does not have any apparent debug value on these systems.

Remove "dhar", Function 0 PCI IDs, and all related code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 38 +++++---------------------------------
 drivers/edac/amd64_edac.h | 10 +---------
 2 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b2f7c14a287c..e0f99b8edc97 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1433,9 +1433,6 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 
 		debug_display_dimm_sizes_df(pvt, i);
 	}
-
-	edac_dbg(1, "F0x104 (DRAM Hole Address): 0x%08x, base: 0x%08x\n",
-		 pvt->dhar, dhar_base(pvt));
 }
 
 /* Display and decode various NB registers for debug purposes. */
@@ -1470,6 +1467,8 @@ static void __dump_misc_regs(struct amd64_pvt *pvt)
 	/* Only if NOT ganged does dclr1 have valid info */
 	if (!dct_ganging_enabled(pvt))
 		debug_dump_dramcfg_low(pvt, pvt->dclr1, 1);
+
+	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
 }
 
 /* Display and decode various NB registers for debug purposes. */
@@ -1480,8 +1479,6 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
 	else
 		__dump_misc_regs(pvt);
 
-	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
-
 	amd64_info("using x%u syndromes.\n", pvt->ecc_sym_sz);
 }
 
@@ -2910,7 +2907,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F17_CPUS] = {
 		.ctl_name = "F17h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_DF_F0,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2919,7 +2915,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F17_M10H_CPUS] = {
 		.ctl_name = "F17h_M10h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2928,7 +2923,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F17_M30H_CPUS] = {
 		.ctl_name = "F17h_M30h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
 		.max_mcs = 8,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2937,7 +2931,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F17_M60H_CPUS] = {
 		.ctl_name = "F17h_M60h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F0,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2946,7 +2939,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F17_M70H_CPUS] = {
 		.ctl_name = "F17h_M70h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2955,7 +2947,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F19_CPUS] = {
 		.ctl_name = "F19h",
-		.f0_id = PCI_DEVICE_ID_AMD_19H_DF_F0,
 		.max_mcs = 8,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2964,7 +2955,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F19_M10H_CPUS] = {
 		.ctl_name = "F19h_M10h",
-		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
 		.max_mcs = 12,
 		.flags.zn_regs_v2 = 1,
 		.ops = {
@@ -2974,7 +2964,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F19_M50H_CPUS] = {
 		.ctl_name = "F19h_M50h",
-		.f0_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F0,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -3287,26 +3276,12 @@ static void decode_umc_error(int node_id, struct mce *m)
 /*
  * Use pvt->F3 which contains the F3 CPU PCI device to get the related
  * F1 (AddrMap) and F2 (Dct) devices. Return negative value on error.
- * Reserve F0 on systems with a UMC.
  */
 static int
 reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
 {
-	if (pvt->umc) {
-		pvt->F0 = pci_get_related_function(pvt->F3->vendor, pci_id1, pvt->F3);
-		if (!pvt->F0) {
-			edac_dbg(1, "F0 not found, device 0x%x\n", pci_id1);
-			return -ENODEV;
-		}
-
-		if (!pci_ctl_dev)
-			pci_ctl_dev = &pvt->F0->dev;
-
-		edac_dbg(1, "F0: %s\n", pci_name(pvt->F0));
-		edac_dbg(1, "F3: %s\n", pci_name(pvt->F3));
-
+	if (pvt->umc)
 		return 0;
-	}
 
 	/* Reserve the ADDRESS MAP Device */
 	pvt->F1 = pci_get_related_function(pvt->F3->vendor, pci_id1, pvt->F3);
@@ -3338,7 +3313,7 @@ reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
 static void free_mc_sibling_devs(struct amd64_pvt *pvt)
 {
 	if (pvt->umc) {
-		pci_dev_put(pvt->F0);
+		return;
 	} else {
 		pci_dev_put(pvt->F1);
 		pci_dev_put(pvt->F2);
@@ -3428,7 +3403,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 
 	if (pvt->umc) {
 		__read_mc_regs_df(pvt);
-		amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
 
 		goto skip;
 	}
@@ -4059,8 +4033,6 @@ static int hw_info_get(struct amd64_pvt *pvt)
 		pvt->umc = kcalloc(fam_type->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
 		if (!pvt->umc)
 			return -ENOMEM;
-
-		pci_id1 = fam_type->f0_id;
 	} else {
 		pci_id1 = fam_type->f1_id;
 		pci_id2 = fam_type->f2_id;
@@ -4077,7 +4049,7 @@ static int hw_info_get(struct amd64_pvt *pvt)
 
 static void hw_info_put(struct amd64_pvt *pvt)
 {
-	if (pvt->F0 || pvt->F1)
+	if (pvt->F1)
 		free_mc_sibling_devs(pvt);
 
 	kfree(pvt->umc);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 2c7b49479aa9..7cfac50d6558 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -114,14 +114,6 @@
 #define PCI_DEVICE_ID_AMD_16H_NB_F2	0x1532
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F1 0x1581
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F2 0x1582
-#define PCI_DEVICE_ID_AMD_17H_DF_F0	0x1460
-#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F0 0x15e8
-#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F0 0x1490
-#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F0 0x1448
-#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F0 0x1440
-#define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
-#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F0 0x14ad
-#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F0 0x166a
 
 /*
  * Function 1 - Address Map
@@ -493,7 +485,7 @@ struct amd64_family_flags {
 
 struct amd64_family_type {
 	const char *ctl_name;
-	u16 f0_id, f1_id, f2_id;
+	u16 f1_id, f2_id;
 	/* Maximum number of memory controllers per die/node. */
 	u8 max_mcs;
 	struct amd64_family_flags flags;
-- 
2.25.1

