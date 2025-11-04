Return-Path: <linux-edac+bounces-5330-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DE4C31AFE
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 16:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2E284F7B12
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 14:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E616D3314D2;
	Tue,  4 Nov 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oz9VLhkO"
X-Original-To: linux-edac@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1932ED50;
	Tue,  4 Nov 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268164; cv=fail; b=Da2pjMnqHLAygjyWGHivXh8Y/0IUC6lsbbMSH++TOb+4K229ua1SNgY0m9bb9S2adaglzpWUZHMJRZ1LgCHx9wsjbeLnQsRYHQDqGhmEXN56W32i97lvTHOsmlnlhgtBL870C3F01r++maubRAluTiL+pFoMstPZZVe5HU1wgD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268164; c=relaxed/simple;
	bh=i9kJU4x7/ywoptEY/gZp/99cal6XlkpSJoRNyqLdd3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Uj9fPBeVLzePxrmQBsGh710gNA8R2Dk9p7tVhKsWSgDFmtJRguXp1/2RzU+B3h7G2QsOzG6xQ5KJR6N74623KPywYXjWPscJenG0VWAx+PmTMlo7zUjoe88qc9wp8+YGdlUoWp7t4kFoQ33pYH/f7iVIEg8T9+OLchR9MxKySDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oz9VLhkO; arc=fail smtp.client-ip=40.93.196.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSeXq/v58DlTnpF1wIfD19TBOUNKpuwPbFS1gMDnxnMYmn6O5PvDHSRFXpiaS7PNTqO/fGAd+jUbahCS/EQFghRaPpx/wWf2/5S7er/dpCZNxEsqYRzDr+tsaEhKQa0K+QTUjes91LmNLRsjdRN/CU0fMtybjGxx9W3stWWghuTagpYGOiHUBQQJjvUvhBXOhHK2dLTcnB3Qnv15Kb8i5+Ktf3yHVltMBPYieCMzWvLVVJWaECMIkRgqaL2yq200KAB4EzsaZA0KVGBd+Wubku+ZTCgg/l8HwjoYbJVN3Dj1xO0sMYh3gITgr355pJZ0uH1SxTn5sTFshkp3ttjtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PuLC7h1opB7XQduXmGE+0GqzkFETv/uc052TSVpax4=;
 b=GSznKwN4zv/7cp8vPylcfLyL5LqVwW2v5ptMzbKQu6WUCpXI4qZQFLt5fwo0aKTgURDCrFl86UtBGsg0+sWDvFwNSe2/JB8eXRjj6V05PkZzuNNmtWvJURh5IqvabHKa5m9RQgcazj1vkzPwSxhrsAoPazxH3LTi7BkTzfd7b8yBeCYSTe6PQZSLdSkwxs4SlMPN0iAIf0yB9bZQPKNd5IOoIYEJhXEjpY9jGVg7F94pNhqh6JARgS1mlUDiqgLW9W9SUGx8Vw1frod4u2wx04Vrgx/kZF64PfoGxu4CtohFUx6uSF1lx9hg4a64yCCttz6StdMJXo0DJiMQ2SxzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PuLC7h1opB7XQduXmGE+0GqzkFETv/uc052TSVpax4=;
 b=Oz9VLhkOR12kUHs8zMJqudPAhL96+T9OOL6pnA4cmlbUaTSD5NQhjEu4DXacdhgxusPG5UoqfLnRXSzk5gyGGGkPALZd5dQa2RJeogGco4zglb9tOinmm6l8Gy8uhzJfq9PnN9fDdFZyiZ19R+EplApfLNGx4C4MO0yGNbT/yHo=
Received: from DM6PR06CA0096.namprd06.prod.outlook.com (2603:10b6:5:336::29)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 14:55:57 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::7) by DM6PR06CA0096.outlook.office365.com
 (2603:10b6:5:336::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 14:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:55:56 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 06:55:51 -0800
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 4 Nov 2025 14:55:38 +0000
Subject: [PATCH v8 1/8] x86/mce: Unify AMD THR handler with MCA Polling
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251104-wip-mca-updates-v8-1-66c8eacf67b9@amd.com>
References: <20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com>
In-Reply-To: <20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9cfb52-21a0-4cfb-7c27-08de1bb24292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2JQbU9PSjJmM3A5WVhwaityQ09kZWcxOUlBbTNZc1A2YVNEcVU3b3dQbWMr?=
 =?utf-8?B?N3NuNmU4emx3SlpINGxnNjZ0VCtrRGxzS2I1dmh1eEFicFI2aHRLd2svUVQ1?=
 =?utf-8?B?TlBpL2F3TVUybXEzUENoRHpTbTVNc3dDMnN6dUlFeDVBWWhNNGVhWXhGUkZX?=
 =?utf-8?B?VXNoSHRuZWJESzMwd1g1cFB4RWVsNFNIVHVxS1A4NVA0bFFWUldZb1dWRkVj?=
 =?utf-8?B?Wm1yT0w5R3kvODhXRVJPMVhWRjRrblk2Wmh0VFBvQkpFL2owWkg2aW5zc3Ji?=
 =?utf-8?B?Q0RqMXNRdmJic3k2SHVlRUc2Y0xOdDcvRFBYMG1XNHhCNDBBT1hLTEdCeHYv?=
 =?utf-8?B?RnJndkg4WDkzUTBoVWxMbkptWEJYTXFFMlJna0xheVdERVRPbUlSeFRPeHhi?=
 =?utf-8?B?MkF2TVZCaFgrMkFtcVdjbzlLeXZFa1RGaGVNbTNmWWJGU1l4Rzc4SFB3NG13?=
 =?utf-8?B?cE1wL2RIV2dOYmNBRFNoMUt1M3h3cHdkQkVybHJ1OVZBdUcwYnJCd1Yxa2Ja?=
 =?utf-8?B?QTNmazlYeks2Um1pQXR2QjNuYTJ5dkpSSjg2MGdyWkt6MmprVTlXRlBwZ0RC?=
 =?utf-8?B?eVM3NFQ4NVI1Y2JPSno3SkRwMFFoWmpMbTZMa0h2NTJPc3FndFJBMWhxaU96?=
 =?utf-8?B?b1ZDQSswa3dCUno5TVFDWXB4K2lnRVNVL0FuTm5IcUR4L250SHNVczlVazV3?=
 =?utf-8?B?MDltTnZ5OVVqVzZWU00zY2FhVTNUTXRhSlh2ZnJSSW0wVDlMcDJMQnpKZW90?=
 =?utf-8?B?Z3NDWTJWUllhcTBuTU9Jd3dIbmJRdGdOUHFhL21qMC8yMm8yVkpDdFFQMTd0?=
 =?utf-8?B?SDdRSkZvc1NCbFpOYmlqalg2RlI3R3U5cjd5Q3hzM1BsQjhzd3AxUlRGaWIx?=
 =?utf-8?B?WVB6RXJTNWtJWjZRVFVWUlZ2cWlMSG95Zlh6RmppYU1tOU9KMG1kWGYyaHdx?=
 =?utf-8?B?VHZtYzV4Z1B3MlBMaGZoYm1tbGc2SUhxZ1g3YUJVTWhxeURxMUpaY1Q4K2xv?=
 =?utf-8?B?bGp4a0dyQ1dic2dmZVBSa0RXL3pmWW5mOFY4Y29XRVJDUTR0YWlpZXRFZ3dk?=
 =?utf-8?B?S3UzM1RSdDVGQnQyYVgzdW5JS1U1dzNiUXMrVVh4R3RQMEViczNlTU0xZU00?=
 =?utf-8?B?UXV5cmY0TUxWbzZGbjM5Y2tsQWJHOVJ5ZHI3ZjFwMCtJNXlvMTdabWRTYWt2?=
 =?utf-8?B?VlZuRWZnbC9aU3hUSTljd2Q5ckFGTWszcVFPS3NIMkhvR1lPNCt5ejRLQmFa?=
 =?utf-8?B?c0Y0RFhIa0RnSmZkSGZSTHpnbWxHVmdoYnBTeVZJZS9aMVNJZWhHcDV3Nm5P?=
 =?utf-8?B?T0FzT0J1TFE4WXAvb015SEJYYk0xSGYyS0VVWFd1VGJ4a1NPUW5scDI1SGV5?=
 =?utf-8?B?NThsek1CSXI0cE1DdklqWVlueFRXbkppSHd2Rzk5a2JNYnlhbUZKODVJN1RZ?=
 =?utf-8?B?KzdoZVZzT3pEd2N2aDhRK0lTRUM1T3hrK2tDanN6eEtqWmJKOWYrR1R6cWkr?=
 =?utf-8?B?OWlGRXBkdW5mWis4SzJNK1ZTaFo0OHNOckZNMWQ4bUNyQ1g0M0grUFd5QjFm?=
 =?utf-8?B?SFBtWFJzVUJieGJFWE5PQUg4cm1SWVAwamRvdkJ3dklCR29CTXFhajd4dzc5?=
 =?utf-8?B?VzV4VzB5RXAvLzNzdktWRitnT0FXNHkyUk1xVE9ISThSRDFnanVZL3IyQWZy?=
 =?utf-8?B?RmJqNG1xTWRqREVhY3RFdlMwU3BTNzJsaEYrZDBYOWdkOW5RbCtGSmg5OHp4?=
 =?utf-8?B?cXVoSXZIQnQwWkZTOHY5OEZJQlJkMmgydG1MaXh2anQ3WFY5MXhTL0xwbzNG?=
 =?utf-8?B?RFZBSHJINjk5QWNzcjVTTVVyUEZJQjh0MC9QdElIYnZUWjdXclh6SFVJbWM0?=
 =?utf-8?B?cERTVzUybzErTlIrLzgrUkt4MEwvYzZ1d0pIQU5ReTlaam0zL1ZVZjJEc29U?=
 =?utf-8?B?MTlTaXYzRmwzcmNHTjdIZWRMc1ZKbVpuWDhWbFkwSUREL2o4V1lQQm1UdEtk?=
 =?utf-8?B?OWswSWJyRnhjVTVhNzJxNnZCMFNzZytlTlNSc1laUkUrZTgzaElNNHgvQUV2?=
 =?utf-8?B?WU5xd01sak9HT0dsb055K1FETlVtTmR5TXRnSWNGMlFTbmxNWUFPcDI2MUNM?=
 =?utf-8?Q?jYmk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:55:56.7401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9cfb52-21a0-4cfb-7c27-08de1bb24292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057

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
    https://lore.kernel.org/r/20251016-wip-mca-updates-v7-1-5c139a4062cb@amd.com
    
    v7->v8:
    * No change.
    
    v6->v7:
    * No change.
    
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
2.51.2


