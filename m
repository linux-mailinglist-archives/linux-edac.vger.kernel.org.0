Return-Path: <linux-edac+bounces-3546-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8995A8A1FF
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E251900AA4
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE7229C354;
	Tue, 15 Apr 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eA5dUkan"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B1829B76C;
	Tue, 15 Apr 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728920; cv=fail; b=CIKuuScJh5P22eV4c816ieOx/7e1Yl5IjkefODpN7ZbeskxdGullv5miAtzCORQn5VuZJCEckm/rbzIunMVoJzPD2kCv5RXhqPub/eJ+zxJAGJWWvAf0VRWQdH6oWRZR1qRYzAsJzchWa6uyxU8Jt4rIxhdd5TsOZ1KEjCregV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728920; c=relaxed/simple;
	bh=nzD3cn4Ky8KUHEQZIRufGaswJuH8j92ZTjXAUw+/sSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=S+lm/srNE4plO0tu3UtYDZkGe9QIxRuFSLzJWhwiYMoqTdhnfoSq5ctd7sIqSP1Zobf9miNe4cSZwftuO9+1B7cCwcJtuC9ITMfnURpQZFwO1PRj7ECcejQrH2iS47Kkqz76OKhrlm32SuOLLwfN44f95U6eo7jnq4h0PzAbjaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eA5dUkan; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7xSqhQz/zPUnjGv6s2K1mVX+MUaLh90UIacZXVl7lZ0EtbNtWItnsf59c5zPo7eQRKSCEREPFCv3TYn6/BvIOu03rvhF58R/jHqwofs7ngce9ROau0HhVsqDDRNep9RAfLHskycWoX6ELJBP+8MDERk8+rcHHD+TJ8jhdDghMxVIeVjo9EQZOtdMuODINRBZSUEy9Xhl5HR5z1RseU28U/USl0ulXt9gZv6zHS50duIA03+dlvwdZQmIWmVXtdNd+9OQgSHNO6VODt5ry9Yy8uffPP5eISLKgtPUjKMjtMhJL3VOpil8cghhvF9AlN8XVdXbdVtgIC1Qb14hr7v9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzoWJtshNcZF41X/20tFLCvjDGlEskG7g4XB8rpPP60=;
 b=CWJPnuysR+Frr4QYNJiQKR5lsSoBKOoZt1my2o9DQUGUT5xArEuihZXzbykOCMOtH/kR7X8ygGWY6271cdZONNRICjfio6+xkKd9MoV0ZEZbC1M2BpJfSeTZgsL7Ck1uR2zKfSRh+o2bH6x/vJdn661KBpcvdb2c/Ebh/xdiixKgQqEFtDKrGkz5VDpR4RAwsrG67XHps7K68TQpKrbwPAp2zOrp/d7qf4K3g/81eYq0xAFakmPLWuG3RWLIUdbBkE6fIziFkz4Ee63ygbtHSh2H4ggB8/zIj67lBMXm68Plhifud2ag4roAZ/16jNti5puAq+CzOK9WxItDj86m4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzoWJtshNcZF41X/20tFLCvjDGlEskG7g4XB8rpPP60=;
 b=eA5dUkanCHFWPPQlA/6J83Iul+UOpICLh4Kl9KW5i4lyXJD032XZDXdl/f5jEav2ixMrjFQYPLlSkoPhSpz5OJlWKB64FhiGZRs/SHDB5+Es0i5qR/TDXoGt0/VbdoBuMhebL+6FXUFuEo8xDaRjzvEbpRaT79qCMChCDWDUxNA=
Received: from CH0PR04CA0110.namprd04.prod.outlook.com (2603:10b6:610:75::25)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 14:55:16 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::4b) by CH0PR04CA0110.outlook.office365.com
 (2603:10b6:610:75::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 14:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:16 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:14 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:55:02 +0000
Subject: [PATCH v3 07/17] x86/mce: Define BSP-only init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-7-8ffd9eb4aa56@amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
In-Reply-To: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: aa52ca7e-d5ef-46d6-fd49-08dd7c2d888c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGJuQk1hT2tHWnFndzFNZUlwcFBkYW4rcGU3elhFQWV1bTNYcFRJaDRrb1Fx?=
 =?utf-8?B?bHJrRjFhVnFyYWt6SWo4SHRSMFdVM2d5SzdiRllpT0VSbXkrWFp5ZzJRMHg5?=
 =?utf-8?B?NVB2Q1FNMDNoeEtTZmxSU3FEZUw1R1EzWmhlSkt1MGN4SktMcVBPakUwNlhK?=
 =?utf-8?B?K2FTRTZOblpZbmFkNDB6bjdkNGxjRSs5VWpUL3NZRDRWSmlGblhJT0pIUTlC?=
 =?utf-8?B?VEZURXFEbm41S1JqRmxoQnMydUZ6TnpocDcrR3lDckZnM3Q4a2ZFT2xXU1M3?=
 =?utf-8?B?bFY1MTFHYXB1dTlGeHpqb1NHaVZuTDlCV2NCSVdyOVFxUGlwRGVMd3ArL21U?=
 =?utf-8?B?TnRZQlJLZTBYeDhIbzA5a01vbGtoYUpWTExHZW1oZWpCOUlacUZhU2JKQmh6?=
 =?utf-8?B?dlBsMmFsN0FnUWY0MnJTYXFnejN3bU5IZkFOM1BEQTAwR3VWMXFMbng5SmFM?=
 =?utf-8?B?YXVGaW44ZU0rUk5hQlF5SmNxeVIzQllhOTVhR2FCTFZZS3RLdWlnWG5rWDZZ?=
 =?utf-8?B?RDRLYlkxMjlTY0dyOUQ3MU1pU1Z3b3oyL25xeXY0blFJK1JFQVBtSXlodDNN?=
 =?utf-8?B?cDNFbWtucC96Y2xBbWV4MVhHUUlNcGNoUkFvMWNnZkpKQWVEVDhKdXdRanhS?=
 =?utf-8?B?YW51OWkzVndJMXBrbnhCN0hIOHRXc2dLbG5lbFE0bG1MU3A2eVBRN1ZKNEhu?=
 =?utf-8?B?cU9aNG8wTi9JM2hEL21wNnM1R3IyeUFqRkFSaXNOR3R5WjdiZnFRSTJOM0ZI?=
 =?utf-8?B?d21adVVjTUVyWmtJZXdQK2R2UXppZkJyeFhoV2lOVldEZEJVVEJKT2Z1K05O?=
 =?utf-8?B?bVpSSHNjUS9zQ2lCV2ZyODdoVEU0WkliTEZSdDByNjVBM0F2MlRyOFdHS2pT?=
 =?utf-8?B?SDZUMlZrUzlTZDV4dmhFd3ErOEZoOEJsSUpYbUZBTk5MV3U2UUNwRSs3WWsw?=
 =?utf-8?B?MjJpbU1EaXhobHRLakFtTDlZcVYwSlcvY3lmcVZwUURRWFg4TXliSGh5ZC9S?=
 =?utf-8?B?YVBJUG9UUWc1TjBDOHkzYmpVcU5RbU85Vk1uU0Z6MWdIZVh5ZjJSZW9PbktW?=
 =?utf-8?B?QktjZU10YnhBZk1TaTVTTk1rQXRMNXlrb3RnOVFXYnl2bm1ZeUk1ZzFQL3Z5?=
 =?utf-8?B?VnZPSGFIVUtZUlgvSjVBUXVHWmhXZlQ5WkJWODg4RnpLTG1LZEpWSVpsTkl1?=
 =?utf-8?B?ejVKMW1zMUNuelpSVGVjNkJwYUdHZTQrcWtiS05uRkdGb1VTZGtaL1NHZ1Ev?=
 =?utf-8?B?WG1uZWltNzN1N0loZ0N3cEQrdG5jbHUwRFg3Y1oySzAybnVWcDNta0ViSlQr?=
 =?utf-8?B?b3BuM2NYRVVkeWNaYkRLa3lFNWEyY20vZGNwY3dCaDBydC9JYTQzMHJ0MHlO?=
 =?utf-8?B?L2tiS01PeFBhQklzblRpZ0RPaDBTaWZiMW5DeFp6RW9xdmcwRmEzSUt2OFV0?=
 =?utf-8?B?RVpDOHZVZUlMdjNzV2dTT1ZDMzN0VEd5Y3J5Y2ZRYkl1TEFBTC9WWjNxclhu?=
 =?utf-8?B?bjJVLzU2Y3A4NWRsWTFPMnhLVlgvZTZ2OUFWSHphSG4yblAxOWQ2QnRNNHZU?=
 =?utf-8?B?UVBRWWhGaDVqVW8xMWhwU3I3amkrcGZNUk9jZXNBVk5iS0lvY2FCRnZFNkZp?=
 =?utf-8?B?b3RraG5aWXhUb3hlbXNGMUZkenAzMlRwSStwN2I5UENEOUx1aFpaQlhMZ2xa?=
 =?utf-8?B?YVcyUjBzbDlpTEcwQlJoaUw5bzdreGp4T3U1aVZtWlkxSkxyWG5NTTBhQzhL?=
 =?utf-8?B?Z0dlUzhPbUZiL3BYQlVEUG13ZGtmQTNlQnpHeWFnUk15OEl6UTZWaXRkZU9U?=
 =?utf-8?B?VTZhWCtTckNUQ284UWJsODdnL3NmZ2lySkUrUHBOMDcvMStGc1pYcVlnVDVC?=
 =?utf-8?B?ZjZDL1JWaTFtV3BRVUFTR21XRWQwUnB1SmtsNjl1dm95SzZTSzMvMktSSzZj?=
 =?utf-8?B?Y1BmdmZFcjNqMzl1dUZWVzBjc1c2TUVaUmpEMlBrTVFkTEFlN2ZkS3hyS2li?=
 =?utf-8?B?amQ4cVljaVh5d0xwTHkvSlczZUJkWndUQ2pabVlkZThVcHhrTGZRZHdpeGd4?=
 =?utf-8?Q?ocNBG0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:16.2167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa52ca7e-d5ef-46d6-fd49-08dd7c2d888c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416

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
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-7-3636547fe05f@amd.com
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/common.c   |  1 +
 arch/x86/kernel/cpu/mce/amd.c  |  3 ---
 arch/x86/kernel/cpu/mce/core.c | 29 ++++++++++++++++++++++-------
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3224f3862dc8..0108f69ec46a 100644
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
index 079ded4eeb86..8e3e51281f12 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1690,6 +1690,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
 
 	detect_nopl();
+	cpu_mca_init(c);
 }
 
 void __init init_cpu_devs(void)
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index aa23139a3092..206973d7dbcc 100644
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
index 331cd8984395..d0a29e22cab0 100644
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
2.49.0


