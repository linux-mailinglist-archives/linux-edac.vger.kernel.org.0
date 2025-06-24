Return-Path: <linux-edac+bounces-4235-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312BEAE688B
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD776A2A90
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164B92E2F10;
	Tue, 24 Jun 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S4xlHmGC"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C292E0B61;
	Tue, 24 Jun 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774606; cv=fail; b=bIlL3lrgl8YXIBPtt/WBThbKOKxnW3FMuKp1NMOsUKWm84h3CxZ0YwHZW7UevcZR0r7ZeT0crrcGXQb1BoHNT/4jHbMk9dp2qDFruTSWcuZ5PdVS+showCv+/PMeQHoHp6xtTeHvtT1Jejfg1YF2izqsfrwOpo8cmX2ncGgs2dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774606; c=relaxed/simple;
	bh=KHKc94XxBizT+ESKipj45EzFPfrUg77hNJrufuZ0yxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tWs6bMbXz2f9zIStaqCnbVbH1b5HlQX911zFYPv85LYB5PmBs0Rkp+eXx3XFkq2XnvBXyFpSsA0gLN0dsbX291Vg6Qkr6cptM4WTU8nf+AenHo7d6kpJMHCXV32+3GxGU2KNVCTv0v33rEtBIp+8pGDSiWDo9NcYx6lw5Z967OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S4xlHmGC; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sh/WQHZQzV2t2t5eZD+Ie8KYnay2j3O6Tz1PSWroKzBm4VSNvDzu5otGQ6wJZWHEf1qk+zPVru2N/j8w/tywFDDj60bmwNitJshPsANzCKYtw+TASJSPBSVx6iyhpJAl+Xu3OHw++aC0vbScWgLwmVZuorrfjtNMwxa7lMyD2MYZumaoqlzHLDAnSaQGzFK/Rmt4Ld3hbqwfkaU+qCy9h26u/ms4wEgcwjsINbGWqdlPEDwig544xSSPiUzLr26acF3qyy2QQsvj3miLAsGXFc3M6xv3bjL7yX5l6ysRWotBKoCSrCizObypfcOZwY7aJRrAMHIE0vvBW3ZG9Y8sxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADVTjgdDYzvuco1X9/2BkU/Ma5F5yiCHbXUACVMseYY=;
 b=uOk2zALbh25J2EErCn9+/FXn5EZfACeozXU4ShtvLZyQkQYOXmG9v8/t4uNiw/sQqnsUc11qrB+xr3FNrheGtXt0vPvfO8YUxaf/Uc9VGfeHbneTavZTrSc3dUrcDa11thT6NcGKEGDQm4T03intyrA8Gor/NDk64I5YitZDayfNK4LLT2E1yVBotAY6UqO+1fHlL7eb4VAVmcxDX4+a0dShPlRC+GKV+eTXelro4/o4bwddh5X8CUNMV/n9LAJGgfJF8iEtct3IGzhUvA3++x5ueC3V7wVqhrh4e2s21KGYewkpD+R6G2Q73bnyrpRvtdLi4q/31l5B/P+XA5KQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADVTjgdDYzvuco1X9/2BkU/Ma5F5yiCHbXUACVMseYY=;
 b=S4xlHmGCaA9VEblPNbX7vhXpjUukE8ghwdoWwWJ/7FK91klUEVZ5DElKK+voV1bTGl2usQD8Up6gQbbzMcoXJLCILXZ8I/pjvTi8xRWCWWDdRORBHnzHPE3XszS8nVBoMo6FqIh8GYCPMCNKsDn9pVH0r6BV4B1ds5BqTpUAl3U=
Received: from BYAPR02CA0055.namprd02.prod.outlook.com (2603:10b6:a03:54::32)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 24 Jun
 2025 14:16:40 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::ab) by BYAPR02CA0055.outlook.office365.com
 (2603:10b6:a03:54::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 14:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:40 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:38 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:16 +0000
Subject: [PATCH v4 21/22] x86/mce: Handle AMD threshold interrupt storms
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-21-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a4af6e-7d2e-4b28-734d-08ddb329bcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vkx2dW45MGdacXJWRlNLS25WMXIvQ3oxU0xEK0dncFF1bzRXNkZHU2dUTjlT?=
 =?utf-8?B?dGdzbG80R3A3YW5UOTZJMUNUSXlad0VSQ0I1K1FHbHk5WmZyZzJOSVVyQTJD?=
 =?utf-8?B?cXY3QUdWSDI4RkJEayt4NlBTN0FkQjJvL2NyRUZFZkNRSXNta3RiY09pSWM2?=
 =?utf-8?B?Wk0vQ3gvWTlueUs1cjJhVGhTc2tqTnZYbW9NQkJ1emJQUFR6ZW1TRFpvV3ha?=
 =?utf-8?B?eEVNZnpRRDc4enJaMjFDd0Rub0hUWkErbk1oakk5Y0pBUGVkVDRhQ3JQb3Uw?=
 =?utf-8?B?dlRPVjF0NmxCQ3FjM2xiWGp5WmQ5SHVlUnRjSDRQOVl4cGVjV2VEaEloVVp0?=
 =?utf-8?B?YjdudUFpT2xTUFVzZ0tCRDRZQ2JaSVM2a0psVEwyV0dBVUV6aVFzWGVjNisz?=
 =?utf-8?B?eWJwS0ZoVDRzOVpjejUzWDNJNUMwNnlvcHpIYnE1Z3JIYWdRcDZmZmYvY1R5?=
 =?utf-8?B?VjBwRElNazhsOWl1bXhKeXBJSzEvUnVSelNVb1lodHNSYUVUN1U1TW9UY1hs?=
 =?utf-8?B?RkNmTUlZMjZkcnV4Ky9kcWZheE5jVUhmVkszcm1xNlNMQnRHWk55U3RzSmFQ?=
 =?utf-8?B?RmRVQlk4OWk3K0RHeDVlQ1RYSzFMUWVkM0ZjZzFJMVZLci8ySWpESCtRQjBR?=
 =?utf-8?B?T0VQN0p3ZTEyQ2FoWUZualc1aTZWMlBoZSsxWUlqWURFYmdNTVVaYW5JWm9k?=
 =?utf-8?B?YndEVnIyT01KeXN4YjdsWDlZQXhZb0h0QXhwbm5JUmxha1dkVnFTbWltTXhV?=
 =?utf-8?B?TDZuZE9LQXJ3S01sZDZlRjFoMFFVOStUZWNvcUVKVXJ1MzJieWR5RnFwWDlQ?=
 =?utf-8?B?SkVMWkJMTVdPVm50d1VteXZjbHZrY3B2cmJSaEZ5SWVoVm45NWJQNW5TNDFw?=
 =?utf-8?B?aUZQRURhdlZPenZxWEgyQVdGd3RYbENDTGZGU1MzVDlpclpRSnNNNVRVWUdO?=
 =?utf-8?B?cDRHRlBWUTdZUlc3b0FuOGRIM1hneTZZbUdKTWh5OHZNeE5kU0t4amxkcGk1?=
 =?utf-8?B?UUZ0WDN4L1pWVGJML3pvWDRJd2lDb0pRd0lQSitUbG1nQUJlWCsxam5VZWRS?=
 =?utf-8?B?elp2WE4zL29Wa0pvWE52dkNyaTRUSldaK3lONUNBOTZNS2NTZ1Zsb3FVWFM2?=
 =?utf-8?B?eEVySGpjZTRWTTV2aGY1ejJ1Y0J2ZkFjNkFmQ09KRG1iMHdUYkVvVmVoZUZy?=
 =?utf-8?B?dUpqOXVHNWFCeGVUdVVkdWdPZVBtVjBGa0toZ1Fza1dURzV4NXNNNDV3S21F?=
 =?utf-8?B?eDNqM1lSUXFyZjVlTkd0NC9VUXpNalVpQlpjNHF4QjhCaDMyWE1PTVdzL0do?=
 =?utf-8?B?VUVhLzRGUXN4dDRQWWFybFFmK2svVWV0dHJoTlM4WDJUV01rTjFnTUN2UnFm?=
 =?utf-8?B?cHlrT1pWc0FMaDNwNVA0eFNqWktjbWRHSHVINTFEM09ESUpXbFdNUmVLSnJq?=
 =?utf-8?B?c0Fac3JiU1A5TW5SalVleUtxa3hFUk43Y1F4anorQVhJK0dzaFBaa1dSSk1M?=
 =?utf-8?B?Zk9PbjhWYnNqZDJOSG5oQ1FFWkpUYWxvcmFTNy9YRnlkS3ozZlhnYTNMSlZD?=
 =?utf-8?B?U2lqTHkra3VNd2JrVklCcVdQN2NQVkZqcVVVZ0pWR3JvdHZuS1ZCUC9hekxT?=
 =?utf-8?B?L01QVFgzQ3hrNm9UcjUxS3NFR2NzRWUzK2ttckhySnRDRFNCcXdrS2hkYVJ6?=
 =?utf-8?B?WW1KOXdaQXpvRDlnTGxMUG1QUlN0R3FvQ0VIYmp6Rm8wZ0RnbUhrMEU5V3dS?=
 =?utf-8?B?UWExdXd0Y3kwSDEwZ1FyelNZOFdyb29uVEpXTlZpbDVUMzhmRFpZYlhSTURl?=
 =?utf-8?B?c1BabXpBVHlpMk1UMUJYVDRGd2NPVElNRzF4R3UrbVdrVVVFMStrbktQSnV2?=
 =?utf-8?B?OVoxL0VzdHZjOFZzTnRmNGdYUm1MWjNQa08zOENIYTZ0VEJqMWJoaUpkemRF?=
 =?utf-8?B?WVRKYzc3cXNUYUJzNm9NQk5HWVRES29kcWRyTTNzS1N0c1J5aW1yTWo5V25K?=
 =?utf-8?B?OXV0UXhDYUV5TVZWVitTUjdpdVZna3NobWl4RGFhVDVxU2xXS21oUTQ2YWRZ?=
 =?utf-8?B?WWVYTEZNU044VkF1YzQ5ZXNXUmxBMXZzaUN1dz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:40.0823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a4af6e-7d2e-4b28-734d-08ddb329bcfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956

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
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-16-8ffd9eb4aa56@amd.com
    
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
index 56e7d99cef86..85fd9273e90a 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -848,6 +848,11 @@ static void amd_deferred_error_interrupt(void)
 	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 }
 
+void mce_amd_handle_storm(unsigned int bank, bool on)
+{
+	threshold_restart_bank(bank, on);
+}
+
 void amd_reset_thr_limit(unsigned int bank)
 {
 	threshold_restart_bank(bank, true);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index e25ad0c005d5..09ebcf82df93 100644
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
@@ -299,6 +300,7 @@ void smca_bsp_init(void);
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


