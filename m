Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D6E26F4BD
	for <lists+linux-edac@lfdr.de>; Fri, 18 Sep 2020 05:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIRDds (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Sep 2020 23:33:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13287 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbgIRDds (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 17 Sep 2020 23:33:48 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2DD473B87BF4DD4B65B0;
        Fri, 18 Sep 2020 11:33:46 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 11:33:39 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>
CC:     <joe@perches.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>
Subject: [PATCH v3] EDAC/mc_sysfs: Add missing newlines when printing {max,dimm}_location
Date:   Fri, 18 Sep 2020 11:26:08 +0800
Message-ID: <1600399568-21649-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Reading those sysfs entries gives:

  [root@localhost /]# cat /sys/devices/system/edac/mc/mc0/max_location
  memory 3 [root@localhost /]# cat /sys/devices/system/edac/mc/mc0/dimm0/dimm_location
  memory 0 [root@localhost /]#

Add newlines after the value it prints for better readability.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Borislav Petkov <bp@alien8.de>
Suggested-by: Joe Perches <joe@perches.com>
---
 drivers/edac/edac_mc_sysfs.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 4e6aca5..2f9f1e7 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -474,8 +474,12 @@ static ssize_t dimmdev_location_show(struct device *dev,
 				     struct device_attribute *mattr, char *data)
 {
 	struct dimm_info *dimm = to_dimm(dev);
+	ssize_t count;
 
-	return edac_dimm_info_location(dimm, data, PAGE_SIZE);
+	count = edac_dimm_info_location(dimm, data, PAGE_SIZE);
+	count += scnprintf(data + count, PAGE_SIZE - count, "\n");
+
+	return count;
 }
 
 static ssize_t dimmdev_label_show(struct device *dev,
@@ -813,15 +817,23 @@ static ssize_t mci_max_location_show(struct device *dev,
 				     char *data)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
-	int i;
+	int len = PAGE_SIZE;
 	char *p = data;
+	int i, n;
 
 	for (i = 0; i < mci->n_layers; i++) {
-		p += sprintf(p, "%s %d ",
-			     edac_layer_name[mci->layers[i].type],
-			     mci->layers[i].size - 1);
+		n = scnprintf(p, len, "%s %d ",
+			      edac_layer_name[mci->layers[i].type],
+			      mci->layers[i].size - 1);
+		len -= n;
+		if (len <= 0)
+			goto out;
+
+		p += n;
 	}
 
+	p += scnprintf(p, len, "\n");
+out:
 	return p - data;
 }
 
-- 
1.7.12.4

