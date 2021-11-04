Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F25445BE4
	for <lists+linux-edac@lfdr.de>; Thu,  4 Nov 2021 22:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhKDWBo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Nov 2021 18:01:44 -0400
Received: from mail-sn1anam02on2042.outbound.protection.outlook.com ([40.107.96.42]:43297
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232119AbhKDWBo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 4 Nov 2021 18:01:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uslsj6eBqH07+rpdtJphmDXB/pNmhhTViTccZlHycF8MwDZz3ggkvYBk6fNC++u6PYLRBlqC470U9fOTpJl3NcpOojU1Iuf6lyL63IblkbdPhxEcuFXVyPq4kK1/LBMdQqpp5xYpdbnZCmEGSVaEEFHN3JVzfMVnMAYv9WZHe1ozCmXLGQ79mqIX/BzSiW3nYhBG2m1qxAFVH7UwASL8OP7E/dBdzspdhWs6BIPfGRkCyEyS8vGyJMeASCCT2Eb68EbAioPBEshrCxli359Z7xq5GCZVOs4CmwQX2wSaNflV5y3KcUz/3uDY+7RzwEkYVe/OvmJSqiWTAXzAgZ+9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFxWfPPorOy9WhNmZlhKG+noZvCsbGIWUNZmO9zoH3g=;
 b=FxttzkrKtvh+QAkF7MHkn9p3G83DR99t0PZvUFi+Zul5b075LtHcz6es9qjYeIosb9KK1F0m9ycXs7pKDyzP6VaQEtSGIl4MlXDiFTBO65Agb874DGrE/zOG4YsI2k4NprNV2X/6+RwN6J1/rHERArqSjjUj6sfsmf5oOq/Z9ynJIgvYvv7zEnPHiuJ4Wo1snJterda3SMdePLaWc1bcabjzEAML9MddnhrV7+BqKNdnLgxPeL8DCjiIy7x3F6q0ueIqEVQZO7Q0JLITeZjQq0FgGwnW9mmlMYSH6d70jibtgr58F/f1pfULUIwSL3niSblC2I5pRUWOWuJKwjwiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFxWfPPorOy9WhNmZlhKG+noZvCsbGIWUNZmO9zoH3g=;
 b=Q3LJES4+3fxfaesUqKFI8cw8IDdom02Q3hPaegA+u3QhjlVVOF44BDGtGoUXTt7hOoYjhu1oAQoLges4eKyOFJYZ8rk1XpioWhqmkU66PYKmE/lL9oE5/VxIvomuo9plIUhzR+UFzl1uNcIRGux92OOb1gM2qP+Vgm9FF7PxNTA=
Received: from MWHPR22CA0005.namprd22.prod.outlook.com (2603:10b6:300:ef::15)
 by MW2PR12MB2539.namprd12.prod.outlook.com (2603:10b6:907:9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 21:59:03 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::56) by MWHPR22CA0005.outlook.office365.com
 (2603:10b6:300:ef::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 21:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 21:59:03 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 16:59:02 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        <yazen.ghannam@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 0/6] x86/mce: Handle error injection failures in mce-inject module
Date:   Thu, 4 Nov 2021 16:58:40 -0500
Message-ID: <20211104215846.254012-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 072a6a4f-f026-4085-3cbe-08d99fde50af
X-MS-TrafficTypeDiagnostic: MW2PR12MB2539:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2539D2BCE1A2ACAF1F984582908D9@MW2PR12MB2539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xy+/t8aV5pbsPZJrozAGBTaTRk8e7zUtAqc+D7lQNH+v2I4PGPFA11VXldVAceBzGC6czH2asXznNGBGOC2+6D/24tnXnRjdwDV9AxakdRrzjD3qkHO8KDggZR6ItzJqfj6V+XObFBR1DeCsczitGMeJ/ztLqlmRQ8M1illxL/j2CtufQIBNpxEmalFdtNmnMH0RMwTpQSrIOHIDCPSZZGD2mCadpKs0Z/B2vO8evH2zfBOP7bVNT9TmUQPLVDmGhw0/ZmCGM9qCB8UQxrFVciqVfnU6049LmYP6l2lEm+9zoNi3o24vIpTmRLkUtMyDJp1PuDHUFqOvG9qn889JGIdljdWsclC2c4j2Ww/yxwFB/zbV+9jznvUyGJzHwnevYiYTIWvtOg+QjR7Lyd2/s4GApiaqOh5Z872RFFv5F463Fy+STFpCSbgbKNzQrIwUhJ5m60wIwtF52ZS7hpjNChmsqgVBhpJotYuMJ2aPrvBpcaB0GYEQCiKCdwMDvJWhKz+G31ssJiym+gqQeHV0+HPEdpeNc7hNbctRBz7oCuJ9j5eLwSRTf+/I+f2RMAJr7E4NGUpN3kbrjpC6SgKqQF6uRyrcVt9fyNfDTuI0b286BWTqTwwtyK5DTbztT44TINlh9vg2qL+7p2i86VVruVfJqGjQFYOhuqoBMFGWJORuEhJuu7xwWv43c33VxfCE3NnBRTcU5JEszMUToFFTC0mOlHucvf5+mJLUIoZKm4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7696005)(426003)(36860700001)(8676002)(6666004)(83380400001)(8936002)(5660300002)(70206006)(336012)(2906002)(110136005)(36756003)(70586007)(16526019)(86362001)(356005)(26005)(47076005)(82310400003)(4326008)(186003)(54906003)(508600001)(81166007)(316002)(2616005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 21:59:03.3074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 072a6a4f-f026-4085-3cbe-08d99fde50af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2539
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series of patches handles the scenarios where error injection
fails silently on mce-inject module. It also sets the valid bit in
MCA_STATUS register unconditionally to correct Val=0 injection made by the
user and finally returns error code to userspace on failures injecting the
module.

Error injection fails if the bank is unpopulated (MCA_IPID register reads
zero) or if the platform enforces write ignored behavior on status
registers.

The first patch checks for an unpopulated bank by reading the value out
from MCA_IPID register and the third patch checks for writes ignored from
MCA_STATUS and MCA_DESTAT.

The second patch sets valid bit before doing error injection.

The fourth and fifth patch does some cleanup in prepare_msrs(). No
functional changes in these two patches.

The final patch returns error code to userspace from mce-inject module.

Smita Koralahalli (6):
  x86/mce/inject: Check if a bank is unpopulated before error injection
  x86/mce/inject: Set the valid bit in MCA_STATUS before error injection
  x86/mce/inject: Check for writes ignored in status registers
  x86/mce/inject: Simplify evaluation of writes ignored in status
    registers
  x86/mce/inject: Restructure prepare_msrs()
  x86/mce/mce-inject: Return error code to userspace from mce-inject
    module

 arch/x86/kernel/cpu/mce/inject.c | 106 ++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 16 deletions(-)

-- 
2.17.1

