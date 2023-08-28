Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF2B78B0CF
	for <lists+linux-edac@lfdr.de>; Mon, 28 Aug 2023 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjH1Mnp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Aug 2023 08:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjH1MnU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Aug 2023 08:43:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6719100
        for <linux-edac@vger.kernel.org>; Mon, 28 Aug 2023 05:43:16 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RZ9BD3qcnzLp67;
        Mon, 28 Aug 2023 20:40:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 28 Aug
 2023 20:43:14 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-edac@vger.kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] EDAC: Use list_for_each_entry() helper
Date:   Mon, 28 Aug 2023 20:43:02 +0800
Message-ID: <20230828124303.361666-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Convert list_for_each() to list_for_each_entry() so that the position/item
list_head pointer and list_entry() call are no longer needed, which can
reduce a few lines of code. No functional changed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/edac/altera_edac.c |  5 +----
 drivers/edac/edac_device.c |  5 +----
 drivers/edac/edac_mc.c     | 16 +++-------------
 drivers/edac/edac_pci.c    |  5 +----
 4 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 8b31cd54bdb6..9296c0244ed2 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2083,14 +2083,11 @@ static int s10_edac_dberr_handler(struct notifier_block *this,
 		    &dberror);
 	regmap_write(edac->ecc_mgr_map, S10_SYSMGR_UE_VAL_OFST, dberror);
 	if (dberror & S10_DBE_IRQ_MASK) {
-		struct list_head *position;
 		struct altr_edac_device_dev *ed;
 		struct arm_smccc_res result;
 
 		/* Find the matching DBE in the list of devices */
-		list_for_each(position, &edac->a10_ecc_devices) {
-			ed = list_entry(position, struct altr_edac_device_dev,
-					next);
+		list_for_each_entry(ed, &edac->a10_ecc_devices, next) {
 			if (!(BIT(ed->db_irq) & dberror))
 				continue;
 
diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 0689e1510721..551b4e10551e 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -218,13 +218,10 @@ EXPORT_SYMBOL_GPL(edac_device_free_ctl_info);
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
diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 6faeb2ab3960..e632dde92327 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -428,13 +428,10 @@ EXPORT_SYMBOL_GPL(edac_has_mcs);
 static struct mem_ctl_info *__find_mci_by_dev(struct device *dev)
 {
 	struct mem_ctl_info *mci;
-	struct list_head *item;
 
 	edac_dbg(3, "\n");
 
-	list_for_each(item, &mc_devices) {
-		mci = list_entry(item, struct mem_ctl_info, link);
-
+	list_for_each_entry(mci, &mc_devices, link) {
 		if (mci->pdev == dev)
 			return mci;
 	}
@@ -495,21 +492,16 @@ static void edac_mc_workq_function(struct work_struct *work_req)
 void edac_mc_reset_delay_period(unsigned long value)
 {
 	struct mem_ctl_info *mci;
-	struct list_head *item;
 
 	mutex_lock(&mem_ctls_mutex);
 
-	list_for_each(item, &mc_devices) {
-		mci = list_entry(item, struct mem_ctl_info, link);
-
+	list_for_each_entry(mci, &mc_devices, link) {
 		if (mci->op_state == OP_RUNNING_POLL)
 			edac_mod_work(&mci->work, value);
 	}
 	mutex_unlock(&mem_ctls_mutex);
 }
 
-
-
 /* Return 0 on success, 1 on failure.
  * Before calling this function, caller must
  * assign a unique value to mci->mc_idx.
@@ -573,12 +565,10 @@ static int del_mc_from_global_list(struct mem_ctl_info *mci)
 struct mem_ctl_info *edac_mc_find(int idx)
 {
 	struct mem_ctl_info *mci;
-	struct list_head *item;
 
 	mutex_lock(&mem_ctls_mutex);
 
-	list_for_each(item, &mc_devices) {
-		mci = list_entry(item, struct mem_ctl_info, link);
+	list_for_each_entry(mci, &mc_devices, link) {
 		if (mci->mc_idx == idx)
 			goto unlock;
 	}
diff --git a/drivers/edac/edac_pci.c b/drivers/edac/edac_pci.c
index 64c142aecca7..0ee1e0a9ce21 100644
--- a/drivers/edac/edac_pci.c
+++ b/drivers/edac/edac_pci.c
@@ -71,13 +71,10 @@ EXPORT_SYMBOL_GPL(edac_pci_free_ctl_info);
 static struct edac_pci_ctl_info *find_edac_pci_by_dev(struct device *dev)
 {
 	struct edac_pci_ctl_info *pci;
-	struct list_head *item;
 
 	edac_dbg(1, "\n");
 
-	list_for_each(item, &edac_pci_list) {
-		pci = list_entry(item, struct edac_pci_ctl_info, link);
-
+	list_for_each_entry(pci, &edac_pci_list, link) {
 		if (pci->dev == dev)
 			return pci;
 	}
-- 
2.34.1

