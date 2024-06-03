Return-Path: <linux-edac+bounces-1163-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 533C48D7AED
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 07:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7F81C20C62
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 05:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83C31865;
	Mon,  3 Jun 2024 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SceEEmS5"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FCC10E3
	for <linux-edac@vger.kernel.org>; Mon,  3 Jun 2024 05:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717391809; cv=fail; b=JVcHfTO/XHTOcYvlI+aYwV9VKcUxBGI+TUgCXNaquq3ES55fzIexki+/ECaA7HLgOa0IZ+HTU9StU7JkKlz0nIjJiSH+U+alrb34rgoOjYeOV+vBwi+R6cwpAtNk89dy5wrOV1njTuIdGNW3DKhDqNzIxqAI55K9oHQFZwRvrx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717391809; c=relaxed/simple;
	bh=KU91I14TLpEJrMinzJqe8uHCb3s+7ht9bc/IDb1Fvq0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NUZ+WmtwIq59se4p13ZfvGdNWWe2B9QiW2gV6I6Ijl7oYe1cOJ92669yVrVW16lkEKJV5biKTiIAt843gFv62XIQYJFegb7QHffukawc0QCKt1tCIeP6FY5XloqKuQCZ5O9iicNwSOUOSc+pUNpuWyq1i/WKV2t2Q/+6cYKzoL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SceEEmS5; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc2VaRjxTR6bm8huZFh1LBbqagGuH8ZMwhlMxU61vRxw9a4fe3aPntOZTOyVrVQYu3ddEsZRfWsV/kMzITTNQ0CYjfRCWZH5HGPuN1UMRIXRgksm+c0Cfpas4SsL71A2zLkA14KOZuSvc/OBY+O6x/vuUIuGNDcllozz+Dfb4f38VDwV+jw20jxzTAm+JhF4ODa62C8sm8wQ2+hBV0eSsLdYjv12Qr6ba94gRe4TgSAoM8YFrvQ6PWh7T9MYOJY+jPNKVOmx9pquy92DA9qs9wgNy+r4R5Og+j83rtY3HsGp+3kI5hZKn1krQw24mDe1OGb5nKM5f+shbOlBsIKPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYVzcSUMmndH72ETQDUNyd44qeZT1qiGuRRcNOaOAi4=;
 b=XtJXabMPRGIetPHDcur1iOI0cPolYvKYwqR1SN1wckvzQN1G2AJUeWHjBPWD/MiW5vm/dNM82G4mjcsdrMadm7+xfVDEjY2BVvE2xKRuDm4Tg/N12JyDcjpQDFGdnYm7l/uexicyiTkOry9txhh+pYNAwuRYpJ1cBNkIBWxYG2VrWEtddkHWKfTip9YJw5P4xoAbJsdzNQwhAxDK87bnlrlQRjh+FjOS+YssdOxPpwk4TMdB7DTHCsyHWWW2OxT0ZYUqpmPVpsxKzitN/mx5GYZqWhpGnxbdV4R8aIMJW/eCHSoFn0cP6LKRSd6vC6ff94PUZQVwTLYdeT80IFixNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYVzcSUMmndH72ETQDUNyd44qeZT1qiGuRRcNOaOAi4=;
 b=SceEEmS5jwnwnAXFxGs7aqmw0qQXXHosM4VA6Kp/3jqr+YPIgg+V1RAHn7OuQjCAGACTCUqRhJrLfFkfm+Hnzw2uUV73lbgyHZiRq4v/Fs67c1ZAkBQFR5JZmZ1L/gtYt1KI7bsC8zWM5iWAqlwOKuiGXy1FXCt89gYswxl0vQw=
Received: from CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::25)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Mon, 3 Jun
 2024 05:16:42 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::f) by CH5P222CA0009.outlook.office365.com
 (2603:10b6:610:1ee::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 05:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 05:16:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 00:16:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 00:16:41 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 00:16:39 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <rric@kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <mchehab@kernel.org>, <shubhrajyoti.datta@gmail.com>
Subject: [PATCH] EDAC/synopsys: Fix the injection of the errors
Date: Mon, 3 Jun 2024 10:46:38 +0530
Message-ID: <20240603051638.22332-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 2685fba6-0b7f-4340-d7fd-08dc838c5b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Sf2HepkXDiabpdRpjEQ9LVohJEpDMIKldPfYIVzopzGOnF59+uJcHkno+yu?=
 =?us-ascii?Q?Wo+eXnVVhv90nMdkMW6NmzhTZwHFD/r1MpkhAHUvkl7TiFY8JH2mj6N/pB5B?=
 =?us-ascii?Q?eZqPna+2cPgSQx6ElMea6KU/vZqOYJv5J1Myc/Y9IwxL77abw5Sl3/C5EE0o?=
 =?us-ascii?Q?tQz4KuAuxD9y9RWpOaFHskq3IbuQAwfY1lptq9mp+tHHaKQEKOeYy+R/+B7w?=
 =?us-ascii?Q?R4gu3lPTIB28Rru6bO4BMZ4gWy986vDY0DVncDADaFvvvdkZ/UVbN+kRzmGk?=
 =?us-ascii?Q?smU1so1zTJ1QphC5mOOtqXtIPF7DrqPj32esNLSUguAUqk3xjPtmuo+Q6o46?=
 =?us-ascii?Q?PXSsr2zDnjBjGBJwV1RB2QBZwSgswfx+dU58qoIu5KHEB3EoPwBWtZY2AJXI?=
 =?us-ascii?Q?0SyIsuyQ6DvNCfuWXIKHsIEwrO05E0UOboIY5koR4Ahvsx1fd7RGzX+Lhn/C?=
 =?us-ascii?Q?79ce549SEnvs70/VXZQGtOPLOUv9r0fK7k5VFBDAtYM4aAZlNlgp1CgfS9DC?=
 =?us-ascii?Q?qLbcW9uv+io0R1veu455MZ5DJkOrXSzQelfwtrFzd+spdx9fwXp+cHvrBfvJ?=
 =?us-ascii?Q?O7887nICy7u7geSva8NO4pmNBh6pDNsSfFq/RwPvsZ4z0sZ7Le5d/Rf0QLqd?=
 =?us-ascii?Q?j8GT8v/ZLHESc/hZThPalS8YVMaFJlOMOY06ncJaay518SGDL8GfGWvBzvOa?=
 =?us-ascii?Q?piD8EJBTlJQ2DfrzKPPfNTTDdenrJMt74KGhF06ac4jZdFqorDL5/pnlZqb+?=
 =?us-ascii?Q?MuZ1j8qDsyngAEqzdZ+L4t/kqHDFxUGQsV6vGCe2DP8om3ZO+JlX55QTwgq0?=
 =?us-ascii?Q?L9RwylyxPOc0kriz57ph6IgjHir2Hhc/LB1Uwf73H0Z5b3uFHmGIdSHWDX7t?=
 =?us-ascii?Q?LN0cCAU8a8Bm54m5nj2x3bIA4nRszuoOBBRu+Zkiuo379iT4SUqdvq6+KAOn?=
 =?us-ascii?Q?xhAuW3bjADwZFvDrPNyQszrhacwCQUxm70P/uRBp8RLg8/0WJdh5xIFrR8jD?=
 =?us-ascii?Q?TGnSFwhv/qDJs0UoOlQta9dhjLbhTivT6oQWdOtFSEm7KpUX6NymTxhu9Hqd?=
 =?us-ascii?Q?pnVJa+ioAdrQ5GJhyKtn2Cjqz9k/xz0/c3HeF95ZvsgS3NQb+VLb6PAHT95o?=
 =?us-ascii?Q?MBwPUNRf6nqMbiUtwNtrH1CwOc/dLN0VybwQtbhL16E5TUWjLRfoo/3GgIPP?=
 =?us-ascii?Q?ulokVCmkquNPH06QTAKn9U84zuQxOCt4Yi7wkfPdVa2iuZxsL3XQKIijI4ht?=
 =?us-ascii?Q?rCJS7+Ybat5UTzXARzPrlCszCRB62hIP/zs1vnb8c2nlyR9gURjTTVmXr2ow?=
 =?us-ascii?Q?t8OHR24oYVxJO+N8FtxiDGkrjN1dXTp+3lwJZF3pznM8TttMPNG3vPnHi3ky?=
 =?us-ascii?Q?LtbxOwf7Sjr8pc8MVyiWK20DbqL4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 05:16:42.6288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2685fba6-0b7f-4340-d7fd-08dc838c5b1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441

The Zynq UltraScale+ MPSoC DDR has a disjoint memory from 2GB to 32GB.
However the DDR host interface has a contiguous memory. So while
injecting the errors the address has to remove the hole.
Introduce get_mem_info function pointer and set it for zu+ platform
to return host interface address.

Fixes: 1a81361f75d8 ("EDAC, synopsys: Add Error Injection support for ZynqMP DDR controller")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/edac/synopsys_edac.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index ea7a9a342dd3..2e54a81c5d4d 100644
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
@@ -344,6 +346,7 @@ struct synps_platform_data {
 	enum mem_type (*get_mtype)(const void __iomem *base);
 	enum dev_type (*get_dtype)(const void __iomem *base);
 	bool (*get_ecc_state)(void __iomem *base);
+	ulong (*get_mem_info)(struct synps_edac_priv *priv);
 	int quirks;
 };
 
@@ -402,6 +405,24 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
 	return 0;
 }
 
+/**
+ * zynqmp_get_mem_info - Get the current memory info.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Return: host interface address.
+ */
+static ulong zynqmp_get_mem_info(struct synps_edac_priv *priv)
+{
+	ulong hif_addr = 0;
+	ulong linear_addr;
+
+	linear_addr = priv->poison_addr;
+	if (linear_addr >= SZ_32G)
+		linear_addr = linear_addr - SZ_32G + SZ_2G;
+	hif_addr = linear_addr >> 3;
+	return hif_addr;
+}
+
 /**
  * zynqmp_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
@@ -922,6 +943,7 @@ static const struct synps_platform_data zynqmp_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
+	.get_mem_info	= zynqmp_get_mem_info,
 	.quirks         = (DDR_ECC_INTR_SUPPORT
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
@@ -975,10 +997,16 @@ MODULE_DEVICE_TABLE(of, synps_edac_match);
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


