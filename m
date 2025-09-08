Return-Path: <linux-edac+bounces-4749-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5315B493DE
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B648B204F9E
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3A630FC39;
	Mon,  8 Sep 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g4TsfL1L"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59EC30F94A;
	Mon,  8 Sep 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346066; cv=fail; b=kEAvWqe7bUa4ny2gHX3J843+8isRwsfCoMhmvg7/osFcxgkRfN+Grw5ei09isoG4kvbCs/VeuNVAm3L/QS09FM/qDUu5obFREE2Y9MYw6iPoxMo1RIb0U/kFTognqHWJlgw5ykkItYiwhUJfapV/FL6I8dGshHTE+dmvfBTeneM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346066; c=relaxed/simple;
	bh=77x9LotGz4q1pWU2rEqeRGQ0FKblUCqSUPOyv3VrGF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ti6Ol/dJyoobHaX/ze/wLNcI9yRio5WCLZiZiuYxZ5Y0QNktqWT0ROZIGgT7bvgh3PrtDrsuYShQvT/9dAS9bh+HyNu5oXYee72ey43JYwUIfUibdwgHf/XcK6YQCf2x5Mh9NNGcC+Ar4m2ecBdWriGwxNq0RlZIyQupLJg+Bh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g4TsfL1L; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sI3ivR90m7Fe+i4P3kzM5oMNKE8qKnFfmjBcAXDI+sfuQfgR9lapU2wRr1XUeSctArTkIf1pqLjLvYMdNY65hIk+7rvswZufqGDoHedk+nzjyE57vhKtea9RtBmxuhK6lD3dO+IMbSMDCQ1Y0oVfsgvZ6yWCcaThDMhrewa58yzP8sVtKGqJxMR8F1jaNnwG5vPXdtt4BsBuYdUBui/kBvj1qO/V763FeXGOLo67aOtQPzRqF2Yc376m3ZUs51lIxvLLvvli2mIWXg7vm5BGD0iwMBnA64gxkrSlWYwLr2Psm0s+dYO6dvpMtmm6++7r1VjKnZY7aK/uMC0e+sPBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3NQlZIGdz4iiviHwrtrXxCt/lgwIdNySNMmHRIDE2s=;
 b=gKu+sNJrj8AzYsc6ZUhK6+J6ckKWZ4Fnr5EZOphW9hQ/McAFkxw8JB2MHbWffJ2YijAuTR+w/FrauyQr0N7NpjweNVPcNrcMOW7w5b4pF+GkBsH1enh8tl0zggqOftfnlHqAbE8cxaJSfECAjoacGGK6hRUjVQzZ7vGrNNYly4v3n36vOB+7Huw2ye9RgirAriKJ070aN5i/lZzy3PWyqVXd2LPATAlNv3oXeN5UGSAYaxnVgSuAY2NxwNZjWg3ktJCNUQU/iXme4IMKBJO8cPkR3Giwbvy4hiT3n56G1IFut6hq7X81eRVHQQqWBGW2Jjs0TV0RJpKuGCAPtajgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3NQlZIGdz4iiviHwrtrXxCt/lgwIdNySNMmHRIDE2s=;
 b=g4TsfL1LcFCtH/FRE4o8iNScc6FjQWu+LgqDV63DPLWt8Tsa6cdDEZ2U5Pe/6EYsrhbq6Fj6DJj7etMNo+oRbiqo+y1MvVwf9L8LrBI4eAYhdsNf4aeTmBXYMd6bNfuB0tlGHXYi24IenXi+J/6JRixL7RcJn7E1wE9FwaZNhuA=
Received: from CH2PR17CA0001.namprd17.prod.outlook.com (2603:10b6:610:53::11)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:40:55 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::80) by CH2PR17CA0001.outlook.office365.com
 (2603:10b6:610:53::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:40:55 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:40:54 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:30 +0000
Subject: [PATCH v6 01/15] x86/mce: Set CR4.MCE last during init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-1-eef5d6c74b9c@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: f591b2e2-9ead-4cb1-6b18-08ddeeee19c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWtQNHFkYW8xY1NjOGFpNnBncnFJemhIemJiSHZoZDNLZEk3Q3lVdGQ5T3FD?=
 =?utf-8?B?NWIxSmFzNXU2V3pkZDFVNkplcTNmMzdER2FDcm53TUovTTgwZ3d0VFluOUd3?=
 =?utf-8?B?UHVaWVRwamI0ekpVZXZPcEtBTGxEV3dENUJnZjlkOWxHcjJCSktvMHMzYUpq?=
 =?utf-8?B?cFJDYjdHMW1rM3A3L2Q1eWNLRUFPaEtxR0kwcEdhKzBnOFJvVHhvZXd3U0xs?=
 =?utf-8?B?Y084dGEveWN1NG1Zc0dxMEpka2tyWVhnSFplTnh4akdDbHkyMGE2Q0Rhc01j?=
 =?utf-8?B?SHArb09CQWhUNnBZWVJkNU5LTEduNTQxT2xSZUNhemFGQitlU3JPWnVtVnFu?=
 =?utf-8?B?MWVyYnlZN2lkK0hRajNGOUJzNG5na2l0Zy9HRiszQ1RNNm83ZkdVemRqUmZE?=
 =?utf-8?B?UFVqaSszdithSzU2TFQyYmprMHRBSzR1ck5meGVwQlhlUzY5Z3JsOU5pTWIr?=
 =?utf-8?B?VEYyemZSblA1Uk9KdFpHNWpvTElhZmU4bnJ1Z0EwWWIxbEZFUHR5c1BEeXRk?=
 =?utf-8?B?R1AxYW1Ub0R4b0Z2NEYvSERhZkJ6NDJ0TVFWak1vQXp3MFlaVHRsalcrNTEw?=
 =?utf-8?B?TnRjeDF0Tk41WlhaNXR0TlY0NG5reEhMQnVYYTVWNjlML0Z6VTBZTktLV1BJ?=
 =?utf-8?B?bG5RRTZSaTAzcXpDNGxlS2ptam42d2ZQWmh1ZjFuMk9sNURSTjQ3QUhGL2dr?=
 =?utf-8?B?dmtLOTFsdmlVeUlRRktUdlVzNDRSU0JNV3FmUU8zT2lya1BxYmEvOWhBbkxD?=
 =?utf-8?B?ME81dlRtMDdlVW9BejFtbGlOVXp4eWVPa2dDdFFuQXNwMDRLb3ZnVUtlUm4v?=
 =?utf-8?B?R0I1V0t5S0tXVklCQTREK21Ja1cyMFBtY0JDY0h6T2VBTlhhc1lzSC9ncHJ6?=
 =?utf-8?B?dytGWm9uZ2oxQlFZRkNMcFI4M09IM1lkV214UzlhNWVrb1dlM2lyT21HcGU2?=
 =?utf-8?B?dXJ0YU50YW9FVjdtR2tMV2EwUWFDWHRPUzhKV0dWRzRnWWNENTUydEtNSlZx?=
 =?utf-8?B?Nzl1RGl1ZDhxMm1GU2dtYVVVREpUdFJKSzFNOGZsZ1BZWDkxNmsxYXJsMVh0?=
 =?utf-8?B?ZGN2UkE5bkJwZ0tGdE5pbDZxanZDTzJuN1dNcGlGN1lLQUt6RkdQczFrL1Qx?=
 =?utf-8?B?R2RSbGNVazVWUjlhZXoyNS9HTEx4RlZxTVV5NXI1NE12Q1NCOG1DcE4yaGFi?=
 =?utf-8?B?MlFzRm0xKzlrTW03dk92THRoK1lWbTNkK01jRzVBVHdGQXAyMDlVS0lHMVd2?=
 =?utf-8?B?am5hUWZYa1MyQ1dySCtxanQ4dlUxL1VJTEtxTXVKNjFOdjN0MXd0cXk1a1pX?=
 =?utf-8?B?SHdmL2c0VDlhVjhwcDlaWFFQV2ZzL1JnVjNUNXB0M0hmVnFaakY5NDFvVEIv?=
 =?utf-8?B?SGxPODRMSnhLMjFCVHpPN3JYUTY5UFNXUVJ1V2REWmRNYWFkZWRFODBkSlpn?=
 =?utf-8?B?R3Y0Kyt4cm9PUkd1ZlJTWWV0Wk1wKzVKYThTTVNRdGxRVERJS201YkZZajRU?=
 =?utf-8?B?TjcxZnI1L2Z2dzNJcHljUGV6RTdZTDcwbSs0blRsTnlxb2ZYRkw3S043YjV5?=
 =?utf-8?B?dnRYSmM1blVGV004SnBIakVZMzNVVlB0Sk1razRIbjBVcGcycElnTjh2WEZz?=
 =?utf-8?B?MXd6NWR1OVAyQnNWZmtST0VTSWpFdFVWbmtPdmNUYzdJN1BOc0Vmc3o4ZUhr?=
 =?utf-8?B?VEM2b0h6L3RSQURqYU55RnBrdXQ0a1VTbkZZVEs1Q0Fad0plaUczeWRLTE9o?=
 =?utf-8?B?eDlJYnEwajJzQnhnd0RIYW5GUEZOdXRFNTRIYmdZZlZoSitxNExhQUFjMU9W?=
 =?utf-8?B?NTVEd1hRaEsxUVVXVDI4M0gwRmVKMHQzM3ltS2VyZWdZVG9FbXJrMFVyVDY3?=
 =?utf-8?B?QmpXYjkwSDdhczJlaUJLNE1RVlQxTjlrSUh3ei9yYlBSRHpUVHd0ZmcvYXZO?=
 =?utf-8?B?T2RYYXcyaFk2RFpTQzYwNEtueHpBdFhVVkEyK1Y3dXdVMVZ4ZFNlbG85Zk1S?=
 =?utf-8?B?WmlGVnlLb2xEOWZqSGdsKzErelFvV2g5NUhWNW1EemI0aS9sc3Y1c1NXb2J3?=
 =?utf-8?B?Q2dVUXd4YjRnQmxhMWVNajJXL1B5MWg4K0JMZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:40:55.7670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f591b2e2-9ead-4cb1-6b18-08ddeeee19c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760

Set the CR4.MCE bit as the last step during init. This brings the MCA
init flow closer to what is described in the x86 docs.

x86 docs:
	AMD		Intel
			MCG_CTL
	MCA_CONFIG	MCG_EXT_CTL
	MCi_CTL		MCi_CTL
	MCG_CTL
	CR4.MCE		CR4.MCE

Current Linux:
	AMD		Intel
	CR4.MCE		CR4.MCE
	MCG_CTL		MCG_CTL
	MCA_CONFIG	MCG_EXT_CTL
	MCi_CTL		MCi_CTL

Updated Linux:
	AMD		Intel
	MCG_CTL		MCG_CTL
	MCA_CONFIG	MCG_EXT_CTL
	MCi_CTL		MCi_CTL
	CR4.MCE		CR4.MCE

The new init flow will match Intel's docs, but there will still be a
mismatch for AMD regarding MCG_CTL. However, there is no known issue
with this ordering, so leave it for now.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250825-wip-mca-updates-v5-7-865768a2eef8@amd.com
    
    v5->v6:
    * Only move CR4.MCE programming.
    * Update commit message to match the new change.
    
    v4->v5:
    * New in v5.

 arch/x86/kernel/cpu/mce/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0326fbb83adc..9e31834b3542 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1850,8 +1850,6 @@ static void __mcheck_cpu_init_generic(void)
 {
 	u64 cap;
 
-	cr4_set_bits(X86_CR4_MCE);
-
 	rdmsrq(MSR_IA32_MCG_CAP, cap);
 	if (cap & MCG_CTL_P)
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
@@ -2276,6 +2274,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_setup_timer();
+	cr4_set_bits(X86_CR4_MCE);
 }
 
 /*
@@ -2443,6 +2442,7 @@ static void mce_syscore_resume(void)
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
 	__mcheck_cpu_init_prepare_banks();
+	cr4_set_bits(X86_CR4_MCE);
 }
 
 static struct syscore_ops mce_syscore_ops = {
@@ -2462,6 +2462,7 @@ static void mce_cpu_restart(void *data)
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_init_timer();
+	cr4_set_bits(X86_CR4_MCE);
 }
 
 /* Reinit MCEs after user configuration changes */

-- 
2.51.0


