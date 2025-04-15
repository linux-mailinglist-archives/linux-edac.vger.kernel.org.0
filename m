Return-Path: <linux-edac+bounces-3549-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A86FA8A206
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2883BBAAD
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62F529E062;
	Tue, 15 Apr 2025 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bDo2jEEe"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC11229B77A;
	Tue, 15 Apr 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728921; cv=fail; b=nm6FUwAi7NIUIXc51nMFD8jmjwEGg7jxN6hEA9p1/hH/s3QkQ4dY7p5kZu5VrfjHmBo43ipJp5brtbf7Cu0WD3R+7ssH1Dkjsz9sSJomY9FvG+3PZJAuzpRlh6y2oiv9BHNzHGwkhmLC9j2vgx/fL1QRLbzgANe1P424hg1gmt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728921; c=relaxed/simple;
	bh=n7giUjo+4S/aUf2tjZNTrr0l3chVyNxhMGh5phJKFPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uvqBBhDN+U7jBNYTSTLZuweI24kEt9xgH0pnTcYVCerPLFqPbbaY54nOFknl6i0IJLHnuZ14g6BezMr6s0PN+m85OP6Nb+pUmKDQbLxGhl/mJtKoA1Qwe4n5DWsQAxAWl3KK56wlhqDJlNmgSyR1iapiqb9VUbgCxz1w+yvIEgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bDo2jEEe; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8mY6L6ZK2BD2mFdo0PAbtYcmXjckqBZAiPl2BGHoEpBHOL8F2BSN51jtk0mZ0gbcFhXTr0MoMDAWEvMiuZp25ZC5OXu6DeqmUVd8FjXShTXiVaKIj+Jb3PNvHawWJhmCNcii8dXdcsnK2OKOt6+oZWVllAW0/NW/p8RZH3LvcgDWsrrptr2z07qqhPqr+WHQNKtyO/gQJSdNtnP+yFT3ALcls3aGYX/b4l/17mdnPCqs8ZHQ686nKAWYlfnfTkJtuhR7KKBqsUfAchdb9l6EFJ5WFy7iRiEvUVHrG2Z5DzpHhn3X5V6XOGdpE/lvoJDcvXvVyLkwuqCM4Yd6fAZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvFU/bSzwisb3vVDeqlhri0SRPvvngja+LDFAMGtZBo=;
 b=qPFUYx4Xia4WGoyhAHGQD/9zIpD32y/S/P0aGhXa5mkXi6yed5byvQ4fdQu6O4ImFL46zTgRMemmX9Y8Qtp1ZwoqigAmqBzAuaaoHevuxyQiWKifDJJBEeekjSuXKHvoUGYQfzUMpdGXNx1wFSfBiufQLEwiSsAjkIqPoeVPLmOe9z5K43viBWP57c69MV1ZZWWBopaKZUmW9tGq+b2ReWr6soqtDdj9xLn9M4i2URVAp1reuxLZA1x7CKs7TFZxrKkSeiblE6QdhyPhpwWKYpgC76hKMrkZqnFM+8k6f/sfrpUZWQUuEVn7lYE7Z1qpGlleBAimFHd2LiTvQRVJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvFU/bSzwisb3vVDeqlhri0SRPvvngja+LDFAMGtZBo=;
 b=bDo2jEEe4xUQ+XdosffWTeQ8ubsxQ6eV8IvVn1nM1THXxBqfH9ab6aELuyrN20NdwbQkUwCSYnOPZhIuCafcwycCn0UWbbt6PlOfbG1OJorXA8453CQZzSX+DlctrImsxP9RGka4d/RoZSFGwCtPGpilChULHFfCNprsF6BrosQ=
Received: from CH0PR04CA0094.namprd04.prod.outlook.com (2603:10b6:610:75::9)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 14:55:14 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::3f) by CH0PR04CA0094.outlook.office365.com
 (2603:10b6:610:75::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 14:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:14 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:13 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:55:00 +0000
Subject: [PATCH v3 05/17] x86/mce: Cleanup bank processing on init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-5-8ffd9eb4aa56@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 346f6a5d-d486-4140-6a25-08dd7c2d8797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1BRY2YwbGFCT1krRUtSNEVQbmJlcnljSUZpV05mbnp1dEpScWlYWERGZVFE?=
 =?utf-8?B?cG1jS1huQkRZa2ZrWDMvWDRVckdtYTdSaWNDdHRvbWZXdU5TUjRxcStBcUVH?=
 =?utf-8?B?MHhqV1hxbm9XUXpSTmJOdUIzU2hGbW9zZGx3ZG1yZlVhTDNLSEZNWTNWUGdp?=
 =?utf-8?B?ZUlWZi9wbHFHRUNTTGk2UXNuRXhTS2s3L1dkemVKLzIyYm9GMTNzU0hUbXVS?=
 =?utf-8?B?RWlkTkc0bkhxSHdFeGZyN3NHVzVudWFMR3Zua2oyU2JTSUVrTHFCOVZWcUtZ?=
 =?utf-8?B?eEc5RDhYaG9IblMwdXRBdFM3VTlncXBJSU84U3h3WmtuZ2d4VWw1bWx2R0s3?=
 =?utf-8?B?ZWlXZFFWaFArVkpwRTRzMEw3NlBCT0ZjOWlZV21DTXF2U2xhRzJUckdMS3Vi?=
 =?utf-8?B?VEhHcG5NYVV5S2s0b3FrQUYzTzFuZlRvdThaUzF5K21qQmhlNkRBRHROTloz?=
 =?utf-8?B?Qk5xdmFUZ1B6MDhLeXZPNzl3UlZFWGVRanZ2Z1VlcHYreE9TT1Z4U2ZNcTlm?=
 =?utf-8?B?NE1ueXhCVzZUam9LQXdkbXYyMjFBS2lka1h1aHNGQ0xxQUNiKytFR1doM1Bz?=
 =?utf-8?B?dWRRc3Eyd0paWjVMeU9VZmNkM1oxNnM0VTIwc3hFNmhhYkk3RU9oRldlVEJC?=
 =?utf-8?B?czluU2RaQVptMENwWG1iMGVUdnBmbTBIclFPQ3I5RThneC9nd3FzRkpkNkg0?=
 =?utf-8?B?Qk8vek5aWjhOM3pGVXVadTBJSmFPMkwwZDBZNGczL01VcTJjdEdkcWwrNG1y?=
 =?utf-8?B?UWJtamtrYy9LM0g5STkvSWgvZTJPaGM1Y3hoVXNaM1hFaWNxakZrQVNCYlRp?=
 =?utf-8?B?aGZWRmRTWE42NmF6Yno0U0RyYmdxbWZvUEhUaS9WNytiandqOWdSK1JlM3BC?=
 =?utf-8?B?eVpwUE5sbGl5Y0xFc1g2cms4VlErS1M4TG9ZdU1QbkwrdXozRHluV2JJYUUy?=
 =?utf-8?B?bVRkdTBGUkJidEVTZVFlNmhhMzlZM2xzb2w0RVVlcHNtVThTaG81Skx5Z3Zj?=
 =?utf-8?B?L3l0ejRVenpHYzlldmJoYmE5aEN2NW5TclI0RmhXa0ZxZWQwYWJQWXhwWkl1?=
 =?utf-8?B?NUVYMXNIZS80d0c5YWt0bTRzWG9ReGMrNkQrN1VLRnJXdmprYUZwYXd1L2Jt?=
 =?utf-8?B?QWtadzBqNG53Qmw1QzVkTjVLbExPSjUvSjk2dlZWWWNBZTNjSDEwOE5LYTli?=
 =?utf-8?B?Qk8yMjVjeGhvd3U3RFVGbE9DakNscVF3ZDMwR2wwSHlvVWxFaHI1REh4aGVH?=
 =?utf-8?B?UzRJSmFSRjZXSE9malpGOGZNVjIxbXlKb3p1Y08rVGhXSkc2citGS2hWbElv?=
 =?utf-8?B?UnZZRkxyVERBb2lWSkhQMmJVMHlvZmRicS90VlBhd3lheVdTK2c5WWVWcDVE?=
 =?utf-8?B?enU5elJyZWl3eFNOTWZhc2NzSzBSbXlMMHUwSlFsbHgzNks3N3ZGQVk0YjJF?=
 =?utf-8?B?MTNXTlhYRmg2THlqMzh5clBsaWJXTWwzYWo2QkszejNRSmh5NmpNeVY0YVll?=
 =?utf-8?B?MHZJWlVOamNaeGNPbjdtSUx2RjQzQXdrVEZPZ1laTWRKTERWNFBnOTBrMW96?=
 =?utf-8?B?Y3U3ekxzK1RudTBaQzAxTG1rWTA3N2ZCVW4xTXVMMDZjNWZQaVJlZnkxSnN5?=
 =?utf-8?B?L0xGWWhjR3ZCZXh6bUxTbTlYNlVYSENiL1dtSDZjZ1VSakQwOUx2UEd4Yy9n?=
 =?utf-8?B?V3B1djVYRlZqZDFVcDRnbDY5RlpBUkNjeGJaZGpMV0tzSWR0YnJkT3M1MSt5?=
 =?utf-8?B?Q0RDQzMybnBGUXd6UnZpdjdxaHpLQmYxSGRZUkllWGE5dlAyMjIvaVRlSVNS?=
 =?utf-8?B?LytGZXpFRWZGaGM4L1V0bXlpbzNBU0lkU01JUHRzUmZKb0QvbUNiVTlrYnhv?=
 =?utf-8?B?NE5PMWNXSWY4Ym1XaWNEN1ZoTkZXV1VoWXVDUWFHKytwUmNwOWpVMHdWZk51?=
 =?utf-8?B?Z1B5ejljKzdmWDhUUGRiUk8rUCtOK0dLVk1VbDdlUXpNNmgxN3B0WlFVOFVP?=
 =?utf-8?B?K0FNL21VcHFORVlEQ0pudFNTdzJmeXYrbFh0VHJwVXJPUWE2dTVmYjUzWnp3?=
 =?utf-8?B?VkhjNXQzMVorSEpOZEhuQlhzUUMwelQ5M3g3UT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:14.6073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 346f6a5d-d486-4140-6a25-08dd7c2d8797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

From: Borislav Petkov <bp@suse.de>

Unify the bank preparation into __mcheck_cpu_init_clear_banks(), rename
that function to what it does now - prepares banks. Do this so that
generic and vendor banks init goes first so that settings done during
that init can take effect before the first bank polling takes place.

Move __mcheck_cpu_check_banks() into __mcheck_cpu_init_prepare_banks()
as it already loops over the banks.

The MCP_DONTLOG flag is no longer needed, since the MCA polling function
is now called only if boot-time logging should be done.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-5-3636547fe05f@amd.com
    
    v2->v3:
    * Update commit message.
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2, but based on old patch (see link).
    * Kept old tags for reference.

 arch/x86/include/asm/mce.h     |  3 +-
 arch/x86/kernel/cpu/mce/core.c | 63 ++++++++++++------------------------------
 2 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 752802bf966b..3224f3862dc8 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -290,8 +290,7 @@ DECLARE_PER_CPU(mce_banks_t, mce_poll_banks);
 enum mcp_flags {
 	MCP_TIMESTAMP	= BIT(0),	/* log time stamp */
 	MCP_UC		= BIT(1),	/* log uncorrected errors */
-	MCP_DONTLOG	= BIT(2),	/* only clear, don't log */
-	MCP_QUEUE_LOG	= BIT(3),	/* only queue to genpool */
+	MCP_QUEUE_LOG	= BIT(2),	/* only queue to genpool */
 };
 
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 72c2aa0809c0..ee801f8862d8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -807,9 +807,6 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		continue;
 
 log_it:
-		if (flags & MCP_DONTLOG)
-			goto clear_it;
-
 		mce_read_aux(&err, i);
 		m->severity = mce_severity(m, NULL, NULL, false);
 		/*
@@ -1807,7 +1804,7 @@ static void __mcheck_cpu_mce_banks_init(void)
 		/*
 		 * Init them all, __mcheck_cpu_apply_quirks() is going to apply
 		 * the required vendor quirks before
-		 * __mcheck_cpu_init_clear_banks() does the final bank setup.
+		 * __mcheck_cpu_init_prepare_banks() does the final bank setup.
 		 */
 		b->ctl = -1ULL;
 		b->init = true;
@@ -1846,21 +1843,8 @@ static void __mcheck_cpu_cap_init(void)
 
 static void __mcheck_cpu_init_generic(void)
 {
-	enum mcp_flags m_fl = 0;
-	mce_banks_t all_banks;
 	u64 cap;
 
-	if (!mca_cfg.bootlog)
-		m_fl = MCP_DONTLOG;
-
-	/*
-	 * Log the machine checks left over from the previous reset. Log them
-	 * only, do not start processing them. That will happen in mcheck_late_init()
-	 * when all consumers have been registered on the notifier chain.
-	 */
-	bitmap_fill(all_banks, MAX_NR_BANKS);
-	machine_check_poll(MCP_UC | MCP_QUEUE_LOG | m_fl, &all_banks);
-
 	cr4_set_bits(X86_CR4_MCE);
 
 	rdmsrq(MSR_IA32_MCG_CAP, cap);
@@ -1868,36 +1852,23 @@ static void __mcheck_cpu_init_generic(void)
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 }
 
-static void __mcheck_cpu_init_clear_banks(void)
+static void __mcheck_cpu_init_prepare_banks(void)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+	u64 msrval;
 	int i;
 
-	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
-		struct mce_bank *b = &mce_banks[i];
+	/*
+	 * Log the machine checks left over from the previous reset. Log them
+	 * only, do not start processing them. That will happen in mcheck_late_init()
+	 * when all consumers have been registered on the notifier chain.
+	 */
+	if (mca_cfg.bootlog) {
+		mce_banks_t all_banks;
 
-		if (!b->init)
-			continue;
-		wrmsrq(mca_msr_reg(i, MCA_CTL), b->ctl);
-		wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
+		bitmap_fill(all_banks, MAX_NR_BANKS);
+		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
 	}
-}
-
-/*
- * Do a final check to see if there are any unused/RAZ banks.
- *
- * This must be done after the banks have been initialized and any quirks have
- * been applied.
- *
- * Do not call this from any user-initiated flows, e.g. CPU hotplug or sysfs.
- * Otherwise, a user who disables a bank will not be able to re-enable it
- * without a system reboot.
- */
-static void __mcheck_cpu_check_banks(void)
-{
-	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-	u64 msrval;
-	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		struct mce_bank *b = &mce_banks[i];
@@ -1905,6 +1876,9 @@ static void __mcheck_cpu_check_banks(void)
 		if (!b->init)
 			continue;
 
+		wrmsrq(mca_msr_reg(i, MCA_CTL), b->ctl);
+		wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
+
 		rdmsrq(mca_msr_reg(i, MCA_CTL), msrval);
 		b->init = !!msrval;
 	}
@@ -2310,8 +2284,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 	__mcheck_cpu_init_early(c);
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
-	__mcheck_cpu_init_clear_banks();
-	__mcheck_cpu_check_banks();
+	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_setup_timer();
 }
 
@@ -2479,7 +2452,7 @@ static void mce_syscore_resume(void)
 {
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
-	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_init_prepare_banks();
 }
 
 static struct syscore_ops mce_syscore_ops = {
@@ -2497,7 +2470,7 @@ static void mce_cpu_restart(void *data)
 	if (!mce_available(raw_cpu_ptr(&cpu_info)))
 		return;
 	__mcheck_cpu_init_generic();
-	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_init_timer();
 }
 

-- 
2.49.0


