Return-Path: <linux-edac+bounces-1595-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF0C94201E
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 20:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 473E9B25280
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 18:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8BD18C905;
	Tue, 30 Jul 2024 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J+YemTIt"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D95E18C900;
	Tue, 30 Jul 2024 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365693; cv=fail; b=rUuKXLPxVCpc+vfvabNpXiLdgyK4C0MxwslUpHKFR3CFa+4x7gIyD+8Gd0vsAmpuoetxbLo2cv5ZPDmirCTIPfPhSOOTlF0ZuPw7apAi5BcUNKbjqmIjxs//cV3/YQdPHIuMYl6lVxekPWymwxbfys4EfLLtottqWq/JubEr8aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365693; c=relaxed/simple;
	bh=A9AiBIhNB4emx/K6xc8akiVZcyQmssGw1Ja58JzbpJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+m8PxgigKsiHqgsE4Ftv/XQTHw6qNzo/5iSGKmn4OfeRaTY6lSH1zhmlJz56voQ2VHY18jlXZpEE0f34EiTpaauzpUFU/Oc94ciLpYxPLqay9bo26L9p1gpU6V6ZN/NAzSIlQ7xKNLNUT39zZWjPxLz8URicORAv2P0b0YnaJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J+YemTIt; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcBhH5gDQKtvLM+3RVgPVCItWAWX2Y9lwVfzCZ/35ftxNXuVjvpSSPgD7qF4cx2eoBQ00MQ9otz5VwhsRLqjQiNXIzObkfwjvRZrg8LceoB0mZMykCoeiYKpCBSBiC+wcCv4x+uQYTfCGNk3no2k6NKy7qYkt09T8srYwX7JUUX1bKLjr6QTX75J9zu8lRrJ2BP/gSurTgLcD726smEbs6XrmaDH3cYSsCCPO41TJlIe2DxaRPpEpS7G0JynsekrjXiQ0qT98uhKhyRJ54NLOva8CPXMCHNHVWpCJ62uX85tgMEer5a9xGUE1djcVVQ7oPs/RjGyqQInA4meUV8qaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOiU/RQiLyr76l6EQEz9SQV+TWwZAGxvTx701NtM2jc=;
 b=CuI2Y0XuJ7ROqIMFVzeqh6tbKmyPQKtfMssRy6vLX9daX/VhNDMjhGZOLhUokD0Rq+2QqZXQub7psAgNTG+4rx5iRwSeSAAf1zRSGQYEZMe7vLgt/Fpb194mXgzPHnG2IUej9PNVwiueqVJMvOcsUxfr0GYsUSdWRZV7EoDcdSi2bgJJlGFnJwZ1EeMlcNP+AY/ztbydQpooydQEWmAhYC0lyNhywaPq031gdSxBRIQhEjOueShj/SL3DpHwZ7CR5Y36jMWViCxqVhVJv1KcUF5x+O5Ar1sg6mAz3iBYB8K2uCrRUjzHuoMoV2WdOOPWLR5jLU5JI3Vzojns8Y4GcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOiU/RQiLyr76l6EQEz9SQV+TWwZAGxvTx701NtM2jc=;
 b=J+YemTItrnVgKS/I86RxKWzdu7ubVsokc9FaNkt+lMuJNlC+PGJQQVNkuVV3RJUDiNgRMDcoWzwyilL+Z0//YkB/N8IUD/uVHUm7xdXC094xkhRF8xxHRFIJRKk2SxdgfDYBXDO8NQy7Lph7zjf4PL2Jj1wZdFAvPb7qTBtr58M=
Received: from CH0PR13CA0004.namprd13.prod.outlook.com (2603:10b6:610:b1::9)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.27; Tue, 30 Jul 2024 18:54:48 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::a8) by CH0PR13CA0004.outlook.office365.com
 (2603:10b6:610:b1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21 via Frontend
 Transport; Tue, 30 Jul 2024 18:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 18:54:48 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 13:54:46 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v3 3/4] x86/mce/apei: Handle variable register array size
Date: Tue, 30 Jul 2024 13:54:05 -0500
Message-ID: <20240730185406.3709876-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730185406.3709876-1-avadhut.naik@amd.com>
References: <20240730185406.3709876-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 4199e651-b529-42f5-09e7-08dcb0c915da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OLG4YDvG5FvL5UMgOj+fE1rSrHFMD8m7zKQnNURMTZ0mVzlArHv8c+VvPEqr?=
 =?us-ascii?Q?tq3YhDHA9P+Ab8xyv8tITmzO+jJZI0vftZDHa90UFOjIaMGFW2higa3jzsKI?=
 =?us-ascii?Q?oFwZllfdXrk+UvE5gZOqXN44SsQQeYIDDUHqyrDWRqj07yIQJVKVX2abqzDN?=
 =?us-ascii?Q?AykSH5iXgCtpQIDRFXRYhKgPPqE8ilpHUO2oFeExPEE+LHSA5YOvkcBfTiPJ?=
 =?us-ascii?Q?dBMbPZPs+8iWdQdf5fxodenf4XoInmnyHwCRkmgOJzqbWGTB3FI2pztnSzvf?=
 =?us-ascii?Q?lxnG/7hdf012T+DC7sTaK8MbLtw4PJHjGg8ONCLNXvJGHlGIkEw9e0F/ehMx?=
 =?us-ascii?Q?3375FUKynjTUHaTziNVezhz0WgDXekbReZxb2q7WNF2nlkWKHv+ZSUkzK8uk?=
 =?us-ascii?Q?kjjPOqKaAaUn+DmzCC6cpTj32wKstlqZZxr7LxLVEjyQeNZQCSoGCMpaw9UU?=
 =?us-ascii?Q?SNAZ7cpwxvCHuol9yqHx9RYKcObUlKoAT+dkMYDPHVUJgiTowULCYv1g+kkC?=
 =?us-ascii?Q?p1h927rieXKdC9YaUz3sSEm4QR+aKcUQbm9AEZeU4X9teIkSE8SnIHUbP4u1?=
 =?us-ascii?Q?flrGash1RPHJ88TDSEDpEJXGCUK2bA629N8mWYQN3RuZ8Pl8oSXUyfMHbj1e?=
 =?us-ascii?Q?niDu5TiM+xpgOuTvXLPhN+WbeooU62ESTQJuysJEVNx2Zo1AuUigAwH8ukEG?=
 =?us-ascii?Q?L2/cYsLPNCcTPnD0uMI60YlLjnHKS+4Ua2WeQGkCnk2nupp3fnbA+hTUayGB?=
 =?us-ascii?Q?O+Otd/Tv4O3V84vYTl89DadjRVQjt5I8hEy+j5FKLnhxCjoWKmrk1IFA7T56?=
 =?us-ascii?Q?onTMxueaKPhSzVT9+qZ4xQYEMFbpKR2RMhHLrfUkF0ROQ9fGkQwmKgScfyhS?=
 =?us-ascii?Q?eLSPZxRRuWCoyv+ztlrTdN99ocimHz1Y45EWHKlYNOG+nTawFanofU6QOtU6?=
 =?us-ascii?Q?RIsasn4lFFzZ80w5kU+Ns4oDLKvby193BN7ZJOtBiu++sCTcYRYUx2us+QH1?=
 =?us-ascii?Q?XT9rQFJTFCyilYQxpjAXhMQQDNid1wQ159I7VCp2Q4ScbNtP75kXg9a+3e0r?=
 =?us-ascii?Q?IAr8rXs7vE/VXBehU/3v1e4fQfR7jlTSL788sIasqRfv4A+vFNtcKymuhUqr?=
 =?us-ascii?Q?JkhxQKEaHnOPDIHOuGaZBtcihDOUAtp8+i/GbU8mZfL9e/pvMPDBXsxKA4bc?=
 =?us-ascii?Q?sYUvubgtYw9AS87lbJ0eb9BYWUNKRkDILpQ2q4udxy6nn0TmYAd0brvJLVc4?=
 =?us-ascii?Q?DH4c6ymROZNk5EHRyqNgN4mcEWEdXQYDjWyFFcBDbXGgLqckO2HDkUaBv78b?=
 =?us-ascii?Q?kiXslUI72U6EjhQ/Kb/RPSNrEBN/elbfF2E3N48bziikJ1DYc/nYCVi/5Txb?=
 =?us-ascii?Q?n9sZMxr6rTqCDQADpzmS4mf4j+TfAIDosz2+6iE4aB3lhhSKuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 18:54:48.0512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4199e651-b529-42f5-09e7-08dcb0c915da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741

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
---
 arch/x86/kernel/cpu/mce/apei.c | 72 +++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index b8f4e75fb8a7..5949fc103be4 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -69,9 +69,9 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
+	unsigned int cpu, num_regs;
 	struct mce_hw_err err;
 	struct mce *m = &err.m;
-	unsigned int cpu;
 
 	memset(&err, 0, sizeof(struct mce_hw_err));
 
@@ -91,16 +91,12 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
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
 
 	mce_setup(m);
@@ -118,12 +114,60 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 
 	m->apicid = lapic_id;
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


