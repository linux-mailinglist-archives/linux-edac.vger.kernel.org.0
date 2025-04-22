Return-Path: <linux-edac+bounces-3650-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7DAA97297
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 18:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399AE170B7B
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 16:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D2A2918EC;
	Tue, 22 Apr 2025 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zCnuZRjZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A902957D0
	for <linux-edac@vger.kernel.org>; Tue, 22 Apr 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339052; cv=fail; b=jyIM104gnt/jWyhCbuBQfyUG67SXttHumBe/PvMqijbKC0BmF9ezF20JUMlpGvoDUJphUifsmwlRE6zeMpokwfdhlBpopjSnj0N3lliXIW61FJoMVHtp4hDpHLKpahfm0E/W06XAJEhcKDGBeqvxF4WWsN+6VVDKozBqBMSySqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339052; c=relaxed/simple;
	bh=V5vp5lVOYVW5WI/0EfUVYPx8EJz20Hw1gDvKUzVnWIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ak4ytQKRshLi7brPI4G4BgAgAv6jYl9kGDp+GkwgOVtZS2XB6OaTbfsw+FR2hRs4GLeuhmQx7+47G+YVyCIcuCviGOIh1ArncRe5qEnKnBll1/J8luAbFwn5Jbo9KMQCxp7TCrWkM5YXBa5yca2t/8a7aZFlCmIT2XV36bYSQCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zCnuZRjZ; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w63gmH60vTEhI5V5usHPg6LYn2KB1f4FIcG0oNFhfUnLRvl/UNFjSnarrEpXb4TFyKFwUlrZDbwKnbNR2j5FTRiwFiQnqEBMQ3Bk6WHhQuOsH6CO0dljbjYjeRA3GVXjGg9HuQ/NAs5Q+bfyr0hdfHs5p4H5SvuIY8tgG9DPRnKFgYcgUwpRplIM4ZPfCzrnXzf7CO9CWBIU3exSPS6YZlbIfWqByHtvxl1FOdkGMcxvw75os3EIsaP/ib08MVq0MWH8+IJbGQSiRo9xbnenTO9+ZioX5X2hajT9ox1rtsD2v54HCvlOZuyOBXU0jP/Rgv77hIhSImNA1s+5KBbDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxNFjLJE+uY7J4N/d9D4bcfWx9TIY5VIyHOJfXapJtY=;
 b=ZBeDoXK5UhpnpHFFY5mtck3Y1No78zofQumHf4pWh7oUMA1wDLOJPhl6yrksb17CDGE2A2+R2k/A8C4uamqXLQFX8mj988F0yUWp5o/rn3zMh0aE6jg0O/PxmZ/atRMLlBLlAUGJPguR8rV0pkD/4tLNPKCM1dvx+7o1mXuAhWTcQfVjLQ3oXzqXbO5l2eU1wzGWz4j8A6RjI+xLWMoFJlXqoXo1/mk+jUc1TTzlMc8P0ShqI6jmEIOM9zNjfnP5oIYN1+WHDn+YAlqyxbVe+ozmq5cqx5e5pERSbCzrE0at5Qwb1jjjzoXs2A+yBZVQW89o21HaqCmSjbj6Bd9CPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxNFjLJE+uY7J4N/d9D4bcfWx9TIY5VIyHOJfXapJtY=;
 b=zCnuZRjZNFMMpxwoAmnicAV9lJdUHUO6JfapIXF40c0YHHetX0NqWEkjA83LnvIKX+/EaeVqlTwd1vBjdZ3vU9powYLbgVc4VuoVWzmyF7BBhOuRMHIoYpiCu21p9zFAc1MajPaW/dfF5+F/KI3WdJE8iSXyBR0Cy9tzUuF64B0=
Received: from SJ0PR13CA0182.namprd13.prod.outlook.com (2603:10b6:a03:2c3::7)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 16:24:03 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::28) by SJ0PR13CA0182.outlook.office365.com
 (2603:10b6:a03:2c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.14 via Frontend Transport; Tue,
 22 Apr 2025 16:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 16:24:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 11:24:00 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Apr 2025 11:23:58 -0500
From: Rama devi Veggalam <rama.devi.veggalam@amd.com>
To: <linux-edac@vger.kernel.org>, <git-dev@amd.com>, <michal.simek@amd.com>
CC: <radhey.shyam.pandey@amd.com>, Rama devi Veggalam
	<rama.devi.veggalam@amd.com>
Subject: [PATCH 4/6] firmware: xilinx: Add support for Xilsem scan operations
Date: Tue, 22 Apr 2025 21:53:45 +0530
Message-ID: <20250422162347.3217007-5-rama.devi.veggalam@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: rama.devi.veggalam@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: fd47d626-463a-4889-b925-08dd81ba18c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zIYSShuzfjezWdyb4ZE2LTy3JG3UVI8km9YrtTCFvCUVF80d//dzjDXKmkNg?=
 =?us-ascii?Q?EkOZxwTjISBmUk0U9VLwyJ8mzx2WB+u8tnP6GII61tHfhOUmVu7ms6ucqBZ1?=
 =?us-ascii?Q?P1pJbYARcXKlE+rOb2J/R/dPalYTjq9qY2y7YyMsjs2eWM+1Ji++ADCeYJXz?=
 =?us-ascii?Q?EkHV4KWeJtfX7kW9eZMQ5xa4kwqRBTAw9TPWcFBoyTx6hC8udublk+NfN0kd?=
 =?us-ascii?Q?fjA0AW0AJAx6lB2cn4aOTxTqzREvWMSc3OlpD4VdQ0Q1tE2MsSkF36goC8vl?=
 =?us-ascii?Q?O/0303Sh9J5eVNPo1+eX+Fn44EHgOEVc6LNAEHiLni8/sTyCyVmCAzaVuLRM?=
 =?us-ascii?Q?QhP7BlgXbO3ugQcggNYtRw7Tq3qqYuadEuG9Y0VLFVfkf6iwiX+S9aY7WLvJ?=
 =?us-ascii?Q?jFi7UJ/GoOsblUG5evSy6FYoNgw3tYlPTKs8mgJL1TnjAe1JILVNyxOoG6Pr?=
 =?us-ascii?Q?z0zUakumJsdkwhVKpnWcqPFAKKbvkwB+i13snE3/hKXS3zBRlqs7dIaXhKq4?=
 =?us-ascii?Q?gbpUGuvK0O9LbJYPH2rA6trfRrPHthaYjXoPvi9OXPAzgCWH+Oy1AWckf1wZ?=
 =?us-ascii?Q?d1E8zXHcP5BIALOmUjc4fWYIcIWZHr5+A5IFwY84yGbDV2D9fAkYnc8qdmrt?=
 =?us-ascii?Q?N571dmOXha0Up7wdLHzmHvCrACKuTQQZyTi+/EywHyU7wn9XB7woioDVngpU?=
 =?us-ascii?Q?HCDv2TgVmf9kuT3L+GPy1dx7boX8s/Qz9yAoRpSgkwWsMqL27LY6EcfZv4OH?=
 =?us-ascii?Q?Rl3BuDXtDR/BJ7N7BkDnAntOebEQUVCizOhOS5j+tSR74jPpHyMHALuBumgC?=
 =?us-ascii?Q?jm2WUiFbTerU7u0cXRz4AigTUujwcsHvWolwJChuEM/elETviEZVShkSEhTd?=
 =?us-ascii?Q?zVic+Hbd6tLNMrB8UK7Uw7oy2XFZDDMhk2r0YTO3gi7TSzDWnRnFrvxwHf6Y?=
 =?us-ascii?Q?fEeDQSTYU9IwF8uELWe6QFOAt9xkCQ0jMMx4twV11n04iZBOmSSnHpq9pjJN?=
 =?us-ascii?Q?q1G2we5gJlEa2juK/wH2q5pXHVDHsxuYbHFhB/Fjp2KPCDEQpaadgKhq9C7R?=
 =?us-ascii?Q?CyyYk+XNH/NU+PSFAcFh0A8ZgpOECSkIu/iG9AkYCIlFhQBovXLig5VDyDvu?=
 =?us-ascii?Q?uHK9MEX9Rd4v8LbaoV/2O+g8vXOSxdntVtvH0qiFa/NDJbVb/RzE+lUtxp52?=
 =?us-ascii?Q?XsQxqT5Osko094kmiMxW8+rOuJPh/NIQ26TuBSFAvEjfeBj4ChkvI0ReKDhU?=
 =?us-ascii?Q?3KoODDYkfQkOlJqs5JAvZJcjKcNzIjD7rXedMGUjWm0KA57KZO77JGrt/XL5?=
 =?us-ascii?Q?b1gMQBinTCjvg+v+lxPjHXCaJVbr7j9TPhy+/ai9249ZJqZVAcFAkoP7W4ya?=
 =?us-ascii?Q?XZts4UcKTW3nyWg09BgN8gWjcG5oibdwEm2/X/K7VLOKdlBpBPC4CDjFtbQ9?=
 =?us-ascii?Q?afROixcTlPZMeDVkXMO1PFOwfoEZU+O3LQKTXI2PG345Gq970Cg/n7HBTz3S?=
 =?us-ascii?Q?lY/s98c8qwVYvIfU4D124GRgWYF5QLFHoZ9u?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 16:24:03.4674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd47d626-463a-4889-b925-08dd81ba18c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161

Add the ATF EEMI call support for Xilsem scan operations
Initialize, start, stop scan, error inject, read configuration,
status and register for software error events

Signed-off-by: Rama devi Veggalam <rama.devi.veggalam@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c        | 91 +++++++++++++++++++++++++
 drivers/soc/xilinx/xlnx_event_manager.c |  8 ++-
 include/linux/firmware/xlnx-zynqmp.h    | 29 ++++++++
 3 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7356e860e65c..bae2ae3444e5 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -14,6 +14,8 @@
 #include <linux/arm-smccc.h>
 #include <linux/compiler.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/firmware.h>
 #include <linux/init.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
@@ -1645,6 +1647,95 @@ int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_gem_config);
 
+/**
+ * zynqmp_pm_xilsem_cntrl_ops - PM call to perform XilSEM operations
+ * @cmd:	Command for XilSEM scan control operations
+ * @response:	Output response (command header, error code or status)
+ *
+ * Return: Returns 0 on success or error value on failure.
+ */
+int zynqmp_pm_xilsem_cntrl_ops(u32 cmd, u32 *const response)
+{
+	u32 ret_buf[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_XSEM_HEADER | cmd, ret_buf, 0);
+	response[0] = ret_buf[1];
+	response[1] = ret_buf[2];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_xilsem_cntrl_ops);
+
+/**
+ * zynqmp_pm_xilsem_cram_errinj - PM call to perform CRAM error injection
+ * @frame:	Frame number to be used for error injection
+ * @qword:	Word number to be used for error injection
+ * @bit:	Bit location to be used for error injection
+ * @row:	CFRAME row number to be used for error injection
+ * @response:	Output response (command header, error code or status)
+ *
+ * Return: Returns 0 on success or error value on failure.
+ */
+int zynqmp_pm_xilsem_cram_errinj(u32 frame, u32 qword, u32 bit, u32 row,
+				 u32 *const response)
+{
+	u32 ret_buf[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_XSEM_CRAM_ERRINJ, ret_buf, 4, frame,
+				  qword, bit, row);
+	response[0] = ret_buf[1];
+	response[1] = ret_buf[2];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_xilsem_cram_errinj);
+
+/**
+ * zynqmp_pm_xilsem_cram_readecc - PM call to perform CFRAME ECC read
+ * @frame:	Frame number to be used for reading ECC
+ * @row:	CFRAME row number to be used for reading ECC
+ * @response:	Output response (status, Frame ecc header, ECC values)
+ *
+ * Return: Returns 0 on success or error value on failure.
+ */
+int zynqmp_pm_xilsem_cram_readecc(u32 frame, u32 row, u32 *const response)
+{
+	u32 ret_buf[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_XSEM_CRAM_RD_ECC, ret_buf, 2, frame, row);
+	response[0] = ret_buf[0];
+	response[1] = ret_buf[1];
+	response[2] = ret_buf[2];
+	response[3] = ret_buf[3];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_xilsem_cram_readecc);
+
+/**
+ * zynqmp_pm_xilsem_read_cfg - PM call to perform Xilsem configuration read
+ * @response:	Output response (status, config header, Xilsem config)
+ *
+ * Return: Returns 0 on success or error value on failure.
+ */
+int zynqmp_pm_xilsem_read_cfg(u32 *const response)
+{
+	u32 ret_buf[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_XSEM_RD_CONFIG, ret_buf, 0);
+	response[0] = ret_buf[0];
+	response[1] = ret_buf[1];
+	response[2] = ret_buf[2];
+	response[3] = ret_buf[3];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_xilsem_read_cfg);
+
 /**
  * struct zynqmp_pm_shutdown_scope - Struct for shutdown scope
  * @subtype:	Shutdown subtype
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index a572d15f6161..4a7bf6094d0b 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -9,6 +9,8 @@
  */
 
 #include <linux/cpuhotplug.h>
+#include <linux/firmware/xlnx-versal-error-events.h>
+#include <linux/firmware/xlnx-versal-net-error-events.h>
 #include <linux/firmware/xlnx-event-manager.h>
 #include <linux/firmware/xlnx-zynqmp.h>
 #include <linux/hashtable.h>
@@ -85,7 +87,8 @@ static bool xlnx_is_error_event(const u32 node_id)
 		if (node_id == VERSAL_EVENT_ERROR_PMC_ERR1 ||
 		    node_id == VERSAL_EVENT_ERROR_PMC_ERR2 ||
 		    node_id == VERSAL_EVENT_ERROR_PSM_ERR1 ||
-		    node_id == VERSAL_EVENT_ERROR_PSM_ERR2)
+		    node_id == VERSAL_EVENT_ERROR_PSM_ERR2 ||
+			node_id == VERSAL_EVENT_ERROR_SW_ERR)
 			return true;
 	} else {
 		if (node_id == VERSAL_NET_EVENT_ERROR_PMC_ERR1 ||
@@ -94,7 +97,8 @@ static bool xlnx_is_error_event(const u32 node_id)
 		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR1 ||
 		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR2 ||
 		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR3 ||
-		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR4)
+		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR4 ||
+			node_id == VERSAL_NET_EVENT_ERROR_SW_ERR)
 			return true;
 	}
 
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 6d4dbc196b93..626418fac816 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -75,6 +75,11 @@
 #define PM_SET_SUSPEND_MODE		0xa02
 #define GET_CALLBACK_DATA		0xa01
 
+/* XilSEM commands */
+#define PM_XSEM_HEADER			0x300
+#define PM_XSEM_CRAM_ERRINJ		0x304
+#define PM_XSEM_RD_CONFIG		0x309
+#define PM_XSEM_CRAM_RD_ECC		0x30B
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	7U
 
@@ -633,6 +638,10 @@ int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode);
 int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
 int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
 			     u32 value);
+int zynqmp_pm_xilsem_cntrl_ops(u32 cmd, u32 *const response);
+int zynqmp_pm_xilsem_cram_errinj(u32 frame, u32 qword, u32 bit, u32 row, u32 *const response);
+int zynqmp_pm_xilsem_cram_readecc(u32 frame, u32 row, u32 *const response);
+int zynqmp_pm_xilsem_read_cfg(u32 *const response);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -951,6 +960,26 @@ static inline int zynqmp_pm_set_gem_config(u32 node,
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_xilsem_cntrl_ops(u32 cmd, u32 *const response)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_xilsem_cram_readecc(u32 frame, u32 row, u32 *const response)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_xilsem_cram_errinj(u32 frame, u32 qword, u32 bit,
+					       u32 row, u32 *const response)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_xilsem_read_cfg(u32 *const response)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.23.0


