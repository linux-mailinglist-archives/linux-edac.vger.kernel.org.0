Return-Path: <linux-edac+bounces-4220-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048B8AE686B
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D266A0995
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9922DECC2;
	Tue, 24 Jun 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5p4BKVxE"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D0E2D8796;
	Tue, 24 Jun 2025 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774599; cv=fail; b=UaNintQgzmo5wPYmDUJAoWfY31BFZapFeuLawmK4tAPyFP4O53hyq8Fqgvsg2MT00lTIVhieI++HROq0gKhhqk2vKrqaBHVqOpZxVyOAsKxZZc/thLgBdmOgnzRIFmfPHL00tsyFuPZ/MuJh2gV53IBMBSZsBEKuGtJQGGelJ38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774599; c=relaxed/simple;
	bh=U3CKZ8tT86xJfMuxj5j9CKO6AdnKEhOXl+GsViWSCNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=f/BbJUynieoJ5wIsFtcZOZq0MFzfhoTqB15p5tOLb/BudbsV5/kDj429gUY2pKYxxh8lFn30cBj+k8ByWusvZDhz+gXvvPY4hueFuLxZn0tD/XFfyKDNsxUEw7UX/X6Z+8W2LGKAZDJjHp8YAiuwZzWg+oFE49aPzjGPrlRPn0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5p4BKVxE; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qygwTz31pQ5iXnVmAjC1AHZoPhHHBv2i2WpSZfCkp9YK5pwRuarziwRTim3bgbFe8S71IhPDumY7Np5CRi0mDZmWan/IPJYws+s7aMsRsG2lILqqx8nKeTAmNrsldfjTwMSWyga6uEHWn4EJJJwoRGjh6Vaiz44m5qls9JJkxeWQRiQwQx7NFCsTBZxugQmNNhAyeZ3Ik3OtXzWapmPkeBLKw7zKPzbLXIkDHkQItgmT+hHchrL+eCFI47gbSIoT9VerzpKVHmAPp7Tkw8ZiLCaaT8WuvNgL+3G0J550AjM/f7jLBLziMmoEGsfq2lf25rxV//0XuwrEHFPgICoL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t4Lc70LKiod2oQMEiR7zJ1v7IH0tyXTmniU3fFqoiw=;
 b=aVvMwixx91OcsJWbbNqAdAaQLJ06eq1yXVPR0omrKEkauWpDIkdTNtKURqQo6i5ZUfSnKsEOnr/8PHUItwf7x4FO/zf/iT+BWsa33rQX70japfibJrRNVFpQY1X6X7VNLac79GWvVKlw7Vg6JCbMMafCuoqeqe95gvlGgSwfZlTFnu1NdgGbIcwC/6pOnHjuNY0M2FkSDKn3LycA3x2WLCGHhjavrDL1u7Abgjvv6n9bfnSUUXmuKFLZqkjX9ZsnSTYEQKIwYApxHF6kUSyGhHsvGjzNvs4U3X542HNQ2aJn+lGUFkr0Ifnjzi5oBPpNmHYKDWkaC+WYwqiyZ2R6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t4Lc70LKiod2oQMEiR7zJ1v7IH0tyXTmniU3fFqoiw=;
 b=5p4BKVxE/931tZZC0QfIJOws8JAk3qMSO3e6dvidXithofqty+1/Y/jEExYnWnzaX3BsVzSwpbnWOwc5kzTz0lCu1a7Y7eY1/k+tBd4+Z868Z32Ho11CL1Awb5fzzYJ+tlD07JSLD5an2fhSd/o0ddssPBEys4fmMSZ9FaLumGg=
Received: from MW4PR03CA0232.namprd03.prod.outlook.com (2603:10b6:303:b9::27)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 14:16:33 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::ab) by MW4PR03CA0232.outlook.office365.com
 (2603:10b6:303:b9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:32 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:27 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:00 +0000
Subject: [PATCH v4 05/22] x86/mce/amd: Rename threshold restart function
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-5-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 2614d55a-850d-4bac-7fb3-08ddb329b8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGZTWlBpYmJ3eUUwYzJZRGQvYXBLb1N0a21YU2ROakhVK1F1cC9UZGo1RFFJ?=
 =?utf-8?B?TFRMY3RmLzlVbCtob2hCYjBtV2FwV25OWjJnTmdzQnRnZUhmSmZDYlN3TlNT?=
 =?utf-8?B?Z0V2MWlGalIyVlhrNzJnMGJvQjdadkpyTUNjVTBuTEtQcndVZDdWWUJvaHd2?=
 =?utf-8?B?R1RMT2ZBaERZanZHWDF3NWN4LzhkM2ltUU9qL0lCaU53SFJweS9ocFlVbzRO?=
 =?utf-8?B?eW85NXdCMnkvNkp3MFU2VFluQnd0YWR4Ny96QTRmNTA5cUh2TGs0U1JydDBM?=
 =?utf-8?B?MUZiQlpoWW43V3dMb3hqS1JDbnRjY3NjdTJnLzRPcHFKWFVWeEtsTWVnZWI5?=
 =?utf-8?B?VXVkY2lSL21reUtMcDB3MlFPZFM4T1FPQnhJSHRTU04xemZ3K2piaklVcThM?=
 =?utf-8?B?S2dLUm1mMFZTZUhRN1hYSDdjbit2cEpzc2tUOHZaUTlsS0tEcWpIeFhPbVNE?=
 =?utf-8?B?THRuMWJQWGFWMmNHUEs2M1R2dHVtd0Zua2EwTVdZb1kxUzZtdzViNVhiZkJw?=
 =?utf-8?B?WUNSWXhtUnJhK25NSGgyNUdTc1FzOXp3ZVpRYVFrdXUxKzZZVHdqVldWM2Jq?=
 =?utf-8?B?M0hVaGpuMHRhck9Kd21xeXlPT3I2aVdCYkFQOEpIQzU2MVllWlI1ZFR2YzhC?=
 =?utf-8?B?aXpXME02WWI0M0tYMWpWeEdXYmFyU1lKZzV6QW1ubS9TSWx1WUFNekorbU1k?=
 =?utf-8?B?WGR4UFFpREZ5enVPOFFlSTFXYjFtVDcxTkVOcThsdVl6QjZSdFJSdWxYMUIv?=
 =?utf-8?B?c3BpejlJNG1HU0JTYnNCOW5TYUoyRDNRcVdHWkQwQ3NkMWRmZWx4L1Y2eERl?=
 =?utf-8?B?S25FRDZVbTY4djhXYng1U0FXM29ZTXJSa1djdFUvQmFPOUQ4MDBxNTJtdkhh?=
 =?utf-8?B?cEVraklLV1JYUWxvVFBuSnVXd1UweVBjUWVWejBkR1ZiQVlpNDRpbHl3T28w?=
 =?utf-8?B?d1Jjb0ZXRlE3eXpSTThnTndGeVB4SE56a0JzTXpCTmZNL21RNW5rbDkrUHJs?=
 =?utf-8?B?ZEVUWW52aERUWWI5Y2Y5SVdFS1M0ek11SjZMZFVoSks5T2ZoaFgzTFNOUDJV?=
 =?utf-8?B?N0N1Vjc0MnNnUGdTa2hRbmplSFluUXNPL1czWGg5U1RZSXJ0TFFUTkFaTEZF?=
 =?utf-8?B?REh4RnpwZ2ZvaDYvc1paS09xR2Y3R0ZVV3hKVzh4MktvOWYxNXZTSTRmaDAx?=
 =?utf-8?B?QzJJR2syZU5LR0pmQmJnak05VEdFOEMyajQ1NmFEZlliVjUxeVJwYnBLUjJs?=
 =?utf-8?B?WG9ZREpSQ0RBTmxvMDVldEtacTlvcFBhaExsUUZLZ2ZyRFUvdzJTRGoyMFli?=
 =?utf-8?B?RHBqd3FINTQ4QmcyNmVvSGdXcDlKRXBMWmMzdG1tZzBPOWNpdUo1UEc3Vm5Q?=
 =?utf-8?B?aC9Mck9zNWtXbUgvdlhmcDRaZXI2eEZCTzdEZXNQVFdoTnQwaGF4S0xzYng5?=
 =?utf-8?B?MEhPMlNVRlhOcVBMaDNDQmJPSlBrTUFsUzVqQXIxZk53VTYwd1NaZDJiclB0?=
 =?utf-8?B?R2lpS2pnRGZZMDQ3dnVydng5VFRKMDVEMThvTXdpNktodG43UXh1YldZeDNv?=
 =?utf-8?B?NFgydW0wZkV0RTRZTWd6bFpaV2V1QVJwRnFZNzZIWlVLT0kxUEgwaElQTmVu?=
 =?utf-8?B?Qm1BcDlPbXhRMkgzbUVXajZBbVlDS1VXY1pDWmhyQkw0cnlLdGlKVHh0aTM1?=
 =?utf-8?B?eE1YbVBnM1JrTHFyWElyS1NXeWVReElmbkY1Y0RyVkhzc01wS3FFVWxCUWVw?=
 =?utf-8?B?dmE5MFRGV2I4RUZ4YXdKaFBiL2s0a0RKZWtnTnFkNW83RWE4YlNvazNxcmd6?=
 =?utf-8?B?WHliWGhacXFnNk5jN29hbnJ1K2J2am9qWGEvZmtjVnl5NWxQMVh3NFc3bkdS?=
 =?utf-8?B?Ynd6NjNkZFNJYnFrUkFEQjYxb21TVllwaXFnUlI3bXpKNktpQnJITGpYQlJa?=
 =?utf-8?B?WnZWMlpVbUlpSmxOM2E4R1lGRmxHT0JEcDd0QUVhWjZiTjJDU1ZDNFA0RXJn?=
 =?utf-8?B?b3A1TFlWZ09pN2MxdFBnMmZ2ZjcvRFBGVExVSkY2MWJlS1NQV2ozNTBPdUpQ?=
 =?utf-8?Q?hLoHXk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:32.7529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2614d55a-850d-4bac-7fb3-08ddb329b8b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685

It operates per block rather than per bank. So rename it for clarity.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    v3->v4:
    * New in v4.

 arch/x86/kernel/cpu/mce/amd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5c4eb28c3ac9..9b980aecb6b3 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -419,8 +419,8 @@ static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 	return true;
 };
 
-/* Reprogram MCx_MISC MSR behind this threshold bank. */
-static void threshold_restart_bank(void *_tr)
+/* Reprogram MCx_MISC MSR behind this threshold block. */
+static void threshold_restart_block(void *_tr)
 {
 	struct thresh_restart *tr = _tr;
 	u32 hi, lo;
@@ -478,7 +478,7 @@ static void mce_threshold_block_init(struct threshold_block *b, int offset)
 	};
 
 	b->threshold_limit		= THRESHOLD_MAX;
-	threshold_restart_bank(&tr);
+	threshold_restart_block(&tr);
 };
 
 static int setup_APIC_mce_threshold(int reserved, int new)
@@ -921,7 +921,7 @@ static void log_and_reset_block(struct threshold_block *block)
 	/* Reset threshold block after logging error. */
 	memset(&tr, 0, sizeof(tr));
 	tr.b = block;
-	threshold_restart_bank(&tr);
+	threshold_restart_block(&tr);
 }
 
 /*
@@ -995,7 +995,7 @@ store_interrupt_enable(struct threshold_block *b, const char *buf, size_t size)
 	memset(&tr, 0, sizeof(tr));
 	tr.b		= b;
 
-	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+	if (smp_call_function_single(b->cpu, threshold_restart_block, &tr, 1))
 		return -ENODEV;
 
 	return size;
@@ -1020,7 +1020,7 @@ store_threshold_limit(struct threshold_block *b, const char *buf, size_t size)
 	b->threshold_limit = new;
 	tr.b = b;
 
-	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+	if (smp_call_function_single(b->cpu, threshold_restart_block, &tr, 1))
 		return -ENODEV;
 
 	return size;

-- 
2.49.0


