Return-Path: <linux-edac+bounces-4687-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55120B35361
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 07:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522E17B1C30
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 05:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988542EFDAF;
	Tue, 26 Aug 2025 05:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0beF4pYy"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768312F1FE6;
	Tue, 26 Aug 2025 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186194; cv=fail; b=jYGhJKgM9FtARMEIodnKA3zuqk0fq7qA4p19k9/q4niAGJj0deidSW5aRF8zCU7dXyPK+4tabiv4wlAK40+x8lhG4LZKWzmS2dhb+PgsCbhGJLPEQ+IXmEoyA/vpaoRl6MNTKjbp0HL3vJNkxm1GjQQiHKykh6kjJ/hTyeIuK0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186194; c=relaxed/simple;
	bh=eGhSJZgDBwujMAWuXyLfdRQHy//VW/Tw2AuwKoghCcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOCPqMF63USA2lEQxBwxAwkRg+KyFK6w+nEBd3cU93I9xnHpyRFZ43KIO44weVZv9SnWVMSKrcBh6zOzM27GVXdKvC65xA6NaPqQKlR1TlQqXpeOluOvYw3hmSO+x8EAGug2jGyWlvEHHYZOP2uxLGOse0vuhuUkZx/8WzDaGkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0beF4pYy; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUStS9NOWFGZGf8MIM/6REhPWV8F+hd2uHcvXQsQ/irffH1mArqWI1aGTB4lRfp/GO21f6YEzbvR9N39PwOytl1fcUuyr/RN4XTWRQvpkxudKY404M8TgNOzGQgIUHXorPMcBy22gf1+7m9HssyMVf56ubfKQpLiRdQnOlQScqhJePoc/doIbR4q3AUIN+yA+sgFo9/rAiTtGQKGpgMDgCg1Pzl1b+DhJTOExCZaSn+SGMigCqVVIgwVt8I5f4qUZCxuVVI9xD0mctTeV+qpriX8e6mM5JJKuUK7dhqmOu++ZswEPjDWcynHOclfAv+seAb+PJ9O4zGaewz/064BVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3UXtLdOZ+v5DIhDimW3z41raz4h98f+QbJogP/vjeg=;
 b=r4K5Y6el+w8eeT13n1ENSJvoq6/65SH9DJAmAiletUtHAtapxASQ3PbhTvE4AY61JoPEO3Bn7O2mcuUJvLL9kwq0mMYm0N9opKiuv2nRrd9o/bu0Hfyc6REETwAhtn9HEklX/r5t4kS4FzTkuaYM9DElOte2uTWI3Ec7Qn8m836jUobcLBMauJrFrs4eisd6YAFrhx++4pOcGcbH9gvD36rDv/QgYuN/aflcj0+z1Ft6xpbuWB+1wwB3gPxuztBZP/TctsjdTdxql2lm5GIUPpZ1DzGzSh8LmCQww8N1yd30QQWM0PzYppDUDsT18tK9ppTkyrtPWex9PRR6UYJ7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3UXtLdOZ+v5DIhDimW3z41raz4h98f+QbJogP/vjeg=;
 b=0beF4pYyAg+ZiDUhDlPqowCP1iG0YCCES2ItyDfNs8M9YUwyAWkjUHH+UOb1k97fDEeXq610eqnopBBAWwIJtEKg4FNn4QB0sC8+p0IrEoUZBDk4pbbru9n5IJ2unanqwX0X3y+0mhz7o2KSSKpdfugzCsjPIS27qtBxJiHorSk=
Received: from CH0P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::15)
 by BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 05:29:45 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::b8) by CH0P223CA0003.outlook.office365.com
 (2603:10b6:610:116::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Tue,
 26 Aug 2025 05:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:29:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:29:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:29:43 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 26 Aug 2025 00:29:38 -0500
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
Subject: [PATCH v8 5/5] EDAC/VersalNET: Add support for error notification
Date: Tue, 26 Aug 2025 10:59:14 +0530
Message-ID: <20250826052914.2066884-6-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f4b069-0e4b-406c-a052-08dde4619120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?coRrB0Tp/EKKr3KvxaoJ6Sar6o6Ga0ssVarszvsjh8Y8/r0dHaqe8T5XFHiN?=
 =?us-ascii?Q?s2Joiqz4b79OhxmnFy7jmjXZPJnxP+3Fv0FoB7app3V7ej77zkJHUuP7Nxlz?=
 =?us-ascii?Q?EZFVK4dBVi6+LPWdcsezOGPg77BQ78JHqtnteM5Trase9zzGNNnXvLME2A8i?=
 =?us-ascii?Q?3HkZqNdMYLSXeH9i4keKel7Za+jYUecmaL8qc08QoZ9bju2m12RisrvCa3fE?=
 =?us-ascii?Q?QOeUCqXcpApARFHR631qIrhtwdak0uIS3YbGND/5cXVIHHO0iZr0/WmA880j?=
 =?us-ascii?Q?woxG8yfEoGrrP4Nw+thNquol2aX8WFb5A3hKx2RyCOSsU1nwQzUHhMvItvoZ?=
 =?us-ascii?Q?otelTFCZytQv349sHfYwnA/Mk1AGsiM6FawCTDfCrBCDZerD99ZRqN8BKW6D?=
 =?us-ascii?Q?BQc8IPfuAjWb8BJGdNss2YPU+ucL0h9tbqoN1WWPTKosOJ3NlJXdPikI7nTJ?=
 =?us-ascii?Q?GQ/xojfEksFe/sO8NB61VmDQqpmrDWIczX17azoDaMDr1ndy4rlbOb16CFD3?=
 =?us-ascii?Q?YsxHjI60H1rrKIte+umAxTHbtzBp24qxIiGkyRW7iL+tCKmTvikfTo11IUAS?=
 =?us-ascii?Q?frkRi+coE1o9FEwOnpdkAoCaP5yHA5skZpml+q4C2vjpAs8n9zEOsZeRgUxz?=
 =?us-ascii?Q?pQG/WFOT+eWxcbGrnlvmNmrVlw813o2pZ0eeGY+54Twq9RyHH1o0UEeUSBXW?=
 =?us-ascii?Q?wvuVpzcalvebvzBoeXl4NseeQWkfq4JldedtyW0no64EthNhsv4cHYHtH6tj?=
 =?us-ascii?Q?xZEj9QXnzf8k/w6UOhsHsCJcYO1susc3G8Dn4/xJElMxvaJlp1UBUtqQc+WG?=
 =?us-ascii?Q?ACxMWsb8kw1huDbfwPbLoF8uK/8yY53A8VOG6bjEALGsMfD47tjDI9PrFD1X?=
 =?us-ascii?Q?s7OyTouGqWTvpAtjs5iyoBy6DEajGyI+9DTD0cCgFp499nAXyrbRzU/X81jO?=
 =?us-ascii?Q?vpqS8O3BBxx/D1xH7cXjqI7E5G7QWCY1O3tmUxltTE9wYxS+TOAVEQAkyw39?=
 =?us-ascii?Q?yPv/ehfGrFq4J/h2s4qI+3UD06iURzT+VTuEhcFeKPF7n+Yak/R1oOPwO0G0?=
 =?us-ascii?Q?y6d+ErTwl5dna47EiS1jJ5834Tb4fxhSV/QqeG/XGrEv3di5m1UX5VaDv0Pl?=
 =?us-ascii?Q?tblVW6D6iw1W9PaouBQlWsTl1nhEcA7RdnolC6UzRb3GkQyP5GSpNunfve12?=
 =?us-ascii?Q?3MpnbliuHkmSPyBm/fhNRGnY2e9lNr9fCcATV2PRuBvhZp1ad1NpdzAXK/Qq?=
 =?us-ascii?Q?l4GVWDE448xs8PUmFdV8zy1LKuOCKG/z+9l3C3pnk1F9MngJZSknRBEzuTJr?=
 =?us-ascii?Q?iLSEEauw2Z7UBL5OSW+nGcQOf3TyTAqdg2N0SypS4/GhaZ5LNpS2reili5nO?=
 =?us-ascii?Q?yaC45DghEado3+7hfAA1Z18VTSvXdE86p63+FAbIhrC7y4R8xyB4LwYUbYzC?=
 =?us-ascii?Q?GF35rQUiv7yrfbfEvQvdxPzjbbQRLAizG44GI77bzJwakz4TxAF7leIAFNsM?=
 =?us-ascii?Q?28k6X/InhGgkbEpYSZzB+hm3YwuyTLcPr5i0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:29:45.3468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f4b069-0e4b-406c-a052-08dde4619120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448

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

Changes in v8:
- Remove "EDAC" from macros and shortened them
- Removed redundant parentheses
- Improved the description of the @i field in union ecc_error_info
- Improved logging for memory_failure()
- Merged init_csrows() into mc_init():
- Remove AMD-specific naming for static functions
- Add MAINTAINERS file
- Register all the controllers
- Replace  AMD_ERR use the versalnet_snprintf in a function

Changes in v7:
- Update the header paths
- merge edac_cdx_pcol.h

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

 MAINTAINERS                       |    7 +
 drivers/edac/Kconfig              |   11 +
 drivers/edac/Makefile             |    1 +
 drivers/edac/versalnet_edac.c     | 1077 +++++++++++++++++++++++++++++
 include/linux/cdx/edac_cdx_pcol.h |   28 +
 5 files changed, 1124 insertions(+)
 create mode 100644 drivers/edac/versalnet_edac.c
 create mode 100644 include/linux/cdx/edac_cdx_pcol.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fa1e04e87d1d..53e2349ce577 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26564,6 +26564,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
 F:	drivers/edac/versal_edac.c
 
+XILINX VERSALNET EDAC DRIVER
+M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/memory-controllers/xlnx,versal-net-ddrmc5.yaml
+F:	drivers/edac/versalnet_edac.c
+F:	include/linux/cdx/edac_cdx_pcol.h
+
 XILINX WATCHDOG DRIVER
 M:	Srinivas Neeli <srinivas.neeli@amd.com>
 R:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
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
index 000000000000..d9d3394a03fa
--- /dev/null
+++ b/drivers/edac/versalnet_edac.c
@@ -0,0 +1,1077 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Versal NET memory controller driver
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/cdx/edac_cdx_pcol.h>
+#include <linux/edac.h>
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
+#define MC5_ERR_GRAIN			1
+#define MC_GET_DDR_CONFIG_IN_LEN	4
+
+#define MC5_MSG_SIZE			256
+
+#define MC5_IRQ_CE_MASK			GENMASK(18, 15)
+#define MC5_IRQ_UE_MASK			GENMASK(14, 11)
+
+#define MC5_RANK_1_MASK			GENMASK(11, 6)
+#define MASK_24					GENMASK(29, 24)
+#define MASK_0					GENMASK(5, 0)
+
+#define MC5_LRANK_1_MASK			GENMASK(11, 6)
+#define MC5_LRANK_2_MASK			GENMASK(17, 12)
+#define MC5_BANK1_MASK			GENMASK(11, 6)
+#define MC5_GRP_0_MASK			GENMASK(17, 12)
+#define MC5_GRP_1_MASK			GENMASK(23, 18)
+
+#define ECCR_UE_CE_ADDR_HI_ROW_MASK		GENMASK(10, 0)
+
+#define MC5_MAX_ROW_CNT			18
+#define MC5_MAX_COL_CNT			11
+#define MC5_MAX_RANK_CNT			2
+#define MC5_MAX_LRANK_CNT			4
+#define MC5_MAX_BANK_CNT			2
+#define MC5_MAX_GRP_CNT			3
+
+#define MC5_REGHI_ROW			7
+#define MC5_EACHBIT				1
+#define MC5_ERR_TYPE_CE			0
+#define MC5_ERR_TYPE_UE			1
+#define MC5_HIGH_MEM_EN			BIT(20)
+#define MC5_MEM_MASK				GENMASK(19, 0)
+#define MC5_X16_BASE				256
+#define MC5_X16_ECC				32
+#define MC5_X16_SIZE				(MC5_X16_BASE + MC5_X16_ECC)
+#define MC5_X32_SIZE				576
+#define MC5_HIMEM_BASE			(256 * SZ_1M)
+#define MC5_ILC_HIMEM_EN			BIT(28)
+#define MC5_ILC_MEM				GENMASK(27, 0)
+#define MC5_INTERLEAVE_SEL			GENMASK(3, 0)
+#define MC5_BUS_WIDTH_MASK			GENMASK(19, 18)
+#define MC5_NUM_CHANS_MASK			BIT(17)
+#define MC5_RANK_MASK			GENMASK(15, 14)
+#define MC5_DWIDTH_MASK			GENMASK(5, 4)
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
+static inline void versalnet_edac_snprintf(char *buf, size_t size, const char *msg, int err_id)
+{
+	snprintf(buf, size, "[VERSAL_EDAC_ERR_ID: %d] Error type: %s", err_id, msg);
+}
+
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
+ * @i:			Combined ECC error vector containing encoded values of burst position,
+ *			rank, bank, column, and row information.
+ *
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
+/*
+ *  * Row and column bit positions in ADEC (address decoder) registers.
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
+	char message[MC5_MSG_SIZE];
+	struct ecc_status stat;
+	u32 error_id;
+	u32 error_level;
+	u32 dwidth;
+	u32 part_len;
+	u32 regs[REG_MAX];
+	u32 adec[ADEC_MAX];
+	struct mem_ctl_info *mci[NUM_CONTROLLERS];
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
+	if (!(isr & (MC5_IRQ_UE_MASK | MC5_IRQ_CE_MASK)))
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
+	if (isr & MC5_IRQ_CE_MASK)
+		p->ceinfo[0].i = reglo | (u64)reghi << 32;
+	else if ((isr & MC5_IRQ_UE_MASK))
+		p->ueinfo[0].i = reglo | (u64)reghi << 32;
+
+	parity = error_data[ECCR0_PAR];
+	edac_dbg(2, "ERR DATA: 0x%08X%08X PARITY: 0x%08X\n",
+		 reghi, reglo, parity);
+
+	reglo = error_data[ECCR1_ADDR_LO];
+	reghi = error_data[ECCR1_ADDR_HI];
+	if (isr & MC5_IRQ_CE_MASK)
+		p->ceinfo[1].i = reglo | (u64)reghi << 32;
+	else if ((isr & MC5_IRQ_UE_MASK))
+		p->ueinfo[1].i = reglo | (u64)reghi << 32;
+
+	parity = error_data[ECCR1_PAR];
+	edac_dbg(2, "ERR DATA: 0x%08X%08X PARITY: 0x%08X\n",
+		 reghi, reglo, parity);
+
+	return true;
+}
+
+/**
+ * convert_to_physical - Convert to physical address.
+ * @priv:	DDR memory controller private instance data.
+ * @pinf:	ECC error info structure.
+ * @controller:	Controller number of the MC5
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
+	row = pinf.rowhi << MC5_REGHI_ROW | pinf.row;
+	offset = controller * ADEC_NUM;
+
+	reg = error_data[ADEC6];
+	rows.i = reg;
+	err_addr |= (row & BIT(0)) << rows.row0;
+	row >>= MC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row1;
+	row >>= MC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row2;
+	row >>= MC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row3;
+	row >>= MC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row4;
+	row >>= MC5_EACHBIT;
+
+	reg = error_data[ADEC7];
+	rows.i = reg;
+	err_addr |= (row & BIT(0)) << rows.row0;
+	row >>= MC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row1;
+	row >>= MC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row2;
+	row >>= MC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row3;
+	row >>= MC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row4;
+	row >>= MC5_EACHBIT;
+
+	reg = error_data[ADEC8];
+	rows.i = reg;
+	err_addr |= (row & BIT(0)) << rows.row0;
+	row >>= MC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row1;
+	row >>= MC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row2;
+	row >>= MC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row3;
+	row >>= MC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row4;
+
+	reg = error_data[ADEC9];
+	rows.i = reg;
+
+	err_addr |= (row & BIT(0)) << rows.row0;
+	row >>= MC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row1;
+	row >>= MC5_EACHBIT;
+	err_addr |= (row & BIT(0)) << rows.row2;
+	row >>= MC5_EACHBIT;
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
+	pinf.bank >>= MC5_EACHBIT;
+	err_addr |= (pinf.bank & BIT(0)) << FIELD_GET(MC5_BANK1_MASK, reg);
+	pinf.bank >>= MC5_EACHBIT;
+
+	err_addr |= (pinf.bank & BIT(0)) << FIELD_GET(MC5_GRP_0_MASK, reg);
+	pinf.group >>= MC5_EACHBIT;
+	err_addr |= (pinf.bank & BIT(0)) << FIELD_GET(MC5_GRP_1_MASK, reg);
+	pinf.group >>= MC5_EACHBIT;
+	err_addr |= (pinf.bank & BIT(0)) << FIELD_GET(MASK_24, reg);
+	pinf.group >>= MC5_EACHBIT;
+
+	reg = error_data[ADEC4];
+	err_addr |= (pinf.rank & BIT(0)) << (reg & MASK_0);
+	pinf.rank >>= MC5_EACHBIT;
+	err_addr |= (pinf.rank & BIT(0)) << FIELD_GET(MC5_RANK_1_MASK, reg);
+	pinf.rank >>= MC5_EACHBIT;
+
+	reg = error_data[ADEC5];
+	err_addr |= (pinf.lrank & BIT(0)) << (reg & MASK_0);
+	pinf.lrank >>= MC5_EACHBIT;
+	err_addr |= (pinf.lrank & BIT(0)) << FIELD_GET(MC5_LRANK_1_MASK, reg);
+	pinf.lrank >>= MC5_EACHBIT;
+	err_addr |= (pinf.lrank & BIT(0)) << FIELD_GET(MC5_LRANK_2_MASK, reg);
+	pinf.lrank >>= MC5_EACHBIT;
+	err_addr |= (pinf.lrank & BIT(0)) << FIELD_GET(MASK_24, reg);
+	pinf.lrank >>= MC5_EACHBIT;
+
+	high_mem_base = (priv->adec[ADEC2 + offset] & MC5_MEM_MASK) * MC5_HIMEM_BASE;
+	interleave = priv->adec[ADEC13 + offset] & MC5_INTERLEAVE_SEL;
+
+	high_mem_offset = priv->adec[ADEC3 + offset] & MC5_MEM_MASK;
+	low_mem_offset = priv->adec[ADEC1 + offset] & MC5_MEM_MASK;
+	reg = priv->adec[ADEC14 + offset];
+	ilc_himem_en = !!(reg & MC5_ILC_HIMEM_EN);
+	ilcmem_base = (reg & MC5_ILC_MEM) * SZ_1M;
+	if (ilc_himem_en)
+		ilc_base_ctrl_add = ilcmem_base - high_mem_offset;
+	else
+		ilc_base_ctrl_add = ilcmem_base - low_mem_offset;
+
+	if (priv->dwidth == DEV_X16) {
+		blk = err_addr / MC5_X16_SIZE;
+		rsh_req_addr = (blk << 8) + ilc_base_ctrl_add;
+		err_addr = rsh_req_addr * interleave * 2;
+	} else {
+		blk = err_addr / MC5_X32_SIZE;
+		rsh_req_addr = (blk << 9) + ilc_base_ctrl_add;
+		err_addr = rsh_req_addr * interleave * 2;
+	}
+
+	if ((priv->adec[ADEC2 + offset] & MC5_HIGH_MEM_EN) && err_addr >= high_mem_base)
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
+ * @controller:	Controller number of the MC5
+ * @error_data:	the MC5 ADEC address decoder register data
+ *
+ * Handles ECC correctable and uncorrectable errors.
+ */
+static void handle_error(struct mc_priv  *priv, struct ecc_status *stat,
+			 int controller, int *error_data)
+{
+	struct mem_ctl_info *mci = priv->mci[controller];
+	union ecc_error_info pinf;
+	unsigned long pa;
+	phys_addr_t pfn;
+	int err;
+
+	if (stat->error_type == MC5_ERR_TYPE_CE) {
+		pinf = stat->ceinfo[stat->channel];
+		snprintf(priv->message, MC5_MSG_SIZE,
+			 "Error type:%s Controller %d Addr at %lx\n",
+			 "CE", controller, convert_to_physical(priv, pinf, controller, error_data));
+
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+				     1, 0, 0, 0, 0, 0, -1,
+				     priv->message, "");
+	}
+
+	if (stat->error_type == MC5_ERR_TYPE_UE) {
+		pinf = stat->ueinfo[stat->channel];
+		snprintf(priv->message, MC5_MSG_SIZE,
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
+				edac_dbg(2, "memory_failure() error: %d", err);
+			else
+				edac_dbg(2, "Page at PA 0x%lx is hardware poisoned\n", pa);
+		}
+	}
+}
+
+static void mc_init(struct mem_ctl_info *mci, struct device *dev)
+{
+	struct mc_priv *priv = mci->pvt_info;
+	struct csrow_info *csi;
+	struct dimm_info *dimm;
+	u32 row;
+	int ch;
+
+	/* Initialize controller capabilities and configuration */
+	mci->mtype_cap = MEM_FLAG_DDR5;
+	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
+	mci->scrub_cap = SCRUB_HW_SRC;
+	mci->scrub_mode = SCRUB_NONE;
+
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->ctl_name = "VersalNET DDR5 controller";
+	mci->dev_name = dev_name(dev);
+	mci->mod_name = "versalnet_edac";
+
+	edac_op_state = EDAC_OPSTATE_INT;
+
+	for (row = 0; row < mci->nr_csrows; row++) {
+		csi = mci->csrows[row];
+		for (ch = 0; ch < csi->nr_channels; ch++) {
+			dimm = csi->channels[ch]->dimm;
+			dimm->edac_mode = EDAC_SECDED;
+			dimm->mtype = MEM_DDR5;
+			dimm->grain = MC5_ERR_GRAIN;
+			dimm->dtype = priv->dwidth;
+		}
+	}
+}
+
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+static unsigned int mcdi_rpc_timeout(struct cdx_mcdi *cdx, unsigned int cmd)
+{
+	return MCDI_RPC_TIMEOUT;
+}
+
+static void mcdi_request(struct cdx_mcdi *cdx,
+			 const struct cdx_dword *hdr, size_t hdr_len,
+			 const struct cdx_dword *sdu, size_t sdu_len)
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
+
+	kfree(send_buf);
+}
+
+static const struct cdx_mcdi_ops mcdi_ops = {
+	.mcdi_rpc_timeout = mcdi_rpc_timeout,
+	.mcdi_request = mcdi_request,
+};
+
+static void get_ddr_config(u32 index, u32 *buffer, struct cdx_mcdi *amd_mcdi)
+{
+	size_t outlen;
+	int ret;
+
+	MCDI_DECLARE_BUF(inbuf, MC_GET_DDR_CONFIG_IN_LEN);
+	MCDI_DECLARE_BUF(outbuf, BUFFER_SZ);
+
+	MCDI_SET_DWORD(inbuf, EDAC_GET_DDR_CONFIG_IN_CONTROLLER_INDEX, index);
+
+	ret = cdx_mcdi_rpc(amd_mcdi, MC_CMD_EDAC_GET_DDR_CONFIG, inbuf, sizeof(inbuf),
+			   outbuf, sizeof(outbuf), &outlen);
+	if (!ret)
+		memcpy(buffer, MCDI_PTR(outbuf, GET_DDR_CONFIG),
+		       (ADEC_NUM * 4));
+}
+
+static int setup_mcdi(struct mc_priv *mc_priv)
+{
+	struct cdx_mcdi *amd_mcdi;
+	int ret, i;
+
+	amd_mcdi = kzalloc(sizeof(*amd_mcdi), GFP_KERNEL);
+	if (!amd_mcdi)
+		return -ENOMEM;
+
+	amd_mcdi->mcdi_ops = &mcdi_ops;
+	ret = cdx_mcdi_init(amd_mcdi);
+	if (ret) {
+		kfree(amd_mcdi);
+		return ret;
+	}
+
+	amd_mcdi->ept = mc_priv->ept;
+	mc_priv->mcdi = amd_mcdi;
+
+	for (i = 0; i < NUM_CONTROLLERS; i++)
+		get_ddr_config(i, &mc_priv->adec[ADEC_NUM * i], amd_mcdi);
+
+	return 0;
+}
+
+static const guid_t amd_versalnet_guid = GUID_INIT(0x82678888, 0xa556, 0x44f2,
+						 0xb8, 0xb4, 0x45, 0x56, 0x2e,
+						 0x8c, 0x5b, 0xec);
+
+static int rpmsg_cb(struct rpmsg_device *rpdev, void *data,
+		    int len, void *priv, u32 src)
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
+	case 5:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"General Software Non-Correctable error",
+					error_id);
+		break;
+	case 6:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"CFU error", error_id);
+		break;
+	case 7:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"CFRAME error", error_id);
+		break;
+	case 10:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"DDRMC Microblaze Correctable ECC error", error_id);
+		break;
+	case 11:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"DDRMC Microblaze Non-Correctable ECC error",
+					error_id);
+		break;
+	case 15:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"MMCM error", error_id);
+		break;
+	case 16:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"HNICX Correctable error", error_id);
+		break;
+	case 17:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"HNICX Non-Correctable error", error_id);
+		break;
+	case 18:
+		p = &mc_priv->stat;
+		memset(p, 0, sizeof(struct ecc_status));
+		p->error_type = MC5_ERR_TYPE_CE;
+		for (i = 0 ; i < NUM_CONTROLLERS; i++) {
+			if (get_ddr_info(&mc_priv->regs[i * REGS_PER_CONTROLLER], mc_priv)) {
+				adec_data = mc_priv->adec + ADEC_NUM * i;
+				handle_error(mc_priv, &mc_priv->stat, i, adec_data);
+			}
+		}
+		return 0;
+	case 19:
+		p = &mc_priv->stat;
+		memset(p, 0, sizeof(struct ecc_status));
+		p->error_type = MC5_ERR_TYPE_UE;
+		for (i = 0 ; i < NUM_CONTROLLERS; i++) {
+			if (get_ddr_info(&mc_priv->regs[i * REGS_PER_CONTROLLER], mc_priv)) {
+				adec_data = mc_priv->adec + ADEC_NUM * i;
+				handle_error(mc_priv, &mc_priv->stat, i, adec_data);
+			}
+		}
+		return 0;
+	case 21:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"GT Non-Correctable error", error_id);
+		break;
+	case 22:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"PL Sysmon Correctable error", error_id);
+		break;
+	case 23:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"PL Sysmon Non-Correctable error", error_id);
+		break;
+	case 111:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"LPX unexpected dfx activation error", error_id);
+		break;
+	case 114:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"INT_LPD Non-Correctable error", error_id);
+		break;
+	case 116:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"INT_OCM Non-Correctable error", error_id);
+		break;
+	case 117:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"INT_FPD Correctable error", error_id);
+		break;
+	case 118:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"INT_FPD Non-Correctable error", error_id);
+		break;
+	case 120:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"INT_IOU Non-Correctable error", error_id);
+		break;
+	case 123:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"err_int_irq from APU GIC Distributor", error_id);
+		break;
+	case 124:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"fault_int_irq from APU GIC Distribute", error_id);
+		break;
+	case 132 ... 139:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"FPX SPLITTER error", error_id);
+		break;
+	case 140:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"APU Cluster 0 error", error_id);
+		break;
+	case 141:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"APU Cluster 1 error", error_id);
+		break;
+	case 142:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"APU Cluster 2 error", error_id);
+		break;
+	case 143:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"APU Cluster 3 error", error_id);
+		break;
+	case 145:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"WWDT1 LPX error", error_id);
+		break;
+	case 147:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"IPI error", error_id);
+		break;
+	case 152 ... 153:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"AFIFS error", error_id);
+		break;
+	case 154 ... 155:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"LPX glitch error", error_id);
+		break;
+	case 185 ... 186:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"FPX AFIFS error", error_id);
+		break;
+	case 195 ... 199:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"AFIFM error", error_id);
+		break;
+	case 108:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"PSM Correctable error", error_id);
+		break;
+	case 59:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"PMC correctable error", error_id);
+		break;
+	case 60:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"PMC Un correctable error", error_id);
+		break;
+	case 43 ... 47:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"PMC Sysmon error", error_id);
+		break;
+	case 163 ... 184:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"RPU error", error_id);
+		break;
+	case 148:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"OCM0 correctable error", error_id);
+		break;
+	case 149:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"OCM1 correctable error", error_id);
+		break;
+	case 150:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"OCM0 Un-correctable error", error_id);
+		break;
+	case 151:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"OCM1 Un-correctable error", error_id);
+		break;
+	case 189:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"PSX_CMN_3 PD block consolidated error", error_id);
+		break;
+	case 191:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"FPD_INT_WRAP PD block consolidated error", error_id);
+		break;
+	case 232:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"CRAM Un-Correctable error", error_id);
+		break;
+	default:
+		versalnet_edac_snprintf(mc_priv->message, MC5_MSG_SIZE,
+					"VERSAL_EDAC_ERR_ID: %d", error_id);
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
+static int rpmsg_probe(struct rpmsg_device *rpdev)
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
+	pg->ept = rpmsg_create_ept(rpdev, rpmsg_cb, NULL, chinfo);
+	if (!pg->ept)
+		return dev_err_probe(&rpdev->dev, -ENXIO,
+			      "Failed to create ept for channel %s\n",
+			      chinfo.name);
+
+	dev_set_drvdata(&rpdev->dev, pg);
+	return 0;
+}
+
+static void rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct mc_priv *mc_priv = dev_get_drvdata(&rpdev->dev);
+
+	rpmsg_destroy_ept(mc_priv->ept);
+	dev_set_drvdata(&rpdev->dev, NULL);
+}
+
+static struct rpmsg_driver amd_rpmsg_driver = {
+	.drv.name = KBUILD_MODNAME,
+	.probe = rpmsg_probe,
+	.remove = rpmsg_remove,
+	.callback = rpmsg_cb,
+	.id_table = amd_rpmsg_id_table,
+};
+
+static void versal_edac_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
+{
+	u32 num_chans, rank, dwidth, config;
+	struct mem_ctl_info *mci = NULL;
+	struct edac_mc_layer layers[2];
+	struct device *dev;
+	enum dev_type dt;
+	char *name;
+	int rc, i;
+
+	for (i = 0; i < NUM_CONTROLLERS; i++) {
+		config = priv->adec[CONF + i * ADEC_NUM];
+		num_chans = FIELD_GET(MC5_NUM_CHANS_MASK, config);
+		rank = 1 << FIELD_GET(MC5_RANK_MASK, config);
+		dwidth = FIELD_GET(MC5_BUS_WIDTH_MASK, config);
+
+		switch (dwidth) {
+		case XDDR5_BUS_WIDTH_16:
+			dt = DEV_X16;
+			break;
+		case XDDR5_BUS_WIDTH_32:
+			dt = DEV_X32;
+			break;
+		case XDDR5_BUS_WIDTH_64:
+			dt = DEV_X64;
+			break;
+		default:
+			dt = DEV_UNKNOWN;
+		}
+
+		if (dt == DEV_UNKNOWN)
+			continue;
+
+		/* Find the first enabled device and register that one. */
+		layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+		layers[0].size = rank;
+		layers[0].is_virt_csrow = true;
+		layers[1].type = EDAC_MC_LAYER_CHANNEL;
+		layers[1].size = num_chans;
+		layers[1].is_virt_csrow = false;
+
+		mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers,
+				    sizeof(struct mc_priv));
+		if (!mci) {
+			edac_printk(KERN_ERR, EDAC_MC,
+				    "Failed memory allocation for mc instance\n");
+			return -ENOMEM;
+		}
+
+		priv->mci[i] = mci;
+		priv->dwidth = dt;
+
+		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+		dev->release = versal_edac_release;
+		name = kmalloc(32, GFP_KERNEL);
+		sprintf(name, "versal-net-ddrmc5-edac-%d", i);
+		dev->init_name = name;
+		rc = device_register(dev);
+		if (rc) {
+			put_device(dev);
+			return rc;
+		}
+		mci->pdev = dev;
+
+		platform_set_drvdata(pdev, priv);
+
+		mc_init(mci, dev);
+		rc = edac_mc_add_mc(mci);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_MC,
+				    "Failed to register with EDAC core\n");
+			edac_mc_free(mci);
+			return rc;
+		}
+	}
+	return 0;
+}
+
+static void remove_versalnet(struct mc_priv *priv)
+{
+	struct mem_ctl_info *mci;
+	int i;
+
+	for (i = 0; i < NUM_CONTROLLERS; i++) {
+		device_unregister(priv->mci[i]->pdev);
+		mci = edac_mc_del_mc(priv->mci[i]->pdev);
+		if (!mci)
+			return;
+
+		edac_mc_free(mci);
+	}
+}
+
+static int mc_probe(struct platform_device *pdev)
+{
+	struct device_node *r5_core_node;
+	struct mc_priv *priv;
+	struct rproc *rp;
+	int rc;
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
+	rc = setup_mcdi(priv);
+	if (rc)
+		goto free_rpmsg;
+
+	priv->mcdi->r5_rproc = rp;
+	rc = init_versalnet(priv, pdev);
+	if (rc)
+		goto free_rpmsg;
+
+	return 0;
+
+free_rpmsg:
+	kfree(priv->mcdi);
+	unregister_rpmsg_driver(&amd_rpmsg_driver);
+free_rproc:
+	rproc_shutdown(rp);
+	return rc;
+}
+
+static void mc_remove(struct platform_device *pdev)
+{
+	struct mc_priv *priv = platform_get_drvdata(pdev);
+
+	unregister_rpmsg_driver(&amd_rpmsg_driver);
+	remove_versalnet(priv);
+	kfree(priv->mcdi);
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
+		.name = "versal-net-edac",
+		.of_match_table = amd_edac_match,
+	},
+	.probe = mc_probe,
+	.remove = mc_remove,
+};
+
+module_platform_driver(amd_ddr_edac_mc_driver);
+
+MODULE_AUTHOR("AMD Inc");
+MODULE_DESCRIPTION("Versal NET EDAC driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/cdx/edac_cdx_pcol.h b/include/linux/cdx/edac_cdx_pcol.h
new file mode 100644
index 000000000000..749db33bb482
--- /dev/null
+++ b/include/linux/cdx/edac_cdx_pcol.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Driver for AMD network controllers and boards
+ *
+ * Copyright (C) 2021, Xilinx, Inc.
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#ifndef MC_CDX_PCOL_H
+#define MC_CDX_PCOL_H
+#include  <linux/cdx/mcdi.h>
+
+#define MC_CMD_EDAC_GET_DDR_CONFIG_OUT_WORD_LENGTH_LEN		4
+/* Number of registers for the DDR controller */
+#define MC_CMD_GET_DDR_CONFIG_OFST	4
+#define MC_CMD_GET_DDR_CONFIG_LEN	4
+
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
+#endif /* MC_CDX_PCOL_H */
-- 
2.34.1


