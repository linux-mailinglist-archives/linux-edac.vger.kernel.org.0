Return-Path: <linux-edac+bounces-4664-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E69B348C9
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8497920675D
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E910C308F2E;
	Mon, 25 Aug 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nEclwysg"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB68307492;
	Mon, 25 Aug 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143229; cv=fail; b=bWnEbDkOsC16QXxFRc9IfNpOFn0UGSpqQxjNG2c/ch9znoGutkNpzlJ3itz6q4AYWqMLw/zBa9AmbfrGuSIldtxeZY2Ghe2MCgJpgHzsHY8qsOLu+6c9B6Lv9oXGygPCRR5MlsB03oY6xPcFKN0hwReSRJFQpQA2/w8kUMnF5cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143229; c=relaxed/simple;
	bh=sOz88nuukd51rSa6gv5tUcVKvb82N0uW7Bi84SEagJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Dw8tmtMMCcf2xqku9JHMjRC63ZcdauZwaOeeY98zqveReWn/owZ2vr+eeL8LkGqwe/G6jMW+HTZukHGAtRVsgYixx1AhWxQGZYurctcTsjqdMq+v+DnkOTHl8x84dwLuWTDBIepBaWPPIXrWbGKnjh+TI2wECEEfVy1VaCjT1Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nEclwysg; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bi/NJsGuQJDmtPcwtKZIEVAFilo5VEa6X4aolc/ayLIvtjyfUny/iqoMGaB46AVWceuIIQWbSYmWc5bUQ7HS2F9yon3/wZJj8zbNOTUgkDT/F5WqiSfqPM6CoTP+RfrDCwP21oHdWAjAqcN8cbu9cIjpz8R3OMWsYUn8xyUB2sZ586URBLILIts7Nvyl5slRp6/I8bT18HMp58RxccRedcVsNs/2KogiwoRv/LHwf1+4OKPLCFvhyxvQ41XKDFZY8MGWZ2+gCFGtidJcX+TiXqcsk5x8aB0bgPpaGK2qjz6zfFqW3wRe+/iiUkETiGzUYAN5cJ2UbeUmVVmquv88SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuUwg3tVR57Y+8anZEHHXBkyJpgg5qvAjKzJwnQMomk=;
 b=chlvX85mvGFJ7FVRCsVIiH1CH1zlWGS41OjPdhMDjLa8VEXjTsBgP7c4FU6Y8jLjUoOdklV93MKw0Q2OGAGG0nn29fXZumSWbGA4RooY2PIre7Pae67DPbcmvMUigwAwYShwz5/JH/EnQljyTvi8RnO/JdagwRA1SNmiu41E3Cz4MjRqiNy8+Wtf/ctccrA32ChCJAHkH/xCNNggZ5Z2N3nxlgcmvPPeWSihD0ACAB0eZ4HxXKP8kcxjRYV/1y/H5hAUlAO7eM20tRl0aihN7fgJyySyZdabH8ZQtHxzwnjO3U4Jijy0pHwhOZ84FuJnYqjCkQPSGGWpqdhsG0n3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuUwg3tVR57Y+8anZEHHXBkyJpgg5qvAjKzJwnQMomk=;
 b=nEclwysgHhlt0wSiJqsJrxCDcBCxzMWUchNlEPJbRnk75Dk2jCTIlbCH92TsRI5lSYgY5kFnREUgkfzqLd6WJh/Sn8jNLbwR6iHIhWeF1THP4zXeukLGAPumXiaNRcndiPaKWrreS2TteODs6q0Ky59TLAjVlKyN2H/x5f2XxdU=
Received: from SN7PR04CA0038.namprd04.prod.outlook.com (2603:10b6:806:120::13)
 by BN7PPF915F74166.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 25 Aug
 2025 17:33:45 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::3c) by SN7PR04CA0038.outlook.office365.com
 (2603:10b6:806:120::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 17:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:45 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:39 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:04 +0000
Subject: [PATCH v5 07/20] x86/mce: Reorder __mcheck_cpu_init_generic() call
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-7-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|BN7PPF915F74166:EE_
X-MS-Office365-Filtering-Correlation-Id: 897cb91d-bda6-4fe1-e713-08dde3fd8aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDMwdXU4YzFrekRtaVRzU0pYQzYrWjZaVHU2aENsbGxMYlN3ekg0SkYwdWQ5?=
 =?utf-8?B?KzBaejdUQk1mZDlIdDNYb3Yydng0WlZrc1AvSWY0aXQ5aHluRWpBTmNSS3pT?=
 =?utf-8?B?TXNZbW8yNkxyNy93MzRvT1BKZzR2M2RCZkVId0VKQTJzVXlJbXhaVUt3bjRV?=
 =?utf-8?B?bWZPNTk3R1oyVXVEVU0zZWRZYXJUMkRLTm1VQkxVeldzNUFsVjQveE0vN2k1?=
 =?utf-8?B?S2FkWVU4Z0RlYVhXYmhEdFZCcnBid3h4NUZna2RSY0dxcnMweW8zOFo1cjNu?=
 =?utf-8?B?b1VuU25SQlIxQ25Jb3ZESU9Ld3lKQTZEMmdhSmNvUmtOTnMycnA0KzZhUlZM?=
 =?utf-8?B?c3Zmc3IyTlV1eUpJV2FWc1Y2QzY5RjhkbTdESnE1Uy9IbWVNdC80T0FDN1Vl?=
 =?utf-8?B?ZUUvdFMzWXgzTi8wQW9pVHVSd2d6TGJCTVZtQzZYWElIOHV6VjRZRWVKSXFD?=
 =?utf-8?B?UW5jMkJGSmc2VEhBSGVEay8wU0NSNnRIdjhiTXBiNzRtWDEvUksyVEFGMFQ0?=
 =?utf-8?B?bFh6NVh2ZllMbU1LbG0yRHhxOFVnQjRkcHVoN0thOXdpWGFZMVovMUF1RHdo?=
 =?utf-8?B?WXp0aCtyVkIyTkhRUnFxaDNyc244TUpoa0dCL0cxcTM3QVpaK0NXMGdaVjBK?=
 =?utf-8?B?V3hTZEpKWGpvbTloeWUybTRDbmRZcnNZbEpKSjk3a3ExdVlXcmxpVEJocEd3?=
 =?utf-8?B?Z3pmOXNMZFp2b2NDNGxveW9Pbk13YXhaQ0JEd3IyOWZ1SUNoZzBhVElOQ095?=
 =?utf-8?B?bkJ6VzYraDFLUmVyTjI0SkRvZXpPU3F0V2RoZkVzS1RGTkk3NFdCRGhUODkw?=
 =?utf-8?B?R1pwbXM4cEJCN09OZlE1VEhWUTlFek44Y2FuSFVDOUdvcVlPSXIvYzQvQ25a?=
 =?utf-8?B?K2o3WHZYL3VTemM0dSt3U0liWlhzQXM3Q3NsamhPZWdYY2Vhc3NLVDJjb2dO?=
 =?utf-8?B?UVFDQjRzZE9TcHRyd1JDZGtzRDZVdjQvTldQMnVNNDV4aHNGOTNzdTdHekp1?=
 =?utf-8?B?QnZaNmhLdWdHL3o4eUM2bEdMTXY1UnVmZ1lqU1hCSlh1UTR6dFpUSUUxam1P?=
 =?utf-8?B?SnBFSEZaY3FUUEIwYWpLdFRNdllwV3V4Yjcvb0dDTFFDRW1YTWJXUGFkYmls?=
 =?utf-8?B?NTh3cWFiZkkwZ0tINnIwVnd5Sjc5SzF1S3lwYUI0RWY3SXl5aXltYXlIT2ZY?=
 =?utf-8?B?elRzdncraTJEN1lrOGZEa3NoUXhGa2o3Wi9FZFB1WFkzR2hscTZzdGRpS0lZ?=
 =?utf-8?B?YWpkVTM2blhYSUs4L1pFNkF4bzJWZWVsWHM5V3BuZmRJRGxHU0N0aGU5emZD?=
 =?utf-8?B?L3pUY1VCVEtUQW5qOU9kaTMxZzNCaGZ4KzRVUER1Y25ZeDkyM2UzVERHVFdC?=
 =?utf-8?B?c0hhSHNvZ3QyV3NRR1VhcENLbzNUckhNSkVPaHdZSFl0R1orN3JncVBuczdz?=
 =?utf-8?B?NUo4YW5EOGx5a2xDQVpYMkNhd2FoTmRlWXRlQjNOMlNpUVdWZUJhWG5Ua3hN?=
 =?utf-8?B?Q0dFNlB6cXZVZUxXTms3dm8zQTh1aDV5cjdDVnFpR0VWemZDdkc2UkdGa2ZZ?=
 =?utf-8?B?MHRiVGhrQjN6bFFuaWV2NUdNcHlvei9XeDRHZXJjM1RPeDg4dEFqUlFJMk14?=
 =?utf-8?B?dmR2OU5Pa2hRWWo1dFI1WldYM2hON3VvUm1iOTh4U3dmRk5idmxpbWdhZWd6?=
 =?utf-8?B?aDEwWi8vU3ViTklIR0J6NzRlUTJ0UEFnaWd3dmRWckFBTlZsTnBwSFFoTUhD?=
 =?utf-8?B?cjNGYmNwdzlFVlY3K1dWT2x1b2ZuemFidjdIUVkwZUVTaExTQ1VvelUwZnVw?=
 =?utf-8?B?cEp0bm1BcUdPQXpOd3c1SCs0cml1dmp5Z2lJMTBPcWhGWGlSd3kyTGtTRENR?=
 =?utf-8?B?RVIzYURocWp6QnFDZnppVTQxb1ozekxoSFR5M3FhTjNUczgvU0MzOStVWXBs?=
 =?utf-8?B?T0hNcnRlL0lzeTRlcjRNWXY2UnRKVkU5dEVQMFVJYk0yendoam81ZzNJdWkx?=
 =?utf-8?B?NmF4RzQ5UUNtSE5HV2xEODRoS2RXU2sxazVXRmFtVVJxQUs5cDQwL2tkb2My?=
 =?utf-8?Q?vnLuVO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:45.2842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 897cb91d-bda6-4fe1-e713-08dde3fd8aec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166

Move __mcheck_cpu_init_generic() after __mcheck_cpu_init_prepare_banks()
so that MCA is enabled after the first MCA polling event.

This brings the MCA init flow closer to what is described in the x86 docs.

The AMD PPRs say
  "The operating system must initialize the MCA_CONFIG registers prior
  to initialization of the MCA_CTL registers.

  The MCA_CTL registers must be initialized prior to enabling the error
  reporting banks in MCG_CTL".

However, the Intel SDM "Machine-Check Initialization Pseudocode" says
MCG_CTL first then MCi_CTL.

But both agree that CR4.MCE should be set last.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/52a37afe-c41b-4f20-bbdc-bddc3ae26260@suse.com
    
    v4->v5:
    * New in v5.

 arch/x86/kernel/cpu/mce/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0326fbb83adc..9cbf9e8c8060 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2272,9 +2272,9 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	mca_cfg.initialized = 1;
 
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 	__mcheck_cpu_setup_timer();
 }
 
@@ -2440,9 +2440,9 @@ static void mce_syscore_shutdown(void)
  */
 static void mce_syscore_resume(void)
 {
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 }
 
 static struct syscore_ops mce_syscore_ops = {
@@ -2459,8 +2459,8 @@ static void mce_cpu_restart(void *data)
 {
 	if (!mce_available(raw_cpu_ptr(&cpu_info)))
 		return;
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_timer();
 }
 

-- 
2.51.0


