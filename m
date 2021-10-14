Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F1442E1B7
	for <lists+linux-edac@lfdr.de>; Thu, 14 Oct 2021 20:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhJNS5A (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Oct 2021 14:57:00 -0400
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:2214
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232267AbhJNS4z (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Oct 2021 14:56:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjJNxNErOgf8Kryj34bSEwANnjnXMQDtmuOT0Uv8eMiMXsazBA9rTjAJ+wvHKaMD9r7w8busKnjJmnbamflX4krUDpmL+NcPWPYnXsiWH/Rsl17PC+Ml58qYVJDA51G4ta88WDNykpVWEWH2DTiQy6eQ/87O2XQg+FHoWnVZDnNe0Jf7ZB1I1UI/s1aKNVBg+j2qsMyxj6EgkPWVjf5O4s1MuTvvn+lWFv8s2ZP+2hCNlVK5C7sOoX6eS+NJgIzSXo6x2qZWJGG0L5qpDVc17OzJnSfCTqCpaNoqQTVG/fYCfrFAfdJxCa1OKgdchZSNwWF8sT4FnUhulSy3NSuSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMnFZhUHhQ4WkhpMBtqS1zhSnoMRiPZtaaJTHCZCOCk=;
 b=W7kQ2gJxPCrscht4ORFupd2McbzRcoGHyhuSZOvLkULyDsANSvtxdJySA8VHnQtfpzEFW9IkuLzdjy4C4caukE60EW1WgcLxbjRN+PGN7dHnEalOo1vmZsfRAUjFutlvONs9kH4334tcWWS4XdGQDZOAy4Q9JHSKPI9LuYr5sPZLMVHBZYBx/dZKwaxJpB0LmgEUsXGh9Yo0gp8NBrN6F3ia/z9tBTqdAfRoVoeJ0m/WZ+BhsB7hrJ0Yzx3ukOdIYmlLhvWFqlMF7eajUbKOCnZW0IWEAjfC1dJSDmP/rm35RW+FqC63Tk4wdJL65VuQmZf9trJIisu/lTJVv+qoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMnFZhUHhQ4WkhpMBtqS1zhSnoMRiPZtaaJTHCZCOCk=;
 b=qMJXpx1iv8wUCNam/Ok4LBYNVZZXOpeUmqYrffPe2A+ucR/bALFyn9AGqZ/m9ykfB9pWJMVvLtiYLfga94GAUBsL8/gTCRrvT0iT64aR2bcwC0o76Wexoad0QWXeO2k9hefdiFU6w51NJdTpWoZ7jTWIkvQ716P09+jcYK1C8V4=
Received: from MW4PR03CA0071.namprd03.prod.outlook.com (2603:10b6:303:b6::16)
 by DM6PR12MB3738.namprd12.prod.outlook.com (2603:10b6:5:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Thu, 14 Oct
 2021 18:54:48 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::b8) by MW4PR03CA0071.outlook.office365.com
 (2603:10b6:303:b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Thu, 14 Oct 2021 18:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 18:54:48 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 13:54:44 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH v4 2/4] EDAC/mce_amd: Extract node id from MCA_IPID
Date:   Fri, 15 Oct 2021 00:23:58 +0530
Message-ID: <20211014185400.10451-3-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 721b5775-396b-424a-b716-08d98f4418bd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3738:
X-Microsoft-Antispam-PRVS: <DM6PR12MB373868D34B8EE418CC3AC323E8B89@DM6PR12MB3738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WptfF6dHcOHuD3w3fIMpd1PeTh0svXkK7BmUlD1LxmEdkv/2dBdJW2Rni34PAEfuUFNWcqY3gjlq6DJLUPosovkNR0pH1fRkSIoTqnqyH3zZNoHoRnugbJOTc0YnKjjS/qHQyA+8p/xxuMHMmX6bYQA/+A3QenqH03YT3Iz5Zav6G5NomMLO8icDn2zXyFrfaP9fDkv+dCEePC6BPJtrJ9VQSDhbXrrgraMNgXRbZugqeicx5nFOae0H/46JLDZoHVwCQtLae3tsppFh8vRxZ0U9fw7AFn52T0UKabX1rBpfACKWIXj3xdjvmGJ2wM803GmUvlcv6kut2ugSezRhuTT9uMVZbY9HtS+LgH1ZoK1VY4Xmq4GPTJNsnVQhlFwD34Xt82Z28JBZ1hH7/OhrUTYOJXcV94QBP+KCA0kQpMMbRo2+2kKs0/6h/jpnTA6nrFL13BeRVH+rG868GZyDqCGSym0J9cvD1raVV41gFpP0xVFMnrWuF+RyRwRiwo/O51KC6fIINOjKyo7cR9RwSHigUC4800l15elI+ukMIDnfzMYaiBvxWI2uhfyqmQurjrd0HiO0qVq3sjpJL4FdhvDkUqooxmbBamBsIsPKrmDTuIFV2k/sOA7Wi6fkGz93baBXewVmPguxSY6/WSywTTvkk3h/W13A8RNhG6MlR65p7n6qDd+0vEsBKoq781Mno/iINNJ/5JKF5icikfPsp2OXMr8lPJ70REOwK9nQf/6OsmgyYQ3FwK6b5dC+WjF9ROUcHwUuAiG5tW5drQziunHUBevIiCa7kh1jZSp/VHw9ZZq/QjwmVsgLeRCPHHTg
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(356005)(47076005)(81166007)(54906003)(2616005)(83380400001)(1076003)(316002)(16526019)(26005)(4326008)(5660300002)(6666004)(966005)(110136005)(70206006)(186003)(508600001)(336012)(70586007)(426003)(8676002)(7696005)(8936002)(36756003)(36860700001)(2906002)(82310400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 18:54:48.3821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721b5775-396b-424a-b716-08d98f4418bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3738
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On SMCA banks of the GPU nodes, the node id information is
available in register MCA_IPID[47:44](InstanceIdHi).

Convert the hardware node ID to a value used by Linux
where GPU nodes are sequencially after the CPU nodes.

Co-developed-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Link: https://lkml.kernel.org/r/20210823185437.94417-3-nchatrad@amd.com
---
Changes since v3:
1. Use APIs from amd_nb to identify the gpu_node_start_id and cpu_node_count.
   Which is required to map the hardware node id to node id enumerated by Linux.

Changes since v2:
1. Modified subject and commit message
2. Added Reviewed by Yazen Ghannam

Changes since v1:
1. Modified the commit message
2. rearranged the conditions before calling decode_dram_ecc()

 drivers/edac/mce_amd.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 67dbf4c31271..af6caa76adc7 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include <asm/amd_nb.h>
 #include <asm/cpu.h>
 
 #include "mce_amd.h"
@@ -1072,8 +1073,27 @@ static void decode_smca_error(struct mce *m)
 	if (xec < smca_mce_descs[bank_type].num_descs)
 		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
 
-	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
-		decode_dram_ecc(topology_die_id(m->extcpu), m);
+	if (xec == 0 && decode_dram_ecc) {
+		int node_id = 0;
+
+		if (bank_type == SMCA_UMC) {
+			node_id = topology_die_id(m->extcpu);
+		} else if (bank_type == SMCA_UMC_V2) {
+			/*
+			 * SMCA_UMC_V2 exists on GPU nodes, extract the node id
+			 * from register MCA_IPID[47:44](InstanceIdHi).
+			 * The InstanceIdHi field represents the instance ID of the GPU.
+			 * Which needs to be mapped to a value used by Linux,
+			 * where GPU nodes are simply numerically after the CPU nodes.
+			 */
+			node_id = ((m->ipid >> 44) & 0xF) -
+				   amd_gpu_node_start_id() + amd_cpu_node_count();
+		} else {
+			return;
+		}
+
+		decode_dram_ecc(node_id, m);
+	}
 }
 
 static inline void amd_decode_err_code(u16 ec)
-- 
2.25.1

