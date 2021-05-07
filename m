Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876C0376A5E
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhEGTDi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:03:38 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:47105
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229898AbhEGTDV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:03:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4ooXmRL5r5FLQiXVLwb8p6Ez6Fo+sw3IQyqekK5TmawawX4AWByQx1efR8NXVWijr2VP5sf2gTqWuNQQi+NL3dzKKwocLOz00KqFWXEfwDzgiOllF7wY73uCeVGVUaUVTEZe/ZUiOX6ZSLS8KkH1JZ/4YFHJSx0DuNZTlgNNKGYdScBpis2W8UXT9C8TQ2Vn0XOjy/hPEjGlQhGGALWJEJ513PkBXNhJHzZhM0pPed5aqzp1YiUsyUfdIUZ3CoF+fPqJUlV5DXkXaQmeCaawPo7H1tMRNGA3w59NWUsHwLQkWJNped2KVbaBduP5z35Ec4RgQke3PYTesDZyzlI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWVQKlSe/q6Wb6QB0xoyEvXuUEOzXi9je5kChWODsQo=;
 b=ASPIobuz3uk+it2/eYKhRAUBmbuk4hUAE2fxows3O6+u+PCHh3sRorjKzU0fndlgv3N8BmTAIQXyPad1ThSFAxpCiB2l5NpUMAbEz8Gz2ZFluxv5zvrJO5H7G6Y5BWjuOTTNZRwZU3CWRIVZr+P6wGJLZVKOewIAo9ySSsC3ud/+dOGsQi90qZuIvQSXWMI8uDped9dVESBW9lWOxxQ7lP+7H81GdOIyFRvYiZoyIxcrL1ks7SD8N8wGJlG1dTL5ddWFWY9CY4+HyDyRZhUul3YjBW2RoTdQPTgDUUTkFolUwTsgL3QuwZbY7fTQbPQ+zdIq2B1dp8SzzzjPBq/iaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWVQKlSe/q6Wb6QB0xoyEvXuUEOzXi9je5kChWODsQo=;
 b=A4YW6VuUk9D7RM+Eh+LZ5GgVSJZ3BSfigBOivS6wpSK8EifEhvWfxVaRzv3gYr9ReHwo3oaiuWsZfkofEyLq9zI7inPyd18S3PItKErKXTqWKMwQ6CTwnX3WiRYiPFScq+RWSuQjlv5dkJrvRj4Yphs2jp7FGtj+PS3f9KAYLF0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 19:02:09 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:09 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 16/25] x86/MCE/AMD: Define function to get number of interleaved sockets
Date:   Fri,  7 May 2021 15:01:31 -0400
Message-Id: <20210507190140.18854-17-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7040fb26-5e07-49dc-39e6-08d9118a9d59
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB16206D5A95F34DAACD58914BF8579@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hae7Fmb1qhOBA6lXixiaB1tqggddl2ekov6SQ20DgxDSihkim7JXU4KT30z9bxPPrBTKIMsPNYN3VA/Lm36frnkDnNW5FQGQdkDJdy3QJzt6OwYtYKifygMFHEreetFlF1QrahLpsuUTLbrjLEYvwo8lklyQvL2Ou55+XHkxBpyuQh8VVh/rYXAsN1m1dS3LJbnVBebi+AOm0S8IszdevfOkzaFd9OoCVe9prrepNgq+hx85L0RtXdWRFS5rrn9NFnie+tpNA8evKtJLoobAnLnzddgK7dc0gMEyQuwUxb52b7i9+mhTgP/fEQaxj5RztCjyWbHBYOW8Oiwi6W7WsDSwUxkOiTpccInQylEfc74oKWYX4aQmBCUfGNiPxktaeHv8gWRWAEsSa/oMcYP8yz0gJz1ar27zZQmkPEibCaZRvwf3x9Lriy5ErFiTtvASTYe1F/UPbDrhlmMy3VILf1WRwihxPwD4leBi51uDpTpTiCoMFPR3gDFvc2Umo7nmHFI0mBTEy4pjWGLd3fZrw69p4FjZ/Vrb3DwokYgMi/Judki3iUkuFLwJC8ie79g061U49Ie3B5CCn+FlhEDCgeL2jYy+IP/9GaNevMAk4QraO8sH8JwtOlajDgao6CtouC21AoCMiMtB6czg564WQ3i4lwq+lAew06nv/S3i5Ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(4326008)(6666004)(38350700002)(38100700002)(66556008)(2906002)(26005)(6486002)(66476007)(1076003)(16526019)(86362001)(6916009)(66946007)(2616005)(956004)(186003)(5660300002)(36756003)(478600001)(316002)(52116002)(7696005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yywtHfMj3ctn+7SFgUeLtgab5HI8sh4TrV5NRYZhkge5hdbAFrfkcuGVXalf?=
 =?us-ascii?Q?fjoFjDLf9X2fJQRGVdhL/u8Nuk2qkztMQi7vdlaJ3Kpyz/JPsIRNqXqMnDbU?=
 =?us-ascii?Q?EMqAQjlJdRzBBZkZlLPzo1yxg0ORn3c8MZuBF+faXRkurRUB0lJ1mrUjgm7t?=
 =?us-ascii?Q?jm7N31oZMnIvq5jT4knJKLuvtxGP/rhycNiftlew4lvOMKtNC4fSIaFVqFZ/?=
 =?us-ascii?Q?Wkp7qSSu5W149ts80BWCarVNgOWdw410r6tR4gUCMzoz+OkR/kc23PU3Iuah?=
 =?us-ascii?Q?xD054dYQpZ1ZnA+KeNIKYGtNAO26ODv+uqiwXaL9kJjtxGO9vLIdPvLFblan?=
 =?us-ascii?Q?ey41glKvgOuq5U9nVxwWfu6YMN9qMqTlvIcuaFheR5t8e5BZZKsVer8epilP?=
 =?us-ascii?Q?mLWg2qNOROmBWaPyjw7eRzk61LJoRLiSMSiXT344wF/pS8oJpT1hB5pciu+g?=
 =?us-ascii?Q?gpk5qYNSuQbHQH+lNSoBLKKH1Pt9H9IV6sYRWtRPCp0/KG4F2yTzE2zwnHVW?=
 =?us-ascii?Q?m+cEDiMm6y3q95u9hxQJQ6qFTL+x36iTvhUiYvivEJ0oG22yLX4qA9e2x07G?=
 =?us-ascii?Q?dA4LKqepcPAxbgHgWeTgOY7DN9dXntZS8478R64D8H2FsIjN2Gg0nK/HXn6p?=
 =?us-ascii?Q?maVF1JbRWOCpUYVSRHJpbfmX5xDsIlu4Dv+anYzR08K6tLFO59RbbCh5z6tD?=
 =?us-ascii?Q?CyJMuXJ9V86SCPd2aXliLtqUx7Lw0jJNUOjAHRrnVwse9e4dMwQeK7mpXb5I?=
 =?us-ascii?Q?ffo2vnjFHO41xm1CftDg8Ri6wXm2Wp2pVJkytoRAuMIgSGn6W1xAsSgkHPJT?=
 =?us-ascii?Q?koyDx/dYuzhVShL/LNTmPhJOc0utdOfneQqduPKWkTE0MOZHyfxAuccj6QBT?=
 =?us-ascii?Q?wMsAlD530opTC2Rqwg0IdROK/H43but/fk9iQAxVbwyXe8gqsNRCJw6QRtgU?=
 =?us-ascii?Q?wayMlXRtxHEfDneWx1QBDFR0NUvGiHubJ4bNXKCK0mI+1Vv/exINwH/SdPIF?=
 =?us-ascii?Q?C+adA859I8PASri/NsC3/GBBdcS9VmCUkvoogyiHYrifxYV8bCYcRj8KNUnS?=
 =?us-ascii?Q?kZt20Yjstj6IZZv8OLtcODjtyp7NDVIkKKQ4Yw1XeXnWggnWyee/8Vqe/IXw?=
 =?us-ascii?Q?AdFPrQ6kuDisC+0SSyj9ldTFgFSLiqQP0MtyUzuNOwNwu7Xnkmp3d4lT1UNa?=
 =?us-ascii?Q?dovqXNIUFi2FBtzUT2jS9FCpHVo8OaeyUh1dZZaJEicN0g03/MplgLDpQiL3?=
 =?us-ascii?Q?JOCnjaw6vOFCJCBNvBuuxuQQkHGu3fgEAff7kM0x0R6lHsJhxoQ1q9u5kZmx?=
 =?us-ascii?Q?DomCTJNWvShX5fqtm+vp0oKj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7040fb26-5e07-49dc-39e6-08d9118a9d59
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:09.4524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81/OATBQ0rAfA4VlKEsrORVXMRmfZsWhwpXHOyHyt8RTVe1skUs7JRCYfNfKI2egfANIS5OJWJOk1gXLhbjvcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Move parsing of the number of interleaved sockets to a separate helper
function. This will be expanded for future DF versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index de59fa6cf540..670787be705d 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -731,6 +731,7 @@ struct addr_ctx {
 	u8 intlv_addr_bit;
 	u8 intlv_num_chan;
 	u8 intlv_num_dies;
+	u8 intlv_num_sockets;
 	u8 cs_id;
 	bool hash_enabled;
 };
@@ -854,12 +855,16 @@ static void get_intlv_num_dies(struct addr_ctx *ctx)
 	ctx->intlv_num_dies  = (ctx->reg_limit_addr >> 10) & 0x3;
 }
 
+static void get_intlv_num_sockets(struct addr_ctx *ctx)
+{
+	ctx->intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
+}
+
 static int denormalize_addr(struct addr_ctx *ctx)
 {
 	u32 tmp;
 
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_sockets;
 	u8 num_intlv_bits, cs_mask = 0;
 
 	/* Return early if no interleaving. */
@@ -869,16 +874,13 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	if (get_intlv_addr_bit(ctx))
 		return -EINVAL;
 
-	intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
-
 	get_intlv_num_chan(ctx);
 	get_intlv_num_dies(ctx);
+	get_intlv_num_sockets(ctx);
 
 	num_intlv_bits = ctx->intlv_num_chan;
 	num_intlv_bits += ctx->intlv_num_dies;
-
-	/* Add a bit if sockets are interleaved. */
-	num_intlv_bits += intlv_num_sockets;
+	num_intlv_bits += ctx->intlv_num_sockets;
 
 	/* Assert num_intlv_bits <= 4 */
 	if (num_intlv_bits > 4) {
@@ -912,7 +914,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
 
 		sock_id_bit = die_id_bit;
 
-		if (ctx->intlv_num_dies || intlv_num_sockets)
+		if (ctx->intlv_num_dies || ctx->intlv_num_sockets)
 			if (amd_df_indirect_read(ctx->nid, df_regs[SYS_FAB_ID_MASK],
 						 ctx->umc, &tmp))
 				return -EINVAL;
@@ -928,7 +930,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		}
 
 		/* If interleaved over more than 1 socket. */
-		if (intlv_num_sockets) {
+		if (ctx->intlv_num_sockets) {
 			socket_id_shift	= (tmp >> 28) & 0xF;
 			socket_id_mask	= (tmp >> 16) & 0xFF;
 
-- 
2.25.1

