Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFC9376A49
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhEGTDF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:03:05 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:61345
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229699AbhEGTC7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:02:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0LyrlokWd+n9Bpu/HvB1pKbnwIDb92HOlub9ByuO7n5NqqXj7zzrEbXg8QOGIzFuPV3lpVoJm2S992zbPWjyG541HQyr3001AU1IVlrftrYumWPO3g0IP/EUaCNSdcvprD6LfujSdDodetc0dhU3boITnnqUtGbArTbgOB5frOLTgaer0M5wlVRkOS/Fmj46q86WjlGUPmcovswD3OHXnK5OZrDfjOoRb0PU8sHZHSNFG37M2QODgu+9i8UsD95ZK6+0d1qX2Yq6wDthIMXMmpB2PGSPcOjhNaRncu46DEHNqlsDBV1aNOr2+pCU2Y0449uQIBPY04dbQi1Wd+jwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/VfQneShCGPB3pX9VjtKwYyKQjmb04gQQtPCKWlJ8Y=;
 b=QsC9FIpz03z8cdHFssNOzMXTKCfFewNP9VsFsWlRjj7KwyjMUYC0PnEQgDm2UkNpsJBReJSO2Q32t/JORY5lAB3tfhQR0QPSeSkERQYpDMK+0C7eXd3E+tQFAP4d3T1MEnWb0ZUuIqi7RELB34yOTCzmQcFVGB2merEmvWXzztCOLtTA9Z/nlvsZotQ7pZCfPhKs/U+2SbT5SW/ba0E3ucBk3CCd4LobBPEjAlHJW4auhCvo9cmETonrIjxDtkrzx9lqQ4OheNs+J2C2SF4vnlYpqZT/NzGVB+1Hw/yFtWm3j9ub3fMZoo/B9ZDnLnTq6xQtmNsZfL5MFE9nu1L5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/VfQneShCGPB3pX9VjtKwYyKQjmb04gQQtPCKWlJ8Y=;
 b=tElAOgmHhgPrwZ98zv/kc8cOX1HIRSSY8HdmGInD+Fx5p4+0D9bOWAT6FsyZItcQZwrUHd2DAJfxE8yyU4022dHpnVzdDbBUbxhGbTHmVRhMIdX0tUD1yGbR45q3n5ZNgO20PhgVLNIzfmMI72dFLed/vEgcR3fGL4sD1r9x3lg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 19:01:56 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:01:56 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 04/25] x86/MCE/AMD: Define function to read DRAM address map registers
Date:   Fri,  7 May 2021 15:01:19 -0400
Message-Id: <20210507190140.18854-5-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:01:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06bab993-0a93-4654-f916-08d9118a95bb
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3073FA79F42E66CECDAF03B2F8579@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3i9Ah+3Nr8z/hjFYJdbaB4kvERRMQouhjCfLifcXslKDHq5KR04NuQHJw1d2F1V/Sl80Hi/ZKfE7JdwmlahCFXM1xLrMcfN1EmdFzIKB7FqtCZIaDh1nxMdtjZ+hfXuDC+BGaiHNgYgSpgEB8HEMkxnHgX0U/85UrPyscvlC1pfWr99mBeSONSPFY8cJ/hzB+g5I2rL5ycponzDyeC1IB3TXTb3EUj/AZnk4yqoZxWgkttTadIIHvcVOeS/JEUJdWZ5onRL8IXBec+JIItESffbKvd3Gc4Qt0lfTRo7/mchffqEyjnFvegyy8s4BFCJWBbkacm+RwqJlJQWE6Jfn0nowqyPcku3E30VnBgsj5LAyGxwqSC84UtsG/bXiM3PLfpSdnvtl0UCMup2CgBEpT0Ty/YwA3XjxnfZQkbSCAP0FZISghYb+gNi7jledd0LPtqctKc+DLW3LW8+gNLREGW4p6jqHrEQXbdPbBqrW3Zqs7orRyL7UrX+0pKun9S1q7UZAG51T2twtsMUyEoSn7hN63Fhmm0K9DSx7SVXqmDVjZadVF2RdDzl9DTz53tXFwiNrhMkBqTYsm1I7b+D2XbnajoJTpElnKm4w6B90g434lTn6YxmwYhtwrkkFlR+Y6rWnaNbhi6f6vY2heqcROg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(316002)(6486002)(8936002)(8676002)(16526019)(2906002)(6666004)(186003)(83380400001)(26005)(6916009)(36756003)(52116002)(86362001)(66556008)(38100700002)(38350700002)(66476007)(66946007)(4326008)(5660300002)(1076003)(7696005)(2616005)(956004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qwkQ9csYGPT+ivzGDd8C5881dnCcJ5lAnVaBwo6pomyLe5nEyjq7Bpht29VB?=
 =?us-ascii?Q?fMbthHzC/labNtId+cqjtjLG0QdW6kZZRWUG7GmlnqXslqeRaDpooWHHsx8U?=
 =?us-ascii?Q?bTqHrQ0J9UIZS9g0Vg+XWJmdoNPE908twg+ouKvrpEdSxSDhPV0NacqahDIA?=
 =?us-ascii?Q?/p3ZI0Bu6xaobQAeEXLJiZlC8lBl3rOF6L+kipTHRgWzvcnFjoSESZ2jiPoV?=
 =?us-ascii?Q?z/MvRmJaUOGfGEIGNQBUXpK7dViQJb+xHAKwqdoFNKU8mfd0yM464dfvPPPD?=
 =?us-ascii?Q?Tv1ZY1NTdPIT8ooeATYVewkCRwYIgXal2bEKyw/OrSn5QMtQeOeLtMA3IY5Y?=
 =?us-ascii?Q?haMbR6Tg0qKojLopK2sJvXuHannkWDWCxDn+YN1iwX6ZxaXASfMdNr61BHuw?=
 =?us-ascii?Q?GRWN4iXszzPP/Eq8d9BOge2INzSOXUI8s9FUgHJGofIjUXwrnK0Lj2EyV7hj?=
 =?us-ascii?Q?7l4xVQ5B13cH8lSuUidxIR8+5CLE5xTMST3T4A7gkW68EfseTI1066b5vNfC?=
 =?us-ascii?Q?2JOus6CGIJLpl/tZ1UbYPcVPyTjkQeCjbcl+8Jzo8/846F+jmmuAMIQlnVy/?=
 =?us-ascii?Q?uwrWLmGT2FnldySrvEGjRKWkeofvkSFT3ZZFXRCrLwZzEoOE11Jc/hjYz1fX?=
 =?us-ascii?Q?XRx5LO9sWO9sVzGn3B7EUyuITgHOW0lpQLx3SHA2i2qirNyceiDUuNPcBaqJ?=
 =?us-ascii?Q?L4ZldyOyz43gyo9Lcq/EuOSNdMNXPeuSsIHvACkSaRe5NB/vxwES/szHWLyn?=
 =?us-ascii?Q?H383fxmX2/f6zECEHI0noKvntyaOCcDz+npM0h7N2mcM6Q9gsbc1cmNwgVhT?=
 =?us-ascii?Q?ilNEr241CtX5rgxIYik7UeDep1UFRoADaS2jEyzxVWHSozNqsPFcDd3Ke763?=
 =?us-ascii?Q?/ef0TS2M27vtbEj4u4W/FAyO7hh5miJkDryYb47/hpH1H93mNh4cJk5qCCzn?=
 =?us-ascii?Q?siOSzJVoxN9EiL7AkHGci3vkBOvSfG0xVKVnvE2bz3zr3VYo1W1rCRonK8mm?=
 =?us-ascii?Q?RayZyae70xKE89b7zrDB99RXmBv3FAI41UuHu/i34OLmlKDyGNo1iMoEfXWH?=
 =?us-ascii?Q?b5JaQTS+HXEvpw/x2+QzHshjMRIOvlV9n0syMSf2EGXRwaclpSCPQDiDZ9d1?=
 =?us-ascii?Q?erTEkvOR8ZeyOnU6QO41tl1fMeN1fX5ihoNeU9wbQ3+os+O/EzjqU6GjwyCO?=
 =?us-ascii?Q?6XYOAfD7x3cWDCYTA2hqPx13oAXvNYrH2bu5ZcRfIRKKaJTWoIDmdaiXkb2l?=
 =?us-ascii?Q?Mei3ccubo9vmE0c97UeVKrQGjm3R8XInCDe08q6exYMPKsHgVT5UafcGFZdV?=
 =?us-ascii?Q?BRjKptMbtMwXF4ALp/YP3QwU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bab993-0a93-4654-f916-08d9118a95bb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:01:56.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcslAmI8+56SgojjngK6fGQG7ht0Ju7PuuZwe94N56XyyeB0u45yxdAI1zGwifE67+Y0QSUa5VedF5fGlbelCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Move the reading of the base and limit registers into a helper function.
Save the raw values in the context struct as they will be parsed later.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 53 ++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 20a6f34143f6..0957f11a4c84 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -715,6 +715,8 @@ struct addr_ctx {
 	enum df_types df_type;
 	u64 ret_addr;
 	u32 reg_dram_offset;
+	u32 reg_base_addr;
+	u32 reg_limit_addr;
 	u16 nid;
 	u8 umc;
 	u8 map_num;
@@ -758,6 +760,27 @@ static int remove_dram_offset(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int get_dram_addr_map(struct addr_ctx *ctx)
+{
+	struct df_reg reg = ctx->map_num ? df_regs[DRAM_BASE_ADDR_1] : df_regs[DRAM_BASE_ADDR_0];
+
+	if (amd_df_indirect_read(ctx->nid, reg, ctx->umc, &ctx->reg_base_addr))
+		return -EINVAL;
+
+	reg = ctx->map_num ? df_regs[DRAM_LIMIT_ADDR_1] : df_regs[DRAM_LIMIT_ADDR_0];
+	if (amd_df_indirect_read(ctx->nid, reg, ctx->umc, &ctx->reg_limit_addr))
+		return -EINVAL;
+
+	/* Check if address range is valid. */
+	if (!(ctx->reg_base_addr & BIT(0))) {
+		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
+		       __func__, ctx->reg_base_addr);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
@@ -771,8 +794,6 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	u8 cs_mask, cs_id = 0;
 	bool hash_enabled = false;
 
-	struct df_reg reg;
-
 	struct addr_ctx ctx;
 
 	memset(&ctx, 0, sizeof(ctx));
@@ -788,21 +809,13 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	if (remove_dram_offset(&ctx))
 		goto out_err;
 
-	reg = ctx.map_num ? df_regs[DRAM_BASE_ADDR_1] : df_regs[DRAM_BASE_ADDR_0];
-	if (amd_df_indirect_read(nid, reg, umc, &tmp))
+	if (get_dram_addr_map(&ctx))
 		goto out_err;
 
-	/* Check if address range is valid. */
-	if (!(tmp & BIT(0))) {
-		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
-			__func__, tmp);
-		goto out_err;
-	}
-
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
@@ -811,13 +824,9 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		goto out_err;
 	}
 
-	reg = ctx.map_num ? df_regs[DRAM_LIMIT_ADDR_1] : df_regs[DRAM_LIMIT_ADDR_0];
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

