Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC01D32DF25
	for <lists+linux-edac@lfdr.de>; Fri,  5 Mar 2021 02:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhCEBhA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Mar 2021 20:37:00 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:13246 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCEBg7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 4 Mar 2021 20:36:59 -0500
X-AuditID: 0a580157-f21ff7000005df43-f7-604184ba87cd
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 82.28.57155.AB481406; Fri,  5 Mar 2021 09:09:14 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Mar 2021
 09:36:57 +0800
Date:   Fri, 5 Mar 2021 09:36:56 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
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
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        <yaoaili@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210305093656.6c262b19@alex-virtual-machine>
In-Reply-To: <20210305093016.40c87375@alex-virtual-machine>
References: <20210225181542.GA178925@agluck-desk2.amr.corp.intel.com>
        <20210226021907.GA27861@hori.linux.bs1.fc.nec.co.jp>
        <20210226105915.6cf7d2b8@alex-virtual-machine>
        <20210303033953.GA205389@agluck-desk2.amr.corp.intel.com>
        <20210303115710.2e9f8e23@alex-virtual-machine>
        <20210303163912.3d508e0f@alex-virtual-machine>
        <1a78e9abdc134e35a5efcbf6b2fd2263@intel.com>
        <20210304101653.546a9da1@alex-virtual-machine>
        <20210304121941.667047c3@alex-virtual-machine>
        <20210304144524.795872d7@alex-virtual-machine>
        <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
        <20210305093016.40c87375@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsXCFcGooLurxTHBoHcJv8Wc9WvYLD5v+Mdm
        8XX9L2aLaRvFLS6camCyuLxrDpvFvTX/WS0uHVjAZHGx8QCjxZlpRRabN01ltnhz4R6LxY8N
        j1kdeD2+t/axeCze85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHi+ubmTxeL/vKpvH5tPVHp83
        yXmcaPnCGsAdxWWTkpqTWZZapG+XwJUx5e9LpoIZSRUL/z9kaWCc4N3FyMkhIWAi8WjlP7Yu
        Ri4OIYHpTBKr3r1ngXBeMkrMu3uMGaSKRUBF4tPEEywgNpuAqsSue7NYQWwRATWJS4sfMIM0
        MAvMZpU4NfksWIOwgJfEl/trGbsYOTh4BawkzryxBwlzClhL9M1/A7XgF4vEpFtLwIbyC4hJ
        9F75zwRxkr1E25ZFjCA2r4CgxMmZT8BqmAV0JE6sgjiIWUBeYvvbOWC2kICixOElv9ghepUk
        jnTPYIOwYyWWzXvFOoFReBaSUbOQjJqFZNQCRuZVjCzFuemGmxghERi+g3Fe00e9Q4xMHIyH
        GCU4mJVEeMVf2iYI8aYkVlalFuXHF5XmpBYfYpTmYFES521xsk8QEkhPLEnNTk0tSC2CyTJx
        cEo1MM36ejjB+FPqOa+uO4IBF943LzPY3sl/c0d46GJnprB5y3d17vl9X3eF+VGv7ZreGjpP
        NJ2u8vdc+88eFP+geVJXQvypzOXOS89/nDipojwjQG3Hji2fV71QZlom9T5hz1qfilmX0oO7
        kjgXF/ocLVKTK+Sv0Dm6RabSYubCuWmGU39p3b7zuuracQ3nE06ixp5qD96Jmkf1CB8yNBBQ
        mZy1cJFsh/scNr0a3xd32ToPT5q2OLrjecyNKVGPDdRu1kjXzei7mRy53XuBmnnguWuTngtm
        rIy7qHzUP5KNX+Hqdp8VsjnCjKHKeRe+Fgaujvdn7Li/bHrApmtOdi/WsWlEqWm+8ha98TfU
        +52ZhRJLcUaioRZzUXEiAOsMPRwvAwAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, 5 Mar 2021 09:30:16 +0800
Aili Yao <yaoaili@kingsoft.com> wrote:

> On Thu, 4 Mar 2021 15:57:20 -0800
> "Luck, Tony" <tony.luck@intel.com> wrote:
> 
> > On Thu, Mar 04, 2021 at 02:45:24PM +0800, Aili Yao wrote:
> > > > > if your methods works, should it be like this?
> > > > > 
> > > > > 1582                         pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
> > > > > 1583                         if (PageHuge(page)) {
> > > > > 1584                                 hugetlb_count_sub(compound_nr(page), mm);
> > > > > 1585                                 set_huge_swap_pte_at(mm, address,
> > > > > 1586                                                      pvmw.pte, pteval,
> > > > > 1587                                                      vma_mmu_pagesize(vma));
> > > > > 1588                         } else {
> > > > > 1589                                 dec_mm_counter(mm, mm_counter(page));
> > > > > 1590                                 set_pte_at(mm, address, pvmw.pte, pteval);
> > > > > 1591                         }
> > > > > 
> > > > > the page fault check if it's a poison page using is_hwpoison_entry(),
> > > > >     
> > > > 
> > > > And if it works, does we need some locking mechanism before we call walk_page_range();
> > > > if we lock, does we need to process the blocking interrupted error as other places will do?
> > > >   
> > > 
> > > And another thing:
> > > Do we need a call to flush_tlb_page(vma, address) to make the pte changes into effect?  
> > 
> > Thanks for all the pointers.  I added them to the patch (see below).
> > [The pmd/pud cases may need some tweaking ... but just trying to get
> > the 4K page case working first]
> > 
> > I tried testing by skipping the call to memory_failure() and just
> > using this new code to search the page tables for current page and
> > marking it hwpoison (to simulate the case where 2nd process gets the
> > early return from memory_failure(). Something is still missing because I get:
> > 
> > [  481.911298] mce: pte_entry: matched pfn - mark poison & zap pte
> > [  481.917935] MCE: Killing einj_mem_uc:5555 due to hardware memory corruption fault at 7fe64b33b400
> > [  482.933775] BUG: Bad page cache in process einj_mem_uc  pfn:408b6d6
> > [  482.940777] page:0000000013ea6e96 refcount:3 mapcount:1 mapping:00000000e3a069d9 index:0x0 pfn:0x408b6d6
> > [  482.951355] memcg:ffff94a809834000
> > [  482.955153] aops:shmem_aops ino:3c04
> > [  482.959142] flags: 0x97ffffc0880015(locked|uptodate|lru|swapbacked|hwpoison)
> > [  482.967018] raw: 0097ffffc0880015 ffff94c80e93ec00 ffff94c80e93ec00 ffff94c80a9b25a8
> > [  482.975666] raw: 0000000000000000 0000000000000000 0000000300000000 ffff94a809834000
> > [  482.984310] page dumped because: still mapped when deleted
> 
> From the walk, it seems we have got the virtual address, can we just send a SIGBUS with it?

Does this walk proper for other memory-failure error cases, can it be applied to if (p->mce_vaddr != (void __user *)-1l) branch
in kill_me_maybe()?

> > commit e5de44560b33e2d407704243566253a70f858a59
> > Author: Tony Luck <tony.luck@intel.com>
> > Date:   Tue Mar 2 15:06:33 2021 -0800
> > 
> >     x86/mce: Handle races between machine checks
> >     
> >     When multiple CPUs hit the same poison memory there is a race. The
> >     first CPU into memory_failure() atomically marks the page as poison
> >     and continues processing to hunt down all the tasks that map this page
> >     so that the virtual addresses can be marked not-present and SIGBUS
> >     sent to the task that did the access.
> >     
> >     Later CPUs get an early return from memory_failure() and may return
> >     to user mode and access the poison again.
> >     
> >     Add a new argument to memory_failure() so that it can indicate when
> >     the race has been lost. Fix kill_me_maybe() to scan page tables in
> >     this case to unmap pages.
> > 
> > diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> > index 7962355436da..a52c6a772de2 100644
> > --- a/arch/x86/kernel/cpu/mce/core.c
> > +++ b/arch/x86/kernel/cpu/mce/core.c
> > @@ -28,8 +28,12 @@
> >  #include <linux/sysfs.h>
> >  #include <linux/types.h>
> >  #include <linux/slab.h>
> > +#include <linux/hugetlb.h>
> > +#include <linux/swap.h>
> > +#include <linux/swapops.h>
> >  #include <linux/init.h>
> >  #include <linux/kmod.h>
> > +#include <linux/pagewalk.h>
> >  #include <linux/poll.h>
> >  #include <linux/nmi.h>
> >  #include <linux/cpu.h>
> > @@ -637,6 +641,7 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
> >  {
> >  	struct mce *mce = (struct mce *)data;
> >  	unsigned long pfn;
> > +	int already = 0;
> >  
> >  	if (!mce || !mce_usable_address(mce))
> >  		return NOTIFY_DONE;
> > @@ -646,8 +651,9 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
> >  		return NOTIFY_DONE;
> >  
> >  	pfn = mce->addr >> PAGE_SHIFT;
> > -	if (!memory_failure(pfn, 0)) {
> > -		set_mce_nospec(pfn, whole_page(mce));
> > +	if (!memory_failure(pfn, 0, &already)) {
> > +		if (!already)
> > +			set_mce_nospec(pfn, whole_page(mce));
> >  		mce->kflags |= MCE_HANDLED_UC;
> >  	}
> >  
> > @@ -1248,6 +1254,79 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
> >  	*m = *final;
> >  }
> >  
> > +static int pte_entry(pte_t *pte, unsigned long addr, unsigned long next, struct mm_walk *walk)
> > +{
> > +	u64 pfn = (u64)walk->private;
> > +	struct page *page;
> > +	pte_t pteval;
> > +
> > +	if (pte_pfn(*pte) == pfn) {
> > +pr_info("pte_entry: matched pfn - mark poison & zap pte\n");
> > +		page = pfn_to_page(pfn);
> > +		lock_page(page);
> > +SetPageHWPoison(page);
> > +		pteval = swp_entry_to_pte(make_hwpoison_entry(page));
> > +		dec_mm_counter(walk->mm, mm_counter(page));
> > +		set_pte_at(current->mm, addr, pte, pteval);
> > +		unlock_page(page);
> > +		flush_tlb_page(walk->vma, addr);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next, struct mm_walk *walk)
> > +{
> > +	int shift = PMD_SHIFT - PAGE_SHIFT;
> > +	u64 pfn = (u64)walk->private;
> > +	struct page *page;
> > +	pte_t pteval;
> > +
> > +	if (!pmd_large(*pmd))
> > +		return 0;
> > +
> > +	if (pmd_pfn(*pmd) >> shift == pfn >> shift) {
> > +		page = pfn_to_page(pfn);
> > +		lock_page(page);
> > +		pteval = swp_entry_to_pte(make_hwpoison_entry(page));
> > +		hugetlb_count_sub(compound_nr(page), walk->mm);
> > +		set_huge_swap_pte_at(walk->mm, addr, (pte_t *)pmd, pteval, vma_mmu_pagesize(walk->vma));
> > +		unlock_page(page);
> > +		flush_tlb_page(walk->vma, addr);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int pud_entry(pud_t *pud, unsigned long addr, unsigned long next, struct mm_walk *walk)
> > +{
> > +	int shift = PUD_SHIFT - PAGE_SHIFT;
> > +	u64 pfn = (u64)walk->private;
> > +	struct page *page;
> > +	pte_t pteval;
> > +
> > +	if (!pud_large(*pud))
> > +		return 0;
> > +
> > +	if (pud_pfn(*pud) >> shift == pfn >> shift) {
> > +		page = pfn_to_page(pfn);
> > +		lock_page(page);
> > +		pteval = swp_entry_to_pte(make_hwpoison_entry(page));
> > +		hugetlb_count_sub(compound_nr(page), walk->mm);
> > +		set_huge_swap_pte_at(walk->mm, addr, (pte_t *)pud, pteval, vma_mmu_pagesize(walk->vma));
> > +		unlock_page(page);
> > +		flush_tlb_page(walk->vma, addr);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct mm_walk_ops walk = {
> > +	.pte_entry = pte_entry,
> > +	.pmd_entry = pmd_entry,
> > +	.pud_entry = pud_entry
> > +};
> > +
> >  static void kill_me_now(struct callback_head *ch)
> >  {
> >  	force_sig(SIGBUS);
> > @@ -1257,15 +1336,22 @@ static void kill_me_maybe(struct callback_head *cb)
> >  {
> >  	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
> >  	int flags = MF_ACTION_REQUIRED;
> > +	int already = 0;
> >  
> >  	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
> >  
> >  	if (!p->mce_ripv)
> >  		flags |= MF_MUST_KILL;
> >  
> > -	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> > +	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags, &already) &&
> >  	    !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
> > -		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
> > +		if (already) {
> > +			mmap_read_lock(current->mm);
> > +			walk_page_range(current->mm, 0, TASK_SIZE_MAX, &walk, (void *)(p->mce_addr >> PAGE_SHIFT));
> > +			mmap_read_unlock(current->mm);
> > +		} else {
> > +			set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
> > +		}
> >  		sync_core();
> >  		return;
> >  	}
> > @@ -1452,7 +1538,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
> >  EXPORT_SYMBOL_GPL(do_machine_check);
> >  
> >  #ifndef CONFIG_MEMORY_FAILURE
> > -int memory_failure(unsigned long pfn, int flags)
> > +int memory_failure(unsigned long pfn, int flags, int *already)
> >  {
> >  	/* mce_severity() should not hand us an ACTION_REQUIRED error */
> >  	BUG_ON(flags & MF_ACTION_REQUIRED);
> > diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> > index f35298425575..144500983656 100644
> > --- a/drivers/base/memory.c
> > +++ b/drivers/base/memory.c
> > @@ -480,7 +480,7 @@ static ssize_t hard_offline_page_store(struct device *dev,
> >  	if (kstrtoull(buf, 0, &pfn) < 0)
> >  		return -EINVAL;
> >  	pfn >>= PAGE_SHIFT;
> > -	ret = memory_failure(pfn, 0);
> > +	ret = memory_failure(pfn, 0, NULL);
> >  	return ret ? ret : count;
> >  }
> >  
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 77e64e3eac80..beaa6e871cbe 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3003,7 +3003,7 @@ enum mf_flags {
> >  	MF_MUST_KILL = 1 << 2,
> >  	MF_SOFT_OFFLINE = 1 << 3,
> >  };
> > -extern int memory_failure(unsigned long pfn, int flags);
> > +extern int memory_failure(unsigned long pfn, int flags, int *already);
> >  extern void memory_failure_queue(unsigned long pfn, int flags);
> >  extern void memory_failure_queue_kick(int cpu);
> >  extern int unpoison_memory(unsigned long pfn);
> > diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
> > index 1ae1ebc2b9b1..bfd5151dcd3f 100644
> > --- a/mm/hwpoison-inject.c
> > +++ b/mm/hwpoison-inject.c
> > @@ -48,7 +48,7 @@ static int hwpoison_inject(void *data, u64 val)
> >  
> >  inject:
> >  	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
> > -	return memory_failure(pfn, 0);
> > +	return memory_failure(pfn, 0, NULL);
> >  }
> >  
> >  static int hwpoison_unpoison(void *data, u64 val)
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index df692d2e35d4..09f569fed68d 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -908,7 +908,7 @@ static int madvise_inject_error(int behavior,
> >  		} else {
> >  			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
> >  				 pfn, start);
> > -			ret = memory_failure(pfn, MF_COUNT_INCREASED);
> > +			ret = memory_failure(pfn, MF_COUNT_INCREASED, NULL);
> >  		}
> >  
> >  		if (ret)
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 24210c9bd843..9a8911aa5fc9 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1398,7 +1398,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
> >   * Must run in process context (e.g. a work queue) with interrupts
> >   * enabled and no spinlocks hold.
> >   */
> > -int memory_failure(unsigned long pfn, int flags)
> > +int memory_failure(unsigned long pfn, int flags, int *already)
> >  {
> >  	struct page *p;
> >  	struct page *hpage;
> > @@ -1428,6 +1428,8 @@ int memory_failure(unsigned long pfn, int flags)
> >  	if (PageHuge(p))
> >  		return memory_failure_hugetlb(pfn, flags);
> >  	if (TestSetPageHWPoison(p)) {
> > +		if (already)
> > +			*already = 1;
> >  		pr_err("Memory failure: %#lx: already hardware poisoned\n",
> >  			pfn);
> >  		return 0;
> > @@ -1634,7 +1636,7 @@ static void memory_failure_work_func(struct work_struct *work)
> >  		if (entry.flags & MF_SOFT_OFFLINE)
> >  			soft_offline_page(entry.pfn, entry.flags);
> >  		else
> > -			memory_failure(entry.pfn, entry.flags);
> > +			memory_failure(entry.pfn, entry.flags, NULL);
> >  	}
> >  }
> >  
> 



-- 
Thanks!
Aili Yao
