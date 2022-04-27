Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B26E510E7E
	for <lists+linux-edac@lfdr.de>; Wed, 27 Apr 2022 04:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356970AbiD0B4H (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Apr 2022 21:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356867AbiD0B4G (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 26 Apr 2022 21:56:06 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62411659C;
        Tue, 26 Apr 2022 18:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/Ma2+pi4ULVCDe02jhqjlEJjXlaENU2VWnNwcE0BBFzupuNebjrfOinf5UXy4RPDpozPeHFftc5nL5xOX9Ki5of84fufj+BmXO/Lf9xlGiXWhwtet2J2Z0eMSP6O+W87UGLq2q9lK5kHf7qXX/IKEh5jdKXiqXlupYPR5ct55sIEWqEv3bRxezLjFFmZ8HpsTWeYbEJ0/er26rMyWmLZIAL7PK4i14PUTCy/KxBktkGvNQA1C7JBTy+CTnKlpPXViUXBtk/qARwcvfqQoC10J+gq2g7USbsitWixhhXVs23oiRbmz0JY7Rzz1r7mHRs5N0c6P9ezZIFN/kDMq/RDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+wKst/1sn+qTXKBupU2W4Bm9FBCzK0jzmuH19KoNW4=;
 b=hfO9K53RBuDz4qQKBAslt0nCMowsDCUcbE8xwWpgLlv7NGy1x4BD4qIfjaELlNE4GqkEe8wKKEQy+M6O5+VYB68isjRCeMvDmQuK5GxwPKrnvjgGs531olSP+57BeU/os/Jhp9ZDfdJNa1DnCaB+mOAhN96ZbiHB+LC3LrBp6sIt4pOIFWa00D6ixVmsGYdgkQGHmp/Ovr7fHuBJesnej3D+LhQSvNf5Il06Uvl4bl5l9b5nSwt71UqOOPZzd8Uf3SJIRdK2ym17JFzNtL9tr0Z3MVE63tvaTw0ZwAhk60cTiCFXKy4GDG+WjqRTpurn3mtOjhDUjZW4kYCRHgEFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+wKst/1sn+qTXKBupU2W4Bm9FBCzK0jzmuH19KoNW4=;
 b=TDk9A1KBcekHikJpEUu1dWGdnBooyxStZSwcoxYxIEu334PXEwNqwjR9EKhE64pOA5lcq/2uxH9aKQUaEZX8n/Z5NPEPntz3iahuryUb02PsSYeNOhr41yBXHHlUZ7x7N0koZFtpZzyVEoC4+IxPlxsneJGzMaaIN/q7MKB62qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR0401MB2589.eurprd04.prod.outlook.com (2603:10a6:800:4f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 01:52:54 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:52:54 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, michal.simek@xilinx.com,
        Shubhrajyoti.datta@xilinx.com, dinguyen@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V4 2/2] EDAC/synopsys: Re-enable the interrupts in intr_handler for v3.x Synopsys EDAC DDR
Date:   Wed, 27 Apr 2022 09:51:37 +0800
Message-Id: <20220427015137.8406-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427015137.8406-1-sherry.sun@nxp.com>
References: <20220427015137.8406-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8a88c95-a1fa-49dc-6768-08da27f0a508
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2589:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB25896A2A806D17DF68474BD992FA9@VI1PR0401MB2589.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NW9TmrynY4i4KF69PbcY1/jTcNlCqGiWBL5mIsXrEtLGzOC5TMOdUMZBhlOBFqbpZImoYHNvNia0ny6TuT8Baphg5hF1EeZnH1KiDvN5skaoUFcg6t1LBL/5filRIV4TTN9MFr0Bic/QVR/K19FJqRYZxdKNdhWTQ347qJS76hEdC17v02kse/ffLp3zugZmYals1VXStNQNcjHW6f1CLWjfMlGXZz7wp+t7T9MwE/IH+Un+w/QjQZLdtz4e+msWYlmv00i4hMEUqLS8KS2ObiYO3mThZhB040KTukSUnB8l1oRLvYrKv/lQycrraiVYTWL0dnCMViipbjuZDnj9XCXSPA+/AjYQmzXC1m4s6I1l2bs3fGQF39A1qmNlB8FntlVjaUMMcAMaLpoLDHEqDSf41Qst9gq4XL3q0CZW8XbxImyve7yPgaXbVgs9TcO4JsRKFcBHtryJwbVj8PGIoBPpHAu5/INdryF50DTT60teahEUQH19lAi1JQ/aGWa5HE1iAyRFF0GDumUPJQVF54xR52LRW4IrUpf+Aj7KTs71VrvWNSSzZOKEHKhHlFqwYkpbb2cqVp8dDD4YsFE+c43CuRIdedR319yJRjjPsSjo6mum6TMcP68gz6taS6GTM0j3tckGCTDyMiyFSoUxuEiTLyRwTENU33Sat7eg3NRsvm+ekJQ8tWPcIx7TV/FIdDew4bGbsm010WGpMHhoXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(2906002)(6486002)(508600001)(38100700002)(66556008)(66946007)(8676002)(4326008)(66476007)(86362001)(8936002)(44832011)(316002)(5660300002)(26005)(6512007)(83380400001)(2616005)(36756003)(186003)(6506007)(1076003)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k+P/HeEDXrxFJTY7ZYH+P4MAJX5uz3Xn34qmxO8Jux5Tbj7K8GpZSqS5EQBR?=
 =?us-ascii?Q?Po5but7hTMGLOZyJAXSY1X8r7LJE0AXnteNYOLk2jkf0nJmpGN9hEfYH3Gy0?=
 =?us-ascii?Q?APSb2ja2r7jf3qWBxXsg7GROr5ITxJ1EQoeEvOAt7V5DQpVIrc0y/GyN48uY?=
 =?us-ascii?Q?6HAOO+XjlFjlBUJiCa42bNfAweA7Q+VxMiLdKmul/OMniKtH70G4bi8c7i0X?=
 =?us-ascii?Q?VBtEWc1XfRLpDtiVxwMfzQypJhy8TNcF3DhVUZdTbAdgPB29LJ1Co8rRzB0w?=
 =?us-ascii?Q?rVFvk2KoSeQJxx+fvN7/wTBT5QfxbaQHM4uRkdzikv6+RJ2+/4255ngXXyN5?=
 =?us-ascii?Q?mbT5QITW30C8IZfba2ZfuLCJstfr6Eg66m5rcXEgstf9+yiBGmLTU0RJkAbT?=
 =?us-ascii?Q?AMWSP6gLaAFzs2MQVwgcc1/O1PU00RCMtXJVuHxpMGud7sIvBRNbjoX1OwcZ?=
 =?us-ascii?Q?39pvKlt+phYsFqrZrNaxYajLBg8i5gO3pB9ovh1dtw7cMiZhpEwaEknGflIT?=
 =?us-ascii?Q?MmgK6Y3aoZb9pKH4Eb2ueoOXNlqeDSTVloOwhJpG6szXwRalslOqJSJJsrUe?=
 =?us-ascii?Q?Cbe4Q2Sqr5eccLSgvMYwLu5e3dD5DgNqtBmRgA6MbY6Yz9LbjELgoD0TPAnf?=
 =?us-ascii?Q?WHgVlVBIQ+rU6VsOKRToDHeX+wQmVeDgvluFpcMX03oYPL6xVRJ2WivMvZWY?=
 =?us-ascii?Q?qT20UA9MHWxcxHxEZI4jH9vWRcxVbS4VzbFh0t2D1FaKCb1i9qTEv1AXZHur?=
 =?us-ascii?Q?dtVInmuNOrKNC8VOakxGY1XDZYlpLHJuQ36yFUaKTrKKzRjDeohSG6igYelW?=
 =?us-ascii?Q?zYtfPKcFsTAfqatK3lYizPFKML2JkTLmXVrtlWNWw3THRtNycRzJMooi2aLT?=
 =?us-ascii?Q?7YbvRnVE3vK7OkthUC59RvWbV9YW2fjj/TUacJcPMqL5Ba2wkg5wCftRBiEW?=
 =?us-ascii?Q?45ZmwjWdUGuOAxR72fa0nXHC9CFWanFmmZ2hOcen6FLoGWNwDdBycF/k0OAY?=
 =?us-ascii?Q?J26uyUDNORG+4T+abZ2Kp0szlPXlatWpfq9wTl4bxa9egJXLrAf4R4AjcKkX?=
 =?us-ascii?Q?dn6f42AZx5G4abw/bg3R+LCCvEFsF81bOiFZnLf9+Q6Vh5fD4A2VE9boHjft?=
 =?us-ascii?Q?co8FntYqsNVFXS4UM3zpUUn6jcfBLRSLbUwqYSUIh79fkPOraNGpv/0ww+zx?=
 =?us-ascii?Q?m0kQ12O1MLIivyt4Z6B6ybvtUxUdDnE4Z0Ez31EQS7Y0Bq2lomWqHXfolP3U?=
 =?us-ascii?Q?Igy+bDix30+rr/orr5EqG/4qWq21P/t0wH7sPgdZH7n5yO3PHf+HADYOv+6D?=
 =?us-ascii?Q?LIbtQp/snm0Ovbbz0L/TIYHzVr46MHYa4ZaMwpCHEet61nCDKhzRMO/OhEoA?=
 =?us-ascii?Q?dxVUtSgzxSOJc/zd3SE543AjZo7Qq6jCcs/El2rjQCNn2cnbgRHBNwSmGDWF?=
 =?us-ascii?Q?ILIh7W4/94WSU+C3bPxJbcsRhawgR5ygbn8knoJIG4exM7kcInD3zUw+hmzP?=
 =?us-ascii?Q?uRZhXyjQaCMf9DYprW98nXQG6c80VN8ToMBGX/K+nRWgDqP0WhoVeBnNpNXs?=
 =?us-ascii?Q?afBzbPS29tc+NwxomgYJyNblsWbCyrNOEGHl0o2mFR5oTUux29J7nmqUvV7k?=
 =?us-ascii?Q?m9hsKIb43LCwNFKxNc5fEb5+CHLgdfsaZwXGfjhqjJ5aZWV+tN/qnDKlOmN9?=
 =?us-ascii?Q?RIlZQ1ScC4p0NFnK2zcTZCeQ4Ie7AoGOd2aFFKOB/Z9iafXJrjtofsifL5Zk?=
 =?us-ascii?Q?o+cGeySGcQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a88c95-a1fa-49dc-6768-08da27f0a508
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 01:52:54.2178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkPj+7a9DDi4Fjz0akH/bH8g5A1XbUSJoFeaLvROZAyY7gzATnIjMX4V0Ir8joxJSvU3I4GFfsb/hasN0whVLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2589
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

Fixes: f7824ded4149 ("EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Shubhrajyoti Datta <Shubhrajyoti.datta@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in V4:
1. Add Fixes tag.
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

