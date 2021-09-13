Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7448409F60
	for <lists+linux-edac@lfdr.de>; Mon, 13 Sep 2021 23:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhIMVx7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Sep 2021 17:53:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:27374 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234843AbhIMVx7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 13 Sep 2021 17:53:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="221853521"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="221853521"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 14:52:42 -0700
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="543499530"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 14:52:41 -0700
Date:   Mon, 13 Sep 2021 14:52:39 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] x86/mce: Avoid infinite loop for copy from user recovery
Message-ID: <YT/IJ9ziLqmtqEPu@agluck-desk2.amr.corp.intel.com>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-2-tony.luck@intel.com>
 <YT8Y5cBiaD3NpAIi@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT8Y5cBiaD3NpAIi@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There are two cases for machine check recovery:
1) The machine check was triggered by ring3 (application) code.
   This is the simpler case. The machine check handler simply queues
   work to be executed on return to user. That code unmaps the page
   from all users and arranges to send a SIGBUS to the task that
   triggered the poison.
2) The machine check was triggered in kernel code that is covered by
   an extable entry.
   In this case the machine check handler still queues a work entry to
   unmap the page, etc. but this will not be called right away because
   the #MC handler returns to the fix up code address in the extable
   entry.

Problems occur if the kernel triggers another machine check before the
return to user processes the first queued work item.

Specifically the work is queued using the "mce_kill_me" callback
structure in the task struct for the current thread. Attempting to queue
a second work item using this same callback results in a loop in the
linked list of work functions to call. So when the kernel does return to
user it enters an infinite loop processing the same entry for ever.

There are some legitimate scenarios where the kernel may take a second
machine check before returning to the user.

1) Some code (e.g. futex) first tries a get_user() with page faults
   disabled. If this fails, the code retries with page faults enabled
   expecting that this will resolve the page fault.
2) Copy from user code retries a copy in byte-at-time mode to check
   whether any additional bytes can be copied.

On the other side of the fence are some bad drivers that do not check
the return value from individual get_user() calls and may access
multiple user addresses without noticing that some/all calls have
failed.

Fix by adding a counter (current->mce_count) to keep track of repeated
machine checks before task_work() is called. First machine check saves
the address information and calls task_work_add(). Subsequent machine
checks before that task_work call back is executed check that the address
is in the same page as the first machine check (since the callback will
offline exactly one page).

Expected worst case is four machine checks before moving on (e.g. one
user access with page faults disabled, then a repeat to the same address
with page faults enabled ... repeat in copy tail bytes). Just in case
there is some code that loops forever enforce a limit of 10.

Also mark queue_task_work() as "noinstr" (as reported kernel test robot
<lkp@intel.com>)

Cc: <stable@vger.kernel.org>
Fixes: 5567d11c21a1 ("x86/mce: Send #MC singal from task work")
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

> What about a Fixes: tag?

Added a Fixes tag.

Also added "noinstr" to queue_task_work() per a kernel robot report.

Also re-wrote the commit comment (based on questions raised against v2)

> I guess backporting this to the respective kernels is predicated upon
> the existence of those other "places" in the kernel where code assumes
> the EFAULT was because of a #PF.

Not really. I don't expect to change any kernel code that just bounces
off the same machine check a few times. This patch does work best in
conjunction with patches 2 & 3 (unchanged, not reposted here). But it
will fix some old issues even without those two.

 arch/x86/kernel/cpu/mce/core.c | 43 +++++++++++++++++++++++++---------
 include/linux/sched.h          |  1 +
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 8cb7816d03b4..9891b4070a61 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1253,6 +1253,9 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 
 static void kill_me_now(struct callback_head *ch)
 {
+	struct task_struct *p = container_of(ch, struct task_struct, mce_kill_me);
+
+	p->mce_count = 0;
 	force_sig(SIGBUS);
 }
 
@@ -1262,6 +1265,7 @@ static void kill_me_maybe(struct callback_head *cb)
 	int flags = MF_ACTION_REQUIRED;
 	int ret;
 
+	p->mce_count = 0;
 	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
 
 	if (!p->mce_ripv)
@@ -1290,17 +1294,34 @@ static void kill_me_maybe(struct callback_head *cb)
 	}
 }
 
-static void queue_task_work(struct mce *m, int kill_current_task)
+static noinstr void queue_task_work(struct mce *m, char *msg, int kill_current_task)
 {
-	current->mce_addr = m->addr;
-	current->mce_kflags = m->kflags;
-	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
-	current->mce_whole_page = whole_page(m);
+	int count = ++current->mce_count;
 
-	if (kill_current_task)
-		current->mce_kill_me.func = kill_me_now;
-	else
-		current->mce_kill_me.func = kill_me_maybe;
+	/* First call, save all the details */
+	if (count == 1) {
+		current->mce_addr = m->addr;
+		current->mce_kflags = m->kflags;
+		current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
+		current->mce_whole_page = whole_page(m);
+
+		if (kill_current_task)
+			current->mce_kill_me.func = kill_me_now;
+		else
+			current->mce_kill_me.func = kill_me_maybe;
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
 
 	task_work_add(current, &current->mce_kill_me, TWA_RESUME);
 }
@@ -1438,7 +1459,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		queue_task_work(&m, kill_current_task);
+		queue_task_work(&m, msg, kill_current_task);
 
 	} else {
 		/*
@@ -1456,7 +1477,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 
 		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, kill_current_task);
+			queue_task_work(&m, msg, kill_current_task);
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e12b524426b0..39039ce8ac4c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1471,6 +1471,7 @@ struct task_struct {
 					mce_whole_page : 1,
 					__mce_reserved : 62;
 	struct callback_head		mce_kill_me;
+	int				mce_count;
 #endif
 
 #ifdef CONFIG_KRETPROBES
-- 
2.31.1

