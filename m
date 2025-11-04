Return-Path: <linux-edac+bounces-5334-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5789C31B28
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 16:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E1294FC7A0
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F418333423;
	Tue,  4 Nov 2025 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Me8HQGs0"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F6331A49;
	Tue,  4 Nov 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268169; cv=fail; b=NBLsmTD0ZVRT8gO0sPs9oN9jcd/pzi1Yk00wqc1eAW7vKzpGOUqgt1daUtaaG91FAXSkfh7i9MEvQ/X65brlPqIhE6Vs+ef2wv6XX5Q1z/gy9rSTCImAlLQvqqfJiz6MMY92IzGKb5pbqC/zlw8ZAxFJaz5aDqmDvgDmlZKUkHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268169; c=relaxed/simple;
	bh=KC179zWMp7Y1zf2XVqVHCis2TJcJ955LHL04kJ5SIv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fvw/lUZ6BSO/xEOB59P1MJ4MdBl+QLu9MIJWjU2lIoy1kbeobL3Q5FtEiVkiyKBDXhlM9R2vAS1KSv98SRho2HyzNMc91D17fXtcgmqZfnnCIYCzD2SjHlaPhFT+s5ViWMMLfffu0BBEvl+I2ZsQfT9N6/HPNzdAaQe/gMsi57Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Me8HQGs0; arc=fail smtp.client-ip=52.101.52.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoS2L+ttousdNl8W7HigPPxMqerR53O+Af73TL88sW1RyuJrk64hSgQlQWBCc4yZi+98V2CDuPW1fS/hRmm1cCKWlhliSHFWr1LGfjApQRVaC7OlfvItZw14CI64gEForOPMvK8P5CiIy4boIntazhYCU4rCDHk6Wn6wNDdRBJn/5ypVJPgl9PB2NSnuddtzIsxW6xMx8K1ykvY/BPdU0pqs2YMjRNOjgiVZwjXYc8sOlfVpaBmYpAANN1JsOVsVUpEdyhULdrJOW4t4OJUS2uRF2tycTdNb9504ZaScrWLib0MKdu5ml7YsoiPKbeqwF2G7su5MPemhb6/myUsOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETWkDEu1tftNq40qbldxcqb8L5DxqTCYSBTj6budbBU=;
 b=tlOSFhgQyJcBGUMJqwud2MHESZx42FIJlBCd/kTI9g+BweAC3dimL5JhRk8kfg0q/nE8wRXvoPQh5u+KhMeVV7wc+6IKrSSL9FoLBnImMdkVMAQeIpFJ5ultQtCRcWzva1KdZp2KyP9Lq35Xtca3R5nxjc88y7DAMP/mPTtjEt1issbt7+Ns6+NIpqaEs8kSvdyH35s3t1UqU5Rl7qMo/SzjVG1NKi0dVtLmL6/VoUG32jZSKAMSgW/VQxS3EUQ1Fwbzz9QOmmfm2H787htm+W8LvDYT4A+66lJOuJvKH+qJORI6ItgxHm4graLw9E5xU8DZZr+p/1rE9Nv3+zAq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETWkDEu1tftNq40qbldxcqb8L5DxqTCYSBTj6budbBU=;
 b=Me8HQGs0LdClQqsSYE8pYL3NrT8hbhEgGDpIYCBikpbiARD08REhW5Qbdl6OBOBeF3J0QpGpA3S325u/WoRxJRTf1sSp6Zf5bNxSIsZaDiTYVhn75QDQBJMuDg0T+yNcGyV9BMxJk3wdX1Z3uu7Fs1XsbK+UQDelYeNFN/IR85k=
Received: from DM6PR06CA0101.namprd06.prod.outlook.com (2603:10b6:5:336::34)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:56:01 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::2f) by DM6PR06CA0101.outlook.office365.com
 (2603:10b6:5:336::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 14:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:56:00 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 06:55:54 -0800
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 4 Nov 2025 14:55:44 +0000
Subject: [PATCH v8 7/8] x86/mce: Handle AMD threshold interrupt storms
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251104-wip-mca-updates-v8-7-66c8eacf67b9@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: e69cf17c-e83d-4f59-1a7d-08de1bb244da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVZFRHdJUTJlbWJySW81alFzSDlBeFdETElpVGZOcTJ2aUtmRElLamdoMGx5?=
 =?utf-8?B?a0VMazRQeUV0dnUxYy9sWkZybngrUUdseEZxMWpuODJHYmUxZ2RBMm5tZVR2?=
 =?utf-8?B?S3ZYQ3RwTngyY0RYZy9IbzkycERzMU9FbmRGeDRXbk5HaTk1MmY0QTFjWTBm?=
 =?utf-8?B?cVhjNmUzZW9Tci8yYVZxcmxWc2phZmc0WVFLZEpoc0c3Qk5iVkhOMWFCV2ZY?=
 =?utf-8?B?S1FxMnNCMmRHRUxtdFllOEFoeVhQV2hlWkE4L3FmT2tBK3VadXFoK1pVeVdQ?=
 =?utf-8?B?MWRrSERkQ2FndXp3U0JHVTNtRXVuUGlpakZ6UHBMRGdGY0l5OExBV2hwRnBM?=
 =?utf-8?B?VklydmhCcGk2ck1UZG1ZaEJ3d25yaG5mUjNmZ2hxTkZnQzYyQ1NMd0xEQ09w?=
 =?utf-8?B?QXh2aXh1eE1BWTBKY0JaaDI3SDdjQ3Rjd1dnVGdEbUlVYlhNeDVrMUh2TTlO?=
 =?utf-8?B?SVZ4UzB4dVR0WUxEdEhQUjMxd2w1QXdHS0ZhWm5WbmhiUFhhVnN5dkNFWUw2?=
 =?utf-8?B?K2o0Sm9xYXBGMFRyS1BROXRtL245SGd5L1FldUIyOWc3RFMyb0VQdEs4VVAr?=
 =?utf-8?B?TWNFa05CWlNkTUVtSmVkTXlHdW1EQjhLallQeGhwUm1XaWRORC9qSkZTZEpX?=
 =?utf-8?B?V1dFcWNrS0dpd3JqMk01cHVrL0I0TUs3T2hJK054M2VvMUZVV1d2NTFyRC9L?=
 =?utf-8?B?S0hmbDl1VVZVU0FjWTlkeVlLQWloUFRvSzRtK0tQeG16eFArOUV5a01JTGJJ?=
 =?utf-8?B?Qll5Q25HbHFhMGhOby9rTnJ6SDZscVJQYThQWWFRcXVja29oTGR4L2lhR3N4?=
 =?utf-8?B?YkJXZ21pOFZJVkhnUXBScXZPNTVMTFFLL3NqSTJQTnFXRW1UUXZRYjVnLzN5?=
 =?utf-8?B?V25NS0xUN2tMSG1aNFh4d3BYbk8vdnpYejR5YXlsbUJJa2Z6Y0lteGVHYUZy?=
 =?utf-8?B?Z0pvTEYvb3NGZ0tCWnNuUlIxcllSR0NtWGVUcjhmTGtVZDVRSWgxWTRQYWV4?=
 =?utf-8?B?SGdMekdtcHZPZ3lhSkpaTnJ2dkFHNEo1Tkx3WUlwZjZsZUtHSTVsNlFvNUFZ?=
 =?utf-8?B?eG8yNjI3cjMySWVOM09JMWxpbjBkOG4yeE1BL2REMUFaTmY4VnpodDR0Slky?=
 =?utf-8?B?TVpjeC9IdkYzNnlsR0hIUUJ6Q1JBbGc5QXgrRFNyUWlKZHR6UE1MemJ6dERM?=
 =?utf-8?B?TFJCK0llejN3NHZLYkJMaTVkdXZvNElrRjgyTm9GaHZ1KzNvcWRWS0YzMFhn?=
 =?utf-8?B?WTRlVjY2K1IzZ1BROXNCME5hOUxJM2U2UEhrWmE0N0puVHRkZ2hDM0x3OTlD?=
 =?utf-8?B?cGZWTHdyaHpmQmZObC9Gcll3N3U3QStIckhQVmVrNVZpVU80dDdKajZHVS8z?=
 =?utf-8?B?cUhhNjlENUw2TG13SmhNZVVDM0p1bDNrQjJkQnZJY2ZuMEYvbWpYUHpGQ21B?=
 =?utf-8?B?L3JFYkQyTmRQZ0pqUU15OHhSalV3SHB4MzA3ck92WHVEbmZzTGNYUVNlbG9L?=
 =?utf-8?B?am1vU1ptR2hWMDkxTzNUSmZlOENHeVpwN3FzT2ZLTllnaWZucVBnYzdTaXgy?=
 =?utf-8?B?YUJpaWdDNlFXRU1reWhHYlp2TWR3OXAyMHZrUk9zMVA1OVpnT0Z2cEVYeVlT?=
 =?utf-8?B?RUhMK2JYR1ZxVXAwTnRtYWlKcnFmQmIrZHpZTW5aZlZlMitlMlVwQm1yQ2l0?=
 =?utf-8?B?Qkg1SWtSaEE0ZUNad2tEV0JaTlV5aGp0MlQ4aklYcnVCL2NkUXpjbnlhZDNX?=
 =?utf-8?B?eWsrdGY2MUhXVlRhRkxXU3BHRmNvME5JMXFhakZBTG5Weml1cWlmc3d0alc1?=
 =?utf-8?B?Uzh6NmhaTE1xOUFHUDhPOFZRRFpHZGJTRGxvc0I0VTU3dFdvQVNZY2xkbmdO?=
 =?utf-8?B?cm4za2lKTVRpelc5YnRFN0tuZVIrUGM5Uk1ybGNpRWVtUVZwZ0s2QVdUYmI4?=
 =?utf-8?B?WFBzZ0ZFbVpPSmMvRnFYaDlHQTlnL21LZlBwTlNxMWJOV2RkYitPMUtzM2gw?=
 =?utf-8?B?dC9OVWpKT0RtdXl6V201MHlKR09nbTc4T3pMd0ZkWU0vMkIyNmliYXhLU0JX?=
 =?utf-8?B?UUtWeDNpcEh3SW1sV3lYWVM1RFBUSVBNRlJpanlha0M2M0hsKzhEL2I2ejhP?=
 =?utf-8?Q?dEP8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:56:00.5676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e69cf17c-e83d-4f59-1a7d-08de1bb244da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446

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

Also, AMD systems currently allow banks to be managed by both polling
and interrupts. So don't modify the polling banks set after a storm
ends.

[Tony: Small tweak because mce_handle_storm() isn't a pointer now]
[Yazen: Rebase and simplify]

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20251016-wip-mca-updates-v7-7-5c139a4062cb@amd.com
    
    v7->v8:
    * No change.
    
    v6->v7:
    * Don't modify polling banks.
    
    v5->v6:
    * No change.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * Simplify based on new patches in this set.
    
    v2->v3:
    * Add tag from Qiuxu.
    
    v1->v2:
    * New in v2, but based on older patch.
    * Rebased on current set and simplified.
    * Kept old tags.

 arch/x86/kernel/cpu/mce/amd.c       | 5 +++++
 arch/x86/kernel/cpu/mce/internal.h  | 2 ++
 arch/x86/kernel/cpu/mce/threshold.c | 6 +++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 940d1a033569..ec5417586b8b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -830,6 +830,11 @@ static void amd_deferred_error_interrupt(void)
 	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 }
 
+void mce_amd_handle_storm(unsigned int bank, bool on)
+{
+	threshold_restart_bank(bank, on);
+}
+
 static void amd_reset_thr_limit(unsigned int bank)
 {
 	threshold_restart_bank(bank, true);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b0e00ec5cc8c..9920ee5fb34c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -267,6 +267,7 @@ void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 void mce_threshold_create_device(unsigned int cpu);
 void mce_threshold_remove_device(unsigned int cpu);
+void mce_amd_handle_storm(unsigned int bank, bool on);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
 void amd_clear_bank(struct mce *m);
@@ -299,6 +300,7 @@ void smca_bsp_init(void);
 #else
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
+static inline void mce_amd_handle_storm(unsigned int bank, bool on)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void amd_clear_bank(struct mce *m) { }
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index f4a007616468..22930a8fcf9e 100644
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
 
@@ -85,7 +88,8 @@ void cmci_storm_end(unsigned int bank)
 {
 	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
 
-	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+	if (!mce_flags.amd_threshold)
+		__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
 	storm->banks[bank].history = 0;
 	storm->banks[bank].in_storm_mode = false;
 

-- 
2.51.2


