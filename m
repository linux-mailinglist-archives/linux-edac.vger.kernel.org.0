Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 053F2136518
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2020 02:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgAJB5I (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jan 2020 20:57:08 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:6198
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730359AbgAJB5I (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 Jan 2020 20:57:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZB8yS6EHltY5vnBeeNBevupwT7Ua+YbB6Awixd5M0PLp/iQ+ETZIrxr5ODCCyWIJy58sFnAV0ojAnnaRR2JtJ1V6+cwbFB0btpZscJ6c9MwUOL0VPLyi6kbixJrglb4kz2N4WaTFT+lz2MDJwdFzFrXiols1/gcDWkzD6ns5b2Bz4LD17xUeYHGY6tVd/ezJsOtCFP0rZnaxaW0/Sc6DQTxrvNcp6YkpyMfLtr85AJjue1jIHY+KiMFkXJ24TDhPWoqiA+Xi9OUP8m69YYGnPnL7rX4BNeHzaIxOBCEP5Uoj/kV2iRYFYqjjGh9a5yNBO/sFVkrpgR3Nt1nlm2MqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JoyyOPOsBt0j/rd5e7H3IOxaxDVqpJTNcCr+QI8M5I=;
 b=G6slXRU/6Rxh7xnzQu4+A2zR4exASJIqdyLf8dQ9iwzwWJGGGwffx8su4SUem3duT793STjwsaCdshrE0Zw6AuGtYY5LwuCXYvKTr5Y/wC8B68pgMLq/UhBDR1LTFHL5dnCx25T6FtAtOyk2sdnINGI/GBd8AVtmwkXESL7rCCQOVng/F9v3o7UrBZC7N0/qC8ApXaKarMBOhPgo3UwtYIPorBBD5D70yiN8DtaXVktCn8U7n8tzr4+ZfP72dwerY12Kq2vMx5V0MuY3ZQFpZf8eGy6T31lno6WLBPhZzYIPWNcme1JtwkhPyKoxbJYT7wu0lb8m0eWytf9l/dptWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JoyyOPOsBt0j/rd5e7H3IOxaxDVqpJTNcCr+QI8M5I=;
 b=f4oqjhGsHvFGaauLFAkTLmwpSalyEqMH78iQUEqOiU7coUAOvjSkbr6PkGafCqAI71aJjofcOsSRcwUcEshGQdBpt4G1zaZ4BGuTvwDfCqH83HiE5n+rdnSBJP3mp3r/Br8gI+7S0meTpqvcy/GCmNK7XjvS/2YXJNCjQlb3zuc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
Received: from BN6PR12MB1667.namprd12.prod.outlook.com (10.172.18.18) by
 BN6PR12MB1378.namprd12.prod.outlook.com (10.168.228.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Fri, 10 Jan 2020 01:57:04 +0000
Received: from BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe]) by BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe%12]) with mapi id 15.20.2602.017; Fri, 10 Jan 2020
 01:57:04 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org
Subject: [PATCH 0/5] MCA and EDAC updates for AMD Family 19h
Date:   Fri, 10 Jan 2020 01:56:46 +0000
Message-Id: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:805:66::49) To BN6PR12MB1667.namprd12.prod.outlook.com
 (2603:10b6:405:4::18)
MIME-Version: 1.0
Received: from ethanolx80b6host.amd.com (165.204.78.1) by SN6PR08CA0036.namprd08.prod.outlook.com (2603:10b6:805:66::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.12 via Frontend Transport; Fri, 10 Jan 2020 01:57:03 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12c55ac2-5578-4aa5-b5bb-08d7957063ce
X-MS-TrafficTypeDiagnostic: BN6PR12MB1378:|BN6PR12MB1378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1378489021FCE355DC28F070F8380@BN6PR12MB1378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(66556008)(2616005)(6916009)(5660300002)(8676002)(15650500001)(86362001)(66946007)(956004)(36756003)(4326008)(1076003)(81166006)(478600001)(26005)(316002)(4744005)(186003)(8936002)(66476007)(52116002)(16526019)(2906002)(7696005)(6486002)(81156014)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1378;H:BN6PR12MB1667.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCM6fTT5qm6CFKl1tZuitQYyyIrxlVw8mOD5pS6X4giQjM+OLRfNqQf6KBrkVc1PX6+c5YaHRLBd/YNHYN1wvLk4b3UGAPk6oSYCHiKX0Sd5HEMa6WTgcRMHKLesnquIwLrWSFB+L49F1g0ywrsPZEvF7lz6WwNAUTBfLrVOKpSCDKzGIuYl6TusEFHCide3y/q1S9yWAjzvaINyQ4Br3ZtYxdVi+PqRMsbf+P3rF4mNXY8zjcMlBUbJtU1PW6TQ488xouLz/1goOlyCLuqyUidMNTTJsSpZlcXjg6xpC5OjlrNGiGDqH1g6eBOmwOgpUourR4tIzPtZP3KC3TESfjTicva417hGWNKzB/5Y7GwZYc7GSekWTKq23RgYpP8EaoXAqKg0gQMYoocLgLqaoxNqeoAxtp0ihvNXYDCfGX/g063b0BJbu1ULBlwoOZPQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c55ac2-5578-4aa5-b5bb-08d7957063ce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 01:57:04.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQ5f4wKzUWgVc+iIiQC7eAMNft7YpFsgLUnU1a6Zo0FxHZQsqx9wCZyePDPHYtZd8sEY7MtXIn5+jf/u9H52Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1378
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Hi Boris,

This patchset adds MCA and EDAC support for AMD Family 19h.

There aren't any functional changes. Mostly we just need to add new PCI
IDs and a new MCA bank type. I've also included a couple of patches that
do away with family checks where appropriate.

Thanks,
Yazen

Yazen Ghannam (5):
  x86/MCE/AMD, EDAC/mce_amd: Add new Load Store unit McaType
  EDAC/mce_amd: Always load on SMCA systems
  x86/amd_nb: Add Family 19h PCI IDs
  EDAC/amd64: Add family ops for Family 19h Models 00h-0Fh
  EDAC/amd64: Drop some family checks for newer systems

 arch/x86/include/asm/mce.h    |  1 +
 arch/x86/kernel/amd_nb.c      |  3 ++
 arch/x86/kernel/cpu/mce/amd.c |  2 ++
 drivers/edac/amd64_edac.c     | 62 ++++++++++++++++++++---------------
 drivers/edac/amd64_edac.h     |  3 ++
 drivers/edac/mce_amd.c        | 41 ++++++++++++++++++++---
 include/linux/pci_ids.h       |  1 +
 7 files changed, 82 insertions(+), 31 deletions(-)

-- 
2.17.1

