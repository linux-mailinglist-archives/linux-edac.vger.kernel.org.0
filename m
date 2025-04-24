Return-Path: <linux-edac+bounces-3705-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 987F7A9AEDD
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 15:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78557B1304
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFF427FD64;
	Thu, 24 Apr 2025 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="npMMygJb"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315827FD4C;
	Thu, 24 Apr 2025 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500912; cv=fail; b=R6fCy3+u4E6h5zDv9efaa9Ywp9JzoA3PZ/kax39nJcbIj/XQ46Dn59OtHlvhgo+za84TCGCZ/MVyO7V/imBlg7xcYVQf5w8s5Vmu1GnT91lDf8Xk85L1uh3hD1jD8B63kogsLi0kdhWNG4PlMoHjDTvrLU9LHa+vcCrZGkjb034=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500912; c=relaxed/simple;
	bh=2SaHOkzYEj8IEDCJKo2WU5+vVYUAdkvwZGA1Di65euc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRqFahAIGx8806g8d/hyJ04LWylMIdXua1oy2GShzglUb+rfWeA0tl4vUX6KdlR4PZFtGVZlK5kFfXfQ3k1UX25aTrm9j/l5uBBQD9dS711aopoWdcdYiwMOCACQYbRvWZbH5tnwnttZ9bMLEy1/lyPGXZzv03M1a28Ka46PhiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=npMMygJb; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8QoxhA1XAiTwZagA0pfpqKzdvlwYqYf0O2gK1IrnT4lMe02O487YsLRm4/gHRlU9c0+5dLuDGTc0IaxbO2Uvs1/k3Czl9IWTz8l/5Bw3tp8Pdel19bCoCB9JwY+b3uKs11/mkT280FsBGrCk3/XGJeY9j0LVNmwnFzsMSvaHzvRWAJc4vhG6HoliXDdJCzb92YD5yRD8F3Dst5veAgekPRLBTNIW7H4t/mFKVFBialVTn2OMI89KEXcmxFZCdOcqJfnrxAf9KVHb0AEYA7OnjiR8OljcgOf4FtMtAWwoBdwHmOxIEpjOUrEAjMgPE4g71jtfkxAWHjHdfQImqxGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SpGXDFl6AKn2OqDzhCI1T5nbJC2oa/Fz0ebrq0HOmQ=;
 b=qOI0xKRo6R1Zc8WDRxVsUquvsWov1QxYvcwNEvVKzhRwiWpDjYROz+MKKDu6cZbrMUMnaGZiFh/T9ikFgIoa3hRpXt34LlM0PsFcp75NXGhc32SggO5+qIOdF6Mivuf0tbBl1zcFJMdt+KpZDdo/fP9jx48dkQiA8taNMOB8y/d0+muDWv8U8T9I4KmVyHXWhmrB8SPMveH/oYugG6UwDI2XDD3HWdGQ3NCAvry17lPXjy1GDgNJ3PYYqvLZUq5dMGhK+LBDeYmjDwn4gx/XUVqPdRhjW6ZyFqojfQ7poGe7iplFGblDiUHHSOGwU/TPivWKRRhTKiqYIDR9lBTE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SpGXDFl6AKn2OqDzhCI1T5nbJC2oa/Fz0ebrq0HOmQ=;
 b=npMMygJbjCfuzmY0aT4Vt8E2cdXcHHrPB9aS7fdz2wv+Lu73a+5HErGVaLsQt7u+vwHi5miwYYO7W+mMfqMKc6E7rqVtauvVsHyacrqmGHkvOwwKOS7A42glvC4+g4fk7aARtK16uhXBXmvK/A/mZyAYWHmfs3XLY3FXBdDtFCw=
Received: from BN0PR04CA0196.namprd04.prod.outlook.com (2603:10b6:408:e9::21)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Thu, 24 Apr
 2025 13:21:46 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::ea) by BN0PR04CA0196.outlook.office365.com
 (2603:10b6:408:e9::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Thu,
 24 Apr 2025 13:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.1 via Frontend Transport; Thu, 24 Apr 2025 13:21:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:21:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:21:44 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 24 Apr 2025 08:21:40 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <ptsm@linux.microsoft.com>, <srivatsa@csail.mit.edu>,
	<shubhrajyoti.datta@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH v6 5/6] dt-bindings: memory-controllers: Add support for Versal NET EDAC
Date: Thu, 24 Apr 2025 18:51:17 +0530
Message-ID: <20250424132118.17074-6-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250424132118.17074-1-shubhrajyoti.datta@amd.com>
References: <20250424132118.17074-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a399b3-1f7d-4da4-3e25-08dd8332f646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?82ThuhB2zztJrbO5LdMYK/UYwPSFjjh06SfOfaWyI8/Ij0IQejvSpnAg+o+8?=
 =?us-ascii?Q?5/C+6E0x99CDNrEFvrmAjv4FK3lE2KzyJl2US+apIgMG+5lSy/evo+dl7ppa?=
 =?us-ascii?Q?zUfkNrUMmXEz2h0eTw41xPcLzZbCK7Q/I7NJV3cky1OX09C9gPUb35AOe4cS?=
 =?us-ascii?Q?zKQqNVj9WWDzyggKhIlFLPwJCmP985Iwm7FoncHl4ZeIj6DUDPPij4SX4dYL?=
 =?us-ascii?Q?wo0w/2+YWGDauASf7ctY99dsczoICjXF1/3KMz3qEOuqpb52N0o8Svy5KwDv?=
 =?us-ascii?Q?PJq7RVaKHcGVShHZ9kZ8cQDLsIy7b1moVDLloccgjwiZvE9zBOPDzKDX4cai?=
 =?us-ascii?Q?LRIAx9BiD7EQ/cdl+BkGvX+N7Mjtj+HkenrekcytkEevHPaimwuy2/t/nXBJ?=
 =?us-ascii?Q?vSJOb6yyswjghVd/T0QAecxU8PaN3pINxgNTngdwlUKXVPjsz9UJbxOkgZKA?=
 =?us-ascii?Q?VMs5v+w/aLCn7tJ8bmb/krmQRiY2osHkokJXTAhincjkwe87waOoQRjG+myY?=
 =?us-ascii?Q?Xskj9IxesUkMDKAaAU8t5C2rOj5LK7+xjmw6ws7kYfhjjewCaSzi0uMopRcJ?=
 =?us-ascii?Q?VYFPZ7YqYNsxGlXL0H+7Oueu31NtYgTLaxYxfduG8J1JUHhVgsUlDhuVosai?=
 =?us-ascii?Q?UPPK9/klvEw7W6wOvN8uxxBwsj1N8bwbLLzL0oBfNvWYtrtc0WS31+QCND+x?=
 =?us-ascii?Q?rDTeHru1TjNNhij9vPsaH4cTe8beqtbEmA8GKAuInVpCPuIv0G2Q7aS8qbYf?=
 =?us-ascii?Q?W6yuGXHWVHBRi1oryy6NetaHHX1WPzM/MqljJGjzvupwUvwWJfxOkQeQFCpb?=
 =?us-ascii?Q?yRgw3vC4U8Oo+Eo3AmRudahwooVDE6/dcsheahoND9C98C7IIkNFsmKcIo4J?=
 =?us-ascii?Q?+SSAjxnrkIjiTh/s4S93z/5Du6FbwD+t8hPxHZzMJSAI5u+AQOAhrTtTKzqm?=
 =?us-ascii?Q?7qtSdt1q8N8DC5N+8hvtoZsOB/uZkC9iTuMK1DQeS5qgIF7tGwtaklIsXMjD?=
 =?us-ascii?Q?HEbomPuS5AsrlJUTL4KV1F4z/ef44NeEv0UhM2BPpZuICBQkPndsV8DLCiN3?=
 =?us-ascii?Q?mOMptNJDNkmeZlyatucsfECs/1lNp/36SondjI16+iQCvNMKR1X5QdEtvoYS?=
 =?us-ascii?Q?NJ8ZSyZY3/57VIAQvbJcCj3yDl/E5jTnL4EiBsOQlkHXrJKU0emd+n9hUiyR?=
 =?us-ascii?Q?aKiOJ3RwPdKu+tCzta0XkjdKSyoSCh4YvqnPYT4rpecsaE3QjQzM8U7fsteY?=
 =?us-ascii?Q?L85Zp/x3y/FI3YgdM8tK05VMPgYmveO2ufEkx1RJnBgknVZq1F6hVfX54xTy?=
 =?us-ascii?Q?tpW31MKEYcfbHALuBy6ZXdzXLtsaj33kIUCWNGh8ROo0YKs3d9Pbz5SfHzGY?=
 =?us-ascii?Q?2GZAOCcyula7kBL++eHvaHB+Gj7cTg6Y+73xkVw0LzM0gcdhzI/uTwgUQGCP?=
 =?us-ascii?Q?WjtaHnnuk9yc6N3n4aUbY/BE2rfnDo+f?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 13:21:45.9429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a399b3-1f7d-4da4-3e25-08dd8332f646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818

Add device tree bindings for AMD Versal NET EDAC for DDR controller.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

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
2.17.1


