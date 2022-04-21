Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB865094D9
	for <lists+linux-edac@lfdr.de>; Thu, 21 Apr 2022 03:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383735AbiDUB7l (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Apr 2022 21:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383734AbiDUB7j (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Apr 2022 21:59:39 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2071.outbound.protection.outlook.com [40.107.104.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179BF11C11;
        Wed, 20 Apr 2022 18:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH7oapXC0hPQY0wv0NFN6tz9HtzIrBdqNzDsrf/wj012WqLzuwGrr82eCv/5Q04D5fFufFlJZ8JFkfePtV1NzIye7NtCY5VJVYBImcDnFrib25QiuS3zVTrmor1SCNjC3CkPwnmVl+y7TruxaLj6xSGGgguZVfzXQy1s2vPVrpcgjY9lk7fQqKfVzXCHPe+K0bZvVA2zXBHyGDtwxLkxLD12lufZOqGbt66Vfl/s8dkJ9xLF0Fha1qU0ERpkx9dqsULffGchEvD+Prd2z+xwtNbY4IDAV3+oxGLk7KWqcXtrTdU9ByeVkYAvtE51SomGwN3yCQEQ4H4X6cimtjUExw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkmdrCi/nFkwi8BolnR1iAN6/9z6Ty8Qjj7fqhoBUt8=;
 b=M8UcqUoGneamMPOJZA8UHUKqTYothOiN3VrTJNftq1V5S4Aod9A8x7yvledAigJnTkbIriNc9bQ7z5LcVb9N2V3cupG7GiQaS2aJJSGJrDfaSrLx+0srOFb3qXm97Bqx/PtAdPFvjQPJy1Ov631gfpm6jLjQcU1B6CLiDF+8EUgZ4DOBrD+tmxvXbtsVFTmgyWY32tNN//0Z67viUunBUuz/ofYKHIHRgfb75qVsN7RA5UNKSHIqQWyxqneGiQ9ie5gzvNe6oUg9oLp5jwkmNRj5t69VBfUnGp3QRXlpq0cCmzBkjAnNpRzzwPR+Oa9dC6TvPaWh3yCb8r3eLxrxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkmdrCi/nFkwi8BolnR1iAN6/9z6Ty8Qjj7fqhoBUt8=;
 b=KR4jZNfejnklWMGehPMf4WWQ7QzS3FiuAEa0rMy42wHlK2lTOK8rvd5oOH2pm9RLEW8AhsYmG6MCdkg0Wzn2e3k/LM/yp5ikoY1nzPwOxBBn2MjPtNxPwju3/EZ9seOGWsbITq7Yk76vLS821hnlRjXqr7XWTxZmNloOmNBIGX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 01:56:49 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::55a2:d9e8:2c99:1433]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::55a2:d9e8:2c99:1433%4]) with mapi id 15.20.5186.013; Thu, 21 Apr 2022
 01:56:49 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     michal.simek@xilinx.com, bp@alien8.de,
        Shubhrajyoti.datta@xilinx.com, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH V2 2/2] EDAC: synopsys: re-enable the interrupts in intr_handler for V3.X Synopsys EDAC DDR
Date:   Thu, 21 Apr 2022 09:53:13 +0800
Message-Id: <20220421015313.5747-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421015313.5747-1-sherry.sun@nxp.com>
References: <20220421015313.5747-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ee75937-b502-4f77-cbb5-08da233a32cf
X-MS-TrafficTypeDiagnostic: DBBPR04MB7564:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB75647846A1C4EC0F8889DE5E92F49@DBBPR04MB7564.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8I0XTk1x05HsIXWNuEHrXhnSZtS1Fy6Ii6urgKJWi652Gu7mvz6u/G+fgnjLpi5D++t3hrpCJp4An53o/w508DUkhbexD3r7ILJbgT+C7vxMMBMGTsNJsLNjak6LPGlb4MQn+cfCO/IYXsMd2FExxQTOWNHZgKIgHiGIS0uXGJ3iIyY6q/KybMJ6zG0DtziiAWPO2LJm6bolsWKSsbj9b63Bd6ZN2y1ipPqo0RkF7hmB1C9sH9UuEu2UdpHLG1H7JVrp1BhbyMDlZikb4t+RLpwmLe29zSkL9kzYc3pNvwJUqMX0j/ZrG7nrBH7EKCaviPa26PfioCP9PUI82Vk1WBXRAyQyeSQNfzmYYGrupl5V/2ZM6uPFVpRampS1vAXYvYmgwRBKQmbHWAZOo+4f5V+/d1y4lRK653KEUf4kEvU5G98a7HdklNRpcZPh1hMeywZkFe2JgWNrE/JlqgHtwDFGOjxhZiL8BDUmqML5qC5jUGnqRnOEhHSAFu+WAFfMkMNXiBCvSC67TG+JXYW1sjmsOHnmx707Pp8MW9+spKAlJlN1kAy1mk93SXJOAlHAPPNgUuAPUtyGT5lHhdsuU3oFg7fhfbFtPtv22IzkraifbNutOxwTsIH5iek/Da93IRN6RDR6YQw8H2T0tgvBXYvjBBezT9N9DsCSKpS/TjttIuYxGvyPFnJNHtYSx94ArV9NsdaauYhvOAaNm6a81emZ1U/NLZOOL9xbXIoFPcnrcnR/DQv4kXJDcA3ZjjuO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(7416002)(38100700002)(38350700002)(508600001)(8936002)(5660300002)(6486002)(316002)(52116002)(6506007)(4326008)(8676002)(66476007)(66556008)(66946007)(6666004)(186003)(36756003)(83380400001)(2906002)(2616005)(6512007)(26005)(44832011)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y/Stjnxb96ocgAIYRCce9jVDiDc/rcKjkpxMTYSqe/u7KdYDpSYpzOL+Mjr1?=
 =?us-ascii?Q?nk71TTDHc8/xR9O2vBelzhZ+e9zzsPMYmcNI3JpDJpN4GKLLz1PKFSED8phL?=
 =?us-ascii?Q?VGxtr4Ps3otK7wB6SHrVgt7a+xwkdtEnF9HU4OoN5YZ0wgwiZgVFWPNUN2B7?=
 =?us-ascii?Q?kQKa7nE6S+Sl0KgkJ5FCjIU+mFBgz0HqKRFQJZMMTD1GKXTrj5vk5MNlz2vv?=
 =?us-ascii?Q?R2fMRFRHcPdVgO4OwM9sXQIvKUSKsPEOxQ4EGaX0pmQ8I5aKnVETlT9U82Tf?=
 =?us-ascii?Q?iE++H6pwf3EDZnpZZtcIV3B3zvrB6upWDE15rX0B+HFTXEcuZr1mvZgSq13m?=
 =?us-ascii?Q?aKgaMZbqPVEX7unW7W3jf0vaKqi/LGW4TRj+7Xbosr6uuwNOfRQBA264Ps6Z?=
 =?us-ascii?Q?2+61d4e2Ecm5QVJEQPrajbjUVZARa8gxw9j0zoIQ4NtqApdGcdYBCAVBDgFu?=
 =?us-ascii?Q?kw0QxO36FfmUffS30eDyKb41vp++BW1Lo/I2JFKxpYjZAxxpe/XHwHGByuf2?=
 =?us-ascii?Q?f5/L5Tib7hbSMZ60JEoqV8tJzehk7migyCJiYEQxZfzVISPllreZ56k0vgTv?=
 =?us-ascii?Q?Fx5fryJ2mo0/6ZtqJG6H5Gwd7QJYBKRww0lJ6xb5JG5fCdlYwh6tlSQdVn1o?=
 =?us-ascii?Q?6ofH6rOtZlT40IHfoAgoL3DBEBQ/DVVpIG7vLQ1tRiZRA2crGTX7EkpTkidR?=
 =?us-ascii?Q?8dGYORZ58RQOntZBhYtR38VXBIyQbBFhS8ASbGRoL36s5SFMhnKMyHscS/Ys?=
 =?us-ascii?Q?CDVORQe/VUNYDbW1k/u2Dust+nk3+h9d0BbYnIy3gAUmCNCGHuYLHj56H23D?=
 =?us-ascii?Q?DBMakdMoaPl+fUsieWCZ9DV8ryma9v5PAYWJMxVqN0Z39wMd1I7l1sPDFpoR?=
 =?us-ascii?Q?1m/1RuYOy3J1xK+3HODv4pv22hqkWz/jzSVOqrv7mWJbmcYEZid1So2+swn9?=
 =?us-ascii?Q?S/jWrASzvr4gzSOYFW7rV9xDxORunoLhZw7fnOhkXtxyZdKxRKIdtNEwutna?=
 =?us-ascii?Q?nUUcyYtkoX/vCQ77vmOC7jZBob6bP+EcXRr4m2DTgoKVMrzD9FM6/20pT5Uo?=
 =?us-ascii?Q?sX+IH2TNT7Q3eBhF0NrRuvqIarpKdKeT77XPm26ySE+2qflEbgx5niMLIV17?=
 =?us-ascii?Q?r0O/SWdmWvzUe/j5pyg3WJWc3F6MRHgFK1NL6C7bKGOH6p7UaCrNsv+RPE6I?=
 =?us-ascii?Q?itWurG437QFDxWPYsf0UHEHsqYWYn7gsuEpYpM0DhVnSPEXa2714KmpoXB63?=
 =?us-ascii?Q?DMngeQAYzC0qKXbyGErNUYt66Uy5raA2VMcwQBWFUTVUmjHHfZDs/KkpWgTS?=
 =?us-ascii?Q?f4zWoUN43OnKdn6+lRLUe+Zn+bxe4/l0G+DbxxHY8Xft4ruZYljeKv/V5lqk?=
 =?us-ascii?Q?kOAp5iRAQ1sVSZxSv3yUvIiN3Y1hbK4OXBH9aNmrou0XfUyJQi6RZ75oHhu4?=
 =?us-ascii?Q?HHYHaHgGrsg7IEkY7dGhFiKcnd+0FEY73meQgm4NgSjr/qEfUEqxoagf1kc/?=
 =?us-ascii?Q?0jaxw4IrZco7ydDLE83AaSSJ4SA3rnDhWEBKNI333DdKdT3gBeq8VzmbyDz1?=
 =?us-ascii?Q?w4Ai+gyx9UBoO2iahJ+MaVemN53HE8miwXC+Sxci3bx7w+yhbooTGKwO58ol?=
 =?us-ascii?Q?O1aigP8UdX0gjdVSSlsmdVHB8T7Lght3li58WyN1IGkkgv70aV+rG1CPhpXB?=
 =?us-ascii?Q?qLzBF1FN7QIqH6t2xmJJkrE5zNrEismZQoq0KdIxwIR8dzZ2TeFJc8n+A+cp?=
 =?us-ascii?Q?MZNRZJjlNg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee75937-b502-4f77-cbb5-08da233a32cf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 01:56:49.5619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/ZuOFcV9AePRrAii0prPYYsflp8G8oeYWWpN03Oyrqg2MSwrERg06qnYVGUJ7e9WgyLdv+j0jNCimvIzEdLqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since zynqmp_get_error_info() is called during CE/UE interrupt, at the
end of zynqmp_get_error_info(), it wirtes 0 to ECC_CLR_OFST, which cause
the CE/UE interrupts of V3.X Synopsys EDAC DDR been disabled, then the
interrupt handler will be called only once, so need to re-enable the
interrupts at the end of intr_handler for V3.X Synopsys EDAC DDR.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Shubhrajyoti Datta <Shubhrajyoti.datta@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in V2:
1. Add the Reviewed-by and Acked-by tag.
2. Add the newline as suggested by Michal.
---
 drivers/edac/synopsys_edac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 88a481043d4c..ae1cf02a92f5 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -527,6 +527,8 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 	memset(p, 0, sizeof(*p));
 }
 
+static void enable_intr(struct synps_edac_priv *priv);
+
 /**
  * intr_handler - Interrupt Handler for ECC interrupts.
  * @irq:        IRQ number.
@@ -568,6 +570,9 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	/* v3.0 of the controller does not have this register */
 	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	else
+		enable_intr(priv);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.17.1

