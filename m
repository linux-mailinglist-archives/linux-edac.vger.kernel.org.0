Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D09650CE3F
	for <lists+linux-edac@lfdr.de>; Sun, 24 Apr 2022 03:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiDXBhu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 23 Apr 2022 21:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbiDXBht (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 23 Apr 2022 21:37:49 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E941C78E9;
        Sat, 23 Apr 2022 18:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwfGDj6GNjU9zqATBF/d/vVrUFIIXlB0nfOEgtX2sKSKvLDXZ0j2vkF+iDCZBIwwnFwLg2k+hZ1s50lX+7epalCMpiY+4ZwF2q+5mrsKM+hikdjtbngjAgU/lE+5cVXqlnJyUY8bEEmgmZyjrPyw/iY8O2+Vid1wQf5pigqjm7/1Z0Y8YydSKTzlWr6wKDo+0egn/WipGK+JEdYGbX5ti1iy40q8faJhnIIproBMkna6uNv7zupX+pZ8hNQH6Nz+VMDAtHqavnLSl4/+9GkNgh1s3QprieBkPaeO+ch7HGWLUjAdiEj05fh7zRbFLQ+Soj2Ictn3lWARAK2fBWTiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBHGuiW5vKz2K5ENMsre4dcfvp6lcl/u03OSfuPSQtg=;
 b=lKmNUlLRYoYDWzKuOJ8vvlMQNFNnBsNJHk9ert3aS8vWZPU6JWjrYHIkQE74RpP5QNllMRA6+u/BfGNX2tc2gFDpUx/Cytk1G8BGJWthpa2LsBJOUeXFRNqlfqI2PpTBA7KTJrcWoAOeNgysshGlhbD5DVILXWxg9n+PPf+Kw9zdqfRhulqVP+oNKxDDI512LxUpeSK2JE5hHd6VGO4SFWTrzMaVHnoGkpWIJEB3+DfbsILo6NRovPjqayUBT/dST0H6eJvFBjd4QUF0vQlvXrNP2NfkjRyuR4HA7EDa5L0SLAeo0no75yzRxLNTc2iZv4RuKE/cBH2HTycYNIhdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBHGuiW5vKz2K5ENMsre4dcfvp6lcl/u03OSfuPSQtg=;
 b=VgzDz8kR9aqr+rUNXn+2xO8/ZBDHquO/wYlI2jTuasi7StEzPhBU6sV9aTFQPUtRyA35M8YYiA6kjcbbp53rQwT144l+2wWYAVJn+lPbsMyvbzK1RBDi+3TV/kCorht6eTPE2bqx0g4ASC8DV0urCLCGzUUgsroQjX12Ks7HJfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM9PR04MB8179.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Sun, 24 Apr
 2022 01:34:47 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6%5]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 01:34:47 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     michal.simek@xilinx.com, bp@alien8.de,
        Shubhrajyoti.datta@xilinx.com, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH V3 2/2] EDAC/synopsys: Re-enable the interrupts in intr_handler for v3.x Synopsys EDAC DDR
Date:   Sun, 24 Apr 2022 09:33:45 +0800
Message-Id: <20220424013345.7359-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220424013345.7359-1-sherry.sun@nxp.com>
References: <20220424013345.7359-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0121.apcprd03.prod.outlook.com
 (2603:1096:4:91::25) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95dac565-f69e-49fc-9ffc-08da25929dec
X-MS-TrafficTypeDiagnostic: AM9PR04MB8179:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB81790879D11EC20C0B1C7DD492F99@AM9PR04MB8179.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZ9IslbNCtHp9pqdJEsoY4BLK4X78jHxk/pqg2Yx0nUZf2K3FY8Jn6Dtr/v3X9En5s/kQY1UGr1lkNKCqikGwqXxl8OElMfLHmiIrs45pH87rinKd/uve1EcruO+yjoo6mA8DOYF00JiMFmwq7cNm4O6upJGiqgJaTzYtaSsjw2pVpls+lv5tYQf+cxsiBuYfeUlWDAzshxuFcXIS/tkdXBwfj2XyOhdMG0Hp+teSn8LyxiEM20WFk3kgr+0pKu2EceFIdSTWG9sRCcyFaFh/aJvv6XKXT2M0n7z9CauUlhp2POFE3iS3lkc/b2mx2vTwElx694KMP4qyTrJ+Cxtjd2yu1j2oZCKrGPrX5XdE9DunBBVz7aumY3Xc8ZWfYnOcqpJWjoBFy2qSIf0GHMEyuPH4eOxX2jZBTnMo0ktSImBTvKXTL6dSeEEOFAO+ZMdGyzzit941+49NHEjxboUa2ZkEloeHXInmTzmYyDCSY/M4u4izhexXyOIjSLUul1FKOyc8g2q6lIGAH468x6JYOw4haATK5hTdUFYTEY1gwre7RpicNE5kKCVcit87xNQYpebDzcTatRgE5WmqM015gwl4Bc1Y2wgVvVGIFLLpSL0ksgafZtoW7A6B5/Oi1ZF16BH6Jzn5kwJdu98Z0KJ+ph7DA46ViixkHbSNxNoD0YYO1f71vVhaqWIFc2xirfBAt6bKxD6YCh+rQLyOVuWAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(5660300002)(8936002)(7416002)(6486002)(508600001)(66556008)(316002)(8676002)(4326008)(66476007)(66946007)(26005)(186003)(83380400001)(2906002)(1076003)(2616005)(52116002)(44832011)(6506007)(86362001)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qi3bYsAaaQP+Yk8Dz+pSalSqnd/ej4aySd4c0ptN38IOMezrEx70Li4GN5mM?=
 =?us-ascii?Q?n+dIqKbEsMo3yneFZofQeW0vMLUxYszCsuR1dkVk2VuNuY5gT9Zbs8pMsl2y?=
 =?us-ascii?Q?hsSmQWy6nMi5AeQK9dM/WLAXfogr+d6+4s9wJN2es4o00IQSRSU5sg67wydU?=
 =?us-ascii?Q?fGX62c7SNT1X0J09bWv+QRIfnMh9KsmWm3LMkvMJSNujFOL1Z8UbiF8CyoL5?=
 =?us-ascii?Q?jPJ/KgrQJWKcdf4bE9M0Ac0t3PXg1BK02I0bRJVyFoZZx4ZKiLc7+O/Vj0b9?=
 =?us-ascii?Q?8mfcxNau7y/HLbRbtscWSuSSoQuw8ZGVrPzuJ0WlI0M8OaKDAuJMs/mhu9j+?=
 =?us-ascii?Q?Ko/dz6BfcwJCBeFfOix4wBbPv1RQ7g8s0nS576R8HT/GMMIx8Tzy3FZVR70W?=
 =?us-ascii?Q?oauQNVAHrnZVPjdCyMDBjf/FNzYW42pD2xBSMxNFzRtsF3tMMA8bWXX3pT8g?=
 =?us-ascii?Q?TNWKQ9JtLxl8Yw7CngGNR1QPiRzhbwqQxSlXxR3L3kPd52BqIzoZR62yEW75?=
 =?us-ascii?Q?qXja9lAjrV5lbciogQavemR49f+BCGtqr6IWn/PCNrxrp6vGe7sD7cnvxrU9?=
 =?us-ascii?Q?g+m91yZSRMIKPpYHxEbEndUlp8H2/S83p54ChNGEX3gCqspSvWanWPi5D/+w?=
 =?us-ascii?Q?KB79AB8Zr7YNiP0Iq5Tin4RNIqiL/Yp67B8aTkGSrlW4c4waXxJqbgVsEiRV?=
 =?us-ascii?Q?FazzNRdaZvJsJDOwgc2qEyq2acmz/TnrSzZj3TcZ8vsaZmArU+Gsf0AxYhLb?=
 =?us-ascii?Q?9FAx9YtQp4aFs9NNT8kLmuw7F4L1osYnETgmdJR9m82tIQZnuw0mtXG6fdJJ?=
 =?us-ascii?Q?EJ4ypWUqF8teDPYJ4tM1MApaJWSRAyK2+H8Q4ZazqAZLgfhEqxET3SyC6oop?=
 =?us-ascii?Q?eLld0dmT2Eg+SkG0S1+78+MXDn35kdYRm/iVMj5aWczXLcfYJIq9ZRsl+Jmr?=
 =?us-ascii?Q?SwdijL0236WaG0LbGIKxcjdlQ9hrocGR5LPGvZ6X3X8wOwpKWbDTr3KgCsIZ?=
 =?us-ascii?Q?pYNes9vaxA0LnLCgezYvR05agGu4D3wLgdQZIYjMAKeQdBZkThylha2dVLQt?=
 =?us-ascii?Q?+wTqG0821i4NrKTC4E+oNzRFPyEx1r4bcl94T1uctx6dRSKwCJMf23FBML9u?=
 =?us-ascii?Q?Uy0LaEOPy1fH19VjgbvJD5bQviCBDJLAzo+T7tVbbI+9W1VRsLPGOG5b2yA6?=
 =?us-ascii?Q?TzVt+Bi68pytjVuu3suv9l+lpWx6lE9phHwDdvCEYgfHVu4qVVDrE3o10NPY?=
 =?us-ascii?Q?TPLkbpf1PBVCTzgNosvKcuJRsvxhgq8G+qYPxVvcQ0pvDdjlbFeYvqfiv/9b?=
 =?us-ascii?Q?KxzXmb8OincwvFGImZ8YObNGFguLwKmjgh0qdrjUcul0EcMHvRfAxoN+NiJr?=
 =?us-ascii?Q?7g0VLMRM5yKFVeyqlQ/KMlnFnvXf39cnDXgwIFtYDW5z2Zm2/mTx/2DXT1S8?=
 =?us-ascii?Q?+0JV+UUQgGQKbNJngwQD6kJJQFgZCa3b6XvSsEM2J0RiZS0vENcZTBksbOsH?=
 =?us-ascii?Q?JPfon5DIGvVjM4rKB/OpGAXgZPU4GRNqIn6AZTsjINopREpQhggAnZftdiOP?=
 =?us-ascii?Q?BjV2oEsgFR16puNEUVPicnWkl9SECVn+mZfQcE/YmXwyfhmdprSlwDyddpAs?=
 =?us-ascii?Q?WUrQk0u+zEiDKMPQFRm4YuzTRuRq3uJ9XkdVRQEREZu750Nlsa3Ff0jxOINv?=
 =?us-ascii?Q?ifyi5vpKEUa5pxufKY47N0qFXlHas9EQ5EQBbtz3R567BTAcORyKjlw5WR44?=
 =?us-ascii?Q?78fMQIXqAw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dac565-f69e-49fc-9ffc-08da25929dec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2022 01:34:47.3360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wetpHt+Z+npMFZRxE6s5bgoJyT56UeJH/yq8iORP2TUlBmJGyJpHCl0xla9eIg4oP9Wvk2wIXx5IHurThScEnA==
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

zynqmp_get_error_info() writes 0 to the ECC_CLR_OFST register after an
interrupt for a {un-,}correctable error is raised, which disables the
error interrupts, then the interrupt handler will be called only once.
Therefore, re-enable the error interrupt line at the end of intr_handler
for v3.x Synopsys EDAC DDR.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Shubhrajyoti Datta <Shubhrajyoti.datta@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in V3:
1. Improve the patch title and commit message as Borislav suggested.
2. Simply move {enable,disable}_intr() upwards instead of the enable_intr()
forward declaration.
---
 drivers/edac/synopsys_edac.c | 47 +++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 88a481043d4c..a14baeca6400 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -527,6 +527,28 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 	memset(p, 0, sizeof(*p));
 }
 
+static void enable_intr(struct synps_edac_priv *priv)
+{
+	/* Enable UE/CE Interrupts */
+	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
+		writel(DDR_UE_MASK | DDR_CE_MASK,
+		       priv->baseaddr + ECC_CLR_OFST);
+	else
+		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
+		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+
+}
+
+static void disable_intr(struct synps_edac_priv *priv)
+{
+	/* Disable UE/CE Interrupts */
+	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
+		writel(0x0, priv->baseaddr + ECC_CLR_OFST);
+	else
+		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
+		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
+}
+
 /**
  * intr_handler - Interrupt Handler for ECC interrupts.
  * @irq:        IRQ number.
@@ -568,6 +590,9 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	/* v3.0 of the controller does not have this register */
 	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	else
+		enable_intr(priv);
+
 	return IRQ_HANDLED;
 }
 
@@ -850,28 +875,6 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	init_csrows(mci);
 }
 
-static void enable_intr(struct synps_edac_priv *priv)
-{
-	/* Enable UE/CE Interrupts */
-	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
-		writel(DDR_UE_MASK | DDR_CE_MASK,
-		       priv->baseaddr + ECC_CLR_OFST);
-	else
-		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
-		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
-
-}
-
-static void disable_intr(struct synps_edac_priv *priv)
-{
-	/* Disable UE/CE Interrupts */
-	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
-		writel(0x0, priv->baseaddr + ECC_CLR_OFST);
-	else
-		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
-		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
-}
-
 static int setup_irq(struct mem_ctl_info *mci,
 		     struct platform_device *pdev)
 {
-- 
2.17.1

