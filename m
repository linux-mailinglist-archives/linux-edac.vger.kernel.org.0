Return-Path: <linux-edac+bounces-2760-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A1D9FED47
	for <lists+linux-edac@lfdr.de>; Tue, 31 Dec 2024 07:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2741883014
	for <lists+linux-edac@lfdr.de>; Tue, 31 Dec 2024 06:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF741189915;
	Tue, 31 Dec 2024 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eH2P+maD"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A51891A8;
	Tue, 31 Dec 2024 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735626914; cv=fail; b=rtwecfw9qzf0y/4qphJnbLByYDTDPXBw0eZn7cTOOiAYAJKHWV4ZXtActnPo911VS47D5fahNYzG/9CYdzQTvqp4Pq8N04Wftz4guev+ggARY4haaT6YZYAGDWtHsOLSCTAN8HN+XcpKbKUc3DQ9y3lOEFdBxP/W4JdhPy84JWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735626914; c=relaxed/simple;
	bh=yvdg//1e8752OL0niSJ/phg7+tUKnrSuQPNjsgpXZsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYCFmLm10fpTFemJXzIjFkIAmO79AoIe5EXGds+2LbDbpwXte9m0NxK5LOP6xeoy4aiaeELEQgKicIlsSIIyGb+HNikYNiMHgDPOVh3q0hw4dv1RlZnR5zGq1sU8kKaqXVmrXnjBswCA/l4zWvs9UPKxMgduR9WgW4EBfM5MP2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eH2P+maD; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uV9wlbOiUjNSKJc7SNAc59q/WtYMJXt9WmBQGyPdcXmHzuP+FJJO4A5+JOw6OZWfTtIaHQD2Lkwx4lBW7w2C2NtP2Ch19BI4jM9gXQPo1oydqtPi5xajaaA/938CN4u76vdOmTp2VpQOzTHLkL5M0GlnhaWbDDfcbyo7Cm8YPRLMQjT0DezYYl2Kg3sqJB/z5XY2g5kmCY+Lh8NJj6/Nrhl+VM34pCalKhg6hmEzOadyyCAVwzorwR/O3QCFOiHzRYnU+4ourp33mo8lx7kqr2vyoZ3ahczFOs3sD++PGd2636Mms7MRB1RFAc85nwt8+OPnwFNnvU6GyUhH083s9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2a08Q2bhaNDRUjwj1vU8qKt9PKCYPk5vvRmYMYUD7A=;
 b=nKfQktg0BDC6grLqXhB0+/HqzD4WTk/SHDKyX2zvHiCjfEx+Fm490uhIKpskZRJxnmXHkH4LhfdqlAHOYdkv46WtJYzaEeOUzCjpJXIoveoM9RDlk1q3yPu72KwNxOzOGFvxWb5NtT38yOk4oXvoQ4SAqKp1lmGhlAwSKshBCgOlbD2BZBO2zMKcqy5pj1b9lwQRnYg7fmt5zgtKBVtEk2YfclVEsclE+IZKmhQd0OK8YIkoDgUOevZaq41bRUqUaI7IytX/u4imz9QLqghRNZfy5vQE/Sg9QRO/It4D/h1gp0+k9HIVgT39dGi/6YuWzKIbm3CYs0JlZ7eTc8TgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2a08Q2bhaNDRUjwj1vU8qKt9PKCYPk5vvRmYMYUD7A=;
 b=eH2P+maDXRZjSFAp8WGz8T4TmagiqgoJ3+Ojw1mWg7ud5W0DrXAXUxE++H3hRsmMnYJCfmDGqHEBQpzgNZ0/KiDxq1ZQZseVs9+EDksFcLVPgoh4OeJ0gt5cFPvdJ0u2wabry14f4iMLwNjXT7kEuGTx6WI/mcXv6oz5M6jMMhQ=
Received: from CH2PR20CA0023.namprd20.prod.outlook.com (2603:10b6:610:58::33)
 by LV3PR12MB9438.namprd12.prod.outlook.com (2603:10b6:408:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.17; Tue, 31 Dec
 2024 06:35:05 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::cb) by CH2PR20CA0023.outlook.office365.com
 (2603:10b6:610:58::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.20 via Frontend Transport; Tue,
 31 Dec 2024 06:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Tue, 31 Dec 2024 06:35:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 31 Dec
 2024 00:35:04 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 31 Dec
 2024 00:35:03 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 31 Dec 2024 00:35:00 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v3 3/5] cdx: add DDRMC commands
Date: Tue, 31 Dec 2024 12:04:32 +0530
Message-ID: <20241231063434.26998-4-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241231063434.26998-1-shubhrajyoti.datta@amd.com>
References: <20241231063434.26998-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|LV3PR12MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2de1f1-7632-41e8-b659-08dd29654305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pwKbNDc3CWiLsmxG189hc+kmd+nrnOeixKCHI5c41NwjhoT+ijRBtQoRIvWt?=
 =?us-ascii?Q?Ibt72sXjYT0Un9Y/r+VQGmqeEvyYxiszoSxNQfvGMX/9PcWyXfVtmAWpR9GX?=
 =?us-ascii?Q?u4x/FnfBlwr6Uch0howYPdU9F5WEy4KTC0CJPoXyo0Kd5HY+3GaJWJk9BIwM?=
 =?us-ascii?Q?oxozGvyCfEvC1iF4tHOMxBAyI7nbv5b6fpGOLeLwBY18P3EJES36/p8tsEdw?=
 =?us-ascii?Q?AYewP6ChnW4KLmZzOoWN7N+66MP1pb6gL76a+mILgUNa4vXK9+yJiDkvtNlc?=
 =?us-ascii?Q?Zrog7mwNHICsVYpzU+Ho48N17APzvtNH+V8n90N7aLsNgHbZdnD/APzOf8FA?=
 =?us-ascii?Q?LD8O/XV3qdbsPK+7LoSiQQXxKS+59J/H6SEDeQrnKU5/DQ5iNY+0ST98XMl3?=
 =?us-ascii?Q?4um+pwIUQgmz4WIDT1CxVK5b6E2oBZ6iKU8sVJoDji0g/jPrsJ6xnBqQHB20?=
 =?us-ascii?Q?00mXdDCgvchV+ueubQMBvIlIJCOE9bGcBhSYtDwQOgegLYk5EGnHSe8yxXvT?=
 =?us-ascii?Q?vlCXWv7Ky7nTPCKy/3QU3EX8uj9qmIT7fOVFvraC9dns7Ck5weE93+p1gMRh?=
 =?us-ascii?Q?/uRYipG2/PiF0fuH6UDeHlDzPQ10xtDXBtbKnS2MjINU4y9/rIT3OldpXbCL?=
 =?us-ascii?Q?vyz2iA39B3PEdM3943cxaXWf8o5oG5RWLJR8YBE96zIjXrCxWzK2aKOFxCUO?=
 =?us-ascii?Q?g9T0awyeFdpXxl4G90SGtPHXySu99nhIcUwwj6ueXWVWjJogsMop4yFe7Yn4?=
 =?us-ascii?Q?XNJxv9nqqd2zcIQXqIqfUNbaAlIXcF2yjM92XEJGTFbDFsPchIS09PPwvVUJ?=
 =?us-ascii?Q?ixWXmN5yJ7SF3x50iq32TnRHmdYbV43ffE03eHStifb9/GVGmSR1KjGcHZF2?=
 =?us-ascii?Q?qLT9b9vTDM5p5VmU9dwruzssJpzQnSQ3mMdJSVA5mCSxya3cu4M9XAftxDIN?=
 =?us-ascii?Q?Fz/5QC4w6vrZVb0ZC3H6hcLuUPvWt5lGwVfya/WR91QrnxoMm6LzNwE5H5bX?=
 =?us-ascii?Q?i++NB3AkS/ZH5JWNefSJxyFq8aVohkNrW0o9cBKo8RJBO6AugKwrFPfX4OWi?=
 =?us-ascii?Q?PfP++VgVcfMYPEKqgq/Z9kYhefP0vGaNKAxHkMDTjYj9IqzAG7LOqDq3unrA?=
 =?us-ascii?Q?Rl9txWbEvyANCJZTTAbdr8wLHKFy34pc2Qf9meIVLpHAKvcqc67b5v9s7niV?=
 =?us-ascii?Q?Ibat98IBirX6KWL2/aRVT7K6SomGfzZQgfFbtk0wACKotURBEXQwQZJjO5Cv?=
 =?us-ascii?Q?2DN5lWJik1QlLnzPJwoT2bssmzOn+4/O1Jk2r7QdUmhSfXiKZLGRhCikjv8a?=
 =?us-ascii?Q?udCDwR38aweAirQWRGUBAYvddu/XUVftGsyg5G3kYIxjTs31VDrgRuMj2JEI?=
 =?us-ascii?Q?7xokdOCMYqE+FWGBQvTi07H2v0DLT4UaBGdTAV6sjm8sVo2wHhB4lNZt1/CH?=
 =?us-ascii?Q?xSJNI7ZQUu9mCRgm31n7gCsf/Jdm7Jt91sWOwFgvMyu4rSCxJUKXmDIcCfqw?=
 =?us-ascii?Q?SucnIkhfOWtjDIY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2024 06:35:04.8580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2de1f1-7632-41e8-b659-08dd29654305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9438

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


