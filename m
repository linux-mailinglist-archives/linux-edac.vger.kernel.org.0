Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10B32682CD
	for <lists+linux-edac@lfdr.de>; Mon, 14 Sep 2020 04:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgINC4e (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 13 Sep 2020 22:56:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58376 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbgINC4e (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 13 Sep 2020 22:56:34 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B7ADABA9B79046030BEE;
        Mon, 14 Sep 2020 10:56:30 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 14 Sep 2020 10:56:20 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH v2] EDAC/mc_sysfs: Add missing newlines when printing {max,dimm}_location
Date:   Mon, 14 Sep 2020 10:48:54 +0800
Message-ID: <1600051734-8993-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Reading those sysfs entries gives:

  [root@localhost /]# cat /sys/devices/system/edac/mc/mc0/max_location
  memory 3 [root@localhost /]# cat /sys/devices/system/edac/mc/mc0/dimm0/dimm_location
  memory 0 [root@localhost /]#

Add newlines after the value it prints for better readability.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/edac/edac_mc_sysfs.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 4e6aca5..bf0e075 100644
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
@@ -813,15 +817,21 @@ static ssize_t mci_max_location_show(struct device *dev,
 				     char *data)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
-	int i;
+	int i, n;
 	char *p = data;
+	unsigned int len = PAGE_SIZE;
 
 	for (i = 0; i < mci->n_layers; i++) {
-		p += sprintf(p, "%s %d ",
+		n = snprintf(p, len, "%s %d ",
 			     edac_layer_name[mci->layers[i].type],
 			     mci->layers[i].size - 1);
+		p += n;
+		len -= n;
+		if (!len)
+			goto out;
 	}
-
+	p += snprintf(p, len, "\n");
+out:
 	return p - data;
 }
 
-- 
1.7.12.4

