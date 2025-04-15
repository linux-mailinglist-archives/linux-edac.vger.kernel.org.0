Return-Path: <linux-edac+bounces-3544-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A4BA8A1FD
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33353BAC19
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B729B78E;
	Tue, 15 Apr 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hJu1Y1nr"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC329AAFC;
	Tue, 15 Apr 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728919; cv=fail; b=ErEyzNSwBwZk3kFiVrKlr896DOLHNLdcgdKDOOOibpbnvviD4RN0wd5w27LcbL5yCw0JsMfgzcphp0m+ESphAhe2+z7H3QPWJa+cnlD3JG/BTVjhn89e3JXptEWu8x/aHXgIsLjAgqvsWVWCS5yY788VuE/rRsdlDX9AQE7ujek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728919; c=relaxed/simple;
	bh=LNJbHram64WCj7pe2l9X+AouzTZnzuyd9yaiPOt8th4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=G/0DyEDtWwIomXgFytjBXNpirqSDQa1xP0fGzPaRTS0vPgzUkMkdCH8unQRuX+PmDSfbEMEHTwpCmf85uE4h7NMQt7CRe8mX8he2AuGC/313irMG8nsSgZSvA+AHsMsP+PjyIsGFn903NxGZTHNb/c5nseo31dsfJMJOH29bHyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hJu1Y1nr; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBSW49iymupWredAEUrl/QJcL/Fl12qeGeZKWDiht1WPbAXTSo5EeZLcRau0Z/0Kg4oBeux2P5uDDE2ed/mbQq1xEXVwtc+aQfbAkygfh7z2Y7ozH9vq22EcRXFVuldlXfgeUVM1pKaZIf7ehvXcedmoLer6CD4rAgKXSuhaR2jv4RlmFFbSxjTCbtNPonXRrF8Zqtd7d3V0AKDIDamHWuXJ6vBZ/hU3JRXVfsNr10g1VbFjPGa8qQZ1AOO48JZeOdnf03n0XJBrBQOVYP+2rz9nPXytAgrfSvDphzMqPzavJL56d81GLOctro4PPKFYvIR4AEEeCcOSGGX9Mw+WYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CzIFIyhtCHYUQoe4dJK/u3PKq8q38sERGr1vxxQQk8=;
 b=PtdN343BgnNzdsiCAFihF9q/ir5icBxtqUw8GRk5p/n9oLcAfSz8qEgqLIEmAn93gd+JGRC78+wXGG9OMuRtoIkFqhnCqgsZRERQoF//bfX7U+QH/NSYtkEchMR4ffVmKuQcUzpdp0Ls75+hlTDWfdjgRDgGpjQas15jCAs/XOVnT4C0osaT5ISCsCdPHeehKJ8/2kTJDQt3g6HLiASwqUKaAqCbFE/Z38LSgOM+95n3JO4fJmaCBDuPlK/6XvNIgG/Bhmjh9L/ypZbA4iY5EWK5sbwf/JgiPppTnR7Kx6O/LA8fp0ip8DPBpqDgo3S6qoxvLkUb4rh4W+Pn92Bjgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CzIFIyhtCHYUQoe4dJK/u3PKq8q38sERGr1vxxQQk8=;
 b=hJu1Y1nrqbGbxZgA8SJnx2/sJ1WdKt20yTBk6I0chWCggH5xMsWtroIS7f+mr02Ihe74htL2kKcjQLYqPVUHgpOZ4VCBPCZJzLBdjlxbm9UyQ0a5QBoGa9PEwxv6YNLequmF5GcJE4w+OcSDzRY+vgvftNV5EFY8AfVw4jWJeIk=
Received: from CH0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:610:75::21)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 14:55:14 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::cd) by CH0PR04CA0106.outlook.office365.com
 (2603:10b6:610:75::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 14:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:14 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:12 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:54:59 +0000
Subject: [PATCH v3 04/17] x86/mce/amd: Put list_head in threshold_bank
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-4-8ffd9eb4aa56@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: f6176b4b-fd01-4612-f78c-08dd7c2d8743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2REeXd6SEo4S1k3NzJVU3JINkJZcGNsYzVWbUU1S1JaOGMxUFh3N090NlpI?=
 =?utf-8?B?cDJkWUhhdlc5QUQyRE9RbmlZMlpDbjFpWDRINU9qaTNTWXZMamZhNVFURm0x?=
 =?utf-8?B?V1ZYV2F6Ymh1N0s3VlpDelJ6VVhDWEE3M24rVVkwVWRRWVVNY0tLQUd3QWg5?=
 =?utf-8?B?MzI0MVlVUlN6eGt3a0E1WDN6UjB3SXB1QmVRY2JhUGNpQ25wNlVvTHpmc1l6?=
 =?utf-8?B?NDhwY1pZUkRoOFdYc284SlB5MWpMTGlWU0Y4K1hxbVowNGhzaVM4eUppeGxC?=
 =?utf-8?B?Y3Q2TU5GdzE1YTV4QkFlUUpmbXJkWUNQckErVGVWSElHR0hRYmRNc0VxejY5?=
 =?utf-8?B?WGpJQnVLdy90RkJXQUpTQlFsUkMrZnVLcE1GR05taWd4QVFpbVBQdi9UTUhu?=
 =?utf-8?B?L2JHSU1rVjlFS284amJSL2plUTllWFZpTVVtOUU1eGM1UVV5cUIwOXFqdzBp?=
 =?utf-8?B?Q3NMdVh6Y3lkN1NtM1R5bVNQa3pqOUFMNlJmdTBvTHJvRjU3OGVVUU1wVDFj?=
 =?utf-8?B?TFRvMUFFblF0bUxvVzcxVlZtNmdobUh4elpvMCtxSWg4YnhpaHVObXdSQTVS?=
 =?utf-8?B?SUQ3RmZma2s0Um9Nd25iWTFKQVNOVWdvYVkyV1dtWmpIaFJ3LytwUytvSzZ5?=
 =?utf-8?B?cmlaeHRwaDZ0eUZkNmV6ODB3UnVKZ205UkFjMFM5RXZEKy9HZytUSWRSc0tH?=
 =?utf-8?B?dXNRM1lMWFhDaUYvVm1oWGRYNEZodU5CditYZlMvMysyU3J6V0lGd1dhbGJz?=
 =?utf-8?B?dCsvU1BJVFI5cTRwU0t2dFdPUHlvRE1McjhsS0YzWTc2dWZLR1A1SnQyQjZr?=
 =?utf-8?B?VlQ0emh4eEVpRTJITlhQOUYvcEtLS1orZlhmRWVyeDkyU1FWeHhBdkttSXlG?=
 =?utf-8?B?TEdlbm1ZSFdVbnZxdkZNamw5d3U1MVM1VkJjaitkWGxYcHBxbWNkdmJRa245?=
 =?utf-8?B?V0xwMEdGUjhBSUZoSW55S2o5UUVMNDZHWThSTnRIbVBTT0kyc3lnc0Z4NlpD?=
 =?utf-8?B?blU4MkRBM2Zkd3Y5NHBYRm9RdTNsbnkxbFphaVo3Vmh0N1Y2T0U5eE1iOWth?=
 =?utf-8?B?V1JnbnJibFNqQVpWSFBNKytUa2RwcE44M3hwR0NSN2E0MExaTHMzcE0xUC8w?=
 =?utf-8?B?d1owSGlheTZwWnZpamZiQzlMWXBMWVZvSnRxb1V2Q3VTRzg0dzBSY0NKcVpI?=
 =?utf-8?B?N3h2azIwSlZxckRGZDJIUitld1lkUnJMbCsvMXY1NHN6UG9kVlBMTVFqSzFo?=
 =?utf-8?B?V21tM0g2OExYcldhR2lqUHFZcWdYQ1ZaMEJrOVdocFBkMmxhNWVHWFFDQ3pI?=
 =?utf-8?B?UHUrSGc0NDFtaWJSVXlqdU5VTlYycUpmT2RlT1JqTTkrYnd3Y1NCRUlCTDdO?=
 =?utf-8?B?VWcwZWR3WVFJckVrUndiVnpLT015d25rZDVjQzgwMjJTZStSVGJhUytjV28z?=
 =?utf-8?B?SkRMQ2Q0Q2JGbXk2WkJuVnVMbm9XOUZ5MTRBb05JQ3lFNlhpUklUdEszY3RX?=
 =?utf-8?B?NkRSa0NCQUVJa1ZyZTNRdE5BNk0rRS92WHJEOGRMNVIzZVo4K2l6dDhpbGkz?=
 =?utf-8?B?MG0reC9qOXhJY2Z6RGhwd2RSWlVtM3I1Qm1nUEhMN2NsRXdRc0xENjV2ditL?=
 =?utf-8?B?SXRwUG00Q0NSOUtQbVlvcmhvVnJXZXNBR3dibTZsL2tkcHU0UWUxSGxVanNT?=
 =?utf-8?B?dlM2dlV1RGFKTTdHazNncjYrZGVmUDhzelJyUTN0WndmdG1hQmFDMExjTUpj?=
 =?utf-8?B?WFpubVhpYnlpTjJRVFVSNHRHMWpiL1B3ZzF6d2JDNHJDMDRyb3pYVGF2OEdn?=
 =?utf-8?B?MHFHNDVJVkN5NmRHSmlPTis0V0ZZV2VEUGN4NzU5bXVZTXRHbWEyNFl1WWVp?=
 =?utf-8?B?T0hCVzgrMHdOQ0dXRzhEaENHOGhObWtqTjV3eTlvaU9jTklDK2dxTlFGNFgy?=
 =?utf-8?B?WHl6SWlWb1p3R1VtbmNBSFR2eTNKZXpIQXlidU41OVRZaWw3R0drUWZOSDlN?=
 =?utf-8?B?RGVndHRVSm9KUTN2ek1wSnlXM3JSZkNObDh5WWxySS9wU1d5bnBUMkhkV2lY?=
 =?utf-8?B?dkIxVERHYzJ5eGdBNTdKUCtqcTJsYU9vUmRhdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:14.0604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6176b4b-fd01-4612-f78c-08dd7c2d8743
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953

The threshold_bank structure is a container for one or more
threshold_block structures. Currently, the container has a single
pointer to the 'first' threshold_block structure which then has a linked
list of the remaining threshold_block structures.

This results in an extra level of indirection where the 'first' block is
checked before iterating over the remaining blocks.

Remove the indirection by including the head of the block list in the
threshold_bank structure which already acts as a container for all the
bank's thresholding blocks.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-4-3636547fe05f@amd.com
    
    v2->v3:
    * Added tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c | 43 ++++++++++++-------------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 46ff41c1b50d..8e5a07f78346 100644
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
2.49.0


