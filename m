Return-Path: <linux-edac+bounces-959-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFC58B2186
	for <lists+linux-edac@lfdr.de>; Thu, 25 Apr 2024 14:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B7EB22DC0
	for <lists+linux-edac@lfdr.de>; Thu, 25 Apr 2024 12:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07E112BE89;
	Thu, 25 Apr 2024 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vyHjUr52"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEB112BF25
	for <linux-edac@vger.kernel.org>; Thu, 25 Apr 2024 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047593; cv=fail; b=ZICAlcxyntsn5c2dIy5foL1OyptkRqxBGoPTMXa9aPjCedjd5GYHZi/q7fq9zWL6YEoO7D6DU38GDEyGt65ZrOYv6X6WoJN1oOoE4QKTPsJoGdxz8Uutemf8PNiKiPOTtCG7prYpDtq0Na65LBNPtYe8D5lWVN7CQkXFn7xS/tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047593; c=relaxed/simple;
	bh=TBw2NgiwTnmq9ew1aa0RZNG78jQ9z7q8SmfggYJ6HOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFfaSpTllhNXkMIoq3Me70nkgU9UmLrdr8sTxKbIqacdGOadkGxHP5z7HJTMiZovvkDFWHBEBUWka80SKJzsUKNde00SnHPdZ+YZON0fjhd2uFJd9tIn1PpGjt16buKBpuBwOrCsv+29chDywjf9BKzMcgaca3kAVNdh0hitM38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vyHjUr52; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaQGwYUqQ2K9TzXZMcC3U8EC/bO4RmIr36lKeBwtmtrR9P6oV1CB3zRXk2lGx+SJA5TSl4+geqNgwmhOyfCxjMFbjlld9tm45naBfiGQT4KS7ZgnVQgm3h/mK66/C05I5kIOO9Mh/PsarRyrSBgDbFXBAC5lemu4uOKeSjbG8NofVpfXTNbXVt6vVw6N5ZnOlvazlQMBWkENkOcegerThcFYEqsMbFAZ2dGp9JurMAlhnMRD26e6wjFgBDG6ED9uRovgPFvnKBFd+59o8vnbNoRzebP8zxL+ZqhQL1crN443B+nCCWDcEiohAxXcmDK5ccS81GYavK5Tp2v2jpZO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbvWmldgzdwf5hg7Rf8WQdQId/GFNPY6Ns+OI1uKhKY=;
 b=Z1+uJXQzYMbCW/lW0lLWKiA/6/nACg1DHNMxX1jpHmzYTHWsCo0pwUXEADI6UMnV6IaiqpnX6crvtIEgYQ0KriLcZBwkzoHUDOA7TznmYkRotzMtyI6tJCSoXzl2o+WSPgAL0vyIxc0UZPNyI5S8Sy4mJja5gaPTNT8o1UQqyJ9oTMDFAPSbZA8G/hFIDyEIkWXS93fjyC08srhrltnfZXReKq7lMftCpzTYzZdtsLhS5kiOs7NMxzYX0ccE67VtuYH7lQL/mxxA+W6Etn1YbezJ5KTQN4PkJtasSU6SaBLSGarPtGqIX5mk2OX/wLG01hXmIdt2e3YmrugqxFpXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbvWmldgzdwf5hg7Rf8WQdQId/GFNPY6Ns+OI1uKhKY=;
 b=vyHjUr52Iu+fP4Gl13rJhuFctPZK7UdMX6r9fUY2+vQiBJgKvRLeIDxUWQZd2nooOiAWNlYfiUhTc8by4nk1nk0bt9DPdrxbuiyt2q8mikTFZFryB12uKYaWWdPuBOcnKjYLj/xzModekrL3yi+qn7XbmEDbe2zO/dmrS4HC4is=
Received: from BN8PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:ac::15)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 12:19:49 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:ac:cafe::f4) by BN8PR07CA0002.outlook.office365.com
 (2603:10b6:408:ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Thu, 25 Apr 2024 12:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 25 Apr 2024 12:19:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 07:19:48 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 07:19:46 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <rric@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<sai.krishna.potthuri@amd.com>
Subject: [RESEND PATCH 1/3] EDAC/versal: Do not register for the NOC errors
Date: Thu, 25 Apr 2024 17:49:40 +0530
Message-ID: <20240425121942.26378-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240425121942.26378-1-shubhrajyoti.datta@amd.com>
References: <20240425121942.26378-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: bd49f2f2-8a67-4adb-b48f-08dc6522005e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FBg40nburV712MUatjknm2oNoPH5WUGx5xdJ6J5EzOg5ZKwdYg6qt5gCNOZD?=
 =?us-ascii?Q?S5rv9OVhmov3vP0fU06tG8fj6tf8h2M+kGlnJqpN7HsYg8RKf0OAtRMyKOMm?=
 =?us-ascii?Q?F9sesFxnMD2pt+0Ncyx1mgGQ7aLVFQpSPeAKpwmpSTHMlbm2JuCVXdsIhVFj?=
 =?us-ascii?Q?9O4GD7h00vqavWrF14BV/AiHdbYNX1R25D+e70NVU7nN3tp8ok5yevTBiqfQ?=
 =?us-ascii?Q?1iZoOITIDtsaKNh66ylJwQ2FNJk+My4ebJv/Ncv3+/4Xe6pHflIB805GqGtg?=
 =?us-ascii?Q?geD7JUVd1mpgkNzv+TFp9ONXVrjzBF8cjznSFM/XGimmLQcOyZ4z3xDYqXtg?=
 =?us-ascii?Q?vQkvMY2wm3gSPCnGidWXAeylMUAYEuDFIy2f06X8ZgzC592YLMxE+GiTV9/O?=
 =?us-ascii?Q?cif2k9o3lXF00fIxBhY6NRVut/pdRBMJYzjyYi2m+DQo/ui3TfLOWGHgur0K?=
 =?us-ascii?Q?01uZRLLkAixTPf4aoH7KkgSYNyUbzPtQnP92wR8UEEwtrWxoAoIALqpH8ffa?=
 =?us-ascii?Q?5QhN/zntlY0yz23RmVq0AD7HjSxHKj4pHQ2S00G8GO/GMGDbO4zsaKGtmfop?=
 =?us-ascii?Q?hN3UDUqreLrCFuPtTvpDLRQcOMFxU2zq3bhk8/YoJbr9zvmviyzoqc05kwiN?=
 =?us-ascii?Q?qvWY3D8DznD7jZdvIQE6UbXLsAaxCPCkt068Q90J0Rftvba9Pp6poOHqpdC4?=
 =?us-ascii?Q?CtALtu5URwX06K8S9Gnmws2bucJEb0S5pEtuCnb/vCDDv4DhBUX9eDhSKicJ?=
 =?us-ascii?Q?7jE6fCBW02QS43Y8c8X9WpRBgi1LRpSeWSe+5hTke4j4QNGxhkOfRk58vbAN?=
 =?us-ascii?Q?SfBh+0OGDgS1xXfXKCxZ0Ghq5U+rktkH1lBAnsH1GlS7W/sWS3XP9e9hkC/X?=
 =?us-ascii?Q?O61rZD56AkzLul6xO10VYESkhksmsBtlwLbKIrlV0VYHEzL2SGjM+MWphA9Y?=
 =?us-ascii?Q?7kwJPdd9H1xoFR6gbXWrHMHWwIUYXFZs1P+eSpMqfFJsiiNxcWKdKWdxv9+p?=
 =?us-ascii?Q?MLJRn9mt2NSf+dxqpl+e00pAWmqHB0YgGpr7lZ3PurjYcNlF79rtgR7qTLuJ?=
 =?us-ascii?Q?B7Ywpmz90FndS3icbYNF+BAd/Xk8Ff3PGc/4mSmT4UTOaKLTT3p9EycOCmih?=
 =?us-ascii?Q?gH1PBLUBBWQSNwOyghliCOoxr8J/cGuiHMyeZgZ0eFG8OzdIdc2hpdlchzcq?=
 =?us-ascii?Q?xO+9HDDgrqvhpkif1A5ROj1+sXnWuqFhScXVt2gX4OmLR56ZAkjxOcTimJAH?=
 =?us-ascii?Q?qKg47Dt8ziWqN6BzPnvAVk9tchYSAC8d7a/FOmsEDcUXQfGisQazioMAAiFM?=
 =?us-ascii?Q?pr2RHr8SIhTj09sVmHBkOF1B8lDcRITPHEJMfKzKvhA8SfiXk4bYvo9NjAb1?=
 =?us-ascii?Q?sOTeaj8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 12:19:48.8799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd49f2f2-8a67-4adb-b48f-08dc6522005e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002

The NOC errors are not handled in the driver. Remove the request for
registration.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/edac/versal_edac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index fb231d0a3673..710325381d5d 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -1245,8 +1245,7 @@ static int mc_probe(struct platform_device *pdev)
 	}
 
 	rc = xlnx_register_event(PM_NOTIFY_CB, VERSAL_EVENT_ERROR_PMC_ERR1,
-				 XPM_EVENT_ERROR_MASK_DDRMC_CR | XPM_EVENT_ERROR_MASK_DDRMC_NCR |
-				 XPM_EVENT_ERROR_MASK_NOC_CR | XPM_EVENT_ERROR_MASK_NOC_NCR,
+				 XPM_EVENT_ERROR_MASK_DDRMC_CR | XPM_EVENT_ERROR_MASK_DDRMC_NCR,
 				 false, err_callback, mci);
 	if (rc) {
 		if (rc == -EACCES)
@@ -1283,8 +1282,6 @@ static int mc_remove(struct platform_device *pdev)
 
 	xlnx_unregister_event(PM_NOTIFY_CB, VERSAL_EVENT_ERROR_PMC_ERR1,
 			      XPM_EVENT_ERROR_MASK_DDRMC_CR |
-			      XPM_EVENT_ERROR_MASK_NOC_CR |
-			      XPM_EVENT_ERROR_MASK_NOC_NCR |
 			      XPM_EVENT_ERROR_MASK_DDRMC_NCR, err_callback, mci);
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
-- 
2.17.1


