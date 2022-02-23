Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595FD4C0E2D
	for <lists+linux-edac@lfdr.de>; Wed, 23 Feb 2022 09:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbiBWIZB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Feb 2022 03:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiBWIZB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Feb 2022 03:25:01 -0500
Received: from spam.unicloud.com (eage.unicloud.com [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87C65A5A5;
        Wed, 23 Feb 2022 00:24:32 -0800 (PST)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 21N8Lh1l031001;
        Wed, 23 Feb 2022 16:21:43 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from localhost.localdomain (10.10.1.7) by zgys-ex-mb09.Unicloud.com
 (10.10.0.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.17; Wed, 23
 Feb 2022 16:21:42 +0800
From:   luofei <luofei@unicloud.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <naoya.horiguchi@nec.com>,
        <akpm@linux-foundation.org>
CC:     <hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, luofei <luofei@unicloud.com>
Subject: [PATCH v5 1/2] mm/hwpoison: Avoid the impact of hwpoison_filter() return value on mce handler
Date:   Wed, 23 Feb 2022 03:21:35 -0500
Message-ID: <20220223082135.2769649-1-luofei@unicloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.10.1.7]
X-ClientProxiedBy: zgys-ex-mb08.Unicloud.com (10.10.0.14) To
 zgys-ex-mb09.Unicloud.com (10.10.0.24)
X-DNSRBL: 
X-MAIL: spam.unicloud.com 21N8Lh1l031001
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When the hwpoison page meets the filter conditions, it should
not be regarded as successful memory_failure() processing for
mce handler, but should return a distinct value, otherwise
mce handler regards the error page has been identified and
isolated, which may lead to calling set_mce_nospec() to change
page attribute, etc.

Here memory_failure() return -EOPNOTSUPP to indicate that the
error event is filtered, mce handler should not take any action
for this situation and hwpoison injector should treat as correct.

Signed-off-by: luofei <luofei@unicloud.com>
---
 arch/x86/kernel/cpu/mce/core.c | 8 +++++---
 drivers/base/memory.c          | 2 ++
 mm/hwpoison-inject.c           | 3 ++-
 mm/madvise.c                   | 2 ++
 mm/memory-failure.c            | 9 +++++++--
 5 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 728f3b36ce2d..f4b56904db8a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1332,10 +1332,12 @@ static void kill_me_maybe(struct callback_head *cb)
 
 	/*
 	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
-	 * to the current process with the proper error info, so no need to
-	 * send SIGBUS here again.
+	 * to the current process with the proper error info,
+	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
+	 *
+	 * In both cases, no further processing is required.
 	 */
-	if (ret == -EHWPOISON)
+	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
 		return;
 
 	pr_err("Memory error not recovered");
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 365cd4a7f239..abf407e45467 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -555,6 +555,8 @@ static ssize_t hard_offline_page_store(struct device *dev,
 		return -EINVAL;
 	pfn >>= PAGE_SHIFT;
 	ret = memory_failure(pfn, 0);
+	if (ret == -EOPNOTSUPP)
+		ret = 0;
 	return ret ? ret : count;
 }
 
diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index aff4d27ec235..a1d6fc3c78b9 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -48,7 +48,8 @@ static int hwpoison_inject(void *data, u64 val)
 
 inject:
 	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
-	return memory_failure(pfn, 0);
+	err = memory_failure(pfn, 0);
+	return (err == -EOPNOTSUPP) ? 0 : err;
 }
 
 static int hwpoison_unpoison(void *data, u64 val)
diff --git a/mm/madvise.c b/mm/madvise.c
index ae35d72627ef..e7cb7a0751d6 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1096,6 +1096,8 @@ static int madvise_inject_error(int behavior,
 			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
 			ret = memory_failure(pfn, MF_COUNT_INCREASED);
+			if (ret == -EOPNOTSUPP)
+				ret = 0;
 		}
 
 		if (ret)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 662afe7b514f..7e16d31df0f3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1528,7 +1528,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 				if (TestClearPageHWPoison(head))
 					num_poisoned_pages_dec();
 				unlock_page(head);
-				return 0;
+				return -EOPNOTSUPP;
 			}
 			unlock_page(head);
 			res = MF_FAILED;
@@ -1615,7 +1615,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		goto out;
 
 	if (hwpoison_filter(page)) {
-		rc = 0;
+		rc = -EOPNOTSUPP;
 		goto unlock;
 	}
 
@@ -1688,6 +1688,10 @@ static DEFINE_MUTEX(mf_mutex);
  *
  * Must run in process context (e.g. a work queue) with interrupts
  * enabled and no spinlocks hold.
+ *
+ * Return: 0 for successfully handled the memory error,
+ *         -EOPNOTSUPP for memory_filter() filtered the error event,
+ *         < 0(except -EOPNOTSUPP) on failure.
  */
 int memory_failure(unsigned long pfn, int flags)
 {
@@ -1843,6 +1847,7 @@ int memory_failure(unsigned long pfn, int flags)
 			num_poisoned_pages_dec();
 		unlock_page(p);
 		put_page(p);
+		res = -EOPNOTSUPP;
 		goto unlock_mutex;
 	}
 
-- 
2.27.0

