Return-Path: <linux-edac+bounces-1359-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139CB9158BD
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 23:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BBC1C22F67
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2024 21:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F511A08D7;
	Mon, 24 Jun 2024 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hHGV1XZu"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A61A070C;
	Mon, 24 Jun 2024 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264025; cv=fail; b=cfMB7NsiuNzyTZqfM3nlDjkpZTmsyRY889X8SyLMCe0uGMb5Cd/ziNgGiNo+UQKrdqv2UVCziVxI+bITda6aFA0SGvpHatTBBUDbozhb9XU0dztH1p3dDzFrntEwqAiv+dNy9xJ74Oh3eN3uVqyO5mXyXXT8LMZIOsU4JDg+Qd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264025; c=relaxed/simple;
	bh=kLLdoj5+xb7uTUEhpdvKHxD5ZBvPmTeGtgQyzJ1h3lw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvREz/1MoBa2priQjxm0CUfWoZ6eyAgbUfLkujC60IjG89LPBOzG/sxF9yLZBp1qhWsAoktd3jq0UeOcuwXSL1ZRi8XH30njkp3UqbMjAnJbAyFdNOa24MAf4qn7TnEUJsQlo7CIQ8h8Mt5o8wGgrFWn0uQHKOazXOD/Ord8hz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hHGV1XZu; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAEDUYFGOi0NhEkbci7GvUJ3cuXFWUvyeKfZUMCpMOKapYu2Z79MwMkWb+U1qWPyoVIyNGRvXgbZzrX8aVQ7nzPWU/Zg12+xcxmC451zNe+LdRZf1w+QLr+cyzPVZfVoriAeQty/RkVQxIPzl4MxAR/XKEL8muceFDsSlEfsZb57cLNraz1EWqGpLcPP68ZEKv3a6DvWgCpsCQSUzomajS8QHp1hMCScqUv62lNpyyTkCBGeXlNuSg5UzINXOJbWAIbbJTKYTzG6GbLHCUrNk3T2GQuusgpxXRGaTQl3CS7kM1yQ3saTCzpnAFUNpf91ReERG0RECgGZJypQsmSxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn1JpJkzzDqljid5AGMUx4b+MJ+Dyo+Mq1+8F1VCyus=;
 b=WwRbho6lM6Xfk3cafcOdjFSDCwtCR/wfTGD6yhXdwJCsA65Ycmvno7eeCrPQFRH3pxwTWd/ac3qpl/JzeI7GtEDI8L/FzZFoyFij7hadgM3uW78+hvF8hapht1CtqajvTAVl3J/RmJko4LE8azxfhx3QYsG1nDNfJUTGzsUXBns/Z3wY2EK//cRPhgI41tmTnFngtwfX4QTelFMDmFCwsnkewpUpSmR9vfIaTYPgDy6L6HW3Jhx1S56KzMerl7Kc6INh++tPlZDix95RTJ4LbItBtSOZX5vTGsEPvtFD7P84ajuzNQBD4ukJ+vl0QXUgt2Yylfd71NbJfJLielrwMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn1JpJkzzDqljid5AGMUx4b+MJ+Dyo+Mq1+8F1VCyus=;
 b=hHGV1XZuQvAEw6nPT2DwA4/XvZgLkpB30NIdEp1quV77218clE9RxarP+7mjr9gljiugI3NufJWyNZxACfXPsDbKy9QAGsjzWxRmNgGY42XXUvvYb7RFofjtsY0zw+EduZlve8HAdky04eEBTOJXqgrJzLc0tW/U/kTYtf/Td2E=
Received: from SA0PR11CA0062.namprd11.prod.outlook.com (2603:10b6:806:d2::7)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 21:20:20 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::ed) by SA0PR11CA0062.outlook.office365.com
 (2603:10b6:806:d2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 21:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 21:20:20 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 16:20:19 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 2/5] x86/mce: Fixup APIC ID search for x86 CPER decoding
Date: Mon, 24 Jun 2024 16:20:05 -0500
Message-ID: <20240624212008.663832-3-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: bef23bcd-8ae4-4e52-a0d8-08dc949373d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IpXAtdaOyK/4d3ZO2wHSOqkppb3lHLHs6TmMrc0VET9a+vAi8Radybp5DtaO?=
 =?us-ascii?Q?a0KwkaQRwvIruMc1faq5Rf9lOp6iyHL21+3U1h4OR4wdlGRfkrrLUXDoiJ6G?=
 =?us-ascii?Q?mxfxdyjvyyZmBJSco6cTh0WIrivgHlvriuVhzYYNO4gx0sfitPED1OG1On6T?=
 =?us-ascii?Q?U+JuyQsbEhbzC3YTDumXduU1t374QRVWmryKON+BEUPlJoK/ZcGoj1SozhsQ?=
 =?us-ascii?Q?4Pj2/Dt+EBKOF13aYQP1x/kNwkIuJCInTt8Qcn2EY8bGD5dQ7woJYW6SDb7l?=
 =?us-ascii?Q?5cTCw9WKXTJA/oN2QAeQTlbOxEVV2G4S+BXZWnNdw2T9pM7xM9mVvVoCPRFm?=
 =?us-ascii?Q?fCrVPLr9a0vHMbrOmJA406Jwi/C913coWE0WdM8c321iUwq4eja3uO9QTvHK?=
 =?us-ascii?Q?o5UXIYDUpu2A6DjCvWxWoCPh0DpBWQf+1J61BYEC255i4qQlatneqLXyyOo0?=
 =?us-ascii?Q?wKgp1AoM3hT6kBzo5fSvvcL5nGHw5o/EFBLPU7Q1S1Svkl0toTUtCgx8Wope?=
 =?us-ascii?Q?tLWWm967kLv467s2PeAP77+LvE0dy4ethvEEDruCEYref6WOp84bHNcs9m4h?=
 =?us-ascii?Q?J/SKIciRnQlLOGHMQy+Z1cuwV0RMP/yjMzpewYOEFywrgUs1JF1a1y7iWQoj?=
 =?us-ascii?Q?b1NALazJyKoOGs0wNuNG4H1HmzMHckGfbb8alOcRsfwHxKGmqjEqO7APo4K5?=
 =?us-ascii?Q?lS5kaB+j3li+rHKAM22y5QXomKL9gI8ZnsB1si/ktcPRXmFm+IGunNUh5Yh8?=
 =?us-ascii?Q?mBem3sJpdvknjksiWOzxL5hF29UQi4NTB1A24Dh9sX/N4VacJgTfRT0heK3X?=
 =?us-ascii?Q?PqaO6suOtolnDFtRxmPlMz1iF3PfYpx3ERLHlWKZw+OwoktrlI5blMh8yvuu?=
 =?us-ascii?Q?SEjEGZsqLqkDiXe4uwokK4P+tzlBh4Ppe0rZyNTCIyPR7QQjTj2BNCGE3A/6?=
 =?us-ascii?Q?gzsOZeCgwgNMqUMhpoMiJJXRtaPm5KzHNRJCiZZeYbOw0ZVRId+3MStgLrfL?=
 =?us-ascii?Q?OtpEetoSwelZ+wxLq1lJJySpaFaEx530i+QDdtHMA/1oPxeDKfPy8mEKVMCL?=
 =?us-ascii?Q?LPN8bv4hGaf+MFVU72q7SMAAdId+H404E9QYgp0YuLbRWZ7ZG4BVk+gdA0hm?=
 =?us-ascii?Q?HNhkEirdRbIwmU/NkWugKWXI0sAU6IJLxnDQ07NQ9FP/TpoVW1rjFOLuM6YJ?=
 =?us-ascii?Q?DI3Bji0ENZoib8zoQ2QIhFEjGQK/Bu/cHQcbCB+YjGSVXbA6E20Vh4Fcvrt4?=
 =?us-ascii?Q?1RyFPu1JmYJAEjb/ttYkgvkrL6xLKQQZK94FqAtpR6yLCzCRqyqzpgYVhGtO?=
 =?us-ascii?Q?erE0p2a49WjVXmoNoAwenkku9asV8GyJ4WpX15t7qIExOwTqnPKsZFOSq3r5?=
 =?us-ascii?Q?J46Fgds=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(376011)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 21:20:20.3142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef23bcd-8ae4-4e52-a0d8-08dc949373d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657

Replace redundant local search code with a call to an x86/topology
helper function.

Additionally, this now handles the case where a CPU match is not found.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20240618172447.GA1387@yaz-khff2.amd.com

v1->v2:
* New in v2.

 arch/x86/kernel/cpu/mce/apei.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 7f7309ff67d0..59f1c9ea47f5 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -66,12 +66,16 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
-	unsigned int cpu;
 	struct mce m;
+	int cpu;
 
 	if (!boot_cpu_has(X86_FEATURE_SMCA))
 		return -EINVAL;
 
+	cpu = topology_get_cpunr(lapic_id);
+	if (cpu < 0)
+		return cpu;
+
 	/*
 	 * The starting address of the register array extracted from BERT must
 	 * match with the first expected register in the register layout of
@@ -99,16 +103,8 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 
 	mce_setup(&m);
 
-	m.extcpu = -1;
-	m.socketid = -1;
-
-	for_each_possible_cpu(cpu) {
-		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
-			m.extcpu = cpu;
-			m.socketid = cpu_data(m.extcpu).topo.pkg_id;
-			break;
-		}
-	}
+	m.extcpu   = cpu;
+	m.socketid = cpu_data(cpu).topo.pkg_id;
 
 	m.apicid = lapic_id;
 	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
-- 
2.34.1


