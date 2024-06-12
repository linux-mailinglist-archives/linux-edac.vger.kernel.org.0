Return-Path: <linux-edac+bounces-1268-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C847905C1F
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 21:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615821C21084
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 19:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36906839F3;
	Wed, 12 Jun 2024 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RA/mWqnW"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F355E73;
	Wed, 12 Jun 2024 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221138; cv=fail; b=DAIO2lFSaaaR64pneiEPW1zp96/4E6a2b1xWuXoLQb8SBDr/AI0plkPghQQU+KJifbjAFPOhsR9S4CQxh5xXu/WDUotLGdldfDqH6iGa9X5EC0jmmAtDZZiA/W5InjPIz3IOiWIzcs5eRlobmKm8yqde5T1LohA9+bnTkzRA4Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221138; c=relaxed/simple;
	bh=kv60lP+KuYaamuUu9IbI380pggtd1l3tjVoiRQYwpBw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ngktXyLsI7WFMfBKRdBKFk7A8ybyDQkgcj9OiGdGJjMndfObBjCky3ifhjlE4JCyLkJZFf1SyjVO8tPMSL8wqu6i08qVEQjyxHHUSZY9dMSFx1jGKFOYFDZvGHMhe387zMnTtmDUZJKMYfQCMfl2GCoqFTGFyyctmBD6EHpQB50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RA/mWqnW; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR/2qfCuQ5y5K0ZxG7cMVcPGNpZ3dO3137WHsa9ncgtLQydpOkjZCBRaekASIgrPcRtz0OCpDJWlbg6AOFtOb4vgkP3CrSefTjJT+DBYDSRcrVbr5tCDB4gObU6DShj2hnrkRH+pdS97mjVYvKGYTOn+XrTtUm/bdecArocMSIZRo2SK50YYVkEIqOG7nRvT6If7rwnnANmSXTjuBWZGgja/F6+QKhJnCzYbHkKP3DRgEi48v1DduHAayPzGfCjO53AnC+Zd7XCWKB+CCDHdqvK/El1pUmVbaGXR68yPfI6L9cneQv1Foh3pnn0L3MSxcutBqHd3f6hzW9BtD0xxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wd/E7tNbRNmlCx2cWsuVnaycZt6TXmyKliBZzGWUIto=;
 b=ZUHrBafe25YhqXsM/27eibmbVSj9nEDDTLuMcl97VEGVIDj9/0VMIE1Ai/c+8F2v/v1GgfVUg/tSvo/9VYSejSpw4MY8zNPAy9EiD1O9KrSR/MAi3Aq60L0/a3HIg7mfhFAfhBe2lozAXfAURMsp2WMlkUtaC2iXtrYIXinbN2xb1jP3t+WwZzFw9Zi0FuoosBmulAZPjK5R7nTidpraX+apGdkw4NLFj0ArBD8HHIbN8uN3IwZpqUOxZBZIIyosUDC5SjpydtBJWaR9+AwD2WQZXfQMxw1ZcnZZklplCX42VwHY6amW0dS4KZpEq4WC0ExyWwAWZSRKspYnCFTEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd/E7tNbRNmlCx2cWsuVnaycZt6TXmyKliBZzGWUIto=;
 b=RA/mWqnWxzakelO4JtwLkJr8WIPlKLVMDwQz/XY5ux8MFbMvhJpkbnMqCAe0+lY+V+MTyHHuqDzjA2LoAAgVqR9rlIRJqY1y4h9HDkPkIssQc4FLv5M+6cYCjneSVeWSPS58ov8yeOPKgZjwdcsoFSSEH6EdtNV6knAofiPYNMbhQTYJzyd0pHr5U/HPcE23Zn6rmucaTI1FwBgQXmk9WuK3f8zUm3u+qlymjQ7t/Yrzw+JZ5axhvTQpgLcLeG8rAjmLY+PHiuuPgzEK2qPMbO0OK6myVgi1ZxjsmOT5QgnkJccUMEZv8tIKm2wFCjzz78LJhf4/GD3/70+8XGVV+g==
Received: from CYXPR02CA0050.namprd02.prod.outlook.com (2603:10b6:930:cd::10)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 19:38:53 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:cd:cafe::88) by CYXPR02CA0050.outlook.office365.com
 (2603:10b6:930:cd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Wed, 12 Jun 2024 19:38:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 19:38:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 12:38:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 12:38:35 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 12 Jun
 2024 12:38:34 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
CC: <shravankr@nvidia.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH v1 0/2] Style fixes for EDAC/bluefield driver
Date: Wed, 12 Jun 2024 15:38:29 -0400
Message-ID: <20240612193831.25913-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: ed147498-c7be-4ed6-f749-08dc8b174924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NxWhRmsneVSP6Ne3CBejXmQrk21p/yJZVopIGiREZV816vDSp4XtFTRI4kF6?=
 =?us-ascii?Q?3hu0bpwHLOPcIkzbTbd4ANMsE+/8W94wBg1u4uKiwTutp7PDYF01M//yImXS?=
 =?us-ascii?Q?cOyP5nn60IA/dqyMGsinhObaBnGcDpbemVDUO7mPrGfKJWePr+De4CI4s8Bg?=
 =?us-ascii?Q?JnJAqZVI2jae8GFpcLfcOjyI2Rh+S2jyXO+rzQkYrzNNI1u0owA54vKpSnnS?=
 =?us-ascii?Q?ylSVauVPodkdAMNyaICAh7W+J0vdx9nvpyozYiMT83l/kcJZLSkkcaUNxhl4?=
 =?us-ascii?Q?gJXqVK61DqD3Tdyg0b91L21hzpcWfhjwPX/MnVBmEi5rtPRWLYxUJAWChPGS?=
 =?us-ascii?Q?sq64ZuWqWDq5HBsxr9q4bXo+dyU2FF7L2o3VABlrmer5Iv++taA5yFv9AAb/?=
 =?us-ascii?Q?ATYfQX7ZuE5T0BZPHHdRPzOKxghW+NnOSmI7aOB/L5fCgf+cF3PNavP0OA8A?=
 =?us-ascii?Q?X4IoF7HZPBCHXTA32/PP5eBJS9VpahIrpbaLCQr9gDQTNKsCBTQKJZSmzQbi?=
 =?us-ascii?Q?7Ez3a6DwqSQqn3YLQb4jUCyyJjNnxpg6rDRI//MSsWkWDAF7JKfB6ykvxB82?=
 =?us-ascii?Q?OkD7DAvJyZsC4AQzMonU8MfPyYnMA/NRuEMOeKjuAfx0qa9KQKbckJdI7MkP?=
 =?us-ascii?Q?NmARImws9qAIWtKQHoEfbu0oz3stXvOZHY6lpvwfLReu+iuW/YFaqWUoc5ce?=
 =?us-ascii?Q?8ZsDR1o38Nw8pm/4L+WhOilU0WTaHzwhNYFOd671nrrikCjKDUynC2YQOltF?=
 =?us-ascii?Q?Rc88JFcyXobym+K5BMYPNIyvMdIVoXXMkEKbVX7MTMrR4S2Gy4iBQ23LugTC?=
 =?us-ascii?Q?EcFEYsbQGniE3YNRvgW8IbbjtBZA5FNs2FS4PNlTM2YsEp1wJ2VM5yBJqCAg?=
 =?us-ascii?Q?CLiMce1/A47y3SHo5azAB4A1EbV+IQBjjXlmLGo+pGSWDuKZ0tWSsB5kU1sE?=
 =?us-ascii?Q?wjJw3kcf7aCmFMYlP2jMDvFzIb2lXnjA1qyFXi20nh62mviKXhRJj6kf/QgB?=
 =?us-ascii?Q?Uxhwk+WDUAOeWsxYiSB1ZO3HEKp6xgArKoXS+Jb/lL4dmR2rXrEFOQZM6jaI?=
 =?us-ascii?Q?myFDByVduUMS1khpWl20tekRYp63x96JnY7omgTbZ2IWcrUHPoN2YXMaujJF?=
 =?us-ascii?Q?rswuv4Ajh7kDRqt8zFYFrVdODUN/oUQNjr18HYWYutfI51vJt1kp7IL0SgrQ?=
 =?us-ascii?Q?2uP1+NIZxu5r6JpDJZLGhTKR2bRKXAYD6+N1bfJ6Ir4n47dignmT0ffDZYx0?=
 =?us-ascii?Q?l4JyMuoBKn8jERp5tk4zcdD/yr8cLK/Q0KCHyBeoNKHNNh1ujwA3OvftFf/P?=
 =?us-ascii?Q?dMJQkUKZhgRW6xlELFahuJrkjR3OukZhOhC8HPMzN8mrxSZiZfAgy7TEl+v6?=
 =?us-ascii?Q?R3CFU1EsttUCdqTq50xFPBUl2fXT/THaRj1+NY37BggZDDAo5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 19:38:50.5560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed147498-c7be-4ed6-f749-08dc8b174924
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754

This patch series provides two style fixes for the BlueField EDAC driver.

David Thompson (2):
  EDAC/bluefield: fix white space in bluefield_edac_mc_probe
  EDAC/bluefield: fix prefix for GET_DIMM_INFO defines

 drivers/edac/bluefield_edac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.30.1


