Return-Path: <linux-edac+bounces-4044-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A868AC8361
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 22:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F42181C00E3B
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292EE2356C4;
	Thu, 29 May 2025 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dObyXBWW"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAE24C92;
	Thu, 29 May 2025 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748551840; cv=fail; b=llFS4DkMn88wK38YbAZpqFkGxv4pvgycGqSN7FTaAuUcJ0CnwDfaBxhD25QDoQ/7omtMu1dTc3LUa8ReZ3rea3YCx7i1grepiyJ0CD19jxB1dyVysu5/UWLwhvXbHX4kFbGbbXnZx5He0wtxqByH/Lr8ncJpChBWW1R+fA/+q7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748551840; c=relaxed/simple;
	bh=2UdeekdbsA5cLJ0kZAZDgFLekAZXVKwlFVJgLeVdA9g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tSIAEG5axg1pRmOlXtjsOiHQSjL9kLuGUVJYTmVJity6S6n/Cqx8ZwsxeWuF88f7rVyWl1t5RuaJW9pi+rI+gd0nUEMdqmXEl0KP/t5NYo0LXggVk2OAlq7jEiiV0IuZ7IxxFRpmRrdOoaUMdm0AFVsY622XDrjEqSMj0n4XfOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dObyXBWW; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFbbI6fQe42xSv1fHBA8hWOA9sM3Z6o6Vua48brQ4r1IFJiBHbEgQUk8aMuFOcerv6IJfqY18xHkO42A7i7Ue2GczCvSviDC+w2ucpcqKqULvJB7jq2V/VOgyLufYlSbtnpEPuVS1lb/83cTAEsfIJTHmtx7EiY6dPYwYiAS94lE9Ty83gwROfBZa9ZY2hW/Jz9tX2C9ruOPnJwASqV4oudv10FAuPr7e5WH2zY+bQ5mJghnXzWEPht9BlNQH3Kb7vuVmoiQv5Si/eEWRO9BeT559OdZlIzlVtoMNtlcf0AgeTjbVMYdco0EyvINOH90i6PVk4VUoZdE++A6+GZgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLANavZrr1io3B03nTDOTGxCYetPt9qnoxrbaIbBsno=;
 b=XnAaEXCUppp9WTgyxWTZaL8n9nBgX3ynlXQFww8nobsXY1CpTMoi+IIdohBT554s4BSwjIeHUDT+esA4/hIlLJvbeCMaW0ewZltKoEhSCtLHvtpO4yTyshelMBcF5pnlcDwnPM5Ti8kOxkenVZP8KgsFdLUepCvyNgHYifLg/CT94WS6XgVniETe0U3B9qTEG+LQ2msskpg++LsnsINwmN5457tATBvvY0RxkoLJnJ/qzwE32k7oq9tjF9SVCR/YzmaegZE1iNBYd02z6f6iKPTULufH/23EKQkFkl1F75gHERo8yCxUPyRpWccZMBIAEsEPvH4q3rQPP3FmwE7yHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLANavZrr1io3B03nTDOTGxCYetPt9qnoxrbaIbBsno=;
 b=dObyXBWWKJfHo/2GVFNHlDy1scrYDURkeuJ7YnJWpOygeYpkjyq9QQFvg6rpzxQKteyGhbkVYQsBIJG9Yv3bakQhEmcETkaSgywBDIV3yebAOBAlgtKC++IFY9F+c9rkAL+U9Ohg/WaPPWBqf4amdJF3pJEDIeYPCp295jqO31I=
Received: from DS7PR03CA0119.namprd03.prod.outlook.com (2603:10b6:5:3b7::34)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 20:50:35 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::7c) by DS7PR03CA0119.outlook.office365.com
 (2603:10b6:5:3b7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Thu,
 29 May 2025 20:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:50:35 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 May 2025 15:50:19 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	=?UTF-8?q?=C5=BDilvinas=20=C5=BDaltiena?= <zilvinas@natrix.lt>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v5] EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs
Date: Thu, 29 May 2025 20:50:04 +0000
Message-ID: <20250529205013.403450-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8c2b7d-502f-4ee8-27ba-08dd9ef275d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SldJMC81STlWTDc2UlA3V3VlNXN6d3haQmxzekp1SDZqNzNSNlVqRHFCemdi?=
 =?utf-8?B?aEY0c0xBSTlEOXorK0ZJSmkyY3JKQjdNRndKUW13alNRRjNkQ2kvRGYyNDQ0?=
 =?utf-8?B?SEd1VmxFS0JCWlRycm05eTV2eC9ENW9tTlhNR3BiTnl1SkQwVWhzblpVZDA4?=
 =?utf-8?B?QStMUjVUN1VFdTQ5OVh5cndCczdXV29tVG9aSjl3MTZSb25ObEFmSWZ4TFpw?=
 =?utf-8?B?ZG5KbDdDekhSQU9HcDArMmcxaU1MQVZOSS9WR0s2VXpRcmZXeFhBQkoxZ3Rp?=
 =?utf-8?B?TzVHUUI0b0hacTlRQy95RjgxY1pMd1pld1dkOGJDVERBSjNnem5zZ0VaOVpm?=
 =?utf-8?B?bThCUkRaRjRIejQ2V2V0Z3RmcWxWbHlkaGd6TGJSS0ppUWRuQWpMU0svRGlQ?=
 =?utf-8?B?amV6VUdBTmUwcmp5b0xCZndTWGRyTHM2R2xsZ0I1LzdKVWxha0FwSFJxTkc1?=
 =?utf-8?B?WWlyN2tnaU1WeWkxTVdINkRmUVNZSENxenZNRTZzVitrSWhRYkFqL0hzaXpU?=
 =?utf-8?B?SWZKMmlGbTk0V3dSTytZMm82Yi9qeU1Wd1JwNVVvS2kzTG5zNC9xWTM1UmVr?=
 =?utf-8?B?R1BYYWd1S2RjZFVMNzA3T21FNytFN2ZOcEFOR092MkpFZEVia1V6S3NlUjRu?=
 =?utf-8?B?Tm5zNGcyK1VSdjEwa3FuaEZvb2FmSnNHNmFNSWlsdHZCdG1qcmcrUmFqRk1z?=
 =?utf-8?B?c1ZyYmViMkJaYlhKM3A0QXZ0WHhjWVV4MzBFVmkwR0FUMFZpeFZHb2RPMkwx?=
 =?utf-8?B?aStRbU1PckxTdUZaVXcrNkd6NlRRQlZSb0dFMmlISnIrZDJVd1lqcFExVjJI?=
 =?utf-8?B?NG1lVXpoelZDc3NaRUZUczVlLzNoTFlHTnpvNVJoR3JLSWwwMGFabU1aMzlq?=
 =?utf-8?B?SXVRVExIc2NYc3dLL0oyMzZSSlhRbEhhVU5wdk5QVEtIc0pHSElTMXpuZ1ZX?=
 =?utf-8?B?RVpmU0dQQmtFRE02NCt1ZjR2Q1QxcGw5ZU1VUGIrdHVkWDdJUGVSZEx5dFNk?=
 =?utf-8?B?b1ZCdkNicWRsNGozUXc1SDQ0WTVhSVlESE5wSWE2TFBib0NrUGxDbzFERno3?=
 =?utf-8?B?cDE1UGl5TlBRM1haMDkrdkc0ZEVhekk4WjBaUmdMa3BiamhLMDVyMzJXajZK?=
 =?utf-8?B?VnB5SlBHNFJiMXRIMFBSeTkxMHRybVl0dERJR2hQSDJwSmR4QWJZK1hoclA0?=
 =?utf-8?B?bDFObm9GL2RjMTd1eldzQTFYV0FHZFlqbis0d2IzNkpPSHpYRUVkeGpVVzU4?=
 =?utf-8?B?a0NNRWs1b1ZacGU0UENpMk9kUTVxaldpV2xKNVZNSThIVHZCSFEwNXZ4UHZs?=
 =?utf-8?B?ZkpLMytYQ1dWNmh1YlVIS2ZCK1d3K3pxRmdSQnp3Vkp0WEZ2elUwNUdQamZ3?=
 =?utf-8?B?Z3libEU5N2txMTJpVjBvQ3J2MFp2Q3RBNU5hWiszZHREUDRHa2hXeFEyNHM2?=
 =?utf-8?B?Y2JBcHhqbkV5cDJzOGxOYkpQVmM4YmtCOS9vRHZxdzVtU3FiUFVraGtHVkht?=
 =?utf-8?B?SzF4WHg5WFU3Zzd2YllJR1oyd2JHSks4RDZ6UnEzZ0w1MCsxT3lzV3Nic2xo?=
 =?utf-8?B?THA0SjV6SlI1bFQ1NFlpYnJQRkZYYjJ1MlhVMnRzOVhveVZ4d2ZPT1crTkpy?=
 =?utf-8?B?ZXRJWEJmN0hlbWc3cVBpK0t1T2ZZNFU3SXA1bmFmNnUyc0l6aEZJL0RLcVRX?=
 =?utf-8?B?SlA0RElNL0grNVJ2c2xTVmt5UFlPbXpSdjU5Z3ZCcHptZS9KUUdLdnZwQWVu?=
 =?utf-8?B?NDNzRXVHTEZqbE9Ib3lSeTNRY3RodUZFTFJUSU5aa2dHNHlGL2F1WHFBd0VI?=
 =?utf-8?B?M2F1NjhpcGtvTHMyM09iaEhDM2hzU3d5dmg5R2orU2kyNGVYZ0VHMHE3QXZX?=
 =?utf-8?B?b2t3MXVKdUxGd3B5b01mTUE2VGFxV0dOYXkyZmN0Z2E4YnkyYThjZzN5SFo1?=
 =?utf-8?B?aGJmVXZMak82UjJzS1Y0T000SzVheGpMdlVubVJTN0NYSFZEbU5wcEdVQUZV?=
 =?utf-8?B?T3IzeEJtVmhTNlM3U0gxTzVsSEV0MTRFeGFYZ09iSWVtNnFmWUhlemZuQ3dw?=
 =?utf-8?B?OFR3S3g0dzVxalp5bDdBV1djaFpQRkcvKzlEQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:50:35.1531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8c2b7d-502f-4ee8-27ba-08dd9ef275d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165

Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD's
modern Zen-based SOCs has an Address Mask and a Secondary Address Mask
register associated with it. The amd64_edac module logs DIMM sizes on a
per-UMC per-CS granularity during init using these two registers.

Currently, the module primarily considers only the Address Mask register
for computing DIMM sizes. The Secondary Address Mask register is only
considered for odd CS. Additionally, if it has been considered, the
Address Mask register is ignored altogether for that CS. For
power-of-two DIMMs i.e. DIMMs whose total capacity is a power of two
(32GB, 64GB, etc.), this is not an issue since only the Address Mask
register is used.

For non-power-of-two DIMMs i.e, DIMMs whose total capacity is not a power
of two (48GB, 96GB, etc.), however, the Secondary Address Mask register
is used in conjunction with the Address Mask register. However, since the
module only considers either of the two registers for a CS, the size
computed by the module is incorrect. The Secondary Address Mask register
is not considered for even CS, and the Address Mask register is not
considered for odd CS.

Introduce a new helper function so that both Address Mask and Secondary
Address Mask registers are considered, when valid, for computing DIMM
sizes. Furthermore, also rename some variables for greater clarity.

Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
Reported-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
Closes: https://lore.kernel.org/dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Tested-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
Changes in v2:
1. Avoid unnecessary variable initialization.
2. Modify commit message to accurately reflect the changes.
3. Move check for non-zero Address Mask register into the new helper.

Changes in v3:
1. Add the missing Closes tag and rearrange tags per tip tree handbook.
3. Slightly modify commit message to properly reflect the SOCs that may
encounter this issue.
4. Rebase on top of edac-for-next.

Changes in v4:
1. Rebase on top of edac-for-next.

Changes in v5:
1. Change ordering of variable declarations to reverse fir tree.
2. Explicitly state what power-of-two and non-power-of-two DIMMs are in
the commit message and ensure that the changelog is ignored by patch
handling tools.
3. Rebase on top of edac-for-next.

Links:
v1: https://lore.kernel.org/all/20250327210718.1640762-1-avadhut.naik@amd.com/
v2: https://lore.kernel.org/all/20250415213150.755255-1-avadhut.naik@amd.com/
v3: https://lore.kernel.org/all/20250416222552.1686475-1-avadhut.naik@amd.com/
v4: https://lore.kernel.org/all/20250513192221.784445-1-avadhut.naik@amd.com/
---
 drivers/edac/amd64_edac.c | 57 ++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 90f0eb7cc5b9..35e59abef598 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1209,7 +1209,9 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 	if (csrow_enabled(2 * dimm + 1, ctrl, pvt))
 		cs_mode |= CS_ODD_PRIMARY;
 
-	/* Asymmetric dual-rank DIMM support. */
+	if (csrow_sec_enabled(2 * dimm, ctrl, pvt))
+		cs_mode |= CS_EVEN_SECONDARY;
+
 	if (csrow_sec_enabled(2 * dimm + 1, ctrl, pvt))
 		cs_mode |= CS_ODD_SECONDARY;
 
@@ -1230,12 +1232,13 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 	return cs_mode;
 }
 
-static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
-				  int csrow_nr, int dimm)
+static int calculate_cs_size(u32 mask, unsigned int cs_mode)
 {
-	u32 msb, weight, num_zero_bits;
-	u32 addr_mask_deinterleaved;
-	int size = 0;
+	int msb, weight, num_zero_bits;
+	u32 deinterleaved_mask;
+
+	if (!mask)
+		return 0;
 
 	/*
 	 * The number of zero bits in the mask is equal to the number of bits
@@ -1248,19 +1251,30 @@ static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
 	 * without swapping with the most significant bit. This can be handled
 	 * by keeping the MSB where it is and ignoring the single zero bit.
 	 */
-	msb = fls(addr_mask_orig) - 1;
-	weight = hweight_long(addr_mask_orig);
+	msb = fls(mask) - 1;
+	weight = hweight_long(mask);
 	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
 
 	/* Take the number of zero bits off from the top of the mask. */
-	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
+	deinterleaved_mask = GENMASK(msb - num_zero_bits, 1);
+	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", deinterleaved_mask);
+
+	return (deinterleaved_mask >> 2) + 1;
+}
+
+static int __addr_mask_to_cs_size(u32 addr_mask, u32 addr_mask_sec,
+				  unsigned int cs_mode, int csrow_nr, int dimm)
+{
+	int size;
 
 	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
-	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
-	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
+	edac_dbg(1, "  Primary AddrMask: 0x%x\n", addr_mask);
 
 	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
-	size = (addr_mask_deinterleaved >> 2) + 1;
+	size = calculate_cs_size(addr_mask, cs_mode);
+
+	edac_dbg(1, "  Secondary AddrMask: 0x%x\n", addr_mask_sec);
+	size += calculate_cs_size(addr_mask_sec, cs_mode);
 
 	/* Return size in MBs. */
 	return size >> 10;
@@ -1269,8 +1283,8 @@ static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
 static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
+	u32 addr_mask = 0, addr_mask_sec = 0;
 	int cs_mask_nr = csrow_nr;
-	u32 addr_mask_orig;
 	int dimm, size = 0;
 
 	/* No Chip Selects are enabled. */
@@ -1308,13 +1322,13 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	if (!pvt->flags.zn_regs_v2)
 		cs_mask_nr >>= 1;
 
-	/* Asymmetric dual-rank DIMM support. */
-	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
-		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
-	else
-		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
+	if (cs_mode & (CS_EVEN_PRIMARY | CS_ODD_PRIMARY))
+		addr_mask = pvt->csels[umc].csmasks[cs_mask_nr];
+
+	if (cs_mode & (CS_EVEN_SECONDARY | CS_ODD_SECONDARY))
+		addr_mask_sec = pvt->csels[umc].csmasks_sec[cs_mask_nr];
 
-	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, dimm);
+	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, dimm);
 }
 
 static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
@@ -3512,9 +3526,10 @@ static void gpu_get_err_info(struct mce *m, struct err_info *err)
 static int gpu_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
-	u32 addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
+	u32 addr_mask		= pvt->csels[umc].csmasks[csrow_nr];
+	u32 addr_mask_sec	= pvt->csels[umc].csmasks_sec[csrow_nr];
 
-	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, csrow_nr >> 1);
+	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, csrow_nr >> 1);
 }
 
 static void gpu_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)

base-commit: 855b5de2e562c07d6cda4deb08d09dc2e0e2b18d
-- 
2.43.0


