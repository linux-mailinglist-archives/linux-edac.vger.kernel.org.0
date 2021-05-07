Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301F6376A63
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhEGTEE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:04:04 -0400
Received: from mail-eopbgr770081.outbound.protection.outlook.com ([40.107.77.81]:44439
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229974AbhEGTDb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:03:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICl2tq03yObQYetyfVHxE/XFh8tnB55Fo9ulP55Gf4HA9spXmfXFc7QLVHW9VE9CPmKvGhLLrZqXP8uBdNq7vGeJVj8M9+Ql8Xuh6uCM/+F833Y5Sr2hcUhs+ktpT69gDRvwSYmkknQ5DSG7FE9BqROQUtnnvr0vAWRlBnGWLWn4SSlVeUnHZsNfzMSW0w4znn5Co4w3f9VhgZgPpxOswSY7Czl48BO575htKJwYsO7tC80jo4VwAfBzvN/7Kz11hu0Za4SKnYkp/5JF6Dc6esVnXYqJuVe4uohN0LuI/tXJRDPStCtMr8KGUKNz0buHLno0iLCemzE3B4FR5Q1PMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhWgsakzAAifgRQdxQB6LOOamCQS/oQxL6bJynDabPU=;
 b=cmMWL+zgzNuGUeAG/UlpNdzhbi9Oqwhx62WxSK0Zf1e1rgCL8uqE7MRlIRBnaY3ZdfJVD7vpgVSoMJt08ImbRZ9Qn4kqyi3cpwZehe3kVF5cy+06SikJco+Q4o27goyuvYd31YCo21QZ4mB1kZ7ryXHPgDzqzJxgMKjrjSIjpCoLIbDQEoFHtMqIoU1CFAVswNY5AMKVX98fCSEEHyXDvP9LyxyQwD399zUfPfO75Zd6CB3d3mtkvVFEiGbQbraHAtLDa/AzAVe+6al8H5FExvNQqCQJHMYu4ogMoHo3qNBQHsS7ZsBNeb7gbuJHeYCVXkXP5+9+XGErbNLGxxrjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhWgsakzAAifgRQdxQB6LOOamCQS/oQxL6bJynDabPU=;
 b=gggmot2tYdysAphv0+GBR0N+0bT1VlfZ9jwtd40F6xMffXo1WcUE2AFDRUFkoJhS7sgTimw5Yr+T9CHDsm/S6Bd51oSC5j8HHHg01JcpgNvSGW34bfojo7bMGogWHTK4x/h0ZraRwTSSOTuUS5KzCGJY3vHYs2dgku2kpwz0lSI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 19:02:10 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:10 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 17/25] x86/MCE/AMD: Remove unnecessary assert
Date:   Fri,  7 May 2021 15:01:32 -0400
Message-Id: <20210507190140.18854-18-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7012ec5-966a-4689-e4bd-08d9118a9df8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1620A7363DF156FC5FFC58E4F8579@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFcBeveru+vdsJnOog9wvLmotHp94cbdEAIvLaeRWwB1M53lSiOqepknMFLaJiNJuk1wETRuvBGEPVuO5ncpjQR9h8BZvM9K6eyDifDGG3E1exZncDqDEzleWvbN4DUgiWtVg3JwjcYzgYas9TJLChAQ2sfV2a4Mnx+NfhW/Zv66ytCgPvow1MIKct4/gZn04jUSCA0V2RD7OzXkFyiYuH6OzNh1vfFEs0pLGJmGZ1aNQ1tGoR/7b+mmXgBtVj2c51qdESom96/Cl1266iUwARR26jBQ6k2iIHznDEk+FPyj38ce+DER5UXp9i0crKo43if7BH7amXB2fIV8r0TQ/DSss9z2syj1QUNp7JeEO/v8dufJbbieXyaKQVM01yuE3XMoCy0RgAnDM8ndtEZIeeFsr3p8QnCiNNC7W7unlqrZA0ZKgGiQBPhhg+Hd5c7a402lInsqxpq5GoQobBwHeSDlUldDNarT5hCNRk2RadLr5qcu0Ju4mZNQNWa9slitMIgJS36Kc7ji0H8mjZg2L/7aaUcd3+pSiv0cbJDZrD0Nl5WTOO0QjiCRsPF+oETnxIFzD2ENWHAeusV7euVShVjBtLKf57EAKDDqRHP2WZf0VBkZWHsw0xC6bQJotqSMjIDv6Eg8MNGlZsCdrfbgNOmdw9u8FsslUK44ZMz68do=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(4326008)(6666004)(38350700002)(38100700002)(66556008)(2906002)(26005)(6486002)(66476007)(1076003)(16526019)(86362001)(6916009)(66946007)(2616005)(956004)(186003)(5660300002)(36756003)(478600001)(316002)(52116002)(7696005)(8676002)(83380400001)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?X/UhYVDVueSOniNdM3E1eH/LwvS2u/Y354eBlEuRB0ViNKdSd+du5uxRnqlf?=
 =?us-ascii?Q?h5ybTnoJtdnkRYCCrNiXUOn35jAt/fpbIyshf6geDFf7nLOEg9wgIQkpyS0R?=
 =?us-ascii?Q?JDjuGC16YPOnPb7+TY82Ij7h7uS6WO3Adv6TTu0DnvD6zBQRWE5nkClR4X1V?=
 =?us-ascii?Q?Ap2uEND5GM2NgjRR8wrnkNkmrtoD8W9ww0kWZhqWsLjWCFCtWWsArlkuGzCV?=
 =?us-ascii?Q?ZjJAw0W9NIfnAsIGGvndZyPiKgSN5KqhdiJugHvesH0EOQoKJdbyWEdNDkaQ?=
 =?us-ascii?Q?TnUxRQc8aY7p7afByS5w+5Zw/KjUimGwwMOE26uNPBhx16iUxFjqBcQD/aaZ?=
 =?us-ascii?Q?KwnwEsldNzeEuy8d/5WB+B74XY9nTi6FL5VB/hngjVgqa3CzuZIBZbf7Hj7U?=
 =?us-ascii?Q?MqIV9oAZRozN6S8vNUWe/rfj5s4gGMYwYHqO52TVweHpbTIx8yHoA5CLdm3n?=
 =?us-ascii?Q?+E0J0fvkGdp8Zi9XpzqAeRTC//R3wTG13JLuIRMkcLAFsvVYfOLf6tB2oRVE?=
 =?us-ascii?Q?IhtgTmyqMsUTjErsmQ3bpwmu3+Z2GLRMiOMi+/m1nRmmhFk+/KABEguz2KtQ?=
 =?us-ascii?Q?72k8lAYPT1EtVb1zs8XqSCmwKkFJhsL9EXPTdG8mo/Lfoz40RWhDFakMqpCT?=
 =?us-ascii?Q?beZ/IuqvcRuC6iGj9Id+5+RWPSoaWO8TM0P67YlXqjl5u8QOsDh4Iu+Bht+N?=
 =?us-ascii?Q?jGsqSqk8Twz7YPo8KnzZSrQpslS+24qPf8/JbgJkmbDvrua0v2dYZbUt3NcY?=
 =?us-ascii?Q?noF6J8ji2M4RAzGd4eCAMc5burf0ZluOpoehaIwcLeKQcStkkfLz/I0fmY9/?=
 =?us-ascii?Q?WLsRSsGo9nN/FrwdRD+DMktUU3JyB3zj7HOVySNNuTVybihdsTFFznJJ+rlZ?=
 =?us-ascii?Q?f6lD99zgp0P2rKFbJmmVZxvcINSW9p4azE0pdyBs7yYTOV09tPD1ExWBr3vR?=
 =?us-ascii?Q?JcibbVN1suWC1+VopxTUk3e5oklmhXy+zWX94ql1Q/6vQ/TCP9gd51BWiFyO?=
 =?us-ascii?Q?2uzWn979qCcKXRG4CC612rFba/AuTnPGExwsGOSkwu66ukT3mlyYg13nvE3x?=
 =?us-ascii?Q?pMtS2dLVem+forhD+p6bSlrdSE084joetGzfRY3eOwMB04mVLUYyCCgucqYH?=
 =?us-ascii?Q?0vP3z5bR3vVbDmrhkHKU5TXMbyoR1OD6yVXny+m0d6e00gDNJPwuFFZa9yx7?=
 =?us-ascii?Q?OMA/Sh7SelU6SIyrt7BKiYtpPyTw7O6I8H7OB4UpnAIWAP2S2xrSaWylC2U2?=
 =?us-ascii?Q?WzmfskEUlzPdgyCqrBhWHLBrGOmuwkdS5B8kT1/fs91iZxpA8XeB8qoIpHur?=
 =?us-ascii?Q?459yUrSb/7rN7X/rdV/E1PDC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7012ec5-966a-4689-e4bd-08d9118a9df8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:10.5198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUjDAfFawaUznucp5iwrbVRzxZM8hxOU6Waiff7kVKKYuERiNT4RWNlO4b7uF982y0XWdQPmOWgHCAO/R3mtFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

It was removed in the reference code, so remove it here.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 670787be705d..8f4838a3d509 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -882,13 +882,6 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	num_intlv_bits += ctx->intlv_num_dies;
 	num_intlv_bits += ctx->intlv_num_sockets;
 
-	/* Assert num_intlv_bits <= 4 */
-	if (num_intlv_bits > 4) {
-		pr_err("%s: Invalid interleave bits %d.\n",
-			__func__, num_intlv_bits);
-		return -EINVAL;
-	}
-
 	if (num_intlv_bits > 0) {
 		u64 temp_addr_x, temp_addr_i, temp_addr_y;
 		u8 die_id_bit, sock_id_bit, cs_fabric_id;
-- 
2.25.1

