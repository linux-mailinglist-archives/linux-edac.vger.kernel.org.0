Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C7A4A8ABE
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 18:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353158AbiBCRuj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 12:50:39 -0500
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:20992
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353102AbiBCRua (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOfIkk71lkwRzRBSNvGycrxhAOTlLIGcYlHmNeAYKThrKCpu3w7CLugX1HWjOeW8ZIxN9kIYVxmd26MX0aPjkIfFb528l4hop8FLKg1hROLU8p3oGtsmVH63CbvDrnbZBDWTSDabgffnq3Xk4KhuzoMo9YjibL/cXayXJsqxGMcDmyo+Ej96vWAS7wvJk4FZu0BM6qkBB7Ra5JNY+mi2GkzOzAojwVV92vopL7Kyc/IauiQBYrHsWjLBS6U9pBWJqbJFvPJrnA18bvLUzaKOkPMp2wjfhks1ijzG9h3PTr+TvRhbeeoxnVyydYr4Yp12bAXRIBYqvE4sflh02B9Nig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoSjIfLDHJWcguDs0+rp/3HRa+VtjUJfsc/r7bRSYMU=;
 b=doGUoXAfyYw2puEbO0qVG8g4tfaaEdtLmfqb5RADx+91pHZJsmx41YMsG+TL2oxPbrKfjBP4Rr2FVbQp4YaAlzsVpnx3o5byglEdHq1BfafiYE9/P9MKfxdNizS/f8b7+G0154fZwSyNb3Z505W2em5izmXZUM/NICcQg2XGZ9o+EuFiWXziGBi0JCJC3ffAfgj+wykdYx1EOhRwnDCEv6FZNU278gsUIHjCwNahWEMtNvUZMjzgwZhgiPwGEBQZ2DJXEdoE0pbaX6JqpRLu4QB2aXKPtBjmSP7RQDsAZFuAW5ruOMQjWJc9Y8v5f0YiEpPpxcKRNIsp5ah104f+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoSjIfLDHJWcguDs0+rp/3HRa+VtjUJfsc/r7bRSYMU=;
 b=1DyoenPDaHoHUX++9C/ecuROQxBnnW55gg9g54ixLd1xaO/zxGuXGr4PKME4smvVQM177eMvH0q1KKV6jImM5l7exEtdlGOODmln6M6qU0IjNb44g3Lo4z21BU5eqaYnc0UKvU49AraEfB9G5O00WlrYcrHnyN8uHQHiqoJTXkA=
Received: from MW4PR02CA0030.namprd02.prod.outlook.com (2603:10b6:303:16d::18)
 by MN2PR12MB2973.namprd12.prod.outlook.com (2603:10b6:208:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Thu, 3 Feb
 2022 17:50:27 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::e6) by MW4PR02CA0030.outlook.office365.com
 (2603:10b6:303:16d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 17:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:50:26 +0000
Received: from node-bp128-r03d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 11:50:23 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v7 02/12] x86/amd_nb: Add support for northbridges on Aldebaran
Date:   Thu, 3 Feb 2022 11:49:32 -0600
Message-ID: <20220203174942.31630-3-nchatrad@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203174942.31630-1-nchatrad@amd.com>
References: <20220203174942.31630-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7f036b3-910d-492a-c0ff-08d9e73da94e
X-MS-TrafficTypeDiagnostic: MN2PR12MB2973:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB29737A638FBED4F00D209395E8289@MN2PR12MB2973.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gn8Q7qjiwQ8mz5AyJj1O87CW3ANKl0O3lB7IOQoKNt0qanB3ZZpa1pOor/WIUkYC+jWp9/HYnuZTXHBSKUq0k6OXKB39mj9apFBj2bBAlLw6DIOndnp5D+OdEMvpwhqRsJk3ybOYzaef+ilbHGs2KtWvXJvKVnJyR+DStf6e9GQfuHdouBVLXOhE//dPL+DduHR5opLl7OTd5MrMbt0f6+xgxT9EWdU5fT4gI1C3ZK4hYvEkXax5oIOMpfkKsL3oKWlkPRiao/zq3xYUoLt7CuOYY5qLemdmN+7iXQMga13/xs0+Ro+jy4DaOQZsWqHz128pFc8VkP8W8QOltTRe3UJLhIFxtPAmC61T3ArnmXOFtNBfa62zFcJxPz+utSLs6t30bZX7edSjFjHLj/vMBjcc+e9G+pnBRtbJDekhvzIQIf34uqhn+ZmvbWMHspYFVs01xgM2l0jPhcsaWnZH6VjJCRlmXV1FTmMNvqYeAvFuQncwDkLQbldVXew4b4NYqg9koj7tPb26LRrlOlX+R0carzvV2v2hqKZjuH0OLUzTBkkdTvpbnMzUFJ5fGz9tiBCBIFrNzjGy0ouOwsw/4+vG+IsMKfXKT/zxwyaJ2laDC0eGLSi2cHheLLYpmF0h9azQ9wjJcrFk+WgrbFjYHHLj6eibdPWeuA/QJsFTlGDb6bYx86fP6olYL30dEL1k0fYfMHZfIn5KmG7Nxw8Ryzwk4gldDZe4KQimeMQiakC5tbmedU7lqg7UDm4sbH6hLjSDBHMynPAdY8NGiJ1XzwsFXdpX2gyyM/MT/EMpb8I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(70206006)(110136005)(40460700003)(81166007)(8936002)(356005)(6666004)(36860700001)(54906003)(7696005)(70586007)(8676002)(966005)(2906002)(186003)(26005)(82310400004)(426003)(2616005)(508600001)(47076005)(36756003)(1076003)(5660300002)(336012)(316002)(83380400001)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:50:26.7449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f036b3-910d-492a-c0ff-08d9e73da94e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2973
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

Handled new device support and enumeration by calling separate function
in init_amd_nbs with completely separate data structures.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
Link:
https://lkml.kernel.org/r/20211028130106.15701-2-nchatrad@amd.com

v6->v7:
* API amd_gpu_node_start_id() introduced to reuse in future patches.

v5->v6:
* Defined seperate structure for GPU NBs and handled GPu enumearation
  seperately by defining new function amd_cache_gpu_devices
* Defined amd_get_gpu_node_id which will be used by mce module

v4->v5:
* Modified amd_get_node_map() and checking return value

v3->v4:
* renamed struct name from nmap to nodemap
* split amd_get_node_map and addressed minor comments

v2->v3:
* Use word "gpu" instead of "noncpu" in the patch
* Do not create pci_dev_ids arrays for gpu nodes
* Identify the gpu node start index from DF18F1 registers on the GPU nodes.
  Export cpu node count and gpu start node id

v1->v2:
* Added Reviewed-by Yazen Ghannam

v0->v1
* Modified the commit message and comments in the code
* Squashed patch 1/7: "x86/amd_nb: Add Aldebaran device to PCI IDs"


 arch/x86/include/asm/amd_nb.h |   9 ++
 arch/x86/kernel/amd_nb.c      | 149 +++++++++++++++++++++++++++++++++-
 include/linux/pci_ids.h       |   1 +
 3 files changed, 155 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 00d1a400b7a1..cb8bc59d17a0 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -73,6 +73,12 @@ struct amd_northbridge_info {
 	struct amd_northbridge *nb;
 };
 
+struct amd_gpu_nb_info {
+	u16 gpu_num;
+	struct amd_northbridge *gpu_nb;
+	u16 gpu_node_start_id;
+};
+
 #define AMD_NB_GART			BIT(0)
 #define AMD_NB_L3_INDEX_DISABLE		BIT(1)
 #define AMD_NB_L3_PARTITIONING		BIT(2)
@@ -80,8 +86,11 @@ struct amd_northbridge_info {
 #ifdef CONFIG_AMD_NB
 
 u16 amd_nb_num(void);
+u16 amd_gpu_nb_num(void);
+u16 amd_gpu_node_start_id(void);
 bool amd_nb_has_feature(unsigned int feature);
 struct amd_northbridge *node_to_amd_nb(int node);
+int amd_get_gpu_node_system_id(u64 ipid);
 
 static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
 {
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 020c906f7934..dfa7c7516321 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -20,6 +20,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
 #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
 #define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT 0x14bb
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
@@ -30,6 +31,14 @@
 #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4 0x14d4
+
+/* GPU Data Fabric ID Device 24 Function 1 */
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1 0x14d1
+
+/* DF18xF1 register on Aldebaran GPU */
+#define REG_LOCAL_NODE_TYPE_MAP		0x144
+
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -104,6 +113,21 @@ static const struct pci_device_id hygon_nb_link_ids[] = {
 	{}
 };
 
+static const struct pci_device_id amd_gpu_root_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT) },
+	{}
+};
+
+static const struct pci_device_id amd_gpu_misc_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3) },
+	{}
+};
+
+static const struct pci_device_id amd_gpu_link_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4) },
+	{}
+};
+
 const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
 	{ 0x00, 0x18, 0x20 },
 	{ 0xff, 0x00, 0x20 },
@@ -112,6 +136,8 @@ const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
 };
 
 static struct amd_northbridge_info amd_northbridges;
+/* GPU specific structure declaration */
+static struct amd_gpu_nb_info amd_gpu_nbs;
 
 u16 amd_nb_num(void)
 {
@@ -119,6 +145,20 @@ u16 amd_nb_num(void)
 }
 EXPORT_SYMBOL_GPL(amd_nb_num);
 
+/* Total number of GPU nbs in a system */
+u16 amd_gpu_nb_num(void)
+{
+	return amd_gpu_nbs.gpu_num;
+}
+EXPORT_SYMBOL_GPL(amd_gpu_nb_num);
+
+/* Start index of hardware provided GPU node ID */
+u16 amd_gpu_node_start_id(void)
+{
+	return amd_gpu_nbs.gpu_node_start_id;
+}
+EXPORT_SYMBOL_GPL(amd_gpu_node_start_id);
+
 bool amd_nb_has_feature(unsigned int feature)
 {
 	return ((amd_northbridges.flags & feature) == feature);
@@ -127,10 +167,60 @@ EXPORT_SYMBOL_GPL(amd_nb_has_feature);
 
 struct amd_northbridge *node_to_amd_nb(int node)
 {
-	return (node < amd_northbridges.num) ? &amd_northbridges.nb[node] : NULL;
+	if (node < amd_northbridges.num)
+		return &amd_northbridges.nb[node];
+	else if (node >= amd_northbridges.num &&
+		 node < amd_gpu_nbs.gpu_num + amd_northbridges.num)
+		return &amd_gpu_nbs.gpu_nb[node - amd_northbridges.num];
+	else
+		return NULL;
 }
 EXPORT_SYMBOL_GPL(node_to_amd_nb);
 
+/*
+ * On SMCA banks of the GPU nodes, the hardware node id information is
+ * available in register MCA_IPID[47:44](InstanceIdHi).
+ *
+ * Convert the hardware node ID to a value used by linux where
+ * GPU nodes are sequentially after the CPU nodes.
+ */
+int amd_get_gpu_node_system_id(u64 ipid)
+{
+	return ((ipid >> 44 & 0xF) - amd_gpu_node_start_id()
+				   + amd_northbridges.num);
+}
+EXPORT_SYMBOL_GPL(amd_get_gpu_node_system_id);
+
+/*
+ * AMD CPUs and GPUs whose data fabrics can be connected via custom xGMI
+ * links, come with registers to gather local and remote node type map info.
+ *
+ * This function, reads the register in DF function 1 from "Local Node Type"
+ * which refers to GPU node.
+ */
+static int amd_gpu_df_nodemap(void)
+{
+	struct pci_dev *pdev;
+	u32 tmp;
+
+	pdev = pci_get_device(PCI_VENDOR_ID_AMD,
+			      PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1, NULL);
+	if (!pdev) {
+		pr_debug("DF Func1 PCI device not found on this node.\n");
+		return -ENODEV;
+	}
+
+	if (pci_read_config_dword(pdev, REG_LOCAL_NODE_TYPE_MAP, &tmp))
+		goto out;
+	amd_gpu_nbs.gpu_node_start_id = tmp & 0xFFF;
+
+	return 0;
+out:
+	pr_warn("PCI config access failed\n");
+	pci_dev_put(pdev);
+	return -ENODEV;
+}
+
 static struct pci_dev *next_northbridge(struct pci_dev *dev,
 					const struct pci_device_id *ids)
 {
@@ -147,7 +237,7 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 	struct pci_dev *root;
 	int err = -ENODEV;
 
-	if (node >= amd_northbridges.num)
+	if (node >= amd_northbridges.num + amd_gpu_nbs.gpu_num)
 		goto out;
 
 	root = node_to_amd_nb(node)->root;
@@ -210,14 +300,14 @@ int amd_cache_northbridges(void)
 	}
 
 	misc = NULL;
-	while ((misc = next_northbridge(misc, misc_ids)) != NULL)
+	while ((misc = next_northbridge(misc, misc_ids)))
 		misc_count++;
 
 	if (!misc_count)
 		return -ENODEV;
 
 	root = NULL;
-	while ((root = next_northbridge(root, root_ids)) != NULL)
+	while ((root = next_northbridge(root, root_ids)))
 		root_count++;
 
 	if (root_count) {
@@ -292,6 +382,56 @@ int amd_cache_northbridges(void)
 }
 EXPORT_SYMBOL_GPL(amd_cache_northbridges);
 
+int amd_cache_gpu_devices(void)
+{
+	const struct pci_device_id *misc_ids = amd_gpu_misc_ids;
+	const struct pci_device_id *link_ids = amd_gpu_link_ids;
+	const struct pci_device_id *root_ids = amd_gpu_root_ids;
+	struct pci_dev *root, *misc, *link;
+	struct amd_northbridge *gpu_nb;
+	u16 misc_count = 0;
+	u16 root_count = 0;
+	int ret;
+	u16 i;
+
+	if (amd_gpu_nbs.gpu_num)
+		return 0;
+
+	ret = amd_gpu_df_nodemap();
+	if (ret)
+		return ret;
+
+	misc = NULL;
+	while ((misc = next_northbridge(misc, misc_ids)))
+		misc_count++;
+
+	if (!misc_count)
+		return -ENODEV;
+
+	root = NULL;
+	while ((root = next_northbridge(root, root_ids)))
+		root_count++;
+
+	gpu_nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
+	if (!gpu_nb)
+		return -ENOMEM;
+
+	amd_gpu_nbs.gpu_nb = gpu_nb;
+	amd_gpu_nbs.gpu_num = misc_count;
+
+	link = NULL, misc = NULL, root = NULL;
+	for (i = amd_northbridges.num; i < (amd_northbridges.num + amd_gpu_nbs.gpu_num); i++) {
+		node_to_amd_nb(i)->root = root =
+			next_northbridge(root, root_ids);
+		node_to_amd_nb(i)->misc = misc =
+			next_northbridge(misc, misc_ids);
+		node_to_amd_nb(i)->link = link =
+			next_northbridge(link, link_ids);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(amd_cache_gpu_devices);
+
 /*
  * Ignores subdevice/subvendor but as far as I can figure out
  * they're useless anyways
@@ -497,6 +637,7 @@ static __init int init_amd_nbs(void)
 {
 	amd_cache_northbridges();
 	amd_cache_gart();
+	amd_cache_gpu_devices();
 
 	fix_erratum_688();
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index aad54c666407..27fad5e1bf80 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -558,6 +558,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
 #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3 0x14d3
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.25.1

