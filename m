Return-Path: <linux-edac+bounces-1651-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 436D8953C75
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 23:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6676E1F25838
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 21:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EF014E2F5;
	Thu, 15 Aug 2024 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ymuuk2Gz"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7114E2DF;
	Thu, 15 Aug 2024 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756626; cv=fail; b=B76PBiPneLbkbrtXDZSgdGeyfLwT+tvFfPZsQcp31edsQU4ZGfDM56PQrm2YKju+kjbIzM4Z7hcltzLOT0aUgc6IF+fvTilQlGBfkRGA5nhgiP/GN/irkP2Begg3K7VfJ42+mhbBkoHxwyg+5TESwDaKkoZt/22kcW959u82XbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756626; c=relaxed/simple;
	bh=pd4VMItTsqoMsO/3JzEMJ+sntpLIc4QyFKQtRddm+Vo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyPoZGcYa237kcCd4lpOTf3aIjGKrSSP+5CqOD+3e8dnWstuMWiywnY1P/Z8w9In2Exj46Tbb1EFZBDXyYP6VFr8BYgscSCwA2FscD3ySj3xm0TLO6JRfP7LqwNfH4zBR7ftfPfkHShZphq11l6aQiMRaMXbls6UtZsD59PH6ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ymuuk2Gz; arc=fail smtp.client-ip=40.107.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seelKtwU9vOpy6b1BxgtMPopho4ibHiTZmaEhzrP3PZL7PhD4ZZ37Ad07F32foNsPbZJvfGLMFzYcGkvCgAmCeGNnhzWbGWsf0iVxeXoS7DsNHB56j34NljSC9cItcB3gHOC4WZlXueAiVOKQ43ZSYkww/qTPFM9JK5EJxsU7IUisrENHIMY4QWUVkvFBS9BLZeZziv/sJnfKTpQY+wjBKMbM46dCclqY7pt5U7PwSB5WMcqZ/YVYu7HNlzg8mNDX8/mC/Zs0QvQYFGDaM7+kBkFS5nd+jMuzGuTVexDSum/1UTcjTm7WNwTssQkGYmnrs/aA8+lXjrPWeuCVAizUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlotC2y4ZhmGAx3NUMDndgbNnyOacOyhij/KS9oiWAg=;
 b=obPe3o7En2NB/RyCpkDtbtxapz3lh7cCi2xnxcssIlqxdZIK74BOWxrKLNjBwye3YtIEZpsTfoX6L0esxs+GgQVFj9fj06E1Ft9TNHQc5CfLPPlglOEOXZR/701dnEsNFQEfUNyUMflSHxQxZtDKWA32SczU1S8xtQUOO6iAjDcD+6XBmjI5haIIlySh24ekUJHKmOCOahBCKlFtafmhEYsgig+Tk3DBInEuFTgZCK48yGHySYzx7XGo+gKkxf5dGpZDfu+CnOZUXXGNd36RWQktPa1hLOn0+18BFgArmk83ynzVGNaODlkkJrLBdKHI0IYjXrHl6o/jsJKSdG5ITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlotC2y4ZhmGAx3NUMDndgbNnyOacOyhij/KS9oiWAg=;
 b=Ymuuk2GzoZN0arBN+z+vbUjHEQtP0+NgLeoGsuRcxY16cFt2yeXjS5KcIDjB/LtYl0BvXRYrGY4YNtMPCSeG6gsWKIcDTrvGQ2+InFsy3MJGoJsChDQBwd4Pv/ln0gKqAhu2pkQp7UX9NfJJzLyKg9u6aEoYyNhjBKPMbWKQVL4=
Received: from MN2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:208:1a0::14)
 by PH0PR12MB8126.namprd12.prod.outlook.com (2603:10b6:510:299::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 21:16:54 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::1) by MN2PR07CA0004.outlook.office365.com
 (2603:10b6:208:1a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 21:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 21:16:53 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 16:16:52 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v4 1/4] x86/mce: Add wrapper for struct mce to export vendor specific info
Date: Thu, 15 Aug 2024 16:16:32 -0500
Message-ID: <20240815211635.1336721-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815211635.1336721-1-avadhut.naik@amd.com>
References: <20240815211635.1336721-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|PH0PR12MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fbfcb7-9ed6-4b88-6d44-08dcbd6f9619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5MK92UKL0m4XFJWDVFtxhYCQa/2WgOqUC9Lmpgl3MJ8KGVH2OP51y4W2YbmO?=
 =?us-ascii?Q?6SjRNUZpJVMcPfusQeB8t2GG4PKHYZGCV68sQj4hPy7j7R/gn2ftJLTukg9p?=
 =?us-ascii?Q?0KOv4cDb1VKy3gwCqtvtxKi/HSeZWsEY52NfkGKBQaY7b+SJDwZig2EUgkjx?=
 =?us-ascii?Q?xsPBXavQ8IX5J1Tq2PqCVxF7bz9tcJfiyeLDcIBUxqJDct203cDT4u9TVPxX?=
 =?us-ascii?Q?DSPEC3SmfeRFW5nGTMozYmHBuqzIeg1IsK7n3gTdHMwfkhYjANQbHXReLx3h?=
 =?us-ascii?Q?foACyO5Z66UaAC1DJSrDzM+0JG8le9HfIWO1IfkI6mBU+m9LCcgjwBhdEuTz?=
 =?us-ascii?Q?0C1X2v9ApZTC5OLo64fC61+SwLX60u0jpIY1Xe3mfnLHBTQMps3gThIHUcfD?=
 =?us-ascii?Q?hooTOy8ECSy6Zm2ww0236aFzlunTJi4U0KU/ydqzCfubiokioUMKf7Pm13Ot?=
 =?us-ascii?Q?YwSlcDX82S+5bH+1URljJfvlTMXvSZwIa57Ek5cG+J3Tw0ZDHBx4PKj9bFkX?=
 =?us-ascii?Q?BitKxKVdHDupe7F22hIBXYRkTgDmtsstG1amXWd1PlSzr5uD3BefrZnCfV/D?=
 =?us-ascii?Q?lRGF7xvsR7/iyOtR06QuZvMzRtossKHg7ggzwWjGJD1JM850S8tnLYjDfs2c?=
 =?us-ascii?Q?MMYqRcAMylaRswD4TY+7ux78LqjuisN56472WDrolLdbdluHJ3z232oRoGNL?=
 =?us-ascii?Q?RIdtT86vNiUf9Eh63zfdySSsIG8ktm9VyvmKpqmpu/4vFGdRBsow/EFFuMYn?=
 =?us-ascii?Q?xZ/nC9t3PpKHqMe+emyfWTmlIOB8Sfnp1vqiC+viaaxXIr1u7DBIT0cLtcdN?=
 =?us-ascii?Q?1Z6VYuC+crwi0tvzQ8BBiwpl1vHL+4/vGfI2dRPk9gFHQ6xCksUiarX6nKBC?=
 =?us-ascii?Q?6Ld6UnQNt+UdeuvRP6vtZ66UjSkhRSnCucMIWjdbnxgXp+fGgu4MaP28jHa5?=
 =?us-ascii?Q?Xur/COcOgDMCswBQZsFJU0sJAFWVlnKvMIygSGEsWDqAw3Xr2wPIkCcK4Y/D?=
 =?us-ascii?Q?6QRUB3BPRKnFXfTA4udGZbRjbmWZe3P8t9VcahU74BeYz9kHj7W7rx0tr3VT?=
 =?us-ascii?Q?1P+UuyHJPhAswtzqbU9IOPqvUCDOzSSX33B8xtleNZMZ8HUmtsePEapjrAiZ?=
 =?us-ascii?Q?Oj1GzUaoomt6RiLa8rpvzwSLG8u1eOMmdW1RHZo3JHMHgV4hIwl85E45uHA8?=
 =?us-ascii?Q?Np64eMPz9tKtshPcigNLdmK+dPACjc9q1MzdxQy1ADBzgc3SdfXvBZZWg/yE?=
 =?us-ascii?Q?Y6heRBs4jv7b5iBrKR832K/K6mntUD1v7Ey2XcsKEmEDZ26U94loELN+AQ5e?=
 =?us-ascii?Q?TRWRSJ63kuKGkb4HFzTJFJNRnKzHW1rC5XP+3VOcZWGZMMMiLkicefgNnkC6?=
 =?us-ascii?Q?UJOvc8gQb6cOjkgg/4/w0F3GdMM0RvWtSvRS4b+xSiRHxztX3QYkjI5aLAzR?=
 =?us-ascii?Q?XQ+AH5XVZkDdHGJqt1bfFcnJ05KVeKgi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 21:16:53.6254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fbfcb7-9ed6-4b88-6d44-08dcbd6f9619
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126

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

[Yazen: Add last commit message paragraph.]

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
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
1. Move wrapper changes required in mce_read_aux() and mce_no_way_out()
to this patch from the second patch.
2. Fix SoB chain to properly reflect the patch path.

Changes in v4:
1. Rebase on of tip/master to avoid merge conflicts.
2. Resolve kernel test robot's warning on the use of memset() in
do_machine_check().
---
 arch/x86/include/asm/mce.h              |  12 +-
 arch/x86/kernel/cpu/mce/amd.c           |  27 ++--
 arch/x86/kernel/cpu/mce/apei.c          |  45 +++---
 arch/x86/kernel/cpu/mce/core.c          | 198 +++++++++++++-----------
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
 include/trace/events/mce.h              |  42 ++---
 20 files changed, 208 insertions(+), 168 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3b9970117a0f..3c86b838b541 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -187,6 +187,14 @@ enum mce_notifier_prios {
 	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
 };
 
+/**
+ * struct mce_hw_err - Hardware Error Record.
+ * @m:		Machine Check record.
+ */
+struct mce_hw_err {
+	struct mce m;
+};
+
 struct notifier_block;
 extern void mce_register_decode_chain(struct notifier_block *nb);
 extern void mce_unregister_decode_chain(struct notifier_block *nb);
@@ -221,8 +229,8 @@ static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 					     u64 lapic_id) { return -EINVAL; }
 #endif
 
-void mce_prep_record(struct mce *m);
-void mce_log(struct mce *m);
+void mce_prep_record(struct mce_hw_err *err);
+void mce_log(struct mce_hw_err *err);
 DECLARE_PER_CPU(struct device *, mce_device);
 
 /* Maximum number of MCA banks per CPU. */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 14bf8c232e45..5b4d266500b2 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -778,29 +778,30 @@ bool amd_mce_usable_address(struct mce *m)
 
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
-	struct mce m;
+	struct mce_hw_err err;
+	struct mce *m = &err.m;
 
-	mce_prep_record(&m);
+	mce_prep_record(&err);
 
-	m.status = status;
-	m.misc   = misc;
-	m.bank   = bank;
-	m.tsc	 = rdtsc();
+	m->status = status;
+	m->misc   = misc;
+	m->bank   = bank;
+	m->tsc	 = rdtsc();
 
-	if (m.status & MCI_STATUS_ADDRV) {
-		m.addr = addr;
+	if (m->status & MCI_STATUS_ADDRV) {
+		m->addr = addr;
 
-		smca_extract_err_addr(&m);
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
index 3885fe05f01e..7f582b4ca1ca 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -28,7 +28,8 @@
 
 void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 {
-	struct mce m;
+	struct mce_hw_err err;
+	struct mce *m;
 	int lsb;
 
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
@@ -44,22 +45,23 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 	else
 		lsb = PAGE_SHIFT;
 
-	mce_prep_record(&m);
-	m.bank = -1;
+	mce_prep_record(&err);
+	m = &err.m;
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
 
@@ -67,8 +69,9 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
 	bool apicid_found = false;
+	struct mce_hw_err err;
 	unsigned int cpu;
-	struct mce m;
+	struct mce *m;
 
 	if (!boot_cpu_has(X86_FEATURE_SMCA))
 		return -EINVAL;
@@ -108,18 +111,20 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (!apicid_found)
 		return -EINVAL;
 
-	mce_prep_record_common(&m);
-	mce_prep_record_per_cpu(cpu, &m);
+	m = &err.m;
+	memset(&err, 0, sizeof(struct mce_hw_err));
+	mce_prep_record_common(m);
+	mce_prep_record_per_cpu(cpu, m);
 
-	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
-	m.status = *i_mce;
-	m.addr = *(i_mce + 1);
-	m.misc = *(i_mce + 2);
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
index 2a938f429c4d..d9d1af7227ce 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -88,7 +88,7 @@ struct mca_config mca_cfg __read_mostly = {
 	.monarch_timeout = -1
 };
 
-static DEFINE_PER_CPU(struct mce, mces_seen);
+static DEFINE_PER_CPU(struct mce_hw_err, hw_errs_seen);
 static unsigned long mce_need_notify;
 
 /*
@@ -119,8 +119,6 @@ BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 
 void mce_prep_record_common(struct mce *m)
 {
-	memset(m, 0, sizeof(struct mce));
-
 	m->cpuid	= cpuid_eax(1);
 	m->cpuvendor	= boot_cpu_data.x86_vendor;
 	m->mcgcap	= __rdmsr(MSR_IA32_MCG_CAP);
@@ -139,8 +137,11 @@ void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m)
 }
 
 /* Do initial initialization of a struct mce */
-void mce_prep_record(struct mce *m)
+void mce_prep_record(struct mce_hw_err *err)
 {
+	struct mce *m = &err->m;
+
+	memset(err, 0, sizeof(struct mce_hw_err));
 	mce_prep_record_common(m);
 	mce_prep_record_per_cpu(smp_processor_id(), m);
 }
@@ -148,9 +149,9 @@ void mce_prep_record(struct mce *m)
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
@@ -171,8 +172,10 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
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
@@ -214,9 +217,11 @@ static void __print_mce(struct mce *m)
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
@@ -251,7 +256,7 @@ static const char *mce_dump_aux_info(struct mce *m)
 	return NULL;
 }
 
-static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
+static noinstr void mce_panic(const char *msg, struct mce_hw_err *final, char *exp)
 {
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
@@ -282,20 +287,22 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
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
@@ -303,12 +310,12 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
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
 
@@ -323,9 +330,9 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
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
@@ -445,16 +452,18 @@ static noinstr void mce_wrmsrl(u32 msr, u64 v)
  * check into our "mce" struct so that we can use it later to assess
  * the severity of the problem as we read per-bank specific details.
  */
-static noinstr void mce_gather_info(struct mce *m, struct pt_regs *regs)
+static noinstr void mce_gather_info(struct mce_hw_err *err, struct pt_regs *regs)
 {
+	struct mce *m;
 	/*
 	 * Enable instrumentation around mce_prep_record() which calls external
 	 * facilities.
 	 */
 	instrumentation_begin();
-	mce_prep_record(m);
+	mce_prep_record(err);
 	instrumentation_end();
 
+	m = &err->m;
 	m->mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
 	if (regs) {
 		/*
@@ -574,13 +583,13 @@ EXPORT_SYMBOL_GPL(mce_is_correctable);
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
 
@@ -597,7 +606,8 @@ static struct notifier_block early_nb = {
 static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce_hw_err *err = (struct mce_hw_err *)data;
+	struct mce *mce = &err->m;
 	unsigned long pfn;
 
 	if (!mce || !mce_usable_address(mce))
@@ -624,13 +634,13 @@ static struct notifier_block mce_uc_nb = {
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
@@ -644,8 +654,10 @@ static struct notifier_block mce_default_nb = {
 /*
  * Read ADDR and MISC registers.
  */
-static noinstr void mce_read_aux(struct mce *m, int i)
+static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 {
+	struct mce *m = &err->m;
+
 	if (m->status & MCI_STATUS_MISCV)
 		m->misc = mce_rdmsrl(mca_msr_reg(i, MCA_MISC));
 
@@ -692,26 +704,28 @@ DEFINE_PER_CPU(unsigned, mce_poll_count);
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-	struct mce m;
+	struct mce_hw_err err;
+	struct mce *m;
 	int i;
 
 	this_cpu_inc(mce_poll_count);
 
-	mce_gather_info(&m, NULL);
+	mce_gather_info(&err, NULL);
+	m = &err.m;
 
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
@@ -721,17 +735,17 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
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
@@ -741,20 +755,20 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
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
@@ -768,20 +782,20 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (flags & MCP_DONTLOG)
 			goto clear_it;
 
-		mce_read_aux(&m, i);
-		m.severity = mce_severity(&m, NULL, NULL, false);
+		mce_read_aux(&err, i);
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
@@ -905,9 +919,10 @@ static __always_inline void quirk_zen_ifu(int bank, struct mce *m, struct pt_reg
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
  */
-static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
+static __always_inline int mce_no_way_out(struct mce_hw_err *err, char **msg, unsigned long *validp,
 					  struct pt_regs *regs)
 {
+	struct mce *m = &err->m;
 	char *tmp = *msg;
 	int i;
 
@@ -925,7 +940,7 @@ static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned lo
 
 		m->bank = i;
 		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
-			mce_read_aux(m, i);
+			mce_read_aux(err, i);
 			*msg = tmp;
 			return 1;
 		}
@@ -1017,6 +1032,7 @@ static noinstr int mce_timed_out(u64 *t, const char *msg)
 static void mce_reign(void)
 {
 	int cpu;
+	struct mce_hw_err *err = NULL;
 	struct mce *m = NULL;
 	int global_worst = 0;
 	char *msg = NULL;
@@ -1027,11 +1043,13 @@ static void mce_reign(void)
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
 
@@ -1043,7 +1061,7 @@ static void mce_reign(void)
 	if (m && global_worst >= MCE_PANIC_SEVERITY) {
 		/* call mce_severity() to get "msg" for panic */
 		mce_severity(m, NULL, &msg, true);
-		mce_panic("Fatal machine check", m, msg);
+		mce_panic("Fatal machine check", err, msg);
 	}
 
 	/*
@@ -1060,11 +1078,11 @@ static void mce_reign(void)
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
@@ -1268,12 +1286,13 @@ static noinstr bool mce_check_crashing_cpu(void)
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
@@ -1319,7 +1338,7 @@ __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
 		if (severity == MCE_NO_SEVERITY)
 			continue;
 
-		mce_read_aux(m, i);
+		mce_read_aux(err, i);
 
 		/* assuming valid severity level != 0 */
 		m->severity = severity;
@@ -1329,7 +1348,7 @@ __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
 		 * done in #MC context, where instrumentation is disabled.
 		 */
 		instrumentation_begin();
-		mce_log(m);
+		mce_log(err);
 		instrumentation_end();
 
 		if (severity > *worst) {
@@ -1399,8 +1418,9 @@ static void kill_me_never(struct callback_head *cb)
 		set_mce_nospec(pfn);
 }
 
-static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callback_head *))
+static void queue_task_work(struct mce_hw_err *err, char *msg, void (*func)(struct callback_head *))
 {
+	struct mce *m = &err->m;
 	int count = ++current->mce_count;
 
 	/* First call, save all the details */
@@ -1414,11 +1434,12 @@ static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callba
 
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
@@ -1467,8 +1488,10 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	int worst = 0, order, no_way_out, kill_current_task, lmce, taint = 0;
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS) = { 0 };
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS) = { 0 };
-	struct mce m, *final;
+	struct mce_hw_err *final;
+	struct mce_hw_err err;
 	char *msg = NULL;
+	struct mce *m;
 
 	if (unlikely(mce_flags.p5))
 		return pentium_machine_check(regs);
@@ -1506,13 +1529,14 @@ noinstr void do_machine_check(struct pt_regs *regs)
 
 	this_cpu_inc(mce_exception_count);
 
-	mce_gather_info(&m, regs);
-	m.tsc = rdtsc();
+	mce_gather_info(&err, regs);
+	m = &err.m;
+	m->tsc = rdtsc();
 
-	final = this_cpu_ptr(&mces_seen);
-	*final = m;
+	final = this_cpu_ptr(&hw_errs_seen);
+	final->m = *m;
 
-	no_way_out = mce_no_way_out(&m, &msg, valid_banks, regs);
+	no_way_out = mce_no_way_out(&err, &msg, valid_banks, regs);
 
 	barrier();
 
@@ -1521,15 +1545,15 @@ noinstr void do_machine_check(struct pt_regs *regs)
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
@@ -1540,12 +1564,12 @@ noinstr void do_machine_check(struct pt_regs *regs)
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
@@ -1560,7 +1584,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 				no_way_out = worst >= MCE_PANIC_SEVERITY;
 
 			if (no_way_out)
-				mce_panic("Fatal machine check on current CPU", &m, msg);
+				mce_panic("Fatal machine check on current CPU", &err, msg);
 		}
 	} else {
 		/*
@@ -1572,8 +1596,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 * make sure we have the right "msg".
 		 */
 		if (worst >= MCE_PANIC_SEVERITY) {
-			mce_severity(&m, regs, &msg, true);
-			mce_panic("Local fatal machine check!", &m, msg);
+			mce_severity(m, regs, &msg, true);
+			mce_panic("Local fatal machine check!", &err, msg);
 		}
 	}
 
@@ -1591,16 +1615,16 @@ noinstr void do_machine_check(struct pt_regs *regs)
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
@@ -1612,8 +1636,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 * not occur there. Mark the page as poisoned so it won't
 		 * be added to free list when the guest is terminated.
 		 */
-		if (mce_usable_address(&m)) {
-			struct page *p = pfn_to_online_page(m.addr >> PAGE_SHIFT);
+		if (mce_usable_address(m)) {
+			struct page *p = pfn_to_online_page(m->addr >> PAGE_SHIFT);
 
 			if (p)
 				SetPageHWPoison(p);
@@ -1628,13 +1652,13 @@ noinstr void do_machine_check(struct pt_regs *regs)
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
index 43c7f3b71df5..84f810598231 100644
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
index 0fe75eed8973..d73e9f0600ee 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -919,7 +919,7 @@ static int ecclog_nmi_handler(unsigned int cmd, struct pt_regs *regs)
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
index f93f2f2b1cf2..a3008f6eb2b1 100644
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
index e5c05a876947..4dadb9975b23 100644
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
index 8d18099fd528..21f9d2c22c81 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -644,7 +644,7 @@ static bool skx_error_in_mem(const struct mce *m)
 int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
-	struct mce *mce = (struct mce *)data;
+	struct mce *mce = &((struct mce_hw_err *)data)->m;
 	struct decoded_addr res;
 	struct mem_ctl_info *mci;
 	char *type;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d0307c55da50..fea085ef663e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4158,7 +4158,7 @@ static struct amdgpu_device *find_adev(uint32_t node_id)
 static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 				    unsigned long val, void *data)
 {
-	struct mce *m = (struct mce *)data;
+	struct mce *m = &((struct mce_hw_err *)data)->m;
 	struct amdgpu_device *adev = NULL;
 	uint32_t gpu_id = 0;
 	uint32_t umc_inst = 0, ch_inst = 0;
diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 90de737fbc90..78dd4b192992 100644
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


