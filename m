Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6108649EC9B
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbiA0Ule (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:34 -0500
Received: from mail-bn8nam08on2072.outbound.protection.outlook.com ([40.107.100.72]:48000
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240267AbiA0Ule (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4/hmTjxU9/AxbjKtqorlM6nLaaEnZ7WdSrglZTXzVHouPkLmpJOPmDlh08QBYkQWCc2WPx2X7/ofOQRsQp1Ga+VuWjo/FUlscxm8snKPzvcDFDhqX6aNHCaAuTK4mixXJjmPE5FZfI4cKTxpugREMScPipsADOs+CJFzEyoma4lKDj2YvYVrFw7avYi6iYvjuqub/QDDbYXpDMqhbBidSXxpjKJcuJ4CjSJMIZP9gLFLRJZUVPYk/E/1D+KIyIZfIzESMV9WACBG02pjlf+BiqJx1jF5udxkvXYaYKVVeyJRAz1my/SInoCxtilpIWlCig5dPjg+8hGivkbNB7zSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBLejrUcGGMpQP4CyaGgdKrtDvV2Af22CrQelABNgUo=;
 b=ZBkiLvmY663okHTsL3WYw+gi+uFC1dsefWehce66jvGnvIsk/r9qlO02IrlJfcsXH39GTuPTVkgl4WO04Vfrrov2iHTPiWnzI/8ETlDss3eGLBE7df8kQAt9BnRoJjQHHnHGXoR1AbjjKwH9PP2CckeJ25kVrY6k/ErJ6KDrjfa9jMb1/GBSDORj0cu571Haq1peXowq3CktX9urnDF5bsOYF45KP7cOd9D09K5tE3KucSFs/MC6PgtIiAxRzRqVJTWZBI2i16Hkj/HJTAuN+BmX/oCx/1/QfYsZd++DsUKLp5F9WkdThsTjtRHcrYYhL9E7ITCR/KVD8+i2IcvBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBLejrUcGGMpQP4CyaGgdKrtDvV2Af22CrQelABNgUo=;
 b=tEx7o3MzddIxUWQW7ayd7U+Nsp2baWUzcSctvyNQ67wJSGL/VDh+E2HK3uK/D3OdCoj77HKZI9XolCfu7VqXlQm+NgvGnDjgKhPWv2JuYvtV8oeNF4m5GSHadvZSfgVMb986aQPykSZQhxYEFiO5Qjmkop1kXuZNrqxKrPBnRi0=
Received: from MW2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:907::27) by
 DM6PR12MB3802.namprd12.prod.outlook.com (2603:10b6:5:1c5::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.18; Thu, 27 Jan 2022 20:41:31 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::c0) by MW2PR16CA0014.outlook.office365.com
 (2603:10b6:907::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:31 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:29 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 00/24] AMD MCA Address Translation Updates
Date:   Thu, 27 Jan 2022 20:40:51 +0000
Message-ID: <20220127204115.384161-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38d895fb-6ee6-41a6-8042-08d9e1d56681
X-MS-TrafficTypeDiagnostic: DM6PR12MB3802:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38028B731E6509E4B2ED4337F8219@DM6PR12MB3802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmlaL61nvmsmkFuqlnC9av9S/tNWVgTAaHB/1J0fJxnjU3xjwLGWp5jZvq9Y7WjSKErOiByw1rU2Yb/7nk5vPZIb+kSKa8DyxDROWFEPNhcMkFRFDOcgbOWRnVqN7PsPv7UQVV3UJKJkganu719MIUbrfQgiXMA3spypC7CJb7pohwR1dPLJ7N7AgPI03VU1kH+9a0ZEIdBtnVpFmNg3Qc44/mhkeEp7oZeTjbGLpjB+Bhf3dC+qL9OwHNafGaaZ75Hm38+evba2l2Ub7JY8QC6SIStJMJOK2VZJhHlK78lC6RP8ojlaCTERbQ1CXif1LVWCE3kjh6A+k5HfhQMuU9jX5kajODS7nbvc6YnUliU7CW9C4kSm+vfj0eff2ZleAq+QEAZPkAVBhveLfqCgXbqzbSUfWDXP/UC+yZwGIyNP9VVi55+nr3G0UODKAV5KjuF2FLr4J/2zVfrKfXAvZ6emr3b3IT6ieAsya0jI2TEd1k2zVzTo8rFbLPJ6P9a4udCVJw1fezRd13w8oHWOJFqGHuswVH+4YyRMfRTJgvn0VWGQ4ahakZWBn5AA6bDANI4ev/X36VuP8CpDPqHf4A2Ua/IQnusNMp5Y+SlSFghRzndhj4LWl57/Gsm57HRMJ1wSgK1wAwyXPmp8YUmI++mZGMDjAhSxTkMJRiLlTE+1Ox186NFQxwwjz91fgYj3gfapOZJRsM1Ky/VR3mwONHSXaTUI8mPw1hy0yrGJVvavHhjB1qCzWDQuf5H2XxbxuYR1Arqzh0gpRRoPH1CkYE9wgD/K028wlnc8ZGDhev8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6916009)(36860700001)(1076003)(54906003)(508600001)(316002)(2616005)(2906002)(966005)(36756003)(356005)(81166007)(47076005)(44832011)(82310400004)(15650500001)(8676002)(4326008)(40460700003)(70586007)(70206006)(8936002)(16526019)(426003)(336012)(5660300002)(86362001)(186003)(83380400001)(6666004)(26005)(7696005)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:31.1963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d895fb-6ee6-41a6-8042-08d9e1d56681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3802
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset refactors the AMD MCA Address Translation code and adds
support for newer systems.

The reference code was recently refactored in preparation for updates
for future systems. These patches try to follow the reference code as
closely as possible. I also tried to address comments from previous
patchset reviews.

Patches 1-23 do the refactor without adding new system support. The goal
is to break down the translation algorithm into smaller chunks. Code
that changes between Data Fabric versions or interleaving modes is moved
to a set of function pointers. The intention is that new system support
can be added without any major refactor.

I tried to make a patch for each logical change. The top level function
was split first, then the next level of functions, etc. in a somewhat
breadth-first approach. 

Patch 24 adds support for systems with Data Fabric version 3 (Rome and
later).

Each patch was build tested individually. The entire set was
functionally tested with the following modes.

Naples:
  No interleaving
  Channel interleaving
  Die interleaving
  Socket interleaving

Rome:
  No interleaving
  Nodes-per-Socket 0 (NPS0)
  Nodes-per-Socket 1 (NPS1)
  Nodes-per-Socket 2 (NPS2)
  Nodes-per-Socket 4 (NPS4)
  NPS2 w/o hashing
  NPS4 w/o hashing

Note to the maintainers:
If there are no major issues, I'd like for this set to be applied,
please. Comments are still welcome, of course. There will be a future
set to add support for Family 19h Models 10h, etc., and I'd like to
address comments there.

Thanks,
Yazen

Link:
https://lore.kernel.org/r/20211028175728.121452-1-yazen.ghannam@amd.com

v3->v4:
* Rebased on latest ras/edac-for-next.
* Dropped patches merged in v5.17 (Thanks Boris!)
* Dropped patches for CPU+GPU systems.
* Dropped patch that changed function parameters.
* Folded glossary patch into other patches.
* Left in pr_debug() statements that I found useful during development.

v2->v3:
* Drop "df_regs" use.
* Include patches needed for CPU+GPU systems.
* Set "df_ops" at module init based on family type.

v1->v2:
* Move address translation code to EDAC.
* Use function pointers to handle code differences between DF versions.
* Add glossary of acronyms.

Yazen Ghannam (24):
  EDAC/amd64: Define Data Fabric operations
  EDAC/amd64: Define functions for DramOffset
  EDAC/amd64: Define function to read DRAM address map registers
  EDAC/amd64: Define function to find interleaving mode
  EDAC/amd64: Define function to denormalize address
  EDAC/amd64: Define function to add DRAM base and hole
  EDAC/amd64: Define function to dehash address
  EDAC/amd64: Define function to check DRAM limit address
  EDAC/amd64: Remove goto statements
  EDAC/amd64: Define function to get Interleave Address Bit
  EDAC/amd64: Skip denormalization if no interleaving
  EDAC/amd64: Define function to get number of interleaved channels
  EDAC/amd64: Define function to get number of interleaved dies
  EDAC/amd64: Define function to get number of interleaved sockets
  EDAC/amd64: Remove unnecessary assert
  EDAC/amd64: Define function to make space for CS ID
  EDAC/amd64: Define function to calculate CS ID
  EDAC/amd64: Define function to insert CS ID into address
  EDAC/amd64: Define function to get CS Fabric ID
  EDAC/amd64: Define function to find shift and mask values
  EDAC/amd64: Update CS ID calculation to match reference code
  EDAC/amd64: Match hash function to reference code
  EDAC/amd64: Define function to get interleave address select bit
  EDAC/amd64: Add support for address translation on DF3 systems

 drivers/edac/amd64_edac.c | 710 ++++++++++++++++++++++++++++++--------
 1 file changed, 565 insertions(+), 145 deletions(-)

-- 
2.25.1

