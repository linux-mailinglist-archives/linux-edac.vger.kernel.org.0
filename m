Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C400350CE3B
	for <lists+linux-edac@lfdr.de>; Sun, 24 Apr 2022 03:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiDXBho (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 23 Apr 2022 21:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbiDXBhn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 23 Apr 2022 21:37:43 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BE31C78E5;
        Sat, 23 Apr 2022 18:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrKUu9/ag+yVPPB6YE2d3eFYO65lknvh7woE7+dmPSN6ECyCYVa5fp4mdEZADqo6yOeByaEcVDHTS8b9+0ZpxrmxIuOAe/LxrN6HP9H36x54myyfnpkzg/rsKV67FTWBcKerb24fNl7Xi45pKve/OkN1qeQ2udPC9w40IRYkwKmYakolN/JzOTHJTITI0YcG9WCGJ0MEnAXNu+fmeqeCl5qZRxzcMdjzGLRK/xS0+9VzPeAsdYBIXvfZtoW968XsAI8pf7u/wDScZg6OqBoyb+xo6ouhE0C6RUJWCaAic/GirQtFkFrRLODbZIDTNPgPzEEg68EVt9njZ/5odNOUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy8B46l+aytgc9jY+0qtSLnbsu4WgPkiFuc6kdAEj1Q=;
 b=HM+EzVnNY1EPUr3j6FGXtwSMyvnpGUpFWhpO9XhIeYUjqE2s/x8vmN1vjYfOltUaNxnld8GOoNWz+eDLj3KsdgzZLlm8d3byx6+BNnYdOYUPFoFKBuO94uzCx5fh3Sc+SSvY6nBXnKGA4eX4kH/bnvusiJDyiGMm+hBG+yh17GrTtBs+IhVl9RmTKlpv/tpGKezYc+xw0HYgUU2nrD5hBOGrnmq/eMW/DZLEbOoiySDr7ywcQ37zgajD8M1PpOX4v8vu7uOyzmyWha9kLgNwzv0zM10QOVn1tj5sWHYSI38e28O30k3VHTSOWrmg0GowsyAagfCYA4N68szghl0cFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy8B46l+aytgc9jY+0qtSLnbsu4WgPkiFuc6kdAEj1Q=;
 b=b3ySHB+qPWpSfAR6TY101AMi8gmKMiDK3BRMHt2f2X8OlqAfHux9jRazPK+AAOai/7dTknokReJnqcaf3H3P7q7GZjygCkwIYChpjMlTxyuK2eO5RGA5WURPIXAqD4QNKUtT/m5/ESE6GbRyBGYnbf95RyC3aZNMJMQx4nvcvyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM9PR04MB8179.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Sun, 24 Apr
 2022 01:34:42 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6%5]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 01:34:42 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     michal.simek@xilinx.com, bp@alien8.de,
        Shubhrajyoti.datta@xilinx.com, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH V3 1/2] EDAC/synopsys: Disable the error interrupt on Synopsys EDAC v3.x hardware
Date:   Sun, 24 Apr 2022 09:33:44 +0800
Message-Id: <20220424013345.7359-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220424013345.7359-1-sherry.sun@nxp.com>
References: <20220424013345.7359-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0121.apcprd03.prod.outlook.com
 (2603:1096:4:91::25) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e631497-f24e-4cef-96b3-08da25929b04
X-MS-TrafficTypeDiagnostic: AM9PR04MB8179:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB8179555252DA10346AFE1A2092F99@AM9PR04MB8179.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LT6YTOefKOsT+mNSM9Mni5ISicL37TGmYEy8SCYfGNkLgmE+qFmos49j6BT1lSszM2HpOvQU7lFMOTfIghMlvPqouvWuslT+9y/0GH4I5pTAar205gYd/oSCtc15Pn1lxqU+RBRGVvr4L1/jPRcgChwXGReCkAl6lzHTMANIT08ky0EqjKmCBjpQH/fnJsCG2373RyhNyG0GUqAk/RpUkOIKHCgsMoDy7aSiTAD2DZtAcSa5xbLhSm4FeNfA2nOfQrSUz/qUlgKGz9wv1r4TvIJrBKiUtn0d5Wxs4HB/46d40Cl5zglXa3rEnCjA4GyWL2jVmseBPO8Ij2AVtmowVNp6QzOQZADN7iVtRv1mMN/OjjWxYgY6qhIr7Xv0UnWP3cueS88CYBPLCXdr4mxMLDmwy71WMGEh5WQLLpOp1R3dBG6sHaCG7eORtxhHa6xVbENt9L0ZswgEi+KL7kczB2NUAu349RnLin08MKSxWi9xa+yqF9F0MABNbbUVY+y55x+igFZhfIQM8GH7ScNEXCOZRJnOzSP+ImQQX8AhP0wFYV5xyuyzKf/Yy66PmfTVnKhUWl+1/wj9V/9wCvU5BugJmxicpLTjV0lsE7IqiaQxG2cclJwm9P7Vsfn5jhCltSmljTFwN4C0qDq7Mojqu1KFMbIcBmsvlDhXyCPX1nNIO9+bA20q1uN9fyAJlnx/kHlITtntyBkn9tnb14Ks4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(5660300002)(8936002)(7416002)(6486002)(508600001)(66556008)(316002)(8676002)(4326008)(66476007)(66946007)(26005)(186003)(83380400001)(2906002)(1076003)(2616005)(52116002)(44832011)(6506007)(86362001)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?buzTfRMP4MfV0S5oXLzkyLVzmWRJmXz7PXr6MTM5Dww/s5mdCcwj/R2STYVM?=
 =?us-ascii?Q?bjDgHvnNSx8w2iNDZCSFIX9FYBW4Ys27dP0Uy2wUfRWjqAQEGCGMbXPua/hN?=
 =?us-ascii?Q?WiAgoDQoyuIjpv1WkxnPv+BxD8Yab2xiGJofCiobInY/MWY+6dvjLOkBAbq7?=
 =?us-ascii?Q?OA0/8iYtGrROySfOT7yPNF+3IgWhNAIjMXoHw/O7F9w+mF3aNkLXnFmddRjK?=
 =?us-ascii?Q?SnUEFvSgMImU5Rp6gK0Rn9eStjr6f9u5GrKALE6awMFmqVO6WVV7d+ypVoMN?=
 =?us-ascii?Q?bk+RqGLSNCBA0+3D65O642Tq1QqD+69APbxzZvKZQRRvScqBjEA9eyO2Y5nq?=
 =?us-ascii?Q?V5xq5N/hXCloyupLAZxW86jqQTdE9Fs3vKV7I6FudAZOQzoK8JA4dJZbZ1Om?=
 =?us-ascii?Q?/+FPInzIsmb/GOYJlF+HOj1bx3Wobk/ujk+Im4Zsjc+WmZh4T23yP2ns2igB?=
 =?us-ascii?Q?m2ygRfazICuLzIXsI+uhfDUpQFTH5YKqHt0LoBqzaMi26S+sdGlBtWGyhFzV?=
 =?us-ascii?Q?PGM2AGURCUE5wu965HtyOwhwFSpuqX7U0MygeUbNfyGhvf1ZdG196K0HUVGZ?=
 =?us-ascii?Q?kxscXoVis20nXmsUJHT0HavpxfcUG9ZD1a6vACS/kjIZzcCpmnI7Nw4rXPA3?=
 =?us-ascii?Q?BavZszrVU+Ks36i0RoRrVsiZvDajGNDQkx5vNcK5ora4ic+M7VAPm0icbggF?=
 =?us-ascii?Q?2bBERD5jC/Qy0wfjA79I1V9X9EJd0bJgu2W6oPTWxQD4X8Ybg8Zfn1xWc2Ny?=
 =?us-ascii?Q?eYecVEjB/pw+6i+06HyqV1FKuInxdXuVimF9MfCsKgfl93zvpOqNgkoXHy5+?=
 =?us-ascii?Q?6jWsPV9KKmMsjgwgOqvVlJm8Hm3ihheE8ctZuCnYPxxyRr15nX28HXszEJ7O?=
 =?us-ascii?Q?ROemwPf2f9ScPPZkO/Y0dhijje98fi8hvPfuqMEoQiz1Y1phKgOy5oH1Q0S7?=
 =?us-ascii?Q?1lzDExnHMQgd98McAJojuPXlGejoyDTH2pJnn5MJsIUEqlyYYhWxInmro7EC?=
 =?us-ascii?Q?6LlvZ41DSYxQYwbmTHugVDJZOpEAsaqS5WOnc7qtGPN8tJkUD9tdJ65NxulC?=
 =?us-ascii?Q?LvHmSW6KAgVePxDtgY1f3mawmeem7481xISPvJO94lm177tviP4q12LZGm4/?=
 =?us-ascii?Q?anW9uIOKBOIWgWu/sP33wyglhNw+YhrBz6KYDAZcKn4vCP9o8zMrJp7N14pY?=
 =?us-ascii?Q?LePmnzBvRF7WSK086mc+cOB4OUIHVgxpqmms+l5Ax8ErfHCV5V2t2k1jc/ri?=
 =?us-ascii?Q?X7lXvcOLs4tvnndz6qgOO8l7sr1aaLYAYITxrvJrXU0a7oQpMpM6t/pl7mWr?=
 =?us-ascii?Q?ga9rpwyhi8gz4poIZyxe9ru0FyAVXKAxs0lYW1VCM6Qu9M5JtcHa50t/f6ki?=
 =?us-ascii?Q?ZPofI9IRPgcodXdFNyckZ8rmPkWlvtxd/szfYLfbdYaBFvM5NYepEkLPTLPj?=
 =?us-ascii?Q?/3iVNwHDT7b0CyUybkrrCVUPTGqN5XCnlzl5Jjvutm3wx/K5hcm5lRSLA1vG?=
 =?us-ascii?Q?4sTnDoSNffnOXNRT+sYOvywa9NK5R+y6Okbb3xIe5ZRoM2QNcu2pOKCcOMSP?=
 =?us-ascii?Q?e91O5RYo5uc1N1sGF/6WBYAckNLD8UJwdj7SllkThVrdp6TEn5Ackg/0VowD?=
 =?us-ascii?Q?Gv3OtpBCI+hCJzr07DaRtp/AiEwmpcQuKI1Cg63eWyy8IfMePs1cN6ecPWl8?=
 =?us-ascii?Q?OWEpCB5lvGVWwPly/e2ApR/h9AH/VtGWhkBn3CfQzXsIFR4U/We9D7eawlNK?=
 =?us-ascii?Q?Xl+47Q+xTQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e631497-f24e-4cef-96b3-08da25929b04
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2022 01:34:42.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVS9M3VGe/Bfepkj+TOGpQQRrChKyX5I7qZOjTGxHpyGMotm2zxJ1f5DDkQgQQrFkbGh+IhV0bYjYDzHetKMSg==
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

v3.x Synopsys EDAC DDR doesn't have the QOS Interrupt register, change
to use the ECC Clear Register to disable the error interrupts.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Shubhrajyoti Datta <Shubhrajyoti.datta@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in V3:
1. Improve the patch title and commit message as Borislav suggested.
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

