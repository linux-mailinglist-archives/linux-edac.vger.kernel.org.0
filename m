Return-Path: <linux-edac+bounces-1270-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC031905C22
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 21:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED4C1C21BB4
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 19:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF2084A46;
	Wed, 12 Jun 2024 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I6BVFmtE"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7679A84A2E;
	Wed, 12 Jun 2024 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221146; cv=fail; b=roMCnzJYCn/XOyzvnr/CpwMyGpE+u9UIym+aojkwbG6vGbixf8sQWDNfcb6ikoFgn5scWLUQUkM514XSEQO/U/8Cvwz8qcXkjG8hUz0oK1eN4EBAoWZLwU28Nu+tHUFs8NQl4/6oa89f8Mzfb57FBgiOVDWUVeJ28pnEvB/nYsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221146; c=relaxed/simple;
	bh=67pdb2IrxO4JC2fmBDqCdZ7SqssE2MBo1YCPdcqt1wo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=luyxR7o2EsuT6HfdGW5QBuaZ3pOnq3+8MXbxxxmWpSDEKXWvFGcJMrF/Xq9kcS6OVJ7D8wejFz6V/K8RBPeCODPuOixvv71vaN+rX7Y65ODu8HP55+5XInm4/5DkFFl4gb/kKrDf9o3CcdFl5ipFzcM1Nqxp/sq/qr0MPJ7nvEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I6BVFmtE; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXJW/+uUYSUWLJuXBvMDO01wlzOIGffs6Zg/7ZcuG6jkWIsfJhw6X2St/rFBpM94skJEOQVnGyd/+xxKhSoOAI8tQsbViugV6HaRPAdJIELAxdeXDbMQDJBaDVfhZ/5xLDpb/OpN6K+rIj2VtlMBISTpdqDfj2g8VzxIsb09hMiUc+3CUhw6Wm7ug+JvWUGkeC5WLUKbA+maIRcTQN5chZx7eRAGvSIxlAVDYY8EIr1n9Zp2a0qCM6wTKBoGjMI2bEFx9iW9z1VPTQjSTJceOQcfCbQJC1Y2vkn2wgtTG+nEz4o908pEQfQw0oTnRFGWBavk5Zi0X/U2RB6y/3hu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ3mLhnS0QJkuqMaN0MXknHT47YVTpv17F7EnD42NXE=;
 b=Pe3OEtj7vkbzVu/cdnLFZNUVgtG1JHGbqdeNCcXMQm72sr6Z+8qAPZ+GwhAB94EhCFQxNr/qo2kGWjFgYUkMwKXSnXVPfx+fZq8Yf+qvonuKDsbZeKa4KwacRV53iX4EL3YTVADhj05ZF8R14Ct6olFaMCXeYXsmS48jsUfPjH73Bo0wgBhAxGxvBGi4JPO8IwtncFdvsdIbnLlz/cw93L9r6KdxRwkJNJdtJEeFFyQ51OzkWfrcyu78wwa33eydZSLyKb7YqIwSdfptSypTYB8DwHtBXSkRGeFX9iwf7sguySBDhRsihBUcGY/UuSFzZtdGlQr6685DF0Ea+CmzYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ3mLhnS0QJkuqMaN0MXknHT47YVTpv17F7EnD42NXE=;
 b=I6BVFmtEB4XMfE8lgkf5HnJLWCamMJe7S6reWRREgHFfIYteYj/ENQPyy0YV//NMiPDtp/QU//AmLmICmgXAHC7b5knsAobQkJiWJrpe0GdBJq6Kpxo/FL3QGeR0WdajhIKPD97P50XDwOc97BlKnkILPVRk/6nqqGn6lBUDl7VmTV40efTsW51QrYMeLJDII3goJxSn7d4MKIC99iSI6dalRdnu54he1ROYoWwDPdlKemiwSRFwCXBy9jjizohRdcK5myYlRJdcS9mqysyq7VhJX8VDnGEZvTRPIpS5at2I9ikA3Yp8A/LSPXXSFuqWgt4qY7u7L3LzvGw23gR0iw==
Received: from PH0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::24)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 19:39:01 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::a6) by PH0P220CA0017.outlook.office365.com
 (2603:10b6:510:d3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Wed, 12 Jun 2024 19:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 19:38:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 12:38:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 12:38:39 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 12 Jun
 2024 12:38:38 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
CC: <shravankr@nvidia.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH v1 1/2] EDAC/bluefield: fix white space in bluefield_edac_mc_probe
Date: Wed, 12 Jun 2024 15:38:30 -0400
Message-ID: <20240612193831.25913-2-davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7c09bd-054c-43ed-5c23-08dc8b174e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SgHijHqTMGmr4ycMboIxB45BHIkQBDxYfyjuRbj9+Ta0J3Q38IrP7sib4a0Q?=
 =?us-ascii?Q?ymLvSuNNe7h3lff7YYuYb0pop20/0OEGf/RemscOWK3wKYzZ+DLgLcwb8e6V?=
 =?us-ascii?Q?MSrCEC6LCpxZBE6bczLp7x9dAUzHx0HZD7FXSX4WH445WsRM4/7ayU62oHRG?=
 =?us-ascii?Q?wkT3dG4crL25LEXyXmKRAh+GChEQPFNjvqkLxFKuc9eHqy6RBfywpZ5clEZH?=
 =?us-ascii?Q?eBgNT5Q4n1BaA0HJMLcIwzaIgGEV4ctUcw6bYgkme/KW9kskd5SbUmBPr0qk?=
 =?us-ascii?Q?c/HbTn9R5O+65uqAakCYZt4wGUkspXI898Ud/sXy7pOMu5+zvT82fMgjwAE4?=
 =?us-ascii?Q?ueqbG9QBL2fUbeAr7SNJvKVFG28gjwX9q9nGHEFiNAqMlNE5tv4x2qqt3w2I?=
 =?us-ascii?Q?dBDOxrRk7fsTh5BDHh2lCJRvbHEhVyQo/Fe90fZ2VDff/fZdwDpYIXuFW8wp?=
 =?us-ascii?Q?g/gzNk1rr/8l6McT90r0gR2R1wcGv8n0+5bCwCy0t366H11jhUGhjxpFP1iy?=
 =?us-ascii?Q?RDlwcOSuu0DDwd2rk5QIRw8EYNweBd5Ty5M2t0OlBvpn5AtXZB5RQAZOLmlY?=
 =?us-ascii?Q?y6dVGEvwCtPjJg867FKoS62MDbMHUYFQXQ5ViJAnEwW8leK1Hco1iCaloB3b?=
 =?us-ascii?Q?e8llBcSdFqrZCBPjCMTJsPJsfVt7L0qUd2/z3EjaC9iAlCZN6Wn5IwQNZx28?=
 =?us-ascii?Q?DJCe8EHtDs1ePq69Ro3GI3LNiBsKNONYxkbQqJxMqksEXwan8LppVYCBFs6i?=
 =?us-ascii?Q?KDOxKWl4GTkuGSjwqs/udClgqCtpFXgfIb1s80fyisKPeNbw8UtKG1dDwTf+?=
 =?us-ascii?Q?M2nIRxv+JACiwOvuQcLqDKKt/c4RBNHnEtpPlahEcAeydChl/HDlLkDK/yjk?=
 =?us-ascii?Q?tRgCp+GunlcEv97nzIqgBRYd7M1CcFiyzNA7Vic0Gz0HcGeNOvuNpBz1gRGd?=
 =?us-ascii?Q?QiYr6M/zC/Gno19LaEZf67iaAlaktkbD3WvS7dI8lIUgKuAm7QsNZ7/CUhMD?=
 =?us-ascii?Q?5YqEsn4A8rnJwxNVVM2rPYGt+E/oq2nrBmSf4h4fjs6+rE1i9rVed2h3LXvZ?=
 =?us-ascii?Q?h7A/nQGFZlSkQYG4Xfir7uNfHaMYegmUb9Z9mbz2L/qZx9LCdWGZTlUgEBeK?=
 =?us-ascii?Q?HYy9PXQZ5u87Y9xS7bNaKs7bEwO59ga0OSATfV0b1TfuEk9tV762FP5DMxia?=
 =?us-ascii?Q?i8D2JIXDHOCJY4225X7e5v3kDAH8Cpk1MRaNrJ/yICtlz4aAG+KzpoMvrlZk?=
 =?us-ascii?Q?ZWfGJ0TEId2lqn6sntYZ0XNk0gRCD2Cqcp4yTOo2LXrpjdamb1r53uou6KJz?=
 =?us-ascii?Q?G3wXGsDH13ZdkU5FTbHMxhtRTAPgaFNXhEvPqVy1ekXUw8iBAM3fn5zDUSjx?=
 =?us-ascii?Q?f4d7/BpPGiR61xWp0qtDnaJhyMPyCt//tsZPXrpVzD02J455Ww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 19:38:59.0254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7c09bd-054c-43ed-5c23-08dc8b174e25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033

This patch removes an empty line in bluefield_edac_mc_probe().

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
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


