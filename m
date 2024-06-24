Return-Path: <linux-edac+bounces-1361-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8EA9158C0
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 23:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6E628626D
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 21:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7ED1A0AFE;
	Mon, 24 Jun 2024 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FzPLxJmQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D281A08C8;
	Mon, 24 Jun 2024 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264026; cv=fail; b=VLSw2/jkZiF0VAUpEpWkY7iIMK/JR4XRIrZD+JeFl4wIp3pFyCRe/Llu59o2mvp7GXS+mQf4PdcPYdMqgFHn6B3XOZ3CtTcpO9D/SMBE99xHXcdcp53d6sTAz6NxgujeGAUGApc+2KQMgqhdZsgrvBY6t7cGlqgEbtsRn48A4fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264026; c=relaxed/simple;
	bh=S02imD3zSy/1F8OfZr5yx7ZcUM0XcMMAGH030rnPTJw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rQxwIy9Ra4N0esIrutlL55O1T/7nHjkn9zBjnVDN7Ic5K9Fp9jWGtn5+H0rq4Dqc2ponaJbky1P0/u7yut1Ynv5kdmOA7LDT59SS5Cvs4JuKN+fKJduSq7drSiSmEvWsxu+2z5sQnJNRDhvKiDWArnclWC5BwmgjT9TbcTlyDaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FzPLxJmQ; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3cJmsxBTZBNaWV3JHIa/vR63G2B5emw8OIUZ3pCRhj8MEAUY7TTm4yRt38mDqVPFoyruh+jxys3GhxJtNtfAKsXmRIDwNzZwbflpELJTf3UO9Bvfqtwy4SwUGaJtgrH3kQBc42uMVr1rjH61KGAT6n1V79aCarEinci5jT6vhY/9HwRyoKy43M3qNHG+xi8e9cHWym7q5sq+hthFQoCf9DGjOWbn+Ez1pYmprPqr4932LalCOQLJXUce/PTG5FUf3awboNdQ7Wfy+F8Oy4WnBEA/f4oAeEi/6F6QBzF8ZOjpDyJ07BlLEwICq4GXFyo97HhQ/2BXvIwxfSrr/7v4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsdP13MV9TEof5nqYAcwWQIcdFNNrnfsVraGnh5OhMY=;
 b=d5cpW7isUaQffwJRHiOoeQtxe2p1yqZUy8bRbYCiaB+oWpDNCul0w8oIO2wGIZ5gPeU+fUuaVgR9YRPCL3V5Z7kNzgj6O2Whis3DpoA0QJz4kaouvwl0lVhGfoAKMb+ZRdtyBDdg0q17kIjyBXIzPPk43mcwr1BNqh9wuHNdgl3cJq9DAIwQR2NMPWcM9CiUNCDklqa6CVo6GwLparo0jW4XMm2nDlL5DA8J0Uwsizukk5j68eu7vbRbc0yCfM94r2L1keWEDtPj47V11K8AeewnTy7mGwR6KlzEH7fERqByChgaFdP/9iS0d5rB3a1Bxq7vGSCai/8mpDar7QYkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsdP13MV9TEof5nqYAcwWQIcdFNNrnfsVraGnh5OhMY=;
 b=FzPLxJmQWGaOC9tqoDctWi68T37+mkW4TWw+iGUkPuxxwFwj7qdmgAsAweejia0D99az3o031QJO9D8WYdQmoKNPhwqx3bGAyL/2UqjsZI7+mP+9hQhWYwGVk4ARe3Rn6K2mJaomRNooH7VplFfw7iHf4nJtmq2SjRSfycYkBLQ=
Received: from SA0PR11CA0079.namprd11.prod.outlook.com (2603:10b6:806:d2::24)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 21:20:19 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::a6) by SA0PR11CA0079.outlook.office365.com
 (2603:10b6:806:d2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Mon, 24 Jun 2024 21:20:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 21:20:19 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 16:20:18 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 0/5] Rework mce_setup()
Date: Mon, 24 Jun 2024 16:20:03 -0500
Message-ID: <20240624212008.663832-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2b95b8-c566-4e28-9376-08dc94937341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QmsNObazIvmv7X56n3Gfg5d+lNCcVGn1LZmg0PCs2rAC3ZpkCLVuPPSJYfCB?=
 =?us-ascii?Q?A94KhErH/txmQ2uAMQVbI0J4U4o9uJq6/tmatrFf7ZytAwF7254t8sjykqyN?=
 =?us-ascii?Q?35xHPPw/O5mR5hX33kRYPn9aaA4bs5SdX5Sov01na3CnyeYrGC91kd140s0K?=
 =?us-ascii?Q?uiPtESOn9KL96d80/DkVb1giinFl2jIzNw7kH3hfSKDhzTzuuCV9316vV5Rw?=
 =?us-ascii?Q?fqZPG3BcfFv9PVF9wS4QXJxFEkfWU6dtTLdesMRPrJdwbU4OZLZSX8ZaL+KP?=
 =?us-ascii?Q?7F1L+mkYoDcOHZiXPNWYgr+3PVDZSAXs+vweMdFhua9AtIvc8Do06u3ja6mu?=
 =?us-ascii?Q?bsG/CG/yUeq3cx8Y9kccYLRgRgQ0GuCTUKeAkO3c/yUoAWunmEx8V97eVLiR?=
 =?us-ascii?Q?+2d3w3oWzUN1rZcYGMZSBEk3Q76KV6w6SMXYAQsqugAoFeOvch6LJRjQfcJp?=
 =?us-ascii?Q?3XzjquTllWfGBls8TRBHkpJf8uQVL0oqwjjlce/e610WfdqvvOySx0NRVhgy?=
 =?us-ascii?Q?CHu+dzrza/stoGAHvy8cXtpdYPex/3QTt2nYP0n4zRbxzZp5Ul12roKPC7tI?=
 =?us-ascii?Q?yGaVby0dgF346qeCjBCh/6d73kk1CaP8rzSl1kvTcFbrHMaIHkCa/Oc/iYg/?=
 =?us-ascii?Q?HkJF5Czm4gAwtzScaEz44kxIGM7YxGxLkemqIXQ2p7ud/hfoU9Oha0g7+qB/?=
 =?us-ascii?Q?cLjXU9p46uw6wMprZsoUGWPJRB0IE8+KLgK2iM3dlqB2S6Z0A3KnfqKfFeXz?=
 =?us-ascii?Q?NlDUJfh0yYm0l3gj/SkDRvMdAvw0SdjGXiQKccKurs9AFooFWI2kROJWP91J?=
 =?us-ascii?Q?uWZL8WfBQ4x1uiS6AoXbVpWBHAD29kCRRqk4+zHJ03G3X00SNRaE310PVh35?=
 =?us-ascii?Q?0Tvo0VXtS7M6IlPDPkz7ClKuSuoOU/90WlEd6hpcy4eTqmVxvEOqRmYkP4yh?=
 =?us-ascii?Q?HZAzf9IO6XesB8+9lHxSovAgYgz1Cy69Oa+bnFkgsAv7n5zq6FF2C3tEaGUb?=
 =?us-ascii?Q?/BComVnxHETxHyeS+76R55bHEncfC0rCnFnebMsWP/LDHlbgky7GCWzO9o+K?=
 =?us-ascii?Q?TRaTZ69DzYvBqiBVb4DOjrVTnwbr6teUKcsOVcz2F6pz+s8+XXhni+gX2duk?=
 =?us-ascii?Q?J92aB3L5/TKEGptH2xOS8o6l2Hm8caxxq6liIaumN3pAP2BdB5YubUfnGjaj?=
 =?us-ascii?Q?04FOIIRbO3C9OQXtF3g2S+zdQ/bgk/R8w5It+AS15l6YqkmvXlTJ02tbArTB?=
 =?us-ascii?Q?NOF1VILGcPnSMW3EVtpY+NPf6MkWhA2ZU9rQjBeTekhxhe9O/NYEOHIVJiBZ?=
 =?us-ascii?Q?v13dvEdMDO0tyXDiT4ZtwCXpTp85Y6hUnoqUNx8/gpR/q/WfNcaoQHUg7voF?=
 =?us-ascii?Q?OzT1VzA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:20:19.3767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2b95b8-c566-4e28-9376-08dc94937341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328

Hi all,

Patches 1-2 are new in this revision. They address a comment from Boris
to reuse a new helper function from the recent APIC/topology rework.

Patches 3-4 are unchanged.

Patch 5 is updated with the changes from the new patches.

Thanks,
Yazen

Link:
https://lkml.kernel.org/r/20240521125434.1555845-1-yazen.ghannam@amd.com

Yazen Ghannam (5):
  x86/topology: Export helper to get CPU number from APIC ID
  x86/mce: Fixup APIC ID search for x86 CPER decoding
  x86/mce: Rename mce_setup() to mce_prep_record()
  x86/mce: Define mce_prep_record() helpers for common and per-CPU
    fields
  x86/mce: Use mce_prep_record() helpers for
    apei_smca_report_x86_error()

 arch/x86/include/asm/mce.h         |  2 +-
 arch/x86/include/asm/topology.h    |  6 +++++
 arch/x86/kernel/cpu/mce/amd.c      |  2 +-
 arch/x86/kernel/cpu/mce/apei.c     | 23 +++++++-----------
 arch/x86/kernel/cpu/mce/core.c     | 38 ++++++++++++++++++++----------
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 arch/x86/kernel/cpu/topology.c     | 15 +++++++++---
 7 files changed, 55 insertions(+), 33 deletions(-)


base-commit: 2db56ea9b277e1790f6a4d8fdd949ab81ba34c76
-- 
2.34.1


