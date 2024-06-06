Return-Path: <linux-edac+bounces-1219-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F328FF215
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3DA1F266E8
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243111993B0;
	Thu,  6 Jun 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EIoSpYZf"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0919938A;
	Thu,  6 Jun 2024 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690407; cv=fail; b=Cewg/gpDlIl6fud2MkycGuydU2zB9YLlSocJMBMXVXNeJekQAcLEKU4hQM4D9e1kCAUKHdBa9soy2Xdyqdy5VZlGMCxf+SNT8ta6dcoRBxasYuLM26e3mX6cu/RCkrOBfAHHXWwpebKVjAnjx0/qmHqOvfg8NwEPA/7/Fp+cXl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690407; c=relaxed/simple;
	bh=LnxJPSgE0r64ML2RQm//3BfDZYpa0oAmS8jPoS2I3FE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nYYh5kT94SqHI4R/DTWOSqPXfgvN+BPqMrDJo+mK1DKpxf3VnYRBFfqvH1x5xKD3tbq6pU9LKkbJlixileRDoh1+VQ/p8d8trXKgfhfdzIe5tguiQy3vQ+Z+uRUcqrq4Ne5ukeErGxfdT2ZF98WgyDeuOnfOqB6iN0O0eRaxKCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EIoSpYZf; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iS7Xl/SohIBwRdQotJYbTMIfU6Vs3oqpBlPOr2D1mFgDOU7AsH86JjnWZZR3fBjy90VmWirkqfJMAm/CXdKhzBb0X23NZO2oeRG05y/qaj/zf84GEQ22YOEZM986emgHiQTtHaK5OvH8dPn8eDIbWG/lYSrubMBfVDB+tEHG/Vv8a3rZ9wvAsMUme/X2a7oFeg18YZDvpJYiDoShVU2phJjsuaJZ+dZYV6Sn755xt3Wqs/WJLtTN3Y5SKYKo9Qo2nFYm5E3NhiVhw4g6PcGYEn1q0vXH2y3Lc8c638g032kUAeeeBLV1EIyBUT8TThjOSa/iSLv3OSSYbFxM356AWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsDZR3hzWO/VTYZ7wJbVcJ5VZEkIzXGeZnBSNwhqRPQ=;
 b=kgUdxV6kXBKQN9TsVL/KBFthXtMvFUTe9WVPFV05TifbgbWLy3HTrDRsf3GXzMB5/ZIDF3CNk/ha1QsP/4foILzUdezh6CmvARvU2vpVgYiqTmPiMnEZmnqB+E9HBP4s5W/MGI3hntD6qOC6y7616fvH40KSj2kVdqRSemYcl/WGJnPvpzDOZgA/dbb6jHlpsE1gBcp8I+zsidu+Xzb44w32k4+HhkfhKIIP5qiP0yjF5cPqS6V7HXHP4IQBlVoqMigXPXfcLbcW3BbmhzAM5gPjkNXtulI8p+Ebf9AXjq77B5JS2FAkkWifVI6FB3bOgwB+2cchfand8kqTEp+Q0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsDZR3hzWO/VTYZ7wJbVcJ5VZEkIzXGeZnBSNwhqRPQ=;
 b=EIoSpYZflglEZzuPPNNowGv2UtgkZVWqMGDHJ/Xhr71wYY3f7Xw4y9BrWpRr/r614wdi3t6P3cyH8WtahVUmd2HelwQgXIo8WSgJsZML/ytIJPsT7hnl/ccD3dsO6i5p5pAX85S7fGulGOVq2o4fTae5CpzSj3hXHGFUADRVHAM=
Received: from CH0PR04CA0091.namprd04.prod.outlook.com (2603:10b6:610:75::6)
 by PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 16:13:21 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::bb) by CH0PR04CA0091.outlook.office365.com
 (2603:10b6:610:75::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 16:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 16:13:21 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 11:13:20 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 6 Jun 2024 11:12:55 -0500
Subject: [PATCH v4 2/8] EDAC/amd64: Check return value of amd_smn_read()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-fix-smn-bad-read-v4-2-ffde21931c3f@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH7PR12MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ae1ec2-2bf1-49c8-d81d-08dc864395a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmRGbXdhL0pGQ2VXbXlhSDd1MGJBVWwvTGx0aEh0VDVzVW5POHQvelJwNDVM?=
 =?utf-8?B?akdtRm5UMjZKejgwY0g1djIzaXNhQkJYZTNoMFkzaXNsOGpRTzVseGZNdGll?=
 =?utf-8?B?ekJOaHBFVU84b1RoMEIySDlIZTdza2E1TzlJcDNCbUhVdThiZW4xaDAybHRQ?=
 =?utf-8?B?VW5MOE9yaHF2T1dWT24xZkY1MU84c2J1OXFDd3hxRnVpMFgrbE40UDFaUHZr?=
 =?utf-8?B?bTRxaVBxc2NwUjAyNU01SUp1ZXZheng2VzZiUEd2cGVyOEFmM3pzQ1pLVnJP?=
 =?utf-8?B?MnhuTXM0cHQrY3FsT2oyclZLUlp5VnJHWFVlWHJobjVCVndKRE8za0IwbkhK?=
 =?utf-8?B?NWhiRi84d1FNdVZCby93TjhITXRNQ3RYQTAzWE83Z2d0MEZqZlVNeFdpd0V4?=
 =?utf-8?B?ck9ESlZDNU9iVEFjZUd4MVR5RVRQTmZLL0NLeC94aTNkR0lqcEd6Rk8ySVdM?=
 =?utf-8?B?TEkyWWViVnRRRGRZVHd5aDlJTGdSTGw0MEZYM3liUENRRVVzUUpjN0FiRzJU?=
 =?utf-8?B?TDh6VEtZQ0QrQ0E2N0ptcUxiaHVzc2ZDK1ptbEpWZitZYUxJTnhzMUtnN3VZ?=
 =?utf-8?B?SkJVNUpGSHJOMnpBSkVVeC9FdVhIOEpJejI2cDM3U2tVZmVIaERnMWNSd0Nj?=
 =?utf-8?B?SHR0L2xvZmgwL25Qc2dSOWN3cTRkT0FQamJoSUVrNlNULzJROEtPZG9aZEo3?=
 =?utf-8?B?Zmt2VlZheWR5d1ViOFFHdDMrSlUzZDE0NkNoNTJIcTNDVktuaWFpZUlXV1A1?=
 =?utf-8?B?UGZSWU5salcvbyt1N29IbDVwV2ZtMXVvbGoxNDBlYUFHR0VNa0JVYm9PRkZ5?=
 =?utf-8?B?UitCWldoWUE4cjhJSTB6UU5UNloxWnNxRHRieFZCL0NTWEtmL0ZPRTRWTjNq?=
 =?utf-8?B?QldLdkcvMiswUXVhcEpaS1cxQkZkUVJiVUhRc2RWZkROWnRMNXFZSVBEVXQ1?=
 =?utf-8?B?RXAzMkJ0TEdFSzA0cjd2WEdhT1BsT2NiNVJXVzNia2hqRHhvaVBENGFldm9Q?=
 =?utf-8?B?dXZHZXV2Nis4SytodFVyKytNWENPTWR4SkF6dXJYd1R6TXpSTE5mVWFxdVFh?=
 =?utf-8?B?em4wOGVGQW5ob1d2cGdFSGdyY1B4OTZsMEtGYnZ0N0RTMmtEQVZSb0wvRWFK?=
 =?utf-8?B?SXFGbHI5NnoyUU1kRXFwSXR6TVZVYm04ZUlkUVpVdDFoMURaaEp3ZU9UaGJu?=
 =?utf-8?B?Z1hjaVYzOHpZK0ZMZ3dlTEJWRG5JRi9KQmwyZGNDOUlFOGtjN1NBWUlBT0gv?=
 =?utf-8?B?VVFXQTVmVVArdzRYMGVrY04vekFmOFUzOWNSYVNJdC85THRIbnVreS82L1JE?=
 =?utf-8?B?cUlpY3pFSDVJaUV4b2JPK3NmMTBUbDkyTGRyVHNySzN0TTl4OERNUFNucE54?=
 =?utf-8?B?UG9Wc3dBVEZra3p1bXRsdzJodWhERlpnTlRXSWpGTnN6MHYxaFliMVphNnZH?=
 =?utf-8?B?Z3krUmNOcnM4NjFjdjZROE9iRWZsWUlzSEZVRlp0N0F6Y3dhZUxlcFZwUDBz?=
 =?utf-8?B?SnFwVytQaVJ1eEJvSFI5R09TcDJoM2U3VmU5a2NhOGpkdXY1akJraThRZm5O?=
 =?utf-8?B?ZjdvRjRIdklrUjZmTlFKVXRiZTJ1N0VrakdrMk4yU3NCc0RQb0MwbVl1T1Bv?=
 =?utf-8?B?aktFQzZTOFRsd1BZUmpyMUp6SFRYMExNSVQrRFEwMlRBSXYzYWE3dWlheEhN?=
 =?utf-8?B?c25IeThYejdIODkydHg1YXV0S3BZdGowZzROVHlrK0tYZUN6bHJqbEJnSFd3?=
 =?utf-8?B?bFcwMThvZFloQnRZMjFreUZrSjFBYTFkZlY2Zi95ZERTc2hrYjgzUnBMVGE4?=
 =?utf-8?B?OFVCUEN6Z0Y3K1hqVmNqUzBZczlXMVRmMVBScmNPa3o1VEQrUWpOMTAyZzM3?=
 =?utf-8?B?RXo5bGxlWk9jcHVTOUhaUTRaWVF5WHFUUWdEUG02RVhzRlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:13:21.0263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ae1ec2-2bf1-49c8-d81d-08dc864395a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444

Check the return value of amd_smn_read() before saving a value. This
ensures invalid values aren't saved. The struct umc instance is
initialized to 0 during memory allocation. Therefore, a bad read will
keep the value as 0 providing the expected Read-as-Zero behavior.

Furthermore, the __must_check attribute will be added to amd_smn_read().
Therefore, this change is required to avoid compile-time warnings.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
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


