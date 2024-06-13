Return-Path: <linux-edac+bounces-1273-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFC1906336
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 06:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3339B1C228CC
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 04:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC12135A51;
	Thu, 13 Jun 2024 04:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t3Y9nQa/"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90293132804;
	Thu, 13 Jun 2024 04:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718254762; cv=fail; b=Bdt8/5OOIdB8gkg+63getX15tQjFDUyKd2UXQYG16AIdyzAh8FMFb7sBX0wnys9EvvL4eMoxtj5cF5wf4a0rRuUmltuiPRXS/UW3fQkXVN3uYbbmDP63UJE8RpwRI66xn4K6WqtdI2Yadvk3P/uPWnfyokj5pUi3wzyB+9dEnxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718254762; c=relaxed/simple;
	bh=HTa/NF40B9Zc48we/sSq+nWlBoB4o49CCwUuWKc/lRk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xqdm8O5bEMAFwHIW6RcXf1XwZJMt22u+rIovLpL9t0kfJE353rwZDXPUlRZ070jbduGpFDnjdPfWJsCoe69qF2Z6Laz+72Qf947Wc8mhnqWFn+WgPwPCAHHiQJLmuJFgA0dyC+Q6fLvQ5ZJkEApFRdybFaCGF2BDdRNaPvQ6tbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t3Y9nQa/; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BP1YrTA5JnYXqiJu1/bWm3FwfrVb5Kutel/XoWUzS2rbDWSltT+b9asDCTj4rOPtn1Fb2Rgb8pmUbWNOriF3gvSoAmE0zSpMW8uU3DcGlLihfW13upiIlyRLpLlK827zsNye3IkwYQq2n3r7AHlzfaFjBKuyfHFWTuSGqC1PX7G+9NgIp14SINoPvSHKEL0JO72REp+KegrUd0n/IPbVc1mnROalaof3AB3SjBiqIz7Gef241RSVrkts9AVdzSHj+AS6ysg9gdf9O5qUR9O2WQGe2zweC67aI9AiuKN78VP9mZj0QJhF+vs4xGwgAddt6rn4ptLi9/YIMoNQSQB/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9PzEif2TA29lc2GCly59Gv5IVkE8ku3dbqwsdy7niI=;
 b=l+7iYSu45JILihX2nLnPH2da2HqRFf2Z20ykB9XUGu0buQpkKdcKYohlwVSUqOKvVPFigj2GFVfok9N0MmlljngJZfyeIJlpnBg82t94ohpy9+LImdCwBYJ+haFsuH+FovF14eACKPudRjBTQFsltkpmLF7m2Y17xGkywBEj3/d5mQ6qqKVHtqCZ3LLtngz3IVI8to9V5y5Dh2HOGlqu9LkamI2OigCvpSGT3Up358DGWCcSl3Yx97SQ+CNbV/irCdbduANA8sevBKhnuvIv0SVmWIb9uYbQKcN3itidjop8KvhwKbVlYFovUkYD7eKIwnYr0NiR8JEtYogiBH+Jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9PzEif2TA29lc2GCly59Gv5IVkE8ku3dbqwsdy7niI=;
 b=t3Y9nQa/SBYJXtc5oVvmgei7yZ8lwjXzmRhQd9zklEdGAiVf1uH0sYmpjjRf8RjF6TVUByRCNr0do236BAyjTFpmxvVG83kVaabfwiJ6HgXvtU70li26eDp5QyyWlReEfnMh4Ay+fiaNyd7LZ/Q6WbHtXmXfksFK8EeYfKlqcqjvwWNZqR/8bpWWIt4fxEV67CXIHkcSdct3BlbeV7Cfl8+Kz0f+YlN565AzkI9oh4oIN1ZQ+rHlrZbKR+2b6h9zOhfV6gPygvlHuA9ygx/1jMQ5JmHT26QtvEU8zvpL4M+J+0Wccz7Gos/kf/Vs2xMPjZtMai65JB5k9hFPfgbbWw==
Received: from SA1PR04CA0015.namprd04.prod.outlook.com (2603:10b6:806:2ce::11)
 by MW4PR12MB6707.namprd12.prod.outlook.com (2603:10b6:303:1ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 04:59:16 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::a2) by SA1PR04CA0015.outlook.office365.com
 (2603:10b6:806:2ce::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Thu, 13 Jun 2024 04:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 04:59:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 21:59:05 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 21:59:05 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 12 Jun
 2024 21:59:03 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
CC: <shravankr@nvidia.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH v2 0/2] Style fixes for EDAC/bluefield driver
Date: Thu, 13 Jun 2024 00:59:00 -0400
Message-ID: <20240613045902.12029-1-davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|MW4PR12MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 24cb5784-b700-4182-9804-08dc8b659329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ytpjOMPRrfV/AvH+JOklL0hAu+k2W8grZTNiiMabjLfFELckJ1X9xZmteK0D?=
 =?us-ascii?Q?s8jO8Vg5Zr5R9DOg1gnU2tQlsbaHWwChdxczt2TnAZB9j9yWrdkudteMn/NM?=
 =?us-ascii?Q?GCJYquyWetqd1aUGSy/IIndNn5keORuQnRwpKheaOwHopwdyH9UbPTKsjWf0?=
 =?us-ascii?Q?YykNVQOeXAoDhwhzFI0iOlG+lTVqeWhJe7bs9FTkSL60N82K26hiQ0mnP8Je?=
 =?us-ascii?Q?RK2EF8qN3Y57mMED8BWbhDlnSZjfJjjdDMiY/rtuX9GBSjrbK7LMXqmg7l07?=
 =?us-ascii?Q?rbLnHosWxPhOPozVOGzcF8IVzLnd3/xFfkOZli+nBNDduMQ/Xn6RCzP14tI8?=
 =?us-ascii?Q?WC1bTr69jbFuYRj5PmulD6AOtlf6AVB4uIVHhEo1M6MsmW7Pdo0I3EJC6m0T?=
 =?us-ascii?Q?mg2NeCPA/SdWljAoZa4vTMdcUI8KAO26Ld1D4NgDAb6/nwkXatqyzvI/R8id?=
 =?us-ascii?Q?qhGYDO4n6+lz7MI4IX6zT0GKH05J4hJuQJBL2PCpMDpnhaCyRGM54KMcYfbt?=
 =?us-ascii?Q?SQJ1wlMTRWTMsJxrKy7chrFXXMrVY8QjUWIKvoaXicyL2HtDQzwWSXd58aHg?=
 =?us-ascii?Q?h7mDLNqYBHm/uY3VQXb6AqeXH0d3XO19EMZGM2L3CUmleZD4HYZHOk39NlA6?=
 =?us-ascii?Q?gVvkJCln9hNJNa7ZuecqfknGaE+wv9cec+gnq8LW6XaGj6Nmv7Y1DSE7rwis?=
 =?us-ascii?Q?qB6He3TS42pVXXnqxuRXpxltqkllA5a4yWDSPtyQ0Pk9+Qfr7/389Vm2V/Ib?=
 =?us-ascii?Q?3H7aOWulEtK5oTzMChj1E5tl7/zqD12z5SX47eX5BuANsc8N3dCc5VFqslpg?=
 =?us-ascii?Q?MTtHyawXhqJwv95ixhDdX2XCVI+++BNCHa20X/DGJxmW5iz/iJnMB+Cdwbd/?=
 =?us-ascii?Q?o70giB83NCicKHU5N4GflFseCvCsX5o0nkYwwV5BvgwJHB73KaloR1JDyybX?=
 =?us-ascii?Q?YLfJAFLsAjPc7RXJ6iQtZfrvmsBDndH/NQQT0KTWN0m7oRgeOBkX9ktD5U0I?=
 =?us-ascii?Q?DE1hbWURP6fliBkSdGrDJkP9Ic/tSPlhsN+bV7y3Il850hehGwlc4sienwk0?=
 =?us-ascii?Q?221hOXIKum9w7TlxY2ROLLJOlrULTCUiUe4uqWLzW8uRXwZhwtpiUXSIzRjN?=
 =?us-ascii?Q?fAAVKGoXh6buTtlYpmtV9Uu8jmogKZia8osp9O8GUKID4YFVC0KqZcVaPY5r?=
 =?us-ascii?Q?MSV25tmWzHFcON2bayAIHXcLGyTo+O2HCYHXSdHHVAZZNfn8/W8wanagc8Ln?=
 =?us-ascii?Q?4AWd9hE435TP0FNtNx6f1DYn489QE9epxqr09Hi0DzESfQzP9nZ8ufJ/v7V/?=
 =?us-ascii?Q?gMGkUkY2tAUZwXnp0D8+/g0GDhJjwxm67+ox9SZ5MpHtHpAPs8oGzNRzYajB?=
 =?us-ascii?Q?EfIeMHpLD0Rs3ggmbXHrRLNNanfe/LYRBDIa/YdojIsFR+FO6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 04:59:15.5295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cb5784-b700-4182-9804-08dc8b659329
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6707

The bluefield_edac driver needs two coding style fixes: one fix
addresses an issue raised by checkpatch, and the other fix
provides consistency in declaration of #defines.

David Thompson (2):
  EDAC/bluefield: fix white space in bluefield_edac_mc_probe
  EDAC/bluefield: fix prefix for GET_DIMM_INFO defines

 drivers/edac/bluefield_edac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.30.1


