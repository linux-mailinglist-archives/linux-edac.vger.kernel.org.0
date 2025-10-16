Return-Path: <linux-edac+bounces-5072-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81549BE4A35
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 18:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD925E2A98
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CADC3570B5;
	Thu, 16 Oct 2025 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ycRUAkB5"
X-Original-To: linux-edac@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A75A3570A1;
	Thu, 16 Oct 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632696; cv=fail; b=hPrVfIWFvCkIoQaMcWWljrNTuU0q8uC1pm+gZZ0FPDg0yWUjRyITEeNZgsnwDlYas5YvRUGPGlS+2TZq7nFZF7Mho0CuAg/NbYrG7eM3ocPV84+PG7PAU1z63XjaJqzWGCtcmsE4I3dbGM23OE3hONyb6tEW1tj+m4hBJZSRQoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632696; c=relaxed/simple;
	bh=SoVE4yowg55cmVkEzip3CHbbj//sKTSawmYPq02Srlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=STUCzBYv0nSVIlz8+aSDAlM82Gvtp5ualloi7TaYDfPhTHg/eujDPfAUJ371J6dpxhTGatRcREjzNQ5BLvBj4BaDSAm9Dlu6AYxYhWL3YxkyUnzo3E0LMoOrmBlB4ZpZe3U5OXRJFwviR6dGu+NUaIuhgUHHYzK1JEB0OLLSkN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ycRUAkB5; arc=fail smtp.client-ip=52.101.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4mK3jOwFzRHSVpOnisiPuz7tkhWlB30/P6kwIqWBZrcn0Mc0mVOhHQXBWvo5CdvJEQANKYJIbZJR2DKxkEWd9nqpJx81RoTQSz4DoUs3PTNGrIDXRxQhgKuMgkFsq+1AkbuNbinV7d/dfGoTjUhe+1AwyTJl7Ve8iL3LlU6vZPHN4sVwb/+btFze5E6VKOk2mJDdjXVrsipO3E9ULEsjvz65U3dD+kWUKkbS5YKShUsOXcQ6GRMpvWa4JtiDIJNT1ctXoE/1jHwMfFD6fzRZiaAKf76bK6prgTHugA8WohyXHNxsC8n8NuTjSXHrhAWPKhCj5ebdd3b6Q2Q5cnyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFA4GWGiwqxAAslG5gXRD25P/3iZzSuEFIrhQewPRVc=;
 b=ZJTryON6E4kTsxPOecal1YzZbT0yENzjpQ96qmqgGKT7qPcbgZhFxWpDJztPgEmao546xX1yhcghDmXkV2Yi5K47JgmiFXQcBZJ4aJ/zIyuBw9SzCWHhfELu6pkHAwiG0JTO6DLC8tl5eXQdDUE5/5Z1jyOJyQ2k0EZiICZ2owcoxdTxqeddAPFlhkNssY9YcZhfeEKr6FWNzZlBkMyjR0g2hoy4In11S/QrCryntoPxRRvKQeIpzhZvX2nSzafhhoQrL6M1dQH/LSis5vReEowzMKKFzKZD9/1JgfEHusDRQPVODjcMHY0xrmUGfQhLPk24bieM9Imp5CzDLOLQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFA4GWGiwqxAAslG5gXRD25P/3iZzSuEFIrhQewPRVc=;
 b=ycRUAkB5lMh4emZNyfRyCGhaamjQsS9e5XR7RjbW+mRchAPGa6QdtgsFGN+2pQLnOHmSVdvD3/mdzO7OBD0NK+298/Y6yLf6l6q4RtVU1FvmlMhZr00M0DV9qk0xVNh5st7lP8i2MBnBdkgwPyUTgL3v2M8ZfLYwVOBZIwa0l2w=
Received: from BLAP220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::33)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 16:38:08 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::26) by BLAP220CA0028.outlook.office365.com
 (2603:10b6:208:32c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 16 Oct 2025 16:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 16:38:08 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 09:38:04 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 16 Oct 2025 16:37:53 +0000
Subject: [PATCH v7 8/8] x86/mce: Save and use APEI corrected threshold
 limit
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251016-wip-mca-updates-v7-8-5c139a4062cb@amd.com>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
In-Reply-To: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd60ba1-09c5-4279-2d01-08de0cd26379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTYvTlRINCs3TU9COWtpMGVuYUZ0TVhtTFpwVTZTeHZiWC9QSzdnQU1QT2pv?=
 =?utf-8?B?Q2hYbnR3WVVIdUVoMkozeFdJOWRob2dMUStYTmpTNmVobUVwKzVVeUsxM3J3?=
 =?utf-8?B?eGZpeWZnUVdOeXBCVkJkZmdjUzBJQXRTT3VvWUdab3BvZytrRDVQWTE1ci8x?=
 =?utf-8?B?cmtQWC9PQVFmSUVzV2JIWXF2QW4vZ2hRMEh6NndrY2g3RVQ0cWhGY3VWWU52?=
 =?utf-8?B?M0xkRUlIaDJpSys4ajRxZUloNWxZYnJ4c0ZUQ01sUm1RTlpvcURwZGg0MFEz?=
 =?utf-8?B?Vk9SMUo1WFdBVVdGOUxnb215cjFuaHJMWi9uaTlETWlYdTBYN1I5Q1JQR0xy?=
 =?utf-8?B?aHBMNzdVT0RsZnE4Nk9vcUJqZ1NJdWhjMWJQeVNjNlFmeUN1Zy9Cay9xaTVX?=
 =?utf-8?B?NGYwZWhkS28rOWgwYVFLODBlVHpCUU9DaFhlbWczcnVQSVZBclJTREluZDh1?=
 =?utf-8?B?cWFzWXFmVC9kYmVpZ05mcm00Qmx3b0NPOXR2L0tyN2hBQnU1dk51NUpUS1cy?=
 =?utf-8?B?STdsTkJrcWt4OUY5bGlTSmRqTXZhbjFxVndYVTh4K2dCVDlYcG5wdFNFaXQw?=
 =?utf-8?B?RTNVV01BTVhDYmd5aEdwSUxWQUJuL2VXUzhkaXhJZVZpZmtFTUNkTjNob0F5?=
 =?utf-8?B?bGdQSnh5ZXpQbk5BVStqTkpJbGVmU0p1dWVqLzZqazVoQlEvNXVQcFlNVTZz?=
 =?utf-8?B?SC9sRVFtaUNMR0hCMGU4UGxMRk00ZXZoREZoZ2EvT1JXQkFhWWN2UjAyYXB0?=
 =?utf-8?B?OFFhZkp5TGJqVHFnYktjSmdSRVJ6cWd3NTBLYjdteU1STU1Majk1bm9ycVRt?=
 =?utf-8?B?Wks1UjM3bGdOZk12aCtCR0g4aVNXTGxqQ01rU0J6eC9HWVh4S0JsVDRKaEo5?=
 =?utf-8?B?cjRiaUdFa3NoZW9LQ1FFNG9jdWtiVkhhTEJJWmhRcW1aYlVkTkxEVHZEbUky?=
 =?utf-8?B?RVZUVSs0Si9zRHpNY0lmLzR1eWI0VmROZ0hzTFBMK1NQWXVPNUhSM0JMR1pl?=
 =?utf-8?B?RzNqZGRnVG5qSW1scTZJZEg1WVZiT3p0QmtIaUlwQm5mbFU2K2ppbEs2YkxQ?=
 =?utf-8?B?WE1KUFlsSUJ0MVNZMytKZkZWWG42QkpZZHFNencxbjk2bExrNDYwVlZ0bUhw?=
 =?utf-8?B?RWF1LzR1NmdoNGhoeFBUeXlnWXRpL2Q4M3dWaFNNRG05Q054Y1hyLzhTY2U2?=
 =?utf-8?B?aDg5S1NOVE95SG5JNnhadGw2NzY5d0VJWkRxNy9nM00wYi9QWGZmMnBTcmc1?=
 =?utf-8?B?ekhPR08rSkFNQUNlc2E3aStTZUlMVkh0bUttNG1lUWl6azlvakNLbmRBcjBk?=
 =?utf-8?B?b3QxQWFHRGxRWDFhZVlhMHZpb1ptWC9iM2VXL3VWNU9aVDR6S3c3TkpNL2li?=
 =?utf-8?B?K0ZPYngvME9ySG1hc3ZsQnlsMlplNVBjS3ZYWDJ0S3c2WVlRUWM2UFArR3RX?=
 =?utf-8?B?RW1qUnZkL0I0Zi9JK2V5dStCZm5kRGFxQnVXU3l1V2lRUE5VcjR4Z01UbnRQ?=
 =?utf-8?B?eG55b1JPbUZyV1pZanZPeDdSNFhzbGMvME1tZzdTSmlNN2tBNmtrdEdPbFYz?=
 =?utf-8?B?K1Y4RWhiOGxyL1hkWGl4czdidFNYZjJIQUVVTnU5eW8wZTM4a0MxditLbEo2?=
 =?utf-8?B?MFpCTzJaL1lrekpSQ3pDVGIxb1E1L3Q0b1QxTjYzeXhhbHZxcTlXWnpJaUhX?=
 =?utf-8?B?V2NDVkJ5UVMwMVAzZDRrRzQ0MDNJRlZLb2NlWmRqWVdTQXNEY2pnK0ppWFlC?=
 =?utf-8?B?MXFES0Rvakg0ZG9jVmNleDEyZjBESXZJNkxWclJNZW1JVVhwc1RzNkNRQlll?=
 =?utf-8?B?MjRlaUlobExxRE5YWEJQd0lOZXZqZVZwWXVDQlA5cTJ3cTJpbFhHM3JZOS9B?=
 =?utf-8?B?d2d1T1JzMHZ0cEtSbDVzdVBxRmZyZThiOTQrNk9PcjBBL2EwWDgwMWRFZldY?=
 =?utf-8?B?RjhqU2RxNjJFaDhzckNlMGg3VDJ4dXB1L0JXdVorOGhBZnc0L1k4cDBVMnZ0?=
 =?utf-8?B?SGhLUWRaUXJjV1lrNitSQnVZVi95NlRRM2NKYStvV1poSVdTTFBWMTRjNTJa?=
 =?utf-8?B?SGFkdjB0dGJaYzNKL0dNVEJHaFpsVVAxd3VMN0FZUVlyTUhKQWwrck9Bb0Vp?=
 =?utf-8?Q?3BdQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:38:08.4282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd60ba1-09c5-4279-2d01-08de0cd26379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804

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
    https://lore.kernel.org/r/20250908-wip-mca-updates-v6-15-eef5d6c74b9c@amd.com
    
    v6->v7:
    * No change.
    
    v5->v6:
    * No change.
    
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
index 1482648c8508..9652fc11860d 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -309,6 +309,12 @@ DECLARE_PER_CPU(struct mce, injectm);
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
index 7020c5ad4c74..83fad4503b1c 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -489,6 +489,18 @@ static void threshold_restart_bank(unsigned int bank, bool intr_en)
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
@@ -497,7 +509,7 @@ static void mce_threshold_block_init(struct threshold_block *b, int offset)
 		.lvt_off		= offset,
 	};
 
-	b->threshold_limit		= THRESHOLD_MAX;
+	b->threshold_limit		= get_thr_limit();
 	threshold_restart_block(&tr);
 };
 
@@ -1076,7 +1088,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	b->address		= address;
 	b->interrupt_enable	= 0;
 	b->interrupt_capable	= lvt_interrupt_supported(bank, high);
-	b->threshold_limit	= THRESHOLD_MAX;
+	b->threshold_limit	= get_thr_limit();
 
 	if (b->interrupt_capable) {
 		default_attrs[2] = &interrupt_enable.attr;
@@ -1087,6 +1099,8 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 
 	list_add(&b->miscj, &tb->miscj);
 
+	mce_threshold_block_init(b, (high & MASK_LVTOFF_HI) >> 20);
+
 	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(cpu, bank, b));
 	if (err)
 		goto out_free;
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 9920ee5fb34c..a31cf984619c 100644
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
index 22930a8fcf9e..ae27911de26d 100644
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


