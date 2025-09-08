Return-Path: <linux-edac+bounces-4752-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875D2B49417
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C597A8E9A
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0EF311957;
	Mon,  8 Sep 2025 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FjN7zzPb"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4071311581;
	Mon,  8 Sep 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346071; cv=fail; b=g45YrkvDlyuE+1/ZwLB1MxDFd4LpBZYTMpe2CTYelHOA+Fi1Byg1eSmBhtt3tkm+313UGjh3iUwgaZgnVtfps3Aec5uDC8h6xBc7/84K2GPsTE2z1E44qJw8UP6AU9DCMo1Ey0mPzjekKGWMS0KV5Wvl9iZ/Xg7+0+AprbDafA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346071; c=relaxed/simple;
	bh=BfzXthckq5bnsORsev8z+RF/Q0hPWT1DatgX2IcJkAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jMpZchRo4g9/UQpVVzrdViihmYgT9bmbuQWfvPQMmfJL4AJCznurQEPThAeK/e6Ivu5JdDqLgBKxFipphU9Jkw2H0hp8PEW35hoRu0TnaqN6AnOnI3UjPHwQ2UrI0d/c0+qEpKFNKmzT4rGBgvnw/7NmXSGpb4lhfY5uZ6ScTI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FjN7zzPb; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlInToWVKUo4Nra/R6MZY1eRRGoCgy02PZAQAqX2mjJxiZRnZRu8t+NlknVYd7KupCq7xfMJu3t50MzrraHRr1a0jtamPohR+8XkIWVM3SHnT0xeeJvrOTD235xECsUwSL5WSS83xlTOGYhxLqpi3eSn9KFDAyuNqOd5reWrjjc+LenFX7nnYGV+x8KAdGiWgxQg37vbANj3nXxG0KoCObRWkT5CQzsg2GjTU39KvyWEr/5tIl75y+MSGmABKHGdI+QyYLLChKXcDaGw39Jp3+HLno17nErkAgMkYUtgL2ThatDTOiyLMAdhWzo6DmfxsUcm1vIDUytb7JdIxI87lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/UYfpZbJcnPcDpAo/P1i+dFJfZOuMhWl5XSffiA62Q=;
 b=Myg5RONM9dZCvBzoLGTtvYBc6MGIIqMHNmra0XFz4EA7jr9VYv6q2JaR/rVoyb3lNlDlibe4vHdCQa8m6PN3eaKDu+8+JSOHjh0Bz84PrxTx4GoAB6R6Zhd9S668rPLOc3wcjMCrrgkz9nS0QKUjDRyLe6Ph7ni4PsR53wTBufdFAytcXP+Cw7hwH0vv6cC/kTmZqqVqQmQQTDJ5z+BtkOsG+VXqOtXGICKUBQfi+YbV2gjGfm1KDUYKJV7lmg8P4qpTX5swK5bEH6ec/Hb6XGz/yBFUbTUg6Ifbwu5UKoiiVYdvHQtMxymtrd+XPI4oriyhzA9IuroskDC3lxDzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/UYfpZbJcnPcDpAo/P1i+dFJfZOuMhWl5XSffiA62Q=;
 b=FjN7zzPb0eHvE7pEYy28zH9wHvBIVipmpMlZcn52qolHBEhzZp7BRwFwpAAZdfthGF18egbGMtA9bL6T5Y0yVLTeUgBDqD41jrLIOZHWh2ym1U3W1yDEzGWjUX7J3njnA+9qx8IQrHQkNxKge39zsc4yuXDtUHBVdUb5RQ7XEdY=
Received: from CH2PR17CA0027.namprd17.prod.outlook.com (2603:10b6:610:53::37)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:41:05 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::da) by CH2PR17CA0027.outlook.office365.com
 (2603:10b6:610:53::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:41:01 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:40:59 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:37 +0000
Subject: [PATCH v6 08/15] x86/mce: Unify AMD THR handler with MCA Polling
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-8-eef5d6c74b9c@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: 9359b9f9-000c-4e80-a2c1-08ddeeee1d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NU9IR1RQU3lWckhJVzhLVXArU1hvQjFTRXk3QnZqTUlZekNWL0tyKzRGQUZJ?=
 =?utf-8?B?OEtmODZDZUFMbmRMUlJ6dEF1WlVHenY2dlQwZ3RIODZtTXJPNWxNYkJpS1pJ?=
 =?utf-8?B?c3N1dTYrVG9IUit4OHBOd053Qmo1bUJ5MExRRS9Qa0ZBdDVPM0g0UHBkRmpK?=
 =?utf-8?B?VU43SFpsSHVLbHJubGJFZG9zTnBHTm9NMnJRNFk2cjFBR3dFMlVyYzhOOExq?=
 =?utf-8?B?eHI0S1JkbmMwREJmMzMrNDVhR2xvYVJIWmxoeTFaU0h6MUZGUkRVcm1PRVBY?=
 =?utf-8?B?Y3E5eW5qbzZRNk01UzVEOEdBZCtGUUJFK0ptYWx0SC93VDdvR0YzQi9wSUxI?=
 =?utf-8?B?ZFY3ME94aDhpZ21nVW1NN1RqZUNMTXQzbE96aHdGRllJdXozNDRKTUVMR2I2?=
 =?utf-8?B?MXBXamI3UkFyeUM3MVAybVBqcTRFamYveVdEaDQ2NDFaRjg2clI0UVhVSElq?=
 =?utf-8?B?N0c3Uys5Q05DWFhuSFpvbVBqcnM4bHdoZWJyOGllM2NhcXdmTjNqTmFBbmlP?=
 =?utf-8?B?YXRVS0lXV2cvU2hCNGdJKzhJR29RQU5IM21LRFVFZHNwZUNpTWhZNW90czFJ?=
 =?utf-8?B?Wi9DOFNYckVhbGtZcm1XMEhXUnd4ZzRIbGFjSXNyOVZwQ2JTQTJOaWwwMXAr?=
 =?utf-8?B?MzNWcWpLekNNdVNzN25oL1M1cVdlNnp4MmJVb25XT0U4RFk2Q0MxSk9uWE9N?=
 =?utf-8?B?WGJwRklSVUFrM280Z1JKaFljbTY4SE05OHNpV1JDTGNaL2pJZ0pIQzlDUGZj?=
 =?utf-8?B?Q2RrR2J4RFNPYy9NaU5pajFiRlZjdTB2WUFWMXlGdmdMRVVuVUowc0lHZWNH?=
 =?utf-8?B?RnowREs1Vkpodk4zbEFJTXh0TWI4dzlXZTNMSDhsZ05FcjIwei9ITzZHeldx?=
 =?utf-8?B?bFdiUklta3dtS2p4eWtDbXRwa29CWXloMzVXZnpmTDNGbk9GY0d2dHRaTmRy?=
 =?utf-8?B?b0pncVNsQlB0dmpKZmY0cWwzajI1bXppNkVKSVgvcVFqZFhQNkEzNkJrbHY2?=
 =?utf-8?B?bWFaNzE1dTNjZy9uNWdNd0pBcEcwN3VWQXRsM2tDcS9FK1NOSDZGNlE4aUZ1?=
 =?utf-8?B?c0tkU1RvZVFjTmVOdXB5OTRxTHgzYk02UXBDTFMrbTFoc0psRjRLRVJYUkF1?=
 =?utf-8?B?eVZoQUtzQ3FLUUVyZVBpV2daSlBYbHJzNi9ORk1Zb2c4VkYwZUgwQlJReHRG?=
 =?utf-8?B?SmcwMlkwSDJ2ZDErbnZCc0R2SVNqY014REN5VTFZSjVpWVUzS3N0cXc0a2dN?=
 =?utf-8?B?WnllOVZnL05rK3RRNVZVOVQvbWJ1YnZDdDhRa1dGeFByRzFRV1NPOUg3cmRB?=
 =?utf-8?B?clc1Q0ZFS3l5M3dkQzN5MW4yNGRXZWMwNlB1SG52S3ZUcGo1cTZaN29aRmRH?=
 =?utf-8?B?VUNOd240STR2b2dDaGQyRVlCL3NOWXZKZmNOUTJybUNiTzRPRERmVFc1VDY3?=
 =?utf-8?B?M3RkKzN0NUVjRm5NeXZhbjNyVjNmdzVyMW1GWkd4L0hmbDBFNXpXK1ptc253?=
 =?utf-8?B?akZSYWVLcFFSNkdJK0lDK25XNGVMeWxmRzhzS0krT2ZTNUJtbEVWTGhvS3Fl?=
 =?utf-8?B?NXBTR2FBM2doTnFGZFNsbDNuazBpTVdKbGlvSlB6MVR2UjFKMEl1OVhxaU1p?=
 =?utf-8?B?TGlqNDdnQlBYQ2lXVncwWFpmTTBmTHdPa0pzSGZHbmxubGpUUEk0b3J0ZklH?=
 =?utf-8?B?cEY1dHJtSkdyVHJKVGpJbUExN2hkd2ZPeE1PUHd4b3p4VElpQWV5ZlBNQzEv?=
 =?utf-8?B?Q21lK3dPRmMvWmRwc2w3OElseDRGSHBrTXRKY0V2TG0ySUI0Ty9pQmNNcUtr?=
 =?utf-8?B?eGRiU0RnRFZnN3o1clRKTVh1Y1pyT1VFWGdqWStuZXlpMDV4SE1hUDRqRlJT?=
 =?utf-8?B?RjAxNzJCMFVYUHR0Rzl6d3RldXg5NVVPMW5jTU5od0RrZW1PckF3YWRNRkpq?=
 =?utf-8?B?aWVRcGdhVXMwVS9XWXVHdWp3ZmFXTHhxa1UrSUhLL2pGaUlDY25QTnFTTnBp?=
 =?utf-8?B?QkxsZWt6WmJob0UvdEJ2KzdHTUdGZEd2a2VVN1hJOGdZVG1nV0dnd0JEcTBT?=
 =?utf-8?B?WUg0VVRydnJMOFZQeEhyMkxDd2hlbG1NNDRLZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:41:01.6656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9359b9f9-000c-4e80-a2c1-08ddeeee1d45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766

AMD systems optionally support an MCA thresholding interrupt. The
interrupt should be used as another signal to trigger MCA polling. This
is similar to how the Intel Corrected Machine Check interrupt (CMCI) is
handled.

AMD MCA thresholding is managed using the MCA_MISC registers within an
MCA bank. The OS will need to modify the hardware error count field in
order to reset the threshold limit and rearm the interrupt. Management
of the MCA_MISC register should be done as a follow up to the basic MCA
polling flow. It should not be the main focus of the interrupt handler.

Furthermore, future systems will have the ability to send an MCA
thresholding interrupt to the OS even when the OS does not manage the
feature, i.e. MCA_MISC registers are Read-as-Zero/Locked.

Call the common MCA polling function when handling the MCA thresholding
interrupt. This will allow the OS to find any valid errors whether or
not the MCA thresholding feature is OS-managed. Also, this allows the
common MCA polling options and kernel parameters to apply to AMD
systems.

Add a callback to the MCA polling function to check and reset any
threshold blocks that have reached their threshold limit.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250825-wip-mca-updates-v5-13-865768a2eef8@amd.com
    
    v5->v6:
    * Move bank/block reset code to new helper.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * Start collecting per-CPU items in a struct.
    * Keep and use mce_flags.amd_threshold.

 arch/x86/kernel/cpu/mce/amd.c | 51 +++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d6906442f49b..ac6a98aa7bc2 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -54,6 +54,12 @@
 
 static bool thresholding_irq_en;
 
+struct mce_amd_cpu_data {
+	mce_banks_t     thr_intr_banks;
+};
+
+static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
+
 static const char * const th_names[] = {
 	"load_store",
 	"insn_fetch",
@@ -556,6 +562,7 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 	if (!b.interrupt_capable)
 		goto done;
 
+	__set_bit(bank, this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
 	b.interrupt_enable = 1;
 
 	if (!mce_flags.smca) {
@@ -896,12 +903,7 @@ static void amd_deferred_error_interrupt(void)
 		log_error_deferred(bank);
 }
 
-static void log_error_thresholding(unsigned int bank, u64 misc)
-{
-	_log_error_deferred(bank, misc);
-}
-
-static void log_and_reset_block(struct threshold_block *block)
+static void reset_block(struct threshold_block *block)
 {
 	struct thresh_restart tr;
 	u32 low = 0, high = 0;
@@ -915,23 +917,14 @@ static void log_and_reset_block(struct threshold_block *block)
 	if (!(high & MASK_OVERFLOW_HI))
 		return;
 
-	/* Log the MCE which caused the threshold event. */
-	log_error_thresholding(block->bank, ((u64)high << 32) | low);
-
-	/* Reset threshold block after logging error. */
 	memset(&tr, 0, sizeof(tr));
 	tr.b = block;
 	threshold_restart_block(&tr);
 }
 
-/*
- * Threshold interrupt handler will service THRESHOLD_APIC_VECTOR. The interrupt
- * goes off when error_count reaches threshold_limit.
- */
-static void amd_threshold_interrupt(void)
+static void amd_reset_thr_limit(unsigned int bank)
 {
-	struct threshold_bank **bp = this_cpu_read(threshold_banks), *thr_bank;
-	unsigned int bank, cpu = smp_processor_id();
+	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	struct threshold_block *block, *tmp;
 
 	/*
@@ -939,24 +932,26 @@ static void amd_threshold_interrupt(void)
 	 * handler is installed at boot time, but on a hotplug event the
 	 * interrupt might fire before the data has been initialized.
 	 */
-	if (!bp)
+	if (!bp || !bp[bank])
 		return;
 
-	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
-			continue;
-
-		thr_bank = bp[bank];
-		if (!thr_bank)
-			continue;
+	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj)
+		reset_block(block);
+}
 
-		list_for_each_entry_safe(block, tmp, &thr_bank->miscj, miscj)
-			log_and_reset_block(block);
-	}
+/*
+ * Threshold interrupt handler will service THRESHOLD_APIC_VECTOR. The interrupt
+ * goes off when error_count reaches threshold_limit.
+ */
+static void amd_threshold_interrupt(void)
+{
+	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
 }
 
 void amd_clear_bank(struct mce *m)
 {
+	amd_reset_thr_limit(m->bank);
+
 	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
 }
 

-- 
2.51.0


