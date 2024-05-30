Return-Path: <linux-edac+bounces-1160-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E78EB8D548A
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2024 23:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFCB2878BF
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2024 21:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEF2181D03;
	Thu, 30 May 2024 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZJR1JrT2"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241018130F;
	Thu, 30 May 2024 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103837; cv=fail; b=m+HQeccvNUocAX/3g0iLe6pabEt7njnwdiURzRvz42JmOXtygwPnEndfAzbtUd/ZP57qZaP0VzO+xBmFOEq3aRFEHueW0Rm2jm8DcJUVyVt9tFdgWfFN99sO8fWQ0qmEWbx+qWHHLDrs+vT06DVNXi9bTwO8Vw4NGXSuvA0V2gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103837; c=relaxed/simple;
	bh=8wT+S9xFWR/56b2IevNaYTjuveht0br3mSd2/0JLDJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2aRQ/xZ031zRtU0wnbsVM9xB05fqyv7xd1sPjEman29n+VO6yX9EqTFf2ntIkuHneuwKI1uWF4s1nFBNdmnJ/oWIJinrcJq7QygybWM+r370SK3eYYH0J0Io80SGhk8A1sVxaCNN5PAH1hqSwWgDQaIdoQrwA0yyAJQzuhFFsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZJR1JrT2; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScTz8xoDlvv48koTQsgXc/hvnGDzpoTXwuR0vjmNdT2jNoN5OAqMrBfR2coJuWvoaK7PeX/LBkhfdd+E51E244FMVazfx4Ev2by+aT4WzwjnaWGC0bXkHHhCz0ZijoBptd6K8mENta/2jiVv84EPixptvFSEaDt0OHVZx9jJp4Nqrnw4IH9cWhOcRZYQxcTnB0sOjtdU78dN6MSiBc7wESIm9fEbNJDzxjWaK5/wP6Zv6CntybuoWAnX+Rhu2Qnc+OjIQOAas7K6Cm+eGspbLCt1MmPD+AkkqhmLv7xbQuJHWQH4KgqmvO/LdyxsbiJblIeaYLO7WFBJqDs6gXaXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmcae4TM+w1Zwn60GaLQvU+QpbTln4MaMCjShDDBSco=;
 b=Fc3tk6Wb7JumRiNlahdJw60LNNVm06RThWkJOviWTNc1hVCnsolEOwwZ9tnVmpOpXrZWYa6WH/5+d5EuE9o38fTHJWmBFZCyVbKJnug56u7c7oFCx7lujABr9Wj6GcpLA408HIm90hiKNXyN5InUzP9SWzQVL8ABC1DNE14bx2ardFjWkLL2cfLyEQaXZfVExlN4nftpftPZlSXfVLGkmr1LK6OtA59TkczkThHoZfxvuw+xj1EgX8ZGfT4APiVLuwNha5phAzYAyUe64AlQSeDdvqXoNcTW3TPx0E7v9sgGn+9LebWwnCl7brtAatKi+CboqdpGsaL9+S9dpOCxpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmcae4TM+w1Zwn60GaLQvU+QpbTln4MaMCjShDDBSco=;
 b=ZJR1JrT28YgK792aRo23jshBTAnfCE0SkCas5kuQ9Lt1+oovbpgu57iK5pRM2gMXeIQ2dZEWigW8dSUNd3OkgUmO+rS+gswgl3iGQmH7gumETARVfrOmP6FNJnINc4C8WXmw1ztke/B53kBl4n279IfzyeOTJvs/CAighQLNKNY=
Received: from PH8PR22CA0020.namprd22.prod.outlook.com (2603:10b6:510:2d1::27)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Thu, 30 May
 2024 21:17:07 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::58) by PH8PR22CA0020.outlook.office365.com
 (2603:10b6:510:2d1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Thu, 30 May 2024 21:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 21:17:06 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 May 2024 16:17:04 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH 3/4] x86/mce/apei: Handle variable register array size
Date: Thu, 30 May 2024 16:16:19 -0500
Message-ID: <20240530211620.1829453-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530211620.1829453-1-avadhut.naik@amd.com>
References: <20240530211620.1829453-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 77811aa4-d236-4a52-3847-08dc80eddbb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C8QcyK+Tvbeuacef0zqsLFsW0eGzGOd6KrOPtBAHIj6YXNEkyYUALH69izjo?=
 =?us-ascii?Q?VjSvlB/lPYWBDR5h8534G6a7aTTASs+9LbcYARhVGMEYWlJJbO8hcAY39PSp?=
 =?us-ascii?Q?fWOV4C2oKoqfPiEcjaQ+aPMOAvEuPRX2590nSJaVZgKlD0u/xTL/0uvOBkGv?=
 =?us-ascii?Q?hAUOsUUAHnWLblu3xM4XBwzOUlpHfb2hR8m2tZ5Tits5d+t0RrDUEcY54laR?=
 =?us-ascii?Q?5SSZSlgPFdMH8ddzzkLwwSV1z61RZ2RCf9zdIqp/8lOjz14lajGlffp4TMo3?=
 =?us-ascii?Q?Ar8lan32GqNeoDBrJoSZx7YVivtkNEcYvkPWJGsly9mR67eICk5yoMovkBIo?=
 =?us-ascii?Q?y77ocogirDNT2ozHrw/wsXFZm8GyEPFh+WmdnsDzXxPKWRzU54h1iy3l8YbQ?=
 =?us-ascii?Q?Hfk4V/bD8IQ2O+5Wl/yaJPRktpxpPRcnvzr0KGRgrerbNoKLcZ17nQWggo7P?=
 =?us-ascii?Q?6i1Ow6N7zwpQTFXyZF/5qTzHWSA0iQh+rfWG910OpPtCLyTD6502Bn4ldaI+?=
 =?us-ascii?Q?r0Y3DhLU4Vhln2gVNhdJ/XqwCrY6+Ym74317mzBNzo/Wwf/eXHrsCzSNPv2E?=
 =?us-ascii?Q?sbtiyMDGtgyDZZb5A3Y0R9szPG+9t2q3WMJaE0jPhZvGtEVvMdiyaRj52BL+?=
 =?us-ascii?Q?On75MdKPxy2Wc+QeXvlVLmFT+Kw5BbvxjRc+qyoQ79RwSHUkkYEZWsIix+n3?=
 =?us-ascii?Q?oScJ0fWSlZGyUGBqE3UGQAyqbmfw6ZHXm0uWrHmsSl8W15Kcd9iA0a7USWSO?=
 =?us-ascii?Q?H8kjs0kPqGn/AZA8/Rx5TWGApkKNdNemzUe3eMMQL3es6bvkFJhksv9YiyuL?=
 =?us-ascii?Q?aYnLKNT3Rsr5FhWl5Ps1zP49yRl1KRQrMhJ0mCvyoJTzBTWX97FqUuwKHOGz?=
 =?us-ascii?Q?5+rZDYs53pSqQHilKr3Y2qbtpMADNIr5AY3PziAsigvycnfktn9fdLxxpg4q?=
 =?us-ascii?Q?jF9kW1WE8AbpkuW4sJCT7ydowgsofsIR0eJvmDPjeu2zLGhmSnAW75qFRfBU?=
 =?us-ascii?Q?yn2AIJ17juEJ4yGW/KOp/kEN+gj6Z9TgCcUUbPon6pLXTG3giK5l2cs5Obgb?=
 =?us-ascii?Q?NsvZH4Li8CcR1eYV8AUZ8YvKSjLA8fh4btPeCLRqp3v3f1VZY4VhmjRTDimP?=
 =?us-ascii?Q?BS7e/InXrd28vyvnngiwoK8NJvWw5i97TRJthOg55fMNREerKmFTcissCfcq?=
 =?us-ascii?Q?67idrw7eSDQZOIhzzAFfsvZknp7GErMPwfvb6lwYNdlFJNa7JDBPyjod0VmM?=
 =?us-ascii?Q?YWfRhHaaJMtwAw5srWu5udpOEEO5KFdybWTmtw1+eC4/CkADID8Nx7adNT48?=
 =?us-ascii?Q?A+gWgfCuq9WreQ15SyBfjUXazTFAgznXHlDCqWxEyE9UevzsEFO2i6XL6E++?=
 =?us-ascii?Q?ZyBjXMqc/VhpNwyNYsD7wwGMJNQl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:17:06.0783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77811aa4-d236-4a52-3847-08dc80eddbb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216

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

Co-developed-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/apei.c | 73 +++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 4cd6312423c6..8fd4c42ddc06 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -69,7 +69,7 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
-	unsigned int cpu;
+	unsigned int cpu, num_registers;
 	struct mce_hw_err err;
 	struct mce *m = &err.m;
 
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
 
 	for_each_possible_cpu(cpu) {
@@ -115,12 +111,61 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
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


