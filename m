Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEC943E180
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 15:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhJ1NEI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 09:04:08 -0400
Received: from mail-mw2nam10on2087.outbound.protection.outlook.com ([40.107.94.87]:3977
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230157AbhJ1NEF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 09:04:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2822eiWcVQD9lZI5eCGTy6kODatiV7iglYGEdX725wX3GGWvoKpaJEodMPZ+tnPUC5bXKY0gqHyjWUgrTB3cxyyywoITPlmJlJjjT6jrtckNU477142BbWi/mdeEHdux3o2HajgtRoRorj5Y2LEVCvxXJeVEc/QePhN6cH7wVi650CqTP5PHiR0jGAshKY/Pwzf9a+MyNvVoXRpZ4m/c6gGQUBjiCcHrxQ3uRap+HV4GsYMHxWi9mmuKl3XvYH/Es1s+GsFaYpFQU2dZa0sn8nKQzztPrzLX6/KdK/RN/cy/aWJcC0pWS70Mt5larwYt0vee8NBCvqngeMuPqx1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0x/g4vXueCZ3gYz9Imo1IzZDoUJqvQVNCSBXKXaaEno=;
 b=mlFHLihSW9Y07u/cFoOgjD82iscqqbtEPN5VO2MQi8vNkpgg+JB5o8yuB9Lwyavbqp2yI5pbSrsxmKkarNjNbvOY9VZDlvU4kmgjS8ks1yVukg9MoSRtmITzZLRh6BTuwxd2vuQ6ixg4rbQT+dyurdLG9yBRj99gAVxzrHxX03sGBNosdVf3/C2dHju/N7l7t8bPJ5QTIHsHuNr04LD+gD66oHPcQEAVzei0gHmAadLmgep7RWZyfsZyx1LZMFMGs+RXNJzpqVCr5rAhAxjaD++di6KIOcgHzUvtaGNmvuONXjjaOKHE1nXDIdsxJcI7/Udv/22p8/DozOXCsXAkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0x/g4vXueCZ3gYz9Imo1IzZDoUJqvQVNCSBXKXaaEno=;
 b=EU4N7T0BrvRFTPph9MQo9n+vKgxhOu6P1F2oRIP6YhduQMHmvIUZ7pxpkIIRKu1IkpU6I97rejurkJK5VB8rXaF2OM7As5yw/93IhHp+YiyA4nqo2a1eD+6559JWvj60KZtke1mGVCYMbSDHqUyXAx6uVnLSK5OmC0P5uatcCg0=
Received: from DM5PR18CA0084.namprd18.prod.outlook.com (2603:10b6:3:3::22) by
 DM5PR12MB2423.namprd12.prod.outlook.com (2603:10b6:4:b3::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Thu, 28 Oct 2021 13:01:30 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::ae) by DM5PR18CA0084.outlook.office365.com
 (2603:10b6:3:3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 13:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 13:01:29 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 08:01:25 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v6 1/5] x86/amd_nb: Add support for northbridges on Aldebaran
Date:   Thu, 28 Oct 2021 18:31:02 +0530
Message-ID: <20211028130106.15701-2-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211028130106.15701-1-nchatrad@amd.com>
References: <20211028130106.15701-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a77d20aa-775e-4680-03d1-08d99a130f03
X-MS-TrafficTypeDiagnostic: DM5PR12MB2423:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24236466EA56524E0BE0DB85E8869@DM5PR12MB2423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06qp6LHjnQM7tJ14eQ9WKyBnbbhBvh0+cwN3Vc3g2clugVRr62mScpsm7OhMndxL2CpgQwer03joV3Q71JxVkK3KZlkLDO1gVQX7RgocudZ5dOyUYxyamplvGmE3BSDGwT/hhUHZHZroiSj2/t2eU1ZBuDjTWXIADv2WL7EDnqS3ZBGnb51lPwvcGV6shwiaCb4TY0FmeIL17UsIWEnEgtfAIAaU4oTGu2ZI/r/qK8WDMbFprEd6dRjgETE2ZSIAoV4riHf++U5Y5cqfnFNq9sHljZrK0EXnRqo5vb5NHB0le1qCQYu0XvMJ6EEKtzn108QqlRm2+FcYkWPtMcZLpx4B/NvhXsoW2Sawu/YJWSaNS+CU3v9U5EORggp51K09vNxVXW0iYYY+MJgv47eDS4tBiTPD+naz1rRIR29ECQFKffmR15WHBBe8x6EXerJuy55TAb5YCcBgwmrhDzykmK+Ej5kNMzQjZsb/gSxfyaxrapKrOcFZ6AxQfFtFMk2AyTsBMrPUmfTTl+/QSl2Av4yy0qGijQXapz/UMFjMad5v6y6P0srB3EH7BhtNBUPwk/do4HsCMStvvSql/EBT4zH+smpfR7yldbiFOa1AE4TAwRXrOb9xkWLBKxFVheL5olTqwJdfNCjszmyBhT4LK6sijQr401dlkYjCt1PEs/8UmoihKWoB/vXI7dcOHnBssNwbtBQLPkBUNSK4ndp7g3S8C0Xm74wOJ55tQfJzlhst9lW/rGO4R6BUcNAOqiDqfrecokjsF49lic5IoXIVucH9z3Th50rjqYXFrfAGalLD6EB0f5YGDvaUPb225h+i
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(6666004)(316002)(26005)(70206006)(966005)(16526019)(83380400001)(81166007)(82310400003)(70586007)(356005)(426003)(1076003)(186003)(5660300002)(110136005)(2616005)(508600001)(36860700001)(8676002)(47076005)(36756003)(2906002)(336012)(8936002)(54906003)(7696005)(4326008)(30864003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 13:01:29.5538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77d20aa-775e-4680-03d1-08d99a130f03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2423
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
Changes since v5:
Modified amd_get_node_map() and checking return value

Changes since v4:
1. renamed struct name from nmap to nodemap
2. split amd_get_node_map and addressed minor comments

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
 arch/x86/kernel/amd_nb.c      | 146 ++++++++++++++++++++++++++++------
 include/linux/pci_ids.h       |   1 +
 3 files changed, 133 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 455066a06f60..a78d088dae40 100644
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
+	struct amd_node_map *nodemap;
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
index c92c9c774c0e..199d9d79edfb 100644
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
 
@@ -126,6 +131,68 @@ struct amd_northbridge *node_to_amd_nb(int node)
 }
 EXPORT_SYMBOL_GPL(node_to_amd_nb);
 
+/*
+ * GPU start index and CPU count values on an heterogeneous system,
+ * these values will be used by the AMD EDAC and MCE modules.
+ */
+u16 amd_gpu_node_start_id(void)
+{
+	return (amd_northbridges.nodemap) ?
+		amd_northbridges.nodemap->gpu_node_start_id : 0;
+}
+EXPORT_SYMBOL_GPL(amd_gpu_node_start_id);
+
+u16 amd_cpu_node_count(void)
+{
+	return (amd_northbridges.nodemap) ?
+		amd_northbridges.nodemap->cpu_node_count : amd_northbridges.num;
+}
+EXPORT_SYMBOL_GPL(amd_cpu_node_count);
+
+/* GPU Data Fabric ID Device 24 Function 1 */
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1 0x14d1
+
+/* DF18xF1 registers on Aldebaran GPU */
+#define REG_LOCAL_NODE_TYPE_MAP		0x144
+#define REG_RMT_NODE_TYPE_MAP		0x148
+
+/*
+ * Newer AMD CPUs and GPUs whose data fabrics can be connected via custom xGMI
+ * links, comes with registers to gather local and remote node type map info.
+ *
+ * "Local Node Type" refers to nodes with the same type as that from which the
+ * register is read, and "Remote Node Type" refers to nodes with a different type.
+ *
+ * This function, reads the registers from GPU DF function 1.
+ * Hence, local nodes are GPU and remote nodes are CPUs.
+ */
+static int amd_get_node_map(void)
+{
+	struct amd_node_map *nodemap;
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
+	nodemap = kmalloc(sizeof(*nodemap), GFP_KERNEL);
+	if (!nodemap)
+		return -ENOMEM;
+
+	pci_read_config_dword(pdev, REG_LOCAL_NODE_TYPE_MAP, &tmp);
+	nodemap->gpu_node_start_id = tmp & 0xFFF;
+
+	pci_read_config_dword(pdev, REG_RMT_NODE_TYPE_MAP, &tmp);
+	nodemap->cpu_node_count = tmp >> 16 & 0xFFF;
+
+	amd_northbridges.nodemap = nodemap;
+	return 0;
+}
+
 static struct pci_dev *next_northbridge(struct pci_dev *dev,
 					const struct pci_device_id *ids)
 {
@@ -230,6 +297,27 @@ int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
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
@@ -237,10 +325,10 @@ int amd_cache_northbridges(void)
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
@@ -252,15 +340,23 @@ int amd_cache_northbridges(void)
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
@@ -275,33 +371,37 @@ int amd_cache_northbridges(void)
 		}
 	}
 
-	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
+	/*
+	 * The number of miscs, roots and roots_per_misc might vary on different
+	 * nodes of a heterogeneous system.
+	 * Calculate roots_per_misc accordingly in order to skip the redundant
+	 * roots and map the DF/SMN interfaces to correct PCI roots.
+	 */
+	if (gpu_root_count && gpu_misc_count) {
+		int ret = amd_get_node_map();
+
+		if (ret)
+			return ret;
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

