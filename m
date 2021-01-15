Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60D62F6F98
	for <lists+linux-edac@lfdr.de>; Fri, 15 Jan 2021 01:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbhAOAjH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Jan 2021 19:39:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:21828 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbhAOAjH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Jan 2021 19:39:07 -0500
IronPort-SDR: nbyRNf675crH1Vqjw7COph3Ia/KjA78SsDouiDl4/NhjrDoKoeoy/mIY2Hif3j3ZlGRAt4QOJU
 9GMkTJ7l0dQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="263262908"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="263262908"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 16:38:26 -0800
IronPort-SDR: sSB7hu1PDVQZRTVYDGxc+nZHE8UD1NIkAcilI3HBux3TR2GReW3Ztwxp5lQcHew/yJaVgqNnE7
 ytWtcCNre8Gg==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="382465326"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 16:38:26 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3] x86/mce: Avoid infinite loop for copy from user recovery
Date:   Thu, 14 Jan 2021 16:38:17 -0800
Message-Id: <20210115003817.23657-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20210111214452.1826-1-tony.luck@intel.com>
References: <20210111214452.1826-1-tony.luck@intel.com>
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

Add a "mce_busy" counter so that task_work_add() is only called once
per faulty page in this task.

Do not allow too many repeated machine checks, or machine checks to
a different page from the first.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---

V3: Thanks to extensive commentary from Andy & Boris

Throws out the changes to get_user() and subsequent changes to core
code. Everything is now handled in the machine check code. Downside is
that we can (and do) take multiple machine checks from a single poisoned
page before generic kernel code finally gets the message that a page is
really and truly gone (but all the failed get_user() calls still return
the legacy -EFAULT code, so none of that code will ever mistakenly use
a value from a bad page). But even on an old machine that does broadcast
interrupts for each machine check things survive multiple cycles of my
test injection into a futex operation.

I picked "10" as the magic upper limit for how many times the machine
check code will allow a fault from the same page before deciding to
panic.  We can bike shed that value if you like.

 arch/x86/kernel/cpu/mce/core.c | 27 ++++++++++++++++++++-------
 include/linux/sched.h          |  1 +
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 13d3f1cbda17..25daf6517dc9 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1246,6 +1246,7 @@ static void kill_me_maybe(struct callback_head *cb)
 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
 	int flags = MF_ACTION_REQUIRED;
 
+	p->mce_count = 0;
 	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
 
 	if (!p->mce_ripv)
@@ -1266,12 +1267,24 @@ static void kill_me_maybe(struct callback_head *cb)
 	}
 }
 
-static void queue_task_work(struct mce *m, int kill_current_task)
+static void queue_task_work(struct mce *m, char *msg, int kill_current_task)
 {
-	current->mce_addr = m->addr;
-	current->mce_kflags = m->kflags;
-	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
-	current->mce_whole_page = whole_page(m);
+	if (current->mce_count++ == 0) {
+		current->mce_addr = m->addr;
+		current->mce_kflags = m->kflags;
+		current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
+		current->mce_whole_page = whole_page(m);
+	}
+
+	if (current->mce_count > 10)
+		mce_panic("Too many machine checks while accessing user data", m, msg);
+
+	if (current->mce_count > 1 || (current->mce_addr >> PAGE_SHIFT) != (m->addr >> PAGE_SHIFT))
+		mce_panic("Machine checks to different user pages", m, msg);
+
+	/* Do not call task_work_add() more than once */
+	if (current->mce_count > 1)
+		return;
 
 	if (kill_current_task)
 		current->mce_kill_me.func = kill_me_now;
@@ -1414,7 +1427,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		queue_task_work(&m, kill_current_task);
+		queue_task_work(&m, msg, kill_current_task);
 
 	} else {
 		/*
@@ -1432,7 +1445,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 
 		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, kill_current_task);
+			queue_task_work(&m, msg, kill_current_task);
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6e3a5eeec509..386366c9c757 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1362,6 +1362,7 @@ struct task_struct {
 					mce_whole_page : 1,
 					__mce_reserved : 62;
 	struct callback_head		mce_kill_me;
+	int				mce_count;
 #endif
 
 #ifdef CONFIG_KRETPROBES
-- 
2.21.1

