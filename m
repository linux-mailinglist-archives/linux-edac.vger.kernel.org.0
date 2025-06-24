Return-Path: <linux-edac+bounces-4221-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E94DAE686C
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634B86A0B08
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2882DECCF;
	Tue, 24 Jun 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yhWffdNR"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892032D8DCA;
	Tue, 24 Jun 2025 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774600; cv=fail; b=ALL9ip6i7duF3WPoNXlglgy5/+CcMMJrO2dmRtwhdRCnshnUCrPi9Jx1pAmVHaqrN3YneTSvQgHmM7EM3nssxsLb5lO8NdCv0xzBOypdtyHtPNKBtXzqhaKPtFeqhWU7RbpoCs6ZFFSpSbQhZK54yzlzcG0UhK1qMknYpGZRmVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774600; c=relaxed/simple;
	bh=iM4IeoBSLfNLdDNV8Uh9yNb9yCgMFwGJp56rbz/SomU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IPVeCKXGg9O3q+UnvLsr43NNXSFO4Bl8q0/l4cO/KgjKZetCQ7Pglbz/+WzHgidYCmllb9A9f7zaTOokAwlIq+K7IA4RCl5RVHWZIHrBbETz9QW+CoTTqgFvGB4LQPkbCvbgPMxywmn75PZQ88y+ooIS+2LR86dnrPdOJmS/m9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yhWffdNR; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJP0jZHwrAdQfZHnfq1iPmXyaa5o9Sx4pT3ejAj626HhRvFlg8ksAIikzkZjMFDjpQuYErhwL+0AZ3CFlKDlycL6t2FAAEAMWD/m6PILMD76BkiWLmkVuRlYqTyQJX8Jvb1W0WrOSGbNoDhnjfQIfP+1kibd9crjzFmi2Yb7ZKRwAnHqx86kp3nqCXXvTliJJCbMztz1KTlgRWYV64BYRTEM11+lrEqYouyNbcl4UeY1iQWLUVhYleyQvRLeHskmKoxcUIY7HcmTRwfRCRDlXnEauwnZqqTx0IrL7J+VNyNXU48F/giSeMsyIC7dyFASVkVp+K3wHyKlJMC8JAQM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o2npA2IvKqnzMTPRJK6I6MLyrofA+2YttuJAqDZ3xM=;
 b=oNzct5Duh7n4NWXykJnsdi1EIsE2GwQ9/gEKwpAARq/rx8O3g2QOwL7PZjOgSqUGwlLLpjLZ5PhKYUGgKfDqGhpM4M29aMqR559Y2SHDlIEF1SuRIDUxqqtmQvsM8ztTwvtXjGjroVOkgcxhXO6rnDwdldKR19NAz2g1jH7LigcuCEeAf02worFAqKHeQfyUWhb5DP6Ref4xT3/Fsvp5YK0dDyEg7UiihpdL78YCGlLDPv3A/t+ATKcK1tThhhSysizTA6+bx+74U9+1LO6FfNPhW0Q2iU3zq613nWUoaPRFUEyq79Q9BSwoI94lZRdYZc30tQq/KK6URd5AnZFaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o2npA2IvKqnzMTPRJK6I6MLyrofA+2YttuJAqDZ3xM=;
 b=yhWffdNRm2OMz1m4sTCCwXRxOIvRwZpHnYkplNKor9x1FxuZCZQpANabhASCUBhVFx1+scjHDaadjY1+kgHpEJAVmdKb8sB5pi2x4mQFw7DRBBEwOYXD2G+hadqC+TiIeuLN/ztL5ztmjfNk7zicNmwx8lXgH+V09Zj2xjngVgs=
Received: from BYAPR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:74::29)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.35; Tue, 24 Jun
 2025 14:16:35 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::b7) by BYAPR05CA0052.outlook.office365.com
 (2603:10b6:a03:74::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 14:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:34 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:27 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:01 +0000
Subject: [PATCH v4 06/22] x86/mce/amd: Remove return value for
 mce_threshold_{create,remove}_device()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-6-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 26995e2b-2e0c-4fcb-4d20-08ddb329b972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0srOU9xbE53K3UzUnhTZHBPR2ZaUzNHd0VmYzJPbk5NYjlGbnBFckxvTHNn?=
 =?utf-8?B?QW1rN1R6alM2SHJvYjNMZ3VOWkl0Z3psNGtBRlRYV2tXTmkxZnRMREVDZjRN?=
 =?utf-8?B?ZVBmc1hNMkEvcTBiRTBsbk5nMlJ1L2VoZzRPYlN2N0hvZXZhcWRsQWZrY3Q0?=
 =?utf-8?B?cDFTU2FKZlZGc29Ma0xOZjh2MXkwMWhhYjNqaDQvYkF4S1g2NDRDV1N6VW8r?=
 =?utf-8?B?Tkd6R3NaNHg5MUc3bHVPa2NjNFdINHFXVEhhZjVvZU1GbFFBeWVKUkt5T0h3?=
 =?utf-8?B?N2JiQ1I1WWVXQ0VLQUVpSzFRNkRKaVF1MUV0aWcwSGYvbkVOTzM4dE16ZUhs?=
 =?utf-8?B?ZDQwN00zeVVPK3c4SXpPMGZueHZvaHRaSWJxU21nSDAzYzIvOXpHY2VTMmZG?=
 =?utf-8?B?ODY3REV6UXFoRGc4SVBIMmtVc0NxMEpjUnd5L3JlU2wyK1ZEQUlDZ1hwa1Nk?=
 =?utf-8?B?eENEdStwb3dFZlA5aUxoRjNOOVZiZ1F4dVVkNGNyRGVvbFpjTFVSWXZWSFJ3?=
 =?utf-8?B?MjAvV000cWNrRFRqT2FOeVdYMStyN090OXB4dyt4amdicXFHQVNVK1NYRm9l?=
 =?utf-8?B?VUtHTEV4emNSbTJ6M3o3elZtY2pmajcwZ0FVVFQ1QnlIbGkzSGlDbUJ0bWEy?=
 =?utf-8?B?ajcwQTVOUWR4T1kwTmhKcmMwZ05Zdjc2RFRJUGVYUWNMNXBiN3VHd2dvVjVu?=
 =?utf-8?B?cjhlclBacTJ6SU1XeDhQN1B3UnJkVmphZVJaZUwwTklwOTBWMUJGVzlqSEE1?=
 =?utf-8?B?UHNkaVdmS0FEZXViVUE3aFNKZkE2M2VIeit1bjBYekJna3FtZEh2VGR3aUI3?=
 =?utf-8?B?a0pvZnliNFBCZndySDdiYjFscDRYSjhKUjB4VFUyN2NJcVdYVk95NjlmWkdN?=
 =?utf-8?B?Ylc1MCszS2c5KzR2SXo4ZjdPb3BnMEM4ZE9NaitHTGFieTA4TkN6TjVab1lE?=
 =?utf-8?B?RzkwVDVyTVM5aU91L0MzOFM2MkpkZHB3U2lWbTlSOUpEY3lCeWhxSmpXOUE5?=
 =?utf-8?B?RXpyanJ0NkF4a3pGYVdZSWRLL3ZRQ1dvUzFYQzB4bzdKancxU1J5N1ZsOXht?=
 =?utf-8?B?ZW5td3JxQmdBd3RueVFvRzgyTXVDdFNkTitmVUpoUXBSUndCY0xkSTBsenBH?=
 =?utf-8?B?UDVaS1luYVk3L2Rrb1hYaTIxSUt4bmNsRzlQQ05sODRsVkpNMGd4cVZvaFpv?=
 =?utf-8?B?UVpRdC9nYUNTQnprOVgwd2JLb0RjZU9nUmpIK1ZJNDNPWFFNYWUwOHJST1Jl?=
 =?utf-8?B?M0pKS0p1L1YzRlpWNUhGSUplNmgwTTVHY21JUzZvT1RLam52UFNlYXRUOEdF?=
 =?utf-8?B?di9JUGc1elhlanpIbS9wSlBTeHU1Z2F0SUd1Vk1FUnFaQVlTMDBhUUZ6MlRC?=
 =?utf-8?B?amNCalFOVkorRkhwZC94TE1IbTlVUGFRMTg4ZzUvckQyMGNxdGFPVEJsQkk0?=
 =?utf-8?B?dDZFTWg3aDNFQzNqZ1RIYk03ZnBvMGk3cnJZNC9EK21samFXYWo5UHROaUM3?=
 =?utf-8?B?ckRORDFNa21GTU40QU9ud0pUVFhKaS9yUldUT0JZb0d4M3VNMEhJWHhoL3o3?=
 =?utf-8?B?MGprRXpDbmJ6QkJMNi9ZR2NPY1JaeTB4dXdnbU8rK0ZJdjc0T1RoTHVnZ0w5?=
 =?utf-8?B?anViaVF3YzhxMkdDWWxLaENzcUlmclBWY0xoWlUvWXE3M3llOHJtR0tiK1NP?=
 =?utf-8?B?cnVtOGk4Y3V2bjAzc0kvNTVwK3ZDdDYrL1k3cmdKZk9GQloyTUlCSVg5aUwx?=
 =?utf-8?B?KzBnT3d5cXBjRnl2QkRvWTJKcHhCQTJab00wUk1rNy9mV05hY1FtdUN2KzNv?=
 =?utf-8?B?UWlhR0RIem9sT2srRVoyVUVEZHRtTUNGTWZ3enpsbUtvY2EwYW5ESXNBdnR6?=
 =?utf-8?B?b3lLSkMrcGNIQnBBTGUzRTFBdGxsTWIwNDV3d3JTaDRwQWx5dGVOZWFoWTRl?=
 =?utf-8?B?NWRZK2orU1FETlNRaFNKUXJ2Q3d5UjFFdDR6aWNGT05QeVNScTdpcmhhUWM4?=
 =?utf-8?B?cTJBY09seTJBYWN0TUNwMlQyNWZKQXF1VVZ0akdDWG8rWHlmSnhxcXFGV0k5?=
 =?utf-8?B?a0tsMEFlcFh4dzV3dkNDS01LTTF0Q21DWk9tdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:34.1442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26995e2b-2e0c-4fcb-4d20-08ddb329b972
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379

The return values are not checked, so set return type to 'void'.

Also, move function declarations to internal.h, since these functions are
only used within the MCE subsystem.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-2-8ffd9eb4aa56@amd.com
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Include mce_threshold_remove_device().
    
    v1->v2:
    * New in v2.

 arch/x86/include/asm/mce.h         |  6 ------
 arch/x86/kernel/cpu/mce/amd.c      | 22 ++++++++++------------
 arch/x86/kernel/cpu/mce/internal.h |  4 ++++
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6c77c03139f7..752802bf966b 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -371,15 +371,9 @@ enum smca_bank_types {
 
 extern bool amd_mce_is_memory_error(struct mce *m);
 
-extern int mce_threshold_create_device(unsigned int cpu);
-extern int mce_threshold_remove_device(unsigned int cpu);
-
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
 #else
-
-static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
-static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
 static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 #endif
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9b980aecb6b3..f429451cafc8 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1296,12 +1296,12 @@ static void __threshold_remove_device(struct threshold_bank **bp)
 	kfree(bp);
 }
 
-int mce_threshold_remove_device(unsigned int cpu)
+void mce_threshold_remove_device(unsigned int cpu)
 {
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 
 	if (!bp)
-		return 0;
+		return;
 
 	/*
 	 * Clear the pointer before cleaning up, so that the interrupt won't
@@ -1310,7 +1310,7 @@ int mce_threshold_remove_device(unsigned int cpu)
 	this_cpu_write(threshold_banks, NULL);
 
 	__threshold_remove_device(bp);
-	return 0;
+	return;
 }
 
 /**
@@ -1324,36 +1324,34 @@ int mce_threshold_remove_device(unsigned int cpu)
  * thread running on @cpu.  The callback is invoked on all CPUs which are
  * online when the callback is installed or during a real hotplug event.
  */
-int mce_threshold_create_device(unsigned int cpu)
+void mce_threshold_create_device(unsigned int cpu)
 {
 	unsigned int numbanks, bank;
 	struct threshold_bank **bp;
-	int err;
 
 	if (!mce_flags.amd_threshold)
-		return 0;
+		return;
 
 	bp = this_cpu_read(threshold_banks);
 	if (bp)
-		return 0;
+		return;
 
 	numbanks = this_cpu_read(mce_num_banks);
 	bp = kcalloc(numbanks, sizeof(*bp), GFP_KERNEL);
 	if (!bp)
-		return -ENOMEM;
+		return;
 
 	for (bank = 0; bank < numbanks; ++bank) {
 		if (!(this_cpu_read(bank_map) & BIT_ULL(bank)))
 			continue;
-		err = threshold_create_bank(bp, cpu, bank);
-		if (err) {
+		if (threshold_create_bank(bp, cpu, bank)) {
 			__threshold_remove_device(bp);
-			return err;
+			return;
 		}
 	}
 	this_cpu_write(threshold_banks, bp);
 
 	if (thresholding_irq_en)
 		mce_threshold_vector = amd_threshold_interrupt;
-	return 0;
+	return;
 }
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b5ba598e54cb..64ac25b95360 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -265,6 +265,8 @@ void mce_prep_record_common(struct mce *m);
 void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
+void mce_threshold_create_device(unsigned int cpu);
+void mce_threshold_remove_device(unsigned int cpu);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
 
@@ -293,6 +295,8 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 }
 
 #else
+static inline void mce_threshold_create_device(unsigned int cpu)	{ }
+static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void smca_extract_err_addr(struct mce *m) { }

-- 
2.49.0


