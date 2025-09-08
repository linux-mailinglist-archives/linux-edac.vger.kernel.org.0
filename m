Return-Path: <linux-edac+bounces-4747-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD2DB493D8
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311FB3BB7DF
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC130FC19;
	Mon,  8 Sep 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H59pMuKc"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDCF30CD88;
	Mon,  8 Sep 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346066; cv=fail; b=CBZjnelDdSVZ387pFq9gxFSitYnfe5paN9CJI9SgZkJ3j554IdwaKt5OaFlF0ZE+ydwIfu3B0FULOhRR1tciSLQGBHtVq4d/dJJl/sOCsWYnMcOHURs63y6tEbso0Ji8eGnOEqlqQrKNNJPLDl8BM/XETUdrkjRg2JjHCm4poz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346066; c=relaxed/simple;
	bh=53EVxLjy5QHgN7yAKSAYgNWWDos33HPWIRwwBEZ7QeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aQWq8hYBd00cM79u1N31GG9WddDCKBRT+FqnjxIlB4khsnhTs4lQ1nt0kxXPz2i++g3qC0oihWQEdaraVpSlgL2U9M5SaNqCiwd46/SNB2JujGYtclEmC8c7WQ9oFQTJcTUgpxU5qCxOV6/gHq0Ivbwdiv6ZX6P73/SF2D1TwHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H59pMuKc; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdMg5tQUUgUJ+kRq8h9y0PZgNYt+X/6Mk6CrECK1jV20bQXN2FiM+6zi/aCgrydFNLLrAvT7OyISvdGMGIPAvzC7Lbv3qk3ulownTJBYyCKeQUj7kcjqcQ24zHhcM4VhjFYX1WeDKzE+OFskKCGdoxWLczO4Bu17Z3qaSisAc7LM9TeqiNtP0vDIVmJg7thJQ2E3DNRUwthW8a65Ru2Auk8xXCFAkfVGB7C5PbnYT2gg0rRj5FSDNIjECnjkWVSS5eTryxRq6UQAAKfwrBW2yRj66NCkIdsLipk7rDTdBxYC/lZH/eGNmfsYkmE5ZCv65bzwRo5IoAJWcB4xBSiw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZutn9yelveBVhwmos1nZMXNgii8tTFF7ieskYrSTnk=;
 b=h8Y949EBaatE/hAHyW4cs709DTg5vvNHncLGrAfsHLzv1Bd1RP6/4Wc14xflR87uk96YR4qhi/fkukNiPgnYpBm5qOlXIEwIrfV/XdCbu58scq8oziQWLGvwNS21A/BHrm48h6sKI6qP6SVUSUpDtRmOFKmxexGZL6hdKG1ytsdjoK+3mlkWz7F3f04Q34+uchj8qdhzEdxGWnNoYBuB3AzJLcBC0G/RV68WV8eg6HJL8GPOMQkCQS55U8dHAlUmsAiAElSGxfbEt91vb1PBPA9bp3leBoqZL3/SZc3JfRObk/2jW+R7PB3TJBjlzLXTBSZ9swWu6FhV+r+juuEHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZutn9yelveBVhwmos1nZMXNgii8tTFF7ieskYrSTnk=;
 b=H59pMuKcfeP3Kt3YAwwmPzxmHY51MljjTayyfnDd8Z2zd3Jj5osqTAoNLWiflAEW4JVI0Sd1H+AdgStlyUhRVgaqFoiRotTkZ7raKidZhBx9cxnf+no1p6x1c9Khnh2sZtfjlhTO3PFFvwo8twX+yef519IRUFtY35u2+y53XDI=
Received: from CH2PR17CA0010.namprd17.prod.outlook.com (2603:10b6:610:53::20)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:40:59 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::34) by CH2PR17CA0010.outlook.office365.com
 (2603:10b6:610:53::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:40:59 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:40:56 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:33 +0000
Subject: [PATCH v6 04/15] x86/mce: Do 'UNKNOWN' vendor check early
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-4-eef5d6c74b9c@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2e770e-225b-4eed-7670-08ddeeee1bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWJOMTdSY0NLMUcxb2lCdlhyZjRnd2hBMUp1Mmd3bENVRlFwY0l4b1k5MHJp?=
 =?utf-8?B?ZkpGTkhRalhOYnJNYWgydThRZmpmdEdDdnhGdUhHNGEranhnSVl2M01OaytG?=
 =?utf-8?B?aFMyMEliWXN1MnZMNmdJWnR1aE1NWkF2VU5ocisyeWY0T0taZFJVVUZ4TjV3?=
 =?utf-8?B?akFQdDl6cnRGNlF6MURpdit5NFdYL0FJODhQYlV0OXRSQTI4S2pmTGxUNkxP?=
 =?utf-8?B?NEFRSElnamVJS2dJRWs3NytLMnhDcDVTRFI0LytLeUl5bmdKREFKZGkrTWFT?=
 =?utf-8?B?QVhiQzhuM3VOMlNVa2lKUDNyVXhpUzZJOXFBSE5WZ0V6K1l0WE9iSWlxQmw3?=
 =?utf-8?B?aTZKRnlwSzMycm1jYy8yNHRxeXBMcHNnQ3BUamYyQTZ2dXBtdzBlYmFPVi9V?=
 =?utf-8?B?RUcvZHF2TmVIUnBvTUpUbnZqVkxibmpBRzE5WVNVaU5JTXMyNXF1QlBOL1Nt?=
 =?utf-8?B?RmJNMzNxL0FNY2tpVXh4MlEvQ1ZpZUFPUWo3YVgvVGFPbG82anQ1M3FtQWZ5?=
 =?utf-8?B?Ky9sQk5uVElGWjRoSzkzb3M5MmsyMGJrcHlUMVFaVlorUXhwTGpRbzZvM0NC?=
 =?utf-8?B?VFNLekd2Smh4SUFQcVN4S2t0VllxZ3h5dlNaQW5JTHAyMmZSdXlXSWFaT0I3?=
 =?utf-8?B?NG8wOWFBZlVsVnJHWFBhYk9XSlZLTnZkZHFIR0l0Y3VDRmFPb3N0UzNoRXor?=
 =?utf-8?B?NmtOY01VYVRNaHBnSlFBa25DamswSjlod3lSOWI0bFMwL0pyaldiMk9wRDdh?=
 =?utf-8?B?Y3NiMFRXeHhwdWxVOENJK3RIaTRhYVZqdUYyN3I0WnJWWXdxVXBLRzdMKy9I?=
 =?utf-8?B?Ky93YnN3TFJ5VWoxYnlVNVVhY2t0aUxEeDRKaUYyWXFrRlVVYVVPNHV5VmZC?=
 =?utf-8?B?N0FsSnF5Q2ozU1htZ00zcGlUbjNkU3M4cy9WZFhqYzFnUWo1NUJ2ckpNT3Nh?=
 =?utf-8?B?UHhVWXdXYnJ4MFNIVU9EcjUzVXFJcm9nVEIxdmNHcjJwT29ITzBFQkFBSXhK?=
 =?utf-8?B?cldwVllqb0VaUnoyQmVUenRhdVJQSUNkUlp6OFVRZkt5NjM1czFvY0w3MDJL?=
 =?utf-8?B?Q0RrNjA3WGI2RmoyWjdTTVZ0NHc5T1VvQnBTN095R29BMWtFWi9QOWZheXVi?=
 =?utf-8?B?dkc4dFdPMkk5VWFBZWM4L2hhVUtkd1A5S3dJSFNlNXhRVS9ITk03eVZQWWFE?=
 =?utf-8?B?eHVuZHRDMndGYVhSSWhLcDEwU1BPYm96aE1pY3I4WGNpbUpJNWQzOEg5bmxD?=
 =?utf-8?B?aS9YR3JwdnpYU3NVUWJYdGk0OFlIeVpsMndLZFVweFdUZ0grdlNiNEg2SVBx?=
 =?utf-8?B?ek84bzdOVFM3QmI4Z0JCN0lXV1o5L3EyZGNoY09tQ3RGWEJQcHdFMHU3UlRB?=
 =?utf-8?B?T1k0QzNGOUVxVnV2cXFwUmk4WUVVSC9pZTZ6dnhadGtidVprSjBkNnF4N2Rq?=
 =?utf-8?B?SnNTYmFpaDY3RkVlc2w0cWR3eTI1RmpoaEVxcUx4UXBkRWFlR1d3KytPNDBR?=
 =?utf-8?B?Y2tkL0Y5eXQ1dVdxSFJkUUpGWXFCOWY3RVFIYlNPMnp6Z25zODdHVHBGVlJl?=
 =?utf-8?B?SnhtRUlTS1htN2kyeGNWL0Q0YmZ0aW5kNmxLZ2owcnY4eldlYWxJK3owdzMw?=
 =?utf-8?B?MUNNMDR1V1NwTmxaOFVQSE9VQ3ptZFUwZ1BpeklzT2x6SzM3c2lQY29GT3l2?=
 =?utf-8?B?UWNBZ2MwbFdmRG1RdDZDNGlhM2VSNnhObFRyTVExSXIrcjlsQlFiaG9KNlJy?=
 =?utf-8?B?YkVvVjFoUkZMcUl3eEhTWE12VEQyL2JYYnN5UHcxejBwNmQvQkdLMDB0c3hp?=
 =?utf-8?B?SG5zSjJ2UFVGcVhzcW10YW8wNDZFTEhydURYUnpFRnVaUXEraEJsT3lGa2hp?=
 =?utf-8?B?M1FsMkRmWjM0NW5jejBQR3BheUx0VVRLSUd3N2haU0RBd1l3UWlqRTFhTmM4?=
 =?utf-8?B?Q1VUaW5JSEZiUlhiVHN3bm55N0Z5MnoyNVdXaGZKb2xTZkQrU1p0U3g1MVps?=
 =?utf-8?B?Tm5uQjVOMnBCandpQVc4WGtQeGdwdWZHb2l1NHZpS3NRZE9XMW0xcUpialZD?=
 =?utf-8?B?VndmeFJGVDEzenBWa002NnNjYURMMmc0Q2xmZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:40:59.2668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2e770e-225b-4eed-7670-08ddeeee1bd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

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
    https://lore.kernel.org/r/20250825-wip-mca-updates-v5-10-865768a2eef8@amd.com
    
    v5->v6:
    * No change.
    
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
index a8cb7ff53e32..515942cbfeb5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1977,14 +1977,11 @@ static void apply_quirks_zhaoxin(struct cpuinfo_x86 *c)
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
@@ -2000,8 +1997,6 @@ static bool __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		cfg->monarch_timeout = 0;
 	if (cfg->bootlog != 0)
 		cfg->panic_timeout = 30;
-
-	return true;
 }
 
 static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
@@ -2240,6 +2235,12 @@ void mca_bsp_init(struct cpuinfo_x86 *c)
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
@@ -2274,10 +2275,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
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


