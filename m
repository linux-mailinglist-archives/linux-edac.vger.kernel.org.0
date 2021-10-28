Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD1143E179
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhJ1ND4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 09:03:56 -0400
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com ([40.107.92.53]:56672
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230240AbhJ1NDy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 09:03:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKt0vRwkaFfq/OJlEm4Duu2fsBQk3bui/qeq16b24Yc6Tj7OtdKeuUkcc8AgC6STLWVGktiV4v4SlVPT/agt4aViyMlSJcsIo+ptesWl0i7tWgwvmqfHucQYkEaKSXVePBPs2vf1/tWAyn9XUGyFyzlhXGUZXj2ZOJ5yJGUd3skbpYR7XVfH50Nw5ZFbdOnZJPZtm9Zaj20MNPC23wO/E9I5qNw1Fg+EArUcqyL7qNrX8r5ePNMvCf8rsl1Tzw5ppRkSAzWPgSrGU5ElnxgMU7vDcoB063lHyO0NS3AJ2QygBBF2Q58FwPLVZXr627bYms5krVNOwir/2/6urmhKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWtj3L4pzt+9mxtmlMfHd7MZHgxuN9zGtviBD9pmGUY=;
 b=VhT79s2sBM/oe2SF7pC7eilhwGjUaoJZ+RwXeLDRaT+xZpqHySyHWOY0+ox+rzQVKzZYJs+2BWDOf0R3z0ZOB9hqgH2MRP83UyxMOQQsF1gdpAt8CORn2C38LFVoGngnXxUEt09lOrqflvXygmJ9T5Qc1k+otcrRT/JT3NeaQSEPwimYw+JH7XIStAj7hlnNq3BsNJxOMEDF3koh9oh+GZd7TBf66yxDc6nJJ8Uxdc5JsuwwohoksXqyUgHwKj/15aEiLquDQ1irLXJUOEDalN1CJZfWeHL1/bIeUUM2toDXvddcDiM45NNxYRculSys9DmLFBwzmmu3+JfnpglKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWtj3L4pzt+9mxtmlMfHd7MZHgxuN9zGtviBD9pmGUY=;
 b=UNdaySiTUlA5KNs5wd85YC6rwdjdBhhVxN0Ud+gN7KLeoDXNn7jkrP1EZAC3rCUE5joQlGLIH+ppqg9MPVfyqpOtaz0qQd/lPe0Eev8fyenGuDd+o3bXFoUEy17Gs/3376qrJr8D9nkNuoG3F+XHACEurtRWKhfFqOQJSFnkdq0=
Received: from DM6PR10CA0035.namprd10.prod.outlook.com (2603:10b6:5:60::48) by
 BN8PR12MB4772.namprd12.prod.outlook.com (2603:10b6:408:73::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.20; Thu, 28 Oct 2021 13:01:25 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::7c) by DM6PR10CA0035.outlook.office365.com
 (2603:10b6:5:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 13:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 13:01:25 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 08:01:19 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v6 0/5] x86/edac/amd64: Add heterogeneous node support
Date:   Thu, 28 Oct 2021 18:31:01 +0530
Message-ID: <20211028130106.15701-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2734c5e3-a945-42b3-714e-08d99a130c9a
X-MS-TrafficTypeDiagnostic: BN8PR12MB4772:
X-Microsoft-Antispam-PRVS: <BN8PR12MB47724E4F7C134A092465121FE8869@BN8PR12MB4772.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hW7c4InGAy08PSQUcg1O0G9Rf1SIaIJQfOsFtyxHOh89bFCcuCzs7A9LIG/gKh8lq9lmz+YNrK11ptiYaTI9MQTlNwjsFAEmcTYgS7Eop766/A3I1yyAcnbIEN8Ucpj2MF3cPsld6zVZaFW/wVsjxuWBhSKK1ITFK5abElXwKN+FzWhOkvDYcopK5kjqZhV6aLUqgCkR4/HtTC5CSETBJ9GRJgP/7w9hTxcchRq5EQ/5luTQSVeID01/g6dBPiiTyNYgRUflKuih2aBY4K8zJPPC7qrWjNZzw0Y6mJRvLHjxhrhNzjvi7Q3NoITj4tGfLYNl412DibbtbLv//ZGZima+XQiaCrIKLS0oO6cYFNE/SGfWAODaeOMZl681k3huOBO0vgkocLXLmkYJiXPy3AOIzCb5zh8jSpqItAH7Ur7cDYjviLSERUE/kCpF+tq+T8fiFjhDbyRSJ/KYx1q8+a+X+hIUhGqKVzMHy1B3JG6IUMNpztVoTEnkISvJBznzAm2j9BFhKXyz7dw1Fpf0z8j+wims4WA52m+U3geEwSywVqUyJmQ2bxWgzFi4+zI9QYbCIgVfCrqTgkVsbapcG8Y5xx4swmufxaAdKZjk5NjCFE7XMOk2EaVChMkmti6kwrCrLDEuqR4NUicfRPUNCm0DAsLYuxa9KYEZa8DhYrLE8OaSe+ZMl0IbsI4gelAo/aOicCaleSgYGsPF7ENNQAvxBVXNWm8GjreU/my6gis=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36860700001)(36756003)(26005)(4326008)(70206006)(2616005)(186003)(2906002)(16526019)(8936002)(5660300002)(110136005)(70586007)(6666004)(336012)(8676002)(81166007)(316002)(356005)(508600001)(1076003)(83380400001)(54906003)(426003)(7696005)(82310400003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 13:01:25.5080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2734c5e3-a945-42b3-714e-08d99a130c9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4772
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
 arch/x86/kernel/amd_nb.c      | 146 ++++++--
 drivers/edac/amd64_edac.c     | 654 ++++++++++++++++++++++++----------
 drivers/edac/amd64_edac.h     |  39 +-
 drivers/edac/mce_amd.c        |  24 +-
 include/linux/pci_ids.h       |   1 +
 6 files changed, 663 insertions(+), 210 deletions(-)

-- 
2.25.1

