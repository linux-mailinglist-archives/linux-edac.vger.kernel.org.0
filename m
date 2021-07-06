Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547073BDDBC
	for <lists+linux-edac@lfdr.de>; Tue,  6 Jul 2021 21:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhGFTJH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Jul 2021 15:09:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:6713 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhGFTJH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 6 Jul 2021 15:09:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="206166879"
X-IronPort-AV: E=Sophos;i="5.83,329,1616482800"; 
   d="scan'208";a="206166879"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 12:06:27 -0700
X-IronPort-AV: E=Sophos;i="5.83,329,1616482800"; 
   d="scan'208";a="427687576"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 12:06:26 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86/mce: Change to not send SIGBUS error during copy from user
Date:   Tue,  6 Jul 2021 12:06:18 -0700
Message-Id: <20210706190620.1290391-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210706190620.1290391-1-tony.luck@intel.com>
References: <20210706190620.1290391-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Sending a SIGBUS for a copy from user is not the correct semantic.
System calls should return -EFAULT (or a short count for write(2)).

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 22791aadc085..dd03971e5ad5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1265,7 +1265,7 @@ static void kill_me_maybe(struct callback_head *cb)
 		flags |= MF_MUST_KILL;
 
 	ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
-	if (!ret && !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
+	if (!ret) {
 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 		sync_core();
 		return;
@@ -1279,25 +1279,27 @@ static void kill_me_maybe(struct callback_head *cb)
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
+	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
+	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, 0))
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 }
 
-static void queue_task_work(struct mce *m, int kill_current_task)
+static void queue_task_work(struct mce *m, void (*func)(struct callback_head *))
 {
 	current->mce_addr = m->addr;
 	current->mce_kflags = m->kflags;
 	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
 	current->mce_whole_page = whole_page(m);
 
-	if (kill_current_task)
-		current->mce_kill_me.func = kill_me_now;
-	else
-		current->mce_kill_me.func = kill_me_maybe;
+	current->mce_kill_me.func = func;
 
 	task_work_add(current, &current->mce_kill_me, TWA_RESUME);
 }
@@ -1435,7 +1437,10 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		queue_task_work(&m, kill_current_task);
+		if (kill_current_task)
+			queue_task_work(&m, kill_me_now);
+		else
+			queue_task_work(&m, kill_me_maybe);
 
 	} else {
 		/*
@@ -1453,7 +1458,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		}
 
 		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, kill_current_task);
+			queue_task_work(&m, kill_me_never);
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
-- 
2.29.2

