Return-Path: <linux-edac+bounces-5071-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 553C4BE4A2C
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 18:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15BE34FC802
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C2F350D7A;
	Thu, 16 Oct 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gseazm1G"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33612350D4D;
	Thu, 16 Oct 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632694; cv=fail; b=kSVDqyHXXdtk4x3Wh7DjfUUQ3TDmlmCCt9d/zCXttPJexnwHxMwQFoIvhdvAn2CsC6r98g+onNSQIGz2S5lEDu0ghVZu0RoiiGJSeqVqat2HaG7SxntKMALAK2FZNGW+ENwt8hg+cTZbxHPyf7IhwC7iVMJ3cpsVIEG0MBn2m2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632694; c=relaxed/simple;
	bh=JRSYONUSXjIFywywzO+jRT+mjhkOb97BfE2cu/PFytg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MBeysnVrv845PSLYblN0yefsj1/XXatGlKX+V/+uTHAkUAOxEchq5KLJg2rzMW22xypTQOS0Eg705Eql8s34Fs3xvLHfSFGKGmb/6yuqwNPtqa8pfuttwDbJWGUVHviVM3ioaKQA07pysZIJut0zWsMhC/+DvUsbf488/Toykzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gseazm1G; arc=fail smtp.client-ip=52.101.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWzN64tX5DClKV2V62F9WrZzMKITJY1jjaTowWGzDkSP90uxf1vH4h230ww8xup6VlOwM0DHy2VZ6Oz1YD4vNScb96W1fB/xwc4l2c4x8Mq0vxWah7UJSDcExjLzS9ig2vtoBN8U5knmzgBM/3YaiooNLMO3lKF2qoEvVyMWUp9xXoTadTM2ceULmhLpZ5g/PcruCU9WSyS2aSjz98bPJ5QWU55w9agFomL5X5EQxgqSZwSiy7awJCt7NrC+W+LADpMowdlAP92lGxFoJe/hk7ICm8xY7cP+ancASP0qin2V2EPZuygrDFzOd/mn83OOlyzlU4DqaUJ4cjU/h/4UuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijMGDdtQchtOZrygvEiIEgxiMFVDsd+BzpUYraYFQ3o=;
 b=OrQEpa7pL28r3BMESL6zpUnSs6WcniFmuzmyxxbIbVXS+lUZfRZikzjWUbXY80F4ERV0Fh3AhrbMm8eHvnEVlr8fmloQyDffFvJ2s9wH+PEt6iV86a9awGYxmVVpuBa8aN91ZaLs0EhTJ3X1Bmc2tfphXfAfhdjolg/9puxRzAveVOiC3sMDUvXhsfBTQS91QaDgS6IOhISPOBvIFLgmkWJ8UU2p9Q2QOXt0By6olBEMsjbhyeBOoZJc5NZ63EmY38DRAguuJOw3Ip1x2G9M4a9F+Rgb2gO0EdXpXR/l3kSytjoSGKo/i8daLhQxG5dDGSI658u/keUjS8Ea1MT83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijMGDdtQchtOZrygvEiIEgxiMFVDsd+BzpUYraYFQ3o=;
 b=gseazm1G2D68DhTdaSp8sj8YGNqCqdYg5M5Qze9HM2Qvg7puE00FD9LZ0mPtWZOsK5wQo9Ed5BC6QTJ5SJB1vbBGZbD/9qaIpl/LbXA0OuuV3oc+0zpYPFBtUZrs3MNxxujZ4q/iwSNHeHSA9296xlqDYYA6ckgjH/PBSGuVj7Y=
Received: from BLAP220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::30)
 by SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 16:38:08 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::22) by BLAP220CA0025.outlook.office365.com
 (2603:10b6:208:32c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 16:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 16:38:07 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 09:38:03 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 16 Oct 2025 16:37:51 +0000
Subject: [PATCH v7 6/8] x86/mce/amd: Define threshold restart function for
 banks
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251016-wip-mca-updates-v7-6-5c139a4062cb@amd.com>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
In-Reply-To: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|SA1PR12MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: 51648ba0-ac14-4ab5-676e-08de0cd2632f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0dBbW54cHJSd2poY2o5TEZKSVdOakxUSXNRYnlpNlY2c250cTFSOVR5Z09q?=
 =?utf-8?B?eStZelVIOW1QUlZEeko3dWpuMmxPelpNWFo1d1JWcWJYRnQ1SXY1L2hkV0cx?=
 =?utf-8?B?UGpjRjNOZmdXVno5NXBsVlY4WWhady8rZG9ROUsxKzhGL3pZckVhcHgxbHRm?=
 =?utf-8?B?VUF5WUxFaWlrUHZid0xBd1ZGc3l6bXl5MGlMMzdOdHB5UHFicmowMFVCbFZZ?=
 =?utf-8?B?eXZXd3huelNRMzNJOVhzSGtCZlNuclR1d2pmNVdlSUQ2WXA4bnZKemxLelhy?=
 =?utf-8?B?cHVrTXc2TWI3MjFtZkJVSUFUYXI4THdWYmpFSHE2U0Q3YU1WbEhhRFJ4S25T?=
 =?utf-8?B?M0ZHNHE0c2N4VU4zdzFCV21VSDBELzV4MmJzMnpIT2F4Rmp4STNKOWxSMG5t?=
 =?utf-8?B?eUgveERBdDNLdlBRajNSY09RR0YyOTB0UG4reEhEcVh1S0lGbXNmTXdMamtJ?=
 =?utf-8?B?NXNzVVgvUThZQ1kwUzhkaS95d25hYWFaTXZlenI0dkhXbEdOWGlMaVJMcTVI?=
 =?utf-8?B?WDVPTTVFR3Rua2IvV1ZkZjRWUkt1UHM2UlNKcFJ5L1BsZFVBb1BQNFRWbEt6?=
 =?utf-8?B?YWRFL0l3Mmd0TmQ1VXZ3bW5vdGx0NXp2Qi9Ia0dPbDJFWjZaWW1nR2NsWVAr?=
 =?utf-8?B?SzkvK1RsbFVPR3B2b24xQ0taRGYxaDUxT1JScExLakw2NFVaMjlzaHp1MDlQ?=
 =?utf-8?B?ZkRIMlpyS2RUajlSSG5UQys3SDJtVDA0WDdJdy92QThlSVQzbHBCcHh2SkpG?=
 =?utf-8?B?S21iTUNReWdBbnFLK1dLWHZzS3M4NWQ3bzcweWxqT3BuTERBOXRyeURHb3hJ?=
 =?utf-8?B?WmFjWUhpay84a2hhVFQrbWhTVkhEV3RwKzdqa2FCcjF4RTB6QUZjWUNIaUdL?=
 =?utf-8?B?TXk0cWNpQzJydVRpZGovaVViay9zSFp4N1dvU0ZFSzRyWmVnQ1VLZ0ROTFdV?=
 =?utf-8?B?NFMrV3hiVGtWYW1DOGx4eGFiZzdwWWxLTkhlOTZQamdaRW5DMWtCcHRTMjZG?=
 =?utf-8?B?WnQ0MGFjdnAvZm1tN3h1Z3hpaVhBSWhPbGVWcmVaM1FEemZKR3FDTE5PNUZR?=
 =?utf-8?B?R1pZTHorYUJSaXptSU9QNlhHc1VlaENYRHhJYzdwM2s4cGJHdEFBNkJndS83?=
 =?utf-8?B?NVFSV0FMa1RldHgzMjBUUENFUXlOYWNvVzZKSU5kV25lcUdKYi82VWZSRGJT?=
 =?utf-8?B?Z3VtYy9RVWtBT1B4YSsyblhLR1hPQzl4UDlPKys1dkpKSEgydVpNVk9BSDBx?=
 =?utf-8?B?c2lieWU4MnpKTHc2VHFuWGlnM2EvR1ZXbWk5YVRoa00yWVpOUHJlOW1Scms5?=
 =?utf-8?B?UWdKOEN5dzVQOENGRU5HV0pVeTlsSm5POWc4U2Z3amgxYW5VWTlXcXpHd3A2?=
 =?utf-8?B?MGt6NXdSdVNYaWFYNzJkLysyK3YwcG9xdlVTak5jMzZsREV5dzJkSXBwOHBI?=
 =?utf-8?B?QmZrV1FZM0dUN3plTEdKQjJXTk1FOVh4TGpwSjJYaEc3UFJHSy9uYncrZU9y?=
 =?utf-8?B?V3UwYmNsZkJUd0t6TGRLeUJ0WlptcC96VlBVV2J0Sm1tRkQ3VXFuLzlwOER3?=
 =?utf-8?B?S09GZlh3ZEo2YTl5WDBUUG0rc1hyVC82YVp4SE5ZTTZ1MGZGOVkzM0JwNmZK?=
 =?utf-8?B?TzdiVlZEVncycmJvT2Ruck9ROUplQTdyMjFZSGErejVycWV1NGt4SzdjVlZW?=
 =?utf-8?B?RmFNcU5wa05FN25rQTN0K2h5UGxIUUsyMytYZEFXYjUvdUE0aTBSa2JBM0hz?=
 =?utf-8?B?eUJZZUVCbnAyZC9WT3NvUml5RGZTMnRYT2dEN2NWb3J6RlB1bXoxbys5eXpV?=
 =?utf-8?B?NXA1VUQzVGoyVTExaGdwUFZNcWUwKzc2MTd1aFFvNWhheUxkbmRHY3NmdDl4?=
 =?utf-8?B?Z2N3VVRiQ3BRcm5MMk5iVWpxNlZieEZCakdxY3FkekplSERIeFBjdjM4SUxB?=
 =?utf-8?B?RVF0L243YjRoUHpIQ09qZ1cvak1hQVpYMi9PaDJGeXJtM0dsdGsycHdqZjVw?=
 =?utf-8?B?dzgxZ2lSaDR5WFIzSXdwTVV1bkdoRjg1Z2s2aFc5eFh2RUZUQmNOVCtyYXhx?=
 =?utf-8?B?L250UGsxSDlaYlM3OXU3QW43c2tqeUc4cVBGNUFxVlVoRGgwWlNXR0VBL0Qy?=
 =?utf-8?Q?Klzs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:38:07.8999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51648ba0-ac14-4ab5-676e-08de0cd2632f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700

Prepare for CMCI storm support by moving the common bank/block
iterator code to a helper function.

Include a parameter to switch the interrupt enable. This will be used by
the CMCI storm handling function.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250908-wip-mca-updates-v6-13-eef5d6c74b9c@amd.com
    
    v6->v7:
    * Add tag from Nikolay.
    
    v5->v6:
    * No change.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * New in v4.

 arch/x86/kernel/cpu/mce/amd.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 29f777b404cc..dd485ebae267 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -471,6 +471,24 @@ static void threshold_restart_block(void *_tr)
 	wrmsr(tr->b->address, lo, hi);
 }
 
+static void threshold_restart_bank(unsigned int bank, bool intr_en)
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
+		tr.b->interrupt_enable = intr_en;
+		threshold_restart_block(&tr);
+	}
+}
+
 static void mce_threshold_block_init(struct threshold_block *b, int offset)
 {
 	struct thresh_restart tr = {
@@ -814,24 +832,7 @@ static void amd_deferred_error_interrupt(void)
 
 static void amd_reset_thr_limit(unsigned int bank)
 {
-	struct threshold_bank **bp = this_cpu_read(threshold_banks);
-	struct threshold_block *block, *tmp;
-	struct thresh_restart tr;
-
-	/*
-	 * Validate that the threshold bank has been initialized already. The
-	 * handler is installed at boot time, but on a hotplug event the
-	 * interrupt might fire before the data has been initialized.
-	 */
-	if (!bp || !bp[bank])
-		return;
-
-	memset(&tr, 0, sizeof(tr));
-
-	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj) {
-		tr.b = block;
-		threshold_restart_block(&tr);
-	}
+	threshold_restart_bank(bank, true);
 }
 
 /*

-- 
2.51.0


