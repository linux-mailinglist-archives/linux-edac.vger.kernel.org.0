Return-Path: <linux-edac+bounces-1501-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EDA92E42B
	for <lists+linux-edac@lfdr.de>; Thu, 11 Jul 2024 12:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7807E1F20F15
	for <lists+linux-edac@lfdr.de>; Thu, 11 Jul 2024 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453A6157A61;
	Thu, 11 Jul 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ARGj6EOl"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B55CDE9
	for <linux-edac@vger.kernel.org>; Thu, 11 Jul 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692438; cv=fail; b=PdsXOo+dVmNUwdPDgZFIXEvyOBWRMiau/MvZ8jrpYkN3xPy9BSnFOk9Duk2DNWGRYyaG5UCnwBS3tmu9X1x40InROigvjneWPWrIFdDzyZLWcSxZNjjDA5rRDu9ymLwcLIY+wbOXpXP7ES0LeZUhmq3Iq2NmuxgpsEXAGSs5bjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692438; c=relaxed/simple;
	bh=NK/FtU1uBosVeBJ/O1jKumhhVtgzA63AYL7jMWZhGEw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JJTkIt4FVR3RiYNgbzHHGSBdtFSS3omJhA6hcIhFGMz5VzXrUVQs48htyCYZC8YaLt3qNtWFKeWKS0JtSoRsqTsP/W4SojYmJBrNkNm0yAu6byFbVyQIySvePzrlZF+5bl0rty0NcJTxN91iwsde64+WBkzE9Z7jKTezVmFn32I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ARGj6EOl; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgEfYGtNr+0nf0cvyngUjxhhZy0o4ZcJevkPBbKHzYNCl0bLCAR7A0Sc/ZYEdxPsofO2alDq2ifs0S1IgM+4TTuueLx0skZs/GgTltUFKIKDIWfGbgaj5Oy9tSWY+P4iVl7uTXF6pXoOosH90hI1lYQuUYtCae99AqGwS+XTvhIhajEVWtzf7ez4Ilo8xgBSu/BHubNnmq34zd04UweI+srSHpD8PkZPZkQhS6TfKdfKJ73ocwPslYFXp7VPaVzjrH6lj2SKqXq7HxxdPYIkrOE/WSDnzJHnmUTly4IzUzkcdHb3Vy8v9CdgArQNs0gnJF/vRJ79pbOoXcaW6Q0PBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+JhoAn7Z1olQQVkuwgJv8KmKjotKt6KMbT9mVKvz+s=;
 b=UorL4/Y91WXxrHK7as0BOfPy32qPvwjUwJSW3Bdk47ppTuGY57J3BY0KMEyKJHdrnjMU1EF46uClDcrC/X/QUdIHE5z4kH2CiMnUaBircADRMCaKrd6PGaeY6ZzYXoJcay9gEhJcQJEho1HLCh0NdAtcxwuJ7nU18P8ecJGRTH6AKo4VF+xGbgffo620Xc37Zkf0PoQFZ06ls13LAkg6ZCFF8t4P0wGF6USr9brQEkvmOiROGOX5DeTJZ52nnwXDUeVsMw7l5pim+D6sCqRlxktvymq0OPrNr5N44YyvKtxuqdUBzDJkG/W79GwBwg7jwP7yG1M2JOyPnq5IQUNMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+JhoAn7Z1olQQVkuwgJv8KmKjotKt6KMbT9mVKvz+s=;
 b=ARGj6EOlei/cgerAWOIlO7tFrxE8gPoWCAMRwUQsZ15tw/RtVBf42VBJhfRcMzqnlRMOszMQ5kNUK5ptJznZgC2alRRdVPb97b/dXhvweCJyuNatu2vpT+UBZNMMjFLfDQu4ZOxwPVlW+/Szc4CxtU5AjSGeLbW9m3qOFr/Szuc=
Received: from SN7PR04CA0154.namprd04.prod.outlook.com (2603:10b6:806:125::9)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 11 Jul
 2024 10:07:12 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::d3) by SN7PR04CA0154.outlook.office365.com
 (2603:10b6:806:125::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Thu, 11 Jul 2024 10:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 10:07:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 05:07:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 05:07:10 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 11 Jul 2024 05:07:08 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <bp@alien8.de>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>
Subject: [PATCH v3] EDAC/synopsys: Fix the injection of the errors
Date: Thu, 11 Jul 2024 15:36:56 +0530
Message-ID: <20240711100656.31376-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: c261e2a2-e073-433c-2bbc-08dca1913bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AdvtqEOxIlQHtCxGUrfT0UzTFg5hblkMU9NkvQ8kPzz4djmD+WXyKAk+2Rzp?=
 =?us-ascii?Q?4YbnY2esmFvM876VX4fQPel5k7cX9Iw15Ru4T/TcHglkfyHShD57mYn3gkxX?=
 =?us-ascii?Q?ZmRpT7f/sMyMkE1iH+VK+mXcbZAy+i0BMeVo9Uvc3F6uQzg18CPIGC44rfU6?=
 =?us-ascii?Q?GtTf3rToGoRnwlBWLEUxmGbPghagSLUbQS+eaX/mbNmOCKOmsKpRApqE/pTb?=
 =?us-ascii?Q?v69gqa02DgheeRsAjEqRzKgArKmarQUMmBBdimPUCmhiE4KPwFSHFuC0+Pwc?=
 =?us-ascii?Q?mIipLdiSomOMpNhFvNcoMJ2ckQvI4Di+WZKamX/1D4aLd36ow3HIC6IjuCC8?=
 =?us-ascii?Q?3Jz6AmJYoCitZsJUEPganj9cXed4hMV65pYz7Y31GcFyrcHzjhdGCp7uzJ/w?=
 =?us-ascii?Q?1l8xTbhMo+/T3mbktbasy38Asu01SpBeCejwvK811Ix5dJGccvfN8/ZmmMGn?=
 =?us-ascii?Q?kKLK25j6pszU5yT/P+laAC0c+rm2yQh3yJGMBC0CkapmMEesxqN8YTWjc/DZ?=
 =?us-ascii?Q?RfTqANe2d2NUmuJLonJy0zOuCv45Ix9E7dPqvIht9t5M4mbHLPAsnZjh3Jyq?=
 =?us-ascii?Q?gqJWon8dB3kWAJeyn9v5SqNM89CoWdFw4NMwpVmwjp5e8IO+7GX3VEvByVpQ?=
 =?us-ascii?Q?WHBmP7Whi+/dfSB52QI9UV0QTwjdTK16KXqO/tDbZ+YYzbD4Tx06338P7VxJ?=
 =?us-ascii?Q?8pPjnVd5llKAgpBPAv9QV9Hz/WUCJku7Gh2vXwGTdTfnXKf0fhPper5QBFCw?=
 =?us-ascii?Q?kInwNxc2fGiFqzu0tbHZhync80g5wmB301IXTQXayAsvE8gE5I21shlEWI10?=
 =?us-ascii?Q?FO+SY8d/ysXAoQtOn7rWRBvArkWLEZ8sIoGZl1NN2N2hbcQkiFgSqY1ocqtf?=
 =?us-ascii?Q?VxgrYwRLfLDNHZxSKpec8eatuopvfYV5WHf29B5dvgTQZ0nHQkViVnNgOgH3?=
 =?us-ascii?Q?nv0bjpeN/bXOlSpAX2xxHUkiefcdbfUDyKRp3CdCK0sayQvT0zYiNNKhCGSH?=
 =?us-ascii?Q?Qb8IxLRkCmAMndBwBeA5t+3OMoZ7nnigBToX55GMZrlrIehsZF0BCGYWb2ht?=
 =?us-ascii?Q?GD97H+wnBakqI3wjA74FEtkzIYhWfwsz8RqB5JPHj/xM8J4rlIrvAldseWSc?=
 =?us-ascii?Q?WvzTUXEDHLNnf5rN19H2Wd6pfZbtlwbwsiYK7Abj+TPwCe7suQABa7pljMeo?=
 =?us-ascii?Q?2SemCVoR+5JOko3ezkIUQ45C3rrE1LmBpMTCYDkbwEf8XdfT8fZdUHBhYejw?=
 =?us-ascii?Q?ccNbcdaE8n4biXzz53Y8WTSagn8SdSnwqWg1qRKT8UuR1Hp7OhUresGHYUPu?=
 =?us-ascii?Q?0GOsxB9b4PwKpkIWG6CqlNaL+38KBAQ1wnZmYqiwOYfI+yuQ/+nKd/ooZQA+?=
 =?us-ascii?Q?j/M3Vrmnn91YXRdEfMFZ7vPlsfEvQutzk4YOEGlL5iBMODcV1/05y5p7rWL/?=
 =?us-ascii?Q?5UGzdqkd3zh65F9etAOOa+tjP9O6bnfp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:07:12.2425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c261e2a2-e073-433c-2bbc-08dca1913bc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760

The Zynq UltraScale+ MPSoC DDR has a disjoint memory from 2GB to 32GB.
The DDR host interface has a contiguous memory so while injecting the
errors the driver should remove the hole else the injection fails as
the address translation is incorrect.

Introduce get_mem_info function pointer and set it for Zynq UltraScale+
platform to return host address.

Fixes: 1a81361f75d8 ("EDAC, synopsys: Add Error Injection support for ZynqMP DDR controller")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v3:
- make the address u64
- declare the variables in same line

Changes in v2:
- get_mem_info under debug flag

 drivers/edac/synopsys_edac.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index ea7a9a342dd3..d7416166fd8a 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
+#include <linux/sizes.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 
@@ -337,6 +338,7 @@ struct synps_edac_priv {
  * @get_mtype:		Get mtype.
  * @get_dtype:		Get dtype.
  * @get_ecc_state:	Get ECC state.
+ * @get_mem_info:	Get EDAC memory info
  * @quirks:		To differentiate IPs.
  */
 struct synps_platform_data {
@@ -344,6 +346,9 @@ struct synps_platform_data {
 	enum mem_type (*get_mtype)(const void __iomem *base);
 	enum dev_type (*get_dtype)(const void __iomem *base);
 	bool (*get_ecc_state)(void __iomem *base);
+#ifdef CONFIG_EDAC_DEBUG
+	u64 (*get_mem_info)(struct synps_edac_priv *priv);
+#endif
 	int quirks;
 };
 
@@ -402,6 +407,25 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
 	return 0;
 }
 
+#ifdef CONFIG_EDAC_DEBUG
+/**
+ * zynqmp_get_mem_info - Get the current memory info.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Return: host interface address.
+ */
+static u64 zynqmp_get_mem_info(struct synps_edac_priv *priv)
+{
+	u64 hif_addr = 0, linear_addr;
+
+	linear_addr = priv->poison_addr;
+	if (linear_addr >= SZ_32G)
+		linear_addr = linear_addr - SZ_32G + SZ_2G;
+	hif_addr = linear_addr >> 3;
+	return hif_addr;
+}
+#endif
+
 /**
  * zynqmp_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
@@ -922,6 +946,9 @@ static const struct synps_platform_data zynqmp_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
+#ifdef CONFIG_EDAC_DEBUG
+	.get_mem_info	= zynqmp_get_mem_info,
+#endif
 	.quirks         = (DDR_ECC_INTR_SUPPORT
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
@@ -975,10 +1002,16 @@ MODULE_DEVICE_TABLE(of, synps_edac_match);
 static void ddr_poison_setup(struct synps_edac_priv *priv)
 {
 	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
+	const struct synps_platform_data *p_data;
 	int index;
 	ulong hif_addr = 0;
 
-	hif_addr = priv->poison_addr >> 3;
+	p_data = priv->p_data;
+
+	if (p_data->get_mem_info)
+		hif_addr = p_data->get_mem_info(priv);
+	else
+		hif_addr = priv->poison_addr >> 3;
 
 	for (index = 0; index < DDR_MAX_ROW_SHIFT; index++) {
 		if (priv->row_shift[index])
-- 
2.17.1


