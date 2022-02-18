Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5494BB5D3
	for <lists+linux-edac@lfdr.de>; Fri, 18 Feb 2022 10:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiBRJmj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Feb 2022 04:42:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiBRJmi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 18 Feb 2022 04:42:38 -0500
Received: from spam.unicloud.com (gw.haihefund.cn [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52A022B0D;
        Fri, 18 Feb 2022 01:42:20 -0800 (PST)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 21I9f935052082;
        Fri, 18 Feb 2022 17:41:09 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from localhost.localdomain (10.10.1.7) by zgys-ex-mb09.Unicloud.com
 (10.10.0.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.17; Fri, 18
 Feb 2022 17:41:08 +0800
From:   luofei <luofei@unicloud.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <akpm@linux-foundation.org>,
        <naoya.horiguchi@nec.com>
CC:     <hpa@zytor.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        luofei <luofei@unicloud.com>
Subject: [PATCH v3 1/2] hw/poison: Avoid the impact of hwpoison_filter() return value on mce handler
Date:   Fri, 18 Feb 2022 04:40:56 -0500
Message-ID: <20220218094056.2056251-1-luofei@unicloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.10.1.7]
X-ClientProxiedBy: zgys-ex-mb10.Unicloud.com (10.10.0.6) To
 zgys-ex-mb09.Unicloud.com (10.10.0.24)
X-DNSRBL: 
X-MAIL: spam.unicloud.com 21I9f935052082
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
mce handler, but should return a value(-EHWPOISON), otherwise
mce handler regards the error page has been identified and
isolated, which may lead to calling set_mce_nospec() to change
page attribute, etc.

Here a new MF_MCE__HANDLE flag is introdulced to identify the
call from the mce handler and instruct hwpoison_filter() to
return -EHWPOISON, other return 0 for compatibility with the
hwpoison injector.

Signed-off-by: luofei <luofei@unicloud.com>
---
 arch/x86/kernel/cpu/mce/core.c | 15 +++++++++------
 include/linux/mm.h             |  1 +
 mm/memory-failure.c            | 14 ++++++++++++--
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b837fd4d..de29165c65b6 100644
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
@@ -1303,9 +1303,12 @@ static void kill_me_maybe(struct callback_head *cb)
 	}
 
 	/*
-	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
-	 * to the current process with the proper error info, so no need to
-	 * send SIGBUS here again.
+	 * -EHWPOISON from memory_failure() means that memory_failure() did
+	 * not handle the error event for the following reason:
+	 *  - SIGBUS has already been sent to the current process with the
+	 *    proper error info, or
+	 *  - hwpoison_filter() filtered the event,
+	 * so no need to deal with it more.
 	 */
 	if (ret == -EHWPOISON)
 		return;
@@ -1320,7 +1323,7 @@ static void kill_me_never(struct callback_head *cb)
 
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
index 97a9ed8f87a9..59d6d939a752 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1526,7 +1526,10 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 				if (TestClearPageHWPoison(head))
 					num_poisoned_pages_dec();
 				unlock_page(head);
-				return 0;
+				if (flags & MF_MCE_HANDLE)
+					return -EHWPOISON;
+				else
+					return 0;
 			}
 			unlock_page(head);
 			res = MF_FAILED;
@@ -1613,7 +1616,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		goto out;
 
 	if (hwpoison_filter(page)) {
-		rc = 0;
+		if (flags & MF_MCE_HANDLE)
+			rc = -EHWPOISON;
+		else
+			rc = 0;
 		goto unlock;
 	}
 
@@ -1837,6 +1843,10 @@ int memory_failure(unsigned long pfn, int flags)
 			num_poisoned_pages_dec();
 		unlock_page(p);
 		put_page(p);
+		if (flags & MF_MCE_HANDLE)
+			res = -EHWPOISON;
+		else
+			res = 0;
 		goto unlock_mutex;
 	}
 
-- 
2.27.0

