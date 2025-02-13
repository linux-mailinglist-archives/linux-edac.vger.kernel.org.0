Return-Path: <linux-edac+bounces-3064-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA4DA34ACD
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C19188A37A
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A33724169C;
	Thu, 13 Feb 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pgtUBiWP"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761B23A9BE;
	Thu, 13 Feb 2025 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465196; cv=fail; b=TatMY4ID0t4XE5h7OJgnhpHXZbcPw8gqhevW/HYapR2R14I/a2kVY3DtL9x4YrmOoY1pGyKwRs7hS7uRQ/GVyrrksl5rX0iv4lXU3Y0cwFnXkxMboFFqFpymsRekzAS9pFnb1YzOyIB78gGhMOlaszTk17VWHn9w0lEAxZWewlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465196; c=relaxed/simple;
	bh=ZMaVJofeQCtIhbIJGCB9qyjH0gE/8f/LliKHFgEvrsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SUdK0RJL0xvEn79YmB2Z5mB8wihB72L2w8hhzOJl2AWX83lmH/1enDdDSvH2jU1CJKD/h5nuSlYuI2v5FeS4T4p7uEN9xjo8GGKAo7jRh46+RUoeBQKzUX4M7p3KMHQOVfpatW2A/pvmUe2ryvfev1OyYxsx9kYSGuFxLncWOeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pgtUBiWP; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJ7sBGEyNo2RJ6bNYgJxNgiBWgkC5PpDybkfRvUFSgDQHSsJdueyxZY7Ef5FOq2bw+9QInEMsjTlw163s3mWqocf1BB4CCEOWY5Ol4xfOhoVFnBH54rQCH/MQpnrPu9bxg6kkxPVEXzy4NiN7TjjTSVY4XjabclaNR9Dp+Zn13+QzrO0Y+xr72KLFPDTFcDT6LSdouV3XJTixyko2agtD/6MGVSbgQpuOBoFc71Trm21BmbTuqorJreGV0P2HwAWRjb4jRrFf8HMPfSVoEXDva4RjUKFRLKpqWoPAoP981DuAx3AWxkx+mzdlw76+3c0Zl2G4qbmaHmu2GMpEsIB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqroFqd9iQ8bB0UgUzi7j9rf29ZggMOjHIKYPo07e8Y=;
 b=fJyiCZlwxDtVKyFxol42Bnd7Qst4KmHtS5VTfcOa08qmsYSMiKabVUMdf34BKT5noupGB20Am5It48+tWOMFIvat+/m0vuXHTamu/w26d/Qmd674QLP17D+oYZgB1ogwYRm7Ndnk1qRHn96nOMGytSab0nC7uYYtGMhI2Z6lzVudjmq8xRgpxbzQ2Xc1YYfEhNmdCiGdLP/juWyk/T/B274eCU/qy0Wj1EUjoI7fBaOsu8fRR8mBWRbfts7LogxcgI2O0s5d8hG6j1CZT534hdaw45Qh05wMMwY0M/sNBDl8XJGupijWJhg2WL6F+JeCbAKGwGKZIf5FtHFk/KCxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqroFqd9iQ8bB0UgUzi7j9rf29ZggMOjHIKYPo07e8Y=;
 b=pgtUBiWPgMPWaKvXjmn0/3s+jGthkS1WmCQFmtIfWJMtB0T2r0xKTAGdMVk7IIV6du8AUjUjp+2fTk0dqR5G0hvGAf1Dc/7L5sHpHxeG91VdPo2hUyOe5o57VvuilLhmVpE1KCXC8jAofCQHN8d0ziGUjTpiI0HqSyFfvrI6CG4=
Received: from DM6PR11CA0011.namprd11.prod.outlook.com (2603:10b6:5:190::24)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 16:46:30 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::cb) by DM6PR11CA0011.outlook.office365.com
 (2603:10b6:5:190::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 16:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:28 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:26 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:45:56 +0000
Subject: [PATCH v2 07/16] x86/mce: Define BSP-only init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-7-3636547fe05f@amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-e27d6
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: f0079933-878e-433a-9d6c-08dd4c4df69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THo5K2M3V0Foc2U3TjdsUEUzbk9rd214Sk1YL1pyTE5xcDljN3E2NzhzcTNE?=
 =?utf-8?B?UFE2MTMvTFJ5VXQ2MEZ6MTQ0ZGo5d3RvWDF1WW9ITlJicEUvQUoweDlTT3ZB?=
 =?utf-8?B?dHJ6YnpOVWUxV2dTUllvd3V0NEhIWGc2QnZWR29BSXF5Zmx4VGtubmpiSXhM?=
 =?utf-8?B?L015bEpKWGhhdXBXTlFkK2FaV1VVdU8yc1hrL1BOK2NESTRKMWY3Um1hMzBw?=
 =?utf-8?B?dTBlcTZJT1N5L3QvSDlIV0ljZU5rcFloWHUzd2taK2RPaDVpazZIR3hDV2NU?=
 =?utf-8?B?VkxqNUJNbCtiVG5uaXMrTjdINnFxUGd4bEFKNjIrWEZJaExCMHdVMmF2V3Jh?=
 =?utf-8?B?ZXpmRXZDcTZOSXhvanVoVmN0TFRYNzEyN1FROW9iTjMvbEVTRjBNYnhRYXhK?=
 =?utf-8?B?aVd2dnR1QVlva1hwTTNrUXlqbnJYbmJHMklqM292blZ6OGFlQzZaVk5kRUZ3?=
 =?utf-8?B?TXVrdXpPMlZFbzRldk91K0hvYU1MckU4MDNjSUtKOGxxSi92QVhOZ3RPbHFK?=
 =?utf-8?B?N3h1WXcxZzFIQyt2dytJeXpqYWhCSFNRRXpZZGEwU3pxRlhVWGh1cWRZdWU1?=
 =?utf-8?B?ck5aVlE2WlY2eU8vTnluSERWY21ZQXNFVDdlVGo2b1NWcENCaG4xYTVFaWtF?=
 =?utf-8?B?Mmk4Rzg1KytQcE5XU3NVNmVoR0MzZXBoRmxDWlhLRGphUUZMQWFYTExHMXUz?=
 =?utf-8?B?T3lab0VyQ0JoaVcwMXZ5a1h0VkFVVUR1clhNYUJKZDFjNXNQbmNON2NEVXVW?=
 =?utf-8?B?bFRaZm00ZTZ3SmVJVTZHS0diaGJkWkV1UC9vNjJzZnltYjZpNzFmVTlzZnRO?=
 =?utf-8?B?MmhIQkdBT0Ruck15MVhsU2JxY3BOZ2JDa3k2amY2dmdKRW9YN0NvVy9rS3FZ?=
 =?utf-8?B?WmVYVXJlWm1BVXprd3VXMkhVdVF1R1Z4cklWRXFuMWxxcWs3cGIrYjcrNC95?=
 =?utf-8?B?S2ROK2NzM2lCT1haeG9DRmZnN09pcmZCcng3VXI0dy9pcTYxc2VBRnRNSEJV?=
 =?utf-8?B?R3hZcjlsMmRjVldIL3NqRWJHTU05MXBLbC84L0JwblhUQlpDa0I0NkxPZ2JQ?=
 =?utf-8?B?MmN4dHI0TUhYR0xjMEljRmdZRzFnSjFwVmN6ak9McHBVNXFiZko4b1ZxT2Yy?=
 =?utf-8?B?RUhxSUN4Zld2RWx2NVlXMlhJTTFSRitrTTJ2UlFhWUFVMmEzZlpCekVENnls?=
 =?utf-8?B?M2RmVXFaVWdvdkFoZnVjUnJIaTBRcWRoTzhrOFJULzhvT2RNQVNVVkx4Wmli?=
 =?utf-8?B?eDZGUUxiM2ErZHRMNUl0bWVGVlg3cG9NY3hLQlVPRG9jY2VScGVFcDdQS3ZE?=
 =?utf-8?B?N0Y4YVVWWmM0ZnU5ZlA5OENaMGU1b0dOSUtucWdNd1hSd1pkYStKUXYvZEhq?=
 =?utf-8?B?MHdPRllCQWNhQnRkY1NBaDFPVExXMWRrK3lVbml2Z3RUU3JPSWxSRWlxWGg5?=
 =?utf-8?B?Nmx2aWhYeUpvTzkwbTI1RHUwd253a3Z5T2hOdWpSdU9HSzE3M2daaUgrekVu?=
 =?utf-8?B?ckwwSWt5TWQrbjZoT0tyeE5zYW4xSFdnT1dsQlBGM3FSUjBRTHJES3AvUStz?=
 =?utf-8?B?dEh5UG1UdFBYbCtENDBsaVppSFVJWHR5Z2J0RnppM0R3UDhKNjFMWkxzU2pp?=
 =?utf-8?B?dFhlaERkTlkrUDljTmsvbjhCSlExNjUwYVN5L3BiS2x6YzRjL0FaUkVUS29n?=
 =?utf-8?B?a29RRldGNEhOMFFwUUsybkw3ZkwvOFhmOEp4WjJFVTZPNDFSeDlBcUs4dlQz?=
 =?utf-8?B?M2oxQTBjY3NlY1lmUC9CMTBhM1hoTmd4UzZpeUswclJzODErZXRWOGhtaFEz?=
 =?utf-8?B?Nm1xOGVILzFOS3VDdm01WnB2SE8ybkFzQlQvMzJyNlIyMVZpRjRqMXVCaGkr?=
 =?utf-8?B?QVJiOXdnS3ZCeWpLZHMrNXE0bEJwMHE1VzlhMXNsK01sMSsvTVU3bk42Q1R3?=
 =?utf-8?B?VThCMURxamlNNmYwUzZtakM3NWZkVEtEYURuYTlLdFNYeWFZdU84d3k1c09Y?=
 =?utf-8?Q?9gPwn1Xp4S4+r9c3TaB4ocUN5xKLxU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:28.9036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0079933-878e-433a-9d6c-08dd4c4df69c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995

Currently, MCA initialization is executed identically on each CPU as
they are brought online. However, a number of MCA initialization tasks
only need to be done once.

Define a function to collect all 'global' init tasks and call this from
the BSP only. Start with CPU features.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/Y6yQpWtlnFmL04h6@zn.tnic
    
    v1->v2:
    * New in v2.

 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/common.c   |  1 +
 arch/x86/kernel/cpu/mce/amd.c  |  3 ---
 arch/x86/kernel/cpu/mce/core.c | 29 ++++++++++++++++++++++-------
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 36ff81c1b3b1..c98387364d6c 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -241,12 +241,14 @@ struct cper_ia_proc_ctx;
 
 #ifdef CONFIG_X86_MCE
 int mcheck_init(void);
+void cpu_mca_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_clear(struct cpuinfo_x86 *c);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 			       u64 lapic_id);
 #else
 static inline int mcheck_init(void) { return 0; }
+static inline void cpu_mca_init(struct cpuinfo_x86 *c) {}
 static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
 static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
 static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 76598a93a8fa..b14e2d98b45d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1649,6 +1649,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
 
 	detect_nopl();
+	cpu_mca_init(c);
 }
 
 void __init init_cpu_devs(void)
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 302a310d0630..a4ef4ff1a7ff 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -656,9 +656,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
-	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
-	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
-	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
 	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7fbf1c8291b8..f13d3f7ca56e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1832,13 +1832,6 @@ static void __mcheck_cpu_cap_init(void)
 	this_cpu_write(mce_num_banks, b);
 
 	__mcheck_cpu_mce_banks_init();
-
-	/* Use accurate RIP reporting if available. */
-	if ((cap & MCG_EXT_P) && MCG_EXT_CNT(cap) >= 9)
-		mca_cfg.rip_msr = MSR_IA32_MCG_EIP;
-
-	if (cap & MCG_SER_P)
-		mca_cfg.ser = 1;
 }
 
 static void __mcheck_cpu_init_generic(void)
@@ -2238,6 +2231,28 @@ DEFINE_IDTENTRY_RAW(exc_machine_check)
 }
 #endif
 
+/* Called only on the boot CPU. */
+void cpu_mca_init(struct cpuinfo_x86 *c)
+{
+	u64 cap;
+
+	if (!mce_available(c))
+		return;
+
+	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
+	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
+	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
+
+	rdmsrl(MSR_IA32_MCG_CAP, cap);
+
+	/* Use accurate RIP reporting if available. */
+	if ((cap & MCG_EXT_P) && MCG_EXT_CNT(cap) >= 9)
+		mca_cfg.rip_msr = MSR_IA32_MCG_EIP;
+
+	if (cap & MCG_SER_P)
+		mca_cfg.ser = 1;
+}
+
 /*
  * Called for each booted CPU to set up machine checks.
  * Must be called with preempt off:

-- 
2.43.0


