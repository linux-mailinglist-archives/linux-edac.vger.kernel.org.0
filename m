Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A72C239F
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2019 16:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfI3Ous (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 Sep 2019 10:50:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35672 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730809AbfI3Ous (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 30 Sep 2019 10:50:48 -0400
Received: from zn.tnic (p200300EC2F058B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:8b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BCE911EC0982;
        Mon, 30 Sep 2019 16:50:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569855047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FnN7DQgxKKbUVQ9VZB4DQm/rTtWbZxtoBke2HT0KdQM=;
        b=Xg7DnbNBRHFAyGpxCZbCd8drgk71sTW7EWTmw3LkaztKE6ifraZjIrc714wogsQleVMzyr
        FxUmaVwUGve4IAysmE1lPrlqpfU/Oi5oFvE90FSpNkyfuYqFYZ7auULxKmmdFwldZTXYQd
        0lcCMnhKN+o07QViVoIzfaCqork/P/I=
Date:   Mon, 30 Sep 2019 16:50:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     mchehab@kernel.org, james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com
Subject: Re: [PATCH v4 1/2] edac: Add an API for edac device to report for
 multiple errors
Message-ID: <20190930145046.GH29694@zn.tnic>
References: <20190923191741.29322-1-hhhawa@amazon.com>
 <20190923191741.29322-2-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190923191741.29322-2-hhhawa@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 23, 2019 at 08:17:40PM +0100, Hanna Hawa wrote:
> +void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> +			int inst_nr, int block_nr, const char *msg)
> +{
> +	__edac_device_handle_ce(edac_dev, 1, inst_nr, block_nr, msg);
> +}
> +EXPORT_SYMBOL_GPL(edac_device_handle_ce);

Eww, I don't like that: exporting the function *and* the __ counterpart.
The user will get confused and that is unnecessary.

See below for a better version. This way you solve the whole deal with a
single patch.

---
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
 drivers/edac/edac_device.c | 44 ++++++++++++++++---------------
 drivers/edac/edac_device.h | 54 ++++++++++++++++++++++++++++++--------
 2 files changed, 66 insertions(+), 32 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 65cf2b9355c4..d4d8bed5b55d 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -555,8 +555,9 @@ static inline int edac_device_get_panic_on_ue(struct edac_device_ctl_info
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
+EXPORT_SYMBOL_GPL(edac_device_handle_ce_count);
 
-void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
-			int inst_nr, int block_nr, const char *msg)
+void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
+				 unsigned int count, int inst_nr, int block_nr,
+				 const char *msg)
 {
 	struct edac_device_instance *instance;
 	struct edac_device_block *block = NULL;
@@ -624,22 +626,22 @@ void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
 
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
