Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C0D4DD8E1
	for <lists+linux-edac@lfdr.de>; Fri, 18 Mar 2022 12:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiCRL0b (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Mar 2022 07:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiCRL0a (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 18 Mar 2022 07:26:30 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130073.outbound.protection.outlook.com [40.107.13.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153E91770AC;
        Fri, 18 Mar 2022 04:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Agaz2pNiOoD9DJYIimfubhL7s1SfkoHIfSunq1TItNEeMB/vpuoRrQYNYQ+Pb/1Ju7JrfRXo+RaQnqcBj41HkOddogocoDaM812cg+MiaBRi0BFVe7Tg1VIvot1MNrnfpMknM2zNtewsq7Umo+8rHsZqM9sr9o1xstLNQgbygw030Mr3uTpAKkuKeuXsZ8qOx0ZIxpMMVR0ycVnGFMIGbQMKMx52Sc43z8YLrb5ITQG/m1DQP8TAGSJtgiyxgcq56wxSBgWiuTkuIr/zMEFpQ+EHM4yu+W6RqMHv6cxm1RL3Qjn1JhzSZusYT3fBK81ow2IG1We5sTvT7i3me9PH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn2V3Fje7aMsl38BfI2eBjVIJPCD4nrQXuWbHBZII0k=;
 b=UPhLJhZYd0vOZZ5gHV3Wweed6S3e5Y7v9qaEfcL2fWz7zZnKuO3EeEr+vw3QyaAaXN9XH7BopL1EAA6grga5lC8cu+JWu8e6hJfddfnMtMaBGwz9uetZ4/ke+jb0gUl2hM8n+NHh0wsHg54gDOABJTJHDoD3lymZ1jVUhCS4K5fn9vnPKUlYsW3LxG6rClPTLt4DtcwUgfbpe0dCOwb/NcCHz/WGQdK+wXHihTxEMginWD3K0DWmGPC4465yy/yLFF7l1dYmXaMVdo2H9wp90GpPd0sx5+6jdcQGDxsl5NjrsWWYiH0UDxgEPxoAqdz89iJlcrtD7ARniZjOVxCdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn2V3Fje7aMsl38BfI2eBjVIJPCD4nrQXuWbHBZII0k=;
 b=KgggvIVuOlyMMTjQ3jWEUklo3VuYuAuR89SNLzTYxy/CCZQHVtyjrjPY5O5jAoRjGIDX8kwkc7Pzl703Dlp0zAbJfJ9LtF1MN+6UsS4LP8F0+pNoyMzVkmhXWMAu2DQQ67e0VqZpoDppbbTnVhkSiiOaGN0uL22TrO3VJlUmLZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM0PR04MB6675.eurprd04.prod.outlook.com (2603:10a6:208:16e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 11:25:09 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 11:25:09 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] EDAC: synopsys: Add edac driver support for i.MX platforms
Date:   Fri, 18 Mar 2022 19:22:31 +0800
Message-Id: <20220318112231.15828-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0180.apcprd06.prod.outlook.com
 (2603:1096:1:1e::34) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45d788e6-7633-4215-7159-08da08d1f5ca
X-MS-TrafficTypeDiagnostic: AM0PR04MB6675:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB66759883BC8070E9055B76D592139@AM0PR04MB6675.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dh1ZJXsNAyRk1reoPst5dSc1J2a+AGwTFR4OkiogwvAybeZ31/lfZTJcO0eFg3ZwMAgd3qzsIa2KJ3ZYw8I7WcQ0ozq9UnFkaqUAH62tOsWC2aawy9Xr1m9TCBn9uXR9GSeAeQ0iajgadiyubB7il4rXwzu/zXqYRzrAoVQbbChtJaBQ4MFvR+MSwFvSe+54VySvUNouoLzLiTxlCR8LIN9olG4U+SaETgIoglbwKlYi3aDRFay6seeYxmbnD6hI+FS6w5RmT4rXbL7yF8Ux0R/PeIx2cz9kT1EomG28RVbGhaoOBgoFDtK0WxI8ykwSGdgpC6l0V9iWcf1pdiIeCiKETBY70AY0sOUQLRFokRhskg3rcCRdGCSaKL/R4WrbmhjhRUKaJ2IGRsrdkdE1i6RjgbgS+ufmJDzZOxpgp9eRWNgMqRI9VLCw5SZOObqHPsDWg4igYHTrGuyQ+xpKIERWjMDvHC9z3jMuC1NMhzoPSD6hJ8GdEAY7r89adk3TGUJZQUr7eQCTlJWPljYw+/dTLSQuhVE1UDO2haYKizWysUaUhuxDXrDcS0hvV1XNtBMxvOgHLWnFNEbA6V8cR5nw2WJgX9IwB4N5bj4DBEA1PXAmM51qViNfJm1T/wQplccULGUw81ZRDZ1WyDqgbHWxnuPNLcNirWScJOS+eEF9S0/hTSlMUkfOTIsVtpm8axpyUqnqxv3WwRhJg2ZHtjD1QhIAZYpuB2yDzQA5ZSR0qRtB/4Ce4bJOc3BEgD3v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(86362001)(508600001)(5660300002)(8936002)(52116002)(6506007)(44832011)(4744005)(6666004)(6512007)(316002)(8676002)(6486002)(4326008)(66476007)(66556008)(66946007)(83380400001)(26005)(186003)(1076003)(36756003)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A1xF+GD0g7Ujg/lUGZ0nY2xiFurA74y9b++GQogofKJswMSA4RxXvDP+vmCS?=
 =?us-ascii?Q?3znmuR/fP34iW/WphH5SqhAZ/wmv8QJUgAsTQdDdqZYfYIlxrXXHWQiRlFXD?=
 =?us-ascii?Q?RuMHHZY8ZAoSI3RXAbs4OOpw/19IjJPIXsvXBWy0PAGYhYvr+pMmdNVti6D1?=
 =?us-ascii?Q?i3rHm4wip8prQTwJqJ7IWrPG6RIfbMT5G1M3vpMiCBirIybI4CFIC5u9sXZ0?=
 =?us-ascii?Q?WBkKNvDXUaXVDFd2DKck250j1vPuqTHTUdrVzVXgLoCgrQ0h6ekDMRBTxdv7?=
 =?us-ascii?Q?J6pKDNldN+j23V44WRq+nFAnSMZdZnKYD/47QZ/QvvCQcTLGaLKxXGxIYQVD?=
 =?us-ascii?Q?lewEJ0uEhtdewgpUi8vhkVXBz3z63QS6Z4rq9QSxbpnTVuLgCb4nW+EF5r5b?=
 =?us-ascii?Q?a1mpCUawwmvGLmPUlkSjhfP8To6RrKeBHFA/+TCrkXQKKPGWjr+dwLZUVhHr?=
 =?us-ascii?Q?moEvqckwmStGezOTrONy5NBde6D77JipE56TShYtRopJg/+r8yMHQrrvBEE0?=
 =?us-ascii?Q?IRyyyOrd7i4O9lTRu+UHDlu/BqERXiWLmvfB90tZTBqTIahOVCoROKvaScyt?=
 =?us-ascii?Q?ViOs82avId3JuEc0sKmTyT9LRDQPOULuKipWNMKyF5wpU8wironJYzE9ZCxa?=
 =?us-ascii?Q?oWnE3LlccSkkHTzxsS8GJ+zUd4DKzLYgUJ+59eMJdZOarZx2rWbtBSLb6ytH?=
 =?us-ascii?Q?UAQd+A4pK5rav4Q5CO53yrE8McyNY8uSv52PmZseXPQFnVPC3HIT7RbjCykB?=
 =?us-ascii?Q?Wqro/S9WpLu/G9oLnYEpPdXxmPwjksQDKFDIOczmRrzDoOvCusgVdZ+TwUVQ?=
 =?us-ascii?Q?D+MJzos102js4BLTpZcER3A15ekYkf5/vBMjbULudB1QkxQ8KWE2aN55L5+N?=
 =?us-ascii?Q?mRu2LdXNfpUMIqV18F+VYVNJDzh9VXkXHch2B2tkxJn2lTCFaT2KQuko+eSp?=
 =?us-ascii?Q?VX3pTe+HlgXGY8Jh+17srmluoNb+J81NDFqfuwgHZUsQogbmE6I5LdyxNRmq?=
 =?us-ascii?Q?a7C6A+nYX0mTG/Cn0KL5zCZs4y9cC47IRYEzQeAv+x+83airUf/3uhYGdjyX?=
 =?us-ascii?Q?9IrvWvIjOod/tJy2tnvFMfSN1tiehBd/FCuUReLsuSazy1We1kZwgdDs1fh6?=
 =?us-ascii?Q?5NJK8HoMapEIneQCSo4RbqUi7E9kxVtGZZgIcHz+WhC8SB8R4/uiGzAoh1C6?=
 =?us-ascii?Q?PI99J3e1hycDE2vPjDfFXCbPJt9SKxpHwvunvH42XZHBQEgS3rjfyA6xlGmb?=
 =?us-ascii?Q?+0ecT5f/0aemrwGAjs1jB9SYlGyTFPL3g8QXFTwzZPDsQsOxxCUWc3G0aS1L?=
 =?us-ascii?Q?RCAGqqAyd3sTocFdXW6Db91S/vb/jsdXU4Q+EujuEgbPDuCS+sfl2abGuyCT?=
 =?us-ascii?Q?qr5A47GrXSuTsLjcBPSwWbed0roPo7cNk9OvlGfAoOeb20oJJQypgDWU5Sd1?=
 =?us-ascii?Q?BdpftyWk1lApo6ZcmWu/akGaza1z/Tpb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d788e6-7633-4215-7159-08da08d1f5ca
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 11:25:09.4655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8b9g8dZYAP7KL4JK0HfetKME2FCkka20r3iKDvtN6yowcoxRheWCNVSRPdETDPTJQE+fJSJno/L5MTDHlJiMVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6675
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

i.MX8MP use synopsys V3.70a ddr controller IP, so add edac support
for i.MX8MP based on "snps,ddrc-3.80a" synopsys edac driver.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/edac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 58ab63642e72..9dd75c9bbb3f 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -484,7 +484,7 @@ config EDAC_ARMADA_XP
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || ARCH_MXC
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
-- 
2.17.1

