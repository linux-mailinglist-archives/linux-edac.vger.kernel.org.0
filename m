Return-Path: <linux-edac+bounces-1653-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10F4953C7B
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 23:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F63A1F25A54
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 21:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445A514EC44;
	Thu, 15 Aug 2024 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P42ZuadH"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8BA14F104;
	Thu, 15 Aug 2024 21:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756643; cv=fail; b=J9PEofIOc0QXWmJjeUvFuJoWK+Q5A/bHbfPR+FVbr9nBWZ2M5PO6i9t5U40VdEaoJuiLuY41rkwhCaxfgB7rV1H8w1PAhITz4uymRYZPlv+CSOi5Vui447yuRpY+r7WV/2+IgOuiEu4bGmx5SG2IWpaVCHAQb4pXLVczSSJrQTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756643; c=relaxed/simple;
	bh=WCxcDToqQ5EqMHL1Z8pw5n0R50ozAFKBKREg7w/HqQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drc/wVL1xXVkjeBqaAnBo/kb1o3AKTZVdS90KtoVV0JIaRW0ryDAjx8XnHuYPhFP8dCvO0YfRmMpo8Bg3AQ/oJPH+IGQrZsEmF3k/gJBjxIfTIz3wKtpxh0rurlHqn/3tNpmGhb5zvurE/+3KKzjnqCEinKOolCIsx2SVtqWEiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P42ZuadH; arc=fail smtp.client-ip=40.107.101.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKeB4WnYqhgcNmFgDXgN+LzP49MSqq2EQPMHYGK9PZx0v4d5aEubEgEAW19UaYTzA7/u285F8rvqUWynTH6bDx6VTwFAsHsldgeICZQrLCQZVa26Y/a/ohJJYPueO347qMQSAEpFkrE9zKdARfnJYa/1gfxellJ4ptumML7pLIvXjV1fffjiuj4Ur+ebL1xTlxX5K09QXgoQHup2T0U5DyXlmfi0scUcEbdRS4xdEU3PuNnDp1Tz6SSCcQ7rq1c0OI9TQX9CzPakhqlNKxiIcDaAYEqHLrsvstU8OpxdJzY46tsBltf+7BkTsVZu9mTrgrRwer9iOODE4bc2uijM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc9H8QaudY8kvel7VUPOUbtsW6n7TXOPICP+juMP83c=;
 b=BrMoiTCieHxpLwjByLE5exgpRZo8W9GNAyvqI09G6/Q8ham+qBNvsnwxJHjNJ1VKqbvYiKqdWOUmIxV+OXfuup1NSTm0jlx2oyJDRNhfK3JQOElyYoWROfIk1+kApY5YGghCSbH0F1U9NZaNFsILxrKU6lPtw3v+JZiF3ZbmrvR3XPTo1j+/SE8SY8+6mayta94Aj0as/crWv1LE/fk/GtUXciw9a+q3R39M0MzvSoWSrn+o3HWbRj5RxooHv9qoJPc6L28xhMPjRRCJSHQTcDaxeDvRHC5ch6AnObCQwXzvHAi/7Ap6fweGtb0242wsMEUFuNjyGZZ91RLbsi+OIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc9H8QaudY8kvel7VUPOUbtsW6n7TXOPICP+juMP83c=;
 b=P42ZuadHhs2eowFUHnxJh69KiQ8LVYvuPEfuQc0FEFg0WxC3xHgzYeGcziQ7uv6ZoyJcM9fDkjNJrpWJppY22B2nxsX3To8e6sbHSpcD/qGOXlSv2g6hY2O+cK/0zsTPFnXC87J3K2g+eYamhB2fJJ5HEwazABnQmwyQvBSl84w=
Received: from BL1PR13CA0422.namprd13.prod.outlook.com (2603:10b6:208:2c3::7)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 21:17:16 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::d2) by BL1PR13CA0422.outlook.office365.com
 (2603:10b6:208:2c3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 21:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 21:17:15 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 16:17:14 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v4 3/4] x86/mce/apei: Handle variable register array size
Date: Thu, 15 Aug 2024 16:16:34 -0500
Message-ID: <20240815211635.1336721-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815211635.1336721-1-avadhut.naik@amd.com>
References: <20240815211635.1336721-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d89684a-7ced-44c7-2983-08dcbd6fa365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z80hvF7IrMMz1xzJDPEkF4VqNk/wdW1VtGQfFialxr3ZrzgOZEQ3oqbs6dZH?=
 =?us-ascii?Q?5PBAdmoESSK4scSY7nNWy/nKtRuDOoRxSxbWRXTPeadKQyHkttIfXg5ewWNg?=
 =?us-ascii?Q?dOUxLeoaRIMowegr6Kkf06/MacfATzzem5XB+vYvhA7O4qP12CEyy7ECYpXI?=
 =?us-ascii?Q?eGF41vLDYfLVA5j406YQGIV0xIK4HH+7oou2YRCjuKg0o3j1ElOBN4nPZmBO?=
 =?us-ascii?Q?vaz7ESdfV25R9xj9D7NWJHGthYOn4eqIb2ELo0l3bzcWMcj2KlTIb3w7WDae?=
 =?us-ascii?Q?27nOJER2dWZx4qNMG4a/rUKgSJpphwO95NjrKZRqFGKlY/q6f63u/roVPGoD?=
 =?us-ascii?Q?CQGylo1llUmATfKdDBPBP9cNIcGI1cgJ9YTE+NhmcFsqHDSq48XxIQYt0BbG?=
 =?us-ascii?Q?pkZgraldnFSjeVSeCRfj94MUaOZIKP0MIRE9cqlttxvBi8wH3HyeammyxG9X?=
 =?us-ascii?Q?1AcKZLGMR6aVnsZNf/OZXcKcEE0iDvMrTm5FTopiWJDtrgsTnGcqCOGYHh4v?=
 =?us-ascii?Q?kDIrXyZieo9go3GfNaIRG27+B+8b7oiEUWDOX24iQUA7/9Q+N2oYaMNkW2BW?=
 =?us-ascii?Q?EyvNBuBhULFFbbS+f1U7mGrlwovvoC0efbnOtLDBmTlmZbJp9XMqx0F9GZyT?=
 =?us-ascii?Q?q5Uo51efXgM5kF0q/sqR7O3XytS40CwndlUdfRwH1NuCTaxJlgKPizyflR0e?=
 =?us-ascii?Q?fyrLgEV3eP7Ym7ACaDussaK84yPvIJRryKrwRFNsNNXkje3qhMkIYwcJC1D7?=
 =?us-ascii?Q?OoFpXx7gKlYcfQLzwVA7Z8yqrXnADRuHWfhlp1vQaKCsXVSfh9hVEeTpcTkC?=
 =?us-ascii?Q?WU58fmy9Xh/pI6KyC/QbsOjDedUFBGsuurx4d11mkOkI9gKEojBm3zza4K+0?=
 =?us-ascii?Q?FJuDREGGy5f9naJh+fBAP25zJ96yV+dtYRWuxUSiMEKIoBhqmbDDo0deEDwf?=
 =?us-ascii?Q?fRROZNeYqhmGHQy4qwSlgjNDiTO15F4ORkfBHZbdg4qSlUEmmwQaAk6Uco6i?=
 =?us-ascii?Q?CYoByW8h77ZCB6eLe96CCnq2QsNL5jr6JWmtWcj/c64hj+dUsndEUBc/dKfU?=
 =?us-ascii?Q?3g/pS+vCuii6Ev/NCW2BiQY9RjUS7I69IY9nClXV9mELqZauZzNZFQZ0W95M?=
 =?us-ascii?Q?ror3OMM+7fgHUOtbXN2YEIuYIFu4jJ1pjav98lMyVw0vmARZ4dZr3Mm1JnQo?=
 =?us-ascii?Q?FoS8OlLBmmkaUG98eM5OlDRJc3WRDUUu47kifKgbJuxzDzZNLbQjUCJNwYa6?=
 =?us-ascii?Q?lPV/zNhrPTimcu8hUIwYu891fkGOvbVr7gy6IB2xOQPs9qJj5q6xRlVsXWI+?=
 =?us-ascii?Q?zw7mzMvx8Gx7fgu3gkiE+jfOywX4l7bONWCrNshhWEpJnXfL3AnpIAlqw0vJ?=
 =?us-ascii?Q?twkbrUySnwXJQpPeFkx+rZnNqrAwee3UW/E9iGcDdMyq76h1qH9P9DsaswLe?=
 =?us-ascii?Q?t97sMNThCFm62TAPMy5jnncfMZTijg+Gw6XsR6NWkySDpp4kp2iZ3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 21:17:15.9322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d89684a-7ced-44c7-2983-08dcbd6fa365
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821

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
2.34.1


