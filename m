Return-Path: <linux-edac+bounces-1159-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5248D5487
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2024 23:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E06BB251B1
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2024 21:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117C21836CE;
	Thu, 30 May 2024 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FmZri2mc"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6D18306F;
	Thu, 30 May 2024 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103821; cv=fail; b=SHyEXsjnkkL+fOLG7sMjJoN6eL8TJzZLUSvPVE5MOIIJ9PJ0u20drcujLIshgSNJDUX+9JaPVEZLYhav4NQTeAkMJErYaObJK2WiqDq6HQBHT+lzgViu08+yQ3o1k7gACl4xKo7ihza5htE5TQJwHrv/TmEyczY4SlCN8EdzLMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103821; c=relaxed/simple;
	bh=+XZXUbzi0FSspXhwbEY+GX74EHnfasCv8JcBAl2yKbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9/Mcl3qZfY5PL0AUvXM8iRDFSQTkALRmoiGMPVGvBqeY66aRyUVvHEdjZEuQf6GIYboMNQTLfNaIE/FeZJRZo2wucpgoyyRQN3Vg/2Q0d47FCoqyNh4uwjOSl1RlYKBXUX3OyqvJ8LWZsXumwepMRytVUtpz5rrdHhe0q3Yj5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FmZri2mc; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh947FGuJMQeI1rISXkiEa7DuYyRI82uCO6FWiqEmbopZ67qK5IwesrSwkGjfdriMjWxtKojWgezsQsBMRGK1VEwqXYBvKgo0bJr8DZk4QPPmk7MMDdBib/SEjaQvoLMaMy5tFWzG7ASIhpKQzGqxMYP9YO1jc6woyuF2MXgK0kg7Sp+n+JnCf5tdMojCFz/RI1oKbFPnc6FK1pnfVEGzsHp5zFhuxxQAWkSC9C2swdozEF+swVCRFhZHTqygqxsM7KqgDWVe/IVPzThFwbb1fFPMaUqCHx84h5co2Bod+fheCIdrmBwwkhD6e5FWaFbp37V/l8s/3TOzltEjIymOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1eCgkt9e8NKW8RNGTTjWmEdP7D58hRwYCotQxuAoh8=;
 b=T9P3c0ynRlKkLESa+OdVb2xiP+wlS7NHFEFLaiO7mJc3uElSlCbAxffhNiWEnkQ4PoauFy3g9KHGfSLMTQXnp5K6QEGf0ABUPvSBQUZQLfmt4RWK9T9T5LWuqkKGeMSQoNsOA5kpxG1Mr7DJsRDV9VZgV8gPK09LixPc7dZIDReUnjBcyGHdHFvnvJ5xao6WIaUIoZ75WlBigdfESKsYbrYiv8IRkIB9f8b4W6c8t3lFSdSL7nYvdfCRLSXdHQ6cVS9lkRmDDPlOq6zGu9snT3zQ5wpbLDJFs9WLz5JjiDAu+fpyN9nAY33b7IwTJaBJCLe7Nx/Su8z9KlwkKlkhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1eCgkt9e8NKW8RNGTTjWmEdP7D58hRwYCotQxuAoh8=;
 b=FmZri2mcMiOtPOFaEQBmHRNd7PFCW/bLEsUEB3+1QVA8C4ucrnc1w5vpBOJiwHNn9kkrOMnzFJs0P8jJBkIV3ulpWqEkhh9kRb06lyJNk/EbP3mLDHwAffX+QdHieYaXo5tlY/M/a7HgFRXVS7TXS7TkSt/bAOgKBq9BSZ+3BiQ=
Received: from PH0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::19)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 21:16:54 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::8c) by PH0P220CA0016.outlook.office365.com
 (2603:10b6:510:d3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Thu, 30 May 2024 21:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 21:16:54 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 May 2024 16:16:53 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH 2/4] x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers
Date: Thu, 30 May 2024 16:16:18 -0500
Message-ID: <20240530211620.1829453-3-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 67804830-6a9d-4dae-40a6-08dc80edd4c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xaJTvnS1hDjos6pHZq4TewwkHDR30yHw37+Bbi6HemNW6+9Cx6kAz3dlGIUK?=
 =?us-ascii?Q?RHL4nYIXMJPqLRAa4fxBPrqsPOQpwTYWEGmqQb376ZrKmB0AM3wxh4O8T17I?=
 =?us-ascii?Q?6zncqB1lM8JnswUYpxazvEffeQmOf7bw6EtbPYoz5pbXVrlyLvGEEpP8d8S5?=
 =?us-ascii?Q?Ou8rnmCGij1X4ITAKH9hLg0qBbi2PTQT8+R5foVfhgE3Kjau4Yhf59t1cK0i?=
 =?us-ascii?Q?tEgPD1BUDXxJSIEd8e86OII3X3TTSTi1sbYNT9qWeD4nfRlixZkoZZiAiPB2?=
 =?us-ascii?Q?bvsMZXQV5BPJm9G1B+b5yaUOR1ndGDUjjuScc4U8G2dWtItf6jE6HyralKb+?=
 =?us-ascii?Q?aCCSaX9wpctvvf7pYeEwYF/PWxU+JmDp8ZyW6d1g3NAfRaZGszS5Fis/D/L/?=
 =?us-ascii?Q?k2TBuwPkLdkV26GNDtfreYKtBIvBti1fvgjm2+ITzc1IR5hgVfQPg5Ez3P22?=
 =?us-ascii?Q?B70+/rMLDXq+7/wvFjx1nB+H5U60YcDCdiWDMVEH3M0BRsASl023x8ymvQj3?=
 =?us-ascii?Q?V/2v+nbs5t5i/7yHfkhz7PqIBcvWNVm5G1GZzwB7WDnUWJtUFkdaQZ8nmXwm?=
 =?us-ascii?Q?C/yejmOcXgDLl6z+kmGRC2UE+h3KXLQfRzoSg9l/ttXlQDtdKdxRXSdWTT+0?=
 =?us-ascii?Q?XGDadrzp1KeyIVlzdywxufNQeyh1SU5vKHk4fm1L4YN4rvDI6e9eKw1SHYcp?=
 =?us-ascii?Q?J7KV/4GMxgsY5MUT7OWbrBj3MiRilY55KNoZTZ1Pnbc51YxoJHCVYk5Z69ru?=
 =?us-ascii?Q?/SjVpWlvHYF6L6HTZZOLf6gTgSUsVvAQvxPtlEnxyzjqgWoGiyXr/rJHhqkw?=
 =?us-ascii?Q?a98pUCRFmIlwej2CpdapCF3BjzztLjNpeJF9uh8z706gAGBbKCZ6PHA/QpAu?=
 =?us-ascii?Q?EyCpM5uet38vzENdQFQ/j+gLXkwNeB6NKCFOgIAomI0l4SCBw+F1m1Nz3Ega?=
 =?us-ascii?Q?KTOKhXBSukKn3WPaHCJXwrVF6T062oFNYyVKFDyxLaL0SuefR/8s221uK7Oo?=
 =?us-ascii?Q?xKE8no4WKPu0KjVI+j7DxuoC3PLgYXBGN1gTjju9MMJlzKXBqsmzCo8kmf/a?=
 =?us-ascii?Q?Ky7DqnxBFFKQqS2it9proQK50BCwMUVvW1n4lss5NgDNVq3pC0MdZYS9xWOj?=
 =?us-ascii?Q?Dbj2Zfs5QajqEEXQkhHCoDspD8aTnA754bXSk/R5360n2+XjZx/iJsRO8OWr?=
 =?us-ascii?Q?Zg+B0ekxVCQv4HMkoa2WjBvPMjhuaQc4/c9Yib2g/rOst9AXuVB00T78GCfC?=
 =?us-ascii?Q?YdzJJ0iSm5hge/a0gArj5Abk3XZ3Cy8+sJNqNja+K7QBxJJik7e0DCg/Hpfp?=
 =?us-ascii?Q?D7FiWQ6bM9MbqlC75IRMljHuZyMekXu5hxlhk8yqGey9JPSK4rFR3ThofUtF?=
 =?us-ascii?Q?kWGKAOjd69Nm8WbKK7Vgqh09R1IY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:16:54.3804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67804830-6a9d-4dae-40a6-08dc80edd4c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925

From: Avadhut Naik <Avadhut.Naik@amd.com>

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

Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h     | 12 ++++++++++++
 arch/x86/kernel/cpu/mce/core.c | 24 +++++++++++++++++-------
 drivers/edac/mce_amd.c         | 10 +++++++---
 include/trace/events/mce.h     |  9 +++++++--
 4 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 83923d8a43b0..290d32c84ffd 100644
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
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2f93c825e0fc..253d7d0d3331 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -201,6 +201,10 @@ static void __print_mce(struct mce_hw_err *err)
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
@@ -651,8 +655,10 @@ static struct notifier_block mce_default_nb = {
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
 
@@ -675,8 +681,11 @@ static noinstr void mce_read_aux(struct mce *m, int i)
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
 
@@ -815,7 +824,7 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (flags & MCP_DONTLOG)
 			goto clear_it;
 
-		mce_read_aux(m, i);
+		mce_read_aux(&err, i);
 		m->severity = mce_severity(m, NULL, NULL, false);
 		/*
 		 * Don't get the IP here because it's unlikely to
@@ -954,9 +963,10 @@ static __always_inline void quirk_zen_ifu(int bank, struct mce *m, struct pt_reg
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
 
@@ -974,7 +984,7 @@ static __always_inline int mce_no_way_out(struct mce *m, char **msg, unsigned lo
 
 		m->bank = i;
 		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
-			mce_read_aux(m, i);
+			mce_read_aux(err, i);
 			*msg = tmp;
 			return 1;
 		}
@@ -1372,7 +1382,7 @@ __mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs, struct mce *final,
 		if (severity == MCE_NO_SEVERITY)
 			continue;
 
-		mce_read_aux(m, i);
+		mce_read_aux(err, i);
 
 		/* assuming valid severity level != 0 */
 		m->severity = severity;
@@ -1573,7 +1583,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
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


