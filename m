Return-Path: <linux-edac+bounces-4407-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47294B0E13C
	for <lists+linux-edac@lfdr.de>; Tue, 22 Jul 2025 18:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131DC1C85487
	for <lists+linux-edac@lfdr.de>; Tue, 22 Jul 2025 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF4127A47C;
	Tue, 22 Jul 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IHgALPT6"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918BE27A930;
	Tue, 22 Jul 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200252; cv=fail; b=SqSPvjquTRpgFmq2fJjr/SElGI3Bw7usAxG8ip7qTwaqWQmLxCUZYjG9RL4YSyppKiIFgsbvrnrIX5kM0vOVMOzyOKLrNaSsLspcYzB7ZImgHkJs4LJCjd/MjDM6kp2VmjO6DOGZvDH8sRkmFP0ZKl2IZQrsVlSFd/NJ9eLgEd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200252; c=relaxed/simple;
	bh=dsOreIfjxtLqf0Ni6sy6AOz9aLN2dNVMWM5d1XolXtE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiMT6NoyvwmSphJ54D7bSPJT3Hu7VcTqr+InZ19vuUVLxDnwO5phQhCjxjHFwAeWmp2KAzdo7z5QMl7zWoyQNfb2yzj4oKtS4j3YvGoFH8COHF06DdndFbQcaiNvTbNO+Qs5krddQyKnJbrXMkLd+FqAex9CR2Ca1+T3S1x6HoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IHgALPT6; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tA1I4NwlirBMFtToJjGF7CgSRbLc0gr091FPPFQGWzGgx8/Ytu07ehSk1ABoJZcTF4mRH55YF1/L2u15Yy+0v2I5RUCh2St+f7VBkk69kEfTvbSh85eOmcSHanZ4LTLpnKj2zJLqGauFylx7b8q3Wkkl/E+mJHAN1md4gNDlzGGcklzTbFBkpxetLljmls6LS/WPqSjixmDz97ABkA/PCPm3VOoHmok/CCK/U/YlcEsnG9rGN/SMvnUVQSOaU5K0bTJUAzVO7o5sm2HGIiKx2lBPLdjVJMVsKOH8JTlExKdzBBgWxok4DcGJbm4Ynjoee64FVEjoT93LCy0kmVh1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFP2C+vviUKS7SsPoUdhOpCN6w+BNPUPmZMa0yvrGTI=;
 b=U99QK1YmSKs4qsEZJoHFwvf/TtZ9iLo88eg74PX6R3W/YA/jpwF3T3MX/cdtl7ZLQuV/pvDj5x1e1qPpGNrM1A2tc9LLPcqM2w02czWlSekeM3kgCBEsvC//Qk9kVOBv5/DT0o2WpWBZmpr0B2IYRN+h0yabR/n4MBJbfI+jGXVO+xMIFL6o7uyLRLJOuc5ditwiFXbscEsFCfYIltC6vaO7GK8HFTiIzpvwkul4MCTyvR+LA4Jij7qb753NvrlkVaanZNd8FBzuTV6aeOT6sYS91Jq21YDT2TkPkfc7EeguDGs4WVQPzWENhDPLS5kVaiy3soaJfSmtfZAC360GOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFP2C+vviUKS7SsPoUdhOpCN6w+BNPUPmZMa0yvrGTI=;
 b=IHgALPT6vJAJZA4yRVyYr9LUInQSaIDLqwZTRhpv0JkrNz5ZPHPsYW0X6wLePz56FvyB8u3a46M1eoSwid2jeaMlsa6bNa+uGDI1Q5NETFbofRysCMHfuP0uO4rIOQuJ+1IJG6zNcAvcAXje4Ur1mvb3E/Kon8+66u2QEaFa7ds=
Received: from SN7PR04CA0159.namprd04.prod.outlook.com (2603:10b6:806:125::14)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 22 Jul
 2025 16:04:07 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::9a) by SN7PR04CA0159.outlook.office365.com
 (2603:10b6:806:125::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 16:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 16:04:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 11:03:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 11:03:57 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 11:03:54 -0500
From: Rama devi Veggalam <rama.devi.veggalam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <james.morse@arm.com>, <mchehab@kernel.org>,
	<rric@kernel.org>, <git@amd.com>, Rama devi Veggalam
	<rama.devi.veggalam@amd.com>
Subject: [PATCH v2 4/4] edac: xilinx: Add EDAC support for Xilinx XilSem
Date: Tue, 22 Jul 2025 21:33:15 +0530
Message-ID: <20250722160315.2979294-5-rama.devi.veggalam@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: rama.devi.veggalam@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: a84d7e9b-4f5a-4716-eeb9-08ddc9396386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lAEX5ee+g8YG/lXojkxMFJEcSau8eKHCZoJQK1Pn4A1KvpBiki3yef+X2JQP?=
 =?us-ascii?Q?JtMfsDXrjG8tyUAnZATi2u5Ph1dvhwGsdO8sfaNLCUsfDTNEnPyYVLhldny7?=
 =?us-ascii?Q?h63iyy5hg7CmH4gfFTBI9ec4+IIJ9Z4LpkvkjiBz3H3bfwVoiEZJAwjY2rur?=
 =?us-ascii?Q?FCi2Tf1YOlWdgWFb3ontlXk95ohnjdULp3pDX1t927dRD1EP3ekGzBEkX+6w?=
 =?us-ascii?Q?ee5etEVamYz7s9dx8zyutabqGYJVDrDx3j2Kild48SoaUExyj8DwSc7romm5?=
 =?us-ascii?Q?KfU2U6ocn1IOnknEstU/1EDAA/KUrOI6Sh91iSLfjgAcACa1us9RyUwf+I1+?=
 =?us-ascii?Q?lAVISDXewwm2qJLf13sHDn0UQ+UJb0FTrSgg04WOaxbIraiG8l/PmjO1KC1d?=
 =?us-ascii?Q?0ZExvpvjmX1aNzAHjNpIF+Ln3GatByUBc08wwz327Z7rbr5B2HiZ9PJDBP/R?=
 =?us-ascii?Q?AQYfajKqn3gIrXkMwsh97+ULlZDXnEiY343w6Yy0tpCHY/yP0Vtan/DgVcYP?=
 =?us-ascii?Q?t746Ss/6bXJWYc4/cGuWLE6AByXhem1OEKpzJgXxi8nIRRwzskzI9jEQoUE8?=
 =?us-ascii?Q?y6w1vNPmrNdjZ2eAwW4kCy5k5BpECb+f7ZBn5yqb4MM7ddIuQsavg6aDZEs2?=
 =?us-ascii?Q?+Id6wBaYL+fbGB258h0I+VAy1981ujUf3PNDj2dK5H3/oOrtGz7byhzbCwWS?=
 =?us-ascii?Q?GMt2oeaIMG0mxFwyI5LNJa+dKzSZC8uZACFpQ67H1j6mfDYYVuP3Kd0rMi52?=
 =?us-ascii?Q?t8has1mUtyPxT5eYf9ygd7TEHgeJbmgRrPDQauNBliqh1Gu8hegFZw0Y+JE8?=
 =?us-ascii?Q?5DTdbdpFDpp3km1ydxHtQBS2vuV9iazHEZ3L//6sHoZrqbAifQ6gl+8+mXWV?=
 =?us-ascii?Q?XPYZ5m6qG3mRJPYGotK7mqUxfJ5YDBxLQGPQRYGhVW7ckc0a6EL1zWsEbVy2?=
 =?us-ascii?Q?0mud1lKPd67/mV16xzmLkO2CV7TL2njsdGGzA4DDbkTptRX4G46pORQNbPpT?=
 =?us-ascii?Q?GLIynCWj78Zxs+jMpgl2g6yByBpZhHxecKinnDMXCOO4VaQOtM+ZHeD88Bl8?=
 =?us-ascii?Q?AZMdVtV3qTmCqMSWKKB4xVRjsrjhWheZn4M4nLHVMim5HmV8BBledCnahrRy?=
 =?us-ascii?Q?j/aEpeBZo2C423Px+FRR6Z2gVLvJm7j7JVmW6ypiFEpF5PkngaNS/d2OxZ9d?=
 =?us-ascii?Q?8XD1p1hCWFGbwTD8iYLECM2mHqV9kFIK3uAwXErz1Zp0I7o5QfNh3/x/sLxt?=
 =?us-ascii?Q?pWsErA8yBltOk7D4s6bWjry5winvbaNPpk7c6UsOf5Cxc4BtEGRA1KW1T+pl?=
 =?us-ascii?Q?knvqiRfnjL7Z+QSjLWS7hauDKtWSj7jzWyQN+iLBaEMe/a9+BvGvhsEV4mnP?=
 =?us-ascii?Q?9jlQ2sHZWndnyOHGNSevqCLqvs0lFbE4ASJg1uZyZ9JPPtEqfZqC2+J8C0NM?=
 =?us-ascii?Q?C3uIqiEZQsS6ARGlTJY3psfScCjkzx6SlmnIEzAQEIXC8xyeVw2ShnSLT1es?=
 =?us-ascii?Q?d4DIP/71hx4lVVvo22TaKPzMUYMSKE4FEpET?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 16:04:07.5835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a84d7e9b-4f5a-4716-eeb9-08ddc9396386
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793

Xilinx Versal Soft Error Mitigation (XilSEM) is responsible for reporting
and optionally correcting soft errors in Configuration Memory of Versal.
The Configuration Memory includes Configuration RAM and
Network on Chip (NoC) peripheral interconnect (NPI) Registers.

The Configuration RAM (CRAM) memory is used for storing configuration
data for the programmable logic (PL) fabric. The NPI registers are used
for configuring the memory controllers, miscellaneous integrated hardware,
NoC interface units in the Veral device.

Add EDAC support for Xilinx XilSEM, this driver
handles correctable and uncorrectable error events.
- Register for the notification.
- After receiving the notification handle the correctable and
  uncorrectable errors.

Add sysfs interface for XilSEM scan operations
initialize, start, stop scan, error inject, read ECC, scan status and
configuration values.

Signed-off-by: Rama devi Veggalam <rama.devi.veggalam@amd.com>
---
Changes in v2:
- Patch created on top of dependent patch series
"enhance zynqmp_pm_get_family_info()"
- Fixed maximum length warning in patch description
- Added details for eprobe_defer conditions
- Updated copyright information
- Removed ARCH_ZYNQMP in dependent list of XilSEM Kconfig
- Added error code for invalid versal device type
- Removed redundant sysfs details in function headers
- Included MAINTAINERS to this patch
- Added more description in commit message
- Removed print for probe success
- Removed function comments for xsem_edac_remove()
---
 MAINTAINERS                       |   6 +
 drivers/edac/Kconfig              |  23 +
 drivers/edac/Makefile             |   1 +
 drivers/edac/xilinx_xilsem_edac.c | 746 ++++++++++++++++++++++++++++++
 4 files changed, 776 insertions(+)
 create mode 100644 drivers/edac/xilinx_xilsem_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 10850512c118..6fcdc084716e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27298,6 +27298,12 @@ S:	Maintained
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
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 19ad3c3b675d..4557248cc596 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -567,6 +567,29 @@ config EDAC_VERSAL
 	  Support injecting both correctable and uncorrectable errors
 	  for debugging purposes.
 
+config EDAC_XILINX_XILSEM
+	tristate "Xilinx Versal XilSEM Controller"
+	depends on ZYNQMP_FIRMWARE
+	help
+	  Support for handling error events on the Xilinx Versal Xilsem
+	  controller.
+
+	  Xilinx Versal Soft Error Mitigation (XilSEM) is part of the
+	  Platform Loader and Manager (PLM) which is loaded into and runs on the
+	  Platform Management Controller (PMC). XilSEM is responsible for detecting
+	  and optionally correcting soft errors in Configuration Memory of Versal.
+	  The Configuration RAM (CRAM) memory is used for storing configuration
+	  data for the programmable logic (PL) fabric. The NPI registers are used for
+	  configuring the memory controllers, miscellaneous integrated hardware,
+	  NoC interface units in the Veral device.
+
+	  Whenever an error is detected in the Configuration Memory, be it correctable
+	  or uncorrectable, XilSEM reports the error to user application.
+	  This driver is responsible for handling the reported correctable and
+	  uncorrectable errors. Also, provides sysfs interface for scan control operations.
+	  The scan operations include initialization, start, stop, error inject, read ECC,
+	  scan status and configuration values.
+
 config EDAC_LOONGSON
 	tristate "Loongson Memory Controller"
 	depends on LOONGARCH && ACPI
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index a8f2d8f6c894..55d9bf7f818d 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
 obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
+obj-$(CONFIG_EDAC_XILINX_XILSEM)	+= xilinx_xilsem_edac.o
 obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
 obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
 obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
diff --git a/drivers/edac/xilinx_xilsem_edac.c b/drivers/edac/xilinx_xilsem_edac.c
new file mode 100644
index 000000000000..d74f5d0150e6
--- /dev/null
+++ b/drivers/edac/xilinx_xilsem_edac.c
@@ -0,0 +1,746 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/edac.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/sizes.h>
+#include <linux/bitfield.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/firmware/xlnx-versal-error-events.h>
+#include <linux/firmware/xlnx-versal-net-error-events.h>
+#include <linux/firmware/xlnx-event-manager.h>
+
+#include "edac_module.h"
+
+#define VERSAL_XILSEM_EDAC_MSG_SIZE	256
+#define VERSAL_XILSEM_EDAC_STRNG	"versal_xilsem"
+#define EDAC_DEVICE	"Xilsem"
+
+/* XilSem CE Error log count */
+#define XILSEM_MAX_CE_LOG_CNT	0x07
+
+/* XilSem_CRAM scan error info registers */
+#define CRAM_STS_INFO_OFFSET	0x34
+#define CRAM_CE_ADDRL0_OFFSET	0x38
+#define CRAM_CE_ADDRH0_OFFSET	0x3C
+#define CRAM_CE_COUNT_OFFSET	0x70
+
+/* XilSem_NPI_Scan uncorrectable error info registers */
+#define NPI_SCAN_COUNT			0x24
+#define NPI_SCAN_HB_COUNT		0x28
+#define NPI_ERR0_INFO_OFFSET	0x2C
+#define NPI_ERR1_INFO_OFFSET	0x30
+
+/* XilSem bit masks for extracting error details */
+#define CRAM_ERR_ROW_MASK	GENMASK(26, 23)
+#define CRAM_ERR_BIT_MASK	GENMASK(22, 16)
+#define CRAM_ERR_QWRD_MASK	GENMASK(27, 23)
+#define CRAM_ERR_FRAME_MASK	GENMASK(22, 0)
+
+enum xsem_cmd_id {
+	CRAM_INIT_SCAN = 1, /* To initialize CRAM scan */
+	CRAM_START_SCAN = 2, /* To start CRAM scan */
+	CRAM_STOP_SCAN = 3, /* To stop CRAM scan */
+	CRAM_ERR_INJECT = 4, /* To inject CRAM error */
+	NPI_START_SCAN = 5, /* To start NPI scan */
+	NPI_STOP_SCAN = 6, /* To stop NPI scan */
+	NPI_ERR_INJECT = 7, /* To inject NPI error */
+};
+
+/* XilSem Module IDs */
+#define CRAM_MOD_ID			0x1
+#define NPI_MOD_ID			0x2
+
+/**
+ * struct ecc_error_info - ECC error log information
+ * @status:	CRAM/NPI scan error status
+ * @data0:	Checksum of the error descriptor
+ * @data1:	Index of the error descriptor
+ * @frame_addr:	Frame location at which error occurred
+ * @block_type:	Block type
+ * @row_id:	Row number
+ * @bit_loc:	Bit position in the Qword
+ * @qword:	Qword location in the frame
+ */
+struct ecc_error_info {
+	u32 status;
+	u32 data0;
+	u32 data1;
+	u32 frame_addr;
+	u8 block_type;
+	u8 row_id;
+	u8 bit_loc;
+	u8 qword;
+};
+
+/**
+ * struct xsem_error_status - ECC status information to report
+ * @ce_cnt:	Correctable error count
+ * @ue_cnt:	Uncorrectable error count
+ * @ceinfo:	Correctable error log information
+ * @ueinfo:	Uncorrectable error log information
+ */
+struct xsem_error_status {
+	u32 ce_cnt;
+	u32 ue_cnt;
+	struct ecc_error_info ceinfo;
+	struct ecc_error_info ueinfo;
+};
+
+/**
+ * struct xsem_edac_priv - Xilsem private instance data
+ * @baseaddr:	Base address of the XilSem PLM RTCA module
+ * @scan_ctrl_status:	Buffer for scan ctrl commands
+ * @cram_errinj_status:	Buffer for CRAM error injection
+ * @cram_frame_ecc:	Buffer for CRAM frame ECC
+ * @xilsem_status:	Buffer for CRAM & NPI status
+ * @sw_event_node_id: Error event node Id
+ * @xilsem_cfg:	Buffer for CRAM & NPI configuration
+ * @cram_ce_mask: Event bit mask for CRAM correctable error
+ * @cram_ue_mask: Event bit mask for CRAM uncorrectable error
+ * @npi_ue_mask: Event bit mask for NPI uncorrectable error
+ * @ce_cnt:	Correctable Error count
+ * @ue_cnt:	Uncorrectable Error count
+ */
+struct xsem_edac_priv {
+	void __iomem *baseaddr;
+	u32 scan_ctrl_status[2];
+	u32 cram_errinj_status[2];
+	u32 cram_frame_ecc[4];
+	u32 xilsem_status[4];
+	u32 sw_event_node_id;
+	u32 xilsem_cfg[4];
+	u32 cram_ce_mask;
+	u32 cram_ue_mask;
+	u32 npi_ue_mask;
+	u32 ce_cnt;
+	u32 ue_cnt;
+};
+
+/**
+ * xsem_scan_control_show - Shows scan control operation status
+ * @dci:	Pointer to the edac device struct
+ * @data:	Pointer to user data
+ *
+ * Shows the scan control operations status
+ * Return: Number of bytes copied.
+ */
+static ssize_t xsem_scan_control_show(struct edac_device_ctl_info *dci, char *data)
+{
+	struct xsem_edac_priv *priv = dci->pvt_info;
+
+	return sprintf(data, "[0x%x][0x%x]\n\r",
+			priv->scan_ctrl_status[0], priv->scan_ctrl_status[1]);
+}
+
+/**
+ * xsem_scan_control_store - Set scan control operation
+ * @dci:	Pointer to the edac device struct
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * User-space interface for doing Xilsem scan operations
+ * (initialization, start, stop)
+ * Return: count argument if request succeeds, else error code
+ */
+static ssize_t xsem_scan_control_store(struct edac_device_ctl_info *dci,
+				       const char *data, size_t count)
+{
+	struct xsem_edac_priv *priv = dci->pvt_info;
+	u32 cmd;
+	int ret;
+
+	if (!data)
+		return -EFAULT;
+
+	if (kstrtouint(data, 0, &cmd))
+		return -EINVAL;
+
+	if (cmd < CRAM_INIT_SCAN || cmd > NPI_ERR_INJECT ||
+	    cmd == CRAM_ERR_INJECT)
+		return -EINVAL;
+
+	ret = zynqmp_pm_xilsem_cntrl_ops(cmd, priv->scan_ctrl_status);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+/**
+ * xsem_cram_injecterr_show - Shows CRAM error injection status
+ * @dci:	Pointer to the edac device struct
+ * @data:	Pointer to user data
+ *
+ * Shows CRAM error injection status
+ * Return: Number of bytes copied.
+ */
+static ssize_t xsem_cram_injecterr_show(struct edac_device_ctl_info *dci, char *data)
+{
+	struct xsem_edac_priv *priv = dci->pvt_info;
+
+	return sprintf(data, "[0x%x][0x%x]\n\r", priv->cram_errinj_status[0],
+				   priv->cram_errinj_status[1]);
+}
+
+/**
+ * xsem_cram_injecterr_store - Start error injection
+ * @dci:	Pointer to the edac device struct
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * User-space interface for doing CRAM error injection
+ * Return: count argument if request succeeds, else error code
+ */
+static ssize_t xsem_cram_injecterr_store(struct edac_device_ctl_info *dci,
+					 const char *data, size_t count)
+{
+	struct xsem_edac_priv *priv = dci->pvt_info;
+	char *kern_buff, *inbuf, *tok;
+	u32 row, frame, qword, bitloc;
+	int ret;
+
+	kern_buff = kzalloc(count, GFP_KERNEL);
+	if (!kern_buff)
+		return -ENOMEM;
+
+	strscpy(kern_buff, data, count);
+
+	inbuf = kern_buff;
+
+	/* Read Frame number */
+	tok = strsep(&inbuf, " ");
+	if (!tok) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = kstrtouint(tok, 0, &frame);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	/* Read Qword number */
+	tok = strsep(&inbuf, " ");
+	if (!tok) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = kstrtouint(tok, 0, &qword);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	/* Read Bit location */
+	tok = strsep(&inbuf, " ");
+	if (!tok) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = kstrtouint(tok, 0, &bitloc);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	/* Read Row number */
+	tok = strsep(&inbuf, " ");
+	if (!tok) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = kstrtouint(tok, 0, &row);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = zynqmp_pm_xilsem_cram_errinj(frame, qword, bitloc, row,
+					   priv->cram_errinj_status);
+err:
+	kfree(kern_buff);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+/**
+ * xsem_cram_framecc_read_show - Shows CRAM Frame ECC
+ * @dci:	Pointer to the edac device struct
+ * @data:	Pointer to user data
+ *
+ * Shows CRAM Frame ECC value
+ * Return: Number of bytes copied.
+ */
+static ssize_t xsem_cram_framecc_read_show(struct edac_device_ctl_info *dci,
+					   char *data)
+{
+	struct xsem_edac_priv *priv = dci->pvt_info;
+
+	return sprintf(data, "[0x%x][0x%x][0x%x][0x%x]\n\r",
+		       priv->cram_frame_ecc[0], priv->cram_frame_ecc[1],
+		       priv->cram_frame_ecc[2], priv->cram_frame_ecc[3]);
+}
+
+/**
+ * xsem_cram_framecc_read_store - Read CRAM Frame ECC
+ * @dci:	Pointer to the edac device struct
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * User-space interface for reading CRAM frame ECC
+ * Return: count argument if request succeeds, else error code
+ */
+static ssize_t xsem_cram_framecc_read_store(struct edac_device_ctl_info *dci,
+					    const char *data, size_t count)
+{
+	struct xsem_edac_priv *priv = dci->pvt_info;
+	char *kern_buff, *inbuf, *tok;
+	u32 frameaddr, row;
+	int ret;
+
+	kern_buff = kzalloc(count, GFP_KERNEL);
+	if (!kern_buff)
+		return -ENOMEM;
+
+	strscpy(kern_buff, data, count);
+
+	inbuf = kern_buff;
+
+	/* Read Frame address */
+	tok = strsep(&inbuf, " ");
+	if (!tok) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = kstrtouint(tok, 0, &frameaddr);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	/* Read Row number */
+	tok = strsep(&inbuf, " ");
+	if (!tok) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = kstrtouint(tok, 0, &row);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = zynqmp_pm_xilsem_cram_readecc(frameaddr, row, priv->cram_frame_ecc);
+err:
+	kfree(kern_buff);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+/**
+ * xsem_read_status_show - Shows CRAM & NPI scan status
+ * @dci:	Pointer to the edac device struct
+ * @data:	Pointer to user data
+ *
+ * Shows CRAM & NPI scan status
+ * Return: Number of bytes copied.
+ */
+static ssize_t xsem_read_status_show(struct edac_device_ctl_info *dci, char *data)
+{
+	struct xsem_edac_priv *priv = dci->pvt_info;
+
+	return sprintf(data, "[0x%x][0x%x][0x%x]\n\r",
+			priv->xilsem_status[0], priv->xilsem_status[1],
+			priv->xilsem_status[2]);
+}
+
+/**
+ * xsem_read_status_store - Read CRAM & NPI scan status
+ * @dci:	Pointer to the edac device struct
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * User-space interface for reading Xilsem CRAM & NPI scan status
+ * Return: count argument if rea succeeds, else error code
+ */
+static ssize_t xsem_read_status_store(struct edac_device_ctl_info *dci,
+				      const char *data, size_t count)
+{
+	struct xsem_edac_priv *priv = dci->pvt_info;
+	u32 module;
+
+	if (!data)
+		return -EFAULT;
+
+	if (kstrtouint(data, 0, &module))
+		return -EINVAL;
+
+	if (module == CRAM_MOD_ID) {
+		priv->xilsem_status[0] = readl(priv->baseaddr + CRAM_STS_INFO_OFFSET);
+		priv->xilsem_status[1] = readl(priv->baseaddr + CRAM_CE_COUNT_OFFSET);
+		priv->xilsem_status[2] = 0;
+	} else if (module == NPI_MOD_ID) {
+		priv->xilsem_status[0] = readl(priv->baseaddr);
+		priv->xilsem_status[1] = readl(priv->baseaddr + NPI_SCAN_COUNT);
+		priv->xilsem_status[2] = readl(priv->baseaddr + NPI_SCAN_HB_COUNT);
+	} else {
+		edac_printk(KERN_ERR, EDAC_DEVICE, "Invalid module %d\n", module);
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+/**
+ * xsem_read_config_show - Shows CRAM & NPI configuration
+ * @dci:	Pointer to the edac device struct
+ * @data:	Pointer to user data
+ *
+ * Shows CRAM & NPI configuration
+ * Return: Number of bytes copied.
+ */
+static ssize_t xsem_read_config_show(struct edac_device_ctl_info *dci, char *data)
+{
+	struct xsem_edac_priv *priv = dci->pvt_info;
+
+	return sprintf(data, "[0x%x][0x%x][0x%x][0x%x]\n\r",
+		       priv->xilsem_cfg[0], priv->xilsem_cfg[1],
+		       priv->xilsem_cfg[2], priv->xilsem_cfg[3]);
+}
+
+/**
+ * xsem_read_config_store - Read CRAM & NPI configuration
+ * @dci:	Pointer to the edac device struct
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * User-space interface for reading Xilsem configuration
+ * Return: count argument if request succeeds, else error code
+ */
+static ssize_t xsem_read_config_store(struct edac_device_ctl_info *dci,
+				      const char *data, size_t count)
+{
+	struct xsem_edac_priv *priv = dci->pvt_info;
+	int ret;
+
+	if (!data)
+		return -EFAULT;
+
+	ret = zynqmp_pm_xilsem_read_cfg(priv->xilsem_cfg);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+/**
+ * xsem_handle_error - Handle XilSem error types CE and UE
+ * @dci:	Pointer to the edac device controller instance
+ * @p:		Pointer to the xilsem error status structure
+ *
+ * Handles the correctable and uncorrectable error.
+ */
+static void xsem_handle_error(struct edac_device_ctl_info *dci, struct xsem_error_status *p)
+{
+	struct ecc_error_info *pinf;
+	char message[VERSAL_XILSEM_EDAC_MSG_SIZE];
+
+	if (p->ce_cnt) {
+		pinf = &p->ceinfo;
+		snprintf(message, VERSAL_XILSEM_EDAC_MSG_SIZE,
+			 "\n\rXILSEM CRAM error type :%s\n\r"
+			 "\nFrame_Addr: [0x%X]\t Row_num: [0x%X]\t Bit_loc: [0x%X]\t Qword: [0x%X]\n\r",
+			 "CE", pinf->frame_addr, pinf->row_id,
+			 pinf->bit_loc, pinf->qword);
+		edac_device_handle_ce(dci, 0, 0, message);
+	}
+
+	if (p->ue_cnt) {
+		pinf = &p->ueinfo;
+		snprintf(message, VERSAL_XILSEM_EDAC_MSG_SIZE,
+			 "\n\rXILSEM error type :%s\n\r"
+			 "status: [0x%X]\n\rError_Info0: [0x%X]\n\r"
+			 "Error_Info1: [0x%X]",
+			 "UE", pinf->status, pinf->data0, pinf->data1);
+		edac_device_handle_ue(dci, 0, 0, message);
+	}
+}
+
+/**
+ * xsem_geterror_info - Get the current ecc error info
+ * @dci:	Pointer to the edac device controller instance
+ * @p:		Pointer to the Xilsem error status structure
+ * @mask:	mask indictaes the error type
+ *
+ * Determines there is any ecc error or not
+ */
+static void xsem_geterror_info(struct edac_device_ctl_info *dci, struct xsem_error_status *p,
+			       int mask)
+{
+	struct xsem_edac_priv *priv = dci->pvt_info;
+	u32 error_word_0, error_word_1, ce_count;
+	u8 index;
+
+	if (mask & priv->cram_ce_mask) {
+		p->ce_cnt++;
+
+		/* Read CRAM total correctable error count */
+		ce_count = readl(priv->baseaddr + CRAM_CE_COUNT_OFFSET);
+		/* Calculate index for error log */
+		index = (ce_count % XILSEM_MAX_CE_LOG_CNT);
+		/*
+		 * Check if addr index is not 0
+		 * if yes, then decrement index, else set index as last entry
+		 */
+		if (index != 0U) {
+			/* Decrement Index */
+			--index;
+		} else {
+			/* Set log index to 6 (Max-1) */
+			index = (XILSEM_MAX_CE_LOG_CNT - 1);
+		}
+		error_word_0 = readl(priv->baseaddr + CRAM_CE_ADDRL0_OFFSET + (index * 8U));
+		error_word_1 = readl(priv->baseaddr + CRAM_CE_ADDRH0_OFFSET + (index * 8U));
+
+		/* Frame is at 22:0 bits of SEM_CRAMERR_ADDRH0 reg */
+		p->ceinfo.frame_addr = FIELD_GET(CRAM_ERR_FRAME_MASK, error_word_1);
+
+		/* row is at 26:23 bits of SEM_CRAMERR_ADDRH0 reg */
+		p->ceinfo.row_id = FIELD_GET(CRAM_ERR_ROW_MASK, error_word_1);
+
+		/* bit is at 22:16 bits of SEM_CRAMERR_ADDRL0 reg */
+		p->ceinfo.bit_loc = FIELD_GET(CRAM_ERR_BIT_MASK, error_word_0);
+
+		/* Qword is at 27:23 bits of SEM_CRAMERR_ADDRL0 reg */
+		p->ceinfo.qword = FIELD_GET(CRAM_ERR_QWRD_MASK, error_word_0);
+
+		/* Read CRAM status */
+		p->ceinfo.status = readl(priv->baseaddr + CRAM_STS_INFO_OFFSET);
+	} else if (mask & priv->cram_ue_mask) {
+		p->ue_cnt++;
+		p->ueinfo.data0 = 0;
+		p->ueinfo.data1 = 0;
+		p->ueinfo.status = readl(priv->baseaddr + CRAM_STS_INFO_OFFSET);
+	} else if (mask & priv->npi_ue_mask) {
+		p->ue_cnt++;
+		p->ueinfo.data0 = readl(priv->baseaddr + NPI_ERR0_INFO_OFFSET);
+		p->ueinfo.data1 = readl(priv->baseaddr + NPI_ERR1_INFO_OFFSET);
+		p->ueinfo.status = readl(priv->baseaddr);
+	} else {
+		edac_printk(KERN_ERR, EDAC_DEVICE, "Invalid Event received %d\n", mask);
+	}
+}
+
+/**
+ * xsem_err_callback - Handle Correctable and Uncorrectable errors.
+ * @payload:	payload data.
+ * @data:	controller data.
+ *
+ * Handles ECC correctable and uncorrectable errors.
+ */
+static void xsem_err_callback(const u32 *payload, void *data)
+{
+	struct edac_device_ctl_info *dci = (struct edac_device_ctl_info *)data;
+	struct xsem_error_status stat;
+	struct xsem_edac_priv *priv;
+	int event;
+
+	priv = dci->pvt_info;
+	memset(&stat, 0, sizeof(stat));
+	/* Read payload to get the event type */
+	event = payload[2];
+	edac_printk(KERN_INFO, EDAC_DEVICE, "Event received %x\n", event);
+	xsem_geterror_info(dci, &stat, event);
+
+	priv->ce_cnt += stat.ce_cnt;
+	priv->ue_cnt += stat.ue_cnt;
+	xsem_handle_error(dci, &stat);
+}
+
+static struct edac_dev_sysfs_attribute xsem_edac_sysfs_attributes[] = {
+	{
+		.attr = {
+			.name = "xsem_scan_control_ops",
+			.mode = (0644)
+		},
+		.show = xsem_scan_control_show,
+		.store = xsem_scan_control_store},
+	{
+		.attr = {
+			.name = "xsem_cram_injecterr",
+			.mode = (0644)
+		},
+		.show = xsem_cram_injecterr_show,
+		.store = xsem_cram_injecterr_store},
+	{
+		.attr = {
+			.name = "xsem_cram_framecc_read",
+			.mode = (0644)
+		},
+		.show = xsem_cram_framecc_read_show,
+		.store = xsem_cram_framecc_read_store},
+	{
+		.attr = {
+			.name = "xsem_read_status",
+			.mode = (0644)
+		},
+		.show = xsem_read_status_show,
+		.store = xsem_read_status_store},
+	{
+		.attr = {
+			.name = "xsem_read_config",
+			.mode = (0644)
+		},
+		.show = xsem_read_config_show,
+		.store = xsem_read_config_store},
+	{
+		.attr = {.name = NULL}
+	}
+};
+
+/**
+ * xsem_edac_probe - Check controller and bind driver.
+ * @pdev:	platform device.
+ *
+ * Probe a specific controller instance for binding with the driver.
+ *
+ * Return: 0 if the controller instance was successfully bound to the
+ * driver; otherwise, < 0 on error.
+ */
+static int xsem_edac_probe(struct platform_device *pdev)
+{
+	struct xsem_edac_priv *priv;
+	void __iomem *plmrtca_baseaddr;
+	struct edac_device_ctl_info *dci;
+	u32 family_code;
+	int rc;
+
+	plmrtca_baseaddr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(plmrtca_baseaddr))
+		return PTR_ERR(plmrtca_baseaddr);
+
+	dci = edac_device_alloc_ctl_info(sizeof(*priv), VERSAL_XILSEM_EDAC_STRNG,
+					 1, VERSAL_XILSEM_EDAC_STRNG, 1, 0,
+					 edac_device_alloc_index());
+	if (!dci) {
+		edac_printk(KERN_ERR, EDAC_DEVICE, "Unable to allocate EDAC device\n");
+		return -ENOMEM;
+	}
+
+	priv = dci->pvt_info;
+	platform_set_drvdata(pdev, dci);
+	dci->dev = &pdev->dev;
+	priv->baseaddr = plmrtca_baseaddr;
+	dci->mod_name = pdev->dev.driver->name;
+	dci->ctl_name = VERSAL_XILSEM_EDAC_STRNG;
+	dci->dev_name = dev_name(&pdev->dev);
+
+	dci->sysfs_attributes = xsem_edac_sysfs_attributes;
+	rc = edac_device_add_device(dci);
+	if (rc)
+		goto free_dev_ctl;
+
+	rc = zynqmp_pm_get_family_info(&family_code);
+	if (rc) {
+		/*
+		 * Firmware driver returns -ENODEV if it is not probed. In this case,
+		 * defer xsem_edac_probe.
+		 */
+		if (rc == -ENODEV)
+			rc = -EPROBE_DEFER;
+		goto free_edac_dev;
+	}
+
+	if (family_code == PM_VERSAL_NET_FAMILY_CODE) {
+		priv->sw_event_node_id = VERSAL_NET_EVENT_ERROR_SW_ERR;
+		priv->cram_ce_mask = XPM_VERSAL_NET_EVENT_ERROR_MASK_XSEM_CRAM_CE;
+		priv->cram_ue_mask = XPM_VERSAL_NET_EVENT_ERROR_MASK_XSEM_CRAM_UE;
+		priv->npi_ue_mask = XPM_VERSAL_NET_EVENT_ERROR_MASK_XSEM_NPI_UE;
+	} else if (family_code == PM_VERSAL_FAMILY_CODE) {
+		priv->sw_event_node_id = VERSAL_EVENT_ERROR_SW_ERR;
+		priv->cram_ce_mask = XPM_VERSAL_EVENT_ERROR_MASK_XSEM_CRAM_CE_5;
+		priv->cram_ue_mask = XPM_VERSAL_EVENT_ERROR_MASK_XSEM_CRAM_UE_6;
+		priv->npi_ue_mask = XPM_VERSAL_EVENT_ERROR_MASK_XSEM_NPI_UE_7;
+	} else {
+		edac_printk(KERN_ERR, EDAC_DEVICE, "Invalid Device Sub family code %d\n",
+			    family_code);
+		rc = -ENODEV;
+		goto free_edac_dev;
+	}
+	rc = xlnx_register_event(PM_NOTIFY_CB, priv->sw_event_node_id,
+				 priv->cram_ce_mask | priv->cram_ue_mask | priv->npi_ue_mask,
+				 false, xsem_err_callback, dci);
+	if (rc) {
+		/*
+		 * Register event API returns -EACCES if the event manager driver is not probed.
+		 * In this case, defer xsem_edac_probe.
+		 */
+		if (rc == -EACCES)
+			rc = -EPROBE_DEFER;
+		goto free_edac_dev;
+	}
+
+	return rc;
+
+free_edac_dev:
+	edac_device_del_device(&pdev->dev);
+free_dev_ctl:
+	edac_device_free_ctl_info(dci);
+
+	return rc;
+}
+
+static void xsem_edac_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
+	struct xsem_edac_priv *priv = dci->pvt_info;
+
+	xlnx_unregister_event(PM_NOTIFY_CB, priv->sw_event_node_id,
+			      priv->cram_ce_mask | priv->cram_ue_mask | priv->npi_ue_mask,
+			      xsem_err_callback, dci);
+	edac_device_del_device(&pdev->dev);
+	edac_device_free_ctl_info(dci);
+}
+
+static const struct of_device_id xlnx_xsem_edac_match[] = {
+	{ .compatible = "xlnx,versal-xilsem-edac", },
+	{
+		/* end of table */
+	}
+};
+
+MODULE_DEVICE_TABLE(of, xlnx_xsem_edac_match);
+
+static struct platform_driver xilinx_xsem_edac_driver = {
+	.driver = {
+		.name = "xilinx-xilsem-edac",
+		.of_match_table = xlnx_xsem_edac_match,
+	},
+	.probe = xsem_edac_probe,
+	.remove = xsem_edac_remove,
+};
+
+module_platform_driver(xilinx_xsem_edac_driver);
+
+MODULE_AUTHOR("Advanced Micro Devices, Inc.");
+MODULE_DESCRIPTION("Xilinx XilSEM driver");
+MODULE_LICENSE("GPL");
-- 
2.23.0


