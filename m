Return-Path: <linux-edac+bounces-4666-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF63B348CF
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7AB75E5688
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61F43090F4;
	Mon, 25 Aug 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1vm1kz/y"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CADB303C85;
	Mon, 25 Aug 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143230; cv=fail; b=oZaimZQpaoz2LATHMs/sk5cE8jG4Xpit27GwtsXDG2VakUb6kVA6yBvDKmGGq0EfOtk8PY0/QefDehftwmMfMqkeR+YXs6qxVozTfRkBqey6lSk6PQDVcuEALjobBxqNfN5+5JYy2Es7150sMUKry+uiYxbqYJYzdqwvwuHGKCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143230; c=relaxed/simple;
	bh=5kHUFgEZHbngWxU1kwBudr/xbfVc2s/7vQlfVCbKXjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aWZiHBy3UsQXanHqe0dZwVV01/Yiw5hTvmFcOyAa5oXFf01Mh4bYoPUonZ0FxBPZgcIrxnXLLZlYX5+lq3ipPbOxkALdQy9IRBon9rIrJUuZsiYReglmmvyRRNLsvA3IDyFS9xMCmHE55oFWoK6Qw+ZSa3VnEbZgwgrHRD+70SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1vm1kz/y; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trOPZEBN4SoxsoYHpxxkQMq1f2XrGwwkrNqUCsxx68l+gNajd+fzt5yi5nsQ2sTJvh0Uof4qk9ghNRpdQjlnGSYKVA5SuA17m6DAbhGkSfAiVT7zbT4EIUu/prNUlzrCLvIwvwYLrJC4bHNdTzfRcA0pNaqi3ONJNvoV91vm2YWcNvSHe+x1NMeN4eGWIC3e1VllL4E/anCUmn7cPwBDImf1A3ADODKAP8ZnkG1noRnKag/tt9Ss+kbMKUZ6UQdHrP9TMu59Yo2fcsxA3tmubdrNnwL5zSpxmcb6J0LCKDiqNKkT7hp7P+MHsNNsQYbT2kyKHHVhH5MEjVVVt5ffVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHhxZW3PNqBknlXKPI+asz+F3+h7MiowBObHbyjtJ1k=;
 b=C83/CzAPI5ejSz8Ss/b0f8CxyLkOpvVb03LvAwtOi36TD3aD+RB58eHlYYfK6dNbsZZaUxBPZZRT2vDCCVBZA9NlhqjljfAkfOtGR/llieyadRPDMXUf9/+6mWBdqaSJfDq0b69JDX5iGRyg3dxEynhXVModrGgF3fS2LxQrbcVjwOEWFzHWMVw7K7L8C+M8c0CCtaaPa7FT9VOPrB5PxWLa6yh/v3HK416Rf+Yh5Dh9aPgKa5mUV0yPAz1IHtuucGdUtGaXMwQULabBzPCqaG4lwyOUpHvbI5Z3d66FlhSoyG8KHWVaIuJ60K8dh/YsUrbO8SRzCCEvb7a0K/AMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHhxZW3PNqBknlXKPI+asz+F3+h7MiowBObHbyjtJ1k=;
 b=1vm1kz/yDHQXDyqxtGA2vJ7QGORpdJ0MWm+bKX2eVn8qjC3tuiUTyRy3B3IUKCWGhpkJ/HTWDYkepuXZdtPhbcsPURD3BAYyFG7MakzBkhksz0K5FztIet6n77BK4RdiD0xFkmp6xf/7i0EGQhzBe1y2jS1wavzfLO8pfOTHRhY=
Received: from SN7PR04CA0055.namprd04.prod.outlook.com (2603:10b6:806:120::30)
 by CH8PR12MB9814.namprd12.prod.outlook.com (2603:10b6:610:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 17:33:46 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::46) by SN7PR04CA0055.outlook.office365.com
 (2603:10b6:806:120::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:45 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:40 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:06 +0000
Subject: [PATCH v5 09/20] x86/mce: Define BSP-only SMCA init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-9-865768a2eef8@amd.com>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
In-Reply-To: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, <linux-acpi@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CH8PR12MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: 9becf3c4-e61a-4f6a-52e4-08dde3fd8b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFQ2aEhMZy9oL1VPZXgxTFh0UXIrdzhhcW9ScHIzUnAvdTM3NmtJaVByYmpG?=
 =?utf-8?B?aVMzS25sZ1pEcnl6UUhEQlRJT0VTcUlqb01DK29rRHVNUFl4dGZlRTRiY204?=
 =?utf-8?B?OU1yNlR5a0J6WU1yZzRwNW40WEJOTUlUSjBJaE1KNFVkWDJpZG9ORElGMkFx?=
 =?utf-8?B?Q05ndGYxU3hIbmpnSDNjYW1GYWI1YWpkcHRvWXJtZ2wwZ0VPWXc1NEtacTNJ?=
 =?utf-8?B?T0pzRlk1YzI2Ni9QSXhUQUlmTjVnMERZeEd2d1FQOXJEZnZsZ3AvcllyQWhl?=
 =?utf-8?B?L2tyVUhObFFXSXBoL05aU3VRQ0piS2hCbDhxdHl3Vm8xclcvMEJLR0dBK1d5?=
 =?utf-8?B?dWJUNlVReDM3NUgvdUNpRFo2NjJBc1VLamRmeUtaQ29HMjN1TmU4aVNOdGY1?=
 =?utf-8?B?UHZyYVhBd09OckFMT2dleXdmaUx0d1lTWnFtQWJvNTdUUkx2RXU1R0JhMnhj?=
 =?utf-8?B?cmtJWHRlYzkvYXZSU296aDdjdG1qZWhiRGdTMTgzZjNGQ040L2lPSHNzazhp?=
 =?utf-8?B?dHY5VTJHR0lxVUNhMkx6c0doZlBkb1BZOEwvd0loYWRTNVFKd2czY0cvYWZO?=
 =?utf-8?B?cTZaZnNCNVNHL0p5cDJab1lJcTZzZy9TdlU5U0lRdkpuamRrQ0JTQ3pIYkhk?=
 =?utf-8?B?UVZlQ1hSRlZmZytaMXJKOEJoVE1NQXVMeDJ5ZlNWakpESTI5VStBQWJ4Tmsx?=
 =?utf-8?B?Umo4V0l4VW9DK2phL1N2eG9XcERXazNHcnMyYkRjbURxNTh0T0tGUDJvdlow?=
 =?utf-8?B?QjVMR3ZlbkZCbEdpWjkzQmJ2RmI2TkhxVGlLTWVvM1R3VGhUajU2NUNLUStp?=
 =?utf-8?B?cGp1VGJ5djQ1SWc4U1NuN1ViVU5xaWZkR2RpUmNJRkhBSVgzVVpvdVN4U2FJ?=
 =?utf-8?B?NURUS2E1MkxsRjh4U1lzMTcrY1JDUE9pMnJTT240MktBQWM0NW5oMkVCZmxP?=
 =?utf-8?B?RzE0Q2QwVVNQaG1RcDhzZ3Q4ckpxQmMwOWtZR0grV2M4T1JUdU1vOHM1UHI2?=
 =?utf-8?B?Ty90NkJBNjcrNXlzRloxMDlJWlZVRHhGUWZYTmExM1VjR293ejd4MGQvcVov?=
 =?utf-8?B?U2dnZ2VUd1JHU3NUNHNPYlQvd2gwdmZpZmFjQ1BvYTJvNUJmV3N5d0ZxaWtN?=
 =?utf-8?B?OTgzSWJ3WllYZkdJYzNFbFRFQ1V5bFVJZ3ZoNkVyLzhPMjRBeEtvdGlMcDNS?=
 =?utf-8?B?V1VuSGhXQ2hjQWQveC81Y2lRMTVLN0gxY2NmRjFrMk1UdlN0M1c3eHordG5v?=
 =?utf-8?B?VHJHVG03STFDdXBSVkxWY1NmT1hNeFhvVHdERHBzbFI4WklEbVRiRUsrUysx?=
 =?utf-8?B?Sm43ZFc3MjBBMlRLTW84QlVMUXJFckNYaGJvUkJyRGx2OG9KZHJsK0JDUS9Z?=
 =?utf-8?B?YUNpbmh1Yk9FSXd3R1YvZUVFbWlPMWRHakxXc2hRNmgwWVZiSG9nT1BxNHFR?=
 =?utf-8?B?c0RiRksrNzNobUdvWGpjOEgxRTlmZlZ3VitnUVY4Z0hDMjMvK0hpMVhUUTVF?=
 =?utf-8?B?YVdSQ0puY3NOT2EwY25LK1RIS1VyeFZzWUJmdXZseEVYdHlzVHpESVoyemVU?=
 =?utf-8?B?OWx2ZUFyUFdYMnF2RVdRTllpcnFELzE2T05kbDNQN3J1cExRZG9YbVhRcmQ4?=
 =?utf-8?B?WVhrQVBlV25BWC9Lb0lkUkpyTDE1a0RadVNsYWhzTFFYOWNVSTU2Y0xDVWNn?=
 =?utf-8?B?UlZIQW16NHdLSjBTTnpneWo1dVpmN2FJekYxbkVaeWNOTHhqUjZDeFk3SFdk?=
 =?utf-8?B?RDBnVjlQcHNqWTlvVFJoQ3FjbWV4V2pkbDByK3dtYnRuUml2QWJzaTlNa3lV?=
 =?utf-8?B?MGsvdHJES1pPOTRXaTNhaTNsQmVWemFkbTVZdklDczZrbGp3ZEZjckJrSTQy?=
 =?utf-8?B?TEYvQXd6TzFQejY0OFV3Ri9XMFMvUUpESHRJaHlYNmw0dHRyMVJscG9qU2Fh?=
 =?utf-8?B?aWhOeWNmdW9XUTRBRUg1Q2lkQjIyQ2M2QVBxc0hNeUZkcTIralAzYnBSVXNE?=
 =?utf-8?B?bTFlZFJrZjRZRFZkcWV3NlZ4cHA5blIwM3A4Rll0QzBBbHdpN1dtOEZ0Tkdp?=
 =?utf-8?Q?vCqsmL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:45.9213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9becf3c4-e61a-4f6a-52e4-08dde3fd8b4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9814

Currently on AMD systems, MCA interrupt handler functions are set during
CPU init. However, the functions only need to be set once for the whole
system.

Assign the handlers only during BSP init. Do so only for SMCA systems to
maintain the old behavior for legacy systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-12-236dd74f645f@amd.com
    
    v4->v5:
    * No change.
    
    v3->v4:
    * Change mce_smca_cpu_init() to smca_bsp_init().
    
    v2->v3:
    * No change.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c      | 6 ++++++
 arch/x86/kernel/cpu/mce/core.c     | 3 +++
 arch/x86/kernel/cpu/mce/internal.h | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 25c243e87b2c..efcfce329ca7 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -688,6 +688,12 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		deferred_error_interrupt_enable(c);
 }
 
+void smca_bsp_init(void)
+{
+	mce_threshold_vector	  = amd_threshold_interrupt;
+	deferred_error_int_vector = amd_deferred_error_interrupt;
+}
+
 /*
  * DRAM ECC errors are reported in the Northbridge (bank 4) with
  * Extended Error Code 8.
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7f2269ce5846..18a8e8f97482 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2246,6 +2246,9 @@ void mca_bsp_init(struct cpuinfo_x86 *c)
 	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
 	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
 
+	if (mce_flags.smca)
+		smca_bsp_init();
+
 	rdmsrq(MSR_IA32_MCG_CAP, cap);
 
 	/* Use accurate RIP reporting if available. */
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 64ac25b95360..6cb2995f0ec1 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -294,12 +294,14 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 	m->addr &= GENMASK_ULL(55, lsb);
 }
 
+void smca_bsp_init(void);
 #else
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void smca_extract_err_addr(struct mce *m) { }
+static inline void smca_bsp_init(void) { }
 #endif
 
 #ifdef CONFIG_X86_ANCIENT_MCE

-- 
2.51.0


