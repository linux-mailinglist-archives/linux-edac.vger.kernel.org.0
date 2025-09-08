Return-Path: <linux-edac+bounces-4753-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED68EB49411
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BEA7B49A7
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD616311C07;
	Mon,  8 Sep 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="frVIJI92"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75FE30F94A;
	Mon,  8 Sep 2025 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346073; cv=fail; b=NuDSAGlHF4tDeejOGbq3JfW9dUyJeOcg/tSb3Up0UXTIvXvcTluKrzqHYM6n9VI3wD1CuTIRMlFHvXWKNog6d3oCjL5EVbtrCqVDbX+uW6oS9QNG8EoQ8qttyJtemyYgqiP37vBiqMR0bT9EcYJFqRZD3K2O68nZbJFfgBb7Inc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346073; c=relaxed/simple;
	bh=GMUjCMdxXBBjaOnntWcA5p/78o/tdir0kifc7wdeiUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JWtc7PaRLsMgBH4ejlLlAkI6FwUVLNzG2fhRWFjt8f0ggZeqkKPJZpoUOfqZnDToxQrvIINi2rxZ1nxo9pQHBduc+6/QRjDaxUwCczZQyVlTBVWOdYL3uIZ4AunaxnCXPco9sQl0e4AKEXHwBAM9rKwSn2KoHKXValvdcxYQf3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=frVIJI92; arc=fail smtp.client-ip=40.107.212.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEIj6wZW50IaT1fHJNxI3CDU0LoZgkzXntkdhiQMDCmV9a2Rol4Ga9ugafD1YOwGOZlw1zhnQmiKAzGm4jezaOpDXbE28GRcj/Sa3zn0ccCJMwnEJq388mDuM560W8hbIvzhyJnDgQqI+hsWv/TD3Z39V+cvOyavjWSBZHI22j7wsXxan3RSHsaVz8fLLJQTx+iNajVFAJgvN446AOHifn5gEgKyuJo3JX3RCBTBwCLkudOs9Xp4vxKLSXxmk+6PvGXGWxsn5PdzkuPwpNG2CGlf/ag7OiJ6TgqQGFAZ5c6A6qORMExrRtHMKO1qA3i9jHxT2tuUhy044KXy8D+IFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZU0OT5xZmgRvMQOAq+EBnZsYs3Lb1LLoDP5yDbJ4CM=;
 b=c7zEKogZrD3tC10sZONm25uzo80AUBwy180alB07e9IQfyJsN16Xl1NrqnI7UuokV0cvJ6b3LLQvNMt/sTQjfxa5J611zx9iVpHDp2p2dHf2lwQHmMFysA4a5SV9e9tk1GsGPuyKcGC/FNYVvMlv3PRL9JWzTvJ+Ncp572ce1/avs8iqWqKnrkUIOwICNYVZIlkFica00eqIZgEfgmTwexp6Rf6DCCDLsN/NIN4tnjT8N0BT2gWgn4oNgPD/J6aV3PXrRYf1lPR8YCRZtoKDYaEStkLcGNRFQx/QAjDMaFjiGJylrKTvw7j2EVWwgVzUf3lCM4fTiT40MYDuxeNGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZU0OT5xZmgRvMQOAq+EBnZsYs3Lb1LLoDP5yDbJ4CM=;
 b=frVIJI92DcFvq7Jdhg7thR8r18Y6DDTSbGUw1rDjugEtF2FfXVHZYo2Okh4DIKxiB4DvGdzZOjYuqgGAE/x2RWLWUM0aU560WruWOlk2NmVAuC8FRVIFWJjTR3iP5a7kxVsMGahQ7xZXIAdrLTd34ZuG5uC/JMJwNp0Kxrk5U60=
Received: from CH2PR17CA0024.namprd17.prod.outlook.com (2603:10b6:610:53::34)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:41:08 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::60) by CH2PR17CA0024.outlook.office365.com
 (2603:10b6:610:53::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:41:08 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:41:00 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:39 +0000
Subject: [PATCH v6 10/15] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-10-eef5d6c74b9c@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3cb005-3ce5-4127-65a7-08ddeeee2167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDRPZS8zUDVKNnRVR3oxVGh5bFJYT3RreTQ4VjV6ZTliaGRERzQ0V1VwU3Ji?=
 =?utf-8?B?bUR0ZGJ4dVU3VEpod0tGQWhTVStTVkNzYU5yOXBnZFBUeXFaWEc5VWRzVmwz?=
 =?utf-8?B?UzcrQnIyME1iaDRPcC9IN3Fsa29Ydk84Y0gyRFJaWWJHWTBZTHJMcm50UU85?=
 =?utf-8?B?aE9ublVVSjZMWkU4ZXV0eDhwSkNPOTVEakZpMXZYcGtIc0VzTS9JZmZmQXpY?=
 =?utf-8?B?eXVJSGgwUkhCOHl2YlordDQyaE9sazZRZkgrKys3d284WUYyTUpTQUp5TWdB?=
 =?utf-8?B?a2JRSk1LWnJoZEVTZFlOYUlkTzduQnJTS29FbXBMekN6NVhkd0owZ0xkZEFN?=
 =?utf-8?B?bEFMMjRrNUlFWVNkMFJaVFBKM3duT3FOU1lmelc4eTZKcGJpVVRqQ0I1REFG?=
 =?utf-8?B?TFovY3g5SFNNVEFSVy8vT1hMTytXc2R6T25hcDR3MlM2aFQ3Q2VPQ3NqSExa?=
 =?utf-8?B?Tlh5VU8xWFJ6LzZQTDE1RVpJK0FJWSt1N1JwVkFXTHhleDNaMlIxUXEzNWFn?=
 =?utf-8?B?VGFtdkxlbkUxWXBiVHVMSXRLU1dMdHpEeVJTWVJoblR6Mjdja3BPZmlndHpu?=
 =?utf-8?B?ZUtqSnJ2a1hxK2hMZ2hZQzNweTBvQ3daZWRCek9ray9DTE5SMkN1eExSTkxn?=
 =?utf-8?B?WkhyWU5zbXQvVWY3V1JSRXJNcGo0cjhHZ0JvNDBWdWoyeHBLTEpSdnRtSnBl?=
 =?utf-8?B?dlpmb1UzSlFvOWNDN0RUNzlOMHZ1b2tndUFwREV6MDI5anYyS2tJbFBOL3pm?=
 =?utf-8?B?M3RtZHdrNVYwdUVFOWlsN1MyaFpuOTNRZzJLUVYyTjIvRExxQXk2YVBOS3lj?=
 =?utf-8?B?TnBpNHdZQzVZUTVLMUlTbUNlUS9teHpseVp6TVJSVndsR2k2U213eVVMVHls?=
 =?utf-8?B?TFhNK2hjbFlvZkJpSDIyTGtxamJlWmFpQXFTbm5MSHlVRitWc2krWCtialVL?=
 =?utf-8?B?RE1pTE5Bb3U4eUVTSVlsZDZVZXZobzRSdC9FSDc5bFlmdlpMMmpMMElCSlgw?=
 =?utf-8?B?R0U1b0ZHQ3RKZlZVSllreXU4RGFReG5KbGZLaElnQ09TSSs4OFM4MjhiaUFt?=
 =?utf-8?B?bnhFUkpxeVF5SDNwVG1QUWY3ZmtZVXVVYlJrd0l1UXRJcFBmSWl3eE92YkNZ?=
 =?utf-8?B?dmg3R1pJZ0xodW94WC9ka2x2OTBzdlduUVRON2tpQnVpdG5hRkpOZ3YxRVVY?=
 =?utf-8?B?Qm5lM1VEUzBBdHRxTFZiM3hKKzFZb1JHdFhSUzRFVFN5NC9iUzZkc3JNZlRp?=
 =?utf-8?B?TGZDRGVtUEg4R1hHWjFsaHlBQTZoLy85NWQ2ZzhTTHdqVzMzKzRQUVZIVnkx?=
 =?utf-8?B?ejBqSlpheU81ak1IU0Z3UTZUK2VTakJYdm9nSXRHU01nbDJzL2t5VVJ5T29m?=
 =?utf-8?B?SE9haVlrSVpNaFoxbitNT2c2UllHNXNKZHhSOStoZDZ2QkRuejVJaWJ4ZS9j?=
 =?utf-8?B?QTVKT2F5MWpraHROL3ZPUzRZbG5FeU01REJLZ2xkaXE0VE9seFpPQjNRNEJK?=
 =?utf-8?B?L0huV2Y3WUl5aFpodytUU2N6Q0Z0dnR2eDFjaWFEN0EyNUl1R1o3Ukh0WUYr?=
 =?utf-8?B?cmd4THBLVDh1L1NhSHpjcHNkZzdydzRqRHNseHpqRnE0WDBubU5BZ2Ezblpy?=
 =?utf-8?B?amV6anUzcnVvWlp1elRJZUg5YXlVZVpGZU03VTZGUkhWZzJ6STg2ZmZRZkRp?=
 =?utf-8?B?eFZTRkFBNkkwT05BT0tUblFyN0hCR2wvanZhWnFicXFxTllHZFZwbFB6bkZ0?=
 =?utf-8?B?QUZrN2JhQUgrZzA1eXhCOUx3TzUvN0VKS2RPNUZ0Nmt4M2x1UXhtbVBqNGs3?=
 =?utf-8?B?WFA0U3VHb1ZORzFHYVFrRlU5SXZYNzZSN1dLN2tERzA2R1NqNDFCbUpqdFhK?=
 =?utf-8?B?YU5zOGlySXJteWlEclhTdFpMcFczVlcrQkhwanE4M3dYWTNXVlJuQ2lVbHJO?=
 =?utf-8?B?MlVmTjRjeE5KMDV2VGJHNUtBVXo2YzUvL0hkYzJlQXJlSGZQWFZ6YzRiUmtJ?=
 =?utf-8?B?ZFYreXZQblZUaU95c1krUkNneW44c3FGeGoyMk0vR2xuNTcrQXNXS1FTSUVa?=
 =?utf-8?B?QWd4bkRSb01pWUJVeTVSTEgvWENyT0FuV2RpUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:41:08.5980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3cb005-3ce5-4127-65a7-08ddeeee2167
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341

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
    https://lore.kernel.org/r/20250825-wip-mca-updates-v5-15-865768a2eef8@amd.com
    
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
index 1b1b83b3aef9..a6f5c9339d7c 100644
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
2.51.0


