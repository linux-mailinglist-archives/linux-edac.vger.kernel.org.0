Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66122FF6E0
	for <lists+linux-edac@lfdr.de>; Thu, 21 Jan 2021 22:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbhAUVMB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Jan 2021 16:12:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:11671 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbhAUVLA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 21 Jan 2021 16:11:00 -0500
IronPort-SDR: XRRKeFJq/BTbt4KEJlScneN4Q7YrInsrVOzh2O9X74v55KULBYamMnj/Tf6iDiGi5ZZujg3e1v
 mdvDyEE4lTaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="178567844"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="178567844"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 13:10:00 -0800
IronPort-SDR: mivUkPtMTq+2YxUYYHU6a6jY5lhCpSm6CQ6kFo0esSvqZwTl7bi+YtusSy51YHaXRtuZ5WKJOj
 9i9vrFNOJpiQ==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="348048621"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 13:10:00 -0800
Date:   Thu, 21 Jan 2021 13:09:59 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210121210959.GA10304@agluck-desk2.amr.corp.intel.com>
References: <20210111214452.1826-1-tony.luck@intel.com>
 <20210115003817.23657-1-tony.luck@intel.com>
 <20210115152754.GC9138@zn.tnic>
 <20210115193435.GA4663@agluck-desk2.amr.corp.intel.com>
 <20210115205103.GA5920@agluck-desk2.amr.corp.intel.com>
 <20210115232346.GA7967@agluck-desk2.amr.corp.intel.com>
 <20210119105632.GF27433@zn.tnic>
 <20210119235759.GA9970@agluck-desk2.amr.corp.intel.com>
 <20210120121812.GF825@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120121812.GF825@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 20, 2021 at 01:18:12PM +0100, Borislav Petkov wrote:
> On Tue, Jan 19, 2021 at 03:57:59PM -0800, Luck, Tony wrote:
> > But the real validation folks took my patch and found that it has
> > destabilized cases 1 & 2 (and case 3 also chokes if you repeat a few
> > more times). System either hangs or panics. Generally before 100
> > injection/conumption cycles.
> 
> Hmm, that mce_count increment and check stuff might turn out to be
> fragile in the face of a race condition. But I don't see it...

I can't see what the race is either.  As far as I can see the flow
looks like this (for a machine check in user mode)

	user-mode

		do_machine_check() [in atomic context on IST etc.]

			queue_task_work()
				increments current->mce_count
				first (only) call saves address etc. and calls task_work_add()
		return from machine check

Plausibly we might context switch to another process here. We could even
resume on a different CPU.

		do_task_work() [in process context]

			kill_me_maybe()
				sets mce_count back to zero, ready for another #MC
				memory_failure()
				send SIGBUS

The kernel get_user() case is similar, but may take extra machine checks before
before calling code decides get_user() really is going to keep saying -EFAULT.


But, on a whim, I changed the type of mce_count from "int" to "atomic_t" and
fixeed up the increment & clear to use atomic_inc_return() and atomic_set().
See updated patch below.

I can't see why this should have made any difference. But the "int" version
crashes in a few dozen machine checks. The "atomic_t" version has run many
thousands of machine checks (10213 in the current boot according to /proc/interrupts)
with no issues.

-Tony

From d1b003f1de92f87c8dc53dd710fd79ad6e277364 Mon Sep 17 00:00:00 2001
From: Tony Luck <tony.luck@intel.com>
Date: Wed, 20 Jan 2021 12:40:50 -0800
Subject: [PATCH] x86/mce: Avoid infinite loop for copy from user recovery

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

Add a counter (current->mce_count) to keep track of repeated machine checks
before task_work() is called. First machine check saves the address information
and calls task_work_add(). Subsequent machine checks before that task_work
call back is executed check that the address is in the same page as the first
machine check (since the callback will offline exactly one page).

Expected worst case is two machine checks before moving on (e.g. one user
access with page faults disabled, then a repeat to the same addrsss with
page faults enabled). Just in case there is some code that loops forever
enforce a limit of 10.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 35 +++++++++++++++++++++++++++-------
 include/linux/sched.h          |  1 +
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 13d3f1cbda17..4a8660058b67 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1238,6 +1238,9 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 
 static void kill_me_now(struct callback_head *ch)
 {
+	struct task_struct *p = container_of(ch, struct task_struct, mce_kill_me);
+
+	atomic_set(&p->mce_count, 0);
 	force_sig(SIGBUS);
 }
 
@@ -1246,6 +1249,7 @@ static void kill_me_maybe(struct callback_head *cb)
 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
 	int flags = MF_ACTION_REQUIRED;
 
+	atomic_set(&p->mce_count, 0);
 	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
 
 	if (!p->mce_ripv)
@@ -1266,12 +1270,29 @@ static void kill_me_maybe(struct callback_head *cb)
 	}
 }
 
-static void queue_task_work(struct mce *m, int kill_current_task)
+static void queue_task_work(struct mce *m, char *msg, int kill_current_task)
 {
-	current->mce_addr = m->addr;
-	current->mce_kflags = m->kflags;
-	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
-	current->mce_whole_page = whole_page(m);
+	int count = atomic_inc_return(&current->mce_count);
+
+	/* First call, save all the details */
+	if (count == 1) {
+		current->mce_addr = m->addr;
+		current->mce_kflags = m->kflags;
+		current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
+		current->mce_whole_page = whole_page(m);
+	}
+
+	/* Ten is likley overkill. Don't expect more than two faults before task_work() */
+	if (count > 10)
+		mce_panic("Too many machine checks while accessing user data", m, msg);
+
+	/* Second or later call, make sure page address matches the one from first call */
+	if (count > 1 && (current->mce_addr >> PAGE_SHIFT) != (m->addr >> PAGE_SHIFT))
+		mce_panic("Machine checks to different user pages", m, msg);
+
+	/* Do not call task_work_add() more than once */
+	if (count > 1)
+		return;
 
 	if (kill_current_task)
 		current->mce_kill_me.func = kill_me_now;
@@ -1414,7 +1435,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		queue_task_work(&m, kill_current_task);
+		queue_task_work(&m, msg, kill_current_task);
 
 	} else {
 		/*
@@ -1432,7 +1453,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 
 		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, kill_current_task);
+			queue_task_work(&m, msg, kill_current_task);
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6e3a5eeec509..5727d59ab737 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1362,6 +1362,7 @@ struct task_struct {
 					mce_whole_page : 1,
 					__mce_reserved : 62;
 	struct callback_head		mce_kill_me;
+	atomic_t			mce_count;
 #endif
 
 #ifdef CONFIG_KRETPROBES
-- 
2.21.1

