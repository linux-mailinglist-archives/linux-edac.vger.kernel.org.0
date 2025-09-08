Return-Path: <linux-edac+bounces-4742-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB6EB48CA6
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 13:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331D63B3322
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C8A2F8BF5;
	Mon,  8 Sep 2025 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZRhZYorg"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8C22EFD9E;
	Mon,  8 Sep 2025 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332660; cv=fail; b=NVb1P9a4yQGWrrZ5XkdIuKNISYE8Y3E3f3OA6d9a/e+ZMSh0aAFPjx3Uc2Qj7/HZdnh4qDGa47oXU/oQNhK/gEj3KWxvVORfA7wo7lZe0CVbH3rTf7HKnuKM4TxHYnG+BCWdhICSYd97f5OeLIzDzvAO3EvDo1G/8Rf6Daa1xZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332660; c=relaxed/simple;
	bh=8xq7tBtj6ymWhfzsnIO9IqanvAViVIGeIP5Mnm/dwy4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eypw9XrYsYK8By2Vj9YgqOLJKEZs/JJf+PAsMtGzzBq7zw9hCYBdjKY12x+RRzg44GtLU4qUPnCouF7on5D/oxqCZRfSSmCpXcpntGDVcYNqbCxmeVxStaJsSphqFzHw33RhS/LTPgFoJFQ0aFu+Y6tWUuizwJnIHRD5jHVBPbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZRhZYorg; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ai1HuSPJx+9GniWRGRzRbubtczGZl7tdJDhatz4vqCOQWB23X3tmPnsk4qm7UMukWxcaU1KpLCmQANwBOfQ/na6rNJBLFxZfI10y0wA+OVHD3EB+1yqFJlufCa05zdWqoh/fFVyC6O/4Np4nnBxX3aJ4WnpMXYc0yER/dLKsEXHw9b6yxLKRg1rzM5v06geM6P3E4Fm+YA4HnUKTejNRrQtIwjqA3cVO9YqjN7MMbaGF0bTNIHLvFGwVzArMAz7HTqRvwhyWHLM6VEShs5ddJI7xygEPtA5S9U6I03p3P5OA8DgKZMfoFNP7+hbxp2r0nAx2+bgYYsyR3rMKUWwxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60BEWeBv9YRjXsIKLMR9AQ9Uwu/ub2OYV1K6fL9WW1s=;
 b=MfPwG28EPResz0JqWvPxW99E83QN05PXwzM3d0OqY1OHrLx9ZBK9oV/OaZHJDHMPLpFlvdbOS/vUEh7+nstgCgEo97uTBXlQ7DaDLaXGVav+OieKyUAWy4k8ivwumujLutKlV2PbTg7CPqhK0GQzl2BMjb2c8SG9FYSSpYtnsmQCoS7DVJL/y/CB1L5aRXA0A3pdSBK8t6oGOOJ1m6dVhHH9b5EgLjJlGNJVHHAXO8/yFQ2MLjwroA7ktSngcwjVIuOxTBqKp31aZhFlsPh7ujSwM5VrAm3rgqKyQ7ww/ZhavFzX4m0+989GqZSA332Pam0jCLHbOrKhcD2jxVDHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60BEWeBv9YRjXsIKLMR9AQ9Uwu/ub2OYV1K6fL9WW1s=;
 b=ZRhZYorgcd4xh2VEoRmmtv7cDcHHJ1xe9srRd7n+zDWou9bq1CEAOURdKOxMsI2N/usS6GLyC5fB5uiABt6pSWpnikaVPKUPwiUHHyD9xob+tiCSZynf3CNHTWOG9XY9/rhv3rACRicxsbKT/C8sH/TaD20b0hHGz82J4Vkxcno=
Received: from BY5PR17CA0052.namprd17.prod.outlook.com (2603:10b6:a03:167::29)
 by PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:57:35 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:167:cafe::a9) by BY5PR17CA0052.outlook.office365.com
 (2603:10b6:a03:167::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Mon,
 8 Sep 2025 11:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:57:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 8 Sep
 2025 04:57:22 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Sep
 2025 06:57:20 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Sep 2025 04:57:15 -0700
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
Subject: [PATCH v9 4/5] dt-bindings: memory-controllers: Add support for Versal NET EDAC
Date: Mon, 8 Sep 2025 17:26:48 +0530
Message-ID: <20250908115649.22903-5-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250908115649.22903-1-shubhrajyoti.datta@amd.com>
References: <20250908115649.22903-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|PH7PR12MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: a1438728-bb31-4804-9132-08ddeecee696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?59QuFOsqzDMxHgbFeX57B7byT+d/6oonY5iNnNh+QDdm3WDFtjdcYTVLCzVr?=
 =?us-ascii?Q?ZjWR9x7qVeS0gVvS9V8kgiLerFLGlEPfKZnhXrwtkKMk1CQFkjiNSmaJgGgS?=
 =?us-ascii?Q?WJyPrKl6QgY0nP+B2z79AJ1H41EmSMXkOAjpMrD3JrLLqteELbbe+rL9uV5U?=
 =?us-ascii?Q?DN+5UKjxQHBzW96/a8w1AP1o9w+2s1WK9Tm5oBGSJUMBhCuVVGndR79k+woS?=
 =?us-ascii?Q?9yZZlEWp6O5TxIGtWhcJy4O5n5FNMPXrxW4XnPGN4EJ+ZGAF5ccYrChI2OlJ?=
 =?us-ascii?Q?tLZ3jLDO9tubJdGseDNJ72XECdX2h3tsjJ5W12Y3Lq+DfjNL4x696SKs/U0s?=
 =?us-ascii?Q?0ygKF6DhuEiTeFTH/2yHa6FWWyGHsrkxhcz72nrQDgKmjVSo9IndFISbLnWt?=
 =?us-ascii?Q?aTsDKrjlZTVPq5EzIZp0BQccWk4EPXQw4MRM9EcTkRPbPU/szr4HD2GG/sJ/?=
 =?us-ascii?Q?TXPwU4FvgrGPlio8vX+eJDCpt8pUEoNKNhWoZ9a8MKMFNc73oF/wr6H1LfWk?=
 =?us-ascii?Q?DtSiT8Wd/gK2hY/j737c7MCb1JoK5uXCQM3dZidXa3OO2oTb3BwpXRBy++KS?=
 =?us-ascii?Q?PSEZCAHi0lDRIMa4fTpS95p4m5NZkMf9NfnKxgq8aG5QuFGFoXtZuHVOI0bo?=
 =?us-ascii?Q?NCVoNcJyhBb5aPAhUMfBwZ7Sy6NVhav5r+ch3g+cnl4zvJwfu5x1UodS6D7H?=
 =?us-ascii?Q?TRu2n+S7lzGkvyW8dxNBjzPAnECKy7yQSU5ESE0P94Nju3VmLylWMe+CeaUS?=
 =?us-ascii?Q?VbSG0Vk1saZjlWQCTEhLi32BTz/S+y4j0FIqCUJEWzuye8RUA7rccrIuCw3o?=
 =?us-ascii?Q?O8q65qWCmw29bbYa5G7XorNovPYJsx0Pq7jm+DhSAktpXSaTf2li04aqgNgR?=
 =?us-ascii?Q?pqyd29LSODWp6ABA3NYfzKezLl30bFMBZK8phgUNrwj6uVLEhcJx3Kms+jzI?=
 =?us-ascii?Q?XtoL68AbH8N8QQeIhVKpv67XgiOO5h3XT+TfJXm3c+h8+otrDk4wsLzJhKCx?=
 =?us-ascii?Q?IDvf2AjSZOHj5glFy7IdWTE9BpHvck7zsduuxJXrgN3uJvC+iHRHFXda/daG?=
 =?us-ascii?Q?kkNURSanFBRgJ+rTNihxrS35f+O1ot9nKfc585hIw7RBZSA+5vsP83hOdrY/?=
 =?us-ascii?Q?8cuQ+jUy/sYXtfP5iNywxhAguCacJXBIn8uZgDMivLSsmUe36sDw9RqnIWXg?=
 =?us-ascii?Q?r/yGIoEE1nyqA0EZkI4zlzwPC71WYS/Ki0F85+v4nOFiPb1x5sZGNq/V5PaB?=
 =?us-ascii?Q?pAzCTFSSWATWoG46n7Gj/rEjo3IbWMC4r4qrCQjbEEEf4ppaJLJWwFgydbeu?=
 =?us-ascii?Q?OJtbN2L2glcBy9LLB9q/ziqV7ykvMox2SEWTDygOz3nvT4pkms9NjTifA2XT?=
 =?us-ascii?Q?ZNuwJYzW5OnISkkmM0zlRqI9WSeeMnYLjFV9uZH7kN77aT+MYiExKNzwwsw4?=
 =?us-ascii?Q?kZGRa+1HEATrO5x5MU5jKYjNV3s2NT5nYN46XCKOGCYuOevmHROewA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:57:35.4447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1438728-bb31-4804-9132-08ddeecee696
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6611

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


