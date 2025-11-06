Return-Path: <linux-edac+bounces-5354-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7341DC38C59
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 02:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D20774EEA31
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 01:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3478922A4DB;
	Thu,  6 Nov 2025 01:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mbIGtQ4e"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF701225A3B;
	Thu,  6 Nov 2025 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394314; cv=fail; b=RAMtNzkZXae7E/L4M1AjKB1WGtRn5d3gQtGTWavoh2nxH7ZiCiqzwshSSUXfSQPnq3DTORblEuhF58/nAQz5YbKd5THLloNN2eIadlyFCXYaN9XLXY2v2wjEjTID8CPszRohva84OslQeQ2/6hTtBE2roxx5TzYuS6bX5TGb+Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394314; c=relaxed/simple;
	bh=NfhaJG9ii6Uaft/bLorOB+BxKSIQaMoOVknenMkHorI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1JqrlyhQYedgraqq47vjBP43wOKv14yhPgVf3VJgM+ckrUKTha54fJ/haNsV4ZeCp1LAOapfVSBS5jgtZRzg/HrJTp6eLPAkQh5D3p7kNkSGgVD+Cj2BaKXoRP3Dl60hqsB39hcJbDkMtGZNxpdrbs5m0+bOXY9rBBVs/QETe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mbIGtQ4e; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1hagYw0XOnxXGKAAshYxg587WWzCtgs8K/5BEEAXe/wSSFpHNLgwQwOKRiHkv1Hl9xv4XQAc7ZJCfyyudnocpRyCyT7Dl5j3wQavM3607lMoDK+C1yrceuIMWCeANwUhOsahkzPoJt1I3mlESuxGlXn/nbEv/HDl7PWBypwVZ7XVvaWBmI4tWyG2xeT659TqHWpe/i0oQtBdcmW5DGR4/DVDf6vrWAaltm1+y1vygV7NldtLaW07OJPCNpYTGWV6YibhQLy9gwW4kxITWpvN6Y7KHPUfwahaYCW1v95dH3ZljtVE3q1jHjVhVIB2labqqG8pMyGw/m5dI7xgWM0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKYQMoic+eCO+qq/0uxqKeDYa9UKDe5NjU1JQoV+15A=;
 b=S9Q3wXq9yH66wdm6TRzOoBbp4XK+TPB7JXVL/dl93E1+eyPjv6VZtTVqnwiXo+7NJgIya5nJWsrjZ9dOVDaVNvChjWmyRFG8ZUPQXjhKqBenoeO4/uEftqj4bGinNsampbrpSCnx+8iDfbXEi5LHZqMnvolTFV4JWIt/nhyi1t9y6gZrUqJii0IH8uD2FegUHOU7x5xXo2/lai06HRp30lI7pRgN7eAeq8W4TE6eH3XHQi3vOH8ZFYrEw56yKOglqvkrMt9ae2Nj1jG0pIWBpugdvlmkv9D3T0NUPH51hloL0wV8Ks/D+8uq1Ee6rqAsxjx5qhf1wPuGpEqTgmFwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKYQMoic+eCO+qq/0uxqKeDYa9UKDe5NjU1JQoV+15A=;
 b=mbIGtQ4e/5/0r1X/iWphcjit0vkfr7MMksBNJsewspfQCQzAp0llwkcUO3MXcHnrzROf7cVn6NAXZoVjhDldC5wFg4vlEW4aRhTaRWUwzJ0QV1kNeKcoM3/pnBEqNSrrf8IhHzWan1gcbbhS1+dRYD36c97/yacpEe6/4kRs9HU=
Received: from BY5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:1d0::17)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 01:58:23 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::cc) by BY5PR04CA0007.outlook.office365.com
 (2603:10b6:a03:1d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 01:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 01:58:23 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 5 Nov 2025 17:58:11 -0800
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <bp@alien8.de>, <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
	<chenhuacai@kernel.org>, <mchehab+huawei@kernel.org>,
	<yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH v2 3/3] edac: Remove the legacy EDAC sysfs interface
Date: Thu, 6 Nov 2025 01:54:46 +0000
Message-ID: <20251106015727.1987246-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106015727.1987246-1-avadhut.naik@amd.com>
References: <20251106015727.1987246-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: de9c5318-eaf2-4e6b-071b-08de1cd7f7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|30052699003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WWT7tyiPC/bNPAnvi1NTTuEhuMbHVZkMFhc7daM98QmWSbYz9Lob6dparD5I?=
 =?us-ascii?Q?6JOlzvRkzYT1tByUUqhlyfgKux/HwQhrajsVcSsWlMzaLHi/zWrUaFmzGPH+?=
 =?us-ascii?Q?RuUPgRPuylMVDqjdhxaLZK6XJmgMTZdynwwPiGltCUKjWYKFm4w/S2FQCoKo?=
 =?us-ascii?Q?yTzV5zMxuMMucmfpZbhRmutNPs13a+kBK0zHV+VAzgi276TRuYGQm5iohig5?=
 =?us-ascii?Q?s5zmdFFRLtYIeUS/1vo9TwYUgsxeCGpulZBb7Y3ZJX5hw8+H5p0nuig2VeOM?=
 =?us-ascii?Q?RLOb//mDNP14NvVs0ye+PCwcnsnLBeRrLHTwMcbE2Xd7KSWz/EpAxatwG3Eh?=
 =?us-ascii?Q?DBxVm+PSIlCR0meSpQcKacVaVEjkrb4whvbp5HF2cyqDYSDYlc6zhA2QNiew?=
 =?us-ascii?Q?p9vBgJS2atqzMOXoyigFNg/oChs7l9hstFDwcLtF/0z9eXr1h5gvyCsDKPlG?=
 =?us-ascii?Q?1TpA4+2qp9UQt0EP1F+TKrtjlKw06HfuxMOTWIfWybHYDLVU8mFqyho6M4BD?=
 =?us-ascii?Q?9P47UqH25nQAkGZjYuRrw6h92Jm5K4EdKNx7r3NGOVNdNILJqn7W5wVXGbpI?=
 =?us-ascii?Q?yU99PZirvzu74u0BABFjMBJ5eRX9i4XBOo2BU0KEjSu2XsCUT3FPipwZw6Tj?=
 =?us-ascii?Q?/KH2zIbzxXbUzuHV7XeoRfwBWcuLWJPOkHAuBmBIvyQpc0skdrqkUgevIJ77?=
 =?us-ascii?Q?0YXfMwlyY4YbQPU9L0abfO7PSNNOQommS31dOkacPugQOa0ufYsLq/oxUHdp?=
 =?us-ascii?Q?9pCuAOj/We79yPXw5onX9ZURQpGHBcwvFn6vvbGaUjJShF5XZqV2hm9A639I?=
 =?us-ascii?Q?SvPQop+5vV4IaYc2AyNtCNiKNvHWRM9yZ0RkjBXMDn/jkJF/8EpiHr6BnNtB?=
 =?us-ascii?Q?BBhVxIUEg+w96M4w0V6jcyEQULrzglZAc+TrA1h99a1/U5LGnYQj1rBHUAF8?=
 =?us-ascii?Q?0GixfnJT613T/8X9Qrp8P2M0AyQx+jnOzdkrt4YDxi+ko2ypn2737vY8qhh+?=
 =?us-ascii?Q?Iunad1/9/Iu/ZSo6VLtYvkjTkZfs8GUu2u7rljFmQ8vWfR1nus4yaMbqzn76?=
 =?us-ascii?Q?Y8+ADpnkqYQTaqZ6LtEVUB9uh4tAiLCUSfnHcdz/mkMC3/WTxEoSCJg4+WBT?=
 =?us-ascii?Q?PXeXCYv7aFRrLXW06YjkZ9gHB3DVyi4jON6WUhglvN+fC7O/sjn2802BtkcU?=
 =?us-ascii?Q?wlIzGoCMPSvriEL8qve1LTECHiNTUiSkQy6JURrUQJH3XSRTJ4TQeg8iLNI6?=
 =?us-ascii?Q?nn2D7g0M6YimJeB7GHvGbDJ7NtuFPOV0rFUKgU6XXOm6LVp54J5v6eOiEbvU?=
 =?us-ascii?Q?7n5jf6v8a8FoLEI2MQ+wLMna4xobzlf4ZVG6chNrDHqWR5nEWKY6+GlS76vP?=
 =?us-ascii?Q?dMYRGp0uks6o+XHSElOqa02HquflTuP4PA4N0TkmZwHWnjLGWtgbN43DlotY?=
 =?us-ascii?Q?4sdC3zi2hq1YUpBvne2+1mDR4TV/IZfH+mA6zI/3ma6ZLTKO64UyFiuYRFab?=
 =?us-ascii?Q?0ZfKHJruO/3i7K/FzTSm6viwLKiqPox5EuNjahqy/3nkxDiHQlsbbWjj+kFA?=
 =?us-ascii?Q?mmUpJAsidg4AcWgM6WE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(30052699003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 01:58:23.1951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de9c5318-eaf2-4e6b-071b-08de1cd7f7c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083

Commit 199747106934 ("edac: add a new per-dimm API and make the old
per-virtual-rank API obsolete") introduced a new per-dimm sysfs interface
for EDAC making the old per-virtual-rank sysfs interface obsolete.

Since this new sysfs interface was introduced more than a decade ago,
remove the obsolete legacy interface.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 Documentation/admin-guide/RAS/main.rst     | 142 +-------
 arch/loongarch/configs/loongson3_defconfig |   1 -
 drivers/edac/Kconfig                       |   8 -
 drivers/edac/edac_mc_sysfs.c               | 404 ---------------------
 4 files changed, 3 insertions(+), 552 deletions(-)

diff --git a/Documentation/admin-guide/RAS/main.rst b/Documentation/admin-guide/RAS/main.rst
index 447bfde509fb..5a45db32c49b 100644
--- a/Documentation/admin-guide/RAS/main.rst
+++ b/Documentation/admin-guide/RAS/main.rst
@@ -406,24 +406,8 @@ index of the MC::
 		   |->mc2
 		   ....
 
-Under each ``mcX`` directory each ``csrowX`` is again represented by a
-``csrowX``, where ``X`` is the csrow index::
-
-	.../mc/mc0/
-		|
-		|->csrow0
-		|->csrow2
-		|->csrow3
-		....
-
-Notice that there is no csrow1, which indicates that csrow0 is composed
-of a single ranked DIMMs. This should also apply in both Channels, in
-order to have dual-channel mode be operational. Since both csrow2 and
-csrow3 are populated, this indicates a dual ranked set of DIMMs for
-channels 0 and 1.
-
-Within each of the ``mcX`` and ``csrowX`` directories are several EDAC
-control and attribute files.
+Within each of the ``mcX`` directory are several EDAC control and
+attribute files.
 
 ``mcX`` directories
 -------------------
@@ -569,7 +553,7 @@ this ``X`` memory module:
 		- Unbuffered-DDR
 
 .. [#f5] On some systems, the memory controller doesn't have any logic
-  to identify the memory module. On such systems, the directory is called ``rankX`` and works on a similar way as the ``csrowX`` directories.
+  to identify the memory module. On such systems, the directory is called ``rankX``.
   On modern Intel memory controllers, the memory controller identifies the
   memory modules directly. On such systems, the directory is called ``dimmX``.
 
@@ -577,126 +561,6 @@ this ``X`` memory module:
   symlinks inside the sysfs mapping that are automatically created by
   the sysfs subsystem. Currently, they serve no purpose.
 
-``csrowX`` directories
-----------------------
-
-When CONFIG_EDAC_LEGACY_SYSFS is enabled, sysfs will contain the ``csrowX``
-directories. As this API doesn't work properly for Rambus, FB-DIMMs and
-modern Intel Memory Controllers, this is being deprecated in favor of
-``dimmX`` directories.
-
-In the ``csrowX`` directories are EDAC control and attribute files for
-this ``X`` instance of csrow:
-
-
-- ``ue_count`` - Total Uncorrectable Errors count attribute file
-
-	This attribute file displays the total count of uncorrectable
-	errors that have occurred on this csrow. If panic_on_ue is set
-	this counter will not have a chance to increment, since EDAC
-	will panic the system.
-
-
-- ``ce_count`` - Total Correctable Errors count attribute file
-
-	This attribute file displays the total count of correctable
-	errors that have occurred on this csrow. This count is very
-	important to examine. CEs provide early indications that a
-	DIMM is beginning to fail. This count field should be
-	monitored for non-zero values and report such information
-	to the system administrator.
-
-
-- ``size_mb`` - Total memory managed by this csrow attribute file
-
-	This attribute file displays, in count of megabytes, the memory
-	that this csrow contains.
-
-
-- ``mem_type`` - Memory Type attribute file
-
-	This attribute file will display what type of memory is currently
-	on this csrow. Normally, either buffered or unbuffered memory.
-	Examples:
-
-		- Registered-DDR
-		- Unbuffered-DDR
-
-
-- ``edac_mode`` - EDAC Mode of operation attribute file
-
-	This attribute file will display what type of Error detection
-	and correction is being utilized.
-
-
-- ``dev_type`` - Device type attribute file
-
-	This attribute file will display what type of DRAM device is
-	being utilized on this DIMM.
-	Examples:
-
-		- x1
-		- x2
-		- x4
-		- x8
-
-
-- ``ch0_ce_count`` - Channel 0 CE Count attribute file
-
-	This attribute file will display the count of CEs on this
-	DIMM located in channel 0.
-
-
-- ``ch0_ue_count`` - Channel 0 UE Count attribute file
-
-	This attribute file will display the count of UEs on this
-	DIMM located in channel 0.
-
-
-- ``ch0_dimm_label`` - Channel 0 DIMM Label control file
-
-
-	This control file allows this DIMM to have a label assigned
-	to it. With this label in the module, when errors occur
-	the output can provide the DIMM label in the system log.
-	This becomes vital for panic events to isolate the
-	cause of the UE event.
-
-	DIMM Labels must be assigned after booting, with information
-	that correctly identifies the physical slot with its
-	silk screen label. This information is currently very
-	motherboard specific and determination of this information
-	must occur in userland at this time.
-
-
-- ``ch1_ce_count`` - Channel 1 CE Count attribute file
-
-
-	This attribute file will display the count of CEs on this
-	DIMM located in channel 1.
-
-
-- ``ch1_ue_count`` - Channel 1 UE Count attribute file
-
-
-	This attribute file will display the count of UEs on this
-	DIMM located in channel 0.
-
-
-- ``ch1_dimm_label`` - Channel 1 DIMM Label control file
-
-	This control file allows this DIMM to have a label assigned
-	to it. With this label in the module, when errors occur
-	the output can provide the DIMM label in the system log.
-	This becomes vital for panic events to isolate the
-	cause of the UE event.
-
-	DIMM Labels must be assigned after booting, with information
-	that correctly identifies the physical slot with its
-	silk screen label. This information is currently very
-	motherboard specific and determination of this information
-	must occur in userland at this time.
-
 
 System Logging
 --------------
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 3e838c229cd5..50e1304e7a6f 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -917,7 +917,6 @@ CONFIG_MMC=y
 CONFIG_MMC_LOONGSON2=m
 CONFIG_INFINIBAND=m
 CONFIG_EDAC=y
-# CONFIG_EDAC_LEGACY_SYSFS is not set
 CONFIG_EDAC_LOONGSON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 39352b9b7a7e..9a7ff42064e9 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -23,14 +23,6 @@ menuconfig EDAC
 
 if EDAC
 
-config EDAC_LEGACY_SYSFS
-	bool "EDAC legacy sysfs"
-	default y
-	help
-	  Enable the compatibility sysfs nodes.
-	  Use 'Y' if your edac utilities aren't ported to work with the newer
-	  structures.
-
 config EDAC_DEBUG
 	bool "Debugging"
 	select DEBUG_FS
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 8689631f1905..091cc6aae8a9 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -115,401 +115,6 @@ static const char * const edac_caps[] = {
 	[EDAC_S16ECD16ED] = "S16ECD16ED"
 };
 
-#ifdef CONFIG_EDAC_LEGACY_SYSFS
-/*
- * EDAC sysfs CSROW data structures and methods
- */
-
-#define to_csrow(k) container_of(k, struct csrow_info, dev)
-
-/*
- * We need it to avoid namespace conflicts between the legacy API
- * and the per-dimm/per-rank one
- */
-#define DEVICE_ATTR_LEGACY(_name, _mode, _show, _store) \
-	static struct device_attribute dev_attr_legacy_##_name = __ATTR(_name, _mode, _show, _store)
-
-struct dev_ch_attribute {
-	struct device_attribute attr;
-	unsigned int channel;
-};
-
-#define DEVICE_CHANNEL(_name, _mode, _show, _store, _var) \
-	static struct dev_ch_attribute dev_attr_legacy_##_name = \
-		{ __ATTR(_name, _mode, _show, _store), (_var) }
-
-#define to_channel(k) (container_of(k, struct dev_ch_attribute, attr)->channel)
-
-/* Set of more default csrow<id> attribute show/store functions */
-static ssize_t csrow_ue_count_show(struct device *dev,
-				   struct device_attribute *mattr, char *data)
-{
-	struct csrow_info *csrow = to_csrow(dev);
-
-	return sysfs_emit(data, "%u\n", csrow->ue_count);
-}
-
-static ssize_t csrow_ce_count_show(struct device *dev,
-				   struct device_attribute *mattr, char *data)
-{
-	struct csrow_info *csrow = to_csrow(dev);
-
-	return sysfs_emit(data, "%u\n", csrow->ce_count);
-}
-
-static ssize_t csrow_size_show(struct device *dev,
-			       struct device_attribute *mattr, char *data)
-{
-	struct csrow_info *csrow = to_csrow(dev);
-	int i;
-	u32 nr_pages = 0;
-
-	for (i = 0; i < csrow->nr_channels; i++)
-		nr_pages += csrow->channels[i]->dimm->nr_pages;
-	return sysfs_emit(data, "%u\n", PAGES_TO_MiB(nr_pages));
-}
-
-static ssize_t csrow_mem_type_show(struct device *dev,
-				   struct device_attribute *mattr, char *data)
-{
-	struct csrow_info *csrow = to_csrow(dev);
-
-	return sysfs_emit(data, "%s\n", edac_mem_types[csrow->channels[0]->dimm->mtype]);
-}
-
-static ssize_t csrow_dev_type_show(struct device *dev,
-				   struct device_attribute *mattr, char *data)
-{
-	struct csrow_info *csrow = to_csrow(dev);
-
-	return sysfs_emit(data, "%s\n", dev_types[csrow->channels[0]->dimm->dtype]);
-}
-
-static ssize_t csrow_edac_mode_show(struct device *dev,
-				    struct device_attribute *mattr,
-				    char *data)
-{
-	struct csrow_info *csrow = to_csrow(dev);
-
-	return sysfs_emit(data, "%s\n", edac_caps[csrow->channels[0]->dimm->edac_mode]);
-}
-
-/* show/store functions for DIMM Label attributes */
-static ssize_t channel_dimm_label_show(struct device *dev,
-				       struct device_attribute *mattr,
-				       char *data)
-{
-	struct csrow_info *csrow = to_csrow(dev);
-	unsigned int chan = to_channel(mattr);
-	struct rank_info *rank = csrow->channels[chan];
-
-	/* if field has not been initialized, there is nothing to send */
-	if (!rank->dimm->label[0])
-		return 0;
-
-	return sysfs_emit(data, "%s\n", rank->dimm->label);
-}
-
-static ssize_t channel_dimm_label_store(struct device *dev,
-					struct device_attribute *mattr,
-					const char *data, size_t count)
-{
-	struct csrow_info *csrow = to_csrow(dev);
-	unsigned int chan = to_channel(mattr);
-	struct rank_info *rank = csrow->channels[chan];
-	size_t copy_count = count;
-
-	if (count == 0)
-		return -EINVAL;
-
-	if (data[count - 1] == '\0' || data[count - 1] == '\n')
-		copy_count -= 1;
-
-	if (copy_count == 0 || copy_count >= sizeof(rank->dimm->label))
-		return -EINVAL;
-
-	memcpy(rank->dimm->label, data, copy_count);
-	rank->dimm->label[copy_count] = '\0';
-
-	return count;
-}
-
-/* show function for dynamic chX_ce_count attribute */
-static ssize_t channel_ce_count_show(struct device *dev,
-				     struct device_attribute *mattr, char *data)
-{
-	struct csrow_info *csrow = to_csrow(dev);
-	unsigned int chan = to_channel(mattr);
-	struct rank_info *rank = csrow->channels[chan];
-
-	return sysfs_emit(data, "%u\n", rank->ce_count);
-}
-
-/* cwrow<id>/attribute files */
-DEVICE_ATTR_LEGACY(size_mb, S_IRUGO, csrow_size_show, NULL);
-DEVICE_ATTR_LEGACY(dev_type, S_IRUGO, csrow_dev_type_show, NULL);
-DEVICE_ATTR_LEGACY(mem_type, S_IRUGO, csrow_mem_type_show, NULL);
-DEVICE_ATTR_LEGACY(edac_mode, S_IRUGO, csrow_edac_mode_show, NULL);
-DEVICE_ATTR_LEGACY(ue_count, S_IRUGO, csrow_ue_count_show, NULL);
-DEVICE_ATTR_LEGACY(ce_count, S_IRUGO, csrow_ce_count_show, NULL);
-
-/* default attributes of the CSROW<id> object */
-static struct attribute *csrow_attrs[] = {
-	&dev_attr_legacy_dev_type.attr,
-	&dev_attr_legacy_mem_type.attr,
-	&dev_attr_legacy_edac_mode.attr,
-	&dev_attr_legacy_size_mb.attr,
-	&dev_attr_legacy_ue_count.attr,
-	&dev_attr_legacy_ce_count.attr,
-	NULL,
-};
-
-static const struct attribute_group csrow_attr_grp = {
-	.attrs	= csrow_attrs,
-};
-
-static const struct attribute_group *csrow_attr_groups[] = {
-	&csrow_attr_grp,
-	NULL
-};
-
-static const struct device_type csrow_attr_type = {
-	.groups		= csrow_attr_groups,
-};
-
-/*
- * possible dynamic channel DIMM Label attribute files
- *
- */
-DEVICE_CHANNEL(ch0_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 0);
-DEVICE_CHANNEL(ch1_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 1);
-DEVICE_CHANNEL(ch2_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 2);
-DEVICE_CHANNEL(ch3_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 3);
-DEVICE_CHANNEL(ch4_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 4);
-DEVICE_CHANNEL(ch5_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 5);
-DEVICE_CHANNEL(ch6_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 6);
-DEVICE_CHANNEL(ch7_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 7);
-DEVICE_CHANNEL(ch8_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 8);
-DEVICE_CHANNEL(ch9_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 9);
-DEVICE_CHANNEL(ch10_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 10);
-DEVICE_CHANNEL(ch11_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 11);
-DEVICE_CHANNEL(ch12_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 12);
-DEVICE_CHANNEL(ch13_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 13);
-DEVICE_CHANNEL(ch14_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 14);
-DEVICE_CHANNEL(ch15_dimm_label, S_IRUGO | S_IWUSR,
-	channel_dimm_label_show, channel_dimm_label_store, 15);
-
-/* Total possible dynamic DIMM Label attribute file table */
-static struct attribute *dynamic_csrow_dimm_attr[] = {
-	&dev_attr_legacy_ch0_dimm_label.attr.attr,
-	&dev_attr_legacy_ch1_dimm_label.attr.attr,
-	&dev_attr_legacy_ch2_dimm_label.attr.attr,
-	&dev_attr_legacy_ch3_dimm_label.attr.attr,
-	&dev_attr_legacy_ch4_dimm_label.attr.attr,
-	&dev_attr_legacy_ch5_dimm_label.attr.attr,
-	&dev_attr_legacy_ch6_dimm_label.attr.attr,
-	&dev_attr_legacy_ch7_dimm_label.attr.attr,
-	&dev_attr_legacy_ch8_dimm_label.attr.attr,
-	&dev_attr_legacy_ch9_dimm_label.attr.attr,
-	&dev_attr_legacy_ch10_dimm_label.attr.attr,
-	&dev_attr_legacy_ch11_dimm_label.attr.attr,
-	&dev_attr_legacy_ch12_dimm_label.attr.attr,
-	&dev_attr_legacy_ch13_dimm_label.attr.attr,
-	&dev_attr_legacy_ch14_dimm_label.attr.attr,
-	&dev_attr_legacy_ch15_dimm_label.attr.attr,
-	NULL
-};
-
-/* possible dynamic channel ce_count attribute files */
-DEVICE_CHANNEL(ch0_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 0);
-DEVICE_CHANNEL(ch1_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 1);
-DEVICE_CHANNEL(ch2_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 2);
-DEVICE_CHANNEL(ch3_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 3);
-DEVICE_CHANNEL(ch4_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 4);
-DEVICE_CHANNEL(ch5_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 5);
-DEVICE_CHANNEL(ch6_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 6);
-DEVICE_CHANNEL(ch7_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 7);
-DEVICE_CHANNEL(ch8_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 8);
-DEVICE_CHANNEL(ch9_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 9);
-DEVICE_CHANNEL(ch10_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 10);
-DEVICE_CHANNEL(ch11_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 11);
-DEVICE_CHANNEL(ch12_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 12);
-DEVICE_CHANNEL(ch13_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 13);
-DEVICE_CHANNEL(ch14_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 14);
-DEVICE_CHANNEL(ch15_ce_count, S_IRUGO,
-		   channel_ce_count_show, NULL, 15);
-
-/* Total possible dynamic ce_count attribute file table */
-static struct attribute *dynamic_csrow_ce_count_attr[] = {
-	&dev_attr_legacy_ch0_ce_count.attr.attr,
-	&dev_attr_legacy_ch1_ce_count.attr.attr,
-	&dev_attr_legacy_ch2_ce_count.attr.attr,
-	&dev_attr_legacy_ch3_ce_count.attr.attr,
-	&dev_attr_legacy_ch4_ce_count.attr.attr,
-	&dev_attr_legacy_ch5_ce_count.attr.attr,
-	&dev_attr_legacy_ch6_ce_count.attr.attr,
-	&dev_attr_legacy_ch7_ce_count.attr.attr,
-	&dev_attr_legacy_ch8_ce_count.attr.attr,
-	&dev_attr_legacy_ch9_ce_count.attr.attr,
-	&dev_attr_legacy_ch10_ce_count.attr.attr,
-	&dev_attr_legacy_ch11_ce_count.attr.attr,
-	&dev_attr_legacy_ch12_ce_count.attr.attr,
-	&dev_attr_legacy_ch13_ce_count.attr.attr,
-	&dev_attr_legacy_ch14_ce_count.attr.attr,
-	&dev_attr_legacy_ch15_ce_count.attr.attr,
-	NULL
-};
-
-static umode_t csrow_dev_is_visible(struct kobject *kobj,
-				    struct attribute *attr, int idx)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct csrow_info *csrow = container_of(dev, struct csrow_info, dev);
-
-	if (idx >= csrow->nr_channels)
-		return 0;
-
-	if (idx >= ARRAY_SIZE(dynamic_csrow_ce_count_attr) - 1) {
-		WARN_ONCE(1, "idx: %d\n", idx);
-		return 0;
-	}
-
-	/* Only expose populated DIMMs */
-	if (!csrow->channels[idx]->dimm->nr_pages)
-		return 0;
-
-	return attr->mode;
-}
-
-
-static const struct attribute_group csrow_dev_dimm_group = {
-	.attrs = dynamic_csrow_dimm_attr,
-	.is_visible = csrow_dev_is_visible,
-};
-
-static const struct attribute_group csrow_dev_ce_count_group = {
-	.attrs = dynamic_csrow_ce_count_attr,
-	.is_visible = csrow_dev_is_visible,
-};
-
-static const struct attribute_group *csrow_dev_groups[] = {
-	&csrow_dev_dimm_group,
-	&csrow_dev_ce_count_group,
-	NULL
-};
-
-static void csrow_release(struct device *dev)
-{
-	/*
-	 * Nothing to do, just unregister sysfs here. The mci
-	 * device owns the data and will also release it.
-	 */
-}
-
-static inline int nr_pages_per_csrow(struct csrow_info *csrow)
-{
-	int chan, nr_pages = 0;
-
-	for (chan = 0; chan < csrow->nr_channels; chan++)
-		nr_pages += csrow->channels[chan]->dimm->nr_pages;
-
-	return nr_pages;
-}
-
-/* Create a CSROW object under specified edac_mc_device */
-static int edac_create_csrow_object(struct mem_ctl_info *mci,
-				    struct csrow_info *csrow, int index)
-{
-	int err;
-
-	csrow->dev.type = &csrow_attr_type;
-	csrow->dev.groups = csrow_dev_groups;
-	csrow->dev.release = csrow_release;
-	device_initialize(&csrow->dev);
-	csrow->dev.parent = &mci->dev;
-	csrow->mci = mci;
-	dev_set_name(&csrow->dev, "csrow%d", index);
-	dev_set_drvdata(&csrow->dev, csrow);
-
-	err = device_add(&csrow->dev);
-	if (err) {
-		edac_dbg(1, "failure: create device %s\n", dev_name(&csrow->dev));
-		put_device(&csrow->dev);
-		return err;
-	}
-
-	edac_dbg(0, "device %s created\n", dev_name(&csrow->dev));
-
-	return 0;
-}
-
-/* Create a CSROW object under specified edac_mc_device */
-static int edac_create_csrow_objects(struct mem_ctl_info *mci)
-{
-	int err, i;
-	struct csrow_info *csrow;
-
-	for (i = 0; i < mci->nr_csrows; i++) {
-		csrow = mci->csrows[i];
-		if (!nr_pages_per_csrow(csrow))
-			continue;
-		err = edac_create_csrow_object(mci, mci->csrows[i], i);
-		if (err < 0)
-			goto error;
-	}
-	return 0;
-
-error:
-	for (--i; i >= 0; i--) {
-		if (device_is_registered(&mci->csrows[i]->dev))
-			device_unregister(&mci->csrows[i]->dev);
-	}
-
-	return err;
-}
-
-static void edac_delete_csrow_objects(struct mem_ctl_info *mci)
-{
-	int i;
-
-	for (i = 0; i < mci->nr_csrows; i++) {
-		if (device_is_registered(&mci->csrows[i]->dev))
-			device_unregister(&mci->csrows[i]->dev);
-	}
-}
-
-#endif
-
 /*
  * Per-dimm (or per-rank) devices
  */
@@ -989,12 +594,6 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 			goto fail;
 	}
 
-#ifdef CONFIG_EDAC_LEGACY_SYSFS
-	err = edac_create_csrow_objects(mci);
-	if (err < 0)
-		goto fail;
-#endif
-
 	edac_create_debugfs_nodes(mci);
 	return 0;
 
@@ -1019,9 +618,6 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
 #ifdef CONFIG_EDAC_DEBUG
 	edac_debugfs_remove_recursive(mci->debugfs);
 #endif
-#ifdef CONFIG_EDAC_LEGACY_SYSFS
-	edac_delete_csrow_objects(mci);
-#endif
 
 	mci_for_each_dimm(mci, dimm) {
 		if (!device_is_registered(&dimm->dev))
-- 
2.43.0


