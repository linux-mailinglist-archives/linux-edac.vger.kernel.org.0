Return-Path: <linux-edac+bounces-3365-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C163A67F10
	for <lists+linux-edac@lfdr.de>; Tue, 18 Mar 2025 22:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A473B180C
	for <lists+linux-edac@lfdr.de>; Tue, 18 Mar 2025 21:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8101D1F0988;
	Tue, 18 Mar 2025 21:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AvdmeqDQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA26191F7F;
	Tue, 18 Mar 2025 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334488; cv=fail; b=hoI6mMOyxmB6rF17jZkodpQOxjT11id1Jpo7qVrP1g2zh1d+gvm+5fAjekJHjE6JZD/P7I8faz0t/Q2Q1Uf9NVWpnATbETtnxfrn9nO3p6saSR4LhoXunM9ImHCv0NG8rQdVInCAUjQElJRmI7crNZZelDLqfwNCTKXvyYot5SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334488; c=relaxed/simple;
	bh=KrxRBX/Bplb+rqIaIb3uXm/95B9pf5+LLyOE5OxdAgY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NQiCx9I3zkFr92II50Ns/rUoiZAObdrGzapXE2fzrkcD93/Xxp42/G9ePwPAiqCfnh/h7+vPjs7M/BOflLKaBxfHqKulIwKQvNXT/89UueFsbN41VL+T5QB15FJ15frgbgDdkPZHcKp/9zTHYQKAkTlcRATSZW1h84He0J59EpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AvdmeqDQ; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgtQ9Fcgi1MjanHhYe2DJzOmd3+xtj2a89ejjJ4dXeyv4heob4PVlGBx49alC56w8bBF4BwLIP/SzuDfRa5QgsQNGXkcVaRdmzFoSs8nKanbytI1aUdICVNyl0/sQYKDYBOtboU52Ld6D1iarWhlfQnuMAydFhbDm9rTboTEtOeazg96SrW51JNXhQpeCDyoIUfservK+urk8Ga2Yv+GVb+uAwfxVnseuTVDwYliVYT1HHdpaCFWyn+9BGqGV3uNTLwCXKTN4FmwnAECjSmZG6JLwk6x51z8F+5YlEQ6cXB9EYBpDnxPwM7u0GGZMgKn4nTJP8d84mcNmImiU3q5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAGyRVnFLDSFfqfrvpIDAidcdsZU0rv8HopJGl2JLMU=;
 b=ecV+WZlvHwgjW34qAcGqkDKmthUsIMuJTEXeuUhH19TZOYJVziUmjuwEjPtnxRrS+gJvcO2gaquz+P//VfZcD5QuACKOZ3BPVNvvsnvEqPtpCaVCA2IXGJpsFzD39sCt13Ar5Ns5YdINErGBT+5eW9GqXmas2Mkh2qHI0Sp6ldzSUROrpitXcQLGMQcmGl6KJxuJMSicFfrog/bJySgakk3894YWUROIykKja9KvKDDNah3WLDLBNlXRu7DKVIFLh2YyADrFlJeD4QFHtOUU016hAPq+HY7Vp83kxXTAdocttoAw57rhLtSWni0ek9w/xo0ypcOJEkndCa7aeIN2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAGyRVnFLDSFfqfrvpIDAidcdsZU0rv8HopJGl2JLMU=;
 b=AvdmeqDQeT32a6b/s8Ipc3CecAOwc/zgqGpiFS4qHUdxWrT2JQieMcRZEaIRcPE6STVQN7zEm8vr39K+cBXN1D8qTWWatCoh2U3H2BBi7y/rDzUr8FmMPT/BKShspxotzBPTCj2ZQSjbuCKipXUNwgkYsZwiGApA+9MAOrEzLnWhUGAevvh+Df7dNebqWOlxBeogkBA7NTUJorg/cM4mEtHwQd3sT5HTIH3qw7C8XTMNRMPJWiki39nYekQiRAXCr+y0zFv3A5ZG3JM3j6wN4+IgxOc2YW2OEOgec56ztuOXq6455az2rya1Tos/MZL0+OUCW+y29phvWabdRx3H/g==
Received: from DM5PR07CA0111.namprd07.prod.outlook.com (2603:10b6:4:ae::40) by
 CH1PPF189669351.namprd12.prod.outlook.com (2603:10b6:61f:fc00::608) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 21:48:02 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::e5) by DM5PR07CA0111.outlook.office365.com
 (2603:10b6:4:ae::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 21:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 21:48:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 14:47:53 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 14:47:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 18
 Mar 2025 14:47:52 -0700
From: David Thompson <davthompson@nvidia.com>
To: <shravankr@nvidia.com>, <bp@alien8.de>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Thompson" <davthompson@nvidia.com>
Subject: [PATCH] EDAC/bluefield: dont use bluefield_edac_readl result on error
Date: Tue, 18 Mar 2025 17:47:47 -0400
Message-ID: <20250318214747.12271-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: 89daa669-7ec1-41c4-73f2-08dd66668ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a+oxHYS4XxN7lnOkuwugq3375vEJeI0mE5Tw2pFSUNQ7TveOWRzCbwvENnrM?=
 =?us-ascii?Q?Aep2cmnYr6l7yiG6ntqPc6CqiO8G6CJ8u5VCiw51oDMxc5Hl5BFQ58XwgOY1?=
 =?us-ascii?Q?g/Xn2Rv06fG/7TQtiw4zS/D0+48v2HqLvx1kRG6bgYLt6xZkiWwnjICUhEZY?=
 =?us-ascii?Q?+qoS+0g3Xgw1tCXKauBmRoSJZuSU+Jd29ajRbjr7xdBYKwrjNo4Op37J+NRd?=
 =?us-ascii?Q?vD3pJCfCQC4L9ItctMB7HyZb/afzMKhSSua3rIM3r4mgS0xNLzYcrvHWnTwZ?=
 =?us-ascii?Q?2jO9+mh2cgOUmdRkuQlg6OOpD+I8EMYz9KXtRpsPhi1nLP8abAY5KYQQKhC6?=
 =?us-ascii?Q?avT7NzJjs1t9/iPJsuzfezy+NlHsPrYrWi0h/YkIlPGecBezFljjB58Rdi65?=
 =?us-ascii?Q?QhH0nQK2rZ7/pj3pys563z0dByvvXBPXVei4Zt6DPZWo4wSzrsv+1OJPZjgZ?=
 =?us-ascii?Q?8fBTri0IsRhlhyeLR2SRIZDTv/wX2EI+0Y49B33kEeKCAER+sMUnq7OyPXpZ?=
 =?us-ascii?Q?11Wf/3RQt0K5ndN5LNi5I1aLy/iWzE3WE7jY4Y/SkXaP9LIyDslj1Q7rX+nt?=
 =?us-ascii?Q?vrorkjuz5LpmunOMx+cvw42AlBi8yXPoA4eOdvo806vS97j8dyzQdU7InwBc?=
 =?us-ascii?Q?0w0AGYEQFmqPxvDqLC3xHFEmsp0GkyhZ2o4r/iTn5QHGpsE/SbfMHBhLpvll?=
 =?us-ascii?Q?edbrLnxcbjqbGNeah9/bo4V+CUdsXV53Z+LFmeotJ2quptffG/clf+eYwWXD?=
 =?us-ascii?Q?X9fE+CffDmf0agSqA71DiFI1N4k6Ck+LmfEjIiYxuZO2Ufrdkl2OJ9As2yS4?=
 =?us-ascii?Q?/TefkuYnf5hbgSFX1JoilTJN8KwOy8ptOYpbjUDZkQqrqVKJNB5USY+cIua9?=
 =?us-ascii?Q?mmBAPby5atowSQgfi+gQhoh6Dz4daPX2FlRUUU3a7IdUPrz9Kmaq6PzV9Zhe?=
 =?us-ascii?Q?yNh3TUmDOZQbph3t7uS46OVoC5c+EEm9OQpncA66T7P6lr+JAxxYgvrNwh1k?=
 =?us-ascii?Q?oe455ISAKZ42LFzz4OKVboDcDTK3ABm0kDlgNA+e/hq5IrU3nG/n49eBxws7?=
 =?us-ascii?Q?WMcNCNIueiI0uAREK2qNnUbJtA7mgZTs7ObZiSpN6LimSizKQdIOBH3OQDUt?=
 =?us-ascii?Q?PIBXQhE4AACjBSQZVROZ2WA0D+O8gEFb08LHDoAFBhM8h2oxvMLl3Xl7hnxu?=
 =?us-ascii?Q?t+fJMBS+t5Dj61v47nre5XAOLZgTaM4446sly9yf/8aFUh6pvkwPOmaj0nKQ?=
 =?us-ascii?Q?c5SmBb/vtPgEmTOomI0WzYUpapzle1r+fctmJ8Xh7Vw/0Q3zEeI8esMj1n9W?=
 =?us-ascii?Q?5rBwcGFIfK0mSoeULlZ3b3HfiG9zIpSVn9jkCm3RJktToyDFtglgTdBaXT2Y?=
 =?us-ascii?Q?Way33jInEjP3YcuTGAKXfCUDffRYbNLi8qSmUG0w23Awej1lH7S9YpXeNoVb?=
 =?us-ascii?Q?VlncAVpoVxaZeJdCnOPKtmBpcOUXeuUurOqsCbMBqQRPrl/0WcitSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 21:48:02.2237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89daa669-7ec1-41c4-73f2-08dd66668ebd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351

The "bluefield_edac_readl()" routine returns an uninitialized result
during error paths. In those cases the calling routine should not use
the uninitialized result. The driver should simply log the error, and
then return early.

Fixes: e41967575474 ("EDAC/bluefield: Use Arm SMC for EMI access on BlueField-2")
Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
 drivers/edac/bluefield_edac.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index 4942a240c30f..ae3bb7afa103 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -199,8 +199,10 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 	 * error without the detailed information.
 	 */
 	err = bluefield_edac_readl(priv, MLXBF_SYNDROM, &dram_syndrom);
-	if (err)
+	if (err) {
 		dev_err(priv->dev, "DRAM syndrom read failed.\n");
+		return;
+	}
 
 	serr = FIELD_GET(MLXBF_SYNDROM__SERR, dram_syndrom);
 	derr = FIELD_GET(MLXBF_SYNDROM__DERR, dram_syndrom);
@@ -213,20 +215,26 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 	}
 
 	err = bluefield_edac_readl(priv, MLXBF_ADD_INFO, &dram_additional_info);
-	if (err)
+	if (err) {
 		dev_err(priv->dev, "DRAM additional info read failed.\n");
+		return;
+	}
 
 	err_prank = FIELD_GET(MLXBF_ADD_INFO__ERR_PRANK, dram_additional_info);
 
 	ecc_dimm = (err_prank >= 2 && priv->dimm_ranks[0] <= 2) ? 1 : 0;
 
 	err = bluefield_edac_readl(priv, MLXBF_ERR_ADDR_0, &edea0);
-	if (err)
+	if (err) {
 		dev_err(priv->dev, "Error addr 0 read failed.\n");
+		return;
+	}
 
 	err = bluefield_edac_readl(priv, MLXBF_ERR_ADDR_1, &edea1);
-	if (err)
+	if (err) {
 		dev_err(priv->dev, "Error addr 1 read failed.\n");
+		return;
+	}
 
 	ecc_dimm_addr = ((u64)edea1 << 32) | edea0;
 
@@ -250,8 +258,10 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 		return;
 
 	err = bluefield_edac_readl(priv, MLXBF_ECC_CNT, &ecc_count);
-	if (err)
+	if (err) {
 		dev_err(priv->dev, "ECC count read failed.\n");
+		return;
+	}
 
 	single_error_count = FIELD_GET(MLXBF_ECC_CNT__SERR_CNT, ecc_count);
 	double_error_count = FIELD_GET(MLXBF_ECC_CNT__DERR_CNT, ecc_count);
-- 
2.43.2


