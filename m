Return-Path: <linux-edac+bounces-1004-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FE28BD1B7
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 17:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179FD1C21D85
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2024 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A171553A1;
	Mon,  6 May 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ENp7PUsp"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C348002A;
	Mon,  6 May 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010388; cv=fail; b=HwTbLWHgbDgicdjAGB4hKOVIXm++2M/3MjV+1SWom7GlwNWuTUcf56k34+Hvj8mbOC+q0N3LN6DddkUWhQ415BkttzkBAgwq+sxecAG68ya4nXxtWKMi7/1XwKHUkfaFYK4gJuAld6lHZ8ORvxL+xAJP9h+24rerEnNRykCOcJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010388; c=relaxed/simple;
	bh=mUJi1OBGETCns/05GOpYSavqY2U7KlMdz4AGzBvDCQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D/Xl68nKUVqkMF5r5602BL36Co2zqhufR53s+JD/LDWhUy44q/GIOIV31QjIXB7TkrpaLpFfRgqnLSPmBhuNAj5Aj2n2Ja8K73hNJoclLCKtwv451H/k8WDfZnlvKYBAWVhj62KE1G/8UmFS/AhAvQhNhF6Bz7SKwJJuVGgDX5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ENp7PUsp; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqnZDLyc95DkmSLxVOWe6Au3TjN9SKtuNuAUg7RBqdpIydZIw1vazYSxkWrIrilK3WBfKv9VYHZkU3AHah5P/FjALzOAjnfMiWqgHgwIQLLb/kSBh7Wdf3CqXvGmf7VgttwtJWq9KpBTxVCOYN9adp70jYhuEeyKOdDI1ywtCtcParj1tU6cUIvLDsAmksS3y/QrXDQfxMvlWPw93VB5nnAZlLnK9uHZRaQxKvq7N7ok5Ri1sqLJ63TKthNt+qcdPRzpdue3TTIt/aN0vspxbO1ZaJl5HyM5S7kUZwfbNNiPYc8tunMqU9WbEaTle7vqj/Q/jnIBloFG3ngjYAzu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3JkJKMh+qRRJKCXkDMKFYu6EnJwxDOoF/I/goB5mZw=;
 b=ocW0+epANfCZLs353KYqzwZJVVmEK+O2E/5jAPIOqUHQw5aa2pTtf30GQ8vGUanQ4+3VDJxosZSMDTM9u9DvCRxWh1nvHOC2Ss+PfF8YpcEpWVhObSzFiLE1a/2l7oODJ+hKOLrJ+u6EEjGtO4gnYPEsWPxBA9TLTQqJWtrw4ad1seFA/ipZIHfAl739IcdH3Nk2FehhFSU/pAUBN1A97Htv8qRXofOI9ZclQz/vbrj4N4MVy0aVXsNITlEEOftEuWydrxUn14B+5T/Si2OcsU3JCu1LAtTUndstJT7DK6phle017I9FgC4N0CcCC5ocgxgo3roaq6RD18uh0sDEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3JkJKMh+qRRJKCXkDMKFYu6EnJwxDOoF/I/goB5mZw=;
 b=ENp7PUspqyRm1xvXsz4txvoAhU0/1C36nT1La4MdQjdvJ7WKo2l9Qh/Vpv0nHwy0YKvI2zAr6XPx94FeY3XmY1gg8XOG20tf2PE/pBYaG4OOIufUv9843+sWOTrcodpD4vf7kft/FnUknLmws728v3vckUmhdWfySKPbAj/j08w=
Received: from SA0PR11CA0149.namprd11.prod.outlook.com (2603:10b6:806:131::34)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 15:46:20 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::a2) by SA0PR11CA0149.outlook.office365.com
 (2603:10b6:806:131::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 15:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 15:46:20 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 10:46:18 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v4 0/4] RAS: ATL: DF 4.5 NP2 Denormalization
Date: Mon, 6 May 2024 15:46:01 +0000
Message-ID: <20240506154605.71814-1-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6f1e2e-bd9c-47b9-0aae-08dc6de3acd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6I/IzZRCZPE5Bxd9EylwTPtxtAC7v0V4kdOuz8Wya64GvBJ+hco0soZnOHBL?=
 =?us-ascii?Q?+TK93cLJQB8k8tiJN8rsdQLog/mT5h99L9lNbfsbqVjzepiINQQbKVmQ6ERn?=
 =?us-ascii?Q?gkschjw5cqOhSytv90NT4dxUyJKSUV8lnFdBScSnYlTnhTbmQ5Il8jW1q6by?=
 =?us-ascii?Q?X3j38sBBgBTjUBI/9sTSq7xu5+fVposwqY2Tj/xMmbfxsbksiwIvvWZTCXvb?=
 =?us-ascii?Q?MRH3WOPLd9bi6dT8w8NDnmE103NE2VYDkaOQg3BzgpQJZICT+yotXtBYAr8i?=
 =?us-ascii?Q?eHIOYzuPsgdoOWaDHwE5Nt5XrBWs4IvtA2XIdv0Kbj5Ptw2fZUVSZ7Jx1PZr?=
 =?us-ascii?Q?ejGWA/3NLB+W/X38zbKKpJZjCcGOPbiAtdvUSKe5mvy2F1Fn3veP8qxKXQNY?=
 =?us-ascii?Q?al5FmK7p3tD7OXDtA/rz9xLed49wCH4kBkhDg2LA+F+vSfit+xUUSm3pbp/R?=
 =?us-ascii?Q?95Mh5Zma9C9hZPySCSXk4YTYOc9MQE3NWOAdpl8UI885cDZkfQeYw9NCFElv?=
 =?us-ascii?Q?n75kNFGqqCui9wOZ6adnDzqECTN6EbY2uHIhZtAPP5By7/1CYO6itOKQjw2A?=
 =?us-ascii?Q?Y096rkELYhCQhDuBTuoKgk6zOAb9jwREPozcYd1vyZgZVS83bWWEDdTedFqa?=
 =?us-ascii?Q?FWH+FugH9eBCgEZ2QkBH2taL0Zy/1akOmGKNvRI1MiUV0PzRLMbuYXkeHceg?=
 =?us-ascii?Q?gSWo66MYgyQzTD401ZdGvs7YhNUcRQt0ikgt+VWDRicfVHeYX1jK/czqiq8c?=
 =?us-ascii?Q?JLfnipTu1hBXwhlOgakePXXMYB4D/ktaxOMDo5Z+MqxRka1bKwah9HUa8nr8?=
 =?us-ascii?Q?5eEfQFrlOGCib8tGjniilhu3A05TgEleqn95Ggc3ZPW2muVOZCJBHSdxD6gv?=
 =?us-ascii?Q?pV1tCU0W/AasJVEjHxEHj558DpwIbnjDNuJMtVkWxAq/guM7vR8Nr/CR82J9?=
 =?us-ascii?Q?7BXmYtFzrJ666LiK7+0rF6GUEA8VPVTtDuXRY+E38mRoDWN5bbJmDRZUB0MJ?=
 =?us-ascii?Q?CTxj7KssqLiZe641ZcVjdpdFFdfFtr1CwJDZpXvXnWxGUsq6hpbidkvm41Yw?=
 =?us-ascii?Q?AedVSAVVfebI9MvpBTglJtPdjRlYS5fuqg24yw+ZLLA9LqsULB/ipHHs7wo5?=
 =?us-ascii?Q?DB3ZscrwmgRiY3xrfBnMic9VBrkgVPiVMgKbwRTczLn6vXi/DvfoksPmrIQY?=
 =?us-ascii?Q?cQOm2RtGGrQw43O5U2cHUg6wLyeBRy6airtebZGZ4GC1J5Qlk1sE40QN5P3R?=
 =?us-ascii?Q?hJ863TwD3YdY/WdlAR9ziqpNn5iVRoHoMyjb1Rr13WPgF3a87kVjom1Vc9LB?=
 =?us-ascii?Q?feaoMyLsTX9/r33VmQth4rn+4L9lY/y4ZEBilnH+AbbLYlMZNjmr0XblVgcm?=
 =?us-ascii?Q?wKwvZgbHoABRk9Ltig2/p5jzWgWn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 15:46:20.3593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6f1e2e-bd9c-47b9-0aae-08dc6de3acd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914

Implement non-power-of-two denormalization for Data Fabric 4.5 in the
AMD address translation library.

Tree:
git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
Base commit:
bd17b7c34fadef645becde1245b9394f69f31702
(origin/edac-amd-atl)

v2:
  - Fix compilation error.
  - Make remove_base_and_hole the inverse of add_base_and_hole.
  - Move all map validation checks to validate_address_map at the
    beginning of translation
v3:
  - Fix bug where the legacy hole was not getting removed properly.
  - Minor rework of functions for matching the normalized address and
    logical cs fabric id.
v4:
  - Merge common cases in map validation function.
  - Fix map validation for cases that don't have explicit checks.

John Allen (4):
  RAS/AMD/ATL: Read DRAM hole base early
  RAS/AMD/ATL: Expand helpers for adding and removing base and hole
  RAS/AMD/ATL: Validate address map when information is gathered
  RAS/AMD/ATL: Implement DF 4.5 NP2 denormalization

 drivers/ras/amd/atl/core.c        |  48 +--
 drivers/ras/amd/atl/dehash.c      |  43 ---
 drivers/ras/amd/atl/denormalize.c | 523 ++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/internal.h    |  45 +++
 drivers/ras/amd/atl/map.c         |  97 ++++++
 drivers/ras/amd/atl/system.c      |  21 ++
 6 files changed, 711 insertions(+), 66 deletions(-)

-- 
2.34.1


