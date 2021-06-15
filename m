Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF7E3A7726
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jun 2021 08:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhFOGir (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Jun 2021 02:38:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4912 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhFOGiq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Jun 2021 02:38:46 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G3z6M5RwZz6yq5;
        Tue, 15 Jun 2021 14:33:31 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 14:36:40 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 15 Jun 2021 14:36:39 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rric@kernel.org>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] edac: Convert list_for_each to entry variant
Date:   Tue, 15 Jun 2021 14:55:10 +0800
Message-ID: <1623740110-15764-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

convert list_for_each() to list_for_each_entry() where
applicable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/edac/edac_device.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 8c4d947..e8b33c3 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -245,13 +245,10 @@ EXPORT_SYMBOL_GPL(edac_device_free_ctl_info);
 static struct edac_device_ctl_info *find_edac_device_by_dev(struct device *dev)
 {
 	struct edac_device_ctl_info *edac_dev;
-	struct list_head *item;
 
 	edac_dbg(0, "\n");
 
-	list_for_each(item, &edac_device_list) {
-		edac_dev = list_entry(item, struct edac_device_ctl_info, link);
-
+	list_for_each_entry(edac_dev, &edac_device_list, link) {
 		if (edac_dev->dev == dev)
 			return edac_dev;
 	}
-- 
2.6.2

