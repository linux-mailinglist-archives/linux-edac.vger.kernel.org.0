Return-Path: <linux-edac+bounces-1950-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC00498C535
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2024 20:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A52B21044
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2024 18:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A830D1CCB31;
	Tue,  1 Oct 2024 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OkVE05Xy"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFB81CC8B0;
	Tue,  1 Oct 2024 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806651; cv=fail; b=uVE3SCZ4DEKS+Z2R5u98QaIUvjiS5HrAZMqsz00zGv/aSWsNSsjq0iAV9vznHf0pis9kVC+cfaDwcAN6jheTlK/8QwjOLidAYfC5ElOhDolKg5O1+yXq7b2eUa0LaUlBAvNPVdqUuwIWGYe2ae5XNlW4HarPsb7vnSm9xnPMUFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806651; c=relaxed/simple;
	bh=TpSviuczBvYTXO1QbOn7f8lKit40jMVgUfDE1L3xfpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tefG2NpxOfkU49B9+/CeqUgq4JNIv5JwimRBpckfUBlABx6RtFUNnFa+vssokh4PmSWNTUaZ/++KIWnsbPEny1nYzZuHrLhTnhXPvKUay+zFtV3Fg+W9XPsGY3mAcooJnv56nZCUJjY84BDDmNApx5S7dm2CS1APGRl0xtMjLzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OkVE05Xy; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2LjtSWQN/B5VoHu58wkjiR6Tv5SKQUWuJj8r67dGdAuwY3iuKI53T61gkxdxYnYrjXYKj7snBj0zCn41r7LRwl1031QY3C0UcC0jJGRnA4Wf00Ubhkc05XUkw72Ef+me1o+/HJBPOtra1FnQCRCvQjvZFaxRVGqqVsZ/8IZmzgey/2e0o6ZnTyTJAl9IQskpz6RyE1OljsOFcHmNKT8+q9gF58v2gPbCNnG88hQ67rzfASYm+5v0IlZHI2d4PJGWH154Dnb//7DXAPXE5xGkNdL1LgOPLv+ndhIWvLLnAlyeUtbymxaKXE8/IQ47J0eepcQyd1EW0c/ZT/8tB3KdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHWz9JuWWYaFTmZ6SsL3bOWKUkgVWzmIDtqiFB3p32E=;
 b=gtjgl77+evrR83pQ38pzVD55T7rAHnrFSVFo0OZ5ABCt2ljw8GJobTKqpjh2uL3MxQxIUegQyXqJb7G0fryNayH3WkfOtoTApFEJQfCiRCdFki+HzSDMoPaGf4xJDecb6DeAqVkzpKfJ+UMmMvgGphM/Cy81dWkdw/bQVx33x5vPvP3G66u9fpPLmbZ5Xl39T8rokKgTAtTDFZsgWXvcAteIyYdCyWtxqwQsTepTvyX6VJJ7os8CntSq0+TMevi+/+Tr9/c36qA/pt1DT+0Q0ocfrdxLEKfIew+v3p8bAdGy36wQgYftuQrJJ6dCHfqa2TNUt8jnNmn9EPK3v3DpGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHWz9JuWWYaFTmZ6SsL3bOWKUkgVWzmIDtqiFB3p32E=;
 b=OkVE05Xy3Z6aO6fZfit3Og1wGP1ojCuXVMfv2sfNI/aTYrnHghXhVsG388T12jdunx71Oeo7Et675O20TLEQVi8KZ6sJo6PgJYoZsrHTePpGSEHXWFtTjvfm16qGPy1Uq5WkCNGLNQ3KjNrIlnkmd9EEjBSCpZgvJm++0Khf04E=
Received: from BL1PR13CA0310.namprd13.prod.outlook.com (2603:10b6:208:2c1::15)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.15; Tue, 1 Oct 2024 18:17:23 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::1b) by BL1PR13CA0310.outlook.office365.com
 (2603:10b6:208:2c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 18:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 18:17:22 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 13:17:21 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v5 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
Date: Tue, 1 Oct 2024 18:12:29 +0000
Message-ID: <20241001181617.604573-6-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241001181617.604573-1-avadhut.naik@amd.com>
References: <20241001181617.604573-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8c53e6-e37f-4c73-abff-08dce2454b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DulD4nzlYJJIkqjpEXNE9q7MPKLThUS2lyfZKDfwn2n8g4ZtBDvnl8F2FoAi?=
 =?us-ascii?Q?fO8GHTsHUseOyp4W4CASDnhAheP+GVcdV/Sshr2TJqYIagjxKPH48BJeXMne?=
 =?us-ascii?Q?ILomscT+aPOUrjX4hVQ2TeYF+r2Zqt8CfGJI3UxRwRfcrTOO5AYIGJuW6xKw?=
 =?us-ascii?Q?bDn3BNdEzq4aK5V1xMF45zEn2OtF2b7RxxGe4p8S0ZFhUf94ixQxQ0MG1d5X?=
 =?us-ascii?Q?H833P2idov+LqEIl3XkMmV1bkevXUeULQhgc89MeGGSvKcqQQq2pKJyYZgKy?=
 =?us-ascii?Q?1qJL6xaMVp2rH3MP9Z0KmHp/Hje03mp2t39ionkyYVCdihVE2ftM98QjaRRB?=
 =?us-ascii?Q?AaUZb2ru6gfFFjR4nL81+4WMPGshbpwf0iGAT0PBAVeG+BIQwLjPK32Niihz?=
 =?us-ascii?Q?MjS5tq/O8QOa0zZPkz1texJc5l4r9jH9JcUiltN+pKcRHOs8eobZboqeuB+M?=
 =?us-ascii?Q?VR2FI01iPkq4t/4L1MP6dPJwFdHs3yT+XMHjxLpqiV7iy4s4WAFk6WKaGZtx?=
 =?us-ascii?Q?rTcX2zBJjLTtMVV+V91vRHPrIQ3bBnOl0FTfs35oGzgZFKdu9cWxJPSE5OLU?=
 =?us-ascii?Q?xNSHx3NPgWaNYfTVtYDGsW2fWBUJSyIBCGjJ0rjLe1OB6pyZPVf8d3N/ic0X?=
 =?us-ascii?Q?40pnXfFnNYQI6YZSjZv1g3xfQROC6y+ri+AQfV8FyhUaaDuxgG1QFKQJaOe1?=
 =?us-ascii?Q?wZzasqhFy7imyt3QkaDt0ZWfDwwMGX2InCULSNTdRmpUwU4okLaAbNhDYcsK?=
 =?us-ascii?Q?Gi6HN21eOAdV78+6q8++f7AfJKqRQTQvuRMmp23YoSYaCLtGzN4CICmsfFtf?=
 =?us-ascii?Q?5qOWk0yBrmeSIAWR6iU8Uw0Qag+EfP1ydHbo9yROBlHsG6geis9iaCwCempb?=
 =?us-ascii?Q?6sQSZQ/+47ZzwvmB/SfBb0+9bk2+Fts07pzwQ67YzoFK/KXt2RCYS2fkH0X7?=
 =?us-ascii?Q?nGXh8yww50NzWvn51mRDAYBKOnhowehtohSQvafZl4OKYe66crAOoWkWeP0R?=
 =?us-ascii?Q?nSDPjD5wl49qPquck2QgMCjDpnW7WhY7udgrqbO3JwTxIL5GFwNqr8r8iUAf?=
 =?us-ascii?Q?u7868palrRTGMdUWpzYD9J6U+PnRb9vVLHc7/y9tfgZduiT7gWKIPXtdl/ln?=
 =?us-ascii?Q?8eQibWN0tL068WsFjTBelLQJidjroLPLs94F1vqYvjZvG5RvrDXcdDH/xoyF?=
 =?us-ascii?Q?kS2d6Pfr4lU+dFTFxaPlmhds9RehVh7A0TzL862RRqmz0WjhxkNJ5iS0CYvA?=
 =?us-ascii?Q?Irnyf9MHN8qUzwm4Qytl1KKrqxkzdmQ77sZnBM3jTBd/aomERHWYwSWeci/Q?=
 =?us-ascii?Q?8GldLLbK2D9Z1CSL3UfL6DiIKx+9fznf3otDFHQObfS3gBOXtJ2wieIUrEaj?=
 =?us-ascii?Q?k3AoPb6Vp7l3YWHLeEPZq9nVkvIn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:17:22.6855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8c53e6-e37f-4c73-abff-08dce2454b88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272

From: Yazen Ghannam <yazen.ghannam@amd.com>

A new "FRU Text in MCA" feature is defined where the Field Replaceable
Unit (FRU) Text for a device is represented by a string in the new
MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).

The FRU Text is populated dynamically for each individual error state
(MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
covers multiple devices, for example, a Unified Memory Controller (UMC)
bank that manages two DIMMs.

Since MCA_CONFIG[9] is instrumental in decoding FRU Text, it has to be
exported through the mce_record tracepoint so that userspace tools like
the rasdaemon can determine if FRU Text has been reported through the
MCA_SYND1 and MCA_SYND2 registers and output it.

[Yazen: Add Avadhut as co-developer for wrapper changes.]

Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
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
1. Modify commit message per feedback provided.
2. Remove call to memset() for the string frutext. Instead, just ensure
that it is NULL terminated.
2. Fix SoB chain to properly reflect the patch path.

Changes in v4:
1. Rebase on top of tip/master to avoid merge conflicts.

Changes in v5:
1. No changes except rebasing on top of tip/master.
---
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/amd.c  |  1 +
 arch/x86/kernel/cpu/mce/apei.c |  2 ++
 arch/x86/kernel/cpu/mce/core.c |  3 +++
 drivers/edac/mce_amd.c         | 21 ++++++++++++++-------
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index a977c10875a0..7d7e673de74e 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -61,6 +61,7 @@
  *  - TCC bit is present in MCx_STATUS.
  */
 #define MCI_CONFIG_MCAX		0x1
+#define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
 #define MCI_IPID_MCATYPE	0xFFFF0000
 #define MCI_IPID_HWID		0xFFF
 
@@ -213,6 +214,7 @@ struct mce_hw_err {
 		struct {
 			u64 synd1;		/* MCA_SYND1 MSR */
 			u64 synd2;		/* MCA_SYND2 MSR */
+			u64 config;		/* MCA_CONFIG MSR */
 		} amd;
 	} vendor;
 };
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6ca80fff1fea..65ace034af08 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -796,6 +796,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 
 	if (mce_flags.smca) {
 		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
+		rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), err.vendor.amd.config);
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 0a89947e47bc..19a1c72fc2bf 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -155,6 +155,8 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 		fallthrough;
 	/* MCA_CONFIG */
 	case 4:
+		err.vendor.amd.config = *(i_mce + 3);
+		fallthrough;
 	/* MCA_MISC0 */
 	case 3:
 		m->misc = *(i_mce + 2);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 280d538dc13b..5a5dce540677 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -208,6 +208,8 @@ static void __print_mce(struct mce_hw_err *err)
 			pr_cont("SYND2 %llx ", err->vendor.amd.synd2);
 		if (m->ipid)
 			pr_cont("IPID %llx ", m->ipid);
+		if (err->vendor.amd.config)
+			pr_cont("CONFIG %llx ", err->vendor.amd.config);
 	}
 
 	pr_cont("\n");
@@ -682,6 +684,7 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
+		err->vendor.amd.config = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(i));
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index aea68999c849..b32dfe329d7e 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -795,6 +795,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	struct mce_hw_err *err = (struct mce_hw_err *)data;
 	struct mce *m = &err->m;
 	unsigned int fam = x86_family(m->cpuid);
+	u64 mca_config = err->vendor.amd.config;
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
-				 err->vendor.amd.synd1, err->vendor.amd.synd2);
+			if (mca_config & MCI_CONFIG_FRUTEXT) {
+				char frutext[17];
+
+				frutext[16] = '\0';
+				memcpy(&frutext[0], &err->vendor.amd.synd1, 8);
+				memcpy(&frutext[8], &err->vendor.amd.synd2, 8);
+
+				pr_emerg(HW_ERR "FRU Text: %s", frutext);
+			} else {
+				pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
+					 err->vendor.amd.synd1, err->vendor.amd.synd2);
+			}
 		}
 
 		pr_cont("\n");
-- 
2.43.0


