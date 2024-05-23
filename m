Return-Path: <linux-edac+bounces-1099-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD148CD9D7
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 20:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E87B2242B
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 18:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F32B82872;
	Thu, 23 May 2024 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KkRo9wLk"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C36C328B6;
	Thu, 23 May 2024 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488835; cv=fail; b=dJ/dojilbB2NnYY0hgDSAm2P1WHKGpT7XbxSf4F7NITjqyS0KjtwxMqsKprSouhnHjUhtfvSph4ZSoIaynFiR1AIiDGCFIRnSja/WGwTZIgAOtDYaMEHHIg/jV5Z5Zldd0S89I941mVmf/27pbLJcYIFFPLLVqM/NTJ2eBCA+0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488835; c=relaxed/simple;
	bh=wwYqJWUS+KYhs9EtGAZZWv9VZgwoU0otfpLm+i1Ff6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MNodi8K+x6HLEmlUNN1lMA3DbNvMkwwLnx0daAvhyCz9DfleVsJfQImVBg7A9F+XZr7FwReTehfxh1EJ49v0cM8K7WvOHekXlmnL6Vh8LU0brdX8PG1Ziivq+1ybXIy4lxHl9uwqb5xyYsR4tpfXFRdAAdQMoA2Q9PUVczey9bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KkRo9wLk; arc=fail smtp.client-ip=40.107.101.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj6klcuIhzdQjRe4DOULpqByr7BhTEhl1ukwHdJzCKwaOeaGk+pJuObdsYOKFKd7bvIwPvRpzc0XQO0IJnqjUfjfMlchwO/D3u2EKM+c4jL/fwTThcTHw4Gm4FzZBy8XIzbPOS2a5i8xLBjMJHmZrPQqBF/EUALfrgSXjBJuEa5OHewqXsQi2nsvMD7Ja4p70M/p7qVulRd6TwXEOWxd760aKGunmYWjcHwwtszBuvnnp5CjYG9pD2p9v+YxW3f39JsBSKxG0/SYNcgmegng8OPJLlifIylLg74+qX7FqN3zxGrixL251wRaR8DhHNoc+d/BuqYtCzSMMhps3NpnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OCt8Z94Wcov5itagpyaQtF99QufOLAe8Ee91JXuDAo=;
 b=XV8iExjpkVkur1819WVqN2LNrxWLe4nmqoVXGWLSzzb5CEAOzjsxUlnXcBs+gyCDO49Ei8USAR/nAChGdrvqllVkPNDY+epOqEq9Yv/4e7wApDGyRR4cpPCS7qTGfh48V1XBz0Jhy3mrBVDHG8EWqP9iHVZT+OflV4nDqDJsCsW918NU7oB3hjH3C1XKuKugXI5sYzyAk+DdgYQ/+rMDLTTRHPbSMz9KH7duuLEiUks6M9Q8dJXTN/p/XrGdmiEdyfym8sX6zCnOYROn5xr0BUYQNfDNqd91bRQ7s2kvBmLCecxxT3pJJlceocR2Sl2qr0netjulvB44ROH/2l8UXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OCt8Z94Wcov5itagpyaQtF99QufOLAe8Ee91JXuDAo=;
 b=KkRo9wLkNdLwTQvtFDRTwTvjblsWz0Tqymz1R04PQuDTa9eUiYeAmwSKTFbC2saqvI+OqNPiWbsi8JshmFxxPDP8HhitAwceXm9unJokaGt0K3HEX0wYn6g6++4oB2Xq1mKV0VETsbZH2KGXN1im9Hbt2vJZyTFtODrVb83Z67g=
Received: from DS7PR03CA0264.namprd03.prod.outlook.com (2603:10b6:5:3b3::29)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18; Thu, 23 May
 2024 18:27:11 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:3b3:cafe::21) by DS7PR03CA0264.outlook.office365.com
 (2603:10b6:5:3b3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Thu, 23 May 2024 18:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.0 via Frontend Transport; Thu, 23 May 2024 18:27:11 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 13:27:09 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 23 May 2024 13:26:53 -0500
Subject: [PATCH v3 2/8] EDAC/amd64: Check return value of amd_smn_read()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240523-fix-smn-bad-read-v3-2-aa44c622de39@amd.com>
References: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
In-Reply-To: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
To: Guenter Roeck <linux@roeck-us.net>, <x86@kernel.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf4c44a-b482-4943-e4d2-08dc7b55f61f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTNwWnNYcFNiWHVhMm5pSkg0QXZPVzFXQU53VlQyaFlPTTJtOWdVL0hybXhJ?=
 =?utf-8?B?SkNNZHgzQ0p2QzQvVjRXWUZtRXo3cXJEVnhHZUNMZkxITVNnTzBHNjg5cmh3?=
 =?utf-8?B?TTIrOUxGZTdLTU1MMThlNStXNWZvSmpXTnNrZ0syMC9nbjcwMXYrYnQ3NklW?=
 =?utf-8?B?QlZ5MkxoODV5bXRwbnZSMWZvWldtcU9uZDlVRnNCM1I1c29pNUFoQjNtTjc4?=
 =?utf-8?B?Y1gyQzN6MzBySjZTdmNaeTBQOFRvdjdsOFg0SUMvTEdTLzJZeW1EQ1RtM2xa?=
 =?utf-8?B?dFZWVjN5ZUNyUnk2N2dUVUIwWHBRV3Y4c1VSQ2NKUVF2aXpWN3pYMnE3Rlh3?=
 =?utf-8?B?RkExTDAwN2VudTNTUVVhdDMxZ0xPc1pTeUx5U0ZrMFUyemxDN2t1TTdTZVhJ?=
 =?utf-8?B?VkNKRlEwRDNTbEtxaUdYazhYaFV4ajluclN2MFpQSW5JN0l0bC80UjNLb2FZ?=
 =?utf-8?B?UldPbEJFb0J2aFROaXA3b0kvSzZ6bGVmeVFWOHlRemNQb2VOK1pWOUpnT3Ar?=
 =?utf-8?B?YUV4cjZWdmUwd0ZNZDdJRUJFQ1JYYmlrVys0SWxOYU9lMXEweDBNYWwvMDNa?=
 =?utf-8?B?dGVmcHAxYm4xTW9yeUh1QnhWeno1RGF4WkZFL2ZFanZLcFpFMkV3QS96dkty?=
 =?utf-8?B?WmdVaG05QVFrTURzUVdxT2hsb3Nzb1pUWFBjdlM0bnhMMjZpSms1RzNxa1Fp?=
 =?utf-8?B?amp1YllENTZFUDY0RzZxWnB6ano5bHhtL0tzQjRKQVdzeDYvVFZQbjMzK1ZF?=
 =?utf-8?B?ZWQzZ051bU9HSGcvWnYycTVTYXA4THpLazFuOVVTdkg2blBFWlVNbFd6NVJ3?=
 =?utf-8?B?UGlua21NdXczamMzQmVOc3NVeTNEZmJyQndqdGpWbU90K1ZNK1MwenVlZjlR?=
 =?utf-8?B?bEdoRy8yNGVZdWZjaXhXdDNycUN1OFA2ekg2RXZNcTFkQ3liNU5FUWNNNkMx?=
 =?utf-8?B?Ylc0V2gwNmora25HSDVHb1VOZVZHWXBBdU05WkZQRkdrQmZOS1BqZjdlRUxI?=
 =?utf-8?B?YjAyNlFNaDN2Rk1pZUtCYjFibUF4Q1MwU0REc2F5UGErQmZPMGJEV3BzYVlv?=
 =?utf-8?B?aktlb0xvM2JWclB2dG9peDdLd3BxT3BNdk5QWGh6Rm1Zc3U1NXdsV09HQXVx?=
 =?utf-8?B?V2k4a2YwSzFRWXZCMGVzdElmdXh5TGg2ckVHbXNkamJHbXoyeERFdnVTV055?=
 =?utf-8?B?SVBGTGtNcGViTlAvRnFya0V4SEd1Wi9jWXlKMFl1NnM5SUNFckVLN3BDU1dJ?=
 =?utf-8?B?eUtYUDZEcW5YeVZQSWpPbkZaRlY4NFBWcytzRUE4eldMenN4Q29qdTc0dVFC?=
 =?utf-8?B?TWJUYVRMckI0aUIvZGlaYVpoME44bDVuUThvSmhIQmR5V1U4amxuQSs0OE5h?=
 =?utf-8?B?d011YlNjWnh4NDQ2dVNtSFNUM2d0dk9RRkRGOHdnampWYU9IVHh5Um1rNWo1?=
 =?utf-8?B?b0QvR2dYZXVXanBUMjdNVWdSNTRXK0JtemtYV05KRTZRZmlwb0VEanAvNVRs?=
 =?utf-8?B?OXplbWNpWGxTQXpuTmhiUnI1bTNEMkZLSWNPMkpNMEt2VXdsMDREZ1lUcjVk?=
 =?utf-8?B?dC9FQXViakM0dnE3Q0dEemhxTzJSRHFneFJQa2F6S25qRnJKUEZrOGR3UzNQ?=
 =?utf-8?B?MGlSbGdlQ2lQVTlPbzVRamw2NmIwTCtybTd5R01TSzhBVGk4QS9TVi9HUHRD?=
 =?utf-8?B?SzdWSUFzeXhpbTBzanhoZmI4c3gvMkZ0VTVjVzVqRW01cDFjUHhQaTRFTWhU?=
 =?utf-8?B?WitzU00rRUdxL2p4c2lTL0R4WXE0TTVNSVB3N0E5VW41d3QwMzIwT2VZbnRX?=
 =?utf-8?Q?rIeBChDRvv/2PZxv94Gzzqrr0SYgsrbOhIsqw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:27:11.0864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf4c44a-b482-4943-e4d2-08dc7b55f61f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287

Check the return value of amd_smn_read() before saving a value. This
ensures invalid values aren't saved. The struct umc instance is
initialized to 0 during memory allocation. Therefore, a bad read will
keep the value as 0 providing the expected Read-as-Zero behavior.

Furthermore, the __must_check attribute will be added to amd_smn_read().
Therefore, this change is required to avoid compile-time warnings.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/edac/amd64_edac.c | 51 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 4cedfb3b4cb6..e958ade6ff24 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1436,6 +1436,7 @@ static void umc_read_base_mask(struct amd64_pvt *pvt)
 	u32 *base, *base_sec;
 	u32 *mask, *mask_sec;
 	int cs, umc;
+	u32 tmp;
 
 	for_each_umc(umc) {
 		umc_base_reg = get_umc_base(umc) + UMCCH_BASE_ADDR;
@@ -1448,13 +1449,17 @@ static void umc_read_base_mask(struct amd64_pvt *pvt)
 			base_reg = umc_base_reg + (cs * 4);
 			base_reg_sec = umc_base_reg_sec + (cs * 4);
 
-			if (!amd_smn_read(pvt->mc_node_id, base_reg, base))
+			if (!amd_smn_read(pvt->mc_node_id, base_reg, &tmp)) {
+				*base = tmp;
 				edac_dbg(0, "  DCSB%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *base, base_reg);
+			}
 
-			if (!amd_smn_read(pvt->mc_node_id, base_reg_sec, base_sec))
+			if (!amd_smn_read(pvt->mc_node_id, base_reg_sec, &tmp)) {
+				*base_sec = tmp;
 				edac_dbg(0, "    DCSB_SEC%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *base_sec, base_reg_sec);
+			}
 		}
 
 		umc_mask_reg = get_umc_base(umc) + UMCCH_ADDR_MASK;
@@ -1467,13 +1472,17 @@ static void umc_read_base_mask(struct amd64_pvt *pvt)
 			mask_reg = umc_mask_reg + (cs * 4);
 			mask_reg_sec = umc_mask_reg_sec + (cs * 4);
 
-			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask))
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg, &tmp)) {
+				*mask = tmp;
 				edac_dbg(0, "  DCSM%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *mask, mask_reg);
+			}
 
-			if (!amd_smn_read(pvt->mc_node_id, mask_reg_sec, mask_sec))
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg_sec, &tmp)) {
+				*mask_sec = tmp;
 				edac_dbg(0, "    DCSM_SEC%d[%d]=0x%08x reg: 0x%x\n",
 					 umc, cs, *mask_sec, mask_reg_sec);
+			}
 		}
 	}
 }
@@ -2892,7 +2901,7 @@ static void umc_read_mc_regs(struct amd64_pvt *pvt)
 {
 	u8 nid = pvt->mc_node_id;
 	struct amd64_umc *umc;
-	u32 i, umc_base;
+	u32 i, tmp, umc_base;
 
 	/* Read registers from each UMC */
 	for_each_umc(i) {
@@ -2900,11 +2909,20 @@ static void umc_read_mc_regs(struct amd64_pvt *pvt)
 		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + get_umc_reg(pvt, UMCCH_DIMM_CFG), &umc->dimm_cfg);
-		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
-		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
-		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
-		amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
+		if (!amd_smn_read(nid, umc_base + get_umc_reg(pvt, UMCCH_DIMM_CFG), &tmp))
+			umc->dimm_cfg = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &tmp))
+			umc->umc_cfg = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &tmp))
+			umc->sdp_ctrl = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &tmp))
+			umc->ecc_ctrl = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &tmp))
+			umc->umc_cap_hi = tmp;
 	}
 }
 
@@ -3633,16 +3651,21 @@ static void gpu_read_mc_regs(struct amd64_pvt *pvt)
 {
 	u8 nid = pvt->mc_node_id;
 	struct amd64_umc *umc;
-	u32 i, umc_base;
+	u32 i, tmp, umc_base;
 
 	/* Read registers from each UMC */
 	for_each_umc(i) {
 		umc_base = gpu_get_umc_base(pvt, i, 0);
 		umc = &pvt->umc[i];
 
-		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
-		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
-		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
+		if (!amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &tmp))
+			umc->umc_cfg = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &tmp))
+			umc->sdp_ctrl = tmp;
+
+		if (!amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &tmp))
+			umc->ecc_ctrl = tmp;
 	}
 }
 

-- 
2.34.1


