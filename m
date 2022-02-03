Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010494A8AB1
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 18:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353078AbiBCRua (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 12:50:30 -0500
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:60800
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353076AbiBCRu1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvLD5G/eTc6j0HxWSTd3SA/NFrjI2h2a8YWhUjKCQyDJo5DlnE0QRG8TVhD1hKLY++M8IcpqBd/bI+91/ZxSwYqiTLR3w+Vd52xftuxha9dnRY5wqFDxt0iWfT9aFhCiGMomEve7TLsLurQ/hxacQ5rZE6Ol+8s60FGnyok6cV5FvhC2plMmThjHZ4MG5r3n9bcOEW8lMcUo1R2VRIZEc5TTOBUll6vVRr6paZlyVveRNJyw6hrTIeZx3mkbXyVmL1DCTimSNXQbUhVqGz0bwARcApGCPK4HxF6oGfXdns8tckINSSAp0pPoRHJ5EGIZxoQC4IE0Mq3aXakRRPuWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMecDP09xjHLYQXna7DlZz+3OW992d6j6ajme8aekbY=;
 b=aSmmcwZ8noN/vEy2mEsDKulm7fbBPN339BJzGSIbDQTOQR040icNyu1ZADmi3I5993GeGXRwU837qWvJ3fOqo1VmwPjXMzX9qiZDHYKvj/q7+0XbH7kYzdDHP8SaOm3oVg+aVESvSzZQ0OkVal+VZo8It/JG9J438HIYQvNbvAmmS/lgXiV3wW5j7wYtXyvKIPOyYQJeV1r/MVsYRFmijbl4dVq9+Tifsxn1UPrSHCYySvBumhBTM5XVXhmhLPj6vO/6ynOT6SprMV0iUMXso5Qh5aCNPgxfSkfaWjMLxIwGAQsYQc2HUFp8F5MHyweGxyzI5yLxiUKYcGwTMvGSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMecDP09xjHLYQXna7DlZz+3OW992d6j6ajme8aekbY=;
 b=uVdtgQHklU1PZEkV6wnBWozXh4DkwHm5eiDo+6/JuwThdacqw/r0LDI5SkTHTmYZ5svetDlxk1ZfG9vCceH/4lRPuGgEQJZp0QtM1EHEnCOWEVfTdYmH840F2mOkcEjydB6641RjNhPKc20F0uNke1dqfhUdY5hGCCMHqy1Lg+Y=
Received: from MW4PR02CA0024.namprd02.prod.outlook.com (2603:10b6:303:16d::9)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 17:50:25 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::76) by MW4PR02CA0024.outlook.office365.com
 (2603:10b6:303:16d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 17:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:50:25 +0000
Received: from node-bp128-r03d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 11:50:22 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v7 01/12] EDAC/amd64: Document heterogeneous enumeration
Date:   Thu, 3 Feb 2022 11:49:31 -0600
Message-ID: <20220203174942.31630-2-nchatrad@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203174942.31630-1-nchatrad@amd.com>
References: <20220203174942.31630-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29a84de5-69d0-4fce-0ce3-08d9e73da852
X-MS-TrafficTypeDiagnostic: BL1PR12MB5361:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5361FC3542AAB3FD8CA01613E8289@BL1PR12MB5361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7QRSIYexqPPBmvUAlkTAnddGq7GyFMuQyovMWENJv9HstlEjaPci1dXS9or2u5weKNyHcG5vX6PuxdN7nM4RNusB3GG9JaWVuEaO+sIk66yo/tl8OtNOa0LSSqGVK4YztE6nU/5pY+vIhLYYtUBbTaJCz1QXmoKWQJf6AJljbQct7iW1f8W46im9hfYxSFxyJyF2/PLEnYNc3FA+gdIaTyUgwBlrZVI0qJthafLfAboFNQ50V5KxkTNa10KPbcumC6WY2h+9xnGkvIYrcfxQqtwO0eDYEnK69K1tELcVPZ5kQ2e4iI/oZZCLf0nMXW9dj5PpRE4cy90z/s/dsJWYkRIYacbpu3rJFks2ZlQhIJClgz6Umdr5kxcVcW0vBGkMqCw/hE60yj2EZUAcoUtGXSUEdvj5yVHDjQgw4WXjxTZEp1PSCQZqQTGwzzirv2wTn0T6GieiJjJlpycx6SrGx97Xet5UkBE43DTy4KDHpmcPUnNrHqaPHwq3AW39I5H05+uebrVE4alh8gZ6UaGAXfGEvpR6+ykputsViA0+3QjC2AAi1m8YKej9fPpevE+Af3J2PeRXb5m5U4nBokEcSybV+8COnAbs1dfX6TaTOWZWLnCzKJST58b98+9KDady80TVT5ccznzhk2NQUF93I0SthT3xuZCsQaVeDHTACaEW35dtW7QybLnQT1HFS+gPf+Wrvhb1P/kB3OwfcG5Ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(83380400001)(336012)(2616005)(2906002)(110136005)(8936002)(426003)(36860700001)(54906003)(5660300002)(4326008)(26005)(316002)(1076003)(7696005)(70586007)(70206006)(40460700003)(36756003)(6666004)(8676002)(47076005)(356005)(81166007)(16526019)(508600001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:50:25.0888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a84de5-69d0-4fce-0ce3-08d9e73da852
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

The Documentation notes have been added in amd64_edac.h and will be
referring to driver-api wherever needed.

Explains how the physical topology is enumerated in the software and
edac module populates the sysfs ABIs.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
v6->v7:
* New in v7

 Documentation/driver-api/edac.rst |   9 +++
 drivers/edac/amd64_edac.h         | 101 ++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/Documentation/driver-api/edac.rst b/Documentation/driver-api/edac.rst
index b8c742aa0a71..0dd07d0d0e47 100644
--- a/Documentation/driver-api/edac.rst
+++ b/Documentation/driver-api/edac.rst
@@ -106,6 +106,15 @@ will occupy those chip-select rows.
 This term is avoided because it is unclear when needing to distinguish
 between chip-select rows and socket sets.
 
+* High Bandwidth Memory (HBM)
+
+HBM is a new type of memory chip with low power consumption and ultra-wide
+communication lanes. It uses vertically stacked memory chips (DRAM dies)
+interconnected by microscopic wires called "through-silicon vias," or TSVs.
+
+Several stacks of HBM chips connect to the CPU or GPU through an ultra-fast
+interconnect called the “interposer". So that HBM’s characteristics are
+nearly indistinguishable from on-chip integrated RAM.
 
 Memory Controllers
 ------------------
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 6f8147abfa71..6a112270a84b 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -559,3 +559,104 @@ static inline u32 dct_sel_baseaddr(struct amd64_pvt *pvt)
 	}
 	return (pvt)->dct_sel_lo & 0xFFFFF800;
 }
+
+/*
+ * AMD Heterogeneous system support on EDAC subsystem
+ * --------------------------------------------------
+ *
+ * An AMD heterogeneous system built by connecting the data fabrics of both CPUs
+ * and GPUs via custom xGMI links. So, the Data Fabric on the GPU nodes can be
+ * accessed the same way as the Data Fabric on CPU nodes.
+ *
+ * An Aldebaran GPUs has 2 Data Fabrics, each GPU DF contains four Unified
+ * Memory Controllers (UMC). Each UMC contains eight Channels. Each UMC Channel
+ * controls one 128-bit HBM2e (2GB) channel (equivalent to 8 X 2GB ranks),
+ * this creates a total of 4096-bits of DRAM data bus.
+ *
+ * While UMC is interfacing a 16GB (8H X 2GB DRAM) HBM stack, each UMC channel is
+ * interfacing 2GB of DRAM (represented as rank).
+ *
+ * Memory controllers on AMD GPU nodes can be represented in EDAC is as below:
+ *       GPU DF / GPU Node -> EDAC MC
+ *       GPU UMC           -> EDAC CSROW
+ *       GPU UMC channel   -> EDAC CHANNEL
+ *
+ * Eg: An heterogeneous system with 1 AMD CPU is connected to 4 Aldebaran GPUs using xGMI.
+ *
+ * AMD GPU Nodes are enumerated in sequential order based on the PCI hierarchy, and the
+ * first GPU node is assumed to have an "Node ID" value after CPU Nodes are fully
+ * populated.
+ *
+ * $ ls /sys/devices/system/edac/mc/
+ *	mc0   - CPU MC node 0
+ *	mc1  |
+ *	mc2  |- GPU card[0] => node 0(mc1), node 1(mc2)
+ *	mc3  |
+ *	mc4  |- GPU card[1] => node 0(mc3), node 1(mc4)
+ *	mc5  |
+ *	mc6  |- GPU card[2] => node 0(mc5), node 1(mc6)
+ *	mc7  |
+ *	mc8  |- GPU card[3] => node 0(mc7), node 1(mc8)
+ *
+ * sysfs entries will be populated as below:
+ *
+ *	CPU			# CPU node
+ *	├── mc 0
+ *
+ *	GPU Nodes are enumerated sequentially after CPU nodes are populated
+ *	GPU card 1		# Each Aldebaran GPU has 2 nodes/mcs
+ *	├── mc 1		# GPU node 0 == mc1, Each MC node has 4 UMCs/CSROWs
+ *	│   ├── csrow 0		# UMC 0
+ *	│   │   ├── channel 0	# Each UMC has 8 channels
+ *	│   │   ├── channel 1   # size of each channel is 2 GB, so each UMC has 16 GB
+ *	│   │   ├── channel 2
+ *	│   │   ├── channel 3
+ *	│   │   ├── channel 4
+ *	│   │   ├── channel 5
+ *	│   │   ├── channel 6
+ *	│   │   ├── channel 7
+ *	│   ├── csrow 1		# UMC 1
+ *	│   │   ├── channel 0
+ *	│   │   ├── ..
+ *	│   │   ├── channel 7
+ *	│   ├── ..		..
+ *	│   ├── csrow 3		# UMC 3
+ *	│   │   ├── channel 0
+ *	│   │   ├── ..
+ *	│   │   ├── channel 7
+ *	│   ├── rank 0
+ *	│   ├── ..		..
+ *	│   ├── rank 31		# total 32 ranks/dimms from 4 UMCs
+ *	├
+ *	├── mc 2		# GPU node 1 == mc2
+ *	│   ├── ..		# each GPU has total 64 GB
+ *
+ *	GPU card 2
+ *	├── mc 3
+ *	│   ├── ..
+ *	├── mc 4
+ *	│   ├── ..
+ *
+ *	GPU card 3
+ *	├── mc 5
+ *	│   ├── ..
+ *	├── mc 6
+ *	│   ├── ..
+ *
+ *	GPU card 4
+ *	├── mc 7
+ *	│   ├── ..
+ *	├── mc 8
+ *	│   ├── ..
+ *
+ *
+ * Heterogeneous hardware details for above context as below:
+ * - The CPU UMC (Unified Memory Controller) is mostly the same as the GPU UMC.
+ *   They have chip selects (csrows) and channels. However, the layouts are different
+ *   for performance, physical layout, or other reasons.
+ * - CPU UMCs use 1 channel. So we say UMC = EDAC Channel. This follows the
+ *   marketing speak, example. CPU has X memory channels, etc.
+ * - CPU UMCs use up to 4 chip selects. So we say UMC chip select = EDAC CSROW.
+ * - GPU UMCs use 1 chip select. So we say UMC = EDAC CSROW.
+ * - GPU UMCs use 8 channels. So we say UMC Channel = EDAC Channel.
+ */
-- 
2.25.1

