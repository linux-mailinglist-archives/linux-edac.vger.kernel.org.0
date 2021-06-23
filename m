Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6753B20F1
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFWTXD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:03 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:25341
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230052AbhFWTXC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LC69U4JjfPtnkd2Sn/IFcgDFfMXHN8qNZ5tHC0jdZggRPCOK96n+4bDmXUhoz/hwTlHPc5X1efkOhrcpen/7nbA6UR+t2gx0HWFkzvIQGTSd8HFUUk0/jDakgM3W/YkpYO0O0HHp83LQUiIpTGBqjxRi6uNEHqAyx7YZ6nydeigJpaH6WNxO85R4/csuMveAlSubRhfs315+pU6xgb+7EOsFVMMKI9CEnxI3TMWxbzQhO5KQundJK83N7a7ispQhIn6MSz/TBND39L45Cvf/mh0oZssA1/K4wvpJVGdSWeRkToihziw+CUyDUCaSAlCij9SkgEzfjDqlPdmDFwoxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/VTeTYyjraWFB+vzm+4VKecUmkX6HGDeekzs1U3YY8=;
 b=CS7ujMurgvUuGH7mzzMA/6KpMKUULRXdL78vkZ5B5FUpCbLeUACLLwO7BIToIex9pfJL39QYd0hXWA476cKz822FsCAk9oZ6qUUXj7ADMZstY0c5Uj0rQvPxhOgrNa0NwZ8B6SYAtxMJ+EXsO0HoLmjSzYFHA/tGA5HJ3NZjvJ6LNIHCJGV2nFMFnnf1Iy7tgoKxRWnTEFP1rAzwcGHCdiSBLJx9ibWm1dmVw51GWEzSDbNvxd8JPWwmvD33rv7kvTVMaMj7kPkzAWNODa7sfyH1JDhZpMDGme8VbgS4S06wa7/jAdoCG5oG1ntfoCOSONZ3Uhcrt9ElgoiE5tRohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/VTeTYyjraWFB+vzm+4VKecUmkX6HGDeekzs1U3YY8=;
 b=aJdIK0t6IMQ6EXCfaSDu8/kDH5SZjztNOoMvcVX/seTBfwt8Ah95TzDDxciMUCMR+2Ittg8VfO/3v/LBeh1xgFjFWmez7IP+R5EMDrHoDJKHJ1vvWSc0eMh5GgnlLljQglqTq3DCEBeWThkmIx8zIkNWGol6WQi1tkzsZ3NqY8U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:42 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:42 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 05/31] EDAC/amd64: Add context struct
Date:   Wed, 23 Jun 2021 19:19:36 +0000
Message-Id: <20210623192002.3671647-6-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64496256-0b58-4c63-eb15-08d9367bfe68
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1187CC0BCCB1142AA1767AE8F8089@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLCkZbiAbKE6GS9qDBHeSC7WMbZc6z8ZxzxnSMzF6CPEpkkhUbAVCBxbh1Zz35E0I0UzYhhQ1joFx79W9eCNccBluFgYAQ2qjjmVzbWfwhMzNlrGHRNQQkifQGoGUzBcsnZV32zq2ET0yqyP9NKOH/k+8OvnBidetWjGmgaGrEkDQyhHXG7WKMxDlLPK+FZrPhQh4mIfGoFEdLry9LNB+x71YGn0Um0/FzzZ8k58z/OL+UUYksneiPnnLLSxxPa0ODziCBUb05A5i+LnhWBtoYHgPFCBVGC1RMAwIHsmbw/S1U35GtE9nI4i93uUmrrxajq5MkNuBwTjxqXkhTNA3/wQfFhRikizxyG5EL20BI6Nqfk7THZJfKWgXz3UGAgN2Y7+aa0CSG8mtrL0BQGZW/GLjFzYByIigVHHP22TGPgP0KmR6s54vaSrKl/+BbF6nHSGb3IXEIvr0oi4Y9qj/izESz+sYWH8zSNr6hZDwY3OJe3Fec1I0uSrGMYixPgp0vQxtrVKhk8qHqVpeWtxrJKk+HtfVtmMKKJwUf+OTbev9MO3o2q58jIxZT/qTpdc9K/ye5gKI8DaQXthmEc9kfUndF8DvdA963xepvMmz+CCN0Lezxu6sjfYPP0fxR5J8mvr8seulXGw1ICbVsOhUL1IoDj6rp+jh4D2v8E8d7wFLJgbbAcvqnliMi82MBp5SCJNlWjQjxJ55WLh0JFlZHjbIlHjm2h600l4aKZ2bopDveVfZzMLK0672ohskBBjx1ap63ZUsS/jt2PWGm2+LqYzP7jstegdOw5Ey0+MGGZWJZ438RcwLLh8lbgbKlafTOmoK3HleUJ9BLfOXuGycg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(36756003)(38350700002)(38100700002)(44832011)(83380400001)(6916009)(26005)(7696005)(5660300002)(186003)(16526019)(66946007)(6486002)(4326008)(52116002)(8676002)(478600001)(6666004)(1076003)(2906002)(86362001)(66476007)(2616005)(66556008)(8936002)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y/ZtNZscaWHAh4bUYPR09JsA658fUHFax3kb2ajiiSFiSSOlgbrAt4Dmzxvp?=
 =?us-ascii?Q?JEwAfBSwA+Xfq5Ap7v3MnTsObMj7GaBgby+G1GTVraPW5QjZUe5ySvXXFPos?=
 =?us-ascii?Q?L289ixUOn0gl2W9M2PcydDqqeAct+mtv/xxc3i/y7Lu/Ix6tGXCOTIz/2JGM?=
 =?us-ascii?Q?TxB8V7a4rJtFeNT59pMzCoVrjxZ5uJxh+1I9j4+/U981Us/zy/bJGazqGpnR?=
 =?us-ascii?Q?sSEatMouJtrlRjw6pFRcK7SQXiZXXxxj5TJHNRbYH1HxuFt1PS717PXifVq3?=
 =?us-ascii?Q?bNVjd2L82O7xhiYCPuGyNPges3w4ZdrgjAGe7tA9wfQGeeB46vEEVriqsSBC?=
 =?us-ascii?Q?wvmiYAqRNXA1kcYbEOhOZuY31q57FyWqwzCIxMCR01LxoLvetTEG1UqXT4ve?=
 =?us-ascii?Q?dq6poVsQTih4af7WSm3/FBDdhEq2SCcs8nPeUO2RC20zaooXl+AEnmToeZHy?=
 =?us-ascii?Q?D9VwfKOSoSvCw4Nt981CuQ5ZyBJW2oHZBNmYy77cSi/gj/dedf3TVzGMOMzW?=
 =?us-ascii?Q?ElWFM5HBziKrVKPWfxR7fvHzJvjU4skiyQCc/B3ppqOrnImTBE3yE+yUDpG2?=
 =?us-ascii?Q?MkAWXHytUt6KaWdR1HkTeNG+kGxaTj0scPLF0PHQNRuLD8uxRRVhWuExy7l/?=
 =?us-ascii?Q?VMM5oPW7L+txr1OPpUHbkVlyejP4GikeV81NLQmc7k1F+iiYmpE0d5Z+vaQX?=
 =?us-ascii?Q?H0VcXpzn+xdj/KkwKj3zqYmhuAeovvF8T9CHedNFtijEH2Pq/UMREY7JKETr?=
 =?us-ascii?Q?9o2o+XhDRJgBJ2JHXnGSiLXwJQuC8IDJvL8xH1qRPnGVsTgNPtmE1oVXjMgR?=
 =?us-ascii?Q?l30QN+SmfQRW9Lfl0w245pnMGe1vMWUjnKjExpXvL9wnCxBfS6IX524rOAgr?=
 =?us-ascii?Q?fL29riOgrsTKaglP3w1ls8WU6Eoxyu0rFLm2uF9vvOY3YQ5dJBKZWwL5U5qX?=
 =?us-ascii?Q?iuiGl3JaWziT4EaxxUVsDImwmzWFf5PmSxISIfLAt+806qbFJClKjUbiEnuT?=
 =?us-ascii?Q?JIm/IPcZLvLm8PI4EoD2rW7mcvM95EJagwvEofNoBCVal0549HMcCvMX+hLd?=
 =?us-ascii?Q?i3ZhGCgNrvBpQa1K+aZsqdhe2YwjgVq3SxV5FxmCZed7Am0g2/Z/CRfLmPrK?=
 =?us-ascii?Q?qm3YiSIfSN5b9KQ+UuPD12pESR+8Masc/7AqdCqbVtoX4WGgjpsAnULm6QNf?=
 =?us-ascii?Q?KR5eZtlDQQkrDWTjkB2gckeu0RQ5Ne6uLKJbIlkjGQCORLCUAIhWNWs0okWK?=
 =?us-ascii?Q?OVrpDiYd8pleCJQfE1w7IsYu8siI3pqukIz21ehXSRKv16SgR4ztVgDBpOMI?=
 =?us-ascii?Q?w7IeFZuTEuXwycOKY59Qsj/y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64496256-0b58-4c63-eb15-08d9367bfe68
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:42.8660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLPuHT4LVh6XuOBRP7jrUp3XbG5xh6hcT3mrotaJQCi/bNFmyOX81WSvGr6xdugDnhUNwTww3lTsACnRxzSE3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Define an address translation context struct. This will hold values that
will be passed between multiple functions.

Save return address, Node ID, and the Instance ID number to start.
Currently, we use the UMC number as the Instance ID, but future DF
versions may use another value.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-3-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.
* Changed "umc" variable to "inst_id".
* Drop df_types enum.

 drivers/edac/amd64_edac.c | 49 +++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index d67cd8f57b94..62eca188458f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1079,12 +1079,15 @@ static struct df_reg df_regs[] = {
 	[SYS_FAB_ID_MASK]	=	{1, 0x208},
 };
 
+struct addr_ctx {
+	u64 ret_addr;
+	u16 nid;
+	u8 inst_id;
+};
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
-	/* We start from the normalized address */
-	u64 ret_addr = norm_addr;
-
 	u32 tmp;
 
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
@@ -1097,6 +1100,16 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 
 	struct df_reg reg;
 
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
 	if (amd_df_indirect_read(nid, df_regs[DRAM_OFFSET], umc, &tmp))
 		goto out_err;
 
@@ -1105,7 +1118,7 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
 
 		if (norm_addr >= hi_addr_offset) {
-			ret_addr -= hi_addr_offset;
+			ctx.ret_addr -= hi_addr_offset;
 			base = 1;
 		}
 	}
@@ -1236,14 +1249,14 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
 		 * there are (where "I" starts).
 		 */
-		temp_addr_y = ret_addr & GENMASK_ULL(intlv_addr_bit-1, 0);
+		temp_addr_y = ctx.ret_addr & GENMASK_ULL(intlv_addr_bit - 1, 0);
 		temp_addr_i = (cs_id << intlv_addr_bit);
-		temp_addr_x = (ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
-		ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
+		temp_addr_x = (ctx.ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
+		ctx.ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
 	}
 
 	/* Add dram base address */
-	ret_addr += dram_base_addr;
+	ctx.ret_addr += dram_base_addr;
 
 	/* If legacy MMIO hole enabled */
 	if (lgcy_mmio_hole_en) {
@@ -1251,29 +1264,29 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 			goto out_err;
 
 		dram_hole_base = tmp & GENMASK(31, 24);
-		if (ret_addr >= dram_hole_base)
-			ret_addr += (BIT_ULL(32) - dram_hole_base);
+		if (ctx.ret_addr >= dram_hole_base)
+			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
 	}
 
 	if (hash_enabled) {
 		/* Save some parentheses and grab ls-bit at the end. */
-		hashed_bit =	(ret_addr >> 12) ^
-				(ret_addr >> 18) ^
-				(ret_addr >> 21) ^
-				(ret_addr >> 30) ^
+		hashed_bit =	(ctx.ret_addr >> 12) ^
+				(ctx.ret_addr >> 18) ^
+				(ctx.ret_addr >> 21) ^
+				(ctx.ret_addr >> 30) ^
 				cs_id;
 
 		hashed_bit &= BIT(0);
 
-		if (hashed_bit != ((ret_addr >> intlv_addr_bit) & BIT(0)))
-			ret_addr ^= BIT(intlv_addr_bit);
+		if (hashed_bit != ((ctx.ret_addr >> intlv_addr_bit) & BIT(0)))
+			ctx.ret_addr ^= BIT(intlv_addr_bit);
 	}
 
 	/* Is calculated system address is above DRAM limit address? */
-	if (ret_addr > dram_limit_addr)
+	if (ctx.ret_addr > dram_limit_addr)
 		goto out_err;
 
-	*sys_addr = ret_addr;
+	*sys_addr = ctx.ret_addr;
 	return 0;
 
 out_err:
-- 
2.25.1

