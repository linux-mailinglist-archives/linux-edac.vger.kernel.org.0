Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF134B118D
	for <lists+linux-edac@lfdr.de>; Thu, 12 Sep 2019 16:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbfILOy0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Sep 2019 10:54:26 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:41147 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732906AbfILOyZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 Sep 2019 10:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568300064; x=1599836064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BgSqFonECsxI3qsQ8wLLqq+IUy6Bt13PJmrbofk+/FA=;
  b=pI2CbJrMulyKtkP0ed0rrqX3ktNDi+Yh+qDEQLmueD+5JXqZOvNFD79D
   Lyu1tbBnbzZsXIbmW6Ktzp2Ze8YSDNkUgZ/GalkSBeKSB31SkG5G9Hl5d
   411VuZspYzd2l5X5X9YL4SZzsCz0tiCUCvEkSEvQQrFqHQ0meRGG1VAcO
   A=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="414933595"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Sep 2019 14:54:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id D3B9FC0608;
        Thu, 12 Sep 2019 14:54:21 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 14:54:21 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.161.99) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 14:54:14 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>,
        <rrichter@marvell.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <hhhawa@amazon.com>
Subject: [PATCH v2 2/2] edac: move edac_device_handle_*() API functions to header
Date:   Thu, 12 Sep 2019 15:53:05 +0100
Message-ID: <20190912145305.21008-3-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912145305.21008-1-hhhawa@amazon.com>
References: <20190912145305.21008-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.99]
X-ClientProxiedBy: EX13D15UWA002.ant.amazon.com (10.43.160.218) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move edac_device_handle_*() functions from source file to header file as
inline funtcion that use the new API with single error.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/edac/edac_device.c | 89 --------------------------------------
 drivers/edac/edac_device.h | 37 ++++++----------
 2 files changed, 14 insertions(+), 112 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 78ac44103acc..4f735c625c36 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -555,95 +555,6 @@ static inline int edac_device_get_panic_on_ue(struct edac_device_ctl_info
 	return edac_dev->panic_on_ue;
 }
 
-void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
-			int inst_nr, int block_nr, const char *msg)
-{
-	struct edac_device_instance *instance;
-	struct edac_device_block *block = NULL;
-
-	if ((inst_nr >= edac_dev->nr_instances) || (inst_nr < 0)) {
-		edac_device_printk(edac_dev, KERN_ERR,
-				"INTERNAL ERROR: 'instance' out of range "
-				"(%d >= %d)\n", inst_nr,
-				edac_dev->nr_instances);
-		return;
-	}
-
-	instance = edac_dev->instances + inst_nr;
-
-	if ((block_nr >= instance->nr_blocks) || (block_nr < 0)) {
-		edac_device_printk(edac_dev, KERN_ERR,
-				"INTERNAL ERROR: instance %d 'block' "
-				"out of range (%d >= %d)\n",
-				inst_nr, block_nr,
-				instance->nr_blocks);
-		return;
-	}
-
-	if (instance->nr_blocks > 0) {
-		block = instance->blocks + block_nr;
-		block->counters.ce_count++;
-	}
-
-	/* Propagate the count up the 'totals' tree */
-	instance->counters.ce_count++;
-	edac_dev->counters.ce_count++;
-
-	if (edac_device_get_log_ce(edac_dev))
-		edac_device_printk(edac_dev, KERN_WARNING,
-				"CE: %s instance: %s block: %s '%s'\n",
-				edac_dev->ctl_name, instance->name,
-				block ? block->name : "N/A", msg);
-}
-EXPORT_SYMBOL_GPL(edac_device_handle_ce);
-
-void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
-			int inst_nr, int block_nr, const char *msg)
-{
-	struct edac_device_instance *instance;
-	struct edac_device_block *block = NULL;
-
-	if ((inst_nr >= edac_dev->nr_instances) || (inst_nr < 0)) {
-		edac_device_printk(edac_dev, KERN_ERR,
-				"INTERNAL ERROR: 'instance' out of range "
-				"(%d >= %d)\n", inst_nr,
-				edac_dev->nr_instances);
-		return;
-	}
-
-	instance = edac_dev->instances + inst_nr;
-
-	if ((block_nr >= instance->nr_blocks) || (block_nr < 0)) {
-		edac_device_printk(edac_dev, KERN_ERR,
-				"INTERNAL ERROR: instance %d 'block' "
-				"out of range (%d >= %d)\n",
-				inst_nr, block_nr,
-				instance->nr_blocks);
-		return;
-	}
-
-	if (instance->nr_blocks > 0) {
-		block = instance->blocks + block_nr;
-		block->counters.ue_count++;
-	}
-
-	/* Propagate the count up the 'totals' tree */
-	instance->counters.ue_count++;
-	edac_dev->counters.ue_count++;
-
-	if (edac_device_get_log_ue(edac_dev))
-		edac_device_printk(edac_dev, KERN_EMERG,
-				"UE: %s instance: %s block: %s '%s'\n",
-				edac_dev->ctl_name, instance->name,
-				block ? block->name : "N/A", msg);
-
-	if (edac_device_get_panic_on_ue(edac_dev))
-		panic("EDAC %s: UE instance: %s block %s '%s'\n",
-			edac_dev->ctl_name, instance->name,
-			block ? block->name : "N/A", msg);
-}
-EXPORT_SYMBOL_GPL(edac_device_handle_ue);
-
 void __edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
 			     unsigned int count, int inst_nr, int block_nr,
 			     const char *msg)
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 30dc5f5979c8..796ea134a691 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -285,29 +285,6 @@ extern int edac_device_add_device(struct edac_device_ctl_info *edac_dev);
  */
 extern struct edac_device_ctl_info *edac_device_del_device(struct device *dev);
 
-/**
- * edac_device_handle_ue():
- *	perform a common output and handling of an 'edac_dev' UE event
- *
- * @edac_dev: pointer to struct &edac_device_ctl_info
- * @inst_nr: number of the instance where the UE error happened
- * @block_nr: number of the block where the UE error happened
- * @msg: message to be printed
- */
-extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
-				int inst_nr, int block_nr, const char *msg);
-/**
- * edac_device_handle_ce():
- *	perform a common output and handling of an 'edac_dev' CE event
- *
- * @edac_dev: pointer to struct &edac_device_ctl_info
- * @inst_nr: number of the instance where the CE error happened
- * @block_nr: number of the block where the CE error happened
- * @msg: message to be printed
- */
-extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
-				int inst_nr, int block_nr, const char *msg);
-
 /**
  * edac_device_alloc_index: Allocate a unique device index number
  *
@@ -357,4 +334,18 @@ static inline void edac_device_handle_ue_count(struct edac_device_ctl_info *edac
 {
 	__edac_device_handle_ue(edac_dev, count, inst_nr, block_nr, msg);
 }
+
+static inline void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
+					 int inst_nr, int block_nr,
+					 const char *msg)
+{
+	__edac_device_handle_ce(edac_dev, 1, inst_nr, block_nr, msg);
+}
+
+static inline void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
+					 int inst_nr, int block_nr,
+					 const char *msg)
+{
+	__edac_device_handle_ue(edac_dev, 1, inst_nr, block_nr, msg);
+}
 #endif
-- 
2.17.1

