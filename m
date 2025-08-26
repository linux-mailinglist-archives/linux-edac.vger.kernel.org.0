Return-Path: <linux-edac+bounces-4686-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE3B3535E
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 07:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0E07AF54D
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 05:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3189B2EFD9C;
	Tue, 26 Aug 2025 05:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jkhgv1y7"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981E2EFD89;
	Tue, 26 Aug 2025 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186188; cv=fail; b=WkV6WV6/XepBACMtqckFCWsTxoG2DXk/8d3XICYlhz9we/7GhP94bKN1T9z+2APvZJeMT83EOvb3b1KTdvAR8OxcWRXQtqFJO6U/Jlw4gORYI6wNdMYLsP9FA+3Spv6O9VdbCd/ys2yeyIAz/2JhH1q0yo8Jzm8Rf9F4IAx7oBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186188; c=relaxed/simple;
	bh=8xq7tBtj6ymWhfzsnIO9IqanvAViVIGeIP5Mnm/dwy4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMytOrkjv4WcYk+0B5CaQry1aYeIPWDBLtRIEkNU5er2DHq3bcSjt/2wgudSPsnNcKlqj0xjyGkIvUyuhF7GPWBUcTqotm1csYK0LGLOz4uYeFLGQcMbpHw0Q4fFz0E0D32InQm0XtAsAx2ci143wVreCpqFXIQkQr3xFwH1rPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jkhgv1y7; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeRqu9Qv3gMu93oxFDjLQQvryPs9BNtfvhf0f9nMA5Q35hV5oN7bpT6y+yxvt+hAlHRaAa2l8pQp+HH9FdfRMYbIzvwhYiBRoA8MFIc18Hs0W3mVT1cYfNnhbFY8Ax+yu1tFDs6Dxkcmiu9Zlz28qT0AP1bk8XaK0yCEVMS2VINKIVNMpYGJoyYyPIDfc+OnQ5zUl38kfZGcxwDMLMQzLxjPOGb8SiYlSIW01IyOcin61BV9XIX25AWJpwmHpSpSEFf60rMVyPTI088AVt05UF9si8W0r7H+mb1qPFn0F/jP0sCqQY4HfZU/qXOlUsdSWRFHV/nIvXs7z5ZE7LIEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60BEWeBv9YRjXsIKLMR9AQ9Uwu/ub2OYV1K6fL9WW1s=;
 b=C6tvFYikKZP4ifpBdO3Bo9RwCimRJhi6+rk2dbomY2BiflKkFtiRy/LsRRzf1QJR0grOWZKYehr45woLwd11s9JMlSGcFdaig3rUxO5ZBnYDdo6zOAwT3AafyfcEBrLYKhnzc+fPdaX2Wo6KW2pBrVB/oLXmHA55PZ+l0gBmItNvomMBNSbzBrBDMcgJAJS21Stu6Imk6PBWnpPBS3HQyv8Dkn8SE5x9KOX9utGxpIFyMdgxlRVCw0dzVYN724AgSuWhNjp4wy2Bfkkm/RhYeWFgcaesZRMgBfPlrL0O3N7YsSwr2dm9d/WOz8CiRuqDUnWzNtoNgU6ciZON8Ivkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60BEWeBv9YRjXsIKLMR9AQ9Uwu/ub2OYV1K6fL9WW1s=;
 b=jkhgv1y7PzNpzsRBw1SLnitc0DMtB5+6+4RR0WzJQgkWNRIUTGt1t73VzsMeE9Xz4pI3SYHr8FuSG2c31lvptQo1vqt7hDMTNeG02PPnJdbUFmgOA1ELdPXBoY4zqhQvFbkdpd5TK3N+NGZtrDlnowajQWv6pIi5tX6pq+nrcC4=
Received: from MN2PR15CA0042.namprd15.prod.outlook.com (2603:10b6:208:237::11)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 05:29:40 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::7) by MN2PR15CA0042.outlook.office365.com
 (2603:10b6:208:237::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 05:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:29:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:29:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:29:38 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 26 Aug 2025 00:29:34 -0500
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
Subject: [PATCH v8 4/5] dt-bindings: memory-controllers: Add support for Versal NET EDAC
Date: Tue, 26 Aug 2025 10:59:13 +0530
Message-ID: <20250826052914.2066884-5-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: ffcf76d9-7b10-4faf-527c-08dde4618e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nhOFt+JCTbKwNyMGqtmXVFzODY89PtDv2l+RI8eP6OVX0pnGmbNI08+3O0wb?=
 =?us-ascii?Q?bkBvo5WvekXlg2Oylj1AfkqFY1yqB62i4ap/KNby0IiZsFGXx/ns/zKvmklc?=
 =?us-ascii?Q?kko2yFC4C21Fu92gakeWvPY8np5mgiwo/lP/9Ka+/n+tU41Dtj82jDQ/opIa?=
 =?us-ascii?Q?blLNsbaDCU3yPPWoVv6snc8wUItg0X8PE6/WjcFEowJs5SHNu+gV0J0FyCk6?=
 =?us-ascii?Q?/PohiPsTDPhMT4Iri9EF4VBipT/+hTFUzfnMe+Tjjd4rm1NeysnhRsKafkNl?=
 =?us-ascii?Q?pQIsDXtsBQ4lQwtCiYnw/MVMwK8z9j0XBuDbZ+pJiJAgB5BVU5E4ioncYskJ?=
 =?us-ascii?Q?3HfPJ/jQ6QStRNGlOQ81jto6V+0wag0z+Cv9Hoxzen/GU1O+9uGh7BPYwOEp?=
 =?us-ascii?Q?olcXSeSSJvCEaQx86E0yiiGwZNQjd4drWFs4mySCrywiHjCQIvp8EovLCwNp?=
 =?us-ascii?Q?w/Z4SxrTOA7PpWdW+ICLQDlwsx7OhWE4i3Lu4etfhhHDHvNWYaopO3JL/UoL?=
 =?us-ascii?Q?aInHAbotMv7gwa3yZyZTwuLDRhj6LnXyQFk99Es0Oa7SHDjBZ5QrK2Bt0k5B?=
 =?us-ascii?Q?D6VU217TxJ8XNoII+CGDHERVOtub2taV5fByULurQV+G7otbx1hfHpT6DJ48?=
 =?us-ascii?Q?9XHp6UcxB7jHP2r2B8+HQvmi4nXic7Qwg9QaAY/GKQEU3Pw4EsIyF3KtPefD?=
 =?us-ascii?Q?OYEkMls6uF46oKR0jD64k81l0YqNJV/ZLb2uhhUdVyM+K6XzEFmN49IF6bI4?=
 =?us-ascii?Q?FohSTdpGHautfTutAxL4yR6BlBN7NOKIfYCtH+zOsoIry2yps/fIqumyIsah?=
 =?us-ascii?Q?Q3aUlG0tEa+6/0roZWLj104YckfxcrupyR/spK/AHzaHdc0+lbPYrZKcNNv5?=
 =?us-ascii?Q?BCfZn+zPxDaHR8KuhWbnFxzRx7x6+4MlW9/DJgXNwLC0Q8cihK1EIR4ZUpL7?=
 =?us-ascii?Q?jKetMdkGLX5ZE8zl5p40foo/t0ciME57n/oS1ZwI56a5O5H5J4W6YttCQhwT?=
 =?us-ascii?Q?sDmXBW/KucupapEwD8SF/Y/6OOBWeKWAEuztrs6PrBfP85lF7tBvMdQqUUj+?=
 =?us-ascii?Q?FcYCdxuccnGhI3r0GuHuj/VKjH9bTe1rl0ibohuVzxSeptHev5SHB120oczb?=
 =?us-ascii?Q?59nEvUY6VeXLpDKu+vk+zU0LdoHI2wb20i3/HQlD6Welw0wffX11JuPX/Rqm?=
 =?us-ascii?Q?pmH6j0QbpSL8MSFhGJribWm0z1NorbkI3QFZtoS3nTZQ1yxt+73FxMnk7q3t?=
 =?us-ascii?Q?ZvVmuWA1LJhCJwOPJR/P92BMzkzGiyy6W1WAxW3G8LL6blWaIp+C9AdVpZkH?=
 =?us-ascii?Q?Vg5jTm6cYjlFjMTWTm0OuWDSCaH+7/sYx6LWPNfL2vg+dcTJae7/WpeY4JPc?=
 =?us-ascii?Q?vO6U9h435zcGaWd4IjyC+2rC8Z8NXxC8no3t4bft4AB8PSOZnfay1G2DnwyJ?=
 =?us-ascii?Q?uJCBZTuwpMG+oPtnQYQSNAq8Uu29nnLexWmzJaF5G4FJb8VIprESkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:29:40.1645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcf76d9-7b10-4faf-527c-08dde4618e04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041

Add device tree bindings for AMD Versal NET EDAC for DDR controller.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

(no changes since v7)

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


