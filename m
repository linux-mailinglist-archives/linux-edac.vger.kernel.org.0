Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD33B211B
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFWTYO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:24:14 -0400
Received: from mail-dm3nam07on2069.outbound.protection.outlook.com ([40.107.95.69]:36384
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231157AbhFWTXq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9ZW5YZX3wq+A9Q7F+rl1IBIW+kE0gOkFcaIoiJAps8c2XTf0po4mZFzwZIPuCYj0UnQiOsIyXE3/8VSIAJob6jK8Q8ALu7Sn5CYw5z85xAwgPZLf25nqnGYp/wkUp0vTgvpNz2mnxgwIdb1r2QJSXKl5GPVV1xe6OJPbsD6dT97TcIkIKrKhNqRMZVAVqqmZz1fwNY84aeyrHIxwJPo80yIYkqOwtb5AO2mp7UWNo4KUqWEP6fi4tK8m6YVW5eoggfreAHHgoqXWedMzrnpQ1Sc9mpl77wVwaDnjMuEnSNbIk1Zuml4omtaiiGif1T4xmZTvt9phUO9FF7PvxWbYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BA4j908+gNCNBxG1DJN5b/45kWNOLZg47eMSvaswrfY=;
 b=nfcHneUb+PZ/PLBBdx5clvVSOhcpZFXT0ZDb1+n/mN/JV6/ylAhbZhADZfuDWs30BOcr4Dpje7kSF2c2X4taf3rYUD739o8WWd7tfXYCEKkv/rHyJUzxtYtXaaodQC+sa0POWWC4UDPyv/Vjk/22BzW/wfaMjb4D3WNhwPU9NyzO/r9U5rmDx2hn9PpA8JNNuuIYcrVPDe287HHQuF35AiJUyUGKO4zeBeE+2oDPADPH0vrmnQR3uc0HnD0jdg64XkbdGq1Hyqw22ZZN1EzpKvZSgACfjigTxw5uOpUHLrTnhEfVqg0vlwMSLm4r2aGwY/gDb7FYvx6/zNamTLqZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BA4j908+gNCNBxG1DJN5b/45kWNOLZg47eMSvaswrfY=;
 b=eoc4Vde8s7HzyYmgnl4bRkRf/XoGxe3eC5ZdSnNvrCsDSFNAOldUfBhFe+8BhxEWm+p1FlZie2yE+gPbQs1JV/7+Rq5trdBEPjnckacXxodf5+hdM99+Um93MqcYoSCG7o3x+tb2r5cCsh88fjsEPs/V9IgpLG74BFVnyE58lAs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0211.namprd12.prod.outlook.com (2603:10b6:405:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 19:21:00 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:59 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 24/31] EDAC/amd64: Define function to insert CS ID into address
Date:   Wed, 23 Jun 2021 19:19:55 +0000
Message-Id: <20210623192002.3671647-25-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74a6260e-dca3-41ce-c53c-08d9367c0883
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0211CD1976A32CE5C35E646FF8089@BN6PR1201MB0211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3R1x/DPdwXQ+5PlFT6mmrX9cbr0heio7cbaB3QqSQ6j94xq8JeHAnsbKKzYLLIAE/UAotmfRN7a9qlz7EjFmayocVMj0PN+Gb5xvgCuXP9a9+KAolLc4k4JZ35NN8Hi0JAO7Qpl6D0a/9IDmSotxSokxP1RUyroKBIOujBF2rYry63vrVuz/6l0dXVBR/rMUn6to7X6VtUgyLxwSa9z3+nI+EQ0VyqHa979xkYmLQ9xb9qKbhGqZnkDpIRJxglqD4cNU8xyu3vuETr5rKTiMaxDUFdK8KC4fV2a/zAaoozuBZw6S2nDVLnRzSn77pEN1Wte/wQllm7cfeM3A+mVlxfR/J3R7r4nGScGnnlo+/eaYVObYub3URN29r87SyWMAvt8qtEDGlGK9LHThV3MMTVsS0geIJsuBTKtQ8XnY6eTPediHbcqJHiETEFJcP9TUcRpZlEFKa8JeRhcykb3ckkfA/r2SpWta7WLdtwOa7tOG/XbPPX2DF3q5hJl9reo7zMeMLzNg4BTirQ5EXmDUR5A3sGcviV0cJDUl3c8dRqfWgLXGo5dUrX9xHkvPNUmxvc4Z77uKU9SuJZ/iRMJt+M0Ag72KuDqxkRwL4BeQ6qOZ3jyvo8o/MytBkuZwbjuD9MF4tYd2fzg1ZTw12n9J+qdzrJSnYWcQ5iisrsPT6RLRBTkc0AGGvp3hAD8wr3UOEORyq4rv/GU8Qi+PD1kdNL/KXcTvPJAzGo4sg2e66YrpSJjmvXnFBGfEjHtOQsS0UsLi+PxoXd/58n2CvTrOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(1076003)(6666004)(86362001)(956004)(66946007)(2616005)(36756003)(316002)(5660300002)(83380400001)(6486002)(966005)(38100700002)(478600001)(26005)(16526019)(186003)(7696005)(52116002)(6916009)(8676002)(66556008)(66476007)(4326008)(8936002)(2906002)(38350700002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z2vU9IsOpRD03Y8SOYT/7C+rRGpWxvu4PmqSCxBpp9B5GfzwzPL4R+RTEu1U?=
 =?us-ascii?Q?gzGaPPJM5F+Zg7NlwTcndjaFwsf5TJe6/vQnUA0FHeYy3LaFBv6VpFUMg9kp?=
 =?us-ascii?Q?R2uP/pThcbCREXi5m783iD16wCDhrX7YZRNS9xshRUQyLfV/mp8BL4tPwD7U?=
 =?us-ascii?Q?Hf0BuDKiQoR6AW1DTA4wYoKfgJjOOP6mNAO+/wJ+46TT0oPhgB4LpXm+ffB/?=
 =?us-ascii?Q?USX8ZiPiJJwudd8QafnwF6+F/VMvWmsgCnD7mJiZuBr2wRR53hD/0MYfjKsg?=
 =?us-ascii?Q?gge68MDlEnADJ4ok1pNyb9POxIBhaRF2IA3PcbXv4/I4YtQMxjEf+Oe2x+SH?=
 =?us-ascii?Q?WEmOvsp1BvgDt/0jMmR9GWmtgT054AISpq9936SCfPq5Bj4jnN4edprUAmnT?=
 =?us-ascii?Q?ULxZhFIKArnJ7VUfM1stGuxDIda3Rpwn1uFx/kKkYiJw5wO7eK8Y02DV0FBN?=
 =?us-ascii?Q?7WQME+CTD3afKNCbbXJDdNIej2wlUXnmeoYwsFa+VTQNdZW/sfpRydeHtKlc?=
 =?us-ascii?Q?0zM6D8/BsG+drUFPIJTnqbBtTIkLpN0ElFjrC2PLHBwMb220y919ddWTCANk?=
 =?us-ascii?Q?BUvUT64p9ZXplyfEEvcWjZEoEqRg+nuJPSB56LXS7MBUTeFZwA9gtmOkWb6u?=
 =?us-ascii?Q?AlkF0fGg78ugoBS6HWYlu6qU50La/2cyPae+BVCGdzFT1enbrysrZwxZ7JZB?=
 =?us-ascii?Q?TxLR3nQPMJ+bxbyKmpseXpzg5DG3EwSy/kobiz0LgnxByRpTA6qPtUasyrMO?=
 =?us-ascii?Q?H8BsqksGm3irTst0gH3+0cqwH+u0IC9wWHoWxcX+tiEFIeuhOEscnoj23M05?=
 =?us-ascii?Q?imEvHijoNK58QsHMkFf/MGgHfePzFDJlgxMlaEO0hyTjRkCA2TeYcw3rzaEa?=
 =?us-ascii?Q?FW36HU8u2TzJogr9/BAtWsW7dBGJ/O1fl+u1WuDDKRcc2udFbg9BUZ5EMBNR?=
 =?us-ascii?Q?eSzz2kDz6S7czZMzKXGOrqeWADWZSkZAgPPCNm7fvtiH261EUGCsrsgParRN?=
 =?us-ascii?Q?aOAv8gfWiwN/uHVTOc/arh7qmMNulUGuogasN3xuL9pl8+kwQchx0bmM2Rnx?=
 =?us-ascii?Q?POAl2fnmAYArTyY/RrVYIfP0U86Xo+3Gu7TMdb2dhF+8qJMomdunGt/Mj3oQ?=
 =?us-ascii?Q?WTeVR2DuyxZ2IF8pxaOpT7IO2/qe/HXuqCf1Ht2ZgiKj9C5GNWZ7nak3BIzq?=
 =?us-ascii?Q?rKj0/vxZRgOgexsm673XNviDFSQfr/HfX0nyuui2z8o1b8RM+mycwO2mOgNd?=
 =?us-ascii?Q?fYXKru6YY3afh+NzOI0VYU9O6tMQ7Iluulvi7HGqZoQ6mUXOI8RHXfCbXA4Z?=
 =?us-ascii?Q?wnKNTR0SuHQbG5w0PPHZcKNB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a6260e-dca3-41ce-c53c-08d9367c0883
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:59.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xtD2S603+HGu1KT0yYjzclzW7DLUBVLIRZinYsksZEx/CQlmF47VH3Jt4UofDeK7frsD5HeG3+fyIh2KWOL4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0211
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move the code that inserts the CS ID into the address into a separate
helper function. This will be expanded for future DF versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-21-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.
* Added function pointer to ctx struct.

 drivers/edac/amd64_edac.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 0270bf4f1f90..d09a17747abd 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1103,6 +1103,7 @@ struct addr_ctx {
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 	void (*make_space_for_cs_id)(struct addr_ctx *ctx);
+	void (*insert_cs_id)(struct addr_ctx *ctx);
 };
 
 struct data_fabric_ops {
@@ -1135,6 +1136,11 @@ static void make_space_for_cs_id_simple(struct addr_ctx *ctx)
 	expand_bits(ctx->intlv_addr_bit, num_intlv_bits, &ctx->ret_addr);
 }
 
+static void insert_cs_id_simple(struct addr_ctx *ctx)
+{
+	ctx->ret_addr |= (ctx->cs_id << ctx->intlv_addr_bit);
+}
+
 static u64 get_hi_addr_offset_df2(struct addr_ctx *ctx)
 {
 	return (ctx->reg_dram_offset & GENMASK_ULL(31, 20)) << 8;
@@ -1166,6 +1172,7 @@ static int get_intlv_mode_df2(struct addr_ctx *ctx)
 	}
 
 	ctx->make_space_for_cs_id = &make_space_for_cs_id_simple;
+	ctx->insert_cs_id = &insert_cs_id_simple;
 
 	if (ctx->intlv_mode != NONE &&
 	    ctx->intlv_mode != NOHASH_2CH &&
@@ -1333,8 +1340,6 @@ static int calculate_cs_id(struct addr_ctx *ctx)
 
 static int denormalize_addr(struct addr_ctx *ctx)
 {
-	u8 num_intlv_bits;
-
 	/* Return early if no interleaving. */
 	if (ctx->intlv_mode == NONE)
 		return 0;
@@ -1351,20 +1356,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	if (calculate_cs_id(ctx))
 		return -EINVAL;
 
-	if (num_intlv_bits > 0) {
-		u64 temp_addr_i;
-
-		/*
-		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
-		 * where III is the ID for this CS, and XXXXXXYYYYY are the
-		 * address bits from the post-interleaved address.
-		 * "num_intlv_bits" has been calculated to tell us how many "I"
-		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
-		 * there are (where "I" starts).
-		 */
-		temp_addr_i = (ctx->cs_id << ctx->intlv_addr_bit);
-		ctx->ret_addr |= temp_addr_i;
-	}
+	ctx->insert_cs_id(ctx);
 
 	return 0;
 }
-- 
2.25.1

