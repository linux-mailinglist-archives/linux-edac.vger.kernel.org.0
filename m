Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBAF702BB2
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 13:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbjEOLln (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 07:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241483AbjEOLjl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 07:39:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878452686;
        Mon, 15 May 2023 04:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx9P6O827hL4N6jlWSX1gUxe7A/T8X56Cy9O6652zQWvyxKMkIWl70FJZbwRduNA6P8O//ujkR0AVnpNZ6bXiaaFxLFkAnF0S9mLQfI91mRX7E5DKtQKu/5ffLnPMKfd4gsW9HLJqxfshyNhLbqteakdqdFdZ+/e86CibiIcKjmiVe+gyomRl7jLTrEoPbJldz38Ng86X5B21zihsO7Q7XqJMH2ZY7ywpz2G346E2SzZe/K21wNhElup6CO3MsWr4AzVSL3egV/156r+BMj9XA82Jejq7fclXfrb6+f9EzKhlmpCSDeotKG7LUcwaqkeM+VWN9N+E7jI2d5cWrbHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra7RonSk1GnQW8K51m2jRMJIcijnXfPN8FOp8iCanY8=;
 b=XKqStM5l9UHp4drUldcc6DIDzVtoJA6euw4qi9IQyAoScDFiOddQgSftHRA4GMtaNfOAvNP3FV/aJHOSvDLNjIRSGZVQZmC3r5OEqy7tuCgXmqoUiF5ahL6wVUS7rVnHNV14wSZiPkVHyYf+E3xF/ccwSWI1FUloDaPtAKTCfJHQ0EnZf88UBLiHB1VTigPk+JbuC8rnXaZ0HCxrp/XIfyehymhJu7AjKLRw3CD/U0p38jf8kZuYEuuFVipkJjXrhqZYIrdWfjhYl7IECb/9LpYGr+eYq//oLwONr+PWo6MMsGPg28i7+wTGcHghTSewMSO79qBBW5H1oVNDo1cUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra7RonSk1GnQW8K51m2jRMJIcijnXfPN8FOp8iCanY8=;
 b=ur+gmmQYUUvB9ZcP7KyGS63p+HgHhbFkRp6v8/9WMKlOXmKQ/5T4rLrl717hNd7xsQTS30Q/6TEFW2EunMsCsUuH4B8mQhKW2XjTmTqCESRvJ3wtZ7Gke+eVLsaK14gJFXTgSU/Wg7not7rk13TjD38R2uEKF4KsI0HOKgNWHao=
Received: from DM6PR18CA0027.namprd18.prod.outlook.com (2603:10b6:5:15b::40)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 11:36:11 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::bc) by DM6PR18CA0027.outlook.office365.com
 (2603:10b6:5:15b::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 11:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 11:36:10 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 06:36:07 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>, <nchatrad@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 5/5] EDAC/amd64: Cache and use GPU node map
Date:   Mon, 15 May 2023 11:35:37 +0000
Message-ID: <20230515113537.1052146-6-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515113537.1052146-1-muralimk@amd.com>
References: <20230515113537.1052146-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: d2075d5a-9790-42ff-a587-08db553894f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nfot9OBe0J+dIWkqrGsoudfKW7rEOOeBgCZ2mR1wG6DeB2apzDCxy3KdFn4N2ETIfBm3gOac9iOEGerK6qTcVeV2P/365JHBB8vVu9mO2wu/b5pYsgC3H1oAJjMd/t3E173+YVsvTO1ompZqilTii+eN1/+WnDQ8X/KJl+PE2pYKkJfhWVRy9GyALVD2Ddk7ELckt2uAnNknnmp2mNoRlMh9C3Hz7c6wu2Dxo0zmTUB2qWQ+DfP2os8ARNIgSx9ghLcTUYeZWy9bQ9YTTRs64aEEQRgJJbDSIu6brIxriW7kYQS0rmSpFbY/nirm9bj7ffVSSDKDUBlHOKckEY/r6KuBipN6XyqgvYdTjntS7X7VdPCFA5O8AtHjPCZp1s5gwnm0pti1OX36HvWxLFzPwSSl9EjHUFqCTUwfOhmK1jsfNWN2SgYF1kTFIX+WugjAOxrrE220Vld8o40SA89X7kjakDAIp9bqTfVln3N7hF2gTxhZxg3hs81wbYtnXGPxaa+FGS09wyhP6ujd4PWYkE6urszRnLfFt9Ve4MOVnUOcnZHIBBmWZTYOJlIW3kyEw0QMWHVhmCFXY/MW3igISQGAJnKWRxkua+4OWMA720hUrlKCG0WPCv3Gsr9lM+PO5OFzdB1LrzCVdt5QO/UDtnRgWRlbokXOwivG9DYFTeHgc8ArOe+jfvKHFRr4oPyFOUw3yin0UBnbVR1xldwr0kGybd1oi0/7ZTNkmTR+uCaLOXVDxsETBZ/NBMEd1z5+hs62uZhMUtPc524ELN0Waw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(336012)(47076005)(83380400001)(36860700001)(426003)(316002)(70586007)(70206006)(2616005)(7696005)(1076003)(26005)(40480700001)(478600001)(2906002)(54906003)(110136005)(16526019)(6666004)(186003)(8676002)(8936002)(40460700003)(5660300002)(36756003)(356005)(82740400003)(4326008)(41300700001)(81166007)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 11:36:10.7604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2075d5a-9790-42ff-a587-08db553894f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

AMD systems have historically provided an "AMD Node ID" that is a unique
identifier for each die in a multi-die package. This was associated with
a unique instance of the AMD Northbridge on legacy system. And now it is
associated with a unique instance of the AMD Data Fabric on modern
systems. Each instance is referred to as a "Node"; this is an
AMD-specific term not to be confused with NUMA nodes.

The data fabric provides a number of interfaces accessible through a set
of functions in a single PCI device. There is one PCI device per Data
Fabric (AMD Node), and multi-die systems will see multiple such PCI
devices. The AMD Node ID matches a Node's position in the PCI hierarchy.
For example, the Node 0 is accessed using the first PCI device, Node 1
is accessed using the second, and so on. A logical CPU can find its AMD
Node ID using CPUID. Furthermore, the AMD Node ID is used within the
hardware fabric, so it is not purely a logical value.

Heterogeneous AMD systems, with a CPU Data Fabric connected to GPU data
fabrics, follow a similar convention. Each CPU and GPU die has a unique
AMD Node ID value, and each Node ID corresponds to PCI devices in
sequential order.

However, there are two caveats:
1) GPUs are not x86, and they don't have CPUID to read their AMD Node ID
like on CPUs. This means the value is more implicit and based on PCI
enumeration and hardware-specifics.
2) There is a gap in the hardware values for AMD Node IDs. Values 0-7
are for CPUs and values 8-15 are for GPUs.

For example, a system with one CPU die and two GPUs dies will have the
following values:
  CPU0 -> AMD Node 0
  GPU0 -> AMD Node 8
  GPU1 -> AMD Node 9

EDAC is the only subsystem where this has a practical effect. Memory
errors on AMD systems are commonly reported through MCA to a CPU on the
local AMD Node. The error information is passed along to EDAC where the
AMD EDAC modules use the AMD Node ID of reporting logical CPU to access
AMD Node information.

However, memory errors from a GPU die will be reported to the CPU die.
Therefore, the logical CPU's AMD Node ID can't be used since it won't
match the AMD Node ID of the GPU die. The AMD Node ID of the GPU die is
provided as part of the MCA information, and the value will match the
hardware enumeration (e.g. 8-15).

Handle this situation by discovering GPU dies the same way as CPU dies
in the AMD NB code. But do a "node id" fixup in AMD64 EDAC where it's
needed.

The GPU data fabrics provide a register with the base AMD Node ID for
their local "type", i.e. GPU data fabric. This value is the same for all
fabrics of the same type in a system.

Read and cache the base AMD Node ID from one of the GPU devices during
module initialization. Use this to fixup the "node id" when reporting
memory errors at runtime.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Co-developed-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/edac/amd64_edac.c | 76 +++++++++++++++++++++++++++++++++++++++
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 77 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 28155b01f144..ef3e50f4d66a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -975,6 +975,74 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 	return csrow;
 }
 
+/*
+ * See AMD PPR DF::LclNodeTypeMap
+ *
+ * This register gives information for nodes of the same type within a system.
+ *
+ * Reading this register from a GPU node will tell how many GPU nodes are in the
+ * system and what the lowest AMD Node ID value is for the GPU nodes. Use this
+ * info to fixup the Linux logical "Node ID" value set in the AMD NB code and EDAC.
+ */
+struct local_node_map {
+	u16 node_count;
+	u16 base_node_id;
+} gpu_node_map;
+
+#define PCI_DEVICE_ID_AMD_MI200_DF_F1		0x14d1
+#define REG_LOCAL_NODE_TYPE_MAP			0x144
+
+/* Local Node Type Map (LNTM) fields */
+#define LNTM_NODE_COUNT				GENMASK(27, 16)
+#define LNTM_BASE_NODE_ID			GENMASK(11, 0)
+
+static int gpu_get_node_map(void)
+{
+	struct pci_dev *pdev;
+	int ret;
+	u32 tmp;
+
+	/*
+	 * Node ID 0 is reserved for CPUs.
+	 * Therefore, a non-zero Node ID means we've already cached the values.
+	 */
+	if (gpu_node_map.base_node_id)
+		return 0;
+
+	pdev = pci_get_device(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F1, NULL);
+	if (!pdev) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = pci_read_config_dword(pdev, REG_LOCAL_NODE_TYPE_MAP, &tmp);
+	if (ret)
+		goto out;
+
+	gpu_node_map.node_count = FIELD_GET(LNTM_NODE_COUNT, tmp);
+	gpu_node_map.base_node_id = FIELD_GET(LNTM_BASE_NODE_ID, tmp);
+
+out:
+	pci_dev_put(pdev);
+	return ret;
+}
+
+static int fixup_node_id(int node_id, struct mce *m)
+{
+	/* MCA_IPID[InstanceIdHi] give the AMD Node ID for the bank. */
+	u8 nid = (m->ipid >> 44) & 0xF;
+
+	if (smca_get_bank_type(m->extcpu, m->bank) != SMCA_UMC_V2)
+		return node_id;
+
+	/* Nodes below the GPU base node are CPU nodes and don't need a fixup. */
+	if (nid < gpu_node_map.base_node_id)
+		return node_id;
+
+	/* Convert the hardware-provided AMD Node ID to a Linux logical one. */
+	return nid - gpu_node_map.base_node_id + 1;
+}
+
 /* Protect the PCI config register pairs used for DF indirect access. */
 static DEFINE_MUTEX(df_indirect_mutex);
 
@@ -3001,6 +3069,8 @@ static void decode_umc_error(int node_id, struct mce *m)
 	struct err_info err;
 	u64 sys_addr;
 
+	node_id = fixup_node_id(node_id, m);
+
 	mci = edac_mc_find(node_id);
 	if (!mci)
 		return;
@@ -3888,6 +3958,12 @@ static void gpu_prep_chip_selects(struct amd64_pvt *pvt)
 
 static int gpu_hw_info_get(struct amd64_pvt *pvt)
 {
+	int ret;
+
+	ret = gpu_get_node_map();
+	if (ret)
+		return ret;
+
 	pvt->umc = kcalloc(pvt->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
 	if (!pvt->umc)
 		return -ENOMEM;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index e84fe0d4120a..a9d62907a7a0 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/mmzone.h>
 #include <linux/edac.h>
+#include <linux/bitfield.h>
 #include <asm/cpu_device_id.h>
 #include <asm/msr.h>
 #include "edac_module.h"
-- 
2.25.1

