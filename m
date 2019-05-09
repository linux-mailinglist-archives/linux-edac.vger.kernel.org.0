Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA4A18FEF
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 20:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfEISJk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 14:09:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37022 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfEISJk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 May 2019 14:09:40 -0400
Received: from zn.tnic (p200300EC2F0F5F0071783F241746291C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:7178:3f24:1746:291c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E53C31EC0AE4;
        Thu,  9 May 2019 20:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557425379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DDbdI1Xv5E0wL2q6g9rFaPnlpU1Wj0FKYyRPwdVhOOw=;
        b=BuWO1rZdfzNmJgoDbpJJVjHE9yUXAfI9nWcCL9MtJF25EWAdFGzdzqWx3NrRh7cZlCul77
        2VhFwe+/YTps7VcIX0djw+c0YYkffuLmSVUwnoY2IR0fJWjp+2zuRTo+ItIxs2vPO8zw+t
        kWi2GPMtLZW/cgs9aUvjGohW22tD6CE=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/11] RAS/CEC: Rename count_threshold to action_threshold
Date:   Thu,  9 May 2019 20:09:23 +0200
Message-Id: <20190509180926.31932-9-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509180926.31932-1-bp@alien8.de>
References: <20190509180926.31932-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

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
index 2c92a70fa2f0..1cbc1ed82afe 100644
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
 DEFINE_DEBUGFS_ATTRIBUTE(decay_interval_ops, pfn_get, decay_interval_set, "%lld\n");
 
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
-DEFINE_DEBUGFS_ATTRIBUTE(count_threshold_ops, pfn_get, count_threshold_set, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(action_threshold_ops, pfn_get, action_threshold_set, "%lld\n");
 
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
 
-- 
2.21.0

