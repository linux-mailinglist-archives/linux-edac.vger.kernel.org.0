Return-Path: <linux-edac+bounces-1218-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0728FF210
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 18:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F6D28B21B
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4476B19755F;
	Thu,  6 Jun 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EnJFVw8j"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E503197A85;
	Thu,  6 Jun 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690405; cv=fail; b=fjSIdsaOD2MMSIqo96UWj907iC8mLvyGMQIaIbgugIb1MQOLhZ7/V12n1vGyityZrR6KxmEsxF/oJ+U+wSkq/9NrJWryY33SGeNsCstdeMhm0tSOZhObE93k4hOyBhqhMT7RFrF0d+h1W6mp2r656VZtHgvUI1VU2JNZYtRRnFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690405; c=relaxed/simple;
	bh=w8/KCczhGQKcmIm4ZXAF+LWIY2sLX43W13QiFZ+B/iY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fIVtbkagowizPYdo8s0Lrf9qoQQa2jsTBZxKT2uoaD1DTD+l4YUIxqT4igO5v/ysYqHNYBa6OfXG+xjiWNKKEmcB7LqOQ4feb5eoxLNFBpnMSm7apFSGUZ77G3upzokhpkj8XP9cfRrkVfhfvYqHqojZZOucYYXdJU5q+UZSFHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EnJFVw8j; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2o1CxVlXuRyy5APLNzTNFLM0kAdaHJEKT4EnsHBaJA6PdbV62uUlshFG17r6ciaD0+63y9EnZldwuJeytKs+RAEGqYWNZnrBCxJh4Pzl+dCgaVyOh7C+r9M4SMQOfNrD61V/B9egA1vFRcv+bpu5kRt8C027Sgd3b2SQAaVaPGp9yGfOB9fXU/da9oDafQzQp1zlLIG7+p/+8SMBfLiwlTGbOhZ1EYtCNWhC3gxYmROeirGgp+DP+CyAg9BhiBpmm0zmdGy2J2YydpxuguavrcnTowdnTo4ckseavMoGpD0+Bgf4i4bGYOX/Au90aOvIboHgPpShm6lE8qwcbiWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJbQ5aHkjvpM6IBklleTnILdolhhhWaT6GN/wxrHqNQ=;
 b=hKh0ZTyPCqWpbI+zoth5l+rMPYj8raTgug8/dtJcb4hkD+vy6dmulq0/2t9qBTwSaHcxGdJ7Rx8MOWF4Ox60zoywsSJgkr9NE0Ln/Li91U7IvFVh65YPuuChGp1bb+x2CRNOZqlZyrVubKsPIA77Ad2a6iQViWStcEd1YK5FJbkr2yiJuKdW2vw8W4j+e2rXIsYTa1HGCMXPbih/o0xGxh7JdXfE5cN6OQkHtFgHjjfLS4MkxvcZTHy9KmoYEeNcK36XS2qiwuk8hbq73m69BGAUUbQD/xLjWFBTA2lya2yZYtWGCUuCaZF4mIYr66ZQzI2TleNsrfLxxXCeuPxRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJbQ5aHkjvpM6IBklleTnILdolhhhWaT6GN/wxrHqNQ=;
 b=EnJFVw8jGJUYA1rMyuhr97sxLTse2lc81PZo5V90nTcQ6Uk62VXGvuj+lEjglp7kZOM5Cgy+Oa07pR6y35altcaLI82Z9qMX4j4JUHmnUx6LRuU6uvq5i3NV79TMeffxeAT/ZoeKHjPSfIye3uPEZhLJcH61SNuZeQzt/2ABK98=
Received: from CH0PR04CA0101.namprd04.prod.outlook.com (2603:10b6:610:75::16)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 16:13:20 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::d) by CH0PR04CA0101.outlook.office365.com
 (2603:10b6:610:75::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 16:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 16:13:20 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 11:13:19 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 6 Jun 2024 11:12:54 -0500
Subject: [PATCH v4 1/8] EDAC/amd64: Remove unused register accesses
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-fix-smn-bad-read-v4-1-ffde21931c3f@amd.com>
References: <20240606-fix-smn-bad-read-v4-0-ffde21931c3f@amd.com>
In-Reply-To: <20240606-fix-smn-bad-read-v4-0-ffde21931c3f@amd.com>
To: Guenter Roeck <linux@roeck-us.net>, <x86@kernel.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <babu.moger@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 3758d8fa-7f4c-4d65-6574-08dc8643954d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXlLaElSREtVSHFLZHFMdHhrMkdmZXczYVEvekxkaXRnTXN1TU9DM0RrRTF3?=
 =?utf-8?B?M25NbDlVSjF1SXNxL2tvMkdaY2VPd0VRWnhLK2dMS0IwL0dHendCUjViQ2py?=
 =?utf-8?B?QUd6elVER0dwc01yUjY2cExxQ1VIbjRiK1dhNEpvS3Q3RHYwc05Zc0ZOS0pr?=
 =?utf-8?B?RDlNT2ZOVFM2cENkem5rOCs1bmhtQjlGRnA2NktibW1mek0rOWtwemFCRjMz?=
 =?utf-8?B?MStZak5KQUtBYXQwWGF1TmZSTXUwZWFEYm9PL3FVZC9WSUo2QkMwMDBkdUsz?=
 =?utf-8?B?cWN5c1h1eE5IaDhkQUtxNDR4Qk15eHFiMjBvSXA0ODNrWWRnTjRWN2FETkxR?=
 =?utf-8?B?eWdrdTdlN3kvR3d0U0Jnb0tRemxGMnBlOFRGcnE5ZWVrdjRoUUs1anZQRnFP?=
 =?utf-8?B?VDkwTURJSCtMM1N6ZlYwSEJITWRPZnpKaC9YY0VLMi80SUhvQllmZElnbFQz?=
 =?utf-8?B?R1ZRUFRMSng0L0srSFZ4WFF6YVV0UGVjTnJJb2ZRVFBYdGdOSFQzK3g0YzNk?=
 =?utf-8?B?U2NGRGtFOXNnVDRnTVFwV0Y0Z0pTMjNjYnhrMHpuOTlPNEFyMnRpdmJlQWlr?=
 =?utf-8?B?SGk4VG9lbjJMWWJkczUxOFY0WnZEdzFZYkRKTW5vMjFUMzhXM2R1WE5adjIz?=
 =?utf-8?B?MWVXVkNnd0NLUC9GYVh2ekx6WGVhcWgxemhMK0lUWHIyamFVTmpNTjhVOXhM?=
 =?utf-8?B?WUZxUnZ3ekxPNklOTkhZcmovQ0xwbjdTV1B3Q1M1TnRWbmYrZm8yejRlVHI3?=
 =?utf-8?B?bHVBSHA4TjhGWHFxVzJkYzNrMFNlMGlJN0VUeXBQZDRDMXB4ekhBZGJub2da?=
 =?utf-8?B?MUtCN1ZLckh5L2VtNDQ1YzdkN1N2MGlNamRTS3dNVlpvUjVnV2NWMWVuVGti?=
 =?utf-8?B?QjRkb2s4bEFwM1FsMG5oMmZsZi9WMFVNY1J1VDkydEY5SlIzdENISXR6OFgw?=
 =?utf-8?B?T0UwZVdsQ1B0SDhVaEFkc3g0VWFmRWFvQzllYnpaZ1gveXdidUlEMC9QenAw?=
 =?utf-8?B?ZFR2U0dQL2ZoaVlwbDRtV2lDTEk2Y2ZWZWxJRDNTT2lKTUV3dTdxNGdqY2pP?=
 =?utf-8?B?ZS95Z3UyUzRSWWpzcDlaa1B6d2R5djRVYjhLUXFUWCtiNEpRNUJiTnB2RGJu?=
 =?utf-8?B?eTQ0YWV1VjdsdS9OaTJQcy9PQ0JLQ0JlUS9sKzkzQzVWSUZJcDJoTHkrT3Q2?=
 =?utf-8?B?eklpVUpFUTFxSjVLSVhzSUF3VUM0RWZsaVdtd1I3VWNHaFpkRUUzYXJYWVFE?=
 =?utf-8?B?WmxZamp0WUJERVJTNTROU1dlM2xkN0o3d2pWMlU5Y0s4ak1sSktpRWh3Rlp6?=
 =?utf-8?B?bUJhZXJjVzRkdks4OVVPYUdDVG1yVHdXMDZhYjlMMERzbXFPM3kwNnNXanBv?=
 =?utf-8?B?VFYwK2xXK2VaMDZ2dTh2YkFoV0xQSGVmc0J1V3c0V1BsMFlnR0xpSzZjOXdV?=
 =?utf-8?B?Tm9MVnJvUHVTNG5KRHpHOTdaWTFFNXpiOWt4YUlOb1dYVThROWY4OUY2dEF4?=
 =?utf-8?B?WURha1BncWxyNEllTEdydlZJRk1KdkZhaStRSFZsZHJBbGxGOEFYNlJ5ak1Q?=
 =?utf-8?B?UnhiYjZVY05VRllmZzQzUlJsN0xMbDNJK1RFbkRneGYyTk0vcG5oTkVZeW50?=
 =?utf-8?B?U2lWSW05a2w4UklPaEhXdXhXUnRKNks3akkvd2tzTmw2c1V2dDdBd0wyYWt4?=
 =?utf-8?B?RGlEYVdLekRmcEl1bytQWFI1ditwMVJIcm5VaWNQOTE2aDFidE02WmlsbFpq?=
 =?utf-8?B?RjR0V0lucnplTEZ3MnZlMHljcE5OVjg4anNBVTg2NEYxSmpvN3JIU29JK2xy?=
 =?utf-8?B?dVRjRHdVc2txd3dzckZGS3BHTUdRVnNGdkkwNzVVS3N0RzlLTnFxZ0xNWS9D?=
 =?utf-8?B?WnYxTEpGckRHbDAxaGMwL2xCY01sdlU5N093WTVjWEZ1Qmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:13:20.4794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3758d8fa-7f4c-4d65-6574-08dc8643954d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760

A number of UMC registers are read only for the purpose of debug
printing. They are not used in any calculations. Nor do they have any
specific debug value.

Remove these register accesses.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
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


