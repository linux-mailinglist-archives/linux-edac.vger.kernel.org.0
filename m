Return-Path: <linux-edac+bounces-4667-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103C2B348D7
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D043B403B
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFFE30AAC2;
	Mon, 25 Aug 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m0lQuziM"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80793090E0;
	Mon, 25 Aug 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143232; cv=fail; b=GfjHbHD2ebFgxZnez9I7kix5sOBBKTUAyHltZJEOLFjyoslXgUSgBPsbclgg5PFbqc4HgbLFrhHBZgGD5f8llZuI2Gav/yL7ko/GePot5KW6girEGPaFinSdlEpElfln3jA4/gW19raOVdpBGMSfLk6raUFokVC6bQPBzArs474=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143232; c=relaxed/simple;
	bh=ggqh6x4rvHEOds7dkKzb66W9vx8ae/v/vWbD1sUbTuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gz8EhsDkHBa0hMsmqVIYaJl4hhQYUFUuQg/2jyJVGUqhJcaVkKkDAOIjLDpQIX4UHGqFM/Lw1qXLEYQhYGNsai9ChFi5JBIVL98S785mjntW6Q9AG31KQfyts2+IQYa66WEwIQo/esLtvd59Zg3/YxomAKbbJQB6Ce3xdUk3FT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m0lQuziM; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1NYvqNpkDeDhtGuP7N92UPxYGUjzPsypu37/NHhojxYtPlOQ54NbmQlGdWmcWzBOLFvRWkzDUvljVVTL3cuQVLagMjARUddApGL3Xt1GokxgNI4cWy/M94TMm1t+6FwHnW9x8g237zSppqeUnMJiVs3nTh8Ytb0S95FvrjQdhEbYjmwKKjlCvxKs0mIEUJ+JDKfGNNzYvo8JbwkcyU01iTW02rXyCMqovzjgWl8LsAO+NmEb9mbS7BrrNhX8UNyR6LMMPDMseHN1KzBo6fmXTkVtEBuSdKM9Xc76VbqvO+vqWTSQVgolK9viczbBURZ0P5LDcnXWta/TPToNj/qog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5xXiO3DzM8FFJ40MVcyoLFGb9B1WJMxADKeXS7uWH4=;
 b=XEmhhPpZXjmlzalsqhiF8xtJqwKKm3L+1Fo56DKzf+AAQRvg1HHmwwkpwH5fENPgfBx+l0ojHEzjsCXwjk5f1qq0d/dWZNraKEUnBnJoWiJ/Kz8wE8u8WAUdXFcaIMzaI6S7KLNxv5WCaSHF57TV60xVAFFPTU2aFT+puQrVIqjDhxmqIIULvdJMhuCyRbs1FFTOz1OVs9dQHotTxh5usZduBCzeqmvo6rbj5QkEgvNZA+dkLw9IxEslJOtJtecaJwQU1YaArsrV7HKcYjdd6QuK9xH0jM9wYwDJ00dWQkuCZQBLvnSq2YrTucJ1gXChz1/jJoM4giMIhdaIRMsJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5xXiO3DzM8FFJ40MVcyoLFGb9B1WJMxADKeXS7uWH4=;
 b=m0lQuziMf636zFaXooVEP8BCvDi3pnf1LTrwq5KJeUCPj/51Svpq8sbNlSVlujLsJ4+weK0c06O9KZAjJ2vTmA0kLuTedwPBMUkjil1uUuSi6td8XMGd8R3qFPQcfolW695gkwp/BjWBYuYwGuK7jU4S4ZIX/JyoLYvjN+JStW4=
Received: from SN7PR04CA0048.namprd04.prod.outlook.com (2603:10b6:806:120::23)
 by SA5PPF634736581.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 17:33:48 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::b8) by SN7PR04CA0048.outlook.office365.com
 (2603:10b6:806:120::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:46 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:42 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:08 +0000
Subject: [PATCH v5 11/20] x86/mce: Separate global and per-CPU quirks
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-11-865768a2eef8@amd.com>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
In-Reply-To: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, <linux-acpi@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SA5PPF634736581:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc37fd9-441e-4bf1-62c3-08dde3fd8ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUdyb04yWHNMRnd6QTUwZ253WXRmYTlVckFPamFlSjZLdFNjMHdTTHFmNXBk?=
 =?utf-8?B?K3ZpZVhEcGozUWVIWjY4OFFmdzc0MDZ4R3VUR1hjMmxKb1lvekM3SHVlUEFY?=
 =?utf-8?B?SmVMU1NvYTlRR3JTVlExL2IxK1V2NDJTbk9OM0xIUVRud1RrcldSZ3ZsbEx3?=
 =?utf-8?B?czBxVG15bUdXcVVFVFNyYWZvWE1wWEN6eVkxKzJmQ204NUtzWWRWeER3d0d0?=
 =?utf-8?B?aW53bEJrSFF3MXJESDVONkFhZ05OdFhUODJyNmNmYzExNk1ZWm93VndJZ1V1?=
 =?utf-8?B?bDBFSitVN2pkaHFsam5xcTRHbXF0eXpOQTQvQjlscSszZ3JETnhqcW93cE5O?=
 =?utf-8?B?MXlOSTRDNmZ0dGpsTC82QlkvbUM3cklZdlpWOHg1bllWdXNSWVg1Zk9YMmtr?=
 =?utf-8?B?WUEvcnkrQi9FS0tlcU9ad2xTRjgvMUl2ZStXOENraFF0Y2VUNjVjZVI3dloz?=
 =?utf-8?B?WG1KNTM0K2FHSEpwUURoWHlxMlMrMDRjWmJpZk9JcFpUdTZnMExFV2hSUXdn?=
 =?utf-8?B?d1BXd2pYdFk0MEtCLzdWY2RBK1dlNHNCWkZ6REs5bWJuRVh1NWcwMGpyU1A0?=
 =?utf-8?B?ajhGTHQ0WTA2TEx0TGZ6TzBlSzJhb2lSakVKcmJFTnhSVVZFL1lGdWtqWFFr?=
 =?utf-8?B?VHVRQ1hzc01hY1RoS2VlRHdvSTRYcWxkdStnb0I3VTBEN0ZIZTI3Rk92STlE?=
 =?utf-8?B?YjQrUnFkcTE5NlllWDdkZFNnZ2tBTklOU2l1OEV4YWtmam9CY1BLUmwrT3Ay?=
 =?utf-8?B?czhVbjZHM0lUYTV3eDd1c3lPNDZWazRCR3RYZjVJNkpWb29HdExkSHF4c3Nt?=
 =?utf-8?B?dmhaZWNHcEZWTllPc3lqbmJaTWIrN2gxeHRxZFFZb29qMTc2UEdIK21BTjl0?=
 =?utf-8?B?L2MyeENMUnJYSzczNHgzRnZqVHRqc2o4TUVtZkZkK0MvL21nL2Njd2E4S1JY?=
 =?utf-8?B?dzd6SjBaNStVQmFMU3lMc25aL29jQWJlTUticlYvZmZ1UzhJbEVRYTZ5YktW?=
 =?utf-8?B?eXBEQVhzUE5wVnNkZVFwUDNaNE54VHhEL3ZpTUZQZTgxdm9hWHIxc3VoK1Rr?=
 =?utf-8?B?VUZZOXpsdGZFZGJHU0ZZcWdKckI3NjJEY0xLU3FZK0JSR2hLcjh4bndiMnR3?=
 =?utf-8?B?ajFZTmYrOVRKdkJ0N0tHYWtWTWU4aHFZWVlWRUZIZHJmSndKOHNRZFdMeGty?=
 =?utf-8?B?UXlKdHBqam5lSlplbzJXWEFjYWh2M2NlcldrVnFmc0dwS0tISm1icEt3Umc4?=
 =?utf-8?B?NVp6MHI1VWkrMW53TXNRaEV5L0tWRXlHWlIzNjFMT3JnRDlLWWt2V2VnaEx3?=
 =?utf-8?B?R2QvRjVaNzRFMjVBajlGSUppQlcyM3lHeGVqM25TK1lQRVFGbE43QUtxUm93?=
 =?utf-8?B?UDUvSmFwNFBzdWpUcGRXcEhGcU4rbjZoMmN0Ny93dFJtNXEyazQ0MldiZndh?=
 =?utf-8?B?QnMrK2orNWVVOVNNT01HM0dHaU5PNVF3MFRzaGRudmJya3ZsRDA3NVV0aUlm?=
 =?utf-8?B?UVEyOWc2SmROU3ZTL3NSL3dJUTlNUm5xdnhRQkVkbVc4VFlHR1BnV3JYR3hT?=
 =?utf-8?B?RXE3Z1hYTWFHR0JUaS9EYlFEYU96MGVabm9CZUlyc2xzQk16WElNZG1JT2Ft?=
 =?utf-8?B?MDlrcWF5QlVEVWZvNFFzaDVVNzZFcnhkWm1EZXBVVmd5RjVBVC84cUY0NFlM?=
 =?utf-8?B?YitUTy9YOVZPUk5tNzVZc1RuRDhLdTJFMVN1djNpOUl1cXdYQ2YwTU1yZi9y?=
 =?utf-8?B?Zi8xUld0OHlldHh6Tnk5c2JxM3I4N3lobVYyZ0EvWjZJakl3WnU3bUtLMVdz?=
 =?utf-8?B?ZDZSNUZrUUV6dXhjQ0pVd29DS1Y4S2JZMDNndGNIcWhpenRqaEpnMUJzcXUw?=
 =?utf-8?B?WGl5bVdESVFzM3lFTndkZ2I1Y0Z2NUhyWVhyUW9wSEtSdkFvTytpWjRVbVBt?=
 =?utf-8?B?YW1JdUZ2RjR3UlpndFlRZEc3Q2ROb0IyRU95Zi91VkRnSlF3QVdpYXBzN2Fw?=
 =?utf-8?B?T3B2TlNqV08yZ2V2MGcyTFhpOGpKYTNxY1NubCs4U2RZblh0ZyswRXpVd202?=
 =?utf-8?B?b0ZyUjR3dGh3S08yK1h3SG9GMVY4cXlTd2hjdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:46.4804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc37fd9-441e-4bf1-62c3-08dde3fd8ba3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF634736581

Many quirks are global configuration settings and a handful apply to
each CPU.

Move the per-CPU quirks to vendor init to execute them on each online
CPU. Set the global quirks during BSP-only init so they're only executed
once and early.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-14-236dd74f645f@amd.com
    
    v4->v5:
    * Apply consistent naming to quirk functions.
    
    v3->v4:
    * Add newline in mce_amd_feature_init().
    * Remove __mcheck_cpu_apply_quirks().
    * Update code comment ref. __mcheck_cpu_apply_quirks().
    
    v2->v3:
    * Update code comment.
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c   | 24 ++++++++++++
 arch/x86/kernel/cpu/mce/core.c  | 85 +++++++++++------------------------------
 arch/x86/kernel/cpu/mce/intel.c | 18 +++++++++
 3 files changed, 65 insertions(+), 62 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index efcfce329ca7..42f5c115395b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -650,6 +650,28 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 		wrmsrq(MSR_K7_HWCR, hwcr);
 }
 
+static void amd_apply_cpu_quirks(struct cpuinfo_x86 *c)
+{
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+
+	/* This should be disabled by the BIOS, but isn't always */
+	if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
+		/*
+		 * disable GART TBL walk error reporting, which
+		 * trips off incorrectly with the IOMMU & 3ware
+		 * & Cerberus:
+		 */
+		clear_bit(10, (unsigned long *)&mce_banks[4].ctl);
+	}
+
+	/*
+	 * Various K7s with broken bank 0 around. Always disable
+	 * by default.
+	 */
+	if (c->x86 == 6 && this_cpu_read(mce_num_banks))
+		mce_banks[0].ctl = 0;
+}
+
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
@@ -657,6 +679,8 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	amd_apply_cpu_quirks(c);
+
 	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 14456f6c2f7b..21a5ea239e93 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1807,8 +1807,9 @@ static void __mcheck_cpu_mce_banks_init(void)
 		struct mce_bank *b = &mce_banks[i];
 
 		/*
-		 * Init them all, __mcheck_cpu_apply_quirks() is going to apply
-		 * the required vendor quirks before
+		 * Init them all by default.
+		 *
+		 * The required vendor quirks will be applied before
 		 * __mcheck_cpu_init_prepare_banks() does the final bank setup.
 		 */
 		b->ctl = -1ULL;
@@ -1882,20 +1883,8 @@ static void __mcheck_cpu_init_prepare_banks(void)
 	}
 }
 
-static void apply_quirks_amd(struct cpuinfo_x86 *c)
+static void amd_apply_global_quirks(struct cpuinfo_x86 *c)
 {
-	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-
-	/* This should be disabled by the BIOS, but isn't always */
-	if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
-		/*
-		 * disable GART TBL walk error reporting, which
-		 * trips off incorrectly with the IOMMU & 3ware
-		 * & Cerberus:
-		 */
-		clear_bit(10, (unsigned long *)&mce_banks[4].ctl);
-	}
-
 	if (c->x86 < 0x11 && mca_cfg.bootlog < 0) {
 		/*
 		 * Lots of broken BIOS around that don't clear them
@@ -1904,13 +1893,6 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
 		mca_cfg.bootlog = 0;
 	}
 
-	/*
-	 * Various K7s with broken bank 0 around. Always disable
-	 * by default.
-	 */
-	if (c->x86 == 6 && this_cpu_read(mce_num_banks))
-		mce_banks[0].ctl = 0;
-
 	/*
 	 * overflow_recov is supported for F15h Models 00h-0fh
 	 * even though we don't have a CPUID bit for it.
@@ -1922,25 +1904,12 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
 		mce_flags.zen_ifu_quirk = 1;
 }
 
-static void apply_quirks_intel(struct cpuinfo_x86 *c)
+static void intel_apply_global_quirks(struct cpuinfo_x86 *c)
 {
-	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-
 	/* Older CPUs (prior to family 6) don't need quirks. */
 	if (c->x86_vfm < INTEL_PENTIUM_PRO)
 		return;
 
-	/*
-	 * SDM documents that on family 6 bank 0 should not be written
-	 * because it aliases to another special BIOS controlled
-	 * register.
-	 * But it's not aliased anymore on model 0x1a+
-	 * Don't ignore bank 0 completely because there could be a
-	 * valid event later, merely don't write CTL0.
-	 */
-	if (c->x86_vfm < INTEL_NEHALEM_EP && this_cpu_read(mce_num_banks))
-		mce_banks[0].init = false;
-
 	/*
 	 * All newer Intel systems support MCE broadcasting. Enable
 	 * synchronization with a one second timeout.
@@ -1966,7 +1935,7 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
 		mce_flags.skx_repmov_quirk = 1;
 }
 
-static void apply_quirks_zhaoxin(struct cpuinfo_x86 *c)
+static void zhaoxin_apply_global_quirks(struct cpuinfo_x86 *c)
 {
 	/*
 	 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
@@ -1978,29 +1947,6 @@ static void apply_quirks_zhaoxin(struct cpuinfo_x86 *c)
 	}
 }
 
-/* Add per CPU specific workarounds here */
-static void __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
-{
-	struct mca_config *cfg = &mca_cfg;
-
-	switch (c->x86_vendor) {
-	case X86_VENDOR_AMD:
-		apply_quirks_amd(c);
-		break;
-	case X86_VENDOR_INTEL:
-		apply_quirks_intel(c);
-		break;
-	case X86_VENDOR_ZHAOXIN:
-		apply_quirks_zhaoxin(c);
-		break;
-	}
-
-	if (cfg->monarch_timeout < 0)
-		cfg->monarch_timeout = 0;
-	if (cfg->bootlog != 0)
-		cfg->panic_timeout = 30;
-}
-
 static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
 {
 	if (c->x86 != 5)
@@ -2258,6 +2204,23 @@ void mca_bsp_init(struct cpuinfo_x86 *c)
 
 	if (cap & MCG_SER_P)
 		mca_cfg.ser = 1;
+
+	switch (c->x86_vendor) {
+	case X86_VENDOR_AMD:
+		amd_apply_global_quirks(c);
+		break;
+	case X86_VENDOR_INTEL:
+		intel_apply_global_quirks(c);
+		break;
+	case X86_VENDOR_ZHAOXIN:
+		zhaoxin_apply_global_quirks(c);
+		break;
+	}
+
+	if (mca_cfg.monarch_timeout < 0)
+		mca_cfg.monarch_timeout = 0;
+	if (mca_cfg.bootlog != 0)
+		mca_cfg.panic_timeout = 30;
 }
 
 /*
@@ -2277,8 +2240,6 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	__mcheck_cpu_cap_init();
 
-	__mcheck_cpu_apply_quirks(c);
-
 	if (!mce_gen_pool_init()) {
 		mca_cfg.disabled = 1;
 		pr_emerg("Couldn't allocate MCE records pool!\n");
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 9b149b9c4109..4655223ba560 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -468,8 +468,26 @@ static void intel_imc_init(struct cpuinfo_x86 *c)
 	}
 }
 
+static void intel_apply_cpu_quirks(struct cpuinfo_x86 *c)
+{
+	/*
+	 * SDM documents that on family 6 bank 0 should not be written
+	 * because it aliases to another special BIOS controlled
+	 * register.
+	 * But it's not aliased anymore on model 0x1a+
+	 * Don't ignore bank 0 completely because there could be a
+	 * valid event later, merely don't write CTL0.
+	 *
+	 * Older CPUs (prior to family 6) can't reach this point and already
+	 * return early due to the check of __mcheck_cpu_ancient_init().
+	 */
+	if (c->x86_vfm < INTEL_NEHALEM_EP && this_cpu_read(mce_num_banks))
+		this_cpu_ptr(mce_banks_array)[0].init = false;
+}
+
 void mce_intel_feature_init(struct cpuinfo_x86 *c)
 {
+	intel_apply_cpu_quirks(c);
 	intel_init_cmci();
 	intel_init_lmce();
 	intel_imc_init(c);

-- 
2.51.0


