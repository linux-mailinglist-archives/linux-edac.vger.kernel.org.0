Return-Path: <linux-edac+bounces-4992-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C0BBBE73E
	for <lists+linux-edac@lfdr.de>; Mon, 06 Oct 2025 17:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2CD73498C7
	for <lists+linux-edac@lfdr.de>; Mon,  6 Oct 2025 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9622D2D77FF;
	Mon,  6 Oct 2025 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eVl4AeXY"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862D2D5416;
	Mon,  6 Oct 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763469; cv=fail; b=K7uRSr/oel9MLsV2o/GDDk7MP4JaCTiJC9ZKBGxt/m7nn1cejd+kuYRtQjEVKf3hO7iXJCpHueciTsrqmhYuGB88ns93SeiHs8NckzTDxRbqwq2ZKtgGR6BRS07MQ0gtv6gfaITIxu22h/+tqnjim684595WpOwxNT61uPYVTtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763469; c=relaxed/simple;
	bh=hHRqo19+AR8SNRlO+x0weSkUK2MUwZiV9yHYR+RQXw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hPw9SG3orzpho3m7FVHRL8DqEe08DNhejXYQ4yh6sQ6lZnGAcmETBMqkiEss3YzKcF8+XQPLdwS45Zzwz1Nyod2CsvXmG8h3NBBRA/h7Q7rOM5ndgaK/0TWozCsKaCCc63rx3T2e7TUEemHilyQlCtFGDc+CkVBbKCbEY76j6sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eVl4AeXY; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3qXOBB2xVvh3dlU/kT0Oczyj+7XHojXUyE+7DN0NcpPdsDtFu6D1cDwpJ9kU4p9uyGbudM0yjW5yaHEGVYqK/1F2chptCnTIbXPyG6nyPDGp8pRx5WKicx36ptbUq9ZnaH79rLwe5JPotGNhz5jtxnFeWGy/URjx0wzOSL7qBIirdXLc/pwNEAy5y5TWQBpMzGFatmcZeXguI4gB/wEZsQhk+ieT3FJ5yBlLhQNqji5kc/CQsYbi7Hx6C6740744sk/+uQBcXcHNecrZRPhr3Q4T4FH9as3QZ1CpQ/aBQW8AAoj71tDDOshR6RN74KKkRYv56R2bWsKqm/LNN4PkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWhBzU+5z3pS2Lje10x3uN6AcQt9pW/kf8g1LyXpF3g=;
 b=kY3jydF77urosHx0Y6f/J2ahElo5hlD9pPzsVbmGuJbn+w6V0l//60yDUrbGKzw1Mlsa32matW3XCMrVzONIKsX1fNWwdzZTjOitmXgzt3EJ++evgv+5RolKjJu0ZVRqjAwXHr4B4MNwFckTynEJRdRpqkO6eFB1+TBYheWJG8qKMrmDndfSOftmypVTgLmgxapdCkQt+9swD9+1XJeD7YwRtQs4xYKK0WACZWLH/z4JEqVDHF1fTrnXxX94phIFEmIe1J2idA/nQzfiZjNWBZ1MNGlA408IZWZNIGJaMAazkbIfAy/vF6UcQgKQobqJGrB6ItonQ27wyaGjQeuIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWhBzU+5z3pS2Lje10x3uN6AcQt9pW/kf8g1LyXpF3g=;
 b=eVl4AeXYjGBHy2sDwSwR+MsNuyk7tRb1u0v1iCB2Yg+XX768EkRChh/sX8wMS+7iIfv6CEEryDmGux/VL5IjA3uQyAa09qUEWqZw83Yy6ysJ68aU4/Pvq1fICO9lublvWY7bdFFHbbkV3zScWllQzcemylNP20jGrswOcjirS2A=
Received: from CH0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:610:e4::18)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 15:10:50 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::d7) by CH0PR03CA0193.outlook.office365.com
 (2603:10b6:610:e4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 15:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 15:10:50 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 08:10:49 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 6 Oct 2025 15:10:26 +0000
Subject: [PATCH 2/3] RAS/AMD/ATL: Require PRM support for future systems
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251006-wip-atl-prm-v1-2-4a62967fb2b0@amd.com>
References: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
In-Reply-To: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Avadhut Naik <avadhut.naik@amd.com>, John Allen
	<john.allen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 8316c2eb-6244-4bc0-4ea8-08de04ea896a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlNrekp0amlQRUJXRUh6WDkvTm9xMFE4a1ppRnZPakZmdmJ1OU1yY1pMY3BO?=
 =?utf-8?B?TzVJc2dhRStKb0R4eUd5MytzN0xEV0tndFVqLzVLOWdhTlJyVXpFNzZnWERh?=
 =?utf-8?B?Mnc2UDBna2Vhamt1Vlp5cG93U01wSnZwVzJBZ2dySTNDZUFwLzR1UDBsY2dm?=
 =?utf-8?B?dlFWcnZrMGNjb1dhVVZ1Y1hXUXo4dXBSTE1lZGFCVG42c2d4OVZ4MTVBaGl2?=
 =?utf-8?B?enVyNzFXWVBNN203OUJldkRJdjExN2ZnZ0NjV1pNTy9EZllybnc5VUpzMFNR?=
 =?utf-8?B?b3BxanFtbTVlQko4anlGUmJTRUZ4cW1IUTVHM0tlZTBPY0dOa1VLUjcyYUZt?=
 =?utf-8?B?QXcxcEJWeXlYaUU1TTM5RGNpVFBxM3FjVE9BZzZhejVyVG9mcDRiSFZRN01n?=
 =?utf-8?B?b3FJR0k0dXgwYTNrOEwzSWxhcDUvMks4UW5wWkRnVnpBMWhhZDZsWEljZEJv?=
 =?utf-8?B?UGFCVUlBUkJ5RlZZTmlyRy9KRVpJRDBPSklobEFESkNWc3BBOHNleXlMKzEr?=
 =?utf-8?B?djh5L3RlQVZwdmlpRWgvc0EyRzBZOFl0cnhIYWJCRjJETmxUcCt6bUNRMFFz?=
 =?utf-8?B?NSsxbFVNUU9pWjA5RXJwUXB3S0s4bmw2R0I3cTUvNkpia05tenp4bDN0aFN5?=
 =?utf-8?B?NFlPQ2x6K2ZOWW51a1BpR0FqdGtWZjhtd2pVckxlUUcraFZ4ZVFxbmtTdHJW?=
 =?utf-8?B?b0g2QzNWd2E3US9zZ3R5Y3A4OTBSSzBPRUNCdHFRQjA2SDVPaVlOaGd4S0xP?=
 =?utf-8?B?TjhRaVY3clVldmtwalBqY0gweXpyVkJEd2lKNkNEaHFIazRBMThFNk5vblJy?=
 =?utf-8?B?Vk13VnZ0K1UydU1Qb2pOaDRxMmxlQnU1aWdBL0s2T0ExYStXVFNrSlc0VU5x?=
 =?utf-8?B?UTFHdjJnUXc4NnRkcFd1ekdCdXpEcGFSS2VzQUNmaFlkbURFR1o5ZkJVRzVU?=
 =?utf-8?B?VDNjVHFXY0Z4VlYxQzlPWXpwdFBuRmhoZk9rSU9IMjdnRFBhNmZXYUh4WnFp?=
 =?utf-8?B?ZG44MVl5L1ZrT2NCZWJ6KzNwd2pBTTY4S1lJeHk0dTZJQThnck1zckxjRUZu?=
 =?utf-8?B?WHJBcCt5Rkg2eDhPbTh6UjE4UHRwYXF2WG94d0ovTzROOFdad2Z2bkpqTGhC?=
 =?utf-8?B?bzVvL3JUSEJBblhxaG1CaU4xRnh2NU9GRVFQeFVxbjdtSzIrS2RWN2hMdCtq?=
 =?utf-8?B?b0RxRmxxTlAvWGhTM2hOUGpoZ0ZSOXZiOU1VeVJTSWlvdHBGOWgyQlY3K3l4?=
 =?utf-8?B?MkJaMWp5aUFJSlB1UURNSjBJdTZyVGFBdUJ3cHpra2ZFLzNqWFFQL3plVCtx?=
 =?utf-8?B?bnRqK200bGwvaUVXTXdMTnlPVTJkcDArb2dwclEwMVFxWjNtVlpRTVcwQWl4?=
 =?utf-8?B?V0ovekZ3cXI2SHNrZmkvemhzcWVIMmZoSTFMOHN4dWJHckJ5R0hqazBOTk0v?=
 =?utf-8?B?MTFqMEZkYnI5L3JRd25NVUlyWGFidkp3Z2p4K2s5WnQ4SlJGMTlFZlpuaFp1?=
 =?utf-8?B?YTVBMFpXOXcwYWkxdjJWSWYwMGZCQTkvcSs1NkE4MkVjS2hNZXNSaWYwME0y?=
 =?utf-8?B?cUNkaWc3NFV3SllucVF5TTgzRjAvS2NGVnhHMHBzcjNjcVZaRFh3NUExWFpz?=
 =?utf-8?B?RkxBOENkRHY3SDZDWWlmNFJZU0hqb0FSRjNvWUNuQVRrZ3NJREIySTJUTWwr?=
 =?utf-8?B?KzJrbFJkV2FPV0xRaDlEaDczR3RKVHY1cTRVMC90clpQbFdwQThEbmhPZDN2?=
 =?utf-8?B?QTBWNVhHWFJSdGpsdUl5NWR0ZFF3NEZ5dGNCRXBGWEZRSVVkUmlrUzh6b0NP?=
 =?utf-8?B?amV5UWd0R2NDTldlZUF5aC9kdXN1VksyRTVVRWVwR3hxNllVR1M2cEt6bEJh?=
 =?utf-8?B?ZTVQL0NwMGVLODFBSURlV0xFV2c1U2Nyb2F1VG1yeUhCYXJmMXVwdFFYQ05Q?=
 =?utf-8?B?cjBmWlc3K3NaZHM0aVlCTUFocXZONThMOWlzSTRQU1JHdHgyQm5XVVplR2No?=
 =?utf-8?B?anBtQTh5dE83aHJ4SXVyenpPekNrSE5uTXlCMjhvei95ZU10UjZQSjFXbEQ2?=
 =?utf-8?B?TGZpMGl5eVM1Z2YycXFlT2dHZDVJaFZSUE5EQzQrUmZrOCtjVGhnd1lJUzQy?=
 =?utf-8?Q?pQbg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 15:10:50.6942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8316c2eb-6244-4bc0-4ea8-08de04ea896a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181

Currently, the AMD Address Translation Library will fail to load for
new, unrecognized systems (based on Data Fabric revision). The intention
is to prevent the code from executing on new systems and returning
incorrect results.

Recent AMD systems may provide UEFI PRM handlers for address
translation. This is code provided by the platform through BIOS tables.
These are the preferred method for translation, and the Linux native
code can be used as a fallback.

Future AMD systems are expected to provide PRM handlers by default. And
Linux native code will not be used.

Adjust the ATL init code so that new, unrecognized systems will default
to using PRM handlers only.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/amd/atl/internal.h | 10 +++++++++-
 drivers/ras/amd/atl/prm.c      | 10 ++++++++++
 drivers/ras/amd/atl/system.c   | 12 ++++++------
 drivers/ras/amd/atl/umc.c      |  2 +-
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 2b6279d32774..8f0864641a1e 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -138,7 +138,8 @@ struct df_flags {
 	__u8	legacy_ficaa		: 1,
 		socket_id_shift_quirk	: 1,
 		heterogeneous		: 1,
-		__reserved_0		: 5;
+		prm_only		: 1,
+		__reserved_0		: 4;
 };
 
 struct df_config {
@@ -284,8 +285,15 @@ u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
 u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
 
 #ifdef CONFIG_AMD_ATL_PRM
+int prm_check(void);
 unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr);
 #else
+static inline int prm_check(void)
+{
+	pr_debug("CONFIG_AMD_ATL_PRM not enabled\n");
+	return -EINVAL;
+}
+
 static inline unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id,
 						     unsigned long addr)
 {
diff --git a/drivers/ras/amd/atl/prm.c b/drivers/ras/amd/atl/prm.c
index 0931a20d213b..2347c8edd4d7 100644
--- a/drivers/ras/amd/atl/prm.c
+++ b/drivers/ras/amd/atl/prm.c
@@ -33,6 +33,16 @@ static const guid_t norm_to_sys_guid = GUID_INIT(0xE7180659, 0xA65D, 0x451D,
 						 0x92, 0xCD, 0x2B, 0x56, 0xF1,
 						 0x2B, 0xEB, 0xA6);
 
+int prm_check(void)
+{
+	if (!acpi_prm_handler_available(&norm_to_sys_guid)) {
+		pr_debug("PRM not available\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 bank_id, unsigned long addr)
 {
 	struct norm_to_sys_param_buf p_buf;
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index e18d916d5e8b..09664b0ff8a6 100644
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -212,15 +212,12 @@ static int determine_df_rev(void)
 	if (!rev)
 		return determine_df_rev_legacy();
 
-	/*
-	 * Fail out for major revisions other than '4'.
-	 *
-	 * Explicit support should be added for newer systems to avoid issues.
-	 */
 	if (rev == 4)
 		return df4_determine_df_rev(reg);
 
-	return -EINVAL;
+	/* All other systems should have PRM handlers. */
+	df_cfg.flags.prm_only = true;
+	return 0;
 }
 
 static int get_dram_hole_base(void)
@@ -294,6 +291,9 @@ int get_df_system_info(void)
 		return -EINVAL;
 	}
 
+	if (df_cfg.flags.prm_only)
+		return prm_check();
+
 	apply_node_id_shift();
 
 	get_num_maps();
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 6e072b7667e9..18ce419236a5 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -422,7 +422,7 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
 		 socket_id, die_id, coh_st_inst_id, addr);
 
 	ret_addr = prm_umc_norm_to_sys_addr(socket_id, err->ipid, addr);
-	if (!IS_ERR_VALUE(ret_addr))
+	if (!IS_ERR_VALUE(ret_addr) || df_cfg.flags.prm_only)
 		return ret_addr;
 
 	return norm_to_sys_addr(socket_id, die_id, coh_st_inst_id, addr);

-- 
2.51.0


