Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2BD302F8D
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jan 2021 23:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbhAYWz6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jan 2021 17:55:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:52559 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732154AbhAYWzv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 25 Jan 2021 17:55:51 -0500
IronPort-SDR: eITmavLr9bxvQks1gVTenFAde9kiMdIWhSQdgzC5ieGqOR+a87sfb07fBQUOtpuz0tJjM0ogpe
 smFDU+EiRipA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179962674"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="179962674"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 14:55:10 -0800
IronPort-SDR: sld4pWMa3Q4QYt8r+JhN9VL8OaAXOL7FXNLqtS0/v7wTxYdxjH1tBqih6kEAvXbFNemQ34Y2YG
 9icLa2z2vsQQ==
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="409921428"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 14:55:10 -0800
Date:   Mon, 25 Jan 2021 14:55:09 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v5] x86/mce: Avoid infinite loop for copy from user recovery
Message-ID: <20210125225509.GA7149@agluck-desk2.amr.corp.intel.com>
References: <20210111214452.1826-1-tony.luck@intel.com>
 <20210115003817.23657-1-tony.luck@intel.com>
 <20210115152754.GC9138@zn.tnic>
 <20210115193435.GA4663@agluck-desk2.amr.corp.intel.com>
 <20210115205103.GA5920@agluck-desk2.amr.corp.intel.com>
 <20210115232346.GA7967@agluck-desk2.amr.corp.intel.com>
 <20210119105632.GF27433@zn.tnic>
 <20210119235759.GA9970@agluck-desk2.amr.corp.intel.com>
 <20210120121812.GF825@zn.tnic>
 <20210121210959.GA10304@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121210959.GA10304@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 21, 2021 at 01:09:59PM -0800, Luck, Tony wrote:
> On Wed, Jan 20, 2021 at 01:18:12PM +0100, Borislav Petkov wrote:
> But, on a whim, I changed the type of mce_count from "int" to "atomic_t" and
> fixeed up the increment & clear to use atomic_inc_return() and atomic_set().
> See updated patch below.
> 
> I can't see why this should have made any difference. But the "int" version
> crashes in a few dozen machine checks. The "atomic_t" version has run many
> thousands of machine checks (10213 in the current boot according to /proc/interrupts)
> with no issues.

And now I've changed it back to non-atomic (but keeping the
slightly cleaner looking code style that I used for the atomic
version).  This one also works for thousands of injections and
recoveries.  Maybe take it now before it stops working again :-)

-Tony

From: Tony Luck <tony.luck@intel.com>

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
index e133ce1e562b..30dedffd6f88 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1238,6 +1238,9 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 
 static void kill_me_now(struct callback_head *ch)
 {
+	struct task_struct *p = container_of(ch, struct task_struct, mce_kill_me);
+
+	p->mce_count = 0;
 	force_sig(SIGBUS);
 }
 
@@ -1246,6 +1249,7 @@ static void kill_me_maybe(struct callback_head *cb)
 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
 	int flags = MF_ACTION_REQUIRED;
 
+	p->mce_count = 0;
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
+	int count = ++current->mce_count;
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
2.29.2

