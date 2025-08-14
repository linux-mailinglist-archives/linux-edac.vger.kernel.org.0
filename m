Return-Path: <linux-edac+bounces-4582-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB60B26B8F
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 17:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8788A051E3
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 15:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747E23E342;
	Thu, 14 Aug 2025 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="djO+CIAS"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007E18DB02;
	Thu, 14 Aug 2025 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186505; cv=fail; b=fQdi98WEkJI+TNFLnxh31EWitx6RXOTCdkUU9eKSCqhYAnXmNqHBB0xrxJT4lQjKGDkFWs0F8DItrigWm8n4cutFRyGJPJg5WYePiwS/9F3vOCldRLSWX2lSC/PeRylKWCSRnyjcn7YItpDbKH6Z9uVW44V9SzwS/bWIHOMwoxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186505; c=relaxed/simple;
	bh=bms/u4QcmAQ7/KWxwk0CGk+L8cQIXaxoot7UqxybF3o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SzWxnmG97nikiYnPjAh2hFcGbxBLZbPg37gZOdgFqoWAauLHCJDjChcs1yVEJVHUaHe0UOOGVAXw1zjITzRTmpQAY6wnyNEPM7FuTf75Ab3XU5Ec8MSN8kDcsF1p0r5div6bO2DbaVagzTA7bui5MIU53gQJJMpWS88QDHUPFg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=djO+CIAS; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbEbAVQP0X73BKtcl1EfoxT0ipTxdY3Pa7jTck1OwOeSv3BZo7cMVM84HIA++l04FfOAIZW45/lcrNRPWIRJfa+uWBND4SggbOt5yromrL4u2hfY+CWvTP8KQNxhJMp/iRsDFcxIgJTmkRDmPMyyalTe6Ik1Gl59gY2xYlZ9aVxc7jooMCIMQoXsnZArhfOD5e+RhSXNN7csRHrT4qhv79GL1/ydGpq79c9zxQltuR1+nKu9tNQS0y9wV0MogWnTN1TRdYS4WhAEgW52g0gyNPxZVe+C5HF9KMqnreQJOhI1cIsA+/iAl3dYtTW7JNecW6Ky0cgqkSuZ7AFmbC52oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZARIGkqtFpitQFDmylssaQ8B5N+4sZaSY209MECpjxk=;
 b=e8B+TT3H5RQfY3fRiGhVZUsy8VizNboy5DPP2SgcL37MoSliHAKB6QcgAaDG61lfdPhi3Yb737yTFcObzY4Di1FujYv+l95nLjOGl2lWAX+abACK12IHjjWF3aSGA1fzidxdG46SwCF90KpBQneei5CWomBLdhRFaGqPRnSDRFN2E4beItL+KSuaEY5di7A37pw/QAhhhPKgpfkxqTJf/2KSJI5aBX5VQShmBMan/oh8+idsMuMDUeSxZUzIAYz0nG2J3VpzmD9J/hHBnfRlGkotfTn4tvqC322n5yznzkiz3BEFiwsrwLHdx2jNo9BzxJB4NtqthwVJP5Ut+01+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZARIGkqtFpitQFDmylssaQ8B5N+4sZaSY209MECpjxk=;
 b=djO+CIASrbDqNjvDs6llLTc2/9689xOed0V0aV7NEk1HwV7F2ewO/3ZcAz9Qk2ZFMxMjIC0FQ+lMwf/I5gLI2J90Xl3QlF5ULuG2r0FL9c2pwIzXxXNdnPq2gShz5B9eBjF/o6d76ZoyuGxwabvvSNYK3I7i6Xrhmz4IXsl4jYg=
Received: from BN9PR03CA0229.namprd03.prod.outlook.com (2603:10b6:408:f8::24)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 15:48:21 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::d5) by BN9PR03CA0229.outlook.office365.com
 (2603:10b6:408:f8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 15:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.0 via Frontend Transport; Thu, 14 Aug 2025 15:48:21 +0000
Received: from yaz-khff2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 10:48:20 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2] x86/mce: Do away with unnecessary context quirks
Date: Thu, 14 Aug 2025 11:48:09 -0400
Message-ID: <20250814154809.165916-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f33dc2-5c18-4073-8f27-08dddb49ff0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dZj6SkubcVqLT7KjaPpSKh6DEYzSm0Dm84HTFltJS1s3B3HDlBFBZK32N2A+?=
 =?us-ascii?Q?AGG0YPfY5wY6A6Uk+LO1JUmZEaNJ6gV08/7saUiw1CZklabhcOszy15WVGSD?=
 =?us-ascii?Q?34k7gISvqVhSEfYXn06c01b4qgbBOqzfziwQMXlqJjRyh/jGw1cfMM3W1znk?=
 =?us-ascii?Q?jIJy9Oa3IBVzGeROt5WD9ugoO75UUDWwt5FFKQDcjrRvAmVqAzzGqxEiN3bk?=
 =?us-ascii?Q?d77pZoLop/36ODb1BYHjxdp2ACxnGIdb75inLcPa6TG+gItqia7WKdVhFTPH?=
 =?us-ascii?Q?Zqvqw5hx7oeVey7JqB+XxgbpX8gx4lH7HpVdV4WB8HVbTHxSy/7uXXv+awMb?=
 =?us-ascii?Q?+jWpwQHxnMSeBB2tq+UgFFwgvlQtSGHaOfFaYAxKk0FNQ3g6FXfAjH0XYOs3?=
 =?us-ascii?Q?7eYqMJJhmUyN/2b2wm0ee8erNygZ492fpaxpfo7l3NCIFvh/VF6V626W6OXx?=
 =?us-ascii?Q?gUVeEy+t6HWtAsiQmeEaYRxCexULc6B0OLFSqv2K1Lp2SlYWhqLKHURaAKti?=
 =?us-ascii?Q?Sr3UF7CazpCpXkgoYHutQxc8MD3btaIqcMJOOlU7TOP0qF6dKIvjvOhgyUN6?=
 =?us-ascii?Q?0dpNHSfMHQ+llfbqYiNt1Cdws3UK4pmilR0Uv/030XMeozJBI3dSL7/0KGQP?=
 =?us-ascii?Q?clAElLEWWutU5ERFfO2nSDJj85mFhjNW0/jGtT0yWgu9ITcoRgj9vg1WRg4v?=
 =?us-ascii?Q?oPmFnFSJkwakq7CBjCm+s2mzJzlWkUK4pGTIr51Ls4Dbhg3mYNimB2VVYAj+?=
 =?us-ascii?Q?tExmeoMkU8z0Lk5kLUqhq5U5Jl0n93ONzlp+p0j5xMVZNHrBZRtVt71yeeLA?=
 =?us-ascii?Q?DnV5J0AXo7ipUp1qAPxbT6+YP9zGlqgSjVaClfFVTrJuAaw0zo6Ciap0KqOH?=
 =?us-ascii?Q?+jn8glaIRbDZ9yQpjLrAaMSSpdG7cfn4XJYgN91m7D9jOQzPUCOk1PXRqMMT?=
 =?us-ascii?Q?z0nUf4zLydQP1glGRCBbB0T3a6OpDPkOuVxS0XcfueDsaddmoHSI6+IPaGWE?=
 =?us-ascii?Q?1zydoWu2dpopQfQtHG31DBgpxrlVMQTC6rT0rFjA0vC0Ng5L3NhotwpU9gBm?=
 =?us-ascii?Q?m6rxSAAfviFF1+htTxFxRwpp+rZzEAn9cx9LuWA56Tj1G2ONXtxo1tinRrIq?=
 =?us-ascii?Q?e+g1QKJaViGBzxpEDCAYNdSCMEYGAOXf7meZIkoyq4kLXUr9z/gqrN+b5nUw?=
 =?us-ascii?Q?VXsjrTIj3kRPhI8D4vvQIOOj54k3+F43wN8M/Bk9z9DYq92+hjcebOZEUG2n?=
 =?us-ascii?Q?A1dIgAPzrY6IhSJeXjjKKyBmSFWv+eReDH88/YPLl+X4OZF1SaUvoIpRhp3Y?=
 =?us-ascii?Q?EAqvzLe3UIP4b/twVcH4x8b+pVznd+Hru6Jr7pGmvqtweHrybf5TjV0yIHc1?=
 =?us-ascii?Q?UCQLOzT0CGiD2aydNdVM53jqP3x0ZQBpQbY+K/bhOXhuuhbwPtuwfWIO35PI?=
 =?us-ascii?Q?x56FfjcLqLfRTqnH1EzjfBEQLMzssfBxw+0p6LsqBmeoTOJ4BFbMd3Hw1VRj?=
 =?us-ascii?Q?DLGz5KGwLCdH9tw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:48:21.4275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f33dc2-5c18-4073-8f27-08dddb49ff0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002

Both Intel and AMD have quirks related to recovery in the Instruction
Fetch Units. The common issue is that MCG_STATUS[RIPV] and
MCG_STATUS[EIPV] are set to '0', so Linux will not save the CS and IP
registers. The severity grading functions will later see that CS=0, so it
is assumed that the #MC was taken in kernel context. This leads to a
kernel panic even if the #MC was recoverable and in user context.

RIPV is "restart IP valid" which means program execution can restart at
the IP on the stack. This is a general indicator on whether system
software should try to return to the executing process or not. The exact
value is not needed by MCE handling.

EIPV is "error IP valid" which means the IP on the stack is directly
associated with the error. This is a specific indicator that the saved
IP is exactly where the #MC was taken. System software can share this
for debugging and/or try to take further recovery actions based on the
nature of the code represented by the IP.

Neither of these refer to the CS register which is used to determine
the execution context privilege level.

It is not clear why CS and IP are tied together in the Linux handling.
This could be a carryover from 32-bit execution where "IP" is the
combination of "CS:IP". But it not apparent if this "IP=CS:IP"
association, as applies to MCE handling, is a Linux assumption or
explicitly noted in x86 documentation when describing RIPV/EIPV.

It is clear that in the affected use cases, the processor context is
valid in general. And the only variable is the IP validity which is
explicitly based on RIPV/EIPV. An invalid CPU context is represented by
the MCA_STATUS[PCC] "Processor Context Corrupt" bit.

Avoid the need for these context quirks by refactoring the Linux MCE
handling code to treat the CS and IP registers independently.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20250813154455.162489-1-yazen.ghannam@amd.com

v1->v2:
* Minimize changes to only code related to context quirks.

 arch/x86/kernel/cpu/mce/core.c     | 83 +++++-------------------------
 arch/x86/kernel/cpu/mce/internal.h |  8 +--
 2 files changed, 13 insertions(+), 78 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4da4eab56c81..a26534a914ec 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -470,22 +470,23 @@ static noinstr void mce_gather_info(struct mce_hw_err *err, struct pt_regs *regs
 	m = &err->m;
 	m->mcgstatus = mce_rdmsrq(MSR_IA32_MCG_STATUS);
 	if (regs) {
+		m->cs = regs->cs;
+
+		/*
+		 * When in VM86 mode make the cs look like ring 3
+		 * always. This is a lie, but it's better than passing
+		 * the additional vm86 bit around everywhere.
+		 */
+		if (v8086_mode(regs))
+			m->cs |= 3;
+
 		/*
 		 * Get the address of the instruction at the time of
 		 * the machine check error.
 		 */
-		if (m->mcgstatus & (MCG_STATUS_RIPV|MCG_STATUS_EIPV)) {
+		if (m->mcgstatus & (MCG_STATUS_RIPV | MCG_STATUS_EIPV))
 			m->ip = regs->ip;
-			m->cs = regs->cs;
-
-			/*
-			 * When in VM86 mode make the cs look like ring 3
-			 * always. This is a lie, but it's better than passing
-			 * the additional vm86 bit around everywhere.
-			 */
-			if (v8086_mode(regs))
-				m->cs |= 3;
-		}
+
 		/* Use accurate RIP reporting if available. */
 		if (mca_cfg.rip_msr)
 			m->ip = mce_rdmsrq(mca_cfg.rip_msr);
@@ -841,35 +842,6 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 }
 EXPORT_SYMBOL_GPL(machine_check_poll);
 
-/*
- * During IFU recovery Sandy Bridge -EP4S processors set the RIPV and
- * EIPV bits in MCG_STATUS to zero on the affected logical processor (SDM
- * Vol 3B Table 15-20). But this confuses both the code that determines
- * whether the machine check occurred in kernel or user mode, and also
- * the severity assessment code. Pretend that EIPV was set, and take the
- * ip/cs values from the pt_regs that mce_gather_info() ignored earlier.
- */
-static __always_inline void
-quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
-{
-	if (bank != 0)
-		return;
-	if ((m->mcgstatus & (MCG_STATUS_EIPV|MCG_STATUS_RIPV)) != 0)
-		return;
-	if ((m->status & (MCI_STATUS_OVER|MCI_STATUS_UC|
-		          MCI_STATUS_EN|MCI_STATUS_MISCV|MCI_STATUS_ADDRV|
-			  MCI_STATUS_PCC|MCI_STATUS_S|MCI_STATUS_AR|
-			  MCACOD)) !=
-			 (MCI_STATUS_UC|MCI_STATUS_EN|
-			  MCI_STATUS_MISCV|MCI_STATUS_ADDRV|MCI_STATUS_S|
-			  MCI_STATUS_AR|MCACOD_INSTR))
-		return;
-
-	m->mcgstatus |= MCG_STATUS_EIPV;
-	m->ip = regs->ip;
-	m->cs = regs->cs;
-}
-
 /*
  * Disable fast string copy and return from the MCE handler upon the first SRAR
  * MCE on bank 1 due to a CPU erratum on Intel Skylake/Cascade Lake/Cooper Lake
@@ -923,26 +895,6 @@ static noinstr bool quirk_skylake_repmov(void)
 	return false;
 }
 
-/*
- * Some Zen-based Instruction Fetch Units set EIPV=RIPV=0 on poison consumption
- * errors. This means mce_gather_info() will not save the "ip" and "cs" registers.
- *
- * However, the context is still valid, so save the "cs" register for later use.
- *
- * The "ip" register is truly unknown, so don't save it or fixup EIPV/RIPV.
- *
- * The Instruction Fetch Unit is at MCA bank 1 for all affected systems.
- */
-static __always_inline void quirk_zen_ifu(int bank, struct mce *m, struct pt_regs *regs)
-{
-	if (bank != 1)
-		return;
-	if (!(m->status & MCI_STATUS_POISON))
-		return;
-
-	m->cs = regs->cs;
-}
-
 /*
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
@@ -960,11 +912,6 @@ static __always_inline int mce_no_way_out(struct mce_hw_err *err, char **msg, un
 			continue;
 
 		arch___set_bit(i, validp);
-		if (mce_flags.snb_ifu_quirk)
-			quirk_sandybridge_ifu(i, m, regs);
-
-		if (mce_flags.zen_ifu_quirk)
-			quirk_zen_ifu(i, m, regs);
 
 		m->bank = i;
 		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
@@ -1950,9 +1897,6 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
 	 */
 	if (c->x86 == 0x15 && c->x86_model <= 0xf)
 		mce_flags.overflow_recov = 1;
-
-	if (c->x86 >= 0x17 && c->x86 <= 0x1A)
-		mce_flags.zen_ifu_quirk = 1;
 }
 
 static void apply_quirks_intel(struct cpuinfo_x86 *c)
@@ -1988,9 +1932,6 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
 	if (c->x86_vfm < INTEL_CORE_YONAH && mca_cfg.bootlog < 0)
 		mca_cfg.bootlog = 0;
 
-	if (c->x86_vfm == INTEL_SANDYBRIDGE_X)
-		mce_flags.snb_ifu_quirk = 1;
-
 	/*
 	 * Skylake, Cascacde Lake and Cooper Lake require a quirk on
 	 * rep movs.
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b5ba598e54cb..59a94daa31ad 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -211,9 +211,6 @@ struct mce_vendor_flags {
 	 */
 	smca			: 1,
 
-	/* Zen IFU quirk */
-	zen_ifu_quirk		: 1,
-
 	/* AMD-style error thresholding banks present. */
 	amd_threshold		: 1,
 
@@ -223,13 +220,10 @@ struct mce_vendor_flags {
 	/* Centaur Winchip C6-style MCA */
 	winchip			: 1,
 
-	/* SandyBridge IFU quirk */
-	snb_ifu_quirk		: 1,
-
 	/* Skylake, Cascade Lake, Cooper Lake REP;MOVS* quirk */
 	skx_repmov_quirk	: 1,
 
-	__reserved_0		: 55;
+	__reserved_0		: 57;
 };
 
 extern struct mce_vendor_flags mce_flags;

base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
-- 
2.50.1


