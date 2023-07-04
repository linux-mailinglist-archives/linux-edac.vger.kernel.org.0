Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C9F746E63
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 12:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjGDKSa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 06:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjGDKS3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 06:18:29 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAE6101;
        Tue,  4 Jul 2023 03:18:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7yWMSe2kitItBlr9Y8Qs9clv/vLoUUD8UjRTgep/eGOyZbp/0S/SgEByGTd1AxOk6SHmqz8TuONqv29cFCWVnmsL1gbgV1I3AtiiAYa9YPGF2my6NDqihZpg/Bsh89w1lvPY5UZ6NZTCLdchnQK5SgNF2gYs4OFn3sd68IlpYAzrVKc+tjjcBjfQ68F4jJJ3j92A9nsWLGhZMltH6sVelp8HAdFGW40BmPSV94NfGQi/SLVYFbytNDcuFUwzN/Wufk2HNRJ/7RmkBVYboPaXbhR1fOQbg2QzHw1ulP4gd8O3VXVAYv62zHF5q19KbxK3Hq2S+dOWddXSx5MGn0BQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NL5pIPf+/mXW4lCMlTg7APBdCAO+2j68pQWX+FYKsw0=;
 b=gx6Vqe4g1F0FbKIgmVDsCsp6tR+oMgVymWf8BcdEKJskca13zm5TO8gznbqEOEfdNGVsv09k0ZxVXNjViJijn0u8jRse/tGG7lQCh8F7pb1XBDz7mAjrN/dtP3RUAmEZNcjpB93k9ByuZfc4WAhjW505kOCCDX7rfMJE+HMbwuDiTI7B9rO2Fxmt+eF0QQ8wfe7m/et8/qQI3zDUIVaNURuTkTttVWgPPWNLiNKZGChj4JuSQ0KNRwl0elA9alL3YYVAKTPap03ZG3NF0KlhOY9j5GUr85J0AmItZ1aybb9Tbw+HrcregzRvTW+uJNxMk264mHbfWeQO8HVCQ0skEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NL5pIPf+/mXW4lCMlTg7APBdCAO+2j68pQWX+FYKsw0=;
 b=pLBQKzzTKNhC0GSeBGlw84pJ8ZiNhJX+yHxNDguv09kAu2QkbkE54+ZogzSaUuRVFV2H7YujMFGDE9E98j8YyhBene6CCBZammZid/9NcMA/4r7zMLS/pPearthrCoPOG+7Ce2ZaONzj0LO9k9zVf4dn+1v7qkfVLdQxpEOS4S27X5HUU4f9M38lXU5xac7Y8n7hm0UekIl++oOk84l1FWv/31fLPVkgErJH4BEeNxJR//mM5y+stcDEMqCTn18fgqTz7hSWOltXCAvuUnSvIjJCbiV71DXF1mv60CnB7I92FVe1aFOm84kHXGydOHZCnR5weVsY3hqIH503vWKydw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4274.apcprd06.prod.outlook.com (2603:1096:820:66::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:18:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:18:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Lei Wang <lewan@microsoft.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] EDAC/dmc520: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 18:18:07 +0800
Message-Id: <20230704101811.49637-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c714cf07-4117-4f45-9e2d-08db7c78009b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sc4WTj7tfUPAqt0WowLqpMqwFr23aX3+jOG0qkZZnS/HccrXqFhdv1fTYeh2v2YS8R16Go3pUPSInmDi0wHdXZGd2NpCVOyWJDs1ppqOBEf8Carza53h++nyAHuWu1fzGZCvQSxP+t0KUwgoEGhOGZl/2utulA2SacFFez7saRZw2/VKffqcJxEv4MuvUcq3Ss+NkYqguwNFggMXv5iVPMatn50x1qi0RrQuDPQa3jNv/YrLGOPZrmrTtBTIF6orbwpzlH+5FpqZ4zSuJiGjzyYlWsl83nfKS4xFmozGnnuSpVFL/3FBXnmPpOIMdoaQ07WM8xj3VRmixUXzQRO5++Il8/XX57GxtiDZE+eQWhhVRKTt39KOvjWezWGuVE+RDR++76b7ls2htcN9KhTI0GRmeBrp8NP0qOKIybVn/XNT+7qg5AkoNCqQh9lOJ8m5gtCgfswy5G7dYMD5yWdGd9UpeLtSY3t+IMd/9DpnuxirpKMXQb2AthOkqRvn8lnSvzdWwJkC9nwQieCeGzqgXSkFgaw19Ky4n9zYmdeHDlBFIVzfHanBoMeJkP8Jr2MFTX1gkSP07bmivEyHd6dN9bhrSzmD84A6eP1Tz72oJhXB34j9TBT1TKNRKGYMT42+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(38350700002)(478600001)(110136005)(6666004)(5660300002)(8676002)(36756003)(8936002)(86362001)(4744005)(2906002)(38100700002)(66476007)(4326008)(66946007)(66556008)(316002)(41300700001)(83380400001)(26005)(186003)(1076003)(6506007)(2616005)(6486002)(52116002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fee4U+5gPh2hrhvuEcywoJKQsbShRH/MfOqgaO95TmPm9+St/Nn3RkIPnHjO?=
 =?us-ascii?Q?/RdjT7njOErTaPkTSVWAz4GHWLlYwsL7SJ3pmWmBkulncbo1DPyqjmaQA7U/?=
 =?us-ascii?Q?CvaPPj1akPAi6kAqfp9RKpZjeRtKAVDPXxlDkhFVz3M3+puN5OfyQEvB4mLF?=
 =?us-ascii?Q?Gts9fuM+gu5rXP3p8znW2FygUUxz0O0WZ90HB2g84kzgFVkWEVoQI1odbTko?=
 =?us-ascii?Q?KNNQlLp72bWZ1NdtAPqDs/WvL9SXocadaj+Rxvv44vrCIq21sipgX+ewY/4R?=
 =?us-ascii?Q?Tqg0mri8PYi6oNY+bX3RvK+1v2XpmWNsmalLikArtrK6hMlo9oEPd+2wTe1A?=
 =?us-ascii?Q?1nBIelsV6WjuDX0DZPLMi8WCaDCi0+u2R8DwiGBeMqVTNQNgMs6zZFX+6X5r?=
 =?us-ascii?Q?X34n7cKjsPZgE8GfxCCdipDSvFa79EwZbFUgbPaYmo0Tu179vv1X1JNJuqtE?=
 =?us-ascii?Q?Us37Kk5mUU9T2UXQlDc3rRG4AD7jS897/dxe3vzR1wgXzUDop6kYFDatKHYt?=
 =?us-ascii?Q?Upc8j4jzQT4WRf56Jph0VA+emu6RDmmMlGE5O1EQ82vcktn0+PwXQ9MmLFn7?=
 =?us-ascii?Q?vO9VpumrGRvDLQb+aWFM837rp22S4tXz5mbqGeBnc1eoqIYeYEIblNk1bESX?=
 =?us-ascii?Q?uTwPz+mk6okKwKmjUNtRlZf8OZv7tOAjGGoeTG0+iQet3K7X+bgBzICREro0?=
 =?us-ascii?Q?/a6UOwTSUQxyRyBOsd4me6XiSHaU8mynzQD7dvLc3sRjeuplhYEHQusMW9ld?=
 =?us-ascii?Q?1ceq/suOfu3QuFDU/YpWL1qix+qxji/4WYubmH84yeo/UdLwbnb6//qtnvjJ?=
 =?us-ascii?Q?bPgCb4nt3FjYemaGf/hBI8OpFApQK6D3U+vN0uH+SWvaho0BmkOM7ZiFhna+?=
 =?us-ascii?Q?VP6C6AxNnXda0bS8JM4RwWWYsC9Yx62gKSOoPxNCkC8lOMqJUV5GNYUn/Nt1?=
 =?us-ascii?Q?5AKvJ55nk3nv/qKdaNFdZLAeGSQlWSZ4+WO8d9txhCCqI/NZ9WmIURG7OHZS?=
 =?us-ascii?Q?yuzH1p4faeZ6c4UNW3XRQXGtqElO6aw+3OyBC/cuDw5+wf10OnYTvVRmIwNR?=
 =?us-ascii?Q?JEzwc4knxoXbgKkfEhmmLr9sDzRWAQMDNttvOs8L1EwmXopr16oBw0j1oWVn?=
 =?us-ascii?Q?PmtH5G6Re5iuUUxTCcRMcvNtJdVla72p985BGg8lhO/RferDGIZpfn5jPBYh?=
 =?us-ascii?Q?6G069rhBtJmJpNog28GrVQ3Nx8dfYwkWjFxKLpee1hMHCDCf0Yoh9nudit2w?=
 =?us-ascii?Q?jRrdHo+WOW2RW4VQ7SlS07BhJIQCq7e0Tjh8Ryc3Z9raEFZOA/k0GX4VrGfp?=
 =?us-ascii?Q?PeW6z5jQbcGbNSlL4Ns2dII3Jl92gSw9lwZEV/cQPXtmW2psMT1rjdU+R4Gl?=
 =?us-ascii?Q?FBw3eSm5x3OyNMnLIsucoAlbT0wuuGy3BSBZXzHnqxJHgRoTwX3zL/eI92Xr?=
 =?us-ascii?Q?vtz56vzcFdeACYBEALBQZ16f729NZVZrjHsY+pD4vO/D2wtGgo1bzDm0ZAZs?=
 =?us-ascii?Q?Ko8TsgZwlvuPPcnn+iYIuV5lkKwgLS6qbF0gStaEx/VxemBLvN7Jhu+zEShm?=
 =?us-ascii?Q?mTTbEAk9NbpP8Vi6hljN8b9+PhXIg80I9ivBandM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c714cf07-4117-4f45-9e2d-08db7c78009b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:18:25.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFVf2hQJZ2EpQDbUNe19bVovSCGihnoEwOBS/Y6oCQPEuMtbAGx7g8hF0r1CExAOmg/3BRVQrtzOEm+CiublHQ==
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
 drivers/edac/dmc520_edac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
index 1fa5ca57e9ec..9a3ebf214387 100644
--- a/drivers/edac/dmc520_edac.c
+++ b/drivers/edac/dmc520_edac.c
@@ -480,7 +480,6 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	struct mem_ctl_info *mci;
 	void __iomem *reg_base;
 	u32 irq_mask_all = 0;
-	struct resource *res;
 	struct device *dev;
 	int ret, idx, irq;
 	u32 reg_val;
@@ -505,8 +504,7 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize dmc520 edac */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg_base = devm_ioremap_resource(dev, res);
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
 
-- 
2.39.0

