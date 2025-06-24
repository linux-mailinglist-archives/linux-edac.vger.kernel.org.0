Return-Path: <linux-edac+bounces-4231-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C28AE687D
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA79F16AEDA
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3315B2E1746;
	Tue, 24 Jun 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vJm+BUKT"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F52DFA3D;
	Tue, 24 Jun 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774606; cv=fail; b=eIGcNGn6ul7hxNL0N1qDQp4v/+X2odndUjhlWcZSda0O7dXhuT9XQtliSBGe6vnJ7ZPISID0rd3sj5bFQ2jGLAknWKuCOk4G9pXwTsbJWpX6i3vdJFx+esPwpMcDpfrSXaPfbw9B/vnXMXVOPeXXch+ZUTYuvEkM/zQkFjEnW4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774606; c=relaxed/simple;
	bh=sUT/SjsPtvGHgVfA01QDt7x5Xx41sstDvXmSa0P3Pfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YwXZmjqGhGaHoi9WWIWKn+/1Cp2sDSmnuN0MB7+H805n/k3eTmkEMzOC0jCTvhClMFM2uBI+pfbfMiWUP7+opzYY/hgThNBMMX6MKmPb+urfWFx7XRpC73WmYsI9PqTrg3K1Ya0x5nUAYC4xDY7jx7YOuK3blZuTYZqzEUIAUdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vJm+BUKT; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjWDnJZggbxkkgbWQQVf8aeeRoMSGUDh2YjAuHOmBmA/zXMczyt+8z4n0equ0+PNpxgT8aGnTYILN4JnmJlI4VSR3n6SSsjceZl78jH6uEKVxId2oqqAUyhaO1ZxHbxBbrFr44mRQ+NNYsbTMP30eHFSaNW14VebKv15O5F5d480oI+AIMX+QrrbI91MAPaswBvIBNPEpdeSgatvLBZTctNyeChhnnCh6S3lXkPDQeOFUteK14TYbSHcHle2OM9ZyLF0Y4O6pQVgOmkYmeYeVghyxasijeOYh47M2y/DgJIyNUMh6Ca9pfHveYvUBk+DNO+D2qb96GUfcxqnXARlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+aWmYAWpKWLiVvOUM9floD9d3qm75gHRQtlWdIIveM=;
 b=bt5qHdA3OtNTkiwvhrwZ7w1ueJcMMngDNvT/0NMY+Mp+z/IKLnICML9daPqbK4VEkql641kh8+R+2bcO2213RQF4gz+ZN6tWtA2OLgqvI3WcqMyj+Yg2/q449JPDNWEOqtRaYOcu31JhmQpEr71xlce0pwc3/jmyzNaTIKobRCuA5qU2rTRG+EAmlPed5kZOO8vyvJxhvZlo/NyreTTPow7820oCL6/CDbfOSI+6AIXybyNyKM1RPOZoICcdVC5jExpSg5ak+jjpz0nVuvG80z8ZBAI8qdmMzy7DNzznA+/TrXxjyIanhvX89nC+ubeNmMfUuGlYghS5IxxSXUYCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+aWmYAWpKWLiVvOUM9floD9d3qm75gHRQtlWdIIveM=;
 b=vJm+BUKT2SaNzo4MSpCUisPY3z1WhJU9UEpsexvX+prPWSjEnVPTQZGA3NptwOfQLeN4Th9xsNkusm0OM5GDAeGw2XN/hRfP4gSudngtS8igEocGa8FUcqh1g3PKQ0Uzgv2Huly43cAh98e6HaV4rU68MhgJjikng2S8s4DLR9M=
Received: from BYAPR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:74::17)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Tue, 24 Jun
 2025 14:16:40 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::1b) by BYAPR05CA0040.outlook.office365.com
 (2603:10b6:a03:74::17) with Microsoft SMTP Server (version=TLS1_3,
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
 2025 09:16:38 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:15 +0000
Subject: [PATCH v4 20/22] x86/mce/amd: Define threshold restart function
 for banks
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-20-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f1d0ce-d0b7-407d-ff25-08ddb329bccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWxpUHJhTFNiNnAzcUlWMjV3cndBTmVBM29ndndXQTVmaGJEMnZvbGdtMDky?=
 =?utf-8?B?NndZQlZiNGN2ek5jOWRuSmplcS8xVHBMS2xINmxVSjFnY2NRUTZRdFBNaFZN?=
 =?utf-8?B?YkhoWFk4bFdKY3RKU203QlFvUWxqR2ZkYm9FZW1TS1lKVlhyZ2pXNlE5YUhO?=
 =?utf-8?B?YUFIY3I5dkcxVW4zYk82TGE2eGlIYlhvY2UybFlqZ3NhOFE5QWZkdGV2WE9J?=
 =?utf-8?B?bzdNd1h6VlR6b0VmVGdxdEdBMlRNd3AxMjl3Q1VCZHNhSVBicFVUcEovVDNO?=
 =?utf-8?B?OFVvd1hkQjJlMnFNbXRwMjVXY2xiV1Zpc0RISklManBBZDY5Z1lobmRnekJi?=
 =?utf-8?B?VWNMbXJ3b0JNRXVJeEU2WXp5Qjk3YXBsU3U4SHd1ZEpZUzJ3emU4V1luNDJG?=
 =?utf-8?B?czdNa0VJazlCQ2kvbGdPZllGUzhmdHBnaFAzUE44ZTd2MTZHQ3U1NDUyd2xR?=
 =?utf-8?B?UEZRYm1wdGdFRVB3Mk1ScnYzZERCS25vK3ZhdzBubTF1L3ZDOTEydGkyakJm?=
 =?utf-8?B?bmlyQWtFU2Q4Y1Z2cnJWRGF5eEN1clUvbkJLcTFaS2N3cURqZXEvYnJTdGV3?=
 =?utf-8?B?ZWhUTVgzZ2tBMFluRU1Ga0syc0EyOHNxN21yOTk1UUMwUjhsdmlwb2JyV0x5?=
 =?utf-8?B?RzFIQUF1NFpQeEFWOXB6dmtKTEpPNUxVQmZJd0JVNFFLcFpNVVJKNGkwN3N5?=
 =?utf-8?B?UXJzMFFQQklGZUxVbWJOOHBzejZoYUhPbUhVWDV2NnZ5MndJdGV1ZHhpVG12?=
 =?utf-8?B?V1RHOFNxbDJiVUtoVFZ2ZzRkS0tMSnNyYmdORXVuK1B4OHdPZEhGWUc2MEhD?=
 =?utf-8?B?QXRmUVRhejQrYXhBdnVmSm5IcSt6bHZCaG81Tk5uNmVlTk5pM1JKNkFZRS9w?=
 =?utf-8?B?clBXaW5UNklHeVVyKzlLM0ZCVWFEa2UrYld0N05QVDg4U0dvUWJSdlNBc3BL?=
 =?utf-8?B?Y0wrdlR0TEVjMlJ2a0s4ampxb3JDcnpYQkNHVldQdXEva3dXeE9DOExwbWpz?=
 =?utf-8?B?Q0dzRXBuMTJjWitzZEJ3S283bStWaWplaS9GOGJvbjV0TENpakdZL2ZMK1JL?=
 =?utf-8?B?SlNmK1hQOUZZSFNwcmdCR0x6N1MwTGdzaElUdnJZVTJvQVZPSU9HMTlnSjlE?=
 =?utf-8?B?eHR0dTJoKzQ5V0VPaUxmeG9YZmY3RHBFMHNWTjJMb0pxamVyNVJOQ2dEdEw3?=
 =?utf-8?B?K2pmVDRUVVZOV1lmRkF3OHNiRVMwdHM5VFNtTWFVZE5wRm03bW41TUlkZ0Zj?=
 =?utf-8?B?djgwdHdlVG5DekIxMURrcEUxMEYzRG5uOWt1MGpKWUN2czM1SE1xRjBJbDAw?=
 =?utf-8?B?TFVlSFZCOWJYUzNCU1dUcGZ5b01XMVdwT3FlTHJQeks0RlFzYUJBNk53SkFr?=
 =?utf-8?B?RHljaklpbzVoRmpRRUVNL1VGTVk5cjJkanN6dWRhTTZCQVJlcUc5bGdyU3J4?=
 =?utf-8?B?d2o5K0lBTTluRFpxZC9hSUFIWTJ0RzYxd0N4eUV0VkVzRThkZWpPdXJpaVBK?=
 =?utf-8?B?Wk1NSlM4LyttYXJRVy9aTmpzQmpnMXRzTlR6MnMrY2l1VWh4MEdVcUtpUnNp?=
 =?utf-8?B?bHFqcXcyTXlLWGl1OGhndXhRQlBveFQvNyt3MDYrQlcyM2E2aVh0NXpqK25v?=
 =?utf-8?B?RG5VZ0hCTkhtUUE1SGdjcGZvWFBvNWZRaFJqZ1BmbVJuempvUlczMVZVdGs3?=
 =?utf-8?B?c0FSYmJ2MnNNT1VFUExyeFY4MDB6bjdhZE1idUk3QVU3LzRObnJjYVdNQ1VD?=
 =?utf-8?B?MGNKQkt4NUc0QnVaQTh2VXNnaHpqNXdHUDNxSXhaa0dzZmpUV1RodHNUc0dK?=
 =?utf-8?B?cEFpZ1RmRERlbkJVaVdQMjNhQmhKaTN2Q05ZNUhQWDFqcTVTNDJ3Tnpzbmo0?=
 =?utf-8?B?eFVFZXhoaFlXV0M3VUNGS3FWeDJDTXNROUVLbmhpL0hZTHpIZGRncnlWT1gx?=
 =?utf-8?B?dVBiSlBpL0Q3cEVkVDZVbStOcDI2M2R5RGtLbnVDQmJhaEdxVjIvZUZoQ0tM?=
 =?utf-8?B?UldLS3NlQWJodTFmclFGZVgxYnUrRVpNMVVrQjlNUjNFcS85ZWlmL2x0YmVk?=
 =?utf-8?Q?byhQNo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:39.7850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f1d0ce-d0b7-407d-ff25-08ddb329bccd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960

Prepare for CMCI storm support by moving the common bank/block
iterator code to a helper function.

Include a parameter to switch the interrupt enable. This will be used by
the CMCI storm handling function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    v3->v4:
    * New in v4.

 arch/x86/kernel/cpu/mce/amd.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 3cb9f6a68316..56e7d99cef86 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -470,6 +470,24 @@ static void threshold_restart_block(void *_tr)
 	wrmsr(tr->b->address, lo, hi);
 }
 
+static void threshold_restart_bank(unsigned int bank, bool intr_en)
+{
+	struct threshold_bank **thr_banks = this_cpu_read(threshold_banks);
+	struct threshold_block *block, *tmp;
+	struct thresh_restart tr;
+
+	if (!thr_banks || !thr_banks[bank])
+		return;
+
+	memset(&tr, 0, sizeof(tr));
+
+	list_for_each_entry_safe(block, tmp, &thr_banks[bank]->miscj, miscj) {
+		tr.b = block;
+		tr.b->interrupt_enable = intr_en;
+		threshold_restart_block(&tr);
+	}
+}
+
 static void mce_threshold_block_init(struct threshold_block *b, int offset)
 {
 	struct thresh_restart tr = {
@@ -832,24 +850,7 @@ static void amd_deferred_error_interrupt(void)
 
 void amd_reset_thr_limit(unsigned int bank)
 {
-	struct threshold_bank **bp = this_cpu_read(threshold_banks);
-	struct threshold_block *block, *tmp;
-	struct thresh_restart tr;
-
-	/*
-	 * Validate that the threshold bank has been initialized already. The
-	 * handler is installed at boot time, but on a hotplug event the
-	 * interrupt might fire before the data has been initialized.
-	 */
-	if (!bp || !bp[bank])
-		return;
-
-	memset(&tr, 0, sizeof(tr));
-
-	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj) {
-		tr.b = block;
-		threshold_restart_block(&tr);
-	}
+	threshold_restart_bank(bank, true);
 }
 
 /*

-- 
2.49.0


