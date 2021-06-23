Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6941B3B2117
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFWTYL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:24:11 -0400
Received: from mail-dm3nam07on2082.outbound.protection.outlook.com ([40.107.95.82]:56929
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231127AbhFWTXn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkzrnAH8rmBj3cRm1tAoTgWCpa+aKAhG4Xf88tN1Lb8KNembhNYBoZw5oLXRBt1VoqMloIbi/j06/B3h0qN2eIW6EmpmpCSIb2U3B0UM9e46EfKOXPaiOweyU34O1m99LmO4Frx2+fe8IKsb2h0u9R7elJ8DAfGwerg0eWxwlaKMoXa5gOk94+VkHIQnyO2X7qPvdkOURkBYH8pKMLDYviVDj4JQCaSrQ/BjNh9hmQUBHVEEkeun5VqOMCE+fIUSMrnwBsiE3kvqQEOm3eO+d8Mm9qvXpauQ53jcIiCR1sceoJ8V68UhlEHuv7hIE2HvShuJ9DNLvl+Cdk7Xd+w1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OvMqmAqnLwQ4zUjnHpcQlik/wjixZfjd2ICnY/XYLw=;
 b=T4nMcfQSUsqBm+oj7yZYVYGZfC6rUp0f8tLtlC36fLNeuqb+NfP8nF8p6wRtzNpp+lhgDA2da9k5LFoRqKe1S6OxSLyPGHtxC2C9vcmB6s5StV8oZtJSPnXDCHMWs5ip/Rgmr4dOB91ayYYpb41kp9pcJEE0Cx1JBzWSJR90kMigZUSVZ6Y9l1iLKO6HMbLZve9nK0aUg1X3FL6E7cm36HjpWomfL2kNKdxCeWyJ+sHBDlYmHlLUPf3oIATnHn1vubqZZ5TC5bZF1E0H/5322PZuwrvpq1AgdjG/WbF3l6ueSjmOZU7X9bTTXMYEyi0sZqstSPnnK/4VGbKNzGlZ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OvMqmAqnLwQ4zUjnHpcQlik/wjixZfjd2ICnY/XYLw=;
 b=ZpTjHAbg7ESdatGgUQfqQeuWKhcRgeOjC/yCcB+ILbCtFrTPloy2JItMusnoo8ohOrrkgTpJhydsqmfKPkrfDlfvQUYUekUlFldpwLhTaSHjszSgw5LzIsiXOJrfIJMlAup5yzc5tK6Ni7SIa+TUKjzB/wBZfbLViOVZNP2XPPk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0211.namprd12.prod.outlook.com (2603:10b6:405:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 19:20:59 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:58 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 23/31] EDAC/amd64: Define function to calculate CS ID
Date:   Wed, 23 Jun 2021 19:19:54 +0000
Message-Id: <20210623192002.3671647-24-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5a44db7-a71f-4b2b-a884-08d9367c07f3
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0211CA6F6416C14925CA1133F8089@BN6PR1201MB0211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdektN/B7eQFCMioD9T87Cp5Rd/YDU1FdtXyfTy1ZWjulThkCDBMFQTd6keGQz83AZD0jDIMz97upuPZC8+wnls6Vi6uozqGegA/AhuNimYm5a/mAbLCLNJWW30lZXYayUiiO139OjPlhqywDQL6HkelQADHCRAONJQSu8s4XEBGOTpOELPJTWsDecIRD9FTZgQ1O6l4xy5QZlMDMlzRhuG65tsdxSLYR13F4hP3jmpwJ0PAzuVUEuaJFScXVU3rgkLsn3Xc5h0x8juvUojlDcZxepE0Baol+m+dh7m8pivBZbtEVVkVnq7U+JGBn+RBmOvMFnt0X50ph/zQyAmlODz0M9at9WTBhYEI6pHYdAa29xY+HOlRutYw+UfOj1cQFCN50eOgXMk9WGLZAmBGC7wFeesbby8YVkulyIj8ztq6z6gMWHJv7xYO9JuI8ci71lVFJ15egDpc2lVrdIik4M/8+gL/KOHnN1+IktBlFLm2u0MXwn8vHjkjbyia9GJdMoEN4GxpHVnTUVhWPQ50qb5osULVounyCKeggvG/cY00e9R4U0zFKekfy117mvJIwe/Xcd3uvF+FMflNHYUSy18xgJIZK0uuMPBOvbgrGl2GFxHvBmsPX9kF2saOmPMRE4iPC6rQ3IRSYviOjNuEua94aFusOVqwDZkl1MrwzVbrTu6bBVA9R7bQIuzKJ9SwZpJxWoN8RN4OFLBB7Yz2GNnTd0oXitaDMue2esJ105LCgsysJDziDSNODZJ0y0HHoTWJlFMN8KPgHsAVqLqQ8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(1076003)(6666004)(86362001)(956004)(66946007)(2616005)(36756003)(316002)(5660300002)(83380400001)(6486002)(966005)(38100700002)(478600001)(26005)(16526019)(186003)(7696005)(52116002)(6916009)(8676002)(66556008)(66476007)(4326008)(8936002)(2906002)(38350700002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YANHg0vbQTl7PTp2hqsNQwk4kFCEE+qr4wQ7YLv96vlr94n9DlpcvI4oNXE5?=
 =?us-ascii?Q?2Em1fVZqulQVjEYyC77+l5TfkvyGjMXjlHZpaCAHIa+Et1VXKykSVoL7hVKR?=
 =?us-ascii?Q?LrqzFhL7QvR11UWBSfZNzONqZ3qR8z9QLCcw2yAkStWHEUffM2when41tagM?=
 =?us-ascii?Q?rDoFWnQoQo33iqpyY7HZbv2SZcDY2FReu88/lKpEvMz/acb5ZiTHM3vcPvHa?=
 =?us-ascii?Q?gNMYQgW/OkghXuDH9bvLi47FzCFm3yRSe4DYy/sGgpdcRed3Em18S93wFMlN?=
 =?us-ascii?Q?XdEy1LEzR4ccHQ0Tdyf1O6IHT4v6YIsIXxwLq3CqYR0X3ot+q5M4ZwYS83Hs?=
 =?us-ascii?Q?toWJnqiy2RNEkBAF18lenn9a5unGZB2DNRiuKBfBg0RB8CDIFrYICAKJLAWf?=
 =?us-ascii?Q?uG6BkmtT8RscahHdyK20ruwGuV+Bek63wAAljuV0LVcuev1OZLyZVdgAjybf?=
 =?us-ascii?Q?PD5L0nx9muAAflaBhbO1uNmLtp7xncUE4bXLEsP1ziiXsU+ccz2TQ9PHYFAC?=
 =?us-ascii?Q?Uvtxc+STmhrN2Oe0ruRWzG1wJ2EnLLKpMzlip3KgmaPhlZwZ0u6dJdwuYl/6?=
 =?us-ascii?Q?1f3FjpXdZf5ciX+AaF9cP3PhGg4hJE95ybNec8XZ0VO9KPfluvGWXek/+pBa?=
 =?us-ascii?Q?rIg4eVSFfxVL2Av0RfS7ltr1wJdt8HWMgxT27062oRVEyEP7SsXuLSe3C13L?=
 =?us-ascii?Q?AKg+dmEV1wmu1RZ5wfgT8ucKECekdmnWnJznKpqXKrnGrvTMjdAEybrt3W40?=
 =?us-ascii?Q?6fEN1MZBHq9T40C6FAKF1k/Psg8+AZ/QJZ7cr1ZBes1ZuAaWCC0HP4YTSmTj?=
 =?us-ascii?Q?CSLDgsiw4AlPFMRAbeJoWCJGn9bG0Jhol/zjbqbKrCiwkNi6ML8vlYLi8Iqx?=
 =?us-ascii?Q?M+MfUb4oXlVNjzUIuIbagwa0vbaUtX6xH2mWc0iLN87Q7xCiWg8hlTZMIcIX?=
 =?us-ascii?Q?lI6rmGjz0XyaBdK+Xr3cDgdXek4KYS+jCWK0FPZGORaFbfTLOa9L61qwxdU/?=
 =?us-ascii?Q?4FgnCkxB7CAdfpWROVP5Mg9xAhNJWfTtZc70KVLzvYVQpscgvqWR3lwssDH/?=
 =?us-ascii?Q?3Ax33ODIlHP330P7OpkLQ/drV3Ht4TA7x38GicNWMBQV523RFRIQctx+pLqs?=
 =?us-ascii?Q?VudKXKBBCgK088UyIkZyeklj35isSifymugnNGWMKLUyyVtmzMK56S+RMgSG?=
 =?us-ascii?Q?algVRPx+CRPYBuk7a1XH7SCbnRd9U98b37bb50a95LELVtzPqRZLph8vkPWQ?=
 =?us-ascii?Q?uAdnHdcI7Y0cBL0n7/efQybnBMhjFCriUA/yBZeHw+pTF68QFndq6kDubfTm?=
 =?us-ascii?Q?lUdosk2PBoUeUalOjdx7Jfn/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a44db7-a71f-4b2b-a884-08d9367c07f3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:58.9158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rV8d8nvTTzVwxGphgbwb91WediuZIASgzeHgyrUpnCDIxxwr2VIxlKr6AQQCX4hSErZ6QnjdZfNsmVj/SPGlPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0211
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move code used to calculate the CS ID into a separate helper function.

Drop redundant code comment about reading DF register.

The "num_intlv_bits" variable is left uninitialized as it will be removed
in a later patch.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-20-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 98 +++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 50 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b497af7c3561..0270bf4f1f90 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1286,12 +1286,54 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
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
+	if (amd_df_indirect_read(ctx->nid, df_regs[FAB_BLK_INST_INFO_3], ctx->inst_id, &tmp))
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
+		if (amd_df_indirect_read(ctx->nid, df_regs[SYS_FAB_ID_MASK], ctx->inst_id, &tmp))
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
@@ -1306,56 +1348,12 @@ static int denormalize_addr(struct addr_ctx *ctx)
 
 	ctx->make_space_for_cs_id(ctx);
 
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
-		if (amd_df_indirect_read(ctx->nid, df_regs[FAB_BLK_INST_INFO_3],
-					 ctx->inst_id, &tmp))
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
-						 ctx->inst_id, &tmp))
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

