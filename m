Return-Path: <linux-edac+bounces-3706-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C3AA9AEDF
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 15:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089D69A14BB
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 13:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10DA280CF0;
	Thu, 24 Apr 2025 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hfzKexEH"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA227FD6A;
	Thu, 24 Apr 2025 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500915; cv=fail; b=hqrKj+LsrKRcYYpjObjtSxLbX6yfgvlycUJnL48WROfYw2fYafkmLVF8KposssihEuzprQ2Mn1LIVFszTEvkkBMaByQB9QMN0hCwrgk/jR2PMGPrc+OhuplETJgsYiBv06TtpPU2TsFH2/8INONtF1267Z8W8ZKlBzTXFN/Ogd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500915; c=relaxed/simple;
	bh=hMNO8LJDhUvS1Z8AN5ZQAuUGXESAc1GA6fg908iuajw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vC5NWnzMC8DSJC+IhM+Y268XiYXqiQcbjQYn9ECK8DqqqnfCTbE+65PqE0GLa0UcVPuxZ8qvXoAXnciTl7g+E5pJvP+b4iYotJ4kHObOSy822HbdvNkiuZqzWLhUtMy4G56tKyjG7qlgCtoYmWnLfDgdXiaWx6nFUSLSLTs6llQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hfzKexEH; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9iiCZ7sCAMbLZXP9854uRtpYlRFDy/7enRqjHmyZtzVBcu66PNrfTb36rTX4gQPguANzz2o6hqpPcNAeFAZDTQ0/8r+Nmn2b8vuSQmTATT2x6g43nIOlQtN3KnlbnyLlKZTxkf4C+PZTWLCz+rI/iMI39wXwYnLTrXNhlM1wn4/TF8TjjEa0gv/65C5+PiFTM+9W+HEo1k52Due7A8gyfYjjce818fiYsOw8RSJ/XyicGUnIR1SA9HgBOhY+jYbI6OdnPLikWuVxRnQAm4y8fYI0oU1tnq6x4qkOBjTdXOSQmuXCYMLmfZtSm35QhewEhXerVe7YKp1s0n/X9uixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdSQ2MVv+pkHJbnEpQ9XFpAgU5jHA7YJPtg/vqIUlLA=;
 b=y/QcZWOrJkToI81Q5M11SXR3wAXuQEBNX+onhOr6woHUqd4g+csrQ3by2a3PTjwm75jCujwqTp+yMu5dcWGkD8nKBRMEwkZy/bqSnowwfw+Mi2QOxMjpQ+mTxNBlPHXlr+5O3maFQxjFS8fyUWOH+Dmpppvs1mpPs50KNp3rdandOECb8dO9w5t7SVPGLrBDiHw0rdiyzHmmhd/FwA2X0gLM8eQGQ61H4qznRveaJSK/vPMAouharkJhPtBvrHk0bN2PkuFYsVlBwGx2FPU5rGsuHj8P8+No4Oku6NWfb8HT1GaKSNbvaw3b5n9ZPcTToyxv+TwEhrNSKvMA33tLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdSQ2MVv+pkHJbnEpQ9XFpAgU5jHA7YJPtg/vqIUlLA=;
 b=hfzKexEHqgT2UWCxOzB6h8CO8brtH+n1dL5MaAxo9+auqtgi7leJKI1X2SKCC8Q0WPMLbyNkqe1heQaVfECaDBqk9eXq4BIngHRzZswuR33oH7J03CqIwAEIHbyGgUlAa/LM8bPwNXjDURUzgbyun+Qxj3knEJcgFWsR8lRyZbU=
Received: from BN0PR04CA0188.namprd04.prod.outlook.com (2603:10b6:408:e9::13)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 13:21:50 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::1b) by BN0PR04CA0188.outlook.office365.com
 (2603:10b6:408:e9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Thu,
 24 Apr 2025 13:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.1 via Frontend Transport; Thu, 24 Apr 2025 13:21:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:21:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:21:48 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 24 Apr 2025 08:21:44 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <ptsm@linux.microsoft.com>, <srivatsa@csail.mit.edu>,
	<shubhrajyoti.datta@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH v6 6/6] EDAC/VersalNET: Add support for error notification
Date: Thu, 24 Apr 2025 18:51:18 +0530
Message-ID: <20250424132118.17074-7-shubhrajyoti.datta@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e8ba1e-0828-49eb-5fd0-08dd8332f907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7tOho5ijyVpkBP+MlK9jLXaHzFj7CEn9tdlLK6XQjgN/xAfqq6s2G8h6mBnF?=
 =?us-ascii?Q?tk9cvcG4Wj7ffOAYJPQVTVuaDluTdSsxktgaQCP9mqcWd9YOwTw5bqv8kp7Y?=
 =?us-ascii?Q?Y5fR/n67tnCLwxML7Q8Y3ErEWRYZAcBqpV0S61Rg29Tu92G2odIM0vdxxCJJ?=
 =?us-ascii?Q?Bqo4GV+V8KQCJ85o00ge5wfO5i9Z7ONfIKDqaExanW/raPiVJpkTqCx/kmhX?=
 =?us-ascii?Q?iP5rl4RzD7UlldaVhjBoIy8H2UKxX+q99VW8Ns4pv9OpTClGWo+Q/lFqihgR?=
 =?us-ascii?Q?UMaHwm2KAKB+HnjvCrYRaA5yScqjzAv8wQ/SrdRptY7laNSV1xfvlUD0Vi7y?=
 =?us-ascii?Q?Wp5hdnc7Px9ZVM7ZrL/UuIvrNGWIun4b0gMs1TI9524FGqWUxAo9q/E402XR?=
 =?us-ascii?Q?LTbGFNfBTqCdBver7v0Sp09KGvO2ZQG60mUxk9tD5nm9mdg5GFiXRUFv7KPr?=
 =?us-ascii?Q?7P4Ug7+qZSe2WZWOcvd842FEsMRJC0D+zRXBWsZJ9mBR90vXGGG6pgAHB1Zm?=
 =?us-ascii?Q?cml/HAGuPB1VsAU+Biw3ohI3n2hoUNOM+SP745Hzi8Qvx/p+k/xNvuo6fRIu?=
 =?us-ascii?Q?937snHg5B18OWtClzSD3TwYnN2ATJG2/2I8j4iuJb2cLVYAThox30YjDhnmD?=
 =?us-ascii?Q?daRhiDwWBTiRN6QkpRyS5IY1hbyTCIOCwLKU3bcluoQ+s2TUEI1szZWYTL9P?=
 =?us-ascii?Q?+m4S9gfP1R7R/VW86ovjBd6ouY+L0cKqRJbpibjsBsxDsnaj33WUqUwYC+VZ?=
 =?us-ascii?Q?F07Cl5BP1hLBjjj2FLBZj+W/zFN9rN1wcfI+dfqhZifCyNX/jKf2QplM8yYr?=
 =?us-ascii?Q?isEo4XSsN/cTLGyhGA0A7sHZ0WXNE7IGOFc9WbzScHR31Reme02FXq009vcC?=
 =?us-ascii?Q?/Vx6OvxmjKjfAZVrGrtJFN7BGTu4aLZPbrhm+fR4F/SKkL86TNoxJiAiyCdQ?=
 =?us-ascii?Q?uNwmKanaNSUE7RpJJeF3k6QwMs8Nk/I7DyXy47ekFJfMANfiscNs2IqMzniK?=
 =?us-ascii?Q?4eYW0q1vUIYSTFmgT188dVcpuoEdjeAMSwu1tAIjVrjjgoWIeFJf0UikeUXt?=
 =?us-ascii?Q?lnhJVZnc12Y3Tj1PvUdPldSPpyI8QXfyZ3VnWwdFtnvB6Dlr6gKcgl/BYJHf?=
 =?us-ascii?Q?06QGgELQHh71mSt1pteqWqk9fIFWDkuBtL/uZzDmX48gjfA+dGAYTQdZb/s1?=
 =?us-ascii?Q?EG+w/GY+WFgDxiljGBbbzave8TI8d4Lj/QxRnClte/MdKckls9ooGWUkgmQg?=
 =?us-ascii?Q?FTiHiMHRmY21med6A024I7yhIDdHR+O6FyAfXf/6uzzCln4qJGh37wRfa1dc?=
 =?us-ascii?Q?B2IztTqOF7JrXopHtherACFADxeUxI6rupczx9EdW9aJpsPuLV6wRInLPM+M?=
 =?us-ascii?Q?cYny9fi2UNioC/bqrj4fHL+aywkA4a8+Et2OyTbNIrInAJgu23nQfYH2xWPD?=
 =?us-ascii?Q?GYLYvUs5eOcR3M2e04Zg1aIWa4QZ1lVeMaWcEXgULQpE9pd0kQDae5vAtolQ?=
 =?us-ascii?Q?7AGBWYJ/g4jzgUs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 13:21:50.5658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e8ba1e-0828-49eb-5fd0-08dd8332f907
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255

Hardware errors can corrupt the RAM or other system components, without
detection it can lead to crashes and system failure, this driver helps in
reporting of errors to user space, triggering corrective actions.

Add support for single bit error correction, double bit error detection
on AMD Versal NET DDR memory controller and other system errors
from various IP subsystems (e.g., RPU, NOCs, HNICX, PL) reporting.

The Versal NET EDAC listens to the notifications from NMC(Network
management controller) on RPMsg (Remote Processor Messaging).
The channel used for communicating to RPMsg is named "error_edac".
Upon receiving the notification the Versal NET edac driver
sends a RAS((Reliability, Availability, and Serviceability) event
trace. This aids the user space application to decide on the
corrective action.

For reporting events driver registers to the RAS framework
specifically:

Memory errors are reported through the Memory Controller (MC) events.
Non-memory errors are reported using non-standard RAS events.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v6:
- Update to xlnx,versal-net-ddrmc5
- Update the kconfig message
- Make the messages uniform
- Add some more supported events
- rename regval to reglo
- combine/ reformat functions
- remove trailing comments
- Remove unneeded comments
- make the amd_mcdi function void
- rename versalnet_rpmsg_edac to versalnet_edac
- Remove the column bit and use them directly
- Update the comments
- Update the mod_name to versalnet_edac
- remove the global priv col and rows
- rename edac_priv to mc_priv
- Update the comment description for dwidth
- Remove error_id enum
- rename the variable par to parity
- make get_ddr_config void
- Fix memory leak of the mcdi structure
- Update the spelling
- Remove the workqueue

Changes in v5:
- Update the compatible
- Update the handle_error documentation

Changes in v4:
- Update the compatible

Changes in v3:
- make remove void

Changes in v2:
- remove reset
- Add the remote proc requests
- remove probe_once
- reorder the rpmsg registration
- the data width , rank and number of channel is read from message.

 drivers/edac/Kconfig          |   11 +
 drivers/edac/Makefile         |    1 +
 drivers/edac/versalnet_edac.c | 1108 +++++++++++++++++++++++++++++++++
 3 files changed, 1120 insertions(+)
 create mode 100644 drivers/edac/versalnet_edac.c

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 19ad3c3b675d..081bccd3405b 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -576,4 +576,15 @@ config EDAC_LOONGSON
 	  errors (CE) only. Loongson-3A5000/3C5000/3D5000/3A6000/3C6000
 	  are compatible.
 
+config EDAC_VERSALNET
+	tristate "AMD Versal NET EDAC"
+	depends on CDX_CONTROLLER && ARCH_ZYNQMP
+	help
+	  Support for single bit error correction, double bit error detection on
+	  the AMD Versal NET DDR memory controller and other system errors
+	  from various IP subsystems (e.g., RPU, NOCs, HNICX, PL).
+
+	  Report single bit errors (CE), double bit errors (UE) and
+	  errors from other IP subsystems like RPU, APU, NOC, HNICX and PL.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index a8f2d8f6c894..8eca81f04160 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
 obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
 obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
 obj-$(CONFIG_EDAC_LOONGSON)		+= loongson_edac.o
+obj-$(CONFIG_EDAC_VERSALNET)		+= versalnet_edac.o
diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
new file mode 100644
index 000000000000..f5c77f4e8a5a
--- /dev/null
+++ b/drivers/edac/versalnet_edac.c
@@ -0,0 +1,1108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Versal NET memory controller driver
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/edac.h>
+#include "linux/mcdi.h"
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/ras.h>
+#include <linux/remoteproc.h>
+#include <linux/rpmsg.h>
+#include <linux/sizes.h>
+#include <ras/ras_event.h>
+
+#include "edac_module.h"
+
+/* Granularity of reported error in bytes */
+#define DDRMC5_EDAC_ERR_GRAIN			1
+#define MC_CMD_EDAC_GET_DDR_CONFIG_IN_LEN	4
+
+#define DDRMC5_EDAC_MSG_SIZE			256
+
+#define DDRMC5_IRQ_CE_MASK			GENMASK(18, 15)
+#define DDRMC5_IRQ_UE_MASK			GENMASK(14, 11)
+
+#define DDRMC5_RANK_1_MASK			GENMASK(11, 6)
+#define MASK_24					GENMASK(29, 24)
+#define MASK_0					GENMASK(5, 0)
+
+#define DDRMC5_LRANK_1_MASK			GENMASK(11, 6)
+#define DDRMC5_LRANK_2_MASK			GENMASK(17, 12)
+#define DDRMC5_BANK1_MASK			GENMASK(11, 6)
+#define DDRMC5_GRP_0_MASK			GENMASK(17, 12)
+#define DDRMC5_GRP_1_MASK			GENMASK(23, 18)
+
+#define ECCR_UE_CE_ADDR_HI_ROW_MASK		GENMASK(10, 0)
+
+#define DDRMC5_MAX_ROW_CNT			18
+#define DDRMC5_MAX_COL_CNT			11
+#define DDRMC5_MAX_RANK_CNT			2
+#define DDRMC5_MAX_LRANK_CNT			4
+#define DDRMC5_MAX_BANK_CNT			2
+#define DDRMC5_MAX_GRP_CNT			3
+
+#define DDRMC5_REGHI_ROW			7
+#define DDRMC5_EACHBIT				1
+#define DDRMC5_ERR_TYPE_CE			0
+#define DDRMC5_ERR_TYPE_UE			1
+#define DDRMC5_HIGH_MEM_EN			BIT(20)
+#define DDRMC5_MEM_MASK				GENMASK(19, 0)
+#define DDRMC5_X16_BASE				256
+#define DDRMC5_X16_ECC				32
+#define DDRMC5_X16_SIZE				(DDRMC5_X16_BASE + DDRMC5_X16_ECC)
+#define DDRMC5_X32_SIZE				576
+#define DDRMC5_HIMEM_BASE			(256 * SZ_1M)
+#define DDRMC5_ILC_HIMEM_EN			BIT(28)
+#define DDRMC5_ILC_MEM				GENMASK(27, 0)
+#define DDRMC5_INTERLEAVE_SEL			GENMASK(3, 0)
+#define DDRMC5_BUS_WIDTH_MASK			GENMASK(19, 18)
+#define DDRMC5_NUM_CHANS_MASK			BIT(17)
+#define DDRMC5_RANK_MASK			GENMASK(15, 14)
+#define DDRMC5_DWIDTH_MASK			GENMASK(5, 4)
+
+#define AMD_MIN_BUF_LEN				0x28
+#define AMD_ERROR_LEVEL				2
+#define AMD_ERRORID				3
+#define TOTAL_ERR_LENGTH			5
+#define AMD_MSG_ERR_OFFSET			8
+#define AMD_MSG_ERR_LENGTH			9
+#define AMD_ERR_DATA				10
+#define MCDI_RESPONSE				0xFF
+
+#define ERR_NOTIFICATION_MAX			96
+#define REG_MAX					152
+#define ADEC_MAX				152
+#define NUM_CONTROLLERS				8
+#define REGS_PER_CONTROLLER			19
+#define ADEC_NUM				19
+#define MC_CMD_EDAC_GET_OVERALL_DDR_CONFIG	2
+#define BUFFER_SZ				80
+
+#define XDDR5_BUS_WIDTH_64			0
+#define XDDR5_BUS_WIDTH_32			1
+#define XDDR5_BUS_WIDTH_16			2
+
+#define AMD_ERR				"[VERSAL_EDAC_ERR_ID: %d] Error type:"
+/**
+ * struct ecc_error_info - ECC error log information.
+ * @burstpos:		Burst position.
+ * @lrank:		Logical Rank number.
+ * @rank:		Rank number.
+ * @group:		Group number.
+ * @bank:		Bank number.
+ * @col:		Column number.
+ * @row:		Row number.
+ * @rowhi:		Row number higher bits.
+ * @i:			ECC error info.
+ */
+union ecc_error_info {
+	struct {
+		u32 burstpos:3;
+		u32 lrank:4;
+		u32 rank:2;
+		u32 group:3;
+		u32 bank:2;
+		u32 col:11;
+		u32 row:7;
+		u32 rowhi;
+	};
+	u64 i;
+} __packed;
+
+/**
+ * struct row_col_mapping - Row and column bit positions in ADEC(address decoder) registers.
+ * @row0:		Row0 bit position.
+ * @row1:		Row1 bit position.
+ * @row2:		Row2 bit position.
+ * @row3:		Row3 bit position.
+ * @row4:		Row4 bit position.
+ * @reserved:		Unused bits.
+ * @col1:		Column 1 bit position.
+ * @col2:		Column 2 bit position.
+ * @col3:		Column 3 bit position.
+ * @col4:		Column 4 bit position.
+ * @col5:		Column 5 bit position.
+ * @reservedcol:	Unused column bits.
+ * @i:			ADEC register info.
+ */
+union row_col_mapping {
+	struct {
+		u32 row0:6;
+		u32 row1:6;
+		u32 row2:6;
+		u32 row3:6;
+		u32 row4:6;
+		u32 reserved:2;
+	};
+	struct {
+		u32 col1:6;
+		u32 col2:6;
+		u32 col3:6;
+		u32 col4:6;
+		u32 col5:6;
+		u32 reservedcol:2;
+	};
+	u32 i;
+} __packed;
+
+/**
+ * struct ecc_status - ECC status information to report.
+ * @ceinfo:	Correctable error log information.
+ * @ueinfo:	Uncorrected error log information.
+ * @channel:	Channel number.
+ * @error_type:	Error type information.
+ */
+struct ecc_status {
+	union ecc_error_info ceinfo[2];
+	union ecc_error_info ueinfo[2];
+	u8 channel;
+	u8 error_type;
+};
+
+/**
+ * struct mc_priv - DDR memory controller private instance data.
+ * @message:		Buffer for framing the event specific info.
+ * @stat:		ECC status information.
+ * @error_id:		The error id.
+ * @error_level:	The error level.
+ * @dwidth:		Width of data bus excluding ECC bits.
+ * @part_len:		The support of the message received.
+ * @regs:		The registers sent on the rpmsg.
+ * @adec:		Address decode registers.
+ * @mci:		Memory controller interface.
+ * @ept:		rpmsg endpoint.
+ * @mcdi:		The mcdi handle.
+ */
+struct mc_priv {
+	char message[DDRMC5_EDAC_MSG_SIZE];
+	struct ecc_status stat;
+	u32 error_id;
+	u32 error_level;
+	u32 dwidth;
+	u32 part_len;
+	u32 regs[REG_MAX];
+	u32 adec[ADEC_MAX];
+	struct mem_ctl_info *mci;
+	struct rpmsg_endpoint *ept;
+	struct cdx_mcdi *mcdi;
+};
+
+/* Address decoder (ADEC) register information
+ * To match the order in which the register information is received from
+ * firmware
+ */
+enum adec_info {
+	CONF = 0,
+	ADEC0,
+	ADEC1,
+	ADEC2,
+	ADEC3,
+	ADEC4,
+	ADEC5,
+	ADEC6,
+	ADEC7,
+	ADEC8,
+	ADEC9,
+	ADEC10,
+	ADEC11,
+	ADEC12,
+	ADEC13,
+	ADEC14,
+	ADEC15,
+	ADEC16,
+	ADECILC,
+};
+
+enum reg_info {
+	ISR = 0,
+	IMR,
+	ECCR0_ERR_STATUS,
+	ECCR0_ADDR_LO,
+	ECCR0_ADDR_HI,
+	ECCR0_DATA_LO,
+	ECCR0_DATA_HI,
+	ECCR0_PAR,
+	ECCR1_ERR_STATUS,
+	ECCR1_ADDR_LO,
+	ECCR1_ADDR_HI,
+	ECCR1_DATA_LO,
+	ECCR1_DATA_HI,
+	ECCR1_PAR,
+	XMPU_ERR,
+	XMPU_ERR_ADDR_L0,
+	XMPU_ERR_ADDR_HI,
+	XMPU_ERR_AXI_ID,
+	ADEC_CHK_ERR_LOG,
+};
+
+static bool get_ddr_info(u32 *error_data, struct mc_priv *priv)
+{
+	u32 reglo, reghi, parity, eccr0_val, eccr1_val, isr;
+	struct ecc_status *p;
+
+	p = &priv->stat;
+
+	isr = error_data[ISR];
+
+	if (!(isr & (DDRMC5_IRQ_UE_MASK | DDRMC5_IRQ_CE_MASK)))
+		return false;
+
+	eccr0_val = error_data[ECCR0_ERR_STATUS];
+	eccr1_val = error_data[ECCR1_ERR_STATUS];
+
+	if (!eccr0_val && !eccr1_val)
+		return false;
+
+	if (!eccr0_val)
+		p->channel = 1;
+	else
+		p->channel = 0;
+
+	reglo = error_data[ECCR0_ADDR_LO];
+	reghi = error_data[ECCR0_ADDR_HI];
+	if ((isr & DDRMC5_IRQ_CE_MASK))
+		p->ceinfo[0].i = reglo | (u64)reghi << 32;
+	else if ((isr & DDRMC5_IRQ_UE_MASK))
+		p->ueinfo[0].i = reglo | (u64)reghi << 32;
+
+	parity = error_data[ECCR0_PAR];
+	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",
+		 reghi, reglo, parity);
+
+	reglo = error_data[ECCR1_ADDR_LO];
+	reghi = error_data[ECCR1_ADDR_HI];
+	if ((isr & DDRMC5_IRQ_CE_MASK))
+		p->ceinfo[1].i = reglo | (u64)reghi << 32;
+	else if ((isr & DDRMC5_IRQ_UE_MASK))
+		p->ueinfo[1].i = reglo | (u64)reghi << 32;
+
+	parity = error_data[ECCR1_PAR];
+	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",
+		 reghi, reglo, parity);
+
+	return true;
+}
+
+/**
+ * convert_to_physical - Convert to physical address.
+ * @priv:	DDR memory controller private instance data.
+ * @pinf:	ECC error info structure.
+ * @controller:	Controller number of the DDRMC5
+ * @error_data:	the DDRMC5 ADEC address decoder register data
+ *
+ * Return: Physical address of the DDR memory.
+ */
+static unsigned long convert_to_physical(struct mc_priv *priv,
+					 union ecc_error_info pinf,
+					 int controller, int *error_data)
+{
+	u32 row, blk, rsh_req_addr, interleave, ilc_base_ctrl_add, ilc_himem_en, reg, offset;
+	u64 high_mem_base, high_mem_offset, low_mem_offset, ilcmem_base;
+	unsigned long err_addr = 0, addr;
+	union row_col_mapping cols;
+	union row_col_mapping rows;
+	u32 col_bit_0;
+
+	row = pinf.rowhi << DDRMC5_REGHI_ROW | pinf.row;
+	offset = controller * ADEC_NUM;
+
+	reg = error_data[ADEC6];
+	rows.i = reg;
+	err_addr |= (row & BIT(0)) << rows.row0;
+	row >>= DDRMC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row1;
+	row >>= DDRMC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row2;
+	row >>= DDRMC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row3;
+	row >>= DDRMC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row4;
+	row >>= DDRMC5_EACHBIT;
+
+	reg = error_data[ADEC7];
+	rows.i = reg;
+	err_addr |= (row & BIT(0)) << rows.row0;
+	row >>= DDRMC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row1;
+	row >>= DDRMC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row2;
+	row >>= DDRMC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row3;
+	row >>= DDRMC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row4;
+	row >>= DDRMC5_EACHBIT;
+
+	reg = error_data[ADEC8];
+	rows.i = reg;
+	err_addr |= (row & BIT(0)) << rows.row0;
+	row >>= DDRMC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row1;
+	row >>= DDRMC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row2;
+	row >>= DDRMC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row3;
+	row >>= DDRMC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row4;
+
+	reg = error_data[ADEC9];
+	rows.i = reg;
+
+	err_addr |= (row & BIT(0)) << rows.row0;
+	row >>= DDRMC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row1;
+	row >>= DDRMC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row2;
+	row >>= DDRMC5_EACHBIT;
+
+	col_bit_0 = FIELD_GET(MASK_24, error_data[ADEC9]);
+	pinf.col >>= 1;
+	err_addr |= (pinf.col & 1) << col_bit_0;
+
+	cols.i = error_data[ADEC10];
+	err_addr |= (pinf.col & 1) << cols.col1;
+	pinf.col >>= 1;
+	err_addr |= (pinf.col & 1) << cols.col2;
+	pinf.col >>= 1;
+	err_addr |= (pinf.col & 1) << cols.col3;
+	pinf.col >>= 1;
+	err_addr |= (pinf.col & 1) << cols.col4;
+	pinf.col >>= 1;
+	err_addr |= (pinf.col & 1) << cols.col5;
+	pinf.col >>= 1;
+
+	cols.i = error_data[ADEC11];
+	err_addr |= (pinf.col & 1) << cols.col1;
+	pinf.col >>= 1;
+	err_addr |= (pinf.col & 1) << cols.col2;
+	pinf.col >>= 1;
+	err_addr |= (pinf.col & 1) << cols.col3;
+	pinf.col >>= 1;
+	err_addr |= (pinf.col & 1) << cols.col4;
+	pinf.col >>= 1;
+	err_addr |= (pinf.col & 1) << cols.col5;
+	pinf.col >>= 1;
+
+	reg = error_data[ADEC12];
+	err_addr |= (pinf.bank & BIT(0)) << (reg & MASK_0);
+	pinf.bank >>= DDRMC5_EACHBIT;
+	err_addr |= (pinf.bank & BIT(0)) << FIELD_GET(DDRMC5_BANK1_MASK, reg);
+	pinf.bank >>= DDRMC5_EACHBIT;
+
+	err_addr |= (pinf.bank & BIT(0)) << FIELD_GET(DDRMC5_GRP_0_MASK, reg);
+	pinf.group >>= DDRMC5_EACHBIT;
+	err_addr |= (pinf.bank & BIT(0)) << FIELD_GET(DDRMC5_GRP_1_MASK, reg);
+	pinf.group >>= DDRMC5_EACHBIT;
+	err_addr |= (pinf.bank & BIT(0)) << FIELD_GET(MASK_24, reg);
+	pinf.group >>= DDRMC5_EACHBIT;
+
+	reg = error_data[ADEC4];
+	err_addr |= (pinf.rank & BIT(0)) << (reg & MASK_0);
+	pinf.rank >>= DDRMC5_EACHBIT;
+	err_addr |= (pinf.rank & BIT(0)) << FIELD_GET(DDRMC5_RANK_1_MASK, reg);
+	pinf.rank >>= DDRMC5_EACHBIT;
+
+	reg = error_data[ADEC5];
+	err_addr |= (pinf.lrank & BIT(0)) << (reg & MASK_0);
+	pinf.lrank >>= DDRMC5_EACHBIT;
+	err_addr |= (pinf.lrank & BIT(0)) << FIELD_GET(DDRMC5_LRANK_1_MASK, reg);
+	pinf.lrank >>= DDRMC5_EACHBIT;
+	err_addr |= (pinf.lrank & BIT(0)) << FIELD_GET(DDRMC5_LRANK_2_MASK, reg);
+	pinf.lrank >>= DDRMC5_EACHBIT;
+	err_addr |= (pinf.lrank & BIT(0)) << FIELD_GET(MASK_24, reg);
+	pinf.lrank >>= DDRMC5_EACHBIT;
+
+	high_mem_base = (priv->adec[ADEC2 + offset] & DDRMC5_MEM_MASK) * DDRMC5_HIMEM_BASE;
+	interleave = priv->adec[ADEC13 + offset] & DDRMC5_INTERLEAVE_SEL;
+
+	high_mem_offset = priv->adec[ADEC3 + offset] & DDRMC5_MEM_MASK;
+	low_mem_offset = priv->adec[ADEC1 + offset] & DDRMC5_MEM_MASK;
+	reg = priv->adec[ADEC14 + offset];
+	ilc_himem_en = !!(reg & DDRMC5_ILC_HIMEM_EN);
+	ilcmem_base = (reg & DDRMC5_ILC_MEM) * SZ_1M;
+	if (ilc_himem_en)
+		ilc_base_ctrl_add = ilcmem_base - high_mem_offset;
+	else
+		ilc_base_ctrl_add = ilcmem_base - low_mem_offset;
+
+	if (priv->dwidth == DEV_X16) {
+		blk = err_addr / DDRMC5_X16_SIZE;
+		rsh_req_addr = (blk << 8) + ilc_base_ctrl_add;
+		err_addr = rsh_req_addr * interleave * 2;
+	} else {
+		blk = err_addr / DDRMC5_X32_SIZE;
+		rsh_req_addr = (blk << 9) + ilc_base_ctrl_add;
+		err_addr = rsh_req_addr * interleave * 2;
+	}
+
+	if ((priv->adec[ADEC2 + offset] & DDRMC5_HIGH_MEM_EN) && err_addr >= high_mem_base)
+		addr = err_addr - high_mem_offset;
+	else
+		addr = err_addr - low_mem_offset;
+
+	return addr;
+}
+
+/**
+ * handle_error - Handle Correctable and Uncorrectable errors.
+ * @priv:	DDR memory controller private instance data.
+ * @stat:	ECC status structure.
+ * @controller:	Controller number of the DDRMC5
+ * @error_data:	the DDRMC5 ADEC address decoder register data
+ *
+ * Handles ECC correctable and uncorrectable errors.
+ */
+static void handle_error(struct mc_priv  *priv, struct ecc_status *stat,
+			 int controller, int *error_data)
+{
+	struct mem_ctl_info *mci = priv->mci;
+	union ecc_error_info pinf;
+	unsigned long pa;
+	phys_addr_t pfn;
+	int err;
+
+	if (stat->error_type == DDRMC5_ERR_TYPE_CE) {
+		pinf = stat->ceinfo[stat->channel];
+		snprintf(priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type:%s Controller %d Addr at %lx\n",
+			 "CE", controller, convert_to_physical(priv, pinf, controller, error_data));
+
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+				     1, 0, 0, 0, 0, 0, -1,
+				     priv->message, "");
+	}
+
+	if (stat->error_type == DDRMC5_ERR_TYPE_UE) {
+		pinf = stat->ueinfo[stat->channel];
+		snprintf(priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type:%s controller %d Addr at %lx\n",
+			 "UE", controller, convert_to_physical(priv, pinf, controller, error_data));
+
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+				     1, 0, 0, 0, 0, 0, -1,
+				     priv->message, "");
+		pa = convert_to_physical(priv, pinf, controller, error_data);
+		pfn = PHYS_PFN(pa);
+
+		if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
+			err = memory_failure(pfn, MF_ACTION_REQUIRED);
+			if (err)
+				edac_dbg(2, "In fail of memory_failure %d\n", err);
+			else
+				edac_dbg(2, "Page at PA 0x%lx is hardware poisoned\n", pa);
+		}
+	}
+}
+
+/**
+ * init_csrows - Initialize the csrow data.
+ * @mci:	EDAC memory controller instance.
+ *
+ * Initialize the chip select rows associated with the EDAC memory
+ * controller instance.
+ */
+static void init_csrows(struct mem_ctl_info *mci)
+{
+	struct mc_priv *priv = mci->pvt_info;
+	struct csrow_info *csi;
+	struct dimm_info *dimm;
+	u32 row;
+	int ch;
+
+	for (row = 0; row < mci->nr_csrows; row++) {
+		csi = mci->csrows[row];
+		for (ch = 0; ch < csi->nr_channels; ch++) {
+			dimm = csi->channels[ch]->dimm;
+			dimm->edac_mode = EDAC_SECDED;
+			dimm->mtype = MEM_DDR5;
+			dimm->grain = DDRMC5_EDAC_ERR_GRAIN;
+			dimm->dtype = priv->dwidth;
+		}
+	}
+}
+
+static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
+{
+	mci->pdev = &pdev->dev;
+	platform_set_drvdata(pdev, mci);
+
+	/* Initialize controller capabilities and configuration */
+	mci->mtype_cap = MEM_FLAG_DDR5;
+	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
+	mci->scrub_cap = SCRUB_HW_SRC;
+	mci->scrub_mode = SCRUB_NONE;
+
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->ctl_name = "amd_ddr_controller";
+	mci->dev_name = dev_name(&pdev->dev);
+	mci->mod_name = "versalnet_edac";
+
+	edac_op_state = EDAC_OPSTATE_INT;
+
+	init_csrows(mci);
+}
+
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+static unsigned int amd_mcdi_rpc_timeout(struct cdx_mcdi *cdx, unsigned int cmd)
+{
+	return MCDI_RPC_TIMEOUT;
+}
+
+static void amd_mcdi_request(struct cdx_mcdi *cdx,
+			     const struct cdx_dword *hdr, size_t hdr_len,
+			     const struct cdx_dword *sdu, size_t sdu_len)
+{
+	unsigned char *send_buf;
+	int ret;
+
+	send_buf = kzalloc(hdr_len + sdu_len, GFP_KERNEL);
+	if (!send_buf)
+		return;
+
+	memcpy(send_buf, hdr, hdr_len);
+	memcpy(send_buf + hdr_len, sdu, sdu_len);
+
+	ret = rpmsg_send(cdx->ept, send_buf, hdr_len + sdu_len);
+	if (ret)
+		dev_err(&cdx->rpdev->dev, "Failed to send rpmsg data\n");
+	kfree(send_buf);
+}
+
+static const struct cdx_mcdi_ops mcdi_ops = {
+	.mcdi_rpc_timeout = amd_mcdi_rpc_timeout,
+	.mcdi_request = amd_mcdi_request,
+};
+
+static void get_ddr_config(u32 index, u32 *buffer, struct cdx_mcdi *amd_mcdi)
+{
+	size_t outlen;
+	int ret;
+
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_EDAC_GET_DDR_CONFIG_IN_LEN);
+	MCDI_DECLARE_BUF(outbuf, BUFFER_SZ);
+
+	MCDI_SET_DWORD(inbuf, EDAC_GET_DDR_CONFIG_IN_CONTROLLER_INDEX, index);
+
+	ret = cdx_mcdi_rpc(amd_mcdi, MC_CMD_EDAC_GET_DDR_CONFIG, inbuf, sizeof(inbuf),
+			   outbuf, sizeof(outbuf), &outlen);
+	if (!ret)
+		memcpy(buffer, MCDI_PTR(outbuf, EDAC_GET_DDR_CONFIG_OUT_REGISTER_VALUES),
+		       (ADEC_NUM * 4));
+}
+
+static void amd_setup_mcdi(struct mc_priv *mc_priv)
+{
+	struct cdx_mcdi *amd_mcdi;
+	int ret, i;
+
+	amd_mcdi = kzalloc(sizeof(*amd_mcdi), GFP_KERNEL);
+	if (!amd_mcdi)
+		return;
+
+	amd_mcdi->mcdi_ops = &mcdi_ops;
+	ret = cdx_mcdi_init(amd_mcdi);
+	if (ret) {
+		kfree(amd_mcdi);
+		return;
+	}
+
+	amd_mcdi->ept = mc_priv->ept;
+	mc_priv->mcdi = amd_mcdi;
+
+	for (i = 0; i < NUM_CONTROLLERS; i++)
+		get_ddr_config(i, &mc_priv->adec[ADEC_NUM * i], amd_mcdi);
+}
+
+static const guid_t amd_versalnet_guid = GUID_INIT(0x82678888, 0xa556, 0x44f2,
+						 0xb8, 0xb4, 0x45, 0x56, 0x2e,
+						 0x8c, 0x5b, 0xec);
+
+static int amd_rpmsg_cb(struct rpmsg_device *rpdev, void *data,
+			int len, void *priv, u32 src)
+{
+	struct mc_priv *mc_priv = dev_get_drvdata(&rpdev->dev);
+	const guid_t *sec_type = &guid_null;
+	u32 length, offset, error_id;
+	u32 *result = (u32 *)data;
+	struct ecc_status *p;
+	int i, j, k, sec_sev;
+	u32 *adec_data;
+
+	if (*(u8 *)data == MCDI_RESPONSE) {
+		cdx_mcdi_process_cmd(mc_priv->mcdi, (struct cdx_dword *)data, len);
+		return 0;
+	}
+
+	sec_sev = result[AMD_ERROR_LEVEL];
+	error_id = result[AMD_ERRORID];
+	length = result[AMD_MSG_ERR_LENGTH];
+	offset = result[AMD_MSG_ERR_OFFSET];
+
+	if (result[TOTAL_ERR_LENGTH] > length) {
+		if (!mc_priv->part_len)
+			mc_priv->part_len = length;
+		else
+			mc_priv->part_len += length;
+		/*
+		 * The data can come in 2 stretches. Construct the regs from 2
+		 * messages the offset indicates the offset from which the data is to
+		 * be taken
+		 */
+		for (i = 0 ; i < length; i++) {
+			k = offset + i;
+			j = AMD_ERR_DATA + i;
+			mc_priv->regs[k] = result[j];
+		}
+		if (mc_priv->part_len < result[TOTAL_ERR_LENGTH])
+			return 0;
+		mc_priv->part_len = 0;
+	}
+
+	mc_priv->error_id = error_id;
+	mc_priv->error_level = result[AMD_ERROR_LEVEL];
+
+	switch (error_id) {
+	/* GSW Non-Correctable error */
+	case 5:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "General Software Non-Correctable error", error_id);
+		break;
+	/* CFU error */
+	case 6:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "CFU error", error_id);
+		break;
+	/* CFRAME error */
+	case 7:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "CFRAME error", error_id);
+		break;
+	/* Microblaze correctable error */
+	case 10:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "DDRMC Microblaze Correctable ECC error", error_id);
+		break;
+	/* Microblaze Non-correctable */
+	case 11:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "DDRMC Microblaze Non-Correctable ECC error", error_id);
+		break;
+	/* MMCM error */
+	case 15:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "MMCM error", error_id);
+		break;
+	/* HNIX correctable */
+	case 16:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "HNICX Correctable error", error_id);
+		break;
+	/* HNIX Non-correctable */
+	case 17:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "HNICX Non-Correctable error", error_id);
+		break;
+	/* DDRMC correctable error */
+	case 18:
+		p = &mc_priv->stat;
+		memset(p, 0, sizeof(struct ecc_status));
+		p->error_type = DDRMC5_ERR_TYPE_CE;
+		for (i = 0 ; i < NUM_CONTROLLERS; i++) {
+			if (get_ddr_info(&mc_priv->regs[i * REGS_PER_CONTROLLER], mc_priv)) {
+				adec_data = mc_priv->adec + ADEC_NUM * i;
+				handle_error(mc_priv, &mc_priv->stat, i, adec_data);
+			}
+		}
+		return 0;
+	/* DDRMC Non-correctable */
+	case 19:
+		p = &mc_priv->stat;
+		memset(p, 0, sizeof(struct ecc_status));
+		p->error_type = DDRMC5_ERR_TYPE_UE;
+		for (i = 0 ; i < NUM_CONTROLLERS; i++) {
+			if (get_ddr_info(&mc_priv->regs[i * REGS_PER_CONTROLLER], mc_priv)) {
+				adec_data = mc_priv->adec + ADEC_NUM * i;
+				handle_error(mc_priv, &mc_priv->stat, i, adec_data);
+			}
+		}
+		return 0;
+	/* GT Correctable error */
+	case 21:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "GT Non-Correctable error", error_id);
+		break;
+	/* PL Sysmon correctable error */
+	case 22:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "PL Sysmon Correctable error", error_id);
+		break;
+	/* PL Sysmon Non-correctable error */
+	case 23:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "PL Sysmon Non-Correctable error", error_id);
+		break;
+	/* LPX unexpected dfx activation error */
+	case 111:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "LPX unexpected dfx activation error", error_id);
+		break;
+	/* INT LPD Non-Correctable error */
+	case 114:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "INT_LPD Non-Correctable error", error_id);
+		break;
+	/* INT OCM Non-Correctable error */
+	case 116:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "INT_OCM Non-Correctable error", error_id);
+		break;
+	/* INT FPD Correctable error */
+	case 117:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "INT_FPD Correctable error", error_id);
+		break;
+	/* INT FPD Non-Correctable error */
+	case 118:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "INT_FPD Non-Correctable error", error_id);
+		break;
+	/* INT IOU Non-Correctable error */
+	case 120:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "INT_IOU Non-Correctable error", error_id);
+		break;
+	/* GIC AXI err_int_irq */
+	case 123:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "err_int_irq from APU GIC Distributor", error_id);
+		break;
+	/* GIC ECC fault_int_irq */
+	case 124:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "fault_int_irq from APU GIC Distribute", error_id);
+		break;
+	/* FPX SPLITTER error */
+	case 132 ... 139:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "FPX SPLITTER error", error_id);
+		break;
+	/* APU0 error */
+	case 140:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "APU Cluster 0 error", error_id);
+		break;
+	/* APU1 error */
+	case 141:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "APU Cluster 1 error", error_id);
+		break;
+	/* APU2 error */
+	case 142:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "APU Cluster 2 error", error_id);
+		break;
+	/* APU3 error */
+	case 143:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "APU Cluster 3 error", error_id);
+		break;
+	/* Window watchdog LPX error */
+	case 145:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "WWDT1 LPX error", error_id);
+		break;
+	/* IPI error */
+	case 147:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "IPI error", error_id);
+		break;
+	/* LPX AFIFS error */
+	case 152 ... 153:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "AFIFS error", error_id);
+		break;
+	/* LPX glitch Errors */
+	case 154 ... 155:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "LPX glitch error", error_id);
+		break;
+	/* FPX AFIFS error */
+	case 185 ... 186:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "FPX AFIFS error", error_id);
+		break;
+	/* AFIFM Non-fatal error */
+	case 195 ... 199:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "AFIFM error", error_id);
+		break;
+	/* Firmware error */
+	case 108:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "PSM Correctable error", error_id);
+		break;
+	/* PMC Correctable error */
+	case 59:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "PMC correctable error", error_id);
+		break;
+	/* PMC Un-Correctable error */
+	case 60:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "PMC Un correctable error", error_id);
+		break;
+	/* PMC Sysmon temperature shutdown alert and power supply failure  errors */
+	case 43 ... 47:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "PMC Sysmon error", error_id);
+		break;
+	/* RPU Error */
+	case 163 ... 184:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "RPU error", error_id);
+		break;
+	/* OCM0 correctable error */
+	case 148:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "OCM0 correctable error", error_id);
+		break;
+	/* OCM1 correctable error */
+	case 149:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "OCM1 correctable error", error_id);
+		break;
+	/* OCM0 Un-correctable error */
+	case 150:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "OCM0 Un-correctable error", error_id);
+		break;
+	/* OCM1 Un-correctable error */
+	case 151:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "OCM1 Un-correctable error", error_id);
+		break;
+	/* PSX_CMN_3 error */
+	case 189:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "PSX_CMN_3 PD block consolidated error", error_id);
+		break;
+	/* FPD_INT_WRAP error */
+	case 191:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "FPD_INT_WRAP PD block consolidated error", error_id);
+		break;
+	/* CRAM_CE error */
+	case 232:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 AMD_ERR "CRAM Un-Correctable error", error_id);
+		break;
+	default:
+		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "VERSAL_EDAC_ERR_ID: %d", error_id);
+		break;
+	}
+
+	/* Convert to bytes */
+	length = result[TOTAL_ERR_LENGTH] * 4;
+	log_non_standard_event(sec_type, &amd_versalnet_guid, mc_priv->message,
+			       sec_sev, (void *)&result[AMD_ERR_DATA], length);
+
+	return 0;
+}
+
+static struct rpmsg_device_id amd_rpmsg_id_table[] = {
+	{ .name = "error_ipc" },
+	{ },
+};
+MODULE_DEVICE_TABLE(rpmsg, amd_rpmsg_id_table);
+
+static int amd_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_channel_info chinfo = {0};
+	struct mc_priv *pg;
+
+	pg = (struct mc_priv *)amd_rpmsg_id_table[0].driver_data;
+	chinfo.src = RPMSG_ADDR_ANY;
+	chinfo.dst = rpdev->dst;
+	strscpy(chinfo.name, amd_rpmsg_id_table[0].name,
+		strlen(amd_rpmsg_id_table[0].name));
+
+	pg->ept = rpmsg_create_ept(rpdev, amd_rpmsg_cb, NULL, chinfo);
+	if (!pg->ept)
+		return dev_err_probe(&rpdev->dev, -ENXIO,
+			      "Failed to create ept for channel %s\n",
+			      chinfo.name);
+
+	dev_set_drvdata(&rpdev->dev, pg);
+	return 0;
+}
+
+static void amd_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct mc_priv *mc_priv = dev_get_drvdata(&rpdev->dev);
+
+	rpmsg_destroy_ept(mc_priv->ept);
+	dev_set_drvdata(&rpdev->dev, NULL);
+}
+
+static struct rpmsg_driver amd_rpmsg_driver = {
+	.drv.name = KBUILD_MODNAME,
+	.probe = amd_rpmsg_probe,
+	.remove = amd_rpmsg_remove,
+	.callback = amd_rpmsg_cb,
+	.id_table = amd_rpmsg_id_table,
+};
+
+/**
+ * get_dwidth - Return the controller memory width.
+ * @width:	data width read from the config reg.
+ *
+ * Get the EDAC device type width appropriate for the controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type get_dwidth(u32 width)
+{
+	enum dev_type dt;
+
+	switch (width) {
+	case XDDR5_BUS_WIDTH_16:
+		dt = DEV_X16;
+		break;
+	case XDDR5_BUS_WIDTH_32:
+		dt = DEV_X32;
+		break;
+	case XDDR5_BUS_WIDTH_64:
+		dt = DEV_X64;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
+
+	return dt;
+}
+
+static int mc_probe(struct platform_device *pdev)
+{
+	u32 num_chans, rank, dwidth, config;
+	struct device_node *r5_core_node;
+	struct edac_mc_layer layers[2];
+	struct mem_ctl_info *mci;
+	struct mc_priv *priv;
+	struct rproc *rp;
+	enum dev_type dt;
+	int rc, i;
+
+	r5_core_node = of_parse_phandle(pdev->dev.of_node, "amd,rproc", 0);
+	if (!r5_core_node) {
+		dev_err(&pdev->dev, "amd,rproc: invalid phandle\n");
+		return -EINVAL;
+	}
+
+	rp = rproc_get_by_phandle(r5_core_node->phandle);
+	if (!rp)
+		return -EPROBE_DEFER;
+
+	rc = rproc_boot(rp);
+	if (rc) {
+		dev_err(&pdev->dev, "Failed to attach to remote processor\n");
+		rproc_put(rp);
+		return rc;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	amd_rpmsg_id_table[0].driver_data = (kernel_ulong_t)priv;
+	rc = register_rpmsg_driver(&amd_rpmsg_driver);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Failed to register RPMsg driver: %d\n", rc);
+		goto free_rproc;
+	}
+
+	amd_setup_mcdi(priv);
+
+	for (i = 0; i < NUM_CONTROLLERS; i++) {
+		config = priv->adec[CONF + i * ADEC_NUM];
+		num_chans = FIELD_GET(DDRMC5_NUM_CHANS_MASK, config);
+		rank = FIELD_GET(DDRMC5_RANK_MASK, config);
+		rank = 1 << rank;
+		dwidth = FIELD_GET(DDRMC5_BUS_WIDTH_MASK, config);
+		dt = get_dwidth(dwidth);
+
+		/* Find the first enabled device and register that one. */
+		if (dt != DEV_UNKNOWN) {
+			layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+			layers[0].size = rank;
+			layers[0].is_virt_csrow = true;
+			layers[1].type = EDAC_MC_LAYER_CHANNEL;
+			layers[1].size = num_chans;
+			layers[1].is_virt_csrow = false;
+
+			mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
+					    sizeof(struct mc_priv));
+			if (!mci) {
+				edac_printk(KERN_ERR, EDAC_MC,
+					    "Failed memory allocation for mc instance\n");
+				rc = -ENOMEM;
+				goto free_rpmsg;
+			}
+
+			priv->mci = mci;
+			priv->dwidth = dt;
+			mc_init(mci, pdev);
+			rc = edac_mc_add_mc(mci);
+			if (rc) {
+				edac_printk(KERN_ERR, EDAC_MC,
+					    "Failed to register with EDAC core\n");
+				goto free_edac_mc;
+			}
+			return 0;
+		}
+	}
+
+	return 0;
+
+free_edac_mc:
+	edac_mc_free(mci);
+free_rpmsg:
+	unregister_rpmsg_driver(&amd_rpmsg_driver);
+free_rproc:
+	rproc_shutdown(rp);
+	return rc;
+}
+
+static void mc_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct mc_priv *priv = mci->pvt_info;
+
+	unregister_rpmsg_driver(&amd_rpmsg_driver);
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+	rproc_shutdown(priv->mcdi->r5_rproc);
+}
+
+static const struct of_device_id amd_edac_match[] = {
+	{ .compatible = "xlnx,versal-net-ddrmc5", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, amd_edac_match);
+
+static struct platform_driver amd_ddr_edac_mc_driver = {
+	.driver = {
+		.name = "amd-ddrmc-edac",
+		.of_match_table = amd_edac_match,
+	},
+	.probe = mc_probe,
+	.remove = mc_remove,
+};
+
+module_platform_driver(amd_ddr_edac_mc_driver);
+
+MODULE_AUTHOR("AMD Inc");
+MODULE_DESCRIPTION("AMD DDRMC ECC driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1


