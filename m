Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706CA3E23AC
	for <lists+linux-edac@lfdr.de>; Fri,  6 Aug 2021 09:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243514AbhHFHEU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Aug 2021 03:04:20 -0400
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:12896
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243496AbhHFHET (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 6 Aug 2021 03:04:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofCxRrtm2/s5oo+ICfFp50wmjn5Vmxcbyw0Nl1/R3fC6HrKN3jBg6NJzVLAiTfjMzcuyEpZ1yhlBq3KaeRw5Hj3VU8RVt866oNcayDlDrfPoAe9Ku3cO5C5j81tEf+U5v2t7JDobqPKlytw4NifZOgvHI4htm97Isr39szagZrjC6IQyAPqtPbH1azJAMPO03iXI0aKn9oaIbQPOrcQxPFSx9hps8F/3yjE+OO8a+PWy0nP4WCmyzQtSuengKalIutEN/pUONaBNdeuClMF+GngkeyBtyuNY/wSeifr9QoaqmlMRUdXNifmMf72DbNkabmWgnObVSdphNlqxsu8tkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rhjOvlxGt2o6q081FwUwKUj2M/wXvegcWEN7cmv/XQ=;
 b=H7H1SdtNJPyy5nIf2gKFdOtL1R+gtcmjvHf4hIRsqHtom4KnfrET6Jw7aTkA+Bs+5y3bwtRFkpY4ndl5vUQmUF1+1BqcHnh+6VaYScIBEwzn5bN+2gKg/dkIejuJwd5OoTwYYp0tZGiiDNNf2irRLx2UUylvHZGSKJoBn7q2Dp6o6ehY7bDarr/eDOZTPUZbwGwHlid7LOk8dTviejyFWXLGPXEVdLcpqH5gEY6+E49SESTLNF8RO9g4YrceFIVwuS714idjzfxZkeNaZlnuEDn0/NdhWGtXrFgc0I4JnuBjef+ufZFAsjbpOyHr5Z4Nx12BQOQjYsRwe9VAiXjmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rhjOvlxGt2o6q081FwUwKUj2M/wXvegcWEN7cmv/XQ=;
 b=rC8+4HXo3oqteKhDNx1TnUV+SOZS+5OHwJ1eMGyEXZg5T3eEzxd+VnG86MXxNFMV4YuEMeBB+NIAJm6Y8p+OCB5+yfsCMKd+J0TcStbBSH8PRVhDH6f//33h2GCqpRxIRhgjXVzLwze12E/YSHlmzkhZnWFhc/WBFiFtI9LK4lw=
Received: from DM5PR06CA0058.namprd06.prod.outlook.com (2603:10b6:3:37::20) by
 DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.25; Fri, 6 Aug 2021 07:04:02 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::9d) by DM5PR06CA0058.outlook.office365.com
 (2603:10b6:3:37::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Fri, 6 Aug 2021 07:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 07:04:02 +0000
Received: from SLES15.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 02:03:59 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v2 1/3] x86/amd_nb: Add support for northbridges on Aldebaran
Date:   Fri, 6 Aug 2021 13:13:48 +0530
Message-ID: <20210806074350.114614-2-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210806074350.114614-1-nchatrad@amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210806074350.114614-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b8bd4ea-e98c-4adc-23a4-08d958a85f2d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-Microsoft-Antispam-PRVS: <DM5PR12MB135502D159C9D958E5794206E8F39@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtHc1zwkvGUYaJcNWCSh+VKJPUvmmc9nh4FfqROApWm/AiF63fmOO2Zn29ig1mlkdgQJWgjmy7Cv63XoFrarJjQaUhPa6gBfmghrz87b+Yjwsdem9ml+87Lpr33ZWvdXABpnxN6PjweoAJLUQDxE1Iyl7gzyDa9Vb4/0TzcQnwOXfj9UiMdxMO+ga9M22GpE/bTXjTx/vlw4L7qXiuZmqa6fmAAWrp2biwrRZ38aYfdOpD+USofUvHNcPo8cRZnM4zjEuuqqhuUKmXfWYSZg2S7Aa29K7PNSbxMXZZOzxb+D433qVxi6Wtb7MVu691WOgAS/9o2ddg/irii+7uDgj5vWRK+jp8kB/v5GkGJLemytDS/sSCzQXAscCI6Cv/sb98tJ+LtGEnEJPv98RaeqRvcf13hNHN4+l+LxaadPxAX5K+Kifzd1/ena+bPQxgrwYM7lPu50864bI820YEN4spyfoWfEWjiKHp8n4Ihs7opHa9q6HCARKwcuWKjYG1ab7RNeUMVVLrOnCPzfhcyEiflCxNHRvrLzAN+Timov5ntw56m/R0zivA26tV5VNKd9jHTgvLVFjSN8TKQA/K3VqgwpTqgFRhpnOBQWrBth157CCx73y5voJ46qsrl6UyTS7f/uBOsEXBJnChV80M9sgoUt/TZU2yTr2CU30kmbmWj15ta8QHNfnLAuYPkXYc9U3HkJDFRPoQtaPmSaLD9Q2r0pPv5i2QJyL3yrJN+ZBoM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966006)(36840700001)(54906003)(1076003)(110136005)(36756003)(2616005)(426003)(70206006)(356005)(81166007)(2906002)(26005)(82740400003)(316002)(82310400003)(7696005)(336012)(36860700001)(47076005)(186003)(8936002)(4326008)(8676002)(5660300002)(70586007)(478600001)(16526019)(6666004)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 07:04:02.3200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8bd4ea-e98c-4adc-23a4-08d958a85f2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
---
Changes since v1:
1. Modified the commit message and comments in the code
2. Squashed patch 1/7: "x86/amd_nb: Add Aldebaran device to PCI IDs"

 arch/x86/include/asm/amd_nb.h | 10 ++++++
 arch/x86/kernel/amd_nb.c      | 63 ++++++++++++++++++++++++++++++++---
 include/linux/pci_ids.h       |  1 +
 3 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 00d1a400b7a1..f15247422992 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -79,6 +79,16 @@ struct amd_northbridge_info {
 
 #ifdef CONFIG_AMD_NB
 
+/*
+ * On newer heterogeneous systems the data gabrics of the CPUs and GPUs
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
index 5884dfa619ff..5597135a18b5 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -26,6 +26,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
 #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT	0x14bb
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4	0x14d4
 
 /* Protect the PCI config register pairs used for SMN. */
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
@@ -182,11 +199,16 @@ int amd_cache_northbridges(void)
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
@@ -205,10 +227,16 @@ int amd_cache_northbridges(void)
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
 
@@ -222,15 +250,28 @@ int amd_cache_northbridges(void)
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
@@ -251,6 +292,18 @@ int amd_cache_northbridges(void)
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

