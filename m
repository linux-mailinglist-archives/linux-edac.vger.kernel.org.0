Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E4C3EF6DC
	for <lists+linux-edac@lfdr.de>; Wed, 18 Aug 2021 02:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbhHRAa3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Aug 2021 20:30:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:60945 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237075AbhHRAa2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Aug 2021 20:30:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="195807459"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="195807459"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 17:29:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="520687345"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 17:29:52 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 2/3] x86/mce: Change to not send SIGBUS error during copy from user
Date:   Tue, 17 Aug 2021 17:29:41 -0700
Message-Id: <20210818002942.1607544-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210818002942.1607544-1-tony.luck@intel.com>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Sending a SIGBUS for a copy from user is not the correct semantic.
System calls should return -EFAULT (or a short count for write(2)).

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 35 +++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 94830ee9581c..957ec60cd2a8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1269,7 +1269,7 @@ static void kill_me_maybe(struct callback_head *cb)
 		flags |= MF_MUST_KILL;
 
 	ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
-	if (!ret && !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
+	if (!ret) {
 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 		sync_core();
 		return;
@@ -1283,15 +1283,21 @@ static void kill_me_maybe(struct callback_head *cb)
 	if (ret == -EHWPOISON)
 		return;
 
-	if (p->mce_vaddr != (void __user *)-1l) {
-		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
-	} else {
-		pr_err("Memory error not recovered");
-		kill_me_now(cb);
-	}
+	pr_err("Memory error not recovered");
+	kill_me_now(cb);
+}
+
+static void kill_me_never(struct callback_head *cb)
+{
+	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
+
+	p->mce_count = 0;
+	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
+	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, 0))
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 }
 
-static void queue_task_work(struct mce *m, char *msg, int kill_current_task)
+static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callback_head *))
 {
 	int count = ++current->mce_count;
 
@@ -1301,11 +1307,7 @@ static void queue_task_work(struct mce *m, char *msg, int kill_current_task)
 		current->mce_kflags = m->kflags;
 		current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
 		current->mce_whole_page = whole_page(m);
-
-		if (kill_current_task)
-			current->mce_kill_me.func = kill_me_now;
-		else
-			current->mce_kill_me.func = kill_me_maybe;
+		current->mce_kill_me.func = func;
 	}
 
 	/* Ten is likley overkill. Don't expect more than two faults before task_work() */
@@ -1456,7 +1458,10 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		queue_task_work(&m, msg, kill_current_task);
+		if (kill_current_task)
+			queue_task_work(&m, msg, kill_me_now);
+		else
+			queue_task_work(&m, msg, kill_me_maybe);
 
 	} else {
 		/*
@@ -1474,7 +1479,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 
 		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, msg, kill_current_task);
+			queue_task_work(&m, msg, kill_me_never);
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
-- 
2.29.2

