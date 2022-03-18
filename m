Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529FB4DD8D9
	for <lists+linux-edac@lfdr.de>; Fri, 18 Mar 2022 12:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiCRLVm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Mar 2022 07:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiCRLVl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 18 Mar 2022 07:21:41 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0BD1F518A;
        Fri, 18 Mar 2022 04:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvvaWFth86ra4ziMjczzUzZOEBG+pGnZAHqrL3JIiOj3K1meucr9hc/oymwhJSvjMEG1eMyAp95HODLZeXJIiB09PYHt4LWZPClitDcbPZQc+Sm3IXH91UUGBqxPAb+VDrXvabhiqJfafO7oe3/lLT75lCxyr1Z7gRTUiP+PUhxJjAxKkxiEN18weOGwU6siWUKIWnQ0JyYo/nOhDtmFmdvorr9r93iUpFcP1knY/vcsNe5FthMmfzWTplPZyH3WR5bcmOOZMI0Hue/ApmW7W2koNwl1GHf2wCOVHp24SgVglubYCL3zE63psrGI3DDKad81+wPDZi3yq2FewCmOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKjoFKGx2M6FU4PRdgOwVCiZQLgMB2E+LoRP5l+zZuk=;
 b=QRzZbfDoYgW9DIfzqAF17o3BfYS0qrOcRDfkhT4ZDAIAHNmAsnQPilrBUkfxkrbzdR1I6aaZqyFiqnVl7f+n3ktIWtMChvGxxqFKbW3zvlR5NLMRr08FNpQe0nOZ+jlvFk1JseeSECKf4jBtUbuUmI1xJl+2xQ3WgNitqaSVikM+iGqUNzLFVHrtM3yDb/9KMF49OpoN++4fzbQFL9aXQDGpEb4UDAH1oCj+cseMGk+BpoOAli1hOSXIvHVsch5qnwV+3/p1GtOoD1o0ELgLIh6Ohh2W8n+aqj2ag+vgX0m/IJe7ey3TwOgshbJ44m19fPEQPjj/ZL39S4HC1UDcPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKjoFKGx2M6FU4PRdgOwVCiZQLgMB2E+LoRP5l+zZuk=;
 b=b6XCZYdCwWy+BRId7/51+YyEy9uey4GvXFg51ZHLJXXt6krdqdPBFl4FHTQz9/kxt/pT/5y7Zs0GDK0sUwAnJmiZvtPqGJthYL1MWrQ1mPOzURR12JzUZY5Vanvu7CIcXQFIn13kcRt90EPeuDhitBe7xXHmMMtzaT1YF/jw8rM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM0PR04MB7108.eurprd04.prod.outlook.com (2603:10a6:208:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 11:20:20 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 11:20:19 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, michal.simek@xilinx.com,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH 1/2] EDAC: synopsys: Add disable_intr support for V3.X Synopsys EDAC DDR
Date:   Fri, 18 Mar 2022 19:17:41 +0800
Message-Id: <20220318111742.15730-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220318111742.15730-1-sherry.sun@nxp.com>
References: <20220318111742.15730-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0088.apcprd06.prod.outlook.com
 (2603:1096:3:14::14) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6f639c8-e63d-4eec-e94e-08da08d148f3
X-MS-TrafficTypeDiagnostic: AM0PR04MB7108:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB71083A58D8D0A9CA0C912B9492139@AM0PR04MB7108.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qk1uH7b9m9rACMamdRQmtjzZNNq61rg4TGXBuj28X2wIfQRZXJ2Qh6MJLg7IPn6y/eVsjvLYF59X7BOKL/6XGBqeOTdYNcPmqEEt8YqwCTiZeeGSkebl9HIZQs9pOjsIM/8fh8xKTvHGOPiubK6QH6PgzhJnb6GeuWynkpLWlK2b48PeZb5BeGZ64Un4pZImd22Pf329XKnNAkd8+5PR2un2N1G30QH3rx79bAxKsFEfdx3Adq9LCfdoncfCEEiXYtUWw5Evkc9Z4P9VEf/SA0jW6yyd/Bth23E9bGXFprtq0H5mye3O9ITBxObTfcQpho6SJWz0oRKMwlDcnG5Nh6SPANjYB7mWI+0JFTjzJ2n/aYxpvp2YB8vNyx9z9RVeG3C2GXRk8TTLU51N6zXfFSmN/EDCw3Q6jyKI2GRx/fpr3jfmqm/Sl6wF3/DGm4Bw3u2uRRf9smG0S7+9hMKthnx4BTOzL+UQUyiJ1WdxjcjGeWPSMLmYoCYY6KYMZeEQLfNzdiP6/uSEhlkg41f7V59xdxPDO79JzgoK45fk/Y5/4Imuh32ckYFG+O1sg1RtqbutrIn+TOrAJeXLa6zHqkRayXfP8qbmqhK6XC+P5fGpe2K3EQ21N3XtLrrC2QhaGXGYDvJJ/JYSK42UkrJ8CX7b83KD7aIMsfW+boW2oXXkVz5VYfe0VY7DCgaJBJKgbJo1AtjafCuhIZRgrrbliQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(4326008)(8676002)(66476007)(66556008)(66946007)(4744005)(6666004)(6512007)(44832011)(316002)(2906002)(83380400001)(36756003)(2616005)(26005)(186003)(1076003)(38100700002)(38350700002)(86362001)(508600001)(5660300002)(52116002)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e39DSRySM5lwSskYRhRiKHq7uZsnmAn3pd3kPnBuBT0yx6wMLFZUC5EwVQYn?=
 =?us-ascii?Q?mxsy5p55VGYX9VMCpBmXhzEbLBMvKJXnyQdfd9o1E1yluEcOUMSZ+eE3cQUU?=
 =?us-ascii?Q?nOwY+d+sYRUGrdbDNZoJ+bBIc0lhivnT1DKDHJ5Eq4aB2j3AkLEN1U4GywUO?=
 =?us-ascii?Q?cjppEnuTsKWKNFwc68Ho8OaffTfju93xV+RtJdQIWgh3QpyNP+PSggIjumD9?=
 =?us-ascii?Q?S0S90mklzUc2NHQeit2SA6vfYXq64gIiO6xKKaoOnyrE8Z1knQHOJ/VApvJr?=
 =?us-ascii?Q?CVKkBl9tS50X0pYLI9RvoXlcjAki+FOuEXA34YbOkxEy35JMt7Q39cAZ2vD+?=
 =?us-ascii?Q?2uu/GlT6rLItK0BEW0hOTmGWTXBB/WgZEtTttUmMHPSU9c/UdvnPCVvtkwFT?=
 =?us-ascii?Q?HFSqnUGdOEFOkmmNS675Xmn9lD4j2jHgw5ikOA6xvhtMCKN3tItmRAiHMQlS?=
 =?us-ascii?Q?fci1ThO08lUj9g4Uw70j4lzTRWYXbbQIkxl57MQIL8QANTwV4pONWaojRSVg?=
 =?us-ascii?Q?4FrADLe9f+p5+beNOl4CSJztNI988GTCeoqqNhB6RM7v40NG7zqe2xXmU34O?=
 =?us-ascii?Q?c8lGswmzNEoUtnZg1XQq4HEJwGPGvsihvmOaYkxeghV7c3mEZKYswEg57Jiy?=
 =?us-ascii?Q?Jy+4leTTzAie3Mze3BLjIKWwbIIAd5Ais5xZgpph8fRuOr5XoGMyvm9B5Rg9?=
 =?us-ascii?Q?hjjqw9wXRtAdJUkKXmul3uIF+aSOziIbS89GUrQSBes/HbB7fhMaxj9NDkT2?=
 =?us-ascii?Q?J32QoeBUBrzAjU3JdrjRwTDwZMmevb7o+Wmm2oe9KWh+NTFCIE+Ml+2M3RI5?=
 =?us-ascii?Q?UYvsp98RvPSybql6I0KmRVPJt0BZzSgMgMHSDSGxNIjKwg7uX00yAY0Yp/Ia?=
 =?us-ascii?Q?NiAIWGsuMKcICzW9kL0FeRwKBSA8UKa4sEfwLYu0PbrQGvExxS8EJATmH/iL?=
 =?us-ascii?Q?FoOio5M06K9lQLeRa+1aJmVdbnXojeM/jWIylcccvDXE/OPIIgWm6eJ6GwUa?=
 =?us-ascii?Q?16XXa80Qhpa5mGMb+rKPrq2PkAQcxWlonIEG8UavcpMUOOYRGO1QuPjR+9C8?=
 =?us-ascii?Q?zR5QI4/Pl6bOQaK4CRfjefOi8aAZVKvv4H5Y2xlK3MAfM/yrLEfg68itdL79?=
 =?us-ascii?Q?3uiOzCwRnKCT4XDyQqsRQzIu9CxRPZdmigQABpTgH7XCgDIkJOQuK/wUvWJI?=
 =?us-ascii?Q?FG5WPQLVQiaAWHRzmOyQW7r2w59DoPqwPaD+h4Kum+Bd57Xg4fHnEX4utwQA?=
 =?us-ascii?Q?l7vAjjGTvDkhb99EZcNWG1miKduc0oXzlBZtmlnuxQd2ZlTh6QFJypKXtojK?=
 =?us-ascii?Q?rAwQTkG52CHL2Psk5+V9PpquLS+9onW59B4/uIzf5j1Yd3IMdw+JjvMtdRJm?=
 =?us-ascii?Q?txO/nDV+1HfuL6cq1fh02sjOz3cfXo2yUMRZba8i9z9Vyc+envrZSRS3fXbJ?=
 =?us-ascii?Q?Ff2AjCX+6fV5xbT70MyQm8oyuDpJgBon?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f639c8-e63d-4eec-e94e-08da08d148f3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 11:20:19.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ousg/PiD6WsmVyf6Lnj/cS4fy5/ltYGDyTtE+pGJ1ubHP8Gcy80Ao7/UIC6PBFRLA1RtPoQY1MnOEESjreL3lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

V3.X Synopsys EDAC DDR doesn't have the QOS Interrupt register, need
to change to use the ECC Clear Register to disable the interrupts.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/edac/synopsys_edac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index f05ff02c0656..1b630f0be119 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -859,8 +859,11 @@ static void enable_intr(struct synps_edac_priv *priv)
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

