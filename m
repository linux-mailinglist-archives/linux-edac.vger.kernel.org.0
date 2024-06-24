Return-Path: <linux-edac+bounces-1360-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B219158BF
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 23:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115321C22F3C
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 21:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4600C1A0AFB;
	Mon, 24 Jun 2024 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZyY7notN"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA881A08BF;
	Mon, 24 Jun 2024 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264026; cv=fail; b=B/pNno5Y8FjNX2tB4sItXNa10VNzo00rleXoG6SPOvOmG6F/lLquQJfLXxSpVOphp1bmeFejSu7Yv8dVhINuj+w7/eZgS5D3KI23liwZbY4qJ6AafntWSeIdvcUwh84vNNc45dAei5CkqpBzCJVEUtC3OBIJcDjTxinJDcxsmPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264026; c=relaxed/simple;
	bh=CB/Z/HvMrktEm9H/mggLyPV9gS9c3hVyeEn+8L5oNmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAezSEPS38M4Pi/C1Dad3W5nhyIDudQJlTHGUiyKr59tFtgXeKaRzGrxsY/Zhi4/svWQd0EZvSIyLc0kxWm2Jsj99dCWeqGPYVe1QPpqxU+/B6iiBDIH+XjggIw1qaTnWGJs9N8TuYXbpUik+rWVh+RhOb/5KjoNAYzImEdohb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZyY7notN; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHE92OOSrMLLKPR2NwrXgaEt7f6LQQ2pjgoAyu7vkHAvO/nVNFusQZWVzR5wDLiF+vP3IPtryLC7VbLuQ+vPbjelbLvHe8O2BDnTlF0StyBd3B+C3dHig1vME39QBbLAHPgP7nqCks3xZDQxkGMJH5zNUbtzJVOgGR7B60anihS5+rCx3Fzt3avyx/ElM/Dfp/3e0od0j2m7TGrAXzxyVG+CuUbleUBCa2YYDGCfCd9zmc3fV/My+Tc16+b+9WDgKg3SZcOCdx0h+P8RTo8XpADOMbE0v4E66H+bw47GBtbauPmMY7/V9vfWEIlK08yhqlhCVCmzW/T0/X17Mvw5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru4HINEfDS7edxbEm8ikmvocUsoEwNAGB2f4OMyQ1Mo=;
 b=BtIzOMROkOXglwP/MVwwAkutRKIxMLzHJbHhwtQHk3/71JriXGDqx4T5wL7n45qpKVRnYFNUOx1bq5ZPVvTrFkAo9EEnMjlizEzXl4Ihv1lLojdaS0Ffko1IaUYhhjJ++iEvLZgHxwVdwCxTYBcBhaJb7T8aFSMzXFaWJfCCPng39qOoIk7I3fJTn2GaNGfdBC2hIGIwOcxP6v3lO+IZggjfIM2bBieUsms4urU82XwWXy+flvoD5uFUanwBxjNsWrhwCA827HTg2v85xdsPUcq/WbMDRBgWed45t2iN80feeShU5w7AHXpOhrERc6U9t62qiC7luQzOTMfmyTaJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru4HINEfDS7edxbEm8ikmvocUsoEwNAGB2f4OMyQ1Mo=;
 b=ZyY7notNY2FRm22/UbSLTc8XwAE8QXbiEQLMjYLN8jmBssunM4OjnkQyhb/TANIJu2g9CHulExsD1aoJZuyFgfs0qIdct7AyYTWHDEyt0HhylF9un/CjPFgIUuFOMQ38qeRyeD7WCvZxTcQnMROAfJJ+yUm2aBmABiq+dftcZDw=
Received: from SA0PR11CA0073.namprd11.prod.outlook.com (2603:10b6:806:d2::18)
 by SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 21:20:22 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::f3) by SA0PR11CA0073.outlook.office365.com
 (2603:10b6:806:d2::18) with Microsoft SMTP Server (version=TLS1_2,
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
 2024 16:20:20 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 4/5] x86/mce: Define mce_prep_record() helpers for common and per-CPU fields
Date: Mon, 24 Jun 2024 16:20:07 -0500
Message-ID: <20240624212008.663832-5-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9cbdab-3b48-498d-0df7-08dc949374a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G111Tmizt6249eTFN8uG6/19FDDuWNrCQC1NAV+7d8Ab/Q+LRqXS+MmQTxa/?=
 =?us-ascii?Q?BX13lqU4ID8+avJpeClp09negFgmNrn/ubsO7cYZlvG63hY4LE71/M5CD6dk?=
 =?us-ascii?Q?yOFHNFKViDM1lKn2jcac4ujmlZGP0bS7eAc8iqFCwhOIOLf/CpccfuCwrx94?=
 =?us-ascii?Q?SG6ecZg/KjcCD6/MaP1QztqOaL6nWrStXJcmoXtGbkBB/Jta7LgfRYvy0VtO?=
 =?us-ascii?Q?/bV5CuZ4AvbG4bjWnVj9jPknsz4hmOfwZ4R8C+ebqEW0u6BdkaSpDzmYQW2e?=
 =?us-ascii?Q?BCvRvZNjNOAxNuoaSdlE9LJUf6KC6lAMaicfkzyG8gjpR3NNn2f+gk2HX7LA?=
 =?us-ascii?Q?S7pnKDSqGrJVfuFh8GhtCOojezn93s5/786t6smIuOuRT7zIc0CseJ4cjZB4?=
 =?us-ascii?Q?n5vt0nT4Mp9Yo49kRhrPRsgxCe+fUVpbB9CYlzqAulp4pz0uerHwdBLrhnQ1?=
 =?us-ascii?Q?W0I8yyPdp6y46o9oeEtl8GNqTVofvxPvMRk5xfSNqFwW+oIrNYcXtMT+f0/X?=
 =?us-ascii?Q?1tVdMvA5lWYeW7cm4Xi5XtFqEkNMI8mqsQIAzDe0j/UlBAx4IS0sNo1n/0vx?=
 =?us-ascii?Q?FmYzF2d2F7W2GzMtSXl8/hQcJOHoRBEwHM+WevybaXM5fDHLh7/gqv6oPNl3?=
 =?us-ascii?Q?jkD4UZ3cMHzAnoIrV6QPvWuUvlcd+lNDjd+n8RSYonlGfFdDDNHHstKagOqo?=
 =?us-ascii?Q?qwZ/x+EuYiB81+QEkOnnGIqCJfvaX8BLyx6zFh6m3DssynychbOfLataZFwO?=
 =?us-ascii?Q?SxREwqTVLz0Wef1p1GQezAPkxFVUazWo579qwdotV1gIEH+yEWc9yAv4H1NJ?=
 =?us-ascii?Q?AfRufuU1MEHvU7jjGTy8qjjhFaD1+6M1+HzONfi1xyUS0nuodV/YdXuV93bL?=
 =?us-ascii?Q?Qhj12AdkXKMOnlgiNyEX8BnehqGCws+BIn8Fdj05PX9NVcP99G8/+xHdZseH?=
 =?us-ascii?Q?poQUoVdw0I+r+vsnpvjbq1L2VHEfsISSHaJKIqydbovISSrCBt4iOQ6wtlKi?=
 =?us-ascii?Q?EqvZw/vgIkHxQkgVo8dyNGfRMXxqTxCE6pOtops4dUuR4Levy24bNZlyKEdo?=
 =?us-ascii?Q?3hh/D0OJg1t1BMfrMYzSYo7RC5838xQokIV7NmlDM94rXUJ3rdkElwNF123f?=
 =?us-ascii?Q?4wvxCbt6C+NbekrS8Mu+mZKzdjVeWcc5YTCZRvtrJEmjIEOKa9atoiOsHm44?=
 =?us-ascii?Q?GjZZEmPFyvBUs7xUbd3M+wOKsAAi2kjazATueec7FhBfSPckEcn9f10Nimxo?=
 =?us-ascii?Q?0A8psmbmOIv1f3f+mtpt49wFWXLSdHSa47q72gWBB4Vu25WBpWfEGDbph15Z?=
 =?us-ascii?Q?2rt5dXk1CWju4zTYePJLat4FafUWqxGrBirg/ZpwAeRjgFM2p/JhEj00HA/u?=
 =?us-ascii?Q?aMGf8do=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:20:21.6580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9cbdab-3b48-498d-0df7-08dc949374a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808

Generally, MCA information for an error is gathered on the CPU that
reported the error. In this case, CPU-specific information from the
running CPU will be correct.

However, this will be incorrect if the MCA information is gathered while
running on a CPU that didn't report the error. One example is creating
an MCA record using mce_prep_record() for errors reported from ACPI.

Split mce_prep_record() so that there is a helper function to gather
common, i.e. not CPU-specific, information and another helper for
CPU-specific information.

Leave mce_prep_record() defined as-is for the common case when running
on the reporting CPU.

Get MCG_CAP in the global helper even though the register is per-CPU.
This value is not already cached per-CPU like other values. And it does
not assist with any per-CPU decoding or handling.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20240521125434.1555845-3-yazen.ghannam@amd.com

v1->v2:
* No change.

 arch/x86/kernel/cpu/mce/core.c     | 34 ++++++++++++++++++++----------
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index dd5192ef52e0..0133f88dfffb 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -117,20 +117,32 @@ static struct irq_work mce_irq_work;
  */
 BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 
-/* Do initial initialization of a struct mce */
-void mce_prep_record(struct mce *m)
+void mce_prep_record_common(struct mce *m)
 {
 	memset(m, 0, sizeof(struct mce));
-	m->cpu = m->extcpu = smp_processor_id();
+
+	m->cpuid	= cpuid_eax(1);
+	m->cpuvendor	= boot_cpu_data.x86_vendor;
+	m->mcgcap	= __rdmsr(MSR_IA32_MCG_CAP);
 	/* need the internal __ version to avoid deadlocks */
-	m->time = __ktime_get_real_seconds();
-	m->cpuvendor = boot_cpu_data.x86_vendor;
-	m->cpuid = cpuid_eax(1);
-	m->socketid = cpu_data(m->extcpu).topo.pkg_id;
-	m->apicid = cpu_data(m->extcpu).topo.initial_apicid;
-	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
-	m->ppin = cpu_data(m->extcpu).ppin;
-	m->microcode = boot_cpu_data.microcode;
+	m->time		= __ktime_get_real_seconds();
+}
+
+void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m)
+{
+	m->cpu		= cpu;
+	m->extcpu	= cpu;
+	m->apicid	= cpu_data(m->extcpu).topo.initial_apicid;
+	m->microcode	= cpu_data(m->extcpu).microcode;
+	m->ppin		= cpu_data(m->extcpu).ppin;
+	m->socketid	= cpu_data(m->extcpu).topo.pkg_id;
+}
+
+/* Do initial initialization of a struct mce */
+void mce_prep_record(struct mce *m)
+{
+	mce_prep_record_common(m);
+	mce_prep_record_per_cpu(smp_processor_id(), m);
 }
 
 DEFINE_PER_CPU(struct mce, injectm);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 01f8f03969e6..43c7f3b71df5 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -261,6 +261,8 @@ enum mca_msr {
 
 /* Decide whether to add MCE record to MCE event pool or filter it out. */
 extern bool filter_mce(struct mce *m);
+void mce_prep_record_common(struct mce *m);
+void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
-- 
2.34.1


