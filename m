Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEF4376A4B
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhEGTDH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:03:07 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:61345
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229742AbhEGTDC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:03:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgSoOM7ABtB5rgbkM5tCy9/XmjMuw12llHQq321ow8sBzx0oAG9UrKnTt5nN4FJkaZPLL/0V4JCWA8EkhTsmI/VYGu32pMXcdiV9pO8SnkI7IMruh0JBxnrgBQGYGH7ic1/ovF/42zl+rwssxubiRpMA3TK8b78l+SULnaEC8F4H58r8zztdL93VM5yXnfCU1Gx1lh2OhEwY1z6s2Tr5fgGpzTsWpBPWvdm3Tn8z+6MC33LudHmXRnf0WIIZrSCszzcrSZMi5iMStRgJFlGBIR9xgEGHg9DTYS7f65yCKs0Pt+KDgdtx/u+b9CuKsVo8Lb0aB+lPCJzkGlpM4UD54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5KhUkeCccC0j7C4W+XKW7M9XcYfyFmDnxzAUKtobsM=;
 b=lgsqtSkg4rDtbGW5M1TxSaSEY6qfYtcFCjFvYpMdhfP4/0LhZAOMBIUyIm30zhNFbo6LMClynEOTtFr9L4c1dGC0coHDxUSjzSECp2XX+rcmmMJzM9MLLIpmlmPxLLd2ZGQjjt75KDNsuaG/Z7RFFleFlbLODLyuV2UdHrTTfKHMZDIiMYWGozvZP2OSa3OavEKWtx5SHniNTceC4vAeqnNolc7InJUxsV+UtBrbrYjDEcotBZXRtBIrtps1nO0GpEUe0Kzl5YF/8P0EIac6LPxMFWNfDtc6zetDiRsFznGk55YUSODCDee+B4k+9tuKokQA0UDvmLRwWU4WNtDVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5KhUkeCccC0j7C4W+XKW7M9XcYfyFmDnxzAUKtobsM=;
 b=ci/UflQQmJxuyhsfuTcC7ngKA8nFZckQ0eFRcxptyQ38++Y+Yl1RNMFZzH1D5ni4OrVEMoxRU/m1AR92NeWZGOa9ppM2gBuOdP6e2eVyHVzth0S0TTK2dhqhBZSWPM9sJQbTAoqMbHKHQ5ksdR4kyLk4OqGTEKagXHY9dk0xk7A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 19:01:59 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:01:59 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 07/25] x86/MCE/AMD: Define function to add DRAM base and hole
Date:   Fri,  7 May 2021 15:01:22 -0400
Message-Id: <20210507190140.18854-8-Yazen.Ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a97e4186-b146-478b-18ff-08d9118a978d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3073C11A4A004F7A375E672AF8579@BN8PR12MB3073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vElC/nWTVe0fBQqW9pDIjAjgXZuwa1/YSt7ftjQbXRvDItnZR5hReJr1YWQR3hIs6C7XXMKlYXUbhIaEY6EcB/cGuRiRLWPiCtYpLZ09i+R4vszcRG988QpEAb0pP78a4lA8fgx/8PYDFPxDRZblraqw+2mFl2N/N5aBG0cVaYsi+yYJHU32MaOMw9ugJDH2AMiZs3t3fsCWBd4ZeCg8Q7pj6Bt4KV8+07CKeei18DgJGPRrKWE3mqmLBk0fsYFDZHsFF6XQs+oFXC2oNp8MaUjQKsPXykkFTjO9ISO2TvoQOgjbuDI4Oprys5/Y9oZ8HyMSqDZZvyjrRUkmVRf+b/FsDgtYPmWoI3i7XnkrVgjvV8G4JBPrwyYs9x4/6rdHHszyWBGLnhDKoYdBK5xWdujFT4Dh2uJAsd3QE3OEIf7EG1za3QZSsc57Y/uaZLRazs42BQQ0dTQRyIFzW0gcyJtrmT0QcvJ39hYno4JzriuiqkemxuIAeJ+HbLKcwzQMAmo6jioaXNc/78co6fZSWt89dmSIjeL6CWPf7mwRXI9dGf3Ub+r+7cNbsNEp9qE5lP6V5ovi8ZPplfbjMECJ21TApvgzPchJkNpmDuGSUfDcxCnU9tp8z1P/y2G89PguWAx/nHMHr9iExbF6fWuGj5n+T/B2Jm8NlPXXtcLF3Rk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(316002)(6486002)(8936002)(8676002)(16526019)(2906002)(6666004)(186003)(83380400001)(26005)(6916009)(36756003)(52116002)(86362001)(66556008)(38100700002)(38350700002)(66476007)(66946007)(4326008)(5660300002)(1076003)(7696005)(2616005)(956004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c0j38krPUScyG/MDq0c2tNu5YcgZeqxMU/nCpFs5HhusM9xPkkE6Ky3ABieA?=
 =?us-ascii?Q?SF5/dKlIlDpFHLCFlPZMj5Bk4IcpqqUyZZ/GRKEu0fHwHhpEwCmiX98nyZ+X?=
 =?us-ascii?Q?qqK8CDIQZbvZwDfwvx19HQZc9RM4jksMy/6P/lvYSj/oiHcUHeqtp8Qj4ww1?=
 =?us-ascii?Q?V0q8GG73JRj0KFelFV+aJVq4L+zcMmoRE2Dm3fWsCNIZVE+/LrYF+uOSDDxo?=
 =?us-ascii?Q?SDrxjekRrupnVK1Vufd9Fe7gEsvS/msShHsZgsIjufOqgGU3gQsIZmGiORNn?=
 =?us-ascii?Q?3SnR/uwDYS2+s4/JUZVW9xfwZgNZAZbkMnUHoCYgWvJOfpH2P+5d5tZku6Ky?=
 =?us-ascii?Q?E0qH2E8MIsPOd5A0eK0VDnzMJTez4mgHi21/5ky/AR8XLFvyy488zRjG+Q+R?=
 =?us-ascii?Q?7oB/lPErMEaqiPBXyrw8SCEqfsq/jAHvkLNUuZ0gqq2ftouuRFcpq3qSqaC5?=
 =?us-ascii?Q?AERXCaHO43mV3+qmat1wT7XAHu0Bf8uKyJOfNPGyxuD3AavOfFDsA0csyuL4?=
 =?us-ascii?Q?GjFfeGsXA3dQMX4U1p/buSWWPTi7dgvPpH345pWqVwl21jx5X1Qn7vnvxFjS?=
 =?us-ascii?Q?9kBN93mi7VU7N9JiJyClRgcDH5+BbccLCwLN9gBevZHEY7d4sA1c57ifRLVv?=
 =?us-ascii?Q?GWQYgNqZ/NSC/PPhEYYEPkJBfHNh7U4klZrx/NzAN9niWmRj34rgRqX0CLGP?=
 =?us-ascii?Q?BKMjaqlxRt8HDOzQUH4u1Kmu8e+5aLAxUlwK7uukcctw4joH+tjxK3r9v7Lj?=
 =?us-ascii?Q?WtYoko9RJqpPu6AgSYWNQckAUqk5Ug9uYqVIfaahnQbNcSagEMrKNQcmQVmo?=
 =?us-ascii?Q?vJbqjFMv1UXSdffWmtCzmc9gU0tfkFfHO0pP/K3ND3OrwApvwGDtM+BmS7OW?=
 =?us-ascii?Q?60MXxVs3c+bjhIVS2gzU+8C4bf+WpcnDVeATObrzBjx6pUBpfmZ6VQpc/ZeP?=
 =?us-ascii?Q?677J/dqZv8gQZthUOahulJxhACuGhx4/mNPfbxFB3fb49WYvwSfjD6OW0xP3?=
 =?us-ascii?Q?YJ9/HO2VIBDHfyyZyu3972ysNCabCmDfGEEd9qYdTOg1g6Sr5SxJkN/Ac6SG?=
 =?us-ascii?Q?m3g01RxG7zr/0j8+y1j/Xuy1qbn2khk/ZviSl1YDXLsF7ACOHdOqwrIbuPpu?=
 =?us-ascii?Q?vxNdRH00XODSWxyrjUQ3MaZK2jOLKXcr+vdgJLjymaf2hwokSvEMXCk0DWqr?=
 =?us-ascii?Q?vVlhiZGcsdalPiRJqFJYIrWDiIySitaQDxR/gPO7RfMgL7RqDH6Fq81iY40H?=
 =?us-ascii?Q?So/XgaXlQg2eGjrD9sqk/JOGOtTK1KF0RV4/JpxwSfr0H50LvFRxcCzTp1vG?=
 =?us-ascii?Q?IEYBFX9iImqDtvwx7joyLXNJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97e4186-b146-478b-18ff-08d9118a978d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:01:59.8019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIrMBBNR674Sw6TDRQY7p0wuti2QWix8eahhYWqrPA37ERwdKUx1HcFMb7OLQJfJqe320pMu2QvLfTg/M4NP0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Move adding of DRAM base and hole into a separate helper function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 45 ++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 263d419d4175..d1a6405bb990 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -938,14 +938,34 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	return 0;
 }
 
-int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+static int add_base_and_hole(struct addr_ctx *ctx)
 {
-	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
+	u64 dram_base_addr = (ctx->reg_base_addr & GENMASK_ULL(31, 12)) << 16;
 
-	u32 tmp;
+	/* Add dram base address */
+	ctx->ret_addr += dram_base_addr;
+
+	/* If legacy MMIO hole enabled */
+	if (ctx->reg_base_addr & BIT(1)) {
+		u32 dram_hole_base;
+
+		if (amd_df_indirect_read(ctx->nid, df_regs[DRAM_HOLE_CTL],
+					 ctx->umc, &dram_hole_base))
+			return -EINVAL;
+
+		dram_hole_base &= GENMASK(31, 24);
+		if (ctx->ret_addr >= dram_hole_base)
+			ctx->ret_addr += (BIT_ULL(32) - dram_hole_base);
+	}
+
+	return 0;
+}
+
+int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+{
+	u64 dram_limit_addr;
 
 	u8 hashed_bit;
-	u8 lgcy_mmio_hole_en;
 
 	struct addr_ctx ctx;
 
@@ -971,23 +991,10 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 	if (denormalize_addr(&ctx))
 		goto out_err;
 
-	lgcy_mmio_hole_en = ctx.reg_base_addr & BIT(1);
-	dram_base_addr	  = (ctx.reg_base_addr & GENMASK_ULL(31, 12)) << 16;
-
 	dram_limit_addr	  = ((ctx.reg_limit_addr & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
 
-	/* Add dram base address */
-	ctx.ret_addr += dram_base_addr;
-
-	/* If legacy MMIO hole enabled */
-	if (lgcy_mmio_hole_en) {
-		if (amd_df_indirect_read(nid, df_regs[DRAM_HOLE_CTL], umc, &tmp))
-			goto out_err;
-
-		dram_hole_base = tmp & GENMASK(31, 24);
-		if (ctx.ret_addr >= dram_hole_base)
-			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
-	}
+	if (add_base_and_hole(&ctx))
+		goto out_err;
 
 	if (ctx.hash_enabled) {
 		/* Save some parentheses and grab ls-bit at the end. */
-- 
2.25.1

