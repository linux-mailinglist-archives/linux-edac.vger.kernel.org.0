Return-Path: <linux-edac+bounces-3060-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E0AA34B18
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 18:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25B23BD6F1
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38AF2222CC;
	Thu, 13 Feb 2025 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iR7Vv82O"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E2628A2C3;
	Thu, 13 Feb 2025 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465192; cv=fail; b=aEHAolqCGaPlSji2En3D8oE4HNKOPySSKSfvG/96b6O8gkZyHoXRip6q8Z7JZ2fiVV2Ep0kpLKQunDcw7R/U2Gbmc23eNkl3SFICVljx3KJdFpYMC1uWcYrVtAjFUKm71vyArGVoF1Fz7sOAOnabGuXQv4FBELyooEVnE3nsxgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465192; c=relaxed/simple;
	bh=I0wS9mLTzfC9jHClfhqphwtYE3X5ADwwzbit1+AvpcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Nh8Ve18ZpYeNV1+fvQvYhqxPdk6DmKEb2TzQ6Cq9oD36cRdPNE3RXiKuAct+UjpVlN7fwUhhNiu2exThjo4BAY42cJZvFfKlk9Mb6bxIg8x1kzbuGQYCub10y6b80rYV/ZQS4k/gvEMLTBGPIzUJfvyomJS1U1J3J3YdPF/igKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iR7Vv82O; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8IuPxo8SCZKXKH8R2NDEN4T2Mzwz78pUOD3SD91CeovURQb+nBSgLxdaJEoJf43vVKxoUP+mN1DN7MBWJuNzlBrgS+UwHt+XlPgZoEIpWsCD8g00mc3lgG0CcBHCkzV8c87FIVxYNzx/pxSB2yE96+U2ZnN12n7+S/JgFlWWbJg9UJQgyNVEnpqZ7cAusqhzY/05ILVJTAzzQPXNSpIr1vj9zldsmHMVRfoXfvKM34kKE3Dh0ySaBKMdUYEpxXN4+4oLdvS3GVLODD96wiBYJ1cwVsgVgQn5FkwxqT8qUBsuAU6Yi6s7JYVQtnDqEjU8VI/xf6EXZSFjqDM81nMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/MAulw+nx45Sd9u2XMpsglLZgoZxizyg8+kY6go08I=;
 b=DrB4IDvVU4/XnoyhCdPd6TmGPPziv3bBdYmwNOA+RUJnJcdJw/eUwxhVi6xpPYIW7FbXOuaex4Jl34V6N/nDfv91L2D+VL9zYQ3p9EYRiaVXzKyCUV+gQqJwSAk7RSAPbsdftN3gf8qyc9llq5+K/0rfbE+igCRz0C/woSWXR8GQhsL1vOYkn/Pm4gdj1uVhUB1xK0KmifOd4aQXBzbcx0YIgLnCSR7lTx0ZlM4jDMi+6H+LbPajZB8mkWyTc2euv6Kl0rCCnmR8+AlaaGFxsH11CqXwx156bQYRxGO5RpjO+xSLdO1UEkTUg+4mPmWN64q+5OSg7lpfqC8nrxvKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/MAulw+nx45Sd9u2XMpsglLZgoZxizyg8+kY6go08I=;
 b=iR7Vv82OKvhp4Y3OrZ8O0xVY5AWCubSk10cxlsz3h6zSkhdc0PMjLgki+EIQ7HEt2jbWHJ/xhTOUF6LetTjf0O2fkNuAWHQrIu0qrsnhFxp0ZixDtRpM9bZIlimrZYtzWd2GXN2mvq5lhPQy55LT17HGmsvitcm1FzJaewwzGu8=
Received: from DM6PR11CA0024.namprd11.prod.outlook.com (2603:10b6:5:190::37)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 16:46:27 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::4f) by DM6PR11CA0024.outlook.office365.com
 (2603:10b6:5:190::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Thu,
 13 Feb 2025 16:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:27 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:25 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:45:53 +0000
Subject: [PATCH v2 04/16] x86/mce/amd: Put list_head in threshold_bank
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-4-3636547fe05f@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 3621fbe7-7a50-455e-1f84-08dd4c4df59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjZkRmRKTE4rVjNDSnhtdkFtbkE5YTFrZXFLWjhWU3JIamcwQjNKcWFCRmRl?=
 =?utf-8?B?YkVFZVRLb1drWE5Nbld6ay82SGdpN1pzWCttS3Y4MTVmLzVTRmZhWXhSakVv?=
 =?utf-8?B?Z3RHd0g4dzZXN3c4YndqWEtmNjJrYzZJc3NId1F6cTB2eWQ2Sjl3azRLY1NX?=
 =?utf-8?B?b3gzSlBscHVGdWdPalE1WlBwbytzWHNzRTFURk1wSDh0U0YxRVFIcDFPVjJm?=
 =?utf-8?B?VG5waWpMMm43aG5IWEt1cG1pU0hSRThvTGhPczY1SWowMzZ3VEU0TTJnQUxO?=
 =?utf-8?B?SFZSSkh3NWNxS0hQUElycXRtSzk5dzFmZXhWVjFiWE0zeUczaHBYbkJ5QU1K?=
 =?utf-8?B?Uktnd2UzaGpHL2t4QmNNSEFibWtkeWlDSDFxbEdsTlYxanpxQXRUTGZtUXR0?=
 =?utf-8?B?em5waWxrZkVrZ0pHL2wrWWsyV0RJcUFzaGtWcVluQStsaDdNQ1lWS3BBdDBO?=
 =?utf-8?B?cDN4TjRZQldja012YlNCd1AwTG5KMVJNV1BUSTFPWit4Y3VqNkpHa1FlTzNk?=
 =?utf-8?B?L1FoSXRhdEJhN1lTeCt0MzhVdWg1bytVWTdmZm9tSHdXNU1sN21ZdDNIa21u?=
 =?utf-8?B?U2phRytCMUxmbHhyWG5EZFdsZ2lhMlByYUNuR3hUTWh6bTkzN1d0Ky91SVVQ?=
 =?utf-8?B?clJKRnlVYUM3L1hqUUZnTk15d0Z0M3dQekxVOUpqcDVVVC9CR3NSa2FFNVRN?=
 =?utf-8?B?cHh2YmFCdS8rbUtpZHJrc1FIWVdZbkY4NnIxMStnaHU1cXdwRzZGOE5wK2Fu?=
 =?utf-8?B?SzNYbXVpNlBHNHNqQ256M3J3WkcxeS8xcVpTZnpMdjBVYW1RNFYxTHBTL2Q0?=
 =?utf-8?B?cnFhd3NlTmFqN2hBNUc1SjgrdVlWMnRPUlIxK1ZRdEZtUkhtMzczc3hIRnJI?=
 =?utf-8?B?Wlh0ZkEwdEZHYWQ1aFowS1RsSnRBbUxyVWdLV3lVVmc4QnVFOFFnQjQ0Z1NT?=
 =?utf-8?B?WkdzOTlEYTVxajNkNGFLWnBrd3VLMDluUTFjQUtIT1NzbHdGUWc5MDFEcmta?=
 =?utf-8?B?aXpYbGMrVWdPQkwzaVpqS1FYL0dJUjlLMUhrYVVyV3JtUFJUbWQwUGJhMHVp?=
 =?utf-8?B?eExqRUJRelJmeUcvWHcvTVo1VmF1VHVQTDNwSCszM00zVmxUcTA4UElHd3JU?=
 =?utf-8?B?ayt6YVR4WjJXNlVXMHNhYkorbDRET0JJNWI4K20xRXFRbkN0QkVEWTIxaVo4?=
 =?utf-8?B?ZExNY0V4bFNHYmdIMlRLV3J1eFExSGVKMjFsTzUyTzc1TWJEcTA4RGNjUk5S?=
 =?utf-8?B?U1pnanNJSmliczA5S2tIRVRUanBRTHc0d1F2Sis4Mmh2ZEFySzl0SUZEY2da?=
 =?utf-8?B?YXAxMVZ1YjM3OE5yZjNKQVFpeUsyaWhYakpDY3VNd0M1bHE5TU1idUhWays3?=
 =?utf-8?B?eWFTSjFBTzlIVHU0OGU0NWQyWG5GRFh5U2FHc21tQ3dGbDJsSDVDMDcvSVJs?=
 =?utf-8?B?VjlNLy92dkRIOVJWd0I2WlhFRnl3aUEwWGpZRUxibEt0dnorWlJ3a0JsOHNj?=
 =?utf-8?B?cXJvdWx0aDYrY2JueTRoa0Z2ZENVbENiM1BIaGhRdCtmTHllZ3Z6TDd6OGJD?=
 =?utf-8?B?dkkzMFFweUQ0a1lhdWIxZjFZTG5DdHpBai9DSWZtWCt0Ry9QbGx2OGxmR2VV?=
 =?utf-8?B?UStmalRVQlR6Y0QxeU1paGNCbG9tVFdLQkhmWXZtTW5LSjVwVFhzOVo3Rk80?=
 =?utf-8?B?QTRhckpDbEFad2hFSi9jbzRSc05xU3ovc1RLeTFxWDJibnVwV2hKaU4yeHBP?=
 =?utf-8?B?QVRwV1lFNHRyR2xtQ2NZRGo5ZVd0S1RiRFkxRUJTVnorNFp0cGM0TFJGYUR1?=
 =?utf-8?B?aUpnM0RqZWZBUFovZjlOdHp4bXFaTnhsNUZzRzZwVlZHZm9lbTluZkVZT0Fa?=
 =?utf-8?B?bFBNZnJFcmt0UVVmTU9MVVd0N1BDbFJjRVdMdXAvdEhEcnkyeWZiaWdBdk9s?=
 =?utf-8?B?aW1mL0R0NkUzenJyd1k2c2tKRHN0SDdNaGlJdnArNTVBaloyVkkyZURPQVdY?=
 =?utf-8?Q?fPqf5vfwBmsQD2ohKbMsDm795M0oVY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:27.2161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3621fbe7-7a50-455e-1f84-08dd4c4df59b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078

The threshold_bank structure is a container for one or more
threshold_block structures. Currently, the container has a single
pointer to the 'first' threshold_block structure which then has a linked
list of the remaining threshold_block structures.

This results in an extra level of indirection where the 'first' block is
checked before iterating over the remaining blocks.

Remove the indirection by including the head of the block list in the
threshold_bank structure which already acts as a container for all the
bank's thresholding blocks.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c | 43 ++++++++++++-------------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f8ad40c5c887..df8984aac1c6 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -241,7 +241,8 @@ struct threshold_block {
 
 struct threshold_bank {
 	struct kobject		*kobj;
-	struct threshold_block	*blocks;
+	/* List of threshold blocks within this MCA bank. */
+	struct list_head	miscj;
 };
 
 static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
@@ -901,9 +902,9 @@ static void log_and_reset_block(struct threshold_block *block)
  */
 static void amd_threshold_interrupt(void)
 {
-	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
-	struct threshold_bank **bp = this_cpu_read(threshold_banks);
+	struct threshold_bank **bp = this_cpu_read(threshold_banks), *thr_bank;
 	unsigned int bank, cpu = smp_processor_id();
+	struct threshold_block *block, *tmp;
 
 	/*
 	 * Validate that the threshold bank has been initialized already. The
@@ -917,16 +918,11 @@ static void amd_threshold_interrupt(void)
 		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
 			continue;
 
-		first_block = bp[bank]->blocks;
-		if (!first_block)
+		thr_bank = bp[bank];
+		if (!thr_bank)
 			continue;
 
-		/*
-		 * The first block is also the head of the list. Check it first
-		 * before iterating over the rest.
-		 */
-		log_and_reset_block(first_block);
-		list_for_each_entry_safe(block, tmp, &first_block->miscj, miscj)
+		list_for_each_entry_safe(block, tmp, &thr_bank->miscj, miscj)
 			log_and_reset_block(block);
 	}
 }
@@ -1145,13 +1141,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 		default_attrs[2] = NULL;
 	}
 
-	INIT_LIST_HEAD(&b->miscj);
-
-	/* This is safe as @tb is not visible yet */
-	if (tb->blocks)
-		list_add(&b->miscj, &tb->blocks->miscj);
-	else
-		tb->blocks = b;
+	list_add(&b->miscj, &tb->miscj);
 
 	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(cpu, bank, b));
 	if (err)
@@ -1202,6 +1192,8 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 		goto out_free;
 	}
 
+	INIT_LIST_HEAD(&b->miscj);
+
 	err = allocate_threshold_blocks(cpu, b, bank, 0, mca_msr_reg(bank, MCA_MISC));
 	if (err)
 		goto out_kobj;
@@ -1222,26 +1214,15 @@ static void threshold_block_release(struct kobject *kobj)
 	kfree(to_block(kobj));
 }
 
-static void deallocate_threshold_blocks(struct threshold_bank *bank)
+static void threshold_remove_bank(struct threshold_bank *bank)
 {
 	struct threshold_block *pos, *tmp;
 
-	list_for_each_entry_safe(pos, tmp, &bank->blocks->miscj, miscj) {
+	list_for_each_entry_safe(pos, tmp, &bank->miscj, miscj) {
 		list_del(&pos->miscj);
 		kobject_put(&pos->kobj);
 	}
 
-	kobject_put(&bank->blocks->kobj);
-}
-
-static void threshold_remove_bank(struct threshold_bank *bank)
-{
-	if (!bank->blocks)
-		goto out_free;
-
-	deallocate_threshold_blocks(bank);
-
-out_free:
 	kobject_put(bank->kobj);
 	kfree(bank);
 }

-- 
2.43.0


