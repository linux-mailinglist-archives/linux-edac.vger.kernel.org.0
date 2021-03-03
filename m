Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75432C663
	for <lists+linux-edac@lfdr.de>; Thu,  4 Mar 2021 02:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355460AbhCDA2o (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 Mar 2021 19:28:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:48586 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1446884AbhCCDkh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 2 Mar 2021 22:40:37 -0500
IronPort-SDR: tYDAeg/6wQ84atbqJA9dDn+1365BBIVUmd8pxEIHVES4mXFL72li6a6GfckkTgirCxgZ/RhYXw
 ZZdx7sa0VEGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174212014"
X-IronPort-AV: E=Sophos;i="5.81,218,1610438400"; 
   d="scan'208";a="174212014"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 19:39:55 -0800
IronPort-SDR: TZujoQ+0KUOUM+eO5Nv5p0nkar8Zn8WByGo+2PBrrnXRpii80ro/sbzusFERjrqN03xe/G5xCE
 p4dJ1MS9DW8w==
X-IronPort-AV: E=Sophos;i="5.81,218,1610438400"; 
   d="scan'208";a="407050161"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 19:39:54 -0800
Date:   Tue, 2 Mar 2021 19:39:53 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210303033953.GA205389@agluck-desk2.amr.corp.intel.com>
References: <20210224151619.67c29731@alex-virtual-machine>
 <20210224103105.GA16368@linux>
 <20210225114329.4e1a41c6@alex-virtual-machine>
 <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
 <20210225113930.GA7227@localhost.localdomain>
 <20210225123806.GA15006@hori.linux.bs1.fc.nec.co.jp>
 <20210225181542.GA178925@agluck-desk2.amr.corp.intel.com>
 <20210226021907.GA27861@hori.linux.bs1.fc.nec.co.jp>
 <20210226105915.6cf7d2b8@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226105915.6cf7d2b8@alex-virtual-machine>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 26, 2021 at 10:59:15AM +0800, Aili Yao wrote:
> Hi naoya, tony:
> > > 
> > > Idea for what we should do next ... Now that x86 is calling memory_failure()
> > > from user context ... maybe parallel calls for the same page should
> > > be blocked until the first caller completes so we can:
> > > a) know that pages are unmapped (if that happens)
> > > b) all get the same success/fail status  
> > 
> > One memory_failure() call changes the target page's status and
> > affects all mappings to all affected processes, so I think that
> > (ideally) we don't have to block other threads (letting them
> > early return seems fine).  Sometimes memory_failure() fails,
> > but even in such case, PG_hwpoison is set on the page and other
> > threads properly get SIGBUSs with this patch, so I think that
> > we can avoid the worst scenario (like system stall by MCE loop).
> > 
> I agree with naoya's point, if we block for this issue, Does this change the result
> that the process should be killed? Or is there something other still need to be considered?

Ok ... no blocking ... I think someone in this thread suggested
scanning the page tables to make sure the poisoned page had been
unmapped.

There's a walk_page_range() function that does all the work for that.
Just need to supply some callback routines that check whether a
mapping includes the bad PFN and clear the PRESENT bit.

RFC patch below against v5.12-rc1

-Tony

From 8de23b7f1be00ad38e129690dfe0b1558fad5ff8 Mon Sep 17 00:00:00 2001
From: Tony Luck <tony.luck@intel.com>
Date: Tue, 2 Mar 2021 15:06:33 -0800
Subject: [PATCH] x86/mce: Handle races between machine checks

When multiple CPUs hit the same poison memory there is a race. The
first CPU into memory_failure() atomically marks the page as poison
and continues processing to hunt down all the tasks that map this page
so that the virtual addresses can be marked not-present and SIGBUS
sent to the task that did the access.

Later CPUs get an early return from memory_failure() and may return
to user mode and access the poison again.

Add a new argument to memory_failure() so that it can indicate when
the race has been lost. Fix kill_me_maybe() to scan page tables in
this case to unmap pages.
---
 arch/x86/kernel/cpu/mce/core.c | 61 +++++++++++++++++++++++++++++++---
 drivers/base/memory.c          |  2 +-
 include/linux/mm.h             |  2 +-
 mm/hwpoison-inject.c           |  2 +-
 mm/madvise.c                   |  2 +-
 mm/memory-failure.c            |  6 ++--
 6 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7962355436da..2c6c560f3f92 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/kmod.h>
+#include <linux/pagewalk.h>
 #include <linux/poll.h>
 #include <linux/nmi.h>
 #include <linux/cpu.h>
@@ -637,6 +638,7 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 {
 	struct mce *mce = (struct mce *)data;
 	unsigned long pfn;
+	int already = 0;
 
 	if (!mce || !mce_usable_address(mce))
 		return NOTIFY_DONE;
@@ -646,8 +648,9 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 		return NOTIFY_DONE;
 
 	pfn = mce->addr >> PAGE_SHIFT;
-	if (!memory_failure(pfn, 0)) {
-		set_mce_nospec(pfn, whole_page(mce));
+	if (!memory_failure(pfn, 0, &already)) {
+		if (!already)
+			set_mce_nospec(pfn, whole_page(mce));
 		mce->kflags |= MCE_HANDLED_UC;
 	}
 
@@ -1248,6 +1251,50 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 	*m = *final;
 }
 
+static int pte_entry(pte_t *pte, unsigned long addr, unsigned long next, struct mm_walk *walk)
+{
+	u64 pfn = (u64)walk->private;
+
+	if (pte_pfn(*pte) == pfn)
+		pte->pte = pte->pte & ~_PAGE_PRESENT;
+
+	return 0;
+}
+
+static int pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next, struct mm_walk *walk)
+{
+	int shift = PMD_SHIFT - PAGE_SHIFT;
+	u64 pfn = (u64)walk->private;
+
+	if (!pmd_large(*pmd))
+		return 0;
+
+	if (pmd_pfn(*pmd) >> shift == pfn >> shift)
+		pmd->pmd = pmd->pmd & ~_PAGE_PRESENT;
+
+	return 0;
+}
+
+static int pud_entry(pud_t *pud, unsigned long addr, unsigned long next, struct mm_walk *walk)
+{
+	int shift = PUD_SHIFT - PAGE_SHIFT;
+	u64 pfn = (u64)walk->private;
+
+	if (!pud_large(*pud))
+		return 0;
+
+	if (pud_pfn(*pud) >> shift == pfn >> shift)
+		pud->pud = pud->pud & ~_PAGE_PRESENT;
+
+	return 0;
+}
+
+static struct mm_walk_ops walk = {
+	.pte_entry = pte_entry,
+	.pmd_entry = pmd_entry,
+	.pud_entry = pud_entry
+};
+
 static void kill_me_now(struct callback_head *ch)
 {
 	force_sig(SIGBUS);
@@ -1257,15 +1304,19 @@ static void kill_me_maybe(struct callback_head *cb)
 {
 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
 	int flags = MF_ACTION_REQUIRED;
+	int already = 0;
 
 	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
 
 	if (!p->mce_ripv)
 		flags |= MF_MUST_KILL;
 
-	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
+	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags, &already) &&
 	    !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
-		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
+		if (already)
+			walk_page_range(current->mm, 0, TASK_SIZE_MAX, &walk, (void *)(p->mce_addr >> PAGE_SHIFT));
+		else
+			set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 		sync_core();
 		return;
 	}
@@ -1452,7 +1503,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 EXPORT_SYMBOL_GPL(do_machine_check);
 
 #ifndef CONFIG_MEMORY_FAILURE
-int memory_failure(unsigned long pfn, int flags)
+int memory_failure(unsigned long pfn, int flags, int *already)
 {
 	/* mce_severity() should not hand us an ACTION_REQUIRED error */
 	BUG_ON(flags & MF_ACTION_REQUIRED);
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f35298425575..144500983656 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -480,7 +480,7 @@ static ssize_t hard_offline_page_store(struct device *dev,
 	if (kstrtoull(buf, 0, &pfn) < 0)
 		return -EINVAL;
 	pfn >>= PAGE_SHIFT;
-	ret = memory_failure(pfn, 0);
+	ret = memory_failure(pfn, 0, NULL);
 	return ret ? ret : count;
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77e64e3eac80..beaa6e871cbe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3003,7 +3003,7 @@ enum mf_flags {
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
 };
-extern int memory_failure(unsigned long pfn, int flags);
+extern int memory_failure(unsigned long pfn, int flags, int *already);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 1ae1ebc2b9b1..bfd5151dcd3f 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -48,7 +48,7 @@ static int hwpoison_inject(void *data, u64 val)
 
 inject:
 	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
-	return memory_failure(pfn, 0);
+	return memory_failure(pfn, 0, NULL);
 }
 
 static int hwpoison_unpoison(void *data, u64 val)
diff --git a/mm/madvise.c b/mm/madvise.c
index df692d2e35d4..09f569fed68d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -908,7 +908,7 @@ static int madvise_inject_error(int behavior,
 		} else {
 			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
-			ret = memory_failure(pfn, MF_COUNT_INCREASED);
+			ret = memory_failure(pfn, MF_COUNT_INCREASED, NULL);
 		}
 
 		if (ret)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 24210c9bd843..9a8911aa5fc9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1398,7 +1398,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
  * Must run in process context (e.g. a work queue) with interrupts
  * enabled and no spinlocks hold.
  */
-int memory_failure(unsigned long pfn, int flags)
+int memory_failure(unsigned long pfn, int flags, int *already)
 {
 	struct page *p;
 	struct page *hpage;
@@ -1428,6 +1428,8 @@ int memory_failure(unsigned long pfn, int flags)
 	if (PageHuge(p))
 		return memory_failure_hugetlb(pfn, flags);
 	if (TestSetPageHWPoison(p)) {
+		if (already)
+			*already = 1;
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
 		return 0;
@@ -1634,7 +1636,7 @@ static void memory_failure_work_func(struct work_struct *work)
 		if (entry.flags & MF_SOFT_OFFLINE)
 			soft_offline_page(entry.pfn, entry.flags);
 		else
-			memory_failure(entry.pfn, entry.flags);
+			memory_failure(entry.pfn, entry.flags, NULL);
 	}
 }
 
-- 
2.29.2

