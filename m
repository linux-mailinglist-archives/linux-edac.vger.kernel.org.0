Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF863F5025
	for <lists+linux-edac@lfdr.de>; Mon, 23 Aug 2021 20:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhHWSNF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Aug 2021 14:13:05 -0400
Received: from mail-sn1anam02on2050.outbound.protection.outlook.com ([40.107.96.50]:51687
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231788AbhHWSNE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Aug 2021 14:13:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqwF4ngZ3bdMPI/+EwOGlPl4mLbOKuSV0Z4ABxP41Z5pbx6asB6i+aPuqrE9qQvvWSONO40S7vCsSpwmMWeuki21nHmIQ49zbH4qLhh9bB2Pldb2kBs1MlKkalmQlxijfo+rwEKpqtDmONUbpmkAeF4RY0f8diRhsm9Pp52HxqNdHBwQ6orvls7ELkwZejObbuU/HCJIfnCx7YWmZF1KjyJzLJPAtDl6pVhpN6CPEQJKnZpWOaadbOp0/N4asT5TN3IAAEGAkbQdNIZJ19Q1bNsWrLBadNgmJ51N7daVCMsDhwrGpJfwW6nK9ACZUsyI/ewBaabn5+mubmPOU05ZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfPW1nVjkVqZY/8vqIMKQlnIlF6Kain1wkpAMXQJrYc=;
 b=Nk7SOyltnKQYsdyUEP2b/z1G+tTfXFVe/AOZJNX/8ueq4g0IHKDeXV3TNrl3qTniEYp5XmFnHtneHEAzXel7sjtB+eC2rSm6SGcJ7ghJiVVElaJedJYL2otJQUReYcV9t0PcXYYndOLW+1E0fucTyUgn03pzIszE8K+UeL8pVRRDyKTPH8zAaU0AURAL5i4kE3cpvap1J/e2x7RWsnD/mIR+8Okw3MB9GJ8CWdCg0mEY4TuxgGhQA/SOCLhoq9w4R7F/06+jXAdcrm7NLuAXSLM2jSJ4jdQN0cGa8wb7ruohhJ8WOeJ4cs/IG+uyD+1+2wTjiAg/b7RB1GxUacrPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfPW1nVjkVqZY/8vqIMKQlnIlF6Kain1wkpAMXQJrYc=;
 b=xe4OyVhgONYQ6aTejtikDDWpVYV/11oYAisD7r8Y3ibBMLqpEGtiuJoGQJuldJtXBMB5v/Tg5u4mBz2O7z41bT8ra2yzONdV2jUBPjzshF2CDWpH49a7mq1cPSmYZDsm+xmDTd8XLG9i/jeBK9Ocv1pRBsu7DbStDUIaUTMYefQ=
Received: from CO2PR07CA0050.namprd07.prod.outlook.com (2603:10b6:100::18) by
 DM5PR12MB1820.namprd12.prod.outlook.com (2603:10b6:3:10d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.23; Mon, 23 Aug 2021 18:12:19 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::48) by CO2PR07CA0050.outlook.office365.com
 (2603:10b6:100::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend
 Transport; Mon, 23 Aug 2021 18:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 18:12:18 +0000
Received: from SLES15.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 23 Aug
 2021 13:12:14 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>,
        <Yazen.Ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 1/3] x86/amd_nb: Add support for northbridges on Aldebaran
Date:   Tue, 24 Aug 2021 00:24:35 +0530
Message-ID: <20210823185437.94417-2-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210823185437.94417-1-nchatrad@amd.com>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 801828aa-4a5e-4008-e9e9-08d966618ba4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1820:
X-Microsoft-Antispam-PRVS: <DM5PR12MB182010CF2FEA518280AAD981E8C49@DM5PR12MB1820.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mAJoaf1a059LLszyTLZreWORr4ZbJnjkpMb9K/BSSaNQwcOe/d9IVMCTyKTKYvjLy0kDoDpAh1FsQ0xBuLG8pTY5DUwLpZv5dgHyv0IHPnRONOJR9yIhALC9QGRgAljo+INx/8s4ORwCxvjhjF1XSKGagCLTMnkufcj94ItPSZQRtJZ0ordSLLNQfTkWj3xOgMEzQXp325PGm++KQXcyRU4zIOgEN1z/iggcHiOO/3WZ1WhW9tae9s8+IK+O+UXZrIYUgA0ZyKdHKfcYufkgClrDFQZYbSCvRzkecly7cFyg5YZ3iw4YyQ8gR+1U2eaPRbqcDVnZjuVmFmbDn2gl/0NRzLTf6MjmPL8namqGcdEXyL/uDoVfmQwt2p/ZvE0xK+91pGzvRwq63tnEEaSNlF9de8e4tiMBfZ7rYthY62dtbCuKz/ia0Or2ZsGbEsyK2ES9r+aGh44uIXFrG6z9yxPCM2xcuSftsH44E3txsvHL0TiS0Ks1GV6IzSzx6+93ii9AHePd/JyJL9sdwnvCWRSBn/wV4xFkIXLGX2uxzTfkCnWrqDefuWRq2d2AB3E5n18TgGvbl6bl7ivb+QlFzBHkco7+AHNS5VN5dYrEd3R1LJL2Vjb4f6T4J4jC39kYjXA7LveYChDo14d51R1WYtWAWPKdCIWlsCm999BcFaH0XNPSEmsbi6Wg88zfx67rIN+G3k8gVH5RaYg8lYlzvRGu0NWqpV1ue90bJTGv7ZhK8RlkzlWTnodcreTNVid3QZfaL8Lc4Zb1/N/IWYsdCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(2616005)(336012)(4326008)(26005)(83380400001)(7696005)(36756003)(54906003)(70206006)(426003)(1076003)(110136005)(36860700001)(186003)(82740400003)(82310400003)(16526019)(2906002)(8676002)(478600001)(5660300002)(316002)(47076005)(356005)(70586007)(6666004)(81166007)(34020700004)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:12:18.8708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 801828aa-4a5e-4008-e9e9-08d966618ba4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1820
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

On newer systems the CPUs manage MCA errors reported from the GPUs.
Enumerate the GPU nodes with the AMD NB framework to support EDAC.

This patch adds necessary code to manage the Aldebaran nodes along with
the CPU nodes.

The GPU nodes are enumerated in sequential order based on the
PCI hierarchy, and the first GPU node is assumed to have an "AMD Node
ID" value of 8 (the second GPU node has 9, etc.). Each Aldebaran GPU
package has 2 Data Fabrics, which are enumerated as 2 nodes.
With this implementation detail, the Data Fabric on the GPU nodes can be
accessed the same way as the Data Fabric on CPU nodes.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Changes since v2: Added Reviewed-by Yazen Ghannam

 arch/x86/include/asm/amd_nb.h | 10 ++++++
 arch/x86/kernel/amd_nb.c      | 63 ++++++++++++++++++++++++++++++++---
 include/linux/pci_ids.h       |  1 +
 3 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 455066a06f60..09905f6c7218 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -80,6 +80,16 @@ struct amd_northbridge_info {
 
 #ifdef CONFIG_AMD_NB
 
+/*
+ * On newer heterogeneous systems the data fabrics of the CPUs and GPUs
+ * are connected directly via a custom links, like is done with
+ * 2 socket CPU systems and also within a socket for Multi-chip Module
+ * (MCM) CPUs like Naples.
+ * The first GPU node(non cpu) is assumed to have an "AMD Node ID" value
+ * of 8 (the second GPU node has 9, etc.).
+ */
+#define NONCPU_NODE_INDEX	8
+
 u16 amd_nb_num(void);
 bool amd_nb_has_feature(unsigned int feature);
 struct amd_northbridge *node_to_amd_nb(int node);
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 23dda362dc0f..6ad5664a18aa 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -26,6 +26,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
 #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT	0x14bb
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4	0x14d4
 
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
 static DEFINE_MUTEX(smn_mutex);
@@ -94,6 +96,21 @@ static const struct pci_device_id hygon_nb_link_ids[] = {
 	{}
 };
 
+static const struct pci_device_id amd_noncpu_root_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT) },
+	{}
+};
+
+static const struct pci_device_id amd_noncpu_nb_misc_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3) },
+	{}
+};
+
+static const struct pci_device_id amd_noncpu_nb_link_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4) },
+	{}
+};
+
 const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
 	{ 0x00, 0x18, 0x20 },
 	{ 0xff, 0x00, 0x20 },
@@ -230,11 +247,16 @@ int amd_cache_northbridges(void)
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
 	const struct pci_device_id *link_ids = amd_nb_link_ids;
 	const struct pci_device_id *root_ids = amd_root_ids;
+
+	const struct pci_device_id *noncpu_misc_ids = amd_noncpu_nb_misc_ids;
+	const struct pci_device_id *noncpu_link_ids = amd_noncpu_nb_link_ids;
+	const struct pci_device_id *noncpu_root_ids = amd_noncpu_root_ids;
+
 	struct pci_dev *root, *misc, *link;
 	struct amd_northbridge *nb;
 	u16 roots_per_misc = 0;
-	u16 misc_count = 0;
-	u16 root_count = 0;
+	u16 misc_count = 0, misc_count_noncpu = 0;
+	u16 root_count = 0, root_count_noncpu = 0;
 	u16 i, j;
 
 	if (amd_northbridges.num)
@@ -253,10 +275,16 @@ int amd_cache_northbridges(void)
 	if (!misc_count)
 		return -ENODEV;
 
+	while ((misc = next_northbridge(misc, noncpu_misc_ids)) != NULL)
+		misc_count_noncpu++;
+
 	root = NULL;
 	while ((root = next_northbridge(root, root_ids)) != NULL)
 		root_count++;
 
+	while ((root = next_northbridge(root, noncpu_root_ids)) != NULL)
+		root_count_noncpu++;
+
 	if (root_count) {
 		roots_per_misc = root_count / misc_count;
 
@@ -270,15 +298,28 @@ int amd_cache_northbridges(void)
 		}
 	}
 
-	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
+	if (misc_count_noncpu) {
+		/*
+		 * The first non-CPU Node ID starts at 8 even if there are fewer
+		 * than 8 CPU nodes. To maintain the AMD Node ID to Linux amd_nb
+		 * indexing scheme, allocate the number of GPU nodes plus 8.
+		 * Some allocated amd_northbridge structures will go unused when
+		 * the number of CPU nodes is less than 8, but this tradeoff is to
+		 * keep things relatively simple.
+		 */
+		amd_northbridges.num = NONCPU_NODE_INDEX + misc_count_noncpu;
+	} else {
+		amd_northbridges.num = misc_count;
+	}
+
+	nb = kcalloc(amd_northbridges.num, sizeof(struct amd_northbridge), GFP_KERNEL);
 	if (!nb)
 		return -ENOMEM;
 
 	amd_northbridges.nb = nb;
-	amd_northbridges.num = misc_count;
 
 	link = misc = root = NULL;
-	for (i = 0; i < amd_northbridges.num; i++) {
+	for (i = 0; i < misc_count; i++) {
 		node_to_amd_nb(i)->root = root =
 			next_northbridge(root, root_ids);
 		node_to_amd_nb(i)->misc = misc =
@@ -299,6 +340,18 @@ int amd_cache_northbridges(void)
 			root = next_northbridge(root, root_ids);
 	}
 
+	if (misc_count_noncpu) {
+		link = misc = root = NULL;
+		for (i = NONCPU_NODE_INDEX; i < NONCPU_NODE_INDEX + misc_count_noncpu; i++) {
+			node_to_amd_nb(i)->root = root =
+				next_northbridge(root, noncpu_root_ids);
+			node_to_amd_nb(i)->misc = misc =
+				next_northbridge(misc, noncpu_misc_ids);
+			node_to_amd_nb(i)->link = link =
+				next_northbridge(link, noncpu_link_ids);
+		}
+	}
+
 	if (amd_gart_present())
 		amd_northbridges.flags |= AMD_NB_GART;
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4bac1831de80..d9aae90dfce9 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -554,6 +554,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
-- 
2.25.1

