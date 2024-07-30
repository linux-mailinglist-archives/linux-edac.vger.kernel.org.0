Return-Path: <linux-edac+bounces-1596-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E43DD942026
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 20:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C24028241D
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 18:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0BF18DF7D;
	Tue, 30 Jul 2024 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3jD3241p"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E518CC0B;
	Tue, 30 Jul 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365707; cv=fail; b=oURwOg1O/4MXAhC0QHqm0n2dX17ArwN08XgVW1sVaPNiBx8VUUK34kSHJr3CQcD7f8J1/phxMD20Crfa2ybjOtNLC1/SCE+CEbULtv0alG2Dq8St3bSkGa7Ov46XS4nGLwJ13rx9hMDrzlKh+LhVpVmV8tDqyyI8ViPkgglPIog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365707; c=relaxed/simple;
	bh=0v0C+HGzIAxIvHr8Ni7NCkjeGpGOK7r392nLJnXCdxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nmcd/Eo8Wc5bvrVc2D6SMNMXjTFcXMS6wvY99YGk3U5WF7q1e+9lhByb7URdrKuYkoD36w7bTvaSYYiS8GTmuGdCJllgbZDsEEwXfEkjn0inCi0ckfr2dPrzBM8LMv9nII+4YZR4WCzir5pvRUKJqCR1feDUOOzoBzSzAQSh1XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3jD3241p; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTrQt5ZHWN1UCC8FOg+hkgW5ZoMGoyy29GbZzk/O+mkbCS1yHpEFkl7zOhgWyoIRkTAMp2fsDvY8p3LUiDOkseIV3V0/5UaTZsTRE8Z0XmLV6Bc5Svlg6XKnfjn+Z6lISKt8C2Kv5/rG6RHO7akZqAwTjReFPmjBFtFYTU91hShCHPyXtLaxHqlYwX0XCVflZYCO57n7b/QmqMTVPV+mUQkm8tQc8jHk/x4sPWlFJjiYtutcWOxdbzoPzWXoA+tJPxHZXownYCc5lh5VBPmEx8c8Bg8WUR8ITHN2yuhahojWRWj2m2+Lj7UWhlWP35omngbePQdiEvd9/+q0C1H7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmQRvxxMB3CItzDn44urORtpgb/R+cUfZE9EtJUONmY=;
 b=YKPDUK5hF0twc6z5tcAKnU3Nxfq09dBFwv9ncgwgrybx4cXLYrm8BVzI/EPOqEQysI0rqypLJ2IP5F8SUUh92KpBYQBctkKkwnBTswHmLz+0T/fvOFNasLGGmrTDEvut4yz1LHAINJwdq0ONxrW7QV+Q9JAzb4v4IKJ8xo9bCH333fzAhgnaWjEzjSZAg+jfrar12F4JpSNb7VkNUN07s9dWVnS3Lm5I4Qo58ugvcLcVd+1Pc9RNGgLbqs+EpscFTwU+YZKHo3j8cki1shjWb6XLezPvGg7igdP9AX6e0xkL/lKWlGn1gpBdYHiFKFqkMXlI2pbcHh9Sqo06yAYqPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmQRvxxMB3CItzDn44urORtpgb/R+cUfZE9EtJUONmY=;
 b=3jD3241pRCG0DG4HRMoGL8epStmPa7K3n9DwysJMsGjmgInvi5i7wXDYX/VgSiYaiUdB9Cw7FTG2/ESuigy6PznOOY5eb+qlkGqBVkBWY532ifIRQN2vh8jzuSXi5eERou8xoZUBgSI46boFJBhaOep1bN6Q/92hm7f8VxxIC+A=
Received: from CH2PR17CA0022.namprd17.prod.outlook.com (2603:10b6:610:53::32)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 18:54:59 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::8a) by CH2PR17CA0022.outlook.office365.com
 (2603:10b6:610:53::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 18:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 18:54:59 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 13:54:58 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v3 4/4] EDAC/mce_amd: Add support for FRU Text in MCA
Date: Tue, 30 Jul 2024 13:54:06 -0500
Message-ID: <20240730185406.3709876-5-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730185406.3709876-1-avadhut.naik@amd.com>
References: <20240730185406.3709876-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a012713-dee7-49e7-bd10-08dcb0c91ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WoF4udGN1FvNWxdnbuEQxjEfDzPparIvYcGt1Ga2RIG+4L/IdVZ88tJBP+Lz?=
 =?us-ascii?Q?YV4gByedy+OfDUrX8oGtnGdf49enWLIeJvygMgxZbYDb0hgHoqHSOPM/eoAC?=
 =?us-ascii?Q?+mcD40vFDwDnGTJ0BndlZOcYdVRUHSep4aIxgUtI1IZcUBMR6CdCZK0VrIjy?=
 =?us-ascii?Q?Rvk12KQNt++6dG7rGLjNaWpqcTveIeMeQTp36Dbd3yvVE0xUvyeox6Cqnh1A?=
 =?us-ascii?Q?LcOPiRTw9XfheOXTOuudYrofVHBZC6cblkpM7RIDPCcRR4y7nEtrVqO85L+T?=
 =?us-ascii?Q?cOSHrhDhMt+k95Mpt/B3ZQtOHApE0uxEgYParJ9gQA3LTzoKM0qDUWqqJont?=
 =?us-ascii?Q?CgXFE+m8FJBTFmmzskGkHQsmKGlQ91N1qIwb9SyDKYzU8Z8cH+flzo3TbgpS?=
 =?us-ascii?Q?ZsR6LyF692QJbhV8/p9fq+pU75FqjQVb6YlQMcwPViulxwxfgdCnVz0I4LYG?=
 =?us-ascii?Q?LEVTGiI4KiTrN2W5B3KEphi0dFTqjG1jlilPDKZn0DuQFxZFZj8KknSYAv2i?=
 =?us-ascii?Q?pANvFWJLiqCZQn5H9vgiELmXMQnBdmMmvsl3jpGxWKcntStwFF160Z6laFgw?=
 =?us-ascii?Q?6OJ+IAxt3mtMkOn1/UTZ1PNi1eQFthv/BpGHLuramMwjqcKQ1w92rmMPN7eK?=
 =?us-ascii?Q?VWgY5EUSUqYrk0xEkjPTBAdPA5rBs3V8tA6dAvbwwOQAW3ngAvshiXYs0IuF?=
 =?us-ascii?Q?SJcCV7w5t180Y0Anxo64/b2h1+LaxQva79dgagri4rQh5W75Mv5S8X0NjvdX?=
 =?us-ascii?Q?Ggz7yLSHzjkJNdKgv7nYF+FIdu+VrK2rGhc7YOUqvRxWwbHwiHeF+esOiMnm?=
 =?us-ascii?Q?dmrQMBN3CjRhOpdrhG8Vv5aKuxG04mx7glFgfzJqFzuwEbbUdX2S3Ff/3m6n?=
 =?us-ascii?Q?VqP+//PdqAhhZUctPKNPTT3bkeldQX8E8Dfwe7JeXE7UYay5AyElB6KsgOqK?=
 =?us-ascii?Q?HEZ0EqCWIQQ/kf0uWxN0oY4xzlrZkq199onO5c9FtFDCSm3MtQ094vVNmERQ?=
 =?us-ascii?Q?e9r9CAEPQlhxlIDCRVqYnIMBegYTdiUbC324zUpfnUGgSrNxRw8n9c0LzbL/?=
 =?us-ascii?Q?9kNk+pLkGfISRkN87WyIgZhP9Yxy+8PnsQOeF/gPe7uTsqvV6MGQ9ILTsLOh?=
 =?us-ascii?Q?GqZQK2BCqImy6Q9sFnCGsIZATDYvNWdKjRsShsD8B+C54pvp/ljWGMTil7ys?=
 =?us-ascii?Q?oKgJs5jBeIe0tTXrZaeYUvBVeDLO/Q0nhXz5Pw8kfV+h6NIRp0hTQTPCO8m4?=
 =?us-ascii?Q?HUUc+4PnpAigwPX6p5FwrsRHqOnEuhLIWwjQoNizTZgENk2xzAtURcqlFu7Q?=
 =?us-ascii?Q?XyeLkV1cM1EcUdBLHVMiQzq0l2aiklGCnZCvT2A7m0F+ssV12XcLtBzwZMBV?=
 =?us-ascii?Q?E5e84+d+pJVsGD27jB06jvnjUNRG7exDVn0/jzKzVVrPCvz5jQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 18:54:59.4172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a012713-dee7-49e7-bd10-08dcb0c91ca2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739

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
---
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/amd.c  |  1 +
 arch/x86/kernel/cpu/mce/apei.c |  2 ++
 arch/x86/kernel/cpu/mce/core.c |  3 +++
 drivers/edac/mce_amd.c         | 21 ++++++++++++++-------
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index a5be7463c78a..377a5469ed7e 100644
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
index a2a5fb940bb6..00b6fa987094 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -798,6 +798,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 
 	if (mce_flags.smca) {
 		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
+		rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), err.vendor.amd.config);
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 5949fc103be4..db2677f3023a 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -156,6 +156,8 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 		fallthrough;
 	/* MCA_CONFIG */
 	case 4:
+		err.vendor.amd.config = *(i_mce + 3);
+		fallthrough;
 	/* MCA_MISC0 */
 	case 3:
 		m->misc = *(i_mce + 2);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index c8089d7a8e9b..054188aac2ee 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -195,6 +195,8 @@ static void __print_mce(struct mce_hw_err *err)
 			pr_cont("SYND2 %llx ", err->vendor.amd.synd2);
 		if (m->ipid)
 			pr_cont("IPID %llx ", m->ipid);
+		if (err->vendor.amd.config)
+			pr_cont("CONFIG %llx ", err->vendor.amd.config);
 	}
 
 	pr_cont("\n");
@@ -667,6 +669,7 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
+		err->vendor.amd.config = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(i));
 
 		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index aea68999c849..f7f7ea0a5292 100644
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
+				frutext[16] = '\0';
+
+				memcpy(&frutext[0], &err->vendor.amd.synd1, 8);
+				memcpy(&frutext[8], &err->vendor.amd.synd2, 8);
+
+				pr_emerg(HW_ERR "FRU Text: %s", frutext);
+			} else {
+				pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
+					  err->vendor.amd.synd1, err->vendor.amd.synd2);
+			}
 		}
 
 		pr_cont("\n");
-- 
2.34.1


