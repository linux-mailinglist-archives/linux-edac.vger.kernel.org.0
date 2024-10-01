Return-Path: <linux-edac+bounces-1949-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A05F98C532
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2024 20:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423301C235C0
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2024 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517F11CCEE0;
	Tue,  1 Oct 2024 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="heyCzQxh"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F8E1CCB5E;
	Tue,  1 Oct 2024 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806636; cv=fail; b=hDHlGDAUgyK0A+R2ddrbZXxhFl1P+NnmXXGLcIsKFTj7IPWx98ukzf4Fbd5vN1UvKCc7vDXrMuqImoGilpXThZa0vkJSdcNLDUWiFt6owINNY5JDy7p6V9gZsc5PJBx1zRlR4e0QIp+OGtf2izZ3NeeP+hBETUKo2fdqTgKyYq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806636; c=relaxed/simple;
	bh=G5qZazva/Mq/whwB9yQJIaVVONExOrKiB+MU0EJbDqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSLm8USeZJcf0SDxRBO93fSFjG9iaTaIIEig8lCRtVAB4o8/rcrTpmugR4PIS7iArQYRVLRTZaFsTsukw325mmm/EjKLPVSfv7OX+QA7Y/+DGaPXAh2+YpJ6y5VvIvCKYn1M/DJQJB6Yd6BICSc+bMT3fp9ZUENKzWSNuq+eWoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=heyCzQxh; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qaVhoOH3RSr8ZwEI8aOJxIr4hCHhGsn4I+4aB5SV7gyb4jxj8vLc1xywoE/R/nQBmGvvaDTRYHtKbwsRC/Ub5SR6XojR4hnqrEbUKimhwrU4fll3g8KlkGzFujSgthmyoYI8G5vDMLRqsCvvdZ+BOESwOGKLYlf15Fnbj5VhjhETnTEPnj8BES2xBIv284GpaLqR+YQp82yzpY+v9Xb+FCWaCjvBAmWVExudT3G+0nQHKr0DurwdMOoQY1tUyzFm/BYL3PIKnzlQdllO/AHvAG/T3dlj4Q4+AkxQCGyIUHbSGIBSBU6BdvBbdESh89pcayWmj4EsBOyVBnFVsq0SEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fKDfJxmtD43Qxjk+JSKRaexDTSkQ2J4WK+VGh/7UmI=;
 b=eVO7LBoeYC44mbWxXgYG4UMrwQNGO5Dp2wxucOnsZ+KxmT1u3GTIJugyUe0ugOeQt4AqSyvuW+ieLXghITpqwcloezxeoxtjTbv2LtDs+Tv9y1LvMvqBbXQnyiRtH+I5080o++YI7AOFZiJBYPUmGWCZmrHM2isGF+rstBeHbeKFzY5ROiUc12T9fPDdd79XziqT5zoi2kEHnY6dPz7A5txxADSgEjLqKLQ9aueB9qsIIjwkdvcmh+UFouU/yQ8M1cq1UUC0tAVoLNdhyNNFNseR6HYXCeS7BjKquROySqh6vgQ2KuCiTWzwaZK7uFEAw60WqRdaWcnaXCcq18kxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fKDfJxmtD43Qxjk+JSKRaexDTSkQ2J4WK+VGh/7UmI=;
 b=heyCzQxh/9eC6g9r6ZadkQ3F/Ja3jMMQNYKJ4DFGOD8E/kLi9r/as2Wmn1ba+4AHJpSPTa0goIFIyTYWbl4kO+0n3Q6LdL9VGDFhaUomjndwhVqa7rr7x/pWgOB9VwyOk+Cxug6f0D3oIgy7cY6WV+ui69QRbJle8hjE1c91YzE=
Received: from BLAPR03CA0163.namprd03.prod.outlook.com (2603:10b6:208:32f::7)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Tue, 1 Oct
 2024 18:17:11 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::a9) by BLAPR03CA0163.outlook.office365.com
 (2603:10b6:208:32f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 18:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 18:17:11 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 13:17:09 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v5 4/5] x86/mce/apei: Handle variable register array size
Date: Tue, 1 Oct 2024 18:12:28 +0000
Message-ID: <20241001181617.604573-5-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241001181617.604573-1-avadhut.naik@amd.com>
References: <20241001181617.604573-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 34fa7e5c-1fa3-4082-6048-08dce2454498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tE7OGc0nrQSYGZDkR+pL+UVVgJPO5W8i3Ozm0osmikTqRrt/QLeVzCvk4oHZ?=
 =?us-ascii?Q?fKWWu1j/EYNiwcWmXpwSckNEB7hAQJMpbPXoWs/VmBLHL2hAbEn2K2O2W3qS?=
 =?us-ascii?Q?KXElJoTTzqHJEKLMF7yqiuS0bcr6TYEt/KbBvgYFFMasz8++YN4eybU7xNvR?=
 =?us-ascii?Q?n/0KMRwcPLkzVHJ0jg/aPoNhy4zJA3V0Vjv9imoERrqOTm4HWrgUNxteoz+s?=
 =?us-ascii?Q?idQunWi4DnY7B+m4eRTO5G9u8AMcGETR0ibg5dTo0S1i3eV5SUKB5VxGk6yB?=
 =?us-ascii?Q?bCc9g3BVOdW8I9Ba1+7HiHVr9ybt2LrUgJhUzm5qila+cF7LXqhBPUx4+Mn0?=
 =?us-ascii?Q?/wmnAR6nY44Pg5U5+FYbJC0+9wlFV5FtVRwF08SfjAQNZ7FEGSXbp5XPaEvr?=
 =?us-ascii?Q?IqDVWkB9P2umLU0DTejGXC0C8G2xApXke0n9PpW4POD9YiHINSeH5hK3UH3j?=
 =?us-ascii?Q?MVxRqLt0DsJ/k/UfwBgaveeNRkngvPcLDoe7aMiB6byNRUFRGXN6a8Mn33qP?=
 =?us-ascii?Q?/Fe4sUTyTqBXL4bjIWl4ggI3SHf4jzkfdi9I1AoP07q+Bq09eaz3L0/6jHyT?=
 =?us-ascii?Q?q+rPv0TtDFXLRzM0bzLbbc5YDTGempUd7jSd50llxNkfc81ZzJq9X+yv3G3x?=
 =?us-ascii?Q?QxMmRbVZKQtFDMeuqSyTjh+n/C6AbJuDVHc5tswsnrke42hA6yz+NYFCbDoN?=
 =?us-ascii?Q?xkK0EoZcvpoQZfGrOQNOCBQVSCnVSeXUHdeFPPKMpHnjZ87mwmk3h4V02JbZ?=
 =?us-ascii?Q?ywZBRbBTuGEmuF8i9xapO84a4j/3jXfe/U4t8PYQbD0ZOCd1I2giHK8JbvuN?=
 =?us-ascii?Q?J6qblY4Z1GxNr4IQyJDLCU+0bSL1njBeN1aSXXTRfsoNN6Xk3CZE7gURldSw?=
 =?us-ascii?Q?EiHliyS1uUklPffbDUD2etmO0Jsrq8yXZD2v4hWZqREeetA2AesOl8cn1BhD?=
 =?us-ascii?Q?QnGLhk0E5JbYFLucioruoiu+6C9K3YKoFq4FJrxxBFAQlk7JlVV4E5Cc0+bp?=
 =?us-ascii?Q?9beTYnT6jDFhH57TclkYcXGkLFcdltUWr5qQpml9THJHQowqHZCn5A28WCCR?=
 =?us-ascii?Q?vff/jGVUvZKImEFVOiY0oj/vXBHec5zu4bAHTIXilBRiFZD/AzaY5LAhlC9x?=
 =?us-ascii?Q?q/4lWwnqVKkKSv2s/wLwjwUA9pGz9N/l7LrUPVzNn3CxObpwHOEHKL9BxnoO?=
 =?us-ascii?Q?V3GCju67m7qYBx5qDjaMESGfrrpjFg+KL+8Lyh8hSNd49qO4e34Z3oMUq0ml?=
 =?us-ascii?Q?84lsEUd2o+VUPXlP1vzxz98IyaOLWGNu+NVtkwktJqYuIqtVA22A1wLTdlKG?=
 =?us-ascii?Q?9ocHQfhSQhIgRKGv54Qjy3ktp73HNcUffcoX21eHFdIiKypEuek5WNgvwMOp?=
 =?us-ascii?Q?j3q8cJGe/406uVylcSVsI0cbHAZb5U7MWKJ9MVEZ4aa0axcFKpu4eK3lRiPT?=
 =?us-ascii?Q?Jn1s+6Uo7AcAeOxG3VUZDwp/VsoIm903ubqnSmyWsdBbidjzJOWFnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:17:11.0600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fa7e5c-1fa3-4082-6048-08dce2454498
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952

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


