Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BE1376A57
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhEGTDV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:03:21 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:47105
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229843AbhEGTDN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:03:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDVmwrlifxbL8kB/IJqZm15qTrhn+QjHJTXJAgBT6s1KLqZLH/K2vD/lGqemWffGSfxUrZMeyYx7h0FBqctpLi4bQ6c8kP6LK6bZ/ompjtX3gnfyhx3mfzpMMZr1cPp6s4bGKrK4jdnZBj1n+FGf0/cePcDFVs5x7SP96KdIfbS5acT9K6+pdU7vPB2qRlQvPT7qhFO//SY7W8T0tHQhoIDLCXLfMI/VF5Rb28glb6Lb6B+RPbsJVDRHW1WUuSSR5MynZ86bnIabjptOwYe+CYpPXpO21hteVoFj37eZ4Ly+5ggRy0EuoRE5Vgq9udbpxbh3pl9CXDL6wI34DiifuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KEKdv57zFGfIk9M1ffeE3YZcEe4VQolLqlqAtrAUE0=;
 b=JbUcoKpienmZ2pF6RzMfcmUJWnzDzUzdC2MmxUXHIMkV6MIgs6veMS2nzVURNPHTp080lRMi/LY3kY/AHRU+jXOUL7uF7QVVgScgGLl6t74HNm1SItz5daHeNP/zhTX2qH8h3U5ViqbkE6s4Hjx1aHpy4F6Cqz3AWhLsh65ZRL3dnHezzpgZRd6Q1jjHLoLEDjUT+f1a2uwVG5NYOLGnKvXvtU21cOBposLkpY8/VVbcl+IvDUKxBHTc5ljjMhnarhcI9frVWfeG0DijcrpsRjTH/agyfrTAjtdp/a1OtEHyQ/LVjV51Chtj8rxHSf4c3akE1NhZIZN4gZNxR6+wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KEKdv57zFGfIk9M1ffeE3YZcEe4VQolLqlqAtrAUE0=;
 b=H6RyezecO9FwiH4ChbRJ6dmsm1frOiDVuIvHkDZX4teXHXkjj6UMr2q09bd7bJUzGIViRfw3ZMZLavglvmpsREzGZT4H0hV0CKDksB7x/hclcUCCSo+CDWjiEyUJHL4SmXP0UxLbxBgVcyJFF7Hbz3eUA6jA98oraLzq4gw1Isk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 19:02:07 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:07 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 14/25] x86/MCE/AMD: Define function to get number of interleaved channels
Date:   Fri,  7 May 2021 15:01:29 -0400
Message-Id: <20210507190140.18854-15-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec818363-e01d-4f93-48b6-08d9118a9c10
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB16200A337A129226C0390B5AF8579@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DHBOgA6O2NB+YcqMoW1afzytoSiQA9VeavK+b+oJBtr4MZIYD3/zq3EtAz3AamyhLqYldnfG7yiWHCIbmcr1z42iduIP/haDd+bB1Pl4W1dzIGFYHh1Se5Xlt92ZKZi9W0fxRomIrXWaIDZpC0sOP83s88Ijl/kCB8EyT/5o2G6ETFxiU3f5KB0gIiEv/Fg1VQdcqizKRsHh8Q2ELOiN2+1yBUg9fOspNlXS1vLJ1ld1VZukGKIng7DApjr0A/Zlsk2V+Bv92+hfD4uMs5r39SLyKuabK4Xjjr9nz+uu/I2xFdwxPa9iE92SYG0P/o+sJ2Z3a03k9yA9LSrToqJMO2yake0Su21JSwUzq7C1Vc29GsMZ/XuDelOO2Vh8mqvx1CjRJjEF9iqF+OK7dMrTqSkE0P5YwEUaEqgAVmUZDscz3OT7mx9jCR2icVkGSEDYrWv6ehlc1zqJXqQQtfEClkkbjZFp+rDvSDnp8/X0k7R627WyIBRsohzkLDgqA6T6MzLKbv/ImlBCRno3qXDK9T47lRR59bGJxD1zhCAn1/v8IqM0afTb1aIjoXlBKPUYPuj4o61ols2gw5DEemfZudt8KdQS0Tj038RXCx479Xmb8vv/4qOdSrFHdKsthd4bRfLa/+TzW4sVL7OJmuQlbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(4326008)(6666004)(38350700002)(38100700002)(66556008)(2906002)(26005)(6486002)(66476007)(1076003)(16526019)(86362001)(6916009)(66946007)(2616005)(956004)(186003)(5660300002)(36756003)(478600001)(316002)(52116002)(7696005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?u1pG4nOxkOQhznvpcsObdPt2PTPPOyMd+c89hvqpGIqSlsHqtyNdk2aBTNy8?=
 =?us-ascii?Q?meM8eHeh3yhZm/9HfTYP7FEYu+cIG6wtRpvhr18EzNnj9Op2n1jWmA6r4T7s?=
 =?us-ascii?Q?K9kEN2J2uYhtOtAm2GnWpTWNgKNYzs6RWTkDSloaoHaTkg9J+FvfCTBHcU9P?=
 =?us-ascii?Q?TtMDBl8olUjCBiEkShU1zRWJIiXpGZPtG+H2xela9DnwX35S9+b6EtuDaGHD?=
 =?us-ascii?Q?IbPTy0svLSNP0pCV49//TNcTMOQOmnGcYC0u/EeT96YqtIsh4T8tKGGcOAQQ?=
 =?us-ascii?Q?G7LGfy0FMcHX3rJqoELlivpi2mQhSuTCStymnm46cIORLcRDzxWwAFS/wtBP?=
 =?us-ascii?Q?h2Oaw7mQSd3oiuGkWI0qqc0ib6WMfH36WzE2ju+SB+WsW1mofaLiig4dCvIM?=
 =?us-ascii?Q?/xz0qw3vqko961UPlak1J7bKutgO7K5UbicSDzfqU4FKTh5r+oTHRwkUQGdX?=
 =?us-ascii?Q?B+STR+td01fhWEl9MHMLsnf4YbuwqeLqQzkTyq2s3Y5PRy30/D8/299PXcN2?=
 =?us-ascii?Q?xgv5AtEA9GH4UQFfGWIOlb7IYju3iXP6Y/EW2VcTgORy/3Ob79sQuXnjshEk?=
 =?us-ascii?Q?TDGVx8YmyFQQ1R0tvC5kHCYDiDyxC56IIBvOxjzaFOHldGFopawxOwhLcZhq?=
 =?us-ascii?Q?cDyfjYJUb3lH5lpqkAsPosiB2afTQKyArD657IvICv2YQJfWU9uh000elsPT?=
 =?us-ascii?Q?JUpNtG8qDaTDoPQ7CeJaRP3fIAN5SvTyqLMxgkyvYBcyNyLqagEeDKraMdCZ?=
 =?us-ascii?Q?r7DPqF+ytXMbMWFlLgL/nHYpHX0V91gYGubPLJ9BnPUeIHbwX/6IbSfTEEak?=
 =?us-ascii?Q?ATN9PnFgUsdTpEWY1pRKM6YTMQ0LhKwE9mO9T6qnDCqttdQhIzRcknSEZQP1?=
 =?us-ascii?Q?ERr8DZBzpJf8myu4lrlc82g6z0jcLoBFsbJV6AoXRrtlcP+JfzBraiaNlQy6?=
 =?us-ascii?Q?9U8KJecpAPLQyJDNqVBnff11rCSfaWAYVT7Z6y5PKOiRTc66lJeSlLGTJkcx?=
 =?us-ascii?Q?JRiT7B/2qG03YFcsK9Ll3HSiMPYFO0wARlTCu3T58MvyjLyM4GWzzPt2Z6Vr?=
 =?us-ascii?Q?YyvEu1jux5XQm1rzH1oNkheU1KS+zbTDCVasIcY7tkjDRTGhGHrTz3brx03o?=
 =?us-ascii?Q?R020kXnUn3OPDIdAG8HmFFRHk+eFsP0ODAZrbUF2T4Wj0uCiXy4G2Rtc0j6O?=
 =?us-ascii?Q?5qF3P49EamZks7BsRg7oTwOvftQnT8LhfVsJQ5wxsv06DDs7rJhBdCdCg/wC?=
 =?us-ascii?Q?bf4DoYHSHJlaI0Fkh68qGJYn9VWp4rPzndzZ7lUHvFsZgA6MbAL8Ee2pTmWT?=
 =?us-ascii?Q?Vvw70zA/FfxGGC1Du5hTUWXe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec818363-e01d-4f93-48b6-08d9118a9c10
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:07.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jnUKSg8Plv8fJDdS7/HYjw7gw9I22JKSfOxDZAYzPxzsBk5rw1cT/xLuBGuPE1O+/2QJrE1l9FLs5b+Ps/koA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Move number of interleaved channel calculation to a separate helper
function. Drop unused cases.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 42 +++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 605376351cc8..0c24bdc346a3 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -729,6 +729,7 @@ struct addr_ctx {
 	u8 umc;
 	u8 map_num;
 	u8 intlv_addr_bit;
+	u8 intlv_num_chan;
 	u8 cs_id;
 	bool hash_enabled;
 };
@@ -830,12 +831,29 @@ static int get_intlv_addr_bit(struct addr_ctx *ctx)
 	return 0;
 }
 
+static void get_intlv_num_chan(struct addr_ctx *ctx)
+{
+	/* Save the log2(# of channels). */
+	switch (ctx->intlv_mode) {
+	case NONE:
+		ctx->intlv_num_chan = 0;
+		break;
+	case NOHASH_2CH:
+	case DF2_HASH_2CH:
+		ctx->intlv_num_chan = 1;
+		break;
+	default:
+		/* Valid interleaving modes where checked earlier. */
+		break;
+	}
+}
+
 static int denormalize_addr(struct addr_ctx *ctx)
 {
 	u32 tmp;
 
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
+	u8 intlv_num_dies, intlv_num_sockets;
 	u8 num_intlv_bits, cs_mask = 0;
 
 	/* Return early if no interleaving. */
@@ -848,23 +866,9 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
 	intlv_num_dies	  = (ctx->reg_limit_addr >> 10) & 0x3;
 
-	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
-	switch (intlv_num_chan) {
-	case 0:	intlv_num_chan = 0; break;
-	case 1: intlv_num_chan = 1; break;
-	case 3: intlv_num_chan = 2; break;
-	case 5:	intlv_num_chan = 3; break;
-	case 7:	intlv_num_chan = 4; break;
-
-	case 8: intlv_num_chan = 1;
-		break;
-	default:
-		pr_err("%s: Invalid number of interleaved channels %d.\n",
-			__func__, intlv_num_chan);
-		return -EINVAL;
-	}
+	get_intlv_num_chan(ctx);
 
-	num_intlv_bits = intlv_num_chan;
+	num_intlv_bits = ctx->intlv_num_chan;
 
 	if (intlv_num_dies > 2) {
 		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
@@ -901,8 +905,8 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		die_id_bit   = 0;
 
 		/* If interleaved over more than 1 channel: */
-		if (intlv_num_chan) {
-			die_id_bit = intlv_num_chan;
+		if (ctx->intlv_num_chan) {
+			die_id_bit = ctx->intlv_num_chan;
 			cs_mask	   = (1 << die_id_bit) - 1;
 			ctx->cs_id = cs_fabric_id & cs_mask;
 		}
-- 
2.25.1

