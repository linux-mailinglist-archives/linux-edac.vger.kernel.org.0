Return-Path: <linux-edac+bounces-4991-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB94BBE738
	for <lists+linux-edac@lfdr.de>; Mon, 06 Oct 2025 17:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB8B189A043
	for <lists+linux-edac@lfdr.de>; Mon,  6 Oct 2025 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C49B2D781F;
	Mon,  6 Oct 2025 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XNVof2AW"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192F2D77FF;
	Mon,  6 Oct 2025 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763464; cv=fail; b=AbNzO61TODduCMQnWblnFfgJVrkR0DWJGoxRPmhBshy/hI6SXkAamztUDPz7rrnBUsCgbTLOoOkAcfuCxvYb3MjHN2Vnny7Ajoa2rGrUz1zvDKnRvGWd720FrXzNvZEzEUwScDrCGXuT21P2vu4JO3ghNGv8BKuYKoyWKZRGwuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763464; c=relaxed/simple;
	bh=iF+TLHuV7O4IwewzupVNrTAn/z6g0wtIbGocU/w6Z8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Njqs1bKCUfYVJfvl4OQq3PjmWkh3Mvx2BuNEOzbmnoA1vTwPMluiRKHpguGYBDXqWC5C85ekrsJvttsJloOVHA/0RgEQulMrB2xrsJg4ApdaF1B08tE061jdX+Uj6oVIk9ICwWdxW8NjT7Icy+dSjQkshmqj8qDtlx165zFdvw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XNVof2AW; arc=fail smtp.client-ip=52.101.62.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEd73ybx9aZxE/x7Vp/lYOhdh19H5Qwp+TTZEs0usZM9caYWGHFptPM+gespEeGCYAvCt4ZVk9eslGzB4jvBIkH6sQPXKhesK5YDdOq2FF+D4teLeJO6ZHye7A6SF/EeSQbMv4KDPGZ1lR1Yx6mQoR2p/vTjXJJl8DYPGHQn6VVOMyk7O/1r5YoUZXyTDKCRpdsnYdu/mXPaPLhLlpWimUMlXKyTwWkC3GuCoBIaGuG30HVWPmlhkQIqzUsEaoE7SuuxsJITgrzfodRK7keOwivoWR97dEIED//KAd/GOEsAQhZs0L7ERCDbvCQO6VzF5g5dUMBsSHBg/eD7J1DvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+a3uz3RS+Kn5yb72yRmmsA8GfRwWT32C9RYfl+5Q8I=;
 b=VK+3ipzBE6ul6XGPSKGXjxVFWZinWMZf47qJzKd6UCVGQWc1714bvDma+LKMnJFfERTdgCjM5oItWm+YKuxFhXHGVnZ6ITw93CuyTGqoi4SQt+CZYQAMo8629sO+CMQtMlFFU1NINHCdATcd2+K1LYV60Lqg39S2l5KTgHSL8lbdCcwpqde310wkWXar01+OD69/OY4pJJScDJ66fLRIJLcn3AlGlWbfFPdcIeA9tpXkP4fTdBM9zy1tBoQVV+uLoi65ax/d6D52GmtVrXPbushWdgchpexnToDsriEcDnwkk+xuH3aR1YnjbYwwgOyj1XUQk2sRnl8Wp26piKyCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+a3uz3RS+Kn5yb72yRmmsA8GfRwWT32C9RYfl+5Q8I=;
 b=XNVof2AWI8D3bx9AOesmQD5JXP4MSOzW5D7AVvcQl5G6DFKWjJx9Qz4BDhDjhQnqzY6shCJnBjBSf0y4uWf2mNoNN1zzg9UiA+ofFnVKrDr/vGNHcEcKfcvwtcIcrixcjtNMeSkxpo9i/u4Qyb2BJtiOTpaTQd1jANJ8gn1rnzE=
Received: from CH5PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:1f4::17)
 by SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 15:10:51 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::f4) by CH5PR04CA0017.outlook.office365.com
 (2603:10b6:610:1f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 15:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 15:10:51 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 08:10:50 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 6 Oct 2025 15:10:27 +0000
Subject: [PATCH 3/3] RAS/AMD/ATL: Return error codes from helper functions
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251006-wip-atl-prm-v1-3-4a62967fb2b0@amd.com>
References: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
In-Reply-To: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Avadhut Naik <avadhut.naik@amd.com>, John Allen
	<john.allen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SN7PR12MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 81527803-ef02-4161-e729-08de04ea89d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlpRQTJsa25yQmR1VktMYytkREJPVGkzRUJ5UnFJTUNnQ3Y2bmVwVGlaZHN3?=
 =?utf-8?B?bUJpdDFkViszYUJ3U0FaMzlpc0pITzNLSFNzdWZYdTd0ZkNsMkIwKytqZ1Fs?=
 =?utf-8?B?bmxra25HVmgrN0tralNGcUpiMXlpMHA3bmNvbGp6RVMxbWJrNzVkbkZ4Z09P?=
 =?utf-8?B?d1ZtRTdQMjk4dEI4amU5bDRoMHYwR083NWJTUURUdUs1Y0w2UTFWbEVEdlhB?=
 =?utf-8?B?R1plYVVML3JiR1NtZ0ZLKzlzTnhHRUpEVjBnQUpHb0crMm1OQXdHT0gzcklP?=
 =?utf-8?B?WUJjdEZYSW9XMGswWGMzSk5tOHFnQjBWSWpTOG5jOWRtUkxqdkoyYkVrZTVj?=
 =?utf-8?B?aWFOWTlDUTB6dnptUTdSNGl6a3NBU2Z5aFRjczFvZG85WEFLYnRiQ1N1QUZ6?=
 =?utf-8?B?aWc1ZUdzejk3ajVTeU1qVGlSRHp4Ti9tWG9WbWo3bVdJZHZEaVB6K1Qyc1l6?=
 =?utf-8?B?SVJrQjB1c1VWcVpwc0RCeFRnMEI3d1ZIem80Tktqb0h0aVo0NG5iMnlEY0NL?=
 =?utf-8?B?VEwzQmJsTjZxRk0xczFMYXpURnFzT2pQbDI3WkYrS09keXNRdUtDMm4zQjYv?=
 =?utf-8?B?OUk1Z2ZKbDVsakNTQzhjWURuTUh3VlRvU2E4Wi80S29aTDhhaWdrWUJrWWQx?=
 =?utf-8?B?dzN0ZmZxUlptS29QVWpMMk5pRFJZejZLMWtjUCtDK1NvSi9GR3JSVDMvaEZQ?=
 =?utf-8?B?VDBpVmtzdy93dUh5TjdnRlc0RHY2Z0xMYmtmN2hMWVM3bVFiWEpJd25hazRO?=
 =?utf-8?B?RGR4Y0c2NnRoc1Zob0pxN3FOUFZmMDF5WElqcGc1amRuU2dIVWJnbEkxQStq?=
 =?utf-8?B?K1hwM21xRU5IbUM0bDhpNVRHcXF4QjY3aTAyMEFQT0hqNHB5RFgwaWIybDlh?=
 =?utf-8?B?VlluNkFiY20rTVJON2dDMzV2THVwV0YwcTFwaE9YSEJRbkFXWVFqTXRRWUZ4?=
 =?utf-8?B?ckhRWnhzdTBHblE2VzR3WndNVDNNMC9TdEMrSW16c3dKSlNnbTJWTS9KQW1z?=
 =?utf-8?B?NjA1WHRDNVJrMHV1bW5ldS9qU2tVVFN5Z3ZzL09XanRHTEsrMHM2RlA0bm5y?=
 =?utf-8?B?dE9CWjZucGIrQkVmaXNJSkk4b2EwSDdIS3NJNXlxZXVqT1p4TGZQeFZpSzF0?=
 =?utf-8?B?TFdlUC96WXJQNXZuT2FCWFFXZjFJNFRteVFiNjRndEtma1hqd0o5WCs2WXlZ?=
 =?utf-8?B?ZmNEZnY4aExaYnFPeFZLUEFxOEdvRHJNejhwSzFNQ2V4Qk5WUmdYWVpuMUJk?=
 =?utf-8?B?UUlMditQV0g5K09pcU90Si9XNlB4eXJsSUlxR0pRTkR6a3VxL29YOGtsak56?=
 =?utf-8?B?OWlxdDJYYVRyWHI1dTdib3ZidTNvbDJ4cXVIRWtLcFZCbG90M3pMbGYvdVhl?=
 =?utf-8?B?L2xvR0xwTmhJNWx1UHRINGxRM2x4RFY0MS9SZ21yUmVmUmZoVDRTTDErYXlF?=
 =?utf-8?B?QWkxejlYZlNnbWUzZ2xjUEJmNEtCcm5zODV5cUt0RTUzbjRvSjBmbUJZZmRD?=
 =?utf-8?B?dGVwRVhaM2dCY1o4RUtYK1BlNGdIV0U3OE85VEIyOXBsKzVXK0x0bUlWYitT?=
 =?utf-8?B?akdoQW5GVEFxcUxmbTh2Y0dBdFdZWUdSalpWOVh5Q3hYLzZQclcwdnp6NUFo?=
 =?utf-8?B?aDdmYi9aVFBaNTZyaEwraU1ycVRDbzg2ajZtM1EvcU8vUlBnelRYWEhrc1RM?=
 =?utf-8?B?K2tvVmVteUVWS0ljSldZUmQrTVM5Sm5hS0Z0QWQrL1JLM2VhcDhOWjRFRENV?=
 =?utf-8?B?amdoUEZpRm5GL3plOUZlTjErK2l5M25vVlZ4YzNDSzZyQWJmVGI3VHNKVllE?=
 =?utf-8?B?b3hPM21hWjJaSk1LTGltMUo2YVNjSiticEFzUFpDLzVIYUVaZ1E1QURBZTlY?=
 =?utf-8?B?OFJNTmpnM0FsR3ZqWUxUNzNqb2c1ZThzZmxnZ3NSbzNzUUdaWmpMc3JzaWJ0?=
 =?utf-8?B?QmNYZ2RZM0ZJcHg5bUNlbEVxZ2RjSmtZb2NTa2F2K1BkZExKUzhXYk1UVWVt?=
 =?utf-8?B?bTVYZEh4OUp0VGhic3d2OFVEclhhZnlWMk1ERWduYmcva0tERGlSc2w5c3Jj?=
 =?utf-8?B?eGxIMUhHcmNjY0I3Ykp3TGxiR3hTWXlhTXIzdWZLSXBFbXZ0R0YwUjN0bkVr?=
 =?utf-8?Q?zw7g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 15:10:51.3807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81527803-ef02-4161-e729-08de04ea89d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603

Pass up error codes from helper functions rather than discarding them.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/amd/atl/core.c   | 7 +++++--
 drivers/ras/amd/atl/system.c | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 4197e10993ac..0f7cd6dab0b0 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -194,6 +194,8 @@ MODULE_DEVICE_TABLE(x86cpu, amd_atl_cpuids);
 
 static int __init amd_atl_init(void)
 {
+	int ret;
+
 	if (!x86_match_cpu(amd_atl_cpuids))
 		return -ENODEV;
 
@@ -202,8 +204,9 @@ static int __init amd_atl_init(void)
 
 	check_for_legacy_df_access();
 
-	if (get_df_system_info())
-		return -ENODEV;
+	ret = get_df_system_info();
+	if (ret)
+		return ret;
 
 	/* Increment this module's recount so that it can't be easily unloaded. */
 	__module_get(THIS_MODULE);
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index 09664b0ff8a6..13c89ef2c487 100644
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -285,10 +285,13 @@ static void dump_df_cfg(void)
 
 int get_df_system_info(void)
 {
-	if (determine_df_rev()) {
+	int ret;
+
+	ret = determine_df_rev();
+	if (ret) {
 		pr_warn("Failed to determine DF Revision");
 		df_cfg.rev = UNKNOWN;
-		return -EINVAL;
+		return ret;
 	}
 
 	if (df_cfg.flags.prm_only)

-- 
2.51.0


