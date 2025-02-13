Return-Path: <linux-edac+bounces-3070-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C311A34AA9
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF317A551B
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BC824BBE3;
	Thu, 13 Feb 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="koHpa8Mg"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7540A23A9B1;
	Thu, 13 Feb 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465204; cv=fail; b=HN4YLnH67kB5766vwvoYBwJ+9GYPZfVQ4gj6CqwtF8SczS2fXK8EL/iquBSQriEnAUN3fnOiaVKsccHfJf+AnqgQAq8tbVfVPvzcaEOtbEL62LiCgk6htSTC6KSj4P/WXtJJ5BmyvpvbPZPhv1LVu3DRdMshfwoVquC5ZVjEE3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465204; c=relaxed/simple;
	bh=pIGouNrBrgQE1IShgio3lOXTbc0eVeztt08HuGL4TfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Dvrg+i0vuYTdj/XFCrVQCtwrDkd63H+NoeDywuBBnwmGoDCJLH9jH+T1tXBndwv3gjrw4OZga+TwzE73PUSgWDZOAZ+M51zfCkntSZ/F2ikjqPehtSHkVT38IWYRVJDEzXUEFxrvQ5vCDfltencz/6G5RSqA8QPJQe4U75mDKAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=koHpa8Mg; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6MHYnEj3Ynykw/fcTTaMcqEeVgfpuQgem9xrQzwXBOnauziJOG6S2CPfvydHPTdXo0e+p4l5Frh4p+WACyrbHWqRjC4OflbKiLFcBNRm424IC/6CfXNvt4x2JFoe704kP9CcJ7rjid8vl8Y6zb2J42BIN5Bv7HvRPfrmhGeY0D29+dZJ6a1Z+2iY21lCaxaJw1F7ELKL80UbUMRcqi8mTead+JepvhjXFgpKwMGBK4Vfme6muxeJvHgLIWrdDWB5Bi6jn2uyIqfhB/SEJBPR09Jf4MukMzNFdIunWh2w/wVCQacOz9mJB0mdojDe+fn7IJYOxo6GkiEMAhZsBIPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL/eoI9gdvAHWIyFSQ63X8BBFGzAWEk43yIz3N+OEIo=;
 b=FSUiiSGFUCaIuAOgDayGl6laLysxlRoNMlIjIGoJnFgBbGI+xWhNK7Y2jobx5/oJfAyNKALC6a+SvIFcB6HEmVZA8aowmf/cBF9E1gRn2Gt/AP4nOGALtMtWxYsjekJArVLoWz8xQBkZmCSFVgAGkC1Zsv6CtYD1ndBCP3s6/8B0+QRDIX7BpbRItFdb+ash1qvmHHfL++D3SeRIUFQQcG+pQWHJZ4iW/dym9ZhgzkPkDQHaSvbFmaszQulnUt/5/wBKhg4t0RtzvyDhwA9y8KBkPK/EIYdX95rm4DIqLP3e25P8D/MbeoCT/TrbfCPXzx+2TBeTIKTFPiPBGZC/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL/eoI9gdvAHWIyFSQ63X8BBFGzAWEk43yIz3N+OEIo=;
 b=koHpa8Mgx4FwFFyK1bIxVxSlZAup6NxldwHVs0Vv60auuXQQ+Vkkv8wV8enYXkmKp+VhN4NnecajvrC2MkJuibe2dqhZ94p/Zdavyq5zq31h1JVVDxIO8HqlUoC0IBtlKGimbtdkJsKAsKVxcITycXMXJHBZyf3+pWrLpBnHZCI=
Received: from DM6PR11CA0021.namprd11.prod.outlook.com (2603:10b6:5:190::34)
 by PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Thu, 13 Feb
 2025 16:46:36 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::84) by DM6PR11CA0021.outlook.office365.com
 (2603:10b6:5:190::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 16:46:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:35 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:30 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:46:02 +0000
Subject: [PATCH v2 13/16] x86/mce: Unify AMD DFR handler with MCA Polling
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-13-3636547fe05f@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|PH8PR12MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5bb5b7-8aec-4e77-375d-08dd4c4dfa43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW9HS1Vkd20wcklXVE9naHY4eStuN1ZJckxZUTRlMXlzajBYM0RzNU1NWDNV?=
 =?utf-8?B?UkJBYUN5YWxEUS9ZajlJbmJ4bE91R0ZLNmUrb3FIWXZnZ1MyZTBaZzF3YkFJ?=
 =?utf-8?B?VHhrMEdIbTVyek5DMllDTitDNWFqTGVYazJ1QzBsWWkxN0hRZCtGZkpweEYv?=
 =?utf-8?B?OVd2RTZGM2F0T0NQeFFUV2hHZk5xYWpSNzJ0dFRoSHQrV0JFb2dreFZGWGMv?=
 =?utf-8?B?bG4zQWZuT3BPWnJPTExEaG9JWFp6elJSbHFvNmhoOG8vamdoVXpVcE0vaFlO?=
 =?utf-8?B?c0RlL0dlcE5kY0gybFllWUVya3ZZRmxhQ3JWM1p2RFNuNkJ6NlpYRzdGRzBV?=
 =?utf-8?B?eSt2QXI1UGFoRDRoRTJiYXFmL0NIUlFkd1VjcS81TFJ2VW00cG9VUnkrTllh?=
 =?utf-8?B?NmZJVWFoT1ZCTW1La1RWMWJVbkNmVlBVY245QWt2dkJnV2w3TTN6Rng2MEQy?=
 =?utf-8?B?Uncxa1pyQjY5MVdEVmpsSWRVb1lRUU5BY2xoMUVUeDErZ1ZEUmtFV2hiSmc0?=
 =?utf-8?B?QkVFUFEwRSt6T0pRRG5RblF6R2QvZHFkakcrT2VIeWVaeE5NWThlem5DL2VV?=
 =?utf-8?B?aEd3c241d2ltQzZxTDZ3eUpTR0dGdHQrWDVkZ1RkYWE5OGV4QndtSmxYcGwy?=
 =?utf-8?B?NjJnSjUxTUZ6cFpmeVRmK0xpNkQ3WGdCTWFJb0tlWjhzUjFGeUl5VzdCUFVa?=
 =?utf-8?B?R0wweDArR0VNakJ1NTNHdytzQjRFbXl5TmZrUE9OSnJyNGhhbXRseUg4aEJy?=
 =?utf-8?B?WW5iOW4za1F5dHJpNXB0UzhEN3VROXZYcjdOVWxJUjczelRUTmRyZzVkOEYz?=
 =?utf-8?B?c2VSLzBjdG1sd0hCUDBNU2lXdERSTjdQZlNKamlzL3BnTkNFVThXSXZ0UURU?=
 =?utf-8?B?aEphbGg5bDFjRStFUExMbmlET3hNeVNtNVhCZHZVSHovTWt1akFPRUxVazU3?=
 =?utf-8?B?UXBMdU8rdmJodXNKMEtQdEh3OEV2R0tib2d1UmE4WTV3eVRrTDE3ZGdnZkRL?=
 =?utf-8?B?SFMybEo3M3NyN0VQZWVhZW8yM0QxUDRMVG11MVZIeGdxS3lhMzd4dGRYL3Zo?=
 =?utf-8?B?Sm0yRFUyeWk0WHMvMmtVOGF0QzZBY2lHSUdMNHR2bFdLMWRXem5kSVpCQ3ln?=
 =?utf-8?B?STVPN1hYOE5FZURQdG9QS0pjUlBZaEluRGd3TmVIK1NhTmJLUnZia3dJNUNx?=
 =?utf-8?B?QWV5Nm1RV2w2WUdjcmRXUHFBYUhtQWptTTgwRmozZEVZb3Z2U1lDYktYWFp5?=
 =?utf-8?B?TUJacmdvQnJiN3ZuZkwxTitVY0dwSXBOUlphbzI0L2JVMHdvaHlta3J2dVJP?=
 =?utf-8?B?S0s4WHk0VTdiazJtbGRtQkozOUZ5M0JGV3IzdVREQ1V6cDJoaGlWbGQ0WG1Q?=
 =?utf-8?B?clFYckl6Z29UZVlmbTdGR2doaWw2bTRod25VTktzZ2JqN09NZm5DT1VURk9G?=
 =?utf-8?B?YkdiMjBWTE9QZmU3NEdwVjB1VGVGcm9oRk1jdDdia2FXVlJyU2VDMG90Qk5W?=
 =?utf-8?B?OXFnZjVrV2xOV0F0UEJ5emIrTENFd2NQTXBMM0d0ZVB4M1JhZ3NLN0lMNjUy?=
 =?utf-8?B?ekhGMlFUcEpaSThhUG0ydHBkRU5VZkYrTGNUNzdCaUU0Y1FyQmxKZXcrM3ZZ?=
 =?utf-8?B?MVc1YjJ6am1zVUdESUI1UkhJbkh0VVpCUk9MdUxxNXZPNEhRRzQ3VW01UEZS?=
 =?utf-8?B?WUVoSGNRMWlKMVNCbWEvdk0vajlCMXp0QiszZVE3NGJ1RS9WalRrQldya0sx?=
 =?utf-8?B?SE4wVldzcHBobUU4T1NMU3dub2JUSnJxamV0NCtkL2tpOGFQT2M2QmJ4VUk2?=
 =?utf-8?B?eGZZbnVTVWFaQnh1bjZSb3U4VlVrOW1zbFp2NzNlQ2xlZnR2eHdpWDdjaENE?=
 =?utf-8?B?NXAxeEtLYk5qS285WlFOMzI5ei9Db29VV1RqUDVtVERDTkc4V0kxRy9OQjh2?=
 =?utf-8?B?dkd5cERBL1ZQc1VoOEEvWml0V2VXQzhvaFcrMndZTjVSdnVYY0NMSW9SUnR4?=
 =?utf-8?Q?Pd41d8PdLuJ6iCWK1ZXW+9Ac/9ch9s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:35.0286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5bb5b7-8aec-4e77-375d-08dd4c4dfa43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207

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

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20240523155641.2805411-8-yazen.ghannam@amd.com
    
    v1->v2:
    * Keep code comment.
    * Log directly from helper function rather than pass values.

 arch/x86/kernel/cpu/mce/amd.c  | 103 ++---------------------------------------
 arch/x86/kernel/cpu/mce/core.c |  58 +++++++++++++++++++++++
 2 files changed, 63 insertions(+), 98 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5e491dbdeecc..5f547f5b3de0 100644
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
-		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
-
-		if (m->status & MCI_STATUS_SYNDV) {
-			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
-			rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vendor.amd.synd1);
-			rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vendor.amd.synd2);
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
-	rdmsrl(msr_stat, status);
-	if (!(status & MCI_STATUS_VAL))
-		return false;
-
-	if (status & MCI_STATUS_ADDRV)
-		rdmsrl(msr_addr, addr);
-
-	__log_error(bank, status, addr, misc);
-
-	wrmsrl(msr_stat, 0);
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
-	wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(bank), 0);
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
index b26eb576e413..9502e8d3fee7 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -692,6 +692,61 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
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
+			mce_wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+
+		return true;
+	}
+
+	/*
+	 * If the MCA_DESTAT register has valid data, then use
+	 * it as the status register.
+	 */
+	m->status = mce_rdmsrl(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
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
+		m->addr = mce_rdmsrl(MSR_AMD64_SMCA_MCx_DEADDR(m->bank));
+
+	smca_extract_err_addr(m);
+	m->severity = mce_severity(m, NULL, NULL, false);
+
+	if (flags & MCP_QUEUE_LOG)
+		mce_gen_pool_add(err);
+	else
+		mce_log(err);
+
+	mce_wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+	return false;
+}
+
 /*
  * Newer Intel systems that support software error
  * recovery need to make additional checks. Other
@@ -718,6 +773,9 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
 {
 	struct mce *m = &err->m;
 
+	if (mce_flags.smca)
+		return smca_should_log_poll_error(flags, err);
+
 	/* If this entry is not valid, ignore it. */
 	if (!(m->status & MCI_STATUS_VAL))
 		return false;

-- 
2.43.0


