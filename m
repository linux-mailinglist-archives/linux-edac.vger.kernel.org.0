Return-Path: <linux-edac+bounces-4739-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7F8B48CA0
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 13:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0C32000B4
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 11:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8802EBDE6;
	Mon,  8 Sep 2025 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gIjJ3riF"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A874E229B1F;
	Mon,  8 Sep 2025 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332639; cv=fail; b=rirekJK/j+lnE3OMZnVTYEwyx0IxO1HzjOHKjITwtjdSlOGYiWH3MEvgRqmDVtxjlvQYvQkr7fz1P0h6b/ak1bSCNJ3s8PRZbgjnH7oQlE2fgd4tXTYtmIPkFzagLFxLbF6MOOAI8MKIcTQHiMtSwXW68/EquqTDeyfFn4g9/KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332639; c=relaxed/simple;
	bh=zyz4qv0w1F9RylJNYcklVmLBpEclHpj+MOQ02A1zCNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMOVv+9c9oAbw3yIahdKyJ/isDurctBBT2pvD2ih89fkwC5Lmg8Z1ALbpZtR3urwL/1bA4LTkPVKpZIF7Zgkv04P/VKfCeSPaSrYGzKndJtXBBE+qv3QkrXQYDtaT6grVYkRhTclxyR/HgSHkI+KTR41YXsUH3IVrX243Uxhqp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gIjJ3riF; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kw6Y79xWxUHJ6VkWy0iUlvO2CQZuMASIz8oglUuF53S2bLsAoV1LFokcqqMVEb2Ei7Y9f3knu1TuSkTkc2umDR2W0XjNzQKJ99foNuYnkP33cCwyQQOPtldauoGdJzedh+RhHpiXhl74bUPwhItm7AwLLkDf28fh5j2FA3k+o1DPp+k+37vqNPZ4OM3bsV4/wwvHdp/0+E2EHtoONLTrcmGGARmhczHSIYUuKUHA+l9ZwHxlcH2carXzzWDv5BpVWCNO+0E2bJdls8ialdFLG33d7fHDOLLaeTlxR2O3guMRjy42aBJDkPFLb7aB4tIFsvy5aJFeDE6PYqbSNGhKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BsrHFXyxuHUSQ1g5OlUFbwC+m7OG0s2K/bv1Sadmpw=;
 b=AE+cX1O6C4lsolpkD+51gEvNLqtRw0KhVFdaaXhyaYE4Y6A/grI+ERxx+5RifR+NfkrguB4sU3mzkwgCJGwVFQEI7Uw4uz5uaXkKjVfPNSu2CNCiIi9ldNCAvHdv/PCKnKPI2aP+G3uHA6psXVbqDc9b19Q/nnhI55kY8nDt8vRTr1GSVknzW0XVSrtYAnA8IYjAR4OyJzkd37bDSVNjktzi114ToxIej813ko+Ne67tX3kxc0Mmw3WctxOFmKUKhyr/wBqW5sjmDthEXatI2I5I6PIYmOOlt006Iq7mwpYwo0Qe2+CSWdS0EFC3Uxc3kooHJlMLaUJ+BeCPR1FYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BsrHFXyxuHUSQ1g5OlUFbwC+m7OG0s2K/bv1Sadmpw=;
 b=gIjJ3riFuLslkBYI9gYOA8kPid8U2PfFIiwkLcAsAIJYltBLJqnSLDsWM/qeWzYE87KcPeDrdJy/tblQlN18VVoPmDIKI454CZAlbcIQKvIcj00i2R5iF2oYaXQltiygGHRnI3tiZ9LczhYANYP8wmFwkc0UFu52NQIUEIEd0O8=
Received: from DM6PR01CA0003.prod.exchangelabs.com (2603:10b6:5:296::8) by
 DS2PR12MB9712.namprd12.prod.outlook.com (2603:10b6:8:275::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.19; Mon, 8 Sep 2025 11:57:14 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::50) by DM6PR01CA0003.outlook.office365.com
 (2603:10b6:5:296::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:57:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 04:57:08 -0700
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Sep 2025 04:57:03 -0700
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
Subject: [PATCH v9 2/5] cdx: Export Symbols for MCDI RPC and Initialization
Date: Mon, 8 Sep 2025 17:26:46 +0530
Message-ID: <20250908115649.22903-3-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DS2PR12MB9712:EE_
X-MS-Office365-Filtering-Correlation-Id: 73343d12-65cb-4c30-624b-08ddeeceda14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LCv22KZkekYpPa2FMqLKNJx6hsc0s1khVVDPrra9tnaVRQzF5MZRVIypNP7/?=
 =?us-ascii?Q?dFW2p8CQu5766vMWtBV05uX2MuK7WFmenuo1rgIy1s4DHAkavIcVfFLyZbl0?=
 =?us-ascii?Q?QqTKN5Z30OX6eeSssTOUb7dYW6UDvZOX/HEVLKMMFHr+7YubN1wnb0ehD/+M?=
 =?us-ascii?Q?9N9+HmRMvZVdJFP1Rw2MS37drGXTQCu3wYk5ZrEXSBpN4lR2PzuVTt+XirLN?=
 =?us-ascii?Q?L8H2VqRLKfUWURBXE24XEZTxbJZGME+unmmAk99c8WpQAY0xzEKJqR5+pCvq?=
 =?us-ascii?Q?PQmNNsV/plrWT0LjqC3uLkDVRAdWjLIJVUDndiq4bR8D+LWPUuB03cxqktto?=
 =?us-ascii?Q?RCwqr1r9O90MPdTXQ37TF03Xw7dJl8P91AkPRRZ4sxLVb6FqPjG22eykcFXo?=
 =?us-ascii?Q?1W/6Eo4m03YXXrGqZS2uVZKSEYHXZLRzNDAyGRY+cEQrHQCixPp/EugqeLh3?=
 =?us-ascii?Q?7TI2WCnkE+vhqcxcFByH/eH9N/PXirBKmODJoyhrKwGQRcWAPc/+ATxhK9ii?=
 =?us-ascii?Q?cqidaNJ/Conu55X2XDd3Pju39t0FPg103Ueh5brnPU9hFv64V4i659lnm+lQ?=
 =?us-ascii?Q?cDYbnfWHOtBNITq8R2VKvKjNNk5uIgmzCsxCXb8L4pAMxNvN4v7YfX6wg+oQ?=
 =?us-ascii?Q?Vr++2BCpIjHPpUy4lbcyiQPOfxiUE8DJGzlbHXHF3bE5kT713sqpm60yYQpa?=
 =?us-ascii?Q?zZfQzqX8jHms/Q0ygT1IOSC2HyAZY2epnZqy9WUveLCkqerRwUd+Giw/kO2v?=
 =?us-ascii?Q?bLpN4mHSybxF4EavVZPgaRLqUqkk41amAw1dIdFg56eaaVk8UvWJdKHXEIzz?=
 =?us-ascii?Q?mhbQd+qg/qbMJODQ7iW8Gz/9m3PsyfOtipMB6Lb56IY+NZBURgU+Sopjpf8M?=
 =?us-ascii?Q?giwmL13o6SgOCSqdOJckL7cMzV/QUdRuCvUf+PJH6MlzqJYrzC3Vu+svUq7J?=
 =?us-ascii?Q?sQKaYRZfqN5gujzJnKl+ImDywD0TQ56/88gwIxU2/GrN6hMDwtIFJTt0xQlJ?=
 =?us-ascii?Q?S7Up7YMTJ+Y0x0W5PR6yzAbAE/TTnIAFyPVCq6F5f0qJSLEFWtK69oghLkjE?=
 =?us-ascii?Q?83w9Th0pSfR3pkqBvylXdVExapDSGQYYWEwpxNq1o9eO5XHiS/BhiCPdD+/0?=
 =?us-ascii?Q?6QABDFxZNMmE/kcDenWIbZoIHfSFZ9aZkx++SOeTxWXCwxKM4ZTpZSFRlKzv?=
 =?us-ascii?Q?meh5dY4S9x0EDTUKjKloZ6iDNtW1gqUXctlcZZdfLaTjU4yD07n2qLAh7Fwf?=
 =?us-ascii?Q?yALc6y7oIHOZYFQUTPFRglTL0pz/Bg2aTLqi4x+UIbkCSP7nXEzwz3lqikg/?=
 =?us-ascii?Q?6Hp33RGiJRffq8IIc3kYfTDhzARxCbRMvYZVhXRZamqstzEmAsmzMtJr+h5E?=
 =?us-ascii?Q?PZMd8DAfMUPZwhTL46kxGcjFyoNhvcWoaU/QxQoc/fDWvMLdI7m3Vqz7dog3?=
 =?us-ascii?Q?MmqALMRqqB5iFUGwOHTueNdGUnXSETxbEJYv6V+9Jh/wXF80wGICO4FIy336?=
 =?us-ascii?Q?l1f6gdlmsdSq8rLKXc4+NSpYaO52MhBL3WTD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:57:14.5111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73343d12-65cb-4c30-624b-08ddeeceda14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9712

The cdx_mcdi_init, cdx_mcdi_process_cmd, and cdx_mcdi_rpc functions are
needed by VersalNET EDAC modules that interact with the MCDI (Management
Controller Direct Interface) framework. These functions facilitate
communication between different hardware components by enabling command
execution and status management.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v9:
- Add tabs
- Replace "This function allocates" to Allocate
similarly s/This function handles/Handle/
- Export cdx_mcdi_finish

Changes in v7:
- Add the kernel doc description
- Add the prototype from first patch to here

Changes in v6:
- Update commit description

Changes in v2:
- Export the symbols for module compilation

 drivers/cdx/controller/mcdi.c | 38 +++++++++++++++++++++++++++++++++++
 include/linux/cdx/mcdi.h      |  7 +++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index 90bf9f7c257b..2e82ffc18d89 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -100,6 +100,19 @@ static unsigned long cdx_mcdi_rpc_timeout(struct cdx_mcdi *cdx, unsigned int cmd
 		return cdx->mcdi_ops->mcdi_rpc_timeout(cdx, cmd);
 }
 
+/**
+ * cdx_mcdi_init - Initialize MCDI (Management Controller Driver Interface) state
+ * @cdx:	Handle to the CDX MCDI structure
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
@@ -129,7 +142,16 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 fail:
 	return rc;
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_init);
 
+/**
+ * cdx_mcdi_finish - Cleanup MCDI (Management Controller Driver Interface) state
+ * @cdx:	Handle to the CDX MCDI structure
+ *
+ * This function is responsible for cleaning up the MCDI (Management Controller Driver Interface)
+ * resources associated with a cdx_mcdi structure. Also destroys the mcdi workqueue.
+ *
+ */
 void cdx_mcdi_finish(struct cdx_mcdi *cdx)
 {
 	struct cdx_mcdi_iface *mcdi;
@@ -144,6 +166,7 @@ void cdx_mcdi_finish(struct cdx_mcdi *cdx)
 	kfree(cdx->mcdi);
 	cdx->mcdi = NULL;
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_finish);
 
 static bool cdx_mcdi_flushed(struct cdx_mcdi_iface *mcdi, bool ignore_cleanups)
 {
@@ -554,6 +577,19 @@ static void cdx_mcdi_start_or_queue(struct cdx_mcdi_iface *mcdi,
 			cdx_mcdi_cmd_start_or_queue(mcdi, cmd);
 }
 
+/**
+ * cdx_mcdi_process_cmd - Process an incoming MCDI response
+ * @cdx:	Handle to the CDX MCDI structure
+ * @outbuf:	Pointer to the response buffer received from the management controller
+ * @len:	Length of the response buffer in bytes
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
@@ -591,6 +627,7 @@ void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int le
 
 	cdx_mcdi_process_cleanup_list(mcdi->cdx, &cleanup_list);
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_process_cmd);
 
 static void cdx_mcdi_cmd_work(struct work_struct *context)
 {
@@ -758,6 +795,7 @@ int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
 	return cdx_mcdi_rpc_sync(cdx, cmd, inbuf, inlen, outbuf, outlen,
 				 outlen_actual, false);
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_rpc);
 
 /**
  * cdx_mcdi_rpc_async - Schedule an MCDI command to run asynchronously
diff --git a/include/linux/cdx/mcdi.h b/include/linux/cdx/mcdi.h
index 46e3f63b062a..74075305cba4 100644
--- a/include/linux/cdx/mcdi.h
+++ b/include/linux/cdx/mcdi.h
@@ -169,6 +169,13 @@ struct cdx_mcdi_data {
 	u32 fn_flags;
 };
 
+void cdx_mcdi_finish(struct cdx_mcdi *cdx);
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


