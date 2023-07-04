Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604E6746E62
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 12:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjGDKS3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 06:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGDKS2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 06:18:28 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51152F1;
        Tue,  4 Jul 2023 03:18:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU3gg7aduJVFW0NbiOyM1e+hQJBgSTeXrK6wgzTeGyv8jiPH6nwtolLdvjewvNfFiyyMJLXDRERI9P0+cDMQViEoPtd8hqVDUFWAQmIAfkrpNrO6GT81WulH0gOlBPs2u/jJu2eD8JpxFFtNFTsMllUTPGq6iNwkotwjq5L6gai1iAaoa+ihHx8uWeQ4LCQEHJJtaybewHyRjrUEDueWmqSL6pL0Ux/ws2YICIddKiAnglv3BUwfcvZgoxWsEnNBShpWB5Mk3tbEW7QeVBeLgt/hRAedwJSXSy4tgIrs1no1Yab/unhdmReBkweiYdJRsO2v54y5SNc3XVVjEJ9D0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/yWADFobI12CsfdzcsiL04jWUOVA8kkFX4k+CGNq+I=;
 b=Cq+zJe6iZAL4AM/SNTGy0Tcg6lShxC6+ea5m0ZYMdcKu470Dk/oUMsHe6BjLXB3xHCL9eT43rddnj7mhOM2zUuFkB+42QO2SIw13DAtQ9i9+99uVkq4dY0YvgRP8HGbdLSLfZYJmyy4PArL8qgi5VPQ3MYuSL8dzAXqZhH6f5CQVUQwMm4duTrxL7ZgtlJ14qBRNtyi78txepsnh4Bh5PGb8dWlw7lCYlcJ/vHOqohZDnmZKSvc1L+aWj+eZVgDAm7LozlC2e9nUWXlMavdFApRBPAtaTjJ4gcwWuoSa2pfA42m8RI9FgjxbFhnbQ31SCDKHLMHCzheXRqXgFxcV3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/yWADFobI12CsfdzcsiL04jWUOVA8kkFX4k+CGNq+I=;
 b=HU40vSYx7xHAChSDQ5Eo3LuU+i2VgMn+QlZvE+BRVvau64+dylq/o90ZD5k83+S4FdhK10ZB0Qx5heahzNM3k2jA/Is2y1J379Qzn9dloTg4fk41BQ+rHAs2y7xCrRWbNESOGyfnmjgMVabJDdjjPDFocwaD3XHAp5pEUu5CeEx7BRoUevNjNmqVbw4psMlinniEX6+ktdHwvZHDYoFTzabJGfRWlyh0fSQtTr6FMNb/ghYroiEetHv30UPHZatx7jWKIvDqO3aLXQUCcd0/qB5bQCs11fCy9+ia7LYzn/1frQsEm5xXW47o5/0+Q+DdeuoxfwyBnyG2M7yTkZhRhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4274.apcprd06.prod.outlook.com (2603:1096:820:66::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:18:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:18:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] EDAC, mellanox: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 18:18:06 +0800
Message-Id: <20230704101811.49637-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 858ffc0b-1fd4-4cd7-be6c-08db7c77ff46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4LIZUKdXZtC1GkWyc+mQuc3Kb41NiZcxREF4ZOwPiX7Lwie2/fJOPpmrtckYeFD+vZ6EdR+HgJDk7OmZHirnT82ojlbk0Hdq/X4sWBaLdTq2scaQvHva4ZttOxw06Fc/x4QMcuyT45CJ5WYTOB4q6BY1tFNyNEqWH+rCbBsy7bx8KuHLmithb4L1JbxNlPc/+1QO/JX76ZRoIo8PAkdGtkke0nRtjbNy1aMVaXrFcSyjOfj9aP2XCGmQqQzYmpimiblV6g0WDqI3vuR0RHl1p4MuPrUsYzEiexNcotpkKO5Lv4OXVGtjf5FCmxykDW6jyO09YXB/aBBNTSEQjura8uUeELgFOkMpE2Nayo7MLcS1oo5TMYwH8C9wUAGdKzuX6UaroyCc0LzVRMtAida1/PhTGsibrpRsh8hhkToIDbHepNP9SYb4uOaclmVHPDna4jwaNvl3KIAuIOfhvm0TPnXiRUpO9h9MHlSIFRJ8mbisQDZjEuC6Pt3JdRGU05jo0O0mi1ffigo8cqpxCDTnSxqnUsafZ/ChMHgEdsUNPxdkx+UZ6TcRhXXcof2k0WfaFUR+rp0hThWKfRbZM78i/h3qIOSxnDfasdzIO8B4I3Tg2rNZeKOnWQnZ2lihbeC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(38350700002)(478600001)(110136005)(6666004)(5660300002)(8676002)(36756003)(8936002)(86362001)(2906002)(38100700002)(66476007)(4326008)(66946007)(66556008)(316002)(41300700001)(83380400001)(26005)(186003)(1076003)(6506007)(2616005)(6486002)(52116002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AkI4OZ7gAALany3mhFXJaGrzG5hYU9ieHfSuVKgvxTcE3URMnib8uNskPWaT?=
 =?us-ascii?Q?h/hkXQPy5ZkaeXJehDsoCuwezCNkrPx7g2j8lHWMoVlDosmpFDQvk1cKgebi?=
 =?us-ascii?Q?qmcTvpynHGCwPB+9qSY8FVf8QLT81KD51+7roM27qXNmUcJa6X/dYJXu7TYI?=
 =?us-ascii?Q?ETCOogXX9XMVlq5eYD37Y8JI5roHhGL8DKVBq4vdDmWvHIC1w9y9ln2s9PC/?=
 =?us-ascii?Q?FalClqQM5a0Ja9leOGPjFzW4s470jLo4HO3aamLg/RPTOCOYboZ25Rc8QclJ?=
 =?us-ascii?Q?UIqxFr2iNyqGQEOSfE8s+Lis2oojr4WzbBk8QvqD+CGOMfl3Ax26jO0RNS42?=
 =?us-ascii?Q?HMvY1dT+L81MTKG1qlZUDQLKXgpBos0S81jK+1gXEzgiaMNT2mCWYHVAfavb?=
 =?us-ascii?Q?TTL48cuD7gKoIstQjZeYGWIcKuVJHKt8WkiDpSl5rmgamOND1bBX/OgM0KaU?=
 =?us-ascii?Q?/LAJek7mDFr7ZK6CpqtplgAL2vwYzer05tKOWzl9f3ChMmYVsdqEsqrLCvF4?=
 =?us-ascii?Q?jeY6WRlakP3LUjQ9V9wIMmVokLBgvp41xxkT45ztQH9kibaNC975mFVH3pPd?=
 =?us-ascii?Q?GfujLf28vJIXT6YemmW+41LP+Kw0wRFiBLEy9dm9U+x84RbzZERXyFhVhvy/?=
 =?us-ascii?Q?eFvdWK73ckehFdIcgrT0mtTyP+gdVIcxOUUOIbhR1pUdXNWOcRcc84fXk/9I?=
 =?us-ascii?Q?1q0Knr/K18zwS611RP6GVo/9FxlYTlkeS9dtWI5MynS8lqBo+rNJqaN4znOG?=
 =?us-ascii?Q?FIP59l5Ke0kC0bej57sLQOtjQDug2FnwAkkq1S2sI706Z/JpXA3Oa9+g9qGB?=
 =?us-ascii?Q?FcPOCLIScr8wT29Q0hJNF7dhmEEYmUEdOKcnLV52yRe1MtQoR1g7jePd1Z8g?=
 =?us-ascii?Q?F/TtQcXZd2TpVMuxnHTTOq2b7uMO/XDSZ7xMiomZU0S79b50K6PfTA96GVdX?=
 =?us-ascii?Q?MUoCOi8cveT+Ui1xZWUTqN54UAXNTJa2N3MGKdDsQtybNkKJcGVZIvfeD/L+?=
 =?us-ascii?Q?X4hMTFyftihYVp/Rz5smHGv/+IH3HEMbzj7jEJ6KfhQX/PBVjMe2/etfeqPv?=
 =?us-ascii?Q?n7slSyhHr1KWw4nputi0TOXrMQwHRdIPhqHv1NLCjal78OXqn5CQwmiRC4ad?=
 =?us-ascii?Q?A2zUlvAgRhacfsKoDOAvwacMBMjOzRcNYR3QYC8dXUUGurLKPtev/QL23IAk?=
 =?us-ascii?Q?bNnAn4OesA3BoAcV15hERDT7xybPdnkB9ahxTIrN/O8hxlZLxP+UAXV1KRoC?=
 =?us-ascii?Q?tmRfYH66+Bgb6Z0wqWHeMsqXpj8lD8F803ffY1gyT4CD17l+MKIJAhAY3AbI?=
 =?us-ascii?Q?wX1MxgNmV90k5nd7pJjwBmmskqYi+9kRopo1TG7NhKeG6CGyu4wLNpXlkSWT?=
 =?us-ascii?Q?WZz+YsKdvG11QLfN5wzxNfx6vyZcSR2zJr179UknxNi95D22yIjZudXCTwRA?=
 =?us-ascii?Q?vyCihHkybJFA04+6AO+uNcI7GQcoLqshC7QO4xym+xMUXgELcLAIO6KpCaB4?=
 =?us-ascii?Q?eFxfdnEnbrg+FSeJ0fTVDOe1KeorOpXM/OQOITqCHOZOZdY2xK/OaaN4k7RK?=
 =?us-ascii?Q?sWfvGzUWPeY7I057oMNeS45jPFVsFjM+Y1zXa2xl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858ffc0b-1fd4-4cd7-be6c-08db7c77ff46
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:18:23.0259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTKFGTDBMfKDTgyZZ0MjnNauh6LhVdi3LxMnnN+cWTTZ92WUdSq9ZpLfbZMTqyvJ/S08BwgRBvZdfAbB6hcNNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4274
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/edac/bluefield_edac.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index e4736eb37bfb..0d09add30460 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -245,7 +245,6 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct edac_mc_layer layers[1];
 	struct mem_ctl_info *mci;
-	struct resource *emi_res;
 	unsigned int mc_idx, dimm_count;
 	int rc, ret;
 
@@ -266,10 +265,6 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	emi_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!emi_res)
-		return -EINVAL;
-
 	layers[0].type = EDAC_MC_LAYER_SLOT;
 	layers[0].size = dimm_count;
 	layers[0].is_virt_csrow = true;
@@ -281,7 +276,7 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	priv = mci->pvt_info;
 
 	priv->dimm_per_mc = dimm_count;
-	priv->emi_base = devm_ioremap_resource(dev, emi_res);
+	priv->emi_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->emi_base)) {
 		dev_err(dev, "failed to map EMI IO resource\n");
 		ret = PTR_ERR(priv->emi_base);
-- 
2.39.0

