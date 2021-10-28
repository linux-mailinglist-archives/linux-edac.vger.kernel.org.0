Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C9743E7D5
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 20:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhJ1SCP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:02:15 -0400
Received: from mail-mw2nam12on2042.outbound.protection.outlook.com ([40.107.244.42]:22775
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231551AbhJ1SBK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxoyh57A1QcItga9GyicuAHTi3PwrrXl87p6Hv08l5QhcTNV+V+vgzKNYK3P/aIuKWNFKEGGnJN1PCykLbBDaNCXJ7RwcvnP4hcTJjETsEMDKO2/GHoBz6mtdCf8zn0b+mIwv8CwpAdOzBN+g/aktkyqYVMVVZ2xh/teyYEYoZzrcZbCtlwt6BMWUFXqgvt4A6jWOafvyztSoaO0MU8L8KBOnaOqD60f2XbGSJfwtBilT4yFvtoqI1Tg56spheZ/1O8j78g2VH19eQNGUw/V2brH1Bg5Yk1qTEZf6F92b4BDbdDSxB53/kN/M08My884pJNuYnvRUblzj+5ews/3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLHzpgXaf1EM4YmD9kDzQYMuyjFqx+9BgNelvHzH01w=;
 b=k/gq4NIjxfuuO5wjMnPu1YThAsrJ9BfLJ0AGStfzLnvBe+x+f00KE114JYYkNz9n9F0wF9/ilBvfH0Dzwt2b4kEweeJ0Un7r+GRdMa2dCuc1nPe+5KlGReT8Gcl7TDcgIU69qWTUEZlyFF0qR4hVSIBTvlH573WDGeuS2cXMbPzABmvI3fGRGoVLkNgM8j8qEL/lmg6439iqxCy6k33WOxOPgHag7KY9PY0bwj+Gob+O73Rexd5zQcjSB/Jbauu5e5X9a79v0KneY0hAnnMw7kgXR/ZhYx3Ux2MHzY6YjHGMzkdeE2qqjytNBYhj17abjbUeWqUqtPok/2P8AAi4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLHzpgXaf1EM4YmD9kDzQYMuyjFqx+9BgNelvHzH01w=;
 b=J0qg9Go4x+brkDFDPvkIkjTLFMpgxcKw3rtphS6b9eoeAli1FOWTIlr1W1L0T4kqzsc9yfqJI9z/i4LIYKrh80yuSMVMY5N9RnagwuRPWd/h50DkTdkLXQmExXVqhVMs13ENw2yMaHBCAG9PDtOj7+5uc1u6DlwpZfe7B3okfy4=
Received: from MW2PR16CA0058.namprd16.prod.outlook.com (2603:10b6:907:1::35)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 17:58:42 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::dc) by MW2PR16CA0058.outlook.office365.com
 (2603:10b6:907:1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:41 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:40 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 27/33] EDAC/amd64: Match hash function to reference code
Date:   Thu, 28 Oct 2021 17:57:22 +0000
Message-ID: <20211028175728.121452-28-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028175728.121452-1-yazen.ghannam@amd.com>
References: <20211028175728.121452-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 131c8156-1806-4212-c934-08d99a3c93ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41408A0EA03323AC17BC4197F8869@DM6PR12MB4140.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQhr92PPLc/4K7+s+ag4ZED8J0lYP5Lz3uYv10ziXXErpXQ82L3FCJ695amKcJj52WXftGRxu+m7pdmBe/buktehTrFc7rruSp17d/2xxf56mKRVg/Xk1duTVHGPcyROyiEbFSrkiwdXvXZhq05RtkIlM0y3RYBjue1+L4x7WBMft67pxR5lyfNShtcfuJhDsUBCL1EaIRi3TiNJ3xcvbiAvbw63W9vpmtEmT2mA1bBU4s6yYtwruBbv9zdaEW9MkOIacyoXjAv3N4OTZglBtxtMfNHXLpNBKKYNwWhpEUNxIfjnMCImswqqLziEsJBhnnClTNSeql6jBFBJVERVRveUR2JWgTc6PdN/XH6MhqUHJFQuICIkwcP3y2Yg5GkDW9rPiRP7dOep5xpzf/JeuSURdJ2b8xymnAKkskAi1I1lELiDsMrgXymmzKpiQ/+a0t9NhAsMdbMqz2WHR/gmjhm2BqWOb2Gzb5shjy6pujw6A+WRtUOA9QpUo/PqZe4tdARBEH8prCHGszgbS/xUHjh+XzUzESsoZ+5K0THDRdR7RmasOriK/7nSvIy0NKV9VETDGMqdjh9qES8SkFfWHSAEvgOPO8eQeaOfClHmBFLuqQrt0PHSU0Q1qFgWkoV5GZHH3TAv7dkncZslmyYTERa2Hs0/x4Fu7qIzKIkIwkbmpP+jOIQCfg1sDwpWBqPMEWbrfLW7lNyGPRYgVNQGPd6xbM3VdMkMaLazGtepU/wLqH0av0NFt9dMgoBj40GaAMbQaOBcU8TFOOZNqplifZtCcXRaRvt6eS+epa3PnGRwoyLkPx8WSp6xg4C+/nFa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(4326008)(508600001)(86362001)(2906002)(356005)(336012)(81166007)(426003)(2616005)(6666004)(44832011)(186003)(16526019)(36860700001)(36756003)(47076005)(70586007)(6916009)(316002)(82310400003)(8676002)(70206006)(26005)(8936002)(4744005)(54906003)(83380400001)(7696005)(5660300002)(966005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:41.6574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 131c8156-1806-4212-c934-08d99a3c93ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The reference code for DF2 hashing was changed to XOR the interleave
address bit rather than the CS ID. Match that here.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-29-yazen.ghannam@amd.com

v2->v3:
* Was patch 28 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9c74813c4128..c6fd813f596f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1133,7 +1133,7 @@ static int dehash_addr_df2(struct addr_ctx *ctx)
 			(ctx->ret_addr >> 18) ^
 			(ctx->ret_addr >> 21) ^
 			(ctx->ret_addr >> 30) ^
-			ctx->cs_id;
+			(ctx->ret_addr >> ctx->intlv_addr_bit);
 
 	hashed_bit &= BIT(0);
 
-- 
2.25.1

