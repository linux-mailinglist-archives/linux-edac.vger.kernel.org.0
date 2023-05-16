Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C843E7058B7
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 22:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjEPUYu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 16:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEPUYt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 16:24:49 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44F81BE;
        Tue, 16 May 2023 13:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoHbg6wZawJXxqbjAnr6O4shmPT3L2ngPdzxYOB1g1ZByi47HVOB7MnMnX7ZRrBUYVpF+spYJkmnWrd9vonOBDpgG3r3KaZBTkkUJct/+ZYgyvmIpRt7qBbyBA4h5SUoIjY5b9n93QWBpp6Uz8wc8B0KKmsotw8ArYRCyL6CmMngqPNKs5LtwaXLvTI3d9UB/Ry78PlhqUyMkV3kB141fHcQVwtnh1988PVphveBp9qrfvmGN2CJINvgHbegnUwTe8YZxIcsgjsDWVlWx/TzbUG7QANU5L2x1EqfZGwJ5O6huovbsswvG8kMcgUUxAEHolYG+9/G6dJ8IZzceRdtyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAzisWRfZWd22mAbmFONFpOpFpclthfHs3VYehaG4KQ=;
 b=KZCeun03IQ/b3tUbfd2+NothKLba9m547pzjxESHDNFLy3xQ3EJXWC+MryNRUGBHuz5ufFXsQXHByjsgzXKszLvmexFYEcexR/XaHinPJ5k+VeE6VbvPSpvWauVGa4u+YIQRGLG+DKkLC38FfcZ34jXSg9BNp1w/R/FUwk/VhoyHVHyr0GN/HdasIX1l3eb509kfFDAIN/NZG+OMo8xU4uN2onZoNusm0phs3/AvchQWzLmJamYAyTPHebw3w/69wHW2EEDpzpuMjUHtHXKci7KOAHu+cYFKDOgKR58xuLQqoxBD+xZezCIeNCO0q5+HJzHOEUm7K/mxV80QT3FuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAzisWRfZWd22mAbmFONFpOpFpclthfHs3VYehaG4KQ=;
 b=zSDex7EcRkwrrD64Lge4rSgUPMQpkcqRuDfvfeX7Hj1DTvWtM7XJyeH+7XeNnjhD6sR6AMBp2hT9dTDc/a4dRXm76NL5I/WpTBuvDnxXYZ1Iokz/CCKwmDHXKQF7wmnkgUCXcoQnE7TOKSIJawWvYnBwOGzUMrzW+1F18BmX9AU=
Received: from BN7PR06CA0047.namprd06.prod.outlook.com (2603:10b6:408:34::24)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 20:24:45 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::84) by BN7PR06CA0047.outlook.office365.com
 (2603:10b6:408:34::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 20:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 20:24:45 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 15:24:42 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <markgross@kernel.org>,
        <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>,
        <linux-edac@vger.kernel.org>, <clemens@ladisch.de>,
        <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <mario.limonciello@amd.com>,
        <babu.moger@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/6] Enhance AMD SMN Error Checking
Date:   Tue, 16 May 2023 15:24:24 -0500
Message-ID: <20230516202430.4157216-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: ff68931a-9e88-42a1-12c0-08db564b96a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCq1XuVPh9ga5tMqWShXTXdcZLScgd2on4unsxI/yiZ7SCSixWls5XJFSz8YU7LtrQEBfkxOQlCAgCbjzr6S9giykM8Jsv9oQUZksWvRikvKRMH79t99KVKhrn6Ngxf1jbYsyHOt6SxQ3LwB0B8vxdsYiztfsAzb8410QqK/fcOKsR5g1RoJl1SaDk/9CIXIOcRuRBywtVYuvZu8xrI3yOBIcNDGqQC2AUrm535TiPj+NlI42N9XUzJ/Ym4N68Mt6vrm9nYUdK3NKwJUSFhgyPBe3QZNnlKlI6tmIa8MdhAmtMAm60IMnYNg7TLIivrtsuq/AaCgNdKJjd6CpeRygi9WHLk28ZMFIjS6GhPznh2yq/X7mSK+AAd56bQxzUEv3JrRwN+VBuBoYf3Cj6W4Ur9VYxKOIjle0GMLVN4uP7DH4SB3ddfdwlkzICEdEg4hGMW34jFg4MPgWMuZ/631Ahgmi4OUrg65x9Z/KdDwxrZtOdLRGzG6881TGYqtyNOyRRR+Pcybd+bGH80bPmjzCSJkPL1xy9CHbwyDr3AYcgz+CLTBWieL3xEuR7Hh/s5C2LBQH3oByVdA9o4BcQ7Z4CNw9agSdKN0WV55/TeSwtPTn3o5oZ/aQl6OgWrT3AJ7dJCinETskqtSAhofo6nfSx9R3OO6gtBlxxotiOAnZ2RmCJYh88Oe3uf7Kotel2YK+L6j9029okw4RuuzbYq3FO9o4mgy7csu/Cmaa5Xo5L6cvHxIkOpNu/aVQhWTiq7PkUJ90dw11nSItamlz+yQJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(8676002)(6666004)(41300700001)(316002)(40480700001)(81166007)(82740400003)(356005)(6916009)(70206006)(4326008)(70586007)(40460700003)(54906003)(8936002)(186003)(16526019)(36756003)(82310400005)(2616005)(26005)(1076003)(2906002)(47076005)(44832011)(83380400001)(426003)(36860700001)(86362001)(336012)(966005)(7416002)(7696005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 20:24:45.2721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff68931a-9e88-42a1-12c0-08db564b96a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252
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

Yazen Ghannam (6):
  EDAC/amd64: Remove unused register accesses
  EDAC/amd64: Check return value of amd_smn_read()
  hwmon: (k10temp) Check return value of amd_smn_read()
  x86/amd_nb: Enhance SMN access error checking
  hwmon: (k10temp) Define helper function to read CCD temp
  hwmon: (k10temp) Reduce k10temp_get_ccd_support() parameters

 arch/x86/include/asm/amd_nb.h |  4 +--
 arch/x86/kernel/amd_nb.c      | 46 +++++++++++++++++++++++++----
 drivers/edac/amd64_edac.c     | 55 ++++++++++++++++++-----------------
 drivers/edac/amd64_edac.h     |  4 ---
 drivers/hwmon/k10temp.c       | 45 ++++++++++++++++++----------
 5 files changed, 100 insertions(+), 54 deletions(-)

-- 
2.34.1

