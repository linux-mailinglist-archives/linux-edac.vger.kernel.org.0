Return-Path: <linux-edac+bounces-1089-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9998CD7E4
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635611F22FF1
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AF7171C2;
	Thu, 23 May 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cysF00yW"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F6F14A84;
	Thu, 23 May 2024 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479822; cv=fail; b=PxJy1+isfdKk+JHwLcixeSAr5mv7LuFSRuGfnMRjGa8AC14lk50AOiHRKK6IJDVOdeLGa8RQoq8K7Zp/FIrqwlYbJ+S/E2fak3PL0aTeUc/9zA4i9dbQQOxRPLViuufEz0XCzS+MD4fSEANHtGhsGSLUH0smLPrOMCPDr0JR5bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479822; c=relaxed/simple;
	bh=OV9MrGCiWxOCocyOdh4M5yQADPNhOhiDbq2sH67M7FI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FfsRXdAx1nZkaVSLfkIoXD8egfuz3GjZiagfIB9SzlwgRspxip9/YTMLU8rXZjhZgccXgZaCmfccE5m/2DzbuczWuO8EgGtIYe9+kiA64uAt2Mrt0gLmeRGliATOaSCSRLS832fvYlKDt4RXZwX+HVaYdrtmTMB4qGBWOLAIwRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cysF00yW; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlJt8mBGUusDwTHoHR7s+QwfrZX/qbHYt+iYFrHjK9cQj8M2+/+hgorrIZXDW0wVZaipUtXoYwcmf7/csI6TGCVuHjDsgkQ5IvqqoBVs5jb22bQ2PFc2QRrIHZHJgTni5TcEAedzRH7zeaGVr7NO/4VPdiOGlJ06GGR5CeGv65GCV0Y69a6bAWifBLuCqxtf0Szyk9L8luzQnbhQjCmvVDXCPM/xRD75oiyjWSOaMn4LDgfg8rZu2s0bP58nCzwkxh6R1hu50TI8JHXh3prytkK4zjakF4BtFiMoS+jkEa/nEGa4ZmoPdqX8ueM9aDdF4ufpelxzHTwzw0DCgGmjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypceBY70vMojKgfa0qyEunfUeRCnKRQWMyLvif/El2w=;
 b=LqO4YG29pcmZla+nHzc4tyiyJ//Phg9VLyyKGb1p1wZB9+QlyQ6iLckSsRUF75OpqwOcfP8u689+yvo4w7ZnzVsZHqgi+ZZZfkJYbZYGQupbJSk9c/KpVgzXuduYDEm4ZP5kyQnguUL4SI7MfyfgkS3XSLl0z1DCMADC4xcMgiTtVKC2LZyAwqG2ik6t/jEw+YN/H0VdykoCU3dtWByq3K5zaQ7PwI44FHeSteT9E9mveNjR0StF9uamSlqB/mfpLglVLUQAYh7z1rqw/MpB4Xy6902KPLBYSy+s8dBGUMwMGwfCKwf7WVzq12npEbeVTcB7SpbmCXCCnpN6v7xu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypceBY70vMojKgfa0qyEunfUeRCnKRQWMyLvif/El2w=;
 b=cysF00yWksobmzgPp5+5DbCjZXqlPTe7uUzNiNe3LrIHR+z5ljpQLeTuzJtfqYsHF2cOgii1/bItr4QMtqx6BLkRLqfVXmi8NpRFGD2CTeX8AOQCc36Lc55pTEKypdhme45/20XYwlEShWHbEFFHdF+nTUn8Gp/PwFJI3DJrYyk=
Received: from BN0PR08CA0012.namprd08.prod.outlook.com (2603:10b6:408:142::34)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 15:56:56 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::f4) by BN0PR08CA0012.outlook.office365.com
 (2603:10b6:408:142::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Thu, 23 May 2024 15:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 15:56:56 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 10:56:55 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 0/9] AMD MCA interrupts rework
Date: Thu, 23 May 2024 10:56:32 -0500
Message-ID: <20240523155641.2805411-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a12158-3abb-4192-13c6-08dc7b40f8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3VUYU0/ApepZ6n52U/SmZ2COda863QmcHJTz6YNNdIKZ4Drje0fdmVpIYusI?=
 =?us-ascii?Q?K8asjH4+LHT6NvmMaz/lKcCKLeVWs7OC5eeMXL6PHUyierF6GGXS7TzW4cCH?=
 =?us-ascii?Q?Jcig+WM0dD0C/lEVWOqBfizbxqpZQoerrUDW5KUh+mm2yljgS6o0v52/Vbua?=
 =?us-ascii?Q?NIIriwSP+EdzK0ik9fD8mAbVcwqy2BKVCLW+1MfKdBoSqmrJ729ltSNmZHDe?=
 =?us-ascii?Q?aLfcmeOG6caqyE9DHXSKJGCHSggDFbU7ghyv4c2mEmRZb037SM/JZ6Z2rYrI?=
 =?us-ascii?Q?DR/0fAKSyRr+k52x73ksQhGl4Os2JuzgCqEDAxr3vRRexpM2MgQGQaij7aPf?=
 =?us-ascii?Q?57nix8f5LwwsrOaQTWVTgZ7BgJF8whqPrw/D85ISy1zwWw8SD0f/R6FxfnOO?=
 =?us-ascii?Q?cmYS+FaPDsFDvLoD34adaD9L/NCApz2+g1u+v0KoOUG8/T0rZyaj7WHfyRnF?=
 =?us-ascii?Q?H/lj2MknWc7xZD07Uq+P2d3qAQtcRdoZ1Abag006t5aJJiD1+bARnOsXCT5g?=
 =?us-ascii?Q?2lWXuHTmmr+4qy96DF6LAG6u4EW+sqvjs98r0p31kIld0AzAHyj+j0SU/D1X?=
 =?us-ascii?Q?1T2f1STJjSTjYhYtW5fbzyPGjIoInlKqtzxoxurUWwu4xqUz+kygyrKIH+En?=
 =?us-ascii?Q?G/GxZacJlPCk47CdBJ9fYiWuiUf1qg6uV15JgEpdrUuN18gP6/2loxp6Plee?=
 =?us-ascii?Q?YX8sG/QdnqrETUngxozi5ogFqbW3PfLOJw44rBofSuR0tSpDhVtB/zRDCMQ8?=
 =?us-ascii?Q?GRj3Y/4z1cwq8osV9kyxi1DbbI7qD0xlKEul7TIZsqp2nYX8790SDez5UTtE?=
 =?us-ascii?Q?H08R3d5BQayhdiYHZge3hUUHn0R4/y6FLqwmU+3QKfbLMlhxZWkUJjuY+wjH?=
 =?us-ascii?Q?cQg/svR7tYASuD0WyUC4Kt1q9Q+kM1iOYXope5kwAQjT1Cf+zQwG+ncyWoN8?=
 =?us-ascii?Q?hs7U99zSzR/lB6+DtoFcMtwKE8lyUV96Y4rBQcFdp8pehcT5xjPKK7fnrhgd?=
 =?us-ascii?Q?H0gtzUw4ztf4OCYBc+0Xvq5Mw3XMLU77gV0cwLv4PXxECJzAQBIAApiWoeRT?=
 =?us-ascii?Q?Kx+O/E+vB/SPqjlv3kMMDRoe0+0nY46199eYycp/ZT7fIH0tzkt49EliS+XI?=
 =?us-ascii?Q?sMaOYJao/vrG+WU8Txnys0pkMnI+WVoe4SsOr5cIDuhYVB6DWg44iNw/XX0N?=
 =?us-ascii?Q?g9hP2BTkq3/7Flp+P30fjZhaZtZ+oHGjyH0NL3Q0PA5SMX05tbajN0mTQS1T?=
 =?us-ascii?Q?H/uW/9zx9K96e4QmXVAcyEM4jjFZiaxMyszQXqUK43zxWAhq62Tjz1z4SFU8?=
 =?us-ascii?Q?IFfNhX0R4Gs8qSN6uVEwG8sp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:56:56.2791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a12158-3abb-4192-13c6-08dc7b40f8df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008

Hi all,

This set unifies the AMD MCA interrupt handlers with common MCA code.
The goal is to avoid duplicating functionality like reading and clearing
MCA banks.

Patches 1-3 are minor changes for issues found during testing.

Patches 4-9 are revised work of patches 6-12 from the following set:
https://lkml.kernel.org/r/20240404151359.47970-1-yazen.ghannam@amd.com

In addition to addressing review comments, I tried to reduce the amount
of refactoring to only what is functionally needed for fixes and
features. I still want to do a broader clean up, but I think that can
come later.

Patch 7 has a minor merge conflict with the following set:
https://lkml.kernel.org/r/20240521125434.1555845-1-yazen.ghannam@amd.com

The sets do not depend on each other, so I thought to keep them
separate. But I can rebase this one on the other, if needed.

Thanks,
Yazen

Yazen Ghannam (9):
  x86/mce/inject: Only write MCA_MISC with user-set value
  x86/mce: Remove unused variable and return value in
    machine_check_poll()
  x86/mce: Increment MCP count only for timer calls
  x86/mce: Move machine_check_poll() status checks to helper functions
  x86/mce: Skip AMD threshold init if no threshold banks found
  x86/mce: Unify AMD THR handler with MCA Polling
  x86/mce: Unify AMD DFR handler with MCA Polling
  x86/mce/amd: Enable interrupt vectors once per-CPU on SMCA systems
  x86/mce/amd: Support SMCA Corrected Error Interrupt

 arch/x86/include/asm/mce.h         |   3 +-
 arch/x86/kernel/cpu/mce/amd.c      | 274 +++++++++--------------------
 arch/x86/kernel/cpu/mce/core.c     | 143 +++++++++------
 arch/x86/kernel/cpu/mce/inject.c   |   8 +-
 arch/x86/kernel/cpu/mce/internal.h |   7 +-
 5 files changed, 186 insertions(+), 249 deletions(-)


base-commit: 108c6494bdf1dfeaefc0a506e2f471aa92fafdd6
-- 
2.34.1


