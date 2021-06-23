Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A473B210B
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFWTXo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:44 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:25341
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230351AbhFWTXY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW7igummqJzr1GhyKfdbpl87+5UQjZpeN3hep6Wb+nurF7R9kG9DvBD7YxsTOJ7Cclh5EA/KmwY18X2Hoka67IyCy6xR2jIT6jJYd2lEk7SL+ksu5daVzyr3NdGeSbGZ8IluD8fmZZCFYaL+p+Y+mcRvwO1J5d6JSDRk6EIrz5jYJpCNjw0vFj30Kzl+Zwn+vOtuT3U/bDGhnAJEzDGNYa7RC0abTOf/q/iQIS9LSq8cJYPo/UQqJDFub0QPlaThtDgXXq4DFcRsPD9B9hTVzrstOkXYVfqeJuotESewoNQ5YTNNBySbQHTbRrPPFSMWvOylPjls/349XCbiEW4A+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNO7WtSynVUJd/EkXORGW1EQxVIDZ9F9cy6CNaOupi4=;
 b=habMkFK62bzlf1IIBZ/WIUkM8/EhiFdK4WQiJmlqnnofah/JBVN80IXex+vYc3YxTMYGJOUGNYq3OfCJuUQv20kpitxXPXu4Jw5pe0ltYB56uTKKAS9ccvC12mpp2Pm2InCgHD84qSo7tK1NIog64xttiIHP1OYZKl9QaUcEnylOZXJEY42Mj59xqEIs8uQqVkBG07SmHOAkuWNcgfXnA4Siec68IcolYTRzAXs4dtuR++Yk8uYaw+5NwoG4xbyoOYTH3CK93PGwcEQvSvcU/rH/pL1+ZCyI7D+GRllcNMALmZl45wsXq0exA6pq+ebO+8dcWpVSvgcKwlTq4LEPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNO7WtSynVUJd/EkXORGW1EQxVIDZ9F9cy6CNaOupi4=;
 b=wNZhJ3DQsiNKNlFdYRm7e2rhRgYRNeCxQ5wjpS76nzlQlyMgKqKPfhzAeD8AgK0rJVibeKNOTYrf/DFQ49UfLnXgSP+P4xWKyTz24efvjRuCQZrJWTPxiHroKZ8dZ4yeieog7Fh4unpOUVIOO8mHbqIQ/UJb+gEBEwaPwPjalVo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:49 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:49 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 13/31] EDAC/amd64: Define function to check DRAM limit address
Date:   Wed, 23 Jun 2021 19:19:44 +0000
Message-Id: <20210623192002.3671647-14-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210623192002.3671647-1-yazen.ghannam@amd.com>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e46e456-088b-41fc-07f2-08d9367c0283
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1187BBEE820838D0CA5E9D38F8089@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPY++VvA3DV5+B9ZvpkJ3gQ8nBzwlpWPisidU+0jJRYohWIwv+yNpgwxkiTQXBevLliPMDo0aJSBt9t/lgs5dwUDGLvzmLceE1EhHHnnPFboS3xzsGWcs7naUv7QBIIUJKy3hXru8Y6AOl9M+FfgwWZZu8G1KNobJybrcSEKN1TRqVkdwXYpU/d8ojvp7PtPOof2ytkWJjL48FAfT3ZDdIjsFGXzFZQC3I0PCDr5UrlV6yU3BfiTzNW81IPo8GTTG5Dpi5YJTSaw1VxMNcPQwnkybis3V9Offyvq9XxHfSQ0JWao0Sen55rYzhdSzLo7oWZiG0WNX15uGYJEdcFRcVeJqVqWumFvM7kdRedgGaQP7lTKgCKsM6XoBKcziTrIgFEReRTX+0SsEaUhxqZc8Pv0RJEIOdRyZM8sABNCHZtQIbawbO2a1/JrhBcEPQ0OXnbCxknivooZvnXbNb5pDeKr+iRK4NRJYHe05nDvCVNuR6w88zzsLO5eEQVTlfrPmZy9IDrQ85OM0gsHc0QB7Sm4EyEJfNNIvszwDUj4B8BKTAQney8Dx94yStFVH5Q9u2Yk8Pb9yN2Aj0U8t3YXDwkA85VYURZAZkVsj2qypCZPeydnOJolPPB2NuopYrhJygM8XxO+7qBQ5Fz3UbLbp/EodxadBpK0sGmoJQ5KAMFuZcymZyLRnzfHcb9EEtcxuJFK3wXBLBJoqWdVESjc3h1KYc6kG/BOIyfdjIj1wXKox5EsKvaSmXCVTUsWAB2sRXa2SGF9ax0x+a2c/61O1nasb2fg+e+NWZ2XTVa0y3H7UYsRCIqVwsLnmCdA4b/C79IphkUn5EV27VsJbSindg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(36756003)(38350700002)(38100700002)(44832011)(83380400001)(6916009)(26005)(7696005)(5660300002)(186003)(16526019)(66946007)(6486002)(4326008)(52116002)(8676002)(478600001)(6666004)(1076003)(2906002)(86362001)(66476007)(2616005)(66556008)(8936002)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/t0w50xMdmAmfEH9GoqpGNT9Nv5Hr+l7lCyTnf88AoJljThsSJqgw+RgsgZj?=
 =?us-ascii?Q?b+DX4ZqjEYzD49Sw5kRPpy/juL9Vbv0A9ngYjyicDwj50jdLHwi1Nv8N0Irm?=
 =?us-ascii?Q?ZtiN+5Oh3nWD3S5whWx5YsLrgbhCqrv/1l2Vbh3Wnsyow1Gi4GXmQsY8k6bT?=
 =?us-ascii?Q?+B2G6Js2UvhZ08RY7PRGjwqbsjkkysVmPM+iFmXV12Z5AUz8VxrnZRRokUIC?=
 =?us-ascii?Q?Q8IlNbbmzxaJmD6mnJtaloVu6rusxkDu4urOJwdBqxzqK2vv6OLR25igceYe?=
 =?us-ascii?Q?7YFHMwv0FVnBC9ktPjDz0LoOZvJOREGlLHoWbBaugEtxiMAmG2DEzqRLQZS4?=
 =?us-ascii?Q?qkdlq2HAzMae+VpCCWO4OPFLYWP5oxaSvYoMN8ur0WFZEH0VTz3DUfUVzvS0?=
 =?us-ascii?Q?wecp01K8kXtEXRnEQQ02BH85AETzo6iZVbNY1xFuPYV2KR9bCrJYBiE3DzmM?=
 =?us-ascii?Q?pBXBjl3JU1mmufN3THl9DvUT+7vlh2eO+OqgBuOyRqcBCuXGMzWvzEYDwwVu?=
 =?us-ascii?Q?jCLrghhHoQLyZ8HKwUlDyVpRpJpyEssz5Ko0z2VmOy6hElTKwPtP243JVTDB?=
 =?us-ascii?Q?vTFK+UVZUU66a1oTLqk5OlzRGP/MnkCVAWtIsCsXXJgJZYw4ZDMlknI08qh2?=
 =?us-ascii?Q?bqjbN4Gx/zJUBkQgsqk2xWxT6+Z1Pd4rmF+pPWbwbFPEEV+1x8c7j2huHvL0?=
 =?us-ascii?Q?FZYD8bZztpJYvO3pj9IQlFjLvJq4tsRmDpKrvd1SdYWqdHzSlzDyicAIV5Mo?=
 =?us-ascii?Q?Z+szdzMr1PbKMVq1koRZGU0qTG6iM3wBEDZyLkz0DNjlC9JnJRY5zdO8rAgU?=
 =?us-ascii?Q?fBshKSC7tkFX0Rt/PoVqhXXnf3eXuMtM+/Jz3LjILdpRtLLhCYQUWB0Iek2d?=
 =?us-ascii?Q?YDUawRPx52+H4M+9uZozA0CeZQOqBtlyPt3UljXndxWepqEkjWT/otw9SFd+?=
 =?us-ascii?Q?KIVJd48HK3pLyw+oZHWBYfvzx6fmzdaFW4wZJF65c2Am0wX1VhO5xPFqwBhc?=
 =?us-ascii?Q?M32sUvIXuO3T6p2LtSL5tuDZHhernkGAiwlvCZW9xQdsFkxOZuCxpRxe44Nf?=
 =?us-ascii?Q?fx2wmGM9J7u4HIrbtIf6ybmW8Ij/gTkZrMv0BkiR4EnLW/8ESu6MiuHh5de6?=
 =?us-ascii?Q?wGihxlOiGi4mRriqCO6fHtbK5Fg/EJT/U0PY9/Ri6s6dI12YgscEW2LP6TLu?=
 =?us-ascii?Q?/YiXWrOySZzNDCQy8JCd/CY7HNUoxvTsRObthGGZYMEIBhtfINqW0c727CkA?=
 =?us-ascii?Q?LSISxYHN4xkWBK2LbwPAIgGz8nckg8EvzK8ufFTlI3lSOZ6c3UvMfXfXZpDu?=
 =?us-ascii?Q?McL2cyjab6SqpRmk1qx4CC6W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e46e456-088b-41fc-07f2-08d9367c0283
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:49.7041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5t+yemnedc1G6D1g9fmFC7VbmMyfHOM1HH0sShmwIlLHtPPH8QNn4Z15dv4uArC3nNzYHtOmnpCNuWPLjlaGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move the DRAM limit check into a separate helper function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-10-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 46b0279a2e12..de80a224ef12 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1359,10 +1359,20 @@ static int add_base_and_hole(struct addr_ctx *ctx)
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
 
+	return 0;
+}
+
+static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+{
 	struct addr_ctx ctx;
 
 	memset(&ctx, 0, sizeof(ctx));
@@ -1388,16 +1398,13 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (denormalize_addr(&ctx))
 		goto out_err;
 
-	dram_limit_addr	  = ((ctx.reg_limit_addr & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
-
 	if (add_base_and_hole(&ctx))
 		goto out_err;
 
 	if (ctx.dehash_addr && ctx.dehash_addr(&ctx))
 		goto out_err;
 
-	/* Is calculated system address is above DRAM limit address? */
-	if (ctx.ret_addr > dram_limit_addr)
+	if (addr_over_limit(&ctx))
 		goto out_err;
 
 	*sys_addr = ctx.ret_addr;
-- 
2.25.1

