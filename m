Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751703B211F
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jun 2021 21:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhFWTYg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Jun 2021 15:24:36 -0400
Received: from mail-dm3nam07on2082.outbound.protection.outlook.com ([40.107.95.82]:56929
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231261AbhFWTYL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Jun 2021 15:24:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FREqMk0VAW1Chk0f1YOYVHkAWvjBEjUXKYzvOsozi4D5qj/OFKznG3ZtlYzf3S7juLmBXhE1AAvc8LMQz1mbJiBTEFBxbU58l4CGNRaBHeZCcMQtOpH6ncn9GNG6PjwUGVUvgmrpRvP/GJKrhP+Ew6XOW6XcHOYsz4/AfHWNAKR6C2lv9KAKw8zaonXIu48EPcMWGoTRSheQ0lxgr2+mN7P96loQgngzlTIX4qzFjnMS1BwhgjKEK4lBjVDcrpZtg2kHzc5iHF/Uau5XmFdtEMURSqPRNz3a1TeS2QP1x5sizEcdLo63YEsdaX77zjucPUG18gbY1HN6x7ZUrM5NtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhDu3MkRoYMa8lekSlvoZUESu+pgkUTjPIq5XLjtz+o=;
 b=BjjaRW1pGwy0Se9zXwGmCtv9C3Pb8+ibmgXNRMIgX4Z4S8svq9C5mgTFQ9ovszNecrY14XV8m++uObSxSIMsZJI/ao8kORyaitAhSHEZLfWZ0pqwc6YBJmMfPQYbK7I+0OAPOaXwXNlSBDXpc761t6W7EObSw+hVmOm2PZsuATFCWZxn1pSBozFYKPu4VaBvSLFRtw6XBacc6o1q3nA6q7xfZY/bYrHcoux1xsXQ+kjZ3unJEwOOYYxCZ169bYN+GbzrLCxO+h4cp2ICcYqLAHTxd8iOZ3xo2/vf5a5egfJPwzJPn8P+TqkWiV/rbtpVfsfJIXGlOEThid0Rqp337g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhDu3MkRoYMa8lekSlvoZUESu+pgkUTjPIq5XLjtz+o=;
 b=WpwoNWMlDmwwTOC+7nQsC+ysZRRmKX02UdFz22esl+784g5gaCP4m5+i8xFT5a8I48SJAYD4ROdUPHxYQiq9ufZ5uQICSOPWdFz43IELK1Hc1UF2RiIw1OJcyse7RQ0W7TmTmW4SAnHAkLKtCOzi71S+1+K1ENBQ6b0BEW83pZM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0211.namprd12.prod.outlook.com (2603:10b6:405:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 19:20:56 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:20:56 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, Smita.KoralahalliChannabasappa@amd.com,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 21/31] EDAC/amd64: Remove unnecessary assert
Date:   Wed, 23 Jun 2021 19:19:52 +0000
Message-Id: <20210623192002.3671647-22-yazen.ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.184.1) by BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 19:20:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0fcc036-fbb4-4fa3-d76b-08d9367c0693
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02118B01B62418F3D5FD253DF8089@BN6PR1201MB0211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0K31rxAHZo8M2bzrq2bbT068j4XQeqVCZegn+n4OSqwppuFO8G6S3qAg8P2bPQuW5it6r4uwtOpzjOyqp/XT1LhO3LV+VFS/X+Vp1RIieFaTJv3RH/i9H7lAYibnn1uUU02H0Jegdr6Gy6VP3qa/zlK8TSVRvsqLl6Ef2irpQAXxj3PRAzbEw+2fX/bFXhZzG5C/hw63wHk1TDy1fGNNvrYyas8WsytNKVa76Ve2fDQT3CwjH8T6vaJcZ9tl7wq18/V5gJxBB5rbevQu8fTiqefGXpl3a8CjQUVZmj0WZSQsIxSeBaztEAY8cx2kqkkkfH/QHUNrwr6UdrM7QAe0jRiFwDaMSa/IBdaSfXo0SVoklkMSS47C57pgAtLXRBbr0EP7ZePdFgAl9HsuLhcHH6P7hMLatTDFOOI6NK3WiF+ERkmE2U+eENXNadm7F0FcNwoG8/KG9suhWkr6kafE6au9/3pgE+pRL2KrL2mBtmVmfWIFbKVEd/DDRfiQ7eI/kapZuF/FEMpQtAFEE9lfVMmKgd6DGmBn497enBg/OdEaXLOrBjbzTTp9c0EigsPnq5EVfj9Hh1bECZcnOdbUTczmPPEEhRAECT3k1q+Xn8RqXMwj6GHtCFiIDknE/kBIcN53GspctAuf8Y/TxlURpcAV/bO0MG7VHJVZftGoe/DA3MDbNtG7EspsL13dwdhRO3EQbU/O+2gwduFJGn+3J032cc9oo6MMuUPZHlpeE+ZRERVM5tfdaTFp7VjmQwpAwXQpmXfUENYdmx3PQjOOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(1076003)(6666004)(86362001)(4744005)(956004)(66946007)(2616005)(36756003)(316002)(5660300002)(83380400001)(6486002)(966005)(38100700002)(478600001)(26005)(16526019)(186003)(7696005)(52116002)(6916009)(8676002)(66556008)(66476007)(4326008)(8936002)(2906002)(38350700002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hms2nZxInr1UzqjZKXecHkxpydJS3856ALBzP/dWRAwJ7t/ej/ZP7JF+5TDG?=
 =?us-ascii?Q?M8+H+l2svhCIpLvGcHaXjshDrBdL6kl5SB8HpYNjBYnUvJv3Qzw32o9my3w8?=
 =?us-ascii?Q?aCr0+Z0LheIhzdGgOnUTzXnysZZGefSSTzFbYpeEXhXlKlgWz0E9gUcGUr6p?=
 =?us-ascii?Q?7AQyvmO9aD8riZdd7nGWPiKSNxh3jhMUkHeJeDw/Pf4oUZGR2sxmjhGnym/j?=
 =?us-ascii?Q?1WvwMrj2opufIXnnGNNbKP+tqSWt2YAccXCWUvenjwVvU1FWdXhIV01Avpqb?=
 =?us-ascii?Q?tCqZEyL4zeevkxRn6Q1bAbijy1w6Fk50DBelqUl29iiLlt3B+MtIqJe0sP61?=
 =?us-ascii?Q?XcqgNNAJEV8RqcbOWbVndUltlt5HtYPnesM8FE8D8rzPwZL2+upxYMEUrlm6?=
 =?us-ascii?Q?/Wo1t2sXn5SSanh6h3Ew56Yt52NgcuhyqIoxSq3twI3AKCYKyEM50VoTSiDI?=
 =?us-ascii?Q?4wS1wynxU41HW24f+qrwkhywr68dI9+WyNsqF51SNnidRLac66xiCMHwSRio?=
 =?us-ascii?Q?b61HMCMU1AjWOG8CxOvXTvzIXIHxtwNf1iK8gYzUoyjYkzwfmYcsEAuMmcQx?=
 =?us-ascii?Q?n8XffwgI2rAnvGMxktlDaIJNLg4TJU0afUwddlgfRRTcNq5vbolFNNjx6M9+?=
 =?us-ascii?Q?EQaJub9w/iAezWOwpHNmSj2/GLh2O0292ED0H5o2kb79Majd7KbS+P8E1NwJ?=
 =?us-ascii?Q?azJHAOr1+xXUOxWhGi4M0a5lwZ63iVre7Bnp2DOfDzJlx9OIGE6oNinKs3Bv?=
 =?us-ascii?Q?p9Y4d3XUkXxa4+H6LVw1Rn2jq30S+V4dxyJaNQbPDaiP8HFw5n2uL9kISNOD?=
 =?us-ascii?Q?/5XBMHD1SjXgLcVd0k8DGFzGC0jjyG+kXB25GAd7hqnJneBJ7/7rFUUTrgAW?=
 =?us-ascii?Q?DMPVEXOeCb2pzoMyPzl4laPhu3lrAI6GjJ5K0kPKY3nodWJsJibC4HSTP6oW?=
 =?us-ascii?Q?J1Idgm5VJrjX22BIjGCE4nG2hcpePkgT+K211KrpaPBfWt4L5aXek/JftnkL?=
 =?us-ascii?Q?mWkho6KV7HCP2by7NRja0JVosf1idzC5dx48asn6vQbcCYBpQIILe0fs2rqP?=
 =?us-ascii?Q?nj1s0C5//HNB8KbOTKBBBdvaTrZ9zMoDX3CFYKGWyKoQcpYDOvQ/qA2WdMXm?=
 =?us-ascii?Q?YOvcEz1fNZVJrlzhQIrYpMDID7v//AOonZy1fJSdOFNrKaUHCri9YdlhnUkp?=
 =?us-ascii?Q?KA35If69zoXb9Flo4clKeyD5mD6cBdxOj1dvhsFdjR+MFDAR3a4/Hv41NHRu?=
 =?us-ascii?Q?Vwn/gS47F/yoR8MzhGiESwX5yVmlpmE23QWK4bmII+uz8XYAWYZIKjuAcs0u?=
 =?us-ascii?Q?cbzBsruGeJ8yDvigseezVlEQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fcc036-fbb4-4fa3-d76b-08d9367c0693
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:20:56.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1C14nWr6cJOeRG4fA3kMviupFCKKRqhDMxeUHisT1hSeYR/uiRnwSaJDdnByg4qKcoFErVbVDcjczY8/nHXLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0211
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

It was removed in the reference code, so remove it here.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210507190140.18854-18-Yazen.Ghannam@amd.com

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 09cdc0466ae2..e5c296b00f5c 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1282,13 +1282,6 @@ static int denormalize_addr(struct addr_ctx *ctx)
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

