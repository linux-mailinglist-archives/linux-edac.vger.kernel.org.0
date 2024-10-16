Return-Path: <linux-edac+bounces-2091-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9BD9A0197
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 08:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E4A1C2307D
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 06:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C8F190073;
	Wed, 16 Oct 2024 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UwsQX+yE"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EDA18EFC6;
	Wed, 16 Oct 2024 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060885; cv=fail; b=fjvzbax7skLKyeKkMONWabp0+ccqigZGkftsLcm9VFJ29HD4i6Rr4EhNEiw3rqyOyDtS4At7BcZFFw5zjRP7EDkjjQlqA9GNwBArCw2rJI9gX3ApmV3Ybt8g9TBYVQaTC2cgxxI41dVkGeabnt54D/NDh6vm+IPmG2tIjy+gAWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060885; c=relaxed/simple;
	bh=XqCbOOrvi+svqVSKGm2QJiKnyX7RX0IQBv8Eq3BszO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYXub35eFHeoxH2vEBgLbsODVxh4TjQ48becaXYDVrgbE3d0QmsNvektna0eDW6gSjqHbmzdUjGMtygLAgUPXgq8yIiY3l1VekueYlGeRdmvq4rIxIiJ2q/gTB85rvmGBXLD1BpdoWriw4P0wifrGC/5Nvta3jZvT7+kGZmT+ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UwsQX+yE; arc=fail smtp.client-ip=40.107.95.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFBT077ZIPGr6AP1IU0mm0DiZY3nZikQhkVYjKT6wFtR0CI4oQV6BEAvuPWY9sAJJhjnwtsgwavIcgCBUeaICJf0Mq83YdvTaG+rtuehdMt822kans7XuCagXZ/UqWemigJ+8r+OTYR6PtvprR6B0JgNiQktbbCffpgOgPYdk+nQgyW3q4BgMWmoEPM7dOlcJ9lqz2cVLQpOsP4W9zCDyq+r4Jcdc10RUY5Dk5OvcfHHb3aLOi8rYacn4olwja+79sb8vlIcuTYwmAj+Io69kkJOj0Q9ET7ocF3Q538x0spUCMa0mcD3j/uDXMIrNsNawby1DNAoqmHuvgsaVrSf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+jeQwQKmM7MccpRbqvURQNkRhKDWlbgPsQMoa1iFrI=;
 b=Y6uRvtKMRsMY4X+Ng8/1MqG4Gnxy9d4vsGEvtzFJabNSec8ahSElXAK6oq4oVo/klOpRo6vYolBhOT1lU3eJjwNc+tItVhQOmx2or5da1TZZn0fZnDGx/e6+VH8odLrSOgwwBa6LzGve1t4yd4O7qUti6RwisJdqPE7utMwG6uR2w6qnOt2YUx6CmUYQIyrYi4050W334a0LAMveKpqkpwh7BxBaUgStF8/68fPN/DIKNIm53w1TvByPhPhtkoMXZp8ZydFkaIay9PAIqqyUU8WA88OGSWBIh6BATdLWzX1dlFVrW3yjc34DdN4Ya9s9JvIVGNHvp+JJ72B3FjqsIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+jeQwQKmM7MccpRbqvURQNkRhKDWlbgPsQMoa1iFrI=;
 b=UwsQX+yEQMyXtbzpBZpMQfbAXDT2B8rxhZo2L4NPGtltGDX3iUdeBmYzl9x73tjLczSnCA0gIUCS2+NcIpfxhYL6Sm3xGy6uy5KhkhBoS8ZMniT3Tp25Hhs5ytuFSRe6EWbg89uHhS2aDEWxpWHxGi8m22bFOMKmbyf5YpJF058=
Received: from CH0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:610:cd::28)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 06:41:20 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::81) by CH0PR03CA0113.outlook.office365.com
 (2603:10b6:610:cd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 06:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 06:41:20 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 01:41:17 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<qiuxu.zhuo@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadhut.naik@amd.com>
Subject: [PATCH v6 4/5] x86/mce/apei: Handle variable register array size
Date: Wed, 16 Oct 2024 06:36:30 +0000
Message-ID: <20241016064021.2773618-5-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016064021.2773618-1-avadhut.naik@amd.com>
References: <20241016064021.2773618-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|CH3PR12MB9455:EE_
X-MS-Office365-Filtering-Correlation-Id: a59b22fc-ad6b-4667-cb0b-08dcedad8b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P3IAY92Ufdd8fBpdfy5tHZufBaoSpAaB9yBHX6G2YK6YmOt3BbFDZpQOK7gW?=
 =?us-ascii?Q?hYoAKf28kRvQPRJHyeiOxdsNlnoPdQBNoKI64HaLoowR+uLDoiNaitK2uE4n?=
 =?us-ascii?Q?4G/D8lVs3HnTz6xZ2t5vopsvMPrZ6MM9alPBsuZheyJ3E8tWVhxAn1A8Qx9L?=
 =?us-ascii?Q?NuKBC5xKdl4t6pDkeASZwVlWq1MfcIfxrd6xVBAFsizHl4j/saYBvIgTHY38?=
 =?us-ascii?Q?70NvKhF03xMTRuHPzMvXT5Pj0bLLhyAQ5wOKlmwZhW4iSnGxLiCAYBi7fc5E?=
 =?us-ascii?Q?KfKUNKYjvgOOcC3wHNBtqa7udOxO1dEKvcI+WVS0TNoYbiTBvpjtuuJbSBok?=
 =?us-ascii?Q?+OUxPkuGG/IqS+BDq1SmSiZBBswUBswNpWklxlEb/VtzXtmWAnrwVH9fSxcS?=
 =?us-ascii?Q?xszvf3yl4UAtwryM4gmzOvchv7rdmeYm4LMwk6A/0l8DmI3YvduIt7bFvJXC?=
 =?us-ascii?Q?ub5iIPN0CvymjK4iIpoCIRYVz09d/xRH5lC/q4mFaJ++4aXZ2SZhsuBWrfEZ?=
 =?us-ascii?Q?J+eY2pX4kNMYJz0IbNc6+cCmTBImUU0v1T9yXARlDlVRvbCBZ47bTruitOst?=
 =?us-ascii?Q?lz3ak+p12LfZFnzjN22WdAUq43hF9JVqp92V1n6icL4WL2+mjdmZP0AwOSrM?=
 =?us-ascii?Q?B7SsPcmkMZp+nbf1HQsoISTNr2QLcJpqMoLGNq+Q+urAyWJ6MLv0+hvMe24r?=
 =?us-ascii?Q?ZO3x8xx2DOZAAJCp+0Z7mmnNLiGrAag98G+eYCJ5Dk1h6B4lLQrq3SnVH4uD?=
 =?us-ascii?Q?44uBtYOBFSnJzuLVaJZbq87+QaN83GAjWIfbeLlMjHx0VKkFNwpM1ljOK6qx?=
 =?us-ascii?Q?IfRUK9Nm1GsLoxGbO7H4z6ZrlGIiCG6xohwrr557YM0qBB0YGwT09wb+EjG3?=
 =?us-ascii?Q?znhyvwh+/PWpuyGrc2dHU2LtT4pGzkr+OZTrcRm7fVMJnztMUY8BYDwINOyX?=
 =?us-ascii?Q?5l4bdj8qJGpZdH7jSlfHGNm0NqvrlPy25vGpKTZwc+nt9C3JcUdhxF7ah+De?=
 =?us-ascii?Q?tPj+YAmPx5IjMMsibuD9Nu0S0mh7SUv0ITcbPETUWOOZKwhyALPX/ussiAk4?=
 =?us-ascii?Q?sthRxNqB+xE4wEl24DViWxMTzBZ3pwp4u9Rk1pGCP2/rsL5ZQVCv1xYZSR0j?=
 =?us-ascii?Q?RhFQrw7A4YNHHS3KJBiRLIm96JjF+qtBy2mtDVAmFdUp04zX+qeKI6mWYJy6?=
 =?us-ascii?Q?UNFDaOK3qKLzUqTpLq1qGH5FJODYRNQC4M5OWYGqnKZdlDFiQDDMf0USFHt5?=
 =?us-ascii?Q?xYhVJVx6RHkm8DUWyfY8XCIwJrcj68uy+zcKYoeugUsdpbMp6YLYpmQwMF+W?=
 =?us-ascii?Q?pwGtz2MUqZrPYBbzLpL/gjlDMmX6BV8q6vPTDwP+akZEROco3uADTLG4q2DV?=
 =?us-ascii?Q?u4zyY28EbSd1wIK2y9fpplDK6WNH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:41:20.2987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59b22fc-ad6b-4667-cb0b-08dcedad8b6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455

From: Yazen Ghannam <yazen.ghannam@amd.com>

ACPI Boot Error Record Table (BERT) is being used by the kernel to
report errors that occurred in a previous boot. On some modern AMD
systems, these very errors within the BERT are reported through the
x86 Common Platform Error Record (CPER) format which consists of one
or more Processor Context Information Structures. These context
structures provide a starting address and represent an x86 MSR range
in which the data constitutes a contiguous set of MSRs starting from,
and including the starting address.

It's common, for AMD systems that implement this behavior, that the
MSR range represents the MCAX register space used for the Scalable MCA
feature. The apei_smca_report_x86_error() function decodes and passes
this information through the MCE notifier chain. However, this function
assumes a fixed register size based on the original HW/FW implementation.

This assumption breaks with the addition of two new MCAX registers viz.
MCA_SYND1 and MCA_SYND2. These registers are added at the end of the
MCAX register space, so they won't be included when decoding the CPER
data.

Rework apei_smca_report_x86_error() to support a variable register array
size. This covers any case where the MSR context information starts at
the MCAX address for MCA_STATUS and ends at any other register within
the MCAX register space.

Add code comments indicating the MCAX register at each offset.

[Yazen: Add Avadhut as co-developer for wrapper changes.]

Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
Changes in v2:
[1] https://lore.kernel.org/linux-edac/20240521125434.1555845-1-yazen.ghannam@amd.com/
[2] https://lore.kernel.org/linux-edac/20240523155641.2805411-1-yazen.ghannam@amd.com/

1. Drop dependencies on sets [1] and [2] above and rebase on top of
tip/master.

Changes in v3:
1. Incorporate suggested touchup.
2. Fix SoB chain to properly reflect the patch path.

Changes in v4:
1. Rebase on top of tip/master to avoid merge conflicts.

Changes in v5:
1. No changes except rebasing on top of tip/master.

Changes in v6:
1. No changes except rebasing on top of tip/master.
---
 arch/x86/kernel/cpu/mce/apei.c | 72 +++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 7f582b4ca1ca..0a89947e47bc 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -68,9 +68,9 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
+	unsigned int cpu, num_regs;
 	bool apicid_found = false;
 	struct mce_hw_err err;
-	unsigned int cpu;
 	struct mce *m;
 
 	if (!boot_cpu_has(X86_FEATURE_SMCA))
@@ -89,16 +89,12 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 		return -EINVAL;
 
 	/*
-	 * The register array size must be large enough to include all the
-	 * SMCA registers which need to be extracted.
-	 *
 	 * The number of registers in the register array is determined by
 	 * Register Array Size/8 as defined in UEFI spec v2.8, sec N.2.4.2.2.
-	 * The register layout is fixed and currently the raw data in the
-	 * register array includes 6 SMCA registers which the kernel can
-	 * extract.
+	 * Sanity-check registers array size.
 	 */
-	if (ctx_info->reg_arr_size < 48)
+	num_regs = ctx_info->reg_arr_size >> 3;
+	if (!num_regs)
 		return -EINVAL;
 
 	for_each_possible_cpu(cpu) {
@@ -117,12 +113,60 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	mce_prep_record_per_cpu(cpu, m);
 
 	m->bank = (ctx_info->msr_addr >> 4) & 0xFF;
-	m->status = *i_mce;
-	m->addr = *(i_mce + 1);
-	m->misc = *(i_mce + 2);
-	/* Skipping MCA_CONFIG */
-	m->ipid = *(i_mce + 4);
-	m->synd = *(i_mce + 5);
+
+	/*
+	 * The SMCA register layout is fixed and includes 16 registers.
+	 * The end of the array may be variable, but the beginning is known.
+	 * Cap the number of registers to expected max (15).
+	 */
+	if (num_regs > 15)
+		num_regs = 15;
+
+	switch (num_regs) {
+	/* MCA_SYND2 */
+	case 15:
+		err.vendor.amd.synd2 = *(i_mce + 14);
+		fallthrough;
+	/* MCA_SYND1 */
+	case 14:
+		err.vendor.amd.synd1 = *(i_mce + 13);
+		fallthrough;
+	/* MCA_MISC4 */
+	case 13:
+	/* MCA_MISC3 */
+	case 12:
+	/* MCA_MISC2 */
+	case 11:
+	/* MCA_MISC1 */
+	case 10:
+	/* MCA_DEADDR */
+	case 9:
+	/* MCA_DESTAT */
+	case 8:
+	/* reserved */
+	case 7:
+	/* MCA_SYND */
+	case 6:
+		m->synd = *(i_mce + 5);
+		fallthrough;
+	/* MCA_IPID */
+	case 5:
+		m->ipid = *(i_mce + 4);
+		fallthrough;
+	/* MCA_CONFIG */
+	case 4:
+	/* MCA_MISC0 */
+	case 3:
+		m->misc = *(i_mce + 2);
+		fallthrough;
+	/* MCA_ADDR */
+	case 2:
+		m->addr = *(i_mce + 1);
+		fallthrough;
+	/* MCA_STATUS */
+	case 1:
+		m->status = *i_mce;
+	}
 
 	mce_log(&err);
 
-- 
2.43.0


