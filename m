Return-Path: <linux-edac+bounces-1590-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C864A941F8B
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 20:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7DD286008
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A12218B47D;
	Tue, 30 Jul 2024 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PpFRhiOm"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6F1662F7;
	Tue, 30 Jul 2024 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364218; cv=fail; b=sAAM+euGR9hsyFYZVvLpM9TOvWI7pyLf8RogP03y2meLp4YYMU3ebIqvixDnHQ3/06Ki4SwC11lUTzVx6JZBqkif3O6MO3sL3jot20vp7CEdOpHuWI3bxzvXTVDpmEBnG10cusUwhxFo4PHk9EweMq7b4oKUY/8HMbmUgXNVr6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364218; c=relaxed/simple;
	bh=p5+6VkTmMKg3gndnexO04YTKHYMfKfFd/L2f3Vc5YT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MefsGR33/ghfN5Hn6ABnuVbKWe/E0LHqdVaqX17XwS+HwUeiST71FvHqQzP9hT7G0v6OOJel7+vLrnetrYHLvk4WBapnzm0ookvNkJzZRpBJ59Ycf++xbCFaE5/7fI6U6NGiQuJ5+oBFmamqiKuiohZVySC7M+O8Cp6yIDufw0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PpFRhiOm; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbnNsYPUxzEZ7yvQUqRHhVWKkbAkQT+gYSzmMWCsaD2ZmPlLZ3PO6uGa9peoZrbk60zPCpscCvx/pKMv3D67dmuTtt/cX6ZJsXSfn2uXt7P1a7xON0kh0M4C2DJz1/Zfljrdr12lsJ7SP3O2BUlEc+OBAtzykfGSy4+mVOc6C4rWZ2ibEVUFtqSUlj0xKjqOyLAeXidlUhiKbHSll3yeIzpF2HpMg98TPQe1Pg0rAi2JO8Zo7l89kqEDbP62UC9t08kboq0bICj1sUvo4Tx9ArfxTVPn7vzaxuRpdho9l6JKq7ZD6vxjBrsJ2Nga9s9arj0mZMQ1t4vKWq5lCzOHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcXXFJ7akCeBJaR2OkVi9BAZI+MrbVLCmIFcPyWEkJI=;
 b=PjFsm5I5rK50vRiLThhDU5XMyef5LTj2vOo3p15GoCD5MQdEWI4/Z20WMkTNJatlHak6cQX9uSG+0lTOAkJYORrv/aBLSJOud0aocOJ+FdAI07o9rLnJ+gl1y8220dVHyOSn2iQaLrTyNxfXPZd/Frv/yfbXrZGM4G0HuGKejBvCNoT5IJTKHiBMR0gheTzPNgvqQDBylUag+6MjWlW9D912YJUDSsnsLf/o+VLM2yVtIT7UssIJCy6cBDPtxnnXWNKXHWFkaTFZe/i6x4dvVqQxsT+S2JX1hbKUR7/9jE195O81vvAD6V0WujDO64NDeBZc+fbwti8IPu4Il6lX/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcXXFJ7akCeBJaR2OkVi9BAZI+MrbVLCmIFcPyWEkJI=;
 b=PpFRhiOmgSW6ozX3GURFlhi/XweOyf5o9cMgivkKCD53AM5hTPEvdZeVMYeHKQv34muxyZHTl/qTKvt2eDKpUK90YGe0vq6mhtghJBIraSvzWu5LGZrgXgQDmpqUwKW56U0+e+FqDGQzThr9+sT78zrItDL9Zv3dZcKRO1ybPHQ=
Received: from SA0PR11CA0018.namprd11.prod.outlook.com (2603:10b6:806:d3::23)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 18:30:13 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::b2) by SA0PR11CA0018.outlook.office365.com
 (2603:10b6:806:d3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 18:30:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 18:30:13 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 13:30:10 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v3 2/3] x86/mce: Define mce_prep_record() helpers for common and per-CPU fields
Date: Tue, 30 Jul 2024 13:29:57 -0500
Message-ID: <20240730182958.4117158-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730182958.4117158-1-yazen.ghannam@amd.com>
References: <20240730182958.4117158-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH7PR12MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b74e8b0-dc71-46e2-ef64-08dcb0c5a6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?su5vDcc0274DRDRHGw+clI6B3DAioQDsiGR5+YScuaHxma9R/d9pBKTYAZiW?=
 =?us-ascii?Q?L18ciJos0r04ZGS4gj8FFfu7hpKps/mKDLtuEHXOUIb295D0ShTgJjJZdbVB?=
 =?us-ascii?Q?5osgluFVHE3DSTcrbyZcHTbrrYESDsjYRh+3SUFOnGujwdMYIvMIBeCLn9Ij?=
 =?us-ascii?Q?Qxa7vujrMvPEHZx+sugDdaL7vRpdz2drc6Xo7N1fTFgRNEdMNjqcH/SVU5zg?=
 =?us-ascii?Q?am/YAv2FHAW7jmi3pIxDtYTE5MYKULypCyFJxPT8/m+kkVt89UpN3FprecSQ?=
 =?us-ascii?Q?Y4BREq2pI5GJxYajglIvUxfIHrYnvi2FJ7ZS3Nu9r+2iQAGr9kWXoG9/q1cQ?=
 =?us-ascii?Q?/QWYxb+P/MakR/YvHneLSj9L9/uY5LVJdyEXY93y+itJwD6XJn/zkWbj2igx?=
 =?us-ascii?Q?XxXE3fGH1j9HXxVXFbE9c3wXacY38qCyXVOr+wnJEZNaNvjD46G1lC70FuY9?=
 =?us-ascii?Q?Na6bX2vA/ZzrWLOzEjlMv6eYDhabfZYttuGdpcqoTha63w9zTQNXMWaGpwls?=
 =?us-ascii?Q?bLwasm23Dw1mq0Nn6pNpH1HKsFnroiH+JPDEBLTlWP2/4QQ58VoAHbe/wTxp?=
 =?us-ascii?Q?Ks5Uh9f0XJ9ZrBhVQDz/cJW/uzMFU8GWpH3jD9xWXSPWlLxKaAtwbUNjvTyD?=
 =?us-ascii?Q?dQSWUjDm6Je8j9V0xI1nhNgh0nu4tEn0PS1cOzgE5MSB+O+LrwmphVErB5RE?=
 =?us-ascii?Q?cFJnblmDhjQ/LqXrNWvF1lMkmQHv805OdfqIs8ID/UbN5N/5x5K+isDsNTAI?=
 =?us-ascii?Q?2+3GyGy6NrjBN/kVGoeSZOKMbe3Fb0b8mQe1uYl97uPVf/EnNUONU8AQA/GY?=
 =?us-ascii?Q?hQvhstXmNFHaE8+yhKd5uDleOp/Xthq+MhSay6n6RwaArfNLRlI6twXDZgaz?=
 =?us-ascii?Q?nmOrioQ1jj20hZL+gJ4QS0YyX9TZPAR8D89aEeKzPFr55AH0EqQbHQgY3CJu?=
 =?us-ascii?Q?1B5uwVIMLzsIrFZyfH7346I6tw3VRdulMRCeStuYdEeGmoIkyW4YkZ5IRYc8?=
 =?us-ascii?Q?Lt0aDDBVEvZQHj4lDT1BRDoGBSFUT/+li8VZG68Iwdpe1dYXc3wp4bBnARM6?=
 =?us-ascii?Q?oTRU1qENZLzKi2+Ur4STl1a+IcwdnQVT0aKqU9vlDk/VTAqsY0tORC+2mVEw?=
 =?us-ascii?Q?//ykxTAJHFCaFNC2nZaROHYMeYJr/OAy+/vi+XTC5MmAv+ocGC+CeFhrkyai?=
 =?us-ascii?Q?0ua9p3IBDbBH0qYQJnxvHDqZf68o2V9ycD3OhNGMPcPWguC8bWCn3U/4FhGt?=
 =?us-ascii?Q?3X1Tpxe1OX19hSl96rhV41ilSXy49+We/gjD7HR5PLDL0a625LdgdXzhi6Eo?=
 =?us-ascii?Q?gt2GkDHLrnbLOAFK9+m9LUfr+9EIEv5kCsANHjJrzgGcTDPy9GGg9rPNt6cj?=
 =?us-ascii?Q?i9H3OgT/vTI7GSCxDr5YplIRG/yENEx/mAzNQu7x85pj/smqEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 18:30:13.5102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b74e8b0-dc71-46e2-ef64-08dcb0c5a6f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859

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
https://lkml.kernel.org/r/20240624212008.663832-5-yazen.ghannam@amd.com

v2->v3:
* Use topology_*() helpers (Nikolay).

v1->v2:
* No change.

 arch/x86/kernel/cpu/mce/core.c     | 34 ++++++++++++++++++++----------
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index dd5192ef52e0..2a938f429c4d 100644
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
+	m->apicid	= cpu_data(cpu).topo.initial_apicid;
+	m->microcode	= cpu_data(cpu).microcode;
+	m->ppin		= topology_ppin(cpu);
+	m->socketid	= topology_physical_package_id(cpu);
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


