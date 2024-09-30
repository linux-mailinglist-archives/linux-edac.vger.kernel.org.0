Return-Path: <linux-edac+bounces-1935-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65BA98A83A
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 17:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F031F241A5
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5E61922CC;
	Mon, 30 Sep 2024 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PT8fVPji"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACF190671;
	Mon, 30 Sep 2024 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709081; cv=fail; b=JPJUJ6rycp8UXnFSiHOICuByCHo4JtiotEzNpTgWGtpKBVV/jnL0zoDypsXmM2tYRYc5o5hVWUq/1MCMZ5XONtir/xiWTnpYNIQGcfJhHsoOUgx0mn/o/61RRJ/9vruMEU46P6hfSq9xdEteC5IrovIEFyD6Njsjjc08ChxDYGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709081; c=relaxed/simple;
	bh=9feu1ry0wc6vdyKWelu9tB7hvnxMquIDZ4BvyykZHlg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rkMaVBI48p91/GmKixZdY+KfbIbLaJEZeIIXl0PeC+piELujdm0FHYekO7VvLaufN0AZvmHqRISPpAKHj+C/WtiUq7qZU3my+6CVJmdDWNiitEfWz4tqMfCdc0+FcR8IBOUgtOhWth/3ELpjKz8L+SK4+ZQK3ItB/0cxtu5DcJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PT8fVPji; arc=fail smtp.client-ip=40.107.95.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSoKq8m54x1mf/2o4+PetnGsIb0sNrlCEvjCKCeVv692+bWpMvEq2ZsCdYeMkrQj9W6AuQbNlC7dAgDfOKF/zXLfjP5ROZlhossOUpX4dj0ui+jwnYYXqDUNozYUu7IWb4Bj+ZzfjRPbjfMtCXiUAkItmao+SVrjQvwxeCi6HZaLCLp5rH3UtpN4sjvGfQ+uCDSYCPxaXhaCcQvHhhIj757sKRr7GXae/U+eTurt82yA37LxLCG55WthHr23M0JGxY4x2Q1j+FNKupHD9oZuGVXphbus9j9jhILLzTP7EQ9E02beAjptLmFRuleJlD9pYRKRv/AjYj6ePj66LOwNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=us7wQFOsOryuJcamWuwA22pfnzJeYuv1V+XhQJV2HMw=;
 b=C8WwOxLFGKGf62sHubIAZ1K31Gd0rRdL5SY7fw8G49wV0nxNQcQD6TP4ewlqdOgC89sqi8OcYZyJKSfL5o8HJF6bRWDzFwT19dBAYUD6ymvIzCZC7TRj8pa40V8s5xh+KCJlGEu6T55D3JrNs27z0mo8fqhpiQRQ1FVFClTGtP5adJRnxnQRc6G8gsDA8FRMSf0anmPf3Sm2gAp5pBVrC1M3YGV1hTzGqe39WdFIkCmzU8/z1XDY3kuIhIY2OxxIPZYXqMgAIpOkbZZqVk3BZOFdac4xqe1l47OBaKtk/iOHgSKZrOT6vRMBdiGCycRhr1Aox0+C2THS2PgmBJ4Vsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us7wQFOsOryuJcamWuwA22pfnzJeYuv1V+XhQJV2HMw=;
 b=PT8fVPjix6X7yryZOMB0kktSplyye8UuP17wUlbLl2snLOJ3SVqass3wRN/ud8SseWcdeoBpqpr9fCWcQqMmYMaZw/ISzc8jHnsgPgFUijRr8v/nxsHAM9Tx7RqR1N1uzRa/qL21ZIaW99Acn905eFG3PPMkTkvSosj9IlEBvOX2Cn9DDDjx9GSi90MvAOi6cryT+D83ZxhwIeT6kVq8d/HO2vhyEEcZouBTzaX/1Wm+AKdqBrbxbJlzaEkk82r1+2R4ZPTmULmmRTUTlJFvljM4hpIcZFi0ExjZJizUy1Gkb/n02Bg7TzXjW6K3bD4Ztj75+h5N5BPkMw63GMoHeQ==
Received: from CH2PR02CA0007.namprd02.prod.outlook.com (2603:10b6:610:4e::17)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Mon, 30 Sep
 2024 15:11:08 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::b3) by CH2PR02CA0007.outlook.office365.com
 (2603:10b6:610:4e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 15:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 15:11:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 08:10:59 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 30 Sep 2024 08:10:59 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 30 Sep 2024 08:10:58 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>, <linux-edac@vger.kernel.org>
CC: <shravankr@nvidia.com>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: [PATCH v1 RESEND] EDAC/bluefield - fix potential integer overflow
Date: Mon, 30 Sep 2024 11:10:56 -0400
Message-ID: <20240930151056.10158-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|MN2PR12MB4158:EE_
X-MS-Office365-Filtering-Correlation-Id: d4cad371-0d7e-496a-4c51-08dce1621cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aKTxxH3WWqYkcU0nQqNHnU7ZQwHpFzilzHHpDj9xSZ2ANsBWA+bbNGcu3sWD?=
 =?us-ascii?Q?LPcly2xeZ7KJ6hHyR1fiuR2ayNG03ENxGlPG2H2TAX6tqkGvLkKNjPeztR3s?=
 =?us-ascii?Q?eJbvSLmIvHxOHXEVTv9MUi7fZldHJuhwYWkY+uWS6F2qOdwXHYsVFjo8hLVB?=
 =?us-ascii?Q?SZVSDmA7XlTytJBYJbqzvIpPX0HDb/8OiELV+ZV0sV8FJCKvzaAnTwEGHZ/F?=
 =?us-ascii?Q?KsYd65ZZoNxt6LYVIOCVhBDD8stP7rEZL0I50M4dTS/ll/vyiFbj+PWZY3Yc?=
 =?us-ascii?Q?2ueYVD8dMA9okhIZT6Y+dWcTwN7GItRPCSTr7JaIvJeX8bq+/MZ+ZPqZfc1n?=
 =?us-ascii?Q?yv+rRBZRbatUeb65Si7zwc9DbBNI8RDisRjQv3KqMDWojB2tOTBg+h+1Xoww?=
 =?us-ascii?Q?4TYGmjTeQPPh/PIbimft+PplvkmpGG4aF+Zkc506pyCI+OxKT09+yC56906I?=
 =?us-ascii?Q?jR+lkX9Or63qu52F6NG2O5SWN8sH9sYrLiSu+AYfJgbQVva4YZnwyLdL/8qF?=
 =?us-ascii?Q?w1Q+BIvApZyLmmM6MXtGz8sWWKO0y/QvAY1Um0fO8GXNJs0HPdnRBzsVXbK1?=
 =?us-ascii?Q?HJLUbjypXaD0MQkgkkrYanRABv38iKCYJeEiPUX1qXkDgJuanWZY+BFt474i?=
 =?us-ascii?Q?UBvUGG5OoCQnbVYA88yESCb3xSzLmdpAgHINbz7HrOZ1cDUBB6k79oeNWp56?=
 =?us-ascii?Q?APGZt8a2VfJZC2W9xb5EDG8e5wOKXRZTff7ssspLYU4jzsh4+lCLfWjyNnQN?=
 =?us-ascii?Q?rcjv2Ti8tdddh6Trk4RQAU3d1lq+djeEHTX3wdZodcEMhI5eYxYHULrJfHn9?=
 =?us-ascii?Q?DvN1qs45bUm1I3engOF4gFocxwfRtDkGkigUtdmLsgiGXgg5p3bYZQxhGTj3?=
 =?us-ascii?Q?7svnCt7bViRuJnZ5FFq475nuHjrzvo5e+uIH1ThGTTUkTOJkE/BrU9i0sDkY?=
 =?us-ascii?Q?fmvRnAPRp1jKWqToCw14oSOgU/T+1dMB7RWaZIO+fP17QFoSVILZr4mWrfxt?=
 =?us-ascii?Q?NLwgDoiwLWH3NjXekAATjO9I7w1yUGQblAYKzbBx6jyg0cztHarv3U4aEAhE?=
 =?us-ascii?Q?KNM2QVPfzGZbHxTCliDRDrajN/i6rkxrII2M6dDaITWDaIqEfQOFB9zT28TF?=
 =?us-ascii?Q?sdZ8a8IAp77uJ+vWsz/1GvuJh3uQ7hD/utTYRgd0csXaYWYVcYSJiZrkDD08?=
 =?us-ascii?Q?GjKJOTGHHy1xECNpUMPQS0lv1tCgwQF/x3pTVvMfXixKA7Z9Mw2Q/4Wrt3zE?=
 =?us-ascii?Q?1ycetViSE8N9k57N/ifSLgpRkRMdHQfXtt+V5vdPC3j/Jvfg004VnbZVhign?=
 =?us-ascii?Q?fdYF9hKqW/v1YJw8R6auCk+J9GOZ84n+0UStOzK7TTJuE1aJjpB+bIbF+VZL?=
 =?us-ascii?Q?XgoPMQaT0GLSEdKxpR5b9e1jo0HdQBwx8oJU2PoK5ZgFr+/8xyASwEuWUNLU?=
 =?us-ascii?Q?yl3lgJeYAgLLO/veJQC8Vnx1O9EQK2l1?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:11:08.2369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cad371-0d7e-496a-4c51-08dce1621cad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158

The 64-bit argument for the "get DIMM info" SMC call consists of
"mem_ctrl_idx" left-shifted 16 bits and OR-ed with DIMM index.
With "mem_ctrl_idx" defined as 32-bits wide the left-shift operation
truncates the upper 16 bits of information during the calculation
of the SMC argument. The "mem_ctrl_idx" stack variable must be
defined as 64-bits wide to prevent any potential integer overflow,
i.e. loss of data from upper 16 bits.

Fixes: 82413e562ea6 ("EDAC, mellanox: Add ECC support for BlueField DDR4")
Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
 drivers/edac/bluefield_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index 5b3164560648..0e539c107351 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -180,7 +180,7 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
 {
 	struct bluefield_edac_priv *priv = mci->pvt_info;
-	int mem_ctrl_idx = mci->mc_idx;
+	u64 mem_ctrl_idx = mci->mc_idx;
 	struct dimm_info *dimm;
 	u64 smc_info, smc_arg;
 	int is_empty = 1, i;
-- 
2.30.1


