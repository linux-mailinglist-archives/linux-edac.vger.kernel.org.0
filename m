Return-Path: <linux-edac+bounces-3552-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA73A8A20C
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9072F440DCD
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694C92BE0E0;
	Tue, 15 Apr 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OGSKj1Cg"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE5D29E069;
	Tue, 15 Apr 2025 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728924; cv=fail; b=BkEa+ZXoceEe7ZnkcjAG1eXoXvhPeJsiatQYWMgzcfbHcIu62IVGTYr2N+08TQu0qneVkrANe9wRVjENZ74zjNgy+LO33Ntk4VLbOYOtR4ezc7ygN3g8iBhYQXAfMF09bBW/hnRg9emHhWQQk0I7dflSa1zPV8kj4Tq4NPihKcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728924; c=relaxed/simple;
	bh=n4vmuYjdff+82gTEjdA6F6dNloMy1UuXsOZjBCDko3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=r55TroxoytiZGuhKHwaR7ReLcSTX+HJrYswsYaWUA8jkjO0JZwunh7TYgdbs2QJCWo+Ybvh3U1LYBPaIpUaEe1fmzsC72Tx7C8nXmrPkxjhziNFILJqE1SBVn72JOha9daQL+BvGJs1etgqUHvjxKZI7fuyVnwMHxmIamLaXyb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OGSKj1Cg; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhpYhoH2j3uzfBDZ/JAhysh40EGaJNvqYG1P8DkEONWMSo3153TrtQU5nrZqDEDrj4BYgtyGJ5PyhoqyllYhAahm/XPeFR6q42rUFoxXhlj7tA0ynBZaR+lltpA18SawelSuHZd9S9YdP7aOl4gS5x+/VeoFpi9XGWJqZFsf+6Ojz9ZVUrQXvY3D4VN44iDj86DXym81jNNd/6VJxnsvdD70ChJgFKA0gtIHdqQBY83m2nYAU1Xk2I689y3HcJb1IBxjZ5rjtHhwegsQnc1iR8CPUkwkw6j+7+HxB6j5dc8fDr0F2UttBi30YfQ6pzlTScZ0BHi0yeh8RshQTzZyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DVc4mv7ZVPyB1Ds3uYXzNc7nH/mObse9z+Nd6MNgVU=;
 b=LM//U3Qqz6dgnfag4uNbul2iWkarJOUoNhncpvssEK4/ZsQAzVMu6ukkyiu6ploUYVjM8xNxpeWbHXHGdgZA7SufCBba8CSOWrCpTmV74K7llH8FKdgsvchw7wE6sDJZyXnBJTjpzYD+e6znNwrXUg16SwZp3nvsXXv5KHfk3dbOtvpNiQp1GPqN1Qo4xQCWCjvdjBj4kaQ59XvLMP6b0TZXXnm+9mHE2NeHcXIoqjfr0WOVU2682YkUmeyJi04GUs4myvDld/jebuU8hlHjFuJQwZYYgQ5gSqS+kJJoUE/CMV0AytV1tYR/u3HZMdY7Fpe08noDrbsOiR6+2foY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DVc4mv7ZVPyB1Ds3uYXzNc7nH/mObse9z+Nd6MNgVU=;
 b=OGSKj1Cg7UcMAiOQZrvnnPmXzMM27cb2RdqgkwuIxlwM8+cVXsrPzJ12G1ZYH4JS2kr+yB6H3q3h1cJnob2R5ovvEQFUwfa4px12Ya+MrLazSp7GrQk/9A7brhQrSpYKkgPAXSR/jwhZKmnqYLV33V+LgvmIVykhRlw5HzSwK5Q=
Received: from CH0PR04CA0096.namprd04.prod.outlook.com (2603:10b6:610:75::11)
 by CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Tue, 15 Apr
 2025 14:55:19 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::21) by CH0PR04CA0096.outlook.office365.com
 (2603:10b6:610:75::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 14:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:19 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:17 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:55:11 +0000
Subject: [PATCH v3 16/17] x86/mce: Handle AMD threshold interrupt storms
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-16-8ffd9eb4aa56@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 4905a765-44fa-470c-600d-08dd7c2d8a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1M0NGpGYzhrcHJsZ0tZaWlHTTFIaVpudkd3cUJ5NzJ5YVh1aERCNTRNSVBa?=
 =?utf-8?B?Q1ZTWmF0bkc2WGt3cUVrTUNacjlOU2NyQmkxbjZ6NWthN2hFWU1reXdPN3gx?=
 =?utf-8?B?TENiUDY1UWg0TmE1bFpld0ZvaXVUbVZaaCtwZmhOSWFuenAza0F3YTlFZXNZ?=
 =?utf-8?B?K3U4bXFPZTFJeFlRbS9Wa3pqYzZhREZuZkJETjE1SVlvVXArOVViQmhwWS9k?=
 =?utf-8?B?eFZ2eFFWWGtaU2Z4L29rTUd4anBxQy85VTk4U0UyVkdlUXNVM3lvNDFCWDUy?=
 =?utf-8?B?V0tLSkVPYXRxSlJJOFYvTVNIa3loVlN3bTBseW5FSjNjZ29kRHpIMEpPVERk?=
 =?utf-8?B?MU5PNERqY3p5ZXJoaksvRFU3SkFhclExQjJkZjNYaXRHRDNZdis5NzZ3eFVs?=
 =?utf-8?B?RnJPc1NGREIzb0tGVVFpbXNtWkZFa3VMZVJkWmgrSFlQMXZCL2xPWlNheGxp?=
 =?utf-8?B?UlBHTzF0SVRWYWFUV0M5eW4vUFlHTXF5WWpzVEdYQWFiR2FXYVEra2drVXlH?=
 =?utf-8?B?djNYcDJpK211cDU5cHMxWkZLclRjWlhCZEs2SFZ6RFQyOEtvUFk0RGhTVnQ1?=
 =?utf-8?B?Y1c2WkhHV1NzSmM0d05kMVd4Q2FpZGd5QTFhZUFhbUo1T2NybUtuQ3NlTVN6?=
 =?utf-8?B?WDYwOG9SN2R5RzhpODVNZloxZFBYNjIrTHduRm1tYzRaOUZZa3RaU2l5dFZ2?=
 =?utf-8?B?YkpKRGlleFJEeGxsbCtZVG5VRjd2aHVqaWhCZDRNOVIzVHkvNkM1WThnSDQx?=
 =?utf-8?B?Q0U0STZSck1wNEJDeEk0S0xZUGp1TUJjd0hFN2hJWDJqOWtqblhEWW9icksx?=
 =?utf-8?B?T1IxZFQ2RHFtTWNSSVdyc2VFQkVxV3JhR2ovR0IxZ0FSL2RBZnhqYXBVNGI5?=
 =?utf-8?B?Nk9hTUE2R3U1MzVUTDBCQ3V2YmNtNjRSVXVYQ2t6ckFaNndiT2RrVlY0cDY2?=
 =?utf-8?B?WlcySlIrMDE2cTdFOUs1Q0haYVRVSHZUSEJnM0ppa2RTUm5CaDByWFkyQXZ1?=
 =?utf-8?B?Q2h6TXNGOHVuNHlQZDV1NGF0YjluTWcvTUIzTWsxRXBKT04rV2g4K29kNENQ?=
 =?utf-8?B?TGtFQzNWTElCNENqUS9hRHRZTHUxV3hIL1RmVnNOYTVlRWFTNVc3a1dxRGc0?=
 =?utf-8?B?VVJJdklvM2VVRHNEaEczbWk4R3M4KzQ3ZWNiNWZGQUwwaDQzbzY5dkoyOWdY?=
 =?utf-8?B?aVdUWGhpT3pTY3V4L1RPVGE1eVoralEzNHBIeXpkVE5aRjViNzFrdTVCVkZr?=
 =?utf-8?B?M2J1dXo5T2owNnpZZ2tnTWk1ZzBON1V3RGdmWFNYVVVZYzlpMkpXN0MyVTZH?=
 =?utf-8?B?Tm0ydU96a0gwcjdEOUNucmVPMjJCcTQ0ZnVvZXQvVEFTaStsaUsyU2c4UWw0?=
 =?utf-8?B?TnV3OGg2MGJ1aC9ZaHo5VTE5OStUL0VSUVR1MUhMbHNSclBlbVFiLzYyUXE2?=
 =?utf-8?B?blFvR1oyc294N09NV2lycktUTktGUUZ5bURTZ3lXV3VQT3cwMFhtbWNrQld6?=
 =?utf-8?B?WHVhd3dPLzdmZTRScHA0dThnZXF5TFRCaWNJczhBNlpsR2hmN1JUOVRxa281?=
 =?utf-8?B?UTl2L3NjRWQrYTRqR2R0dEhHU1Ayd0MrWjhjbUJVeWU3RDFYOHhpUWpQd2V0?=
 =?utf-8?B?aEh0Ymh5U2ZFVWVENDVsOUJ4RGQrVEwyR2FlSlYrb0t0RC9sVm5mK3dvazZx?=
 =?utf-8?B?VWd1TTJzVUYxaHpxM0JzS083b0k5bkRzYmxHMHdoSW9vcE5LZ0tqQ1JkZFFt?=
 =?utf-8?B?Mk13ZSt1RlA3N1JxL3BGcHZuaVpDbVdUb0NSWjZ3elI2cFFSN1ZQb01XVEwv?=
 =?utf-8?B?V0pNajBpbDQwUnM1ejVRS1ZjVkVwQ05Eb2JQODhMQmM3bkZ1K0VpTEF6ODFn?=
 =?utf-8?B?RXhiVVVNMEptQ1FPNWxHTllmYUxVOVcwaFhvYnBSUk9tVmNOYWJYdVAzNzVV?=
 =?utf-8?B?N3VycHNnRk9OOERweDdSUzB5L2FmMkw4cVNzTHBXS0NpNHZVdVFndTNtSnBo?=
 =?utf-8?B?VzNqY2xxUld3QU5PZnJ5a1d4WWRJV2JVZkpna2xobThaVUNEcC9VNEE2WGNP?=
 =?utf-8?B?K0tpa09Fa3JOc1RMR3VDdFpEMUluMmdOOU1Vdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:19.2011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4905a765-44fa-470c-600d-08dd7c2d8a54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274

From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Extend the logic of handling CMCI storms to AMD threshold interrupts.

Rely on the similar approach as of Intel's CMCI to mitigate storms per
CPU and per bank. But, unlike CMCI, do not set thresholds and reduce
interrupt rate on a storm. Rather, disable the interrupt on the
corresponding CPU and bank. Re-enable back the interrupts if enough
consecutive polls of the bank show no corrected errors (30, as
programmed by Intel).

Turning off the threshold interrupts would be a better solution on AMD
systems as other error severities will still be handled even if the
threshold interrupts are disabled.

[Tony: Small tweak because mce_handle_storm() isn't a pointer now]
[Yazen: Rebase and simplify]

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-16-3636547fe05f@amd.com
    
    v2->v3:
    * Add tag from Qiuxu.
    
    v1->v2:
    * New in v2, but based on older patch.
    * Rebased on current set and simplified.
    * Kept old tags.

 arch/x86/kernel/cpu/mce/amd.c       | 18 ++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h  |  2 ++
 arch/x86/kernel/cpu/mce/threshold.c |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d76a64c47a6d..93f6cececad4 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1218,3 +1218,21 @@ void mce_threshold_create_device(unsigned int cpu)
 		mce_threshold_vector = amd_threshold_interrupt;
 	return;
 }
+
+void mce_amd_handle_storm(unsigned int bank, bool on)
+{
+	struct threshold_bank **thr_banks = this_cpu_read(threshold_banks);
+	struct threshold_block *block, *tmp;
+	struct thresh_restart tr;
+
+	if (!thr_banks || !thr_banks[bank])
+		return;
+
+	memset(&tr, 0, sizeof(tr));
+
+	list_for_each_entry_safe(block, tmp, &thr_banks[bank]->miscj, miscj) {
+		tr.b = block;
+		tr.b->interrupt_enable = on;
+		threshold_restart_bank(&tr);
+	}
+}
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index aeb0a998f553..0dd77fa18d06 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -267,6 +267,7 @@ void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 void mce_threshold_create_device(unsigned int cpu);
 void mce_threshold_remove_device(unsigned int cpu);
+void mce_amd_handle_storm(unsigned int bank, bool on);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
 void amd_reset_thr_limit(unsigned int bank);
@@ -299,6 +300,7 @@ void mce_smca_cpu_init(void);
 #else
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
+static inline void mce_amd_handle_storm(unsigned int bank, bool on)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void amd_reset_thr_limit(unsigned int bank) { }
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index f4a007616468..45144598ec74 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -63,6 +63,9 @@ static void mce_handle_storm(unsigned int bank, bool on)
 	case X86_VENDOR_INTEL:
 		mce_intel_handle_storm(bank, on);
 		break;
+	case X86_VENDOR_AMD:
+		mce_amd_handle_storm(bank, on);
+		break;
 	}
 }
 

-- 
2.49.0


