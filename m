Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B7D2F2215
	for <lists+linux-edac@lfdr.de>; Mon, 11 Jan 2021 22:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbhAKVqF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Jan 2021 16:46:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:20892 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731682AbhAKVqE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 Jan 2021 16:46:04 -0500
IronPort-SDR: PIdsy3Zxk0jwQ23aW2KsWnxbcjjzxyJYh1AoDJ1fORsXh+oDsGWa+APuLor2nUytnjlNDzzgvd
 e/AUCF+2cWNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="177166209"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="177166209"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 13:45:08 -0800
IronPort-SDR: /EYgtN6RyiajNarZm1QuziXZRJmrrwZcrPFB6ZrKQDG+4v0wQOeZWxJaoRULpM/ZF8lHay2iho
 V+jp2RHT8YtA==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352760865"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 13:45:08 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user recovery
Date:   Mon, 11 Jan 2021 13:44:50 -0800
Message-Id: <20210111214452.1826-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20210111214452.1826-1-tony.luck@intel.com>
References: <20210108222251.14391-1-tony.luck@intel.com>
 <20210111214452.1826-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Recovery action when get_user() triggers a machine check uses the fixup
path to make get_user() return -EFAULT.  Also queue_task_work() sets up
so that kill_me_maybe() will be called on return to user mode to send a
SIGBUS to the current process.

But there are places in the kernel where the code assumes that this
EFAULT return was simply because of a page fault. The code takes some
action to fix that, and then retries the access. This results in a second
machine check.

While processing this second machine check queue_task_work() is called
again. But since this uses the same callback_head structure that
was used in the first call, the net result is an entry on the
current->task_works list that points to itself. When task_work_run()
is called it loops forever in this code:

		do {
			next = work->next;
			work->func(work);
			work = next;
			cond_resched();
		} while (work);

Add a "mce_busy" flag bit to detect this situation and panic
when it happens.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 7 ++++++-
 include/linux/sched.h          | 3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 13d3f1cbda17..1bf11213e093 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1246,6 +1246,7 @@ static void kill_me_maybe(struct callback_head *cb)
 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
 	int flags = MF_ACTION_REQUIRED;
 
+	p->mce_busy = 0;
 	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
 
 	if (!p->mce_ripv)
@@ -1268,6 +1269,7 @@ static void kill_me_maybe(struct callback_head *cb)
 
 static void queue_task_work(struct mce *m, int kill_current_task)
 {
+	current->mce_busy = 1;
 	current->mce_addr = m->addr;
 	current->mce_kflags = m->kflags;
 	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
@@ -1431,8 +1433,11 @@ noinstr void do_machine_check(struct pt_regs *regs)
 				mce_panic("Failed kernel mode recovery", &m, msg);
 		}
 
-		if (m.kflags & MCE_IN_KERNEL_COPYIN)
+		if (m.kflags & MCE_IN_KERNEL_COPYIN) {
+			if (current->mce_busy)
+				mce_panic("Multiple copyin", &m, msg);
 			queue_task_work(&m, kill_current_task);
+		}
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6e3a5eeec509..a763a76eac57 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1360,7 +1360,8 @@ struct task_struct {
 	u64				mce_addr;
 	__u64				mce_ripv : 1,
 					mce_whole_page : 1,
-					__mce_reserved : 62;
+					mce_busy : 1,
+					__mce_reserved : 61;
 	struct callback_head		mce_kill_me;
 #endif
 
-- 
2.21.1

