Return-Path: <linux-edac+bounces-2768-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 918829FFD0E
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2025 18:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A58162BD4
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2025 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00548148832;
	Thu,  2 Jan 2025 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jAJaCu0T"
X-Original-To: linux-edac@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52536185924;
	Thu,  2 Jan 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839932; cv=fail; b=HCxgvTahIRVQQ1pQWyZ/HG7lKkqJciSdnNxi/n8xGBr1rs0DRCy9T2RL1rbPz9iWZES/hzmeXQNorP+9Gx9B8yg5yzQUSCW/gDhuVgRIR0WEoPtj7vmlkrFkozNPwEw0W+jsQppRPJqF5uhBL+E++mZmHyy5+fOKMRt8lDO/1Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839932; c=relaxed/simple;
	bh=VI0IaGZhDTKlOr+GsnufUmtz21gHZbkxsPpHwWwpc4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYB+PRD8CiA+B9vXeYfwVjy2nzY87G2h0lR8XR0K1ArH8hz9K/Dr05SeDOL6eChRw9QDeQxcOcVWjS3mo/g8ADFI64HO+xt+jwItec1I4nQD42rtU0fc5q9HwnAiTgjxNhEp9C7/FYIs7RH7dzD0ReDPDuZ70A6FEeaox8XbDOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jAJaCu0T; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPWxKRvE0Xg5FcpDc7mX8z8/2/GkZTDsy/fdPzIAjfHqgu86mZh2k3uorVnBt4gbh7nzXo7a/65uxbFLgIH0PyEP3qkdQs56b9svK+o0a3Qo1MrGyiYPF/57QZQg8O7QEYxc0IMuji5Y8lJJSgYMCVAOZF/56MfqjWwWkwO0MoFfhPc7ilt8+ZihHBOK9JKady/WMW4FTILJaU5W6Rv5ZTuDmZMVYY4E436wUcXtBeIXZjwPZuiN1pdDOBLmOBfZefUWee3y8cA0qjOQ6D7ytb2cjXUeicfrrHL/gf8jr/MoGbo2w4M5r+oHcADKx98M6pENvk4o7hyOtVr/O6cQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eI/K4TC2Iklg+lFBp6n1hZgPDF0YDKp5mrAGrAsBl9s=;
 b=PnYMoK9OKXdE70pMsRt05ftZnYWhHzI79hQlUmdny/6XggkpCoMPeiNUrpkhcpLGdrU5DUfgJJuQypc65JHtgOXbT7MG4Yo9BiG1VuefNH1J2zkTVjkncRhw4/WtNEVgdFrGCRcTioIkNW1F+Nqs6/5B96jlDkPxipL+dUrifpXTlEir/kPpxL2NceRa8bFNK2YlZ536c51MqoUHZl+3GTsO/kLbthhrBq4Fzu0qLus3eufYeQmrnreqXVr0QW7aDlyh5ELnhJLNEjf9PNWmyCdEI3ZTLXEv+9vGDjvUzjMy1Sfzfsi/ja3ZV7VO4fk7qtw39fGi6i2ylVJfKRIgRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI/K4TC2Iklg+lFBp6n1hZgPDF0YDKp5mrAGrAsBl9s=;
 b=jAJaCu0TxE+QhdY7d7AWDKHybiSjkqmvTQRnN3mE4fdAewhjROjQIfBpumgquNQLzK97WtWoQwEzZRaMwtF9Nh7zetUBaUevszonzMSC7Itzjm+CcDpm9A6xpnIzGSGVRJKfWCvPMkCGQIh3119J5nRQFIndmIA5ZOHInNbcNuE=
Received: from SN6PR2101CA0010.namprd21.prod.outlook.com
 (2603:10b6:805:106::20) by MN0PR12MB6175.namprd12.prod.outlook.com
 (2603:10b6:208:3c4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 17:45:20 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::9f) by SN6PR2101CA0010.outlook.office365.com
 (2603:10b6:805:106::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.6 via Frontend Transport; Thu, 2
 Jan 2025 17:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 17:45:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 11:45:17 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 2 Jan 2025 11:45:14 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v4 4/5] dt-bindings: memory-controllers: Add support for Versal NET EDAC
Date: Thu, 2 Jan 2025 23:14:33 +0530
Message-ID: <20250102174434.17677-5-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250102174434.17677-1-shubhrajyoti.datta@amd.com>
References: <20250102174434.17677-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c48604-01c0-4d9b-071e-08dd2b5539b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Phy+lAX2ZRrkVN4O6BQHnECJvzOKt9dYnv0EYJqqNZDvKHSfZaYgwpv9WmR?=
 =?us-ascii?Q?R0lIoCaj+d4paBRVurVS17qmK5Lv4MTGojrvlOWaultM5KNB58mjQXo4Bj9D?=
 =?us-ascii?Q?mK7pTF8gERmDodacMSbZgB2Mx5zTclHnO0UlvpfN7VGlIo9XE+b4jiVGCrmd?=
 =?us-ascii?Q?PyKJOQqUw1JH8rwwGTDkJ8LMYHEYQKG04G0+niWA/aZeTGosj6UBSUQiTxg7?=
 =?us-ascii?Q?pWzjApaleD7ocx+ZDe68WPjgQwcDQ7wMk3/ojXbylRgehwCI6jd2pFSMUoyA?=
 =?us-ascii?Q?hvJ6uGqZx3reANv5zuGODTvfILaf36FkmOz/VhKADoLKbEvET/+Jte5iSBhw?=
 =?us-ascii?Q?oQXyea4Z9xRnxDwy4kJzliaCl0n1QVAKIQc/InzPUXE5yOgbbDm1b6dJCsvK?=
 =?us-ascii?Q?cUb+uST/AMunQeKz0v+RTMfvDeoTgWcWhvg3N4YhC2NzL8vWcD1F1yi9eKwc?=
 =?us-ascii?Q?2bnjzHgP1aPKH3Q6XNOAUo9DceMkqnoIXwcfuOyjNbYwrip+PoI1MJk1k/sK?=
 =?us-ascii?Q?w/8nUc0MbqXMh+bUBUlUEDUtjNv+rS6EGlaMm4a3+E093mfBjCTMXzn7vfBP?=
 =?us-ascii?Q?UpUkU6Qix8KO1k+GzQGfpbyxQJMEt1KazOc0Z0tgJMnlaEVjeg7AWJgzTyhS?=
 =?us-ascii?Q?TVflTBmYJq2BGwYFUvhg8j2W/D9lmy5daRh0gW1KHgmtuWqCDlE4UmljZXbA?=
 =?us-ascii?Q?qCBQ/7mMHWbSP787x8TUz9wiXp9ehdRyxMCk+8LOt4H9tfHcPlBcWW3y0ouf?=
 =?us-ascii?Q?dyHC3VRDl4w4hG5N2gzqV1U+5zVQPBV+fJIcLuKTaV5K1DDPpRXpHjElKsUW?=
 =?us-ascii?Q?seynRw5/vSX7YTCFgo+KAMmt201/LtCcui2UnlSejpEuXJZqSwdtR+kY7zqT?=
 =?us-ascii?Q?LQzci8mFCsR0RV1r86q1R9UJvX7+hwFmPVXX+OcKc3AiIdjnj6sD9ecuNk87?=
 =?us-ascii?Q?dBymFmY55udlkbhgNz04sSq8+Aqjdp+5V26Evmp0oPyhwCC1i8QWylpTWW5o?=
 =?us-ascii?Q?655xBTcWO7jbCJxRCUDMtwVou1cwgH3a/+sYe3Adv+pb+EToSRx570kiZksH?=
 =?us-ascii?Q?Lic/DMK6wagqbk9XZFTOnOwxgH05AIKQXUnsae8U3JnSnzZ0SJms/gjQsjeU?=
 =?us-ascii?Q?HtNmCndzqiTTNc+IRMckALOapsS+zpEW0nj6pLXGr7QGcvL+k56F8yzApYR4?=
 =?us-ascii?Q?ugj67k6UuasXcW97UBfkA9+8Mj4mXgl3ZgcD6WE6gDUlyQFAzrQgSa3nuQBi?=
 =?us-ascii?Q?7IjXg1gdYkYHZzUtHyETVYwSwiFsLAd8SjJIwg9jD01hlbz7QzovZIjXVt4j?=
 =?us-ascii?Q?cjqLNutwhTNxPmlYBhYE883UCAvDYLuR32o3cpZLu5l2dlRfo4/1XqFYCgWf?=
 =?us-ascii?Q?Fw7x0d9vhurHGxBanqpCUVPaZ6G91UCRvA9OyE9yGmTjHaAE/QpsqkSIyUpo?=
 =?us-ascii?Q?nSmSWfgMO2xNRpbwirvWwxTmC/Gx47X/v0GulcflREQS1p2yob7j5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 17:45:19.5920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c48604-01c0-4d9b-071e-08dd2b5539b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175

Add device tree bindings for AMD Versal NET EDAC for DDR controller.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

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

 .../amd,versal-net-ddrmc5-1.0.yaml            | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/amd,versal-net-ddrmc5-1.0.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/amd,versal-net-ddrmc5-1.0.yaml b/Documentation/devicetree/bindings/memory-controllers/amd,versal-net-ddrmc5-1.0.yaml
new file mode 100644
index 000000000000..4c81e30f4818
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/amd,versal-net-ddrmc5-1.0.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/amd,versal-net-ddrmc5-1.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Versal NET Memory Controller
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+
+description:
+  The integrated DDR Memory Controllers (DDRMCs) support both DDR5 and LPDDR5
+  compact and extended  memory interfaces. Versal NET DDR memory controller has an optional ECC support
+  which correct single bit ECC errors and detect double bit ECC errors.
+  It also has support for reporting other errors like MMCM (Mixed-Mode Clock
+  Manager) errors and General software errors.
+
+properties:
+  compatible:
+    const: amd,versal-net-ddrmc5-1.0
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
+       compatible = "amd,versalnet-ddrmc";
+       amd,rproc = <&remoteproc_r5>;
+    };
-- 
2.17.1


