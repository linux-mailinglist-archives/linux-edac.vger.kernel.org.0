Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D221D746E69
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 12:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjGDKSr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 06:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjGDKSo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 06:18:44 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6011AD;
        Tue,  4 Jul 2023 03:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYEKrtY03UvgIDttvHu9jMeccAse0ywKfWZJkAfr4EB0dsl2XRNyFUi0SpcuUKKkJ44Jb9xa/05IAbUl9lgb+sEhR5a95Nmd82m56bBG2jt1qoewikbQEIYRl6uHHklmhKW2cd60KPiqTNUP+nTJIsZH5U6BcLARg3QxiohPx2G9wF/DFvRSqerDh/rbEvRnrTO8Z+Qzk7X9XsacCUcYiwTBNl5YFfWnuoT3tmp9esF8d7O1Gr1bTpcqOHf/FWRdYjqexbPWsXDhwIRF7F9SBh2hgl/IZY8DhZzUis1w1HOZ33aXztjYRdRDcRhUR1o/R6jDcFvQxIw9pEVicPw/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V68J+9ixv0SUBG8zH4xtep/QwhChI0iWjyd6h3+O88w=;
 b=JoPwS11NKBOEnH1NOgmdf8QWh0mdYB9GAruqlWnv7Qp0H1W2gkWDV7T8YLknqiL3h/n1UHH7/8CshqDWJgzyMj26FKxp/CcYXmKz/vWShy8tZOQIwSy0Qw34Rl9VQXTQtbgcIgwbIlHKooRTAyQK0gzLxA+I4x8ouLMZOomhqssF9NHYkpbU8AkCs7G+LGd48Et11Gf7yKmdFBskt25UA6kMVPLhR572iseYpub90U3EzjdpTJo2bdvGcouGFA54pHA9XFgcOE0h8rWHRNFnOiqBYoMdMnOvTubeS4IyEChjtfBZWi/SW3H1NlotjlBw0U7qSRzd/vB4IfTITKdzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V68J+9ixv0SUBG8zH4xtep/QwhChI0iWjyd6h3+O88w=;
 b=heYoqMLYvUpdqD52+01/BFzh0XrPs3D4+QQpFedu7qQC/POnX9xu1WTx6owXed7J71/beRWKdgjsOX4RbUV9kfs2BmQEOW8UvhG8lyRKCj3W//i+lNvcuF8pGWsrvOlpvsf8+hb/ZOYJqqDz2G2MHAzer0f3LAR58/1fVpbfMa+11B2tEbGaWf/uUM/4zYLeIuI/dvVTeti2DuuGxuflj7+TieptF9QICPRVkukpGVHBiB/NWtKwlWMRhEAD7gxN+Qjg/zHA8nuwUdLtCpqBKe3pMIiO/tdCEzoxgZ247rQh4bwqttqHELFrZOLPTH5SLbuCq6ja8aKRH1vMGi3lsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6036.apcprd06.prod.outlook.com (2603:1096:101:da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:18:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:18:32 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Khuong Dinh <khuong@os.amperecomputing.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] EDAC/xgene: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 18:18:10 +0800
Message-Id: <20230704101811.49637-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704101811.49637-1-frank.li@vivo.com>
References: <20230704101811.49637-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: ef605347-d95a-4051-6d73-08db7c780511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbT+zkAWRsBFdyVqBAh3A57vzR/Sa8XbD7uq+Mk2IYKOtLUsBlJI2pQ2S5YRXiQNkOBVFJnDbdcz/tECSChUiZVueh/mu0Y+tOdH0RXOPWza2kKL2iTZ6QxSE9tFR5BPu3Q6wuz+H1DKF2Jq7T9FlJBKWQ3KP6ocMNHyNkniOayo8MIodF7j9yoCTkVfDmEyfdqrh3G01z9LnIeJ5L4oSq0D738dNo2DX4dTDwF7VC4aQPc0cBtR1yMnbkU2TuLiGEQGt0vu5ppN54n41qMQYAk/zjWaDZX+9ivld9qtpEamJxAkM9pl1qMhk/bsrBlIo0Os8ttDDpEHq1zAMBTN4Z9kuzdFJlf/N8YoO06WCIYoTiZhTLAldg0b47X7nrLmONYfYiSjUSzTBHCO+edK6VG51mM+JDtleAR8w6vzveeKgwBVUNjDthMDfRm5W1ZuWZDl3yk++ljmV5jjPBQ+coD07bUFoIrgmjH1c5rofZBr7vw42wfEHo5AlIP86FqOD+0moMCmj736xZNTClng+Xsp40YO7/qDBlXTqFMXXNjBTe2ReRw17ouaOWUQuqA8ZgkHRDIXSsuTL7F53zdzsN5OJNNJHZOHLclXGXgtev9nEuXUiWETx6An7UIDbEx4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(4326008)(316002)(66946007)(66556008)(86362001)(186003)(26005)(6512007)(66476007)(1076003)(6506007)(83380400001)(2616005)(4744005)(2906002)(6486002)(38100700002)(6666004)(52116002)(38350700002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JdPVLUOPhpZlerQZUQ9BuiEthZnBMlde9yHxGcHgny2JRlwzxxx/F6KYbdSM?=
 =?us-ascii?Q?3qTVe9OBJwCq3FjTvZK/mXH421kHF9Ud49+nYgJw2N3sI6YaeeQphW+tiH9d?=
 =?us-ascii?Q?RaAruTePRe+xyoa5r52O54gbOt3jhb5Zxe2f6VHOqaUrjitVPsAyoSGku501?=
 =?us-ascii?Q?ecEyVRvM6NRQPtueoTzfXgpSJ/3jpr9ILyCg5Op13AFhKrNOR+mNEGMKJ3yl?=
 =?us-ascii?Q?JH9ApH0pql3N3vvwniMjneMw8XujFblM0ll+1dEow0LS6l8kY/tiO9T4Pka2?=
 =?us-ascii?Q?5+nmFtWJ3pa/x3+z89m7g78Xkx/NQgwfPpfWo63wnFgkrIHKBC/yHtmhvgF+?=
 =?us-ascii?Q?tkbNv81XypzMSQw5CfftMBO+nJjBviJbA42OiUBVPCM0s7VGFICupslnCoYT?=
 =?us-ascii?Q?utqqVP6Xg0yraNw6qo49l+xLyDZziG+IfMl6t+5PL4J8hSuRXapuS67HpESN?=
 =?us-ascii?Q?GyyLZcFT17bJRqHXIPLmy1CSk1qeIBXIac5tT0lfGJoIOI8GAvhYpqrc7CiP?=
 =?us-ascii?Q?1KVRNNdwv8s63goAvVeWPj4q4XCGoJgXqrW+/8+CradPM7aHezTppqHp4S4B?=
 =?us-ascii?Q?Z81f6l2/7I2+ML0WCouhtF5PIlM7n/t0FvPlqckeXFzSrJp7yaTwxsOl1Tw7?=
 =?us-ascii?Q?AdCUyL4RWMUBZrDVu/whWZZrJm0Wna2Qi9zEUkoT7H4uAN8CT97998xfr2lu?=
 =?us-ascii?Q?StBGCL8m9ljUWWMGIB3kAt67Xy6XW0LgiCrp0MQCMjjDNpcKs+aPBFPYAM3H?=
 =?us-ascii?Q?89SjEhTS711VlIXLbgIp9VLd+2iJNrdIuhD2nSIalI+6VvkLXGc1R7ZQHKda?=
 =?us-ascii?Q?Y3SovQbzR3RibpEO+77k+HuPW7altEwGHSKLylQldD+9XhO/M+Q/onRVi8Ku?=
 =?us-ascii?Q?OP31t2TzTOT2YtnNCBb9idg+FfR8MW3U+b25TiPB6Qr9t5IhPvQNA5yNUWns?=
 =?us-ascii?Q?G4q5919Izkz1JvvvaPJylxLFEWGA3KXNElTvQw8M568qY9041cHK02z8zm9l?=
 =?us-ascii?Q?WTroyBIOCZ4S+NMyOw4lXPEa6COdtQK246llc0/EId3dcxY5q37C+kf2DQvD?=
 =?us-ascii?Q?pm6Nt3uGS0C5l5msFWL303QMInvJFBrIzbTrSX4TI/NAKi2a8X6j+v3noCV7?=
 =?us-ascii?Q?yMDbR7WsGf6/tBlIpT/AJ1CsZDeAHWDxhf41YI2pUOwafD1vi3ecpsZLWJqa?=
 =?us-ascii?Q?xGg9a4KtbUc11iq7iwhdTWGA5nvuGTYY+9UBXLsnWN2CQi/oLHO+5L+uICMQ?=
 =?us-ascii?Q?nBtx9eyvd/X5ChbAZQa8t7TTomIVcxhoT2BHMtRr4vpcZnLJmE2t8mWte8hG?=
 =?us-ascii?Q?Hh5Cysi9Cpj95hrCW/4dI643rXLLPVBQQJJ3Gr65egDiMcCKDiiyL9CRZ88D?=
 =?us-ascii?Q?8AKyGtvxKAhzPGHFyKY7vYkmjRLxKtQu78VCnYE8ltozMUwatDtOMZUgmeX0?=
 =?us-ascii?Q?roYmdiCE07jNoiKMtHkOYcBLQW+PNU6lHpUSRdnSXU6HlztCX5ErpbLomDNg?=
 =?us-ascii?Q?oZYtCVQd/c7TA/UwG07gcRW86wJcuv9R6KiliW73Xkf8qscpEtPDuRtodN3J?=
 =?us-ascii?Q?ROhUNdxeIekY6OuRcRj33S+Smk1dPnQcW9kAFKTa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef605347-d95a-4051-6d73-08db7c780511
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:18:32.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSHWPr89dLu6q/eCU0ViC9HxHdzd5cCRrxP8zU5mrJ4jkj2rkMfmKaz1qsDRSMr8HJ4mjsQ4e3SthtQg2xm1vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/edac/xgene_edac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index c52b9dd9154c..5ac1a0d3495b 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -1845,7 +1845,6 @@ static int xgene_edac_probe(struct platform_device *pdev)
 {
 	struct xgene_edac *edac;
 	struct device_node *child;
-	struct resource *res;
 	int rc;
 
 	edac = devm_kzalloc(&pdev->dev, sizeof(*edac), GFP_KERNEL);
@@ -1903,8 +1902,7 @@ static int xgene_edac_probe(struct platform_device *pdev)
 		edac->rb_map = NULL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	edac->pcp_csr = devm_ioremap_resource(&pdev->dev, res);
+	edac->pcp_csr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(edac->pcp_csr)) {
 		dev_err(&pdev->dev, "no PCP resource address\n");
 		rc = PTR_ERR(edac->pcp_csr);
-- 
2.39.0

