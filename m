Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACC6434225
	for <lists+linux-edac@lfdr.de>; Wed, 20 Oct 2021 01:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhJSXjS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Oct 2021 19:39:18 -0400
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:63777
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229668AbhJSXjR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 Oct 2021 19:39:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBB96HBOpL8sImpX14UxuhD2cYyfZAngGEm936x0WzvUcRYZz4jXmUC579WAXcWHMvGjZ77wna0t1bXiIQxceZqyDaMwlmsZLhTqwiw5Fi8ymnSAOOp2ynS2UtkxgID+wUXdjhC2Y7a/1RNJMlc9Ma5Kn4B8dimbc7M8hDBF006ymoN10amsBgqycx5aKXAm0zpmJrKgw2bKyR3Uvd6OvciKrYVZMpgq3VrlwUaSMBO6QpU6PVbgG+s/YVBcWi18khB3HoZGw2RhRPXY3rWtSIQkC1hLxIyg3QMQQxSEF+2qa06cd5oYO/AAc+2PpP+1TKBgxEvRhWv57fGuvXu2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7H/9hhGMUolxDi25Zw5nXDxtlXrBfTykpS/SAe9NtM=;
 b=k76DK8RvuEPTgAKOnY8qLDUh0EFRwDFd5OoXGxU81T8X3fs3p1dHGomcLunaUG26ZvhgPoixmv5MrMXBt4l2lPDxt9kcvxGmbRrHPeDTHmEST15ZueiVoGj+1WlHNz7G+0/BtoTbqJJqTk+quHHYEyhX1rNH5yv8X9BCVbJQGQE5EdAXWK2uXCu1ki1quDGdDLfHsZPsXqe3cdvvdAVgZv64e3muT5mVzmRsL+Aw1HFLGfBs7aj9Zp3Zh8jpcXrs6TizrFwMrEhj2BfdjukOKz1ivKH7qKtDfA5Waq2THxmiofHuk59kycPFODW3aTFi26ocRZ2UWWznB9bueQIx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7H/9hhGMUolxDi25Zw5nXDxtlXrBfTykpS/SAe9NtM=;
 b=cyUGHAisO5u53UQqCkoJfjKlTj4XRJLoRgbZ5T9kQKkIdny52L7Jx/8dXIx0CmulIDFwqkKFsviqboDN/uTs4GNBOGicwxcT98FJUtjEkOCINzQxce7HsVe+xaCeuLxH600sCB4dhjrOd7a2doADWi0eC33OrOJ2p8FM03FqnsQ=
Received: from DM5PR04CA0048.namprd04.prod.outlook.com (2603:10b6:3:12b::34)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 23:37:02 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::5d) by DM5PR04CA0048.outlook.office365.com
 (2603:10b6:3:12b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Tue, 19 Oct 2021 23:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 23:37:01 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 18:36:59 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        <yazen.ghannam@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 0/5] x86/mce: Handle error injection failures in mce-inject module
Date:   Tue, 19 Oct 2021 18:36:36 -0500
Message-ID: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2faca32f-2911-4308-24be-08d9935959d6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4471:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4471E291EDB42EE97A6164E290BD9@MN2PR12MB4471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ku9u8G7EuAHOBDiq49hVJrjIa8UtGdqdZ7GQbfZjtCac39B9eiV+tdiMBE+HTlGxED38WiHx5pOEAzQ3+pwBQKbNsUvYXWdRAHSFN5qPBWrV5opROh9zs8bLpi5898xc22jCZZj8ojW2AquDAKGP7/idZ/TzyY5+9rMLTHi//9vgkx6b5CdMzQOZzrH1RELeuKPogkmDu2BZbtuqaCRQFkDpPOfumy+FqO4RlL4L8iKPvohEgup4H8/G7RdSg7wFOkexBLbTOFo4Q731yq+uN1gXEByHDLhfhE29TidFvRPLOva/3pbl5JOkf4UF6//LgBZIPrsXsybIvtAJnTEShNAtxFWXI6C8gipYp8NHGNS8dBQwuoci/4PaiAeRtHa18im+C8hVHx7vfktdT335wqCEGH6wwJCPqUL91KTZ+PRZEcABUaG3V3TF25juCAawaR6n9bhOLiyH30ZvmOogD/OIhkFBAmthUXHtmwWVvKp1jLh8vNWxzOEZpFcSTTKpqSFzQiQZXa6JQVTbMlky6xgcQlyv6xpjssfbL77PquqGEMRKRHfPRxI9NRzWhW5d3grJlKd6ZplTu6qGxGgLu7+x4yh7W+RCsLGVZmy5WpZeIlDOQBi/6jTapI5Wrjg7NpTmwtJOY+meYIVwrQo7lg+0dsTgPH9TTrtMf73Yk3FdLELTr8fL3/QIGoRf1vxdp4Vre/+NYIsA1zmXfJmFR/4RO1KlOgxiphAIVMvGEM4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8936002)(83380400001)(4326008)(70206006)(70586007)(5660300002)(8676002)(36860700001)(356005)(6666004)(81166007)(86362001)(1076003)(26005)(336012)(16526019)(7696005)(186003)(316002)(47076005)(426003)(2616005)(508600001)(2906002)(36756003)(110136005)(54906003)(82310400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 23:37:01.7185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2faca32f-2911-4308-24be-08d9935959d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series of patches handles the scenarios where error injection
fails silently on mce-inject module. It also cleans up the code by
replacing MCx_{STATUS, ADDR, MISC} macros with mca_msr_reg() and finally
returns error code to userspace on failures injecting the module.

Error injection fails if the bank is unpopulated (MCA_IPID register reads
zero) or if the platform enforces write ignored behavior on status
registers.

The first patch checks for an unpopulated bank by reading the value out
from MCA_IPID register and the fourth patch checks for writes ignored from
MCA_STATUS and MCA_DESTAT.

The second patch warns the user about MCA handlers missing signatures if
valid bit is not set in MCA_STATUS register before doing error injection.

The third patch does some cleanup by replacing MCx_{STATUS, ADDR, MISC}
macros with mca_msr_reg().

The final patch returns error code to userspace from mce-inject module.

Smita Koralahalli (5):
  x86/mce/inject: Check if a bank is unpopulated before error injection
  x86/mce/inject: Warn the user on a not set valid bit in MCA_STATUS
  x86/mce: Use mca_msr_reg() in prepare_msrs()
  x86/mce/inject: Check for writes ignored in status registers
  x86/mce/mce-inject: Return error code to userspace from mce-inject
    module

 arch/x86/kernel/cpu/mce/core.c   |   1 +
 arch/x86/kernel/cpu/mce/inject.c | 103 ++++++++++++++++++++++++-------
 2 files changed, 82 insertions(+), 22 deletions(-)

-- 
2.17.1

