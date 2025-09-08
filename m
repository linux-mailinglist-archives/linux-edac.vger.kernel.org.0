Return-Path: <linux-edac+bounces-4751-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7E5B493EC
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135AF3B3EBF
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6912A3112B4;
	Mon,  8 Sep 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kAxMRQjD"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116F130FF27;
	Mon,  8 Sep 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346069; cv=fail; b=eTwYSsXkBWlhbSd14LfiXlPDTy3qvuAmplY7lBhvpP7j0CFQcRG/ZyQZP0A3nolOIhmLVPGzNPAbGsCdJH/d8qoK/bKjyrPboMHCGfva6VHunSclKmy5udbPYNJWNEyDABIO4e0pLJN4BGyyjMR0feVnSRKh4wHgSciqniBiWhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346069; c=relaxed/simple;
	bh=CJ68LLCeqJQQaDulfeUwaKL1femS8OfyaY88h5T7QGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rW7I3lZsD5gxuKjbvOijC2KD9gGIjy24arKHVezx9x0h87hnOOOaS4idN2MPV1YtnQUUPvyG8ODYsEhH+vpZTNvXpu+Q/34S+H5p0eik5wjXJd1Ov9tzkP5ijJBh2+ZvTQxHYDr+Vi1v2LFXoG6HgHfwb2mwPFnsjtjNnNjg//k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kAxMRQjD; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mk44bPD+jy+5uS/DlBSF/WrMBsjqQnANODytvU8pQD7Sg+Jtlsuu079FilStYhQY1oJ69U74ALHvvaMEKxQKWdG3gx44MGORkl1Xf1nCMiH9N64AF1XTemoYGENIPW/N8OHqTkFENEs5VniTcsDOOZVfkKlH2VkMigAoaI3sH9pXBIqWuodAoxroB6s6a8yhJKKgfFaJseBW+ps5DEtvQc2f9R3y9TsHnd9WuR7oVpqza/+7qji4oLHipANjYGx66qPsq5+6SRlZDa2SxGa/bWkxku7QBN2kFkoTpqjtkyoEMxn2QwnzqNXjQm+wGUaVwUS5Jiprc64SeNThdhUPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otwxcsWABY7a7De5temDItcW1IE7xjFKZQDs75JNAVg=;
 b=Dun7hqgpQul5C8mkSySlWtHwWwr0N/j4urvOPsMytH5dRnd/i9LS+M8vOcaoQg8yt1txIjpH0gU1whjvcTkAc6MCaBChXD30470UvtXlEAYoLj8W8+YGxEtRJxLbJgTLLIz5vdSgelbyj7CA7/l07bkXzMwc3+mm0T7eWknqd/tZqRTyKPHr1CoslDZ68yvuxhaG5FlS7DrWfjRuCJY5R+zIIept6NM2JBGQtUqpq4K7T9Vz0Jfxp9kKcHBjFMQEjqnmnQIuvYyHzMPTYPNIt3xW6zlwejL3AUcTbNV9bEEL+Dp+sb8P3keI+qHFEUt5fRGDygo4sZ/SqCy2R+Ofxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otwxcsWABY7a7De5temDItcW1IE7xjFKZQDs75JNAVg=;
 b=kAxMRQjD4j4HlpSzwnZOAnNkJ99Fv0SGcolr+GENHUt5psLPZp6c5wNHh78EelnoJcM3uq1dSZiMpCweCvbB/X0U4pHEKQMOPrLYxPOwKcnUxsn/qu+6zzgtYhH1shqrJJjtkETpmxU0k0sAQVS1VoXHDt1BRSayZUC8XKWkmCY=
Received: from CH2PR17CA0023.namprd17.prod.outlook.com (2603:10b6:610:53::33)
 by IA1PR12MB8333.namprd12.prod.outlook.com (2603:10b6:208:3fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:41:00 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::56) by CH2PR17CA0023.outlook.office365.com
 (2603:10b6:610:53::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:40:59 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:40:57 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:34 +0000
Subject: [PATCH v6 05/15] x86/mce: Separate global and per-CPU quirks
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-5-eef5d6c74b9c@amd.com>
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
In-Reply-To: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, <linux-acpi@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|IA1PR12MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a4eeab-3399-465b-477f-08ddeeee1c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWk1dWQ0UkY4ZFNrdjVaa3RQbGFVWjdZb01zeDQxbENkbjh2VWVGY0Z3ZjBZ?=
 =?utf-8?B?OWMxNWRESHQxTFZEUElrQmJFUE85Um9lUm1RUmpWd2phTnoybjhyNHF3MGNh?=
 =?utf-8?B?aHc0c0kyN2d4ZlMybUwxSmVtaEVXYXdrTXRmYnpqb3R0cnM1b1BqV3d4eFZM?=
 =?utf-8?B?NXBmb0FQY2s2WjFxWEt2UE5idWZVNlcxUTEzclM1N3B2RE5GTkNwQnVSdk9D?=
 =?utf-8?B?d1BENER5Y1d1bnVnWnZybTdsa2Y5dFVnN2JoUTdOanNzMjZ6UmlZWmc5R2lL?=
 =?utf-8?B?ZlcvWm9vMmNhaWRPbmRFT0pzSFQ2MjNacjE0a1N1dEJxYTlQeVNBRlNXaGt0?=
 =?utf-8?B?SU9kNXZ1QXQ2Wm5WSGhDYStkSFRlSktyaWlucmZHSHZVcUR6anBhbnFMNHZT?=
 =?utf-8?B?UTJiV0hYQ1JBVWtxdy9JVlpqZnBiUklDekNuZFBUQUZWKzhveEo4aGVvL0pq?=
 =?utf-8?B?emE1WTVJQmExdlY0dXEwTE1MeVZFdlJoRG00bGdNN0dGcUo2N2NlTHJlRElK?=
 =?utf-8?B?UElRRXJrODdUY2g2RXBUZms3VU1OUVNCenZvNVBjUGxTV0JFb1JhaEJLNjgr?=
 =?utf-8?B?cUtoZjVjbFhzeUFlNzlNNHkwcWRkYlVkSTdERWtVZ2tVS0Q2SnZNRC9pQTlM?=
 =?utf-8?B?a0dnVm12Lzgyd3B2cml3N2dFblZBU2xFbjlqaTBpeXlBN04yN3RLd1BpSHVj?=
 =?utf-8?B?b0x6WDBwMWErTWxVaDFVeTA2TG8vM2JtenMzV0t0SlZGdjczNUNQeTRoeEFq?=
 =?utf-8?B?K1ZMVEZoa1VVc056TlZXQjI0b2hPdkJiMHNza2FRcmh5T3d2K3cxNUE5VFQ1?=
 =?utf-8?B?U3FmOU96MStId0lRcmdBVHRJcjkzeFhyeTlOT2plMGRvSVRNdXAycVU4REJH?=
 =?utf-8?B?UlNjMmk3YTVQRUZlT2U3b3VmWXNFdUdRVTZwRFo2SXJsNzZ6OUF5NDNoOEh4?=
 =?utf-8?B?aC9SS2M4NVQzR2tSajdyUVltUnVuS3lwOHQ1Q0VQQnl5dTNKYUkwRFRIUUxi?=
 =?utf-8?B?dzFMR243SGFyalVBKy9CSzRJN2NpSWlKV01sMlFncDk0VGRkcnE1dS94T2ZS?=
 =?utf-8?B?bjJ5RXF3bWlTai96SkRWRk1hRW14cnZYcEViYk1Za3Yremw5T1lvejRUaWdq?=
 =?utf-8?B?cFlqM0FRR3o0NHlOeW05TVhwaUZSUk5BTGl4V3dmdUp3WkwvZVhKTThSaUhi?=
 =?utf-8?B?UE5xY3pudkppZ29QSENEWjdaV0ZucXhuMkUzaWljZS92RnJ3OS8ySDEzeU5R?=
 =?utf-8?B?ZmJqd3Nza0tyL3RwbWxxc05IU3VTVFQ1ZHB0NVAxdklDekJmNGJPSHpHNjgy?=
 =?utf-8?B?UGdYd2hTZ2ZNZEFzVmJUTXkxak5EVVFXMlhtSXg4eUl6T3NTTUQySkh4Z0lX?=
 =?utf-8?B?N0sxbitWSE1vdzM4THkyK1BWd3JJNWJ1MDY3MXFpU2JuRml1TjV2MklFbUN3?=
 =?utf-8?B?ckJRRHkxMy9BTjIvbzVPbG5pTFc3ZFNmTDhLMmxpMEt5cGVBZy9vbUlUUjBC?=
 =?utf-8?B?dGZkOW5YSkxISEJHU1drOVd1TzJEUW05eEVwNW9MaUhmakdKdWcrcnBsSWN0?=
 =?utf-8?B?VjNQTzcrM3BSOE1QK0ZjaDNld0xxRlpSRHd0NGRxMUFVNUZLL1BtUUNoRE1S?=
 =?utf-8?B?L2MweW5WdUZrMjFFRXJYckRRWkE0TnpTQ1orODNyRlV2WmJ0QXo4WHVlRFcz?=
 =?utf-8?B?eHNRU2hIVWQyZzNDS25ycnBRUFdnVXRscjBPZlh2YVBHYUx3T25Ka2M3K1pr?=
 =?utf-8?B?ancwaVF0MElNYzBWZlB4ZS9NUFRBRGtIa0VIbVo3N0VhdXk4My9aSnRPeENp?=
 =?utf-8?B?Wm5NbE5ObGR1WFV1b1FPRkFCanhuNmdVS1NTRHQ1WnA2M204V3Znd0J1UEt0?=
 =?utf-8?B?QlVEekNoM0M2V2ExYU00QUhhcFFGZFJrb3JySkFwYXArd1ZZRm5FSEw1T2kr?=
 =?utf-8?B?RXNhTldpUUVpZFlRbXlJVTJBd09Id3FMZkZUQWkrQ0NOM1l2Ky8yNEQwT0x4?=
 =?utf-8?B?TEZZTXlORFE1RGlMTDFteUFKSEgva2ZUT0VGbzVaMS9qWmV1YWUxZkg2MGpX?=
 =?utf-8?B?enhqNnBGT3NWZHVYT0hDWDkvaTdteTliSStiUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:40:59.8473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a4eeab-3399-465b-477f-08ddeeee1c30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8333

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
    https://lore.kernel.org/r/20250825-wip-mca-updates-v5-11-865768a2eef8@amd.com
    
    v5->v6:
    * No change.
    
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
index 7345e24bf658..b8aed0ac765c 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -646,6 +646,28 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
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
@@ -653,6 +675,8 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	amd_apply_cpu_quirks(c);
+
 	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 515942cbfeb5..7fd86c8006ba 100644
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
@@ -1880,20 +1881,8 @@ static void __mcheck_cpu_init_prepare_banks(void)
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
@@ -1902,13 +1891,6 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
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
@@ -1920,25 +1902,12 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
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
@@ -1964,7 +1933,7 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
 		mce_flags.skx_repmov_quirk = 1;
 }
 
-static void apply_quirks_zhaoxin(struct cpuinfo_x86 *c)
+static void zhaoxin_apply_global_quirks(struct cpuinfo_x86 *c)
 {
 	/*
 	 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
@@ -1976,29 +1945,6 @@ static void apply_quirks_zhaoxin(struct cpuinfo_x86 *c)
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
@@ -2256,6 +2202,23 @@ void mca_bsp_init(struct cpuinfo_x86 *c)
 
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
@@ -2275,8 +2238,6 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
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


