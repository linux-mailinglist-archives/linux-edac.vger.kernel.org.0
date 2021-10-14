Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E82542E1B5
	for <lists+linux-edac@lfdr.de>; Thu, 14 Oct 2021 20:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhJNS4x (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Oct 2021 14:56:53 -0400
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:51936
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229587AbhJNS4w (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Oct 2021 14:56:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiRFDqsuLBWlKfc62nVIWT/mVL3aO6spwtpq92lCu0s/I0StAZvS7fWT2WZEfwecVAzUFi5DvKIHg/T0Y+A6+eMuvN5lY09hMHHgGVkGQ2oeHXxwYsHYNGONWeIxadsH9Cjpjs8YkwKcFjpuUTZvSB07lsy4J8BPSrWxtv6tBR6WYz4OOsULqe/J4RSmuuCGdxwjBg4fP1a9YN/dQSoLNQeWV6Tyy2/MoarhmLHpQKPmXYr0p2eCv5aBaRBgUiEyh9Sh6xLBz2tuBg6VFMOCKcPGnkDmx1TcdTe/nGTSs1P8NL9lmY4JumR4CwEADFO7IyEEu9scsALbiZRhM+NKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCAqUrgrOvlfJaVLYb8DntD9zAxtBtoxUrwQLW5Afxo=;
 b=BYWn+TlyfK1NSjlkdTlcjqUZWa3oPcSJ7ri2mXCItMxMQhLglhIKxakCgruwHN4HGbwMw3NzSFnvL3RHOZ5Q3cq4kNei/XF7l5l3qnb8BWJMNiO5PwKl4uW5Ijbk/BBD7O07nffmKr3qHQOWDMXRSs7Rtf/6LwG+f8JBzM5bsgzYl98JJyEHjg2T0af12wrkluMbMzmjGl/RwDGFV3w6hbfL279B5CocYkFJJRwGnr6mS/cTGITo2yLTPlDLEftby1L5qpeeL624FY9GkwMe77KPEBcZsllb2sg1u6IjRowT03H4i2WVeYtJ+yMufS5Kub5JssHKomshYK2YBNrKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCAqUrgrOvlfJaVLYb8DntD9zAxtBtoxUrwQLW5Afxo=;
 b=SoKXX6dEHU2CTtUi56uzmhxt939PCKxtm1qa5DDBNZxXQ85BhM6whxi32dqe0m0D9SRoDD9avLxkStSW7+rpwIwUR94/hncLDPYqCWG3cAQtRNRe0t4TlpeCmiLkyyObMSdf/Qcr7eYEJJ9NqYLdbXyQcLDrXYg0GWZtp/2X9dU=
Received: from MW4PR04CA0229.namprd04.prod.outlook.com (2603:10b6:303:87::24)
 by DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Thu, 14 Oct
 2021 18:54:44 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::a6) by MW4PR04CA0229.outlook.office365.com
 (2603:10b6:303:87::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend
 Transport; Thu, 14 Oct 2021 18:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 18:54:43 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 13:54:39 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v4 1/4] x86/amd_nb: Add support for northbridges on Aldebaran
Date:   Fri, 15 Oct 2021 00:23:57 +0530
Message-ID: <20211014185400.10451-2-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211014185400.10451-1-nchatrad@amd.com>
References: <20210823185437.94417-1-nchatrad@amd.com>
 <20211014185400.10451-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 888187a3-8619-4928-7fd6-08d98f44159a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4650:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4650A7FA36E4AA493A678AECE8B89@DM6PR12MB4650.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bum4yquIGzbH/PhUnori20NxHhVZcAdx7cd6vfxvO16q4LIB6HaZjAT4zXyiNcl9xFJN+8dNzCN+glPnN5QOxzJiebEXnrAZwNtIRLEGWmdWrflJii2j9RFW4MJKWnLiFHftViDztOeEhTz7Fj25L8NrG5oUNWq8lG27Hf1Lgq8u+vLIwCOH9MIcATl4c3uHRN5oV5YHp475o05qL3m/nVoHd/5VfHPDj7NBCUfFdFGMPBDhEIfFjcQq5bxs2yMZCzu3WoUOresmK2Y/d8VDXkiT66umKSxqRmal6yEHVoLpg3h2L0qGP6a5vkTyaxXwnBGhTe7HJiA0v64AhrkMLy8IyY3GDoRcqGgjIsaw5GrfL7PVO3X0TyIvWrUSsDSg23rPLRxc6SZkswOSoroD0jCJqkc46Lx9BjjHfCVKAAMxxvunK6jJlHrvF5zyNJ3KLYVyHe3JXFuuU4RFVHXZx5pCfsaFbhroWMksx43skbF8E9OJIo0qaDOnO7Nf8ToCyzr30eOL/uHYpu168Hm63KQ+2G/CxOeglRELQzGVXHLs8naUXYx0rojkMgf57vTpzi7oLqueQ+RPjOVu1+qagBqFuJaxz4JfEDz+xuzptjd3EdyT0Hr+TLsHIiSvrGzKWjlX9mSmxIfqx08hRxbINV8TQyaOa6OMf+7ZsETdouai/i32hZWT9kjx9jqrSdu80IDDGJ+vwwg136S9NVC6J/bYoT7DRRqyTSPNykRCndhqnRxx2n8Fidx91kxBEs2GiNERDbxUOtcSuEKAxY9158GkOdqGPzhpxlJgpkLPR9V4K5Mz0gzpDF627BLFG003
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(6666004)(508600001)(2906002)(70206006)(2616005)(83380400001)(36860700001)(1076003)(70586007)(7696005)(54906003)(36756003)(110136005)(966005)(5660300002)(82310400003)(316002)(26005)(16526019)(81166007)(426003)(186003)(8676002)(356005)(47076005)(4326008)(8936002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 18:54:43.1021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 888187a3-8619-4928-7fd6-08d98f44159a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4650
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

On newer systems the CPUs manage MCA errors reported from the GPUs.
Enumerate the GPU nodes with the AMD NB framework to support EDAC.

GPU nodes are enumerated in sequential order based on the PCI hierarchy,
and the first GPU node is assumed to have an "AMD Node ID" value after
CPU Nodes are fully populated.

Aldebaran is an AMD GPU, GPU drivers are part of the DRM framework
https://lists.freedesktop.org/archives/amd-gfx/2021-February/059694.html

Each Aldebaran GPU has 2 Data Fabrics, which are enumerated as 2 nodes.
With this implementation detail, the Data Fabric on the GPU nodes can be
accessed the same way as the Data Fabric on CPU nodes.

Special handling was necessary in northbridge enumeration as the
roots_per_misc value is different for GPU and CPU nodes.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Link: https://lkml.kernel.org/r/20210823185437.94417-2-nchatrad@amd.com
---
Changes since v3:
1. Use word "gpu" instead of "noncpu" in the patch
2. Do not create pci_dev_ids arrays for gpu nodes
3. Identify the gpu node start index from DF18F1 registers on the GPU nodes.
  a. Export cpu node count and gpu start node id

Changes since v2:
1. Added Reviewed-by Yazen Ghannam

Changes since v1:
1. Modified the commit message and comments in the code
2. Squashed patch 1/7: "x86/amd_nb: Add Aldebaran device to PCI IDs"

 arch/x86/include/asm/amd_nb.h |   9 +++
 arch/x86/kernel/amd_nb.c      | 131 ++++++++++++++++++++++++++++------
 include/linux/pci_ids.h       |   1 +
 3 files changed, 118 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 455066a06f60..5898300f11ed 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -68,10 +68,17 @@ struct amd_northbridge {
 	struct threshold_bank *bank4;
 };
 
+/* heterogeneous system node type map variables */
+struct amd_node_map {
+	u16 gpu_node_start_id;
+	u16 cpu_node_count;
+};
+
 struct amd_northbridge_info {
 	u16 num;
 	u64 flags;
 	struct amd_northbridge *nb;
+	struct amd_node_map *nmap;
 };
 
 #define AMD_NB_GART			BIT(0)
@@ -83,6 +90,8 @@ struct amd_northbridge_info {
 u16 amd_nb_num(void);
 bool amd_nb_has_feature(unsigned int feature);
 struct amd_northbridge *node_to_amd_nb(int node);
+u16 amd_gpu_node_start_id(void);
+u16 amd_cpu_node_count(void);
 
 static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
 {
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index c92c9c774c0e..54a6a7462f07 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -19,6 +19,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
 #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
 #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT 0x14bb
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
@@ -28,6 +29,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4 0x14d4
 
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
 static DEFINE_MUTEX(smn_mutex);
@@ -40,6 +42,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT) },
 	{}
 };
 
@@ -63,6 +66,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3) },
 	{}
 };
 
@@ -81,6 +85,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4) },
 	{}
 };
 
@@ -126,6 +131,55 @@ struct amd_northbridge *node_to_amd_nb(int node)
 }
 EXPORT_SYMBOL_GPL(node_to_amd_nb);
 
+/*
+ * GPU start index and CPU count values on an heterogeneous system,
+ * these values will be used by the AMD EDAC and MCE modules.
+ */
+u16 amd_gpu_node_start_id(void)
+{
+	return (amd_northbridges.nmap) ?
+		amd_northbridges.nmap->gpu_node_start_id : 0;
+}
+EXPORT_SYMBOL_GPL(amd_gpu_node_start_id);
+
+u16 amd_cpu_node_count(void)
+{
+	return (amd_northbridges.nmap) ?
+		amd_northbridges.nmap->cpu_node_count : amd_northbridges.num;
+}
+EXPORT_SYMBOL_GPL(amd_cpu_node_count);
+
+/* DF18xF1 regsters on Aldebaran GPU */
+#define REG_LOCAL_NODE_TYPE_MAP		0x144
+#define REG_RMT_NODE_TYPE_MAP		0x148
+
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1 0x14d1
+
+static int amd_get_node_map(void)
+{
+	struct amd_node_map *np;
+	struct pci_dev *pdev = NULL;
+	u32 tmp;
+
+	pdev = pci_get_device(PCI_VENDOR_ID_AMD,
+			      PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1, pdev);
+	if (!pdev)
+		return -ENODEV;
+
+	np = kmalloc(sizeof(*np), GFP_KERNEL);
+	if (!np)
+		return -ENOMEM;
+
+	pci_read_config_dword(pdev, REG_LOCAL_NODE_TYPE_MAP, &tmp);
+	np->gpu_node_start_id = tmp & 0xFFF;
+
+	pci_read_config_dword(pdev, REG_RMT_NODE_TYPE_MAP, &tmp);
+	np->cpu_node_count = tmp >> 16 & 0xFFF;
+
+	amd_northbridges.nmap = np;
+	return 0;
+}
+
 static struct pci_dev *next_northbridge(struct pci_dev *dev,
 					const struct pci_device_id *ids)
 {
@@ -230,6 +284,27 @@ int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
 }
 EXPORT_SYMBOL_GPL(amd_df_indirect_read);
 
+struct pci_dev *get_root_devs(struct pci_dev *root,
+			      const struct pci_device_id *root_ids,
+			      u16 roots_per_misc)
+{
+	u16 j;
+
+	/*
+	 * If there are more PCI root devices than data fabric/
+	 * system management network interfaces, then the (N)
+	 * PCI roots per DF/SMN interface are functionally the
+	 * same (for DF/SMN access) and N-1 are redundant.  N-1
+	 * PCI roots should be skipped per DF/SMN interface so
+	 * the following DF/SMN interfaces get mapped to
+	 * correct PCI roots.
+	 */
+	for (j = 0; j < roots_per_misc; j++)
+		root = next_northbridge(root, root_ids);
+
+	return root;
+}
+
 int amd_cache_northbridges(void)
 {
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
@@ -237,10 +312,10 @@ int amd_cache_northbridges(void)
 	const struct pci_device_id *root_ids = amd_root_ids;
 	struct pci_dev *root, *misc, *link;
 	struct amd_northbridge *nb;
-	u16 roots_per_misc = 0;
-	u16 misc_count = 0;
-	u16 root_count = 0;
-	u16 i, j;
+	u16 roots_per_misc = 0, gpu_roots_per_misc = 0;
+	u16 misc_count = 0, gpu_misc_count = 0;
+	u16 root_count = 0, gpu_root_count = 0;
+	u16 i;
 
 	if (amd_northbridges.num)
 		return 0;
@@ -252,15 +327,23 @@ int amd_cache_northbridges(void)
 	}
 
 	misc = NULL;
-	while ((misc = next_northbridge(misc, misc_ids)) != NULL)
-		misc_count++;
+	while ((misc = next_northbridge(misc, misc_ids)) != NULL) {
+		if (misc->device == PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3)
+			gpu_misc_count++;
+		else
+			misc_count++;
+	}
 
 	if (!misc_count)
 		return -ENODEV;
 
 	root = NULL;
-	while ((root = next_northbridge(root, root_ids)) != NULL)
-		root_count++;
+	while ((root = next_northbridge(root, root_ids)) != NULL) {
+		if (root->device == PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT)
+			gpu_root_count++;
+		else
+			root_count++;
+	}
 
 	if (root_count) {
 		roots_per_misc = root_count / misc_count;
@@ -275,33 +358,35 @@ int amd_cache_northbridges(void)
 		}
 	}
 
-	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
+	/*
+	 * The number of miscs, roots and roots_per_misc might vary on different
+	 * nodes of a heterogeneous system.
+	 * calculate roots_per_misc accordingly in order to skip the redundant
+	 * roots and map the DF/SMN interfaces to correct PCI roots.
+	 */
+	if (gpu_root_count && gpu_misc_count) {
+		if (amd_get_node_map())
+			return -ENOMEM;
+
+		gpu_roots_per_misc = gpu_root_count / gpu_misc_count;
+	}
+
+	amd_northbridges.num = misc_count + gpu_misc_count;
+	nb = kcalloc(amd_northbridges.num, sizeof(struct amd_northbridge), GFP_KERNEL);
 	if (!nb)
 		return -ENOMEM;
 
 	amd_northbridges.nb = nb;
-	amd_northbridges.num = misc_count;
 
 	link = misc = root = NULL;
 	for (i = 0; i < amd_northbridges.num; i++) {
+		u16 misc_roots = i < misc_count ? roots_per_misc : gpu_roots_per_misc;
 		node_to_amd_nb(i)->root = root =
-			next_northbridge(root, root_ids);
+			get_root_devs(root, root_ids, misc_roots);
 		node_to_amd_nb(i)->misc = misc =
 			next_northbridge(misc, misc_ids);
 		node_to_amd_nb(i)->link = link =
 			next_northbridge(link, link_ids);
-
-		/*
-		 * If there are more PCI root devices than data fabric/
-		 * system management network interfaces, then the (N)
-		 * PCI roots per DF/SMN interface are functionally the
-		 * same (for DF/SMN access) and N-1 are redundant.  N-1
-		 * PCI roots should be skipped per DF/SMN interface so
-		 * the following DF/SMN interfaces get mapped to
-		 * correct PCI roots.
-		 */
-		for (j = 1; j < roots_per_misc; j++)
-			root = next_northbridge(root, root_ids);
 	}
 
 	if (amd_gart_present())
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 011f2f1ea5bb..b3a0ec29dbd6 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -557,6 +557,7 @@
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3 0x14d3
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.25.1

