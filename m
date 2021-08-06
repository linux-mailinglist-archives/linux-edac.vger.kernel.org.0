Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39FC3E23AA
	for <lists+linux-edac@lfdr.de>; Fri,  6 Aug 2021 09:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbhHFHEH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Aug 2021 03:04:07 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:65121
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243496AbhHFHEG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 6 Aug 2021 03:04:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+LD6TOl8Oj0rNkw2oNmxaBY5TjuEfv3po4nIvDy/0ut6Ua1v4U3576jlzl484HHnEFKJa1R5pnKjRuI+a8QzAjrRDfqoc986NPe5n6tR3zV+9CgNITiUhp8nXpZDItFrsDP/+7yZYzgWQedrGXcu6DCUzqjgnjZhcoQr835xkpiV63ZtIanIsKuQI5LkbFwj1m/DI7r5Br/92ElH5SeODgBPSjMgoXpVqULa26tK3iyG+oNLDHqwLeorHJ+vaThgEY42bANI5BEcKen39+BLkyjMuYbpayvkXOGp3Fj0cKdYzk+i1cll5gJZgyFIOQfq/kjBBPTszIqVOOJ56/abg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFpMPDnVCIEA9rgQJf9Km2MpOiZ5KNT7NryR7xZnSrI=;
 b=U/4/Gth/vw7E6hdZuXn8gvHbVFdgC5HBK6CVUV8s36tVrxge+RQot0Wv1Tyej7iThhEoOW2A84Lhca6XoO0lvx3MXfjmhY3DwQl1jLr3TQPiPwXo/o42pMfKCAYTX/s/5RnHP6HmdGhb2J1hkHlmvz7IbRkJp+w6AzYpFT7+y+W9arzyEEZXf93sj5pCaaSzblDdpY31Wd2CnGfjfb/WQOqM4YKgn7uL+hSUOB0OkhSE062NtKWcHPqu9Xqsho3KaV4jenLd8o18TBDUIBiFivFg/bp2bOfr/0qybyJVK+0xuxL2Ev3bTbogz9qjtGlALEiEcYnmZ5ri7/hYM5nCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFpMPDnVCIEA9rgQJf9Km2MpOiZ5KNT7NryR7xZnSrI=;
 b=a58gjzCTbzMH4Cn4o+YxgN/ux/szE1LHSX5OA2SVxHzrqNPgauh6IIp5/VDbop79qlJeS9ym4rvROF5yqeauuzZPM+YvcSpiH4vBzvsC7XFNRWb0RiitFscfku55UHMJ45py0GLUwOAspShJbvNgttLzx5Xa/rJx0va1ZhlH10o=
Received: from BN9P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::18)
 by DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15; Fri, 6 Aug 2021 07:03:50 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::90) by BN9P220CA0013.outlook.office365.com
 (2603:10b6:408:13e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend
 Transport; Fri, 6 Aug 2021 07:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 07:03:49 +0000
Received: from SLES15.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 02:03:47 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH v2 0/3] x86/edac/amd64: Add support for noncpu nodes
Date:   Fri, 6 Aug 2021 13:13:47 +0530
Message-ID: <20210806074350.114614-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210630152828.162659-1-nchatrad@amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35699899-ca4d-4127-3140-08d958a85789
X-MS-TrafficTypeDiagnostic: DM5PR12MB1308:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13081A460716652EEBB0D826E8F39@DM5PR12MB1308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQVB+SyesxVkD5LahkCQKC6U9NCzqSD4GOOWoxaPXJBG3bxFKzYyX7Hu4vWbjxWBKZL4A+jc1KrTMjnnI9Z1V4+sS+r90k+4a8fm64f4eEBPkBODnMhLk/D4blJ6yT81eZnS2Abdotx+Nq5tLeCH014DAgTAkXoJZKYKiiK18Qsb3N5yimTUadHnbLmEUOs2MHdRbSqSOgvH0OsJzRjd5S3F91VaHdVJvkgueQtsd73QEEU31AckPq9eK+w44E3gBoXE57g9x10X+4MhrQcg8zlUfwlBMVsu9KldHEKCf4hKgY8WP9szScMnKtZr2gncdMIZQVkU8W8Mc6bnT7o3CMm1/4eo/cisPFaqgoCJ+Lv1+56xxAwBZLof3OFqm1qT1IspOojXUMt0WRfXbVmnEbuNVR8Bk4Fpx2rd1f/Kt+XSAoOG/UTYn9IfW2XxjnWflrWXSJjCb7bKyvUQBwHT5GrGZQ/7Oi08430xfNiY2ngWPAwzPtnVY16mGsfDK6ERllFBDFDzRC2+b469pv6pHW9sUpo6Wa4co8rKeLXulbv62R5SD3DDRmkUOxBpuUflzlOKPAnO442m0GML6mm0CdS1NF8Ryz+kCP/bFmyZATJAD/ru8mj3CBY6tI2bqz4e2kuIoqK8rX58r6vOUNpmkSVyCwaOhXGER6mgGXjeN1xR7+KMzU+VA7BMcfBFtYTHFmwJXZNMEtetrbwAItT8ulCwDRLIUlNogKxsyAgU3bFJ8Em4DwsGkqVlFxQyiKFYcTMt3xlPRORu1tUtnvCeQTMzzeKN9CV5AY63E4c2caJqfYkWewMxSRE9r1Ot4HAt
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(36840700001)(46966006)(426003)(81166007)(336012)(83380400001)(2906002)(110136005)(7696005)(4326008)(70586007)(2616005)(54906003)(356005)(82740400003)(47076005)(8936002)(8676002)(5660300002)(1076003)(70206006)(36756003)(36860700001)(26005)(16526019)(316002)(478600001)(82310400003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 07:03:49.5564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35699899-ca4d-4127-3140-08d958a85789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1308
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

On newer heterogeneous systems from AMD with GPU nodes connected via
xGMI links to the CPUs, the GPU dies are interfaced with HBM2 memory.

This patchset applies on top of the following series by Yazen Ghannam
AMD MCA Address Translation Updates
[https://patchwork.kernel.org/project/linux-edac/list/?series=505989]

This patchset does the following
1. Add support for northbridges on Aldebaran
	* x86/amd_nb: Add support for northbridges on Aldebaran
2. Modifies the amd64_edac module to
   a. Handle the UMCs on the noncpu nodes,
	* EDAC/mce_amd: extract node id from InstanceHi in IPID
   b. Enumerate HBM memory and add address translation
	* EDAC/amd64: Enumerate memory on noncpu nodes

Muralidhara M K (1):
  x86/amd_nb: Add support for northbridges on Aldebaran

Naveen Krishna Chatradhi (2):
  EDAC/mce_amd: Extract node id from InstanceHi in IPID
  EDAC/amd64: Enumerate memory on noncpu nodes

 arch/x86/include/asm/amd_nb.h |  10 ++
 arch/x86/kernel/amd_nb.c      |  63 ++++++++++-
 drivers/edac/amd64_edac.c     | 202 +++++++++++++++++++++++++++++-----
 drivers/edac/amd64_edac.h     |  27 +++++
 drivers/edac/mce_amd.c        |  19 +++-
 include/linux/pci_ids.h       |   1 +
 6 files changed, 288 insertions(+), 34 deletions(-)

-- 
2.25.1

