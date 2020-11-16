Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164392B4549
	for <lists+linux-edac@lfdr.de>; Mon, 16 Nov 2020 14:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgKPNzo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Nov 2020 08:55:44 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7922 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgKPNzo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 Nov 2020 08:55:44 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CZVvc3zz2z6wpG;
        Mon, 16 Nov 2020 21:55:24 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 21:55:28 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <zhangxiaoxu5@huawei.com>, <michal.simek@xilinx.com>,
        <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rric@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH] EDAC/synopsys: Fix wrong return value of mc_probe()
Date:   Mon, 16 Nov 2020 08:58:10 -0500
Message-ID: <20201116135810.3130845-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

If create the inject sysfs file failed, we should return
the error, rather than 0. Otherwise, there maybe error
pointer access.

Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 drivers/edac/synopsys_edac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 12211dc040e8..7e7146b22c16 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1344,7 +1344,8 @@ static int mc_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_EDAC_DEBUG
 	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
-		if (edac_create_sysfs_attributes(mci)) {
+		rc = edac_create_sysfs_attributes(mci);
+		if (rc) {
 			edac_printk(KERN_ERR, EDAC_MC,
 					"Failed to create sysfs entries\n");
 			goto free_edac_mc;
-- 
2.25.4

