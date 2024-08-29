Return-Path: <linux-edac+bounces-1752-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ED89652F4
	for <lists+linux-edac@lfdr.de>; Fri, 30 Aug 2024 00:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA2C284265
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 22:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7BA1BAEC7;
	Thu, 29 Aug 2024 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IEZIQoXf"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73718A931;
	Thu, 29 Aug 2024 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970765; cv=fail; b=l6sIL8sH83KgdoEZqtxb6TEC06NCDdWkptdwsa/SXAfm8iouAYaW+XS+u51KJzWL1CmNQqSK4NRdANazHIsZgsXYADkItPPfSRCYYp4a6vI2gP19oUBuVgqBSpHkjoDnT5j2It9qEu2zc5MNl2pj3zXKm9GEJvfTYfZLPZbbepI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970765; c=relaxed/simple;
	bh=kFWEYXELWf0m+oqsIAUGR+2MFTFMMR2VMObST6+a2Wc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mf4tkWpWBpipQq/ObVqUkznMgNJazdL6rnf58bRAxmCe5jQIYk36iwORJvqdP5Fx9zH2FgxNWOJvO7b09P+Fr9ugRhYyHJb/W3xGy8fbypzehiqnDBt9TogCDdY2vc2mUgV6QJDknByoRKEV1PW83IPVT5QVfW/tHS4l0+lCxCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IEZIQoXf; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivK6lNWPqkxcfFJ5vdzlBR1DUs9klXNb4b9ZVBNy63q0ICJbY/pNXHuYK6JSx8WvGh8I8EyY0tL6/s6i3olVW4Sr383t+Q6Ot0lJeSUHXkB+vv6bloj3mJHUa1lZsDoaGYg4AqT+z2mAFRl7OLz29JKPmPAJDavIOSA+y26Cp4BVhCZOFFkJ87H7u6Vr3WdoTNPnz/IQWpUxQFiLDIL/H+XxmBWtEV4R7jdD2QWr3tySFJ6P1SW7q0hbpu9s7xdnDzQgvYcLAVWnRJFYWmCgzzmIPBAWWDDfyvGZMxrMygYoguOomFymGmBSD2bVHz/rxSxikVQXj5K5ihJhP4ycJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHTxRnK1qu7Y4duV7zsa8+nJU4IkZixiGFA6F70jsL8=;
 b=cUMfsxaalsJBLSOxsgQdHD/m/GEUnseJynC65/hk4kzQrWbIkyOD/+NgviRgDyDsDbj2d8ZUC2JrKp2MSSYnqikEFtDJOe0MbtQGzITy0QFzxTAcwQ5EFVVOyK0zaL2nsTsk2V6gXeU08vBGhLGwbxAktIR6at8JFJwYAMrguIcaEXz6IFSFr5z5+uWvYoimPxt7iBK3999qkf8Hwf03CrzLGQz7xBy+oW61VbjpL9agF7+jbWZvJ+RPgkL9tcBbttke3frRyNEs80T7HNDcjZoRzBdMIoY2jicCXQONPqDtEDGpnr8VcWcKoDywEag82T9dCBezyKe2PtxvyasGkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHTxRnK1qu7Y4duV7zsa8+nJU4IkZixiGFA6F70jsL8=;
 b=IEZIQoXfKLTf+kYuH81DWc5QC3GSBo5I/t/VIoJultN5YV50BaAmfyv3tUUbb8gvst8lKbDZE9lxb0+dwIuihgw3W1Hkhx1S67sYoIlp3HwJE/FdQRPCEH4xoinNe49XXTb26ro+cgZBWZto7Qcu0nyHG0z0dDN44+10ZlSqa8E=
Received: from BN0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:408:e4::16)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 22:32:39 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::de) by BN0PR02CA0011.outlook.office365.com
 (2603:10b6:408:e4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 22:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:32:39 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 17:32:38 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, <boris.ostrovsky@oracle.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [RFC PATCH v2 2/2] x86/mce: Prevent CPU offline for SMCA CPUs with non-core banks
Date: Thu, 29 Aug 2024 17:32:25 -0500
Message-ID: <20240829223225.223639-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829223225.223639-1-yazen.ghannam@amd.com>
References: <20240829223225.223639-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: b20b7ca9-7b81-4b79-9004-08dcc87a7da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hkrFyovlGxOi54aoD8IwVwZZe0yx5EaL3LZ4D3Y9uQxWxoqFVHgbF4/XFyzg?=
 =?us-ascii?Q?9ExLHqzmKpFgoHOpVRjZKqEpdca6Mr+ZbMcVi6KWBl4p5CPVLQXyfUhq8xOc?=
 =?us-ascii?Q?86K7+c6fA+U2D7hUgB2mQus0PULGI9SnlSlmjvz6B2twR60ddMGkSgglJ/RA?=
 =?us-ascii?Q?oFd7rdl/17FtNjGLxotXTeHU/ijyf68tq1yQjH3zpkLZWkPpPTpVO1ftFm5T?=
 =?us-ascii?Q?QxfvrIacWvr0v9vDo4Ss2PAeZYcX7id3QE3beQi/hZbe4A39oK4xo9eMT9We?=
 =?us-ascii?Q?s/mwZcKnFxVlsBLeARUbeMdUwlKT8c/tImMj+XaRcirvnLAdq/K2w2WKBkN8?=
 =?us-ascii?Q?ESCg4LKOA0+GZtMxU1Hv75/g2rg2nbwVzda9ZCwaAa3sAo5bkDT4z6T5cTeA?=
 =?us-ascii?Q?3lBiVnrJCDogsU7Lc2xQCY3tP4pNPlP006/FLC62xRAigFvWUePjArUjVZki?=
 =?us-ascii?Q?kAQmFDgeWJ+L4RCzy+ryqIP+WB9YPsJwOoAtd6NboWucsKCsqryJVqwUXDx+?=
 =?us-ascii?Q?AUvb2MpG1pUbEyP+Kx8uA4WNwYngTg8YF4siObYgHKi3fu91vgOvw4+51iBn?=
 =?us-ascii?Q?D8elKcOpvhS9s2s4Boez20AmL+GttvBJWU1ZBQ6A+sf2k3uDf6D6MG6DHGhu?=
 =?us-ascii?Q?DnCId9d83X73OoXf/DI6n/3J5ySBSoWblEjr2tGSaD1SJpljgnoWGlg3U/qB?=
 =?us-ascii?Q?MZnpNgwXfanHC2wSF5T0bCTErFHTpEocaeYdZDy55UwGsiWc0YBGxDsJr8iK?=
 =?us-ascii?Q?bqGbvPNn9znVB8ZAkF3OOHEKMm60Poo7lr/KfPXwke7YxNqC1XlQben5Sl/g?=
 =?us-ascii?Q?zgRMk1Ar2YNZ2XTefAgnue03nzh8fHLj4HhjdqdcIaTqz/6hkHw51Vz5zOQb?=
 =?us-ascii?Q?GHEhs5mpR9ZOBhSXxMoba7+sph6EoZ4kWBparz8Q1REvil1ofJim7zP+q/lr?=
 =?us-ascii?Q?q8mD24s3B+hQw2x/AoC0J17rALmjCdirgBGD5r+OSCMntVd42A4xoD8NsSM6?=
 =?us-ascii?Q?UC25dYJZzxo3hAHhpu5a1+UmaURfX3hEdRALx7WI3wLprIZnyjOj5DTiHUrq?=
 =?us-ascii?Q?cIpltdms3IdTS6/efZCQzvRMOPxHJaWS8JEnoPmjs79TAtGQA6BQaRcmZ4qa?=
 =?us-ascii?Q?5ZafrV9fcfZPHuta0Gj8HMFN4SvpTsowrXTy39MzS8/pxDkz82GZzV5pAsqS?=
 =?us-ascii?Q?e+yOkDr7/LtPYCdI2uUeqjH4SUbRNAv1uaqprQOrVVXfRXDdiweo7CW7mD3F?=
 =?us-ascii?Q?9UCmf9rpfrzZonNHsDDA5Ph8I7aFf/1hVMRT9C6Ewra2jxZqN52sOFBiUHoQ?=
 =?us-ascii?Q?aWaahoSVKV9J/xAMipLPI4pFnh5xFVybzJkyRbnGlrgs/xis3WHMsnIwSJrQ?=
 =?us-ascii?Q?nVhGqo/VAxEYpubdjV/5nQJYMwUvfqoVlTDPYLp4fOFI0GHsXMZVX91nvEw8?=
 =?us-ascii?Q?IuDinqvVVIM0Us2rwpqaQn2oGkQgNMqa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:32:39.7369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20b7ca9-7b81-4b79-9004-08dcc87a7da6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967

Logical CPUs in AMD Scalable MCA (SMCA) systems can manage non-core
banks. Each of these banks represents unique and separate hardware
located within the system. Each bank is managed by a single logical CPU;
they are not shared. Furthermore, the "CPU to MCA bank" assignment
cannot be modified at run time.

The MCE subsystem supports run time CPU hotplug. Many vendors have
non-core MCA banks, so MCA settings are not cleared when a CPU is
offlined for these vendors.

Even though the non-core MCA banks remain enabled, MCA errors will not
be handled (reported, cleared, etc.) on SMCA systems when the managing
CPU is offline.

Mark a CPU as not hotpluggable if it manages non-core MCA banks. This
prevents the CPU from being marked offline from sysfs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/core.c | 15 +++++++++++++++
 arch/x86/kernel/setup.c        |  2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3b9970117a0f..bd9ac102ba49 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -213,12 +213,14 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_clear(struct cpuinfo_x86 *c);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 			       u64 lapic_id);
+bool mce_cpu_is_hotpluggable(unsigned int cpu);
 #else
 static inline int mcheck_init(void) { return 0; }
 static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
 static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
 static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 					     u64 lapic_id) { return -EINVAL; }
+static inline bool mce_cpu_is_hotpluggable(unsigned int cpu) { return true; }
 #endif
 
 void mce_prep_record(struct mce *m);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 33893b5c8b0c..2f4a04092dd0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2775,6 +2775,21 @@ static int mce_cpu_online(unsigned int cpu)
 	return 0;
 }
 
+bool mce_cpu_is_hotpluggable(unsigned int cpu)
+{
+	if (!mce_flags.smca)
+		return true;
+
+	/*
+	 * SMCA systems use banks 0-6 for core units. Banks 7 and later are
+	 * used for non-core units.
+	 *
+	 * Logical CPUs with 7 or fewer banks can be offlined, since they are not
+	 * managing any non-core units.
+	 */
+	return per_cpu(mce_num_banks, cpu) <= 7;
+}
+
 static int mce_cpu_pre_down(unsigned int cpu)
 {
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 5d34cad9b7b1..754089334591 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1222,6 +1222,6 @@ __initcall(register_kernel_offset_dumper);
 #ifdef CONFIG_HOTPLUG_CPU
 bool arch_cpu_is_hotpluggable(int cpu)
 {
-	return cpu > 0;
+	return cpu > 0 && mce_cpu_is_hotpluggable(cpu);
 }
 #endif /* CONFIG_HOTPLUG_CPU */
-- 
2.34.1


