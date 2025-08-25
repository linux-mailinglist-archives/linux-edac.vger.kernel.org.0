Return-Path: <linux-edac+bounces-4663-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ADBB348C5
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26A25E5400
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9BF308F1E;
	Mon, 25 Aug 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uGNn1oXX"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D4D30748F;
	Mon, 25 Aug 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143229; cv=fail; b=a7aKLjbfjb+7KjYMEvwAmI/nc88VDVRXByqOpFDPOnjaPoihKkEyYmmxc76QZxBYvWMjJBuQ+Xi9qJXlK7+QqINHybqtS/QJZJfUvn12xKim/+a7okLXZw6M1w2HG1bXNiVbj3IKvX4pf9VwBOlClY4xzDC0oFATtBVgm5if1gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143229; c=relaxed/simple;
	bh=KhT/kD2OTCfeVclVPHmo2IgHZ8Os7VjuUBMuTZhH+3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=da5Zvkbc1FqxoN+A/ADnb1S6D0GgdJ7vmVeJYr3YW0xrgZYAT7VO7TCOxacl5OVKh5HcfdieWkvP+fUXC2BPqicszRvR6QV2Qc3olrYq/ROQ8ANZrd6NCp2ZLg4G5QHxGfcjrhY0zaEZ/4Tw2ZGeaJ5siYGaqGwaDYrE6YZQZBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uGNn1oXX; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPHmAhwmBUJO+DOFN7MWYuMT9uQOvIBQJhInvcWhcjTJF1aDmARz1rWyKzQGISA0A0ytCYqv0mOu6S6PkkMsWAnK7jdn/uYUeB75gN7T3ubn3rvI+0aLn3RmdFocuHkRYE4IGify5hE9ewENeqWgYZIEQHKlJumIoho+RqlbvedqcyuISrNg0IKNxI8BQouXhoDUGVZH4LeSMpllJDVhN5sgWUU20xWLPVY4OMjtyf7E0xdAi+TMFXWo+PmZwrJrpNFJMiLV9cYaUdbbgcnc2S5iDi/ka25WnBj5x/x6JFkf9cJQ3aXE6++FEJ9y/ae3I62q4P4GiaUs67eshxHq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVN59JTS2flafklL/byRQ4/zbBQ9zlvhjHsBpiroudM=;
 b=qQYmJdaeumMqGJCe5pnUZrZ2Epn/JpJ1gbCbMXJa4WGU2FJeH9Dbhg59M5XG8jWA31/Mq6Myqkdi0REaBfk3X7CECNTbryqYigcw5IE6kNMTNq6cKG2TJnJJ6D05PICMnGKRdzyeKbnjriYIxCaLzecz4cFEkZSGZCQTBedzZgMYQ2F9W/ezgkQP6LBy6PcD6EaTO4GwJMmWgoPPQCNwqu7AjQ/ZU+y3TCB5BnexwGHm/EtDQlbn5g5bhvErOIisaGT73YO269TJpInE4guEIg9rTMH6XSRChgZM9I3HIEMhYlhD1cA66AW0NFhaMbJp8mmNk5Yxw84lHWnpf6g69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVN59JTS2flafklL/byRQ4/zbBQ9zlvhjHsBpiroudM=;
 b=uGNn1oXXIxPgxzGBqpFmoigL616b2dGE40+utAdHwQyap1hcxkSugbQmu4Snh7L7hWdqWxLw8qteYlxDrFVLFIZl5j939xS2BLiU1twPti3Ss314BqHJXArXKwslvwokUOHZZLNgM6T6jQ9a0WlLaGJX15X1zs3ZWzwu8bJ1LU8=
Received: from SN7PR04CA0043.namprd04.prod.outlook.com (2603:10b6:806:120::18)
 by SJ5PPFABE38415D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 25 Aug
 2025 17:33:44 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::1c) by SN7PR04CA0043.outlook.office365.com
 (2603:10b6:806:120::18) with Microsoft SMTP Server (version=TLS1_3,
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
Date: Mon, 25 Aug 2025 17:33:03 +0000
Subject: [PATCH v5 06/20] x86/mce: Remove __mcheck_cpu_init_early()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-6-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SJ5PPFABE38415D:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3f8565-9d2c-4cba-b9ac-08dde3fd8a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnFxSC9mNFhpSXkvVk5KTWpZUGxIU000QTRwSEtkWFhXYWZvRHNaVkhTVmxo?=
 =?utf-8?B?Z3JVV1BIZkp6cWNtZXF0dk5ZZXFmOXJwTFZ3SjJVdEJySjlGK0E4cDFIaURj?=
 =?utf-8?B?ZXBPNGFxM0grR1JlemtTQkdZdlNxMC9wVTQyZEVTOFZLKzdBNFBiNHdzYlla?=
 =?utf-8?B?ajdINWEyZ0c3WUtDK05WazBZSjNObEh3ZG1vdTB2LzBGT1huOU5qdDF0SGt4?=
 =?utf-8?B?WmxDT0lTWk5LdTVkVnRQcXVaQnB0ZEp2M09qOUJNTVU1UWFOZjFQZ24xOWlI?=
 =?utf-8?B?WjltUnFRZFgvQk9rRS8wbEg5NTVsM2VUTkRmY0Q4dERXc1hKVzZKL3VybUhq?=
 =?utf-8?B?b2VpUFN0aWsxVGFxUWo3Z2FlQmQ0NzZ1U3RIdGI1YWVSSkFjYkRaTWliT1pp?=
 =?utf-8?B?RWw1aWd5a3hVeVBvMFZGWjU2dFJlTCt2dmR1aWFUaUZsMWdOZUhuV2ovejZ5?=
 =?utf-8?B?NzQwbEhDbGhJZ2h2WDZqNUFub3BBTVNrZkJKQ0pCdmR0cm1mRnZSUVNNUGtn?=
 =?utf-8?B?NTJsRE1peENmeDFtcUlTcjY1bmRqQk9jMUFDZFlmdHRHYUI0Y2ozMnJlSTV2?=
 =?utf-8?B?VWxJb25EQ0Z1ZDNuMEtqdTFSVy9uREpSZlJvYkhFU1BHNmdRbC9GNCtpMGty?=
 =?utf-8?B?bzdEZTNSSWFFQ25oM0s1L01sYnhLNkNIY2JYYkxmam42d1JkV2xqeEZjUkJC?=
 =?utf-8?B?OXYzenQzRGpRT0JtZGJnUE5KWVkyZlFHbUlKWTdUUDZPencxSHJvamNzazBt?=
 =?utf-8?B?L3FjQlRnb2t0V3V6Q2xLbXZyZDBObTJGRkluRCs1dnRTdGcvY09UZDVKRitI?=
 =?utf-8?B?RmtvUE1VSEVoemQvQVVQRDBlMmpaU1RvK0dtSENrNWt4QTNPejhCVnFoUVVl?=
 =?utf-8?B?WHRjdlkvNnc4N3I5VmhkOTlTZEhldFRMY0NGMkhROUQ5cTVDRS9aVEdTcXBV?=
 =?utf-8?B?L2VmSGE2T204QzRXVmZEZ3QwMFRvV3hhREtLcFhtMFJrRUFBU1kwTjVrUDZT?=
 =?utf-8?B?TURrSHFuQUNRTXVTNk8zNEV4QXl4aG9rTXJnMXBDbnlrR3ZKWWliMVRGdWNP?=
 =?utf-8?B?bC92UGlMRzJMWGEyOWF0cVRXYjNvVmFQY0ZRRFdDWjJySTBFN0FCd0hWM280?=
 =?utf-8?B?RFB4Ym82SGxUcmdCd212ZGtsV2ptaTI2dXVDbE1nUS9TNHp4YmVlZU5zczJt?=
 =?utf-8?B?a0NYZVQ5THJiOUxkbC94SHJoYm5SR3pjK1FlTW1WaS8xTGp1V3JGZTZIMjk3?=
 =?utf-8?B?SFJ6UG5UUHNmUEpjQWJqODFTeDJIbHJLUDVkazJ1NDd4WkVVenJSUEN4S1pr?=
 =?utf-8?B?eThja2gwWWlOTm5vNmhCalBiTGFyWXQzVUllb2FRN3JPb3dhVFVLY0phUDVJ?=
 =?utf-8?B?RHlZT0V5cnpKVVlXY08rWXB2RUd0MEFaQnQ4RjhyRm1adHB6VWNEcmplR1VM?=
 =?utf-8?B?SG0zK1lhUU9XK3p5TXpWL1lpdU5ReFlSTUpscHJxMjZnMjM1bUdNOEd3U3pE?=
 =?utf-8?B?ZUt4VG1sZERMVGJObE1mVjc0b3RuMHJoazdBV0ovaDhEdkJhcWdPbnI3VlZM?=
 =?utf-8?B?THE1WkVZWERsSHlubEgvVis1eHBMenVHOVMyYWlveGNURUV5RG1jQUNMVEFv?=
 =?utf-8?B?VTlWOWNEbEZqYzlianZwMkU4M25jTWdmQ2hsNTlVYWZLT2dGQ1VPTGJQdkxt?=
 =?utf-8?B?OThGZGY0NXJscUJxTDJOTWZMTjJ2SkFZUjk1SXFaU2pac0ZYYTd4TVVEa2RR?=
 =?utf-8?B?dytzR05zZlRkaXZqWGw1YUh6RFlyTmtzamRJM3h0eUZxSlBrRy8zYUZVWlcr?=
 =?utf-8?B?bklYNXk5ZktPWTVETDlJUzZjM1R0VHpLZnliS0tpV2FLYXhkZzllL091eEJk?=
 =?utf-8?B?RGs1M1g5ZmNIVVY5enFvY3lBTzVSaFRMeC9kTFBELzF5MnFPdHpuRXowSlUw?=
 =?utf-8?B?NGZZRlR1Yk44THV4UjJRRVpzSFZ4OXpvSlVYL0IxOTZUVFE4dXN0SHZYMmM2?=
 =?utf-8?B?bTIxSG9WOU81U2h1WnN5Ym43NWgwN0N6NnNMeTBmTWpWTTREYktvZkV3YVdQ?=
 =?utf-8?B?Ymt0WmNYb01GUVlscjZoWjhnSnEwNmVmRWtBUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:44.7524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3f8565-9d2c-4cba-b9ac-08dde3fd8a9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFABE38415D

The __mcheck_cpu_init_early() function was introduced so that some
vendor-specific features are detected before the first MCA polling event
done in __mcheck_cpu_init_generic().

Currently, __mcheck_cpu_init_early() is only used on AMD-based systems and
additional code will be needed to support various system configurations.

However, the current and future vendor-specific code should be done during
vendor init. This keeps all the vendor code in a common location and
simplifies the generic init flow.

Move all the __mcheck_cpu_init_early() code into mce_amd_feature_init().

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-10-236dd74f645f@amd.com
    
    v4->v5:
    * Add tag from Nikolay.
    * Move __mcheck_cpu_init_generic() change to new patch.
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Update commit message.
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2, but based on old patch (see link).
    * Changed cpu_has() to cpu_feature_enabled().

 arch/x86/kernel/cpu/mce/amd.c  |  4 ++++
 arch/x86/kernel/cpu/mce/core.c | 14 --------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 54f02bda75aa..c7632da8b460 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -657,6 +657,10 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
+	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
+	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
+	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 311876e3f3f4..0326fbb83adc 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2034,19 +2034,6 @@ static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
 	return false;
 }
 
-/*
- * Init basic CPU features needed for early decoding of MCEs.
- */
-static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
-{
-	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) {
-		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
-		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
-		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
-		mce_flags.amd_threshold	 = 1;
-	}
-}
-
 static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
 {
 	struct mca_config *cfg = &mca_cfg;
@@ -2285,7 +2272,6 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	mca_cfg.initialized = 1;
 
-	__mcheck_cpu_init_early(c);
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_prepare_banks();

-- 
2.51.0


