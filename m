Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D9E43E7E2
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 20:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhJ1SCg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:02:36 -0400
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64]:23425
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231338AbhJ1SBS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGC7YOxWuZnFSwRetWeWWwlte+fuZlUU0AwSgdBjPaLqPPIj0GEKT3UjMcXz5K2wnVnVm/1s2bwXwH0NTUs4y2fNeiJWAGxlYEPtV+Z2yc5Xo6Obsxchhcca+/Qh1/+mw7+pUgBUKJzI7sNAVPU1Uz/8CAosu7JPK1lFfpI6roFgAJr39ap0UXBHU2e+lxLE1GivOBC6gtJ2S5GUJaU8oAAWfK1NwUUwK57Adjjy2khi+YCKya6yUI2B9/Lz1iSFUIHgeOBPX8yTYE4cUbjGoHgyadTlKmcHJUMjsLft2V4WLNum8r9YnfWlSPGvGi9xluynTsan/o9XQJpWHqm9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkyPyfJhyUJ67oDDrxx5HsDBHYUFWY16oYpNLWh7p/g=;
 b=Zd7A/lRv79kWxiRpTtxLW98RHIZUUKqY+wWXR4Ot8b0Y3RR3LSaN0S+uXu5gTfhWPBvlj9FyHDht08aU8Wbwra9k91sCXwORL/cnHjfbCTYRexGePu8V8cc5lNM75RXFh+sIIiEF2QU1/uhNyZ4nxR6DPdF0lxJ5RMJWb6pZkXFSTOZHbyU23qJjHnZDylSyhEH2DNS1aacYnAt/Lbr69z6wtcEXWfoCJ55C7QPfrzVfXd1/JPb8wuaC4VpKdndPdJRaL9ILg42Oz6cG0Grg70xilbf86UcprXViG/ge9O1acvATGAouIloAiFC7WrjuGIRge7L0C6SSJ86SJ63l6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkyPyfJhyUJ67oDDrxx5HsDBHYUFWY16oYpNLWh7p/g=;
 b=G4/ejBtRH73H6y/mZSdx6zQHUcWUzJz6Vx30nfim2fuLDo8GCQjS9s7RWvifw20NhqNYrOnqmcnQ1Mt1mrNj1jj5GKZLXyqh3HdVcYwqT5A9+U9wDKvGyDjYh+p1ZM7zjnhBmN6OdT9/X3LpI+vLP+qdswSRPDwSOn07y799NnU=
Received: from MW4PR03CA0110.namprd03.prod.outlook.com (2603:10b6:303:b7::25)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 17:58:48 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::96) by MW4PR03CA0110.outlook.office365.com
 (2603:10b6:303:b7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:47 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:46 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 31/33] EDAC/amd64: Add check for when to add DRAM base and hole
Date:   Thu, 28 Oct 2021 17:57:26 +0000
Message-ID: <20211028175728.121452-32-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4191d8a9-4a9c-46f2-d0c7-08d99a3c977b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5030:
X-Microsoft-Antispam-PRVS: <BL1PR12MB503034ECD8A51C459805472DF8869@BL1PR12MB5030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bBM5Q4NiuEknoUrPjpW1uoW/TYg7zHWFah9p/tEdyvmc7obvcn4vLXsHT2SK5LbHghSr8/x64neHS3JTlhrjHc31X+B6lE0X/d5PSR5SqLOUrzRe1qgK2gqm2OccQ9g+gHaUwixx4P709C2+0GX3PZopSXY2RkgIhsfG31tZNgU6zPNXBAm7VB1Vn2ea40YoQoRZzK4iINYUwBMlO7I3nyS5Mk4JoFzR00QLJXbzD1pN4x3uspn8FOXdvR9bK9XvVTs294LTM4kcQ9CsESejUE3ZmzJQPuCm1BcaevcY1a6I7gUU1G6tUH1gJaWF/Qb+SOraKKYDYFHocmXqvo6B8vyPcFhujnsYqs2T2eCd2FPofju/8f+kgtrKKlyIf0E5gqNhc1xYmFD6j5FLen536Vr2o+3wwOAbVbSmp/dwFLXdlWM3PbRXqdg2Y0UGB/j8W7c8x2Lh/48LL8BE1UuIOajx6hukvEuEiXL2kb6UQg8Xa5FigR6cW1oPrb3D+lu0XVSBsRO+FQj3hTfAX5eDBU31K7GQ/UIR17lnRfDItBbRGJ5SPz7CVTFNxhIxk5FE0Wsh1mCLhPRjJgJGXQpQrerI0KvY9CC10E4rzW1urAOWVBhc4ZXYSto16vsfbPefQSew8O6yqMJZcBeVjBpUpstvlVk92HTX5UnTKRNavd9oBP4EblOzLwv6fLTBpyRUuAmMdTq2dJfU3NSxItzO19aA1cNtic9wSojpYkTqgvc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(426003)(81166007)(36756003)(4326008)(26005)(54906003)(6666004)(70586007)(336012)(356005)(70206006)(47076005)(36860700001)(7696005)(508600001)(2616005)(8936002)(2906002)(82310400003)(44832011)(83380400001)(86362001)(8676002)(6916009)(1076003)(186003)(16526019)(316002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:47.8246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4191d8a9-4a9c-46f2-d0c7-08d99a3c977b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Some DF versions and interleaving modes require the DRAM base address
and hole adjustments to be done before accounting for hashing. Others
require this to be done after.

Add a check for this behavior. Save a boolean in the ctx struct which
can be appropriately set based on DF version or interleaving mode.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
v2->v3:
* New in v3.

 drivers/edac/amd64_edac.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 5dacd7e03202..07009901a283 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1092,6 +1092,7 @@ struct addr_ctx {
 	u8 intlv_num_sockets;
 	u8 cs_id;
 	u8 node_id_shift;
+	bool late_hole_remove;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 	void (*make_space_for_cs_id)(struct addr_ctx *ctx);
 	void (*insert_cs_id)(struct addr_ctx *ctx);
@@ -1638,12 +1639,15 @@ static int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 df_inst_id)
 	if (denormalize_addr(&ctx))
 		return -EINVAL;
 
-	if (add_base_and_hole(&ctx))
+	if (!ctx.late_hole_remove && add_base_and_hole(&ctx))
 		return -EINVAL;
 
 	if (ctx.dehash_addr && ctx.dehash_addr(&ctx))
 		return -EINVAL;
 
+	if (ctx.late_hole_remove && add_base_and_hole(&ctx))
+		return -EINVAL;
+
 	if (addr_over_limit(&ctx))
 		return -EINVAL;
 
-- 
2.25.1

