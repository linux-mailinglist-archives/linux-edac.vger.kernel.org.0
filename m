Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22E825D391
	for <lists+linux-edac@lfdr.de>; Fri,  4 Sep 2020 10:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgIDI04 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Sep 2020 04:26:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729582AbgIDI0z (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 4 Sep 2020 04:26:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5359180C9C0A7CA6DE60;
        Fri,  4 Sep 2020 16:26:53 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Sep 2020 16:26:43 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] EDAC/mc_sysfs: add missing newlines when printing 'max(dimm)_location'
Date:   Fri, 4 Sep 2020 16:19:23 +0800
Message-ID: <1599207563-41819-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When I cat 'max_location' and 'dimm_location' by sysfs, it displays as
follows. It's better to add a newline for easy reading.

[root@localhost /]# cat /sys/devices/system/edac/mc/mc0/max_location
memory 3 [root@localhost /]# cat /sys/devices/system/edac/mc/mc0/dimm0/dimm_location
memory 0 [root@localhost /]#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

---
I am not sure if there are some userspace tools using this file.
---
 drivers/edac/edac_mc_sysfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 4e6aca5..5d7b079 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -474,8 +474,12 @@ static ssize_t dimmdev_location_show(struct device *dev,
 				     struct device_attribute *mattr, char *data)
 {
 	struct dimm_info *dimm = to_dimm(dev);
+	ssize_t count;
 
-	return edac_dimm_info_location(dimm, data, PAGE_SIZE);
+	count = edac_dimm_info_location(dimm, data, PAGE_SIZE);
+	count += snprintf(data + count, PAGE_SIZE - count, "\n");
+
+	return count;
 }
 
 static ssize_t dimmdev_label_show(struct device *dev,
@@ -821,6 +825,7 @@ static ssize_t mci_max_location_show(struct device *dev,
 			     edac_layer_name[mci->layers[i].type],
 			     mci->layers[i].size - 1);
 	}
+	p += sprintf(p, "\n");
 
 	return p - data;
 }
-- 
1.7.12.4

