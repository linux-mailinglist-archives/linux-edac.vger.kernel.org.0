Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5534FBA23
	for <lists+linux-edac@lfdr.de>; Mon, 11 Apr 2022 12:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245058AbiDKKyp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Apr 2022 06:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiDKKyo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 11 Apr 2022 06:54:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831F341606;
        Mon, 11 Apr 2022 03:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AauVRtengVWRh5pbzsInMaB21LjpSQnU9DzddUEtSkQT9NdvdwDmTB2vj7AmloLBcHCA3dBuUz7VdKL3sLkBrZJhRGIlkiRZvWX8CQuo3sVYmINuK9sPdObq0uerBAzoT/VBktG7kcPWpSP0sdDUWJ7Tvb92SBeqEoHuenDpCvCE65xBhsOwZ7RQGmtvR4/4EvZA4wg2ezSeGxS0MTtexdCtJAqauezsYgcE18/5JrziQoOp+XFTwR4fLfzQhiYrhVOU9ZtnwLq2FDn/y+5jbHIaBnFloqTSrPZQTSmQ343ekkuHjYdL2s0MNoZvGasVSwCvnP36xPtv0YYbnhP8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUPeChNCokYLpn9TfwhUiQaTXykUu7pna/xbj/Qkd0Q=;
 b=iPjPZRzY/o0p5AK2DVMHUE7c72LbfNjxmrYCu7CVPW/8tn9Bj2St1OI0n74Or8Mxvrnbj9UM8+f/myXt2SKXzrzNHNTGk75wOmLtJpE4HtgJOndPS/XS7xcj1CrLp0ln78fTuMN14+zdOkH2E6rxespBQxLaagsEtKRXVoaa53M21WwDG5MgK0UQQO7XHNTRli+iXtRqETJl/haoj1AiFaB0jYvzBCrqlBN0qIxs3wnv/pH18OKyFBJi9cOz2nq06TYIWw/LVR+DHSJNRphBG4CCdsaRMG3hPd7Hmo9YvF0zRYPPpeR+7kzk4q7/WVNqbevIeqB5vKSiWP5ldLlcsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUPeChNCokYLpn9TfwhUiQaTXykUu7pna/xbj/Qkd0Q=;
 b=mTuPmwP1wYsGei5963gvItKjHY0zhhoCUerFKGHL06ISgDsf2zCQeQttWdUkbswRHqlb41X+R9WZhPScVNXgOX3MxaWxXecgVa3jREkdF3i25FuopPR33TrGqeJ9zHoU7PkVflMZjM1zMZYEKM/rhcLy+2kMIICO/GbThN4UpAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB2948.eurprd04.prod.outlook.com (2603:10a6:206:e::14)
 by AS8PR04MB7800.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 10:52:27 +0000
Received: from AM5PR04MB2948.eurprd04.prod.outlook.com
 ([fe80::21d5:ebc7:be07:3718]) by AM5PR04MB2948.eurprd04.prod.outlook.com
 ([fe80::21d5:ebc7:be07:3718%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 10:52:27 +0000
From:   Priyanka Singh <priyanka.singh@nxp.com>
To:     york.sun@nxp.com, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        priyanka.jain@nxp.com, jaiprakash.singh@nxp.com,
        rajan.gupta@nxp.com, rajesh.bhagat@nxp.com,
        Priyanka Singh <priyanka.singh@nxp.com>
Subject: [PATCH 1/1] drivers: edac: Fix bad bit shift operations
Date:   Mon, 11 Apr 2022 16:21:59 +0530
Message-Id: <20220411105159.10746-1-priyanka.singh@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To AM5PR04MB2948.eurprd04.prod.outlook.com
 (2603:10a6:206:e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7df470f7-360b-451d-4e53-08da1ba95e40
X-MS-TrafficTypeDiagnostic: AS8PR04MB7800:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB7800E5F9A940CA0F9DE1C73C91EA9@AS8PR04MB7800.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxAaUZ/QQkvHMXMH5Gq/Myn4a5a93Z2mFvk7rjCaKuSfPaZkjUOJAOCgX0F1VRFeXwqyBx7KzxPsKozxUYwI5/N01wFmxr1OYrx5+Uuc9Sw5dyjDiYC0VY+lm1S3PPDlMHbkizaHGRMfdoLwN5DiY+LzsiTXF1Osh/VmVZA+0ua6Ai2EzUHnuOQcRQ1XD7TOe2/O6/lq7bllMi+CDHd5fzJrb48SeIRww9953GXDVFcxrOBr2oH1PM4OtXG5h/fyj5VHW7SvU+e6B2PF0RFIGqS3sy28r3sffEdxVY4UTaMN1gqGnuQkqwYzN0Sf1QPY/ViAU1wq1MPjYtIUBA4tKgU7tO4cZ2Kv5WK4sbdDfr41BVGP43+DeGRx182OTIaKw0mLt2aBxG1SmSdO22tvRnwA8N9Ao7hT9n/7NMEkvOkzVJma/yl1gLkWARd5ukWLCdlmdStDiEADfNvrj7QAYv6uS2szP1O8go8tXVK7qPZw4TZZERZ2StXS9oxq0gWggn8Yh8X6dXKf55AP1pPwV0zUWdjJMnjVV/VLdu2gLVp5BBs/v0MRNpyoS2EU8sHQUOK4NImLNC53q1+M92E14slt+VmUdCQS0VshS+aDDNN2SHgs0R1SLZirfd/+CuXj9F6zCoxTJKSWISqxka/lGBuZ5jFTA9qdR5Yru7OINr16lZ6eyGh/1Hf8DejZaXE2DnpNoM6MpMseK/NMtteoZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB2948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(44832011)(55236004)(6512007)(6666004)(52116002)(83380400001)(66556008)(66476007)(86362001)(8936002)(8676002)(66946007)(6486002)(508600001)(6506007)(36756003)(5660300002)(316002)(26005)(1076003)(2616005)(186003)(2906002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?70QPvkJKS41/T4XuZiBXwsz82pAXmZUeaVQmXHH+4wYBSlVsi+iq32acu79A?=
 =?us-ascii?Q?Cut4MQCWYpImy/WC5c2ENF11FlrpMeqOgbQaLcR5KhL7xfy++p2QEwivmj1g?=
 =?us-ascii?Q?R0TmIXcpLrTyZDU/5/dohCmxc1CPoAWg45DZnK3VagGzmtP9jA4lt6CnhCZK?=
 =?us-ascii?Q?nlW+aYESmCkGM4XwlIS8BGZtKz5PuZ5lJoLQ9MH8AAoc6SdO+C3NB7theMe2?=
 =?us-ascii?Q?6B3xHCgVLwkIhKNcZHs/ggbRtSOSvXNKhfIUBAuTlfjn+0CB7C+ZbRW6z8rY?=
 =?us-ascii?Q?2VlSI6KNMKMuZCXYs9tt0v/RihIrw2T293+Zdixms+hkUudSClywl65g7h+/?=
 =?us-ascii?Q?shhNQKqxTo03p6/v2m9sKiJWBzTUYNhapFEl5AWzBOG70K8IvsShQwFZKSlt?=
 =?us-ascii?Q?a1JJYffC1EyryD1FTkP1VUrbDI4wHWx5IhSQ/wWv8zNBLNcR/pmPs8sRYo7p?=
 =?us-ascii?Q?XWTeFVZ5ocu1EMQ5Iulh5v3MAYAn1kAcVuqud+FnNQP+zwUT3KsVqx/ai2qL?=
 =?us-ascii?Q?5jyhu+KHgDX2kXkPZTCtO0gDVg/xQ7vWt7QLt5/Mo6/dkneUH2jUs/rIweXo?=
 =?us-ascii?Q?oASFIU71ivhCSvx9r7x8vi4XABik+sSlzv6FamqrXOGHkbkmGs35bTde+IH9?=
 =?us-ascii?Q?6JXekEFlUPPwQAsFl7s4A+/gUkXJlKWEEE9qdykaRYdoe96pileu7zUJANuA?=
 =?us-ascii?Q?OgUBA+fJGwE+zcAdb3Yyhlg+47XgjnToTxU2gROO8LqYimTAYB+qKwhh4JCp?=
 =?us-ascii?Q?tVkSYVbtr3e97SxGsC6kEG9hxnonlaOnqnwALGCOq53WJclHqpw7XNjAeicu?=
 =?us-ascii?Q?UAi5jacTU4kM4/aFjtN10M9xrkRAibNIS1ooEEcAz81P5cDoic4UkzrQqZzm?=
 =?us-ascii?Q?xmuvyJoVxf2G8NmdCVWJl+x8KFfHd4hy6DB9K9WhPSi+bgt6O7DaxWrAfC38?=
 =?us-ascii?Q?xxq03HgxrYaIq5kAbl78eVqn5yHO4BNcJL5oeZCdV4f8PLUwAKRZUhcO0Jke?=
 =?us-ascii?Q?x6UtjojQng9KCIH6w6gAmnTqmaBckwF+RNKBdTINeXR6ze9e3PKJ+aoZpVpk?=
 =?us-ascii?Q?XNbgH5Sm52QYlWz+zu4THd8oPM/tNjJ+eoHvg/TW2GwYR2C9PJzeU9WuDjL0?=
 =?us-ascii?Q?UTlxUpgD08s4uJ/tmJ8BVnT2gqUZ71bR0hoxRbNqatTNQ8dhpFQKLPZffERl?=
 =?us-ascii?Q?Ah3wFiwaHbcPDx7FMtFyRIEEoXbnbWHDIFBX+JttdjL4oR/9yBwdIl8BlxwB?=
 =?us-ascii?Q?zKFW4ky8DDEyPaXT3chch79lv6vqFOoJJ7S8pM4leMDDw1atxnh5BWCFjsV4?=
 =?us-ascii?Q?wH3Nebqv6na7gYkP7LKL+K5L5PwifMH6HnQyp06B1WGkpEnE8hKuGKyrxZ4f?=
 =?us-ascii?Q?7J1kGLcTDwh6uXpidC8r4Jy9f/tR/wnYQE0rq7sJ3rsOFOdHM3zsjwdv4wrI?=
 =?us-ascii?Q?49W4rrv4LW3d2fs6ceeG9s5oz3x2G3s2hgLWl12eCwSl1KWY8xS5Zt4Qe0WX?=
 =?us-ascii?Q?JRQw+YToBjUiaRIVnGEZc81/90oKYOaqKKQ3XAmAVvplHOyu8VCArHF9k1Zc?=
 =?us-ascii?Q?6I2VvYP0r/dqsSTSgx+q1aSAkTOnrzNeVHpc8pAr4+/3UbFtNWCd7wOMz63h?=
 =?us-ascii?Q?zZuCH13eXIYUvLi+3+A/Nq6HeFYstULhGelnSPL8nOAbX0f2C20WVcdGKAPr?=
 =?us-ascii?Q?U7sjPsoa4ko/YAc0C2Wk5dhSPXJgLKSh37jgS7EBzvEw7doa9HV5vEY1+UHf?=
 =?us-ascii?Q?JfR2lrB7oyhcAyFa540Ikpfk5B4tEdw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df470f7-360b-451d-4e53-08da1ba95e40
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB2948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 10:52:27.3854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8V0GqJ58iAd4Mqm/2Gjt9PM0gpr9GbiF1Q13zoMk4SWj6rqcnc2KvcbKBIq+QHqWFpvFFOPvC3AE6IplL8tIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7800
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
---
 drivers/edac/fsl_ddr_edac.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index 6d8ea226010d..a4503137e62b 100644
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
+				"Expected Data / ECC:\t%#8.8x / %#2.2x\n",
+				cap_high ^ (1 << (bad_data_bit - 32)),
+				cap_low, syndrome ^ (1 << bad_ecc_bit));
+		}
 	}
 
 	fsl_mc_printk(mci, KERN_ERR,
-- 
2.17.1

