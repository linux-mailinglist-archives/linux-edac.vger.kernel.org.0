Return-Path: <linux-edac+bounces-4665-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEF1B348CB
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E225E50C6
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCFC3090CD;
	Mon, 25 Aug 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YlmW+aE9"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA5307494;
	Mon, 25 Aug 2025 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143230; cv=fail; b=rwabQ9hZI5mXYVBZGRvKq8ZQxeKJDUl7JIapAtzQSIlKT/DMDsXGswt0dL7+4NIFdfbuhNnQjJXZypbwOvjgaMgBOWke7tEx8btIsomS9mCtAR9j4L5UVp/vvusKKUdL2m71/CXqs2tYIB6HMQZW2x+40Lv/MRkXrV/Afb/+0Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143230; c=relaxed/simple;
	bh=SURWk1bhbby8/ZpR3DmIi0Bkmq4sSs0DtH+6f2yK/zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Yih3CRm3vYFXjFfrmOqa/4oJecpyih4xU34dVfrsgl6kiaBwSgjIF5CROtfhyC4EEH0Tu5aF1sh/tW88TTxzViaXqDuIvZHFwuRqlUmWdyFSzinOR0U251OiYuQdHzkYvkbFUTw6bse4g/oTBu7UsO+tSwQlM3ppLLEEGTruoUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YlmW+aE9; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DM5SlL3hHHZajLWOGLI2rWsv2r5PzHa8/NnuwCKRzdji2lOZfJ1vUeOCNaO0ocog24wrwrrLlb95kQjF6Ih1Wi4SlGMhuJUoR/mtKp3GEZ10vYKNwCTlrrmCWlYPFO4qI4zwC1T0w9OEzCB13/Ts/7pufqovyPP/uSkb+hUcb8p8pnMQ5yIg/2rdR5iScM+OsuomcchXIBLZLHsYJOTyQLJqueG/wHSeiXu/3pLlCzG68LP2qUnxcIrDzrOUzmrvyz/GHJb4cjwddSijIC4bH2DqwAsOmFObixhCxjGkhbTMS+uM5A3vmHgXTPkBo18Sk5Qv8sEZOLLGJn1iKkMTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfK29MTsKIOfjzYlO43uU4MY8pUFjDtRwEkawNqXOIQ=;
 b=r9nyI6zDCR1Fr+L4lMH4EiqlX8IOJojmnWJa2RvXw5iWcAKe+k1cPEFvvYzUjlquF/PSr7nAjHVi6LfvoxtWWnjc2l8x6G/a6/OqULtrfeiFV9SkIPjLL0HAT8G39i2jvsxWSUZERZlnfcMGegKd/MhmPivPqJ3lmUltW6EYz9/i8kDTrxq/o+9ixZSFnl5NLRVkonTrQGwEr96KyDZbDM7+NYv4y8yvtXjpJQfm0uoMz6MBGNGWj3ZTjrVzE8NIOMhGmEso4w+TgH8STGHJoJwr2cKVerfj57s7MPbMPPfWecC4BoNB+HRY0GBg6P6JGoSua2XNOtfyAts/R1+mKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfK29MTsKIOfjzYlO43uU4MY8pUFjDtRwEkawNqXOIQ=;
 b=YlmW+aE9eDQjk1t9YHBOuspvCEyprn3AozakW0IzooEQCNvGXAyQbS2MShc8SQCgB6NWz8ujGvQVISVwHHzLuQEJsPVBOFlDWSlgHl9uEcqIvIhUfrxobwCw39iUJRfhDAD+uFPuI3T7OXr+Bix9m5N4/0wzG4bvTonhrIZn4Vg=
Received: from SN7PR04CA0060.namprd04.prod.outlook.com (2603:10b6:806:120::35)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 25 Aug
 2025 17:33:45 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::12) by SN7PR04CA0060.outlook.office365.com
 (2603:10b6:806:120::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:45 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:40 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:05 +0000
Subject: [PATCH v5 08/20] x86/mce: Define BSP-only init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-8-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b15770-bc22-4b32-20fb-08dde3fd8b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFAzMkZyVnpKcmhvQ3o3MEozMDlRZVdha3VvS29ibGt3UlIyUmF3cmhud1dP?=
 =?utf-8?B?cFREZE5DeU8xNUd4bTlZNEpKaXJOTTBrTWlGYUZBalZWOUorMzNZUTFRVXhZ?=
 =?utf-8?B?K21ZOGplamRweTdZelY5enpYVXlNQjMyci9ueGtyZzEyZ1VMd1NOQTlWdG55?=
 =?utf-8?B?aG1XZTg3L3I0bkZuVWh3eEpSNjhpQ1BYSzZQRFNYTDlDZjZVckdLS2N1ZU5W?=
 =?utf-8?B?WGp5ZzB2Y2NLa1VHSC9qSktSVG1VNEtpVkpDWm1HMmJQd05RbzBYZ2Ivcm1x?=
 =?utf-8?B?R1liRjZ6dzNOSTg5SnRxMFlUNGtGUUh1U1VpN2pLM2FnMVpWZURmMk1NclQx?=
 =?utf-8?B?WjVQdUdIdnI4OXFJN09FSDFoUjB0MURxSEFBRDNDV3R6YnhobkZqck1yWm5R?=
 =?utf-8?B?MEgvUDJ2MEZtMVhXOE4vdmJXWVBpY1MrbTM0cFJRSlJvOUxUaUtPZmF5R0xp?=
 =?utf-8?B?NlNQa1JXcEdwdEFBdElhSGdjSWZuVGlZN1d1MUdsZWc5ZWJMOTdtbnQrdk5q?=
 =?utf-8?B?VlB6NUJ0Rk8vckI3dmFEZnRuTWZocWYvMEF1QkVwTmpzUithaHlERGNPV0Fh?=
 =?utf-8?B?RUgwVTZyYldrL0FrbDAwN3QxNnVnL24rSFhzaEYzNXRsV0pzVHUzeGNnSThq?=
 =?utf-8?B?cTNsQzBXQlEvcU5NSXo4OHYvczZmS3liMDltcVVldUo1c1hvWS8yVTgxbXp5?=
 =?utf-8?B?eGZISTAyYTdUS2ZEUUtCbnRRNVhUQTA4M3Y1MFFLSGZrNVVsTlh5ZUw1bUlG?=
 =?utf-8?B?alM4b1d2cFdKa2xZMklVQUtFZVU4a2ZnMWt0bnRYVGh0eUVLTC9ZTWRvK1hp?=
 =?utf-8?B?Ulpkc09waHlZb1NMZllpM0ZUVGszd1RYb05yQk05NXU2OTdiVmlhYWN1cksw?=
 =?utf-8?B?QWt1dG1nbnlGVmNmSm03aDZHZnd4QTcyV2dCcXR4NUo1dndteEJjYmxCbmd0?=
 =?utf-8?B?TG1QR2JKbTdJNldFS0hhc2lEeEJqcUJOK1h3a041U0U2aXdMTWxNTW52YTNl?=
 =?utf-8?B?S0RQS3I3ZFJNaHpvSXZlR3dQdTBrczAyNVFtS3lMd0Q4TnkzZSszSzhBUVY2?=
 =?utf-8?B?VHlpNUVoUzFkL1dLeHhOSjBuM1ppRGRjOGZsd2Fjb3VUTk1Jd1RnTkl6TzAw?=
 =?utf-8?B?ZWpSeE1wNHdDaHdQUmJyQXMwQTBIaHhVS0ZjSE5vQVpnZ1NieDUrdHFIbllN?=
 =?utf-8?B?ZXgzZkhoKzhjOW5kMmhsa0s2cnRJQ3AreE00dXczV3JNa1hFcEFsUERkeUFX?=
 =?utf-8?B?cEYrMllxbmlNT2xteUkwT3lzWjhabGFQdy9ScUM0dXRML0VLcWRnbmNaSWd4?=
 =?utf-8?B?SzFWU2FqYSthV0NMR1YvMXpZSTcrYm9BaE83eURhb3B2SUFVem9XRFpPbjU4?=
 =?utf-8?B?bk54Um9xNzVIcUNJN2VWYVhhczNaSmhLcmZNT05OdDBCOHdMR1pBSUMwM1pl?=
 =?utf-8?B?MTVDVm5KcWtpM003aHBPQjAzdVF2RWFscEJQTTh5K0kra2JKa3NtWVdhNzdG?=
 =?utf-8?B?TktFZGtzd0dnUjBQaFdiREN6cEpsdUxkeEJCZ1grVDJFK25mODhoaWlHKzcy?=
 =?utf-8?B?NUMxTFl0a1NPMkZrdVh0UVhaSEpLZFNJT0l1TkRhQWxEbG9zYmxma1ZkMkk1?=
 =?utf-8?B?UnpBVWJoN0VlOUQ1NWRLN0pHVFc3RUpQbU5odlZFd2RCYXF0SEltQkd2b0RO?=
 =?utf-8?B?U2tyOCt3K2lkQUVYMGtNQ1lhdzBacUU2c0JwL3Z1MnEyejk4L0FJTjh6a1dH?=
 =?utf-8?B?UksvZkx4cHRwM3Z6bndjSzBMWGdlTTFTZGZYam1HMFF0QWxTZ2YvNVdGTnhr?=
 =?utf-8?B?blJKekgxWHVVUUxtaERneVU4clBIYnZJbGZIY3R6YkYxcUJ0Yk94cHU5bEtW?=
 =?utf-8?B?Y0hrWk5Rdis0V0ZLdzdPU0xGdGY1Y0lnazkvbnUzaUpzMzV0cnk2Zm1ISWNK?=
 =?utf-8?B?bXl5M3NpTGR3SXZvSEFmcEQva3pYOG41Y000eTVXYmtRZ3ZVcU1vUGM0Zm1m?=
 =?utf-8?B?NVJFWFJZbmkxN0VNVFJhVDcxQ2xPRWFYT09SMnNsVlRqK2ZsUEJHY2d1VVpz?=
 =?utf-8?Q?wt/6bR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:45.4488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b15770-bc22-4b32-20fb-08dde3fd8b06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424

Currently, MCA initialization is executed identically on each CPU as
they are brought online. However, a number of MCA initialization tasks
only need to be done once.

Define a function to collect all 'global' init tasks and call this from
the BSP only. Start with CPU features.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-11-236dd74f645f@amd.com
    
    v4->v5:
    * No change.
    
    v3->v4:
    * Change cpu_mca_init() to mca_bsp_init().
    * Drop code comment.
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/common.c   |  1 +
 arch/x86/kernel/cpu/mce/amd.c  |  3 ---
 arch/x86/kernel/cpu/mce/core.c | 28 +++++++++++++++++++++-------
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3224f3862dc8..31e3cb550fb3 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -241,12 +241,14 @@ struct cper_ia_proc_ctx;
 
 #ifdef CONFIG_X86_MCE
 int mcheck_init(void);
+void mca_bsp_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_clear(struct cpuinfo_x86 *c);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 			       u64 lapic_id);
 #else
 static inline int mcheck_init(void) { return 0; }
+static inline void mca_bsp_init(struct cpuinfo_x86 *c) {}
 static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
 static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
 static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 34a054181c4d..8bbfde05f04f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1784,6 +1784,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
 
 	detect_nopl();
+	mca_bsp_init(c);
 }
 
 void __init init_cpu_devs(void)
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c7632da8b460..25c243e87b2c 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -657,9 +657,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
-	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
-	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
-	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
 	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9cbf9e8c8060..7f2269ce5846 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1837,13 +1837,6 @@ static void __mcheck_cpu_cap_init(void)
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
@@ -2242,6 +2235,27 @@ DEFINE_IDTENTRY_RAW(exc_machine_check)
 }
 #endif
 
+void mca_bsp_init(struct cpuinfo_x86 *c)
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
+	rdmsrq(MSR_IA32_MCG_CAP, cap);
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
2.51.0


