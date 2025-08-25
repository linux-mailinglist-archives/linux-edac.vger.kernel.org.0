Return-Path: <linux-edac+bounces-4661-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71CEB348C1
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216785E531A
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813D2307AF8;
	Mon, 25 Aug 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ykqOL5Bi"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454B30748E;
	Mon, 25 Aug 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143229; cv=fail; b=Tbg3PiIJh+lSciEaR8XABXJQNBIPKGGRo47EN85zAM/qyZ/Q0PFmoyOVt5WH//vqka7hImyQFSKss9LeRqCFaLCkzH3YNSnGj/QjMZb8TDZPhhZMXfdV2lAwr1Vpy/4ocRri6VggbV96PhqIts27hJgQNFaQl40g74ZFx63Swk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143229; c=relaxed/simple;
	bh=LUo3e5vIFTUc7ojHrrgDLZzQ69UoOy2bZvGjlUISq58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=C4s8lDAIDbMP0TYJ7P8q2LlF3H/dEjz1xfBCQyBU7+De8AoB/84KacpcRUy/F9lICYk8peFaAgqAvUI81zS0ZNUbVwheNf1TtQdvlUCZwS6lcJhR6jxg4ad1q+P0/f3nc52j9JqtqH3i61+1e0TmH1y+56SMCm/CGiu4d5B7sI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ykqOL5Bi; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeeg/NBrYIW5jkwOImPcgaLlGbX2xs3aWKNQRgsaucDwh0PtINa8qsoQMrqXVe5IseteRJHv6C4XrbTg2/686CyFqARfbb0oIgobQLHumRXmQB3UV8rGJTCjuTazahSmIshIlqdm87HYFoEXLwE3xZN39dK1T2nYOYcxHjnd69I2BZZIWJeyGCwMBnIaZl2z99PDMpGqkFs+YzpRKBfYR8GkmPbrw5tfvUAOqMcKkH1OxiL5tzSmlabiT5zJLS9AvSBM5Y47pwOK8ieZO9elRSWTCWQEgrXYVy0kBT9TiOVzYSoaLZ111h1uQteGmXPiTr81PSqpQzgB38ptKCQB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5FPuPnSpExTj3Z886hf3Or8YI589t6WXUl8WXYufro=;
 b=Qql2YtC7wq7ea/FmJZ8oiGzTjRjEW8iAZP6muMrDl86GQtkFLYA4CEy/oh/awsrO3YqcXXR7lXGnPkv+uIYR1NVC5y2grSa9eXEU/9T2mWiotMRBwHtnjojZr3r9t57VFQAMzmT9LmFOpgNnRFw4SsAOd9FMzYCVn0IywHIyEpmNkWwQ0QtnFdj+R9f4nt3xaGrdgNqKtlrnRfp1hrnrTLxysFFzt5dVv3EqTec5ZILKT+FyQqXVMKHjEVg8g/tEXcVtbUh9i5/eTmI4AT3rdTcErB5YxEGfPKCWSNw6fTOzn5zEcpD0+kD3ZeNjhcX6OJCUT/zZtjbd+FEOoDen6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5FPuPnSpExTj3Z886hf3Or8YI589t6WXUl8WXYufro=;
 b=ykqOL5BiOoh4ppGcbCZ5ed8eRQQP/5QfLWQH8HUm8VEZ4doza2CFQ79/sC+iBtPglgS5sCfEktcrcCpkXkh66MQMW4OSkvieRsgNCY7uZxYz8P85GZgC/rCXU+MJFa0lAT5xHu5w0Gw18QNMqPXKxH3Izo66uBsopFNNKTuITug=
Received: from SN7PR04CA0045.namprd04.prod.outlook.com (2603:10b6:806:120::20)
 by CH1PPFF5B95D789.namprd12.prod.outlook.com (2603:10b6:61f:fc00::62a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 25 Aug
 2025 17:33:45 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::dd) by SN7PR04CA0045.outlook.office365.com
 (2603:10b6:806:120::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:44 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:38 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:02 +0000
Subject: [PATCH v5 05/20] x86/mce: Cleanup bank processing on init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-5-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CH1PPFF5B95D789:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c8f79d-7eb0-4702-a729-08dde3fd8a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVYxVzREbE9aZWF2NzJNWTJ4eFVoQ2svQ21veTdjdGg4VEhTUUMrSDk0a2tn?=
 =?utf-8?B?Tm9yczZ2TDlCK1BhYWJLWE5vTXFFa01naXhiMllCdENET2o5YmxHTVAxdXlK?=
 =?utf-8?B?R1VuL0l4WHh1dWZiV3pDSlJBZHU2bHRqOWpLZHYxbHdSVU5FRHJDTXhLOGRV?=
 =?utf-8?B?Yjlxckppd1Z0MzRHNTBMWjlVV2s0aXQxaVZESDZEcEsxQjNQUUkvOG9VSWU4?=
 =?utf-8?B?c0FLTzErUkNpU1RGL3p0bXhaRC9FdkZ6d3UwOGxkOWFqc1hZRHFwYnBZTjln?=
 =?utf-8?B?eGpFcitqY0ZBenhpVmJZRFpCM2JjYlF0bFdCei8zWGluNlRTcW95WWp6UDgv?=
 =?utf-8?B?dWlZMEg5REptV0I1OG1YcmdyUGR6WFBteDJVUHRoTHZ2S2RMOHZqUjZEMUN5?=
 =?utf-8?B?cWRGY0t5M0U5Zm1WQzFhSjd2YXY0V1VPSGV4eEVNR3ZqTGVIaU4zM3YvNTV4?=
 =?utf-8?B?TFYrV24yRld5NCtZZkZKN3EwTlhvSzFuY2c2WFppNk5qU2tSUmZCVENnN0lW?=
 =?utf-8?B?RUpzQXRETGgxaGJiWmQ0WDY3b000QWlsamZ0ZUF3ZWxJbnMyM1RPaElkKys5?=
 =?utf-8?B?M25uWUFKUWFhc2xrSXpKbU84Z1pkWEw5TU9XdGFVOG5pdjBTSVZJbmg0OGdt?=
 =?utf-8?B?b3drdmpUL0w3N3hHQlVsWUFnVGVoeGZDU3RmNFRqKytnZlJCUjNZelZrMFFj?=
 =?utf-8?B?VHMvNEM1R3BvUnB2WnRZTjVVQUhHQW5RMm90eEhpc0tNVE9HWllqRk1YeEk3?=
 =?utf-8?B?YTRVeU5keGVERUl2RjlGM3gzRXgzRG1raWt0UUVSVHpMbXhxNUExL29rL3NF?=
 =?utf-8?B?K3hjZDdOamNMNVZRZmsrRjNXbnJZZGNPZnhGVnE0RzlscjBicnRXWERPRjhF?=
 =?utf-8?B?L1NUcFlwV1BJZzV0enlPUkRuRTgvNFppa0ltSXFob0pTSHZFMGlSdFByZkVu?=
 =?utf-8?B?Wlc1a0dKZGFvV1dHUHRIc1lJWFpNb2VnZGpnWmJIcFdIc2hTTUxPdW82SHVG?=
 =?utf-8?B?NXdCeE85Y2NjQ2d1aFRGUUkyOEtsbDZCdXhJUzdYMG1USVgwdVVoSW5udmdJ?=
 =?utf-8?B?eHA2N1hpUWRXNThZUzBUMEgxc041dkNwNzBtMGNYOUNOY1JZbjhKVEoydVRh?=
 =?utf-8?B?UXhEdE5ibkM2bmF5LzMvNzBmMmVGTWtIRHhBTjV0MWk3Q3VMVW5jajdBVDFF?=
 =?utf-8?B?ZzNSV1I3UlJsaXlHQW1GMGV6cVJpRmp3NkZlRzJnVW9ZZFpsQnhNOTNCNWdy?=
 =?utf-8?B?VzBIdjdVOTV4QlZ6NVNQdTlHcHdPQmF3QkJYMG5IZzY2LzEzMzRmVkxlNXZw?=
 =?utf-8?B?U0ZsWkNpdTJuUGJxYW5UaEc4SU05U0RabUtlMldzZkxCWTlWMXY1UitmVk5Q?=
 =?utf-8?B?UWpGNDNLZU5oNXV3RE1ETFVXd3pIWDJTU3ZYdHk3YnpRVzNZcDltZkpvUExu?=
 =?utf-8?B?djZVZFVPTnlGa2lMWGZqVnd2TCtxRXBYWldOVzhpTGR6WmRVWnkxN3UxVmZ2?=
 =?utf-8?B?aFBjQWFqelg2NG01K0tmTVlMaTd2cW5MQmVlanE4MlFtMkIvdVlMZXdRenhI?=
 =?utf-8?B?YS8vUzRMVU5oNUVOQU1EbjRoQmV5NUNnaERzVEFiVlgzRmd3cFNWckk4TXdq?=
 =?utf-8?B?QjJCdFFUODhJY3NHRTR6NzZvMHVkNDdidFFMcndTcUNTTktNRnpPNktaTmE1?=
 =?utf-8?B?ellJbk1EYklSa1RtQVQ0MjNqQmYyVXRuRHV0TEJWR2lZcXpBTW5oM25TNVE4?=
 =?utf-8?B?ZUJpQlZsb0lwMmY2d1Y5SEQ1VUZpdnJzQnF5c1JQNnNEOXVLaWxMbFRNL1NL?=
 =?utf-8?B?TUh3VW8vYTMwYzUzd3czSEJ0R0hGUm04azdjSW5DaVlpM210dDJTRHVQMVNq?=
 =?utf-8?B?dzZodGZ3UGFJMUNHeDlYWVU2VlZMaElZT0piN0dCSm9WSFltSitIRGUxUUpp?=
 =?utf-8?B?L09CaVJxUFlvT0x3aGhWKzJ2WG81akZJRUdlWU9PbnVWN1BGek9teUpKTm43?=
 =?utf-8?B?S3J1eFJEUm1pOFRpUXY1VnV4aTFyTzNCN3hxR1BURjJ6bHJhdGVDaGM0ZGxH?=
 =?utf-8?Q?doGDj/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:44.2068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c8f79d-7eb0-4702-a729-08dde3fd8a48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF5B95D789

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
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-9-236dd74f645f@amd.com
    
    v4->v5:
    * No change.
    
    v3->v4:
    * No change.
    
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
index 4da4eab56c81..311876e3f3f4 100644
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
@@ -1812,7 +1809,7 @@ static void __mcheck_cpu_mce_banks_init(void)
 		/*
 		 * Init them all, __mcheck_cpu_apply_quirks() is going to apply
 		 * the required vendor quirks before
-		 * __mcheck_cpu_init_clear_banks() does the final bank setup.
+		 * __mcheck_cpu_init_prepare_banks() does the final bank setup.
 		 */
 		b->ctl = -1ULL;
 		b->init = true;
@@ -1851,21 +1848,8 @@ static void __mcheck_cpu_cap_init(void)
 
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
@@ -1873,36 +1857,23 @@ static void __mcheck_cpu_init_generic(void)
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
@@ -1910,6 +1881,9 @@ static void __mcheck_cpu_check_banks(void)
 		if (!b->init)
 			continue;
 
+		wrmsrq(mca_msr_reg(i, MCA_CTL), b->ctl);
+		wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
+
 		rdmsrq(mca_msr_reg(i, MCA_CTL), msrval);
 		b->init = !!msrval;
 	}
@@ -2314,8 +2288,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 	__mcheck_cpu_init_early(c);
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
-	__mcheck_cpu_init_clear_banks();
-	__mcheck_cpu_check_banks();
+	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_setup_timer();
 }
 
@@ -2483,7 +2456,7 @@ static void mce_syscore_resume(void)
 {
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
-	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_init_prepare_banks();
 }
 
 static struct syscore_ops mce_syscore_ops = {
@@ -2501,7 +2474,7 @@ static void mce_cpu_restart(void *data)
 	if (!mce_available(raw_cpu_ptr(&cpu_info)))
 		return;
 	__mcheck_cpu_init_generic();
-	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_init_timer();
 }
 

-- 
2.51.0


