Return-Path: <linux-edac+bounces-2761-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A98F9FED4B
	for <lists+linux-edac@lfdr.de>; Tue, 31 Dec 2024 07:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE43A3A2AC3
	for <lists+linux-edac@lfdr.de>; Tue, 31 Dec 2024 06:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEF518787A;
	Tue, 31 Dec 2024 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qs+XqNip"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693418871D;
	Tue, 31 Dec 2024 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735626921; cv=fail; b=odB29c0zG+Yv61r0+ToTKoFLRB6FPHOcWsLYDP4S0JPurA4MbIPVBz6jwPs9t2cv07XeEk0DfT/P+dOOEadhAeJzqc+Gax1qej6QXWzfvQYRqCwPQl2Yo5vxSxydsjvASY2j5nMfo7y7CY11OUJeRyG5PMYyIVUni6P+7Rzssx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735626921; c=relaxed/simple;
	bh=qPlX3tQVVBWrKmqd3LEq4gWDRkKOz0esahuCzv2O8ig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQfjEbdZUATqykcuX+rsbUTFlgpWPjCi0mpNqkpCIIU+3JNhICNuMOcn3gbiUVTVbOcJc1Ta3tjgjZy9b4N9htp2fycA+GORE7L6slDDpziCDp9e4xVY0k+6qRJhIhEVPnzkTrz1+ceG+IGiSev1Az4DxDoggOVs0M5RzwnUD+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qs+XqNip; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBTvS4ETmmPqGzpcBMfvfYnHgM1+MBMhZtfH73SGNkK7xdFDTOQ3G8hDNlQmIzt+GOkrxDnVG6baEOpHY3qZFPlHkjNKcrCmGGHlwYisyOD4fYaH3HDy5f2S5t3AUzo7++TTv1sZqBUSPk+E3QV4cDcROIc05ivV1q9RDKvjmz2uTa0L1BC6xHcO6fB9d2ocWADQDFp8muWmRJDOM9PzUD1jlT3y6rz8PxPxEGVfRczQefP2OVFASxaA/Ok8V5vvh2maWIUDwRw9exYnd178TAnNkYNwIbj4Vlpa1t+Rt6M37/KTaVqYhz+waHK4nitVOp2vT5Ic8CqP7vwEBGK/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQjoEZtgHGPdpjm68hDG4x45btP447dUU8L+uqjWgZ8=;
 b=k2ppqThEuhl+dXdLY61EDJWqs89cSBcfEMGg2IHI8f7wEGECvjhgUY1I1wD6DeUzfOQGIPImG2FRKJDcaJrS3ohDgsaxc03TsE7L9kw+Un11KOH34s+r5e5L0mNyzmNp+z4ieQKVMxND8Z7Sb58wiZKEtFghRjQbE49YpMC7A/DBt+jhX5+HFJguEHNgaXCCYNO1dmtN0gw3jMx5WmuwDJIPTXa9BCSRedmd6nyg/pqSyxfDIesI5vURdEZ4YWaGy5NIWNgrubncKS6nFhuTD/vkHZfWEFr2MkMmTsdWBkHQA1oW/HFJcK20s3bY80vnz7ouWdh7c9U3nEW+3xpFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQjoEZtgHGPdpjm68hDG4x45btP447dUU8L+uqjWgZ8=;
 b=qs+XqNipjPSjYF1bS+QJDb5PyI0vSzqv31FJirEEdcQYLapZmhG447we23cwIbOxCkm9d+wqNapQjihk/0Dcg5SLef6XftJTLdXAydZ/JhuIt2K3Aq36vDKsLS5im8Physit/QJhWLVAzYQn0vB4fqeEL8ggRDixzjBVhlf7MQI=
Received: from MW4PR02CA0022.namprd02.prod.outlook.com (2603:10b6:303:16d::15)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Tue, 31 Dec
 2024 06:35:13 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::8) by MW4PR02CA0022.outlook.office365.com
 (2603:10b6:303:16d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Tue,
 31 Dec 2024 06:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Tue, 31 Dec 2024 06:35:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 31 Dec
 2024 00:35:09 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 31 Dec
 2024 00:35:07 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 31 Dec 2024 00:35:04 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v3 4/5] dt-bindings: memory-controllers: Add support for Versal NET EDAC
Date: Tue, 31 Dec 2024 12:04:33 +0530
Message-ID: <20241231063434.26998-5-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241231063434.26998-1-shubhrajyoti.datta@amd.com>
References: <20241231063434.26998-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: bb428c38-4eec-4b69-12d3-08dd29654796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?imCpoBNX0Pt3sf1fSHGRM924hoYjl8OxRXmmg29RIuZvLr09IUk6E8O5DdCS?=
 =?us-ascii?Q?IFb4gRBp2DPhPq1f8pCZNQrEYFakMxJrdmdd1P74o7YCRO8aBmSR7qeMUpIc?=
 =?us-ascii?Q?LFoEiBpxI/ZzWWVdh+WIelZ2dEeRn+ceMiIy8bNFGrQwU7YVx20djWl16Mts?=
 =?us-ascii?Q?3YQWRWNVvzHF1s2J8U5G8k7sSpKF9K0jF9DPm4qwg6yJtkbj53USCGrqc1b7?=
 =?us-ascii?Q?W9FtpWVsZX12LlndHflfl9VjT3p7QYafU5PuUFb6cDQEzsst+Nn1SFujbii8?=
 =?us-ascii?Q?XF7eBBNBTuhwzlFlqgxg1rM2shKuxk3+qMYFTLGIUaEbtJYOmVw/bLizl3If?=
 =?us-ascii?Q?Hl0N5uoGjMAm/l9uiwXO1bGufqX/Vysrny76RuwgVaMcx22qiD+mbQxPP8WW?=
 =?us-ascii?Q?Yb3zv35ulnljExxzUh743d79yrB+aRvajOZZUKo4fr0sFZxytYDrLJ9ZtpmE?=
 =?us-ascii?Q?cxSr8KN7vrZct2mABUXI1FThp8edM0ImBXLj0HKljRXk1gEJRvkLeh1gI/xm?=
 =?us-ascii?Q?jLaUjTlSxmF3i/Cu3/fojGSSO7rVl6NLfcqEsp/2a5CdnXkU1ax7jPRfNVPM?=
 =?us-ascii?Q?4zJCR+zcZGu+PEI4LUVna5aQ551wJzTJYYV9tBTxrVlxvBcsS3ONFK2UDrWf?=
 =?us-ascii?Q?up444YjVfUZULA4KzREOIEK4HXOIM/NsdzHX/ObanDnrPh4jVH9zB32VxdaM?=
 =?us-ascii?Q?xKbTooWClm0MDPeTeFHpttUXqEPKDOWIvukaXMbuR97DtFM7QrlpCIAKEAvB?=
 =?us-ascii?Q?cfhE9MgKb87iJ8z+P4j0uO2q/cadWpwwggt3rlhYnVFog1CV9d2I2H95EnUW?=
 =?us-ascii?Q?3xH0JXdtXRwqEkNk2L8Qcp1DtgkgJ6nxKhTib0gRHG0x+A0HQLk1nqIOvOY7?=
 =?us-ascii?Q?qa+t9zasd92mmpLuUfFXL7CRTGtrE8axf4eoTxggBDXv9zlOJlKDIBH3lO/1?=
 =?us-ascii?Q?PuxT9MNE2UvZaFRnjJEFUCA+A25jq8lxL9R/v7+/BedinmcKB+5YtJTM8aqG?=
 =?us-ascii?Q?1xXU4TorQ7cqoatUIjCf4RpJtQp6oG5aWMdk/IUu9eOyqCZ6CBzirPL1xI6M?=
 =?us-ascii?Q?haMoOirjtnK/eLjzbKLkNj6dHiE40blUguzNPKdkDkOi+4gfU5RUbf+grpJr?=
 =?us-ascii?Q?YWBh/g3cbCQ7zPUFbvQyZC974wdu3dUxISKS+koXdicvPxBIQiMYz/UvpB/Z?=
 =?us-ascii?Q?HL4I1Sd7IVWVjG5z3qx0CETuHh50GQy2wIqKD1csNYF91AMxzUD4seyx+Ezh?=
 =?us-ascii?Q?DORyKjX1rhVFxMPkVT9dAYt4au3JIefPrc7jfidu+B0U+BoK5SHimlm1DA2B?=
 =?us-ascii?Q?iCZw5nDgikwk2bGNdFZoq01ZEA4sOEqagT2s+YOTmJ51vEH09EfPMwJb5QjZ?=
 =?us-ascii?Q?Hny7MejcMObbkO+QdV6MDkj3XGOSOtNUWFTRDLfQjufMB4uJsdgbDlpe5Zn6?=
 =?us-ascii?Q?lOso9gh0nv2u+D3AdEXvqZd36A9hyabY4duSCxytNB9nGbO40PVxwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2024 06:35:12.4369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb428c38-4eec-4b69-12d3-08dd29654796
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932

Add device tree bindings for AMD Versal NET EDAC for DDR controller.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

(no changes since v2)

Changes in v2:
- rename EDAC to memory controller
- update the compatible name
- Add remote proc handle
- Read the data width from the registers
- Remove the dwidth, rank and channel number the same is read from the RpMsg.

 .../amd,versalnet-ddrmc.yaml                  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/amd,versalnet-ddrmc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/amd,versalnet-ddrmc.yaml b/Documentation/devicetree/bindings/memory-controllers/amd,versalnet-ddrmc.yaml
new file mode 100644
index 000000000000..b6fc3548017d
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/amd,versalnet-ddrmc.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/amd,versalnet-ddrmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Versal NET Memory Controller
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
+    const: amd,versalnet-ddrmc
+
+  amd,rproc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the remoteproc_r5 rproc node using which APU interacts
+      with remote processor.
+
+required:
+  - compatible
+  - amd,rproc
+
+additionalProperties: false
+
+examples:
+  - |
+    memory-controller {
+       compatible = "amd,versalnet-ddrmc";
+       amd,rproc = <&remoteproc_r5>;
+     };
-- 
2.17.1


