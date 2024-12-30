Return-Path: <linux-edac+bounces-2755-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A34E09FE2CE
	for <lists+linux-edac@lfdr.de>; Mon, 30 Dec 2024 07:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA02E7A1110
	for <lists+linux-edac@lfdr.de>; Mon, 30 Dec 2024 06:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055B017FAC2;
	Mon, 30 Dec 2024 06:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RAJlmHOu"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F89212CD88;
	Mon, 30 Dec 2024 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735538787; cv=fail; b=IZwom4tT+XWDovxoU8gQoTH4G64tPKjt4hTcFvc8DeS8fFEzl1dUyxckJ9USu5B5UfrNGWqha0y+Li/alM3aR0/nHQx83PLFMvCALTcBoHTmw/3M8TbGfF2VFY+L2x+9sjZJwOVLohKmVv8lopLaGCQl8lPxyDMYQC2bSi8GN+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735538787; c=relaxed/simple;
	bh=aeNr9plAluHWdE4LIcy8N0IbpOzifCWfj6b0txSfEf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlMmpMnZ/wNtGd//qGGKR/7hh9crHSUuLEss8i2r+bMOYANiB/kuSJdJZeRpn9n/MZArz+a4nxPOzBz/mFKap7q4WHFKsy0SeG7yinqB92BuY8mGxsxtp/29IN+E5/fPSGRKrL8+nJ+VQw3dqP54ABsMw1Bfls6HY1USrvlqE64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RAJlmHOu; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8KW26pQvem5atl1IPoMuy4cK+5yfdATn3ZvE0E7HcQjuMu2dnnkqVQCUWrYQ7gSIc6H2JSeiZ6FTASzbmUA3lIUjnu/DxjJNkLAWn5q9p1pgY4FQa0tghrS1FrScvQPCdFC22HN2gFsKhLD9leIBP+1s21YWfHBDPgg9h6JJ3sSshmN/uL3DeYRNzo1sBB3cSuMAM5tFEpGfAkI80A4cXfVI3UhnoPA8G9Lrn6sqAl+Bj0Vv17dkBl3SGjzMw1Lbz5LsWRs5o4o2yrWtUGqUGMvbq9oh1N+87PgGEvnbVOCUnTVO9OGw1TcxC4AEQ/ybTPmyN8hSE11/JjM/aawqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxA2lTML/pW9QA36+3bdfN7edgvMnwOzZxbzoY0WUHY=;
 b=r8jKrNHBIUxhO9cJ3vRLlAu0XgJEznocsDqwb17HAKXub62Mr86CbuOjonEBFoxYTxZWTtnJnZNUMnhjiTepqHCtbRFm/MX0gQI/DORL2ZWjm+zaaoYEJYioOnnSDNDam6BGKpT/ZhUffu8RbDxxBj0/koA5ZoiKr5DMOeTDGdGU3xK4+BvllYUaWX7sqphxBwy9gutUx/Fe3Zk62beh8bTICoAGd7P+su264QPcp/+z+WgM9mhNwlHKp2uDAkhfhTr45KLNwrIMIydpSDfA5Ci/JvzGkL9RijTgMwXpYSiFhd8bqXCJscRW4lD7MZRd57kk153ejxzZhjWMn1MKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxA2lTML/pW9QA36+3bdfN7edgvMnwOzZxbzoY0WUHY=;
 b=RAJlmHOuogjKulEqqsLmxlnGJefSArCwYMIuwtHTR0hmHUPl2w+0mzOyKD3hV2KYvWSv0Fr+NRWsjYOw7JUxFQURQ2EbNNfBCBd0WeEobt5zXVf5BVVqnZS3zZodI+z5v9zRBzBixGSwSzK/A/tOCeL5EdqI+AYjT6wH8E8hfug=
Received: from BYAPR08CA0045.namprd08.prod.outlook.com (2603:10b6:a03:117::22)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.17; Mon, 30 Dec
 2024 06:06:19 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::cc) by BYAPR08CA0045.outlook.office365.com
 (2603:10b6:a03:117::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 06:06:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Mon, 30 Dec 2024 06:06:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 00:06:15 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Dec 2024 00:06:12 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v2 4/5] dt-bindings: memory-controllers: Add support for Versal NET EDAC
Date: Mon, 30 Dec 2024 11:28:48 +0530
Message-ID: <20241230055849.11183-5-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230055849.11183-1-shubhrajyoti.datta@amd.com>
References: <20241230055849.11183-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: f8df5d59-7f83-45be-f62c-08dd2898135f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RKyQ1lyE8bznA2Sz7QnbPe2T6R8t4NPp6kiX91H4+lcxkqgv8RYbFLsli8wX?=
 =?us-ascii?Q?QXfWCH/b8GvJ9KNYx9R+s1+9uX7elsauCy78PupTFgvE9xLEsWkXZfBN3+lr?=
 =?us-ascii?Q?3TZ7HJQVq7fC+eT2Rv607r/71gULlXtI3KmT4gDgr4pXiTbpx7KNDfKdvH4K?=
 =?us-ascii?Q?3zqk33x9xBswq6CAfnq2PkkILBrvQLTuq2a/9bC1TyggjEAWbgQB7gLOQLII?=
 =?us-ascii?Q?Wuo5o+CQftJldY6VBttZoC4aHEjWIJOSTayO5G9LYXwbI0Yz/GE3lLHVDMFC?=
 =?us-ascii?Q?PcmewM/i/9k7nmCLMW7s9FF0/kO3uiHenXGV+Mv1t2FxXRXLdG/tRYvBLAzC?=
 =?us-ascii?Q?mOAykBHnrVrnvP4rsW999a/VNCO+3GLieFSfULU/vFfDEC3ep6HQFA8B+f5L?=
 =?us-ascii?Q?fcyyDbY7qlRMaisi57SOiC6Gpz62y6nuDwJCXhFq7r5WlD/d1MW9leh3QIpT?=
 =?us-ascii?Q?FROiuw4QLMJpYhnBOisotDUemVk/kru6ZZ5DXt2h0lLRB0XRwZZiP4t635kp?=
 =?us-ascii?Q?cZqlvAPxRjekCV2EldnFqD+lHa1n3aL6LN9/Ow6OXujneVI2wIgqJFRxyGiv?=
 =?us-ascii?Q?LxaY5PU428xiUJWDaKhwmTgNXYTbiC9jjzL19E/lgFEUK4uPtmOp6D59H+3B?=
 =?us-ascii?Q?G/SFQaD232ilQ6lPhc3FfyozvUkmDz/vsjXnSQ+0WVUgeTkM8UNGXa6EZ2UO?=
 =?us-ascii?Q?kV9GSw36YlGXVIo5se+l9Yv3sZElrvzRz605PqIYookD0yoDwwOOmWihTkPT?=
 =?us-ascii?Q?jkNdmIR+HGpt+JthKaeiKCP8eDBjkZUWj1g4/vDmEgTTfixRvjedxyEltVMY?=
 =?us-ascii?Q?MPKJoycZSlss+CXUKTnhxC+rjfU4P72WmNKIt28yG3JcY6jS3AA7bqCJnbiy?=
 =?us-ascii?Q?YvsntQLUURZ5NhxB+pHziprrYYn3wHZxHZK84TQm0gIHG78QCUll5wZva5SC?=
 =?us-ascii?Q?9ojzrH/mB/EA8csWKLjB68NuR6otDUq7+Ku3ZnqvAS8O5dJXNz7/G2nYu7o/?=
 =?us-ascii?Q?TyYIexgDXz4vVKjc5de0IXFjB/AtsISqXsBzUKykGKr/L/q/DKUqRo88xOfv?=
 =?us-ascii?Q?/PGRIEFkTYDJBY+GdStM3/9gl6JIfqzwZOOT4T3ovQHwouC5GaGaPynJHzvN?=
 =?us-ascii?Q?zQGje+1S+Lmnlup9kmu0ajFiDOjfh4iZDXW1Kb2EtBpS9kEFJNjefoCqiu7G?=
 =?us-ascii?Q?VVwi3MCCF+n04wU4ZoL6V6dm1y//bENhHs8GVX2UW16ALAsOo/Gagx6cCB2d?=
 =?us-ascii?Q?GEU8EwT8HZSwdzW5owvn7CCWZp5aTFKA5DflxzpRm2fW4tnyU+ayWpvphgiM?=
 =?us-ascii?Q?+tShfCEflaqZJdryo7FuYHesF4UB0MVt+TxVcAl3uFuybFXSVDjjtqRC+t0/?=
 =?us-ascii?Q?pjoazBSlZ0BjqE3x5kSN/0VfSZHKrfmbSOBUvLESQl8B2T69M0PXiEDfIftU?=
 =?us-ascii?Q?6zymlN95XLAwx5SYx1jDslOtEobImta3KiJgBENs3+24ZrIoVgShNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 06:06:18.0112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8df5d59-7f83-45be-f62c-08dd2898135f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067

Add device tree bindings for AMD Versal NET EDAC for DDR controller.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

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


