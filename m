Return-Path: <linux-edac+bounces-1011-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E28BD416
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 19:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81A6281558
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 17:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F171581FE;
	Mon,  6 May 2024 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1ZNksg23"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4AC157E7A;
	Mon,  6 May 2024 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017724; cv=fail; b=Bgv6mHJ4UdR44vsKSbcGuQ/lin+WoqloASPrUxF8Ptv9WDO81jzbODEmYsmicmo3pap/4NIqVoFktiqDLlObTqYakRR8LvSdG2M612qn+/VUS79OmcY1yoHmkrmPsjR/y5SwJMgIoYUmNafqTgV2WkQSwIJ9e0UxaKLaF7BiC/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017724; c=relaxed/simple;
	bh=NAQUS0iXrBz0gpy7VEGw6/C1DfYkIskTvWIbGrb8dws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6rCoygVJAzvSNNH3oBBQB2n2Gqi7iGBLv7jtXu6L5IOAqbetb0goGzCigKLQ3/E3kE8aV9rlzo3BqJQjv5JWJz4b+Vf/7DrG02+ZV4fYRqUId10nEmGIiCwv9H7dA5TtwpSbEd0cg44GbSTJYLKRuexazbqIhFOZzSU4cw3zjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1ZNksg23; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcZDgp/Ugk/OW5LdjsHyCJFQd/REYzbEmDTG/IBVouGKlJsCLMp2rZPly7swjhfDJAhe25OiAEVi2DkKZby0ExijNQ8jwm5pY6M1RmMe71tdj+jLKDd2e5b8Go0zC/gbUAey1KiLLbsO8y6eqH5I8vvLHHQYxwxrNUzVdK8iT9Isdoag+fRlB24ybIWB8BD1szV9+BFYqVb6Go/kQ7TeeWjUI/KmK8MJtBMHDiX2y9akrfoXWOHo8UUboNOYUMERwUzw0Ik4SkGnTiZZa7JjbmVEf+YsNQMNZfYCMRdfezdxD+DSdFjLBhxMOYrqfDueVslm3tUluQrCcoDZ+lODGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edN5g7ybAMFNKVnU2tLL1HyAOrob1vyHXE/fPGvQ9Pc=;
 b=Joixr7nFWOh/QBI1DMA75D9/1w4PC6YnMikzttnFPXY2E/qrYLeo2Uy6QE97x/1o9Fqm36TpxGN3m7HUme0Ox59vLea/0ozQLojhfcuNhsZ8oBePpuB/B5XmVRu3Rg/9sxmyYkmtq/XRlBakJN7VjY5nNA/803nvEB7NZOMz+oFkhFhSxKJ5Ti/fHhsrzmKW1uixcsz81EVbH8wos3IVQdTsIH+38Ekpso/39hcEQlKxaY5JXRq19IgCArVSxR0/ZUx22whcNGirnF94O6xpZoHfZvrDijdDYwBoYBiRdrVyS9Fgc9vhiI/M1pBUUY+/tLwYbiDO+O46H6sx8lX2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edN5g7ybAMFNKVnU2tLL1HyAOrob1vyHXE/fPGvQ9Pc=;
 b=1ZNksg23pb0SNxuvd18ZFQMlYjTMt5J7urqptRlVBVsh3tROWst4wV37LVSpR+lq9bBQSKOD8M7vKEoT1CJ1vZo5gTBmZqebS/510/o2fB3eh5itCkRQShfOp1NDjAG75I8SZ9M9MusBiPlwDAqsN6PCr6ElJORiU3nyZIRB60c=
Received: from BN0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:408:e6::22)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 17:48:31 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::a7) by BN0PR03CA0017.outlook.office365.com
 (2603:10b6:408:e6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 17:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 17:48:31 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 12:48:30 -0500
From: John Allen <john.allen@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<yazen.ghannam@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, John Allen <john.allen@amd.com>
Subject: [PATCH v2 2/2] RAS/AMD/ATL: Translate normalized to system physical addresses using PRM
Date: Mon, 6 May 2024 17:47:21 +0000
Message-ID: <20240506174721.72018-3-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506174721.72018-1-john.allen@amd.com>
References: <20240506174721.72018-1-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f76b15b-c806-45a0-11fe-08dc6df4be8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y082Q3VWM0VuN1ZWVUtlNEp4RW05NmZzOUVBVjZOdXdrYVdrSjJOQ1ZpL1BW?=
 =?utf-8?B?OGxZUlZLM2pRM1lDQnpOS1hRcm1tZ0x0SjY4Q2dyV3NiY2RldVkxZ2w0ZGp3?=
 =?utf-8?B?SDA5RjlRL2lMRzI5bklaclRZMy9RR1ZlZkhZTUI2aTg1NDluQkYzTm50VjEw?=
 =?utf-8?B?aERjeC95dWRmT1RnakY5TFJTYlpKZERGcjg4bnljNG1oUDN4WnJyTDZNOWJJ?=
 =?utf-8?B?VGpKZE5xY0QrVVBTS1F0Tk9jWU5waGtsZDNWSGxkeFhMNWpNZ0swR2l3OG1C?=
 =?utf-8?B?SUNiNmhWZGgvcnFYVDlNUWt0SElWRkxhc3N6QklFaTFtZlpybUpoNDZYa3pC?=
 =?utf-8?B?ckV3cFR4U0pXb3NZdjJoN3N6ZHJ6eTJIdHZQUy8reGJaWkZXRXBtM1hNUHoz?=
 =?utf-8?B?NTdYYkRDU2JjcjZSQ2c2OXY3Uy9pYVhrWlAvM2U4aFhJdENBbGRpR201VXFT?=
 =?utf-8?B?RFhQYUV0MVFtZ2xKZWhsVHA0UEhXOTliNUVUSnJDVzBDNzdOVFlaMnd1c21w?=
 =?utf-8?B?SnpXSWpVTTVGWHlWYUsrZEl6d25PTHZVaFhVUkwzL013TWNHTStXZW92STho?=
 =?utf-8?B?bitDVmIrMkVZdjY4WEgvYjk3bzBMYnVoeWVxbzFjdUhOUmlvYWRPdDVrZjVm?=
 =?utf-8?B?bjhoYmlBSDYvZ2o5VGRnY3V5Q1ZJUUJlT3JQZ3VVUEJqTWJXUzYrVmhuK2F1?=
 =?utf-8?B?dFBlSXI5cm80aGs3b3Fzc2tXOGF5WVUwUlh6cTVFZmJiczg1RktwS2pIYk1x?=
 =?utf-8?B?TWN2czVKMGFhMFFUOUI1TUk1d2RTdmE3cVhZbE1QTllhZEdkOEN2elYxRWt3?=
 =?utf-8?B?SWk0TytDbUJ2c3FVeVd0TE9sd0w3a0RkTzY3OU5iVVVlUlFnSlFZeldSQzZ4?=
 =?utf-8?B?dVE4ZVRybVp6NTRJVDMvY0lsa1VSRGdra2xsM3U4ZEJPeDZxYlpZN1MrSStH?=
 =?utf-8?B?RXRNN1FxWXpRYytOdzBodU9QbVM2dHVkazVwdEI0UUZlc0xNd2p1cjVTZ2ZU?=
 =?utf-8?B?ZFNyQUhoN2Z6VW8wUzB4STR0YzFINFF6NTFzMzhHMG8vZjVjNktoK0lkZ1p2?=
 =?utf-8?B?cE5FN2o4VzlzNXlycnEvSDRZVFVjYzNWTnRiMlZ4K1RiNUxEZXFrUVpPU2FS?=
 =?utf-8?B?bzNXMDdMblVHQ1RtRThCbmRBNWZpZHpwcEJTRjNyR3dtQXExV1pZNlpyZlBI?=
 =?utf-8?B?QnMwclFQKytxQUlYVDFKR25qOWhqV2RBSERaRkk0VmlMY1FEWTNmMytjcCs4?=
 =?utf-8?B?K3ZaWlA5NzZwalVBdFd6UUkyNm9oYk16WDIwNTJLbHBRZXBRdGMwNFpSK2Z2?=
 =?utf-8?B?VGFvNXF2UXgrQmdselVoRERGVFBRWjF1TU93WjlGNk0xSVk5c1hKVVhEMVNr?=
 =?utf-8?B?TUxOSGlVc3dlUmMxY1kwK1BqdGxKeENoamxEaStqVHNCVlQyeCtKUG9zVzlt?=
 =?utf-8?B?bm9WWUhRUFRQejl1dmVUSktGVGFUMzc2WGFHVnV1UFJkWlZRb29XUDZHNXhy?=
 =?utf-8?B?VzlVdTFrdTF0THRRZ2prc2UyR2pNWWJnaVdmaVh1cEMzNFhSanNiK0F5aTh3?=
 =?utf-8?B?T01Pd0M0SEpoYzJ3V1N4L1FMYVVHa01OQjJSNUZKaHhSc2p4T2VyL3lkMVpj?=
 =?utf-8?B?aWF4NWtwNTBsbHBxampKSlBxamEzeGttT2JLRmFuQlRoZzM5Y0NRbm5xZHJv?=
 =?utf-8?B?YnUvdUQ4U3QvbHgxWXZFT29kVnBhdjZBcHdhaGFwQlBZS3NPcDQyc2l6WTRu?=
 =?utf-8?B?c0RJTWtsd1lPMnEySDlCc2NQMTdyS2xwU0VBb0VYTENsakt0UlI1NDI3L1RY?=
 =?utf-8?B?OHVTakY5aCtSdTh2NS80aUhmSEJXUTdOR1gvWmRab2FUNEF1Wm9tbHE4YWhC?=
 =?utf-8?Q?NF1+5q4hd9Zu3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 17:48:31.5597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f76b15b-c806-45a0-11fe-08dc6df4be8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018

Future AMD platforms will provide a UEFI PRM module that implements a
number of address translation PRM handlers. This will provide an
interface for the OS to call platform specific code without requiring
the use of SMM or other heavy firmware operations.

AMD Zen-based systems report memory error addresses through Machine
Check banks representing Unified Memory Controllers (UMCs) in the form
of UMC relative "normalized" addresses. A normalized address must be
converted to a system physical address to be usable by the OS.

Add support for the normalized to system physical address translation
PRM handler in the AMD Address Translation Library and prefer it over
native code if available. The GUID and parameter buffer structure are
specific to the normalized to system physical address handler provided
by the address translation PRM module included in future AMD systems.

The address translation PRM module is documented in chapter 22 of the
publicly available "AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
ACPI v6.5 Porting Guide":
https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/58088-0.75-pub.pdf

Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - Make norm_to_sys_prm_handler_guid static.
  - Change pr_info statements to more appropriate pr_debug and
    pr_info_once statements.
---
 drivers/ras/amd/atl/Makefile   |  1 +
 drivers/ras/amd/atl/internal.h |  2 ++
 drivers/ras/amd/atl/prm.c      | 61 ++++++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/umc.c      |  5 +++
 4 files changed, 69 insertions(+)
 create mode 100644 drivers/ras/amd/atl/prm.c

diff --git a/drivers/ras/amd/atl/Makefile b/drivers/ras/amd/atl/Makefile
index 4acd5f05bd9c..8f1afa793e3b 100644
--- a/drivers/ras/amd/atl/Makefile
+++ b/drivers/ras/amd/atl/Makefile
@@ -14,5 +14,6 @@ amd_atl-y		+= denormalize.o
 amd_atl-y		+= map.o
 amd_atl-y		+= system.o
 amd_atl-y		+= umc.o
+amd_atl-y		+= prm.o
 
 obj-$(CONFIG_AMD_ATL)	+= amd_atl.o
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 5de69e0bb0f9..f739dcada126 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -234,6 +234,8 @@ int dehash_address(struct addr_ctx *ctx);
 unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
 unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
 
+unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr);
+
 /*
  * Make a gap in @data that is @num_bits long starting at @bit_num.
  * e.g. data		= 11111111'b
diff --git a/drivers/ras/amd/atl/prm.c b/drivers/ras/amd/atl/prm.c
new file mode 100644
index 000000000000..8e96a6370ae3
--- /dev/null
+++ b/drivers/ras/amd/atl/prm.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Address Translation Library
+ *
+ * prm.c : Plumbing code to UEFI Platform Runtime Mechanism (PRM)
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: John Allen <john.allen@amd.com>
+ */
+
+#include "internal.h"
+
+#if defined(CONFIG_ACPI_PRMT)
+
+#include <linux/prmt.h>
+
+struct prm_umc_param_buffer_norm {
+	u64 norm_addr;
+	u8 socket;
+	u64 umc_bank_inst_id;
+	void *output_buffer;
+} __packed;
+
+static const guid_t norm_to_sys_prm_handler_guid = GUID_INIT(0xE7180659, 0xA65D,
+							     0x451D, 0x92, 0xCD,
+							     0x2B, 0x56, 0xF1, 0x2B,
+							     0xEB, 0xA6);
+
+unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr)
+{
+	struct prm_umc_param_buffer_norm param_buffer;
+	unsigned long ret_addr;
+	int ret;
+
+	param_buffer.norm_addr        = addr;
+	param_buffer.socket           = socket_id;
+	param_buffer.umc_bank_inst_id = umc_bank_inst_id;
+	param_buffer.output_buffer    = &ret_addr;
+
+	ret = acpi_call_prm_handler(norm_to_sys_prm_handler_guid, &param_buffer);
+	if (!ret)
+		return ret_addr;
+
+	if (ret == -ENODEV)
+		pr_debug("PRM module/handler not available\n");
+	else
+		pr_notice_once("PRM address translation failed\n");
+
+	return ret;
+}
+
+#else /* ACPI_PRMT */
+
+unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr)
+{
+	return -ENODEV;
+}
+
+#endif
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 08c6dbd44c62..3c018870633c 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -333,9 +333,14 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
 	u8 coh_st_inst_id = get_coh_st_inst_id(err);
 	unsigned long addr = get_addr(err->addr);
 	u8 die_id = get_die_id(err);
+	unsigned long ret_addr;
 
 	pr_debug("socket_id=0x%x die_id=0x%x coh_st_inst_id=0x%x addr=0x%016lx",
 		 socket_id, die_id, coh_st_inst_id, addr);
 
+	ret_addr = prm_umc_norm_to_sys_addr(socket_id, err->ipid, addr);
+	if (!IS_ERR_VALUE(ret_addr))
+		return ret_addr;
+
 	return norm_to_sys_addr(socket_id, die_id, coh_st_inst_id, addr);
 }
-- 
2.34.1


