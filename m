Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE26746E65
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 12:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjGDKSb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 06:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjGDKSa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 06:18:30 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EFAF1;
        Tue,  4 Jul 2023 03:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmTPcxgwdWNfB0+miw1oA5/uKeaXh7UcCj1q3fLtlaQOsqzl1V5nj+UJKU6MEHRvoCVFixtb1v4d1k9gkBsi7sV1o6e9mmX646qyMojzsuQIsI1BGYMtK0n2xAvuxebyNH0UO6AAqABI29YNdOitRDWQYn0HpRQ7v6iYr6m9kKWWRA1mtmqwzsxRp8FkrVx+hEcNVYvkQnw6AwKiP7rPyIxpe5zkaG4Cf5JqBFBcwFSbGEngPUOwHx/OzV5yktbvKc+PdNLJkve6ZlTPPHzjyKQKN3BFKEYyD7tA1T8ZwTm/gVEiFzKgvs8SZZEoSiY1uZgUBf81usw1ggD+KHDzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ4IvJy94NBTYfpw+R/ZChKvscwppEmPZxxlpdBDryk=;
 b=XEBDuqUEl7Qe25xl6soZUs9RtV+e/f1vcMC6SnvpKTjTkNdTXCH5wcwWM7zmvS3+mQbwo8agVtPF6H1V/OiftDS8ouXH5hrNTFQfy9BcLdN8qpAD1JdIWITg1qfA6zlD/XayRxjhi6YO/RCiFie2iSv/54l8N46BcVfXXq4EEBp9JEsz6h2nyAMt1jo7osKsPseo7KTtDsFSdYvu0zpFJLObocf3KQB93o3nyoS9Egv279rdbHO+4Sgkg1kr8omevnvNMWZxfwBPNogqJG0lRrOsfYYyhySsKjZViq19Egv3eKgfaan8iO1Q+xA0ZZAWIoeJ3tlR9Dnl2ly1pP8LgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ4IvJy94NBTYfpw+R/ZChKvscwppEmPZxxlpdBDryk=;
 b=aDG143VxE3luXlzxkcEvu+EoqR9MwvyIRjQZbfOyeYNa+3bvzWJzox0bLMleIAVK/X9CRaSJGD7+sRrCM6rPbr7msjcKfZtmLM6lc3xy89sYjdD5GBU/mWGcwm16T4+nUkxkAS68YZ6P8gUhGbbJTNTbnpD70FdJ/SUdI6jPA584lkNskbJU4C4XCVUgzczeLtKBdeKaJGkmz+OiIuAx8i+V2tHKsrFoiGzJfl4XQrOciOhTEz0+pX7PRT5Cnn5welNbh6r3foQooLRY34d5HOhLkcTXXmUoUEm/EFn8TZPoq2dL2ay6W3hC+shouq18Z3+nspvU7ntAHuKZaVGgLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4274.apcprd06.prod.outlook.com (2603:1096:820:66::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:18:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:18:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Michal Simek <michal.simek@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] EDAC/synopsys: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 18:18:08 +0800
Message-Id: <20230704101811.49637-3-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 84029ac0-0a54-433b-f225-08db7c780205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GHOQ+2s9jdxxo/uGsZ8HfsJq6L1vHwnahBUsHgIlkbnGU77R5xTTDfLF8EwtKtEQ+1zphnkIT5+ny8DftUw0/dfThDB4fCjM1R6QqKbq/vq9dWCo/MwnMrVOV6HdZdDeHuQWYL5Rj9AL2KH9XQTJaDwr7Uh68aGIGzM/HOcttDTlWe4H6zGeo3IA1kzwnZ/cU/tHf8LaciG0heFCDD26WOMpI8iFBjfFeGm9HqEKgeH+eZeG0C/ktYgUvlkxpjFBCAjeHokJ+Fj9zglgZsb7lvZJLzJSdwMBDD+U9W1LbkRULK8rtYGwLpKgZzaNs+M+2H552fhnYiGci+BX8jP6+KXkM8earemoCKx1VlFfnBkWlUtUMnj+ZW1QSjz5GclqCLISY/hCjnwHmHahLCu6NjKUbll5ELCRISai3XhkTuaoRIgdzPdfiEoFKclmQ6orqmDEa/XPshaVwg8ra+5M602fQS3/U6ph2SyVfKwA0CeozCx25XNbmaCRFTt8d07wSZkvf/65gkuUZX3y6CWT+c/y0iNPVXq64rHRkfvj89spda0L+QzAw4YIaWk9d1Lxl2EXamSoJsfqXWKOMbPW5I9V4iQskQhiPxlI6skBtVByxbC5NMeAEUIKQzbo58+0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(38350700002)(478600001)(110136005)(6666004)(5660300002)(8676002)(36756003)(8936002)(86362001)(4744005)(2906002)(38100700002)(66476007)(4326008)(66946007)(66556008)(316002)(41300700001)(83380400001)(26005)(186003)(1076003)(6506007)(2616005)(6486002)(52116002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?prA6Yq1J2JoF7svBQOaILb0gAzSi8PKS94tFZG4x2RoVnJ+7fKFImFI8IkZO?=
 =?us-ascii?Q?a4DX2Xo4rFSdb3j8Jl8hvcw/mRDc08rhskrOg9rA8Kz1MrgmB9noHtFLiETU?=
 =?us-ascii?Q?p0fntQ3oe4CPjKXReRkrIISFdO83hN2hpl3UXTy1jXQY/Hi8j4lHs/9Knf8f?=
 =?us-ascii?Q?vImjNtX3mYBFyc8vGzo8NSSeW4/QSQcPXwj5XbUHlW0nNQ9zsb+u3uAMIgnW?=
 =?us-ascii?Q?MY/Tjau9evHMuT/o/6v9td7Q+M1PXfzUFHO8wZihPpYjmjc5/zdW1fRXQdCh?=
 =?us-ascii?Q?Qe8hGtuYJS3hTaItBVDjGIhe7vjRL1z7ajvHPstYCOQJCqMcs7HWEHS9Gt6A?=
 =?us-ascii?Q?jF226w7PLZA9iiZPnW/CL5dn2P8GOJ6zV7SvtfYl6GvrsO6XqTpo8ALP+mIc?=
 =?us-ascii?Q?ragxroGTIONMLKYI0sNLM1404lOe4Dd24Q7ukvjEGCAcvCeyJjXTBq6mnjJn?=
 =?us-ascii?Q?geIDUPKZZX5/uvsBU5YS3l4d++iAVKkNTL0fqoPEqfbYbPtN10WdefGHYEjl?=
 =?us-ascii?Q?wiTLPjrofltzuy7VPuSccp2ExqvgQpyQF1w5sQzwN4b43MpZawXU68luIlVZ?=
 =?us-ascii?Q?B5ZR8M6knF2KdUPPdRKC17NMMz9qNio8WJNuUxSQC+auvSy4TwpLzIWH9dM7?=
 =?us-ascii?Q?Wp+v++aqJyb03TGwXbRqXI6RMK0YHeK4NqcVIwQfekbBY+XMVgPuBhMGTSxN?=
 =?us-ascii?Q?zEH4ckiBOwiViu8RNMKmyBERRODnaXrhWP9aIfUmkf5DdlsDxnzrz6W9bQL2?=
 =?us-ascii?Q?4P84gM/GDRpVIOyp7NPpbvKNTQDGw71mI4/f57LKlYxO0zS3zOKDry6N4aRZ?=
 =?us-ascii?Q?bIgR1NTzPyumcxumn2/zbyc35x4QYENF8oWnH35IUh7GP0dZbugDrJDo+hgR?=
 =?us-ascii?Q?WXn5hZGBmuwLbu7X6EJq/HAUvIHsIQyAbmFcZCMPb4GVviRuC4e8LKx0JTXT?=
 =?us-ascii?Q?Ozf9NFLE208sDJvjPlNjl4dp4RsZksXM1RJo6YAq1O+jSQnIEA9nPHiM9L/l?=
 =?us-ascii?Q?nxxvUQbejh+lT61svXU6ydbi28/DvH7io6zohrCZ1/tB3O+kkDyz+QP5Qvuq?=
 =?us-ascii?Q?iD6VJ6FqHck7IyTCyl5IXrvKq/g23Xjyl5c79TSPmjUex8ZjgJ9D5qg1YfT7?=
 =?us-ascii?Q?FQ4uko2QalvWtjOvNzT3ayBce2QmRe44zLmuWYJLVBMwTuLKUsy1JPnYo6Nf?=
 =?us-ascii?Q?aqy0nD5KxwB2ShOmbPnIS5iDrKqNF4QgiIc69wzQxJNWzs3RiMgJCT50XMV8?=
 =?us-ascii?Q?mvc4MFuo/sIck1SZPG2BTMXffwOzQr235TjBNx9QmIdRbTQXxABD10dfyfPa?=
 =?us-ascii?Q?H3kbkYra8HgvFV/YjE+vG5i9C/uVfFqYksljNcHQDvslrpFIg94mhXLtytEj?=
 =?us-ascii?Q?DucF3VddnJmwOoTvyBKC5c7egfZXqVOxxA2nbu4fBDO8o/ct50j1vP+UbleC?=
 =?us-ascii?Q?J/9f7o+BNVJWNenhlA+2A3oSAAcQnnzVydQT5ATWCtptX8BFUs9KCmlUELUS?=
 =?us-ascii?Q?zVmNRAcxbHybU/sHLQS+S5fev/m8Z6kI/rID5t378EstT27G6AmyiEtTvMan?=
 =?us-ascii?Q?k+cx3z92x6K/bEIuPR2jmo1plw/pWg/h2WnA8OO5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84029ac0-0a54-433b-f225-08db7c780205
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:18:27.7405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cS46lUszStWPuSMlZLTaxaNcbDsXmqaNY76qHJzxe5kCt5GuHbtl0LR+I/inq8/j0qjp7lxzTtmyssLsjdBKxw==
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
 drivers/edac/synopsys_edac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index f7d37c282819..620861fb5231 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1325,11 +1325,9 @@ static int mc_probe(struct platform_device *pdev)
 	struct synps_edac_priv *priv;
 	struct mem_ctl_info *mci;
 	void __iomem *baseaddr;
-	struct resource *res;
 	int rc;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	baseaddr = devm_ioremap_resource(&pdev->dev, res);
+	baseaddr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-- 
2.39.0

