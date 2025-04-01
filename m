Return-Path: <linux-edac+bounces-3453-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E21A7839E
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 22:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2273C18927DC
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 20:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E021CA1E;
	Tue,  1 Apr 2025 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aTrTeqoy"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3021C9F9;
	Tue,  1 Apr 2025 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540574; cv=fail; b=YERsca0NnE/ny9GxRp5VrW5D0NTI4+N09G3ZR4sZk1529YrylzBpMvoOrlqSb59Onh3FoiWzg9aq1I61PxmwklXGS//IjZHBCbU/h8dbEoOtxrXDFr0U1JGCBZaEu/pwo9nDaUDVvVFj1eygFgxNtLs1HnF5DS0idghfD5w38EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540574; c=relaxed/simple;
	bh=AQJshUSDUEOCxsqZFhu+Xvh8XYfEsqvnjRbkyiO9C9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UXTwlNpKvENRS4kkJUd7JW+7vc6wVsioPa9ytJXI16zeYdFYjdK1vr37QyT98K8OCQVixYRMgRGjHP/P7LpOJ2jeTWFeZBWswtM7V5X20jFJPEB0Zw/xiv5Av1CW5fSykWxmLzQXsl6pvNzq1rPSI7rnIgK5hb8xOSmfjD1KInI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aTrTeqoy; arc=fail smtp.client-ip=40.107.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcoV0CyexuT0qgFgcDe3w4qK7D5Dr5+jb3Y8Hp/Z0MjyGGQlXxO80IsZ3Uf2iqgplyyYy6Xf49WlzpnjyuSPChUDwuw313FSmC58JMpQjCYSS1jTPi534iYnd9WFPmDe6IaQeQw1FVCQvtFMO5AXp5yg9x7jYhBSE0oQLovDGkPaC+ZlgFx22vta4ff2/cQHXiVl1lOj+REAyJ1MuWNZDg77g0NcMx9arD9Mmc3ovPBRD/4mKKGa+bSPOoHPUhgxZupL+41QYH1tUL/Vyy3C6Xm4mRmIxvq0+kKm5J8dxP1guGMEYnPHnwg7O8W4FsOJdE5PHXdn1rIYfOA8nfMsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdG78Jj4zdx94rtHhd7nUrerosFG/PYBT7cYfiQC3vI=;
 b=EZS6GZGF/1BQTeuaYZ46lzM1gzOeGPyrc+pXW/DQaCMRbWFNsTvOBpSSQQ2YTg9bvcvYtluA0SgIHBAoC4sTb0Yii83qNZXMXUu79JVDzcYUnl4gRAw7wOAeX/rJOxVx20LepzQ8zrXeAhyszjNZh7f7ZzfCQOJ2VQ9K/u3zJfxorGt0k3+hv5ODp16cdjYscGYYL716KK7YB2HZyVxscFxutBlOnGral3jbpN/wTA0vC/ZGIJoaBMGugeq161YwxH3xTCZ7ZjdPSFyXJABXKutyF5rDRwV2746+djwNGa+LOl3ES3gRN+aSLD5ZdjN6EOAMZJr2TxiJ/1Y74f0SwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdG78Jj4zdx94rtHhd7nUrerosFG/PYBT7cYfiQC3vI=;
 b=aTrTeqoyzhBTJ2+93rPCDGVw+bt0/E9sGsNoA5Q6Z/IhJ6qc/DfNer0aBoHFeFWtLDhqObXEQ//dd1O7MdYuwYcCjrhh+u0716qchmuG0e7nmU9BNVruvhJCW38614NcAaGbpbWs/i7zP64TsWdXlSY+SZppEEMw1XNhLCvvzZU=
Received: from SN7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::30)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Tue, 1 Apr
 2025 20:49:26 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::f) by SN7P222CA0027.outlook.office365.com
 (2603:10b6:806:124::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.39 via Frontend Transport; Tue,
 1 Apr 2025 20:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 20:49:25 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 15:49:22 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 1 Apr 2025 20:49:00 +0000
Subject: [PATCH 1/2] RAS/AMD/ATL: Include row[13] bit in row retirement
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250401-fix-fmpm-extra-records-v1-1-840bcf7a8ac5@amd.com>
References: <20250401-fix-fmpm-extra-records-v1-0-840bcf7a8ac5@amd.com>
In-Reply-To: <20250401-fix-fmpm-extra-records-v1-0-840bcf7a8ac5@amd.com>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>, Borislav Petkov <bp@alien8.de>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, Muralidhara M K
	<muralidhara.mk@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-419e3
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 4269a2e6-f8c0-4d29-533e-08dd715eb072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1U4clRMQnlLZ0U3aUF5UXhCYVk4SHVpTlpxK3hHcTc3amxTdFFWcWxyT1Z4?=
 =?utf-8?B?WTlySjN1YnA1NmpxVTJMODlqM1E3aVdWNWREbkx2L21MTzRVU3RydkdZdlJD?=
 =?utf-8?B?OHFGOHZGYWNWZW5WS2JRYnpndzF3UFVwNitFbWRJQXJEdlhiUG91dTVubnJn?=
 =?utf-8?B?YjhlcVpRK0xreTVxRjk5aExtQXpoQUVRaEZOdzg2b1VSSnRpTE95Mmw1YVJ6?=
 =?utf-8?B?RXdhZEpBRXR3L0V5eE5aRWlvSVY5Q1hIaExTRUtSVzBUNXlWWHdJbFAwNTdE?=
 =?utf-8?B?ZTJVQ2M2TllJUWtHWkExRHEyV2dNSCtGY1F2ZlRZb2I5MThWVmVRNmZCRTNE?=
 =?utf-8?B?MkZiY2VDbjk1ZExIOVRMRFk1RnVQdllFTUNQbWlScmtJbFRPMC8wRXA5NUlj?=
 =?utf-8?B?eXFqTm02NVl2SGlnSzJaaXBYaUIycUhsKzFlRUc0SnowR2ZiQk1Samc3UmdG?=
 =?utf-8?B?ZlZLQUtGNmtLejI4OGJjeGVsTGMrUEkxZ2xSVWlra3VNbk56b01jNkFYVmdi?=
 =?utf-8?B?djVtR3J4TEZCVVAzaE5wV2hrdDc4c1Nia2gvODB3ZEw5TEd5QWRqcUFpRlht?=
 =?utf-8?B?N3QvQ3FRUmhueVZYd1FlWDhZN2FGVXIvUzhoL3ZXMUVLcnQxWDl4bWdTUnJN?=
 =?utf-8?B?bDFjZkNiMmQwNFZORTRBUkRhTU56cm92Q1lQcXV5ZUV3eTZxSEZObnhUU0NK?=
 =?utf-8?B?cjdOYlRHWFJDVGlhTU1TczZEcVIva2FDREw0SkVkakx2Z09Kc0NjUFBVands?=
 =?utf-8?B?dUJDSVZ3ZjJaOWxpNEU1SFRWT09iVGVPTzZ0Z0F5Q2ZnSE14VmplcXdzeVp6?=
 =?utf-8?B?Wlc5R0ZrNS8vRTRnbDdkelFhdGJPL2JVWE1BS3lsUnI4SWhhSDNqcWcxODZy?=
 =?utf-8?B?cVFTQTlIbkIxdVZUSGROOXg0WUhHTjk0dEh3Z3k5WElkYWRqc21iODhsR3NK?=
 =?utf-8?B?VjBEVndSMVJEaVBLZHQxOTFFZ1RCa1E2OWwzQkVBOWltdjd5bll6WnZRRncr?=
 =?utf-8?B?Si83VHVpTnJWTWlWazB2RDZybmY5bUFnQ1BxUTVybEh0MGlsVm5nNkV1MEJM?=
 =?utf-8?B?cG0ycDdqRVFyb05LK3BtQ3pha29Yd3ZELzVJVUR0VDdiTXhicFNJeTlEVXZi?=
 =?utf-8?B?MXdJSnF2RHRtSzI4eUxCOU5JYmE2ZmNmMjFlWTc3REpEYWVzKytCMXVPNzlW?=
 =?utf-8?B?bVVFZ1VveTRaK3RXL2l4RlE1SHhYb0RMTi9RSVNtOHgwek81VGYwL1AwZGpn?=
 =?utf-8?B?QkltVjVEL0cvNjVxRTliMVAyT0xvTXBUWXpCbG5OZWU3WVA4dHZObXdsQ3JG?=
 =?utf-8?B?UlBCWTliYVhRUFZWYnRISjNuSXJrbGJWMDN6bFVBM3lPTlBuYXFsbWhhVnRJ?=
 =?utf-8?B?UTlOWFpxSVREL2FOZXRyNGlRU29WVzI5RVVuVHpvZDY3dWlVcU5xL1hldEhi?=
 =?utf-8?B?ZUs4TEttSW9tV2FtZkYyZ2puTXA1a2Z0cmpoditNMUV3ZFBETHE2N1ZBbGE5?=
 =?utf-8?B?VXFLdnUwOXFFNlhZeUI0a3dyc2o1eG5EWEJMSHZBSDljNWFSekIyc2cyY29r?=
 =?utf-8?B?Q1RYc245cmFiNklJeGxhMTVFaVVsQi84R0JQcXhBRFAwTlZSdFArWmh0U3BJ?=
 =?utf-8?B?c2RGVUVtclBWTnFqdXlsSzJLU1JhN21WUUgrdEQwVm5iWlp1aHRXVnpEOGd6?=
 =?utf-8?B?NFAzQ3VHbEZ0K2g0NEtycCsrQTdUdHpnZTJVYVp4UWp6WWt0T2l6VkFRanZH?=
 =?utf-8?B?ZFdwYzFob1ZrNVBPTWVQVVBlbldtMXhJZHJyWFQ5Y3M1Q0JIZUhFV2dxTlhu?=
 =?utf-8?B?MFE4VXo2bVBDYmFtdjl5LzZqRStyS0M0cnJMR0lodUtsS2hmM0RYM1huZU1y?=
 =?utf-8?B?TjFpSHB4TEJyeXcxamk1dUplVGthRFRsTzM0NU9TOHV5WXVsdkxpa01LdTV4?=
 =?utf-8?B?ajFXUXdLWnBtV0RjVEZOV2M4b1RWWEM0eVlGZzJpa1VKK0c2S3JVT21HeXFn?=
 =?utf-8?B?VFFrRUtoZFhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 20:49:25.7000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4269a2e6-f8c0-4d29-533e-08dd715eb072
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012

Based on feedback from hardware folks, row[13] is part of the variable
bits within a physical row (along with all column bits).

Only half the physical addresses affected by a row are calculated if
this bit is not included.

Add the row[13] bit to the row retirement flow.

Fixes: 3b566b30b414 ("RAS/AMD/ATL: Add MI300 row retirement support")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/ras/amd/atl/umc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index dc8aa12f63c8..cb8ace3d4e42 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -320,7 +320,7 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
  * See amd_atl::convert_dram_to_norm_addr_mi300() for MI300 address formats.
  */
 #define MI300_NUM_COL		BIT(HWEIGHT(MI300_UMC_MCA_COL))
-static void retire_row_mi300(struct atl_err *a_err)
+static void _retire_row_mi300(struct atl_err *a_err)
 {
 	unsigned long addr;
 	struct page *p;
@@ -351,6 +351,23 @@ static void retire_row_mi300(struct atl_err *a_err)
 	}
 }
 
+/*
+ * In addition to the column bits, the row[13] bit should also be included when
+ * calculating addresses affected by a physical row.
+ *
+ * Instead of running through another loop over a single bit, just run through
+ * the column bits twice and flip the row[13] bit in-between.
+ *
+ * See MI300_UMC_MCA_ROW for the row bits in MCA_ADDR_UMC value.
+ */
+#define MI300_UMC_MCA_ROW13	BIT(23)
+static void retire_row_mi300(struct atl_err *a_err)
+{
+	_retire_row_mi300(a_err);
+	a_err->addr ^= MI300_UMC_MCA_ROW13;
+	_retire_row_mi300(a_err);
+}
+
 void amd_retire_dram_row(struct atl_err *a_err)
 {
 	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)

-- 
2.49.0


