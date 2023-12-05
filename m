Return-Path: <linux-edac+bounces-202-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42636805296
	for <lists+linux-edac@lfdr.de>; Tue,  5 Dec 2023 12:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FF41F213E1
	for <lists+linux-edac@lfdr.de>; Tue,  5 Dec 2023 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777D55954E;
	Tue,  5 Dec 2023 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4GYCk61"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE0E1BF;
	Tue,  5 Dec 2023 03:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701775294; x=1733311294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EQkZcdlIGejyKoHaUNRbB39EMDdMWkYBuyy3w6bmovA=;
  b=B4GYCk61g1aKnMK9n3TxA/mIEtnW6wL8D9h3b0u3DSYKXCyQyvoKMPQK
   yp5RPCfT5LTK6w+Rj7ZIqxkuGvQBcjeE4B0KD45kyIdsnfQEP4cnoq1zl
   DdLu/cWhqHKEPqfHYoGNdLwZ3O3nLFn/A1F6nAm0Z4LL5VCGbmQ5t5Rhe
   OgqQL+azIDjeR9Ou7C9XeFmMdnva56gjTf2HvFp2d96VscRWyqmvOakXJ
   JrclCkQ6G4I/xTSbYXInwqSfAm5886MdI7e8KYqtO3EPv1e6JIzmft84v
   ljfaozePBiTWVUe6RHwpf0G1KyVjmRSceO8k+QmxYIeNk8xkXTLeD9Wkq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="942621"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="942621"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:21:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1018192992"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="1018192992"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2023 03:21:24 -0800
From: Xin Li <xin3.li@intel.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	peterz@infradead.org,
	jgross@suse.com,
	ravi.v.shankar@intel.com,
	mhiramat@kernel.org,
	andrew.cooper3@citrix.com,
	jiangshanlai@gmail.com,
	nik.borisov@suse.com,
	shan.kang@intel.com
Subject: [PATCH v13 26/35] x86/fred: FRED entry/exit and dispatch code
Date: Tue,  5 Dec 2023 02:50:15 -0800
Message-ID: <20231205105030.8698-27-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205105030.8698-1-xin3.li@intel.com>
References: <20231205105030.8698-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

The code to actually handle kernel and event entry/exit using
FRED. It is split up into two files thus:

- entry_64_fred.S contains the actual entrypoints and exit code, and
  saves and restores registers.
- entry_fred.c contains the two-level event dispatch code for FRED.
  The first-level dispatch is on the event type, and the second-level
  is on the event vector.

Originally-by: Megha Dey <megha.dey@intel.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Co-developed-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---

Changes since v10:
* Replace "IS_ENABLED(CONFIG_IA32_EMULATION)" with the new ia32_enabled()
  API (Nikolay Borisov).

Changes since v9:
* Don't use jump tables, indirect jumps are expensive (Thomas Gleixner).
* Except NMI/#DB/#MCE, FRED really can share the exception handlers
  with IDT (Thomas Gleixner).
* Avoid the sysvec_* idt_entry muck, do it at a central place, reuse code
  instead of blindly copying it, which breaks the performance optimized
  sysvec entries like reschedule_ipi (Thomas Gleixner).
* Add asm_ prefix to FRED asm entry points (Thomas Gleixner).

Changes since v8:
* Don't do syscall early out in fred_entry_from_user() before there are
  proper performance numbers and justifications (Thomas Gleixner).
* Add the control exception handler to the FRED exception handler table
  (Thomas Gleixner).
* Add ENDBR to the FRED_ENTER asm macro.
* Reflect the FRED spec 5.0 change that ERETS and ERETU add 8 to %rsp
  before popping the return context from the stack.

Changes since v1:
* Initialize a FRED exception handler to fred_bad_event() instead of NULL
  if no FRED handler defined for an exception vector (Peter Zijlstra).
* Push calling irqentry_{enter,exit}() and instrumentation_{begin,end}()
  down into individual FRED exception handlers, instead of in the dispatch
  framework (Peter Zijlstra).
---
 arch/x86/entry/Makefile               |   5 +-
 arch/x86/entry/entry_64_fred.S        |  52 ++++++
 arch/x86/entry/entry_fred.c           | 230 ++++++++++++++++++++++++++
 arch/x86/include/asm/asm-prototypes.h |   1 +
 arch/x86/include/asm/fred.h           |   6 +
 5 files changed, 293 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/entry/entry_64_fred.S
 create mode 100644 arch/x86/entry/entry_fred.c

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index ca2fe186994b..c93e7f5c2a06 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -18,6 +18,9 @@ obj-y				+= vdso/
 obj-y				+= vsyscall/
 
 obj-$(CONFIG_PREEMPTION)	+= thunk_$(BITS).o
+CFLAGS_entry_fred.o		+= -fno-stack-protector
+CFLAGS_REMOVE_entry_fred.o	+= -pg $(CC_FLAGS_FTRACE)
+obj-$(CONFIG_X86_FRED)		+= entry_64_fred.o entry_fred.o
+
 obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
 obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
-
diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
new file mode 100644
index 000000000000..37a1dd5e8ace
--- /dev/null
+++ b/arch/x86/entry/entry_64_fred.S
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The actual FRED entry points.
+ */
+
+#include <asm/fred.h>
+
+#include "calling.h"
+
+	.code64
+	.section .noinstr.text, "ax"
+
+.macro FRED_ENTER
+	UNWIND_HINT_END_OF_STACK
+	ENDBR
+	PUSH_AND_CLEAR_REGS
+	movq	%rsp, %rdi	/* %rdi -> pt_regs */
+.endm
+
+.macro FRED_EXIT
+	UNWIND_HINT_REGS
+	POP_REGS
+.endm
+
+/*
+ * The new RIP value that FRED event delivery establishes is
+ * IA32_FRED_CONFIG & ~FFFH for events that occur in ring 3.
+ * Thus the FRED ring 3 entry point must be 4K page aligned.
+ */
+	.align 4096
+
+SYM_CODE_START_NOALIGN(asm_fred_entrypoint_user)
+	FRED_ENTER
+	call	fred_entry_from_user
+	FRED_EXIT
+	ERETU
+SYM_CODE_END(asm_fred_entrypoint_user)
+
+.fill asm_fred_entrypoint_kernel - ., 1, 0xcc
+
+/*
+ * The new RIP value that FRED event delivery establishes is
+ * (IA32_FRED_CONFIG & ~FFFH) + 256 for events that occur in
+ * ring 0, i.e., asm_fred_entrypoint_user + 256.
+ */
+	.org asm_fred_entrypoint_user + 256
+SYM_CODE_START_NOALIGN(asm_fred_entrypoint_kernel)
+	FRED_ENTER
+	call	fred_entry_from_kernel
+	FRED_EXIT
+	ERETS
+SYM_CODE_END(asm_fred_entrypoint_kernel)
diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
new file mode 100644
index 000000000000..215883e90f94
--- /dev/null
+++ b/arch/x86/entry/entry_fred.c
@@ -0,0 +1,230 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The FRED specific kernel/user entry functions which are invoked from
+ * assembly code and dispatch to the associated handlers.
+ */
+#include <linux/kernel.h>
+#include <linux/kdebug.h>
+#include <linux/nospec.h>
+
+#include <asm/desc.h>
+#include <asm/fred.h>
+#include <asm/idtentry.h>
+#include <asm/syscall.h>
+#include <asm/trapnr.h>
+#include <asm/traps.h>
+
+/* FRED EVENT_TYPE_OTHER vector numbers */
+#define FRED_SYSCALL			1
+#define FRED_SYSENTER			2
+
+static noinstr void fred_bad_type(struct pt_regs *regs, unsigned long error_code)
+{
+	irqentry_state_t irq_state = irqentry_nmi_enter(regs);
+
+	instrumentation_begin();
+
+	/* Panic on events from a high stack level */
+	if (regs->fred_cs.sl > 0) {
+		pr_emerg("PANIC: invalid or fatal FRED event; event type %u "
+			 "vector %u error 0x%lx aux 0x%lx at %04x:%016lx\n",
+			 regs->fred_ss.type, regs->fred_ss.vector, regs->orig_ax,
+			 fred_event_data(regs), regs->cs, regs->ip);
+		die("invalid or fatal FRED event", regs, regs->orig_ax);
+		panic("invalid or fatal FRED event");
+	} else {
+		unsigned long flags = oops_begin();
+		int sig = SIGKILL;
+
+		pr_alert("BUG: invalid or fatal FRED event; event type %u "
+			 "vector %u error 0x%lx aux 0x%lx at %04x:%016lx\n",
+			 regs->fred_ss.type, regs->fred_ss.vector, regs->orig_ax,
+			 fred_event_data(regs), regs->cs, regs->ip);
+
+		if (__die("Invalid or fatal FRED event", regs, regs->orig_ax))
+			sig = 0;
+
+		oops_end(flags, regs, sig);
+	}
+
+	instrumentation_end();
+	irqentry_nmi_exit(regs, irq_state);
+}
+
+static noinstr void fred_intx(struct pt_regs *regs)
+{
+	switch (regs->fred_ss.vector) {
+	/* INT0 */
+	case X86_TRAP_OF:
+		exc_overflow(regs);
+		return;
+
+	/* INT3 */
+	case X86_TRAP_BP:
+		exc_int3(regs);
+		return;
+
+	/* INT80 */
+	case IA32_SYSCALL_VECTOR:
+		if (ia32_enabled()) {
+			/* Save the syscall number */
+			regs->orig_ax = regs->ax;
+			regs->ax = -ENOSYS;
+			do_int80_syscall_32(regs);
+			return;
+		}
+		fallthrough;
+
+	default:
+		exc_general_protection(regs, 0);
+		return;
+	}
+}
+
+static __always_inline void fred_other(struct pt_regs *regs)
+{
+	/* The compiler can fold these conditions into a single test */
+	if (likely(regs->fred_ss.vector == FRED_SYSCALL && regs->fred_ss.lm)) {
+		regs->orig_ax = regs->ax;
+		regs->ax = -ENOSYS;
+		do_syscall_64(regs, regs->orig_ax);
+		return;
+	} else if (ia32_enabled() &&
+		   likely(regs->fred_ss.vector == FRED_SYSENTER &&
+			  !regs->fred_ss.lm)) {
+		regs->orig_ax = regs->ax;
+		regs->ax = -ENOSYS;
+		do_fast_syscall_32(regs);
+		return;
+	} else {
+		exc_invalid_op(regs);
+		return;
+	}
+}
+
+#define SYSVEC(_vector, _function) [_vector - FIRST_SYSTEM_VECTOR] = fred_sysvec_##_function
+
+static idtentry_t sysvec_table[NR_SYSTEM_VECTORS] __ro_after_init = {
+	SYSVEC(ERROR_APIC_VECTOR,		error_interrupt),
+	SYSVEC(SPURIOUS_APIC_VECTOR,		spurious_apic_interrupt),
+	SYSVEC(LOCAL_TIMER_VECTOR,		apic_timer_interrupt),
+	SYSVEC(X86_PLATFORM_IPI_VECTOR,		x86_platform_ipi),
+
+	SYSVEC(RESCHEDULE_VECTOR,		reschedule_ipi),
+	SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	call_function_single),
+	SYSVEC(CALL_FUNCTION_VECTOR,		call_function),
+	SYSVEC(REBOOT_VECTOR,			reboot),
+
+	SYSVEC(THRESHOLD_APIC_VECTOR,		threshold),
+	SYSVEC(DEFERRED_ERROR_VECTOR,		deferred_error),
+	SYSVEC(THERMAL_APIC_VECTOR,		thermal),
+
+	SYSVEC(IRQ_WORK_VECTOR,			irq_work),
+
+	SYSVEC(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
+	SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	kvm_posted_intr_wakeup_ipi),
+	SYSVEC(POSTED_INTR_NESTED_VECTOR,	kvm_posted_intr_nested_ipi),
+};
+
+static noinstr void fred_extint(struct pt_regs *regs)
+{
+	unsigned int vector = regs->fred_ss.vector;
+
+	if (WARN_ON_ONCE(vector < FIRST_EXTERNAL_VECTOR))
+		return;
+
+	if (likely(vector >= FIRST_SYSTEM_VECTOR)) {
+		irqentry_state_t state = irqentry_enter(regs);
+
+		instrumentation_begin();
+		sysvec_table[vector - FIRST_SYSTEM_VECTOR](regs);
+		instrumentation_end();
+		irqentry_exit(regs, state);
+	} else {
+		common_interrupt(regs, vector);
+	}
+}
+
+static noinstr void fred_exception(struct pt_regs *regs, unsigned long error_code)
+{
+	/* Optimize for #PF. That's the only exception which matters performance wise */
+	if (likely(regs->fred_ss.vector == X86_TRAP_PF)) {
+		exc_page_fault(regs, error_code);
+		return;
+	}
+
+	switch (regs->fred_ss.vector) {
+	case X86_TRAP_DE: return exc_divide_error(regs);
+	case X86_TRAP_DB: return fred_exc_debug(regs);
+	case X86_TRAP_BP: return exc_int3(regs);
+	case X86_TRAP_OF: return exc_overflow(regs);
+	case X86_TRAP_BR: return exc_bounds(regs);
+	case X86_TRAP_UD: return exc_invalid_op(regs);
+	case X86_TRAP_NM: return exc_device_not_available(regs);
+	case X86_TRAP_DF: return exc_double_fault(regs, error_code);
+	case X86_TRAP_TS: return exc_invalid_tss(regs, error_code);
+	case X86_TRAP_NP: return exc_segment_not_present(regs, error_code);
+	case X86_TRAP_SS: return exc_stack_segment(regs, error_code);
+	case X86_TRAP_GP: return exc_general_protection(regs, error_code);
+	case X86_TRAP_MF: return exc_coprocessor_error(regs);
+	case X86_TRAP_AC: return exc_alignment_check(regs, error_code);
+	case X86_TRAP_XF: return exc_simd_coprocessor_error(regs);
+
+#ifdef CONFIG_X86_MCE
+	case X86_TRAP_MC: return fred_exc_machine_check(regs);
+#endif
+#ifdef CONFIG_INTEL_TDX_GUEST
+	case X86_TRAP_VE: return exc_virtualization_exception(regs);
+#endif
+#ifdef CONFIG_X86_KERNEL_IBT
+	case X86_TRAP_CP: return exc_control_protection(regs, error_code);
+#endif
+	default: return fred_bad_type(regs, error_code);
+	}
+}
+
+__visible noinstr void fred_entry_from_user(struct pt_regs *regs)
+{
+	unsigned long error_code = regs->orig_ax;
+
+	/* Invalidate orig_ax so that syscall_get_nr() works correctly */
+	regs->orig_ax = -1;
+
+	switch (regs->fred_ss.type) {
+	case EVENT_TYPE_EXTINT:
+		return fred_extint(regs);
+	case EVENT_TYPE_NMI:
+		return fred_exc_nmi(regs);
+	case EVENT_TYPE_SWINT:
+		return fred_intx(regs);
+	case EVENT_TYPE_HWEXC:
+	case EVENT_TYPE_SWEXC:
+	case EVENT_TYPE_PRIV_SWEXC:
+		return fred_exception(regs, error_code);
+	case EVENT_TYPE_OTHER:
+		return fred_other(regs);
+	default:
+		return fred_bad_type(regs, error_code);
+	}
+}
+
+__visible noinstr void fred_entry_from_kernel(struct pt_regs *regs)
+{
+	unsigned long error_code = regs->orig_ax;
+
+	/* Invalidate orig_ax so that syscall_get_nr() works correctly */
+	regs->orig_ax = -1;
+
+	switch (regs->fred_ss.type) {
+	case EVENT_TYPE_EXTINT:
+		return fred_extint(regs);
+	case EVENT_TYPE_NMI:
+		return fred_exc_nmi(regs);
+	case EVENT_TYPE_HWEXC:
+	case EVENT_TYPE_SWEXC:
+	case EVENT_TYPE_PRIV_SWEXC:
+		return fred_exception(regs, error_code);
+	default:
+		return fred_bad_type(regs, error_code);
+	}
+}
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index b1a98fa38828..076bf8dee702 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -12,6 +12,7 @@
 #include <asm/special_insns.h>
 #include <asm/preempt.h>
 #include <asm/asm.h>
+#include <asm/fred.h>
 #include <asm/gsseg.h>
 
 #ifndef CONFIG_X86_CMPXCHG64
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index f514fdb5a39f..16a64ffecbf8 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -60,6 +60,12 @@ static __always_inline unsigned long fred_event_data(struct pt_regs *regs)
 	return fred_info(regs)->edata;
 }
 
+void asm_fred_entrypoint_user(void);
+void asm_fred_entrypoint_kernel(void);
+
+__visible void fred_entry_from_user(struct pt_regs *regs);
+__visible void fred_entry_from_kernel(struct pt_regs *regs);
+
 #else /* CONFIG_X86_FRED */
 static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { return 0; }
 #endif /* CONFIG_X86_FRED */
-- 
2.43.0


