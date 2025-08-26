Return-Path: <linux-edac+bounces-4683-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BB5B35355
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 07:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B805418848DD
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 05:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B972EE617;
	Tue, 26 Aug 2025 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lib5ty22"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71E82EDD41;
	Tue, 26 Aug 2025 05:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186174; cv=fail; b=W7YjqBgErY0eNPGH+depu3AFZ9geVqwx67Eejo3BKzYXI8BL2HiM4Qi7N9RQLiNVrEQeISMkLD75OvslPHK84N1ndrZzMJbx9tNtzD6sacZt6p5geUENyTvbxvIP4+ImARPKEOGhWqV+J2jU2VulIcMkpE/rsJoVWRHt6y6mTSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186174; c=relaxed/simple;
	bh=vgtoPmVrZEI+pgB+/CXDBNmSS+aiW0KMxgFvYvyoEqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mb1UMEAIA/Yv9Ct/Qv5pAlL8r0QqkV0+LIGA9CLzkH+fgitJUmfv5UtS0TqR1z4pb++YTi8q1NKmvPWxM6kpsZB9ygsX22cx2Qe44wmZ2/l9UZ5DxvN3yaZ4i2qOKh3ih3J2n51eA6XE3GWTy2AfF7D0Dxs5yrt6I/1mnSxdcKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lib5ty22; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtQ7HxXPhXllJYSuhQY5QCosXTmi7BGlWiiBYmIV1sKf4aDFy68CqlllKmqNJ0g726IdlgH/DWus4oYQZGIpU2utFsipmtzUteNhIfvC4dwh6B7NxNtMQ8TQhKo6A/iepjb50EY9gFDrOLsFYzuOjyhgQHok117O+K55i+qiRrS80Shd6gv4mBepYyRboeONwo16W7lnShKeeJvPCuM4vhBvWOWfdO6Z5v4U35AUMWemmAOE4PFeFuXF9SXyz09B4kxhFFAfmImp9S9jcuFq9vQ60elKwXirchulwlqd4QwKLIYy1JozB0FJABCDjQ+LENsNmkri6l1B3VNoo7f8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TseDBIMvYxHmGVLVQZnL2dYNeyEHNNzCPU2zzTRJyhM=;
 b=Now5Lgxv1xy6Cy6ZEbSRLWea8f8ZZU4NnQd/tkyIWzm4giAOoY8QVYO8J7plnNmZr3kh/kgU5OGyUcVkoVtMfRvkZaEwFVTpH3RtaWLV537mlodm2r4WOsehdT/ano0je/dR0teJjGJijRz17DzdCy+na8q/yUxtZEOFWo38oPBVqlvwOq/Bvjk5qbvth3wDdJ4qjbSCehNIxTQlaETA2YKGmLqfuciYHVQmiAxZ8LZIKvRMQGbPVFCau1p2JKjOjYaEVDNOIsZlUvrKDIy2xme1POHa3I9v1NevhXXiEP0eVqAo6ijuHZuGN5eEayNu0QYrUZSVhefU7OGbzwgHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TseDBIMvYxHmGVLVQZnL2dYNeyEHNNzCPU2zzTRJyhM=;
 b=lib5ty22ViF/m8FBwlLVUizjSvKxnDJXZM0jM0LxuY7hDoHYZOtM05byfXW5Xk5kQhqCxAbVuhUsqlkFaCjeJwqVW/gfUBIpBKi+nsJ4h/w699+eJJJg8dPkkb1m+s/VIbQKWyRqdM+DZqApXFGrbg49tgJ/s9DvYSlrSe3Qh14=
Received: from BN9PR03CA0955.namprd03.prod.outlook.com (2603:10b6:408:108::30)
 by SA5PPFAB8DFE4E8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 05:29:25 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::57) by BN9PR03CA0955.outlook.office365.com
 (2603:10b6:408:108::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Tue,
 26 Aug 2025 05:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:29:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:29:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 25 Aug
 2025 22:29:24 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 26 Aug 2025 00:29:19 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <ptsm@linux.microsoft.com>, <srivatsa@csail.mit.edu>,
	<shubhrajyoti.datta@gmail.com>, Shubhrajyoti Datta
	<shubhrajyoti.datta@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
	<nikhil.agarwal@amd.com>
Subject: [PATCH v8 1/5] cdx: add the headers to include/linux
Date: Tue, 26 Aug 2025 10:59:10 +0530
Message-ID: <20250826052914.2066884-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826052914.2066884-1-shubhrajyoti.datta@amd.com>
References: <20250826052914.2066884-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SA5PPFAB8DFE4E8:EE_
X-MS-Office365-Filtering-Correlation-Id: 69daa101-afe9-4cbf-9b7c-08dde4618522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z+GxJG+Qj75t8y+riTE6inaK0SdxApsmrf6/hNYNAqln6Shznxs+YuspByD9?=
 =?us-ascii?Q?AyU+kecdiK59OdljF15Bg4pq960mmhMOnRUuTqWeyAAsPmP70mRvyqbxmoE4?=
 =?us-ascii?Q?bqJ6GMRAF+VEPoGACe/SFoTDBqDHCadaRPsd9g5fwS21w/cXddqsdErUedV4?=
 =?us-ascii?Q?dazpoWXUxMwg0heZeICb4f0900+oiasVJZ312Avtl7le/t/cbSzORV3xwpgw?=
 =?us-ascii?Q?n4AdgF7ysdqJNo0VpjT+a8ra8XlWDhOWMAVfcykUGrrZo6vowLII94zgvvs5?=
 =?us-ascii?Q?34+ZVniWrFMfEu17wsND8QHiRt7kfiN7mZFlOIik7+HwgSXVjGDXXZJwva6+?=
 =?us-ascii?Q?oJVk4Dn2ypfRXp2lpbdpGRQhxhgeOwmMOF7McSSn+9LvGLUgDQQpHXsrOPX7?=
 =?us-ascii?Q?20QRpEPSTLJBPdWb+cf7cOLGQIJZtZQeNQf1iDXLgHOY7iD426+inYtTD0vQ?=
 =?us-ascii?Q?ijLDBT3g3ZQCPN+aEB6Sky5fYoT5c8XK8+qiL7MuHpNH0NVeLC91N8NRMs7z?=
 =?us-ascii?Q?7ooGJSMNHzlqEGvI+4/L2m/3uhaMmS3L1/3fOZH2xRyOqo4c0uvaul5z/Xnb?=
 =?us-ascii?Q?DigM7wjt1Z4IJ4uFCKenOD8E519Acij6FUs4zT2TQNQSwT196bXkUj1cwbtY?=
 =?us-ascii?Q?0h/lQGllibplgaQPNHAP0dKaIFNF1yPu7d2kGjnQSlSBgi25OG1WYaFPgVmC?=
 =?us-ascii?Q?GeBxvQWlv9PjHfPZZQQEs86a4Mfp0upVAHsuLUgYqnHoP3YWfiGyO8k1qc2W?=
 =?us-ascii?Q?7gjXWJrKnpLlu9aGv4qMQIHIDTD6eOiaEVJKTJDVwqfH8vyagWT1ynflzRRI?=
 =?us-ascii?Q?s+yQE2Ybcy8Si3SmuWy9PSoGOLy+Jc8eHm4OHBsAd8kx1S7jkWU+YwEKIxrI?=
 =?us-ascii?Q?APUEoZsMiCoVqnMqkBeZJLPXEd8bYw5MtS9/l/q+ACbAgY3jjU9KIdZAIi5c?=
 =?us-ascii?Q?f2uJNOuJyAaVPpulb51G3WyCx3aXlmpE0fws96uqGSu+LCEGRaHDZ//oI+fJ?=
 =?us-ascii?Q?84blHksoPho76ErzY06osy7bxrk4M9k0zhH14werBGGMfPANNsDGgwNmWbgf?=
 =?us-ascii?Q?mUci9/b52lVwB++bZ+dNimciAlckse0gHN6apYT18ehvaajYuClKheiQ7uta?=
 =?us-ascii?Q?BGxtzq4YxN3KmJrZGu7C//zXRZzWI1Dd+18Y9nbnGXC46cRYB63JArn9M8Yq?=
 =?us-ascii?Q?y1t0+Lma2Ai8xQu1FJnDh2zJTOP7y+yPdVdySfcBCuxZuiuoEWPGWfh1+YV7?=
 =?us-ascii?Q?13BqlLlTXShrTOHjkovsxFFUW7w5BsMHPYbPOF4kdtYbZwl0b/J9oiMaltbu?=
 =?us-ascii?Q?HaNv2ay4K6m7tea4v9fZe8SIHhtd1wZed54qZ5EUE1ZgX+0mV7wvXQDueVTh?=
 =?us-ascii?Q?VOAaE7MSp7eHGm8/Xv/SMjogquiU7CMYu0nJB+TWOtWL4+JBoxZ8swIrcqRQ?=
 =?us-ascii?Q?73d2qcn07OUffdf8bFJYLuNJrihNo21nD5VsXsvYdlEyJ2RHjS8xF+d2kxMl?=
 =?us-ascii?Q?rKA00fqeNJty2a7BZpXAWSjzdPXcTa/KzlSQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:29:25.2639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69daa101-afe9-4cbf-9b7c-08dde4618522
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFAB8DFE4E8

Move `bitfield.h` from the CDX controller directory to
`include/linux/cdx` to make them accessible to other drivers.

As part of this refactoring, `mcdi.h` has been split into two headers:
- `mcdi.h`: retains interface-level declarations
- `mcdid.h`: contains internal definitions and macros

This is in preparation for VersalNET EDAC
driver that relies on it.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v8:
- Split `mcdi.h` into `mcdi.h` and `mcdid.h`
- Removed common code from CDX headers
- Used refactored versions from shared location

Changes in v7:
- add a minimal header instead moving them

Changes in v6:
 - Patch added

 drivers/cdx/controller/cdx_controller.c       |  2 +-
 drivers/cdx/controller/cdx_rpmsg.c            |  2 +-
 drivers/cdx/controller/mcdi.c                 |  5 +-
 drivers/cdx/controller/mcdi_functions.c       |  1 -
 drivers/cdx/controller/mcdi_functions.h       |  3 +-
 drivers/cdx/controller/mcdid.h                | 65 +++++++++++++++++++
 .../linux/cdx}/bitfield.h                     |  0
 .../controller => include/linux/cdx}/mcdi.h   | 52 +--------------
 8 files changed, 73 insertions(+), 57 deletions(-)
 create mode 100644 drivers/cdx/controller/mcdid.h
 rename {drivers/cdx/controller => include/linux/cdx}/bitfield.h (100%)
 rename {drivers/cdx/controller => include/linux/cdx}/mcdi.h (74%)

diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index d623f9c7517a..e943cec09fab 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -14,7 +14,7 @@
 #include "cdx_controller.h"
 #include "../cdx.h"
 #include "mcdi_functions.h"
-#include "mcdi.h"
+#include "mcdid.h"
 
 static unsigned int cdx_mcdi_rpc_timeout(struct cdx_mcdi *cdx, unsigned int cmd)
 {
diff --git a/drivers/cdx/controller/cdx_rpmsg.c b/drivers/cdx/controller/cdx_rpmsg.c
index 04b578a0be17..d4f763323aac 100644
--- a/drivers/cdx/controller/cdx_rpmsg.c
+++ b/drivers/cdx/controller/cdx_rpmsg.c
@@ -15,7 +15,7 @@
 #include "../cdx.h"
 #include "cdx_controller.h"
 #include "mcdi_functions.h"
-#include "mcdi.h"
+#include "mcdid.h"
 
 static struct rpmsg_device_id cdx_rpmsg_id_table[] = {
 	{ .name = "mcdi_ipc" },
diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index e760f8d347cc..90bf9f7c257b 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -23,9 +23,10 @@
 #include <linux/log2.h>
 #include <linux/net_tstamp.h>
 #include <linux/wait.h>
+#include <linux/cdx/bitfield.h>
 
-#include "bitfield.h"
-#include "mcdi.h"
+#include <linux/cdx/mcdi.h>
+#include "mcdid.h"
 
 static void cdx_mcdi_cancel_cmd(struct cdx_mcdi *cdx, struct cdx_mcdi_cmd *cmd);
 static void cdx_mcdi_wait_for_cleanup(struct cdx_mcdi *cdx);
diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
index 885c69e6ebe5..8ae2d99be81e 100644
--- a/drivers/cdx/controller/mcdi_functions.c
+++ b/drivers/cdx/controller/mcdi_functions.c
@@ -5,7 +5,6 @@
 
 #include <linux/module.h>
 
-#include "mcdi.h"
 #include "mcdi_functions.h"
 
 int cdx_mcdi_get_num_buses(struct cdx_mcdi *cdx)
diff --git a/drivers/cdx/controller/mcdi_functions.h b/drivers/cdx/controller/mcdi_functions.h
index b9942affdc6b..57fd1bae706b 100644
--- a/drivers/cdx/controller/mcdi_functions.h
+++ b/drivers/cdx/controller/mcdi_functions.h
@@ -8,7 +8,8 @@
 #ifndef CDX_MCDI_FUNCTIONS_H
 #define CDX_MCDI_FUNCTIONS_H
 
-#include "mcdi.h"
+#include <linux/cdx/mcdi.h>
+#include "mcdid.h"
 #include "../cdx.h"
 
 /**
diff --git a/drivers/cdx/controller/mcdid.h b/drivers/cdx/controller/mcdid.h
new file mode 100644
index 000000000000..5014b04ed710
--- /dev/null
+++ b/drivers/cdx/controller/mcdid.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2008-2013 Solarflare Communications Inc.
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#ifndef CDX_MCDID_H
+#define CDX_MCDID_H
+
+#include <linux/mutex.h>
+#include <linux/kref.h>
+#include <linux/rpmsg.h>
+
+#include "mc_cdx_pcol.h"
+
+#ifdef DEBUG
+#define CDX_WARN_ON_ONCE_PARANOID(x) WARN_ON_ONCE(x)
+#define CDX_WARN_ON_PARANOID(x) WARN_ON(x)
+#else
+#define CDX_WARN_ON_ONCE_PARANOID(x) do {} while (0)
+#define CDX_WARN_ON_PARANOID(x) do {} while (0)
+#endif
+
+#define MCDI_BUF_LEN (8 + MCDI_CTL_SDU_LEN_MAX)
+
+static inline struct cdx_mcdi_iface *cdx_mcdi_if(struct cdx_mcdi *cdx)
+{
+	return cdx->mcdi ? &cdx->mcdi->iface : NULL;
+}
+
+void cdx_mcdi_finish(struct cdx_mcdi *cdx);
+
+int cdx_mcdi_rpc_async(struct cdx_mcdi *cdx, unsigned int cmd,
+		       const struct cdx_dword *inbuf, size_t inlen,
+		       cdx_mcdi_async_completer *complete,
+		       unsigned long cookie);
+int cdx_mcdi_wait_for_quiescence(struct cdx_mcdi *cdx,
+				 unsigned int timeout_jiffies);
+
+/*
+ * We expect that 16- and 32-bit fields in MCDI requests and responses
+ * are appropriately aligned, but 64-bit fields are only
+ * 32-bit-aligned.
+ */
+#define MCDI_BYTE(_buf, _field)						\
+	((void)BUILD_BUG_ON_ZERO(MC_CMD_ ## _field ## _LEN != 1),	\
+	 *MCDI_PTR(_buf, _field))
+#define MCDI_WORD(_buf, _field)						\
+	((void)BUILD_BUG_ON_ZERO(MC_CMD_ ## _field ## _LEN != 2),	\
+	 le16_to_cpu(*(__force const __le16 *)MCDI_PTR(_buf, _field)))
+#define MCDI_POPULATE_DWORD_1(_buf, _field, _name1, _value1)		\
+	CDX_POPULATE_DWORD_1(*_MCDI_DWORD(_buf, _field),		\
+			     MC_CMD_ ## _name1, _value1)
+#define MCDI_SET_QWORD(_buf, _field, _value)				\
+	do {								\
+		CDX_POPULATE_DWORD_1(_MCDI_DWORD(_buf, _field)[0],	\
+				     CDX_DWORD, (u32)(_value));	\
+		CDX_POPULATE_DWORD_1(_MCDI_DWORD(_buf, _field)[1],	\
+				     CDX_DWORD, (u64)(_value) >> 32);	\
+	} while (0)
+#define MCDI_QWORD(_buf, _field)					\
+	(CDX_DWORD_FIELD(_MCDI_DWORD(_buf, _field)[0], CDX_DWORD) |	\
+	(u64)CDX_DWORD_FIELD(_MCDI_DWORD(_buf, _field)[1], CDX_DWORD) << 32)
+
+#endif /* CDX_MCDID_H */
diff --git a/drivers/cdx/controller/bitfield.h b/include/linux/cdx/bitfield.h
similarity index 100%
rename from drivers/cdx/controller/bitfield.h
rename to include/linux/cdx/bitfield.h
diff --git a/drivers/cdx/controller/mcdi.h b/include/linux/cdx/mcdi.h
similarity index 74%
rename from drivers/cdx/controller/mcdi.h
rename to include/linux/cdx/mcdi.h
index 54a65e9760ae..46e3f63b062a 100644
--- a/drivers/cdx/controller/mcdi.h
+++ b/include/linux/cdx/mcdi.h
@@ -11,16 +11,7 @@
 #include <linux/kref.h>
 #include <linux/rpmsg.h>
 
-#include "bitfield.h"
-#include "mc_cdx_pcol.h"
-
-#ifdef DEBUG
-#define CDX_WARN_ON_ONCE_PARANOID(x) WARN_ON_ONCE(x)
-#define CDX_WARN_ON_PARANOID(x) WARN_ON(x)
-#else
-#define CDX_WARN_ON_ONCE_PARANOID(x) do {} while (0)
-#define CDX_WARN_ON_PARANOID(x) do {} while (0)
-#endif
+#include "linux/cdx/bitfield.h"
 
 /**
  * enum cdx_mcdi_mode - MCDI transaction mode
@@ -36,8 +27,6 @@ enum cdx_mcdi_mode {
 #define MCDI_RPC_LONG_TIMEOU	(60 * HZ)
 #define MCDI_RPC_POST_RST_TIME	(10 * HZ)
 
-#define MCDI_BUF_LEN (8 + MCDI_CTL_SDU_LEN_MAX)
-
 /**
  * enum cdx_mcdi_cmd_state - State for an individual MCDI command
  * @MCDI_STATE_QUEUED: Command not started and is waiting to run.
@@ -180,25 +169,6 @@ struct cdx_mcdi_data {
 	u32 fn_flags;
 };
 
-static inline struct cdx_mcdi_iface *cdx_mcdi_if(struct cdx_mcdi *cdx)
-{
-	return cdx->mcdi ? &cdx->mcdi->iface : NULL;
-}
-
-int cdx_mcdi_init(struct cdx_mcdi *cdx);
-void cdx_mcdi_finish(struct cdx_mcdi *cdx);
-
-void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int len);
-int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
-		 const struct cdx_dword *inbuf, size_t inlen,
-		 struct cdx_dword *outbuf, size_t outlen, size_t *outlen_actual);
-int cdx_mcdi_rpc_async(struct cdx_mcdi *cdx, unsigned int cmd,
-		       const struct cdx_dword *inbuf, size_t inlen,
-		       cdx_mcdi_async_completer *complete,
-		       unsigned long cookie);
-int cdx_mcdi_wait_for_quiescence(struct cdx_mcdi *cdx,
-				 unsigned int timeout_jiffies);
-
 /*
  * We expect that 16- and 32-bit fields in MCDI requests and responses
  * are appropriately aligned, but 64-bit fields are only
@@ -215,28 +185,8 @@ int cdx_mcdi_wait_for_quiescence(struct cdx_mcdi *cdx,
 #define _MCDI_DWORD(_buf, _field)					\
 	((_buf) + (_MCDI_CHECK_ALIGN(MC_CMD_ ## _field ## _OFST, 4) >> 2))
 
-#define MCDI_BYTE(_buf, _field)						\
-	((void)BUILD_BUG_ON_ZERO(MC_CMD_ ## _field ## _LEN != 1),	\
-	 *MCDI_PTR(_buf, _field))
-#define MCDI_WORD(_buf, _field)						\
-	((void)BUILD_BUG_ON_ZERO(MC_CMD_ ## _field ## _LEN != 2),	\
-	 le16_to_cpu(*(__force const __le16 *)MCDI_PTR(_buf, _field)))
 #define MCDI_SET_DWORD(_buf, _field, _value)				\
 	CDX_POPULATE_DWORD_1(*_MCDI_DWORD(_buf, _field), CDX_DWORD, _value)
 #define MCDI_DWORD(_buf, _field)					\
 	CDX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), CDX_DWORD)
-#define MCDI_POPULATE_DWORD_1(_buf, _field, _name1, _value1)		\
-	CDX_POPULATE_DWORD_1(*_MCDI_DWORD(_buf, _field),		\
-			     MC_CMD_ ## _name1, _value1)
-#define MCDI_SET_QWORD(_buf, _field, _value)				\
-	do {								\
-		CDX_POPULATE_DWORD_1(_MCDI_DWORD(_buf, _field)[0],	\
-				     CDX_DWORD, (u32)(_value));	\
-		CDX_POPULATE_DWORD_1(_MCDI_DWORD(_buf, _field)[1],	\
-				     CDX_DWORD, (u64)(_value) >> 32);	\
-	} while (0)
-#define MCDI_QWORD(_buf, _field)					\
-	(CDX_DWORD_FIELD(_MCDI_DWORD(_buf, _field)[0], CDX_DWORD) |	\
-	(u64)CDX_DWORD_FIELD(_MCDI_DWORD(_buf, _field)[1], CDX_DWORD) << 32)
-
 #endif /* CDX_MCDI_H */
-- 
2.34.1


