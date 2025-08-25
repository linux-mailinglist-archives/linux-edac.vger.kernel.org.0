Return-Path: <linux-edac+bounces-4670-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CEAB348DD
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AB75E27EC
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694FF30EF8F;
	Mon, 25 Aug 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="og8OmCnr"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C382830AAC6;
	Mon, 25 Aug 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143235; cv=fail; b=hohbD1Qm4VPwOHc/t6kjfCSvh5aWWd+e91u9MSWhy7JdZOLESIjR9tx8ftegnplVKx8+axTa/fr+VazBmXsavjo9elOwApoP+wu0qMOZw+QB/4abPhbo9TaNGR4kJvViXMCdMNEXtMMoebixCCSIguO692Wh2cfalNkI3/BGcjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143235; c=relaxed/simple;
	bh=+qcV1grJKsgBwBdMVadlDHsW351W8nndrRnO6ePdrPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nRMeXffGenOUfjGE3NK+jSO0ws3NhN2iMlX6A3zqJw936BqZ9O27+pzUNRoZenxn3kW+zOO+urU3YVV17WE0wbKmcx6ZWe/lVDtZvknfT2LRTbh4jmgnlXjAKbyHhxwP8dwcmuUw6uIZN6lo6sqps9JsQJOdc3tDqO7HA0ZJRF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=og8OmCnr; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5xSGSZES31RuN80vHbJnH2bMaJ7izCmU9tWHsKYeaGeNpi+GmXlTlkRmpIZAjB9rvc2UhGqMlW7mxxSU1x2j2iknaqsVC0J7vchIMVfRoBRQuYh/lZ4rK+A3DE4wo72Kl2NRN2BnfTKxqbCMZi10J/5HHOc4XCkiZX6/aFTm0o3NPNKbpz9V3Gzti+cDw5AV5QxUl+5aPk/2yO1REdShCYuPmlRf1rAGrecYhYgtlYKepxwWQfTV6omU5XiPY6mKFIDTA84kUJlJsLdXs/ffwB44ndh59C0dtwATxifDQ29WyHXbYjEi3H0ewgvs0XzLKBWu5z/YmOrqHrKORV45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hh2S3cKezwjHo+/GZmeuMrOOyupyV11xw3oJ70ZkdGs=;
 b=OuJOnnEjWpWObc+qdpljG1AgV4/LvfijJ97gba2WmtyNnH7OX58St2Xfg7YrDyYPdR2bDt9mhRDaBJ7jOYiFIOqekfOOqMZJq0Zh0nu9n746vth+IAlzJFavO5Dah81X2d+VQn+F63dyo7iDnRvytie5UZEXj5qBf52h1wWK53QvByPtCJNJZVTR6R/BT0Hygk1rq4Hm8AD0A9MqgFjAuVvrRje4Q+WFrdojgmAc26fnEDDe9SbxcIJvJ4ZwpuVmHmjjkgR83Yz4KW8TreQmKoQwqENEFu/r2tSpEKtXhg/RD7ScoBYyRd/EBgkonuctntU+DaSeNor1Sd0PlY/hjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hh2S3cKezwjHo+/GZmeuMrOOyupyV11xw3oJ70ZkdGs=;
 b=og8OmCnrgdQfD7bftdIz3sJtW90zyMEs57gfGDoPXXJvxgZ6phMmKLzCvyl7n2yXyDieBgCMGi7c93LcqeaoMQ9YyTA02IM3cvu/ICY9d55lLxBhIldP0H44S/5II6MpDMofQdjoeCETz6S38DEoMeOv1dVGue0o1P+JYrpGK+g=
Received: from SN7PR04CA0060.namprd04.prod.outlook.com (2603:10b6:806:120::35)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 17:33:49 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::12) by SN7PR04CA0060.outlook.office365.com
 (2603:10b6:806:120::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:48 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:44 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:11 +0000
Subject: [PATCH v5 14/20] x86/mce: Unify AMD DFR handler with MCA Polling
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-14-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 20304e4a-e324-4c32-4f7b-08dde3fd8d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUNXUjVyY1h6Yk0wMkE1Ry93SklleGFOeFQxaUFmNlFxdGMyYW5lU1VLaE1q?=
 =?utf-8?B?a0NBeDJpVHlsNE1oVlJrdTQ5Y1JwSTNZdXN6WWlSdXBMMEV3OG1HZDNEOWxs?=
 =?utf-8?B?M3hKQ0UwU0FPQ2ZXbDdod1dlVkxTdUxJY1B3bzd0a3lhTzMvUGdwNlFIQWRi?=
 =?utf-8?B?YnZHb0s0MThzRnhiT0NpRUR5QWJXblRKdHdDN1VqYmFUQkVLL1JaNFRwUElj?=
 =?utf-8?B?cTdWcWJJNzdYRXV6dUhNOEw5TXBXd3hHWm1VNE5yR3JQNTJ6ZExReHpJc0Nw?=
 =?utf-8?B?WCtEOWNEdUxwSGdwWkZ1QXRjdmZJNkZGUkRWb3ZMb0w0ekRGcmtOQ09uUTE5?=
 =?utf-8?B?R2ZQdUFVMU95dzFhL2hDUzNrYS9PSFIreDZncHVqVUdRT3Y1QklQUzB3aGJj?=
 =?utf-8?B?SEtQaDc2c1VJZzlzZFQ2WWM4TTVzZi9PWUUwcXVXMHkyajNNRGFYaDdQMW1V?=
 =?utf-8?B?NTBib3o5eDhkUnpjWGllOWNIb0ZXQWVVYVVpbDN0ZWRKTWNhR0pHc2VPbnkz?=
 =?utf-8?B?Qm9yNjhTVmhEZGZPMjQ3M3lOZk1SRnBGNzBRTzQxU2NqdGdFeDc0YTRYejhF?=
 =?utf-8?B?T3laOHlkclROcTdOVVBraXFPNERIT0FsYVBEUzBDM0U1L1k1R0NSYnhtTXFt?=
 =?utf-8?B?Vk9lSEFsbzZXeHZGRm5CQk9MY2ptb1lHUW0zdmVKSll2RURtcVByaDVSdGRn?=
 =?utf-8?B?Zzg0L0JuNHAydjh0YkhxV3dab0grSFNhNzI0bHNzUENCczVSODFvT2k2SnRz?=
 =?utf-8?B?M1dYVHhzNGRLbnprTDRyTnlGSHhTT3BvamxpN0p6ajhmSWRoclA1ZUZ1bWZM?=
 =?utf-8?B?RkxvcFhVTVZ3U3EvOC8wa2dSRytLWENLS0k0NVJrNSt2aWdIUEJENDV3SDVO?=
 =?utf-8?B?ZTh5NDZkd1ZoWnNFOFB3ckI0eDdDZjR6QUZ6TWQrSzFKbkUxcFBERUExUWpK?=
 =?utf-8?B?YzlNRlpsc1Z2Y2ZpM2QxMWQ0YlowaXBDLzk4YXloVTkyTE94Q1hrTzVZMnVI?=
 =?utf-8?B?M1QrVWRJVVlPc0o5QmlwSjlhU3l4NEdDWTVJMHNydkdQNzBwYUpvbStRekNY?=
 =?utf-8?B?L3FWcmI4K215WVI1Rld2VmllYmxnQmU5LzhhVkJCM0hWZjIxNFFhajZIeU5W?=
 =?utf-8?B?eUdtN3g4OHV5WmhJYWEvaEFETnlLYUg2a3hEZXJaRWlld3RZK2JqQXpUZ3BI?=
 =?utf-8?B?S1QzbWlUQ3JobWdZMkVnTmxmZnRCMXpyUmczYy9BZmwyN1BsM0V0bEVxbUdV?=
 =?utf-8?B?Q0JWbGVJMEg3UmV1OU13SzFwaVBDTWdIc3MweTNqVDNFWlI0V2xrWHNPdGVO?=
 =?utf-8?B?TFBFNHMwb1VXSldOVlZIQXU4dGJvQjBML1JZOTd0eGg0OXhqZTRodWF0LzRR?=
 =?utf-8?B?bWtnVlE5anpNOFpNMnNyUlNPbHJ6Z081ZWhRd2NjYmhCR3AwNExUMXVCUG0r?=
 =?utf-8?B?MVNubU5CTytjUnNMQ3VxN3J2NXMwRTdEQ013OVR5VnoxYUdDS3VidzVYWTFp?=
 =?utf-8?B?Y1Rxb0M3c1ZvNk1qRmcwRWFQZWJvMjNNWjBKQU1UNnQ4WTdFN2lzRGd4aVlU?=
 =?utf-8?B?QlB4WWNPZmJSUTNjNlJXZUpGYUMvaVNTcHJGOEdocnVsbXBUNWtiSDZ4KzNX?=
 =?utf-8?B?b3JaZnFiZGlzZUZvd1M4QWJRenk3WE9wRERCUWlUR0E4bkhkTUE3Z2pJZTha?=
 =?utf-8?B?dEN6aW1BcEFlU3FhN01YaGt6czR5cnFaUitmdFNLWVJhWHFCRzZPWk9XVjVs?=
 =?utf-8?B?K0pDYVZGcmxxNWZEeUx4UFdveDlPU1c0RXNsNGVnckFFaWxPbGYzMllZWjNX?=
 =?utf-8?B?RXVZeTNEYWJpRXN3SE9KQXczbVdiVVZGNWt6bGZhN0dUenFSMlRYT1hLTFgz?=
 =?utf-8?B?ZURKUzMxeTFlc2NSZTB4VzJuREVRdm9aTXNTRTVSZzV3ZU96RFk1eGM3TlhY?=
 =?utf-8?B?ckE0WnEzM25VQ2hVY09KY1VuK0F5S1JKUG1BTHkzN05wRUFjMGI2aC9qaWQr?=
 =?utf-8?B?ZUs5c09SYXYxNTIyNG1VRndFM1l1VDFyK0xlcGR5cVM4NEJFTHJ6TUNCeE1m?=
 =?utf-8?B?ZmVZODczQy9WOHlPN1c5c0VKcUlST0pHazhJdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:48.9500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20304e4a-e324-4c32-4f7b-08dde3fd8d1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456

AMD systems optionally support a deferred error interrupt. The interrupt
should be used as another signal to trigger MCA polling. This is similar
to how other MCA interrupts are handled.

Deferred errors do not require any special handling related to the
interrupt, e.g. resetting or rearming the interrupt, etc.

However, Scalable MCA systems include a pair of registers, MCA_DESTAT
and MCA_DEADDR, that should be checked for valid errors. This check
should be done whenever MCA registers are polled. Currently, the
deferred error interrupt does this check, but the MCA polling function
does not.

Call the MCA polling function when handling the deferred error
interrupt. This keeps all "polling" cases in a common function.

Call the polling function only for banks that have the deferred error
interrupt enabled.

Add an SMCA status check helper. This will do the same status check and
register clearing that the interrupt handler has done. And it extends
the common polling flow to find AMD deferred errors.

Remove old code whose functionality is already covered in the common MCA
code.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-17-236dd74f645f@amd.com
    
    v4->v5:
    * No change.
    
    v3->v4:
    * Add kflag for checking DFR registers.
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * Keep code comment.
    * Log directly from helper function rather than pass values.
    
    Link:
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-13-3636547fe05f@amd.com
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * Keep code comment.
    * Log directly from helper function rather than pass values.

 arch/x86/include/asm/mce.h     |   6 +++
 arch/x86/kernel/cpu/mce/amd.c  | 103 ++---------------------------------------
 arch/x86/kernel/cpu/mce/core.c |  50 +++++++++++++++++++-
 3 files changed, 59 insertions(+), 100 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 31e3cb550fb3..7d6588195d56 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -165,6 +165,12 @@
  */
 #define MCE_IN_KERNEL_COPYIN	BIT_ULL(7)
 
+/*
+ * Indicates that handler should check and clear Deferred error registers
+ * rather than common ones.
+ */
+#define MCE_CHECK_DFR_REGS	BIT_ULL(8)
+
 /*
  * This structure contains all data related to the MCE log.  Also
  * carries a signature to make it easier to find from external
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 63d8b12fe30f..4a832c24d43b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -56,6 +56,7 @@ static bool thresholding_irq_en;
 
 struct mce_amd_cpu_data {
 	mce_banks_t     thr_intr_banks;
+	mce_banks_t     dfr_intr_banks;
 };
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
@@ -300,8 +301,10 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		 * APIC based interrupt. First, check that no interrupt has been
 		 * set.
 		 */
-		if ((low & BIT(5)) && !((high >> 5) & 0x3))
+		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
+			__set_bit(bank, this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 			high |= BIT(5);
+		}
 
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
 
@@ -796,37 +799,6 @@ bool amd_mce_usable_address(struct mce *m)
 	return false;
 }
 
-static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
-{
-	struct mce_hw_err err;
-	struct mce *m = &err.m;
-
-	mce_prep_record(&err);
-
-	m->status = status;
-	m->misc   = misc;
-	m->bank   = bank;
-	m->tsc	 = rdtsc();
-
-	if (m->status & MCI_STATUS_ADDRV) {
-		m->addr = addr;
-
-		smca_extract_err_addr(m);
-	}
-
-	if (mce_flags.smca) {
-		rdmsrq(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
-
-		if (m->status & MCI_STATUS_SYNDV) {
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vendor.amd.synd1);
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vendor.amd.synd2);
-		}
-	}
-
-	mce_log(&err);
-}
-
 DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 {
 	trace_deferred_error_apic_entry(DEFERRED_ERROR_VECTOR);
@@ -836,75 +808,10 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 	apic_eoi();
 }
 
-/*
- * Returns true if the logged error is deferred. False, otherwise.
- */
-static inline bool
-_log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
-{
-	u64 status, addr = 0;
-
-	rdmsrq(msr_stat, status);
-	if (!(status & MCI_STATUS_VAL))
-		return false;
-
-	if (status & MCI_STATUS_ADDRV)
-		rdmsrq(msr_addr, addr);
-
-	__log_error(bank, status, addr, misc);
-
-	wrmsrq(msr_stat, 0);
-
-	return status & MCI_STATUS_DEFERRED;
-}
-
-static bool _log_error_deferred(unsigned int bank, u32 misc)
-{
-	if (!_log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
-			     mca_msr_reg(bank, MCA_ADDR), misc))
-		return false;
-
-	/*
-	 * Non-SMCA systems don't have MCA_DESTAT/MCA_DEADDR registers.
-	 * Return true here to avoid accessing these registers.
-	 */
-	if (!mce_flags.smca)
-		return true;
-
-	/* Clear MCA_DESTAT if the deferred error was logged from MCA_STATUS. */
-	wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(bank), 0);
-	return true;
-}
-
-/*
- * We have three scenarios for checking for Deferred errors:
- *
- * 1) Non-SMCA systems check MCA_STATUS and log error if found.
- * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
- *    clear MCA_DESTAT.
- * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
- *    log it.
- */
-static void log_error_deferred(unsigned int bank)
-{
-	if (_log_error_deferred(bank, 0))
-		return;
-
-	/*
-	 * Only deferred errors are logged in MCA_DE{STAT,ADDR} so just check
-	 * for a valid error.
-	 */
-	_log_error_bank(bank, MSR_AMD64_SMCA_MCx_DESTAT(bank),
-			      MSR_AMD64_SMCA_MCx_DEADDR(bank), 0);
-}
-
 /* APIC interrupt handler for deferred errors */
 static void amd_deferred_error_interrupt(void)
 {
-	unsigned int bank;
-
-	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank)
-		log_error_deferred(bank);
+	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 }
 
 static void reset_block(struct threshold_block *block)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e7a9a175bf49..6b3569b412a6 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -687,7 +687,10 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 		m->misc = mce_rdmsrq(mca_msr_reg(i, MCA_MISC));
 
 	if (m->status & MCI_STATUS_ADDRV) {
-		m->addr = mce_rdmsrq(mca_msr_reg(i, MCA_ADDR));
+		if (m->kflags & MCE_CHECK_DFR_REGS)
+			m->addr = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DEADDR(i));
+		else
+			m->addr = mce_rdmsrq(mca_msr_reg(i, MCA_ADDR));
 
 		/*
 		 * Mask the reported address by the reported granularity.
@@ -714,6 +717,43 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 DEFINE_PER_CPU(unsigned, mce_poll_count);
 
+/*
+ * We have three scenarios for checking for Deferred errors:
+ *
+ * 1) Non-SMCA systems check MCA_STATUS and log error if found.
+ * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
+ *    clear MCA_DESTAT.
+ * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
+ *    log it.
+ */
+static bool smca_should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
+{
+	struct mce *m = &err->m;
+
+	/*
+	 * If this is a deferred error found in MCA_STATUS, then clear
+	 * the redundant data from the MCA_DESTAT register.
+	 */
+	if (m->status & MCI_STATUS_VAL) {
+		if (m->status & MCI_STATUS_DEFERRED)
+			mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+
+		return true;
+	}
+
+	/*
+	 * If the MCA_DESTAT register has valid data, then use
+	 * it as the status register.
+	 */
+	m->status = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
+
+	if (!(m->status & MCI_STATUS_VAL))
+		return false;
+
+	m->kflags |= MCE_CHECK_DFR_REGS;
+	return true;
+}
+
 /*
  * Newer Intel systems that support software error
  * recovery need to make additional checks. Other
@@ -740,6 +780,9 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
 {
 	struct mce *m = &err->m;
 
+	if (mce_flags.smca)
+		return smca_should_log_poll_error(flags, err);
+
 	/* If this entry is not valid, ignore it. */
 	if (!(m->status & MCI_STATUS_VAL))
 		return false;
@@ -837,7 +880,10 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		/*
 		 * Clear state for this bank.
 		 */
-		mce_wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
+		if (m->kflags & MCE_CHECK_DFR_REGS)
+			mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(i), 0);
+		else
+			mce_wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 
 	/*

-- 
2.51.0


