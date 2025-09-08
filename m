Return-Path: <linux-edac+bounces-4757-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7701DB493FF
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7681205538
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD6F313264;
	Mon,  8 Sep 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lcHn0Bae"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E430EF97;
	Mon,  8 Sep 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346081; cv=fail; b=o0aVd14tqGjNDD344OjGjIHys38GmWI7zSAcojd/+PX2hpaqm6w2jBPJ9P9+RgyFBWCAqrvuw15hWhSieM8kxDkNqrduNmfaRR3M0txLVj5I2ovpXKIFcwvpiUHTdby2kTyWMZUwwyE+3J8SycxC1SnjvwAEQRSdbKISx5IIutg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346081; c=relaxed/simple;
	bh=OhtLpOh+th/7qPTXB4Xr0/fi+yKzjtY/7PpczX2vJ7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N9k2xF936Ms+/L/rQf6RAHxiTq6p3/fKRBEukGLDdKGklqs5ngNHZZ1/VSHGjZoAO2i8lYu+bJV04RfD7FBifw0KRffLPrugXw3lMlccZ7O9tgbT6vwwiQ68Xaq1976OoMpsJ+eZ1ej3+mGDjAEyv0Ln1G8PlIpfO1vucuTp5N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lcHn0Bae; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ubcjb5pLQttx75lKeLg4FYUxhLgqLqxMuvdeMaC3mR170RCUEesm5G5n1iPcTlTLeu6vBFrg8YoXkYJ7B4TGBANYDx4lyqH4kvEWp5tRsC6ngBzAXkTK7ZbJY9ncqRSKiLhZjcu5SDg4+dqE7W4Te/vwDZPBCNgyV/tOKp2cyiIyeq9zuSAaYxlHoSRXwatrrd8Z7kr0AyzTCzrHkuIsyjkpwVfmXwLeU4kBqQO5K3fHKsgm6i7jIsoNZHBZUcW5ucBbUzbebjphOfKb8Ysre0YZ2nJkS6+ZO2JfokLdlZ8/PDGNDzlsaywJXx8CDBzFoNbIt90ABk+FOqdTFZhUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biu5AOT9I2EFTsYQ+KrQX7Ep7m4dpxWN5ViRkpS8oTA=;
 b=feMCxNIAObCLExhTCRSJ9XuonNQMYKFyuj+3Jb4sZK/BtRhZKScxS0SVNpQAEJ04PxzJlhtHvXOSv6OJn3/xAUUpQCFO1pANmdGE5un8rBFzCAqBbZT96RFOfMDk4XFRMv2aNl2q2TbFH+Jshb8JcaaYxX0cvblY8D+wS9ZRLUj2x7/9Zkdb9ylsyB+JblES7vcG9gudkkbK+beJ6bL7rJswVH/R8Y+jPpxns/fMqx7X4FoyknawHjU57B94O564sP33CQeakrbYVZkozlaL04p9Ek7GSZnyKcWBkkOC3r+FtQn7V3PUppKKmBDivbzC3xj0U0VyFADymQYyT7XAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biu5AOT9I2EFTsYQ+KrQX7Ep7m4dpxWN5ViRkpS8oTA=;
 b=lcHn0BaeDmvAgGNWSpD+Si0cY64YGbXeRU8zuQCjQPuI0vURMQdyYFhAwbCZrkH/HPUqyO8Vp6vNn5iSxSMHE6lZFaEvwLCcXYwMb5ZHD7Zv7gpqObyAZL8YZJeMfLic9u6A1sKFHaCbByProhIyKlWlW4ivSTbXuc/YLDxrPuM=
Received: from CH2PR14CA0012.namprd14.prod.outlook.com (2603:10b6:610:60::22)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Mon, 8 Sep 2025 15:41:16 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::77) by CH2PR14CA0012.outlook.office365.com
 (2603:10b6:610:60::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:41:16 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:41:03 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:44 +0000
Subject: [PATCH v6 15/15] x86/mce: Save and use APEI corrected threshold
 limit
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-15-eef5d6c74b9c@amd.com>
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
In-Reply-To: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, <linux-acpi@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 9edf5d05-8152-45ce-1a30-08ddeeee2618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEloZFN3ckRjZlZBaVI3eXo4MFQ4QzF6R1Jhb0VqM2hyb2cxb0x0c0t6L0hO?=
 =?utf-8?B?cHNLSnRzY1ZYREwrNXp3WEtyYzMvZWR5NEJNNUNQMVNEc3IxRDBMZTMrczNi?=
 =?utf-8?B?VE82eXM1QmNkT2dtamtFSEZoU29xcVVUUDJMaks5WHpOdkV3SGo4dThmb2dZ?=
 =?utf-8?B?TXdOMVBUQVhicS8xdVYzb3JFUWpKQzdUNU9xa1pNd2JlVmFXOGpwUjZWRkdJ?=
 =?utf-8?B?ajR1OXdjVmdUSm1KRUdpQkhuM3ZLRVVIcGMxQ2pVMVJwRzhSdkdhZ1BXYlNo?=
 =?utf-8?B?dVMrdXpsYjY3N3haNytiR3hSWm1jZ1QreDhES0QrU2Y4Q25OVWhqdVZ5NW11?=
 =?utf-8?B?MDdZT2lKbnhxb3d6RHFpMXR4SktUcmNLQk1WWjNxMkNGSm1EN2hjd2lPNEE2?=
 =?utf-8?B?NUFTY0lHMlRMMUE3MVpFRlVzbEpLMDhhY01OODN4K3VZRmlDY2dRUTUrOEI1?=
 =?utf-8?B?Vk1XUnk5akhMQnhmUlVPUFdBdC9mUWF1b25lTk4xSzZlNnhoZGNaVHN1ZnhR?=
 =?utf-8?B?QVVKL0EwekZrNFQvM2pLaVFmNm9Nd3UvV1htOHRjMnc4SEZwUWtnRXgxUjA2?=
 =?utf-8?B?MmhkbHVaT0FlRGR3Y1RYZkdTZlpkT1FmZlB6NVpmR1lmK2dGV0YyWHdmd3JD?=
 =?utf-8?B?UFptakNadlBSckRuTzdycmpnbVF3MENSb0lmdnh5c1NPdVo4MXZCb2FqWThu?=
 =?utf-8?B?WS9zT2VtTmVOZU9sc3NsV29BNG9ENzh4a2pTbURWdGNHWUpOQXZUa3ZML3J4?=
 =?utf-8?B?ZTVmdXpnNEFTc1AvTmJhbnJZdkhOcEg2ditKL3dQYUd5Q0JoMEpmUWEvNi8v?=
 =?utf-8?B?WlVBMW5hZ0dlYnJCZk5KR0Y0WGZRam5FenE3MFI0aFNMMlF4MzdQbXBPMklL?=
 =?utf-8?B?L0FQOFBld1Y3Nk43T2hBKzB6eE5pRXRSR2cxVm5CUlZFZDJDS0VoSnhjNHBu?=
 =?utf-8?B?WEdLeUtiSTF6NjNlSnZISy8xQngwT0c0RjhRSnNXVnZ4M3lxdWtTSEpNZlJh?=
 =?utf-8?B?Y1AwSk40VVpQWElZU2ZVaE1sOFZramorakJhYStsSmVidU5Ka29yZklGV29v?=
 =?utf-8?B?enRWdDVXM2k2TXJHL0d2SVdkc3AvbXlWS0M1aWtmYjFXREQzUFlEUFdDeUdr?=
 =?utf-8?B?SEZFVmlyWG5nQllJVG1XMjcxYnpKWlFObFBldUwzUXMvR3VTQVdzMXBiMUpk?=
 =?utf-8?B?VEtPMS9zTjhpMmpJbk9KOXlDNEZNdUtGa0hPWG10VjVyNDZCbXM1NVBvKyts?=
 =?utf-8?B?cE55UDhnNUg4RFZtMUE3d0dkRURta1BmdnE2b0QzU2FKUUlwMGNnUk1TN2xE?=
 =?utf-8?B?eldWTEJlUDMwYzNqMDFvSndCeERvZEFZYUdYcmtSNlJqaktyOTBDTm9UVU90?=
 =?utf-8?B?R04yQnpnTURsV0VXd08veTFyQU43MEhYYytqajJBSkU2cmJjVktnQ3JlSGJY?=
 =?utf-8?B?akxaeTdkM09uQStCZWlEWTMxOUIrWGhFRW9TRmRMRzA2akFHSmd5TmNIV2tV?=
 =?utf-8?B?b0pSN2E2SWhRMlppMlVoZGxBWmJiejZLK3VZOGlEaExFaU9VMDVEWjVaSFdQ?=
 =?utf-8?B?dnpJUm4xWG1XNWpRZS8wa2JTa3lyTXpCOW56L3dIVU0zSHNPSFFrVm9YS2Jo?=
 =?utf-8?B?WHFQN0IyM1huc2o4WkxLbXVER1B5UUZySzZMVVVvbVlpd1VSVkU5UGVQRkNs?=
 =?utf-8?B?NDFRSmdiSWN3Vng5OGhlbG5KUnBIQ25aNW1sbloyZ3JraEI1azBGWWtoRmZT?=
 =?utf-8?B?MjhRRjlvcVYzZzkwUy9WTHZjbUphQ3FVQ3hNeXZaODFIQUE4RkZ2Tzl4NXBN?=
 =?utf-8?B?ZVdyTjJrMUdyTE1tdm9rTGloZHNZZzhQVVdTZzBsSnhZVHQ4Qk4yaHFvRmJF?=
 =?utf-8?B?aWR4OG5EMmFScVVxU1NaMTM1akxHQVh5cHB3d2dvenIvZGRKamNTVHdBMlpX?=
 =?utf-8?B?V0NDZEFQdHJpTHJTQSsyVTFkMlBBUHlZVHdIaTVOeXNVY0VBLzY0QjNhRTk3?=
 =?utf-8?B?bHMyaDl6TG9NRG9xMVRZR0lkcmw3Q3BRdkFGNVBNcGNFUkxiU3dNVWd1TFdE?=
 =?utf-8?B?ZGZweUY4SEVtdGNranVYbEZOajd4d1A5RDFJdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:41:16.4681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edf5d05-8152-45ce-1a30-08ddeeee2618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184

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
    https://lore.kernel.org/r/20250825-wip-mca-updates-v5-20-865768a2eef8@amd.com
    
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
index b895559e80ad..9b746080351f 100644
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
 
@@ -1071,7 +1083,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	b->address		= address;
 	b->interrupt_enable	= 0;
 	b->interrupt_capable	= lvt_interrupt_supported(bank, high);
-	b->threshold_limit	= THRESHOLD_MAX;
+	b->threshold_limit	= get_thr_limit();
 
 	if (b->interrupt_capable) {
 		default_attrs[2] = &interrupt_enable.attr;
@@ -1082,6 +1094,8 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 
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


