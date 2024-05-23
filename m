Return-Path: <linux-edac+bounces-1098-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74DB8CD9D2
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 20:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E325282116
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA96B80624;
	Thu, 23 May 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JAgmt1/x"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796A4F8BB;
	Thu, 23 May 2024 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488834; cv=fail; b=In5bnhi/U1lIVW5iVJHxojVuRDvQZerGor6A8QQyFLIzYxJ8ytYLJerDAI2e5onV//oUSkxwieKbiJjzNOod2CQvwVM3Ucfntne0EscUjFwFPXo8As792IKAcr+j1pmaJmLt5MaTJc30NcwSyyzAudeB1Wo2CXufpkVROrZOEk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488834; c=relaxed/simple;
	bh=BIcXZX1mtI8ZTj+EiV2rx3f58KkkrSjFXf1uZpjRcIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tdRe//LCove3DQbUucLzK+WdtdCLt9DPfvjJ8l/BOUAZUtAgan+7bHZQlhcXRih9lxaWo/bWTHyESOzDoDQuAWNCPtNazW1VmL2qsypDMMic+4eQnf++eiE+Z9bGdc4TzrkJgH3yxL+lXDkHebVFSXM/gGdo5qiP/LzaiUmknQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JAgmt1/x; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCFJJtZi4hOOizIk6uWIUiIm6ZeWd6uSrY0v5nGPomr8uAD7oNGcPTmQyliZdo43og+U3ruWUhtjCzvubsb2XKia/YKxUAj4LsyXyCMtOVXavRiIvhiZ+/oSpPuhqL0ELOmof9CSOMp/34HLRNqFLEI3jVhVIgGwhzCWFVvdwiJSOoBMO80tiaPWDmguZLgPVVOhcJ12qA+sTBeSlYrMrbfFXXHOtLK6Ncgoh47eDnr1MBg1n1+n1KrTHw8uDxY92mv1OHyRNufaw/yh2frrOwTRK/ojIo9vQ47NvMFrpp6FJFE4IrqXlxWEzDrE9qESBdlmyFWHDP6G6dHPJ6efSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7SCt7F4OO7w2sQIN1qLxP+POI2Lgw2NcR+2gbWxrSU=;
 b=Pa+Ig7IW57d+yS/Rbtvsv/XqpcgRTaD9059uyGB/FVkDlSYSOlBLu4zMUvzZ19gGvHKLRuWqRTylNl55k/kM9C3BKDxCwWIfMuBjdG2pYYWJnaGFpdltV6o7LTuA0P9/kaTYUcqa72ps6lTq3/1vF2K6AYzK55MBLR26Ui7E8FkeV461cL4FH0VlVOUwz3H9XGUL05xOCLv4+w8V9x9kbA65nOOQVcLjPRfUtIIfSGviUYKyBZ9F3D4YqshfPWpGSpfXrhMTcLWl3qDinVqFtMDFSV0jHiZoRatfKWUcqeWEnZWMelJFUvt95hA5iFuHpYzUEYFRUV5Qp6cTWqkMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7SCt7F4OO7w2sQIN1qLxP+POI2Lgw2NcR+2gbWxrSU=;
 b=JAgmt1/xm/u/0KdcIEpeEIulv2IY+eho93yIusOw0kV3E2OdndyvHx+9Gf520FE0wn4QPUd0ShvLT0eZju5Zb5VipGa2w4vN5aKAsO3Aq9Ya7crNGnV/dbp+7fqXWvqK5U/mjYUbx9n1GkPn6YSqTtbppyuXf8fRnQkZZAjv0pM=
Received: from DS7PR03CA0258.namprd03.prod.outlook.com (2603:10b6:5:3b3::23)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 18:27:10 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:3b3:cafe::f7) by DS7PR03CA0258.outlook.office365.com
 (2603:10b6:5:3b3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34 via Frontend
 Transport; Thu, 23 May 2024 18:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.0 via Frontend Transport; Thu, 23 May 2024 18:27:10 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 13:27:08 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 23 May 2024 13:26:52 -0500
Subject: [PATCH v3 1/8] EDAC/amd64: Remove unused register accesses
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240523-fix-smn-bad-read-v3-1-aa44c622de39@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea45ac9-e257-42b3-d4ae-08dc7b55f5ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmdIbENJYWhNV1hNanp2NGdxU2JXaFIyNk4wRUpxRzJtR1pHZGJGRVh4Tmoz?=
 =?utf-8?B?NElhbzJiUjRKV25INjdNOTl4WHNxcDQxV1E0cjN5bytSaGVBRjNpS210MjR2?=
 =?utf-8?B?ZDNwNmZISkg1cVlDRHdCUXRoelo0N0hyYjlaMlFlTk0vbUY5djdlQnM4akNY?=
 =?utf-8?B?Qm9ZcTNpcHZnMzI0TFIycDlydkwzZFhTenRaakFiLzhxODJGdUNIM2t5TWtr?=
 =?utf-8?B?UlRWRCtHTmNGZDA0YXBhL015T2dwamY4R3ROV3dPZUFjRzU3dENiLzlKam1T?=
 =?utf-8?B?SDl4K2pUK3htMHplTFpGWDBtUm51b1VqdEdWTFF3d24zUjh3d2NPM2lINFhz?=
 =?utf-8?B?NWs4OFNYYUtMTU95TzIzMExzNkZ0QlF1M3NzeDhkYjUxb0RDaCttUE5KTXQ3?=
 =?utf-8?B?dTBWb05BVnZ6YUU1R3JjMHVaWVViVG1CTVpXQVBFVk41THpIVDNhSjRadjFl?=
 =?utf-8?B?SlhpWVZvYTJUQ3Y3bml0Z1FyZHBXL25zam9MYi9ZWVRvbEFmMW1rcEJaSFQ2?=
 =?utf-8?B?QkcvZE5YNTRYeGRyNTRVNEhhQ3RIVDRqajQ0NGNsajBLdGhlTkNRbFZSYTd1?=
 =?utf-8?B?SG4vb3gxenpGWVo1STIzTVRid1lwb2FITG4xT0YrRHVSclo4MUI5TnN3Ni9T?=
 =?utf-8?B?bjJhakRzems5VlVxc2R3Qkh0V2xVUUFBUmFFWlF1TVg4NmhESEt6TCt6UmtF?=
 =?utf-8?B?cnNtaXp4aTVOdDJlSnhFSUVOYTBjTEN2dDZvdEZxa2F6WGVRdzRWTHJNajcr?=
 =?utf-8?B?eUFnUDd1OXZaTDd6UnNSQjlKdEp4Ty85d1QxNkJkUHF2QmYvUXJFM1QzRzBt?=
 =?utf-8?B?MVBSMWhxT3ZlYUZqTW44SVpHc0xJMmxNLy9ETU8rMDlIZUlCUWxma1BWZ2dZ?=
 =?utf-8?B?TVBrY0hRQW0ydUJtRnFydUFqSExUb3RkUWk0V20vZmpJS09kTVg3cTd5SXVK?=
 =?utf-8?B?dkJiVlh0YWQrcXBmOFc5d1UwMzVsTllKeno5ajVRRmdvSDNqK1dLKzRnNHpz?=
 =?utf-8?B?bGtrWmlQUXhsejdpWGZCUGoxNHUybVBwZjZESHhrbG9aTHhOLzd0N1dubVdu?=
 =?utf-8?B?ejdTcXNxVHFNMHg1dzVEcDNySG1GbDdrL1lpTCtDODE0bklFWHAwK3lUU3dl?=
 =?utf-8?B?S2FnUkdvRG4vQ2FKZ1ljdzl3REY5TUxtZlhhdnBwSmFpTXNBODdUcXJoakc3?=
 =?utf-8?B?cThzREpkYUt1ZThud1hrRlU3QXRiSFZhNHdmK3F1d1VNcFBoV1l1QmJQMUxG?=
 =?utf-8?B?WGZrTUVXeUlrdjc5T0hjaENKb3FIeCtvajZtRFFTTGlYVWQzQkNYU0xPSGRR?=
 =?utf-8?B?ZEQ2MlpqbHdVM2JhVEJvVHhyVFVuK1loOHFra1hId29SMHdXQnoxb0VOSGtL?=
 =?utf-8?B?SWV4anNoenhaSTdkeUo0ZnBjMnArMSthc09wZk5FcTRTb0ZHbTdYcVd5cmVR?=
 =?utf-8?B?NUQ4dG9jMGRPVTRXMW9pT0E0dGNzWW55bWU0bjFpYkZtMzNOOFNBKzkrQ21R?=
 =?utf-8?B?Y0VCY2syUy9TS3ZCdDVhVWE5Rm1WNDZZdEZ1RCt1dGwwNjFvWnBrU0xLZ3pv?=
 =?utf-8?B?b2RZUVpzSnU2V3RXUU80UjRCRkJ1OVlmWXBtNHFVeWVkNzNpV2tEQ2hGRUhi?=
 =?utf-8?B?RVBQVlNEYitVaFlGM3dBV0JrNE9mNGIyOHBjelZCc2ppYTVxdjRNZjZHdzQr?=
 =?utf-8?B?c3ZabjdGUGgyRlg4Q1RZbTNQb2Z4dklxSURKdGN1ZXF4by9hUXd4VUFCdi9F?=
 =?utf-8?B?ZDVPS2Q0K2YzR1N1d3NqdEdISFNVWXJRRUVPQzdIVDVETkY1ZVhxa3hiVnJP?=
 =?utf-8?B?UWRMcWd6ZVZvTmlKS0Evb0k3eWVCZ0M2Qk5TVG50ZFR6aXpuYWYwc2ZXUGEx?=
 =?utf-8?Q?DIGHvYkZqSA+F?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:27:10.5552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea45ac9-e257-42b3-d4ae-08dc7b55f5ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990

A number of UMC registers are read only for the purpose of debug
printing. They are not used in any calculations. Nor do they have any
specific debug value.

Remove these register accesses.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/edac/amd64_edac.c | 18 +-----------------
 drivers/edac/amd64_edac.h |  4 ----
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1f3520d76861..4cedfb3b4cb6 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -20,7 +20,6 @@ static inline u32 get_umc_reg(struct amd64_pvt *pvt, u32 reg)
 		return reg;
 
 	switch (reg) {
-	case UMCCH_ADDR_CFG:		return UMCCH_ADDR_CFG_DDR5;
 	case UMCCH_ADDR_MASK_SEC:	return UMCCH_ADDR_MASK_SEC_DDR5;
 	case UMCCH_DIMM_CFG:		return UMCCH_DIMM_CFG_DDR5;
 	}
@@ -1339,22 +1338,15 @@ static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 static void umc_dump_misc_regs(struct amd64_pvt *pvt)
 {
 	struct amd64_umc *umc;
-	u32 i, tmp, umc_base;
+	u32 i;
 
 	for_each_umc(i) {
-		umc_base = get_umc_base(i);
 		umc = &pvt->umc[i];
 
 		edac_dbg(1, "UMC%d DIMM cfg: 0x%x\n", i, umc->dimm_cfg);
 		edac_dbg(1, "UMC%d UMC cfg: 0x%x\n", i, umc->umc_cfg);
 		edac_dbg(1, "UMC%d SDP ctrl: 0x%x\n", i, umc->sdp_ctrl);
 		edac_dbg(1, "UMC%d ECC ctrl: 0x%x\n", i, umc->ecc_ctrl);
-
-		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ECC_BAD_SYMBOL, &tmp);
-		edac_dbg(1, "UMC%d ECC bad symbol: 0x%x\n", i, tmp);
-
-		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_UMC_CAP, &tmp);
-		edac_dbg(1, "UMC%d UMC cap: 0x%x\n", i, tmp);
 		edac_dbg(1, "UMC%d UMC cap high: 0x%x\n", i, umc->umc_cap_hi);
 
 		edac_dbg(1, "UMC%d ECC capable: %s, ChipKill ECC capable: %s\n",
@@ -1367,14 +1359,6 @@ static void umc_dump_misc_regs(struct amd64_pvt *pvt)
 		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
 				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
 
-		if (umc->dram_type == MEM_LRDDR4 || umc->dram_type == MEM_LRDDR5) {
-			amd_smn_read(pvt->mc_node_id,
-				     umc_base + get_umc_reg(pvt, UMCCH_ADDR_CFG),
-				     &tmp);
-			edac_dbg(1, "UMC%d LRDIMM %dx rank multiply\n",
-					i, 1 << ((tmp >> 4) & 0x3));
-		}
-
 		umc_debug_display_dimm_sizes(pvt, i);
 	}
 }
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index b879b12971e7..17228d07de4c 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -256,15 +256,11 @@
 #define UMCCH_ADDR_MASK			0x20
 #define UMCCH_ADDR_MASK_SEC		0x28
 #define UMCCH_ADDR_MASK_SEC_DDR5	0x30
-#define UMCCH_ADDR_CFG			0x30
-#define UMCCH_ADDR_CFG_DDR5		0x40
 #define UMCCH_DIMM_CFG			0x80
 #define UMCCH_DIMM_CFG_DDR5		0x90
 #define UMCCH_UMC_CFG			0x100
 #define UMCCH_SDP_CTRL			0x104
 #define UMCCH_ECC_CTRL			0x14C
-#define UMCCH_ECC_BAD_SYMBOL		0xD90
-#define UMCCH_UMC_CAP			0xDF0
 #define UMCCH_UMC_CAP_HI		0xDF4
 
 /* UMC CH bitfields */

-- 
2.34.1


