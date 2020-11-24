Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CE72C1E3F
	for <lists+linux-edac@lfdr.de>; Tue, 24 Nov 2020 07:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgKXGag (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 24 Nov 2020 01:30:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8393 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgKXGag (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 24 Nov 2020 01:30:36 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CgDfB1kZwz72HQ;
        Tue, 24 Nov 2020 14:30:10 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 24 Nov 2020
 14:30:18 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <bp@alien8.de>
CC:     <mchehab@kernel.org>, <james.morse@arm.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>
Subject: [PATCH] EDAC, mv64x60: Fix error return code in mv64x60_pci_err_probe()
Date:   Tue, 24 Nov 2020 14:30:09 +0800
Message-ID: <20201124063009.1529-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix to return -ENODEV error code when edac_pci_add_device() failed instaed
of 0 in mv64x60_pci_err_probe(), as done elsewhere in this function.

Fixes: 4f4aeeabc061 ("drivers-edac: add marvell mv64x60 driver")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/edac/mv64x60_edac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index 3c68bb525d5d..456b9ca1fe8d 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -168,6 +168,7 @@ static int mv64x60_pci_err_probe(struct platform_device *pdev)
 
 	if (edac_pci_add_device(pci, pdata->edac_idx) > 0) {
 		edac_dbg(3, "failed edac_pci_add_device()\n");
+		res = -ENODEV;
 		goto err;
 	}
 
-- 
2.17.1

