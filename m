Return-Path: <linux-edac+bounces-1008-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD41C8BD1BF
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 17:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E555E1C22525
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 15:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC49C155756;
	Mon,  6 May 2024 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p1ZxUxNh"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83165155752;
	Mon,  6 May 2024 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010413; cv=fail; b=TcfblCwZRcBT8eCvKFtY+wmoJfwhasbENkElZ+snAF/ruU124MRR7ftAL9Q/DVyaDYclAXZPySYMadid0a4BvMCA75RQ67tpvVeYuFVIpMRGDk6t3lN46WQZ7XK9ifMhI+ni8uSqLJyvqjwQlVOkMIOoQ2SH36lHDNE610+ac2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010413; c=relaxed/simple;
	bh=MzgyWnlj0Gx5iRpdpOhboii4elrJF2taw5FDVxa0xFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUqsjyae5RrH9AAYhwu1+X9LF6eXqhh2z2GTZl6uqTGk5M2pEoOJKiiANQO1GfnLUjuMoxAwM00vhwyHCetnKbQByCy28hXaSdU4skupDkV5rPMmauTRv7mljkOEyMjsu9Cw/fNQXqOqN/5y4P+qGjZkTWTYX6tK/sprjgfPvSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p1ZxUxNh; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obqba8B3k5qSFPeRPUIRM0YnIKstyCDpRRAysN+8IljAHkUS+CkIz8QgfTSwxucUB+OD7nuCLQGeCBeeybp1ulzG6t8gv0n7HtNCtfS8pe5Z5dFxr88VkZykMkskDqjjrYPLt9JKmO4LGNbjWyOPr2tKAM6aNxURk3akxeL+HsAFun3m7fRbYflYSf6yXER6LZSPy8YZqhfC6Es3Ivhj7UdQVlf8N4YN9gLVFrPeFSqAx3DgtHDtpqjSJtpwi9Ebbe4Ojy5acrunFyvA9TqkeEya5CMQYXwDERaZviKh6VL8ZR7EoPxBzr545uF/e2glfrS8F712rOgXIOmoHB6gkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+akAL2iduPYhO5KgfM8jx4Ojx18heRYA/div64xC52E=;
 b=kRzpCfijT6kRcNOoxA7jStb8Bu7IB+eXRwyolTFI7KpvIsRgfyzbRI7Ji6fbjwjoTE/JVM6PJ57nyzeb/BZLV7x3wmRsoa8q9MjCVfgSXKdsbkdVqEuswTareYWJniQn4BpSdjkq5agPpn1S1QFJ1VB2IMm5BFJNNjhBtB7ll1pSz8ZLq+yTtzJ5s4vd+XET/utrLDU9IJ9KBBtvg1KmloSZtUxIQJxvHXhnAw2NwG/2eMUB7cVoUqV3qtGyReY0kJUVjuzLRbaKtxbWScQosAH4i1q7OuHNtmOb1OTbmzjtSDsiCPi3RGps5Nf5rxDge8pnJ7IPXbOcCgCSiHXrNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+akAL2iduPYhO5KgfM8jx4Ojx18heRYA/div64xC52E=;
 b=p1ZxUxNh5/W7ZrAWIaC/In2KyuQRq42DJ5900A/zT8V/DKy9pcarrOxfND6bVd6nFu5jAQWoatf0sjHkphy9R8IosAfAsXmnXuHw647KqusZKgeZKd/lV2LJFc/+ijtvA9c77NPAs18N8ddIGnMxcYXj8d9es0q13aJQZPGRW9E=
Received: from SA1P222CA0123.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::10)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 6 May
 2024 15:46:46 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::15) by SA1P222CA0123.outlook.office365.com
 (2603:10b6:806:3c5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 15:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 15:46:44 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 10:46:43 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v4 4/4] RAS/AMD/ATL: Implement DF 4.5 NP2 denormalization
Date: Mon, 6 May 2024 15:46:05 +0000
Message-ID: <20240506154605.71814-5-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f910f7-3176-4bc0-596e-08dc6de3bb34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nxc4WQGVGJatWQcYohfZCWaYVFPcVzZqt6j48+l7hUsJh2UAkzNSm6ULkdhb?=
 =?us-ascii?Q?4a1X7Ch6xj3zcXfLodvZXxy2u7Z+MKM3Q+vibTCr/RwxEX4L2wsvvseq79o/?=
 =?us-ascii?Q?BqhA/yg/DSkKXoefUT9J7VpDm+ecuTyygA3Fg18MBBQMd9qmajb33VU/b8rg?=
 =?us-ascii?Q?W32ud6PzZy03Y+1CgemG6ddINevroNjWg7AwcoZybBRkeDN6ZU0SBhmM8kY3?=
 =?us-ascii?Q?8jB/qlIQVKk/zgCnbw34YIi5zTQL1HC+Rm81KBclbhDHX+Nq0aPZE1lXYxhM?=
 =?us-ascii?Q?MYdRogKa+UXnc0uv0iEkretCsQOLxwQZROLIcslPgTvx9WqmxKiaa4pzC4Ri?=
 =?us-ascii?Q?57AdGl3EaUk2OURNfQU4XoiFRG4eNjxbXFjkvQtQXh4DwbIjbpb+55sD20BC?=
 =?us-ascii?Q?3V4Eq7gTCbYumC3doRZ0zWRkHU1vR3QczxZMU8kG5uEZxCAunpO4O+2prBMj?=
 =?us-ascii?Q?P4aQF6ACdFmXTpJIkZWblGro9EjyeGsen1DCOBBEu8d8mAv81woLsofAf0Z2?=
 =?us-ascii?Q?2eHDHLbbqIMCaoh2jIqUqt2YUaRfyn+Ew3u2tyyuD/NJXN2EezO+6yySGpOq?=
 =?us-ascii?Q?HAq4XojDJRAIkEqzc8f/QA5C67kKAqvXua4jh/DSsETT/KbTDri6Hc7r98cW?=
 =?us-ascii?Q?YZ7i1DLVuCBsHYPC9kxXnFXkiZl4+JEsuHl4d4tuuHNDU96UXw0fDR4vn4bD?=
 =?us-ascii?Q?fDu9KG8ohDtR8ZPQa+N7du0CzEqm00yrDXbnydCAXSL4jmZRsz79iEENihuV?=
 =?us-ascii?Q?PQxkYZtpckliLF8QI2+KF0gIUqNzpSC4+XCpjW8SPe9rudENRkjC7Sy3zF7V?=
 =?us-ascii?Q?5Ks1/hfbtCwUiVifQm7DN7gWFMD3NZ+4UQTmKsp3c3Op9DKMvwgdKexdUYWk?=
 =?us-ascii?Q?OpSn2B6dMxFkC+FvAcp7xyu5bs132CmyK9FIskSgqpeSECfnauaPWZN+7Kl1?=
 =?us-ascii?Q?b3YZ3OJ/JW+Uayns+3V1hWzG1xeJlHYq3TEkJtgvWq+/wddepCJF1Y91v+Jf?=
 =?us-ascii?Q?+JEenOtrmSm/BTENsHFKn1TCvVB6q1SXq1zFhh1Sw/O9HY+urSy4wRAZs3DC?=
 =?us-ascii?Q?0iGOGW7wuh3TbU+0dgH9IB+hXtA95mExVxadoAM9cq2xPv+C6D1IBL8qvt9X?=
 =?us-ascii?Q?kSytbl3Qci8U/5+qPzrR9uKMVOIBAF82qqLa9lO5tS75a2mg9qZ6f01m2vmB?=
 =?us-ascii?Q?URyCbHYkz1Eknrnozz7x7UvsvbI7wI9Rla3FyRF8cv9BDq09Kn9EcSDqwk/u?=
 =?us-ascii?Q?Yx4RIP4Gn4p3eV0YeAVu3Sem9/z3XHJPAl30GNwb+4cS2eojChqTLQAmEP3v?=
 =?us-ascii?Q?cTjdbq+BZ/HJla4ai8m+CpOJyk1sIXh0jZ2ixE8gHm9Dza4dQQnREhQtnaC1?=
 =?us-ascii?Q?VBBjNi85UmfQ195gV/fBG7VJT0ol?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 15:46:44.5072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f910f7-3176-4bc0-596e-08dc6de3bb34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181

Unlike with previous Data Fabric versions, with Data Fabric 4.5
non-power-of-2 denormalization, there are bits of the system physical
address that can't be fully reconstructed from the normalized address.

To determine the proper combination of missing system physical address
bits, iterate through each possible combination of these bits, normalize
the resulting system physical address, and compare to the original
address that is being translated. If the addresses match, then the
correct permutation of bits has been found.

Signed-off-by: John Allen <john.allen@amd.com
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
---
 drivers/ras/amd/atl/denormalize.c | 523 ++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/internal.h    |  40 +++
 drivers/ras/amd/atl/map.c         |  20 ++
 3 files changed, 583 insertions(+)

diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
index e279224288d6..5db85116a167 100644
--- a/drivers/ras/amd/atl/denormalize.c
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -448,6 +448,110 @@ static u16 get_logical_coh_st_fabric_id(struct addr_ctx *ctx)
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
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 14), denorm_ctx->current_spa) << 4;
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 2;
+		cs_id |= (hash_pa12 | (hash_pa13 << 1));
+		cs_id |= hash_pa8 << df_cfg.socket_id_shift;
+		break;
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 2;
+		cs_id |= (hash_pa8 | (hash_pa9 << 1));
+		break;
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 13), denorm_ctx->current_spa) << 3;
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 2;
+		cs_id |= (hash_pa8 | (hash_pa12 << 1));
+		break;
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id |= (FIELD_GET(BIT_ULL(9), denorm_ctx->current_spa) << 1);
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 1;
+		cs_id |= hash_pa8;
+		break;
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id %= denorm_ctx->mod_value;
+		cs_id <<= 1;
+		cs_id |= hash_pa8;
+		break;
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id |= FIELD_GET(GENMASK_ULL(9, 8), denorm_ctx->current_spa);
+		cs_id %= denorm_ctx->mod_value;
+		break;
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		cs_id = FIELD_GET(GENMASK_ULL(63, 12), denorm_ctx->current_spa) << 2;
+		cs_id |= FIELD_GET(BIT_ULL(8), denorm_ctx->current_spa) << 1;
+		cs_id %= denorm_ctx->mod_value;
+		break;
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
@@ -699,6 +803,412 @@ static int denorm_addr_df4_np2(struct addr_ctx *ctx)
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
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		temp_addr_a = FIELD_GET(GENMASK_ULL(11, 9), addr) << 8;
+		break;
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
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 14), addr) / denorm_ctx->mod_value;
+		temp_addr_b <<= 11;
+		break;
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) / denorm_ctx->mod_value;
+		temp_addr_b <<= 10;
+		break;
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 13), addr) / denorm_ctx->mod_value;
+		temp_addr_b <<= 11;
+		break;
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) << 1;
+		temp_addr_b |= FIELD_GET(BIT_ULL(9), addr);
+		temp_addr_b /= denorm_ctx->mod_value;
+		temp_addr_b <<= 10;
+		break;
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) / denorm_ctx->mod_value;
+		temp_addr_b <<= 11;
+		break;
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) << 2;
+		temp_addr_b |= FIELD_GET(GENMASK_ULL(9, 8), addr);
+		temp_addr_b /= denorm_ctx->mod_value;
+		temp_addr_b <<= 10;
+		break;
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		temp_addr_b = FIELD_GET(GENMASK_ULL(63, 12), addr) << 1;
+		temp_addr_b |= FIELD_GET(BIT_ULL(8), addr);
+		temp_addr_b /= denorm_ctx->mod_value;
+		temp_addr_b <<= 11;
+		break;
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
+		case DF4p5_NPS0_24CHAN_1K_HASH:
+		case DF4p5_NPS1_12CHAN_2K_HASH:
+			denorm_addr |= temp_addr << 13;
+			break;
+		case DF4p5_NPS1_12CHAN_1K_HASH:
+		case DF4p5_NPS2_6CHAN_2K_HASH:
+		case DF4p5_NPS1_10CHAN_2K_HASH:
+			denorm_addr |= temp_addr << 12;
+			break;
+		case DF4p5_NPS2_6CHAN_1K_HASH:
+		case DF4p5_NPS1_10CHAN_1K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), temp_addr) << 9;
+			denorm_addr |= FIELD_GET(GENMASK_ULL(63, 1), temp_addr) << 12;
+			break;
+		case DF4p5_NPS4_3CHAN_1K_HASH:
+		case DF4p5_NPS2_5CHAN_1K_HASH:
+			denorm_addr |= FIELD_GET(GENMASK_ULL(1, 0), temp_addr) << 8;
+			denorm_addr |= FIELD_GET(GENMASK_ULL(63, 2), (temp_addr)) << 12;
+			break;
+		case DF4p5_NPS4_3CHAN_2K_HASH:
+		case DF4p5_NPS2_5CHAN_2K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), temp_addr) << 8;
+			denorm_addr |= FIELD_GET(GENMASK_ULL(63, 1), temp_addr) << 12;
+			break;
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
+		case DF4p5_NPS0_24CHAN_2K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
+			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 12;
+			denorm_addr |= FIELD_GET(BIT_ULL(2), test_perm) << 13;
+			break;
+		case DF4p5_NPS1_12CHAN_2K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
+			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 12;
+			break;
+		case DF4p5_NPS1_12CHAN_1K_HASH:
+		case DF4p5_NPS4_3CHAN_1K_HASH:
+		case DF4p5_NPS2_5CHAN_1K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
+			denorm_addr |= FIELD_GET(BIT_ULL(1), test_perm) << 9;
+			break;
+		case DF4p5_NPS2_6CHAN_1K_HASH:
+		case DF4p5_NPS2_6CHAN_2K_HASH:
+		case DF4p5_NPS4_3CHAN_2K_HASH:
+		case DF4p5_NPS1_10CHAN_1K_HASH:
+		case DF4p5_NPS1_10CHAN_2K_HASH:
+		case DF4p5_NPS2_5CHAN_2K_HASH:
+			denorm_addr |= FIELD_GET(BIT_ULL(0), test_perm) << 8;
+			break;
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
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		denorm_ctx->perm_shift    = 3;
+		denorm_ctx->rehash_vector = BIT(8) | BIT(12) | BIT(13);
+		break;
+	case DF4p5_NPS1_12CHAN_1K_HASH:
+		denorm_ctx->perm_shift    = 2;
+		denorm_ctx->rehash_vector = BIT(8);
+		break;
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+		denorm_ctx->perm_shift    = 2;
+		denorm_ctx->rehash_vector = BIT(8) | BIT(12);
+		break;
+	case DF4p5_NPS2_6CHAN_1K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_1K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+		denorm_ctx->perm_shift    = 1;
+		denorm_ctx->rehash_vector = BIT(8);
+		break;
+	case DF4p5_NPS4_3CHAN_1K_HASH:
+	case DF4p5_NPS2_5CHAN_1K_HASH:
+		denorm_ctx->perm_shift    = 2;
+		denorm_ctx->rehash_vector = 0;
+		break;
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		denorm_ctx->perm_shift    = 1;
+		denorm_ctx->rehash_vector = 0;
+		break;
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
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+	case DF4p5_NPS1_12CHAN_2K_HASH:
+	case DF4p5_NPS2_6CHAN_2K_HASH:
+	case DF4p5_NPS4_3CHAN_2K_HASH:
+	case DF4p5_NPS1_10CHAN_2K_HASH:
+	case DF4p5_NPS2_5CHAN_2K_HASH:
+		denorm_ctx->base_denorm_addr |= FIELD_GET(GENMASK_ULL(10, 8), ctx->ret_addr) << 9;
+		denorm_ctx->div_addr          = FIELD_GET(GENMASK_ULL(63, 11), ctx->ret_addr);
+		break;
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
@@ -710,6 +1220,19 @@ int denormalize_address(struct addr_ctx *ctx)
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
index 05b870fcb24e..946e36c053c5 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -34,6 +34,8 @@
 #define DF_DRAM_BASE_LIMIT_LSB		28
 #define MI300_DRAM_LIMIT_LSB		20
 
+#define INVALID_SPA ~0ULL
+
 enum df_revisions {
 	UNKNOWN,
 	DF2,
@@ -90,6 +92,44 @@ enum intlv_modes {
 	DF4p5_NPS1_10CHAN_2K_HASH	= 0x49,
 };
 
+struct df4p5_denorm_ctx {
+	/* perm_shift: Indicates the number of "lost" bits. This will be 1, 2, or 3. */
+	u8 perm_shift;
+
+	/* rehash_vector: A mask indicating the bits that need to be rehashed. */
+	u16 rehash_vector;
+
+	/*
+	 * mod_value: Represents the value that the high bits of the normalized
+	 * address are divided by during normalization. This value will be 3
+	 * for interleave modes with a number of channels divisible by 3 or the
+	 * value will be 5 for interleave modes with a number of channels
+	 * divisible by 5. Power-of-two interleave modes are handled
+	 * separately.
+	 */
+	u8 mod_value;
+
+	/*
+	 * base_denorm_addr: Represents the bits that can be directly pulled
+	 * from the normalized address. In each case, pass through bits [7:0]
+	 * of the normalized address. The other bits depend on the interleave
+	 * bit position which will be bit 10 for 1K interleave stripe cases and
+	 * bit 11 for 2K interleave stripe cases.
+	 */
+	u64 base_denorm_addr;
+
+	/*
+	 * div_addr: Represents the high bits of the physical address that have
+	 * been divided by the mod_value.
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
index e58b29e890c4..4a6e2b1b6a78 100644
--- a/drivers/ras/amd/atl/map.c
+++ b/drivers/ras/amd/atl/map.c
@@ -696,6 +696,26 @@ static int validate_address_map(struct addr_ctx *ctx)
 			goto out;
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
+			goto out;
+		break;
+
+	case DF4p5_NPS0_24CHAN_1K_HASH:
+	case DF4p5_NPS0_24CHAN_2K_HASH:
+		if (ctx->map.num_intlv_sockets < 2 || !map_bits_valid(ctx, 8, 0, 1, 2))
+			goto out;
+		break;
+
 	case MI3_HASH_8CHAN:
 	case MI3_HASH_16CHAN:
 	case MI3_HASH_32CHAN:
-- 
2.34.1


