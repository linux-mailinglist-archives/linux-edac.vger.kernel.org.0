Return-Path: <linux-edac+bounces-4135-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B514DAD7FC9
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jun 2025 02:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED57170F47
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jun 2025 00:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E26183CA6;
	Fri, 13 Jun 2025 00:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wffKGVBe"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A51E50E;
	Fri, 13 Jun 2025 00:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749775968; cv=fail; b=qi4HNgEPwHtEpN0KZg1c+2OcmBSwaENK6jpuk3xAWtTWY1njHwJQodF1RWcghpT9HRWmOWN21updlLHxBy7Zrgtiu14TpLt/z63MQyS4q3fsFsUZQ4xszlouTQ8SGS6sBBBOK/9ERc8w1Yq8NKKDN7xC4tWJYVBhFyT1lp2HoUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749775968; c=relaxed/simple;
	bh=HpuDl1SEmGIlYdhZpbPMA2Q4gDHwurufPNACPSZtt30=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FGLy6JyKdJbkEz0zyvlz7W1cDn+0lPtqhSN3r+E8ryxkp0sKUP8C7hcfMew7Bt7B/+6+7kJZY5tpJL0M5Jj8IRttWG7cza05QUnPRJos4wHS2EwgCNcan+4Pu29zIe7/tu7yXC5GC8Z31elrRI6f8I+853uWAvq2M+R+DTwKp7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wffKGVBe; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wN12/HjjKSYT2z/tJpQ364Ux8/lABRe9XmxXUzJXJrS1wsjN6h3QuIyWLS7LukDbCepxhVXzV1yniVbXgyV0LwRuTXTAyy4VqmU+xL/sL5s7GVvRPPfvUBBGREzCpqbvHvfrjoxdpxaQ6nk4cTazZqLvZmRaFpIJCvBEUx4oRIenFd6Z+puLK9BCNNlcrn32YGHX4jlBlGDVbw4JsO9/GxqREkBs4qHo8yCKHw1ooWIwpGNMFtN0VdD0rmumGddDi9hCSTK2fe16shEFdbzwGHv0CSaIkl7iGcais4cqcZTHOiLIjB42h5PA79RHRvEdyk2QqfzsIfPMR/RoGHU9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iynutVJuAqCvLIk2pXOitkNAY2g0ZBEcvhtmIVeU6dk=;
 b=U81mvPsfZSj7J4vn8IOyxS+39nCjPgxrZc/T1lbcC5N2Q8TeGiZibCAY4rH6WgY5BdHINQ6DuX2vkdfvcIAVWOwVpS9goUbMgLEDWhDg7eogWpdJ4XO4r2YEyMtFOCCflJ0gTIKT7SNgav175nVADv8bJx8hbhM+b7DrsmeJyYFb2EezKykZjQzyTh/kUveoUhAQWDKuSTsfNJCszCR85GoNTYPVSMAbYj9teoBtgpjhcSHN1L1ZCEzbQ1xpDKeXBiGKBs5Ww6psMybKSTmnFkkGlIRPYoF4gAxLh/bOTLVnY0G5V5es2HfvkDTQsrQM+FmuBPAgY2iJF2Jux7wVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iynutVJuAqCvLIk2pXOitkNAY2g0ZBEcvhtmIVeU6dk=;
 b=wffKGVBepSibJDJIRGsj2AteYhf9QWsx523395WS7NTUwJSh+LsYuvKwnuwxyTlxiGJNwjTysxQnV+juYkztekXoxnqYQa1+/W1FfsRkFzOjl/CP8T09FN9IoVNiOaUyYn67VKiBrwnQ6EQWvQ0zRaImoH8rThK6D1LoQMi2ulc=
Received: from BN9PR03CA0763.namprd03.prod.outlook.com (2603:10b6:408:13a::18)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 00:52:41 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::d4) by BN9PR03CA0763.outlook.office365.com
 (2603:10b6:408:13a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Fri,
 13 Jun 2025 00:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.0 via Frontend Transport; Fri, 13 Jun 2025 00:52:41 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Jun 2025 19:52:39 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <yazen.ghannam@amd.com>,
	<mario.limonciello@amd.com>, <avadhut.naik@amd.com>, reox
	<mailinglist@reox.at>
Subject: [PATCH] EDAC/amd64: Correct number of UMCs for Family 19h Models 70h-7fh
Date: Fri, 13 Jun 2025 00:51:35 +0000
Message-ID: <20250613005233.2330627-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bfda78-d558-4e63-b8ff-08ddaa1499de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A+RZg1NnM1k/qZffB63NIO0wBd945nepTq62USLC/Otv1/GcIGgKb958XWSY?=
 =?us-ascii?Q?Lk49sr9gSJ0HSWVRGZwMsU28yWQ2a0MTWC2UVk+tm56aykJ5KkF6BX54n33e?=
 =?us-ascii?Q?wEEIIrgU2b4RKCKJzBrr6xyZXlx839UaXafnQJK8+uGF7MsDXDQbtEoRhK+w?=
 =?us-ascii?Q?u0zU6Ic0Y7PAG41vk9aCZ8B/mfeHzlwuaf60eYOWMcY3tOxz4MdYXDX4DhqF?=
 =?us-ascii?Q?qpDTD/klFX3E21r8UE8te2d2axkt6XBTebn54dBg9h0HsCwOpVCv1JjoryUK?=
 =?us-ascii?Q?5aXBYbyzalhl4/d3fLtY6Y9o2QIm4L5uTvDBOn43O9kWTNPnbjmcFJsWqakv?=
 =?us-ascii?Q?PtWY71Ge/t/jbm5wpbTzBEB8M7uDk1Wgz76HsxaSnCxiCh6dxpRps5+htijK?=
 =?us-ascii?Q?ILCxw5FI+EKLdrxdrd7xKwT1j3JT9dG77Ev/zJvzIh+1x2KGyvHNGsBNaudL?=
 =?us-ascii?Q?zwmXqJd1LGOSpZtFjO11Om2VCiOyi151Dtg9zpxP/BAEZoHZjtV7K4v3lH0q?=
 =?us-ascii?Q?2jt1Ku7jTJd4VsQh3TLNz3reh7pG5D0p7AxSthoFT4JlHKe4jpVJbPXiDo7b?=
 =?us-ascii?Q?qT7iGd0+bws67QgqWilbODUYSHYwzHRLTVZQBl6iUuMaDwuz8RxnX8Ll+x6P?=
 =?us-ascii?Q?/TTzUBVYSB4khId5eiV8hfDkrnYv5jZa5RcaRyKQI+QW0HQbLu4xNqINDoj8?=
 =?us-ascii?Q?Xobggjb/MwzJGoXateAJlF8yYD4oXD/bQlQWCKJYD9vo1QIzs9o9j0uHDWbU?=
 =?us-ascii?Q?USqjcqklwKFEQRI41re3bfRtDMhhWKiDeyNei1ARVqssgoU3KfXrVFK5ZIpD?=
 =?us-ascii?Q?lCX8wf7YbtnequyJp4iGFwR7xkrRK8ILcW2jpKm93b2ogqVVg9vz5/+R8N6U?=
 =?us-ascii?Q?PjaaFDoHgELdq0X73keIPw7eEvfNMByDjOIvU7SKIN3dDK3vSSz14etwkLaq?=
 =?us-ascii?Q?30H7SxgFNUv4Tc4AYzHB/xQng2ZIcoAMpjCtdnus5mLoLp5WOAOAE21e84Ai?=
 =?us-ascii?Q?sHWQcllItmadgDabYHAcVSIpB1PU2AUFlwhmFerfAUEYtxtRnUIci4mBYot+?=
 =?us-ascii?Q?NhFKAWeokGbfdJzW4cD4a2UsSFLp3U9wRbuB2ZPRjb9Fu/9QPAquULz3OvDC?=
 =?us-ascii?Q?aFP1Rm/Dfpp7wj43kxmIIGQVbjOxKHUK5ozGvFIkzScMQX8i+JR8900oKW2H?=
 =?us-ascii?Q?WmvCAQ5Ia0nwkkUN+GdvUkh0eWgi5Y+O9Ym/NdblIJVjleQAnQNjIQLo/hO7?=
 =?us-ascii?Q?7TmJyvacjSHRwQ0wcNSTqKAmx0iG6WEO91Ks6dmO0M2qfuZ+SyPYSk2FQwmW?=
 =?us-ascii?Q?XoPKc7RKTK915TL9/eZW3PvFOZuHE9R0FfAcWD8LrK9UbHqL24yxqEIHRq1U?=
 =?us-ascii?Q?mZDgu2e8WdzYLJk1hZJVoqNmF78uIVMzDaVHrzXfTaPvoV3WUjsqllarjGBF?=
 =?us-ascii?Q?EWPYk8cHu0/Fw4dKD1uxFnVSUdFZBmvHSsg/QpuwjMbGAog4v7/RUPrrLxil?=
 =?us-ascii?Q?Ncj5mBrK0HMk9Olc0UdWK9DelODFTdEUm6TU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 00:52:41.3635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bfda78-d558-4e63-b8ff-08ddaa1499de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114

AMD's Family 19h-based Models 70h-7fh support 4 UMCs per processor die.

The amd64_edac module, however, assumes only 2 UMCs are supported since
max_mcs variable for the models has not been explicitly set to 4. The
same results in incomplete or incorrect memory information being logged
to dmesg by the module during initialization in some instances.

Fixes: 6c79e42169fe ("EDAC/amd64: Add support for ECC on family 19h model 60h-7Fh")
Reported-by: reox <mailinglist@reox.at>
Closes: https://lore.kernel.org/all/27dc093f-ce27-4c71-9e81-786150a040b6@reox.at/
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Cc: stable@kernel.org
---
 drivers/edac/amd64_edac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 90f0eb7cc5b9..390f5756b66e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3879,6 +3879,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 			break;
 		case 0x70 ... 0x7f:
 			pvt->ctl_name			= "F19h_M70h";
+			pvt->max_mcs			= 4;
 			pvt->flags.zn_regs_v2		= 1;
 			break;
 		case 0x90 ... 0x9f:

base-commit: 855b5de2e562c07d6cda4deb08d09dc2e0e2b18d
-- 
2.43.0


