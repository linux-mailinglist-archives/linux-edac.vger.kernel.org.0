Return-Path: <linux-edac+bounces-3063-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C053A34ACC
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733081895319
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580BA24168D;
	Thu, 13 Feb 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AAUIv703"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981823A9B5;
	Thu, 13 Feb 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465196; cv=fail; b=cefKs4xZNgY5boBdNzQG9c8pEuFMsv9NvTmDRkk6TY5N1Kn/UC+RjJEocP8lx5IYPJPPSMjbGgCl6ZtnTTaoVUkF4pgL6IVPeGFIoIJmpE9EivYLY3mlR3Vj1a7Xe8LibLe9F1/nt6POD0MfzSFohhbcvfTrbQj/n0TNm4Fbsy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465196; c=relaxed/simple;
	bh=1gMCTj6IcGdC5u8SPLnwaVsq9WL56JbIv6l4neqkN3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ndbN5dY3+uZiS+a6YENsOeyLiX27Vxi/5FjQoDm0NBUjyW3L4Lvr0sDm+irDsfe5rkDc9M6paNJkYaw6BW9r06eqVi8xnTyNnT4kwYxI3CYHjaadm4uaNO9EE1CoENetVgHaI5VaVxf2g+VCzG/4buLYddTQE/Q8H4f08Aj+Ua4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AAUIv703; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yx0FPIlb273Isx6PpqlsVgQVnEjiuGVCXBh4qBqKo3oEOJz1hHTpbA7+CPemBt7VYeuh1Lwv/wweem3csH9MNDgoqUHc74duhH+qLK9xqnGf+iGT4E51fTL9rDKs+XNnuxK4GtOFnCq2kprRdCfc87j3SwrdmMLl3S1wXg7/6vABPJoNKmarCqbHQxZqtV0A5DSYNP8yPtulmYnWE+ZFVXQElNzUrQBS4xcZpn1xrul6E/jL2IDbvOQceEQArnwrW3p2HemPF4Tge3V1c+XoJmGC805tNgJw9sntbCyJyau5iCauk0rFQax5UpUcbkhmcmGRFtn+ygzktNfxBvEBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnWA2jzol4TJBg6ku9OA/4qUZhndXKKl31fScjqJlpo=;
 b=poL5NYhrLJwSZ/sCkwM0EMyYVC7XEbJtzC1DnrdOVQaeVpwn7lTJlroi3qFVKN5Z2zi/XtdY1ux4NjP5WPrICXCFZOyLfyJGd/NRXqJbBSdAmnWSp3zSfNo/b9uFl52bTQN4MGMQEMrEIv7Np5YJBL6x+aL5sReqYpfRRzdRrR6XyD5ZFqA646CQtSvxH20DdX1TdiHAQxq+Z7vGkF7/HRN32KhOuTg1jpqeL9Fk/PNPB/bAXLZJjvjiGNQpYAe54XTs21e1MDQfBmqtxQGYvRz12iUaD+OfXFGKNvLLBBvAMCIOVvqVO8+Xgl4nCjX7wid0IQ95lM3WmrWrsdrQFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnWA2jzol4TJBg6ku9OA/4qUZhndXKKl31fScjqJlpo=;
 b=AAUIv703xdRGk5W/G4yCuPkqxLvc+4L7G36AZBmZSGoSwCq61YoO+ZQarQqq/xU2emsFxa0DiOs5hqfhXgkNJiP3CpNa3L9GoH/9GdPuTRAxBjdWQo4Vvt7d0mo1zgn49kO9haPbgTOl6+qqPQFO22XBKJDkphIrOd9fnj9j6Sc=
Received: from DM6PR11CA0011.namprd11.prod.outlook.com (2603:10b6:5:190::24)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Thu, 13 Feb
 2025 16:46:31 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::cb) by DM6PR11CA0011.outlook.office365.com
 (2603:10b6:5:190::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
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
Date: Thu, 13 Feb 2025 16:45:59 +0000
Subject: [PATCH v2 10/16] x86/mce: Separate global and per-CPU quirks
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-10-3636547fe05f@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 37101b65-6e8b-4645-d8d1-08dd4c4df83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1Rram1iaENQT0lQdFl3RzkrNXpQK0lZU1cwNXZheVNQSFdtVUpMVks4a3pq?=
 =?utf-8?B?Y2t3bmV1UDVoV054RTdneVd4c3hsMXNFOUhrUW12NER3bktXUUhEVXlwYUNn?=
 =?utf-8?B?WEM2NTA5VThYK1RaalFsKzlDc3A0VmxvejdkS0pHQytaSWV1T3ZFSk1RVkh6?=
 =?utf-8?B?WEJYQ3p1ZHhRcU9VcUVDcWVrWkE5c2thbVFYRy9NV01zZ2ZnVzc1TERPaHc4?=
 =?utf-8?B?ZHh4WjR5cjJyNWt5U1l3K0FuWlV4N0gzNzJKNVNFSU55MWE3aGJ5QmhxNm56?=
 =?utf-8?B?dzJRQjQ0Rm13MU5vdUpoOURKM0VtdjFjVHZUS2g5Ukx1QmswWE43aGhzVjc4?=
 =?utf-8?B?V2Y2ZHlGSU5NUU90ZklGcFhUWDJsc3JNeVdtTmdYK1VkTlp0eFlBL3dPMllP?=
 =?utf-8?B?aTlCR0tNNTJrd1FPMzNyamlFRlo5WGs5YTRqSS9BMHRvOHNyb3dGeU10QUJ2?=
 =?utf-8?B?M003aWZJUUxnTE5YRDJ1a2VqNllJWXQ2NnAxUkM3Z1VFdjJxakdaTTljZy9J?=
 =?utf-8?B?WWZRZnc2cU9oeTdqUDZ2M2RidWF0TXcrYktrUVFCUkdnMEVKVklaeHpsTEx3?=
 =?utf-8?B?WVhSWEdic3J2WHl0SWhIL09OekFqVWordTZBUUpTOGFiZW1wYU1WcTh3QUhZ?=
 =?utf-8?B?cVlRUThNK0I3c0QxN0c5YTlxdXluMStpZ29Bd0tiWEMxRTZNMkE5SXVMdXR2?=
 =?utf-8?B?UDNuRklRZlhHb2ZmTUpQeThod2Q4YTV5SWx2YThzQ2FTcFJxRElDRDVPcHdi?=
 =?utf-8?B?aWVuR0dtbHhUT1llbElNN29NaE5oeTJuOTB2Q20xeXdCYmJZVW1xTG1pbVV2?=
 =?utf-8?B?RGwzcW9qVG1OeVN2TE5TOXgwVFdWQm1nMmVKZEdZRk5ENHpTT0xQZFQ5Wjlj?=
 =?utf-8?B?SS9tN3R5akxaaWRmYlYvaWlPanZuWFVuRnJtZ1R6MUhhblQ5TjhDMnhlNDVr?=
 =?utf-8?B?c2hubFJlaDhadSs4VTZqaFdVQ2EyZ2dWVktlWlUwUE8rT3BhMUs3b2EyeVpE?=
 =?utf-8?B?WXRkSlVxY1hia0VmWWpoZ1N3MEwvaXc5bHZNcDB5ZVZwZVZtUG1XNFA3d0N3?=
 =?utf-8?B?WTVaSGRNdDhFTFlyRy9kcFl2bWR2d2RmYzJRWU8rcWhBYy90WHBjTGdLTzQy?=
 =?utf-8?B?OEdib2dTMm9jTnI3M0gvZ2lLbUZ6TnNMa2IvdkRSSTNGQmJVUUtNZGVZQjFM?=
 =?utf-8?B?Q3JXZkM2dDlmR1MvN1c4a0RaUG4wQ0JUZy9HRTJibitTZDE5bllTZEt3VHMv?=
 =?utf-8?B?MUJVTUxNdkJNMUFTMTJZblB1U2hNOVg2Ui8vNmtkMlZ6eG5ZSmZ3NGZYNzVV?=
 =?utf-8?B?K2NYUDY1cjlMYmI4aVJJd2kxeDdvc0tGMElCNXp3N0ZnUWQrZE00eVoraVg4?=
 =?utf-8?B?K0lDck5oR3hraVJZWWhwQ05Dc3A1S09FN202RzJaUlhyREd5M0gvVWJDRGtR?=
 =?utf-8?B?MVhVWWNxR01NMyt5RERZWjM4NEtLYjVocjl5TUtlQ3d3UDFHMFNwY1k2VW9i?=
 =?utf-8?B?ZndSUElsU3Bxa2lHeC9ITUQzbThUbTBjTkdQTm1UUForais5RUlZd1ZnN0V2?=
 =?utf-8?B?cS8ydlRTUHB1ZUJzU0pjVVhsMVdtelZNUmRzUnFMdFVQSEpzay90anpNdkF5?=
 =?utf-8?B?d1g5RHU0MklmYzZDa1dVNzhZeG11dHd3bndsam9DRVFZcDZvS00wc1A5RTBS?=
 =?utf-8?B?TGZVeTVVOSszZU9jdGExbTM5ekd0TkI5c25CVXJNT2lFOEFTeTF3R0w2WXhF?=
 =?utf-8?B?cFduTjBjU3ZJcElwd0tjRXdOeVRuM0c4dzVTeVVNSUlWem9mckdPTWdtZDlP?=
 =?utf-8?B?TUZsZlQwMFN3eFczM2cweVJhYkRMdEtkSjkzMUtpZVZua2RxZ3pJVXF5eE11?=
 =?utf-8?B?M2dnZ04vaDB5TTMyVFFZQldjTk9kUjFmb25lNStzTkRtVVFYYVVTck4vcFZj?=
 =?utf-8?B?VmI2ZkU4R3B5RjFjdHZOblNPWUx2Q25hWHBZQjJQSXlsUnM1UkVON2tTS2Za?=
 =?utf-8?Q?lcjzL9z8BAbShpD0OHeO2O6hl2ZoEY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:31.6380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37101b65-6e8b-4645-d8d1-08dd4c4df83d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532

Many quirks are global configuration settings and a handful apply to
each CPU.

Move the per-CPU quirks to vendor init to execute them on each online
CPU. Set the global quirks during BSP-only init so they're only executed
once and early.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c   | 23 +++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c  | 36 ++----------------------------------
 arch/x86/kernel/cpu/mce/intel.c | 15 +++++++++++++++
 3 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index bf2b1dc5aaa9..c6510415159f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -649,6 +649,28 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 		wrmsrl(MSR_K7_HWCR, hwcr);
 }
 
+static void amd_apply_quirks(struct cpuinfo_x86 *c)
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
@@ -656,6 +678,7 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	amd_apply_quirks(c);
 	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 38db802acde4..1ea52f6259a4 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1879,18 +1879,6 @@ static void __mcheck_cpu_init_prepare_banks(void)
 
 static void apply_quirks_amd(struct cpuinfo_x86 *c)
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
@@ -1899,13 +1887,6 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
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
@@ -1919,23 +1900,10 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
 
 static void apply_quirks_intel(struct cpuinfo_x86 *c)
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
@@ -2255,6 +2223,8 @@ void cpu_mca_init(struct cpuinfo_x86 *c)
 
 	if (cap & MCG_SER_P)
 		mca_cfg.ser = 1;
+
+	__mcheck_cpu_apply_quirks(c);
 }
 
 /*
@@ -2274,8 +2244,6 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	__mcheck_cpu_cap_init();
 
-	__mcheck_cpu_apply_quirks(c);
-
 	if (!mce_gen_pool_init()) {
 		mca_cfg.disabled = 1;
 		pr_emerg("Couldn't allocate MCE records pool!\n");
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index f863df0ff42c..1a7aaee14991 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -468,8 +468,23 @@ static void intel_imc_init(struct cpuinfo_x86 *c)
 	}
 }
 
+static void intel_apply_quirks(struct cpuinfo_x86 *c)
+{
+	/*
+	 * SDM documents that on family 6 bank 0 should not be written
+	 * because it aliases to another special BIOS controlled
+	 * register.
+	 * But it's not aliased anymore on model 0x1a+
+	 * Don't ignore bank 0 completely because there could be a
+	 * valid event later, merely don't write CTL0.
+	 */
+	if (c->x86_vfm < INTEL_NEHALEM_EP && this_cpu_read(mce_num_banks))
+		this_cpu_ptr(mce_banks_array)[0].init = false;
+}
+
 void mce_intel_feature_init(struct cpuinfo_x86 *c)
 {
+	intel_apply_quirks(c);
 	intel_init_cmci();
 	intel_init_lmce();
 	intel_imc_init(c);

-- 
2.43.0


