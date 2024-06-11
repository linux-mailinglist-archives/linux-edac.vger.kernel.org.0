Return-Path: <linux-edac+bounces-1251-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017A09046ED
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 00:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F63286995
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2024 22:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262EE15444C;
	Tue, 11 Jun 2024 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wnh6U5C4"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4A14EC73;
	Tue, 11 Jun 2024 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145053; cv=fail; b=Tz0BGaiD6rI9gTDxl6/tHKF9XIU3/qKji0k1obsepkMMh0oajLuX2qfAWEcvnomjZVzHuDPFhprwuwmbwDGqeX0AXWCK7SbHGSQofWFeCOOiEH7e7rjFbxfA6INbVTnkN4HBCPy5IkT4G7R6rvYWaGBNxI9PqReQzNZSPDOLGjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145053; c=relaxed/simple;
	bh=9feu1ry0wc6vdyKWelu9tB7hvnxMquIDZ4BvyykZHlg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u7o4FxdkmA8W1ZuD9T7ImfT+oNY1XaCXt8EXu9shnN+DDN0R31JJnZPljsqfqGWhFPoVxjCUQqHspbsMCImSIKtztx6PhTJyD8vNYXwKXqG8l+vq+KNCmWyl1ZedEO/QgtzsgBIepiR0v83qUyJevgAPXgjvQuAb1sJjUnof0tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wnh6U5C4; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogjQYBlHHTVkkHlzP0h24jGfnRDl7LpP94kd4Hnj+8ZAj0Xvuhv8m8w5xuHcaZFjprghPxLuwIagp4SLLEoYkryBV0nsaxbeYDnFEY6TEDcuP5Ok5Rxhnu9bfSBWZiRtQ5tfP8BjnwQhbNJFtLJnvK9iQ661P1LDvl2k31jlcYlMTM6f0UMG+hUS7iYVPfKw/CM1aZkXZNmC7GbzO5//Vso78AX2sQxDn+66T6/pANjxeNTDEjTJhqxHApGUu2roSk1MyTcQxUdH6cc9j/KAqtwsYaDhZa04OHUJxRp5Z4iVMaPGNuNl3HmNzixIlaXiy+GnTddVmILY6OGxZcJzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=us7wQFOsOryuJcamWuwA22pfnzJeYuv1V+XhQJV2HMw=;
 b=bo1K+8O5y4auCIsTZSyLA/rHmJFysz2O4UoFEyV6Xt5KJUvjlWtma2HUtun4urlk8PWiboNZjS/Oy0acyuUhAFukYjiPa/QTaVglIB9C+7xR23iOggR6NzprJSNabdIr1UwehQqDvw94poUmaeuv6I9nIN8AhMC94fceHPxGa8W3GliIrfULcZZziG+cbv65eSF5A3yFV3i5phZjYek0c8BU6gwtzzT7jB2J9YATen9e2Z+65Dm6TgWWauK+v9USYInzrhVZqxYY+cfMXPwcUzLLRm6ITXvmu/11QFKn1YtvWY6tHFLriTc9mNIZsPGK3peR+o3zyl83TyVSIqWFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us7wQFOsOryuJcamWuwA22pfnzJeYuv1V+XhQJV2HMw=;
 b=Wnh6U5C45gmWTJtu3FTWjBLqJaIWhriWgcuF+XfW38m+Wrqs2s7ETMEJyNBMMu3b4hvZ1n+L0IFE8nG+zxjEpCZPt5DzgAeWnqliOrPzhu8Hys6hJ6ut80KmreNXjytxCwKaXudIWgpqOc1k4cn/pQfItnP7KVeCeOogIjxNcYghjOSHTzgkYJAPfjg4WiCEC/qvBPsVfuEwly5LvqU/tFJovgkd6oV3HZPfd8K4M8crCpBeA1+iOibmtXknFUlXbcCZbr/sfZyrVU4yYHOpfLDg7aaRjpWOqWHP0Kmlwm6xW02ZsLlIM//MXS/Tfk76+E3QT5I4WBgJmL5ZTIVF2w==
Received: from MN2PR18CA0017.namprd18.prod.outlook.com (2603:10b6:208:23c::22)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 22:30:47 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::65) by MN2PR18CA0017.outlook.office365.com
 (2603:10b6:208:23c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 22:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 22:30:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Jun
 2024 15:30:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Jun
 2024 15:30:20 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 11 Jun
 2024 15:30:19 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
CC: <shravankr@nvidia.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH v1] EDAC/bluefield - fix potential integer overflow
Date: Tue, 11 Jun 2024 18:30:17 -0400
Message-ID: <20240611223017.30988-1-davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ba8f33-15ed-4747-781c-08dc8a662379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|82310400018|36860700005|376006|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9EWo8nmeE3SZlWSHbuFY62+OdLpqRGyYLcaQw8Fm45CChIN4JA+i68/SJAay?=
 =?us-ascii?Q?5CZMN8RcYwXg6ew5a6L/o+VpJFZWf4Gr7Okn5zkGQjQnYBHdX3vv/XwzRk9Y?=
 =?us-ascii?Q?7U5bXxHeODhVNBvsuJMz0V0+F5o/tnbV65QBj4wLJx7Vg5LGMmz71pYRgV2s?=
 =?us-ascii?Q?fCnzYMv8sw7RrMNcaEqslroGcJGAwiO7OvCxpHuk1fkoUxd4vxDbe7LJ5AA8?=
 =?us-ascii?Q?sMhrKa5b4GPiqytzivHRiiIRMc3hGag8AKNWhrNsMFmR7RK1p71XRFt48ItT?=
 =?us-ascii?Q?3hHQgncnxMdhw4LQHNyAnXNOv8Xki6+g3CpUZY1CTy+pi2DfBoDobyD2xNIo?=
 =?us-ascii?Q?GNyA1Eg8JG4NpKG76p3EZwLToOOrXfAGmirav0UEcVUgl6eUHtbmfmygJ/Em?=
 =?us-ascii?Q?s51uSOD6VwjslAC+4Ee637BgiEi1jU4m3g+iFyPAbhgxPa5QBboI5/QA057c?=
 =?us-ascii?Q?U0f0Sk8TlbDnKOBK9ijF94JVhBhR4aGBUdWMlwc5fsIp6nOJ+avVZPSoD53z?=
 =?us-ascii?Q?TACyUQ6/Lne8v372N1C0u5LmMJqF8LKMb7YObHjdJAo297aPshJdR/CLgkt/?=
 =?us-ascii?Q?D9A6BFI8qZ/uKe0jgY4Ki0+gTpguy3ng00Qc2CpJlq64VdQVnnpADaQNOkD+?=
 =?us-ascii?Q?ElyH/ZkCXwQ0/WWdk/TGRBhO6tLnaFym61LOTfqQlvcc3vP/2FB9uQ+//qbL?=
 =?us-ascii?Q?+5q956tOcxhVHe3K7h/7VbigIoul7hwSE1n5Xiaf2EUlZby8Skc1AkA9F3NZ?=
 =?us-ascii?Q?uNVLaeIO1dC3HVBmRnd70GcQdGlvhQnQVbtxNLYs6CcNg3fvnyPiaReUJztf?=
 =?us-ascii?Q?SrVPQcyHPjF3+t3P8BSYbSLiE9+A8Uth5/Qbb2Y4022JtmR4jsyIsS/p2J6Z?=
 =?us-ascii?Q?mP2anMOujkYxkgz/pRLJoYY6sPH6BVvsrrYVebpidvOJjHOr1RtN+7pLqBwE?=
 =?us-ascii?Q?NOiJKhkQ0O66WPDtHtnFKpBgfKKFDlkj7aVgwwfeRfJgCZxGS4J7T/mQWWM6?=
 =?us-ascii?Q?RjYQs6kIlqNrnNBPnxOH0F+zu4xq1j2JjdxmMH8vriUqFV42yr90BgeXrDpj?=
 =?us-ascii?Q?VlpJ59dvADAUHXeCf7VnIZ62DRkq4Tecfs8bzOsfnfhs/VwKP8DIwINX9AXy?=
 =?us-ascii?Q?hMQFSnRKalqYE+QSG1NV3JmaY3qF3Zyt21IN/gm72ZAbReKQV054avsJq7ET?=
 =?us-ascii?Q?hW5NeiO0g4h/fn9zWo3vFGF5jWZS8LdhY5Ka6yS7llPYrgq0G2oGuz6LLBM+?=
 =?us-ascii?Q?CjbXGWar9TLQL9lKPQbo45LlKR+Ga5vB2siTAlLNOTaCuyH4RrVETNlOx6Sl?=
 =?us-ascii?Q?9PHT00L90xJ1EoZmMVilRqVYLo2D9CJGVdBJ01wF/z9BdwxAOiIWeXsXb6Ei?=
 =?us-ascii?Q?UGpemNYaFGuJ66bnRQSD4j/cEAx5ka+Ea/jmKHSWIbgHFazioA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 22:30:46.4196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ba8f33-15ed-4747-781c-08dc8a662379
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658

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


