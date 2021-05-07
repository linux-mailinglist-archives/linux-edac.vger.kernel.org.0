Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972DF376A67
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhEGTEZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:04:25 -0400
Received: from mail-eopbgr770081.outbound.protection.outlook.com ([40.107.77.81]:44439
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229959AbhEGTEE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:04:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpS7lik5PCYrPcwpHQLSm0cIz8gWghpJq4D5Y/WwMrx/AthurJUVioKG2yY+QGzeIrO+8BIUMWgRyqNndij225hEVK8qjtrEfLhn/KpEzrJVQct3LYkzrUY69oLpnQ4XzkKf38G8YlYPfGEO1yHR3z16cr9AXNAweIQ+9KMcTyDV9q6uXXZngYi9npDmHPPYqfnrEEPmY4BhiIfwGlw40urPb3SIyAw+z0wtdX/UYH/ePwPrzZ4kEMvqhrhVyUPFcbyHA6KqZ27SN33XFB94tirHNOrq/23/JytG6wuVMNMKFaM05U8cye2lRqG9kVxHGg1Ojn64VT1nyHgJ1BBoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVJuVnaUO0EaYvsywS/DLGdSddCKhRrydBtnIfckj9A=;
 b=oWngVyIJ/2iFViQ5MO83QEmqZPMNHxOJYzpYDbNaYoJSqzU57sdaoig52yfyBJaRWYk2HVq4s0sAI+0YSwqV0hCsOP2NYIdii0j76Q4/oKKfFUkho8+nZQwXzrx9Fsgu8hUqBOT+u2ELkuLApB0YI4WtRC7LDwgP6zUthtOdWMr/ZtUKpKrC5zetqRqChlqXYslRSKXYtuauUKeBPF6uuMpOzAAZC9qY47D9XrwYWrGlTC5RXt33iok1uoR3LfJXMejiE1+jyE9N/L69pp+yOn1SBFY6NV507znAvLLQdFhtpVNvE7HUNsC5nJiWOR4AYOZNrRRIQUghyDu0VlhEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVJuVnaUO0EaYvsywS/DLGdSddCKhRrydBtnIfckj9A=;
 b=SwCR0BlZ/uRXivL0037RHoCt7bmrh/ghbe8mP+aU5RBw3U4X/2wfiHl9qVscN2OIA29R0o1nmZXWB11FNRZbMcAGdGgWJtqRF2K/PXD8/ddDwUXARLXMt8yoaXa9div5Fh+vS9ElCtA/OYQXsbxevBMpDNPoAcGoTIM1mvUzMBk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 19:02:12 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:12 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 19/25] x86/MCE/AMD: Define function to calculate CS ID
Date:   Fri,  7 May 2021 15:01:34 -0400
Message-Id: <20210507190140.18854-20-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70692758-4437-4031-50cf-08d9118a9f2e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1620713D483ADEB6991CCA85F8579@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkOIxHcpv4+7leYN24E9R0d+WnQHdcVd3fYAnoZLZwwNSeT5SzS4otGyjWKITEG1I+384ydwYxuQ4QW82fQoOv9FLbqkpCTe62qcEnej4s6vXrlFS5GlHMRwk0PB48QYs5N8bE2urB4Lp7iOcTCuM23lN1z9UHUu09xxzdAX7JtzytTuw8BaAQJM/tctN2oxafRmSxH1Ikc9RkG65KAuBvpn4G7PEuVFIIthLJ11UDSWUESpFzqADumG+AE917CL9N17Rv6fpBHSqJNno987beIxZ00iFBxDw2HmLIY2u7KaHYiUqJ2rY5EMAsDBviAiaLKXEsp3fwZZtFDughOyLTBRzzehOkmeOj8+6uDdtw+B57+L1HXoDzUq2fKE9gnLSR79ZhmRNaNDZEMQbqELg+AN3IQPbd7zgzDJJh5rgxPCwipGw/4o2e4GG65M/Jo0Pj6zuoaTtLJdU+nkg4HY1weEtLbc1ofHP1ju2g5s5hO/c7YOQ6lrALtqq8XhfKKJixqcStjmrcAYLMxclJ6kTmaIFIBsQfSkkSe9sra/Yv3yb3Hq86AY7ybpRBeOAsjbgw0U5PHL+gaeUkpDGQ47TxkwYgUjz0fEmHsbKmX54GCHRle0KJMZyamvljjUqzKV6ZFiY+Knh6S+FipVARrqEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(4326008)(6666004)(38350700002)(38100700002)(66556008)(2906002)(26005)(6486002)(66476007)(1076003)(16526019)(86362001)(6916009)(66946007)(2616005)(956004)(186003)(5660300002)(36756003)(478600001)(316002)(52116002)(7696005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HCRpPMSpe6mzYTSvK1VIbp6TsXHhE0zaBZPihX2tcd568hXVRlEy7dYJ8Oq4?=
 =?us-ascii?Q?wFiofbg8TtTyq4h1bPg0Z/qEJ5lf9/dslMPIpc0ft0OcKj/hEXKzQOGnXRsv?=
 =?us-ascii?Q?4oQUthBPNJclZyF+6qG1SE3c/zEjpEk4sy1bg/A21a7UPo1FKWnfL/9i80ym?=
 =?us-ascii?Q?aY3F8aGuCzMnH1ksxM8SN6XaKH3CjFuxKETqxJ7rI28OvNgxXqkO5gxC3/T9?=
 =?us-ascii?Q?YMqDqH01O673CfTln8WVHc7E2PMsyKqpu8GMWQ78XlYvnUO1e9CUs9HPzjYP?=
 =?us-ascii?Q?cjY1KC1k+bwc8GEJ7gJAh4k5lhnp56ZZB2yKSoM74FvJNNpSatYYBtoX3SrW?=
 =?us-ascii?Q?FWxG+icAlnWb7hlMyLRuQe7funRWALHWbl11kRvj+25aa/w1XKdAv1pKnPYK?=
 =?us-ascii?Q?X57mOylNeIqSEYdekdvyYUxrBkcvB9Z0bWVoOBH3eVJrcEkA24Mqya49o98M?=
 =?us-ascii?Q?YOMlat185P8hXcDWeai5WpHXfMf8fcEgibrDt7iO99t4jeE7s1TphI+ElvTo?=
 =?us-ascii?Q?u6KSp4x6GRyw86GlnO46uGKMWa9jJ5XBgVLVGDB+PXX4zfZV8fc598+O5m4Z?=
 =?us-ascii?Q?DXyhUWD9IPVaV5jWONwvriRNhAuHuLOSIooyzN+7zuPfSIACBP502PRstV+c?=
 =?us-ascii?Q?Hn9Iv1WmQjUSJ9YkQaoXqdFuCDU3sonyUUS5ud8kJdr10AXFAusHl9830DFK?=
 =?us-ascii?Q?XBthzhVmQJUnEDQJXiqBpCuPyeSews0Kzgajlj4E3nwb1/Inj40e8zM34Nx5?=
 =?us-ascii?Q?Ch3tG+t5kNESlvCJFQl0/rsv4qn3KyIuzBBbQRMDJF/m3h7omoyOUhPnK9eQ?=
 =?us-ascii?Q?VLZxBXDZI8QfLMA4wfJFb1WT5CRCGDRKorfLaSmlzZOzcq/r4EDIwspbG5lp?=
 =?us-ascii?Q?v54A4UEMxwGyYCR3tIRwZfZfjAwGEMs8ulmXDDhTT94uut00pbgAJ+2Otz+t?=
 =?us-ascii?Q?ym6erySHYSCbDttJmljE/BNDAmw2OUUCRSXenI46oD0CziViOp7ZSdb009Ua?=
 =?us-ascii?Q?YgfxPFr9s5cVB6nGNRAumGQG/Xb1Y2VAVeoz+v+jfO1dIA2iivphmR5zgh9q?=
 =?us-ascii?Q?bul/tEI1c22wWKUu0j2MgmfOvtnqY4zASf0CLORlE4yDaBqpZQMYq53Zm8Hh?=
 =?us-ascii?Q?7A2bD89BPWVBkeSwWKP7iQRax+Y7BfTnoUw57WC4oBrB9Tc1pLFIA2a7JbY1?=
 =?us-ascii?Q?5W5YT7vKx5nU7+B3H/6f16Key7MLWRBiSpx1Kn4FbztjeNTXmEh1vATBd0cY?=
 =?us-ascii?Q?iQMbU2ujBKToBZrYV2T3di3x6dLduxwOjpD6miOdLy0an0QFvhDDCJTE1NwI?=
 =?us-ascii?Q?0r+yGNJU7DfQOop1xb3Ykkw4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70692758-4437-4031-50cf-08d9118a9f2e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:12.5706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUY6IcCax/D7/calPsMMGl53mDfUUpmpNFeV+Y9tyhwJGujuBR37flAbuJk2t1O+jKW4ikIf0URuaG7oOjOnyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Move code used to calculate the CS ID into a separate helper function.

Drop redundant code comment about reading DF register.

The "num_intlv_bits" variable is left uninitialized as it will be removed
in a later patch.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 97 +++++++++++++++++------------------
 1 file changed, 48 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index ba365901e39d..ae49cef4792f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -892,12 +892,54 @@ static void make_space_for_cs_id(struct addr_ctx *ctx)
 	}
 }
 
-static int denormalize_addr(struct addr_ctx *ctx)
+static int calculate_cs_id(struct addr_ctx *ctx)
 {
+	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
+	u8 die_id_bit, sock_id_bit, cs_fabric_id, cs_mask = 0;
 	u32 tmp;
 
-	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 num_intlv_bits, cs_mask = 0;
+	if (amd_df_indirect_read(ctx->nid, df_regs[FAB_BLK_INST_INFO_3], ctx->umc, &tmp))
+		return -EINVAL;
+
+	cs_fabric_id = (tmp >> 8) & 0xFF;
+	die_id_bit   = 0;
+
+	/* If interleaved over more than 1 channel: */
+	if (ctx->intlv_num_chan) {
+		die_id_bit = ctx->intlv_num_chan;
+		cs_mask	   = (1 << die_id_bit) - 1;
+		ctx->cs_id = cs_fabric_id & cs_mask;
+	}
+
+	sock_id_bit = die_id_bit;
+
+	if (ctx->intlv_num_dies || ctx->intlv_num_sockets)
+		if (amd_df_indirect_read(ctx->nid, df_regs[SYS_FAB_ID_MASK], ctx->umc, &tmp))
+			return -EINVAL;
+
+	/* If interleaved over more than 1 die: */
+	if (ctx->intlv_num_dies) {
+		sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
+		die_id_shift = (tmp >> 24) & 0xF;
+		die_id_mask  = (tmp >> 8) & 0xFF;
+
+		ctx->cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
+	}
+
+	/* If interleaved over more than 1 socket: */
+	if (ctx->intlv_num_sockets) {
+		socket_id_shift	= (tmp >> 28) & 0xF;
+		socket_id_mask	= (tmp >> 16) & 0xFF;
+
+		ctx->cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
+	}
+
+	return 0;
+}
+
+static int denormalize_addr(struct addr_ctx *ctx)
+{
+	u8 num_intlv_bits;
 
 	/* Return early if no interleaving. */
 	if (ctx->intlv_mode == NONE)
@@ -912,55 +954,12 @@ static int denormalize_addr(struct addr_ctx *ctx)
 
 	make_space_for_cs_id(ctx);
 
+	if (calculate_cs_id(ctx))
+		return -EINVAL;
+
 	if (num_intlv_bits > 0) {
-		u8 die_id_bit, sock_id_bit, cs_fabric_id;
 		u64 temp_addr_i;
 
-		/*
-		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
-		 * This is the fabric id for this coherent slave. Use
-		 * umc/channel# as instance id of the coherent slave
-		 * for FICAA.
-		 */
-		if (amd_df_indirect_read(ctx->nid, df_regs[FAB_BLK_INST_INFO_3], ctx->umc, &tmp))
-			return -EINVAL;
-
-		cs_fabric_id = (tmp >> 8) & 0xFF;
-		die_id_bit   = 0;
-
-		/* If interleaved over more than 1 channel: */
-		if (ctx->intlv_num_chan) {
-			die_id_bit = ctx->intlv_num_chan;
-			cs_mask	   = (1 << die_id_bit) - 1;
-			ctx->cs_id = cs_fabric_id & cs_mask;
-		}
-
-		sock_id_bit = die_id_bit;
-
-		if (ctx->intlv_num_dies || ctx->intlv_num_sockets)
-			if (amd_df_indirect_read(ctx->nid, df_regs[SYS_FAB_ID_MASK],
-						 ctx->umc, &tmp))
-				return -EINVAL;
-
-		/* If interleaved over more than 1 die. */
-		if (ctx->intlv_num_dies) {
-			sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
-			die_id_shift = (tmp >> 24) & 0xF;
-			die_id_mask  = (tmp >> 8) & 0xFF;
-
-			ctx->cs_id |= ((cs_fabric_id & die_id_mask)
-					>> die_id_shift) << die_id_bit;
-		}
-
-		/* If interleaved over more than 1 socket. */
-		if (ctx->intlv_num_sockets) {
-			socket_id_shift	= (tmp >> 28) & 0xF;
-			socket_id_mask	= (tmp >> 16) & 0xFF;
-
-			ctx->cs_id |= ((cs_fabric_id & socket_id_mask)
-					>> socket_id_shift) << sock_id_bit;
-		}
-
 		/*
 		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
 		 * where III is the ID for this CS, and XXXXXXYYYYY are the
-- 
2.25.1

