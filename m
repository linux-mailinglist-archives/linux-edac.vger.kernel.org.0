Return-Path: <linux-edac+bounces-1357-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD5C9158BA
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 23:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60151F2655D
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BA21A072F;
	Mon, 24 Jun 2024 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YNWRLlO7"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C613D633;
	Mon, 24 Jun 2024 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264024; cv=fail; b=Jk7hnBBg6SOsqB0hn9CuE1k0cB3nNBs6/Fc7nHKrdKaT2cn0O0mQZb2bmwWkJzB8eRf6IKYPdE7ArYBGql4bUCc5ezzyX9ScT1slDGnliB1M+jVmxzuhWSj2eJ3X1SVfkAnTiuXK0hzmLHEUF5WIGmm9EEpwrPBzlUGKog/F+6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264024; c=relaxed/simple;
	bh=0XTbSVkFEAIABW46FSh8OySg1Ok+mgUoX2/bKwg6cnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdtuPesPwK+T7+M+I85s3f5o0aqUbFoZujUHa8KMXYAFe/agUOhTSHtPOcf9x80wfI2YU0e4TlLt4C6eBPtoDLgs23+I2JrV5w88tchJpwAU+B7ANvkZfPE8eueqlZseivw7C8xqu4G+2pnnvOMb+wpC1GhE1Rqhp6U0l9UkxOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YNWRLlO7; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeSK74B7Y5CmEo9edX1In6C9amu8HOoa9Vqwgu1X8sj5GkKeMZcIQZtzIPYW3qQUTIF33zjAMBAiCys6Vw8lcP765crByNf4gljzUEjdWz78TZXOuC83N2T6dYcsyDn+WMy7KtyYmVtVOE1qFIprBM/WsZE2H1yDQQqtHkWe6q+PbHhFMOOeSySyaJwo1sK5mj+7AuZKg0TiKxMD1zRg4W49BZmGlvhYsIDgIUIvrTHDMxyYqkvKmphrmE8+/7gtrLCAdthrzMU6XIZ5thXiU5uCKHVyfy419fy+z6lgWp56hfoqbyEOYmtXdFn1PyWD0GqHc6GrParK8j2ABAGv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsncQGJcHNTcf2+kpdfn6icrJfdLxhXNfNThFzapN2A=;
 b=T2fJJMxDwcOcEV0ie+4sHdylk+5b3KZ5dqbAIPNljJ5YtYC17WetpJ/9amE9MfMR9EAXXoAKkBPo6iGZi/1sgUSIpush7c0ZTA7TFA0bLGkJjzjTtiU1FQXwBit7/zNkVLP/oomgp0LhAw/r8EvDC7TTnsPK77q29MnwYVOsu83oYhNUt+BOCEezqn5RtPTpLcwj5LPdQs2K9tSOiW9aIYA5c/GaQX+ZuX6BsY6AG8ohlRwxLCsHQCvWsKTRrA3b9aFfLvtDVUvTMFY+TUL9rgh9zL0+Die5lCmPLQ3XaY0rh0XgsN9hnRG5aw1d7iJ66gToN1My2GeDt3thomkOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsncQGJcHNTcf2+kpdfn6icrJfdLxhXNfNThFzapN2A=;
 b=YNWRLlO7j8J5bVeq1yQ4pZ2J4HTVccNGsoaaZGiVOZwLPDd+1RnvF7gbYNJl8jAPGT4lKIqBWneQqHpnA6g9SYMgnGbjefLMhG2zIZZl9p1MJL5B1XhBvN9233pz05P+hmg97J6L5XT045IbhIDfDr4EaBxuGtIeezbAgslpZ5c=
Received: from SA0PR11CA0081.namprd11.prod.outlook.com (2603:10b6:806:d2::26)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.24; Mon, 24 Jun
 2024 21:20:20 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com (2603:10b6:806:d2::4)
 by SA0PR11CA0081.outlook.office365.com (2603:10b6:806:d2::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.38 via Frontend Transport; Mon, 24 Jun 2024 21:20:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 21:20:19 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 16:20:18 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 1/5] x86/topology: Export helper to get CPU number from APIC ID
Date: Mon, 24 Jun 2024 16:20:04 -0500
Message-ID: <20240624212008.663832-2-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9cd00e-084d-46d0-ded6-08dc9493738d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?apI6SQeo9GIKEvrMoWhF2nhl6/M5RpBdfHr8YJTVFDuEl/81gosJCIFqD4Bh?=
 =?us-ascii?Q?ZfRuddrRpwU7fnrYdwY1cMtfU3rhdB6Tyit25DbaT7UCPspSaecNqBZtaI/O?=
 =?us-ascii?Q?CHDtZb7EPrdJG8srsGlRRZDCvMalzh65oezVbcm9P+GiDb4R/57DIngpPwUg?=
 =?us-ascii?Q?rHk1Bhf78CuaoXNikMfPmOfB/X1MIwCA4B6pYIpTz5mMRRc9ql9N5HH42bVo?=
 =?us-ascii?Q?rb8+zm5F2VTo2/XqMcRaaEFpnO2RG5nByXSZgaeVi3wzvQSMlF6KlJuXlp4d?=
 =?us-ascii?Q?gcPPzTUZEBN08UslGzigjkf7CUbzAvLmKdc+haGdvubCKnQ+YxCogQ2LfIpO?=
 =?us-ascii?Q?aKyf2anHU9qJnJELXulRELrrarL/d6omhsQ8VTZe5NH31XalebGb/eUETP9n?=
 =?us-ascii?Q?gIb8vaSogT4K2oxUdoKTO/23uoGf0k8AAQPtiUnxw2dWKzVXTfZvd4jHBy4B?=
 =?us-ascii?Q?+hbpPuSWVcRw2062EKaiRZnfkLhFvjnpzyPA/M4kn+6rzgrLcvSTqC4J7ENr?=
 =?us-ascii?Q?7RE785U1kNxkiRKqWd5Wkd1Tq2x3UptivCje3GY1tqUJrXCA3cQnVkHWVQbJ?=
 =?us-ascii?Q?X1bfqsE8IrhS05S+LUQpmxN1m1WJJQ7OUaozelvqUHsH5CyceQpY9iQ8nWLy?=
 =?us-ascii?Q?ZpCdmSaEKgzsvH0cUFISOhj7ojdQl8GgcSnxdMnHLXZuwL1dtH4JM+cO2uiL?=
 =?us-ascii?Q?6+L8ewppwRIXFzLaCDBSJiXX0lCJwz76v1GjLfdkH46aEL+uDfj5FIV/VAVt?=
 =?us-ascii?Q?qTSd0ZlVNJjApbSZHY2OfFoge/EF2hTxyx9HMbjoZKIxh+xcEjm+jaKC9T3V?=
 =?us-ascii?Q?bumsYfzh5Moqt+Uf3MQ3OGcGP2ZvL3hCCCWlKvn45Y4rG/R3pN2R40XGwGgV?=
 =?us-ascii?Q?Q70yvON8T/pbN64LjHYsYXu5VBlBvj55iIqryHkRfJak2BNJUYzyVmTDvv37?=
 =?us-ascii?Q?ieK74egnhc/QXeb+KsBOHOcyQxgH6W729Uf3Ua7Z1Ae5cd04vt2TGMhfSNw7?=
 =?us-ascii?Q?ZrMgAPCydWxGOuZ/MloGSSYcBQtpi1i00A4aupuTpkjUBBEMG9Nk16pLlu98?=
 =?us-ascii?Q?kAWmGv9LAQkfOgiRCE3oz8nlAVpZd/NKNcDv93r5EhrIx1yl1Tsye/R0FI1I?=
 =?us-ascii?Q?15UjimU9L864Ga6jgXB16sKIjisJ6Y8U99IA5MD2/8KkFBvzUNGqGk1muJZP?=
 =?us-ascii?Q?DFgvQTrj9K37WTIJ/0OoJZreGOYNNJYlZrNRX4HfSt8QeI2l0g62IHA7z9J+?=
 =?us-ascii?Q?zb8iSAnJN2h3fFxX+c6gSd+lNPlW4lv3r41To7FAfClx+lV+ERsY33dGuwsM?=
 =?us-ascii?Q?NEH9skaKAJgZ2sbe1gPbOnA0ayvC1xJ3QAYB3kP5qXGOCryMgOtVrcvNK8is?=
 =?us-ascii?Q?dVFbNa0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:20:19.8611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9cd00e-084d-46d0-ded6-08dc9493738d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807

The need to look up a CPU number from an APIC ID is done in at least one
other place outside of APIC/topology code: apei_smca_report_x86_error().

With the recent topology rework, there is now a helper function to do
just this task.

Export the helper so other code can use it. Also, update the name to
match other exported topology_* helpers.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20240618172447.GA1387@yaz-khff2.amd.com

v1->v2:
* New in v2.

 arch/x86/include/asm/topology.h |  6 ++++++
 arch/x86/kernel/cpu/topology.c  | 15 ++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index abe3a8f22cbd..d8c3c3c818bc 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -171,11 +171,17 @@ static inline unsigned int topology_num_threads_per_package(void)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level);
+int topology_get_cpunr(u32 apic_id);
 #else
 static inline int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level)
 {
 	return 0;
 }
+
+static inline int topology_get_cpunr(u32 apic_id)
+{
+	return -ENODEV;
+}
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 621a151ccf7d..fc74578ee3bd 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -95,7 +95,15 @@ static inline u32 topo_apicid(u32 apicid, enum x86_topology_domains dom)
 	return apicid & (UINT_MAX << x86_topo_system.dom_shifts[dom - 1]);
 }
 
-static int topo_lookup_cpuid(u32 apic_id)
+/**
+ * topology_get_cpunr - Retrieve the CPU number for the given APIC ID
+ * @apic_id:		The APIC ID for which to lookup the CPU number
+ *
+ * Returns:
+ *  - >= 0:	The CPU number for the given APIC ID
+ *  - -ENODEV:	@apic_id does not match any known CPU
+ */
+int topology_get_cpunr(u32 apic_id)
 {
 	int i;
 
@@ -106,10 +114,11 @@ static int topo_lookup_cpuid(u32 apic_id)
 	}
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(topology_get_cpunr);
 
 static __init int topo_get_cpunr(u32 apic_id)
 {
-	int cpu = topo_lookup_cpuid(apic_id);
+	int cpu = topology_get_cpunr(apic_id);
 
 	if (cpu >= 0)
 		return cpu;
@@ -388,7 +397,7 @@ int topology_hotplug_apic(u32 apic_id, u32 acpi_id)
 	if (!test_bit(apic_id, apic_maps[TOPO_SMT_DOMAIN].map))
 		return -ENODEV;
 
-	cpu = topo_lookup_cpuid(apic_id);
+	cpu = topology_get_cpunr(apic_id);
 	if (cpu < 0)
 		return -ENOSPC;
 
-- 
2.34.1


