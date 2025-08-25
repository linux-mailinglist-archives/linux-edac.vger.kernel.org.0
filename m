Return-Path: <linux-edac+bounces-4660-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32704B348C0
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6871A87C44
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4DE307AD1;
	Mon, 25 Aug 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DAQ2JOWw"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EC3306D58;
	Mon, 25 Aug 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143229; cv=fail; b=LTdDMnt1QNRRtbHnqMRo84t0El+DOnbDK509aHcvpEqwKAza6Ny/7WdX250caHRTcfgZK4oW2WDt2SXY4soFBRN+9ReJA4qDDB6RY+fZ57aLDfYcoZiwbez/e14N0YcwDOafzFQbn7pL6sAYeGPnzngDicYcb6qm+0+/jCnfHNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143229; c=relaxed/simple;
	bh=N1eB1V0YFwpm6KPXb03rMLy+iifXtMxZkUIFNfUv9Zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=az7pa+RkNX0620qrFt+0EHezwMNVmTGvSwbZAsrZrVduUBuDFgthuQucGgCrk9+v9Y+z57tEFWUElckncIpn9eg4fL2PBJrz3TvOZkUTbdP9DtUwhq/0c0mbx2DMd+AdHhKYNSprO87tu/b+GQqO+Dpf/laD3l1/pHDZxYPOTvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DAQ2JOWw; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmHZ0CzlVLq6MPTJDItJynCzFxiWs0xUsfK2gMm7E1Avbcedtv5/TBHqLlpvEmGRM86XcLG2n7wcs5SFpio0B0mJNrC6bO0GXu5u/eZDC/re5AtWkofdMo91WisD4JatwJSwLgb6voRC4coUNyiqSuGo3rEldelY63XxFLr7f5uyEAhS1FIcaqar0l6HBgYQF5//eGzuqE2xKCQ3ZhRX5Ba7oAM+NiuffPcWwOge1gzv37gfwB6a5mWsMvlEH9kOs3eGIomqyenFwF74OFmrqP29nvlQsmFEiaNqq/H5cfQjXf7GcT9rttco/Ldp7MdhkeZiH9GcNo6vZ5NID1vIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4ojCnshDA3cCl000uqNFDIfXR9mNosoCVmtF4loXbM=;
 b=P3y6Yf8kqLw9dZF+UnGXjCz17JeUdnu6k9cxDuvDgB6P5jME9djxnEWDbl6hP06Fp+s6ExH6uNlW7gJnAm+PNYiN00UysVq3ywnac4OV3djVffG3tnoT1BkAjvtZJrM034GIgyvY0d42dkQwSIPnSXDN46P/3sX69BrRdfZw0XUIWxOSXuQpb2WQcpr6kWWxJJe9fSTwaGxzQ6QKtb+CRmIJFULJ33WK5hCQzAQDIUPGwT0PmIhngAf2725byE4kS4D8oYesqMoRgfFvrEMHjToGPxc350v+pX9FOzZ1X6nua864IbgtcJTplqaLYQPicRH8vjDgmcC3uQA7D1Zitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4ojCnshDA3cCl000uqNFDIfXR9mNosoCVmtF4loXbM=;
 b=DAQ2JOWwOpWtl1rmM3sUJz4tsH1OTmUFjpLmyMu67lTmxlV5m9wPUptGrOS8MIOyU99bhokoaeZnTaKjgNzNXNvAmtq93yYc3Cn65/qVulFAxF400Ux/ANWrr8kOU79N+Q9Q7MQkml0zEP5y8V03HrvO+rQkH0KtsB3iWtjnFYE=
Received: from SN7PR04CA0046.namprd04.prod.outlook.com (2603:10b6:806:120::21)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 17:33:41 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::7c) by SN7PR04CA0046.outlook.office365.com
 (2603:10b6:806:120::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:38 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:36 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:32:59 +0000
Subject: [PATCH v5 02/20] x86/mce/amd: Remove return value for
 mce_threshold_{create,remove}_device()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-2-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: b0913c1e-360b-4d75-fc04-08dde3fd86ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVFTcjJWOVArbGFhb01HSXpnbytzaSs0Uk1aOEhmNEFxVXJuS1gxUHFLSnpU?=
 =?utf-8?B?NHpvb0RvVzc5dU5SWGEzZ0VYYSs3SmZzcEVSOGpoWEF5UENIMWxaNmxQUUJS?=
 =?utf-8?B?c21lYXMwd3ZlckVWRmJIWXZBTzVHM2dYaTRTTlJ1Z25OSy9zUTFZUzcrYWlK?=
 =?utf-8?B?MERZYWJ5MW1EaVFoTDRYSFZpNENWS0pLdk5ZdzI5dWpCb2xNNTNCd3p2TWFC?=
 =?utf-8?B?WlN6Q3VZbkN3QmozenptVmcrdVVkUHI3NmxWanppOHNEVzhReUFPeWxzYnVz?=
 =?utf-8?B?amU2bFp3dkg0ay9naEZFQWdqWDdRenlqUHFoaHNRZmYxSmZSdk54L1ZUeVRZ?=
 =?utf-8?B?QXBsa01ENTBzMkRXUHJ5UFNlVlB0NGpzbUZydzNEdzBYMGx3Y2Mva3JKTDZ6?=
 =?utf-8?B?WnZ1UHRtR1U5WExxM2FoZjVqb2huK0NpL2g1QWdNWUhFTThQY0lUUVVtZGNJ?=
 =?utf-8?B?ZGpmN283Ry9GUWR4eit1Rk5ZbUxiS0k2U3NldC9mWkljemJYazdWNVBCV1Jn?=
 =?utf-8?B?Z1ZTZVFaTE9HVWdoY0s5RDg5bGIxTGN0OGVDbWg4YzU3MFFuM0NaL3hZejUr?=
 =?utf-8?B?U0ZkS0hHd01ldFlvMkdWNWFqcXBNOEhXR2M3djRMRTdBd2JJdmZkUUc1V2or?=
 =?utf-8?B?MnhtYnRGcnhHVEErT1pHT0Q1TmREVG8rYXg2RlJLMHdKOUdLWTI2T0pBcHMz?=
 =?utf-8?B?dEhHVk1tRm9aY1Y3YVA4SVFBZWphbjVuQW93TVN6M01pOTNsckRHQ2IvREYv?=
 =?utf-8?B?ZklLM294Vks5dFM0WWtGYjY1UkFUeUV4UUFlZlRKSC9CanFKdFNBYTlFbVd2?=
 =?utf-8?B?YnFvcGl1dG1uMnlHZm5PaEhkVEREWTRsZFg5aTRIVnNwWHhYL3ZpZHlrUElh?=
 =?utf-8?B?Wm9Nc21EelpqUG1JRTJxaE9tTEh5QkhYN05CSTIxQjlBR0xCeC83cFF1eVZ1?=
 =?utf-8?B?Ykh0aDAvSG5qWGoyMkNJM2pBdVBrZllvK0xDKzZvdFlrQnJVYlJ3SExQTW0x?=
 =?utf-8?B?VGhnOWtlVHRqNEdhRUxvdjN4NDdwbnIyeVZXd3hFTlZrTVVBc0Q1bDBLcVds?=
 =?utf-8?B?TWcrdnlQYVRsbDdxOXBWNTZYOGtyenRtU0RZcU4xUVh5QWYrcURoM0FWK3hU?=
 =?utf-8?B?YXZxRWZodHc0SXVYWCtTMTlLbE5wMXlwSWdyN1MrSDJHREZDZGh5eHJCY2xs?=
 =?utf-8?B?TkFTbnN0Ky9KOFpsTTFCU3ZqNnJjM281cVV5cnl4WWFKSnRDRkdFVXNhRWtv?=
 =?utf-8?B?NUdCY1g2Z01JR0VPVkM0a1AwT1NlaTJHOGpsVVR6aUhWUTVOeEN5QlBZMlE1?=
 =?utf-8?B?RnNnTDRUNmFYSE5vbllNcG90Z2RHbkxyelRnU2NNZnhvK0sxMkRMSVFkQjJD?=
 =?utf-8?B?NFZ3aDhTTjB0N1QwNUlhQ3ppeUc4bkpYS3k3VkRSbFJzUENIQStVL1FVWWpO?=
 =?utf-8?B?bHFtOTZqZFBpQXU5ZUF3aGpDY1JpZklmWmc3WUFxUUtuSzgvWUg0dXFwekV3?=
 =?utf-8?B?ZDdXaU0wa0NPVEhaMVRDcG81RjRLZ2FlUmFyTGRkUlZlR1QyV1owNnA3OEFi?=
 =?utf-8?B?MTcxZ2pkMW5FUU5UN3VJMzU2Z2praXp0WEtlSXA1TWhHeXcrQnRTSlpEKzF4?=
 =?utf-8?B?alBoSlJPamVHS2NxaHRoRFcrV0wwZ1REVUREeitqbzNyR0pmeStKcTVHZWw4?=
 =?utf-8?B?elhPZTZLR2VYSXcwUm9PTVhMM2tGNjNqUWZaeHorWjVpTVd0T3A4RnA2SkJk?=
 =?utf-8?B?U0FDTE96cDJ6WTkxSysyMTV1aC9CaFJQWFloTURDbG5xNHA5bkpMUXFPck5i?=
 =?utf-8?B?Q1I0OEFDOGpUbEI1RUozYWswUjBpbmJSMTZJd1JPT25QOGxHNVNkSmZsdC9O?=
 =?utf-8?B?Ui9PbWQ3ZjllZnhGQ1BBeHRKRURVeEZLdGFHUjh6RWxFRUNqcG5xQTd6WGh1?=
 =?utf-8?B?MENqTUFrSlk4QnBtaHhyb0pmL0MwL0RmOWc1a2U5V3JSdTdLNTVNRi81STBU?=
 =?utf-8?B?Qi9IUUhiK0lVSmVJY3BpNXZ2L0lFVHQvM1hZQkF2bWE5VjNVUnlnNnQ1MWNU?=
 =?utf-8?Q?cC306w?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:38.5743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0913c1e-360b-4d75-fc04-08dde3fd86ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890

The return values are not checked, so set return type to 'void'.

Also, move function declarations to internal.h, since these functions are
only used within the MCE subsystem.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-6-236dd74f645f@amd.com
    
    v4->v5:
    * Added tag from Nikolay.
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Include mce_threshold_remove_device().
    
    v1->v2:
    * New in v2.

 arch/x86/include/asm/mce.h         |  6 ------
 arch/x86/kernel/cpu/mce/amd.c      | 22 ++++++++++------------
 arch/x86/kernel/cpu/mce/internal.h |  4 ++++
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6c77c03139f7..752802bf966b 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -371,15 +371,9 @@ enum smca_bank_types {
 
 extern bool amd_mce_is_memory_error(struct mce *m);
 
-extern int mce_threshold_create_device(unsigned int cpu);
-extern int mce_threshold_remove_device(unsigned int cpu);
-
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
 #else
-
-static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
-static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
 static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 #endif
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9b980aecb6b3..f429451cafc8 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1296,12 +1296,12 @@ static void __threshold_remove_device(struct threshold_bank **bp)
 	kfree(bp);
 }
 
-int mce_threshold_remove_device(unsigned int cpu)
+void mce_threshold_remove_device(unsigned int cpu)
 {
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 
 	if (!bp)
-		return 0;
+		return;
 
 	/*
 	 * Clear the pointer before cleaning up, so that the interrupt won't
@@ -1310,7 +1310,7 @@ int mce_threshold_remove_device(unsigned int cpu)
 	this_cpu_write(threshold_banks, NULL);
 
 	__threshold_remove_device(bp);
-	return 0;
+	return;
 }
 
 /**
@@ -1324,36 +1324,34 @@ int mce_threshold_remove_device(unsigned int cpu)
  * thread running on @cpu.  The callback is invoked on all CPUs which are
  * online when the callback is installed or during a real hotplug event.
  */
-int mce_threshold_create_device(unsigned int cpu)
+void mce_threshold_create_device(unsigned int cpu)
 {
 	unsigned int numbanks, bank;
 	struct threshold_bank **bp;
-	int err;
 
 	if (!mce_flags.amd_threshold)
-		return 0;
+		return;
 
 	bp = this_cpu_read(threshold_banks);
 	if (bp)
-		return 0;
+		return;
 
 	numbanks = this_cpu_read(mce_num_banks);
 	bp = kcalloc(numbanks, sizeof(*bp), GFP_KERNEL);
 	if (!bp)
-		return -ENOMEM;
+		return;
 
 	for (bank = 0; bank < numbanks; ++bank) {
 		if (!(this_cpu_read(bank_map) & BIT_ULL(bank)))
 			continue;
-		err = threshold_create_bank(bp, cpu, bank);
-		if (err) {
+		if (threshold_create_bank(bp, cpu, bank)) {
 			__threshold_remove_device(bp);
-			return err;
+			return;
 		}
 	}
 	this_cpu_write(threshold_banks, bp);
 
 	if (thresholding_irq_en)
 		mce_threshold_vector = amd_threshold_interrupt;
-	return 0;
+	return;
 }
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b5ba598e54cb..64ac25b95360 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -265,6 +265,8 @@ void mce_prep_record_common(struct mce *m);
 void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
+void mce_threshold_create_device(unsigned int cpu);
+void mce_threshold_remove_device(unsigned int cpu);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
 
@@ -293,6 +295,8 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 }
 
 #else
+static inline void mce_threshold_create_device(unsigned int cpu)	{ }
+static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void smca_extract_err_addr(struct mce *m) { }

-- 
2.51.0


