Return-Path: <linux-edac+bounces-3550-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B42A8A208
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8E83BB982
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B284B2BCF49;
	Tue, 15 Apr 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J3BNm5CO"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781AF29C34D;
	Tue, 15 Apr 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728922; cv=fail; b=RiIZVbNkH8WC6DfY7xiVuGMONMVzM83ivp1b7rzEROyQBUmsasV6LTuniL3VtEnvWpON/gBKSJa6exoeyNycAurWfbk8/I3vJYTOcdNJ0bAjpHsWk/e6uUQFZO+nZslBxNX6heSPZaNCRNjuHx0PZwyL+6MOc2N1RiiNHqMDCrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728922; c=relaxed/simple;
	bh=CVt3WapJN88CDgwSB8XwMSt/61I4/OT3cs2YgeF7Z+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Cwy+mTB/OgkOlcBqpq3w/jw8yYxfxViUMkKRwNdXNt/+JUZsK+CrndlphhW5jjluE+F1KeLGRq11c93x3QD9G4TMq4Tlwo6vLVYMvECJFJ54igkyVkUigP2PwseC9i1091fxmutjJaD3KidYfTMBixY4Al+iCNoG/XsR8zJ4hPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J3BNm5CO; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPJjCRhg/NKbTxKkQNeDLaQN9pyYKqVI5yeXUKoadV7ukQ3ybSvVKKSa+C9xKU7eF8qsZrJKsjucT3wVkOMFMnO0H/AHmufP81SZRozQtzJYel5Ul4xS+hS2+P46XFn0sY5qKepD62bxKsbLgTNlTgawpkBcqf4CiyZiXNXUWs0+xFXDMEky4s5AmDZYH74+jD65GlGmZ5o/T8ATq9lLv2QdMYXmZK95DGQPD70UIMF00sH2+ncfAOznLlR0PxLtG6eI/xg+JgfHDeKQShKWhp96Eg9s9xT1Pj5c8H+neGTkfqIwz6Ngp0Q/rZp7NLCsdqngxt2wmCzTTCCvP1LbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXK+1I+b5oEVTGKVlVmTvvHJAWj4cwAYNGHVsLC+sn8=;
 b=sMSVMnmxFk1r9njTajha9NooWxPndQ33JCwgqdE18OPPWo+rNMfuZpubK9Byk9R2nriY3tMP7c+RzOYA/Y1K5EyznifQiy4Uo4ffCvhgamxpogzD3+fb7g0OlLOQznYqoSvcmHl1oMMy+g+r4nulBy2N4swOLfJgYoTbZp9Drn/4YG414PuqycvMAQmiCS9PSPYrlYtVusQAeZlLNm0hnHRjiQpmh8VUjN17oDFOWFJtYhEFN3Wxxyy9z0p07aBOoUOsyuS+VcGJ349WMnaj9456q0QAxyg1M+7WdIvFrfXqeVBpqcto/+AnmmNleEki/2AUTbjx2avNNkITQDUz3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXK+1I+b5oEVTGKVlVmTvvHJAWj4cwAYNGHVsLC+sn8=;
 b=J3BNm5CO5q+2oxpA2xZbSccRFlMwRTNKDMA+xH4BCMH6Ms3sX0y48nnKa/91U91Kk+kyZmwBp2uEiMXN/ivSk2YS8xOe7KOH8563LsdZ0N9QVA79STFNxcSbjSoI9OmwcMG79p9kgUBe/Hc1RNhyD59Ig+g6j9feP+PADUVW/3c=
Received: from CH0PR04CA0096.namprd04.prod.outlook.com (2603:10b6:610:75::11)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 14:55:15 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::8f) by CH0PR04CA0096.outlook.office365.com
 (2603:10b6:610:75::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 14:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:15 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:13 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:55:01 +0000
Subject: [PATCH v3 06/17] x86/mce: Remove __mcheck_cpu_init_early()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-6-8ffd9eb4aa56@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 500c4625-3f43-4a95-3dd7-08dd7c2d880c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnBqL0gvRUU4ODZ2QkRYVlZsT2M1ZnExODB2dHpmUEcyRDdYb3dlMnRuT0Jw?=
 =?utf-8?B?YktjKzZKZEtKYXZhRW9SaWlkd3pScXZTWnFLZmtKL2VBOVFXZS95RXc3OFV0?=
 =?utf-8?B?WG84SWVnck1QdFBtU1M4V05lcUJDT0cxSzloRkEzTjZ3VzZqUVVKSWNzM1Uy?=
 =?utf-8?B?SWt2VEx1SGE5QlZVVFNEZE56UnBKbkZoRWZ3RVJqYW44R3p2Wm50TGY1L3BW?=
 =?utf-8?B?aXpHZkxlV3dIeTY2dEk5MlhrVHU4MjJMZlljZDh3WWJwNGJqQUtqUCs5THhj?=
 =?utf-8?B?K2hZL1dhTHhwL3M5OTZvQmQxcFZyTGZqdm9NeU1tRGJ1bldIYmh2b0JRKzNU?=
 =?utf-8?B?QzBxZ1V5aXAyNitvaFRyTDVoaXFEcVU3Q2dRNWJ4K0xqWVFBQW9sNDRqS2Nq?=
 =?utf-8?B?V0pMTjdSUVRSdUhQSXJyR1BDQU0zRFk3UXpDcjR4MUZZbDNvenRoeTF0NVV6?=
 =?utf-8?B?UTRHc0I3Q3pGMm5JNmkxOEJMUWRBVlord1ZObFdMRlJDdVNWdGNPMU9Ua3g5?=
 =?utf-8?B?YjhER1J0c2NaSGdWUWdLVnhhWVc3Mit0OEI0YWIvNklGeTlla013SkxyNVE1?=
 =?utf-8?B?Y0dmdXU5cGJITC8wd24zb292cmZUQllsNXNBbWwzQ3orOW1WVmhMcFByY2s0?=
 =?utf-8?B?OHpMbmhqa3Bqd0hEUG05K25kcU5iQTFhaXgyTXVwaTBOWENGRkZJaURBdk5m?=
 =?utf-8?B?N29kQTJDSkpoWEFZZXc4UFZHd0dIcE5mSzd4MTNwOFRnZTF2SUlYR3pSaTdo?=
 =?utf-8?B?Wno4TmdDYzhKZi9qUXhXOFZRMnk1QnA0SGZWMWRLRlE0dk1YLzBKdnU2cnZx?=
 =?utf-8?B?TXBYZGZtNnZGeG1FR2xtRGdkRzd1ZWJBZnJONHZWbHdTSGE0VWkyMUxDY2Np?=
 =?utf-8?B?b05CYUplK1dndGVTVFp1MG0rczdVdzlMdTNBQ1lUbUt3M25ZSEUwb29ybXFH?=
 =?utf-8?B?R2hadUZ1dFROSEFLOGQwNjg1YkVHWDFBL0VRVmRXUXQ2Z0twYTVWVWhpTXR4?=
 =?utf-8?B?UWxRWDlsR2Z5UWNrK0pVcmZrdGxLVzhJMjJRSjJDaHhiVXJibWdScWE4cFVY?=
 =?utf-8?B?VFRXR0pXQ0lZTEhDUGk2Rk9RaUFmY2gwVWREZElScFI4NEhVdXB0ZGx5U2cw?=
 =?utf-8?B?N1huZG5aUmtGOEZQVUpLcm9FcHpSVE5QQkMvZmZDSGt0L05uNE9mWllsOHFV?=
 =?utf-8?B?R3ZZQURaclN5NG1kRkRCMzh6Ry8vOHNaR0NJdVljdjlZU1U5RnZwTmVVcS9t?=
 =?utf-8?B?M0tZOTFUcTVIUmJvZVNhNkhqcVZnL0h4OGdTVW9oUEZ1bHNHV1BwQ3hDN1JO?=
 =?utf-8?B?KzNiZEVBM0EvTmtmRnRDVU02OGs1NStQenB6bUhPd20xUHR4Q3FXUUwyM3Mv?=
 =?utf-8?B?NjZyVG9WYzFzMHNMbXI5amw4OEJ6ZmlKekFDdFAvdnczak03dDBvcGhFOHh3?=
 =?utf-8?B?KzJnekEycEcvY01kLytwVkxkOTllVHllN0YvSG90TE9XaVEvSkx6VXh1bWZF?=
 =?utf-8?B?VjZ4V3lrZXJuUW5EWSt4LzBpcVRiUGVjeG1ueVpwZWg5amE5VnhRR2Z3elM3?=
 =?utf-8?B?NnF2YkdvVzBXS2NiMmtoOGllS1lsaXRGWW8yS0lVOXpYTTI3Y3NROTdaeWZ3?=
 =?utf-8?B?WEMzM2NNZjcrLytDUjRMeXJVa3Q0Vzh1RTE3REdnVllMVlRjSzI1QmxrWVFT?=
 =?utf-8?B?N1FQVTBPVmxTYXZiOHVJbThVMHdwMzJ1VldaM3dTckg3d09vQ0VkUVFqblBD?=
 =?utf-8?B?S0t4T09vbDc4bXJFSWF2NkF0WGJlcnRCTzNyMGlaOXMvcWFLR0IrWkw3azBl?=
 =?utf-8?B?djFlVlJMMFlJc25hdUJxSUVjL1gyWnJJWkorQTdYb1N2ZmFYd3gzL2tjcWcv?=
 =?utf-8?B?UHNEVXM5K29udytRQTBxNDFRT0swSWZhN2NaQzRTMmd0NXNTdzU1VldYYWdh?=
 =?utf-8?B?OUlaY1NTN0ZxeFJMejM2YnN6NkxJNTRXM2NvVHoyUUd0TktFZzU4c2ZqckpQ?=
 =?utf-8?B?VzdPQmQvRktHU2VkaS9UNFVUUDhpY09Qc3hnTXBiQ0RQRVQreXFFS21kbzJo?=
 =?utf-8?B?ZGZyRHR4TlAvM1hueTBxU0JiVmF5ZnJmb0M0QT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:15.3104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 500c4625-3f43-4a95-3dd7-08dd7c2d880c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064

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
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-6-3636547fe05f@amd.com
    
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
index 8e5a07f78346..aa23139a3092 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -656,6 +656,10 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
+	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
+	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
+	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ee801f8862d8..331cd8984395 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2029,19 +2029,6 @@ static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
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
@@ -2281,10 +2268,9 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	mca_cfg.initialized = 1;
 
-	__mcheck_cpu_init_early(c);
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 	__mcheck_cpu_setup_timer();
 }
 
@@ -2450,9 +2436,9 @@ static void mce_syscore_shutdown(void)
  */
 static void mce_syscore_resume(void)
 {
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 }
 
 static struct syscore_ops mce_syscore_ops = {
@@ -2469,8 +2455,8 @@ static void mce_cpu_restart(void *data)
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


