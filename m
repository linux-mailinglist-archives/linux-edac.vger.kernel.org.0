Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01C850CE3A
	for <lists+linux-edac@lfdr.de>; Sun, 24 Apr 2022 03:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiDXBhm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 23 Apr 2022 21:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbiDXBhi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 23 Apr 2022 21:37:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726611C78E5;
        Sat, 23 Apr 2022 18:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGPGuyBDObeYsda1LsY6mJ86nb5mYAltGIdFVHk6GwofOM0wJQ66fjgHU9eQO5vqrI9MR1kQfN6DVipb5E+gcLN3PsfYChldnL6izaGN7TgrHJ2nSVsPfjllLm5raQO9pSjy9Fe9bZJXV0ujMZ36v7ikPjzreOyZzCw5e4Aa9sbHRnYyR1+Ga+eOKvzqHch+loWQzsSUHDSrurUNCkM0yQRVqHY+h/5H3AhOUDfefJmJNHtVRUoC2Xd8pY5Rb0s1mFLY7vjvmgMVwMxWQzbCiakSKasWjgWoAfJF8zh6MnD8LTCvfP4flR+mO81crXpblJKb5r79NQuD/9EryDPjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxanjDe5IFpB8yyg6ZLFfb94x5Ftowg/aQq7V9hYeQ8=;
 b=Yjt8dBFfN6wZl6n3foXpYXliwh00husVYfGAVpT4/nRHl/mx40uCY/R0tCKlZicLG+99f7sVlIYZcD4FTQnNDidTpDBo8GUrwFhjicVd94AMDiRXt6Im2l9+qRNQdFDMJlAGOYstGWHOFqdcjpmAWACgdIXaYZlfgcZWP32P6XqfsLxFs0W/Az5gIE4klzf6aOWsB/gcJGd+6pdFpP4bKqeEQvm4ycf2EzCTtFDOzSUZcgFZ81uUkeb8vnPuOs3XG+0W2kAv2wZAko29pZfto+pDRQqc7cyE7fRzzZNcE7UWBhlvkN5d5Ua5hxZSVZazzs/bxKKyjkSsYKzxBUNqXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxanjDe5IFpB8yyg6ZLFfb94x5Ftowg/aQq7V9hYeQ8=;
 b=pCNg49S4D+2+duipUX2kw+m5NVmojfTlGp+RQ7Ky9alYFCwfNC8Uo61Udj2cYvYVHC2BEnj0N7iYMd3K4heULLFw3Qoz9HE7prIsCm4jK1NnlEiIis9wWS1xRhcnSHgC9rK2K9H68eenLrwvDqMedVMNIEv8VAcjqOkU/t4dEco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM9PR04MB8179.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Sun, 24 Apr
 2022 01:34:36 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6%5]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 01:34:36 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     michal.simek@xilinx.com, bp@alien8.de,
        Shubhrajyoti.datta@xilinx.com, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH V3 0/2] EDAC: synopsys: fix some bugs in v3.x Synopsys EDAC DDR driver
Date:   Sun, 24 Apr 2022 09:33:43 +0800
Message-Id: <20220424013345.7359-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0121.apcprd03.prod.outlook.com
 (2603:1096:4:91::25) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d197fd4c-1564-41ca-f3f1-08da2592973f
X-MS-TrafficTypeDiagnostic: AM9PR04MB8179:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB81792C8ECFEBE6C55D2E477592F99@AM9PR04MB8179.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5do34cPdYRJZ98iEQErISPNrQkujidaHhOe1x/9AAJmQet7UNGcvshZNt8XczSO/3DzzeB281dANodAG/EX2ZWVkEY8QZ8msJctIprIru1GViGFV5X/cs4xl2Io84Qvp5DfUifpFxjvA3Gv7Z7InR8OaU7BPM95b/H30gCDAyopOCfOg5iKMIpjfTUgKaqUWqyRtGpWS2uten6K7VWX6MzuTl1IvnSNw8vfOJjnPpeMZGg9LwKffUi6pu2MS1XmyCrBdNvbD9W5+W/Gvu00Cn/vVVOZgr41abw0Pp8PszGBAcCfmyHP+ggQhStmX8mn/4Q6F5MmPbRl8jv0wWGh7dPEP1xXUUGGpEdi6fX7camvppbpBN4RVA8fYqgJt8BNaTi022R3refpyTWA7cBUih9mqUi0oZXoXLGIPumc6sGjAjOEF3bwRxtVUZxdbWxh/9jS9PYJELU5KU9lnHitI91BX+hRh1xKXtfEq+VCx1aXA/BEvZh7ik0OLg6HJzFAk36qYrmMUjz0Iq69b82ztCYs772NQU67ytyDGlHwR8QPWr2fUz302mX9Jo5A7+UioH1UMEB4WHCGeGMgtY35vskkxEJby20mcgKg5Ur6NTBbzgMroeSXxZCVgtaE/WYDxZYiboH46JBczjP1eCSSyflMi1fumejKBkXAGomdI+0MxLLzLZ3tNbyNlayIGoufAxfJpyyWZ69Puf78nkEqmEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(5660300002)(8936002)(7416002)(6486002)(508600001)(66556008)(4744005)(316002)(8676002)(4326008)(66476007)(66946007)(26005)(186003)(83380400001)(2906002)(1076003)(2616005)(6666004)(52116002)(44832011)(6506007)(86362001)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HtFfbRJ88i/KBW65mue+NzdcfoRDlxm0obDWaLp8mbmgqOydedh9U/QR38hZ?=
 =?us-ascii?Q?7kelxS4R0+8da1ydp+0faz/0ZY2J15LLNQSSUEM8Cm/vL5WXs5TFgKZlN9/r?=
 =?us-ascii?Q?XaliwlTYgvN7HeKKFkgwGpRCIC7MRPRkTVFlOivRIvVAAZ5LMQPFll1AjqjI?=
 =?us-ascii?Q?AIJzqfP5SFOVqUENmufJwrBx9dsVbE0Cq8Rlawj2G07kRDwUYyBtBFXHpOh2?=
 =?us-ascii?Q?iYY1+BuW7gGt4c5QAZN2JCbBBuDzEnmQwZxMCG26APJNpZIqR8k3mCQnZF15?=
 =?us-ascii?Q?t8D9LVv8rr/V+RX+D6WL04tioH8TI7WkaaSaeQfabRmYNVBNc9oQcwVTx5uC?=
 =?us-ascii?Q?71+iRJFAjfichrwnlE9CnrUwtfjKpMzoXBRm4GKHN6luk06oP2ogZ1F0W60L?=
 =?us-ascii?Q?Fj7TQOp27Z7NDRu4ejxocU2KzUGiXb+yfbMhr5t/yTQ93iFMX0nc+KFzI7QQ?=
 =?us-ascii?Q?WgcISh0nRtf8s42oqgvP0nco6wm+HLvS0rr6SYxtDSWLlLkdDqgH90dZGKii?=
 =?us-ascii?Q?Xx3L1seRLdKPCLJv2AKf1J6Az1PVikK2BdnjScVc2qFTch+85zPjAkzozXgM?=
 =?us-ascii?Q?GGsBcCt4KcrbB1rzs2f6ZFrMt3/kwSbmPIMNrt8atgahbb/zuU9FKdaIcYCr?=
 =?us-ascii?Q?KJBdV8I/miJ1cg7XwPZkOBpLJA2FKVact7vkpVrnHY+EPgC0v8OL1f88jJ/q?=
 =?us-ascii?Q?w9fFVa3IgNooPt5aWfZi5IQyDQ6LtvJ7jCa/+ulxe6s+ftj8hWbUDdvnEE70?=
 =?us-ascii?Q?YmvA+dxiMBsmqau9v3Kbe0BYpLc3a0NeW7qF+rs8T0czOdmF6EHpufbNatcg?=
 =?us-ascii?Q?QLunfN4d4xgN0ZNBfYZpOODWiONtilrTdWmJPoKOhd6cRH8Va3NFIkWi/usq?=
 =?us-ascii?Q?hKUXdu0FDKBBgJpLegzvRV91Cp4Oq5AmstvNH6wEsm52jNrcN2oFsZSmHlPU?=
 =?us-ascii?Q?a/fqSeduhzodKwQgeqlx+L18cJeOV/7PfG1PnAuFbWaHB8SEgDYnKIL9xa76?=
 =?us-ascii?Q?/tRuQvazbIGLsTur3UX/oaReHYIE1FPbZMaN+8iozYIVLLaL4TpedVgG7r+L?=
 =?us-ascii?Q?Vz8ZLqkhO0EL1LBmzxH2+Q8fUc39E6uZEDrU41VrSE7pVgpdvUNVk3Xvnbcg?=
 =?us-ascii?Q?wljJGjqXjJAdhrugDfbDR+JGGNviuTeV5gDzj1W8aM9JJPNw3y9GRtuOaf+9?=
 =?us-ascii?Q?LemrBIO3hyxAf1Wsw9LN5/yibvDPWOrZzP5EBkar5RKYNXEpPMCEhHCl/Ti0?=
 =?us-ascii?Q?L1FOwkATDcKuguljlR88wAVFT6JDfFBThM5eWiEoAv64VxtF0YxxJTWWZO2z?=
 =?us-ascii?Q?eQ0apT4oaq7qE6FXAC8xdfPfqxwvQmjCeY6+HSvxEYNfw3AbibbW91v42BP3?=
 =?us-ascii?Q?LwqfmhfLRlUVmmLmcmLzzq/rmRi9+xTt98Mf77BSNMq1z3zdoZboSvp6ZAM4?=
 =?us-ascii?Q?0Ywo7XrcAdT4LTk4+vq1adGcZN9uj8Cq3G1la9tryWlbcFTSokC+KAzn85yf?=
 =?us-ascii?Q?FAgnmplsp76GN6Xp2fM6JH9fbtLe4XcP8e+IFGQ1wvfGQIaQYRcDsUff5G52?=
 =?us-ascii?Q?L2mnP06tv3Hi989DBRyGX7y4OpJLgo8OoJZRdk2ca8KwJUkOf3WmEgVisuNF?=
 =?us-ascii?Q?NsTakHiRQk5K6YYQX4ljVsiA4l+h+d4x0SpF1ixnUrCAsclP0WP5l5wh7Lr/?=
 =?us-ascii?Q?VihtuhnWttIDF3idCyXjdMk+rZwR+50jhAyI6U5WNZN1tq2lgf60aE0Yl5Zc?=
 =?us-ascii?Q?ridQzo1row=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d197fd4c-1564-41ca-f3f1-08da2592973f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2022 01:34:36.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcTw3KUpw8pJXNPt3MgMFcwAI8PiJoALheiKrB5c8jVxNt4rmOpEaFFa9iw9TmvoIOnMLFbG0TvHA1NnxoEqug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The two patches fix some issues for v3.x Synopsys EDAC DDR in synopsys_edac.c.
For the details, please check the patch commit log. This has been verified on
i.MX8MP platform.

Sherry Sun (2):
  EDAC/synopsys: Disable the error interrupt on Synopsys EDAC v3.x
    hardware
  EDAC/synopsys: Re-enable the interrupts in intr_handler for v3.x
    Synopsys EDAC DDR

 drivers/edac/synopsys_edac.c | 44 ++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

-- 
2.17.1

