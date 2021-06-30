Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A363B8573
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 16:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbhF3Oxl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 10:53:41 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:22280
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235841AbhF3Oxj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 30 Jun 2021 10:53:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dtdh635M4whMKmP/oWONFfm76zaexsa6NqPhKQUcqAbS9Y8yiRTe/BZt7NvrQ5T895TCzjzAvGQ0OTVOkxmlxcp+qZgUZ+7Dl0zUIY3MmUxzEaDfTbIBPARfuBN0w0a8VfRZCTAAy1HXeSZJFvEd9G7ctPmBsDz0s5RJDQxEYZP3oJuxql/0VUwWd/R/d0wAqR9OwRBx+MABB0skJbMArxT9+0mAtfjumd4WRCF7w3gjiZXl5o6ECi16SEuck84UcEt8DnY6Iwjvg7Tlv8tebdmwdiauAmNSoxHn+G7jAjCLUGyU0gW6riya0/owYrXiOGANatklAE8Nwt4Y+gHC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O8cB7HQtjqvX+Ln9YT5pj4SxNrEgTgZE3McOiUzrEI=;
 b=IMYqH0s1RAvTVzlYKTNB1q9QXunIlWJuwtjVMEenVnUjlsK+VsRFtd6ricXaeFjcpmQJGwBLRVNSIeWQku1RTalmmToPavmzZu7qB0eFPKjdQBDDNCDaOJWgTVlFx3gvZi4Y/s7M0eB3qzofPqksrqcGzY8bq9RQOQVdyBq5WMXa/fygxkMPCEdqVZMDlvCtdZ7RQX62M0y0Q9PPsHCc5xCjL0Bt0/yF5Up4S0xUdkcCxHTEhRR19shrNuvlXB5dJ8tNfThhXzaNkMz5nN5x08kcgeGfDld8oC9m9QQqXNwyd4IGB4PhUWnfSibUpwHPNDM0qPzW/S99a0GRTl1azw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O8cB7HQtjqvX+Ln9YT5pj4SxNrEgTgZE3McOiUzrEI=;
 b=ETpLaZk4UAPUaL/erNM00vdKt1LUSYNaAqBHUdWGhCr21jyjk3JBntgFWxnVKoFzj5S1KRCGI2rRX5Dvfh2PEpl0CdzgQIpLVGDzd1QDJjXhUOQi6V7c502SJ/PI4WHUS2NRW46KuwIGXHPDlqLIqeMLGRIvzRleY7NHXEcktY8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 14:51:08 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022%5]) with mapi id 15.20.4287.023; Wed, 30 Jun 2021
 14:51:07 +0000
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     linux-edac@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org
Subject: [PATCH 7/7] EDAC/amd64: Add fixed UMC to CS mapping
Date:   Wed, 30 Jun 2021 20:58:28 +0530
Message-Id: <20210630152828.162659-8-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210630152828.162659-1-nchatrad@amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SLES15.amd.com (165.204.156.251) by MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 14:51:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc05cf72-8c32-44d8-e615-08d93bd67db7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB512543CEC1ECA1FD0418F056E8019@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLihwZyDGin7VlxY46xHhKfn914jm4eaa3BmryWY81LWVBpVIiiwQyqbA6a0EFUjEUD4MMu+fq1Prg4umJ0UWToBbkx17fif/LYdksCAA+y10zIK5IDJfRbPpquh2U9DADJVY8phz2MgOE+p5ybX3dHW22S1pD02JPq3T6V52pLn0sSEhtqXmTZppVUWXITx4V3H/gWf13HgDWJXHB/YsZDxCeVS1dKhv8FLyFuhby+VNqfxzpSAcTMC9D7ekaHew7ZvKpbHV3WQweEH1YgP9n/0SwJK0nQe9aJez8BCfUszawciZqmZkPZVt7DqDf3T3QeXKdw5F1QTa9VfdHlkV1894bp6UvlqSy1Hgu5cuVeDzm+kFCVqRu8Q64F60Y/L+Jmw9VaTTCYqNTkcBoQGqwc4Mvux1rE56nMmU4n4B5gqyrGiStiVI/iRkbHaJ3ThMGIvsXoh5jif9zWU2mNPE/ojagEreiUb1jVxXq98++Iwgc7aCp6tjturjeW7o7X9vQx4jM6pV5hdo6jqQ9T2BX1DewfofwaffPch1ozKNCj1todJnSHV9pBUdS1V1DYU3fpkfvKoz7wxaMJs62j9jD8eH/sBwRC/To7LCib4Thtb0R1myyp75fY/foaLu5ym/Li+9G6VXhVEmBsGODuQY4E9C5i4pShZsy+LblqORAmu0NaUoVm9IctyBEhuWysNT3Bf8WBzSUNRvkO+1mfCeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(66556008)(52116002)(7696005)(6486002)(478600001)(316002)(6666004)(83380400001)(2906002)(38100700002)(2616005)(956004)(66476007)(38350700002)(4326008)(36756003)(8936002)(5660300002)(16526019)(1076003)(8676002)(66946007)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1I30+ExEZ8e12IFkwkjJVAaEhajhRa0BBxyAnMtKvtNF7NHuRA9FaPrss0bR?=
 =?us-ascii?Q?uI1FhGoD0c2QOL5m/Yq767HdFC80HxwrRp7NbWBzg0KDPOCQZTJ+MFoMk9OD?=
 =?us-ascii?Q?kgleDAk3XR7WomOt6d5Vd7Fdaf6/xuKz1zzM0sZf4XAmv7VCl9RYeL9FhEGv?=
 =?us-ascii?Q?K+TD57Ec87TA53+WtSc/eN3yeaKoiSkFUqPJzi0dD1fnCyrNvpFXKbiM+NXr?=
 =?us-ascii?Q?01VLry+n6MRmRDZqtdmS2+LdutKk3yLtUeeVKcpAhHx6Z7rUg48h0gObhFp7?=
 =?us-ascii?Q?xjZAxalqmQjiMp/xr1Dm7UTyaqoUKH5/iGPTL/y7qBAlxs77epywLXbF0teA?=
 =?us-ascii?Q?CkdmK5E6Gb6rtzQlwx3MB0u2dpppoGKdOLpJhonqSCaguJXsYc2Gw3CijFJu?=
 =?us-ascii?Q?WtKna3XI6e8W8JRkcwVy8dQGZS6+iGXEGf6uwh3bKvpqsvDzWgxk5fPOY9bG?=
 =?us-ascii?Q?7InRdlT4tzvoVjTifU9GyVRMAkzJ8zQqYe/bAvI6QpUz15ZXxyP8l3O0sIOO?=
 =?us-ascii?Q?aESP2pb2VxTYUr64fHaAVCW93swworgwU5lXZtl6skJiQtTmPyfu2MuFrTXB?=
 =?us-ascii?Q?usmQTumGOVJvKrRE1iKhFUcttwXMrE3rjTyvJCGOcYerwUgHKyPl+45LMRZH?=
 =?us-ascii?Q?lehyqi1cS1+whiL2YFFILSzxHI8Msex4cBYAds3ZzlS93gs19VW8y5Nw2mE6?=
 =?us-ascii?Q?9PlevuvsB5R3IKalUn9Il7X0LaKWYBnCVcauYCv3J5k7S2rtRV0dWZvF1Tu+?=
 =?us-ascii?Q?ChfYd4QcAgy7vN28tsz6PEatOWaF8QVTg+Va3QwrBkm0QuK9pvyAALilwGRa?=
 =?us-ascii?Q?AEYfNeGgXKbU2XEQKVIyQyrniKDXYjv7tJqIF6UK5EhEpsj/MsA6ZiqMLnwt?=
 =?us-ascii?Q?ZjkQK9qD/PAU9rm8EZmd+7H1Ao6vV6s+MxbcyWbbrEFCeS3jwt0rE7RN7Qce?=
 =?us-ascii?Q?1Ao6IY5UAVlEQdiJYgbkRLNkGsb2Js4dek9jMHkmTLNbptgJeLbr22lbcCsx?=
 =?us-ascii?Q?aOO7noCt+pN6KBkvjncGvIlES74jYNto/NutZn+RKa81RSmkHcPO2zka/c3V?=
 =?us-ascii?Q?JcwUImJLf2enDGtg6bBOWXVPduNPlB2blC6EuLZwkZx9uFsZLcwGGjndhYsR?=
 =?us-ascii?Q?itz/XsxZY8aDcia4XDS9Uhqx36ZXte/hIWz389Lj/RG5bTibZdUalSsArqQ/?=
 =?us-ascii?Q?mBOuiDf72/Rfp65TSROgwMzHgzyuIuek8bcVczcVk9pbmZojzpV8ytdmYzNR?=
 =?us-ascii?Q?td5ZDokNxR6YUMTINCse5sAVp9HvnnGncxHx7htuyfrcCwitqK0Fc841+wA2?=
 =?us-ascii?Q?N1y/47C/k61hJU4nLr62+vdt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc05cf72-8c32-44d8-e615-08d93bd67db7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 14:51:06.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +A5uYGLyzTLZT7rKOpzH8CvTrQpn3fHhl1W2gbJsvJWxSNSxsOoBtFvAFsacBuijusWT1LqiMXHgS9VOFsVMPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

This patch handles the UMC to CS mapping for Aldebaran

Aldebaran has 2 dies and are enumerated alternatively
 * die0's are enumerated as node 8, 10, 12 and 14
 * die1's are enumerated as node 9, 11, 13 and 15

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
 drivers/edac/amd64_edac.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index a4197061ac2a..3416699fa7f6 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1562,8 +1562,41 @@ static u16 get_dst_fabric_id_df35(struct addr_ctx *ctx)
 	return ctx->reg_limit_addr & 0xFFF;
 }
 
+/* UMC to CS mapping for Aldebaran die[0]s */
+u8 umc_to_cs_mapping_aldebaran_die0[] = { 28, 20, 24, 16, 12, 4, 8, 0,
+					 6, 30, 2, 26, 22, 14, 18, 10,
+					 19, 11, 15, 7, 3, 27, 31, 23,
+					 9, 1, 5, 29, 25, 17, 21, 13};
+
+/* UMC to CS mapping for Aldebaran die[1]s */
+u8 umc_to_cs_mapping_aldebaran_die1[] = { 19, 11, 15, 7, 3, 27, 31, 23,
+					9, 1, 5, 29, 25, 17, 21, 13,
+					28, 20, 24, 16, 12, 4, 8, 0,
+					6, 30, 2, 26, 22, 14, 18, 10};
+
+int get_umc_to_cs_mapping(struct addr_ctx *ctx)
+{
+	if (ctx->inst_id >= sizeof(umc_to_cs_mapping_aldebaran_die0))
+		return -EINVAL;
+
+	/*
+	 * Aldebaran has 2 dies and are enumerated alternatively
+	 * die0's are enumerated as node 8, 10, 12 and 14
+	 * die1's are enumerated as node 9, 11, 13 and 15
+	 */
+	if (ctx->nid % 2)
+		ctx->inst_id = umc_to_cs_mapping_aldebaran_die1[ctx->inst_id];
+	else
+		ctx->inst_id = umc_to_cs_mapping_aldebaran_die0[ctx->inst_id];
+
+	return 0;
+}
+
 static int get_cs_fabric_id_df35(struct addr_ctx *ctx)
 {
+	if (ctx->nid >= NONCPU_NODE_INDEX && get_umc_to_cs_mapping(ctx))
+		return -EINVAL;
+
 	ctx->cs_fabric_id = ctx->inst_id | (ctx->nid << ctx->node_id_shift);
 
 	return 0;
-- 
2.25.1

