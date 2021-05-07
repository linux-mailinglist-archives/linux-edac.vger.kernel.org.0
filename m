Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B25376A5B
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhEGTDc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:03:32 -0400
Received: from mail-eopbgr770081.outbound.protection.outlook.com ([40.107.77.81]:44439
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229889AbhEGTDU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:03:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFna1FKul93FE+vNtlBtifrIyoRDAwujIMNw6FVElNx3KcTg0jEGSyKlqqyt63JxI7nw9eR4sDPulP6qg02/mZiGu9SZxqEUQBRhlxBJruCZ3w7lESLgsIsmgiq3QwmdEgTyqtV/EnEOIstdZMX2UWGDyIAD8oM7lRfnlksYm0hrDuCHDe+o6taj5EH57Xcrx9mV8vd0oPTy/S3j8CPox9+hHcLWjkjFm4EJPHVLd77/jVzhJKPt+0Pkh2bmNs7SbOlPSG8p9p32wEOxFztX3r3BKoe92vM7a1tcT6EzgIOBkxLvrIJxnmmqw85B02qCYsKFm3XjfR8RNiulPCy3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvYXxY2mPfpY0fjm+vdKhYMf0GXw/6mRrRa+m6NjwEo=;
 b=CEsEgzJ3I79tgmShHYHu241GLqHfRr2toPWjynzfFewWphC4lS/H15qDSxKgXf4BR4boxVOdgYboc1g2xIZHrQq+qfFDLzf0mPNMQ4eIKgZB7SZnb7PNnCTqyadMkGTMRbXCgb01ZZ06EB4ckYhekFv2J7T8FniIoL8aI4TETtVbuzNCkTnBGNkh8igQUCtRfEm6KJtDOkDqPzQwUDuS2qH50zZNvP1kasfisGJrOznR6MK0vn8VRkP15uXqJNIQpK+x9dpuB9HWcV+Ld0g4Z/KFGMlCDePDI2gzYE7RKwj6xcYvQpucfy+d6Thg7+9rxz7HnBwGuw6Xmq3dtgniOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvYXxY2mPfpY0fjm+vdKhYMf0GXw/6mRrRa+m6NjwEo=;
 b=OBy3HWnYRhmAjKj3yyH3DS4zR7BG8XoFoFYDybR3ckftY0jFPrM9BYZ6r7I/el0TEJBnkAGlTZvLbxABRmMEPXk6LE/6uhFuuTflADOti1xQSwnzFt+u9WhmnADNATJ5DCwTdbwD8dvOcnuzsA/Dn6+Y+dDqJo/Z4j8mTvNxMC4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1620.namprd12.prod.outlook.com (2603:10b6:405:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 19:02:08 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:08 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 15/25] x86/MCE/AMD: Define function to get number of interleaved dies
Date:   Fri,  7 May 2021 15:01:30 -0400
Message-Id: <20210507190140.18854-16-Yazen.Ghannam@amd.com>
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
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d87ed3a-b9fe-446a-a9f2-08d9118a9cad
X-MS-TrafficTypeDiagnostic: BN6PR12MB1620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1620A21E7C4369638319D6F9F8579@BN6PR12MB1620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7akEjogrtvv5YWLAoDTuvUaF7MkbbeC8mMdmkQwQXwYTQGRyEilHbmgBUTCrPguZGNvw7Aizl+DO7mRw+XEqFun2jK9ZVd6ChWOlkQYZU6bQXC97STTuE8kj4qgoMjp1Tsumil3ktAiSohaHisKFdoCiy0hpT/Y91ts1TCi7UxHqBbWQg73/Q2vW4nxaM5MqPtQyaPZ/E/xPMxHIvOS3wouBi6cvAB/aW3mDzAYRrUXYuA7V8CAvnwnwAa+TrV54YsxsxADgFxnXt3Md9YOIazr1sdixlLD6zHcPxFT66t2jSoOuew9WF19vNgnebp4+//CNjZOfTRaf2cxen4C9HF5zerl4MQvkRxzxnV+v/PRM+VbM27O7VbwpC02iJuugugkyecJNLxubIpB/bLp9W37MSnkpRmoWjgRcPwr9O3hnREiOPB+/rfateZony+oSOLKfCNMXcV/Zgqz2NjuSUmO59HY8JMXEEyk/oGeWBDCKMP4MLTJfKj/aT+AYGD9CibeDflKHDRbM2KxINFcL888j8OQbD61GQGKEx/o7wwr3Hd2k+fwkTZk8rn5uNnuGeXoZTwJpjJcz9BvLxEuuDuNL5IxbXafXNNhg61nOHDIcMf4brguZji3EPWjjw+m4DHfue0QEO3RqN+MyZgSOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(4326008)(6666004)(38350700002)(38100700002)(66556008)(2906002)(26005)(6486002)(66476007)(1076003)(16526019)(86362001)(6916009)(66946007)(2616005)(956004)(186003)(5660300002)(36756003)(478600001)(316002)(52116002)(7696005)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WvgyQw0mMsinaCbt27IErTuDfvk2gBoPCS8Do5JQKet9nFNv6HsSfZnl8ziJ?=
 =?us-ascii?Q?3o91c9fOPY7TXHJXoLmmKUMYPvqIbKlQTF4vnhRaqL2Tfoh8smC7oCsEQlMw?=
 =?us-ascii?Q?EGJUsLqd37g1LW/q+0Ir325NQxfoEc0IZprxUEStjJw+lARM+h0Be4ODQJOk?=
 =?us-ascii?Q?ANGxUT/T5O3ZQGxmCdlsLpJpYZwSWwSyL9Yl4k2l0KJdh7IXtSuxqC4vJlOK?=
 =?us-ascii?Q?Zy3rhaeFLgPD4Coctpin3YUHbgnZWvR8IUUj6BX3qLWjbkljRORtSME3xxjK?=
 =?us-ascii?Q?pYc15BsY9fz/yv89od/8AQQ0AIJ+oSS8G4W8XJUA2qOB5Mdnglam7AhyHQiG?=
 =?us-ascii?Q?pCBTYaUVvOVonoZ1ryE4BMWsP98hsBM8UBBmk+1kenGdyTNX8TAVCl2FO99A?=
 =?us-ascii?Q?HBDXfCWigEoWJDzLPBP4rAAnklu8PagdKuMI/y/ZrY/XA71Xxit1PvOJ5hFC?=
 =?us-ascii?Q?u36AUUltUdNugm5Hw2LDE6/uakHKPBFgBKZB/PEXR9TFv1KsngKhMzVkMCcl?=
 =?us-ascii?Q?uz9XMCCA2iY+QqoRc+OoR0Eud/4DlhMZ1Lkj8sBbWdzU+LXvp6ih6QULinBT?=
 =?us-ascii?Q?yved56+P0QJoKyw9hyYjdlgaEN5W9u8Hx7F+hP3aHgR3a83FsZGvra5Mghz6?=
 =?us-ascii?Q?9+LhkSAe/9+AooKv8UdTdEZZFxcJQKIIbwSWsy0SrHcu1GRB4gn/v9aDKQ1g?=
 =?us-ascii?Q?9mIJDFOtVoneQTVffvNOTseUL7Q8ClQbfFRYDpPMhRff6fhkz2KtRMZEEnFp?=
 =?us-ascii?Q?eW4PYfdqkV5hyRg5f2fec3IYGiBbLlMkiOZLKC+CsCa40HXRow6w2uGLtJHU?=
 =?us-ascii?Q?jURxS9SKQvvXvqC1ZYtKFzJQk25x4LSA19wnHMaBWgqHcfKrhH1192VAh296?=
 =?us-ascii?Q?GZGuXI1V9SuLNx5er89/E1SyPpg1rhxeGx0A3OsJr5CuLhEQEWq8i/wlducW?=
 =?us-ascii?Q?XdIkmdopdcPmu9NeKIqzAZNukqO/CgxEhxyLD+k4qBrXqxJzLvnCPV+7YGkt?=
 =?us-ascii?Q?wtH2L4btz8GojqSj+7HcpnfSdoB40Lo98xIeqrNyxhOY+Y0ZwPzJK1Xy/+NO?=
 =?us-ascii?Q?wshmGQS66KrZCOqaPq4NPHLEU6crBx8QfR2uj//OzQBUBRmllWWuIFwQ8Ojt?=
 =?us-ascii?Q?SHbVkw0vUs6e1EOSnfpgQrdfkICMdTLBt+h6rCjjspmYHgLVwlP8hEHqpsRP?=
 =?us-ascii?Q?T2F5A6CiF/4XZdjG9dho1UnYWL4Dx5FMtN7HolwuogSPhfWMw8s8YLOxrlIQ?=
 =?us-ascii?Q?MVauppVmbRM/1VC0Js2CQIsw0yY+KT9kTOxdsN5awuXb3B1yc9lvon3UTtBx?=
 =?us-ascii?Q?BVTLCR1i3sUes/D1xKrUpB4f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d87ed3a-b9fe-446a-a9f2-08d9118a9cad
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:08.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nstXOyePszPpd/RG04yECtpTrx0o+N4Xr1mxSyfDjs52ujy6zGCE2UyJocTzvxYtUapGAlBlG+PWgSv7m+nspQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1620
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Move parsing of the number of interleaved dies to a separate helper
function. This will be expanded for future DF versions. Also, drop an
unneeded assert to match the reference code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 0c24bdc346a3..de59fa6cf540 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -730,6 +730,7 @@ struct addr_ctx {
 	u8 map_num;
 	u8 intlv_addr_bit;
 	u8 intlv_num_chan;
+	u8 intlv_num_dies;
 	u8 cs_id;
 	bool hash_enabled;
 };
@@ -848,12 +849,17 @@ static void get_intlv_num_chan(struct addr_ctx *ctx)
 	}
 }
 
+static void get_intlv_num_dies(struct addr_ctx *ctx)
+{
+	ctx->intlv_num_dies  = (ctx->reg_limit_addr >> 10) & 0x3;
+}
+
 static int denormalize_addr(struct addr_ctx *ctx)
 {
 	u32 tmp;
 
 	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_dies, intlv_num_sockets;
+	u8 intlv_num_sockets;
 	u8 num_intlv_bits, cs_mask = 0;
 
 	/* Return early if no interleaving. */
@@ -864,19 +870,12 @@ static int denormalize_addr(struct addr_ctx *ctx)
 		return -EINVAL;
 
 	intlv_num_sockets = (ctx->reg_limit_addr >> 8) & 0x1;
-	intlv_num_dies	  = (ctx->reg_limit_addr >> 10) & 0x3;
 
 	get_intlv_num_chan(ctx);
+	get_intlv_num_dies(ctx);
 
 	num_intlv_bits = ctx->intlv_num_chan;
-
-	if (intlv_num_dies > 2) {
-		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
-			__func__, intlv_num_dies);
-		return -EINVAL;
-	}
-
-	num_intlv_bits += intlv_num_dies;
+	num_intlv_bits += ctx->intlv_num_dies;
 
 	/* Add a bit if sockets are interleaved. */
 	num_intlv_bits += intlv_num_sockets;
@@ -913,14 +912,14 @@ static int denormalize_addr(struct addr_ctx *ctx)
 
 		sock_id_bit = die_id_bit;
 
-		if (intlv_num_dies || intlv_num_sockets)
+		if (ctx->intlv_num_dies || intlv_num_sockets)
 			if (amd_df_indirect_read(ctx->nid, df_regs[SYS_FAB_ID_MASK],
 						 ctx->umc, &tmp))
 				return -EINVAL;
 
 		/* If interleaved over more than 1 die. */
-		if (intlv_num_dies) {
-			sock_id_bit  = die_id_bit + intlv_num_dies;
+		if (ctx->intlv_num_dies) {
+			sock_id_bit  = die_id_bit + ctx->intlv_num_dies;
 			die_id_shift = (tmp >> 24) & 0xF;
 			die_id_mask  = (tmp >> 8) & 0xFF;
 
-- 
2.25.1

