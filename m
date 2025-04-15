Return-Path: <linux-edac+bounces-3548-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69705A8A204
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31242440C70
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A029E043;
	Tue, 15 Apr 2025 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ik4W0se9"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5429B788;
	Tue, 15 Apr 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728921; cv=fail; b=k4rk+b8wDt/Y7kl6WkcshPjTIsww75Pcfmp4nsZReDAfp5ytQzeBZgg7MvUKUZk8FC3ii8w6GvyXDnvSskaoniOWsiWy/9dCnEc+XCBfyomJ1otvCCLhR5vp6IuEw+FR3GVbvvCCNghIDwCKZV6nc3KPw30HejevzNAnrtOSGtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728921; c=relaxed/simple;
	bh=qVuiZIXfHKu+un744PZh3KhfqUDSKtvnQQ/6+IqNQDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SK+kWn0qCUPZk21PN7CoqVgCR65uPzL5oN7oPoNa1JoQG60a1mLGwJ69qdYd+9VYTWFXikjcb4FoaAz9xGKTL3g9laPPPZEn7fLTvjqJhpTgb5mzXCeqG5sXdrtk4MSAbb9fYiZm88o52m6OnwWVA9jP8oRaf4cS1et358aRMjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ik4W0se9; arc=fail smtp.client-ip=40.107.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B951XW8kpR1w1Fv/fIXabePrn2OzrzbXN/ht0FWZ+TZcsVDHOUEROnyldYgFrCm2Wv6v9ctRu0Iz5A4h04PogkYYIooknJm1hrKFn8UVO4i1l9oHHBLwa5N2evmrhGvcWK+cnzXIyycjpjujgmvT6NPDW/M3VMZl36FAgYtMW2nr57uZIYYB8Vvfdt90C0r1bJ1HPgz8gMoff8SlhZGvMHpFcv8Mnu21RZGzCka9C0P+XzW2vYmLcgS+1SQduzqTXz1oQAKB1bFPEjyAedQoT07lK/B1HpWNrlkHScBFv/P5IGndyP99ZiwY0bmwFBI2q4+yKBci6CMZpcwgfHVLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0j+VF/CZ6jkCPy35B6hAI2apMCWw+QsmNTgEQNL7VU=;
 b=o7DrIx22oDshrB5oryq4bDprsHuBBNPb65JVNBCwDDlRqJhRg5B0FPO8VlKtHTXQR6g6uTmuAdQmojMWbUe6sBV/inlQHbtjoV0FqEam6Tu9ZdVN6q2FMAq5P11BhJZiGTlfCzsh8QJGleGdPO3tCObGnMMuFCCOZuvBIfG91GaDZNLlbAGAE9VZJ7tPLji4zKpyXGFD6GxaeqYBcmkK6zCpVQ2UX1EmaTvryEc1Zyqh8dq00clEccUuj8czXp7jI/RPnL7G/jHHvwqIx75Ypl0uYT5SxG8HwzFGySxRx6SUi14ejzqQ5fgoW7McFHaGnV0mODQHq7oc4nYw4lAbAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0j+VF/CZ6jkCPy35B6hAI2apMCWw+QsmNTgEQNL7VU=;
 b=ik4W0se9a8t3AksAmoC5KRRwEU7wAsRzoiEwRU9/JYSL1vZtVpZMn+oPrq76ubQ4kpxs6TOjIeZKXxwh1Nhntbm08JKsLQ26kwS9jsBj0zd3reLU9oXBGXDavT7k41GHo7sjzONjD58ts30CB/md/0oAoaD/n2FqPNrY22e2q9I=
Received: from CH0PR04CA0096.namprd04.prod.outlook.com (2603:10b6:610:75::11)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Tue, 15 Apr
 2025 14:55:16 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::8f) by CH0PR04CA0096.outlook.office365.com
 (2603:10b6:610:75::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 14:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:16 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:14 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:55:04 +0000
Subject: [PATCH v3 09/17] x86/mce: Do 'UNKNOWN' vendor check early
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-9-8ffd9eb4aa56@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 42615be7-d1ea-4e7e-4a40-08dd7c2d88ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWlDQzliWFRuOGtEUytKWlRrd1RYWXd5L1p0aHBZb0xLRXBqVmM2YWM5WWpL?=
 =?utf-8?B?Y2ljakcrdXlrbjlDUWxpbVFPajRiRDdsc1FLc0QrUW9yVG5mbTFhMUtlU2xi?=
 =?utf-8?B?QVdBRkREQ0I3TXZIYzFhNFN6Nm5JL1BVeWZ3VE5hM3FNQVlaWDYrVHFJT0xv?=
 =?utf-8?B?WndLN2lnZ2NMRC9JcnN2dmFOZy9pNFRDL0JacWV6WkhHT0tpQkpwUXpEU0NU?=
 =?utf-8?B?N210T2hDK3djTklFNnRlRDdCWUtOZSt0SUY2QnoyY3R3MzNsRmdNN0JvTXds?=
 =?utf-8?B?cDNTb0lXa3lESHJGaERjZzZxcXlxajlVODFvK09KVVFGMG9hbW5Id3ZCeG4r?=
 =?utf-8?B?QnRXRGFMazl1dkhGMHppZkpIRW9sdE0rc1EvWFQ3VzVGMHFhcUFibE00Vk1Z?=
 =?utf-8?B?cmc3Y1F5TkMxVDdDSTdHL2hmeDVGU1hXdDB2ZDRUd2NBSVVFeFBtTTlIZlF6?=
 =?utf-8?B?UjErdUpndVhvbmFjVnp1d3dSaThWcnJnM2dHZHBpQmkrZnAzOXNkZ2lxTnkz?=
 =?utf-8?B?Vy83c05nV0ttbGZ1L051ZGE5SFh1L3pUWGJWUzhWTDNMWjZPaTBFVHR0VUg3?=
 =?utf-8?B?YUJPOWM3ODlaVHVnK1lHOUpXTDJVZnlvWnU3WEQ2eFZ0cHRPQzg5ZGVwNkQ4?=
 =?utf-8?B?TklmS3NjbStvQ0RnTnlNVHlsSkhIMmJqcFlpd2Q3VXVnTHNEL241V1pNMitx?=
 =?utf-8?B?RUF6bngxOXI0RElOWnB1MWFpMmpNb1B4dGlEaG83aXg3akowaENtajFrZDdJ?=
 =?utf-8?B?UkxKMC83QnBvbUw2MU4rcjNkNXIyb2ExSjE1OWQ0UDlBM1E2YXZvVGVIeWpj?=
 =?utf-8?B?ZXByYmhXRS9mNXplYXZOSVBQcWZzaUFLQmFYU3V4WFV1RVVYTFU2NnpTenE3?=
 =?utf-8?B?aFZEUW9XdUJ2VzhMdUsvR3piQ0I4T2g1aVF4Y0g1WnZ6Q3ZpLzY4c0hWRTFK?=
 =?utf-8?B?ankyYUdqWXNEL3RyajdWZnc0VWhQS25hN3JPckdvRnBlNnM1QnJNMU01bVFC?=
 =?utf-8?B?YVhIaEQzWUV5SHpRcnhwUW1qN25HQ1VHN2RSOGFZMDlZQko2cHY3clVhTE9P?=
 =?utf-8?B?eGoyY01wanE3bEgyMXNuWFRvS3BnVy9VazBnS1kvSHBhbnE2b3RmWktOL2d2?=
 =?utf-8?B?bFZsNHV2UElYaHEybHo1ZjdtRkZqcEFCNFE0Ry9ua21IWXNpRDVuMEtmdVJx?=
 =?utf-8?B?eFhmZE9CSmdYMHJQRCtTcjRBK1o2WUpuanFWaGkrOEZRMjNOY0xKaTdhY3dt?=
 =?utf-8?B?MVNSUSttdEpMVFFUbnFyL1RpUHV4VFY3aU0yZFNRMVkwU0h5c2pwMGFJeUIw?=
 =?utf-8?B?dHNXY3pqSkZKeDJNUlExU25kckpGSUpPME5pZnUxOHFvai9wcjFJQ3YzeUZK?=
 =?utf-8?B?SVN1dk1RcE0yeERJQkRpRzVwc1ZjVHMzYk9DSGkzOGNCUEd4R3BDMnpKRC8v?=
 =?utf-8?B?eGkwbUNvYjVQdEFUb1RQWStxMnBYZXlqemQ3bVJaZmlTdDRFSVFMUm1lOHR5?=
 =?utf-8?B?RWdPYTNYTGtWbHBSTHQrdFZxN200Sy9kUkpoeElyMW8yZUlUM1Uzem5xZDRM?=
 =?utf-8?B?c3NYbUhYMWlEeTZRVlFxY3dHNGhDQllZMUdiQ2QybVE3TllLQThOaHR3YUFW?=
 =?utf-8?B?aEtFcktHWGdJVHo5MUZBbWVNUjVQeUdlT2xjNXlKSnp5SEdBb3RiSjZ2akpR?=
 =?utf-8?B?d0U2eTNjaGtoYjZGWFhaeDZLNGorREZleDJSN2lEcGsvR3Z5NHdoRFNIUDAz?=
 =?utf-8?B?UUZONFR0VmpPc0x0WHUvd3AxV0hMUU9tbmtOcTFuaS9CN3BaVm9McWdXakd5?=
 =?utf-8?B?TkZiYlFRdEdJYmk1bk5KamJJaThGR1lVWWNGTDhIMkVJbThJUUpHeEZNalpa?=
 =?utf-8?B?K1I4ZFJTWFFaRDVyNVdXL2Q4NlRPcTJxai9va0hEQk5CVEhyWlJrc29ISy9v?=
 =?utf-8?B?M1FJSHRZMjVVNS82c3NsTjg2ZnRab0tzZzBHZ2I4SzhMZXc4WC9CQTBzVSsw?=
 =?utf-8?B?Q3BnakNhVGEySVpqV3VtRjhQVit6SG9FY3A4TlliajhYNnFKdlowODFBYXdr?=
 =?utf-8?B?Y1RyL0pORzNETURndWVEVGM0NG9POFNubHZqQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:16.5136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42615be7-d1ea-4e7e-4a40-08dd7c2d88ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312

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
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-9-3636547fe05f@amd.com
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 444d006366fd..9dc9d672a7d1 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1974,14 +1974,11 @@ static void apply_quirks_zhaoxin(struct cpuinfo_x86 *c)
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
@@ -1997,8 +1994,6 @@ static bool __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		cfg->monarch_timeout = 0;
 	if (cfg->bootlog != 0)
 		cfg->panic_timeout = 30;
-
-	return true;
 }
 
 static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
@@ -2239,6 +2234,12 @@ void cpu_mca_init(struct cpuinfo_x86 *c)
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
@@ -2273,10 +2274,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	__mcheck_cpu_cap_init();
 
-	if (!__mcheck_cpu_apply_quirks(c)) {
-		mca_cfg.disabled = 1;
-		return;
-	}
+	__mcheck_cpu_apply_quirks(c);
 
 	if (!mce_gen_pool_init()) {
 		mca_cfg.disabled = 1;

-- 
2.49.0


