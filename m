Return-Path: <linux-edac+bounces-1358-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DBB9158BB
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 23:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6461C22E6F
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C51A08CE;
	Mon, 24 Jun 2024 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CyeyNLrA"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B571A00D0;
	Mon, 24 Jun 2024 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264025; cv=fail; b=SLB0i5IAsLmAZUPRj/KhEgbfzvF0/riQ6cVfQxuWkoTiDITNJbgoQMVTwfO6jOGxDvOIMM5upKWKRpcoZYXvr93WeLJRdjEn+cKJcxL7p839JHYehOgqWdFvp+ZlFFR1W7YCm3zjVR2K3QmCT8JzlsVKndMeWoDyNb1d3osnF6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264025; c=relaxed/simple;
	bh=1N/eRue6MTR64FnBmoobaeCRn+GHZ45SdXsA22hUPlU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaBlPCxCCNs1jz31/qWU92DnwH3XU4xExBxRah4A2GRvV+NOVi1NRuNdusdntQCggMpAlUVY83+SVgwuHzyJVsNK0soeelv8X53peE9X7HLt5RA1vn/ipWcOPXFSg0IMDy3le9F9VzjHgPeQGRXUznEpXrxiP/M26yCB7Mjbef4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CyeyNLrA; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cevVOWIsUqRvmaMvXx0tjWn3gLvgU3e8oOOtSuLF8jo1rsaowW8whqOvStRCaOC6Rf4UHadwRv+C5AN2OIo66NJu3dVIGGUoI9gTWNy240B6hcfsYIMO/ZEhLLiav9uS5Vg3UjT3+2jMPer+eiOy0b2ZX+/1h9xs4HQsUVv62xVOpWMh3nhHQ7ilX9hChzLZBthNYl/ieJJsMTP+KXt6NzGKqcvQEAm5bH7xMoAoVlS3AFZAdxfQ7PxbNEKi0s68tKlCQDdDCHHFYT8ATCuxGIAeMxsPNGRT7kAjLGthRzS6pAgCuM6hMm4nmR5bOhvFRdeN0RSIvY3jR6/JGbCDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbDJyaBBYP0iy60+vCMyUt6sk/TXcFQp9nGVLxzCAGs=;
 b=DXmMqbfSdX8SRHYj2rJHvjlGFIF4YYRJeNr83KD9wL6VYbSAviax4HfgqLZAFxgFRU1gH99ULt5EIas+F/VWCdfamXNf45bweQPrtzyPpMsTI6V7kmHUH4qxUvt/8nLJC0j+2hpGS3L7i2jtAFk4Dqh5/1qzXodUSWzqHLfVa9ryMeftZH4jmnhigR2aONFZ0fVfFvHfUJrjwT51Jznkaf64C0cpt+bXD8zEpdmnqawFsHNpri2cQUh4LD1DUDcDQYnLfAno7skjUjyzJ/KY/A4hDqIQAos4FGsujlOXwA+rmE+byz9lnaFipzLqMpe/TzVDV+3T0g/lQocqWoUtxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbDJyaBBYP0iy60+vCMyUt6sk/TXcFQp9nGVLxzCAGs=;
 b=CyeyNLrASpVc+gRKgptJaT6dWPEBFJys3apuvv9pHDIdlOIALWDa6tXgadbo5SkejBvbD5u8O7JKbgN7FAkSFLTNjABKr6ewX0Qn9Foe1nbNADgwqUY73BbX28YizjRB2AJ4soP69ccA/qLADgJtoxb1cNULZIAToZ0nnQtjC9k=
Received: from SA0PR11CA0078.namprd11.prod.outlook.com (2603:10b6:806:d2::23)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.27; Mon, 24 Jun
 2024 21:20:21 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::69) by SA0PR11CA0078.outlook.office365.com
 (2603:10b6:806:d2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 21:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 21:20:21 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 16:20:19 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH v2 3/5] x86/mce: Rename mce_setup() to mce_prep_record()
Date: Mon, 24 Jun 2024 16:20:06 -0500
Message-ID: <20240624212008.663832-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624212008.663832-1-yazen.ghannam@amd.com>
References: <20240624212008.663832-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a119e7-6012-42bc-4d60-08dc9493743e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5km3f6aRRD6ASoczDM0/Ao7aEEn2gMi0WuWczYljZqDQ0jRnOBtAp2pXue77?=
 =?us-ascii?Q?gXkWIpyO+K7NVCRM34l64sWSbYowxe5sf5ys3AfL5qAhtGs120//V+AQz4TK?=
 =?us-ascii?Q?CJ0VbFY4eSFRe921ulF9XrX+KixzLllSQ5HR4n8psuCYBRi++S0FY+r/IOrh?=
 =?us-ascii?Q?i/OoyYUU8uVf1K2M9RNSbG5R5ctOCOjD5OvLvsYoPVSKfd3VELvMnxfeA6H3?=
 =?us-ascii?Q?4Qd6j3cMsSX6PGqXqBy1mdIH5hezmAcj2n4s9vu6UU3uEhXn5ZH/ZkaGK/mr?=
 =?us-ascii?Q?LoW1WwSf/rSpJNfS/Ii7nAj+n1ka1DB+KMpZamsskElpNYCJ11oB21cCPoAy?=
 =?us-ascii?Q?wC/bRkB0UeBSzsxL55QmOy+sJcUM7GmFm5RAk3EuCvbT+LvYOvrPrist1NmX?=
 =?us-ascii?Q?5yTj83FnOgkCwGF0TvoN9lIemN5fTOBfLR3Cp3KTHcsQpVVwmNTCm+Mitbz6?=
 =?us-ascii?Q?GlDMZwo7DuKst/DpNmvEX12fWLbfa/sGuqJ1359BLFHcX1/qr/R7cevBefCu?=
 =?us-ascii?Q?QrUVDfZYAi9vLXWOLGpYySzfK7XFDwrlWs9DOk0VD5MQVE6SBFlIyfyacm3L?=
 =?us-ascii?Q?i8+aL50qPz34/JqYzoTRMUc98b4BSLT5QrNRgISTugq1ZNriKUNV5eTvyUGM?=
 =?us-ascii?Q?sC23C060Q5CJ672JkiQE+UzOiaEJoPrOVZzLe4DvZd6YF1cHW1cRayIuuEhl?=
 =?us-ascii?Q?PGD6X4QHffD2rI9IZXaTrJzg+YPGRMRBjweYumss6yK2aBsgz0WtRGwx9zBv?=
 =?us-ascii?Q?ywc1pwk3BMmsIBWhq/+bNiQR0dvVrtd34Tx5l0z37E0yHUDkDRQ+GdNVgvRX?=
 =?us-ascii?Q?zo3qRMEEkvxHl9Rxiv/vUhd88WUbYPAc5HhOT5fy+L3YIbH6BFO5dQlUvysm?=
 =?us-ascii?Q?CrCHz5OcaITU4WYsL0l3d7cBfowDeunFyso+c/OU4+EzBK/2MAjwO8iAPBnH?=
 =?us-ascii?Q?+kbmQWpd+p6N3A+QtHCZlRUicCAaZe3F4PWP3rtKCkYZUVAf9WmxTUAnPNh7?=
 =?us-ascii?Q?YTLornUqYpkl6U48yZK/Icdd8PX+mJrXvhuINCAOrV5PXZidoRcyjxalldTl?=
 =?us-ascii?Q?ic23SK8UsL/sVJ5zunVYVitJxAshqnPqaeDO1aTOImfHAR0zrW5cP+XR/6KF?=
 =?us-ascii?Q?95O0RuaJFX+3SkWbpURX+WSlFJEGDrwcRREHKfp7Rxowo9GJMKG8rgbz2E4S?=
 =?us-ascii?Q?BY0TFzyiQVDOXaMnCRccGq6awjKE4HyPkuvCjQMGu+O/NKgnbN919an3AEXT?=
 =?us-ascii?Q?F8zu99T005PSsHnxXNpRkDAfJtwIL8b3SEt1xPhLyzJu2fyLqdv47p8UI0M7?=
 =?us-ascii?Q?ej9k+En7rcuvnCdmgJSXXp1z4g2WX1LuYNCwJfrx37w7eE90l3TVChu8QhgI?=
 =?us-ascii?Q?blyGBuE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:20:21.0173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a119e7-6012-42bc-4d60-08dc9493743e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413

There is no MCE "setup" done in mce_setup(). Rather this function
initializes and prepares an MCE record.

Rename the function to highlight what it does.

No functional change is intended.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20240521125434.1555845-2-yazen.ghannam@amd.com

v1->v2:
* No change.

 arch/x86/include/asm/mce.h     | 2 +-
 arch/x86/kernel/cpu/mce/amd.c  | 2 +-
 arch/x86/kernel/cpu/mce/apei.c | 4 ++--
 arch/x86/kernel/cpu/mce/core.c | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3ad29b128943..3b9970117a0f 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -221,7 +221,7 @@ static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 					     u64 lapic_id) { return -EINVAL; }
 #endif
 
-void mce_setup(struct mce *m);
+void mce_prep_record(struct mce *m);
 void mce_log(struct mce *m);
 DECLARE_PER_CPU(struct device *, mce_device);
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9a0133ef7e20..14bf8c232e45 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -780,7 +780,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
 	struct mce m;
 
-	mce_setup(&m);
+	mce_prep_record(&m);
 
 	m.status = status;
 	m.misc   = misc;
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 59f1c9ea47f5..8e8ad63da5b6 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -44,7 +44,7 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 	else
 		lsb = PAGE_SHIFT;
 
-	mce_setup(&m);
+	mce_prep_record(&m);
 	m.bank = -1;
 	/* Fake a memory read error with unknown channel */
 	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
@@ -101,7 +101,7 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
-	mce_setup(&m);
+	mce_prep_record(&m);
 
 	m.extcpu   = cpu;
 	m.socketid = cpu_data(cpu).topo.pkg_id;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b85ec7a4ec9e..dd5192ef52e0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -118,7 +118,7 @@ static struct irq_work mce_irq_work;
 BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 
 /* Do initial initialization of a struct mce */
-void mce_setup(struct mce *m)
+void mce_prep_record(struct mce *m)
 {
 	memset(m, 0, sizeof(struct mce));
 	m->cpu = m->extcpu = smp_processor_id();
@@ -436,11 +436,11 @@ static noinstr void mce_wrmsrl(u32 msr, u64 v)
 static noinstr void mce_gather_info(struct mce *m, struct pt_regs *regs)
 {
 	/*
-	 * Enable instrumentation around mce_setup() which calls external
+	 * Enable instrumentation around mce_prep_record() which calls external
 	 * facilities.
 	 */
 	instrumentation_begin();
-	mce_setup(m);
+	mce_prep_record(m);
 	instrumentation_end();
 
 	m->mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
-- 
2.34.1


