Return-Path: <linux-edac+bounces-1094-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11948CD7ED
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 17:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC47B22DBC
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C82374CB;
	Thu, 23 May 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O9LvUOUH"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC3E1E535;
	Thu, 23 May 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479827; cv=fail; b=KmsolZgFIUhkepEDyoWSRHpGWFQXOYUzTgDaw4FTeJ7K6bIzfnWewR5Jcfxakd4Z1z0lVT1lAW9K5FlCj/pktFOmmcg3prM+uN5J60m9u76Qu409M5HCLtOS642b95MC0LvKPnTbJqaXZ35rISPfWF5EfWxIQ+m/ooyOz7/sw8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479827; c=relaxed/simple;
	bh=Zq8oMTTsRotel5ebTBQPKrhh4faAW2qxJ6U1OsQLpsI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LByz7xJH3j1M7qifdvnNdL6wlS7J8WPHiqmGlbodguuwjEaQMEyWlKmoxDxF8uyuxwhmxjRt5STNzYuN66Qwt1Y+DcTwpWpL3ODtMbvnO7A1+xGsnjSM3bgnEqJqzTZKuhjgkzYgOBFZ3xSmDPbE3DQfWZcxtiAPSdVdhcYOcts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O9LvUOUH; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NirzauIVGlSPRCnRyYhjNqy5VcW7jrxinaSnrQXS//EXD6mxCPAjDwMSIstZzrUv5hIviNRbt9ccBKW5IFDIocljfj7sw8K31xu0VqkMuJpNnf+1B74R5y9cYo+FoAkLtEgZCdV0as4K0ObNlQ/S59eMjzscj/Pe2d+Pc/gegzuw2ArM/U8Rst9oACuuj8YCjRnUKJPJOjjAi5cUnsTCcpJ2oRCKA3ziJeSJFKk3NHm4FfN6TcTfommZzFjI+UhQlrTi+IvkPcdzH2tjdWOzQ00Qv7tfK41h6q9aWKyEvxhYDEjQI9JOEabXDc3UnA6bHcw7g8mXYHduMgKSHK8+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6h0DWu7VI7hOF0ZW6zuwxept7IpT31vkge1FUQj3C5Y=;
 b=YR2k+n2BoHO+Z7OiEizoCoQF7IMhfGF1hsT5rX3cdTrHm9K0YWBuvCsFzi3u7F/urYuryyXArkkfUtz0IkIk6PO//Mj+XHmlJmrfTBZ61ab8AFXYVOonM0WTAiJKrdvg69UH0f6yZgHm8I2iLhlBicHnIDccGsAI71h20nn9Or5aQmYvQEdxjKVpM5168ImfXqAVAVxUyauB4c0r1GZrlFD4WSGsiuM6iW+InBtk+41J9rUNHSb/q1jvN/IJY7jk3ADn4Hla0nbqVXnNEXH8vpSLq83SKATYGahRc6xT8rDzHpbc8kBKr2Zs5mkJ4FcMHpUkZL7inimocz1i0BCshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h0DWu7VI7hOF0ZW6zuwxept7IpT31vkge1FUQj3C5Y=;
 b=O9LvUOUHkk8YL9Ks3dTta4/inSZg5wtpCv7/POgz1t/2XQipZZKhFustFMo9GTxIJGK0zqrxvN35lEoJpdpcmHy3HxNiE4qfEa3LPILotNyuCil+CmnFOX+Zeurrpyvdw6tHMWjLTBy5wPUATnEvScTAdsZdKwQ2rtGZRN0KvQs=
Received: from BN0PR08CA0013.namprd08.prod.outlook.com (2603:10b6:408:142::21)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 15:57:01 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::b3) by BN0PR08CA0013.outlook.office365.com
 (2603:10b6:408:142::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 15:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 15:57:01 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 10:56:56 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 3/9] x86/mce: Increment MCP count only for timer calls
Date: Thu, 23 May 2024 10:56:35 -0500
Message-ID: <20240523155641.2805411-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523155641.2805411-1-yazen.ghannam@amd.com>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 82036e87-c179-48b5-1c65-08dc7b40fbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eye9zthNZbAqCLW0NAzUe7xCtPtiv0fDxNLIr6SwrDIetDXusyeJyn6V4lea?=
 =?us-ascii?Q?HWLmiWdSjHbiKHK2RIOkmdvQwoJ2W7oBREzfCykasWvFz8eobL6FufZQ2r79?=
 =?us-ascii?Q?TcB31TKTNjfuw/N7y6jdRUW3ZNVavXzAkflj3uI23NN0R0+0DW2Tc55rxR2E?=
 =?us-ascii?Q?2gHa4NyyPVu10myXS0ecC+dj3jK0Z4U0Yeh8tgfpUV6YX9aLy98cVD/TyyXt?=
 =?us-ascii?Q?e8ykfpq5XKHJdfaKHscN247ZWXRZ5E5R/cGX/SozcQvrS1uwVv6I1kF7ML9B?=
 =?us-ascii?Q?gnBwXQ8SPjHyxy8lHjllhLvR6K/mYx3RJvJj804XZrGjs3esY2sqKm1sYDxt?=
 =?us-ascii?Q?eK3YV/qztuEMY1T74aHgR5MyBhA7m4BT48eg6rJtWFkWoDhgQK5c6573ERQv?=
 =?us-ascii?Q?tmyN2Nr74Kde/1Hi1+2FaBzEXebQtBiyUmkSOE1h20jsJBQpFhpzYb+uHbQ7?=
 =?us-ascii?Q?n3W5U/zLp0sfPlwxFMXWZxlvJ7jV029dO3TdTZFDZL4hy0/hXKK0W6bgPcYg?=
 =?us-ascii?Q?5gikerdR1ypI/evEaaoE3rXuRXecSoZ44XynXe9v1cOx0Z4gaEzOuvMaOoFf?=
 =?us-ascii?Q?E43fGEJf0hq/2xJjmJShlIQ01G/PfX6AFJbM3loDLz2O6rvT1+MAuQM5P01y?=
 =?us-ascii?Q?3c3ympWVFR9eHXFC/crsaKPWI///SQraT8p3XEb/3lumav+Kz2wAjCiAO3JQ?=
 =?us-ascii?Q?rzYftl4evkHEbCFc1C/3NInQPmFSTZMJwTqipvmK6A8wL6AocJbDuLI4a9Ng?=
 =?us-ascii?Q?crQWRfcmozaa05oWydijphm8wZFpyN0BWhpkDOOlwyW8dWnaOsARi/Pp1LN+?=
 =?us-ascii?Q?oM49n+Un11rSjfyE+4gKgmvxve537XBt/2TWQ1HrC/MvRyc0k5IQFvNDf0h0?=
 =?us-ascii?Q?Y9ByOZaCCTbpaAXGYAL7HytFOXquB0yCxoh2UYHudDeTdMg5E7pDJfGsIj2Y?=
 =?us-ascii?Q?ontJ081xumZi24S+l1Ocu/w3o7IH7+XysLOzRzCdO84nk8oJzB/P2wCWYrlh?=
 =?us-ascii?Q?d2cfFUiAWKb6zvXPnUpBrYqoROHGvjA7svawAiDDiBkZ7iU2w0uL5fMCpy8P?=
 =?us-ascii?Q?vckz5VztIDLr4s4QOakvhU4J6EL489uydjHZOxaZg9VXzSOEj7v9CG4uZDdY?=
 =?us-ascii?Q?x9HlnkUUCbkhOizpVjptiL5NbBcIi/pfoWfqkDwUe8CiK4TZaJ6OAPYexvPg?=
 =?us-ascii?Q?YMPwySfmtEsHuJ1rdxV4rg44zJKGL92PPIZeX5MYqDMC279GgDcEBhFIoBVz?=
 =?us-ascii?Q?tAFC6vVVAWARXBHRTGCSWe1j81opjeEkIOdPyEZoVFgB+S9OWffMvOi4X5xL?=
 =?us-ascii?Q?ntN+gmKLgjmI0nUn1K+SYiy7983cebNiXlmjt87B7iJYtQbx4YasBIUwNhPm?=
 =?us-ascii?Q?YNGGZd0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:57:01.2011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82036e87-c179-48b5-1c65-08dc7b40fbce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940

MCP count is currently incremented for any call to machine_check_poll().
Therefore, the count includes calls from the timer, boot-time polling,
and interrupt handlers.

Only increment the MCP count when called from the timer so as to avoid
double counting the interrupt handlers.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 287108de210e..70c8df1a766a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -683,8 +683,6 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 	struct mce m;
 	int i;
 
-	this_cpu_inc(mce_poll_count);
-
 	mce_gather_info(&m, NULL);
 
 	if (flags & MCP_TIMESTAMP)
@@ -1667,8 +1665,10 @@ static void mce_timer_fn(struct timer_list *t)
 
 	iv = __this_cpu_read(mce_next_interval);
 
-	if (mce_available(this_cpu_ptr(&cpu_info)))
+	if (mce_available(this_cpu_ptr(&cpu_info))) {
+		this_cpu_inc(mce_poll_count);
 		mc_poll_banks();
+	}
 
 	/*
 	 * Alert userspace if needed. If we logged an MCE, reduce the polling
-- 
2.34.1


