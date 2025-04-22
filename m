Return-Path: <linux-edac+bounces-3647-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD823A972A5
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 18:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F6A40215D
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 16:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BE22957A5;
	Tue, 22 Apr 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lPPqasnG"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F4293B42
	for <linux-edac@vger.kernel.org>; Tue, 22 Apr 2025 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339042; cv=fail; b=UysCHa6bnBaHofjWAah8EH9YP8pswWjWqn38ACPnfhYCpPEQ6OQlDiPn83ab4msUaabaa5iuSXfepBtW44xnvjceuI1PDHxhh1MpNotjuNE6wARBgDDIEVCcfcUNaH7GiM0n31919HVZKdLtca++f12duEE1ffSKtDflQl6OfNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339042; c=relaxed/simple;
	bh=NQx9ygjNNWbunF0LZMGAR78BpbHuQO24oBdEOB6PtaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVknVplxI2EDkJCfPZSLUO4t03g+D8TuXFSVjtH9T5rS1j0+S+zTXGrMusAyz25L7NwKrhTeaXZQqlNAV7qHvkSq9w2NZH3VSGNpse1ygsvZlrPhBmeuml3OpzRO/DGUdSeU2juK7//Iq4ETOV3Jm6wSQPE6+QgALdH5cykJWxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lPPqasnG; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ze9MIYMP5FuhzgzqwkGucE9CR5/iwdXWGTzna8LP6OMZw2W7cOJ+VeGCFcJcSSHOZEu2IRkgDvlaoLN7OfDM8XcoG9aH8c2O3HLZtcHWzlmf6JxHchbv/XJ3h4gWigv4skuHFkFWEBtMEKKt0mIIq60j5jRvo/yyZGRIqJNlxCdw7Trc7Ar8/xfZCWmRacApseYj0NoEmVfuhgUoMYoISAVzDGi3TcMALO+xQK8bAVU6CMwSBBrEAOU3Sdp2KVQtYrr/JRkAzWA+lwQspg0vDZ41qtJn+lz3l948qn9Tlyp0Y93BGnsBxnUzsCdy3xqqo8Q+z89MYz9jrgVIkf57aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo0KF3E0TBYT7sNvHRNBP5q+3Zg9t6qEadNhSBqwfN4=;
 b=f6E9fOTViUr1IG3+ToenYPLPTA99HTEsDCSaBQMb4+n7ImU7sEHLr8OojANC6WbQhL5ReFgtFjnQxyf0YhITi0juBHIrD2eC7AEUZ3jHj30IenLnex3v4dyODMj/2lxmm3tj/tGal6c3qziA1uu+CbzlnhltHBzOTohH0U4n5fA0HhToRaQZzQ+dFvhaBLB7UNPYGDQdcjrq3rNrZJrnIKKu87GwK7zCzpd8fDzI4YjO7a6QPzHm1iDKOLIMdjZFkIbuTeZcnwVBtIVPW1Q+pEYJ4OoLvpBLdAI6EIIvAV5q0a/pmdg+vJQRSZp9WS0qAJ9LZf8Idg+JRmYJRYcAQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eo0KF3E0TBYT7sNvHRNBP5q+3Zg9t6qEadNhSBqwfN4=;
 b=lPPqasnG9bXHAmsX7IQPtzSHu6Xd1uneEwyc7YWSIn1DJerfTqO09Gbx8VfCJ/xilJ6Ea9oiEWI7lyAdt7TWmRwGGtMYROnOPb6DFobf3DGtTugg8XXKHF/ahcK9zwHjv8N8BNowv361yt4eDPlTUCXr8amTPbe9uPzOut/39nA=
Received: from MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16) by
 CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 16:23:57 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:23f:cafe::85) by MN2PR01CA0047.outlook.office365.com
 (2603:10b6:208:23f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 16:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 16:23:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 11:23:53 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Apr 2025 11:23:52 -0500
From: Rama devi Veggalam <rama.devi.veggalam@amd.com>
To: <linux-edac@vger.kernel.org>, <git-dev@amd.com>, <michal.simek@amd.com>
CC: <radhey.shyam.pandey@amd.com>, Rama devi Veggalam
	<rama.devi.veggalam@amd.com>
Subject: [PATCH 1/6] dt-bindings: edac: Add bindings for Xilinx Versal EDAC for XilSem
Date: Tue, 22 Apr 2025 21:53:42 +0530
Message-ID: <20250422162347.3217007-2-rama.devi.veggalam@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20250422162347.3217007-1-rama.devi.veggalam@amd.com>
References: <20250422162347.3217007-1-rama.devi.veggalam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: rama.devi.veggalam@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 70205c26-f684-49f7-a71c-08dd81ba14a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ecxcu3BwpXHwkoKeQe/ZaaVtKC56b4iAavO85B/OAyIldmOB/MfYvAvBvfa0?=
 =?us-ascii?Q?Re7VOUTl6iUW/Wq3iDbQx5ks8v3tpYbzPproJAwqI4wA63qCE11LA8J+xEiG?=
 =?us-ascii?Q?sNX02OkqGfvP5FhyQUijV/KxKa4KBoYOkOWzH3942g6tU5Zqts+QhFwW8Onk?=
 =?us-ascii?Q?B7baXrnGSSNMHm04kna247zKtNSiecmxpqQHruqGElIesXu/CKTAdEefSgc7?=
 =?us-ascii?Q?v3BPvYJd1oGI6wsIeLVwTjuDzuzfIFHLaIosoENxeRRMyTkqmEab0Ha5u1aT?=
 =?us-ascii?Q?zJQrZE5JodqUOgB1iZ2VSm5hADKaqnbE2JVKFcrBe5etx9PUrRbbfOcElysa?=
 =?us-ascii?Q?yFC48+ifwzC48oUU4j9cFMIfFr+ETyqyAncsZFeamBmBepEwludFE5V++f7q?=
 =?us-ascii?Q?S8h3ej0kRu4IX4+A3EtpwKRO06izokgX6aHe7wBo6ujMhnCtT6UkM/5Zkzq0?=
 =?us-ascii?Q?gvLXS/00RWtU1TyyppINRvHTc9v23Dc2tcCeR8iKMyMUpLZz9zDqNjPgqa06?=
 =?us-ascii?Q?9wEtp+3zkKVxX+YXmxlOJ01uHJOvdESQkLbxO1/rvMSzVYtXzcA8FnvVeH8A?=
 =?us-ascii?Q?ww4XedZQhNJaOqKgJyuIp2fPTtezTJI3j0OfgecqHNa5Cgpl+hjyV7cR3jfl?=
 =?us-ascii?Q?bOEK4AWPlFYhtmCwYZ2fY0uPq+9n7/BclMx43+JAejKzZ9zuuvP3/HlOjG+T?=
 =?us-ascii?Q?b0VTK6Hgnuivy8vJ19GptKhy5V5hfBcIEJg1uxQS5TfKJMfd0h2vJifavsnT?=
 =?us-ascii?Q?IkhuAWOc9M1kWy3X/GkNpcQVTdjqYcj34RaBf1j7UnASipjwt0mMo+Zkj+hF?=
 =?us-ascii?Q?6Ed+jIUCtgGk7UD14cU6eygcSNspEClnT/p52Bz923XKXI7cZ7CvmqotwBp1?=
 =?us-ascii?Q?kSudAW+eYIN5oOQdaXcxXlahzbMi7bCBT7k+Ij/tFsIvA/41QetlVp9DoirZ?=
 =?us-ascii?Q?VxzqTwoTv5fR4c4VNmjOp6kOmXAErrOy0XOB+5nOWVmzoZoPCN/qwigIx0J6?=
 =?us-ascii?Q?LTET/+KMdrX8EBK8Do7qGPZAybhc/BYeOiBvVwu4XyU0+WJxNkMYs5rBtg+3?=
 =?us-ascii?Q?ocbZPmbUXTtuGSkCbXHa6fwtFnqNZmlGPD4tbNU2B+U4LzaT2ow1WB1h/0WV?=
 =?us-ascii?Q?FXR3e3K5gjIEl60UeC2wpUlrmSTh3Uaqn7ZHlxi/fHZmNUJkNkXrwO0aLUGE?=
 =?us-ascii?Q?8+v/P9ENmZqSHrObAcHsquGLqMRn40B2vTd2NMO0JJOQz8egTYMMKTBNPaYv?=
 =?us-ascii?Q?0RCw61Egd9M1DO/nMxxtaHGJFm1lmsDZCHl6UKCjyZ1DqvRmysHFanFbE1/u?=
 =?us-ascii?Q?XK97r8ahzlATL966BR86TvaeB29GBKwxnN2W5c1icKAWq0LIb/IYFp0pXXqg?=
 =?us-ascii?Q?i6OGCR2N4tMq9EpOgSDuXEQubxPgnjmMmwumXgasim9y6354iQRF0/nrW5r8?=
 =?us-ascii?Q?hQso8fLBntywFEJOd/+ZEDGqNfWvp5TvUlu0ZtglpjQY4tQS3NycJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 16:23:56.6244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70205c26-f684-49f7-a71c-08dd81ba14a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458

Add device tree bindings for Xilinx Versal EDAC for
XilSem controller

Signed-off-by: Rama devi Veggalam <rama.devi.veggalam@amd.com>
---
 .../edac/xlnx,versal-xilsem-edac.yaml         | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml b/Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
new file mode 100644
index 000000000000..99abcaf1e055
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/xlnx,versal-xilsem-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Versal Xilsem EDAC driver
+
+maintainers:
+  - Rama Devi Veggalam <rama.devi.veggalam@amd.com>
+
+description: |
+  Xilinx Versal Soft Error Mitigation (XilSEM) is part of the
+  Platform Loader and Manager (PLM) which is loaded into and runs on the
+  Platform Management Controller (PMC). XilSEM is responsible for detecting
+  and optionally correcting soft errors in Configuration Memory of Versal.
+  Whenever an error is detected, be it correctable or uncorrectable, XilSEM
+  notifies the errors to user application.
+  This driver is responsible for handling error events received from XilSEM
+  on PLM.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - xlnx,versal-xilsem-edac
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+      edac@f2014050 {
+        compatible = "xlnx,versal-xilsem-edac";
+        reg = <0xf2014050 0xc4>;
+      };
-- 
2.23.0


