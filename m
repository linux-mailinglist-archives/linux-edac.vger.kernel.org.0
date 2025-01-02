Return-Path: <linux-edac+bounces-2767-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984999FFD09
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2025 18:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820753A31F4
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2025 17:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FD01AF4C1;
	Thu,  2 Jan 2025 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RRLMYlcy"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC7195F0D;
	Thu,  2 Jan 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839926; cv=fail; b=n3CoAGariiycFkBTZ68erjfZ4U6Co/oDjieAtkSESJKL1zeN6ySVzKcn9k4fVlOvkryeX7Kb56s8GGjaVvRooMHD70Tu1q1enbOo+tB3HCRCEu67dEpubRhetNohbQwcZUa/DI1IYQB5ee1QFp3jNJZGpoNZsg6Dh+NcV+JV9ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839926; c=relaxed/simple;
	bh=yvdg//1e8752OL0niSJ/phg7+tUKnrSuQPNjsgpXZsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7CPkJFXzM2YFiOtTLU6wKGO7xJlFW7uAabcNylUjD52GMFxPLOda1VTdHeHiq0KRpY5UQHdQ14qrVaQyYLC6CKVY1Uj4i2Mk67V9LmsaWeKSir28GHB6m19E9PFB2tVSYC/agXjwkAZ3A7hYfFGdRRL0+0jgtGX7+Nj47V8z1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RRLMYlcy; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2SODg151wSANmrb6qWc91wMXMkvrmX1JONUxK0pB03je2n15qsdEkMoJo3iee9aagCjvoowreBAw42B2t2n8s9D5m5VssiazEXC8vIQCUCh6CXgN6KeC41ED+M3iplV9p9Rq8p4aFrS6u9CpcPHL8zMBcIb6M4hh79Ir+Hsan5nohYq3boHhZDt1jcj9Mhiah1ObmkINuq/Zfg9pQ1fa+Rv0w70UKfLJQaZ2K8y5vAT/9hIPobVEOeaUA7lyHjO9iamDc7FgEI79f9RsAPWUnjt3D4TS9LRzL1qfTamgR1J54EbawKpi+1ro5JBS5Ja1QxaMM0m0Mx8wFA7WvrC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2a08Q2bhaNDRUjwj1vU8qKt9PKCYPk5vvRmYMYUD7A=;
 b=DPoce2gjbnu0zWGODJDPhiIO2NStPv47OAb6FHzxGkMdlEnxHo4eXbcyjosDFTQ1i1VW7SA3s8X4gsW9DZiiBQ3Zih4LIPwFJxHhBNaM2c6xUz0Vf/OmhUBKciFpfgjJuPSCrDVVGpPhQ+lwoJsaomJ65ym44DWgpJbog+7IGjZhJOOMEZaE/JMe7u8pBfhQU1nFrM5BTSeQBIfNKLW6MZK1XDVjtO+9S0DXbGmTOdjC2VSltHfj+Te1f1MJr7a+g4BQHhh4I2kpCyFLAk7Sdq3FMq5WpQgiyWFTIkSRX/aXeOOyW/Qkvw7nyC6Haow6fwrXiDGJ6TbPZw9CJVFmwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2a08Q2bhaNDRUjwj1vU8qKt9PKCYPk5vvRmYMYUD7A=;
 b=RRLMYlcyz0PHs/o8Wt94DzZEC4nT+G2cplQufX+Go4jg82JCbXRS0M4MzoBNhtnHITXq6KR+Yv6DAKWHzk1pBJAIYEG54RD8tagMoaCpwplLOJLnwMRH30iflS7o43c7Jcn0/LVcsXyz9mHEASlcvSgliJmS0S6fUQpxY+n9gCw=
Received: from SA0PR11CA0022.namprd11.prod.outlook.com (2603:10b6:806:d3::27)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 17:45:15 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::55) by SA0PR11CA0022.outlook.office365.com
 (2603:10b6:806:d3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 17:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 17:45:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 11:45:13 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 2 Jan 2025 11:45:10 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v4 3/5] cdx: add DDRMC commands
Date: Thu, 2 Jan 2025 23:14:32 +0530
Message-ID: <20250102174434.17677-4-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 710ff7aa-3dcb-45fc-8030-08dd2b5536f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xTT1KufDVfQXw8YvAfh7j7Q58zMydwd1H5UCdNqWNG72Teg4BeVFcpToktUY?=
 =?us-ascii?Q?ttcExJEQaxbWbxBJtgigW1NiX58KWCjq7znnwVzs4K4kFX+MAZTT1QuKPKmg?=
 =?us-ascii?Q?kys07aE5LEhpUbgov+xkcFgAodX3+09MnrsTvDnXS2xrUC2Wx++3KsHdP94q?=
 =?us-ascii?Q?OmQQWya4/6cmxL/bebEqTfuJE9c1T1IDRKODPBdSQoRW31ptqXkfZ3wN2ezg?=
 =?us-ascii?Q?pBYQ7Sk7qZMh0qTYlRE0cCKG7XWTtTR8xrPEpbThzDygjBRnm3XnghaTVl79?=
 =?us-ascii?Q?FGxAd2cH3XYmWRhf4PTHY2P6pJA4j+c4xtskJ6NoXaSIJk+R/Q7Lz6+scA2p?=
 =?us-ascii?Q?1VlFmnnx/uAGT+UW7TXoxLlb74ZOn8WOTSJIAgmKQMxr5uMU3BJH3825TDds?=
 =?us-ascii?Q?NGRVJROg2088hpqpPQVOVcqgH4p+1DS+PSWEjlHc4nHgxKT1ENCfnW2cynYq?=
 =?us-ascii?Q?AK6AnPeqXickz2cO/J30pB4JeOPjoNlBfQCXOiwejHelghLCllCHMyadL5hW?=
 =?us-ascii?Q?vSnfXlXKYe0mz+UBjTl1aXk3XIZkTy2uNASnYcaGLttYyIYsElvL9T+aD6Q4?=
 =?us-ascii?Q?NiEoc6HmUbRVTweR/jc/FfySFciyBNoVzU27uXHEa6zU4bpJZokmIAzDwlMz?=
 =?us-ascii?Q?s2G3Bznq1YUbgi6Z+TtELyRwfcR+00aiCmQVxoNgnCCCyxBRWwRNWn72GmU9?=
 =?us-ascii?Q?hRDPwJ61P4PvIfsERHWFBiWzpcYqA/x8YtJXcaXUp4JJk8lPJcnTiHf0pw1p?=
 =?us-ascii?Q?cNo4ORz7ddq0ti8yf3aGJKHZ1+/sX5wR4beQyoyiTygwP9IbW+r4W8XcyVfJ?=
 =?us-ascii?Q?U6BohAQtDcNDJ3V8114k/EYc3xEmjJmOqGjUJM/8OeqqRdF1zmUChj6hkuWe?=
 =?us-ascii?Q?ByAsphGZ1WwEXZmQ3F5rAnYNYr/DpaNlhbWlUpSiE7Emkq0jML6XtBiQLA5n?=
 =?us-ascii?Q?pca3Z5eYcuQkMq0AG3qBGnFgZwVe5jPxtW9qTXzP7atMh+eoQGEoynS8uiIX?=
 =?us-ascii?Q?Jmkpl0HjHwVjqWOysVlu2n5bWq7EVyPx9BrFEaEbIAgM3JPJUfB30pKx4/SB?=
 =?us-ascii?Q?hW6BUfuj3KqMZpTHsaltE918nJrxBULPOTa3AxqYEJcfPkH6IPsVB8vfScr2?=
 =?us-ascii?Q?L2UVnr8EcNpL0RqKgxTrUJblgHHxjBvbueilJ0O8JAtRoxKauyvR064GR7E/?=
 =?us-ascii?Q?98i7as6lgrN5f7b/CXgm9DVy/8iIDbCuaD8wYmeT0LNdMgyfBHh6wmRQp9w9?=
 =?us-ascii?Q?f3q868WkpTxwha6ZxtyWMlr4EedWSIrX4gg0WrTp5SGvSAS9cP07mp/YQXb2?=
 =?us-ascii?Q?C2YUrnyyKDAx8/B4/y74fFbkoNo4uo8H+Qqx8uz4V9y7AtFMcqqGQqb0//7i?=
 =?us-ascii?Q?2X/6wdxQWULUs+nS6DpY9YF6gRQHSZFgaGuGELS5CMzH6NuS3NmEk+NrXumE?=
 =?us-ascii?Q?0npR5pzXPaAwAVCDB1OMuwiV/r57uMQjbdtTRifWvPSOd7HZ98bjY6+m0m6q?=
 =?us-ascii?Q?zyYr5cyok4P1Jbc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 17:45:14.9552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 710ff7aa-3dcb-45fc-8030-08dd2b5536f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713

Add the commands for getting the DDRMC properties.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

(no changes since v1)

 drivers/cdx/controller/mc_cdx_pcol.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/cdx/controller/mc_cdx_pcol.h b/drivers/cdx/controller/mc_cdx_pcol.h
index 832a44af963e..174270e148f3 100644
--- a/drivers/cdx/controller/mc_cdx_pcol.h
+++ b/drivers/cdx/controller/mc_cdx_pcol.h
@@ -302,6 +302,12 @@
 #define MC_CMD_CDX_BUS_ENUM_DEVICES_OUT_DEVICE_COUNT_OFST	0
 #define MC_CMD_CDX_BUS_ENUM_DEVICES_OUT_DEVICE_COUNT_LEN	4
 
+/* Number of registers */
+#define MC_CMD_EDAC_GET_DDR_CONFIG_OUT_WORD_LENGTH_OFST		0
+#define MC_CMD_EDAC_GET_DDR_CONFIG_OUT_WORD_LENGTH_LEN		4
+/* Number of registers for the DDR controller */
+#define MC_CMD_EDAC_GET_DDR_CONFIG_OUT_REGISTER_VALUES_OFST	4
+#define MC_CMD_EDAC_GET_DDR_CONFIG_OUT_REGISTER_VALUES_LEN	4
 /***********************************/
 /*
  * MC_CMD_CDX_BUS_GET_DEVICE_CONFIG
@@ -587,6 +593,16 @@
 /* MC_CMD_CDX_DEVICE_CONTROL_SET_OUT msgresponse */
 #define MC_CMD_CDX_DEVICE_CONTROL_SET_OUT_LEN				0
 
+/***********************************/
+/* MC_CMD_EDAC_GET_DDR_CONFIG
+ * Provides detailed configuration for the DDR controller of the given index.
+ */
+#define MC_CMD_EDAC_GET_DDR_CONFIG 0x3
+
+/* MC_CMD_EDAC_GET_DDR_CONFIG_IN msgrequest */
+#define MC_CMD_EDAC_GET_DDR_CONFIG_IN_CONTROLLER_INDEX_OFST		0
+#define MC_CMD_EDAC_GET_DDR_CONFIG_IN_CONTROLLER_INDEX_LEN		4
+
 /***********************************/
 /*
  * MC_CMD_CDX_DEVICE_CONTROL_GET
-- 
2.17.1


