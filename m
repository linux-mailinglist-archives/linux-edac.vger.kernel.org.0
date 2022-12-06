Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DA2644A69
	for <lists+linux-edac@lfdr.de>; Tue,  6 Dec 2022 18:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiLFRhB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Dec 2022 12:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiLFRgg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Dec 2022 12:36:36 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74813C6C3;
        Tue,  6 Dec 2022 09:36:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeCGNetm6vBNoaMU12V+vN3f/qhfwtvwW/pFnxiRrnlAL8Ld0NdIhqiyE8oSbSh17waugMckR+vJEDiglHi+oDr2Mce2wFzmmBWfz3XG+LvHFw5UXFJzX/Ho/4yMCeJR05rDRabapTPpu1cUjSaleqDBtF2OX2QS1TZULzPq+YFNd7Ngnn+vh2WjqSYHojIAdGMZBCgy82h2YfCfd9s1DrkJ7MNifF7XvXvvsEbYH2X5/Kn4GxWVOf2yCegrJEo0X2bZepegt9NTkn7B17X1L5lBK0MerszvTheG5xRzTGD5twMB2W+VWd8dF3u1FxScYktwLj7o/icPAfoxoj7O7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2uhbHwX6osfXodb/30pTu0JPDjxF3b0MqtpuTEwQzU=;
 b=aBhilThseuvcUW6/97umjzJOSQpeG9REfn14F+pjoYQA+DgI851gQbeAPlD4lX/PLtFaYXN7gMK+k1F3LPQyQJHUfr8S0A+RiHUvizOmayPP/AnvsrkucBUq01RZXJ3OW4nYzC93R7JPqC8ont8IusmljF013jV/PfLz5+cmDh9eJL/bP/J0OVCJULSFbEiy40iW9ahBBLTyluMRcDZEkS4jv87NeXw2MKkldce/hzvU5a2q0Zf8C6/zqnyJBpQJ/IkqYe4AdpywyRSC8WdSNW/rU5++EQneNfbSW11N3bXxtqE6S+GOjoBr88mvlJ1KjbqHAjsgSCeOoN78f+OnKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2uhbHwX6osfXodb/30pTu0JPDjxF3b0MqtpuTEwQzU=;
 b=zlXue9MedjX9l+9c0cbwmrKmt7uxJ2oG5ctK/2GUDPC4jWM8S0y4IS34WYMEHiav/PnypnctLPwL3TB5JnmP/Ac6SutXxtE3+ORN4YGkxFUtcp5lWJdWfVXxjC+0Mg/LQ2HU7EfRg7bI16XY0pAxt1EpsDmG60QUE2XQbHgNdGs=
Received: from MW4PR04CA0219.namprd04.prod.outlook.com (2603:10b6:303:87::14)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 17:36:20 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::e5) by MW4PR04CA0219.outlook.office365.com
 (2603:10b6:303:87::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 17:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Tue, 6 Dec 2022 17:36:19 +0000
Received: from titanite-35bahost.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 11:36:17 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v6 0/4] x86/mce: Support extended MCA_ADDR address on SMCA systems
Date:   Tue, 6 Dec 2022 11:36:03 -0600
Message-ID: <20221206173607.1185907-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b87cc3-43cb-4224-37ca-08dad7b062c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRP91mPlCjPRk4VdcXTSUGyfJd5reB5ihAE/QgiDpeGhVhkVnYltn+ndSyKSV7ATTzQdgICCgw64CmRHKTqA58SEmJbKx5moiukLjScdgNNMG4fipNftl/ygnhJ+0lXmipVvXUkSVCL/eZJSOokQapI/MGgn6S9WJ4jmwCND+9tGoN+aoFmybpW1zLNYtFn39pGNc2f3eAHKqv7zgE4gbkazYaus+Hu9ly/r0gs79DYY8+E5yUaibGvyI3cMm6SDrwBirphhrPesxjwJeDB5PEG53XEECR1mhZ0ZwFSwoGY/Au42hVzaHfeAF4FoQ6eDiFVhyX+KWvVdmUEbIo2aBfPhnYVZBQA70UIZ4JUSA6yOWZELCiO1FdgaxMubXAbsYXe1gDTYoUFmj811P1gBMTSCPBLyWWwioKKtObdO0pcbCOef0fImqToPFP2oTi/fVlYQ4Mlq6FuGkTjvZwdecvx9t7uomIeqlz7Ex7VwDIZ4zLVRy8dfZQjJh5bXsl6jiU7RoWeTzHMbHtiavwSdUfc9EAZDajvFIrK9Ma12pMzmxoFxKpJBZ+gaT2XBjGxXhpIcTh9WFoUJuIxlQWZbfQ4R0ksZKHvlXhdgMQ7h8qVWp1wp4o9FaSmnWd6c7cXQBcEAI8qSllj3ryqdix5ujUu+iF5+8XuPz25HW2U9nsr2F44F97sIxVJ2QV9IN+GyjwfmDou+RJ0k3y2jqdIEqkGm1/jGiYNXs471bme+i2bs+CvX55+RN3tEzrM8AmT/Fun5gwANsiCpHewJdDnqCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(86362001)(41300700001)(82310400005)(44832011)(83380400001)(2906002)(5660300002)(8936002)(47076005)(8676002)(70206006)(70586007)(81166007)(356005)(316002)(6916009)(54906003)(426003)(336012)(40480700001)(16526019)(4326008)(2616005)(1076003)(26005)(966005)(40460700003)(82740400003)(36756003)(478600001)(6666004)(7696005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 17:36:19.5961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b87cc3-43cb-4224-37ca-08dad7b062c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

This series of patches adds support for extended physical address on newer
AMD CPUs.

Patch 1 simplifies part of the MCA init path by reordering and combining
some helper functions. This was shared by Boris during the discussion of v5
of this set.

Patch 2 removes another MCA init helper function and merges it with the AMD
MCA init code. Also, some other MCA init functions are reordered so that
MCA is enabled after vendor init. This was shared by myself during the
discussion of v5 of this set.

Patch 3 moves the SMCA-specific parsing of the MCA_ADDR register into a
separate helper function. This was originally submitted by Smita and
reworked by Boris. The current version is unmodified from her v5
submission.

Patch 4 adds support for the new location of the "LSB" field used when
parsing MCA_ADDR. This was originally submitted by Smita, and I've rebased
it on the first three patches.

Thanks,
Yazen 

Link:
https://lore.kernel.org/r/20220412154038.261750-1-Smita.KoralahalliChannabasappa@amd.com

Borislav Petkov (1):
  x86/mce: Cleanup bank processing on init

Smita Koralahalli (2):
  x86/mce: Define function to extract ErrorAddr from MCA_ADDR
  x86/mce: Add support for Extended Physical Address MCA changes

Yazen Ghannam (1):
  x86/mce: Remove __mcheck_cpu_init_early()

 arch/x86/include/asm/mce.h         |   3 +-
 arch/x86/kernel/cpu/mce/amd.c      |  16 ++---
 arch/x86/kernel/cpu/mce/core.c     | 100 +++++++----------------------
 arch/x86/kernel/cpu/mce/internal.h |  44 +++++++++++++
 4 files changed, 74 insertions(+), 89 deletions(-)

-- 
2.34.1

