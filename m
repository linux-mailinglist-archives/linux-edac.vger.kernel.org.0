Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A802342E1A5
	for <lists+linux-edac@lfdr.de>; Thu, 14 Oct 2021 20:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhJNSxd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Oct 2021 14:53:33 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:33120
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232090AbhJNSx2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Oct 2021 14:53:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7gvQpXfR8bLB5TuCBk8wXPmE4nxIwYzKn3UanRR/Uc/yKaDpUXCBSnMiWyWg7fKNoTCO8SNt7D/UYUFLkew+7slWMettvSDyy6Wb2vbf0O2nXq1vQsraIj/7I94CdLu/kfQspCfoKv0gkDxAsm9i2uJj+qF21po+BncPTkgxkWjsVUvWBLnch5BemVZSL39JFS85JGyeSx8J6vkgiemvt4NEM5sdeb004cPmzjZnEGcgNWUkzBVvywSQQbwpfMGqdd4qJOAhjNAPmXOWBQS23X8VL3pIGqn5O6QVLpTwmH0Th5d0w/0r/pLIrynn76tVfqAM35TcSu/Drq3j3W1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCAqUrgrOvlfJaVLYb8DntD9zAxtBtoxUrwQLW5Afxo=;
 b=ZQ6ifpfu14X82gFLpNPurA5JgOuk6noEPwxS5KQxurUfgsUhWBchidEUu6TWVR8tg+uzQP89gy6roQ0KoPdGdIRL99010O4la9YCN18sTTMQMF6vXJCGoQw34/Po3cxUJzDXExHEQmUyUzOzHEOk/kFFCx8CPovZmS0LqIu+9dKkkiczQnevIUPKdIobcQXkqJjMwrZSX13WSlf0y7bz59wI7skTfJFghtp1EqhqrbQcdU+Box3IYFBmUGmHEygDIVvdm+l95BP92BShBBFO+qMlOTehS/LEn7IxHneHeCAUJLD0umI3P94dR64ZKNmu1rZa6OC6EWTRYPKAyCiPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCAqUrgrOvlfJaVLYb8DntD9zAxtBtoxUrwQLW5Afxo=;
 b=UC6ki/FQ/O0SrPkdJIjiH3xk5XPdZaZNXm2mZOatIe/9YITLVRew8bxDnuXdT914DtB/yaEraGR7ncgI2b2xIMx60gT39YGdLbMn+egJqhkiX7LBLznD1fQSuuvauvl9Ne/ruO0OOtbo0L5FBPWDP4khYbs7DCA8dXHkmWLppqM=
Received: from CO2PR07CA0067.namprd07.prod.outlook.com (2603:10b6:100::35) by
 MWHPR12MB1197.namprd12.prod.outlook.com (2603:10b6:300:f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Thu, 14 Oct 2021 18:51:20 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::69) by CO2PR07CA0067.outlook.office365.com
 (2603:10b6:100::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Thu, 14 Oct 2021 18:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 18:51:20 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 13:51:17 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v4 1/4] x86/amd_nb: Add support for northbridges on Aldebaran
Date:   Fri, 15 Oct 2021 00:20:55 +0530
Message-ID: <20211014185058.9587-2-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211014185058.9587-1-nchatrad@amd.com>
References: <20210823185437.94417-1-nchatrad@amd.com>
 <20211014185058.9587-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15408b1f-7af7-45f5-786b-08d98f439cc1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1197:
X-Microsoft-Antispam-PRVS: <MWHPR12MB11975AAEC53A41083B806204E8B89@MWHPR12MB1197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLc5QvGMnVz2c9p71y+6brc7yIE7x3XC/RDmfX31sU6ysaWxyW2E0yyTEqtKLW7/wovokeY9iHPkHKKLvZ6mtracDsHoQOTACtBncyowzIs4QveEMZEp5rTzRpllTiq14zvCS9TZQe0DUZA6veXsXqTdz4ilJip31myzbYuEsd8jq/e9wIsk6Dy+jeuTzZRZXnBE81swQJXthc8k1XJvC6LmDpTrvtbbstJn3aOc1xoaPknN31XYMrwXnkbh/ZTxK3J+0oNT2UC5aEUNe5V6JlIp4zHPrvv8sPmjrtZq4ijKSQxXxvrfUeBgQP/RuzM0ROMdDzr/WlDy8orSFLniahQIsReB0v95rCaa1rGoE3jMZyIgbfnbxzWh3I+VGjCwPkcFYPSXR2GZzT2HLG3LlVkfdki1z6MmCBs9/aUMLhp+sD+hTrBu803bYEJaDEqROzuvnBn+Vyl7ETMgsie9TCO3v6X5H+HoIu69Jvh8OfqDMVt09hN9ZOtw/Oz+UV13/Tx9wFCzgETfGkQ+XiAGCxVDR1kHNSylVAH3ZxyuO6SG4jPxCDus/Gg/9kYodS1gmdVIPjJ2fAxlxtVJKoiFkzu8MzkcuYiPriT2rCOGc7YHwJ4oMjFqMddyo/KsaTcuQfkkhxsyNgcxhW2zDJeEJCugGbxOQOKlybXeGlQvzX6Anrwopw0kqn5sJUCJrTSePvGXkph4fuAq2fWuOn8sTEwhR6ImCeESdy4OYoSXHBwQXuPtJ30h8wPQ/rU/RrKaXg6UuSpnBvLE435MSSoiEoPFwpfYW/rhscCesCMCMlfaGr2vwuXKGJAKvcGbHn+n
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(426003)(186003)(6666004)(2616005)(316002)(36860700001)(1076003)(70586007)(16526019)(70206006)(26005)(7696005)(336012)(81166007)(47076005)(2906002)(508600001)(8676002)(54906003)(8936002)(82310400003)(83380400001)(36756003)(966005)(4326008)(356005)(110136005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 18:51:20.3222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15408b1f-7af7-45f5-786b-08d98f439cc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1197
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

