Return-Path: <linux-edac+bounces-4236-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151BAE688C
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00C36A2DC0
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9B12E336F;
	Tue, 24 Jun 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S1u6+AO2"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080B2DFF19;
	Tue, 24 Jun 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774607; cv=fail; b=K0A9/g5nmqx5D4Q6DoKLu5CDvKSM4sJ5pXTveWjWHZm75N7CczKzX9LBUrsj7oFrucVVtNPOGkGC6CGSublF/YTfei3K2+bIHdfyqGJbSkp0iy5M6HsQi6OYSq56azxY1v9QnMJgUOpbpKhouivSMC7eGGk+O1n6y77yzHJimGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774607; c=relaxed/simple;
	bh=8eeso9hIb2jmdDMdjbEne7zVRy4omlRlLaUcb8dUlEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aaHlOZFrNQV+xWymN4dL9LM2vy5+fq1YsMmFkb/HBFtikKq7NIRJXL4BHBQ4/PORbEvI+ygD4ypVfa/kJnVYuA7SQ0gGnpojyv8aLkzjOvEdi4rnohVr97wpjMFWc7COeQu1VdZwaesdXOkL9ZcIHQ6gRRmx+RlzA6L+d9OzymQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S1u6+AO2; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1Hc6IX5JpCQ2iuJrmBTlvf/2k1pGupAYtmGa2P8L01D8nL5EyTM7q6CLzyZ9TF47VYVhu63NqlzJfar48K69+DxkoxrcAkPW8hM0FchpnkIHY1Y7pWbm8fDKaVdu2t+dOxo2xCTDpzo9+vw74GZt7Mymqv+OTLzJQHBhUkIVqgOiaiUrQuYNNJU5VVXXVUI8kmoZAMlMlrr4Hf3YX2n/nMjrMBhvF9YtyUbqJo35SQqF2nnBiwBBTnLTd1G8B+UzJKIUHPNOPRahpPg9xJ596+veQo8d7j9FWug0lC/eu7Fa2yQ37bTwcIKG+aaBD6YL9YGi8qxKSThfD2RCsOsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFiu4W7ftl5yFuB97zTetpeFeUZ4GK8Ps+x1K/va9h4=;
 b=MlyyOPcZnM4rvaqp62WtVItN4M5kNkh16wyhmHuzNK/MV4Qr6wPOnzEAWSxiAozC1dKHpHFE9n/TtAfXdf8Glnj6urWeT53kqy2DkFD4hhemAlUk21SbvRb8RSTB9gvBl7kkUw4zez0bHsW3qIRrC+aZVlZU+vX67kYW+xW4nQlR4uNIQd/r09gnQnAbS1CjHXfBy26S4Fzl40tg8Lf8UYqFt4TX027Xhw795yESaxgPIaaKoIgMpEmSQbH2WabosMo+qh9XoLi4tuUmfqhVvJZRT3XgLl9Nc0BV4+OfNecvFXx5A5hgMg466oD701DZHMS2EGmLKgiMI6ZjZ3B7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFiu4W7ftl5yFuB97zTetpeFeUZ4GK8Ps+x1K/va9h4=;
 b=S1u6+AO2OmjN9iZS8BWqiXu/4A5fanJewF5f++MfqyWX0z3gMgqBwAS6tbuYApBStRQE4orujnAqbiCumvhPezPt/pFNoX6MjPDeCSNz7444B/vX59X8uDv3V9vOu07P+P77CdwjnoSIWqFcNWJbF1K+GsSgImYiVdTvm94hVJE=
Received: from BYAPR05CA0064.namprd05.prod.outlook.com (2603:10b6:a03:74::41)
 by IA0PPF44635DB8D.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Tue, 24 Jun
 2025 14:16:39 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::88) by BYAPR05CA0064.outlook.office365.com
 (2603:10b6:a03:74::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Tue,
 24 Jun 2025 14:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:39 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:35 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:11 +0000
Subject: [PATCH v4 16/22] x86/mce: Unify AMD THR handler with MCA Polling
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-16-236dd74f645f@amd.com>
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
In-Reply-To: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|IA0PPF44635DB8D:EE_
X-MS-Office365-Filtering-Correlation-Id: b1bb30c3-58e3-4d1c-04c0-08ddb329bc73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDI1QjBaUzc5K1RaSjVHZVlQN3hzb0d0MWtLaHVvRHJCQllCNTdTTVBQYnZ3?=
 =?utf-8?B?ZC9lSGJoN2FQRXlmZWdRV1ZHUTlleXJjbHZmanQxVUFraTdsUnNXdXhndWdD?=
 =?utf-8?B?cUdUUmhBZ1FnNnNvamdlV0tsZHI5V3p0d281YXdmVllRVkZHdWpiNkgrM2dn?=
 =?utf-8?B?eWU1MTZ3OTlSK1RTRzJEVXp0SWcrNktSYllESXJYYjk0RWtrcWpxcDZBeXlS?=
 =?utf-8?B?V2pReEdlOXNnV2I2cmV1NXpGMndqZndaQlNrcklCblBFZk55eCtibTFraDJx?=
 =?utf-8?B?TnZsMXFVaEtzM2FtL0VSK0tjSXQ2bDJaR0lLL1BCRzZoV2FTVnBSakJMYWt1?=
 =?utf-8?B?WjIzcDV0N1ZMNmw3VVdFSklpRUg1NmhFdTIrMnN0d3RjSnFjbU1oTWFWaWxU?=
 =?utf-8?B?VVYzdXFqL29ZbzkvMWRteEROajh2MWhTUFp4TGc1cUxuM1RkSUhIaDlaSEpq?=
 =?utf-8?B?djlnb3hYU1ptdkVtb0FIUmpyU2grUE5zUDJFUENvODFaWXZpTSsrYU5jajcy?=
 =?utf-8?B?OENjeWpkTjNaSy9vSVQwZTU4ZksxdmFHUERIdnhHWnJrYlFRR0phZll3TkdJ?=
 =?utf-8?B?RUNZVlRmejRnakFSQ25VSmNoZktvTm44OE52YmtWL3VrYkEyMVl3NTZmcTNC?=
 =?utf-8?B?TnJxQjI3MTNscHR1cGd6UGk0c1Z5d1NoU2ZURnRkK3ZKdUcySWgxckluajVz?=
 =?utf-8?B?ai9iY1pyRXg2dHZxd1N3Qmdqa1pVME5aTlpXRGd0elQyZ0wwdE1VMWVucytF?=
 =?utf-8?B?MndlRE8zK21oWVF5SWxkZzJOOTR2ODFPT0xGSzlSSnR5dkcvTE1zcjM3UUFm?=
 =?utf-8?B?WDVEVjVEc2pRY1V4NXdBVVk4U0FyTDQ0QWJWMWo3dzV4WXFXVHlhMzBmZ0lU?=
 =?utf-8?B?YXRaaEtYVEl2dExhdkhmb2hpcXo0dEl6UDZ5ajBuQ2kxRDZ0UlptWGpXMXhY?=
 =?utf-8?B?REFPQzFuQnRSRVJ5bmdXMzhzUXlhRnZ4ajJIUFdiMm1UTXg3dHloNE9uYzdC?=
 =?utf-8?B?b2FteGYwd013U1k5V1lEN0d2ZElQWFZTMHlrYzM2ajFSZXYxNTJzQytIQjdy?=
 =?utf-8?B?c0xhYnZObXFqUkVod00zOTQwUkh3M0tBSUxnWUxsNjdYd0lWL0VRM0laakZJ?=
 =?utf-8?B?dUV4ajFnL1FFcndQY0U5Mk9lK3FnNWxDclN6L1BOOHFkdzRrME8rQ1B3dVhR?=
 =?utf-8?B?aE82Sk9tUXd1Zm01UVhFL1AzUG9LVHlPN0JwN3lIVS9UMWdEQ3U0TzdWaGlO?=
 =?utf-8?B?ajRMVFR1bk5lemRZNXE1RkpHM291UHlKUmhRNW5hWmxmQUsyYzF0MjljVHNT?=
 =?utf-8?B?Wi9OQUlPVlBHME9jV3UrRW5GSTlJZzd5Qy8xTDRxTDZZNlhBZlpQSlBGR0M0?=
 =?utf-8?B?eVNkRStDYTNWYVZOTHl2cHF1M204MnFkVkJsSW15a0s1ZFE0bXpIWXhOZ0d3?=
 =?utf-8?B?bnhmQkh3amZsQWQ2Q01HVHBqbG1uaVcwVWJNTGM1UWdCR2NaKzZoVVg3SFZE?=
 =?utf-8?B?SXZwL09sT2RQVGZJeENHcVlvTnJ2T2x5b3NxRGthTkp0R3l0SlZERXB6cnhE?=
 =?utf-8?B?R05lOTk3UkU4VlBUT3dDaVByOGhoWXppd3NCenFUdTBQWDZZY3BFQ2JSTjdR?=
 =?utf-8?B?Tlc5MEJzK20zTFNMQzV5SDFDdnJYN0g4Uk55WWxXNGN4MnJoWHNnVitjZm4z?=
 =?utf-8?B?TUNDTTBnMUt3ZlJ2ZlFvQWkvQlB4akIrc1d4UlBUNDNTQ0RUazVVKytPRlpm?=
 =?utf-8?B?c0Y3M3d2Y3phamdrQi9WUWtLZUFoTCtwNFNNblBIUU1OSVVlZ1ZxZ2x1MVZO?=
 =?utf-8?B?S3VXNHVBdjVJdFFzV1BDcnNESTgxVHpiQWhsK3FJbEdJd09EVXdtTkNITmhV?=
 =?utf-8?B?R1B3YlpJd21iU1NsNlpuV0RWdDVkcDFaSVFMNGZFazRPdHJacHN3OGpKNGp1?=
 =?utf-8?B?NE5HMysvaEZxbndCaURLd1FVbGk5ZmZ1ZnllUXhjblFrUFRQbGpQR013VTVU?=
 =?utf-8?B?QWtmTTU2Mzh6Y3Q2N3hCeEdKRzRuUWFWR2JvaU5JeGRFUlQrdnVmbjlpbzh4?=
 =?utf-8?B?anRVSE4reTBrU242Wm9rMUhFcUJUaE1OVGVDdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:39.1755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bb30c3-58e3-4d1c-04c0-08ddb329bc73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF44635DB8D

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
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-12-8ffd9eb4aa56@amd.com
    
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
index 28dc36cdd137..0c789fa1ae4c 100644
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
@@ -558,6 +564,7 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
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
index bed059c6c808..a0aaf0abd798 100644
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
2.49.0


