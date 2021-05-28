Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54528393BE6
	for <lists+linux-edac@lfdr.de>; Fri, 28 May 2021 05:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhE1D2Y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 May 2021 23:28:24 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2386 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhE1D2X (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 27 May 2021 23:28:23 -0400
Received: from dggeml767-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Frql06CgYz63c0;
        Fri, 28 May 2021 11:23:08 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggeml767-chm.china.huawei.com (10.1.199.177) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 11:26:47 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 11:26:46 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Johannes Thumshirn <morbidrsa@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "Doug Thompson" <dougthompson@xmission.com>,
        Dave Jiang <djiang@mvista.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] EDAC, mpc85xx: Fix error return code in two functions
Date:   Fri, 28 May 2021 11:26:37 +0800
Message-ID: <20210528032637.9231-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix to return -EFAULT from the error handling case instead of 0, as done
elsewhere in its function.

Fixes: a9a753d53204 ("drivers-edac: add freescale mpc85xx driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/edac/mpc85xx_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 67f7bc3fe5b3..b2eaa62c9412 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -248,6 +248,7 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
 
 	if (edac_pci_add_device(pci, pdata->edac_idx) > 0) {
 		edac_dbg(3, "failed edac_pci_add_device()\n");
+		res = -EFAULT;
 		goto err;
 	}
 
@@ -552,6 +553,7 @@ static int mpc85xx_l2_err_probe(struct platform_device *op)
 
 	if (edac_device_add_device(edac_dev) > 0) {
 		edac_dbg(3, "failed edac_device_add_device()\n");
+		res = -EFAULT;
 		goto err;
 	}
 
-- 
2.25.1


