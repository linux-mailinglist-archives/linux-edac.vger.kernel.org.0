Return-Path: <linux-edac+bounces-4406-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA15B0E138
	for <lists+linux-edac@lfdr.de>; Tue, 22 Jul 2025 18:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409571884C32
	for <lists+linux-edac@lfdr.de>; Tue, 22 Jul 2025 16:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0430C27B4EB;
	Tue, 22 Jul 2025 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p0aZcCD+"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D43127A930;
	Tue, 22 Jul 2025 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200243; cv=fail; b=fPNudMgNQKQJGq7yhh06c6WROrb+Di3O54nb07i8tJG3JcqvQo3J0cVDq2U1DJz+/K+RmQfQBuAadEioZopKoCk/uL9QCyHmeSRTIgMBfAqACayR1zkk7V9QNjv7K9GFP66X1jXi5lFigIuSnojMXLYMZJENujZR9evOUiJaPig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200243; c=relaxed/simple;
	bh=KphwHg6YA1ajpufpEL8lgy5oP0j13+OKNbkZj+4CZSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqFU1f14XnjlSVaZriYnRXjUBdCRR8Bg0BMjzorrd6CCJb+1hVV+O5UIgcMxXCjiFDG4kGAl8wCm9gdA7lQnskBtGIbvIlxJkdqH6cTjip481E5EjeQQW0W4cGnekZWSYI5hnpWbxhsMxmIIFBrAmk9TFqA5REFTWH5Y2LrTmyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p0aZcCD+; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NabTMGNCFSfmtbvlnrb4uP/T/LuQyRpUVqslaq03qTb03fOkSdeX+qgj7Bsa/RupZ3/zROsQ94ZserKCbDLgF2MhHb+Zl+OBbOh/rXbgb/L3vLpIZHRYccs7HzEbmI8DKxa+ZksBvD202v+hQky7mtCz8/gqWQ+WVfN2GwSzMQIKkIPp2HoUoCflAGNA8UmXlm6WWjPfU8soH1psIfCsrapzDOG80an65i1fy1/94xOsp7//vd0dO+iTd1D3yOmeXm+tnNEjPPkcal5tFLt1tsnR2ihNAyIDwE/zbV7XnQ2bmfkNGE9qGLeloqFbc/iPvrfbJcb2i8ODMMuMQEw/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhRMSVylKdaxherkRcPCp/IKwor7R2Ee/3TwyVRwbfc=;
 b=JOOBTtc7DarbCJPegLpla/4h9qtHsBkHCWhywwK9SsDGIMYcITHGqHj8g191NSG4VYKTrBIwGghJ5iNU6fk3uWsSDO1fLPRsIxut0cP+0LoBRtIFDamS1MYqejZXLXo/mMocXzCP9IZjJXfON+baj5ufzdcXzGDcfjTUVO0rMTgflkn7Rfbtb09seak3ZO/ieUBnKO4CJ6TQXdWI0PbOMcU/opq6pedSkYCg1XPYSaY74zGobHac/4aMIDlr6Oh0eCVSfJn4oZxsdFAAHF5DIGBy179dK1m8eUdsGCBv5oZxzLHhLaV53VHRn52DVy20txkg0j98zOagSOMLKxJVKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhRMSVylKdaxherkRcPCp/IKwor7R2Ee/3TwyVRwbfc=;
 b=p0aZcCD+DvzzbHFMv+gpN1rOwrsG+IYXebSTWADJSmGrXZHNBvLzN2cTHoYcCXkmaS68jMxwmr5W9mAGevKdKszJ9gHcPVq9SyVn8IeVunc+uzJndTGVtFxz5xs3ZXrBp8kqc2i1GlnLFCOLl/GQxcjZGM8nbI35adr9K20pTQc=
Received: from SN7PR04CA0154.namprd04.prod.outlook.com (2603:10b6:806:125::9)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Tue, 22 Jul
 2025 16:03:59 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::4f) by SN7PR04CA0154.outlook.office365.com
 (2603:10b6:806:125::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 16:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 16:03:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 11:03:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 11:03:53 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 11:03:50 -0500
From: Rama devi Veggalam <rama.devi.veggalam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <james.morse@arm.com>, <mchehab@kernel.org>,
	<rric@kernel.org>, <git@amd.com>, Rama devi Veggalam
	<rama.devi.veggalam@amd.com>
Subject: [PATCH v2 3/4] firmware: xilinx: Add support for Xilsem scan operations
Date: Tue, 22 Jul 2025 21:33:14 +0530
Message-ID: <20250722160315.2979294-4-rama.devi.veggalam@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20250722160315.2979294-1-rama.devi.veggalam@amd.com>
References: <20250722160315.2979294-1-rama.devi.veggalam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: af380bd2-8b4b-470c-dc6d-08ddc9395e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P/JciVfMQ4cnt2zreMBmqnaR2uULAHLvyoPj7KbL02LTkLE9o7h4VrbC/O3x?=
 =?us-ascii?Q?6STyyveyrAlbv9RQqhk3wZsGSnn5Je1zlnUjSKU0VpWUYsFKhYgP9nhaGyr8?=
 =?us-ascii?Q?CNx+bnpayCO9LnkuL3Djq48/foZm8azaKpwSQmqFbpTxBhTQQRakdbw1bYZc?=
 =?us-ascii?Q?VTTX2CORWA34i7/J5TnzyLESDXrZVdFU4rLP3FtzyhCKJXyCqeOw3ogQzZGC?=
 =?us-ascii?Q?BoYF7oO/+MTHGOFgWFp6b9UQzaT+JGA5+m6UoIjzKnkyl0ORm2FzaTJaHkiD?=
 =?us-ascii?Q?1FGGey4YI40f8kB/qNmNoMVK7gLDecrmMeibcU/8eaFOkDDjPaRUlfEKKpi+?=
 =?us-ascii?Q?zx2t+i2DcmGjGHsxKWw2qpCg6GT/9z8cOXAhF2x5ESfcAZa/Mpp+G4ZQR66f?=
 =?us-ascii?Q?9g2RnCxog/sH37LsJcibM0d4747CGOYIxoQTYtz6BFvuDJBmMsuTqKxVg59C?=
 =?us-ascii?Q?jJ2UZrbAjRQszBmelz55aC4/CtoaD+3eKj5tT75O7Opq2FA1gpINfUqbhWVe?=
 =?us-ascii?Q?1OA7vIgItIYd0vD4HCiePHB7+A9XceIZDHnLxctfhdLYM+x2Y7JE0JSqiu29?=
 =?us-ascii?Q?4r+qL19P8pxZeiQ/ccBqVNx+anodJTtJCtPqYCoJ0VsojM2Phi65FA7xVDAr?=
 =?us-ascii?Q?Xq1U+AkHBJi3p84ZRV0G9VQGjnLuNtQ3+N2KGSg9sHc9U8eFPxp0Q8ktksQM?=
 =?us-ascii?Q?7ypMNZlmvl+tLjwYou3L+Z+1RGx1uIDhxm1QtZtPZF1c+M1GoEFApNCZdXUV?=
 =?us-ascii?Q?qB94pQmGPALG4zAoyVhQq2OILQ24+xHPJ18rCd11w2uYzaf3hWUCs8tcL3JR?=
 =?us-ascii?Q?576SBrumgU7jqirBMI8sJL33+bLSAzH7MJnWXNVxuPWc6G4odZk7+7IpQTU3?=
 =?us-ascii?Q?2NDvny0aMKRlF6accLCEW1scZ7MD8NjXe7LwtwekNnCmQyf88XLIhyNeNBGa?=
 =?us-ascii?Q?ZVBstHHVzF5KDv1jdROfXV7PcYNME9MaUxwZmvxoDm4WqnRD8H6Bqby4g2HV?=
 =?us-ascii?Q?QbimNkRmTh3DWxD38CIjAZa7aGP/R6mARg59HnT+cmLqo/VbDA3fNZ6529h4?=
 =?us-ascii?Q?uMcxJepdpfpTOFtPP8ejjKE7PlaSxwcLrRowfJxrerPYgD1BBaOapGsJSx3R?=
 =?us-ascii?Q?+8+qa20WMS6Y0K80zwq74KCM7KlP/PKpoMihw9LjwBpKsVMaHXuyS8y3UtuU?=
 =?us-ascii?Q?wqLihtIWCO6Lin0iCgpF3DHizW8Lq5NmrvD02udGlktpVsY3AI74ebk/PpqN?=
 =?us-ascii?Q?gjl5ZHNKQj4WVGVkzfVgwJKjrkjhR8/DetfaJFr1nnU9rca4e+JPjTU9zaPv?=
 =?us-ascii?Q?fIZJyhMXCYTymynUhWMXRhj9C+TDw7FfjuJK0+7YNwgzg2ELrr5PbmdchYxl?=
 =?us-ascii?Q?Qv6R//euVputirgQZgU7przreak8++vvbVNxtiobaCJoGAgD6vOKN+HBTpXO?=
 =?us-ascii?Q?mU+vVfLLS5QDo/zwLYS2Zwqg2oofMe81RLNlp0gppKt/xPqtILbBuH5J9gsU?=
 =?us-ascii?Q?ey0tBjO2l0VaFK+xr6cYvqYlolDx4My78I14?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 16:03:59.0184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af380bd2-8b4b-470c-dc6d-08ddc9395e6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218

Add the ATF EEMI call support for Xilsem scan operations
Initialize, start, stop scan, error inject, read configuration,
status and register for software error events.

Add macros for XilSem correctable and uncorrectable error events.
These new macros need to be used during registration of XilSem error
events for Versal and Versal NET devices.

Signed-off-by: Rama devi Veggalam <rama.devi.veggalam@amd.com>
---
Changes in v2:
- Patch created on top of dependent patch series
"enhance zynqmp_pm_get_family_info()"
- Removed non-relevant SOB names in error event header files
- Updated copyright information
- Merged Versal and Versal NET error event definitions to firmware
driver changes
---
 drivers/firmware/xilinx/zynqmp.c              | 91 ++++++++++++++++++-
 drivers/soc/xilinx/xlnx_event_manager.c       | 10 +-
 .../linux/firmware/xlnx-versal-error-events.h | 49 ++++++++++
 .../firmware/xlnx-versal-net-error-events.h   | 51 +++++++++++
 include/linux/firmware/xlnx-zynqmp.h          | 47 ++++++----
 5 files changed, 227 insertions(+), 21 deletions(-)
 create mode 100644 include/linux/firmware/xlnx-versal-error-events.h
 create mode 100644 include/linux/firmware/xlnx-versal-net-error-events.h

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 17156eea78f2..9712ff353246 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -3,7 +3,7 @@
  * Xilinx Zynq MPSoC Firmware layer
  *
  *  Copyright (C) 2014-2022 Xilinx, Inc.
- *  Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+ *  Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
  *
  *  Michal Simek <michal.simek@amd.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -1643,6 +1643,95 @@ int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
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
index 6fdf4d14b7e7..f292a68ad5d5 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -3,12 +3,14 @@
  * Xilinx Event Management Driver
  *
  *  Copyright (C) 2021 Xilinx, Inc.
- *  Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *  Copyright (C) 2024 - 2025 Advanced Micro Devices, Inc.
  *
  *  Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
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
+		    node_id == VERSAL_EVENT_ERROR_SW_ERR)
 			return true;
 	} else if (pm_family_code == PM_VERSAL_NET_FAMILY_CODE) {
 		if (node_id == VERSAL_NET_EVENT_ERROR_PMC_ERR1 ||
@@ -94,7 +97,8 @@ static bool xlnx_is_error_event(const u32 node_id)
 		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR1 ||
 		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR2 ||
 		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR3 ||
-		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR4)
+		    node_id == VERSAL_NET_EVENT_ERROR_PSM_ERR4 ||
+		    node_id == VERSAL_NET_EVENT_ERROR_SW_ERR)
 			return true;
 	}
 
diff --git a/include/linux/firmware/xlnx-versal-error-events.h b/include/linux/firmware/xlnx-versal-error-events.h
new file mode 100644
index 000000000000..2d3be7c9e84a
--- /dev/null
+++ b/include/linux/firmware/xlnx-versal-error-events.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Versal Error Event Node IDs and Error Event Mask.
+ * Use with Xilinx Event Management Driver
+ *
+ * Copyright (C) 2021-2022 Xilinx
+ * Copyright (C) 2023-2025 Advanced Micro Devices, Inc.
+ *
+ */
+
+#ifndef _FIRMWARE_XLNX_VERSAL_ERROR_EVENTS_H_
+#define _FIRMWARE_XLNX_VERSAL_ERROR_EVENTS_H_
+
+/*
+ * Error Event Node Ids
+ */
+#define VERSAL_EVENT_ERROR_PMC_ERR1	(0x28100000U)
+#define VERSAL_EVENT_ERROR_PMC_ERR2	(0x28104000U)
+#define VERSAL_EVENT_ERROR_PSM_ERR1	(0x28108000U)
+#define VERSAL_EVENT_ERROR_PSM_ERR2	(0x2810C000U)
+#define VERSAL_EVENT_ERROR_SW_ERR	(0x28110000U)
+
+/*
+ * Error Event Mask belongs to SW ERR node,
+ * For which Node_Id = VERSAL_EVENT_ERROR_SW_ERR
+ */
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_XSEM_CRAM_CE_5: Error event mask for handling
+ * correctable error in Versal Configuration RAM which is reported by
+ * Soft Error Mitigation (XilSEM).
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_XSEM_CRAM_CE_5		BIT(5)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_XSEM_CRAM_UE_6: Error event mask for handling
+ * uncorrectable error in Versal Configuration RAM which is reported by
+ * Soft Error Mitigation (XilSEM).
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_XSEM_CRAM_UE_6		BIT(6)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_XSEM_NPI_UE_7: Error event mask for handling
+ * uncorrectable error in Versal NoC programming interface (NPI)
+ * register which is reported by Soft Error Mitigation (XilSEM).
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_XSEM_NPI_UE_7		BIT(7)
+
+#endif /* _FIRMWARE_XLNX_VERSAL_ERROR_EVENTS_H_ */
diff --git a/include/linux/firmware/xlnx-versal-net-error-events.h b/include/linux/firmware/xlnx-versal-net-error-events.h
new file mode 100644
index 000000000000..690337c6b9e7
--- /dev/null
+++ b/include/linux/firmware/xlnx-versal-net-error-events.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Versal NET Error Event Node IDs and Error Event Mask.
+ * Use with Xilinx Event Management Driver
+ *
+ * Copyright (C) 2023-2025, Advanced Micro Devices, Inc.
+ *
+ */
+
+#ifndef _FIRMWARE_XLNX_VERSAL_NET_ERROR_EVENTS_H_
+#define _FIRMWARE_XLNX_VERSAL_NET_ERROR_EVENTS_H_
+
+/*
+ * Error Event Node Ids
+ */
+#define VERSAL_NET_EVENT_ERROR_PMC_ERR1	(0x28100000U)
+#define VERSAL_NET_EVENT_ERROR_PMC_ERR2	(0x28104000U)
+#define VERSAL_NET_EVENT_ERROR_PMC_ERR3	(0x28108000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR1	(0x2810C000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR2	(0x28110000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR3	(0x28114000U)
+#define VERSAL_NET_EVENT_ERROR_PSM_ERR4	(0x28118000U)
+#define VERSAL_NET_EVENT_ERROR_SW_ERR	(0x2811C000U)
+
+/*
+ * Error Event Mask belongs to SW ERR node,
+ * For which Node_Id = VERSAL_NET_EVENT_ERROR_SW_ERR
+ */
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_XSEM_CRAM_CE: Error event mask for handling
+ * correctable error in Versal Configuration RAM which is reported by
+ * Soft Error Mitigation (XilSEM).
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_XSEM_CRAM_CE		BIT(7)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_XSEM_CRAM_UE: Error event mask for handling
+ * uncorrectable error in Versal Configuration RAM which is reported by
+ * Soft Error Mitigation (XilSEM).
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_XSEM_CRAM_UE		BIT(8)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_XSEM_NPI_UE: Error event mask for handling
+ * uncorrectable error in Versal NoC programming interface (NPI)
+ * register which is reported by Soft Error Mitigation (XilSEM).
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_XSEM_NPI_UE		BIT(9)
+
+#endif /* _FIRMWARE_XLNX_VERSAL_NET_ERROR_EVENTS_H_ */
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 4bfe314e99ef..69f545eee743 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -3,7 +3,7 @@
  * Xilinx Zynq MPSoC Firmware layer
  *
  *  Copyright (C) 2014-2021 Xilinx
- *  Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+ *  Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
  *
  *  Michal Simek <michal.simek@amd.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -69,6 +69,11 @@
 #define PM_SET_SUSPEND_MODE		0xa02
 #define GET_CALLBACK_DATA		0xa01
 
+/* XilSEM commands */
+#define PM_XSEM_HEADER			0x300
+#define PM_XSEM_CRAM_ERRINJ		0x304
+#define PM_XSEM_RD_CONFIG		0x309
+#define PM_XSEM_CRAM_RD_ECC		0x30B
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	7U
 
@@ -110,22 +115,6 @@
 #define XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET	7U
 #define XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG		0U
 
-/*
- * Node IDs for the Error Events.
- */
-#define VERSAL_EVENT_ERROR_PMC_ERR1	(0x28100000U)
-#define VERSAL_EVENT_ERROR_PMC_ERR2	(0x28104000U)
-#define VERSAL_EVENT_ERROR_PSM_ERR1	(0x28108000U)
-#define VERSAL_EVENT_ERROR_PSM_ERR2	(0x2810C000U)
-
-#define VERSAL_NET_EVENT_ERROR_PMC_ERR1	(0x28100000U)
-#define VERSAL_NET_EVENT_ERROR_PMC_ERR2	(0x28104000U)
-#define VERSAL_NET_EVENT_ERROR_PMC_ERR3	(0x28108000U)
-#define VERSAL_NET_EVENT_ERROR_PSM_ERR1	(0x2810C000U)
-#define VERSAL_NET_EVENT_ERROR_PSM_ERR2	(0x28110000U)
-#define VERSAL_NET_EVENT_ERROR_PSM_ERR3	(0x28114000U)
-#define VERSAL_NET_EVENT_ERROR_PSM_ERR4	(0x28118000U)
-
 /* ZynqMP SD tap delay tuning */
 #define SD_ITAPDLY	0xFF180314
 #define SD_OTAPDLYSEL	0xFF180318
@@ -627,6 +616,10 @@ int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode);
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
@@ -945,6 +938,26 @@ static inline int zynqmp_pm_set_gem_config(u32 node,
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


