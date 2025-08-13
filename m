Return-Path: <linux-edac+bounces-4571-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A8FB24E6B
	for <lists+linux-edac@lfdr.de>; Wed, 13 Aug 2025 17:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6899A21D1
	for <lists+linux-edac@lfdr.de>; Wed, 13 Aug 2025 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7D2288C9D;
	Wed, 13 Aug 2025 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o0EkC1Zb"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DB62877F3;
	Wed, 13 Aug 2025 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099919; cv=fail; b=QhHqEvIrGv7HiGKK8J2Gu+1WFnE1zcuWrIK20dm/XjI5W6Nzt5wcx0pm2h1ZjdSRc0eZUY37e+bcypfe3zYK70Sze8ecdRwTNEXv7Fv9O2ng9VGFwHDt8G+5dAwx0oDT9HYalEIgLv7Zj20VWh+WyH0CIyHnN9JxvK4H9xLuqQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099919; c=relaxed/simple;
	bh=jUP4HDeAKb2Zo2lbrjy0OYUx/6lofXvGL5xTOqgipFQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SeUfNUF2Mz7FZJhJndpeKXuYSANYs0eNSk6867Y6gD2A7ZBIkXZOsTagYvzYhCpHTInCJJT3NP3Fs/68CgS0hfJDFt8DfYZURtuLYKdVnEwyFiFPXV14CAI0gj8AkDYFK1btkPm6bDBkjV3rqSrozR7w1rY+fA276AO2gdWeliQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o0EkC1Zb; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8U6l7qdK17KOmZR8rARs4nnZIAi9dwlSnwwyWlaS4tXt4QUaGV6f2Nv/L15Z9tgd58ByZD7qlR+3GCdm0BZc8It6y7q+TXqenR/yvCvUCqWTLw6RkMeHTAvP4JdT5QtCllm98+U1Imq+w0OdQpT2qE3n8I4S5SWc7IRy7343hNGFBoQJoZngnkYR0uhbwEljDu9HyV4zGEusxGqWHhxP2JPafZvY7cVmMnfzkyUINqIKcKXmVViJA2m99ql0aUEMG4bxqGCI8IwjSMfyR0BpD3EE7HfxMgMDy7aFJanJK6vF8gstbK3M3JHh4P6Bp9uymTO8Si0zg3X/aM7m3qZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGRsUUT5H6qhN7Apcxy51DgUc0TiMU/5rZJBD+1FTJE=;
 b=YfLZpuelsIObfndbczeVyg5mUeZalGdIhJZiXpxBH0NsnOHAC6ZvLRT4h24Zwt9eaNwuDkjit55V8hekAyyJ7dWpaSgE8h74ksquoo7lD1832tlWJLkbvJ5BFq6zjEdoG6DxaJBrjRMJGg8ZzXKvaXujKEjqeOSqIPSnpkjtlJCLnxGiW3KVAZTjll1nOVMFstHMstcbFkNxvB8NGTWbR1MpOmAx/p/zXutQFuqP2LF4WlF6vjauw8bhiCS3eg0LoO5g8HihBWx4frbLzMTso28ccPrYwLhcSw+wH5dH5zZVDESukkxvbJSNF8TQRW7jv/2ufb4SuoyfjMAg6mOIeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGRsUUT5H6qhN7Apcxy51DgUc0TiMU/5rZJBD+1FTJE=;
 b=o0EkC1ZbE3C6S9WcfUnH3vWN2Ja75A9KKFCsPN1nRgt7mTd7MjHekMTGpOjdyjtisWsxTINULYHzWxfVHPj1mzC7KxjbkCzcBWHJwO8meoJ2dEI6E82VimmQ0RRwDQ1NtrfrBPUOdWhPtTfE/2P+OC5Fm6WgcbxxZPIZhRVwsic=
Received: from BN0PR04CA0054.namprd04.prod.outlook.com (2603:10b6:408:e8::29)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 15:45:09 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::2c) by BN0PR04CA0054.outlook.office365.com
 (2603:10b6:408:e8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 15:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 15:45:09 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 10:45:06 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH] x86/mce: Do away with unnecessary context quirks
Date: Wed, 13 Aug 2025 15:44:55 +0000
Message-ID: <20250813154455.162489-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 4466ddfd-29ee-4b2f-ab38-08ddda8061f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aG1Nmaa4BEcByXiLCYcCSYwxOBGCIRo7VSr6g4CnlZkB4GOvknAtzw+x4Uj1?=
 =?us-ascii?Q?LO1dxN48Alo0eD8gguVBnJ/ReKo3txS+a5w42AKE73QRjpxc6nG9cYEp/JJb?=
 =?us-ascii?Q?PkYeZygyR+oTx4E0hzi0JZoR1XhJ5CzGOJh6YyJydHYFsBGkHIRhuanENW3U?=
 =?us-ascii?Q?3WzDvfBoYQ8t3UQIUrCfvsRTj6c7y39gbVLa7MoJKTmgq8mLgzRis6DpfBUJ?=
 =?us-ascii?Q?PDroKvsAKLIEtknQCrZ0HeuvX0ThwtvTPUc+PBzBDBdiPH0vtRB1vjNn22+m?=
 =?us-ascii?Q?osktK7IUdGHUVIN36/z9R+N+U02KgkClnS/fsY+U/eLwP6cIeBwhkDitqJjo?=
 =?us-ascii?Q?72glVJ8mjCQXjbwR4ZiPsuPX1MuYDKDpNQHB/kDHWorHGcB3vyIVD/lJ0sWN?=
 =?us-ascii?Q?QinR/TyKkx2kfDC1nVdwPxCaLYx6Ady7bQLjNLv2ZvwBDA5qn9Iyqo+KNjCH?=
 =?us-ascii?Q?Ol7/whWpDNVTwtowpaa0Ktd4WnSC3xwX9j08VRsGfkQn8lnEzjfCOU/dR0Sa?=
 =?us-ascii?Q?++MhxeFSAub/geBeyOtefAN/wvwhXdwaVY4Z1Nnve91qVHPJo6GtRajYMm9J?=
 =?us-ascii?Q?jPuX2YcYXBYnave4rXJlvemiE2UwJMMvqNe8rXvk1962Sj9cIdMaO+d+ZOF/?=
 =?us-ascii?Q?w/Rl/sdyzND789cr5XIsNlmKwMrUKKaHJreI8V+w3SbYTnMlG4bkOmWVXrVi?=
 =?us-ascii?Q?cxItn4okaPNSPLaAyi2qkcNDJUoztSNbxGr7rKkP23enk22A25zPTK791Mhb?=
 =?us-ascii?Q?UshZ9rkJmTw1UBhyrCDHdmBapr+/qQ1Yx0aW+VRLXJns54odSND93jKlLoBB?=
 =?us-ascii?Q?gh8iNEBIGjwIfDgwjDYRYpurOb30nJs7eRnkX4tdNSKPJ7TQWUiVluLDPl/W?=
 =?us-ascii?Q?i2q5OvdHoOUktRDWzmlHwWFuI/6iHYDMjnBNgnLmKP8QBZUVXw53Ehh+wtkZ?=
 =?us-ascii?Q?bujPHL8mYNqmBUAYKSqnKXrtN7nnm0GFJP7SyQDwtmuI6FL2FxUpCVi4lTLZ?=
 =?us-ascii?Q?IhR+Q63z0J1+/HMf/VYnvp3xxE4Hwuv6+acyIwfe8SwcYkZ/4L1iphD7gkTT?=
 =?us-ascii?Q?cxmw1ZiIoZWCoExPQ63k432si7jXbNGnNPT2Vu/xRtweE9ttp7yeMjyyClwy?=
 =?us-ascii?Q?WsysfixtKkqOmTauLRgk/fDjSbaUjRQypyLWtF2TEM3QqMU7vRZMpCDzmZ1s?=
 =?us-ascii?Q?mjPUzEuKpqmy0ATBnEsHvZkmvekvCY4fgieduDYlEp7/Xjtua5wAfG7lNxTI?=
 =?us-ascii?Q?Kr9frNrRTIbujWoFQOWKVIKNlF8Mc6u/mW6mZ79gz/ZdAKdVeyhtHlWpQqef?=
 =?us-ascii?Q?a83sk4yTL+8yusM4x30g3g7MvxJbyP+uMyhAJh7kPlizLmkZRZ2tF7ZA2IAj?=
 =?us-ascii?Q?OTuflvaYsla6HVrM4movZ4bXyi4o2m8ldyUjOCbsl8LtmydtoxXsZhLZ2tAZ?=
 =?us-ascii?Q?/FqOEJIvj8hSMdBY+reu79ANUdK1S8a/gm10fKsD9j0TStxgZbB1ilJcsDeX?=
 =?us-ascii?Q?IUuBthTEcV2acYJe/NqT2c5ZTzd96WYsCdj7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 15:45:09.0474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4466ddfd-29ee-4b2f-ab38-08ddda8061f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439

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

Additionally, this removes the need to "fake" the CS value for VM86
mode.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c     | 101 +++--------------------------
 arch/x86/kernel/cpu/mce/internal.h |   8 +--
 arch/x86/kernel/cpu/mce/severity.c |  24 +++----
 3 files changed, 22 insertions(+), 111 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4da4eab56c81..1aed411cbdb1 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -456,9 +456,8 @@ static noinstr void mce_wrmsrq(u32 msr, u64 v)
  * check into our "mce" struct so that we can use it later to assess
  * the severity of the problem as we read per-bank specific details.
  */
-static noinstr void mce_gather_info(struct mce_hw_err *err, struct pt_regs *regs)
+static noinstr void mce_gather_info(struct mce_hw_err *err)
 {
-	struct mce *m;
 	/*
 	 * Enable instrumentation around mce_prep_record() which calls external
 	 * facilities.
@@ -467,29 +466,7 @@ static noinstr void mce_gather_info(struct mce_hw_err *err, struct pt_regs *regs
 	mce_prep_record(err);
 	instrumentation_end();
 
-	m = &err->m;
-	m->mcgstatus = mce_rdmsrq(MSR_IA32_MCG_STATUS);
-	if (regs) {
-		/*
-		 * Get the address of the instruction at the time of
-		 * the machine check error.
-		 */
-		if (m->mcgstatus & (MCG_STATUS_RIPV|MCG_STATUS_EIPV)) {
-			m->ip = regs->ip;
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
-		/* Use accurate RIP reporting if available. */
-		if (mca_cfg.rip_msr)
-			m->ip = mce_rdmsrq(mca_cfg.rip_msr);
-	}
+	err->m.mcgstatus = mce_rdmsrq(MSR_IA32_MCG_STATUS);
 }
 
 bool mce_available(struct cpuinfo_x86 *c)
@@ -738,7 +715,7 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 
 	this_cpu_inc(mce_poll_count);
 
-	mce_gather_info(&err, NULL);
+	mce_gather_info(&err);
 	m = &err.m;
 
 	if (flags & MCP_TIMESTAMP)
@@ -841,35 +818,6 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
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
@@ -923,26 +871,6 @@ static noinstr bool quirk_skylake_repmov(void)
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
@@ -960,11 +888,6 @@ static __always_inline int mce_no_way_out(struct mce_hw_err *err, char **msg, un
 			continue;
 
 		arch___set_bit(i, validp);
-		if (mce_flags.snb_ifu_quirk)
-			quirk_sandybridge_ifu(i, m, regs);
-
-		if (mce_flags.zen_ifu_quirk)
-			quirk_zen_ifu(i, m, regs);
 
 		m->bank = i;
 		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
@@ -1057,7 +980,7 @@ static noinstr int mce_timed_out(u64 *t, const char *msg)
  * All the spin loops have timeouts; when a timeout happens a CPU
  * typically elects itself to be Monarch.
  */
-static void mce_reign(void)
+static void mce_reign(struct pt_regs *regs)
 {
 	struct mce_hw_err *err = NULL;
 	struct mce *m = NULL;
@@ -1088,7 +1011,7 @@ static void mce_reign(void)
 	 */
 	if (m && global_worst >= MCE_PANIC_SEVERITY) {
 		/* call mce_severity() to get "msg" for panic */
-		mce_severity(m, NULL, &msg, true);
+		mce_severity(m, regs, &msg, true);
 		mce_panic("Fatal machine check", err, msg);
 	}
 
@@ -1197,7 +1120,7 @@ static noinstr int mce_start(int *no_way_out)
  * Synchronize between CPUs after main scanning loop.
  * This invokes the bulk of the Monarch processing.
  */
-static noinstr int mce_end(int order)
+static noinstr int mce_end(int order, struct pt_regs *regs)
 {
 	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
 	int ret = -1;
@@ -1227,7 +1150,7 @@ static noinstr int mce_end(int order)
 			ndelay(SPINUNIT);
 		}
 
-		mce_reign();
+		mce_reign(regs);
 		barrier();
 		ret = 0;
 	} else {
@@ -1557,7 +1480,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 
 	this_cpu_inc(mce_exception_count);
 
-	mce_gather_info(&err, regs);
+	mce_gather_info(&err);
 	m = &err.m;
 	m->tsc = rdtsc();
 
@@ -1607,7 +1530,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * When there's any problem use only local no_way_out state.
 	 */
 	if (!lmce) {
-		if (mce_end(order) < 0) {
+		if (mce_end(order, regs) < 0) {
 			if (!no_way_out)
 				no_way_out = worst >= MCE_PANIC_SEVERITY;
 
@@ -1950,9 +1873,6 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
 	 */
 	if (c->x86 == 0x15 && c->x86_model <= 0xf)
 		mce_flags.overflow_recov = 1;
-
-	if (c->x86 >= 0x17 && c->x86 <= 0x1A)
-		mce_flags.zen_ifu_quirk = 1;
 }
 
 static void apply_quirks_intel(struct cpuinfo_x86 *c)
@@ -1988,9 +1908,6 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
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
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 2235a7477436..6bf7081b19c0 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -272,23 +272,23 @@ static bool is_copy_from_user(struct pt_regs *regs)
 	return true;
 }
 
-/*
- * If mcgstatus indicated that ip/cs on the stack were
- * no good, then "m->cs" will be zero and we will have
- * to assume the worst case (IN_KERNEL) as we actually
- * have no idea what we were executing when the machine
- * check hit.
- * If we do have a good "m->cs" (or a faked one in the
- * case we were executing in VM86 mode) we can use it to
- * distinguish an exception taken in user from from one
- * taken in the kernel.
- */
 static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 {
 	int fixup_type;
 	bool copy_user;
 
-	if ((m->cs & 3) == 3)
+	/* Without register info, assume the worst. */
+	if (!regs)
+		return IN_KERNEL;
+
+	m->ip = regs->ip;
+	m->cs = regs->cs;
+
+	/* Use accurate RIP reporting if available. */
+	if (mca_cfg.rip_msr)
+		m->ip = mce_rdmsrq(mca_cfg.rip_msr);
+
+	if (user_mode(regs))
 		return IN_USER;
 
 	if (!mc_recoverable(m->mcgstatus))
-- 
2.50.1


