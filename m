Return-Path: <linux-edac+bounces-3068-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11671A34AD9
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BBC1752DE
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC1A245AED;
	Thu, 13 Feb 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rK76SorC"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D55245007;
	Thu, 13 Feb 2025 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465200; cv=fail; b=TT5JwcqKD4UU3WmTyC+hyEM8jP19XVsFPYZUL7f7505vSLVp5Yg2fBFNyONRBVjhWRvMDc87auapk8XBk8Iu9C1fYOWu311UDdsWdk+7P0DAfNasy1t3wVbOKVHJz28yjeH12zLzkwkVwH/1lyTszQW4aiZLzBHRanr5jGR7EqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465200; c=relaxed/simple;
	bh=E8XewbvSwpflzFnxlIW6n3i0hzVm5R30KSj7KbhBB88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aQgBnEdzQszqrOyysT5IkPSodX3Bj+W9PwuYaVrlxUrjfLon21Hjukac7VVgejY1t6/Gi7HizR1WRJXc84MOuyp90U8oQwSHKnYT9sgbuW41UcXZgITXzQ57MVZSxuaXjU7yq2c33ZHh/mADa89BJDgfbaVR/WC3bFUgr+WFcOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rK76SorC; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1JnrKVVrE8m4yjt433norUogL31Eyi2/AQGX5b3ZlGlKIn7xMLdIGshHR++yH5SCvq3vOPYR/6CoqHfrsyGNH/T9xCiBC720k7OvC8c3vVaXvaVF5JPhCWGrsTCWV3D13gRhrk8+97PfFDg71BlKk4nzz0vkSd7ZazSwx5BxzK61MFND1GIoHyXlbJ+VMXakMS8PUTwSFQEztIo2rocuzxf0wCZ0TwzF/5SWtXJ37SNy7Nh0bEZREbU2rOvhuUi/sYERZ7CD9ew7XeTuULKEtAafOwRfTyDHIX+raa/PDLvIfvlPWMC4lk6ew7faGCGcOYF4c5SChwDyuwvT3z+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2KfDR94+kX7cHHfHeloLUENsMoJGqbXponq/BC4ZvQ=;
 b=gB7YrbQz7cr0kK5cOWUUypulGFl36kH7O4+LdSeDXszb9SnEhzsrMZkpG4/nXvjPZ5XnDDgDDs0loaIANg638M8R+UgYxrEBz0Fcz/Firpc5kYGc8kRbar0O3cIP2yxSzJgxXRafp5Tyinkzo78zkFftWCiPvJi7Xp5SPTeY7WvBKy3pLMgyVlKZol6xEaHa/IaDQa3uM15nY+q07CG57B80/UtqmfwsUVXZk8iYjxeo1CJTCuFOlH5GR2fnD+myMQwKY9ROgMwO5irjBkk0hhg8Bktha0d3lGPR2v+7pKisB4w/yaFZSidPeOXSqIxupOmbztpQuRdJwNvHodBwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2KfDR94+kX7cHHfHeloLUENsMoJGqbXponq/BC4ZvQ=;
 b=rK76SorCLQuxsoNhfFNT3HCoXOpIk1G/HKGE8eKFbc9oE4cnbSucp9Ql6jgcOTq0LQ2Om4K6Fx6StyPpgM+I5Gbtdgc8ZnRLqfYa1o7NoKxCCqh8+rssusu93OSQN0OhJBg1Ien+xgYcimnABZZaAo4xF1q8OzbgzM5Re3M7Pb0=
Received: from DM6PR11CA0031.namprd11.prod.outlook.com (2603:10b6:5:190::44)
 by MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 16:46:30 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::74) by DM6PR11CA0031.outlook.office365.com
 (2603:10b6:5:190::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 16:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:30 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:27 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:45:57 +0000
Subject: [PATCH v2 08/16] x86/mce: Define BSP-only SMCA init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-8-3636547fe05f@amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-e27d6
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 855552c7-ccfe-458b-1b4e-08dd4c4df79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXZuRm1neUpsaU1NR2tUemdYVkxiWDlZaHgwVGlYNmJVZjhmaTB4d3ArNlFs?=
 =?utf-8?B?bFREM21mVW9LRzYrNWlkT3ArREt1cnE2TzdmQk1HZHJPRmdiVnMwNmRYVUc2?=
 =?utf-8?B?eEhja3U3c2I0SU9QQTZKOXlld1FyREc0ekY4a3dBSDNvbE9OTVoxK214RWJM?=
 =?utf-8?B?cHI3Ny95dmlOZVBCQlBPaVZ5YWhIZHU1WXpRcTNkelhsQjhsYWlKLzNoeWZm?=
 =?utf-8?B?aVpNbFUyZElFbGFERE5ESDRpUWdvTG9Oek81cFpKMXJEdVJCenRDUEE4R2Fv?=
 =?utf-8?B?cmVOUDdnME5wNFNDZU80MFM2TkY5d2ZIaFcvcmJuam1FNHh2T1RUaEZEN0pT?=
 =?utf-8?B?SW5yRlJWbVFhSEhzN09aZ0krUnNRR3Ard0lnVE5vd2dDMHora1BXYVVINzdO?=
 =?utf-8?B?c2tsTnhBVUhiSHVuUlVpMEtvYUhEdmlVT1EybEl4Y1VIcTAvYTdMOUw5ajZo?=
 =?utf-8?B?SGtrMEFZRzRERjBtbXVaU2poZFdtWkJXTnBicTlZNHJlWUxQWlMyT1RZUzRY?=
 =?utf-8?B?YkRBMGZUOUhmT29VMVFCV3dxM1lsNGswd3dRQ21yaTR5a3hsaUNncVZpWkpk?=
 =?utf-8?B?OXJENmwxS3Irdk1UYzVqUkFnTEJucW9IRllRZVFhOGsvcnd4YmtNV0l2NFk2?=
 =?utf-8?B?bGVneU9aeTVpYU93QnY2bnZxS0VGc3g3ZFUxY3pXaStsM24zNG1iRWxtbEsr?=
 =?utf-8?B?S2N2UDNESEFDVGxxM0lzVUpRNlJDRnpFME85a3c3eVRwVGZVVitaTGUyNThS?=
 =?utf-8?B?akRRWDUrUEZ4RVBRaVFrZVg5dkxmSlJCajRaQVlQNC83WEllUElKN0QzVEpT?=
 =?utf-8?B?anZ3UmZQL096d09nSzM3SC9mZWlwTU1RWHJrQTJIS3R1T1kwdjJJRm5KODdM?=
 =?utf-8?B?dURONHo2NVNXak9sNkIrUWEzMTlJM1BWTWc4bDF4N3p5bGR2NVJpb1RLWlBx?=
 =?utf-8?B?OWZRTVhFVG14MGpJRVVnZjRIZnFVK3JDeEg4cjNqbURvQisvZ3pVSExaM1h6?=
 =?utf-8?B?UXVybURvVGtkckRsbVpVY053eEZlS2tEcmk3bVJmLzVXejVwV3lGcXVESnR3?=
 =?utf-8?B?NDhJTnZjTkJOek0zMitQb0JoOUxWWTMxajkyK3NMcXlrS29SUGRPek10b1ZU?=
 =?utf-8?B?YjVzL0ZRdWlzVkpYTW5ldFVranZpVlJGMVlERjFGQnNDUk1QbS9lSm0rb01Z?=
 =?utf-8?B?bkcrMVJnYkpOaEVVZXR6ZExNdUtFTHhsWjVrNXh1RlFyK3VvTzhsdnBWSzJ4?=
 =?utf-8?B?L0tDTkp3Tndsc2dLNVBzNng3MHA1N2kwU0k5bHNMSFowUFdmN2x4REgrNHcz?=
 =?utf-8?B?anJJRWtqcW5sN0MwM1dVS2hWOTBmMVRTRUtLSjd3TEhxSWRzbDJLcUFTd1BG?=
 =?utf-8?B?NTdRVXRQOVJCWG5Yc0VHclJqYnM2dUJ6UmVHclgrTHJIczFNT2dSQ1VyTVJj?=
 =?utf-8?B?YU9ySHJoOG1BVEJYQ0RlcW16bmkyKzlnYXpwMi9hakJqSWRpYWVKVGNIRDha?=
 =?utf-8?B?U2RqQkFXb3NablFvSFRWM0NkaFNUWnJwVWRHVGJwVEh5SVhIbGxqWnJKa2VF?=
 =?utf-8?B?L2tCRkhWV1RWMTNHaHM0RjdjdnQzS0NZL3RhSW94bC9kZEI4SVB2QXVHM0NV?=
 =?utf-8?B?UnhycFpKQlhtd0hCelFxYU9LR2FzTDVVdzNtY093Uk5OZDR0N0lVMVowand3?=
 =?utf-8?B?eGQvMG1yN1E2TDNVdDROMUlwRkdadkdUTGZwVS9uZzFQSHVDV09ENzk5ZXdo?=
 =?utf-8?B?aEdXajZIeU8yTGtIakpYazJwNmlDazZZd0p5ZUE5ajJkRWVaUEZQYnFxYkhS?=
 =?utf-8?B?QlJMdUR3THdQTEV3M3BQNlVZR0c3Z0xTUFM0bElvNzFTejZ5bVNjcVUvajhx?=
 =?utf-8?B?ZVd4aW1UcldyeS9BYmtkdkFscXhudk9GU0hNeGpoU2kxZnpiYXNlK1dSekVV?=
 =?utf-8?B?b0s5Mm9KS1BHTms2QkpEUmI1Y0tTaE9wWDhQdDM5MlNERnJvc0xJQ1Y4K0lB?=
 =?utf-8?Q?KedTVa40niljfph95C196H7TBQ5RkU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:30.5911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 855552c7-ccfe-458b-1b4e-08dd4c4df79e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117

Currently on AMD systems, MCA interrupt handler functions are set during
CPU init. However, the functions only need to be set once for the whole
system.

Assign the handlers only during BSP init. Do so only for SMCA systems to
maintain the old behavior for legacy systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20240604154635.GTZl8222q7WAEVSJKH@fat_crate.local
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c      | 6 ++++++
 arch/x86/kernel/cpu/mce/core.c     | 3 +++
 arch/x86/kernel/cpu/mce/internal.h | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index a4ef4ff1a7ff..bf2b1dc5aaa9 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -687,6 +687,12 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		deferred_error_interrupt_enable(c);
 }
 
+void mce_smca_cpu_init(void)
+{
+	mce_threshold_vector	  = amd_threshold_interrupt;
+	deferred_error_int_vector = amd_deferred_error_interrupt;
+}
+
 /*
  * DRAM ECC errors are reported in the Northbridge (bank 4) with
  * Extended Error Code 8.
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f13d3f7ca56e..402d7993eb96 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2243,6 +2243,9 @@ void cpu_mca_init(struct cpuinfo_x86 *c)
 	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
 	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
 
+	if (mce_flags.smca)
+		mce_smca_cpu_init();
+
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
 
 	/* Use accurate RIP reporting if available. */
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 231ba8ca4a3e..a4bae8c0cf4c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -293,11 +293,13 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 	m->addr &= GENMASK_ULL(55, lsb);
 }
 
+void mce_smca_cpu_init(void);
 #else
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void smca_extract_err_addr(struct mce *m) { }
+static inline void mce_smca_cpu_init(void) {}
 #endif
 
 #ifdef CONFIG_X86_ANCIENT_MCE

-- 
2.43.0


