Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3384A42E1A3
	for <lists+linux-edac@lfdr.de>; Thu, 14 Oct 2021 20:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhJNSxY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Oct 2021 14:53:24 -0400
Received: from mail-bn8nam11on2084.outbound.protection.outlook.com ([40.107.236.84]:33377
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231549AbhJNSxX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Oct 2021 14:53:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4pY4IsxoIO0OPX7XmwChc6uupzZTxg+2uJnowaRRqguL7G0+5Bxax/y6ac/3qrVqyv8vHz0LqIoLmJaBmfpvi14vfByxiZcPJjC6mUISblu3FPUlcLRMivxBLWUFkEKvxIMrZaw0pVBUWprFkRbvtqdKdJRQ8NZHChbjXdmarfbi7TKipxsYSBZU6Dpk7CNewrErNupkjJgu1aqDjRpgyPm9H8Pb78r18Q2wVjsT4qcqwvBBJHgxidJbxOhYRm4YGAem8FpYRwYJMMH8hWGUXnYaUic+lpM8LvKuGece1boMc7h+3yBZMaWOHbCYTYydSwYTbQ3Id1HBoUUKC7wVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIl8I6cDhGH3luNq8QONik08Wbf54hWfSuoUQ8Fy5LY=;
 b=BQhIYNjURBKIES6fbTX71Z3/MzB/ERqFygGgFT28HNVa5cmgmqQfcg1fZ/9Y3ta140kKuwFPO93zmdSqBdR1+aiVwYN709ECbl+qbYrD+fWkKLBUnJ/t5wB1hkGi4AzMRRy7ADrAj2IXG/WAyvjGzhI43FRD8DzxQW4tpDgiEykMtyKDsybcDFy7f50m47Pr55DXcCfFh8VgQcraF7/+y6HMw1etauR1G+SwSaDQJvoLTHOLT7ilL2bS+Z+jDRJ9LT+XnajzasZ1YKQDSbqmIBnnUHWPB0ste1pqge1gjgEpnJhu68WJl7v4GYiURq5Mw7xkzwwxNg3Mr3NzH4YRYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIl8I6cDhGH3luNq8QONik08Wbf54hWfSuoUQ8Fy5LY=;
 b=WJCXYCSkF/AfwQoTPQ4Fnhre1Ej5v7pL4D5FbY7PKK1G/6uwenbuCp2RoRda2UX1eiyni+uTZ2+/X0mQcQqAvY7grOtavtHW73EHzxp9HV7XNQO1QWlCZjqVljh/0VfQbU6ahghjLWYnAGoZkIIN6tJ4G3W3Hl0FhCLfk+rXQlg=
Received: from MW4PR04CA0076.namprd04.prod.outlook.com (2603:10b6:303:6b::21)
 by DM4PR12MB5326.namprd12.prod.outlook.com (2603:10b6:5:39f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 14 Oct
 2021 18:51:17 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::e5) by MW4PR04CA0076.outlook.office365.com
 (2603:10b6:303:6b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Thu, 14 Oct 2021 18:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 18:51:16 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 13:51:12 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v4 0/4] x86/edac/amd64: Add support for noncpu nodes
Date:   Fri, 15 Oct 2021 00:20:54 +0530
Message-ID: <20211014185058.9587-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210823185437.94417-1-nchatrad@amd.com>
References: <20210823185437.94417-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71e05570-9061-4753-cc8f-08d98f439a61
X-MS-TrafficTypeDiagnostic: DM4PR12MB5326:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53265682B098EB5656011A22E8B89@DM4PR12MB5326.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KlJ6UHFhDcrOC11f22+oVmAGUAFbpvUBAJkzXvaE4Vs8hKX3PuMKiTzPehyW53peXs4Z81YqH+n9wTXxLMvrWaImxC1EPYneN7vkEL16VU/a3lUWhKQWlTIcOz09QaBDrfYHk2CWhL1YaWiuzOVQkhxQ8RTr1iezN9Gpm4viETY5KvcV7g5Ce9mL7uv4p438yLz/iw3RQX8+2v44UkuQWdQgRsplXhf9El8+1KlKXcsx2m74R1I5tWS9Un+PkHX7uuFJdKXmyy78DtsTrAuPbMkS8HMzNjZ4v5yqk/WPImqZXBUeIRpcPddihgxw6TDG7jZcPyT1ldvOmikiBHuoIpgzuQeclHqUyl0MAhqo0m1PCEqa0aV9ajq2RJ66xEbkWDVE4WwXkHsDdr0wU7uJJ4oX2bzenNsiv4d1ptYdoN6p1MDBmu6xFCUTi8+DViNCfC0d0EICMdYUG3UkykRA0v+H52edf8cM5smofXWXjC/pJIIj5uKnkGhBcCIWm4t53sTPSr3worLehix5c5kDKn4wkJVxmiiZL1tTA9ix5jfunUa7qI84q7btuFjDjN5nXIkLM5Hxbe6mJcMxlRVLcFD0hyRqgweg1B1D90xQWuCm0walZJKOK3qNRn2aIO+KSBNoJpY4pOaSSmaztylGDxOn6PKn5JaUynj/e6pagnPeVzbYJnx6jJMhhRHPRIYGo7GphfJxHTqqMoVp+mizAtgfGJaxWMBvzxm0D4WrD4k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(70206006)(70586007)(1076003)(5660300002)(110136005)(83380400001)(8936002)(186003)(336012)(2616005)(54906003)(426003)(4326008)(47076005)(16526019)(316002)(8676002)(2906002)(36860700001)(508600001)(7696005)(6666004)(36756003)(82310400003)(356005)(26005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 18:51:16.3858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e05570-9061-4753-cc8f-08d98f439a61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On newer heterogeneous systems with AMD CPUs the data fabrics of GPUs
can be connected directly via custom links.

This patchset does the following
1. amd_nb.c:
   a. Add support for northbridges on Aldebaran GPU nodes
   b. export AMD node map details to be used by edac and mce modules
	
2. mce_amd module:
   a. Identify the node ID where the error occurred and map the node id
      to linux enumerated node id.

2. Modifies the amd64_edac module
   a. Add new family op routines
   b. Enumerate UMCs and HBMs on the GPU nodes

This patchset is rebased on top of
"
commit 07416cadfdfa38283b840e700427ae3782c76f6b
Author: Yazen Ghannam <yazen.ghannam@amd.com>
Date:   Tue Oct 5 15:44:19 2021 +0000

    EDAC/amd64: Handle three rank interleaving mode
"

Muralidhara M K (2):
  x86/amd_nb: Add support for northbridges on Aldebaran
  EDAC/amd64: Extend family ops functions

Naveen Krishna Chatradhi (2):
  EDAC/mce_amd: Extract node id from MCA_IPID
  EDAC/amd64: Enumerate memory on Aldebaran GPU nodes

 arch/x86/include/asm/amd_nb.h |   9 +
 arch/x86/kernel/amd_nb.c      | 131 +++++++--
 drivers/edac/amd64_edac.c     | 517 +++++++++++++++++++++++++---------
 drivers/edac/amd64_edac.h     |  33 +++
 drivers/edac/mce_amd.c        |  24 +-
 include/linux/pci_ids.h       |   1 +
 6 files changed, 564 insertions(+), 151 deletions(-)

-- 
2.25.1

