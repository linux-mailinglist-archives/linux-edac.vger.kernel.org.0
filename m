Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E09A49ECBC
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344131AbiA0UmH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:42:07 -0500
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:34074
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344202AbiA0Ul5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5iSLRb9xHd7yl95xCrz6e6RUGSceivpyt90KfylzhcKmoVSU/148n6FJP5ex6fbdaoUZqZc6CAvT1latXJ9hguuj4s3vIO0+WAWaw90Knly5dyHjNVBck4b0ULSF3dOWMOlHXr+dEo6NAiYsWVmpKvWUlCHEnQXtfR0iY4cntIjupg9b+p8/b+PZdmcRsgR6g43+RtZrtW8yH0JiEfykznGZAbnZyA2vByDjj71pBBMNNKybzuCPCOwlp+0hK+HKeKJ8JrQV9d854Ktx2vSRzRwDrwAAp7xNwTyri1CK41rm6dkgj/YII3mr26+77IWt/Ax0VEhurdao6QFNPLP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KI6Co5wbDhFFbCxLKnRvWExh9uSAPyJGVPXo7WMf6I8=;
 b=nuXMbS1F7CbHWzggFkXKB7moFU0qLd/IeGpsDg9KxfETyyMr3s39ezKiekvLL7jMZK0A028Pnq/XnIj3x384YSs1a9B7bBqjaXnEJuWrz1rVyKW29gC9TEDWS+SWkI9x8Ix9/bx+zasTE0+Jy45sTc4UvetDNSW54yt05B8otRKWqy3NxeHvvi+V1Ni8kWC4MZHWPA5AZ0t7wtK/qWIvPLyn8MtzeMuXOtkMuxItTp8mg0HamAoLVS6hjZf0iDWKRJSwc51hGD3ydfS93fSzljWmVySfuQawIthAuIZFXGBHodbq4uJHmLUM4F2lnVXfIn/oxjWsYZ5aTb3pkh8gkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI6Co5wbDhFFbCxLKnRvWExh9uSAPyJGVPXo7WMf6I8=;
 b=l4G8CIjFrcNluQHIoxkPF7N2R/RJQB5oHk8jnoMgePD8FDgd4JgVlxCmtmyYQK15lLKwjcmrvfuvmJdvRC9fVgt3XpIt/tlO7j9ZJZ3LiXl2JDHfwKFcI2Ftik9m8XxD9JeRyzzmylABS1qG0lDdZwZPntdV6kKoodERrdXWEZ4=
Received: from MWHPR17CA0089.namprd17.prod.outlook.com (2603:10b6:300:c2::27)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 20:41:52 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::f7) by MWHPR17CA0089.outlook.office365.com
 (2603:10b6:300:c2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:51 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:46 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 22/24] EDAC/amd64: Match hash function to reference code
Date:   Thu, 27 Jan 2022 20:41:13 +0000
Message-ID: <20220127204115.384161-23-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127204115.384161-1-yazen.ghannam@amd.com>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 186d5c3f-aa1d-4abd-0199-08d9e1d572bf
X-MS-TrafficTypeDiagnostic: CH2PR12MB4040:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB404055FB94183831EB95FA78F8219@CH2PR12MB4040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUpcXRYNE2LL1RH15uRX10oAD1csYnC4CqxSbmXtuHtumaNUGLP7NhzhP+LtTh+QSuwwc7QPOHx7Xe61NJY9xYXSyeXGDnDMxqZ3O4rh1OTRZL+FlPAO7amrcvKaJKhdyhkSamBnQd72Qy1E5hR7e4Knhp4GohEVTa0RVAQTqKuELLzWWSR70CF2s28pPPHTHwskn98Jqpx7gqyz4syxsL1znhyAFf0RKhruoBB0uStCLxh2UhF9P/ImOZ8ZsW3Xq76PXN6zQ/EGofnvK7iIhhnhEz6g1p+ZUwSBcnpf0buvA/Vr3c1x0wJvR/S54gR/WkSpHhZ/N7lWG2yjQ0oQjS0UTy+tspfXEm49UpUcjCcEvldWyaBqZLlAg+3d+chgJiw0J7eZtvP0ZYGl3x2LTycpSI7vKvfrYcoNhUZx1x4CJCIPR2NIiD4136WzMd4UQwEUntjCqLBwjTq47gZUI2iSSDHfqAaNbwUsxu3RWGAbhLfJfF1t/+Ko+kL6eCtnOMqvin9G12PXiXuNozABcpHkcuX39RzqYwepoVs9J51OSDNpZ+Kp3UAcrnG4S6ZNYkLS41kV7GQGplZ+NL302WxpFkZ9/X6oc5EX1qcZHR8QgHx5cAd3cAteKBGr2ObLWFTK24+o4Jt+87bBdPdd0moUk+7X8rhnkIwC84TQNpQuz9J8RNI8CXANbMGT/RVWaSqfN9WX6LPeV2+eAIau0gCGbIqizhzNKSLH9+747mNMZ5nVlqsbVA+S2A1NcORj2TxJU/7v9r1707wlxm2LNjBMUoeRGy6LaXdG/jDZONk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(47076005)(2906002)(36860700001)(7696005)(966005)(83380400001)(82310400004)(2616005)(16526019)(1076003)(54906003)(508600001)(426003)(336012)(186003)(26005)(356005)(44832011)(86362001)(4744005)(40460700003)(8676002)(5660300002)(8936002)(4326008)(70206006)(6916009)(70586007)(316002)(81166007)(36756003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:51.7008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 186d5c3f-aa1d-4abd-0199-08d9e1d572bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The reference code for DF2 hashing was changed to XOR the interleave
address bit rather than the CS ID. Match that here.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-28-yazen.ghannam@amd.com

v3->v4:
* No change.

v2->v3:
* Was patch 28 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index e293aefd486e..601ececf5106 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1142,7 +1142,7 @@ static int dehash_addr_df2(struct addr_ctx *ctx)
 			(ctx->ret_addr >> 18) ^
 			(ctx->ret_addr >> 21) ^
 			(ctx->ret_addr >> 30) ^
-			ctx->cs_id;
+			(ctx->ret_addr >> ctx->intlv_addr_bit);
 
 	hashed_bit &= BIT(0);
 
-- 
2.25.1

