Return-Path: <linux-edac+bounces-2790-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CDCA01EE4
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 06:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8066C7A187A
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 05:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5B41D63C6;
	Mon,  6 Jan 2025 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MnANwNqZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48E31D61AA;
	Mon,  6 Jan 2025 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736141701; cv=fail; b=kw9gqpd8pDMqKoR0lcv2eUHk2Q7o+IHgcKls2bPEiF9RwRgRNfusJQEQ254n3S0vBmgrsDYop3HdC/q6puCEYylg/a0PeBlvlFxGcdOrZCCkL5Cq8tnqzoWFOd2HmtmcfG274O0SP4LDnMnjZJKwLRmraDOOI2TlDBrkrGdsi9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736141701; c=relaxed/simple;
	bh=SYYagp/rCsLT6anbh2edRDMSkeA4LNSYxDG41l6BQNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTJ9bR2CJEgssg6egiHOrM+d0CnLvtkBDrKX5TfV+qfQPMG58zHv5TUHpJp/kd89HScnLbFqzEmVs/6haJS2Sg8fkx+IVGqq2UG87kRSSr4kVGETxC83ZbbZtmWN5FKIolljaxML4jYxYq2U7poUbq4wzmJlK4EfNhAZ20WcQvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MnANwNqZ; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2xjJtXHzmGdYiS6ED8ULhhSAMhPbXx3ILUDZFJTPdXAD9LTnZUqQo1cjcPBwWl/zrS/IHGxrfTTKMpreorJ4gEr4NU6tYIoezynYMjBYv2WaPBSVZKr4oz9pp18xVixqvhHewN01oD0Tjc57pnkdlK3O+u1kn7YxfGQMmhbk7UVW6S21vzb/2S6H1jYrtVOcJQIDJkDIxtqWCjeSN18uU8y7lpelKDS3uvbXeuxwq3R5sKZ9YmvWsCnp9kuPpXtVFNMfRgyjQOcfU+cymEqRyj1oaQ68Ozmqf9v0hBJaxYiyrxo0lXsLH1W8jBmDQof44lvG1I5c5m8ufGMsRzfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kh0ixJMOEn7M9bc8Gek7g/V3bMEp4IhUy3EdmGV1KAs=;
 b=d35grW9vt1dc3l2pnq6k+73bNTRgvOJK8soPlBtY6CT08saPPxbUmw+IkWZoQnKDPgDIail1Kjev5Zv8j8vT3ekePBdhWCRqknzjIuQ30e4UFy2f0Ayo5xdg1T+JBxQVg4MBeU/ZC5PhiBOtmfCO8IOGdY48kBK5CkYTFaaO1tL7/NROMBcHevgsQVASRi3ypRrhzzhmO0GPd/woFZ6pwqSdvgaS7rTyS8VXWD/VVIiCXBMjVoH/l5yVzC/Zdoa+1PLh/BaZ/na46p9BbhYtW34Bn8rGHmF8DboPwXq+9f6x3E2jOOLX83r5gLtGDggWGJMSuwGR8MiRyUtwiSouBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kh0ixJMOEn7M9bc8Gek7g/V3bMEp4IhUy3EdmGV1KAs=;
 b=MnANwNqZXRul0/LTubhe1SXczLuOFvIbEogLrTvcB61xSMe3ncb34lhJNCDMpYaPLYkNIHlK+a8zTTdzWo4MoDCIdgse+wVF9voKKKaIn/zW2l0JeqOvt1RlsfJ0WGXaqePZSsOHHtRPfFtBOMRdsAfpeY7RjUt5/Xh+mnhpm3o=
Received: from CH3P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::10)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 05:34:52 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::ba) by CH3P221CA0021.outlook.office365.com
 (2603:10b6:610:1e7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 05:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 05:34:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 5 Jan
 2025 23:34:51 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 5 Jan
 2025 23:34:50 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 5 Jan 2025 23:34:46 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v5 4/5] dt-bindings: memory-controllers: Add support for Versal NET EDAC
Date: Mon, 6 Jan 2025 11:03:57 +0530
Message-ID: <20250106053358.21664-5-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
References: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: 957d03c1-3e9b-46f1-a7d1-08dd2e13d83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?keW6ajJHYBCe+3pgwt2alBYIfrdEpwrZYSCf/uUEVYJ6GbjIJF3RHG4DbSGj?=
 =?us-ascii?Q?NRth3VWnHrtWAh0IhrqBGHrX8DnJdTh52Lvu1uFl9TgGDND989VPE8eacycw?=
 =?us-ascii?Q?ewRJnuWGUIzQ0TKQGcjicPZmWZEDKe/LQVLXlh6zRIJwLKWmxuRkZGH+3LGF?=
 =?us-ascii?Q?X5qB7OQ16T6D4J1KJQ9zjw8IqV9IdV7e5Rd8IrIlbAdhjsQFtFzTW7JgsKxb?=
 =?us-ascii?Q?FPmwvOkzJGGrcimn9Wbb5IItzivapZiS9YR6MbSv3ErtjlDlrmPP5H6uuOxH?=
 =?us-ascii?Q?wjLu0H14fvCG4oOMk4MTy8SQ5UTpVpHYhMIiwiA+K6w7FoJFVNb8lNR8Au8B?=
 =?us-ascii?Q?wjfM6lBcysneW/U11TG+AenP5Tf/n+8PN8a4o+pk/TBSjqGwErD8Vlf63W8o?=
 =?us-ascii?Q?MpqkppGISur+JMQPUbsganGhXQ20b6pbtohrzYpeFzAMN2cgD7tSgh8MkPSx?=
 =?us-ascii?Q?lBDF9KsrkQOSxpetTmgvyd/ieRer0oirWQoJ4rn+DsnluyDXAtVRx6onCZjl?=
 =?us-ascii?Q?Kz0UBvqucT8f5K7huth3Vgz7CZwKe9Tl4X4MMU631DryAiqsQlkHKCSf7NQl?=
 =?us-ascii?Q?urW0wLsOCZlIJnE4GfrbVuuYXKYvOOa6ivZ6cf78iFeI+WRt8yoAQWOiHHNE?=
 =?us-ascii?Q?ISq0U1HpH7HhKyb2ZtJaJBtN8nBghr9T6QglP9dqSxyWuAHHhrXnyi+pCITx?=
 =?us-ascii?Q?Km1Rp8kXV40i0Vg/srH/aXZE5vv8ssSMvPT/u8823jcnY3we1iYv/UNAXnGA?=
 =?us-ascii?Q?lYTUJ3CcUvjmoWx6kKGk7K3iTkXWG7viatT99irEMrnxgX8d1PZN0+3Yd/Vx?=
 =?us-ascii?Q?nfc+XNYrC6opOjCUbjSCQRcAeMem3XoecJIfmELepODzTzFcxAuTMtXjG6Nx?=
 =?us-ascii?Q?piCz3WNRscE7Tf4BgCt5SETmS4Yjzqq5uQwDPEuSigHV295PoWlpgJakE0Sa?=
 =?us-ascii?Q?ksCF+0noko0UYZapGoz4Pw43rcVkdz/+OhSj4OrCsj+F7OigvcXsX/kvboGf?=
 =?us-ascii?Q?CIFRhvwVALQVf/q4QnkAytQKf1P03x2uXPj/XmCkbk5F6OxSZ8F4U3YdtFGB?=
 =?us-ascii?Q?9/qPERrpubg2xzH53JzHjakX1sgjv++1vrZ+og69759Ek3tlkycuLQDCThrI?=
 =?us-ascii?Q?26MVyuj6LMu/SExBC4Z/W2mHIQEwDoc65awhobqnpZN8QAZi5/kmdqj3b/eD?=
 =?us-ascii?Q?51fEWtfODJxjz4iQ7y/hI6k+jC5c+zAJtT1CFFsReLb/diMZ69r91EEBo2ML?=
 =?us-ascii?Q?Le27Z1QiCH9CDBwgW/2mO3CeMancDGoRsxdmbnSbgGeaSA2Ku1eHOjS2bqLl?=
 =?us-ascii?Q?WTfGvrwWlZy59wCMENCL+t+CXhn5sl7Jqdiz+3pno+Ynvtt/61qP2NGgueQJ?=
 =?us-ascii?Q?Y/6V0HVGPQB0TlfcXhKOZGFQ1Mq9iqnxQAB4lRCfDDDN7AqnpH9vtZ1enEeZ?=
 =?us-ascii?Q?Rwd7QhTRzWHIJeUGTvosZiAeNr8qgHcpBoPiusuX7CrqEiteSv/jnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 05:34:52.2807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 957d03c1-3e9b-46f1-a7d1-08dd2e13d83c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272

Add device tree bindings for AMD Versal NET EDAC for DDR controller.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v5:
Update the binding
Wrap the description

Changes in v4:
Update the compatible
align the example
Enhance the description for rproc

Changes in v2:
- rename EDAC to memory controller
- update the compatible name
- Add remote proc handle
- Read the data width from the registers
- Remove the dwidth, rank and channel number the same is read from the RpMsg.

 .../amd,versal-net-ddrmc5.yaml                | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/amd,versal-net-ddrmc5.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/amd,versal-net-ddrmc5.yaml b/Documentation/devicetree/bindings/memory-controllers/amd,versal-net-ddrmc5.yaml
new file mode 100644
index 000000000000..7021449e2211
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/amd,versal-net-ddrmc5.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/amd,versal-net-ddrmc5.yaml#
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
+    const: amd,versal-net-ddrmc5
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
+       compatible = "amd,versal-net-ddrmc5";
+       amd,rproc = <&remoteproc_r5>;
+    };
-- 
2.17.1


