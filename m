Return-Path: <linux-edac+bounces-3555-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C82C5A8A217
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC537A3DFF
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9CA29899D;
	Tue, 15 Apr 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JgZTNPq0"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D5297A6F;
	Tue, 15 Apr 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728925; cv=fail; b=f3Y14w8XaJk9/55EN3we1f1P84MvEvVRUl7IGdNOVI03cQSe5mfzrSV2nglaQQHO0fXhOQyysu9QMklvsP4NXkrgGxrma2NEv3CRO+GfVm1HkAKCIrmIsqX4Xc6u1WLeae+p/ub7fsHomYeFwfzbSkNX8YTXZ+bII5zHxwV4pUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728925; c=relaxed/simple;
	bh=vVfzO5o9r1naLWabpnROggm13ikeKKI4qB6h+GIZVdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Hc+4RTnBeofDypvOlUm4gtfajCPzj+XHyOqw0BwrYmuBDX1Aq+wvKjdIQkR0c4Px5+tdw/my8ZdWGTKQb4oB/Fr03YQH9uSgQobSjsd4ItmtQzpSn0hy5Ew2l7G/7gPB89NEYPGJ0nLF/gN8ZIZxG0N+kYUSBdlXHd9aCnlLOgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JgZTNPq0; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHQYnVJpfZ1fAvkGONoaa3K7mGqyJ6cpPP/BseKENUGfy+ezCrdSNP6WNYnWCQRgr6DOG1sVU6zDiMa0X2NojPgOX7fhv0DyNV4pp4AsWGShMcaCrzMu5hOj23Xpc5MF4kM1cSx303T0qrRhd/Ex6O41AYz++c1zm0dlGtWyp2iyvmGPrkZBcegQIf2IdLx9H8AWK2BG0UNx3LAZeLXcusV2SjZ3Z6nROpS9tZExxO0GeHN7zcCW686crL0NN0UY5Rtc4R6AbF67voWXti31juHofRk8yo9vLJp9aA2SejJTMqPGE2/3dJFtAP9tjRtvL5DGJg7RJlYB4fFFnCFPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJePmtdAyFdUrNRVn8k4GQrUQstPd9mhQ/p0qRfMLn4=;
 b=N4sHqH1O2J+5XEGFEJJ2wavnp57vMX8FxfQmBAh3K1APAbGoQnzDbcE4xMJGoauiBAtTW9Pt59UJKO9VdS67BwIBPw2UxllUg+No76qaTuFe/lWI+5oOmlHPgkb7HPOvMGuLWKjyDqX6W+yHq3XKJdUwmhTVC7VXd0N7DlKMiM2/8cqguZmB45RoYGjUDrq58QiNvs/WrAo5aQgEM93OzntE9seTS1h6T7yuOMVl+XHp6sgRyN93ABaLBcOj7sLl/saZFcVz1x9Owv/Bz3cT9epimiZ/j+JEzRlGffojW3e0daxqdf/9YSHnUYZbv/U936dE7UnaaDfL+aIVkwa5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJePmtdAyFdUrNRVn8k4GQrUQstPd9mhQ/p0qRfMLn4=;
 b=JgZTNPq0mgLKcVcbmJyo8rJSr86qhbDa8UEB0DPyd9BHfeqrKObU0V0ulkGIgDu3xDH2LExCoWF4i+hosIc0I1kPtI/Xr3/kF7NElkTtjLaNIVCzdMtc9P5mvcPI1pOP28edfHbsGOOaXUcVyVDWY6WiiwVFK94ToEcK9j+IQs8=
Received: from CH0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:610:b2::11)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 14:55:17 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::6e) by CH0PR13CA0036.outlook.office365.com
 (2603:10b6:610:b2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 14:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:17 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:15 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:55:05 +0000
Subject: [PATCH v3 10/17] x86/mce: Separate global and per-CPU quirks
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-10-8ffd9eb4aa56@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 179593d7-eef3-4333-cab6-08dd7c2d893e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG5WdUZOQUlhblAvWUxPM3EyckNpR0ZmYlUzZ21lNCszRjdJNFQxZk1zN2lk?=
 =?utf-8?B?bGwvR25aWm1zS0RCc1VhK0FSZ3lPYzVvQlhqcXIvcUgwalBUZDExdWZqVzZN?=
 =?utf-8?B?bGE4RnFZQ0dTaFNtTU1qS1lZMWVYbHozMkpiYjZjbnQ0ZzVXdXBuRkpDY0cv?=
 =?utf-8?B?YS9KMnJKM2s3UTJsN1ZxV0ljMUhIZEt2OGxsc3Z6NjE2VzVuTkdPYXV4UjQ3?=
 =?utf-8?B?WlRDT2ZnZlB5Q3Z5RVUzUGgyYm9MQlU2bTRibVY4YnNFMmlvekpZZFYvTGRI?=
 =?utf-8?B?clZkdFpzQnI1SzkvV1V4WDNyWEljT2ZDc3lqK2lWdzhIK29zbDNrVHhpbVll?=
 =?utf-8?B?OGdXbk02UGdqSVNjZ2xLaTlyOHVOS2p3UHBwaEZCeTUwaC9YckNUaGszQ2xY?=
 =?utf-8?B?OFlPY3hZdXBna1dlanBobXY3ZDB0cTdxek5kWVArc25lTmo3MHA1NGJjYnJa?=
 =?utf-8?B?V25XUUZNbmhubkQ4VEdES0FJQ0lQMGxXWHptUVFpUVphNkMxdFg1RVBJQXFs?=
 =?utf-8?B?TVY2YkhpS29pSUJ3a0pDZGNsSmJqMllhVTVNTW01dmF3UXl5eVRsU3BEUUxt?=
 =?utf-8?B?ZFJHKzZZd3d2bUdLb2xNRVA2TjdaT0ZXejIzSkRycW1HT2dQNlVqSXNLOHVl?=
 =?utf-8?B?SXFOS056djh4VCswSWdLTUZtME4wUlVZSm43c3h5QjR0TElxQTlFZkovN205?=
 =?utf-8?B?MHh0VUhpQUx1T21pdTN0YjR1OHJuNVptb3hxMzM2eEQvWVByZUFVYk1rdHJr?=
 =?utf-8?B?N1kxTEdnZTJDbDdmcExSL1R5VzJ4NnRjTCtLbHZOM3ZzRS9NRlZOZlh3ZHhB?=
 =?utf-8?B?eUZvOS9yNHVjWWcyeXkyT2FhSnJGSlU5V0JTM1Y3OGpkcjZZb0h0SXlJUGJF?=
 =?utf-8?B?bE5YVXFSb2J0UFdVUmdleUVoWEZ5N3BxaExRSFZjYnhEQkxwVnZhY3RYVmVV?=
 =?utf-8?B?VXFtTVQ3L1FERlBrV0d0MXA0T0E5TXVYb295Vm9DZ2xxV3lZdXgzQUhLL2Nq?=
 =?utf-8?B?Um96WUdoMThmNHBEKzQ3cUR5TVFSWFcwd3NoMEpSaUtHVXdUNWlOc25tUkNZ?=
 =?utf-8?B?MWRFeTh1aVhCRkJwdERONlNRK1MrYkhRV1YwRmE2dXlJMmFxNkROUmJ2Mjhk?=
 =?utf-8?B?T00xR3RTdmUydlNrOEhyVTdhTGlTS3JibGdIOHNMYWIrV28zb0pyRVdBUDl2?=
 =?utf-8?B?VXp1SzlxYnkxWUVmZzRrVHd4Q28xR1d4TjlhalFHYW1IMzVJaEc4TWN5Mlht?=
 =?utf-8?B?ZjgyWE1CRDZMTmxHMm5HYzBKZWJOeDlvbjJzcjlTYVordjdQa3ZxN0YrVW1Z?=
 =?utf-8?B?R2lBRG4zOTd6b253R09OOFNJYStrWm9BVk4ycjdtT1c1VFdNY3V6ZVVkckFz?=
 =?utf-8?B?NUNpUmVGTjdtS2pCcThDdVA1aEhjbEFFL3VKa2piZEdDY0tZbEpSdWVZSU5h?=
 =?utf-8?B?NnhweW0vY2drMStGY0pYWlY2TU1IUXV0MUdsN1hBcnREMFJmSENhV0RQZDVh?=
 =?utf-8?B?bGNQWEZpV1ZscHoyeEJLT3ZCWUc1WUMwWjE2T3pOWG5zeHg2S0pYWVI4TkhD?=
 =?utf-8?B?bVl1d0RwVlRQSWl3NTNwVVRlUW84bDFnWURnbVJKdEwxcVEzQld3c0ZqNlFo?=
 =?utf-8?B?NmNUVHhqaW1RQzJnd3o2WE43OUVkZUlrQi9yZG1rQ2pDQ3dweUI2ZUpPdUhp?=
 =?utf-8?B?dTJYVVg3K1VURTQ5L1FEaVJtUVg4SmZ2enNyRytKanRmQlY2ZS81aUJnc0VG?=
 =?utf-8?B?ak04WjF0UGhpODN6SUZSTkhLRnJKUlhuUXQwT2E5SitNREJVSlp3aGN1cEdZ?=
 =?utf-8?B?dFl2bW42K0ZzdElScUFpV2pWMkFWR3N1T3plOUVlNjJ3OVpFL0FXTmsrYWpo?=
 =?utf-8?B?SDBLNW5Yc2E1VmFFb2R6UXJTa05MMmpLcXkza0dXOUsxbGR3R1Z1NVBBUHBN?=
 =?utf-8?B?Z2ZnYkQraTQxMHlRVitBRzJQT2FoVU4yeGFnd2dKSGRZRWlyMW9UdWl6d0Z4?=
 =?utf-8?B?ZlhYNXBpWWRyNVczNmV0aHFXcTg4TERvTE9MTnpwZmZzV1J2MnRKa1dlV0pN?=
 =?utf-8?B?eTJnZm41anVtTFBINHIyMUdtRm4rekMvNDVxdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:17.3819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 179593d7-eef3-4333-cab6-08dd7c2d893e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603

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
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-10-3636547fe05f@amd.com
    
    v2->v3:
    * Update code comment.
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c   | 23 +++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c  | 36 ++----------------------------------
 arch/x86/kernel/cpu/mce/intel.c | 18 ++++++++++++++++++
 3 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 0d84b171b851..6a69cac36c18 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -649,6 +649,28 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
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
@@ -656,6 +678,7 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	amd_apply_quirks(c);
 	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9dc9d672a7d1..413c68f18084 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1879,18 +1879,6 @@ static void __mcheck_cpu_init_prepare_banks(void)
 
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
@@ -1899,13 +1887,6 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
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
@@ -1919,23 +1900,10 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
 
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
@@ -2255,6 +2223,8 @@ void cpu_mca_init(struct cpuinfo_x86 *c)
 
 	if (cap & MCG_SER_P)
 		mca_cfg.ser = 1;
+
+	__mcheck_cpu_apply_quirks(c);
 }
 
 /*
@@ -2274,8 +2244,6 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
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


