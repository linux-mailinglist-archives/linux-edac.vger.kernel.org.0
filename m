Return-Path: <linux-edac+bounces-3072-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A02A34AE5
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1070118808E3
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D972266196;
	Thu, 13 Feb 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uXOXgWYo"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7F24A075;
	Thu, 13 Feb 2025 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465208; cv=fail; b=qgQGrCpaTqDIfAiTbD2pRlBXJ/D6q0CFP7XEyZDoy0nymlZ206D6d2wVZI5lAzE0Y8SU4LZMcZDSnKueBJI8gboInY7xNLeckZ6lLzTuYML0Ej896njPFJbyGRwLkbxuUgJNLEIeddl5jNLHmoxZvH1NPKvpE9wE27m767OL7vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465208; c=relaxed/simple;
	bh=ndg5gUCA7LezAA4vxZ/Hf95pHu1Exs2EVHhKZGuXdtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QIRh+B9XLmu1N/APX1fzj/vgMIBrBl62vZHOzFwZsq3jK3ZT5yyh7bM6mP7H7jZqQtPI8DmrTGQt6ULSyL6yZCs5kYMIzaXCLZXqz1M0fBq96yjHQptEFEHNinjWftJ4HXAl+EtmMuO5vnx2FLtQWR5u7v8uhT3WPjIlAipopGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uXOXgWYo; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiqY0G44jU/0qZrtnQYhcOUiPmJ+AJkTZ9EFz5ZMoCptIUXrRcPZe7vXE33688VPjKC7F2RRW9HL6OGvoYOh7mmIF0aQ/L8IYjKUodicvHDSwVUbmWnpZGsFeEXu/CtyD8jcRowNb75ioM2iwXOyfIoOCSmFqRjkVb8iVN45KxVUkwhNjqNRNQ+RhMLLD/wdCrg9iUaZXigRPtguX8dEZz+XW4+mLuX1RzsrDQl8yM3Xtqzzy23P6S+3mX4+u0ANBf4Bcgh9mJeoVK+BGWnUq7P+9drrRS4NRIsroIkqjUWWeZqi/JaIwYP1fcUUNQWiLKVE1JB7MH9eQeuoUdygbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=midfnS3OPp6vKmRVTdbEciTeZ8yexJcmmKNRM9NOnLA=;
 b=FuIz+KzUyTBmZAR4nELmxxruK24itytkwF1u8nGLtRVboG3O9grrot7+8mMoQlYtePLkQbCBBKGa0jTyhZsqpsNy+3qRNzkJmdkziZ+IxC/jamQIs/6+paftYZ6giBz7veqEBkM9B0FnrvFfewxJsXI00PoOXrUovu5Khf+YKK7X6f4lwtAuwySeAgsFvbGCyeZsIe5zIapiNajB4/33er4h3S48q8C1xxJU8hmT73y6ML7xE7Z66wFuRkMSPbbf282kRcI/zo6iDw7brfAQrYoC89oPaQLhPmw6k/EUeLOM2S5XT1e7grFbrxKN+OMZyBbtKksLCAvfJWbZigNBYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=midfnS3OPp6vKmRVTdbEciTeZ8yexJcmmKNRM9NOnLA=;
 b=uXOXgWYovmfNtxihCUWgBSbrsWWxMs7GKThOLrJWi/x1hRmhHwp9jAeJR1Y8yR3OziQrqvY4aMxD4iFLly15sMIMeRDICQQEKs7uG7Gm/dNO22KUrTtqcuvuhwMJzkPjbZ4ZRzPCZ8HZShEukP1rQiQYYLgyHxnFp8qVRXBFwK4=
Received: from DM6PR11CA0027.namprd11.prod.outlook.com (2603:10b6:5:190::40)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.23; Thu, 13 Feb
 2025 16:46:38 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::b1) by DM6PR11CA0027.outlook.office365.com
 (2603:10b6:5:190::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Thu,
 13 Feb 2025 16:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:37 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:32 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:46:05 +0000
Subject: [PATCH v2 16/16] x86/mce: Handle AMD threshold interrupt storms
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-16-3636547fe05f@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 360b5e74-89c1-44b5-2362-08dd4c4dfbf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0h5b3pXakN2WEJxZGxkcFRMZWFJc2VoNFJ1b2MvbWZYVDdoMWZxZjhsUXVY?=
 =?utf-8?B?OWxzaUNhN25ha0xvNnplbDhkOXpYT0RWdVMrSVg3RS81U25QRmNENmRqNjVp?=
 =?utf-8?B?RVVFVU5WWVNMNEFQRmRwYnVvRldkT3ZYb0VxNDlwUlhGN201RjMwMVRFaDUy?=
 =?utf-8?B?K29nYmdnZ0t6VDRkNGlZOEFKSVd3c0IvaXByWUtybUFqQWFaaWs1bUdQaFlv?=
 =?utf-8?B?c3grLzN5cDVWVTZURUhhZkJxZXQxS0tXaytVNGIxSFVtSTRzQjFBRnErUCsw?=
 =?utf-8?B?S1hKaTNaVmZwVHJwSFhjUkI1SzRQZklGZW9EeHF0U1pORGt4NHA0bDgwN1Iv?=
 =?utf-8?B?SlZTL1VFYjNFWE9IcS9Kc2JYQzc3bWdWeExRNTExNXQybXdaWjZFVTJvYm1i?=
 =?utf-8?B?MDljMTZ3RlBYVkdheHlRcmtSLzlScE55TEJGNlowQ09XWEgyYjdSb29STHlx?=
 =?utf-8?B?L2V2T1BYOUpxSVAvanJZeWhxY2g2dEpFSmYzRU1DaitRLzBRTmd6c01xY1V1?=
 =?utf-8?B?WFh2Q21aL3R4eVo1OER6RW0zS1VlNnh4Qm1zT1ZrY0VEaVd1amR6TmJuNnNP?=
 =?utf-8?B?QmJVc05PcEQ1bWtydVoxR29SNE01NVNFWCtBanlXbnVTMG5Wamo5YVZtcTVa?=
 =?utf-8?B?Tkw4NFRvUFV3M2dVN0NJanJwMEo4M0Z0NVBUVFZDZWVBNDYxZHplczdsTVRC?=
 =?utf-8?B?UGs1MXowMXdCV1pMMWUwWkRRN2hIU3JCaGxyb3VwU0tZMzVnQTd4S2V4NHFs?=
 =?utf-8?B?RHJBKzRVVW5WRXlxUFNhVHptL2dnb1doWEtubE41b29jT2JSaW5LUVZiQ3JW?=
 =?utf-8?B?L3NCMkZqQlB5eS9tdWplOHJOeHdMS1ExVXJjZGphM0YyRG40UitzN3pyVVM1?=
 =?utf-8?B?NzVuYkg3QU1VTE5SWnlhMkx3c0hXellRS0Q1WUhwSGFTQUNjcm5OKzlrQlhX?=
 =?utf-8?B?eVlkWFQ2VDFOL3NjZmxQbnJPWE56WW1lb2M2b01LcFhNZDF4U1IxcndyWmk2?=
 =?utf-8?B?RVBjQno5c0lhWFgrNHYvdmFid01hTEdLZENpZE5XTVV3RTdsVTYwZnZrYjlx?=
 =?utf-8?B?ZmxYTU1lTXBvSWc4bjJsaWRvN2JhRkQ2Um43NDRMNXhqSjhVNWFMMUcxVFFa?=
 =?utf-8?B?QjYxRE8xTW5OVWlFemhtRm1DeUR4M2ErMHJSNkoxVDYxY2lYMWExUVAvYzQ0?=
 =?utf-8?B?QitkYStnU3JtamRUVDl1M1ZvR2hLeUVPVnFJWTczSitGVHRnQm5LeUFxSU1u?=
 =?utf-8?B?ZDRXUE9wQTdCTXp6QzZaNlZrNWl0VmZqeUdYTGE2M0N1Z2tsTmxxOVdiQmRH?=
 =?utf-8?B?bmZ4ZEtoMU1BdUxsZ1hpU0lMWWR3NTluc0hNaVZocWNRV1BMNUdJbE95aG5X?=
 =?utf-8?B?c0R3R1AwRHdVRE8xVEx1Z01KNU5BQ0RNbjdKZnRobHBBTHB6cmpJNFBha0Qr?=
 =?utf-8?B?NDdJYlluL05pY3FDVTY1ak9CUmFkRXRkYWEyUEUvRTlFUXRJKy9uT3ppcTY4?=
 =?utf-8?B?VWt5OWZmNGtXejJBeVh4ZlliZUJyeG9LekxadXZYeXloWnpFMnBoS2hYNHJm?=
 =?utf-8?B?WW0wQ3ZpYkF1Y1NhUUN0YmNWZjJGUi9tb1Y1L3ZodnNxU2dBUzJIU3k1ZnZq?=
 =?utf-8?B?bVJPR3NzaWZRUEtabERQbThYMmx5eWloaEhKR0djSit6MHd6RXh5bWRDbGdR?=
 =?utf-8?B?WWpRdEEyY1o2NjFGcTZpZ3RYdXdYWk9rdmRqQytsZGJLa1c0eFZRMzR0Y094?=
 =?utf-8?B?aElDcG56cm5GV3hCL0pHU05zOEhNQ2ZCSlYzN1J3S3o0UkltcVpCNWwra1RM?=
 =?utf-8?B?UmsvYVF6Zzgra3VsR3dFQUwyNmtEMlhtMzQ3VmRBQkVxYW9ENU5ZRE1Jck1q?=
 =?utf-8?B?SXB3TnIzSzVBbFV2QVFaQzFYVjFTeTk3MjFuQVE1RGJUWHV3ZXozejV3VXZn?=
 =?utf-8?B?dDhwZnU3cWRHNUdySXF2cWxJMlhRL1pkdDg4bDdEU3pHUlB0K2UrSk05cjJm?=
 =?utf-8?Q?l2ji6dHWCRCtci3hKYuTgUmbyRbN2M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:37.8724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360b5e74-89c1-44b5-2362-08dd4c4dfbf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553

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

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20230616182744.17632-4-tony.luck@intel.com
    
    v1->v2:
    * New in v2, but based on older patch.
    * Rebased on current set and simplified.
    * Kept old tags.

 arch/x86/kernel/cpu/mce/amd.c       | 18 ++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h  |  2 ++
 arch/x86/kernel/cpu/mce/threshold.c |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 404e0c38f9d8..a2d02f0c2153 100644
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
index fe519acfafcf..9d771db2bcae 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -266,6 +266,7 @@ void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
 void mce_threshold_create_device(unsigned int cpu);
+void mce_amd_handle_storm(unsigned int bank, bool on);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
 void amd_reset_thr_limit(unsigned int bank);
@@ -297,6 +298,7 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 void mce_smca_cpu_init(void);
 #else
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
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
2.43.0


