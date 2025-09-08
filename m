Return-Path: <linux-edac+bounces-4756-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54075B493FE
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FADD20606C
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A0A3128C6;
	Mon,  8 Sep 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LKr+Yq9Z"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD2331283D;
	Mon,  8 Sep 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346081; cv=fail; b=Wz9OuoneIBS1jFwdaYGZiY0PlrGe40rqRMqnROxcOYCY7JhweqEQNVSP5EPz+q5oRr33zBxLhi+10BwX74KB1OVajlP0rKyKTumZX0V2ApX197Wf86KhqbuA7dgEB0zx+B3gfYVUO9OfHIDsSxBHMnExF0lm14Iu0HD1y3yZ6p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346081; c=relaxed/simple;
	bh=aTzUmDazVBWlrAXt2ZNB6Bph8ma/PkRduNso1QAIcWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fkn3894VPxXNEqu63XKMljjYaWvT5V9LCTPYAXuvZ2upiPyw3wouPZ0BPar1XuURkV+uvqLG9mI2G9dYHZ9T/7qESktVVedqqJxE/mZ79aPf2/nOVvI9Q2wYCFzHNoufcft/cQTqQpcY210jMfVYsaXHk5k2MpEh2oBjF6/LpwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LKr+Yq9Z; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjSD/0+E9wFcSE6K7avFZ5sbBxkrdPXyR5hqYVaMLOO6MCDMoQCLHl9idBFIKuCStfLUHxaRBX4eeGPQY5FFHvybc91J1HcAFVtmsk5SNY2uTUMaLApN7YwbU68SL4tXnJCVDef/C6PSBXyy1xaKvIKJn5u4cgdoRc3I0g+IFuILmiy2d6eO9ljXDh3aNZggbuag59FuMvUtJtCnppezIaGrbYFVj3KXIpzoiUgjZt/qD9iCxp6g1EkzKBgRV3C6lS3cssdwpXsDQc8RsxfzrPwNMyavUvIHrssHMy8BY2YCntxk7mmQv+7yRd4TALU0RexHHeNdfA9qX6gYFnFvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnCtVg9qsj8JXTFJXZmRN8MD7eTzh+ti/xsSQ0Dji8o=;
 b=YoiWh0Bke3XQnV+vqWSgeZImJqv7766sfKHD44kFuIQCFx71xWGb+LzogtvRk7zkE/rzKnehUyn0yVD5mR+2QDpGfLsv7jwWPCis1sLOAIh7RJkmvwcqZW8XccufcoMj16xfaYqacnls5pEJI+T/cOIXEMl+Wn4YPH/Oe3yV+Koo6EraR3leD8N4HYTCxT51DYKDhMsKq3/ygqSDz/8xyob0LwyI151uykF8x4pc4ZVpJzrUST9e4gFJHqsmZ+zhhcQ44I2bPA44CYGgJKaoWGC4k+90Ed/uDiKBl94yzWjnrbJmpeDGtAfL2yjawtslrjtYtfGAyac0zMZFVfv1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnCtVg9qsj8JXTFJXZmRN8MD7eTzh+ti/xsSQ0Dji8o=;
 b=LKr+Yq9Z0kFuZYisH8Q0x5nZFFJYV+FH172bNCrfwmd237x8citjNEXqTkR6rOzStVAUKvQ4sU5k8GO1FeaoXsVC7lJW/rSAfrJ6Y+kLEGSdY4HUhvvI8QhXYniLnnrNCLqS+dxETna4zBnbVMktcc0y5lsmlxOR8EOhxxyLAEQ=
Received: from CH2PR17CA0006.namprd17.prod.outlook.com (2603:10b6:610:53::16)
 by IA0PPF170E97DF1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:41:14 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::1b) by CH2PR17CA0006.outlook.office365.com
 (2603:10b6:610:53::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:41:14 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:41:02 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:42 +0000
Subject: [PATCH v6 13/15] x86/mce/amd: Define threshold restart function
 for banks
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-13-eef5d6c74b9c@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|IA0PPF170E97DF1:EE_
X-MS-Office365-Filtering-Correlation-Id: 50cf0c1c-7bd8-40bd-954d-08ddeeee24e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THNnMWorUmtaTnFEWTZIZ0lrZWo1YVFTOW5OSzA2bGNJK0JlNzVEakpuSjlz?=
 =?utf-8?B?ck1KaWM2WGk5SFFYTjZabS9pVVFseDdaWHpPRDlYaGxFeEY4dHc4ZUd4Qjgr?=
 =?utf-8?B?clYzSVNIaVczT2RZVVR3Zzk0Vnd1cXJTWndMWnV0czA0ZmEwMlVtUzJWamNO?=
 =?utf-8?B?S2VQQlA3RllGS1piaXl1VDU3SGNXa2tOaXgvMlI5bUdrSDFIc2Juak93YzI5?=
 =?utf-8?B?RDlJQWMxNUZJRWFLNW1WMjUvazVIdmY1aEFwRFBmemROYmIwOGJEVFVPVWtF?=
 =?utf-8?B?MWNTQWdXdS9iOEZITGQzUTlQcTVoUzZ1cG1KNWxEdjM0RHpTTmtFZWdPSG1l?=
 =?utf-8?B?WE5RNGZoZVBWTDJ4MGhpQkZsTExpUDBmaHcxSmowTEF1cVhCekp5dVpSRnhh?=
 =?utf-8?B?MWI1cFdmY0t3UnRTN01Mai83YzZsMFR1L01FUjFoOEN0YVNBTEpnTkticGMv?=
 =?utf-8?B?Y01RaGdpeitEMWEzRC9UK2I0RnRkODZwZ1JFblA3VnJnSVVpblBrZkNQT3Z0?=
 =?utf-8?B?c1dZWFh1MkVTa0xHYXNpU0lVUEwrVHRUV3JSY0E1WFBNNVFiSzJTOHFQVHBl?=
 =?utf-8?B?anMvcGYyVTEwMm1Wc3BQYU9OeE83TER5Vi9kMVBPbk1UVjBtYUxaZlc2azJS?=
 =?utf-8?B?S2xYdFRISkhYSkYvNUVXZlNlOSt1dWNEQVVqcm1RMnd4R3ZYRkVZNlkvWGdL?=
 =?utf-8?B?ekk2MWR3NnprL3hkMDhDQ29lTnFSOGtmSTNvT0Vyc25WbFhFT0MxdjJIV29K?=
 =?utf-8?B?c1ZmamJPWGlkYWFSQWpsNGRCUkJPMktXU1NIazdNSkdnYWJadlczOFhmVXUy?=
 =?utf-8?B?VCtrSnB1ek9PaGJCU1c0NzhhTHpGNUlWdXdadE9DVmRFdGkzMmQ3Z3Z4Y1Bp?=
 =?utf-8?B?TTJCaHlHbHJJeHpieTNtTkhYa2tOZ2c3N25JVkc4dXZWRGZUcFJzZCtuUzlo?=
 =?utf-8?B?emcyeHN0VE1TL1JySHdtNmxBSExwYUpNRlVCcGpUN2N5cG1OR3VTZkVuVG9Z?=
 =?utf-8?B?V2h2eTZYNlEyVDJ3d1FjNCsxUEZmOWtoMmtwTlk2QzN5OGVOT2xoSWVISDBa?=
 =?utf-8?B?NmNTOGw0NkdNdHlkZXF3cEdxcHpWamdJM2dzeDIraUUra2pqTU5qb3JpbE4w?=
 =?utf-8?B?ZFJqQU1ZUzdoNGZjS3dMVTN0Z0t1YlREZUV1d2xwWUtHL0IwVFZCajlrcVoy?=
 =?utf-8?B?bFVtWG5RUXVieWRTc0lTbkNBd0l1MDJJTWpIRFFHeDgyZVlWdWJxc1Q2aWN3?=
 =?utf-8?B?eDYwUGxiN0FHb0pEYjFzVWlsRHZ5Vkt3SzY3czNhdzErWkpyTFY3UkovL0lP?=
 =?utf-8?B?cmdwS3hoMlU0dytsYUV3R0ZXTWdmMG5SMUxSZmRLZW9zK2t6VCs4Q0E5czF1?=
 =?utf-8?B?TVExMkZVRDliaUpPMXBkYVRUMWFoNFg4MUJNc1pVNit4QVhoaHhNd3p5QnZM?=
 =?utf-8?B?SGIvc0N5ZDJLY2FTS1ZKeDFkQmhRdk9CWE55RjVPUU1VbU9ueFl1TkZLcFdW?=
 =?utf-8?B?d29lS21xdmljZnErRnhHWDZST1pvc2hrd1RoOWVpd1BXczBmZ0FIWW5CU0JK?=
 =?utf-8?B?TjI3bzBhTUQwZ2lwNjh6WlZ2Zi8yWm9iSlppb3hUOVVtVUNZTmxsNHkvNkVG?=
 =?utf-8?B?OFFJRkEzeXZuOUZvSHpjYU16dEVmWCtpUlRvejl5MDhhVzJoN1RBZHRNU3RN?=
 =?utf-8?B?Y2FQM1MrSjFOVW9sbDJ1T1YwRXNoWVQzMThmVXNaVVBkNUZvdEVlMHRXWncr?=
 =?utf-8?B?bGlwOXA1bUNuemFQUTV1aVRxam82WTJPNjFINVVId0FNZ01pT1JqaDZkZHRl?=
 =?utf-8?B?VkFDSVdYalUwVkNtVXJYai8wTGZ2YkpGZEh4NGJDd25XWmZETjRJcGpzSmpF?=
 =?utf-8?B?L0Jlcjd1YmJvTkEwdEhLbWJHOHNPYnhlNVhiUGlFbzdSZlh6OW5FTEFrVDhi?=
 =?utf-8?B?d1RPdkJKOWtETktadTdpUkR5Qllka2d3ZE5nMy9YbWUxRnNLYkNKRnBHNlY3?=
 =?utf-8?B?MVZnMVVJQkxBVkRNNjMzN3NycHBWbGM5UkpVOUpuc29rYW5FZ3M5dWxhZ3F3?=
 =?utf-8?B?NzEzejFZOGtJcEVGaFdtL3E3NDhxcUZCZzE0dz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:41:14.4241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cf0c1c-7bd8-40bd-954d-08ddeeee24e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF170E97DF1

Prepare for CMCI storm support by moving the common bank/block
iterator code to a helper function.

Include a parameter to switch the interrupt enable. This will be used by
the CMCI storm handling function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250825-wip-mca-updates-v5-18-865768a2eef8@amd.com
    
    v5->v6:
    * No change.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * New in v4.

 arch/x86/kernel/cpu/mce/amd.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9ca4079ff342..fbdb0cec5737 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -471,6 +471,24 @@ static void threshold_restart_block(void *_tr)
 	wrmsr(tr->b->address, lo, hi);
 }
 
+static void threshold_restart_bank(unsigned int bank, bool intr_en)
+{
+	struct threshold_bank **thr_banks = this_cpu_read(threshold_banks);
+	struct threshold_block *block, *tmp;
+	struct thresh_restart tr;
+
+	if (!thr_banks || !thr_banks[bank])
+		return;
+
+	memset(&tr, 0, sizeof(tr));
+
+	list_for_each_entry_safe(block, tmp, &thr_banks[bank]->miscj, miscj) {
+		tr.b = block;
+		tr.b->interrupt_enable = intr_en;
+		threshold_restart_block(&tr);
+	}
+}
+
 static void mce_threshold_block_init(struct threshold_block *b, int offset)
 {
 	struct thresh_restart tr = {
@@ -814,24 +832,7 @@ static void amd_deferred_error_interrupt(void)
 
 static void amd_reset_thr_limit(unsigned int bank)
 {
-	struct threshold_bank **bp = this_cpu_read(threshold_banks);
-	struct threshold_block *block, *tmp;
-	struct thresh_restart tr;
-
-	/*
-	 * Validate that the threshold bank has been initialized already. The
-	 * handler is installed at boot time, but on a hotplug event the
-	 * interrupt might fire before the data has been initialized.
-	 */
-	if (!bp || !bp[bank])
-		return;
-
-	memset(&tr, 0, sizeof(tr));
-
-	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj) {
-		tr.b = block;
-		threshold_restart_block(&tr);
-	}
+	threshold_restart_bank(bank, true);
 }
 
 /*

-- 
2.51.0


