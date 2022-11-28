Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018F263A1B2
	for <lists+linux-edac@lfdr.de>; Mon, 28 Nov 2022 07:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiK1G7H (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Nov 2022 01:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiK1G6v (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Nov 2022 01:58:51 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481A85F73
        for <linux-edac@vger.kernel.org>; Sun, 27 Nov 2022 22:57:36 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NLGQk3YkBzJnxf;
        Mon, 28 Nov 2022 14:53:50 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 14:57:11 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 28 Nov
 2022 14:57:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-edac@vger.kernel.org>
CC:     <tony.luck@intel.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <james.morse@arm.com>, <rric@kernel.org>, <qiuxu.zhuo@intel.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH v2] EDAC/i10nm: fix refcount leak in pci_get_dev_wrapper()
Date:   Mon, 28 Nov 2022 14:55:12 +0800
Message-ID: <20221128065512.3572550-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

As the comment of pci_get_domain_bus_and_slot() says, it returns
a PCI device with refcount incremented, so it doesn't need to
call an extra pci_dev_get() in pci_get_dev_wrapper(), and the PCI
device needs to be put in the error path.

Fixes: d4dc89d069aa ("EDAC, i10nm: Add a driver for Intel 10nm server processors")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v1 -> v2:
  Fix some grammar errors in the commit message.
---
 drivers/edac/i10nm_base.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index a22ea053f8e1..8af4d2523194 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -304,11 +304,10 @@ static struct pci_dev *pci_get_dev_wrapper(int dom, unsigned int bus,
 	if (unlikely(pci_enable_device(pdev) < 0)) {
 		edac_dbg(2, "Failed to enable device %02x:%02x.%x\n",
 			 bus, dev, fun);
+		pci_dev_put(pdev);
 		return NULL;
 	}
 
-	pci_dev_get(pdev);
-
 	return pdev;
 }
 
-- 
2.25.1

