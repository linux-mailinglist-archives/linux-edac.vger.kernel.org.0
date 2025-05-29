Return-Path: <linux-edac+bounces-4034-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A61B0AC7955
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 09:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AF39E739E
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 07:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F002571B9;
	Thu, 29 May 2025 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B6dak1Bu"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B321ABC2;
	Thu, 29 May 2025 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748502038; cv=fail; b=dXH+eMrqvgYTa8aBt23Z0WfkG3JeVGGK9A5e6fSjX36qXqNflti9hPZ5YgjxGy0dmUgP2GmDgL0ywhObrLrhnrLyHaat6zhAM1hMEfG+BIG1K8+gEq4kq15ReRHYtMMUh+89D02oZWSmPCLPcf/CbhRHKl6ZgAsfBbgB57WozCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748502038; c=relaxed/simple;
	bh=Zb4vFFeNNiQlESJ//tvai+WxYk/V9EcG5amDv9LQwEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgFvEMU9fou0mmnXGdHFSssaNBlSHVTEIIk6qxVIVIU01c1T51VUG9KhCG8GCpKz48XkZdIXbYrfK84jW3CSYovktk0QzYSVkyATcKDWm6vEfukmUKvMV1YcBbjjNLZOzqNAQxAOh58O5DKBzP6E624bN06ig9hnV/siolawi2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B6dak1Bu; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjONoKGXKhjN4UnTisMx5mfvOoU0VD3No33pXW/f/ShDZhzZAACCTgIaE5+nsZkbBWUhYv54xiMteiFGNYLTfZLYuqUaqspMYkg1OFTa3cx+0Tpj6Yohtn5L8lB7fCx5Y7H8uW1TRStMITjVv2MWSmrpgV4YF36SuGLvKiTxD20dOCE9mv8gRq5ewVhSUi6xtJ04DDapmo7u2EeWgNO4QQ1KPAtHsigQ+3tktqkvMnzFb8T4IvJCvZ3umwgW9N1eYQ9lVHH8/HD0oSbidD3SSElkD8Ju5Trio+H9TJ668/UbPG+c5A/5drYQIVPFH6wf/lZCcLDuVUCOrretK9K0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCoJ7lNZ16ANmJoEzXub9qTrBcen1lrpDjoNpXA4ZsM=;
 b=uT0l1YYkOLNNK6yZ1AUCF7RrEitJlxfRxaUNb+tf5w53WyCDAuZvQXmRyQ0pWZ2J5kveh120+wlXsQqIAIumaBbf6G5E58jkTFfRZerp7sOP6oPT3rdEZm6oN1Bcodt3uSMhvXJuQXtF89oQ1pZAXLTUidxLt59jtaiM6R/qQu0119B29TqlvNc3eaHCLvvXx+K2TP/9X7zwyRc9TmTQWlM8r54L0HwWF6dU9b+eWVcFOHFR+QxQhmONRGboJzClNMNY228z2P4ExQyH1uJfmQzzyBzSryUZzzhj6vL1u9XvAOFuEFHLJYsXFzC9JsdpLZiYLKH+HcMhABlMm18eEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCoJ7lNZ16ANmJoEzXub9qTrBcen1lrpDjoNpXA4ZsM=;
 b=B6dak1BuqHIExXDhCTkY3oBWvqSoX9rS1Kz5FtgtGGJD5UVidDV6T4F0Tc1xjEaz1sUwCJtLE6tM8FE7LdvwuOeknbRdyKW0HqO1vZnGYnfbcD/G6c6V940Fds2eVXZHEn92peJ7HI7Yq+NxTLEq2D9BDpm4tnsjYyzFSRZfSS4=
Received: from BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::24)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 07:00:32 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::2a) by BLAP220CA0019.outlook.office365.com
 (2603:10b6:208:32c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Thu,
 29 May 2025 07:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8813.0 via Frontend Transport; Thu, 29 May 2025 07:00:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 02:00:30 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 29 May 2025 02:00:26 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
	<nikhil.agarwal@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH v7 2/5] cdx: Export Symbols for MCDI RPC and Initialization
Date: Thu, 29 May 2025 12:30:14 +0530
Message-ID: <20250529070017.7288-3-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
References: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be74010-5d91-469c-2244-08dd9e7e80c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XUOYYSIQdf9dFnKYdwu1J7RMfTuFQz02hOkGd17oWfWmJ5RVq36dz2s1y/Dn?=
 =?us-ascii?Q?RR/C5cW0sJdOeFs2da24OZnE1wxLjYcB5Bvhqjdek5eFDZS74lnKz5rqozt9?=
 =?us-ascii?Q?hwJEHBhsEIXxi0bDfoDT0OMUu0obkxGsspThldsk1MC4sM1BETLLDMDv8Nev?=
 =?us-ascii?Q?oN47YugJkw9wo2gjlqUaf/V1QJtGalVTK4PfTDM4q54lArocSEGTZZXoXxuF?=
 =?us-ascii?Q?2ZIfvv2kX8iH0xuouFn7ZNVciQLRw7MbUSvCqB5SrhpC3aVFkrh3uaJGVxlv?=
 =?us-ascii?Q?H5jEUT06QVqpFMHskRCXyK/TL5YxiFLHWw3D09Xxx2w5clO+xIU47TDl6e7j?=
 =?us-ascii?Q?TEl4UBwQsOy4K6ReCKq/SHr//txuZnMvIaMpk4L3LDBc/JCenXgMzwJ5VYSq?=
 =?us-ascii?Q?9QFM/IYGB2TazqiBbghg4GazPkV1UcIHiZ0acHhuKpnqxy2LZF3kNmvwMO4S?=
 =?us-ascii?Q?d+a9j4cMAq4uMKAQNKDQQ10ilrBXTF02t3MAlGI/d2K+U/VXy1SGxawr3nuV?=
 =?us-ascii?Q?rCz1jySrOnbI0AHqxGcfgXdzNTGYlZUCEQXbvtkFYgm2sPJ8gKd5pawY+4cb?=
 =?us-ascii?Q?PjVj2Lw0yS+4Y/TpUptGHGkq8/+kijnMdRIUXncoLbBRmsTNiBgFcM6zNyuZ?=
 =?us-ascii?Q?GUdZHWy1scjWfxgyfGg6KPi3bH/pfJ995VRUUT8cOwVBNUWOvzfDcYw1HIvw?=
 =?us-ascii?Q?ofhp+IlcNzft0ABaze3mRq5vKu/LGnuXIvWYO8iYK9t8G8D8FFTPJgIYl2oh?=
 =?us-ascii?Q?y7CjpP2R85X/Kdh8lYpdJUgytSKmMvC7ukRgOJxBVBLz8hAcflzFynXCeDXO?=
 =?us-ascii?Q?1eB4bu9OOFFkkGHDbvi2doPB9XHLXrjX2jxMLTQhR7luMxm7Gi0SPKN7cGpU?=
 =?us-ascii?Q?JxwSn5Rfaw5n+GTOVGfKaMgOFSzPKQKV1c2wk7SHlBTeG8fiSH4udqx3lVlp?=
 =?us-ascii?Q?7oKuXqws19GZnCa1QtUKDhw6wN16LaXRM/mBZmXQM6306zzuN84EfP6g1aGR?=
 =?us-ascii?Q?IhL2VF8zHbBD2eQwIW/ZYakpdhe+PBQDiMLlhjjKgMna2qEvowQxJhTOJd4l?=
 =?us-ascii?Q?tX4h5SGdXG9FSyoU4VLKA5PgUfaSOYASAyy+Ch6aEWbuESwFpNqHEHZRxnR6?=
 =?us-ascii?Q?iMk73ta7B9vx7d/gFOdxHtGYOkKsbNxT+bYIXRWeN4kXxJ6dFegL6ozBcfCE?=
 =?us-ascii?Q?wNr4wq5fvppp6tfezvy/7Svu1M8tn4ZIujGCkUq2JtxdnMppcj2T/BMhZBxd?=
 =?us-ascii?Q?V/EVlbmxu4vaaOOCB3FGjp7wutYyWqgOaqUo0WmSB6edua1kn4VPdmJyh0bJ?=
 =?us-ascii?Q?+dsaEjvk6+W4bVF1tIQdDFhROiEMjuB0T5zVHxcNB6ApFktPK7kQCe1mkZTo?=
 =?us-ascii?Q?qIaamfxX+fK92YPgKBYNar8Sl0+/EKQCi8OsnkmTgP9EOlHW7zk2QdnpJK1+?=
 =?us-ascii?Q?YreBazh9Hef3AfCdPZY7HdVh8Q05EoHYt3ofLTazBXYEmm8EYZw4bEYe7qtY?=
 =?us-ascii?Q?AaxK0j0Sh8CnVt6S8er6vheh/gwXUwPnFhMl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 07:00:31.9591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be74010-5d91-469c-2244-08dd9e7e80c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527

The cdx_mcdi_init, cdx_mcdi_process_cmd, and cdx_mcdi_rpc functions are
needed by VersalNET EDAC modules that interact with the MCDI (Management
Controller Direct Interface) framework. These functions facilitate
communication between different hardware components by enabling command
execution and status management.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v7:
- Add the kernel doc description
- Add the prototype from first patch to here

Changes in v6:
- Update commit description

Changes in v2:
- Export the symbols for module compilation

 drivers/cdx/controller/mcdi.c | 29 +++++++++++++++++++++++++++++
 include/linux/cdx/mcdi.h      |  6 ++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index e760f8d347cc..f3cca4c884ff 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -99,6 +99,19 @@ static unsigned long cdx_mcdi_rpc_timeout(struct cdx_mcdi *cdx, unsigned int cmd
 		return cdx->mcdi_ops->mcdi_rpc_timeout(cdx, cmd);
 }
 
+/**
+ * cdx_mcdi_init - Initialize MCDI (Management Controller Driver Interface) state
+ * @cdx: NIC through which to issue the command
+ *
+ * This function allocates and initializes internal MCDI structures and resources
+ * for the CDX device, including the workqueue, locking primitives, and command
+ * tracking mechanisms. It sets the initial operating mode and prepares the device
+ * for MCDI operations.
+ *
+ * Return:
+ * * 0        - on success
+ * * -ENOMEM  - if memory allocation or workqueue creation fails
+ */
 int cdx_mcdi_init(struct cdx_mcdi *cdx)
 {
 	struct cdx_mcdi_iface *mcdi;
@@ -128,6 +141,7 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 fail:
 	return rc;
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_init);
 
 void cdx_mcdi_finish(struct cdx_mcdi *cdx)
 {
@@ -553,6 +567,19 @@ static void cdx_mcdi_start_or_queue(struct cdx_mcdi_iface *mcdi,
 			cdx_mcdi_cmd_start_or_queue(mcdi, cmd);
 }
 
+/**
+ * cdx_mcdi_process_cmd - Process an incoming MCDI response
+ * @cdx: NIC through which to issue the command
+ * @outbuf:  Pointer to the response buffer received from the management controller
+ * @len:     Length of the response buffer in bytes
+ *
+ * This function handles a response from the management controller. It locates the
+ * corresponding command using the sequence number embedded in the header,
+ * completes the command if it is still pending, and initiates any necessary cleanup.
+ *
+ * The function assumes that the response buffer is well-formed and at least one
+ * dword in size.
+ */
 void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int len)
 {
 	struct cdx_mcdi_iface *mcdi;
@@ -590,6 +617,7 @@ void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int le
 
 	cdx_mcdi_process_cleanup_list(mcdi->cdx, &cleanup_list);
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_process_cmd);
 
 static void cdx_mcdi_cmd_work(struct work_struct *context)
 {
@@ -757,6 +785,7 @@ int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
 	return cdx_mcdi_rpc_sync(cdx, cmd, inbuf, inlen, outbuf, outlen,
 				 outlen_actual, false);
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_rpc);
 
 /**
  * cdx_mcdi_rpc_async - Schedule an MCDI command to run asynchronously
diff --git a/include/linux/cdx/mcdi.h b/include/linux/cdx/mcdi.h
index 46e3f63b062a..1344119e9a2c 100644
--- a/include/linux/cdx/mcdi.h
+++ b/include/linux/cdx/mcdi.h
@@ -169,6 +169,12 @@ struct cdx_mcdi_data {
 	u32 fn_flags;
 };
 
+int cdx_mcdi_init(struct cdx_mcdi *cdx);
+void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int len);
+int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
+		 const struct cdx_dword *inbuf, size_t inlen,
+		 struct cdx_dword *outbuf, size_t outlen, size_t *outlen_actual);
+
 /*
  * We expect that 16- and 32-bit fields in MCDI requests and responses
  * are appropriately aligned, but 64-bit fields are only
-- 
2.34.1


