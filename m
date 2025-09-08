Return-Path: <linux-edac+bounces-4745-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74DDB493D6
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940A5205A43
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255FE30F957;
	Mon,  8 Sep 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="txSE5F+h"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6E1E130F;
	Mon,  8 Sep 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346065; cv=fail; b=CacxDAo3oFyUkMRahhXtc0aHBm0ULKgSBILIVLEH5S1c4xmUuVzPGaKb8oQ9Z8qZIakJcZSXNQFLaPMUb4iyJUQIqBNrN6mJ3KST8/WpWSNkXrccdA8fWtf04brcWzOrVBgSUnC6zP4TUlFUZeiOYN2eK2kjsfCGaUk/DJIdedI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346065; c=relaxed/simple;
	bh=ymQ217BU5HEm9ECLPkGb3L54IORmhHE7/XgxC78aYtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LYdOgTYleDKsW9FJ16BFWNtblNOMS40OZKsySgMmJQ6np0MYAGgOjhme7oQe/CLaqFc+8G+Mkz7Jn/IdlF5Op41IukE2Z8HWVi+NIn5zpA44jmcpFCYI3ddBtcCfjzl/RlBKdLnQ1X4upCyXUo5lrtEcuDNIRvoay+cZ4wrL6ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=txSE5F+h; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFmhhG8E6ahs0a2FHKi0fze7bZVVHI3FDMGd2vf545DwowIR/JqMB+jrGGh6ehzsfckPDehuSyM6LqGjA9vAYtuClt/Ux9sMrN8sxykcfY/r5nAR0c8GFKj6q9nMnihcFF1jhApUEk3S8ItL5cGhHdipafMd5D9747LxrNWz4+nyt/SLklETCK+4HaN3pZGK/c9dIJ+2fks29vC8lwIrgPOFX7ke0NlrbCIOm+2JGN/0Oa2Dg3YXywQ9rCEX4c8Nct7FoW2E0cu+UjY1yTSx4KJzwY21NKg4dn5L++gT+4nsbXQ5HMf3G0X38R5Xoc6Nf+GmRouVodP+2ywxhwTo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltZ/XBpnOAbPuUdjRyLSYDxAA9zLYPaRGwehMCD6cYI=;
 b=gVBT3saEZTzwvPHaCow0SFOJ+mEuYQwcrgfzNeVggP8UUBaDFrS0pkbT2unxe//CCws4UTiQ9iSVdh/8x9TEL3bZQI+dQ+mT374OzFYg0CGfiZ3yMyCeY6OSv2iVloUNrTxPCutTjXhFvLO9kVhnx/ofOYchjOVv5aWQaGbEM7MUUALe8jNeyoXhK0IMmOL0YJvluf9uJtrYmx6hijh7BW1KQnyG2zKJDMCXFhCpjo8LZDc/i7Yyg6PsIvhW2Fy+N0W62Q+EErwJ51yaubQ2g6r0W7swWv1S5WhE4P49WZv6tjfiPp7mPiyiEXOyIIunr/qjwTqvJMOeoFaHrkqD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltZ/XBpnOAbPuUdjRyLSYDxAA9zLYPaRGwehMCD6cYI=;
 b=txSE5F+hMFyF/fTSMh0uNVdArVrFtfSgAY6T643SHqDyn1tlqZDQAp2OOZPjH3z5XBfKwObyTyygX05nQm/Qu6m282haPzrl2eDW+JQh6tq410cBWC9EEVBSoPU9LlPEGJO9NVRXoPGbmUgvfn9AHt1h0gw6UgXAK6X+Tt1HF9U=
Received: from CH2PR17CA0015.namprd17.prod.outlook.com (2603:10b6:610:53::25)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:40:58 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::1a) by CH2PR17CA0015.outlook.office365.com
 (2603:10b6:610:53::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:40:58 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:40:56 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:32 +0000
Subject: [PATCH v6 03/15] x86/mce: Define BSP-only SMCA init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-3-eef5d6c74b9c@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d55b2a-c17b-4e40-10f6-08ddeeee1b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2o4S1R0M2NSV0Irc3pmdUpqQm1IYndRaVUyUDVlTFNObHJxbS9pZ3NNNjhm?=
 =?utf-8?B?VzNpQWt2NjlQZktidTliL0pEZTFYcTh3NWpQS1d5b1NGQmY4dUM4S0NwTm0v?=
 =?utf-8?B?ZlhpUStNdWlsNnpicHdUK1JpelY1ZUFjU0g2N3dnQ1lmUmpKOFdmZGt0VkdK?=
 =?utf-8?B?K2JuOXF6ZUk3VEhidWY0cSs2RnFYbDZjM1Z0d3c4N1FGZ0hZTFJsQ1MvRDFH?=
 =?utf-8?B?ZVRuK2lSc0Ezck91Sks5OXRIdGdLZGVybGljdGRPa2grOUd1TnJyZ052OFJI?=
 =?utf-8?B?bWFpeFlYT2taRlo0YUI1QWF4N3FCcUd1VnhkL1VMbE5lcHorM1NEaGVTemo5?=
 =?utf-8?B?a1NzeG9WeUhyclpDdm5JaVVqM3Ixb3F5aUFjaG1lNmhKL2FWVkQxWGhhMnoy?=
 =?utf-8?B?MlNSa212TDFiYi9zSG9YOENHY1NmVjlQM2xVZ0hLcys3ZU1iNm5YR0FRZ2Nq?=
 =?utf-8?B?Tnk1UkhtWmlpdUhGV3ZkOEtpWUZDUUdhQW5rOTl2b3JIc1NTWjh2T3RGS3c5?=
 =?utf-8?B?ZVlFc2kxcHZHRlVnWTZUS280NlhBd1JoeUEraDBpaktoQUtuK2pmNmdoZ2N4?=
 =?utf-8?B?SWN3b3BXL2VCak84cHlYWWFQMTl6NmZJTEZFRStCcU5rcksvNFhTRUlWTVFR?=
 =?utf-8?B?bll6ekF6Qm8zMkk2S3loUXVKRHMveFpHQzNLOVByT3poS2JmWEV6b29KNVd5?=
 =?utf-8?B?NS9BOU5oa2NoZjYzZ3NrZHlURUxZb0VQZFFYWmtrRVRuSWxSOUhnU2tuYU1o?=
 =?utf-8?B?alNqWWw3S0poNDk4VG1FYlo3cWRmckFoOXZGWnFNZ2FtRXF4aDc2dFhsZHpv?=
 =?utf-8?B?ZW9LWUo2WTlDNmx4ZW9uQUJXQlF2b2JkNUphUWdwemx6NXJ0RlBlRllaYU5O?=
 =?utf-8?B?RFVNZTNjU2wzOGswN0VXY0Y0WGVtL2RLT3lTUVJQWlg2NFIxeW1aajUrMXNn?=
 =?utf-8?B?TWd3VEljMEEyeEhLWEpxMzlCQjZENFVtVW5KRTl4L09nMzExV1F1eDJTMWQ1?=
 =?utf-8?B?dWRnNGhwbVlNUDRQK25yUnptWWg3SWc1SmNHeFd4SjVtdHRyZzRiL1U2TjJN?=
 =?utf-8?B?VmpCVTEzUTZvTG4wVWpEK21jOEFPRzJaL1hWTXJhTTNpb1FmRlVxbzU2dnVF?=
 =?utf-8?B?NHdudVN6MDZVUDg4N1ZRblBuVGt5ZVRRNE1WQkd3QnBSWUhBZXhUZnlXOFF6?=
 =?utf-8?B?bElHRUk3bURWRTJHWEFtWmZxMWw2d2d4dENVOGd1RFYrVjE1SVlkd2dRR0Fs?=
 =?utf-8?B?UUFVR1pEdHhqTU9oNVNnL21COWR1UUd3T1pKTXl2UVc0NDZ5ZGhDalFHSzV2?=
 =?utf-8?B?WHY2Rmg2T1lWckJKMW0wU21welNoNGQvTXFyWitPbUc4NkVLb1RPaysyeFg1?=
 =?utf-8?B?ZjdsVEtnOHc2QkNPaE5KTGZOYTc5WWZGR0lTQmdsQWF6dUMwUVcxbkRzQ0Mv?=
 =?utf-8?B?SkdRbVErT0YzcXd0VDBsMUlGOFFoc0pZUDhGYXE1UkNqbnJiNHI1NCt2eExj?=
 =?utf-8?B?Tm9OVFpmeHZFVzBPZzQ5MjVOQnVjZlhSNEtDbXBDK1RVbGt5QkpBdDJZUW1E?=
 =?utf-8?B?WlQ2dFg5M0Jjb01SQkVDQjlMNlB3LzhkS2hoVGwrVWlLY1c3ZHZYaVhhaUlL?=
 =?utf-8?B?VVI1amFMVlgyUnFRbS9HUG94UE5Lem40UkhwZHppa0RyWXJjR2NpcVlDdFU3?=
 =?utf-8?B?OVp0eVg0cm5ERHZ3dzV1OE12RHZDa3cxc0tTWDdNeEhEOEY3SFNaWnpyVVJi?=
 =?utf-8?B?ald6TzJjWThZV1RDMXg4R0g3RDZsUGhiRGZ2RnBWcllmaXU0OFJUYWpDR1Vr?=
 =?utf-8?B?VVNNRmxoekcyeXVidWE1R0g0U1NyNk9BV1QySGRlSHU4M2t2T3JnenpvWmRJ?=
 =?utf-8?B?a1o3SVNhb2MrYUxuZFd4dmlLOXh5WXdKTHhjeXhCVjBLcDlueStVczNsL2hF?=
 =?utf-8?B?SXR5T3VxT1V5N2tET1ZBeVRjU0pnM1ROcTM5NmJNRGcra0xudTErM0JsL1F1?=
 =?utf-8?B?cTNGbVpzSVBUWmFQU3doZTE3aE5RcGJiQjNBNXVWQnVGR2VaaTFjL29KbVBS?=
 =?utf-8?Q?r2nrNZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:40:58.4184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d55b2a-c17b-4e40-10f6-08ddeeee1b56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464

Currently on AMD systems, MCA interrupt handler functions are set during
CPU init. However, the functions only need to be set once for the whole
system.

Assign the handlers only during BSP init. Do so only for SMCA systems to
maintain the old behavior for legacy systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250825-wip-mca-updates-v5-9-865768a2eef8@amd.com
    
    v5->v6:
    * No change.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * Change mce_smca_cpu_init() to smca_bsp_init().
    
    v2->v3:
    * No change.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c      | 6 ++++++
 arch/x86/kernel/cpu/mce/core.c     | 3 +++
 arch/x86/kernel/cpu/mce/internal.h | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 3c6c19eb0a18..7345e24bf658 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -684,6 +684,12 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		deferred_error_interrupt_enable(c);
 }
 
+void smca_bsp_init(void)
+{
+	mce_threshold_vector	  = amd_threshold_interrupt;
+	deferred_error_int_vector = amd_deferred_error_interrupt;
+}
+
 /*
  * DRAM ECC errors are reported in the Northbridge (bank 4) with
  * Extended Error Code 8.
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 79f3dd7f7851..a8cb7ff53e32 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2244,6 +2244,9 @@ void mca_bsp_init(struct cpuinfo_x86 *c)
 	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
 	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
 
+	if (mce_flags.smca)
+		smca_bsp_init();
+
 	rdmsrq(MSR_IA32_MCG_CAP, cap);
 
 	/* Use accurate RIP reporting if available. */
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 64ac25b95360..6cb2995f0ec1 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -294,12 +294,14 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 	m->addr &= GENMASK_ULL(55, lsb);
 }
 
+void smca_bsp_init(void);
 #else
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void smca_extract_err_addr(struct mce *m) { }
+static inline void smca_bsp_init(void) { }
 #endif
 
 #ifdef CONFIG_X86_ANCIENT_MCE

-- 
2.51.0


