Return-Path: <linux-edac+bounces-3411-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D22DA7400B
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 22:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77753B7F81
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 21:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0575826289;
	Thu, 27 Mar 2025 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MP1Js1NS"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F396E2BB15;
	Thu, 27 Mar 2025 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109651; cv=fail; b=Vk71zy/UwIdLuhKCmx5efUYNWuRfOMgmsrWdWO1uC5kFA63Kt5lw4SwvDSsMv8F4aAxexUJDjLmdQW4ASLi0i9VIxHa+D84oGH5wyoigPbGQXn9RRdLsihhxMLrmSUAFPdNF1KOFQuLFpafD9eOISPlCddqdOR80L7+uSHIct8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109651; c=relaxed/simple;
	bh=LpAc9/CTQcTKNgLJogxC6llg2vWmIG0XiFCW+ah3oNY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nV+lNpQypQ5sqBUtijS5HnGGbJFfeuhSt1HbIaNGXDvalOSMdO/KN1oq9WCkPiZorFLKpcAthmqs1Acreeg5n3C+LF+xTlw0roA6onRPoZC0O0PyDNq+7RMSUyKEVBfn4zm5DEacEp13Tgle/NaGJH0FhudyHH30NdsMolIRh7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MP1Js1NS; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/0jLyoLE9eyA2AOyrusbpNnI2ETotK+YQdfzEMQaMM4nl9C8ZGjo8xbtmvJDbNssfaVdVr5h2za17zRelWyHSl+RhBdpLKKdn0YZRP/+yCq94W5oDM2HqLtqpSDq71Uumi+k3lRwkDOuxsggWiD5cY7LeX61S/1zQ0geuuU6QsmSz8ViZ9cPyHFjFPZdPpKqssW7vjBDhXb2czThAipS3B8glXsNF/AKfgZjVe/yUr5dubQHOe95aBN6qPS/CYiPe15CuBcgNQo01FkAag5mx7EvR8mmRCMimbEQggAG1Tkcgw47UA3TTehGZwGbImjGs/WjptVWVn2SPi/kGqfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHQgfZSQMg3h5wysYq8h0AlDO1NWYiOUGIqMVD14QRY=;
 b=N1p9TRy56RC039mnv/cWiA0Rkk88XI6pVXe0BXw93LXzkP4iFkur4Mv+sI3RCYjqYnsDrkVkcbExsgZcwe4il4sswwu/Bl565rILbH/BehfQAh1nWW12XdVZquPFO8C2ZdgG2QRZ3kxAgE2i+wf22wEoRS7wh3vtrz/O01Fmd4dbe9OnNAyJWyb5qk0nFCiSWQ4mJ8uy5zarspo1GlLd2908GkBcv5O3t0tqqbEcA/gzSWlcSzB7YSbvVZVXRMJP0u08knYvBsYJtU5QafBkn3IoxZNOE7aF7cG+jdR+tyoENw8meWm6xjr3yRH5C1j54boHhVkJH/cV0IKJYcrfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHQgfZSQMg3h5wysYq8h0AlDO1NWYiOUGIqMVD14QRY=;
 b=MP1Js1NSWnUyct4AAwlpWwtn1T1uHOZPUYk1OQMe8HMnlgMBB3Q8ZhHIfM6QbcsZyzgsWvYh99P1vpKR7lB4d2i5VlS3f5bns1PZNR6kdKn0XvnCry/ClEd418EeFbkDS6VCmQABYPjP23U0xSzOl4dp1h+n5ZFdK6rC+0MUE/w=
Received: from BLAPR03CA0068.namprd03.prod.outlook.com (2603:10b6:208:329::13)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Thu, 27 Mar
 2025 21:07:25 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::6f) by BLAPR03CA0068.outlook.office365.com
 (2603:10b6:208:329::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Thu,
 27 Mar 2025 21:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 21:07:24 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Mar 2025 16:07:23 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs
Date: Thu, 27 Mar 2025 21:03:50 +0000
Message-ID: <20250327210718.1640762-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 560e4380-f6f6-4d2d-19a8-08dd6d735fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rEI4ykI4USi54aBqpv6oI5D16sAIbSgcP6fYFuiReVYzdW/gRtCssFn7Umz+?=
 =?us-ascii?Q?ES7eGx6i8CreU7sj2iKQvzjjPvLW0JoSnNKJP87iWSOBuqJ/96I/yk/oPNyr?=
 =?us-ascii?Q?mDTq2rHlsgeOKyvxOR1RzJroPcwYnKZ/1uo0l0B7xPkTYWWkO50wnQKtLlzn?=
 =?us-ascii?Q?UkIv39JqEC5HFJJoU8UBPqRz/HRYgBy+owKischLpQ2eGp1I4ITw3NOZVt+V?=
 =?us-ascii?Q?X+K8yxASJ+iWEEA08XBlAWn8A4rhSH6085gzZ6uvNSgrqwSQmjo1r49vRhmV?=
 =?us-ascii?Q?aDNprz4Vz0gZjB6J8jXw40/5gna/Z9Qr5ru5v0PhMJBexxk9XmEz6vfGvmtR?=
 =?us-ascii?Q?jswx3mnHVzr44tZDOrYsxdBh1lgCyznYx6yQirpVHBncRXSNYtnc1XBcPGz8?=
 =?us-ascii?Q?7qys3M0LrkEy1iNfLM4h+nrhnNBqWBtl9vBkDUSUr7/je4zTYwcml9pzzyKA?=
 =?us-ascii?Q?wleAKyk2b+GXKvH4n5rA9lfb02vR84Fsp7Jkim8ixeI8RrO2C2a+Ax3QE9ap?=
 =?us-ascii?Q?qkKVK2rzmoxTzmoj3LPCKgJtXlwSza0P4wuMaEdDCddWIPptpOucICRdpgJX?=
 =?us-ascii?Q?gZAyR3ZIO2qbGGedULWX8XTcxaQ0GqYAtwggMwahOd01DpjkSZMbhCEGXgse?=
 =?us-ascii?Q?Mth1lRq0sKuEpdclyCw9NhFo630RhdA2l1ULzbgt/rBgNKGDd51LPO6KMb7M?=
 =?us-ascii?Q?Dd+tqgUHG1GS51MpUjCXeczJ3cE8qR/oV+JNB6+Ny589FEjMjqwl03P9+dKB?=
 =?us-ascii?Q?QMdf54iPYN5sKInZaTQ/86vugJhbFZF8BAE9K0i2WSy4NxUpvJJ789Ca7bbF?=
 =?us-ascii?Q?UBHEzWiFVbM4hsUxOjKmxHJgSSc8L+hh3Dz1qMpK4MmNbDUx1E7maOso81Ld?=
 =?us-ascii?Q?x4cwhbDMEj0iE+ldbts6/LZsoH4H3tZx9O+BTL6jT8DIb9koQP+TyKaWOXP1?=
 =?us-ascii?Q?hQmzhB7U+zGZWS5i61wAOLhstiwjcxxZIkFx2tTzf/SoPetjxvsbe3R3m4Vv?=
 =?us-ascii?Q?5MNLAEywaqN2Ou0dBZz1DXWvl+uMlnTnbtT6m4fTdgNVAZcp42zXSEOA+FJ0?=
 =?us-ascii?Q?tB0+nrefIC5Eoc3ZK9Hl9UvspZtLfBk3QqVLsIeZHrF/O7Dv7sNNXBbUC/Rk?=
 =?us-ascii?Q?7pdqkWAEfADGcO5mNMSu/aFw1+YylVK+6ijQSNPM2hVFCkp86qDqhUJ2Zp35?=
 =?us-ascii?Q?IkWGivFrx/VmOmbCdWkbMuo7RbvT2X+7bnYP1a4HcQzN1yfyUkSAuBb53vFg?=
 =?us-ascii?Q?YDWlQetQodLndcgoX0pTGd/imWeHzXU6uPvpG/t06JGTNcUKc4WiYy/Gz6m3?=
 =?us-ascii?Q?s7IZ52vqx0ddJ4AdhAruvTmVcgZFOVda0nnM2Yc4ydB5s1HDDB1zMQauZGH/?=
 =?us-ascii?Q?xWHEjVkToZy27J6KJmY6ZBzJ81TK7aBvf5XBABZulcq5+IIrL4NFXuJX/oK/?=
 =?us-ascii?Q?n2hCpqh21TOtxEdMHP0K8jEmrVzfrawrAckWJbRrpMEF77rhJj6Ltaki3w9n?=
 =?us-ascii?Q?ywkGDyRYe48bUUE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 21:07:24.9553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560e4380-f6f6-4d2d-19a8-08dd6d735fa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719

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

Furthermore, also rename some variables for greater clarity.

Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/edac/amd64_edac.c | 56 ++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 90f0eb7cc5b9..16117fda727f 100644
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
 
@@ -1230,12 +1232,10 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
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
+	u32 deinterleaved_mask = 0;
 
 	/*
 	 * The number of zero bits in the mask is equal to the number of bits
@@ -1248,19 +1248,32 @@ static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
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
+	int size = 0;
 
 	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
-	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
-	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
+	edac_dbg(1, "  Primary AddrMask: 0x%x\n", addr_mask);
 
 	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
-	size = (addr_mask_deinterleaved >> 2) + 1;
+	size = calculate_cs_size(addr_mask, cs_mode);
+
+	if (addr_mask_sec) {
+		edac_dbg(1, "  Secondary AddrMask: 0x%x\n", addr_mask);
+		size += calculate_cs_size(addr_mask_sec, cs_mode);
+	}
 
 	/* Return size in MBs. */
 	return size >> 10;
@@ -1270,7 +1283,7 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
 	int cs_mask_nr = csrow_nr;
-	u32 addr_mask_orig;
+	u32 addr_mask = 0, addr_mask_sec = 0;
 	int dimm, size = 0;
 
 	/* No Chip Selects are enabled. */
@@ -1308,13 +1321,13 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	if (!pvt->flags.zn_regs_v2)
 		cs_mask_nr >>= 1;
 
-	/* Asymmetric dual-rank DIMM support. */
-	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
-		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
-	else
-		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
+	if (cs_mode & CS_EVEN_PRIMARY || cs_mode & CS_ODD_PRIMARY)
+		addr_mask = pvt->csels[umc].csmasks[cs_mask_nr];
+
+	if (cs_mode & CS_EVEN_SECONDARY || cs_mode & CS_ODD_SECONDARY)
+		addr_mask_sec = pvt->csels[umc].csmasks_sec[cs_mask_nr];
 
-	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, dimm);
+	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, dimm);
 }
 
 static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
@@ -3512,9 +3525,10 @@ static void gpu_get_err_info(struct mce *m, struct err_info *err)
 static int gpu_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
-	u32 addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
+	u32 addr_mask = pvt->csels[umc].csmasks[csrow_nr];
+	u32 addr_mask_sec = pvt->csels[umc].csmasks_sec[csrow_nr];
 
-	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, csrow_nr >> 1);
+	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, csrow_nr >> 1);
 }
 
 static void gpu_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)

base-commit: f1861fb575b028e35e6233295441d535f2e3f240
-- 
2.43.0


