Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD1E64C707
	for <lists+linux-edac@lfdr.de>; Wed, 14 Dec 2022 11:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbiLNKYm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Dec 2022 05:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbiLNKYc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Dec 2022 05:24:32 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9CC21249
        for <linux-edac@vger.kernel.org>; Wed, 14 Dec 2022 02:24:26 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NXBFM4C49zqT25;
        Wed, 14 Dec 2022 18:20:07 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 14 Dec 2022 18:24:24 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <dinguyen@kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>
CC:     <linux-edac@vger.kernel.org>, <tthayer@opensource.altera.com>,
        Wang Yufen <wangyufen@huawei.com>
Subject: [PATCH] EDAC/altera: fix refcount leak in altr_portb_setup()
Date:   Wed, 14 Dec 2022 18:24:10 +0800
Message-ID: <1671013450-44489-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The node returned by of_find_compatible_node() with refcount incremented,
of_node_put() needs be called when finish using it. So add it in the
error path in altr_portb_setup() and the end of altr_portb_setup().

Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
---
 drivers/edac/altera_edac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e7e8e62..3d79fd3 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1528,6 +1528,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 		edac_printk(KERN_ERR, EDAC_DEVICE,
 			    "%s: Unable to allocate PortB EDAC device\n",
 			    ecc_name);
+		of_node_put(np);
 		return -ENOMEM;
 	}
 
@@ -1535,8 +1536,10 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	altdev = dci->pvt_info;
 	*altdev = *device;
 
-	if (!devres_open_group(&altdev->ddev, altr_portb_setup, GFP_KERNEL))
+	if (!devres_open_group(&altdev->ddev, altr_portb_setup, GFP_KERNEL)) {
+		of_node_put(np);
 		return -ENOMEM;
+	}
 
 	/* Update PortB specific values */
 	altdev->edac_dev_name = ecc_name;
@@ -1611,9 +1614,11 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 
 	devres_remove_group(&altdev->ddev, altr_portb_setup);
 
+	of_node_put(np);
 	return 0;
 
 err_release_group_1:
+	of_node_put(np);
 	edac_device_free_ctl_info(dci);
 	devres_release_group(&altdev->ddev, altr_portb_setup);
 	edac_printk(KERN_ERR, EDAC_DEVICE,
-- 
1.8.3.1

