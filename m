Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0001667EC1D
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjA0RHl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjA0RH1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:07:27 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8309986EAC;
        Fri, 27 Jan 2023 09:06:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCZAj1A3GMK9n0/0aURDJ1MyWWDsRPAQoF3dKIHMUkNxFh1+yE0TKCZyC69xZQn5E4YOkFW0JuxXZH52QiMlTpSynhfjg5zzvQubU8AdDHMFRhSsywLv/NmUPI+4p1qh9LFKDlU4yi8W0RLl7X5Rjkw06vV/7TaomR1ZegvEBTewOfOhvG0W0DWkQGZ1pE7hT4XCe4l5IbJrqCry0xixQA3VDYLd5ZTtbG4pxqKdj+M3lEc/JWa2SSZ3YLMKj1qf4myQVpLIlxT6R1rcCqRIO8qJSDMH4kRasGISaAWVtZ5EQIFFz4oK3nHPzbzi7ibMDcrVZ2Vtx/o1jwpOGSOFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOw4CeLcFhN8zTDuNyCccuduK8o748M5EJqwKg6eRV8=;
 b=kG5X+ANrBeriwStRq/36lvCcBSA5m/N9CJJEsnGxjxyQcA6YxI100HTz0rNoA5zIiEMmeEV2VnoExICnL3jZzHB8jTwnket0L0PIfqlWcRdrSwWeVVJbXbbjhSb0T2JPvzVA22jy7o771CwLCh92RmPbghUQ1OpI97eLSx0nxF3GO/TbjwZGBiBwEoly7hfTrW2Q4p9/r7z5Y8bbtOWKrjWURUp+ZkPXRMMM0s4PXbl0ttBSz75iaZ8YjWgRmIL3B/puDyle7LL5UDPx6Vru0YUfYiHobhqvydjR9RL9PwqMBpt8iFN+BpaSKz2HynHLq0ux0ucj9iBam0o8gndg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOw4CeLcFhN8zTDuNyCccuduK8o748M5EJqwKg6eRV8=;
 b=k2SK9e5Z0bFnL4tGJmlf55fV3lgSVPTXs+GUuOaHt7FLPYUi6ECkBK3DaTCIDKmnQjfsamISgM10IepGDirKcm3ZoZUQ1w7w4hUm3Yj7dJF2pn2TF33TxNXfjWjhoxH2cpZZJXkvYjX5ByVb+9+0LvVghR6yikaBftkWBWAu6RE=
Received: from BN8PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:d4::34)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 17:04:33 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::18) by BN8PR04CA0060.outlook.office365.com
 (2603:10b6:408:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:32 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:31 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 03/22] EDAC/amd64: Remove PCI Function 6
Date:   Fri, 27 Jan 2023 17:04:00 +0000
Message-ID: <20230127170419.1824692-4-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0deac8-b69f-4a69-49fa-08db00888fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eph98u+DhyrWtv6+LR/wMYQFC+5Zlreb5zJTnmZD3LoMlv1U7jHoyZLY68XTXv/KgpReXionK8n3hlKMYUVFu67MjJyPT1l/vYKCCD8Inzue27IFGqlz2KTQmh7iSP0jywLI8ePKjkJsvVT5ZHgKhDZQs+cC9CGVbee2/rBx5EQaBhD01pMFP0AkJkIQpCQpJBUTnmj7IbCijHbntsyr3qmXZbUGgaVdzCT9wH/62X7/A8shKKTU3Oj2cTbQPcaVFgur/l8vsnl7C1ghPTGT+ZXjlj0BCJZPX1Do+on55eq0NUbpstDXu9gq+j/ajmlMjtzgb1JqkIEnxfMpJCXytaOi5iYHbmZzmCO13q50VNFdsMozrfttFBHblC1vnw143ZgTTFeGd+HKP9ZBOKRJYMfSDNmINFiOqOc2rcoacQUsEWUTv4kti+Fxw0eKB691Jf4bQs9oO5eNMLUBypNSzfja6GUFOYUhZ0ESybm+Rk+JD8gVSguMbhDnK2CO8VQQt63xd7/clczLXA9QSM7qDdaM6SJAfxT+8INiQSLP4sVyVm6grBrYsqIyNIdqFQQIDffeRKzav1QHhVFZo3SH55I3+gE8UxDlnV1B0Aaf3zGXtBHvOv//3gIvRAhquak9m9SKbZNZjDnu6mLkT5RqxbSWCrWUoADuDshTgZh+9Vmx7HiplzE1fhlwKM2I/cAh0oFX0cKgaQ2POHS++8EeZrGY5+xU9ih1lo85ZSx59vaAjsknVyFECFE7UYCFN0HtPFpTqbk8HcCg3IJ+tMcSnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199018)(46966006)(36840700001)(40470700004)(2906002)(44832011)(40460700003)(356005)(1076003)(81166007)(110136005)(2616005)(36860700001)(186003)(70586007)(336012)(26005)(426003)(40480700001)(16526019)(83380400001)(70206006)(6666004)(47076005)(4326008)(5660300002)(86362001)(8676002)(316002)(8936002)(966005)(36756003)(41300700001)(7696005)(478600001)(82740400003)(54906003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:32.8901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0deac8-b69f-4a69-49fa-08db00888fb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PCI Function 6 is used on Family 17h and later to access scrub
registers. With scrub access removed, this function has no other use.

Remove all Function 6 PCI IDs and related code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-4-yazen.ghannam@amd.com

v1->v2:
* Also remove "pvt->F6" pointer.

 drivers/edac/amd64_edac.c | 22 +---------------------
 drivers/edac/amd64_edac.h | 12 ++----------
 2 files changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 07a89df0d4f4..dce2179ad454 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2906,7 +2906,6 @@ static struct amd64_family_type family_types[] = {
 	[F17_CPUS] = {
 		.ctl_name = "F17h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_DF_F6,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2916,7 +2915,6 @@ static struct amd64_family_type family_types[] = {
 	[F17_M10H_CPUS] = {
 		.ctl_name = "F17h_M10h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2926,7 +2924,6 @@ static struct amd64_family_type family_types[] = {
 	[F17_M30H_CPUS] = {
 		.ctl_name = "F17h_M30h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
 		.max_mcs = 8,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2936,7 +2933,6 @@ static struct amd64_family_type family_types[] = {
 	[F17_M60H_CPUS] = {
 		.ctl_name = "F17h_M60h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F6,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2946,7 +2942,6 @@ static struct amd64_family_type family_types[] = {
 	[F17_M70H_CPUS] = {
 		.ctl_name = "F17h_M70h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2956,7 +2951,6 @@ static struct amd64_family_type family_types[] = {
 	[F19_CPUS] = {
 		.ctl_name = "F19h",
 		.f0_id = PCI_DEVICE_ID_AMD_19H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_19H_DF_F6,
 		.max_mcs = 8,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2966,7 +2960,6 @@ static struct amd64_family_type family_types[] = {
 	[F19_M10H_CPUS] = {
 		.ctl_name = "F19h_M10h",
 		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F6,
 		.max_mcs = 12,
 		.flags.zn_regs_v2 = 1,
 		.ops = {
@@ -2977,7 +2970,6 @@ static struct amd64_family_type family_types[] = {
 	[F19_M50H_CPUS] = {
 		.ctl_name = "F19h_M50h",
 		.f0_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F6,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -3290,7 +3282,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 /*
  * Use pvt->F3 which contains the F3 CPU PCI device to get the related
  * F1 (AddrMap) and F2 (Dct) devices. Return negative value on error.
- * Reserve F0 and F6 on systems with a UMC.
+ * Reserve F0 on systems with a UMC.
  */
 static int
 reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
@@ -3302,21 +3294,11 @@ reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
 			return -ENODEV;
 		}
 
-		pvt->F6 = pci_get_related_function(pvt->F3->vendor, pci_id2, pvt->F3);
-		if (!pvt->F6) {
-			pci_dev_put(pvt->F0);
-			pvt->F0 = NULL;
-
-			edac_dbg(1, "F6 not found: device 0x%x\n", pci_id2);
-			return -ENODEV;
-		}
-
 		if (!pci_ctl_dev)
 			pci_ctl_dev = &pvt->F0->dev;
 
 		edac_dbg(1, "F0: %s\n", pci_name(pvt->F0));
 		edac_dbg(1, "F3: %s\n", pci_name(pvt->F3));
-		edac_dbg(1, "F6: %s\n", pci_name(pvt->F6));
 
 		return 0;
 	}
@@ -3352,7 +3334,6 @@ static void free_mc_sibling_devs(struct amd64_pvt *pvt)
 {
 	if (pvt->umc) {
 		pci_dev_put(pvt->F0);
-		pci_dev_put(pvt->F6);
 	} else {
 		pci_dev_put(pvt->F1);
 		pci_dev_put(pvt->F2);
@@ -4078,7 +4059,6 @@ static int hw_info_get(struct amd64_pvt *pvt)
 			return -ENOMEM;
 
 		pci_id1 = fam_type->f0_id;
-		pci_id2 = fam_type->f6_id;
 	} else {
 		pci_id1 = fam_type->f1_id;
 		pci_id2 = fam_type->f2_id;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 48f1d97e1274..2d5ea9ca3868 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -115,21 +115,13 @@
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F1 0x1581
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F2 0x1582
 #define PCI_DEVICE_ID_AMD_17H_DF_F0	0x1460
-#define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F0 0x15e8
-#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F0 0x1490
-#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F6 0x1496
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F0 0x1448
-#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F6 0x144e
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F0 0x1440
-#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
 #define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
-#define PCI_DEVICE_ID_AMD_19H_DF_F6	0x1656
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F0 0x14ad
-#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F6 0x14b3
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F0 0x166a
-#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F6 0x1670
 
 /*
  * Function 1 - Address Map
@@ -354,7 +346,7 @@ struct amd64_pvt {
 	struct low_ops *ops;
 
 	/* pci_device handles which we utilize */
-	struct pci_dev *F0, *F1, *F2, *F3, *F6;
+	struct pci_dev *F0, *F1, *F2, *F3;
 
 	u16 mc_node_id;		/* MC index of this MC node */
 	u8 fam;			/* CPU family */
@@ -501,7 +493,7 @@ struct amd64_family_flags {
 
 struct amd64_family_type {
 	const char *ctl_name;
-	u16 f0_id, f1_id, f2_id, f6_id;
+	u16 f0_id, f1_id, f2_id;
 	/* Maximum number of memory controllers per die/node. */
 	u8 max_mcs;
 	struct amd64_family_flags flags;
-- 
2.25.1

