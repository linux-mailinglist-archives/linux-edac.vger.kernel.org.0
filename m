Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5BF76FD1D
	for <lists+linux-edac@lfdr.de>; Fri,  4 Aug 2023 11:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjHDJU6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Aug 2023 05:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjHDJU2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 4 Aug 2023 05:20:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12E45B94
        for <linux-edac@vger.kernel.org>; Fri,  4 Aug 2023 02:16:51 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHKDf4n80zVjyB;
        Fri,  4 Aug 2023 16:50:42 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 16:52:29 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:52:29 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-edac@vger.kernel.org>
CC:     <sramani@mellanox.com>, <james.morse@arm.com>,
        <mchehab@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next] edac/bluefield: Use devm_platform_get_and_ioremap_resource()
Date:   Fri, 4 Aug 2023 16:49:43 +0800
Message-ID: <20230804084943.1326226-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify
code. And emi_res is not used, it can be removed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/edac/bluefield_edac.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index e4736eb37bfb..a35c9f8f0d2c 100644
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
+	priv->emi_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(priv->emi_base)) {
 		dev_err(dev, "failed to map EMI IO resource\n");
 		ret = PTR_ERR(priv->emi_base);
-- 
2.25.1

