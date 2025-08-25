Return-Path: <linux-edac+bounces-4677-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91146B348FC
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E02207D5C
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DF13176FA;
	Mon, 25 Aug 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2i60QwxY"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39431353D;
	Mon, 25 Aug 2025 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143242; cv=fail; b=DAaloPy/T/pBzpnbjz+QCaUyKeaFxIfYyAOaJ6qlLD1+4VavwB82CLMWceyzB2v2XHnGR2fLR2MO4SgQwRAs+Nhi6A1UB6vz2JEqfqNsD41aOPg/wMc3RAJd68t/TwnuvtcG4WZuvljdGfv4Pm4YxARi3U6xp7Hwv+cRvYb0XDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143242; c=relaxed/simple;
	bh=fkp4kygFwoJZPCJAiOlvCapVRkG6f44mRO7oRU48qhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iPN5QGkujeO0UeFr3bWb+MI4jgl7XZHis5h4kF77i5rZeSn/Won+ihTD3qJc9P3O6iHrF2lXW1qjsKEqGZXqZNyl7xaqVCoB5KJlG9d5tLnCtAn86o6fq0dNFatFxR3ibCafioAAVY47bihYNl87gS8dPfSaYwB4RqtEKIe3fJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2i60QwxY; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/ZHm6SWHEXhUt4v2SaH7+pnqyAMydtUhWJED4UcaEVCf7dEyNJoAM7KlB17NTR5LYRH6M23pi1ttWnQSHoA2Z6DcHURwscvEVBrzg6M20Af27yLOY7LA3MquD6UDJ5nxXtPx1eFxAG/eyh6muneTbHxSwHV+xLoYBzOBwWUubyXKcR5UsEDvXjZmMbG+pbXzirBR1EmSamUuCmwKspS4N+B6J4djRIU9B7qFC37Fo3KOZ4QjYeUg0e4xHUzFc9n1QSZX2AFXGTiK41iG4iM5oRsoXT95T9mV6c1qFou8wjDHe3WA3ECEIC1c18e45A1y9rZOjwIokygtwwkNyf0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dfVLlp9em18Tnudeeok4SZVgTZlv9Fn1mNh3ooz5Rs=;
 b=GEWIgKqTRzOnwf1sXbqBx/LLnDoFitEGa3JkbNg+u42ayimhA0SqKwypSf9Z/FSYs4zBbCOmWsHNXURT6OezPaOYWSk7nJqWTrAKcvji3hJoNS5LvBO+0IP651qmF9hmQGpQZAZ0vX/qt0cNU0iLRQ/ggniVVBxvXQoyGYlrp+biZ3bk8tdhyUvjMfZyX90Z94+/GIagfl4StiFOkNHq8EQizjNr9US3PQ97JVor0YCeoSkSmGoYrGPIX7IAZGclUQ1J/BpyV6Kbz39XkmM11Qj+JRUVpMsFY/E7I+1C3Um6d65MRhKO6/4Es2xvjE8AGBoVGtzLVcQbhQqshTHnkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dfVLlp9em18Tnudeeok4SZVgTZlv9Fn1mNh3ooz5Rs=;
 b=2i60QwxYfgtZ9tA47jAI/t/C+K7k59G/ittHF+0r7gYw7xe+8ro3wNOY7t19X3cWPm/euBmaEZndZJVWitja4kOOCOVsDEGB8g79/m8sFye1x6ucrkyMnaWJC3LuGiAf5mD18cswFpGycFQ7nZYSei2XW1+ZLOyik/+TeuDlxwM=
Received: from SN7PR04CA0058.namprd04.prod.outlook.com (2603:10b6:806:120::33)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 17:33:52 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::42) by SN7PR04CA0058.outlook.office365.com
 (2603:10b6:806:120::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 17:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:52 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:48 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:17 +0000
Subject: [PATCH v5 20/20] x86/mce: Save and use APEI corrected threshold
 limit
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-20-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 0334d5fd-d408-42f1-ade8-08dde3fd8f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUtqc0hIWVhoNWc4NHROT3hNbmFPeE5JenpIdHlMNHRvUnNBeWRHUVk0enRR?=
 =?utf-8?B?NTVEbXoycmFBL0pSYU9XWk1wVGNhMWhla20weFpaaVlkd29XbGxXRGxreVhS?=
 =?utf-8?B?RytLc2d0WkhyUVdoZE9JWWJJK2I0TVU0OXJyc3dPWmlnT2xPL0VoeFlyaTZE?=
 =?utf-8?B?RUw1NHpkMUFBK1N5ellXdmo4WjNQa2hvdFREcE5yN2Q0UEdTOFhmTHREOFFt?=
 =?utf-8?B?eU5YZmIvRmd0SHhVS0prQ3IyQzVXMFRScTh5bndibHRlVzF1VW8yVzJCNDF5?=
 =?utf-8?B?ZGVzR1pDR2hUNGZzRzhmcWZ4S1Z0Z2RWa1pRQkU2dDNxaGpRQktITXBOSVlM?=
 =?utf-8?B?NWRVMVFiU05nbkNPb1pVdUp3S0FWVytRUU40Y3ZldG9iZEhMNWR4TE5vM0hC?=
 =?utf-8?B?RDZtQklsUUNKSHQvRXovdkR1TjRISVQrRWFpRFRqVHo4bSsyNzZuSlVIWHZs?=
 =?utf-8?B?Z3FUM2VXUWN6aFpjMjU5Q25LZEtCK1FYUkxUVDdFeDdaR3lpVnNFalhRczBF?=
 =?utf-8?B?Q3JLL3UvaE9kS0ppRFZmYkY3Y3hwc2JDNzVoTFVoNkI2ang5Um1JWkkxRTk1?=
 =?utf-8?B?NVNuV0Exb3JHUGxUYmFsVDhYSkIyVnJZR3E0cm9VbXVSYXJCUEo3UnpQbkJi?=
 =?utf-8?B?NzBYVWtLT25BWmdpVDVrSjgvZmRiZ1lPZUE0bGtpcUJYdVRwNENOa3o2c01k?=
 =?utf-8?B?QVhFUVhCd2RoeDNNVnFBZ2E3MVhoOW1SNnhjaDhlU3hVbEJFN05neUllbU5L?=
 =?utf-8?B?WFRIQTdqankwbm9hSjRiMmYzVjlmRUxhVnNwdm1aZ24xWm9WMElRRzlQcSth?=
 =?utf-8?B?dnpqa1ZETVpaRmJzSHYwSWR5NWVNR1BzNktHdDFySUtiWThFNG1TK2RzNnUy?=
 =?utf-8?B?Rjl2VUdEUzVTU0R3cVRacGNVY2w5MjhmOTA3K2NXYjVLMG1PU1lJV2RkM08y?=
 =?utf-8?B?R3oyOEplVzFCZVFINUtNZURzUHhTNHVEY0t2dDNuZWU0Mm5Nc05lMEErUm5m?=
 =?utf-8?B?RjQxSU5KdkI3aEFZMzdCNnlXQ0Y4R2RoejBkNUwyL1dMT0QwTnpBa0ZrYnpq?=
 =?utf-8?B?MWsrbDlsa25PcXExc1VUcldsYWxJMXo2b0htVHl1SEw4QXlqY0xUcEQwT042?=
 =?utf-8?B?emhtSmlWNTFzaEdPSDdJaHFrdjFDY1hIU3l0YlBOWDhrdnBhM3NMZHIyNk9u?=
 =?utf-8?B?SHNyZ29qR3E4MW5nWDF4T0syZ1ZycnFBc1NLeWU1disycFRINXd0MjVhMmNv?=
 =?utf-8?B?U3FVVDlJU3liekZzQ0lyMVIvNE8vK3RVRi80dFFoNUlxRi9tUWFjODBpRWtp?=
 =?utf-8?B?cjNHdExZZU5Cb0xvTUlNVnVJT3VDamlOdHpJZFl3aHo0QTJmVmF4dW12ZVZn?=
 =?utf-8?B?NmlzRUNCL1czSmZHR3EzWHBHYVUwTlptTGFqRW9ZeWNMNnlWMytKTmIyT3hX?=
 =?utf-8?B?ZnI3RHlXYTVEbWUyaHEyVHVpQzYyZ1FSTU9LSnhSU1dnTkg0NWpuRmVrT2dP?=
 =?utf-8?B?Q1dDbStaWXJZK3luQTlkaFJyM0I1ZTkyQ0ptMjJjUFFSVlVlUzVyRzZYR0Q1?=
 =?utf-8?B?dEs0VGEvMWhYU3lQOHd1NlhTMGhUVnFsYmhOekV4YkgyMTFFSHNmRFZqanM4?=
 =?utf-8?B?enFZNlpZYVpiMkl5WnpNUEliY1JpbndPRVkxV3kxU3QyWkcrdm0xMEt2UzZo?=
 =?utf-8?B?WERIZmloM1hDYTRKQy9OOXQrQ1lBOXBaNzV1QVdQV1d6WXFkV3ZDWUU0VGZF?=
 =?utf-8?B?QnU2WmJNWEpuVHg3L3FIbjJaRkVjRTFIR3JCYnRjOU42cFNmU3pXNTNiMFFK?=
 =?utf-8?B?dmNHdzR0NlFneS9EMzVlR3lCQmdPaUlnQmZRYWNlRDJCdjc1Lyt1MGJDK1kv?=
 =?utf-8?B?ZDhPWHl4WnU2bEpxdzdXaEx0L0hFblROT0ZzNHUwaGU3YTBUR2I2a1k3azBi?=
 =?utf-8?B?bG4vZU03WGxtTm9tbkwvblFoaGxkSmdpTlFUZmdtYjBjTHBlcjZ0bjJtckxi?=
 =?utf-8?B?VUptUU14cHkyekZibG1KTUlTWEhvWXZqWjhoU1RjbGZaQ05BRFFLWUpGRU9q?=
 =?utf-8?B?bjhBeHM1RE1Vc21rL29oeDhKVWs1dWRJTCtCUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:52.5767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0334d5fd-d408-42f1-ade8-08dde3fd8f45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754

The MCA threshold limit generally is not something that needs to change
during runtime. It is common for a system administrator to decide on a
policy for their managed systems.

If MCA thresholding is OS-managed, then the threshold limit must be set
at every boot. However, many systems allow the user to set a value in
their BIOS. And this is reported through an APEI HEST entry even if
thresholding is not in FW-First mode.

Use this value, if available, to set the OS-managed threshold limit.
Users can still override it through sysfs if desired for testing or
debug.

APEI is parsed after MCE is initialized. So reset the thresholding
blocks later to pick up the threshold limit.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-22-236dd74f645f@amd.com
    
    v4->v5:
    * No change.
    
    v3->v4:
    * New in v4.

 arch/x86/include/asm/mce.h          |  6 ++++++
 arch/x86/kernel/acpi/apei.c         |  2 ++
 arch/x86/kernel/cpu/mce/amd.c       | 18 ++++++++++++++++--
 arch/x86/kernel/cpu/mce/internal.h  |  2 ++
 arch/x86/kernel/cpu/mce/threshold.c | 13 +++++++++++++
 5 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 7d6588195d56..1cfbfff0be3f 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -308,6 +308,12 @@ DECLARE_PER_CPU(struct mce, injectm);
 /* Disable CMCI/polling for MCA bank claimed by firmware */
 extern void mce_disable_bank(int bank);
 
+#ifdef CONFIG_X86_MCE_THRESHOLD
+void mce_save_apei_thr_limit(u32 thr_limit);
+#else
+static inline void mce_save_apei_thr_limit(u32 thr_limit) { }
+#endif /* CONFIG_X86_MCE_THRESHOLD */
+
 /*
  * Exception handler
  */
diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
index 0916f00a992e..e21419e686eb 100644
--- a/arch/x86/kernel/acpi/apei.c
+++ b/arch/x86/kernel/acpi/apei.c
@@ -19,6 +19,8 @@ int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data)
 	if (!cmc->enabled)
 		return 0;
 
+	mce_save_apei_thr_limit(cmc->notify.error_threshold_value);
+
 	/*
 	 * We expect HEST to provide a list of MC banks that report errors
 	 * in firmware first mode. Otherwise, return non-zero value to
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d7b226a68ed3..1c143009df01 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -487,6 +487,18 @@ static void threshold_restart_bank(unsigned int bank, bool intr_en)
 	}
 }
 
+/* Try to use the threshold limit reported through APEI. */
+static u16 get_thr_limit(void)
+{
+	u32 thr_limit = mce_get_apei_thr_limit();
+
+	/* Fallback to old default if APEI limit is not available. */
+	if (!thr_limit)
+		return THRESHOLD_MAX;
+
+	return min(thr_limit, THRESHOLD_MAX);
+}
+
 static void mce_threshold_block_init(struct threshold_block *b, int offset)
 {
 	struct thresh_restart tr = {
@@ -495,7 +507,7 @@ static void mce_threshold_block_init(struct threshold_block *b, int offset)
 		.lvt_off		= offset,
 	};
 
-	b->threshold_limit		= THRESHOLD_MAX;
+	b->threshold_limit		= get_thr_limit();
 	threshold_restart_block(&tr);
 };
 
@@ -1063,7 +1075,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	b->address		= address;
 	b->interrupt_enable	= 0;
 	b->interrupt_capable	= lvt_interrupt_supported(bank, high);
-	b->threshold_limit	= THRESHOLD_MAX;
+	b->threshold_limit	= get_thr_limit();
 
 	if (b->interrupt_capable) {
 		default_attrs[2] = &interrupt_enable.attr;
@@ -1074,6 +1086,8 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 
 	list_add(&b->miscj, &tb->miscj);
 
+	mce_threshold_block_init(b, (high & MASK_LVTOFF_HI) >> 20);
+
 	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(cpu, bank, b));
 	if (err)
 		goto out_free;
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 09ebcf82df93..df98930a32a5 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -67,6 +67,7 @@ void mce_track_storm(struct mce *mce);
 void mce_inherit_storm(unsigned int bank);
 bool mce_get_storm_mode(void);
 void mce_set_storm_mode(bool storm);
+u32  mce_get_apei_thr_limit(void);
 #else
 static inline void cmci_storm_begin(unsigned int bank) {}
 static inline void cmci_storm_end(unsigned int bank) {}
@@ -74,6 +75,7 @@ static inline void mce_track_storm(struct mce *mce) {}
 static inline void mce_inherit_storm(unsigned int bank) {}
 static inline bool mce_get_storm_mode(void) { return false; }
 static inline void mce_set_storm_mode(bool storm) {}
+static inline u32  mce_get_apei_thr_limit(void) { return 0; }
 #endif
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index 45144598ec74..d00d5bf9959d 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -13,6 +13,19 @@
 
 #include "internal.h"
 
+static u32 mce_apei_thr_limit;
+
+void mce_save_apei_thr_limit(u32 thr_limit)
+{
+	mce_apei_thr_limit = thr_limit;
+	pr_info("HEST: Corrected error threshold limit = %u\n", thr_limit);
+}
+
+u32 mce_get_apei_thr_limit(void)
+{
+	return mce_apei_thr_limit;
+}
+
 static void default_threshold_interrupt(void)
 {
 	pr_err("Unexpected threshold interrupt at vector %x\n",

-- 
2.51.0


