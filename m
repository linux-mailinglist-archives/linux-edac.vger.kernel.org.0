Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D03D4A8ABF
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 18:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353164AbiBCRuj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 12:50:39 -0500
Received: from mail-mw2nam08on2089.outbound.protection.outlook.com ([40.107.101.89]:4577
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353100AbiBCRua (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObHU79N4dAzeTOZ5kwDJM6vYGMBZJbMWKKz6O4CV4lVCXnY74Wxd2cEd3YcDaBID5v0dxKOyAcRNg72qaLljKvoRh4rIH4vsdgsalBjU0BlsqaeMhZv9OLvSoJgtiLNicZuyzGqF0pC4t6OGvcOfCJb5t48W0HSG7Ie9pYA4ppwGg/zqxWhGFvp8M8e06DCqCm5qnUvXti3HZJi4+LHFQ6EC6PFNPieF/2cfeTOS08Ee66Jo8G+5Ah+RmbQ3n8sU76qVVNng6bgeU/XXPvNTyUEIvq5Qmng4gwDTlz3dsO+lVYYou+hGpaz++cKfQxuZNBjOeXzW65vTNPQ+no94NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dacqSjElAAlHBGIucZMEYpHNvlXdyVmNL46AKxuFSn0=;
 b=iRfqdJl50fMK3HGoLHuvGxHEB4cKCVBqsjxZaeQRlVa6MVqPAWlEuLV/4cmZdP6cAR78ZCxiqHaSEqhYFkqyMK5X6798XQHBBW/TVNJzESVHGPr83/flp3rh6IaM2du9RkFwNu3th3eVEXlTet60FFeoK9YiATkI15kfvM7aUvQLbEWITx1DN1eqwQNbIOl8pqK+AhbNlv9Sqmh41VXJhMVymEORSulbeECkrb7wiO2mzAcF88PrbzLg8k7UPwAlllM06JNBjCSevG8ffHlPcg0ug4Sjgv3PjoZOu0eD64LXleWt4BRgj2NWsPAlbwUi6DvHpSxY14Fggc7jm+iKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dacqSjElAAlHBGIucZMEYpHNvlXdyVmNL46AKxuFSn0=;
 b=IbySyt4a1LakUry54vof43pmNGt3MLhxvoJ8qZcFZDxTl9ng1RukXMFrCB2jwjmST5dau0PAFjHSjXirk3UdS5tWj84H7jifPFfUDWE2a3+VkDenWe/mveKQ5P53eV75itNneLQGyBrob+v7odfm6m31qpQKi4ApFbQkjtEzBCU=
Received: from MW4PR02CA0022.namprd02.prod.outlook.com (2603:10b6:303:16d::15)
 by MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 17:50:28 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::6) by MW4PR02CA0022.outlook.office365.com
 (2603:10b6:303:16d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 17:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:50:28 +0000
Received: from node-bp128-r03d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 11:50:24 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH v7 03/12] EDAC/mce_amd: Extract node id from MCA_IPID
Date:   Thu, 3 Feb 2022 11:49:33 -0600
Message-ID: <20220203174942.31630-4-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ba715e63-87dd-487c-9c0c-08d9e73daa52
X-MS-TrafficTypeDiagnostic: MW3PR12MB4554:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB45543D6975B6AD39BEA23675E8289@MW3PR12MB4554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nzu4RkH5goZzEuB4Ag8KcnMBuwfZ04MYuVLcN++dbNdoMex6QXA69atfYrM6DbZ/zItzbMAyanzpZnQW8P+Pcw+mBCBOneCsTSXEJBRpYtZHfmup9iAD3YjYjZIMrEZ1tBQtqtYRQ4pdZkkY6jQM+ETPbkkMi/zlK96Rk7E7F3bn87PnpewutGZGFZpwDNZXCySzb/0Cz3MyFpcWOWxf86UAI0B914tnR5Z9vWo1aFW/JHj+Y5ymtledfjx167nI23t4MAbZjnxekii1ePc64R0FSrq1RvO3jGj5iRKUa5JyUGsvOkwBE4oFF+w26Q35Ns8D1z1hS+duA20K4ascQWN8fMo/0DBTCbC63bxYKmDbc190nwkZyPexWsDxEuYVB7dyxyk0fvDhS1n5ROPNRX25Mapj6mCCwkoDLaNA2s7Pm7vLZjV/h4lSjHnC2sAebMP8G4Mv92xm3uRDMidoXaBWOUPnJUf6C2H2BMpM5vhLBkzou+HQWJ9x4L2rQRafqBfduBwy28qy3tpghL5UJg2kGGrXvwpDYtc85Zmco+mpkivzLYNVvjCbRbdQmNolXQ0ae+y2SNv0Q+WRIAPtiA2/QeXnncya/3ZF0K6FQoNYN49sFYxCtEli3wSo4X46RgxdS+TaOFU0B7R70IdxjNGMDHHlsR2uvGpKEEax9yfyNPAMqfxFIGaHb0rQ/mQwhEunajxUrZvKv5gaq+pxwcfJQ8fAshKcLe1bcGSEurtGsuUvV/fvqdDlEshYKHVBflY+7ML6ho0uFWoqqk4E5xgCqf/JhHMXpojntbOKvAQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(426003)(6666004)(8936002)(70206006)(8676002)(336012)(5660300002)(70586007)(4326008)(16526019)(26005)(966005)(1076003)(7696005)(508600001)(83380400001)(186003)(82310400004)(2906002)(36860700001)(81166007)(356005)(2616005)(316002)(47076005)(110136005)(54906003)(40460700003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:50:28.4322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba715e63-87dd-487c-9c0c-08d9e73daa52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4554
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On SMCA banks of the GPU nodes, the node id information is
available in register MCA_IPID[47:44](InstanceIdHi).

Convert the hardware node ID to a value used by Linux
where GPU nodes are sequentially after the CPU nodes.

Co-developed-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
Link:
https://lkml.kernel.org/r/20211028130106.15701-3-nchatrad@amd.com

v6->v7
* None

v5->v6:
* Called amd_get_gpu_node_id function to get node_id

v4->v5:
* None

v3->v4:
* Add reviewed by Yazen

v2->v3:
* Use APIs from amd_nb to identify the gpu_node_start_id and cpu_node_count.
  Which is required to map the hardware node id to node id enumerated by Linux.

v1->v2:
* Modified subject and commit message
* Added Reviewed by Yazen Ghannam

v0->v1:
* Modified the commit message
* Rearranged the conditions before calling decode_dram_ecc()


 drivers/edac/mce_amd.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index cc5c63feb26a..865a925ccef0 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include <asm/amd_nb.h>
 #include <asm/cpu.h>
 
 #include "mce_amd.h"
@@ -1186,8 +1187,26 @@ static void decode_smca_error(struct mce *m)
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
+			node_id = amd_get_gpu_node_system_id(m->ipid);
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

