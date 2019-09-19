Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4F46B7FD6
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2019 19:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388943AbfISRRy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Sep 2019 13:17:54 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:37576 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391937AbfISRRx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 Sep 2019 13:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568913473; x=1600449473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=loeOa3WFH7vmFHgR6vpCfr/3FKy/37GuGu18rh4N9I0=;
  b=dp8I0SBxUi5+2QrJicTxeCG8nOo7kPpokZlUMtKPcseeEqDLa3t2mw3c
   MyZtrgXMtr9hMuALTYgEtRWK2YE7Cg8zj2DLQeUGhH8ej3yi7vgG4Lcjx
   4wveRkiEGeKBDUH0AhIm/bDtJf+3UHWwzeeZZZwgA+6cUunMCoER2MgQD
   U=;
X-IronPort-AV: E=Sophos;i="5.64,524,1559520000"; 
   d="scan'208";a="751654705"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 19 Sep 2019 17:17:43 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 919BEA21B6;
        Thu, 19 Sep 2019 17:17:41 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 19 Sep 2019 17:17:40 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.160.5) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 19 Sep 2019 17:17:34 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>,
        <rrichter@marvell.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <hhhawa@amazon.com>
Subject: [PATCH v3 1/2] edac: Add an API for edac device to report for multiple errors
Date:   Thu, 19 Sep 2019 18:17:12 +0100
Message-ID: <20190919171713.8060-2-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919171713.8060-1-hhhawa@amazon.com>
References: <20190919171713.8060-1-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.5]
X-ClientProxiedBy: EX13D06UWC002.ant.amazon.com (10.43.162.205) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add an API for EDAC device to report multiple errors with same type.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/edac/edac_device.c | 62 ++++++++++++++++++++++++++------------
 drivers/edac/edac_device.h | 40 ++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 20 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 65cf2b9355c4..866934f2bcb0 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -555,12 +555,16 @@ static inline int edac_device_get_panic_on_ue(struct edac_device_ctl_info
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
 
+	if (!count)
+		return;
+
 	if ((inst_nr >= edac_dev->nr_instances) || (inst_nr < 0)) {
 		edac_device_printk(edac_dev, KERN_ERR,
 				"INTERNAL ERROR: 'instance' out of range "
@@ -582,27 +586,31 @@ void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
 
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
 
+	if (!count)
+		return;
+
 	if ((inst_nr >= edac_dev->nr_instances) || (inst_nr < 0)) {
 		edac_device_printk(edac_dev, KERN_ERR,
 				"INTERNAL ERROR: 'instance' out of range "
@@ -624,22 +632,36 @@ void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
 
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
index 1aaba74ae411..30dc5f5979c8 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -317,4 +317,44 @@ extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
 extern int edac_device_alloc_index(void);
 extern const char *edac_layer_name[];
 
+/**
+ * __edac_device_handle_ue():
+ *	perform a common output and handling of an 'edac_dev' UE event
+ *
+ * @edac_dev: pointer to struct &edac_device_ctl_info
+ * @error_count: number of errors of the same type
+ * @inst_nr: number of the instance where the UE error happened
+ * @block_nr: number of the block where the UE error happened
+ * @msg: message to be printed
+ */
+void __edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
+				    unsigned int count, int inst_nr,
+				    int block_nr, const char *msg);
+/**
+ * __edac_device_handle_ce():
+ *	perform a common output and handling of an 'edac_dev' CE event
+ *
+ * @edac_dev: pointer to struct &edac_device_ctl_info
+ * @error_count: number of errors of the same type
+ * @inst_nr: number of the instance where the CE error happened
+ * @block_nr: number of the block where the CE error happened
+ * @msg: message to be printed
+ */
+void __edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
+				    unsigned int count, int inst_nr,
+				    int block_nr, const char *msg);
+
+static inline void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
+					       unsigned int count, int inst_nr,
+					       int block_nr, const char *msg)
+{
+	__edac_device_handle_ce(edac_dev, count, inst_nr, block_nr, msg);
+}
+
+static inline void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
+					       unsigned int count, int inst_nr,
+					       int block_nr, const char *msg)
+{
+	__edac_device_handle_ue(edac_dev, count, inst_nr, block_nr, msg);
+}
 #endif
-- 
2.17.1

