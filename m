Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D1774A2E6
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jul 2023 19:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjGFRNy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jul 2023 13:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFRNx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jul 2023 13:13:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C60C1BFF;
        Thu,  6 Jul 2023 10:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuI4KqWLOY5jVG64lkY74zI1zQ9T9jA0ryQXxNbd+KjmaJl59InxQJ72esMkq5YpeBaXjmWUTUnG/iH8kcFv7f0LbGcQRT+nkxeeQlBxgd0zkfG9IF0l8ncH/me6/aDyAl4V0owjX1tZcvQPIDgFBL2Y6VIICeAuKSI1kDBecwjbWog8H9N6S+6XsAZIZAw1y8WsmdXby7rh3LUjvgzeGQMSQ+wynmWREKgdZdeEa2uVXGAtCk1rUdtlDPlWFS/Ltb9rPpUVDP/X70rCSV3JrFA96xtrlvUGAAPpRVHb9LG/yi8GfmRhi3AF/3fxpiOkD2wcQfS0j9rcdusQybr9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3NwBrK87aWlaYjiW6ksd2eXAhi1zRgg62XYze/0kEM=;
 b=TJbmgm6Qksfm8fcuVG8xGG6lBSqtBF/QAfAOOYVfE2LvivVZ5Vf0rp0Gj1R5LMPPJpnSRxtJUaDQ+bZETzptMZJzcZ34wrxFJ19N5MPLu8bwP9cML100Jtt+1hoyNZDqeHNz9/QrX0FEOIA1AagPHkxiEC+Qm32AGFao143F/dMibaPxUCpqWEWoZykCeApyKw/yMuBOvgFnoLHdWuPZfgCZeXspzdVxWf328XL6s5NSfo9Ildi7jwPj+7d6AXlo3IFIdvvybm1wnUo5cMrBC0fu5HmNT4koAhBhHFr9scQRUeX2ZIkfdiAPTIIBwaIKzAItGf6PTgwFrP/KEIXumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3NwBrK87aWlaYjiW6ksd2eXAhi1zRgg62XYze/0kEM=;
 b=rcXVeRhg4rsnL/J/cEnQQShLoD8vLAv2woRjKmeFDJmrQ7Xa388YRAy/eyTa+NgPwN28A9+OIGC4TUMo01UM/7w/FXH2WIQ1FG8qWX7ko7fZ3RosK5m9hB5+wzklomGKtNxfeDvAWa+5SFG2+McYDOn1rO8XMTKgK4fiHHSi5cE=
Received: from MW4PR04CA0316.namprd04.prod.outlook.com (2603:10b6:303:82::21)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 17:13:45 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::13) by MW4PR04CA0316.outlook.office365.com
 (2603:10b6:303:82::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 17:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 17:13:44 +0000
Received: from onyx-7400host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 12:13:42 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <bp@alien8.de>, <linux@roeck-us.net>, <x86@kernel.org>,
        <linux-hwmon@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        <yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v1 1/3] x86/amd_nb: Add PCI IDs for AMD Family 1Ah-based models
Date:   Thu, 6 Jul 2023 17:13:21 +0000
Message-ID: <20230706171323.3722900-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706171323.3722900-1-avadhut.naik@amd.com>
References: <20230706171323.3722900-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|SJ1PR12MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: c9943a02-d164-4bfd-4b3c-08db7e445a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +DakguEPpTLF+dQUrcqU/91VQ4Vw84tTBUmb5LpW6xi52LPSJYGukvsUnYwNbD53YQWrlbF5kGf59in4dHF/AitnA+KclIqcavs8IGMBE+FZ+ArY7SxTXs9nqjfkQ0Ng51+/+d/LO3kaZW5Oxz+ZXxr3f/G8YCqHP7DXBUqSTXFecqDmFj4EHI2VUWZc03FJJbUl5fLIkn5usBed9uO2dRMVvVKoP3p8AXA6hjRPptYpe6n+vijSfthAFRBtgzscB4XHcudXS6PiAN8eUYa7Oaqm7FdQH5wHxJ666JhtHJq0j1FD3oBgwsujCF00MbJrM2GqnjuEbnS4mmvAHLsfRsbQ/BLlA7vlUQfYEeAqAxg6xITaFXsXkpqVyQiiURvHcUhnc5qnqKWXQT3knFZ5BJ9j0A0u0+uR6w9lSrbqmlJ7CbgD/pc7Lz9OvsjO2JOhhmQOjc89ZGtKgeUk6/6o0rNNsX9uw7IMbbf+YpQWrxYY/Wi6jTrDfJnpPtRueNmAW6NBeRFksXWRogVlfU9kNUnIb5CVVXtXJH+LVUJZeZuAbSG5th5yO82bd39YKNinBKsV7Zu1Qzw4CW16tBNrPuQSXJSf8Vtv/1nqGbqVUbgnLdSx7/uGiGzBzrPBVG7kPl0ajqEdkpIy4AwIAqpOwgsBgLImSwOTcTUr7xG88A8+n2wqPDVvbkQi9HpFePHX61/DkJW+Mfm59YveCgwVZT8B1S439c3DIsG5dzzTd8FWoIh8nWVwepAYFZptIDSmq4ziXfi3PsUtb45Kncu93wPz71JG0dTQLw8D8PeToYc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(186003)(26005)(336012)(1076003)(16526019)(426003)(7696005)(6666004)(36860700001)(81166007)(54906003)(478600001)(47076005)(356005)(2616005)(110136005)(82740400003)(316002)(8676002)(8936002)(41300700001)(40460700003)(44832011)(5660300002)(4326008)(70586007)(70206006)(40480700001)(2906002)(86362001)(36756003)(82310400005)(170073001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 17:13:44.2440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9943a02-d164-4bfd-4b3c-08db7e445a7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Avadhut Naik <Avadhut.Naik@amd.com>

Add new PCI Device IDs, required to support AMD's new Family 1Ah-based
models 00h-1Fh and 20h.

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
---
 arch/x86/kernel/amd_nb.c | 8 ++++++++
 include/linux/pci_ids.h  | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 035a3db5330b..356de955e78d 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -24,6 +24,8 @@
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT		0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M60H_ROOT		0x14d8
 #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
+#define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
+#define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
 
 #define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
@@ -39,6 +41,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4	0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
+#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
 #define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
 
 /* Protect the PCI config register pairs used for SMN. */
@@ -56,6 +59,8 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
 	{}
 };
@@ -85,6 +90,8 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
 	{}
 };
@@ -106,6 +113,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a99b1fcfc617..6947e148bf38 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -568,6 +568,8 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
+#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
+#define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
-- 
2.34.1

