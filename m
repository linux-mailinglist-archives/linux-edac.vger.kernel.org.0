Return-Path: <linux-edac+bounces-3543-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE043A8A1FA
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4403AD3C8
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A2F29B215;
	Tue, 15 Apr 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dye7nOol"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305C129A3F5;
	Tue, 15 Apr 2025 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728917; cv=fail; b=Nt7zxNGFckU1xgEkbWSBExOIG+cbIBMMv5z2kWoEWtgJuzMCVAFwybkBKmLAOLut69l7/KrCUi+Hlf6LrzgyyumBUqKMKZjikpK1a2pCdNXuyTSAciOTXkRAT8IYcixAiq2eUPFedO9vMaf0GofrZKD5FyIfWo2NuJlLL1SirOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728917; c=relaxed/simple;
	bh=0XmFDAjI80iDMkCDTwZ35rtQgf3daeb/6n4QMtkNvqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Tu7u+zWxmBvOwK9vq//5TiAfY/yhNjzlFwhsndHS0xROvWrZ0dOZ9hajNkDk2/94ciAlFyPYQw7PSszPNnlHDjQxh3sEeSfLtbT+1WB73RM8XfvWjanfWgdo3FOzLoGhjw7JxaeB9uj17zEkce8v5tGQr9/3MO7ufOenKRNP2Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dye7nOol; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bO3iJXfcqkWcSy7TKncqfX83hJDAItvhCCr6eBLb+pKDdZNPjY7tGykbOGXI4NEj3rHowHN94tu8EHsWtn0QVvaScnQtEb2qSsJeWSHJ6ZppCznPz6wD7dRBMo1o/+0K/DvARFWudfZPv4pl6ANJ4p2AckZhaWRbcLxV7Z1omBaDj42vAqed2Py5cWG/s03IcvcLaBDvvE8bQpFfEJNAngfUlA5nFa2jSCw/9rYY9L1xqzK5kMwu5Ovn0QAn/UtuE2SAtwWdoux+68PTC2EtRvI8gbKn0FnpHQZf57AHWf3JBnLw/gGAj+RiKJFBHZS2zpQ9WghY26MBWcv184KzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7OukUcipecJdGuxyE5jETyxT81POg50oIDVufdsegM=;
 b=aP0i3Pk1xtMPrdYeLYR/1s3VIn0hgeMBljrZQLMzsCBdvuS5+N3+d/4CzjfHkrbpDdvg1XTiabNCP1WnBp2NxxRWyP6SZdAMoaiVl1yeBxrJ1w0r/YevVPYtdXc3jKutBb7VtNVcUlk3V0dGajMsFAzhrZsTGdHQo9P9TEkKp9lFVjWLZwKK35LkJC1x5ieOXYASq1LGsm5y2vTdwMtDV12qzJu8uQAdK687MTQbKSVsr4N/smjE9oaFjzYhpkOMv8XUz3q+6GH/GQa5yLM89n/VB4qZgw6Vns37fHEARwRr80mk7lUEeU4e2JrgfcLKLOEElHNuH3rOL3/0BEjZ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7OukUcipecJdGuxyE5jETyxT81POg50oIDVufdsegM=;
 b=dye7nOoltYfdQfYISMHPi4Zqw6qYLKk2yZ2Y4C4Yx7xKNJ3pfXckXUtRC3QHGa43IgL1sRazKXo5cKxTVIOQ/hY65VR+WFIyB2EIUpKoTbZHO4cyCCi9qJnakHBPErZ3v/RmOrqViGh48KYfrAXrmlIeBV+fTIlcrXcnLo2n4yc=
Received: from CH0PR04CA0112.namprd04.prod.outlook.com (2603:10b6:610:75::27)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 14:55:13 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::69) by CH0PR04CA0112.outlook.office365.com
 (2603:10b6:610:75::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 14:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:13 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:11 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:54:57 +0000
Subject: [PATCH v3 02/17] x86/mce/amd: Remove return value for
 mce_threshold_{create,remove}_device()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-2-8ffd9eb4aa56@amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
In-Reply-To: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ddf246-7905-4f5f-c186-08dd7c2d86cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHpZaWxOcEdhREUyYWNBdnZZZEtUU0wzd01rRWI4amVuMWlQY1VQa0RLNUFv?=
 =?utf-8?B?Ymhhdm5TMExXYmdzLzZKckd3WTdHT3BDdm81c2dnMkZXb3FiUDc3NzFWYzRG?=
 =?utf-8?B?cS9WaS8rbFdFVXpIUDRHc0M0OWtvMWQ5bWNUN2RtQ0ZNQ0xCSnFrS1ZJemxE?=
 =?utf-8?B?T3RLblh3TUpaczFIZDkxd1I0anYzOXl1NnN0Sno3cXB4TVd4UExRWU5obFg4?=
 =?utf-8?B?T2xCT3dXa0hFVDdGRHBmeURFSUVaT0V4SERoc3gxTjlJbnF1SS9FZVdJdVI3?=
 =?utf-8?B?TjdCSm5odlVCcURyUkM3Q05wQm16clkrUmpVa0hRNnUwQi9Ya0hJRzZhajVI?=
 =?utf-8?B?TE1TUnp1TCtDVjlHVWszTlhkR205eDFYVDVoSWNjdUVra0laa0lxbmF4bUpS?=
 =?utf-8?B?WXdPdmFMS3l1dnhSWGk4aU9hOEhoQkNOeGtPa09IcmFGbWlWRDgvOWZrTEM1?=
 =?utf-8?B?OUFQTmxzeFNxbzEwbXFqMXN3NkZxYXFwNTVyYU1WU3p2bkxXMko4elZZZUlB?=
 =?utf-8?B?QmlSc3p1bVVSaVB0aVd1cWx6LzZhZzdnTXc4Z3hidGlJVE5XTDRValJON0lC?=
 =?utf-8?B?QVhkZjdtb0FvSjJqVWRQelpGVmNWYUVKOU5aMXpQWlBwcHZ6TVJLWWJVK0xo?=
 =?utf-8?B?WVRySlp4TnlFSFpXTjQzdk9nRDFNekFYRHQwMGE2RWxzbGk0N0tPVmtJSEdp?=
 =?utf-8?B?RFBDQ1hQZU5VTEcyVTZtK2lWQmVVYlBSdy84U3YvRTBPWldiUkJieFNGN2J6?=
 =?utf-8?B?MC9HQkJzVDFxU0JGODRmbG1ISkVnY3c4dlluam5TbEVqQVlONDlvdE8wbUhx?=
 =?utf-8?B?N3B0YlljczU4OU9rRmdzN0lHRXYvaXh1WkM3SXFCQXRWUStNd2tBajkzQ2Nj?=
 =?utf-8?B?WTJPekY2ZnFVNVRlVllPalRtbWgwY0RzSUhpZjN5VFNPL3A5enZ5YzhGUm85?=
 =?utf-8?B?NlNqV24vNzNqbGVEckwwZmhzcG84ckRsQk5FQkthU3A3L1pwaGNIWDhTcDhm?=
 =?utf-8?B?cnRKNE5EWEZqTFdtVXhXQmVoSlp3UEREZUJhem1LNTgzMU15bGRVZ1dORDU5?=
 =?utf-8?B?T0dRd2NzRGZoMzU3OXVzaFhCa25YMmFFR3BKMGowQ01nYk4zTGU5YkJwVUty?=
 =?utf-8?B?UXV4UWdkR29LcVdSQ3EvQzNMbnZmdHJrYlJhTDlUR2hLK21HTlluSFBzTkMz?=
 =?utf-8?B?anBwRkwwQmw5dGY2NDVFS204WlVEUVNQbS9xZkZXdmNSR3gxaTBwUm4wRHJr?=
 =?utf-8?B?QVZXcFkzdElLNXJRZnpkSXRnV2UzZDNOWGIwMEZqcnJoY0c1Z08yYndWekpO?=
 =?utf-8?B?YWVFcDBibmtPaEVRTFpub2s0d3dsWlNyWkJsNFpMZ1JrMDhKRFd2VFVtUXRB?=
 =?utf-8?B?SG4wdGc4dlhtMkNrRm1SbjVmWTNxN0h2bUJ2VFNOVTdYT0dDT0NNQXBXWUdy?=
 =?utf-8?B?dENxRVZqUmorU1RaUVhVOEI5d2RkUFJJQ2dYdmxzKzJ1VlZaWE9BQ3dwODYy?=
 =?utf-8?B?MUtzWWJpcXFPMmU1cDRmS1VHSVZTQXlvRHVvdndyVVVOSTV0Mjc5czVFZGF4?=
 =?utf-8?B?M2creTJndDFxRUZzZ2NNekJkQWJXMEhaWllqRFp2Q1hXaHZma296WmIycWNT?=
 =?utf-8?B?RmVrcmFTTUx5RkN3UFBNTzRFSitDL2RFOFdHQ3BKR2txSmNacVcwMkd4Vm13?=
 =?utf-8?B?cGFaeEgwYS9TWjJKdWkvY1ZWQlFYeklSVG8vYVJJdWZTU0RSUGdHY3pWK0ZD?=
 =?utf-8?B?QW1LbVRLejZjdWR5Vy9zZm9PdUtuZFlOWFAvVWJpMk55MEx6NU9NMUtOUWhv?=
 =?utf-8?B?Q1pDdU9EbllQN1psMzVldEp2QklGRXF2aG5CNWFURmhqRC9EcWdSSm9XLzRJ?=
 =?utf-8?B?dFdFNlNKODR4dENxUkdsSWtkeGQxcG1ZanZJdS9odVM3UnJwQ0hyWHNiZmZk?=
 =?utf-8?B?aFlDaStOdnlZT210Ui9SU3RGVkJvZ00zLzFMd1ljUkx5aG1yWnBldURhYUNF?=
 =?utf-8?B?TDQ4SEZ2VFltc1liQnkxQzhjV2tZYlFnZlNxa1hYSHZYeU9vaDgwcVo2cnpi?=
 =?utf-8?B?RnNselorbTRCaWgxV0N3RFVzV2syZzAvZmxLZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:13.2791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ddf246-7905-4f5f-c186-08dd7c2d86cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765

The return values are not checked, so set return type to 'void'.

Also, move function declarations to internal.h, since these functions are
only used within the MCE subsystem.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-2-3636547fe05f@amd.com
    
    v2->v3:
    * Include mce_threshold_remove_device().
    
    v1->v2:
    * New in v2.

 arch/x86/include/asm/mce.h         |  6 ------
 arch/x86/kernel/cpu/mce/amd.c      | 22 ++++++++++------------
 arch/x86/kernel/cpu/mce/internal.h |  4 ++++
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6c77c03139f7..752802bf966b 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -371,15 +371,9 @@ enum smca_bank_types {
 
 extern bool amd_mce_is_memory_error(struct mce *m);
 
-extern int mce_threshold_create_device(unsigned int cpu);
-extern int mce_threshold_remove_device(unsigned int cpu);
-
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
 #else
-
-static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
-static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
 static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 #endif
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9d852c3b2cb5..7ff479c679fb 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1290,12 +1290,12 @@ static void __threshold_remove_device(struct threshold_bank **bp)
 	kfree(bp);
 }
 
-int mce_threshold_remove_device(unsigned int cpu)
+void mce_threshold_remove_device(unsigned int cpu)
 {
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 
 	if (!bp)
-		return 0;
+		return;
 
 	/*
 	 * Clear the pointer before cleaning up, so that the interrupt won't
@@ -1304,7 +1304,7 @@ int mce_threshold_remove_device(unsigned int cpu)
 	this_cpu_write(threshold_banks, NULL);
 
 	__threshold_remove_device(bp);
-	return 0;
+	return;
 }
 
 /**
@@ -1318,36 +1318,34 @@ int mce_threshold_remove_device(unsigned int cpu)
  * thread running on @cpu.  The callback is invoked on all CPUs which are
  * online when the callback is installed or during a real hotplug event.
  */
-int mce_threshold_create_device(unsigned int cpu)
+void mce_threshold_create_device(unsigned int cpu)
 {
 	unsigned int numbanks, bank;
 	struct threshold_bank **bp;
-	int err;
 
 	if (!mce_flags.amd_threshold)
-		return 0;
+		return;
 
 	bp = this_cpu_read(threshold_banks);
 	if (bp)
-		return 0;
+		return;
 
 	numbanks = this_cpu_read(mce_num_banks);
 	bp = kcalloc(numbanks, sizeof(*bp), GFP_KERNEL);
 	if (!bp)
-		return -ENOMEM;
+		return;
 
 	for (bank = 0; bank < numbanks; ++bank) {
 		if (!(this_cpu_read(bank_map) & BIT_ULL(bank)))
 			continue;
-		err = threshold_create_bank(bp, cpu, bank);
-		if (err) {
+		if (threshold_create_bank(bp, cpu, bank)) {
 			__threshold_remove_device(bp);
-			return err;
+			return;
 		}
 	}
 	this_cpu_write(threshold_banks, bp);
 
 	if (thresholding_irq_en)
 		mce_threshold_vector = amd_threshold_interrupt;
-	return 0;
+	return;
 }
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b5ba598e54cb..64ac25b95360 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -265,6 +265,8 @@ void mce_prep_record_common(struct mce *m);
 void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
+void mce_threshold_create_device(unsigned int cpu);
+void mce_threshold_remove_device(unsigned int cpu);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
 
@@ -293,6 +295,8 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 }
 
 #else
+static inline void mce_threshold_create_device(unsigned int cpu)	{ }
+static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void smca_extract_err_addr(struct mce *m) { }

-- 
2.49.0


