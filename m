Return-Path: <linux-edac+bounces-4224-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A04AE6866
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7634C3AD7
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F782DFA5C;
	Tue, 24 Jun 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ciU/5dCX"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C92DECD5;
	Tue, 24 Jun 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774602; cv=fail; b=Tdcp626hnaAHyYjOscai5bsLVjUy7cCjqmWe0DU/QRHpsVg2v5o44W4MFivJDGohf6aE2zap6mszFRKg3WbLODJB2IfE55rLmF9dyIhE78TIgF6TyhbvhAYBz0C1qQwtJR41g0p2DYzKdt3jpmvuS7qTQAexCI0AFYx77OBYLPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774602; c=relaxed/simple;
	bh=m6cwxCaBCZlI0RLsMszhbT/DD/s2GFpiFrsBqX1heHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=subLwTM6chpUuYdpbsQ6ADuBBTf7s9yrieJsEbZ+X3DEim41Yu3o36whrIKz6kRzdYAf5aECPg/pXF7jo5tpqs+g/SmmKgm4metFWGqdgLaHPIsYZtzbUw5GQf3mcD0uw4WaDpuedvCGCLlK8tC+lGFNTdqssetTqiDs1DpM6eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ciU/5dCX; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBeOVSDeDPD4SyL+0KH9LY8J0iu0j2meuHyRx4L+sdk+n5FeZaS3oAOVbSlxpHb4YGZpYePjMpzj+ufammyZjkCjlJ0XKkUpSMcaRc9vSmqg3wtUSUt/Gl+3vLfrVCd6J+2Z1zhPR4jYoh/ZeVaPGNZr+vyFISGNrdhs5sCZhvAShUd52RP8boz5Ccgva0HUDbsKocKV51EnIC03cfqEhA1jgQWugG6qAiX/8hyf0TrcbSF4U7CoFI/iX3P9Zk10KUVZiO1t4VGcMJqJlj5aDykZ4zjoAVGc7YPUQdJ03DI+jTnd/msejvg1VEpHQODOXmN36+ZSgxY0UaDavDnxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZhT7ZzdamwNR71vIDsJOUEaDUnfOV2gS73UPGLCBzA=;
 b=KLocGotE9j51XonFwK3REUD03qUeLUSg8csPvBAtG2nv47gRIMAmBQmLPg6o480uo0/EoztzYNUeT7LS418cqIIv61yUnmaENlmfqhUoafiAY1IdJpNukyYsp8OvCPpH0qxoVQt1qxTl9U86vwgMbysd2y4NewNemSpyafQVg5BRTOBczilnkJUwsaILdTysVpXXJ5hs9GOiWo6BFL+MVqnNH4Gsj7+FR+tENu/OTENfCIXr89/oSsot+obld8pCOzmJOc7/RAb4xVWNOQKtiH+pDZj9Fz49pmQpWzuOQMTmjZFozLpyM73EKL5s6EJAYVElXIzbD4NzjfmAK7gkAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZhT7ZzdamwNR71vIDsJOUEaDUnfOV2gS73UPGLCBzA=;
 b=ciU/5dCXDnNoAeekFyc170JdrBXJz5C7DiJ+ATORWLnsRmr62JRJbS4nwP8Ec6Y4V4ZVPxgg0HtDSFmdlUbadTE4YvPPTTpBf4Cw3aH/rdmbPWbP7R7G2qVEdfsk22kKgK+trqVX+qIXT9z+gNqNWuPhT2MHa51aKQht67siNaQ=
Received: from MW4PR03CA0211.namprd03.prod.outlook.com (2603:10b6:303:b9::6)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 24 Jun
 2025 14:16:37 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::ec) by MW4PR03CA0211.outlook.office365.com
 (2603:10b6:303:b9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 14:16:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:37 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:31 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:05 +0000
Subject: [PATCH v4 10/22] x86/mce: Remove __mcheck_cpu_init_early()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-10-236dd74f645f@amd.com>
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
In-Reply-To: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 685d50b9-6c9a-4bde-ad3e-08ddb329bb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGFyelRvK2ExdXE4dU9UNXFLcldRbnQ0a0JVWVRJTEZSaGQ3Z2xPSjBjQWVS?=
 =?utf-8?B?aXEvUG9iWHhBUkhFU09jUEFTcEQ0WmRZWjNGRjNkV2pTZUYyejdRSE9RVm02?=
 =?utf-8?B?dDhFVmlGdHlLSGZobXNsWjFQbVY5Ry9oYVZ1czRMejlKUXNjb0lBdDAwYkd5?=
 =?utf-8?B?Um0xYk9PS1FUVVlYWnFkOW55MkI5M1Q0eW1JVWh4bFVVTTk2MUFmSkREYmNC?=
 =?utf-8?B?OFZDVFRNd0t3WFdwazI5MGE3STNseTZOUzNmWWJWZUgwWVV3SUhsTk1wOXBn?=
 =?utf-8?B?NDUvc0U2WG5WWU1NTjU5YjltTzJMbDFHeEJDR3NMQkRHS1NqTFUxYjFXdGtJ?=
 =?utf-8?B?T2tuQTcvNTJJSVNpb2N3dm9vYUFKaWdWcU9YVkZwMStkcCt6TFdsc2NkVnZ5?=
 =?utf-8?B?UnNIcjR4UCtjdUpXc2ZuZ1FnODAxWTVkWG9NQnJ0T0U1M2wvcFdWdnZWSHgy?=
 =?utf-8?B?bHpCUVBqMFJuaDRRVVJvT0RyQmRRK2I2YkVwZTZZRGNtSG1ONzdtcTJGZVM1?=
 =?utf-8?B?TG41N281d00wWTVCOWpIR0grRHhLQUJ5RjExVEQzWm52N3hIanl3TGN3dkpE?=
 =?utf-8?B?M2lmMUhwTXU4dElGSU83ZVZvRTFuMGoxWXBJYWl4aCtrN0dwSHBlMGozRDJr?=
 =?utf-8?B?ampBcVd0THc2S0hrQWx1NmlRby9PTjA0RW8wZHZxU2hianpUQWc2dmM4YnI0?=
 =?utf-8?B?YkVsZTNKWXZmWGN0U3laQWJMbUY4YVJ2a2FWWStXU1lNcUk0ZGx4MXpBTENQ?=
 =?utf-8?B?dGZHTERvdnFTa2YwNkF3c3F2ZFZkOEozMTVXdWRwZDFuRTVpUlFGZFNPNGpj?=
 =?utf-8?B?VXhXRC9lUU5DMk9hTWlyVVZ6YjVITjRJK2JWZTN4dEpXMWt1eElVYVg2czVJ?=
 =?utf-8?B?MjFjWWdyVEZoamdWc0NRVkhOZFdNZE9LVmxWeVk3bVIyVXpjekJIdWhZZS9Q?=
 =?utf-8?B?dlpHSmJkb0tHSmdjbkZvMXJxS2FTenA1TEF2a3MrQVFkSHVzVnpwV0pQaEhW?=
 =?utf-8?B?TlFxZDNtN0w4SEI4SmxYeHZtOThtdFBUUHlNd0tYQ2twRWFpRDNNYnR0Wlp3?=
 =?utf-8?B?SUtPbGhLK25MUXhBV2ExVWkrWGF6cVVkS3BuVVlObzFEWHZ3MHBueDNTaXRi?=
 =?utf-8?B?MG9VT0pnQVdvc005cTZoNlpmL2dNRkpxU09YY05tdGZhMXRqWFZ6T1RxN1ll?=
 =?utf-8?B?T3M4ZHN4eVgyZndRb1ZDVHJvRTY3Z3VuWVE3eEdHRnVacmhVTHBRUHEyNEhQ?=
 =?utf-8?B?d3VNNmdIQzNVZmNTSUpHdUhORmRERzBaVlFDb3BJdy9OOFI0QldCZkx3aVpL?=
 =?utf-8?B?ZTVacVlZcjBpQVk2ckZUUlE2TWVGQ2NReENXalEwK1pLS3F2WlRiVEptYk1P?=
 =?utf-8?B?YUVEV0lXZlFWTC9GS2YwUE9qMFBKaHVDcm1WOG9OaHlSNGxjYkUrcmFYQWl1?=
 =?utf-8?B?TEZpMDIzT29KYlRwZGF4WlpXSHRuOVB2WWtmRlV3VnBUUG03YlZSYmRWeTlC?=
 =?utf-8?B?WXpsV2JlV1kwU2RleUMwMzRzOWt4VGxKOW1QQmp4cGVhSlM0L004NEphaEtT?=
 =?utf-8?B?a1Z5ZVkwN1dMektFd0FzcDRQVXRWKzZnVjNaUVIxbGxuMTUrYWJrcWZYN05L?=
 =?utf-8?B?WWorbENnMkp3ZHRHTFRmTGZtTFlLYnozQlhyT2k1MGx5N3RTQmZGZ2xMNzNI?=
 =?utf-8?B?cktBVHFZTXBIVFJNd3lSbUJpMFFOaUphYUFIanQrNXJtUk4zb2Q5QkN4UzZu?=
 =?utf-8?B?ajExWk0vdDRUMWRWTFFEODRmUjJtY3R5UmZlbzdhYlllZEFsTExnVDk0VnFa?=
 =?utf-8?B?NDlGYWd0WVZEUzF5YlozL2E3Y2U3d3NMTjEyRmlQYXNvTXJEZXNNUGI4a1o2?=
 =?utf-8?B?bGsxWWE2K1NXRHRBak4wVVlOOXFIbHc0TEZlbzZXTUNWM2J6VXArUWJ5V0Fl?=
 =?utf-8?B?QjFaVGpxd0hNc20zTzVOQkxZc3I0SUl3VTF2QkFmTVhrRGFQTUJKNWYvQ3Nw?=
 =?utf-8?B?ZmZCYnUzdTZ4RzJiY3A5VWRYOU9jbHh5MXEzbHNkaFFyRVhOR3NNZ1ZTbExI?=
 =?utf-8?B?NHh3eVNqYzRZOHJleXBucnRra0lHK01tREV4QT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:37.2342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 685d50b9-6c9a-4bde-ad3e-08ddb329bb49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307

The __mcheck_cpu_init_early() function was introduced so that some
vendor-specific features are detected before the first MCA polling event
done in __mcheck_cpu_init_generic().

Currently, __mcheck_cpu_init_early() is only used on AMD-based systems and
additional code will be needed to support various system configurations.

However, the current and future vendor-specific code should be done during
vendor init. This keeps all the vendor code in a common location and
simplifies the generic init flow.

Move all the __mcheck_cpu_init_early() code into mce_amd_feature_init().

Also, move __mcheck_cpu_init_generic() after
__mcheck_cpu_init_prepare_banks() so that MCA is enabled after the first
MCA polling event.

Additionally, this brings the MCA init flow closer to what is described
in the x86 docs.

The AMD PPRs say
  "The operating system must initialize the MCA_CONFIG registers prior to
  initialization of the MCA_CTL registers.

  The MCA_CTL registers must be initialized prior to enabling the error
  reporting banks in MCG_CTL".

However, the Intel SDM "Machine-Check Initialization Pseudocode" says
MCG_CTL first then MCi_CTL.

But both agree that CR4.MCE should be set last.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-6-8ffd9eb4aa56@amd.com
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Update commit message.
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2, but based on old patch (see link).
    * Changed cpu_has() to cpu_feature_enabled().

 arch/x86/kernel/cpu/mce/amd.c  |  4 ++++
 arch/x86/kernel/cpu/mce/core.c | 20 +++-----------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5d351ec863cd..292109e46a94 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -655,6 +655,10 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
+	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
+	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
+	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 486cddefaa7a..ebe3e98f7606 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2034,19 +2034,6 @@ static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
 	return false;
 }
 
-/*
- * Init basic CPU features needed for early decoding of MCEs.
- */
-static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
-{
-	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) {
-		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
-		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
-		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
-		mce_flags.amd_threshold	 = 1;
-	}
-}
-
 static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
 {
 	struct mca_config *cfg = &mca_cfg;
@@ -2286,10 +2273,9 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	mca_cfg.initialized = 1;
 
-	__mcheck_cpu_init_early(c);
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 	__mcheck_cpu_setup_timer();
 }
 
@@ -2455,9 +2441,9 @@ static void mce_syscore_shutdown(void)
  */
 static void mce_syscore_resume(void)
 {
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 }
 
 static struct syscore_ops mce_syscore_ops = {
@@ -2474,8 +2460,8 @@ static void mce_cpu_restart(void *data)
 {
 	if (!mce_available(raw_cpu_ptr(&cpu_info)))
 		return;
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_timer();
 }
 

-- 
2.49.0


