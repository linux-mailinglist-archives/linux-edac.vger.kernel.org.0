Return-Path: <linux-edac+bounces-4754-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D84B493F4
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A302060B2
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C103A3126AF;
	Mon,  8 Sep 2025 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XZSgF5UQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E76311C1D;
	Mon,  8 Sep 2025 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346075; cv=fail; b=Ph9LMVUa48A1sp6cmY/OWdeEuHQgrJcxQiYgxQQc241gt6NRePbstybpSkgOXp/mHMY2WW3zTZCgIMpDvhJ601JQRwOCuMMMaj7PkTnscWhe1bj2WKtYp3yuAYGNqIXWX6xhESLSnqGUe1pURPmvkZzRCJGwPvOZt/Y2fpEVh50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346075; c=relaxed/simple;
	bh=rLvTjkqirVV52tihHknbbHgZYCI0J1bZ/ECW9Z8Nw1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LiRS/1ZUkoqOdtF2+tqjqS1f0jZnhH1wyupoFek6q4q/kGO0rrZcDdNj1pzrNPrZUz0Yyhh5zEyXYMA+bybQjDrZU1CIGYJH9NsTXFnJSGoeddJteK84jawojQY7xpSqJtBUAsgKJnw4LJ+wO/y6OAF7Q95DG3Rkx+r847jTlMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XZSgF5UQ; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzpbbOFM/ggEpPmcx1CBfG0P9r7ZAa5o9+XPtKdltfbAdiGmH18wvILZgzRbH4iZkvQl3xpnLIxmuujFnVwLmozXPY2+2kIss2c/uCLKS6Aq1jKjuLBmoNWhDe78xaC49ZaLYXi4ZeXl67bDTkvN7WDSKakXA4XBocCMZRriWmInTm+V2oSAmu3MK1wcCrNd6K+kzjmrsRKXxecZZEMZVLdX/NhlchXISmGGqzbXaxOm+0tsbWL4e7LNAr+2BBE5utg9YAab/4KDRfRBIK7pSSYhJM7/XMxI87O5Etco5/pNqZfsuMBgD0JqD2AZx1m8X5uqH2iAJwHsfZvceZ7Tzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajgc9eRs0YyTQu83aY9gWFa7U2GT8XJjT3EIGU+lW/4=;
 b=rWWDt972DTGbDmUKKzRBb6nWKfV0Ux3Tpv4Ga/ah7AnbCYJNJgIHBDD1Gb6xuvpnBsclCT3YiuqpvUyDn8mHH2gBq7yBjk/uk9hWD1owqi4Z0suEDdMwqnq1sldudAhheIi5qJSP/U+L+HtjoLJeXWf0iLzsgQwECBxDwatwe3lPcX9lTBIHR9ZKuma+dqlNC45+A3JoaQ3aoY0ZsJ+FVxKvErfKuTQRvYNO3jfD1/x7YI1wUw+a0xQ25k3uf7CvhFyeb0/CvJ7LpSwWdShpEBsKQbQN9QMdRHz1oiSmB8dXzRLI02QNsLHVxZF5KFHgFN1GmumeVmn6VvBEY2E9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajgc9eRs0YyTQu83aY9gWFa7U2GT8XJjT3EIGU+lW/4=;
 b=XZSgF5UQPtFUoMoDKNq/9HVfynX5kfnO37T8vismmxu5l2LPngnEuhrbzinMmR9HvcyGSYQGyazcAFerVW2XoiCnJbE9HK7Y87MqLdb8PXeMDLsabtu0mcmESaMYApcpp6MdFD+6cioW2O/NwbTVs0FT81dDwOEODEjV3I9hL5w=
Received: from CH2PR17CA0011.namprd17.prod.outlook.com (2603:10b6:610:53::21)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:41:09 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::1a) by CH2PR17CA0011.outlook.office365.com
 (2603:10b6:610:53::21) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:41:09 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:41:01 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:40 +0000
Subject: [PATCH v6 11/15] x86/mce/amd: Support SMCA Corrected Error
 Interrupt
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-11-eef5d6c74b9c@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2cb37e-7bbe-417e-8b09-08ddeeee21a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmlmZlp6L2ZXRVlVZkwvUzVyYmxEdVhjUVc4TTZHTTBjQlB6M1Fqa05QRExK?=
 =?utf-8?B?YnI3b3BTVWZMWjVsU1daTGFKbUc4Vm51WGYxVjRrQzFIMmo3Ky8yOGxkdkRo?=
 =?utf-8?B?VzNwaDJwMHdzM1NFK2Z5Z0JrcGkvbDhqTDNudkk0TENmeFZDdGd0dmZ0UG9R?=
 =?utf-8?B?WnJMc3MxYVVCOHArT0RmcysrSWZmTEZnQlBiOXBFMjRXZVpnSzFnOHRDSERq?=
 =?utf-8?B?b1prSWwySzFJOGx1cDZTOWM1c0tqZFVYS3RZNG1qOFQ5dUJESGxCWkpkdUYz?=
 =?utf-8?B?N0EzdW94T1cyQjVjblVnaHMrL3VlbU9LT0RwNFU3M0VXdk5SbndtSnpxRVV0?=
 =?utf-8?B?OWFNVXhyeTd6WGd5Y00xaFI1YWhjcTdKR0dNZytPOEU0akw5QVp5SlN6LzdS?=
 =?utf-8?B?NEVxc2cyVzNhT3ZQd3BtM0N5eGtRQ2NscTkxQnAwNXRLZjVmWmE4cjQrakVQ?=
 =?utf-8?B?ZFNuK3NrY0wzbVpWMEM5R2I3dDVoRnBQbFVKMHUwN3JzSXRSbTZtOUlKMzNX?=
 =?utf-8?B?b2I2M3A1OVdMdnpjT2hYQlhERFdYRk9xdmU0OVloS05jZDBEdUVvU1RIMHhN?=
 =?utf-8?B?bXEvUWhUQzJWMWJZMmhoYkFHK3FZZkNYZ0dudzhUdXlJUExVVWZmVVZpdCt4?=
 =?utf-8?B?WE5ycWp6eHBNeExuTlNPdjFHS1lZQU5SMGh3NHZ0ZDNKK3dRR1F5cjc3MEtN?=
 =?utf-8?B?SWpaY0NpR1ZSUS9yTGNkck9OMTJOeGZ5OWdqcVJkNG1SUjFNZXorZy9EYm9X?=
 =?utf-8?B?VjVYamRhNndRWDB0QWZNdDhwaklTNU9KUDFNT1ZoZHVHQ3VsaXpDSFdMSWR5?=
 =?utf-8?B?bEJCcUFTYnowd2ZhMkJlazN3ZXJlWStEeWlRYWFIWUwyemN0YWRCMmJJL29t?=
 =?utf-8?B?RWdNUTFKdyttdG8yNDV5aWs5NUZCSUFkQ0lDT25ybHh4d2FobHpCakFBN2xD?=
 =?utf-8?B?MmhHenByV2o5dDR6ZFZ2cnV2ekJWYlA1VWRNODZ0MjhiU1IzOEtTY0xWNWtM?=
 =?utf-8?B?VjN4bGJIc2MzRkFPMnNBQUNmVWl5VCtoYzJIamJnbmFxRHpONG92eDlxOTZK?=
 =?utf-8?B?NUQwTXFRVDNYczBzby9qRWZSMjJaK2s4RDVCb2pmWmpya3VkaWtaUm0zUVVE?=
 =?utf-8?B?QVBqQ2tCS1VUQ3AzeEdScTAwSW84SzRTVVU3ZWQyWGg5bkNhdFBHZ3loOW9m?=
 =?utf-8?B?UXgvQXVxSHkrUy9tVXd0bnlkSlIwVkM2eFEzUnlQZW9zMmY3cWhXZ2FNcHdO?=
 =?utf-8?B?aCtkZlJISjN5a0lIVWRCRlRSeUxmZ0w1WWhuQ1JUbFdoYWNyUCtuR2xJQjZV?=
 =?utf-8?B?VFFpZXFFNDNZV1hoNDJoQWhTME93eDRCOVd2NUp3Uml2ZTc0NE1MN1NycmVj?=
 =?utf-8?B?UDExdzRyejJpTnU5ZkQ1d0phQm5iZDZKYXlIbEtIQ3NzYWtUaTloS3o1Vlhq?=
 =?utf-8?B?V0dSYktxUzIxbjRUNXgyek0xNzZ0a0ZtZXdPRTNrelhwNlBNNWxJTHZQRzk1?=
 =?utf-8?B?K0xZTGhYbklReS9GRzJaMG9KdGRKdWR3MFpiN3BYOVYreTJtRGIwdFVwbEpI?=
 =?utf-8?B?YU9CajJSZS90UjV2MlNtMnI4SnFuOXpQNWJsREtCWlRtVWJXK1VJWU52eDhy?=
 =?utf-8?B?V2E2Ykt4enJobC9mTjl4T2JqMnpSdFZVb3JhMVAvMW1idWtRZnE1azZ4MTBt?=
 =?utf-8?B?YTFkSjhLTWtwVi9Ea1pTMHlNZ2hUd1lMdHVQNS9UZzNFeUtQczR2U0lNQkJM?=
 =?utf-8?B?SmFHMjlTbCt2eG10Y3NvNGlGZy9VdURWRlpwR3UwVzMwRDlkWmk2R0ZoaDVo?=
 =?utf-8?B?TTJrWEZOOE8wNXY2WE8rRmtCSGJDQ1hQL2Fmdkhjam9KVkp1YjFiRk1jSXlR?=
 =?utf-8?B?YldQLzJ2Nzd4VUFxY2l5Um11MjZzS0Vjd0lXRjkwY2NaWWl3bDlCU0VNMTh4?=
 =?utf-8?B?ZnNLK2F1Ym0vanduOFAzTlI1ejkwUTV2VjFFOHcwd1JONHdNVzhsNi84SkZC?=
 =?utf-8?B?dmo4SzlJTmpIYUxndVQzNmpLYVcvMmJYdllFSFc2UDY0Vno3T3Z1RDBHRWty?=
 =?utf-8?Q?ti/A+3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:41:09.0189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2cb37e-7bbe-417e-8b09-08ddeeee21a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769

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
    https://lore.kernel.org/r/20250825-wip-mca-updates-v5-16-865768a2eef8@amd.com
    
    v5->v6:
    * No change.
    
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
index a6f5c9339d7c..34268940c88a 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -308,6 +308,23 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
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


