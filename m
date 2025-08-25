Return-Path: <linux-edac+bounces-4668-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9C7B348DA
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6D73ABAB3
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B6C30DEBC;
	Mon, 25 Aug 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zFHSa4dX"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E13093A7;
	Mon, 25 Aug 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143233; cv=fail; b=mcIg9lMF77LLwNlLq3CSPBfPXoL7g7kzqBdeXalNDQ6dtFHAwHrz+y1KO3pCjTFJLZOr4iyYqM376wqHZUV1lUydEzvDahRt+bupX/QYxkjwXv7TvaLDwx3rD8xmo/hzJOGpeheo+lz3R9++WfcCfAayv+hAyWjkTjRukK2bNqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143233; c=relaxed/simple;
	bh=GCZyg5EZx95O/q1qpCVtkzwRjZIIqEu6oFVSFGyAKdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hv+82BhjnJDPfCmzZhDMzN7fkB/jo6z/Bt5EnO7LjIAjSnZQIpJvBbwWPrAgUqNnvP2IKGbYgGG8atfzxsbczrJjBrkjogdy6V+Dl9FfDzax2wndH271HLyRxApOkM3i9xWMmV8RaArPvZzIioSM1pq8c5HnhMj2WPuXsVRYKkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zFHSa4dX; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYSIzvB1H1UpUBUnboFASPzOirGNai/DZ9QpyCsPAcdgPywH7Rwe3d2vyYlMA99LCvo31Uk7GI8OQXvo1qb9rOZk4E2Zj3Zebm9F1oycc+kxoE8XIHEfYYnfXQNgTbT+wZDXp+lNhipappcvLwbB7TNb85i1tKjrNEcD/iMpktpTYZqLi3ArDGjCOPimLwkxp2K5fNpAxs/k3D/kXN4NK/MIhKJ+YZPfi32QOv+kC8BeOK/TcUR1VOPhbtSVLx4Q0KO1vdGpoKDFT976O0KlUFikdu3rR37olTal6DNS6yRAiudQpe5AbIixdpyTm2JO7NGs2QGqI1p9WO14XDirOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57bxtnJR6Ul5tGmldAwGIQPZfCzpv0fYkhXfY7qkXjE=;
 b=gNX2uopSe4bL970JIZiTmbJj3lIhdcUOJzA8XnI80ZsDS97/iIizfe9VxBjo+/K+H3H+L5+zUkiiFr9w3Jxg2HC2Ng7J+2q4+qvyIWihsf3SiJFU+edoEt9mfM9oOY96GuETRIrhG80YY5aaaK7M8aor5PvFymhbvNPlyRgI0hOYGt8wtpGe1UaXGsL2g7srg2C9eyaYMqW9Scxbssxj+w43fVke/cdRtz8AJk3NWR8tYLTLPlxVVXhmw/0OFuc3OKF/Hgayr6a82L1bWH8F59698UatepRymYkqNFaH1iv8NxS7vj56ElS2y7RUxjgbaD0n3qg71+FHFKlyyJjMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57bxtnJR6Ul5tGmldAwGIQPZfCzpv0fYkhXfY7qkXjE=;
 b=zFHSa4dXy4+eLTpcacciV7IxcgMPWauI+9cZO75vk2rrNBxCv36PgntwFdWdqI9Bf8fQqkenubKEOhPYlKc0HrIPZcvjeBDBdOuFACLy1oixN6/SQriGqu4TCdu+iyWldUQvHMrrOFSknG3X74iRct8Anh+CxExjI8T+ZAyl6uI=
Received: from SN7PR04CA0048.namprd04.prod.outlook.com (2603:10b6:806:120::23)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 17:33:48 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::f3) by SN7PR04CA0048.outlook.office365.com
 (2603:10b6:806:120::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:48 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:43 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:10 +0000
Subject: [PATCH v5 13/20] x86/mce: Unify AMD THR handler with MCA Polling
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-13-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 376e4ed9-b34c-40f1-d381-08dde3fd8cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVQwTUl2K1ZOT1hNVzkzUitybVJ4bm91aGVzV2NXa0pCTkpuQ1RaTEZPSk9T?=
 =?utf-8?B?enN4ZEdSaDJKRkJRZkVzS1NSM2VuNnhKRVFpL09NdnZYMXhFa1BGS3lDQ1g3?=
 =?utf-8?B?dnRyVEV1UWQyRDZmcTRYY1ZnczhpSW1qbWFWWVo0QVRZdmQzaHFXNE13WmFz?=
 =?utf-8?B?anBUR21zNW4xNFlEc2RhK0JwRkZ3c2tlK2ZCMXhSS0syRkRHNm5FV2ppMW5v?=
 =?utf-8?B?UTI3QVNyYXlMUVY3Z09pSEdKb0ZIWE96WndiR1JWTE5sdG55UmRsR1Zja3Fa?=
 =?utf-8?B?cXNjY3JhUmRaZHBSclZLTnZISDh4TXovZ2lkK3VuQjJHZElYeTdsYVdZaXlm?=
 =?utf-8?B?NWNYaDRhcHlwdmgzN0x4cmRoSGlqTmZCU0hjeC9PdWJXdVZGSGZ3QWd5bTQ3?=
 =?utf-8?B?cWdtclIyVHRyQzFCb1U3WTJQd1NhdkdpU05QMkZGSmdjbkgvYnB4Mm9DUTFX?=
 =?utf-8?B?SUFtNXd0YU1TRU9pcERsUzNLMTdIN3dYMzNZTWp0QThqc2tuWVhidSszTTN5?=
 =?utf-8?B?N1lvS05zL3JtTkVmYTdOWEVPd2FwMTFsaHdTZTVKcHFJbzFXbFJsOXVVZVdo?=
 =?utf-8?B?SVVpZ2Rmd05vdHRpOURCMU1kL3hoMUptMWpMREdvbitaRWhZZ3FWc3ZkYmdw?=
 =?utf-8?B?SGN6b2g0SG9COHg0WkhXUU5OR0tCZDFJL0k0REdETU1kNEh0MWRmbXR2eFEv?=
 =?utf-8?B?MzdKU0JoN0hLU0xzUlZoS0JGL0w0U0M4MDRzZmpTWmFVQ0ZPZ3J0NEZqQzdw?=
 =?utf-8?B?NEc4dDdBYWlPMjNxMkJyeTlXNzZ0STlWbUpza3NwMm5nWmIrZTE0RGRvb2lh?=
 =?utf-8?B?ajYxS0IwQkZHamE4T1NKSnlxdHJzZEJtT1l5ZXFsTjI5RStLS09XMnNjSVhy?=
 =?utf-8?B?cTlNUUcvbXlLQ2FrcWgzeDJoemZWdE1WT1VHT1B1NXhuUnJiVzdwRXN6ak44?=
 =?utf-8?B?Z2YvWW5kbnBGeWRwTkQ4dVJ6d1J3UmVkTWpsWnhVbzQzTWFsU2lQdFkxVUZF?=
 =?utf-8?B?bzZSbFFIMGMybjU1cFFJRVlBNkpTaHNhZ2U5ZERQNGZvU2xCQkRaT0pkSklS?=
 =?utf-8?B?UmJnL0hIUHJKVmlCR1RwbDBHT0JWcG1tV2RMY0c0cFNMVEFUc3lNZzlhTzAv?=
 =?utf-8?B?dS9mZGRkN1FscWJod2g4dTJkanFrb0JSZ0plZDN6c0RwZVYrRVNYZGlIOUVu?=
 =?utf-8?B?WlNMekJ6TDV4dkVnWmdvWHVzT25KSU1iVWlCUzZPeU9BMndzcDNFU04yOVRY?=
 =?utf-8?B?Y2ZJWW5YcFlWZXJueUdScnFtOFFHUlFpNDJoQXlrZDk3Q3A1OUUySGo2Q2pi?=
 =?utf-8?B?MHdvelBqa3RjckZkcmF6Qng0YnB3dlZxSldIdEM3S1g3S3MxVE1XWmhVeGJp?=
 =?utf-8?B?MSsvWDdIamdpT09INlN2dTR1R0pud1BsWndvQVlOS3V4bm9LRklvNXdyQmdj?=
 =?utf-8?B?c0xTT1BTTS83U0YrQVQrSmdaS1plT2xRTWNrUlduNmVjMUR2Rmg0NkxTWE4y?=
 =?utf-8?B?OHc0OUV6a1VZdFY0SzFvWXMyNDIxSkpzbG5NNk9XRjR0OGNCczFTWmlHenJG?=
 =?utf-8?B?blgxSC9od3ZBMUZEcENjb1JIbHdnSVNrQ3BGZ1NXdTZaeDd4eGxZTVlWNHNK?=
 =?utf-8?B?b0d0MlZBblZ2SVBVVU93Zk15WkRMN2FCb0xJZUZ2VmdiTWZ4VWV0RlVRZ0Yx?=
 =?utf-8?B?b0pZRkxBallQNHd2aCtoWG1qOGY0ZEkzLytGWktFTENuUmFZeURxdkY5SllR?=
 =?utf-8?B?QzFIY2JxaVdRQVpKdlRyVitvdTc3bEo3U3p0VGdmUDl1TGxKTTdhTFJVdVYr?=
 =?utf-8?B?cGRnbzg1dHZBS0cvQTVQKzlQUEhMM3lwOFk3SFhSZ3FQOWR2QSs1cUVCKzBw?=
 =?utf-8?B?RHgrTzd2YlpWeGpISmhuaXNPRXdGRVhGTVVpSWZUU3l4YmhUSkxYaDlHVGZu?=
 =?utf-8?B?ckVrOGlSZUFpUXdyT1c4VGhCNVBIQnhTRWpLVDVzbVgzYnM3QkZKREQvSzh3?=
 =?utf-8?B?eUU2cDBkcEhnVlBSdk9qVTBzRkcxSlB6WWRwdXNaTkRSNmRtSSs2Y1Q1N1p3?=
 =?utf-8?B?aDgzbDRrT3piUjRGTjhBaXJ5eVRkUTB3dllPUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:48.2334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 376e4ed9-b34c-40f1-d381-08dde3fd8cae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220

AMD systems optionally support an MCA thresholding interrupt. The
interrupt should be used as another signal to trigger MCA polling. This
is similar to how the Intel Corrected Machine Check interrupt (CMCI) is
handled.

AMD MCA thresholding is managed using the MCA_MISC registers within an
MCA bank. The OS will need to modify the hardware error count field in
order to reset the threshold limit and rearm the interrupt. Management
of the MCA_MISC register should be done as a follow up to the basic MCA
polling flow. It should not be the main focus of the interrupt handler.

Furthermore, future systems will have the ability to send an MCA
thresholding interrupt to the OS even when the OS does not manage the
feature, i.e. MCA_MISC registers are Read-as-Zero/Locked.

Call the common MCA polling function when handling the MCA thresholding
interrupt. This will allow the OS to find any valid errors whether or
not the MCA thresholding feature is OS-managed. Also, this allows the
common MCA polling options and kernel parameters to apply to AMD
systems.

Add a callback to the MCA polling function to check and reset any
threshold blocks that have reached their threshold limit.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-16-236dd74f645f@amd.com
    
    v4->v5:
    * No change.
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * Start collecting per-CPU items in a struct.
    * Keep and use mce_flags.amd_threshold.

 arch/x86/kernel/cpu/mce/amd.c      | 49 ++++++++++++++++----------------------
 arch/x86/kernel/cpu/mce/core.c     |  3 +++
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 42f5c115395b..63d8b12fe30f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -54,6 +54,12 @@
 
 static bool thresholding_irq_en;
 
+struct mce_amd_cpu_data {
+	mce_banks_t     thr_intr_banks;
+};
+
+static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
+
 static const char * const th_names[] = {
 	"load_store",
 	"insn_fetch",
@@ -560,6 +566,7 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 	if (!b.interrupt_capable)
 		goto done;
 
+	__set_bit(bank, this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
 	b.interrupt_enable = 1;
 
 	if (!mce_flags.smca) {
@@ -900,12 +907,7 @@ static void amd_deferred_error_interrupt(void)
 		log_error_deferred(bank);
 }
 
-static void log_error_thresholding(unsigned int bank, u64 misc)
-{
-	_log_error_deferred(bank, misc);
-}
-
-static void log_and_reset_block(struct threshold_block *block)
+static void reset_block(struct threshold_block *block)
 {
 	struct thresh_restart tr;
 	u32 low = 0, high = 0;
@@ -919,23 +921,14 @@ static void log_and_reset_block(struct threshold_block *block)
 	if (!(high & MASK_OVERFLOW_HI))
 		return;
 
-	/* Log the MCE which caused the threshold event. */
-	log_error_thresholding(block->bank, ((u64)high << 32) | low);
-
-	/* Reset threshold block after logging error. */
 	memset(&tr, 0, sizeof(tr));
 	tr.b = block;
 	threshold_restart_block(&tr);
 }
 
-/*
- * Threshold interrupt handler will service THRESHOLD_APIC_VECTOR. The interrupt
- * goes off when error_count reaches threshold_limit.
- */
-static void amd_threshold_interrupt(void)
+void amd_reset_thr_limit(unsigned int bank)
 {
-	struct threshold_bank **bp = this_cpu_read(threshold_banks), *thr_bank;
-	unsigned int bank, cpu = smp_processor_id();
+	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	struct threshold_block *block, *tmp;
 
 	/*
@@ -943,20 +936,20 @@ static void amd_threshold_interrupt(void)
 	 * handler is installed at boot time, but on a hotplug event the
 	 * interrupt might fire before the data has been initialized.
 	 */
-	if (!bp)
+	if (!bp || !bp[bank])
 		return;
 
-	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
-			continue;
-
-		thr_bank = bp[bank];
-		if (!thr_bank)
-			continue;
+	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj)
+		reset_block(block);
+}
 
-		list_for_each_entry_safe(block, tmp, &thr_bank->miscj, miscj)
-			log_and_reset_block(block);
-	}
+/*
+ * Threshold interrupt handler will service THRESHOLD_APIC_VECTOR. The interrupt
+ * goes off when error_count reaches threshold_limit.
+ */
+static void amd_threshold_interrupt(void)
+{
+	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b3593a370bc9..e7a9a175bf49 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -831,6 +831,9 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 			mce_log(&err);
 
 clear_it:
+		if (mce_flags.amd_threshold)
+			amd_reset_thr_limit(i);
+
 		/*
 		 * Clear state for this bank.
 		 */
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 6cb2995f0ec1..e25ad0c005d5 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -269,6 +269,7 @@ void mce_threshold_create_device(unsigned int cpu);
 void mce_threshold_remove_device(unsigned int cpu);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
+void amd_reset_thr_limit(unsigned int bank);
 
 /*
  * If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
@@ -300,6 +301,7 @@ static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
+static inline void amd_reset_thr_limit(unsigned int bank) { }
 static inline void smca_extract_err_addr(struct mce *m) { }
 static inline void smca_bsp_init(void) { }
 #endif

-- 
2.51.0


