Return-Path: <linux-edac+bounces-4672-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CB5B348DF
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A01206EFB
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADA430F545;
	Mon, 25 Aug 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="erfs8abH"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB23054FB;
	Mon, 25 Aug 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143235; cv=fail; b=jnNhjYNS057/191e+wc6+HKUN5/ERlrbCv/ZNY88iuvj9IJUPfah0h4ImoiaGRkL5vPotGoSSb8LFgYxzOz6rmq/gNvuJqz28lXF6tlFaVv+Kr6BGEqgzfADTVtS6Qz44iA+XUygadvEnRc41MJx99md9UEUUgIiMKUS4+0P3rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143235; c=relaxed/simple;
	bh=VloJpj1zckQAPNB/Igkh2wML9gd7UDtj0gqizHR3aTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BCtwCmFhOpby6e8/JWyeg9+FNQyAD12yXQV/O68kkoKWZfArEE9marlZOs1E/F0mP+Ml6wXoxXKBg5yZFU9HWEgx5Uuln30ue3A6rGvl7epSZFY2ZmL9vpl0Zkw2Nlu3VckxM36+DzseKG8e34+s2R91+LQZW8cAoXEtikkLM9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=erfs8abH; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1TuSmoNpZSU2v6/HSgpEB2L/ShchAsbqG5qPiWcfr2yhAKG3Tf3pHtCu98oXY3o6SvxdYy96ukaAehCJ2bd9UirXtHsgAkd1wE0pk2HemnS9/jPS0RrREvBeuV3ECirI0WudZBeb86oqKqExTZZceL2tntd+Kk8Q3okqUxXQFvq+F4hhyf0dSHY1XifbpLez1PztMpF9PC/IgK0M9dIKzJN23/fXY7SgffAydvm/dUKWT3gIsIJeOO71+sJLyopirUQbWtv90ALdBOKrWt3gRDT/tKLN7PT/VMT1A7zCqd9zgxQk5HYlss6cG/gIv3XfMLOviBbA6WOWo8He5UPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPnCuM62b+V2696LUhgaSUORujh6D09Ivy/7bRGeB4o=;
 b=qPAUZyUCPyGFyqquKeAZqoqWkGM4Z1fzhhOdyorXhGUNA+IKieLMD8+i0QfodsjhFDzTe08RggH4BZXtio56c23+A109rKDgRMX0kh5KSn8mjtlTKDPSJr2TauFlMmp9dj3lewg820Xtyi11vM6fn+ffuBSGvavJ4jaStIOomYEtp0qDaPwVqTHbwVWL4p0Bcw8+N+zCrEHPmylmT4qG0nJ807E7VX1g4C6ccCOYde2YohZD6lYeFAJkYgYN2h3nNNnpZY8xptAP6XcZCQVhaKdkxnELPIHiMWlNfmLJ3SECWqcu7sOs543du2nc3W9zhcrEanhKuXRwInDeIDEUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPnCuM62b+V2696LUhgaSUORujh6D09Ivy/7bRGeB4o=;
 b=erfs8abHmg44gEbR8/mJlPsf6aWOOkcln1gC8eipzLXFz85gdrwnffR3k1Vs0z5wFWOM1XCWPfKY2OHwSKJfbo47B3lrnSLBkCswe0KvTqvwhTlmEKE3mmMfpEUOLrbG+MbcMwdEQlxcUqc+ChKGdE+A8qDhQUf3Qjzzu988QZ0=
Received: from SN7PR04CA0058.namprd04.prod.outlook.com (2603:10b6:806:120::33)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 17:33:50 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::66) by SN7PR04CA0058.outlook.office365.com
 (2603:10b6:806:120::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 17:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:50 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:45 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:13 +0000
Subject: [PATCH v5 16/20] x86/mce/amd: Support SMCA Corrected Error
 Interrupt
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-16-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a88cd7d-fde7-4e6d-652f-08dde3fd8e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2ZhWEoyeWtCa2VhUTRjUzcvQlVEdE5VaWVXUWxCQmlGYlhHdjdQVFBhd2dL?=
 =?utf-8?B?Nzl2cDFRTGNhSmJLRzJmRS9ZSnhDRldKbExya3IzVU1BMCtoVktXUmlwWXIv?=
 =?utf-8?B?NmZoR29tajRzaC9xZS9XR3ZYWVVrZHR5RFFmQlh4WHB6dmllaHMzR0pOaWFm?=
 =?utf-8?B?bkZUYi9BSjF3dlFJbDU5bGNvcjIrZFZzSGlBaVZqZVdrRlJTZTAvOUZYejEv?=
 =?utf-8?B?K2Rpdk41VmQyMEV3QnJMTlN4YVRuQ2x1M3RYWU4vLzZJMTNaRXZRZ08xdkFL?=
 =?utf-8?B?eVZlaElrVHRGR1hsWE9SbmZ2SXQyTU4rUlU5RjRTUzBBSVgvSmVob1U0NmdN?=
 =?utf-8?B?aWtyUmNKcXhZRVFyTkZ2Y1lWeW9MV1NVcnk1cGxnSjlnYWVuZ1RFVHJGbUov?=
 =?utf-8?B?S3BZTmZLelE2QlFvb0t1UFdYNUZXOW9KYzA4a1ZQZjk1OUJqZUZsV3RnRTBm?=
 =?utf-8?B?dnVrcnZuYXVycWNlVU1jU2JyVEpmV0JuQ0VjdjJJcjBmeTM3d3dqWHpGVDg1?=
 =?utf-8?B?WHp2ZWJnOWtzc0ZQUnVnT2NIQTB3ckgwaUljU3VJZFlNQ1F0NC96c0ZVSTVE?=
 =?utf-8?B?Q1dxV3Zyd1ozR2xqZzJ3VDRLWmF6NGdzV2cweXQyQ3ZPMTNJenhuOFdVMDBz?=
 =?utf-8?B?bTZMRnhkeStHb3BIZThZb2FUSmhwWURmTXl6Wll3NGlNb3VwT3lCRlh1Z2xJ?=
 =?utf-8?B?enpXNnVnN2ZBWnN2ME9XZU4zWVJwdG9zM3lYd3VTaXhubzZDNXdyMHpsYVFr?=
 =?utf-8?B?aXJuQXgyaVQ4OUhDSjRpakQvSW1QcWxSM2FpbEluZmdVeFJkZllLR0VKR052?=
 =?utf-8?B?QkhJdDFtRW9aTGFjVGV6WnFxdFh6M1FHd1BVemplYzhKZW5NOVpoaUxjVWxH?=
 =?utf-8?B?Q2pNUUkrQ2xZUXY4UG9aK1RGd281T3pvMHViN3pkaUsyanBUdEtENDF4M2Iv?=
 =?utf-8?B?b0tESmxZN1BrNStFMTlnazdsQW9vN09oWGs5MFB6cFhNejd0aUQ0bEVSbjF4?=
 =?utf-8?B?SFBRYzVOSWZtZXc2Z2xNM3NDclI2TjR6TkgycGo1NE1tMUlpMVFKK0tBOFlH?=
 =?utf-8?B?eFZaUnJFSmtCYkNVaGdyU1luOStyajBrQlFhVC8yYTBnb1psUnhyMHk5a0tk?=
 =?utf-8?B?OWx3YTZaRVRUTkQvTEI2bldiY3JFMGNhMlZzNFE4UXV4UGJRM2wxeklGWW9Q?=
 =?utf-8?B?Nm9iM0pBNlV3VVdLanY4bStIejhQSUUySGxlbituREFBRXo4aVg1MGtpcncr?=
 =?utf-8?B?K1lIWG9Rb1hIeHduRXhibnpSVkJmR3V5VnVCb2dTUWFINkVSa2I5SUc3V2VZ?=
 =?utf-8?B?NUVoMWZ2aTJsOVB3T25DU1oxczhoK0Y3K0U0akwveFdzZ2NIRlhISmM1Lzlj?=
 =?utf-8?B?dEhod3o3UUcyMjdYN1NheTk5aW9SeDFwS2tDZFMwcTZRanFqYXJKYzZGZmll?=
 =?utf-8?B?N0wvOS9pMlpsSW8rMk93UVJFamZwc21ZNURLZEJVTDNIc0RJTktTQTRnS0xj?=
 =?utf-8?B?eTdTL3lYak9sYzJoUlp4VnI4eGlBbzJJNjAzL0kyaEg3SkFOT2ZMVkkrMHM1?=
 =?utf-8?B?M1l2ZUFGUzZZWUlFY1BxcGltem5KbHNwWWVJeXJZdTJLQlB2U3RjY2w5R0R4?=
 =?utf-8?B?TjVpM3FwR3VzalROZlh3OWY2cHFlMnVtbWYrQWFYdm9wVmhHNGRoSVA2SnRq?=
 =?utf-8?B?ZjdxQ2pPWW81Uk5zMmhuK1c5ZzZtVXFIRzVhVFJWRnJQdzJ1LzlKMWJQQXVM?=
 =?utf-8?B?NEc4UjRWdjlZSzJ0OTBDTVJRTjB4RnBRME1WZmtITmxXYXJrN3dHTXJ0WW5i?=
 =?utf-8?B?MjQzdFBZZUxnY1lCck1NQkxzL3ZPOWg3ZGZlU2J2YWhXLzdVbU1Sd1ZOVEtC?=
 =?utf-8?B?VWJucEs3WEw3UkxVMGVvZVRNb1NEK0RsMlFuNlpVNUZSR1g0eUswTGFWUlUx?=
 =?utf-8?B?RjRUUUdHZklxaVRaWjJrOWV4YzgrSjc3dGtoQTRVVVh4QlZ1cEo5YUpsY1gv?=
 =?utf-8?B?aVNlOG9vYk9id1A0SzFETjFWZFZ4MU40VUxmcmErMDhnSmliVGtiQ0VQMHYz?=
 =?utf-8?Q?pAWTdN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:50.6155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a88cd7d-fde7-4e6d-652f-08dde3fd8e1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776

AMD systems optionally support MCA thresholding which provides the
ability for hardware to send an interrupt when a set error threshold is
reached. This feature counts errors of all severities, but it is
commonly used to report correctable errors with an interrupt rather than
polling.

Scalable MCA systems allow the Platform to take control of this feature.
In this case, the OS will not see the feature configuration and control
bits in the MCA_MISC* registers. The OS will not receive the MCA
thresholding interrupt, and it will need to poll for correctable errors.

A "corrected error interrupt" will be available on Scalable MCA systems.
This will be used in the same configuration where the Platform controls
MCA thresholding. However, the Platform will now be able to send the
MCA thresholding interrupt to the OS.

Check for, and enable, this feature during per-CPU SMCA init.

Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-18-236dd74f645f@amd.com
    
    v4->v5:
    * No change.
    
    v3->v4:
    * Add code comment describing bits.
    
    v2->v3:
    * Add tags from Tony.
    
    v1->v2:
    * Use new per-CPU struct.

 arch/x86/kernel/cpu/mce/amd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 44fa61cafb0d..559ad5ddb7a0 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -306,6 +306,23 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 			high |= BIT(5);
 		}
 
+		/*
+		 * SMCA Corrected Error Interrupt
+		 *
+		 * MCA_CONFIG[IntPresent] is bit 10, and tells us if the bank can
+		 * send an MCA Thresholding interrupt without the OS initializing
+		 * this feature. This can be used if the threshold limit is managed
+		 * by the platform.
+		 *
+		 * MCA_CONFIG[IntEn] is bit 40 (8 in the high portion of the MSR).
+		 * The OS should set this to inform the platform that the OS is ready
+		 * to handle the MCA Thresholding interrupt.
+		 */
+		if ((low & BIT(10)) && data->thr_intr_en) {
+			__set_bit(bank, data->thr_intr_banks);
+			high |= BIT(8);
+		}
+
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
 
 		wrmsr(smca_config, low, high);

-- 
2.51.0


