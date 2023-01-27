Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7C467EBF6
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjA0RF3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbjA0RFZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:05:25 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613D584F8F;
        Fri, 27 Jan 2023 09:04:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOb/JTQRa++zJOAnSkkO+Y2AO6kd41oyaDiaocgnWmShHjZ/vrNBDbXIdWPEvmmhQMhYMQbFe80KbFTCaJSo/9aj4S6vKBfMM1556tk7UuvTDPSTzCFq2qL9C2/3G5n4BC83eMKjlyzERrZbtOQyvAEjKpr5y5ikPfADHjDIVrRYBPDEEoUqhfVDNs7ZwxG8ekoxugfQt8q5ASo8MAcmHguMabk84VtNTQUcWU9EWmdfLm1PKkynkcNhVyiynBe83SJD+kH5CfWRH6BaV8gYmH8q5BFtsxvUdfeNExQGROJCtAp7IcetvGlrKiwS+bibbS+3hIOCyC4iBggFnQMaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PcZgMg019jjIigLGM5JL7QfFpfLdgsHGV9Ftqn6YtA=;
 b=euMVatYfzf2gOWL2lm+Vya0UN5BJp2lxYFppT8i7sZBCjZbLMZ62M2PVmQ3eZlZrJDecx6cvggm4sgY1tkRpy9ir9OFonXxvzwB+tl7li0x06xWe2nd1r17g6vkymFKuPN716ECI95GxvKulT6Hu4qq+gKepSyw1g3681e1e7uhHDxYSKuWjbDRVKWR7FDPCV08kUkoMQ1L4R0EX4MC4VwROVhUtLkl7GiYyWR6hb7OYQre0kXIqtyMMRy+4fqzmsm184Td3edPLCADEIjWwbthx2JC+zv5G3tpJAMWv2tzgM8cSuj96ecdeLHQJl/YCCYnh4ydXrpf6OTK+TtQULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PcZgMg019jjIigLGM5JL7QfFpfLdgsHGV9Ftqn6YtA=;
 b=yeEWmyBND2Ot3zH8FwZdOoqmCKYqvBW61kFkL55nuxuvuOHN3c0yljY4F3HD0RvKadih67pw6xOsdACZIkUG/5Owutzg77Mwwievb1f3NdTokI6rGEXdCWyH0SQjLmOwc4ONOv5vPklvfaxatsZjk76yUTKepfM2cS/qiKskw2s=
Received: from BN8PR04CA0037.namprd04.prod.outlook.com (2603:10b6:408:d4::11)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 17:04:33 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::5e) by BN8PR04CA0037.outlook.office365.com
 (2603:10b6:408:d4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:33 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:31 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 04/22] EDAC/amd64: Remove PCI Function 0
Date:   Fri, 27 Jan 2023 17:04:01 +0000
Message-ID: <20230127170419.1824692-5-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 2937749a-b5aa-4117-ba74-08db00889004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLThrg8puIiyQjU2EKx1FXamp0vGKpK2aJpddVxR59HvkbM1qju+cg5orP5mLEtVdHlfuSexbBHgVeOn+N6q0ilYRv9UjFi+YHD5ekjQGQAd8xHAKb8KO/P28JIApvY0T6QPnQCcPsmdXPqSEONnJhV48jV8Y6+N0xqeavgsO06d9Mpe0t2MM1zo5Ymeu76RSXXl1wMu3iq4l5wC/U/DbvOygk0ftPFezNe2z1r72vt0hTZYrI2g3fZVSvv3cLrtVBWQEWlcN06MWBhCC3WyYwHVhInZd1lous1USQ8manF7BJTbyo7J3Ru3PfsclaRSwgtGXuZH4q1Ro1kvBe2hUC6rYdFg/V9iQM2j3CA4PIx4eBusb2RqdwTYAGZWbhc46CbvlbTcZnSauUnprF4g1eRJCS6rCrIdOpZc1NkqJLUU2UzjFAP0q2sLCDDOb8cqZm1oGaT8gPuIWymGkiKXKm2qqiwWOdRLkhRX1qVn0vUw2Q6XQUkmTSBwRzHeYjuRbsHmybWvoyrkaUal0uoo0wz4NSe8RGi6S7UgxpVFTr41+kD41fWshoyLypGTyM5dyKF5zbA58id5Rvlx3+r1AlWroJsT36N0VKYm1dniFaFx5MMnf6dBRSCaMMM7C6TUT7s/NDBAOXtFae8rwKxcJ8aqoR1vVAl0mvCXOEu3I5A0sqQEf1KuZXJ5fKh0KFJsOFns2Yv2fKe+UgWo8z5bNIiAg7nrw0dih49K355FrQzRGJtq0k5DuZQbrVrGVYCB4ynYjKWxH8a6fFHL0fJKlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199018)(46966006)(40470700004)(36840700001)(4326008)(2616005)(186003)(26005)(16526019)(336012)(36860700001)(82310400005)(83380400001)(356005)(36756003)(40460700003)(40480700001)(82740400003)(81166007)(86362001)(426003)(47076005)(70206006)(70586007)(8676002)(316002)(44832011)(41300700001)(8936002)(5660300002)(2906002)(54906003)(478600001)(7696005)(966005)(6666004)(1076003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:33.4369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2937749a-b5aa-4117-ba74-08db00889004
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
Link:
https://lore.kernel.org/r/20220509145534.44912-5-yazen.ghannam@amd.com

v1->v2:
* Also remove "pvt->F0" pointer.

 drivers/edac/amd64_edac.c | 38 +++++---------------------------------
 drivers/edac/amd64_edac.h | 12 ++----------
 2 files changed, 7 insertions(+), 43 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index dce2179ad454..352cbcda53f9 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1428,9 +1428,6 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 
 		debug_display_dimm_sizes_df(pvt, i);
 	}
-
-	edac_dbg(1, "F0x104 (DRAM Hole Address): 0x%08x, base: 0x%08x\n",
-		 pvt->dhar, dhar_base(pvt));
 }
 
 /* Display and decode various NB registers for debug purposes. */
@@ -1465,6 +1462,8 @@ static void __dump_misc_regs(struct amd64_pvt *pvt)
 	/* Only if NOT ganged does dclr1 have valid info */
 	if (!dct_ganging_enabled(pvt))
 		debug_dump_dramcfg_low(pvt, pvt->dclr1, 1);
+
+	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
 }
 
 /* Display and decode various NB registers for debug purposes. */
@@ -1475,8 +1474,6 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
 	else
 		__dump_misc_regs(pvt);
 
-	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
-
 	amd64_info("using x%u syndromes.\n", pvt->ecc_sym_sz);
 }
 
@@ -2905,7 +2902,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F17_CPUS] = {
 		.ctl_name = "F17h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_DF_F0,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2914,7 +2910,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F17_M10H_CPUS] = {
 		.ctl_name = "F17h_M10h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2923,7 +2918,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F17_M30H_CPUS] = {
 		.ctl_name = "F17h_M30h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
 		.max_mcs = 8,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2932,7 +2926,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F17_M60H_CPUS] = {
 		.ctl_name = "F17h_M60h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F0,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2941,7 +2934,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F17_M70H_CPUS] = {
 		.ctl_name = "F17h_M70h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2950,7 +2942,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F19_CPUS] = {
 		.ctl_name = "F19h",
-		.f0_id = PCI_DEVICE_ID_AMD_19H_DF_F0,
 		.max_mcs = 8,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2959,7 +2950,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F19_M10H_CPUS] = {
 		.ctl_name = "F19h_M10h",
-		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
 		.max_mcs = 12,
 		.flags.zn_regs_v2 = 1,
 		.ops = {
@@ -2969,7 +2959,6 @@ static struct amd64_family_type family_types[] = {
 	},
 	[F19_M50H_CPUS] = {
 		.ctl_name = "F19h_M50h",
-		.f0_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F0,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -3282,26 +3271,12 @@ static void decode_umc_error(int node_id, struct mce *m)
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
@@ -3333,7 +3308,7 @@ reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
 static void free_mc_sibling_devs(struct amd64_pvt *pvt)
 {
 	if (pvt->umc) {
-		pci_dev_put(pvt->F0);
+		return;
 	} else {
 		pci_dev_put(pvt->F1);
 		pci_dev_put(pvt->F2);
@@ -3423,7 +3398,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 
 	if (pvt->umc) {
 		__read_mc_regs_df(pvt);
-		amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
 
 		goto skip;
 	}
@@ -4057,8 +4031,6 @@ static int hw_info_get(struct amd64_pvt *pvt)
 		pvt->umc = kcalloc(fam_type->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
 		if (!pvt->umc)
 			return -ENOMEM;
-
-		pci_id1 = fam_type->f0_id;
 	} else {
 		pci_id1 = fam_type->f1_id;
 		pci_id2 = fam_type->f2_id;
@@ -4075,7 +4047,7 @@ static int hw_info_get(struct amd64_pvt *pvt)
 
 static void hw_info_put(struct amd64_pvt *pvt)
 {
-	if (pvt->F0 || pvt->F1)
+	if (pvt->F1)
 		free_mc_sibling_devs(pvt);
 
 	kfree(pvt->umc);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 2d5ea9ca3868..398fb58dacbf 100644
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
@@ -346,7 +338,7 @@ struct amd64_pvt {
 	struct low_ops *ops;
 
 	/* pci_device handles which we utilize */
-	struct pci_dev *F0, *F1, *F2, *F3;
+	struct pci_dev *F1, *F2, *F3;
 
 	u16 mc_node_id;		/* MC index of this MC node */
 	u8 fam;			/* CPU family */
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

