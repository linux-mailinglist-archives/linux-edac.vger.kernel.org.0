Return-Path: <linux-edac+bounces-4744-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F18B493EA
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EFFC7B79F1
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7B430E0F7;
	Mon,  8 Sep 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FXf0hsGg"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD71223DD9;
	Mon,  8 Sep 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346062; cv=fail; b=D01xkMBpdcIMOFsa9ia38NA4aZsOxBj3bc9UXkBewA9l3QzCxNoGcgwlIdxXwJ3bgKHw1kV7bNHuDlJajrLOHupB7VHO93B6O1Kl2aMAzTlaNZBOrxjfbjXzBLKhKe/IKSACYFGmsIhIUI/dLe97eOPWKJ17EtiDq9FLIW5Ho40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346062; c=relaxed/simple;
	bh=42NbsGREv5coNY5swLQnE0Yj8+H0nPMq+xl5rfOpEQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M/7VtMeku7mBPT3EZWVWIfmnE6CrIxINpgYlHQKwXkg4w/PqrB/4vcar3eGGrHII4E72tC3E8mPvQ4d1eql6EfUa0ilrCdf31wF1ZNfp3XX7KeiHYxggieoDC8CgOvCsxeq8XwnYqNYr3t5uuqekNbfpRYw7NrzcRWnx1NG5mxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FXf0hsGg; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4Jl4OxLgsUNp7PP7MqnJjdJPOZcB7t2imcoM5zOlPqyssMIxDrsbMwpLnTlrJEl0+ztHadxdVUc/YW3FbPo7VfJrybD/ZWRuaX+BTnql54IC002mx2Y5HrD5fNejH3leHCZ3GfpOLTLhfezulW1MEGSXffVRfM8jtwn19Ml8gNXJqiR4IESwa8ajFshACnNOdCC8EQxd20nFLIyh+mDVNqXsrkvnmkq2Tp/0b9Gb6jtetW2EVmy+fYdczOFCbmhoXWb/0J3XDJKeIwND2RCCsj5CKcWo/cN1jl4fuhMFJYB73tMTAzijmIhBTLt8hBE0fB9zPb0NIT/0OID9jeBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcP2coIM0p0Uk120g4x6cB32xCqzhvL3QSnkXUQBx7c=;
 b=PQm8tSaAVay4lV7gmhaG3FeblBdIpNOWFze5tJSOogNqdCOCAJ+Xo+jok0/IEglHeJRaEfjXbEeN3k27VHHlne5YswxCgcWmTcYpdHYoCHOV6evqnPAII0cyME5NgpT7TI+5TOnCDqWML6taFcuOv0mhiR172fIdpT8A1VQuWi1V7z60/ajNuJ40R1lD9cLAZBTsWi0RGQtUsoi7s6Bg0JEmUj6jSp7wRd1WAg2IzOzJtiLSkehvfY3ohPfxqsDWQDuD/7NGceeECwLKS5vxWLAEKcQ1rz6VwxnA6TrRaRSE8Mp/VnVqdxugxRMF4akB4Kn/Zi1UA7xfX4yeRRI+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcP2coIM0p0Uk120g4x6cB32xCqzhvL3QSnkXUQBx7c=;
 b=FXf0hsGgL6eQcm797oWn9n5N+WsNZNELYJnc7P0W7La5UWB34lJa+ier+kA7j3S73rQl8YQMH9H3xQI0cFSMhPZuHJeAeVd3qd+jwEM4JUvnlUWVSWpkew7ocy5OnvFn8AA5h2yg513FimniZvDaVMIzP6SVTY/aqI0p6R1WuG4=
Received: from CH2PR17CA0004.namprd17.prod.outlook.com (2603:10b6:610:53::14)
 by SJ5PPFF62310189.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:40:56 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::5d) by CH2PR17CA0004.outlook.office365.com
 (2603:10b6:610:53::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:40:56 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:40:55 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:31 +0000
Subject: [PATCH v6 02/15] x86/mce: Define BSP-only init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-2-eef5d6c74b9c@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SJ5PPFF62310189:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f857c1a-e5cf-48f3-135b-08ddeeee1a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFFybUhTOXRQSE1XSUVQSCs3ckR6emRwUjA2Y1V1NVc3VVk5R1IrWlZRVWFT?=
 =?utf-8?B?K1dodk12ZjF6bGVpa2JjZ2o3L3orU0pwUjJ4K2JuRjhDUk92eUFCR0FnRnNE?=
 =?utf-8?B?OVBVSTBQL21mSVROZ3BvMjJYNTBBRkdZQ1pSUVZwSlQrVXVlSlVZaWROemdo?=
 =?utf-8?B?c0syTEFsNUJqU2lJeXpTZ3JNNDhKbU11aWxSUGsyT0d1K1g5aGV1eEJvcEg3?=
 =?utf-8?B?VllobGZTcHJIdVAwZjhOaFFTcHJZNkJLeHg0c1JFQ3JhR3lkQnVub0VxeG1m?=
 =?utf-8?B?b3VDNlI5VkRjL051TzdseWNzQ2EzQ3FxRGFqaEtRcmJLYlp5ZGltazZ4NWFT?=
 =?utf-8?B?NnIzd3YxQi9DeTJoN0Q0Qng2a1I2RGJOajZYKzZ3UlVNa2pnZ29YOGJ4QW03?=
 =?utf-8?B?M0xUYXBSb25uZDl2c09QbGpFRXVkTS9MbmVaeGlQRXpleFozKzhKbVNyZnhz?=
 =?utf-8?B?OFRUdndNbTFnS1Y5OFBKdG45dGUzajM0UE5sN2h2UDNzWFZyL3k1bXFHM3lq?=
 =?utf-8?B?UjF4dzFjYnZyY0J1UzBUTFczbkdtV09iV01tYUt3THdYNHJ4bVZRK01MdXpm?=
 =?utf-8?B?MnBwWE5EV0FBNTdPWlpMTGdMN1lpOHhwSUFWOFF0bmM3dmhmNjNKQ1Q3bXJx?=
 =?utf-8?B?eXFUcXBNWmlRTG9WV05xY0hGV2JmcDFtcWZsL1EvVXhIalBOVVNRK1BJOE93?=
 =?utf-8?B?Y2Y1Mi9yL1kxUEw2NEZ4NWFUZmJBOEZCdW1vUDVlTTh2R1BNWGZYRHQ5MVJN?=
 =?utf-8?B?TVFaczN5Ry9OYkEyQlNaZGgyNEF4emxIOE9SZDFvSkdzdXpoU25USGpwVmto?=
 =?utf-8?B?S25nb2Ewb1RoRnJlS1FUVThsRFd2SWtBdHd1MjJPMVpvS1Y0Q1o1MlhtSnZp?=
 =?utf-8?B?OUZnTkdLZFFPVC9TN1Z2TC84NExvdFRla0hmZWJzWVFtRjBWcnZtbkNnUUlj?=
 =?utf-8?B?MlNjeWphNHdjSVlreVRvbVg5aUN3MkhEY0FWT1VTbUdwNmF4VGVLTmx4U0lS?=
 =?utf-8?B?UVFDeXdqNDQvV2dRZmhPYm8reHhBU3VYcFFEaUlIeG9tbzNvWDNiOGxXb2Iz?=
 =?utf-8?B?QXQ0Z2xQVk8weVpSeFllaks4MzVRaDlJcTNMYjFqNGtRZ0tBVGEyVmluRStG?=
 =?utf-8?B?cUJQS0dpUGpWdWUwcExBWEJqdjVpazF0NnJEU0VEUDc5aCtYdHBKQWZJdnNG?=
 =?utf-8?B?cUFkdXE0R3c1cEphVUJqODV4VTFaSmVmcThCWTZtc3lPMFcvVGU0TUl0dWVr?=
 =?utf-8?B?dlZxRnlGVFlDMFJLSmFXZUJjTjhWSjlLeUNaeTYvY3Q2S05aTmJPT2ZiR2Ja?=
 =?utf-8?B?MTEyMUt1RXZ0MVlENy92NENaQmZySng1Q3Q5UnBzNExwbHUrT0Y3SmNyUzFG?=
 =?utf-8?B?UkRxU1pMNk1NM1VLOFJLaDhOT0tpQ3EycmI4Tkk0bG1VT1llQlROeWc2dGZn?=
 =?utf-8?B?Mm5PRVBvTUo5OFFoWFF2ZE9WMGhKWjIzS3VESUQ0Z1hTVHZJZW1rVW1WeGFn?=
 =?utf-8?B?Q2NiZVRWNXlXbnd0U1lKVTJqMTY5N2VFbXp6NVkxTzcwNkJtZWF3WXRwUGZP?=
 =?utf-8?B?NGhzRGdIUkcvRHNZUTBrZGdjeHByMGlQMGtUMmlGV20ydFBWekx5WjAvMmgr?=
 =?utf-8?B?ZWRFekJWZWN6ZlRNUzA0bThKcndEallBK1dIMGhuUSthRVc4dCtWU2xUQkRo?=
 =?utf-8?B?bDFiSm9acE54aXVOeGxpT2xvbFVBSTE1WmZjQWx0MVpMSHZudnRLdTJyS0Rx?=
 =?utf-8?B?Q3Z4bEdXK0JlaHBRaitZZlpMM0Z0ZXoweEwwTWltcy8zM2VVMnFydGdxYWQ5?=
 =?utf-8?B?VjdvRmJFWTlTeE1BN1BVQ1RrWmpoNVFRRFpRcHg0cDdXUm51ajh4ekoycXUr?=
 =?utf-8?B?VVorL24zR09FU3hlNisxS3Z2MmxzY3BpbjdseEVPMmxlcTJvNkxBYXJ4UHBE?=
 =?utf-8?B?eWhKd1NYa2ppazlFSWNzUGt3cloxTGxSTWd5OGcwd0Z0Nk5ySGtEeWludzBZ?=
 =?utf-8?B?NjdwZ1dDUFMxNmN2ZkdPSEdrMnZkcEFsWlBFM3BrZWxRVnhWcHQ0dDVmQmtq?=
 =?utf-8?Q?TII9yZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:40:56.4129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f857c1a-e5cf-48f3-135b-08ddeeee1a25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF62310189

Currently, MCA initialization is executed identically on each CPU as
they are brought online. However, a number of MCA initialization tasks
only need to be done once.

Define a function to collect all 'global' init tasks and call this from
the BSP only. Start with CPU features.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250825-wip-mca-updates-v5-8-865768a2eef8@amd.com
    
    v5->v6:
    * No change.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * Change cpu_mca_init() to mca_bsp_init().
    * Drop code comment.
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/common.c   |  1 +
 arch/x86/kernel/cpu/mce/amd.c  |  3 ---
 arch/x86/kernel/cpu/mce/core.c | 28 +++++++++++++++++++++-------
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3224f3862dc8..31e3cb550fb3 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -241,12 +241,14 @@ struct cper_ia_proc_ctx;
 
 #ifdef CONFIG_X86_MCE
 int mcheck_init(void);
+void mca_bsp_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_clear(struct cpuinfo_x86 *c);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 			       u64 lapic_id);
 #else
 static inline int mcheck_init(void) { return 0; }
+static inline void mca_bsp_init(struct cpuinfo_x86 *c) {}
 static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
 static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
 static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 34a054181c4d..8bbfde05f04f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1784,6 +1784,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
 
 	detect_nopl();
+	mca_bsp_init(c);
 }
 
 void __init init_cpu_devs(void)
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index aa13c9304ad8..3c6c19eb0a18 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -653,9 +653,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
-	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
-	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
-	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
 	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9e31834b3542..79f3dd7f7851 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1837,13 +1837,6 @@ static void __mcheck_cpu_cap_init(void)
 	this_cpu_write(mce_num_banks, b);
 
 	__mcheck_cpu_mce_banks_init();
-
-	/* Use accurate RIP reporting if available. */
-	if ((cap & MCG_EXT_P) && MCG_EXT_CNT(cap) >= 9)
-		mca_cfg.rip_msr = MSR_IA32_MCG_EIP;
-
-	if (cap & MCG_SER_P)
-		mca_cfg.ser = 1;
 }
 
 static void __mcheck_cpu_init_generic(void)
@@ -2240,6 +2233,27 @@ DEFINE_IDTENTRY_RAW(exc_machine_check)
 }
 #endif
 
+void mca_bsp_init(struct cpuinfo_x86 *c)
+{
+	u64 cap;
+
+	if (!mce_available(c))
+		return;
+
+	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
+	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
+	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
+
+	rdmsrq(MSR_IA32_MCG_CAP, cap);
+
+	/* Use accurate RIP reporting if available. */
+	if ((cap & MCG_EXT_P) && MCG_EXT_CNT(cap) >= 9)
+		mca_cfg.rip_msr = MSR_IA32_MCG_EIP;
+
+	if (cap & MCG_SER_P)
+		mca_cfg.ser = 1;
+}
+
 /*
  * Called for each booted CPU to set up machine checks.
  * Must be called with preempt off:

-- 
2.51.0


