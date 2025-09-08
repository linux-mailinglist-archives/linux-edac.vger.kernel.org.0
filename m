Return-Path: <linux-edac+bounces-4740-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BCAB48CA2
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 13:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9852000C5
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77FC2EDD6C;
	Mon,  8 Sep 2025 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OFm1chyp"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7401D5150;
	Mon,  8 Sep 2025 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332658; cv=fail; b=dMwu7lSO6zMe9dGnh5TFSN4DfI1m3XZ3HE/V6nKzkZppmQa0AMkX2NLEcj2g6Lo+XroOEz6PNsnD/MbqsK9xVOULEV4/tCfqPBsPE9+6DlGLByNAP+cfC+pqvxfOmEKHXjZtefWdEwsviN0/26G19+T+V542OekOcbDRw/wfEfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332658; c=relaxed/simple;
	bh=orvcIJGyijKyWhUbglhgTmXkKHI6YiZ9CqazVne+ZxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3quNtfu6OEtJKxumLFtfu+tVH3QrknUEy/shAjIuJ2Byo97JR7QVlC6X1SwjS7j8ECSVVCN2vgfTanzp4gQDANvlBeXQ1Y2AKD+C3uyLxBclHI+AACoMVRv/ZkqSAL29Pf7oGyn3FOlzf0LgR0sWxPCXhW+86a1GArUVIgN7P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OFm1chyp; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7LSpsnVcXRlfuau1tT0AfsOo+7fSbbKjY96TtHeWvjk0xCWCtQUPdKzYvSnFyGIXIWllhlAmpzEgPTKz1izYnqOsxI3gJ8g6m4RhCsMo4uzUD4U4R2GXXVOxPXQYDZH0wfQuCKBhntRh4s3LyyRqVq7EJ/80FU3KxvFHXDEWWF7awCCZmzURA5FtU0szfbUi9Yw4vntO5iGUIrOZFJgR5cntDM5vF0oSpLN2QDJ5Uqdss4Cj0QK//uAbHb9u0pTdgM0n4oyFUu7Df+nivOt59ukXgiOWMMOz0p4KBhGCwJgWoExZV6JdwGZ2Ujh/D1M2QLF+NGEghD3c8agcqnhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzUnWepnWm9eHWZ1YOs2B/YaOlDWqv1cYOLs5NtuBGA=;
 b=AIoLik4BpcstC+Nr8D6GHnN9SnIDvAfiztJrWABhiOEkDnXAE/Hv+kpYwjVHh/9RL9gLw/nVfC8AYnXigNZw8gLArJXzXptV9436pjYwE0nEjHqksL1D/aZJOI7Okps5LL0k2dviuioWGT1hGovU8IWCWkMd4nCNuYKM38wXEOMgo5xVoPzLVLA2HZpm5JXNpsOlb5fHrUBgPXghTJBL0Ea3Gi8T/XxTgdiAnjflKBKemMgCOh4q3MA4Y8f1ab+cmUYMkDf4peceM0RKP3I8ztYY/Gk/oLVgYQJJ1ig3DTl83KMad2Q8bUfV5qXFNnjPa93LQoa+pDT5h3crHm6YzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzUnWepnWm9eHWZ1YOs2B/YaOlDWqv1cYOLs5NtuBGA=;
 b=OFm1chyp4DupMWW6aLAlCl3imQeIrbYUj5j6EuR3dR0ZBPFq9Oj8ynGhKbKvjOwR6IBbEWJ5jVk28gaG5WzT4V0Y49PpO/bzcJbDzvgYfRLsYo42+6kcaI+teOtzOZijX8Me+j/TlCIV3Nvt1EofjudAuQuP8uxXelHy+eIHDB0=
Received: from BYAPR06CA0024.namprd06.prod.outlook.com (2603:10b6:a03:d4::37)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:57:28 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::d2) by BYAPR06CA0024.outlook.office365.com
 (2603:10b6:a03:d4::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:57:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 04:57:26 -0700
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Sep 2025 04:57:21 -0700
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
Subject: [PATCH v9 5/5] EDAC: Add a driver for the AMD Versal NET DDR controller
Date: Mon, 8 Sep 2025 17:26:49 +0530
Message-ID: <20250908115649.22903-6-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250908115649.22903-1-shubhrajyoti.datta@amd.com>
References: <20250908115649.22903-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f46e369-5334-4c5d-7f3d-08ddeecee260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q/bX9+oFVZA4KxwmaprsfciR3X5JyDJfe12o4hVV3pOAudMPdWd3WDxk7+lq?=
 =?us-ascii?Q?eR7Z6bO/qKM5CcJH8KZZVOmV5tcXDZQiA5le908IUzfwcHm4askHt0QRt9K7?=
 =?us-ascii?Q?mPkXqRkNxae8bW3dWswdCSwOw5SSPsrMkJ0LpCJsMryfokQsXY//ULARFqKw?=
 =?us-ascii?Q?yaZNT6vUyBLAF1m0lAg64EsXirGTuM3kdiZumMKL76xXPa1SZYwQNgzVq2pO?=
 =?us-ascii?Q?yqnDXOl9X+GwUclKIaRFXb7S9I2GnSxLRLAgEan5GgRt5bn25Jf7BeSKaC8B?=
 =?us-ascii?Q?YFibNNnVkJZvctEYbEHrChsDGaKrDwaGNFBqX5jiIPoY84jqBgZec045uzp+?=
 =?us-ascii?Q?IYS7IaRVTYDe1pq0KumurJzHnOP2f1V/bcNa/qRemMoH7gKeIeG90uya+u+J?=
 =?us-ascii?Q?GFYLlsA8Ylps5AGT5eEgJpm5ENcOU8nJ1htY7vXzx3ECo53BgNU8LO41nD9Z?=
 =?us-ascii?Q?Hf2j9h96h8JaV8BP74vtisJOJme9yfwCTH9rE6Hs8G5i885f+Hq26B0R/jIw?=
 =?us-ascii?Q?IUEaElsBgDvPMpeflRUT4C6BaH23smvkzXYsYUyqBnZtu+3oAhQGlyahiELv?=
 =?us-ascii?Q?ZLlBO5x9RWGxd5gQFUpjYmYNPhNAmy5v8an0o/Mb5U6Keo4iptAc9hPf9GFG?=
 =?us-ascii?Q?o0woWmP20Cqr1f8jGrOG9eXeZazP5J08B3kS6FO1flOffjVouSqLJNbfQVgF?=
 =?us-ascii?Q?35KxX2o8uB2auzEXv2xl9rqZW8aD9OSILPVmM6E4QNQN6TN0cOX+iiDUN5SP?=
 =?us-ascii?Q?ZX6NgslVj3flCYnDw1R6R7qBmEPscwK9y6kWC5dwWtdrE1W5rFXDRpfMR9KI?=
 =?us-ascii?Q?oWyQKxuPc/85Pf+sXjTGMHDZkMT69hRH4Od9hBr0Jwk0U3eKZribtM452Ut6?=
 =?us-ascii?Q?P3efClHirtq/XDHnROM03wGK7vo9kMcmjYG2COIVNnCETaHQEr85efy9dqNo?=
 =?us-ascii?Q?4CEDihN4PBnYjEteg5YG+Gh3NpNjA282N6s2KSY32qPNVCK1ptEIEX/MCwd7?=
 =?us-ascii?Q?PrsKbPHYa9YWRa8ZdnzH25PbxczyJ0fFp7W6VSk5tJA3uSnQUGY7RXhjkvOW?=
 =?us-ascii?Q?fiMT8mnbFA/dlBUsGYbneh8Bf1TQzKQFUTcu25mnzIXsf4q6umG3ijIj7Xlx?=
 =?us-ascii?Q?Am+BhEVIEiOHNv1vSKm2g4f6VNCqfsLEeo5EPc0Jl44Ozo0Yi+OJI91qwyYr?=
 =?us-ascii?Q?cRnMuuKa//Wyt5dWDBjMfOhB2uBW8nFx7VwpiZ1IhO2NSZBjnHhusPe6SsOI?=
 =?us-ascii?Q?LpBhGJuJE86F2sio18j0MbKjljX5eHKF+Pk7y3BVRKA1kffvwnFzAk9xZF1R?=
 =?us-ascii?Q?lAPNMou3Wdi3g3oFFlISJotYL1fh6mADA0yI5vEyMzPnmaD91TCakET5jmpn?=
 =?us-ascii?Q?gIEE2b1jDvPq0nsDC9/hJB1cbyEcE++Nk//Hsti3tPKuABgJu9+MkUryQsMR?=
 =?us-ascii?Q?vop4bITw3NTmr5/2tODOGgKrOlg589Kz0a3cuR4P95K7EW6XxMg3d/aMmwnD?=
 =?us-ascii?Q?UusXdVwNCaJPu12Oy/KJNNeFCAksRnW09HCuQjf5qXyLtocprkn+zYy96Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:57:28.3778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f46e369-5334-4c5d-7f3d-08ddeecee260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009

Add a driver for the AMD Versal NET DDR memory controller which supports
single bit error correction, double bit error detection and other system
errors from various IP subsystems (e.g., RPU, NOCs, HNICX, PL).

The driver listens for notifications from the NMC (Network management
controller) using RPMsg (Remote Processor Messaging).

The channel used for communicating to RPMsg is named "error_edac".  Upon
receipt of a notification, the driver sends a RAS event trace.

  [ bp:
    - Fixup title
    - Rewrite commit message
    - Fixup Kconfig text
    - Zap unused defines and align them
    - Simplify rpmsg_cb() considerably
    - Drop silly double-brackets in conditionals
    - Use proper void * type in mcdi_request()
    - Do not clear chinfo in rpmsg_probe() unnecessarily
    - Fix indentation
    - Do a proper err unwind path in init_versalnet()
    - Redo the error unwind path in mc_probe() properly
    - Fix the ordering in mc_remove()
    ]

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250703173105.GLaGa-WQCESDNsqygm@fat_crate.local
---

Changes in v9:
- Fixup title
- Rewrite commit message
- Fixup Kconfig text
- Zap unused defines and align them
- Simplify rpmsg_cb() considerably
- Drop silly double-brackets in conditionals
- Use proper void * type in mcdi_request()
- Do not clear chinfo in rpmsg_probe() unnecessarily
- Fix indentation
- Do a proper err unwind path in init_versalnet()
- Redo the error unwind path in mc_probe() properly
- Fix the ordering in mc_remove()
- call cdx_mcdi_finish

Changes in v8:
- Remove "EDAC" from macros and shoterned them
- Removed redundant parentheses
- Improved the description of the @i field in union ecc_error_info
- Improved logging for memory_failure()
- Merged init_csrows() into mc_init():
- Remove AMD-specific naming for static functions
- Add MAINTAINERS file
- Register all the controllers
- Replace  AMD_ERR use the snprintf in a function

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

 MAINTAINERS                       |   7 +
 drivers/edac/Kconfig              |   8 +
 drivers/edac/Makefile             |   1 +
 drivers/edac/versalnet_edac.c     | 958 ++++++++++++++++++++++++++++++
 include/linux/cdx/edac_cdx_pcol.h |  28 +
 5 files changed, 1002 insertions(+)
 create mode 100644 drivers/edac/versalnet_edac.c
 create mode 100644 include/linux/cdx/edac_cdx_pcol.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 77782f2e33b4..d51372cdf43e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27789,6 +27789,13 @@ S:	Maintained
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
index b824472208c4..39352b9b7a7e 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -584,4 +584,12 @@ config EDAC_CORTEX_A72
 	  The detected and reported errors are from reading CPU/L2 memory error
 	  syndrome registers.
 
+config EDAC_VERSALNET
+	tristate "AMD VersalNET DDR Controller"
+	depends on CDX_CONTROLLER && ARCH_ZYNQMP
+	help
+	  Support for single bit error correction, double bit error detection
+	  and other system errors from various IP subsystems like RPU, NOCs,
+	  HNICX, PL on the AMD Versal NET DDR memory controller.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index c1736f264320..1c14796410a3 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -88,4 +88,5 @@ obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
 obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
 obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
 obj-$(CONFIG_EDAC_LOONGSON)		+= loongson_edac.o
+obj-$(CONFIG_EDAC_VERSALNET)		+= versalnet_edac.o
 obj-$(CONFIG_EDAC_CORTEX_A72)		+= a72_edac.o
diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
new file mode 100644
index 000000000000..66714fffa591
--- /dev/null
+++ b/drivers/edac/versalnet_edac.c
@@ -0,0 +1,958 @@
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
+#define MC5_IRQ_CE_MASK			GENMASK(18, 15)
+#define MC5_IRQ_UE_MASK			GENMASK(14, 11)
+
+#define MC5_RANK_1_MASK			GENMASK(11, 6)
+#define MASK_24				GENMASK(29, 24)
+#define MASK_0				GENMASK(5, 0)
+
+#define MC5_LRANK_1_MASK		GENMASK(11, 6)
+#define MC5_LRANK_2_MASK		GENMASK(17, 12)
+#define MC5_BANK1_MASK			GENMASK(11, 6)
+#define MC5_GRP_0_MASK			GENMASK(17, 12)
+#define MC5_GRP_1_MASK			GENMASK(23, 18)
+
+#define MC5_REGHI_ROW			7
+#define MC5_EACHBIT			1
+#define MC5_ERR_TYPE_CE			0
+#define MC5_ERR_TYPE_UE			1
+#define MC5_HIGH_MEM_EN			BIT(20)
+#define MC5_MEM_MASK			GENMASK(19, 0)
+#define MC5_X16_BASE			256
+#define MC5_X16_ECC			32
+#define MC5_X16_SIZE			(MC5_X16_BASE + MC5_X16_ECC)
+#define MC5_X32_SIZE			576
+#define MC5_HIMEM_BASE			(256 * SZ_1M)
+#define MC5_ILC_HIMEM_EN		BIT(28)
+#define MC5_ILC_MEM			GENMASK(27, 0)
+#define MC5_INTERLEAVE_SEL		GENMASK(3, 0)
+#define MC5_BUS_WIDTH_MASK		GENMASK(19, 18)
+#define MC5_NUM_CHANS_MASK		BIT(17)
+#define MC5_RANK_MASK			GENMASK(15, 14)
+
+#define ERROR_LEVEL			2
+#define ERROR_ID			3
+#define TOTAL_ERR_LENGTH		5
+#define MSG_ERR_OFFSET			8
+#define MSG_ERR_LENGTH			9
+#define ERROR_DATA			10
+#define MCDI_RESPONSE			0xFF
+
+#define REG_MAX				152
+#define ADEC_MAX			152
+#define NUM_CONTROLLERS			8
+#define REGS_PER_CONTROLLER		19
+#define ADEC_NUM			19
+#define BUFFER_SZ			80
+
+#define XDDR5_BUS_WIDTH_64		0
+#define XDDR5_BUS_WIDTH_32		1
+#define XDDR5_BUS_WIDTH_16		2
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
+/* Row and column bit positions in the address decoder (ADEC) registers. */
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
+ * @ceinfo:	Correctable errors.
+ * @ueinfo:	Uncorrected errors.
+ * @channel:	Channel number.
+ * @error_type:	Error type.
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
+	char message[256];
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
+/*
+ * Address decoder (ADEC) registers to match the order in which the register
+ * information is received from the firmware.
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
+	p = &priv->stat;
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
+	else if (isr & MC5_IRQ_UE_MASK)
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
+	else if (isr & MC5_IRQ_UE_MASK)
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
+ * convert_to_physical - Convert @error_data to a physical address.
+ * @priv:	DDR memory controller private instance data.
+ * @pinf:	ECC error info structure.
+ * @controller:	Controller number of the MC5
+ * @error_data:	the DDRMC5 ADEC address decoder register data
+ *
+ * Return: physical address of the DDR memory.
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
+ * handle_error - Handle errors.
+ * @priv:	DDR memory controller private instance data.
+ * @stat:	ECC status structure.
+ * @ctl_num:	Controller number of the MC5
+ * @error_data:	the MC5 ADEC address decoder register data
+ *
+ * Handles ECC correctable and uncorrectable errors.
+ */
+static void handle_error(struct mc_priv  *priv, struct ecc_status *stat,
+			 int ctl_num, int *error_data)
+{
+	union ecc_error_info pinf;
+	struct mem_ctl_info *mci;
+	unsigned long pa;
+	phys_addr_t pfn;
+	int err;
+
+	if (WARN_ON_ONCE(ctl_num > NUM_CONTROLLERS))
+		return;
+
+	mci = priv->mci[ctl_num];
+
+	if (stat->error_type == MC5_ERR_TYPE_CE) {
+		pinf = stat->ceinfo[stat->channel];
+		snprintf(priv->message, sizeof(priv->message),
+			 "Error type:%s Controller %d Addr at %lx\n",
+			 "CE", ctl_num, convert_to_physical(priv, pinf, ctl_num, error_data));
+
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+				     1, 0, 0, 0, 0, 0, -1,
+				     priv->message, "");
+	}
+
+	if (stat->error_type == MC5_ERR_TYPE_UE) {
+		pinf = stat->ueinfo[stat->channel];
+		snprintf(priv->message, sizeof(priv->message),
+			 "Error type:%s controller %d Addr at %lx\n",
+			 "UE", ctl_num, convert_to_physical(priv, pinf, ctl_num, error_data));
+
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+				     1, 0, 0, 0, 0, 0, -1,
+				     priv->message, "");
+		pa = convert_to_physical(priv, pinf, ctl_num, error_data);
+		pfn = PHYS_PFN(pa);
+
+		if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
+			err = memory_failure(pfn, MF_ACTION_REQUIRED);
+			if (err)
+				edac_dbg(2, "memory_failure() error: %d", err);
+			else
+				edac_dbg(2, "Poison page at PA 0x%lx\n", pa);
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
+	mci->ctl_name = "VersalNET DDR5";
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
+	void *send_buf;
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
+		dev_err(&cdx->rpdev->dev, "Failed to send rpmsg data: %d\n", ret);
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
+	const char *err_str;
+	u32 *adec_data;
+
+	if (*(u8 *)data == MCDI_RESPONSE) {
+		cdx_mcdi_process_cmd(mc_priv->mcdi, (struct cdx_dword *)data, len);
+		return 0;
+	}
+
+	sec_sev = result[ERROR_LEVEL];
+	error_id = result[ERROR_ID];
+	length = result[MSG_ERR_LENGTH];
+	offset = result[MSG_ERR_OFFSET];
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
+			j = ERROR_DATA + i;
+			mc_priv->regs[k] = result[j];
+		}
+		if (mc_priv->part_len < result[TOTAL_ERR_LENGTH])
+			return 0;
+		mc_priv->part_len = 0;
+	}
+
+	mc_priv->error_id = error_id;
+	mc_priv->error_level = result[ERROR_LEVEL];
+
+	switch (error_id) {
+	case 5:		err_str = "General Software Non-Correctable error"; break;
+	case 6:		err_str = "CFU error"; break;
+	case 7:		err_str = "CFRAME error"; break;
+	case 10:	err_str = "DDRMC Microblaze Correctable ECC error"; break;
+	case 11:	err_str = "DDRMC Microblaze Non-Correctable ECC error"; break;
+	case 15:	err_str = "MMCM error"; break;
+	case 16:	err_str = "HNICX Correctable error"; break;
+	case 17:	err_str = "HNICX Non-Correctable error"; break;
+
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
+
+	case 21:	err_str = "GT Non-Correctable error"; break;
+	case 22:	err_str = "PL Sysmon Correctable error"; break;
+	case 23:	err_str = "PL Sysmon Non-Correctable error"; break;
+	case 111:	err_str = "LPX unexpected dfx activation error"; break;
+	case 114:	err_str = "INT_LPD Non-Correctable error"; break;
+	case 116:	err_str = "INT_OCM Non-Correctable error"; break;
+	case 117:	err_str = "INT_FPD Correctable error"; break;
+	case 118:	err_str = "INT_FPD Non-Correctable error"; break;
+	case 120:	err_str = "INT_IOU Non-Correctable error"; break;
+	case 123:	err_str = "err_int_irq from APU GIC Distributor"; break;
+	case 124:	err_str = "fault_int_irq from APU GIC Distribute"; break;
+	case 132 ... 139: err_str = "FPX SPLITTER error"; break;
+	case 140:	err_str = "APU Cluster 0 error"; break;
+	case 141:	err_str = "APU Cluster 1 error"; break;
+	case 142:	err_str = "APU Cluster 2 error"; break;
+	case 143:	err_str = "APU Cluster 3 error"; break;
+	case 145:	err_str = "WWDT1 LPX error"; break;
+	case 147:	err_str = "IPI error"; break;
+	case 152 ... 153: err_str = "AFIFS error"; break;
+	case 154 ... 155: err_str = "LPX glitch error"; break;
+	case 185 ... 186: err_str = "FPX AFIFS error"; break;
+	case 195 ... 199: err_str = "AFIFM error"; break;
+	case 108:	err_str = "PSM Correctable error"; break;
+	case 59:	err_str = "PMC correctable error"; break;
+	case 60:	err_str = "PMC Un correctable error"; break;
+	case 43 ... 47:	err_str = "PMC Sysmon error"; break;
+	case 163 ... 184: err_str = "RPU error"; break;
+	case 148:	err_str = "OCM0 correctable error"; break;
+	case 149:	err_str = "OCM1 correctable error"; break;
+	case 150:	err_str = "OCM0 Un-correctable error"; break;
+	case 151:	err_str = "OCM1 Un-correctable error"; break;
+	case 189:	err_str = "PSX_CMN_3 PD block consolidated error"; break;
+	case 191:	err_str = "FPD_INT_WRAP PD block consolidated error"; break;
+	case 232:	err_str = "CRAM Un-Correctable error"; break;
+	default:	err_str = "VERSAL_EDAC_ERR_ID: %d"; break;
+	}
+
+	snprintf(mc_priv->message,
+		 sizeof(mc_priv->message),
+		 "[VERSAL_EDAC_ERR_ID: %d] Error type: %s", error_id, err_str);
+
+	/* Convert to bytes */
+	length = result[TOTAL_ERR_LENGTH] * 4;
+	log_non_standard_event(sec_type, &amd_versalnet_guid, mc_priv->message,
+			       sec_sev, (void *)&result[ERROR_DATA], length);
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
+	struct rpmsg_channel_info chinfo;
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
+		return dev_err_probe(&rpdev->dev, -ENXIO, "Failed to create ept for channel %s\n",
+				     chinfo.name);
+
+	dev_set_drvdata(&rpdev->dev, pg);
+
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
+	struct edac_mc_layer layers[2];
+	struct mem_ctl_info *mci;
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
+		rc = -ENOMEM;
+		mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers,
+				    sizeof(struct mc_priv));
+		if (!mci) {
+			edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
+			goto err_alloc;
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
+		if (rc)
+			goto err_alloc;
+
+		mci->pdev = dev;
+
+		platform_set_drvdata(pdev, priv);
+
+		mc_init(mci, dev);
+		rc = edac_mc_add_mc(mci);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_MC, "Failed to register MC%d with EDAC core\n", i);
+			goto err_alloc;
+		}
+	}
+	return 0;
+
+err_alloc:
+	while (i--) {
+		mci = priv->mci[i];
+		if (!mci)
+			continue;
+
+		if (mci->pdev) {
+			device_unregister(mci->pdev);
+			edac_mc_del_mc(mci->pdev);
+		}
+
+		edac_mc_free(mci);
+	}
+
+	return rc;
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
+		goto err_rproc_boot;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		goto err_alloc;
+
+	amd_rpmsg_id_table[0].driver_data = (kernel_ulong_t)priv;
+
+	rc = register_rpmsg_driver(&amd_rpmsg_driver);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to register RPMsg driver: %d\n", rc);
+		goto err_alloc;
+	}
+
+	rc = setup_mcdi(priv);
+	if (rc)
+		goto err_unreg;
+
+	priv->mcdi->r5_rproc = rp;
+
+	rc = init_versalnet(priv, pdev);
+	if (rc)
+		goto err_init;
+
+	return 0;
+
+err_init:
+	cdx_mcdi_finish(priv->mcdi);
+
+err_unreg:
+	unregister_rpmsg_driver(&amd_rpmsg_driver);
+
+err_alloc:
+	rproc_shutdown(rp);
+
+err_rproc_boot:
+	rproc_put(rp);
+
+	return rc;
+}
+
+static void mc_remove(struct platform_device *pdev)
+{
+	struct mc_priv *priv = platform_get_drvdata(pdev);
+
+	unregister_rpmsg_driver(&amd_rpmsg_driver);
+	remove_versalnet(priv);
+	rproc_shutdown(priv->mcdi->r5_rproc);
+	cdx_mcdi_finish(priv->mcdi);
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


