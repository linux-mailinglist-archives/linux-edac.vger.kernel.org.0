Return-Path: <linux-edac+bounces-1082-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C108CAEAF
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 14:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E51284C53
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 12:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C07770F2;
	Tue, 21 May 2024 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BMT1Apak"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3BF347C7;
	Tue, 21 May 2024 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296091; cv=fail; b=alLTmzH3MiTwr8NrmC9Te8HS08e4kUJy48cd3mpt/eCFJy+r4XzUwx201gd3pd+mMpgkLsx8GgOKtXiDhDjnWwskJWZNjTNOT4gnCu+7em8C4SSe1ECrHjiBmmiXmml2eM0dA/vOwEjBouRpY3hWtz661bnBAwltkb98kr+/Sh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296091; c=relaxed/simple;
	bh=SXZK9lQrUs1Px1u4dRBJCtX80XHajLDlDWHmRdVv6RE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSqQUSJito3iahjuRfcqRrnjByQGomieRU0goATLpYCvoLXLbe25RobcyoTrcHIZ0E7HKJJ2TZtz5aI0qvXYTkQZQJDlc+5ne/SIhI8oxSDq1Bb7XgKpAcgIJ7n65dZv9Dtxq+QTwHjxeOQivmIZ9M1kZ7TSe3pjm+Q/ocRX+y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BMT1Apak; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXG8bIvDpltE9wSfQLTpacjsWqD/CMRnu71CGOBmd+Z6DKhiK8GLpO3+qNP8G/nhvUGd85LDU8hmLVP4lUgpb1oL1eITGE8OR0Ojt+gyBiXwV6I7T9THgPyR1ywmOJ6XkEK8adQQTwTer0QhHH4qjUuNj1Nh/dIHDu2/K/FGGWACPwrUyLY2f2kPRZEb/vmGMbrgaPQood77G892dDQlYVzgChcKybKZS+xKUTculmiCd8HQX0DVQaeL0C1bOgzSk2rP3HGNC07/TWBVGekyvqN2FmBMuZbFO098Pl+q/JE7dC+9gIaebTezJ/p/7t9Tux7KCAF2t11nyXG50R5iRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgeSi9UjHrhohIxuVJWjAAgdjg306DGBnIoTzYJ52Ng=;
 b=hUrUmLTHZ2WoK9lKy3fhDK0dxB8cqEQSb3c5gT4f066H10JPIeHtKwAyCsRj3z/1xutg1ct4ME29zhv87t0YZtOU/AyfImWDQmulR+WayueVfnL3Hmz5Of3np7CwLOjo95JqRKyve3EdO31KGgJot01UgUjn2bKh/3F11dRHDEIjp727mciR8Q06cvjLIVKKBnP+hfYGZLb1Xc8D//0TxcvjUMUwzUqEFWvKxaOnvKnO8XBTR7CiivRQn5793BIpU7os2v8VhzVz8oGUhXaFBP2Ec1cdpXcAPUUtMFq0JrfPiq4HEVWqFFuWwajCk5jVQO3RE9GP11VnmlpQy0DFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgeSi9UjHrhohIxuVJWjAAgdjg306DGBnIoTzYJ52Ng=;
 b=BMT1ApaktovsRfdcZDINFMrZz/tWqCpK6pcQWiUM4N0XbDU7H/iwTF8dhvdMkEVOdGajQP4aDCCz5J3Bj4c5q7KwwNS4uLT82wMfVAX8NxLItayFQTdnqNEjFCfMIu8+q4RG220hydnbSOMrYBJClCirVrq70vMamDmjWK0jAak=
Received: from PH8PR20CA0024.namprd20.prod.outlook.com (2603:10b6:510:23c::19)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 12:54:47 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::f8) by PH8PR20CA0024.outlook.office365.com
 (2603:10b6:510:23c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Tue, 21 May 2024 12:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 12:54:46 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 07:54:44 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 1/3] x86/mce: Rename mce_setup() to mce_prep_record()
Date: Tue, 21 May 2024 07:54:32 -0500
Message-ID: <20240521125434.1555845-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521125434.1555845-1-yazen.ghannam@amd.com>
References: <20240521125434.1555845-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 7346d79b-4664-4432-4c64-08dc7995316e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xz5SoPvSwHGq0vEpqhplr23DoIoG1m/5riQh+9CnstBQ701UF4WeEE3bZZL2?=
 =?us-ascii?Q?JiLUi+5FCIlJRqWk7ifsai5PFquqoKGBxetoKRo7/SBggH5j9KJ92mmK64sF?=
 =?us-ascii?Q?mn3cAO25+D/qpqXqKbeRIz1QqzXDy1SACZdhaKHwhHh5grPoB9T6r5SZWDO0?=
 =?us-ascii?Q?RrROtW9WlwCZItvYonJXRO0gmi4yYkiCgzQ4qOjNNKOzAyJlFt8eKvId5UZc?=
 =?us-ascii?Q?3QyQUxKzerDKEp2WKd5mYnhdlsIn5KtjdgzH59xAZHJ88+M5tYeAzuHNi/wv?=
 =?us-ascii?Q?KyhqJ1WwC0XpfU4TkFycwWFLfchvKay+X4bgBu5CgeaDI19upbnkYhTh7y6f?=
 =?us-ascii?Q?w45IJGPyv75Q2RNVzip7pwSV5isMU1utbanc0Iko73u2GieDuQf4NAYrvyMD?=
 =?us-ascii?Q?q/dyXeo9btaX4cuQ7LpBoAKpdaRatdvGOnZekwRTdW45ZRDT1cmE57GK7t1y?=
 =?us-ascii?Q?8w4r0RdWuoJfhLh9LzFUNhXX6BdChgygYApp4dUnauhC0JqsDPaGFUroJuQP?=
 =?us-ascii?Q?v//TYZArii25ztB8hL3Q63QwESnlZ9tcR70UiC79dx08ZY4qDzDMyDSoLNNg?=
 =?us-ascii?Q?yYzgfzlYpE2ljcE1t7Ih7CX2MLFbVxqkPVSEiZI9SAiw40l62pH45vUMcP1V?=
 =?us-ascii?Q?j+/JWRAp6wHCLr+BdO/bGjZo+T6JHGTnPTIpvIlk7SXECCc+FNxFnECUE+/M?=
 =?us-ascii?Q?f3di2U6sJ22M7lz0Ej73s9HgVIQeBlBk+VKTUZ6pYuX8xfTUyMROTV55Nvsv?=
 =?us-ascii?Q?fRtOUdCWuLYxVCe5DYFb+omLpx/w0P2mYt0wBh/vt5umMRkkxrzJWAIbGzBB?=
 =?us-ascii?Q?xdwaQbjUQdtiPTvk9/zq3oOeisJgYCGJnlCp9LdOevA+zsN1ON51Wqslx37L?=
 =?us-ascii?Q?Ob1h+DlpiImwi0v1ieXXTRIszGJWoraOfMP8bDN5Dz0N1wwGqGJeSGGYNcWD?=
 =?us-ascii?Q?yvcFYjBwvEf1QJcMH4vqejbwHlSJl+CdFjKiXIAETi99YfvqHvIUmSMIlrgq?=
 =?us-ascii?Q?5or2UGNs+98ru+0mwYw7sCyEgh5TeEQn+VqvNT6cmX+LQpd7Z39nNT7p7+aX?=
 =?us-ascii?Q?hMSOARnb+tOu+71F23GNXqlWjTxQOZNigijz0DKGnrYBXzgs+A3mnZCNXjQ9?=
 =?us-ascii?Q?hWcBoQoohpkevatba3Nu71FTNamaeUoDqzAPv0EzrmegO2qXB7mYPWW8e4Ni?=
 =?us-ascii?Q?S+nb6YDrkg1tl9KPuGItRjBtAlpNKr39GKqlVn9Zu039r3+pcBObRueoWnnJ?=
 =?us-ascii?Q?UUXsPBkrbB3Uid0Mxw8HktQn9hdERLUFYfktqV9+2ZFHA9jR9z5KL0/kBBiW?=
 =?us-ascii?Q?uuqWsCvQMQi9wMrDr98C8k2G3OoZC02ylmFplHDGRjdTPdUxaykeGMIokKum?=
 =?us-ascii?Q?MrCdq4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 12:54:46.5074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7346d79b-4664-4432-4c64-08dc7995316e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976

There is no MCE "setup" done in mce_setup(). Rather this function
initializes and prepares an MCE record.

Rename the function to highlight what it does.

No functional change is intended.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h     | 2 +-
 arch/x86/kernel/cpu/mce/amd.c  | 2 +-
 arch/x86/kernel/cpu/mce/apei.c | 4 ++--
 arch/x86/kernel/cpu/mce/core.c | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index de3118305838..c3722b84d9cf 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -219,7 +219,7 @@ static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
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
index 7f7309ff67d0..8f509c8a4e98 100644
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
@@ -97,7 +97,7 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
-	mce_setup(&m);
+	mce_prep_record(&m);
 
 	m.extcpu = -1;
 	m.socketid = -1;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b5cc557cfc37..9dfa80084054 100644
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


