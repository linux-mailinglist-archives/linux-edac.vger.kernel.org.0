Return-Path: <linux-edac+bounces-4225-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED99AE686E
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E554189792E
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A8C2E0B41;
	Tue, 24 Jun 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ucV/5DXj"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1442D8787;
	Tue, 24 Jun 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774602; cv=fail; b=S/7LXtAR0MaESDRNGtHJwsdT6YGOE1Acu8JeU2an5KRGIby07TPtaCztp3AigN06bgBf0gHbJqMTMYFs1n7afrS+2YdpOA6epecwDojsArhT4c44JcDtLojW47I4WbVviZ+LRxhWR4u/++95eMXV6d/MfJv6XJwx3kY6+9yS9XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774602; c=relaxed/simple;
	bh=h7qJZlqYI6jdX+qt78rqDswnA/5YNQUm7BugACjCqWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=THQCzOBnNexSj90/MHC/sFaQzNDnbbeJypJxylxfxzJ4ZTxiPZgxx3xM2IP3LCiexIalcPiINtGi0dNx4opm2EYI/8xbX4x15rrXu170BuNjE4Br6Pw/28uIVEDxT29R4vqY6gvH+Eah7LOCWJQfbARhAL65/O0jeiotBfMN0Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ucV/5DXj; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GS8FaZBzZele4NZnfMNCJjq/6yTWdZL7k5cafbNKhB0zDfUsz6gaDz/H/vDTX7uksIpuzGxuxE3vIDVrs776fQwY8j2MVlMJniar4o/+klZb3NwbE5F05AfGzlA6uiO9SW0GZFpy9VWMSDl3hsNz7T4IY8DeqErsYvvXXXZSpbheKhPVlancmECcBwH45HlgD9xQTE4XCwf4v4XJ5sW5BtaEM0GrZNONYsWs6JFLcQJ+6/a3RXznq8Xd2fOmtBcanu+y3uzGGJiN65AsRsQ04p3M0/ta6Pq5Z++IckEwB/qMFxh4Mtp4eHDxdAYkja13Mc/1DhjKJS9o5JJr9jwdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PmjHIUFybsIpygOH7b9ziSVBlfeuV01DExs1A1uOVs=;
 b=bafvpOX57SZdZd05khDKpiD54jUnHzVgdoSfPnNXlDoO6SDhFZTkufzRBT9sI1gYUejT6ntZ7JVZ7TY6lIHtvvlb/kNemf1AZYLZbICSxLn2ZcKhbXk3GdqTqLCUUytEMo6OcpUhc5qyZBC/sHMKwpJ2ZoZAQWlA2XDAzZQn4Ee5hw1OnTiN1v81mU5APXNbcEiJU2ph0Pq5sWXbAuN/xCUOvu0wl6yt8z66UlRDZAySqQclM3J5wePjXYUSJHE9Gu1J3z48RuUZpkhjTecfpuDq6VjiDl5H5ibEud+wO4LQWM0Z9VuEAAMPQbEXirE8xC9CCTDwpkznDTMTUocMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PmjHIUFybsIpygOH7b9ziSVBlfeuV01DExs1A1uOVs=;
 b=ucV/5DXjUEPKnbGYv45UNB6vyvppVV2CcMgnyRDsGeHX+o3yBbmv831AZDgi/xW2wnENc0B2ddcWEwoqX9hsnOOdryaU+CM5+tln2R4QsZPHY4EbIQshSRkNx/z1nCa7PMIud/glUnN1JNHMIPrCU6hQWNjWQlcuXE782iJwZdI=
Received: from MW4PR03CA0230.namprd03.prod.outlook.com (2603:10b6:303:b9::25)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 14:16:38 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::e) by MW4PR03CA0230.outlook.office365.com
 (2603:10b6:303:b9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Tue,
 24 Jun 2025 14:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:38 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:33 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:08 +0000
Subject: [PATCH v4 13/22] x86/mce: Do 'UNKNOWN' vendor check early
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-13-236dd74f645f@amd.com>
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
In-Reply-To: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: fba33849-4a7f-405a-1c0c-08ddb329bbe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUNCdXFneURRZkJiQTVtU2xWVEszd2pycjBvZGxmSDNvZjgwTXd0c084R2Ry?=
 =?utf-8?B?bWxXeFJ6T2JLZzhyRExmUElUV25jRzFJYnJ5Z0ZWL2hIbUtrVzZMYkNoWjY4?=
 =?utf-8?B?YW1pTHYwV3dESGFTcEZxK3B1RTcyYjhzMGtWb3VJMG13UDlmdXp5SE80Q3N0?=
 =?utf-8?B?Z1ZmSDBadHFVdXZyTG84dzFEeTB0RkRvWVM3eHJUSGI2UDg1YWdhSjlnSjdI?=
 =?utf-8?B?TTlGWW5wa0JpQnpoN2F4UFY2NnN0a2llaFk5cHdMVE5iWmpaMWpmdEZsT1dj?=
 =?utf-8?B?VVhicnYwV2ZsOE02aE5hazJDSnduTTlQOXpwODNVRVlWbHRwT0JIZ1lqbDly?=
 =?utf-8?B?UzlwUHo1YWU2WEptdkF0a0wwTDRaVHVOWm1qS1BpSVB0OUx3cFVXWXZ6OGhu?=
 =?utf-8?B?WlIyUjdqWXdzb25tdG9wbyt2Qkh2ZzFUYjdtbUpRTXBYMUVpdk9DWHdReEVF?=
 =?utf-8?B?bFh1THBRRmZvN0RNbm5iSWM4VlBUZlRoWEhLWll3RGVNb2ZTK0hqSzZQTWVH?=
 =?utf-8?B?QytqQXJ5QWxYTU05RkZKZTVUa0Q5akR4enBPa3NCS29YVGRtOFFYcm5wU1Fh?=
 =?utf-8?B?eUZBYzdvVkdKRXJ5ZSs5T0RmcTM0bzk2Y1JIUXcxdWwyUEtnbHJSaFVEMWpy?=
 =?utf-8?B?NVBzdEo0RVJjV3B0WFhRR0NBMlg1aGQ2b1FuVGp5cWc3bEY4dzRhRHp3UUpq?=
 =?utf-8?B?RnBZNDEzQzQ3WGZkVVpyQ01uc0d4T3VBWlVMR2dXTzRUQ0dxUlkrTTFCSWho?=
 =?utf-8?B?MGNnazJuQnkrY2dTSCs1ZlI4QWkzbThBZnNqZHVoTEZVYmh0WEN6ZWNNSFNN?=
 =?utf-8?B?NldBY0I2RmtnaDB2cWdrQWVSRmR1YXBUaE5TMjBBdmpSQnBzVm96RWJ1NlZS?=
 =?utf-8?B?VWxDd1hhb0RENmptSkJGZXhrMTRKM1lINXROTTV4akdpbjFMdHVpNktWeTRR?=
 =?utf-8?B?blU2anF4Zi9McnhyaFZ6NmZhVVBUQW1rVVdCU1BzdzIxNTNQM0NKTW1HaXlV?=
 =?utf-8?B?TjExci95T0xINnlBNVIwR2R6a2NzYlRBc2JsVUdvcDJxZ0hrNVlPQkM0b1pG?=
 =?utf-8?B?OGNCK3JTMWhPTlQ4ZHVBNFgxVzl1YzA5Y1U3K0dxUkw2WnRuQzBsRExjVVVw?=
 =?utf-8?B?bldsdVMwM3gwZ1VJMnIwMUYxb05qSEJISGhCdzltTEhJcU9hV3JlWnhRRXhO?=
 =?utf-8?B?bEowMC9zMG1xQ1M5Nit2TEdUYUJNWUdjSXpOSGVzSjY4R3BQbnczbnpUVFAx?=
 =?utf-8?B?VzdLa0hKaVphS2dZanhvU3BncWNTWC9IWlRrT1hqNmsySmhGTDlCcHpHbnpR?=
 =?utf-8?B?M3hiN1N3UkFoS24vUlV1U2JsSnpEMlM1RVVJR25RTmxPaEFBSmltWWV3Z2Uy?=
 =?utf-8?B?ZmxLZlg4a1JaaXdlUGZoc0UrSXg0N3BITXBLcVY3VkMzamdzYm0vWGtsNGk3?=
 =?utf-8?B?MCtzbHBEZjZIMjd3NnBpWnZzdlRrYlVIUlY4SnhGQm8xUlFIdG9MQTNmSzFh?=
 =?utf-8?B?KzRxa0NwbFRqUWViWDNHUDhpdGpWdk5PSGkveHRJemNSMmlqcnVjdFdoc2VO?=
 =?utf-8?B?Y25ZbjFjRnJFMVVTRlRnZ1FpOWJnaWJkRW15Tm96QmhScExmUC9oWWNaT083?=
 =?utf-8?B?MG9SZmJSaExuSFdaU09yc0VDRXRXbGY5MUgrZE1LaG44S1JOSUs3T21EMGZ6?=
 =?utf-8?B?YXZmM0Q4T253TXRUSUhrUjFtNVNlZjJ1NGV0dkRNSSs0U3dPOEtUbm9GMDJO?=
 =?utf-8?B?NHR5UWlDSXo3VVkvaFBjWUYySW45LzJIdUlwcy9YN0tHVHpUajlxcjhiM1Fw?=
 =?utf-8?B?MURZbHE0dllvYi9nQWdhQU05Y1U0MWtIZStKdU8xL2daVzRpU0xEZFVpbHM1?=
 =?utf-8?B?V0syTTdJWUoyY1djV1pTcXFxU3NybFZ6SHYwNjJmVWZxM24vZ0VQSkUrM1Vz?=
 =?utf-8?B?NFJRVlhkdkFMZDFVUFVzMFU4K3dZendLN3luMTlSOGtsQ0FZVFNWTnh1TVdR?=
 =?utf-8?B?c3JiWTlTdnZwbHNKeGtuM3dRbFJCMWJLZFlMSjBtaFdISmVKbW5WV01Cd2p5?=
 =?utf-8?B?dkFoY0VpNTdHeWI0Z3M4Q1pjdHk5dnBZbEpFUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:38.2509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fba33849-4a7f-405a-1c0c-08ddb329bbe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139

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
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-9-8ffd9eb4aa56@amd.com
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index c852d06713ed..a723c7886eae 100644
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
@@ -2243,6 +2238,12 @@ void mca_bsp_init(struct cpuinfo_x86 *c)
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
@@ -2277,10 +2278,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
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


