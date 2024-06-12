Return-Path: <linux-edac+bounces-1269-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C66D905C21
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 21:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DE91F21A7C
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 19:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D1384A32;
	Wed, 12 Jun 2024 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FdoI0Zd7"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0884A27;
	Wed, 12 Jun 2024 19:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221146; cv=fail; b=LU7TYqqOT5aQb8/GHyMeEyKtqDT+zNvv6o8rnvJo/7mQemG0Bcroxvc2XFfBFFMCNCbMOfMJr33mvKJWtAAU+hYE7EdJ9aJz9uQpBTxaU18vAY/gloBxiWZ9f43myd4ADczD7Ydj87LhrCWCyJnnJbQtUTX+ZLgeH60C1Gl2FmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221146; c=relaxed/simple;
	bh=LfELwTS+azaPQ7Z/yogft0JyFyV7t1SsQyPsFco4ehM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTMgygpQZE6hZT5uOPGOx7r8aV5AwGgW2CG3x9Q9jDCro4NBM+cxOjGvnE+YXwu5sQGTcoiN6TEylOExx80wA7atQbUuphYSyktV+UuTffFQaoxD3osGQRl2Sq6ekfodq/Dhfd9ZMvqenBgc3a/5HAoUGh/h20D95MqRN/gTlz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FdoI0Zd7; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiAi9JDkXp2K0OvRNA4rwkTZUc1uBBbhBhcFmQ+iC9cc3OpGgcfBjYEJhywKdNSzUsgPQrmAjornxue2hj0IwumnvQqv8fH1wUiJY8cytolXwM8sd0zGp5777hcr7SN3exfeWiTKSq627MqQvUpDrj+RLYKAYx5kV6JanRXcdln18N0Ca7NoqPXRJrpAHWIke44ZkeT5ExoEklwgW+hKduy6uJJqlZ+P/26f1h+/lBzm3wikYxb23944nKbeD29LQQvjX11QoZXkYQIL5kZUdUarpNfzkVBHvzyjnLaxcK8Dl/IOlPr0q/M5QKNuT+KVqmrLJC0mn08gjdkB3vjsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhJiUw4Zz1Bb35t8FdsPE2cE6YjzNEf8azo11oJzxa0=;
 b=Wz0I7SGl0QE8gwgmKs1DTnUWV6Mc433gjj6foqP4k8wuD1ozW9GhKn2QM8cAKoI3KR/N/AY9LGT8LTyAtd6l1XQchC6k4DOd9kCu41HtT0hCBPAgAWUV+07pNs05UFxqnJO8NU7S/o2iGxpmEeDeOIkeJdgmqrYW4wb1BOtFb6ZJcElAQ3jPoPVKRVvr+nuJ/NkkrjX+rkweU99pWTKdpFRVckySf0GBsxeGiFcpEvFZa1hvoEtDpidtfSzO2ifdj4/1d8YFpSU9rvlF8bhRLzKre2GyVZ9Tdg9ohEMJAUHGQ9ER0Dmdv30AaczuQ2N0JNbdh53834ML51tKz3YtsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhJiUw4Zz1Bb35t8FdsPE2cE6YjzNEf8azo11oJzxa0=;
 b=FdoI0Zd7ReScFtK7mKQAOaJEUoY5sl5Mo7MY6EwLhBRw3E+HkH03i5sc21syNaiagBIZKLNxKqq35nYN/wmGo03+C9Xhc8//tPv3oYTXScle/qJ/4oIYLcgyZ9Lt6d9nHvGeeCjNOVy/D/Ki/Qmzah7XiQ9FHdUcCyTNp3qGiK3KzS20z8U7s7Nu5bCr2084d7QBKsUc7FxrmNImFj0kcxvcWc01Trx3laZAJwYqZqaDn4eJPzkRwxOoXkjelNsm6n+Yp70qHBFtWOngqQyOGtfMdDjN/iEI8QUt/A2hb3OQsZE6iSKeRARojL6tU7YwUpUaHrkjOOmFTxiRG/8SXg==
Received: from BLAPR03CA0178.namprd03.prod.outlook.com (2603:10b6:208:32f::32)
 by PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 19:38:59 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::c4) by BLAPR03CA0178.outlook.office365.com
 (2603:10b6:208:32f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Wed, 12 Jun 2024 19:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 19:38:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 12:38:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 12:38:41 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 12 Jun
 2024 12:38:40 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
CC: <shravankr@nvidia.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH v1 2/2] EDAC/bluefield: fix prefix for GET_DIMM_INFO defines
Date: Wed, 12 Jun 2024 15:38:31 -0400
Message-ID: <20240612193831.25913-3-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20240612193831.25913-1-davthompson@nvidia.com>
References: <20240612193831.25913-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|PH7PR12MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf91790-246e-4dee-2025-08dc8b174e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SR8vWtvtctlAUKmCmAvEsEAutv7VjclzMctavF50BcpzOzo1Od6GAsDw9WIM?=
 =?us-ascii?Q?vhHUwYIWAcVIA176LU9+xAtgmx+MEo9PFOa/zp6xYyiKuKaPSTIE4XxShSRa?=
 =?us-ascii?Q?B/tI/BbVCSQ5PieBIjZAlbRrtZDN9OGAaSJspCKK9j0Cr9vtpwfXkhIIeFFK?=
 =?us-ascii?Q?UVoLLlxE5X0NcSUCi3mSPJQy7GgKGChFgtzLI6eRTCe1G5xRd75vEjlxYQcq?=
 =?us-ascii?Q?BkGM8b1H5vu6loWRBtcA9ApB2n0xNT/dmsh1W2wcDljLjh2PMhT29c4MN43D?=
 =?us-ascii?Q?fJajvLrlp++6TgFBjCVYII5JcZMMmEuwcO1wbU4GCRd89s6OaUF75EemFiP4?=
 =?us-ascii?Q?AUhuiMtgDARE8+VaF8ihR3E1oytPLCV5WqrUujyQayRZb7t/DKxaoGtJ5gWT?=
 =?us-ascii?Q?dsl1bEw6o454E92J2phaYcrsug9WPUxGVgJGklWds2L+ygy6bA4pm/LTbnbL?=
 =?us-ascii?Q?/8dKOQuJYTaLDigNhguDXVFh9o5L9s+xe0g6Eo5oJ4IiNDMjWq/UtroDoG2C?=
 =?us-ascii?Q?WbWIReRLJi160pUODg05m3fAac1t2XoufzxrSYd1O7Kvwv4Kdcq2i2METMcA?=
 =?us-ascii?Q?cwdhuAk6EaeH6CMj+zpx2qRM+du3ktgxaFOKUGRGERAVlVyCkcVBeQgS/u1D?=
 =?us-ascii?Q?oOrlPJUK46jbFpm7CNDtP0mO1RUFn98YSnePGs5rJ8MAsAzGZPWmOVxVTFgS?=
 =?us-ascii?Q?PK4jeXt2tHmGU/t6QjKvv4vjq2TO9/dhLezW74VMqPWycYIVFE3PjobZikhz?=
 =?us-ascii?Q?2uiNE4GjCTaYoeWvGtEELYiSFi9ykWgaEdeLEO75c0yEowZnzLgYbUN65L0V?=
 =?us-ascii?Q?70bQqpBWUk81cONCuLtZKm5ud8o5HrMkgLumDEL++rPJrBnvnkIHROz/T2yf?=
 =?us-ascii?Q?DBYWlElX2KqMhWjMdDAn3sTXTp/XqE+t/SvaXjG1BiyQekGjdM/2c1boAh/7?=
 =?us-ascii?Q?KL0nt/9+pX828Wb3IycwD+8qpgemkmfwAOL1n+Xnls3YBw/qj2COR109siBz?=
 =?us-ascii?Q?3YWiXChdC74WD+2ZYWyOvDPab3x/Ji5yWFOQHdEoBAQaykXX+3/BHwD0ZuEv?=
 =?us-ascii?Q?q5yRtv5vO95xiMFx0ePN6z6siWMDsksUCYczsgJbXdSpNCWz2s/X5Wi43MBO?=
 =?us-ascii?Q?UI7VTMas9BgQmBgwrxiiFNmQ1B1FR9bcEuxwXmwr6la7kbsqhdkMNiWiaGWC?=
 =?us-ascii?Q?vYhVWZjAudhpLb4bIyGWfPYl9G9HiQfFbSm2iYIdqHQ+IiVtkHf2rMN6J2fG?=
 =?us-ascii?Q?RiQt5LZVLSoZKNvwgCcdxtBymLu6rWRQtqiPmzxGj5tsRPRVlTO5y4lza60O?=
 =?us-ascii?Q?D+8gl7DYGNWe5+3bDWGL6nnF6gBP/eulPlhpIRN4rjUfE6SvuJeKa8/D4B2z?=
 =?us-ascii?Q?6x+1IrvLtviHtfQWWihD2AZ5T2kfy41vsH3ydJxwE1w0CYBm6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 19:38:58.7335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf91790-246e-4dee-2025-08dc8b174e07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883

This patch updates the prefix used in the "get DIMM info"
definitions to align with other #defines used by driver.

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
 drivers/edac/bluefield_edac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index 1f6f39a7dbf3..8f1cc029606f 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -48,12 +48,12 @@
 #define MLXBF_EDAC_ERROR_GRAIN		8
 
 /*
- * Request MLNX_SIP_GET_DIMM_INFO
+ * Request MLXBF_SIP_GET_DIMM_INFO
  *
  * Retrieve information about DIMM on a certain slot.
  *
  * Call register usage:
- * a0: MLNX_SIP_GET_DIMM_INFO
+ * a0: MLXBF_SIP_GET_DIMM_INFO
  * a1: (Memory controller index) << 16 | (Dimm index in memory controller)
  * a2-7: not used.
  *
@@ -61,7 +61,7 @@
  * a0: MLXBF_DIMM_INFO defined below describing the DIMM.
  * a1-3: not used.
  */
-#define MLNX_SIP_GET_DIMM_INFO		0x82000008
+#define MLXBF_SIP_GET_DIMM_INFO		0x82000008
 
 /* Format for the SMC response about the memory information */
 #define MLXBF_DIMM_INFO__SIZE_GB GENMASK_ULL(15, 0)
@@ -189,7 +189,7 @@ static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
 		dimm = mci->dimms[i];
 
 		smc_arg = mem_ctrl_idx << 16 | i;
-		smc_info = smc_call1(MLNX_SIP_GET_DIMM_INFO, smc_arg);
+		smc_info = smc_call1(MLXBF_SIP_GET_DIMM_INFO, smc_arg);
 
 		if (!FIELD_GET(MLXBF_DIMM_INFO__SIZE_GB, smc_info)) {
 			dimm->mtype = MEM_EMPTY;
-- 
2.30.1


