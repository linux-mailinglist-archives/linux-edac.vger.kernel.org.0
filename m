Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4FF439944
	for <lists+linux-edac@lfdr.de>; Mon, 25 Oct 2021 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhJYOxh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Oct 2021 10:53:37 -0400
Received: from mail-dm3nam07on2069.outbound.protection.outlook.com ([40.107.95.69]:49377
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233661AbhJYOxJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 25 Oct 2021 10:53:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZucI4MqiadID6tBMMvigJ3VoXMuyJTm7VnNV/tAMGleLJP+vhP/S83YTXehUAODAVczW3C9iR5gJKbErmOIDMLYtc+JZ/zgW+XSfJbNcYo54rhZ8lVn0uWvzzdlFgxMWBk/Sej2XGe3cMDmEsVfBMR0AQeDf+ThQ/iYfWiKpoJvlXM8sL3VDtoXpsyrRmXVAz27ELq8Kv+PwZHbaSrGahAmu1d8FRFW2TRf0tiUvfrI+f4RpPyZjsz26NK7zyW29L2h26B78PbEJWkhkr24g9p4WLr2HVZkmHK0WGQFjMKGNfpsXxptevIaN8eV+EtC9APhv1Vc1DRLGbE87jLaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUJ0a2+DYtAsQJNxVoFvBK7Q/KA2sSe2bk0k7NCdjg0=;
 b=FHP3Uokj1PlHlui8jdsvHLPYkCZFcnnw+0BWiRPqeO7gm2VWwgpToSV7Zud78RIKENHSDQhUePAR1XZ8sBynRu+I/sEsVLluV74XdczhQcb+j3mmztqgGuueRncbhD6NpRntneCxxFMyDd8y3sHgZW/aA0Lstg0G+4HAUE2l4Hm9SePP/MgHH3al+pR+OinSZx2Kiv4wR1r8tR8Pq2+ajELg5LpQO1Ycw0BAr92jaw33YvqacZtLpIHoTDz2AxuGj9C45L7/ZqqWHALb3qU65wXooM800gcmU96xEIuLoATaG4Zi0A/Oc14ajwhwC+sciUZFu6AeQiBj8bRiFzgUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUJ0a2+DYtAsQJNxVoFvBK7Q/KA2sSe2bk0k7NCdjg0=;
 b=oRLAA0WxQHpvLhPeD+LBkAFrcfjRzd+fVXohAyp90UNM1z3yHaafS/yF4390CsXEfS25Uq/8OY7nAxvdFUt/VIPsohZBjxPx2C7Simu2LqjsvTk65TrasxugdJAIg9jtQ+uqaDU6icDMHySAaapbEm2d6CUwLR7k+OBJnzx+wbY=
Received: from MW4PR04CA0097.namprd04.prod.outlook.com (2603:10b6:303:83::12)
 by BN8PR12MB3603.namprd12.prod.outlook.com (2603:10b6:408:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 14:50:42 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::c1) by MW4PR04CA0097.outlook.office365.com
 (2603:10b6:303:83::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 14:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 14:50:41 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 09:50:37 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v5 0/5] x86/edac/amd64: Add heterogeneous node support
Date:   Mon, 25 Oct 2021 20:20:13 +0530
Message-ID: <20211025145018.29985-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00f0028d-bfee-4363-f84c-08d997c6d114
X-MS-TrafficTypeDiagnostic: BN8PR12MB3603:
X-Microsoft-Antispam-PRVS: <BN8PR12MB360320162AD8BB99FD536E5EE8839@BN8PR12MB3603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4o2Je5YX0CIk1vBuuv4MvXtcQOukGfOvHSEcaTb/j2ps7NTRDGrgJNkzeYIsI9JjITkET9rr8Mky9lMUtqcL6dvdBvw9XvV3EPRUwnlXrsmhZsf62xhf/vSiDiW8DVUWeG7JnJl6h7YpDuQN/oqXjp1sfVGLarkAz33cfvJFhcyL83XoKvrk4qL6HeqRVEaCVXLw8gS3IMqZf+RtSdFrKGjKaiENjPbNbbQG3ZczAaptgyJx/9hMO9K0SNvUzL2kG8n4oT+iNPileihCwi1foNF4CZglhvr9TXSTZYiYs1oovucgI1kHfIeC5NMTT6D1Qx8c4w/kEUr6TkLzROcbCMjMirA6WO1rjZ9i1IYiQyRtvfa6mhfJalwiQUmU5ItxBEtyqU2k1KtJjCvxioqROnhl7A+K9lyw9PhdQLXbBfo3xoxMPtez/QmAadz9pzNYjjqVb8fSOzqICENJtDY8BaERv/+dT+q1mjpsPgYLHssGqYfEhxcFqWNZ4Lq/EZXRyQ7vsX380sfQkp1rOi353/qNuYtzq7eHOD1tM6ir+4QYDvVf1IH6W3ECTLFYwO+HRCgbV8hajUc65SvpWaCguIfRVmLc/R3Or2i4UG+BsN6fphZNsMceN6FoLGClIc2BKjrISUFtj6Doh/dLd5v9ZSePYga9bo/6mcaocZJdL2BfYwzQKjqD6C+rUNTZy3jKX/MxstBe9MRUJhXdrprqB5JeNakWXWuTjhizUMIiUsw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(316002)(5660300002)(7696005)(36756003)(336012)(16526019)(2616005)(26005)(186003)(426003)(8936002)(110136005)(4326008)(508600001)(83380400001)(36860700001)(2906002)(54906003)(8676002)(47076005)(81166007)(6666004)(70206006)(70586007)(82310400003)(356005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 14:50:41.5317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f0028d-bfee-4363-f84c-08d997c6d114
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3603
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On newer heterogeneous systems with AMD CPUs the data fabrics of GPUs
can be connected directly via custom links.

This series of patchset does the following
1. amd_nb.c:
   a. Add support for northbridges on Aldebaran GPU nodes
   b. export AMD node map details to be used by edac and mce modules
	
2. mce_amd module:
   a. Identify the node ID where the error occurred and map the node
      id to linux enumerated node id.

3. amd64_edac module
   a. Add new family op routines
   b. Enumerate UMCs and HBMs on the GPU nodes
   c. Move fam_type structure into amd64_pvt struct

This patchset is rebased on top of
"
commit 07416cadfdfa38283b840e700427ae3782c76f6b
Author: Yazen Ghannam <yazen.ghannam@amd.com>
Date:   Tue Oct 5 15:44:19 2021 +0000

    EDAC/amd64: Handle three rank interleaving mode
"

Muralidhara M K (3):
  x86/amd_nb: Add support for northbridges on Aldebaran
  EDAC/amd64: Extend family ops functions
  EDAC/amd64: Move struct fam_type into amd64_pvt structure

Naveen Krishna Chatradhi (2):
  EDAC/mce_amd: Extract node id from MCA_IPID
  EDAC/amd64: Enumerate memory on Aldebaran GPU nodes

 arch/x86/include/asm/amd_nb.h |   9 +
 arch/x86/kernel/amd_nb.c      | 150 +++++++--
 drivers/edac/amd64_edac.c     | 592 +++++++++++++++++++++++++---------
 drivers/edac/amd64_edac.h     |  39 ++-
 drivers/edac/mce_amd.c        |  24 +-
 include/linux/pci_ids.h       |   1 +
 6 files changed, 630 insertions(+), 185 deletions(-)

-- 
2.25.1

