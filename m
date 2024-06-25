Return-Path: <linux-edac+bounces-1370-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAA291720C
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2024 22:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7791C23112
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2024 20:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8680181B9B;
	Tue, 25 Jun 2024 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fvvH/VZK"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B25181B8F;
	Tue, 25 Jun 2024 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345440; cv=fail; b=LSk98l3o1GHrJEoia8r6X7IhL3jBceEKhszBGgQC850/Nq4pj+P3YZ+ahBoXAsDRQfrybJ8ZjfMVLFcRioIXGYMkQ/PJv0TB+oe9yDeIRLgzBAA0GlR2ozWFAv7IBS8jcseHsU3huupGZqtqIX0QvJC5li0BQqjNgEzGUEhC/cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345440; c=relaxed/simple;
	bh=zZ2Q+PHOZ25oyy9ytD6y57aCOXkPpukXfR//MSMCJIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBgtzlZGmrKSWNV6Y6BYAQ2xNrzfJ1TtS1Y7M2jjVJZJKS0KmbnEPklSnK0pMkGmGBirbbFd0U+rGiBfY1DwX5dUQOcG5Di1E4CIRaqir2NOAHMWVi9xfFzahEknLm9Kndo19/HjsAShRoO2x0CTx/ITpAxjSxEJBKMX54ASpjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fvvH/VZK; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/hOjW+eo0MugxqnHKeKqz/ORFvnM7cb63TgluG4UhYyZw0kPYn3wZbPnDMHhGk4PNEe78hYLA8wgRRuhhkQcWHwNj1QBDHc/1nIqcYrVqRYnnMDoW/V8tGNocoCxR7OJL5cSGdscqb4r2hHwzoBBDwW/xTKkSN5MCD4oiyvZsXGp4VPq2jzL1dgu8W99yc7oAqtS84/AQu2Q/mI4exAyBn3ByvJg+gF60CEIkf9A594CCJLrMiE3n0FFWS5ulR64nkGe+VlCfwfSTuqFB0oaxyNIpt0MN03nWmfPtOg63Nuc0oKL6/qeN9aqiQs1sVY1qfenjA5qFj5kUTXPz9Msg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq+UoVLLMDivR6eBKjaH+bMbtIJGsRAbtW18Gi98Mio=;
 b=d6FbHEYaGyIR2Y2ig5qXWntOt5XzT+o84vDmhDRNjseFlH2gJVqrxYqcPWfv05kHtNSjus+gar09/Jpv7h9MlZC+CYMQPL1OBqsKfJuNLyI7w67jUQ+wxA7P48WrndKSQYiF3uOUEoQ5LVlSTvse52JAqJXUEMogjjhlhMf5RPf5drdjV+XTMAjuOoOy7+RlsURTFvp913IvdPKP3zB1Gqo4vo0eGkFFT6rsJE0Y7o9/Qd04CvUIW7DGmoPyF33a1JXmRNdFm/v5gl0uHW3fuifX67U5XCKh26clZpoCENxzUm3QNTkHjOwLx7F8lCqR+H9P0j4yZHy1q1y3+fhvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq+UoVLLMDivR6eBKjaH+bMbtIJGsRAbtW18Gi98Mio=;
 b=fvvH/VZKGFrCP0LEyzT+E/1fbWehlum7HgeOgCt6e2/ihbx0IS3ED+mhL29sh6NPvAVQcWQSzUZA7WAxOcf2YU8lWcuaghl7Nhg06LAPOxUlISNdYkAyQe20XHM7mRDDrsI2f0qNfO+ov1IcaRczQCNrRpYkLzsqB5Ia1+T0ANE=
Received: from PH7PR03CA0030.namprd03.prod.outlook.com (2603:10b6:510:339::35)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 19:57:16 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::49) by PH7PR03CA0030.outlook.office365.com
 (2603:10b6:510:339::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20 via Frontend
 Transport; Tue, 25 Jun 2024 19:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 19:57:16 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 14:57:14 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v2 4/4] EDAC/mce_amd: Add support for FRU Text in MCA
Date: Tue, 25 Jun 2024 14:56:24 -0500
Message-ID: <20240625195624.2565741-5-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8cbe55-ff83-4d83-2980-08dc95510365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QicD8wPJWb+YxzOAivP1HedJhcsYddHa6BohuoVkEevzoU2W9ekASBUQWs50?=
 =?us-ascii?Q?c+J4XofQBCVPACoUlUahg4gtoArkymQHCu3rHfWOuc19GSvYE8pYjLnJdKwH?=
 =?us-ascii?Q?SsI6pKgHeBLKdJCEHXme/v5x5GDYBuyUGCc1BRfUaGekXv8zKLW2FoRaXBSq?=
 =?us-ascii?Q?K5MINGO5sGTM9aOHArj4gAXwBk89505uGc2Jhloyq/eiMVPv5YRf5u5WUzAQ?=
 =?us-ascii?Q?jzWytJrhRhD/axcQ+QE7gBSaiHyGhMMec1xN6+qfYlQcs1c5jJLjwBFdNoWY?=
 =?us-ascii?Q?Htqkjr9QLUADJWvMVYuhToKX6MJlDWEfVaq94ncnd2C4kz04NjPEhVhLBBUN?=
 =?us-ascii?Q?+NO/mw3kLqq3nTmbjgYCZeKgTfnB2JyGIkuW3Q8jyh1yPBwdEckr4GeoIuoi?=
 =?us-ascii?Q?sgDOlat8ZpuuJbqZ3zZXli26qnNAfIVM6n5bTn9w+/+qw8XaRgo/fDvcJv9X?=
 =?us-ascii?Q?o+z3kmDO9zsH5GCxq+uiDQS6C43lbfz2J/kQW5pB/4woIMSgF6bCNgTFJJiF?=
 =?us-ascii?Q?dKB+cPyA4siPSnNIjSbeldeYfzRj+k0Y8g3HkHntZxq0IShAhgtEkFDgajmv?=
 =?us-ascii?Q?WsXrFpb0fd8SUrEVfacpB8RXHyo8bsELTCYWRvtuG2HwFmNTTy65am0lYfS8?=
 =?us-ascii?Q?zAWK+46MiK4B+7lAcJ5tyvr2DFUdY8js2bjkWNidOX5u3j+PkwqFiLb7zHVO?=
 =?us-ascii?Q?ExdXAr3igqDwyypXKW4x7Pm4336peyQG+BPkqmzcO9O5Nywayn3iE4ldIEB+?=
 =?us-ascii?Q?RLoD71Ls4MUBfWgPmdnGFsQItgJiRlXdFK2LmAQT31flpfWlm3qfZFY0xTzU?=
 =?us-ascii?Q?HkyC6CgNGVK21L0nb4BKJt1WdnkJma5LuWT6OAz7M2l+jbynQLcua15PC9ia?=
 =?us-ascii?Q?KXBE9sjgClC4ImOEI1vr4frh8nDbvMjxj7hdxmq/UW6w43fl+60zAWAekMyA?=
 =?us-ascii?Q?a7auVeSRwc+VkrFGzaEBYGFtRUlkrJF6DzFRucbHHzgxI081VB6ajnrxrGxh?=
 =?us-ascii?Q?EEm+wEoPMhSRQbm3M8KqiO9ya3NL1qNssuUuBzV45+XidWJsAW8z1Fm5Ut9I?=
 =?us-ascii?Q?Zci6cMksMiTyESMr6jvN14RTUh1l3CS6gnUFSg1OxdBfQivgdBszSl9Zpzhx?=
 =?us-ascii?Q?7YgZ4XTlPMpACXBtIaMYrJd7uIfakNp9VM/PgPTQWeUeP5Z47TDtcV5EDFE9?=
 =?us-ascii?Q?K5ClvnHsGqXph4aSHWXAKQSuBkrQrGbtVd09x7Jr82V5j9kO27TJ/FXGvyPU?=
 =?us-ascii?Q?GRI82MVRnvI4eh89KFyD5Sn+GbqCT5rWu5hS4qOUMqqZWQFwVeyjQ/eSFjPI?=
 =?us-ascii?Q?T1GQgNVAK50Uhl7EmCtiUprqDCjBvpHyav/pmmffn1wYw6d4NXz+waqeyPxi?=
 =?us-ascii?Q?LV3th1jPPrG7gAeH8NbyxsNK8TZJpidh5BSSTGoEB12/PAQaaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:57:16.0368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8cbe55-ff83-4d83-2980-08dc95510365
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188

From: Yazen Ghannam <yazen.ghannam@amd.com>

A new "FRU Text in MCA" feature is defined where the Field Replaceable
Unit (FRU) Text for a device is represented by a string in the new
MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).

The FRU Text is populated dynamically for each individual error state
(MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
covers multiple devices, for example, a Unified Memory Controller (UMC)
bank that manages two DIMMs.

Print the FRU Text string, if available, when decoding an MCA error.

Also, add field for MCA_CONFIG MSR in struct mce_hw_err as vendor specific
error information and save the value of the MSR. The very value can then be
exported through tracepoint for userspace tools like rasdaemon to print FRU
Text, if available.

 Note: Checkpatch checks/warnings are ignored to maintain coding style.

[Yazen: Add Avadhut as co-developer for wrapper changes. ]

Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/amd.c  |  1 +
 arch/x86/kernel/cpu/mce/apei.c |  2 ++
 arch/x86/kernel/cpu/mce/core.c |  3 +++
 drivers/edac/mce_amd.c         | 21 ++++++++++++++-------
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 2b43ba37bbda..c6dea9c12498 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -61,6 +61,7 @@
  *  - TCC bit is present in MCx_STATUS.
  */
 #define MCI_CONFIG_MCAX		0x1
+#define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
 #define MCI_IPID_MCATYPE	0xFFFF0000
 #define MCI_IPID_HWID		0xFFF
 
@@ -199,6 +200,7 @@ struct mce_hw_err {
 		struct {
 			u64 synd1;
 			u64 synd2;
+			u64 config;
 		} amd;
 	} vi;
 };
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index fc69d244ca7f..f690905aa04f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -798,6 +798,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 
 	if (mce_flags.smca) {
 		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
+		rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), err.vi.amd.config);
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 7a15f0ca1bd1..ba8947983dc7 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -157,6 +157,8 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 		fallthrough;
 	/* MCA_CONFIG */
 	case 4:
+		err.vi.amd.config = *(i_mce + 3);
+		fallthrough;
 	/* MCA_MISC0 */
 	case 3:
 		m->misc = *(i_mce + 2);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 3bb0f8b39f97..cbd10e499a28 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -195,6 +195,8 @@ static void __print_mce(struct mce_hw_err *err)
 			pr_cont("SYND2 %llx ", err->vi.amd.synd2);
 		if (m->ipid)
 			pr_cont("IPID %llx ", m->ipid);
+		if (err->vi.amd.config)
+			pr_cont("CONFIG %llx ", err->vi.amd.config);
 	}
 
 	pr_cont("\n");
@@ -667,6 +669,7 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
+		err->vi.amd.config = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(i));
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 69e12cb2f0de..6ae6b89b1a1e 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -795,6 +795,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	struct mce_hw_err *err = (struct mce_hw_err *)data;
 	struct mce *m = &err->m;
 	unsigned int fam = x86_family(m->cpuid);
+	u64 mca_config = err->vi.amd.config;
 	int ecc;
 
 	if (m->kflags & MCE_HANDLED_CEC)
@@ -814,11 +815,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
-		u32 low, high;
-		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
-
-		if (!rdmsr_safe(addr, &low, &high) &&
-		    (low & MCI_CONFIG_MCAX))
+		if (mca_config & MCI_CONFIG_MCAX)
 			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
 
 		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
@@ -853,8 +850,18 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
-			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
-				 err->vi.amd.synd1, err->vi.amd.synd2);
+			if (mca_config & MCI_CONFIG_FRUTEXT) {
+				char frutext[17];
+
+				memset(frutext, 0, sizeof(frutext));
+				memcpy(&frutext[0], &err->vi.amd.synd1, 8);
+				memcpy(&frutext[8], &err->vi.amd.synd2, 8);
+
+				pr_emerg(HW_ERR "FRU Text: %s", frutext);
+			} else {
+				pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
+					 err->vi.amd.synd1, err->vi.amd.synd2);
+			}
 		}
 
 		pr_cont("\n");
-- 
2.34.1


