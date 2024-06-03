Return-Path: <linux-edac+bounces-1165-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDF88D816F
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 13:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003A11F25D58
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 11:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC1C84A58;
	Mon,  3 Jun 2024 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mSHNU9sP"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CFD84D09
	for <linux-edac@vger.kernel.org>; Mon,  3 Jun 2024 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414839; cv=fail; b=LnF7RbrLZM3o/kqTBMa0Tm7RsAjbRDO48uDNoBhcndQ97sjrW0EJrZN5obR1yiFpX8WsB7vYCKJwG2GtaIGW4APQAV6tGGekrrIW3CWgPprFCdjWSS4yrvkIQnnppste8o3BqqdJOM9YYui6JpQ480pG85TYTX4S+k5Yb9y5CCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414839; c=relaxed/simple;
	bh=KqsS1luTgSn7mvm/6bbTII4MAFVh3UTCfExtSYXJu0c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b4603jX1vBIo4maHtjTId9wWUwa3rcYH/Ow9u5XqDE5TrfXd1mz6TOBz3FS+2omgnT3ppupzkSof/q/Ud4ddMbuc1a1x//bvaxCneDGPvnJ6JuNrq2S4fZr/Jfe6EilvIY4AyPimRhKcqaCm1vM3HER4Wxv2XKGMowYYCFokvEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mSHNU9sP; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4v6KauL/Vxha6amRmrFXxVDUE4V5pb/5mXocfDbQ4MYTc8RPFJmctqwJ6CroQGjeWNqp07jHRDImPvv/9a7HFyDtvNX3VkOXBUKl993PLtlTssTH7C89TPFsAQ0G8iKiQD9GZfvlbNxlEF/AakeaW4aP3TvBJaMjnxrmVdflEU5L9xd2m060cNjfO58fRQ3Seumz+PYGdaLLXmuBt3N9xKuPVVieFGh4MJ43GW82k4a1QzR208OrxjDFMoHQm/7thV3o+fSwGbmrrNyBk5g8wkmjiJMg0fT6YL9gZtdSTKzjfLsYJbQHaLbyOEjfgZ2mXXPobuRrhYjAt22sIpeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPyT9ExWB8L4RSp5tuoZzLjsl4FHDtrWB+MUJ7Yexuc=;
 b=hk2fbY3nrRoiDeHfngJaHJIupUpcvXkNDxNWV+Bz7AvgQUN/+dG2hgpS90tbIgyz4Syw09cOg4p3MzYu9Hqskjz3VVSkP/p/mVHsfVtPXdEzHIeZtfum2IAQGxYizw8T7+h3UGsugyqwrRRQKjA1IFKbXhKAt4QI8JHpY0IYX+z0si8gyTU2Brw8aEczWR6PbKehiwCXgZqkX7vt1Ojhfpp/G0qmSb8jERkJxzDF2XuVuoheoNHVvKpqL652pLMnNNWeO/aA2k9cvCwB/SrZOxvUWVbipW3x1NyKRxNsU9my+fpQMQ/oL1J4EAmlkYHLLVT17hZdlTGAR5/lK7wl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPyT9ExWB8L4RSp5tuoZzLjsl4FHDtrWB+MUJ7Yexuc=;
 b=mSHNU9sPi/WcUJcQgU9HL0nra78N3MEQqTCmjpjnNUWcMI+2z1s/slNN9qa+AVpcCFUxGUto3dUmkYPdnt5GFFk6wGORTZWTQqxgAcy4iGiJJ8v5s0MPKuJ3/Ac/8DzAxq6g51BtcjWmXS1EYs9N6bIkB/b9W3+nM4IVhZvPx98=
Received: from PH7PR03CA0030.namprd03.prod.outlook.com (2603:10b6:510:339::35)
 by PH7PR12MB7186.namprd12.prod.outlook.com (2603:10b6:510:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 11:40:35 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::1c) by PH7PR03CA0030.outlook.office365.com
 (2603:10b6:510:339::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 11:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 11:40:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 06:40:34 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 06:40:32 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <rric@kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <mchehab@kernel.org>, <shubhrajyoti.datta@gmail.com>
Subject: [PATCH v2] EDAC/synopsys: Fix the injection of the errors
Date: Mon, 3 Jun 2024 17:10:26 +0530
Message-ID: <20240603114026.4927-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH7PR12MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 3918e765-3de4-4914-f8b1-08dc83c1fb69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dj5OwyfuASXxTK+gnUqF2uvqpDoD2ofqVLZAMKiiTWvDkaq7hnHi/bftxsA6?=
 =?us-ascii?Q?105U9Pjd6GLjpsgjAmRMJ+Rd8Q43s/l4Rg//sthAHGroisC/aFdf9XT2mUla?=
 =?us-ascii?Q?IUfqOYhyLMcDaAmeQbNoplUCvp1CPDOOisCb0HQB6CVCU/FvdMOfZyx83Onj?=
 =?us-ascii?Q?cj13tq1XZqIviDdImu0+7r1iOrb110uAf9WDbcH15q7XzyI26jUSFQsHFyP1?=
 =?us-ascii?Q?BUBoya9iIBN31ILj9Jx2od3YmjLRwsXJl9A2Klf0/+4rA59NM8L18cr5R3pA?=
 =?us-ascii?Q?FY350eSslL5tS2ZOJG5krKVP7DjqEUFsQjK3CdMoPp7UGTkGNNeyrXbYh9jF?=
 =?us-ascii?Q?j8Xm1BtUMYSzj37nCNaJndaZfejgRHKH1BwW+nUbReHYuSqo7VDpDJ+Pu7y9?=
 =?us-ascii?Q?wwSjaFKMkP9ym61djLWSieoNUETrVg949pvZUryu/x/PhUeA6Y3LLE921akf?=
 =?us-ascii?Q?qIcuSweWK+nxnc+UsoQNBQfyyo+Y1aoAbOmbJnVAPH3NtJPh5Mu1mmmMa7wr?=
 =?us-ascii?Q?oMoWyBWUwDqzBJ1VYSdUPPmoOHULJzseFCBKp2R1qOz3r3gil/3Id/tNQzhG?=
 =?us-ascii?Q?qrJqQxaDqbp4L8iNSlXUIOnmso74WsMBmvJrEQ7VFvMbgMD69OURUWOPfdzX?=
 =?us-ascii?Q?aI0lLhCt58Sa45zOC0zGhiAyJtT1uSiqpZUSZtbrS/rFGHVnPy1bAAi1yTK6?=
 =?us-ascii?Q?QpairsOilQIBqRNki5XLLh9ITkt3C64h6J8K0rRSpu3RnLWOKxp7C/+u0DKB?=
 =?us-ascii?Q?dj4SK7ctfOwv5cwL3sUQ2tTKpsupSsRzSZwFQnEEsqkS6+XbGf9UTjWWXOdJ?=
 =?us-ascii?Q?gcgLdOJtlKZUnH4mfl2k+flWlZnZZ5/Jmns+6EcLx4CXPy+zD9VvTxpVE/Yd?=
 =?us-ascii?Q?vE6u8zLJGMYPRL5Rb2uywYUTQfTjgcNblUJlAb6sTVSS7OK+P295FYhamemq?=
 =?us-ascii?Q?QKbYFsl6KwZuax4aFRFBmy3aUABu4N4UcsqOcdLN6skRFhlCoZ2AqwiNyiA8?=
 =?us-ascii?Q?Aw+0kRIZIKsttZosEjSEt6GvTFaevLHHvgZx+EIFij7SkfoO87WlFGeqz4IV?=
 =?us-ascii?Q?ARj57Zml9LQfnjtEe/s1cmOsSBbyXb/JbYpoa8z9ea1zihqjKLes8DifBSQO?=
 =?us-ascii?Q?KwvCaaz8+Gm58XK4r5fv3XZbgd+fWnmJ+iF0LzYsxiL3PkpOzH21nKp2nFoU?=
 =?us-ascii?Q?/NFqL3YzOlHpyezTin/j5JP58xZfedhigKDeq/IsZK4tSbXpU+7+RMsXedau?=
 =?us-ascii?Q?caokI9Sb89cCWOI+jjb8QwDp8rKoHZ/z3oMpwDKXMZtuTMA4Ai5Na3hV2F17?=
 =?us-ascii?Q?n+Tpn/5YYJ8cZY/FAScQW9DaDPHNR42m+FsU0xVgxcUcYDYFjiA+U3ot3I08?=
 =?us-ascii?Q?uXZAX5UGWXxh4qN0ZKk63g2n++NL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 11:40:34.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3918e765-3de4-4914-f8b1-08dc83c1fb69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7186

The Zynq UltraScale+ MPSoC DDR has a disjoint memory from 2GB to 32GB.
However the DDR host interface has a contiguous memory. So while
injecting the errors the address has to remove the hole.
Introduce get_mem_info function pointer and set it for zu+ platform
to return host interface address.

Fixes: 1a81361f75d8 ("EDAC, synopsys: Add Error Injection support for ZynqMP DDR controller")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v2:
get_mem_info under debug flag

 drivers/edac/synopsys_edac.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index ea7a9a342dd3..4dd821de295a 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
+#include <linux/sizes.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 
@@ -337,6 +338,7 @@ struct synps_edac_priv {
  * @get_mtype:		Get mtype.
  * @get_dtype:		Get dtype.
  * @get_ecc_state:	Get ECC state.
+ * @get_mem_info:	Get EDAC memory info
  * @quirks:		To differentiate IPs.
  */
 struct synps_platform_data {
@@ -344,6 +346,9 @@ struct synps_platform_data {
 	enum mem_type (*get_mtype)(const void __iomem *base);
 	enum dev_type (*get_dtype)(const void __iomem *base);
 	bool (*get_ecc_state)(void __iomem *base);
+#ifdef CONFIG_EDAC_DEBUG
+	ulong (*get_mem_info)(struct synps_edac_priv *priv);
+#endif
 	int quirks;
 };
 
@@ -402,6 +407,26 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
 	return 0;
 }
 
+#ifdef CONFIG_EDAC_DEBUG
+/**
+ * zynqmp_get_mem_info - Get the current memory info.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Return: host interface address.
+ */
+static ulong zynqmp_get_mem_info(struct synps_edac_priv *priv)
+{
+	ulong hif_addr = 0;
+	ulong linear_addr;
+
+	linear_addr = priv->poison_addr;
+	if (linear_addr >= SZ_32G)
+		linear_addr = linear_addr - SZ_32G + SZ_2G;
+	hif_addr = linear_addr >> 3;
+	return hif_addr;
+}
+#endif
+
 /**
  * zynqmp_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
@@ -922,6 +947,9 @@ static const struct synps_platform_data zynqmp_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
+#ifdef CONFIG_EDAC_DEBUG
+	.get_mem_info	= zynqmp_get_mem_info,
+#endif
 	.quirks         = (DDR_ECC_INTR_SUPPORT
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
@@ -975,10 +1003,16 @@ MODULE_DEVICE_TABLE(of, synps_edac_match);
 static void ddr_poison_setup(struct synps_edac_priv *priv)
 {
 	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
+	const struct synps_platform_data *p_data;
 	int index;
 	ulong hif_addr = 0;
 
-	hif_addr = priv->poison_addr >> 3;
+	p_data = priv->p_data;
+
+	if (p_data->get_mem_info)
+		hif_addr = p_data->get_mem_info(priv);
+	else
+		hif_addr = priv->poison_addr >> 3;
 
 	for (index = 0; index < DDR_MAX_ROW_SHIFT; index++) {
 		if (priv->row_shift[index])
-- 
2.17.1


