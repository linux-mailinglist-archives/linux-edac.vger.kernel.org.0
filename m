Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20949ECA9
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344118AbiA0Uly (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:54 -0500
Received: from mail-sn1anam02on2055.outbound.protection.outlook.com ([40.107.96.55]:12311
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344143AbiA0Ulr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUZr6HaR23JsDx3WWD16RPLmrXseoyLBkoh8ZE1jzJztmFI8k2nwIpewfvlxU0oPbGwTJdiwospFxw5tTXYBam8jCZH4P9G8vTWF2KfwwFlM667QdN4o0IgL62E0M5wh7AQGiqCtTtXJ4V0qtry6VwMVMHURse6uG10J3HLKabB511MnTew0i97PWV0NlHqGilaPUwmeUzp/btetmI0KrYHIqtMFG1XdPJtbGfaeuLsEwmgjRSnpl6UNmu1goJIS5wgfwPaiJr1Ssb67fPgYmw17UV5FQ/VnDlwtj057ctz+jUH/b68whQwFhywU+3X3/WuRELBmRiDo/ZYzXTeWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWPLQYKGGDXgy6/QO2OZP7uX/u1b7OKhAksZpE1GT+E=;
 b=Thz17q5I/3pn1N7/pqj4A0pOcpiCInhheRbX18u+L0yQ1iyiMPUdVuM6VRHCD0HOnqp7aTX4MokBiyIhWbAQMQBxlxdKd/DdVg4F+grFFWhXg6pHoTVB/oeMHyxM7wzl3ftZnMK+XTUukmSKizFyYsC5HZ1YRV2K2Jpjoz5YRDSOtzbBvQXBUKNv2iWxIPwj0uADzfxCS2eiG2KkVgfyVihpMMN7+kXmzmZw0xSUVgbeprqWI9OfXca9HHhzd0GZ6PeZIBRmoga0eiEDUimqnrbfC7YA7rU9xl/NZxYWm8jeX/zjDamvHXAR/nQ7DJgEUqwpkwJd4EmevaAl5Fb87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWPLQYKGGDXgy6/QO2OZP7uX/u1b7OKhAksZpE1GT+E=;
 b=RUVdCBbAq2E1bQMqqmvmzS0c5flaDLSDL5xMRx10Wbopj9BK5MKG65vv2BvMxVdYikWQkBUFRwjfEuZYKHLB8n9ZyW3SRjugIWsUvbsR9PhxbOgOIPQSm9ndqyOuLoYJ7tLNHfXixopoAaTLEIqnFFUch/6nGEj9bJBP3npgVXg=
Received: from MW4P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::16)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 20:41:44 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::36) by MW4P221CA0011.outlook.office365.com
 (2603:10b6:303:8b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:44 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:40 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 08/24] EDAC/amd64: Define function to check DRAM limit address
Date:   Thu, 27 Jan 2022 20:40:59 +0000
Message-ID: <20220127204115.384161-9-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d12171fa-50f5-42ca-da3a-08d9e1d56e27
X-MS-TrafficTypeDiagnostic: MN2PR12MB4080:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4080F1E66B2A471694BF6752F8219@MN2PR12MB4080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TdYjQ1iv2a40AMPBJeG8f7CeEZBIHu8RYkDzYUuVXvVqruSUlYMge967lzSeNa0fF2E3q99+wA0pylpkTe9pf+vK+Ea2jvVmrdpJGOsn4YrhncUU8UKFuhur4I0YZroTV1QNIvJsAeye2iNTv4w8o+Kx9KwQwAtG1148ke/pMt/LZjxEHRnAiXDalAG44FAiEMyuPXZ8mmVOefMtlv45lIl2hnK6fCEWL2fMWHmEWiGa4KnkEUUUxAbGLKCobuopWeQfNf9NSvuSrondPAkMuRJpRNNJBQauKZ1KKkA26eWoxDY6Z8DINj2zIr0id8M1q3PICi3/Fr0evdq1F199KCkSEqti+rAkZDwJws3KFi9GKcQz9Gzcs6dEO61Nv1sfeepXrqL36GBdOOW4IPyL0iOJbt2t9jkx43gZvonAnozPi7WDMkZD72JmkthSXSpAR2BaFO4fwLb8IR7P89q/hAATrjt0xRzHjpDECKhFFDDVxBUunkxVebuROPEJ/1AFC9DE6mELqSz0hgToPP7VlNWNaCiyR6gnNgtOkimfFZgvBs+A6Dl1phHOm8+daQ85tWYih9gEUNXAeBFoxnBiEak+pQZ/VDHhnUN+tAXwK9lcTDZKgXUidiUdn3Eqm6pQV8T+HJQzAO6v8F1hybvH5PgeEho75JYJ1sTxAtRDxqotsjU1b5gjKQ2h5Cxzq1W7unr2YrRwYKq6amFnU6mKJqAjsJrUtLV+2PtIl2rke+zdtYOijF/u7nZ7glrE20dq6cRHGa+H6VCndbFSpT/LYZu1vnw3gIpwf8a3IH+Jrzc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(1076003)(83380400001)(26005)(16526019)(40460700003)(36860700001)(336012)(82310400004)(186003)(426003)(47076005)(36756003)(8936002)(8676002)(70586007)(70206006)(4326008)(316002)(6916009)(5660300002)(44832011)(2906002)(7696005)(54906003)(86362001)(81166007)(356005)(2616005)(6666004)(966005)(508600001)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:44.0150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d12171fa-50f5-42ca-da3a-08d9e1d56e27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move the DRAM limit check into a separate helper function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-13-yazen.ghannam@amd.com

v3->v4:
* Include pr_debug() on failure.

v2->v3:
* Was patch 13 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index da2d0d9ce406..139dca3a3ba4 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1326,10 +1326,20 @@ static int add_base_and_hole(struct addr_ctx *ctx)
 	return 0;
 }
 
-static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+static int addr_over_limit(struct addr_ctx *ctx)
 {
-	u64 dram_limit_addr;
+	u64 dram_limit_addr  = ((ctx->reg_limit_addr & GENMASK_ULL(31, 12)) << 16)
+					| GENMASK_ULL(27, 0);
+
+	/* Is calculated system address above DRAM limit address? */
+	if (ctx->ret_addr > dram_limit_addr)
+		return -EINVAL;
+
+	return 0;
+}
 
+static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+{
 	struct addr_ctx ctx;
 
 	if (!df_ops) {
@@ -1365,8 +1375,6 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		goto out_err;
 	}
 
-	dram_limit_addr	  = ((ctx.reg_limit_addr & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
-
 	if (add_base_and_hole(&ctx)) {
 		pr_debug("Failed to add DRAM base address and hole");
 		goto out_err;
@@ -1377,9 +1385,10 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		goto out_err;
 	}
 
-	/* Is calculated system address is above DRAM limit address? */
-	if (ctx.ret_addr > dram_limit_addr)
+	if (addr_over_limit(&ctx)) {
+		pr_debug("Calculated address is over limit");
 		goto out_err;
+	}
 
 	*sys_addr = ctx.ret_addr;
 	return 0;
-- 
2.25.1

