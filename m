Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D282B221F0F
	for <lists+linux-edac@lfdr.de>; Thu, 16 Jul 2020 10:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgGPIyo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Jul 2020 04:54:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7759 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbgGPIyn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Jul 2020 04:54:43 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 398F9A10BBD81C6EFCED;
        Thu, 16 Jul 2020 16:54:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 16:54:40 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] RAS/CEC: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 16:58:34 +0800
Message-ID: <20200716085834.11484-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yongqiang Liu <liuyongqiang13@huawei.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
---
 drivers/ras/cec.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index a992bb426..ed47b59e4 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -435,7 +435,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(action_threshold_ops, u64_get, action_threshold_set, "%
 
 static const char * const bins[] = { "00", "01", "10", "11" };
 
-static int array_dump(struct seq_file *m, void *v)
+static int array_show(struct seq_file *m, void *v)
 {
 	struct ce_array *ca = &ce_arr;
 	int i;
@@ -467,18 +467,7 @@ static int array_dump(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int array_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, array_dump, NULL);
-}
-
-static const struct file_operations array_ops = {
-	.owner	 = THIS_MODULE,
-	.open	 = array_open,
-	.read_iter	 = seq_read_iter,
-	.llseek	 = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(array);
 
 static int __init create_debugfs_nodes(void)
 {
@@ -513,7 +502,7 @@ static int __init create_debugfs_nodes(void)
 		goto err;
 	}
 
-	array = debugfs_create_file("array", S_IRUSR, d, NULL, &array_ops);
+	array = debugfs_create_file("array", S_IRUSR, d, NULL, &array_fops);
 	if (!array) {
 		pr_warn("Error creating array debugfs node!\n");
 		goto err;
-- 
2.17.1

