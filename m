Return-Path: <linux-edac+bounces-3559-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD84BA8A220
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0776A1900E4C
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1784829E042;
	Tue, 15 Apr 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p/k1CC/5"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0CA2BF3EB;
	Tue, 15 Apr 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728928; cv=fail; b=XdK0202RWgI+w61RNSG67jz676NCtBlF3khOf7+QU2dDFa89IOJfAW9l8CHtbhzZ0oKvU+YJpbu9lqgiMv0hFKGwSzNgALGz5rRJXncgQXZia3xf8qH9EVvBxHSImmhQpRT/8G7VgbHzZoAG25C6BGzKyJkgbdAgwOH9GCFQ7nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728928; c=relaxed/simple;
	bh=jEiAbxLNNaavVkpbE9OcX9nbZyfDajfiUisKs/v7bes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AM8i3rIV2GTIbgJL6U6d3sYDSyRq9C21+c2lcrfMk1h+cCasfBwk4Segn+aaVYb323VaKbJIoYdycspH9xgv0nNxLYGEWiYw0ar/wu3c9oPaqSd71jCleR2h/RgFtdapvfn47izWDTL88snTegmD8mmq4Z+019PO8MFn9ajIsCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p/k1CC/5; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOAZ8ZMG6X/EtEZOl7lY4HQLCaxt40MniZRxLwkHZtQ9h5ElRvhfJCCNr7n2vndDf4UY8mYd/DiwDGpMqFf/ycB+uxUnV9ODegpsgUueFf69AWsMyznDfm0N9ssksXWkRwrRijb0KVA2//Sse0sJeJW7LarC505/KOOCMtPxftKjBSKUGGkxUH0bzQ0ZZbhjcpHuBbO2/oBbiDkUMDSmEAdUBtBJdr8ld0OHR8WjQnpl8xIFapgt/wYghXAvnR9fbGe5dNwmvmQOQsByjxiGHf7+v6B/Zg3RlkKDt2rCwQu947lvtN+I6Ev8eQ/CnyKHfTLeSe6FBuj6mEWTS07img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JUy9/1esQvE+dsOXCusXiisL+ly9JTX3CKAaggYBTo=;
 b=lnnjxDJ6ftzgHnlMjHf4bZGwNSwFOJ9bFd9HsOO86R74wDAnRZA2ffb22avI8XRP1eiyqRA+vsND1jaQStP+V8gEYG7zUYN5LgePL1MeZsL45wESYbbm2spRIO1eABtaiCcmWEEfhR5gO8hse60TwdIYD3qUe4lzqrR58lqklE0yOmOf7fuXLH9rlYNj3Dkxus6uykVL+QkfoLPE+qehpGWkGMHJgVyzNQ544l91FRfYSbX8AhL/NwWsRSyOeavET1Q93oJPnGc+iOGJ93yokuwsXTzTD23YXsqrawB4tFTfId0efH9KJ9bpqY5LPHG0vr8SwDx8YkxY9Je9aD7LDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JUy9/1esQvE+dsOXCusXiisL+ly9JTX3CKAaggYBTo=;
 b=p/k1CC/5kaBLyxR0HUUgTjmetdo1ksinV47WdNgj7X9E6ja2CbAdN+ljzjyB597Kvjyu6EgeTkXF0odR7Q0TzvGTIHKbpRvPOWf0RAQRMM0JUZHVRN/sanm51GCqIrKtdJN3H6bjdhrV7uZgrapUnznUZaQLWoromqJODZq6taE=
Received: from CH0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:610:b2::11)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 14:55:17 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::de) by CH0PR13CA0036.outlook.office365.com
 (2603:10b6:610:b2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 14:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:16 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:14 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:55:03 +0000
Subject: [PATCH v3 08/17] x86/mce: Define BSP-only SMCA init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-8-8ffd9eb4aa56@amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
In-Reply-To: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b318ed9-6a74-4782-bced-08dd7c2d88af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEJ4OE1LWndhditkYm5CeVNYMnJ3S09HV3NUbUFRWGFWOEx0a3F6dmhMbFAy?=
 =?utf-8?B?akZzQURycVdWcEh6YThZenYxNEdyVk1rYWVsejd0RUZaRXNSWnoxN28ySVRB?=
 =?utf-8?B?dVMycVNjL3JxVnN2bmhpWjBGZ0gzNGJaUFJ6aFdySThRTzVRMXJvbG4zYWFM?=
 =?utf-8?B?TEhZZGwrbHc3RnJzMkxhUWxmUlNXRURvWTdJNWYxWHlPWHdsZ09vMWlZUW4y?=
 =?utf-8?B?b2RJS3QyVUhTNUllQmQ4aFZEU3hEQjFaeXpVOG90RUhLWThHVXB3ZEVHZTJ1?=
 =?utf-8?B?dEQxZUkyZFlSLzFCK1V4WE1MSWpUNzJFTDVNeGx2V3ZsdnhMUm53dDlNc3pl?=
 =?utf-8?B?MmRiTzF1aFRBeWFVcG5yUVhwaElCMG5kc2dMQVpnaDVtbDRreDE4blQrSDUw?=
 =?utf-8?B?QUp4eVV0VzZudkFBTHVMaUpPTnRFRldpMTIrM0xORENWdnN6V21WT0pvNElU?=
 =?utf-8?B?ejU3dEFGbm52aXM5RTdpVkhUNXcyNDIvbzFKb0pBVGUwbzBYMitpTDIzRmNl?=
 =?utf-8?B?NzRCQndnQzdEQ3BzM2U5R0hZUGdQZk16b0ljaHZNVzRnU0VYcUlKM1piTjUr?=
 =?utf-8?B?d3RQZHZhcXBzc0M5QUloQWV4blNaSmhINW1MMUw1d3I5TXU1NHM3VCtYRURy?=
 =?utf-8?B?ek96N1hsRlRadHNPVG44UmhNaVpiWFU1Vys0V2hpK3ZETkErc1k3RDNrMVFq?=
 =?utf-8?B?ZmZ0RDNzZlRjUkdvQy9JQ2tjV0cxM0pYSjBicVJ0TTdBMUYvZk4zMXg5Y0hJ?=
 =?utf-8?B?R1AwaHVNWnNkZGZCektoQ2hxQWNQSkZaYmlMeEhrR253RjJKR2NmYnNzZlRI?=
 =?utf-8?B?czVSS2VScnQ2blpQYmdiUWZhK2d0YnppRy8rSUJrR3ZUSUxqbXpnZVNST3Vx?=
 =?utf-8?B?TFRUSmZoSVVFTndYeHo0WGlMMUxGWUtmcE0ray9MbUVRdVNEQmZCaGtZUnhj?=
 =?utf-8?B?RTBBb05BTFArdHNyT3pOOG5YSlZTSmdzL2loUldRSVczbEtnaWx6SVNOWTZL?=
 =?utf-8?B?Ykw1MkRHMnR4RWVySytNWEVQSVp0VXVmcW9CU2hTdmc0aWVTRmwwazRYU25C?=
 =?utf-8?B?cWxrSG5TQ01Hd2s5Y1crd0ZVYk53WmVqait2Ly9lYUkyMUltY3RKaGJ2SEdy?=
 =?utf-8?B?RFBqbGkxc3lzdHJrTmRiSnRvMmlMZkwzYTByN1JPK1VVdWdvN215VU4rZkxi?=
 =?utf-8?B?emZPY1JDQkljK2t1YnFGQWx4MWtlcythODViaWlQREphYXpDUjh0cXN6V1FJ?=
 =?utf-8?B?a0J2ZjJaaTU1bHZwQmtWT3JGdnFFcktkaExKcXU1bTVMV1N4OC9SR2EvYkln?=
 =?utf-8?B?YXdLbFkvNjFvQUt1UExHeDd0VXZaMW02dWg1cFpkeFVxVGUwd3JUaUdiUjFq?=
 =?utf-8?B?UzFMSEtYS2I0MmtlNGlnWWErTlBmdTdUcEV0ZVRpNzN0L05TbmJZdkZ6eWNY?=
 =?utf-8?B?d3RSSjNPa0YyWHFQejdxK3h0Z3FpVE1ta2V6Ny9yaWNHK2Jsb3dQdldEOCtH?=
 =?utf-8?B?N2V3MUVMV1J5YjFuWno2Z0NtcHN5TFV5YkJvdTVaZlg1ajB1amQzZFFkWEtG?=
 =?utf-8?B?SHFqaWF2L2ZMaFlJa1UrejNmVVNZaTQ0R1V1MzFBRk9XWGU2WTNXc25URTN2?=
 =?utf-8?B?a2IrUWxyL25halJtYXdYWm15bUtrOUxlYnpla3B6SlpXQmMyOHBKWUNtYVdi?=
 =?utf-8?B?K2dROG9ueGtOck5pSVB5bldybHFhN0ZEVWpIbFBJMVhqckJWdkNrcWhDdFFh?=
 =?utf-8?B?MDlxQWhSM2F4N2w1dDNudWw1QXp5NHYycVRLRTZXMy9BTkloQ3VDMFNuUnMy?=
 =?utf-8?B?ZGtrT3B4WVA5Tm5tOWZXY2VWRTdUUnR0K0hlSUw4L2VhS2xGdkxFL01jaDJj?=
 =?utf-8?B?NmsrbmthQ2xBZkc1V29vaTNmSUdDRXp5MWRqWGZUZjc3Y2dldVFYTS80U2Qy?=
 =?utf-8?B?aHZaazc4OG1NaWxqSkEzbUNPTTB1RVdhek9tcW8vOWFuK2NsNGxWT1JaMmFE?=
 =?utf-8?B?bVpwMmRQclppNEhHd2hiRXZyV1hrS3dGd2RrT0xjNEM1SWZpeExXbU94UGVv?=
 =?utf-8?Q?/h4/fH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:16.4444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b318ed9-6a74-4782-bced-08dd7c2d88af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778

Currently on AMD systems, MCA interrupt handler functions are set during
CPU init. However, the functions only need to be set once for the whole
system.

Assign the handlers only during BSP init. Do so only for SMCA systems to
maintain the old behavior for legacy systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-8-3636547fe05f@amd.com
    
    v2->v3:
    * No change.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c      | 6 ++++++
 arch/x86/kernel/cpu/mce/core.c     | 3 +++
 arch/x86/kernel/cpu/mce/internal.h | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 206973d7dbcc..0d84b171b851 100644
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
index d0a29e22cab0..444d006366fd 100644
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
index 64ac25b95360..87b69935d57d 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -294,12 +294,14 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 	m->addr &= GENMASK_ULL(55, lsb);
 }
 
+void mce_smca_cpu_init(void);
 #else
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void smca_extract_err_addr(struct mce *m) { }
+static inline void mce_smca_cpu_init(void) {}
 #endif
 
 #ifdef CONFIG_X86_ANCIENT_MCE

-- 
2.49.0


