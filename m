Return-Path: <linux-edac+bounces-3702-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4F5A9AED4
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 15:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66584441A5
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 13:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5605727F72A;
	Thu, 24 Apr 2025 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aQsXuJT8"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB47927B51C;
	Thu, 24 Apr 2025 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500899; cv=fail; b=LqC0zJQP1vNtKLB/xW9OEBNndqo93dMZbWG2/cH45Cr9iAgYSqB3oyHUlWvaUQZDIkdHoLhueD6izyGm42jG5aNIjY6fzqgGpFH7ONDc7cVbKYSdlI7H/+QAqD0NoICQ7Ov7ufyqoQ7RGNruU0/noNZHjghzF9eFTyVYX52C49k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500899; c=relaxed/simple;
	bh=tPRphpFSm2hd3tYln+wWkvk4mMmDwBcBDCYUht2PZ78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7N06TFAW3JpgjnSklDH6mP+yK/V9sCRgN/4X7c1h/5zovaws5F469YWkAf7s8AwHRqtB7fkc9AXHpYj2Z9THWg5QQh/digtu/zULqDxITitpFK2tagjXEcFNoCVA5RW5eVc7ewaV4nk+zs+O9rOxr/26w5zHjjHX9XmxmMztvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aQsXuJT8; arc=fail smtp.client-ip=40.107.95.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGGCNXTriKNT/y6ox2+BW/y8RL+sm975aCAE8HUwHbn+h4E/yQocBbJ31Lvk52rUbTHwojZD8W8uFcq9640AUs0Fr9c+N7WmnmOvbkDbO/vZjXGx/bkwE9WIF06Ki0DTiTni0WC3lw7hwfyEnno8FmEB+869qdvd0caDgjaXWu9/Wg8rWBxiYCvjnzMprPqMKDqBc8AfMqFbiIusiqpr30bzDZsEDGQjc6TQR/TsHQR9+e2o6O4KEDeHe2HhRUIIwtbzzQ0RxXA7qbvgMEBJb8TvgeUgUHEAbOhE1WnK9kL1OUc2dplCAaTM5ujr9XFmkqhON+btfR+Aw6iAXS1Fmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfYj3ydOSot7WVWO5DMAEwexQeDay/88vs93cF+76M8=;
 b=I2Q1PdtBcoSXwYrmXtn9Hm4L1QGW+hgHkCFQiscNtmNT6oeNTqK32OdrWRrPspjwiuipc68Wi5KU8CMQ4b4TS3E/5AJHt8LmQOCNGgqbZ3BLK2XedFBkK3DRtQJF0uGdhO+UtDc50E0SPFTkaCmh9ESAOKtC4jf+AueuUyDmZNWu09i/uqRasJmoseYXP6k6wPE2w4Ez+ld2gOioWN/5ilf6pCmwQbmWKOYAWJXQNhde31DORY+v+7WY+ZWhXuBqQ78gQ7pZxMkjvzvzFcBvOztkq7IpfdpMp6MnzwOUNicvAkDbUg+x7cAK6r8he3h3Y+iPqBfMikt5YBULxPH+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfYj3ydOSot7WVWO5DMAEwexQeDay/88vs93cF+76M8=;
 b=aQsXuJT8h4MKcPkTSrYH32VHlQnu+YuTv7LUr1S+3PjYJ0ta6qy38o6hdDxBmNsCDPM+Wosig5uCoieS2pMWEko3evmmtta6KCC2hb/ngnhAhNn0F/nhV0+p1y9FhFLqcjTMverNylECYO7ZH91fryjlr1EuSKx04F1dQicbt9Q=
Received: from BN0PR02CA0047.namprd02.prod.outlook.com (2603:10b6:408:e5::22)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.24; Thu, 24 Apr
 2025 13:21:33 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::d9) by BN0PR02CA0047.outlook.office365.com
 (2603:10b6:408:e5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Thu,
 24 Apr 2025 13:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 13:21:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:21:31 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 24 Apr 2025 08:21:27 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <ptsm@linux.microsoft.com>, <srivatsa@csail.mit.edu>,
	<shubhrajyoti.datta@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH v6 2/6] cdx: Add DDRMC Commands for DDR Configuration Retrieval
Date: Thu, 24 Apr 2025 18:51:14 +0530
Message-ID: <20250424132118.17074-3-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250424132118.17074-1-shubhrajyoti.datta@amd.com>
References: <20250424132118.17074-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 6157b44c-2e6a-4a01-fb03-08dd8332ee98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vnZbR4B1qFK7uM0xBsuGLw/kq+7u75CQQMDeLXfr0qLK/1xrNzFE8WRz63JW?=
 =?us-ascii?Q?6rNHkjxjeWoNE6F2FybozO9gXHvVv7azfEkWHb2M0648jk41Ym1DBnGExJkG?=
 =?us-ascii?Q?H8akXRrhzS03BTIVM72+/pAj9iFv09z+pPOH7wkeSD4mvAoPC5ZaKtYf/v3Y?=
 =?us-ascii?Q?Ieja0JHBDnv/LIzZcEsKHlvaWj68HurMM1AIYTFKJT3pX9yw241C/TvVQ/LE?=
 =?us-ascii?Q?nhLXOJVdgjPettduxmueDhMLU29WQeZmhF1FV3IrNJbWvgZ2cJbB6lqBtEz5?=
 =?us-ascii?Q?QxSVrHUM0h/IbwHueV5uycWxH9KmhWv1upRR4Qc6lDxZx08y5+xq8qhaCNKD?=
 =?us-ascii?Q?9JLocUdPdiLuFwAf09FwawnjYg8fytfp/MLJtfNCfEDjTwEq4JW8N+z6XLaa?=
 =?us-ascii?Q?Eav550TbJ19H3FkGHgz3+mfA8a3NOWOYHwXwh+Bc+zQDwWPTSYBCfxE9tH5d?=
 =?us-ascii?Q?290Y/sxnpGgpYnyWsyy/hbi7kHHUMC+tf/Ow1zf0athEUiIAsFVmfl/kqAuS?=
 =?us-ascii?Q?vewcvgMWAQGu3iErqVmYaOskBLvpJ2/zHGNL7nmVTsWBiUBwQq5ZIVK7jZH7?=
 =?us-ascii?Q?L+WauqLm1UeLF9eCNcglB5cbJekIO4iYuVdY+t3WgcV7vdCOvTD/ezFua93n?=
 =?us-ascii?Q?evieJpRJg2dErDqcY8X0SKe45vFlfwqpS4qsc3Godt1m/Hz/2iG0F2KJ0ebp?=
 =?us-ascii?Q?ncoLiCi+Gr7oA/M4WC/OpI25QZ+WGvvJc/RdOfXM2xzMlZNZHcYEQRwabIG0?=
 =?us-ascii?Q?siMN/2Wz1+DawrcQ9o4epsZbcK/7r1lWr5zbJLdAoUISqWZLVUg1rZwCakfj?=
 =?us-ascii?Q?Ygh7T9LBt13y2GV+YB/CEGNHNPudbkIzfKkx2DHPbRK7RxM/YhvdhSTYO+8u?=
 =?us-ascii?Q?y4jCfw2yDK9c3y0Y8y/BvQw9haAE/gu6p6fAsGwE3ItwP2Y5L4wLOdXGuHnY?=
 =?us-ascii?Q?NLJKdeF5UskK1XVtWHNgnR4HdK8+fSiD+S2QVtlMOzdK+ICgvGQ8CoCyyULj?=
 =?us-ascii?Q?mpz2ibTRc9SlanxfqRKgwe58+KE0gZNBVX8t5Fe6KJ7Z5Zc2t6q+ZyHplaXm?=
 =?us-ascii?Q?J9sztzXLe2njD50PIYGC5rdTTjQA3uOeaoBEbONu6bLyiN+acckgdA1KCgLR?=
 =?us-ascii?Q?M/0pzgm9l39Fq4qdApHKA26cZsk60EP4wfFSfvM/V3L/tnETkdACzbAawBb1?=
 =?us-ascii?Q?RVeaNmfBoaDy90GRzlBXzAezOlwA0mBHd55uQNvpxVB+BhF4fM9LqnYUxJFA?=
 =?us-ascii?Q?gTYhAaYmhIDnxpjkl0pFtbnn2Bk6tGyxsLGzlxKFed2FqGbWyWXbZKY+GxAK?=
 =?us-ascii?Q?4yHxhJ7uKhCuQq4T45Eaqvuw2XB9LVe6qjzoeEI/n2S7ztpctz5O33Og20XH?=
 =?us-ascii?Q?162S2k6OWRrxQgSp/kQfzUhYFi99tSLDJyjfbRo2wGqJxR0vO4c3FYEM7UHs?=
 =?us-ascii?Q?u3Kjh4mdE4y/RdMSrRj1MmJ6y7w3QnQytwtBqiBzw8Sb1JvfuLrvbzUw1yqX?=
 =?us-ascii?Q?5NLOkM0BRGQWMaIgqAZYRnVzV7D0YqG3gjzS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 13:21:33.0647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6157b44c-2e6a-4a01-fb03-08dd8332ee98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695

Introduce new MC commands for retrieving DDRMC (DDR Memory Controller)
configuration details.
These commands allow querying the DDR controller's
configuration, including:

-The number of configuration registers
-Register values for the specified DDR controller index

This functionality is needed for the VersalNet EDAC.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v6:
 - Updated commit message

 include/linux/mc_cdx_pcol.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/mc_cdx_pcol.h b/include/linux/mc_cdx_pcol.h
index 832a44af963e..174270e148f3 100644
--- a/include/linux/mc_cdx_pcol.h
+++ b/include/linux/mc_cdx_pcol.h
@@ -302,6 +302,12 @@
 #define MC_CMD_CDX_BUS_ENUM_DEVICES_OUT_DEVICE_COUNT_OFST	0
 #define MC_CMD_CDX_BUS_ENUM_DEVICES_OUT_DEVICE_COUNT_LEN	4
 
+/* Number of registers */
+#define MC_CMD_EDAC_GET_DDR_CONFIG_OUT_WORD_LENGTH_OFST		0
+#define MC_CMD_EDAC_GET_DDR_CONFIG_OUT_WORD_LENGTH_LEN		4
+/* Number of registers for the DDR controller */
+#define MC_CMD_EDAC_GET_DDR_CONFIG_OUT_REGISTER_VALUES_OFST	4
+#define MC_CMD_EDAC_GET_DDR_CONFIG_OUT_REGISTER_VALUES_LEN	4
 /***********************************/
 /*
  * MC_CMD_CDX_BUS_GET_DEVICE_CONFIG
@@ -587,6 +593,16 @@
 /* MC_CMD_CDX_DEVICE_CONTROL_SET_OUT msgresponse */
 #define MC_CMD_CDX_DEVICE_CONTROL_SET_OUT_LEN				0
 
+/***********************************/
+/* MC_CMD_EDAC_GET_DDR_CONFIG
+ * Provides detailed configuration for the DDR controller of the given index.
+ */
+#define MC_CMD_EDAC_GET_DDR_CONFIG 0x3
+
+/* MC_CMD_EDAC_GET_DDR_CONFIG_IN msgrequest */
+#define MC_CMD_EDAC_GET_DDR_CONFIG_IN_CONTROLLER_INDEX_OFST		0
+#define MC_CMD_EDAC_GET_DDR_CONFIG_IN_CONTROLLER_INDEX_LEN		4
+
 /***********************************/
 /*
  * MC_CMD_CDX_DEVICE_CONTROL_GET
-- 
2.17.1


