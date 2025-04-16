Return-Path: <linux-edac+bounces-3568-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC615A90E97
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 00:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152CC19066D5
	for <lists+linux-edac@lfdr.de>; Wed, 16 Apr 2025 22:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5242823817F;
	Wed, 16 Apr 2025 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4g2+4HfR"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882C229B17;
	Wed, 16 Apr 2025 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744842366; cv=fail; b=fl/WHrFQSdDP0T/6ABl57iijGMFwujsEOpNxShOfY86yzAt7eTFXFIl+L/JZfyK9o4aRM2m6ooY63ubkFZ4/pNPplZnnAxlLckdwpys9PFiNwncQJn0BZJ+Lxg/drdCW6OiAx/SXvq5gyK4umyuP1mQhSZXFJHrtzqLjwr9VE1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744842366; c=relaxed/simple;
	bh=ptq2D9+7EmTouyXN49Y6l+NGD7rvGVbOG+S4zvTf28U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lr4KM7J0fGgi7tTeesitcUfBZ3ShOabPoCdz7jYtRM03wXSW/bQoJU8GUeJrTgtVg1sYsMZsoTW/Pd57DxR2HdFhejFiUnyI8UdZ/gkWqYpETLGA87IPm01csAO4rYaFvtaX6IxYH7wJuULTGGW7zZDPypj2QFiJgWeiR6utMKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4g2+4HfR; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gj4B+/gM9Pbr0UFOPLA6FypL8nHIvlzNdEakpDHTwa5gjNjExURuD3D38wHfhuldRAYlzQ1cLoybHjPOYFRNYws6ISzVoF+dygqaenHMZMHHQ4XR7dW5XKuu2Qy20nh5PSINO5DQcSCWUHJGInGbKm3YqpOT1Mw3Sz3/kp3H5o/5hRD7cVylzgRdNjT0AKD3b5y2T+rbIJM0+CnXyobyVkFRPpLYN9tgo3lW1n0DM1u5eZRJS+nh43mPdTAI3SDrssxqcxr+BEnANh4vi1zVfDYfkpH/tSPpR6hf2gRcX/3n40cgJkDheN2ON3dIkz1Xx57He5ljC4HlIN8op0f5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWb4zHepiqKq1/H46F5XbjHmrDGp5OnyMVu/9NNODrc=;
 b=cpSQf1mPNGQnzfbTlONAGk8TgrG9NiTl7YDNIyG8QH1gKiLtKp+HXJ8vCwkYVyj4iWBps2FJmXjNK5iBCj589MADk5dwV2IB+uOtxx1v+XG1cy+O671erUVuul5DaJ0TVXS+ZfdCQakMI3/HcoezLib8raq3qPXmGwREDkgwgsWkzyoHhXpUOs62sDyTK1QD8ii885gX2XexTLovX28iwj6gDe0yFnuOmRKs6+CW6B2RalRfh6vEv9N8TkSq/QVAJckNYZiSUpRu2Vg03XNJvFbFz1JmHFdhDRTXooZbt2z+rmh2CMGBeceVSHvi1oIbPKhsF4ZeIeN41Q1Attqqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWb4zHepiqKq1/H46F5XbjHmrDGp5OnyMVu/9NNODrc=;
 b=4g2+4HfR+v25ksO4kqmAbbITTgxX5r4p4aeGNJrdQX1A2hcxQm3uHv5f2eDIGHSeH+wJ+rr4nRgOyvfPGccNiSxpBoThEv9qS4l75ddroT7jxI8MmrmFIJ7F2mrZ1xcjSj5R64jTwGIHtUFKxcvIVgQGZr3medDXWwR9xLprJbs=
Received: from BN9P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::27)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 22:25:59 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::f4) by BN9P222CA0022.outlook.office365.com
 (2603:10b6:408:10c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Wed,
 16 Apr 2025 22:25:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 22:25:59 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Apr 2025 17:25:58 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	=?UTF-8?q?=C5=BDilvinas=20=C5=BDaltiena?= <zilvinas@natrix.lt>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v3] EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs
Date: Wed, 16 Apr 2025 22:23:40 +0000
Message-ID: <20250416222552.1686475-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f831263-6600-4262-4885-08dd7d35a9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUc4a1huR0diRnlGaWRtMTRlK1luZ0tEcm4zaEg0eGwrenByc1FRd1hlMGZs?=
 =?utf-8?B?SlpkUVJUc0lLdzFNeW1ubm5sOGl4MnVBcnN4dXZmUHd6RHVVYllGc1BpT0t4?=
 =?utf-8?B?aVkvV0RiNVpuVmVLcjQwVG4zSkJFK2pnbkZkbENNOTJBYUJWNnVpN2EyN1FU?=
 =?utf-8?B?R2RHcEE3Ky9jNVdqdmMvaEd3dXhOSVVEbVpRMG9mcjJTVHlKOEh5RDRhcjND?=
 =?utf-8?B?c016QmRpZ25VcHdRSXFPa3Frb0lUTnNGQ0dOTmd0Tlc3VTFLc0JqNDBoRTBa?=
 =?utf-8?B?WnI2eVVybzNYNXAva3RCbi9aVlkxcENqTzJmOFBBTTZyN2l4VFdsNEVOUEdm?=
 =?utf-8?B?bEwvZlFvVWVYUlV0V2JvVjQ2OFNoalhFSmhYcmFiN3R6SVl0b3BtVnVXQ0s1?=
 =?utf-8?B?UTdyWFoxSWNXMGVlTVVWTXRRVWhGS2U1K3RVZk1tc09SWWt2VFA1QmppdHJR?=
 =?utf-8?B?cXBpelFGL0NGRjYvMWJMOVVDeGVZdnNzRnpMRTc4b0hkR1ZVNmk5MExPeGZB?=
 =?utf-8?B?RWZMbGVNZFV0VTY5d296bWJOQllvQ2ZCQWdOZkdscnBMM1VpWWFTZHpUaHVs?=
 =?utf-8?B?ZVV2RmpKS1JTMFg5MTh1NnZQZGhwVVA1QXJNN3J0ckp6ZlZCRmdFa244UWsv?=
 =?utf-8?B?NEVFMWZoS2NhTE40enhEdWFIWG0zN2tOeG5zZ3NLSXNGTGptcERkWmthVTBp?=
 =?utf-8?B?R2Y5cG9obVg0RXlQVldlenZaYUJqblNHK1RYVEhMZE41bVRFYlNrUFNuUmxY?=
 =?utf-8?B?aDVlczkyTExEYXhmdkZ0VW5NT1pRUHRNR0tubUVveDJUbkJvZ0RqZCtQQW8v?=
 =?utf-8?B?THlXU3QyYno4NVoxTmVVWkJGN21ZcGVUL1BWWDA4WVBMUi8wZHRZd2xkMktx?=
 =?utf-8?B?ZFdOUHJWd2hhWlFVNzhoWjhLR1pBZ1ZSaFBOM2tqcTlpMWpwN2ZWL2dWd0pU?=
 =?utf-8?B?SGRLY2xDMlorRDgxUzNNQjVmRUhaNy8zZ2FCT1dENXdjRFBYQUJucDVCOFBr?=
 =?utf-8?B?T2lRM0J2R0ZNUGlNQVRQdzcvZkxacjNTTno5SDNocjF4a3BGNVc5OW5kdkg3?=
 =?utf-8?B?YktmbEluMEc4SEVpOENpYytabnMrdStLMmxoZFpnVDRCUFNucDBoay9qaXBh?=
 =?utf-8?B?MVdvL3JSbk8zckZINjdlYlFzT0Y4d2JGQlAxT0JBaWNkeHpkSytkbWpvbXIw?=
 =?utf-8?B?R2RSQzRSamJWbytaTVErUlE1RWRCNXZFSTlyMDNkMjUreTJDMnVzMTFPcEV0?=
 =?utf-8?B?TENPN21maU9mcWQxd0tvOGhoeFI2VmpFOXJTUEhacklJQXE0dTRHMFRySkp2?=
 =?utf-8?B?aGlnM3RjQk82YTV4Q25jSkJUbkhjdmJRMWkvTnNFTVIyZk85a3VyUng2cXBO?=
 =?utf-8?B?ZE5yVGRaM1ozdkpYWHNJVnREemJzZlpROUgrL09Ua3ZIWkJvZGtpOW5WYll3?=
 =?utf-8?B?ck5rUHBGOHNnSUxoWFdJRnF0V0FDbkJBaU5MUzFqemhXclJDNDNDdldHL1VN?=
 =?utf-8?B?VFQ5czdSamxOMVFqQTJleWZxTGxGcHQzYThNa1EvbCtGNEc1bUxQT0t0bXlQ?=
 =?utf-8?B?MU10NWgwbWdBcHZEaEE2Slc5VVliT0R1ZHRzQzJhaUVXL0VUVVg4YlZMN2Qy?=
 =?utf-8?B?ODIvSlVIQ3BmemExN1Y0NSthMFBpMmVJdGNXUE5uQzhkU2hWQkdWVjdNTlQz?=
 =?utf-8?B?L08rbmw5RE9XZENFdDdHV1FSbU0rR3o4MjhHbHBRQTlKakp3K2hxTFNWWmFX?=
 =?utf-8?B?dk5pT2RidExlTlFnSVcrUVgyZVN6U2JaMGxEMTNLMmFxOHdSRDVia3BHNmRt?=
 =?utf-8?B?TkIzRGdoNUxDTUI2QUlZV2tDZEM0SHM2a2M0UDlhWmtGdm5kdU9TeGVmV1Jm?=
 =?utf-8?B?S0NGVGhRMEd6dVRMcm5JYlJ0QW9LY2ZCK0FDbnJ4a1JneGpKOC85Sk9WNW9n?=
 =?utf-8?B?emZ2amFIY3YwS1NSa2loRWErOGViT0hOTk83V3hiMUs3aElwQXpLNEw0dEN2?=
 =?utf-8?B?YWRmOFpVVk5kYjRBWkU1eE9saWZ1WCtDbFFTRHoyaTFzVmRGajcrWXZkNlQr?=
 =?utf-8?B?ZzBoa2xFWDhzZDBaRGdlYUUraFNaaExrSlJydz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 22:25:59.0240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f831263-6600-4262-4885-08dd7d35a9b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082

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
4. Rebase on top  of edac-for-next.

Links:
v1: https://lore.kernel.org/all/20250327210718.1640762-1-avadhut.naik@amd.com/
v2: https://lore.kernel.org/all/20250415213150.755255-1-avadhut.naik@amd.com/
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

base-commit: 58029c39cdc54ac4f4dc40b4a9c05eed9f9b808a
-- 
2.43.0


