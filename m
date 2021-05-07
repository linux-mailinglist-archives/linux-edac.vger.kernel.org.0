Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D649A376A4A
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhEGTDF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:03:05 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:61345
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229470AbhEGTDA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:03:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hov8Ya5sxNH1LOzkL+fvBEz5/h81CIiyq9whzbvKrKLT7WS8/Y4+Z9AdF5ZjQS5w9t3sXOqf4DiRoKUdQ/E0mbIJtSzibRyQedsywAOq0AMjGO6jcQstpe/G8tl1GZJ0UW5zihS6Zglh38SV226ps62dM1b+3wQe82NzlVSRl3PtZNRdR1bPEGfMwpYQsqT6WUMtLKtB1vrVCPr3LxzW0J2JBO5IIwuK5kjROPWloWBY0kyn1yGTKeN5yNKbuQOJ+P5OxgZMI6z0nq52Lwtm0SKuW3RLxn367Mf4cukSnLFqtXGovnv5RisglE5hZF1Zh1wFtmu7MjsbqldL++Wuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2nJhjNZS4qcdWg97yu+0TAq0wZsFfBnJ5JtN7P6jc8=;
 b=dy3O+YbLAPK9X/owIioXqohmVxqbuLYfsKGr3iNLCkHhYu0IwPxBms98XVxusjbZCuSam1eun1XrKZ+unUjzMcic/IOjymr0o2JvMPesMyQsnl0LnhJnnZAMBUK+2lF6ihOHsbC/+Fl3zZlZcHB9w41rv3Fbz5DKcymF4+/wahy7Jff+6fDbt/tWQLj5Y74FlPZrjgDGFnO0igxz93/nHf9r1i0K7NeviLXb6vFsGcetBQqGJHj5SEhW+ydpBsYUYnmtryVnL5tKOEK+K6866NPq4WEWHg4jRwhNvlL5gZFqwX6t+U/3dNILTj/KfXLAJv8i61A53mnT389XAMosJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2nJhjNZS4qcdWg97yu+0TAq0wZsFfBnJ5JtN7P6jc8=;
 b=ULnt1wfCcGtb8Te8QWriI/Nk/+7CIsEydryu1u04DH+x9rL2ivlK1tYRH8NRTHQT0Uii5iyCD+gDpMMDl61fRVOaNtq+uUqW1xErZzbqur8k0fxUtGOuemGeHXu9L4W7YJ9EzD0lqWWoqcPkfopLHCS5CGixCWXC1BaWaV7UgqQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 19:01:58 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:01:58 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 06/25] x86/MCE/AMD: Define function to denormalize address
Date:   Fri,  7 May 2021 15:01:21 -0400
Message-Id: <20210507190140.18854-7-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN6PR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:404:8e::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:01:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20ebc95c-9c6e-4da4-a153-08d9118a96f9
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3073787ABAD84682B0239DB0F8579@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrfZsDIaMOjX1q6ox8xl6XozC5lmS6NVV+qA2EF5AZ8bCF91jeF6463I9S7/vkQRz2QqcI27zgZFz/53cS1NAIJLwNF54GjT4YLCtwoyi1g5WSbdlW8dmMPyBiniKFubdyhQLr21nLVGegewPy1Q73U+rgdW2uMTlIYNdoIOxcXkwcvD/E7WfJrrE1vCmHBWFEmj8iFW7JDdhRy8S7/bgtb2Jy89plwH/Vjkl/pw+y3NmkjDKcEjJVaJfIBGsTMKwe5ZSkrAQpDV++rXrPAu5rAMpbJTR28zzVlt322X5bD1QzOdWp/stbqN82zb6k36oJU7h4DsAFcqHIF/Wlpk7XpAIjtAofKpIuyTdvvbgy+jSmvAQuE1oaKz0ggRrb+G9jobZDy801AoBauY3lW5QjN5AJqRusg0m2RX6+AUEyeQWqSsbBSiWf1onojdkb1ktysRd7HNv9PKu/jFxC+XXqagLDgHn0mTLXSO1csdyifZzIHYDyZ1KVknjkruT5n4xkw5JjH4aUzqmkTLtFjUmIYJxmrldRlNNlnA6fmHiSnIz2xcgBh0QJAy6iWyOaKWh09V9MZxcNcFtvG150eWqKaE6yeiDJHO6ev1tHrOouD2MtmJuvo/1l0pLXg7F2yq0NFwZqsAVm13wW7R2FFGn8p4luFAI3zofuFG19cArMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(316002)(6486002)(8936002)(8676002)(16526019)(2906002)(6666004)(186003)(83380400001)(26005)(6916009)(36756003)(52116002)(86362001)(66556008)(38100700002)(38350700002)(66476007)(66946007)(4326008)(5660300002)(1076003)(7696005)(2616005)(956004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fEmQZQhalMKk4TF87SmCqKB3gDT1jDNBdRJaDcrzE2anuyvwG9Id/6eCrd4d?=
 =?us-ascii?Q?EimpcltQfgKSo5iSH/AYI2Figa0+fYXRImQEDEx7UxZgWvpJx9xHcad5k3X7?=
 =?us-ascii?Q?JCQ+IipQRp4WSL2ngqr13hX3CVcsQngVkL6SFwNp1nTL5Xa203eWGU91Y4MX?=
 =?us-ascii?Q?5IvgKc8vtyGEdq8rcwKy3B2/hDvooV49Ak/YmZ+BIILHxANhaOKa8IONuclx?=
 =?us-ascii?Q?vtFe5ei4NoEhQXVmsAA37red8wnz+ILxev5uO5tgBEok/6hmT11NAfQ1U2tK?=
 =?us-ascii?Q?KZqtvc9pV7IT6NipOu3gMsg0gYLwyn476ZvWOxQmmYAfO6loL9Q3Vndthi8z?=
 =?us-ascii?Q?fvrdxu4qY+Y6BbtejNPI7Di3r2syHB1bp5+vPCt3GeG9UQaxSDHFNnIXMY2f?=
 =?us-ascii?Q?+Xb34k4rvhBXFK8V3vZMkDomZZWAVa4J6IPgQUAHrBxtuiAkX1hMrVon4A2P?=
 =?us-ascii?Q?zotJSlT3jYnz/EY1evV7EZ7gYDbeNFUNnGn4941MLsd7qWM2jdFBABTvqicb?=
 =?us-ascii?Q?rWswbppxbCpOFLaXLetNeYPJGjuB1+XlRQtwrwNgIgmmNwXNnAnX81tjKNxF?=
 =?us-ascii?Q?KranBNC4AlDAes1B37dugIOS4v8rKqVjl0m8CnWsBn+kko9JNggSeYbA5U9+?=
 =?us-ascii?Q?5hTwdN9imiiIsSXWH3Dx4ZUSWTVUA7O63SRoNFg5YZ228cKifFKy9m3mUx8Y?=
 =?us-ascii?Q?hZu9DOHNeV7ZbnM0IR177UB5DAAl/Sxfwo8pDKvrXm4k+xhx7NARLO1zzZDb?=
 =?us-ascii?Q?dOUbLl+60/Ny7HXS3DzmRzMh6KDF042yUBPSiF3j/RnffLexIAgA3xM2sl/+?=
 =?us-ascii?Q?PYswoowxFxhJiOX5cZzSY6G1nU7oA5qMUvnxKqU28tLYfJOKgUaer/8ZD3H3?=
 =?us-ascii?Q?7tObhl4cWdSFNNLIRmIJxUwj7oKt7pLnkYcOREENKnlAJbw3MPq6ECRg9x2u?=
 =?us-ascii?Q?NhIAVco7lbz9MAVIiNdswqzg4b0iqKZAGfv2fPX1fa/+5pgzt8MPdApJbfZQ?=
 =?us-ascii?Q?WJ+cWOqwECN4iejTJ7hHgF0NizUn4hD+Tnx8yD4hQANeXIjRbFyOwgJ6aegZ?=
 =?us-ascii?Q?R7rVs0dAZbfemtJkoSVovVmJvlM/d17HlKLxnM+ABI+GMWDk0WhEADG3UHzg?=
 =?us-ascii?Q?KAOAd0096MUBtQjoOPIc5Ssul13bayeqx9I7j+9vudEj+g/tY8Be0B6VhSyI?=
 =?us-ascii?Q?rcaa7BGZ9nF6G01W75vyY9ipxy7OZwLC4Ntq6U0CTecvK+Jg9AQoVJhMvTpG?=
 =?us-ascii?Q?SoiQABabctY126itKeVjULIeIsXh+fqtPTZ8EscIrmysgbhyGNJPLhuiySU4?=
 =?us-ascii?Q?9MYnN2AlR7/Hw4WqnZImsHyE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ebc95c-9c6e-4da4-a153-08d9118a96f9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:01:58.7605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WoyMwI6wOHiyLcR1W7R5lQoxXhyLiITWGMSV9xB8nYaRFJfVt8dj4/KJewah/eOka/9oJlttQmB7s147s5TSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Move the address denormalization into a separate helper function. This
will be further refactored in later patches.

Add the interleave address bit and the CS ID to the context struct.
These values will be used by multiple functions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 125 +++++++++++++++++++---------------
 1 file changed, 71 insertions(+), 54 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f1a467cb74e6..263d419d4175 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -728,6 +728,8 @@ struct addr_ctx {
 	u16 nid;
 	u8 umc;
 	u8 map_num;
+	u8 intlv_addr_bit;
+	u8 cs_id;
 	bool hash_enabled;
 };
 
@@ -812,56 +814,26 @@ static int get_dram_addr_map(struct addr_ctx *ctx)
 	return 0;
 }
 
-int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
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
-	ctx.umc = umc;
-
-	ctx.df_type = get_df_type(&ctx);
-
-	if (remove_dram_offset(&ctx))
-		goto out_err;
-
-	if (get_dram_addr_map(&ctx))
-		goto out_err;
-
-	if (get_intlv_mode(&ctx))
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
@@ -876,7 +848,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	default:
 		pr_err("%s: Invalid number of interleaved channels %d.\n",
 			__func__, intlv_num_chan);
-		goto out_err;
+		return -EINVAL;
 	}
 
 	num_intlv_bits = intlv_num_chan;
@@ -884,7 +856,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	if (intlv_num_dies > 2) {
 		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
 			__func__, intlv_num_dies);
-		goto out_err;
+		return -EINVAL;
 	}
 
 	num_intlv_bits += intlv_num_dies;
@@ -896,7 +868,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	if (num_intlv_bits > 4) {
 		pr_err("%s: Invalid interleave bits %d.\n",
 			__func__, num_intlv_bits);
-		goto out_err;
+		return -EINVAL;
 	}
 
 	if (num_intlv_bits > 0) {
@@ -909,8 +881,8 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		 * umc/channel# as instance id of the coherent slave
 		 * for FICAA.
 		 */
-		if (amd_df_indirect_read(nid, df_regs[FAB_BLK_INST_INFO_3], umc, &tmp))
-			goto out_err;
+		if (amd_df_indirect_read(ctx->nid, df_regs[FAB_BLK_INST_INFO_3], ctx->umc, &tmp))
+			return -EINVAL;
 
 		cs_fabric_id = (tmp >> 8) & 0xFF;
 		die_id_bit   = 0;
@@ -919,14 +891,15 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
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
+						 ctx->umc, &tmp))
+				return -EINVAL;
 
 		/* If interleaved over more than 1 die. */
 		if (intlv_num_dies) {
@@ -934,7 +907,8 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 			die_id_shift = (tmp >> 24) & 0xF;
 			die_id_mask  = (tmp >> 8) & 0xFF;
 
-			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+			ctx->cs_id |= ((cs_fabric_id & die_id_mask)
+					>> die_id_shift) << die_id_bit;
 		}
 
 		/* If interleaved over more than 1 socket. */
@@ -942,7 +916,8 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 			socket_id_shift	= (tmp >> 28) & 0xF;
 			socket_id_mask	= (tmp >> 16) & 0xFF;
 
-			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
+			ctx->cs_id |= ((cs_fabric_id & socket_id_mask)
+					>> socket_id_shift) << sock_id_bit;
 		}
 
 		/*
@@ -953,12 +928,54 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
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
+int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
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
+	ctx.umc = umc;
+
+	ctx.df_type = get_df_type(&ctx);
+
+	if (remove_dram_offset(&ctx))
+		return -EINVAL;
+
+	if (get_dram_addr_map(&ctx))
+		goto out_err;
+
+	if (get_intlv_mode(&ctx))
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
 
@@ -978,12 +995,12 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
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

