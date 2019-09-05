Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF72A9D2C
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2019 10:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbfIEIiU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Sep 2019 04:38:20 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:63658 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730914AbfIEIiT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Sep 2019 04:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567672696; x=1599208696;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=JoB5AyJPXadZzdhXc+cFYRaaNL2nQ/XdAjAVfNiK2KA=;
  b=oIMK4PjLDnLOsgwEoEXlSURrPsxr1v8Plc3z5qnoV/x3x69bFfSJGeAF
   uIFPn4sqwHGWGoRgKFJUzPorWRjwHvy1iGTogWxxIY/dffs8nurWTmvHi
   DPiXmg84UsBsRDvxQ9ciH66faVo0EMLp7G2C6+GLnE6h4kMjr3r7v6qHY
   o=;
X-IronPort-AV: E=Sophos;i="5.64,470,1559520000"; 
   d="scan'208";a="749148804"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 05 Sep 2019 08:38:14 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 1092DA26EA;
        Thu,  5 Sep 2019 08:38:15 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Sep 2019 08:38:14 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.161.154) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Sep 2019 08:38:08 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <hhhawa@amazon.com>
Subject: [PATCH 1/1] edac: Add an API for edac device to report for multiple errors
Date:   Thu, 5 Sep 2019 09:37:45 +0100
Message-ID: <20190905083745.6899-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.154]
X-ClientProxiedBy: EX13d09UWA001.ant.amazon.com (10.43.160.247) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add an API for edac device to report multiple errors with same type.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/edac/edac_device.c | 66 +++++++++++++++++++++++++++++---------
 drivers/edac/edac_device.h | 31 ++++++++++++++++--
 2 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 65cf2b9355c4..bf6a4fd9831b 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -555,12 +555,15 @@ static inline int edac_device_get_panic_on_ue(struct edac_device_ctl_info
 	return edac_dev->panic_on_ue;
 }
 
-void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
-			int inst_nr, int block_nr, const char *msg)
+static void __edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
+			   u16 error_count, int inst_nr, int block_nr,
+			   const char *msg)
 {
 	struct edac_device_instance *instance;
 	struct edac_device_block *block = NULL;
 
+	WARN_ON(!error_count);
+
 	if ((inst_nr >= edac_dev->nr_instances) || (inst_nr < 0)) {
 		edac_device_printk(edac_dev, KERN_ERR,
 				"INTERNAL ERROR: 'instance' out of range "
@@ -582,27 +585,44 @@ void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
 
 	if (instance->nr_blocks > 0) {
 		block = instance->blocks + block_nr;
-		block->counters.ce_count++;
+		block->counters.ce_count += error_count;
 	}
 
 	/* Propagate the count up the 'totals' tree */
-	instance->counters.ce_count++;
-	edac_dev->counters.ce_count++;
+	instance->counters.ce_count += error_count;
+	edac_dev->counters.ce_count += error_count;
 
 	if (edac_device_get_log_ce(edac_dev))
 		edac_device_printk(edac_dev, KERN_WARNING,
-				"CE: %s instance: %s block: %s '%s'\n",
+				"CE: %s instance: %s block: %s count: %d '%s'\n",
 				edac_dev->ctl_name, instance->name,
-				block ? block->name : "N/A", msg);
+				block ? block->name : "N/A", error_count, msg);
+}
+
+void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
+			   int inst_nr, int block_nr, const char *msg)
+{
+	__edac_device_handle_ce(edac_dev, 1, inst_nr, block_nr, msg);
 }
 EXPORT_SYMBOL_GPL(edac_device_handle_ce);
 
-void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
-			int inst_nr, int block_nr, const char *msg)
+void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
+				 u16 error_count, int inst_nr, int block_nr,
+				 const char *msg)
+{
+	__edac_device_handle_ce(edac_dev, error_count, inst_nr, block_nr, msg);
+}
+EXPORT_SYMBOL_GPL(edac_device_handle_ce_count);
+
+static void __edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
+			   u16 error_count, int inst_nr, int block_nr,
+			   const char *msg)
 {
 	struct edac_device_instance *instance;
 	struct edac_device_block *block = NULL;
 
+	WARN_ON(!error_count);
+
 	if ((inst_nr >= edac_dev->nr_instances) || (inst_nr < 0)) {
 		edac_device_printk(edac_dev, KERN_ERR,
 				"INTERNAL ERROR: 'instance' out of range "
@@ -624,22 +644,36 @@ void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
 
 	if (instance->nr_blocks > 0) {
 		block = instance->blocks + block_nr;
-		block->counters.ue_count++;
+		block->counters.ue_count += error_count;
 	}
 
 	/* Propagate the count up the 'totals' tree */
-	instance->counters.ue_count++;
-	edac_dev->counters.ue_count++;
+	instance->counters.ue_count += error_count;
+	edac_dev->counters.ue_count += error_count;
 
 	if (edac_device_get_log_ue(edac_dev))
 		edac_device_printk(edac_dev, KERN_EMERG,
-				"UE: %s instance: %s block: %s '%s'\n",
+				"UE: %s instance: %s block: %s count: %d '%s'\n",
 				edac_dev->ctl_name, instance->name,
-				block ? block->name : "N/A", msg);
+				block ? block->name : "N/A", error_count, msg);
 
 	if (edac_device_get_panic_on_ue(edac_dev))
-		panic("EDAC %s: UE instance: %s block %s '%s'\n",
+		panic("EDAC %s: UE instance: %s block %s count: %d '%s'\n",
 			edac_dev->ctl_name, instance->name,
-			block ? block->name : "N/A", msg);
+			block ? block->name : "N/A", error_count, msg);
+}
+
+void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
+			   int inst_nr, int block_nr, const char *msg)
+{
+	__edac_device_handle_ue(edac_dev, 1, inst_nr, block_nr, msg);
 }
 EXPORT_SYMBOL_GPL(edac_device_handle_ue);
+
+void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
+				 u16 error_count, int inst_nr, int block_nr,
+				 const char *msg)
+{
+	__edac_device_handle_ue(edac_dev, error_count, inst_nr, block_nr, msg);
+}
+EXPORT_SYMBOL_GPL(edac_device_handle_ue_count);
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 1aaba74ae411..c8dc83eda64f 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -287,7 +287,7 @@ extern struct edac_device_ctl_info *edac_device_del_device(struct device *dev);
 
 /**
  * edac_device_handle_ue():
- *	perform a common output and handling of an 'edac_dev' UE event
+ *	perform a common output and handling of an 'edac_dev' single UE event
  *
  * @edac_dev: pointer to struct &edac_device_ctl_info
  * @inst_nr: number of the instance where the UE error happened
@@ -298,7 +298,7 @@ extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
 				int inst_nr, int block_nr, const char *msg);
 /**
  * edac_device_handle_ce():
- *	perform a common output and handling of an 'edac_dev' CE event
+ *	perform a common output and handling of an 'edac_dev' single CE event
  *
  * @edac_dev: pointer to struct &edac_device_ctl_info
  * @inst_nr: number of the instance where the CE error happened
@@ -308,6 +308,33 @@ extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
 extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
 				int inst_nr, int block_nr, const char *msg);
 
+/**
+ * edac_device_handle_ue_count():
+ *	perform a common output and handling of an 'edac_dev'
+ *
+ * @edac_dev: pointer to struct &edac_device_ctl_info
+ * @error_count: number of errors of the same type
+ * @inst_nr: number of the instance where the UE error happened
+ * @block_nr: number of the block where the UE error happened
+ * @msg: message to be printed
+ */
+extern void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
+					u16 error_count, int inst_nr,
+					int block_nr, const char *msg);
+/**
+ * edac_device_handle_ce_count():
+ *	perform a common output and handling of an 'edac_dev'
+ *
+ * @edac_dev: pointer to struct &edac_device_ctl_info
+ * @error_count: number of errors of the same type
+ * @inst_nr: number of the instance where the CE error happened
+ * @block_nr: number of the block where the CE error happened
+ * @msg: message to be printed
+ */
+extern void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
+					u16 error_count, int inst_nr,
+					int block_nr, const char *msg);
+
 /**
  * edac_device_alloc_index: Allocate a unique device index number
  *
-- 
2.17.1

