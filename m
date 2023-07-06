Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B8674A2E4
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jul 2023 19:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGFRNh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jul 2023 13:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFRNg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jul 2023 13:13:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD3B1BDB;
        Thu,  6 Jul 2023 10:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=divD4YzwxiEWckEc6waDpleNPqeo489+c/4MrIwjcAs9C27MloIPIOjR5UmbtqhA/LeUzhC4jqftn4MU7qbLlW/8D/hHHr02VhLcVt5sdZSVq9i0XfXlwfoi8hqT8Ct3tEadlsq2oYeFgHFoaX95Nwfy3W+Z+5I4ic+NDsBAwqrmopHeP6oPAwuoObsn7RKt6lNe3ykqHsavG97/okTrXd5IpAYl2Vi0PBGJ8TGtddk8pByRW9M/3tgbHak7GVerD5NyhlObwlAoalImcmlJfO4isP77Q5rmwCgq7PYTE8T+guuVZg+ghJI6eRWRvYUAPxdolyggv+PyUj+9/F3aBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw645N7kR52eUrNIef4cgEkKBT8/IMhzfITiWbKe8wg=;
 b=fQlf4fNlF31hg3ieq/K8BdDQ+0UF3Gawo6jn/0mr4VJhnUAWg3j3KlljbsGp20gMD9NXN6Xst5oYlbtv8Asf48lb59mXSwLjV9QWjOM6f/wqGE5323Z0rbfduAWRfczCncDV/vfuqxleuCNeTGLj2DJef2UzFpWrnTY1gMLTuWpRa4ZDXwqA+4q7R+jRUsELDkFiqQcaEb8GIhVVjUjYUowOS+buf3eowSe/vsc5RXw0Re/YEQVY4OkiwB3y2BzsnDjyYemjP+dLLq5CM1EgrRD+YArNDcydTdhE+iwS7QKYsYZY/0po7EPQhV4Dtauujdtcv27HktXoj5LoNY9WQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw645N7kR52eUrNIef4cgEkKBT8/IMhzfITiWbKe8wg=;
 b=Lt1kMFOYUtLUgQp15NNdCxEjLxYmczeOoWef4vltg7m4hJWzL43HMG+3SYp7r9ULto7KyepjgZZ0WgbrrOtD1phEo/f3zSn3LRhlF/Ho/iqV0nnKFd1MA5BTy18/lBzThS95LUYKdKwGmHiR95lMyTxM8ZBvGmWiglz50wOuOds=
Received: from MW4PR04CA0071.namprd04.prod.outlook.com (2603:10b6:303:6b::16)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 17:13:33 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::52) by MW4PR04CA0071.outlook.office365.com
 (2603:10b6:303:6b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 17:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Thu, 6 Jul 2023 17:13:31 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 12:13:30 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <bp@alien8.de>, <linux@roeck-us.net>, <x86@kernel.org>,
        <linux-hwmon@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        <yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v1 0/3] Updates for AMD Family 1Ah-based Models
Date:   Thu, 6 Jul 2023 17:13:20 +0000
Message-ID: <20230706171323.3722900-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: edeca98f-066a-4561-edd1-08db7e445325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3sO8ADurBztOqqVwUyb4TzHXTmVblwQCxhMeLiBrnXz5h35fx1DeSsoMHKYbz434gAoH9AqLPjJpE8b2y8uKnd0e5jTIgsxCm/U1Tvf0wMqMVLfEC9WuU96t3bQKcz63BoPdpgPL8a0Yvi5Uh+7d0BIu7WvTy1YHHAXWhAzAJy2IB37BBTsWVBxNuwQnoiW6b4HjWJeZAA6TRzAO00z231v2Ixi8TNHeTrGdGLd3vrHKN7vxuuwLXoL9rLlHzlfi1f1kr5yU+/gkx+rQMSaA7/Q+95+EE/YTFJ3Rbv/qhuz4WAt3EhOmJyP51B/36O4nm9Tz/Ukzp4sSRcSFxnAB6NeTkkrYqwtSNTL6t6c6nmjnPaSyFsvDAPC7H1vsY2shq3Q6YiDvE2Ocvy44Wso7x/bRPWZahOETmElwHWKoHe7ubZkvG8X+Y4uPKjrepX5p0PLrEPnW0LPpS7de8exJgQ6Y6ya4ysvIpb8hz5uEBz1Wkbf3UIAAN+sbqnLFrJ7dfcUlScT1t1TfaQo/vYrsdSoi3jnV0j/6LZ9+hdpBaw0q4JcmleXcxqMWrR2izGM23JJPjL4jd9W4hXR60sLfNVK3xiU25sjtwTBZD1TYSLgnM0sBvcJOV3fslhgCkW9VgdY5mjkLsW2oYiZP+1bgtEyxwoe2NB+xDWmF+bjGGgQMEwb/8dr5ZA2CxBAC0/DVUb99e+jLscY9k5LdRUXeHP6P5ZDnXKBOkwG4CAibN3+rjl++ZkS8qwCueV4NFneyImMxEyVkiuECpZnvkf2c6f+ZFX6t3PN+TOZtBMcbYbo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(7696005)(478600001)(110136005)(54906003)(36860700001)(47076005)(426003)(336012)(2616005)(83380400001)(36756003)(86362001)(40460700003)(40480700001)(2906002)(4744005)(70206006)(82310400005)(16526019)(26005)(1076003)(186003)(70586007)(356005)(81166007)(82740400003)(4326008)(41300700001)(316002)(8936002)(8676002)(5660300002)(44832011)(170073001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 17:13:31.9209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edeca98f-066a-4561-edd1-08db7e445325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Avadhut Naik <Avadhut.Naik@amd.com>

This patchset adds support for amd64_edac module and temperature monitoring,
through k10temp driver, on AMD's Family 1Ah-based models.

The first patch adds the required PCI IDs for models 00h-1Fh and 20h.

The second patch adds the required support in k10temp driver for AMD's
Family 1Ah-based models.

The third patch adds support in amd64_edac module for models 00h-1Fh and
40h-4Fh.

Avadhut Naik (3):
  x86/amd_nb: Add PCI IDs for AMD Family 1Ah-based models
  hwmon: (k10temp) Add thermal support for AMD Family 1Ah-based models
  EDAC/amd64: Add support for AMD Family 1Ah Models 00h-1Fh and 40h-4Fh

 arch/x86/kernel/amd_nb.c  |  8 ++++++++
 drivers/edac/amd64_edac.c | 15 +++++++++++++++
 drivers/hwmon/k10temp.c   |  8 +++++++-
 include/linux/pci_ids.h   |  2 ++
 4 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.34.1

