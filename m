Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB3D2A4EC
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2019 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfEYOmN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 25 May 2019 10:42:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbfEYOmN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 25 May 2019 10:42:13 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F199C4B7FDF832421FFA;
        Sat, 25 May 2019 22:42:10 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 22:42:02 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sschaeck@cisco.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <james.morse@arm.com>, <joel@jms.id.au>, <andrew@aj.id.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] EDAC: aspeed: Remove set but not used variable 'np'
Date:   Sat, 25 May 2019 22:41:53 +0800
Message-ID: <20190525144153.2028-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/edac/aspeed_edac.c: In function aspeed_probe:
drivers/edac/aspeed_edac.c:284:22: warning: variable np set but not used [-Wunused-but-set-variable]

It is never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/edac/aspeed_edac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 11833c0a5d07..5634437bb39d 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -281,15 +281,11 @@ static int aspeed_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
-	struct device_node *np;
 	struct resource *res;
 	void __iomem *regs;
 	u32 reg04;
 	int rc;
 
-	/* setup regmap */
-	np = dev->of_node;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENOENT;
-- 
2.17.1


