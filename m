Return-Path: <linux-edac+bounces-1083-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C66E8CAEB4
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 14:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118D21F22D93
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 12:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04B27828B;
	Tue, 21 May 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hmoQNcMi"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212667710C;
	Tue, 21 May 2024 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296093; cv=fail; b=u9raUw8je1oG6KiegVxtlAQEXURz9a03V3HdMj9uli9CQgsds0PtIJLsEFg6P+bl6aN4A2pO2Po1f30wFOdBeQ/BNchcPngxkPvyrMtwndl+qSa0O8iw4IULxT0MCjUQBHPLGTGhrJMjiVkcfLxn/Bm1PE3wd6+6MgYyGBkPNWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296093; c=relaxed/simple;
	bh=xo/gLq30JyX33MbGOGCBSvaNLgrtocQM/jUKK4XADCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWRISz90aBH60DRFLvpZa9y3GUDGMsB2TvNXgybhmM2xfSjynaah1MMNkpubOhO2S0Jy3xeiDrfpT1F2KjGaIZp12EOep3PcBhnjNksGGw2t+WIAH6kuy9pGYRP7gdyux4AoeQuidOV5/UUHsAVrWvvvvy3laMvLDdOYTY0H6vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hmoQNcMi; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SN/sJ64/KyIbn/ENxGXkRohV2IX4uljB2Ds16sWxqvcJz4X63VXbfdWa/poAxU0hi6MFLcBlnakuUpIanNVdNx6qQQaO+zedogNTQdXctFeCnL+w38u4Z3rZMjUnd8zhRPo7C4+hZRVo9E+X8dFV9k6jgHocEPil1hd3q7IKk6GQ4tyIO00Y9cGxjdfOGlOBC9tWoGjXDkaEqn/+Z4Gg8cG5LkO+9/v1F/Z8Yk6up0umnR2yXuORmfEYyRxAku5VWIJSPMoATOKa1SRRh93xfmkWLbJp+CcqvK4LiLhUjHA5zRDe69VTdEq65UOoP+kSL8JkdfEfJ0CKaW3S3YqWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9/OcjxwcpbQdn5q8XB1jUDNeMwy+fP7usUr0lSEK18=;
 b=cZugL9+u/QR/FhipRDYG5tcnTnNx3q3Dgi0bw/vQc8sLODpkIpiTECtCsi25oD4DCF2X0LYwdqV7f7Xdan0AB0ns6py94SPavJ+Wielto7aRdQChFRzHhYB+yBsOOH+BZA/gVANTrWAbsz18Q1+yfb/j9JY+LB4Lng+foo4TjSCuBiF2aZB3EDY6s9L9dj87JVQxXIX/j2cMCberM1uSQxoHcylQmv3gmoCv4haadGmu/O/G+cj3J0C3gGBa4a/LeNhaaWgjpm+mkilrabbtAqTksmvnHj5Y50YWJl4FonNOq/a7VGyZCvqWGBjO2F2i7UnrFYBJsNpdK9NeZFrMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9/OcjxwcpbQdn5q8XB1jUDNeMwy+fP7usUr0lSEK18=;
 b=hmoQNcMi5hlNtdXBvCXtX0VIWRnLZtQmg2CSNb4ujBN++tdSOfTpQknvJAaIB6SnsFAz+OxBEop/2tT0QLwfmQ3P9O7+YSvemvcx0QqfNWmH/iwBO6xupcY3izoXoyPHlWr7R0zfv1LH1sU69czrSmkupfTBaX//33+JjZsrKig=
Received: from PH8PR20CA0003.namprd20.prod.outlook.com (2603:10b6:510:23c::16)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Tue, 21 May
 2024 12:54:47 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::d4) by PH8PR20CA0003.outlook.office365.com
 (2603:10b6:510:23c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Tue, 21 May 2024 12:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 12:54:47 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 07:54:45 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 2/3] x86/mce: Define mce_prep_record() helpers for common and per-CPU fields
Date: Tue, 21 May 2024 07:54:33 -0500
Message-ID: <20240521125434.1555845-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521125434.1555845-1-yazen.ghannam@amd.com>
References: <20240521125434.1555845-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: bb65989b-808b-4886-46ee-08dc799531ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VtYVgMtuotHq2yGSM0JwhrOl5FW54MWS4KclO9jPghQCn3h/XCM3NbkbWIJU?=
 =?us-ascii?Q?K4rDhJggcMNgwRCAXG96JqHgpoGLdRHoc1kj96/PgLOuWpkOgNOg53T/qZrH?=
 =?us-ascii?Q?VPtVKxT+WBN8HFxuOgcEBpirC6F4NvZRO26uV/tr9fCVElcuGGKUyMft9PHv?=
 =?us-ascii?Q?xgy8wfEb/8kdfMhR/bLhr7ZkJ49sTywkCZLAzsZgLzuNoHn2oBfI8xrUvyN+?=
 =?us-ascii?Q?6rjAiwggIs7Otbu6hZ1Vkza9sYUJ7/QwiEFdw6CfiHwlwMTvGgbLoAXjMA0P?=
 =?us-ascii?Q?9J4F2GfqUIwJI+Q2Z7msthVKyWn0V75upne5kbgOK1W7SBakg7/JMw7U+KNk?=
 =?us-ascii?Q?iVfdjtTfso/xXWTiW5SrjnBaMqKKPmIk9TPDkjHPMiVfTriVNWyvFhu00Ggi?=
 =?us-ascii?Q?za4PnX9LGWLkwaKjHJZb8KEpfaIo3scSL1Y9oVd7uLoogsi6PyxJlTv3pGgF?=
 =?us-ascii?Q?fle+zY5eqv6A2EGwBomcGBIoQeTsxAWxV5MKE3qtMr2J0F24Ur3/12XrEqej?=
 =?us-ascii?Q?L7JB7bSJSdocAID2RRli1BO+/ZMRRm02myaNk5TeTBZj7ElbSrnk7z5wmHHn?=
 =?us-ascii?Q?W9K9l8kkRwdtrK3QM76qTvABaNDdMaTaE9mjlB0Gbct+Mlx6WTs5rfPAOP8A?=
 =?us-ascii?Q?AH0GLpDHWyleVRVd7p1M7z0zgHr7/5if9xZ06hZzR0s6DzF9ml9rm6tWoGry?=
 =?us-ascii?Q?gOUCO+7Z/97bFau6YmOzrIJpgUdez4HjUaKdxQZ4XEBcqc9vqUwmSqMe1MAr?=
 =?us-ascii?Q?GrboRO1tFDZjOM+4/EdV56r/pSo75uvxrhrEIXEN8e103Cne5UcvZxkbdKbl?=
 =?us-ascii?Q?8AKn2QpFIBkRZ/HlJKxGw2Kjpc+MRlIipixZ7W3T7x2qrZM5tp+thviYEwMm?=
 =?us-ascii?Q?9UxKotJrqBg9tu/zldF8cHJqjJxxdmQef7ucm3MGf9eFOhSGDkXuqZgbxhwh?=
 =?us-ascii?Q?8bljasKp3GNGNpC4nztt9wIrxEqVp3mJKY3GNl9E9i4lM0Di8O4STZO3/gEP?=
 =?us-ascii?Q?MmgTg6/glRiXhaWh3xXUVFPmRmme0xRBxA27W+/kJkOAscc3IdNMVNe0Hc+K?=
 =?us-ascii?Q?cY8NFIbcdwMvnJtBz54EnDNfhAA4OuLhdhMlMeUwZ9dntuyL4ZaVZrdNRFtL?=
 =?us-ascii?Q?bwYvbm2o8X0mMvAFu6NtMpJfJaW8VMQBntJRVPxkxE/JyWalwaKR+YC0quQC?=
 =?us-ascii?Q?bXjrFxdH2uidytQ76GI8yit0Jmw5qPSggble8tckKNUVDAUGWxQmusjXNoMI?=
 =?us-ascii?Q?Lh40fkCRCOLoK1dQuT/Wu/OFHbdVXDXBOhv+IEF9lc9M785BPFLKWBkQhmGh?=
 =?us-ascii?Q?wBDnhOUu+ICRBFe7W1bJPZkqHF03NwR9DNI3Cm8bty3iB9F+O1IhyNgIGECj?=
 =?us-ascii?Q?3w1f/z80X8myJP9XXVh4RZt4mVvQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 12:54:47.3199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb65989b-808b-4886-46ee-08dc799531ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054

Generally, MCA information for an error is gathered on the CPU that
reported the error. In this case, CPU-specific information from the
running CPU will be correct.

However, this will be incorrect if the MCA information is gathered while
running on a CPU that didn't report the error. One example is creating
an MCA record using mce_prep_record() for errors reported from ACPI.

Split mce_prep_record() so that there is a helper function to gather
common, i.e. not CPU-specific, information and another helper for
CPU-specific information.

Leave mce_prep_record() defined as-is for the common case when running
on the reporting CPU.

Get MCG_CAP in the global helper even though the register is per-CPU.
This value is not already cached per-CPU like other values. And it does
not assist with any per-CPU decoding or handling.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c     | 34 ++++++++++++++++++++----------
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9dfa80084054..dacca82d45de 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -117,20 +117,32 @@ static struct irq_work mce_irq_work;
  */
 BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 
-/* Do initial initialization of a struct mce */
-void mce_prep_record(struct mce *m)
+void mce_prep_record_common(struct mce *m)
 {
 	memset(m, 0, sizeof(struct mce));
-	m->cpu = m->extcpu = smp_processor_id();
+
+	m->cpuid	= cpuid_eax(1);
+	m->cpuvendor	= boot_cpu_data.x86_vendor;
+	m->mcgcap	= __rdmsr(MSR_IA32_MCG_CAP);
 	/* need the internal __ version to avoid deadlocks */
-	m->time = __ktime_get_real_seconds();
-	m->cpuvendor = boot_cpu_data.x86_vendor;
-	m->cpuid = cpuid_eax(1);
-	m->socketid = cpu_data(m->extcpu).topo.pkg_id;
-	m->apicid = cpu_data(m->extcpu).topo.initial_apicid;
-	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
-	m->ppin = cpu_data(m->extcpu).ppin;
-	m->microcode = boot_cpu_data.microcode;
+	m->time		= __ktime_get_real_seconds();
+}
+
+void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m)
+{
+	m->cpu		= cpu;
+	m->extcpu	= cpu;
+	m->apicid	= cpu_data(m->extcpu).topo.initial_apicid;
+	m->microcode	= cpu_data(m->extcpu).microcode;
+	m->ppin		= cpu_data(m->extcpu).ppin;
+	m->socketid	= cpu_data(m->extcpu).topo.pkg_id;
+}
+
+/* Do initial initialization of a struct mce */
+void mce_prep_record(struct mce *m)
+{
+	mce_prep_record_common(m);
+	mce_prep_record_per_cpu(smp_processor_id(), m);
 }
 
 DEFINE_PER_CPU(struct mce, injectm);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 01f8f03969e6..43c7f3b71df5 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -261,6 +261,8 @@ enum mca_msr {
 
 /* Decide whether to add MCE record to MCE event pool or filter it out. */
 extern bool filter_mce(struct mce *m);
+void mce_prep_record_common(struct mce *m);
+void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
-- 
2.34.1


