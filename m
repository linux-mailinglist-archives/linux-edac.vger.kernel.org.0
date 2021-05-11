Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E75D37A66D
	for <lists+linux-edac@lfdr.de>; Tue, 11 May 2021 14:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhEKMUV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 May 2021 08:20:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2632 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhEKMUV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 May 2021 08:20:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FfcNs6CQrzklcD;
        Tue, 11 May 2021 20:17:01 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 20:19:01 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] EDAC, mellanox: Remove redundant error printing in bluefield_edac_mc_probe()
Date:   Tue, 11 May 2021 20:18:56 +0800
Message-ID: <20210511121856.5996-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When devm_ioremap_resource() fails, a clear enough error message will be
printed by its subfunction __devm_ioremap_resource(). The error
information contains the device name, failure cause, and possibly resource
information.

Therefore, remove the error printing here to simplify code and reduce the
binary size.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/edac/bluefield_edac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index e4736eb37bfb33d..962d9f889923820 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -283,7 +283,6 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	priv->dimm_per_mc = dimm_count;
 	priv->emi_base = devm_ioremap_resource(dev, emi_res);
 	if (IS_ERR(priv->emi_base)) {
-		dev_err(dev, "failed to map EMI IO resource\n");
 		ret = PTR_ERR(priv->emi_base);
 		goto err;
 	}
-- 
2.26.0.106.g9fadedd


