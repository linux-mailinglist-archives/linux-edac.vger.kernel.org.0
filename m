Return-Path: <linux-edac+bounces-2601-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CBB9D5CE0
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 11:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C451F22072
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 10:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6931D968E;
	Fri, 22 Nov 2024 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="En+POqe7"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27511D61B9;
	Fri, 22 Nov 2024 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270006; cv=fail; b=ij6CqBIdSaYaHMjbqplOibu1tp18YMkQsuj4rnIb6jhldoiH4IBtYRnIPKlQ1YKr+En7NVadHn/5TWHEVUo8DSzbnwZa4cPh5Ftq/Uavf07lOqsIcSBpL3PjsRkZL1K6+SOyUeT4pgq2pmg/00MKhaNthQz0JPbm7MnSWZ1kj4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270006; c=relaxed/simple;
	bh=T7SzCYaLG+4rdxGylS6ORSpp/9fEKr3rlO+1pVDZkb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwoypu/yCGg95QeJIQiocyPkWg0MGN9G1dwufzblONOJf/JHuMSC5Jr/WxXljGAuYS9l/vWztMyM8Z/4H1sV6RlSLNrUeqq4QQbnOIXjSUj9fbCzDBwdxiAdXuPGWUgNexAn34YFlAHBQf3UsXQgm9pvMRNwu1YHOS7hHK7iF5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=En+POqe7; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHxLHaC/ENlIXFV4hVjAnOtwqiiW5ywdLM7Cak9KdFaeNRbdPFWvmVdST/HSZzXzNdRV/DLdLbOw9OG0NrC7gmKfTN3wK/8E9b9yX8E2HKzF35UHPlGZ6BYr2WcZGOAVpOGB3XEd/70Lvw18WLOjRyfn2j8ltS0CC7IkVIx5zugcVEGfk+WYsLOqdQmlPJXjOwyvPNdU0rZWsDTZaqme0Sc3yM47W0AqFfDKzkr+i4JRBvbBvRcd+tiwnFdoDEtpnd+NcC3Xvdc1tLZHtID+W7pGg0U5oCvA+4vo4dSKZhtA8fSP8v/HGBYB1CFnF1zqrHqumYIaXetB5GERX2U2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/zc6ScvZPuEuI8pjbByFsOkOTOILifjgyX8c5SdPlU=;
 b=n3Xc2Oybptw5Ujtpe3ticrw0Ho9Qc03+NRHNtHcWxUZJoFgDZkEFS0b/xuHR0o2WdtFiaaP4mnXn7UiHGA9uj2WwMmWANpgmHZBORWul3asung0k0JOAo1WJynjBXH9360frhEvIPaUF16wULqK1IKQyuH8I6yzH9Pa15nsccUSvSTtub1v6XShVAYH3LXYIq/1VQwYwP9/CjbuxKTOmFo96JsFBqiTjJDdW/UW46rlygEv6de8KOv3Nd36a3jX5boeL0s3g+gCsId+zy/QunYsyT8IVJnPzXzpECpeM9g6qvFUkynQNlAH0C8xTNGPlPODmy5PTc1dPlajQU5hRog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/zc6ScvZPuEuI8pjbByFsOkOTOILifjgyX8c5SdPlU=;
 b=En+POqe7v1ludOxgxhyeKXI0HSJzom5IpoHupKgtSDHu+bGzP8E7Wd7QXDczKXPHewesW65jXkyIKortcusxxQLtb6CrZSQXvjXO1d+9yK+tN4NfpZuRMkVVmu1wBZJHLHtAvHgyoA4I5FZoXT/1UtgLiFAPz15lNHDUkZr+75k=
Received: from MN2PR19CA0042.namprd19.prod.outlook.com (2603:10b6:208:19b::19)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 10:06:40 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::a8) by MN2PR19CA0042.outlook.office365.com
 (2603:10b6:208:19b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Fri, 22 Nov 2024 10:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 10:06:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 04:06:39 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 04:06:38 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 22 Nov 2024 04:06:35 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <krzk@kernel.or>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
Subject: [PATCH 1/3] dt-bindings: memory-controllers: Add support for Versal NET EDAC
Date: Fri, 22 Nov 2024 15:36:23 +0530
Message-ID: <20241122100625.24571-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241122100625.24571-1-shubhrajyoti.datta@amd.com>
References: <20241122100625.24571-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d55d4c-0f73-441e-7d61-08dd0add5bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gaa3fVUuKEpwjr1Z56WMiyDeIbNnGHxhOPda+z9/8tVQoGbgumlcEXtzWIO2?=
 =?us-ascii?Q?R7DF4JBufnyCVnVk7jlsrnrDyZjVzEpVRqXvYHBaHUie1IU2d3eBPudGrwb9?=
 =?us-ascii?Q?Q/d2RUDxr5QcO8j5C3tWNJ5i/UBbfg1rOVh8uCTgP8egYUAKCJOj7uT/aORX?=
 =?us-ascii?Q?TnNBkYyuEC63eyzniagF7n8WozNAEbaOv7ko8lZ9yeLq6IZjxrb4WwLeKfl3?=
 =?us-ascii?Q?n41Ib9SMoc5sujdvtKSOpVDQnv7lDVKKkw80Z8gbPAnPXvaM3aW1laXB1z+T?=
 =?us-ascii?Q?MtbtaCbuxFayK3ZBuqV0UZJN2Dn6IaZSs+DWjTpeA9j8NiK3fVcWpkYusZRQ?=
 =?us-ascii?Q?kKb/2pxi5o7To1AtTi0zLp/cDnYX+24EEKl3b69H51s+s1vGzBmqf42B5PWw?=
 =?us-ascii?Q?LbporjE2OssXPI6+7dwagQU7hdd9qV5Lp+tn5gRUesJ1mNYc60GeSSyyu2jc?=
 =?us-ascii?Q?nvG+rkS+U0nBpTfNdKcVHuTFHQumi+JhlR67CsmB07wunDSJfo6xPSuDY0qh?=
 =?us-ascii?Q?+VO0ub0/GvjzbRAno6VvxaX/Dqu4a3FsxWfVCzli8f4PXaVjtJG0bQvKfPQm?=
 =?us-ascii?Q?C+pCUzM1ZuqqdOBFnUjThEwAtnPERQWfJineDcxudasC6TsjTyxoEeOK18/3?=
 =?us-ascii?Q?onU1/vCAEQsohK8HfjkWvdifaLRPnn2kpL3JVv8+HVP7l1ZORsofUS4tp9C8?=
 =?us-ascii?Q?Uoivj4qzqO0mkKNneGpMaR9E7M0SymrRqv66Hi95XfUEXeRpXJb1uene77C0?=
 =?us-ascii?Q?QRBi1vyGX4zlEtHLpViPFFqPeu6s8VFiV7j0F7n6TtNCIRPlAQFTzq/ti4an?=
 =?us-ascii?Q?huQ4wI/vQKUbTNHS182wWhCSit5lzgcDkimJtg95eF23DPmkSpLeOJ5I08T7?=
 =?us-ascii?Q?ZoP0akq9F0Rx/B31vn8NfY5CsNoV7yjGC2p+iTdg0CqrcqRW1NTsYw1t49wE?=
 =?us-ascii?Q?lgHtFkrcpicgCYl7a7ApsAY6nkuvk8UcG9kAnXXrlVdAvxWZkuugAQ+ENRXb?=
 =?us-ascii?Q?7ov8JsvPsMzKhvdtWw03VQsom3bzNznWAiOlU9XjKKBELWge7GK6/c79MCOR?=
 =?us-ascii?Q?j76CcrRHlxUY5LgR7IAQFEfORNtwiGTVtf+Jcr0jEh62zVpFY0i0KbjYECpb?=
 =?us-ascii?Q?ilEq5FN+ldw7UjC9LZjM3Zhu9hmnqljCfR6pYMT02wT5cQJkxbOP08qRD2UR?=
 =?us-ascii?Q?WmoccBHHrb5OpbJqRwmWMKb7xIuSrZPQOKpFSSZ/QkFLxtcMey78qMKxKG5D?=
 =?us-ascii?Q?AnndeL51S4BEaeYjz1XQjqV2+l0/xyQ7WlaEo9nihfjjDqyQ+doT0NkBhtVn?=
 =?us-ascii?Q?FDTTrDRaHJgGn1eNaGTUjBqdXvVtj555h2+YIcajiDqZ5FfPn69w/pziVXQr?=
 =?us-ascii?Q?OuLfA+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 10:06:39.8998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d55d4c-0f73-441e-7d61-08dd0add5bc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452

Add device tree bindings for AMD Versal NET EDAC for DDR controller.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 .../amd,versalnet-edac.yaml                   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/amd,versalnet-edac.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/amd,versalnet-edac.yaml b/Documentation/devicetree/bindings/memory-controllers/amd,versalnet-edac.yaml
new file mode 100644
index 000000000000..22a4669c46b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/amd,versalnet-edac.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/amd,versalnet-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Versal NET EDAC
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+
+description:
+  The integrated DDR Memory Controllers (DDRMCs) support both DDR4 and LPDDR4/
+  4X memory interfaces. Versal NET DDR memory controller has an optional ECC support
+  which correct single bit ECC errors and detect double bit ECC errors.
+  It also has support for reporting other errors like MMCM (Mixed-Mode Clock
+  Manager) errors and General software errors.
+
+properties:
+  compatible:
+    const: amd,versalnet-edac
+
+  amd,dwidth:
+    description:
+      DDR memory controller device width.
+    enum: [16, 32]
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  amd,num-chans:
+    description:
+      Number of channels.
+    enum: [1, 2]
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  amd,num-rank:
+    description:
+      Number of rank.
+    enum: [1, 2, 4]
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - amd,dwidth
+  - amd,num-chans
+  - amd,num-rank
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-controller {
+       compatible = "amd,versalnet-edac";
+       amd,dwidth = <32>;
+       amd,num-chans = <2>;
+       amd,num-rank = <1>;
+     };
-- 
2.17.1


