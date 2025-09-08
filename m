Return-Path: <linux-edac+bounces-4746-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55F4B493D5
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCBD442865
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7730D30FC04;
	Mon,  8 Sep 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3DVT24aD"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D796230F541;
	Mon,  8 Sep 2025 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346065; cv=fail; b=Ns0Fq5g9MbDx8LBKpSaVAJ4VslyTq+2c9juKe+tiR3UYauzy5MRJPFi5WBD4qISTX5+rA4t0r0/sAZTWzcXHyvduiGLh7iB4JlD1D0ScitL8RFiJehwe7JX2ZqXuMUGZWwEPu3IP+f2CjTzydDp1pH/Fgqj1IHBmAFrxd6imwQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346065; c=relaxed/simple;
	bh=QM1ulJ7Gk21m4b0wW4JarumBF3+J7sVSJdv1XVx8V+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ErbNu7lM4cl7LY0SQsFx2p+bTCeSHwiubtbC0M0K3SrPjo1FJ4szaBlX8TaNDiLc2ptOBUpzxXvt1+1DzgJOLq6UnZgJWBlHwg92/YMmZ0wCw9pPW68gncSXmgyjlJzuQ+8oj+ob+gnoV0SwgOrWzK688Fq91sTpSmCVdeHGhsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3DVT24aD; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgYX9AIGO5ibIeepcwBiPs9toV2pH9uv2cqzRSc8rxR7rBxEKNr7vUOB/oaFauw8RbaG6TbvLGGkx8dIaJQFTKetGTehuk6gR6oZLYXkulugctvhE7HY1jfcHHr29pH4eE2F/wWUkSDEm5bXV8CpJSzQL2MLKHLqMklSzNcd3X/kF8ESbxipmjZXnVcF42r4rcJAdel3iTGdgxK3/0qSkqUQV0I0pZCkdxNLaX0Mh8gXYCFWKLn12nCAPOBk6xp797Zd3kF0BrwjEQVQ60Cnu4iBS8zEZsKyCMWZYoa8q86wCUU9bLWuzi88wLZwNsKOlheTc3Np/CKjq1YwYCAQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvkX+RTRcIKNKE/Aqq7vSDhRQJqehHe1s11xq3iCpBU=;
 b=Nl6Zm6RJ5IqHm0KjtnPXyjysApus4Af7qcD3L7KiyiWGEODkS+o2pVNvt0KbnfKHqoWpCl1EWJf38OxkMkLcvUDrFokdl2zYa0bDpgYfKcK44bO19aE4QkV9HLS6G6QgXi8eujZ/B2tgfKzKL71wcLYSKsXJCDc+Ggi5z3aDWp6ybwCKnm1ICCwzGUqchdvNANenbIynBRz6aNzINbpMtJ3/enlCAhxuu+g36l0yeMsZSbRyOmXBrynZVjtdzqn2bY2K7HaS+WJWGcxShreJYiJj2qLmyiOSzzrwJcYjFKL//bsy6c01t59cW+p9hb9Nw0LLafM/9UHncr1Ir7i01Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvkX+RTRcIKNKE/Aqq7vSDhRQJqehHe1s11xq3iCpBU=;
 b=3DVT24aDiXIK+uF0d5YQFopPVm8ZhpQ1uJgZ6zOUbR12/GD5Lsd3lYuoSOAU2EbjP1+IoJFsOXDAfEuGJ0lfuHhTeNCsi4CE16ITSLCGcYPavmH+9IdVCRw7s3cPqBG0h9YUjqgKO+VHl2/fyrBv1i6tnjVJNP6nYi3WToiWHo8=
Received: from CH2PR17CA0018.namprd17.prod.outlook.com (2603:10b6:610:53::28)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Mon, 8 Sep
 2025 15:41:01 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::a) by CH2PR17CA0018.outlook.office365.com
 (2603:10b6:610:53::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:41:01 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:40:58 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:36 +0000
Subject: [PATCH v6 07/15] x86/mce: Add clear_bank() helper
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-7-eef5d6c74b9c@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b5b0a1-872a-47d5-0f79-08ddeeee1cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1lnako1eFRWZldpRkY3QktvZHhvSDhZbGx5QWdaNG40UzRqaHFQNzNDcGNX?=
 =?utf-8?B?MmcvdktEK0lrUS9mQVhNSStQcm1Rbk0zdHBKVEl4dG9FMXNLalhOUU5OcTZC?=
 =?utf-8?B?dEpWaTB3Y1Z2ZDNPbzBXMVE2RmR1MzB3VmdFZkpsUFdZOVppVUVQcUFOZ1Y2?=
 =?utf-8?B?SjIrQ3ZtWVFRcWZ1VENDN0NDb2Nlc0dsVVZzTmhqQmhNTkkvTmxsQVhOdWkx?=
 =?utf-8?B?SnZGQWxzRktNckZaN2VkM1Vaei9sbXVieXZHZEVwc2Vwb2NWc05mMTZvWHRR?=
 =?utf-8?B?MEhMMFB2UWsxaTFuNG1vNWU5RHBEMjEzS2wwdGtjTGw3SFU5aHJySmNjS3Fw?=
 =?utf-8?B?WjI0bDk0SGhnWnpNa1ZBeEYzM3EzeE1jNTI2dDluZnRSM0REZzRWcDVxclhr?=
 =?utf-8?B?WXRvRHhqaWJCQ2plUTF3L3h1ZnFQYkhkYnhOUWNUWE9SZVpUemtZTlk3Rmkz?=
 =?utf-8?B?WDVtVkNOWlIyazFKYTMwSDBoNldlaUtUaGtXVVJqNXN5QTh0SHEvUEsrS1Zl?=
 =?utf-8?B?ZjY5b2h3V25HSEVKT1RNTk5BVnN3a0VVbDNPMEtUT2duTkFFZlhhMDNjWHhv?=
 =?utf-8?B?ejJWelVGaCtSbFVEOEpXaUhBQ3hhNFlzNytkQzJVMWwxb1ROOFU5RGYvZ3hM?=
 =?utf-8?B?T2Q2ZGNGRk5UQ3N1ZDNGMHRFeXNkRFJoTVd6cm1FL3VlOVo4bTFBbDNZbFBq?=
 =?utf-8?B?eTJJQXFGNGkxMTR0SytLZ3FoRjIrWGNMMm81WmpGN2FYNXJpSzRYdzY2eWQ3?=
 =?utf-8?B?YlNmcDdxcWdYUUZ6d0srdW9SZTZ4NWFOWS84VE1FeVZ5MkJuYWdrK0szN1dF?=
 =?utf-8?B?SWZCZjNkdktJYXh0eGFOaHhXaUovZzdmbTRieXErMnMvVWlzeFFaQkUyUnlv?=
 =?utf-8?B?OE16aUEvaVJVQzJZUk5jSG5TR25HcHh4MmQ1bzZGZWtiVXFsQUhnNnlpVTJa?=
 =?utf-8?B?OVFqQThGL2ZhUXlQK2NjRytxeEpUdzRmSldOMm0zVmVtbGdta3JNdVJ4L3Vm?=
 =?utf-8?B?QkZNVksvWFpwSStnRFJIa2lMdXhpYmEwWURteVltY2tSbXIwNEs3YUU3TWxZ?=
 =?utf-8?B?eXlWMzMrTUhqanJWRnFsbERibE5NbHc1ZW1TNFhYUnAxRnlNUUxuYS9Gd2Zh?=
 =?utf-8?B?MUNxaVlYOXpod3RWalpTeFFIZjN5Wkx6dzZNMi9MMWlGUldERVFQZ3VXV0dq?=
 =?utf-8?B?bzJEU0xVNE5yL2lPUHNORFl4N3g0aDZwRmlmNHpoZkg1R1VZWFhna3k4RkU0?=
 =?utf-8?B?bWNiSVd4d2FrNFJQd0c5SzRoeCtIbDZkaUwxOHdyUWVZSHBnV3NmcGhJQ3A2?=
 =?utf-8?B?YkR3RHl1S1lSQVUwVnJCZWx1QU1IWmx0NnFha2R3dnhuNjRWZWdadENzYnpN?=
 =?utf-8?B?N0tlZ0hPcVVXbWkxV1lHbFo3cVB1QjV2dzNUL2lSQzBMazcxNlN6UmJYN2lT?=
 =?utf-8?B?M3lvdTJ1L1k2ellGODVLVTJEZGlGbzNVOGNiK2hMM0JQbTNTb2pnYUZpMHdM?=
 =?utf-8?B?YWdpbXVwK2xlQTZFRkR3dExqSnMvYjNwcFEzZml6bndNR1RNZWduVnZQTjNy?=
 =?utf-8?B?eHhGWFVDOUVzeklLc1YxaFJEZHFxaUdjKytldnVxS2w5cEdGWTQwRzVKNk9O?=
 =?utf-8?B?c0hoY21YT3VVUzR3c2hMQ2NkTVkveXQvOGcxQTNKWTVIS3NlOUk2NzJFMmZY?=
 =?utf-8?B?Y1ovY2FKR0ExL2hpQzZVWnkvK24vOU5QaUZWYlpJRnRTeW0vbUY4OVpMa21M?=
 =?utf-8?B?ZVB4V0tVSm1YQ2Jjd1R4L1BMak5XTGozb280UitCRTJodHNrbDRqTUZ0RFln?=
 =?utf-8?B?UkpDT25zK0pCcjR1Qi9WSzFhRGp2SVVxV3VVcHI4NFRpbS9hOVVPdyt3OW9W?=
 =?utf-8?B?K3ZpQnh5a2R5ejRrcjdDWVBaNjBYVktRMmhza3FmanJoMjFCU3ZsOWI5TXN0?=
 =?utf-8?B?R0I5TjhlM1lKd0JXeHljTGhIL095RW9yWnlYeXJnZEdvd09zVHA2MTRjOUZP?=
 =?utf-8?B?SkNoRE1uSjlCL0VCaWQ4eVBtZnkrUmFrUVlxYmZNQnFHcnVLOVVmZjBWK1VF?=
 =?utf-8?Q?8Sc75w?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:41:01.1821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b5b0a1-872a-47d5-0f79-08ddeeee1cfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319

Add a helper at the end of the MCA polling function to collect vendor
and/or feature actions.

Start with a basic skeleton for now. Actions for AMD thresholding and
deferred errors will be added later.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250903094859.GGaLgPC_eWQgAqpHHb@fat_crate.local
    
    v5->v6:
    * New in v6.

 arch/x86/kernel/cpu/mce/amd.c      |  5 +++++
 arch/x86/kernel/cpu/mce/core.c     | 12 ++++++++++--
 arch/x86/kernel/cpu/mce/internal.h |  3 +++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index b8aed0ac765c..d6906442f49b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -955,6 +955,11 @@ static void amd_threshold_interrupt(void)
 	}
 }
 
+void amd_clear_bank(struct mce *m)
+{
+	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
+}
+
 /*
  * Sysfs Interface
  */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5dec0da6169e..06645f56b564 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -423,7 +423,7 @@ noinstr u64 mce_rdmsrq(u32 msr)
 	return EAX_EDX_VAL(val, low, high);
 }
 
-static noinstr void mce_wrmsrq(u32 msr, u64 v)
+noinstr void mce_wrmsrq(u32 msr, u64 v)
 {
 	u32 low, high;
 
@@ -760,6 +760,14 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
 	return true;
 }
 
+static void clear_bank(struct mce *m)
+{
+	if (m->cpuvendor == X86_VENDOR_AMD)
+		return amd_clear_bank(m);
+
+	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
+}
+
 /*
  * Poll for corrected events or events that happened before reset.
  * Those are just logged through /dev/mcelog.
@@ -834,7 +842,7 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		/*
 		 * Clear state for this bank.
 		 */
-		mce_wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
+		clear_bank(m);
 	}
 
 	/*
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 6cb2995f0ec1..b0e00ec5cc8c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -269,6 +269,7 @@ void mce_threshold_create_device(unsigned int cpu);
 void mce_threshold_remove_device(unsigned int cpu);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
+void amd_clear_bank(struct mce *m);
 
 /*
  * If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
@@ -300,6 +301,7 @@ static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
+static inline void amd_clear_bank(struct mce *m) { }
 static inline void smca_extract_err_addr(struct mce *m) { }
 static inline void smca_bsp_init(void) { }
 #endif
@@ -319,6 +321,7 @@ static __always_inline void winchip_machine_check(struct pt_regs *regs) {}
 #endif
 
 noinstr u64 mce_rdmsrq(u32 msr);
+noinstr void mce_wrmsrq(u32 msr, u64 v);
 
 static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
 {

-- 
2.51.0


