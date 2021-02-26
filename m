Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607EB32669E
	for <lists+linux-edac@lfdr.de>; Fri, 26 Feb 2021 19:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhBZR7U (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Feb 2021 12:59:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:5134 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229949AbhBZR7U (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 26 Feb 2021 12:59:20 -0500
IronPort-SDR: NVFVAGmqR6E4V6vh+JaHh+Fq7Oc1/eTFdu+NuscGoMZhGqxQxzjZYSaObO0A7lifXuk9VKCvvZ
 74jtN9M4ikrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="185265198"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="185265198"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 09:58:39 -0800
IronPort-SDR: QHSNmYkMoCK8MwS31AsKm/UZdgerEwOX1IHFXVdS2UQgJCL8Dvt9egpqf/7O9lSnPTns7KXiRP
 Kv3nhlu00h7Q==
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="405065941"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 09:58:39 -0800
Date:   Fri, 26 Feb 2021 09:58:37 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>, "david@redhat.com" <david@redhat.com>,
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
Message-ID: <20210226175837.GA184397@agluck-desk2.amr.corp.intel.com>
References: <20210224151619.67c29731@alex-virtual-machine>
 <20210224103105.GA16368@linux>
 <20210225114329.4e1a41c6@alex-virtual-machine>
 <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
 <20210225113930.GA7227@localhost.localdomain>
 <20210226105250.3a15e35c@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226105250.3a15e35c@alex-virtual-machine>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 26, 2021 at 10:52:50AM +0800, Aili Yao wrote:
> Hi naoya,Oscar,david:
> > 
> > > We could use some negative value (error code) to report the reported case,
> > > then as you mentioned above, some callers need change to handle the
> > > new case, and the same is true if you use some positive value.
> > > My preference is -EHWPOISON, but other options are fine if justified well.  
> > 
> > -EHWPOISON seems like a good fit.
> > 
> I am OK with the -EHWPOISON error code, But I have one doubt here:
> When we return this -EHWPOISON error code, Does this means we have to add a new error code
> to error-base.h or errno.h? Is this easy realized?

The page already poisoned isn't really an error though. Just the result
of a race condition.  What if we added an extra argument to memory_failure()
so it can tell the caller that the specific reason for the early successful
return is that the page was already poisoned?

Something like this (untested - patch against v5.11):

-Tony

---

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e133ce1e562b..0e32c4d879fb 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -637,6 +637,7 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 {
 	struct mce *mce = (struct mce *)data;
 	unsigned long pfn;
+	int already = 0;
 
 	if (!mce || !mce_usable_address(mce))
 		return NOTIFY_DONE;
@@ -646,8 +647,9 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 		return NOTIFY_DONE;
 
 	pfn = mce->addr >> PAGE_SHIFT;
-	if (!memory_failure(pfn, 0)) {
-		set_mce_nospec(pfn, whole_page(mce));
+	if (!memory_failure(pfn, 0, &already)) {
+		if (!already)
+			set_mce_nospec(pfn, whole_page(mce));
 		mce->kflags |= MCE_HANDLED_UC;
 	}
 
@@ -1245,15 +1247,19 @@ static void kill_me_maybe(struct callback_head *cb)
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
+			force_sig(SIGBUS); // BETTER CODE NEEDED HERE!!!
+		else
+			set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 		sync_core();
 		return;
 	}
@@ -1440,7 +1446,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 EXPORT_SYMBOL_GPL(do_machine_check);
 
 #ifndef CONFIG_MEMORY_FAILURE
-int memory_failure(unsigned long pfn, int flags)
+int memory_failure(unsigned long pfn, int flags, int *already)
 {
 	/* mce_severity() should not hand us an ACTION_REQUIRED error */
 	BUG_ON(flags & MF_ACTION_REQUIRED);
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index eef4ffb6122c..24c36623e492 100644
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
index ecdf8a8cd6ae..88b92820465c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3045,7 +3045,7 @@ enum mf_flags {
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
index 6a660858784b..ade1956632aa 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -907,7 +907,7 @@ static int madvise_inject_error(int behavior,
 		} else {
 			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
-			ret = memory_failure(pfn, MF_COUNT_INCREASED);
+			ret = memory_failure(pfn, MF_COUNT_INCREASED, NULL);
 		}
 
 		if (ret)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e9481632fcd1..e8508e4d70e5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1388,7 +1388,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
  * Must run in process context (e.g. a work queue) with interrupts
  * enabled and no spinlocks hold.
  */
-int memory_failure(unsigned long pfn, int flags)
+int memory_failure(unsigned long pfn, int flags, int *already)
 {
 	struct page *p;
 	struct page *hpage;
@@ -1418,6 +1418,8 @@ int memory_failure(unsigned long pfn, int flags)
 	if (PageHuge(p))
 		return memory_failure_hugetlb(pfn, flags);
 	if (TestSetPageHWPoison(p)) {
+		if (already)
+			*already = 1;
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
 		return 0;
@@ -1624,7 +1626,7 @@ static void memory_failure_work_func(struct work_struct *work)
 		if (entry.flags & MF_SOFT_OFFLINE)
 			soft_offline_page(entry.pfn, entry.flags);
 		else
-			memory_failure(entry.pfn, entry.flags);
+			memory_failure(entry.pfn, entry.flags, NULL);
 	}
 }
 
