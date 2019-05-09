Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA5418FFE
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 20:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfEISJf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 14:09:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36964 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfEISJe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 May 2019 14:09:34 -0400
Received: from zn.tnic (p200300EC2F0F5F0071783F241746291C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:7178:3f24:1746:291c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 103FC1EC0B5A;
        Thu,  9 May 2019 20:09:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557425373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UEXWg2URSKnWXuSJJUpT1EWR6AmDhcNd64KRaHH2jHw=;
        b=Emld8reuLmtKbRjyo9ql6Sr9lWXJv1runSwtI4sDUDYwgUEniLpUEgI1zE0gZsx3byYjee
        SlZvFhHxcWZ3azxMbaDViLO2XhvXTYOoOEDeHKMKl/7zHyJ4TOrYmgPvUAudhHmJNLlxsG
        C7o8ASnoaYhxg9+c55SeSYacmOgyoMU=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/11] RAS/CEC: Convert the timer callback to a workqueue
Date:   Thu,  9 May 2019 20:09:17 +0200
Message-Id: <20190509180926.31932-3-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509180926.31932-1-bp@alien8.de>
References: <20190509180926.31932-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

cec_timer_fn() is a timer callback which reads ce_arr.array[] and
updates its decay values. However, it runs in interrupt context and the
mutex protection the CEC uses for that array, is inadequate. Convert the
used timer to a workqueue to keep the tasks the CEC performs preemptible
and thus low-prio.

 [ bp: Rewrite commit message.
   s/timer/decay/gi to make it agnostic as to what facility is used. ]

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20190416213351.28999-2-xiyou.wangcong@gmail.com
---
 drivers/ras/cec.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index dbfe3e61d2c2..673f8a128397 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -2,6 +2,7 @@
 #include <linux/mm.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
+#include <linux/workqueue.h>
 
 #include <asm/mce.h>
 
@@ -123,16 +124,12 @@ static u64 dfs_pfn;
 /* Amount of errors after which we offline */
 static unsigned int count_threshold = COUNT_MASK;
 
-/*
- * The timer "decays" element count each timer_interval which is 24hrs by
- * default.
- */
-
-#define CEC_TIMER_DEFAULT_INTERVAL	24 * 60 * 60	/* 24 hrs */
-#define CEC_TIMER_MIN_INTERVAL		 1 * 60 * 60	/* 1h */
-#define CEC_TIMER_MAX_INTERVAL	   30 *	24 * 60 * 60	/* one month */
-static struct timer_list cec_timer;
-static u64 timer_interval = CEC_TIMER_DEFAULT_INTERVAL;
+/* Each element "decays" each decay_interval which is 24hrs by default. */
+#define CEC_DECAY_DEFAULT_INTERVAL	24 * 60 * 60	/* 24 hrs */
+#define CEC_DECAY_MIN_INTERVAL		 1 * 60 * 60	/* 1h */
+#define CEC_DECAY_MAX_INTERVAL	   30 *	24 * 60 * 60	/* one month */
+static struct delayed_work cec_work;
+static u64 decay_interval = CEC_DECAY_DEFAULT_INTERVAL;
 
 /*
  * Decrement decay value. We're using DECAY_BITS bits to denote decay of an
@@ -160,20 +157,21 @@ static void do_spring_cleaning(struct ce_array *ca)
 /*
  * @interval in seconds
  */
-static void cec_mod_timer(struct timer_list *t, unsigned long interval)
+static void cec_mod_work(unsigned long interval)
 {
 	unsigned long iv;
 
-	iv = interval * HZ + jiffies;
-
-	mod_timer(t, round_jiffies(iv));
+	iv = interval * HZ;
+	mod_delayed_work(system_wq, &cec_work, round_jiffies(iv));
 }
 
-static void cec_timer_fn(struct timer_list *unused)
+static void cec_work_fn(struct work_struct *work)
 {
+	mutex_lock(&ce_mutex);
 	do_spring_cleaning(&ce_arr);
+	mutex_unlock(&ce_mutex);
 
-	cec_mod_timer(&cec_timer, timer_interval);
+	cec_mod_work(decay_interval);
 }
 
 /*
@@ -380,15 +378,15 @@ static int decay_interval_set(void *data, u64 val)
 {
 	*(u64 *)data = val;
 
-	if (val < CEC_TIMER_MIN_INTERVAL)
+	if (val < CEC_DECAY_MIN_INTERVAL)
 		return -EINVAL;
 
-	if (val > CEC_TIMER_MAX_INTERVAL)
+	if (val > CEC_DECAY_MAX_INTERVAL)
 		return -EINVAL;
 
-	timer_interval = val;
+	decay_interval = val;
 
-	cec_mod_timer(&cec_timer, timer_interval);
+	cec_mod_work(decay_interval);
 	return 0;
 }
 DEFINE_DEBUGFS_ATTRIBUTE(decay_interval_ops, u64_get, decay_interval_set, "%lld\n");
@@ -432,7 +430,7 @@ static int array_dump(struct seq_file *m, void *v)
 
 	seq_printf(m, "Flags: 0x%x\n", ca->flags);
 
-	seq_printf(m, "Timer interval: %lld seconds\n", timer_interval);
+	seq_printf(m, "Decay interval: %lld seconds\n", decay_interval);
 	seq_printf(m, "Decays: %lld\n", ca->decays_done);
 
 	seq_printf(m, "Action threshold: %d\n", count_threshold);
@@ -478,7 +476,7 @@ static int __init create_debugfs_nodes(void)
 	}
 
 	decay = debugfs_create_file("decay_interval", S_IRUSR | S_IWUSR, d,
-				    &timer_interval, &decay_interval_ops);
+				    &decay_interval, &decay_interval_ops);
 	if (!decay) {
 		pr_warn("Error creating decay_interval debugfs node!\n");
 		goto err;
@@ -514,8 +512,8 @@ void __init cec_init(void)
 	if (create_debugfs_nodes())
 		return;
 
-	timer_setup(&cec_timer, cec_timer_fn, 0);
-	cec_mod_timer(&cec_timer, CEC_TIMER_DEFAULT_INTERVAL);
+	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
+	schedule_delayed_work(&cec_work, CEC_DECAY_DEFAULT_INTERVAL);
 
 	pr_info("Correctable Errors collector initialized.\n");
 }
-- 
2.21.0

