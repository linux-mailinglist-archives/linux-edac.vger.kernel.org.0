Return-Path: <linux-edac+bounces-3551-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F17C8A8A20D
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3DF189DF0E
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5202BD5A6;
	Tue, 15 Apr 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dSSV299K"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3029C33B;
	Tue, 15 Apr 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728923; cv=fail; b=sC0RspPK2AoO9tiYHsDi3pznuvDhpk1otNPGqdQHeLrAuzrc/7JQP8L1npY8dHMmoc3FE37LMyR4yzgB7oQEcO2I8eXLSHyORNSJTkPzArkJVKQvUFjxLEbUo6WotuA605IIdcKT/bDXZ7jOZVbV8esfTxZ+8EuX2OeDDq9JUNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728923; c=relaxed/simple;
	bh=HyHvmMxlkRvKG1XIGhgj6y2mBVS1cQOxTbzCOabLioE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oyg7wIjg+z5YYcEEtl9uVPqtTXNa3OAuwTyx/2bv19L0lTQnbxcTeVbwN+YDJCuYfyC2eNa6Ogma7Ms2elg/YvKOEzQ8QDyvIuKOF+qogT6S4lWbGSrTctA10NyJt6013++aEQt3OLzDHkczf+4fCsKHSZSCRaj1+0+wp0saf9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dSSV299K; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCETbwmNCXngMFiHsJL3mbYXTOJUCwVPeeVn/sMJw4PIXlAxiMZIWIkjo3G3GZJ3KXZc4kAod+4hYikrGHgRTvSzGHCpiiJQOeqDOxPbCL6Jt3hXHj/oTUGsrLzSGCbE1dEwEwrMvu/TrqJzYy0Do9TpJU5IxXLoYCdLx7kFVK7J8xcpsLxkN3CflBI47ZDAI30A0WXq3z+gg3lJC1QLowJVpbD4RQGD9RjBQYHia3Byn7nVW/wUCVOLOB+ENvefvV1VIEhUNyH+wtGkUkV1o2+sz57lxV/h+GZ+N02JconnnTzyyHenJwtMwIQjYl9qercFJzLHTtuHKTcNkBZKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqB8pqBvx7Cwmt7YCuSgZPHbZSR70iSv777T2OlTTB8=;
 b=GsaFIVBIKnbuIZISXXXmynCxXbEzl6sqw0/Bg1dzsjdM3uQ15L4RTeRhyjxhmT1n8LUdwwI12MYSQW2St+GVDcm1vFITZodYAfmxNwFwG/9B4Y4q8mNWjaFwDBw4SjUq8NIKlE/zFQJy9zzO62pYFHDXrK41EIH6YRsum3cMlQnixXVx/g2jul0tFdzOyd+raiOC8cUa9LPxaKFMLcNA9Ez/ni5U/rDCWYa7dI9GAJ2x+AkLNxLH8QstBsAOc5AKi5g6Rd0BtCGlDqpF2rlfKyoymze/3I5sAK0nXBiZdUsIsxxpC8BMK8zfVsjdXAjosdkjNgqHxcwrbNK268lbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqB8pqBvx7Cwmt7YCuSgZPHbZSR70iSv777T2OlTTB8=;
 b=dSSV299KLBU0k0DpP8je9+scMjySrdAGhRON4jeM1rNqbh+owG1yj43U0S9FywyThzm4ifx1st5XOKNt6X4pSC8PGal2pI/NdrrlkVhGpru5GahDtXxPaQ9sJihfKMX6THd+v40plaVO3Dwv6DCn7L5VswE3Jl857GyXuSe/T9o=
Received: from CH0PR04CA0120.namprd04.prod.outlook.com (2603:10b6:610:75::35)
 by CH1PPF6D0742E7B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::613) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 14:55:18 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::7a) by CH0PR04CA0120.outlook.office365.com
 (2603:10b6:610:75::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
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
Date: Tue, 15 Apr 2025 14:55:08 +0000
Subject: [PATCH v3 13/17] x86/mce: Unify AMD DFR handler with MCA Polling
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-13-8ffd9eb4aa56@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CH1PPF6D0742E7B:EE_
X-MS-Office365-Filtering-Correlation-Id: cb703d9a-5955-441c-c7cf-08dd7c2d89da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkxjcUU1M0hMU1NLT1FTUVovaCtPcVptdm5ZeUZubEZESU5teEVIeHlZWVBo?=
 =?utf-8?B?K2djdk1vaTBGeERmM0ZhRmRtMGhOWW1nYVd5MXAwa2tqQlhra0Nybm52QTk4?=
 =?utf-8?B?ckFVSnAwaTlFdWUzVnM2SkVFMzZDalJlVVRLb3dTWW04ditCNkQybHlTZE01?=
 =?utf-8?B?WFhlc0hLQkI5TGpydlJrTnlOeEYxTmZmRmdoVEQ0T1N6dGFLWEQ2OGtyU1Fo?=
 =?utf-8?B?OWVxY3pHemw1dFFYQnBNTHJSeXJoYzJNVlV3K3F1RnZkTWx6c1ZzZzE2eVRY?=
 =?utf-8?B?WHJqczdTOHFEelBueVBuQ25oYmIxUWliZHdhTXZWS3VETVZ6WE5vQVRxeisy?=
 =?utf-8?B?K1pIdUpHVmxqbElnRHh1UENuZ3Ewa2hsOG5YdnpleXR6VGtPTGpuOGU5a3pi?=
 =?utf-8?B?WGp4dkUrOFNGajI3T01aZEExS05wUUZHOUdoSmhaUHJSRVFTaGU1MDV1YjJG?=
 =?utf-8?B?UktPOHFHS2o5dHVHT3dIdXNwM25KQkF0YnhWVkJZaEJWZk54NXNHcEFYNlg3?=
 =?utf-8?B?KzlLVlZ6MkZ0c045b2srRWdpNnlRdjJGeVhpVXpiZGdsVHIxM052QjJUOTR6?=
 =?utf-8?B?Z0RVWUFMM1FqYlFMY0ZHZ0VIN2hKTndua2JVbXc3YTVZZEtUM1NaanNvWElY?=
 =?utf-8?B?NEZ2NjJYbXk1YTRHMEZFR2NOUzhmdW43Sk42ZmVmMlNJcGh3S0tsOWkyTUpo?=
 =?utf-8?B?b1BpZ0xSRUZmSWdvczYvVWZXWnRPbXZ4c0dCTmFJMGZsQ05mOXVCUE9TK2pP?=
 =?utf-8?B?b1I3VG9GTVVwTjFpb3hEdDlXdW9PNFQ2WkJCZWViLytFbFpuc2sxaDVuQnor?=
 =?utf-8?B?dUsrdzlLak1KMHExR295bTlmM3BvMitQTHJBUnBqRjZlUEdYbXRVOGlWVTlm?=
 =?utf-8?B?aHV3QXhxSkhGb0Uza0ZiaFM5YTcyeHV1elFDRGJCeDVwcWxNeW9VT29ONUZC?=
 =?utf-8?B?R2c2S2o4L0JaMHNPUTB2ZUdQMHVBblptaVlRWVdubTRXVmYwekNneG8xSEZ4?=
 =?utf-8?B?ak5VLzdSSW10UmEwWUt1ODhRTFBzWHBTMC9lYXhyajk2TVVpQmlQU3l3c0tq?=
 =?utf-8?B?Y1Axa1lvbnpoM0svakhHUTNhWjJ1dCt4ZVRqUXJmTDhQbFR3K09OcEpMVmdp?=
 =?utf-8?B?Zm85NnJsOS9xUWF2VStrZVgyb24zcDU1OUtMQlZORlQ3djJ4RnZQRGQ2bmZr?=
 =?utf-8?B?VXI1OXIwSDZlenlVWG4xT3NVdXNjQkppL0ZqZHhjRE1JdVVjTEVaUVlTQ1E3?=
 =?utf-8?B?SXpUTUlHdXcyRFFOdGgvR3BDNUhraGEweFZWeHR3QTZVM1ZteGtpV1ZOcWlv?=
 =?utf-8?B?azEyMFZiRzVCdTNYMzVhOEd5UW9oZHBXNk5aMFpFQjdsbHJXUkJTS2pjUnFI?=
 =?utf-8?B?d05QODBlTUE3ZnBuUFltbzJCTjdYVGprM1hiODlkc090VzcxOUZMaGQvQTdS?=
 =?utf-8?B?TUFJUjJtVFNCNlFaRlFKdWI5VHZqTi9qblp1NzhZU001bE55aDhMZTdWRFVt?=
 =?utf-8?B?MzdleGZHNkpqWEltcDBQR1RGdkp6N1AwcTEvU2xPaGZTd0FaR2I5UEY1bzRi?=
 =?utf-8?B?ZEcrMG44RUgzVTRXOVdza0JPWTRIQjdGNzdVQXM1WEFZMjRPNlExYXhtZm1h?=
 =?utf-8?B?WFRtWkVTbjQyODFzNDdrd1JFTy84UjNDR2o1U004K3JyckVJZHVxa3ViTzlD?=
 =?utf-8?B?bm9LNDVwRjVmNjZnNzZza1ovM2FHaWR6aDNNOStGczloNnk2d1hVdW5zZ3VM?=
 =?utf-8?B?TG5IdUNFY3piVENZSzE0WGpoa0dpblEvN251dTA3cXF0WUE3blZDUDJIWi93?=
 =?utf-8?B?YjhnQXVWOUwzcFB1b1k5VVRrcndKYUIwWFVQZG5DWXdzQU5CQmZEUnh5dTA5?=
 =?utf-8?B?TWo5VWI1Mkk0ZWYwRjZZbDJkVklhSXVPQVB3ZzJ6bDZrc2hEbCtTQklnQ0Vw?=
 =?utf-8?B?c0xabjdyajhHZWlHTWc4M1BWSDVVMlVoWElVTnFPRFYzaXlXTi9LelJxWThP?=
 =?utf-8?B?b3NlVytMaitJL3RiU1Q0a0NlQUNHZzA4QjViRzd5YkMrTkNTNGlKQVA4VmJt?=
 =?utf-8?B?UFNBZkFyOVRHUCs5eDIrSEZxVjN5Uk8zQldSdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:18.4042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb703d9a-5955-441c-c7cf-08dd7c2d89da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6D0742E7B

AMD systems optionally support a deferred error interrupt. The interrupt
should be used as another signal to trigger MCA polling. This is similar
to how other MCA interrupts are handled.

Deferred errors do not require any special handling related to the
interrupt, e.g. resetting or rearming the interrupt, etc.

However, Scalable MCA systems include a pair of registers, MCA_DESTAT
and MCA_DEADDR, that should be checked for valid errors. This check
should be done whenever MCA registers are polled. Currently, the
deferred error interrupt does this check, but the MCA polling function
does not.

Call the MCA polling function when handling the deferred error
interrupt. This keeps all "polling" cases in a common function.

Call the polling function only for banks that have the deferred error
interrupt enabled.

Add an SMCA status check helper. This will do the same status check and
register clearing that the interrupt handler has done. And it extends
the common polling flow to find AMD deferred errors.

Remove old code whose functionality is already covered in the common MCA
code.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-13-3636547fe05f@amd.com
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * Keep code comment.
    * Log directly from helper function rather than pass values.

 arch/x86/kernel/cpu/mce/amd.c  | 103 ++---------------------------------------
 arch/x86/kernel/cpu/mce/core.c |  60 +++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 99 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f8755a21fd48..62c4fe98d02a 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -56,6 +56,7 @@ static bool thresholding_irq_en;
 
 struct mce_amd_cpu_data {
 	mce_banks_t     thr_intr_banks;
+	mce_banks_t     dfr_intr_banks;
 };
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
@@ -300,8 +301,10 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		 * APIC based interrupt. First, check that no interrupt has been
 		 * set.
 		 */
-		if ((low & BIT(5)) && !((high >> 5) & 0x3))
+		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
+			__set_bit(bank, this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 			high |= BIT(5);
+		}
 
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
 
@@ -794,37 +797,6 @@ bool amd_mce_usable_address(struct mce *m)
 	return false;
 }
 
-static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
-{
-	struct mce_hw_err err;
-	struct mce *m = &err.m;
-
-	mce_prep_record(&err);
-
-	m->status = status;
-	m->misc   = misc;
-	m->bank   = bank;
-	m->tsc	 = rdtsc();
-
-	if (m->status & MCI_STATUS_ADDRV) {
-		m->addr = addr;
-
-		smca_extract_err_addr(m);
-	}
-
-	if (mce_flags.smca) {
-		rdmsrq(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
-
-		if (m->status & MCI_STATUS_SYNDV) {
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vendor.amd.synd1);
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vendor.amd.synd2);
-		}
-	}
-
-	mce_log(&err);
-}
-
 DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 {
 	trace_deferred_error_apic_entry(DEFERRED_ERROR_VECTOR);
@@ -834,75 +806,10 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 	apic_eoi();
 }
 
-/*
- * Returns true if the logged error is deferred. False, otherwise.
- */
-static inline bool
-_log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
-{
-	u64 status, addr = 0;
-
-	rdmsrq(msr_stat, status);
-	if (!(status & MCI_STATUS_VAL))
-		return false;
-
-	if (status & MCI_STATUS_ADDRV)
-		rdmsrq(msr_addr, addr);
-
-	__log_error(bank, status, addr, misc);
-
-	wrmsrq(msr_stat, 0);
-
-	return status & MCI_STATUS_DEFERRED;
-}
-
-static bool _log_error_deferred(unsigned int bank, u32 misc)
-{
-	if (!_log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
-			     mca_msr_reg(bank, MCA_ADDR), misc))
-		return false;
-
-	/*
-	 * Non-SMCA systems don't have MCA_DESTAT/MCA_DEADDR registers.
-	 * Return true here to avoid accessing these registers.
-	 */
-	if (!mce_flags.smca)
-		return true;
-
-	/* Clear MCA_DESTAT if the deferred error was logged from MCA_STATUS. */
-	wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(bank), 0);
-	return true;
-}
-
-/*
- * We have three scenarios for checking for Deferred errors:
- *
- * 1) Non-SMCA systems check MCA_STATUS and log error if found.
- * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
- *    clear MCA_DESTAT.
- * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
- *    log it.
- */
-static void log_error_deferred(unsigned int bank)
-{
-	if (_log_error_deferred(bank, 0))
-		return;
-
-	/*
-	 * Only deferred errors are logged in MCA_DE{STAT,ADDR} so just check
-	 * for a valid error.
-	 */
-	_log_error_bank(bank, MSR_AMD64_SMCA_MCx_DESTAT(bank),
-			      MSR_AMD64_SMCA_MCx_DEADDR(bank), 0);
-}
-
 /* APIC interrupt handler for deferred errors */
 static void amd_deferred_error_interrupt(void)
 {
-	unsigned int bank;
-
-	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank)
-		log_error_deferred(bank);
+	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 }
 
 static void reset_block(struct threshold_block *block)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index de85b014653f..0a2a97681266 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -714,6 +714,61 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 DEFINE_PER_CPU(unsigned, mce_poll_count);
 
+/*
+ * We have three scenarios for checking for Deferred errors:
+ *
+ * 1) Non-SMCA systems check MCA_STATUS and log error if found.
+ * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
+ *    clear MCA_DESTAT.
+ * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
+ *    log it.
+ */
+static bool smca_should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
+{
+	struct mce *m = &err->m;
+
+	/*
+	 * If this is a deferred error found in MCA_STATUS, then clear
+	 * the redundant data from the MCA_DESTAT register.
+	 */
+	if (m->status & MCI_STATUS_VAL) {
+		if (m->status & MCI_STATUS_DEFERRED)
+			mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+
+		return true;
+	}
+
+	/*
+	 * If the MCA_DESTAT register has valid data, then use
+	 * it as the status register.
+	 */
+	m->status = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
+
+	if (!(m->status & MCI_STATUS_VAL))
+		return false;
+
+	/*
+	 * Gather all relevant data now and log the record before clearing
+	 * the deferred status register. This avoids needing to go back to
+	 * the polling function for these actions.
+	 */
+	mce_read_aux(err, m->bank);
+
+	if (m->status & MCI_STATUS_ADDRV)
+		m->addr = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DEADDR(m->bank));
+
+	smca_extract_err_addr(m);
+	m->severity = mce_severity(m, NULL, NULL, false);
+
+	if (flags & MCP_QUEUE_LOG)
+		mce_gen_pool_add(err);
+	else
+		mce_log(err);
+
+	mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+	return false;
+}
+
 /*
  * Newer Intel systems that support software error
  * recovery need to make additional checks. Other
@@ -740,6 +795,9 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
 {
 	struct mce *m = &err->m;
 
+	if (mce_flags.smca)
+		return smca_should_log_poll_error(flags, err);
+
 	/* If this entry is not valid, ignore it. */
 	if (!(m->status & MCI_STATUS_VAL))
 		return false;
@@ -2226,7 +2284,7 @@ void cpu_mca_init(struct cpuinfo_x86 *c)
 	if (mce_flags.smca)
 		mce_smca_cpu_init();
 
-	rdmsrl(MSR_IA32_MCG_CAP, cap);
+	rdmsrq(MSR_IA32_MCG_CAP, cap);
 
 	/* Use accurate RIP reporting if available. */
 	if ((cap & MCG_EXT_P) && MCG_EXT_CNT(cap) >= 9)

-- 
2.49.0


