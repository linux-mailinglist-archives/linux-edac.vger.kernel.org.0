Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC913B8571
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 16:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbhF3Oxh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 10:53:37 -0400
Received: from mail-bn8nam11on2075.outbound.protection.outlook.com ([40.107.236.75]:18017
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235830AbhF3Oxe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 30 Jun 2021 10:53:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EATMlcTm8LrFBPSotZzwNl2Zxr4L5RQFPpbZbyQ3JrJPnqfU6Wq8BGwQ6OvZPam9ejJ8cCOOU641sPp/9blqjbXY7azjqhZjafT2w0/1YyVvjI3xYndaAKEHA4loLM4c4vVimZzEetRdAWSN8Kasgj1MHpUGwflJoHbzKBgIISPraTcdTIc3WYz/5ArWqZoN1qpsTS9f7HlZfD1Cka/iP8VikK4F06dnt6hBeED2ZnMZMZXMs1/T/o9bxbj9CifO/1pwp8CtAxfDLZ8A+a0q208+0qu8b0+PUuJN1W5rlmaNfLMb9kAX0fDnIES1ewQWaTTmIyVrjXFwgmA/JNx0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf42YnwFYxwkc8eNZdcmQMoXqc8V0ftaJjUtv9SZwzk=;
 b=R5HiiKgMTT6QMH6KIKuKJXlJdxNsBzsy22cMR9ezu42sLJ4TeUB+q+UnijOGF9b6arMnXcUWdiPL8nCATQeXIsDmflflpmcj5K0U1gq+wbFjTjHWk7faKfrognl+9qaJvWJH8+cCzas+svpQm7FU0TMCk5ODDRZHS8Lw7ld7WsL3T2Uk7MbinICAiU1ithylfRPv5SZcbDRfhNSXQkO+qXf27ccMccL6VFPiB22lrsT/cO8YbTE0EUOCUcteGWc6W2btTHBi4KqFZgGcVwlO2GmeyL5dDSqMN0OoLfomD1325yRnAw7j9Gt866pyqvjjYRS0qaBCnhcVhlpZ4t2nqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf42YnwFYxwkc8eNZdcmQMoXqc8V0ftaJjUtv9SZwzk=;
 b=N4PbXww8a0ivWUG6wav/i9A6KQPy/e9ghpcEFHaRKpkrkAn5HM8ZL2zos4i5ePYZznUjtoTO6Z2zJYr+NPFGJVOGwWKySEZZ8LoE15HY/MQR8Xo9VjxgATRrzPOb/VM4bnFvEx/j8OOJd4aZQRnGCKwO4h51vGxBEG31uOxQDhw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 14:51:04 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::8ce:4339:7e20:7022%5]) with mapi id 15.20.4287.023; Wed, 30 Jun 2021
 14:51:04 +0000
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     linux-edac@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 6/7] EDAC/amd64: Add address translation support for DF3.5
Date:   Wed, 30 Jun 2021 20:58:27 +0530
Message-Id: <20210630152828.162659-7-nchatrad@amd.com>
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
Received: from SLES15.amd.com (165.204.156.251) by MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 14:51:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dc5f702-7a76-4f9c-7e10-08d93bd67bf8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5045C9158B39528F66F5A373E8019@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzXGN2ZL2RsuT/sM4CN/UYHrQBeqXLs4Vma4yFpwdOVrS/pJVakuPi8AW95ksAuz/8xIYziuhpPoqwFmCVHm5nLR3kMNUSqTZwRQoq5WjAxCgbS7LFzBOX8jBNWcFkYwVeemzVh7+eovJFNPlA/YK/jV85TyLmF/th0S5QJ11kMsMcWeIqxf/2/tPs70ZnPjX5cS4N37i/77ywN/4pNspP+ETQKWT5sV6DCbWbNoqVlWMEm5t3y5EKVGKpulB16N1KGoExDhmLoaEwcgUxVxXbDwUMkyz38n/3XJYoABJqw+YVwO2OWwzek/IXevL/elLB1wOoSFEUpG8WN8URNvHUE47MyF1nZ//mE2H5F2KTo5i8rxyKIe9Vc4URDMFlTn5BDb5sDypowqaMIyk0r1o7LhRdObCG5b+Hp+devPYG/zPQoMMJ1zgSKNJW6HGj48Pk9Ezps0GP8T7/biyOsqopf0ro6Ddz5hAcVdwjGzvyByeh/Y13UnECQBM6AqTh4vCWgNJ1LsvmA/J2s88qiHvDLBjK7k/DjTOdGhUVH6rIfJPFLRaRiaR8Qp5gAvfS7hTHJFUEb7yhTwyOtjVfeKED0R3J33GirEL886zQ3bO3I3H9quReOWN16jHjJm6K0mepIdHIouohOFsongYoWYsN2dSgbR8zhn/2vviZ8xkQQ9djYGkpb0sbnNe2Kf2UQxbzWGs6zmOcermxW6bUcvMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(36756003)(478600001)(83380400001)(6666004)(52116002)(26005)(7696005)(2906002)(6486002)(4326008)(66476007)(2616005)(956004)(8676002)(16526019)(186003)(5660300002)(66946007)(66556008)(38100700002)(38350700002)(316002)(8936002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G8LDM2OXK0MvfjDrG5Dq7HW9pYfEnYIJqjct9bhX0fwFLZ6zKtHfR6X93jcd?=
 =?us-ascii?Q?WZu6RdlkXF7dzhZoeCaF/kReRajBGJCKUzc1vedAy+MEMPmUOSpMmvkJrkj3?=
 =?us-ascii?Q?W49Asrup3mpiAgwYnjWJSw2uOJMmdYWhGfGephn3Smv/5rIssF16ZnRclFVj?=
 =?us-ascii?Q?q5H1rlVLayLOcI5FytarCNUpXg5yDtvvtGsfuSH3v6vBYc0kUmcOZ8Ymh0Wc?=
 =?us-ascii?Q?EN2uZNyGmgoNewnJmiWZHn6W/jzJDWLFCXASLOQNK6ItZS/nSg9Dxlz6j9yF?=
 =?us-ascii?Q?uT7H1mkDP3e9vP0GpOJAwH9N1J+NswiqZvVK9ZeX9XvDuQA8tDA6r4yW/Uny?=
 =?us-ascii?Q?HzcWjijXfMADkpI7TNG1UfM8T+lQG+54BGmDGVXkqz4OC7LXBq/CXPWg2Gjz?=
 =?us-ascii?Q?Pe5NJ4RSQ4C9tBNMR4MpchJDTEMbefcFSgjWmACFSVRX3Gy6yZ+d/4l0nyFv?=
 =?us-ascii?Q?+cAwnmfVQCa53VH1cHdFuv0gUCBNJS/WCWIuR1gE/lMH6y1w0/MHNUrq5iJo?=
 =?us-ascii?Q?dk+4pJicAtAiZhEaxX+FvMVAuhoaL04ZGBkCUKp1qwmtZTsjGhgsyjv1lP6m?=
 =?us-ascii?Q?57WfFRzhtT2tpiYyiYBFCO5D8TNMNwg58gOjM7l6RWn/vM9yYbonnssQ5I7/?=
 =?us-ascii?Q?FMUylhJPMqm30PEO6KRpESlaklI44nl9ZEMhQq/DdUhNzvl0CMg40XHvFZV3?=
 =?us-ascii?Q?qhJph1bKLe+5QVihGsuaqdcagzmdQseRhsDKzgD+lJnDz/DZEAHzEmRby+3T?=
 =?us-ascii?Q?mfW1GhiSSNJIPhWg4I2nnwdz0Ngn1p8Dp6zjxPCRvL9Ql3g59vvKUFeebeXD?=
 =?us-ascii?Q?LFMRXqe0gZk44NNfnH/BkzhreaIqzkMPaiLcL5JRr9+V8bcIQ9SS4dt89nb9?=
 =?us-ascii?Q?sruXT3Pwd1wzrrPe0AvSHX9fXM8B7bCcewA21qD5RxDmMdF57E+QryBgCyF0?=
 =?us-ascii?Q?/GUQMbn3O2vTf8nwP6A+RFO8jZaOeomqx1k11sIw5m13b/FwUU+sLtGUQvup?=
 =?us-ascii?Q?vp089sNv1UPtW4uJyBi4dMKiiJkJYOFiH9hs48O+zxebrN61eRpJZpTgv3Ov?=
 =?us-ascii?Q?xKZzavEliWUmejOFY+Jiz4RqDdcNZTdIdkQwORAhGZFDTphE5ecOj3F6U8He?=
 =?us-ascii?Q?2gVC4Y/sznrZ7G7JSLYxgIPLbhorWqD60EVs1Ior6f/aiLqeSh7Ge7F0GByl?=
 =?us-ascii?Q?vFQ/Rjcfa8qMKINgVgSjdLHQPUbPyY5NZMevl1z6ijElkDR6qQDwSGpe7Lc1?=
 =?us-ascii?Q?v+ZcJCPqYJwvp2HTNRONPBuLF2zZ+5wJf580Xi3VgvaAgaIJ5Zb/9wMPbdyB?=
 =?us-ascii?Q?DiNK833c+i6wAwlWGc49OeAe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc5f702-7a76-4f9c-7e10-08d93bd67bf8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 14:51:04.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn5RK7PGV5CHk+onKIMTlL6uzV8c1YP9xiVmOegLchJwPbD9XcWHz2SDxDAxsInOJp5RAjs8LNjgbFi+EkSWig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Add support for address translation on Data Fabric version 3.5.

Add new data fabric ops and interleaving modes. Also, adjust how the
DRAM address maps are found early in the translation for certain cases.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 213 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 209 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 8fe0a5e3c8f2..a4197061ac2a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -996,6 +996,7 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 /*
  * Glossary of acronyms used in address translation for Zen-based systems
  *
+ * CCM		=	Cache Coherent Master
  * COD		=	Cluster-on-Die
  * CS		=	Coherent Slave
  * DF		=	Data Fabric
@@ -1064,6 +1065,7 @@ static int amd_df_indirect_read(u16 node, struct df_reg reg, u8 instance_id, u32
 enum df_reg_names {
 	/* Function 0 */
 	FAB_BLK_INST_CNT,
+	FAB_BLK_INST_INFO_0,
 	FAB_BLK_INST_INFO_3,
 	DRAM_HOLE_CTL,
 	DRAM_BASE_ADDR,
@@ -1074,11 +1076,16 @@ enum df_reg_names {
 	/* Function 1 */
 	SYS_FAB_ID_MASK,
 	SYS_FAB_ID_MASK_1,
+	SYSFABIDMASK0_DF3POINT5,
+	SYSFABIDMASK1_DF3POINT5,
+	SYSFABIDMASK2_DF3POINT5,
 };
 
 static struct df_reg df_regs[] = {
 	/* D18F0x40 (FabricBlockInstanceCount) */
 	[FAB_BLK_INST_CNT]	=	{0, 0x40},
+	/* D18F0x44 (FabricBlockInstanceInformation0) */
+	[FAB_BLK_INST_INFO_0]	=	{0, 0x44},
 	/* D18F0x50 (FabricBlockInstanceInformation3_CS) */
 	[FAB_BLK_INST_INFO_3]	=	{0, 0x50},
 	/* D18F0x104 (DramHoleControl) */
@@ -1095,6 +1102,12 @@ static struct df_reg df_regs[] = {
 	[SYS_FAB_ID_MASK]	=	{1, 0x208},
 	/* D18F1x20C (SystemFabricIdMask1) */
 	[SYS_FAB_ID_MASK_1]	=	{1, 0x20C},
+	/* D18F1x150 (SystemFabricIdMask0) */
+	[SYSFABIDMASK0_DF3POINT5] =	{1, 0x150},
+	/* D18F1x154 (SystemFabricIdMask1) */
+	[SYSFABIDMASK1_DF3POINT5] =	{1, 0x154},
+	/* D18F1x158 (SystemFabricIdMask2) */
+	[SYSFABIDMASK2_DF3POINT5] =	{1, 0x158},
 };
 
 /* These are mapped 1:1 to the hardware values. Special cases are set at > 0x20. */
@@ -1103,9 +1116,14 @@ enum intlv_modes {
 	NOHASH_2CH	= 0x01,
 	NOHASH_4CH	= 0x03,
 	NOHASH_8CH	= 0x05,
+	NOHASH_16CH	= 0x07,
+	NOHASH_32CH	= 0x08,
 	HASH_COD4_2CH	= 0x0C,
 	HASH_COD2_4CH	= 0x0D,
 	HASH_COD1_8CH	= 0x0E,
+	HASH_8CH	= 0x1C,
+	HASH_16CH	= 0x1D,
+	HASH_32CH	= 0x1E,
 	DF2_HASH_2CH	= 0x21,
 };
 
@@ -1118,6 +1136,7 @@ struct addr_ctx {
 	u32 reg_limit_addr;
 	u32 reg_fab_id_mask0;
 	u32 reg_fab_id_mask1;
+	u32 reg_fab_id_mask2;
 	u16 cs_fabric_id;
 	u16 die_id_mask;
 	u16 socket_id_mask;
@@ -1447,6 +1466,128 @@ struct data_fabric_ops df3_ops = {
 	.get_component_id_mask		=	&get_component_id_mask_df3,
 };
 
+static int dehash_addr_df35(struct addr_ctx *ctx)
+{
+	u8 hashed_bit, intlv_ctl_64k, intlv_ctl_2M, intlv_ctl_1G;
+	u8 num_intlv_bits = ctx->intlv_num_chan;
+	u32 tmp, i;
+
+	if (amd_df_indirect_read(0, df_regs[DF_GLOBAL_CTL], DF_BROADCAST, &tmp))
+		return -EINVAL;
+
+	intlv_ctl_64k = !!((tmp >> 20) & 0x1);
+	intlv_ctl_2M  = !!((tmp >> 21) & 0x1);
+	intlv_ctl_1G  = !!((tmp >> 22) & 0x1);
+
+	/*
+	 * CSSelect[0] = XOR of addr{8,  16, 21, 30};
+	 * CSSelect[1] = XOR of addr{9,  17, 22, 31};
+	 * CSSelect[2] = XOR of addr{10, 18, 23, 32};
+	 * CSSelect[3] = XOR of addr{11, 19, 24, 33}; - 16 and 32 channel only
+	 * CSSelect[4] = XOR of addr{12, 20, 25, 34}; - 32 channel only
+	 */
+	for (i = 0; i < num_intlv_bits; i++) {
+		hashed_bit =	((ctx->ret_addr >> (8 + i)) ^
+				((ctx->ret_addr >> (16 + i)) & intlv_ctl_64k) ^
+				((ctx->ret_addr >> (21 + i)) & intlv_ctl_2M) ^
+				((ctx->ret_addr >> (30 + i)) & intlv_ctl_1G));
+
+		hashed_bit &= BIT(0);
+		if (hashed_bit != ((ctx->ret_addr >> (8 + i)) & BIT(0)))
+			ctx->ret_addr ^= BIT(8 + i);
+	}
+
+	return 0;
+}
+
+static int get_intlv_mode_df35(struct addr_ctx *ctx)
+{
+	ctx->intlv_mode = (ctx->reg_base_addr >> 2) & 0x1F;
+
+	if (ctx->intlv_mode == HASH_COD4_2CH ||
+	    ctx->intlv_mode == HASH_COD2_4CH ||
+	    ctx->intlv_mode == HASH_COD1_8CH) {
+		ctx->make_space_for_cs_id = &make_space_for_cs_id_cod_hash;
+		ctx->insert_cs_id = &insert_cs_id_cod_hash;
+		ctx->dehash_addr = &dehash_addr_df3;
+	} else {
+		ctx->make_space_for_cs_id = &make_space_for_cs_id_simple;
+		ctx->insert_cs_id = &insert_cs_id_simple;
+
+		if (ctx->intlv_mode == HASH_8CH ||
+		    ctx->intlv_mode == HASH_16CH ||
+		    ctx->intlv_mode == HASH_32CH)
+			ctx->dehash_addr = &dehash_addr_df35;
+	}
+
+	return 0;
+}
+
+static void get_intlv_num_dies_df35(struct addr_ctx *ctx)
+{
+	ctx->intlv_num_dies  = (ctx->reg_base_addr >> 7) & 0x1;
+}
+
+static u8 get_die_id_shift_df35(struct addr_ctx *ctx)
+{
+	return ctx->node_id_shift;
+}
+
+static u8 get_socket_id_shift_df35(struct addr_ctx *ctx)
+{
+	return (ctx->reg_fab_id_mask1 >> 8) & 0xF;
+}
+
+static int get_masks_df35(struct addr_ctx *ctx)
+{
+	if (amd_df_indirect_read(0, df_regs[SYSFABIDMASK1_DF3POINT5],
+				 DF_BROADCAST, &ctx->reg_fab_id_mask1))
+		return -EINVAL;
+
+	if (amd_df_indirect_read(0, df_regs[SYSFABIDMASK2_DF3POINT5],
+				 DF_BROADCAST, &ctx->reg_fab_id_mask2))
+		return -EINVAL;
+
+	ctx->node_id_shift = ctx->reg_fab_id_mask1 & 0xF;
+
+	ctx->die_id_mask = ctx->reg_fab_id_mask2 & 0xFFFF;
+
+	ctx->socket_id_mask = (ctx->reg_fab_id_mask2 >> 16) & 0xFFFF;
+
+	return 0;
+}
+
+static u16 get_dst_fabric_id_df35(struct addr_ctx *ctx)
+{
+	return ctx->reg_limit_addr & 0xFFF;
+}
+
+static int get_cs_fabric_id_df35(struct addr_ctx *ctx)
+{
+	ctx->cs_fabric_id = ctx->inst_id | (ctx->nid << ctx->node_id_shift);
+
+	return 0;
+}
+
+static u16 get_component_id_mask_df35(struct addr_ctx *ctx)
+{
+	return ctx->reg_fab_id_mask0 & 0xFFFF;
+}
+
+struct data_fabric_ops df3point5_ops = {
+	.get_hi_addr_offset		=	&get_hi_addr_offset_df3,
+	.get_intlv_mode			=	&get_intlv_mode_df35,
+	.get_intlv_addr_sel		=	&get_intlv_addr_sel_df3,
+	.get_intlv_num_dies		=	&get_intlv_num_dies_df35,
+	.get_intlv_num_sockets		=	&get_intlv_num_sockets_df3,
+	.get_masks			=	&get_masks_df35,
+	.get_die_id_shift		=	&get_die_id_shift_df35,
+	.get_socket_id_shift		=	&get_socket_id_shift_df35,
+	.get_dst_fabric_id		=	&get_dst_fabric_id_df35,
+	.get_cs_fabric_id		=	&get_cs_fabric_id_df35,
+	.get_component_id_mask		=	&get_component_id_mask_df35,
+};
+
 struct data_fabric_ops *df_ops;
 
 static int set_df_ops(struct addr_ctx *ctx)
@@ -1458,6 +1599,16 @@ static int set_df_ops(struct addr_ctx *ctx)
 
 	ctx->num_blk_instances = tmp & 0xFF;
 
+	if (amd_df_indirect_read(0, df_regs[SYSFABIDMASK0_DF3POINT5],
+				 DF_BROADCAST, &ctx->reg_fab_id_mask0))
+		return -EINVAL;
+
+	if ((ctx->reg_fab_id_mask0 & 0xFF) != 0) {
+		ctx->late_hole_remove = true;
+		df_ops = &df3point5_ops;
+		return 0;
+	}
+
 	if (amd_df_indirect_read(0, df_regs[SYS_FAB_ID_MASK],
 				 DF_BROADCAST, &ctx->reg_fab_id_mask0))
 		return -EINVAL;
@@ -1558,8 +1709,17 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 		break;
 	case NOHASH_8CH:
 	case HASH_COD1_8CH:
+	case HASH_8CH:
 		ctx->intlv_num_chan = 3;
 		break;
+	case NOHASH_16CH:
+	case HASH_16CH:
+		ctx->intlv_num_chan = 4;
+		break;
+	case NOHASH_32CH:
+	case HASH_32CH:
+		ctx->intlv_num_chan = 5;
+		break;
 	default:
 		/* Valid interleaving modes where checked earlier. */
 		break;
@@ -1665,6 +1825,43 @@ static int addr_over_limit(struct addr_ctx *ctx)
 	return 0;
 }
 
+static int find_ccm_instance_id(struct addr_ctx *ctx)
+{
+	u32 temp;
+
+	for (ctx->inst_id = 0; ctx->inst_id < ctx->num_blk_instances; ctx->inst_id++) {
+		if (amd_df_indirect_read(0, df_regs[FAB_BLK_INST_INFO_0], ctx->inst_id, &temp))
+			return -EINVAL;
+
+		if (temp == 0)
+			continue;
+
+		if ((temp & 0xF) == 0)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+#define DF_NUM_DRAM_MAPS_AVAILABLE  16
+static int find_map_reg_by_dstfabricid(struct addr_ctx *ctx)
+{
+	u16 node_id_mask = (ctx->reg_fab_id_mask0 >> 16) & 0xFFFF;
+	u16 dst_fabric_id;
+
+	for (ctx->map_num = 0; ctx->map_num < DF_NUM_DRAM_MAPS_AVAILABLE ; ctx->map_num++) {
+		if (get_dram_addr_map(ctx))
+			continue;
+
+		dst_fabric_id = df_ops->get_dst_fabric_id(ctx);
+
+		if ((dst_fabric_id & node_id_mask) == (ctx->cs_fabric_id & node_id_mask))
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 umc)
 {
 	struct addr_ctx ctx;
@@ -1686,11 +1883,19 @@ static int umc_normaddr_to_sysaddr(u64 *addr, u16 nid, u8 umc)
 	if (df_ops->get_cs_fabric_id(&ctx))
 		return -EINVAL;
 
-	if (remove_dram_offset(&ctx))
-		return -EINVAL;
+	if (ctx.nid >= NONCPU_NODE_INDEX) {
+		if (find_ccm_instance_id(&ctx))
+			return -EINVAL;
 
-	if (get_dram_addr_map(&ctx))
-		return -EINVAL;
+		if (find_map_reg_by_dstfabricid(&ctx))
+			return -EINVAL;
+	} else {
+		if (remove_dram_offset(&ctx))
+			return -EINVAL;
+
+		if (get_dram_addr_map(&ctx))
+			return -EINVAL;
+	}
 
 	if (df_ops->get_intlv_mode(&ctx))
 		return -EINVAL;
-- 
2.25.1

