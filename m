Return-Path: <linux-edac+bounces-4816-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF84EB5A348
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 22:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB29C3A45DD
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 20:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4DF31BC88;
	Tue, 16 Sep 2025 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bb5E9cnK"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013030.outbound.protection.outlook.com [40.107.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1831BC81;
	Tue, 16 Sep 2025 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054787; cv=fail; b=eVBJQlZpw1EBM5vlIqxKb9HQ9+oy7nfplvQwQ9gCGHLA/szLSFWSUEYGy8+Vgqj1rNUDYiITCv68/O/UazA436GE6LnaRaRCLeUoRTPSzAjLLpqDXxrg/tD4YCYmeDf/FIOz5U4YX/QaWn3G/Z1Ey7hgdaU6e6u3JMXbsndnDUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054787; c=relaxed/simple;
	bh=xf4bM9xFUsVR7SGQAl5hCUFnLeQLWG7Zxfc77Q03zMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRXVwabrwhyTF0URx89JBMzFM+rO8p20JDMVtB8vG4OKerXEgPKNdk/qcTco/K9w8f4412L0SpVg/jWQJiqZvDyaPdc4Ej1QJc3BqX7qge/G20dvsYFld9o+vifnXpzGyCmM5dJwAI9ZVtXrynw4ykRlVR5ZmACZoZztqbIB+AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bb5E9cnK; arc=fail smtp.client-ip=40.107.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amst4K3lioQJB9EyDQirmvWmPIMjS7MrDGfVIsygve/7pawHbZPCLFtEMotBEdybGzxeKJ8sRzfKGn7Lo8mNx9xENQhluuW5Du+17b/FejavsBtLvDnXJ1M5GpTihx2p9AYQWy5V5iwwD93AWACkbMuae7gAPqpIZJmjMysjK+DtwS+WJLPm1NzwZ1A3wW9oVZEfLr/clgr/bFaHtGZSI0tmCKIoBZJGEru2f//O9m4S/kvCNhuGX5oRHrJbjFCDAb3fJZ9Bla1Z+WPtr7gLwDsey4JaeMis5Vg7b6V56P5ItJCzoNbu1Euii7vVaWe7QFlNo1+JB/FZN9f8BmFYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jy0ptpULIrIaQHkFmqz9EUUkQ6VNs3uETXiAjnVkFvU=;
 b=bOEluUjOgxquWmEmFJaCFvtODEjF91xBXugtQrgOpZr8nAqLrSSKBO6xTGRyumDS5A+OV8YWxMHOjp/1ZNl0uEqSOeiHuQ+XGCZCHCFWptq1DOZ6GjXy0pEkcmxuKa/h5U/CylS2VAi/h7U2pW10XA+rWF0AIZQpl1usRNpeLFl1lAM2APNN3mGRYwtXP2NQZ6PbQ9xAVR1CsySmo0TOYfIxS3pY5Wq48G07nFMzO+l5cibfudHJfIgyPASqyVXsu9+OxWjaLT/NHhcc/lzyQLEan19Ca8pz6BR4RnyQyTQwdw9QJstyqgNk7uUxyuo9Hnuiyb9M7KTEbw4joD+rqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jy0ptpULIrIaQHkFmqz9EUUkQ6VNs3uETXiAjnVkFvU=;
 b=bb5E9cnKyKj7mFIKhA+fkGn9X3pMtevOQRWy8/Pth/SYKyAJ/GUwvZ+qq9hqBSPuXTYUGtXbvfn46uxSCrbZzhGRFwgbPk6qBTLaZnJT8K1MHCVyy1sKccKduEAKHnsS/Jxv8/6sjoGV/yaFBmf1Q2FdrU/ZVIzwlLwzlUdrXd8=
Received: from BY5PR17CA0025.namprd17.prod.outlook.com (2603:10b6:a03:1b8::38)
 by CH1PPF4CBE7339A.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 16 Sep
 2025 20:33:01 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::43) by BY5PR17CA0025.outlook.office365.com
 (2603:10b6:a03:1b8::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 20:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 20:33:00 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 13:32:59 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadnaik@amd.com>
Subject: [PATCH 1/2] EDAC/amd64: Add support for AMD family 1Ah-based newer models
Date: Tue, 16 Sep 2025 20:30:16 +0000
Message-ID: <20250916203242.1281036-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916203242.1281036-1-avadhut.naik@amd.com>
References: <20250916203242.1281036-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|CH1PPF4CBE7339A:EE_
X-MS-Office365-Filtering-Correlation-Id: 5581f079-2ed4-4606-6b61-08ddf5603aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hziFbaXRpSdGkUwEIOg+IKzeLYCYS63v2WDUZj0pnAmRLfHT7nSBegXxbnHX?=
 =?us-ascii?Q?OY1JB7Sk7iCDKnFuRvkzzApn4PBMZG5BR0uiCLUJos0uwUTlxyhAXI3LtXOk?=
 =?us-ascii?Q?cneOqPN8Vubl12H9yZ8tFofgiwQUpISBiSxUbpU4Qcfyl1NHyfZovdJAbGVq?=
 =?us-ascii?Q?o811pnrMc8cZgR3wwYYKEKvsMARzK7MLBgYgrQy+ybJ+wrd2lrMGJS2JoOyq?=
 =?us-ascii?Q?9MpCLbrEMScDFUzx4Vhwo6UOjuqXd+iMfXJrae2Rg0aWKPgsrrKgrzd0aRd/?=
 =?us-ascii?Q?AjJbBpO5wEzXP36PaoQvG07ZSVU+kmaEVMC8NWgzHm8itJAfwHygXlbOZKrZ?=
 =?us-ascii?Q?2Hp0/E814Fee86Q28FOQ/z1OdtnlToHhCuKfNej1JzHgM5N5JLqpqShOabAB?=
 =?us-ascii?Q?JpUDe8JD17xy1AK8msMAVVlu06tw31aRmkRMGIaA67ZKv9neo6C2mArJd6OA?=
 =?us-ascii?Q?N96mzBb9tY2PqY6v31ijdMkJ1dnOfGNetjXUs/4akuDjn8lr1my0xr3qen0A?=
 =?us-ascii?Q?B8q98NIw4bXjKr0ooWI8AmNTIXZmMAGGleaZt9e6Zyg5evX+E0jAj0lLJUJG?=
 =?us-ascii?Q?A58KJHX82rrVDdTyspsUOeKXFZi4gaBpYkLJTD5sYoz9wUZBS//Y8R2TDG5K?=
 =?us-ascii?Q?vDfjrHegkw03J7yy5RzLJpCOSwjN+mtd7812XQaVBT+mtwfY5+5d3QaPkz25?=
 =?us-ascii?Q?F0Lc53AMsDsmz6eB2lKgWGCvjRBaV5yChwyXc0O3PjkluafU16J3EDXaf+4L?=
 =?us-ascii?Q?LWzx7pHf/Lmsz8HR6CUksOIMO9M75EKTXKPbjcywL9I+7zS3GztET23ppgbi?=
 =?us-ascii?Q?HVgRU6+D3z/DzrHMUZAIsoFkOExqQ3o+MnMPND/zZkWQZTkMXllXcgWaGrHo?=
 =?us-ascii?Q?vdIpv9jWj8eG7JpY+yYrn3cXarQScXjsduaPUNmlReceDGZKm/DyPRQEKsCh?=
 =?us-ascii?Q?+wMEeRIcMY4+Kn5ZbdjFAIli7iE8l0Kzj1xvNGIyOyUeTnMdL9MxuM2Nu9CG?=
 =?us-ascii?Q?R5FZn+SVpPNvS8mK8OHzwtXBdx0ORAUre7uBbd7nXM7u89e7RCKOkBZcWdeC?=
 =?us-ascii?Q?B3nhSqz1FEA03caRlugSgsVgM849nwmlr2q4+i5tWHpb5210qZbd+Y2FUeey?=
 =?us-ascii?Q?fIHMl43oq0sGKr6v5Rsq05fwP8+3pmTAeevBuSso3z4jyeXw0otNiMS4IWin?=
 =?us-ascii?Q?UaOYnuIUXztLUQBXjUt/D4tYkdUxQ4Sr9o12tZ0FsIb9F36kIcuYBibakVjl?=
 =?us-ascii?Q?h+liiOqK8YTzXhmX26DBSbATlBBXfi4Z6VCtCU8XIW6UZAMcMt1qVmOLbbbY?=
 =?us-ascii?Q?dD60iHDG0cUNJ1eKuJ1eRUhz3n3Q+lIIO5PAT6Qncj6UlSGZiJZvSXHYxRKq?=
 =?us-ascii?Q?MXiHA00PK+rGr4gYH/bGB3ukhDoqO4NcyJtIQjAhDJfFOGVCODjh7J5Is/la?=
 =?us-ascii?Q?ubCEq6XqKQPEyW5y0o/6iLdofgTVYnUKkIecgtP0NyB0GmjUZiBsPGNxJYbY?=
 =?us-ascii?Q?8VTpCk4Vvo50ZP7HypgE5iq4h8MO44ccB5B2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 20:33:00.7148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5581f079-2ed4-4606-6b61-08ddf5603aca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4CBE7339A

Add support for family 1Ah-based models 50h-57h, 90h-9Fh, A0h-AFh, and
C0h-C7h.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/edac/amd64_edac.c | 20 ++++++++++++++++++++
 drivers/edac/amd64_edac.h |  2 +-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 07f1e9dc1ca7..2f6ab783bf20 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3923,6 +3923,26 @@ static int per_family_init(struct amd64_pvt *pvt)
 			pvt->ctl_name           = "F1Ah_M40h";
 			pvt->flags.zn_regs_v2   = 1;
 			break;
+		case 0x50 ... 0x57:
+			pvt->ctl_name           = "F1Ah_M50h";
+			pvt->max_mcs            = 16;
+			pvt->flags.zn_regs_v2   = 1;
+			break;
+		case 0x90 ... 0x9f:
+			pvt->ctl_name           = "F1Ah_M90h";
+			pvt->max_mcs            = 8;
+			pvt->flags.zn_regs_v2   = 1;
+			break;
+		case 0xa0 ... 0xaf:
+			pvt->ctl_name           = "F1Ah_MA0h";
+			pvt->max_mcs            = 8;
+			pvt->flags.zn_regs_v2   = 1;
+			break;
+		case 0xc0 ... 0xc7:
+			pvt->ctl_name           = "F1Ah_MC0h";
+			pvt->max_mcs            = 16;
+			pvt->flags.zn_regs_v2   = 1;
+			break;
 		}
 		break;
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 17228d07de4c..d70b8a8d0b09 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -96,7 +96,7 @@
 /* Hardware limit on ChipSelect rows per MC and processors per system */
 #define NUM_CHIPSELECTS			8
 #define DRAM_RANGES			8
-#define NUM_CONTROLLERS			12
+#define NUM_CONTROLLERS			16
 
 #define ON true
 #define OFF false
-- 
2.43.0


