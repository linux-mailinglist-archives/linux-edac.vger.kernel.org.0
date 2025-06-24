Return-Path: <linux-edac+bounces-4233-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBBAAE687B
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714244E2BF3
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1682E2EEE;
	Tue, 24 Jun 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2mBWg7b6"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D42989AC;
	Tue, 24 Jun 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774606; cv=fail; b=WKlmdMCd54E6KpfehBjFvZSIUzCpOqTPW/rNxQDLqmb7oBpEKk0gyuB9oH8F0HQQ56YASZX0AD/GI/HJAZIMDQiWkjDvxAqJGMmAOz/VjDdToHQwIhVCGhyKRrz9uDw3PlyBy+Hu1nh32xbuIv4taQ2FFokk+qv2Gx+PJXJJxGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774606; c=relaxed/simple;
	bh=8ALPE6Ne8lOfto6UQvYd7q4YRXjlSCHU68EMK7OrLG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jMhzxb555lYiW03tmIErASDGiPVEgx/IQL/nZRetqtSQwvU7bwRGLtfP81UnCCu0kXIA6mj3R4cl9jaSfo7lnI7dWKBPqPf2mhJ8lWiazB0/5sXR/PFJKGDYN66C2kMQHmJgr6JNR7tBIppTcBkN+8SY5tN/KVGfPoGxcc+58jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2mBWg7b6; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO1KHUA3c4ehgiG9wCXXyN0kHPk9NYYLvjpmjzp/H0mmG3FjPkktxEPG8bURfFTUfKw3wXNsMEXMsOaSY8aG0SJmphql7sRCEaBQWUDXBkl4mwuBJpIwmJwFreGsEvpwOuxuLrBu/yDTfssUq9Gix4uS3vo7n1aPheKGH6h8DCNsSz/89LmYhVmrBv/GWj8VZBr20XwGh4SSf+bAvsGCNgxgmL5tBR945nrpL1khNDw9JCOsx9raQNnc2xvjiZP6haHFvn/PK676iGq4OVUhCvK7xpgatHekn01/aOVe8AptEVt5yp5igFMBL3f3KzX4Oa84Ecm2fiUbOONkbqufSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMbFx41w4ZFMJEabi0w0o3IwTQ6GqieaGiCOEtE6Lro=;
 b=rRswEgMa2o7GmUlnjjMTEToyFkc2Z0SSBDHFpYo4O9QI341got3rVwvxjVDpjiBqwPtIkaT3IukaKChutRhBE+kl2vxlw/9SDL/B7qPASAnlQTwMwOP1ls7eeB6dG1KrjQkzwMyE9fA2mdU0/Hs26Oj1T/CZsulXfEqDprVtZbF95rXkUqyUQu5d7O1hoQSc5IkHlsnzINGDwq15btonHvet74nf3Oar3po2zu77SB2YhOx5x6FAnyNKMAJc4UoWTPctvG+Osnh5CIi8FNLb0rp0iZ7bA3RjeZbWYBTiaFX1DFUvvgcxw+tely+o+oUqMIYfGSnrQ20OU9MC5Qh4mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMbFx41w4ZFMJEabi0w0o3IwTQ6GqieaGiCOEtE6Lro=;
 b=2mBWg7b67PCWY3OUae6uMvY1bBN011EXMxAxojANqYHjv0i8VN98Oi9sL14uYTE8vgeX0f+93LVhKLoHboLuna1i39wAKcPck0QKiUxFnCKHGCrcJ2L00ElXi5gn8iM7cbvAYH+tefZngF7QNCVlzDfV5VRLK2hWGFsZJvxxYG0=
Received: from BYAPR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:74::22)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 24 Jun
 2025 14:16:39 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::8b) by BYAPR05CA0045.outlook.office365.com
 (2603:10b6:a03:74::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 14:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:39 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:33 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:09 +0000
Subject: [PATCH v4 14/22] x86/mce: Separate global and per-CPU quirks
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-14-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9eed87-c377-4a09-4992-08ddb329bc67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnhjcjBUSGVWT2hzV0lwV1lHeUtVWG5TV3JoTzRDSmc4RXRWL3VxTHpiNUZp?=
 =?utf-8?B?R0NDZjB3L1A3WnFJRzJkRWFqYk1mL3lMcUp6ejZvT1pJV0RyemdWVENGR3JL?=
 =?utf-8?B?SzBydDdRVEpKcTBHdzMwa29wTENoc3Y0RkJEcUkvaFoyc094dTlwM3oxQzAx?=
 =?utf-8?B?VWFhV0txTlZjMVR1am55WEVBaHRMZzRYM1NNaGdBWDdzQURldzc2TENZYmJi?=
 =?utf-8?B?aUg2aklVTkxaOGZVb3ZoNkpNR2xEd3Rid29ONytXMm1nYnRUWWora1ZiaS9U?=
 =?utf-8?B?QkxvaUhSeDA2dFpLZENzL3BEY0I3a0dSd3d6UlJOUGkzeWJlZnFDSEFJYzNX?=
 =?utf-8?B?RFhaaWdtclRYZDRrdVJXWFF1MXdXa0VOSzFMUnFvUW5sS0ZtRXRHcUtvaHla?=
 =?utf-8?B?OCtidHhHd2JFUmtMWEd0QitPMkpiRzRERFpMZ1dUUkk3VWpzZnM3MUZQSUxh?=
 =?utf-8?B?RFpwaWU3S1M1ajZkdElPWnBycC85Y3VkdVlqL21VSXNCWFhIQUNkcXdKZ01B?=
 =?utf-8?B?ZW9GckxBZzdoZFVod0xPZEtpbTJiUm9xWmpldE5OdGZMcng1aWxUOFhQcnY4?=
 =?utf-8?B?MG9tbWxRYktZSVEwTEY0OGt2KzRxWUsremsrRUtHS1pLMzhmckc3Vk9uVGgw?=
 =?utf-8?B?TVI1b052cWV5NFdOMjBuTEhVTG53OUZRKzJEQ1dTWU1ZMFltL2JRWmVydDdX?=
 =?utf-8?B?Q0RMUmR6NUFTeDhNejhFNmNibWRNa0dvbEpQZ3RNSEZDZnlJM1luWnZ3a3Jl?=
 =?utf-8?B?TXdMR2hkRlhMM0FtUnZybkI2YkRYditDNUJzMG1QWkV4SDA3YXdGTFNwM1l4?=
 =?utf-8?B?bnBOUzNsVVIxbU5Ra3hNZEZYeU03ZE1FS0RBaTZtLzArK01RcmowTkFkQ3pJ?=
 =?utf-8?B?VFRWTXlxb1diT3phVG02cFVGaXFVMWlTbk1LTnJza1ZnQ29GYWNkZlArRDV2?=
 =?utf-8?B?aTJHdkpYZ28vWWlmYk9QanBYL21XRS9qSmJ3TGZxYXJHaFJCdktQSDZ2TlJy?=
 =?utf-8?B?Z2ZSZEJYZCt1dDR2UVB0eS9OWTRxeFl1K0F0UDRNd3dLbTRsV3Z5RlJmcytY?=
 =?utf-8?B?QVJRTHFXZnovbW1qRDRXYTBWUlU4VG14cmM3R09XcHVzQ1hPK3dnZHYwU3p2?=
 =?utf-8?B?a0VlRS9EWlVheEZtelIzR0thSXhLSCs4Mk1ld0hyVzA4VzRvOEVTeXM0ckhM?=
 =?utf-8?B?U0hQand4bUdLdFhHMU9xU1ZJSGRGU1dtdjBzTTZKRFNMYlRBaDNEVkVDV1ZD?=
 =?utf-8?B?K0pZZ0FPcWd1WGhOaGY5dW12OXg4czlBYlVTb3AwR3ZVWldTZnZzSktFY3hM?=
 =?utf-8?B?NmhWVHhIM3RITFJ1RzR5RXdpaFFFT0szRGE3UVJhNm9GVEhZQnB0QThzRC9p?=
 =?utf-8?B?TURwdnBiUkNqZWpsUTgyTml2WnZ4QTlaeGluK2g2czNYRGhuUzNoWXZzdWJU?=
 =?utf-8?B?cUwxOVJTMG12SFkwSCsvb0JucklId0g1RFNDL2tzTDJKbXI1d0hoM1Z6SzdO?=
 =?utf-8?B?MmovL1pCd1huNk5YOU1Zci9pR240WXB3aFV2bWJmZHVVN1BRajBTbUNURmVr?=
 =?utf-8?B?RmxiVUJwVnNMR0VmejNyZzVuM1lGZm80alBUUzFuQkROQVhBakhaMFQvTVI4?=
 =?utf-8?B?NWpTWldxMVNCQnN5K0l6cmtDU21KUzIwdGx4Z2dDNXkyZStjNUJYS2RadDVq?=
 =?utf-8?B?K3d6c1dHaHNlVHRqZ1pjbms0dzhjS2NtYlhiVFYwclRvOE5ZdE1oL243dHRl?=
 =?utf-8?B?M210aGVWY25LVG5wQ3ptekR3VFgwaVhNNnNXOUhyVW9YNHZsYk91ZTZjb0Nw?=
 =?utf-8?B?eGpESnIrZVdhbkI0b3RidC9UQWxhNElzenVqcUh1VnZTeXBDbGx6cEthaCtY?=
 =?utf-8?B?WGNBY3A4Ync4VmZVSEU4bDZ0NStMYWs5Q2pyaitkYWFhVitTVGlkOCtCMHB0?=
 =?utf-8?B?WUFZM2JzbW05Sko2QjlwVnlzaEVuMXRLTnRPYWUvdEhYSzlFRjBrSTd6QzY1?=
 =?utf-8?B?VWhockkrNW1xK0RjTGRFYU9xYzVwa1ZwNmxjdnVnQ1UwazZTTStWa2FCcWlx?=
 =?utf-8?B?TldqK2ZMbUNla3k1emVRQU5qRFd2YlVtakVWdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:39.1134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9eed87-c377-4a09-4992-08ddb329bc67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678

Many quirks are global configuration settings and a handful apply to
each CPU.

Move the per-CPU quirks to vendor init to execute them on each online
CPU. Set the global quirks during BSP-only init so they're only executed
once and early.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-10-8ffd9eb4aa56@amd.com
    
    v3->v4:
    * Add newline in mce_amd_feature_init().
    * Remove __mcheck_cpu_apply_quirks().
    * Update code comment ref. __mcheck_cpu_apply_quirks().
    
    v2->v3:
    * Update code comment.
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c   | 24 +++++++++++++
 arch/x86/kernel/cpu/mce/core.c  | 79 +++++++++++------------------------------
 arch/x86/kernel/cpu/mce/intel.c | 18 ++++++++++
 3 files changed, 62 insertions(+), 59 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d55c4b5f5354..28dc36cdd137 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -648,6 +648,28 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 		wrmsrq(MSR_K7_HWCR, hwcr);
 }
 
+static void amd_apply_quirks(struct cpuinfo_x86 *c)
+{
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+
+	/* This should be disabled by the BIOS, but isn't always */
+	if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
+		/*
+		 * disable GART TBL walk error reporting, which
+		 * trips off incorrectly with the IOMMU & 3ware
+		 * & Cerberus:
+		 */
+		clear_bit(10, (unsigned long *)&mce_banks[4].ctl);
+	}
+
+	/*
+	 * Various K7s with broken bank 0 around. Always disable
+	 * by default.
+	 */
+	if (c->x86 == 6 && this_cpu_read(mce_num_banks))
+		mce_banks[0].ctl = 0;
+}
+
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
@@ -655,6 +677,8 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	amd_apply_quirks(c);
+
 	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a723c7886eae..4f6af060a395 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1807,8 +1807,9 @@ static void __mcheck_cpu_mce_banks_init(void)
 		struct mce_bank *b = &mce_banks[i];
 
 		/*
-		 * Init them all, __mcheck_cpu_apply_quirks() is going to apply
-		 * the required vendor quirks before
+		 * Init them all by default.
+		 *
+		 * The required vendor quirks will be applied before
 		 * __mcheck_cpu_init_prepare_banks() does the final bank setup.
 		 */
 		b->ctl = -1ULL;
@@ -1884,18 +1885,6 @@ static void __mcheck_cpu_init_prepare_banks(void)
 
 static void apply_quirks_amd(struct cpuinfo_x86 *c)
 {
-	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-
-	/* This should be disabled by the BIOS, but isn't always */
-	if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
-		/*
-		 * disable GART TBL walk error reporting, which
-		 * trips off incorrectly with the IOMMU & 3ware
-		 * & Cerberus:
-		 */
-		clear_bit(10, (unsigned long *)&mce_banks[4].ctl);
-	}
-
 	if (c->x86 < 0x11 && mca_cfg.bootlog < 0) {
 		/*
 		 * Lots of broken BIOS around that don't clear them
@@ -1904,13 +1893,6 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
 		mca_cfg.bootlog = 0;
 	}
 
-	/*
-	 * Various K7s with broken bank 0 around. Always disable
-	 * by default.
-	 */
-	if (c->x86 == 6 && this_cpu_read(mce_num_banks))
-		mce_banks[0].ctl = 0;
-
 	/*
 	 * overflow_recov is supported for F15h Models 00h-0fh
 	 * even though we don't have a CPUID bit for it.
@@ -1924,23 +1906,10 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
 
 static void apply_quirks_intel(struct cpuinfo_x86 *c)
 {
-	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-
 	/* Older CPUs (prior to family 6) don't need quirks. */
 	if (c->x86_vfm < INTEL_PENTIUM_PRO)
 		return;
 
-	/*
-	 * SDM documents that on family 6 bank 0 should not be written
-	 * because it aliases to another special BIOS controlled
-	 * register.
-	 * But it's not aliased anymore on model 0x1a+
-	 * Don't ignore bank 0 completely because there could be a
-	 * valid event later, merely don't write CTL0.
-	 */
-	if (c->x86_vfm < INTEL_NEHALEM_EP && this_cpu_read(mce_num_banks))
-		mce_banks[0].init = false;
-
 	/*
 	 * All newer Intel systems support MCE broadcasting. Enable
 	 * synchronization with a one second timeout.
@@ -1978,29 +1947,6 @@ static void apply_quirks_zhaoxin(struct cpuinfo_x86 *c)
 	}
 }
 
-/* Add per CPU specific workarounds here */
-static void __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
-{
-	struct mca_config *cfg = &mca_cfg;
-
-	switch (c->x86_vendor) {
-	case X86_VENDOR_AMD:
-		apply_quirks_amd(c);
-		break;
-	case X86_VENDOR_INTEL:
-		apply_quirks_intel(c);
-		break;
-	case X86_VENDOR_ZHAOXIN:
-		apply_quirks_zhaoxin(c);
-		break;
-	}
-
-	if (cfg->monarch_timeout < 0)
-		cfg->monarch_timeout = 0;
-	if (cfg->bootlog != 0)
-		cfg->panic_timeout = 30;
-}
-
 static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
 {
 	if (c->x86 != 5)
@@ -2259,6 +2205,23 @@ void mca_bsp_init(struct cpuinfo_x86 *c)
 
 	if (cap & MCG_SER_P)
 		mca_cfg.ser = 1;
+
+	switch (c->x86_vendor) {
+	case X86_VENDOR_AMD:
+		apply_quirks_amd(c);
+		break;
+	case X86_VENDOR_INTEL:
+		apply_quirks_intel(c);
+		break;
+	case X86_VENDOR_ZHAOXIN:
+		apply_quirks_zhaoxin(c);
+		break;
+	}
+
+	if (mca_cfg.monarch_timeout < 0)
+		mca_cfg.monarch_timeout = 0;
+	if (mca_cfg.bootlog != 0)
+		mca_cfg.panic_timeout = 30;
 }
 
 /*
@@ -2278,8 +2241,6 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	__mcheck_cpu_cap_init();
 
-	__mcheck_cpu_apply_quirks(c);
-
 	if (!mce_gen_pool_init()) {
 		mca_cfg.disabled = 1;
 		pr_emerg("Couldn't allocate MCE records pool!\n");
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index efcf21e9552e..ae9417d634ac 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -468,8 +468,26 @@ static void intel_imc_init(struct cpuinfo_x86 *c)
 	}
 }
 
+static void intel_apply_quirks(struct cpuinfo_x86 *c)
+{
+	/*
+	 * SDM documents that on family 6 bank 0 should not be written
+	 * because it aliases to another special BIOS controlled
+	 * register.
+	 * But it's not aliased anymore on model 0x1a+
+	 * Don't ignore bank 0 completely because there could be a
+	 * valid event later, merely don't write CTL0.
+	 *
+	 * Older CPUs (prior to family 6) can't reach this point and already
+	 * return early due to the check of __mcheck_cpu_ancient_init().
+	 */
+	if (c->x86_vfm < INTEL_NEHALEM_EP && this_cpu_read(mce_num_banks))
+		this_cpu_ptr(mce_banks_array)[0].init = false;
+}
+
 void mce_intel_feature_init(struct cpuinfo_x86 *c)
 {
+	intel_apply_quirks(c);
 	intel_init_cmci();
 	intel_init_lmce();
 	intel_imc_init(c);

-- 
2.49.0


