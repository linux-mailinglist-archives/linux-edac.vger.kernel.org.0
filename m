Return-Path: <linux-edac+bounces-3067-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42713A34AD7
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C515F17877C
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE907245031;
	Thu, 13 Feb 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V/VfGl5g"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C762824292B;
	Thu, 13 Feb 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465199; cv=fail; b=OgEq6L5ym6C3SwB4v46ck4b77On91w+49/XVoMm3hRkXePQbrihx1AUHjq+koQax1eJ3m/QP/uPnVXYvea6EYmPM8FRd1H5wgH4jFs4ocUx5ANoYhIjFWg7NSDI70OCRBGrQkkl0qgiM7rr8wPS8kjHhQkxZvxV67t9YkdFUNjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465199; c=relaxed/simple;
	bh=Oc3sZTZcItnOf74w4ziaquJBycLuzeX6V7oIK6O5oPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=j2JYOSEpzd6v+B/CEdFI/TGIJskwWGKMqheF0kt5+jC3/I/t0LjNywXWvmC2EDWLcJH4aW77uKK5exlCcmMZwMBN6X6jEGmId89xwPY8QtTrBBYKKAlZ7cHjeqqYRRIsWumbg/wflsuomRhlEgOBWh9VQBwNsbV/udYONUe5TBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V/VfGl5g; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGaR5K+s9M4EMuAaZu3RxbgwlWu5I3887NZCC3ampTXgEDU++q8JL4KmEOaD4FdshmWhK4iurFIEsqyrS66v00peejxkMv5ubI5+whQcIbvNuTXqkQKajz3v82T3JcGIRmnbcQe92GLpggoT6+ZTw78StSkNc5U3wPYcgnY9rTqRj5LhXGiPU6o5b/ehRwiaLvaIT2H8oWWPWy8swcEGRs89RnrPEckDhG9f0ed1JOXF0VmeUxDG95oAnGLfyjNxe9g7sgxKESJAqKuinJ39rU9mnjD8BWm/LPHDDhvgUc++iN9gmHGYkvq3cC/lV7fG4z/Life2vaHs/RmwNtyMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glv6YjE8HWaEgjLLluJ6j68SMqnWOWLpLxfYH75JTOI=;
 b=CHna2w9H7Xljt/IdXAFWJfWPTQ8GZEDTl+R6ezjWX7fD9OvKVVy1kFuBj9bcGEz+UBPNiFDxsbNkKvwgk8jWA8yHaiuEa9G0lYcdfn/C9Hg71pyYjduN2343UA9k4W5D62ycu5PCOCIic8oTWHKXKsFxcJpOXQ7nKLMHm2b5B9zXXfHi+93D0hKvmPvZdPdtab1gdIwzhr05lk7LJB5jdGzYFqibarDrt9kCNTyfQooFXcFA2DmcVIiUyfmoAZXn7HRrifa5dHrkGyKSzEUUjIBAUj6aJlo9ki/y7zjudM2rwr8g4k8recOuCElAoiM9/vg140ZRcutXfA/bno9U2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glv6YjE8HWaEgjLLluJ6j68SMqnWOWLpLxfYH75JTOI=;
 b=V/VfGl5gszubycdpK8bjHM5Gx/9h769i4BzS/f8+LU/9OtUwMAQXU9t35mmzLCfw/Nj46bJSs+Fg/KIW33NKnqSLuBGdi6ssf5bhEGvO5MpSz1dxHr8LGAsLqjUAp1hGUeKM2+V7Ui+vV+UKMKZFWanVPps5xCFuXTRq8D0r8Ik=
Received: from DM6PR11CA0030.namprd11.prod.outlook.com (2603:10b6:5:190::43)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Thu, 13 Feb
 2025 16:46:33 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::79) by DM6PR11CA0030.outlook.office365.com
 (2603:10b6:5:190::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 16:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:33 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:29 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:46:01 +0000
Subject: [PATCH v2 12/16] x86/mce: Unify AMD THR handler with MCA Polling
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-12-3636547fe05f@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d063631-947c-4cd4-418c-08dd4c4df96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEpBbTJ5SjE1bzM4R1RSTllNZkc5Q3IwOGhWaEZDblozRm1XWjZncGl4ZEZV?=
 =?utf-8?B?SmZIdHJEbFAwVzZsRmk2WS90aWwxQ3pvZWlGQ29pUitPaXA5NmhqT21uQVpJ?=
 =?utf-8?B?dVQ5WFlpNkw5VjlVd3I0aEVCOU1ab09oQjNzTUhyZm03YU9qNm9NN0xHSThE?=
 =?utf-8?B?Smh5THh0SnAwYUkxTUkxMnZVU3lBRTVIcHVEWnRiRFRnZ2xhV1UwSUtHTlZr?=
 =?utf-8?B?VUZFcHl3MnNOWFNkbTJ0M3ZKeEtYaWZiY0E0RlRWdTNxR09wTG9DR0k5R25h?=
 =?utf-8?B?QWh4M0FZMmdvVnJLSDFNWlY4SWpINnhiK2NDa2svN2Q3c3piQXNsWWdERVh3?=
 =?utf-8?B?VlBuRHd6Y3RiSldVb2VrUU53eFN3OHNFTTE0VWlDTStuUU40cTdLZWNIa0s5?=
 =?utf-8?B?ckRxMXd4cEg1aVROaDhOTWtRdFdRM1dtTU1LTnVnK0dSakl0bWJVMzJJcVk0?=
 =?utf-8?B?WVRnOWFQOGRrdEdFSjRHVGoxQkxQendVM3FNZkR6NFhRUUV4OXRIYThZREN5?=
 =?utf-8?B?dTUyNFdta09mMncvUnRHaUcvdEJaY2xqbnFHREVmRCt2VDR2MnNJdXV2M2pa?=
 =?utf-8?B?VDVCR3ZOOWdTamVFK1Myd1VlZG1zUDZPUVdHQXQ5TVNHWGVEK0pNMFNiSGNE?=
 =?utf-8?B?UDR0N1NyWUdUaHVhRmhqSjBTcnVudjZlWEVRdDJwcG9ueWE4TXR4bnFmZy9m?=
 =?utf-8?B?bFRzQnpTalBtaFhtN2U5WnJ2ODNWbmVnVzJBeStwWVdNSys4T3BDQzBaZ09M?=
 =?utf-8?B?NVNJNUFNZm9uNWNnV01FVFNYbGZTazNrYTE3ZkhicWU4cGl5blVNRC9idzBW?=
 =?utf-8?B?dmd5eTlGdTBubHBTWEY1NThqS0w0ZzlRNXN0QjdTQlpYY0NSYnpwU3dkeHJo?=
 =?utf-8?B?YXNrMS9OQXMwQmZwQzNndkw2QWhucytFK1JUeHdtdUFEU0xqQWFMalVzelpv?=
 =?utf-8?B?bUxtbXZCY0NheVNKRC9lU2Ztc0UwbnMzaUtqUUdpaG8rOHNnNXlmMy91bzRl?=
 =?utf-8?B?S0ZJd1VoV2ZhQ2RpWjFSWVlnRDhRLzJEdStIcXJBYVpKZisyZVo3dk9scEkx?=
 =?utf-8?B?VUtEV1U4N1JqTlhmcTV3V2hrV0RTdmtORnUvZ2VOam55ZnN5eTNyTndlSCtC?=
 =?utf-8?B?S2NDbjBSWmRDeEZ6UnM4K0JwRmVOQ2dMU0NoeDcwWFg3ZXQ1RGRvY2F3dUJB?=
 =?utf-8?B?Ni9pN2tGbTkwTTVrdElVaW10ekxlV0hlazNGRi9NRVZOamVNaHpGbGE3bXhE?=
 =?utf-8?B?ZEV6aXVlaElhL1QyZGRRMFpMRkhYOEpPd3BObEx3VlBldE04WE9DUVJIRjJH?=
 =?utf-8?B?SjArVlVWVWFRYmtpbkt6RG8zellRb0NPaU1OK1FLaXBkQTRMejQ2SU95Ty9t?=
 =?utf-8?B?Wjhqa21sRmgyblI4M0tQS29rVG9kZVZDczZha1JQb0FSQU9EOTNQVHVlenZU?=
 =?utf-8?B?VUN3UGhlWTZHNHc4NDlqcWs0clNyU3gyTHNHQ05HU3k1NDhiYVM0TEhEbUpZ?=
 =?utf-8?B?U1RlYytnNHdJb0F0dnk0QU1ueFlNZStKTnQ5WGpvU3c5bzNDZjlKYjhoL1hU?=
 =?utf-8?B?VHcwUlFYMVBYeDI0SGNKaWVtQzN6MVVaWUJYNFRQdGlxT3Q0WGNvZjNFUHFY?=
 =?utf-8?B?ZDZFVEtBLzd3ZGk0Z2ozVmY3UWQ3dEdGMlh6ZEZTNUo1WjVHUVVEdnBOc2cv?=
 =?utf-8?B?Qm1nbUxEY3JycEhjdUgrMnkydkhsYmNSTDBEMFduaklzekpSV29lNXh4bHVQ?=
 =?utf-8?B?ZklRZjlWNUJCVW1oNDNEdnlnNFRHeEpIcXpHd1JNSDV6cllGM2daYnc4dmMv?=
 =?utf-8?B?M1JKNWpoRUN5UDdUb01pM1BzRkFLTnZCcmY3TmdRY1dGUjRYRXFaSE1qQ2VM?=
 =?utf-8?B?SFY3UWZORFkyQ2lEQUtnNE42UHk0Nm0zUGcxai8rYml4M0txVDdPanIrcFF3?=
 =?utf-8?B?cGUxa2VPYW0vcWhVbktLeEtmdGdjenNkeUFMUEliWXBBUy9ZaC9DRkFZK1R1?=
 =?utf-8?Q?t3+CamAFSnq+03Z6sCiWTZXER8uT4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:33.6067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d063631-947c-4cd4-418c-08dd4c4df96a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382

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
    https://lore.kernel.org/r/20240523155641.2805411-7-yazen.ghannam@amd.com
    
    v1->v2:
    * Start collecting per-CPU items in a struct.
    * Keep and use mce_flags.amd_threshold.

 arch/x86/kernel/cpu/mce/amd.c      | 49 ++++++++++++++++----------------------
 arch/x86/kernel/cpu/mce/core.c     |  3 +++
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c6510415159f..5e491dbdeecc 100644
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
@@ -559,6 +565,7 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 	if (!b.interrupt_capable)
 		goto done;
 
+	__set_bit(bank, this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
 	b.interrupt_enable = 1;
 
 	if (!mce_flags.smca) {
@@ -898,12 +905,7 @@ static void amd_deferred_error_interrupt(void)
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
@@ -917,23 +919,14 @@ static void log_and_reset_block(struct threshold_block *block)
 	if (!(high & MASK_OVERFLOW_HI))
 		return;
 
-	/* Log the MCE which caused the threshold event. */
-	log_error_thresholding(block->bank, ((u64)high << 32) | low);
-
-	/* Reset threshold block after logging error. */
 	memset(&tr, 0, sizeof(tr));
 	tr.b = block;
 	threshold_restart_bank(&tr);
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
@@ -941,20 +934,20 @@ static void amd_threshold_interrupt(void)
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
index 372e8b078dd5..b26eb576e413 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -809,6 +809,9 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 			mce_log(&err);
 
 clear_it:
+		if (mce_flags.amd_threshold)
+			amd_reset_thr_limit(i);
+
 		/*
 		 * Clear state for this bank.
 		 */
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index a4bae8c0cf4c..fe519acfafcf 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -268,6 +268,7 @@ void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 void mce_threshold_create_device(unsigned int cpu);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
+void amd_reset_thr_limit(unsigned int bank);
 
 /*
  * If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
@@ -298,6 +299,7 @@ void mce_smca_cpu_init(void);
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
+static inline void amd_reset_thr_limit(unsigned int bank) { }
 static inline void smca_extract_err_addr(struct mce *m) { }
 static inline void mce_smca_cpu_init(void) {}
 #endif

-- 
2.43.0


