Return-Path: <linux-edac+bounces-4676-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED67AB348F3
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2DA64E3745
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640CC312803;
	Mon, 25 Aug 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sXMHGWkL"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B2A31062E;
	Mon, 25 Aug 2025 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143238; cv=fail; b=Q0aXS/yK7ZVM5D+R6iIBHfwRjJzZAnKwv89Z45zjWP1HJJkp+lrG5YUD+RqDRdnK+iJaXUIXXHKl8gET0pR2tuyV+CZ3oVu9RHvhm0O6WFYBhSeKqXtV+t/S1X72GrBDLocerUhOcEZa1jOeAH7SBq5kHJdSDAxisQdkmJuBiyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143238; c=relaxed/simple;
	bh=vGdpBBC3VPZxEBIt96s7xztHjP/u9X2YFi149FY2D7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=j3/zyLTDXbRcHCOCf+yIjyqlBBWqQ3QIWZOPXN9wimnkGze5zFAmkX1zygDYpaE5rFMp0uJoMgG3KoZT8CvySdLh3/vbUvhXImZhzPBlBzA/gbAbSdJE/LbJ6Ea3oI+rO/z2Fqt07FO8EK4Fwi5mNMPRn28OzYdhgUV/b8W/dVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sXMHGWkL; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Be8qE86561zFfYHrw8KuxLXFw5C/9ASLolaekRv+mnMx2DFM5MSotabXHJkqkUF3IhZHHIARQjhrJ5eYs429Z5Dx8YOElMB8MZ4y+0f5R/qnIeuuWv/jJq/jsC0cYRpvyjyt9CutrPQJYb3Lvu0JpJ9JXRBY/VRSgBhoA468/ft+IOXV03KSZdZLLxXpWxPy7i0GaFQb8exF38Jovw7ei+MC/VH8rYIv72p8/j0PQdojTAaBOFa1OF62tiI0UKlKRaXoqzdUSfFsw3AH+GM2jDtN2LNzvmNcxKH4ebdGRxKsYcZqznxByZG+oTVZsHZGP+QVZN3qbeTAO1ojk+py4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCiIVbU5YN1ojuaaNiX4WDZFOkOf/eZY77L2u4nL4Y4=;
 b=Dxzb8WB3rSWxN5PEOb0l47ciu0ADF5G9w5T6cJfaapod//lFYJHIaJkzoQeA43ueyyu1LSRgi3bNdy8gzisUK8D6/BQ5ysm3LcuJ0LgRSLqk4R8Wzgc55MYe7xZBkfXQd6nm/VWvcZGr55XKGuhXrSPnd16YiXCqtOFXnqY5m0bWBrO/OYKucduce3oCTEWE3u3NgIk/J3sRdYWIwg6q8UGhNnwrLLfH31vIThUDAYYgbeBjBGgFKPV4N8rlPA0ejA7lE56z+a0UPiMPs/uCPzCCqneLcwCBzxKII14iTC4u+bMOnTwnnaIcs1szTQVuGNqJUZoIpCrV0owhztLRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCiIVbU5YN1ojuaaNiX4WDZFOkOf/eZY77L2u4nL4Y4=;
 b=sXMHGWkLNXp5T9QPNR5lTKmmyna8310iK2Idznbg9w4bxvIikLPZq8Edt+OS3M5rzZIoQ4Al477YwbA7L365scf9chuVKa8dmDClR5upoqAuw/ATzY0F3jivwLHFrLfkaA1duaEN1EBJ3LR3QftL6P8wKctrDI3XE6Vp/ZRI5r4=
Received: from SN7PR04CA0046.namprd04.prod.outlook.com (2603:10b6:806:120::21)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 17:33:51 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::af) by SN7PR04CA0046.outlook.office365.com
 (2603:10b6:806:120::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:51 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:47 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:15 +0000
Subject: [PATCH v5 18/20] x86/mce/amd: Define threshold restart function
 for banks
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-18-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 345f461c-0b0c-4b29-8871-08dde3fd8e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0x0QTIzbzdDRUp3aGp0OUdTM05rRFNteEMxaVkvbjZFb25FbjVGUm5GR0xV?=
 =?utf-8?B?bHBaWC9wbTFjbHZLd0ZtOTFvcmYyUzNtYXUzYTF1UlA5elhERXNITmhMckM3?=
 =?utf-8?B?cnNTeGlRYzNaTXJ2cUo1WnZFRXdxLytvdHllVktTZVdEKzZXbW84UGx1NFlE?=
 =?utf-8?B?N2xtNkRzT0xNQ05uUDUxNE1Cd1Vva3VDU2ZpSXRMdHZZRk44aE5lZU9NZlZC?=
 =?utf-8?B?K2NwWFpOVVBLRlBlbCttOUMyZGI4Y28xb0FVQkZQeFBDeitGS0FIUFdSOVBl?=
 =?utf-8?B?SENzdEc0eGcrTklicXpWeUwremFFdGJmZkV4bGI0cFRjalZXNkVwRDZkaEY3?=
 =?utf-8?B?alliRlFwaFRRdnB3dGwrY3N5NFNiUVNEOGZ6TDF1cG8zbVBsSlk3d1Byckpt?=
 =?utf-8?B?Y0N2dTR6ZGhiTkFFbFNhb000aEEzTGtRRnhSNDBGMzlFdDJiNUZMS3QxcVpZ?=
 =?utf-8?B?WEwwMk50OXFmSEdYakY1RURFMTMxNkFhK20rWXE0VVdTSklWTjUxbUxXamYr?=
 =?utf-8?B?ZS9UeDUzTEF5VUFjWlY4bHhFcDdONXNlaG42SXR3VExJNnZvcVBheVY2b2ZS?=
 =?utf-8?B?ZWx3aDVjMDIzT1FHaHNValZObEh2VDIvZURURHpyMWdUckk2S29iSlk1Y21B?=
 =?utf-8?B?OTRWQ2VqVTBKc3VTSU11bjdXdjc4dEVNL0hsSWY4WjNFTUdwQUZnRmJoRWVv?=
 =?utf-8?B?Y2dNSmtKeWpkU2cxcDZZcm5PaU1EdDlibHNGYXlTOFZ0STUyUW9tVThvMHNh?=
 =?utf-8?B?WVJxY1E3ck9FT0NMOTAzdnp0cEZGZTR1VFg4RXJ3d2ZoQ3pzWWZ2YTd6VWJs?=
 =?utf-8?B?S09udlF6NW1qVDhQUzNKQ1VUTFNrY2pOUUlyRjdNNTdNQnNnVnZtK1FOVmx6?=
 =?utf-8?B?T0NvRk51eDJycjVYVVdpWkc0NWVHRDVZaEdmamwxeVpRWDZ4N3lreVVud1ds?=
 =?utf-8?B?bDB1REYvVnFrZ0J1NTF3WjdTNFdPU2k0bG9yZVhwcEk4aFZtaWYrMTFoZ21p?=
 =?utf-8?B?NnhIeXVHa3JFNDg2L0MxV1pyT1JlUFpWSUh4ZDI3N3c0N21KcnBvT1EzbXZL?=
 =?utf-8?B?ODM4YjcxWG8zdm5nOGVkRUV5MlFNRzMxbFR0NEJoTnErR3JqczgvQmhDUi9T?=
 =?utf-8?B?MkxSbXFYUjVhemwzeFJBbUtDNVF2MklrYTJoY1lqWStzYy9Scks1SHlpSVBh?=
 =?utf-8?B?eFNCc2paYld2aDU4VEhyK0pZR0JPd2htT0J4MlZwRjBsOHFad25UUXVRMW9p?=
 =?utf-8?B?NE13UXVBUEtxckFGZHpmSlVnaG5yZkZJTi9RaEs0d2hTMTdYT2VaL0g3UUVt?=
 =?utf-8?B?Zi9VVnQ1MjkrOHhDQW4zZ1JUdkhZMlAyemVsemJOcXMrRzAwZnhhVjJjNG9W?=
 =?utf-8?B?bFVWZ3pGZDBtMGYzYXdsbHlGQXdGWFBqYmFHSkRsVmhYUjlWK1N4MmVTbnl2?=
 =?utf-8?B?TEk1bTE0ZVpwa2lVUlVneVF5WDZNTW96MlNRR0JtTFVTMERNd20rY0FQS2dT?=
 =?utf-8?B?KzVHaE9NL2xGMlZjdVFTWEl2WEQ2TnJMaUxjbUlNc09oTHR6SUZsK0xwQjRL?=
 =?utf-8?B?UTQva1poZjZ1MTJ4TGhwMVdEWXY3aFVYc2d2bElKRUlHSUN4dzlnSHlpL3gy?=
 =?utf-8?B?VkZwdEROZlREQmVlb3hsZXh1OWFuaWlFQmtoeTlWdEF4YXA0UFkvMGdZRTIx?=
 =?utf-8?B?Y2NnckdZOU1GNVlNTlFhb1NJNkl4c0k3ZVE3MjNHYitYYWRTMWlJVE9kSzFI?=
 =?utf-8?B?Qk5pc0hCYWxsd0crUmFYQmxmVzM0M2huWXFvU1MxMFBzMDNZaW9wY0NxQjBr?=
 =?utf-8?B?RGFoY1NOSlBONGVoV05aU0FLSk4wSSsrRzBVdGNUVUYxcHJnOHlmT3lGaENB?=
 =?utf-8?B?YjZ0L3FJbzJKcmp1OFlJdktXbkdzZVBneXI4eUY3SXRlejdOd2xBL2hTNU1v?=
 =?utf-8?B?Mm42bVlKYlBqZ3ZxbFZYc2RzT1R6MUF2bWdvZGRvaWhTTGFwais5OGYveVVL?=
 =?utf-8?B?eGY1QThiNCt3Qkp6dWRQbFhsUVJaYU9veVRwNWp4V2hwTkxsUGdjMzlGYjJh?=
 =?utf-8?Q?UjlISJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:51.1662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 345f461c-0b0c-4b29-8871-08dde3fd8e6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870

Prepare for CMCI storm support by moving the common bank/block
iterator code to a helper function.

Include a parameter to switch the interrupt enable. This will be used by
the CMCI storm handling function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-20-236dd74f645f@amd.com
    
    v4->v5:
    * No change.
    
    v3->v4:
    * New in v4.

 arch/x86/kernel/cpu/mce/amd.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index b929b09dd7eb..0c8ec431ebd2 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -469,6 +469,24 @@ static void threshold_restart_block(void *_tr)
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
@@ -816,24 +834,7 @@ static void amd_deferred_error_interrupt(void)
 
 void amd_reset_thr_limit(unsigned int bank)
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


