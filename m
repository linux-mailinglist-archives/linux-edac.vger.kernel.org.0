Return-Path: <linux-edac+bounces-3892-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E541EAB5D11
	for <lists+linux-edac@lfdr.de>; Tue, 13 May 2025 21:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C3017E2C0
	for <lists+linux-edac@lfdr.de>; Tue, 13 May 2025 19:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E02728E5E3;
	Tue, 13 May 2025 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g9G6wvoK"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9241EB5CB;
	Tue, 13 May 2025 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164158; cv=fail; b=HJxmPwUK/dlRClbzCPu6pGuMb8Nq+FMTa6x1i2pAx+M1nSQ0COSC2j+FPoLDLCZgblDdmFEwFxRV7Gq9YRWyjIUnXoQmONvpMYzBW6azuZv75xVKCv80JKOjJoF9b1il2oE8PtLvqAZIwzR+aitccBeedIkYyI92zE8UUAhvfuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164158; c=relaxed/simple;
	bh=xY+8bvuKVTs+HinsX9IEzXUr00FGEaqUCiyf2xN0lT4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P2/KysrlzJxtBTSLX7BHFzfUujafJDhnVaQZl4LgRHjxlyUDCkGsB1JmRGg9eSuGXiMvZPjVpQM1uAvikNLV7bAw3Wyj4uj957ETpbYE3kkZoKSoLNmC5TvPMPMtXbC/Tyfs1egun22AclOZhDTKoIVZmpcDSdBDaAyg068eR2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g9G6wvoK; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYapb8wTtr7eYHRDPvmkQDG+7LKJNG043dC1LeqLG8D9YXonSC9lSZWAK0S7d/H7hY9CAcAnvEvCTzSF990PNMKYgV8EHclHpnYdz27wm+RIKdHcU25MNKxI0L0dcxX3cvbO89c6cPkVUCYEoWUkcBPf6xexPq1mhTcqs/62gXR8WiMRk2Ay8j+jdIgw5k6Y8pORKZhmu8Gnx5OW+K2E55Yh55MaXLj9orQBJATmLWU384ok+mj05T2lL7Jge9UCrMHGhW7A+7gtPbUR5Z3dzPNatkOvXA8v4mLEN35WRjWY3SqByJMw0VhiwC7Hl/6XybaVRzpHT9kg0XtcLgeYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaVfyeSvI7SiegNbD7gLpKq3H6CLosOxKLq02+ruYio=;
 b=N5FVCX0r+5Wi8qGqh6wJHZIzD9L3QhBRo+T0kWWZOX7Twemq652sr1kE78lYQtHRKi69uvIChNm8S0NutqZoqNJ5s3qLOoy0NKd9OZqv/fpvseFab99nplLPhxIM8BswBCWKXbAImhz9wcwe5lsmScZjtk47DPRI4DprorGqe3vbaZnAZwtj25f1u+T/tpcsilWwozAI0DUkmYz3o176GYXsz8ZlSFrcKyRj2NCl61NlKnW4nNgpJOrVX+kQDd8sLDKNiyhaqTOsLS96D/7Xrd+szgaSYiwiVleIspFqsf8PtHqKHVo4YApNYQSiPSOJDaAWYElKGi6Sh76usNNZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaVfyeSvI7SiegNbD7gLpKq3H6CLosOxKLq02+ruYio=;
 b=g9G6wvoKb5Vmv4SyeEtL8rjRZal7xhXVOcNbq6lPoLDJr3P3OZeS1sj76gUiKq6OuyzCfNOww6fEJJcfKLdaFWtkcieNRTU2XpngYGHyjvvPGFi1hjusUJQt2VOtBteKMFy/XV7Db9kve5BLRWwh9fBWMFBqga1rgAEB42XeF+s=
Received: from BN9PR03CA0878.namprd03.prod.outlook.com (2603:10b6:408:13c::13)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 19:22:33 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::31) by BN9PR03CA0878.outlook.office365.com
 (2603:10b6:408:13c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Tue,
 13 May 2025 19:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 19:22:32 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 May 2025 14:22:32 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>,
	=?UTF-8?q?=C5=BDilvinas=20=C5=BDaltiena?= <zilvinas@natrix.lt>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v4] EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs
Date: Tue, 13 May 2025 19:20:11 +0000
Message-ID: <20250513192221.784445-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: e2798e00-563d-426e-06a1-08dd925382b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGNWVWRKVmd6UlpJMkk1NFVjMU44cmFTV1dxb2t5OEY5emdlNWQ5MTFCL1c0?=
 =?utf-8?B?RXpUTTk0b0l4RUdOMUJBWDl2Y3Z2S3crWE55RnBGMDVXc25jS2hrNHhWOFBZ?=
 =?utf-8?B?QnlpTndQazJlSnoySDFvYUVhYVdEN3M1K2ZTWXYyVTR3dU9NZ1VHRWRLWFJV?=
 =?utf-8?B?amVxZGNad2x0MXk0RFl5S0ZuTXhUeE5iU0o3L1ZneVlUbXFNcklWUXRTc1NO?=
 =?utf-8?B?MFFsci9yM284TVRQKzE1bjZzQklHNWRWTVU3REs2VVNMVTJMRFpVTjhTTzl0?=
 =?utf-8?B?blNpaDgwM3lJSmhHNFhjQmQzL1dpQ09tZFpReElDY1BwaHMyOWttUjNzNWpH?=
 =?utf-8?B?dHM0QitRU1NDZXMwbkF0VFE2VURLalF4ckc0bXdhVkdkUFROUVdld3ZwR3Fm?=
 =?utf-8?B?SWNNRktPWlJBdkYxd1JLbmF1VkgyYUVMZjczSVZOY0VYVEFQWlBCalp3WXcy?=
 =?utf-8?B?YVZ5bkVnUjdnNmNCMUljbi81NVZ1cFFZYnd3V0d5aDJmeS91K3AyemljSnZJ?=
 =?utf-8?B?N3NvYVJUU1BBVmpObmRNUjhFcVJhdkRwQzZCSVBLRG9KR3lMQWorWlRiNHZJ?=
 =?utf-8?B?d0t1QTZNT3cyQUhNMzZ0VmR0MElrVWplbHgwRGpHYmJpeVJFcEV0TnQvVkpM?=
 =?utf-8?B?c21veVBwN0JUZ0h5UzRiQTRiamV0ekd6RkJGd0tjUWFDaWxCZnEzSXlkNE9L?=
 =?utf-8?B?MXptMTNyUzlLd1VMeHc5RmRUWjNRNFlxL1BKSS8xbDdaUVlJOTByYmo4YnRE?=
 =?utf-8?B?aU5QNU1IbnZ0UlBWVEFYM2hONHJpUXhKd0VxelFadFl2cnR3eFAxbkJ5ZjdX?=
 =?utf-8?B?dDdOM0V0MXFBM3hFZGM1UDNuTysybU0rSXFQb2EyaE85dWxCNmw3d1AzYnY4?=
 =?utf-8?B?ZE5KVGd5YUNuV2wraGk0YjZKeTV4cFIrcHhMZmllbGZhNHZ2Qm1ZeHlnMW1N?=
 =?utf-8?B?U1owNEZqMGhqT0c1dXlxVWFJRGUrelJNU2JSMG1MdnFyWkRncGxrMkF5WTEz?=
 =?utf-8?B?TmRhTWVRdjA0bFVVdlBMYytrYVlzZGNDT0pVOVFGdlNNMlJ0QmV1U0Y3YTdw?=
 =?utf-8?B?bldxNzdqMVIvL2hxV0pHWTZYSklXaWwwaDVKY0dUR2Z4U0VqZjBTUzdCL3N6?=
 =?utf-8?B?WlhGbGUxWVI0UXJHdHN2MVNwZE42WmZHVk9FWTZPa1l6eldGVysydzc3TGox?=
 =?utf-8?B?VkNKQU9SR2J0SmhRR2l3alBuMjZSOWtWazR2QXZEbW5wdURKT25HWlJVaTY0?=
 =?utf-8?B?cENra3UyZjhwSjRTcEJpUHp6QWd5WEFhNzA4TStxVUZuUlhzTUhGUkt3cEdF?=
 =?utf-8?B?TFM4ZjRNQnZrSElyL29FeEYvOEFZZWVlSHA2SmVzRWRXc0tJMjVXdWxVakR1?=
 =?utf-8?B?Tm91QnJTbldYKzgyOFBodmVhTXdnaVNMemJ0cmtPZExxNHBnNFZxd3hKUDBq?=
 =?utf-8?B?TVB6VUIyOEtyaEVTN0M3UWpGNFRnMXEzN1JybHhFV0h5Qi9haXVqcFI0c3dH?=
 =?utf-8?B?TWxqSEhXVnJ3SEpiWTZjRVNRRURvUG53Mjd4RFh0a3BycXJ3SkNWeTlBTHJN?=
 =?utf-8?B?Z2ttWW1HVWY4YjVaWjhVVUJGeGo0blVjdE9CTmNhSkx1a0lwMGFUSDgxdWt3?=
 =?utf-8?B?QW9IUzJnUHNzL1pFUERxeUlQYXh6aXdvVTRKWGU0b0ZhelhWa1hyL3Ruajdh?=
 =?utf-8?B?cUtJM2hxQ21XK0ZvN01YeHdFRHdoaVRGeDdQVm90ekh2M3FpM0U5S1A3cFF1?=
 =?utf-8?B?enRYR3FtYWZ4OUMxcXdDUW0zR0xyeVVuSk13aVB0ZVh2VkZ3RWppVFlkVXRJ?=
 =?utf-8?B?VTdzZzdlRExqck4zV1E3eGlsOFhCbVgyazJWMWwyVlR2VXpVRHdxT09UOVNW?=
 =?utf-8?B?ZS9oRThZTnR4MlJhZFFjLzc1Vk9NMi81cFN2UkwvQ0MwSjQrNlc4UnpZQStU?=
 =?utf-8?B?bTJhN2Q1ekl5RDhBUExOWTBKeVZocWY3clE0TktSTW5qNjZURG9jTm4wSHZM?=
 =?utf-8?B?UWVIcW55dG56aUNQQmdTLzg4WVo1VUJ0Z2FhVnNzbVpPcHJTeS9vK1NsR1Rr?=
 =?utf-8?B?aTdJdFhnRWRpclFMb2x1R2dXMFhjcFRna0RSUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 19:22:32.9081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2798e00-563d-426e-06a1-08dd925382b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840

Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD's
modern Zen-based SOCs has an Address Mask and a Secondary Address Mask
register associated with it. The amd64_edac module logs DIMM sizes on a
per-UMC per-CS granularity during init using these two registers.

Currently, the module primarily considers only the Address Mask register
for computing DIMM sizes. The Secondary Address Mask register is only
considered for odd CS. Additionally, if it has been considered, the
Address Mask register is ignored altogether for that CS. For
power-of-two DIMMs, this is not an issue since only the Address Mask
register is used.

For non-power-of-two DIMMs, however, the Secondary Address Mask register
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
```
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

Links:
v1: https://lore.kernel.org/all/20250327210718.1640762-1-avadhut.naik@amd.com/
v2: https://lore.kernel.org/all/20250415213150.755255-1-avadhut.naik@amd.com/
v3: https://lore.kernel.org/all/20250416222552.1686475-1-avadhut.naik@amd.com/
---
 drivers/edac/amd64_edac.c | 57 ++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 90f0eb7cc5b9..9e8b8bd2be32 100644
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
@@ -1270,7 +1284,7 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
 	int cs_mask_nr = csrow_nr;
-	u32 addr_mask_orig;
+	u32 addr_mask = 0, addr_mask_sec = 0;
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

base-commit: 4521b86e4a6ef9efff329ef18120b1520059ae4e
-- 
2.43.0


