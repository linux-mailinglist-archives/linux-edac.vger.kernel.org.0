Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C27376A48
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhEGTDE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:03:04 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:61345
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229727AbhEGTC7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:02:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8rN3ajNvPnvfStCWro/0gC3P8w/eEWh3uk9W0ZeCdhxhsI8IVa2rm8jYXCV39bsOzBOHjOcn1CE/SWHx78346kf6+dJrkR8WcDGlr7kTMnMqpMskSLR4tuzwrLImR3TAlBVthHxosY4JhoZJTZXjuE0VtBR/bWrRpUgrYL08+MMHH42BdOYos9/GsLTASmTQSg7i984fv+Vs773twOd6IIMki7SN4o2HTPJ0SGYdJ2GdubPmMUYREo+eqytftzWv0Sf9BJvZvVCWdWNlMvT6HP/H/0wnyzVNg5yChkIh0bCQnM9ydvhCDIm7/V73BhLa97OhSMrjewTEMffVHkGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFySVG65h31y5l5wtRKKzoTT9gHw5LTv8obZFqb/Y/k=;
 b=h4ITEvcDSxruU/V0BjbMT4Z2k1oMoJaBIbaJq6G+UK/yMm3ndUUgkwqNmNEA6ftP/R1Qik5s7WbR1daNKfnAmV8Nf0dhRH1D6aKBcHATvYf0i1/zfgQf8BbpwOldwBf26S7NIojRTIYVRad0f08kNdR8jweLXZ6xv3GhQS6DUmWlyeQbJEHpX8a9ne5G6o5PydlZ/m8GdCJ/5E7DdVi32z0rvVJayXNfODRfowZMuvOE0WQTyIjrk2Cy6HaH3tCXVGTqUQQYDuqo0Kilpf9XMtU4xEsEoByRWZQ7e9pVv+NkYFsIjhW4y/VV5FPjPROS+1xu0JZFzXC9ZZ8sjaSnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFySVG65h31y5l5wtRKKzoTT9gHw5LTv8obZFqb/Y/k=;
 b=OFIvhNaqrwhh2W3kFd09Sh2rPqErHbK9XSYN75N2XFw4BqpApXAZzjT0hbwTK3jlADNJIS97a1DTgyFK2xYH+W+Tzz3buQh8Q8FBpsYHQap7hyULtLi7MvVmHfXvQY4tHCbVX2j0WYq3ZxYTdxM451HvzMKtvLyXAJMP98ggEyo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 19:01:57 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:01:57 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 05/25] x86/MCE/AMD: Define function to find interleaving mode
Date:   Fri,  7 May 2021 15:01:20 -0400
Message-Id: <20210507190140.18854-6-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:01:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54ac9515-cc80-4f8a-9ece-08d9118a9666
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3073C91A4A73163123043610F8579@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PyDvXKcBbHXWr0FnBPuTr7YMF0qScUcHOApNMiP/fYk6D3TowXEvHxNjZGpMGitIIYyiCRw3HBi9Qhv1VnCdURzY6A692LrP4Xgwpp7qWihjeXc3MmXk3CaGktFcGfYjaTcmgd2JTyTqcMoXwnnGTsuA0sr6HbLQgbfF5oZE7+W9Z1Z7LuGjGJkhkCKnPTIHITnZSYPhY3PNmpKVVKduC5AI21xWt4w6lfAvq5auaQtSvTB4UG47K0UwZ30FELt2gQDjWS7IDb8f4vZjElSwDY86E4l129jglgvFmCxZuk4aX7YdspbpGe+tWm2jthf6uAYqVf3IGvSmje0gkju3BTK8PmY8nGOZveIf9fxypFYwy+vDcPMRkmjgJBz/Nu9p5rytvHb0UbD7loq1G7z7YGJQkNH5APkECil0cPWdaNCDbV7ZBmwJWwPyK2ib99xas7xfm3Q6DYhEhDMqiTXVaox6O1nal6e94l3Ff2ku9+9PtZ7t8aeRvElhVDyRMm74SfEDn6poFQf9Uzrvapww8IeBHmzFW9b9CbCbGPfCGl9MCosVQMkB4sOjNKDNDKtXn5Vg5ppRwIsrvzun4WVLBPny3MDxan7gdmUN83c9B2shjVS3qh7R2Ml08KJoKOtC1nhqxU5L5IKiVfCqjgyHbTlMJYpYL0ZxRuIxjZNQ2Vu7oWdN8xUxOCFpBvo/WXKo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(316002)(6486002)(8936002)(8676002)(16526019)(2906002)(6666004)(186003)(83380400001)(26005)(6916009)(36756003)(52116002)(86362001)(66556008)(38100700002)(38350700002)(66476007)(66946007)(4326008)(5660300002)(1076003)(7696005)(2616005)(956004)(478600001)(37363001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UxYkoDvDTTyqPBYautrbA6z9Gy6kPQDs3sltm9icspW5ZiNg59iN70kWYhG3?=
 =?us-ascii?Q?PDNChmlA8xC0STL6TYxGmHiTSQRYciG+dq2xQ3+J4/s2OeBGzmXDq5LP3glZ?=
 =?us-ascii?Q?DOQqXG/WkMY9f3OfruhB+c3EeqMJFBpet0BSUFWT1FZpSfeXqJKMme+hXOHp?=
 =?us-ascii?Q?a0bp2q+HwZCFfUCOwLy/u2pegv0lSC+jt0tBdbHxVsbKvCgFbEk/UuRqgMCQ?=
 =?us-ascii?Q?HzNiTMtdpzl1crdD7JJLxb5HizJcWwR1Wdqv9QFwJqjKRVGnRyiG/qEsLllT?=
 =?us-ascii?Q?pNeIX0FPseeWA7lcO3Sijl6N+OzWsr1Nwijp4s0gIUbLSoHxZatsic1qXV2E?=
 =?us-ascii?Q?H3gwH4EIKLgJeBbNDnGC1mIh/aPTKzoiCh3vIYSaLYnFF5Qpw6Qsvx3oQ7tW?=
 =?us-ascii?Q?jbaz2AYrN6H3FWCxQZETgnxoF9qKHn3qwAHdLBANf1YbKjY2OxI8uV3mZ+Ze?=
 =?us-ascii?Q?8bpMx0t0iTqmDqwnx/+Yc8JZ8rwSn+PoKanwmrxIfqJYkufUMuCzk/oQr4bp?=
 =?us-ascii?Q?b+wM6cp2sJ7JE9edF6xc93wUl1CEUT3QQ0B4EmfHtPQxYTEgBp9pb1fmfPPO?=
 =?us-ascii?Q?fvS9YW9SnwbcbciJrds6iYXOBkVhytnszRZkwHydmISnO0loTjm/XsmGWsgE?=
 =?us-ascii?Q?nVDGqHG9FaMz3hHcpfwGPA/YjAwKydZ+1VIqKn4boyTIlkEBzJO4fFWbY5hy?=
 =?us-ascii?Q?ldKlp3RQOB+ZcrRrIykOipwueCLfqP3/8hjr1M2brIWEDEdP92YJavLKlwRR?=
 =?us-ascii?Q?95jFFkeR2mYJtd9PLwBATFdRjAMuWpvpTm1cLnLGTv691su9mf6jWYggBcs+?=
 =?us-ascii?Q?3OtamXZSk8z1CgbyEtOUUaE04sNQamcaEhPgLrD8V0ddqITbFphWQXFgZ+fx?=
 =?us-ascii?Q?b36MXRc6GaooK76TwCM8SD6nhie87JaoqiSuydZFd0kri9vcYvZz1PeI/Vwp?=
 =?us-ascii?Q?z8TTsY9chwtpz+ZDRGMnM5ucDiEtPM+K8M5nJScjMYASdnHZxRbDi4jOyQWF?=
 =?us-ascii?Q?ePmDUULYqKs6kgUDHenHsGdtAT8w2wV9UqKFcbnD7NP2U069rKTv/1aFteoj?=
 =?us-ascii?Q?NSaBFF3Ege0Y9iEn9CqqbGvvkqXnyqWKVJQ0+deI8enCenluU8XVT8bzU86u?=
 =?us-ascii?Q?r7n3C/sj+wTAvCJ3imSc6yqwsVCSt5bijAYt2Acaf8KXTwCYsCR337vG5ZhW?=
 =?us-ascii?Q?2nfukGpODcf47vx1P1ZWW+T9DFqeeWVqLHnRwKXVHXQkQ51BTckxFpUHoNlH?=
 =?us-ascii?Q?YKdPrYpHD6Z/jzNBdVjnAvF4QpI5VpnVKkrhfv5m3tqItETu/ZK2RRQfvUwr?=
 =?us-ascii?Q?B/Cx9Xz++cIDGLhk88g9fqNV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ac9515-cc80-4f8a-9ece-08d9118a9666
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:01:57.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FvfNSmR7a4PpsoAXXJyedz2V47L4botTALWFaN/Y+z00pfCq2qvqXYFgs5mA/OyvJIsJKQHGjhfx+waidR/IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Define a helper function to find the interleaving mode. Define a
DF2-specific function now. Future DF versions will have their own
functions.

Use an enumeration for the interleaving modes to give a human-readable
value. Save the interleaving mode in the context struct, since this will
be used in multiple functions.

Multiple interleaving modes support hashing, so save a boolean in the
context struct to check if hashing is enabled.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 38 ++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 0957f11a4c84..f1a467cb74e6 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -710,9 +710,17 @@ enum df_types {
 	DF2,
 };
 
+/* These are mapped 1:1 to the hardware values. Special cases are set at > 0x20. */
+enum intlv_modes {
+	NONE		= 0x00,
+	NOHASH_2CH	= 0x01,
+	DF2_HASH_2CH	= 0x21,
+};
+
 /* Use "reg_" prefix for raw register values. */
 struct addr_ctx {
 	enum df_types df_type;
+	enum intlv_modes intlv_mode;
 	u64 ret_addr;
 	u32 reg_dram_offset;
 	u32 reg_base_addr;
@@ -720,6 +728,7 @@ struct addr_ctx {
 	u16 nid;
 	u8 umc;
 	u8 map_num;
+	bool hash_enabled;
 };
 
 static enum df_types get_df_type(struct addr_ctx *ctx)
@@ -727,6 +736,28 @@ static enum df_types get_df_type(struct addr_ctx *ctx)
 	return DF2;
 }
 
+static int get_intlv_mode_df2(struct addr_ctx *ctx)
+{
+	ctx->intlv_mode = (ctx->reg_base_addr >> 4) & 0xF;
+
+	if (ctx->intlv_mode == 8) {
+		ctx->intlv_mode = DF2_HASH_2CH;
+		ctx->hash_enabled = true;
+	}
+
+	if (ctx->intlv_mode != NONE &&
+	    ctx->intlv_mode != NOHASH_2CH &&
+	    ctx->intlv_mode != DF2_HASH_2CH)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int get_intlv_mode(struct addr_ctx *ctx)
+{
+	return get_intlv_mode_df2(ctx);
+}
+
 static int get_dram_offset_reg(struct addr_ctx *ctx)
 {
 	if (amd_df_indirect_read(ctx->nid, df_regs[DRAM_OFFSET], ctx->umc, &ctx->reg_dram_offset))
@@ -792,7 +823,6 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	u8 num_intlv_bits, hashed_bit;
 	u8 lgcy_mmio_hole_en;
 	u8 cs_mask, cs_id = 0;
-	bool hash_enabled = false;
 
 	struct addr_ctx ctx;
 
@@ -812,6 +842,9 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	if (get_dram_addr_map(&ctx))
 		goto out_err;
 
+	if (get_intlv_mode(&ctx))
+		goto out_err;
+
 	lgcy_mmio_hole_en = ctx.reg_base_addr & BIT(1);
 	intlv_num_chan	  = (ctx.reg_base_addr >> 4) & 0xF;
 	intlv_addr_sel	  = (ctx.reg_base_addr >> 8) & 0x7;
@@ -839,7 +872,6 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	case 7:	intlv_num_chan = 4; break;
 
 	case 8: intlv_num_chan = 1;
-		hash_enabled = true;
 		break;
 	default:
 		pr_err("%s: Invalid number of interleaved channels %d.\n",
@@ -940,7 +972,7 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
 	}
 
-	if (hash_enabled) {
+	if (ctx.hash_enabled) {
 		/* Save some parentheses and grab ls-bit at the end. */
 		hashed_bit =	(ctx.ret_addr >> 12) ^
 				(ctx.ret_addr >> 18) ^
-- 
2.25.1

