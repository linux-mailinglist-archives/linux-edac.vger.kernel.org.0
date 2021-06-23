Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E183B2115
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhFWTYB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:24:01 -0400
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:4705
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230509AbhFWTXh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:23:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhEqVgw+Q+SXwHgcdnFVs70pqlFbPro2nvi0HbIFJhCcqB0WDFk/zHlZSe2Y7vdQJviQPZdbYoxWblNg442YpVFoe0nvGmU5lwK7opcDq7lsN73uQPX1BbaIJOgUXQqPdN/48MlWBZZV/le2jmcN9WH1gVB7NGKnmmiI5eJTq0Oe7UItnVeDWDmik7/fD/beVoSwWgjacLPzU5BJYFHF/9lenhDTe0FLBG4YwCalnPsj7gFoCbZptuaGj06AXtROf4qDLWCkIVmse34vbKHh6MfznKrltyN+BvgmUIPRzUWmLdU7xUFcU6rYb8gFbNHZ0KQBWVBrAtrYHwNniB2Fbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JS+WLY04wrO4xFlLaw6OBLHJrXKQezjpufWjQMZgKY=;
 b=WUKDWp/Ae8dikfBudS6XHxMA8eqyrIWvkzdGwC0uqDDpZpXOVjUrMssCWRcWrCm6xW9HVFc7qHsNWfMWyiHXtMsi2TLCIzSA67plexULiSTb06hqiX8PdwAIpjNi7FiKTeqkBa9mj7zOBQ+M70h7+yyBzLiWhiyGA5UkI2f37MY7CKRcRhPY2Ws7thu4aPA+ON3D7n2mFaOYpKBxuk8+G9teOuiH2/G/7sUWWEHEYE92dtkePdW1Yi8R4HJk1hG9VL6YDVw8UU0Cuk/lsynMELsHkSEZVwoOcsG4/QJoyTCQrK3LO29N2zU6XAq9bQ6i/3de4TFFNjtUNoW0ZZpNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JS+WLY04wrO4xFlLaw6OBLHJrXKQezjpufWjQMZgKY=;
 b=ch5rWyN7LnVbrQVA9vrHtmjxRSSdqVrzeHYpaRNoJxNeFX5U7c0CAWptQfiYVhT4jIbsw4UzrjuuAgvBuTC9khC1s14kP+Dn6d75qTs1aHWP1K4FlWrnVoLMq85RmpHtwWw+sxo7YWTB3fh300O4LZ1jBEN0hpD6b56B+CdhssI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN7PR12MB2740.namprd12.prod.outlook.com (2603:10b6:408:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 19:20:54 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:54 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 18/31] EDAC/amd64: Define function to get number of interleaved channels
Date:   Wed, 23 Jun 2021 19:19:49 +0000
Message-Id: <20210623192002.3671647-19-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25324932-199c-41b1-d83f-08d9367c051c
X-MS-TrafficTypeDiagnostic: BN7PR12MB2740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB27404038E2BDA9B34BF34922F8089@BN7PR12MB2740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cOWYvbWue/RyVw4YYWkrWI6b6qXGnX3M6R0IqujjtAbabEF7yeez4DdqJH7CHlSbqR92N8CbDP9cK6oRWekTUm+tndEproAssGY/3zHKaOgi3A0eDhyaoKZ39MjZCNDc2NwAz1IaRfRY35CXnmulPzeiJURu9dNvqfM39Zv2CB2YemLStfqV4RhCdWCwZKYxtrj9fv20RAdpbW+aj6lZ8szh75Wv5jkGjYdFBRNHwR5CvxjddQ7rvsNivQ9npxAfaZhsAfXUiLKZJ53SRctRPtubIDJHz3bMMdzdcXVlL8yn2u/pTXzC8GmHslYMgmUlehNL3yd3OeSOM9DdpJIPpvFubSRgTYhQj+gtpG8mDQXlnq50DoE+/dgk0rt/7K0wTA5voD+1iHP9+mYcrSxus29KOVFpslqaWXIGKnSMrGops1h6iUHF4GtbYRfdxy9nixo4T7MeUEFGJkmF3La6DAELkI7VwgrpRXagakXAmCF6k802Lgodw9FUw2BADAsL1cWfvFZ1/o9C647IV9NNaPCn46gqF3aC3PLBDxpCFJFWuPSuwiDk/s8KLrcj6TuN4u8pN5zxfzq8aKiicdhtopLu68PhUep3dYNj8Z+S1PEfS6Xt2OCFD+vrSCcs2bp8JKyfyUAky7ayYKazz+hjE7Zu/3+SC9QEvbi41tnb74Cexvl1em1V/ai7OtMO+jtDOrODyyg99hHqCKu/+Iy2p/TrKoBYtFv3STb5xejX5OQhBE13+9dBhRTNvcNW0YMzVSXdnkG1oVckzTF2X81Wln98gCEPyqPCg7/V5u05VXo1QAso+8BOad+tFomsIT1g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(5660300002)(6666004)(2906002)(83380400001)(966005)(6486002)(66556008)(66476007)(186003)(26005)(16526019)(86362001)(7696005)(478600001)(52116002)(38100700002)(2616005)(956004)(44832011)(316002)(36756003)(6916009)(1076003)(8936002)(8676002)(66946007)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ky4pJZGsnJeUTziRydqo3CxW2GEe3QoY9ot1zVv2JGWjAUDSepCph2KMSmR7?=
 =?us-ascii?Q?gRjYHv1HS0jylaNwb+oxxoPMLQv5VbvvRjyybOxtM8gs6dEzOwx83wQPdFDQ?=
 =?us-ascii?Q?KOdh3Dcxib+7AMxmO2Xd9kdpp35h8s3bwoaZJJc06UggxOG4cCKuTQW97REt?=
 =?us-ascii?Q?l1Qc1Rmy8Cm87u3WRrt9/SMjz8FLzQ7Ps2uz3cMGdMdkjCVfaQAHXa9beQnx?=
 =?us-ascii?Q?H95CJP2mfgfpCK6fDm93UrlW5g6JanrV9itLHYGWSOlGXgIHO+TikXX/NDun?=
 =?us-ascii?Q?/RcC15BaCH/7lZU2xlhy8My4Zuj0T/uJgNX87ptvH1wL7CCK8IVD6rhHVfxi?=
 =?us-ascii?Q?+f5FnmQfKc0QfBMXQLyBX2tfDW5HGLWNfsrAB8ddT/3gLjQ5eOckBO4a6W5v?=
 =?us-ascii?Q?zKGbsCswKZE5nc7JGi+3DwQKCjjiNvgIMvyPpMrpdHujDEzluZ6xqJmEx1UO?=
 =?us-ascii?Q?ULGNuK/I052P9TmN7cPdm63vNbiK+w543ya+WPTTcgKam41c8z918+SSRSIL?=
 =?us-ascii?Q?AQhht57gp7AE2JALYWwBy3GZPRxmsUWTxOhbXSpU77c6cO8D9KAaUjK/2HNv?=
 =?us-ascii?Q?cMkP0noREF4NxDGIM9iC8EGDjL2a1/kbsU+PCjZiJSVNoAA6TEmMvBtubdZg?=
 =?us-ascii?Q?AsL1l0YVYcvlBs050ABBON3NlMOhB24R8A6RBUzoBcBArHQcRMxHCLIRORbg?=
 =?us-ascii?Q?yTW8ODn+PuesJnlrvLPeJGHY+XSbfjwPvF16o41d3Pzgfi1z58BGDNXWCj5c?=
 =?us-ascii?Q?BAKFT+7vmquz2ReTSqC+WW1XNlmDoJtKIkAavj4K+8psWbxRdQJHJ6W5OxXp?=
 =?us-ascii?Q?Km0L73MjgxTwy2qwTwGSbmu3Ug+vfD9awzYwbEyNHGLTdS4vDGEX7YGWN1J/?=
 =?us-ascii?Q?mR0B1Zp0M7RosyBBxNB0qPhevm4vgq8shoEHKBessyasEvAhmAtF7Fz1CH9P?=
 =?us-ascii?Q?q7j/7AtCP2v22ZRCCbcOYipipXIeWS7xd0Q8ZNBMOPm7nj7jJsoPXD4JD48B?=
 =?us-ascii?Q?cyvwtbtV6Gj10CpjudwMJATnu7zQ0ERic4D9bYjYGbFedQM0MsVangq6cHo4?=
 =?us-ascii?Q?bCmcGwbxif2UlsWOkc0OxHTk6biRy7BthTEpO97o4mlYsYTzo7b6MgjJ2MS6?=
 =?us-ascii?Q?asS1ILIL0jbILetLldoBiyAOR86xDH2evhMlgf209DPXHnxhaMhkNNDtSsKZ?=
 =?us-ascii?Q?KnbK5upodMr6gZTewBOaN+OfUYUxrpjv1Xo85Y8aGE0NI9hWyMKBK/aNumQf?=
 =?us-ascii?Q?L8NsU+H5nwlSx+m40chBaVVsBewQPFZ876sOZlHlZGsRdKeBqrS8Awr2iZEn?=
 =?us-ascii?Q?OR1DFDFL/5UXh++i69o/2g3/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25324932-199c-41b1-d83f-08d9367c051c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:54.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXbbSn+6du/gY24S54m6gLm/E3kuFLJgNNg25wOtP1ptFQ6jnf7qGK2ERQPmv1xQaZgYg446dSQFN1GXfPTpAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2740
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move number of interleaved channel calculation to a separate helper
function. Drop unused cases.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-15-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 42 +++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 02dc34c13d65..80192a05bb93 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1097,6 +1097,7 @@ struct addr_ctx {
 	u8 inst_id;
 	u8 map_num;
 	u8 intlv_addr_bit;
+	u8 intlv_num_chan;
 	u8 cs_id;
 	int (*dehash_addr)(struct addr_ctx *ctx);
 };
@@ -1226,12 +1227,29 @@ static int get_intlv_addr_bit(struct addr_ctx *ctx)
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
@@ -1244,23 +1262,9 @@ static int denormalize_addr(struct addr_ctx *ctx)
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
@@ -1298,8 +1302,8 @@ static int denormalize_addr(struct addr_ctx *ctx)
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

