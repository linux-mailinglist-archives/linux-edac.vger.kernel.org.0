Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C4D70D408
	for <lists+linux-edac@lfdr.de>; Tue, 23 May 2023 08:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjEWGdq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 May 2023 02:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjEWGdp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 May 2023 02:33:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFE7118
        for <linux-edac@vger.kernel.org>; Mon, 22 May 2023 23:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjDRITnvif0Ej9NhGlluMD8a8A3gVzZl2xkcEqUx0dmGCZtjIXpaJMadP15QyHUStqBMy8/dbodfgMC338QwCbUAzvej2nTLiHIABYn5+Y3NX78YrWgFYUkuE6q9e0RQ8NJnR5fUKqa3i5Buf4552R80S7Rr8ZpIUYsylliGyTiRp3kq0ncUXJxhneSeiNmbwELXNNKhnieEZfRHt/4qOgoCX+/KIT4vhlEoYIZngZe6CBC31sWq7jN2T1Y4AUFl0SOG+NlY39wMZeOzL2Tt/GPSXI3ry5UCyredNIwc9aS1vdz28FKLKvNp++ti64Muv/9vsX0MS/8J3XYwUnjIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GTUMthoWxVcRcMqwqSEsKOwjUJDGcYMy46RlupbmYk=;
 b=AMblZeh9yxsHI7/zpMkxaYPrp2PYeOfoPuZr3MpNNCUVwOLmMuY6BCoU3HbaBryTAhZ2UmTaN3J1ksN6BtIn6vv++uj0QsYBlLCIEzcgoemvWO93S905N6cLZDyfyQWQPw2NMlaXJBwSOKWdrzNGKknLQgXtq9MdVgsnnKlIayzF3OTIzOv3JNngCDE380hH8TC2hsC6kPEsTR66bXoMvX7JCVjHxWqnWldz5hinqX7/svIWOENBnKhMYczWP7RiPkpoOIe7i01E5DBXcjG8zD9fovl/aVYnssdatIDWP8DibWixChguHhDJPyxoocGYdoMravHR3auIVtJMrm2Jfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GTUMthoWxVcRcMqwqSEsKOwjUJDGcYMy46RlupbmYk=;
 b=X11hcHpuAmaD6/grWiuSw6x/uYmVVsNGS5EHNN4ubPVIda5bG1TcZzKaSs7Ur1sYlKeo3m3JZ+QbvZH8AQjp5jHJNTY3YoejQpEGjKZ5TahTohpqTaiBxZ8M5G8aPs25bgAcYK2Sgn+n6wW1YacJAfaZu5ohxtZJYc6xx6ifr8A=
Received: from BN9P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::21)
 by CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 06:33:41 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::d8) by BN9P222CA0016.outlook.office365.com
 (2603:10b6:408:10c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 06:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 06:33:40 +0000
Received: from BLR-PF38F8CF.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 01:33:38 -0500
From:   Ayush Jain <ayush.jain3@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <Narasimhan.V@amd.com>, <mchehab@kernel.org>,
        <Kalpana.Shetty@amd.com>, <Yazen.Ghannam@amd.com>,
        Ayush Jain <ayush.jain3@amd.com>
Subject: [PATCH v1] Rasdaemon: Fix autoreconf build error
Date:   Tue, 23 May 2023 12:03:11 +0530
Message-ID: <20230523063311.4900-1-ayush.jain3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|CH0PR12MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: 2590c6a0-57ea-432d-8bbe-08db5b57a619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdfQicSJ65GooXPcdJUVMLBj1/uzz3oz5xDRMQ5z+kbwBTDtYKB7qjx8ofMeEcbOP9W6r+sNEXgTlToxpW5LvwB1rNEbtAQ2OhDeZPQXeaVXwlAw0JL2mpYrVzRQVbnEnDadE+um7MdB+DOEzRbuAEA8K8kyjljW0dKkaztyu2qifkDlXI3YKTmXsghMsU5wQnM7RUF0v5Pu8OxNayTzrweUiNXw1scxzrkIJ9Am16A7HSQobM0KN9EzcHst3/mVwwOAYwbkSA+AEAqcj95k91C9l3+J7T7yVmNGv0BNBNWWCDsYxJL8T5qXSpuN8naqHm5m3IcZEhUHhNi8gRAfoAlzjF7KOnQmDek8z/jN2tGAQCDIQzEsVlV6sYAdJvsYlMAEhRlUWiuBCmZ4WN8Q0bB2I89cHveYqU/z4X2AlQsPmIsDdmXBVrgdC34yViJJbNMadVXF5sNJEyLaER1yQ8rbR9hESXiR0dhc1Ox5TrJKEKCcrNckXfLEw9pDK8jhkU0Z6iSqGTAmuqK4jVs+DDT4x1vBBC3ekM8xU43tkzfEPHEYncNCjVlFTErejzpe1EnsNsTEAGSFBNqnpRSqTvfB56aNKd/k5ltZnOP7n08tXV5HLblHD9zMuF1OOfzSLlQ0cnpS2mta2JzPzFBzenJuyp4Ykwf9wyDwZrmpEx3dmUm9pyHHgSSbQEE0GEOnOyLmd5r2sxO2psjBGvXg/YNZGQ750J/5GXg9g2b+nvoGYx3wlTXY8eAYktEo1Dt/JgHR4CPd1i/q8OCtvKfVWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(40460700003)(16526019)(26005)(356005)(81166007)(186003)(1076003)(4744005)(2616005)(36860700001)(47076005)(36756003)(336012)(83380400001)(426003)(2906002)(40480700001)(41300700001)(7696005)(316002)(54906003)(6666004)(82310400005)(478600001)(70586007)(70206006)(6916009)(4326008)(86362001)(8936002)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 06:33:40.9719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2590c6a0-57ea-432d-8bbe-08db5b57a619
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5251
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When building rasdaemon with autoreconf, on certain distros
we see the following error message.
Makefile.am: error: required file './README' not found
Autoreconf looks for README file instead of README.md
Fix this by passing 'foreign' to AM_INIT_AUTOMAKE.

Signed-off-by: Ayush Jain <ayush.jain3@amd.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index ab5697d..7b39f59 100644
--- a/configure.ac
+++ b/configure.ac
@@ -3,7 +3,7 @@ AM_SILENT_RULES([yes])
 AC_CANONICAL_TARGET
 AC_CONFIG_MACRO_DIR([m4])
 AC_CONFIG_HEADERS([config.h])
-AM_INIT_AUTOMAKE
+AM_INIT_AUTOMAKE([foreign])
 AC_PROG_CC
 AC_PROG_INSTALL
 LT_INIT
-- 
2.34.1

