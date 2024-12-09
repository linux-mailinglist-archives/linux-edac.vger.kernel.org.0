Return-Path: <linux-edac+bounces-2679-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558ED9EA185
	for <lists+linux-edac@lfdr.de>; Mon,  9 Dec 2024 22:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7408E282D75
	for <lists+linux-edac@lfdr.de>; Mon,  9 Dec 2024 21:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E2D19D8B7;
	Mon,  9 Dec 2024 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Myr9sil6"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D360176228;
	Mon,  9 Dec 2024 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733781412; cv=fail; b=RjTEnUkR4m6HdEDIsvRAisuuSEr5Pb92hkGNuWhpUXyAVEyOplEaXQT3JK+ftRLea8OzcSnBlm5AbnUinPzKRpZg2By783qKvGvcnibDTIB7bpdii+MrcErV3eNKP6Br4sK9uqbypHwWnpJ0qN+c5NppgooW3uHPiuMAyf64nuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733781412; c=relaxed/simple;
	bh=F+9XA97JMLvGq/GQsSksjjgp2YB04nPr/0gbIEQBUKg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fmRM3MsCOB2sOx7tCwcnY/t0jCXLeZqEM7a73MsmwS0PA5h4YdCb0aWZ/A23pMFPqFPNqE6g5syr1Tw6E1wKOhYhhqJ28JhcVRKqzpkPHxbWzRGx682GKnRV2vXGvrzTxzjRaGTXy06gZj8ndcfkKCYAQ63YLNFSA4VeqqaOvQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Myr9sil6; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxss6MQ0/SjM5px/pJnpam8HWAgms3FoAMvSay2UBHa5VvleI9Cj5g1Y7cxehNlbSrb0kn/zOBg3vPrJIrvhXWmgPkPa5RDjzwmrhwL97nuNitEXAD6j8h/7VfEIOTAvtHP3kF6IGD80TBfEZmoTWeLl5i18MIOTWI2Mx3dlgwK7GtYLUdRWr8bmw4UZow4nYOCr9q6SZdw1i8VMpfmkP6HuSanPOK+NBdV2XqSZ6PKA/P2Ws+H+Ob3FYuH1Ipms9YHVkRi4mOuLpHufNFqyEAXgUxrAeA+3DfOQDbd2QBtAcnauw6hVXdKVFAYZbviANyF6OIC2qb/sc2UqmaJJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM+mw2DU1F6fFlgSltTBiT6FB8Z1+qK+o/yCC8SB9PA=;
 b=j+xVfUFwEQilnspCJTQR77UaSj+WF3qChRlAxLXAgFVehYfPkgTqe7XioUaMqfherOMG7UFBhlLruKBS5JToHaCNBGyhv8gMa1m+Ys52+uSXS1mlZDkrWHZpw6l1/weXPmSDyO+e2a9Pc2u5ctt8Z2yW8Y2o/WlmkQ5yePQ5IUM9e2iAZd8IQsN6xyTeYaLrb/MeLOIuvHOLhq9RmS7povURs04uXDyfkmfY92TMyG7Tp+QVheH55NcR/dvyAmTm0NR4GE4VGdRA+H6s0L5G5tRyRsWfOsW8VGuYg2RRe6Wu/KaGUp/I1WC3sxyFJQ1E6Gh8qeWV5mF3QCWDfo+Q7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM+mw2DU1F6fFlgSltTBiT6FB8Z1+qK+o/yCC8SB9PA=;
 b=Myr9sil6Lw6eZFl1CHSa6ETR0CriROJqBKj/blWZvsEtkMuLooCHJDgMk30hE6VLkFVZemd1LH2wf1bVq5LnUxzhqjHQ1IevDm2r6z61QxK5WiwuhKz56P36Moxy++sAJEspHFR2Rbds8SE+Ciu4D1TqpQTqYRRWq3HXUwoeczE=
Received: from CH0PR13CA0048.namprd13.prod.outlook.com (2603:10b6:610:b2::23)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Mon, 9 Dec
 2024 21:56:43 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::88) by CH0PR13CA0048.outlook.office365.com
 (2603:10b6:610:b2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Mon, 9
 Dec 2024 21:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 21:56:42 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 15:56:41 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <yazen.ghannam@amd.com>,
	<avadhut.naik@amd.com>
Subject: [PATCH] EDAC/amd64: Fix possible module load failure on some UMC usage combinations
Date: Mon, 9 Dec 2024 21:55:10 +0000
Message-ID: <20241209215636.2744733-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 59693f01-e16d-48ac-bdd6-08dd189c5def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TgIKiFQ6X3rzZYl2caPPR0vVZRfRMK8XJnAQZldPu3D5+LKu87csm2NL7Gdn?=
 =?us-ascii?Q?GXcMbweyXAsTiupNjIwlu03PxMyjkXcsNBRND2ga/qhVlkB0Bc6k5ZUazWyH?=
 =?us-ascii?Q?4IGALQDZ0CjldelGyHB765aQS4IxyH9EEOnS+0ZBr/0YQW0YJ9bqlWH4D6jN?=
 =?us-ascii?Q?IYT0q1g43saaDuyyQtJSpIIWq74OjKbQ1J73u7/rfNVXD3GTfKITp425m6j9?=
 =?us-ascii?Q?WsNGbGT9nqIHaBAktZi0AUGdUVd7xs9Xe5K5iiFtMxJxPOlao/WArxx3PrXt?=
 =?us-ascii?Q?w5vnMMQP1Ad6wMktl6SLsO9vXCjyNwPhR8GxtofcZiVV7C2Tf/BN+3IeQ/TY?=
 =?us-ascii?Q?k/utd2F1EX39H97WBd47ycV02Z2+uufOvbNd8JBEheeYtCWyECNkQg3cu+VY?=
 =?us-ascii?Q?Odb673L8yTLo3d68JJ23mv/Gr8rfZJ+aSFYp/0CANWIsKqmmR9Yo74MMK35B?=
 =?us-ascii?Q?sbGR5/t1RN7dZ+o6JNsz1NEt3nR3vCZbczzRi5nb/MZOf2+M1s31hQEY22N1?=
 =?us-ascii?Q?+XDxKt5ao6jKcCM6x51raeF+NeRjioUCHWqmNxNdVbXC9/Tp+3IyJ8RPbrwh?=
 =?us-ascii?Q?FCWQx6uxWf3K6BFM7+6uMOhOpNeWrNdMJHvrdyqLgH7gdrI6Appf33XPd2Se?=
 =?us-ascii?Q?rMlmY/2uxnL+PuVdT0wNpoLSHDkJyUhTFrcq1fQ833nzJwLQoF+hUjaMZ45D?=
 =?us-ascii?Q?iJuDjUgedcoMAxlKiIYZWRbEEPXbQPmJrV3ruIev6O8kQS6/ILYTxmnAwYpY?=
 =?us-ascii?Q?KxbnNzAkEFBJfCS8WJD3ZwEXbktW/A3FSfoe+blSjiWZof6XX/4LI++sNZAY?=
 =?us-ascii?Q?iRNlwjIHHcG9rDvFvQJVjUyTJxTSeIEm3tZrbBzyMVkEUYFW1AtQ+z1ueg9N?=
 =?us-ascii?Q?11BWumsg9n/FudUl6aLKi5QAqf5G7+iBfe0dzFwSTGqw6kMpSHqhO7FJac8b?=
 =?us-ascii?Q?xByDGzZt3nUnRGdCeFz7ygNpm1IjuvsS7k8VI5UpsKLka6CDZ2PI9nTaQSA0?=
 =?us-ascii?Q?HxSQnVaOzYMiJAuEz6mzGFXquhyeaemb8MrrzmHQEn+gtM7TYLspU+fGpW12?=
 =?us-ascii?Q?jVRBy7QhsqlAsBOV9Bc/JfU/LDO5A7Oc+B73aQlvktJWRjlu6ulKG2HZGjq2?=
 =?us-ascii?Q?biJ+9N4neu242/lpulVKtWiUOTeukT8+gilklJomLbOg4k+aSnoCNWHg7egt?=
 =?us-ascii?Q?CvAQBBf+0eEyJqieSQUfaqIX4mULmP70sM11JeNMLajPUEGHsG0yLP7V1cNF?=
 =?us-ascii?Q?4e4iNK+sUjyJBSDNR4moiGDeWHGkEtQIkYQ0xuaOyM7zWS6Hisn0VjXrV1ni?=
 =?us-ascii?Q?8PHQXmVjMVDk0tIn9aSvL8dvGZStp/9kLsKCGCzDWT8dnnGUc3YqT4UCyQqO?=
 =?us-ascii?Q?OwyCreMe2PHctjVgPtX0aFwAj4Qa7DfqKcgUNcrY9D9GfIviKKHDuBl8BaP1?=
 =?us-ascii?Q?Tys8EoN2LnCpjRI2+josRkHmSzlxri65?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 21:56:42.5342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59693f01-e16d-48ac-bdd6-08dd189c5def
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212

Starting Zen4, AMD SOCs have 12 Unified Memory Controllers (UMCs) per
socket.

When the amd64_edac module is being loaded, these UMCs are traversed to
determine if they have SdpInit (SdpCtrl[31]) and EccEnabled (UmcCapHi[30])
bits set and create masks in umc_en_mask and ecc_en_mask respectively.

However, the current data type of these variables is u8. As a result, if
only the last 4 UMCs (UMC8 - UMC11) of the system have been utilized,
umc_ecc_enabled() will return false. Consequently, the module may fail to
load on these systems.

Change the data type of these variables to u16.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ddfbdb66b794..583685e8e60f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3362,7 +3362,7 @@ static bool dct_ecc_enabled(struct amd64_pvt *pvt)
 
 static bool umc_ecc_enabled(struct amd64_pvt *pvt)
 {
-	u8 umc_en_mask = 0, ecc_en_mask = 0;
+	u16 umc_en_mask = 0, ecc_en_mask = 0;
 	u16 nid = pvt->mc_node_id;
 	struct amd64_umc *umc;
 	u8 ecc_en = 0, i;
-- 
2.43.0


