Return-Path: <linux-edac+bounces-1245-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E8A900D8D
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 23:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCC6285B08
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 21:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B627F1553AA;
	Fri,  7 Jun 2024 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BwWNUAVI"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDC915533D;
	Fri,  7 Jun 2024 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796014; cv=fail; b=OJA2blukxph9EhH0le5/fXYNioQU4+PY/3VwY02koahHHYaVSCK+5U+5JgaBo3RnZaLV0fLzHIgdHYf7FBBjBTOMe4NdBSXiPSVZzp0rf053LJ71kwI2lVfGot88X11OTHAv2LWwh344u01A7jtAAEOroq/E/90lbJ0qC/K77tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796014; c=relaxed/simple;
	bh=jJ5n/fO3556orv+UOkKA7Vs/IRHy6RfGSTM95uDE4BY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YzrcST8YE9/3QiGMZSAojQCNItMuLf7oj54zOtCQwbjYYwVv/Zi2JxmXQdBinJ+VdaeT/O+5CMj1qqDF3wRes6Rw+EFspv0hCuENp7degjxQMN1iJxiF8LJ8/LPj7yCxgodVjGkoanRAdcvWZei3CxldpjcxkY4ZRVTBD7VkonY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BwWNUAVI; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PILmcEbbkzoXvNRA3lovAFevgt6hcMKkUd5//NqfJIa5G4/fgtwe5s6bGlX9SEcwaVtEG4ti81YlWrqe/CXGie7vsfd+J6BU440T2e/V/q0R4B/d61u9Q3ObZoTDp70Z4Qlw/sjd4o0eKpYFLdhYprCigzdJGOsg33rfCC0wVFME8x8ZgEhgMQ90JJt9sMIkMcXTjOzkpDUZviv68anNBgciYJeXqwpfyZ0UXKKBur/dsmBlGJ4ssM5iSLo/z8m+mz6ySZ2A2U4TgMXbS+eF3RBIm2CwtG9KL/IlV9K6x2UqcdSLcvVq+uE3p1jzinRItTHqdpXqBi46xwpF1ZLCdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPHHa4qck4zaTk8T8ZV2hIpf2TcND5ON+WySfmf9aRk=;
 b=UnBz0on9JXoJTArkcXx9NQIxy3kQb819toUWDD6pGcYB+CeUA3m+mMSKZBra6PNiMXMzWPYLSXpX+gR+0NcA9t8O2kmklv0VrECpmiRSi1kbnN/fGfBjIwg89ZWuhWVTVduek3CckR/XGowxtNBxZFFpkMZpz6K39ICboBbO9MwXxX5tyYXq2FxIOQLXLgOUI2ct9zGkhiBA9hk3LEsasSMCz/0zU7v3+MdxefqmcoipssP2jfTVYdelv50T6o49JT8ZQFf2wc+uB2jHebmrxls6uk4fWdfCp8na1UcSu86RrNoFKvWGq7aanBRvdF4sdlM6xZ560ZOho+PxNMJ9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPHHa4qck4zaTk8T8ZV2hIpf2TcND5ON+WySfmf9aRk=;
 b=BwWNUAVIjbKpnHWglNWCaUwYMxbjZbQ5s9i3MslI1WhPwkK9FOtjU7DKyPlTo4W987xmaLpqVjJbkJ5n/X2bm4ftitcKC3S1YSvkcl5Hqa9dRcFiXqIGl+UV5dCrT4ZqHf8rvk0Be+Wqk9s/Fh3CeRm7mqsi8neQJv0Y0oR4p+g=
Received: from PH0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::6) by
 PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 21:33:27 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::73) by PH0P220CA0001.outlook.office365.com
 (2603:10b6:510:d3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 21:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 21:33:27 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 16:33:24 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Fri, 7 Jun 2024 16:33:00 -0500
Subject: [PATCH 2/2] RAS/AMD/ATL: Use system settings for MI300 DRAM to
 normalized address translation
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-mi300-dram-xl-fix-v1-2-2f11547a178c@amd.com>
References: <20240607-mi300-dram-xl-fix-v1-0-2f11547a178c@amd.com>
In-Reply-To: <20240607-mi300-dram-xl-fix-v1-0-2f11547a178c@amd.com>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Muralidhara M K <muralidhara.mk@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: a11cd2f3-0572-4a74-d9ad-08dc873977fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEUxdExDNzd2TnlhckRFRWZLRm5nU2xDR3Y2RXhaSjZZTmN1M3JBTUk3dkor?=
 =?utf-8?B?L1R1UWttUWFNSmhQSmsrTlNzVmd3ZE1nRCtCSTNwaEhXSWl4STByRHpHaCty?=
 =?utf-8?B?ODBkYmpPbzNSakxhTjdXUXU1Zk9oTVNxeGN5cUplLzVoMG5wbThDSWFFWGpv?=
 =?utf-8?B?TjlqVDFaNDk5eURUTGVGVFAxU2tNcUZMUTF2b3YyTzY0b1hwWlVtcU5KYTBq?=
 =?utf-8?B?dUpnZlI1bUlCN09JOXFWVGw4SytYS3pzelh6aXFPWC9JTVBMMWl4RGN6ZmJh?=
 =?utf-8?B?MnVYN2xud21yVUtJUDFvdzFId1E5a2gyY2o1ZjFvaktqRGdPRG0ySjZMV2lL?=
 =?utf-8?B?eGY0Q296NTJQMllNT1NWWE1tOU4vemM4a2Y4SDVKNVNqN01wNWxGYmlnd3lj?=
 =?utf-8?B?ZFBtc2JBWUVSYXZndGNoK1A4VzJNaVhiSzBtRXFZcVlLTFc2N2R6bzV4cFk3?=
 =?utf-8?B?TGJsRlVMTHpxeXV2RnBlMHFaZ1o5Z0RnWklHNzd3ZUU0MWpkaUdCK3Z2RWRG?=
 =?utf-8?B?L1FJR3RUWlFjY2Uya3FFTWcxR05rSmFTVm83bkVrczg0K282NVZWOUhRY2RT?=
 =?utf-8?B?T3FTQkF4eVRzZStCK2pOMERSYnpCSS9iR25FbGNIcXl2RzFvY21iT1Y3Zldq?=
 =?utf-8?B?aTZoVXhCYTl0RzJUR0NMb09IRld0OHJpd2lhOTFoTjZya1U2aUZZVml2SWNz?=
 =?utf-8?B?VFhEWExkWEpLRmh1Y3hKNW8wZWkzdkhnbm5nRGFTaEhkcEQ5OTJNUzJyRzJp?=
 =?utf-8?B?Sk1VVDdZVDQyNmQ2ZXJERHdtYlVFd1FTV3h0c2xCaUwzMXpvb2dTNC8zYVpB?=
 =?utf-8?B?akJFdWJzK01uUHdaa1d6aitxUFhXVDZWZUpnTU5JMFlXSW9WNWMxTCtyUUIw?=
 =?utf-8?B?bWtPOGNXdnVMa1NXa20wdFNac0xzY2hIVkhLS3JXbEZ1ZWtwK3Y5bVduYzJC?=
 =?utf-8?B?VHNuVVF5NTJiTzl3b1VkdGhoTWozYzk0UW14TTNpM2lNMFpZOGJ6RENZTDhU?=
 =?utf-8?B?U3MrYTY5MHU2UmxFY1VrS2t4aHp4YmYwYU5HNFhtYkFkVnhtTExVWHBKMUc1?=
 =?utf-8?B?VVVqek1YeFJqVVFaY0EvWlVxZ1dlc2xoa1NmSlVTc0FobkQvaHl5YnVGRlQ1?=
 =?utf-8?B?a0hlK1hmUi92WWt4RmwzWXNEZm8xeEp4ZVJ1cDNla1J0QzdLV200ajdDUmRv?=
 =?utf-8?B?bjA4QllHVXh3THZUbUhYa1pXUmE0QWkrWFRCRTdwOTRuak5aT3NEK0FkS2pt?=
 =?utf-8?B?d2p5QmtyY1dvc0doVkY3Y1RRY3BKTTI2eG1lZkFJQ05QcGhQdHd1SFBuM3FU?=
 =?utf-8?B?M2lwVGdDRmNDaW83cFZMTnlrR3BQZHdkQ0FkTklxdHFaa0RKcG1ZemNJRkc1?=
 =?utf-8?B?aUpRaVo2bWhnRk83dU1aZlFuN1FIcUIyYlhpNThoU1lWZm5xdTBIZjBxR0RR?=
 =?utf-8?B?TG1EZkhTNUV0R0UwMTBDbXlhM1Y1Q2FZWHFUNURwT2MzaDNDZm1jZmtjcDdE?=
 =?utf-8?B?N3dtZnNQK2RSbUNhT3Z3aDd2THFCR0FRMmpqUktlN1ZoR1BkNXI4enNaQndF?=
 =?utf-8?B?NzVoQ3FvbHBZbE0rMGxIZGxUajRMMEhxSWNKT0pRamVXSmxTcG1IRW9Mb0Jw?=
 =?utf-8?B?RHFaL0ZWOVl4VnU4clIxMG9PWU1OR3Qvd2luaVExcDZLaEhGeHY5dmFBTXlQ?=
 =?utf-8?B?bGtiRVRsZklRdFM5MjBkdFpuaGFGcnhES1Z5SUo0OU9pVnhLbVZ6UndQdEZB?=
 =?utf-8?B?S01tOWJQZGp5TFFDWGVrMWw0NXloNUZaWkdXZC8valNrOEVzeFZ3dEFYM1JG?=
 =?utf-8?B?SmRpY2ZpcU1qVDluTkFDQXd0cWpnYUZJNThMdkRjcXU2MU40L0JOd3pKK3Nj?=
 =?utf-8?B?ZCt4eGQyZkQ1ZlRDekpRRDg4Z2lnRi9mSzNqN0JSTTVQR0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 21:33:27.3994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a11cd2f3-0572-4a74-d9ad-08dc873977fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561

The currently used normalized address format is not applicable to all
MI300 systems. This leads to incorrect results during address
translation.

Drop the fixed layout and construct the normalized address from system
settings.

Fixes: 87a612375307 ("RAS/AMD/ATL: Add MI300 DRAM to normalized address translation support")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/amd/atl/internal.h |   2 +-
 drivers/ras/amd/atl/system.c   |   2 +-
 drivers/ras/amd/atl/umc.c      | 151 ++++++++++++++++++++++++++++++-----------
 3 files changed, 114 insertions(+), 41 deletions(-)

diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 5de69e0bb0f9..196c1c8b578c 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -224,7 +224,7 @@ int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo);
 
 int get_df_system_info(void);
 int determine_node_id(struct addr_ctx *ctx, u8 socket_num, u8 die_num);
-int get_addr_hash_mi300(void);
+int get_umc_info_mi300(void);
 
 int get_address_map(struct addr_ctx *ctx);
 
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index 701349e84942..6979fa3d4fe2 100644
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -127,7 +127,7 @@ static int df4_determine_df_rev(u32 reg)
 	if (reg == DF_FUNC0_ID_MI300) {
 		df_cfg.flags.heterogeneous = 1;
 
-		if (get_addr_hash_mi300())
+		if (get_umc_info_mi300())
 			return -EINVAL;
 	}
 
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 5cb92330dc67..a1b4accf7b96 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -68,6 +68,8 @@ struct xor_bits {
 };
 
 #define NUM_BANK_BITS	4
+#define NUM_COL_BITS	5
+#define NUM_SID_BITS	2
 
 static struct {
 	/* UMC::CH::AddrHashBank */
@@ -80,7 +82,22 @@ static struct {
 	u8		bank_xor;
 } addr_hash;
 
+static struct {
+	u8 bank[NUM_BANK_BITS];
+	u8 col[NUM_COL_BITS];
+	u8 sid[NUM_SID_BITS];
+	u8 num_row_lo;
+	u8 num_row_hi;
+	u8 row_lo;
+	u8 row_hi;
+	u8 pc;
+} bit_shifts;
+
 #define MI300_UMC_CH_BASE	0x90000
+#define MI300_ADDR_CFG		(MI300_UMC_CH_BASE + 0x30)
+#define MI300_ADDR_SEL		(MI300_UMC_CH_BASE + 0x40)
+#define MI300_COL_SEL_LO	(MI300_UMC_CH_BASE + 0x50)
+#define MI300_ADDR_SEL_2	(MI300_UMC_CH_BASE + 0xA4)
 #define MI300_ADDR_HASH_BANK0	(MI300_UMC_CH_BASE + 0xC8)
 #define MI300_ADDR_HASH_PC	(MI300_UMC_CH_BASE + 0xE0)
 #define MI300_ADDR_HASH_PC2	(MI300_UMC_CH_BASE + 0xE4)
@@ -90,17 +107,42 @@ static struct {
 #define ADDR_HASH_ROW_XOR	GENMASK(31, 14)
 #define ADDR_HASH_BANK_XOR	GENMASK(5, 0)
 
+#define ADDR_CFG_NUM_ROW_LO	GENMASK(11, 8)
+#define ADDR_CFG_NUM_ROW_HI	GENMASK(15, 12)
+
+#define ADDR_SEL_BANK0		GENMASK(3, 0)
+#define ADDR_SEL_BANK1		GENMASK(7, 4)
+#define ADDR_SEL_BANK2		GENMASK(11, 8)
+#define ADDR_SEL_BANK3		GENMASK(15, 12)
+#define ADDR_SEL_BANK4		GENMASK(20, 16)
+#define ADDR_SEL_ROW_LO		GENMASK(27, 24)
+#define ADDR_SEL_ROW_HI		GENMASK(31, 28)
+
+#define COL_SEL_LO_COL0		GENMASK(3, 0)
+#define COL_SEL_LO_COL1		GENMASK(7, 4)
+#define COL_SEL_LO_COL2		GENMASK(11, 8)
+#define COL_SEL_LO_COL3		GENMASK(15, 12)
+#define COL_SEL_LO_COL4		GENMASK(19, 16)
+
+#define ADDR_SEL_2_BANK5	GENMASK(4, 0)
+#define ADDR_SEL_2_CHAN		GENMASK(15, 12)
+
 /*
  * Read UMC::CH::AddrHash{Bank,PC,PC2} registers to get XOR bits used
- * for hashing. Do this during module init, since the values will not
- * change during run time.
+ * for hashing.
+ *
+ * Also, read UMC::CH::Addr{Cfg,Sel,Sel2} and UMC::CH:ColSelLo registers to
+ * get the values needed to reconstruct the normalized address. Apply additional
+ * offsets to the raw register values, as needed.
+ *
+ * Do this during module init, since the values will not change during run time.
  *
  * These registers are instantiated for each UMC across each AMD Node.
  * However, they should be identically programmed due to the fixed hardware
  * design of MI300 systems. So read the values from Node 0 UMC 0 and keep a
  * single global structure for simplicity.
  */
-int get_addr_hash_mi300(void)
+int get_umc_info_mi300(void)
 {
 	u32 temp;
 	int ret;
@@ -130,6 +172,44 @@ int get_addr_hash_mi300(void)
 
 	addr_hash.bank_xor = FIELD_GET(ADDR_HASH_BANK_XOR, temp);
 
+	ret = amd_smn_read(0, MI300_ADDR_CFG, &temp);
+	if (ret)
+		return ret;
+
+	bit_shifts.num_row_hi = FIELD_GET(ADDR_CFG_NUM_ROW_HI, temp);
+	bit_shifts.num_row_lo = 10 + FIELD_GET(ADDR_CFG_NUM_ROW_LO, temp);
+
+	ret = amd_smn_read(0, MI300_ADDR_SEL, &temp);
+	if (ret)
+		return ret;
+
+	bit_shifts.bank[0] = 5 + FIELD_GET(ADDR_SEL_BANK0, temp);
+	bit_shifts.bank[1] = 5 + FIELD_GET(ADDR_SEL_BANK1, temp);
+	bit_shifts.bank[2] = 5 + FIELD_GET(ADDR_SEL_BANK2, temp);
+	bit_shifts.bank[3] = 5 + FIELD_GET(ADDR_SEL_BANK3, temp);
+	/* Use BankBit4 for the SID0 position. */
+	bit_shifts.sid[0]  = 5 + FIELD_GET(ADDR_SEL_BANK4, temp);
+	bit_shifts.row_lo  = 12 + FIELD_GET(ADDR_SEL_ROW_LO, temp);
+	bit_shifts.row_hi  = 24 + FIELD_GET(ADDR_SEL_ROW_HI, temp);
+
+	ret = amd_smn_read(0, MI300_COL_SEL_LO, &temp);
+	if (ret)
+		return ret;
+
+	bit_shifts.col[0] = 2 + FIELD_GET(COL_SEL_LO_COL0, temp);
+	bit_shifts.col[1] = 2 + FIELD_GET(COL_SEL_LO_COL1, temp);
+	bit_shifts.col[2] = 2 + FIELD_GET(COL_SEL_LO_COL2, temp);
+	bit_shifts.col[3] = 2 + FIELD_GET(COL_SEL_LO_COL3, temp);
+	bit_shifts.col[4] = 2 + FIELD_GET(COL_SEL_LO_COL4, temp);
+
+	ret = amd_smn_read(0, MI300_ADDR_SEL_2, &temp);
+	if (ret)
+		return ret;
+
+	/* Use BankBit5 for the SID1 position. */
+	bit_shifts.sid[1] = 5 + FIELD_GET(ADDR_SEL_2_BANK5, temp);
+	bit_shifts.pc	  = 5 + FIELD_GET(ADDR_SEL_2_CHAN, temp);
+
 	return 0;
 }
 
@@ -146,9 +226,6 @@ int get_addr_hash_mi300(void)
  * The MCA address format is as follows:
  *	MCA_ADDR[27:0] = {S[1:0], P[0], R[14:0], B[3:0], C[4:0], Z[0]}
  *
- * The normalized address format is fixed in hardware and is as follows:
- *	NA[30:0] = {S[1:0], R[13:0], C4, B[1:0], B[3:2], C[3:2], P, C[1:0], Z[4:0]}
- *
  * Additionally, the PC and Bank bits may be hashed. This must be accounted for before
  * reconstructing the normalized address.
  */
@@ -158,18 +235,10 @@ int get_addr_hash_mi300(void)
 #define MI300_UMC_MCA_PC	BIT(25)
 #define MI300_UMC_MCA_SID	GENMASK(27, 26)
 
-#define MI300_NA_COL_1_0	GENMASK(6, 5)
-#define MI300_NA_PC		BIT(7)
-#define MI300_NA_COL_3_2	GENMASK(9, 8)
-#define MI300_NA_BANK_3_2	GENMASK(11, 10)
-#define MI300_NA_BANK_1_0	GENMASK(13, 12)
-#define MI300_NA_COL_4		BIT(14)
-#define MI300_NA_ROW		GENMASK(28, 15)
-#define MI300_NA_SID		GENMASK(30, 29)
-
 static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
 {
-	u16 i, col, row, bank, pc, sid, temp;
+	u16 i, col, row, bank, pc, sid;
+	u32 temp;
 
 	col  = FIELD_GET(MI300_UMC_MCA_COL,  addr);
 	bank = FIELD_GET(MI300_UMC_MCA_BANK, addr);
@@ -199,34 +268,38 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
 	/* Reconstruct the normalized address starting with NA[4:0] = 0 */
 	addr  = 0;
 
-	/* NA[6:5] = Column[1:0] */
-	temp  = col & 0x3;
-	addr |= FIELD_PREP(MI300_NA_COL_1_0, temp);
-
-	/* NA[7] = PC */
-	addr |= FIELD_PREP(MI300_NA_PC, pc);
-
-	/* NA[9:8] = Column[3:2] */
-	temp  = (col >> 2) & 0x3;
-	addr |= FIELD_PREP(MI300_NA_COL_3_2, temp);
+	/* Column bits */
+	for (i = 0; i < NUM_COL_BITS; i++) {
+		temp  = (col >> i) & 0x1;
+		addr |= temp << bit_shifts.col[i];
+	}
 
-	/* NA[11:10] = Bank[3:2] */
-	temp  = (bank >> 2) & 0x3;
-	addr |= FIELD_PREP(MI300_NA_BANK_3_2, temp);
+	/* Bank bits */
+	for (i = 0; i < NUM_BANK_BITS; i++) {
+		temp  = (bank >> i) & 0x1;
+		addr |= temp << bit_shifts.bank[i];
+	}
 
-	/* NA[13:12] = Bank[1:0] */
-	temp  = bank & 0x3;
-	addr |= FIELD_PREP(MI300_NA_BANK_1_0, temp);
+	/* Row lo bits */
+	for (i = 0; i < bit_shifts.num_row_lo; i++) {
+		temp  = (row >> i) & 0x1;
+		addr |= temp << (i + bit_shifts.row_lo);
+	}
 
-	/* NA[14] = Column[4] */
-	temp  = (col >> 4) & 0x1;
-	addr |= FIELD_PREP(MI300_NA_COL_4, temp);
+	/* Row hi bits */
+	for (i = 0; i < bit_shifts.num_row_hi; i++) {
+		temp  = (row >> (i + bit_shifts.num_row_lo)) & 0x1;
+		addr |= temp << (i + bit_shifts.row_hi);
+	}
 
-	/* NA[28:15] = Row[13:0] */
-	addr |= FIELD_PREP(MI300_NA_ROW, row);
+	/* PC bit */
+	addr |= pc << bit_shifts.pc;
 
-	/* NA[30:29] = SID[1:0] */
-	addr |= FIELD_PREP(MI300_NA_SID, sid);
+	/* SID bits */
+	for (i = 0; i < NUM_SID_BITS; i++) {
+		temp  = (sid >> i) & 0x1;
+		addr |= temp << bit_shifts.sid[i];
+	}
 
 	pr_debug("Addr=0x%016lx", addr);
 	pr_debug("Bank=%u Row=%u Column=%u PC=%u SID=%u", bank, row, col, pc, sid);

-- 
2.34.1


