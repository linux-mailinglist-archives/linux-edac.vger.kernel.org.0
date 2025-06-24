Return-Path: <linux-edac+bounces-4230-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2E1AE6881
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A796A1D65
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FA72E1726;
	Tue, 24 Jun 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1FHs/HNl"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3FD2E0B66;
	Tue, 24 Jun 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774605; cv=fail; b=J7JjET2Z5CreTa4XLWgAEPZjZPEyDwtkDa00TWgmJo1Qxy31U+Cikgro43/4TyUMBFsxHMUVQnxTZlk7o27mBZsBFZ4GGqiheV6+NCuNv1cpxxFzvkYmhOToCR+NF5szNP50ukgJATgGEgzgjEDXUEm2N/Xa7elaQOGuSG6KJZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774605; c=relaxed/simple;
	bh=NgSMfrqL5u6na8jgFKIh5RkyjmfnD/PgY7J5aaM5Zyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dSUKeE7T3wBEfPM7hbPTeTpoFcjvBs5H5uu/bc/J5dNOG3CaKzcqXV2yZafaYhHNIsDDUib5FlAPMNbqf69TV9G2CMf1ih852qkF4m9DMuwkK62o9LOMjNHapmaG/V//6tkAAeCzumA/SQxBEJxiXUcoyFeb5vSUGaWvYjTMk5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1FHs/HNl; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ec3dZmZpro5cHo45+3oUoFtqBUVK1uL9DiEEYnf41XRwTd8TzZG8bSRm+oc2Tpi1uVq7EXrXFLXKaNLAccViQjPiYF2P2mtadAQ6mTXyZvPTSbYgHEhvR+8Kz6fdtekrAiD2u6/CyF055vcDsI/mhnZB5nNVviaBwBYXSnDX/kyr3Mg9fJvh71j54kP+QfQyghVhmlZBilHZzclDVTs/PRT9imxTX9Alq1jjXWtdXS1iQOlpyvbVwrnRkyxAVQaUmUXBb7zy/aVEoTo6UhD3B9R5rcS6y1D4Umf0aBq60sHPd0lsYjm6kCITeDsNlGYVoA5ueHz0v5CRnuCCe/OfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4Dq9t3i16skBd1YuUjYHECsGxwvBT4FowuJZ6e+m9Y=;
 b=G2SwYeUQmOEaslixGdjqTL/SRZwGIlyM6boFPY8tiUSCweEoou2/Va/2Ggor2/gpHy3AwkUgkYTe9YpDrEl1VLDbDi2pUcizmTmI6ZagQqksYb6uwWCWpYw4GhqIp7gj+YuQf6fkIy2QCWAh6pXTOdEySVh3YAWmSDRZYYZA6a7czg/X0F+PduKaSJ2s+bmTXoNJBjFWvrOEIzc17FYbWIxeQBxkh6jL8AsErS5gkEW5vRo/Ys3W9xag0k46gLEma26GH0O+9ISKyco7WKRc3cERZvgC5yKvl2JoTfYBWQ2m1XhNPipIlZqrHuRdIRfvt+4KWjxBpCmmpAMBb5q3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4Dq9t3i16skBd1YuUjYHECsGxwvBT4FowuJZ6e+m9Y=;
 b=1FHs/HNlCQHr9l/4A89nGFf98tz1ITeXgeRKnl7aEREwGuB1c3PSAd+vB5tIuNMR2BGA5EIIvcoxn7+yn/opPUJanB8KVfch65NZQqSO3aHh8bCL7LzZHhLYGgOoFzD/aegpAIwTKgQW8aTh2tq3dCrf7A85UVGzHC9FTgDY7RY=
Received: from BYAPR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:74::20)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Tue, 24 Jun
 2025 14:16:39 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::e3) by BYAPR05CA0043.outlook.office365.com
 (2603:10b6:a03:74::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Tue,
 24 Jun 2025 14:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:39 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:37 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:14 +0000
Subject: [PATCH v4 19/22] x86/mce/amd: Remove redundant reset_block()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-19-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be7f1ac-e4d5-4ef0-7cf8-08ddb329bcbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnlxMmxWOGtxM3ZkVy9NY1lNUER3elZKVC93SWVhb1ZZSzVFektnZ0JZZHlk?=
 =?utf-8?B?Qk9QcWhXOUpMclQwQ0ZzdlJLV0Rjc0QvY25QRDhlQkR3SUVwMlY3bWR5Q0RR?=
 =?utf-8?B?R09MVVIyY0VDSStrN2huTmNxRnB6NnlNWm9KVTN5SjdpR1I4dzN5M3hyUldt?=
 =?utf-8?B?dFg0NGg4TDRpTXpoaEtGZHNXWCtFWCtzRW9jVzNncWFUdUxvSXhjOXVMVmlS?=
 =?utf-8?B?aEFtNDNiMlJuTlZPbWVPS1kwTnE0dER0T1IwVUdYdGZIVzM3cE81aFk4b3A3?=
 =?utf-8?B?N0tzcjkxZFM0VzlqZEw2NS9Ib1NzZ2RvV0dPT0RoMnJVNW5waUxIekJJcHBx?=
 =?utf-8?B?UmFwYVF2Mjg0N0I5cXNXZFAyaG9jNHZtbXFPT1FBWXBDOW45eDNpeGI1eXhj?=
 =?utf-8?B?YURMemVWbHhIN1N2R0k5aEJLblVYYzdta2xETzd1eHlUMUNEKzFVVFdMeVp4?=
 =?utf-8?B?SlgyRU1yN2RhbDF4K292WlpLbzI1S2I4QXFDUzF3bE4zQk1qbDkvVlhDTEFV?=
 =?utf-8?B?eFhESFhRdDBRYm9aZzN6YnRGNDA0cS9PL05VN3RDUlhWMDhnMG5ETW9yWUhJ?=
 =?utf-8?B?RmhuMmRiYkVER0t0UW9MdDB4akd6ZUVjeTEvcGtPaEhtbk1yWHQ1YzBKdXFm?=
 =?utf-8?B?Y1FXd1FBWEMzMnd3ckFQOHo1b1ZtR0dzSjRLL2RoRlAyZUhYcE0wVHhiVWhz?=
 =?utf-8?B?ZldPZmtNM0JGVHFOeUpaZ2FZeE1NakRGeDdkWUtEUUZCY1FTdXBzK0xHaVNO?=
 =?utf-8?B?OUJRYWNZUXcyVS9iNW5JZ2xFZ1R1TnB1TUR1enBFUm5DNW5YUFhxK2Y1aHZi?=
 =?utf-8?B?bklNeEtrY1d3NzhlVUJlOU9LdGgzV3pjY25jQ0FJTDlzUHBNSXp3aGVlRmsr?=
 =?utf-8?B?Q2xQYVNpdllDUVdJRDIxazZsYWo0bEdvd0xkd2J6TzZnTXA5Q3gvZEc0L1p4?=
 =?utf-8?B?MG9ZUEhBcCtDditlVTdEVDFweUQxSjJ0ZlU0NDJYbjM5d0IwQzk1NHhzNUFn?=
 =?utf-8?B?VWJhRlI2YlBRaUZOcmtFOVk0N3JadTJaalQzVnA5R0p0Rlp4b2VvUW1Cb3VX?=
 =?utf-8?B?b0M3UnI1TVQ3SDJpU2FRK1BlbkFIYiszRVZ3UlJPUStJTCtTbTFha3p5M1Vv?=
 =?utf-8?B?ZjBybzZIK0NNeXkrcnNKd1R4QURycC9uN1NsVWxIQlM1cVc3eWdNWmlGcXZS?=
 =?utf-8?B?VWNGWkpXZk8xMkZjT3J6QkQ2L3JDcExVZ1JaSi9IRXMwSHBteXpTN1ZSWi9Z?=
 =?utf-8?B?WDFNeVNFRG8zRW1xdDlQK0JEb3hzZ25rN1VJTVRyVVBOTTFCZXU3ZmpmSTEw?=
 =?utf-8?B?bDZJZjR4K1owbHZTd1F0TlhpQlRvYm1qYlBVODZTbzJXdmx0WDFNelRrQlUw?=
 =?utf-8?B?UG9tYkpqSGpuVmQ5WHFMVnh0Y2VtRCtSeXZMUSt5STNZOERiWVlqSDNGbjA0?=
 =?utf-8?B?d2lzRUpMV0tHSVZpVW1XWEtWTFB6RVc3amcrTFNybXltRno4bUhqVlZWcUN5?=
 =?utf-8?B?b3ZIejdiUUM4c1g2bTlkYlViSzZCbXdHMmR6NW1RTmc2VTJ0dlQvaWdjTUFm?=
 =?utf-8?B?U1VVc3hPdEsyQnI1ZWt3TkNMSTNvSVE3SHd4bG91MzJldFl2bVlzWlg0bmNC?=
 =?utf-8?B?Zk9jKzREajlnU0s2Z2NLVVdGN2dGZWZFcDdtdXh5RmxLWFpwOGp6aWR1eStO?=
 =?utf-8?B?ajBjTm9IanRwd1ZaaHJ3dyt4L1QybG1mSTRBMmNXU0pTcWdubjN4eTZMMVRp?=
 =?utf-8?B?NjRyNndYMVVoRitKQy8yT0FjZnhoWUptSC9vblpjbDd4eWlMWUpNSUIxSVJm?=
 =?utf-8?B?V2VmWC9UUVBzMzA3elNpc01WTm1tK0VNUktjQ293ZWpKMXovUWFkejZOZzF2?=
 =?utf-8?B?aTI4ZEZMbmtCZ05paWtXK0g1ZllPZk5oYjlKQjVJakUrd1BCVy9XRmkrcUtu?=
 =?utf-8?B?YmIrY3FtSk5QSGxVdG1JaU0yd2x2YXY4cWRiajN1aHJkeFdiNzY1QldEUG1i?=
 =?utf-8?B?Z2RBY1VNbGZCNGRXdzBGZ1RhbURDRnI2K1pYaVRZdjZmN2dNK25GTWRCRXNY?=
 =?utf-8?Q?+0MeDy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:39.6912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be7f1ac-e4d5-4ef0-7cf8-08ddb329bcbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248

Many of the checks in reset_block() are done again in the block reset
function. So drop the redundant checks.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    v3->v4:
    * New in v4.

 arch/x86/kernel/cpu/mce/amd.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 3ddb28f90d70..3cb9f6a68316 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -830,29 +830,11 @@ static void amd_deferred_error_interrupt(void)
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
 void amd_reset_thr_limit(unsigned int bank)
 {
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	struct threshold_block *block, *tmp;
+	struct thresh_restart tr;
 
 	/*
 	 * Validate that the threshold bank has been initialized already. The
@@ -862,8 +844,12 @@ void amd_reset_thr_limit(unsigned int bank)
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
2.49.0


