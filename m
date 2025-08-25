Return-Path: <linux-edac+bounces-4675-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E0DB348F2
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B89384E36D5
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AE53126BD;
	Mon, 25 Aug 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KpPo0R6C"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D2330DECF;
	Mon, 25 Aug 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143237; cv=fail; b=M2/wyrwujx7juLkw74rVOUIGBoaD4g33vKp9CqFSIbpNm18QRSld2F0MwP6l81tkBrfY9jwZfqe/CbzrAlcGDKXvQD73eKa75RTXo0rkAKFYhVFnCrjQCqf/ry1D6rOSXOeAATuw5mcxNEk/aACHkNNgo2qa3Th177wl8Pepmfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143237; c=relaxed/simple;
	bh=qnilMg90yaze4yTfkS6GvxCBZc0LzpBS9TCbP4FVjMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FIdyDswrnCbSDm1A7cmqqOKnN5NxZDY6iwgNKROV6B1jx8RWVdJKEKl9+ZXmj0b/x/6SNCkDUNMLo6wKvsp4VZ7yj+hChFt6dtS5JdqcrWZRGmCCtIES+kOxMGrNiLW4OLt4C6D6FBhdsEO865jNHm/QxGWn+mBi0Qg2gz8ZK50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KpPo0R6C; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbS27y4DwryvOouTHNCkt4w60hln3zwM3NPirvJsfXXOjgdhf8iDqRAFTRUS083ChB+TKb+0zkyjlSm5BhTgeE1LI5NXTHAHahDubS7SQwycPUo6Yj79BvS2+kfWi7fWkbrAPzoqowlx73om0fHMh7051+uVR0a8Xeff5WHGvh3Vv225TeQpRZ1aa3VQyUB92ZFwKPaXZ4hsSy93CsHchy3VmGeQ3jinVDYaZzdf1/d0cACEvE81zlmMCg8SVcQlM4Cy++C7XIaz6S5t6I/2qKhMSJXf444/NbH349npIpJMNluL0WI8/upBlVFGUsJSGnKqx3ORZS39DqblZz8Zzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1svcgkOGQOsqlabklr9ihJOI2getr6trkjNyHoebhs0=;
 b=Aa9kYyYHSV6YpAesqfUeJEtW2UaeMjjDlq3YVK257pFcF5nPYyytuEeCvquUHClYd2daMtUkSun8DqRK9XNlkHwLOTKODThmp2Y9Haj2WSGj4Y6b0OOsaD6NFfT0wIwbdW3cfdYDkFWd8HBkPuEZ5BMF2/n7CEYC0tSWZGoZkLoUsngRi12ThaiNYaz7lLJCHL/BoZUiQcbNdYQUrNgQ+Nu9YKIecbCaxKXHkEAjTBy1yiCD+Tafdmq3vzi0YyhfjeHSOIZ6w2ygYX6DJGGp1SzZ+VLqxCY7TQeQTldSxBowM5fbo7r2Q064Laf6DYQMup0Co+Ndbmpft0jo4y6wxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1svcgkOGQOsqlabklr9ihJOI2getr6trkjNyHoebhs0=;
 b=KpPo0R6C7Tpi3bTs6aqvfyA4riUkeILETGoszYbydsdBurFwzJzNHKKpA/+xbDimZT2o7lPsIJrG2gNWhvrcU6f+NvVO8UQY571K8WoFNFrt6jQPx8o1forxKKekNuEbviaICMS5krwf3xDho06q7ugTkmCvtraG5PE89tyxX5w=
Received: from SN7PR04CA0057.namprd04.prod.outlook.com (2603:10b6:806:120::32)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 17:33:50 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::27) by SN7PR04CA0057.outlook.office365.com
 (2603:10b6:806:120::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:49 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:44 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:12 +0000
Subject: [PATCH v5 15/20] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-15-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b88116-e9d3-484e-dc25-08dde3fd8d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnkyVGI5NVZOUTNIZE8wZDNRT1NPb0tHbmdHaHlWeVVTckxZd2ozQXpMczFB?=
 =?utf-8?B?N25SbmRGT3FUQ0ZrUkpHTUdEZHdZQldoNXBjY2hnMFUvQkFpbElCVGRGVHdj?=
 =?utf-8?B?V0xWOG1xVGZ1T1l1MURSOHRTRHRBVGRabzVvMkFsOWkzMFBscFc2ZCtJOXdj?=
 =?utf-8?B?eEd3TjFOV25Zay9sYzFiRHRrTWVzbnZaUlQ4V1QvZ2xCT3pFWHNtRngwblpP?=
 =?utf-8?B?VTRmOE9NQnhKUkdDb2RnY2NGYTlkRE5ma1N2OU9BWmVuc0xMa280UndPaFF1?=
 =?utf-8?B?TUs0eFVoVi9KUlA5ZFNOSXFOWFg4SklpeVpwRVRRNEtFWmlNYW44R2VoRjNu?=
 =?utf-8?B?dTFpeHdoMU5KWTJoTnJmc0xCUWlvYUNubkVKYWJwYjlnZlkwSlVScGxvc3hm?=
 =?utf-8?B?ejNwb0ZDWEZoN3JTakpyN0dmNG4yeEh1NXVpZWQyWlZHdGwvTVRvelUrcHla?=
 =?utf-8?B?Q21INU5UQVliejJrdkUwdzNxN0FsNTRNdmRnTmlQTVZVZXBwZHB5K0VaSlRW?=
 =?utf-8?B?K0xxaGw0eHhPQ3hVVlBialYyU3Z4RndIbHNsSG9mWStIa3ZvS01pQXRSTkN2?=
 =?utf-8?B?Wlk4bXBOVC9oZDUwNE9tenhuWHJraDg4UmN5OWpNTzBxWTl3WjJrdGpuOUts?=
 =?utf-8?B?dEtGQ1hSQVVzYk8zSXZOa2ZqNGNOazNuWFhDbVRPNnRpUGNtN1l0SFJycEc1?=
 =?utf-8?B?ajlaZTFQSlFBK1ZWcFFVWi9rRzhxV2pSTDh0cUh5T2FISkxMMk9DWjBnVmNy?=
 =?utf-8?B?U0ZMWGM3aGRjL29UOGdRbm1RbytXTGI4dkNWZ0x1Q2phOS9IRkVNWnpKbEdv?=
 =?utf-8?B?bE9UZlpnV2xPZUZGNHloUXlxR2RzN0I0SlJOdGNaUXY0T1JRSFBqbHJQVFRF?=
 =?utf-8?B?M3NhbDJDWklYWXI1d3YyWTBaZGFmMXBVb09qUWZRQjRwUFRrbUpBVFNCQjFu?=
 =?utf-8?B?MG1OSU40bjNUbG93OGJQTENkTHZ6NnlrWjJmVm9zZWNYWUhyV0I5eVNzem1D?=
 =?utf-8?B?ZmJJTjZGWTlOYTRzWTdOUWVwaEZLR3lvSkcxMTdISm10TEJyck5zSEYyOUc2?=
 =?utf-8?B?ajQxckFXUFNSR0pSWHBraDBRYU5YME9rcDZPNGRLdldUNVh6VFI1eWVJVmNI?=
 =?utf-8?B?dDZtSXZEUXk5aGUxUDdvRjBqOTR0MnVteGxleUQ4M0xoRGpTV25uL0dZaEZw?=
 =?utf-8?B?MDhnMXRBWkJ2MXJ0UVBqK2lTZWhPUURWdFhQcnQvcmZpRU5KMlVzTVVZSXJI?=
 =?utf-8?B?TWMrb0prZ0ZiOTF2V3BZTCs4NnhFKzhJQkgyMzJ5TDdhVEtWU2plZXVMM2Vq?=
 =?utf-8?B?dVVmL1J2MytFU3JrcXVPSDFDcitGdXJWZUI5YmdFalpKRUpRWGtYRkJXU2lB?=
 =?utf-8?B?elRaTmxMcVZNS2FrNFZUdXYzaXE0SjRyUXM3dDJuNHdFUGVGUWFGOVl1dXZR?=
 =?utf-8?B?NWtzcGtNUUc2ZGRoc1VUM3RSNDRYMk5YRFJobkw4dDFLbWhDdFpkdU1kc1RS?=
 =?utf-8?B?M0JXUnczMjFWeDZGRTFTbTU4UWdiTlJaU05SeGdrZHNONFZOcFFVY3prK2dG?=
 =?utf-8?B?QXB2LzJadFJ5bVdvRWhDU3lGTEh1Q2JEck1jYzREL3U2aFFrUU9PMzl0VTFO?=
 =?utf-8?B?L1doUE51SHRDRDNKbG1DQk85dmNpUlhBOUhWVkhhZDJKNWhOaW02bDJkM21E?=
 =?utf-8?B?bFpOSFVvWWhOdnB6RVhGczRZdlVRZjY2RmxETDg2ZHJhWDNTWjhvejdGTzRO?=
 =?utf-8?B?SzZFc3JpSmdEVDhMa1E4Y1l0aTdpMVV6UzBFbWdJOEJXYnhxdXJrcFlFZGRG?=
 =?utf-8?B?ZWlCZ3FwUnhHSlVXY3N0aG1mSS9rYlRGSDI3MHhtOHVzMTU1bVZhdUtDQlRa?=
 =?utf-8?B?OXc5S3lYUHFlK1JLY3czcTg1L1JEZlplL3NaMWlqQnZrWUo0V3NhRDNXbGNB?=
 =?utf-8?B?cHJFR3pzWUxNdk5vUEpwbzVrUldZcnZodjRRMFdQRy81cGo5bmdzOFNRSDhy?=
 =?utf-8?B?ZVJ1cGt4ZzJMYTNVSURHSEllVVJJOGtRVklocnZtWXR6NlQ5ZU5JaUt4b3hD?=
 =?utf-8?B?VE5rVERwT3QwS2M3T0FrVUhObFQvSzI1T1N2Zz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:49.7067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b88116-e9d3-484e-dc25-08dde3fd8d8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908

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
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-14-8ffd9eb4aa56@amd.com
    
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

 arch/x86/kernel/cpu/mce/amd.c | 113 ++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 65 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 4a832c24d43b..44fa61cafb0d 100644
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
 
@@ -377,6 +377,14 @@ static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
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
@@ -385,14 +393,6 @@ static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
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
@@ -473,41 +473,6 @@ static int setup_APIC_mce_threshold(int reserved, int new)
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
 static u32 smca_get_block_address(unsigned int bank, unsigned int block, u32 low)
 {
 	if (!block)
@@ -552,7 +517,6 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 			int offset, u32 misc_high)
 {
 	unsigned int cpu = smp_processor_id();
-	u32 smca_low, smca_high;
 	struct threshold_block b;
 	int new;
 
@@ -572,18 +536,10 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
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
@@ -591,7 +547,6 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 done:
 	mce_threshold_block_init(&b, offset);
 
-out:
 	return offset;
 }
 
@@ -682,6 +637,32 @@ static void amd_apply_cpu_quirks(struct cpuinfo_x86 *c)
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
+		data->thr_intr_en = true;
+
+	offset = (mca_intr_cfg & MASK_DEF_LVTOFF) >> 4;
+	if (!setup_APIC_eilvt(offset, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		data->dfr_intr_en = true;
+}
+
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
@@ -692,11 +673,16 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	amd_apply_cpu_quirks(c);
 
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
@@ -717,9 +703,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
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


