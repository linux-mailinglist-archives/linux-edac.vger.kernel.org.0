Return-Path: <linux-edac+bounces-1654-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C54D953C7E
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 23:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D156C2865AC
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 21:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13100153824;
	Thu, 15 Aug 2024 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vyXMhca9"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2D14EC7D;
	Thu, 15 Aug 2024 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756652; cv=fail; b=tyTz4LIxtdhGtZdkWWPL1QErw2jBi0kWMLa8UGGOj+B9u0atugUBQsIs/aAv3fN3o5SE00zXL2E4rqJapmzbMWqIfJwz+qVbk718NgpNja4dp2dVHWeKFNmxtCvkCb8CU9SZ0ruZBtLWwBynfDAd4JjBiXi9NW/whXueS2Remug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756652; c=relaxed/simple;
	bh=RnhsPtsYWqNt6vrKUE7+YcYgI6hm5+qU5igfIvPwcZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgIR9AvIZSDKJTMq5qm31j9DOt7zJb226WXPDDr4KFQS3sYBFLHaXqJxZdsNjAhMCvM+XzZ2gJkdWLKu37R/oeGiOHCL/i1Oj1ASLXLHy9Ab5fMiZJaBt8oHp3RwmGTfdC3OH39jvdx1I+wuqQuLi1Bc0FgytOsDlpv/QS2Hy84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vyXMhca9; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoDhiUvAz13AW6KLOiVqgzIzVqvFS279UHPfw88Pr32wQXzhCH3z/CDZr/Am4lXBrrH7c+B3KIjym6a2R8NCXdEkdBSDd+rL9OmSEy6RJ7olVmiEsiJU8/iUr6ZcPx5GjWVaZvf/xEqZxzo87aQo/rjKUB6PouVVndJjDKMP+RmfmAfeEvaOT5fsHEaZ+OT75LXo8Hk9r1R93QYzhi5/Og5CCZlbPGWi2L1HCu0G0r1wBrCotnv9fWV1Seteuxq5Z6mcHg0CEmuGjVw0+EkYtk55pgiosbOmpsmiZnv4q2sYCAUzd1NI3F1GzfVd9cQakTthdXfpfLoovo4C+7d2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqagdSPuUQOcKCNQf0f+uHlg+BtXcXfAmC//rIpAs8Q=;
 b=OPazQ+hvPRyYjex4zkEF8UeTMeEbKpvoHvKNhboYoQY8JwIQyiXaMZkdFB66Q//Z1cw6smThHusAKKYVhMtrpiMOu4f2t/tJhRJsU7LXIhsdCoWxpKKnpOVxDflY1cZwp49fBANzWa5Sa2Bj7caP2Ft/nJUe6c40/5UBZV5ZcGX3Ww5iHa7Pq96nNvwnMdECr8imL23ZTq+8HUxVfclQsyuOfHxR4wpCbVK1eeLTGQO0FI9YToooWakXm5uTfxij2DzG/3oK/F9uo3vufyD5ZDg+XosBUX/D2DHi6SsDdOl0fm3rVbHFeaAKDw4Zz9GWXj7ITvG0/U+xJWlIMpRkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqagdSPuUQOcKCNQf0f+uHlg+BtXcXfAmC//rIpAs8Q=;
 b=vyXMhca9gUorRE+82BpLB99mTE4fPmYlXaf6ow1XLmRQtNRCgb11h2rO+icVPhkrj1FS5rcUq9xu4EM+Pt6SwuhOLJqcg4Y+WHfKi1A7CxHtiguE8KS/9EU7Oafi2DbFGSxUspeXIUUUninDQRTvqtUIBBcAM9V1LVMngwIx+L0=
Received: from MN2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:208:1a0::15)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 21:17:27 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::2e) by MN2PR07CA0005.outlook.office365.com
 (2603:10b6:208:1a0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 21:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 21:17:26 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 16:17:25 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v4 4/4] EDAC/mce_amd: Add support for FRU Text in MCA
Date: Thu, 15 Aug 2024 16:16:35 -0500
Message-ID: <20240815211635.1336721-5-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 5310ba54-3a75-48de-f44f-08dcbd6fa9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D+XCZ9UWuC/jsKHvIOh1ABNh4xxkAUmSimFoh2vpJdMqVj4iJvQsWPkcHH23?=
 =?us-ascii?Q?SC2IiNKuRo0mzn8fESt17Cngpqh2lXN5A3iKwmrhqMOk12wR+JBvxSSLq31j?=
 =?us-ascii?Q?YYTY7pivdhsW0CMYeeqzFepPq2pKTcxeKnJRLjQGb+ROddLWOms6JLI8zkKL?=
 =?us-ascii?Q?c1p/eB9M69EqZiwda2wJ1LmVD7xTw1NA6aGMZt++rOJlo8kAL4B+zagSOaEP?=
 =?us-ascii?Q?ewJvX5X5SMxnpn9NH8vv50lH6uEzywCIsg8R360VHfrIqhovXOg4tU1AE8na?=
 =?us-ascii?Q?nsz7+yhIrkLZT0Zi9lJ8dd70hev2+5Bdn+/up8tQ92hUJPpp+XJay5JPYSAB?=
 =?us-ascii?Q?Gr72vmXTy3E0w36pxMjgp3f5oDw01xSJtjJAbi5HkAjyrJEaEEqcGWGmck3E?=
 =?us-ascii?Q?U4lIDSD6kLnqAOWPtxPjI9B38SEFXwTOzUp1NrcNPSe+kJNpXJaN1pgf1362?=
 =?us-ascii?Q?jcugkqwbGJa6gqWW0JAAin4ND+Ik1Mc1qZ0cLYxeya5+PGa3rQJlhphjWbYe?=
 =?us-ascii?Q?q6axUPeyicKGLNl0xLrYZkbOX1Buuzjrk5aUdU7Vl3YIrnm3BnTV5Rv4Mvj/?=
 =?us-ascii?Q?XfJg6Ey/IVheIRanX+eyNCJNkXce6a4iGJ8590YzKW9QWXb3QZ2hZRgUDvuR?=
 =?us-ascii?Q?bnXL80HUNJFW5HNPMUj+Fp4LNT1hR+ua7KGqehDFdcrqP0jOs7HMMbMPX/vm?=
 =?us-ascii?Q?fx89X63HTTscGIdGwkN6I74PXYaaO8fxvnacIzJ9v5XyqcDKbKbvMHYCV6ec?=
 =?us-ascii?Q?2YX4Zn5sOxCExGX5sTHPj4sNf76vMhHX0T1PZQ9OK+VuXgKJB84Io7OmxZZp?=
 =?us-ascii?Q?4KV1zTx/tMmC7NdHy6mKTu5iT2LtgBnAZZBbQKPLcD4kOt2o13dHmHT/1f73?=
 =?us-ascii?Q?KeUtBx7UeL/5ERrTzrfwq8m27SHwcDvLb1UVVeIsIUOrgNI380C0UE49uVt1?=
 =?us-ascii?Q?iEXHibDnnCYs5Ad+Bqbz7Ja51uai7OnygzGNjOBaM/nfMQIPBaUc8Lcdn+2U?=
 =?us-ascii?Q?FJmL9rLaaSHostUXD3aYorh20oBXvLbBJCTm5bn994QSVvFEgEFm7iviSF8J?=
 =?us-ascii?Q?l+MViXP7/BDrEcy3kpUWgvA8XbofqFCUhKN2oLCkPjD1xab/FRwXyHf3Lq7o?=
 =?us-ascii?Q?JquTZLiGbSuq+JPbqc0IKmCOKetmkK2OSwi4G5PAYjAidiK321i3r26TUHDX?=
 =?us-ascii?Q?ar9XUzleYyS8/c25ezlbYhYO7Q5Z9u/u+HW4tWS4DVKmfZGlqQWOOWdE/CX3?=
 =?us-ascii?Q?kaDMr1rdkv1+Fkhhp74N/q/4bb+uEqmQ0bNPri2H7BDwG2Ri1ruUNva/iDEv?=
 =?us-ascii?Q?2BONM9SA0RPCkJmd4HtFV7Rib9tECjI4oQCp1LLn74SOpWy6CBTebHnVqzOn?=
 =?us-ascii?Q?CpMQ70R4RPGXWf6nVHRcph/ibQlnhYELkOsHwxmIhYY0jFPxKJMQipdBmZgs?=
 =?us-ascii?Q?pgTA/O/Th2eokbKO5xM7WFObl3Z+UuowokFOfC3U70RPD+J0/N8C2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 21:17:26.9383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5310ba54-3a75-48de-f44f-08dcbd6fa9f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484

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
2.34.1


