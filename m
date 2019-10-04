Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 123F4CC120
	for <lists+linux-edac@lfdr.de>; Fri,  4 Oct 2019 18:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfJDQ5H (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Oct 2019 12:57:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40114 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfJDQ5H (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 4 Oct 2019 12:57:07 -0400
Received: from zn.tnic (p200300EC2F0C7700D5F6910340328F8F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:d5f6:9103:4032:8f8f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92EC71EC0626;
        Fri,  4 Oct 2019 18:57:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570208225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=h+0mivdjgezbd+ZZJIetcbwxDfHWLnjVmNKjpWtjkgY=;
        b=AuUusN/7O6GlZJUNpEXx61THkrq/YEpn0/jbbGjeJTC411HQYMp6mDxR/QV9wXMt9LGHbi
        E1rRd09BijI+dl/wrpmakX/7mcwtRjfvAHp2y6krXK27F6nRCU9s1ZpQXBjK58qHtbY4A8
        SOYODxCpTLY2vTJJpwzuFHf+DPiPjNA=
Date:   Fri, 4 Oct 2019 18:57:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Hawa, Hanna" <hhhawa@amazon.com>
Cc:     mchehab@kernel.org, james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com
Subject: [PATCH -v2] EDAC/device: Rework error logging API
Message-ID: <20191004165700.GB3362@zn.tnic>
References: <20190923191741.29322-1-hhhawa@amazon.com>
 <20190923191741.29322-2-hhhawa@amazon.com>
 <20190930145046.GH29694@zn.tnic>
 <5263edad-e0c9-a05a-72d7-e69c59d78d8f@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5263edad-e0c9-a05a-72d7-e69c59d78d8f@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 02, 2019 at 12:25:55PM +0300, Hawa, Hanna wrote:
> Missing count check, same in *_ue_count():
> if (count)

I think you meant:

	if (!count)

Anyway, fixed:

---
From 0e49a27859b947d2abded91ee3558639bf8ec0bd Mon Sep 17 00:00:00 2001
From: Hanna Hawa <hhhawa@amazon.com>
Date: Mon, 23 Sep 2019 20:17:40 +0100
Subject: [PATCH] EDAC/device: Rework error logging API

Make the main workhorse the "count" functions which can log a @count
of errors. Have the current APIs edac_device_handle_{ce,ue}() call
the _count() variants and this way keep the exported symbols number
unchanged.

 [ bp: Rewrite. ]

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: benh@amazon.com
Cc: dwmw@amazon.co.uk
Cc: hanochu@amazon.com
Cc: James Morse <james.morse@arm.com>
Cc: jonnyc@amazon.com
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: ronenk@amazon.com
Cc: talel@amazon.com
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20190923191741.29322-2-hhhawa@amazon.com
---
 drivers/edac/edac_device.c | 50 ++++++++++++++++++++---------------
 drivers/edac/edac_device.h | 54 ++++++++++++++++++++++++++++++--------
 2 files changed, 72 insertions(+), 32 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 65cf2b9355c4..8c4d947fb848 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -555,12 +555,16 @@ static inline int edac_device_get_panic_on_ue(struct edac_device_ctl_info
 	return edac_dev->panic_on_ue;
 }
 
-void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
-			int inst_nr, int block_nr, const char *msg)
+void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
+				 unsigned int count, int inst_nr, int block_nr,
+				 const char *msg)
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
+EXPORT_SYMBOL_GPL(edac_device_handle_ce_count);
 
-void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
-			int inst_nr, int block_nr, const char *msg)
+void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
+				 unsigned int count, int inst_nr, int block_nr,
+				 const char *msg)
 {
 	struct edac_device_instance *instance;
 	struct edac_device_block *block = NULL;
 
+	if (!count)
+		return;
+
 	if ((inst_nr >= edac_dev->nr_instances) || (inst_nr < 0)) {
 		edac_device_printk(edac_dev, KERN_ERR,
 				"INTERNAL ERROR: 'instance' out of range "
@@ -624,22 +632,22 @@ void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
 
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
 }
-EXPORT_SYMBOL_GPL(edac_device_handle_ue);
+EXPORT_SYMBOL_GPL(edac_device_handle_ue_count);
diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 1aaba74ae411..c4c0e0bdce14 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -286,27 +286,60 @@ extern int edac_device_add_device(struct edac_device_ctl_info *edac_dev);
 extern struct edac_device_ctl_info *edac_device_del_device(struct device *dev);
 
 /**
- * edac_device_handle_ue():
- *	perform a common output and handling of an 'edac_dev' UE event
+ * Log correctable errors.
  *
  * @edac_dev: pointer to struct &edac_device_ctl_info
- * @inst_nr: number of the instance where the UE error happened
- * @block_nr: number of the block where the UE error happened
+ * @inst_nr: number of the instance where the CE error happened
+ * @count: Number of errors to log.
+ * @block_nr: number of the block where the CE error happened
+ * @msg: message to be printed
+ */
+void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
+				 unsigned int count, int inst_nr, int block_nr,
+				 const char *msg);
+
+/**
+ * Log uncorrectable errors.
+ *
+ * @edac_dev: pointer to struct &edac_device_ctl_info
+ * @inst_nr: number of the instance where the CE error happened
+ * @count: Number of errors to log.
+ * @block_nr: number of the block where the CE error happened
  * @msg: message to be printed
  */
-extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
-				int inst_nr, int block_nr, const char *msg);
+void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
+				 unsigned int count, int inst_nr, int block_nr,
+				 const char *msg);
+
 /**
- * edac_device_handle_ce():
- *	perform a common output and handling of an 'edac_dev' CE event
+ * edac_device_handle_ce(): Log a single correctable error
  *
  * @edac_dev: pointer to struct &edac_device_ctl_info
  * @inst_nr: number of the instance where the CE error happened
  * @block_nr: number of the block where the CE error happened
  * @msg: message to be printed
  */
-extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
-				int inst_nr, int block_nr, const char *msg);
+static inline void
+edac_device_handle_ce(struct edac_device_ctl_info *edac_dev, int inst_nr,
+		      int block_nr, const char *msg)
+{
+	edac_device_handle_ce_count(edac_dev, 1, inst_nr, block_nr, msg);
+}
+
+/**
+ * edac_device_handle_ue(): Log a single uncorrectable error
+ *
+ * @edac_dev: pointer to struct &edac_device_ctl_info
+ * @inst_nr: number of the instance where the UE error happened
+ * @block_nr: number of the block where the UE error happened
+ * @msg: message to be printed
+ */
+static inline void
+edac_device_handle_ue(struct edac_device_ctl_info *edac_dev, int inst_nr,
+		      int block_nr, const char *msg)
+{
+	edac_device_handle_ue_count(edac_dev, 1, inst_nr, block_nr, msg);
+}
 
 /**
  * edac_device_alloc_index: Allocate a unique device index number
@@ -316,5 +349,4 @@ extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
  */
 extern int edac_device_alloc_index(void);
 extern const char *edac_layer_name[];
-
 #endif
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
