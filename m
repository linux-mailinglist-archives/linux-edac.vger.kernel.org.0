Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC0733EB59
	for <lists+linux-edac@lfdr.de>; Wed, 17 Mar 2021 09:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCQIXM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 17 Mar 2021 04:23:12 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:15487 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhCQIXI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 Mar 2021 04:23:08 -0400
X-AuditID: 0a580155-20dff7000005482e-0d-6051b4b3c64c
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 57.C4.18478.3B4B1506; Wed, 17 Mar 2021 15:50:11 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 17 Mar
 2021 16:23:05 +0800
Date:   Wed, 17 Mar 2021 16:23:04 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        <sunhao2@kingsoft.com>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210317162304.58ff188c@alex-virtual-machine>
In-Reply-To: <20210317154812.4173f423@alex-virtual-machine>
References: <20210303115710.2e9f8e23@alex-virtual-machine>
        <20210303163912.3d508e0f@alex-virtual-machine>
        <1a78e9abdc134e35a5efcbf6b2fd2263@intel.com>
        <20210304101653.546a9da1@alex-virtual-machine>
        <20210304121941.667047c3@alex-virtual-machine>
        <20210304144524.795872d7@alex-virtual-machine>
        <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
        <20210305093016.40c87375@alex-virtual-machine>
        <aee5176eafb54c88b19a5b2671d0a1fc@intel.com>
        <20210310141042.4db9ea29@alex-virtual-machine>
        <20210311085529.GA22268@hori.linux.bs1.fc.nec.co.jp>
        <20210317154812.4173f423@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsXCFcGooLt5S2CCwflHQhZz1q9hs/i84R+b
        xdf1v5gtpm0Ut7hwqoHJ4vKuOWwW99b8Z7W4dGABk8XFxgOMFmemFVls3jSV2eLNhXssFj82
        PGZ14PX43trH4rF4z0smj02rOtk8Nn2axO7x7tw5do8TM36zeLy4upHF4/2+q2wem09Xe3ze
        JOdxouULawB3FJdNSmpOZllqkb5dAlfGx2aZgllWFfcOJDUwtup3MXJySAiYSGz4upSli5GL
        Q0hgOpPE8pkTGCGcV4wSC7atZQapYhFQlfi1ezcTiM0GZO+6N4sVxBYRSJJYPPsrE0gDs8B3
        FoknV7eAFQkLeEl8ub+WEcTmFbCSmDG3nR3E5hSwltj87j8rxIZHLBIHZu1lA0nwC4hJ9F75
        zwRxk71E25ZFUM2CEidnPmEBsZkFdCROrDrGDGFrSyxb+BrMFhJQlDi85Bc7RK+SxJHuGWwQ
        dqzEsnmvWCcwCs9CMmoWklGzkIxawMi8ipGlODfdaBMjJP5CdzDOaPqod4iRiYPxEKMEB7OS
        CK9pXkCCEG9KYmVValF+fFFpTmrxIUZpDhYlcV7HSKCUQHpiSWp2ampBahFMlomDU6qB6bbk
        erbwsktHc/6ET/DufuCcJRb66P7OLVd7mNh7tASOH3E6mnZfjKVz6wXhB1OFHBueP5Xx2GHv
        Ep779+LKvyFzwxK4i5s2ahWVMNgyCF7Pqw+4Y7+8pdA7UEpU54sd39mN5Z+V0w2sFa3/BXPt
        FFr3zHCu5NTosmVv+/c83tRSE7Xw3CweXaHTf0wOr9k9S2LtVAGzOW9Vd9zWeLo5I7RW8plB
        dcdKI6FuqT0yLxS37ExbwcT5l60pZc2Z2y0Lr5jYaWUJXtVz3fBg7sLVCZsNOr1dS8KiHvEK
        nDU9EanydOm1yTuvqJ59tm83Z7QKQ4btt0mzD6xhev8zIiu6TO/xQus/b8895PYTrvPMUmIp
        zkg01GIuKk4EAMr+zukuAwAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


> > 
> > Returning true means you stop walking when you find the first entry pointing
> > to a given pfn. But there could be multiple such entries, so if MCE SRAR is
> > triggered by memory access to the larger address in hwpoisoned entries, the
> > returned virtual address might be wrong.
> >   
> 
> I can't find the way to fix this, maybe the virtual address is contained in
> related register, but this is really beyong my knowledge.
> 
> This is a v2 RFC patch, add support for thp and 1G huge page errors.
> 

Sorry for the debug info and other unclean modifications.

Post a clean one.

Thanks
Aili Yao

From 2289276ba943cdcddbf3b5b2cdbcaff78690e2e8 Mon Sep 17 00:00:00 2001
From: Aili Yao <yaoaili@kingsoft.com>
Date: Wed, 17 Mar 2021 16:12:41 +0800
Subject: [PATCH] fix invalid SIGBUS address for recovery fail

Walk the current process pages and compare with the pfn, then get the
user address and related page_shift.

For thp pages, we can only split anonoums thp page, so I think there may
be no race condition for walking and searching the thp error page for such
case; For non anonymous thp, the page flag and pte will not be change. so
when code goes into this place, it may be race condition for non-anonoums
thp page or from a recovery fail for anonoums thp, the page status will
not change, i am not so sure about this;

For the case we don't find the related virtual address, Maybe sending one
BUS_MCEERR_AR signal with invalid address NULL is a better option, but i am
not sure.

And this may get the wrong virtual address if process have multiple entry
for a same page, I don't find a way to get it correct.

Maybe other issues is not recognized.
---
 arch/x86/kernel/cpu/mce/core.c |  12 +---
 include/linux/mm.h             |   1 +
 mm/memory-failure.c            | 127 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index db4afc5..4cb873c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1246,7 +1246,7 @@ static void kill_me_maybe(struct callback_head *cb)
 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
 	int flags = MF_ACTION_REQUIRED;
 
-	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
+	pr_err("Uncorrected hardware memory error in user-access at %llx\n", p->mce_addr);
 
 	if (!p->mce_ripv)
 		flags |= MF_MUST_KILL;
@@ -1258,14 +1258,8 @@ static void kill_me_maybe(struct callback_head *cb)
 		return;
 	}
 
-	if (p->mce_vaddr != (void __user *)-1l) {
-		pr_err("Memory error may not recovered: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
-			p->mce_addr >> PAGE_SHIFT, p->comm, p->pid);
-		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
-	} else {
-		pr_err("Memory error not recovered");
-		kill_me_now(cb);
-	}
+	memory_failure_error(current, p->mce_addr >> PAGE_SHIFT);
+
 }
 
 static void queue_task_work(struct mce *m, int kill_current_task)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecdf8a8..cff2f02 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3046,6 +3046,7 @@ enum mf_flags {
 	MF_SOFT_OFFLINE = 1 << 3,
 };
 extern int memory_failure(unsigned long pfn, int flags);
+extern void memory_failure_error(struct task_struct *p, unsigned long pfn);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 06f0061..359b42f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -56,6 +56,7 @@
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
 #include <linux/page-isolation.h>
+#include <linux/pagewalk.h>
 #include "internal.h"
 #include "ras/ras_event.h"
 
@@ -1553,6 +1554,132 @@ int memory_failure(unsigned long pfn, int flags)
 }
 EXPORT_SYMBOL_GPL(memory_failure);
 
+static int pte_range(pte_t *ptep, unsigned long addr, unsigned long next, struct mm_walk *walk)
+{
+	u64 *buff = (u64 *)walk->private;
+	u64 pfn = buff[0];
+	pte_t pte = *ptep;
+
+	if (!pte_none(pte) && !pte_present(pte)) {
+		swp_entry_t swp_temp = pte_to_swp_entry(pte);
+
+		if (is_hwpoison_entry(swp_temp) && swp_offset(swp_temp) == pfn)
+			goto find;
+	} else if (pte_pfn(pte) == pfn) {
+		goto find;
+	}
+
+	return 0;
+
+find:
+	buff[0] = addr;
+	buff[1] = PAGE_SHIFT;
+	return true;
+}
+
+static int pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
+			     struct mm_walk *walk)
+{
+	u64 *buff = (u64 *)walk->private;
+	struct page *page = (struct page *)buff[0];
+	u64 pfn = buff[1];
+	pmd_t pmd = *pmdp;
+
+	if (likely(!pmd_trans_huge(pmd)))
+		return 0;
+
+	if (pmd_none(pmd) || !pmd_present(pmd))
+		return 0;
+
+	if (pmd_page(pmd) != page)
+		return 0;
+
+	for (; addr != end; page++, addr += PAGE_SIZE) {
+		if (page_to_pfn(page) == pfn) {
+			buff[0] = addr;
+			buff[1] = PAGE_SHIFT;
+			return true;
+		}
+	}
+
+	return 0;
+}
+
+static int hugetlb_range(pte_t *ptep, unsigned long hmask,
+				 unsigned long addr, unsigned long end,
+				 struct mm_walk *walk)
+{
+	u64 *buff = (u64 *)walk->private;
+	u64 pfn = buff[0];
+	pte_t pte =  huge_ptep_get(ptep);
+	struct page *page = pfn_to_page(pfn);
+
+	if (!huge_pte_none(pte) && !pte_present(pte)) {
+		swp_entry_t swp_temp = pte_to_swp_entry(pte);
+
+		if (is_hwpoison_entry(swp_temp) && swp_offset(swp_temp) == pfn)
+			goto find;
+	}
+	if (pte_pfn(pte) == pfn)
+		goto find;
+
+	return 0;
+
+find:
+	buff[0] = addr;
+	buff[1] = (huge_page_size(page_hstate(page)) > PMD_SIZE) ? PUD_SHIFT : PMD_SHIFT;
+	return true;
+}
+
+void memory_failure_error(struct task_struct *p, unsigned long pfn)
+{
+	u64 buff[2] = {0};
+	struct page *page;
+	int ret = -1;
+	struct mm_walk_ops walk = {0};
+
+	if (p->mce_vaddr != (void __user *)-1l && p->mce_vaddr != (void __user *)0) {
+		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
+		return;
+	}
+
+	page = pfn_to_page(pfn);
+	if (!page)
+		goto force_sigbus;
+
+	if (is_zone_device_page(page))
+		goto force_sigbus;
+
+	page = compound_head(page);
+
+	if (PageHuge(page)) {
+		walk.hugetlb_entry = hugetlb_range;
+		buff[0] = page_to_pfn(page);
+	} else if (PageTransHuge(page)) {
+		walk.pmd_entry = pmd_range;
+		buff[0] = (u64)page;
+		buff[1] = pfn;
+	} else {
+		walk.pte_entry = pte_range;
+		buff[0] = pfn;
+	}
+
+	mmap_read_lock(p->mm);
+	ret = walk_page_range(p->mm, 0, TASK_SIZE_MAX, &walk, (void *)buff);
+	mmap_read_unlock(p->mm);
+
+	pr_err("Memory error may not recovered: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
+	pfn, p->comm, p->pid);
+
+	if (ret) {
+		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)buff[0], buff[1]);
+	} else {
+force_sigbus:
+		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)0, PAGE_SHIFT);
+	}
+}
+EXPORT_SYMBOL_GPL(memory_failure_error);
+
 #define MEMORY_FAILURE_FIFO_ORDER	4
 #define MEMORY_FAILURE_FIFO_SIZE	(1 << MEMORY_FAILURE_FIFO_ORDER)
 
-- 
1.8.3.1

