Return-Path: <linux-edac+bounces-4684-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C19FBB35359
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 07:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DB13A1315
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 05:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974D2EFDB9;
	Tue, 26 Aug 2025 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SH7eaYTX"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5922EE29F;
	Tue, 26 Aug 2025 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186175; cv=fail; b=Rhs+T+iDJJ9sJ1heQjuF14zMVp2hW1G6fityeeQKjTj3+NiNWyny0j3QipD7tLA02mLmeBgDOuCXqiWl4tALtKUkmrwgiSsVkIFNDEOIONVW5ZNLKeY6BP4B2MYvNqgxlMHnmDZ2yU0xnaCZP9yxaeA/tjX5pFw8nf3sp4l26EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186175; c=relaxed/simple;
	bh=BedOt79+PW6QxRT0a2r83zG0BciGBldYa/9lcLTECJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WijnqFap6qqgTt8xxkid2ezjx6S/ChcZL2gJ8UTYw6k+AhbpYNg8DuZrvbxL0eyASGpPo6r7BT3DToarbv2zIlLK07Cyssvt/dGvYyB1JpMmQpaeHA0ASr0LZgs1XC+SM4+VbuoxwQG5yi6n9AWqifP/z2sOPSyRf5jhAfJd6MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SH7eaYTX; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOkNK6wXvnTm20XxNgY96a13+7V/nKNmo53rpMD0kCjAFPtVKxk+gfz1SAxyLUibGPZVWPKc1hZvMALkwxpOLw5YL3ma/L3kyTOeZKZQeqmdXpERKd0yAqX0xyk8QTeZ+x6nNbt3m9jZU6Ad7Fow9quwG7+qSrt9NF6itsU7fKcurxErS8zJqEb3QKTlfI/IbP2q2yvVp6LWw0oFCenqjbo9cut38FPjP3Bt8w7mQWPSM36nJuX6wBcZzA9zoFVT8vrg39+EZL5aFjiDoWjURSfhAux/hZFZ0Agj2tmDWXuIeAQOK2roJmRYZtXHBm4VtBFnX+PjOCL9QRq2GQlHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fao3+upMfuKUn7A1BBpx/0/uQ2/CPeUVXV+AjUc+vcM=;
 b=lUb8OyHZ8Hx8ux7gJUQW+sxA3UycNxCAxYRDFYP79npZsHYyKNo0zKM5qXwcB00waDw4etqZ/NHkIDseJVIGYuD9UZJHrtOfYZREgQEjKyeyuLQq7GS19yPlfmicPMFo9jD6ibHeBlWdgpmtBRpT6mJTeDscFeNbziH6fwhXQZ+ChnRBdf1oyT5tY8nB/6na5rO2yUGjC4RoLR1rYyJAPZgsK5BKKz0fralhXP8C8doQ93c3r97U/8WZFYy9THl89vAOLqF7A11r71Gf9RuDdoiFPWFsccA3FYDj0vEcf3DBQaf0YWH4V0IxnACfuLRbEJBlBcKs5yJHm/4YwLHRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fao3+upMfuKUn7A1BBpx/0/uQ2/CPeUVXV+AjUc+vcM=;
 b=SH7eaYTXff9A4cuJURgtlgiY1hA8rJE6y5aK8uer9TESsCBiOv28ch09RVUKjQa5HVnPqn1egu+SLTLgVMKkQdxJMKcIHAwPMDGHYpU+L2/O2QJaJ5sqQ29PWUVnKSGHhpCh9StenYLP9YP4IJ35HeJ/RX/7YxZSUiY03Fq3Qz4=
Received: from DS7PR03CA0171.namprd03.prod.outlook.com (2603:10b6:5:3b2::26)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 05:29:30 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::24) by DS7PR03CA0171.outlook.office365.com
 (2603:10b6:5:3b2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 05:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:29:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:29:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 25 Aug
 2025 22:29:28 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 26 Aug 2025 00:29:24 -0500
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
Subject: [PATCH v8 2/5] cdx: Export Symbols for MCDI RPC and Initialization
Date: Tue, 26 Aug 2025 10:59:11 +0530
Message-ID: <20250826052914.2066884-3-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 62284627-eb56-43bc-8daf-08dde461881f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hWxWlmugQ3MHGkXBpbQTqEiQLW+W+7utJ1942qFVZR28bmoxJbc+BugsqL2s?=
 =?us-ascii?Q?GaCIr1Fp9CWpcq23btdmwia/mhxLR7btg57UdSNlfqpy0EMIZt0wpZcLvYYW?=
 =?us-ascii?Q?7Nh9aEufKYWEsJkd5Xc7PoAyO5fsQQVKSSQwwTAN+lOi0Q4QTk+tObqLF07P?=
 =?us-ascii?Q?m8/0J40O8DwuuNaUlwkrOMuctf2dJnuHL5SOUpBjSTwiQCTqY+0a7x5qBZBP?=
 =?us-ascii?Q?D0fH3qbxHjxpt/AQXX75MXICtak3k0qGo8/RWCoe3bkRluAa7upK19avaEry?=
 =?us-ascii?Q?HHZ6qjHOLeY71NuIki7qBiE/Kodte1HtYVe0qqjIhgo+9OqztOJvP5Qb71dU?=
 =?us-ascii?Q?XsY8NJ+r7Cslov4//LezhH6ySSK9T3w9Kjyh1ruwn/3rADIbxDjKWngEbbNE?=
 =?us-ascii?Q?76UrbfG8lKFTIMi9Kg/9aQql+A6G4yb2X7rBjLkL1p2VLYYz55I8U16za8RI?=
 =?us-ascii?Q?DpNde8amEDvLb3qWJkZYi9HjwR7xV9h6BYmXiUknSuHyCOyoCn3iA5vyRTif?=
 =?us-ascii?Q?fRt59iqEbFosN8c8OKg59r4M/4LW0bu9rSPuZoaAKFLRVRClU2tbkbleuFHk?=
 =?us-ascii?Q?Dv8mNYtmY5edwpDD9eNZ77bctsrCQpdejIsx87TW83eWKipQPuNS9F3TJon4?=
 =?us-ascii?Q?+FAMtS/S/TgNS6pCaAAKREOQb25OPwEJLWW1fCAc+C4J2APtXHpNsnO0kW9T?=
 =?us-ascii?Q?YmVQm/KPsu5dp0pSjZyPC6d8+fNETA8OisfsNnIueG6jsBF4pWqB88SuvnMW?=
 =?us-ascii?Q?UBiUW8jEAKs1lMWFSJASdBktEIk7ZfXqF9ySR7HLbLZ1/KvMTwTnuysSehmo?=
 =?us-ascii?Q?fwafXmzu31jbaSkNnpGQQle9GJcOHVrDdfKEFypE1ZevapjB+M+/bHIFpmno?=
 =?us-ascii?Q?BkrLqPtbKlziPEo29u1YVfuh/esbDhgsMXYBjvl+qNPd3rxWe4OAGIctO2Pe?=
 =?us-ascii?Q?i9RXZLQATMF+rqwJ6jspESuQLztO2Kxkpxm14qVWq1ZEJfjt3krmnxjK3dCZ?=
 =?us-ascii?Q?E7G9aoenzmerkCKuzOe7ZZJp/ga9GKmbXSW056/A343Gs+FBSCCGJJ3Y6uyF?=
 =?us-ascii?Q?p+zqs85EkiztG3TjEiJfRp24m9vFK/UZ2XLETLbQ1yo1LOd0w81rfgA9drx1?=
 =?us-ascii?Q?wNh7GLFj35B5ZgzUmEZFu+BFrOS5R5OSn8KhAmzNW5kcLo8eq/9xjbAXzCn5?=
 =?us-ascii?Q?qIogIDkfcJKpCq4biS2ZO1s0s9CcEsJzg7NlpamoSr8qK2uzFLMOanuzmWap?=
 =?us-ascii?Q?nccftTdwbXuRSnmTQvm/2143MwcvqkcIjUFLpyuVsFKx1gKZUPHBdldSTb6L?=
 =?us-ascii?Q?6QH5MCQb367hYPKx10WttgHdCSQFnwcIfHYNDI4lcOgiJ+s5Xz5IHdpO9qnK?=
 =?us-ascii?Q?QRSZL0PAYEu1KyacUWert4iLqcsVogPzUOtwOZH6vjpgmM/W5hpvjWF/Se4p?=
 =?us-ascii?Q?J2E5mTj1Ts7dyMB0wbXlQ080lXYrffhGvh7aywuTIwTXo3bI5JQaa3dxjyeo?=
 =?us-ascii?Q?6yNx6N53CxgAtecz5F0CdoLEwgioZErrBSUq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:29:30.2394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62284627-eb56-43bc-8daf-08dde461881f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132

The cdx_mcdi_init, cdx_mcdi_process_cmd, and cdx_mcdi_rpc functions are
needed by VersalNET EDAC modules that interact with the MCDI (Management
Controller Direct Interface) framework. These functions facilitate
communication between different hardware components by enabling command
execution and status management.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

(no changes since v7)

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
index 90bf9f7c257b..6f52d8dac907 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -100,6 +100,19 @@ static unsigned long cdx_mcdi_rpc_timeout(struct cdx_mcdi *cdx, unsigned int cmd
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
@@ -129,6 +142,7 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 fail:
 	return rc;
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_init);
 
 void cdx_mcdi_finish(struct cdx_mcdi *cdx)
 {
@@ -554,6 +568,19 @@ static void cdx_mcdi_start_or_queue(struct cdx_mcdi_iface *mcdi,
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
@@ -591,6 +618,7 @@ void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int le
 
 	cdx_mcdi_process_cleanup_list(mcdi->cdx, &cleanup_list);
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_process_cmd);
 
 static void cdx_mcdi_cmd_work(struct work_struct *context)
 {
@@ -758,6 +786,7 @@ int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
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


