Return-Path: <linux-edac+bounces-3701-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3D6A9AED1
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 15:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4551943CC8
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 13:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161D327EC6C;
	Thu, 24 Apr 2025 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P3dbQSG2"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0383027CB0D;
	Thu, 24 Apr 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500896; cv=fail; b=QzS9HQR3Db/jCXhoMZ9QX20ngc7nq0mRgoFybSoS6dvhGkAEVuvACTLag/wJQVGiG/6c/67DFnwb0c0wz24r8fMGCjlMw+ZpFVMdmt+DDe/vwtVMh/lM3qSfeeTh4/ft/UY2u0ibaU5UVbNHFkKMtA4+Zd5TRxi2yv52xqgZPE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500896; c=relaxed/simple;
	bh=gAiV9FTc+CIkVRteU8D+G+yYli7dwjWUK4g6qhi+baE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJAHpIQJZum+vWKlsFmddPxoBkzhHwwI9ukb2aFD01Vn61rpOdA/MUVP41uFL3Lc01OTCGOrrDnF4Bl9GJuApQXUYKloM46hxrZJSjLQo0tnErnqIvoMoMMNlCLAWznpEuP999NwfkX8k9VdUUTnXDBvlS2JL6EFTXi64r2ZT5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P3dbQSG2; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BctlVWcpMJbm+tdzqKDz5kiRgdKhoGQ6BEZ48/69Xp9FufbjI3onD7QzBYJjT6+hVBvKnCZqjvAgJat68yUZziQ48fqeA3R+MkaDmdzQEiMPmcIxH8PMPGqzDYlXpRGnRZR3fxviNItY+p62j1IorGgSzjPMsXBxNJMFGK4osWbDd7wiQ6CW3ZVWku6PtJMTdnOjZ0lsiv+kcimpW3TRQKYmpybPVsLXTKDbgvbYEX++CmYNHRdEC7fZyvtAkWADpnQKcnG6SxNvl2zBwhEVzoul1R5jtyx3FwxmZha4cEa0bmodDxAOUHF10KthDoxFR613+ueFQtRUoyRV7+Lnvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7vUJMo08twcBvlRueK35BpukrjnFFa4JM7WPGd6Eqo=;
 b=gr8+3zDDoBXK7wPHjD/FJ4fQ4w2z28OaK+/X7WWJmXcK5Yupnd2cXfrbYcpn14OsLvkDUatevwE3j0K13si11wp0Iu7JJpFaOfvTFD7qOXuW2Fk5g5YVVqLjtpNsYc6XW9be9vgqIOJhtA7zumVCHRtQuxrnw/uCJ1PnYDRXOrK4bTAu4Th6fJAZ9GeZUuMgteGgveD9qVo/suABaE0Q+pUZn5eec3WvBRgBICx5gUSemzVMCtGTXsfYIsSgirkNHp36mwTpmdkAkmqrcivnClk8q0rPUNn2rjI1Sf5Crvz2jq/JXKF34y9Zm5FouqHR52EdaDPw0eU1sMfuK/VRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7vUJMo08twcBvlRueK35BpukrjnFFa4JM7WPGd6Eqo=;
 b=P3dbQSG2DBpuAc1+J2GTV3VBK5aFY5HUzh8VIgFC0gmPty7+/SFu6O0HhYm9znUfRqeFcS0L3qZxvWrX/oN7/woe2xqXQXm4LNZpF3K3S5gRPgJ6mCIGDRNAVNCBP4ECbPSsYxuVM8RAObpklgx2Q/moEHyMZoEJVAZdgTTEuRM=
Received: from MN2PR05CA0056.namprd05.prod.outlook.com (2603:10b6:208:236::25)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Thu, 24 Apr
 2025 13:21:28 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:236:cafe::e1) by MN2PR05CA0056.outlook.office365.com
 (2603:10b6:208:236::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Thu,
 24 Apr 2025 13:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.1 via Frontend Transport; Thu, 24 Apr 2025 13:21:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:21:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:21:27 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 24 Apr 2025 08:21:23 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <ptsm@linux.microsoft.com>, <srivatsa@csail.mit.edu>,
	<shubhrajyoti.datta@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH v6 1/6] cdx: add the cdx headers to include/linux
Date: Thu, 24 Apr 2025 18:51:13 +0530
Message-ID: <20250424132118.17074-2-shubhrajyoti.datta@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bbb2d3-bcfd-436b-c9c2-08dd8332ec17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YIRjnMfCaGjqJ/U5w4BLWWzlTdhyaVNzvD+hFqNUBZTLGHTshU9jWhjNnZNa?=
 =?us-ascii?Q?YLbxR3vs+iwftjHsMondRePH3rk6G/vDB3aSI2XRO8gWtQ5MhUwqbXaFRm4+?=
 =?us-ascii?Q?cAsZBGSyDJIWMiPMIoclouWRXIXcxQztple8+kSH5jb9FdermS71GIEj61Ab?=
 =?us-ascii?Q?RgBZNMhY3Xj5VCUC0vx3JJwD3PNMk8jUfYZTtVynS7bvIvfCUXHYPwr0byjL?=
 =?us-ascii?Q?7iKec6nlpi2t6oivMcpqyhpZsr3DkWFsjWHjkikb3zenLmhqTK9DsT+N4yIi?=
 =?us-ascii?Q?qbvsVOFbrArrVifUaMszjelFzUXuO3vqLuggszECDvMb3SOGTe1lLTjvh2DV?=
 =?us-ascii?Q?wmgrrzxYLjDKJtDcbdJeSPNgZl+4Zv43R0ZV7l1XnxwO0ysBZJUuzeAmSWDj?=
 =?us-ascii?Q?FsdhPnKixYxUWIHyEski7UpDftC/UUOOU49UdtovJYk/Pc4OTnTrLivbM1k8?=
 =?us-ascii?Q?fCHEqTfTOz/1Y9ao3vQue4naqW4QVEog5nT8mfVda//lq6nagtBnqDacVbVr?=
 =?us-ascii?Q?qbYC82AKpnR0GRt9P6tcH5qzZ1K3M9e0JJj4PzEHXXm6Gc7OSeTDoGYPOwN3?=
 =?us-ascii?Q?Tq34NVDE83eww4CKHgVBzpAcBQowukHP7xOZKnUeLi9jX8/QMDSCAOXkleGM?=
 =?us-ascii?Q?eApsPiwNgBehcvSX3wPWjQEy7gCjP+fHdUpfOTXC2AEoKeFpNEmcn+CFSDat?=
 =?us-ascii?Q?fyQ9AiR9evwvWEZ3mG5u2WKsnC8+81C8e4y9HEy5/KtQZty5JoMuLg/nqMyk?=
 =?us-ascii?Q?ZwJdVZ3b0eWtfeSmHerbw+ZzOm5PTjle2IWf8EeMHRfNjint6LgDf9L10DOz?=
 =?us-ascii?Q?U0iOEzLad44F+p5xZyUrVr2Ds4z8VO5R1S8x/niRJIXYe2oSNmAzdIwb7SwR?=
 =?us-ascii?Q?MD7irCRiZCDnvqVNggfAneM1XOAXIXW1behSs+tC9hAsEHDOxD2Gvsc5Tlbf?=
 =?us-ascii?Q?h1n6ez8YcRqfQ15M1/2K1DKieIE/VMq4HeRO9jeLfXx2bhFJfaw9J9N7js6U?=
 =?us-ascii?Q?A3sMTl02ofyb9uyqkNnLTIMzb0A0JSiWE7OYlyyqYAjCLmOZmIAZWffq8XwU?=
 =?us-ascii?Q?47Z/QWLZcApUSTmIV4G+eznA/obagsUpPUS502cEbK2irvKSq+t/E9tJUJMC?=
 =?us-ascii?Q?7LuPEZ0i7GxcZw8BBcSdhWK8J1ZDbj8tHZOW0t27mC6hUSqKZBxB8p43H9zP?=
 =?us-ascii?Q?39jp7tS9gbl0Fe2IRZ2Lk5fYW40xsHTiyhAL5oe5jhTB51iX8Eo3H1j9Ob9t?=
 =?us-ascii?Q?VTNRvnZm8Jbi/JiOdvy/2r/8RAKIcId96C0L79Vbmkk39QOz5R+2FzvbkO52?=
 =?us-ascii?Q?8LzDYlReqWEeynjcsdsNcrXT5ejJiKwl4TBU1X4Rq9mgkmu8UwYifyzZtg19?=
 =?us-ascii?Q?iVOIBezfXP9QSmwtoozyI5oFdA7tyxlKtpLiM4r1snM0XGKDjK5KyJ0xGiup?=
 =?us-ascii?Q?p5Hh98rSzkzhF+majtbZBMjMVLiz0V5NqKbB1qLFZmTfK52UV4f2cA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 13:21:28.8634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bbb2d3-bcfd-436b-c9c2-08dd8332ec17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125

Move the header files from driver/cdx to the include/linux.
Adding the protocol, mcdi and bitfield header file to
include/linux. This is in preparation for VersalNET EDAC
driver that relies on it.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v6:
 - Patch added
This patch is compile tested.

 drivers/cdx/controller/cdx_controller.c                       | 1 -
 drivers/cdx/controller/cdx_rpmsg.c                            | 1 -
 drivers/cdx/controller/mcdi.c                                 | 4 +---
 drivers/cdx/controller/mcdi_functions.c                       | 1 -
 drivers/cdx/controller/mcdi_functions.h                       | 2 +-
 .../cdx/controller/bitfield.h => include/linux/mc_bitfield.h  | 0
 {drivers/cdx/controller => include/linux}/mc_cdx_pcol.h       | 0
 {drivers/cdx/controller => include/linux}/mcdi.h              | 4 ++--
 8 files changed, 4 insertions(+), 9 deletions(-)
 rename drivers/cdx/controller/bitfield.h => include/linux/mc_bitfield.h (100%)
 rename {drivers/cdx/controller => include/linux}/mc_cdx_pcol.h (100%)
 rename {drivers/cdx/controller => include/linux}/mcdi.h (99%)

diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index d623f9c7517a..4676adcef010 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -14,7 +14,6 @@
 #include "cdx_controller.h"
 #include "../cdx.h"
 #include "mcdi_functions.h"
-#include "mcdi.h"
 
 static unsigned int cdx_mcdi_rpc_timeout(struct cdx_mcdi *cdx, unsigned int cmd)
 {
diff --git a/drivers/cdx/controller/cdx_rpmsg.c b/drivers/cdx/controller/cdx_rpmsg.c
index 04b578a0be17..ad4a4602b367 100644
--- a/drivers/cdx/controller/cdx_rpmsg.c
+++ b/drivers/cdx/controller/cdx_rpmsg.c
@@ -15,7 +15,6 @@
 #include "../cdx.h"
 #include "cdx_controller.h"
 #include "mcdi_functions.h"
-#include "mcdi.h"
 
 static struct rpmsg_device_id cdx_rpmsg_id_table[] = {
 	{ .name = "mcdi_ipc" },
diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index e760f8d347cc..600084e81a86 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -23,9 +23,7 @@
 #include <linux/log2.h>
 #include <linux/net_tstamp.h>
 #include <linux/wait.h>
-
-#include "bitfield.h"
-#include "mcdi.h"
+#include "linux/mcdi.h"
 
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
index b9942affdc6b..1b503f42dc40 100644
--- a/drivers/cdx/controller/mcdi_functions.h
+++ b/drivers/cdx/controller/mcdi_functions.h
@@ -8,7 +8,7 @@
 #ifndef CDX_MCDI_FUNCTIONS_H
 #define CDX_MCDI_FUNCTIONS_H
 
-#include "mcdi.h"
+#include "linux/mcdi.h"
 #include "../cdx.h"
 
 /**
diff --git a/drivers/cdx/controller/bitfield.h b/include/linux/mc_bitfield.h
similarity index 100%
rename from drivers/cdx/controller/bitfield.h
rename to include/linux/mc_bitfield.h
diff --git a/drivers/cdx/controller/mc_cdx_pcol.h b/include/linux/mc_cdx_pcol.h
similarity index 100%
rename from drivers/cdx/controller/mc_cdx_pcol.h
rename to include/linux/mc_cdx_pcol.h
diff --git a/drivers/cdx/controller/mcdi.h b/include/linux/mcdi.h
similarity index 99%
rename from drivers/cdx/controller/mcdi.h
rename to include/linux/mcdi.h
index 54a65e9760ae..abe691a501dd 100644
--- a/drivers/cdx/controller/mcdi.h
+++ b/include/linux/mcdi.h
@@ -11,8 +11,8 @@
 #include <linux/kref.h>
 #include <linux/rpmsg.h>
 
-#include "bitfield.h"
-#include "mc_cdx_pcol.h"
+#include "linux/mc_bitfield.h"
+#include "linux/mc_cdx_pcol.h"
 
 #ifdef DEBUG
 #define CDX_WARN_ON_ONCE_PARANOID(x) WARN_ON_ONCE(x)
-- 
2.17.1


