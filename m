Return-Path: <linux-edac+bounces-5351-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D90C38C4A
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 02:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E47188C929
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 01:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031E3225A3B;
	Thu,  6 Nov 2025 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kpYwou+8"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D511EF36E;
	Thu,  6 Nov 2025 01:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394266; cv=fail; b=TnnA3cGQoL49lkJ7u9fWKUVgiGiYUsM/zTpwnhb1Lmahn6ONdjQCVrkucd7XIc5x/W/8AI/kRxMmfNROv9ach1XT8IjKr1KNp/X5kVknVGAy8R1IJ1dq+jVzbE6xGdEHmBqhGxJK8jYCwDgtuyvLav/iw/6u3mTJHnNx6tTb2hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394266; c=relaxed/simple;
	bh=4AhKb57wrn2SWB0LQVMiAc2qfK0KIEmUM+QpSj1LLkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O2WrVTHIL8Hs73o0/HlEuvI6JuOFr2vpZRNbCi+jH7modzRjpDF7NWS8xPO3q9V4gIk9YXaNKRPkt6px3feNvNdK4D5nc8o88gF6hyqH35Wq6KEwN4ukwgaLRwc2d1kpRVf73CjSYZPJsSi/mRRbu8091BZ6zuK/LoFfLIKj6XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kpYwou+8; arc=fail smtp.client-ip=52.101.52.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXrQ91PJT0ik9PkvMm5oPon0bUPk9Kjeqh9AuCXh4oDN6Bh/aEr1mTA5X01rqIOFa0we4nRvkWwhsD3HKxP7LmBDwY4TPqe61y+4NRopHp8apzQc/wL2ZiLwlyOHqJJl01hFxKJFyBDz8aXoquJ/xWU750b44y6bFYMMx5aqXAHpn+yvgslkZkFSH3MNxYVZZjdRZJw7lm0I4oor3Pa9bwmn2O3AuGFWj/Ec0v1efoE+JayhYBYbSGqtcJ3KKbOWl9C7J8zbzis7SjqEGnRIP1RjSpmkYurp3NbhmNYRpIJncRD4QsRN9BCiIA76nLn1aAQoqldodWmGON74ixknfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSPfemeHc//fW3JPbTuePU9LPktU7QwBvRzFY08aGc4=;
 b=QItm+8CO3B1YxKSEaG7X+loLRDU0VvTcw8OwPD3YuqFhwNCBqk7qBm9A4YMG3ohaJLk/Kpdzgv3VMU3LrB0rI/7jaQsDOWZGVhFbbtA5twFJySZinM0S4ggqL3INXYKvSe1HVsWFZs5Rv61LLQ2C/U+Z5cG3wb+VBP3t0sBBtWBlZwBcbz/F3JZhKBWM5AMBlfOTWjM8aMhE5b8r3FKfaIrYkb9aiBhY5o6//l+tc4i/H6ZeCVa8YTGgIlcG9zf7lUeP4UwWpku+dGGCTPuu1ZZxzjPF+AiQvblo1nQXC90MEgbEAKlhBdbF/TWvlJgDAljkvb5MMffQ6GXjJWPzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSPfemeHc//fW3JPbTuePU9LPktU7QwBvRzFY08aGc4=;
 b=kpYwou+8Wb6tTIM4wN46Ui84Y5761YattFtliRLXuhH7UT8P/zSSzqtkxme3GLTw8nKVxUt3B1DtCxVl81bUf+QsCFIE56wtrncpuPi2rqFB0bgLgcJuODIlVB8fW/ZDt8nouys+gtk3KI3WYqpUZSSpjTGlGRdBVefV6TT7mf4=
Received: from BY5PR20CA0006.namprd20.prod.outlook.com (2603:10b6:a03:1f4::19)
 by IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 01:57:41 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::29) by BY5PR20CA0006.outlook.office365.com
 (2603:10b6:a03:1f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Thu, 6
 Nov 2025 01:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 01:57:40 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 5 Nov 2025 17:57:37 -0800
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <bp@alien8.de>, <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
	<chenhuacai@kernel.org>, <mchehab+huawei@kernel.org>,
	<yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH v2 0/3] Cleanups in amd64_edac and removal of legacy EDAC sysfs interface
Date: Thu, 6 Nov 2025 01:54:43 +0000
Message-ID: <20251106015727.1987246-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|IA1PR12MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b55fe7-101a-49b6-7a63-08de1cd7de6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CnAg28K1esBD1vGrQmzL4hqvRduohOOno49PepSTjPvLsfPSNqt5FvFO5xtf?=
 =?us-ascii?Q?yuoyRb0Z3Zos2DKCDZ8+j90dednytSfRk1IjnGTijN4WeiCLoofq4PEm1paS?=
 =?us-ascii?Q?tuynhhwqSSbwEhGZsjdsIxcapkLv2u71PxQiQmP9zeRbLqVmgV3XXDqOpvvi?=
 =?us-ascii?Q?snNwNUQuvPq8gg8SD6eXOeHoIqfPigp9mrJfjtM/a76O4QUfgZNGoNS1B41k?=
 =?us-ascii?Q?f0H4JLzj4+nGnF+x7OMWl9IJVU/hRAQhkerk+gTiipCS8XVJndQ7/J0IR09y?=
 =?us-ascii?Q?9FNzfJg5DgnHP8yBCQgOZk4w6dSgoJWpZ44FPsIlbeHb6CvU9iC9gUBmXcmF?=
 =?us-ascii?Q?Nh6WuDTfBUQOiSsMQPJ+52XC2SvKRC5qW6mbDjiUqo5iX0ICYC3GKRZ9AbSP?=
 =?us-ascii?Q?cHgVum6DAWQmaZEfz9Xt4jyg0I1V+UV35pP6nu6hKN8rzwdxEaWp+c7fHirV?=
 =?us-ascii?Q?yGJ+YxYTCfd7vqH1eQHWHr2Gx9jWwOXieoB5JuOm88Qc/BjB+KExymms/WDn?=
 =?us-ascii?Q?JVb3ZfOMvgJaHgdcWsZcEhoWJXx/Hq7l5Vv6wkugnB50e679uGoiz193jgby?=
 =?us-ascii?Q?NKkN8KKrpNb0JVjYs1gebVpVKTFKm0Ytw3o8X7hTsGUmY/pHF8qwHm9FbCeh?=
 =?us-ascii?Q?DXCPcBZvjpUqlf0urylqdEF6lk5B7DopR1xKLYn2I2qgcnen37hH2GKG49Ws?=
 =?us-ascii?Q?u3flNDhxRP9utaB+6RMdoKvl9DAmpjzmDUBOmCqWOhmyLt4mXOclQh+vcnOs?=
 =?us-ascii?Q?BR4JQivucnxBCwrLPbZkTcuEIoH7MVbCP3dJkB3UHmqI7chKkNlfJfFS3f/d?=
 =?us-ascii?Q?P0OIJLLRQ4Halv6N7nIc86i+9HSe06EaM0x/vuAd6cOpYBWiz61GB7L88czv?=
 =?us-ascii?Q?r0tzZOhpU16Atk88DISFvEy3/8MEg9ZQM7EHnTvJWpfBNOjurvs1pRdZHoRJ?=
 =?us-ascii?Q?pwfomA+IMjynkf+NUsbfxmhiUxP7t5NTQQCNcpZIqTA6mtegDH9loxnVw9B+?=
 =?us-ascii?Q?i8HZykBrjszFMQfMuERsztDsX8QNio71Crxn9qo5DSm51nPJNfVpH+gMFOAF?=
 =?us-ascii?Q?wZPXA604TTkoVZCKKKCGwJ71RG/Knnbr4EhpXeVzcY6UWpxMeJZhymK0a1i5?=
 =?us-ascii?Q?CsMI01xzP0nP105sTWhTifG7EBw9NUrd7QXpXkk2qbBR4Rw0ZxADKiYM+lk1?=
 =?us-ascii?Q?d319Pw9DSpsUhBNtfixudQSNLgtxw8kG/dFC9Rvq1aL6F5h92uBdoB+koydi?=
 =?us-ascii?Q?zUUMMbBBvEUghLaNC2nY+RJfvtyYydhcKjWcGMDQN3qrTtgqPpcdfBWAZMSr?=
 =?us-ascii?Q?U1Bn0VpVeXNMAa7yGJb/s2VK7wqJ2sqmoRPhFp3jcDYlkaSaaD52aQTcyB4q?=
 =?us-ascii?Q?H50/PVx3MoLbqy7Au47T7NghUUc+VqpmT3XnfJXCT63Z6YLxrudYN8RmpAsj?=
 =?us-ascii?Q?OVlOmdxnJSiCCRjn6Xz+rm1klnbeutX/fCTGyC8S9yJ01lcTKfMvCuL+IQ9k?=
 =?us-ascii?Q?W49Zel9zSUEEpA8seWvAq+0k4oczKI5qEJq2+WSvG1HTjjCRWKaNgIijV6Gi?=
 =?us-ascii?Q?Qe8CjzgNDoOGQl0/3aSDLa6fkS/pVZm98oHy6RYq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 01:57:40.7179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b55fe7-101a-49b6-7a63-08de1cd7de6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9529

This patchset undertakes some cleanups in the amd64_edac module and
removes the legacy EDAC sysfs interface since it has been obsolete for
more than a decade.

The first patch removes explicit assignment of the ctl_name string and
instead generates it at runtime using scnprintf.

The second patch removes the NUM_CONTROLLERS macro and instead uses the
max_mcs variable to determine the size of chipselect array.

The third patch removes the old EDAC sysfs interface.

NOTE:
These cleanups were earlier submitted as part of the set adding EDAC
support for AMD's newer Family 1Ah-based SOCs.[1] However, since the
support patches were critical to enabling EDAC on newer AMD SOCs and
since these cleanups were still under review, the set was split up.

[1]: https://lore.kernel.org/all/20250909185748.1621098-1-avadhut.naik@amd.com/

Changes in v2:
 - Drop the patch that set zn_regs_v2 flag for all SOCs based on Family
1Ah and later.
 - Change MAX_CTL_NAMELEN macro from 20 to 19.
 - Modify commit message of the second patch per feedback received.
 - Skip deprecation and just remove the old EDAC sysfs interface.

Links:
v1: https://lore.kernel.org/all/20251013173632.1449366-1-avadhut.naik@amd.com/

Avadhut Naik (3):
  EDAC/amd64: Generate ctl_name string at runtime
  EDAC/amd64: Remove NUM_CONTROLLERS macro
  edac: Remove the legacy EDAC sysfs interface

 Documentation/admin-guide/RAS/main.rst     | 142 +-------
 arch/loongarch/configs/loongson3_defconfig |   1 -
 drivers/edac/Kconfig                       |   8 -
 drivers/edac/amd64_edac.c                  |  61 +---
 drivers/edac/amd64_edac.h                  |   7 +-
 drivers/edac/edac_mc_sysfs.c               | 404 ---------------------
 6 files changed, 22 insertions(+), 601 deletions(-)


base-commit: d05ab93a9183520b2a6965765e14a3e6bdf01f90
-- 
2.43.0


