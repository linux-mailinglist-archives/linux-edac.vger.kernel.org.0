Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4E73B20FB
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFWTXQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:23:16 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:25341
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229930AbhFWTXN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY7CAcJMYUDqf9/+6kq9cKqKDGBwvD/SFjjKiIcxYM+dwZRkLmLQMFfJjQznNElIRKMHV+B+z7kZS5GURMArlzD2qNuveRH15tFi8YIjo+NPSQkPAf1cTMdMX+pfRVRh/KdKXZaFWkT95/g6wtdcwvKQXc3nBceplfaOgmzBz7K2ujTKKbeY+Xr0ciU+bvUulhAnoLmZHngSfw6v8jt6jFJCIPGVGvifvMbsKjzThXw+YTIEcLnsfmk3HQJkd6ADWgHoZVg3VgcLiMUYAuTnSSMBLTR/IsWJXo0zMlN/S9disqhsLvbBm/vmqcg2bVKnLibuz/cCxmY6msUbD4w0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYn7y3g5INbnQyH8Zst88hR0E+O1I0Ho3MijgrDiwtY=;
 b=FDXSIJBYz+hp6IXS3VyDBCaUS9Hjb2CNPLpnOvfRv2LR3rBzeIgf2HgwfEVumxV64ympiNYQvO+uMShZxmFewfbaK0/Y2xXKi3UXj2QMcOVkJVxdnNRnZCPNw/6DeepzfSdzn+PRDeeNnuxmnvMFw77lualgcbE8nUkFXJIFtXbOzL7+IYBbVVAubAexwzxODnpzmpNlYhTALNcsNjyyXFM15aIb/3ddny2Z+uvbOVf6Nba5E2KN5m/zp4TiICWF6jwMfLfayLogbcdODwOG9wd2n/FZabz1COj/mKArsOwVQo8wRM8orUVnOQTCRhAVybDj7GhX67SiHrEN7hlomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYn7y3g5INbnQyH8Zst88hR0E+O1I0Ho3MijgrDiwtY=;
 b=Aj4E/MOk1ISUWgg/rL5VuHA03sfjxJZ24rQBCC5lg4bw/g7NP8uGW6E5hDDe/rt7vdGZQAc0XOywsHsq0r0MD+l5cqB9olf90lCrcBE5E0SL9aDj2B4wLLDM9q1vvOB/FORX1kDqzI3zLH8wwe82BZkM3yrnZ7u/TtwnsqxmCaw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:48 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:48 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 11/31] EDAC/amd64: Define function to add DRAM base and hole
Date:   Wed, 23 Jun 2021 19:19:42 +0000
Message-Id: <20210623192002.3671647-12-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e06e8fe0-d129-4bfd-8aa5-08d9367c0189
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB11877C99B08A6E4848B0C826F8089@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTM4pVhOeY/ANR5FVtz0ME+K53kPzVXX2bN4cu0Avj9aGrjl4r3flXdmTzY2Yw19Z+EmX/4RfhT22ObLRvoO3t8ut8YNQmGSifhPvhyxw7UFebvC+oVxTkrWD+ksdETOBUrgONGCSCnNBz8BZsmNvMIyllvrWI+QyFDmsM0dOXTrPc+hIM3wQJ1Vq23C/3A2nyVdKYi1j1xRG6GZEyNd5wuCvl/aWOaFhpaKJJwXMr/KtORTfCXSQ6fGUqykNi0j4JUsSmkhOBp49jf2e+ma/b0vdizF4BLak6qh9kPcUmQ9M77HeBE6E9oRoiSqT5ayVuJzh3+6/fhkJtUy98Qt3yZ4GD+5lhF2T0tEswRPZomigAUni5ac+CTaWYCi7PzaK9zbGxLo9mNudgoKqc6lJPERwKMdZn8ALlE5ZE28RWn49n/pJz0qyenk+Dcji4SnxzZMWhkH1D564mk2BVVw0PXwVude2xi5rxSS5zDot71qyCpR4x+bSyG1CKUAo2a82sB2CGzBr/8CkjtZ26Gg2zN2Dd9k5rQqPcOJTUtd2UzD1yb6D8VJaokCz++ZWwt0cmozVv0oT3IkYAQhmhGYT309jY9j4Ch5iT5HC3I7gGrBarobU8q95SHqJRfuZZoqswkS/FepiguHtVhkCCo7lNWBpAxt85Oy3HkQx9Ji9PZxUUXMr2iou5Glh8uFaHo+PVZiIjvwcsK8TCn1pz9hrpf7iFqyRfdDfzAh8MXIX0v/I44ORhRQRRK6wN3UpIFnz0bt4qT6IH+8lI1hxnMLdu1v4ZoPZfT9xeITKG6AexHl7rbd1XIOFYiiUj9BxAjQqMSX1elFU9XHQO9GpL0jAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(966005)(36756003)(38350700002)(38100700002)(44832011)(83380400001)(6916009)(26005)(7696005)(5660300002)(186003)(16526019)(66946007)(6486002)(4326008)(52116002)(8676002)(478600001)(6666004)(1076003)(2906002)(86362001)(66476007)(2616005)(66556008)(8936002)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qtRYTgDZaTBTqG29qZM4np/J3tzLNZ9ThSgy1SkPicHGOefPDujoczyDXw1F?=
 =?us-ascii?Q?h65AXlZJ2xq8Pzv2F4SnZuylrNWxlbKPCSBbh/ofHlfK5+siEiekXrLGn6OV?=
 =?us-ascii?Q?B9zYwppvA7r1+n5LS0zhPYve3w1QXtSsKuHqqWqZxmEi9ZQQti5IHZfp2JiE?=
 =?us-ascii?Q?rC2z2wYhClMbfhePzFkdDZljKUllsJ59rkx09y9qOTQECU+rSTbsteRJcKHF?=
 =?us-ascii?Q?Zv3PccrXZyhGIwY52yRWkMwRRB5/cV8XJLfnj2jDrnFvbFi5vCFBn4M9d0Px?=
 =?us-ascii?Q?ncWoXgLmMD1F/5HsMNZud5dRe7dgMDJDvUbI/EUUbuj3yl6gmh/HYz9IPNKv?=
 =?us-ascii?Q?OuYPnAJUDePe9QPsqm4vVN1RKwVaW1HFKQgt05G26IWH8oQDJbnSIXXDXKqo?=
 =?us-ascii?Q?i9PAauYWo9xhocQTNoCLRDEMBOiXQce2ScEvr7J0j0WDMu5uWkcDgMpdlP2n?=
 =?us-ascii?Q?jymzimXIFS4bzjyuB/yKMrgS9WSzqejhYexOB0S+GEqUx2dIdsitWkGkyFvS?=
 =?us-ascii?Q?iJy/66ql2RhdYFF1kHZqlzv9QgWEso44KgzQByD2hDhZQyytbvNTcOS7tiAf?=
 =?us-ascii?Q?vRyDSMPaERWTbCVlkcoUGRioIthpi83l3Jv2ylLpnUoWr6Fbqhkj2o6twEdF?=
 =?us-ascii?Q?rqpyMNSwUlfBlC1OLHKpxT8wKly29CXwM7/f3YpQU8AE/5pxNwPZg62Egxj0?=
 =?us-ascii?Q?JRIXvo6Qu6AoMsOBFzD5q38aqJkRleRIb/PPf2u8Ju3URE8fU0ecQMU40RD9?=
 =?us-ascii?Q?+ePFN+rJTPzwkcUTNnUU1RSKWT46j/APvkpYnTdi88ve+MKq+VVyMSf9YHQq?=
 =?us-ascii?Q?A5Hu1nnoJCrMmxOWT8JlvUfJPhQCGb0vjBwMv8SSuqJqTqrFXwaU/YADOfuO?=
 =?us-ascii?Q?jKdw3AOvGJL3Y45jWQulQ1OYol8A+kJ8+nUjY5rHNi+vaMvA6wc5g8jNzVSc?=
 =?us-ascii?Q?ipCMd9Qy2t9a4anoJa3LCq4+gjyXewuprvmN/dD3CgzxsirOG3xwZLdxiz6A?=
 =?us-ascii?Q?YJdZDYGPJ2ocHxTy33WcQhenxEJ/2z97LD3+sW9sMGMb2Y9P0iJTc6crZVUu?=
 =?us-ascii?Q?qxo5eF2H+TaS1+vhlu3I2Vo30H4+UCY6RCOweVsgR8lmBLAC/TMcs1FkqVzq?=
 =?us-ascii?Q?YhRhGvNh0HjXlebrHoaK4ZvYWTsflV4KQ1Xibkr+BwGMnThhL9iUXqcbB8pk?=
 =?us-ascii?Q?F1utDrsP9lFpSiDokMUWMQ9gsgNuPAqC//mZhyTI3se5IqhCHXrzueOpm6ZS?=
 =?us-ascii?Q?vyDX75yidFN8cwO8NbTgWK14Tu2x2qpQVTHBQarJAfqjzzm/3lB7YW+t8C62?=
 =?us-ascii?Q?RBzXTIBB363xfYZ1VDcIKYaH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06e8fe0-d129-4bfd-8aa5-08d9367c0189
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:48.0830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Uy9fkCjjGJQINHGYqsnDpfYZuMzU6RXUGoDAUlcQS9aspIX8NrTlcrMGO2OdYUvNfgU27gWccnQUCUVvCJXlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move adding of DRAM base and hole into a separate helper function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-8-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 45 ++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ebb82b5e155b..68c4aecd5e7a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1320,14 +1320,34 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	return 0;
 }
 
-static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
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
+		if (amd_df_indirect_read(0, df_regs[DRAM_HOLE_CTL],
+					 DF_BROADCAST, &dram_hole_base))
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
+static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
+{
+	u64 dram_limit_addr;
 
 	u8 hashed_bit;
-	u8 lgcy_mmio_hole_en;
 
 	struct addr_ctx ctx;
 
@@ -1354,23 +1374,10 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
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

