Return-Path: <linux-edac+bounces-3652-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924CCA972AA
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 18:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F8C40324E
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA9D2918F0;
	Tue, 22 Apr 2025 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZvN2nRfz"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263C296146
	for <linux-edac@vger.kernel.org>; Tue, 22 Apr 2025 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339055; cv=fail; b=ST1k8hMCllU2ynuzF4o7uUm9pwauTShY/k/0SdXHgBjVlAYhtnmgoQXcUTZb7q+XCsFZVUO3JSGqW9OaPGrDbYvDxPgZqZeqvJNXPPanrmpO/ljBomgq8H+5C6VO2YoJMkV0AzynaA+Lw1fs+GnoKd7k4PTrBgrPYNyrrX1TAl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339055; c=relaxed/simple;
	bh=+NgKt4oB+7TEGU9Xiiij+kWBg0Il1HzBdNgBgVWYMbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hp1zeXpX3hfMjUBuksSFNz45juXn/RdwNABUvNgoYuzW74oY+7qp+D0xcTEo+b51pyr20Y9Ouvr4oYnhTcvV8l3dqnXzeVSaQpTuF+4CU8oTI7qLuM1awkzyX4v7BrtnHkmVGF3MFvCJ+ZMQgfDJXlQ/2WKrO8Tc4lfL/KTXJe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZvN2nRfz; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/jU+LUKH2Op2BN3DnIcTGSmuURBNleRXA9p/4NFKs/dVUvUlhWkS5VRdtJPPY6o3SF/8c+tkwvEThncb9oUb/O1Z+rKbEkivEgD6slqQgYVSG3xtWd2HUwk6C8aA9TqwQsZsToUfvHiL8vuTxjp2Mk2StRxiURm/wkdojK+N+cTf3/thvfy2py6vtIGQc8U6VNsvytddcTlkmOGnSnMomQsiVkzM3v+I7PWyCYUhvcL12R1swo7EQ8XSdGDvBHS9vHhlBYgkyEu3ut3pteskn215lP2CIebDftgqMR9GGpEc56Iy2cXrjB3D6Tvl+c/q930E4/4lkHdqWqu/T9XwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viIMPw8FkA61bPpHwPJxki6lkGfMS+o3FnhDca+YEHY=;
 b=ro71E0xf26HDrVC6jOJbDvHie7+gE5FQajPAbhe4zTvQFlI812yae6O8iEqNfdjXVyQhUnyXvEzT6MJLW7yzREJm6W79kfhjHN6Hx+aCbN6WyaKYXUCjuoAKQlYPNW49f+F6Gk8C5oGEMV2cLx4CVY/VpIRh1bNOUIAS9W2qdiLWJiZdn9ZU9h9agceC2UEoxXAQILttBBOwFV/B/z+0rOS7twOyQHn5zCx/3i9/YlnVtIdbR6zDZDyCWv1B5i+9qeadPB3IeD8wTDAycOf+J7ICP56ePk4rwMmvTpCw3oXeR8hmeiekHnQ+N2uzLNkQu8SPlo9wJ73M6J6JEOid9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viIMPw8FkA61bPpHwPJxki6lkGfMS+o3FnhDca+YEHY=;
 b=ZvN2nRfzU3FUZMVfaF4p3mYQBOegp/Ow06ckAwyh6UCP2I/PjIFalbDziVd0/JRWBP1+C8+pUST4/vInh5rdqy+Wn1SmBo5jmAvisoBsJcg3QO6Njssy/EbDFLrRxieKngOQeeGQweMVCkC0jtiRwF8F/pITZoHnVVsiUEWaQPU=
Received: from MN2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:208:23c::19)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Tue, 22 Apr
 2025 16:24:03 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::5a) by MN2PR18CA0014.outlook.office365.com
 (2603:10b6:208:23c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Tue,
 22 Apr 2025 16:24:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 16:24:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 11:24:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 11:23:58 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Apr 2025 11:23:56 -0500
From: Rama devi Veggalam <rama.devi.veggalam@amd.com>
To: <linux-edac@vger.kernel.org>, <git-dev@amd.com>, <michal.simek@amd.com>
CC: <radhey.shyam.pandey@amd.com>, Rama devi Veggalam
	<rama.devi.veggalam@amd.com>
Subject: [PATCH 3/6] include: linux: firmware: Add XilSem error events
Date: Tue, 22 Apr 2025 21:53:44 +0530
Message-ID: <20250422162347.3217007-4-rama.devi.veggalam@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: 81fe5d3c-26f9-4851-5589-08dd81ba1857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8XRo6s0Dk8nITuHea2SkNUK+WNIwR/ZSZUUlvETay8njqETkw9tJm+AM+sS4?=
 =?us-ascii?Q?hbEJVJLcKTZRGBk5HEyfoVqQDRGVpN20losm/77KjiREEpYipxY+KHMO/7S0?=
 =?us-ascii?Q?bhSXj01TsbSfdFYEBPYn+OxFGmHuU4nHEztifuTMNHWztgpVRFyBLw4lg6Z9?=
 =?us-ascii?Q?ekpCMTscda/vy2ss0yQsYepjDKDznofsFlszWkz2uZXBmx130tNT7eSRSqDN?=
 =?us-ascii?Q?61fyWYdyf4WRuZD/v8BN+0f+9jzSh87iMA4xuslscvFpvKkWVHFeDsov+5RT?=
 =?us-ascii?Q?HYpjYCca2A5KVIC7dKTncRKQXD/s9SkcAZyDmOwUwL0p9/YcUq4rJPpv6/KG?=
 =?us-ascii?Q?IoruYAgNTIFQbr7b3iKGAZxjzXUS0BTxndaA/O8UswyH+2YonpZipMnIUQTI?=
 =?us-ascii?Q?n6ZS4idYbGGAayug9/Z0HUBROWYE0nJQT7cxTyjNYyUUzxD7b24GMUS0Wjy9?=
 =?us-ascii?Q?muugf4JRejYpQTPaqxsViPSsRzTTGYzLsv20Axj7A0vndHN04srh3pMtP/Cl?=
 =?us-ascii?Q?9NDXfLK+VZvCEDL30+36eyvA8XhgAm1y3VWxBOCfXmwvPTtwaNVqCP+HuoTr?=
 =?us-ascii?Q?Z2uAEEKb+n0ZsRKjzfCXZIxnMYaRiY6/h0+l8TzU60et+hty2LUJKdUzbeGv?=
 =?us-ascii?Q?atmQxtA3lYlMKenVxAbvdj7fDj9isRztgg1Jvn91etFMo7fNuwiue7VNJqxE?=
 =?us-ascii?Q?hy0q3Q6OqguHANpM5TBHX0ASd7/sUncvpz/5OJL6pft2eLXc9KyAT/nKlQXZ?=
 =?us-ascii?Q?UgWZnn8VdCa9IxvWgKXzq/o1nglFcNfrV+JO8rYokg1143BDZC/lljlBw+Xc?=
 =?us-ascii?Q?JnBbypBR+snVSsmORjAH/SlFgjGLN1WUSHEqLjXwiSPbnoAgTLkdx48UJyL6?=
 =?us-ascii?Q?muNOiGJEn76d2sbtD8bGCd03sE5LYkUMRIoemk1xs7O8K2uNW0sVogY3lreu?=
 =?us-ascii?Q?Nz8wToc8ECosL7Uf0oMss/HaXrsLbDAeqYh+gLUF99P08jslsUP7JCoe8mHR?=
 =?us-ascii?Q?+2A/y0OV7gQ6KMnqL/bePyO8/bMPervKzxkV7DsfwX5XXjFBIqhEsVjV9UVd?=
 =?us-ascii?Q?LU8D48LJ5OuD2sZVS6rWskWq8+I8ulcU6TeJGyZxcJbBrwGez1zju4qTHGMi?=
 =?us-ascii?Q?lTqVza7BA+PeYOltvLD1bmEJ1dMgj76wRkPdOSuXy4n+57FR4QyabR7VBfju?=
 =?us-ascii?Q?sL7Zyc4ZahDVnUX9+gDWIXTCEPGVK/XQNx39nsDPnvA8KsT28wAVGN5mGm2d?=
 =?us-ascii?Q?vN2ZmygqMGqkiCiskdc6MYNMDVGqBZ0h/sDD2F/i31rDhNjG6iw9tf6/QnKF?=
 =?us-ascii?Q?Q9aI0hUbwqJT+4reS4xPyWvsFy6VaynlyV8QqnrNjZS7Cv+t1rgGkt4XZCMh?=
 =?us-ascii?Q?+TzxOKHsqarAEz0BvuNl5Q4JUNxR+qKtqXNBU5OTqIfUNpcTKhoSbpC4Mcgx?=
 =?us-ascii?Q?9lGXWpfIAzxb8FvRgr575iw/I9P4KnYJWHCPqn3rOnC2VC51+SDnZAde7o8D?=
 =?us-ascii?Q?aCwMHjqTgd9R3WwohnAYvnt2iSEwmSuSx212?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 16:24:02.8286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fe5d3c-26f9-4851-5589-08dd81ba1857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734

Add macros for XilSem correctable and uncorrectable error events.
These new macros need to be used during registration of XilSem
error events for versal and versal-net devices

Signed-off-by: Rama devi Veggalam <rama.devi.veggalam@amd.com>
---
 .../linux/firmware/xlnx-versal-error-events.h |  663 ++++++++++
 .../firmware/xlnx-versal-net-error-events.h   | 1125 +++++++++++++++++
 2 files changed, 1788 insertions(+)
 create mode 100644 include/linux/firmware/xlnx-versal-error-events.h
 create mode 100644 include/linux/firmware/xlnx-versal-net-error-events.h

diff --git a/include/linux/firmware/xlnx-versal-error-events.h b/include/linux/firmware/xlnx-versal-error-events.h
new file mode 100644
index 000000000000..44121c6de938
--- /dev/null
+++ b/include/linux/firmware/xlnx-versal-error-events.h
@@ -0,0 +1,663 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Versal Error Event Node IDs and Error Event Mask.
+ * Use with Xilinx Event Management Driver
+ *
+ * Copyright (C) 2021-2022 Xilinx
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
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
+ * Error Event Mask belongs to PMC ERR2 node.
+ * For which Node_Id = VERSAL_EVENT_ERROR_PMC_ERR2
+ */
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_BOOT_CR: Error event mask for PMC Boot Correctable Error.
+ * Set by ROM code during ROM execution during Boot.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_BOOT_CR		BIT(0)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_BOOT_NCR: Error event mask for PMC Boot Non-Correctable Error.
+ * Set by ROM code during ROM execution during Boot.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_BOOT_NCR		BIT(1)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_FW_CR: Error event mask for PMC Firmware Boot Correctable Error.
+ * Set by PLM during firmware execution during Boot.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_FW_CR		BIT(2)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_FW_NCR: Error event mask for PMC Firmware Boot Non-Correctable Error.
+ * Set by PLM during firmware execution during Boot.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_FW_NCR		BIT(3)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_GSW_CR: Error event mask for General Software Correctable Error.
+ * Set by any processors after Boot.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_GSW_CR		BIT(4)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_GSW_NCR: Error event mask for General Software Non-Correctable Error.
+ * Set by any processors after Boot.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_GSW_NCR		BIT(5)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_CFU: Error event mask for CFU Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_CFU		BIT(6)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_CFRAME: Error event mask for CFRAME Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_CFRAME		BIT(7)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMC_PSM_CR: Error event mask for PSM Correctable Error,
+ * Summary from PSM Error Management.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMC_PSM_CR		BIT(8)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMC_PSM_NCR: Error event mask for PSM Non-Correctable Error,
+ * Summary from PSM Error Management.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMC_PSM_NCR	BIT(9)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_DDRMB_CR: Error event mask for DDRMC MB Correctable ECC Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_DDRMB_CR		BIT(10)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_DDRMB_NCR: Error event mask for DDRMC MB Non-Correctable ECC Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_DDRMB_NCR		BIT(11)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_NOCTYPE1_CR: Error event mask for NoC Type1 Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_NOCTYPE1_CR	BIT(12)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_NOCTYPE1_NCR: Error event mask for NoC Type1 Non-Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_NOCTYPE1_NCR	BIT(13)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_NOCUSER: Error event mask for NoC User Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_NOCUSER		BIT(14)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_MMCM: Error event mask for MMCM Lock Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_MMCM		BIT(15)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_AIE_CR: Error event mask for ME Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_AIE_CR		BIT(16)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_AIE_NCR: Error event mask for ME Non-Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_AIE_NCR		BIT(17)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_DDRMC_CR: Error event mask for DDRMC MC Correctable ECC Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_DDRMC_CR		BIT(18)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_DDRMC_NCR: Error event mask for DDRMC MC Non-Correctable ECC Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_DDRMC_NCR		BIT(19)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_GT_CR: Error event mask for GT Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_GT_CR		BIT(20)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_GT_NCR: Error event mask for GT Non-Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_GT_NCR		BIT(21)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PLSMON_CR: Error event mask for PL Sysmon Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PLSMON_CR		BIT(22)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PLSMON_NCR: Error event mask for PL Sysmon Non-Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PLSMON_NCR		BIT(23)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PL0: Error event mask for User defined PL generic error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PL0		BIT(24)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PL1: Error event mask for User defined PL generic error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PL1		BIT(25)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PL2: Error event mask for User defined PL generic error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PL2		BIT(26)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PL3: Error event mask for User defined PL generic error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PL3		BIT(27)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_NPIROOT: Error event mask for NPI Root Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_NPIROOT		BIT(28)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_SSIT3: Error event mask for SSIT Error from Slave SLR1,
+ * Only used in Master SLR.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_SSIT3		BIT(29)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_SSIT4: Error event mask for SSIT Error from Slave SLR2,
+ * Only used in Master SLR.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_SSIT4		BIT(30)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_SSIT5: Error event mask for SSIT Error from Slave SLR3,
+ * Only used in Master SLR.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_SSIT5		BIT(31)
+
+/*
+ * Error Event Mask belongs to PMC ERR2 node,
+ * For which Node_Id = VERSAL_EVENT_ERROR_PMC_ERR2
+ */
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMCAPB: Error event mask for General purpose PMC error,
+ * can be triggered by any of the following peripherals:,
+ * - PMC Global Regsiters,- PMC Clock & Reset (CRP),- PMC IOU Secure SLCR,
+ * - PMC IOU SLCR,- BBRAM Controller,- PMC Analog Control Registers,
+ * - RTC Control Registers.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMCAPB		BIT(0)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMCROM: Error event mask for PMC ROM Validation Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMCROM		BIT(1)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_MB_FATAL0: Error event mask for PMC PPU0 MB TMR Fatal Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_MB_FATAL0		BIT(2)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_MB_FATAL1: Error event mask for PMC PPU1 MB TMR Fatal Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_MB_FATAL1		BIT(3)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMCPAR: Error event mask for PMC Switch and PMC IOU Parity Errors.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMCPAR		BIT(4)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMC_CR: Error event mask for PMC Correctable Errors,
+ * PPU0 RAM correctable error.,PPU1 instruction RAM correctable error.,
+ * PPU1 data RAM correctable error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMC_CR		BIT(5)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMC_NCR: Error event mask for PMC Non-Correctable Errors,
+ * PPU0 RAM non-correctable error.,PPU1 instruction RAM non-correctable error.,
+ * PPU1 data RAM non-correctable error.,PRAM non-correctable error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMC_NCR		BIT(6)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMCSMON0: Error event mask for PMC Temperature Shutdown Alert
+ * and Power Supply.
+ * Failure Detection Errors from PMC Sysmon alarm[0].
+ * Indicates an alarm condition on any of SUPPLY0 to SUPPLY31.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMCSMON0		BIT(7)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMCSMON1: Error event mask for PMC Temperature Shutdown Alert
+ * and Power Supply.
+ * Failure Detection Errors from PMC Sysmon alarm[1].
+ * Indicates an alarm condition on any of SUPPLY32 to SUPPLY63.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMCSMON1		BIT(8)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMCSMON2: Error event mask for PMC Temperature Shutdown Alert
+ * and Power Supply.
+ * Failure Detection Errors from PMC Sysmon alarm[2].
+ * Indicates an alarm condition on any of SUPPLY64 to SUPPLY95.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMCSMON2		BIT(9)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMCSMON3: Error event mask for PMC Temperature Shutdown Alert
+ * and Power Supply.
+ * Failure Detection Errors from PMC Sysmon alarm[3].
+ * Indicates an alarm condition on any of SUPPLY96 to SUPPLY127.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMCSMON3		BIT(10)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMCSMON4: Error event mask for PMC Temperature Shutdown Alert
+ * and Power Supply.
+ * Failure Detection Errors from PMC Sysmon alarm[4].
+ * Indicates an alarm condition on any of SUPPLY128 to SUPPLY159.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMCSMON4		BIT(11)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMCSMON8: Error event mask for PMC Temperature Shutdown Alert
+ * and Power Supply.
+ * Failure Detection Errors from PMC Sysmon alarm[8].
+ * Indicates an over-temperature alarm.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMCSMON8		BIT(15)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMCSMON9: Error event mask for PMC Temperature Shutdown Alert
+ * and Power Supply.
+ * Failure Detection Errors from PMC Sysmon alarm[9].
+ * Indicates a device temperature alarm.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMCSMON9		BIT(16)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_CFI: Error event mask for CFI Non-Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_CFI		BIT(17)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_SEUCRC: Error event mask for CFRAME SEU CRC Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_SEUCRC		BIT(18)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_SEUECC: Error event mask for CFRAME SEU ECC Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_SEUECC		BIT(19)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_RTCALARM: Error event mask for RTC Alarm Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_RTCALARM		BIT(22)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_NPLL: Error event mask for PMC NPLL Lock Error,
+ * This error can be unmasked after the NPLL is locked to alert when the
+ * NPLL loses lock.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_NPLL		BIT(23)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PPLL: Error event mask for PMC PPLL Lock Error,
+ * This error can be unmasked after the PPLL is locked to alert when the
+ * PPLL loses lock.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PPLL		BIT(24)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_CLKMON: Error event mask for Clock Monitor Errors.,
+ * Collected from CRP's CLKMON_STATUS register.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_CLKMON		BIT(25)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMCTO: Error event mask for PMC Interconnect Timeout Errors.,
+ * Collected from:,Interconnect mission interrupt status register.,
+ * Interconnect latent status register.,Timeout interrupt status register
+ * for SERBs.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMCTO		BIT(26)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMCXMPU: Error event mask for PMC XMPU Errors:,
+ * Register access error on APB., Read permission violation.,
+ * Write permission violation.,Security violation.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMCXMPU		BIT(27)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PMCXPPU: Error event mask for PMC XPPU Errors:,
+ * Register access error on APB., Master ID not found.,Read permission violation.,
+ * Master ID parity error., Master ID access violation.,
+ * TrustZone violation.,Aperture parity error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PMCXPPU		BIT(28)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_SSIT0: Error event mask for Master SLR:
+ * SSIT Error from Slave SLR1.,
+ * For Slave SLRs: SSIT Error0 from Master SLR.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_SSIT0		BIT(29)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_SSIT1: Error event mask for Master SLR:
+ * SSIT Error from Slave SLR2.,
+ * For Slave SLRs: SSIT Error1 from Master SLR.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_SSIT1		BIT(30)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_SSIT2: Error event mask for Master SLR:
+ * SSIT Error from Slave SLR3.,
+ * For Slave SLRs: SSIT Error2 from Master SLR.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_SSIT2		BIT(31)
+
+/*
+ * Error Event Mask belongs to PSM ERR1 node,
+ * For which Node_Id = VERSAL_EVENT_ERROR_PSM_ERR1
+ */
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PS_SW_CR: Error event mask for PS Software can write to
+ * trigger register to generate this Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PS_SW_CR		BIT(0)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PS_SW_NCR: Error event mask for PS Software can write to
+ * trigger register to generate this Non-Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PS_SW_NCR		BIT(1)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PSM_B_CR: Error event mask for PSM Firmware can write to
+ * trigger register to generate this Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PSM_B_CR		BIT(2)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PSM_B_NCR: Error event mask for PSM Firmware can write to
+ * trigger register to generate this Non-Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PSM_B_NCR		BIT(3)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_MB_FATAL: Error event mask for Or of MB Fatal1, Fatal2, Fatal3 Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_MB_FATAL		BIT(4)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PSM_CR: Error event mask for PSM Correctable.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PSM_CR		BIT(5)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PSM_NCR: Error event mask for PSM Non-Correctable.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PSM_NCR		BIT(6)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_OCM_ECC: Error event mask for Non-Correctable ECC Error
+ * during an OCM access.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_OCM_ECC		BIT(7)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_L2_ECC: Error event mask for Non-Correctable ECC Error
+ * during APU L2 Cache access.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_L2_ECC		BIT(8)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_RPU_ECC: Error event mask for ECC Errors during a RPU memory access.
+ * Floating-point operation exceptions. RPU REG APB error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_RPU_ECC		BIT(9)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_RPU_LS: Error event mask for RPU Lockstep Errors from R5_0.
+ * The Lockstep error is not initialized until RPU clock is enabled;
+ * therefore, error outcomes are masked by default and are expected to be
+ * unmasked after processor clock is enabled and before its reset is released.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_RPU_LS		BIT(10)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_RPU_CCF: Error event mask for RPU Common Cause Failures
+ * ORed together. The CCF Error register with the masking capability
+ * has to reside in the RPU.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_RPU_CCF		BIT(11)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_GIC_AXI: Error event mask for APU GIC AXI Error
+ * by the AXI4 master port, such as SLVERR or DECERR.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_GIC_AXI		BIT(12)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_GIC_ECC: Error event mask for APU GIC ECC Error,
+ * a Non-Correctable ECC error occurred in any ECC-protected RAM.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_GIC_ECC		BIT(13)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_APLL_LOCK: Error event mask for APLL Lock Errors.
+ * The error can be unmasked after the PLL is locked to alert when the
+ * PLL loses lock.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_APLL_LOCK		BIT(14)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_RPLL_LOCK: Error event mask for RPLL Lock Errors.
+ * The error can be unmasked after the PLL is locked to alert when the
+ * PLL loses lock.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_RPLL_LOCK		BIT(15)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_CPM_CR: Error event mask for CPM Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_CPM_CR		BIT(16)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_CPM_NCR: Error event mask for CPM Non-Correctable Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_CPM_NCR		BIT(17)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_LPD_APB: Error event mask for LPD APB Errors
+ * from:,IPI REG,USB2 REG,CRL REG,LPD AFIFM4 REG,LPD IOU REG,
+ * LPD IOU SECURE SLCR REG,LPD SLCR REG,LPD SLCR SECURE REG.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_LPD_APB		BIT(18)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_FPD_APB: Error event mask for FPD APB Errors
+ * from:,FPD AFIFM0 REG,FPD AFIFM2 REG,FPD SLCR REG,FPD SLCR SECURE REG,
+ * CRF REG.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_FPD_APB		BIT(19)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_LPD_PAR: Error event mask for Data parity errors
+ * from the interfaces connected
+ * to the LPD interconnect.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_LPD_PAR		BIT(20)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_FPD_PAR: Error event mask for Data parity errors
+ * from the interfaces connected
+ * to the FPD interconnect.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_FPD_PAR		BIT(21)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_IOU_PAR: Error event mask for LPD IO Peripheral Unit Parity Error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_IOU_PAR		BIT(22)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PSM_PAR: Error event mask for Data parity errors
+ * from the interfaces connected to the PSM interconnect.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PSM_PAR		BIT(23)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_LPD_TO: Error event mask for LPD Interconnect Timeout errors.
+ * Collected from:,Timeout errors at the slaves connected to the LPD
+ * interconnect.,Address decode error.,Interconnect mission errors for
+ * the slaves connected to the LPD interconnect.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_LPD_TO		BIT(24)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_FPD_TO: Error event mask for FPD Interconnect Timeout errors.
+ * Collected from:,Coresight debug trace alarms.,Timeout errors at the
+ * slaves connected to the FPD interconnect.,Address decode error.,
+ * Data parity errors on the interfaces connected to the FPD interconnect.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_FPD_TO		BIT(25)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_PSM_TO: Error event mask for PSM Interconnect Timeout Errors.
+ * Collected from:,Interconnect mission errors for PSM_LOCAL slave or
+ * PSM_GLOBAL slave or MDM slave or LPD interconnect or PSM master.,
+ * Interconnect latent errors for PSM_LOCAL slave or PSM_GLOBAL slave or
+ * MDM slave or LPD interconnect or PSM master.,
+ * Timeout errors at the slaves connected to the PSM interconnect.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_PSM_TO		BIT(26)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_XRAM_CR: Error event mask for XRAM Correctable error.
+ * Only applicable in devices that have XRAM.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_XRAM_CR		BIT(27)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_XRAM_NCR: Error event mask for XRAM Non-Correctable error.
+ * Only applicable in devices that have XRAM.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_XRAM_NCR		BIT(28)
+
+/*
+ * Error Event Mask belongs to PSM ERR2 node,
+ * For which Node_Id = VERSAL_EVENT_ERROR_PSM_ERR2
+ */
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_LPD_SWDT: Error event mask for Error from Watchdog Timer
+ * in the LPD Subsystem.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_LPD_SWDT		BIT(0)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_FPD_SWDT: Error event mask for Error from Watchdog Timer
+ * in the FPD Subsystem.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_FPD_SWDT		BIT(1)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_LPD_XMPU: Error event mask for LPD XMPU Errors:,
+ * Register access error on APB., Read permission violation.,
+ * Write permission violation.,Security violation.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_LPD_XMPU		BIT(18)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_LPD_XPPU: Error event mask for LPD XPPU Errors:,
+ * Register access error on APB., Master ID not found.,Read permission violation.,
+ * Master ID parity error., Master ID access violation.,
+ * TrustZone violation.,Aperture parity error.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_LPD_XPPU		BIT(19)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_FPD_XMPU: Error event mask for FPD XMPU Errors:,
+ * Register access error on APB., Read permission violation.,
+ * Write permission violation.,Security violation.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_FPD_XMPU		BIT(20)
+
+/*
+ * Error Event Mask belongs to SW ERR node,
+ * For which Node_Id = VERSAL_EVENT_ERROR_SW_ERR
+ */
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_HB_MON_0: Health Boot Monitoring errors.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_HB_MON_0		BIT(0)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_HB_MON_1: Health Boot Monitoring errors.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_HB_MON_1		BIT(1)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_HB_MON_2: Health Boot Monitoring errors.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_HB_MON_2		BIT(2)
+
+/**
+ * XPM_VERSAL_EVENT_ERROR_MASK_HB_MON_3: Health Boot Monitoring errors.
+ */
+#define XPM_VERSAL_EVENT_ERROR_MASK_HB_MON_3		BIT(3)
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
index 000000000000..039c96bacd54
--- /dev/null
+++ b/include/linux/firmware/xlnx-versal-net-error-events.h
@@ -0,0 +1,1125 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Versal NET Error Event Node IDs and Error Event Mask.
+ * Use with Xilinx Event Management Driver
+ *
+ * Copyright (C) 2023, Advanced Micro Devices, Inc.
+ *
+ * Jay Buddhabhatti <jay.buddhabhatti@amd.com>
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
+ * Error Event Mask belongs to PMC ERR1 node.
+ * For which Node_Id = VERSAL_NET_EVENT_ERROR_PMC_ERR1
+ */
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_BOOT_CR: Error event mask for PMC Boot Correctable Error.
+ * Set by ROM code during ROM execution during Boot.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_BOOT_CR		BIT(0)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_BOOT_NCR: Error event mask for PMC Boot Non-Correctable Error.
+ * Set by ROM code during ROM execution during Boot.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_BOOT_NCR		BIT(1)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FW_CR: Error event mask for PMC Firmware Boot Correctable Error.
+ * Set by PLM during firmware execution during Boot.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FW_CR		BIT(2)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FW_NCR: Error event mask for PMC Firmware Boot
+ * Non-Correctable Error. Set by PLM during firmware execution during Boot.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FW_NCR		BIT(3)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_GSW_CR: Error event mask for General Software Correctable Error.
+ * Set by any processors after Boot.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_GSW_CR		BIT(4)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_GSW_NCR: Error event mask for General Software
+ * Non-Correctable Error. Set by any processors after Boot.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_GSW_NCR		BIT(5)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_CFU: Error event mask for CFU Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_CFU		BIT(6)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_CFRAME: Error event mask for CFRAME Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_CFRAME		BIT(7)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PMC_PSM_CR: Error event mask for PSM Correctable Error,
+ * Summary from PSM Error Management.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PMC_PSM_CR		BIT(8)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PMC_PSM_NCR: Error event mask for PSM Non-Correctable Error,
+ * Summary from PSM Error Management.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PMC_PSM_NCR	BIT(9)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_DDRMB_CR: Error event mask for DDRMC MB Correctable ECC Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_DDRMB_CR		BIT(10)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_DDRMB_NCR: Error event mask for DDRMC MB Non-Correctable
+ * ECC Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_DDRMB_NCR		BIT(11)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_NOCTYPE1_CR: Error event mask for NoC Type1 Correctable Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_NOCTYPE1_CR	BIT(12)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_NOCTYPE1_NCR: Error event mask for NoC Type1
+ * Non-Correctable Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_NOCTYPE1_NCR	BIT(13)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_NOCUSER: Error event mask for NoC User Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_NOCUSER		BIT(14)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_MMCM: Error event mask for MMCM Lock Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_MMCM		BIT(15)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_AIE_CR: Error event mask for ME Correctable Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_AIE_CR		BIT(16)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_AIE_NCR: Error event mask for ME Non-Correctable Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_AIE_NCR		BIT(17)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_DDRMC_CR: Error event mask for DDRMC MC Correctable ECC Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_DDRMC_CR		BIT(18)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_DDRMC_NCR: Error event mask for DDRMC MC
+ * Non-Correctable ECC Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_DDRMC_NCR		BIT(19)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_GT_CR: Error event mask for GT Correctable Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_GT_CR		BIT(20)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_GT_NCR: Error event mask for GT Non-Correctable Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_GT_NCR		BIT(21)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PLSMON_CR: Error event mask for PL Sysmon Correctable Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PLSMON_CR		BIT(22)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PLSMON_NCR: Error event mask for PL Sysmon Non-Correctable Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PLSMON_NCR		BIT(23)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PL0: Error event mask for User defined PL generic error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PL0		BIT(24)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PL1: Error event mask for User defined PL generic error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PL1		BIT(25)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PL2: Error event mask for User defined PL generic error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PL2		BIT(26)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PL3: Error event mask for User defined PL generic error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PL3		BIT(27)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_NPIROOT: Error event mask for NPI Root Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_NPIROOT		BIT(28)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_SSIT3: Error event mask for SSIT Error from Slave SLR1,
+ * Only used in Master SLR.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_SSIT3		BIT(29)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_SSIT4: Error event mask for SSIT Error from Slave SLR2,
+ * Only used in Master SLR.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_SSIT4		BIT(30)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_SSIT5: Error event mask for SSIT Error from Slave SLR3,
+ * Only used in Master SLR.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_SSIT5		BIT(31)
+
+/*
+ * Error Event Mask belongs to PMC ERR2 node,
+ * For which Node_Id = VERSAL_NET_EVENT_ERROR_PMC_ERR2
+ */
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCAPB: Error event mask for General purpose PMC error,
+ * can be triggered by any of the following peripherals:,
+ * - PMC Global Regsiters,- PMC Clock & Reset (CRP),- PMC IOU Secure SLCR,
+ * - PMC IOU SLCR,- BBRAM Controller,- PMC Analog Control Registers,
+ * - RTC Control Registers.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCAPB		BIT(0)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCROM: Error event mask for PMC ROM Validation Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCROM		BIT(1)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_MB_FATAL0: Error event mask for PMC PPU0 MB TMR Fatal Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_MB_FATAL0		BIT(2)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_MB_FATAL1: Error event mask for PMC PPU1 MB TMR Fatal Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_MB_FATAL1		BIT(3)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PMC_CR: Error event mask for PMC Correctable Errors,
+ * PPU0 RAM correctable error.,PPU1 instruction RAM correctable error.,
+ * PPU1 data RAM correctable error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PMC_CR		BIT(5)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PMC_NCR: Error event mask for PMC Non-Correctable Errors,
+ * PPU0 RAM non-correctable error.,PPU1 instruction RAM non-correctable error.,
+ * PPU1 data RAM non-correctable error.,PRAM non-correctable error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PMC_NCR		BIT(6)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCSMON0: Error event mask for PMC Temperature Shutdown Alert
+ * and Power Supply.
+ * Failure Detection Errors from PMC Sysmon alarm[0].
+ * Indicates an alarm condition on any of SUPPLY0 to SUPPLY31.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCSMON0		BIT(7)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCSMON1: Error event mask for PMC Temperature Shutdown Alert
+ * and Power Supply.
+ * Failure Detection Errors from PMC Sysmon alarm[1].
+ * Indicates an alarm condition on any of SUPPLY32 to SUPPLY63.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCSMON1		BIT(8)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCSMON2: Error event mask for PMC Temperature Shutdown Alert
+ * and Power Supply.
+ * Failure Detection Errors from PMC Sysmon alarm[2].
+ * Indicates an alarm condition on any of SUPPLY64 to SUPPLY95.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCSMON2		BIT(9)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCSMON3: Error event mask for PMC Temperature Shutdown Alert
+ * and Power Supply.
+ * Failure Detection Errors from PMC Sysmon alarm[3].
+ * Indicates an alarm condition on any of SUPPLY96 to SUPPLY127.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCSMON3		BIT(10)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCSMON4: Error event mask for PMC Temperature Shutdown Alert
+ * and Power Supply.
+ * Failure Detection Errors from PMC Sysmon alarm[4].
+ * Indicates an alarm condition on any of SUPPLY128 to SUPPLY159.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCSMON4		BIT(11)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCSMON8: Error event mask for PMC Temperature Shutdown Alert
+ * and Power Supply.
+ * Failure Detection Errors from PMC Sysmon alarm[8].
+ * Indicates an over-temperature alarm.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCSMON8		BIT(15)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCSMON9: Error event mask for PMC Temperature Shutdown Alert
+ * and Power Supply.
+ * Failure Detection Errors from PMC Sysmon alarm[9].
+ * Indicates a device temperature alarm.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PMCSMON9		BIT(16)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_CFI: Error event mask for CFI Non-Correctable Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_CFI		BIT(17)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_SEUCRC: Error event mask for CFRAME SEU CRC Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_SEUCRC		BIT(18)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_SEUECC: Error event mask for CFRAME SEU ECC Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_SEUECC		BIT(19)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PMX_WWDT: Error event mask for PMC WWDT Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PMX_WWDT		BIT(20)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_RTCALARM: Error event mask for RTC Alarm Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_RTCALARM		BIT(22)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_NPLL: Error event mask for PMC NPLL Lock Error,
+ * This error can be unmasked after the NPLL is locked to alert when the
+ * NPLL loses lock.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_NPLL		BIT(23)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PPLL: Error event mask for PMC PPLL Lock Error,
+ * This error can be unmasked after the PPLL is locked to alert when the
+ * PPLL loses lock.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PPLL		BIT(24)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_CLKMON: Error event mask for Clock Monitor Errors.,
+ * Collected from CRP's CLKMON_STATUS register.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_CLKMON		BIT(25)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_PMX_CORR_ERR: Error event mask for PMC interconnect
+ * correctable error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_PMX_CORR_ERR	BIT(27)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_PMX_UNCORR_ERR: Error event mask for PMC interconnect
+ * uncorrectable error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_PMX_UNCORR_ERR	BIT(28)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_SSIT0: Error event mask for Master SLR:
+ * SSIT Error from Slave SLR1.,
+ * For Slave SLRs: SSIT Error0 from Master SLR.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_SSIT0		BIT(29)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_SSIT1: Error event mask for Master SLR:
+ * SSIT Error from Slave SLR2.,
+ * For Slave SLRs: SSIT Error1 from Master SLR.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_SSIT1		BIT(30)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_SSIT2: Error event mask for Master SLR:
+ * SSIT Error from Slave SLR3.,
+ * For Slave SLRs: SSIT Error2 from Master SLR.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_SSIT2		BIT(31)
+
+/*
+ * Error Event Mask belongs to PMC ERR3 node,
+ * For which Node_Id = VERSAL_NET_EVENT_ERROR_PMC_ERR3
+ */
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_IOU_CR: Error event mask for PMC IOU correctable error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_IOU_CR		BIT(0)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_IOU_NCR: Error event mask for PMC IOU uncorrectable
+ * error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_IOU_NCR		BIT(1)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_DFX_UXPT_ACT: Error event mask for DFX unexpected
+ * activation
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_DFX_UXPT_ACT	BIT(2)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_DICE_CDI_PAR: Error event mask for DICE CDI SEED parity
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_DICE_CDI_PAR	BIT(3)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_DEVIK_PRIV: Error event mask for Device identity private
+ * key parity
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_DEVIK_PRIV		BIT(4)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_NXTSW_CDI_PAR: Error event mask for Next SW CDI SEED
+ * parity
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_NXTSW_CDI_PAR	BIT(5)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_DEVAK_PRIV: Error event mask for Device attestation
+ * private key parity
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_DEVAK_PRIV		BIT(6)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_DME_PUB_X: Error event mask for DME public key X
+ * component's parity
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_DME_PUB_X		BIT(7)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_DME_PUB_Y: Error event mask for DME public key Y
+ * component's parity
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_DME_PUB_Y		BIT(8)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_DEVAK_PUB_X: Error event mask for DEVAK public key X
+ * component's parity
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_DEVAK_PUB_X	BIT(9)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_DEVAK_PUB_Y: Error event mask for DEVAK public key Y
+ * component's parity
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_DEVAK_PUB_Y	BIT(10)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_DEVIK_PUB_X: Error event mask for DEVIK public key X
+ * component's parity
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_DEVIK_PUB_X	BIT(11)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_DEVIK_PUB_Y: Error event mask for DEVIK public key Y
+ * component's parity
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_DEVIK_PUB_Y	BIT(12)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PCR_PAR: Error event mask for PCR parity
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PCR_PAR		BIT(13)
+
+/*
+ * Error Event Mask belongs to PSM ERR1 node,
+ * For which Node_Id = VERSAL_NET_EVENT_ERROR_PSM_ERR1
+ */
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PS_SW_CR: Error event mask for PS Software can write to
+ * trigger register to generate this Correctable Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PS_SW_CR		BIT(0)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PS_SW_NCR: Error event mask for PS Software can write to
+ * trigger register to generate this Non-Correctable Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PS_SW_NCR		BIT(1)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PSM_B_CR: Error event mask for PSM Firmware can write to
+ * trigger register to generate this Correctable Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PSM_B_CR		BIT(2)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PSM_B_NCR: Error event mask for PSM Firmware can write to
+ * trigger register to generate this Non-Correctable Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PSM_B_NCR		BIT(3)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_MB_FATAL: Error event mask for Or of MB Fatal1,
+ * Fatal2, Fatal3 Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_MB_FATAL		BIT(4)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PSM_CR: Error event mask for PSM Correctable.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PSM_CR		BIT(5)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PSM_NCR: Error event mask for PSM Non-Correctable.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PSM_NCR		BIT(6)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PSMX_CHK: Error event mask for PSMX CHK error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PSMX_CHK		BIT(7)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_APLL1_LOCK: Error event mask for APLL1 lock error. The error
+ * can be unmasked after the PLL is locked to alert when the PLL loses lock.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_APLL1_LOCK		BIT(8)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_APLL2_LOCK: Error event mask for APLL2 lock error. The error
+ * can be unmasked after the PLL is locked to alert when the PLL loses lock.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_APLL2_LOCK		BIT(9)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_RPLL_LOCK: Error event mask for RPLL Lock Errors. The error
+ * can be unmasked after the PLL is locked to alert when the PLL loses lock.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_RPLL_LOCK		BIT(10)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FLXPLL_LOCK: Error event mask for FLXPLL Lock Errors. The
+ * error can be unmasked after the PLL is locked to alert when the PLL loses lock.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FLXPLL_LOCK	BIT(11)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_PSM_CR: Error event mask for INT_PSM correctable error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_PSM_CR		BIT(12)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_PSM_NCR: Error event mask for INT_PSM non-correctable
+ * error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_PSM_NCR	BIT(13)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_USB2: Error event mask for Consolidated Error from the two
+ * USB2 blocks.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_USB2		BIT(14)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_LPX_UXPT_ACT: Error event mask for LPX unexpected dfx
+ * activation error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_LPX_UXPT_ACT	BIT(15)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_LPD_CR: Error event mask for INT_LPD correctable error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_LPD_CR		BIT(17)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_LPD_NCR: Error event mask for INT_LPD non-correctable
+ * error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_LPD_NCR	BIT(18)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_OCM_CR: Error event mask for INT_OCM correctable error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_OCM_CR		BIT(19)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_OCM_NCR: Error event mask for INT_OCM non-correctable
+ * error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_OCM_NCR	BIT(20)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_FPD_CR: Error event mask for INT_FPD correctable error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_FPD_CR		BIT(21)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_FPD_NCR: Error event mask for INT_FPD non-correctable
+ * error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_FPD_NCR	BIT(22)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_IOU_CR: Error event mask for INT_IOU correctable Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_IOU_CR		BIT(23)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_IOU_NCR: Error event mask for INT_IOU non-correctable
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_INT_IOU_NCR	BIT(24)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_RPUA_LOCKSTEP: Error event mask for RPU lockstep error for
+ * ClusterA
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_RPUA_LOCKSTEP	BIT(25)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_RPUB_LOCKSTEP: Error event mask for RPU lockstep error for
+ * ClusterB
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_RPUB_LOCKSTEP	BIT(26)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_APU_GIC_AXI: Error event mask for err_int_irq from APU
+ * GIC Distributer
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_APU_GIC_AXI	BIT(27)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_APU_GIC_ECC: Error event mask for fault_int_irq from APU
+ * GIC Distributer
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_APU_GIC_ECC	BIT(28)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_CPM_CR: Error event mask for CPM correctable error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_CPM_CR		BIT(29)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_CPM_NCR: Error event mask for CPM non-correctable error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_CPM_NCR		BIT(30)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_CPI: Error event mask for CPI error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_CPI		BIT(31)
+
+/*
+ * Error Event Mask belongs to PSM ERR2 node,
+ * For which Node_Id = VERSAL_NET_EVENT_ERROR_PSM_ERR2
+ */
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FPD_WDT0: Error event mask for FPD WDT0 error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FPD_WDT0		BIT(0)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FPD_WDT1: Error event mask for FPD WDT1 error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FPD_WDT1		BIT(1)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FPD_WDT2: Error event mask for FPD WDT2 error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FPD_WDT2		BIT(2)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FPD_WDT3: Error event mask for FPD WDT3 error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FPD_WDT3		BIT(3)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_MEM_SPLITTER0: Error event mask for Memory Errors for
+ * Splitter0
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_MEM_SPLITTER0	BIT(4)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_AXI_PAR_SPLITTER0: Error event mask for Consolidated
+ * Error indicating AXI parity Error for Splitter0
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_AXI_PAR_SPLITTER0	BIT(5)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_MEM_SPLITTER1: Error event mask for Memory Errors for
+ * Splitter1
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_MEM_SPLITTER1	BIT(6)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_AXI_PAR_SPLITTER1: Error event mask for Consolidated
+ * Error indicating AXI parity Error for Splitter1
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_AXI_PAR_SPLITTER1	BIT(7)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_MEM_SPLITTER2: Error event mask for Memory Errors for
+ * Splitter2
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_MEM_SPLITTER2	BIT(8)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_AXI_PAR_SPLITTER2: Error event mask for Consolidated
+ * Error indicating AXI parity Error for Splitter2
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_AXI_PAR_SPLITTER2	BIT(9)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_MEM_SPLITTER3: Error event mask for Memory Errors for
+ * Splitter3
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_MEM_SPLITTER3	BIT(10)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_AXI_PAR_SPLITTER3: Error event mask for Consolidated
+ * Error indicating AXI parity Error for Splitter3
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_AXI_PAR_SPLITTER3	BIT(11)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_APU_CLUSTER0: Error event mask for APU Cluster 0 error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_APU_CLUSTER0	BIT(12)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_APU_CLUSTER1: Error event mask for APU Cluster 1 error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_APU_CLUSTER1	BIT(13)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_APU_CLUSTER2: Error event mask for APU Cluster 2 error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_APU_CLUSTER2	BIT(14)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_APU_CLUSTER3: Error event mask for APU Cluster 3 error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_APU_CLUSTER3	BIT(15)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_LPD_WWDT0: Error event mask for WWDT0 LPX Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_LPD_WWDT0		BIT(16)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_LPD_WWDT1: Error event mask for WWDT0 LPX Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_LPD_WWDT1		BIT(17)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_ADMA_LOCKSTEP: Error event mask for ADMA Lockstep Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_ADMA_LOCKSTEP	BIT(18)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_IPI: Error event mask for IPI Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_IPI		BIT(19)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_OCM_BANK0_CR: Error event mask for OCM Bank0 Corr Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_OCM_BANK0_CR	BIT(20)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_OCM_BANK1_CR: Error event mask for OCM Bank1 Corr Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_OCM_BANK1_CR	BIT(21)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_OCM_BANK0_NCR: Error event mask for OCM Bank0 UnCorr
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_OCM_BANK0_NCR	BIT(22)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_OCM_BANK1_NCR: Error event mask for OCM Bank1 UnCorr
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_OCM_BANK1_NCR	BIT(23)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_LPXAFIFS_CR: Error event mask for LPXAFIFS Corr Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_LPXAFIFS_CR	BIT(24)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_LPXAFIFS_NCR: Error event mask for LPXAFIFS UnCorr
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_LPXAFIFS_NCR	BIT(25)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_LPX_GLITCH_DETECT0: Error event mask for LPX Glitch
+ * Detector0 glitch detected.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_LPX_GLITCH_DETECT0	BIT(26)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_LPX_GLITCH_DETECT1: Error event mask for LPX Glitch
+ * Detector1 glitch detected.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_LPX_GLITCH_DETECT1	BIT(27)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FWALL_WR_NOC_NMU: Error event mask for Firewall write
+ * errors from NOC NMUs
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FWALL_WR_NOC_NMU	BIT(28)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FWALL_RD_NOC_NMU: Error event mask for Firewall read
+ * error from NOC NMU
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FWALL_RD_NOC_NMU	BIT(29)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FWALL_NOC_NSU: Error event mask for Firewall error from
+ * NOC NSU
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FWALL_NOC_NSU	BIT(30)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_B18_R52_A0: Error event mask for Bit[18] from R52 Core
+ * A0, Err event
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_B18_R52_A0		BIT(31)
+
+/*
+ * Error Event Mask belongs to PSM ERR3 node,
+ * For which Node_Id = VERSAL_NET_EVENT_ERROR_PSM_ERR3
+ */
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_B18_R52_A1: Error event mask for Bit[18] from R52 Core
+ * A1, Err event
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_B18_R52_A1		BIT(0)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_B18_R52_B0: Error event mask for Bit[18] from R52 Core
+ * B0, Err event
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_B18_R52_B0		BIT(1)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_B18_R52_B1: Error event mask for Bit[18] from R52 Core
+ * B1, Err event
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_B18_R52_B1		BIT(2)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_A0_CR: Error event mask for R52 A0 Core Correctable
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_A0_CR		BIT(3)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_A0_TFATAL: Error event mask for R52 A0 Core TFatal
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_A0_TFATAL	BIT(4)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_A0_TIMEOUT: Error event mask for R52 A0 Core Timeout
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_A0_TIMEOUT	BIT(5)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_B24_B20_RPUA0: Error event mask for Bit[24:20] pf
+ * ERREVNT for RPUA0
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_B24_B20_RPUA0	BIT(6)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_B25_RPUA0: Error event mask for Bit[25] of ERREVNT for
+ * RPUA0
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_B25_RPUA0		BIT(7)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_A1_CR: Error event mask for R52 A1 Core Correctable
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_A1_CR		BIT(8)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_A1_TFATAL: Error event mask for R52 A1 Core TFatal
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_A1_TFATAL	BIT(9)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_A1_TIMEOUT: Error event mask for R52 A1 Core Timeout
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_A1_TIMEOUT	BIT(10)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_B24_B20_RPUA1: Error event mask for Bit[24:20] pf
+ * ERREVNT for RPUA1
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_B24_B20_RPUA1	BIT(11)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_B25_RPUA1: Error event mask for Bit[25] of ERREVNT for
+ * RPUA1
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_B25_RPUA1		BIT(12)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_B0_CR: Error event mask for R52 A1 Core Correctable
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_B0_CR		BIT(13)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_B0_TFATAL: Error event mask for R52 A1 Core TFatal
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_B0_TFATAL	BIT(14)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_B0_TIMEOUT: Error event mask for R52 A1 Core Timeout
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_B0_TIMEOUT	BIT(15)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_B24_B20_RPUB0: Error event mask for Bit[24:20] pf
+ * ERREVNT for RPUB0
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_B24_B20_RPUB0	BIT(16)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_B25_RPUB0: Error event mask for Bit[25] of ERREVNT for
+ * RPUB0
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_B25_RPUB0		BIT(17)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_B1_CR: Error event mask for R52 A1 Core Correctable
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_B1_CR		BIT(18)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_B1_TFATAL: Error event mask for R52 A1 Core TFatal
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_B1_TFATAL	BIT(19)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_B1_TIMEOUT: Error event mask for R52 A1 Core Timeout
+ * Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_R52_B1_TIMEOUT	BIT(20)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_B24_B20_RPUB1: Error event mask for Bit[24:20] pf
+ * ERREVNT for RPUB1
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_B24_B20_RPUB1	BIT(21)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_B25_RPUB1: Error event mask for Bit[25] of ERREVNT for
+ * RPUB1
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_B25_RPUB1		BIT(22)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PCIL_RPU: Error event mask for PCIL ERR FOR RPU Clusters
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PCIL_RPU		BIT(24)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FPXAFIFS_CR: Error event mask for FPXAFIFS Corr Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FPXAFIFS_CR	BIT(25)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FPXAFIFS_NCR: Error event mask for FPXAFIFS UnCorr Error
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FPXAFIFS_NCR	BIT(26)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PSX_CMN_1: Reserved
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PSX_CMN_1		BIT(27)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PSX_CMN_2: Reserved
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PSX_CMN_2		BIT(28)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PSX_CMN_3: Error event mask for PSX_CMN_3 PD block
+ * consolidated ERROR
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PSX_CMN_3		BIT(29)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_PSX_CML: Reserved
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_PSX_CML		BIT(30)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FPD_INT_WRAP: Error event mask FPD_INT_WRAP PD block
+ * consolidated ERROR
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FPD_INT_WRAP	BIT(31)
+
+/*
+ * Error Event Mask belongs to PSM ERR4 node,
+ * For which Node_Id = VERSAL_NET_EVENT_ERROR_PSM_ERR4
+ */
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FPD_RST_MON: Error event mask for FPD Reset Monitor ERROR
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FPD_RST_MON	BIT(0)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_LPD_RST_CLK_MON: Error event mask for LPD reset and Clock
+ * Monitor Error.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_LPD_RST_CLK_MON	BIT(1)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_FATAL_AFI_FM: Error event mask for Fatal Error from all
+ * AFI FM
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_FATAL_AFI_FM	BIT(2)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_NFATAL_AFI_FM_LPX: Error event mask for Non Fatal Error
+ * from AFI FM in LPX
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_NFATAL_AFI_FM_LPX	BIT(3)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_NFATAL_AFI_FM0_FPX: Error event mask for Non Fatal Error
+ * from AFI FM0 in FPX
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_NFATAL_AFI_FM0_FPX	BIT(4)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_NFATAL_AFI_FM1_FPX: Error event mask for Non Fatal Error
+ * from AFI FM1 in FPX
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_NFATAL_AFI_FM1_FPX	BIT(5)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_NFATAL_AFI_FM2_FPX: Error event mask for Non Fatal Error
+ * from AFI FM2 in FPX
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_NFATAL_AFI_FM2_FPX	BIT(6)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_NFATAL_AFI_FM3_FPX: Error event mask for Non Fatal Error
+ * from AFI FM3 in FPX
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_NFATAL_AFI_FM3_FPX	BIT(7)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_RPU_CLUSTERA: Error event mask for Errors from RPU
+ * cluster A
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_RPU_CLUSTERA	BIT(8)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_RPU_CLUSTERB: Error event mask for Errors from RPU
+ * cluster B
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_RPU_CLUSTERB	BIT(9)
+
+/*
+ * Error Event Mask belongs to SW ERR node,
+ * For which Node_Id = VERSAL_NET_EVENT_ERROR_SW_ERR
+ */
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_HB_MON_0: Health Boot Monitoring errors.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_HB_MON_0		BIT(0)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_HB_MON_1: Health Boot Monitoring errors.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_HB_MON_1		BIT(1)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_HB_MON_2: Health Boot Monitoring errors.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_HB_MON_2		BIT(2)
+
+/**
+ * XPM_VERSAL_NET_EVENT_ERROR_MASK_HB_MON_3: Health Boot Monitoring errors.
+ */
+#define XPM_VERSAL_NET_EVENT_ERROR_MASK_HB_MON_3		BIT(3)
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
-- 
2.23.0


