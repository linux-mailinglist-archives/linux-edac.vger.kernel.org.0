Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81D267EC10
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjA0RGd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbjA0RGF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:06:05 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8E58497A;
        Fri, 27 Jan 2023 09:05:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjTg0COUU8qBOPM8eyhirvv5oZ1xgEFlp9GIxdsG+1NnoyRyjebt+yVw2YfslCtRQIpVOpL/KjRLNr2KWw+REpssd74lBiCrG24PdS2yiItZ1iN8MJupcig1Uo+rEXN50j4WPZfZNLDJDjnhEztEeTStvlPoFawpimBZw/vRh5oOy4lexaD147Q+v69tzQMHyA6N0NIDtuqv5zb8h0TJAlsWcjxJYEOTBt+BoNEY2VfLo++8ZtWYZSwB7lMA7/LcNweZd3/0ksxq8gFj2qk8hVZclk7s4+uTWfpmIPz9ZOsF2dK89M7Qr6NN/dOPsTxQAMRNLm8+KgoqArwry79lDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5YcovxXShS8uVNJ+vMeslU0ZSLeD0SZJKDMa+4ArS4=;
 b=OJuzdBu43+tfgHdrk9j8Oo5W6BR7q7+YBfjlrH23rj3KnjF2JRfJYj8MwOhn9DqZZkUDICTcTg1g5hB07z6czluHeiIpcJ7vO+FwBeZPGqQQRlOi/I/iW4mCQWL9Q7L7oSMMMaHydBTvbz2y/5dH6FgZ5CuhdlAXnRFTpe3u9YoNCtl1KqQ45J8fRklYRSBsis+RjQx8gYaHewFbgf3Kr5aaM/lS+DXIgnB5IIO8cPpVScDyGvxanrGrQCmJ3UsFMavckbw/r2bYnXvFYhyYVRUlWmdWFfTEv4migT54b1vAbsMTjXoz13mY3yI+dT0MZptYbk8QCU+MGsS8kkNWpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5YcovxXShS8uVNJ+vMeslU0ZSLeD0SZJKDMa+4ArS4=;
 b=FDybrfu8Wrrn/dXy4G3SwCIAnDCMgY0zU1JIjGlwXCRauQop/649b3RrazCnIBiL9mdUm5vjpSYWn2CFlOXRd+y+9jf4j94aR0apf6f0xfH7Y5M9+DW2FVcv3GFtShmDFa2eygpl0k8eaL+jDCO/XneSXgIJeHrgUXO5w6F7SOE=
Received: from BN8PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:d4::21)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 17:04:31 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::46) by BN8PR04CA0047.outlook.office365.com
 (2603:10b6:408:d4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:31 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:30 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 00/22] AMD64 EDAC Cleanup and Refactor
Date:   Fri, 27 Jan 2023 17:03:57 +0000
Message-ID: <20230127170419.1824692-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6e3eca-bc14-40d2-bf3b-08db00888e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qm2DGUnm4RtSgRI+Ycg/nX6HyaOhDfvNq2n/o8nbDSlXD6pwAsbGF1BAWXjai5MeK9OWwvoqfmYGa8e2wEvkO6FkSP/5T0MGDnqqtvnEAfk2qUlJeLgZseIPJ8a3L38gQXPdgF1GnG/iBclhttrj4o0gKi78bzPZBAVCA0x74NoVAHWUAl/DQXc6YHIK4PjxjedEIZHxjMNRyGK5mUpMkn1tPPVqYmrYzIJSWdiR2M3QbLoj3g3MJmM7O9cXJNxaMlY15gFdjwEwe9e3VEW6eOSS96fSh5t63UW3OPE222Sj03KgxmWwMKdZ4b11sN8M8d5V1TxUSj6J9nG1olUNpWP0kcwV/PsqOXJ4966w4dJcLfpcqrqKwQ0nhm0vQ7Wd8dEQ9PUXSUR9FppSDDtYTbVrQWbKDYjauNDcKxMZKj0fZ6Fjsnq/6egX1pIPkXjvYZ9qhAS+f+q+jPfh+joUP1gcF4mvS/naQQPH6XwoaZLCgJE7nAGdimaDQ4qy2vCj/G2pYXITbgH/nctkqtOLgsyQm/BNbpeMwwiysCramrei18XIGDDUuG69cwcmGM4extITVyL2/EinfuAyXlAq/T/XmJmlv+ms8RlKwfOwPSJk2DryxTNPPrtQ/E8QU6YVFcBGdH/af4kTQAkeVYYUYoaBMim3i+ZLk8giXg7hLU1p/MpC2J+x/1cAoLFZkU+GAmVQsyZm+pMrfgdfwAcH9wSehHrHBeVqm4zxHx4ERwJDruC+uLARMItVkl219dAkha0x0WMef7fNX2M9yuVSpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(40470700004)(36840700001)(46966006)(7696005)(16526019)(186003)(26005)(478600001)(966005)(47076005)(2616005)(336012)(82310400005)(426003)(83380400001)(6666004)(316002)(54906003)(41300700001)(8676002)(81166007)(356005)(1076003)(70206006)(82740400003)(110136005)(8936002)(44832011)(40460700003)(86362001)(4326008)(5660300002)(70586007)(36756003)(40480700001)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:31.0777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6e3eca-bc14-40d2-bf3b-08db00888e9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

This set removes a good amount of code that is no longer useful. Also,
this set splits the module initialization more clearly between legacy
and modern systems. The original intention was to prep for adding GPU
support, but I think the split is worthwhile on its own.

Patches 1-4 remove useless code for Family 17h and later systems.

Patch 5 removes code that is no longer needed for all systems.

Patches 6-22 merge, split, and rename various functions and structures
to have clear legacy and modern initialization paths. A future patch
set will add a third "GPU" path.

The basis of the first revision of this set was to make a function
pointer for each legacy/modern split in the code path. This resulted in
16 function pointers. And, in my mind, it was still hard to follow.

The basis of this revision is to diverge early during initialization,
and then follow separate paths. This results in 7 functions pointers
including 2 used only for legacy systems and 1 used only for modern
systems. I think this is much easier to follow as each path has a clear
set of helper functions.

Also, I dropped a lot of the boiler plate commit messages. Most are now
fairly terse though I did try to add extra details in some cases.

Thanks!

-Yazen

Link:
https://lore.kernel.org/r/20220509145534.44912-1-yazen.ghannam@amd.com

Muralidhara M K (11):
  EDAC/amd64: Merge struct amd64_family_type into struct amd64_pvt
  EDAC/amd64: Split prep_chip_selects() into dct/umc functions
  EDAC/amd64: Split read_base_mask() into dct/umc functions
  EDAC/amd64: Split determine_memory_type() into dct/umc functions
  EDAC/amd64: Split read_mc_regs() into dct/umc functions
  EDAC/amd64: Split ecc_enabled() into dct/umc functions
  EDAC/amd64: Split setup_mci_misc_attrs() into dct/umc functions
  EDAC/amd64: Split determine_edac_cap() into dct/umc functions
  EDAC/amd64: Split init_csrows() into dct/umc functions
  EDAC/amd64: Split dump_misc_regs() into dct/umc functions
  EDAC/amd64: Add get_err_info() to pvt->ops

Yazen Ghannam (11):
  EDAC/amd64: Don't set up EDAC PCI control on Family 17h+
  EDAC/amd64: Remove scrub rate control for Family 17h and later
  EDAC/amd64: Remove PCI Function 6
  EDAC/amd64: Remove PCI Function 0
  EDAC/amd64: Remove early_channel_count()
  EDAC/amd64: Rename debug_display_dimm_sizes()
  EDAC/amd64: Split get_csrow_nr_pages() into dct/umc functions
  EDAC/amd64: Drop dbam_to_cs() for Family 17h and later
  EDAC/amd64: Don't find ECC symbol size for Family 17h and later
  EDAC/amd64: Rework hw_info_{get,put}
  EDAC/amd64: Rename f17h_determine_edac_ctl_cap()

 drivers/edac/amd64_edac.c | 1221 ++++++++++++++-----------------------
 drivers/edac/amd64_edac.h |   89 +--
 2 files changed, 483 insertions(+), 827 deletions(-)

-- 
2.25.1

