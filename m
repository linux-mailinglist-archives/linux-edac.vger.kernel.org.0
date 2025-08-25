Return-Path: <linux-edac+bounces-4662-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7ADB348C4
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6165E4F83
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A395F308F0A;
	Mon, 25 Aug 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cI+CggbY"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C123002A2;
	Mon, 25 Aug 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143229; cv=fail; b=s1R9ezcscHe8jovBMi0UuptBEP7DFfYHw9D7+i9GVrEXw9d7jtFXQTuAozMAC2u6jod7bIU/DUdA/P1bBDks9RzfK4T/3FKbDJDCnX1VwdxVzkvi84oD9ur+rWmLnZRwqqWRThSqrMsyOh4a2xuxr62hHjqmKejFl+T8Ui/w5IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143229; c=relaxed/simple;
	bh=DfP5K+6RX+JQF1o165IRVuwIS5FiaycyGhyvXgXi5AI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Rq8oyaoJpw50CWURv1uZGms/XsVLeM8iks8mEQOC9LKsYBdF6IF1YMKg43ulSrkO4xcM09zGP7qwCQAzsYRD+WHz4/yWk9Ppgxclaq2HC9W7dGLWiGoxDLci9guFmfYbBdrbropVHW5Q9P4FCM0Il1TDwMMD+SZkDtfc9MAU90M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cI+CggbY; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YU8/JTEtGnLyraaFu/B2anhAZZRTk4wt19d4dMiZjmHGMej2aTPNdBtUHZqmfqGagFnDDTd7JiyVOY/fzBdaeita9mfwC7PUhHJD5SRzXOvU4LURWxUqGwxGSY28RKCYre+klxkNffRIV0oRtmlmHqMrx0qAa2wduLKwLQmqq+ps7x+XHnk9AYIQrC0dumqdMatbJ+RTeBnGDnblq6A2vZ+uCXD+tUAG5HDpq/MMG7ED4DG7vxrkEE1gKtYPllqlSDldcm9dov3ynOYerfqpvSVvYSG2AUuuQGTp07AUOuEsir52tD3+lHcMCGDpbuMhNdT2KMETiC/ZTHTByr+5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NizmtGAK7zyYnTw+XyGDzjPs3XeTnttCY9qlce4ojz4=;
 b=sLJ+UUP2ri4e6rVwwUsmlfsvcyJU3G8xloo4oBuHppWH20uqzc1m/BGqNlI0yGgK3uhxXMRys/1ffbWmhdfO8iy1PD5lbMinbPUrTGS9/2Zt6/KiGI6iKIAsA80cxPH6ZBw5iAs79XeZgFvd6W6EI+pKOuK1qf3QRqHnkcnODuU/0H+4oYVcoDq/24cmPc948xB6lDovHJoZVi5rQJvG+gbuJThaWKIjB0fgzMqo5o0vrJ1VzBDHwXjKLKbadibfOMHbQiMwIjnkl8fAYtEvpUag1NT0hm/y4W59Fg0373J6ar1nBdp+tcLZw5mwLq7ckeViBwuWs8Hjdle0iPJBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NizmtGAK7zyYnTw+XyGDzjPs3XeTnttCY9qlce4ojz4=;
 b=cI+CggbYCPR2qFHkUzo/R75yK300qq9IFDQNHU3grGu1ngod1UZ6TamoVOwl09WGKrPB8Y3YaAb2D/gTfC96lKH0VJsdIzbdYFUsJhJxImSPaPsBx2hr9YQQ1CVzTcfE9ZOt9g5paNmqXCNCVgBMUaRyUtnLCI7uo6FUALiDCzU=
Received: from SN7PR04CA0058.namprd04.prod.outlook.com (2603:10b6:806:120::33)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 17:33:44 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::a) by SN7PR04CA0058.outlook.office365.com
 (2603:10b6:806:120::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 17:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:42 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:37 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:01 +0000
Subject: [PATCH v5 04/20] x86/mce/amd: Put list_head in threshold_bank
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-4-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA1PR12MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 01adc928-8df6-444d-12a8-08dde3fd8987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L24xc1dQRDQwNTVoN2xBeWxmN05oeDJnRXFaazB2cFR6K01lVkNBMjdYNlds?=
 =?utf-8?B?bUxCWEJuYXEzL01SVllhVEJPZkVRUm00VGlNWHF0Q0hBbGVadWRtdUJCbEMy?=
 =?utf-8?B?bnE2T3c2WXZEUTFMTUxNcWc5cXFSZUV4dURiaHhnZVE2WUJuMEdYRDFBSFBE?=
 =?utf-8?B?OTBtRCtQcVY1ZThYbGVhSHJHZ0hRTU93TzRHTWJRSG5rMFE1bGF3dDlDN0lP?=
 =?utf-8?B?dkIxczdEVy85NGxhSEVTNHZsR2ZURmpRNVVaTHhRQWtBUFBONHhkeUZjRU5o?=
 =?utf-8?B?ekc4TTB2MjEyNnprRkpjcEl3enZ2Mmt2SG1FWUh2UGd2ZDJrakkxOGFzamlt?=
 =?utf-8?B?ejlTZTE1V2ZGSXdrMWdkWnVwYnM4ZVByUzlqS2prN3NnMHA2RzZmZElwTmlz?=
 =?utf-8?B?MUt3SkRDa1RPNWo2SXVVbStnYXcyZ2l1OVNzdEx4SERXQXlKZis2QjVBOGd6?=
 =?utf-8?B?ZDJ1ZjY2M0RtcmxFTmJTNGs0eXB6ZDhsZUJsSE5xY2xZQ1h2UkhjMk85WTNk?=
 =?utf-8?B?amRXSHI2dEYyZ2cxWVBWaXZDenRISUl1bDhRS2FXWXNib1ZjN3RXOFgxcU5z?=
 =?utf-8?B?Y3MzWmhWdHRnRVcwdVB1SVByRUtSMHBHbGhDZlQydnZmMHh2UVJvZnB5Ti9s?=
 =?utf-8?B?R01Tb0o2d29XS0lLcnh2Q214K1VlK0gxSndrQjFrZWZ5TG5sMXJ4QS82NWVC?=
 =?utf-8?B?eHl6ZXgzTDRrc0tMOTZpdXp4THZtN3dMTXZiNnBVYXN0eXJLSThlaEVjbkpy?=
 =?utf-8?B?cmNnNWJtMlJuL2QxWmlBMkxGdm9TOTVpZnQvS09aN1FGZklnV2draHZDUWha?=
 =?utf-8?B?YXdBcU9mUy9iSnpBbE5nY3pXK2VXNDdQbklQZXhzdWZ5NnVGQ1h0SGM5cW43?=
 =?utf-8?B?Yi9TalFyZm51MHZCYTljREMzYTVEZmpqWVJzTVhSOXlDT3NyenFubWhLOUJp?=
 =?utf-8?B?S0g1cm5valpiUlQxNWRBNWdORXYvdWg1NG93S3BXUE0wUjdieHBidDZoTFpI?=
 =?utf-8?B?VGdjRmxBL3RVSlEyTmxxYTFxSlhrNHErRkZyczJPYXZ6S1dzNkVMUVlpL09n?=
 =?utf-8?B?MzdqYnNHT3gxWDNjTVRzOXRUNHpSWHJSSXAwYWxmOXAyRmRkcHJHbkZVMnBw?=
 =?utf-8?B?clJJcXJVMFlhQ1N4VmFrdWgxTHBEYWp2T3lnUzlNWHY4aUdLNGxXWXhia1hW?=
 =?utf-8?B?Q0dsVEpZZUxIczJNMW0xQlNjZ0hISlRVSFVDZ2RFck5OamozbkJsNUNqeFh1?=
 =?utf-8?B?RnhFZFNQRFd5UHdteEo1dXVqVzR3My9rVHh6LzNTVmQ5ZUF1d3M0V1cvdWR1?=
 =?utf-8?B?NXhxMWI2eFBoeGs3RGZlS1hESmt1NnFmS0JxdmdXNStMczd2Wm0wREVEV2VH?=
 =?utf-8?B?UUUzQXkwMDZHbjRQSU82dEJLalFXYmh4Yjdod3R1a3JzaElscXdiMlBWU3FM?=
 =?utf-8?B?RnlUVjQxY21Nb1h2dmlXTWs0YVp2QU5XN3NMRVhucFBmVHV6KzVmenREbzlk?=
 =?utf-8?B?SlBVNUR4RzBtdUkyN2R3ZEVzNDUxU0l1MWNyL2JVTFYwQjUvcXVCeVMvb3Bt?=
 =?utf-8?B?b2FnV0wzYXR4c1FoSDc0MkdHZWhpV1o3UXNDaVBGL0EvblJoZWlDbXVXU3dB?=
 =?utf-8?B?enQydFozUmxHMm5seVJsQzdjUFRrQXlVUTJ2ZHA1dVUwNVJ0RE9DWERWcDYr?=
 =?utf-8?B?d1NnQ1g0Tm1pRm1FelV1M1I3Wkh4MDhsQS9kK2Z5RGYvMHVjVzN2UnRkQk1l?=
 =?utf-8?B?Uk1NTS83M09tSHVGcWV1aG5BbEgyVjczMWFJOVZrbGZraUVoQkNZS05CTXJo?=
 =?utf-8?B?UFBYK0F6R3BwUitESU9OOUNrTW84VkUvY1AwSjN6TUV2OEpaS2FjbGVZNmtn?=
 =?utf-8?B?anprOGtCNElsSlV6WENWb1ozZm9XTnZPc3VMVEhOc0R6N2VhL0g1anA1N1ZB?=
 =?utf-8?B?bG03eFUvTkloM1lsVEZNK09UTmkyckNCNmJvM25LZUR6RGtpTm5NOGJ0azk1?=
 =?utf-8?B?UGZ3THVuTjh6VHRXL0trdGVsa3RweS9KSGFyV1NVNEt6SkdOR0ZJS0VpQy9k?=
 =?utf-8?Q?GJXgH+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:42.9386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01adc928-8df6-444d-12a8-08dde3fd8987
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555

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
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-8-236dd74f645f@amd.com
    
    v4->v5:
    * No change.
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Added tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c | 43 ++++++++++++-------------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 580682af432d..54f02bda75aa 100644
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
@@ -902,9 +903,9 @@ static void log_and_reset_block(struct threshold_block *block)
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
@@ -918,16 +919,11 @@ static void amd_threshold_interrupt(void)
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
@@ -1153,13 +1149,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
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
@@ -1210,6 +1200,8 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 		goto out_free;
 	}
 
+	INIT_LIST_HEAD(&b->miscj);
+
 	err = allocate_threshold_blocks(cpu, b, bank, 0, mca_msr_reg(bank, MCA_MISC));
 	if (err)
 		goto out_kobj;
@@ -1230,26 +1222,15 @@ static void threshold_block_release(struct kobject *kobj)
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
2.51.0


