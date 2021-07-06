Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678513BDDBF
	for <lists+linux-edac@lfdr.de>; Tue,  6 Jul 2021 21:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhGFTJI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Jul 2021 15:09:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:6713 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231700AbhGFTJI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 6 Jul 2021 15:09:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="206166883"
X-IronPort-AV: E=Sophos;i="5.83,329,1616482800"; 
   d="scan'208";a="206166883"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 12:06:27 -0700
X-IronPort-AV: E=Sophos;i="5.83,329,1616482800"; 
   d="scan'208";a="427687585"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 12:06:27 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user recovery
Date:   Tue,  6 Jul 2021 12:06:19 -0700
Message-Id: <20210706190620.1290391-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210706190620.1290391-1-tony.luck@intel.com>
References: <20210706190620.1290391-1-tony.luck@intel.com>
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
 arch/x86/kernel/cpu/mce/core.c | 39 ++++++++++++++++++++++++++--------
 include/linux/sched.h          |  1 +
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index dd03971e5ad5..957ec60cd2a8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1250,6 +1250,9 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 
 static void kill_me_now(struct callback_head *ch)
 {
+	struct task_struct *p = container_of(ch, struct task_struct, mce_kill_me);
+
+	p->mce_count = 0;
 	force_sig(SIGBUS);
 }
 
@@ -1259,6 +1262,7 @@ static void kill_me_maybe(struct callback_head *cb)
 	int flags = MF_ACTION_REQUIRED;
 	int ret;
 
+	p->mce_count = 0;
 	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
 
 	if (!p->mce_ripv)
@@ -1287,19 +1291,36 @@ static void kill_me_never(struct callback_head *cb)
 {
 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
 
+	p->mce_count = 0;
 	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
 	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, 0))
 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 }
 
-static void queue_task_work(struct mce *m, void (*func)(struct callback_head *))
+static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callback_head *))
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
+		current->mce_kill_me.func = func;
+	}
 
-	current->mce_kill_me.func = func;
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
@@ -1438,9 +1459,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
 		if (kill_current_task)
-			queue_task_work(&m, kill_me_now);
+			queue_task_work(&m, msg, kill_me_now);
 		else
-			queue_task_work(&m, kill_me_maybe);
+			queue_task_work(&m, msg, kill_me_maybe);
 
 	} else {
 		/*
@@ -1458,7 +1479,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 
 		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, kill_me_never);
+			queue_task_work(&m, msg, kill_me_never);
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ec8d07d88641..f6935787e7e8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1394,6 +1394,7 @@ struct task_struct {
 					mce_whole_page : 1,
 					__mce_reserved : 62;
 	struct callback_head		mce_kill_me;
+	int				mce_count;
 #endif
 
 #ifdef CONFIG_KRETPROBES
-- 
2.29.2

