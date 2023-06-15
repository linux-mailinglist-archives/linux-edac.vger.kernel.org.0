Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F509731D4E
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 18:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjFOQDt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 12:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjFOQDs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 12:03:48 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39132949;
        Thu, 15 Jun 2023 09:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF10iPUrN89r4bsuTp6cvzo/bna6ODGe5tinJmJLud1EknP6O51RjCrhoLNW5SwmPzfjgBUFA/QSVLOe0P+0WKOn1l0jJIFduADqOfTjUxhvOV8hfdriWSzEsRN93+7r3PP0nWtJmOEZyZTk7TtSO1pJv62pFeNLpg5i92pGW01WsdyA5tM8z0wAOHNfIWXtM8/xUFn3Bw3oLZTMN4MR1FwQtGZnMGlRIbztLggr9GhjbsiZy8QGKGxnAzMaUvZaSEsG2v6Lq8k0QvwrlJdsMjvmqP7F4mQHvdh7DCydS8gmkUP5CT/cw9kXknRaqJ5u6DDX7pOYzfGSOiZ5SbnlbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwfmRat6pSPmipJfebHfzfpDPiivE7cYJpA5bsx71Rk=;
 b=SmNhxDRdzEp7Q2t60yGet37fl5Uk7QmAR8Jzgx/bKa1cCW1eggoazosnIEcMhPmGHTx2V3fKGcWg9XKlIr7B2dUB93JW4OiUmRW+mnbXN2JoJK4JK2oj5C1myta4vESPbAuyWoub6Ivctpmj5AgQ2vulHzO7bTuAzk9ckEOvP2kIbpqFN1JQBPuspicaklKSF0oJ+tuXGTfDDyLoPf8GPXE7NTL2o1nUMDnThZkFF4iD3yGnFlam8g0CymZ923TJaXCw2xi2MFnp328irAOEr1GcFQyKY5LJdV8fEl7SiQS09QquSwnnZIt6yLEy45tv46Amr4XohSgXzEotWNv1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwfmRat6pSPmipJfebHfzfpDPiivE7cYJpA5bsx71Rk=;
 b=T/McAkHdXq68VytYq4pkO/oj/e0rP1O1LRsFWjw6UsJASd6YosKxZzqFUCu0djAOabXcKQNgMWhvjoh3haf4ECmM6uk2/WvMl7g9ba0EYrUbHmfC6vs0Oyo2IJ/wuWhy1CcIZqfCMksTxDdsxg8NbACVbh+0hXgggjggmu4LAA4=
Received: from BY5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:1e0::12)
 by DM4PR12MB5216.namprd12.prod.outlook.com (2603:10b6:5:398::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 16:03:43 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::4a) by BY5PR03CA0002.outlook.office365.com
 (2603:10b6:a03:1e0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Thu, 15 Jun 2023 16:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 16:03:42 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 11:03:40 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <markgross@kernel.org>,
        <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-edac@vger.kernel.org>, <clemens@ladisch.de>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <mario.limonciello@amd.com>,
        <babu.moger@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 0/6] Enhance AMD SMN Error Checking
Date:   Thu, 15 Jun 2023 11:03:22 -0500
Message-ID: <20230615160328.419610-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM4PR12MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: 773b05f6-2655-4c89-eb9e-08db6dba1763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIuEhsn03fzKaFHCUuaC18BglDoiuvpnMJ3f/NE2jJO95WEbMlj6HIHPhGTPWG+MopbX0iIG9djMerQ+kV9tVowjfD8j42W2W/hKkoOEFOiiQFxHQGdMUBjErvRfBgUlKpehcKNpaClLrr99sj7j5GJwfwcKEgpwLhG1xNXhBaZ/HQmE4oBv32Mr8GHMbGJHbxAqzrjG3VOGRQICd4CxmIC0qgqjuoPSIT1qTJs/zmNirbaapFbjPr7xNSwoZDuqs6cI3xJeu/35U04I1ZPPW2FFdjKErHTvphqgzR+q2jVlTxODuFM7PWJpeOrQwilmneFICX1CLoO3SxPfGW6xuUgTqIeNBgfDTprgfYcmVpwu5RE9WamEfYYL15C8O95FzElfSMQvjDl8pXuz57JLWq1FQtmFh1YeYN5Zl1S00X6Vi2F93PDWROa7yD6blEAi49tHkDd1bk+FDhajTUa1rvDKy3LW3KScQov6429DlDzGu+EunFzZiV77jS9VHFqsDCkN0DEegUf0Q7uP5jh4IvHV6gBidNtRYCSBOT4Xqk5AF/kDCjVt7NE8PeJMMNJ9UgQog8tm90XTzN2F7RlZnHJhz72M9cdv2yHVXizurKdySGpHn0ymSKvj0pHgXZhb2p7jdTqU+YHwhNRAYlKmHHc2I3mPRSJksBiU21c+VYBGyUcdpUURegP+vZ7S1iGApxYGORahhpRllb9WvV/FpZQ8DnbefcifrfVta7pI/NYouFVxzGAiTHe9+QH/MrDsXJFB0nxzwYR5fd1B8ILd3xDW/PYGSRJ5n6S4KfQdaYE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(7696005)(8936002)(26005)(40460700003)(8676002)(41300700001)(36860700001)(478600001)(81166007)(36756003)(82740400003)(356005)(82310400005)(4326008)(70206006)(6916009)(70586007)(86362001)(1076003)(316002)(54906003)(6666004)(40480700001)(44832011)(5660300002)(83380400001)(426003)(186003)(336012)(16526019)(2616005)(7416002)(47076005)(966005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:03:42.5419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 773b05f6-2655-4c89-eb9e-08db6dba1763
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5216
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

This set implements more robust error checking for AMD System Management
Network (SMN) accesses.

This set is a follow up to this discussion:
https://lore.kernel.org/lkml/20230403164244.471141-1-yazen.ghannam@amd.com/

Patches 1-3:
	- Pre-patches in AMD64 EDAC and K10Temp modules.
	- Required in order to avoid build warnings with the
	  introduction of the __must_check attribute in patch 4.
Patch 4:
	- Introduces __must_check attribute for SMN access functions.
	- Handles "PCI Error Response" behavior for SMN reads.
Patches 5-6:
	- Optional cleanup patches in k10temp.
	- Not required for the SMN access issue, but I thought they may
	  be good to do.

I've included x86 platform driver folks for awareness, since there are
some AMD SMN users there.

Thanks,
Yazen

Link:
https://lore.kernel.org/r/20230516202430.4157216-1-yazen.ghannam@amd.com

v1->v2:
* Rebase on tip/master.
* Address comments from Guenter.

Yazen Ghannam (6):
  EDAC/amd64: Remove unused register accesses
  EDAC/amd64: Check return value of amd_smn_read()
  hwmon: (k10temp) Check return value of amd_smn_read()
  x86/amd_nb: Enhance SMN access error checking
  hwmon: (k10temp) Define helper function to read CCD temp
  hwmon: (k10temp) Reduce k10temp_get_ccd_support() parameters

 arch/x86/include/asm/amd_nb.h |  4 +--
 arch/x86/kernel/amd_nb.c      | 46 ++++++++++++++++++++----
 drivers/edac/amd64_edac.c     | 68 +++++++++++++++++++----------------
 drivers/edac/amd64_edac.h     |  4 ---
 drivers/hwmon/k10temp.c       | 57 +++++++++++++++++++----------
 5 files changed, 119 insertions(+), 60 deletions(-)

-- 
2.34.1

