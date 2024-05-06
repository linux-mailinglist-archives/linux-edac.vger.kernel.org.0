Return-Path: <linux-edac+bounces-1006-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978F98BD1BB
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 17:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14C51C2231A
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F8F1553A7;
	Mon,  6 May 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ht0XZpMd"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6BB1552FE;
	Mon,  6 May 2024 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010396; cv=fail; b=oFTGppQ1LbOFPMJ6JGgyFrNVLzo5c/neglp6JK+NC23yoTQBT/VgRezUyqq2D+2Uy5ambncOe66yXWqc8IeX5xUi6SrBMo52qIna7Fe1TeoIlTH2FGe8MZw06hEnJ/d+mNXJN1hBpWgzAXUJRUxTs7ORkwBfNDb3HqOQyUOdUKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010396; c=relaxed/simple;
	bh=rSjiSaoO5348k2iMi2zJuCiy//Z7KyohmFE1R4X+iBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMYn2lUY7mUaWqA422ub2rNP3bJmy3PgLhLibsdtPkirWeJtJBdTM4Bt1NMDpJemS/MjOxqg3ILo7KVW8bBHwOyMqAugS6eqrYcKvPNF+HnvT11iWuoPkmq4hgeSepDvSdtOYEGeWnj1wewop7HhKyTjFhE7YwJdcjxg9/dr0s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ht0XZpMd; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9e9GDQ5y9Zn1e2mFLRtFOP8Jr8gN5gsBdCVsp6aWriFmts6OdUX1cHdyEjfWDooSs9O5GG0aB8YLpACG1Qkp1lLhC/eNqXpgCoxxRk3Jfd0YSR1Wk2TYlIKMouCG7Nlw9PPTD3xrwzzTNOURUH0k2ERwoxcfp56hVdkVIdqMeRWsCuptBsQzIorPyatzZxfJdoQQn6kZZGX4noXD01+toR8itREW6OWRgymHQH7pz09acwUFKVG/FkUAQKcYNlR/7PPDhrwedpqgqycr1ujSdo7RN+/kI4TQR0er2FRiT4Kj2UqOYvtXu2Ru0IPYbyg6c/f7mYTUg+fVOYsj+bzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSio4+7u7PvTuVNDKj7DOhF7tNY62EXlUR+GgraEFXU=;
 b=fyIqatGEY+pd8+TjVvN3XvO7vMPa53EWRUCbhZlXUKwdxOQxeKFMLUIpQpRHBiREiP+cIYGcDe5i1vmIxA9NQ6uDy6/J4zVeO74r/ArDm4Z1NhGp6tt3c22hYwYBsxLu4YV8s2HkquvyT1QL6YRchvnehsJjv6DYX0XaYrv0x4H943d/wk/kUfiIJRB6FaX5/7ZTTC6t3LLOWFr8IDwnW76MXQIKWi32v9sNQkopNbLSwxPw2lURRkUeXXM7s+XF3AzAPB9tb+rmNhdGEo65G7F1tqZg3qr100xmUIi0lAbcnf771ue9TQKdT3HDcmJXOdrKUQqqEbxS7sboc4Nazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSio4+7u7PvTuVNDKj7DOhF7tNY62EXlUR+GgraEFXU=;
 b=ht0XZpMdUoKi+kwoHXgTrSwE2YxPw6dF+WVOMdky4sZ3b0I0K/UFUQlRhWertYnENLhhJDUv5KLQJ0DZcHhm2ahX2ZLbx9SdekwTVbQCu3XaDF2y9MTlPIzpl66NJsw8d761QJ4cfCHViUQYjWK6nTUx5u6cAyVxIhRd06atSWE=
Received: from SA1P222CA0124.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::12)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 6 May
 2024 15:46:32 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::3b) by SA1P222CA0124.outlook.office365.com
 (2603:10b6:806:3c5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 15:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 15:46:30 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 10:46:29 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v4 2/4] RAS/AMD/ATL: Expand helpers for adding and removing base and hole
Date: Mon, 6 May 2024 15:46:03 +0000
Message-ID: <20240506154605.71814-3-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506154605.71814-1-john.allen@amd.com>
References: <20240506154605.71814-1-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SJ0PR12MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: b589187a-1838-4b7f-0ac8-08dc6de3b2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T0Q087sAOWqN+MbKu9B3AeMcuPQfF3m2ekMj56Ib+T6drWyvVMSItQzuRgbO?=
 =?us-ascii?Q?BY/u7EMcAhPsvgt8uGUQ7lPcZwYQ7THdRtyqfUchFFwhPezBNflHYNN/MgLM?=
 =?us-ascii?Q?4cF0F8oY4yaYgfqloydQKANcPgR+mL3XSHSIZwKmqFuRuY5Xw/Ru1fXeF1Rc?=
 =?us-ascii?Q?b8fu4N3KIgI9GBCudCnHOxWyEEa6udLbuayJurQ3zDqX3Hbz65odlZcvAUYg?=
 =?us-ascii?Q?KCwoEiwIsEbrFQZTRFj4g7JZJ45WcGVrNEEZX/dY+rsPinDlpyshTJ+ZS6KE?=
 =?us-ascii?Q?CIYrHD80QQWj6rMuaaWXBFkBx7NB5LCAN4tc5+wn15QNPYR4sOh/2+DqEuVU?=
 =?us-ascii?Q?seojJoC5OMtyzb8QMZDvhernzUpLTmPFjvE0jvMgm1ipU2vY2LPgKiloBl7x?=
 =?us-ascii?Q?ID7xFP/MhLG6AXQtZVYueOUn5vpJV0lFU1Ia9hZHDFyQbJ3/br6h/LrrqXAD?=
 =?us-ascii?Q?0RyuqpJkfrT0fuLQJrSXoV3XdVdModmK9vhCOpsfrTzTZay6/W1VI/T64M60?=
 =?us-ascii?Q?y4daFpDgeNt9kWW5VmDmUsVp1dTFV1G02xpMRTxvg2PpT7fLcj03iytk3/Cd?=
 =?us-ascii?Q?L/Ved9aDtlegblAqhXUU2lQTl5shWPgf/V/2NFRn+xYfdJheJWi+KrrYzxMF?=
 =?us-ascii?Q?tcX3vPzJRUoihuOtN0z0K6RKKlJkgFtVcR/HpvkzzfYMcg6IcqpchRRRONOc?=
 =?us-ascii?Q?Xmo4G1H3q65oZ/vw/A+jI5VDBQnvVHVfgD/ZF2C/R2wsZZiT10rE48SlzJKk?=
 =?us-ascii?Q?q99Goyj1J9vNesrVwTXZy8gIALKfwHoS40NgCKZYehPAbJ5vOHVh7q2cemcU?=
 =?us-ascii?Q?tMLdzASYwm0vqzwNx8tra+PqRuOjIUpdJRSk9gmjeUmCT1ehbdd1CMnnv3RR?=
 =?us-ascii?Q?at9r9h2cW/aLeKG0SgpY5/C+OpphTYGNIrSj/wznbPTg6ntS3ztwJht0nXib?=
 =?us-ascii?Q?PZsrl/EjZK1aYxGpzbBKtq763ZD7UT8UH8hRmHW885DhiMu6YsgbB8I1nzbH?=
 =?us-ascii?Q?Nqqo+K1ibA/yiJMUmuSgesp8IeZrktFoUvEqKsaBHBWyu5feAB+nnDANnryl?=
 =?us-ascii?Q?uRmY0VSENTMPSLk9pt3rXF6AP1IacgCivxzFMjiQsxCYjF2xehUWOibP06z4?=
 =?us-ascii?Q?FmEjV/GU1R651Eh5mOUfjECk4LlwFbwNVDLCpZ4WdIEpeeCVTxfNNxrugGLo?=
 =?us-ascii?Q?b5vl+5e0QfwZMErGT65WU8+kPHmsoWftZC111/JNS0fDnSoqdWlaB6dDbp6T?=
 =?us-ascii?Q?3txbJ/fo4k4beJrkNLhXM5eB443aGa5GWfVTFgaqEfdzgAko+aJwgd1lM/6B?=
 =?us-ascii?Q?FtM2lE+tbTWz9L+375Zhb/9wnSsVx8gzTzkORUA4mEHLuEM4N9+S9lJKBNdn?=
 =?us-ascii?Q?8RfnziJUQybtuXnuUYH9yNHIN36W?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 15:46:30.5541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b589187a-1838-4b7f-0ac8-08dc6de3b2e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901

The ret_addr field in struct addr_ctx contains the intermediate value of
the returned address as it passes through multiple steps in the
translation process. Currently, adding the DRAM base and legacy hole
is only done once, so it operates directly on the intermediate value.

However, for DF 4.5 non-power-of-2 denormalization, adding and removing
the DRAM base and legacy hole needs to be done for multiple temporary
address values. During this process, the intermediate value should not be
lost so the ret_addr value can't be reused.

Update the existing 'add' helper to operate on an arbitrary address
and introduce a new 'remove' helper to do the inverse operations.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - Make remove_base_and_hole the inverse of add_base_and_hole, removing
    the hole first and then removing the base.
  - Improve commit description.
v3:
  - Rewrite commit description.
  - Fix bug in remove_base_and_hole.
---
 drivers/ras/amd/atl/core.c     | 43 ++++++++++++++++++++++------------
 drivers/ras/amd/atl/internal.h |  3 +++
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 63513d972c07..c3a97ffd1a37 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -49,15 +49,26 @@ static bool legacy_hole_en(struct addr_ctx *ctx)
 	return FIELD_GET(DF_LEGACY_MMIO_HOLE_EN, reg);
 }
 
-static int add_legacy_hole(struct addr_ctx *ctx)
+static u64 add_legacy_hole(struct addr_ctx *ctx, u64 addr)
 {
 	if (!legacy_hole_en(ctx))
-		return 0;
+		return addr;
 
-	if (ctx->ret_addr >= df_cfg.dram_hole_base)
-		ctx->ret_addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
+	if (addr >= df_cfg.dram_hole_base)
+		addr += (BIT_ULL(32) - df_cfg.dram_hole_base);
 
-	return 0;
+	return addr;
+}
+
+static u64 remove_legacy_hole(struct addr_ctx *ctx, u64 addr)
+{
+	if (!legacy_hole_en(ctx))
+		return addr;
+
+	if (addr >= df_cfg.dram_hole_base)
+		addr -= (BIT_ULL(32) - df_cfg.dram_hole_base);
+
+	return addr;
 }
 
 static u64 get_base_addr(struct addr_ctx *ctx)
@@ -72,14 +83,16 @@ static u64 get_base_addr(struct addr_ctx *ctx)
 	return base_addr << DF_DRAM_BASE_LIMIT_LSB;
 }
 
-static int add_base_and_hole(struct addr_ctx *ctx)
+u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr)
 {
-	ctx->ret_addr += get_base_addr(ctx);
-
-	if (add_legacy_hole(ctx))
-		return -EINVAL;
+	addr += get_base_addr(ctx);
+	return add_legacy_hole(ctx, addr);
+}
 
-	return 0;
+u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr)
+{
+	addr = remove_legacy_hole(ctx, addr);
+	return addr - get_base_addr(ctx);
 }
 
 static bool late_hole_remove(struct addr_ctx *ctx)
@@ -123,14 +136,14 @@ unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsig
 	if (denormalize_address(&ctx))
 		return -EINVAL;
 
-	if (!late_hole_remove(&ctx) && add_base_and_hole(&ctx))
-		return -EINVAL;
+	if (!late_hole_remove(&ctx))
+		ctx.ret_addr = add_base_and_hole(&ctx, ctx.ret_addr);
 
 	if (dehash_address(&ctx))
 		return -EINVAL;
 
-	if (late_hole_remove(&ctx) && add_base_and_hole(&ctx))
-		return -EINVAL;
+	if (late_hole_remove(&ctx))
+		ctx.ret_addr = add_base_and_hole(&ctx, ctx.ret_addr);
 
 	if (addr_over_limit(&ctx))
 		return -EINVAL;
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 1413c8ddc6c5..05b870fcb24e 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -236,6 +236,9 @@ int dehash_address(struct addr_ctx *ctx);
 unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
 unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
 
+u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
+u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
+
 /*
  * Make a gap in @data that is @num_bits long starting at @bit_num.
  * e.g. data		= 11111111'b
-- 
2.34.1


