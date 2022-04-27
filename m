Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89C9510E5D
	for <lists+linux-edac@lfdr.de>; Wed, 27 Apr 2022 04:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356967AbiD0B4E (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Apr 2022 21:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356922AbiD0B4C (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 26 Apr 2022 21:56:02 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4DE12A9F;
        Tue, 26 Apr 2022 18:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMoH0RIoEzDkiLtAIv85xB3hbg1ChSYAl3GBEVbGGulwPeTYbsg0krt3hlhhN51ekL4LHJOK5z4mNtklbx7D8EOa+kY2w+EdyMoFPVKx0YfRBoSU4iYRoMjaDH/nwY9FjSdQmKuv8PUVNKZFjtfZaCX/Va9mT2WDPZX/jzuFG4skvFng3t2ia1iJ0Qv9+R/Pojz3F9RMVSfaiQ9aSKHfX6jjdWmUuKS6wGroZOn9fV8fKUk751sWbQGllkfuA/M2FqdIIo3xYuthGPxgvKNTRkGEPnvAfoM/6lnVxY8CbYLwI2TAvT76hgyceRYHR3TYLKepL5A2SZ6JjkiAivMnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwnHzvaiqyT04DKwzBRCFeurDGyjmox8aebpkR+ppng=;
 b=ILCd0xS9C/46ldbk3iRVLx2T3tLBYG7i0iVYetMBlIo1glxkUl72R79dHYV1kqqTUMppIxCxRLeRCpmt2UEnVnn8hq+WFVQ3/2zoIkPSWry3NJws7ujcMgKVlJeD046S6rgwHFRl56KC0Diry7F9pgdXEUHrfLF6YNlQ4WwgqEqOspRRuhRFVS/UqS0VqX6qWwEYqVJ3Mu5kkICHuE0r1AZZXHLPtHHaipaRk022tzh6CXXgZ6n50RgxMhvlodhz/GY2dix7BActGfgc5/kl9714CfQRiz+O6h3dTsSX7sB2q9yL7HK/1dI/ENpmcBUZAUzcwnA4WcLX5kMBMX1fGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwnHzvaiqyT04DKwzBRCFeurDGyjmox8aebpkR+ppng=;
 b=GkeG5TwfgJRRTNwD8x4BCz6QNJ+fL1Lm2wpK9FE9NQMjZL91eMjq9pVq9x1UYGARuZ91bzS3w/T+Hx2jUjaaqo8Xxgfgcjj2uE3P7M4OBVwvA/oDQKtfbmj+KeuwnvtpflGLVmM35FxtYQXpr5mv+D7X32kooD9b9NMt3KzeQWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR0401MB2589.eurprd04.prod.outlook.com (2603:10a6:800:4f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 01:52:49 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:52:49 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, michal.simek@xilinx.com,
        Shubhrajyoti.datta@xilinx.com, dinguyen@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V4 1/2] EDAC/synopsys: Disable the error interrupt on Synopsys EDAC v3.x hardware
Date:   Wed, 27 Apr 2022 09:51:36 +0800
Message-Id: <20220427015137.8406-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427015137.8406-1-sherry.sun@nxp.com>
References: <20220427015137.8406-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3440baf8-2a75-41a9-3564-08da27f0a246
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2589:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2589D0278D4CDF610E8C626E92FA9@VI1PR0401MB2589.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzrC5r8x31MYlZRk+bY1+ZrV43W+74nUJbfYpGP997L97Yk7ze2AG/0popn3/ketpUPQr3K96i2fwBA19YnwcBj301cpGhiblQRlN5FjT+J0CP1m8z6T54Fu9FzB6inU0wTaBw5YYNrcG01eioo0fF2B5pE+6/BDXOA5AC0706oj5VFkoxXeFRsMQcQ+Pv526e4pvDCMM6QVc9xwYhCzbOZzslQz+T++jNJ0si4MipaXXmrcdhbxxfdjFNr1PaboucsnXk/AdcFjs7ehlx6qe0Ch/Pcoi48HP36CRyBd38EZBRdFm3n3UgNHpUfbJwMxPg0HVYhnrEIlT0vIBdGzJRZbX8DJmykA2N9/YHtaj2QnLxiMRLONdgGek1H8nW3NRFpMMUJ+cDvrC6mxYxNd/GvtWK5HWmVd35pXI+L3GtM0fd08XdXFGjONlZHJJ4p5vDdQJyKmZ05wQbrARdIDAO8l77lLOldiHHqADRQvKfLR1apn4ypdCak3mJY5qhE5mxYO2eNj49LxCPatiK2wPMM3u6xn6TdRX/ss9iXfOPFEZ9QU+rK5ZLmYqeoUNeEWVP4RCjJnV/NKFmw9daUSwy3cKNIbvL66kqawOfov4scbnIg3KyRwnPlnNTt3SJu+ZIhgFkYbiHzuAFpDJMcz0F6uWsB8U5IfJxbEp0tfMUH5h4/4ouW1s6531DOrieH3PG0QVDbIvKfr8aN56HIdGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(2906002)(6486002)(508600001)(38100700002)(66556008)(66946007)(8676002)(4326008)(66476007)(86362001)(8936002)(44832011)(316002)(5660300002)(26005)(6512007)(83380400001)(2616005)(36756003)(186003)(6506007)(1076003)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N3X+eqZ4/s0ZoPsR0oQW1NGQVySCEdi9k0v7pihA+zb7iOqOk/BGckAfvc7e?=
 =?us-ascii?Q?InQO6D2SauvoVQxrZrxMKtvcfTBZN7tWE3V9ukAnK84DwiGzp1PArvmC7mdp?=
 =?us-ascii?Q?q80j+zeCi8hBmcMA75/YbwajkA5gld505XLkBbl2BvH7d24GkibXGzKq0zzF?=
 =?us-ascii?Q?J6fcezrgMKqtpM6+9Cj6rnPbT0XfvFV3NodBd8Ee4DICq8bQd3GdWdCqoJnZ?=
 =?us-ascii?Q?EVnMcvIBKWCZZPjmgS7AhS4Htw5Dtw39XXz1++3TSlTB5KFNS6W8Nig98jSR?=
 =?us-ascii?Q?/sMdUb+G5BbBmzXwjbIqyjzcqopJZkMNZIG5ef9ZQRbT7j9D1qsP1cC/9d9f?=
 =?us-ascii?Q?KSIiBcma5P8a7sGB6WD2ROlNrQOEuti4mHJ0BcGQGGSVX4ZStvFx9o905IRI?=
 =?us-ascii?Q?51MUw+fvqc0q4Ubog1JHKxAlsyuUeF9YlA36js2Fy9oz2hjumYyywAH3ZkSP?=
 =?us-ascii?Q?LU2Ur2axaWANeb3Mjzq5lCfy42zjMDm5bEQx9qz+x7+iAEi53iuEH0vaPy6k?=
 =?us-ascii?Q?FMtFcUaLiqKm8PfglEzvuH+rSE32A6RO80lLM4PVHANK1Vl2q4KkJNgNpqgd?=
 =?us-ascii?Q?RoxU97Vb2E2X2HVV57mHlCYmzW66QM2gD8jiX95WmIcdNMbZvRpZg5McdC/Z?=
 =?us-ascii?Q?wCys9shOuSg5+Bqh4eUSPUDyxESFx4FNp7+CMRVID36Ejmpdc6Vt5eR6xNGP?=
 =?us-ascii?Q?vbe8spwtJ3ze4yO2IehBHMWTtEl5OKYEvXhUAhwrmOMuBhFWu3ZK6HQbz49p?=
 =?us-ascii?Q?YXzSGAjUxeoN4TKn4iMovvXKzOswbJSOwjLeLpHdt85cQobzpJ/y+6Vxelg8?=
 =?us-ascii?Q?/dEknDwp8EIvYnTSTiAWRjaEnGMl5Kc24dbHf/GgO4gqzSjJ6Y95xSeAeV7O?=
 =?us-ascii?Q?tJeQ833lU43ht3eigpHpeEd2lRu9WGF3CxM7ymzmbWIOgdCcPjHBEOfaAVZP?=
 =?us-ascii?Q?qIlfWwA5V8utVxLnQQPekwLX1BQmvt1Z3zrFdCCqrHR50iBh9plYvTjkksr/?=
 =?us-ascii?Q?jif4kMxNWo3o5WH/Rqosd1Kp8RmYpLwgnOe9Zj+ts/onC3e7vNEZHRyp5l23?=
 =?us-ascii?Q?pIaelSBivRrMxeG1b63u8RTBqlVJe5RpSUB0+HBcMhYQ307P7jtB7vjh7j+Q?=
 =?us-ascii?Q?nxV0KZjQ7ZgbY+xwBWtVuSjZZOfNQAeD51zxv3RZsYNKJq19jm9tEyYRKdiU?=
 =?us-ascii?Q?fjP/YQRSePHiQ26UGKgrYGCnHF4nvwu+dxXeNuVwTcxKA4ryiF8+yHlGAn2Y?=
 =?us-ascii?Q?zztJ+YzZGooCNXgntsExJUsAVS4Acjv3ormsmtYKaYkB7WziV76AVaxeY3WA?=
 =?us-ascii?Q?PCOfQyT8qhr5DPUz3g1f6/YUjAeF+ANtkzbf6vJLZ3MxtxfqEQemo3xCiiLi?=
 =?us-ascii?Q?6icD2i9R0+H5vYb5IdjU6GgoQIXrU1viPmpPtlDx4FvjKFTznVPgV7A3unS2?=
 =?us-ascii?Q?ZovInEXe0Ey96AbrqyImUbaYARbT+8GCLEN6oY68Eb0+qKHD7xGOCZ1XTShG?=
 =?us-ascii?Q?8v9tc4EZKFgkLbk8Rv0jGeDzlazwzEpHaXDCp2eVgHUgxxw4wI2XWtzMzjxH?=
 =?us-ascii?Q?E/XzuJgopMlSJxWfVTqnmSTfrTDYC8TIzBi/84r28xNKK+fTylZxaSJ0QX8e?=
 =?us-ascii?Q?R1MrsVzwFZb59yUpsB/4G1PuxUBu+CIY85YgcxAuB4EIIqeIgAfjNnqAPTXk?=
 =?us-ascii?Q?Bsd4u6IOjWgbBFJx69VzUshLpztWRCQMTHL72nj4wXnKucMTuFqOmPgyDKDL?=
 =?us-ascii?Q?NcGDk4SoSg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3440baf8-2a75-41a9-3564-08da27f0a246
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 01:52:49.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nX1mz5nY6nPprudy9MAqfcFHIGQAXPceoAZhU9sW5uR6ceTRRm9PE01ERIzBfNXS8ycyU29HY/arpYAc/KJ7w==
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

v3.x Synopsys EDAC DDR doesn't have the QOS Interrupt register, change
to use the ECC Clear Register to disable the error interrupts.

Fixes: f7824ded4149 ("EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Shubhrajyoti Datta <Shubhrajyoti.datta@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in V4:
1. Add Fixes tag.
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

