Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E7F3E7E25
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 19:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhHJRXN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 13:23:13 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:52769
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230289AbhHJRXJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Aug 2021 13:23:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMkbLb9/Bm2q0kdwZRCOu+P7XccUSts9Fa9slL+pKAjVmGpjqdCrtaWyzV6o/q2fZcZrDOVO79nNniddgDcF5qc/PkQ2fx5EBJx/RosN6UrTOTHfQ/w8e373nrkImG+RCbY2S2QZDHcHnXp5M+wUUI0xyC4XrcHRBj+LynCZSf2D3kV/3FqFfz4AbOablGrXSPApBNeUbylyCqNSvzgxbSa4YKRiiFkpCERS7jFlpiMWhLQI4uSI66ysY61n50uqmYi62sl6kzFtNJ6MOcwYb3Ze/k1JgMhZ7JKUNJWh6/MpXSTmSettnS3Wroc7wbm1IPC8xSxYSLdE7TcIl2Kh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8brDnTnfOWAAVqWd6l9Vl1VdZOPiCHkpCzQjId72kM=;
 b=hSvQA5fQ0im0bALPjPehcknTIbjNSKRZLPQ3b8U/91K0iwevwdf29K8j3fyWdpSVhoF5PFRduoQeoc9vIaejDtUsGuIqyu7a2MC4E/H6qFARNI7C7ftSbUvjUWlyjk0TayDpSqUzgfCoY3obEUsGywfOnISutCZqa6srAmzoysRRYC2NXvStrlujTWzjba9kQnHA46EYP7tuJRGY76T4QX4cL66bs2ny+F2JMyDogATfDgHoYy50yqUpUSBQ862XxWzO5v2JEr7RQ8ObQ7a9W33xUcN8FAeaxqPG9OajKCErmfR+g1H/poIVHyo2EnnfIjvGkFmXO4pF1XtANQCYoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8brDnTnfOWAAVqWd6l9Vl1VdZOPiCHkpCzQjId72kM=;
 b=SE0Ptsz2drXt+zKZLBcpek4xtqcTfzO/ergIVOvQMyyiqEF0Wtarn94egs7kwUJsiRKwzziYY8WuxudZGRhEBB2LuO3mbSxfCLXa5uTpUmt422tC8DT7C8wM8SZIQx5PaLRg8Mur3W4VeEFsVpBRLJpZ9bhzpbpJlkDbYDqA+q4=
Received: from MWHPR04CA0058.namprd04.prod.outlook.com (2603:10b6:300:6c::20)
 by BL0PR12MB4946.namprd12.prod.outlook.com (2603:10b6:208:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 17:22:46 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::c8) by MWHPR04CA0058.outlook.office365.com
 (2603:10b6:300:6c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Tue, 10 Aug 2021 17:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 17:22:45 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 12:22:42 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <mchehab+huawei@kernel.org>, <yazen.ghannam@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 0/4] rasdaemon: Add support for AMD CPUs family 19h
Date:   Tue, 10 Aug 2021 22:52:10 +0530
Message-ID: <20210810172214.134099-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6043d6c-7a4c-48e9-9999-08d95c237812
X-MS-TrafficTypeDiagnostic: BL0PR12MB4946:
X-Microsoft-Antispam-PRVS: <BL0PR12MB49468F073A6F8AA6C362E36DE8F79@BL0PR12MB4946.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AZXFeSSboot56AaqLgkvdBqX+wQGFnjai3bdDX83ZIKbCSaDE0m+eZEa66ei4icB56+G2jpz+R0bG3uBUJKQsYwA7BI1Y2qagarAwcFYauRT3V3/U+DcJB6g5nNBeyoZRJXRJ+3PrSm8ZqpzLEgGlvXp7pLFdCaCSOE7o2CmaYocIc87F/6sLUxVglvLUUxg5+rfVxScwaLA+umDjuwOnR8wzxDS6Wf0gQfeSYA9bcLeXS1jOASKRy8rl2IF3WeRn9mA81HN0H3gPbLnS0xNnBgfwJmBGB0pdBdyC7nrJKeS9Gm6/2sMtKIH5ESJrp8EnM/HLPj9/+EQ0rJXg/P5Ohx/wOeY+epnoRRO2SsnHmZBMoOrlbP3XqF2wpSzSGFdXVqRd33nG0nj00R3zuWkid9A+lD+rpQeKVjSTVSG8Puw5uVNd6ylTbGAz6DWy6KVHPYftNdgqTgd5Ezdena0Na3h8j5fJKYcHQBlDF3UZfF02DCRRB5XyDWDbupCVa+g2ocydqKNZ2mNl0Xuql6bOaqjlc8OZTndHbS1c75tUAolTNdypMFUcGg/xfQ9rMa4famQPQZNZSwS5seogwU6v1oWi7UtRMQBJ+fRulw1Tp0jBKgjDkt89DmBj68krVQgcCLDPUYVJgHFMW31UIbo38Sr94tJdr7t8T3VvYrFshWUpyYhNUXiLCEvEB4vYEI8QVbDJEp/7/x+0c4MzCQU+O1Lc88KoB01pqfBuy6MWXyb3yHiXlzE+/G8duRnPtL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966006)(36840700001)(2616005)(8676002)(54906003)(336012)(478600001)(316002)(186003)(16526019)(36860700001)(2906002)(6916009)(7696005)(26005)(83380400001)(356005)(6666004)(426003)(82740400003)(36756003)(47076005)(1076003)(70206006)(4326008)(82310400003)(81166007)(8936002)(70586007)(4744005)(34020700004)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 17:22:45.6132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6043d6c-7a4c-48e9-9999-08d95c237812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4946
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch set adds
1. Error decoding for newer banks
2. Set max number of banks per cpu to 64
3. Error decoding for SMCA banks on noncpu nodes
4. Support family 19h CPUs from AMD

Muralidhara M K (3):
  rasdaemon: set SMCA maximum number of banks to 64
  rasdaemon: Enumerate memory on noncpu nodes
  rasdaemon: Support MCE for AMD CPU family 19h

Naveen Krishna Chatradhi (1):
  rasdaemon: Add new SMCA bank types with error decoding

 mce-amd-smca.c    | 188 +++++++++++++++++++++++++++++++++++++++-------
 ras-mce-handler.c |   2 +-
 2 files changed, 162 insertions(+), 28 deletions(-)

-- 
2.17.1

