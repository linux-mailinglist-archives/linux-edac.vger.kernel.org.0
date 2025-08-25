Return-Path: <linux-edac+bounces-4669-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B87FB348DB
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E3A1A87637
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F77930E0CD;
	Mon, 25 Aug 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5mxtsUn7"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECC309DC4;
	Mon, 25 Aug 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143234; cv=fail; b=bwRk/XEJ8V2NtiMLo1Op/bE3qwA1kIjIXmSN+ecBy3I+4lUMFauu6RArkacVWcVw4vxIoKlJCVcl7WuMO1Osi8JYKAihegOPLjz5Fd5wtOtcfTms6APF6lcin3pyghUEu3OHbAADSJ/n7xdQMxT/pTujkDl/AIXvIBDVppdCixk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143234; c=relaxed/simple;
	bh=vM1QlFK0rfeLluoW5HpmMThtZJwKF6+c9BYfz6Q7Vb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rM2FirIka2v9IRIogCjIjm/lEYcxik+5NDVkP/L1AFyGzoYCA6T7LRBdqQMfRWxQqOMAZTpPsLa9enIzYR4zTbXRHlliUkNZ2iHoNMLuH41V23pQsyLU25PVDV9c/b5qu3HUHHcBJSkT/tCpRGWGOHpeYDjyFh9eplTx5UagRmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5mxtsUn7; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjtLJyVcaQ4f0vmy+J9cnmz9XodHW2OPONt+GF9f95Ahkrroe06fzIvIcMzOa7EGCMB0MJ8Cui1SEHz/JiG07mfXm0E6jR+H8XbiiZEU0RfvGkytL+UyeUYEY7YV7CWzRiiin8eI3nzbhaUMU66QhVi2VlmcnOXtKKL8NZECxeEqSUkN96CEqbEIbQ7AcxGUzQ1k92uZrkv+8xddw1jzdpBrXnPk8MCB4d46zBcf+oHu0od/4njEY1f9vEtadPa9U7gtWSS8kFCIb57THztp8DJUiTOoDkHvIoGHE/oZbLGPH5zvUrx3PKPbE7x0aEjkOjsVbLNQhtwvg1Mv1VozKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZBFhkBQoqpyBDohL5Z7nrRGM2MKh9nmPi8cuGqm+QI=;
 b=DK+EO602B9btKHtgklIj0uh7JLKwVOPIm4hkuQIW0hn3YAUEGZpAhZhz8xB/NC+sQlpQkicSoYjUIxedGNnhKtkq3oUMECOCdLUFKc5b8DxtMeSj9oKOWRkPWDaR7/iVk5d9K6TUNNAtbspu9wq9WvqTR5GOZ+43YEO+Gx6MAABo5b4JtBKMKHzGGBZCoSIBhaYnDI4RT5UrJPQvU05gzGHK+w6avskQLwVBifaURnIE8gC/CdfPgWDqZf6S431rH3PKih82llZR1CN8iH0ljnW2ZYkYA3zayMB0rNZPLhZjXTZo8rpBFt3G+Dp+RVhvQ30JyfwEvnBEarMQS34MJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZBFhkBQoqpyBDohL5Z7nrRGM2MKh9nmPi8cuGqm+QI=;
 b=5mxtsUn7gftfNNowwBd8cm/3IMVljZsevHAkIwx6SbdtkEiw3YlNX8ArrDd2Pd6T7f9Oz4tYl6avmT4P20m1Tw7rkNe+/tHRqa5h2yN/4IaVnTN3FmM20iSUaIEn0bo/h3SUKzcCKqbQn8SDhxNrKoD5C8WBjkUb++y3tTZYy1s=
Received: from SN7PR04CA0035.namprd04.prod.outlook.com (2603:10b6:806:120::10)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 17:33:46 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::1d) by SN7PR04CA0035.outlook.office365.com
 (2603:10b6:806:120::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:46 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:41 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:07 +0000
Subject: [PATCH v5 10/20] x86/mce: Do 'UNKNOWN' vendor check early
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-10-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d97768-ddbd-4407-1156-08dde3fd8b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WExBd212dUl4TDBkSlZ4MnFpdFd5ZXdBOW80S0ZRSXNrQk9iNWhEZWVhSVo4?=
 =?utf-8?B?bE5HbzFYTDEzWmNhcEtPUUtuSkIwME5JYWxCSndjYmZmSnl6K1MxVmFwUy9R?=
 =?utf-8?B?TEdoNUZaQmZUWTk1WlVFRitCeWtJSUp5TUIxTjNwNGZNeEFhRmZOMGh0NnRS?=
 =?utf-8?B?SWpBOVFQZldBa2NMNXk5TGVsdkNBN1lhekNVdDd2dk9BMW1KTkloZUFBbm9p?=
 =?utf-8?B?N3pPdjdEYitTelBQaGZzalhTc2Y3VmY3QUp0M2tFTGxKUnhjWVZsQXdPWDJm?=
 =?utf-8?B?TW96RlpmaFlmV3A2L1NranNYZ1VybHVFMHBSSW9DNzhISnNGVFFPNUUrM1pt?=
 =?utf-8?B?aXVNRG1vYncvMzV2WFV4d0xQUTZmODdhL0V2cDRXVG1Va1FBWS9xaDFrRW1s?=
 =?utf-8?B?ME1Gb1ZlNkZYN2RNcktCbkoweWxUTTN1MWl3RzJQdEREeXFzZDFHMmVsMU5v?=
 =?utf-8?B?N24wTDZsTGVsckl5UElOY1NpT3hZTmQ4SmErUk9jbUpuYzlKQUJQbW1Ecllu?=
 =?utf-8?B?Ry9HNWliOE11VUI1RGtmdlZWdjF4NlM1SjBaTUJyc0JCQkhJVzE1WU8wSzF3?=
 =?utf-8?B?SkxCbC9XaHpCOW0xYzNGaXdYRncyakVJSi9JMVRJMlVXQ0ZxaUpJdmhoQ2tn?=
 =?utf-8?B?WmhZVThLTFFLS2FNRVlvb01tRkJmTGk0d3pacCtLVURNK0ZCT3ovRlpWU2tQ?=
 =?utf-8?B?eXFsZm9jRDc5empmQlI0RHJWZElpbUdyTThyNUJUazZhNEkvRzlYSHZFclFP?=
 =?utf-8?B?dlNtOFhaalhIK3ltT2lRL3IwNXBCd2htdVF5N0hCV09zelhBWkhYS25WeWJS?=
 =?utf-8?B?aGQwMGRFZnI0ajZjdVNZa1ZEVzFDVWw0Zi9tb1dmV1E5SWJSRG56WkFWdTVv?=
 =?utf-8?B?dHF3azZmRFY0cnNmZllaRnB3TkNYd1F4R0JCQjQzZlNzaTdPVXpzRUxJNXhi?=
 =?utf-8?B?TldtSWhIOUNYNGV2V2NBVnRpZDFPVVVjbjByaThJOHZ5Z1NDdytUdmdpWnFt?=
 =?utf-8?B?d0xHQ1E3c1k5Q1RPVjJwdC9uV1pGb2tJZWJ1cmlkbXhJOG01bWRub2hlODR4?=
 =?utf-8?B?enU0MFF1YWRISG0xbERHNXRPQWpOVXZpbVEyMS9ubFYvQTViY3U0bC9RSlNY?=
 =?utf-8?B?elNVSDdXMVh6c05QaFFmNWtKNmo2UjFCYWRXS3M5YVYvbWhVeE1WL2tQQW5I?=
 =?utf-8?B?TEdSTmNoVG56N2Y3UTRKYW1SZEh5a2d1ZFV3N0FzN2xpUklsQ0F4QjNwRkx2?=
 =?utf-8?B?VW9SYjBIRU1xWmtZeDduME9vQlhQWjhnd1Rad3FMR2lxMkF0aExLQVBXUXBs?=
 =?utf-8?B?d3N2QU1WRk5TaUlPSGZONGp0dW00VU9BQ0VDUnBGUzdHUU1GUFh3bWZqdnVt?=
 =?utf-8?B?TGg0MDgxZnF6WU1LRWJXMWR2SWxhK05NWjJvN09XOHhJdkdVakhCaEh4RXRY?=
 =?utf-8?B?Y1RXbWV2UnIxaDBOWnFkeVg0cUF5Y2NwSWNzTDlJR05PYm1Mam1FSi9tOC9j?=
 =?utf-8?B?b2JjL24zVHdKVjBVbi9rUXhCMUZYa0h6dFpES0NyTjBjRTNHcWIvMldaeEtP?=
 =?utf-8?B?V2JaZEdSejY0N0dxTTJqb09qMUh2QUVpNElnUGJUTWdRSWdWMzFPVTM2d2dj?=
 =?utf-8?B?RlZNdWFlM1FKdE9GYnp3S25QeGhNamxwODRudC9Ddk5uWjVkb29VT0tKV3dI?=
 =?utf-8?B?anNtRzQvWkt4WDh4dWtscTE0QmxyNVpTa1hRQnJUUEp6NEd5TXk2TWRCN2hH?=
 =?utf-8?B?eks3blJ2cWM3ZjFhaHFUM1FYRzIyUWMyd3BVd2QwdlVKYnNwWDFrV254Z2xy?=
 =?utf-8?B?eDN5b3RaYzcxL3ZmWVJhb3M3RE1TcUZLUTBNU0dTaERZYXVrcVREc2Z1SjZG?=
 =?utf-8?B?aHgrTUZQK3RvSC9MYTh6UkJGTHpRckNwdHlsOFdYNGxlb1ptSWhlcGxWbUpJ?=
 =?utf-8?B?M1EzaEJ2M3dadVI2bTE5bThtTXN2VEZ0OWhkUXlXdFo0akxjaHpQOTZoaEJK?=
 =?utf-8?B?NnJhRk9wQWVJUW0rMWR6QWNnUnJZdVdsY0JuQzQwcFRrQjJ1ai9GR09HS3Jh?=
 =?utf-8?B?VFZJcCtpajdrUnBoL2J0Sm5XUVFscnlSdTJjUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:46.0056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d97768-ddbd-4407-1156-08dde3fd8b5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069

The 'UNKNOWN' vendor check is handled as a quirk that is run on each
online CPU. However, all CPUs are expected to have the same vendor.

Move the 'UNKNOWN' vendor check to the BSP-only init so it is done early
and once. Remove the unnecessary return value from the quirks check.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-13-236dd74f645f@amd.com
    
    v4->v5:
    * No change.
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 18a8e8f97482..14456f6c2f7b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1979,14 +1979,11 @@ static void apply_quirks_zhaoxin(struct cpuinfo_x86 *c)
 }
 
 /* Add per CPU specific workarounds here */
-static bool __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
+static void __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 {
 	struct mca_config *cfg = &mca_cfg;
 
 	switch (c->x86_vendor) {
-	case X86_VENDOR_UNKNOWN:
-		pr_info("unknown CPU type - not enabling MCE support\n");
-		return false;
 	case X86_VENDOR_AMD:
 		apply_quirks_amd(c);
 		break;
@@ -2002,8 +1999,6 @@ static bool __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		cfg->monarch_timeout = 0;
 	if (cfg->bootlog != 0)
 		cfg->panic_timeout = 30;
-
-	return true;
 }
 
 static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
@@ -2242,6 +2237,12 @@ void mca_bsp_init(struct cpuinfo_x86 *c)
 	if (!mce_available(c))
 		return;
 
+	if (c->x86_vendor == X86_VENDOR_UNKNOWN) {
+		mca_cfg.disabled = 1;
+		pr_info("unknown CPU type - not enabling MCE support\n");
+		return;
+	}
+
 	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
 	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
 	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
@@ -2276,10 +2277,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	__mcheck_cpu_cap_init();
 
-	if (!__mcheck_cpu_apply_quirks(c)) {
-		mca_cfg.disabled = 1;
-		return;
-	}
+	__mcheck_cpu_apply_quirks(c);
 
 	if (!mce_gen_pool_init()) {
 		mca_cfg.disabled = 1;

-- 
2.51.0


