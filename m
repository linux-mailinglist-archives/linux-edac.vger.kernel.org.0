Return-Path: <linux-edac+bounces-3553-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A18A8A212
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4C3189E031
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7E52BE109;
	Tue, 15 Apr 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="In5//C/H"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666429E078;
	Tue, 15 Apr 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728925; cv=fail; b=HyOBVOhTTvpBp2QV3MVEfvS+j75T1sDHwbAmE7Ue0QC2WiNo++vNB9lvuX+VDtf2xsmGqz3LTESXFH2ElDP+qGfU+r3IT112ISN6wSACFiuo17puutLtpiFVfBvQkwJDTGCgiPIisIDpQJQYnwijNRm6bPslASGLEmAwNn7SXuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728925; c=relaxed/simple;
	bh=3v8bKl8XifDlubORmDN18Z1zZH2gGRnB5or/L3pABqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UVeTXyMD8KhywQg87gMwdnHKldUdLy9+etTicbu5SFdHH6JQrqQbrgwjBvExaG02nNgQhnAQD735lMFmjO6nWsGmXFWNK1yyyeNE58kdpBAg/F71ydkO+pEOfFF0kTVjat8H6BAoz0dPd5/bLGcyKR9+oUjbWRnAmPoNGnvuj5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=In5//C/H; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbAYsFlRPZ11hCHdkwa03JOt/PoSRCBpl8cYvVkOVM2rjbK2nbrUYjwyRbC3PoOJIbnb9Bxs4UW6lH88St0lFzn3ZF2N+RBw8v0Z1x7biGm4e8/09e1qVx84W7AEBeacO+6AMy7RKYBF/+BZMHD2ns2UsSEUtJ+/rFfFUb8npyfmQKY3xvYmvaCLiB0wAJ7mH5VN1FsXRs5nk5Y7VCSXcG/oYs7Ons+ry2UDwLbeAGtrWm/t0KJ7KjEo1YFDfc0IsoN6jagIWFkoJgK3eS9k9dsljBr06pbjyz4jenK5G4XEaMPfv+Dpeu2o4O0x+GbYw5b99pty6JOUFc8NF40ueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4hTpbKhD3YjY/dv3dIvoPMWq3dYt2cw6L0mITVZNqs=;
 b=W0Imt+23wLo6CQJxgpU5Gtg3VnM++f0Ru/JLAQLT43qG5QWq4VnNjvP5nmFZvFdVE/IVAR6ETMhnAvoAK5HoaykqlbcJDX6EN6UitO7SnHhs4tHUffrMc2JTXEQqST8RO73oa2/4Tv9O1wFnGsNuVkzBF4eEJhTohFPqRzyNu6S6xqh/rHng8oATsDeRj1t3aDbRNJErQMioQ9RfbIpb74dvL/CxM1HHuyhz8rOzxCMQ9ndo3yye/GVQ5s9yU/DBfD8qTvpesXw1vqBj74YL5o5lbeu+jZ8T/DLm5tf5yqEKNBXpORDQgu5Ji3/eWNwH/ftG2YZwzl/iZkLqJ3/wQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4hTpbKhD3YjY/dv3dIvoPMWq3dYt2cw6L0mITVZNqs=;
 b=In5//C/H6IdBKM3IznXL7SoQTmVtH+L0Cbh89giJPR5LdZZH0w6dJqWDZLpOS7q3IEoNUCsCsKRjRY8ibAGjgj7YR5q0rIET04QBb1YGt9fe7kFrHAD3fHHDp1lj5SLxDVHuF4DGa2H2vQlUlwBDYrMKlkjJUADufJfBm0Lm4HA=
Received: from CH0PR04CA0091.namprd04.prod.outlook.com (2603:10b6:610:75::6)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 14:55:18 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::49) by CH0PR04CA0091.outlook.office365.com
 (2603:10b6:610:75::6) with Microsoft SMTP Server (version=TLS1_3,
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
Date: Tue, 15 Apr 2025 14:55:07 +0000
Subject: [PATCH v3 12/17] x86/mce: Unify AMD THR handler with MCA Polling
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-12-8ffd9eb4aa56@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d2c771-de30-48bc-b625-08dd7c2d89a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWtpMzYybGdyaGNnNnY5UElNd3ZJeHEySXk2Vk1BSlA3TW10TnIyQUJ2bnpL?=
 =?utf-8?B?MUdOeWVRN2VxSXhYSTdkQjBWQk9aNG5zL0tqbDcrV09yUDdpVlgxdDZKb0VT?=
 =?utf-8?B?ZUl4aGVOcXA3ZFJGS3hucVNoRm9jN3pOdXBQMTREekpKR2VhYUJ0QnVBOFVF?=
 =?utf-8?B?bmtIV0M1UG5DdEJaNXNTenFLb3dodno2VGtuMXIyVGpoN1hnV2VmbUlDTHc2?=
 =?utf-8?B?TUMwUjNqZDQ2R2VKZ1Fic2Rib1YxQ05lQ1FrVXRaTWozU01KUTg4UXdHUmhM?=
 =?utf-8?B?dERmdzN5UURHSkRuVDNueXNyMFBpWE81YmRHeWJJbjgzT0x4dlRldWk0elcw?=
 =?utf-8?B?T0dFdVZINWpENHphTVBEd2EybDF3Ry91d3BpQTlxU0F0V2tpN2h0eUtUbDhE?=
 =?utf-8?B?QnJuV3hFbmE5R1R6dCtjSEVXNHVFc0FVeW1jbnJVVHpoN1d4YXQxRE00QjQ0?=
 =?utf-8?B?S2VrYk9EWFZuVmo0bnNIclVISjM2MmZ4QlFiS1o5eERtbFNQNHlBNE45d0h3?=
 =?utf-8?B?Y0xFeG5nK04vVnplSjNISWExdDJveFJoMk1jYXhLazhzTU4zUmRvN2NvYXNv?=
 =?utf-8?B?K1J0NjhZNGpzbnY2MTFUV0dpKzZYVUd6cnNmc3FXZnFpZWVZNURRbFQvejFw?=
 =?utf-8?B?eUR5MFpUZjFWN1BibmRjRnE4UGpkNm1hRDJrcTlXY1pxMUd4aUNlWHFtb1Vj?=
 =?utf-8?B?VG1DdXdGMFRoNVlZQVprbENRajhaTWFIOWRWRU5LdkZ0K0Frajh1d1drR05R?=
 =?utf-8?B?ckVhVUx4d0hPcDF1MHJ3VnNZLzR6MkV3amNMRTB5Qmw2TU43bVpFZFIyK0cr?=
 =?utf-8?B?Q09md244ZDJ4MEh6VE9QL0JwZGtDanE2dC9Xb1VkYVAvSmhvOU5CcVI0UTV3?=
 =?utf-8?B?RCt6aTFpeXJFTmdiYmlUTkhFQ0ViUlBmeFBQNDVub09GMnUxVGNjMTlZQmt1?=
 =?utf-8?B?WGJoUjdlSFN6aUFETTQ1a24yeWtSU3lxc3FTWXJBRHFkd1ZnZ29aSytFRnVX?=
 =?utf-8?B?dk1MZENFU08xR0dnZmpheXVOaTkvWUFHNDI0aXhoQzYyLzJzVjNGM0xFcFlS?=
 =?utf-8?B?WE9qanl5NTFENkU1UE5ORHRjTDhpcGtCVDVlMENYdXVvRHNzS1laVmRXejQ2?=
 =?utf-8?B?SXFUNy92a3NHK01aMzJBUUJIbnd3aFY1U0pVemg4dElPOWRCQlgxaWtaWUU4?=
 =?utf-8?B?WXBBZ2I4ejJXMS9jK1pNakdNSHdRdjRHTEdPQTVBSnBKd0hHQzlqQU5SbkhJ?=
 =?utf-8?B?K1U1NHc5emVVRjJ6VUQwN2xOY2oyVW92REhxNXY4eEFmdnNUSmhzT1VhMFhW?=
 =?utf-8?B?YlhWZExRM05lVCszV0Z0NVd4dExzdk5XMDZ2L2FLckZMcTFsQkViRnhHeW05?=
 =?utf-8?B?dHBKd1RVd3hRYy9icytxS2FmemFwclN6Z3EzSU1tQmxUY1F4amNwNHJrMU5q?=
 =?utf-8?B?eXFOWWpxdFFTMFlaZXNacE5jVU1kWnQ3Q2ZmVjh3RHlOOURsN2U3c1BlcExt?=
 =?utf-8?B?RzFHUm02MjFLQXFJU1JCMzR1Mm85OUFHMWV2UHlJcjJESHlSdEVBeGFOVXlk?=
 =?utf-8?B?YnIzYkUrUU94T3lWSWdmSzBISFd6RFFMb1RKa2JsL0xqUGxBOG85b2FMNE1v?=
 =?utf-8?B?ZFFmWGtiaHFrZmdXUUhSL0xCaXFXaXFwUEJFRWcxU3dzZUN1V1VUMDF3S1U0?=
 =?utf-8?B?YnBNRGliaEx1cnlTRDNZdERCUlR1bi9XZXpCcVhoUkhXRHhHRjhHK2hoaS95?=
 =?utf-8?B?N0hCMlk0T2l6K0pIeDJMSkFxbytMdVY2WjJOdU9wMGYzZ0liNFhxdktuQlJ6?=
 =?utf-8?B?SSt2UjI5blR0ZmRIQXpzQS9yZlMvSmluaWIwOUNYcGNJVTQwT0Q2TTZGL1dp?=
 =?utf-8?B?TWJkaURQYThiUXlTWVhkNUVBQlk0eDlQWmxJME5pYzd1WnUyWGhta242dFo5?=
 =?utf-8?B?RnZxSFoxSUZWcC9ZTW02ZUN1T2ZNeXVRS1laUW14alg1ZFllbkJUSnpXUjI5?=
 =?utf-8?B?Z1hPaVU0a0tyanRuNE51VlpDdGNtWEd3MHRFcVh4QWpjL2U1Nkk4SEU1dHp2?=
 =?utf-8?B?OTJyNUV3RzgzZnc3TGJ5ZzcyaVUwMzFEWEUvQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:18.0761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d2c771-de30-48bc-b625-08dd7c2d89a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709

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
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-12-3636547fe05f@amd.com
    
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
index 6a69cac36c18..f8755a21fd48 100644
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
index c82c9e435066..de85b014653f 100644
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
index 87b69935d57d..aeb0a998f553 100644
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
 static inline void mce_smca_cpu_init(void) {}
 #endif

-- 
2.49.0


