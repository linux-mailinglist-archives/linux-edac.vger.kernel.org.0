Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059D84C7177
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiB1QO6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiB1QO6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:14:58 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233D74579F
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2LB3AMzw1loA9tKYPu6d5NaUMWSUqrc/evkY3z+avcbD0aSroghwt+1/VtsB2dG1DxF211YkQgD2lWrpAAISC6byGyxtwjuwjMJWPVkndFvksQCO9aJ5nxn5aIWtQXahVZGWLBrAfjAY2oKAtcENNceRB912XybIx4XMlcFro32jk4vCaVbtFSmWUfA5iWujlQ//DqtC7Kmxt2nT2rQ7Bthi0RzIxOX0EsTcazVT40p1QsvXMe1bvqdPiVDdpBffqOCnoSwqw8n45C0yIBgREFqczBGCA+1TvCtJJPYnkjOr0pzGsbVqE0i8d8FDHCITfbzWLxTPfjSJouiV150eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fU6Q5hV9OzGjiVjuR3wkHbxuLJs5w1ij6Y0AWMjJVH4=;
 b=MCKMYGt4yq1Tcl5V2hep3WxA/9CmPUrXCZmmFbd6tqB+0y/jcOamvywyuvf3NTcP7nq/rl5hvgfCyo6FKPR55NVjTfh1DhSGlTnOYYlw90KFGJyN3ZxFW87LkNb4slwDaTejWvYLze+ZzW/lfNTzyPG5AwNWgg7EhQo5u0q7BrYJpiDN69mZYg5YLmt69w2vRsXTrAD/ZpDsc1zorPZE5e4rWfuo/Uxw9nYT8Uhe4aAc0Z8YzwB6DEED53X4FznMljRTwQMg1xg7Lm+1QbJBCOcG65E2eamUjdxQRLexn8yEBsQL+GKrBM0sl3A7Qorae0yOexAROgLMpviODF0rwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU6Q5hV9OzGjiVjuR3wkHbxuLJs5w1ij6Y0AWMjJVH4=;
 b=ntLYvoBaBU64n+SJxBa23grRGQJphFEOCsm88TAt5F6jmcmwi7IM2Gil9ifov/OUXOlP+nTg7bewNd1eha90bOW9o66hC0P0vCEf11sqq+H8914khTabKFnmy0p13bIIT5MMHPZFZpO8yYS+xjDz99/LIm0U3YVgREakzzfItKQ=
Received: from BN9PR03CA0080.namprd03.prod.outlook.com (2603:10b6:408:fc::25)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 28 Feb
 2022 16:14:12 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::97) by BN9PR03CA0080.outlook.office365.com
 (2603:10b6:408:fc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:12 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:08 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>
Subject: [PATCH 00/14] EDAC/amd64: move platform specific routines to pvt->ops 
Date:   Mon, 28 Feb 2022 21:43:40 +0530
Message-ID: <20220228161354.54923-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d62654f-363f-4e17-194f-08d9fad55bb5
X-MS-TrafficTypeDiagnostic: BY5PR12MB4051:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4051276C5BCE0D4CD58AD8E1E8019@BY5PR12MB4051.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1CQQy3+MLVUW9Fn1TbSbQPFlM+BsM9OaO5pDT/B81SfSyH+HyUdYwnEEmDLf76DpgqjMPHsIFjDIcmK4Bxo4ZaTYUNbOTx942lCyuwCikGdVLv5RSLsocmtt4O/V4ijvZCm7gVGWO6aeQxlkq2gAB67rkeHvPTfPys3TmdVa6+7ZHKhMGHLnqK+KR7gJ96XZ7m1ooXrpTQtcWFQunAizm4p6Y0iPxoJJwZEc8q2Qnohc5HiEipaaugJ3cibP3yU1X2Aje4eA+Daph4pTUPO78Q7V6R7/+s6JfNyMOtIhkGRD9XvhWk7O2ojYm9UeYlmoiLnr/ZoJL7iGKBG2drJ6ctrzvJwsZMw28vErBygV9W2055hnwZTpD0stOvSAnpTTcwG9Gu38PZ0RN7B/Er1LhyOLU+LMEB2HyVacCUXVfNz57DV18B44Twu6YL7nFxJqd8MBpe14gp6ji0BQgAIqcUEOw3USesGI3KbOVyqzE8RPCapCkwzkQjCWwPSzI/E+B4wohqT4VnGABswrT+acRQGHl3Z1/gQCAZ75FBnd9B/5xt3oDwsR8euKmq70dujPmBF0ytIXuk9RzcGHzurhdml2vi3/b6AoXhfvM4L9ma6wGgMO50QC2W0v0+qB6SbS3Atjd0lxU4jsjvM8YM9xP802ECiLBPQT9ZoW3wKuC+3V6iWerUK7QZqUkj88hYlMzcSrYXD3H87if86DKJUSP18pIxX1al5jJtk2cxuM8NwImX4wRtkUMgSx6pajryUjNaTey6Ihe+WX0IhsnT+JmFBxLUWSfOv+Tpc3rp83gaUM7DMnxieEEt1B36uxSuSlWraKn6PQYNUGQHvqJUvlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(47076005)(70206006)(83380400001)(8676002)(4326008)(4743002)(426003)(336012)(186003)(16526019)(7696005)(1076003)(36860700001)(2616005)(6666004)(26005)(36756003)(6916009)(316002)(54906003)(40460700003)(8936002)(966005)(81166007)(356005)(82310400004)(5660300002)(2906002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:12.2271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d62654f-363f-4e17-194f-08d9fad55bb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

amd64_edac module supports CPU family/models ranging from 10h ~ 19h.

Define family specific ops routines to make the code scale well for
various platforms, also ease adding future platforms support.

The code in this patchset is partly reviewed
https://patchwork.kernel.org/project/linux-edac/cover/20220203174942.31630-1-nchatrad@amd.com/

1/14 patch in this series is the 4/12th patch in previous v7 series
[4] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-5-nchatrad@amd.com/

[2 ~ 14]/14 patches are created by splitting the 5/12th patch in
previous v7 series
[5] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/

This patchset applies on top of the upstream linux kernel.
Each patch was built and tested individually. Tested the functionality
on Rome and Milan platforms.

Muralidhara M K (14):
  EDAC/amd64: Move struct fam_type variables into struct amd64_pvt
  EDAC/amd64: Add get_base_mask() into pvt->ops
  EDAC/amd64: Add prep_chip_selects() into pvt->ops
  EDAC/amd64: Add determine_memory_type() into pvt->ops
  EDAC/amd64: Add get_ecc_sym_sz() into pvt->ops
  EDAC/amd64: Add get_mc_regs() into pvt->ops
  EDAC/amd64: Add ecc_enabled() into pvt->ops
  EDAC/amd64: Add determine_edac_cap() into pvt->ops
  EDAC/amd64: Add determine_edac_ctl_cap() into pvt->ops
  EDAC/amd64: Add setup_mci_misc_sttr() into pvt->ops
  EDAC/amd64: Add populate_csrows() into pvt->ops
  EDAC/amd64: Add dump_misc_regs() into pvt->ops
  EDAC/amd64: Add get_cs_mode() into pvt->ops
  EDAC/amd64: Add get_umc_error_info() into pvt->ops

 drivers/edac/amd64_edac.c | 793 +++++++++++++++++++-------------------
 drivers/edac/amd64_edac.h |  55 ++-
 2 files changed, 419 insertions(+), 429 deletions(-)

-- 
2.25.1

