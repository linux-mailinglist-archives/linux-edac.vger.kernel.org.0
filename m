Return-Path: <linux-edac+bounces-1369-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E105917209
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2024 22:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9141C26354
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2024 20:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B840C180A98;
	Tue, 25 Jun 2024 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UYdAq+9d"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F9E17F39E;
	Tue, 25 Jun 2024 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345434; cv=fail; b=B/I8YCUGr26ZWqSGTE81jyUQB7sCvykSEY8FE4b+SQu64B5zhZBJbvnev20HakHrSLDM6OST5bXXQdz+8Zp26+cbOg6YuPBG6O1ZJ88lzEXFnaXl/yrT3ZbUDoml/73tqv7TL4fwu5rfF2Eqh7VC39A/gzuSm0WCZWk61VQ2dJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345434; c=relaxed/simple;
	bh=U9OPar17EzubovNUkm0XKNYU2n0Y0X2MFmfGYMfrYpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJsv2rp4Df2mBLPWFinu+9ADay7qWkC+/G0DvMDAuVqiviLvw5Ej1aV9zBWjIxlvKXLtCqeJAegkjNB5YkBlJCgzlkVH7y+GP9MWfIgaxOoxpL0p4qpBhC2aExrfnT72SigYNqSjGGkCkVjwwr4vrLmWhUDXAq1h97pz9k4o3aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UYdAq+9d; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzIosnrGUj7LhWUsr80mlWwt0IbXqJlRCFQfBfmLtgydjgs1dLI1fgJQ0P32tbtwU7Ti6ZH8BE2+ceYOYO4/8l3yuudoyKs0/SlHVUy87etNPvcBH7DucJr4H1xg5EN4gWZbZMtSkSmZ36ti7WPkKCJZXvREQOTiFuHOsn2ir2tKSyYEMwYSlN2lm2hdfCzsrPlwJQYeEPlcswPLERDazTfSRJE/vF0xkxSCsTNzvWsycx55fty8fvn8RyapUqibWKmRDbRhtYygNr+aNvKNVkMu/OcHf1HmpKv3QjltF9oKlwLan6IspTDmfPiScluqXuPWWW8fFyikCsJ7D6Bt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sh3FHbjXH/TKfzOWgZT4WCqS+nLHmt2QIMteNNez7wo=;
 b=S766J6zIVAX/BCv6jAOhfUhlmoBYb7jPpYe7bbvTOLAx6AcnHDqtLpfitjK0rfwM6HdwXVrgTJfDPKv6BOBD+LjGz/oy+r4LrGteyFETjsGhRQN6yiA/+IneMeihI7cipLTx69EM04cCq1nWEuWe9lZChHKMZRv6v7mAcvtiFYtfKN2c8kXr1C6ArfgdYXK3kBjQIjTCmI7fpr6ih/9uFfJcZu6EL6eLhwookQKSLvH/PizfH/uHCKrES/e6ef67KzWUaEGSCIbrC7r8vU5ClYV2xkwSb3tEK8vUrMnypcT22KwM6Vk9LXt0/ZECkw9mq/pTNlET6pZV0SJdb8ETVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sh3FHbjXH/TKfzOWgZT4WCqS+nLHmt2QIMteNNez7wo=;
 b=UYdAq+9djkXzL1wGBKGzWCEed64noQxQQy10/Z20mDwWJwJ6eltmjWqcUffYJi0DC3b4z41tj0ADsiPR5kpB5o3GC+Tqjhyr5QkmDw4l5KSdTnQlqq9OkyBbybUTK76AV3AC5YRIsURoMVlMyIjPI3lsgtIbq9dNCpC4wW1mgGU=
Received: from CY5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:930:1e::31)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 19:57:09 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::31) by CY5PR04CA0018.outlook.office365.com
 (2603:10b6:930:1e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 19:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 19:57:09 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 14:57:03 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v2 3/4] x86/mce/apei: Handle variable register array size
Date: Tue, 25 Jun 2024 14:56:23 -0500
Message-ID: <20240625195624.2565741-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625195624.2565741-1-avadhut.naik@amd.com>
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c51b1b-be1d-4912-70b6-08dc9550ff6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sP004em7jAmBwBadMKdWVz5TGgX3k5v0RbDTmqY1Mqbe1p2Uy0LwPjFqUPQA?=
 =?us-ascii?Q?8CT7buC7sQFNQotTsF0qAfyOHqnDVlaT1m3zgoCTVETjkcy1s55D0AFpMIIm?=
 =?us-ascii?Q?RmmmcKIuXm/cBe7VEbzOh0eTUs2b0Psgoo+nf9sMoesodfpGjudmN5P+KWU2?=
 =?us-ascii?Q?K0osgjIA8ATpu3EDXMuLYydas6jXk9I36tliDb82SmWlL1KIqDZe8eptKb3u?=
 =?us-ascii?Q?e3qk94N6kD/wQ/Sd4O/YxvBR2gCEb6HzJJmjgT3pSi3O4QJEfV4xMSce+vYt?=
 =?us-ascii?Q?HCsYPTD/qc5SVpjKSn5MWqHxAsXWZwl+J+2xsELAT313IPl0h8O/2eb8pJmp?=
 =?us-ascii?Q?7HjWDrjzOyhDF4ZG2t5xa/N3wBjN4FHft5C1mSoTEGwTLyAdFaEt5htKd/uK?=
 =?us-ascii?Q?2n6Fvd9V9p4DD9EoqWvwl4gQ3D/ILH7GfAvKMOrg0Pj4aKwxU0T+BvgKJVw/?=
 =?us-ascii?Q?uZJcJxX8pltyCLoEZNMLw4YzkzkKKlBKS8ZyBI/URX85GaLHnbJmjBAnfBQF?=
 =?us-ascii?Q?gi3t1ep7MlIR45h5IQsZ5akq3LhGNA2Guqu6VV46XLoFzGfkX//Q73vjKRbm?=
 =?us-ascii?Q?UDjqP7EpbLI3/QU+FQl6QtCyyG8qvgFr/Fcvg46dG9x4/ZJ2grhRwjUaLEzZ?=
 =?us-ascii?Q?mQFnX6Pzs+SAlsRxIUMGcQLLzgZDtnrQEG/OCt1Pbl0EgsEORH5bCJHSjxV/?=
 =?us-ascii?Q?Y7zlH0WnPQNed8Ex0Xb0bvaFwNR6SC9j8erX0QNXvRvFfdHaQBYA3XH1Vy01?=
 =?us-ascii?Q?nWDBWqKr1xm50Csiku80lbwAJrUUXtcqEj+UEkOiqrDaoBZ1vBAczOq0t9XT?=
 =?us-ascii?Q?xowf6c/xiqjqA26uULN2OwN4lkRfy5j07qhBmxRXXZnA0ZkjrK9GpP/2MkHv?=
 =?us-ascii?Q?pbUbzDaJjiFMopxNnxWagMwLY3XqDANDQkwaqZg7k9fPGgSibMr6XMEKXap9?=
 =?us-ascii?Q?9+zLd8SKBNYMCT90eSYKWoQzQWOdllN7L9WhvjdHc6aUePPcoGQ0nht7o1gi?=
 =?us-ascii?Q?geEnmuXoo/0RrDogIPGiY6KNHKloajxVijJj6/hxfPTAV81xJ4PSPMvvWo5J?=
 =?us-ascii?Q?WQe72FtcoOCRrBZ1ArbHMeynVqxt+jaL2y9y4ugEuyJNkF6YgCmUueKy9xZI?=
 =?us-ascii?Q?Cv0SFgnGB3l7m40nJJITpsQfiUG8qkRuqh3fxs2EePur1myoK2J0IqUkSfRR?=
 =?us-ascii?Q?YPKt0AUExzB02c6o5ifC4baLexZwKEG9eNANqS8VZ4H/wqhp+zIjwqRHJn2N?=
 =?us-ascii?Q?rEAqgIErJCoXMIsJ+achNXgK5+17E+9cCjjXPhj4V5atHTck5kxRlKMOcwl1?=
 =?us-ascii?Q?nUooQRoE4eO5qbWKkQVfWlyKS6/xW+Np51JGLV5V32dAhqT4SXVxhuz6ZnFA?=
 =?us-ascii?Q?ZHs6brYwG3vvYxYarFg9nEgGBzIjbMKshxE/bpRrmpsniivdyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:57:09.4024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c51b1b-be1d-4912-70b6-08dc9550ff6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

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
---
 arch/x86/kernel/cpu/mce/apei.c | 73 +++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index b8f4e75fb8a7..7a15f0ca1bd1 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -69,9 +69,9 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
+	unsigned int cpu, num_registers;
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
+	 * Ensure that the array size includes at least 1 register.
 	 */
-	if (ctx_info->reg_arr_size < 48)
+	num_registers = ctx_info->reg_arr_size >> 3;
+	if (!num_registers)
 		return -EINVAL;
 
 	mce_setup(m);
@@ -118,12 +114,61 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 
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
+	 * Switch on the number of registers. Cap the number of registers to
+	 * expected max (15).
+	 */
+	if (num_registers > 15)
+		num_registers = 15;
+
+	switch (num_registers) {
+	/* MCA_SYND2 */
+	case 15:
+		err.vi.amd.synd2 = *(i_mce + 14);
+		fallthrough;
+	/* MCA_SYND1 */
+	case 14:
+		err.vi.amd.synd1 = *(i_mce + 13);
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


