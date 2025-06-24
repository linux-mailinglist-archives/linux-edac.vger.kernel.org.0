Return-Path: <linux-edac+bounces-4228-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC7EAE6884
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693CF6A1A9C
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752942E11CE;
	Tue, 24 Jun 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w/l/mBHS"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08EF2DFF25;
	Tue, 24 Jun 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774605; cv=fail; b=KOC3kpJU6QwOd/p7DLUF2EHQppaWw5US48bK2ubymKs3SkuBuYcvr/fl51z/RK8RXHM8gmRkkPQu5hdl8JtkG1XhdF9As56QyuNfH1xbTeRVKn+CIJfGYC6FDVEhd8QPjgWPgmF2kWky3MAkPErrZpSivGdLVe6T86f/0e2GNfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774605; c=relaxed/simple;
	bh=vPEQSSZrbPIEQ+3ZDYXQFGxEcbi0TwPXrNYJBi9QTBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rZJwBjoTPgt09DX0xwTAvq3HlLDJUN4BTPPZH7c8PHid2O9oEEvu4OmbbdpZdJNGsRBanETt1fhyCeq86oMvAq8VXYwwryFzscMnv9v7eZ5BT7H4l6iZBhnicAOtR7P+150J71dCtl9PC+D7s7xnGS38oZEcKlIcFEwJzEA7g1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w/l/mBHS; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0h0TTGh89EROFea9H+1sSn6V4dLXUvg21LlhryG4xUpglmUfOKEZm6OsvQBBoOT3x8R07ooORF4l5ME9RHE8Tk9K2Scn9G0fImsaOg7JdmLFc//DpRgDQwmjCAHXRmWGI65xYQGbrkYHUYrEXcTfAMiVDX8ToCp2jL6fRAHoS/xWwDlGvu7Wn9QZbHzVlXEha2fxVc3yvpbm1JkeEqZB7fBzKAmcDR4qe7nqygSz5SwgIZdBiNT/GIee4lnr8mOjlyRiAR3m9KMgG2u9D10tVmIegDsbHQRRLc3JXI3lMP3veSaztjhsa2g9HueOuZXJw5E84YREEIwScBM/8vFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP336B6mS4TQoArtsB77Dvuqac1/RA4b/+i+j1TYmhU=;
 b=mLz2gcoE/WW9MgC+cFPLlxqMsGqCiDRDkm2T2wkLehADosnWWJr7F04qKMKM4Ar5Vb7hi4ek9G3jdSTWiH+hU6UZXQfk7pGkk2zMjJUKyU90OheF9DXuefw27gbjeeOPtRRjEfE70BAofUmxlxIsrb3WhyEpD/6InEl2VhuzK59IBOjz9uvJyOe+CemBVykJENqo6sOrgaOq9hAPu5sxw8QcrXfJjMJ/+wdPGzyVR1kOd8Hy8Bd/b2A2dDBI4Uu6R/CQy2s67MRyyVkwC5QelcunKc5qbMkE7Q0RZhNiIo54hRaKN7K86dN/80/AvYmRvV1M0IcOsEm6YECxewMtjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP336B6mS4TQoArtsB77Dvuqac1/RA4b/+i+j1TYmhU=;
 b=w/l/mBHSNuWAyqyTUwj8pm8/dva5sXuUjL/SCntldyf1E/079k5/+YYIY/LWYzfACRFhj+QOM/IURNV192AU56ktWSAVXj9RoSCUBrytosZ7Prh9ohtrWGSKD2eCWdhi6hTQu22FxZ+7cFMZ8wymW69pVYTVJ6wDRiXgsk9U1K4=
Received: from BYAPR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:74::19)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Tue, 24 Jun
 2025 14:16:38 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::2a) by BYAPR05CA0042.outlook.office365.com
 (2603:10b6:a03:74::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 14:16:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:37 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:31 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:06 +0000
Subject: [PATCH v4 11/22] x86/mce: Define BSP-only init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-11-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: db46ff50-5b1d-40bb-77ce-08ddb329bb75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1Q3NWk4RDFNSUVtNGdJeU15LzJhSVdFK0lpeVVudjZCN1RlTG0weDIrdUJV?=
 =?utf-8?B?MkdBc3Q4cm9HeXo3L1R3b0E1T1FaV1BaRVpxd3dRVUhDaHZ3UkxLL2Rud01F?=
 =?utf-8?B?UjVFbVhGTmw4ZnVsRzJUZXFYeXNaZENPSWpFbkV6bVB6aGxBUHh5NGh6QTA3?=
 =?utf-8?B?aytzcXhhdFQxR1ljMkFGSGJTQ3g0TkFWV0RMR052eDVVbTB5OFFaMmVpblll?=
 =?utf-8?B?UHpqeUFFeERVL1Q5czdkTDk3RWZIOTY3bVpHTGJ1SEZxRGtIdVN1TmNOdDFD?=
 =?utf-8?B?dDh6ZGF2dG04N1ZWd21FWFdDY05ZeS9pS1RQWDVBYVFSS093UHNhNHJ4aHIy?=
 =?utf-8?B?citVQ3JnYUVndlp5emtpYkNNaS9SNS9Da1E4UGFJc2R1R2JqUnF3RHhzRFEy?=
 =?utf-8?B?dUptQTZuOUkyUEVKd0FXTFNwNjJDdmJab0lFdE9iUHRTdGRrb1lRcGM1WHRw?=
 =?utf-8?B?NC9WTFFzQjJUU2N0aW96VHNxTHRTaWZ3b2ZPL2ZMYUUxM1RJM0xHK3ZNYXp2?=
 =?utf-8?B?ZzZsNXJaSVFLOVF1ZXJ0Tmd0aWxYcFIvQ1pIOFNnREdSbFZMTjFEQUhhNlNo?=
 =?utf-8?B?WVg2RXpTWkFSbVlrcTd1eVhyR1RtUFV5VGc0ZTZ1M09xTFUyOXhKd3dMTmMv?=
 =?utf-8?B?S25leVRUTzRVbWUxWkZBNHRxZHUxVXB6VHZMYWRMYU1xMGlsUFFIbUcvYmNy?=
 =?utf-8?B?Z0d0bVh6ZlFZYzRPRkdveFZhZnBKcXZjOHpPa0JLNThNVXQwV3FPejMwRDI0?=
 =?utf-8?B?TnlIb3VOM08rWTJoZmlSczNVK3M3SjlkLzBjWmw2Njc0WiswdTBtQzVYWWpF?=
 =?utf-8?B?VXI2aUV6L2hXZlkrOUx5bHRTS3ltSGxSU3dsSEloSDlXOUxQYXB5WWJ1R2ti?=
 =?utf-8?B?UnNwS3dVa0xSTDdHa0tPZEZ5UDNEWUkzYVJqZGJibEFGT3U4MFJMaFNFVnpD?=
 =?utf-8?B?YkVEZzVGZFFVMHUyT3NvSHpsb2tlNXkwRVBYVGdnblR6ZlZwQk8ydi8zNEg2?=
 =?utf-8?B?c3dybE5VcWIwT0t3MXNSOFJ6S3NHT2l3R1VEVVdmbXNUbVcvbmZqUktUSEd3?=
 =?utf-8?B?T0VHcm1PQUdQaUI1TjlKSWhGWmtRWHFkRVFULytCUWN2aFFSOWFYLzgxUlhm?=
 =?utf-8?B?WDljWjdzbUFHUTdFME1zSnRtdFhwRTloMzJFK29zNEhKeFA0VzNGRXRncitv?=
 =?utf-8?B?K1JXMlh1OWFvY3lKQ2diR3hXSVJGNXdmQ0c0QmlBaWdtV0krTnAvVWorZHZj?=
 =?utf-8?B?dFVaQjB1TXhpQkg5MjV6ektzN0h1K1NidVdoK3BSdlVQbE4wTWJCMlJNUE5s?=
 =?utf-8?B?MVNZMHdMS3hvN2JnaXBxaGpLdURGbXhWcFJ6SWhGUFBuaHZrTTlwcU5aOWhJ?=
 =?utf-8?B?dDhDdjVwQjdtS0x0cEVKRTRLU1lkWC9LOHkwbGFiWEJ5ZTNqMTNGdUpNQUF3?=
 =?utf-8?B?M05oQ2xQOERaYmxWMkdYL0hCK1ZaZWEzaHQxdUxmRVlHV3Z3THhKNW8wRGpG?=
 =?utf-8?B?UGFVbzh4OWJ6UWNNNnUwbm8zaG9NdHZLbE14UGRMYW9BUFEzQ2tHMTUvWDFq?=
 =?utf-8?B?OFJRQmVQM1IrUjViZkQrYzQxNVBvOVBHc1k5RFgySWM2VjBMSVlBQ0wyNWI4?=
 =?utf-8?B?dFU5ZktSY29aM3I1cnBoWGlXallzQmFMK2dCOEt2UDQvQ0dLRUJaakk2L3NT?=
 =?utf-8?B?dXI2eElmVTZlKzlvdDB5eCsvLzlHU0Zrc1BGSjVidmpuNjBLeFY4b2FBYUph?=
 =?utf-8?B?b1hDTlFWaVludXBQSTR6dHNSYzJPaDIwVXBDeHpRTkZpVk9tc3FGT1kvbm9J?=
 =?utf-8?B?UXdGS1B6aEpKT3RmTDBoUjRrRGwyajBzb1NrZGFmWDZSQXduS1U1cTBpTDgv?=
 =?utf-8?B?dGpPZnUvU3UxZjlrT1ZUTHVHc1ByV0dIUWNtU0RiWnFVU3gxVU05RE9uMDMv?=
 =?utf-8?B?TW4xL3psTmhuVFRNaC9QZ0wvYW9EUE1XRVU5blVLUnFYaEpCUjh2LzFiT1k5?=
 =?utf-8?B?T0lhblhBdDFueGo5SnNwQWJxSEtoUXZTWVg1cWQ3bmRPTUkzN29wYnlRd1dL?=
 =?utf-8?Q?9A0FXZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:37.5193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db46ff50-5b1d-40bb-77ce-08ddb329bb75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583

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
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-7-8ffd9eb4aa56@amd.com
    
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
index 8feb8fd2957a..8a00faa1042a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1771,6 +1771,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
 
 	detect_nopl();
+	mca_bsp_init(c);
 }
 
 void __init init_cpu_devs(void)
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 292109e46a94..25a24d0b9cf9 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -655,9 +655,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
-	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
-	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
-	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
 	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ebe3e98f7606..c55462e6af1c 100644
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
@@ -2243,6 +2236,27 @@ DEFINE_IDTENTRY_RAW(exc_machine_check)
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
2.49.0


