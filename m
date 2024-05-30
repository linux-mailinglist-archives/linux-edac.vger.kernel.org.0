Return-Path: <linux-edac+bounces-1161-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DA98D548D
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2024 23:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D759282E50
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2024 21:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7195E1836EC;
	Thu, 30 May 2024 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LhiuXrgg"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19EA24B26;
	Thu, 30 May 2024 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103848; cv=fail; b=HzcaLOJbjd6swdv+Pk4d7oGoXAxnYP/CRgjvB5mx1cRyr2twYSe5bzoWQ3CNJGVTUjl2C2vBC3+fP6eM/wNTGEASoIZccQlS6NG5OoYlj32EOHWGP94fMoUaus+79/xcqfLveWJ2w522XUmeeu8eOHhyx59E4DCerI2SoOppoAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103848; c=relaxed/simple;
	bh=t16ycn82rfOPSztiIc8jcmxGPMacvxCGWlBnDHGZdgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9epJ3MfNkeIBKl1XK2tSHOCpAmlcIAYUQrgBWMhnzQRKLnkCxSVC/l0645UBNWfwJrJe41PBLOKK0XTaNCS84SE6ohysrSH/dE5hqQ0ocMYafgX7rm6eNTP5Y9+CZSm5uuBeKQdNnD6sOzYI4NCaZ+X9L2UoFJ4Hrv/nBHqg8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LhiuXrgg; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSDR1m0tqFdcVbXPFNpFS50z6rE0I+CJZzg8GcZ3xI4Au4Zvtb+i17KAxWvOJLaPc0A8a7dGfG29gH6ptP7ntJ1ho2UJb72laXmLmFzrpeCS142ErjH/NaRVjBZrJ+cQKwyKd1U+CAAYwgnVY09so6hcjAT4On4rtXaO2+Xg5vcKQwsbWlQYyWQvhuPqa/k1wFfM7bGbSkr33sDuOJSyOYpb6soEI2fJePuUdZ07MwIf3sTqrA92XVA8XptDLzfH+NdiNHC+s0zlyObFb3M+As3cp5BnvfyqdDIxGtj/5A979S37SDTVXnxxUMZQ43ZdmXBJGdSnnXs2BqsccPnm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgZHAoNSlm/cHtBXuLuVAeOrAU0k8QGxE4kas9s/zmU=;
 b=aB51DspfDIzlx749OJOOZTa8qO2uMAl+1p2xtRanir7TF++6lXzCi0FI3C65aHDfvvyE3l1BFxhjxmvzW20QtZGHDwhmx7FIXdXBkbBpC/kQ4zt3mDQ9BCO918eEWPU/a46Ft3ipkB1maIqwfBOPmZkRSm0QEQ71HL9nDj+1NqCfNEOevV5FXrscQm/BIVongwGcbkm7P6xER3Ru+vGSGnI1/kZ7XnVaumBY3xr/ZGPHlJHa5NDYtgw76PKbXETY/AT5oYXmmrmqeIlO1bnQUei1lPF7GYoErT7g/2unUXU0dWx04UGxm8aIvPy70V8TpbahWzcCohjyD9nyFSkTyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgZHAoNSlm/cHtBXuLuVAeOrAU0k8QGxE4kas9s/zmU=;
 b=LhiuXrggX12la2EdGux+BUNTN95hz2X3pwo/n8DqKfAhvx7fiTsxWK2e522DuccLoKOO8h4CvNMevsbYbIFxXAUSbCtKgxYS0yNCvBG3/SzhoHQVZsQvdfozZRKZVDNMOInSzoWxJ3gAn0G2CtHY4xqXBNVYvPyn54smkWSl7Io=
Received: from SN6PR16CA0037.namprd16.prod.outlook.com (2603:10b6:805:ca::14)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 21:17:24 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::81) by SN6PR16CA0037.outlook.office365.com
 (2603:10b6:805:ca::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Thu, 30 May 2024 21:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 21:17:23 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 May 2024 16:17:20 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH 4/4] EDAC/mce_amd: Add support for FRU Text in MCA
Date: Thu, 30 May 2024 16:16:20 -0500
Message-ID: <20240530211620.1829453-5-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530211620.1829453-1-avadhut.naik@amd.com>
References: <20240530211620.1829453-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: afaddaeb-3131-4368-f658-08dc80ede65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4cmliK0AUjxnzKIO/lkxxYt8wyGHJ4HS7kHWUf3OXgaWFvxbHY+rgO4yDYVh?=
 =?us-ascii?Q?0V9yUTEMjQ2LfYh4PMFNAUa7e5kC0WHhywg6+7p83CG/J+YWxfDHtqhRpVJc?=
 =?us-ascii?Q?8jso/G6/OkDwLHTQND67vgcEtOWNZGP1PrjAIO0pdxjO7plyeRYZq1AuH3S/?=
 =?us-ascii?Q?wnOTh9SjisIM7c36taRq8WWW+iBIabhm7CoBugvmqqfVjCKjW5+onx/nHXIq?=
 =?us-ascii?Q?/HsjiUXGFfJ//caqBc28GegKwbKE3y2HfaQ3DCp6GeT0nAgoa6V5vS8HUXMA?=
 =?us-ascii?Q?r8TwTsLqAl5vV8yLQ5mz2c2swd+9hCPuDmjQe3/Fzl6RS/OHCekhDOhX8fkq?=
 =?us-ascii?Q?Gzp1KjhXeM+3KAUW/CbUg8a6ZJjw5VHDzNQ14ZrYDVvgNcLtwvFpBZ0ZlgAx?=
 =?us-ascii?Q?FsVPNQduGX2R6rJfKmzs+RdE4o1NA/djja9i41yknlJKvBQx6wd8WV4LNvlS?=
 =?us-ascii?Q?t4WJ2zhcJRf6XZIq+dPsxe1byjYyeK3eq2aqtqBzfl3oMGxYFp/gif7t07HL?=
 =?us-ascii?Q?EgisjN1Nz5Vyjhy+U5u+7nmEC1NQNOFq0S1Rl13yZVseqbMRUEIOo19/hW1t?=
 =?us-ascii?Q?S7djsuvAmZ4cHNF7u7bwHwTHM286Oz6WUzIpK1VITMtFhORXfGfT1AKsy3o/?=
 =?us-ascii?Q?53o4jysTU606sSV7KE0O3YgJ6yy7RL8zRx5p13j0Its5R6dV22+e8gNzfn88?=
 =?us-ascii?Q?jBpzduDgd8wlwtU3nWWYRBJqDegfoEg6HG6hojyU56bJNbO9syQqDoJjUuFj?=
 =?us-ascii?Q?2mNeHztOSa7+n4sFfcg0E44Pw4hHwjPltrJRFNAP0lomGVxwn2NX9bXeZm2P?=
 =?us-ascii?Q?3dDAd1eGRj0NVGtnakA8BcQg2AWvF/qhzTNoaqrsFG4vPS/yxYnU8aUwpG58?=
 =?us-ascii?Q?7AVOCocdt8Tv1P5HvJ5rZeuOydQXoGqjesSDXME5snjeV7E74LvwQDEdluNu?=
 =?us-ascii?Q?5uy8lT96DbZyyGxxE5RoX5aKC+ZfAYSHGeoxJSuJnK++ZtHUzZ+j+vFTq/If?=
 =?us-ascii?Q?FK3p50GcvSWsSEHdn6U2MF13Ga0fHOHnA+KuxMFoAjjmrOXcQfT7gcSAUQUB?=
 =?us-ascii?Q?xvtxd8V9Zy+bYp/7wY6whcH89BaMXiqIVk+yGIM/J5fs+kg63TCJBHe1sntR?=
 =?us-ascii?Q?YA9+sUbvKUPRtScKSQnFjYQPIeuvBQqPMc4LZNqHHwxjkgoWUo8t9Z5VvdV8?=
 =?us-ascii?Q?LhVK/2lvTl7bIO6ICxzRcipCOR551TlOdjXSfGK5DNcL8EnRESFEezGVgmhc?=
 =?us-ascii?Q?W0RT5elIo4Fua+5xqA38HgVgoc2X44yo1XxGqyMnkHIps2gEFXCSijP3qXWS?=
 =?us-ascii?Q?I+wXO3rl0GNNy8CRBn7n24AdB5we+23Xgc1wBgjjYPKMXeoVJVZ5sWvlvMxa?=
 =?us-ascii?Q?MycYVnlPJfjzXqUoLSmzODENXv3x?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:17:23.9533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afaddaeb-3131-4368-f658-08dc80ede65b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295

From: Yazen Ghannam <yazen.ghannam@amd.com>

A new "FRU Text in MCA" feature is defined where the Field Replaceable
Unit (FRU) Text for a device is represented by a string in the new
MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).

The FRU Text is populated dynamically for each individual error state
(MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
covers multiple devices, for example, a Unified Memory Controller (UMC)
bank that manages two DIMMs.

Print the FRU Text string, if available, when decoding an MCA error.

Also, add field for MCA_CONFIG MSR in struct mce_hw_err as vendor specific
error information and save the value of the MSR. The very value can then be
exported through tracepoint for userspace tools like rasdaemon to print FRU
Text, if available.

 Note: Checkpatch checks/warnings are ignored to maintain coding style.

[Yazen: Add Avadhut as co-developer for wrapper changes. ]

Co-developed-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/apei.c |  2 ++
 arch/x86/kernel/cpu/mce/core.c |  3 +++
 drivers/edac/mce_amd.c         | 21 ++++++++++++++-------
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 290d32c84ffd..a513a2dce458 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -61,6 +61,7 @@
  *  - TCC bit is present in MCx_STATUS.
  */
 #define MCI_CONFIG_MCAX		0x1
+#define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
 #define MCI_IPID_MCATYPE	0xFFFF0000
 #define MCI_IPID_HWID		0xFFF
 
@@ -199,6 +200,7 @@ struct mce_hw_err {
 		struct {
 			u64 synd1;
 			u64 synd2;
+			u64 config;
 		} amd;
 	} vi;
 };
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 8fd4c42ddc06..2671b3a5f24b 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -154,6 +154,8 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 		fallthrough;
 	/* MCA_CONFIG */
 	case 4:
+		err.vi.amd.config = *(i_mce + 3);
+		fallthrough;
 	/* MCA_MISC0 */
 	case 3:
 		m->misc = *(i_mce + 2);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 253d7d0d3331..a2a588c6383e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -207,6 +207,8 @@ static void __print_mce(struct mce_hw_err *err)
 			pr_cont("SYND2 %llx ", err->vi.amd.synd2);
 		if (m->ipid)
 			pr_cont("IPID %llx ", m->ipid);
+		if (err->vi.amd.config)
+			pr_cont("CONFIG %llx ", err->vi.amd.config);
 	}
 
 	pr_cont("\n");
@@ -680,6 +682,7 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
+		err->vi.amd.config = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(i));
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 69e12cb2f0de..6ae6b89b1a1e 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -795,6 +795,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	struct mce_hw_err *err = (struct mce_hw_err *)data;
 	struct mce *m = &err->m;
 	unsigned int fam = x86_family(m->cpuid);
+	u64 mca_config = err->vi.amd.config;
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
-				 err->vi.amd.synd1, err->vi.amd.synd2);
+			if (mca_config & MCI_CONFIG_FRUTEXT) {
+				char frutext[17];
+
+				memset(frutext, 0, sizeof(frutext));
+				memcpy(&frutext[0], &err->vi.amd.synd1, 8);
+				memcpy(&frutext[8], &err->vi.amd.synd2, 8);
+
+				pr_emerg(HW_ERR "FRU Text: %s", frutext);
+			} else {
+				pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
+					 err->vi.amd.synd1, err->vi.amd.synd2);
+			}
 		}
 
 		pr_cont("\n");
-- 
2.34.1


