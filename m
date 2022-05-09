Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9744352007C
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbiEIO7u (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 10:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbiEIO7t (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 10:59:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC55A195E88;
        Mon,  9 May 2022 07:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3R4FZ2B97bjBvKtcGbDN0Icr/AMiaywDDDNCaUYMnaW2LO6svVeNDDvktZDVmKVhPK5MTGVVyABYQKRCxeNPzw0wc/wfWyib0tISdqnXUd6JmP8dstaPJnYJvit7G3BNjAQkp1eDaGKF63EHFBHFaX+WKPA7c6zI6b1cQbypY36t3slCmu8msWjxg2aYbJAK4v8DYO/Wq1yJcB0bWzFPdXiX0+oFTCByGZ8sLHWpBclBS+degrULqoboLA3HMOvbC3Pv3NqaVYX7mBP0ibdGK7IY9FskKgWZaOogHA7+bwQF1v2nmg3iMrqvXr5e4PN/EvOqdEr2Qk0pp0Z0ATd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTxfBI943Xz904QZI71rENW0fo91agoh3SfdF/GnC0Q=;
 b=KUEf3JdA9Gwss6njvZjOEl4ED4E8w/R1T4ajOUc2wj8vBLH494P2npxT/It1UVXXtMLAGz3pLAftaUZ7GyHMXX9TlnuBSAQq5fbSgZ+UCypxtRXMLTYd+NpxE/tFwKnUWfBNCGInji77exO2xLiwLLIYiSeB8xDphSBZNqDTCfLDK9DLECAtY3tvFtyfo2WfUyQSojBLWs6ZZqLG0vwXOiwR6RvEHEkoe+KDqYWw3mN8CNiKIkCn68r2TwygHiCBF+U/i2yOFgLSBhKo/tHFOJvxR2RHqgZcO+Vj6eeTvaYS4LppTNfXtpIqDOZZgYp6b3I3t2LSLhA77/uX096VDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTxfBI943Xz904QZI71rENW0fo91agoh3SfdF/GnC0Q=;
 b=gOPcy9/eMM3tm49+hyqo6N0s1k8KiER498IwCv6+FT3HwasA6BJbxKZ4v3n9Rrz16wBmigaDkt9FdW9WnDfpOEOCS6X5gzdWriboH9QdyKlmC4rZbDn5So9r+3RlxXppkmX5DoonF2B5PFDq9BtD/2tGVNLYmaQn9IcdQyas1A4=
Received: from MW4PR03CA0330.namprd03.prod.outlook.com (2603:10b6:303:dd::35)
 by DM6PR12MB3500.namprd12.prod.outlook.com (2603:10b6:5:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 14:55:53 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::33) by MW4PR03CA0330.outlook.office365.com
 (2603:10b6:303:dd::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Mon, 9 May 2022 14:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:52 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:46 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 03/18] EDAC/amd64: Remove PCI Function 6
Date:   Mon, 9 May 2022 14:55:19 +0000
Message-ID: <20220509145534.44912-4-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e753c905-2856-43c5-7893-08da31cc037f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3500:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB35006CBEC5C31B4BA8A8EE6DF8C69@DM6PR12MB3500.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3n+Ls9HZDd3WAChrnpKIz6qwumMVr/bCMwnXXy8yhna60GgcXOkxMNp8BfPu8a6JLPElbQ1IUtDUElSjBLPh5pdZyfuzpLa3o2Pan24IVyH6HS++P2h1EJoVvMho9tEo6TrwT0zs5kDxkgwYEYKNgVCTfNof0dNhx14j9GEVtczaWdJJqZIV1nw01WY4FwSKtuvAkH7Um6pY06Lw9LiF0tXcQdnFHq7ICTGaEnJw2tg1zfzRVZr+qG1NWam1hM81mzWQ/EciIqh5JLuBrLoyvcyv8J4/fg9oZWr7k5qYCLoqYl9b78EONbSXrC0zTHqY2JCVaTSPmLEvJ4Xm0nn5eXl5zgiWjYs5FEyOfZfbEY2y788mMzqz9/3ihk+0ogP3HGrNoSJaqor2UdJhyyY0prtx2mVuaC/R+GsLNZBKkY6Pv6AGZklCjywOwFG2UG7wVjnRL82A1FJDuhIb17rPTsaCa+jkFOyCaijTseyqoyWSXO9SJmtLZveGr1DZGgqF1K2GlWHr42v/hAwkk2CbeG1vBoOyEThSyDKPJt2283CYYyQfpNK6rUeWuaDaEO18OFkk6iQnrPwCM9t/dZo3eOnPcbSLytg6cKpeRP5BW+2qfquX9AvgTjThRmw5wlRdb38y91cHi7BqjtTbNZYpPdEI7bgkuYdoxlmh2/Q5p4B/s8mCrCEvApPSP+5/JKjWWdgYc+gWnIhFMdPoXmkYmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(316002)(8936002)(36860700001)(110136005)(16526019)(54906003)(8676002)(356005)(4326008)(86362001)(70206006)(70586007)(44832011)(26005)(83380400001)(6666004)(40460700003)(7696005)(186003)(1076003)(2616005)(426003)(336012)(82310400005)(2906002)(47076005)(36756003)(5660300002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:52.6246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e753c905-2856-43c5-7893-08da31cc037f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/edac/amd64_edac.c | 22 +---------------------
 drivers/edac/amd64_edac.h | 10 +---------
 2 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 3ec7eb4ceb4e..b2f7c14a287c 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2911,7 +2911,6 @@ static struct amd64_family_type family_types[] = {
 	[F17_CPUS] = {
 		.ctl_name = "F17h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_DF_F6,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2921,7 +2920,6 @@ static struct amd64_family_type family_types[] = {
 	[F17_M10H_CPUS] = {
 		.ctl_name = "F17h_M10h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2931,7 +2929,6 @@ static struct amd64_family_type family_types[] = {
 	[F17_M30H_CPUS] = {
 		.ctl_name = "F17h_M30h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
 		.max_mcs = 8,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2941,7 +2938,6 @@ static struct amd64_family_type family_types[] = {
 	[F17_M60H_CPUS] = {
 		.ctl_name = "F17h_M60h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F6,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2951,7 +2947,6 @@ static struct amd64_family_type family_types[] = {
 	[F17_M70H_CPUS] = {
 		.ctl_name = "F17h_M70h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2961,7 +2956,6 @@ static struct amd64_family_type family_types[] = {
 	[F19_CPUS] = {
 		.ctl_name = "F19h",
 		.f0_id = PCI_DEVICE_ID_AMD_19H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_19H_DF_F6,
 		.max_mcs = 8,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -2971,7 +2965,6 @@ static struct amd64_family_type family_types[] = {
 	[F19_M10H_CPUS] = {
 		.ctl_name = "F19h_M10h",
 		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F6,
 		.max_mcs = 12,
 		.flags.zn_regs_v2 = 1,
 		.ops = {
@@ -2982,7 +2975,6 @@ static struct amd64_family_type family_types[] = {
 	[F19_M50H_CPUS] = {
 		.ctl_name = "F19h_M50h",
 		.f0_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F6,
 		.max_mcs = 2,
 		.ops = {
 			.early_channel_count	= f17_early_channel_count,
@@ -3295,7 +3287,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 /*
  * Use pvt->F3 which contains the F3 CPU PCI device to get the related
  * F1 (AddrMap) and F2 (Dct) devices. Return negative value on error.
- * Reserve F0 and F6 on systems with a UMC.
+ * Reserve F0 on systems with a UMC.
  */
 static int
 reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
@@ -3307,21 +3299,11 @@ reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
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
@@ -3357,7 +3339,6 @@ static void free_mc_sibling_devs(struct amd64_pvt *pvt)
 {
 	if (pvt->umc) {
 		pci_dev_put(pvt->F0);
-		pci_dev_put(pvt->F6);
 	} else {
 		pci_dev_put(pvt->F1);
 		pci_dev_put(pvt->F2);
@@ -4080,7 +4061,6 @@ static int hw_info_get(struct amd64_pvt *pvt)
 			return -ENOMEM;
 
 		pci_id1 = fam_type->f0_id;
-		pci_id2 = fam_type->f6_id;
 	} else {
 		pci_id1 = fam_type->f1_id;
 		pci_id2 = fam_type->f2_id;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 48f1d97e1274..2c7b49479aa9 100644
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

