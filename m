Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729D34A8AB5
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 18:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353136AbiBCRug (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 12:50:36 -0500
Received: from mail-bn7nam10on2062.outbound.protection.outlook.com ([40.107.92.62]:23302
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353112AbiBCRuc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZW90GFfIhkuMQNlT+xF1XZsaRjeAdvwCpUcL8143mNvq05eh0T/Gv1Rl7hiLXKr/VLutOD9yEzWiKkGp+0WLOfDQrDyq9zS/1qGXBveXSFlv09ue/ehRmAvx2FLGrtWix2dqN9eLgvrBcTsGZeaaqdlOMNSrRLpyYSYsU29NUE6vC2DpztESYzuMR9XjsHrUc2+bYJpj4rmDWf+ExMGj3A3IS7iIhbzz9VWZwWhfbgghJBESpHD6aY6vex8WlZmX1gYh0uIJnpc9StplP/0LnKTaJlMRJYtt6UfHTZobKAegI/aUOIC8NavuPDKxWMkfvcfB3ZM5olr614nq9RImJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/6n+F88rKhX1kcncnU8KQWJs3UA7c+aut25zH9c3y8=;
 b=NaBBE4F0J47AZw4gQ9fpLU/OV8X9FoYEwQ4f54XJCZbVml0gixMzblxCyVaM6qhhrK4LjhihxkiRLPXShUUEUFthCR7v6Q2Z4IQviSndhGoufLlXTmUcEhQhYh/OoIt4pAdrkTKGj9yphNFK1oAwLM1NIIXUwtr+Yb2/LUnowVEXtCG3LhBDuy4tZo3T++bJOZeYf+Gk2XBgjHJJIqD3xtigwLFazTlWbURjLkjsJb75RiquejAq5sCx6l/5CrTOHS7wLdlo88GEJ8+2ZCG/uVzcQ3C/i5oH7vtCfsuI5gF1NCAd4qfjnWtZt/HHq5UNzwVNUXAO+QOwOtBvNzQwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/6n+F88rKhX1kcncnU8KQWJs3UA7c+aut25zH9c3y8=;
 b=T1GHHsbzTClN2s8oYVyyvOTxuu9oPXshcBaF9tZVer+ztdZFWERu9pc8YPtEXR3f9E4xoAdtWRowlUU1VYtlrQ5Plj/yTz3GBIKDhHByUqyHoJVLeinhnKrfkWKy6qXTp35TZbWh6Wn1YyLS+uBQdKdnXuzmMO/IMKR+48PYkiA=
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by CH2PR12MB4808.namprd12.prod.outlook.com (2603:10b6:610:e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 17:50:30 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::a4) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 17:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:50:30 +0000
Received: from node-bp128-r03d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 11:50:27 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v7 09/12] EDAC/amd64: Add check for when to add DRAM base and hole
Date:   Thu, 3 Feb 2022 11:49:39 -0600
Message-ID: <20220203174942.31630-10-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 189b493b-fabe-4be0-ebdb-08d9e73dab9b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4808:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4808D48C57151626F64B97FCE8289@CH2PR12MB4808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2erm2kFhVBus9NxfOi36HJY3Ea2BxluSD9f/4ySRAydKczs7CuObMJEjYhJbx+sichwvlncb01y6WmKBtdZWLx2fpeApjzT80m2Ene43qyGcyTEBXGwzt/wjvNUGsy4FiFj3aXePenK63bIGEpDidD+SWuMArWkcVJBnmykolrhwTT4lgQOipQqjlUA10F4KDpwlStwxFfEhkHGpH7UVN+YbSLaRxzGsHqFe9ChOIFaKd8M+N+WwlwZvsmGyHOV87MecRvEpUn93yqwgH09eClws34eerFMITt3yekK6ZUm3DdZZvP4jKM5qnFqU/eeQ4A6DQyISEwepF6kYFSmvP3yYT2FNbQDsGE99HYTd+oTc0P+g3U6bcLILvZmaBJGTB3iKZvS1kfcxN695D71q5hT9v9PKUYNkJpDtC54i68iG7KvQ6l/8xmj/7MEkfE01TImK28sx5uMHW8rgtkyfE3ulMvDDHWqFI184kHTD72Snxu9G4LMz0BY+v1vA4+vVT98LeKxJ/skYNqjfxK/4sQ21EBzpShq8Aoa7EHBvTfI2Ak4UFsxqSZMV7AH6OVmOzZrRTCLc49ONPK3HNbRozdDzvKrrCAnIYE87jf+WguSQaZe38nOIHQNNAnEbHzxFLSanWLchgp0rzLPqTCYL4cueJJabXZww0rZguoSoNAas9GsAr2K263+jlGXemaftfQtmQIVM62OIk60icQd8CYjbT9EbQyuQ35MR788YD38ldQHc+PeeQvdMmXbp7WUeoveDDw66GRJhOMC7YKAxq07n7uo8kOa4TK1LwxwpEN0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(7696005)(356005)(6666004)(2616005)(83380400001)(47076005)(82310400004)(336012)(36756003)(426003)(508600001)(186003)(1076003)(16526019)(26005)(81166007)(54906003)(36860700001)(316002)(4326008)(70586007)(8936002)(966005)(110136005)(8676002)(70206006)(40460700003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:50:30.6060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 189b493b-fabe-4be0-ebdb-08d9e73dab9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4808
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Some DF versions and interleaving modes require the DRAM base address
and hole adjustments to be done before accounting for hashing. Others
require this to be done after.

Add a check for this behavior. Save a boolean in the ctx struct which
can be appropriately set based on DF version or interleaving mode.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
Link:
https://lkml.kernel.org/r/20211028175728.121452-32-yazen.ghannam@amd.com

v4->v7:
* Was patch 31 in v3.

v2->v3:
* New in v3.


 drivers/edac/amd64_edac.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 241419a0be93..0f35c8519555 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1112,6 +1112,7 @@ struct addr_ctx {
 	u8 intlv_num_sockets;
 	u8 cs_id;
 	u8 node_id_shift;
+	bool late_hole_remove;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 	void (*make_space_for_cs_id)(struct addr_ctx *ctx);
 	void (*insert_cs_id)(struct addr_ctx *ctx);
@@ -1676,7 +1677,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		return -EINVAL;
 	}
 
-	if (add_base_and_hole(&ctx)) {
+	if (!ctx.late_hole_remove && add_base_and_hole(&ctx)) {
 		pr_debug("Failed to add DRAM base address and hole");
 		return -EINVAL;
 	}
@@ -1686,6 +1687,11 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		return -EINVAL;
 	}
 
+	if (ctx.late_hole_remove && add_base_and_hole(&ctx)) {
+		pr_debug("Failed to add DRAM base address and hole");
+		return -EINVAL;
+	}
+
 	if (addr_over_limit(&ctx)) {
 		pr_debug("Calculated address is over limit");
 		return -EINVAL;
-- 
2.25.1

