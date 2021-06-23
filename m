Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF29E3B20F8
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhFWTXN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:13 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:25341
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230107AbhFWTXI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gV0t0cuLtNoW58LvySs2p1L8bCTFTL7IFsE2RHiDDONhZPp8nFv9T9WX4hZPsLMI8UoRFirXXksRNBnQ1KVzTFRok5mDsG1CCS9RmUbJTVOhw+pDANPJLnmAvvQGgjqWGd3FQb8qYPna7qdGNWnKldmC7n2H98Dx4LpZxXCJ6/Z6SheEEnl3ng08DF8swLHCC0DDuZ5L6p7cyRurup6qzd5G1CvlrVOl3g2rCo/bEB0MPIRbDSwrfHRQt1bEKu0WqJDYTDvJlt6o6EuansuCmKpkZW0sE/hKwvwyjl+8tXajMJUm80hjE/bYxxDdCnfJPgT73/FQBVTTmvsT6WgaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0r7g/FgjviEG0GKIL8M4o0xmv6SnKBUvngHzO5h5bk=;
 b=V3ptypxEHEsxaKeRa5V6+YhxO6iUBxJ7REL0JTWDi7CSw64jiGk4NDSOePBYYoev8kffXIDFVJhqDfqRbXMvEtDcosCuhoc1aXmV5F7Xnk7Fjq3Ln1r/6l/ftkKV5XAAcFC4o/s216CeTSLTr7GIBNjSY2uRlkIVNn2GgY6bwT5YA2qcRo0L3CDZpg1FYD+0NSTR7FPntKic5yLSitb2n7y/IuWlczn4EVFDXH793KJN0V/3IBJf5JL7wngYaqnovAdb+WNCyYfmOfMN3f9F25OU82w++Le3V4ZegRtXwhtPKeOxSIATanuvOzEXEw/iHiOUQjm/ewdmFJeBxOxKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0r7g/FgjviEG0GKIL8M4o0xmv6SnKBUvngHzO5h5bk=;
 b=G6cVXxpbqTYBcn25T/4M464lFP721+wHs+GvP2NEbKlur5zgJGFCkr2E0j8WeNBNY8jf/NRZOV0OpgffCRpTiHg03gQv6etAIsSa1QBuokxHnkAf4S2xSGeKMd5yB9PvTNXlbkndXDeA+PLbBUf1hwEmzcfD9GRJstQm7ZSVW5c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:47 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:47 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 10/31] EDAC/amd64: Define function to denormalize address
Date:   Wed, 23 Jun 2021 19:19:41 +0000
Message-Id: <20210623192002.3671647-11-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f3c5065-9519-424a-5fd6-08d9367c0108
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1187F503CC92D85A9CE36C20F8089@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdfPtiYkogUZpYuTbbVD8iT7XaSZfJTlzMGC0mno6nPtxOC9n/S6xmrYBt2dr9JfMJ0jnRDWW3PedfHHtHUQSc1cVBX7QXVDZDt/fVPgxxizGVld3dvjRjpE6t+jYsI+/JDcprmywIse/WESq1itk+6edjiOD9Xa8/ewpr8S/JjWHlJu4tAgR5aaJ1R6i2h8LcGr8jTqDXPsCInYfkrgV8PzE2OGj9zgzJszQIaNbEjL7jHUMh+FahW5q/LL7YMelKyPYGNM6wNBJJ8RCxPiGg7CddsN8eThevSt9kxzvsEmr1CKiU0gqTBPVPj+neNqGwGPtPFztrwu2ZWjTD5G5nEe1iIhaheWOnigJXkdTVPHNs5LrtlKIynOa/6axG/RkoKOG5oRHY6w7Rpl6wMSjaq1gy/tRx/EYP3xHCFedAbBCcBU1tMEFq70Qsz+DN6XzPneQi/dX6pmFp+VN+PDS6pt1AO6Tt1CbegW4BMeZV37PvXdjdJ8B0g45mP6CB1gsaMcfLRrdjcfmI0LbGz4N+72oTGByvj96vYgrxfSJ+UVB+WmcWvppIt0JdEUJWqXl7XyUuPTR7vJgHFxSUM+fJiwf/cagbR+JI6tWxKcitIRZoDNAOAYKYVHs7xG/5nZ6GgqU6LhRDUMIXV1bT5SN19Fwx5dOX+bUuXz1TbpXaVntwQSKuRjulmAygi0B8yAI/q1G1Au5ML7jIPF7VsHWjRN/VsHLP4IzAhKnyFbZHOsVan1ddD4KRdT13e7KJpO+1krp9fJCsxSgnawGz+7mwOHM+c37hamZQvdJwUXJYjvym4+W06gjlt3a52yr9y6WA6ffY7v3GWg9hdIEZep8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(36756003)(38350700002)(38100700002)(44832011)(83380400001)(6916009)(26005)(7696005)(5660300002)(186003)(16526019)(66946007)(6486002)(4326008)(52116002)(8676002)(478600001)(6666004)(1076003)(2906002)(86362001)(66476007)(2616005)(66556008)(8936002)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lE3VPE/TM0AX6j3e9/57YpzGRxUs2prHE6WK1Nd3gdaXZW0EpZa5g4wTrdym?=
 =?us-ascii?Q?sCOPdYXOht5d4f5SewMz+u5K2mdFYOpnRm00hDnSVORXrHVi5wGEwLwZ1cD4?=
 =?us-ascii?Q?iUMHgjB40TohSLuRtyovM32ftN6CW3Y2baelHWq8zmXVeQyipDDO7tnHgOXl?=
 =?us-ascii?Q?8KsJP+OMWxl5MY/NbvBOKvLmwwMbgJn0y/EqVTWQDeTTas0BRQteIxpP7srl?=
 =?us-ascii?Q?5jYZxTNoNq9FwNiaeJVg2Qlu+T5weExHURcHUqFPIGOqIpCxSmnkBm6725kv?=
 =?us-ascii?Q?bm9Iq58/dOB46a+Rbh1zP46C7e2DkgX634bQ/KBy2qe7vwjVZ653pTmN0doS?=
 =?us-ascii?Q?jP+/37/novBqaSSIhxNYSw7zW9HrkM7nSDF/d2qJuCuB89tcvWlVgS9eR1XD?=
 =?us-ascii?Q?8gg6pW0jjxHivmoqtz6dTN1iV2PCucn0NqBFCIMVhCphlSULk4fpO5MeaC2w?=
 =?us-ascii?Q?b03ASdRMszmcQGL6G+8nPfFOLZY2O/V0vHAdyaIrXFU5qZ76FM4KIUCz9zZP?=
 =?us-ascii?Q?BgQHPJBICSo6FScyncGxPTOmJvUqrPM5TGx66FubE7U7Nlk9ajXP4i3CNx6g?=
 =?us-ascii?Q?n4NRdFXr/7Tjp2UaHyUlKrpWQav7Kjnf0J8zwg/ArZojmA8ke0xrHTbZ3qsQ?=
 =?us-ascii?Q?7UKs38YzlvikKgz6joOeF2+tRN0oVv2oexC+BcdnV/at0FPXH0RXNbf/NvKs?=
 =?us-ascii?Q?9oWwjjZUcQiQ53tcrtyJseaTNgKYhxH/fV0+PGLmGT9t1AaS6C/Itcee6tqW?=
 =?us-ascii?Q?rZbp/4nmDI/LVE/oeeMDOBNKfC+9V3zwZkh/pXo+fICs3JYIFP4/jIEuHS2R?=
 =?us-ascii?Q?untOA7d3tyi7l/SwjUqsbYBeYFav/awqW/pwW/Rf5CDJ3I74lFkbV/3c5v6m?=
 =?us-ascii?Q?HBoLXraZN/c+2M3b1WUIa8B2QNJekFfpFSxKjS5ooO7FsY3buY4qZdRvjdLx?=
 =?us-ascii?Q?L1BnjSruGoVNS7ncOeABd8l/aBVQ477h8+v6DRk1edL0wJxyr+SMNJvW/IMa?=
 =?us-ascii?Q?0Rort1uZyET0CieXMfbPBFgmbK68U66C4ZJ3dWcxERxg0IPpTwIk6aqKvFuM?=
 =?us-ascii?Q?84/8HmUdcstqeR3brXWJ2FrgwvnUl1IgKsbDw5LgGoC97AZD7j70GHJ/UEgw?=
 =?us-ascii?Q?SB1OUZf5tKxJdFZhcjFeoTf8DxaYHE+cD1ydLwW/kBE63ZNy1BzdYo01veof?=
 =?us-ascii?Q?SXfc2Wl/so6NakgIDYK3kLM5LCgfMwypttQpbfkc2Rr05FuPIfElZeBswceB?=
 =?us-ascii?Q?JPaeo1FgayMOx8ksMrSo7CRiM/2+5whCLv2a1+6std1pu9IrcUE8sFhCTFdN?=
 =?us-ascii?Q?M143BqO3pErkh6b12RC8VB69?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3c5065-9519-424a-5fd6-08d9367c0108
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:47.2655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUj5f3VeYvdLzttxHVYnETOMLtRrKQzn1EVVUlqO2R9ghr3daWV5nXy8o13xoTI1HcOaO6UQJ/KttExbVP16kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move the address denormalization into a separate helper function. This
will be further refactored in later patches.

Add the interleave address bit and the CS ID to the context struct.
These values will be used by multiple functions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-7-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 128 ++++++++++++++++++++++----------------
 1 file changed, 73 insertions(+), 55 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 93a4ce9eb735..ebb82b5e155b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1096,6 +1096,8 @@ struct addr_ctx {
 	u16 nid;
 	u8 inst_id;
 	u8 map_num;
+	u8 intlv_addr_bit;
+	u8 cs_id;
 	bool hash_enabled;
 };
 
@@ -1193,57 +1195,26 @@ static int get_dram_addr_map(struct addr_ctx *ctx)
 	return 0;
 }
 
-static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+static int denormalize_addr(struct addr_ctx *ctx)
 {
-	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
 	u32 tmp;
 
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
-	u8 intlv_addr_sel, intlv_addr_bit;
-	u8 num_intlv_bits, hashed_bit;
-	u8 lgcy_mmio_hole_en;
-	u8 cs_mask, cs_id = 0;
-
-	struct addr_ctx ctx;
-
-	memset(&ctx, 0, sizeof(ctx));
-
-	/* We start from the normalized address */
-	ctx.ret_addr = norm_addr;
-
-	ctx.nid = nid;
-	ctx.inst_id = umc;
-
-	if (set_df_ops(&ctx))
-		return -EINVAL;
-
-	if (remove_dram_offset(&ctx))
-		goto out_err;
-
-	if (get_dram_addr_map(&ctx))
-		goto out_err;
-
-	if (df_ops->get_intlv_mode(&ctx))
-		goto out_err;
-
-	lgcy_mmio_hole_en = ctx.reg_base_addr & BIT(1);
-	intlv_num_chan	  = (ctx.reg_base_addr >> 4) & 0xF;
-	intlv_addr_sel	  = (ctx.reg_base_addr >> 8) & 0x7;
-	dram_base_addr	  = (ctx.reg_base_addr & GENMASK_ULL(31, 12)) << 16;
+	u8 intlv_addr_sel = (ctx->reg_base_addr >> 8) & 0x7;
+	u8 num_intlv_bits, cs_mask = 0;
 
 	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
 	if (intlv_addr_sel > 3) {
 		pr_err("%s: Invalid interleave address select %d.\n",
 			__func__, intlv_addr_sel);
-		goto out_err;
+		return -EINVAL;
 	}
 
-	intlv_num_sockets = (ctx.reg_limit_addr >> 8) & 0x1;
-	intlv_num_dies	  = (ctx.reg_limit_addr >> 10) & 0x3;
-	dram_limit_addr	  = ((ctx.reg_limit_addr & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
+	intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
+	intlv_num_dies	  = (ctx->reg_limit_addr >> 10) & 0x3;
 
-	intlv_addr_bit = intlv_addr_sel + 8;
+	ctx->intlv_addr_bit = intlv_addr_sel + 8;
 
 	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
 	switch (intlv_num_chan) {
@@ -1258,7 +1229,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	default:
 		pr_err("%s: Invalid number of interleaved channels %d.\n",
 			__func__, intlv_num_chan);
-		goto out_err;
+		return -EINVAL;
 	}
 
 	num_intlv_bits = intlv_num_chan;
@@ -1266,7 +1237,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (intlv_num_dies > 2) {
 		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
 			__func__, intlv_num_dies);
-		goto out_err;
+		return -EINVAL;
 	}
 
 	num_intlv_bits += intlv_num_dies;
@@ -1278,7 +1249,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 	if (num_intlv_bits > 4) {
 		pr_err("%s: Invalid interleave bits %d.\n",
 			__func__, num_intlv_bits);
-		goto out_err;
+		return -EINVAL;
 	}
 
 	if (num_intlv_bits > 0) {
@@ -1291,8 +1262,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		 * umc/channel# as instance id of the coherent slave
 		 * for FICAA.
 		 */
-		if (amd_df_indirect_read(nid, df_regs[FAB_BLK_INST_INFO_3], umc, &tmp))
-			goto out_err;
+		if (amd_df_indirect_read(ctx->nid, df_regs[FAB_BLK_INST_INFO_3],
+					 ctx->inst_id, &tmp))
+			return -EINVAL;
 
 		cs_fabric_id = (tmp >> 8) & 0xFF;
 		die_id_bit   = 0;
@@ -1301,14 +1273,15 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		if (intlv_num_chan) {
 			die_id_bit = intlv_num_chan;
 			cs_mask	   = (1 << die_id_bit) - 1;
-			cs_id	   = cs_fabric_id & cs_mask;
+			ctx->cs_id = cs_fabric_id & cs_mask;
 		}
 
 		sock_id_bit = die_id_bit;
 
 		if (intlv_num_dies || intlv_num_sockets)
-			if (amd_df_indirect_read(nid, df_regs[SYS_FAB_ID_MASK], umc, &tmp))
-				goto out_err;
+			if (amd_df_indirect_read(ctx->nid, df_regs[SYS_FAB_ID_MASK],
+						 ctx->inst_id, &tmp))
+				return -EINVAL;
 
 		/* If interleaved over more than 1 die. */
 		if (intlv_num_dies) {
@@ -1316,7 +1289,8 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 			die_id_shift = (tmp >> 24) & 0xF;
 			die_id_mask  = (tmp >> 8) & 0xFF;
 
-			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+			ctx->cs_id |= ((cs_fabric_id & die_id_mask)
+					>> die_id_shift) << die_id_bit;
 		}
 
 		/* If interleaved over more than 1 socket. */
@@ -1324,7 +1298,8 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 			socket_id_shift	= (tmp >> 28) & 0xF;
 			socket_id_mask	= (tmp >> 16) & 0xFF;
 
-			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
+			ctx->cs_id |= ((cs_fabric_id & socket_id_mask)
+					>> socket_id_shift) << sock_id_bit;
 		}
 
 		/*
@@ -1335,12 +1310,55 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
 		 * there are (where "I" starts).
 		 */
-		temp_addr_y = ctx.ret_addr & GENMASK_ULL(intlv_addr_bit - 1, 0);
-		temp_addr_i = (cs_id << intlv_addr_bit);
-		temp_addr_x = (ctx.ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
-		ctx.ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
+		temp_addr_y = ctx->ret_addr & GENMASK_ULL(ctx->intlv_addr_bit - 1, 0);
+		temp_addr_i = (ctx->cs_id << ctx->intlv_addr_bit);
+		temp_addr_x = (ctx->ret_addr & GENMASK_ULL(63, ctx->intlv_addr_bit))
+			       << num_intlv_bits;
+		ctx->ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
 	}
 
+	return 0;
+}
+
+static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+{
+	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
+
+	u32 tmp;
+
+	u8 hashed_bit;
+	u8 lgcy_mmio_hole_en;
+
+	struct addr_ctx ctx;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	/* We start from the normalized address */
+	ctx.ret_addr = norm_addr;
+
+	ctx.nid = nid;
+	ctx.inst_id = umc;
+
+	if (set_df_ops(&ctx))
+		return -EINVAL;
+
+	if (remove_dram_offset(&ctx))
+		return -EINVAL;
+
+	if (get_dram_addr_map(&ctx))
+		goto out_err;
+
+	if (df_ops->get_intlv_mode(&ctx))
+		goto out_err;
+
+	if (denormalize_addr(&ctx))
+		goto out_err;
+
+	lgcy_mmio_hole_en = ctx.reg_base_addr & BIT(1);
+	dram_base_addr	  = (ctx.reg_base_addr & GENMASK_ULL(31, 12)) << 16;
+
+	dram_limit_addr	  = ((ctx.reg_limit_addr & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
+
 	/* Add dram base address */
 	ctx.ret_addr += dram_base_addr;
 
@@ -1360,12 +1378,12 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 				(ctx.ret_addr >> 18) ^
 				(ctx.ret_addr >> 21) ^
 				(ctx.ret_addr >> 30) ^
-				cs_id;
+				ctx.cs_id;
 
 		hashed_bit &= BIT(0);
 
-		if (hashed_bit != ((ctx.ret_addr >> intlv_addr_bit) & BIT(0)))
-			ctx.ret_addr ^= BIT(intlv_addr_bit);
+		if (hashed_bit != ((ctx.ret_addr >> ctx.intlv_addr_bit) & BIT(0)))
+			ctx.ret_addr ^= BIT(ctx.intlv_addr_bit);
 	}
 
 	/* Is calculated system address is above DRAM limit address? */
-- 
2.25.1

