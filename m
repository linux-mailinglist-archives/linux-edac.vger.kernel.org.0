Return-Path: <linux-edac+bounces-1750-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B819652F0
	for <lists+linux-edac@lfdr.de>; Fri, 30 Aug 2024 00:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9511F24386
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 22:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCB318E341;
	Thu, 29 Aug 2024 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fVFyzJDi"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47718CC13;
	Thu, 29 Aug 2024 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970764; cv=fail; b=YYCHaux8lalGfo/y82KT29tRv3P9UkcR+a9PU1/o++65iBw9HQhgUOqy/OKUQlMev9EocCtdknDNUDwPRwIdp0/e26pSsoi9T6XQzbgcgwkSpKMevQzdZepld4n32jwL9/tQNckM1S/Y3wfSZJwNdmQ/DexrJlCRGlkITPMpPNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970764; c=relaxed/simple;
	bh=kP1fdtEMH53w6YDQFnfPklj+DdopgZdfJvGtMctVk2w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hrrA6G9NKrkmmzeQhpwa7zXzVWlmyqub3BPyCccovLDeJQ3w6u1Qhd/d1vIJUId3bAZf49eC9HVShh6yJVS/i6qPgdlR/7VanTpIAcLYdE0o3K6OAg0zkR5w8fCcxYnIqO84dPYf8V++iGf+CQm9ngWlWpM/XXO+0Ve3D1wC0/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fVFyzJDi; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxVn4Rgs/bGXb/q7LOV2o6vjV9GH4581hEOea8jWLwxlWMUSykw201/KE/jr0LuC3XvR/lcgyL88/1O01WeWmJ14TEFgVKpPUdrjWAYJNnTfDYVVM8pUeM8CT+m4+YyXwpWGX6PUvQuEOB54pr46EhNQ8Lpi1hUELGfahU/00P4TT4GIFtCxL3G2BtjbmRTSMu77Wia3twH3qwdaWGd+Zm8Xe0+FKZjlsbGlBPCfoenoFim8g2mNrCvsSf+27TU3424B0R1XC2ddtN8fWPZTheRgOh08f36eDXO1ui16FnBXlUzdCXbuhjBvCjmdgJAIc/krXlRi2l2sryQzV1othw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghmB5VWDWdW0jXpJUncDCNP1fmSk01rd/w4D/J05Its=;
 b=iwwVoCzXL9ZMrbhLQgSvu58uxFNardf5SlhS+QYGP46ykrqs3jJS90rgpYHhSxEdcuPw1KOkZmpUH5xBkZtF/vWQhdHYlTyYutN1XP1RSf0PTItr2DMvuKcITa4qJk3nl/Pc4Fzr5voocan987ir7yJAosX2vrfHJ+BQoD2dqTRQGQqN1TrY3Biyvrg+w1FEnJe38Md4KYvbAeyeMofVG4gfh1ErCi3CBPzTM9kVwP4E/5tT9i+L2COMUNvkTWO66qKG2IZIftCJSmgfQs6IfCNlfi8ZZ+VvGLe2afbYlqLQjAyZf+fnNZtUhxoKVDuoBUVi+WPh6sZ9qfT+gsWO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghmB5VWDWdW0jXpJUncDCNP1fmSk01rd/w4D/J05Its=;
 b=fVFyzJDia7MXj2Mm/Ohx1b/x9yu/9DP3VC5IaVVtHQMb9SwoHgDpOku8YzLYNA/hTd7nRxQYiO+7qMBKh4PMtKjclfOQvsEsN2qa/ho5M/sV1phznZOu7cbnDNVwNtmVtMcQ2esnleYQjg9kZzECo9uvlc30ladRL1McWkNOCfw=
Received: from BN0PR02CA0007.namprd02.prod.outlook.com (2603:10b6:408:e4::12)
 by DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 22:32:38 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::f8) by BN0PR02CA0007.outlook.office365.com
 (2603:10b6:408:e4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Thu, 29 Aug 2024 22:32:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:32:38 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 17:32:37 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, <boris.ostrovsky@oracle.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [RFC PATCH v2 0/2] CPU offlining with non-core MCA banks
Date: Thu, 29 Aug 2024 17:32:23 -0500
Message-ID: <20240829223225.223639-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS0PR12MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7b9444-42a1-40b3-4a2a-08dcc87a7cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CqSW4Ln3ndcX64X2/D4SfDtqjTnHznyHJKhdX76Lgxd1suxRcFu+fr17ll9G?=
 =?us-ascii?Q?DX5keEZmBRIDtvX92AFnr8ZVgaIMHMQRQi2M2MeWrOK1J+TlGCnD1eiWUVul?=
 =?us-ascii?Q?Hb/M0U0qNZ3g5HUy3aUSp4rFrRCVSDV8GMsRAPAZqGZ5twDFUMzDSQKw6JNH?=
 =?us-ascii?Q?6FAiSFccyt4jCqeIGmLTXd621kIcdioQ/HymXdTcjvcMK5vau8tc3bo/skXc?=
 =?us-ascii?Q?16gzufiUCPS2E55PLPmbgrWvwoID83zVzV8mFeHn/CB1dvggcjoHUWKEye9F?=
 =?us-ascii?Q?ftI5VFC2tJJ0/lQkQF5Ld6mJmsdbLVPVpLhsgF/zGfP97PiW87oyJrParEMS?=
 =?us-ascii?Q?8R0Nop+A0Y2JiG7WiQ2uSLapPsF7fxjvZvErgpO+++daHTt0hN1WXeE1w3sZ?=
 =?us-ascii?Q?URZXJw6aIYgfCrD/Htnap04xZLf9XpNM1snH17mCpi5vCQ2nEzO6/pqFxPpe?=
 =?us-ascii?Q?S4JJH2batrmVJZSnSJ4t6xANqbuEfSGUa3HkP+e72aTjERwASn6mkFvSZbgZ?=
 =?us-ascii?Q?qOv9uz4yJKTT2qXlHMK4qjlj3yEdD67GZY/aau8uAYAIvrIM8tmNJlx/FlNz?=
 =?us-ascii?Q?2A1QQgw7tVcdOy7BkjE2g8o2ZwcuQxlhPCsW12kJ5oEu6o0OQoKe1CuOVruO?=
 =?us-ascii?Q?n7wxbSeA+7RviiY4MvDlqwRhCxuoTlvrkLnhiCqKAPsVmlmQQxGmLS1EnkN6?=
 =?us-ascii?Q?qDMcGCEcWBs01IgqbRAhO8iYwMf5YPyCK4FY2RMXLNhwfz/wRthlL1E1EO4Z?=
 =?us-ascii?Q?xmY2Im+hHMj7zFFvn/dLLKd2p01huAm5WdbnWfLZvQqc0HnOSo/6vAoUNhGs?=
 =?us-ascii?Q?LBE/S4xLu73CWGpaXzFrpG9vkWXvan572BV5dFJ0RmpUtLTaNXdyOwF1JgbS?=
 =?us-ascii?Q?COYKgY6EcoORm36AWXz/DzAH+Zt/+4h5TqNII9z+IgFctn3fkyQ12y+nOpfV?=
 =?us-ascii?Q?flJjxQ+TJqYamXHO5h1VuNbP6ZzNJcaVgFt0PBOfZUkMg3hFfazXGIc0NA6V?=
 =?us-ascii?Q?hSef45dSZCGOoUojMMUR4f0Q7CYnWdJin3FyVdNHLKl0gYPGIwCr25d4naCW?=
 =?us-ascii?Q?eKmeIcCKqI0PAsMmIKJmvfwihbo5hF85OG9tWw1YtIXJyr7Le9hCST9E2efH?=
 =?us-ascii?Q?Z8/mv1uUI6tDMYDlMm+PTVzOF1fUmGXBeUnslt4c7wfCZdC3DDDFp/iiBhzQ?=
 =?us-ascii?Q?47rBay6gtkg/3TRIglGzuEd39sQuDuOiFuaGT21UnDNZeF73nt1iD+Jsz1k9?=
 =?us-ascii?Q?09nw7wO6HxxcFkgk9p7rKUEczFhD7lIG8yXsp+aL02AGWYYKe2bEAxSssFku?=
 =?us-ascii?Q?6xNstXs0IN/OhqiOgM1ksLF/A2jvQWryCfGW+gaL5g12zRD+Fq6S38KPUpeJ?=
 =?us-ascii?Q?0OtgG3iA2fVVeB4WJ4UvQASTJCkdR28kI/mdvkqG+l3VI/G5lw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:32:38.4400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7b9444-42a1-40b3-4a2a-08dcc87a7cde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680

Hi all,

The major change in this revision is to prevent the sysfs interface from
being created in the first place for CPUs that shouldn't be offlined.
This is a more direct solution to prevent users from bringing down CPUs.
And it shouldn't affect internal kernel hotplug flows.

Also, I've changed this set to RFC, because there are still open questions
about how to address this use case. Here are just a couple to start...

1) What if a user wants to offline a CPU, and they don't know or care
   about this restriction?

   Should this behavior be controlled by a kernel parameter? In this
   way, a system admin can enforce this policy without affecting the
   general user base.

2) Should this use case be generalized and indicated by the platform?
   Maybe a new flag in the ACPI MADT Processor Local APIC Structure?
   This would be set by firmware to inform the OS to not allow a logical
   CPU to be taken offline. Again, this could be enforced by a system
   admin by changing system BIOS/firmware settings.

Thanks,
Yazen

Link:
https://lkml.kernel.org/r/20240821140017.330105-1-yazen.ghannam@amd.com/

v1->v2:
* Change to RFC.
* Include new patch to adjust the number of MCA banks.
* Change solution to prevent the creation of "cpuX/online".

Yazen Ghannam (2):
  x86/mce: Set a more accurate value for mce_num_banks
  x86/mce: Prevent CPU offline for SMCA CPUs with non-core banks

 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/core.c | 22 +++++++++++++++++++++-
 arch/x86/kernel/setup.c        |  2 +-
 3 files changed, 24 insertions(+), 2 deletions(-)


base-commit: 793aa4bf192d0ad07cca001a596f955d121f5c10
-- 
2.34.1


