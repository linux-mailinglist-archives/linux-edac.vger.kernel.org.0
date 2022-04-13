Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0314FEE5E
	for <lists+linux-edac@lfdr.de>; Wed, 13 Apr 2022 06:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiDMEu7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Apr 2022 00:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDMEu5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Apr 2022 00:50:57 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50051.outbound.protection.outlook.com [40.107.5.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627E626ADA;
        Tue, 12 Apr 2022 21:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFLkEL5jA2pBS1TBEuzaZ/hPa6PQ9Srb+yTm7jvWS80Jy28WTyzcqUk9aTsQ2QLjq+0oOwKkGv39tifPbkwfMl/fk/nSrnBytMychm3Ngy0r67ko1wjm5FMWPHsVJlO6sRqedjfnptmgBwkbrxXwY12gyEYNoMar6DCw/fHs+r9r6yz3zz6aTNZMvsBY4PHdd60uM3yCTw0Eu7tCzV8XtrRDtQEqFpqcqJCoeOicaBL+Q8MD1NsMjmbtOhEGo4dK4IEXBXAZlgAOQryGHZLhguA1Pkn/X/GfYAt1bo5rqI57hir2auX3CwNn+CnsW3njBwUB6grtVW7mF4SB+gV1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RkIaiuch/k4v5I6XyaofiAM16SYHpo7woBgFRK72K4=;
 b=YKe+LebCLEalczcg1ltKDZH3raKAyGZjcJKdJfKxmaAls72M8x5BVNYwJ6Z+mOiVsqEKUaYOv2qmFqHpO5aQn734ztvcRTgThuLFnNecxM8zTgO7hwYAvaZlETKmzGm2ofhJDzntS669pOyqIrpbfeoYPlLQZHzFqZTO/U2YYGZpn1yQGiK/WVQk0NWc+m4TCA7AugeHn+lLVnecc0N/ulMcylxuj3KI1MHBbjWLw6ZI2WtFu0+glMb16MepeBNcE+aCkD2YEfndkTv2mV0Sy5yOuRRBGzSUzEBseIRnHT+aSpO5Q9wF4tLCTwd02GNFo0MQbsVU7mxOLhSuTRTNWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RkIaiuch/k4v5I6XyaofiAM16SYHpo7woBgFRK72K4=;
 b=WESa7p7WsUnjF4DQT6puyZoFJWvjuu6xj50JMWpM3HmpK8JVzq2FIRMgOcdIabuKhvcTZLBazbRoB2EjX2OqbpMSO2JTaDBlGq24pvTBRzTLArIQ9WmFrSl0vPuGo28a95/Swe6WuTkS3mLLUMRUzTcF+GpwLhpxl3mwqdEs+0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB2948.eurprd04.prod.outlook.com (2603:10a6:206:e::14)
 by HE1PR04MB3209.eurprd04.prod.outlook.com (2603:10a6:7:1a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 04:48:32 +0000
Received: from AM5PR04MB2948.eurprd04.prod.outlook.com
 ([fe80::21d5:ebc7:be07:3718]) by AM5PR04MB2948.eurprd04.prod.outlook.com
 ([fe80::21d5:ebc7:be07:3718%4]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 04:48:32 +0000
From:   Priyanka Singh <priyanka.singh@nxp.com>
To:     york.sun@nxp.com, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        priyanka.jain@nxp.com, jaiprakash.singh@nxp.com,
        rajan.gupta@nxp.com, rajesh.bhagat@nxp.com,
        Priyanka Singh <priyanka.singh@nxp.com>
Subject: [PATCH 1/1] [v2] drivers: edac: Fix bad bit shift operations
Date:   Wed, 13 Apr 2022 10:17:54 +0530
Message-Id: <20220413044754.29516-1-priyanka.singh@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To AM5PR04MB2948.eurprd04.prod.outlook.com (2603:10a6:206:e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dda57c2-2afd-4e83-a436-08da1d08dc91
X-MS-TrafficTypeDiagnostic: HE1PR04MB3209:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB320999520FD5A3661D41C9E591EC9@HE1PR04MB3209.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9Vl40QHg16orT3aaRgbPbm2kOvjZxNwav6+LLitr1XIPb94wmOYQlf5KqWI0xnf/iRaMO4Y6fTJhtGMslNS/AQC03iqVGBAj/AjNS+Eu4SltBUq6nI5E+N0po75t5rWWWKuyHoIZrWlGtimO4zQ1o+yL81d0CxjqqzNBUb3ndu5+6c31DsfMYCGh+pYYKTudYNuyVdha3bl5n10CGC433aRUfrXJ36kGawNcUfBgxIN3lwpeVRVaRa/RZ2IlU+dXK/ukRVCIazCn2+z0rQfGqGTHpYJ9Ja7s/ag+aBOCk810nq2t8Fvh8mS4kP4o8QfiIIM1IqvTRRD17AryWoYGyp0hD0qSH/ItLq8w1BCsvnCdCMqq3L4tS565rPvcikUJKE21fnX5N8XZJZhh4MHDgETWD8yfU5hDGmnLyj8SLDcXAAzYNygT8Ven8+y4WkMJt5E34VRabn8SY5ZHcg5GhWhoPXo9mjdRZM0j1HNZ6PEhwUVmIF0Wvoq5bl71DDddiy5JhaowCewtkKQPqdJdm7AcFrwdPfvoR2AhAge8EfA2oeiypaUYIPbC/Jmm11D+zuGjrzMzOMtqDFf259pGz3/zsK5TQVVVEjqHz95lDeq2LqhrvJmSHxQ4GApc2aSeFrDyIu1+hDgurhr44Ps7n8w36xFvEsns7ylJ7dzJCApCIHJt4Fhq1f4nLhCVnjK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB2948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(86362001)(2616005)(2906002)(44832011)(38350700002)(38100700002)(66946007)(66476007)(6486002)(8676002)(4326008)(66556008)(5660300002)(6666004)(316002)(508600001)(8936002)(55236004)(52116002)(186003)(6512007)(1076003)(26005)(83380400001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QF3/Pm/7LrKJl3R4mtAYlzx1HrDt/iDHHdBnTpIGUtr7OG/Nwz1+5QH0GR6Q?=
 =?us-ascii?Q?u0RcdH6JZHCnQovFhYQYu9d3LwWfTSFg8+8r1aHHRvxr2cb/eO/DMSRWnr+s?=
 =?us-ascii?Q?TB1YMUZ1/zrjKmFvWal5QhoglYOrhcC36cBdiPIRBUBT1Zg/33XNDb3EA+/L?=
 =?us-ascii?Q?6EqlqeuPn8DP35Os3mF2yegW2K3RWo/r4ftwyJMb4XdRSJ/6XvqnTArefiEc?=
 =?us-ascii?Q?vklj8x4wf+ux63i2+MxOMhwvWff7xJI/iqvfWr29mGtr2ajkLquMOV2R5g5j?=
 =?us-ascii?Q?hhh7P3cAr4Ho7i/+p9EQFGB0gyOa5DMR5uW0BTKcRFGjaXn8/xkhhQ20LsA0?=
 =?us-ascii?Q?1Ympi7MtCcJ+E2P9e134p8WtfipsBE7WnrZ2z0o454kznVFpoq1XgmZBvlI9?=
 =?us-ascii?Q?SYZEzGvyNMexleepHt4spQAy8PMKFfnZ76mpwp4gNeh0Uf08rknERdtvEjLK?=
 =?us-ascii?Q?dylPqp+HYfcIl4edhbz0Y/KvD9LwkjOQtPL9rhlM0opK3y43mVx8Rnsf5Zw0?=
 =?us-ascii?Q?GbFVr7EVe68ZdbF4rsTUmcrYHRLucJZ8VNEiWrTZQweR/u9oPh+RyIJHdNSn?=
 =?us-ascii?Q?/+uHamu1BSqVF69ifQCtfYUx2s2Go1KkQnCGESIiQ4O/2OrEYAx7+L0v2XLu?=
 =?us-ascii?Q?8bBZO5U6NGSs6U3mBsSBs/X+bvDVXOY5z4QISLO+k2mufnBZNMwQV87n5eni?=
 =?us-ascii?Q?cbENRJ9gDT1MgqvsCwrZjFO/CXIAXHu13atvQkbwGTCRBIrgcKX4KOPWRJdi?=
 =?us-ascii?Q?RHV2MjSdv3AKvL2vZaOxDjmqRrOObjhAOg0kb4aTr6iec8JfQcV/8Z/GvqaX?=
 =?us-ascii?Q?dskJ/1tpiyfEeI88crcRX9ka8fjDdIa48ToT6pfykalRdWhb4uNuvU+CmRRu?=
 =?us-ascii?Q?EEdItRjPgicZikyTFcRh7xIPr9cvEqimt6dWrASv7wg5ApRaam45FJxeeHvK?=
 =?us-ascii?Q?BpjD/PeJ9N29AA4dXw0JVT5TRTl7E5rIf45sk2Icp8apYl0dtSx4OhfBLrb1?=
 =?us-ascii?Q?3I/Jy1Acdj+2sHYYK9SNjKGdCaG8hoRu7DqARJYnRSgVVHmtT6S15/L23kyx?=
 =?us-ascii?Q?d5mHg1V0JaKAaeuFrBNikU88d9PY/PVWchiDEnO+dLtnadDlo+H/kXgAD5xh?=
 =?us-ascii?Q?W+G2yAyE/uGttK1E8hD4g7eLgvoa/hgw9wWXHVSdSW9nO+vL8fgXh8id0rbG?=
 =?us-ascii?Q?Ni4PmSoiUq9DXOux+TZVFBiPKrYEnODGIk3zwmbuIizJe58Zax+P6Zl2CKa3?=
 =?us-ascii?Q?jlKzvioCDm+gu1Lb2x67V9183tlKxLmrLTSVyb4kBLNj887KXjnpe9Cezure?=
 =?us-ascii?Q?Tj0I21NjgIgcl89d1kbtBC8WkS+IlDi00QHPA4vyB6zg+Tya/QJqG0sSebyd?=
 =?us-ascii?Q?VoHWmXS846euW/z/FFCIWLPpJUHS1HRFVFQeXK2gV43J6cWSzEAWAld53ASC?=
 =?us-ascii?Q?85BWhJIMiOarbAYAhvw1b2qliBAQuLAg6w0UxCAHFd9We/wMF46S1e6KLnVH?=
 =?us-ascii?Q?ccBBCq2ccLtMzwQ42spk7NKv4ZLxrr1q8yKuSAjqC4ofTgXsSuQTcndyslV4?=
 =?us-ascii?Q?q+hiFn7vyLzpwOWEueFXGLfd8xaejdoitzmAcJP4L4ewlHlbpJTf2Cm0dH13?=
 =?us-ascii?Q?ICu4H2gmU46iysbgz6nkYATA0e7mLZhRFoXhA1RCh2XUZk2f+/8kc5oTvQfK?=
 =?us-ascii?Q?xIbuRcac7la6PO5Z7Jto8pG/gdp45m6Bjv7yGg/PEH+HZWx5ZdNnk4Iu7ZpR?=
 =?us-ascii?Q?R4XoTHpatUGEJWrIUaRLofFNRVsUShA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dda57c2-2afd-4e83-a436-08da1d08dc91
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB2948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 04:48:32.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMH+m2PGgMjVQKHSrfND9ObPMNIMcvqCOyjKQrlzlrdXsIv1K2uo/qtiyJ87bBMJI96LIeS5Ezc3hgqV08dOSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3209
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix possible bad bit shift operations in fsl_mc_check()

Signed-off-by: Priyanka Singh <priyanka.singh@nxp.com>
Reviewed-by: Sherry Sun <sherry.sun@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes for v2:
     Fixed compilation warning

 drivers/edac/fsl_ddr_edac.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index 6d8ea226010d..747c52b019a2 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -6,7 +6,7 @@
  * split out from mpc85xx_edac EDAC driver.
  *
  * Parts Copyrighted (c) 2013 by Freescale Semiconductor, Inc.
- *
+ * Parts Copyrighted (c) 2022 NXP
  * Author: Dave Jiang <djiang@mvista.com>
  *
  * 2006-2007 (c) MontaVista Software, Inc. This file is licensed under
@@ -334,18 +334,24 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
 		sbe_ecc_decode(cap_high, cap_low, syndrome,
 				&bad_data_bit, &bad_ecc_bit);
 
-		if (bad_data_bit != -1)
+		if (bad_data_bit >= 0)
 			fsl_mc_printk(mci, KERN_ERR,
 				"Faulty Data bit: %d\n", bad_data_bit);
-		if (bad_ecc_bit != -1)
+		if (bad_ecc_bit >= 0)
 			fsl_mc_printk(mci, KERN_ERR,
-				"Faulty ECC bit: %d\n", bad_ecc_bit);
-
-		fsl_mc_printk(mci, KERN_ERR,
-			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
-			cap_high ^ (1 << (bad_data_bit - 32)),
-			cap_low ^ (1 << bad_data_bit),
-			syndrome ^ (1 << bad_ecc_bit));
+					"Faulty ECC bit: %d\n", bad_ecc_bit);
+		if ((bad_data_bit > 0 && bad_data_bit < 32) && bad_ecc_bit > 0) {
+			fsl_mc_printk(mci, KERN_ERR,
+				"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
+				cap_high, cap_low ^ (1 << bad_data_bit),
+				syndrome ^ (1 << bad_ecc_bit));
+		}
+		if (bad_data_bit >= 32 && bad_ecc_bit > 0) {
+			fsl_mc_printk(mci, KERN_ERR,
+				"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
+				cap_high ^ (1 << (bad_data_bit - 32)),
+				cap_low, syndrome ^ (1 << bad_ecc_bit));
+		}
 	}
 
 	fsl_mc_printk(mci, KERN_ERR,

base-commit: f6695af7ac79f92d80a7c20fc86a236d1784562f
-- 
2.17.1

