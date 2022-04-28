Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6C4512991
	for <lists+linux-edac@lfdr.de>; Thu, 28 Apr 2022 04:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbiD1Cgn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Apr 2022 22:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiD1Cgm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 27 Apr 2022 22:36:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060AC941A5;
        Wed, 27 Apr 2022 19:33:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdorFVm0rLiUpT3IS8WAjO44B0MmPPapCcCNuhtFTCereQzP0bClt54hsbJ9GvVDZXb9gAdLfaNNEQS6lICPSWxRdeUcoo3ld7OUOKf/YQFcRH7NciSd4/lf+VB5NeDAxJ8l89X5fhEDHv5sADpheqB3l1dcdSoznO6zzBdrQn+nrlfjYJqcIexhgWvXX6yfK2qkv1dVtr3OK4lfPl9ZWx8bjJjFbq17v/zYVHXr5LDu22dvGfZG4Zyw/oehH6CdX4u8JTnJcmMqtjuyZD6b+qSjmosRJ/Cx3IHwqKMuGa3GdKnvumCJrgpBAZWz0MFmuZZ1C0WR40le4qP+fOlvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbrIfNF6E+84k5sFEpuyK2PAorsQ79gB8Cl9SADoRD0=;
 b=BVO15Pg8nAh3xcFaDJCiyZs6NJs23vES0KrwIFTT/z6ThrpNTj3T/NVyAb9pNZ2PyIm7y3tYKiOlFDJ0FVkZKebSQpLEgNVe/5U3YW2urcxeNfyutjX/qiGjr7BaQ8LL2E48xAAJwD0iG7oKtgh5HQD+bCLgE9IJBq4XB8vH+Hl6ZjCBlVek2g0iHElz8o7JbDSb9bzDF+yLuN2DtLoBt6/FrZvm0wMYiIlHF78T5BnFVLMpPztc/Pgj9naqvaj47U2wO3Gqh4DlKGUBrz4S95ZxMADn0W3BVkeUuJIm50eC/SKB4iUDyDz2lb3zjPaAU/zCgewlYEvD+PUsqHXOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbrIfNF6E+84k5sFEpuyK2PAorsQ79gB8Cl9SADoRD0=;
 b=JnIq0jwfIml9XJiOndju/Ifccug04ocMXFkpb7taD1QZSgENzMkavqLPwS+XNOHQc3Crpvg2vBjbZdRpFAOucUtP/nvrfzOHnV3oN4z5PWGzQdKWhEQF0nHcc85pmdupUM/qzT9ZjoPjuJWdy2wII35Xjv358PCc4+mBnOHA/ZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR0401MB2560.eurprd04.prod.outlook.com (2603:10a6:800:58::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 02:33:25 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1cff:564b:c3cf:46e6%5]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 02:33:25 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, michal.simek@xilinx.com,
        Shubhrajyoti.datta@xilinx.com, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2] EDAC/synopsys: Add edac driver support for i.MX platforms
Date:   Thu, 28 Apr 2022 10:32:09 +0800
Message-Id: <20220428023209.18087-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fd417f0-60eb-4932-bf7b-08da28bf7881
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2560:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB25609DFB2076C141278AF6FB92FD9@VI1PR0401MB2560.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCH/7QpueCL25FE8uyDpAtdaLD4H/ufdx/+2u/fbwrOt48EV9JzRcQ+BDSNq8s5behnmugdqcgezjfrRNMeqXi7gOqsYFaw45myjBble+m2GkIuNKCgM44LY1+D0vl8zPCnAgKcQ1TARVSJ5CX/hdr5lQPLAJAmwx/11Tlc0DYUDrezgBn6Z21ke2dBFkkrXqs51/EjfsVIKGbDQRHwTO0/qATr0C/vYenBdbDHYplTMQ29bz5T7LWxpkM9P1Clu4iFB99cvoW1I9dr7/Y09dvLotCyg+RjM4qoS0MJEKnSwZFMVe0YM/5fmeWx0R3+fNZ46sV0HE7Bk90tqG52dr2Uz5OZ5hWFxxYICmPrqvvDKhyKFNAzkBNo9pBNFNMM7omN4PQtdcI8xDgbJy6d0nl0sUi290AEZCaTqu5LksRzJZlX+WoGxFootEUTmsoNozN+1dJUdL1pvFcdudDzsExr3DswFV69SYefa7jta0vGwpu/xmjLry2nhdIT531XY/ev+0aNAZMz3Q9pcjlhVMIp73ZoCH5eLkWZGI6CHCSWxtnQr/g9QjV+0iazd/KSZ/S+3GyL8utPlDUwGtwVGJGhSqjRwWjK+Avbg/xm+RTk3U9RdzFX/cESjOctfo1a0m7apcYGLCfg2a7V6AdsMtJ8AQz84Te1Wt5KG0qR12QvN1ZhBwcvglXpE5suoz/ZxyU28+wVi7zX3L9OKv4swaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(1076003)(44832011)(316002)(4326008)(26005)(6512007)(2616005)(86362001)(6486002)(5660300002)(508600001)(38100700002)(38350700002)(8936002)(52116002)(6506007)(36756003)(6666004)(186003)(83380400001)(8676002)(66476007)(66946007)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d3bJZbco4pN1NqembIL8va8Zil+nadLKU3xusCOCm95OpwoPPYdmePS8FVzU?=
 =?us-ascii?Q?9RFuQZho4jAParkzJgYe1p70mREONYbKHlXtv5ubt8dsiZ/LSX/Jsu4DtSoZ?=
 =?us-ascii?Q?kewpx5P1p6QRnHQe9HXeQ29pHXdRaRS7rrACThkqZ8+gHzZ74wBWL4eWKNoh?=
 =?us-ascii?Q?5cbNopKVZtlberfQboiwnIdZfuWFVxTjQ9JHX7ObZtFLpsqsZAoDlo4mZAyC?=
 =?us-ascii?Q?OSS041UnCxHb7eVVFeRoUenjxDy79Ik5gnlQq+qn6M20+YTKuGlE2yzoYt/P?=
 =?us-ascii?Q?YNE20lP9ZfdLJ2i7vAkjlpb+CVnDpJouakOWnmMbrfgCEN3txQq8bamgVaYk?=
 =?us-ascii?Q?OiSeDvlIT5aigfIH6Mn7710wrZUdUiUNmRC2KEN/Tp20nAfp9Y1xBxQuLEhm?=
 =?us-ascii?Q?WoKgMTh0XNY/DP2+9NyDujaNDzeQqMrZoxYzNe+iyzZSrkejVHDmfjV9eQxL?=
 =?us-ascii?Q?AiszOfcUfLd+HdIzmzPL0dE1Q91LrSMbEVriCspaXRyBD8g2++oXkXvxADuf?=
 =?us-ascii?Q?+PAhLDanuTeL2OFcx2ig+6a5G/M/8prght0wBwMfw5EHQnHKl73OeaiiCMfy?=
 =?us-ascii?Q?hiciFZoCtFATZ8i0Mq+tGyRY5ra3KrwAQ2W7Tx9F61aPKjFbGuksvlfkPBTk?=
 =?us-ascii?Q?ZFeHLWIO5vNbPmfqpiDKjboIhaiRrKEzWUv5tiGnwnfTunHTIxuXJ5DmB7ZM?=
 =?us-ascii?Q?uD4xZYNT35VetFoxDZnAZnX36Eqnbko7omRCIQtDDnuyRaiZdyfa2yOnAYfk?=
 =?us-ascii?Q?fKXFzZczChx6hGpIEg4JBi8rX+HaKH58B8JtK/N9WlYJiHE+GUTX9WIF8Hv0?=
 =?us-ascii?Q?rAhV8qwZIEWvYcxoOjvX1VeYtKy/gOQC2hQKfT4YotbXfeNyiNG108A9eU6W?=
 =?us-ascii?Q?r2HSnfn2MN/Qsq06Q1EvG2QKfadTNu2Mq0Hjj+7OCF2pKvdyEGtuWKE6Aas5?=
 =?us-ascii?Q?opJhDidRTXGUKEaWSKg/e61W1wkgEANkN7AeumdSDeCdZWBo6Yi/0GVCWWlz?=
 =?us-ascii?Q?9T+dYqXMT6E0ctEPtggsDYvXtUxfVOAHpASt7UqQKn+/areBOJ5C73jws0wu?=
 =?us-ascii?Q?JVugWpv681I+x6BZ+rVluTvL/lEav1UUmuPzpWmZ7mJH6kNeogssOUoSaMIJ?=
 =?us-ascii?Q?NGNcUr65t7CYfIgG5HtNGPkom+UoXgFLtsJHIFuc9nINuRWnmjG9aTVDbtOw?=
 =?us-ascii?Q?Xfxp6/tGNDsaRD/KTUIIck0OM37uEr9XhzdYmeL6HXI2KPIfXyddwD6S2P9k?=
 =?us-ascii?Q?/3w1qAIv1QpDwPRNbVqf80Jlcb5x8ueOm9Nr3UHASP4h1DtzMF9dAY2sY+68?=
 =?us-ascii?Q?tHgi58c4GqLVQv37f1QAygDuYqXU53CYdnQdDGtrUgTqykAm1dp9RxQNhQYD?=
 =?us-ascii?Q?Y/lsByAq0kU8a3PB6XO3NcGcv2H0spM6F3LvivvtJ9f8eF0FfLaLrtz6H7eO?=
 =?us-ascii?Q?tNMx65a0uuCZU8z50S+rcOwHB+uiAjvjDQy/TOBcF5stJiaNfFwiIaSCueP9?=
 =?us-ascii?Q?yfCVAChMn5N4ePLqOXg4DhpOt0biHTIeaMZ+tTJrvdUsoVEeTdfDuWTN5+HL?=
 =?us-ascii?Q?bOEUF3/H//N+SP8hAMSqFAUAMVhGFeaXi48MHK/LyyoQj4mA4bD0vSxlQFFJ?=
 =?us-ascii?Q?xZTy7Xy3Rdk+A/dhDh6pi/6p5bhpp4aGAUU3aWcqX/3yTielr+pIIzxRXRMQ?=
 =?us-ascii?Q?eLg/V12gUsp1dQhkV3boZgF91CxrIEBWB0gF1XjM0gosZGBypeIARwJV/RYD?=
 =?us-ascii?Q?WAKgEHv1lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd417f0-60eb-4932-bf7b-08da28bf7881
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 02:33:25.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vryl7LyOI19QgzRBxgeuVjcu6d9XaHFxBVRY0jfIwshi9MIAur/j0RrXbSzKVMnLpquRWYN2BMo1gTtoMiDkgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2560
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

i.MX8MP use synopsys v3.70a ddr controller IP, so add edac support
for i.MX8MP based on the EDAC_SYNOPSYS driver.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. Improve the patch title and the commit message.
---
 drivers/edac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 23f11554f400..d3e2477948c8 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -485,7 +485,7 @@ config EDAC_ARMADA_XP
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || ARCH_MXC
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
-- 
2.17.1

