Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6026D7D46DF
	for <lists+linux-edac@lfdr.de>; Tue, 24 Oct 2023 07:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjJXFXG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 24 Oct 2023 01:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJXFXF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 24 Oct 2023 01:23:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA54F125
        for <linux-edac@vger.kernel.org>; Mon, 23 Oct 2023 22:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTIRJmUXIMs5YAS+9S6DyO2Kh7EqqxMxUU6qIWYayfrSmcDVpua64kdZzL6TYnzmnN+ZyAdhdaHzKRwnLI/dQImmV4E1l5Qig9/xvp5fbjNsqYrOrwFeZ6+L+wNjPc1Nrc3e+CTxPpRaYHlbyMfasp6gHmTg7zyYu/dKxD8Uw8NPdonprlSVr6UN8Ile4Y7Op9cInf21X/YVYzCXerELR4PyruhxakkknIukKFErTgp+09xe61Tz58PYe/EccEEMrrtWNYiDedxtsCnQfQqk7q514HbJltA2JbeOT6vTghyy16JrOV5mJ/xkHMWOSKU+qqa6M1/ZpmhkAqPVUCuQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ter5CJfHOxlTEwJ1otGhilrtcVMoTLziusKlou7mB/M=;
 b=j9OAbTXxC7c4E1w5bQZCeQFd6Y4CXBgY8ONwlg2bcBYR1h7AYPYTI/TTpF6P1JZWeLydFAPAA4uy2/i6ephnkJSQU3vDU+9KF78w2ALhH3oFB/CaUYTSiyiveGhcQcx3d1O50vv+EpYW6bX0H0Pxrlp67eSmBGD89fUU4Hk11w07FQSsiAqBR3g3AyV+XaYl0SGTN7fBvJzGMIY0jZIAoi0P/12jMGdq3aw5hOQPlIVprU8zVo12/Dcg9MOX9nPxdKGjQ/01OPmlJz1K03+TQLL/90yGcaZ9htTQEdlXmydrjMzDYIE4qOFy4z5kPsc0ThIi97rjW9fIPLJZR+teSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ter5CJfHOxlTEwJ1otGhilrtcVMoTLziusKlou7mB/M=;
 b=t+01Gtx91FYzY21M6nZR6M0xs/k7Ut+At0L7c1ifU8WWWE1TzPPfPS8o2AofpZXPdFc0jEqDtvUA5NAYkF6TcUcrVO3Ic2Zjq+ZkPJC6EQmizLCWYQSrVyLcrwc7vffunBrYITUMlPh8ojZhkJWhdDJXYnKcgd66MoldxHLwR4w=
Received: from MN2PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:23a::13)
 by CH2PR12MB5018.namprd12.prod.outlook.com (2603:10b6:610:6e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 05:22:57 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::94) by MN2PR03CA0008.outlook.office365.com
 (2603:10b6:208:23a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Tue, 24 Oct 2023 05:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 05:22:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 00:22:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 00:22:56 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 24 Oct 2023 00:22:54 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <mchehab@kernel.org>, <rric@kernel.org>,
        <dan.carpenter@linaro.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH] EDAC/versal: Remove a unnecessary check
Date:   Tue, 24 Oct 2023 10:52:53 +0530
Message-ID: <20231024052253.25052-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|CH2PR12MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bfde1f6-a34d-4c1e-ba29-08dbd4514870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMSlBkTpqy4uxBv11WYkzqwmcQy4TTk+OC/GQjk1AJSm9WsC8Q2I9Nz40PMzYAfcBc+rkMN/ho6iJnRZM2rK8S0ozZeLv3EqBxMllERbnJQFs6vuPllLI/ZXZqQrybC8h02H73v90cXVarkWOYEZqd2Md5f/t27B7/wWqpthHPPAA1lLlUEJOG8zAgV9XxFc7ZMuOLmi+Dgi9QMi384N+5HNY0VYcWunezI/W0kIHryVWMU1KT4ParSHzmIZm3e/0JhNVH4t9bmJ79Gi0c4qjBVyLAa0s05l2mSsvxbiLiqIrqzfiKq09bqh+lTxLqgPyfLdNmKw5ShX+N2ZiooL47Kig7tquedXPVMZxqZqhJSZYCLpMVhNln4GfG8coxy+txJfqhHx9psf+E0n3yeWEnWBJpiqiotj6U5LTBKLvC1NmP5mzNt2CMPzIMLIDx75wBox3QNd6WVpar7Yl3GhvVvBeehV5+mfaQscJjhnaTLbFJQkoAABya9+kLk5HRGJQSvG4HeN6UY5ZL/U3oSmbLfyBRj1M6DBwTbHakuSZuBeRLTw+mW1pEQzzzElpve/+eS/bAKjIBx29IRtR7fq72543LJNQJZ2FTup43j9mLEi6NCEcnRJ/mJMteGihdwI/N9dfb+UfDykaiIMgKSbShVJIkB3P+nUlGk+YDbBADA7NdelGSOqdeZUdiVNPB50F2He+1ckG8Rl3Y8NadAyOS4mowmmNMAHo3kZ5ng5dMY87sqhdmfA5wKwnp9MNzILZtdjsbH5zxF1jb+Q8xGXbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(40470700004)(46966006)(36840700001)(966005)(478600001)(83380400001)(47076005)(336012)(26005)(1076003)(2616005)(426003)(2906002)(54906003)(70206006)(70586007)(316002)(6916009)(44832011)(4326008)(8936002)(8676002)(41300700001)(5660300002)(36860700001)(86362001)(81166007)(36756003)(356005)(82740400003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 05:22:57.5375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfde1f6-a34d-4c1e-ba29-08dbd4514870
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The edac_mc_id is always positive remove an unnecessary failure check.
Fixes Smatch static checker warning:

drivers/edac/versal_edac.c:967 mc_probe()
warn: unsigned 'edac_mc_id' is never less than zero.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/a4db6f93-8e5f-4d55-a7b8-b5a987d48a58@moroto.mountain/
Fixes: 0fd934580ea3 ("EDAC/versal: Add a Xilinx Versal memory controller driver")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/edac/versal_edac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 08f630185913..87e730dfefa0 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -962,10 +962,8 @@ static int mc_probe(struct platform_device *pdev)
 	if (!get_ecc_state(ddrmc_baseaddr))
 		return -ENXIO;
 
-	/* Allocate ID number for our EMIF controller */
+	/* Allocate ID number for the EMIF controller */
 	edac_mc_id = emif_get_id(pdev->dev.of_node);
-	if (edac_mc_id < 0)
-		return -EINVAL;
 
 	regval = readl(ddrmc_baseaddr + XDDR_REG_CONFIG0_OFFSET);
 	num_chans = FIELD_PREP(XDDR_REG_CONFIG0_NUM_CHANS_MASK, regval);
-- 
2.17.1

