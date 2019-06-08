Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC1D3A22A
	for <lists+linux-edac@lfdr.de>; Sat,  8 Jun 2019 23:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfFHV3G (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 8 Jun 2019 17:29:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfFHV3G (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 8 Jun 2019 17:29:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x58LSw1n3145795
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 8 Jun 2019 14:28:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x58LSw1n3145795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560029339;
        bh=7rC3Q2ayfAyGL6lzPOoEQQ1AorBSQ9l3HZ0ycTpNTKI=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=l0mkrlzEK5BuDrCgS5eUl8O4AiWHf8JCnZHeF1mQ+OjLpbOAmKDbivNeewCxy8Z+g
         LO7KApOdOngl2IE9+l6xZI6vKS9mvibuntF4yu6yG6gzYj0a2Lc5WzPFC3TDxsvPFF
         n/pdkZVM2plUthWZGpzBnHKQjDJiICBYU+pPInqpN1IxdNtlRGHtXrqY5CLd2fORIC
         njr4apV5Ud04XFXNdUGsJ2bEaEwEI137uniMIuUekqsL8UCyi0FcRlC20E8Y/bgm+g
         ZxNHYdnHdJJjLwrgAbkZw7LiaYl3FjpgivybMdckAIJAu3y68/g4R08AKzxGBlVjW6
         NnHe0Jz56q5xw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x58LSwsK3145792;
        Sat, 8 Jun 2019 14:28:58 -0700
Date:   Sat, 8 Jun 2019 14:28:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-b8b5ca6600dec2a4f1e50ca9d3cf9e1d032870cd@git.kernel.org>
Cc:     tony.luck@intel.com, linux-edac@vger.kernel.org, bp@suse.de,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: linux-edac@vger.kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
          mingo@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS/CEC: Rename count_threshold to action_threshold
Git-Commit-ID: b8b5ca6600dec2a4f1e50ca9d3cf9e1d032870cd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Commit-ID:  b8b5ca6600dec2a4f1e50ca9d3cf9e1d032870cd
Gitweb:     https://git.kernel.org/tip/b8b5ca6600dec2a4f1e50ca9d3cf9e1d032870cd
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sat, 20 Apr 2019 21:30:11 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 8 Jun 2019 17:38:17 +0200

RAS/CEC: Rename count_threshold to action_threshold

... which is the better, more-fitting name anyway.

Tony:
 - make action_threshold u64 due to debugfs accessors expecting u64.
 - rename the remaining: s/count_threshold/action_threshold/g

Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/ras/cec.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index da5797c38051..364f7e1a6bad 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -37,9 +37,9 @@
  * thus emulate an an LRU-like behavior when deleting elements to free up space
  * in the page.
  *
- * When an element reaches it's max count of count_threshold, we try to poison
- * it by assuming that errors triggered count_threshold times in a single page
- * are excessive and that page shouldn't be used anymore. count_threshold is
+ * When an element reaches it's max count of action_threshold, we try to poison
+ * it by assuming that errors triggered action_threshold times in a single page
+ * are excessive and that page shouldn't be used anymore. action_threshold is
  * initialized to COUNT_MASK which is the maximum.
  *
  * That error event entry causes cec_add_elem() to return !0 value and thus
@@ -122,7 +122,7 @@ static DEFINE_MUTEX(ce_mutex);
 static u64 dfs_pfn;
 
 /* Amount of errors after which we offline */
-static unsigned int count_threshold = COUNT_MASK;
+static u64 action_threshold = COUNT_MASK;
 
 /* Each element "decays" each decay_interval which is 24hrs by default. */
 #define CEC_DECAY_DEFAULT_INTERVAL	24 * 60 * 60	/* 24 hrs */
@@ -345,7 +345,7 @@ int cec_add_elem(u64 pfn)
 
 	/* Check action threshold and soft-offline, if reached. */
 	count = COUNT(ca->array[to]);
-	if (count >= count_threshold) {
+	if (count >= action_threshold) {
 		u64 pfn = ca->array[to] >> PAGE_SHIFT;
 
 		if (!pfn_valid(pfn)) {
@@ -416,18 +416,18 @@ static int decay_interval_set(void *data, u64 val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(decay_interval_ops, u64_get, decay_interval_set, "%lld\n");
 
-static int count_threshold_set(void *data, u64 val)
+static int action_threshold_set(void *data, u64 val)
 {
 	*(u64 *)data = val;
 
 	if (val > COUNT_MASK)
 		val = COUNT_MASK;
 
-	count_threshold = val;
+	action_threshold = val;
 
 	return 0;
 }
-DEFINE_DEBUGFS_ATTRIBUTE(count_threshold_ops, u64_get, count_threshold_set, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(action_threshold_ops, u64_get, action_threshold_set, "%lld\n");
 
 static int array_dump(struct seq_file *m, void *v)
 {
@@ -453,7 +453,7 @@ static int array_dump(struct seq_file *m, void *v)
 	seq_printf(m, "Decay interval: %lld seconds\n", decay_interval);
 	seq_printf(m, "Decays: %lld\n", ca->decays_done);
 
-	seq_printf(m, "Action threshold: %d\n", count_threshold);
+	seq_printf(m, "Action threshold: %lld\n", action_threshold);
 
 	mutex_unlock(&ce_mutex);
 
@@ -502,10 +502,10 @@ static int __init create_debugfs_nodes(void)
 		goto err;
 	}
 
-	count = debugfs_create_file("count_threshold", S_IRUSR | S_IWUSR, d,
-				    &count_threshold, &count_threshold_ops);
+	count = debugfs_create_file("action_threshold", S_IRUSR | S_IWUSR, d,
+				    &action_threshold, &action_threshold_ops);
 	if (!count) {
-		pr_warn("Error creating count_threshold debugfs node!\n");
+		pr_warn("Error creating action_threshold debugfs node!\n");
 		goto err;
 	}
 
