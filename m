Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEA942E1A7
	for <lists+linux-edac@lfdr.de>; Thu, 14 Oct 2021 20:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhJNSxj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Oct 2021 14:53:39 -0400
Received: from mail-dm3nam07on2089.outbound.protection.outlook.com ([40.107.95.89]:52289
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232090AbhJNSxf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Oct 2021 14:53:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLqf//E5G8nJytEnffbZUmwfStoI1Hjqgc1R5belbHKg3liVyPvcWwAXNu1s34M5Fh67Iz3g7Dir5zfNs+ROAl0y+lFRgox7wJK3j1x3Dim3G638pa7DokOE5Tq32szTpbnOcn0+Js8wsgxqVhG988s9fDVFXsrpiaB4fycUmqwIfIIGD0i6fEq8687ldte1uJmO5FrpPhWTeE3PJDnutaBcfzeiWcu+5tLdhiOJO5V0yX10729ABXe1szEs4nlowQ2snrqr9+jOn1Ar8oMVsEG5Dn3enEkpTwdeYOo5QSV/u0g/zrzSL9vaoOMxNSk0HntJCUqTsZB7WNqT8+rOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMnFZhUHhQ4WkhpMBtqS1zhSnoMRiPZtaaJTHCZCOCk=;
 b=W2G0MnpuEjMU9cDaAmYlHiAp+oIQDVpKTM7SJ+Y0RL8TzwTarpHALEUhvGpMdtawXkjFecaJ3pH20wVar4u7rzubhBT/bdeJ6QpYQcNyWE64PJK6dKg+Wq7taLB5Q8p7rZobG9fivbMRppygeIBzv0KbD4hzeYjAfoJDzBMnbM3NKn/+hcx3b+F/awiuk8REGEoqKyYqswB8xXkNcLULYbsz5A5WPN2jluntx/zHkcfeKYCRTkkXqwhhw8VcYvvUeAYCz/sJmRdK2KK3/JCqpgRDdZYmeXYHEe7y8jrldSMJfeW16gLm8SADJfhC5P5UWu3Qffz4O6NmMiJBxbgnXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMnFZhUHhQ4WkhpMBtqS1zhSnoMRiPZtaaJTHCZCOCk=;
 b=n+o103FOSDfXncVcRjW2VTuwjOY1rDN6sOOmPG3iUySSBXxyEvn/QDrEY36Cuvoq8rQbDC0BHvQfRSdmoPLO6tx5/jvNTh8L7r3+1gMOxudOea4gzj9s1YfcE7j1YcPJrtmH835z/L/gMV3mOAK26QpErsIFNkK6cLyS4kG6JTc=
Received: from MWHPR17CA0056.namprd17.prod.outlook.com (2603:10b6:300:93::18)
 by BYAPR12MB2600.namprd12.prod.outlook.com (2603:10b6:a03:69::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 14 Oct
 2021 18:51:26 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::17) by MWHPR17CA0056.outlook.office365.com
 (2603:10b6:300:93::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Thu, 14 Oct 2021 18:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 18:51:25 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 13:51:21 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH v4 2/4] EDAC/mce_amd: Extract node id from MCA_IPID
Date:   Fri, 15 Oct 2021 00:20:56 +0530
Message-ID: <20211014185058.9587-3-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3a7e7a2f-38d5-4095-8f79-08d98f439fe6
X-MS-TrafficTypeDiagnostic: BYAPR12MB2600:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2600F6E6B26EDF920C3DD251E8B89@BYAPR12MB2600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnF8u5t1snVi6ydsAGq9+nQxLbG8VsfAzNA5Psxs/9Ju33RERQuSsL7zKk9TcWgsARyLOG/ue/uGnEwCMDjgdXvRC8KVIdA1xviC21AaM/WoKM8+I40SUtz4uVaQIQGEmBeHsIgdWQWkNB/i8nci8Vk7iw8FacOjkOvDOhbQs/APIaII2ywug3y4h6dJhJio0UIHpDOYiiM/A3JjYVguoWn8LEV0+rp6Zt3AYqJ+fEA/bU/TPOTqOs9z+tmiL3/hrZDRnVS/mR58ec7BvauH3C2r3JI5tgfdooZ1nxv4nSXk34pHb7eIuPPRtXfcdmExSn/hVD7xGHBQZzxNAARk55hRQLjGJJrC57zGi88Gkah5aJTA/lgIOJNoEY9c0+o/2iM34cGoixPawDyafm+gFHFSXJqMgweHN7+h6LRFQaz5TfgewL1gsTi6wb5MmMG6jQYxsJBNCM/QEIP0sBKuv1gM1seI6kw+RyWWv59ReXfecNMpLr96iZTtHPiWpOnra2d+gedTO0TJ9B5NDki7sp1hEuztFXSG57vw3xmvFcnTW0zEoY+rnbJxB5gX7j1cIWWtFsCuLW7t4xbePmg89LlZni5AhKbGHgDcgAeHJEu+9v400p1bue697WFsHaB/BcQoUGPSaeNtA51xLcgKcrdyn93L6JaTo2ABFBGFw8y3Jj2gRJjUnbvqInmWkJY3V242N2JGHghry3zb31RGjtv9eef6NHMMoidnn+WGs3dlNbsr7hDQx6klC1S2uRWwhjmyq+Gw09sjor6C+gedRbZiZHi93Q0UWht3p9Yc5sAWvJgXQZQ4IFEqfrS7AsT7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(47076005)(70206006)(5660300002)(7696005)(110136005)(966005)(4326008)(70586007)(36756003)(36860700001)(2906002)(316002)(508600001)(2616005)(81166007)(26005)(54906003)(16526019)(82310400003)(6666004)(1076003)(186003)(426003)(8676002)(336012)(8936002)(83380400001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 18:51:25.6274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7e7a2f-38d5-4095-8f79-08d98f439fe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2600
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

