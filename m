Return-Path: <linux-edac+bounces-3066-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E20A34AD1
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD37175CC9
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68446245006;
	Thu, 13 Feb 2025 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UhatMGON"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC9241691;
	Thu, 13 Feb 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465198; cv=fail; b=q3qZEpj2VJqfvC0M5FELpaZEqx+eDV/7YXu3dGKpgf5e73TRBb918934P+XuDgvVesQTQlq8ikr2PlfqzJAfyYMVo5gG3UxJkdC74hPuHwAPzb1ql7qpBQGiEH58fIDB1C+n3rY3iMMey1E3eWger4CA1CQMDkGh9XVej9+Dq3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465198; c=relaxed/simple;
	bh=dwMPZR/e1oafD83IGQMxP77WYCcZlxdZ+wTfmzcmCqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=p3fVOEdhj5WpU1EikQgmIaBsFpivDEZ+G0uAfSEqRfMghfGtixDA/hZaOF71lH8AeBCKTjS/VJ0py8BwXj/PAhl09psV/Pts++ufSoSFgeHXzajRqwlpAjygqUo6qwV45iPNhnDcKC5FS+IuxpVMF278lLQO+fLtOg6xMHfAnlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UhatMGON; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akv3h1UXIp+bZB3tJB60lfRywqyLREKPVe6NJNzAd6A47BkiKA6OqM33BQicW1U5G+0Wi8Wnblp3fxfdINoiyurFJQziNiKwGON5SqbPv8qxge93Iao/Oht2kLu3OEiW9+bxRpPQNvSe3XClDarTqwTClM2EG+xr5p+pscrxuTZZ4iOIMbCdnIU9PbnmXm1WhaEoE7SdWZfwgeOFr0B9O5vV7uK+bp3zrclWkPy/v2DuVzeYiCp3g/dbr9v9NDZF6dXk2MJqoXGopXB7tJWyovcB0aib122LlXSKGCtnc9XvktrKbNTJuT/z3zpNlFZu26zJD+PKrkh/1jZTNzOUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkcHfxe1npkgEfp57BEy1TQUo+Qi91ZjVAmpdDhMg+A=;
 b=JxR6g5O7WkH/kDRcNpoZ2ZQw9ehI46ojfXJwZjCVNoGsmSWYhlIG6BiV6M2e0gXrzfYzX3h4FbAQH6TbT/umuTqf8mKJYbys3Ls02cSmkWpXAvQnJb4bYHUhrm3VG4ZNLVnoV0ykWjux8GVG7UrC2zWRFLJ6/oxODHzH2k/9tDovgc5Dtd8kNPCME6XWODnbDPsbqmCbpuCkuz6vDbsRwT1kqAuraemZX93AXeha9N+nXd4nXF4J6z6qTVZ7rgjWRZa9vPhBOSq3tb4z4QQ/yKGQ4P+QYme8qQPmlXdwMHyGoWld7AQthC4Aav3AWP+v05xnuYSkiEpqEMyNHTrrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkcHfxe1npkgEfp57BEy1TQUo+Qi91ZjVAmpdDhMg+A=;
 b=UhatMGONKoYpteCjI18xx94TshbdVOFhHuUfFBjekUGWXTKbhwJNxpLPkTX7XScIz4Dl9JOEm6eiFrg7qtaKud32M9/YaYoQoowEfaY7pLGc6UKUTGMRqZb63nyN54e3UE+98vokf1z9JTEJvClCJTC3o608cZFx/RiJUHj4sfU=
Received: from DM6PR11CA0001.namprd11.prod.outlook.com (2603:10b6:5:190::14)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Thu, 13 Feb
 2025 16:46:31 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::d8) by DM6PR11CA0001.outlook.office365.com
 (2603:10b6:5:190::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Thu,
 13 Feb 2025 16:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:31 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:28 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:45:58 +0000
Subject: [PATCH v2 09/16] x86/mce: Do 'UNKNOWN' vendor check early
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-9-3636547fe05f@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0a8560-4bbc-4baf-b497-08dd4c4df7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTNzUHE5Q3FHNzhnazdHbis1NmhDS1NkNXRTQXdNblF5U1pDVkljeTFsK2hi?=
 =?utf-8?B?elZJV2MxbHgrRC93ZjFBRXArVUhrZ1drR0F3T1A2RnN1ekpQdkJlNzlvOEpB?=
 =?utf-8?B?UTB3N1N4bG42dnNmZG5CSUFGY0k3Q1hXUmhFdmFVYk5rcEVmTU8rU3ZYTElC?=
 =?utf-8?B?SVJSNVRTcnZKUkFiZDV5bEQzcGwyUXU2S0p4RU4vVlQ0SXBxSVVYejBPMitN?=
 =?utf-8?B?Qm53czdBNHFtUzBiMkJrN2lSUDRGd2VXOHk1YnpMVVpZOWlqTUZtSFJha0dJ?=
 =?utf-8?B?WXhrWGtkUWo4WVBkZlpwTWJiMjhjVXVxdnExWUliT3BlYzdibWF4UVVYOE5i?=
 =?utf-8?B?MGdjOW1jeEttMEFBejZ0cGJ1SjZiNDYyYU5sUHp3VTJoMStGYitFckFRQ3p6?=
 =?utf-8?B?bWJqcWtmZVlaT3lHR0gzajB5NFR1Sno2VmVUbmxhcVN1SWVYdlZEY0t5SXJU?=
 =?utf-8?B?K0ttNThSZWFzMGVZTSs2L29OcEloVzExK0RmM1l5S1FlM3NUTGUyR3hiVmpy?=
 =?utf-8?B?by81QjBkdGUxekFNeGh2eWh1UXl0eVF3T3JaYW9FOW5TYThZMjJSdEhoR0RV?=
 =?utf-8?B?RlZxUGEwK2RXWXlpWkFuNXhXbDQ1SlVqaHFRdnRYSUltMEdKOEtNWUxBK09P?=
 =?utf-8?B?elNLNkVyUXQ3MnpwU2lEbzE4c0FZRkFuMndJMTZiZkQ4c2ZoN2tYUy9wZjB3?=
 =?utf-8?B?L2dFOUhHNDkyUk1RSUlqdkZ1WXZFc3lkczNWeXdibko3MmhsblFoUVN3UUwv?=
 =?utf-8?B?TkIvU0w0Yk5zbis2eUlQS2R5R3BTOWlybHlST09vN1Z2NnRkNFI2TVNMSHdh?=
 =?utf-8?B?VG9mOXp3MzA2WTNzdnRCYkVmMXd4NU1MQzl4TkxxZkNReUVRNGh1U2RZWUEz?=
 =?utf-8?B?MFdJUEVUcHJ2Uk1oaFFMdkJwSFJaTit4elBtekVrKy9YRVhtd05zbXJrcDEx?=
 =?utf-8?B?TWFXMlNBMTAybzVQakNqdjlmRXBOSzlnK2hOeDNxUFdndzN0MlJYWGtMelY0?=
 =?utf-8?B?NUs1aDE4WDRHWjVHQjVZM2syWEZTR3RYSXhHN3l1blQvYVBSOVBFc3FRUkNF?=
 =?utf-8?B?dEhBTldjU1JYY1VNUEVoaWwvdlRRdy8rTGUwV0FidnhxM0ppQ1o1NHJpRjNC?=
 =?utf-8?B?WnkvQnZwc0tvUzFHVGc4SnUvTmxTajFLLzQ3WDZrYW9VemJWY2tLSGsxMVZ0?=
 =?utf-8?B?MHVIcEM1bm42UjNMdkNtNWdHclRaUyt0V2h1Y1FiNUlIZTc2VFhWWDBjK3lP?=
 =?utf-8?B?ZjBWRDlIemlrMDg1NDNDR0lmMy9pS0tSYmwwV1VsZ3MydGJUSzRvSXJleUli?=
 =?utf-8?B?S0hSRDJSR3BZekdlVi9wUmtLazNnK1lvQjdWYzZNQXVOb1NzT3h5a0dCUC9E?=
 =?utf-8?B?OVZEYXFGZWRiL0wvTmhsd3VUa2xNWXJqd3VZQit4eCtGVWJtbkYxbVRxL2FN?=
 =?utf-8?B?K2hFQXh1b24xTGltd1g1WEthWWg5SUdod3Q0WEl3b1pKUlJsWk1ZVkVrMHoz?=
 =?utf-8?B?bDZjUlhuWnZsMExMZWZNTmJLZy9VV3R2bmV4a1M0SlVwb2tzeGNVOGovL291?=
 =?utf-8?B?ZkZIN2NLZzIvSnNXZ3N4bGhxVjY4Q2hhYm0xREd1SFF6ZlVHZnhpVnFpR1k2?=
 =?utf-8?B?aXFxMmlrM1lLaVdQTXdwbXNWbk1aNitCNU1pRnhKWlJnMHhEUmxIYWNyZXph?=
 =?utf-8?B?bnlhcDJ6Undhekd6Yjh2RGJrSkI0ajVEUHpxL0M1KzdmOVk2NkRHdGt3SU9F?=
 =?utf-8?B?ZjdHWjZZZCtZVEpQNXdrVXlvdko4SXl0VDNOamJtNUVrNGcyZlo1NXZ0NVp5?=
 =?utf-8?B?WVBWU0RmZGNsMzNsUjlVL2wvWEdKQWVvMHI4N2ZyVXNvZUh1NWFLNjJQSy9i?=
 =?utf-8?B?aHlsOTBBUXd6anBQZ1prMnlzY1o4RVAzV0NtR3NmbDFYejQrVHhQUWcrMTg1?=
 =?utf-8?B?ZnZ1TGdWd2Q4NGx4aDYweDFkYllkMndFR2gzanFLZXVJTGU5RjQwbXpyTVM4?=
 =?utf-8?Q?k0SyKnjPivwUTdqEtv62d5+BU5L3Hc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:31.1692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0a8560-4bbc-4baf-b497-08dd4c4df7f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531

The 'UNKNOWN' vendor check is handled as a quirk that is run on each
online CPU. However, all CPUs are expected to have the same vendor.

Move the 'UNKNOWN' vendor check to the BSP-only init so it is done early
and once. Remove the unnecessary return value from the quirks check.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 402d7993eb96..38db802acde4 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1974,14 +1974,11 @@ static void apply_quirks_zhaoxin(struct cpuinfo_x86 *c)
 }
 
 /* Add per CPU specific workarounds here */
-static bool __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
+static void __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 {
 	struct mca_config *cfg = &mca_cfg;
 
 	switch (c->x86_vendor) {
-	case X86_VENDOR_UNKNOWN:
-		pr_info("unknown CPU type - not enabling MCE support\n");
-		return false;
 	case X86_VENDOR_AMD:
 		apply_quirks_amd(c);
 		break;
@@ -1997,8 +1994,6 @@ static bool __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		cfg->monarch_timeout = 0;
 	if (cfg->bootlog != 0)
 		cfg->panic_timeout = 30;
-
-	return true;
 }
 
 static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
@@ -2239,6 +2234,12 @@ void cpu_mca_init(struct cpuinfo_x86 *c)
 	if (!mce_available(c))
 		return;
 
+	if (c->x86_vendor == X86_VENDOR_UNKNOWN) {
+		mca_cfg.disabled = 1;
+		pr_info("unknown CPU type - not enabling MCE support\n");
+		return;
+	}
+
 	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
 	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
 	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
@@ -2273,10 +2274,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	__mcheck_cpu_cap_init();
 
-	if (!__mcheck_cpu_apply_quirks(c)) {
-		mca_cfg.disabled = 1;
-		return;
-	}
+	__mcheck_cpu_apply_quirks(c);
 
 	if (!mce_gen_pool_init()) {
 		mca_cfg.disabled = 1;

-- 
2.43.0


