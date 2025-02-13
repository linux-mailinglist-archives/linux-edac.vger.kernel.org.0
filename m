Return-Path: <linux-edac+bounces-3071-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8CCA34ADF
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8D3189392E
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C60324BC16;
	Thu, 13 Feb 2025 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WuMgT9nm"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB1C24A07F;
	Thu, 13 Feb 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465206; cv=fail; b=A1igFubnPstzcn44IGnB2RJpQ05dKSWrJscMMthPVuv7W241/C5gGiNAMgg7XUTFScZ8AgdDDZjDutPYsQDbNM6vjhXxnyWXuFyTBNdDf0DOxqEcevmnMdU/Pag+orEYlmqJNsvRIVz5c6I06j+KzVNd5AMVTslm1sSjVY1ar8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465206; c=relaxed/simple;
	bh=BhZZcLFoKQAdMkMmFELmW1N9G9LNSvTgVpjjpFjz69g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SCOZQrFktJoQPsIjWleyrvntixx7LkznsvyTSpa5E8M/Ft4c4qIELrtyM3Q/ZSxqq6mDhC90Oq6GpEXDj9knZHK3t6cF+f2FhYedS+UyopuSTY0nUXjsfOorkq0dw1248292jfWjZiT8Gzm0EcLymhk7bAUe6H/AjInVKexBLGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WuMgT9nm; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSvMCTDd76a+TZ7eYnIFux2tYlzeaijP3UPeqzHe1mcPWjXpI/HaD6ObVN3vPXwMujvj4dQZmC+6eSgN8wcUgpKIVrXn7SUJoqda0xmqKLkvoK4RU+rJmBwu2yJ88OZkppjtDTHkALnkwbcVj5v83k5L95aGlR4PNaTHaovw50n2i9MLr9o6PuheUQoll+RYvoz18xg+4d78NW2UYiWf7RhyucDVMEr/1VUXaur9cjQ/TQrY4lCi180z2tjDssZJwzCFuHlnpXm7Qd8qWQfYDWiefoH+rcXZ3kBasZv0JGmH0tQSe58QrzQ8dESHm3tDwJMWSmATCvMqdPl/KEjSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdQm7SIHcSe1uXMNVnAAU6u3V2g+InCXjQZGY7+mwu8=;
 b=ZbWa7Y32j7Mdb9LNn/Wt3Jt25T6p3w/J4xA74PlC8Qk4x7e5UyNJc1IAR2RxOrVjno4/g37bHvY9hZoZkhx6MwBFUH+OXn8RS+Uzewig7zvt/2HsSry8QrDfautWgHOnMmC39qTk6XCsqk71dYv80t+Y7Hvaw/A/U1cZHXe5ptNNgiAbrMAUdZxi/QO1B1eaKLGOuLvt8zM4cG+8iZyxLI36MAWtaIGq+CMKzU27nD+kUr71Lpw+hvtnAd/Af+fZJs6V6eAUHShW0vP4eH38OaJnG9OJ4/x3qporzGLGFx/rbr0uCwWp00IYePMkGP8gaoFN0hz61WC3MjecTS1dmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdQm7SIHcSe1uXMNVnAAU6u3V2g+InCXjQZGY7+mwu8=;
 b=WuMgT9nm6/a5OckZqGCsw4v84inN0f62pZ/XounSnUwGxf/5S7gM/Fj8o4Z+wupqpuvfQiehAuvr/GD8oFXOuL0fsjXu2LC8p/b7j9eBtkzoK3Xb7HklE6tWjghZXSFp9pAVMhlG+ESxwJscmV49Gt+AfydGmGMDqdFONSTstOg=
Received: from DM6PR11CA0015.namprd11.prod.outlook.com (2603:10b6:5:190::28)
 by CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 16:46:37 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::b5) by DM6PR11CA0015.outlook.office365.com
 (2603:10b6:5:190::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 16:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:37 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:31 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:46:03 +0000
Subject: [PATCH v2 14/16] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-14-3636547fe05f@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH2PR12MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbb56e8-b491-4421-773a-08dd4c4dfb87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTVYdGo4VCtCM0k3V0lleXJNYlpYMEhzemNHU21SRHVDK1RrVU01L1RJdy93?=
 =?utf-8?B?N01KT0ZiVHBBYVRzQXJkNnFEaTg0SUdXeFd3WGVLcnNqK3RjY3ZwR3MxSk9w?=
 =?utf-8?B?UUhrZTVpR2VoSWIwZmZzY0MwS0FSVURBYmJ1Z1d5L0J2MTN2SW43VlBiNnZ1?=
 =?utf-8?B?Nk9OOFU0cDREOTVBRFIvTk90bVRPTEw4VDIzNG9iVFVkYytVSlEwNjZna281?=
 =?utf-8?B?WENiQmdaVW5vTjlkMUV1QmVEWUwxWWhMbDI1QUIyTGpDQUYyaHgvSXd5SWFX?=
 =?utf-8?B?Tkdka3N6YkRWL3RvRllvWllqSzlia1VwSkphdVZjRDh6UXBmQ1UrQzZ4ZW5Z?=
 =?utf-8?B?MUVYVmFnaGVJd2JrRmdPb0hVa0t5Mk1ta3E1RGNkTU1QWW8zVUFXRTZWcFFi?=
 =?utf-8?B?NG9GNFI3VzJCOXZxam82aDhNZFVLekd5Wm5vbTg4V3d1b3phTDgrbW5hemUy?=
 =?utf-8?B?bHkrQ3F4VlpwZHhDcTJTaGZpb3FJZ1hsWUxOTU5WRnBwbjBkSk9oVC9WVm9q?=
 =?utf-8?B?MGRkRVFzdkdsa0NXMGErTVRhdU5YdEpjRHNlSExLK2x4bzZvb0pqUUc4TnZh?=
 =?utf-8?B?bU9mZ3V1VHFHdWwzL2tMUG9haWVSNkZFcTR1YlRhL05ENDZadDhkekVNckls?=
 =?utf-8?B?d1B5OVQyZkljSHNuVFppSm1MNVk2UU9Sak45Mkc0OWxLZ0ViNmhieUhuK3Nx?=
 =?utf-8?B?WWdoMmJsK0ZCN3pKb1AvaTBQZzNtNDdGeE4zdjcxUDFHMmU2dFFROFRiV2dE?=
 =?utf-8?B?WUVKTVVPOUdmaldmTVBFQnZpMzNIZWxtMzdIVUpVQ1hPZ0pIZ0duS1RmTk1W?=
 =?utf-8?B?bjFSNkc1NDBUUjl5QW5UMkwwSGkybStUOUZQZkJWbHZTYS84QjhQN3RWNHg5?=
 =?utf-8?B?cWllQlV2Q3dwaEd6cENBOTFpdXBaUG8xbUt2S3lhT1V5bU9adlNXQ3l1TDBL?=
 =?utf-8?B?NE9UQU5yeU1ycjRnSXN2YnpzcnZwQWkyTVhIWlF5MnpOTVl6YlBLOS9YQ3kz?=
 =?utf-8?B?VlJrSTArSmRBODRjTXFhcXlRRGozbks2V2Jwc0NCV2U5UnBMaWgxUXlseFFh?=
 =?utf-8?B?aGk0aVhTdWZTMFRSb0tUbGp0Z3JqQWYvbTQzdWtOTFJmY0JZeWZrOHRDKzRz?=
 =?utf-8?B?SnFoVDRvR1A4Y3JOQWxMeUMyaG5LaWFDTkhBL081enZ5Nk9QeWFHWTZURkVE?=
 =?utf-8?B?U2xJN2dOalN2NHRqY2NUTHNyRzQwcktOL0RyNHhRY0d0Zm9zT1JZci9qS3lK?=
 =?utf-8?B?NDlVTC8zSThpaHBlR2lFbE0zWk52UExqM0JtRlQ2VHZEZ1FBcWhtR3JuTGda?=
 =?utf-8?B?Vm1GbVpLQndyNUNyNWcwcUl6TXRwdDRMNzRQQ3VycUNBTktlZGZCU0xxOWNW?=
 =?utf-8?B?ZDRSRW1QejYvOTRlU1ZRaVFZczNkVXhwd04rcENrZGFMdENGcnNaRUt1cjZk?=
 =?utf-8?B?UHYxcXBTKytkRFYrc09jWDZKVHRmZnpUU3B2VHhRT2VPRENJejdwVTlQRlAw?=
 =?utf-8?B?dDRmdTZuR3hES0trSmJIdE9uTHFjOGVkdjNsVHBKSnRWem0zdm11anNaV3lI?=
 =?utf-8?B?VzhMQlp6OWUzRHRLc1c3OEVMUDB1UGFCbnFrSm14a2dkNGc5ZG9RZFhzVVkx?=
 =?utf-8?B?cHdMWHVKSXB4bGx1SDA3eFNvcnE5Z1hoVXduK1pQYjhlVE5OMit0UVBTdlkz?=
 =?utf-8?B?ZVg2Rk5nM0ovN2tHaS8zaTFXRjVYRHpoMmI4VVQ1Z0Y4WEVPTDRrdDNmS1RC?=
 =?utf-8?B?MFpuUTgvSmJqUEI5ckdubFQzaG4wZlUxUXk0TFpKaXpwZXE3eXlkU0NwOTk4?=
 =?utf-8?B?SmlCQi9wN1ZQS3FKcytYZjR0elFvTU1ScGdVWkRiaVlUUzI0VFZDN25zcG9Z?=
 =?utf-8?B?RjhadzNLMmRaQm9FQ1FhV0xWRVIzdFdhYUtUdmxrTHNtWXR1ZHhRTW5MNDQ1?=
 =?utf-8?B?L3JLUDhsRmc3R0FPczdGZGwweURPZmZ5MGEreVZDaDNpaWU5YkQreDF2Qi9G?=
 =?utf-8?Q?A6ZEJWVOO/bDZuh+yZzyF3embc9My4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:37.1692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbb56e8-b491-4421-773a-08dd4c4dfb87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519

Scalable MCA systems have a per-CPU register that gives the APIC LVT
offset for the thresholding and deferred error interrupts.

Currently, this register is read once to set up the deferred error
interrupt and then read again for each thresholding block. Furthermore,
the APIC LVT registers are configured each time, but they only need to
be configured once per-CPU.

Move the APIC LVT setup to the early part of CPU init, so that the
registers are set up once. Also, this ensures that the kernel is ready
to service the interrupts before the individual error sources (each MCA
bank) are enabled.

Apply this change only to SMCA systems to avoid breaking any legacy
behavior. The deferred error interrupt is technically advertised by the
SUCCOR feature. However, this was first made available on SMCA systems.
Therefore, only set up the deferred error interrupt on SMCA systems and
simplify the code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20240523155641.2805411-9-yazen.ghannam@amd.com
    
    v1->v2:
    * Use new per-CPU struct.
    * Don't set up interrupt vectors.

 arch/x86/kernel/cpu/mce/amd.c | 113 ++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 65 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5f547f5b3de0..75a48f484815 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -43,9 +43,6 @@
 /* Deferred error settings */
 #define MSR_CU_DEF_ERR		0xC0000410
 #define MASK_DEF_LVTOFF		0x000000F0
-#define MASK_DEF_INT_TYPE	0x00000006
-#define DEF_LVT_OFF		0x2
-#define DEF_INT_TYPE_APIC	0x2
 
 /* Scalable MCA: */
 
@@ -57,6 +54,8 @@ static bool thresholding_irq_en;
 struct mce_amd_cpu_data {
 	mce_banks_t     thr_intr_banks;
 	mce_banks_t     dfr_intr_banks;
+	bool		thr_intr_en;
+	bool		dfr_intr_en;
 };
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
@@ -271,6 +270,7 @@ void (*deferred_error_int_vector)(void) = default_deferred_error_interrupt;
 
 static void smca_configure(unsigned int bank, unsigned int cpu)
 {
+	struct mce_amd_cpu_data *data = this_cpu_ptr(&mce_amd_data);
 	u8 *bank_counts = this_cpu_ptr(smca_bank_counts);
 	const struct smca_hwid *s_hwid;
 	unsigned int i, hwid_mcatype;
@@ -301,8 +301,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		 * APIC based interrupt. First, check that no interrupt has been
 		 * set.
 		 */
-		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
-			__set_bit(bank, this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
+		if ((low & BIT(5)) && !((high >> 5) & 0x3) && data->dfr_intr_en) {
+			__set_bit(bank, data->dfr_intr_banks);
 			high |= BIT(5);
 		}
 
@@ -378,6 +378,14 @@ static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 {
 	int msr = (hi & MASK_LVTOFF_HI) >> 20;
 
+	/*
+	 * On SMCA CPUs, LVT offset is programmed at a different MSR, and
+	 * the BIOS provides the value. The original field where LVT offset
+	 * was set is reserved. Return early here:
+	 */
+	if (mce_flags.smca)
+		return false;
+
 	if (apic < 0) {
 		pr_err(FW_BUG "cpu %d, failed to setup threshold interrupt "
 		       "for bank %d, block %d (MSR%08X=0x%x%08x)\n", b->cpu,
@@ -386,14 +394,6 @@ static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 	}
 
 	if (apic != msr) {
-		/*
-		 * On SMCA CPUs, LVT offset is programmed at a different MSR, and
-		 * the BIOS provides the value. The original field where LVT offset
-		 * was set is reserved. Return early here:
-		 */
-		if (mce_flags.smca)
-			return false;
-
 		pr_err(FW_BUG "cpu %d, invalid threshold interrupt offset %d "
 		       "for bank %d, block %d (MSR%08X=0x%x%08x)\n",
 		       b->cpu, apic, b->bank, b->block, b->address, hi, lo);
@@ -474,41 +474,6 @@ static int setup_APIC_mce_threshold(int reserved, int new)
 	return reserved;
 }
 
-static int setup_APIC_deferred_error(int reserved, int new)
-{
-	if (reserved < 0 && !setup_APIC_eilvt(new, DEFERRED_ERROR_VECTOR,
-					      APIC_EILVT_MSG_FIX, 0))
-		return new;
-
-	return reserved;
-}
-
-static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
-{
-	u32 low = 0, high = 0;
-	int def_offset = -1, def_new;
-
-	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
-		return;
-
-	def_new = (low & MASK_DEF_LVTOFF) >> 4;
-	if (!(low & MASK_DEF_LVTOFF)) {
-		pr_err(FW_BUG "Your BIOS is not setting up LVT offset 0x2 for deferred error IRQs correctly.\n");
-		def_new = DEF_LVT_OFF;
-		low = (low & ~MASK_DEF_LVTOFF) | (DEF_LVT_OFF << 4);
-	}
-
-	def_offset = setup_APIC_deferred_error(def_offset, def_new);
-	if ((def_offset == def_new) &&
-	    (deferred_error_int_vector != amd_deferred_error_interrupt))
-		deferred_error_int_vector = amd_deferred_error_interrupt;
-
-	if (!mce_flags.smca)
-		low = (low & ~MASK_DEF_INT_TYPE) | DEF_INT_TYPE_APIC;
-
-	wrmsr(MSR_CU_DEF_ERR, low, high);
-}
-
 static u32 smca_get_block_address(unsigned int bank, unsigned int block,
 				  unsigned int cpu)
 {
@@ -551,7 +516,6 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 			int offset, u32 misc_high)
 {
 	unsigned int cpu = smp_processor_id();
-	u32 smca_low, smca_high;
 	struct threshold_block b;
 	int new;
 
@@ -571,18 +535,10 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 	__set_bit(bank, this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
 	b.interrupt_enable = 1;
 
-	if (!mce_flags.smca) {
-		new = (misc_high & MASK_LVTOFF_HI) >> 20;
-		goto set_offset;
-	}
-
-	/* Gather LVT offset for thresholding: */
-	if (rdmsr_safe(MSR_CU_DEF_ERR, &smca_low, &smca_high))
-		goto out;
-
-	new = (smca_low & SMCA_THR_LVT_OFF) >> 12;
+	if (mce_flags.smca)
+		goto done;
 
-set_offset:
+	new = (misc_high & MASK_LVTOFF_HI) >> 20;
 	offset = setup_APIC_mce_threshold(offset, new);
 	if (offset == new)
 		thresholding_irq_en = true;
@@ -590,7 +546,6 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 done:
 	mce_threshold_block_init(&b, offset);
 
-out:
 	return offset;
 }
 
@@ -659,6 +614,32 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 		wrmsrl(MSR_K7_HWCR, hwcr);
 }
 
+/*
+ * Enable the APIC LVT interrupt vectors once per-CPU. This should be done before hardware is
+ * ready to send interrupts.
+ *
+ * Individual error sources are enabled later during per-bank init.
+ */
+static void smca_enable_interrupt_vectors(void)
+{
+	struct mce_amd_cpu_data *data = this_cpu_ptr(&mce_amd_data);
+	u64 mca_intr_cfg, offset;
+
+	if (!mce_flags.smca || !mce_flags.succor)
+		return;
+
+	if (rdmsrl_safe(MSR_CU_DEF_ERR, &mca_intr_cfg))
+		return;
+
+	offset = (mca_intr_cfg & SMCA_THR_LVT_OFF) >> 12;
+	if (!setup_APIC_eilvt(offset, THRESHOLD_APIC_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		data->thr_intr_en = true;
+
+	offset = (mca_intr_cfg & MASK_DEF_LVTOFF) >> 4;
+	if (!setup_APIC_eilvt(offset, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		data->dfr_intr_en = true;
+}
+
 static void amd_apply_quirks(struct cpuinfo_x86 *c)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
@@ -690,11 +671,16 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 
 	amd_apply_quirks(c);
 	mce_flags.amd_threshold	 = 1;
+	smca_enable_interrupt_vectors();
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (mce_flags.smca)
+		if (mce_flags.smca) {
 			smca_configure(bank, cpu);
 
+			if (!this_cpu_ptr(&mce_amd_data)->thr_intr_en)
+				continue;
+		}
+
 		disable_err_thresholding(c, bank);
 
 		for (block = 0; block < NR_BLOCKS; ++block) {
@@ -715,9 +701,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 			offset = prepare_threshold_block(bank, block, address, offset, high);
 		}
 	}
-
-	if (mce_flags.succor)
-		deferred_error_interrupt_enable(c);
 }
 
 void mce_smca_cpu_init(void)

-- 
2.43.0


