Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED90C746E68
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 12:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGDKSp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 06:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjGDKSg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 06:18:36 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDCF107;
        Tue,  4 Jul 2023 03:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuOzv4Krs+tl8DQdQO3IjHaA8JHS3+IfBL9RzhjRMDQMaIRcuR4SeVqPK3llDp/7qrb5r29ViHkePA4290QPBCFH0dlN0CsMP7h4VHDu1TTkiWkoe6p+B/2vK4US0QPgROcb/lr2ZXK93PyE85PKOVBzfJkDdFFZlVy6uWkioX6ELddaSI8chsGQBflWYgNmi1www+8jVip5c7X9zCRXX+vGEkZ52svlcLJLoaaII+8NFRi/XzkJOHnbgq6Zshxxcg0OptbvzuZ7GWx7GAtKldDvlGdWyezYcYe1FD+39rLe+E4siFpmAHoWHW07hXMnzFmPvyXgoFfRnH3Kihs9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeJYHVk7hRz1R3iD0xTjqT6YET613q1QKHzKZ94ByfA=;
 b=aO4zjAUCbP2IxkzS+H3zGao5EGkVXcREDcVQiVKhEbb3u1MLyA4iRDFBfngU2j83dhTUzYNRtsq1CZiSnEwkrsZeant+ZTIpfnk+mfRWhKMV3zq9AlIYXjSIYD6gbaN6KUZDK1/dT0nCw1oeIamQt9I39l0AmSYr3e9B5AZ0ESU5Ci6BGd56agBQx2vHKXyNOzQb5IiJJYldFoh7OgrlF0n6GV4Q05W7jrjH8MF8Fuy0YWpZnB2GQoCOqTx7Z2GTvLNrGfeC/Kj/ypvCGS+Ou67VLM3/wwkQKt8xeDQDxCewfnQt7sNfc1k4dIPZMvhVp54JPwtPB0B3DWJJCe5gUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeJYHVk7hRz1R3iD0xTjqT6YET613q1QKHzKZ94ByfA=;
 b=TwemSCbuokpgBIyHkPJpoGJiHWYNniHYezMvZqinCF70FWTsPrpGlX+chP6VhUfHvSD6fQdEEZ8YXe5SS5dHySNmny616g4O7frdibVUD0vpnaVA4fDHwhL27RuDgwgwHkCKDxt3VMC71yxYyVrvRRTWgc+n7v9IbEDSmthX+0Y/6lNBE4KxLCWJJiJM6OCxUYUfOuhn9KAOV3op/iRvO+8JP9NWWd12/c+dHX1RQUKh4XI+3TYHAreMbcO2O90LG0SnISd2Ud8Q7fh3B1YuCbtpyL/7KuUI2PuaruvQS4Ukz2mVwRRyMsSsNEigp/r3LDnDBuI3XMxhXXodDKb8dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6036.apcprd06.prod.outlook.com (2603:1096:101:da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:18:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:18:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Tero Kristo <kristo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] EDAC/ti: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 18:18:09 +0800
Message-Id: <20230704101811.49637-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704101811.49637-1-frank.li@vivo.com>
References: <20230704101811.49637-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4ea362-4453-4e55-461a-08db7c780370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ET8bU62SprTEt/0vrLJHG2Te32stvIN59YMs0vxHIVf1MNqpNGBMQ1kq3+zCYlwyNQpmrrfjfaCxNFGZKp4f1ascv0FRWMXzMFPVe9UQKgI1LFYSnMOgTHps4zG6fftr9y7ZwnXK+x+QAtOkUiApbQ/eeQ9U8+pgniEiTyLjlrqKTDoQTm+thotn5TuAY7KO6m5KIXf74y6ViWGuNvsJdPFZt/slMLaJ4neTyAgSE82OtqIhnLEzGKIWEUMepCW18fbJTnJDNBSQZybT0vtlD4/bcv347sA0O6UpFVhyct5le1ZpZPVD4x7PbxIOvtr638jkmnwc/Jy9Ss9RBmYcS8KYa36ZeJYNKsWcg1yn8DQ1KiXVaHHxkopJ4dJxIIUGZ8eFGtOBPTLuP3evP/YsDue8Vc+dVvx0HFYdk9VfzfMvkQT/licX3seJrhGT6lJQY4w8sJR+9N5z37atOnB0PsLsz5/IBNLkd5iOxjTj28BSFotay49BQXrrpD0bxBt7W8jIoEupX6FJDD0ntjXZNQlQc1Mzf5m1cGkNMMo7Dre7UUwnem9ZoQ1inZF24HJQvzS7Al1NDRguC9sYoDg0pVTJMzPxIui8r17PiAMH7cnI662/QZNY4MpUCD/vMVpN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(4326008)(316002)(66946007)(66556008)(86362001)(186003)(26005)(6512007)(66476007)(1076003)(6506007)(83380400001)(2616005)(4744005)(2906002)(6486002)(38100700002)(6666004)(52116002)(38350700002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X8qKkXwhoPmPKIrTYuZL/nxAvIe5MrWKr3zgB+4QeglibiBwN0HgVnQjR6Yh?=
 =?us-ascii?Q?MmiBogK4K6aKXt/L7kPg8YZGH6iwYPCV+i3OTN+xuBCsUVHkr9uj4XvoDakz?=
 =?us-ascii?Q?Ak9XrMxDvCkrVKVvQfPi0Id8avXU0+YJmE1y+Nr8sHOyYHDOnZJNwdORVvYB?=
 =?us-ascii?Q?8mHQrZPwVfyUfqtSWqwEEMAl+XbvlJ/JrUhd9OX3CiDe1tIq0NxxoiDKBP3E?=
 =?us-ascii?Q?MfzKoQMniwYKZrkpqq6VJ/jwwS28O2I9PFCKr5OksbYYO5ZaC2sZHC5rr9yX?=
 =?us-ascii?Q?SE20KTbx+Q8iGD1Nrd0WEbLhKZy+O03BMwsi1P6WoTm7TnFWtbJpy2gSwyio?=
 =?us-ascii?Q?F9UVfTdxHPLCDj13BM1bLiA3jZRkxq7ZfZWk0T2hYqnvJGAAZnWr3cxnFt87?=
 =?us-ascii?Q?W173iUOOtOPXzQOAUgvcYn07Vem3WQyN9tep/6VhLFYLBwIquHD9miAStNj2?=
 =?us-ascii?Q?vzdtMe9fb+Lx+Zw2yrlGgpR1MEQdybWrI8q/7CeyXM6MZkDZgipwe3gBKfuz?=
 =?us-ascii?Q?VAP15XBpW/o2NWjMiUwoWR27/GNuGLS3kpTOvKdWMR3LvoU6k5Y39Leqjf0J?=
 =?us-ascii?Q?L6goiC9zeXTVfqS1HSiNhiShkbVP5F8aoJEan4DwKNv0Sg+NVBpnP5EASokd?=
 =?us-ascii?Q?Zd4/2lhioq2yC/6pVA1Pygh7b3+eABOeShdx52OUiffZzHx3IoCS9Yp2mjqG?=
 =?us-ascii?Q?275h4WGd0L/Cm2+YHcGF6HrcTEuPWp9Y6uukPb91EAB00Jwkv05+2ytrE0dO?=
 =?us-ascii?Q?zYipNOhhG7czez/jqNSSRbyGFZo80Z7VvObjZXbCz1v83uTEveDUuFWHcE5B?=
 =?us-ascii?Q?EOUell1BEtl0Khoe+rYlZTJdrpb3AZnQqfG3hE3mhShXmV0aqSUmijdwDbaR?=
 =?us-ascii?Q?zNTQAqy0X+EYbRKCNWB9vzJgTQ3PPHuoqS3G6t2bXWZtftcf6L17D0+6Qqyh?=
 =?us-ascii?Q?al/hPfGJJOi8z3tmAXkPvQc9hzC5vQZdlXzLSh9/KlZ4xKfI1vPNUuHzxqE7?=
 =?us-ascii?Q?1UAxKwdf4bYzz7HDBKZRGvELqKypti8nqaQH4tiHoTmF/bf+HUhYblzqwS//?=
 =?us-ascii?Q?GlB9/KsFADuLyyOD5tahd0Ni/Oxf/EEMV+Vk1B7S7e62M9z7VT/DvyoNVR2w?=
 =?us-ascii?Q?TTVdsi9g3GsEra5JknYsKWXqjC9OVp/y5A20EWKDg1jRrAnW0uAXVB5wXysJ?=
 =?us-ascii?Q?fTGAaQKMQWcvBltY9S7IkqbktJjbxINrtoxbBF5uLs0hRkCHJDGFS3ZxpTme?=
 =?us-ascii?Q?ml0b366nU/8aU0nrsakf/zfwTNIkUBk3Za3YPc/4qXsPVlVsAt94z0wv0FJc?=
 =?us-ascii?Q?K4OwULlf4K31Yyv3wcVPMlXUqsUhCnoCYV2beKb5fJK5uIBRgI6jvGrhwO2J?=
 =?us-ascii?Q?d7odctssup+SGBstKo8gcdFpwDYDlBRHwD8Vqos5rknSL4dtkkq2IiN6VRF3?=
 =?us-ascii?Q?wI4lEfmyZi1fo3XFxuKFaDd4bJQUXxL5y4vI4vdsE3BBM6GGuFRcQnwttTsw?=
 =?us-ascii?Q?xER9t2zFhkq2Vy3OY1yMxpNVDcGrDY47TR2d4PjvFWSt5D3ORlw8AqK0TTpS?=
 =?us-ascii?Q?FwLu7QxUJ0+yNlOJGraqvOKVSeJPItwQTEhJ9pSm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4ea362-4453-4e55-461a-08db7c780370
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:18:30.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7I5dnE4LvUmWHWnKBoPAXxjESPXK+szC7pFI0IH28Bt3D+C06wc6CpVkd8RtZfvMzyTr7dH5FsTT0FrMA7LEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/edac/ti_edac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
index 6971ded598de..deec2d045e8c 100644
--- a/drivers/edac/ti_edac.c
+++ b/drivers/edac/ti_edac.c
@@ -231,7 +231,6 @@ static int ti_edac_probe(struct platform_device *pdev)
 {
 	int error_irq = 0, ret = -ENODEV;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	void __iomem *reg;
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[1];
@@ -243,8 +242,7 @@ static int ti_edac_probe(struct platform_device *pdev)
 	if (!id)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg = devm_ioremap_resource(dev, res);
+	reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-- 
2.39.0

