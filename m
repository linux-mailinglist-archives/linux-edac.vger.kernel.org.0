Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43544BA2B9
	for <lists+linux-edac@lfdr.de>; Thu, 17 Feb 2022 15:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbiBQOQo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Feb 2022 09:16:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbiBQOQn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 17 Feb 2022 09:16:43 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E67AD100;
        Thu, 17 Feb 2022 06:16:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kka9cJPYIhu0dydqIV9jgcCbct2i+P9ULH4xTUoQCiyAVDV0L5b0bu7tleb7/oJ/jEUnC3C42+xdWTilR8ft850/NkCoEQPHjZvN2ygUb+AENmShPZZ+sVAzXrCZK2rpS4fLj5jG8A4HApTglARqacRWbPp1m8r4F4cfCskegTtJzfmPPqcydIPjWWPpKPU86dgcx0k4tGqN83cbeNxHKVVWGIvHMO31NnsooUnj/RwhYpwb07vLV1ADXMRV2ZJGISAbfws/LlDVRlVkRc2qv2ZXCk+TmhsQp3CDQN9OVq1Q4Gq0Kya7RJTXIzKMSDukdtqLnQ7yOM/y1um1yAIm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHW+t6DU/YGgsjQmG9zfTpJQPhinT+cX2HE6H69wK28=;
 b=F6yoCtcDpl6gEihDCZ3e03vRz4gZDZowFhMucsZpK/b+FxE4dxVpIsGYZtYMmtP74JYihU+cXl3S4OcSulSL7Yu6axZ0yjFivTyOzrGgrjCv1NSA5DqFbiI25U3r4/OqLblZ9VH5xTK2qXkC4jqQB+zr4Yuvh+Jv+5pFzZ1dHRhYhEo8ID0FtnROq+sLT0kxm3lsajpVPW869rlErA12qi7Jle86f+gP1cJpc8S92Fc+QVooYO7NuxD+b4A/9af+a9AvGK0WZCpNOvI9xs+0T/DLW78x9E947wD8YJ4KjDKBrF4dYsiBS3LMWz+7p7ihozgUv2gNBcfXup+YONRqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHW+t6DU/YGgsjQmG9zfTpJQPhinT+cX2HE6H69wK28=;
 b=ZxNlK+YET01MPnzdCgdG0qRiofsrNtaP5BisyTaL/x9eyRCN9ue6AcaGw6SfET73cvGRvWe6QlX7P4AhXP4d2n1mQlyaHylRdA6PxRk5hImR727GQO5NJ8AWCZEEaMtYJdYby2DgWsefjlQtkKWfI1JzGrfQgAnOUp4iifq9kUg=
Received: from BN9PR03CA0160.namprd03.prod.outlook.com (2603:10b6:408:f4::15)
 by MWHPR12MB1517.namprd12.prod.outlook.com (2603:10b6:301:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 14:16:26 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::e2) by BN9PR03CA0160.outlook.office365.com
 (2603:10b6:408:f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Thu, 17 Feb 2022 14:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.20 via Frontend Transport; Thu, 17 Feb 2022 14:16:25 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 08:16:24 -0600
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [RFC PATCH 2/2] x86/mce: Simplify code in log_and_reset_block()
Date:   Thu, 17 Feb 2022 08:16:09 -0600
Message-ID: <20220217141609.119453-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220217141609.119453-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220217141609.119453-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da12cdac-e86e-4541-f756-08d9f220151d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1517:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB151712C08A1D4B63F9F23DE990369@MWHPR12MB1517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HSAdyGsQqIUBz6F6SVcaeJRnmlqJWkYLrZdSsC5qOvkUYJA4HHRk8WdfsGSTVFPL2xrMGJEkmfOSrP/NCl/H40Gbv3o1KW3AnlgKQHaIDU8QCk1rb5otHf+mK9fzePrhbmiasG036ne61GRsBgK8UMhysfzV523fONff5GM3bPq1yqbx8+CS3+R/oWfQxnyjJT7wZNo/g63x5rnHOv3Ozysj9LjEdw3WMG3y0EFPz1Qx9TDak9csa3xmQoscQ+DguzidTdQEmaX/W9Z4WE/TYZbYizK6AlgXUfXz9yTQ6bomWUHjM1D7gb7iwCscLDeAgdqctXFwzil6fpawt40XjrZOiywnJ5/2FDKpMvKybDuGqJiKnkp/oSacnSLM6VcZJJo7TjpaJaArv9bjY8gMmaDUfdm5HbMerPWc1THaV5eff9jJnq6kh6yEoAlb1IU+Ct8icpWgYXzspkSMxrcEmxI4KBXU6fQd8iky9RA0IPjc2RCkx3SIZAP9Q4nnmhjT/OWNa5dnBd3W8mx2ag8mtT2icBMIXu8FMrbgO8F6JVz29a24tE5PVAxmMyAuqixdM4MPOtfCfdeopOdIJvsNlkf/5l01SR2tA7tkbA36dJuDgZgvWbuxvH+axiKc16Y5lU8P3TKU8XHZXqJkc6zNVhFffkLv80vGBvrJPWB/TEkV5vAAXTUAka6XqC3CA9wkql172YfaMdG1WomPC0EEOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(316002)(47076005)(82310400004)(81166007)(356005)(40460700003)(4744005)(508600001)(7696005)(6666004)(83380400001)(110136005)(54906003)(1076003)(186003)(26005)(5660300002)(2906002)(2616005)(16526019)(426003)(336012)(86362001)(8936002)(70586007)(8676002)(4326008)(70206006)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 14:16:25.6171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da12cdac-e86e-4541-f756-08d9f220151d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Reuse the existing _reset_block() to reset the threshold block after
logging error in log_and_reset_block().

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 53d9320d1470..823733468973 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -960,7 +960,6 @@ static void log_error_thresholding(unsigned int bank, u64 misc)
 
 static void log_and_reset_block(struct threshold_block *block)
 {
-	struct thresh_restart tr;
 	u32 low = 0, high = 0;
 
 	if (!block)
@@ -976,9 +975,7 @@ static void log_and_reset_block(struct threshold_block *block)
 	log_error_thresholding(block->bank, ((u64)high << 32) | low);
 
 	/* Reset threshold block after logging error. */
-	memset(&tr, 0, sizeof(tr));
-	tr.b = block;
-	threshold_restart_bank(&tr);
+	_reset_block(block);
 }
 
 /*
-- 
2.17.1

