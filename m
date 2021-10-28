Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5240443E794
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhJ1SAb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:00:31 -0400
Received: from mail-sn1anam02on2063.outbound.protection.outlook.com ([40.107.96.63]:47424
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230484AbhJ1SAX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSJmJlddeRbXD6LqSAYIl6s9Nycs7uYB3W++B3FV5bUYR/enJRS5QwW9TP9Ikz/AJ3ogJib8Ub7ILjDCpQlYP2V8JVRwFtJWZGXEQnmCyvLV16FqwDLiJbRNf1H3YvezVXP0k7+egO1hW28Np9RVU07SA+DWTDX79ZaNSJyzrMPX3Aw557zV68hwqXfciugX07fUYGgMrgOPeeCRt4bYbCf5MZgccQhcghC5gEbP7rDeACOVlKJZ9PKObHjyIKvI4pOyCDj3fUjiuIvMsV4uQ8xQkhtoBe11iAzkEchZ1d98iLxyMJ+Wwe6zWHyCfYr4evaXy9gJOmvHDJZ5aES70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBM/NHI4/M9ioYxIxja3QexzLfBJoA7gifHGQ9xcT1I=;
 b=JEBmfniRIcODJWY1FLAwnFMDI73THntE4nHo4S3IGiroTMjX748FP98n+ZpkXkZz46e0pa790e+Ote4VRHYi7KaEKrLVirMuXOrByqi05h4QacSOwUG6iCPiD7WdkFwWHl8wkAcRJ8LDKINHxdVPWtpfA2p1YFjE+wjhjpp8QtqXrXMOZ/aPDDMY28QM2YNl1GZs/oBln5wbPIsc/+9OwwGTPWMS7RxtfHQTYEXSj4AiYg54OSdTjbzWE53g0cNl5QUa1t8Hi+m6ogqr0MzxzKPxBZz9qWMrQbQmDdDKaw26j7gfcYFXugkeGv8XrLfaffF5LO8CK6cZ0+AfERUalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBM/NHI4/M9ioYxIxja3QexzLfBJoA7gifHGQ9xcT1I=;
 b=BiAyYjV3bOpkIRv9Zw7I/rExQVhdXi7uXzSNMbW6/kOOno0EU+LND4u2afy5UzjZCBfgpdj2ONifP59ilYOMVLlZv7fMWUM4VNJqxbu74HEf11MHtlflMa8tbuitqUYBbJC93YggGrbJe5/zrjoitdF150dvkhBDsWEszS6rMj8=
Received: from MWHPR10CA0022.namprd10.prod.outlook.com (2603:10b6:301::32) by
 BY5PR12MB4872.namprd12.prod.outlook.com (2603:10b6:a03:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 17:57:54 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::e6) by MWHPR10CA0022.outlook.office365.com
 (2603:10b6:301::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:57:53 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:57:49 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>, <x86@kernel.org>
Subject: [PATCH v3 00/33] AMD MCA Address Translation Updates
Date:   Thu, 28 Oct 2021 17:56:55 +0000
Message-ID: <20211028175728.121452-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91b7edd6-ce29-45f2-9863-08d99a3c7708
X-MS-TrafficTypeDiagnostic: BY5PR12MB4872:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4872E2CF8F76970A825CAC41F8869@BY5PR12MB4872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6N9wB7gMtUGWvfrXipbni9V8JdG4+/KVBfdqEabvabXHPvx6gt60qRDKhzFGTOBqlDEzBlcBW42zeIROnPBqzCwvwe05HGpaWq53bysj1TD7E6oPkWy2DK+MXnXPdnzCQDwiXqvdjrsTGu8o3NjIwyNN4egprmKKqHghyEMbcK6mtdUfVX/mC1xIZMdNbQ0rl3Z5KrbGGbQ2uVkVvkIXOKfSZuU1n/fGLuGTF70BwdHFxRp3Q4K0esVyo0nKgD9r7kjZciSueztfGmugxgIEmNzc5Ny9QU9t+XtbM8uu8G4/hCv7a0a5Y51Gp9Fz2Qpa+V8KGmAb+drlvsXQd/zdRdXeX6pIpJXhUeV/Q9i5qr2nrbVphCfzWEHEsJB9O31DSFyJJ8zlPDvV/Fzz5EWuiF0sMkATatOxv6Rm5IqIy9XeGsy0skYOV7GZd/zBWkj7W5JdsuMTFlPdX3yLQ1WnRmeCV590ovMJF9e/yUogY7tz4rHOa5oA2CCinmvGhsJcbcGN7MborHOpNPLEo6JGebbhITMvKd5EG/bSNGDrOngH7TMJ6lMJbn+0F7y0TkFQ0CcTT09SYg96moTui9RrEa+eaYx67ZQA3vEt/L5zwjvztME8+911P/Onu3RslTbfEjykuvMD2j6Nq2UAa/lJTpxkOkgNjpzoZ1sVPZRLoh+bHfxKOfBp/um6SssIDJN5UuB7do93vferY1g+cSl/IxP/QXf1WO7d5Ix4pP8Stith7vhkjJ1o9h638Pt1vckBskD5IaYTvyV43i/cDIgOJ0hR6KhYi33ZBKZal+jTnlOW5PFULKbpIEpwDRf14ZyP0F+n9fRLyHjKvR0N4EFflaIZW7ZPCk5Au5kKkc+0aIA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(15650500001)(82310400003)(356005)(81166007)(966005)(26005)(36860700001)(2616005)(426003)(336012)(508600001)(1076003)(54906003)(316002)(186003)(8676002)(8936002)(47076005)(44832011)(5660300002)(6916009)(2906002)(4326008)(7696005)(70586007)(70206006)(6666004)(83380400001)(16526019)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:57:53.3754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b7edd6-ce29-45f2-9863-08d99a3c7708
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4872
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset refactors the AMD MCA Address Translation code and adds
support for newer systems.

The reference code was recently refactored in preparation for updates
for future systems. These patches try to follow the reference code as
closely as possible. I also tried to address comments from previous
patchset reviews.

Patch 1 moves the address translation code from arch/x86 to EDAC.

Patch 2 moves the df_indirect_read() function from arch/x86 to EDAC
also, since this is used only by the address translation code.

Patches 3-28 do the refactor without adding new system support. The goal
is to break down the translation algorithm into smaller chunks. Code
that changes between Data Fabric versions or interleaving modes is moved
to a set of function pointers. The intention is that new system support
can be added without any major refactor.

I tried to make a patch for each logical change. The top level function
was split first, then the next level of functions, etc. in a somewhat
breadth-first approach. 

Patch 29 adds support for systems with Data Fabric version 3 (Rome and
later).

Patch 30 adds a short glossary for acronyms used in the translation
code.

Patches 31-32 prep for future systems including, but not limited to,
heterogeneous CPU+GPU systems.

Patch 33 adds support for systems with Data Fabric version 3.5
(heterogeneous CPU+GPU systems).

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

This version of the set was rebased on the following set.
https://lkml.kernel.org/r/20211025145018.29985-1-nchatrad@amd.com

I've copied x86@kernel.org for the cover letter and first two patches
that touch arch/x86. The EDAC maintainers are copied for the whole set.

Thanks,
Yazen

Cc: <x86@kernel.org>

Link:
https://lkml.kernel.org/r/20210623192002.3671647-1-yazen.ghannam@amd.com

v2->v3:
* Drop "df_regs" use.
* Include patches needed for CPU+GPU systems.
* Set "df_ops" at module init based on family type.

v1->v2:
* Move address translation code to EDAC.
* Use function pointers to handle code differences between DF versions.
* Add glossary of acronyms.

Muralidhara M K (1):
  EDAC/amd64: Add address translation support for DF3.5

Yazen Ghannam (32):
  x86/MCE/AMD, EDAC/amd64: Move address translation to AMD64 EDAC
  x86/amd_nb, EDAC/amd64: Move DF Indirect Read to AMD64 EDAC
  EDAC/amd64: Allow for DF Indirect Broadcast reads
  EDAC/amd64: Add context struct
  EDAC/amd64: Define Data Fabric operations
  EDAC/amd64: Define functions for DramOffset
  EDAC/amd64: Define function to read DRAM address map registers
  EDAC/amd64: Define function to find interleaving mode
  EDAC/amd64: Define function to denormalize address
  EDAC/amd64: Define function to add DRAM base and hole
  EDAC/amd64: Define function to dehash address
  EDAC/amd64: Define function to check DRAM limit address
  EDAC/amd64: Remove goto statements
  EDAC/amd64: Simplify function parameters
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
  EDAC/amd64: Add glossary of acronyms for address translation
  EDAC/amd64: Add check for when to add DRAM base and hole
  EDAC/amd64: Save the number of block instances

 arch/x86/include/asm/amd_nb.h |   1 -
 arch/x86/include/asm/mce.h    |   3 -
 arch/x86/kernel/amd_nb.c      |  49 +-
 arch/x86/kernel/cpu/mce/amd.c | 200 --------
 drivers/edac/amd64_edac.c     | 911 +++++++++++++++++++++++++++++++++-
 5 files changed, 910 insertions(+), 254 deletions(-)

-- 
2.25.1

