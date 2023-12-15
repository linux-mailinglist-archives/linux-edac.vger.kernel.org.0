Return-Path: <linux-edac+bounces-259-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CF0814149
	for <lists+linux-edac@lfdr.de>; Fri, 15 Dec 2023 06:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00841C22352
	for <lists+linux-edac@lfdr.de>; Fri, 15 Dec 2023 05:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652DC63A6;
	Fri, 15 Dec 2023 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YEUu0F+V"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2E5612B
	for <linux-edac@vger.kernel.org>; Fri, 15 Dec 2023 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DC94uMfWe5RdzI4cWXgahq4CoRHGozxmsWgoHiEuMDbJ8hq9wPRMLiAArcyyh6ngSnyWFl7e16opOQHXzl6yJ4fGnjKLuFFFdr9GS4wDf0ahDNNM5IFO/ZfYVHKLHF3qoEyECpRmdvZoIHLw2g5S1rG+PBamExMy3AkWML7tzgay2U3cYUB9QvJ4+d/Ur8PDyQejxf3HxI6yyfXXV0v0nyLvMvNd8uIfDz98Fqq/5TJHeBoNpauvLpC1KWoelPremkUSKr53RaOoiwnqljEye/kflaEKmuQThTb+yxKDa8mv1nxZ+ZSrahbDe1QXwk9S585ucAlLWp6bcOegixeWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aa/Ggrym+Xy5180IBJ3QGXLB/PeUphOiuhhhELY8yBU=;
 b=Fj0Z8xBexS4Sp9r6DDKFjD16Z1i9W7d6qHZu4pYg2U2+mqtU8z83D4dH8DN//goRN8Q6g7Osxvd5PjPgrpXSnIKnF4d3G2P/dF7SYs8HEli+MPzuejBxc7jOy/OiOXy2XDC3Pk0eo9TaJXrLKDRON4iWtlMsPS3mTprbOsj5xSwhiF2RbkAuZhouXx7pFVuXJkvESmUPW0gMWGzJumVwu48kUrI720TCStDJNCH/k3Yx7N2k/ODVweRTmEl3LntIoRvethHBqechdGPUh+E/HcUO9yKSja0wkOhsu6u2UmfxDLHp1ApQUN1gWEr98MC0sLhNJV+3bMgtpuCalB+1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aa/Ggrym+Xy5180IBJ3QGXLB/PeUphOiuhhhELY8yBU=;
 b=YEUu0F+VfpcUF8/KwxmSi7jAGAiiyWg0SHQ6yp0T6CLTF8NuksWrUhiyVGEhsqbkEglkn0r3k7mMYqd+A3ZHbamjQWbIrgNK4CRm3lCpnakd5CtGN5Lp1+92EhpCByxnH6MufNVgcq+U+P1ev4Pner0hhaI2tTeEAXxz6itaXPA=
Received: from DM6PR01CA0026.prod.exchangelabs.com (2603:10b6:5:296::31) by
 DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.31; Fri, 15 Dec 2023 05:34:33 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::95) by DM6PR01CA0026.outlook.office365.com
 (2603:10b6:5:296::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29 via Frontend
 Transport; Fri, 15 Dec 2023 05:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Fri, 15 Dec 2023 05:34:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 23:33:55 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 14 Dec 2023 23:33:53 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>, <shubhrajyoti.datta@gmail.com>
Subject: [PATCH v3] EDAC/versal: Fix the read of the num_csrows and num_chans
Date: Fri, 15 Dec 2023 11:03:52 +0530
Message-ID: <20231215053352.8740-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DM6PR12MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f550b1a-7533-4927-6dbf-08dbfd2f848a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8VmFrdY+RvDuBby5jFVHLhPVMj4Ug21s/t+TX9JpShLsLO6CtAbfS9i3h0eEBl44aeNUPqi0jl7MusiUAUHCK8yYeEPPBke53C3FtGT1KVEouU6evqYaBimAYvMpXgJJFMfUnJV47mt0TWJq0BSQyYqEjPumMvYw0vgUb+2NaDUOZ3b+J7QcjVSncIoFH7ZEfk32qpcNJd52VZkNbxEbi3CYonJilksL2FEjiLjqkJr4/cKVma7dls7Bk+mBr2jiLv9PmpFd0nrpUJmuJBgdcX+YJ7O1x1KVwgr7BZ+QhO8ChZCIn9VOPrghFRjO3H1onoDvhPq8heNvj7yXd/TFZE185pMNmO+4tTuEPbK7V6EQ9nqjvLo8Nx75vFZ2Fep4TnCHmmmhehBNOAqvcpFCtrgcn2qGO1jYbQiZkWNyexx3Xfz8hoGVyh4yz6kcaBTVgc94jlrg5LRd/Pi0415ogeKFsuzBZhI8wB8DzAz/1g3Hp31QRi+yPww6jvdDn5NoXLAvUHT8iCjTXPNnI/1dhDmQcaokZYlRr2v2EhMqHgvl1HvNjD0cpCZhOkWWfIYOfB4Bd/9SruepwxHJzE6RQoOndSavsOYJmpo8tJXmQ1kst/wioY9swEk9WIlEIETQdP3bCjWP5ffmEkhj7N/939wPB/e9bUQlMmFWxmEXegv1H2TtGbRMNzU14rYxJTA5/LYeRZam+zF8v4YFdbOBz/h9bx5TTF23SoEpuuTc5gKOZseVR78HEnOMrOPa4X1kQZzyaww9SGXq01sAm7uZpA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(26005)(2616005)(1076003)(336012)(426003)(36860700001)(83380400001)(47076005)(5660300002)(44832011)(4326008)(41300700001)(2906002)(478600001)(966005)(8676002)(8936002)(70586007)(70206006)(316002)(6916009)(54906003)(82740400003)(356005)(36756003)(86362001)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 05:34:33.1230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f550b1a-7533-4927-6dbf-08dbfd2f848a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5021

Fix the extraction of the num_csrows and num_chans.
The extraction of the num_rows is wrong. Instead of extracting
using the FIELD_GET it is calling FIELD_PREP.

The issue was masked as the default design has the rows as 0.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/60ca157e-6eff-d12c-9dc0-8aeab125edda@linux-m68k.org/
Fixes: 6f15b178cd63 ("EDAC/versal: Add a Xilinx Versal memory controller driver")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v3:
Update the commit message

Changes in v2:
Update the commit message

 drivers/edac/versal_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 87e20f39f999..f0d8702802a1 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -1038,10 +1038,10 @@ static int mc_probe(struct platform_device *pdev)
 	edac_mc_id = emif_get_id(pdev->dev.of_node);
 
 	regval = readl(ddrmc_baseaddr + XDDR_REG_CONFIG0_OFFSET);
-	num_chans = FIELD_PREP(XDDR_REG_CONFIG0_NUM_CHANS_MASK, regval);
+	num_chans = FIELD_GET(XDDR_REG_CONFIG0_NUM_CHANS_MASK, regval);
 	num_chans++;
 
-	num_csrows = FIELD_PREP(XDDR_REG_CONFIG0_NUM_RANKS_MASK, regval);
+	num_csrows = FIELD_GET(XDDR_REG_CONFIG0_NUM_RANKS_MASK, regval);
 	num_csrows *= 2;
 	if (!num_csrows)
 		num_csrows = 1;
-- 
2.17.1


