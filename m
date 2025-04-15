Return-Path: <linux-edac+bounces-3564-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A532BA8AA24
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 23:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3851A3A98FC
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 21:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1105B197A8A;
	Tue, 15 Apr 2025 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CSvCFAZY"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2445710F2;
	Tue, 15 Apr 2025 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752734; cv=fail; b=Uf7I0ilfpOVrUogcWumXYAemaWRAQR3OtDTfSE34fd3Zq1IM9dUEju261+AiLW9d51dcqH2dVgoFo0EgH4PP3XT2HdFLDmuRbDSTuTfn5JN0SQ+K0k3tDdW2QLXyzJnnzfKIrs1Xb+ZO52krOTK7upL7bK0IWx20qxsOQ+Iv2Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752734; c=relaxed/simple;
	bh=YkThshmrJxUB1jKv4sVST0iAe3E5LMHFNHdiyx0QXUA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X6ScL+nr/hlBkZ/dPfBHqKvwhx55kNW3TQvOVQ4oqCfjjKgZ76qCVd5FAmyy1eyB8SIPKppa3mR5+eyOnftMLm2A0ZZMt+xM1g/iEfgQzdbjkIBnvGxAbOH340/FPHbYio5gX+sbaznl6CAo2h6l0qyIrJ6MggdRMoI86dveKSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CSvCFAZY; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGFGGWADPcGWbWyeN3hMBpRWYYq3p5DV0GgbVjtvzDhIhf76aHfXZrFu9f9LrpjSfb0da+YbJRbg9p81fvYpg6GNyFPv6Ks9WbCN59bCC5Czsnchgc6KGb0OKgoqhFeE3JS5dlLT06PZFETNgfhL4afylqIAYCD7AoPb9ik2uxmLKLxYGhiGsfAkmFBJtggZmAwEBf2UNuZV82UBN9uKm5gmrp93wWGJU2J3Zpz/EUZrNW43KFRpYLs7RKYgIDlYrrbSvmr2pZHw5SXetR+xjy6UvPmbuYubByjOIEiLTn5eEAcmn907ZmD7dUbBO6mTjliadWhBNv2eyswQZr7fmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWPuM2gyNQFQRqAQ7QcASjySm0StJdfrVXOW7F7SfF8=;
 b=aaAk7A22w94dvDWbyBqaYWIO2zUhWPRY4d7sfLBId/GU3AsAI03hVXANz+wpKBOCcaeXzHJb5oym3zEFGfWYex4mdnn3HdkarW1jXizQNL9e1CQssgjuVRc1o3EPu5Q5SEmxvbJzzdsBa1NEJJfJfk835Eiir4MAbm2z3hre0blmcQgeyPok6EQgoEuALpUDnAMSLO0inPucNm067ZvjFPIscdRYxHSqyabxuXL9GyRfbqKG4+7OslhURXqX8TtBY+pj5p0nyVdmUQaskFuHyirmL4Y2g8qit84QQB6rb/vhY4h5+HmDlxqVucwl0TddTil1VDSDkUNeP/NdUFH5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWPuM2gyNQFQRqAQ7QcASjySm0StJdfrVXOW7F7SfF8=;
 b=CSvCFAZY8eZ8D7ES6hWzciUzilHkeNXj3JibsPpMMsEpH/UmckpFy0gOi9zexLOgj2t1y/dHJi7uOmTWJXoORw8fRcBFMNhlAbnPLnflMxwjLXWKM0yzuYuvcHRn/yjeFZgdNUfQ8UW1+Da+3v0X9gi7XT8VyIuT9F1piuujc44=
Received: from SJ0PR03CA0081.namprd03.prod.outlook.com (2603:10b6:a03:331::26)
 by PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 21:32:07 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::ce) by SJ0PR03CA0081.outlook.office365.com
 (2603:10b6:a03:331::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Tue,
 15 Apr 2025 21:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 21:32:07 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Apr 2025 16:31:55 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>, =?UTF-8?q?=C5=BDilvinas=20=C5=BDaltiena?=
	<zilvinas@natrix.lt>
Subject: [PATCH v2] EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs
Date: Tue, 15 Apr 2025 21:25:58 +0000
Message-ID: <20250415213150.755255-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: c40ae18c-fd8b-45be-17f3-08dd7c64f8f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2RidmNDaGN6bFpJNzFJZnNJOEZ6dlMrczFRcU1JZWFiTXB3V3lJcytRSGRl?=
 =?utf-8?B?SE90eWxGMi9vUXZqbzZpNThCTllaZm1WaG11TnZOZ09rS3NldExyNm5VaWdr?=
 =?utf-8?B?ME5YVERyVkQ3aXB6QkUxVXBFV09DOGVoUGI5ZTc4bXZ3VmRpcXFYQmgrbUI0?=
 =?utf-8?B?amliZGxHcnl4U0FUZDRIamdWYkdNRHVqQXF0RjdrWXk3djRud2lBMDNqaVpN?=
 =?utf-8?B?aXZuRDRtclpLVGdXVkRnUE9Ec2EzcThPVFhvbzlTUG1rYk5YaXorbkNZeHNX?=
 =?utf-8?B?cDhFdldWU2FXRFJjdHRYYWJScHFzT0ZDYkU2MDNDcDAzVFVhdnovWmpqSnUy?=
 =?utf-8?B?S1ZxZG8raUdzUWlIOHc4aDRhTXI4WWRlUlU0UHVGTi9WS2U3R1ZVVGFRWFlC?=
 =?utf-8?B?YiszTGJaTUlTZlk2WE9zMmlyRTk2QnhlZ21UbEs4TFNoZVE2Z3I5bVJQWGRx?=
 =?utf-8?B?di9ZNkFUajNBY2NUdGI1Nlo4bG04TDE1cklOODJkUWtUVUxrU1Znbm1YZitY?=
 =?utf-8?B?Wmk1ZkFpNEtObk5kTzM3SFBENjFXU1FnU01CQkFKVFJjbjZKQ09kQlBDR3pk?=
 =?utf-8?B?TTk2SC9ZNElFcU9ia2diQXFjU0wvczRCRFlpZXRkY0dKWkpsb0ZxZXQwQ3lF?=
 =?utf-8?B?dll2ak41Mk1GL1JlSUh0dU1QTzEwVmszZzlmdUMvbk5JUkN0d1ovcGQySVds?=
 =?utf-8?B?MHZwQlkvaHV5UWQ5VCtxZEFOVzlqV0xxSUhuVDJ5cUp0QnhIV0FiSTF2MC9p?=
 =?utf-8?B?T1J0WDd5d0xRakhHWnFydGRFZ3dudjdmaS9ubXRFd3hnZldhbEN5eG1RbFdm?=
 =?utf-8?B?dWZ3SGczUW9ma3JnMWh3MThlK3RMODFtcFFML1cybS9iV0tjY1g2WkhSMjNN?=
 =?utf-8?B?akpSZlZyTSt0TDBaSjJZSmxJK2IzRXdUOGxGalNCWmJhbmd2S01uMmFIWWVO?=
 =?utf-8?B?dGp0ZmxRTTJxMDNpK0ZqOTZMbStDZmpMakd1ZGw5NmI0N01MazduODYyd3pG?=
 =?utf-8?B?RmxaNDdGTm9jZ2FXZjJ0QlA0b2RsWDhsaTdVdTJXNitTME9JTkZpTWcrOCti?=
 =?utf-8?B?bnVhZmxXSGwwU0FaenFUT2Q5OXBRc0NUVldLVVQ0M1l0OW5RUVFkaVNRUnFT?=
 =?utf-8?B?Ny96dFUzWitaTE9YdGMwOWowZTNEWXJoVkpYYzR0V2VONzBhdk95dzltNmdR?=
 =?utf-8?B?UkZHM0FtUDNJUVl6c3FlRk9sT0YvYmhwcDl5SlkrTG1WcCtoVUpjU2N4Q0dn?=
 =?utf-8?B?bTF3MDFrdHFvWW9MT1MyLzQzY2ZHOHRHSm81RkFrNjlJcDh5RkRDYlA2ekZH?=
 =?utf-8?B?NGNRd0tIZEFrNksyTVRGSnVWbjhiT1E0dWUwL2lYRDlVYXlHQUxvNEM5bTdN?=
 =?utf-8?B?VER6eVR5a3ZLa0tTbjM4bnFuZEYrdmZZWDNYSkxXZHFWZXU5dVZ5RzJ2bHdW?=
 =?utf-8?B?aXkrWGVVNUozV2FkUlZFcEdtUUp1eHhMTEt4SDZPeEJ0SUxHUTkvWFdKSnVZ?=
 =?utf-8?B?bkpMQmJpNkJ6eWVOeHFoYUVic0x2SWY2TnhFeU9PZDM2cU1QNjlZWkRLMzQv?=
 =?utf-8?B?VXEzU1pwZG84SExlMjZDbUxpc3N0dlRoUEpRRU9MdnlGMmNLUGJ1b0FsS2U0?=
 =?utf-8?B?anpENndhT0Q0TFI2RnRIZjZOR0ExY2NHR3JRL1ZZL1d4OGcycXhnYjVQRDRP?=
 =?utf-8?B?MGlTU2NSemZOcGQ5TnBGK3lNcWNMemhsbEliV1JkOFBJNU9SVnh6RnJ3aXZV?=
 =?utf-8?B?akViZ0w5SVFNWjJ4Sm9hUE5BUWdKOWM2NkFvNWxRN1VnRGNMU3cyNXF6ZURz?=
 =?utf-8?B?d2VJWGJMbWhaczg3dFhubVcycTlnRzhORjR5OW9TWDlnKzVwSjAzUnJ6cVo5?=
 =?utf-8?B?TElqTnRPK1FxQktpQmxDVm9jMkpBRVZtcHk0R28rMHY2bWVZUGMzV0hmTFNW?=
 =?utf-8?B?bGJMRDJCaU03THdsT0E1eVRjWUhGRnBKY3FKeThXR3h2V0FpRTNwV0YrSTdr?=
 =?utf-8?B?Tm9ySkdRL3JnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:32:07.0286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c40ae18c-fd8b-45be-17f3-08dd7c64f8f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429

Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD EPYC
SOCs has an Address Mask and a Secondary Address Mask register associated
with it. The amd64_edac module logs DIMM sizes on a per-UMC per-CS
granularity during init using these two registers.

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
Tested-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Cc: stable@vger.kernel.org
```
Changes in v2:
1. Avoid unnecessary variable initialization.
2. Modify commit message to accurately reflect the changes.
3. Move check for non-zero Address Mask register into the new helper.

Links:
v1: https://lore.kernel.org/linux-edac/9a33b6ff-9ce8-4abd-8629-3c9f6a546514@amd.com/T/#mc0b1101055f12ccb06e5a251d16f186597ed4133
---
 drivers/edac/amd64_edac.c | 57 ++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 58b1482a0fbb..91d22e63bdb1 100644
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

base-commit: b4d2bada09b17fcd68a0f00811ca7f900ec988e6
-- 
2.43.0


