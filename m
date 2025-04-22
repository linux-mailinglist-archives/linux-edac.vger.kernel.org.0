Return-Path: <linux-edac+bounces-3651-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C99A972A9
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 18:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDEE3B9689
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16F4293B6A;
	Tue, 22 Apr 2025 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wPxbDuz5"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F84290BAC
	for <linux-edac@vger.kernel.org>; Tue, 22 Apr 2025 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339054; cv=fail; b=WRKoRKkV6G9R67mcW+6zpyKvaTuBhjiE6Q5YGwmeus4Sd8CKph0HprzumSP0emNOVxtQCa10Ojsq/XBhJ1gr6vm6yjel607/JBoJLg1trHCAcFEulNeRm+2bwRMHlZ9iQaSeaIvNceB0aDjSJJ7uo942HTKAEC18oWcll1H+fkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339054; c=relaxed/simple;
	bh=BzW0e+7NtCIxAgeeDA9UNmrHhRWD1men+O7EQJLNl1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek8wH+M06BcAlJa7dvV7Kc1+wcqfHX1PoHm3XEr2UHpi1cTUPgGs/jAcr9wQ80P4J7MIJQqX5uLoGxc/m6IZQ2XsjzOQisswzd98cp0gd4f6Yh5LJxxlsuwYQzvCzRmzg9vzjsBDJnqm2tWEknJvGP3J4u2bvybKNob8jB3IpqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wPxbDuz5; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DN/jWX1shukcw9HpnN9x3Cm2b1c4h+BCnhMRVCXTgTPfY8rxFkKdPEfmkpRL+KFNsX2VwnnB0RGn67LrcNXz8NowRc9VdvembpKSjctdOvWmXvwU4vn7Cb24T7wh18kp3Ntr95hZ1Bs/Qdesm19kJX5/r6KXm8RUAMdAIAVe25yXr/noUIu3eYNcPbP3d4AjLBhdf26V3gmLZGJjbgfXXy0C3vaa1R3GF/EzpkO3LRPqPkZRtej/EVEcs2/5OkOIWMfa6eZIvGkC+6jk1pp8f/3KXw2aldQHnoBPYVmbythVs5LXEfOH/4PGEnSeTLS9fEiyU06Hih4QA2rs9a0Uww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btTasn+r4c2WytfX/ZcBAnuMsdFE1GTEiP6tJ8yvI+A=;
 b=zPD04V495REe57tdS5neFjVUa1ASXU8gvLZ74pmt6Hm+gcJUPY4EMthgJrls8fhYWFpgYuPoXMQrICFRFCjmyTHuShxTZPJjmOI8Ck4ZxPH5sJePMcSLtHM5Za30NCbV1ST6yCvXyJ9V7i4+7WxsH2dCBq1X1qTkxl2dbxg+7F8G5IHU34gMWYOAzsM8QGI3zzJvJ9ljL9K2VNc+f/07mOActmRd7I141DB/4qezTqXtI6pN8D61YJ+sEPQTa72/h67V6YrtbXR/xrDzPUa07fNjMRAla1vQxEXpcKb0yvLmsUGkVPZucKgltMv4y7sltvqzP+cb5NvbWRKBAGphUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btTasn+r4c2WytfX/ZcBAnuMsdFE1GTEiP6tJ8yvI+A=;
 b=wPxbDuz54PhTo6wPRJrIRP4/FDOi9wq/QvdDulqsupZDwwbUUN/9DALdPTHh3F2KFeqHUoChqlWl05kEvshquby2bGPe5O7o0skMQfARRAWwwBscLa/sqnUrXiCQv/hbP293Q4njfiO6tg4tw/PAGu/wuYIXofmyFyyHwEe/e2E=
Received: from SJ0PR13CA0196.namprd13.prod.outlook.com (2603:10b6:a03:2c3::21)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 16:24:08 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::ca) by SJ0PR13CA0196.outlook.office365.com
 (2603:10b6:a03:2c3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 22 Apr 2025 16:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 16:24:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 11:24:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 11:24:04 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Apr 2025 11:24:03 -0500
From: Rama devi Veggalam <rama.devi.veggalam@amd.com>
To: <linux-edac@vger.kernel.org>, <git-dev@amd.com>, <michal.simek@amd.com>
CC: <radhey.shyam.pandey@amd.com>, Rama devi Veggalam
	<rama.devi.veggalam@amd.com>
Subject: [PATCH 6/6] MAINTAINERS: Add maintainers fragment for XILSEM
Date: Tue, 22 Apr 2025 21:53:47 +0530
Message-ID: <20250422162347.3217007-7-rama.devi.veggalam@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20250422162347.3217007-1-rama.devi.veggalam@amd.com>
References: <20250422162347.3217007-1-rama.devi.veggalam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: rama.devi.veggalam@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 91288653-fe3c-4d8e-20d4-08dd81ba1bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pWTssPOjpYn+e/dRYaASkMqEgGjPh/D1TVbk40Hqsllpz0d0OIloYEddhCS9?=
 =?us-ascii?Q?SKH80+qtQeTASSeZYmkhs5+37hq/t824PV2txY5xeMi1zOCTIs6K3YK76K6O?=
 =?us-ascii?Q?sKB0qYf1nD1fpPwmQiinHx4GX1/oV7uYFKtjLqSp+vZXUIK9aKS/WSMQitdi?=
 =?us-ascii?Q?PXZq8XykpO9HhNMAWhviUlaARuOuaMpPhEDkXHqYnRoArG3TDrATVZ8scMaf?=
 =?us-ascii?Q?ad0ZNaWa1lOkkA2VPg1PeyCvhFJrMZ/zyEAiUE/YEIx5vRirWL1GCHKRteoR?=
 =?us-ascii?Q?ifyLODPc79MhT7sqwomwYH/oSc4ui1Y7LDiexg6E5Xp6yyQGUPsmmYf/1FMy?=
 =?us-ascii?Q?cdSFpwoUtGQMyye51VrCMlo2gge3cIl5GF1Sjz/s95B/GERHMQeUV88pEQIX?=
 =?us-ascii?Q?yLZ8l//oJ7UoqzA1sdHBQ5zaYu6vW4qYJszRzjPcYZcGXfG9Ovlz9pbn8fyr?=
 =?us-ascii?Q?8ukkSwWthS5r/xoVAwbp9waayuU6BQ1ezGlT4djU5P395vezFxgpB7P24myR?=
 =?us-ascii?Q?8CqTgaQvOkPD+bVlmHqUxbvB4ALm9bbjws7PIHiCVc3jfSuBb6590APzuL5x?=
 =?us-ascii?Q?mB2kMveVkpBWyahishT83buC3F5qUjFgDXY0dUtLVjVAuAWxVyF39kiHXF2P?=
 =?us-ascii?Q?lH4usjoDYxwRX7dxfzYc5qe1EFAztYn/wLLov2toHJnLMrfsgd5kN1Bwib+z?=
 =?us-ascii?Q?xz661lXdNSdp0Y870U2kbR/3ITQVm1AGQlgMTgyLRMjEZFJWgf7Cm98reJr6?=
 =?us-ascii?Q?vMSxyOn9u/J5ZBCxzWuPN14uqJcYlbUhppToJHcKaaSq7iTSG5SiGN6x6Nkp?=
 =?us-ascii?Q?CfIj3mnOqnCJtLv8fqd8Me7LilatlgEFHOaNouAOCnybNDu2oXHzFripFYmh?=
 =?us-ascii?Q?j6z0IacIEuTgIZzjeuyO8FCL+uCucQiey+504+pXe2D4uuITteC+2MVeBoJN?=
 =?us-ascii?Q?6/m8aV0/4//QgKnnc6eY7YVDcD7EpEIZOZR2O/19+38+UFaDnst994BW8nqD?=
 =?us-ascii?Q?wFaOMxgAvDeeVI3ylYcSQkf8ODOtir3/1yvu7WHYWfC+QmwZSVgyby4BcnVm?=
 =?us-ascii?Q?nSv7u7Jelw7sSwcBfZLvEKjaE2trDBADanES5I4R3tkfMyGg2PjtA4LAtT1F?=
 =?us-ascii?Q?qKOmsiklLjTjni3nKizNbyN8NUHEw1rxS/fpwAlATbPrusOpSA54P/KqknjB?=
 =?us-ascii?Q?eIsNYNtTTvKlSn7nzhVTbrJVE0JNk09HEK9jdgHOP3AkgEW/fbGZsVircMzZ?=
 =?us-ascii?Q?Tf8QWqwRaICH4eNy3cwGmBEiqBNFxFGmw0ihVkIXcrRYvGUENEiwG15cmK7/?=
 =?us-ascii?Q?af/k6MR2zBHOe1RZsMiMPUehzkA8YKT0Qup7v4HAEyhmeUD0l04b9dcW4jg+?=
 =?us-ascii?Q?/zjooaNzvh4mJNx4mehGzTuFmaRwiwIRmcav4tov0rXCZsHL/beUEW+CO4GD?=
 =?us-ascii?Q?HYfFuy7B2ULy+KVrxb1UH1aXjj4dzxe4Ol9lsnRyEXn3Bk6PJxzlt/rxnLES?=
 =?us-ascii?Q?8XtZ+xlE8aswAgaW/lobo28/EFLLG4zeHKxm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 16:24:08.3893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91288653-fe3c-4d8e-20d4-08dd81ba1bb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337

Add maintainers fragment for Versal Xilsem edac driver.

Signed-off-by: Rama devi Veggalam <rama.devi.veggalam@amd.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa1e04e87d1d..358954056bab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26621,6 +26621,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
 F:	drivers/nvmem/zynqmp_nvmem.c
 
+XILINX VERSAL XILSEM EDAC DRIVER
+M:	Rama Devi Veggalam <rama.devi.veggalam@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
+F:	drivers/edac/xilinx_xilsem_edac.
+
 XILLYBUS DRIVER
 M:	Eli Billauer <eli.billauer@gmail.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.23.0


