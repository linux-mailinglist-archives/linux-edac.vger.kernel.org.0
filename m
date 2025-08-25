Return-Path: <linux-edac+bounces-4658-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A10EB348BB
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A116206445
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F33054CF;
	Mon, 25 Aug 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="emQF2m6R"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D3301000;
	Mon, 25 Aug 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143224; cv=fail; b=TJkH3yz6kOThshmgHN8J9lr8u3vayRi88iO0By94Ce3OmN2E1draoXQD22fIgXDcf0EbT9AKoVGpx6+OOosvnoSEHUaSMN92RN7p2aPIFkpIEohy2Z7MaxkjbYIP2tbX43BT5xNS1oudZTCKfe2AQjNMvLdyNIuG+9VZuRuRdF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143224; c=relaxed/simple;
	bh=7elYmStGNwo1HDz1adX15xorVs4paCKLXt/7ybG8n7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=D1tuLIosItJ3mVoS0fo6QxDha3Z/SMjxUWYwCVBsigj91m/NHAej/jYiVgzgUgvVtluVhbiwvo8Rci8AihwOo1rYYj+6tDe7/jkkncizsOrQujm7UWHyYZIQ48iTzIPyeGnGGg0n4SAqbnUaEX1Kw5C3V7/0NCzQJ+UmSBI9kjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=emQF2m6R; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gj4wl1UR1JKQCBwedyGLauIkcaFJfQrwHkJlWlzIZx6S9DWtOaGabyWTPwR36b84VXiM3rq40dwsjKi6HmdaRkmcNWeLYrd0ffCXTFb4WjXPUtA4L+gUAfVXAaPL+E2DuMetBGAoMzeTA6UdXI7/Fb9tSh2+VwrePWvLBFuE9mbrdfqJpqKdXjUcE9eBOgXX7MdS1A/a2XxAooPXqavAVFu43sHliVbcwPVQjjSOFLL3a/trtnMIIx/dfsXljaIFQvnT/Gcs51BwI7R3difBAlJfCEvRpJTaWSl4k4enp/k1T5aSL4H77TbE8CMJFirB0LnFoxa8qH31E9w+C73dtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIBZKlOiQA0u0GnYKWXhEHnKNDX9Wn1eh8O3hYc3tAE=;
 b=p82w6ptyS4GS4sFfGO1ECfqQzPEu/9Pi6UfatCalb00MqptSNW/3kNRM9RD8qoE0OWuejOHgUbr8mWwKif9VurryU3zr3q2fcnVwl4TI9JTkty3rQUyTsWfJcPdWcakm0Jd2q4pr1k7ZfQKXIe1V2+wz5H+FMsB4orkeqf9KTCHSKf33riHCv4LYkH93zBdnAP4ZbDIaHGoMrjW2IMUsW+NebKSmxi6+gLzvdq8iTD6JFx2Y2bppG72un1cJBaWtb1/ws8r3F1NRdqgbvnMYFXuGcmOIgZ5aDZ/+floWPZsLKifU7ZrtqrGs1Q4ePgE/aXXbnP/c3hmn2h+CzymWPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIBZKlOiQA0u0GnYKWXhEHnKNDX9Wn1eh8O3hYc3tAE=;
 b=emQF2m6R8DTT4S8jSRzGXDKe5av6vUQ4xYZvqnoA5u0zyqA2sUSo7/0U+PBSej/5eJwU4x+tsT4z8Qc163JcdWq7eKiw6ZuBwlkxP+78gH8/MAJXFFDuvuOoLJrJUV66y3zi4WdOrZjQybOk4+8Tomj1/3oAEjDdZLCdZlpRBi0=
Received: from SN7PR04CA0039.namprd04.prod.outlook.com (2603:10b6:806:120::14)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Mon, 25 Aug
 2025 17:33:38 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::5f) by SN7PR04CA0039.outlook.office365.com
 (2603:10b6:806:120::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:38 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:35 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:32:58 +0000
Subject: [PATCH v5 01/20] x86/mce/amd: Rename threshold restart function
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-1-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: ca70ab46-635a-4d2c-622a-08dde3fd8696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qkt3RFFrUzlCZ1JoT3ExMHh5OFZPZzZybGhPeWcrYVBFMlFINFlJY0pJdDJ1?=
 =?utf-8?B?R1ZUWUtZV2VzQTl3UUlsTzkyc2NTWHgraFk4Q0VrYmdpUkZDUG1oTjR5c000?=
 =?utf-8?B?UHowK3J5cXdONVBOQXNJZGE2ZUtiYm14S3NvQ0NLVEJaWHNQdzh1MHI4RElv?=
 =?utf-8?B?UVZieElVUW9Gd1lKL1RlNEZxNUk3TjR2aHhaWXpjY1hyOFU4M2JUM1YxMWZm?=
 =?utf-8?B?U0hqNlpURGh6ZGUzeTN6R2pNa3FhQnlrQi9JNDBYMk5NaVBGbmxoRWRvSzdZ?=
 =?utf-8?B?dVp6YTRVVGNmamFTOXlsNlpOUWJYelZVUjZ4NVd1bFV2ckJmbHVOMis4WkZR?=
 =?utf-8?B?YklPZXZOTXYzeEg3NTFqSkVHaVhxb3cxaUowN0xqTjJHMXB2dWoxYVIxVm5M?=
 =?utf-8?B?cVpFUGh2cFhnMllLQWdZa3pkUXlIclJZa2J6blEvZG00NHVQTnR1Z0RneEF5?=
 =?utf-8?B?SUl5b250dmV1anhTRnlXVE9zLzlWVEhpUFdiYXc2ZW5BbFV4NkZUZXlSOXFx?=
 =?utf-8?B?dmV3NFFNVWthOTZTbGw4ay8vN3JqZUFWNUE5Tmc1cXZDclkxSzdZTWprSklv?=
 =?utf-8?B?bmFVRm15Q0puMG9FczEvUDV3OWwyQ1N0SHl5VHFPVDFLL0gwVzBaL0Yydjgw?=
 =?utf-8?B?VDVGcVV1YjZKNmo3NHFuRGVhVXNzZ1ZZa2Ryd2ZNZUNMZXNKSDJJNFVsZU5Y?=
 =?utf-8?B?dk1yVWZVc2ZMNnhyUGJEL0tlU2ozYUFMcnVmMlVEOGF6UlFoZE96S0NPVVBU?=
 =?utf-8?B?c21TRGRrVjlOSjFDOE5uU2wrUm5qcWJvTm1ja0hyalNJK2dqUTJ5VTJhc3FV?=
 =?utf-8?B?L1k1aytiTmNDbEU4Z0RsMGNzaWtRK2VVVVJIWjBVTGNoVThIVUN3bTBVZlFM?=
 =?utf-8?B?OG5uVDN5aURSYVgvTWQvOWRBOXZNTWVYUDZXd3dsR2ErbWhQaFl0dWhFckVS?=
 =?utf-8?B?RWtBc1p5Sy9TYmJKdGJtNGk0R2V5WlF6OEcyUDNnRDIrVitzS3ZmaUsvbkVE?=
 =?utf-8?B?dUx4Y1ZqTkhrc1d0bzFqNkFmOG5Yd1hFajluY3BvdldhMkNIclBUZlpGM0l2?=
 =?utf-8?B?SFVscm5aNGhEaDFUbGVEcDRVQkNETGhCckhEdE1lam5IZmRDcHM4QlVzWm9z?=
 =?utf-8?B?QkpXbFY0ZnV3WUVNTzluMzZGYlZZZ0JXaTR0WWJ0a09DSUlscG54anFQOVdv?=
 =?utf-8?B?Y25ZK0dybU5JdXNWM2l6SGpjUnlUdWNTZW03Z1ZHOEpBanJwMzdBSXlmMzJL?=
 =?utf-8?B?NWtQN2djdk9pb3dpVk05ZTRLWlpZRnlFRUhQczl6SWc0NHJLYmdHazQ5WUl4?=
 =?utf-8?B?R0MvSThYc0hYemdyb1FiVXJMQVZPN2tUWWtSQVhMZ3dOcWpkTklxaW9sQzVM?=
 =?utf-8?B?T21DcWlmWGVUMWN6WjlLRmlvSTVkYW5sYU94T202K1RPSFNUY1BBNXd3ekZs?=
 =?utf-8?B?WEc1NmpBNXNwMThDYjlQSkd5bHNpUEtVcDgvaTZvQm1JZllvUUdveFhzYVpM?=
 =?utf-8?B?TGhULzRWMThETDNOZ25UaG8yWUVxUVVkZnNDWDFZU05iV1lXUFJORlNnek4y?=
 =?utf-8?B?Lzh5RmlUMUtLdHJCeTFiYWFrYzRwaEZQZldDR0JTN3VZTVBSdFZkbkt6V2Qz?=
 =?utf-8?B?dTBRUmhQWHBoMkZHSk5wc0ZlcE1VWnRmUkQ2bDJCelE1WDFkYktLeWw0NGhQ?=
 =?utf-8?B?Rko5SHlHSTdZTU5WcVlnS3dKVHFsZlo1UnpRM3EwcUYwcUpPYjlmMElPRWJh?=
 =?utf-8?B?Sll1NXZFdkhiRUJKY2hCU2YwTitGeVAxVHFTUS91U1N1Y042VjFvZVAvb3gr?=
 =?utf-8?B?V1NyUFFqeGdWUWhRSnYyWk5hcGgwWDVRbFZsdEtWSWNPNUdQQVBZSVZnY0xD?=
 =?utf-8?B?aXl5cU93T0NmUWxFOUp3NElja3cxcTcycU5RUWF2cWVNSWFNRm1HTnJuRjVu?=
 =?utf-8?B?WStKQXhpV0kwNkZlWXMxS2Q3QzhUQzNXSWVQQWx3d0praVd3eTB2Ui8vdnJJ?=
 =?utf-8?B?TkkxSXZ1UWc1RGlQS3JCU1hWVlRtOGtjMUZEYktLQWExUThvdVZuQVBtYi9U?=
 =?utf-8?B?NW1WU3R5dzlySjR5Ly8rR3RmTkladmM1TE1tZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:38.0057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca70ab46-635a-4d2c-622a-08dde3fd8696
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112

It operates per block rather than per bank. So rename it for clarity.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-5-236dd74f645f@amd.com
    
    v4->v5:
    * No change.
    
    v3->v4:
    * New in v4.

 arch/x86/kernel/cpu/mce/amd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5c4eb28c3ac9..9b980aecb6b3 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -419,8 +419,8 @@ static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 	return true;
 };
 
-/* Reprogram MCx_MISC MSR behind this threshold bank. */
-static void threshold_restart_bank(void *_tr)
+/* Reprogram MCx_MISC MSR behind this threshold block. */
+static void threshold_restart_block(void *_tr)
 {
 	struct thresh_restart *tr = _tr;
 	u32 hi, lo;
@@ -478,7 +478,7 @@ static void mce_threshold_block_init(struct threshold_block *b, int offset)
 	};
 
 	b->threshold_limit		= THRESHOLD_MAX;
-	threshold_restart_bank(&tr);
+	threshold_restart_block(&tr);
 };
 
 static int setup_APIC_mce_threshold(int reserved, int new)
@@ -921,7 +921,7 @@ static void log_and_reset_block(struct threshold_block *block)
 	/* Reset threshold block after logging error. */
 	memset(&tr, 0, sizeof(tr));
 	tr.b = block;
-	threshold_restart_bank(&tr);
+	threshold_restart_block(&tr);
 }
 
 /*
@@ -995,7 +995,7 @@ store_interrupt_enable(struct threshold_block *b, const char *buf, size_t size)
 	memset(&tr, 0, sizeof(tr));
 	tr.b		= b;
 
-	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+	if (smp_call_function_single(b->cpu, threshold_restart_block, &tr, 1))
 		return -ENODEV;
 
 	return size;
@@ -1020,7 +1020,7 @@ store_threshold_limit(struct threshold_block *b, const char *buf, size_t size)
 	b->threshold_limit = new;
 	tr.b = b;
 
-	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+	if (smp_call_function_single(b->cpu, threshold_restart_block, &tr, 1))
 		return -ENODEV;
 
 	return size;

-- 
2.51.0


