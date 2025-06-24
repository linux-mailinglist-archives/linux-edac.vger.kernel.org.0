Return-Path: <linux-edac+bounces-4222-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91F2AE6870
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7731C5A6F88
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5B72DFA2A;
	Tue, 24 Jun 2025 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="48Lw3YCo"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529392DECB1;
	Tue, 24 Jun 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774601; cv=fail; b=ljUUY9Vgp0BMOTgYqnGbq64+453+tUZTxvnJW16Y5Blq5MiDILgfBbPaeUIcQ7EOLykQWDzN0cISIVAW4cDDXM0xP1P5LI0IAj+0xDt3vaa/npG3ixT1XjMWZw6ZQbQIi2EieTWMX+17ijujm20FaiyWK/ObTHJv7Dvq6LOo29E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774601; c=relaxed/simple;
	bh=+OBqsGLfZ3+8WQrkO9asniDcZU2PuE2D/qB1LgVIcVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KVzMVc2ceY8I2oqgc17B35roPIst2v/+JCFc+op6cIYCYX7xSBVnpZ0AvMCACv/3Hwz+Tj2gNNY4/TDjcHQxb2pFiFpS5TzhHARjpIyx3o3C2ET2Qb8iKdYT3Z9O++L0PyAvMeOYW1rKKvuycXSvSK8rhBzi87Irur/KkbgyvjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=48Lw3YCo; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xq/PjH63QncewFd/Uku4qhHXPeEqO+gwKBZS/ZRgUaPUI2kY4dHjCTSb2bJpI4kz4mWKh0AvHr3H3kMd/QXbNP6LwJsDUKcZcp+6LOKnrh5nGXACCQqh4hmioIzoIhwBe3Pm2C9+Z9ihmYjmRwBZ8uUGaYdin8eOSU80fFo/CZKxXwa11v1CkKHct1AsDee5jp2jjez5xV/xRlN1zgszHlHBjvDOODtOWh/iW9gwEuSR26twUoBZQCIqYqY3pN2Nty5qVPtsY6674XLvc9T9BjZoF/zbSj7u6PPdE9WLzX+X3jCeP6MAU/NuT3p15S1emn/Ov3kZmCqAD8IpcOa8EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UFEnDw9WblrUWx0SuQx8EVQOwDtHAc7xpXHV6xWDV4=;
 b=iYX4UtQdqZ6zaWXmukKNM1ZYDU1h4tIWt6Xbaqnirnb0q0pMb+JqV2QxhCNY4X29JF2NeKgPW3/vegyhFDx1rHLfaQoOyzxYstdMTjxAR92JfG7RIjYsm49OuQUBpNsg88iufDrVDhPqXvYTJT9/4rhD8hmbWiVOYrFxw6EW9WJ+0KeFkA3dpxP9goL3g24J/jVXkmmPhhPlc+A3FiioNMP8Il0BCFDhHfrJZdTxKMifFSuIcvjgz2B2DgkIAvdQPjOk/J+zeAHkwdlS+BPCSOMejXjXtb82/XLMzz7pOXbJjrF5ceBZl2fP+MLJbd3FNC70NfEOATBOX9CzOwsfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UFEnDw9WblrUWx0SuQx8EVQOwDtHAc7xpXHV6xWDV4=;
 b=48Lw3YCo6XAWxmgjHeFjDP2GHOqVFI1+mC27Av5vP7GXxnTSVIbvUZuQ9TikS0csH6mXxv97O6COvEPCe99D7sib0BOQ+ccpAxFj8IlQSGqsCat9yYeWOLVrMy5EUXJQgApQ2zJOYJhy8Rc8CyTdHF+nDU/yTwcasCzGJU3K30Y=
Received: from BYAPR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:74::17)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.25; Tue, 24 Jun 2025 14:16:36 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::1b) by BYAPR05CA0040.outlook.office365.com
 (2603:10b6:a03:74::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 14:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:36 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:29 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:03 +0000
Subject: [PATCH v4 08/22] x86/mce/amd: Put list_head in threshold_bank
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-8-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 288627e9-fc96-49c7-dfe1-08ddb329ba8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWJ5RysvSDJjSVVPM0V2K0wxZ2c4eWpTY2tUcTlFVUJGSGN1djVXemxoVmRE?=
 =?utf-8?B?VElxWGZ0VGpYOWF1RjdzanIxSWszRHNSSCtPL2pCcHExZE9MZTdXdzBwM3dT?=
 =?utf-8?B?SWhOdmVPUGtseFY5SWE1TXJjci9IY2ZlL0dlZDlEdDN2YjIwcU9LUU9qbUZG?=
 =?utf-8?B?RUk1N1NaRDRLUGhCSnNmbXF3SS9rd01zL0E0UmF1ZFRJVEN0RDNsbE9Bdmtj?=
 =?utf-8?B?cHJMaWdaOVRBZFR6ZGFIV3NFR3doN1U4NnNBSnczWTFBWkNLZ1FRYlhwd2hV?=
 =?utf-8?B?cjFISG1oc1ZuaHkvQThSdU52U1BwVTY1b0tqVFdIUWZrQ3Vhby9VbU9nQW5z?=
 =?utf-8?B?MnZtUFQ2TWc5d0pQakIyU0hDbFl1aFdkR0JBRllkcDJyU0tQUDY3S2pKSHpF?=
 =?utf-8?B?dHhmeDlEZjBTTlpmOGtZVXh3SEpRSXRjaG1URWRTdndneDdRR2V1OEl6UFV5?=
 =?utf-8?B?NXEwNCtZbEYzUkhuOHhNaDBmTjZTVUgwUkQzcHdUUEdvb3grMmpQUXA3b2Nj?=
 =?utf-8?B?M1RIeXpDMVVMT29rUk0xMjlRZTN6TXY3aEY2WkIrb0tYbFYySlFBNEU0d1gv?=
 =?utf-8?B?ZEpnVTBydkkyT2EvT0FvUzFla3NLUnIyeVVBeG5Ca2NsMHNSUSs3ODBXTlAr?=
 =?utf-8?B?Yk0yZ0JUbmp3YVhleXdWTVJ2SHhHeHB6M1Z0Q2lyamxRK1BCQ2JRMlBid3Fy?=
 =?utf-8?B?NVZqNnp0T3RScTZHSzBuUHJWSytRbjI2WHZpQUo2eEF0ZFA5K0NhcVFuWWVR?=
 =?utf-8?B?a3NGdnBVTWdTQ1NuZUgrS25TR08rUFlrMFRPNTJVeHpiSWxCQ0o1VnlMZWNN?=
 =?utf-8?B?bkEvMWgvU2QvM3hJRmVTV2tkdWNHZ2U2SnA0RHlEeVVwSkNEVjViMVc3YjRP?=
 =?utf-8?B?N3NRT1NrYjhMRGFSdTRFY2lNVjR5S1FXcWpkZEE3UE9CMTN4SHNnbmU3ZDZM?=
 =?utf-8?B?cFBOTFNDRlN1ODJKWXZrZ0c2N2gvVHMydGV0RWUxYm5YN0pwVHdTSE96cnZy?=
 =?utf-8?B?U3BmZm1XZm1od2lnNXZkeXJKMjkyWkNxS21LZ0tobEFkSUxMOUFXakJSSmJB?=
 =?utf-8?B?TGhjK0FFNHEvMmNUYnU0c0FwRkhNUGJ3N2x1QWhqWkZQOTNKVkQ3WjQyc04y?=
 =?utf-8?B?OEtSVGdYWENvc00xcnI3OHdtQkFOS1pXU0E1N3Zsb0t6ZGpmNEpGdElMVWov?=
 =?utf-8?B?bm5kdWpGL0xGUnZHMUx5bDdDOVdIZzVFRGhvNlY5RzRHYWZRS1hWOEVwSXd6?=
 =?utf-8?B?NHFlSUVKYzl4NkFiYmEvdVI1NkdvckFWckdRM2UxaXlrUnNPTXhLL0pJd2VC?=
 =?utf-8?B?a3VEOWhJQTBtZ2czdUEybnh1ZEhscmdXOXZGR0FqZkV5dktSOThaNGcwY3JG?=
 =?utf-8?B?MFFWS0FoSitjSGhsR0lTWGt1cGdtNlFTaFRWdTJuWDYrM1JRWURmRzVlbyt0?=
 =?utf-8?B?b3dCemlJSTZPOG9oZWw3ZHRLd0VmZ2VleHdJRWY1MlE2bEsvNCtqOVhJRldz?=
 =?utf-8?B?dWZUSHQ3d1JmbWpFVDM5SmZPK3QxUm9DUzVjcWV3TGI0MklXOUxKVVB5czdU?=
 =?utf-8?B?b3IzWmd4WXhvbG9CS0pITzFLRW0rM2pMK2N3WkkxZktTSGdvR0l2cUJJY3kw?=
 =?utf-8?B?TkdySUo5WVhLN1FCdUdyWWxsU0MwOWEzdDZCWmp2THZ2M1RtcmRVT05FcGw4?=
 =?utf-8?B?Rzlxa0NTTUFkeitxbHJ6NVRoZllzSisrVVJ6eTgrUEJVd1FTTGI2ZmtrNkZm?=
 =?utf-8?B?VWJRejF1aHZ0ZXpSTDk5SVYyblNxcFp1NjZNR2hqakt6azYzZ1NXbDhJUXZS?=
 =?utf-8?B?a0hlUDdQVmkzQVpOMGF0b3ZtWWxyNGZJYkpwMExhL3cwR2RVYnNRL2FqSEIw?=
 =?utf-8?B?aEdFbVhiOUFIcWIrNTRGd2FOSkpsdVZpQ1MzRTlrMzdCRVRONXRHUVFLSWZ6?=
 =?utf-8?B?RmNzTXlRcVVHbXlkU1N1UmExc1B5QUtZWDNVdTFvdXVzRW5HNzVGclM1b1JK?=
 =?utf-8?B?VHRTOTRvdDExZ3QvSWRkOERHWXg4UVNFVis2RnQwTHF3SlhnRmJ6MGlOQllD?=
 =?utf-8?B?Vm14WTVuK0tOYXBGZ0dTNGFUZk1pVnFhMi9KZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:36.0037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288627e9-fc96-49c7-dfe1-08ddb329ba8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814

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
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-4-8ffd9eb4aa56@amd.com
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Added tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c | 43 ++++++++++++-------------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 0ffbee329a8c..5d351ec863cd 100644
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
@@ -900,9 +901,9 @@ static void log_and_reset_block(struct threshold_block *block)
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
@@ -916,16 +917,11 @@ static void amd_threshold_interrupt(void)
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
@@ -1151,13 +1147,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
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
@@ -1208,6 +1198,8 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 		goto out_free;
 	}
 
+	INIT_LIST_HEAD(&b->miscj);
+
 	err = allocate_threshold_blocks(cpu, b, bank, 0, mca_msr_reg(bank, MCA_MISC));
 	if (err)
 		goto out_kobj;
@@ -1228,26 +1220,15 @@ static void threshold_block_release(struct kobject *kobj)
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


