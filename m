Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B22B118B
	for <lists+linux-edac@lfdr.de>; Thu, 12 Sep 2019 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbfILOyT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Sep 2019 10:54:19 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:41147 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732808AbfILOyT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 Sep 2019 10:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568300057; x=1599836057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tVhsKWdad/ZsldeXHdaQNlIf/wo05howUqR6U3Hiavc=;
  b=KcJcUbP85ZxqDRDIazrHjJoRIVssprhZDYbcZ9acaZKIiWL1Swq8INfS
   x45udMjr9V4xNm3QTMd8bElWcmOTRSh0qBDknwxwT68lMUWbqWp5Rzxl6
   e4oCtLoYCumFMVCLrBWr7YJ5SXIJgzAYgBt8wIlrpeQF2bhc0DDCiBXy/
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="414933583"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Sep 2019 14:54:17 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id B30591417C3;
        Thu, 12 Sep 2019 14:54:15 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 14:54:14 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.161.99) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 14:54:08 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <james.morse@arm.com>,
        <rrichter@marvell.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <hhhawa@amazon.com>
Subject: [PATCH v2 1/2] edac: Add an API for edac device to report for multiple errors
Date:   Thu, 12 Sep 2019 15:53:04 +0100
Message-ID: <20190912145305.21008-2-hhhawa@amazon.com>
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

Add an API for EDAC device to report multiple errors with same type.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/edac/edac_device.c | 91 ++++++++++++++++++++++++++++++++++++++
 drivers/edac/edac_device.h | 40 +++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 65cf2b9355c4..78ac44103acc 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -643,3 +643,94 @@ void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
 			block ? block->name : "N/A", msg);
 }
 EXPORT_SYMBOL_GPL(edac_device_handle_ue);
+
+void __edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
+			     unsigned int count, int inst_nr, int block_nr,
+			     const char *msg)
+{
+	struct edac_device_instance *instance;
+	struct edac_device_block *block = NULL;
+
+	if (!count)
+		return;
+
+	if ((inst_nr >= edac_dev->nr_instances) || (inst_nr < 0)) {
+		edac_device_printk(edac_dev, KERN_ERR,
+				   "INTERNAL ERROR: 'instance' out of range (%d >= %d)\n",
+				   inst_nr, edac_dev->nr_instances);
+		return;
+	}
+
+	instance = edac_dev->instances + inst_nr;
+
+	if ((block_nr >= instance->nr_blocks) || (block_nr < 0)) {
+		edac_device_printk(edac_dev, KERN_ERR,
+				"INTERNAL ERROR: instance %d 'block' out of range (%d >= %d)\n",
+				inst_nr, block_nr, instance->nr_blocks);
+		return;
+	}
+
+	if (instance->nr_blocks > 0) {
+		block = instance->blocks + block_nr;
+		block->counters.ce_count += count;
+	}
+
+	/* Propagate the count up the 'totals' tree */
+	instance->counters.ce_count += count;
+	edac_dev->counters.ce_count += count;
+
+	if (edac_device_get_log_ce(edac_dev))
+		edac_device_printk(edac_dev, KERN_WARNING,
+				   "CE: %s instance: %s block: %s count: %d '%s'\n",
+				   edac_dev->ctl_name, instance->name,
+				   block ? block->name : "N/A", count, msg);
+}
+EXPORT_SYMBOL_GPL(__edac_device_handle_ce);
+
+void __edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
+			     unsigned int count, int inst_nr, int block_nr,
+			     const char *msg)
+{
+	struct edac_device_instance *instance;
+	struct edac_device_block *block = NULL;
+
+	if (!count)
+		return;
+
+	if ((inst_nr >= edac_dev->nr_instances) || (inst_nr < 0)) {
+		edac_device_printk(edac_dev, KERN_ERR,
+				   "INTERNAL ERROR: 'instance' out of range (%d >= %d)\n",
+				   inst_nr, edac_dev->nr_instances);
+		return;
+	}
+
+	instance = edac_dev->instances + inst_nr;
+
+	if ((block_nr >= instance->nr_blocks) || (block_nr < 0)) {
+		edac_device_printk(edac_dev, KERN_ERR,
+				   "INTERNAL ERROR: instance %d 'block' out of range (%d >= %d)\n",
+				   inst_nr, block_nr, instance->nr_blocks);
+		return;
+	}
+
+	if (instance->nr_blocks > 0) {
+		block = instance->blocks + block_nr;
+		block->counters.ue_count += count;
+	}
+
+	/* Propagate the count up the 'totals' tree */
+	instance->counters.ue_count += count;
+	edac_dev->counters.ue_count += count;
+
+	if (edac_device_get_log_ue(edac_dev))
+		edac_device_printk(edac_dev, KERN_EMERG,
+				   "UE: %s instance: %s block: %s count: %d '%s'\n",
+				   edac_dev->ctl_name, instance->name,
+				   block ? block->name : "N/A", count, msg);
+
+	if (edac_device_get_panic_on_ue(edac_dev))
+		panic("EDAC %s: UE instance: %s block %s count: %d '%s'\n",
+		      edac_dev->ctl_name, instance->name,
+		      block ? block->name : "N/A", count, msg);
+}
+EXPORT_SYMBOL_GPL(__edac_device_handle_ue);
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

