Return-Path: <linux-edac+bounces-3554-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB195A8A213
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C6F3BB507
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C062BE111;
	Tue, 15 Apr 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0hL3p1n4"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C172BCF40;
	Tue, 15 Apr 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728925; cv=fail; b=dIplU25trEJD3AFRszlkfLFJceb4og9NtKNBtz6jQmVQ6Avv3Aywu7ZzEdj1kKBfXs9Wg8UFbJSVT3/8QwWv2FhAri3Tz/6fp0uMSJLjT7QxnRHwbVeViIge/7NXRMNsKPD0HAHJB6jYvz36/lBty4TX+KKWvod4Dls5aMDqkbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728925; c=relaxed/simple;
	bh=F3+hbVeAnvseO54CzAuVl/dAlcBAoOV8TVQi7AYSoKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gSp9szT1eYwcKpQ6Q7EzL85WSuCQ2VynRP9+maAhY6l3C7e21X1SlvjHZFUSLtvNUsiGjHZ6AU5ENIxw7tuT46OWl/59yEUmhVClb31Rbr9DUnVOvTTXWT3PF+FgKgYzmKeY7hmmv0Vk4QWMnS4y47K8UK3b6rnR6EZXUBemX48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0hL3p1n4; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVvCQLG54LJwpZ6Malz9dv6J3oYA/0yfxqwWnqW3xpHdn2irNiX5Q5ZKkMVkOgZx5BKnDczja0dhK2hz8j+SzUsd72M2RK+8+cReYvXMnsJb2LBQeQTCf6yKqU+4xnRQ+ilDIDXzuTBZ7dp7tA0J+JDQpaZ9BAqIjoXuCmmMzsVJ99Yxm20QE1M7p7HBm75tvmsbSNTRU8ewpgON6kbYYcLrXPOWAgEqsIIEUJfV/FSFkiU6KI8l764sYJFNRK0MvihEe7cgqnQW67dg1Kxa8LjJLbszkxdY9PqG+mQjd1tadPME5Z3CGw2eTdPYYtnaMPsFEYNrmCUsPEICUAk7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQrGFCYIkHInYghWPFgDbqjPyuy9nuuCGMF7dfwQbdM=;
 b=jUl0afEynbePvN7R3jaj4KJiQwkn5sBYqK9Pz25ailICSWvPPIEjoL2EymbVG2Oe+f/raMIYSzjLdHaEOiv/s9A1Z3/dpthNUhoSGIetkRmgNf8EOemZzmN3SEs+zPjLFhkM3iDiDY4LxqPivBTOFY9BS89VH/CX1TJ3NIMTVQzYLuD7KMvq3i6T7lseX77G7ciOF8oHIZKYSPw3LZ7Xqy2l3LpEmet5zOliJAnujD3CpTncSADfh/TbJHd8uFc8db4isCotf3LMia2JgNmtVQSQDQMCyxse0e5jCBMCdTfO9zRibJ2NOUyyhKrTNz0Yy6KwMC6zpdu5A7CocXwoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQrGFCYIkHInYghWPFgDbqjPyuy9nuuCGMF7dfwQbdM=;
 b=0hL3p1n4O0Gsevi/1Sxdt2ypo+sdhAFR9n18P4DpxJld4zPh28CMQ5IP99QU5b53oEISjgjAJWmrq34kcIOLlgzfca77tID39MP3eRESJyYc3boIG3EwVT8Xn4nAB4O6/NvOSCEQaukKvFym9F4fayU7uXBpBYJVX4kgHkT+AMk=
Received: from CH0PR04CA0115.namprd04.prod.outlook.com (2603:10b6:610:75::30)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Tue, 15 Apr
 2025 14:55:18 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::9e) by CH0PR04CA0115.outlook.office365.com
 (2603:10b6:610:75::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 14:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:18 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:16 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:55:09 +0000
Subject: [PATCH v3 14/17] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-14-8ffd9eb4aa56@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 379edea6-1900-4be1-eda5-08dd7c2d8a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akQxNHU0ejZrTGh2ZVRSRkhNOGJ6MWZjQ0xYOWV0VVJibnpFUFlUa2lycVpG?=
 =?utf-8?B?SGNtekN3MHZQNFBKWW1ueldBQ3VtQXNxemgzWTIvYUZMRS90Vm5CWDZoQXhx?=
 =?utf-8?B?RUwwa2JRSUJPUnV5UXl2TTVObi9wTUVNanQ3bGw2a2ZFZ3RDTHBuWnZSdVRS?=
 =?utf-8?B?YjJBYnZvTzMyU1gxNVVMZExhZCtwMnpQWWRocnJTa0lNVjZnZDY5ck51Mjg5?=
 =?utf-8?B?cXFCNFhDQnF3VkhoUmlSYVhHVXVneDNoeEtVMWsyU2hjVzhUMXBaWGNrRGdK?=
 =?utf-8?B?dUVSQTdtMmV3TDBDYjZaT0J5MEo4OUdBWWVRYmlHVHN0WlM3V2lvL0l6dDd0?=
 =?utf-8?B?QkM5OGhuTEdIemNlUFZIelVaRFczUDBpc0hlRHozVjBCai8yK2hSNFMreGNx?=
 =?utf-8?B?ZnZaYXdKbHNJby94SGdiMUhRNUNTSDM5Qk5zOEpRV0d6OTd5NUZTWGdYWlZY?=
 =?utf-8?B?MnhrV1ZnaitXME5oZUVMLy9aUjZMSExvTDJKenJBaUVzZngzS2MwN3NhNkZq?=
 =?utf-8?B?SFNnOUZnRUV5RDYyczRYeEdJVFJzT3BhbktYcWg1aHk0dzdCR2FaNlFndWpw?=
 =?utf-8?B?MmlZdGN2dUp3c2NqYnFBTE96d0ZsQlYzNGl6OTh1OTFIdGlqOE9iU1JYeTVu?=
 =?utf-8?B?d2JoeVdBK05FeVh2Z2k0bzVlcTl1dnhMMXJBRWhSVUdPUFhNMEpUK0VocjJ1?=
 =?utf-8?B?Znlxem4vNHpUY2tQTHMwSEZVcWppNXZrdVZ6WHh5SjI2Rys3bmF5QkVuaEVE?=
 =?utf-8?B?ajdkMlFFcGV4V3V5RnlWVXZZK1BWcFdNVWdhL0pmVnluMWx3dGFiZDd0UTRk?=
 =?utf-8?B?STViTHhXSFlRaCtLeitKT3ZFOEF5bzBJSEt5TmZDRTc1UGxFYlBDTkdoOU42?=
 =?utf-8?B?WG5pU20ybVlERitvdnE4QjI2SkxmY2hUb3JwQWY4MXRINk9LbHBjd09WTWJi?=
 =?utf-8?B?VTFRd2lJNGRRT1dqT3BpRzV2dFpjc3czQi9vb2Q2ZFlMQjhTbFZsVmFGb2lr?=
 =?utf-8?B?SHh5a1c3SXgwYWlrLzBLSHlIRkdtWWJhayt4dnNnUy93c2Z4WmxGT0ZFcDlh?=
 =?utf-8?B?bHhnUmNUaWpadGxFUktVaGxaVUFHWHIrbEhycHpjblc2UHlKb3hsN0pBU2h2?=
 =?utf-8?B?aXdwNTVXbGVzamNoRmFETGg2eHpiZ2FBN29oWTVEakkrUHJhUUpUTDJwTm9C?=
 =?utf-8?B?c3FlUDBsQ25BN0xpUjU0TlhMZ3dBcy8xc0MwTEtIcVZyQkVDcXV4S0FZUUdW?=
 =?utf-8?B?aUZ3enZNTjFEdEZ6WHV2ZDFUWURPb29JWVVvcGs1OXZ1V1JwOHVtNzVFSzBP?=
 =?utf-8?B?SDRlQ1RBd3dHOUdWOGZmbHdnaFExZmhiR2lGb2E5NzFNeVY2dGRGNlZ6YThw?=
 =?utf-8?B?eHBRcGxqUks4cy9odVA1OU5icnlsNm9yTFZ1TW9uNkhnMkQyNUo0bHF0c0Vu?=
 =?utf-8?B?WUxyOWozUDRlNFc4SlJBd0Z3RXZDQ0NHK0QxTmdtcGlLOGxZL2Nya1VKeStQ?=
 =?utf-8?B?Z05aaVY1WmVDeEFZcHFWK0U0N09Ea0puWnRQVG5uMS9qQ0hRQlNCc3FKYzQ3?=
 =?utf-8?B?cXZJNlB6Y1NDMzBMaFIrdWxzaWpqSFliRGNWeWVrMG5IdzRselhUYTJIeDQr?=
 =?utf-8?B?ckZtaHhLTEgyYTlRQXdMbFY3Ymc4R0U5b3pBTCtkRkdhcXRLRGkxb3M0TlJU?=
 =?utf-8?B?a2NUUERJS3JzWlNVNUdsNVpuQnRRN0d2aEVCdS9MMHpGWlpRd09YMjVaVVFh?=
 =?utf-8?B?ZzhzeWQwZXlVNEs0N2tDWGtIWUxkK203RHlsVjdLcy9KbnExbnlQQUphTHRB?=
 =?utf-8?B?NHlmd25tK3dMRkg0c3VvZk9rd0cyV1FjV1RESVo1WW9ISW1kb1FQSStBTXBZ?=
 =?utf-8?B?NkYrTnZUSHNSbXd4WExuNDk5WDNkb1F4M1YzQW5YL3FvdC94K3F2TjhUZEg0?=
 =?utf-8?B?QStWZmhTajMvYUFvQnl5eXp4Qk03dlRHUEY4VFJMSlJFdFRRcXUrTXhudk82?=
 =?utf-8?B?REpqVWswNWw1ZXJLTVlRV25zRU5PL2dkRU52ZUJOOG4yYUNmUUF6VXozMkJl?=
 =?utf-8?B?cjM5NnVoN3luNXdQS0ZIU0EvOVArZkFqRnZCZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:18.6542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379edea6-1900-4be1-eda5-08dd7c2d8a00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753

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

Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-14-3636547fe05f@amd.com
    
    v2->v3:
    * Add tags from Tony.
    
    v1->v2:
    * Use new per-CPU struct.
    * Don't set up interrupt vectors.

 arch/x86/kernel/cpu/mce/amd.c | 113 ++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 65 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 62c4fe98d02a..9e226bdbdc40 100644
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
 
@@ -57,6 +54,8 @@ static bool thresholding_irq_en;
 struct mce_amd_cpu_data {
 	mce_banks_t     thr_intr_banks;
 	mce_banks_t     dfr_intr_banks;
+	bool		thr_intr_en;
+	bool		dfr_intr_en;
 };
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
@@ -271,6 +270,7 @@ void (*deferred_error_int_vector)(void) = default_deferred_error_interrupt;
 
 static void smca_configure(unsigned int bank, unsigned int cpu)
 {
+	struct mce_amd_cpu_data *data = this_cpu_ptr(&mce_amd_data);
 	u8 *bank_counts = this_cpu_ptr(smca_bank_counts);
 	const struct smca_hwid *s_hwid;
 	unsigned int i, hwid_mcatype;
@@ -301,8 +301,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		 * APIC based interrupt. First, check that no interrupt has been
 		 * set.
 		 */
-		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
-			__set_bit(bank, this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
+		if ((low & BIT(5)) && !((high >> 5) & 0x3) && data->dfr_intr_en) {
+			__set_bit(bank, data->dfr_intr_banks);
 			high |= BIT(5);
 		}
 
@@ -378,6 +378,14 @@ static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
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
@@ -386,14 +394,6 @@ static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
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
@@ -474,41 +474,6 @@ static int setup_APIC_mce_threshold(int reserved, int new)
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
 static u32 smca_get_block_address(unsigned int bank, unsigned int block,
 				  unsigned int cpu)
 {
@@ -551,7 +516,6 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 			int offset, u32 misc_high)
 {
 	unsigned int cpu = smp_processor_id();
-	u32 smca_low, smca_high;
 	struct threshold_block b;
 	int new;
 
@@ -571,18 +535,10 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
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
@@ -590,7 +546,6 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 done:
 	mce_threshold_block_init(&b, offset);
 
-out:
 	return offset;
 }
 
@@ -659,6 +614,32 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 		wrmsrq(MSR_K7_HWCR, hwcr);
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
+		data->thr_intr_en = true;
+
+	offset = (mca_intr_cfg & MASK_DEF_LVTOFF) >> 4;
+	if (!setup_APIC_eilvt(offset, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		data->dfr_intr_en = true;
+}
+
 static void amd_apply_quirks(struct cpuinfo_x86 *c)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
@@ -690,11 +671,16 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 
 	amd_apply_quirks(c);
 	mce_flags.amd_threshold	 = 1;
+	smca_enable_interrupt_vectors();
 
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
@@ -715,9 +701,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 			offset = prepare_threshold_block(bank, block, address, offset, high);
 		}
 	}
-
-	if (mce_flags.succor)
-		deferred_error_interrupt_enable(c);
 }
 
 void mce_smca_cpu_init(void)

-- 
2.49.0


