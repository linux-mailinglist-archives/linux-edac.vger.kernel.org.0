Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E6242E1B1
	for <lists+linux-edac@lfdr.de>; Thu, 14 Oct 2021 20:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhJNS4q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Oct 2021 14:56:46 -0400
Received: from mail-dm6nam08on2082.outbound.protection.outlook.com ([40.107.102.82]:8097
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229587AbhJNS4q (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Oct 2021 14:56:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv8w/jzR06hkagbzKjx2Gn+rFSohKJn38Lda+DtDlyejEI2UefJDk9btc88bgTJp6SsmsuO8pDjXj0+4U2+MFxf52Osn52U0YurPhg8F8yiqDxd5sFc/x7kGiDR4frOrtSj++f9fOmyXTsQlfjIXFT10IGt+OyQOsCSg7h1oOW76VIiaZ2fXkcAL97AvIoNIaRiMiaBCpab3aLPPIjwoOgoK6AXU34vtCU6/fq0BTGQCfXs0CtlJIpWjp2HGcuqIhyxaMi9CCYGEmnBOZG503dVRHaZ9xZqNb1vq2CZeFjPyhKI2YNW85Dvc7ClO0Bi8Ap3iv5X5EilTooGECPqYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIl8I6cDhGH3luNq8QONik08Wbf54hWfSuoUQ8Fy5LY=;
 b=SyqhkZ+3S16F+0QaByL6XZNpB8gcZRgWr6LvKrS3hkT1X1PDwElkRqFE0kpO047M9wBrsLGy6KMNKd0St6pbBTNi/08uWHB+AqMwEMqJ22cQ3G2Hq9uTK7aRgOCpOQ6n06FIzLS0IyJE4K3JjPYN/4C2C3p+Vuq8WUj10LD8D1PwH+Le3PogELe3yp8Z5D3dnqweDj8ZOOmV1RsBYyncgBoRy9JJJoagL+eeXR/t5g+kkRv/akjEFVCfYkszBwqBYPnxaXtLwP7rWyJUJlVNF+EMNKbgrwOXxOKkXxJ7g9sjtFbi+Y8pPzDp6LaUUZYRUDF5wX+CLKCH/JkOW82pRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIl8I6cDhGH3luNq8QONik08Wbf54hWfSuoUQ8Fy5LY=;
 b=5WYCUY/SjwGF41is7ErkpYWAjQmVnMlbKD1GGvZ27QnT0lbrsq+eiZr/28fZPGb7nI+1bhjl/YaVbITbHArj/yX0F8XspEkOJ3BloYgZ3kLK1hEsm94u2UgjE6/bn3+OKBBG8eNSq2ESfg7HmzaO5CwV/X5CwPLnmmc16n8N7Fo=
Received: from CO2PR04CA0005.namprd04.prod.outlook.com (2603:10b6:102:1::15)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 14 Oct
 2021 18:54:38 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::35) by CO2PR04CA0005.outlook.office365.com
 (2603:10b6:102:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Thu, 14 Oct 2021 18:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 18:54:38 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 13:54:34 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v4 0/4] x86/edac/amd64: Add support for noncpu nodes
Date:   Fri, 15 Oct 2021 00:23:56 +0530
Message-ID: <20211014185400.10451-1-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 75965576-3989-4c47-708f-08d98f4412c6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4161:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41618BDF07916752AEE13E2DE8B89@BY5PR12MB4161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/RZgAJr8dFJ4ONI/Exl4ay0Bky3ZAgv9SMcmlyKdWhPcIxGaTULXyHWxdIMRD8VJupBX65kR3YxUuARXQdoDgDHoqoo3ffut9FfFb+NKKtG9zA41Wf2ycBdUD+lrdi16WOUmsL37omOvtJI9qBNZMPjOjY4O9gzTG9wu4b4y0okmu0/5yLwwpVRmmf5UkFb7aWnB8TSYcFhE/9xPnvetSQE7eTiP6oyN9fmPMnD52K+sK7LMMWhQizyOIQ+Q/5f2Zk0H0UEhtqz44DAYd2H93wW5MclthRZMy/UjGKtfE7D/N7yKawJHIChMq0Xxe7OufXrzh4bHn83ycKgwdjwMPfzxo7WyPr3txAA9yCMlP1oW+dylnUP+ZfmDXzWdnSW6h9RRSS/71pIBO50a4a1mUMJQKcu8I3n2yjzmXHW94Sssfs1gPZOZd4IgkH8KYnCwydt6wTecQ0d0WBBY396zxu1lNOU0MDgyimx13WHoPM9t4yZ5lI//fGh4g7sap2g8B4HPrON5g32/KAd5gcsBQVTt+qikK1ZWMBGboAoh4ke9Hs2wvVRhnw7QdV5BX3/fQUccbIZHt9Fv182/lkX5II5Wg902A6qdOANl9GlHWoW5rvgrMvCzn1cWIJkzY/iHUUJ8gPMXL9O65jNreXFcOp6S9WbbileGuMdRqhJhMqd23w4APAXmO6HoNNm1lKddO6QGCV7vhSsmKZSsWcMJLn5I24DCJkQjQ2iS4M5v9E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(336012)(36756003)(356005)(81166007)(36860700001)(26005)(16526019)(4326008)(7696005)(8676002)(5660300002)(47076005)(186003)(1076003)(2906002)(508600001)(8936002)(6666004)(70586007)(83380400001)(70206006)(82310400003)(426003)(2616005)(316002)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 18:54:38.3719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75965576-3989-4c47-708f-08d98f4412c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
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

