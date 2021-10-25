Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3231D43994B
	for <lists+linux-edac@lfdr.de>; Mon, 25 Oct 2021 16:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhJYOyD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Oct 2021 10:54:03 -0400
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com ([40.107.223.69]:39617
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233586AbhJYOx5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 25 Oct 2021 10:53:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9JVn8QunbqTrBF9qlYfhjWFEVS7c4b0nUPcZue32qeoOBNSXEbQr7yZljh5ZhD+RAkNcjCPfwtnzCN3Rg4aJnaLw1uqyHa+iI9j6MuLJCo8iUsnSKGP/dAmFNhfhzAmNRCFzCu70JVArnHEIVf68GcRHcBLWxhZDtoMC6K6nIWI5bUhANZpWEHvfT1tMCXV1FgKPIIMzeXvStzLcaLm9zpYV3LY0owwbbK1iWZiHoKv8XzoZlW0oiUiFwd4afu06b3iDF0/onYfY5lwAEJFC9hQdToA6Vcc/QGorUOI8NcWdaAEv4+IUNAHOv2oD+ICxYzEf1QSYc9JveJM6NjuTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+blj1t7a5shRe+d53g/Rx2t+hUA6Myi82y9QkqFBbsw=;
 b=X4JZOCTA7n/1kpzH/7O51HT0qykklLYx0hSImTGP6L/iC2EZrjabnD+qUBJ6KLsI2DpU4FAr1Jc6aWn1Hujc3em/19/p+iXw/AmhpdZdSirOB0p6SeL0oO0s4ZHC01/32mH/ZkF41LHRAtKlqyUaTE2dQc97IpwFke7ln3R+pWw0t1Hx8RwOrHBDUPxfIBTcdLO4S15G66uIadDZwrJEoDx7eeP14nLvrCRUBtNRPraPez2wv/NFRmloS/OxuzfhAUFbA07VDMgUOxdu2BMAYS5zGj3les3zTz4Lm3zxi51ouRgKspo6dNvdGeKcQWRMeeYKNDxy7v3EQzWA9FWxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+blj1t7a5shRe+d53g/Rx2t+hUA6Myi82y9QkqFBbsw=;
 b=ocZzIQuRGvyjnZgoLml93xdxWE9/827jTpENuU949BVLtv8dWEum+FAPSRNnQfQ82T8g/69i4p2O9r/p6gOLUiZS21R3soijoUetp+3zf6Mxnv/0YAJLfaTKsLfqmvysgAgmnKgnLanOR8ynodAK4I9zz2esIBvnw5DBYpu2QII=
Received: from MW2PR16CA0071.namprd16.prod.outlook.com (2603:10b6:907:1::48)
 by MN2PR12MB2910.namprd12.prod.outlook.com (2603:10b6:208:af::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 14:51:33 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::9a) by MW2PR16CA0071.outlook.office365.com
 (2603:10b6:907:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend
 Transport; Mon, 25 Oct 2021 14:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 14:51:33 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 09:51:02 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH v5 2/5] EDAC/mce_amd: Extract node id from MCA_IPID
Date:   Mon, 25 Oct 2021 20:20:15 +0530
Message-ID: <20211025145018.29985-3-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025145018.29985-1-nchatrad@amd.com>
References: <20211025145018.29985-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b10a28df-f1a9-4e4a-f6d0-08d997c6efd2
X-MS-TrafficTypeDiagnostic: MN2PR12MB2910:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2910940EDFC2EECD5A73DF8AE8839@MN2PR12MB2910.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ylJ4X244M3rSv9Fv98do6MPDZAeIfNWCBK/h0azJo+xZaKysbj4V5pW5EVPAaoMD284POdAPfDePH9cQSGth6YVJY5bawjOZB/fGp4D+n3ch1MVKFLk3HLfx4qF+DmWjTJA0ZJV0Y8VfPy/00yvtQZK+oacjAkhl4fV/2phPrMyNo+ulC1rvTMT6X9EAHrBDTHE9haYl+uUJNSP0g9Nn05Sc4zqNHZ8HwuIqll+C0RddQrGbnBfB7dSE9E5BQ6LblUh/Bspjw3fpmagHOyvYgSPS8T7iDXOPXvdIkp0ukBO+bNLOGQgc3eSgtMOsnR/0sgADfoLSyI8xmgPtwOkVzg9GoWwFJn3li7U0u8ffRs7G5+puqrSVTt2e/0LKMpOeAmn91J4g+enw4WfkHGPSmes99naumWkqgzX4A6Qn6f6LSRCXs9F5mQ17aJAk7vBBC3/EbcgnD20A9l/7lQK5WWEf8Bbqg9qAib/beImig7qcbN0TkcLY6bpO6BV14Ow75hqw9DQ26qxL64u8uMZtzTfGJEr1GoAQuvsdjL6awMr+yHOSJz0KGhDAA9yM5u+I2hrBoDaynUAoiTj2ypB5OCqEvGR+ZHYMP1Mcci+32yJkON/vMMUOilPQN4q3j1b627aZqIOjtSPzeqyCtaUAZ/6OcNG+Y27NhRzhYHq2aso69vY4alcSycyS+Dk7Ckczgwfc4afUG4gylKVjMMmUblyEX/nbf6PqpVmhZHjBFv2y9nip4U8SX8kzld/KT/Fl9skulOjKzxY+0o22wsElf60GQiT9+uQx5QkccKHKMbWQMtnwMxCjClD9sa/4rrW
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(4326008)(2906002)(316002)(356005)(36860700001)(2616005)(1076003)(426003)(508600001)(82310400003)(336012)(966005)(6666004)(54906003)(83380400001)(36756003)(47076005)(8936002)(70586007)(70206006)(110136005)(81166007)(5660300002)(7696005)(186003)(16526019)(26005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 14:51:33.0176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b10a28df-f1a9-4e4a-f6d0-08d997c6efd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2910
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

