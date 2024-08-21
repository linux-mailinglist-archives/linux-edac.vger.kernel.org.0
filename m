Return-Path: <linux-edac+bounces-1713-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EB3959F2C
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 16:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B74A2B22277
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 14:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391CF18990A;
	Wed, 21 Aug 2024 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ot0OEB5f"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144E1547D4;
	Wed, 21 Aug 2024 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248837; cv=fail; b=brZAEPDp1ew9YY28zXVzAi+2MdCSbOEbj1DEfYyzFgLK9Msh6inBMnoGMvASHsXPFdidp7L4a2LNK7/WbxWpHpx9WMMTMg9ndGarBJXlCD42dzQLZa2UXliTYZvyYFxU1EIc8HnM+Ot/Mf9HaDe+oOhuM/RmvRCgsKv4pWlogv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248837; c=relaxed/simple;
	bh=fMVEMEhHCbSxeH7XSr/IA9D14GY0ZN0OxSS6RzIwC/c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kkKpob3wgMRcY93nKY7LEkUxAaBFsAr/mhzKUSxnj6WymmMMcQw27tQDKJtQOFTzzxZqUjHqVQKJBKe0DkYkCElXGQuJj5V9B4KX/wpR2Oe9MdPZjet6t9XJ4I8RPtNisvH5yiafPwDCeSPdmQ4mZK0Ab2l9Ps8MRmScWY6jM7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ot0OEB5f; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHygFeDT3I0XpdFV+wHzkaNzSZ3AC20JvC/hKDPbFRnMdYWqBqFg7TNmfF+/a+KC7tblxlDFtiq3G7QMzQXvXfwQX3KM1WMFsjGNjNH/QN29F6S4D19BNL7x2/s+Pim+Xt1OEVXu4UdM9h/dpVHizxoJW3SA+0+KzdMNm2PNEU2wHT+h30P3D/wIisXnIT1+yjfvbZ8JsvS0ejrukpd8pXjwUAFXjOUMwcm69FVS4EZEoCH6Eh5539q8rzHMxnH7OEStlbVsLesNcOdZ0xVozKNmC5tF4Af7wU8PHEjxg7VH6wyUEx1/9AyqSxOhh2ZF1njQucyTtde3X9rNugh/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNUsCb8NoiES/7ljgF3CDrm+UF0AXdn02NFsDviOEEQ=;
 b=CmpA2gFmJ8guXPMLM7okCGGwmmEDDKuQ2bNhMmxeB48Vq2mXStp0/HKTR4s8nTE+MrAi6kDQc1bA9yxsX6i6jmoSXivSIErz9xxvlZuLj7HArgPvR3er197+DRj6SiK+oDbQPeq5taYgEjCC4DGCqIUHF+zl7/G4AZzjROnysAuzkPsZMHNR3QWi/M63EfF6QUfTCSOSWGUhzjDQrYxeieoyQfmuYRuTt+CuZqkml34pMHhsMRjwYTJXctciTVJwKtwE77OJ5QyKCtHPInr0aHHY2Nk72a+h7HTCU0XghLex4cdnHGpXFDGef8lWOvukK/EpDI+YUWDjY5Nh3FWJWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNUsCb8NoiES/7ljgF3CDrm+UF0AXdn02NFsDviOEEQ=;
 b=Ot0OEB5fjAqN/QAzBJ4X3+lV79/aO/7dX1CXarIfMSBZTjNsx8tc2T6ngAy6PTLmCRxD7vqWn6d9W3xgA3MkBxhpu5/oDNEFMmfy6B9ebk4msfWEelSwLgl+S1c5ViJcm8M/rZJnbHYqFdpjGaHbfO/vtqEeiQu1qo9NUanxMFA=
Received: from MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 14:00:32 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::31) by MW4PR03CA0139.outlook.office365.com
 (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 14:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 14:00:31 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 09:00:26 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, <boris.ostrovsky@oracle.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] x86/MCE: Prevent CPU offline for SMCA CPUs with non-core banks
Date: Wed, 21 Aug 2024 09:00:17 -0500
Message-ID: <20240821140017.330105-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab1dafc-be28-4b48-57fc-08dcc1e99f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMgMaDRMSszGgxcf5/jHo3yyvtp/+aVjnm/gsG2LoQGjQi46F5Yo58CZ9WkU?=
 =?us-ascii?Q?cXz8ZO9z0kQE7qck59SReFM2K5zkKPdg8RNehD3mfm9tEMVJNI0Hn2Wf+IZD?=
 =?us-ascii?Q?0sqO5GgkUsL3zdT+7Bii478NbdWfDkLgId4C0IpDLOLWoAqGOFqcYoTEU7To?=
 =?us-ascii?Q?lA/e6F8YKriV51lRMgwTJv8lqGRyc8g/di57GO9j/IAng3I56FN6XOxO6pEM?=
 =?us-ascii?Q?0CtVc2WvrCwbExDs6IhxJjRT4cWDlzu7q0GTAlK/hBscfuYkxSG3zmAOS8z+?=
 =?us-ascii?Q?7jyukGCZOdK2u6jqZr9FOqRz3fJzIgAmqWxcNd9dX/G+HW8RuCqj0id+yB4J?=
 =?us-ascii?Q?B8ScIf3xuCXvuXcMOOWZTkft1G/2vV/4CouNqYTecHQFr3nMrm8mopQhZPa8?=
 =?us-ascii?Q?fmMhU0IOMs5sCoOf1+d1iFok9C9rlZkzhMJO1xgNPWhZv7ZdtY3OthrGysZa?=
 =?us-ascii?Q?6yIR4hD9h6lFkgQCdStUfzyUd1jdDC8osHy6egM1AnwFtFCWL34f1OvMHIfW?=
 =?us-ascii?Q?zMTIWhHTgshh92F9DNhucMZhOn14v0P3xXJxi84lhZ+MeLJD9ZpxJgjU12kg?=
 =?us-ascii?Q?TliEO8sFLDUQoVHdEcuNBdtUYJIpjgWOtoKV9zrcgdFAIXrOu0YTp5pi3d0Y?=
 =?us-ascii?Q?jCjj7R4axuy9Lgy730vSpnE52s8C9o90S8IPof56N2Y4NmNV3CxYIHXglZir?=
 =?us-ascii?Q?cpuLjfFkmG8kxKZ3eTMLBaHawQhGFI6Nj9wH7fnSfMTy88pgPCCuXEPbpkk4?=
 =?us-ascii?Q?5V7bUc3d7vfip/1+2u+SeZFnFizdfHaR/Pg4xXpqUsnQQVcOp0kaJ1WfJSpO?=
 =?us-ascii?Q?MBxfUH3r8QtDo4lkAfc4a2OYvg0nsnzyhowejm1MN+vLtWiMI7LERf8HBfw4?=
 =?us-ascii?Q?FKBLGOzWcGhexfxSMwo8leWdtYT4qYIPhN2/nmhLUihdgX8gfn4DelC/UpdW?=
 =?us-ascii?Q?bQFAQHLjHjX87tEQiEssciSLEdDrR3cbn9NGh8OrONpixTnST6UiPfYXFRvE?=
 =?us-ascii?Q?OOxKndcROGv4nM0rcX5sRZlfHj3TKAiNLoGMwS7QnLndPGGUkGIDptiCxwMX?=
 =?us-ascii?Q?WVIKVhI/yctPweoKptqG/Ybi5g1Uoyg8R/TvNuf/RRxN3ZHDGOdnV8yBn8Ri?=
 =?us-ascii?Q?THCmzvHGH5i0NIDHD3dQ0nCIC+znsdOfmRaebTnNEL4u0ZlUfYtETws2YaJl?=
 =?us-ascii?Q?/nsg66yCcwZqcPyfyUZKcWqtY77sOeLZ99565RdXqxcVxtpdJ+OIUr36eo6k?=
 =?us-ascii?Q?rWTIVzwMDs0Rn5E7+Dago1y53Rh8gUI60U0bhjVgJuGt6zL0cA9pMa9KLvig?=
 =?us-ascii?Q?MKgi9cgc9OFqysKRW3PrcYzG4Xtzjir5LH9qWnSsvkn4tNxMOdEBqNjYgAck?=
 =?us-ascii?Q?ikCNimefvGOFLhTWZf7/nAyvXjQxWwZuGLKNvbeCEWTVUGLJeeT5XQ+BKz3U?=
 =?us-ascii?Q?5L67hNUaS5zlWnAF8W2dW4w7Nn+dqT3A?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:00:31.7819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab1dafc-be28-4b48-57fc-08dcc1e99f0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439

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

Check if a CPU manages non-core MCA banks and, if so, prevent it from
being taken offline.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2a938f429c4d..cf1529d0e6b1 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2770,10 +2770,34 @@ static int mce_cpu_online(unsigned int cpu)
 	return 0;
 }
 
+static bool mce_cpu_is_hotpluggable(void)
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
+	 *
+	 * Check if non-core banks are enabled using MCG_CTL. The hardware may
+	 * report MCG_CAP[Count] greater than is actually present, so it is not a
+	 * good indicator that a CPU has non-core banks.
+	 */
+	return fls_long(mce_rdmsrl(MSR_IA32_MCG_CTL)) <= 7;
+}
+
 static int mce_cpu_pre_down(unsigned int cpu)
 {
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
 
+	if (!mce_cpu_is_hotpluggable()) {
+		pr_info("CPU%d is not hotpluggable\n", cpu);
+		return -EOPNOTSUPP;
+	}
+
 	mce_disable_cpu();
 	del_timer_sync(t);
 	mce_threshold_remove_device(cpu);
-- 
2.34.1


