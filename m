Return-Path: <linux-edac+bounces-2603-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234AA9D5CED
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 11:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756071F22CA7
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 10:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D291DED75;
	Fri, 22 Nov 2024 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sr+4FCrE"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9081DE8B4;
	Fri, 22 Nov 2024 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270016; cv=fail; b=rxj1LrK0okz3pZNtpCkFltpFaz6e1EZaCrxG2MXkUYwi/Njsknd52G+7JngtGvsrXr4gHKaaLwPIj42aFg4J3zSA5VovVDajix3sTKFc/g2bq6xZeAHM4IhNhm5HdumVeTmasxydWHPkEDk63qCTLX9BMfhfKBdB5/YQYyEgIoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270016; c=relaxed/simple;
	bh=PPa9AAr3jWalMNLezggMdIkYB6JcU+seMY6Eh8XIPXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiRNfh0SW2JD3eu9nueMdSNLIF5Pq4jdo2bA2KSMM9v3EpnJ5ziXVPH3G6crfN4U/SPtf/QKCQqoHG0snNbsK8AbAmZ2Y9592viP2e7Q5z49fo5HJeyNOZu7hYKqs0KKa6B9Cgg4ZFCGJCfDFcPvb3gsHUSz8zjZRRn5MQYdJtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sr+4FCrE; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpARfg+sjsvrf4QzEL2pd6Fe08lkI2tokEI80znr+tw+Ivdw4jlGN/glMJRBLXdRhEHbS1UKer/T1oCpnE5BOf2lXsP2lvy4gdRS3en5JPs50UXShtqoGBXSN+XJUuq+q0uyRi+r9QyNn5O2++7vQnig6W1fo3N0UDjbbVsceHbIJ6SWFCEinq8asjBpppv/mqwZGVBxlSeEntb5V9M789ZI2r9tQB62Rki1k0dhJtVIii+3xkDpzVYc0GnjtG6Vgcm/zbkPlR1UFpAipQmgFmI8bp4r5hOvLCcmu0nB08xC0uI1MH1YJs19/a2YhN7NQGFtKjmpGym/e7glTYf1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlVKPaOYLZDPmdjhb9nWGTEMxETSb9v3a7EtjLXrDmg=;
 b=pMHloKCwWnuccTyHWAxa45qb1dCROmtrrzuXSD+aA/5dFLYU5XpOU8yaS4+C/EhdEXs1XpDDlVvZyFgrItQYYe1uIJURu9ZDe6iRuW8uRONlAmNb4u3de0w5u6R+G3gbhZwARN/OnD+i7lh4Og/P4tdVrv0Yk+XgETZKhiyMVOCPgeZoiQshjTHZteRh90kQyBsmH/gT3WocFlE7KDR8oCAGGZRhauMPEog23XUZc6rQY0W/gVNm8JT5Wor89ZL737zJMGRzpxfT0zMQcPMLhnTMtPGi60Wwtqq1QbaVNLd7QRtDxiaZKAx36Ht528NxdsQ2m3vJvXMtapWVaftUyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlVKPaOYLZDPmdjhb9nWGTEMxETSb9v3a7EtjLXrDmg=;
 b=Sr+4FCrEVRgEeEkh9Hb/KfvVjipm+iSMMTyG/qXdhLJEDaUiuhvufdOEYeXlxF2kcnixYaB4QEiAenH7tuN9p2WlIQrcD5BJlqLQWybTx77yJ5fHM6Tf0DsH0I1FDcVyNR7AtqgAaLy1oifELNjLU5t/F0OKi6YDxHMtmHgwzko=
Received: from BYAPR03CA0008.namprd03.prod.outlook.com (2603:10b6:a02:a8::21)
 by SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 10:06:48 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::a2) by BYAPR03CA0008.outlook.office365.com
 (2603:10b6:a02:a8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Fri, 22 Nov 2024 10:06:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 10:06:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 04:06:46 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 04:06:45 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 22 Nov 2024 04:06:42 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <krzk@kernel.or>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
Subject: [PATCH 3/3] EDAC: Versal NET: Add support for error notification
Date: Fri, 22 Nov 2024 15:36:25 +0530
Message-ID: <20241122100625.24571-4-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241122100625.24571-1-shubhrajyoti.datta@amd.com>
References: <20241122100625.24571-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SN7PR12MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff21657-796c-4510-11c6-08dd0add606f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TOHg/0Awf9M1z4cRdRZwJoKF517puiy1IlVcLwXtGOKfS/MtGfMw2ozrKN5P?=
 =?us-ascii?Q?wcE2jlqqx8h7CsLAzpF92JW2jTJVYMa85vPiMCEpVNUcK/3zPsqNuunK+Xa3?=
 =?us-ascii?Q?wfp/N2W6IyHbRCu7iM3CGhq+tbSDi4B7MwZ7+DfMXZuPmiuI3R0Tb6aHPquc?=
 =?us-ascii?Q?c2WgSSn/HFFK0MtedfUXu3guJvsS5tqYtRkVnr7HJZUGF1tmof+C6M6eKA4A?=
 =?us-ascii?Q?e6nObLd0sH0GL/PRFkZfcZtVuKhYSlDswlwDVRE1x+6zhmZBeYdhcrrasoIw?=
 =?us-ascii?Q?7QBeJXLZADXv0/RYHcZ4tv0DsfngC0r6Xk9GVAbQUzfjpaxIhlou8+D1Z7dz?=
 =?us-ascii?Q?2ZzkAKbwqqNeQTFlZK5MdOvt/gAMJ3a6I0VKTQ1Rn0eaMspt9kvrQkame+gQ?=
 =?us-ascii?Q?DIch0WbfiN/uVZ9wxqwc/abBILB03RNvGeP324+80gYCprFWAc9qSpfCBOqd?=
 =?us-ascii?Q?Ri9+aT69MB30aSKkGNTMdWFg8MrEZFW7ETZKtgStKx+dDqP7k2USeufxG8IU?=
 =?us-ascii?Q?H6SYki0rDE+y2+i1h6zbrBQQXZQanDuLxdCOfURInF6JVK8b8iU7r2tFJvdQ?=
 =?us-ascii?Q?7MSPwHmpOgUL3/+KPVo1rPhlFKJcdMJ+OoHIRfAlDBdMw9+LMwsFlz71R2UY?=
 =?us-ascii?Q?YJjP1PLXpsQboOOTumYLXu0EGf6uZ3hI0Sk9XN8vInRKmSBx7GRhvMZrxPGn?=
 =?us-ascii?Q?RPYiyqPTEf8ngpGkFdFWdZaGYiXHPO/i1rS+jzWKrs1Llx2uq1iHAMdcgZn5?=
 =?us-ascii?Q?D7aw34tMk89dZXEVO3f9Y/tCaDu7c2Y09LYvlD8H2lE972BYymRC4fM9uKzR?=
 =?us-ascii?Q?fpC6Wxgfc0Lm7Wh/FJuXIdwdP1KgNxRINcNvMo2kPItnL5YVuny5FhDtUBA5?=
 =?us-ascii?Q?7sNvyp6uRk9Fi87QG3cpWZ59STE8EYIEesegImkBsqw/rn05+v99jNZ6nGCX?=
 =?us-ascii?Q?L9YIApG1P+/eK2n/0+kY/MQROTtdcHLDMWJOahRzH/XG84xZPiKIIXDu42v+?=
 =?us-ascii?Q?m3bYtpN28yODF0E88dnqxvLQ7lP1blw0dnMVIMPLyCE0LR6gqWx2v7zyLbZ0?=
 =?us-ascii?Q?36/s9sRUO+UcnXBgUaMSr1VkrwCUQl3gpVNauv38k7ZAePSS96PNG6hfhdBN?=
 =?us-ascii?Q?Yz89hyUEG6xIYME/bfcDTsMDCtdg+Ds7jJEZIXpNNnOuN6BimOfgtUSKg8F8?=
 =?us-ascii?Q?iNF0Jyc+sDXiTDC2TLwNR6f3b3LQdncl5eGMTjZNWOfszYtpO0AnUF7MwVKg?=
 =?us-ascii?Q?4qq/aIi8603M+JReGTiSw7Xw4TTFYmJukELd4S8gqETwfVYxaRsRwq1itkFI?=
 =?us-ascii?Q?VCfy7B0MmAeofdUEQyGxjiFPrE6K8TfV5QifaS4t9iI1DECfcrgtiJZyJdcK?=
 =?us-ascii?Q?+Qs+VVrfcc2t14mCB0akaVuQUQvLdW8KABVC7ktbnHnDaNn6Qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 10:06:47.6701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff21657-796c-4510-11c6-08dd0add606f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204

The Versal NET edac listens to the notifications from NMC(Network
management controller) on rpmsg. The driver registers on the error_edac
channel. Send a RAS event trace upon a notification. On reading
the notification the user space application can decide on the response.
A sysfs reset entry is created for the same that sends an acknowledgment
back to the NMC. For reporting events register to the RAS framework. For
memory mc events are used other events use non-standard events.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 .../ABI/testing/sysfs-driver-versalnet-edac   |   11 +
 drivers/edac/Kconfig                          |    9 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/versalnet_rpmsg_edac.c           | 1321 +++++++++++++++++
 4 files changed, 1342 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-versalnet-edac
 create mode 100644 drivers/edac/versalnet_rpmsg_edac.c

diff --git a/Documentation/ABI/testing/sysfs-driver-versalnet-edac b/Documentation/ABI/testing/sysfs-driver-versalnet-edac
new file mode 100644
index 000000000000..598a6c6cef39
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-versalnet-edac
@@ -0,0 +1,11 @@
+What:		/sys/devices/system/edac/.../reset
+Date:		Nov 2024
+Contact:	shubhrajyoti.datta@amd.com
+Description:
+		Writing 1/2 to this file will send a reset request to the NMC (Network
+		Management Controller). 1 will request a SRST (Soft reset) and 2 will
+		request a POR ( Power-On Reset).
+
+		For example::
+
+		  # echo 1 > /sys/devices/system/edac/.../reset
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 81af6c344d6b..c3e0644aed0d 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -564,5 +564,14 @@ config EDAC_VERSAL
 	  Support injecting both correctable and uncorrectable errors
 	  for debugging purposes.
 
+config EDAC_VERSALNET
+	tristate "AMD Versal NET EDAC"
+	depends on CDX_CONTROLLER
+	help
+	  Support for error detection and correction on the AMD Versal NET DDR
+	  memory controller.
+
+	  The memory controller supports single bit error correction, double bit
+	  error detection. Report various errors to the userspace.
 
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index faf310eec4a6..7b1a8525c021 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
 obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
 obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
 obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
+obj-$(CONFIG_EDAC_VERSALNET)		+= versalnet_rpmsg_edac.o
diff --git a/drivers/edac/versalnet_rpmsg_edac.c b/drivers/edac/versalnet_rpmsg_edac.c
new file mode 100644
index 000000000000..75d34da1db76
--- /dev/null
+++ b/drivers/edac/versalnet_rpmsg_edac.c
@@ -0,0 +1,1321 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Versal NET memory controller driver
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/edac.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/ras.h>
+#include <linux/rpmsg.h>
+#include <linux/sizes.h>
+#include <ras/ras_event.h>
+
+#include "edac_module.h"
+#include "../cdx/cdx.h"
+#include "../cdx/controller/mcdi_functions.h"
+#include "../cdx/controller/mcdi.h"
+#include "../cdx/controller/mc_cdx_pcol.h"
+
+static DEFINE_MUTEX(vnet_edac_lock);
+
+/* Granularity of reported error in bytes */
+#define DDRMC5_EDAC_ERR_GRAIN			1
+#define MC_CMD_EDAC_GET_DDR_CONFIG_IN_LEN	4 /* 4 bytes */
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
+union edac_info {
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
+ * struct ack - Acknowledgment information to report.
+ * @error_level:	Error level.
+ * @error_id:		Error id ectable error log information.
+ * @next_action:	Next action to be taken.
+ */
+struct ack {
+	u32 error_level;
+	u32 error_id;
+	u32 next_action;
+};
+
+/**
+ * struct ecc_status - ECC status information to report.
+ * @ceinfo:	Correctable error log information.
+ * @ueinfo:	Uncorrectable error log information.
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
+ * struct edac_priv - DDR memory controller private instance data.
+ * @message:		Buffer for framing the event specific info.
+ * @ce_cnt:		Correctable error count.
+ * @ue_cnt:		UnCorrectable error count.
+ * @stat:		ECC status information.
+ * @lrank_bit:		Bit shifts for lrank bit.
+ * @rank_bit:		Bit shifts for rank bit.
+ * @row_bit:		Bit shifts for row bit.
+ * @col_bit:		Bit shifts for column bit.
+ * @bank_bit:		Bit shifts for bank bit.
+ * @grp_bit:		Bit shifts for group bit.
+ * @error_id:		The error id.
+ * @error_level:	The error level.
+ * @dwidth:		The dwidth.
+ * @part_len:		The subpart of the message received.
+ * @regs:		The registers sent on the rpmsg.
+ * @dwidth:		The dwidth.
+ * @adec:		Address decode registers.
+ * @ept:		rpmsg endpoint.
+ * @ept:		rpmsg endpoint.
+ * @mcdi:		The mcdi handle.
+ * @work:		The work queue.
+ */
+struct edac_priv {
+	char message[DDRMC5_EDAC_MSG_SIZE];
+	u32 ce_cnt;
+	u32 ue_cnt;
+	struct ecc_status stat;
+	u32 lrank_bit[4];
+	u32 col_bit[11];
+	u32 grp_bit[3];
+	u32 row_bit[18];
+	u32 rank_bit[2];
+	u32 bank_bit[2];
+	u32 error_id;
+	u32 error_level;
+	u32 dwidth;
+	u32 part_len;
+	u32 regs[REG_MAX];
+	struct rpmsg_endpoint *ept;
+	struct cdx_mcdi *mcdi;
+	struct work_struct work;
+	u32 adec[ADEC_MAX];
+};
+
+enum error_ids {
+	BOOT_CR = 0,
+	BOOT_NCR = 1,
+	FW_CR = 2,
+	FW_NCR = 3,
+	GSW_CR = 4,
+	GSW_NCR = 5,
+	CFU = 6,
+	CFRAME = 7,
+	PSM_CR = 8,
+	PSM_NCR = 9,
+	DDRMC5_MB_CR = 10,
+	DDRMC5_MB_NCR = 11,
+	NOCTYPE_CR = 12,
+	NOCTYPE_NCR = 13,
+	NOCUSER = 14,
+	MMCM = 15,
+	HNICX_CR = 16,
+	HNICX_NCR = 17,
+	DDRMC5_CR = 18,
+	DDRMC5_NCR = 19,
+	GT_CR = 20,
+	GT_NCR = 21,
+	PLSYSMON_CR = 22,
+	PLSYSMON_NCR = 23,
+	PL0 = 24,
+	PL1 = 25,
+	PL2 = 26,
+	PL3 = 27,
+	NPI_ROOT = 28,
+	SSIT_ERR3 = 29,
+	SSIT_ERR4 = 30,
+	SSIT_ERR5 = 31,
+	PMC_APB = 32,
+	PMC_ROM = 33,
+	MB_FATAL0 = 34,
+	MB_FATAL1 = 35,
+	PMC_CR = 36,
+	PMC_NCR = 37,
+	PMC_SMON0 = 39,
+	PMC_SMON1 = 40,
+	PMC_SMON2 = 41,
+	PMC_SMON3 = 42,
+	PMC_SMON4 = 43,
+	PMC_SMON8 = 47,
+	PMC_SMON9 = 48,
+	CFI = 49,
+	CFRAME_SEU_CRC = 50,
+	CFRAME_SEU_ECC = 51,
+	PMX_WWDT = 52,
+	RTC_ALARM = 54,
+	NPLL = 55,
+	PPLL = 56,
+	CLK_MON = 57,
+	INT_PMX_CORR_ERR = 59,
+	INT_PMX_UNCORR_ERR = 60,
+	SSIT_ERR0 = 61,
+	SSIT_ERR1 = 62,
+	SSIT_ERR2 = 63,
+	IOU_CR = 64,
+	IOU_NCR = 65,
+	DFX_UXPT_ACT = 66,
+	DICE_CDI_PAR = 67,
+	DEVIK_PRIV = 68,
+	NXTSW_CDI_PAR = 69,
+	DEVAK_PRIV = 70,
+	DME_PUB_X = 71,
+	DME_PUB_Y = 72,
+	DEVAK_PUB_X = 73,
+	DEVAK_PUB_Y = 74,
+	DEVIK_PUB_X = 75,
+	DEVIK_PUB_Y = 76,
+	PCR_PAR = 77,
+	PS_SW_CR = 96,
+	PS_SW_NCR = 97,
+	PSM_B_CR = 98,
+	PSM_B_NCR = 99,
+	MB_FATAL = 100,
+	PSMX_CHK = 103,
+	APLL1_LOCK = 104,
+	APLL2_LOCK = 105,
+	RPLL_LOCK = 106,
+	FLXPLL_LOCK = 107,
+	INT_PSM_CR = 108,
+	INT_PSM_NCR = 109,
+	USB_ERR = 110,
+	LPX_DFX = 111,
+	INT_LPD_CR = 113,
+	INT_LPD_NCR = 114,
+	INT_OCM_CR = 115,
+	INT_OCM_NCR = 116,
+	INT_FPD_CR = 117,
+	INT_FPD_NCR = 118,
+	INT_IOU_CR = 119,
+	INT_IOU_NCR = 120,
+	RPU_CLUSTERA_LS = 121,
+	RPU_CLUSTERB_LS = 122,
+	GIC_AXI = 123,
+	GIC_ECC = 124,
+	CPM_CR = 125,
+	CPM_NCR = 126,
+	FPD_CPI = 127,
+	FPD_SWDT0 = 128,
+	FPD_SWDT1 = 129,
+	FPD_SWDT2 = 130,
+	FPD_SWDT3 = 131,
+	FPX_SPLITTER0_MEM_ERR = 132,
+	FPX_SPLITTER0_AXI_ERR = 133,
+	FPX_SPLITTER1_MEM_ERR = 134,
+	FPX_SPLITTER1_AXI_ERR = 135,
+	FPX_SPLITTER2_MEM_ERR = 136,
+	FPX_SPLITTER2_AXI_ERR = 137,
+	FPX_SPLITTER3_MEM_ERR = 138,
+	FPX_SPLITTER3_AXI_ERR = 139,
+	APU0 = 140,
+	APU1 = 141,
+	APU2 = 142,
+	APU3 = 143,
+	LPX_WWDT0 = 144,
+	LPX_WWDT1 = 145,
+	ADMA_LS_ERR = 146,
+	IPI_ERR = 147,
+	OCM0_CORR_ERR = 148,
+	OCM1_CORR_ERR = 149,
+	OCM0_UNCORR_ERR = 150,
+	OCM1_UNCORR_ERR = 151,
+	LPX_AFIFS_CORR_ERR = 152,
+	LPX_AFIFS_UNCORR_ERR = 153,
+	LPX_GLITCH_DET0 = 154,
+	LPX_GLITCH_DET1 = 155,
+	NOC_NMU_FIREWALL_WR_ERR = 156,
+	NOC_NMU_FIREWALL_RD_ERR = 157,
+	NOC_NSU_FIREWALL_ERR = 158,
+	RPUA0_CORR_ERR = 163,
+	RPUA0_MISC1 = 166,
+	RPUA0_MISC2 = 167,
+	RPUA1_CORR_ERR = 168,
+	RPUA1_FATAL_ERR = 169,
+	RPUA1_TIMEOUT_ERR = 170,
+	RPUA1_MISC1 = 171,
+	RPUA1_MISC2 = 172,
+	RPUB0_CORR_ERR = 173,
+	RPUB0_FATAL_ERR = 174,
+	RPUB0_TIMEOUT_ERR = 175,
+	RPUB0_MISC1 = 176,
+	RPUB0_MISC2 = 177,
+	RPUB1_CORR_ERR = 178,
+	RPUB1_FATAL_ERR = 179,
+	RPUB1_TIMEOUT_ERR = 180,
+	RPUB1_MISC1 = 181,
+	RPUB1_MISC2 = 182,
+	RPU_PCIL_ERR = 184,
+	FPX_AFIFS_CORR_ERR = 185,
+	FPX_AFIFS_UNCORR_ERR = 186,
+	FPD_CMN_1_ERR = 187,
+	FPD_CMN_2_ERR = 188,
+	FPD_CMN_3_ERR = 189,
+	FPD_CML_ERR = 190,
+	FPD_INTWRAP_ERR = 191,
+	FPD_REST_MON_ERR = 192,
+	LPD_MON_ERR = 193,
+	AFIFM_FATAL_ERR = 194,
+	LPX_AFIFM_NONFATAL_ERR = 195,
+	FPX_AFIFM0_NONFATAL_ERR = 196,
+	FPX_AFIFM1_NONFATAL_ERR = 197,
+	FPX_AFIFM2_NONFATAL_ERR = 198,
+	FPX_AFIFM3_NONFATAL_ERR = 199,
+	RPU_CLUSTERA_ERR = 200,
+	RPU_CLUSTERB_ERR = 201,
+	HB_MON_0 = 224,
+	HB_MON_1 = 225,
+	HB_MON_2 = 226,
+	HB_MON_3 = 227,
+	PLM_EXCEPTION = 228,
+	PCR_LOG_UPDATE = 230,
+	ERROR_CRAM_CE = 231,
+	ERROR_CRAM_UE = 232,
+	ERROR_NPI_UE = 233,
+};
+
+/* The driver should have only one instance */
+static int probe_once;
+
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
+static void get_ddr_ce_error_info(u32 *error_data, struct edac_priv *priv)
+{
+	struct ecc_status *p;
+	u32 regval, par, reghi;
+
+	p = &priv->stat;
+
+	regval = error_data[ECCR0_ADDR_HI];
+	reghi = regval & ECCR_UE_CE_ADDR_HI_ROW_MASK;
+	regval = error_data[ECCR0_ADDR_LO];
+	p->ceinfo[0].i = regval | (u64)reghi << 32;
+
+	par = error_data[ECCR0_PAR];
+	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",
+		 reghi, regval, par);
+
+	regval = error_data[ECCR1_ADDR_LO];
+	reghi = error_data[ECCR1_ADDR_HI];
+	p->ceinfo[1].i = regval | (u64)reghi << 32;
+
+	par = error_data[ECCR1_PAR];
+	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",
+		 reghi, regval, par);
+}
+
+static void get_ddr_ue_error_info(u32 error_data[REGS_PER_CONTROLLER], struct edac_priv *priv)
+{
+	struct ecc_status *p;
+	u32 regval, par, reghi;
+
+	p = &priv->stat;
+
+	regval = error_data[ECCR0_ADDR_LO];
+	reghi = error_data[ECCR0_ADDR_HI];
+	par = error_data[ECCR0_PAR];
+
+	p->ueinfo[0].i = regval | (u64)reghi << 32;
+
+	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",
+		 reghi, regval, par);
+
+	regval = error_data[ECCR1_ADDR_LO];
+	reghi = error_data[ECCR1_ADDR_HI];
+	p->ueinfo[1].i = regval | (u64)reghi << 32;
+	par = error_data[ECCR1_PAR];
+
+	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",
+		 reghi, regval, par);
+}
+
+static bool get_ddr_ue_info(u32 error_data[REGS_PER_CONTROLLER], struct edac_priv *priv)
+{
+	u32 eccr0_val, eccr1_val, isr;
+	struct ecc_status *p;
+
+	p = &priv->stat;
+
+	isr = error_data[ISR];
+	if (!(isr & DDRMC5_IRQ_UE_MASK))
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
+	get_ddr_ue_error_info(error_data, priv);
+
+	return true;
+}
+
+static bool get_ddr_ce_info(u32 error_data[REGS_PER_CONTROLLER], struct edac_priv *priv)
+{
+	u32 eccr0_val, eccr1_val, isr;
+	struct ecc_status *p;
+
+	p = &priv->stat;
+
+	isr = error_data[ISR];
+	if (!(isr & DDRMC5_IRQ_CE_MASK))
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
+	get_ddr_ce_error_info(error_data, priv);
+
+	return true;
+}
+
+/**
+ * convert_to_physical - Convert to physical address.
+ * @priv:	DDR memory controller private instance data.
+ * @pinf:	ECC error info structure.
+ * @controller:	Controller number of the DDRMC5
+ *
+ * Return: Physical address of the DDR memory.
+ */
+static unsigned long convert_to_physical(struct edac_priv *priv,
+					 union ecc_error_info pinf,
+					 int controller)
+{
+	u32 index, row, blk, rsh_req_addr, interleave, ilc_base_ctrl_add, ilc_himem_en, reg, offset;
+	u64 high_mem_base, high_mem_offset, low_mem_offset, ilcmem_base;
+	unsigned long err_addr = 0, addr;
+
+	row = pinf.rowhi << DDRMC5_REGHI_ROW | pinf.row;
+	offset = controller * ADEC_NUM;
+
+	for (index = 0; index < DDRMC5_MAX_ROW_CNT; index++) {
+		err_addr |= (row & BIT(0)) << priv->row_bit[index];
+		row >>= DDRMC5_EACHBIT;
+	}
+
+	for (index = 0; index < DDRMC5_MAX_COL_CNT; index++) {
+		err_addr |= (pinf.col & BIT(0)) << priv->col_bit[index];
+		pinf.col >>= DDRMC5_EACHBIT;
+	}
+
+	for (index = 0; index < DDRMC5_MAX_BANK_CNT; index++) {
+		err_addr |= (pinf.bank & BIT(0)) << priv->bank_bit[index];
+		pinf.bank >>= DDRMC5_EACHBIT;
+	}
+
+	for (index = 0; index < DDRMC5_MAX_GRP_CNT; index++) {
+		err_addr |= (pinf.group & BIT(0)) << priv->grp_bit[index];
+		pinf.group >>= DDRMC5_EACHBIT;
+	}
+
+	for (index = 0; index < DDRMC5_MAX_RANK_CNT; index++) {
+		err_addr |= (pinf.rank & BIT(0)) << priv->rank_bit[index];
+		pinf.rank >>= DDRMC5_EACHBIT;
+	}
+
+	for (index = 0; index < DDRMC5_MAX_LRANK_CNT; index++) {
+		err_addr |= (pinf.lrank & BIT(0)) << priv->lrank_bit[index];
+		pinf.lrank >>= DDRMC5_EACHBIT;
+	}
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
+	if (priv->dwidth == 16) {
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
+ * @mci:	EDAC memory controller instance.
+ * @stat:	ECC status structure.
+ * @controller:	Controller number of the DDRMC5
+ *
+ * Handles ECC correctable and uncorrectable errors.
+ */
+static void handle_error(struct mem_ctl_info *mci, struct ecc_status *stat, int controller)
+{
+	struct edac_priv *priv = mci->pvt_info;
+	union ecc_error_info pinf;
+	unsigned long pa;
+	phys_addr_t pfn;
+	int err;
+
+	if (stat->error_type == DDRMC5_ERR_TYPE_CE) {
+		priv->ce_cnt++;
+		pinf = stat->ceinfo[stat->channel];
+		snprintf(priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type:%s Addr at %lx\n",
+			 "CE", convert_to_physical(priv, pinf, controller));
+
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+				     1, 0, 0, 0, 0, 0, -1,
+				     priv->message, "");
+	}
+
+	if (stat->error_type == DDRMC5_ERR_TYPE_UE) {
+		priv->ue_cnt++;
+		pinf = stat->ueinfo[stat->channel];
+		snprintf(priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type:%s Addr at %lx\n",
+			 "UE", convert_to_physical(priv, pinf, controller));
+
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+				     1, 0, 0, 0, 0, 0, -1,
+				     priv->message, "");
+		pa = convert_to_physical(priv, pinf, controller);
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
+
+	memset(stat, 0, sizeof(*stat));
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
+	struct edac_priv *priv = mci->pvt_info;
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
+			dimm->mtype = MEM_DDR4;
+			dimm->grain = DDRMC5_EDAC_ERR_GRAIN;
+			dimm->dtype = priv->dwidth;
+		}
+	}
+}
+
+/**
+ * mc_init - Initialize one driver instance.
+ * @mci:	EDAC memory controller instance.
+ * @pdev:	platform device.
+ *
+ * Perform initialization of the EDAC memory controller instance and
+ * related driver-private data associated with the memory controller the
+ * instance is bound to.
+ */
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
+	mci->mod_name = "amd_edac";
+
+	edac_op_state = EDAC_OPSTATE_INT;
+
+	init_csrows(mci);
+}
+
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+static int amd_rpmsg_send(struct cdx_mcdi *cdx_mcdi,
+			  const struct cdx_dword *hdr, size_t hdr_len,
+			  const struct cdx_dword *sdu, size_t sdu_len)
+{
+	unsigned char *send_buf;
+	int ret;
+
+	send_buf = kzalloc(hdr_len + sdu_len, GFP_KERNEL);
+	if (!send_buf)
+		return -ENOMEM;
+
+	memcpy(send_buf, hdr, hdr_len);
+	memcpy(send_buf + hdr_len, sdu, sdu_len);
+
+	ret = rpmsg_send(cdx_mcdi->ept, send_buf, hdr_len + sdu_len);
+	kfree(send_buf);
+	return ret;
+}
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
+	if (amd_rpmsg_send(cdx, hdr, hdr_len, sdu, sdu_len))
+		dev_err(&cdx->rpdev->dev, "Failed to send rpmsg data\n");
+}
+
+static const struct cdx_mcdi_ops mcdi_ops = {
+	.mcdi_rpc_timeout = amd_mcdi_rpc_timeout,
+	.mcdi_request = amd_mcdi_request,
+};
+
+static int get_ddr_config(u32 index, u32 *buffer, struct cdx_mcdi *amd_mcdi)
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
+	if (ret)
+		return ret;
+	memcpy(buffer, MCDI_PTR(outbuf, EDAC_GET_DDR_CONFIG_OUT_REGISTER_VALUES), (ADEC_NUM * 4));
+	return 0;
+}
+
+static int amd_setup_mcdi(struct edac_priv *edac_priv)
+{
+	struct cdx_mcdi *amd_mcdi;
+	int ret, i;
+
+	amd_mcdi = kzalloc(sizeof(*amd_mcdi), GFP_KERNEL);
+	if (!amd_mcdi)
+		return -ENOMEM;
+
+	/* Store the MCDI ops */
+	amd_mcdi->mcdi_ops = &mcdi_ops;
+	/* MCDI FW: Initialize the FW path */
+	ret = cdx_mcdi_init(amd_mcdi);
+	if (ret)
+		return ret;
+
+	amd_mcdi->ept = edac_priv->ept;
+	edac_priv->mcdi = amd_mcdi;
+
+	for (i = 0; i < NUM_CONTROLLERS; i++)
+		get_ddr_config(i, &edac_priv->adec[ADEC_NUM * i], amd_mcdi);
+
+	return 0;
+}
+
+static inline void process_bit(struct edac_priv *priv, unsigned int start, u32 regval)
+{
+	union edac_info rows;
+
+	rows.i = regval;
+	priv->row_bit[start] = rows.row0;
+	priv->row_bit[start + 1] = rows.row1;
+	priv->row_bit[start + 2] = rows.row2;
+	priv->row_bit[start + 3] = rows.row3;
+	priv->row_bit[start + 4] = rows.row4;
+}
+
+static void setup_row_address_map(struct edac_priv *priv, u32 *error_data)
+{
+	u32 regval;
+	union edac_info rows;
+
+	regval = error_data[ADEC6];
+	process_bit(priv, 0, regval);
+
+	regval = error_data[ADEC7];
+	process_bit(priv, 5, regval);
+
+	regval = error_data[ADEC8];
+	process_bit(priv, 10, regval);
+
+	regval = error_data[ADEC9];
+	rows.i = regval;
+
+	priv->row_bit[15] = rows.row0;
+	priv->row_bit[16] = rows.row1;
+	priv->row_bit[17] = rows.row2;
+}
+
+static void setup_column_address_map(struct edac_priv *priv, u32 *error_data)
+{
+	u32 regval;
+	union edac_info cols;
+
+	regval = error_data[ADEC9];
+	priv->col_bit[0] = FIELD_GET(MASK_24, regval);
+
+	regval = error_data[ADEC10];
+	cols.i = regval;
+	priv->col_bit[1] = cols.col1;
+	priv->col_bit[2] = cols.col2;
+	priv->col_bit[3] = cols.col3;
+	priv->col_bit[4] = cols.col4;
+	priv->col_bit[5] = cols.col5;
+
+	regval = error_data[ADEC11];
+	cols.i = regval;
+	priv->col_bit[6] = cols.col1;
+	priv->col_bit[7] = cols.col2;
+	priv->col_bit[8] = cols.col3;
+	priv->col_bit[9] = cols.col4;
+	priv->col_bit[10] = cols.col5;
+}
+
+static void setup_bank_grp_ch_address_map(struct edac_priv *priv, u32 *error_data)
+{
+	u32 regval;
+
+	regval = error_data[ADEC12];
+	priv->bank_bit[0] = (regval & MASK_0);
+	priv->bank_bit[1] = FIELD_GET(DDRMC5_BANK1_MASK, regval);
+	priv->grp_bit[0] = FIELD_GET(DDRMC5_GRP_0_MASK, regval);
+	priv->grp_bit[1] = FIELD_GET(DDRMC5_GRP_1_MASK, regval);
+	priv->grp_bit[2] = FIELD_GET(MASK_24, regval);
+}
+
+static void setup_rank_lrank_address_map(struct edac_priv *priv, u32 *error_data)
+{
+	u32 regval;
+
+	regval = error_data[ADEC4];
+	priv->rank_bit[0] = (regval & MASK_0);
+	priv->rank_bit[1] = FIELD_GET(DDRMC5_RANK_1_MASK, regval);
+
+	regval = error_data[ADEC5];
+	priv->lrank_bit[0] = (regval & MASK_0);
+	priv->lrank_bit[1] = FIELD_GET(DDRMC5_LRANK_1_MASK, regval);
+	priv->lrank_bit[2] = FIELD_GET(DDRMC5_LRANK_2_MASK, regval);
+	priv->lrank_bit[3] = FIELD_GET(MASK_24, regval);
+}
+
+/**
+ * setup_address_map - Set Address Map by querying ADDRMAP registers.
+ * @priv:	DDR memory controller private instance data.
+ * @error_data:	The address decode error data.
+ *
+ * Set Address Map by querying ADDRMAP registers.
+ *
+ * Return: none.
+ */
+static void setup_address_map(struct edac_priv *priv, u32 *error_data)
+{
+	setup_row_address_map(priv, error_data);
+
+	setup_column_address_map(priv, error_data);
+
+	setup_bank_grp_ch_address_map(priv, error_data);
+
+	setup_rank_lrank_address_map(priv, error_data);
+}
+
+static inline bool is_response(u8 *data)
+{
+	return (data[0] == MCDI_RESPONSE);
+}
+
+static const guid_t amd_versalnet_guid = GUID_INIT(0x82678888, 0xa556, 0x44f2,
+						 0xb8, 0xb4, 0x45, 0x56, 0x2e,
+						 0x8c, 0x5b, 0xec);
+
+static int amd_rpmsg_cb(struct rpmsg_device *rpdev, void *data,
+			int len, void *priv, u32 src)
+{
+	struct mem_ctl_info *mci = dev_get_drvdata(&rpdev->dev);
+	struct edac_priv *edac_priv = mci->pvt_info;
+	const guid_t *sec_type = &guid_null;
+	u32 length, offset, error_id;
+	u32 *result = (u32 *)data;
+	struct ecc_status *p;
+	int i, j, k, sec_sev;
+	u32 *adec_data;
+
+	if (is_response(data)) {
+		cdx_mcdi_process_cmd(edac_priv->mcdi, (struct cdx_dword *)data, len);
+		return 0;
+	}
+
+	sec_sev = result[AMD_ERROR_LEVEL];
+	error_id = result[AMD_ERRORID];
+	length = result[AMD_MSG_ERR_LENGTH];
+	offset = result[AMD_MSG_ERR_OFFSET];
+
+	if (result[TOTAL_ERR_LENGTH] > length) {
+		if (!edac_priv->part_len)
+			edac_priv->part_len = length;
+		else
+			edac_priv->part_len += length;
+		/*
+		 * The data can come in 2 stretches. Construct the regs from 2
+		 * messages the offset indicates the offset from which the data is to
+		 * be taken
+		 */
+		for (i = 0 ; i < length; i++) {
+			k = offset + i;
+			j = AMD_ERR_DATA + i;
+			edac_priv->regs[k] = result[j];
+		}
+		if (edac_priv->part_len < result[TOTAL_ERR_LENGTH])
+			return 0;
+	}
+
+	edac_priv->error_id = error_id;
+	edac_priv->error_level = result[AMD_ERROR_LEVEL];
+
+	switch (error_id) {
+	case HNICX_CR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: HNICX Correctable Error");
+		break;
+	case HNICX_NCR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: HNICX Non-correctable Error");
+		break;
+	case FPX_SPLITTER0_MEM_ERR:
+	case FPX_SPLITTER0_AXI_ERR:
+	case FPX_SPLITTER1_MEM_ERR:
+	case FPX_SPLITTER1_AXI_ERR:
+	case FPX_SPLITTER2_MEM_ERR:
+	case FPX_SPLITTER2_AXI_ERR:
+	case FPX_SPLITTER3_MEM_ERR:
+	case FPX_SPLITTER3_AXI_ERR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: FPX SPLITTER Error %d", error_id);
+		break;
+	case LPX_AFIFS_CORR_ERR:
+	case LPX_AFIFS_UNCORR_ERR:
+	case LPX_AFIFM_NONFATAL_ERR:
+	case FPX_AFIFM0_NONFATAL_ERR:
+	case FPX_AFIFM1_NONFATAL_ERR:
+	case FPX_AFIFM2_NONFATAL_ERR:
+	case FPX_AFIFM3_NONFATAL_ERR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: AFIFM Error %d", error_id);
+		break;
+	case FPX_AFIFS_CORR_ERR:
+	case FPX_AFIFS_UNCORR_ERR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: AFIFS Error");
+		break;
+	/* PL Errors */
+	case PLSYSMON_NCR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: PL Sysmon Non-Correctable Error");
+		break;
+	case PLSYSMON_CR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: PL Sysmon Correctable Error");
+		break;
+	case GSW_NCR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: General Software Non-Correctable Error");
+		break;
+	case MMCM:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: MMCM Error");
+		break;
+	case LPX_GLITCH_DET0:
+	case LPX_GLITCH_DET1:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: LPX glitch Error %d", error_id);
+		break;
+	/* Firmware error */
+	case INT_PSM_CR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: PSM Correctable Error");
+		break;
+	case INT_PMX_CORR_ERR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: PMC correctable Error");
+		break;
+	case INT_PMX_UNCORR_ERR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: PMC Un correctable Error");
+		break;
+	case PMC_SMON4:
+	case PMC_SMON8:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: PMC Sysmon Error");
+		break;
+	/* RPU Errors */
+	case RPUA0_CORR_ERR:
+	case RPUA0_MISC1:
+	case RPUA0_MISC2:
+	case RPUA1_CORR_ERR:
+	case RPUA1_FATAL_ERR:
+	case RPUA1_TIMEOUT_ERR:
+	case RPUA1_MISC1:
+	case RPUA1_MISC2:
+	case RPUB0_CORR_ERR:
+	case RPUB0_FATAL_ERR:
+	case RPUB0_TIMEOUT_ERR:
+	case RPUB0_MISC1:
+	case RPUB0_MISC2:
+	case RPUB1_CORR_ERR:
+	case RPUB1_FATAL_ERR:
+	case RPUB1_TIMEOUT_ERR:
+	case RPUB1_MISC1:
+	case RPUB1_MISC2:
+	case RPU_PCIL_ERR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: RPU Error %d", error_id);
+		break;
+	/* Memory Errors */
+	case OCM0_CORR_ERR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: OCM0 correctable Error %d", error_id);
+		break;
+	case OCM1_CORR_ERR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: OCM1 correctable Error %d", error_id);
+		break;
+	case OCM0_UNCORR_ERR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: OCM0 Un-correctable Error %d ", error_id);
+		break;
+	case OCM1_UNCORR_ERR:
+		snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
+			 "Error type: OCM1 Un-correctable Error %d", error_id);
+		break;
+	case DDRMC5_CR:
+		p = &edac_priv->stat;
+		p->error_type = DDRMC5_ERR_TYPE_CE;
+		for (i = 0 ; i < NUM_CONTROLLERS; i++) {
+			if (get_ddr_ce_info(&edac_priv->regs[i * REGS_PER_CONTROLLER], edac_priv)) {
+				adec_data = edac_priv->adec + ADEC_NUM * i;
+				setup_address_map(edac_priv, adec_data);
+				handle_error(mci, &edac_priv->stat, i);
+			}
+		}
+		return 0;
+	case DDRMC5_NCR:
+		p = &edac_priv->stat;
+		p->error_type = DDRMC5_ERR_TYPE_UE;
+		for (i = 0 ; i < NUM_CONTROLLERS; i++) {
+			if (get_ddr_ue_info(&edac_priv->regs[i * REGS_PER_CONTROLLER], edac_priv)) {
+				adec_data = edac_priv->adec + ADEC_NUM * i;
+				setup_address_map(edac_priv, adec_data);
+				handle_error(mci, &edac_priv->stat, i);
+			}
+		}
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	length = result[TOTAL_ERR_LENGTH] * 4; /* Convert to bytes */
+	log_non_standard_event(sec_type, &amd_versalnet_guid, edac_priv->message,
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
+static void amd_rpmsg_post_probe_work(struct work_struct *work)
+{
+	struct edac_priv *priv;
+
+	priv = container_of(work, struct edac_priv, work);
+	amd_setup_mcdi(priv);
+}
+
+static int amd_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_channel_info chinfo = {0};
+	struct mem_ctl_info *mci;
+	struct edac_priv *pg;
+
+	mci = (struct mem_ctl_info *)amd_rpmsg_id_table[0].driver_data;
+	if (!mci)
+		return dev_err_probe(&rpdev->dev, -ENODEV, "no amd device to attach to\n");
+
+	pg = mci->pvt_info;
+	chinfo.src = RPMSG_ADDR_ANY;
+	chinfo.dst = rpdev->dst; /* NMC */
+	strscpy(chinfo.name, amd_rpmsg_id_table[0].name,
+		strlen(amd_rpmsg_id_table[0].name));
+
+	pg->ept = rpmsg_create_ept(rpdev, amd_rpmsg_cb, NULL, chinfo);
+	if (!pg->ept)
+		return dev_err_probe(&rpdev->dev, -ENXIO,
+			      "Failed to create ept for channel %s\n",
+			      chinfo.name);
+
+	dev_set_drvdata(&rpdev->dev, mci);
+
+	schedule_work(&pg->work);
+
+	return 0;
+}
+
+static ssize_t reset_store(struct device *dev, struct device_attribute *mattr,
+			   const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct edac_priv *priv = mci->pvt_info;
+	struct ack reply;
+	u32 reset;
+	int ret;
+
+	ret = kstrtoint(data, 10, &reset);
+	if (ret)
+		return ret;
+
+	reply.error_level = priv->error_level;
+	reply.error_id = priv->error_id;
+	reply.next_action = reset;
+
+	ret = rpmsg_send(priv->ept, &reply, ERR_NOTIFICATION_MAX);
+	if (ret)
+		return ret;
+	return count;
+}
+static DEVICE_ATTR_WO(reset);
+
+static void amd_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct mem_ctl_info *mci = dev_get_drvdata(&rpdev->dev);
+	struct edac_priv *edac_priv = mci->pvt_info;
+
+	device_remove_file(&mci->dev, &dev_attr_reset);
+	flush_work(&edac_priv->mcdi->work);
+	rpmsg_destroy_ept(edac_priv->ept);
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
+static int mc_probe(struct platform_device *pdev)
+{
+	struct edac_mc_layer layers[2];
+	u32 num_chans, rank, dwidth;
+	struct mem_ctl_info *mci;
+	struct edac_priv *priv;
+	int rc;
+
+	rc = device_property_read_u32(&pdev->dev, "amd,rank", &rank);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "unable to read rank property");
+		return rc;
+	}
+
+	rc = device_property_read_u32(&pdev->dev, "amd,num-chans", &num_chans);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "unable to read num-chans property");
+		return rc;
+	}
+
+	rc = device_property_read_u32(&pdev->dev, "amd,dwidth", &dwidth);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "unable to read dwidth property");
+		return rc;
+	}
+
+	mutex_lock(&vnet_edac_lock);
+	if (probe_once) {
+		rc = -ENODEV;
+		goto free_lock;
+	}
+
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = rank;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = num_chans;
+	layers[1].is_virt_csrow = false;
+
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
+			    sizeof(struct edac_priv));
+	if (!mci) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Failed memory allocation for mc instance\n");
+		rc = -ENOMEM;
+		goto free_lock;
+	}
+
+	priv = mci->pvt_info;
+	priv->dwidth = dwidth;
+
+	mc_init(mci, pdev);
+
+	rc = edac_mc_add_mc(mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Failed to register with EDAC core\n");
+		goto free_edac_mc;
+	}
+
+	amd_rpmsg_id_table[0].driver_data = (kernel_ulong_t)mci;
+	INIT_WORK(&priv->work, amd_rpmsg_post_probe_work);
+	rc = register_rpmsg_driver(&amd_rpmsg_driver);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Failed to register RPMsg driver: %d\n", rc);
+		goto del_edac_mc;
+	}
+
+	rc = device_create_file(&mci->dev, &dev_attr_reset);
+	if (rc < 0)
+		goto unregister;
+
+	probe_once = 1;
+	mutex_unlock(&vnet_edac_lock);
+
+	return 0;
+
+unregister:
+	unregister_rpmsg_driver(&amd_rpmsg_driver);
+del_edac_mc:
+	edac_mc_del_mc(&pdev->dev);
+free_edac_mc:
+	edac_mc_free(mci);
+free_lock:
+	mutex_unlock(&vnet_edac_lock);
+
+	return rc;
+}
+
+static void mc_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+
+	mutex_lock(&vnet_edac_lock);
+	probe_once = 0;
+	unregister_rpmsg_driver(&amd_rpmsg_driver);
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+	mutex_unlock(&vnet_edac_lock);
+}
+
+static const struct of_device_id amd_edac_match[] = {
+	{ .compatible = "amd,versalnet-edac", },
+	{
+		/* end of table */
+	}
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


