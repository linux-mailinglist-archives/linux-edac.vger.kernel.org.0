Return-Path: <linux-edac+bounces-2190-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7B9AB71E
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 21:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 460BEB2436B
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 19:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2455C1CC15D;
	Tue, 22 Oct 2024 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WW97OhOm"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0451CB50C;
	Tue, 22 Oct 2024 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626189; cv=fail; b=Igw3z9xEEojd++26XEByQi0fZ5q1m0xd2Gg0mbSBEBpYwk+0DU2wfdzRRnX+Bm2qV1tcrkSmO1Iww0bVL88D1V6dW3v/yLC3Dpayyj2bMD0FcCrGbJ9ByAMxkmOai2UByNhqFE8bebYqfzNEvRW/0wGlHLKPCkzGO4OMEzIcsig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626189; c=relaxed/simple;
	bh=oEuWKDc+cArZI2M0ZLKvv3eyVGJiPpFtoVue2T1KJJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sh9GbXm1H0CgmkYRlR5U9XPeq/cYA21UXb34MQSjjpfL8wsVzea/QAfi173rJeEZV4FzHdU3noNKSxI6Lakw/sB/Lr90w042YxJou9BaQfDd8Zj1dvS7Bux716UvdGT0v035SK7zRV2yIPmNxpQvspNVgLRVKvNM7WiJa1HRnXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WW97OhOm; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crrj06kzncNhqJNz96i0yDc8kVEQ+EOWVOP0sOpdt5bStdUHy0j+FsqFmoUEAe2hQtUYF5oFbQhfL4pz0osDrdBtNHNVWnfw89/zBJkrVPa+fclcjYWpbsVFdPEzzri5aSfESmXSrnHgZcG6pgnfGMXFuzydJHJXNFIhiWLYixAidaXKyjvLBdsugeTJzVJEplQkXEBjlF721wjNtDLdnNbrTBz1d1VIZKdbrpyHgl1T5l6JOIwFRxzLEgpSv+Qd4bN4VdCCsaypkhLRGjLzgaWbD0Kqr4drG6Kln3k+uktu1JZIgFQ1dPFWxR6CnLJ0tqgLuDDOfhowy8vxyXEb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EJKi0nQn0M5d3FrUjSN7jekC3CA6c3TcilflOPrn9E=;
 b=NKL2kCLPhgLgDzIrhjUzdpLzVu8mjA0Rvd6zre6veiqGqg8iYPwnojYrj40s39K12HUIfn8WgzDiQOQkfGqld6IwBvHt+I4VoUV9J2Wffy7YGXj1dtgpZfXOLbD2kxFcAGnogpfG+rx5lvVdOAy+BN2iPplbo+fXG5U1ZkL6jiKNLGL9TAXbRYqMM5/Fq3mM2Hn3v653g5zCyY9DNX4podGsCLLdbKIqZPo/DXOX2H6JJ9TjP6aVO5R4zhaz0YlPMyNym8vUq0bf9RwfDbHGKMvwi1iP/QFXso0y3H140JdrEaBK3mlZa/kaz7iVpzyHHbNlRdHGPea3vFCQjpR7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EJKi0nQn0M5d3FrUjSN7jekC3CA6c3TcilflOPrn9E=;
 b=WW97OhOm+m1ejHlsNQgxEL6siRGXrW3l3R6WWCxUg3NW4hd/zl4/SjUeHzTcYVAiPAgr5TrA9ZyUUiioJ5P+AWREL3LPfk86EGPfBFs+brajoBY6r4UiYDC22f8QpMtOGEUh5chJFncWCd6kQv55W4Rh/Mcw7RvuPuZrgQjWjLQ=
Received: from BYAPR02CA0030.namprd02.prod.outlook.com (2603:10b6:a02:ee::43)
 by SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Tue, 22 Oct
 2024 19:43:01 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::1a) by BYAPR02CA0030.outlook.office365.com
 (2603:10b6:a02:ee::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 19:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 19:43:01 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 14:42:59 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<qiuxu.zhuo@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadhut.naik@amd.com>
Subject: [PATCH v7 4/5] x86/mce/apei: Handle variable register array size
Date: Tue, 22 Oct 2024 19:36:30 +0000
Message-ID: <20241022194158.110073-5-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022194158.110073-1-avadhut.naik@amd.com>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SJ2PR12MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c1b2e1-1d28-4ff0-c052-08dcf2d1bcf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/1+uE+1Ghxa73uopU8/3NJN2VF5nEc6BkGWpgrR8kQYXxaNJ/rK9u+180zzD?=
 =?us-ascii?Q?jhbMqOvRr0oJWZjns6l8DTE++tXpcC9eyCqytbqMKYy/H/Re13sTZCawQ3v2?=
 =?us-ascii?Q?n3CySOjOAhTOcrxtqttKM9X4rO3BfLrSLlU/BgYsxLT5UEx+j458eKuM/7Ug?=
 =?us-ascii?Q?3yQFEl08DHo72Mdw3JwCEKy3kZRNC7ZZ88mC19J3bdoyFjNF/6roo4a0hFp5?=
 =?us-ascii?Q?MYrUbzJ5whhAd1zMS9E5COmHET6XT+IqkjzCM5lAXSSFZeIqFne09q/JEbMC?=
 =?us-ascii?Q?4rOtSj0IPAVi+ks+6zU+h5ockfvSvX/IAh/+6pN0F0ihEuJw8CEfR31yV7Ug?=
 =?us-ascii?Q?UzLaXszd9Q25IEP2Iu7dm0+c/50Xt7S0q/lBrObn8GDlisofHCTRhEWXFVdQ?=
 =?us-ascii?Q?Kr+EaTHVUQhzhGLF9npoL4ahELd8ixnn3nlvRZK1KQ6QyxQR+GtJf5VeoadB?=
 =?us-ascii?Q?1dHqcVpCR3NSo2daSX2KcoZkSez27BLSmDjbQGk05dst6SOPwyrChkU4yKPj?=
 =?us-ascii?Q?90cFISjlCJblyydWZ23ah2pBV0YrJOdIDxWV9CkGJX4fPnQQi+MJ+SMoM1j6?=
 =?us-ascii?Q?udCrJ24MZlDjSRxflyY276AwjoBA1wyjn/3A8/uNYKpH/rSPigN4sTS+VbhI?=
 =?us-ascii?Q?ojZNd1U8weFmWPdQOBe20/kwyHuPY+jKu4MYOlgasQvl7gZgILHUzjCPeh08?=
 =?us-ascii?Q?ixK9yCrupceJ81nAzCZEyf/M3izEr1Bncv+Bp85cRFfyu7CjKx5WpAf8Skke?=
 =?us-ascii?Q?qzEvZ6lWnoC82dRwrdnQbO2MYjZ2MA2PsC7gvEFPYn/b6vofzJl7yPhhxSKT?=
 =?us-ascii?Q?Pu/nUL4gXvanPPTcmKUz/0KxtZUNCB9ZVfLRzkf37gyfJnvBCd2uGzbokZ0F?=
 =?us-ascii?Q?aDGBqiFHMO76j2LKiY+ZSQdJ9iyIpR3zuz7aYwPN2f96DLSwEc5slrxSaUhy?=
 =?us-ascii?Q?cKGJUDj8PEibRb+pXxWJPCnqPJPBtxSazSAgs3/cg+IAkNjQAYdMFRO4Yprf?=
 =?us-ascii?Q?btF4698Dh+oO7bNqBo3BrRf0l4ZMwsXi8heSQOq14puHWqXUtODYnHMnKDUK?=
 =?us-ascii?Q?I0gaW0f5nIM2WtrPjTlU929HuFE58fboeg0xO+gYx0YdTKUmPLSIlYcbNAfy?=
 =?us-ascii?Q?9qeKVVXq983QeWphAHx8Wv+dsno8b4ba7J+KgEx4RdAm1+vhn6oy/S0g+vN2?=
 =?us-ascii?Q?tDTf2CZmNFnS/VwqvLk5//H3kaTtVinU4RTnzJ5O+ge15B99C0pRpJT+4Zez?=
 =?us-ascii?Q?IeGrN/nV3cwXcTk/iEP6TBT94h+YuX6Mx8j5w0XfzT72TM6phnNqfiGsC+eN?=
 =?us-ascii?Q?tAp/LjQhc1mqpQFQnR0ahmdovdu9v2W4nkL4J/yR00twmvBQemB4uq/hUh5v?=
 =?us-ascii?Q?cVmjEhGP+x+UraJfPv3cXHmxeY2JkckybYtgR82MYv2ZR/pUlkvyL47WxLad?=
 =?us-ascii?Q?grgFVwlDu3s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:43:01.0398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c1b2e1-1d28-4ff0-c052-08dcf2d1bcf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717

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

Changes in v7:
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


