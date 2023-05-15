Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7521702BA6
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 13:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbjEOLjw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 07:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbjEOLhv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 07:37:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DA91FC3;
        Mon, 15 May 2023 04:36:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhMdaFwC8o8EZlk0/6WPRdk1R1tSIjMtqPB6pRSqlpLjsoyQ4tUIMiQ+g3ofHKp9gIkGIYGOQd8fCe7uBwFsCKd2XqOE9qIlnPd6eh7Kx/jzXjTeKd6dHHzJPWU2lq/KhacWerzFDcFzaNg68NYaVdsd6g5bsLWHe6ko4kUbFaDQpZYwvNctQ8aVEt1v8tVOW+fzaJ1O2IjfPBLldEWROPXzyKHX6bWO5rwdoqhe0VpaVODSqIYKIRyGf3bpijWOQisoNAZc6OrzK/z+NYGP3s1fVeHbl1aTgOynZhK662tDwQ2t1UnlBPPbl/64k7pAOSisSowBGNGFgr2Y/BiYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jv3y6YCsG8EDFUiBjR2a+b2tK7dkUoQYbLO2jvIqSxg=;
 b=f2AR2CYP3rCLkUiYGEuLfuNe9WthWeZomQj64b5vUong/mWiOzei+8qBWZrrZ18hvRhAEf9DdQY742lvmvEeWIzVF/KrDaTKk0h8ykSQ+/2kqQOnbscnTjFOa/8F0wAiYb+nFCl6nzXXPZ2yOHpVM/29CaL8BN+mrz5ueeQWphBZbZ5q7VlVd/pFotfloTDGLw0bEcJzUEEdYHtNpPAxGIY9VxEt/49OceExKShagVupWa+UonXcTqtR5OM/p86sqoLKa+WLMei69sl05+HJ3b4TlpNrhzVRWsNRDIdgIa3Safngl33KhaubCVAIMfcCvAkTFzH/DOGyuPhR5Jm/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv3y6YCsG8EDFUiBjR2a+b2tK7dkUoQYbLO2jvIqSxg=;
 b=sg7c/u2knw8RO/EvPTwAKFjOb3SjjxHSbvmIjd9osbXia+wV/euRkOZ2WOkUx+RVktkK2v/++BjnAKrWjnbYaqLiJBdLliMeMFyRBYTx1Qm+69llsCofI/VgDzmSNc5X1n3kLHw7wmm1MNUmvc5OnleZvCvpt9JywP2mDWDCCGY=
Received: from DM6PR02CA0131.namprd02.prod.outlook.com (2603:10b6:5:1b4::33)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 11:35:57 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::7d) by DM6PR02CA0131.outlook.office365.com
 (2603:10b6:5:1b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 11:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Mon, 15 May 2023 11:35:56 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 06:35:54 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>, <nchatrad@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 0/5] AMD64 EDAC GPU Updates
Date:   Mon, 15 May 2023 11:35:32 +0000
Message-ID: <20230515113537.1052146-1-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3b6dbc-63ea-4ae9-aff1-08db55388cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCjsi74h2XK5dnfAAJAD3bYwCTGs/D4o5gtRtMsU3leulc+MilX0rarFADGiVFyIaMjDh1JBNuuLYBPlW8tG/xp7Wn3/er3YvxUbqFHMX4FEwmQrSsVnh48xhlw94M2V6/NCFnODHMSTQzjue3QEzguAipZAfoqNTyforhRc/UVmx/55yfU/vLbpx3i33kOw1gDDRFJzRrg/Qjn1k/howH4KSYQi1GG05uOiTSQNUK6zU6PxCu1pShcoFh6HELDmSmIVatemjy2A2B2I9LdDaIKOMgooqORzgP2pqXJ/ODn3uVJPgQW7+xW8hzYAGleC2tMhSuVeIfXDLOgMSSgwUzJW6cQXEsjdxGDZM9APdLVLCyLJvtN18W0Mh6MKqZPDna+xLS3wBVLoGzVjYZ24cqTj/f1NhdGMDVISxAVlUs35t2RCn1wcppf+ycLDVY5B1pp/BQpuIK2IjFmJ+Hnoe8jHv4fUr8iZGoULg83wzXyFtYRghptinwf0InzOKLHcDvEmDN3umdiYtAv9+Jmr3lfGsN3JKxYdAqQ4UV+X6L65ecFDAOE5M1HMjc9DOI6M+ESQ4XlQ0Jr3L1tgUuawi6vHCdDlGKkhyOlFyszqHwncIlwGF1fvs/5NDs+HUiTaYtd3bFE68w4DU8VSPV6zTPqZ5unDDibO9ftDWjV149BySaPiKBORfdIUaRv4mxBGh7bfdn8ovROeGgXlC6ueSZwCiCK9LoEOu503WP9Hps32ZPzpTyNCUwUH1YdRM6emU3d1HG2yg+yQiLBpFXzcqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(336012)(47076005)(83380400001)(36860700001)(426003)(70586007)(70206006)(2616005)(7696005)(1076003)(26005)(40480700001)(478600001)(54906003)(110136005)(16526019)(40460700003)(6666004)(186003)(15650500001)(8676002)(8936002)(5660300002)(2906002)(36756003)(41300700001)(4326008)(316002)(82740400003)(356005)(81166007)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 11:35:56.9326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3b6dbc-63ea-4ae9-aff1-08db55388cb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

This set adds GPU support to AMD64 EDAC starting with the MI200
(Aldebaran) series.
The AMD Instinct™ MI200 series accelerators are the data center GPUs.

Patch 1:
Adds PCI IDs without changing the existing AMD NB code.

Patch 2:
Recognizes the new UMC SMCA bank type in the decoder module as just
another UMC bank. Decode details are done in the AMD64 EDAC module.

Patch 3:
Adds code documentation on how the GPU memory is laid out in EDAC.

Patch 4:
Adds the bulk of the GPU-specific code.

Patch 5:
Handle differences in "AMD Node" enumeration for GPU dies.

Muralidhara M K (2):
  EDAC/amd64: Document heterogeneous system enumeration
  EDAC/amd64: Add support for AMD heterogeneous Family 19h Model 30h-3Fh

Yazen Ghannam (3):
  x86/amd_nb: Add MI200 PCI IDs
  x86/MCE/AMD, EDAC/mce_amd: Decode UMC_V2 ECC errors
  EDAC/amd64: Cache and use GPU node map

 Documentation/driver-api/edac.rst | 120 ++++++++++
 arch/x86/kernel/amd_nb.c          |   5 +
 arch/x86/kernel/cpu/mce/amd.c     |   6 +-
 drivers/edac/amd64_edac.c         | 386 +++++++++++++++++++++++++++---
 drivers/edac/amd64_edac.h         |   1 +
 drivers/edac/mce_amd.c            |   3 +-
 include/linux/pci_ids.h           |   1 +
 7 files changed, 488 insertions(+), 34 deletions(-)

-- 
2.25.1

