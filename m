Return-Path: <linux-edac+bounces-2189-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2729AB71B
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 21:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0461F24125
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 19:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E071CBEA9;
	Tue, 22 Oct 2024 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qztKvnon"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E571CBEA4;
	Tue, 22 Oct 2024 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626177; cv=fail; b=cxt7OJdxOROGgglZ0LSgbjxNIweKqVwSgFy3o61pZC5QA3qNJFcvWDMmDDjyC+M3hC5cw7HyDNXVTzgiTbGUwnHl7iSR2hlgxqmjq1TpUxjX9Q5gYE/EpasYHNnmr3LuddYRqehLTskg3MrqSqd7SArQV8c5W2eMsJtMyp+Swps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626177; c=relaxed/simple;
	bh=kOGx/P6fumAv39z/vhTTgWrpfFufoTn32JK5PAa+Xwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugk2S1JbUGDrekCLMlKtiR53nil4rRSZMZMzzcJQcVKqX+HRI/Zx2gbNCOqDB8HS2wmtNGT8sQxXPdnTw2/7G3QB/60OtR+Pr5C/asq9w7PKY6lffddiKTUwuRzUzgYc60xpRk+womwzjXjbFvdXud9iD61IvWon3ngmTErcuJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qztKvnon; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDlCQNWpH/VyYVdLWeKr09OLqzx3wPTr4cv6Pwp/1F2YryFyASIJrCulVwu/LQdZbZXMAsCTIftUuyEIqtU6Tqnhqm865Xl+yugtgY8fZkxI7h4kiFN6v+7rD98dNySJBcHT98ThxgSAydEX3GkCLr90JU1eqCO/856TA1t1VbFdZFkWC8rSNblOfASfxOcjAtzDf1p+tBnoyi8fAeVhGeyk8unZFEEkPmPT7RfPF6vLuH9eI3+sNcSaQEPSVqrrhRrjl3tXgeVJEh5h89HUR1i3l8UJWhxb1pEEX/Vnw0ZM1Mxy002SN/+ORqKRRwRyKWqb9VF6cqM1CaK3z0Tspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzS2wsJYFy7vV+z0Y4DrnCfvDjnqJSNWkFEcQol+/V8=;
 b=kzHtPzCY/nad/zCqoZ2wTAEFS1xol7CWhO45wbPUFvVfGvvmW+4SYvpvsCkEreIMooSYYhO2STcQoWFRALJjAY6JYCodI/K1qkKN9DPG1ZRFYUK2MY7RZ+zJTWxqhdQRU2ri0Iz3jEWj79CMDVaviqlz6s6lmFnSpCLK1+Koq2WdUHpTP7+IMlt22VekqOiiWR1KBRMnvBnkg/rlae+/yQ9zOjPCijA5da7OUBD22FSXHnNPYFkIq0s0Tnwscem+Eryf9upbu9fVbO0xOy9Lov5NUzAapvzxuGgiZR1B/bmvzLK6SZ1KiVjNdVh2j/IGF5b8rrgR9ra/keInaFAOmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzS2wsJYFy7vV+z0Y4DrnCfvDjnqJSNWkFEcQol+/V8=;
 b=qztKvnonHvgu1wK4oT56C+3DBxzSj6Gd9LF7/78Ohq9PoT066u4Y3Tui2niQmvKybQw5lja2wxLmjQcrlKJTQua6AS49JlkO16a9UY80UEHsQDaVVe3nmpTKedIumXTCrsIEAHoNOpaD7S6gb5DNc33RNnakHiJeANtmju1EkEA=
Received: from BYAPR02CA0028.namprd02.prod.outlook.com (2603:10b6:a02:ee::41)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Tue, 22 Oct
 2024 19:42:50 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::23) by BYAPR02CA0028.outlook.office365.com
 (2603:10b6:a02:ee::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 19:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 19:42:49 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 14:42:48 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<qiuxu.zhuo@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadhut.naik@amd.com>
Subject: [PATCH v7 3/5] x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers
Date: Tue, 22 Oct 2024 19:36:29 +0000
Message-ID: <20241022194158.110073-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022194158.110073-1-avadhut.naik@amd.com>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 8415452b-5876-4c08-fb89-08dcf2d1b63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7cwxsVYN4M0/V55dq2fbg+sstcRydK1Cq8GNmTKlTLZd06ho3NixnIcwwxYs?=
 =?us-ascii?Q?yCdhurl+imJty+bmwZ1KS4051UVYKoXRCpcxLSCwYVYsiR3CmSOlVkxmvnKu?=
 =?us-ascii?Q?nhtqzKEoJNt6/bZ6Txj0L2GS4p8nGnsTo9drGzXgWU6/CHxNVtSqGMRECYGJ?=
 =?us-ascii?Q?1kIeixSvRsQWnOdOlUDLarLVud6JM5fdbtYNbFG2KBWN86wAiwJgcYGH8qnt?=
 =?us-ascii?Q?wuGeLSWfYItPLS5oHfnzm0TsdhsswXW/hYQMYRQ0QMIPY7ND0NKp5O2Xv5AN?=
 =?us-ascii?Q?/v+IdMeKhjFN1tRzYOFp9t4jrr/NqMZaO4kkCOD94Lekqh/ps3cqbhLGRX+5?=
 =?us-ascii?Q?50X0vbFsHoQI8/6en8/MICSpSPVaTRjRbuaszgb0sH3ne572rqA87cJNI+m+?=
 =?us-ascii?Q?8Z3eFhgXpCFOacDnEDDwh4tuiV5X25VqGwJIBa03Os8OHGmN2RT9Kfw9sXIu?=
 =?us-ascii?Q?hQG/GtS6iClGuGH/mMHxeDA+Q4cuTyEVn68W4BLGlKOsKCZV4rbqlsZ7QVrh?=
 =?us-ascii?Q?zrzSGLnIEJvnexHVOexWXCgXQRmIBjhYTf7TW2SVikN/2m/hBmXcfXo78umt?=
 =?us-ascii?Q?1rcMH1vSUtpTidmQOEOxNrvxq5dpzaM1xcUG9PC+gVQNdLsUQkvFaR2NSECS?=
 =?us-ascii?Q?JIta1BQJLGea1MugRui2QIce7zhW/o+pfWxTJ2xdC8siW8gZiZgW4NMayZLw?=
 =?us-ascii?Q?B+7QMisJ7BOHWXDzrChfZUH3adxS6pqGjgbCvNPEnya3cYmvTY15uJRC+okW?=
 =?us-ascii?Q?ZYNcd5eiW+/E5SxLWhtCs+0QPTtABiKS0ABuJfb/9iwRNPGKzHeoDR1wC5BH?=
 =?us-ascii?Q?q7n++XmUMiNO9dy7PZEnXo+v4R40CdtlIXVdvZgZkV+Qy3gpwDQTD9Qkb6G4?=
 =?us-ascii?Q?2ZIgy9V8SbVL7OPNlChTvO+IW9UnlO/zgY2gRa7mlCxICnWVouoWzgPIrDhp?=
 =?us-ascii?Q?yPgqcpPcDHbQ7nBsLfO7O8r2h11ZkdzNPkqfjsmm9TLmDth929w+azwyaFFV?=
 =?us-ascii?Q?eESLdNXFrEFME4lq6U/nySM4VFaeCNE9QzySFcR31G8u0HBSCoubAPL1v8EK?=
 =?us-ascii?Q?7nqIJzCTkuwCf3Tr65TZw/yx0oAaL2ClQVT8PzA7Vx+XX92Mrdk123ekA3p5?=
 =?us-ascii?Q?Jfmibs2JBqOwq033iPUMCjVQavlgR7esRPeR2SIBl/E6KpB3mazJ/qJX03tp?=
 =?us-ascii?Q?kl368ROkr/7gyJfbOYigqaR0oY8CaLKdVTafDJG9/7Cfzirpeopc2WFPMexm?=
 =?us-ascii?Q?NcQHt/fQgGMTSyuPOSqkJmqJ6B0jNvyY60mfhGelLVpcZvMjZnoDtTervjSX?=
 =?us-ascii?Q?uuXDXz0Uq9XsIgh7rcyYNcM81Kw3haeuu2gszbgwuDy9/Wr5c1Su5sL8O2Sf?=
 =?us-ascii?Q?NU1pz7XHxUohAo8Mg4UJdKEAjbVA2O7Qe2Db8kwLgW3ypJq7vn9qnJvHvgxB?=
 =?us-ascii?Q?9zXIYss959Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:42:49.7741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8415452b-5876-4c08-fb89-08dcf2d1b63c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136

Starting with Zen4, AMD's Scalable MCA systems incorporate two new
registers: MCA_SYND1 and MCA_SYND2.

These registers will include supplemental error information in addition
to the existing MCA_SYND register. The data within these registers is
considered valid if MCA_STATUS[SyndV] is set.

Userspace error decoding tools like the rasdaemon gather related hardware
error information through the tracepoints. As such, these two registers
should be exported through the mce_record tracepoint so that tools like
rasdaemon can parse them and output the supplemental error information
like FRU Text contained in them.

[Yazen: Drop Yazen's Co-developed-by tag and moved SoB tag.]

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
from this patch to the first patch.
2. Add comments to explain the new wrapper's purpose.
3. Modify commit message per feedback received.
4. Fix SoB chain to properly reflect the patch path.

Changes in v4:
1. Rebase on top of tip/master to avoid merge conflicts.

Changes in v5:
1. Remove "len" field since the length of a dynamic array can be fetched
from its metadata.
2. Substitute __print_array() with __print_dynamic_array().

Changes in v6:
1. Rebase on top of tip/master.
2. Use the newly introduced to_mce_hw_err macro in amd_decode_mce().

Changes in v7:
1. Rebase on top of tip/master.
2. Change second parameter of __print_dynamic_array from 8 to sizeof(u8)
to ensure that the dynamic array is parsed using a u8 pointer instead of
u64 pointer.
---
 arch/x86/include/asm/mce.h      | 22 ++++++++++++++++++++++
 arch/x86/include/uapi/asm/mce.h |  3 ++-
 arch/x86/kernel/cpu/mce/amd.c   |  5 ++++-
 arch/x86/kernel/cpu/mce/core.c  |  9 ++++++++-
 drivers/edac/mce_amd.c          |  8 ++++++--
 include/trace/events/mce.h      |  7 +++++--
 6 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4e45f45673a3..c2466b20fe79 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -122,6 +122,9 @@
 #define MSR_AMD64_SMCA_MC0_DESTAT	0xc0002008
 #define MSR_AMD64_SMCA_MC0_DEADDR	0xc0002009
 #define MSR_AMD64_SMCA_MC0_MISC1	0xc000200a
+/* Registers MISC2 to MISC4 are at offsets B to D. */
+#define MSR_AMD64_SMCA_MC0_SYND1	0xc000200e
+#define MSR_AMD64_SMCA_MC0_SYND2	0xc000200f
 #define MSR_AMD64_SMCA_MCx_CTL(x)	(MSR_AMD64_SMCA_MC0_CTL + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_STATUS(x)	(MSR_AMD64_SMCA_MC0_STATUS + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_ADDR(x)	(MSR_AMD64_SMCA_MC0_ADDR + 0x10*(x))
@@ -132,6 +135,8 @@
 #define MSR_AMD64_SMCA_MCx_DESTAT(x)	(MSR_AMD64_SMCA_MC0_DESTAT + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_DEADDR(x)	(MSR_AMD64_SMCA_MC0_DEADDR + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_MISCy(x, y)	((MSR_AMD64_SMCA_MC0_MISC1 + y) + (0x10*(x)))
+#define MSR_AMD64_SMCA_MCx_SYND1(x)	(MSR_AMD64_SMCA_MC0_SYND1 + 0x10*(x))
+#define MSR_AMD64_SMCA_MCx_SYND2(x)	(MSR_AMD64_SMCA_MC0_SYND2 + 0x10*(x))
 
 #define XEC(x, mask)			(((x) >> 16) & mask)
 
@@ -190,9 +195,26 @@ enum mce_notifier_prios {
 /**
  * struct mce_hw_err - Hardware Error Record.
  * @m:		Machine Check record.
+ * @vendor:	Vendor-specific error information.
+ *
+ * Vendor-specific fields should not be added to struct mce.
+ * Instead, vendors should export their vendor-specific data
+ * through their structure in the vendor union below.
+ *
+ * AMD's vendor data is parsed by error decoding tools for
+ * supplemental error information. Thus, current offsets of
+ * existing fields must be maintained.
+ * Only add new fields at the end of AMD's vendor structure.
  */
 struct mce_hw_err {
 	struct mce m;
+
+	union vendor_info {
+		struct {
+			u64 synd1;		/* MCA_SYND1 MSR */
+			u64 synd2;		/* MCA_SYND2 MSR */
+		} amd;
+	} vendor;
 };
 
 #define	to_mce_hw_err(mce) container_of(mce, struct mce_hw_err, m)
diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index db9adc081c5a..cb6b48a7c22b 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -8,7 +8,8 @@
 /*
  * Fields are zero when not available. Also, this struct is shared with
  * userspace mcelog and thus must keep existing fields at current offsets.
- * Only add new fields to the end of the structure
+ * Only add new, shared fields to the end of the structure.
+ * Do not add vendor-specific fields.
  */
 struct mce {
 	__u64 status;		/* Bank's MCi_STATUS MSR */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5b4d266500b2..6ca80fff1fea 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -797,8 +797,11 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	if (mce_flags.smca) {
 		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
 
-		if (m->status & MCI_STATUS_SYNDV)
+		if (m->status & MCI_STATUS_SYNDV) {
 			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
+			rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vendor.amd.synd1);
+			rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vendor.amd.synd2);
+		}
 	}
 
 	mce_log(&err);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 3611366d56b7..fca23fe16abe 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -202,6 +202,10 @@ static void __print_mce(struct mce_hw_err *err)
 	if (mce_flags.smca) {
 		if (m->synd)
 			pr_cont("SYND %llx ", m->synd);
+		if (err->vendor.amd.synd1)
+			pr_cont("SYND1 %llx ", err->vendor.amd.synd1);
+		if (err->vendor.amd.synd2)
+			pr_cont("SYND2 %llx ", err->vendor.amd.synd2);
 		if (m->ipid)
 			pr_cont("IPID %llx ", m->ipid);
 	}
@@ -678,8 +682,11 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
 
-		if (m->status & MCI_STATUS_SYNDV)
+		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
+			err->vendor.amd.synd1 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(i));
+			err->vendor.amd.synd2 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(i));
+		}
 	}
 }
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 8130c3dc64da..194d9fd47d20 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -793,6 +793,7 @@ static int
 amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 {
 	struct mce *m = (struct mce *)data;
+	struct mce_hw_err *err = to_mce_hw_err(m);
 	unsigned int fam = x86_family(m->cpuid);
 	int ecc;
 
@@ -850,8 +851,11 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		pr_emerg(HW_ERR "IPID: 0x%016llx", m->ipid);
 
-		if (m->status & MCI_STATUS_SYNDV)
-			pr_cont(", Syndrome: 0x%016llx", m->synd);
+		if (m->status & MCI_STATUS_SYNDV) {
+			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
+			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
+				 err->vendor.amd.synd1, err->vendor.amd.synd2);
+		}
 
 		pr_cont("\n");
 
diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 65aba1afcd07..c1c50df9ecfd 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -43,6 +43,7 @@ TRACE_EVENT(mce_record,
 		__field(	u8,		bank		)
 		__field(	u8,		cpuvendor	)
 		__field(	u32,		microcode	)
+		__dynamic_array(u8, v_data, sizeof(err->vendor))
 	),
 
 	TP_fast_assign(
@@ -65,9 +66,10 @@ TRACE_EVENT(mce_record,
 		__entry->bank		= err->m.bank;
 		__entry->cpuvendor	= err->m.cpuvendor;
 		__entry->microcode	= err->m.microcode;
+		memcpy(__get_dynamic_array(v_data), &err->vendor, sizeof(err->vendor));
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016llx, IPID: %016llx, ADDR: %016llx, MISC: %016llx, SYND: %016llx, RIP: %02x:<%016llx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x, vendor data: %s",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -83,7 +85,8 @@ TRACE_EVENT(mce_record,
 		__entry->walltime,
 		__entry->socketid,
 		__entry->apicid,
-		__entry->microcode)
+		__entry->microcode,
+		__print_dynamic_array(v_data, sizeof(u8)))
 );
 
 #endif /* _TRACE_MCE_H */
-- 
2.43.0


