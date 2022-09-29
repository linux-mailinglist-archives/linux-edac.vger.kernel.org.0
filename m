Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AA95F182E
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 03:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiJABOb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 21:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiJABO0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 21:14:26 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CABCD6409;
        Fri, 30 Sep 2022 18:14:20 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 1E4BAE0ECB;
        Fri, 30 Sep 2022 02:27:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=Wuk4O59cXcttSrtKFRFPt0XppdcnPe6R4xFVev7zIkQ=; b=dim4L7bcOXJT
        IXolNndmVAqP3ESV7nSU2apun8ZRF/HFNoMYt29HdhF5pidhizd8AvipTU8RzkSo
        8vIKUVAyrftByPGcOFnZaSzjmvZOkpaYd2NuggMZRW7l5yyRLL8RJws/r/nDFUjW
        tsGTHGAFCOybFIUCGAigG8TxT/jL1ZA=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 0F7A5E0E6B;
        Fri, 30 Sep 2022 02:27:33 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:27:33 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3 13/17] EDAC/mc: Add MC unique index allocation procedure
Date:   Fri, 30 Sep 2022 02:27:08 +0300
Message-ID: <20220929232712.12202-14-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

In case of the unique index allocation it's not that optimal to always
rely on the low-level device drivers (platform drivers), because they get
to start to implement either the same design pattern (for instance global
static MC counter) or may end-up with having non-unique index eventually
at runtime. Needless to say that having a generic unique index
allocation/tracking procedure will make code more readable and safer.

The suggested implementation is based on the kernel IDA infrastructure
exposed by the lib/idr.c driver with API described in linux/idr.h header
file. It's used to create an ID resource descriptor "mc_idr", which then
is utilized either to track the custom MC idx specified by EDAC LLDDs or
to allocate the next-free MC idx.

A new special MC index is introduced here. It's defined by the
EDAC_AUTO_MC_NUM macro with a value specifically chosen as the least
probable value used for the real MC index. In case if the EDAC_AUTO_MC_NUM
index is specified by the EDAC LLDD, the MC index will be either retrieved
from the MC device OF-node alias index ("mc[:number:]") or automatically
generated as the next-free MC index found by the ID allocation procedure.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Note the approach implemented here has been partly ported from the SPI
core driver using IDA to track/allocate SPI bus numbers.
Link: https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L2957
---
 drivers/edac/edac_mc.c | 89 +++++++++++++++++++++++++++++++++++++++---
 drivers/edac/edac_mc.h |  4 ++
 2 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 24814839d885..634c41ea7804 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -29,6 +29,9 @@
 #include <linux/edac.h>
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
+#include <linux/idr.h>
+#include <linux/of.h>
+
 #include <asm/page.h>
 #include "edac_mc.h"
 #include "edac_module.h"
@@ -46,6 +49,7 @@ EXPORT_SYMBOL_GPL(edac_op_state);
 /* lock to memory controller's control array */
 static DEFINE_MUTEX(mem_ctls_mutex);
 static LIST_HEAD(mc_devices);
+static DEFINE_IDR(mc_idr);
 
 /*
  * Used to lock EDAC MC to just one module, avoiding two drivers e. g.
@@ -493,7 +497,64 @@ void edac_mc_reset_delay_period(unsigned long value)
 	mutex_unlock(&mem_ctls_mutex);
 }
 
+/**
+ * edac_mc_alloc_id() - Allocate unique Memory Controller identifier
+ *
+ * @mci: pointer to the mci structure to allocate ID for
+ *
+ * Use edac_mc_free_id() to coherently free the MC identifier.
+ *
+ * .. note::
+ *	locking model: must be called with the mem_ctls_mutex lock held
+ *
+ * Returns:
+ *	0 on Success, or an error code on failure
+ */
+static int edac_mc_alloc_id(struct mem_ctl_info *mci)
+{
+	struct device_node *np = dev_of_node(mci->pdev);
+	int ret, min, max;
+
+	if (mci->mc_idx == EDAC_AUTO_MC_NUM) {
+		ret = of_alias_get_id(np, "mc");
+		if (ret >= 0) {
+			min = ret;
+			max = ret + 1;
+		} else {
+			min = of_alias_get_highest_id("mc");
+			if (min >= 0)
+				min++;
+			else
+				min = 0;
+
+			max = 0;
+		}
+	} else {
+		min = mci->mc_idx;
+		max = mci->mc_idx + 1;
+	}
+
+	ret = idr_alloc(&mc_idr, mci, min, max, GFP_KERNEL);
+	if (ret < 0)
+		return ret == -ENOSPC ? -EBUSY : ret;
+
+	mci->mc_idx = ret;
+
+	return 0;
+}
 
+/**
+ * edac_mc_free_id() - Free Memory Controller identifier
+ *
+ * @mci: pointer to the mci structure to free ID from
+ *
+ * .. note::
+ *	locking model: must be called with the mem_ctls_mutex lock held
+ */
+static void edac_mc_free_id(struct mem_ctl_info *mci)
+{
+	idr_remove(&mc_idr, mci->mc_idx);
+}
 
 /**
  * edac_mc_init_labels() - Initialize DIMM labels
@@ -612,7 +673,8 @@ EXPORT_SYMBOL_GPL(edac_get_owner);
 int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 			       const struct attribute_group **groups)
 {
-	int ret = -EINVAL;
+	int ret;
+
 	edac_dbg(0, "\n");
 
 #ifdef CONFIG_EDAC_DEBUG
@@ -649,20 +711,30 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 		goto fail0;
 	}
 
+	ret = edac_mc_alloc_id(mci);
+	if (ret) {
+		edac_printk(KERN_ERR, EDAC_MC, "failed to allocate MC idx %u\n",
+			    mci->mc_idx);
+		goto fail0;
+	}
+
 	edac_mc_init_labels(mci);
 
-	if (add_mc_to_global_list(mci))
-		goto fail0;
+	if (add_mc_to_global_list(mci)) {
+		ret = -EINVAL;
+		goto fail1;
+	}
 
 	/* set load time so that error rate can be tracked */
 	mci->start_time = jiffies;
 
 	mci->bus = edac_get_sysfs_subsys();
 
-	if (edac_create_sysfs_mci_device(mci, groups)) {
+	ret = edac_create_sysfs_mci_device(mci, groups);
+	if (ret) {
 		edac_mc_printk(mci, KERN_WARNING,
 			"failed to create sysfs device\n");
-		goto fail1;
+		goto fail2;
 	}
 
 	if (mci->edac_check) {
@@ -686,9 +758,12 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 	mutex_unlock(&mem_ctls_mutex);
 	return 0;
 
-fail1:
+fail2:
 	del_mc_from_global_list(mci);
 
+fail1:
+	edac_mc_free_id(mci);
+
 fail0:
 	mutex_unlock(&mem_ctls_mutex);
 	return ret;
@@ -716,6 +791,8 @@ struct mem_ctl_info *edac_mc_del_mc(struct device *dev)
 	if (del_mc_from_global_list(mci))
 		edac_mc_owner = NULL;
 
+	edac_mc_free_id(mci);
+
 	mutex_unlock(&mem_ctls_mutex);
 
 	if (mci->edac_check)
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 881b00eadf7a..4b6676235b1b 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -23,6 +23,7 @@
 #define _EDAC_MC_H_
 
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
@@ -37,6 +38,9 @@
 #include <linux/workqueue.h>
 #include <linux/edac.h>
 
+/* Generate MC identifier automatically */
+#define EDAC_AUTO_MC_NUM	UINT_MAX
+
 #if PAGE_SHIFT < 20
 #define PAGES_TO_MiB(pages)	((pages) >> (20 - PAGE_SHIFT))
 #define MiB_TO_PAGES(mb)	((mb) << (20 - PAGE_SHIFT))
-- 
2.37.3


