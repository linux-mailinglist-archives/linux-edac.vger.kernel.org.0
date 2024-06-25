Return-Path: <linux-edac+bounces-1367-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4019B917204
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2024 22:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E344228249C
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2024 20:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53F17FAB4;
	Tue, 25 Jun 2024 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZpoGqz9B"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D286817F4F7;
	Tue, 25 Jun 2024 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345408; cv=fail; b=XP3V8Evkjlf7C5g7y3PI6o5kzXqEVPX4HKvF6V1Uhqy7s15KSg4hDahOIE/vfRKmCUQnu4XWSTL16xz/xulaWHIyZ+ckRCf8j74EEIqViUpb3OGkkd740NeBlkEXSvd99gUHg1a0oPTWuYkrbSPNoyIcXz5E+eQ4FN7jDV7u9/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345408; c=relaxed/simple;
	bh=07lPrqj+gWoqNQJaaTJJimdGrzzwz2aZFYn31ve1bGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VK3NBqxkdXmSCrXgCQcmnjF5Vm95yw7tPD3v38hL4b1bT5K44nUK+K4yIuI4K1RuKzvPx7CexRAUV7B5VNI5W23ksIvELQBJXkwSFRdNCGGjoMKo66P/q6UNgvYTw90D0DprpXv7ml5BIOluqhbjK7DZcVyCdwVlqdBQEpPeedY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZpoGqz9B; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo0Jip70ngdgmV/M+IMSoeuj9e6Z8V2df/9SkwKNe2soJMVarVIqMjj2syBnOWW4u1rp7xL5Esm/sFIuYEv9oJaRfiRfDhFdCiTF4x/R4IZu6Z3VPSC4+fn2MOLIRGmmtRI+5cVZ+bkVC80H+NXEqwRuf6NZBmE0GnGksIPUF4QczoRvohidJI6hQDaBzELDvWdHff+wvucBJbmv/seZipOXkLyC3mG+L8B8f7b1K5pFPc2aIV0onk7HZVwF1izfJqqxKtt9sSxr2BVN3xll1OJNnn7i/7TSlJ7S7CAbYByPPl035q8HxTP5VukG+wyaJCR6qwPNrYTVgCkYthzqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20nMVYtwNx8+a4HeMlWK9XO8DEk4JwXy+98+lVv7z4Q=;
 b=EF728ede9rXMEGE2da+3aDZAfHpf6WNcwexI/ELMz+7vZ+m/9ixBUDU0p/W03A5i8tCG0TNIZoQRAjzyKdekqJJ/Bhk/HI2BAJiwvIZrsov1rDHjO42c/GVyPIFnmcjXOEUkx/Zlc23omXhF6K9P3BeWZVeyjtRvj61aA3IEpcaHe3FhSit0t2JkXWcpk+lvUs6bebQkfiIlToW8MXyPOOpEj8QBZS7h2BPOUZK751iTLFNbprrBoe09qD2/Nc0b2s68ljw1qaRKod5lqp9RTksxGIuGNj41ZfwpRxl1ZXC6Qqkm8jL9/PApYShJOhTQapL2FzwFI9lG41sPLep+3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20nMVYtwNx8+a4HeMlWK9XO8DEk4JwXy+98+lVv7z4Q=;
 b=ZpoGqz9BQnTva4qM6+KJbCytH2KNf+RpNZhYyaDACr+rtR9jVIMD0Rv8qrI75bGsfWji7mejjZcAKbMoNnmHMnIvPHXKrNo13dedggfFbATrPSw6rjSXUYuR9rac532UCBspRxo8hfVl9jXucaSlGIr2ysDPgWJETHVAG6T4Gkw=
Received: from DM6PR12CA0015.namprd12.prod.outlook.com (2603:10b6:5:1c0::28)
 by DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 19:56:43 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::49) by DM6PR12CA0015.outlook.office365.com
 (2603:10b6:5:1c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.39 via Frontend
 Transport; Tue, 25 Jun 2024 19:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 19:56:42 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 14:56:41 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v2 1/4] x86/mce: Add wrapper for struct mce to export vendor specific info
Date: Tue, 25 Jun 2024 14:56:21 -0500
Message-ID: <20240625195624.2565741-2-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bd18b1-28bf-4d3d-1fe0-08dc9550ef8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rDgLWx55OfPsgQ55AXhmcMY05Yg5xnyLBjtHIDJC3SeRiypza3epoZB4Vxo/?=
 =?us-ascii?Q?I8Gvz7fTCMvC3oENkhznlOBOkWd6sRSXVSquKLgbkFNm2ftQh5NxUjjpRVv4?=
 =?us-ascii?Q?SdIaAMW2fUARmxoRoFgQUk5uC6sbxTa48CMYYgqenBhdE7wSVLXBQkXh9xoD?=
 =?us-ascii?Q?NDVqsfJCe3vYqZRSKcjVWjq/+S9BYTNXJ2aSGURwb/5HrRb9o3+lkPSCYfWT?=
 =?us-ascii?Q?zlBSYvzT6RibCprRpRCoGGJD+Ai4A3qjCmPTZPa8nGBCWX8aGkiY8srlMUac?=
 =?us-ascii?Q?m5AowlB5vBXprprHrmoXPm/pX7g6WE8HRmGseu83TaQPhwPUX6WyPl+kQ3pp?=
 =?us-ascii?Q?MCGVJqucbzJk0s0wmuvqv8qRuC5eflahn9mZpYQoBNzz7EitsaJ1/pyNIwBA?=
 =?us-ascii?Q?VQgtws7CWDR8Mqmfjsn30YVrC+/ypaTYfl7k+sq1QkALIiHF5/2UjIWlfVhU?=
 =?us-ascii?Q?73zVPjY41NeOM+isa6wvgc2L/uVuRKWuUPRSKqRBmdzs86e4dPWS3A177HRQ?=
 =?us-ascii?Q?R1pbOC190YBQb+mky6q4mL5TAB4cZ9bgb8qMiOWXoAfRBrvwaRZlgrTZni4q?=
 =?us-ascii?Q?TGK3GE3FIjmTqDxcZqdNtQWkw4xKBOZlwb0zNKDH/0QIqBOkpF/FAOf6A3QA?=
 =?us-ascii?Q?Em0eDhcWjLnUqAfJQ2it7MT33LeKkOuk+9UvoAs/4tVI1EEUVQJLUqcejjoJ?=
 =?us-ascii?Q?mTy3uZg2KWuZUxPmMyGXbAI3Ln8f4r3iivVMVz17O2jn7k6ddXXl2f84rBt3?=
 =?us-ascii?Q?afICDTHRwatFSpM2RGwCxeICIisUdz8AuOGxBHQ0+h0kjEESQE/9oGSQ906+?=
 =?us-ascii?Q?/S5Kawhm1InpIkWYI/bv1hw1Hy8G4bWjpyGUa1Sd8CruOKmgxqIpz3kFVzLO?=
 =?us-ascii?Q?HQSpSfOb6cUTX2C//t9bLfhECG8EhQy9Tu3debIMtnwY5ARmPad93MfDns/N?=
 =?us-ascii?Q?LLMZhYhzUKW7UxUrkPyxVvEIpmiK/2aualAVkjCbRBOSdCqtCoK+KWxZe9rB?=
 =?us-ascii?Q?CIOeWMDntSh0L7DsRTj9PMqoQYLHUCKNtVCIwyh8LOOdPDgJ4entj7RYiRef?=
 =?us-ascii?Q?3EWyOixwuYWSZqqkGqPwKKNr7bEFDa+TOF2f1wbZsjaW0DBaOzou85vR/cMa?=
 =?us-ascii?Q?LhaxQiBkLwDJBPZG7ktOVZNfVZKfHgAET5EpqUYkVhZ2KZTd00sEJ/6h+1mM?=
 =?us-ascii?Q?nempSh8rmcjjsAryZ0ZU+hG9YeXWQzGSKXMH0oWX7Nov8wrn23TbAdYcPvOR?=
 =?us-ascii?Q?LCxil4brFmLqSDh/FJRfmjMxwTYW85BQ4EBwP2RLQfyCo3H/CSty3t7KIhfO?=
 =?us-ascii?Q?eCWaIsCu//Q9ToF2jAmxUdVoqVPHgIpPBr4N/msg3fx8gpNShqSHX7MAIoRi?=
 =?us-ascii?Q?vUyztJFjGqDkPFxl9rSm+dX52manBB6GMEcKkzHMGOk+it7xbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:56:42.7246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bd18b1-28bf-4d3d-1fe0-08dc9550ef8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826

Currently, exporting new additional machine check error information
involves adding new fields for the same at the end of the struct mce.
This additional information can then be consumed through mcelog or
tracepoint.

However, as new MSRs are being added (and will be added in the future)
by CPU vendors on their newer CPUs with additional machine check error
information to be exported, the size of struct mce will balloon on some
CPUs, unnecessarily, since those fields are vendor-specific. Moreover,
different CPU vendors may export the additional information in varying
sizes.

The problem particularly intensifies since struct mce is exposed to
userspace as part of UAPI. It's bloating through vendor-specific data
should be avoided to limit the information being sent out to userspace.

Add a new structure mce_hw_err to wrap the existing struct mce. The same
will prevent its ballooning since vendor-specifc data, if any, can now be
exported through a union within the wrapper structure and through
__dynamic_array in mce_record tracepoint.

Furthermore, new internal kernel fields can be added to the wrapper
struct without impacting the user space API.

Note: Some Checkpatch checks have been ignored to maintain coding style.

[Yazen: Add last commit message paragraph.]

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h              |   6 +-
 arch/x86/kernel/cpu/mce/amd.c           |  29 ++--
 arch/x86/kernel/cpu/mce/apei.c          |  54 +++----
 arch/x86/kernel/cpu/mce/core.c          | 178 +++++++++++++-----------
 arch/x86/kernel/cpu/mce/dev-mcelog.c    |   2 +-
 arch/x86/kernel/cpu/mce/genpool.c       |  20 +--
 arch/x86/kernel/cpu/mce/inject.c        |   4 +-
 arch/x86/kernel/cpu/mce/internal.h      |   4 +-
 drivers/acpi/acpi_extlog.c              |   2 +-
 drivers/acpi/nfit/mce.c                 |   2 +-
 drivers/edac/i7core_edac.c              |   2 +-
 drivers/edac/igen6_edac.c               |   2 +-
 drivers/edac/mce_amd.c                  |   2 +-
 drivers/edac/pnd2_edac.c                |   2 +-
 drivers/edac/sb_edac.c                  |   2 +-
 drivers/edac/skx_common.c               |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   2 +-
 drivers/ras/amd/fmpm.c                  |   2 +-
 drivers/ras/cec.c                       |   2 +-
 include/trace/events/mce.h              |  42 +++---
 20 files changed, 199 insertions(+), 162 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3ad29b128943..e955edb22897 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -187,6 +187,10 @@ enum mce_notifier_prios {
 	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
 };
 
+struct mce_hw_err {
+	struct mce m;
+};
+
 struct notifier_block;
 extern void mce_register_decode_chain(struct notifier_block *nb);
 extern void mce_unregister_decode_chain(struct notifier_block *nb);
@@ -222,7 +226,7 @@ static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 #endif
 
 void mce_setup(struct mce *m);
-void mce_log(struct mce *m);
+void mce_log(struct mce_hw_err *err);
 DECLARE_PER_CPU(struct device *, mce_device);
 
 /* Maximum number of MCA banks per CPU. */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9a0133ef7e20..cb7dc0b1aa50 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -778,29 +778,32 @@ bool amd_mce_usable_address(struct mce *m)
 
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
-	struct mce m;
+	struct mce_hw_err err;
+	struct mce *m = &err.m;
 
-	mce_setup(&m);
+	memset(&err, 0, sizeof(struct mce_hw_err));
 
-	m.status = status;
-	m.misc   = misc;
-	m.bank   = bank;
-	m.tsc	 = rdtsc();
+	mce_setup(m);
 
-	if (m.status & MCI_STATUS_ADDRV) {
-		m.addr = addr;
+	m->status = status;
+	m->misc   = misc;
+	m->bank   = bank;
+	m->tsc	 = rdtsc();
 
-		smca_extract_err_addr(&m);
+	if (m->status & MCI_STATUS_ADDRV) {
+		m->addr = addr;
+
+		smca_extract_err_addr(m);
 	}
 
 	if (mce_flags.smca) {
-		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m.ipid);
+		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
 
-		if (m.status & MCI_STATUS_SYNDV)
-			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m.synd);
+		if (m->status & MCI_STATUS_SYNDV)
+			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
 	}
 
-	mce_log(&m);
+	mce_log(&err);
 }
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 7f7309ff67d0..b8f4e75fb8a7 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -28,9 +28,12 @@
 
 void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 {
-	struct mce m;
+	struct mce_hw_err err;
+	struct mce *m = &err.m;
 	int lsb;
 
+	memset(&err, 0, sizeof(struct mce_hw_err));
+
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return;
 
@@ -44,30 +47,33 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 	else
 		lsb = PAGE_SHIFT;
 
-	mce_setup(&m);
-	m.bank = -1;
+	mce_setup(m);
+	m->bank = -1;
 	/* Fake a memory read error with unknown channel */
-	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
-	m.misc = (MCI_MISC_ADDR_PHYS << 6) | lsb;
+	m->status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
+	m->misc = (MCI_MISC_ADDR_PHYS << 6) | lsb;
 
 	if (severity >= GHES_SEV_RECOVERABLE)
-		m.status |= MCI_STATUS_UC;
+		m->status |= MCI_STATUS_UC;
 
 	if (severity >= GHES_SEV_PANIC) {
-		m.status |= MCI_STATUS_PCC;
-		m.tsc = rdtsc();
+		m->status |= MCI_STATUS_PCC;
+		m->tsc = rdtsc();
 	}
 
-	m.addr = mem_err->physical_addr;
-	mce_log(&m);
+	m->addr = mem_err->physical_addr;
+	mce_log(&err);
 }
 EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
+	struct mce_hw_err err;
+	struct mce *m = &err.m;
 	unsigned int cpu;
-	struct mce m;
+
+	memset(&err, 0, sizeof(struct mce_hw_err));
 
 	if (!boot_cpu_has(X86_FEATURE_SMCA))
 		return -EINVAL;
@@ -97,29 +103,29 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
-	mce_setup(&m);
+	mce_setup(m);
 
-	m.extcpu = -1;
-	m.socketid = -1;
+	m->extcpu = -1;
+	m->socketid = -1;
 
 	for_each_possible_cpu(cpu) {
 		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
-			m.extcpu = cpu;
-			m.socketid = cpu_data(m.extcpu).topo.pkg_id;
+			m->extcpu = cpu;
+			m->socketid = cpu_data(m->extcpu).topo.pkg_id;
 			break;
 		}
 	}
 
-	m.apicid = lapic_id;
-	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
-	m.status = *i_mce;
-	m.addr = *(i_mce + 1);
-	m.misc = *(i_mce + 2);
+	m->apicid = lapic_id;
+	m->bank = (ctx_info->msr_addr >> 4) & 0xFF;
+	m->status = *i_mce;
+	m->addr = *(i_mce + 1);
+	m->misc = *(i_mce + 2);
 	/* Skipping MCA_CONFIG */
-	m.ipid = *(i_mce + 4);
-	m.synd = *(i_mce + 5);
+	m->ipid = *(i_mce + 4);
+	m->synd = *(i_mce + 5);
 
-	mce_log(&m);
+	mce_log(&err);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b85ec7a4ec9e..6225143b9b14 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -88,7 +88,7 @@ struct mca_config mca_cfg __read_mostly = {
 	.monarch_timeout = -1
 };
 
-static DEFINE_PER_CPU(struct mce, mces_seen);
+static DEFINE_PER_CPU(struct mce_hw_err, hw_errs_seen);
 static unsigned long mce_need_notify;
 
 /*
@@ -136,9 +136,9 @@ void mce_setup(struct mce *m)
 DEFINE_PER_CPU(struct mce, injectm);
 EXPORT_PER_CPU_SYMBOL_GPL(injectm);
 
-void mce_log(struct mce *m)
+void mce_log(struct mce_hw_err *err)
 {
-	if (!mce_gen_pool_add(m))
+	if (!mce_gen_pool_add(err))
 		irq_work_queue(&mce_irq_work);
 }
 EXPORT_SYMBOL_GPL(mce_log);
@@ -159,8 +159,10 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
 
-static void __print_mce(struct mce *m)
+static void __print_mce(struct mce_hw_err *err)
 {
+	struct mce *m = &err->m;
+
 	pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
 		 m->extcpu,
 		 (m->mcgstatus & MCG_STATUS_MCIP ? " Exception" : ""),
@@ -202,9 +204,11 @@ static void __print_mce(struct mce *m)
 		m->microcode);
 }
 
-static void print_mce(struct mce *m)
+static void print_mce(struct mce_hw_err *err)
 {
-	__print_mce(m);
+	struct mce *m = &err->m;
+
+	__print_mce(err);
 
 	if (m->cpuvendor != X86_VENDOR_AMD && m->cpuvendor != X86_VENDOR_HYGON)
 		pr_emerg_ratelimited(HW_ERR "Run the above through 'mcelog --ascii'\n");
@@ -239,7 +243,7 @@ static const char *mce_dump_aux_info(struct mce *m)
 	return NULL;
 }
 
-static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
+static noinstr void mce_panic(const char *msg, struct mce_hw_err *final, char *exp)
 {
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
@@ -270,20 +274,22 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	pending = mce_gen_pool_prepare_records();
 	/* First print corrected ones that are still unlogged */
 	llist_for_each_entry(l, pending, llnode) {
-		struct mce *m = &l->mce;
+		struct mce_hw_err *err = &l->err;
+		struct mce *m = &err->m;
 		if (!(m->status & MCI_STATUS_UC)) {
-			print_mce(m);
+			print_mce(err);
 			if (!apei_err)
 				apei_err = apei_write_mce(m);
 		}
 	}
 	/* Now print uncorrected but with the final one last */
 	llist_for_each_entry(l, pending, llnode) {
-		struct mce *m = &l->mce;
+		struct mce_hw_err *err = &l->err;
+		struct mce *m = &err->m;
 		if (!(m->status & MCI_STATUS_UC))
 			continue;
-		if (!final || mce_cmp(m, final)) {
-			print_mce(m);
+		if (!final || mce_cmp(m, &final->m)) {
+			print_mce(err);
 			if (!apei_err)
 				apei_err = apei_write_mce(m);
 		}
@@ -291,12 +297,12 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (final) {
 		print_mce(final);
 		if (!apei_err)
-			apei_err = apei_write_mce(final);
+			apei_err = apei_write_mce(&final->m);
 	}
 	if (exp)
 		pr_emerg(HW_ERR "Machine check: %s\n", exp);
 
-	memmsg = mce_dump_aux_info(final);
+	memmsg = mce_dump_aux_info(&final->m);
 	if (memmsg)
 		pr_emerg(HW_ERR "Machine check: %s\n", memmsg);
 
@@ -311,9 +317,9 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 		 * panic.
 		 */
 		if (kexec_crash_loaded()) {
-			if (final && (final->status & MCI_STATUS_ADDRV)) {
+			if (final && (final->m.status & MCI_STATUS_ADDRV)) {
 				struct page *p;
-				p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
+				p = pfn_to_online_page(final->m.addr >> PAGE_SHIFT);
 				if (p)
 					SetPageHWPoison(p);
 			}
@@ -562,13 +568,13 @@ EXPORT_SYMBOL_GPL(mce_is_correctable);
 static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
-	struct mce *m = (struct mce *)data;
+	struct mce_hw_err *err = (struct mce_hw_err *)data;
 
-	if (!m)
+	if (!err)
 		return NOTIFY_DONE;
 
 	/* Emit the trace record: */
-	trace_mce_record(m);
+	trace_mce_record(err);
 
 	set_bit(0, &mce_need_notify);
 
@@ -585,7 +591,8 @@ static struct notifier_block early_nb = {
 static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce_hw_err *err = (struct mce_hw_err *)data;
+	struct mce *mce = &err->m;
 	unsigned long pfn;
 
 	if (!mce || !mce_usable_address(mce))
@@ -612,13 +619,13 @@ static struct notifier_block mce_uc_nb = {
 static int mce_default_notifier(struct notifier_block *nb, unsigned long val,
 				void *data)
 {
-	struct mce *m = (struct mce *)data;
+	struct mce_hw_err *err = (struct mce_hw_err *)data;
 
-	if (!m)
+	if (!err)
 		return NOTIFY_DONE;
 
-	if (mca_cfg.print_all || !m->kflags)
-		__print_mce(m);
+	if (mca_cfg.print_all || !(err->m.kflags))
+		__print_mce(err);
 
 	return NOTIFY_DONE;
 }
@@ -680,26 +687,29 @@ DEFINE_PER_CPU(unsigned, mce_poll_count);
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-	struct mce m;
+	struct mce_hw_err err;
+	struct mce *m = &err.m;
 	int i;
 
+	memset(&err, 0, sizeof(struct mce_hw_err));
+
 	this_cpu_inc(mce_poll_count);
 
-	mce_gather_info(&m, NULL);
+	mce_gather_info(m, NULL);
 
 	if (flags & MCP_TIMESTAMP)
-		m.tsc = rdtsc();
+		m->tsc = rdtsc();
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		if (!mce_banks[i].ctl || !test_bit(i, *b))
 			continue;
 
-		m.misc = 0;
-		m.addr = 0;
-		m.bank = i;
+		m->misc = 0;
+		m->addr = 0;
+		m->bank = i;
 
 		barrier();
-		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
+		m->status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 
 		/*
 		 * Update storm tracking here, before checking for the
@@ -709,17 +719,17 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		 * storm status.
 		 */
 		if (!mca_cfg.cmci_disabled)
-			mce_track_storm(&m);
+			mce_track_storm(m);
 
 		/* If this entry is not valid, ignore it */
-		if (!(m.status & MCI_STATUS_VAL))
+		if (!(m->status & MCI_STATUS_VAL))
 			continue;
 
 		/*
 		 * If we are logging everything (at CPU online) or this
 		 * is a corrected error, then we must log it.
 		 */
-		if ((flags & MCP_UC) || !(m.status & MCI_STATUS_UC))
+		if ((flags & MCP_UC) || !(m->status & MCI_STATUS_UC))
 			goto log_it;
 
 		/*
@@ -729,20 +739,20 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		 * everything else.
 		 */
 		if (!mca_cfg.ser) {
-			if (m.status & MCI_STATUS_UC)
+			if (m->status & MCI_STATUS_UC)
 				continue;
 			goto log_it;
 		}
 
 		/* Log "not enabled" (speculative) errors */
-		if (!(m.status & MCI_STATUS_EN))
+		if (!(m->status & MCI_STATUS_EN))
 			goto log_it;
 
 		/*
 		 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
 		 * UC == 1 && PCC == 0 && S == 0
 		 */
-		if (!(m.status & MCI_STATUS_PCC) && !(m.status & MCI_STATUS_S))
+		if (!(m->status & MCI_STATUS_PCC) && !(m->status & MCI_STATUS_S))
 			goto log_it;
 
 		/*
@@ -756,20 +766,20 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (flags & MCP_DONTLOG)
 			goto clear_it;
 
-		mce_read_aux(&m, i);
-		m.severity = mce_severity(&m, NULL, NULL, false);
+		mce_read_aux(m, i);
+		m->severity = mce_severity(m, NULL, NULL, false);
 		/*
 		 * Don't get the IP here because it's unlikely to
 		 * have anything to do with the actual error location.
 		 */
 
-		if (mca_cfg.dont_log_ce && !mce_usable_address(&m))
+		if (mca_cfg.dont_log_ce && !mce_usable_address(m))
 			goto clear_it;
 
 		if (flags & MCP_QUEUE_LOG)
-			mce_gen_pool_add(&m);
+			mce_gen_pool_add(&err);
 		else
-			mce_log(&m);
+			mce_log(&err);
 
 clear_it:
 		/*
@@ -1005,6 +1015,7 @@ static noinstr int mce_timed_out(u64 *t, const char *msg)
 static void mce_reign(void)
 {
 	int cpu;
+	struct mce_hw_err *err = NULL;
 	struct mce *m = NULL;
 	int global_worst = 0;
 	char *msg = NULL;
@@ -1015,11 +1026,13 @@ static void mce_reign(void)
 	 * Grade the severity of the errors of all the CPUs.
 	 */
 	for_each_possible_cpu(cpu) {
-		struct mce *mtmp = &per_cpu(mces_seen, cpu);
+		struct mce_hw_err *etmp = &per_cpu(hw_errs_seen, cpu);
+		struct mce *mtmp = &etmp->m;
 
 		if (mtmp->severity > global_worst) {
 			global_worst = mtmp->severity;
-			m = &per_cpu(mces_seen, cpu);
+			err = &per_cpu(hw_errs_seen, cpu);
+			m = &err->m;
 		}
 	}
 
@@ -1031,7 +1044,7 @@ static void mce_reign(void)
 	if (m && global_worst >= MCE_PANIC_SEVERITY) {
 		/* call mce_severity() to get "msg" for panic */
 		mce_severity(m, NULL, &msg, true);
-		mce_panic("Fatal machine check", m, msg);
+		mce_panic("Fatal machine check", err, msg);
 	}
 
 	/*
@@ -1048,11 +1061,11 @@ static void mce_reign(void)
 		mce_panic("Fatal machine check from unknown source", NULL, NULL);
 
 	/*
-	 * Now clear all the mces_seen so that they don't reappear on
+	 * Now clear all the hw_errs_seen so that they don't reappear on
 	 * the next mce.
 	 */
 	for_each_possible_cpu(cpu)
-		memset(&per_cpu(mces_seen, cpu), 0, sizeof(struct mce));
+		memset(&per_cpu(hw_errs_seen, cpu), 0, sizeof(struct mce_hw_err));
 }
 
 static atomic_t global_nwo;
@@ -1256,12 +1269,13 @@ static noinstr bool mce_check_crashing_cpu(void)
 }
 
 static __always_inline int
-__mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
+__mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs, struct mce *final,
 		unsigned long *toclear, unsigned long *valid_banks, int no_way_out,
 		int *worst)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	struct mca_config *cfg = &mca_cfg;
+	struct mce *m = &err->m;
 	int severity, i, taint = 0;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
@@ -1317,7 +1331,7 @@ __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
 		 * done in #MC context, where instrumentation is disabled.
 		 */
 		instrumentation_begin();
-		mce_log(m);
+		mce_log(err);
 		instrumentation_end();
 
 		if (severity > *worst) {
@@ -1387,8 +1401,9 @@ static void kill_me_never(struct callback_head *cb)
 		set_mce_nospec(pfn);
 }
 
-static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callback_head *))
+static void queue_task_work(struct mce_hw_err *err, char *msg, void (*func)(struct callback_head *))
 {
+	struct mce *m = &err->m;
 	int count = ++current->mce_count;
 
 	/* First call, save all the details */
@@ -1402,11 +1417,12 @@ static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callba
 
 	/* Ten is likely overkill. Don't expect more than two faults before task_work() */
 	if (count > 10)
-		mce_panic("Too many consecutive machine checks while accessing user data", m, msg);
+		mce_panic("Too many consecutive machine checks while accessing user data",
+			  err, msg);
 
 	/* Second or later call, make sure page address matches the one from first call */
 	if (count > 1 && (current->mce_addr >> PAGE_SHIFT) != (m->addr >> PAGE_SHIFT))
-		mce_panic("Consecutive machine checks to different user pages", m, msg);
+		mce_panic("Consecutive machine checks to different user pages", err, msg);
 
 	/* Do not call task_work_add() more than once */
 	if (count > 1)
@@ -1455,8 +1471,14 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	int worst = 0, order, no_way_out, kill_current_task, lmce, taint = 0;
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS) = { 0 };
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS) = { 0 };
-	struct mce m, *final;
+	struct mce_hw_err *final;
+	struct mce_hw_err err;
 	char *msg = NULL;
+	struct mce *m;
+
+	memset(&err, 0, sizeof(struct mce_hw_err));
+
+	m = &err.m;
 
 	if (unlikely(mce_flags.p5))
 		return pentium_machine_check(regs);
@@ -1494,13 +1516,13 @@ noinstr void do_machine_check(struct pt_regs *regs)
 
 	this_cpu_inc(mce_exception_count);
 
-	mce_gather_info(&m, regs);
-	m.tsc = rdtsc();
+	mce_gather_info(m, regs);
+	m->tsc = rdtsc();
 
-	final = this_cpu_ptr(&mces_seen);
-	*final = m;
+	final = this_cpu_ptr(&hw_errs_seen);
+	final->m = *m;
 
-	no_way_out = mce_no_way_out(&m, &msg, valid_banks, regs);
+	no_way_out = mce_no_way_out(m, &msg, valid_banks, regs);
 
 	barrier();
 
@@ -1509,15 +1531,15 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * Assume the worst for now, but if we find the
 	 * severity is MCE_AR_SEVERITY we have other options.
 	 */
-	if (!(m.mcgstatus & MCG_STATUS_RIPV))
+	if (!(m->mcgstatus & MCG_STATUS_RIPV))
 		kill_current_task = 1;
 	/*
 	 * Check if this MCE is signaled to only this logical processor,
 	 * on Intel, Zhaoxin only.
 	 */
-	if (m.cpuvendor == X86_VENDOR_INTEL ||
-	    m.cpuvendor == X86_VENDOR_ZHAOXIN)
-		lmce = m.mcgstatus & MCG_STATUS_LMCES;
+	if (m->cpuvendor == X86_VENDOR_INTEL ||
+	    m->cpuvendor == X86_VENDOR_ZHAOXIN)
+		lmce = m->mcgstatus & MCG_STATUS_LMCES;
 
 	/*
 	 * Local machine check may already know that we have to panic.
@@ -1528,12 +1550,12 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 */
 	if (lmce) {
 		if (no_way_out)
-			mce_panic("Fatal local machine check", &m, msg);
+			mce_panic("Fatal local machine check", &err, msg);
 	} else {
 		order = mce_start(&no_way_out);
 	}
 
-	taint = __mc_scan_banks(&m, regs, final, toclear, valid_banks, no_way_out, &worst);
+	taint = __mc_scan_banks(&err, regs, &final->m, toclear, valid_banks, no_way_out, &worst);
 
 	if (!no_way_out)
 		mce_clear_state(toclear);
@@ -1548,7 +1570,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 				no_way_out = worst >= MCE_PANIC_SEVERITY;
 
 			if (no_way_out)
-				mce_panic("Fatal machine check on current CPU", &m, msg);
+				mce_panic("Fatal machine check on current CPU", &err, msg);
 		}
 	} else {
 		/*
@@ -1560,8 +1582,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 * make sure we have the right "msg".
 		 */
 		if (worst >= MCE_PANIC_SEVERITY) {
-			mce_severity(&m, regs, &msg, true);
-			mce_panic("Local fatal machine check!", &m, msg);
+			mce_severity(m, regs, &msg, true);
+			mce_panic("Local fatal machine check!", &err, msg);
 		}
 	}
 
@@ -1579,16 +1601,16 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		goto out;
 
 	/* Fault was in user mode and we need to take some action */
-	if ((m.cs & 3) == 3) {
+	if ((m->cs & 3) == 3) {
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		if (!mce_usable_address(&m))
-			queue_task_work(&m, msg, kill_me_now);
+		if (!mce_usable_address(m))
+			queue_task_work(&err, msg, kill_me_now);
 		else
-			queue_task_work(&m, msg, kill_me_maybe);
+			queue_task_work(&err, msg, kill_me_maybe);
 
-	} else if (m.mcgstatus & MCG_STATUS_SEAM_NR) {
+	} else if (m->mcgstatus & MCG_STATUS_SEAM_NR) {
 		/*
 		 * Saved RIP on stack makes it look like the machine check
 		 * was taken in the kernel on the instruction following
@@ -1600,8 +1622,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 * not occur there. Mark the page as poisoned so it won't
 		 * be added to free list when the guest is terminated.
 		 */
-		if (mce_usable_address(&m)) {
-			struct page *p = pfn_to_online_page(m.addr >> PAGE_SHIFT);
+		if (mce_usable_address(m)) {
+			struct page *p = pfn_to_online_page(m->addr >> PAGE_SHIFT);
 
 			if (p)
 				SetPageHWPoison(p);
@@ -1616,13 +1638,13 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 * corresponding exception handler which would do that is the
 		 * proper one.
 		 */
-		if (m.kflags & MCE_IN_KERNEL_RECOV) {
+		if (m->kflags & MCE_IN_KERNEL_RECOV) {
 			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
-				mce_panic("Failed kernel mode recovery", &m, msg);
+				mce_panic("Failed kernel mode recovery", &err, msg);
 		}
 
-		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, msg, kill_me_never);
+		if (m->kflags & MCE_IN_KERNEL_COPYIN)
+			queue_task_work(&err, msg, kill_me_never);
 	}
 
 out:
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index a05ac0716ecf..4a0e3bb4a4fb 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -36,7 +36,7 @@ static DECLARE_WAIT_QUEUE_HEAD(mce_chrdev_wait);
 static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 				void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	unsigned int entry;
 
 	if (mce->kflags & MCE_HANDLED_CEC)
diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index 4284749ec803..3337ea5c428d 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -31,15 +31,15 @@ static LLIST_HEAD(mce_event_llist);
  */
 static bool is_duplicate_mce_record(struct mce_evt_llist *t, struct mce_evt_llist *l)
 {
+	struct mce_hw_err *err1, *err2;
 	struct mce_evt_llist *node;
-	struct mce *m1, *m2;
 
-	m1 = &t->mce;
+	err1 = &t->err;
 
 	llist_for_each_entry(node, &l->llnode, llnode) {
-		m2 = &node->mce;
+		err2 = &node->err;
 
-		if (!mce_cmp(m1, m2))
+		if (!mce_cmp(&err1->m, &err2->m))
 			return true;
 	}
 	return false;
@@ -73,9 +73,9 @@ struct llist_node *mce_gen_pool_prepare_records(void)
 
 void mce_gen_pool_process(struct work_struct *__unused)
 {
+	struct mce_hw_err *err;
 	struct llist_node *head;
 	struct mce_evt_llist *node, *tmp;
-	struct mce *mce;
 
 	head = llist_del_all(&mce_event_llist);
 	if (!head)
@@ -83,8 +83,8 @@ void mce_gen_pool_process(struct work_struct *__unused)
 
 	head = llist_reverse_order(head);
 	llist_for_each_entry_safe(node, tmp, head, llnode) {
-		mce = &node->mce;
-		blocking_notifier_call_chain(&x86_mce_decoder_chain, 0, mce);
+		err = &node->err;
+		blocking_notifier_call_chain(&x86_mce_decoder_chain, 0, err);
 		gen_pool_free(mce_evt_pool, (unsigned long)node, sizeof(*node));
 	}
 }
@@ -94,11 +94,11 @@ bool mce_gen_pool_empty(void)
 	return llist_empty(&mce_event_llist);
 }
 
-int mce_gen_pool_add(struct mce *mce)
+int mce_gen_pool_add(struct mce_hw_err *err)
 {
 	struct mce_evt_llist *node;
 
-	if (filter_mce(mce))
+	if (filter_mce(&err->m))
 		return -EINVAL;
 
 	if (!mce_evt_pool)
@@ -110,7 +110,7 @@ int mce_gen_pool_add(struct mce *mce)
 		return -ENOMEM;
 	}
 
-	memcpy(&node->mce, mce, sizeof(*mce));
+	memcpy(&node->err, err, sizeof(*err));
 	llist_add(&node->llnode, &mce_event_llist);
 
 	return 0;
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 49ed3428785d..c65a5c4e2f22 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -502,6 +502,7 @@ static void prepare_msrs(void *info)
 
 static void do_inject(void)
 {
+	struct mce_hw_err err;
 	u64 mcg_status = 0;
 	unsigned int cpu = i_mce.extcpu;
 	u8 b = i_mce.bank;
@@ -517,7 +518,8 @@ static void do_inject(void)
 		i_mce.status |= MCI_STATUS_SYNDV;
 
 	if (inj_type == SW_INJ) {
-		mce_log(&i_mce);
+		err.m = i_mce;
+		mce_log(&err);
 		return;
 	}
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 01f8f03969e6..c79cb5b00e4c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -26,12 +26,12 @@ extern struct blocking_notifier_head x86_mce_decoder_chain;
 
 struct mce_evt_llist {
 	struct llist_node llnode;
-	struct mce mce;
+	struct mce_hw_err err;
 };
 
 void mce_gen_pool_process(struct work_struct *__unused);
 bool mce_gen_pool_empty(void);
-int mce_gen_pool_add(struct mce *mce);
+int mce_gen_pool_add(struct mce_hw_err *err);
 int mce_gen_pool_init(void);
 struct llist_node *mce_gen_pool_prepare_records(void);
 
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index ca87a0939135..4864191918db 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -134,7 +134,7 @@ static int print_extlog_rcd(const char *pfx,
 static int extlog_print(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	int	bank = mce->bank;
 	int	cpu = mce->extcpu;
 	struct acpi_hest_generic_status *estatus, *tmp;
diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index d48a388b796e..b917988db794 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -13,7 +13,7 @@
 static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	struct acpi_nfit_desc *acpi_desc;
 	struct nfit_spa *nfit_spa;
 
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 91e0a88ef904..d1e47cba0ff2 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1810,7 +1810,7 @@ static void i7core_check_error(struct mem_ctl_info *mci, struct mce *m)
 static int i7core_mce_check_error(struct notifier_block *nb, unsigned long val,
 				  void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	struct i7core_dev *i7_dev;
 	struct mem_ctl_info *mci;
 
diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index dbe9fe5f2ca6..7579c4fa6f18 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -911,7 +911,7 @@ static int ecclog_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 static int ecclog_mce_handler(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	char *type;
 
 	if (mce->kflags & MCE_HANDLED_CEC)
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 8130c3dc64da..c5fae99de781 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -792,7 +792,7 @@ static const char *decode_error_status(struct mce *m)
 static int
 amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 {
-	struct mce *m = (struct mce *)data;
+	struct mce *m = &((struct mce_hw_err *)data)->m;
 	unsigned int fam = x86_family(m->cpuid);
 	int ecc;
 
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 2afcd148fcf8..e2fb2d75af04 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1366,7 +1366,7 @@ static void pnd2_unregister_mci(struct mem_ctl_info *mci)
  */
 static int pnd2_mce_check_error(struct notifier_block *nb, unsigned long val, void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	struct mem_ctl_info *mci;
 	struct dram_addr daddr;
 	char *type;
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 26cca5a9322d..0c4e45245153 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3255,7 +3255,7 @@ static void sbridge_mce_output_error(struct mem_ctl_info *mci,
 static int sbridge_mce_check_error(struct notifier_block *nb, unsigned long val,
 				   void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	struct mem_ctl_info *mci;
 	char *type;
 
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 27996b7924c8..7de89c24e06f 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -633,7 +633,7 @@ static bool skx_error_in_mem(const struct mce *m)
 int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	struct decoded_addr res;
 	struct mem_ctl_info *mci;
 	char *type;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1adc81a55734..d8cd44eb7e73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3824,7 +3824,7 @@ static struct amdgpu_device *find_adev(uint32_t node_id)
 static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 				    unsigned long val, void *data)
 {
-	struct mce *m = (struct mce *)data;
+	struct mce *m = &((struct mce_hw_err *)data)->m;
 	struct amdgpu_device *adev = NULL;
 	uint32_t gpu_id = 0;
 	uint32_t umc_inst = 0, ch_inst = 0;
diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 271dfad05d68..d3ce41a46ac4 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -400,7 +400,7 @@ static void retire_dram_row(u64 addr, u64 id, u32 cpu)
 
 static int fru_handle_mem_poison(struct notifier_block *nb, unsigned long val, void *data)
 {
-	struct mce *m = (struct mce *)data;
+	struct mce *m = &((struct mce_hw_err *)data)->m;
 	struct fru_rec *rec;
 
 	if (!mce_is_memory_error(m))
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index e440b15fbabc..be785746f587 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -534,7 +534,7 @@ static int __init create_debugfs_nodes(void)
 static int cec_notifier(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
-	struct mce *m = (struct mce *)data;
+	struct mce *m = &((struct mce_hw_err *)data)->m;
 
 	if (!m)
 		return NOTIFY_DONE;
diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index f0f7b3cb2041..65aba1afcd07 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -19,9 +19,9 @@
 
 TRACE_EVENT(mce_record,
 
-	TP_PROTO(struct mce *m),
+	TP_PROTO(struct mce_hw_err *err),
 
-	TP_ARGS(m),
+	TP_ARGS(err),
 
 	TP_STRUCT__entry(
 		__field(	u64,		mcgcap		)
@@ -46,25 +46,25 @@ TRACE_EVENT(mce_record,
 	),
 
 	TP_fast_assign(
-		__entry->mcgcap		= m->mcgcap;
-		__entry->mcgstatus	= m->mcgstatus;
-		__entry->status		= m->status;
-		__entry->addr		= m->addr;
-		__entry->misc		= m->misc;
-		__entry->synd		= m->synd;
-		__entry->ipid		= m->ipid;
-		__entry->ip		= m->ip;
-		__entry->tsc		= m->tsc;
-		__entry->ppin		= m->ppin;
-		__entry->walltime	= m->time;
-		__entry->cpu		= m->extcpu;
-		__entry->cpuid		= m->cpuid;
-		__entry->apicid		= m->apicid;
-		__entry->socketid	= m->socketid;
-		__entry->cs		= m->cs;
-		__entry->bank		= m->bank;
-		__entry->cpuvendor	= m->cpuvendor;
-		__entry->microcode	= m->microcode;
+		__entry->mcgcap		= err->m.mcgcap;
+		__entry->mcgstatus	= err->m.mcgstatus;
+		__entry->status		= err->m.status;
+		__entry->addr		= err->m.addr;
+		__entry->misc		= err->m.misc;
+		__entry->synd		= err->m.synd;
+		__entry->ipid		= err->m.ipid;
+		__entry->ip		= err->m.ip;
+		__entry->tsc		= err->m.tsc;
+		__entry->ppin		= err->m.ppin;
+		__entry->walltime	= err->m.time;
+		__entry->cpu		= err->m.extcpu;
+		__entry->cpuid		= err->m.cpuid;
+		__entry->apicid		= err->m.apicid;
+		__entry->socketid	= err->m.socketid;
+		__entry->cs		= err->m.cs;
+		__entry->bank		= err->m.bank;
+		__entry->cpuvendor	= err->m.cpuvendor;
+		__entry->microcode	= err->m.microcode;
 	),
 
 	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x",
-- 
2.34.1


