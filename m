Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FE0702BAE
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 13:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbjEOLlV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 07:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240413AbjEOLjU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 07:39:20 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156E71FE1;
        Mon, 15 May 2023 04:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJHx5nVwHcSdjf915XcC29VUbNa2x7exrS82W5H9GwtJQ6thD+xLWVKS/ZbWJbg6ZarhYft0+X297hDY7Dj+wRrwpEZrCiRMufjjXs0okNHCfOApBIDrawA1aS0vZ1fbfYjDnhdKtrRLIRS/79P2ZnXQjOp/N03KBYyQS61izLWShoJIs2HB0NTETrFV9dXmU96WszJWeKXkH4p1ZBFCJ8erAduPgYvmdqGmAp8Lk7VbappKtPhBqOIXHQxBvQQJbQD2nnoiMAE+u5jtxPvoCBZMoCjyqA7us3CMUnUUw9L1d7PW/uZ/CvTq7gPZrpfuARgjC989dngbeEsYKKMGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0gZhrzob57y3Ne4CCwL2DGkjPeQhG61cqBhR9rVR4w=;
 b=VGkC90ISAglDtqQasd0vzCz4BB20UOuj/NbK/jRIuBXg2f5lHR2jD708fNc1mh+4EguMYPY8FTIrE0iFWdWtQQb/vzqqWBimdgNyUrQefW9TLBReql1IE4aKZGJIZ12IvnC+rRG0YU1d0GVbNjsLwiYHX7bbXCvqr2kjFLmUidioM0o23idntxrS7ZNUnRi7tzF96IWn3I5ArB+SgSCUEHALdQds/SVv2diGAOq696tYKJwGOoh++YMl9YL4yBYrKF0gLRMTb5F1t5t2Ix3hcVk9d8NLukvizJ86BATjeOzMwb3Iygxw1Gp6OQ238kxR9BXVAMKsTe+r1A5TXaK7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0gZhrzob57y3Ne4CCwL2DGkjPeQhG61cqBhR9rVR4w=;
 b=YGe82VKOolcXkh2oGNsrhxcidP7Dvsr9nBqMcUFCFrJGEHZ0E+VcOYn3dewTA+2gSRsP5IGkZQOS1gunbWkzudcyc7AGuNZ+UgkiZZBXXSGZy5kMqPVRFHjRkDEDaQl8hnPr1siiFmsO1C73+hY17jUnPW5A5EVjpi0lKnaRRrk=
Received: from SJ0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:33a::29)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 11:36:05 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::20) by SJ0PR03CA0024.outlook.office365.com
 (2603:10b6:a03:33a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 11:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 11:36:05 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 06:36:02 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>, <nchatrad@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>,
        Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH 3/5] EDAC/amd64: Document heterogeneous system enumeration
Date:   Mon, 15 May 2023 11:35:35 +0000
Message-ID: <20230515113537.1052146-4-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515113537.1052146-1-muralimk@amd.com>
References: <20230515113537.1052146-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f644d7-fa50-4ad9-3c22-08db55389196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HA/XuJdhwZtlIhqLpciW5qp8cdV6GjIx63MCHk+qUjTvUs4PejfdDO1nZpZyfWoGt7n6tltfZTKmEdp/8PsOKCAqCBu7rxevZe4Tv60jS3PkvnWVCsKOOaOvJ8OoreeuxJ4Ydgc6XEV3GYHB9lmMtuOC0FHVgrL4w6zjc6NaoFQOZ7W0HrQ/M5ITtOdEvWHQVQLFriw1m2neeI88knIDpUnqTD4ZdAecyF4itOtleMk/V44zpLirutRnjCgF4pntNyS8yiQBnaCYyxDykvUJ524jjye95qOqfP1AogIOtspESZjlkyO0XYiyJ5nyz72kHUwNcMaj2pILauk3Y8ObzZzP/1gI6aJwrv7gtxuvbpUbCjeSchD/WsOy5p+t9I2VqTtCehhtKKtU87Z4UW3Bv1RimKnma9hd5xn0HX7zyVvFoD4voMG4bnk/fv1btBkZh50zlnUqGvKFxYN9yaRwo7kcVYS1DOLBuGvDflPmYirHb15NlLapTJD7x3Dd7iqTHmNw0jNwYfOxO5oOjh9gJyOTResSNlrWYHyTBMzfh252jYmXQGy55teSnELboGmlFyW+9HvKTBOMgfJ6yurl5QBiS4u72DngjzqZRhiKDFi5EQ3LRC3rU6eMDCgCeoA91exBjUG+pYQH5eFlb5V1D0TDvMdDT2tF4VEQVuEHpvFlROjHHhje5WxqZlyRdHubgYBu7PkJzSqiuQtDP3E2A7p/GK5OCFJMScFL5BEmD5DUqGOhXHhF/y/K5qhuX/7t/DUh2pWMAO3QyevVXKNuDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(47076005)(186003)(16526019)(2616005)(41300700001)(6666004)(7696005)(426003)(336012)(83380400001)(1076003)(26005)(40460700003)(478600001)(54906003)(110136005)(70206006)(70586007)(4326008)(82740400003)(81166007)(40480700001)(316002)(356005)(5660300002)(8936002)(8676002)(2906002)(36756003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 11:36:05.1347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f644d7-fa50-4ad9-3c22-08db55389196
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Document High Bandwidth Memory (HBM) and AMD heterogeneous system
topology and enumeration.

  [ bp: Simplify and de-marketize, unify, massage. ]

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/driver-api/edac.rst | 120 ++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/Documentation/driver-api/edac.rst b/Documentation/driver-api/edac.rst
index b8c742aa0a71..f4f044b95c4f 100644
--- a/Documentation/driver-api/edac.rst
+++ b/Documentation/driver-api/edac.rst
@@ -106,6 +106,16 @@ will occupy those chip-select rows.
 This term is avoided because it is unclear when needing to distinguish
 between chip-select rows and socket sets.
 
+* High Bandwidth Memory (HBM)
+
+HBM is a new memory type with low power consumption and ultra-wide
+communication lanes. It uses vertically stacked memory chips (DRAM dies)
+interconnected by microscopic wires called "through-silicon vias," or
+TSVs.
+
+Several stacks of HBM chips connect to the CPU or GPU through an ultra-fast
+interconnect called the "interposer". Therefore, HBM's characteristics
+are nearly indistinguishable from on-chip integrated RAM.
 
 Memory Controllers
 ------------------
@@ -176,3 +186,113 @@ nodes::
 	the L1 and L2 directories would be "edac_device_block's"
 
 .. kernel-doc:: drivers/edac/edac_device.h
+
+
+Heterogeneous system support
+----------------------------
+
+An AMD heterogeneous system is built by connecting the data fabrics of
+both CPUs and GPUs via custom xGMI links. Thus, the data fabric on the
+GPU nodes can be accessed the same way as the data fabric on CPU nodes.
+
+The MI200 accelerators are data center GPUs. They have 2 data fabrics,
+and each GPU data fabric contains four Unified Memory Controllers (UMC).
+Each UMC contains eight channels. Each UMC channel controls one 128-bit
+HBM2e (2GB) channel (equivalent to 8 X 2GB ranks).  This creates a total
+of 4096-bits of DRAM data bus.
+
+While the UMC is interfacing a 16GB (8high X 2GB DRAM) HBM stack, each UMC
+channel is interfacing 2GB of DRAM (represented as rank).
+
+Memory controllers on AMD GPU nodes can be represented in EDAC thusly:
+
+	GPU DF / GPU Node -> EDAC MC
+	GPU UMC           -> EDAC CSROW
+	GPU UMC channel   -> EDAC CHANNEL
+
+For example: a heterogeneous system with 1 AMD CPU is connected to
+4 MI200 (Aldebaran) GPUs using xGMI.
+
+Some more heterogeneous hardware details:
+
+- The CPU UMC (Unified Memory Controller) is mostly the same as the GPU UMC.
+  They have chip selects (csrows) and channels. However, the layouts are different
+  for performance, physical layout, or other reasons.
+- CPU UMCs use 1 channel, In this case UMC = EDAC channel. This follows the
+  marketing speak. CPU has X memory channels, etc.
+- CPU UMCs use up to 4 chip selects, So UMC chip select = EDAC CSROW.
+- GPU UMCs use 1 chip select, So UMC = EDAC CSROW.
+- GPU UMCs use 8 channels, So UMC channel = EDAC channel.
+
+The EDAC subsystem provides a mechanism to handle AMD heterogeneous
+systems by calling system specific ops for both CPUs and GPUs.
+
+AMD GPU nodes are enumerated in sequential order based on the PCI
+hierarchy, and the first GPU node is assumed to have a Node ID value
+following those of the CPU nodes after latter are fully populated::
+
+	$ ls /sys/devices/system/edac/mc/
+		mc0   - CPU MC node 0
+		mc1  |
+		mc2  |- GPU card[0] => node 0(mc1), node 1(mc2)
+		mc3  |
+		mc4  |- GPU card[1] => node 0(mc3), node 1(mc4)
+		mc5  |
+		mc6  |- GPU card[2] => node 0(mc5), node 1(mc6)
+		mc7  |
+		mc8  |- GPU card[3] => node 0(mc7), node 1(mc8)
+
+For example, a heterogeneous system with one AMD CPU is connected to
+four MI200 (Aldebaran) GPUs using xGMI. This topology can be represented
+via the following sysfs entries::
+
+	/sys/devices/system/edac/mc/..
+
+	CPU			# CPU node
+	├── mc 0
+
+	GPU Nodes are enumerated sequentially after CPU nodes have been populated
+	GPU card 1		# Each MI200 GPU has 2 nodes/mcs
+	├── mc 1		# GPU node 0 == mc1, Each MC node has 4 UMCs/CSROWs
+	│   ├── csrow 0		# UMC 0
+	│   │   ├── channel 0	# Each UMC has 8 channels
+	│   │   ├── channel 1   # size of each channel is 2 GB, so each UMC has 16 GB
+	│   │   ├── channel 2
+	│   │   ├── channel 3
+	│   │   ├── channel 4
+	│   │   ├── channel 5
+	│   │   ├── channel 6
+	│   │   ├── channel 7
+	│   ├── csrow 1		# UMC 1
+	│   │   ├── channel 0
+	│   │   ├── ..
+	│   │   ├── channel 7
+	│   ├── ..		..
+	│   ├── csrow 3		# UMC 3
+	│   │   ├── channel 0
+	│   │   ├── ..
+	│   │   ├── channel 7
+	│   ├── rank 0
+	│   ├── ..		..
+	│   ├── rank 31		# total 32 ranks/dimms from 4 UMCs
+	├
+	├── mc 2		# GPU node 1 == mc2
+	│   ├── ..		# each GPU has total 64 GB
+
+	GPU card 2
+	├── mc 3
+	│   ├── ..
+	├── mc 4
+	│   ├── ..
+
+	GPU card 3
+	├── mc 5
+	│   ├── ..
+	├── mc 6
+	│   ├── ..
+
+	GPU card 4
+	├── mc 7
+	│   ├── ..
+	├── mc 8
+	│   ├── ..
-- 
2.25.1

