Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD0B4B9649
	for <lists+linux-edac@lfdr.de>; Thu, 17 Feb 2022 04:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiBQDDm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Feb 2022 22:03:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiBQDDm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Feb 2022 22:03:42 -0500
Received: from spam.unicloud.com (mx.uniclinxens.com [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADAD225D31;
        Wed, 16 Feb 2022 19:03:26 -0800 (PST)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 21H30oTu032234;
        Thu, 17 Feb 2022 11:00:50 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from localhost.localdomain (10.10.1.7) by zgys-ex-mb09.Unicloud.com
 (10.10.0.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.17; Thu, 17
 Feb 2022 11:00:49 +0800
From:   luofei <luofei@unicloud.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <akpm@linux-foundation.org>,
        <naoya.horiguchi@nec.com>
CC:     <hpa@zytor.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        luofei <luofei@unicloud.com>
Subject: [PATCH v2] hw/poison: Add in-use hugepage filter judgement and avoid filter page impact on mce handler
Date:   Wed, 16 Feb 2022 22:00:38 -0500
Message-ID: <20220217030038.1552124-1-luofei@unicloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.10.1.7]
X-ClientProxiedBy: zgys-ex-mb11.Unicloud.com (10.10.0.28) To
 zgys-ex-mb09.Unicloud.com (10.10.0.24)
X-DNSRBL: 
X-MAIL: spam.unicloud.com 21H30oTu032234
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

After successfully obtaining the reference count of the huge
page, it is still necessary to call hwpoison_filter() to make a
filter judgement, otherwise the filter hugepage will be unmaped
and the related process may be killed.

Also when the huge page meets the filter conditions, it should
not be regarded as successful memory_failure() processing for
mce handler, but should return a value to inform the caller,
otherwise the caller regards the error page has been identified
and isolated, which may lead to calling set_mce_nospec() to change
page attribute, etc.

Signed-off-by: luofei <luofei@unicloud.com>
---
 arch/x86/kernel/cpu/mce/core.c | 22 +++++++++++-----------
 include/linux/mm.h             |  1 +
 mm/memory-failure.c            | 25 +++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b837fd4d..c2b99c60225f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -612,7 +612,7 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 		return NOTIFY_DONE;
 
 	pfn = mce->addr >> PAGE_SHIFT;
-	if (!memory_failure(pfn, 0)) {
+	if (!memory_failure(pfn, MF_MCE_HANDLE)) {
 		set_mce_nospec(pfn, whole_page(mce));
 		mce->kflags |= MCE_HANDLED_UC;
 	}
@@ -1286,7 +1286,7 @@ static void kill_me_now(struct callback_head *ch)
 static void kill_me_maybe(struct callback_head *cb)
 {
 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
-	int flags = MF_ACTION_REQUIRED;
+	int flags = MF_ACTION_REQUIRED | MF_MCE_HANDLE;
 	int ret;
 
 	p->mce_count = 0;
@@ -1300,14 +1300,14 @@ static void kill_me_maybe(struct callback_head *cb)
 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 		sync_core();
 		return;
-	}
-
-	/*
-	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
-	 * to the current process with the proper error info, so no need to
-	 * send SIGBUS here again.
-	 */
-	if (ret == -EHWPOISON)
+	} else if (ret == -EHWPOISON || ret == 1)
+		/*
+		 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
+		 * to the current process with the proper error info, so no need to
+		 * send SIGBUS here again.
+		 *
+		 * 1 means it's a filter page, no need to deal with.
+		 */
 		return;
 
 	pr_err("Memory error not recovered");
@@ -1320,7 +1320,7 @@ static void kill_me_never(struct callback_head *cb)
 
 	p->mce_count = 0;
 	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
-	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, 0))
+	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, MF_MCE_HANDLE))
 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b192..f4703f948e9a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3188,6 +3188,7 @@ enum mf_flags {
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
 	MF_UNPOISON = 1 << 4,
+	MF_MCE_HANDLE = 1 << 5,
 };
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 97a9ed8f87a9..1a0bd91a685b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1526,7 +1526,10 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 				if (TestClearPageHWPoison(head))
 					num_poisoned_pages_dec();
 				unlock_page(head);
-				return 0;
+				if (flags & MF_MCE_HANDLE)
+					return 1;
+				else
+					return 0;
 			}
 			unlock_page(head);
 			res = MF_FAILED;
@@ -1545,6 +1548,17 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	lock_page(head);
 	page_flags = head->flags;
 
+	if (hwpoison_filter(p)) {
+		if (TestClearPageHWPoison(head))
+			num_poisoned_pages_dec();
+		put_page(p);
+		if (flags & MF_MCE_HANDLE)
+			res = 1;
+		else
+			res = 0;
+		goto out;
+	}
+
 	/*
 	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
 	 * simply disable it. In order to make it work properly, we need
@@ -1613,7 +1627,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		goto out;
 
 	if (hwpoison_filter(page)) {
-		rc = 0;
+		if (flags & MF_MCE_HANDLE)
+			rc = 1;
+		else
+			rc = 0;
 		goto unlock;
 	}
 
@@ -1837,6 +1854,10 @@ int memory_failure(unsigned long pfn, int flags)
 			num_poisoned_pages_dec();
 		unlock_page(p);
 		put_page(p);
+		if (flags & MF_MCE_HANDLE)
+			res = 1;
+		else
+			res = 0;
 		goto unlock_mutex;
 	}
 
-- 
2.27.0

