Return-Path: <linux-edac+bounces-4993-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C797ABBE76A
	for <lists+linux-edac@lfdr.de>; Mon, 06 Oct 2025 17:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A9F4349629
	for <lists+linux-edac@lfdr.de>; Mon,  6 Oct 2025 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FF51D5154;
	Mon,  6 Oct 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="02fDO24u"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC49194C86;
	Mon,  6 Oct 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763876; cv=fail; b=GF24DTwv93FkEceRI8xCMl0E4x8PPEenDUayBakP9mq4ton0R/nTWlj+LSwqfpodDgSgO4n/IsiBuV4cuA9aOSt4PRLRcgyrbF8rC6l0paxVE0DCrw8k97sSbYu9SqzPdBgQHmXw28t8i1eq78IOUkx7r/05bjpDNxWEe4Y3GP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763876; c=relaxed/simple;
	bh=XHkaduVY4ALMXUe+mC31KrY8PfBUwTJDDGJUhfk97ow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tCzGGaAlMt7xQvqJKvuH7kGsEIZi9Jg5GNTlECoqupatOSgTGMkqkwPJQAugZB2o8gFJle/WSzXugafvdKCdooTS60a9u5suySpWbXp3kM6JEi42Gayxagg4ekC4EZqKUAFA5+DDqeq3GahFt2BHztVs5uavN30MbOnMqmOrOEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=02fDO24u; arc=fail smtp.client-ip=52.101.61.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T11rgFgp88Dw3HWf/TdXtrVniylko0/TrC7IF/NLpcOm87roYnWtWRM8fu3yvTrORnd+YfP4C+bLi8CSjQd5PJZsuNAREgClmtTInRyEGb4GS1kqpsqXYUN/dxjXOvcwXzodvy3JVtw2QrnpZUU3sK9T+r8qmvy0SG3af+7EqSdlmI571zzLggXFLSAOxnxGI5qOzOWs8c6WgF/yPABMyPfoxEFPLXxsyT2Py9cVIVU3ZCiR89epte6MOq38bSD3CRljFi6q56K9PNMgNznjEUdvqvAJbZGe2mkucbjhY+KadFyD+Ufy8OLl4gMSRCDMVsrvFM9zClMVoScEyUvw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFL8cGLxDANHtox70QuZLBcNahtrSMQ0m0zihYNKYlc=;
 b=rJAxTKkc44MYpWpaGF5lq1/AQ9PBvfCsSJe4J6fkq2MJaWIDoCMcNg/SVq1G+ApMYrZVhD7EEJp44UpJsu2snyRPcNjQHMDR2dOD+W/sFZtnT837bnF0vet6KfiBhmM8lHuU6Y8wyP4mcKZt9kXF2Fmv2JXtOe9mEBp5oZ3pFAItkCgyHgwsFzvEqQEd64obxKCdz5mJvbvDc4PmLEeR3HgXgdJ8Q7m6BKA0+1m0Zwte1lnD8Cvx1B98IHU4g6fFg7FfxZruvCitiQuv09s4/vqNZVMmCFV0R6h5ZSRgGiMGoWBs9dwz9aXKXlLoXgBWgW77I10QkulQMptaNchM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFL8cGLxDANHtox70QuZLBcNahtrSMQ0m0zihYNKYlc=;
 b=02fDO24uceqqzanQSm3FKuET11DjhcYk/PPHwYqDa1OgKRfUKgYW715IbphJK+RWVUnJNJ7fOsjUthhtBHQm1P12ac8TInSuxmVVSKryjv6/leogozgOo/8opi0k7+wytgQIMYjtdTmQrrWYYHL1QoVivWHPQIPWlfZ+QYToEeE=
Received: from MN0PR05CA0008.namprd05.prod.outlook.com (2603:10b6:208:52c::18)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 15:17:45 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::c8) by MN0PR05CA0008.outlook.office365.com
 (2603:10b6:208:52c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Mon, 6
 Oct 2025 15:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 15:17:45 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 08:17:42 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] RAS/AMD/FMPM: Add option to ignore CEs
Date: Mon, 6 Oct 2025 15:17:31 +0000
Message-ID: <20251006151731.1885098-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e78b4c9-b63b-4b45-b1f4-08de04eb8068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pPf5fKf1KgVTzKsYrr6T9MCnnrwbVO+z8DzEZsE7uue2gi7zBYY0YioCvFeO?=
 =?us-ascii?Q?Mi0oq+OM0SMt5tmExQ3lyHCYTqz33MEzG1E0G1HzokRa1wjJP/qdyLQ+qiaR?=
 =?us-ascii?Q?s+LaGw1V/Ry9QHjmjdO1bDuDz6F0awE63hVsENgox9s0OQ74ef5UO0MW5LeM?=
 =?us-ascii?Q?9fJYqg6KT1P5YfmUZY4bUJOtFlvFrGOVyc8qAqOfqhG/eYfUvPHYPTRzlErQ?=
 =?us-ascii?Q?OUMyBRASmn8ahxaOmLDH31uOCKmwA411Fktm/5hJshV9UWX1+nPBZSjovogk?=
 =?us-ascii?Q?KlW5yn2DbmXDzvgwcXYwG+8vDdRH1s4ClTA+0Kwp99BS4lq0sV8wSL/UkLdp?=
 =?us-ascii?Q?3TYwwJXVunYmLihre0Tdb4q6cS6ebV0mQDpGdlzbM/4bkssu1zZSe0Yjtdx6?=
 =?us-ascii?Q?JQRLKJMjY+rTfijJHlDLdGx172p99PQ6aW52d069Fv+Z27orlEdrV7X07Boo?=
 =?us-ascii?Q?3ec9EHOaDG0M+qdMH3wafeetQJvYAONK8YXEExrkNyqm4h4ViQ0LaMEA4mdk?=
 =?us-ascii?Q?P5RrsCzLzj9Sikpsv/db89C1jFg778r6sA0vox8rgCVQN4LjUm+xvJOW0jje?=
 =?us-ascii?Q?dTcpswXCedEZ/8rrbDjAomFVlo0iP8BtodKcXsr0ni517uJL1d0BTFj8JqY/?=
 =?us-ascii?Q?0/HlzUEqSsUKR6yo1VHpJFtezrgehHGiEWJq5n0n2ODe/FV5qFI84sz/ZPKH?=
 =?us-ascii?Q?WNPSg2wi6rKwP31sLZe2jMF2OJNQgSuqgrAtzqDm4M7BGUM/olmwwdivIUDi?=
 =?us-ascii?Q?vbGgpMWj4ww6jw4X7PmRKi44jgzOEWpKGJn0SDjpBB3e/PGNc6spDHhtFmY+?=
 =?us-ascii?Q?VuGU1FPoC/dzxHMlFUSC34fsDMKqiqvmvJXFQLdi5mAcWsnYbPQiCB3KVLNJ?=
 =?us-ascii?Q?GuvEGQ8jBdf8njOHYeGM1Q5u+QSeH2DMvHV3WTcPPCXjlWZag15lwakPfcet?=
 =?us-ascii?Q?VxF8f6qOkic9d0aKooWC/Foz8yz3HfFk7llu3LJ66JiKibq5WKjiLAtGYUBh?=
 =?us-ascii?Q?ZmjkTDtZrP3YFNOV75PX3YzVLiLNXewxrEES4qYsuYLRkWCro8tG8Aw/UjIQ?=
 =?us-ascii?Q?mH3b/5XyVeimZQOcC8VajBaTciJCiFySwGNkOF81lNx8czAnp6vkY+tR0+eV?=
 =?us-ascii?Q?uCaRF5V/3QYehbCIzFJm5lOCk3z1oxJ+n2sOK3F0Z5CO59AMkeGi/OavxHy4?=
 =?us-ascii?Q?aBCAks53RCK8+rD7eTNgNNZIaf8eOU6DENTQXpVf4XNUQ9/7eqgJwh79pPT4?=
 =?us-ascii?Q?Obv+2vcSe6qS9k3ZYU/lyeI6q6J9xSFnHWpBSZgLZt8IRYR2Cwkux7VrGrv5?=
 =?us-ascii?Q?0yTIdYJxk1MsrylXTjqy+255Q72U/HMUdKP65wZ4zG8aqpBxnkRqzp1JGvJB?=
 =?us-ascii?Q?6PLFGn6fJSzO2lyiPE3rUjq9uTMCaLioWEkXzLXPF4Ljnx8dvZ2xfkINNkOt?=
 =?us-ascii?Q?7XaWVO4sb0rHfDIqupz0+yqTrcaJ3CEJ5OBZtNyCQUKUZjKuJ2EsI5KlmxKb?=
 =?us-ascii?Q?0qtynMSr/ip9Eiq6u/bSgSS6Ux2H0wBigCKhSgH6Ixuq1PmjKbuDkAYzH0WA?=
 =?us-ascii?Q?C02xai7xTDOvB7/Wxqs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 15:17:45.0825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e78b4c9-b63b-4b45-b1f4-08de04eb8068
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772

Generally, FMPM will handle all memory errors as it is expected that
"upstream" entities, like hardware thresholding or other Linux notifier
blocks, will filter out errors.

However, some users prefer that correctable errors are not filtered out
but only that FMPM does not take action on them.

Add a module parameter to ignore correctable errors.

When set, FMPM will not retire memory nor will it save FRU records for
correctable errors.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/amd/fmpm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 8877c6ff64c4..08b16a133f20 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -129,6 +129,14 @@ static struct dentry *fmpm_dfs_entries;
 	GUID_INIT(0x5e4706c1, 0x5356, 0x48c6, 0x93, 0x0b, 0x52, 0xf2,	\
 		  0x12, 0x0a, 0x44, 0x58)
 
+/**
+ * DOC: ignore_ce (bool)
+ * Switch to handle or ignore correctable errors.
+ */
+static bool ignore_ce;
+module_param(ignore_ce, bool, 0644);
+MODULE_PARM_DESC(ignore_ce, "Ignore correctable errors");
+
 /**
  * DOC: max_nr_entries (byte)
  * Maximum number of descriptor entries possible for each FRU.
@@ -413,6 +421,9 @@ static int fru_handle_mem_poison(struct notifier_block *nb, unsigned long val, v
 	if (!mce_is_memory_error(m))
 		return NOTIFY_DONE;
 
+	if (ignore_ce && mce_is_correctable(m))
+		return NOTIFY_DONE;
+
 	retire_dram_row(m->addr, m->ipid, m->extcpu);
 
 	/*

base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
-- 
2.51.0


