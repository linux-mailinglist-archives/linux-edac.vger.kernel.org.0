Return-Path: <linux-edac+bounces-1093-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9EF8CD7EB
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 17:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0821F21235
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7582F2E631;
	Thu, 23 May 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gz1V/GUc"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4621CFBE;
	Thu, 23 May 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479827; cv=fail; b=tX4t6aYsvr7zmW841J8ZhWY9Wl41ZibHrrbRKOBL2b5Evl2/WX6ZDH/ly1rbRyyYSPxd6TG6vYRipFlFl1qMLGCQrcmx3P65njnGB3R6Wf6Qw7uzMewn7KLzcYqMU//LEShkxpPiYKNgnGmtCcgeQXk3U4/eXUaG4WkgPiUHV18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479827; c=relaxed/simple;
	bh=6VaFCzwO2aWCu2IqFWyrfzNeDlmyzNu6ajq/EoK9UFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKQ9vvlejPZu0ACGM5H0dG9UZp0ns9o0eCQoVsLdtF/4SC9Y+iJwKZoROw0uuuUspMFBFByYhyRk66WYU9G/FTFM7ioCjU84z45pJbKWqXqJ2a8uF5NXL/ttZIDF8QhTygx8B85GkCje+G/jV6dpaNFIq9UXbVanEv9JZmjc1KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gz1V/GUc; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRg99yQXSAG5pVRgjsZg5W/jOHOvaRtsQXFE0p8ohTneg5VDh9J/VOC+dyymI7/ZB5G++zt2HifiJl8yEFQp18M7vlwT7UBuF5WGN5qYqoCvus8vB5d+B9I4+cPKNK4Y+2Uac3ovzJWFJncgnd4Ee0ayOmd1MOBBXEyqnzei3GNOMay16mi66LEhL1r79y+LbjCSGncMz2Vm0F0bbWSQlzr6giI+1v50+KpfcseARs5eBK0nLI6wI6hY2u15QKDPKbq0F3topIwbJg+wtBiH6QuZTny2CTzCWYGaxDxWVFh7JwYgj0nyk3Srg3PfX3I6aGGJ87jzu+v3wod06/FD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAVSUJzt77JEqfP4QJYqSDOhH4BmmS81Dbf+2Nt6w3o=;
 b=SxY3l+GqexTpvHeVaDsyyzbcgjB4QVxcvMyVtAqKCIWNJ80an9Bo25PBUn6rbTgMfYyh6AGzkCF6zteOEu4lXOFeSSdhCjmJlR02/T51bTPzyKHbIO5UbuHe/GjS33423SQACRjtygj6IwLlTroumXCDs+uEjYzMfG1lMXzO0N6Jw6fOK/K72C7pJMK5bq0ZAWyuoCRNAJTFk0NXQyQG6Pzbb8qi4T4ZgCfIY/3OYrAMZvmp6qxmUpkeW3UI8HaWR1QFMltudmTrvYPdDThAH1EmNb5oq3Hl7zKBFAAoa07PX/ws5FdaalbtRC++m/wB/IyohRua7WslJd3n3Wwv8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAVSUJzt77JEqfP4QJYqSDOhH4BmmS81Dbf+2Nt6w3o=;
 b=Gz1V/GUcbURT3rYREFEuWBz8LtZZQDuSpO727j3Cw4etFug3+tJEmz8rrcJc/pnpxnmHNUHpsSVx98ZHa7FJS9s/0RuzV9abeX9MIxh6Tz3ijGdxDLTu7llLAbtkrDrv5/N+EPCflHPpGxsomqTLtV0rJwCDgu0y2vtEwxeydRM=
Received: from BN0PR08CA0007.namprd08.prod.outlook.com (2603:10b6:408:142::32)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.21; Thu, 23 May
 2024 15:57:03 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::f6) by BN0PR08CA0007.outlook.office365.com
 (2603:10b6:408:142::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Thu, 23 May 2024 15:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 15:57:03 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 10:56:58 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 7/9] x86/mce: Unify AMD DFR handler with MCA Polling
Date: Thu, 23 May 2024 10:56:39 -0500
Message-ID: <20240523155641.2805411-8-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523155641.2805411-1-yazen.ghannam@amd.com>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cf9f9f-85bb-4ec5-0fd0-08dc7b40fd04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Ojn1+fhx5JPhpFxBvVy44MaHiWpg7SLU0MIn6dcq8hS8UjHoRev1DKdDetv?=
 =?us-ascii?Q?PkMo4i+OP620yJhr8lzzXCOe0x1LJ9NmVOntFYKM3xsBuyNt0FOSdOCOdN0y?=
 =?us-ascii?Q?A6/xycZwWF6AK2ZIqs9gLPDhCHO2oCBrzA23tZN19LyQIYgbku0PTuQ/N9Wo?=
 =?us-ascii?Q?1ATGhiHbJHolGA6+qAcwM12oUW0/wF/WA5JqwO5LoNipl/n3pj6kCHwMcErY?=
 =?us-ascii?Q?7R/H+0h3lnJm/tZhcTBSLvjuOtRv/RPwFqjTWnOGedW20653vAOz6Q7rrA2Z?=
 =?us-ascii?Q?IcKrsFsJGljZk1hOcNxTAM5B3AQH6z4XBH5AoXV3joMQky3Gr33QUL9Yujpb?=
 =?us-ascii?Q?sg39VWHbFuzl3UHc/VF/Vg+SElb0TxKp7qsJlw0Y2vswQUgOPsEqoaHLNg8D?=
 =?us-ascii?Q?uTXqoX/0vlhNWiyRP/L9hAcc0Xh5v3DKNXWu0bTaUjJzcSmXgG3FETxRgrlu?=
 =?us-ascii?Q?almAbfCi/tfujd19dyKgFdjyET7pXPvyEdbbmXy03DUOHivv48WpIhPu40vK?=
 =?us-ascii?Q?DPLPSqFPbbbsAZBiwZfvTIZLnJFZKLTHxgPiw/DJXI4GKzXJ+lQ188pUOVi3?=
 =?us-ascii?Q?vlUJMDtSt4BGd7cc22JAGtKYTC96ZZ1HkXI+Iq4zElj+ILtCM3722wyI7grU?=
 =?us-ascii?Q?9vvVisaVemGpUg99DqwSE5pl2puVwD6cuRlb0dLOmq1NgJPUyD7p4FhU4hNY?=
 =?us-ascii?Q?dKdR8NguAiSULRlS4h+ed92d73FSfKy3z9kZnmrJzvGlJWNtEfRT97AShlV9?=
 =?us-ascii?Q?mGkNUJ+SdDR85kVfxoSKwgvXtLWVaUi1CUJQIdPNyagdJPX9uKtCcG3jkbv5?=
 =?us-ascii?Q?kgX8Ba0rG/EMVCa4UBrnMaMXp6OQXqJ0/DjbX33bu0c2AR+S4Osm6WRhVdjH?=
 =?us-ascii?Q?pR81DjToW1hyH5UzWVcYIZ1ZmSVMyC1Fd0geg5rrDUdpSd4hQVivJ4XF6JYU?=
 =?us-ascii?Q?r6x4q5XZ3fj7ebYnJqU2XZxH3/qn56sjZU5yHjwPaT0WwUKObGQ2iIvR+IZO?=
 =?us-ascii?Q?9/sftr8kVrMDSz0d5o9Ick0t3qJ6hNq8qzYrkp0N2Zyq3LLRPjIZsUxSO7CK?=
 =?us-ascii?Q?i9u1UwAmlod3mLTXxI7NpH2UCIRxYud9PXNnGIb3fvFyWtXAoVpXYZymBzCM?=
 =?us-ascii?Q?4ESz+zLYsUmSOYJ3Kyzq4ER+4AOfOmkqH+vSjbNEFXC77nh2Yhql/pFmMMRG?=
 =?us-ascii?Q?tKTFw3pGKUl9d2q67O9ii74fKSnAe6vDIJ5TzZxyegeo8k7/5sUi7OGox6x1?=
 =?us-ascii?Q?/z1Yv/wszXi30JjfaQETHrleEaZ7oz2RRZGbf/6GaV5lX1/HO9cOR3ZvJbfn?=
 =?us-ascii?Q?3cTP+A/CWJgD47PG6R9rFkZApofb2lVwsWD3Qx4xWUUbFH5ULK9YsUaeZbOg?=
 =?us-ascii?Q?1hbdl86ZNHG29cqgsuqmpjEht8ou?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:57:03.2324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cf9f9f-85bb-4ec5-0fd0-08dc7b40fd04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853

AMD systems optionally support a deferred error interrupt. The interrupt
should be used as another signal to trigger MCA polling. This is similar
to how other MCA interrupts are handled.

Deferred errors do not require any special handling related to the
interrupt, e.g. resetting or rearming the interrupt, etc.

However, Scalable MCA systems include a pair of registers, MCA_DESTAT
and MCA_DEADDR, that should be checked for valid errors. This check
should be done whenever MCA registers are polled. Currently, the
deferred error interrupt does this check, but the MCA polling function
does not.

Call the MCA polling function when handling the deferred error
interrupt. This keeps all "polling" cases in a common function.

Call the polling function only for banks that have the deferred error
interrupt enabled.

Add an SMCA status check helper. This will do the same status check and
register clearing that the interrupt handler has done. And it extends
the common polling flow to find AMD deferred errors.

Remove old code whose functionality is already covered in the common MCA
code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c  | 99 ++--------------------------------
 arch/x86/kernel/cpu/mce/core.c | 46 ++++++++++++++--
 2 files changed, 46 insertions(+), 99 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1ac445a0dc12..c6594da95340 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -57,6 +57,7 @@
 
 static bool thresholding_irq_en;
 static DEFINE_PER_CPU_READ_MOSTLY(mce_banks_t, mce_thr_intr_banks);
+static DEFINE_PER_CPU_READ_MOSTLY(mce_banks_t, mce_dfr_intr_banks);
 
 static const char * const th_names[] = {
 	"load_store",
@@ -296,8 +297,10 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		 * APIC based interrupt. First, check that no interrupt has been
 		 * set.
 		 */
-		if ((low & BIT(5)) && !((high >> 5) & 0x3))
+		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
+			__set_bit(bank, this_cpu_ptr(mce_dfr_intr_banks));
 			high |= BIT(5);
+		}
 
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
 
@@ -778,33 +781,6 @@ bool amd_mce_usable_address(struct mce *m)
 	return false;
 }
 
-static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
-{
-	struct mce m;
-
-	mce_setup(&m);
-
-	m.status = status;
-	m.misc   = misc;
-	m.bank   = bank;
-	m.tsc	 = rdtsc();
-
-	if (m.status & MCI_STATUS_ADDRV) {
-		m.addr = addr;
-
-		smca_extract_err_addr(&m);
-	}
-
-	if (mce_flags.smca) {
-		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m.ipid);
-
-		if (m.status & MCI_STATUS_SYNDV)
-			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m.synd);
-	}
-
-	mce_log(&m);
-}
-
 DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 {
 	trace_deferred_error_apic_entry(DEFERRED_ERROR_VECTOR);
@@ -814,75 +790,10 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 	apic_eoi();
 }
 
-/*
- * Returns true if the logged error is deferred. False, otherwise.
- */
-static inline bool
-_log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
-{
-	u64 status, addr = 0;
-
-	rdmsrl(msr_stat, status);
-	if (!(status & MCI_STATUS_VAL))
-		return false;
-
-	if (status & MCI_STATUS_ADDRV)
-		rdmsrl(msr_addr, addr);
-
-	__log_error(bank, status, addr, misc);
-
-	wrmsrl(msr_stat, 0);
-
-	return status & MCI_STATUS_DEFERRED;
-}
-
-static bool _log_error_deferred(unsigned int bank, u32 misc)
-{
-	if (!_log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
-			     mca_msr_reg(bank, MCA_ADDR), misc))
-		return false;
-
-	/*
-	 * Non-SMCA systems don't have MCA_DESTAT/MCA_DEADDR registers.
-	 * Return true here to avoid accessing these registers.
-	 */
-	if (!mce_flags.smca)
-		return true;
-
-	/* Clear MCA_DESTAT if the deferred error was logged from MCA_STATUS. */
-	wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(bank), 0);
-	return true;
-}
-
-/*
- * We have three scenarios for checking for Deferred errors:
- *
- * 1) Non-SMCA systems check MCA_STATUS and log error if found.
- * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
- *    clear MCA_DESTAT.
- * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
- *    log it.
- */
-static void log_error_deferred(unsigned int bank)
-{
-	if (_log_error_deferred(bank, 0))
-		return;
-
-	/*
-	 * Only deferred errors are logged in MCA_DE{STAT,ADDR} so just check
-	 * for a valid error.
-	 */
-	_log_error_bank(bank, MSR_AMD64_SMCA_MCx_DESTAT(bank),
-			      MSR_AMD64_SMCA_MCx_DEADDR(bank), 0);
-}
-
 /* APIC interrupt handler for deferred errors */
 static void amd_deferred_error_interrupt(void)
 {
-	unsigned int bank;
-
-	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank)
-		log_error_deferred(bank);
+	machine_check_poll(MCP_TIMESTAMP, this_cpu_ptr(&mce_dfr_intr_banks));
 }
 
 static void reset_block(struct threshold_block *block)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d6517b93c903..16c999b2cc1f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -637,7 +637,8 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 	if (m->status & MCI_STATUS_MISCV)
 		m->misc = mce_rdmsrl(mca_msr_reg(i, MCA_MISC));
 
-	if (m->status & MCI_STATUS_ADDRV) {
+	/* Don't overwrite an address value that was saved earlier. */
+	if (m->status & MCI_STATUS_ADDRV && !m->addr) {
 		m->addr = mce_rdmsrl(mca_msr_reg(i, MCA_ADDR));
 
 		/*
@@ -668,6 +669,35 @@ static void reset_thr_limit(unsigned int bank)
 
 DEFINE_PER_CPU(unsigned, mce_poll_count);
 
+static bool smca_log_poll_error(struct mce *m, u32 *status_reg)
+{
+	/*
+	 * If this is a deferred error found in MCA_STATUS, then clear
+	 * the redundant data from the MCA_DESTAT register.
+	 */
+	if (m->status & MCI_STATUS_VAL) {
+		if (m->status & MCI_STATUS_DEFERRED)
+			mce_wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+
+		return true;
+	}
+
+	/*
+	 * If the MCA_DESTAT register has valid data, then use
+	 * it as the status register.
+	 */
+	*status_reg = MSR_AMD64_SMCA_MCx_DESTAT(m->bank);
+	m->status = mce_rdmsrl(*status_reg);
+
+	if (!(m->status & MCI_STATUS_VAL))
+		return false;
+
+	if (m->status & MCI_STATUS_ADDRV)
+		m->addr = mce_rdmsrl(MSR_AMD64_SMCA_MCx_DEADDR(m->bank));
+
+	return true;
+}
+
 static bool ser_log_poll_error(struct mce *m)
 {
 	/* Log "not enabled" (speculative) errors */
@@ -684,8 +714,11 @@ static bool ser_log_poll_error(struct mce *m)
 	return false;
 }
 
-static bool log_poll_error(enum mcp_flags flags, struct mce *m)
+static bool log_poll_error(enum mcp_flags flags, struct mce *m, u32 *status_reg)
 {
+	if (mce_flags.smca)
+		return smca_log_poll_error(m, status_reg);
+
 	/* If this entry is not valid, ignore it. */
 	if (!(m->status & MCI_STATUS_VAL))
 		return false;
@@ -724,6 +757,7 @@ static bool log_poll_error(enum mcp_flags flags, struct mce *m)
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+	u32 status_reg;
 	struct mce m;
 	int i;
 
@@ -736,12 +770,14 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (!mce_banks[i].ctl || !test_bit(i, *b))
 			continue;
 
+		status_reg = mca_msr_reg(i, MCA_STATUS);
+
 		m.misc = 0;
 		m.addr = 0;
 		m.bank = i;
 
 		barrier();
-		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
+		m.status = mce_rdmsrl(status_reg);
 
 		/*
 		 * Update storm tracking here, before checking for the
@@ -753,7 +789,7 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (!mca_cfg.cmci_disabled)
 			mce_track_storm(&m);
 
-		if (!log_poll_error(flags, &m))
+		if (!log_poll_error(flags, &m, &status_reg))
 			continue;
 
 		if (flags & MCP_DONTLOG)
@@ -780,7 +816,7 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		/*
 		 * Clear state for this bank.
 		 */
-		mce_wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
+		mce_wrmsrl(status_reg, 0);
 	}
 
 	/*
-- 
2.34.1


