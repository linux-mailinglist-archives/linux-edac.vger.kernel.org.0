Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534AA3335B8
	for <lists+linux-edac@lfdr.de>; Wed, 10 Mar 2021 07:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhCJGLS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 10 Mar 2021 01:11:18 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:14202 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhCJGKr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Mar 2021 01:10:47 -0500
X-AuditID: 0a580155-1f5ff7000005482e-70-60485b66f134
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 8A.93.18478.66B58406; Wed, 10 Mar 2021 13:38:46 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 10 Mar
 2021 14:10:43 +0800
Date:   Wed, 10 Mar 2021 14:10:42 +0800
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
Message-ID: <20210310141042.4db9ea29@alex-virtual-machine>
In-Reply-To: <aee5176eafb54c88b19a5b2671d0a1fc@intel.com>
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
        <aee5176eafb54c88b19a5b2671d0a1fc@intel.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsXCFcGooJsW7ZFgcOGGpMWc9WvYLD5v+Mdm
        8XX9L2aLaRvFLS6camCyuLxrDpvFvTX/WS0uHVjAZHGx8QCjxZlpRRabN01ltnhz4R6LxY8N
        j1kdeD2+t/axeCze85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHi+ubmTxeL/vKpvH5tPVHp83
        yXmcaPnCGsAdxWWTkpqTWZZapG+XwJXx7fgK5oIb6hXbT7UwNjB+luti5OSQEDCRmHR3CmsX
        IxeHkMB0JonFf+8zQjivGCWu7/jJ0sXIwcEioCqx6XMySAMbkLnr3ixWEFtEQE3i0uIHzCD1
        zAKzWSVOTT7LDJIQFvCS+HJ/LSOIzStgJfHlygSwBk4BS4lPPavA4kICK1klPs/1ArH5BcQk
        eq/8Z4K4yF6ibcsiqF5BiZMzn7CA2MwCOhInVh1jhrC1JZYtfM0MMUdR4vCSX+wQvUoSR7pn
        sEHYsRLL5r1incAoPAvJqFlIRs1CMmoBI/MqRpbi3HSjTYyQ+AvdwTij6aPeIUYmDsZDjBIc
        zEoivH7H3RKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8+495pogJJCeWJKanZpakFoEk2Xi4JRq
        YGo4krt5a/A7Rqbm48f4pC6VfHqaL1U7922z1yHtPa2Tdtl0W3a4VxT9MG1euvHkneWqgal9
        z6UiOq+4/n4+r8Glc1Wt9M2EzIsZE27rVEwW5Qo8oKRmZH/D6MOxdx4i7c7Bm9U/RdTFCDn6
        iWsv+lnutKL254Oobe1bH39TmF1vOOWuwf91TZtWHIw3bLHeVfEvxUGV4+mLlbc2C7pabdid
        UnKW+XWd/3Unn8f27TbBt7gu71/a++DQyeBPbfk1l1mf897/ducI63e+H+uyi9e1mV8MeBNT
        O8XoyrptjQfadCy4BJxaGc/bnPjhrbek1PHRm2K3dcemVQi0CZ5WSdgl4aTYG8Mom/0xZvpF
        HSWW4oxEQy3mouJEAEtHZ50uAwAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, 5 Mar 2021 15:55:25 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> > From the walk, it seems we have got the virtual address, can we just send a SIGBUS with it?  
> 
> If the walk wins the race and the pte for the poisoned page is still valid, then yes.
> 
> But we could have:
> 
> CPU1                            CPU2
> memory_failure sets poison
> bit for struct page
> 
> 
> rmap finds page in task
> on CPU2 and sets PTE
> to not-valid-poison
> 
>                                 memory_failure returns
>                                 early because struct page
>                                 already marked as poison
> 
>                                 walk page tables looking
>                                 for mapping - don't find it
> 
> -Tony

While I don't think there is a race condition, and if you really think the pfn with SIGBUS is not
proper, I think following patch maybe one way.
I copy your abandon code, and make a little modification, and just now it pass
my simple test.

And also this is a RFC version, only valid if you think the pfn with SIGBUS is not right.

Thanks!

From a522ab8856e3a332a2318d57bb19f3c59594d462 Mon Sep 17 00:00:00 2001
From: Aili Yao <yaoaili@kingsoft.com>
Date: Wed, 10 Mar 2021 13:59:18 +0800
Subject: [PATCH] x86/mce: fix invalid SIGBUS address

walk the current process pte and compare with the pfn;
1. only test for normal page and 2M hugetlb page;
2. 1G hugetlb and transparentHuge is not support currently;
3. May other fails is not recognized, This is a RFC version.

---
 arch/x86/kernel/cpu/mce/core.c | 83 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index db4afc5..65d7ef7 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -28,8 +28,12 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/hugetlb.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 #include <linux/init.h>
 #include <linux/kmod.h>
+#include <linux/pagewalk.h>
 #include <linux/poll.h>
 #include <linux/nmi.h>
 #include <linux/cpu.h>
@@ -1235,6 +1239,81 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 	/* mce_clear_state will clear *final, save locally for use later */
 	*m = *final;
 }
+static int mc_pte_entry(pte_t *pte, unsigned long addr, unsigned long next, struct mm_walk *walk)
+{
+	u64 *buff = (u64 *)walk->private;
+	u64 pfn = buff[0];
+
+	if (!pte_present(*pte) && is_hwpoison_entry(pte_to_swp_entry(*pte)))
+		goto find;
+	else if (pte_pfn(*pte) == pfn)
+		goto find;
+
+	return 0;
+find:
+	buff[0] = addr;
+	buff[1] = PAGE_SHIFT;
+	return true;
+}
+
+extern bool is_hugetlb_entry_hwpoisoned(pte_t pte);
+
+static int mc_hugetlb_range(pte_t *ptep, unsigned long hmask,
+				 unsigned long addr, unsigned long end,
+				 struct mm_walk *walk)
+{
+	u64 *buff = (u64 *)walk->private;
+	u64 pfn = buff[0];
+	int shift = PMD_SHIFT;
+	pte_t pte =  huge_ptep_get(ptep);
+
+	if (unlikely(is_hugetlb_entry_hwpoisoned(pte)))
+		goto find;
+
+	if (pte_pfn(*ptep) == pfn)
+		goto find;
+
+	return 0;
+find:
+	buff[0] = addr;
+	buff[1] = shift;
+	return true;
+}
+
+static struct mm_walk_ops walk = {
+	.pte_entry = mc_pte_entry,
+	.hugetlb_entry	= mc_hugetlb_range
+};
+
+void mc_memory_failure_error(struct task_struct *p, unsigned long pfn)
+{
+	u64 buff[2] = {pfn, 0};
+	struct page *page;
+	int ret = -1;
+
+	page = pfn_to_page(pfn);
+	if (!page)
+		goto force_sigbus;
+
+	if (is_zone_device_page(page))
+		goto force_sigbus;
+
+	mmap_read_lock(p->mm);
+	ret = walk_page_range(p->mm, 0, TASK_SIZE_MAX, &walk, (void *)buff);
+	mmap_read_unlock(p->mm);
+
+	if (ret && buff[0]) {
+		pr_err("Memory error may not recovered: %#llx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
+		buff[0], p->comm, p->pid);
+		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)buff[0], buff[1]);
+	} else {
+force_sigbus:
+		pr_err("Memory error may not recovered, pfn: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
+		pfn, p->comm, p->pid);
+		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)pfn, PAGE_SHIFT);
+	}
+
+}
 
 static void kill_me_now(struct callback_head *ch)
 {
@@ -1259,9 +1338,7 @@ static void kill_me_maybe(struct callback_head *cb)
 	}
 
 	if (p->mce_vaddr != (void __user *)-1l) {
-		pr_err("Memory error may not recovered: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
-			p->mce_addr >> PAGE_SHIFT, p->comm, p->pid);
-		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
+		mc_memory_failure_error(current, p->mce_addr >> PAGE_SHIFT);
 	} else {
 		pr_err("Memory error not recovered");
 		kill_me_now(cb);
-- 
1.8.3.1



-- 
Thanks!
Aili Yao
