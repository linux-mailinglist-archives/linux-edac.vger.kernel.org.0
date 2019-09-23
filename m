Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83746BBC2C
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2019 21:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfIWTTe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Sep 2019 15:19:34 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:31405 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfIWTTe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 23 Sep 2019 15:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1569266372; x=1600802372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xWz179vPrX5wqnBp1Ph/qRdIvYipnnsMduudtgRLRB0=;
  b=XeGa+eCpDsyJvv8BpfL5Xzw1N/BKfZLcGwz9yVrBGz57k6FH3sF/j5U6
   O/N/8nQDpc6a/3KJKBD4HigeIT3RHegdaqqkheyzu4OXKdYtW4Lcv3yAA
   SWSOv7+bOOxYLsGSb+w/O5TXgxciwXfFeUKdMbBufTfqK4GLaDhfZraey
   U=;
X-IronPort-AV: E=Sophos;i="5.64,541,1559520000"; 
   d="scan'208";a="703972304"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 23 Sep 2019 19:18:19 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 3E905A1E06;
        Mon, 23 Sep 2019 19:18:09 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Sep 2019 19:18:08 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.161.176) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Sep 2019 19:18:01 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>,
        <rrichter@marvell.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <hhhawa@amazon.com>
Subject: [PATCH v4 1/2] edac: Add an API for edac device to report for multiple errors
Date:   Mon, 23 Sep 2019 20:17:40 +0100
Message-ID: <20190923191741.29322-2-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923191741.29322-1-hhhawa@amazon.com>
References: <20190923191741.29322-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.176]
X-ClientProxiedBy: EX13D08UWC002.ant.amazon.com (10.43.162.168) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add an API for EDAC device to report multiple errors with same type.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Acked-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_device.c | 56 ++++++++++++++++++++++++--------------
 drivers/edac/edac_device.h | 47 ++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 20 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 65cf2b9355c4..6701fd3a8ce0 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -555,8 +555,9 @@ static inline int edac_device_get_panic_on_ue(struct edac_device_ctl_info
 	return edac_dev->panic_on_ue;
 }
 
-void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
-			int inst_nr, int block_nr, const char *msg)
+void __edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
+			     unsigned int count, int inst_nr, int block_nr,
+			     const char *msg)
 {
 	struct edac_device_instance *instance;
 	struct edac_device_block *block = NULL;
@@ -582,23 +583,24 @@ void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
 
 	if (instance->nr_blocks > 0) {
 		block = instance->blocks + block_nr;
-		block->counters.ce_count++;
+		block->counters.ce_count += count;
 	}
 
 	/* Propagate the count up the 'totals' tree */
-	instance->counters.ce_count++;
-	edac_dev->counters.ce_count++;
+	instance->counters.ce_count += count;
+	edac_dev->counters.ce_count += count;
 
 	if (edac_device_get_log_ce(edac_dev))
 		edac_device_printk(edac_dev, KERN_WARNING,
-				"CE: %s instance: %s block: %s '%s'\n",
-				edac_dev->ctl_name, instance->name,
-				block ? block->name : "N/A", msg);
+				   "CE: %s instance: %s block: %s count: %d '%s'\n",
+				   edac_dev->ctl_name, instance->name,
+				   block ? block->name : "N/A", count, msg);
 }
-EXPORT_SYMBOL_GPL(edac_device_handle_ce);
+EXPORT_SYMBOL_GPL(__edac_device_handle_ce);
 
-void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
-			int inst_nr, int block_nr, const char *msg)
+void __edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
+			     unsigned int count, int inst_nr, int block_nr,
+			     const char *msg)
 {
 	struct edac_device_instance *instance;
 	struct edac_device_block *block = NULL;
@@ -624,22 +626,36 @@ void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
 
 	if (instance->nr_blocks > 0) {
 		block = instance->blocks + block_nr;
-		block->counters.ue_count++;
+		block->counters.ue_count += count;
 	}
 
 	/* Propagate the count up the 'totals' tree */
-	instance->counters.ue_count++;
-	edac_dev->counters.ue_count++;
+	instance->counters.ue_count += count;
+	edac_dev->counters.ue_count += count;
 
 	if (edac_device_get_log_ue(edac_dev))
 		edac_device_printk(edac_dev, KERN_EMERG,
-				"UE: %s instance: %s block: %s '%s'\n",
-				edac_dev->ctl_name, instance->name,
-				block ? block->name : "N/A", msg);
+				   "UE: %s instance: %s block: %s count: %d '%s'\n",
+				   edac_dev->ctl_name, instance->name,
+				   block ? block->name : "N/A", count, msg);
 
 	if (edac_device_get_panic_on_ue(edac_dev))
-		panic("EDAC %s: UE instance: %s block %s '%s'\n",
-			edac_dev->ctl_name, instance->name,
-			block ? block->name : "N/A", msg);
+		panic("EDAC %s: UE instance: %s block %s count: %d '%s'\n",
+		      edac_dev->ctl_name, instance->name,
+		      block ? block->name : "N/A", count, msg);
+}
+EXPORT_SYMBOL_GPL(__edac_device_handle_ue);
+
+void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
+			int inst_nr, int block_nr, const char *msg)
+{
+	__edac_device_handle_ce(edac_dev, 1, inst_nr, block_nr, msg);
+}
+EXPORT_SYMBOL_GPL(edac_device_handle_ce);
+
+void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
+			int inst_nr, int block_nr, const char *msg)
+{
+	__edac_device_handle_ue(edac_dev, 1, inst_nr, block_nr, msg);
 }
 EXPORT_SYMBOL_GPL(edac_device_handle_ue);
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 1aaba74ae411..7869f036138a 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -285,6 +285,33 @@ extern int edac_device_add_device(struct edac_device_ctl_info *edac_dev);
  */
 extern struct edac_device_ctl_info *edac_device_del_device(struct device *dev);
 
+/**
+ * __edac_device_handle_ue():
+ *	perform a common output and handling of an 'edac_dev' UE event
+ *
+ * @edac_dev: pointer to struct &edac_device_ctl_info
+ * @count: number of errors of the same type
+ * @inst_nr: number of the instance where the UE error happened
+ * @block_nr: number of the block where the UE error happened
+ * @msg: message to be printed
+ */
+void __edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
+			     unsigned int count, int inst_nr, int block_nr,
+			     const char *msg);
+/**
+ * __edac_device_handle_ce():
+ *	perform a common output and handling of an 'edac_dev' CE event
+ *
+ * @edac_dev: pointer to struct &edac_device_ctl_info
+ * @count: number of errors of the same type
+ * @inst_nr: number of the instance where the CE error happened
+ * @block_nr: number of the block where the CE error happened
+ * @msg: message to be printed
+ */
+void __edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
+			     unsigned int count, int inst_nr, int block_nr,
+			     const char *msg);
+
 /**
  * edac_device_handle_ue():
  *	perform a common output and handling of an 'edac_dev' UE event
@@ -308,6 +335,26 @@ extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
 extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
 				int inst_nr, int block_nr, const char *msg);
 
+static inline void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
+					       unsigned int count, int inst_nr,
+					       int block_nr, const char *msg)
+{
+	if (!count)
+		return;
+
+	__edac_device_handle_ce(edac_dev, count, inst_nr, block_nr, msg);
+}
+
+static inline void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
+					       unsigned int count, int inst_nr,
+					       int block_nr, const char *msg)
+{
+	if (!count)
+		return;
+
+	__edac_device_handle_ue(edac_dev, count, inst_nr, block_nr, msg);
+}
+
 /**
  * edac_device_alloc_index: Allocate a unique device index number
  *
-- 
2.17.1

