Return-Path: <linux-edac+bounces-4404-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7220B0E12F
	for <lists+linux-edac@lfdr.de>; Tue, 22 Jul 2025 18:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8A617FB4C
	for <lists+linux-edac@lfdr.de>; Tue, 22 Jul 2025 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ED827A925;
	Tue, 22 Jul 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iS1Djjyb"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD627978C;
	Tue, 22 Jul 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200240; cv=fail; b=WQJDTA0Et36+0UO8urTBo3uOTGMNdVbcU8YJxzWz3hHHNzWlL6m++sFeG7Q1DaBwlPqh3JS+JytPTKALgETwcksLyNPaT/4Vit80vG3gjxRTuJCSWed5xc2wSXrSdgSLRMBWbxhzvgFpHsb9s1FLu2wyIWdQsgmQYpaN6bOBsbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200240; c=relaxed/simple;
	bh=xkB5n2nw+VALLQISF3Azh1C4oI9XE9PKlO+nh/p0hx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9JpQ6pkq00dS6vS7njb7vx5xhNrRHM6C9O6JzDXG3zzMIyT1xh2Gc+mf0qVHWUphVaksTd+3q0r80vJ6+Egpda2nJz+Vc5VV47Ih9yFc0x97tXa/D3dhE24/14u4SDFsRLiHvGsBs3ldvyiI8uwkszLclwVjETFXhT4+Y5LO+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iS1Djjyb; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVLSZybmg7QmRKGuvo9VeuABk816X4V9d+9bG+9RGzbss0XJR+2EiCrMRFxCstU4Kiihdgu4q5kU/z0W/y40+aX7O9i1O10v9aNHAc5aOS1RcmtL4zpcCdMYi9v3+T/MvW9J9v8J9WfG5wqdCd5Tg0zTTmJ35Ly8hwedRqAr9Or8pzgMnSeDUhEcY11MEvm/L2m4I6hFfMRu2zckz5MRpGvMxPdejGwbDKNIu8axf686alLAUz6Tp5fXhm/Fe87tsY5VTvCsHL+v3ZGNLud/0NOi//QmGkNwanD9r4+SqZ1WSQp/ZF6scUXt+rGTntqFFSXv6nyuK7Ii2VaYAblnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cT12I8wDfo9lpQwOzb0qKAz9ZkS2gS83h9rRqLr13g4=;
 b=x4aH3qtNE1fjBJR/POuOTJOZat+WIKxvsqGWHKG0ofRTXAQwhBZYvRiG3POuAer1QwKeRUDw5SBVeV877adKEyDNWadOZGAXqLLzqqpSG3kXld3O3pfKat/MKCbyexLADKnGjdjtPy86UPfUMOktpz5QOjGdUgNKfXADnLwivX6o/BaHy84a1zvedIuQ1iEGo3ok8olsZsRi6r1dv0rCXoRtbReic7TnPPJMqJJgAkQaLna5VU9WiLBModWdIJWcpt+56850e5+lnLdXEJqDBehyT34d2LEzNcoeD6LY0Rx8DYf/cTBRJ0E19h7XVE4JmAHIvxUdZ5MTDCtAJGLw9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cT12I8wDfo9lpQwOzb0qKAz9ZkS2gS83h9rRqLr13g4=;
 b=iS1DjjybtZWi9vx8RBD0AvSafb7zqLFZantKwDk8CBwLUwq2zBgdfy892uC85rA7filv/BFBUUoFEadSUDh9apWqLl9NTbPRvMX9MYukWl/VzW/0C6w+JdRvLgkmoztxIlAVIlIhhRUkFH8K2S08LmeOtWEmnz0W3+0589Ag/bk=
Received: from SA1P222CA0100.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::6)
 by SA1PR12MB9515.namprd12.prod.outlook.com (2603:10b6:806:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 16:03:56 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:35e:cafe::ce) by SA1P222CA0100.outlook.office365.com
 (2603:10b6:806:35e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 16:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 16:03:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 11:03:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 11:03:45 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 11:03:42 -0500
From: Rama devi Veggalam <rama.devi.veggalam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <james.morse@arm.com>, <mchehab@kernel.org>,
	<rric@kernel.org>, <git@amd.com>, Rama devi Veggalam
	<rama.devi.veggalam@amd.com>
Subject: [PATCH v2 1/4] dt-bindings: edac: Add bindings for Xilinx Versal EDAC for XilSem
Date: Tue, 22 Jul 2025 21:33:12 +0530
Message-ID: <20250722160315.2979294-2-rama.devi.veggalam@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20250722160315.2979294-1-rama.devi.veggalam@amd.com>
References: <20250722160315.2979294-1-rama.devi.veggalam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|SA1PR12MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: d05349a1-cf93-4b49-6a33-08ddc9395c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c5jwOWNZptFK/XsItWN5ARs5m+IcgF3pDF3U8rjvJN5Q4IqzAW0i+kWj7Peb?=
 =?us-ascii?Q?F39BlmYgExvLB1ya43ipv4CcNBvZZjJdV+xGpYr4JwxAIMKxkS1S7J8OC5jD?=
 =?us-ascii?Q?RAKGpcg1iIi1s270icyCtsrgMZuhIRtk92BOwzpadZSUuw3CmJhqAYvU+1Up?=
 =?us-ascii?Q?QQeTwUno/o5BlaETkoiVpJHnnOBPSDy5v7UmKyBbyGhJSx1qCHJCELfCiKJJ?=
 =?us-ascii?Q?zHTdwDmnp3ZcspRMfGZTlikvYavvFwN3PcNKsh6GWUKXiU7P46r8SdOMk4r0?=
 =?us-ascii?Q?Fd/LpZnPG1gfC5JmzSa0VU193rnXP/GgpiWFCcJRAuwgbRC0pmye44P+5kMj?=
 =?us-ascii?Q?ult0QXJvWlBCuCuzDtMmDmz9u/ozydPMsLpYDmfKm5Mp95YZ2z/u92dV75Wn?=
 =?us-ascii?Q?ywv0XKQ4PNaMBWgei2RF5x03i5IUFGmCWDA653zj7vs+qWadQuQK9nVpiuuK?=
 =?us-ascii?Q?nNWlJk65kW1LqXt3skRi6Ml7bGLLIktJ1wrnCAFUbNl8Ofkb8FC4t4EfEqXb?=
 =?us-ascii?Q?S9GWIPUd9nRIpCUO+YRfa630Qz++yomfv4m1WJnysd3KCUSrNQfH743L5+e6?=
 =?us-ascii?Q?oPhcdeeHZdDsojkPSxNu7lDOZs7iw7Ukey6AcLIvk47VCey8/Es2s4R8hwmZ?=
 =?us-ascii?Q?Pac/SrZ8ZpEawBzsZihFvXY7iArxWF8J98WJZL+4GCDTalQHravY5SNt+MVL?=
 =?us-ascii?Q?C5s8UgVFy1CY2FVBxtJw6CjSgCel1xi4fkgRE+/ksqwTDMcDzS3k/lPBN3QT?=
 =?us-ascii?Q?B6ZZoCh5dQnmL6o3tUX96ZxzuzBcSdkQdaJVujo3PQakRCWIxU4fxc8prTdf?=
 =?us-ascii?Q?AtMoG5s6YR2WRlzw2fgTrBCj/jn0j7CNTa2Xc8fpDIuSzYJuiiNaklOmEVPe?=
 =?us-ascii?Q?orq/ZnQsk+cAOWUTZDzmIPH4hPbaReTHNL4Zd4DKg7LnZElTywUoz93Ak/m8?=
 =?us-ascii?Q?O904/PiLhVzqHfHwZ+5wACTu0QSvG0jqiGqTPE1WZd7fdR5FGMD4Qa3MyZH7?=
 =?us-ascii?Q?YoVohqaXmcATvOGo82xZIZYYZ8WiXw4L3HZQTlapudumUnlMznt6ArxEW+M7?=
 =?us-ascii?Q?Q8+3tiLmv+xJgH3wr+MQESwHQHE5021c88G6V1sdVikVhIkv04ofFdx2q9pc?=
 =?us-ascii?Q?UZvgGAn0L0+sg4KwvTiveFiiQHEQDWeYm6hyi0dLlH0JYYuyH73li4GmHVt0?=
 =?us-ascii?Q?EovkZ/ytJnEIGn1cqUJwTsp+bpdydZfahWb81O3DQQeP2MgjETqOfoiyLkF6?=
 =?us-ascii?Q?lOxYF8n1Uh4GFtlACUU1P+Q3KA8W10XVIaQzNvcDC68Xz8l+1VRPBkYmW1sL?=
 =?us-ascii?Q?sfz8S75jJtd4WZ3sSeJ4u5wLQQDhatexq5Nf1fZy5+/LUby18PuadjGT49tW?=
 =?us-ascii?Q?86uoxNihk7qgLvAemQefpUv9rmN8AjRtz8qjVamP04gDbk7eXF0Wt6TYfTJx?=
 =?us-ascii?Q?+s3OmrfR44YeiK4Kj21yPsrm7thSBNhw0K4Fh0svN3Gui3v4ar9shg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 16:03:55.5319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05349a1-cf93-4b49-6a33-08ddc9395c56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9515

Add device tree bindings for Xilinx Versal EDAC for
XilSem controller

Signed-off-by: Rama devi Veggalam <rama.devi.veggalam@amd.com>
---
Changes in v2:
- Changed "xlnx,versal-xilsem-edac" to constant
- Removed "compatible: in required section
- Removed "|" in description
- Removed "items" in compatible
- Fixed indentation in examples
- Updated title and description
---
 .../edac/xlnx,versal-xilsem-edac.yaml         | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml

diff --git a/Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml b/Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
new file mode 100644
index 000000000000..23c1d0557a66
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/xlnx,versal-xilsem-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Versal Soft Error Mitigation (XilSEM) EDAC
+
+maintainers:
+  - Rama Devi Veggalam <rama.devi.veggalam@amd.com>
+
+description:
+  Xilinx Versal Soft Error Mitigation (XilSEM) is part of the
+  Platform Loader and Manager (PLM) which is loaded into and runs on the
+  Platform Management Controller (PMC). XilSEM is responsible for reporting
+  and optionally correcting soft errors in Configuration Memory of Versal.
+  The memory is scanned by a hardware controller in the Versal Programmable
+  Logic (PL). During the scan, if the controller detects any error, be it
+  correctable or uncorrectable, it reports the error to PLM. The XilSEM on PLM
+  performs the error validation and notifies the errors to user application.
+  This XilSEM EDAC node is responsible for handling error events received from
+  XilSEM on PLM and also provides an interface to control scan operations and
+  fetching the scan status & configuration information.
+
+properties:
+  compatible:
+    const: xlnx,versal-xilsem-edac
+
+  reg:
+    maxItems: 1
+
+required:
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    edac@f2014050 {
+        compatible = "xlnx,versal-xilsem-edac";
+        reg = <0xf2014050 0xc4>;
+    };
-- 
2.23.0


