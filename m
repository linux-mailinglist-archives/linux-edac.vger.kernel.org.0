Return-Path: <linux-edac+bounces-2752-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 750DF9FE2C0
	for <lists+linux-edac@lfdr.de>; Mon, 30 Dec 2024 07:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C651603DF
	for <lists+linux-edac@lfdr.de>; Mon, 30 Dec 2024 06:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78A017C20F;
	Mon, 30 Dec 2024 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fOPW/I1i"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD081714D0;
	Mon, 30 Dec 2024 06:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735538561; cv=fail; b=VeedkqU4GQNyUyNF0yU7oNhxxagv4IUJt3D72Dgx5ZM+Z57+ztzt05Jfw+VReLrwp97idP/d/UAWAGOIEcs26Dc60uyVZF94MRObC8zxKGBoTnAaRaeLHJTfomHphSJtFOSIGJfM2PFolO6Z3CFS9W9wR8t820cri/hoaB8V5yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735538561; c=relaxed/simple;
	bh=T/RwqZIH7s/NLyZFjgsTlmr65eoEpQ6+N8upfSUldys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtN6jocBe86vKymoiPcvLnj1xKLzkG5dk4KzV1wJSsJTxLdeL/8jIaxKupt6JcD9JK3P9Yv5WQ060HEjBaakPOVGjfAQoT88FQDYpfol/LqQfSqE84xJXWD6NVhwkudnV3JKPdQhtMfDOfzNm9yTD6V0OYWAiIopjlfqJmDPYkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fOPW/I1i; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etfL07RfVo3I1VnmNIcMVN+rmDcSVL3qOTAgPNk2BOeJZaHPMAGqvDFpbweOlgNdzEARFZ63MSJGxLAVbedQ8XyilbV8bpbu+uq3wizbr9jxhuJ/rQfHbB53Elbfxid7JYO2sGYUixmINJMHiYieM+73WXxfGMxnO5xh4FP0+v+PIcEXtpGLvZS6T7DTt9dK6GBjCY7GMOyiUBCqvK0vDu63kO8uxEzrIyZDXbvZKPuX+RZPEszdQVa8TBlMfdfHlRUBfh5J3Qtszvw/eUcUF2VjyJsh6qXjJsesblHxynkIRv29EiumD1mjsvzinN+OqnktJ0SqF+r3WsahsJp7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snIdmDdg5JV8fEMbnzJc/eb7t8/VNDdIqa8/+vo/Cu8=;
 b=Y1o7R/OW6df/sz3ax4ajOMmhz8CGBg9N7VNiITk8KpApTTgzR62BoU1Pz/d6ZkQN0K8yqxd2iYZ5nN7vIHs5UBt8+BmvOvVkZfGZJSjzGoidueZEsEdbswVfmURXs0RJhJkvUwskLXGMYM0kiilVYnxEEq/QWgsc/3j0scmZ6cLUs+Cguu9ptc40d9jMg/swcXKzcyQNZCnv+r0YQpfHec7OMFHN8q7Oqxykj3Wh9Hocp3IJwos2zET/0UqYPD/ASMV5D76TF7ykGN8xsUbLtcOg67qcKsb164NgJzxj4qI+hWKlO6VGyc87cPhjjBZT6iC74e7NiKgrLxW1JIiSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snIdmDdg5JV8fEMbnzJc/eb7t8/VNDdIqa8/+vo/Cu8=;
 b=fOPW/I1ixE2BNNUvy8Q3qw9zLuKw/LnvbpDUfTZ/8HY0H+bsfl7lcjt8ePdgyIG6V9lLnDgsddBVuKA5tx880KXc1mFu0jtXt8KJFDX/C9290hN8ACM6MNl2kCAQlOc2YH5+LWnQrU2UECQCMF07dBl0NZyEwYwHBfxNq7stz30=
Received: from SJ0PR03CA0071.namprd03.prod.outlook.com (2603:10b6:a03:331::16)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 06:02:30 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::2a) by SJ0PR03CA0071.outlook.office365.com
 (2603:10b6:a03:331::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.16 via Frontend Transport; Mon,
 30 Dec 2024 06:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 06:02:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 00:02:23 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 00:01:50 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Dec 2024 00:01:46 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v2 1/5] cdx: export the symbols
Date: Mon, 30 Dec 2024 11:28:45 +0530
Message-ID: <20241230055849.11183-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230055849.11183-1-shubhrajyoti.datta@amd.com>
References: <20241230055849.11183-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: d7acc305-157b-48d0-b0ce-08dd28978aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r5WUd0EP1vkGJNrzzEz2XuKQDLtZj94Gd/iXaE+RNeUZmSa6fu0b5mlbAcWL?=
 =?us-ascii?Q?vZmvz3r9e2H4RDczflanE46CdJ8893aMIqNHIUl/9KRLMZ5OllAR5oP/7z3i?=
 =?us-ascii?Q?BxMnut8/G6gKaFQi+dtvQw3aTFQavjNYeVxJxmnNich8h13sV/Nn48Z2mlPZ?=
 =?us-ascii?Q?KzFfCLQoHVYlTi3NRD4Cru6MEl6OccokxTjRNHl0FmyuEekv+Y0wziKQqebb?=
 =?us-ascii?Q?CHNeaQxdF28yxdsSsvXWJKUIDcGty/qvKxhAxcwkccCQWooVjxEvkrCFReBz?=
 =?us-ascii?Q?MG11+TcT+Et9NEA1htDOPJcKAGOw66dJjQSlJjm65lX+KvaInkK5dGtRM1Ki?=
 =?us-ascii?Q?mP6K7puJU6fX4NzbRGzXZgsPisxq2pPgSRV426Ca05FToe/vVxoRhOwi3xyI?=
 =?us-ascii?Q?bvqag+57Ma45Kssyzn5KS2e0/Ejzsw94RqwCDFQJKCup9akBRytZmQDI8OqI?=
 =?us-ascii?Q?RaaUd1mi0NBF9KBczXh0ZPi4/BdWi/is6ivjPdwoAcUB+h9FLtG9DdqSrMvJ?=
 =?us-ascii?Q?vmWB2YnqPeHkS3lHg2cTjveGWBLQVnvBYfxMwX4Pl4GWjMzEKq0EtWD55JDh?=
 =?us-ascii?Q?b27t6Z139Kwc2DXwnf4GtFCo3szaswA3CV/HjQTi4XaqN09l6hfPHCr5//We?=
 =?us-ascii?Q?GUeAE6Hh5I2/EtNkgq5yk1dD3kYFIQ7yNoDfuRu6gST5YflqL0H2t2sRFy4h?=
 =?us-ascii?Q?mg9+TbYzPe1ndGYgkbiv8X7LxtdXqMdBAb84nSCFnesEySnMCfdYvryKhWS5?=
 =?us-ascii?Q?RVh6W/lVCf2/5wT/0IjDuU7RL0gmg/3kyQfR16tqyx9qJAn4g8ztOdnqLCEh?=
 =?us-ascii?Q?J8p4hGGsxXaArRwLR+hb2YC/CmRNp7EHvEQQYSl4eA1bvwoT8f8DIbl9g5TE?=
 =?us-ascii?Q?2f3gBAwcCYfVlAhozsrDPsii2xfSO5jtE7jrkxQdXn02OO1Nzsu8+UGQ7mtm?=
 =?us-ascii?Q?a6wuriReYS8p+Yg15sUT+str3/IpRPzt155e05WUO3gAgzt3vQNUx/BZ6yXw?=
 =?us-ascii?Q?N6Mn/h9gnnkz+8r6twykPSoN+Lb+BsYsCbKvJNbFuSNje1uPKkwrqR0MyZ2h?=
 =?us-ascii?Q?n9Vh/1Y18G6x0OXqJkZmpAIrjo5N5vUck8MCzC1evYUxR4278B6hMFXTGity?=
 =?us-ascii?Q?rre6y/BZiUVmmfLa9z/hr9dCmBHN3OtTQoF1nb1Bd9MAuelWjW9BugByui9b?=
 =?us-ascii?Q?VFbEQbgBS6T5nl0BMedW1cShwtfgunNPTf+uh8B6/xTL13c4QHlYNBXZ2/N7?=
 =?us-ascii?Q?p+jgoORBcYQLId8tmbiLyfrJ9t/xesLLDgeqbftZJs6yJUSP/zD1GefA7Cxv?=
 =?us-ascii?Q?f/rJYZxnu7Ll7jyrma3Srfjkl44njvVYkzUNOEDo5Woko2QnS/YG8CbIgYUS?=
 =?us-ascii?Q?MjBeLoRBw0HMyTHAolnJbxkkDfxZ2JfYKhAojmd7Qa6023d+nNpsfOqLSpJZ?=
 =?us-ascii?Q?hiW57n7ovg6jkSP7vbkaCoPN/fQGHK0kZzXMeskruknGjImnWk6W+7hwy6OG?=
 =?us-ascii?Q?P80EVSRbQIIS/5n2a4aMhie+bI9VZYltFNHZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 06:02:29.0609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7acc305-157b-48d0-b0ce-08dd28978aed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774

export the symbols for modules.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v2:
- New patch addition

 drivers/cdx/controller/mcdi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index e760f8d347cc..e819049df659 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -128,6 +128,7 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 fail:
 	return rc;
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_init);
 
 void cdx_mcdi_finish(struct cdx_mcdi *cdx)
 {
@@ -590,6 +591,7 @@ void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int le
 
 	cdx_mcdi_process_cleanup_list(mcdi->cdx, &cleanup_list);
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_process_cmd);
 
 static void cdx_mcdi_cmd_work(struct work_struct *context)
 {
@@ -757,6 +759,7 @@ int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
 	return cdx_mcdi_rpc_sync(cdx, cmd, inbuf, inlen, outbuf, outlen,
 				 outlen_actual, false);
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_rpc);
 
 /**
  * cdx_mcdi_rpc_async - Schedule an MCDI command to run asynchronously
-- 
2.17.1


