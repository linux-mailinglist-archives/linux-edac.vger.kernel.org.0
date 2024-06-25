Return-Path: <linux-edac+bounces-1368-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 995D5917206
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2024 22:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E431F244E8
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2024 20:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D231802B2;
	Tue, 25 Jun 2024 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y2uqLO6n"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B3717F4F3;
	Tue, 25 Jun 2024 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345424; cv=fail; b=O6rVX8BRuFhzbzQ5/Jk4hD5bEZBOTrljfqRcNdrJllRtPBDBPFpV7vh5ilj7Xam/I9OaFInuJ3KJDiBzcMjS11zIpEhCOCEHBOtzEdmDjJIl9xJNxKDjmF5wynuY8OT0s5JGL7g+908ER2c7HcUKptpijo0pS+E2sJQUGgZmMoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345424; c=relaxed/simple;
	bh=ujBsuBa1n0n336ZOOBv/iBA1CjJjoguvRoJqppDAgIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hijc4lUITqORex2u4pmJk2An37iN1TYbTCbIe7nuI0RwrV226RASB86DcJiPqNvTdiFyBVvZUHfFvzijppNBtYQOv4nMNVnVC26BnxKuAz16lnR6rADx06CAQkcoL5T6EVth6T/pAy2adXzyseAiGgSlI+Z9UVYs7stwxh1gOeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y2uqLO6n; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iN8YmvEDVEEKX4r4gSE3rXfRFAMN9fJy6qt1IDce92m4rz1cHaH6BTID/4laBWa52Bq4Xw5NCHUNqxx/ksx9FUzVjDYEndAm5CBDQVveDTBCTYwINgyvPzGjaNtoQBhKppghC3GIicIK6y1ghRinx+ppj1iHdksTOhMGnIKB6hQ1O/gz0ztwc0JHj7M0aUBVpfghKEokOqz7B96fzZ+p6XbOD4F0iNHxuVU3hzVX+Va+IzlRh8PN6Zm3POSe94mxKuLu0r8vCgtGUT/8It6x2u1jTJP90NGQgiB/4ZWeXhlGI+Jmmz60Q3yu4jpIMYBRU04J+sSxZjLivAKPiqab/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWd31KmQjOl0nwi4fUGFUwub1Eyf3Ms8iEYk5iP0s1w=;
 b=aDykqckM4Vx2XlORqryAdiybkQT+Y98s0bwmvqNBsMj0PJEy4aFTHTLtEIPfnRnj7tz8CQ/8l9sOrwbNX2RtRBDWmP8hKsV+HOmZ7B4jB/R9lAJOQrCshCFFLS81TQprq4hu5CDCfF8iS8n8nDOWkBIoi3dYWpW8c3H+20LnOIl3qyw7+1hi4LGYBGv5AmSvWddSCBN1Qb9rf7G4eI8z4ONyM+tBwY4j0MnfnP87lBp/W1LumbPW9dIulrxrAtcemR/2S9gxrUmBU++1cneKMXT+9k7KhLL07uHeIsnNUEHw1MsbsxuLvWba9BEEeUsUy3AwSTM1KOkjsQrKlC6rSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWd31KmQjOl0nwi4fUGFUwub1Eyf3Ms8iEYk5iP0s1w=;
 b=y2uqLO6nUelCWqHGo1vbJngNC/3TwnCo1xQxpSnUCySp/FPvJB0Ag6vTNCGIDHntoEExc2amAku0htB7AY7MCjgio8R37H/yUr6DBzWCdmEWjB2oOLFmtMOLPDxrWO0ArRDU7z1s96jthS/LHiJ6RfqxTsMrlZgro/nbYFRD0rQ=
Received: from DM6PR12CA0017.namprd12.prod.outlook.com (2603:10b6:5:1c0::30)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Tue, 25 Jun
 2024 19:56:55 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::2a) by DM6PR12CA0017.outlook.office365.com
 (2603:10b6:5:1c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 19:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 19:56:53 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 14:56:52 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v2 2/4] x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers
Date: Tue, 25 Jun 2024 14:56:22 -0500
Message-ID: <20240625195624.2565741-3-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 9799109a-ad78-4914-6f12-08dc9550f630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yrtFON4ODosDgZCqOc0bxpsIqKwr84u0in3Ur+yp2lHqrK7q8kX4Uci0YTMm?=
 =?us-ascii?Q?kTbQP5c8ARA3v1tUU5qlCY8kkXIOvYlIWq4s9I9TmhyQ40m80oljr9fpndsv?=
 =?us-ascii?Q?BdRhhqxet441bWoSPiWnsiHusXro1G47apKiDt3zx3Kkn33otv35gbdNkA/i?=
 =?us-ascii?Q?xHub8PeUDrPpjzV59YFXoR5qPCSrB1YWVmESVg4Uy9WIzIJKwU5G4lD+GI3C?=
 =?us-ascii?Q?/+q+BFZa3FMgxiJjP7X/La/yw1x/kQXD/CkkditWqle5snVQU/YMRz1GZtN7?=
 =?us-ascii?Q?Ou/JWe5HORJUndn7peBNNNlrfv4kXeXhsUQrXnC8mdA9TfzVOuQKgEapIqCn?=
 =?us-ascii?Q?sQ1deqM5hl1cQ3hslwdUQ346E/j3UbgfecMa0hzdqzcInvHQq3llFF88Tuo3?=
 =?us-ascii?Q?XFiUnUAEev4qTwRebb1PMMmoLu5+6rAdlnx7bWdeuf5PKvDnSDna2nnjx0Qi?=
 =?us-ascii?Q?6St+ORc2JzCyHUQeL1EG8IUXf7jbjkVLbgEn/sZh0PkVWRxFdb5fkEqYssWR?=
 =?us-ascii?Q?wfs2Kz6YP/0+YD2DCta/yWCcYaVGYNSUlHjphnE6qVyz1KcFZL4SGX/3BUZC?=
 =?us-ascii?Q?PbGVmJO11rYwfe4qBPUGO/78Tx5C557sASh4nqcHHtmw42F28jOUkPMowPnr?=
 =?us-ascii?Q?JXcoNZy5SDgaHXLvj89FQsuaXMue54Fry6676YsfsGsD7t5U7eFT1J2CDYwA?=
 =?us-ascii?Q?dMHo0IE9S1C1Ci6yy5B7UkhdOuV9sNZaISShxaPesXz1pbkb8FU3Wh8d1VXA?=
 =?us-ascii?Q?ZMvwM3xjjFaDSqxkmvU7LXska3hnkUNm2ndbuHizm3jyL7/XsccERCRBQFWF?=
 =?us-ascii?Q?0nJlJqgFhT1vm9c8S5FQV0sRPm0XqOw7hR6fSVcHn/rpl4d78R9/pCPlm65h?=
 =?us-ascii?Q?9slYxts2pkwwh20y2zSzHiPXq2gt5FoDdkyOk8j8PA5hvWwVmc+lBaaHya/H?=
 =?us-ascii?Q?gCSxNNkGUjve+f0b6e3SGrisfdEv/+TBjF26EVTvf1Z1HG0VW3n9oot1HFdL?=
 =?us-ascii?Q?Ekkqm5WWrSdtD4fTdkoyBvtZukdknXrbGgykevoxi8I5B8guQ0is62M3xnA9?=
 =?us-ascii?Q?u+3WJDm47LW/HgkCzEma5Cmv2QmA1W/N+iYbfEyovftTUsbC48Q8/LiYe06v?=
 =?us-ascii?Q?nXqbVdYT24l2ZL1RhzZJpLS+0PQaQJiXS/Se7n/QI/gJt1Wm6ywQTJ2lfrKp?=
 =?us-ascii?Q?CwupYf1zQAB/CcyT4SsQ0mIuX6TAic6PYmrS0tt6mhTnIcInyYV36PFo9uDq?=
 =?us-ascii?Q?KIZ7fPXGeJCmTgJCOp26wPAKCLc1JbrW13nmXebP3WjxPDp9hRWFC7P8sTaL?=
 =?us-ascii?Q?qVaIcurt+azkf4df5isEQlc22gByRu0MuErDqwziW+sQ2VsoPcSJI9cuoPqU?=
 =?us-ascii?Q?s+kj7vkKCOi6I5ytMV5ITVkQKe9/57v7yzZ6C05BP8Jq2NGqjw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:56:53.8809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9799109a-ad78-4914-6f12-08dc9550f630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713

AMD's Scalable MCA systems viz. Genoa will include two new registers:
MCA_SYND1 and MCA_SYND2.

These registers will include supplemental error information in addition
to the existing MCA_SYND register. The data within the registers is
considered valid if MCA_STATUS[SyndV] is set.

Add fields for these registers as vendor-specific error information
in struct mce_hw_err. Save and print these registers wherever
MCA_STATUS[SyndV]/MCA_SYND is currently used.

Also, modify the mce_record tracepoint to export these new registers
through __dynamic_array. While the sizeof() operator has been used to
determine the size of this __dynamic_array, the same, if needed in the
future can be substituted by caching the size of vendor-specific error
information as part of struct mce_hw_err.

Note: Checkpatch warnings/errors are ignored to maintain coding style.

[Yazen: Drop Yazen's Co-developed-by tag and moved SoB tag.]

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h     | 12 ++++++++++++
 arch/x86/kernel/cpu/mce/amd.c  |  5 ++++-
 arch/x86/kernel/cpu/mce/core.c | 24 +++++++++++++++++-------
 drivers/edac/mce_amd.c         | 10 +++++++---
 include/trace/events/mce.h     |  9 +++++++--
 5 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index e955edb22897..2b43ba37bbda 100644
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
 
@@ -189,6 +194,13 @@ enum mce_notifier_prios {
 
 struct mce_hw_err {
 	struct mce m;
+
+	union vendor_info {
+		struct {
+			u64 synd1;
+			u64 synd2;
+		} amd;
+	} vi;
 };
 
 struct notifier_block;
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index cb7dc0b1aa50..fc69d244ca7f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -799,8 +799,11 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	if (mce_flags.smca) {
 		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
 
-		if (m->status & MCI_STATUS_SYNDV)
+		if (m->status & MCI_STATUS_SYNDV) {
 			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
+			rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vi.amd.synd1);
+			rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vi.amd.synd2);
+		}
 	}
 
 	mce_log(&err);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6225143b9b14..3bb0f8b39f97 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -189,6 +189,10 @@ static void __print_mce(struct mce_hw_err *err)
 	if (mce_flags.smca) {
 		if (m->synd)
 			pr_cont("SYND %llx ", m->synd);
+		if (err->vi.amd.synd1)
+			pr_cont("SYND1 %llx ", err->vi.amd.synd1);
+		if (err->vi.amd.synd2)
+			pr_cont("SYND2 %llx ", err->vi.amd.synd2);
 		if (m->ipid)
 			pr_cont("IPID %llx ", m->ipid);
 	}
@@ -639,8 +643,10 @@ static struct notifier_block mce_default_nb = {
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
 
@@ -662,8 +668,11 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
 
-		if (m->status & MCI_STATUS_SYNDV)
+		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
+			err->vi.amd.synd1 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(i));
+			err->vi.amd.synd2 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(i));
+		}
 	}
 }
 
@@ -766,7 +775,7 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (flags & MCP_DONTLOG)
 			goto clear_it;
 
-		mce_read_aux(m, i);
+		mce_read_aux(&err, i);
 		m->severity = mce_severity(m, NULL, NULL, false);
 		/*
 		 * Don't get the IP here because it's unlikely to
@@ -903,9 +912,10 @@ static __always_inline void quirk_zen_ifu(int bank, struct mce *m, struct pt_reg
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
 
@@ -923,7 +933,7 @@ static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned lo
 
 		m->bank = i;
 		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
-			mce_read_aux(m, i);
+			mce_read_aux(err, i);
 			*msg = tmp;
 			return 1;
 		}
@@ -1321,7 +1331,7 @@ __mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs, struct mce *final,
 		if (severity == MCE_NO_SEVERITY)
 			continue;
 
-		mce_read_aux(m, i);
+		mce_read_aux(err, i);
 
 		/* assuming valid severity level != 0 */
 		m->severity = severity;
@@ -1522,7 +1532,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	final = this_cpu_ptr(&hw_errs_seen);
 	final->m = *m;
 
-	no_way_out = mce_no_way_out(m, &msg, valid_banks, regs);
+	no_way_out = mce_no_way_out(&err, &msg, valid_banks, regs);
 
 	barrier();
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index c5fae99de781..69e12cb2f0de 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -792,7 +792,8 @@ static const char *decode_error_status(struct mce *m)
 static int
 amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 {
-	struct mce *m = &((struct mce_hw_err *)data)->m;
+	struct mce_hw_err *err = (struct mce_hw_err *)data;
+	struct mce *m = &err->m;
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
+				 err->vi.amd.synd1, err->vi.amd.synd2);
+		}
 
 		pr_cont("\n");
 
diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 65aba1afcd07..9e7211eddbca 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -43,6 +43,8 @@ TRACE_EVENT(mce_record,
 		__field(	u8,		bank		)
 		__field(	u8,		cpuvendor	)
 		__field(	u32,		microcode	)
+		__field(	u8,		len	)
+		__dynamic_array(u8, v_data, sizeof(err->vi))
 	),
 
 	TP_fast_assign(
@@ -65,9 +67,11 @@ TRACE_EVENT(mce_record,
 		__entry->bank		= err->m.bank;
 		__entry->cpuvendor	= err->m.cpuvendor;
 		__entry->microcode	= err->m.microcode;
+		__entry->len		= sizeof(err->vi);
+		memcpy(__get_dynamic_array(v_data), &err->vi, sizeof(err->vi));
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016llx, IPID: %016llx, ADDR: %016llx, MISC: %016llx, SYND: %016llx, RIP: %02x:<%016llx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x, vendor data: %s",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -83,7 +87,8 @@ TRACE_EVENT(mce_record,
 		__entry->walltime,
 		__entry->socketid,
 		__entry->apicid,
-		__entry->microcode)
+		__entry->microcode,
+		__print_array(__get_dynamic_array(v_data), __entry->len / 8, 8))
 );
 
 #endif /* _TRACE_MCE_H */
-- 
2.34.1


