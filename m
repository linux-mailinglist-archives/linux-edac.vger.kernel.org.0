Return-Path: <linux-edac+bounces-2163-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354BC9A6E02
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 17:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E79282CD2
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2024 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EEC126BFC;
	Mon, 21 Oct 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a+YNRUWG"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC280025;
	Mon, 21 Oct 2024 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524140; cv=fail; b=Je5K6sTV4BPjk7ojYMiKkP6LdSkvYU1gWZOaWVQ7A6F2iAGr+Lhx1YRz3e1ea2Kx93ivtEIJa5Xim9yPR/eqk8sDc8/JD12S6Fisu3Sx82ZcaAqlrTHIagXwxNmYT3oj5tuAe6lMF0+VG1226hp98Sj17i41vmuT6QAeMizSbWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524140; c=relaxed/simple;
	bh=tsI4cl9qmx6aAEpZ6CCuCu793xcEZ1MgujWyeDuOd1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jUgvM+TmT3aLCmTJDF30ETVxcGCmSfnlAG9TlOMS3DfZFQZV8GWNcioRpsQfZcF0qLHE1r5Lams+X001HnnXN0u1GOyqTyb46Kf7Ty1WgZUfc50pIvw+4ax3CTqQbi7J1/ifSPM6i82/R88upveIhIMgzgfST4CDEumotFgfKL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a+YNRUWG; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTl1t/uIfSbo66/A+WxprKpnuJcKHx7KDGMUfIwCjG3j+cDm+Au6IuLP75qcnCfa2IpxI4xWmVloZPzHkjp2yZi/h7auP/w4TCMgDL3rBUbVa9LuCJfUapvjSp8RD03qSOM8sOX7uhBayaEh8zvsAB3eka52Vcn6PBy726795fAg/+RX88dBOCTaLNsl+8ShB2hzdJW3ZDWAZ9dz9jMNWDyGBF+Wu4eQ+KCpks6Hz6RPQ8XJtuXsnXqCc2Qk8J+gZFOX//L7aXnCGn/0FxB4mzhGIW1r0q7lYsfokWei8/6As8DvCkITEOy0dGZAQZQvdcAmV0reKJOWiwTdJZ74Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXKm/m67ODqCkMzK2GtWLC/I+v2qYA/Nfpot+c2Mwxg=;
 b=l5+Xnx4YlXDvFvMw70Lx8lCekw9o2xvu8l/sZMPRbFGSns7OE+oo4TjJN+doFW1mLZ46tk3y/VJWopssX79agQQoCevoNPz6gTJpeF7HnDQhhF52mw844/IfcoHF0kDdj1dmj+kZ991zCNUeZvmS5tosybK/1M0SRaBM6kmDS2AIfK/HqyE4IyxLPTMAwtwOb2DKkoY+nXCoFBRnm9wCqvHI/6qgyT/nETik8qaLYjztqiYnd0sznS/kuNyr9G3BCjY+O7n8fPj35s0/zSHqWfY2E0pNqeJlXELywbdpZJILcWagNpILTM+ejoF5lPn3zRonspcKAieJEGl/Dh/m3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXKm/m67ODqCkMzK2GtWLC/I+v2qYA/Nfpot+c2Mwxg=;
 b=a+YNRUWGYmN0XgTcap6Ox9bNXIQHVgK2lNHEVNzPWqr6rMLXq6/CeN7EIgRfhoXu5e+p58dcCO17mCmm4cXWTsyqHIm3SgN7e7TVQ1Ay59nYTWafeWxHTkOemVmVAe7ZKc9DpcHHgpCfSgcco9jHsBRlTwQh695u6LnPKEvITYE=
Received: from MN2PR15CA0050.namprd15.prod.outlook.com (2603:10b6:208:237::19)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 15:22:11 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::69) by MN2PR15CA0050.outlook.office365.com
 (2603:10b6:208:237::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 15:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 15:22:10 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 10:22:09 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] RAS/AMD/ATL: Add debug prints for DF register reads
Date: Mon, 21 Oct 2024 15:21:58 +0000
Message-ID: <20241021152158.2525669-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: e12e6829-246f-4f06-6690-08dcf1e42204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XNhVNix+HH10kCsQKaU7aNrfTJwE6NYXtLCn2qBVIlEKSnzAH+U/V+QbjQ3z?=
 =?us-ascii?Q?KiRNz0tVw3EEy/w2uY0FrFVTE06+YB1nfZTQUwnFcMWLa5sbB+JeDIAd3Y9D?=
 =?us-ascii?Q?EhRuoOB3dVofN9r1qOXo2t6VCIZjB3BJ5eXCP9PUyYxtaODpVmLFgLUJwNAu?=
 =?us-ascii?Q?RQvBWqwBgvlDPWqEVyCjLaBEVPeDgmjHTkstLFYzN1GJIdN+q2u/v1Nh1v7w?=
 =?us-ascii?Q?plKHdRSTcV1F8Ya76Cc9zBOh8lp5brcqXkGN6tOEGR5Ktbwm3Y9N1C9yOsfC?=
 =?us-ascii?Q?El/HuR8VhJ/1ZJMceHB3lUO6B34TnylNA8dtayr+BJmQVK1DOMJW9ZchAElf?=
 =?us-ascii?Q?r1Ba68HVUCjowRWRq6nFFchJ74ZvgEqHGHp+Uf7lsRHLmUqYO8vDrB1X2Unb?=
 =?us-ascii?Q?CPjdGniwHJZIuzaDDrOAO5cXRE6TbSIxgzPtkPhhHFdLW4FWNQCSKu323fYz?=
 =?us-ascii?Q?/4cw5aLyGo0/qZ1CtgD2NZJ2WSO3SSztGvsOVqUHlLJFD9EgyA1QVhbZuHiC?=
 =?us-ascii?Q?HJ1lcTA2Lnvxdo9CGvxCOW2oS8hwRQOXCGG7M+2eNorqe4ltxp5kSp2ItJDc?=
 =?us-ascii?Q?CHTEoC5RG1yam1kpGlob9FOk9y21ihU+7prRQWUXKeUyPQRglrQK5+FdjFl3?=
 =?us-ascii?Q?Ap4tRkeqzVlHT+X0d2o25qTI6TdHVaz8N/ND5jmg0kATm0LYoawyV/V7QoJn?=
 =?us-ascii?Q?ARQWaLX2S8PHXrsJtP7KmwuKEkAF8t+tbAqzbbeFBJWmFcRJnb0e8Te3a9pC?=
 =?us-ascii?Q?YLnGSBQAIufQugv4DDx5SKEgLdRZCdU97DeSCuCzNYQqsUqsv/zz/xESD0J4?=
 =?us-ascii?Q?7n85eSdNulm/kREM7Rq++kyFePevQPFHKl4y1p+WQPKV5WvdDRTEmN5Lc2na?=
 =?us-ascii?Q?pMVJJBSdLh49xoZDmt/ALjK5FdBDcahqwAfv/TiJxaGmWDbVeFSJxCQO5m/0?=
 =?us-ascii?Q?hGhQ5hhO4S1+mlzAB9W6dTeiRYwCoVWdQvAOhTlK0r4n5cHj3z/zTvjY7E4t?=
 =?us-ascii?Q?htmAfqnZtb9HkKOSrrvhuNmIY9+b7zlfKKmsAo8kcxc2AmN85+/N7JzMvVaG?=
 =?us-ascii?Q?GmgsOD+tbzn5h9DE0TDXorhA+F/tSoeMhapSHQsUgDw8VCct6Rd3MyHFeXrS?=
 =?us-ascii?Q?o5/U3XWtj5NxdSp76eS+DU4gjYtcxaQvernV/qfGVCaQ5LPBwOLYFVVeqf/d?=
 =?us-ascii?Q?CuTZ493VDYEdjdaPvuWC0xMbm/861cHgyQdSQKIq8D8nQIdPjgqBWy1zcHRC?=
 =?us-ascii?Q?w+324friMYTyGjyloptKamFoNTpFHoHwPA6HT6Z0h84ieZrzOyE86zMEGa0q?=
 =?us-ascii?Q?4H05sOwElmXKcjrhlE1gdkWzu9JoJFvPH0Z7us6EIm+S0P3KWojIJQRiLU3G?=
 =?us-ascii?Q?YW0G2YkqWedei00zUOTcnSBz0UGicjcz3QooyqavnTBnTZ6CWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:22:10.4537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e12e6829-246f-4f06-6690-08dcf1e42204
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005

The ATL will fail early if the DF register access fails due to missing
PCI IDs in the amd_nb code. There aren't any clear indicators on why the
ATL will fail to load in this case.

Add a couple of debug print statements to highlight reasons for failure.

A common scenario is missing support for new hardware. If the ATL fails
to load on a system, and there is interest to support it, then dynamic
debugging can be enabled to help find the cause for failure. If there is
no interest in supporting ATL on a new system, then these failures will
be silent.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/amd/atl/access.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ras/amd/atl/access.c b/drivers/ras/amd/atl/access.c
index ee4661ed28ba..c2334f8f9add 100644
--- a/drivers/ras/amd/atl/access.c
+++ b/drivers/ras/amd/atl/access.c
@@ -70,12 +70,16 @@ static int __df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *l
 	u32 ficaa = 0;
 
 	node = get_accessible_node(node);
-	if (node >= amd_nb_num())
+	if (node >= amd_nb_num()) {
+		pr_debug("Node %u is out of bounds\n", node);
 		goto out;
+	}
 
 	F4 = node_to_amd_nb(node)->link;
-	if (!F4)
+	if (!F4) {
+		pr_debug("DF function 4 not found\n");
 		goto out;
+	}
 
 	/* Enable instance-specific access. */
 	if (instance_id != DF_BROADCAST) {
-- 
2.43.0


