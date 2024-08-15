Return-Path: <linux-edac+bounces-1648-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F056953C16
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 22:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D121C23E3F
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 20:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B1314E2DF;
	Thu, 15 Aug 2024 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EfCwSEAt"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85A914A609;
	Thu, 15 Aug 2024 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754850; cv=fail; b=X3nwc2M9CQTF04c9Xeis0Tz6231C3OGNBrNN+vYM97qf6GquEl/6xX9CwFNM2+XkKSpD8n0et83uV4Zb5X4bF18p9qytR+ajzMBKo4v+Pc+gdVH2eZ10o1NBHeaH2aJ867c+0u3X6E++9Vd6EemKiwSnVmIEjDVa91ctWu4wfFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754850; c=relaxed/simple;
	bh=9feu1ry0wc6vdyKWelu9tB7hvnxMquIDZ4BvyykZHlg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BvwbrOAr25aTIX2wWo8veJS8lQc6tyEXO98Nc1lzgjUKjvCkGyD95SQvInNvX2UhGguUenttfye3Drrd1/vVDcnWUFjTxzlMP/DS4AkjaWD3pOB5CeBy2nO+R7/M/MBeoLt5K6zsK57cUkMK8C6CyxpuXUShKYT/2epGwpwius0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EfCwSEAt; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grlxdbuGrq259GbPJCzphxiuMIgZQUYua9MEP69cOg4gGDvI3AS/9JG6GGSM1xvjyZVX49QBWc41l1kjjmvTSyoWYjEd/eMwolm5ZME007KQHqc0rZtX5uC6HUFuZYPDxYNOszWNV1IMGzlrtKX1/qTFgDKslVYLPJGNgD+Zd7Wjx92nt7Kejthvg8UVNGpn5uhl/MHGJ42H4x8mMwGhXdvX6mGFcmBuGSJCufMAiQie45ROD/B3l8lU6/a4r91LuCK0UWPLixy65RKU0bv2dIe7Kg9O59IpAohDNczHu/x+O7Pj77en6tcg/+8b5z3mlJKVbsz0z8trOu21HuYdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=us7wQFOsOryuJcamWuwA22pfnzJeYuv1V+XhQJV2HMw=;
 b=JhFM2WZmdwMC+B/HzVNo1ag34r09Ag778+8yUk2BGzNXgHRgTnkNyhZ/KyWmmUOynNK5/rba6u7KnXXFAkpX/E7qhwUsAKU04G5T+XkGnk3PbVpYrDHuex0AUnSzoGQheXsRCuWrth8swoJ8Uk8vrsRhNZot04ylXEQLghh19f1+bEC4VtkwqaGIpan3K5sVNNQYblsXBY7rU29fcQAS4FdyX2AGIWOfxLNmNyxp/4KjtvSRI7W7Skic9fvVojt8JgfUgl0u6d0K+L9mMwUcqOl+JJfh+AhyMF3z/gS+r7rFUn34EXVUNXxZ+dwwJVjcARJldr7ZSVn//fgLmCJpcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us7wQFOsOryuJcamWuwA22pfnzJeYuv1V+XhQJV2HMw=;
 b=EfCwSEAtVc2D+l6lJOGtYJ32x9VdcBdx9PfR79ODK4IBP7coe5y4cA9Wc0cWQc0dIUN3TYwST9YfZvAFE1tSoFKQ/qNy/0V2/tPTaGQaqha5DGF5PGcZ7ldQsKpe5wtU6adTLh17H2MCFsrD7nWMq64KxGCSPKkPAXXKMHer0F6Ezjm6WNL/mDftmGza4EicRg9fvPCVoJR31+FSH9hw/7FLyDZohWRCn2Iha2IseqAfmZq77c6y6brbVgv+RvAQ3j6KIQ67R3jt/uQldieDxsiwp/pZKHn/oDOQSVy5PNNCEBwXb7jg4jNlAwJLGWB+g65Mp1ztty3/IZ+f7s/ZZQ==
Received: from SJ0PR13CA0089.namprd13.prod.outlook.com (2603:10b6:a03:2c4::34)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Thu, 15 Aug
 2024 20:47:21 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::65) by SJ0PR13CA0089.outlook.office365.com
 (2603:10b6:a03:2c4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16 via Frontend
 Transport; Thu, 15 Aug 2024 20:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 20:47:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 13:47:12 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 Aug 2024 13:47:12 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 15 Aug
 2024 13:47:11 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
CC: <linux-edac@vger.kernel.org>, <shravankr@nvidia.com>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [v1, RESEND] EDAC/bluefield - fix potential integer overflow
Date: Thu, 15 Aug 2024 16:47:00 -0400
Message-ID: <20240815204700.6447-1-davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: fcfc75c8-8491-42ed-4383-08dcbd6b75d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ubofKp968MvMJfSo5E15GWTGY+HRfQoOsyXFLtPR/q6Abe6sz68sO9YkPSTv?=
 =?us-ascii?Q?GIISzJeHSSFlw3auUxP51qBkeBCaGKVq+ud1lhkTINJ1ScN3ZlxdgK6emwBx?=
 =?us-ascii?Q?NaYmSeu6+XQJkA1HjvFhzGnw7DI8ieQP/tmQtA09PBZv6HQ26tjS2dmKuQiW?=
 =?us-ascii?Q?v5w/nGrw45Kpu36FGoeepINHGGsr9DKkBfSu6BpXNtKLaIDkc6BdbByPP8G3?=
 =?us-ascii?Q?4iGYMwz/phYtx+WWrsneZAWzPqIDFKf3ivUU+rmpXZQnLenk5+MK+H/QsR/+?=
 =?us-ascii?Q?6xhcnS+3xLh72NAWU6L+dhcavv/0gLujoC7VaBOPe44622m9kq+dXC6bpsDU?=
 =?us-ascii?Q?dZjgbgYy9jGHQ/JUHU0lz1v5g47HFoPDJHrM4Gdnf4s0WMqtK7Q5Z4BIMj+B?=
 =?us-ascii?Q?T2SLRQHh/naPvVg4huQ7zU592bH+AcOu+iSh3b4byTyyW0Y6SsgYzrHUGwg+?=
 =?us-ascii?Q?oMWjlIxLEzLPEo6neQz+9BoI1V8bY6VE1rBEncmsn8PBf/rshow1OcbRWzkp?=
 =?us-ascii?Q?vqm81h+YN6BSpo6RWupZ0IJ/zEIwqsM9yI5kTAzVx5wOrua4/QluEC28i90h?=
 =?us-ascii?Q?NNRdBTee3QNd3UV/zd6fY/DQ5orkhHwqAROZKeBc3sAimUTO6YaPrCDQj/L7?=
 =?us-ascii?Q?yoC30BD08gX6YBieKYbbEH8gd0pqIjVNUFNMcMCB6Kceg25TjAH8eeyUy7RG?=
 =?us-ascii?Q?sCVb3G1FUK6vD8lq7IDLWZfReDK5V9qbdlmM9tbsS39lKMFdwN/pJ5Iv/fhP?=
 =?us-ascii?Q?DV95wqIbhftvSv1J4zFLxFZiEWQX7SnpC9ubzEf2cRmz8SGLZjUUcwXA/UI/?=
 =?us-ascii?Q?+fgaC6VCmHkf2YA48kzy2Ab6rXNnSv41kbL7NYphEwpNC/Jhka/pw4T6JifX?=
 =?us-ascii?Q?AzagdzLIngfx38p1wL8aOuEcOpe2vqtROcydtaxGCSle8obwlmWD5kL3vHqc?=
 =?us-ascii?Q?FRQD/qTzgQ5CTqFK1I+5XlngAW7pov8Kqwwotg7PFbpBm8GdgjTvYgSSXIGr?=
 =?us-ascii?Q?ddpNXW2hGFw29j2MGlOBjD9TMz9S8e3oFmSFtd15naaLoawXmS6r4Q3Wxdce?=
 =?us-ascii?Q?Zd+bVt50eCf+nuxwz12oAWWp+ViI4MXkVWi19Fl6otCZFygQiXV9ccHRgB7M?=
 =?us-ascii?Q?5eMLORYwC6/xnUudyqkWtrUjO30zo+oYhLZGTlML+wkqHTfViFrdVtkTbEZU?=
 =?us-ascii?Q?KMl7MRvwCA9+XBkEeFsj7ER6FHjmjjrMuByO8AxDTMj/HVIAcDlbE6T9BIdz?=
 =?us-ascii?Q?doML0CkTYfWYZcSOiy9hKvqqwQk/jaLss4hydQQQj/4H7v75Qd7AtjJCTAim?=
 =?us-ascii?Q?+8I3n3W4eDLst0rUl3D9GNawdkPx9qVJCv1DEQF6a5vrTtJe4Fvhp1488F5I?=
 =?us-ascii?Q?TM976BGHLXCifl4t9v5XaTJ1KzCNq73RyOOXcu2k27lNFMEz4W9F9JGuGtKV?=
 =?us-ascii?Q?1YOF6DxZYaW0P19mBouGS6wxuUJ42FTt?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 20:47:21.5385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfc75c8-8491-42ed-4383-08dcbd6b75d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

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


