Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5474A8AAD
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 18:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353092AbiBCRu3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 12:50:29 -0500
Received: from mail-dm6nam11on2045.outbound.protection.outlook.com ([40.107.223.45]:43872
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232884AbiBCRu0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HakDJi6+XWsPREuVkP/ufuB3/NtiDBGdt1IJ0mnn+pSM0oc3l5ROnwSvU8Nn05UddkhrrzPIxDlyw0eV97+Inut9Ah/3qVlg2Fop7AS6ca9nj97MRhlo7+AX3YgLv5FIY1kpUTv9VywkFMKNfHLS9YYyugKBTO4NchPoDh7FHlOGVu+iWG76Yt4AxgOI+jlKz/eLASX58bKQZ3TjWG7Fdw2QKAuLz74fjODVKZekGkMSuGhgGnBScgIrQzqTvgv7PKRLBoYkn5gebSdUT5B0uHvHfvnsgX6kEJfmtgbJxEE/BC6t1p/8VBzgiamAc69g2gHJMt7uaVI71bcg4ul1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+B27CHrmeFJSZnWsREzmJFTYJc+DrmQm/zVxxgNRhM=;
 b=BfGRwSfnRFQ74+vNqCBgD6gCJenLD/bwreEj9O3vHZq7/RWuMkqi6x0HB1Yb8S+cFgYehsrdk2iRwuRDOwknK7gMdPgfbqDe1uPKMQHVeJVtBuppK5UMMt92mG2ozwANbZeJF/rTf4P0SMnjKGn4cCSyGryouT7PIBNRM2+usQBeP3W1UqUe/j6ln3vshGogAFMAOmIm7GxFxmrcRgzrtGB0ikK3HDvmVO03ldJsEIgY84MefQhF0++4URlgC6ZrDjPvAYghAUnRdD/LgIpTzCgkhBxnjrx7ooAz+6pQ+gX7T9CAx+xlYgcCsppW52EIi0xZ3jsI8kx91FIF+mD3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+B27CHrmeFJSZnWsREzmJFTYJc+DrmQm/zVxxgNRhM=;
 b=Ye0UgyCVZVxT+f2V3Mg3aAnXbFxYeuYR1GnzLW1PB0DEGwb6y3foU+05TEd45CjEzS2AV8R5l/JTfXtZAXaJsos76LOSHHuS1Kll+Qk5XV2FfxBPMxsWHAP5uV4ZrsSVf63F8pZQ7mTxzjzJtC0WiCkqf7EaX6WtgacwZTXl4+A=
Received: from MW4PR02CA0023.namprd02.prod.outlook.com (2603:10b6:303:16d::16)
 by MN2PR12MB3232.namprd12.prod.outlook.com (2603:10b6:208:ab::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 3 Feb
 2022 17:50:24 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::d) by MW4PR02CA0023.outlook.office365.com
 (2603:10b6:303:16d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 17:50:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:50:23 +0000
Received: from node-bp128-r03d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 11:50:22 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH v7 00/12] x86/edac/amd64: Add support for GPU nodes
Date:   Thu, 3 Feb 2022 11:49:30 -0600
Message-ID: <20220203174942.31630-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db6d6583-b686-4d8a-58cd-08d9e73da755
X-MS-TrafficTypeDiagnostic: MN2PR12MB3232:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB323253FEE68AFC041A4CEBD0E8289@MN2PR12MB3232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4m307VG4Pz9O6tBrRyCYOp9tkcWkS/1cvcDQ3IAGiQMk9IoezueRLUXgiQJp7nKEBYio+/mNtuf/KAEYirmHXMCUHR/+1qEOaw/pgusHMQ3km4ylQyZLVSushHT/VyfTXKNrwsZ4Z3/k56UQxKxkcqPD5xeCAQEco+LRoBv4vxT0W82X50UNAoxv0f04Kfp0qjMXh63EVQE7P0LS04rJJc5CD5w0EM1zUaxaQ+y07nn3AGj61sxRl4ToC0vWVwH5uApsiy7pVeW705OxjJsavtLsmerq6qX2jJ8+O+JxZGR+2uU1MxKPsxy05kdXfUP+vbyNvjA9UA/ITrSh2jYjBW/DBiqYaq3wwabcunAL7WMb2cOc314LVsoCQ89c4Sf3DCrqDNNF1NShChltnkQs7uhyglYd0z6iBOj/pPf+OkErnxw3wzLM9hEfJGzjRbaHW+lR77giA5Lboh0EAevNAAd7SL2KH7QcPpUiTxB+qV3JPktkiCkKopusybaz8/W8vtDkAyl/GolP1KNpW/UbXh1/k+7Vxs4uLgPGtaXpEcltI7VxinI2RncbPOMZQCfPp18LFmlRO9Kk1bJU3BpT/99APakQ10VrEC6MkdBv/6U2MW7jS1NETrwmYPPAZfSnGJ5bq+Y/0TXVveqVOaeww7QiXze33j/sBudYWM9N6cwjjwdieFOMoGmuAmzHSj6IFLbSXCfZOhgwx3VslZf+EWXNPaI1RW912DHo9L6tvppkgMFgv0lhLFepC1mtMlZxs9fCSGWhnm0D1nn8f8N7QGmBtyGhRzyVIhjkltL2LMs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(47076005)(40460700003)(70206006)(36756003)(5660300002)(508600001)(70586007)(7696005)(966005)(316002)(8936002)(54906003)(4326008)(8676002)(110136005)(336012)(1076003)(2616005)(82310400004)(26005)(356005)(426003)(186003)(36860700001)(83380400001)(81166007)(2906002)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:50:23.4170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6d6583-b686-4d8a-58cd-08d9e73da755
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3232
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

On heterogeneous systems made up of AMD CPUs and GPUs, where the
data fabrics of CPUs and GPUs are connected directly via custom links.
UMC MCA banks on GPUs can be viewed similar to the UMCs banks on the CPUs.
Hence, memory errors on GPU UMCs can be reported via edac framework.

This patchset applies on top of the following series
[v4,00/24] AMD MCA Address Translation Updates
https://patchwork.kernel.org/project/linux-edac/cover/20220127204115.384161-1-yazen.ghannam@amd.com/

Each patch was build tested individually. The entire set was
tested for address translation and error counts on GPU
memory.

This patchset does the following
1. edac.rst:
   a. Add Documentation support for heterogeneous systems

2. amd_nb.c:
   a. Add support for northbridges on Aldebaran GPU nodes
   b. export AMD node map details to be used by edac and mce modules
	
3. mce_amd module:
   a. Identify the node ID where the error is and map the node id
      to linux enumerated node id.

4. Modifies the amd64_edac module
   a. Refactor the code, define new family op routines and use
      struct amd64_pvt. Making struct fam_type obsolete.
   b. Enumerate UMCs and HBMs on the GPU nodes

5. DF3.5 Address translation support
   a. Support Data Fabric 3.5 Address translation
   b. Fixed UMC to CS mapping for errors


Muralidhara M K (6):
  EDAC/amd64: edac.rst: Add Doc support for heterogeneous systems
  x86/amd_nb: Add support for northbridges on Aldebaran
  EDAC/amd64: Move struct fam_type variables into amd64_pvt structure
  EDAC/amd64: Define dynamic family ops routines
  EDAC/amd64: Add AMD heterogeneous family 19h Model 30h-3fh
  EDAC/amd64: Add address translation support for DF3.5

Naveen Krishna Chatradhi (3):
  EDAC/mce_amd: Extract node id from MCA_IPID
  EDAC/amd64: Enumerate Aldebaran GPU nodes by adding family ops
  EDAC/amd64: Add Family ops to update GPU csrow and channel info

Yazen Ghannam (3):
  EDAC/amd64: Add check for when to add DRAM base and hole
  EDAC/amd64: Save the number of block instances
  EDAC/amd64: Add fixed UMC to CS mapping

 Documentation/driver-api/edac.rst |    9 +
 arch/x86/include/asm/amd_nb.h     |    9 +
 arch/x86/kernel/amd_nb.c          |  149 ++-
 drivers/edac/amd64_edac.c         | 1450 ++++++++++++++++++++---------
 drivers/edac/amd64_edac.h         |  203 +++-
 drivers/edac/mce_amd.c            |   23 +-
 include/linux/pci_ids.h           |    1 +
 7 files changed, 1345 insertions(+), 499 deletions(-)

-- 
2.25.1

