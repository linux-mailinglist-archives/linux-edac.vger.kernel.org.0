Return-Path: <linux-edac+bounces-4741-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB4DB48CA4
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 13:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497DA2001EB
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 11:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467402F7AB4;
	Mon,  8 Sep 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5dBM7k4k"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620F229B1F;
	Mon,  8 Sep 2025 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332660; cv=fail; b=Q/3o1fPB6lezKIwFZ8jKbuLmJoq6d096x1ULpShzryZjvEfAmNQdtoOYD95K/FNs6zPVWZ8IouLRQWRQGpE8IUCJFl5Yr1xDcOST9UAmYxpvWsN1WnyivCEOYyB0ppP9rHXAlgq9ZXLLeBMeAFJd0KdSrQj6rzLv9AuHNuTNu9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332660; c=relaxed/simple;
	bh=Y0hwLJzY62cVZj8LVQ/wBEhCjymNQKbAxlbixeQN11o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awtp3zgX1jbfjYmKqWUrWy944Tpt2Dk8mwhjAbiNKeUdAh74lsznTxDzYYr5TfDkoZUTU43D2srQyhhL9oNCWVtPMqrXaS4mUUpzDg/51CPQl2HQ1cfop9cZJvsn2O0PMwM3n1w2tGxFwTUG1bcG3xgpRLWBKSN/VpSxdR6/og4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5dBM7k4k; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPppETEH/dZOeZfiuzbeFXeLotUuewSm288KgYMJuRpkGS6plStfg+iu9lqeqh1NSpw92xvT064KDcZU2OxbEIzA5ro0oXZSh5LIir8zNMdfbpWCu/Ec1Bo1POEzmqoE65hiBwBNb3V8C0Ufctfhb/jyQHNvDjwu8iDFdPC2dlqtrhAWQj0nmpEfdlS1iUC59FoAmyYh40I6d+cTmFumUp5n2qLOP1bgYhRgV6edM9vX1s0RDxWB9jlxC7xy04PzA/tK3SdFhLjD0IujNmA1XetjjQYI+LjGCct+vXQYX5sMIbTmphn+N95cY0PNA6dahP4vHSLlNwdzyHSVTTvtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SLvkbE5HP5n/8hB8IIFTqIejlgwRtn6nTTJ6NKyFd8=;
 b=jB5TOQJ/ouU9wBg2i9k2fO4tgx9HZsLSDEYuAMuVAgeNBwSLMQk3+hpOndCGimLiekOWsRdT4/h4ardZXohlOfzUY6KoqDFs/bfQEYLWiNz52JXAdLEOUMJOK4eFmP4dWeTLnQk3bjgptY4hFfESgOBedzKK3S4RtryKwp0UuEzmJdRzaVJ/YLaCfxKvBO3IryUXZ7KjcjPCGNg1jAllAbl2RfLFF76JckzaoapR0Ji6vTxc8jBnY0OBXocvNp3FPJopc/dPjXOY0ez8TiLdHePsy8sOWku3qMe0d3HgBlxYWP8Y2ajY22SOZVFSNCQpdDgHcJf54wCKmtzzacKWAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SLvkbE5HP5n/8hB8IIFTqIejlgwRtn6nTTJ6NKyFd8=;
 b=5dBM7k4kQ9yckyrmsQ01hNijVhcPGk4tRHx0WcoFmSJB+eYBYDLIIo9YzAqVykoJAXHleQoiOU68FQmqdOdthwf73CF3BrqSIJZkwKFDQ5EzgJNAZs51m2yPTu+H7L/2kG3dNOY/zD8Uv54hWWJ1mz9jywA6cg60WqOYAOgx6qM=
Received: from BY5PR17CA0057.namprd17.prod.outlook.com (2603:10b6:a03:167::34)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:57:31 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:167:cafe::7) by BY5PR17CA0057.outlook.office365.com
 (2603:10b6:a03:167::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Mon,
 8 Sep 2025 11:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:57:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 8 Sep
 2025 04:57:03 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Sep
 2025 06:57:02 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Sep 2025 04:56:56 -0700
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
Subject: [PATCH v9 1/5] cdx: Split mcdi.h and reorganize headers
Date: Mon, 8 Sep 2025 17:26:45 +0530
Message-ID: <20250908115649.22903-2-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 70cad212-c978-468c-b470-08ddeecee2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d8VMY2GXhyZ0Da+q712s6RtvTKcYaovm7PqibCwTNim36QP7EJ7k+toORyXH?=
 =?us-ascii?Q?/5/GLtoudYK1kli31KvCOLd8C3VMqYrSKU3W5wjPHfU3HECTG9DlxGzaVmJ2?=
 =?us-ascii?Q?pjOPh/7e8PB7MazlZSVrHbwdA8uF0Pfq/lnW6ICH4f5sAeOE84tavHHu3kRc?=
 =?us-ascii?Q?X8dXb5Abv7Upnw9xRZ730L1iUqOY9uWGQetfimRjqT362UtZhlSmH2IqcfHO?=
 =?us-ascii?Q?sKakN8/c/tMXaXfPEk78nDTDdoP73p5w13OTMRd8SZHNLqLgOwWXMcELtp9B?=
 =?us-ascii?Q?CBuQDV7aj8XF0tSq4yW1TQXY8ILsppHL6YufTyaTCl8wIMCvrKPZSikJSwsJ?=
 =?us-ascii?Q?L1cIswlySOBXwkHEwYQ8n3XaV3uZL8+Zy7ubGQs/J8OGxHtTyNNL8/Mn85fw?=
 =?us-ascii?Q?wvYGeZop9v/DXKp1bvmeqs2qUDbEX+GY9sHJmPzBb8eiv6V44FrOG0D8sl/m?=
 =?us-ascii?Q?1i/PPZHBf3iGBLSV+2/xfpeEZBezklpVkiUTjhnU6lqtxUvjjYYj1d0DKGXi?=
 =?us-ascii?Q?g+WtEpgqrUH4AE2N3qAUImoNQ6CgyPS/F+u7R3SnTu6wsvgRxc4dKh4MXR7U?=
 =?us-ascii?Q?TVlPH2kr2xxsR5cwsqEbqQ4brYqNoJ++Ozx4wvUlP8pDpyLZvk+/L2YRNs8k?=
 =?us-ascii?Q?CdmYogL34Rhj0AfnjFysjLaAejEbh2hvmQaMB0YPZxGGrVN0pBYPeGAL2Hwk?=
 =?us-ascii?Q?QrvNjfqgfPX4rjJK4zyJ0Flqv2k2U6bYfdeTMzsk6BBGpu14jHHHEj85GhrD?=
 =?us-ascii?Q?6bh4+shOCSvvE5EHC0VD4FkZMei7RueSwlnoX3hT5SGKva+dY4mLgfv1qGDD?=
 =?us-ascii?Q?648ET5c6LQGec6r8hoBWmvXEDWOmw85AAPIuYxaKbODQoRUnYj5sMYmjGJjy?=
 =?us-ascii?Q?vJNYehevCtjdaABYYlMmoUalGFQQwtL2a6i2g5Noh60FX1CKXKosx6vsnjmD?=
 =?us-ascii?Q?IRxlD/vGusYnKJdUmT3xSa6FeMQkBi2NSkU3cfuBkF8GOlJPuJp/RTg5+G/l?=
 =?us-ascii?Q?pzA2rOl8QBMVdHtYqGnrYMplvOJvtHvUq5Z9oh55eJt/wVRii3ws8YRuLAGq?=
 =?us-ascii?Q?hTAhJq+Anl8c6xsrHKPUwARa5+DCDfZ/hP3RjUokBIUAEvhBp3htPLs56+TL?=
 =?us-ascii?Q?TY/0pmkx4aiIbL4vdsdrUId63kP3/Nwmxn1h3WvhSeIEvDnbySBBWKjPTFj0?=
 =?us-ascii?Q?J3nWfp+3OC99H+gmY6ogr+J8tRbBButqUJFpRzzl+FeRexgi04nyMTxT7VE8?=
 =?us-ascii?Q?E8nnTjC6JJ5KwsFk64W5jjsGPPlrsJcnbWjF1pcopM7nFotXpfzwcnJCm+ck?=
 =?us-ascii?Q?SRvhZkTeXRXWidSs4VHWMNl97i9p0lh2XJDQ9nSQ8lxy4Ml5zfOCai6BsSRW?=
 =?us-ascii?Q?BEAa8Kserb2qOzWu5l/gFs4GoPNcraqW3urp6n5P2TZpRvL9KA8n7ULl0nNO?=
 =?us-ascii?Q?tU/QliqeRLM7axucbrd/IIL5IVQ0krDwg1g4VRYlxomEhSH7o035gmKXd31p?=
 =?us-ascii?Q?f+xce2p9SJCMFjfE8aTUzuOspnykASqxyUGL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:57:29.3040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cad212-c978-468c-b470-08ddeecee2ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905

Move `bitfield.h` from the CDX controller directory to
`include/linux/cdx` to make them accessible to other drivers.

As part of this refactoring, `mcdi.h` has been split into two headers:
- `mcdi.h`: retains interface-level declarations
- `mcdid.h`: contains internal definitions and macros

This is in preparation for VersalNET EDAC driver that relies on it.

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
 drivers/cdx/controller/mcdid.h                | 63 +++++++++++++++++++
 .../linux/cdx}/bitfield.h                     |  0
 .../controller => include/linux/cdx}/mcdi.h   | 52 +--------------
 8 files changed, 71 insertions(+), 57 deletions(-)
 create mode 100644 drivers/cdx/controller/mcdid.h
 rename {drivers/cdx/controller => include/linux/cdx}/bitfield.h (100%)
 rename {drivers/cdx/controller => include/linux/cdx}/mcdi.h (74%)

diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index 5e3fd89b6b56..280f207735da 100644
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
index 61f1a290ff08..59aabd99fa8f 100644
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
index 000000000000..7fc29f099265
--- /dev/null
+++ b/drivers/cdx/controller/mcdid.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2008-2013 Solarflare Communications Inc.
+ * Copyright (C) 2022-2025, Advanced Micro Devices, Inc.
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


