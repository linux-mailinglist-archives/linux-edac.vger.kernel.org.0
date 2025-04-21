Return-Path: <linux-edac+bounces-3596-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1C3A953E5
	for <lists+linux-edac@lfdr.de>; Mon, 21 Apr 2025 18:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21099164DEF
	for <lists+linux-edac@lfdr.de>; Mon, 21 Apr 2025 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DF21E1022;
	Mon, 21 Apr 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YLtLCmT6"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0891E0DF5;
	Mon, 21 Apr 2025 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745252097; cv=fail; b=o+OY/8QNY16c8AxxNzPmkDVOCBqxX06IykIY3rEsxx7WjWEoV/QwVSYUa6Tufn4tB0Sjd5xp3FWppbN7rYZRzqkM0ykoTyC1ix4DV/QasNYA3uJTHXH301f0+hzPwx2ZpB/0pCoo5FLiDhh1gMBJG0oa7SeSxEmsxOtR1VEDcPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745252097; c=relaxed/simple;
	bh=ANaGUvEHSKPWs69bAzL1d7Dwt56NETjbR8xT/0Nu3kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cql/vu1NmxB+Jaw3D7tLAHDhIG1JDRczuwk0/7eEclxuoZ8P+4y8NbEEHBl8kztbQFRDQQV4Ib7+v6Du4SAlhreXSja8Dwk1vSxzCI1BMccRBDnzvRVQlMJMwtQQmMJy9W9Rqm8AyGWw1pJ33Qz8YqDrZCnj9fPGztKVaOKZPIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YLtLCmT6; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsDtgRpMHzevKEH/8LgJ8V+9TAh0EYqUMnw7ypmGuvSF1r6KKP6R36ss6nnqGjmo6N43VKOB/PheShL6+DnZf0OFx4LRj00IKJlFnkRIoBn3s5s243lYXyF5pIecAxAgZuT/yXrJRuE+fv80YMVBvzzmXIKXeylNMPK1Yi7zZj36k//Hie6HIStX2HBAXtmfSmHkCfW9PEMCdkr/PXC4yGpiX4Uwwrygjy4oR8A6Qf6EHnLx0kyOjwgAHBHaXEURtrjK7kOwABsCp3d+uXsQ1dJ/8nnDBGV4fWeyMLjotyrDeN62pm5b7DgmvdmSZpAHbgjLuKnFgrjlROFBRIAdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DL50mT1gaaVZMn9cVhe/mBi3wPaeqHM5aHh1C+OtbtI=;
 b=XLXxIxRW1bMpJ/xv3rcSDgEgPvlrDEMetp9dUtLv1utbUimvJBKFSm9ox2hTI7ru+I9+GCiqFPSkMpR6a9S+FQJwkTfpxW1oeTtqpsiKCoOcO26LWsSTqnzNhz7P33MFV84yoEx138wJ2ROiWLWsD5O5rjMg+Qx0J/DFsBP55iH2gwqqfQlH/7kjZtdlyrd9NQq4VUx4qCUHPECHIXUKP3jBgEwX4p+ianHgWdC2bIkopPpZCypCIec8+sG9uQjLILtsni1DUr6h+CBgJSVbU3diBy2km0D871KB6KRegzn1guZW+3X1IGUrplHHRSKib6b1NP136Uc9Cb0u630Bzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DL50mT1gaaVZMn9cVhe/mBi3wPaeqHM5aHh1C+OtbtI=;
 b=YLtLCmT6xSGNd3IwpTc+tl8aTIEr2Oz1LcXW78LQlBs/Wmxan7R4a49SAlJ/7ADHNoi7470g61Fxz073BQo3s9Q93swHoBfDqqDd1IAfEpYTwp8FUVOG7W5FU3bl7Ww9yxo//rXfdVY6VXKjZTwJnQj7L6rpgU0Vx86gLxGJZ/yPEv6M1+vfPGzvGuCxrsIfA4qOeOsbCEDAW4VeHTIsqqR/YMAh/E054xf/GQiex1olPaxNp4ufG4w37zT5Zij0UApYWqV6IeyaANbTBkrlhKAciP4PR47lzkkk4yRQp1rZAWq0vIw+EAB2DwNZ/QSvqVsfuZ8T5yOA0f9yWCfsVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by PH0PR03MB5800.namprd03.prod.outlook.com (2603:10b6:510:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 16:14:52 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 16:14:52 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	tthayer@opensource.altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>,
	stable@kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v2 2/2] EDAC/altera: Set DDR and SDMMC interrupt mask before registration
Date: Mon, 21 Apr 2025 09:14:47 -0700
Message-Id: <20250421161447.41886-3-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250421161447.41886-1-matthew.gerlach@altera.com>
References: <20250421161447.41886-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::19) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|PH0PR03MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 21517120-84b1-413b-9eb5-08dd80efa5ad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HoHNGz4efjFsk6TsBfVA8yCgeFh5NmP6p7vdHaJNg9LAdVvmThJAeUEl+zaU?=
 =?us-ascii?Q?3RVARugrUD0GEJ6NwdJ/DlnJ4w623ENCCey54Q8w5SiPv3T6X8p8bH+zy20x?=
 =?us-ascii?Q?0YCfIYB5AIDnmzF8oDffIRJi7Eg4LWvv5dCL4/7SuxzNe6w3GDBhlT3LnYz+?=
 =?us-ascii?Q?CWJWZ55E2KPuS8xbatJXwU6kadOiql/+fMxFSbhFShs1b47PSu04+0ofyzWt?=
 =?us-ascii?Q?B66ApcOr4L7AWm8RB671NewtxWGDMYrYQSXIonOXUjRcZjC4/lc49jJ0GRFe?=
 =?us-ascii?Q?o5rkiODkfBetw5jSS5+XIZWA4tR21jZ4qiynnKyJ3excBZpZ8elrH3ZEi7j1?=
 =?us-ascii?Q?85+lUheKqFl9OTVpcaVAGTKti6xm7k3PWQCId5dzO1BIToW7gU9OKvCzS1E0?=
 =?us-ascii?Q?+ExlaaynWzmEGcT1+m1j1xTdZsdoJjJnK4uj31zBbSmtExYEy////dqvdS9R?=
 =?us-ascii?Q?t+Ny7PV134b8dKrLe8L46nt57rUmMjRcGKEGFEzuDvILQtRaz33dgdcRTgpr?=
 =?us-ascii?Q?HWhJOOzacTvrI5gUHmzyFSGw8UykLcipy9Gv4WstIvKu/r+87E28UTekeTpj?=
 =?us-ascii?Q?rD3q90RjoSc0Uv+ZYUzReTs+2r9eRe4J0SgYgfVqgmUWLFgozPznYfBap69X?=
 =?us-ascii?Q?HB4YU0/946SmplHryVt/71Y2I1sAUhJvWjFcSGBxOAQYXWwy8f84gljGCPq+?=
 =?us-ascii?Q?Gz6BkjO7nlXSthD32ef5IDJWiawTZLk0r1Mfk9pqlBukVOd61d3sG31D2VMC?=
 =?us-ascii?Q?F/5IHD+4ROrRmImHH7eF9YEH2yUUCd+bU743lVyK0qUBtkEwHzQRG8RnBp37?=
 =?us-ascii?Q?VZSq9SBcggnFdx16AXtBwVHYtj2JA7v8DuatcbGaPISb30uIwib4t1aojWEH?=
 =?us-ascii?Q?GZIYOsHci7aQ4BdTaC9GcsI47AzmWtRS8N58RGON5CCH7fHm7Bb1CSHtpYrH?=
 =?us-ascii?Q?IPm2byXtkqkxH3TQXlGnfHFLWSF9xUE77OWq/BQQiuCeGpUHbNsWdF9+TDm2?=
 =?us-ascii?Q?CVgD5QVPhZKtaHu9a0TDFslSYR8W4yix2jS0eDFDB1E0FapKCQbaU5HE5I6J?=
 =?us-ascii?Q?KlXKbpzJS1ddYAvlLAe9WORDuYV/J6gBnM3OV9z3gDx6Hx/5OmRgaxiv6wxe?=
 =?us-ascii?Q?DGltq/ArolyClA/S+N3AE70bJ2zQASTDdMrJN5l0XhpjjHlRp8ewKBBH+B0K?=
 =?us-ascii?Q?s/U92CILwyiR3R9CG1tTHxVoyK7Yfm+ygnDv0pQGf+GFv2lJZAme55HMHGWx?=
 =?us-ascii?Q?+zShCBZ2bofC6oLJQRTcoD4Ria6vrQA4IGpctjfSDndpSMUw58uyc4eD0FKW?=
 =?us-ascii?Q?ybD3qJgXtbuZ/Muk4zAozBrvqawjLZArDtLBm9rWvU9nZoMxtwx+cv3zTpeP?=
 =?us-ascii?Q?3u2U8b7GnnOU+D8wEwS5GV888bAlAqXED31xKG+PeZnZ5pJgjh7/YqZ7pCUo?=
 =?us-ascii?Q?bdvHGxQLYRk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IurnQOLZDdW8pCDPKe+8Ccr+vNCZwOa1Z2J5rvbbZ9cWVWkgRgSbHlGPCdJ3?=
 =?us-ascii?Q?mJ7U5uLzxD+gvHTDyJ54/U09lhDIHoqFP1iYWvyMKNHZMdcLrWgpbr6u36cr?=
 =?us-ascii?Q?/SnZnpuo29euuUapmc1JY58DQ+kupWjJ/B5/BWOUvS6k5vRO5oHP1Bqc386B?=
 =?us-ascii?Q?3Mda/kMCybC7oMVzttNTR5BrU4rZvCMV8DL0iX4YICbQGQxSvfmtMIN41Bu6?=
 =?us-ascii?Q?m8Sq3aJ27TmwYUohqyI23zHK0DuVEvglOvsJeIA4EMB+7gIRFWiEpzZBZVM8?=
 =?us-ascii?Q?1rww+GVcB2PHXzh6zROg/jBUCMVCsNPYiy3tWKmeAhul1siXciVWLEIyO2o1?=
 =?us-ascii?Q?d+VBHHmYnKx9QvhLilEIINrTGy0/kHfF0U4RDck9QVfJy3LMaQXOSqwiyLQJ?=
 =?us-ascii?Q?VMGw55LxRv7nE7ljXOXUal1DGne+hlh1K8+ekMH79mDwXnN/9H3CCwRHAWtG?=
 =?us-ascii?Q?KR0W6JGC8Di187LtVWS2AdKrkJZTDtyqOEphGLqf1fLWqYCx89d+Lg6B+Tzh?=
 =?us-ascii?Q?iIFVAt82+xFG8y1yle0tAUTtuisnxDHRLAQEQ6BzDi+DzuqzgphACJRe4zcc?=
 =?us-ascii?Q?MkF7DCgIeEcX/5AYxzq0O53rA7GVN+x9s0gm8UpAL0SDWQ5n8m9Lmc8EtOa8?=
 =?us-ascii?Q?3HmS995D4rZD/xfPVVnrv2hBW39EzE6Eu8OK4+qw860g6Wi4kZLKrbWbRk62?=
 =?us-ascii?Q?JVLb3vFtm3m47gCBF/XTz7/KMDWNGfertYVi8RN/u7OTq+srxY/vP7gGpevy?=
 =?us-ascii?Q?Y7xZ3xU8X0AHgeJ8pPCVIcAHxbzjhNxqOeDlKD7cS+TDayDKDTIxXOLl1NYW?=
 =?us-ascii?Q?E5ErJpacZXitmbRGtoWWez14je2EULwEC3SKjz8Zz1p+t19DMxHpUwpmQS84?=
 =?us-ascii?Q?nyPSIQylbJOyWpxo9ZQ86XJVvFzygOT0JAmh2Aga0KBj+1llKSqp7WPmPlg1?=
 =?us-ascii?Q?aCaQhSpGuMUC0XzY0NFYTsrx+InNqrZxWz4MjZ2UijSv8Kp4OAiHOqY+CAzr?=
 =?us-ascii?Q?1RxCzktUMeHNAAicZqH90+XXMIzmcI/xztLEaGtIuY/k7dvRqjkHoNQ727/K?=
 =?us-ascii?Q?rGzwnFDDu6KbKdnhQsQ2HuWxbjjO7zYeT1WbL4dI8vwxaSoLMC4o743+Jryr?=
 =?us-ascii?Q?RPuVcVFS3QgmOLjshTYiBft15FUQWjwcyBinfsLtS/bYfmGi53F6BcFes6Zp?=
 =?us-ascii?Q?dEkP/xFoVPWxup16Ia8ZwSQKW3Yk/jUHj2jzMfd79m0A0TVWJr4+6nO6JkuC?=
 =?us-ascii?Q?EqIg9T205lSF7Xfd4nMjJmawYPVfjdGJEZXNJrmiDelQlaPTMx0a8jKncLAW?=
 =?us-ascii?Q?xQ8BI4sUvW5sv0d6Kib5/rqAM/+ysWv36OQM7P8VqhhvFknscpd6uQj/UQW7?=
 =?us-ascii?Q?vSkMwrcvXibRjsec/lnGbxzlUSm6gs3k0BBiHm23T+ACFCI7VM1bHmzGm96k?=
 =?us-ascii?Q?/AWcjWa1RqL9ftdUGBCtAyfmbxCCjiUjaL6FLF2u30bYFvKRnaHkLLdPt3hR?=
 =?us-ascii?Q?H1o6YT/NziTlACjZJtkC3lEGw0y6xh1xy39l/6vgCtBDNMcLxQUFevc7jFW5?=
 =?us-ascii?Q?IdnMcVzZzhyKa1ZaMKrdbFxAUQqPkcmGJm7pgS+04woEHoVSEnTv/HiB06Tr?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21517120-84b1-413b-9eb5-08dd80efa5ad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 16:14:52.2830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCKA4hi0z4SpryDw8Pj+noQ23IJgYU4qYWG7uKZzvb5ENAwjtPLAvElfqzVqUNK6IKPOagP953rMN8JbWChHpb1fLOEEF2Z6LEXuiWeKMtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5800

From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>

Mask DDR and SDMMC in probe function to avoid spurious irq before
registration.  Removed invalid register write to system manager.

Fixes: 1166fde93d5b1 ("EDAC, altera: Add Arria10 ECC memory init functions")
Cc: stable@kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
v2:
 - Add Fixes: and Cc: tags.
---
 drivers/edac/altera_edac.c | 7 ++++---
 drivers/edac/altera_edac.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 88d9d2f458ee..dcd7008fe06b 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1005,9 +1005,6 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 		}
 	}
 
-	/* Interrupt mode set to every SBERR */
-	regmap_write(ecc_mgr_map, ALTR_A10_ECC_INTMODE_OFST,
-		     ALTR_A10_ECC_INTMODE);
 	/* Enable ECC */
 	ecc_set_bits(ecc_ctrl_en_mask, (ecc_block_base +
 					ALTR_A10_ECC_CTRL_OFST));
@@ -2127,6 +2124,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		return PTR_ERR(edac->ecc_mgr_map);
 	}
 
+	/* Set irq mask for DDR SBE to avoid any pending irq before registration */
+	regmap_write(edac->ecc_mgr_map, A10_SYSMGR_ECC_INTMASK_SET_OFST,
+		     (A10_SYSMGR_ECC_INTMASK_SDMMCB | A10_SYSMGR_ECC_INTMASK_DDR0));
+
 	edac->irq_chip.name = pdev->dev.of_node->name;
 	edac->irq_chip.irq_mask = a10_eccmgr_irq_mask;
 	edac->irq_chip.irq_unmask = a10_eccmgr_irq_unmask;
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 3727e72c8c2e..7248d24c4908 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -249,6 +249,8 @@ struct altr_sdram_mc_data {
 #define A10_SYSMGR_ECC_INTMASK_SET_OFST   0x94
 #define A10_SYSMGR_ECC_INTMASK_CLR_OFST   0x98
 #define A10_SYSMGR_ECC_INTMASK_OCRAM      BIT(1)
+#define A10_SYSMGR_ECC_INTMASK_SDMMCB     BIT(16)
+#define A10_SYSMGR_ECC_INTMASK_DDR0       BIT(17)
 
 #define A10_SYSMGR_ECC_INTSTAT_SERR_OFST  0x9C
 #define A10_SYSMGR_ECC_INTSTAT_DERR_OFST  0xA0
-- 
2.35.3


