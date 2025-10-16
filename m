Return-Path: <linux-edac+bounces-5066-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2777FBE49DA
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 18:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D12189EBAF
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B72232AAB8;
	Thu, 16 Oct 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1kfbaOti"
X-Original-To: linux-edac@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5D21CC44;
	Thu, 16 Oct 2025 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632686; cv=fail; b=buFnmfTjHp3m3I6L1Haa2QcK+o9v2Z09kCP8XpKSxxFNwKU1dnDtLALY6gzNwHLgwOdmHH0naajyMzCx9fDRpKjyvegG/jAThKqX44CDyK74GmarLRcmdMt0+9mzHuJOD1Pqcimlw2Gso8W11sLhzchGslCygr/GnRGC7aHAC5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632686; c=relaxed/simple;
	bh=pTzoJzkcTP9ZQ6qFbxXhkZe/V0ZcBuypKIgEype06hE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hPxpW9aekCc0yjQJgtIi57huXu32o6rNXF8omwPkoquNHyUoWpEB+GdZAHj3bcQoUbQYg9h6toTL2su3JQ0Ijxu62zf/T2xbvfn6yXNkBcDNEZLug+lJmxOcvszj9QXmFQXvsXGJfGzCOE/qU6TXBfwuTlOFZMAxYnQi4F9hPBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1kfbaOti; arc=fail smtp.client-ip=52.101.43.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzcDdG3qSl8RTBK40QRRm2+acInCPL87/7vpu5khsc1ekLSmSFKx+U08NIr44kasjoWhJF5imUBc740P1Ov+DgFmcIxIDJIw71+3tYGoXNAEkoT1rKTyc3dA6XEpOCjt16Sp3CrjarMB8rhObWR/oVK+54jNOnSxl7LySwAfeHPwTT41B+/5F3s0KiofFteXcgJJilDHLlyp5W4UqWPaCAfB5IS/n5r4Bovwt1fvut1lOELr6rNjM0m5sIzr1lqJFBzjNrj0y6YHw/e31ZJeEJu9ZE4CbIW4GHQ4yM90T3ZehTQOHzcJL5hWhSeWxwaeh/C3ZVp48pxgO/SvHw54tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NONmXt9ywsXOTDhm0J44NaWeeOnPMLGZNkvW++/A0w0=;
 b=IP+1vSn9d7sPez/QeK27RbP/X0hDlQ6dGfQn9wn2Y40dia0WiJMBCh1xgcZcu+T1gN/h+Drpp3EjkETNxrKJhvQXRDe6VlyXvbY7GCRHUu4nSNvvHSjnf1yJzS4/BjoUsNa7xDm/dsT9yLzHp7BvQNzSuAHZfvN0CotzNLi1Hj9t95u1P2x91DvjgnqRojLZgn4Uoej93kO8gItNUlfduoovujXE8Eg7gQjICU6EE/LvxUy8EPXKL0jyCk61Zm7168GQtBz3eH5aNPc5K5yk0Fij7phPMNn3Xf6uLTEKvX6sXUDLbP9PlQ2u5IGUyBUWwlaPBJVtgpUPie0EcAQVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NONmXt9ywsXOTDhm0J44NaWeeOnPMLGZNkvW++/A0w0=;
 b=1kfbaOtiUBQS2CFrH4sHlo2ZWcuT/7IHI5G4i7qEHv32Jaebqgexz7OPdPUqiEoTLspgm+p1BsGxb1bYAGiZ5EDjVZHNcZWX/H2XyxVcMykT5xJ/rKzJXMcKCd0jAsOMjvIywtQJJEKIZeVo2aZtTnWrhSAUyYPKTpu7Nso+dW0=
Received: from BLAP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::16)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 16:38:00 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::73) by BLAP220CA0011.outlook.office365.com
 (2603:10b6:208:32c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 16:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 16:38:00 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 09:37:59 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 16 Oct 2025 16:37:46 +0000
Subject: [PATCH v7 1/8] x86/mce: Unify AMD THR handler with MCA Polling
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251016-wip-mca-updates-v7-1-5c139a4062cb@amd.com>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
In-Reply-To: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Bert Karwatzki <spasswolf@web.de>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d417f2-73bf-4b13-5500-08de0cd25edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWY4aERtT2UvZmdaZDl0Mit5allUV251RnRTSVRZWjRuaVBuWlE2a2JVeFhr?=
 =?utf-8?B?YjkxY2Z3QUtRZjNoQkp3MURrU2M1ZXFoWE9mVXZyYmRIOFBBQXU1Yk5vUWJT?=
 =?utf-8?B?ZW5nUG9oUHZZZ2F3Ykw3MUNxMi9qK0MvTjgvKzIrK2F6dDRwU1lOV2ZBWmpk?=
 =?utf-8?B?b0hOY2krcGZTd1NXUkZUNWtTM2dGNWtMSS9Tc3laMTlyTXB6cWV3UE9HRm5N?=
 =?utf-8?B?VERlVGJFMkJzY2lzNVFTbUY0SGVTRVF3Y3ZCei8wdnY5R3lhUkxtOURiODJv?=
 =?utf-8?B?L203L3hjenIzMEthd2F6SkNQcGpYbVhTUWRiY1RhdzZkQWhsNzQ1aXNINGtC?=
 =?utf-8?B?cGdVNXVJblJQRUFuU2N4czZmQTVnVE84cVphMzZPTGUvaGRJYjZ3dUZySzg1?=
 =?utf-8?B?dHFnQ2h0TjRPNzBsYncwM3Y0UDlBTHBqWGlLQUNqVGd5bTZweGZGUTEwajYv?=
 =?utf-8?B?MElnZmx4TFJ6T2RhTzAwODVWVlBaakVvK1RQVTJRREVUMDZ1Yml5TkZMOWcv?=
 =?utf-8?B?Qk1ORXhhckQzS2pITkVhQUJXbEptRWFWcW1mcktFY0R0SWdjODV2d1BiOVNJ?=
 =?utf-8?B?WXRHN3NYMTliYUdtcmN2K3FwOGZZNEhNRmNnUk9JMk82QW0vM2U4bFhCRHdB?=
 =?utf-8?B?Y1pkNVlmQmdEajZ6Zjg4MXZyYUR3NVF4TjhjK2R3Z2w3ampybE85eVEvMFgr?=
 =?utf-8?B?M0RQcW41TUFlb1orOXhacW9VMVdQN3pRQTRUUDFkeFp1V2g5RFl5WXYvYzk4?=
 =?utf-8?B?eFBIZEpzT1MzTkxteEthOHZyd25qTmZuZHJWdzd2cEUxVmxsMXVNMzZCZVN2?=
 =?utf-8?B?SjVxdnR6ZDhvSnM5KzFFOTY1b3o0bmpYb2puYUhCR0VlY2ZOWWlPeDdFUitN?=
 =?utf-8?B?ZTdoK3VLN3pvRlQ5U0ZGaUJWcW04Rm5DOHVJVzVRcGtqSEIyNDFoSUQyaHpB?=
 =?utf-8?B?dWw2V0RsM3lXMXQ3dHRSMDlmN2pjUkVSRWVDVUNRc2dTY0JrUmhlVlhDUWFS?=
 =?utf-8?B?NnVIaC82Y2VES3JYTWdHT3IxSkg2MHZmaUF6WEhCbVZXQWtwOEJJVXFBeXMv?=
 =?utf-8?B?ZVRWR0VCRi9pQ1kzN05QQ1JhQVlZUG9LLzNXR0FpbjhuMDZOQ29udmsrQlpF?=
 =?utf-8?B?R05QcysyS1RxNEdZa2RNY1FlKzE0VGg5RXhuM1RON1lUOGVuSkNRUjY3TDRv?=
 =?utf-8?B?ZHExM3UrSjNLMHI3aHczSmtaeFhabVVCZ3dnRVNjcG9RRzVsb0N4U0dxRDZa?=
 =?utf-8?B?Mm94Vm04WDNtLzFKVzZ0ZWdZemgxL1R6c3U3bFZyRTRRZVBIOUJFT1lGZHN2?=
 =?utf-8?B?U3loNG9leVQwWVhFTjlHTmJkUGZlTVlyck9idGN4dVRvN0Q4T0dsbTBJTlAw?=
 =?utf-8?B?dmY2TE44OElBaEZxSnRXM1NBbS83SG1BKzVrYjBxL012WCszYkUxSC9sVjNo?=
 =?utf-8?B?T21FTFIySWd3Z0JIcS8zbzhPcmpJYzM0T2U3VWxmYVkveFpKVU01ZG04QS9L?=
 =?utf-8?B?SkxjZEZOeTNHU1pxR3ptNXhKTjEvN0p5WWU0WU1veHFjQnZRTC9iWnBwbnU1?=
 =?utf-8?B?UVJkbTNkZ0Y1T1BGS201U0ZMbDYvaDRQakllZTFZaGRYZlpDQlZtYnZ5SlRQ?=
 =?utf-8?B?WjVtZmhoOHJZaE12Unlxa2R6UVhRdm9idGtXWks0MGZYMjVOcXQ5UHZxUXJj?=
 =?utf-8?B?VUlVb3JKNkRab1duaXJCbEdxVnc4SG9TdWJMb1dnZEsxTy8yanB4eEJvN2dp?=
 =?utf-8?B?WEkzOG5rY0JHektieHRENGRQRDBNUWtOQnFhdnVWcDdKb3FZZmVSMzZFaURH?=
 =?utf-8?B?TzJhQndMSXJvT2xyNUxCbmlSVmJ5bGgwNmd6RjlkSGNnQ1FERENVRVJlT25j?=
 =?utf-8?B?dnBaK1lobmJ1MUwvdldJWDlQK0hoU3kxUURDWEdpNllkSW54MkQyaWRkSzM5?=
 =?utf-8?B?Vm9WMGxSNWoxWFUvcXFGS3Y0aUkrLzc3aU04MVBDQy9rNXdvcitOWWhxM3o0?=
 =?utf-8?B?a1Q4L0pwUFVNV3M4M2Q5VzduU04yVitGam1pTWZVZFBFRUxjYkVUQWtWMU1U?=
 =?utf-8?B?RUtlckhCcGo3cmxJc0VaTFN1UysvVkNKY0ZjRjhMTkE0RDY4K3NTUVhXSkEx?=
 =?utf-8?Q?Lf60=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:38:00.7109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d417f2-73bf-4b13-5500-08de0cd25edf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699

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
    https://lore.kernel.org/r/20250908-wip-mca-updates-v6-8-eef5d6c74b9c@amd.com
    
    v6->v7:
    * No change.
    
    v5->v6:
    * Move bank/block reset code to new helper.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * Start collecting per-CPU items in a struct.
    * Keep and use mce_flags.amd_threshold.

 arch/x86/kernel/cpu/mce/amd.c | 51 +++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d6906442f49b..ac6a98aa7bc2 100644
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
@@ -556,6 +562,7 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 	if (!b.interrupt_capable)
 		goto done;
 
+	__set_bit(bank, this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
 	b.interrupt_enable = 1;
 
 	if (!mce_flags.smca) {
@@ -896,12 +903,7 @@ static void amd_deferred_error_interrupt(void)
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
@@ -915,23 +917,14 @@ static void log_and_reset_block(struct threshold_block *block)
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
+static void amd_reset_thr_limit(unsigned int bank)
 {
-	struct threshold_bank **bp = this_cpu_read(threshold_banks), *thr_bank;
-	unsigned int bank, cpu = smp_processor_id();
+	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	struct threshold_block *block, *tmp;
 
 	/*
@@ -939,24 +932,26 @@ static void amd_threshold_interrupt(void)
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
 
 void amd_clear_bank(struct mce *m)
 {
+	amd_reset_thr_limit(m->bank);
+
 	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
 }
 

-- 
2.51.0


