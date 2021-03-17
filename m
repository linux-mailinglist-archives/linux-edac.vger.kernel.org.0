Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A26D33E2AE
	for <lists+linux-edac@lfdr.de>; Wed, 17 Mar 2021 01:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhCQA37 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Mar 2021 20:29:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:7010 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhCQA3m (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 16 Mar 2021 20:29:42 -0400
IronPort-SDR: WPfJs/q/9O4jLG05R6AuI9ltrv1Nsa6rYx3iOfLiRlDXx+1xzRdndg4HScU8i3yyrBzmbs+6/b
 ZM5Kn8VgVLYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="250719960"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="250719960"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 17:29:41 -0700
IronPort-SDR: 8/naJhP/XArpCeNVyMh1M+goB/9rxHj6N5kSc2TLdIcG9UNhk+FX3QjckiP7c/VfTKkK5EUXql
 73xj/LmbskuA==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="412431921"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 17:29:41 -0700
Date:   Tue, 16 Mar 2021 17:29:39 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>, Andy Lutomirski <luto@kernel.org>
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
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210317002939.GA276305@agluck-desk2.amr.corp.intel.com>
References: <20210304144524.795872d7@alex-virtual-machine>
 <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
 <20210305093016.40c87375@alex-virtual-machine>
 <aee5176eafb54c88b19a5b2671d0a1fc@intel.com>
 <20210310141042.4db9ea29@alex-virtual-machine>
 <20210311085529.GA22268@hori.linux.bs1.fc.nec.co.jp>
 <db80e98d2b264e988596d0d7d7c8a776@intel.com>
 <20210312135531.72e33b35@alex-virtual-machine>
 <3900f518d1324c388be52cf81f5220e4@intel.com>
 <af80221baed940d8bcc643e3e7d40036@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af80221baed940d8bcc643e3e7d40036@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 12, 2021 at 11:48:31PM +0000, Luck, Tony wrote:
> Thanks to the decode of the instruction we do have the virtual address. So we just need
> a safe walk of pgd->p4d->pud->pmd->pte (truncated if we hit a huge page) with a write
> of a "not-present" value. Maybe a different poison type from the one we get from
> memory_failure() so that the #PF code can recognize this as a special case and do any
> other work that we avoided because we were in #MC context.

There is no such thing as the safe walk I describe above. In a multi
threaded application other threads might munmap(2) bits of the address
space which could free some of the p4d->pud->pmd->pte tables.

But the pgd table is guaranteed to exist as long as any of the threads
in the process exist. Which gave rise to a new approach (partial credit
to Dave Hansen who helped me understand why a more extreme patch that
I wanted to use wasn't working ... and he pointed out the pgd persistence).

N.B. The code below DOES NOT WORK. My test application tried to do a write(2)
syscall with some poison in the buffer. Goal is that write should return a
short count (with only the bytes from the buffer leading up to the poison
written to the file). Currently the process gets a suprise SIGSEGV in
some glibc code :-(

The code would also need a bunch more work to handle the fact that
in a multi-threaded application multiple threads might consume the
poison, and some innocent threads not consuming the poison may also end
up drawn into the melee in the page fault handler.


The big picture.
---------------

This approach passes the buck for the recovery from the #MC handler
(which has very limited options to do anything useful) to the #PF
handler (which is a much friendlier environment where locks and mutexes
can be obtained as needed).

The mechanism for this buck passing is for the #MC handler to set a
reserved bit in the PGD entry for the user address where the machine
check happened, flush the TLB for that address, and then return from
the #MC handler to the kernel get_user()/copy_from_user() code which
will re-execute the instruction to access the poison address, but this
time take a #PF because of the reserved bit in the PGD.

There's a couple of changes bundled in here to help my debugging:
1) Turn off UCNA calls to memory_failure() ... just avoids races
   and make tests more determinstic for now
2) Disable "fast string" support ... avoid "REP MOVS" copy routines
   since I'm testing on an old system that treats poison consumed
   by REP MOVS as fatal.

Posted here for general comments on the approach.  On the plus
side it avoids taking multiple machine checks in the kernel when
it is accessing user data. I think it can also meet the goal set
by Andy Lutomirski of avoiding SIGBUS from syscalls that happen
to touch user poison. They should see either short counts for
calls like write(2) that may partially succeed or -EFAULT if
the system call totally failed.

-Tony

---

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index f24d7ef8fffa..e533eaf20834 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -23,6 +23,7 @@
 #define _PAGE_BIT_SOFTW2	10	/* " */
 #define _PAGE_BIT_SOFTW3	11	/* " */
 #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
+#define _PAGE_BIT_RESERVED1	51	/* Reserved bit */
 #define _PAGE_BIT_SOFTW4	58	/* available for programmer */
 #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
 #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
@@ -56,6 +57,7 @@
 #define _PAGE_PAT_LARGE (_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
 #define _PAGE_SPECIAL	(_AT(pteval_t, 1) << _PAGE_BIT_SPECIAL)
 #define _PAGE_CPA_TEST	(_AT(pteval_t, 1) << _PAGE_BIT_CPA_TEST)
+#define _PAGE_RESERVED1	(_AT(pteval_t, 1) << _PAGE_BIT_RESERVED1)
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 #define _PAGE_PKEY_BIT0	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT0)
 #define _PAGE_PKEY_BIT1	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT1)
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 7f7200021bd1..269e8ee04c11 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -45,4 +45,24 @@ void __noreturn handle_stack_overflow(const char *message,
 				      unsigned long fault_address);
 #endif
 
+static inline void pgd_set_reserved(pgd_t *pgdp, unsigned long addr)
+{
+	pgd_t	pgd;
+
+	pgdp += pgd_index(addr);
+	pgd = *pgdp;
+	pgd.pgd |= _PAGE_RESERVED1;
+	WRITE_ONCE(*pgdp, pgd);
+}
+
+static inline void pgd_clr_reserved(pgd_t *pgdp, unsigned long addr)
+{
+	pgd_t	pgd;
+
+	pgdp += pgd_index(addr);
+	pgd = *pgdp;
+	pgd.pgd &= ~_PAGE_RESERVED1;
+	WRITE_ONCE(*pgdp, pgd);
+}
+
 #endif /* _ASM_X86_TRAPS_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0e422a544835..974e1eb5d1aa 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -287,6 +287,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 */
 	if (c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xd)) {
 		rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
+misc_enable = 0;
 		if (!(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
 			pr_info("Disabled fast string operations\n");
 			setup_clear_cpu_cap(X86_FEATURE_REP_GOOD);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7962355436da..41bedc961928 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -635,6 +635,7 @@ static struct notifier_block early_nb = {
 static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
+#if 0
 	struct mce *mce = (struct mce *)data;
 	unsigned long pfn;
 
@@ -650,7 +651,7 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 		set_mce_nospec(pfn, whole_page(mce));
 		mce->kflags |= MCE_HANDLED_UC;
 	}
-
+#endif
 	return NOTIFY_OK;
 }
 
@@ -1443,8 +1444,18 @@ noinstr void do_machine_check(struct pt_regs *regs)
 				mce_panic("Failed kernel mode recovery", &m, msg);
 		}
 
-		if (m.kflags & MCE_IN_KERNEL_COPYIN)
-			queue_task_work(&m, kill_current_task);
+		/*
+		 * Machine check while copying from user space. Note that we
+		 * do not call fixup_exception(). Instead we ensure a page fault
+		 * when we return to the faulting instruction.
+		 * Let the page fault handler do the rest of the
+		 * recovery.
+		 */
+		if (m.kflags & MCE_IN_KERNEL_COPYIN) {
+			flush_tlb_one_user((unsigned long)current->mce_vaddr);
+			pgd_set_reserved(current->mm->pgd, (unsigned long)current->mce_vaddr);
+			current->mce_addr = m.addr;
+		}
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 83df991314c5..da917945150d 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -282,7 +282,6 @@ static int error_context(struct mce *m, struct pt_regs *regs)
 		return IN_KERNEL_RECOV;
 	}
 	if (t == EX_HANDLER_UACCESS && regs && is_copy_from_user(regs)) {
-		m->kflags |= MCE_IN_KERNEL_RECOV;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		return IN_KERNEL_RECOV;
 	}
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 77b9b2a3b5c8..e0e71ca023ce 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -234,24 +234,11 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  */
 SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 	movl %edx,%ecx
-	cmp $X86_TRAP_MC,%eax		/* check if X86_TRAP_MC */
-	je 3f
 1:	rep movsb
 2:	mov %ecx,%eax
 	ASM_CLAC
 	ret
 
-	/*
-	 * Return zero to pretend that this copy succeeded. This
-	 * is counter-intuitive, but needed to prevent the code
-	 * in lib/iov_iter.c from retrying and running back into
-	 * the poison cache line again. The machine check handler
-	 * will ensure that a SIGBUS is sent to the task.
-	 */
-3:	xorl %eax,%eax
-	ASM_CLAC
-	ret
-
 	_ASM_EXTABLE_CPY(1b, 2b)
 SYM_CODE_END(.Lcopy_user_handle_tail)
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a73347e2cdfc..49232264e893 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1245,9 +1245,13 @@ void do_user_addr_fault(struct pt_regs *regs,
 	/*
 	 * Reserved bits are never expected to be set on
 	 * entries in the user portion of the page tables.
+	 * Except when machine check handling of a copy from
+	 * user passed the buck to #PF.
 	 */
-	if (unlikely(error_code & X86_PF_RSVD))
-		pgtable_bad(regs, error_code, address);
+	if (unlikely(error_code & X86_PF_RSVD)) {
+		if (!current->mce_vaddr)
+			pgtable_bad(regs, error_code, address);
+	}
 
 	/*
 	 * If SMAP is on, check for invalid kernel (supervisor) access to user
@@ -1291,6 +1295,15 @@ void do_user_addr_fault(struct pt_regs *regs,
 			local_irq_enable();
 	}
 
+	if (current->mce_vaddr) {
+		pgd_clr_reserved(current->mm->pgd,
+				 (unsigned long)current->mce_vaddr);
+		memory_failure(current->mce_addr >> PAGE_SHIFT, 0);
+		current->mce_vaddr = 0;
+		error_code &= ~X86_PF_RSVD;
+		pr_info("#PF: maybe fixed? Try to continue\n");
+	}
+
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
 	if (error_code & X86_PF_WRITE)
