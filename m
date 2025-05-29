Return-Path: <linux-edac+bounces-4035-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 692F0AC7958
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 09:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020631C0745C
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 07:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E40F256C93;
	Thu, 29 May 2025 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IH2PV6Ej"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0330F256C7F;
	Thu, 29 May 2025 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748502046; cv=fail; b=u6HgJw/QM/4XKm/lbpRiLKg5cEG6OwaDATKBrp5RSfk1+MaIm0UeL/xcGCR8QotxXt7gkgzvQkKlH+rzhcibDUsPLSFmxz3t38dJ/9Yue//tg8Idg6bG4AQx/zQxV0w3fu9mZd81owKCeLaARB74/MZeTCoPoDhdeqYuscwHxgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748502046; c=relaxed/simple;
	bh=HaEkdTDYVHNFACbhWiJbM3ysv/aGx34TO6/i22ObuMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gze/Q0kQUpllQwY0vftcZV+oNWWAFyA/7AVOiX4iKIEtCTrVexrDbxMIFmTNkvNyZDxX8aeTvmdjQf3MER6QydGrN5v2g09DfSQGy+1nkMO2GvfwK77OIcdbo6gHedGAajQukqQQK0C53wxaKMeQKTmWv0OxeXZ2oCBzE62q+xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IH2PV6Ej; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spoa/KIJxGQak1SMURFmdfNKEmj4okbAWASfqii3PZWLLWMxbJnOex7Z//C8zVsQfR7rs9mdta2G2KyoYns6b++lazYWk5IMRyssRSkbSzKB+yRU5WtnxbDL9fELZYYI8Tvwkk9H1CulxoUHhvgYHTco+ZbsJoE+GYf/ShlL9A1TbEqE+yszbmrTRMlLdeNYF5LTfAvHrGVI9UBT/0nxPDusUzCXjFx8SB4LrlRNhjx+0tEp+f7vESuHjvum9EiPCQjBwf5RZGhiLy353Q1BdxWWdQI7U4+XWUvNHpCXChW+6DOhUYI3tJEQMpWPi+eOnwtwIndoHNoBjPSsO++AGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0etD3lGWdGpX1h/vU6xfGdw1xOioXXe0NpB0yv+UuJI=;
 b=rz/WBtF95Ck57MSLO48yYWd+XdwD5BBqWjZFOW2yTEg1EVYORkgJ8es07nCFHEHaBmjBfF27yOCf/3ymOZlOBPi1JhDNtXdLqSSOxJXHlHY/6n2jCvHZQYRGiOF3q8/IK0If4ikEO4YK+QDdw+DGdnr8vAcpUff9iMrroWRbExXH35CYFXBrNZk0CxEBZCbvqdY2dtxsazS6Kq4pg6gmpb/ghzsOQjVwgC7r10QoyCsNegzv0TC+ThXob6UYWNb9wAdM8b+SjwvosRUs4BPdR0hQzRes7ne1G1QK7A8BBZjn5NYc02LzIMWcXQruRLixp52AULPQsbRE2WSJJGT6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0etD3lGWdGpX1h/vU6xfGdw1xOioXXe0NpB0yv+UuJI=;
 b=IH2PV6Ejs8WBbZYjrEBhfKs0HM9as74OTrC/Hfx1SpaApfK0IECfWnPPNIFwJO7eme9/7NYSTPNM6/lEslqt4ViKhtrA8VYBQhjE5VnZunv+4j+X/Nckii2E48XdhXT7ZISWpAPFgiFnEBarbAqhSd/uGWCs8e7DSYuONyFwr9Y=
Received: from BN9PR03CA0931.namprd03.prod.outlook.com (2603:10b6:408:108::6)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 07:00:40 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::6d) by BN9PR03CA0931.outlook.office365.com
 (2603:10b6:408:108::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Thu,
 29 May 2025 07:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 07:00:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 02:00:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 02:00:38 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 29 May 2025 02:00:34 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
	<nikhil.agarwal@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH v7 4/5] dt-bindings: memory-controllers: Add support for Versal NET EDAC
Date: Thu, 29 May 2025 12:30:16 +0530
Message-ID: <20250529070017.7288-5-shubhrajyoti.datta@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe86cf1-40b9-4df8-ab06-08dd9e7e85ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WW0QlvR7enudgktbUOhX2Dthbe4h6Lg08kedazag73QFs3h4Zh8flt+ip3T3?=
 =?us-ascii?Q?WdNh1Xfgj7P7mK3iCWWCtXBEbKivcS/gKGVRujR/sV4Eic9STGGdH+IqONd7?=
 =?us-ascii?Q?wsHkpHyFKKt/oRPb4rHWXfahW3fpLlV/O4J7DPszAXhfLNdyGdCg/jXbpK4F?=
 =?us-ascii?Q?CCrUqR2QXKOvOhhnzQ/BwVL9YzzMue47z/u9tsLZBwdTYVqiknSK5FsIdXC/?=
 =?us-ascii?Q?HEAHEtiOJ8eTWE6Zx8tvtUQLPi9bzz/bXYQBqUUEANqjrm3MX05cAlgIcNgI?=
 =?us-ascii?Q?cWS0SeXaDCuU4alt7jGWWAX1avJGnlcS32QxyiL/grnyZZ1hGuzSv6NfIPLE?=
 =?us-ascii?Q?EsFeMkyJxQ8E4LlC+ipXozMxza3fIlvjEZc2+tfdUF6intGs1bst5n1r47GN?=
 =?us-ascii?Q?b5z0B3r4l/ZYX+JSlPLr62VP0sj8Ggp20quMYNPDvCCRSqzjEOr9t/IUXvCc?=
 =?us-ascii?Q?K5VGPYCcZ8GRN1pC+1A8kSLVjtF7xncDzADWRYKFDpYCepTs8tfFT6BsbBqk?=
 =?us-ascii?Q?cWW43fXNQqVgMR/DTD00BuHvI/mBz73A/WBVfFPeYMaabW/WGSPBLhVxoxug?=
 =?us-ascii?Q?m3T4qTuILoJ+MQYts7vMe8sL1yZ+HsXXFDXb12gL7M7cmdmKtF5Cn67wIxlh?=
 =?us-ascii?Q?FENkoJbBIJ+7T1KT7fjfN64OAP3prclhQPZpVUSqhNIz1QHa5KhXKrvwiIX4?=
 =?us-ascii?Q?Wj5f2Y6InPBfyhitumYPPl5PKxotx6+enBBVgjYHkd5MN0G4dctAtPAeJXv4?=
 =?us-ascii?Q?eN3kgeAlqenQOydhdMdq/Vgf3dM/vGQ4F2dWnaxZDczrW2RcwcY71rqK9hjL?=
 =?us-ascii?Q?xVVPoBw5QdWt902gegmyXXwe4ApT8+/kAKEfJFIrrLtBeEz6Yg3G37nNLqB/?=
 =?us-ascii?Q?2HEyCXqCTWr/B60umn8dfHFZXxLs0JtCwvkpfXB94OCyfhtRWHhDQ8W7ciiK?=
 =?us-ascii?Q?wxRVeBgTRqeArlnNuEkBZlEU3VFCb94K5wnZwgEm3awCGdNi0P7Z0EkzOkT6?=
 =?us-ascii?Q?hkQwID0aKq3uCteVAqG0iK9O80AMklkfRvt2cayRZQo4g6iNrz0QMRUQ3hQ2?=
 =?us-ascii?Q?j1pLo+EQprzZ5+K9CYOPP8H1IM5OwQ9uKDEwgGpSsge02/fwOdZZGTpItoWo?=
 =?us-ascii?Q?IL6hwzQRKmc9FpqLxSaiqflY8Z73lFprRKk/jxsPVa/BTgxC/s1Vue0JIcKn?=
 =?us-ascii?Q?jCEz/hGvfxaRafUSU3qghqLmtSFfi0m/syeOfk4/9BhrjDy64fUUAXVW+K8l?=
 =?us-ascii?Q?x8tK66oDYroDQwJp2CH3n6121dHGL4fx859cPrFRZ6phzPfKC+Dqkb2Z0x9j?=
 =?us-ascii?Q?Jbp0qJg0rTpcncZvNiUjbeDjR8f74k2pG7VN2i9AbcSftEECUuZbkajjh/E5?=
 =?us-ascii?Q?CnZUiQtqhV1wUPQZQclGFQpDKGcCOzf9EoJoCOp6e1yPPvpvt32yKrhMdV2v?=
 =?us-ascii?Q?I/ZULB0ByqPOKg+qBlcaZZUYYNloLyCd0vXPL3V3tOTM6qsKYGzOnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 07:00:40.1801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe86cf1-40b9-4df8-ab06-08dd9e7e85ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496

Add device tree bindings for AMD Versal NET EDAC for DDR controller.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v7:
- Add the reviewed by tag

Changes in v6:
- update to the chip name as xlnx,versal-net
- Correct indentation

Changes in v5:
- Update the binding

Changes in v4:
- Update the compatible
- align the example
- Enhance the description for rproc

Changes in v2:
- rename EDAC to memory controller
- update the compatible name
- Add remote proc handle
- Read the data width from the registers
- Remove the dwidth, rank and channel number the same is
read from the RpMsg.

 .../xlnx,versal-net-ddrmc5.yaml               | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-net-ddrmc5.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/xlnx,versal-net-ddrmc5.yaml b/Documentation/devicetree/bindings/memory-controllers/xlnx,versal-net-ddrmc5.yaml
new file mode 100644
index 000000000000..479288567d0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/xlnx,versal-net-ddrmc5.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/xlnx,versal-net-ddrmc5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Versal NET Memory Controller
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+
+description:
+  The integrated DDR Memory Controllers (DDRMCs) support both DDR5 and LPDDR5
+  compact and extended  memory interfaces. Versal NET DDR memory controller
+  has an optional ECC support which correct single bit ECC errors and detect
+  double bit ECC errors. It also has support for reporting other errors like
+  MMCM (Mixed-Mode Clock Manager) errors and General software errors.
+
+properties:
+  compatible:
+    const: xlnx,versal-net-ddrmc5
+
+  amd,rproc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the remoteproc_r5 rproc node using which APU interacts
+      with remote processor. APU primarily communicates with the RPU for
+      accessing the DDRMC address space and getting error notification.
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
+        compatible = "xlnx,versal-net-ddrmc5";
+        amd,rproc = <&remoteproc_r5>;
+    };
-- 
2.34.1


