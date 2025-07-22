Return-Path: <linux-edac+bounces-4403-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E251B0E12B
	for <lists+linux-edac@lfdr.de>; Tue, 22 Jul 2025 18:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663281C24ED8
	for <lists+linux-edac@lfdr.de>; Tue, 22 Jul 2025 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F09327877F;
	Tue, 22 Jul 2025 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tMhl15/G"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A68277C81;
	Tue, 22 Jul 2025 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200234; cv=fail; b=EUULebFplVwVLBIfj8UMO2A+VJsRGyPxzZYl86M8RSabb7YyV9QG7SkqQWX7VfrQ24GPo7RrmxJtJrCL8R94UvJVsbco+f5ejoTWKCHWVXwRf61gRkGW9Dh7dgNsZ1mZ9MxePUnCm+PqJxmJ7mB/iitbFl34Ahaez0KKqPaVJew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200234; c=relaxed/simple;
	bh=BzuqFUXEnU/LbGsUhEeNXvZE/+eNSXrrR203xEaoSgk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t1eGkYhlLqreHDCBREWvXzP6zFyzuL0eJym2IwM+JUZbV5w3UDo1yrEV2mmQyHPTRlVBMeQedPL8eqybURQIUIXda/Di+bwMoG3ylNneT+3bPM934gs46WzhT1u62KhK3jMhYwpNW6ISxmGABeKX0sVoJKqYKfsSHCMI6RfaWok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tMhl15/G; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy7sh/BWTqBPHgjEomE/Re6rZ3kl/8Es886I+d1aadifRAGQ1j0gugRuGmmc+hjT6NAPLBbq90y2ZVYJN62w1t8zbQ4miTFaiIrnkcclniwOEJsA6vRXoL2iSnBx42UcHW/P1fyNuiWWVtbuUOuj+lxRQ1HWvFuQfoDEzyO2YJaUStgrCE6YBdpzf+HVPaz9tDTSFZPBJhRG8Sga4sUeFe7jC+PVP3dmR1hO6iAyji25/IyeztCN2ZthJf384wvv5AS8Dj6kMkN6GHp6YlcVuqegHaS4HhVXFTMB+S0i4MPHsxiaGJ+mibnR6oAl8FGm12Fu/sVlt2bmUrEkZEdbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQmW9bDJ8XUIKTmw8y5vhRZOa0b9wuT1s8m3pVLZhSg=;
 b=aVOCs8Csi5gQurbkmPacehb6Gz23sS9cZ6W+59ZEHWQnx6gMvaGFjoV7SD49IZ20XpEEqo3tE5J8wkfaO4eHvEyjh9qI01WECsTRlw3hDX5Rp/DbpEicN6pRBU2Y1yb2fTiVc0ZVvjuEz0etgx0LpH3b0mhNZ+cWOAGfMDY9Sjq+EfZ4CVG7qGMKj2FoVJYP3zLz7e37rTUvAtUOxwgR2DKMpbhe8IsZ9WdLn3BUJp7CsvSHMk8iqEwxkjV8qNhwb6ryRl6X890KVWhpi8ncl8iC5LLd08CcPksPIqO2cWVE1KNKVQoXlBckQOfWEaW62VV2taCeANG1jpPgmw1v3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQmW9bDJ8XUIKTmw8y5vhRZOa0b9wuT1s8m3pVLZhSg=;
 b=tMhl15/G9rlIXtJ7Od+h0dfQTHRnZeAww1uEpZjN0nWY3WW0lT13o4KXxY61vor5U16t/qJf23l1UBhL0ltS9QSuVCcOJ92xojvqWRNIv9o8yDIPvdeAAydRTcDitu5t9Tmmf8BG/P3E/Ze2r24fHypVHHBifxPXoZmXtCu9Gm8=
Received: from SN7PR04CA0072.namprd04.prod.outlook.com (2603:10b6:806:121::17)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 16:03:49 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:121:cafe::fc) by SN7PR04CA0072.outlook.office365.com
 (2603:10b6:806:121::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 16:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 16:03:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 11:03:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 11:03:41 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 11:03:38 -0500
From: Rama devi Veggalam <rama.devi.veggalam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <james.morse@arm.com>, <mchehab@kernel.org>,
	<rric@kernel.org>, <git@amd.com>, Rama devi Veggalam
	<rama.devi.veggalam@amd.com>
Subject: [PATCH v2 0/4] Add support for Versal Xilsem edac
Date: Tue, 22 Jul 2025 21:33:11 +0530
Message-ID: <20250722160315.2979294-1-rama.devi.veggalam@amd.com>
X-Mailer: git-send-email 2.23.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9790a4-b09e-4da8-9f04-08ddc939588a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SNX57G3Y2lLpbRMhaR30ZcJwFFSQzHHKBLqAz8tAX0l8aYismaqgEqMxVsN/?=
 =?us-ascii?Q?h2uriQ7F7S/5ox+5wq1O9gJD0WtuwEbvUnRQcaUE6xuCPXrNmNsBtfwRHKS+?=
 =?us-ascii?Q?OyWlZw1wFI7vEfpRy+Y/xQptGw16XZ/TkjxYPfdBtnZN+xsDZGRJMrZMjY20?=
 =?us-ascii?Q?zz9kvlcgGxsjog7tgeAfYAEfeQwkdrU/oJk88q7FYOZk3A1ENw/wOYiAsKOg?=
 =?us-ascii?Q?Vt1BR5qbtF6+X+4jGVGD1LD7h8k9lanw84Yr8kmRDcqrQdhB2YcpQd7O7ytF?=
 =?us-ascii?Q?kEbTAj+zTWcMM+sSMMSrWKU+K1abNeH2kcNyV7+c3xVqFyvSnayoCbKwCQXc?=
 =?us-ascii?Q?C7eMYxbTEjtNRGFoORSm6/gnrTfi79DAZBBdt/TPpjUIcCgG6+KSCLolIl2x?=
 =?us-ascii?Q?Qd39ZyxYmVq2SA9jsR2vEMyirU6H3WVG3gRpqARz4YIaTBuhD5lYaiZPCGP4?=
 =?us-ascii?Q?BRhGj3ja5tJwaeu+O1kzR9BwJUxYXd30yvQvHT6PtrkHzU6VvDYu4o1jwy4A?=
 =?us-ascii?Q?vCNozNMOZOy0eqio8LlYWpCnr2J8hqxi6hhKoKwu81Ds91+3lq4zn227g+zi?=
 =?us-ascii?Q?Gb3/p/4T6Oja/+bFb0+MWIoR02iQsYRF1mJk/AEGUKXBygjEw1ia9J50157H?=
 =?us-ascii?Q?zrqtJAeySZC7w4+x/gXtkc0E/8XUEVtM246j9npcUA5g/4U8sJ89y7zy7PfG?=
 =?us-ascii?Q?sOE8X8E1MTohVSmeggZCX1ZMLAINamdtDSd2oWmpnVqx//osgpVCaVDQ0LeU?=
 =?us-ascii?Q?4zhTpmCxMo+KeBniTg3AJYBx2/UKfVRP33wZzTFvNNcxbjKWr5vviDMHf/aj?=
 =?us-ascii?Q?tRosV0kVhcpCAAf86jCWpiyLi3iTCXJ2/hidKG++Skl1R+vghADrNYyWFn/9?=
 =?us-ascii?Q?aKA0RSQDI4UWU9vZI9P/IqeY/UP2PrLVvSX9G+X1kOBavQPYR+EYN+ETG2OD?=
 =?us-ascii?Q?qe0O+TI1V/NmZklz5AzWD77QJaIbv80lLxLtZPly0l0GGOcXShL4JdxFc2b4?=
 =?us-ascii?Q?qOSU2ZOy+skpji0oa9Q1dcjHKddA5rWYirNuvg6vDQqNMG9WgEM1cJEfybSt?=
 =?us-ascii?Q?Y02R74kvwa9zArfUjRofnQepubAND7b8kgC7JYZEf9dUYnBzKN9tulB2HWZe?=
 =?us-ascii?Q?m2rlLdgWqcuP+e8z7xylqLIZufCNBIPZ9J6a1vaGtSAT1iGJttvLQbKfeAtV?=
 =?us-ascii?Q?a99aabi52i+mGFpFPeJUGuNMkja5cCqpHmL5kyuQWxffktvZXSmDJCxA9zTL?=
 =?us-ascii?Q?l9qAspuqRB7IQElz3ofJEgbydRNhSazJhh0ZmBBf3bSeZW98NSIqMxOzz3Zz?=
 =?us-ascii?Q?nGQ3BXqWl0honiiFhjWKC/gxOtHyye4LB64btT+3FAmUhtRSX8WFvQlJlCCJ?=
 =?us-ascii?Q?3MC7sWb/mvVooE15or7wglYI17dSku3XMHDdheQX6xvSa1jgO1rBpXTq6wMn?=
 =?us-ascii?Q?tSs6Zw66zEWcbN25n4q88ztlmT0jx0728MrzRrTHP9nhw0nkhxZd8jjBYUpU?=
 =?us-ascii?Q?PHkMkTf7K77rvhT+60GUpBPsip5p5aPFtE+o?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 16:03:49.1526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9790a4-b09e-4da8-9f04-08ddc939588a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177

Add sysfs interface for Xilsem scan operations initialize, start,
stop scan, error inject, read ECC, status and configuration values.
Handle correctable and uncorrectable xilsem error events.

This patch depends on
https://lore.kernel.org/r/20250701123851.1314531-1-jay.buddhabhatti@amd.com

Changes in v2:
- Patches created on top of dependent patch series
"enhance zynqmp_pm_get_family_info()"
- Removed non-relevant SOB names in error event header files
- Added details for eprobe_defer conditions
- Updated copyright information
- Merged Versal and Versal NET error event definitions to firmware
  patch
- Updated "Date" field in sysfs file
- Changed "xlnx,versal-xilsem-edac" to constant
- Removed unused macros
- Fixed formatting issues
- Removed ARCH_ZYNQMP in dependent list of XilSEM Kconfig
- Added error code for invalid versal device type
- Removed redundant sysfs details in function headers
- Included MAINTAINERS to 4/4 patch
- Added more description in commit message 4/4
- Removed "items" in compatible
- Fixed indentation in examples
- Removed print for probe success
- Removed function comments for remove()

Rama devi Veggalam (4):
  dt-bindings: edac: Add bindings for Xilinx Versal EDAC for XilSem
  Documentation: ABI: Add ABI doc for xilsem edac sysfs
  firmware: xilinx: Add support for Xilsem scan operations
  edac: xilinx: Add EDAC support for Xilinx XilSem

 .../ABI/testing/sysfs-driver-xilsem-edac      | 104 +++
 .../edac/xlnx,versal-xilsem-edac.yaml         |  42 +
 MAINTAINERS                                   |   6 +
 drivers/edac/Kconfig                          |  23 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/xilinx_xilsem_edac.c             | 746 ++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c              |  91 ++-
 drivers/soc/xilinx/xlnx_event_manager.c       |  10 +-
 .../linux/firmware/xlnx-versal-error-events.h |  49 ++
 .../firmware/xlnx-versal-net-error-events.h   |  51 ++
 include/linux/firmware/xlnx-zynqmp.h          |  47 +-
 11 files changed, 1149 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilsem-edac
 create mode 100644 Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
 create mode 100644 drivers/edac/xilinx_xilsem_edac.c
 create mode 100644 include/linux/firmware/xlnx-versal-error-events.h
 create mode 100644 include/linux/firmware/xlnx-versal-net-error-events.h

-- 
2.23.0


