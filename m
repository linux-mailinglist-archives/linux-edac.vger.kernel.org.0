Return-Path: <linux-edac+bounces-25-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DB17EBDCE
	for <lists+linux-edac@lfdr.de>; Wed, 15 Nov 2023 08:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CBC51C204F9
	for <lists+linux-edac@lfdr.de>; Wed, 15 Nov 2023 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594082E856;
	Wed, 15 Nov 2023 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pv3A55LS"
X-Original-To: linux-edac@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5836C5247
	for <linux-edac@vger.kernel.org>; Wed, 15 Nov 2023 07:21:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09F0EB
	for <linux-edac@vger.kernel.org>; Tue, 14 Nov 2023 23:21:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5UKIUfpgwF7dhMDunUkfi9i8a649QHOCzLIwK9UtcUNNmToG/2W1XN25cLeBm1UxDSVlZbWIwGsU05xpN/irUBUI27zwYkGDS/qWC6z1yGHrPOEpSXtPtMvbX0RS4xFN/hnqi/HkRHsUDMT6iuHNIZgg7FQZfc67j9j1TX/z4Yri2KtL72AsuqXNuM4eJFjDAC9MvOwovlbN90mGF1HfZE+4vgDP0v4qjLDSSC//snNdkFfgstLkjQyphajRU9d7HhR5gwd6CoUF0q5MTjx5ABUE+HlJ/VfzsjxrqSrh7cU/9sue2pL6DKpxBHx8mcgSxS8Mr9nvZJJ0R5360M2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBOdGmnxivM4q5AITfny6LecykwKmEf+kY33gYMbuXI=;
 b=BcU3BeZKASFzSHubblO0RPI/IAKu91RasrPlPjhQ1EjlRzUAdw9+rOgHZb1wx1gQ47cVGUTCFjzY8wlu31dYUg+qEuAq9wHs2RsFBTBVu+2A+33RYI8qqqQI/gdzgi3hE0hGVndEt/koXZkiHLtoKP0Kt1kTjOb/QJCaKZ5NAqw2QKDm3Y2zJNYDquFvL4PnVLj9kaCnkCtAsIXqac3BH8hKV9cJJWTMTOxprhAjy9W16LeVMSPiAN2PkXKa9g7AO8dFHGiiCMQQhW+Ml/4MgpS2Fl42kSwBsum6/fmvOPbJ2fMxhvLQi13JtTfcE2Knm1xxjP4Wot10xBQ3oaLHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBOdGmnxivM4q5AITfny6LecykwKmEf+kY33gYMbuXI=;
 b=Pv3A55LSrxoQMixWMzMIQ9+fw++Rd4lPV6MBqblirofWra0oIoLGaEclvh6l00m9dRAIGbMpwTm1h5LuAu2LIbAjQ41FhS/pIpSfbfaSmjYdMWG2imzBV6Pfi7Cq5xNtUUjwe8jSwqgNyrjVI/+iWWNb9LF2NEQC6kgxSNc634o=
Received: from DS7P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::17) by
 DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.17; Wed, 15 Nov 2023 07:21:12 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::62) by DS7P222CA0005.outlook.office365.com
 (2603:10b6:8:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19 via Frontend
 Transport; Wed, 15 Nov 2023 07:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 07:21:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 01:21:03 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 23:21:03 -0800
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 15 Nov 2023 01:21:01 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <sai.krishna.potthuri@amd.com>, <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>, <shubhrajyoti.datta@gmail.com>
Subject: [PATCH v2] EDAC/versal: Fix the read of the num_rows
Date: Wed, 15 Nov 2023 12:50:55 +0530
Message-ID: <20231115072055.25373-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c573654-2dd2-4285-99c8-08dbe5ab723f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	luzfeP9JRhmuWuAlbhhbXqfJnt/EX853d0kainwnCmNaSmOJmJ7IhisN3c3opIOaxWeoXJAgxvPRZvFWVrLogZHlqP3TkeV9HIYrsSpIYxok50nGMS8q58Yg+5udgLEJUZErmfEgD756+GLbrQp6QzLYou9EbI1yygLbRybbjYRIswYKdmm+YmLTeosbCPavk3h3Kl5ykmeoMH3ebH92ItPHsbPVBrrRYiJ93BCdaxIClV3q/P1fcEaD7GEday5ISmut1nGNKbst3z9wEIobjCdxeiL4vpjo88liQ4msOdja1wKCiWmf9bMJe786oSvG7J6DTVsYXeB3GCIHEAzkv0q2nid1i8fI0JgaxqBMVEjnWVsT+d4aIasiNYPPKLwz94SIppNk6wp5V3P+Ywpupo42+Jor9EXPzXtYxpAWXH03hlH86LpaIUztaVEFGP7iOAJNLVH/z/hSylDz1vqNz5/2wS5YhRxoPjHkDcWQknKm3g2T6FSrUUQr+8pU5r/9GvwDNO8uXWSt8KiAPMq9r/qjxgRljCYNZi+qcBwYbv2VAjC0jDNb9CeJmbgJZZfKwoXa6np7KUisI35/+BD7mrTBWGlTvTsvcQtctY86QdIi980U3tjRPuWhzRXIMlBAKwXU16QZmTJSXNWzut2Baw/GbKj/TYztASmByfJouysMiFNMguYF0cBvBpvA0yuKOtBzX2KGJKeHWLBiay34dL4dCSRIAvOgbtPexPdZyVNRxi++B1Obj1xz5/mXEiFXhvh65dfKVeJGZLc7YPNWKQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(82310400011)(1800799009)(64100799003)(451199024)(186009)(36840700001)(46966006)(40470700004)(82740400003)(2616005)(426003)(336012)(40460700003)(26005)(1076003)(478600001)(966005)(70586007)(4326008)(44832011)(36756003)(8676002)(8936002)(86362001)(41300700001)(2906002)(5660300002)(70206006)(54906003)(316002)(110136005)(6666004)(36860700001)(81166007)(40480700001)(356005)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 07:21:12.1058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c573654-2dd2-4285-99c8-08dbe5ab723f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238

Fix the read of the num_chans and num_csrows.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/60ca157e-6eff-d12c-9dc0-8aeab125edda@linux-m68k.org/
Fixes: 0fd934580ea3 ("EDAC/versal: Add a Xilinx Versal memory controller driver")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
v2:
cc the mailing list

 drivers/edac/versal_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 87e730dfefa0..8625de20fc71 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -966,10 +966,10 @@ static int mc_probe(struct platform_device *pdev)
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


