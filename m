Return-Path: <linux-edac+bounces-1586-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F601941558
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 17:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144BB283192
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A971A38EF;
	Tue, 30 Jul 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uqaUhD8I"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714E1A38DE;
	Tue, 30 Jul 2024 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352769; cv=fail; b=sX6xgXeYPRB6ACZ+UJ7Ny0RbTHn/ICQOkXIg8Bj0252+t+jmtqohTzFhtavwb7tE1CqZ29FOClSFtEg5QBXUv1a9rhOaAsn8zgLNFchWdb8/G3+LnO8oXv1pM/ZCQGYsYOki1yEKHQC1Ret8mGLiiIxhb2AY+HzoZDK+A1yFVqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352769; c=relaxed/simple;
	bh=cuJAGLWeRUc1HLYty2ljcRYRFrgc5EvSOhg+eWsgi6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bw2xKkykV42PeYY3PMBQ4OT35RSMyoAOeEMFNgiLE9AOQIeptdJBRSNUd/D5GtELo1Y7NrX7SN39huz+dFDdT71Z2dIoCHe3QFbkyynd4f3jqNGvmsK0ak8z2eiGIlDWHMdf3aoCwr9kEwR/EfaOqSyMyzaabcoCABmh8u4yyoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uqaUhD8I; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeW2OIQKfOBzREC1ZmXBtzSn1yZpToz7cfpiCAoTjp7VYhm9iiMHcABh+FA1VG/DBdAmAG6t8fOx8uQJOw7fP20F26rsUUGoGVhAtSkU7dnQErNWRtp+wpD8EXS7r8mqTTIZN16LZ4aUkNAPFnEDYtycfXFGCflOnR3IRtCDTHXh0QLKeqvSPLIEIOgXi7AQHtDpjvSBdkFsPZnBdVoxmH93WumXgTBh0YbJb5yhpdDwGeuq8f4KCr+jD4BKiYa+wYlpn6WD/L3XPPQno7byPlii0RBIHxgrQGtwJbpTwl/hCUJcbhZFHRHvqrQ79cPbK4lQJ0N1RMiuR4/CxhvRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iDpznTtQWM7DYsYxMk3lL6BffX1299LsAyt5kKlh2Q=;
 b=BeR/kO3bXjWoBcdupOcMVfcMciooI3rILdHsYTnVuYtdAGwZZIc8+8AGhOJiiWqYUHyFOusOt/zwmgHQ2gyrO3LJyg0La0eIyG8SIgwrUI1CABT4LDp7o9VXCZF/uo6GIJVkp1BkXmSdFSuQDhhaY5byfrh+TYfH+GBaQ7d61o4DL6zGeXs2dFZGgOOIZJLuNe6GcfeEaCWEv4GLvnZ33CxT91HW9J5TKgW9fM/YuMOvZ7MJle6lTUjjZ0eiZX3zyb5YFpovCmmrQMsa1HkUlm1CC4BLUVuc5BGLQ4fASPJiJGV1aRAv3hWS2QFzK+NHS4j08xe3QX+bPs411y47lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iDpznTtQWM7DYsYxMk3lL6BffX1299LsAyt5kKlh2Q=;
 b=uqaUhD8IHEBbsX9glbHIZ7P5tjrW07McX6U17MhZIc9kil7DR2DyOeRFdKhny9yYl7YiUn7xOVrgGvQ/sb/1+ffTeO+AFN1rc4+WijZ661Dk50llCMWgNrkc1LDxUHOyalv9pOZ0PpMYldZzh23NX0IGNaZo2+M2uTAQvCqxhEw=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 15:19:23 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::a7) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 15:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 15:19:22 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 10:19:21 -0500
From: John Allen <john.allen@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<yazen.ghannam@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, John Allen <john.allen@amd.com>
Subject: [PATCH v3 2/2] RAS/AMD/ATL: Translate normalized to system physical addresses using PRM
Date: Tue, 30 Jul 2024 15:17:31 +0000
Message-ID: <20240730151731.15363-3-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730151731.15363-1-john.allen@amd.com>
References: <20240730151731.15363-1-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2254e7-9053-4d1c-d3d7-08dcb0aafde2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qmd2cmZKUUF2SFdkY3hveUM2NDZ4OElRREhzUVlkVDhvMlNBYUJKNFZmMG1z?=
 =?utf-8?B?NEVwUCtmajJBTklyQVMyamV2Z3FkNkpObGY2UGZqKzFESmdYREd6bWdJZHpx?=
 =?utf-8?B?YVNFZ2IyNnFhdGI4UkUvYTlZUXo0dk1pY1hzOCtCN3FXbW5ta3hJV1VuRXp1?=
 =?utf-8?B?S2JsMkhlZkwxRDNNNXVuMzlsUVovV1VsM2svbnVxTHhxUEwxNDdyYkdueHl0?=
 =?utf-8?B?c3g3MTJKclQvNDlpd3IvbGc2NGxVaW5BcjRqNHY1UkliUktqancvUlVBa1ZN?=
 =?utf-8?B?aGJNNDVpVUF1K1BJU3VFVFF6MnBRZisrWnZscnFzMFNpbjlTVFBaSUNNL0wv?=
 =?utf-8?B?N1N3TEhSMGxBWXArUTRnT2N3SElZam4rRlM2d3NVV3htelVTRzVrZ2VmaCtK?=
 =?utf-8?B?Mktpb1VZa1E1eDVzdmZOZEZUNFRhSXU4TGRXb2cwdGgxeTd6aGRlWmdMbUMv?=
 =?utf-8?B?ZzNhUHhNd2RoQ1poWDRGTWg5Vkc3MEQzWTllSEE5MTVGTkpBRUlKTlBBeGZn?=
 =?utf-8?B?QjN6TmMrRktSOHo1Z0labXpFT1N4Y1NWZm5OVHd4RWZEM091ZTVmaDFFNFJW?=
 =?utf-8?B?OFhjNXNWOHhlSnFNa0pqQ0FQT0pSbGhic0VQOFRWUFBVYk9XZUdGeU5aRFJT?=
 =?utf-8?B?dFBHTTg0WjFYcGJ6MmE1ajdwWHkzbzF2d256WXlMRWt3eTNZcHFEUVNkbWFQ?=
 =?utf-8?B?VytZY2U5cHhKYWl6Q29oSW9mSEs2enppcDd6NGRxcHFxTFlkWFpPY3ptdkt2?=
 =?utf-8?B?dkEreDcyaGczNFNITE9OSXM2MFhkVmpwNTBaQ3d5Ulh3WVgxeEE2UEwxRi9q?=
 =?utf-8?B?Z0x0N3BqdTYrL3JjZ0JFdEtCV1NsVFltc1E5MmhuY1VvNzhWcHVVYVJLa1d5?=
 =?utf-8?B?ZmVUajVKQmJuQVNnTHJpbXlmY09zR1l5TEhZNHo2SVE3R3ZBOVJjSkFWQTV6?=
 =?utf-8?B?ZlJTUTFXZC9vU1MzNkU1ZmNJZENDUG50UXJMTE52TEU4N2JPWS85V3MzbzNx?=
 =?utf-8?B?MVY4T2pBV3VtTEFIQmt3bVVnY0hjMGNnZTMxS0huTXZSZzFZZjNZZWRnMm0r?=
 =?utf-8?B?UjRVV2lrUDE3R29zK21oYXZ6UlNxR21YeFc2SkhhQzY1YkRIVlpZV2lFTEZH?=
 =?utf-8?B?VGQwTVprVFJ0cGNKRnU3bDdnOWhtVGxMUElWaW5GQ3Q0MzBIaFdRRTNTa1FV?=
 =?utf-8?B?TGVrUm5WZzZhUFVWZVJ3bkxlRGxueG1JRGhhekpVU1h5M1JlSzBYdGZ2NFNr?=
 =?utf-8?B?dDZ5NWE1L3c0L0Exb25UdGtPVllrYVhzcVc3UkFlQlFLdk4xcTg0S3dMR1Nv?=
 =?utf-8?B?SXNkNHlMRU9SZ3dZUUdWN0Y5SExreDZLaHdtNmhUeFZ2STE3VGVxUVhFV0NO?=
 =?utf-8?B?S2ppbXNtS1VzMmlIc2NGc2RVTFNFcENPaGEweEJoTlFtdHBibnh4R3FKVXVK?=
 =?utf-8?B?a1kwUDQ4cmF2aDRwd2J0OXdnalNzZ3hVU1JUQ0ZXby9JV0NqNFVSWXhYYWJn?=
 =?utf-8?B?OHMreFJqbmtCRSsvMmxwektLS2drZm5tM0JUNTRqU0thOVNIV1BFQWFtdWZ3?=
 =?utf-8?B?QTlMazRNdThHMlVHMmIrUGVtZkJkYjZhQXQ3dENydC93TzVjeXN3aGZscW9U?=
 =?utf-8?B?d0t1azZHK3hEaXZ0ZnNGNkJhZmU1UzZmSDhjWHJEUExnUm9uWU1ZZEpLVEI1?=
 =?utf-8?B?SnRaSldIWTMzdHZwdHpIMlBTcjByRVI1WmxqS1FINThDNE5XNlhxN1FtN25h?=
 =?utf-8?B?QUJIZ0NnL1IvY1FCTERDRnhIM0xJakxENlZRbmRVRFVBK1RwVUs1ZCtCcXFN?=
 =?utf-8?B?d295Vkp1b1A0TWxLV2JHOWFGYzVFNVdKSHFEOEtnQ2cvbmxTeGtxRlF0cGZy?=
 =?utf-8?B?d01DWFkvMzg2bEtXYktoT1VwV1JRVDVZd3RIUmg1U0tra20vaDhhTzV6eGRN?=
 =?utf-8?Q?B2gydtVWH8LRzx856T98z6C8WCks3fzg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 15:19:22.8635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2254e7-9053-4d1c-d3d7-08dcb0aafde2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509

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
ACPI v6.5 Porting Guide".

Signed-off-by: John Allen <john.allen@amd.com>
---
v2:
  - Make norm_to_sys_prm_handler_guid static.
  - Change pr_info statements to more appropriate pr_debug and
    pr_info_once statements

v3:
  - Add new AMD_ATL_PRM config instead of #if defined(CONFIG_APCI_PRMT)
    in prm.c
  - Shorten variable names
  - Update file header to include reference to the ACPI Porting Guide
---
 drivers/ras/amd/atl/Kconfig    |  4 +++
 drivers/ras/amd/atl/Makefile   |  2 ++
 drivers/ras/amd/atl/internal.h | 10 ++++++
 drivers/ras/amd/atl/prm.c      | 57 ++++++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/umc.c      |  5 +++
 5 files changed, 78 insertions(+)
 create mode 100644 drivers/ras/amd/atl/prm.c

diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
index df49c23e7f62..551680073e43 100644
--- a/drivers/ras/amd/atl/Kconfig
+++ b/drivers/ras/amd/atl/Kconfig
@@ -19,3 +19,7 @@ config AMD_ATL
 
 	  Enable this option if using DRAM ECC on Zen-based systems
 	  and OS-based error handling.
+
+config AMD_ATL_PRM
+	depends on AMD_ATL && ACPI_PRMT
+	def_bool y
diff --git a/drivers/ras/amd/atl/Makefile b/drivers/ras/amd/atl/Makefile
index 4acd5f05bd9c..b56892c0c0d9 100644
--- a/drivers/ras/amd/atl/Makefile
+++ b/drivers/ras/amd/atl/Makefile
@@ -15,4 +15,6 @@ amd_atl-y		+= map.o
 amd_atl-y		+= system.o
 amd_atl-y		+= umc.o
 
+amd_atl-$(CONFIG_AMD_ATL_PRM) += prm.o
+
 obj-$(CONFIG_AMD_ATL)	+= amd_atl.o
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 9de5d53d0568..143d04c779a8 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -282,6 +282,16 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
 u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
 u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
 
+#ifdef CONFIG_AMD_ATL_PRM
+unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr);
+#else
+static inline unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id,
+						     unsigned long addr)
+{
+       return -ENODEV;
+}
+#endif
+
 /*
  * Make a gap in @data that is @num_bits long starting at @bit_num.
  * e.g. data		= 11111111'b
diff --git a/drivers/ras/amd/atl/prm.c b/drivers/ras/amd/atl/prm.c
new file mode 100644
index 000000000000..0931a20d213b
--- /dev/null
+++ b/drivers/ras/amd/atl/prm.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Address Translation Library
+ *
+ * prm.c : Plumbing code for ACPI Platform Runtime Mechanism (PRM)
+ *
+ * Information on AMD PRM modules and handlers including the GUIDs and buffer
+ * structures used here are defined in the AMD ACPI Porting Guide in the
+ * chapter "Platform Runtime Mechanism Table (PRMT)"
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: John Allen <john.allen@amd.com>
+ */
+
+#include "internal.h"
+
+#include <linux/prmt.h>
+
+/*
+ * PRM parameter buffer - normalized to system physical address, as described
+ * in the "PRM Parameter Buffer" section of the AMD ACPI Porting Guide.
+ */
+struct norm_to_sys_param_buf {
+	u64 norm_addr;
+	u8 socket;
+	u64 bank_id;
+	void *out_buf;
+} __packed;
+
+static const guid_t norm_to_sys_guid = GUID_INIT(0xE7180659, 0xA65D, 0x451D,
+						 0x92, 0xCD, 0x2B, 0x56, 0xF1,
+						 0x2B, 0xEB, 0xA6);
+
+unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 bank_id, unsigned long addr)
+{
+	struct norm_to_sys_param_buf p_buf;
+	unsigned long ret_addr;
+	int ret;
+
+	p_buf.norm_addr = addr;
+	p_buf.socket    = socket_id;
+	p_buf.bank_id   = bank_id;
+	p_buf.out_buf   = &ret_addr;
+
+	ret = acpi_call_prm_handler(norm_to_sys_guid, &p_buf);
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
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index a1b4accf7b96..dc8aa12f63c8 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -401,9 +401,14 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
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


