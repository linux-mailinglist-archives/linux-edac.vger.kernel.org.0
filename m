Return-Path: <linux-edac+bounces-4758-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4CEB49407
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C95442976
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BF4313275;
	Mon,  8 Sep 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EpsO4/hU"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5413128A7;
	Mon,  8 Sep 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346081; cv=fail; b=obS4LTYU0cPdJoPf8242P+WXHlqGrF/OyxWC7BIx5GiNltpZApWqQYyovtYpz7koaZ1/9GwnEhX0Gn/FY7FR5iJ66MBYjkHIevsKMHwdVdg6tjLBxBjNXbp8uiLMvwi836ilT7EP1Zfb6Cut8a8Xrgo0shhx7PVBw8SvWO52/KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346081; c=relaxed/simple;
	bh=Ds8YonDmr3LudFKTg2YOtr4JUzEQLV5rGMUfNSHwz9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oVHNQ7Z+k1bf5go58zqHv+afCvdZbZs9RNuszgcHX/uV7yjRvQC+XHi1UtnAjFGcHvmj5wZHvOCfbCv/vg4lAF+RxxiYjdMKjQmq6TWIjTSaMK+qZMZ/tkeReumE8Qe/9gjIZpv7V2sAL78Gaw1BX7aud/tLC1bLbaye5qAcz90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EpsO4/hU; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHuPoPRHmhQEVhcpWZKJ6pBMeHyvu5ikTQ92x5wYOmLHRgrjgiiQYDnQ3N+dbaFON+2DQI9j/OeGr10xl3RIAS+n4QJRNL/1fu7UVvz/bhIi7xW24nUBgOHaczdTTJc6tyCeHPV6RglzkCrNsVyqXoJzsxDGwYXrr5XHwdJuAtgdhZJdAYyKgl+JCvsXab8ynU+9H84t4pkkDbjsFiFWCUqDAIeTkjh3e3AqO+wVx7B8ArrYzjcjN+fhV+9AicBg0q1k6UWOxO7SRjNSwwkdvloRYLOETxzK+bMxIgHpdYijuiohzvYU4Rx1aiKJqLspSbi2rn/8g19uLMqkBKLcmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ieT7pCs9Z9QYGHh7+ycAvm9J4m5buaMRT8QUP6lKXI=;
 b=gArnynV4aSTBMPbHLxHb2miMRzEfzhfQdHxdxTnp6wUpcrSIFJJt7Dx9KGjl34oqw9M8ptyx3CCm6iaGASlHpUCy1+sUm8SPQqO1smIIvz0EwEFeJYOXUyYfVjf1dd3/Uh/QnQNVJf53XeuIqZG4Z84EP6QHfh9ubLN+kv671FvMnVQFxpQprQMmd6i0oPgDni58A4xTERFcjF4thooOzd3SD1iRl+GfII/cL3jUWApMyh64Gj2VG8I64NZKLgwIKWaTqgCTRML2vynIDsZDnoYYkx6lja1P/8oKNXdBfnQsEpHNKIP7EM9WyoJADq9RahBurOdKWwU++2Mvxnk59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ieT7pCs9Z9QYGHh7+ycAvm9J4m5buaMRT8QUP6lKXI=;
 b=EpsO4/hUjGGkJ8tN5FI6ohXXm3PTRUpCTDxLvbSOMUEYHa+2r1oPssm0Pv339zph5notYEP/Zgd79viOe8PYjgHLMCE0g9gOjlf34ZRwX4IWYcaB2tpzdHE8SOhVcVO7g0VzM0NifmokvNEywokR4K5aPyf4eKKpdCeL7U7ml7s=
Received: from CH2PR17CA0002.namprd17.prod.outlook.com (2603:10b6:610:53::12)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:41:15 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::4b) by CH2PR17CA0002.outlook.office365.com
 (2603:10b6:610:53::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:41:15 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:41:03 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:43 +0000
Subject: [PATCH v6 14/15] x86/mce: Handle AMD threshold interrupt storms
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-14-eef5d6c74b9c@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: db90ad6c-adac-4966-7274-08ddeeee2543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnNjTTZIcHQxcVJnb2NRZTUvQVRDaUh6MkluOWFDb2M3eXkzNFhyS21yVWJa?=
 =?utf-8?B?RmloK0MyekIxZ3luSG4yMU9aOVdmdE5NaENNZjV4Z2lWM3VibkR3OFpmRW5a?=
 =?utf-8?B?NmZsaGZNdUZtL1pEajJGNE5zUDBsWUxraGVMMk90UjRMSHRYTzFnbHh1eEs2?=
 =?utf-8?B?b3ZaTWJXdTVaM2JUWTN4OHBYMnRhc3ErMnliNUlwTkVBS0lzNk5HRFRIc1Jk?=
 =?utf-8?B?aFZIUm9ua2drVjM3VUZvTEs1Z1BqRnlNNFJjU1J0NEZNK0dMbHBFY3lySllV?=
 =?utf-8?B?ZFBPV1V4S2Nxb1hOWVRXaDA1NjdITjRpZzFLcWR1UWhWNENTVEJUdHN3WHZZ?=
 =?utf-8?B?YXJTTUhDMkN5ekQrQWhmN1VMOWNUVVZHNVdEZU1FelFRK29zVWNYYkdWTm1S?=
 =?utf-8?B?cUdkMG5uQlZidlMrRWFWRnltNFRVMnFWR25NMVBoaG5tYWRRNnBCYnVsQ0Vu?=
 =?utf-8?B?aEtyNUxDK3N2bjJnTFdwakNnODlFalRsMUZRN0svanB5dHNib2Q0dTgyODU1?=
 =?utf-8?B?RlZQcGpMZEhLVEFGcjcvQ21RZ2pDZkRxNVV1YTh1QmZqNzUvUTZrVmNMTm9B?=
 =?utf-8?B?L3NPZThlQVJick5kdXlSOHlXcGFleUxHMzU1cHc0S3VnNWE0eUhrSlRVZUFu?=
 =?utf-8?B?Ry93RWZYS1FTb3FxZHNFejJjbGR5dVd2MGRLazhjbHVjTG1QTVFTd0wzNzcx?=
 =?utf-8?B?UlI0Z2Q5KzdMakZHaEUweUlBTEgyY0dxZHN1QzRXQTlXdUpaUWpqTDRWOVUw?=
 =?utf-8?B?c3ZQN3RYc1k5N0RvbEd5TkNHbnJlcUllZWIwK2tmd2NwVU1Ra2xQem5ZYjZz?=
 =?utf-8?B?RmVXMVFXSThGMmx0SHN4TVdOVzdPMklKdGVIeDlLR0g4N2RoYlJrcnRnV2xH?=
 =?utf-8?B?eUMzYWVSaFh5UVk5TUp3SzllQ0ZSanBOdXQ3WlR0ek1qYVFtTWI1V2JyREpv?=
 =?utf-8?B?NG0yTjBGU1BoNXp2ZWVPL2FKdWdsMlVsNlRMZXhxMmI5NHZ3dWhNcHZ5Q01i?=
 =?utf-8?B?U1N4N05UOGk0UnlnZ1VyMzJjVDZWRGFPTCtSTGUzQWxCOEt0ck1veStuWGxh?=
 =?utf-8?B?b3dQWTZ0UTNxSUIrZ0F6aXhSdVRyam1EODNaUjVZdVEyZmZHcDY0b0hOZVIz?=
 =?utf-8?B?U3M5eUNDZHc2ais3Mys3RzVsZlU3bjN4cjFSZ0hnSDBPamVSNTBzd1R5Mjcx?=
 =?utf-8?B?Q2JYQTJJSnVDalpJdzRqeGNENEJOaHdwK0ZSNjVyUDF0M1hEa1ZTenRBT0Yy?=
 =?utf-8?B?MDNkYlhUMGRHVEZSWkJnaGZScUVubDNuMzZuMXozck5heklJZnE1UTJoZytu?=
 =?utf-8?B?UVpTYU5xR3pVWSs1cCttRzB1ZjVIeWhqUW5IYUp1ZDczSGdUQ1FVV0JwWE5B?=
 =?utf-8?B?c1pTbHJ5TFN1d1U5eFUvVHlaemZJVUIyTGxOYTRyWDBPZy8zczVoTEVCa255?=
 =?utf-8?B?b2gzbHVaV0tSY01RRnE3R1BrV1JnZUFZZDdoUFZiRmRVeHl0MC9OZncrUkFh?=
 =?utf-8?B?Znp2UnpFcHRibzdUbE1ldm1LdUpKSzZsdjlQeWxiZk9RK3o5VE1jSkhlTzl1?=
 =?utf-8?B?endzWTEyYXBKNmxqaVdkSDRlUEMxOU9YTHNMVnhXSFdpTzBoN0hSNDBSZzdT?=
 =?utf-8?B?WTNHMHVPSTl2blc5dDQyY2tWWGdEZ0lwdGJ0aTUvb2dpdGZRZkdTWDBPVTBo?=
 =?utf-8?B?YzVOU1lsVkdVaGJUWXUrNitBb0hIRnpiTlNRNmJMSGRTeUtuR1ZQNVMzNlJh?=
 =?utf-8?B?NlV5dGhlSW1DYy9oK2dONHpnRktseW16a3p0WEliZVpacVgvREF6bENHTDdU?=
 =?utf-8?B?Z1lkeFhjUTBKYkE0ck5MTXptenBSc3VvUUNwWVlmNC9uVDQwQlZQL0hBMk9E?=
 =?utf-8?B?dGpjSm5MMGppakVEUHk0OFZDbStsZ0tOK0FzUGd2RnNEQStqMHdubWhPTzVQ?=
 =?utf-8?B?blc2SXhsRXVCZ0piWVVTTHJGOUQzdU5xU01hc01YTWsvYnNjMGlYSXEzbElC?=
 =?utf-8?B?UHJDelRLMzFkOFQ2bHczb0VKVU5scEN2SnBUZVF1TzEydmhwZmhDd3g3bDh0?=
 =?utf-8?B?UDNyc2V5MjRoYnpYbGdlSTA5VnFSWkc3S0FyUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:41:15.0735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db90ad6c-adac-4966-7274-08ddeeee2543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517

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
    https://lore.kernel.org/r/20250825-wip-mca-updates-v5-19-865768a2eef8@amd.com
    
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
 arch/x86/kernel/cpu/mce/threshold.c | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index fbdb0cec5737..b895559e80ad 100644
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
2.51.0


