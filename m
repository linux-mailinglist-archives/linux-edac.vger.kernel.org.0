Return-Path: <linux-edac+bounces-2191-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E499AB720
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 21:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDE1B22E94
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 19:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DF21CC17F;
	Tue, 22 Oct 2024 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2VxjiXQj"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F61CBE80;
	Tue, 22 Oct 2024 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626200; cv=fail; b=XZ5iUn+3Rj1lz67uyr/myx6IwoOCnCx3VrFQQgj/sMOFDGI/b0MX+wY8JhQlEgZCndO8F5jlB5WAdyYH4RUzoPKxnmWkXY/hT0SaJ4obwB2OIhSkmZW9tvnfsyFBaYBz+Xa+eE5Z/hHxdM9RwPIyf72GODX0xHo4J4WV4NYsOwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626200; c=relaxed/simple;
	bh=2ZBtsX452qXOV1qcBEsddueXdutnZWqOfLHgxDo9yOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzGUsZE65LRsUz68cgkR9hpjT2Neu8MdyvyEao56+do7Luw8iEOXH2aDwF7YEJXdUDQfrunv5mslXWivKJwiz4InimIFMKzW0sWOss2ZZvdPKOuWrlKFhRwSrMNRwyeKQ+CaTXskzUxvTJb5v1V1fUddhjeFEsNVMcHDtfkxwUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2VxjiXQj; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7v7qAgiZoXyUpHTSUNLxfQMo3pKaLNvHaeFP2MJVw9szHZioRSUr4Lj4ZVPLckz8eSRosuREUSuoqsjNTC68iInbIuRBO/+OSc0zR7R0kViSJ9X2NsbZiXv9nLbD5A4sSydz9J0kLZPJENatkeribITOyNEFw9gyeCiNXK3zM5zzSxki+b1nOT77P/xKtfb7PaG/9vglBtfZAPsIOjgojjSSaL35/XnJ3HvyqXWEP2IsGovPKvbOwvVieDIW6fEOYJSwMrRJxaIi8R8NItVvinBS59J85wm0k6QXtURFzz5Y3GDnX3CFmLOMrD1bkBkeA8vJQqRN+gGPgDrBbxw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DI5mcyNskl+zc88dbcUYR8Fqtb3IS5MFUcEslXFrsEg=;
 b=NIhAwfL4gHHbpDUq6oNCGOkWh4/DJGRth20gDUrqW5YxC+0clhezVhk4JVWcc6ZDEyf0WtApHVbucicCuhWSf2frELejLYsWIRrOFoJSDX8Fh14hlenlXf+wlEGFW6w6UWEy3oH+667ry3dHr9IBjZEaITCSMK1XKkSguePfkrdJ34r3i7+2LToUrusNzE3W/kTeZTbYnBlNUolwRBV/aKQyTyL+syh/n8hzsrsdqCpKIxWw9KGGNTfJnxf+0BhidXkyP4c3uaVvjfZJqXdNWZY3YgezMuIOb/6oFhn8Lw63ZCQCmLxSOIj4Ct3qgKNJDMQDgmYImfWVUSyZeRQ7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI5mcyNskl+zc88dbcUYR8Fqtb3IS5MFUcEslXFrsEg=;
 b=2VxjiXQj/FjE/4xogsD8gj2/9t/a7Ee/goBBeoUWajMVoyxsPaTEPYqiGwqsOh3WmPqFOJc4k4F1MEYUnxuErty46KjynX+t4JBtJ12SCDYPPKGv8r900yygabQTt2bZkmgnNeRGKuFmIFzjfsC+jJB44aacT1fvNf2U2NrOeUs=
Received: from SJ0PR05CA0177.namprd05.prod.outlook.com (2603:10b6:a03:339::32)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 19:43:13 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::fc) by SJ0PR05CA0177.outlook.office365.com
 (2603:10b6:a03:339::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 19:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 19:43:12 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 14:43:10 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<qiuxu.zhuo@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadhut.naik@amd.com>
Subject: [PATCH v7 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
Date: Tue, 22 Oct 2024 19:36:31 +0000
Message-ID: <20241022194158.110073-6-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd53772-bd7c-4be1-ba31-08dcf2d1c405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VMVd0t0OMpljIOlm5UQ7nL1hC9Cs/FfsGSwruTuRoI8Wvp9l3oLI2UyGt3gA?=
 =?us-ascii?Q?Yvr15QeV1uCEiFPfUWwSQkH5yvfqVIRMUYirDFWgEIv7X83qRyMNPtlZRiPB?=
 =?us-ascii?Q?xjPojMMqq7VZEyH8zvvhCZ3b27EWAPkHD9jJbJGnUQSPVpwBz/U5XCjekyXh?=
 =?us-ascii?Q?8sINGhgGk3+2sXf90xv6EpPLTXYZpu6vYcciheajt05ltTwqy7Q+voO8dm8o?=
 =?us-ascii?Q?HzBkvcFbTuzFTNAv8/fgeFgsor79lgY5kll1t9YYYv2TeZvZtN9HAwgAXb1m?=
 =?us-ascii?Q?8iT7wG/o+a5ExCL6SeRT7Gt/Kj58SZbxZCTAV3u18fCcoObEffJ0cFEAHkrC?=
 =?us-ascii?Q?OjqRkTTQunOhXBxZR4RJO14Whcc/QLA8Upm6frynUcOH/VWVegxJYBaLeoxc?=
 =?us-ascii?Q?TT+ZJUInEMruu5DxSsgmOV17KFsrErqPpEt4D8WDD76dM1Cvj2OwN4mm+tDZ?=
 =?us-ascii?Q?OqbZ/hUT00kRr7Jbpykg4DEOZ8qYLaXnIDFbK8gxYlMIpM/2FzD95DD1gdI2?=
 =?us-ascii?Q?pgNBNjMfvryfOBdeD8gPu7cwIM++hl1cps68eBZdQeZgNauT24NtqonURybx?=
 =?us-ascii?Q?f9bOwPi+HAfdaLUdDxdDLxUwcKTLWd8ebml1dMvNCumOgT9bkKY3EDBnQRUa?=
 =?us-ascii?Q?a4Gu0251S7oWWPOmbbFy5A95TTIRZKAT9oSLy3PaFAKdsjgm2i6oTx1T1B82?=
 =?us-ascii?Q?ivM9x+a3MElXUZAcwmGnbBAt0rgdaLiQeZrpPAWlGi8d+OMiJTjLuu3KrOA/?=
 =?us-ascii?Q?4VPFrIDwU+eaQbO23ihNJHV/VhfgP3sgnZDKptBQZbM7yjNxy/89gHpeqMN6?=
 =?us-ascii?Q?7tJlIDrdEsxP1ByrR+46OJaJNWg8mXEaSjHWy9gZcdENigGnvsbMCyG/NTUV?=
 =?us-ascii?Q?W3w0HY0skn6snYLa1XOcMpkzucRLJDSO4tFUFF9ZPvhwtISONibwFb+OFJhU?=
 =?us-ascii?Q?rNa1JbzpyD6mlmqZgJL63VpAMEgOH1ZYFZqvcJEgNVPSOFBkbaE3sDI6b50W?=
 =?us-ascii?Q?lz0Q4cuBKN20Y0uJAQaAxSqnI27PBramCUFZGYBvwJGacISUb1B1E0LNaTnJ?=
 =?us-ascii?Q?iKih6XY9vCAAmyCZkU1prmaU5YB4nX9nRpdwA6fiqz3O6a9ATrrQ0YVirz0N?=
 =?us-ascii?Q?aJfuaD68w+QsWpZcJ6UJvACzlQxcngLAr9dcRiQgghDRR68LD9xqmkvmYoDi?=
 =?us-ascii?Q?Xwa/f7HX8FMchVrgpSzYZfeLX5d5UXbo51zuh03m6w9Y4JjAGVTn+t5I5Dmv?=
 =?us-ascii?Q?C6iHARX865mEgiZyHoVHTW3BbrGhYrye0EQCHaUM8ZuR4ExUFVt4Yb72qKDZ?=
 =?us-ascii?Q?14ixCYNbdhqIfjmzSH9/R71nu6XJIe/vYYSb71ky+V1zaW/6wgsIQg+Hm5sS?=
 =?us-ascii?Q?FJPaO3Ux3PVZW8yrhBoBoCZYybNVrmqZ8oKUS/Spk0tKtPV7Sp8FyuiIYuIM?=
 =?us-ascii?Q?7Pbq9otBwlw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:43:12.9001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd53772-bd7c-4be1-ba31-08dcf2d1c405
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573

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

Changes in v6:
1. No changes except rebasing on top of tip/master.

Changes in v7:
1. No changes except rebasing on top of tip/master.
---
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/amd.c  |  1 +
 arch/x86/kernel/cpu/mce/apei.c |  2 ++
 arch/x86/kernel/cpu/mce/core.c |  3 +++
 drivers/edac/mce_amd.c         | 21 ++++++++++++++-------
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index c2466b20fe79..72a69ad7d692 100644
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
index fca23fe16abe..bc5e67306f77 100644
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
@@ -681,6 +683,7 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
+		err->vendor.amd.config = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(i));
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 194d9fd47d20..d69a1466f0bc 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -795,6 +795,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	struct mce *m = (struct mce *)data;
 	struct mce_hw_err *err = to_mce_hw_err(m);
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


