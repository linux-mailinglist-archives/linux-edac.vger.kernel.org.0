Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6C3B20F5
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhFWTXH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:07 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:25341
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230092AbhFWTXF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kezDkbU6u5PJBgp82l1vf7uzF/CBd31EY7ihiTET3LFRCMe0Pq1hLqeaNZUzhNKIEGFo3ahi/5VYoNCeOryDkhHgmoHDSzBe54KruPoIQGnxdwSoEbHtXy7nzGH5ZslFx4RB72/IVMa6TCYYw0fpu3XIwkd7UhbpOm9xEZ5lAlEEkqyWDEMKEx3vWrN3aSK11/yW22Z13k9yujQX77WZrs3Z7crGyN1MCA6ZLYpEfPyFJKYG4+QbeyOEZf+1y0aojIfH4gwLIzAThuN1y3ZY2gBqMrdg638IVyyOUnpPbdbd2aUrtuT1UQviURM0+LQCf7pN3guKaSaAPWcjyGm+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm6JMBN1zZ2Me7i4RL9T3hauuispVZXY0i4kiWk1vV4=;
 b=k5X0RaPGd9Q1F4uaWHkwQS3FLdblQonMc51M7JAOcCFLVhRXFEDrIk6Auk7g7k6V1PhGjX1MmbS3/Y72L8DmTAwDGJ69seYlCJv7zTfq/sAyZcpK2k2MtEUhd1Fdi+M82YmfNPiycXiy4kdzvhpa2nMx4AcEed5DeRhoPuQ94WKH7Iw88u6XiLIAX2Y8vCiQyO2pshpTCtamB6h8BvRUWB7Db3fueMiJEniP2xY0tDxs6Pt/MHhS6pP+6IvjmKE5yzjhYEOGhAXzxjspcqQze/OL54+dKcusMV2LItdXy6iRetLJwtaNvbVb74e6rmbZYzMTRbzNZZbvZ39mOWOhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm6JMBN1zZ2Me7i4RL9T3hauuispVZXY0i4kiWk1vV4=;
 b=d+ObPo1QNckS+QA+//wynWjjdrSrv6LCuLkD5cXoL8YtRcbvyR7x5t7j/ITdgiTlabzY5OEypePPeIeiKQrKyL6v3JByl8ikUUEMRjNhY0XK0GIAyVuCcw55YjrNakCIYQe+OgfuUtMzwqK7asGtr6FQjGpaHQO/LYMyP5D712A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:45 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:45 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 08/31] EDAC/amd64: Define function to read DRAM address map registers
Date:   Wed, 23 Jun 2021 19:19:39 +0000
Message-Id: <20210623192002.3671647-9-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfb205e6-371e-4188-b3d2-08d9367c0000
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB11872A5E5E8715A31C5215E0F8089@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQuf472g67q5UIyBfcNUGDsHyLUFw9qCF7qRddAPlNZTw3C2ZX4vlUSyijZ3J1gfxFvcF8K2SaBgC0cxRMUBsWTz6pITECTL+59sDTmkELt/iSrO4J6j9mXgoM/JBRuJf0mbaLavVK9H66PZ33fY7oGHBIaCSfLfFSmdaWUAsk471w7VJG66ElEtxxrKL4GZN+Ax7yRIJOiI4G7taa8FF9aK83rvWfRAguBCQBhWCkuHY7MYNH0NNQrDfD6Z1px8r0I7TAVzhb3gDrFPatvzrajAIhnL9pTV9SXkyX+Vgr3jBqnI14eVS0R1QiJPrA3YJeMVzBh6E44S3dmS0rweDQd5O8z/mx3wPeysAjBujH0yk7haDRV4LQ5/tcwD7eQmYtEjJLQ+Hf83htabyGVDDXmaGcJFADc+o+/wBQ7CbNAlnCVhZ7Mybdadsb1D3XFSDp5lpQIUB7h0oEYrb4O3AQYYS7iIYPbxDHGvzw3m5efPsK+C4ndjeZHUT27ByfhqkjJ8FYlgFA7xOnaOL/Skoq4jpF08K4zQq9xG8/yBmG2cTxRR1Tf1RQNvFYE8xJAj1x+FihxfWlX5/t9WspoXjftwD1Q4bFe+NcbBPKQzGVN3H4nt3PPUtHiOQahX9EHoAAcNIw6lL9MvMm9v0HrXK6b4bhzN/yjIejp48Ik4kN0nCcyd+BY7VCMz+JoNLhLVJUMOnS8SxuN9W2dKWWBxki0zB/pLvvpC3zyN+ENev6ufb/iR98Sbw8PzVKxTetkQ3c0wnd2ZzyMeoHyk2iuaoWM+MVThyk3crhhrTaXTEvll9voyOK8P+nH5j9O2Stmqs2YjoRragaiEcYkYLREP0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(36756003)(38350700002)(38100700002)(44832011)(83380400001)(6916009)(26005)(7696005)(5660300002)(186003)(16526019)(66946007)(6486002)(4326008)(52116002)(8676002)(478600001)(6666004)(1076003)(2906002)(86362001)(66476007)(2616005)(66556008)(8936002)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1uuRZtpyoQUJpZGh9w2eDFPirnU6q8AaMQIrwzIJhBGWcXeZMvPP/fy6kwKr?=
 =?us-ascii?Q?4Y5sI+nOzG8pxOppsDr+2RtOqs4qTkSnPcjZ4B6RZwhL4eWE3/CuHST2mW0X?=
 =?us-ascii?Q?j8QONBcB09838r7C4bK7e3FAOu7MoA+qeCZyXpndtrxUS1P+LIB2mm1WcBQ+?=
 =?us-ascii?Q?iHV/ng4tqGmrY2Wgmx7dCAvKsBVnVqFJUXfpJsYQRDxkWW/0NJt1lMRtPLGx?=
 =?us-ascii?Q?x6LdOv1JK9MXHPTYBvkjxVCLGugJuXGFEHDeaQf3f/ixE6sgnUIWye9Sr/3C?=
 =?us-ascii?Q?MOGCs0gMWrM8N/4vTMznqP4JHasAATOhSQFPG9F9LRkfSw6TxrNrLvJRx7g6?=
 =?us-ascii?Q?2/qsY4eMu/5lzSYDjAtaGfJcYyAr/JBnhu7V0EwvBoaB5sAv58M1J2htRmzi?=
 =?us-ascii?Q?Sba3qY7cGkwwytsA1VN52IjEHiXbm95UrHsget6XAdgjMA6ZGHIhIhsNE/WF?=
 =?us-ascii?Q?KRtBEK+hp6g8+ZtZIPloAo6TR+p1tWWCGln1O8aY1qmU0bq9jwTHrw7oYppm?=
 =?us-ascii?Q?/gyYMKDDnCABc/2NJduwnYgEo/p+BpBvcLpPtOMlM+a2fxB6OnTZXufzzvoq?=
 =?us-ascii?Q?8inTMFJWMukmG0YZx9+MnLDipi0N6a9HXMlmtzHeVkrRo6N/i3wAMTP+Krsv?=
 =?us-ascii?Q?BTosb9tuJBkL67MSm9t9c6V0hgpFRuyjeDPbNBIfHD7Gprq2u6Lvz4LYUGBK?=
 =?us-ascii?Q?o/sEQ0Fbxd3kvUexpO/fDRJSbPNq4sOYc0JybT2BubHJSb4TbpkQI3Kp8Zsb?=
 =?us-ascii?Q?FkZNzy83aLimfKN3iOzJUe197kAxnTiP7w3jA77Je/jZbuCWRP3lOkomemEA?=
 =?us-ascii?Q?bNgDVMNU/LGYCiBHnnYlJ4i7RPVfGroX6Jr7yM9PjdsTm4N+3ISVjWBXS1eL?=
 =?us-ascii?Q?6WnkVSjIlyG+b5b3BtRlFZoDD42rX3ZrjY3fNcZnfCo9sdpRzs5fOdktDDRs?=
 =?us-ascii?Q?MMr5cHnXX12LDFUyrhUMKmeUIi0hP+BTUU7jKLfykAzCdLPGz7QxoLJGZi1W?=
 =?us-ascii?Q?Fud/XN44HR5ruj8aCiUF2SyUcYN4fc68tGN8oGauRh3SVMBeejXrJ/OJ0UkR?=
 =?us-ascii?Q?N/D6TXSOyruDsw/LItFVLKGmXl0HLREtAa6Kj6/6J/Mp4o0LVK5FJyXkLCwr?=
 =?us-ascii?Q?U6bzEtg9jFmE4BjtgcYWMj41scnvWnI/2c35VRoreAfogDc1jskCTL8IbEDK?=
 =?us-ascii?Q?vA1EWsxZ9dg6uZj3eg6WmgIqdQ9YJ5ATrOr9DPEenPeOJ/1djLEEPiHNCPjM?=
 =?us-ascii?Q?/OPGQmMm3R09bdGlqawZLY27GWZyvgxAYz9pgnMEj4pcveluKH2D0CqCmPTh?=
 =?us-ascii?Q?jIQuu6jJjanebgpeUAhpQG71?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb205e6-371e-4188-b3d2-08d9367c0000
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:45.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGO3lXPLVu9S85q34TLx6LoU41SL1Q5obpkCTILzCNewu6lQAq8Vnt7bZDWrnqLTllnAkisyWKzsHQqoZa2kYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move the reading of the base and limit registers into a helper function.
Save the raw values in the context struct as they will be parsed later.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-5-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 58 +++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 389f0621e885..867ab32caab2 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1083,6 +1083,8 @@ static struct df_reg df_regs[] = {
 struct addr_ctx {
 	u64 ret_addr;
 	u32 reg_dram_offset;
+	u32 reg_base_addr;
+	u32 reg_limit_addr;
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
@@ -1139,6 +1141,30 @@ static int remove_dram_offset(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int get_dram_addr_map(struct addr_ctx *ctx)
+{
+	struct df_reg reg = df_regs[DRAM_BASE_ADDR];
+
+	reg.offset += ctx->map_num * 8;
+
+	if (amd_df_indirect_read(ctx->nid, reg, ctx->inst_id, &ctx->reg_base_addr))
+		return -EINVAL;
+
+	/* Check if address range is valid. */
+	if (!(ctx->reg_base_addr & BIT(0))) {
+		pr_debug("Invalid DramBaseAddress range: 0x%x.\n", ctx->reg_base_addr);
+		return -EINVAL;
+	}
+
+	reg = df_regs[DRAM_LIMIT_ADDR];
+	reg.offset += ctx->map_num * 8;
+
+	if (amd_df_indirect_read(ctx->nid, reg, ctx->inst_id, &ctx->reg_limit_addr))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
@@ -1152,8 +1178,6 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	u8 cs_mask, cs_id = 0;
 	bool hash_enabled = false;
 
-	struct df_reg reg;
-
 	struct addr_ctx ctx;
 
 	memset(&ctx, 0, sizeof(ctx));
@@ -1170,22 +1194,13 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (remove_dram_offset(&ctx))
 		goto out_err;
 
-	reg = df_regs[DRAM_BASE_ADDR];
-	reg.offset += ctx.map_num * 8;
-	if (amd_df_indirect_read(nid, reg, umc, &tmp))
-		goto out_err;
-
-	/* Check if address range is valid. */
-	if (!(tmp & BIT(0))) {
-		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
-			__func__, tmp);
+	if (get_dram_addr_map(&ctx))
 		goto out_err;
-	}
 
-	lgcy_mmio_hole_en = tmp & BIT(1);
-	intlv_num_chan	  = (tmp >> 4) & 0xF;
-	intlv_addr_sel	  = (tmp >> 8) & 0x7;
-	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
+	lgcy_mmio_hole_en = ctx.reg_base_addr & BIT(1);
+	intlv_num_chan	  = (ctx.reg_base_addr >> 4) & 0xF;
+	intlv_addr_sel	  = (ctx.reg_base_addr >> 8) & 0x7;
+	dram_base_addr	  = (ctx.reg_base_addr & GENMASK_ULL(31, 12)) << 16;
 
 	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
 	if (intlv_addr_sel > 3) {
@@ -1194,14 +1209,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		goto out_err;
 	}
 
-	reg = df_regs[DRAM_LIMIT_ADDR];
-	reg.offset += ctx.map_num * 8;
-	if (amd_df_indirect_read(nid, reg, umc, &tmp))
-		goto out_err;
-
-	intlv_num_sockets = (tmp >> 8) & 0x1;
-	intlv_num_dies	  = (tmp >> 10) & 0x3;
-	dram_limit_addr	  = ((tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
+	intlv_num_sockets = (ctx.reg_limit_addr >> 8) & 0x1;
+	intlv_num_dies	  = (ctx.reg_limit_addr >> 10) & 0x3;
+	dram_limit_addr	  = ((ctx.reg_limit_addr & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
 
 	intlv_addr_bit = intlv_addr_sel + 8;
 
-- 
2.25.1

