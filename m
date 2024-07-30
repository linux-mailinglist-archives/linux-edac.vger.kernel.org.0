Return-Path: <linux-edac+bounces-1592-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0127A942011
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 20:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8259A1F248DE
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 18:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B43A189B89;
	Tue, 30 Jul 2024 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ucnAKy94"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466A1AA3C6;
	Tue, 30 Jul 2024 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365659; cv=fail; b=eo0Ho9RKacA7WG0T/00KXrSILWIhkrD5N4hXZOmi2mS4Kwpv40mWa1wW4c3NTdPhzhRd6raJCtIwiIdDBvJ26qcW9xNy69IBcog3BfH97i/ppXBgLGh+/dq3Wd7eApXEb2+ZRGxXFHvAW/vG4UbdKoDu/janedhx8M8ZOLwsCDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365659; c=relaxed/simple;
	bh=Q0K4IwQlXAX0rsN6szKXM1RyMTy0vjjrSeMwP8XtPWE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QATMqWRBzQrZK4O0e0DJA7/Llht4/nXBodugwp7bOBrH2jPishKlmo2r98kPs4Ckdh4BeSoyWbhFeSoU1oTh1qgYQ3N0v668MEnS862/FHXM3fu7WzKxJ/0Z3uxpWBUaaLtvYyl+qpm2+JzjgU1eudB8MQ9BfdcCaDlLNFc+8Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ucnAKy94; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNszcNVV8cL4bZvqC60EhMI/6JSJbCMK+T+3VNPPBvYkRJbBG+vWr7MZd9z2CYpNcWeU6ml4huTyTP2ul1EYszZqkLVvRs2A8mQeMfqnYIXEmBqpG2l5Y5+W006GmBrb0apy/4VeuHbGQfqFSfVYexc0umCn5N+pnPW67pgGmrK2063nmAKDLXRf13hxbInD7YGiVokDcnNY2LJ8NAvS4p1kwBvGdTYmBXS0wfeip6L3f5/nGQSF0yzxOHKOgvFXcdpi/SMhD8OzT8GIuxOXod4Ax3yfhMni4B9859t7iPvT0N+pmpDRMd5/hM1hj0BCfF3CUzN5qgdGZB5lITq2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMtrEfp0NdsRRgS06mz/Xs0zSUynypwJuUmYPidt9YA=;
 b=qUszttUiZScqB0fu1jUbq7vwsM235JsUnVlqP39EGGI+dSzQjllmVrtW7od0Xg5aCX9AJtoUz2xxtUOt/Y7yeYLSkmWGdSfyhwo+A4Zk9+DVlceNyViiggxpM+ERiwdn5dJOiTSirJlT5dl2OQ6Au0Qb0dpkDDXzlWi9fNDPv1gbJ0Jljam8XBPHb5QEernl4b/fkGxEHRpIKicWUwlAB2Ui7tBDwCWi3KYkjhAQsuURBVx/AYNGX8yAV/vBtORirRgGuSFax6jrUgS64+jaNp/9FcbEbdB/CO57THYkko/rXdTTkWVlpLCgHSaG/zYHT1lW9k+4lRbUBRmc/U7jyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMtrEfp0NdsRRgS06mz/Xs0zSUynypwJuUmYPidt9YA=;
 b=ucnAKy94P9gjYFxlQS1mH9w6AWsIsw+ASeLZF7MyBLK0ONUOKFdl6kO4/ZgNvsfZTGFmx3d2h9eiP8jWdq58QhExVmL1bp5RHrKtSQqfwGJIFlmueu59fXKW+bhw9EEYBRlYO3oqwd2bw+g0pDlcu29LbdDgQ6NyMXS+osH/5j4=
Received: from CH0PR03CA0083.namprd03.prod.outlook.com (2603:10b6:610:cc::28)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Tue, 30 Jul
 2024 18:54:14 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::dd) by CH0PR03CA0083.outlook.office365.com
 (2603:10b6:610:cc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 18:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 18:54:13 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 13:54:12 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v3 0/4] MCE wrapper and support for new SMCA syndrome MSRs
Date: Tue, 30 Jul 2024 13:54:02 -0500
Message-ID: <20240730185406.3709876-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 608b56d0-26d7-4eb5-bd1a-08dcb0c90150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t2Q3PADq3vTXgV5v1elU5ObE1SL7UmHgxKM0oeIQrDGUpIjzvXMnhztZD8pp?=
 =?us-ascii?Q?oY24mPNeCaTaFBthYUHydWeC78iitkcKNhY1kRaTC47B+jfIHJim2FSshSXG?=
 =?us-ascii?Q?UG1IkU9IMwHieHgP7iKM1nPjuAZw2uuDFGDpmR/j1PS++nPBRYZr69FTw0PR?=
 =?us-ascii?Q?/S+JV9ccrj8qC5dECV5xcbpkN9vG+lusCgtb6sEVNBtJwoVRmLWxXeCPZh3w?=
 =?us-ascii?Q?xaZ+PmdME0/1S7SMTDurUUDWuIb4Q6ZRmeJdyFXIYvWn1oKsfRO3Qje7gLXx?=
 =?us-ascii?Q?3NSxwaER/YWDQOSm53MXHbOdyzpnVOJXkx1HnUEmoQgjG1KxkC8pHPrf0j2T?=
 =?us-ascii?Q?BJuoxhWlaNM7NTvarg0MtBwnJs/wRz2yEz5b8Pcs9qkU5Sn2Za9ta7Vr9NQc?=
 =?us-ascii?Q?Gs2Scqzn0e1a/et0d0QI/hZnHgT7ZR2boQHmRzEiO1PSIzxiEU7Esl4TPqch?=
 =?us-ascii?Q?C7aF9i9tCyW466CpE/ck0RJUiGHtOtEDnDnmtSSCt4YkdDmpxA/LJIkmaD7C?=
 =?us-ascii?Q?2lIM8UJg/5bbCVO8X9z7Arcx0YjB0RaTrXS1GWzXc0uH9PulypQgnu6JFGJ7?=
 =?us-ascii?Q?vJIYz9mu95M/+ohYN4D0rrdXcvPZNTWE0LUBCijgZ9EdZM5hmu90LVNkYQQu?=
 =?us-ascii?Q?861gDnBLGhhFdLgo4piNFx2PAs4sbP2rOymiv0cGjvFtWE/IUcgqefjRrzzt?=
 =?us-ascii?Q?j+jt6NcnZOYBva4o/XbgOBVRvBaByy9eYmCJHBmogIYMe2j6vxtgP7UNnrxM?=
 =?us-ascii?Q?+1g60rMSgw+M9BEFEqnwVsjYXOxmC4U4BVUGvoy0+lRhRo0d/DO3HZLoYVAd?=
 =?us-ascii?Q?YOlhAwRNtoVzVJyXJQlDgynskG6WUZJy+WoI7Zajv/MVQFsGvpZvNJ8M10i2?=
 =?us-ascii?Q?HUwQwFodMgq1w4YVnwicaaiKgzbPwGigYytCx6atUo+qU3JHH6ynSM5e+hMI?=
 =?us-ascii?Q?HtHJJBLN+IFKumEHTl9wTApwl2ELWpj5W1OiPV+gUexKHNJ6QyXXxgB4IPlx?=
 =?us-ascii?Q?LedEeet1jdOWcLJz65KK6D8t9dWGKxYpN4GsFdCZfor44dL8/RUqRDmJC+An?=
 =?us-ascii?Q?wtCShXBVT4v1ytLiSw4WhAzgdq1SzI3foNTA99NsPNvCkZ68qLz3PvWFBGcY?=
 =?us-ascii?Q?yVp5+grNaDiLx46bK/ulgenk1WM6GCiiLDuGJTpCw3qWE0fNfe/rsZM0VYd1?=
 =?us-ascii?Q?QZXRZoIBzYe4VfA+MAX4I+4mEkLXDskXrkiDjlgVscgIJ5CHYc7gp+SOCTsE?=
 =?us-ascii?Q?uY1KjJQ7og99l+iuH8Vna8su978uNjf4R7lf8yUoMgqMBFsLWZ62ZZvXTCYS?=
 =?us-ascii?Q?qq14wEWQjFr25PHCt/ZpwCp/VgbvR6zXoUrKQj5I0OTCKt1q+xT7WGauDz38?=
 =?us-ascii?Q?TT66zVVORry75HBlv3btdlzTHzZ0VGNhs7Lc9v1omzp/i0Wg/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 18:54:13.5970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 608b56d0-26d7-4eb5-bd1a-08dcb0c90150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688

This patchset adds a new wrapper for struct mce to prevent its bloating
and export vendor specific error information. Additionally, support is
also introduced for two new "syndrome" MSRs used in newer AMD Scalable
MCA (SMCA) systems. Also, a new "FRU Text in MCA" feature that uses these
new "syndrome" MSRs has been addded.

Patch 1 adds the new wrapper structure mce_hw_err for the struct mce
while also modifying the mce_record tracepoint to use the new wrapper.

Patch 2 adds support for the new "syndrome" registers. They are read/printed
wherever the existing MCA_SYND register is used.

Patch 3 updates the function that pulls MCA information from UEFI x86
Common Platform Error Records (CPERs) to handle systems that support the
new registers.

Patch 4 adds support to the AMD MCE decoder module to detect and use the
"FRU Text in MCA" feature which leverages the new registers.

NOTE:

This set was initially submitted as part of the larger MCA Updates set.

v1: https://lore.kernel.org/linux-edac/20231118193248.1296798-1-yazen.ghannam@amd.com/
v2: https://lore.kernel.org/linux-edac/20240404151359.47970-1-yazen.ghannam@amd.com/

However, since the MCA Updates set has been split up into smaller sets,
this set, going forward, will be submitted independently.

Having said that, this set set depends on and applies cleanly on top of
the below two sets.

[1] https://lore.kernel.org/linux-edac/20240521125434.1555845-1-yazen.ghannam@amd.com/
[2] https://lore.kernel.org/linux-edac/20240523155641.2805411-1-yazen.ghannam@amd.com/

Changes in v2:
 - Drop dependencies on sets [1] and [2] above and rebase on top of
   tip/master. 

Changes in v3:
 - Move wrapper changes required in mce_read_aux() and mce_no_way_out()
   from second patch to the first patch.
 - Modify commit messages for second and fourth patch per feedback
   received.
 - Add comments to explain purpose of the new wrapper structure.
 - Incorporate suggested touchup in the third patch.
 - Remove call to memset() for the frutext string in the fourth patch.
   Instead, just ensure that the string is NULL terminated.
 - Fix SoB chains on all patches to properly reflect the patch path.

Links:
v1: https://lore.kernel.org/linux-edac/20240530211620.1829453-1-avadhut.naik@amd.com/
v2: https://lore.kernel.org/linux-edac/20240625195624.2565741-1-avadhut.naik@amd.com/

Avadhut Naik (2):
  x86/mce: Add wrapper for struct mce to export vendor specific info
  x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers

Yazen Ghannam (2):
  x86/mce/apei: Handle variable register array size
  EDAC/mce_amd: Add support for FRU Text in MCA

 arch/x86/include/asm/mce.h              |  34 +++-
 arch/x86/include/uapi/asm/mce.h         |   3 +-
 arch/x86/kernel/cpu/mce/amd.c           |  33 ++--
 arch/x86/kernel/cpu/mce/apei.c          | 118 ++++++++++----
 arch/x86/kernel/cpu/mce/core.c          | 201 ++++++++++++++----------
 arch/x86/kernel/cpu/mce/dev-mcelog.c    |   2 +-
 arch/x86/kernel/cpu/mce/genpool.c       |  20 +--
 arch/x86/kernel/cpu/mce/inject.c        |   4 +-
 arch/x86/kernel/cpu/mce/internal.h      |   4 +-
 drivers/acpi/acpi_extlog.c              |   2 +-
 drivers/acpi/nfit/mce.c                 |   2 +-
 drivers/edac/i7core_edac.c              |   2 +-
 drivers/edac/igen6_edac.c               |   2 +-
 drivers/edac/mce_amd.c                  |  27 +++-
 drivers/edac/pnd2_edac.c                |   2 +-
 drivers/edac/sb_edac.c                  |   2 +-
 drivers/edac/skx_common.c               |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   2 +-
 drivers/ras/amd/fmpm.c                  |   2 +-
 drivers/ras/cec.c                       |   2 +-
 include/trace/events/mce.h              |  51 +++---
 21 files changed, 331 insertions(+), 186 deletions(-)


base-commit: dee974604f7870167161cbe51e8f3b9c2858de34
-- 
2.34.1


