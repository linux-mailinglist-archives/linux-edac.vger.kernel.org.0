Return-Path: <linux-edac+bounces-3377-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05617A6AB66
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 17:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9721896F7C
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF4022539F;
	Thu, 20 Mar 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="H7dDwOc6"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11011060.outbound.protection.outlook.com [40.93.199.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D373224223;
	Thu, 20 Mar 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489210; cv=fail; b=FQsTuEv1/uxMP/KCPhz8UGNH74u3EtLujtA4X5+bKWnIZ882q2iSongZU2vw1sImB8POqjp/GArWIEPLJD6C5Mg+dvbJGG+WtlffxLRcHkxSIIJ/1p4GKY0ptl/7HFhDjmDepkuHzb1SmFUgPUai/YlAIKr+kIDmpPeV0ojdErE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489210; c=relaxed/simple;
	bh=o08r/mIXe+y7WuVyutbzqePOddzUlXqVn+rpSJBP9DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UNC1uj+p06A39W8QCdGNxvDyJnBGpOs854jiQsJbiGRfgmxZu0fPD4KszDyFM/iEIimzaUud4vZt62ymQJVpGVPQW3aJDQeE1LmlBJYFNhCCpw/DB9acyDkbvF1+lkJ/VaW8LAoONB17kWjjxA4etqVDKTP2vOvVVWsS7QiDC5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=H7dDwOc6; arc=fail smtp.client-ip=40.93.199.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfZ78pV5zcEep97g3B71dVqalN+nWfSOAsRZArUEqjmfTNC00ZBKNtKn19Rp6tpiZjtHQH4g6RLInsjeZo3RSQEXALM/VQZ3bfK9WVs/1sc0Q/F9gALfUGxQ6UNMNQh+DWddndTZLlZMkgW0klZcR4DE1CpFZlVQg5VrRSBfBbsUSmsNuPWYqCy0H1RytHejID9vvYYhcXtOTZ7jh0C+edgX1zSblGKtKg+YeU0bLjNEhHXbOYOY2lwgeJZX0t66KAvh+FsjQy8Oj9URU3u4JQ1pglYxw3MMQmEG45tmLiAtYdZyAVHOg3PSDgSaTtend3OQSwlyfN3MEXXL8Hox0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gSwtAjRN8TXe2bTSkkz0TFDB4+f4JwxqGOUqE0M3/g=;
 b=VVcK8CJJ597BBliwrXvSit0iYP3Ox19Rji/pxHNlgGehX4b+95um1vmnLx0iGmXEQLcVkTlNKoq8B0QRf4FubEt54JpDvxvTa1yIkRSWaqjePp+lbooOVEaSul37enbuS2432DOU8AlLAqHqqLXtS+hlPqAljHgDoyY4aXkTO6v6xD7H3i3n6hu6ABuvqFbh8mK+ZtTMwBTO9KxxFVNS7BStFvPAVKPFGLlWBe+dO7luNRvLAeaF66wQIcNxZn22UDpPkA1hem0PgfLvskCazj++iL3jty+vKKBQfC2F95wvZIvqJCVMg3Q+vRfJPX8LspuLGSwA7XqNsMmkWjqZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gSwtAjRN8TXe2bTSkkz0TFDB4+f4JwxqGOUqE0M3/g=;
 b=H7dDwOc6jNYcZ5kOFWNuej4qZeBgucW+8yE7cZfznntfzvpNFq0PqmxUyf3m1/fgcXRqePXy9uyq2blXqZCzS5NFUTtEIlqkijyF0LM9T1SSiGnkGKXzVqTANQWH+PvvclQzTQ2oJr2AalY+tqA/MMVcMDRcOadbuVsxmsSUTER/FqQbqmUzbws1JTeB4VDOeMqAZt8UjyWFVWn1QJn/McnrU8nv0Phchp0zxI6WF4BILA34nymV8ox4v6xHIEjqEdeONy3DCzuPSoPdLQIEyUPdmF6/b79bPt0MxdZDk8v5XG/qWURrK/CDEEOzerxuccsrvYxNH6yvF+grZLwBjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by PH7PR03MB7003.namprd03.prod.outlook.com (2603:10b6:510:12e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 16:46:42 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 16:46:42 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 1/4] dt-bindings: edac: altera-s10: Convert to YAML
Date: Thu, 20 Mar 2025 09:46:19 -0700
Message-Id: <20250320164622.6971-2-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250320164622.6971-1-matthew.gerlach@altera.com>
References: <20250320164622.6971-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|PH7PR03MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: a175b667-17f0-4ae1-f7e5-08dd67cecaf9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BkiWVH2hVPADNZv8gpQIZXulckZftPYWFlgP403Ym08EbwkWQ6eOeDPyuPak?=
 =?us-ascii?Q?qsOQXG2LFKtxpOm9x15a7CV7o9+HjyseHr89h2MxqN6bCx8I9mF7mmIowvof?=
 =?us-ascii?Q?B0RL06PEtCSjEYfbaSI68xMTfuvbg+ouDooqm4MEv24g484xRm8IX1q3Jm/+?=
 =?us-ascii?Q?nPHDD/N202R/K8XDkwEnBasrrnnbqwHedVdcihmotx95zll2hsHWyuKi2LQQ?=
 =?us-ascii?Q?cA8J3rNNgel7i86mlAO5OhBFdRAtdOSB9gNywe8CpsVdsWNhu6pTqHnY72Uz?=
 =?us-ascii?Q?vb84So8xjZk00gq9aZbBYbQ5xOIHC+7zrmcefHwyzrwaMEK0W/lcSB/4wYQz?=
 =?us-ascii?Q?JIyHhY/sChWO1sH1XoUBRFg6FK98vevSnzYc+qvxa2hhjNcFphBPexfeJ731?=
 =?us-ascii?Q?zSe5uPSV+tFuP5OK3ulfmzl5EfaUQi/Wisf+e0U172qsVqQE9ceD0lyPQXWi?=
 =?us-ascii?Q?EjTY6kgEMnzBOR44NHaLD8bpjRjUhOLZl4n958gIctaA8JgZOMiKQ6hWyAVB?=
 =?us-ascii?Q?gf0VltA2uBk6DxBzEP26+1+MHNvLZWf+MCCe6UC5afO+wbjlKZdAV7aDrV2L?=
 =?us-ascii?Q?1fRYJSHbacbeEvQVoS+aGWpX05XAhagmLoX+XtYqt+cfsiLT+yDbYicWtYQN?=
 =?us-ascii?Q?UbNleYigaw8Phq7L36nEpKtWmz+dxzRz2TGoh5YxmqhWeGQRAJNgwiGKOMX+?=
 =?us-ascii?Q?GCd/81okNwHQKIGKurHTgDsxTdeg+USFttiNScdOboqtY4pRG/hr1XjHgtoa?=
 =?us-ascii?Q?IZPJNkDrpOr10EhiVVHBWcGpmb0Pk/VH/d5QuwxsAn6mn/c1Al2qQhDCbP2B?=
 =?us-ascii?Q?fMuyLLlA3IgR1wWjE02Z0P4WHax4MAiUA5TKDf5icSd7K1l12H+bAKIobnT4?=
 =?us-ascii?Q?KcV58v0dCBNtCY+sDTaf1Nink/WKjKmhHIR/rtDpSKMOCG7CEBXP9LW/nMBz?=
 =?us-ascii?Q?vEZgG3+Ds8j4scmclSZBjHajV9HEKAdauSgnCu3OWr0T4cwGghI66siKHliK?=
 =?us-ascii?Q?gVmb0xU2n4WpQu+kzQNcUgOZCrMFz/0yLqLdkvZjZWVFTXfyJ8oWhvBjiGnz?=
 =?us-ascii?Q?+83GNFrPzZRn41KFbhUTY2uKkbdut1aQtkASY8TGKZSV+J3eEqV1aRpgMXXq?=
 =?us-ascii?Q?6DHPCxlZH8MXSS1T2h5XKsM7dBE1by5zryZuItULM9UdQTFdXe77GCiINu6N?=
 =?us-ascii?Q?JfR7PTfy6DKpiqXoTsG4WVHESA9QIQRXnN/8wd1RqfiC6seg8N2KORyaqhqs?=
 =?us-ascii?Q?a4uzHTnXAWtVYtA7p8oDyk8uDK+QKE49TzX7aASMWPb2udY8k0/BhZv3gzj/?=
 =?us-ascii?Q?UguWXie/HLZ6ktLOyQyAAg+xVRY+L4sfAZxMfHj7+PKbxlpR3C+72ltyqU+F?=
 =?us-ascii?Q?qYNlxGrc2Mj+DrG8MRzOf8OHGKLw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XOopi8z/Pvh3YvRSX9n+jY1FVRy96XR2U5USk+kjrR1EHCBIUxJwilChSiW7?=
 =?us-ascii?Q?X0CE8bQHlXXECTRDa0LUrr4QgHxMlSVM7hWv3SR7iOagy3S0TljNw4iG52k9?=
 =?us-ascii?Q?Dp9THJ2aPzHgQwbgufJsXrXpBaRYmEMT1FoKwxJB/oFTH8udCzQNgEa2BaKe?=
 =?us-ascii?Q?lrC2p2Nw0rIVVpP0Fi6OZIRg71dDz+E5Ysr41ozrwZaY8hMQAY+vFOKvnc9p?=
 =?us-ascii?Q?IertpXTGpD1lUyUxs/Y9zaoDtVExp/MgbXsKlIoQhH2sYrgI0fZmUgjUot1Y?=
 =?us-ascii?Q?7ZGTzBgpspOn7ecFG1Zzb195+Y2lLUjOLficu17mO75y4JdMGsww5Vgjojd/?=
 =?us-ascii?Q?U54L4w2vZ/MBMCrhssV57Pxbhn8enpv4oAZGOxriINDU9bA6fKf6b+LBEtyn?=
 =?us-ascii?Q?ZVioQAD1GPS0HSgWXKwpZhcBNcBFWyeBZmAjkUy2Bb7Uo1yYL+ey3gNeEmUz?=
 =?us-ascii?Q?5lXk0yHSh06H4BTg3nAMHCVYLmfcSM2NxwV2oDitJH+3SwI0RjosJZQr0aO4?=
 =?us-ascii?Q?DQ08VACM2X2OFSlBeVm3E3hSYLkWCyB/ysHDOyZdLz5PzcV5EP4gM+o1yUqT?=
 =?us-ascii?Q?DTqiUhul5rMniKkQytWitxeqhcz3mmLXPdu1u7IVH0+HBbkgO5CVTbsUVscf?=
 =?us-ascii?Q?BrnTEne2rG3TGGaYdPyqEbdQvk5Fwc8uzHaOe8rycNrD9Xmlj3/JODzGbSco?=
 =?us-ascii?Q?H2pdOyHbEgkXGbUkpmUjco6Ikxh/71YlH7hNHhX+ijI/Yv6nWjj+z53tv3x9?=
 =?us-ascii?Q?WJqtwWBtS9UNrV3nHbhhzu6guzgw0qUTYJFsLupH/0HWVedkTnHIZnnqgbKG?=
 =?us-ascii?Q?t5Kz6ZvlerDOU1EBTDJ2/m2YEmHoiVan1B9MYTJPJxl9p5o2bq9aebXN4K53?=
 =?us-ascii?Q?pRoUr7WaH9hYb5Oj5BDue2hBNV5iQMT904O2H4l2pijb/A7P0+8PU8ygaxFG?=
 =?us-ascii?Q?CJkcRsd5GnR6ugGWGXNKE1Lt0lJrTxeiOUSPIJ65D9+mMU1WAt2aFevp7CY7?=
 =?us-ascii?Q?jNUhLWZ1JlMQri/7L/PzWouleVYN+sWfwOSJMMlasmauqCn69SC2BiCFBeaL?=
 =?us-ascii?Q?Mcwp/JDA69o0I8KQ+TN7HyO93TYs3l2+dM5PqWd3jk4onk4cn6gMZ+BiiLJr?=
 =?us-ascii?Q?wJ1C+EK6vIgPXGevwlha5nWHCEEJRsuLcEfDI11JJTsiBxeRvYIcNidmgtdS?=
 =?us-ascii?Q?slhmSzVPvAgN+QI6lpbBcwA3+WBRswWoGoIEmWxzpH0JmiqCmcvq5HmxFmxe?=
 =?us-ascii?Q?9ETv2f0xfNXdC6zP4voV+uonLiXoYChWunoHedezFx9zoJEbw5e4A2HQ4Z1M?=
 =?us-ascii?Q?E3u7h3BMuj95mII9B1rDojPuaeH+MSHVrT/rxO+N4uQ8GIgQ9hB6Xi3NyY0Z?=
 =?us-ascii?Q?87DblCb4V/p/YTe8capIsVwlecBD3167/xazdAxdEvA2xRSLJiHxeg0W6EPS?=
 =?us-ascii?Q?Md+MSV5X1ZwU1LUhmoktKimv2vOQye8TTKF+m5nnYU+PCBzbitTQQcdk2bo2?=
 =?us-ascii?Q?1P7pmHgrdY5TNnowTMIF2SfwG8FYKDxwTJq2f9Lohfrwoi6pwivIs4LKCIzb?=
 =?us-ascii?Q?6qd6AjjuVWN6KrJKxxp5n7m9Fuvugq8IqOyIVZFE1S616mk2GsGGHD/eYzJg?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a175b667-17f0-4ae1-f7e5-08dd67cecaf9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:46:42.4160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqHO+LKN8DPirZDEjCnNa0ASnysTggIUp+3i9H2ss+TibBtbMga1xk74S1WGOOGS3ECVdBCYS7gkaS5cF1nOJ7jimZiZja4TW6JaCv1SL70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7003

Convert the device tree bindings for the Altera Stratix10 SoCFPGA ECC
Manager from text to yaml. The hardware for the device tree subnodes
have not changed since Arria10; so don't change the compatible strings
to include "-s10-".

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 .../edac/altr,socfpga-s10-ecc-manager.yaml    | 228 ++++++++++++++++++
 .../bindings/edac/socfpga-eccmgr.txt          | 150 ------------
 MAINTAINERS                                   |   5 +
 3 files changed, 233 insertions(+), 150 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml

diff --git a/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml b/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
new file mode 100644
index 000000000000..ad057a63e88b
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
@@ -0,0 +1,228 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2025 Altera Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/altr,socfpga-s10-ecc-manager.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera Stratix10 SoCFPGA ECC Manager (ARM64)
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@altera.com
+
+description: |
+  The Stratix10 implementation of the SoCFPGA ECC Manager counts and corrects
+  single bit errors. Double bit errors are treated as SErrors in ARM64. This
+  implementation requires access to registers only available to the Secure
+  Device Manager (SDM) via Secure Monitor Calls (SMC).
+
+properties:
+
+  compatible:
+    items:
+      - const: altr,socfpga-s10-ecc-manager
+
+  altr,sysmgr-syscon:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  ranges: true
+
+  sdramedac:
+    type: object
+    additionalProperties: false
+    properties:
+      compatible:
+        const: altr,sdram-edac-s10
+      altr,sdr-syscon:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to SDRAM parent
+      interrupts:
+        maxItems: 1
+    required:
+      - compatible
+      - altr,sdr-syscon
+      - interrupts
+
+  ocram-ecc@ff8cc000:
+    type: object
+    additionalProperties: false
+    properties:
+      compatible:
+        items:
+          - const: altr,socfpga-a10-ocram-ecc
+
+      reg:
+        maxItems: 1
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to OCRAM parent
+      interrupts:
+        maxItems: 1
+    required:
+      - compatible
+      - reg
+      - altr,ecc-parent
+      - interrupts
+
+  usb0-ecc@ff8c4000:
+    type: object
+    additionalProperties: false
+    properties:
+      compatible:
+        items:
+          - const: altr,socfpga-usb-ecc
+      reg:
+        maxItems: 1
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to USB parent
+      interrupts:
+        maxItems: 1
+    required:
+      - compatible
+      - reg
+      - altr,ecc-parent
+      - interrupts
+
+  emac0-rx-ecc@ff8c0000:
+    type: object
+    additionalProperties: false
+    properties:
+      compatible:
+        items:
+          - const: altr,socfpga-eth-mac-ecc
+      reg:
+        maxItems: 1
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to ethernet parent
+      interrupts:
+        maxItems: 1
+    required:
+      - compatible
+      - reg
+      - altr,ecc-parent
+      - interrupts
+
+  emac0-tx-ecc@ff8c0400:
+    type: object
+    additionalProperties: false
+    properties:
+      compatible:
+        items:
+          - const: altr,socfpga-eth-mac-ecc
+      reg:
+        maxItems: 1
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to ethernet parent
+      interrupts:
+        maxItems: 1
+    required:
+      - compatible
+      - reg
+      - altr,ecc-parent
+      - interrupts
+
+  sdmmca-ecc@ff8c8c00:
+    type: object
+    additionalProperties: false
+    properties:
+      compatible:
+        items:
+          - const: altr,socfpga-sdmmc-ecc
+      reg:
+        maxItems: 1
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to ethernet parent
+      interrupts:
+        maxItems: 2
+    required:
+      - compatible
+      - reg
+      - altr,ecc-parent
+      - interrupts
+
+required:
+  - compatible
+  - altr,sysmgr-syscon
+  - "#address-cells"
+  - "#size-cells"
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    eccmgr {
+        compatible = "altr,socfpga-s10-ecc-manager";
+        altr,sysmgr-syscon = <&sysmgr>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        ranges;
+
+        sdramedac {
+            compatible = "altr,sdram-edac-s10";
+            altr,sdr-syscon = <&sdr>;
+            interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        ocram-ecc@ff8cc000 {
+            compatible = "altr,socfpga-a10-ocram-ecc";
+            reg = <0xff8cc000 0x100>;
+            altr,ecc-parent = <&ocram>;
+            interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        usb0-ecc@ff8c4000 {
+            compatible = "altr,socfpga-usb-ecc";
+            reg = <0xff8c4000 0x100>;
+            altr,ecc-parent = <&usb0>;
+            interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        emac0-rx-ecc@ff8c0000 {
+            compatible = "altr,socfpga-eth-mac-ecc";
+            reg = <0xff8c0000 0x100>;
+            altr,ecc-parent = <&gmac0>;
+            interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        emac0-tx-ecc@ff8c0400 {
+            compatible = "altr,socfpga-eth-mac-ecc";
+            reg = <0xff8c0400 0x100>;
+            altr,ecc-parent = <&gmac0>;
+            interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        sdmmca-ecc@ff8c8c00 {
+            compatible = "altr,socfpga-sdmmc-ecc";
+            reg = <0xff8c8c00 0x100>;
+            altr,ecc-parent = <&mmc>;
+            interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
+                         <15 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
index 8f52206cfd2a..4a1714f96bab 100644
--- a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
@@ -231,153 +231,3 @@ Example:
 				     <48 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
-
-Stratix10 SoCFPGA ECC Manager (ARM64)
-The Stratix10 SoC ECC Manager handles the IRQs for each peripheral
-in a shared register similar to the Arria10. However, Stratix10 ECC
-requires access to registers that can only be read from Secure Monitor
-with SMC calls. Therefore the device tree is slightly different. Note
-that only 1 interrupt is sent in Stratix10 because the double bit errors
-are treated as SErrors in ARM64 instead of IRQs in ARM32.
-
-Required Properties:
-- compatible : Should be "altr,socfpga-s10-ecc-manager"
-- altr,sysgr-syscon : phandle to Stratix10 System Manager Block
-	              containing the ECC manager registers.
-- interrupts : Should be single bit error interrupt.
-- interrupt-controller : boolean indicator that ECC Manager is an interrupt controller
-- #interrupt-cells : must be set to 2.
-- #address-cells: must be 1
-- #size-cells: must be 1
-- ranges : standard definition, should translate from local addresses
-
-Subcomponents:
-
-SDRAM ECC
-Required Properties:
-- compatible : Should be "altr,sdram-edac-s10"
-- interrupts : Should be single bit error interrupt.
-
-On-Chip RAM ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-ocram-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent OCRAM node.
-- interrupts      : Should be single bit error interrupt.
-
-Ethernet FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-eth-mac-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent Ethernet node.
-- interrupts      : Should be single bit error interrupt.
-
-NAND FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-nand-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent NAND node.
-- interrupts      : Should be single bit error interrupt.
-
-DMA FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-dma-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent DMA node.
-- interrupts      : Should be single bit error interrupt.
-
-USB FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-usb-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent USB node.
-- interrupts      : Should be single bit error interrupt.
-
-SDMMC FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-sdmmc-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent SD/MMC node.
-- interrupts      : Should be single bit error interrupt for port A
-		    and then single bit error interrupt for port B.
-
-Example:
-
-	eccmgr {
-		compatible = "altr,socfpga-s10-ecc-manager";
-		altr,sysmgr-syscon = <&sysmgr>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		interrupts = <0 15 4>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		ranges;
-
-		sdramedac {
-			compatible = "altr,sdram-edac-s10";
-			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		ocram-ecc@ff8cc000 {
-			compatible = "altr,socfpga-s10-ocram-ecc";
-			reg = <ff8cc000 0x100>;
-			altr,ecc-parent = <&ocram>;
-			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		emac0-rx-ecc@ff8c0000 {
-			compatible = "altr,socfpga-s10-eth-mac-ecc";
-			reg = <0xff8c0000 0x100>;
-			altr,ecc-parent = <&gmac0>;
-			interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		emac0-tx-ecc@ff8c0400 {
-			compatible = "altr,socfpga-s10-eth-mac-ecc";
-			reg = <0xff8c0400 0x100>;
-			altr,ecc-parent = <&gmac0>;
-			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>'
-		};
-
-		nand-buf-ecc@ff8c8000 {
-			compatible = "altr,socfpga-s10-nand-ecc";
-			reg = <0xff8c8000 0x100>;
-			altr,ecc-parent = <&nand>;
-			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		nand-rd-ecc@ff8c8400 {
-			compatible = "altr,socfpga-s10-nand-ecc";
-			reg = <0xff8c8400 0x100>;
-			altr,ecc-parent = <&nand>;
-			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		nand-wr-ecc@ff8c8800 {
-			compatible = "altr,socfpga-s10-nand-ecc";
-			reg = <0xff8c8800 0x100>;
-			altr,ecc-parent = <&nand>;
-			interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		dma-ecc@ff8c9000 {
-			compatible = "altr,socfpga-s10-dma-ecc";
-			reg = <0xff8c9000 0x100>;
-			altr,ecc-parent = <&pdma>;
-			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
-
-		usb0-ecc@ff8c4000 {
-			compatible = "altr,socfpga-s10-usb-ecc";
-			reg = <0xff8c4000 0x100>;
-			altr,ecc-parent = <&usb0>;
-			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		sdmmc-ecc@ff8c8c00 {
-			compatible = "altr,socfpga-s10-sdmmc-ecc";
-			reg = <0xff8c8c00 0x100>;
-			altr,ecc-parent = <&mmc>;
-			interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
-				     <15 IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 0c8fb060072b..236e23174719 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3191,6 +3191,11 @@ M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 F:	drivers/clk/socfpga/
 
+ARM/SOCFPGA EDAC BINDINGS
+M:	Matthew Gerlach <matthew.gerlach@altera.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
+
 ARM/SOCFPGA EDAC SUPPORT
 M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
-- 
2.35.3


