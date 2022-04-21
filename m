Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710655094DB
	for <lists+linux-edac@lfdr.de>; Thu, 21 Apr 2022 03:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357029AbiDUB7e (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Apr 2022 21:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238864AbiDUB7d (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Apr 2022 21:59:33 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DC3333;
        Wed, 20 Apr 2022 18:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9tbXuSd6zHGBRDXf2+0EUvoRB9QKcmdNSNq/83MLps9n6cMpXIKnYtGX0G1VrfaxMC3inHZ0+lnLFqakmSkg9UtA30X6u4bFng9YNz3MWJ0T9N2HjOH38PwBhOP7h03uGfP1tEiSMSwtrs+mS94XFlC5eS94SgiUI3+LnZdjKBgPJGiEAAvs8m5iRmBxDnOI8wOkmQSzZMfxMrDY6vzbtezAxOp6crV64cKM4zofJtHnEQ9td0EhtRyFUOdVE69/DW5ZE/rska0NnSzLe1EjuBdcWGBdoCE4CVc8YwSwpEOoy3LiiZ6wJw84jzNLIpnM5Z2ZE3l4TWXU6l8mPGpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmedbkzsrtNbfac0i1cx10rR+ThhukgbfoNnb24Ofbo=;
 b=E5/TjHaOBHGbIU8XNlPNbNojOSf2X+aRH/Zl5cqat+aYBbrGDTylhc6ldHZbF3bdsdXIkY+isya3BtynCRIs6u91mMRYhoFIqdDRR02MCK/87uOZL9MZMFWqEyhkWK6LnHB0kAtvAU1PFj3dD+j8AHd4OLJcCkZYJ+weQrwH8Kw5oi3jYU+j4iIjDIaQgZ4qRe6uYMO3H5g3mqWsyoKiO+3qjfeCsmAu9XLzMzIlmwa1OsgmWI6DfIRCYxbuFAbtucyW0b+nww/69xzMXllw+ujVUwra8g8felXm9r+6Xz1fCq3DCjvkqQp5/Y2i0hIxDcWzo8hjCRBUmmAGi4iaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmedbkzsrtNbfac0i1cx10rR+ThhukgbfoNnb24Ofbo=;
 b=HCeZ/8niAK3xOxddNYZ09o+cOc7Q/WYClxRLwtkrnoSY0jT/aLVg118c2zs++24yT+HnQlL8uRL6SS1kewRukE0jjYC6KPMfMNcBt/rmHttsm6GRYacq3rPdtxQEZsJEb5IbtGFpUAJde650eHt8ZPq+ikvRm5jeEraJob6HUPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 01:56:43 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::55a2:d9e8:2c99:1433]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::55a2:d9e8:2c99:1433%4]) with mapi id 15.20.5186.013; Thu, 21 Apr 2022
 01:56:43 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     michal.simek@xilinx.com, bp@alien8.de,
        Shubhrajyoti.datta@xilinx.com, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH V2 1/2] EDAC: synopsys: Add disable_intr support for V3.X Synopsys EDAC DDR
Date:   Thu, 21 Apr 2022 09:53:12 +0800
Message-Id: <20220421015313.5747-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421015313.5747-1-sherry.sun@nxp.com>
References: <20220421015313.5747-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 721845a6-4a9d-48f0-c772-08da233a2f02
X-MS-TrafficTypeDiagnostic: DBBPR04MB7564:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB756482177FD8355DBE74856D92F49@DBBPR04MB7564.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YV2niFcFm7ht+2M0TjEESft1kS894NFxGeXyqhh1kYI7wXzsoovDGNJOiFvt0WdPUrtB8bWPg0hnJATxmd1Mx20NaJN3NE2z1jxsJbac5vAowX2Eo8dcswR5NmvGzrgRMFJ/qRerZvcZRvyJByZqiF7GEFivc9oqADgMPfqI9JfiuL/dKQUwMsrifO+gCX8Fb1QtKSZiUxNRi7EBcXXixdoN3F3U8DYxrJuZwnVEIm0vbhz4oiSgOnu0N8KbwKugkGCEAUQcYhvOGK9jUxOYzgkCkCzSqF23eeVdaBx7Q8dsZHmaSbUZSqyAeXiJ9wlU7GEuRlUaSQjgBcyg6W+enCLT5/4xwLrXjSE/y8MlDLXAKEo6Pxuo03EnxyhJbipm1oJsgA05C5ZWBe9XT3phdTV5O7xxbXK2zMnpEBKXX799gwQjTnysdt55NqeNUxTwha+GmaKmxFrGwTKGaUVW1wXhwZqV0mAuPZTOs3weRDWJ6V8iSXekp2XC20+IWC2LiSPw/fSdIu3YWk8GEGZtAmc+j7W5Tjd/znaLzKeZNEPv6UzCUm88p00869i8nOp4hQYqG2QznajjKrfHBNa49SAhVYy+yE/G5VyhKpBqRWCDIqtXkmy6HfXwPYSjGF+WJVLteVbLZfjTrDMOQAenbdHJGv4rIbxs/ntU4LS/wKk9fdL7qxtpPHmapY20u7kpCj5FxznLOH95NPId3Q0Z0Hm9PWLoU70akxVlYUpBM59Wl6PVCv8OOFuDerI+2J8Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(7416002)(38100700002)(38350700002)(508600001)(8936002)(5660300002)(6486002)(316002)(52116002)(6506007)(4326008)(8676002)(66476007)(66556008)(66946007)(6666004)(186003)(36756003)(83380400001)(2906002)(2616005)(6512007)(26005)(44832011)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OLKt1ErevKOs/2CQyvLdFxDBVRKWv39hSemhsDoYAYV4cmjxZz+Lg1uBAVh2?=
 =?us-ascii?Q?oaicQEh01aEmCkjxg61naainIPbPB7IT+rQHrmjLmMPGCb3PS06/rdmVji7o?=
 =?us-ascii?Q?X3ZnXWXmnENMW4n3Ov1PX/baVv76bGqoaFUpkUYtiO0OG1u+bD4KSIDgsAf/?=
 =?us-ascii?Q?ZwSTQNjVy6wBjvc5HdoS2BQ6DAOWCKMBFyZ4Dm4F2/BTkcHbJaanOFQtwvLT?=
 =?us-ascii?Q?GqYq6BAmd3t/IZPZ4aFQoqu75S4h58u5bc35uHgr/mEsXDgOHlu5DARV20f1?=
 =?us-ascii?Q?2+bjBQHyP0UR4LyLWrJ3VAZhPuu1VIt7i+PvUHKjHyGwbORKR8FC6QQpbj9q?=
 =?us-ascii?Q?L9ZqGhpi6pV4IZAWo2IbTREt8ZPgmKmkX6xp3dpVY+sh3D+YcxLvGAttgIqs?=
 =?us-ascii?Q?oG/iCOS10TNM04UbZxAC5oa3UQacUSfc5S7jhrckYmt4/agvKZfB8ghJ7Z/8?=
 =?us-ascii?Q?jEmEKPPEcfExnoT7lRL4nSLr3N8F7D6eBebrlCqNJMVV9MCiVKAwe2nHSmS4?=
 =?us-ascii?Q?T/vQYNhdXxHqLmVhB6trFSWFGr6DksjfAdI3K2vA6D37Cb4rMBNn2CNzaFpx?=
 =?us-ascii?Q?XSghCDj8APY6tWzR+FUMkoT5Kvz02Jiu1zlRVtPnHw1qi0ub8usdt3rxD5CL?=
 =?us-ascii?Q?Qwn1fm/quTnEcBBgJI5BrLBzx+dVjFYZ0rT/9U8ol2TdzVVejKn28OPly5bz?=
 =?us-ascii?Q?KCLot+h3USwtJRSjthLfBy1YhXrT/eg/xFaKAlKgBdxGdU3MK4Oho6Rt1QPi?=
 =?us-ascii?Q?aO81wP1N7pGpSPQBfZXmGUSpO47ByRndKzDt1JvQC7jwE+otgl7J8yem0lpx?=
 =?us-ascii?Q?h3/65geoaaItmg9eoWlP5GJ03Hw2DkdEazeSLD9LBLc5rDYfmw4UOPkp5brr?=
 =?us-ascii?Q?NnG6LRXHtZtV+y6CHWjUtellk7xYoFFiGhQcbI+0eV18utNvM5fkEIDVngsz?=
 =?us-ascii?Q?hEmK7DfWgWe1+DojY3w8cC+x4JOe7ijyY3if07P3AWwEnTlDhoUXJRhWf8i8?=
 =?us-ascii?Q?hVGGkDwjmzTPZpEJeiVcl60NA4e8qrydCXAkmCPsWJaVSil0/gHCeJShzvE5?=
 =?us-ascii?Q?S863XDMzBli5hd2cXuUhZR8Uskr2TxxTFzWwyvYyApLhYKlOSE+stNo62COC?=
 =?us-ascii?Q?GipHW/bSn5pAbXnEdW0gRGd3geu1xIFtzDnRKr2eNpuAItAabsaTqCUeWxwq?=
 =?us-ascii?Q?KgFdoIaTOxo8VSyLOPVc2MM1lmeY7HMgppdj52dozRiacYSCjr27xdygMtLD?=
 =?us-ascii?Q?ZCoBhYfrsV9QJL8SH/t1LrjuqU/BO8QdbU+E4zvbBC+tKQwqLXg5m5fQwFzK?=
 =?us-ascii?Q?BMhj3dFrqeXJY2eNUzG1evWoTv/eCgcZ4G3xGUBZ6+67V7r46PoM/93Fh7Ql?=
 =?us-ascii?Q?yBaTFjO00HsnYc79dQ5tCPzcJJRUolWfw4INSr11cmVe9J1Lxicw6XQmPMcP?=
 =?us-ascii?Q?XnCWKSlEjgzM+pr1o85/jBA3ZO3F7SBgRCH06SzEifC6RyOg5YkxxfnjDkJU?=
 =?us-ascii?Q?R7aNnJobIJDBJQiZskIOAQ7HKI9S4tu240fhoVZ6d8RDEmPaVA2nu/mshJtz?=
 =?us-ascii?Q?d9FanAKTf6CcmHwMZ2BO5Pucpqe9KPcZ3G0g/M9VvqkzRGs3gngqqIq+PKTy?=
 =?us-ascii?Q?cxHx1OWk4Rm/vtyrE/E68kXTU5fj/QQoT8Xm5YsXN2sJkAqxyBmQ+BRDT0nQ?=
 =?us-ascii?Q?TzFJPRUqH4+zS8rRjNye4NAPJAL9dqqKFMEqA22azx9fueq5jYi0RBmtrOdg?=
 =?us-ascii?Q?j/1HD22xuA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721845a6-4a9d-48f0-c772-08da233a2f02
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 01:56:43.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJfY5N8AZXihtLjWFKYSgdu2k+kxvO/WalD5NdUkmQZGhaUtbSOD+uvOJoYRKtux2Jc1B2ZAluuOZlSvBoTDgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

V3.X Synopsys EDAC DDR doesn't have the QOS Interrupt register, need
to change to use the ECC Clear Register to disable the interrupts.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Shubhrajyoti Datta <Shubhrajyoti.datta@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in V2:
1. Add the Reviewed-by and Acked-by tag.
---
 drivers/edac/synopsys_edac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 40b1abeca856..88a481043d4c 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -865,8 +865,11 @@ static void enable_intr(struct synps_edac_priv *priv)
 static void disable_intr(struct synps_edac_priv *priv)
 {
 	/* Disable UE/CE Interrupts */
-	writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
-			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
+	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
+		writel(0x0, priv->baseaddr + ECC_CLR_OFST);
+	else
+		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
+		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 }
 
 static int setup_irq(struct mem_ctl_info *mci,
-- 
2.17.1

