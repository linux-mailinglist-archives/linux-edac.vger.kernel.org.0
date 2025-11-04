Return-Path: <linux-edac+bounces-5331-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B08C31B04
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 16:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 071024F8623
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 14:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70160331A6C;
	Tue,  4 Nov 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xLfN+mtD"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E932ED5B;
	Tue,  4 Nov 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268165; cv=fail; b=uv+1FzSYBmWJJXt7DFQtnrKdHTK6Q8vgFPQGv8cEQdUmzIex/K0QOF4w2sa2Su4D3rUPxw6P0nD7/r+jOAJLD65EoJrUKMY9VKC1/cQtzOC9bmrGn5M84jbd5Ios1Zm/BDzsaqlOLk6x3r0zwWz3c/VqZ7JEQg5t+AX8OyjHv5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268165; c=relaxed/simple;
	bh=qE9DgStV68W4/+JSiD/FTV2amZjIO0rqbXzrAMtIlf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XhSk3X2kRO2KT4cZoi3jS8Iu2/lXO8ln/Ul8/kCVlIm/0dpUu5H64eNn2hB6kDtw/xMbkxCXXA40pmVPzmcc9R8lvtbREAyogD2+DFDvCFTrCd7sZpnJNM3BDgMLWOG1fnUrVxMAq+8stdo3JNCZ7RQ3caHMYGoDoy1zONw9KUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xLfN+mtD; arc=fail smtp.client-ip=52.101.193.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd387iBKzVzdiZvuBjgbxvyLSFSgU5w5gFyDFwpYJK+E84S4IxCGVf0mVhl2IgpAOqGyEPlSkqGiwG3zGGeh5M53hwHvL0mP7BhDIEC3fUMgFCjCQiLW10mapjuR5iLMxobBXzVGWzCPdBbwa7K7zn05IgkZHANAY1UluE7lMsiW7DSVL5t8PE84KdtNj3pZFwMihYISk0bSzx4CRkhhPQOVvprS6X1dEAXIyObmhZwiTYu0YdUqPyQHXJgCqZW8yh8dVhln4t9emkZEOle17Nh0I1gw5KbqkwH1tDrvk0oEfrLbPlUQRgCBgcgido9ZwtY38+G6IbDTovsV5reI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxN1d0LC0vfsfMLp9fixBT59rHWy6m4AyVF5VyM5szs=;
 b=C+AVaYarsuIR24nYvyK/X487enma3NvMoaGYVKFpxIo4K/cJt9u4/3dG8cHZ3z8pCb7zG1F3i9Ze7yhpxSc8/8MVQmw7+lDYOXWS5zUNwEdPcecbExGzB4qZ8uvpUxWVJhE8GqibpEVNBnjspf4Q/T7l0kDE43unzEYdqgOcA+6c/mscq95XeVQePov3X+V1mQ9jKiRB7GhyVZoqBD0zlvlbbMae3DV7OhYfu9AK5dZpsLmSZxQQpj0kF02TNYlHwzei71ZPMU+/O4hBmkoLe3xOHRGUWnR/SXbxE/emUjwv+rXVDTjqcpuLjSnr+9KTvCQyvXqSfjuZBf9I1IziuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxN1d0LC0vfsfMLp9fixBT59rHWy6m4AyVF5VyM5szs=;
 b=xLfN+mtDZWuNyireYzATs07Ki2G9d/bfgifgGzUAtbYAhEajpyFcZFTVcb92QynB/S09IZzWt6TQOYdF+yvCTH1c/DcsShdPB+1Xr9megPZKXcsVQOFed9ys6VlD7XRB1XbkrGlBiCauJy2KROueXh0Qnabxvj8w5iy0aidqJ0o=
Received: from DM6PR06CA0095.namprd06.prod.outlook.com (2603:10b6:5:336::28)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 14:55:59 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::c9) by DM6PR06CA0095.outlook.office365.com
 (2603:10b6:5:336::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 14:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:55:59 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 06:55:53 -0800
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 4 Nov 2025 14:55:42 +0000
Subject: [PATCH v8 5/8] x86/mce/amd: Remove redundant reset_block()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251104-wip-mca-updates-v8-5-66c8eacf67b9@amd.com>
References: <20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com>
In-Reply-To: <20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Bert Karwatzki <spasswolf@web.de>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e94b27-e8b2-4d42-0abf-08de1bb2441a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjluaGFMaVVNTnJWZ0lZSWdPVEZBYUlXd0lJU2lQQUVZdm1RZnU1czg5RkUy?=
 =?utf-8?B?QW5hL1F2R3J0K2JWNjYzT2RCN1IyNGk0ZlZEUUhhZi9VRGNScVBrQ0pqVnhs?=
 =?utf-8?B?bnRTME1TRFVXN1Q4bzlQSW81MVU2QkpaQjJrL0Y0c2tnSlhSalF1S2VEZlBO?=
 =?utf-8?B?VjhETEc3UlVlNlhONUdtRGFNYlMxTUxwNEtrWkNFbXptRW9tNkVKcldLc3Ro?=
 =?utf-8?B?RmxxNGZtemZaMElobkZ2dVNYd2RsbHRvdWZMcG84UW5tM2lNU1UzSWdubkxm?=
 =?utf-8?B?YnVPRURuYmdYdUora3RkSHlQemlTUk1GMG1la1U3Sm5DM1prTXozZ1A3Lysy?=
 =?utf-8?B?SkVUWWs2QVd3eFdzbXA5SEUxSnp4RmgzTGIzRGo4SVBYK1g0VEJ2dzg5UDVy?=
 =?utf-8?B?dzQ5YU9MWHo3OWVSbVc5K0lLdTI3V201c09WRVNqcUdudEMwNHloUWdkaEVJ?=
 =?utf-8?B?cHpic1hPeXE5M0hHcS9Vc1VjOGNBVHVHbEpGaVZINFMwZ1oxZ1NSQUZZcnND?=
 =?utf-8?B?RjhJNkNiSkdCT0ttQ2VqQmlpcEtQSXJtWlNLR1UrVDlQVTJ6ZzVoQkZJcVpD?=
 =?utf-8?B?WnIwK0tMcGhLdmhnMWNpcEpyS1BJazJqdW42N2FveVlMc3Y2YmtVVm5peEZ5?=
 =?utf-8?B?SVhZRTR4SnROK3FmQW5ibVRZY1dWZ1pKdXRlTFA5ekRVVFhieHkveW5memZ2?=
 =?utf-8?B?RUNvVHNzT1JoR0ZMNEovSTBUM2RmeTRPK0syczJUeGY4cVJVMkFJSGNENE10?=
 =?utf-8?B?M24wZkoxRm1QZVBvNE92R3dBazMvd2pid29ob0t1K0N0aWN1eUdXZUQrZEx3?=
 =?utf-8?B?NUJ1MStLcXozdlBlN0hxQVJjSEFHTkpWYTFNYXBBZTFkMDhkczJZRmJBVC9s?=
 =?utf-8?B?emcwMVp4ZjFIakJIMkZhQy9VeUU1SEQya3c1V1ROVVZ1d3BVMWxEQkpFZG1j?=
 =?utf-8?B?RW9tZ0ZyK29ObEdUVEJ1Nmo2c2xwNHNsRkdZNGVONnBJeXNUMmpJR1BDV0tE?=
 =?utf-8?B?L2QvY2FtUlNhai95ZzY3Nk9KTlZkQzE4QUMyYXlTUHFxSzVWemRkRjZlYTR4?=
 =?utf-8?B?cUZwSUM5bms5Sy82TE1PZlplWDk2Mkw1OTMxSG50aWlUM2swVXQ3OEZLNTVQ?=
 =?utf-8?B?MGloYjd0TE1BWTZVZmxWenErZkMwTjRSdWM0djBnQlY5TSt5Z0pCaWk1VGN5?=
 =?utf-8?B?MEw4WG5zQVRIMU1DMjlGbFNob2FITFVLSVBmQXpWZzBoNy9IRU1qWFFpRkJE?=
 =?utf-8?B?TVQ2UEwvUEVnMWNmdVNWTGdWUWlVUXI2SWwrT09DRGw1TzNHLzdSYjRtNFpN?=
 =?utf-8?B?RzE5TzhSQ1g5QjJ2bWxjcVFQUWRtVmdrRUtGUjlDS3NlUG9lZjRDVmRKUS9X?=
 =?utf-8?B?SGZycGFsUThmSWZvNkY5QUNLWXRtVmZBb0djREsrNGFsQjVQT3doditKQkky?=
 =?utf-8?B?ZG92dTlBWEd0TXRZR0dkeFM0eEZDd0d0L1U0cmJzR3lBYzJPTDUrdmcvMFdr?=
 =?utf-8?B?NlFyOVVuRHA3SEtac0ZEUVhqKzJhbEoxaEhpOUFWYTlnMkZ1SmRuVzhGSExa?=
 =?utf-8?B?RHc4bVZVdEM1UTZ5cVE3ZGhFNmlFQzJoWVdDSTlYZ2cwT1RrODJVcnp5Rytl?=
 =?utf-8?B?aXNDbDBMbzZGeFdWWkVydzMycGtrb3hCMFRJeW1CY1hIRjRtenFKYkJYcVc2?=
 =?utf-8?B?K0NNbnBaZi8vQ2IwNlA0RVZsTTFXQWVXSmZLL0dINy9yQmJlVDQvMGhrUXBz?=
 =?utf-8?B?dzRwc3FJVGk5emcyV0Z3NituQ3pIRUZlSko2SmhLd0ZNd2tpUFRrNWU4djgx?=
 =?utf-8?B?cEpnVzVuNlNYUUsyY00vaVo3WmhxenZ5ZVJObVYzWCtFSzRVQXdaSnZqMXV5?=
 =?utf-8?B?dWJSUWRGV2J5a1h2c1R6N0VUdE81Tlo2U1ZHakdNdnZiYitIS3JHeHBLOEh3?=
 =?utf-8?B?ck5nVDhHbFdDa1hWdG91TTF6VkgybURKRXhGTXZ1eU9yRGxvREtHbTBTWjN4?=
 =?utf-8?B?VDVQZzlxYThzMlRER3JHb3NNOE5kaDl6eHBlbHJxWWQvQzc0T0Nva0lwdFQv?=
 =?utf-8?B?UkhWYjFObFl4Y01DRSsyclRmL0UyaURRWXhNSWJRcDNiWE51dTVVTnNTRzc3?=
 =?utf-8?Q?S/4M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:55:59.3068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e94b27-e8b2-4d42-0abf-08de1bb2441a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236

Many of the checks in reset_block() are done again in the block reset
function. So drop the redundant checks.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20251016-wip-mca-updates-v7-5-5c139a4062cb@amd.com
    
    v7->v8:
    * No change.
    
    v6->v7:
    * No change.
    
    v5->v6:
    * No change.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * New in v4.

 arch/x86/kernel/cpu/mce/amd.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6d16b4589eef..af2221bcba96 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -812,29 +812,11 @@ static void amd_deferred_error_interrupt(void)
 	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 }
 
-static void reset_block(struct threshold_block *block)
-{
-	struct thresh_restart tr;
-	u32 low = 0, high = 0;
-
-	if (!block)
-		return;
-
-	if (rdmsr_safe(block->address, &low, &high))
-		return;
-
-	if (!(high & MASK_OVERFLOW_HI))
-		return;
-
-	memset(&tr, 0, sizeof(tr));
-	tr.b = block;
-	threshold_restart_block(&tr);
-}
-
 static void amd_reset_thr_limit(unsigned int bank)
 {
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	struct threshold_block *block, *tmp;
+	struct thresh_restart tr;
 
 	/*
 	 * Validate that the threshold bank has been initialized already. The
@@ -844,8 +826,12 @@ static void amd_reset_thr_limit(unsigned int bank)
 	if (!bp || !bp[bank])
 		return;
 
-	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj)
-		reset_block(block);
+	memset(&tr, 0, sizeof(tr));
+
+	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj) {
+		tr.b = block;
+		threshold_restart_block(&tr);
+	}
 }
 
 /*

-- 
2.51.2


