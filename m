Return-Path: <linux-edac+bounces-1232-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D00788FF5F7
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 22:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDBF1F245B9
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 20:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D689419AD8A;
	Thu,  6 Jun 2024 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gPbloCdn"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759AF19AD73;
	Thu,  6 Jun 2024 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706044; cv=fail; b=HmfPjIBujiVQy/iKNhK6QM8k+7tivGzYxkbXf4jUYwNFiRS49vyzU2avAxhosq/b3auDunblO3vs60VvifHkChDBxS6j5ohvJmDrV5xL4lcCjjwJH8Cu5NhEZlhWohxJ/AxDv1OLf7GPVJ80l1BuOR57Qg1hEmC2ahPF6RfFGJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706044; c=relaxed/simple;
	bh=etPo4WY4xIizRy6iDb7hu3jArsvG1MUTR3NG8yNtQtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJQMfPaOMQz/Ii2YikQpuxSxoY6t/EhblnlxoChanAMROG47Z1qvYRw/wKUU0uptJIK900QpgG7nRgcHKWfm0dXRIKmvNc41W0ON94hsFiepTg3vycMsd8eUpCQLgZddpNBJHVYDLDJcJXt1JUbLmU/YWUqBSsJeqGv+6SyagcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gPbloCdn; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgMF8QuVx5Kh/d7utMn9ptuByyd7n+oI//XJDUvsYtgQmIhQNBqTZnPwx6Sh/xceiXWBHBW2ef0cC+VSYN7+t1Ger1R5NNaYtbzBi3QhSh6LFsLZVlUJeNth/uxUUhud4KgCqHzfYfyfehdp8BfKds4p9uwmY35tJhxDLmIoJAJ86y7PF/m1NxnFFnNTu/Iu3p9m6yMkuaVcmKyD5XWljoOkfaYL9mHvlPrbLIEgpW3RKDFyMsSj95FHdPrSUCRd7BE5hkfNFHGPGiDOu6ShY71kGvuo5S5abKwabtwDXl0+QbIVTqhHY5EmCh5tfArOF3/fVF/uLhfd9vZXfDHFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPzJInAFhjs24o713G5/alYclQCy7leVKqTDfEiX5iM=;
 b=XMAkNWAVBBK6GKPfGeRuDMdgCzfOt7hiFSCt0/A9EcLAn9Gh6OKLTPhNo758z/+oh5xBDlPH7auZUqmfXc8XE8aKyt+O8Qfp9n7c7TI5+2tvn9203G6xv03p3+TSHoVZEIeGoBwjDblFnTBJVuINDYy05BVPzvqJnRmR9jTXRztY9p/5LSR/3oS0WXsuV5b0ts4WlKEvkHSVnN0g1E3PasxFdV9UO29BXeIL6HStWJnmHWfSoWlbEPr1AtBWpKGDywQ7Oedf1y2dY4pDnFC5fFDlIs2+y3AJp1pUDPMVsvQ9o9+HMl3UgugU3vY5ms4eFDPhJk0YlcCHmROcHbxXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPzJInAFhjs24o713G5/alYclQCy7leVKqTDfEiX5iM=;
 b=gPbloCdnTaf8TeM3RsvAVg17FW39PfVSM5PEJq1wGEYPFYTku6cPvmJ92i9AVoJ4TN4ceknkjPA3Sphl02bxBkHnit/bukwC+igZVW6JpNjwNRizmQ1mBo2ciuOmdUFrxK59HZmPd2KvN87ZdCZUWyUIWc0gD+SnfKa7r4mYL4c=
Received: from CH0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:610:76::35)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 20:33:58 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::5b) by CH0PR04CA0030.outlook.office365.com
 (2603:10b6:610:76::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 20:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 20:33:58 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 15:33:57 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v5 5/6] RAS/AMD/ATL: Implement DF 4.5 NP2 denormalization
Date: Thu, 6 Jun 2024 20:33:12 +0000
Message-ID: <20240606203313.51197-6-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606203313.51197-1-john.allen@amd.com>
References: <20240606203313.51197-1-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: edaa5a35-0a8a-4526-3208-08dc8667fe59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HkuYZskVr1zWXeyTax1eLglpprzaxUgOcOtU53nbjVbGj3vhjDb1Bv08dg0n?=
 =?us-ascii?Q?0y/E/Kz7CQMHB1f/ZcUBO1n0IOWq6J84BRkWQJOFNn/xiCFR3I6cgDThjzN0?=
 =?us-ascii?Q?x29DiuEuHRzH0WkyOc/wmL5asenjp+G+wBm5caq3pgbtCx3E24L5GRKRKSxB?=
 =?us-ascii?Q?Rc1Ywtl+mzEbnV+8kHHDlO+z/PUYFd6wfHTwdGUeb8jjTjR1vLF5Dhs+E4BN?=
 =?us-ascii?Q?ZsWneP0A0tNCHm0pidnOpWlYMg/1eLSNTdNKs49EDBGIU2JnpCnD+CfbIdZu?=
 =?us-ascii?Q?qx1fg5ECreClZLTgQCv3wH9aSeSWC00en+kElQEFILhLJ0m9XXJ6rOcb403a?=
 =?us-ascii?Q?WG1yTvDGjczgDZoADrmG0iFK1l24afP6wWTH9WBkurzM5pO8BZfRoG/ho4yC?=
 =?us-ascii?Q?WfbC2SKAahQN7WKfTZKmLDFviwBpHv/tb2+VWceThlpPk3llmWm6Hkjkic+W?=
 =?us-ascii?Q?MYL5zf4WYpbD9ICTNiv2WHyL6Ov24umxAaPH5AZuT5mwKEDn+I1DzXeZbEhJ?=
 =?us-ascii?Q?ydjc+MTsKoXQ7vMIcmWiCgONqReivZFKnhjHI+GUv9HDyfEgCqubajXmG0Sq?=
 =?us-ascii?Q?KdodHoR5N1sI04nW1sQkAIhMJH29QkumVP1NexpL1rC52sGXUAUzCHgFwtY5?=
 =?us-ascii?Q?uWZBMErWTTFEUo0n50h+QxyVkHN1JXalJCsnDLZq77+/3xXuO65Q+mGL9ILX?=
 =?us-ascii?Q?Pyjhsh87iIOR2/MupExZbLgm3/q62yFWV3FPKI2nwH0FHGasTwHXLpcbQ62N?=
 =?us-ascii?Q?2m/eCpZkwyJMoT9dvMZ4Xp+kanYomVl6VKbz3vPzPbRp/pImxo9hdIOMF37t?=
 =?us-ascii?Q?kMc/CeY8y3Jt+zOju6tgxvHmPVDDbCH3SbDjVAJ9W2xqtANgHIs1//8idvcx?=
 =?us-ascii?Q?WHgC+4Xl2nynrkB9TxwWCTk/c5IxMH2l1nHsGADuLuw/s9JLKKzjVK+lFyRJ?=
 =?us-ascii?Q?8vS5UF2R/11hbyuSrm2Qb0K0HolAusiXeNIFjG+rS3nJgkaf15QP8XEvw2y2?=
 =?us-ascii?Q?8PpEM/YbsC5RTPBlB/tgjcNeAVrU/sWVqwYeGMMf5B04Fpbx8shk0B+b2ZYs?=
 =?us-ascii?Q?zLQvyVgydw0/3gvtP/8j6GluiMqKdxxT5i0bGZV9JymoFWiT6D2Lc3cfiIhY?=
 =?us-ascii?Q?sRrN69p4sFYNz/4UbGNnimqGRpPKkqEFLMzklF5rCuiOmKE0yzO96slYIfqT?=
 =?us-ascii?Q?oYiepPffIoUsvK/Mm8csMEyHBXEBt3JlZ+vjEBsTRuCvJjo/ZC3VG6mZffxK?=
 =?us-ascii?Q?rOOCzIxc6aaUEk37oSDkgPHDC/Lr4oBwzCi3HJvPSpCerXm6+EqKekfyTStm?=
 =?us-ascii?Q?RcaXrFDfolXyfwlLHpS1LUgrTf81OjhIRDVnx9pPpcoz9JWjh6g40rYvP4f0?=
 =?us-ascii?Q?JQ1me0LddWfpKU2wQUFT8kj8DQCgWqGrDjQyOVDMSVGl+5XdgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:33:58.5998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edaa5a35-0a8a-4526-3208-08dc8667fe59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521

Unlike with previous Data Fabric versions, with Data Fabric 4.5
non-power-of-2 denormalization, there are bits of the system physical
address that can't be fully reconstructed from the normalized address.

To determine the proper combination of missing system physical address
bits, iterate through each possible combination of these bits, normalize
the resulting system physical address, and compare to the original
address that is being translated. If the addresses match, then the
correct permutation of bits has been found.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - Move map validation to patch 3/4.
v3:
  - Change return value of get_logical_coh_st_fabric_id_for_current_spa
    to u16.
  - Initialize variables where defined in normalize_addr_df4p5_np2.
  - check_logical_coh_st_fabric_id:
    - Rename to match_logical_coh_st_fabric_id.
    - Shorten local variable name.
    - Simplify return logic.
  - check_norm_addr:
    - Rename to match_norm_addr.
    - Shorten local variable name and reuse single variable for multiple
      uses.
    - Simplify return logic.
v5:
  - Add newlines after breaks in case statements.
  - Remove variable names from comments in df4p5_denorm_ctx.
---
 drivers/ras/amd/atl/denormalize.c | 561 ++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/internal.h    |  40 +++
 drivers/ras/amd/atl/map.c         |  20 ++
 3 files changed, 621 insertions(+)

diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
index e279224288d6..1a525cfa983c 100644
--- a/drivers/ras/amd/atl/denormalize.c
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -448,6 +448,118 @@ static u16 get_logical_coh_st_fabric_id(struct addr_ctx *ctx)
 	return (phys_fabric_id & df_cfg.node_id_mask) | log_fabric_id;
 }
 
+static u16 get_logical_coh_st_fabric_id_for_current_spa(struct addr_ctx *ctx,
+							struct df4p5_denorm_ctx *denorm_ctx)
+{
+	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G, hash_ctl_1T;
+	bool hash_pa8, hash_pa9, hash_pa12, hash_pa13;
+	u64 cs_id = 0;
+
+	hash_ctl_64k	= FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
+	hash_ctl_2M	= FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
+	hash_ctl_1G	= FIELD_GET(DF4_HASH_CTL_1G,   ctx->map.ctl);
+	hash_ctl_1T	= FIELD_GET(DF4p5_HASH_CTL_1T, ctx->map.ctl);
+
+	hash_pa8  = FIELD_GET(BIT_ULL(8),  denorm_ctx->current_spa);
+	hash_pa8 ^= FIELD_GET(BIT_ULL(14), denorm_ctx->current_spa);
+	hash_pa8 ^= FIELD_GET(BIT_ULL(16), denorm_ctx->current_spa) & hash_ctl_64k;
+	hash_pa8 ^= FIELD_GET(BIT_ULL(21), denorm_ctx->current_spa) & hash_ctl_2M;
+	hash_pa8 ^= FIELD_GET(BIT_ULL(30), denorm_ctx->current_spa) & hash_ctl_1G;
+	hash_pa8 ^= FIELD_GET(BIT_ULL(40), denorm_ctx->current_spa) & hash_ctl_1T;
+
+	hash_pa9  = FIELD_GET(BIT_ULL(9),  denorm_ctx->current_spa);
+	hash_pa9 ^= FIELD_GET(BIT_ULL(17), denorm_ctx->current_spa) & hash_ctl_64k;
+	hash_pa9 ^= FIELD_GET(BIT_ULL(22), denorm_ctx->current_spa) & hash_ctl_2M;
+	hash_pa9 ^= FIELD_GET(BIT_ULL(31), denorm_ctx->current_spa) & hash_ctl_1G;
+	hash_pa9 ^= FIELD_GET(BIT_ULL(41), denorm_ctx->current_spa) & hash_ctl_1T;
+
+	hash_pa12  = FIELD_GET(BIT_ULL(12), denorm_ctx->current_spa);
+	hash_pa12 ^= FIELD_GET(BIT_ULL(18), denorm_ctx->current_spa) & hash_ctl_64k;
+	hash_pa12 ^= FIELD_GET(BIT_ULL(23), denorm_ctx->current_spa) & hash_ctl_2M;
+	hash_pa12 ^= FIELD_GET(BIT_ULL(32), denorm_ctx->current_spa) & hash_ctl_1G;
+	hash_pa12 ^= FIELD_GET(BIT_ULL(42), denorm_ctx->current_spa) & hash_ctl_1T;
+
+	hash_pa13  = FIELD_GET(BIT_ULL(13), denorm_ctx->current_spa);
+	hash_pa13 ^= FIELD_GET(BIT_ULL(19), denorm_ctx->current_spa) & hash_ctl_64k;
+	hash_pa13 ^= FIELD_GET(BIT_ULL(24), denorm_ctx->current_spa) & hash_ctl_2M;
+	hash_pa13 ^= FIELD_GET(BIT_ULL(33), denorm_ctx->current_spa) & hash_ctl_1G;
+	hash_pa13 ^= FIELD_GET(BIT_ULL(43), denorm_ctx->current_spa) & hash_ctl_1T;
+
+	switch (ctx->map.intlv_mode) {
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 13), denorm_ctx->current_spa) << 3;
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 2;
+		cs_id |= (hash_pa9 | (hash_pa12 << 1));
+		cs_id |= hash_pa8 << df_cfg.socket_id_shift;
+		break;
+
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 14), denorm_ctx->current_spa) << 4;
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 2;
+		cs_id |= (hash_pa12 | (hash_pa13 << 1));
+		cs_id |= hash_pa8 << df_cfg.socket_id_shift;
+		break;
+
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 2;
+		cs_id |= (hash_pa8 | (hash_pa9 << 1));
+		break;
+
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 13), denorm_ctx->current_spa) << 3;
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 2;
+		cs_id |= (hash_pa8 | (hash_pa12 << 1));
+		break;
+
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id |= (FIELD_GET(BIT_ULL(9), denorm_ctx->current_spa) << 1);
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 1;
+		cs_id |= hash_pa8;
+		break;
+
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 1;
+		cs_id |= hash_pa8;
+		break;
+
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id |= FIELD_GET(GENMASK_ULL(9, 8), denorm_ctx->current_spa);
+		cs_id %= denorm_ctx->mod_value;
+		break;
+
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id |= FIELD_GET(BIT_ULL(8), denorm_ctx->current_spa) << 1;
+		cs_id %= denorm_ctx->mod_value;
+		break;
+
+	default:
+		atl_debug_on_bad_intlv_mode(ctx);
+		return 0;
+	}
+
+	if (cs_id > 0xffff) {
+		atl_debug(ctx, "Translation error: Resulting cs_id larger than u16\n");
+		return 0;
+	}
+
+	return cs_id;
+}
+
 static int denorm_addr_common(struct addr_ctx *ctx)
 {
 	u64 denorm_addr;
@@ -699,6 +811,442 @@ static int denorm_addr_df4_np2(struct addr_ctx *ctx)
 	return 0;
 }
 
+static u64 normalize_addr_df4p5_np2(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx,
+				    u64 addr)
+{
+	u64 temp_addr_a = 0, temp_addr_b = 0;
+
+	switch (ctx->map.intlv_mode) {
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+		temp_addr_a = FIELD_GET(GENMASK_ULL(11, 10), addr) << 8;
+		break;
+
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		temp_addr_a = FIELD_GET(GENMASK_ULL(11, 9), addr) << 8;
+		break;
+
+	default:
+		atl_debug_on_bad_intlv_mode(ctx);
+		return 0;
+	}
+
+	switch (ctx->map.intlv_mode) {
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 13), addr) / denorm_ctx->mod_value;
+		temp_addr_b <<= 10;
+		break;
+
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 14), addr) / denorm_ctx->mod_value;
+		temp_addr_b <<= 11;
+		break;
+
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) / denorm_ctx->mod_value;
+		temp_addr_b <<= 10;
+		break;
+
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 13), addr) / denorm_ctx->mod_value;
+		temp_addr_b <<= 11;
+		break;
+
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) << 1;
+		temp_addr_b |= FIELD_GET(BIT_ULL(9), addr);
+		temp_addr_b /= denorm_ctx->mod_value;
+		temp_addr_b <<= 10;
+		break;
+
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) / denorm_ctx->mod_value;
+		temp_addr_b <<= 11;
+		break;
+
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) << 2;
+		temp_addr_b |= FIELD_GET(GENMASK_ULL(9, 8), addr);
+		temp_addr_b /= denorm_ctx->mod_value;
+		temp_addr_b <<= 10;
+		break;
+
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) << 1;
+		temp_addr_b |= FIELD_GET(BIT_ULL(8), addr);
+		temp_addr_b /= denorm_ctx->mod_value;
+		temp_addr_b <<= 11;
+		break;
+
+	default:
+		atl_debug_on_bad_intlv_mode(ctx);
+		return 0;
+	}
+
+	return denorm_ctx->base_denorm_addr | temp_addr_a | temp_addr_b;
+}
+
+static void recalculate_hashed_bits_df4p5_np2(struct addr_ctx *ctx,
+					      struct df4p5_denorm_ctx *denorm_ctx)
+{
+	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G, hash_ctl_1T, hashed_bit;
+
+	if (!denorm_ctx->rehash_vector)
+		return;
+
+	hash_ctl_64k	= FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
+	hash_ctl_2M	= FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
+	hash_ctl_1G	= FIELD_GET(DF4_HASH_CTL_1G,   ctx->map.ctl);
+	hash_ctl_1T	= FIELD_GET(DF4p5_HASH_CTL_1T, ctx->map.ctl);
+
+	if (denorm_ctx->rehash_vector & BIT_ULL(8)) {
+		hashed_bit  = FIELD_GET(BIT_ULL(8),  denorm_ctx->current_spa);
+		hashed_bit ^= FIELD_GET(BIT_ULL(14), denorm_ctx->current_spa);
+		hashed_bit ^= FIELD_GET(BIT_ULL(16), denorm_ctx->current_spa) & hash_ctl_64k;
+		hashed_bit ^= FIELD_GET(BIT_ULL(21), denorm_ctx->current_spa) & hash_ctl_2M;
+		hashed_bit ^= FIELD_GET(BIT_ULL(30), denorm_ctx->current_spa) & hash_ctl_1G;
+		hashed_bit ^= FIELD_GET(BIT_ULL(40), denorm_ctx->current_spa) & hash_ctl_1T;
+
+		if (FIELD_GET(BIT_ULL(8), denorm_ctx->current_spa) != hashed_bit)
+			denorm_ctx->current_spa ^= BIT_ULL(8);
+	}
+
+	if (denorm_ctx->rehash_vector & BIT_ULL(9)) {
+		hashed_bit  = FIELD_GET(BIT_ULL(9),  denorm_ctx->current_spa);
+		hashed_bit ^= FIELD_GET(BIT_ULL(17), denorm_ctx->current_spa) & hash_ctl_64k;
+		hashed_bit ^= FIELD_GET(BIT_ULL(22), denorm_ctx->current_spa) & hash_ctl_2M;
+		hashed_bit ^= FIELD_GET(BIT_ULL(31), denorm_ctx->current_spa) & hash_ctl_1G;
+		hashed_bit ^= FIELD_GET(BIT_ULL(41), denorm_ctx->current_spa) & hash_ctl_1T;
+
+		if (FIELD_GET(BIT_ULL(9), denorm_ctx->current_spa) != hashed_bit)
+			denorm_ctx->current_spa ^= BIT_ULL(9);
+	}
+
+	if (denorm_ctx->rehash_vector & BIT_ULL(12)) {
+		hashed_bit  = FIELD_GET(BIT_ULL(12), denorm_ctx->current_spa);
+		hashed_bit ^= FIELD_GET(BIT_ULL(18), denorm_ctx->current_spa) & hash_ctl_64k;
+		hashed_bit ^= FIELD_GET(BIT_ULL(23), denorm_ctx->current_spa) & hash_ctl_2M;
+		hashed_bit ^= FIELD_GET(BIT_ULL(32), denorm_ctx->current_spa) & hash_ctl_1G;
+		hashed_bit ^= FIELD_GET(BIT_ULL(42), denorm_ctx->current_spa) & hash_ctl_1T;
+
+		if (FIELD_GET(BIT_ULL(12), denorm_ctx->current_spa) != hashed_bit)
+			denorm_ctx->current_spa ^= BIT_ULL(12);
+	}
+
+	if (denorm_ctx->rehash_vector & BIT_ULL(13)) {
+		hashed_bit  = FIELD_GET(BIT_ULL(13), denorm_ctx->current_spa);
+		hashed_bit ^= FIELD_GET(BIT_ULL(19), denorm_ctx->current_spa) & hash_ctl_64k;
+		hashed_bit ^= FIELD_GET(BIT_ULL(24), denorm_ctx->current_spa) & hash_ctl_2M;
+		hashed_bit ^= FIELD_GET(BIT_ULL(33), denorm_ctx->current_spa) & hash_ctl_1G;
+		hashed_bit ^= FIELD_GET(BIT_ULL(43), denorm_ctx->current_spa) & hash_ctl_1T;
+
+		if (FIELD_GET(BIT_ULL(13), denorm_ctx->current_spa) != hashed_bit)
+			denorm_ctx->current_spa ^= BIT_ULL(13);
+	}
+}
+
+static bool match_logical_coh_st_fabric_id(struct addr_ctx *ctx,
+					   struct df4p5_denorm_ctx *denorm_ctx)
+{
+	/*
+	 * The logical CS fabric ID of the permutation must be calculated from the
+	 * current SPA with the base and with the MMIO hole.
+	 */
+	u16 id = get_logical_coh_st_fabric_id_for_current_spa(ctx, denorm_ctx);
+
+	atl_debug(ctx, "Checking calculated logical coherent station fabric id:\n");
+	atl_debug(ctx, "  calculated fabric id         = 0x%x\n", id);
+	atl_debug(ctx, "  expected fabric id           = 0x%x\n", denorm_ctx->coh_st_fabric_id);
+
+	return denorm_ctx->coh_st_fabric_id == id;
+}
+
+static bool match_norm_addr(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx)
+{
+	u64 addr = remove_base_and_hole(ctx, denorm_ctx->current_spa);
+
+	/*
+	 * The normalized address must be calculated with the current SPA without
+	 * the base and without the MMIO hole.
+	 */
+	addr = normalize_addr_df4p5_np2(ctx, denorm_ctx, addr);
+
+	atl_debug(ctx, "Checking calculated normalized address:\n");
+	atl_debug(ctx, "  calculated normalized addr = 0x%016llx\n", addr);
+	atl_debug(ctx, "  expected normalized addr   = 0x%016llx\n", ctx->ret_addr);
+
+	return addr == ctx->ret_addr;
+}
+
+static int check_permutations(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx)
+{
+	u64 test_perm, temp_addr, denorm_addr, num_perms;
+	unsigned int dropped_remainder;
+
+	denorm_ctx->div_addr *= denorm_ctx->mod_value;
+
+	/*
+	 * The high order bits of num_permutations represent the permutations
+	 * of the dropped remainder. This will be either 0-3 or 0-5 depending
+	 * on the interleave mode. The low order bits represent the
+	 * permutations of other "lost" bits which will be any combination of
+	 * 1, 2, or 3 bits depending on the interleave mode.
+	 */
+	num_perms = denorm_ctx->mod_value << denorm_ctx->perm_shift;
+
+	for (test_perm = 0; test_perm < num_perms; test_perm++) {
+		denorm_addr = denorm_ctx->base_denorm_addr;
+		dropped_remainder = test_perm >> denorm_ctx->perm_shift;
+		temp_addr = denorm_ctx->div_addr + dropped_remainder;
+
+		switch (ctx->map.intlv_mode) {
+		case DF4p5_NPS0_24CHAN_2K_HASH:
+			denorm_addr |= temp_addr << 14;
+			break;
+
+		case DF4p5_NPS0_24CHAN_1K_HASH:
+		case DF4p5_NPS1_12CHAN_2K_HASH:
+			denorm_addr |= temp_addr << 13;
+			break;
+
+		case DF4p5_NPS1_12CHAN_1K_HASH:
+		case DF4p5_NPS2_6CHAN_2K_HASH:
+		case DF4p5_NPS1_10CHAN_2K_HASH:
+			denorm_addr |= temp_addr << 12;
+			break;
+
+		case DF4p5_NPS2_6CHAN_1K_HASH:
+		case DF4p5_NPS1_10CHAN_1K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), temp_addr) << 9;
+			denorm_addr |= FIELD_GET(GENMASK_ULL(63, 1), temp_addr) << 12;
+			break;
+
+		case DF4p5_NPS4_3CHAN_1K_HASH:
+		case DF4p5_NPS2_5CHAN_1K_HASH:
+			denorm_addr |= FIELD_GET(GENMASK_ULL(1, 0), temp_addr) << 8;
+			denorm_addr |= FIELD_GET(GENMASK_ULL(63, 2), (temp_addr)) << 12;
+			break;
+
+		case DF4p5_NPS4_3CHAN_2K_HASH:
+		case DF4p5_NPS2_5CHAN_2K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), temp_addr) << 8;
+			denorm_addr |= FIELD_GET(GENMASK_ULL(63, 1), temp_addr) << 12;
+			break;
+
+		default:
+			atl_debug_on_bad_intlv_mode(ctx);
+			return -EINVAL;
+		}
+
+		switch (ctx->map.intlv_mode) {
+		case DF4p5_NPS0_24CHAN_1K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
+			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 9;
+			denorm_addr |= FIELD_GET(BIT_ULL(2), test_perm) << 12;
+			break;
+
+		case DF4p5_NPS0_24CHAN_2K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
+			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 12;
+			denorm_addr |= FIELD_GET(BIT_ULL(2), test_perm) << 13;
+			break;
+
+		case DF4p5_NPS1_12CHAN_2K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
+			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 12;
+			break;
+
+		case DF4p5_NPS1_12CHAN_1K_HASH:
+		case DF4p5_NPS4_3CHAN_1K_HASH:
+		case DF4p5_NPS2_5CHAN_1K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
+			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 9;
+			break;
+
+		case DF4p5_NPS2_6CHAN_1K_HASH:
+		case DF4p5_NPS2_6CHAN_2K_HASH:
+		case DF4p5_NPS4_3CHAN_2K_HASH:
+		case DF4p5_NPS1_10CHAN_1K_HASH:
+		case DF4p5_NPS1_10CHAN_2K_HASH:
+		case DF4p5_NPS2_5CHAN_2K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
+			break;
+
+		default:
+			atl_debug_on_bad_intlv_mode(ctx);
+			return -EINVAL;
+		}
+
+		denorm_ctx->current_spa = add_base_and_hole(ctx, denorm_addr);
+		recalculate_hashed_bits_df4p5_np2(ctx, denorm_ctx);
+
+		atl_debug(ctx, "Checking potential system physical address 0x%016llx\n",
+			  denorm_ctx->current_spa);
+
+		if (!match_logical_coh_st_fabric_id(ctx, denorm_ctx))
+			continue;
+
+		if (!match_norm_addr(ctx, denorm_ctx))
+			continue;
+
+		if (denorm_ctx->resolved_spa == INVALID_SPA ||
+		    denorm_ctx->current_spa > denorm_ctx->resolved_spa)
+			denorm_ctx->resolved_spa = denorm_ctx->current_spa;
+	}
+
+	if (denorm_ctx->resolved_spa == INVALID_SPA) {
+		atl_debug(ctx, "Failed to find valid SPA for normalized address 0x%016llx\n",
+			  ctx->ret_addr);
+		return -EINVAL;
+	}
+
+	/* Return the resolved SPA without the base, without the MMIO hole */
+	ctx->ret_addr = remove_base_and_hole(ctx, denorm_ctx->resolved_spa);
+
+	return 0;
+}
+
+static int init_df4p5_denorm_ctx(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx)
+{
+	denorm_ctx->current_spa = INVALID_SPA;
+	denorm_ctx->resolved_spa = INVALID_SPA;
+
+	switch (ctx->map.intlv_mode) {
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+		denorm_ctx->perm_shift    = 3;
+		denorm_ctx->rehash_vector = BIT(8) | BIT(9) | BIT(12);
+		break;
+
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		denorm_ctx->perm_shift    = 3;
+		denorm_ctx->rehash_vector = BIT(8) | BIT(12) | BIT(13);
+		break;
+
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+		denorm_ctx->perm_shift    = 2;
+		denorm_ctx->rehash_vector = BIT(8);
+		break;
+
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+		denorm_ctx->perm_shift    = 2;
+		denorm_ctx->rehash_vector = BIT(8) | BIT(12);
+		break;
+
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+		denorm_ctx->perm_shift    = 1;
+		denorm_ctx->rehash_vector = BIT(8);
+		break;
+
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+		denorm_ctx->perm_shift    = 2;
+		denorm_ctx->rehash_vector = 0;
+		break;
+
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		denorm_ctx->perm_shift    = 1;
+		denorm_ctx->rehash_vector = 0;
+		break;
+
+	default:
+		atl_debug_on_bad_intlv_mode(ctx);
+		return -EINVAL;
+	}
+
+	denorm_ctx->base_denorm_addr = FIELD_GET(GENMASK_ULL(7, 0), ctx->ret_addr);
+
+	switch (ctx->map.intlv_mode) {
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+		denorm_ctx->base_denorm_addr |= FIELD_GET(GENMASK_ULL(9, 8), ctx->ret_addr) << 10;
+		denorm_ctx->div_addr          = FIELD_GET(GENMASK_ULL(63, 10), ctx->ret_addr);
+		break;
+
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		denorm_ctx->base_denorm_addr |= FIELD_GET(GENMASK_ULL(10, 8), ctx->ret_addr) << 9;
+		denorm_ctx->div_addr          = FIELD_GET(GENMASK_ULL(63, 11), ctx->ret_addr);
+		break;
+
+	default:
+		atl_debug_on_bad_intlv_mode(ctx);
+		return -EINVAL;
+	}
+
+	if (ctx->map.num_intlv_chan % 3 == 0)
+		denorm_ctx->mod_value = 3;
+	else
+		denorm_ctx->mod_value = 5;
+
+	denorm_ctx->coh_st_fabric_id = get_logical_coh_st_fabric_id(ctx) - get_dst_fabric_id(ctx);
+
+	atl_debug(ctx, "Initialized df4p5_denorm_ctx:");
+	atl_debug(ctx, "  mod_value         = %d", denorm_ctx->mod_value);
+	atl_debug(ctx, "  perm_shift        = %d", denorm_ctx->perm_shift);
+	atl_debug(ctx, "  rehash_vector     = 0x%x", denorm_ctx->rehash_vector);
+	atl_debug(ctx, "  base_denorm_addr  = 0x%016llx", denorm_ctx->base_denorm_addr);
+	atl_debug(ctx, "  div_addr          = 0x%016llx", denorm_ctx->div_addr);
+	atl_debug(ctx, "  coh_st_fabric_id  = 0x%x", denorm_ctx->coh_st_fabric_id);
+
+	return 0;
+}
+
+/*
+ * For DF 4.5, parts of the physical address can be directly pulled from the
+ * normalized address. The exact bits will differ between interleave modes, but
+ * using NPS0_24CHAN_1K_HASH as an example, the normalized address consists of
+ * bits [63:13] (divided by 3), bits [11:10], and bits [7:0] of the system
+ * physical address.
+ *
+ * In this case, there is no way to reconstruct the missing bits (bits 8, 9,
+ * and 12) from the normalized address. Additionally, when bits [63:13] are
+ * divided by 3, the remainder is dropped. Determine the proper combination of
+ * "lost" bits and dropped remainder by iterating through each possible
+ * permutation of these bits and then normalizing the generated system physical
+ * addresses. If the normalized address matches the address we are trying to
+ * translate, then we have found the correct permutation of bits.
+ */
+static int denorm_addr_df4p5_np2(struct addr_ctx *ctx)
+{
+	struct df4p5_denorm_ctx denorm_ctx;
+	int ret = 0;
+
+	memset(&denorm_ctx, 0, sizeof(denorm_ctx));
+
+	atl_debug(ctx, "Denormalizing DF 4.5 normalized address 0x%016llx", ctx->ret_addr);
+
+	ret = init_df4p5_denorm_ctx(ctx, &denorm_ctx);
+	if (ret)
+		return ret;
+
+	return check_permutations(ctx, &denorm_ctx);
+}
+
 int denormalize_address(struct addr_ctx *ctx)
 {
 	switch (ctx->map.intlv_mode) {
@@ -710,6 +1258,19 @@ int denormalize_address(struct addr_ctx *ctx)
 	case DF4_NPS2_5CHAN_HASH:
 	case DF4_NPS1_10CHAN_HASH:
 		return denorm_addr_df4_np2(ctx);
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+		return denorm_addr_df4p5_np2(ctx);
 	case DF3_6CHAN:
 		return denorm_addr_df3_6chan(ctx);
 	default:
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index f623ac23e4b9..c67ba4bfe9cf 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -37,6 +37,8 @@
 #define DF_DRAM_BASE_LIMIT_LSB		28
 #define MI300_DRAM_LIMIT_LSB		20
 
+#define INVALID_SPA ~0ULL
+
 enum df_revisions {
 	UNKNOWN,
 	DF2,
@@ -93,6 +95,44 @@ enum intlv_modes {
 	DF4p5_NPS1_10CHAN_2K_HASH	= 0x49,
 };
 
+struct df4p5_denorm_ctx {
+	/* Indicates the number of "lost" bits. This will be 1, 2, or 3. */
+	u8 perm_shift;
+
+	/* A mask indicating the bits that need to be rehashed. */
+	u16 rehash_vector;
+
+	/*
+	 * Represents the value that the high bits of the normalized address
+	 * are divided by during normalization. This value will be 3 for
+	 * interleave modes with a number of channels divisible by 3 or the
+	 * value will be 5 for interleave modes with a number of channels
+	 * divisible by 5. Power-of-two interleave modes are handled
+	 * separately.
+	 */
+	u8 mod_value;
+
+	/*
+	 * Represents the bits that can be directly pulled from the normalized
+	 * address. In each case, pass through bits [7:0] of the normalized
+	 * address. The other bits depend on the interleave bit position which
+	 * will be bit 10 for 1K interleave stripe cases and bit 11 for 2K
+	 * interleave stripe cases.
+	 */
+	u64 base_denorm_addr;
+
+	/*
+	 * Represents the high bits of the physical address that have been
+	 * divided by the mod_value.
+	 */
+	u64 div_addr;
+
+	u64 current_spa;
+	u64 resolved_spa;
+
+	u16 coh_st_fabric_id;
+};
+
 struct df_flags {
 	__u8	legacy_ficaa		: 1,
 		socket_id_shift_quirk	: 1,
diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
index 04419923f088..24a05af747d5 100644
--- a/drivers/ras/amd/atl/map.c
+++ b/drivers/ras/amd/atl/map.c
@@ -696,6 +696,26 @@ static int validate_address_map(struct addr_ctx *ctx)
 			goto err;
 		break;
 
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+		if (ctx->map.num_intlv_sockets != 1 || !map_bits_valid(ctx, 8, 0, 1, 1))
+			goto err;
+		break;
+
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		if (ctx->map.num_intlv_sockets < 2 || !map_bits_valid(ctx, 8, 0, 1, 2))
+			goto err;
+		break;
+
 	case MI3_HASH_8CHAN:
 	case MI3_HASH_16CHAN:
 	case MI3_HASH_32CHAN:
-- 
2.34.1


