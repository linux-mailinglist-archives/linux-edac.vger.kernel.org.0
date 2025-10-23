Return-Path: <linux-edac+bounces-5161-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D66BC00C42
	for <lists+linux-edac@lfdr.de>; Thu, 23 Oct 2025 13:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EB6E506200
	for <lists+linux-edac@lfdr.de>; Thu, 23 Oct 2025 11:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AEB30EF7E;
	Thu, 23 Oct 2025 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P4GbrPyh"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4809730C62E;
	Thu, 23 Oct 2025 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219170; cv=fail; b=SvmO4sz7hAhI2xFNcFE59M+NRpnP3pbvSdq9y4ko5zMhE6pRiLTtnLLDZ5olFBlX7YUFK3KhpPVFKxUmS6fnoi3povLeCXcAC3a3SBYY2Sw8NtvRSu3J4mQs67OemWlfFhRFclRprpQ0z101Zs6TVk5VyeM4MxlCdusAFWEFXZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219170; c=relaxed/simple;
	bh=ydUfj1tUKlv9LLYaR5j5RNSij8dMzuWReUyYtq7EUGQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pj7KwYEmKGX8Ary2sa2CYZ/L4733ycxOJtuSjcqwbti4JObJaZp+UZ3lFovstZQ9x5/0IukBHPcR3Iv5Je4p43JlVXgi9K8cDyFKs1sw8LLsI1vPuPoyTN6MDsLKIkJw4cK8RRRaJQX7A3BRvu0WoymLbtzwnEmPt70CQmdPXag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P4GbrPyh; arc=fail smtp.client-ip=40.93.194.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b15R985ne7+Ax9Xo03haNQF++HM9UncyEGCDNXUpLPUucrbw7DCQ+sWAJzUoVC+CdG8zW2xWMwpXhViT2CTc1q3Jz114n6LiQM2xDzWh+LGqwWLOcmS9g1Rc7bJINuyH04+V2u7fQVh98qGC7qxAaFmdl0miaAvZTECy3DoJKWie8vywHIu7GX5J7uNNPdlf1v9eiOLSIEEv61mRVyoie3fri3/IqiMJDu1XHsj4cmwOcgocZQ1y06I+qdb8s07p5I9UZwtu2y4M+BY/oZNpF7gc4YB3lSeZIQZyINFHSVOyyuZTqgr+ZFvCPPhYoXCGhkQeK2cExUi4px8eRnWdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHvLY2UdHrRhO6Hx85cMal7HJNoVbkmK05G/R+YTF5c=;
 b=M8b5UIVfsBi20BHxonZPmnQBbrPMCU4wmjoDTXxK+7R2iNQgk3u37ydlwcHjW8wdAKfHU9K771WBavCfxa+aXlWi+sbdnZ/KPyl29tNVBoXVAzbN2fRmKY2MrEl96vCoH1WEuYxgWUARWXgcvLb54pEigo2Naqivz407ojmEmgiIoq5JOQdAhkuUfioOROm0ST9yKvLqsfa9St3ww1EiN73kbAvn9K1JjA2AL4nV5CBW5IwaYNNuetdYaLvMI62FTQvZPO6ySlwSwRqIxn8l6W4jV9v/2/UWJLuaxzuqfMKIbi2URnJCRXTj5jtGlBCvyJFhxz6+iA97gEabEYsJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHvLY2UdHrRhO6Hx85cMal7HJNoVbkmK05G/R+YTF5c=;
 b=P4GbrPyh0Tao6UhwJ5tWNerjbCwVq0zTnAhg4FhnGmgKLadpMC2HkZRU1AaD3jgW/USnBD+5DR6/YKa+niEBcRb1oGDiAr5g5YfyshRqyiXPTbD6nnWT6+BsGB/5EPhPsdv5Cgn3s8Fe3OLP9ONeHfX/zY7kjiig4mkgX+fCP4w=
Received: from DM6PR07CA0067.namprd07.prod.outlook.com (2603:10b6:5:74::44) by
 DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Thu, 23 Oct 2025 11:32:43 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::9f) by DM6PR07CA0067.outlook.office365.com
 (2603:10b6:5:74::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 11:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 11:32:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 23 Oct
 2025 04:31:20 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Oct
 2025 06:31:11 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Oct 2025 04:31:09 -0700
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <shubhrajyoti.datta@gmail.com>, Borislav Petkov
	<bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH] EDAC/versalnet: Handle split messages for non-standard errors
Date: Thu, 23 Oct 2025 17:01:08 +0530
Message-ID: <20251023113108.3467132-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac55f74-68fc-4bad-9a5e-08de1227e206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m+/fXD+gyI5NdTO/NZcOs7Wf7rYCZIHw8Cc2P7/a8lgtMyHvF3TqnPP99uZf?=
 =?us-ascii?Q?S5oEKIiWJiC2N309qM/zLVG00QrebFHNNic9m6S2rYGpXDy+cxBCRqNanAy3?=
 =?us-ascii?Q?nSKNlk+ONeWSoRcn74/C1E4YAXJPJrI88/PGiLDgAY5PnS43Imd9srVX48OB?=
 =?us-ascii?Q?6fUkjW7ltk6qNo5PE+ZWYEoHtb5DF/SHmrrXW4gULuoIGyjggdm97+buYyBi?=
 =?us-ascii?Q?z5ph3AkKhye6rQg/7NYq1aLdJJzwA7Uqq8pkGaL1t/2fzy0TGI6+f8ZgAi/+?=
 =?us-ascii?Q?9qOCfejMSQXl9VBt3/KVNb0B4t83qGev3uOFrMifGvE3D9/KsJ7W3HmUUHPK?=
 =?us-ascii?Q?R9qFMYX6CdhLSu+X3Xsus05iOFSqQEtMKdkHDlWFjLDlJGs7HL/r/meGbvBD?=
 =?us-ascii?Q?1tfRDi5ZZKD9+FI/3zCv5ZL9sJDoS8DUy9WhxQC3oavk2iYtEE/cNlQxcpY4?=
 =?us-ascii?Q?diIDfD7SiSTOXWwpGyHUwhvCt9Cum+v1mevqNxng38AMfR41GrfNzLt0CsDF?=
 =?us-ascii?Q?D/X3evKQZISQwGzC3x9G4fUR9vf4tRVrjD3Sf39G29MPlv9tmsn4eX7ZZXxd?=
 =?us-ascii?Q?YmAiU3K+2K8RwgJUh2uelYBYpEh6diUKvj4VW80QsBk5sZM5K/a3VNukGDA3?=
 =?us-ascii?Q?WyMEJXOozasONYnNLTeqeAOaEz5TVu4jMmdZbZaTO/oWItl3hQ00gm0Tx641?=
 =?us-ascii?Q?kZyAvh4azhsYvfwqhxMg2sqipCUVch8XzZjNELVg7jwoxxoLfu3jSRf5TZzz?=
 =?us-ascii?Q?SD1IOWPcWebW1q3XGPUxOMGQuMRFuMYcx0QFc8owJ9NEcSzk56D59bqery9b?=
 =?us-ascii?Q?BI6DBwBNV+PwGWVtoS2KfZDqmlf34iUvkJjDbnCzcbw5umDsPe2cX8lUNQoT?=
 =?us-ascii?Q?XU6T2U/Wwnqb3iHmmRSupF9Rzz0K/OYaJ/x6R5fxmIjxoeutJU5X+70GgmPM?=
 =?us-ascii?Q?jeUqzU2ipr1RTRPniqn93dPBlZHYkm2eRcdE/sIsEferPb4kgjsiEmoIpIBH?=
 =?us-ascii?Q?p3+7ECk3LdWl3znrHIPSEdF9vTMADb8fazs6LRZl4uwwtC4wxto6BDH8uFa1?=
 =?us-ascii?Q?+gamaQOldnQ33FXOBvvNEEPJydeNWGHQtM8n1TKMZDzsedmnuo4YX4yap0Fz?=
 =?us-ascii?Q?kyl8Wl89Vu+vLpjmAo5qTyiJo4sjd8wX89xfWuUURgOZU8/LD9VHPXOpUyx6?=
 =?us-ascii?Q?D2zSYMfK/7gjWw69Pg2go7NkXec+6kIWV5Tos5fQPvCtZxk44e3rIlfhKuqI?=
 =?us-ascii?Q?gHj0TRRw/tGrnjdsQjs0rYSTOtAIsHIie8Ym32TqqAL9Z5EJwigSi0LjHz3B?=
 =?us-ascii?Q?BTnlRg2V+qnJ5Kui9pNY9iLkpdj29kgBeH23vl/1uLpHEBoxoehvETCp0V3K?=
 =?us-ascii?Q?lcwd2mjC6E5FLymrALWoHYBDp5zgnINHaprCUS21XDj6sYNvELEQutjZYMLx?=
 =?us-ascii?Q?BD+TPZi/w9IxFD25OBtaRCpWhgRQ+nHPq+HHSjfwc5yrCnBoPLfAc8+srzHO?=
 =?us-ascii?Q?jQYg/pplm1B3lZ8qww7u4dUE5HBWu2tFGR5BmKU+GTGMM9TOeFf1cBxmuwFj?=
 =?us-ascii?Q?NCFSiPCmWPdadAiuCpk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 11:32:43.7544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac55f74-68fc-4bad-9a5e-08de1227e206
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536

The current code assumes that only DDR errors have split messages.
Ensures proper logging of non-standard event errors
that may be split across multiple messages.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/edac/versalnet_edac.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index fc7e4c43b387..a055f54a389b 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -605,6 +605,12 @@ static int rpmsg_cb(struct rpmsg_device *rpdev, void *data,
 	length = result[MSG_ERR_LENGTH];
 	offset = result[MSG_ERR_OFFSET];
 
+	for (i = 0 ; i < length; i++) {
+		k = offset + i;
+		j = ERROR_DATA + i;
+		mc_priv->regs[k] = result[j];
+	}
+
 	if (result[TOTAL_ERR_LENGTH] > length) {
 		if (!mc_priv->part_len)
 			mc_priv->part_len = length;
@@ -615,11 +621,6 @@ static int rpmsg_cb(struct rpmsg_device *rpdev, void *data,
 		 * messages the offset indicates the offset from which the data is to
 		 * be taken
 		 */
-		for (i = 0 ; i < length; i++) {
-			k = offset + i;
-			j = ERROR_DATA + i;
-			mc_priv->regs[k] = result[j];
-		}
 		if (mc_priv->part_len < result[TOTAL_ERR_LENGTH])
 			return 0;
 		mc_priv->part_len = 0;
@@ -705,7 +706,7 @@ static int rpmsg_cb(struct rpmsg_device *rpdev, void *data,
 	/* Convert to bytes */
 	length = result[TOTAL_ERR_LENGTH] * 4;
 	log_non_standard_event(sec_type, &amd_versalnet_guid, mc_priv->message,
-			       sec_sev, (void *)&result[ERROR_DATA], length);
+			       sec_sev, (void *)&mc_priv->regs, length);
 
 	return 0;
 }
-- 
2.34.1


