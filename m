Return-Path: <linux-edac+bounces-5335-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49477C31B0A
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 16:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFEC3A8DCC
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EFA333445;
	Tue,  4 Nov 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="24E1Fojf"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A933290A;
	Tue,  4 Nov 2025 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268170; cv=fail; b=O9SbWi+qyIC2SMEtJWiwGJEXr93x2qM1trjz8EEQTNL9hHl1EcgLBLlIpU9C1S1obIXKzRF8Tgs4g6WA/pf3s2FVYv6Ea/4rBj33CKiuHkGrPdM4Z7NSY5+cZiRcN+jlVwNtfIbsDpqI9xQcipcyEjDK7Lgyl8ZlvHKgnxALSsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268170; c=relaxed/simple;
	bh=XANYXjGICx5CHYuFLmzvYFYO4YU9kwwvRm3qhZdSVNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=f0CG87O8dchWnxaWuZDSKkwECiSLHChSzuVdbbaFUR/KPjANxp9+jjS+eJ0Ry08aUcw3qVt8nzN2R79EkO/UWYSZd4Cusymgp3RT+cu5PGHVnIb71xENPzSL8iTM5MirmUfedjau/abVtMrgDxd/IWU+vtCFzWeK5W8ZseLqaYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=24E1Fojf; arc=fail smtp.client-ip=52.101.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISR4fpQSDL8nQvo5LNZQRgYHomgsxrwz8MlJ1HErxehcVwHgd8Ej6Bj8JlglmbSON5eUHoxYUK3TiO6r29v2ZclQlBab8Tw4cQHOeScr+e5/ryL7hPpEwLgMkMnpHf1IGNS83GUC3tBC9CDdfW0d1kaMRunJfFgsSJC1rpWwKNC3GOXttB+DGeuux4v0iERtdErWt0/BZvflou4kHg4QZjLhAaGAqqHwEsgdLBpV9sf2cJ/YB1+Xr8b339ao3qa4EouxyHenX8rBCuboDqYgtzm9KXklvUfzKZzEKnHtjvjIeiE4/IUTt64fEYTlNkXhxnUrc2iOSBwia7+7w04bsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEYe3YXvmtgdbe6TIq26dQ/JiGwwxPDqLF6u6iKlaXc=;
 b=HkyYo1FOE2Vr3o25Cfk/T0DI3sk4QgS7g05IQLZXuWwpTOPNUseUAT2xooygIhd1/b596kflwJSxAfy60z1bRIi1l9sZe8RwZ6Goz/wztBWINt2jCDtHM7dB6BZXkC5rQ0uromilm+Uk3d18cLCdPPoFYu5fs855tYXBP5k1qzy7vR7CR/BQslXweeIHnbegshyBMsSIDjNZ7HANknXavKETPJSe9TLgatoZYUFR4SxZ0zw9woMx7VCUiMTaBrLB+jWlnZFW4MrP8a1qC4VkdcnUDw1/LesJUA4i2Hs3ulJ9MJfr3gjXeaLnjXTGZBCkDixB+59HGVrOZG6RBDXnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEYe3YXvmtgdbe6TIq26dQ/JiGwwxPDqLF6u6iKlaXc=;
 b=24E1Fojfeo/0vVmy1V2hXxFMELS/f4CcZeWZuSQ+msv1fGwuLSDqOGNmy3IfXr71A6z9NWt7z4+4h8g94xQG1xYZ4o4ZWlhbjQriUEAcFGAHXAinSq3GzcTUvBb5ED+viSiQ1aIzD25ylgBmCW9SjAaawSFitgYR17JuciPtq4U=
Received: from DM6PR06CA0081.namprd06.prod.outlook.com (2603:10b6:5:336::14)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:55:58 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::64) by DM6PR06CA0081.outlook.office365.com
 (2603:10b6:5:336::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 14:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:55:57 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 06:55:52 -0800
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 4 Nov 2025 14:55:40 +0000
Subject: [PATCH v8 3/8] x86/mce/amd: Enable interrupt vectors once per-CPU
 on SMCA systems
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251104-wip-mca-updates-v8-3-66c8eacf67b9@amd.com>
References: <20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com>
In-Reply-To: <20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 24fcc305-4b96-48c4-90fe-08de1bb24339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFd0cE1oSEJwYUI2cm5jd1dDck12SjNsemJYZUlNaVF0dlVodkZob2dzRXhY?=
 =?utf-8?B?RVFXelg1TklmczRCRTZHaEJmakFZSWtkMFUxczhrTXdHWitwZkVVQWhyYXZ4?=
 =?utf-8?B?dlpMWEF0TUlTOFVPZlpIZzVIRWlQZW1QSFNqQ0N4SDR6NGVPYjBPUnJvaVF4?=
 =?utf-8?B?TUN5Tkc5TFRyaGw0NkJ0bGtXaFc3eWFicFVtS1dSRWJSbE1GT3ZiRG1BMnpU?=
 =?utf-8?B?bCt5RXVLcVQvclZvM3dGWFhhYnc3SWNBTVNSZXVweEpGRWF5eUxyWGp3QUZI?=
 =?utf-8?B?NWl6Ykl1Q3FPckNBTU5PVGRGVlp0emZIMHhjdDBzTk96UzhScHh6YWFZeGcw?=
 =?utf-8?B?b3RFTm0wZTZob0tpSmt0QXhwcmhuWmVJazFPNXNycTg5OHNyVDZWcDhBOXpM?=
 =?utf-8?B?NXJQL1Rqd2ZyeTh2Y2VuMm5vWFNET1JxTFNkSzdiSjNXWVNaVzJXT3poaFo0?=
 =?utf-8?B?czZGWm5nRDVtbDRNME9WK2ZmMjJ5U0tTYnh4aFZLUUJZQ0RiK0Y2Ynp1Zm00?=
 =?utf-8?B?NTVyWGdoZGFBNml3SXVNNWtlRnRXRDlSckhaMlhlY2JxY2VVeFNxZDJXODNo?=
 =?utf-8?B?R3VvazFacUtWcWQ2ZE9zVTNpTSthR1FyZlRwUXJaZHJvRnJQVWpuKy9XcVg4?=
 =?utf-8?B?a3JYZzd3bitML0U1dkt6aCtKcHdsQUFEejlUK3NkcXZHTU1vL0hNUEtobUVz?=
 =?utf-8?B?bTVNWWkwclEvTFY4Tkd6bUN1K3Fud3RtbzA5K2JqNDYzL1ZFbzhGUHpkTFRF?=
 =?utf-8?B?RjZaRTN4b3NSYnVBYWFVcXdnSUpQeGdVdDVpbmFQRGVaQUNTZDNwOElRVElZ?=
 =?utf-8?B?WXRiV21tVGg4azhrSzY5VDhGNEY5SFg0NVRtT3NNY3hwNldGODlBMWF0dWVj?=
 =?utf-8?B?dksvY05Pd3BoNHkrdnRvbVNoSVJqQXF1QTdzcEJTUjhHajNDbjZiZTVPTTJj?=
 =?utf-8?B?QUlRSVJNb2krZk5qRWtIblBJWWR2ekszR3BudzZDOEhrM25SMFRsdU56d2h1?=
 =?utf-8?B?bllyWDVzME5Sd2VodHdCU3pnWGI1Mkc4TVR6Skw2blhoTTF5WW13aER2ckZV?=
 =?utf-8?B?bytSL0lBOU95cWVINWErcTNOVHZsVndiNkIvd2dadGJnNXMwQ3dlZjYrUmJr?=
 =?utf-8?B?RGRZbjJUNy83aXZ2cnpad0dFKzJ4TDY4OGlzb0JBaWhlSkJQZVhUME5yeUlL?=
 =?utf-8?B?WjFldFlPcEM0Y0FleEk3RFBack1ySDVrMWUwL051dkdMb2ZKQ3l5SU1LR3hZ?=
 =?utf-8?B?eWlUUklaOEd4SFFOdi96OTN2UTNRbkRyeVBXekxzcE9tZU9NQnRMbE5pUkVp?=
 =?utf-8?B?a1lST2JTL0tjalZ2bW1VNzFSNEtKVVJmNlZScjh1SHRHSGRSdDhxL3dvMDZU?=
 =?utf-8?B?TXV3WHRQWTlBOGxRM0hJQXRINGoxdjJHOXk4Mm5CeWtoV1lxOWJYMFRzYlky?=
 =?utf-8?B?NnErZ0oxaHNkUWF3UE5kbjFrMEdTUnVEZ0tSRzJPRXZHRG5rSGdPWmFEZDBT?=
 =?utf-8?B?RXlyeUxyOUlwMTRiR21zQmh5WVJyVXN3TjQvSzBSNXo1UzFoWDJLdmRYMFdX?=
 =?utf-8?B?YXJrWHB6akhNVG5QMUh5NDNFTEJ3SUNHM1k3ZjJZSjlXSFZ1RXFhdUwrbmNH?=
 =?utf-8?B?eTRFK2N5TkhXVklYeXpHTGJQWktFZkZMbWtjc3Myd0JHYjRRWCtEYXR2czFs?=
 =?utf-8?B?RVAwNEp0WFdXa01FTXpqWWpCdlNvNXY3bGF3QjgvSzF5RjJ6S3dsRVpyU1Nu?=
 =?utf-8?B?eFdrdzFmZWdaUTJ2NTMzdFg4V0huTnJhUnNEUzArVEtYdDAzclZjOW9YUHVh?=
 =?utf-8?B?aUM5TGlpb0R2a3Nlc1JZNWJRQUFWdlNhUHFtazFqY2hQbkhOMVlFcThsWlZv?=
 =?utf-8?B?cnJOYTY3Z1hBaG9JbzFIYW91MVRhQW1LRTBYTG5TUURpKzd3UlFTaGo3bVZG?=
 =?utf-8?B?SUxRUExKU1BoUERBYWxBMDR6cldHVVFOZkhqaTdhSkpOQzA4M2VYRU4vWXIr?=
 =?utf-8?B?V01DUzVSY2hrSkJjbVJuam1mRU80WkhlK1pjZDZCTWVoR0NtY0Q3aC9PNEo2?=
 =?utf-8?B?a0I1akR0dHhpdVFDWG9IQ3l1ZHBtaHU5aDBxakQ3SzlqS0p3M0hMaW1MTVNl?=
 =?utf-8?Q?9+R75DV/5CuX9xfNI5Jz3hqAQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:55:57.8367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fcc305-4b96-48c4-90fe-08de1bb24339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091

Scalable MCA systems have a per-CPU register that gives the APIC LVT
offset for the thresholding and deferred error interrupts.

Currently, this register is read once to set up the deferred error
interrupt and then read again for each thresholding block. Furthermore,
the APIC LVT registers are configured each time, but they only need to
be configured once per-CPU.

Move the APIC LVT setup to the early part of CPU init, so that the
registers are set up once. Also, this ensures that the kernel is ready
to service the interrupts before the individual error sources (each MCA
bank) are enabled.

Apply this change only to SMCA systems to avoid breaking any legacy
behavior. The deferred error interrupt is technically advertised by the
SUCCOR feature. However, this was first made available on SMCA systems.
Therefore, only set up the deferred error interrupt on SMCA systems and
simplify the code.

Guidance from hardware designers is that the LVT offsets provided from
the platform should be used. The kernel should not try to enforce
specific values. However, the kernel should check that an LVT offset is
not reused for multiple sources.

Therefore, remove the extra checking and value enforcement from the MCE
code. The "reuse/conflict" case is already handled in
setup_APIC_eilvt().

Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20251016-wip-mca-updates-v7-3-5c139a4062cb@amd.com
    
    v7->v8:
    * No change.
    
    v6->v7:
    * No change.
    
    v5->v6:
    * Applied "bools to flags" and other fixups from Boris.
    
    v4->v5:
    * Added back to set.
    * Updated commit message with more details.
    
    v3->v4:
    * Dropped from set.
    
    v2->v3:
    * Add tags from Tony.
    
    v1->v2:
    * Use new per-CPU struct.
    * Don't set up interrupt vectors.

 arch/x86/kernel/cpu/mce/amd.c | 121 ++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 68 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d9f9ee7db5c8..117165c357b7 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -43,9 +43,6 @@
 /* Deferred error settings */
 #define MSR_CU_DEF_ERR		0xC0000410
 #define MASK_DEF_LVTOFF		0x000000F0
-#define MASK_DEF_INT_TYPE	0x00000006
-#define DEF_LVT_OFF		0x2
-#define DEF_INT_TYPE_APIC	0x2
 
 /* Scalable MCA: */
 
@@ -57,6 +54,10 @@ static bool thresholding_irq_en;
 struct mce_amd_cpu_data {
 	mce_banks_t     thr_intr_banks;
 	mce_banks_t     dfr_intr_banks;
+
+	u32		thr_intr_en: 1,
+			dfr_intr_en: 1,
+			__resv: 30;
 };
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
@@ -271,6 +272,7 @@ void (*deferred_error_int_vector)(void) = default_deferred_error_interrupt;
 
 static void smca_configure(unsigned int bank, unsigned int cpu)
 {
+	struct mce_amd_cpu_data *data = this_cpu_ptr(&mce_amd_data);
 	u8 *bank_counts = this_cpu_ptr(smca_bank_counts);
 	const struct smca_hwid *s_hwid;
 	unsigned int i, hwid_mcatype;
@@ -301,8 +303,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		 * APIC based interrupt. First, check that no interrupt has been
 		 * set.
 		 */
-		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
-			__set_bit(bank, this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
+		if ((low & BIT(5)) && !((high >> 5) & 0x3) && data->dfr_intr_en) {
+			__set_bit(bank, data->dfr_intr_banks);
 			high |= BIT(5);
 		}
 
@@ -377,6 +379,14 @@ static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 {
 	int msr = (hi & MASK_LVTOFF_HI) >> 20;
 
+	/*
+	 * On SMCA CPUs, LVT offset is programmed at a different MSR, and
+	 * the BIOS provides the value. The original field where LVT offset
+	 * was set is reserved. Return early here:
+	 */
+	if (mce_flags.smca)
+		return false;
+
 	if (apic < 0) {
 		pr_err(FW_BUG "cpu %d, failed to setup threshold interrupt "
 		       "for bank %d, block %d (MSR%08X=0x%x%08x)\n", b->cpu,
@@ -385,14 +395,6 @@ static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 	}
 
 	if (apic != msr) {
-		/*
-		 * On SMCA CPUs, LVT offset is programmed at a different MSR, and
-		 * the BIOS provides the value. The original field where LVT offset
-		 * was set is reserved. Return early here:
-		 */
-		if (mce_flags.smca)
-			return false;
-
 		pr_err(FW_BUG "cpu %d, invalid threshold interrupt offset %d "
 		       "for bank %d, block %d (MSR%08X=0x%x%08x)\n",
 		       b->cpu, apic, b->bank, b->block, b->address, hi, lo);
@@ -473,41 +475,6 @@ static int setup_APIC_mce_threshold(int reserved, int new)
 	return reserved;
 }
 
-static int setup_APIC_deferred_error(int reserved, int new)
-{
-	if (reserved < 0 && !setup_APIC_eilvt(new, DEFERRED_ERROR_VECTOR,
-					      APIC_EILVT_MSG_FIX, 0))
-		return new;
-
-	return reserved;
-}
-
-static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
-{
-	u32 low = 0, high = 0;
-	int def_offset = -1, def_new;
-
-	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
-		return;
-
-	def_new = (low & MASK_DEF_LVTOFF) >> 4;
-	if (!(low & MASK_DEF_LVTOFF)) {
-		pr_err(FW_BUG "Your BIOS is not setting up LVT offset 0x2 for deferred error IRQs correctly.\n");
-		def_new = DEF_LVT_OFF;
-		low = (low & ~MASK_DEF_LVTOFF) | (DEF_LVT_OFF << 4);
-	}
-
-	def_offset = setup_APIC_deferred_error(def_offset, def_new);
-	if ((def_offset == def_new) &&
-	    (deferred_error_int_vector != amd_deferred_error_interrupt))
-		deferred_error_int_vector = amd_deferred_error_interrupt;
-
-	if (!mce_flags.smca)
-		low = (low & ~MASK_DEF_INT_TYPE) | DEF_INT_TYPE_APIC;
-
-	wrmsr(MSR_CU_DEF_ERR, low, high);
-}
-
 static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 			     unsigned int bank, unsigned int block,
 			     unsigned int cpu)
@@ -543,12 +510,10 @@ static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 	return addr;
 }
 
-static int
-prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
-			int offset, u32 misc_high)
+static int prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
+				   int offset, u32 misc_high)
 {
 	unsigned int cpu = smp_processor_id();
-	u32 smca_low, smca_high;
 	struct threshold_block b;
 	int new;
 
@@ -568,18 +533,10 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 	__set_bit(bank, this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
 	b.interrupt_enable = 1;
 
-	if (!mce_flags.smca) {
-		new = (misc_high & MASK_LVTOFF_HI) >> 20;
-		goto set_offset;
-	}
-
-	/* Gather LVT offset for thresholding: */
-	if (rdmsr_safe(MSR_CU_DEF_ERR, &smca_low, &smca_high))
-		goto out;
-
-	new = (smca_low & SMCA_THR_LVT_OFF) >> 12;
+	if (mce_flags.smca)
+		goto done;
 
-set_offset:
+	new = (misc_high & MASK_LVTOFF_HI) >> 20;
 	offset = setup_APIC_mce_threshold(offset, new);
 	if (offset == new)
 		thresholding_irq_en = true;
@@ -587,7 +544,6 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 done:
 	mce_threshold_block_init(&b, offset);
 
-out:
 	return offset;
 }
 
@@ -678,6 +634,32 @@ static void amd_apply_cpu_quirks(struct cpuinfo_x86 *c)
 		mce_banks[0].ctl = 0;
 }
 
+/*
+ * Enable the APIC LVT interrupt vectors once per-CPU. This should be done before hardware is
+ * ready to send interrupts.
+ *
+ * Individual error sources are enabled later during per-bank init.
+ */
+static void smca_enable_interrupt_vectors(void)
+{
+	struct mce_amd_cpu_data *data = this_cpu_ptr(&mce_amd_data);
+	u64 mca_intr_cfg, offset;
+
+	if (!mce_flags.smca || !mce_flags.succor)
+		return;
+
+	if (rdmsrq_safe(MSR_CU_DEF_ERR, &mca_intr_cfg))
+		return;
+
+	offset = (mca_intr_cfg & SMCA_THR_LVT_OFF) >> 12;
+	if (!setup_APIC_eilvt(offset, THRESHOLD_APIC_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		data->thr_intr_en = 1;
+
+	offset = (mca_intr_cfg & MASK_DEF_LVTOFF) >> 4;
+	if (!setup_APIC_eilvt(offset, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		data->dfr_intr_en = 1;
+}
+
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
@@ -689,10 +671,16 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 
 	mce_flags.amd_threshold	 = 1;
 
+	smca_enable_interrupt_vectors();
+
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (mce_flags.smca)
+		if (mce_flags.smca) {
 			smca_configure(bank, cpu);
 
+			if (!this_cpu_ptr(&mce_amd_data)->thr_intr_en)
+				continue;
+		}
+
 		disable_err_thresholding(c, bank);
 
 		for (block = 0; block < NR_BLOCKS; ++block) {
@@ -713,9 +701,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 			offset = prepare_threshold_block(bank, block, address, offset, high);
 		}
 	}
-
-	if (mce_flags.succor)
-		deferred_error_interrupt_enable(c);
 }
 
 void smca_bsp_init(void)

-- 
2.51.2


