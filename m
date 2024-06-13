Return-Path: <linux-edac+bounces-1272-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A015906334
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 06:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163391C225A3
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 04:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF0F134406;
	Thu, 13 Jun 2024 04:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OxEbuPkH"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50464446CF;
	Thu, 13 Jun 2024 04:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718254760; cv=fail; b=IaGAD4HlXx/gR40qSgqF4xOgd8DKcDg7ipuJZjqhGnBdM90iJN/+zqnueAIogxN1HY7163flZ2V26QeRUtCNsoiozdowSJI53YSdYEk321oKwNLUrni6SYIdI3OxXdKNdJTg6Je2vApx33I6JZF7rLxjCPD1GksLQyF6rkcuCvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718254760; c=relaxed/simple;
	bh=QbLkxV5tOtabex/Jps6HMQI6GePxcIFy/AaqPZdHZ4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQRpq3/1/Krw09Coc5bLAKQegb8HGb8B+QBj3gkjvncRXSaDaqgdp434TbTyY2s1ww7ZSavM8pMaMIcGq0QMmqCi9L8DDwqn//Au7q+h0JhtyK211pHmQPxN0yzRVVD+sPreXp1+zCs/tRB2gCcC+a5S3OapSr21VtZrWbLFp04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OxEbuPkH; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6HtHlzAUqzbPZ6w+B8nkmHUL6jUlmcMEnEv7xl3vqzO7rl9IWk3fv/AkPmHDUSu0rJW6n53kUC6zGaU7sYQnkizzVMvA/qgcFOkCl/keHh5HxHntj/ueOpiWiXm+t26T/VKXQxEe5lMRsEdKokmCXyLKu91VVwpouKanJt5dfL4y5H+4PelVZZ7071nCbUC+6BQ5cSzm1q5+xxlCP4vdGjwKKzBxKcjMcx2O54RDznW8LsAfZbLb6AAwTMWQSsLjsZvfBrN4Umw6TrCx+Re2zKCTddBDBtPupn6ZJ4C8EtC3+g2q+Gvn9n1fY+mz2UPETGFdnFPUn2betaSKmexrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhSFywPARQDTkC4nv9noiJkosXzr7cqQw75IuOP81js=;
 b=YiCe3UUdGprSexdjxse56JO/Gyk9n4j+2yFLDgGpYj6a3UZ175eP5nYlK4Oh8WyAIwRQehpxU3VCLLSKfrRBA4osaC+oucDNBbruQUfUKi1Pt9PIjnSXUBH6D0g0wbsesckNx3fyH6eQFZwmeXQyo8MIAh6AOH5Nd7Ue7zk2FA8EJ3BCG8klbb2SNrjAp4091CrK6amqhHm6w6tbuDCXtcuOh0rgNGWSS/aDhFV2v4d8dzS/t48elndO1OOCdjP3MZBpP8Crm4uDB9d1qRXoKgPf444cdTkwm+6f2o+MJG9yvyiMyUK38iwiKb/MU/lY8YwQWjHqK0b0kRX2mm5X1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhSFywPARQDTkC4nv9noiJkosXzr7cqQw75IuOP81js=;
 b=OxEbuPkHmV043S3HSiGpmCHSuEOKmkDBhtwRxD7usGMkJ2+uCwbYfH2ur21ZUUypa/6RUIx3dZpTM89unsFQGDxF6nhIYeW9wSWXv6h7yiEj7X88SMMzVhyETZbD2vRB489SFNvy4EiS84oczNKqNFPjnENGpIjSLs0YCfdce/Y71URDmMSEhOh+FILThkvpUBHyp+3IrG5Kmx0sfywrR5bs7Q8g/T8mHVT5u5R7p01sYl4hTGzgWN1JViEE+cgATLyJ9JzgnXsY+6yChCnquVsFZrBUkvMyevGgxBa1VMtf3KJvb7LheqZ88W3ndoVcZZC7/nOSCKdRBzvlMPS3nA==
Received: from CH2PR15CA0019.namprd15.prod.outlook.com (2603:10b6:610:51::29)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 04:59:16 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::1e) by CH2PR15CA0019.outlook.office365.com
 (2603:10b6:610:51::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 04:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 04:59:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 21:59:08 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 21:59:07 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 12 Jun
 2024 21:59:06 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
CC: <shravankr@nvidia.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH v2 1/2] EDAC/bluefield: fix white space in bluefield_edac_mc_probe
Date: Thu, 13 Jun 2024 00:59:01 -0400
Message-ID: <20240613045902.12029-2-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20240613045902.12029-1-davthompson@nvidia.com>
References: <20240613045902.12029-1-davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a796fc-2b58-4316-2c13-08dc8b65935b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f0qKmusHL3cV20po1a9qdvGW4iMxZIB3hHtSA0zmgTHvSzu3wZARP7jpeszo?=
 =?us-ascii?Q?KAsZKQMjgO+RAzfw4K7ClTCvaBMUM2D+gZQjgdDxMMminqck/zs4Zt1yGMmd?=
 =?us-ascii?Q?8Y4FW+9qH8Ya1+UZFWus2bTyDoZVC4myznNMDCAQc51FwKaDpFyYWnklmjyN?=
 =?us-ascii?Q?4BDYY86TO0Xu2BZxp3jcZaN5wsIfsMPdhjotKey1I353TOZbwc5JnQ+Rruai?=
 =?us-ascii?Q?yv3uiAZjQss3cuYo2CSC55aW/SrFnH74TLkwa+UUYtnWNeHgLZR1yw1H5CZ5?=
 =?us-ascii?Q?IneqTWWraSTFAmE9uJE+cflvMGJat6aYkXlHZqL9Wwcb+5HP6yrxsTnANh8z?=
 =?us-ascii?Q?Knxnni506669QgvkVZ/p/njFi1d7ycGp2c1/dLXJRhX3nlOwIfnIQoOg7rgF?=
 =?us-ascii?Q?pmuyPp90XABUdoh7rqC4ZhyeMYe7IgRAbWbQdgV1SZTUjbsRs38SQGLoEs7F?=
 =?us-ascii?Q?o42M/rsvuXn0LQSBK4d9HCKy+WSRqOcakQM+gvKq7GOT47yleStRXH0BZi6n?=
 =?us-ascii?Q?MT5S+DDF3Ur3v7Qxn54surxiU27PKLgMvzneq55HSNgOJG5BNYxZJ2v+irg6?=
 =?us-ascii?Q?x5r8MoXJ0R3VlQJ8WtvYotWkvUla/QvaAqcfauWYHPRXEPSXs3/ozPzxtVh8?=
 =?us-ascii?Q?9SHxFXuiFB7geA8mvlhGP3yVIvoVj54m++nGY/b9KGz3hFU89bnOkR9fftG/?=
 =?us-ascii?Q?2niNbitBy/ouskmt3bf9KdYvErrSyTDR02ZdmH0IC4L5llJKcGL83OMU4d52?=
 =?us-ascii?Q?6Tl3lHoJOWQ/Jt9Dr9uqRxw3wDqtcSF0eOWXj62LXA8PCNfK5k9+syetbx4x?=
 =?us-ascii?Q?nEEcIxEgHkdg2UJwTAnronuPY/Czi76k25XV55qzgScriyfb3lJGdWCmfT2L?=
 =?us-ascii?Q?hDZu5dgDn0yaK0ypdU3RUqWR2l/R5IIyqw6W4pw44QHSHOPWRnsHeX6jp9m7?=
 =?us-ascii?Q?uXRiLRWVf79dPjjipd2qEbbUG4vtIXDmZmWDJ7427pO+KtxdL02Qn1VhzvuX?=
 =?us-ascii?Q?wGwjRSx9OFrJLDo7yq8FRPHyqmApbJSQ88WA/i/1KKL/3sCavzlbud2uXFPV?=
 =?us-ascii?Q?bvMcQg2zhA/g4ko602V3F0EPUSgtO2oagpJSqATefu/e3jKe+yJD1zPM1NOc?=
 =?us-ascii?Q?N6UPKa77Xb2UKDu1Ot/39vW8fArJrwnQ+FbYLpyZbXDrpfjuneCG2xH69QUl?=
 =?us-ascii?Q?IbR0VpyD9HucjkHvhYC4wEAFLzLZjUoaq+9H6sczldBm2YIv0yEk5HO8psaP?=
 =?us-ascii?Q?SBA7tT4OYZzd73p8tCZqB7isbgf7W85q21+oOaV7DjfqrMPT1e+AJ6XttIeY?=
 =?us-ascii?Q?Ggszt5si0xbbnXJmKgXKACu6KoYTSOamworR4vcdw8efq9JHE5LK8HmPLoQP?=
 =?us-ascii?Q?74FBDPX6o1j2mYyd9ecPmXWRl8mO2wgAbYo8vK25Lt4utBA1NQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 04:59:15.7763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a796fc-2b58-4316-2c13-08dc8b65935b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480

The routine bluefield_edac_mc_probe() has an extra empty line,
so it must be removed.  This extra line is flagged when running
"scripts/checkpatch --strict":
  CHECK: Blank lines aren't necessary before a close brace '}'
  #324: FILE: drivers/edac/bluefield_edac.c:324:
  +
  +}

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
v2
- Updated commit message per review comments
---
 drivers/edac/bluefield_edac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index 5b3164560648..1f6f39a7dbf3 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -320,7 +320,6 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	edac_mc_free(mci);
 
 	return ret;
-
 }
 
 static void bluefield_edac_mc_remove(struct platform_device *pdev)
-- 
2.30.1


