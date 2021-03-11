Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36E1337116
	for <lists+linux-edac@lfdr.de>; Thu, 11 Mar 2021 12:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhCKLYT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Thu, 11 Mar 2021 06:24:19 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:14549 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhCKLYD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Mar 2021 06:24:03 -0500
X-AuditID: 0a580157-47bff70000021a79-b6-6049f721b84a
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id E4.5D.06777.127F9406; Thu, 11 Mar 2021 18:55:29 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 11 Mar
 2021 19:23:58 +0800
Date:   Thu, 11 Mar 2021 19:23:58 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
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
        <yaoaili@kingsoft.com>, <sunhao2@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210311192358.62915aa7@alex-virtual-machine>
In-Reply-To: <20210311085529.GA22268@hori.linux.bs1.fc.nec.co.jp>
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
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsXCFcGooKv43TPBYNcNQ4s569ewWXze8I/N
        4uv6X8wW0zaKW1w41cBkcXnXHDaLe2v+s1pcOrCAyeJi4wFGizPTiiw2b5rKbPHmwj0Wix8b
        HrM68Hp8b+1j8Vi85yWTx6ZVnWwemz5NYvd4d+4cu8eJGb9ZPF5c3cji8X7fVTaPzaerPT5v
        kvM40fKFNYA7issmJTUnsyy1SN8ugStj78lvLAXbzCueHV3O1MDYpdXFyMkhIWAisfjWYuYu
        Ri4OIYHpTBKnHpxigXBeMUq07t/G1MXIwcEioCpxqU0SpIENyNx1bxYriC0ikCSxePZXJpB6
        ZoHvLBKtx2+xgSSEBbwkvtxfywjSyytgJXF+RRSIySngKLFnvgbE+I0sEifunAGbwy8gJtF7
        5T8TxEH2Em1bFjGC2LwCghInZz5hAbGZBTQlWrf/ZoewtSWWLXzNDGILCShKHF7yix2iV0ni
        SPcMNgg7VmLZvFesExiFZyEZNQvJqFlIRi1gZF7FyFKcm264iRESfeE7GOc1fdQ7xMjEwXiI
        UYKDWUmE1++4W4IQb0piZVVqUX58UWlOavEhRmkOFiVx3ssVnglCAumJJanZqakFqUUwWSYO
        TqkGpqTt89Jajz37vFJ3T9+7m6JVchxX3s5PvN2wiL/5fvWlX7d7LbkCTtS1OG/mypRc9PD8
        Ast9WxTXyt5d97fLQm2rh80W54kFbFu4EvKup9Y8lTyV/fJB4LUwE1UVoT0XyiK8q7cHX+i5
        d/nrz3N/2p7fXyKz9ZAKX6ikt3CT/V3rV8b7fvDu337CfUaeSW7s27ksTg737L+JvAvcaG01
        Vf1M6av9Mg11Em5dc7TbtzDPnur/zM3h2+LmnhuZbOl6DcwPF/w/EVqxN+z+KfUdH/huVcmZ
        /1y+82dI1nHm96ahjtOfnWlhiP6z4dIEffPtSdGr1G3nlc/Qvam8yfwk2/8F8+YZeb57Y916
        Z9eW+FQlluKMREMt5qLiRAAhjk/mLQMAAA==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 11 Mar 2021 08:55:30 +0000
HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> On Wed, Mar 10, 2021 at 02:10:42PM +0800, Aili Yao wrote:
> > On Fri, 5 Mar 2021 15:55:25 +0000
> > "Luck, Tony" <tony.luck@intel.com> wrote:
> >   
> > > > From the walk, it seems we have got the virtual address, can we just send a SIGBUS with it?    
> > > 
> > > If the walk wins the race and the pte for the poisoned page is still valid, then yes.
> > > 
> > > But we could have:
> > > 
> > > CPU1                            CPU2
> > > memory_failure sets poison
> > > bit for struct page
> > > 
> > > 
> > > rmap finds page in task
> > > on CPU2 and sets PTE
> > > to not-valid-poison
> > > 
> > >                                 memory_failure returns
> > >                                 early because struct page
> > >                                 already marked as poison
> > > 
> > >                                 walk page tables looking
> > >                                 for mapping - don't find it
> > > 
> > > -Tony  
> > 
> > While I don't think there is a race condition, and if you really think the pfn with SIGBUS is not
> > proper, I think following patch maybe one way.
> > I copy your abandon code, and make a little modification, and just now it pass
> > my simple test.
> > 
> > And also this is a RFC version, only valid if you think the pfn with SIGBUS is not right.
> > 
> > Thanks!
> > 
> > From a522ab8856e3a332a2318d57bb19f3c59594d462 Mon Sep 17 00:00:00 2001
> > From: Aili Yao <yaoaili@kingsoft.com>
> > Date: Wed, 10 Mar 2021 13:59:18 +0800
> > Subject: [PATCH] x86/mce: fix invalid SIGBUS address
> > 
> > walk the current process pte and compare with the pfn;
> > 1. only test for normal page and 2M hugetlb page;
> > 2. 1G hugetlb and transparentHuge is not support currently;
> > 3. May other fails is not recognized, This is a RFC version.
> > 
> > ---
> >  arch/x86/kernel/cpu/mce/core.c | 83 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 80 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> > index db4afc5..65d7ef7 100644
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
> 
> Maybe requiring many dependencies like this implies that you might be better
> to do below in mm/memory-failure.c instead of in this file.

Yes, agree, I will change this, Thanks!
 
> > @@ -1235,6 +1239,81 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
> >  	/* mce_clear_state will clear *final, save locally for use later */
> >  	*m = *final;
> >  }
> > +static int mc_pte_entry(pte_t *pte, unsigned long addr, unsigned long next, struct mm_walk *walk)
> > +{
> > +	u64 *buff = (u64 *)walk->private;
> > +	u64 pfn = buff[0];
> > +
> > +	if (!pte_present(*pte) && is_hwpoison_entry(pte_to_swp_entry(*pte)))
> > +		goto find;
> > +	else if (pte_pfn(*pte) == pfn)
> > +		goto find;
> > +
> > +	return 0;
> > +find:
> > +	buff[0] = addr;
> > +	buff[1] = PAGE_SHIFT;
> > +	return true;  
> 
> Returning true means you stop walking when you find the first entry pointing
> to a given pfn. But there could be multiple such entries, so if MCE SRAR is
> triggered by memory access to the larger address in hwpoisoned entries, the
> returned virtual address might be wrong.

Yes, We need to consider multiple posion page entries, I will fix this. Thanks for
you sugguestion!


> > +}
> > +
> > +extern bool is_hugetlb_entry_hwpoisoned(pte_t pte);
> > +
> > +static int mc_hugetlb_range(pte_t *ptep, unsigned long hmask,
> > +				 unsigned long addr, unsigned long end,
> > +				 struct mm_walk *walk)
> > +{
> > +	u64 *buff = (u64 *)walk->private;
> > +	u64 pfn = buff[0];
> > +	int shift = PMD_SHIFT;
> > +	pte_t pte =  huge_ptep_get(ptep);
> > +
> > +	if (unlikely(is_hugetlb_entry_hwpoisoned(pte)))
> > +		goto find;
> > +
> > +	if (pte_pfn(*ptep) == pfn)
> > +		goto find;
> > +
> > +	return 0;
> > +find:
> > +	buff[0] = addr;
> > +	buff[1] = shift;
> > +	return true;
> > +}
> > +
> > +static struct mm_walk_ops walk = {
> > +	.pte_entry = mc_pte_entry,
> > +	.hugetlb_entry	= mc_hugetlb_range
> > +};
> > +
> > +void mc_memory_failure_error(struct task_struct *p, unsigned long pfn)
> > +{
> > +	u64 buff[2] = {pfn, 0};
> > +	struct page *page;
> > +	int ret = -1;
> > +
> > +	page = pfn_to_page(pfn);
> > +	if (!page)
> > +		goto force_sigbus;
> > +
> > +	if (is_zone_device_page(page))
> > +		goto force_sigbus;
> > +
> > +	mmap_read_lock(p->mm);
> > +	ret = walk_page_range(p->mm, 0, TASK_SIZE_MAX, &walk, (void *)buff);
> > +	mmap_read_unlock(p->mm);
> > +
> > +	if (ret && buff[0]) {
> > +		pr_err("Memory error may not recovered: %#llx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
> > +		buff[0], p->comm, p->pid);
> > +		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)buff[0], buff[1]);
> > +	} else {
> > +force_sigbus:
> > +		pr_err("Memory error may not recovered, pfn: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
> > +		pfn, p->comm, p->pid);
> > +		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)pfn, PAGE_SHIFT);
> > +	}
> > +
> > +}
> >  
> >  static void kill_me_now(struct callback_head *ch)
> >  {
> > @@ -1259,9 +1338,7 @@ static void kill_me_maybe(struct callback_head *cb)
> >  	}
> >  
> >  	if (p->mce_vaddr != (void __user *)-1l) {
> > -		pr_err("Memory error may not recovered: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
> > -			p->mce_addr >> PAGE_SHIFT, p->comm, p->pid);
> > -		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
> > +		mc_memory_failure_error(current, p->mce_addr >> PAGE_SHIFT);  
> 
> I guess that p->mce_vaddr stores the virtual address of the error here.
> If so, sending SIGBUS with the address looks enough as we do now, so why
> do you walk page table to find the error virtual address?

I check the code again, yes, I should have placed mc_memory_failure_error in else branch, but it seems p->mce_vaddr is not correctly
initialized and for my test, it has a zero value then code goes into if (p->mce_vaddr != (void __user *)-1l) branch; It seems this is
another issue needing to fix;

And from the p->mce_vaddr, possibly there is a better way to get vaddr, i will dig more about this.

-- 
Thanks!
Aili Yao
