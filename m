Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C3A43E183
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 15:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhJ1NEK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 09:04:10 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:46560
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230299AbhJ1NEK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 09:04:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVFKvij8wNGcFoUU2W/2t4/8qn70UjAG9EFlloqE3ySyZ9IGn6vFxDZn64GX50vU/echA8RoXUQ+x+GHmb2zkkuMHzNw+thb4D/hElkNWHcRos8HOlzWkkJPWbPrN3jwH2gaxrwxkSjVQ1mkbzcJnEan+BewS/K2F3ZBCxOocD4yijtNbRw0ENv3qxgbz5a7/OE9JynxQunY7tDArROTOrBcZsIQMZcv5ezsu/H57s/oi2pdoL4KT2lYJLGnYRFMqjNOzPvKEbdDNG8B3NJ470L9uSeZCa8T/d+O1lcAutJ9QAFc7U8WX/Ukra6SSSWYWVDdz+NgCi58FratHSbe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxOxDP7jmuCpGXFCsk9UxCWU0QOzRo74wMFv+7Oxdl8=;
 b=JEddxBbLeI9sC+vsApQZhin//9TBwiczlgxny+paQGj7/UwGzIYxx+XwPzskft+iP3kTE77atG9JnLQhxWEFMCqeEh26Rag9KVWkzTdyZtPidsa9tzJKHO4oiwyeTYfTxqJ8adwvWktNHK+wMNwNhCjtRQYDfm8vCPt4RixGXuSl33tJzh+itxaJR5guyu26zuiNwkuugrV/GGpA+AN2YWBRqF4sZTwvZxQf7GYrBxoyatu2i2KwedDZB1ZWq6/4yqBsh5eJaZN7cw1y5RjGtyUNRvozWfVf5cFK4A+JfwEbtwEEKR3A/NG++c1QjMiqbnxTz5lpD+cgr8/MQYfjrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxOxDP7jmuCpGXFCsk9UxCWU0QOzRo74wMFv+7Oxdl8=;
 b=RdyvN0fseC4VLhYIGDINRo8P7HUy0p0hlohj0fRL+HbfyrpCk+nJdDYtRnTFm6xdrASenA277hp32RYfiKSJuXvAWgM7YX3cTAbqbh75cZwgyV/+nSWzrRzQl8cIRIK9D4svINjb1T5K6xk2rBpJDCLU+OvR8W4ySn0ENTGwooA=
Received: from DM3PR03CA0009.namprd03.prod.outlook.com (2603:10b6:0:50::19) by
 BYAPR12MB3206.namprd12.prod.outlook.com (2603:10b6:a03:130::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 13:01:40 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::d6) by DM3PR03CA0009.outlook.office365.com
 (2603:10b6:0:50::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 13:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 13:01:39 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 08:01:36 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH v6 2/5] EDAC/mce_amd: Extract node id from MCA_IPID
Date:   Thu, 28 Oct 2021 18:31:03 +0530
Message-ID: <20211028130106.15701-3-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 983ea13c-97e6-4cb3-eaed-08d99a131538
X-MS-TrafficTypeDiagnostic: BYAPR12MB3206:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3206C715DB4B69D403166F16E8869@BYAPR12MB3206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+D6Gtwp9nXzV5aGpdTARxyx/7SJW+dmT+mPy+c8xlcCu3LqoRR2ReRJy61cDzkRQpx7KRoGCd8mWg77lauG4LlFEycywImPjgk7glPrUyAvYjD+7TpWtp+n+fqrn3TY+EhIeIEzDnf8BulYgQ3exv9XG/heW/4xutYo7rVi3omw0cJ7bYRgotI/E52ow79HQe4/1qkWvn6qQYhwkVKBggK4a/nLbh7FOvDmTDeFzXJwyrm+RlsjdaDUwiatut3etqlnoMrzE08Advd86BwTjweu6FLF60a8cngu6SO9f0ybjLOQlA3+J+oALWd48kZg4pcEtyPojJCU/ZRz67pxINZaOzoffzYi8x99PSLSXkWMIZx2/VR0xb1pT7o2rB49Hx2YrS7L5/lzhUQnAVAD7VnoFRVgYtzk2jjRqp2PNrzzoB9G5L8lmLXxQVRnWHlQnxrZ/zhsOnWDjWPbwCO78KqM+HWFhx1BP3tYoqFAfQ7yEIAV2gvhDOegDJRVM0lfOrQNZiPx+gR9mGs0RiZhhbaihQSXraLuhj/CochF2qcm0TuWlbGe01ODexcIaYg4XjgYXv0hXFqZlVat2JtMx0g6hp5VQ9KgrwLRuhpK/T35N9KAEihyVV+SUIxL53w/aH6Jh0byI/Pv9Kn/VvGAnPhwtEjymU26ffXhLu7W3jtoPQfCGaUD64f/rfch0DKsk2MEZEyztEXB/skvYg0zVVDRu3XvlSgw6CePoMjwgDCIYVAy2T6uKSx8krSivpOW3siEVc2Yopg3+p/H/VKTeORhbpsIGBY76gJzxAT4WyaayggvsW4RzDrZqRTbyJG2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(186003)(82310400003)(2616005)(8936002)(47076005)(316002)(8676002)(54906003)(16526019)(2906002)(508600001)(110136005)(6666004)(336012)(26005)(4326008)(426003)(70586007)(83380400001)(70206006)(81166007)(356005)(5660300002)(966005)(1076003)(7696005)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 13:01:39.9694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 983ea13c-97e6-4cb3-eaed-08d99a131538
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3206
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
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lkml.kernel.org/r/20210823185437.94417-3-nchatrad@amd.com
---
Changes since v5:
None

Changes since v4:
Add reviewed by Yazen

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

