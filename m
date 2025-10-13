Return-Path: <linux-edac+bounces-5032-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EEEBD5876
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 19:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B36418A52E7
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 17:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2026530595D;
	Mon, 13 Oct 2025 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oyn3uh2k"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4F3081C7;
	Mon, 13 Oct 2025 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377039; cv=fail; b=XYhCABwvMgmqQdbl1GxKhOJkkHEdnrdU2Gkmu5Xu74BmTUBM8dJ2HyZSQIIfZfQMJoZiRoe/5WKASkrQp6Gp775VBFcOet0id1tgU6Soz2N7/L1hHgo7cZFSXL48zhufao7vwdojGaeDupVE0dWqnzzNGIxj2FWTEBBS7l2M6x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377039; c=relaxed/simple;
	bh=qDM761Qw+KG7I1fLTeTU1Pr/UTvZZRF9dnMWUBN/GGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaB3cM6NguyNKAwj8AOxOZ9dCx+vWwYcyr3bv0HTYqj6HOZGuPLxo7ZQAtMJJtHRFA/alQxFr83UEvUW/b6UpF7ELlSxE+0gNgcE8JiMKqJCTcfLGR8Lq9vFZ9MV7DGdhTgsKVhzHTdMWI+n7DDGAf6gGHDfrrvAxrP7xO9KgUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oyn3uh2k; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u23qWBNJuSqgJZfNzwJgPAUiVrg6uCtw/sm9gjrkwUP3XloO1t1vHAYJJ/klFBICUW2xJzA5rfH6X3rubXtON52PwNom4S41io9UfsFuvxyH7ZOnIFkJXJUMq0PIaTg1FPszhTtRy+xPQ/abZmniCbgGvFIFV4BNJ20jnowxr4ampHkPg0LGQhXNTaWSi3JbjgZZNyPJ66uXM+fAuHegdOXkcv3VYIjbXxX3lRR4oOTwJzNNSN/qBhNb9yNahO1/qO9rJaXPYX671LIQaWjdCrDZvEu927617cQ5zQCN+rW5bukE4eLjpOltqPNYdwimavMaeWlCcOXtRJ+gLfRmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riwvS37vTSfyX2rZ7q1x55lnvyALiTZxBOR6O80IZL4=;
 b=sLtsVdyxRAtZDqOHPIPOX8ILWSgIjOXBftqozCk3e8IxeDzVTofEZlK2Qt+IGkzSmyXmLq6d5P8wi3LSSvk7jfVmODd+XygWDMj26VUd88DXM2HqPDFTGToHsZjB2CaQUSQMNuigSE8HPUQ9uoq7UnblKY4chGziyOIiio2BocfwxO+XOweGGVQGw27rQyn7MA22edGCwRTCBTEeBkvK1MDKFuMJKfLmNT6bzM0NE9LkgsmFFLFn/7Sx3GEss8zOQBGk3Vrf5wfstNDwNyzhhzVSRDcfNOZnG0NaUdMoJKC5Lz3U1sRuiJ2uqM8mXQdJPDr/aID8xSLAUFyLGdYGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riwvS37vTSfyX2rZ7q1x55lnvyALiTZxBOR6O80IZL4=;
 b=Oyn3uh2keooa9yIaq76DpALzn8p+gwEl24JU0qbpXEXh1WLKB7fprIR6CUNfAZTlpFb4ULba1QAamvOn9hSHCi0U5/Awr0LxTf1rZluOkJCNLxW8pu3ixYW72pEkIwyzysrxA4L4mB5ll/1NdEiIiLAiLsOiDIrQe9CX7GTQJgM=
Received: from CH2PR07CA0044.namprd07.prod.outlook.com (2603:10b6:610:5b::18)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:37:12 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::6) by CH2PR07CA0044.outlook.office365.com
 (2603:10b6:610:5b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 17:37:12 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Oct 2025 10:37:10 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH 2/4] EDAC/amd64: Remove NUM_CONTROLLERS macro
Date: Mon, 13 Oct 2025 17:30:41 +0000
Message-ID: <20251013173632.1449366-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013173632.1449366-1-avadhut.naik@amd.com>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff1b6d7-ee94-460c-a0ac-08de0a7f24c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0nmYI9B0i1A/th+fR5xoCWkyyga3wQu7H0VHNa2KHvPKnNODPZCU/hiYZar9?=
 =?us-ascii?Q?49rglGeffmGvXaN0S4GiFse+BGvi/jEHwC895m7tWXrtw50eklLPnO1KulSy?=
 =?us-ascii?Q?nMHjLtPXlpsDllt4b47dntH8U19WhNqvEQtfMsjn78OZKP6Is94e1xFfngg9?=
 =?us-ascii?Q?tCnBnzPQ0nWh77VkrVHNpsJ5qg1KnDC5PMuBgw5BpTIPtBUxqEEILqK/7Dtz?=
 =?us-ascii?Q?+dYCUd0r4ex6/la00lrx9RuKncpBYZTj8JPYV39Ug3/1uSsG/kHbCJdpenWz?=
 =?us-ascii?Q?BFZUR117TkiucCFfSDqDiRp52NDkf0u6Ijfaq0z0aw4WIvLr6gES8qNX8xrL?=
 =?us-ascii?Q?Ommld2NnCahRo1C3wdApdWljiLF+qEWda8AMGCG1qVKnxl4/kRQ7IR5BwbOG?=
 =?us-ascii?Q?JPxO6cC6Z/H2LlDgerzWuj+z8VPdHScIDcWM5l62ex6k0Qc2PzENiqZx8rxR?=
 =?us-ascii?Q?1G6Yjmtg0XYh0KkEQhbRwqLuZhBNdjr3TXSzvzaZxrt3vNn4g9kBdlfKKNpe?=
 =?us-ascii?Q?dBxgmJma0fjcw44/TKjwAcioVaVKK4wFlj8TDUcifUZ4KH32Qe6Xc4IiRVCr?=
 =?us-ascii?Q?zlB9HRX9gMpB9ubv4aovD8VtVA2FuvCKXm5S3+4Td/kCGg3a1hYNLvUFCAio?=
 =?us-ascii?Q?7NioeYYNaHnyqT7UH9U4IOn/ogWNWEKXA5jNMnAMTkarXypyzbWDVQv6C4f6?=
 =?us-ascii?Q?Zyv6BhVwzrQFNWspIJkH6v0ut5UoCYMrINFaj4nVf/ARU2H9cMdWep9FDOev?=
 =?us-ascii?Q?e5FTPJBM3OvUQmuaull/9hQ252NXChIwJ3980N8Ma79Yt2CQ1MQnF0AVlHkK?=
 =?us-ascii?Q?aB5jGqwOMjjangbBh+gynBRJi4CPsWeUVKCE1GFo8xfpCztYqoS1Wqnq5AGy?=
 =?us-ascii?Q?QtaOIDgny9ezQKyMION/ORUgGkm78sNZZiqmxemDzisa8nZEK0psbJSTmtaH?=
 =?us-ascii?Q?i+Vvff2jUoKxFs88y4yzGjRw4Z7YZ4djsC/BZd08vCoI1kad9x9pkw5jutv4?=
 =?us-ascii?Q?mf8vFtQGxCTZ6MnqSNuRp2Yn4IrFfy9rIuMzbWAMOlqeL5QS9JJUicbvD44O?=
 =?us-ascii?Q?rV5pyPPCUnV9FpaRwKLdPiOKNlldX0WujIXLEOVjm8+ANmm4cfc4GiMaUmYM?=
 =?us-ascii?Q?D5+H56Y8VKgtkv+SdXmd3f7fDCC5thTRlqzljKCFdhPHp3pdA9guwV0C+tIR?=
 =?us-ascii?Q?/m73hYzS1Th7u3izv/CjLd0Af6EtpUEiNJrWtI+1cq9RF4181TjJMV6kb4aQ?=
 =?us-ascii?Q?P//12CHxX8oYIiybBCJ7FXtZ3ZX6bJefwy3hflz3KPNiSn53bz2M4cgBj1yj?=
 =?us-ascii?Q?VUThjuFzLslEWfSlrEKp8p3T23jKxjlmzebdcIdH1k4uNYNnl6seukiSIzOv?=
 =?us-ascii?Q?BYtklhmQtn5HIhD63ZAKIeeiHkgfuPhf+vZ/zoTpi9PNypeiyAyUkjVeOdIr?=
 =?us-ascii?Q?FgL43fwbLL3Qn46LJlCdzY/+58W7+UNlQTfZ/s2tHplWG2yKxFCJumqlw5sx?=
 =?us-ascii?Q?CzEW9t+RqCN1G8N52bNL5Cdzi/s9ow7KkRkVj3XKsQnxdgXjlauUSkLwm8dA?=
 =?us-ascii?Q?0iwHR9IWZh9KarLZcpM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:37:12.6488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff1b6d7-ee94-460c-a0ac-08de0a7f24c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330

Currently, the NUM_CONTROLLERS macro is only used to statically allocate
the csels array of struct chip_select in struct amd64_pvt.

The size of this array, however, will never exceed the number of UMCs on
the SOC. Since, max_mcs variable in struct amd64_pvt already stores the
number of UMCs on the SOC, the macro can be removed and the static array
can be dynamically allocated instead.

The max_mcs variable and the csels array are used for legacy systems too.
These systems have a max of 2 controllers (DCTs). Since the default value
of max_mcs, set in per_family_init(), is 2, these legacy system are also
covered by this change.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/edac/amd64_edac.c | 5 +++++
 drivers/edac/amd64_edac.h | 5 ++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 886ad075d222..2391f3469961 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3732,6 +3732,7 @@ static void hw_info_put(struct amd64_pvt *pvt)
 	pci_dev_put(pvt->F1);
 	pci_dev_put(pvt->F2);
 	kfree(pvt->umc);
+	kfree(pvt->csels);
 }
 
 static struct low_ops umc_ops = {
@@ -3915,6 +3916,10 @@ static int per_family_init(struct amd64_pvt *pvt)
 		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), "F%02Xh_M%02Xh",
 			  pvt->fam, pvt->model);
 
+	pvt->csels = kcalloc(pvt->max_mcs, sizeof(*pvt->csels), GFP_KERNEL);
+	if (!pvt->csels)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index bb6cf4b1ab77..5f61631c8a7d 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -96,7 +96,6 @@
 /* Hardware limit on ChipSelect rows per MC and processors per system */
 #define NUM_CHIPSELECTS			8
 #define DRAM_RANGES			8
-#define NUM_CONTROLLERS			16
 
 #define ON true
 #define OFF false
@@ -347,8 +346,8 @@ struct amd64_pvt {
 	u32 dbam0;		/* DRAM Base Address Mapping reg for DCT0 */
 	u32 dbam1;		/* DRAM Base Address Mapping reg for DCT1 */
 
-	/* one for each DCT/UMC */
-	struct chip_select csels[NUM_CONTROLLERS];
+	/* Allocate one for each DCT/UMC */
+	struct chip_select *csels;
 
 	/* DRAM base and limit pairs F1x[78,70,68,60,58,50,48,40] */
 	struct dram_range ranges[DRAM_RANGES];
-- 
2.43.0


