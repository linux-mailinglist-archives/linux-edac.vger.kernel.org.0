Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B290122E4F9
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 06:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgG0EcU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 00:32:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:24188 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgG0EcR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 00:32:17 -0400
IronPort-SDR: sv1s+BB8PkcTfceI8wWKA2Dn24YJQDuX+eDgjTRkqdAVV4XIw+zq8fwn05DmNSCBqQEu5OLhSX
 HN6aRwyA+K1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="131016891"
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="131016891"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 21:32:09 -0700
IronPort-SDR: lxSV+MiKR0bzOj6qJY8QtMUe9NSEMaWVg5PuBKbisZG8NidVF5ibPYIN++lx55pJXEALcR5cLp
 EU2h9K96mziQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="329550035"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2020 21:32:08 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>, linux-edac@vger.kernel.org
Subject: [PATCH 2/4] x86/cpu: Relocate sync_core() to sync_core.h
Date:   Sun, 26 Jul 2020 21:31:30 -0700
Message-Id: <20200727043132.15082-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Having sync_core() in processor.h is problematic since it is not possible
to check for hardware capabilities via the *cpu_has() family of macros.
The latter needs the definitions in processor.h.

It also looks more intuitive to relocate the function to sync_core.h.

This changeset does not make changes in functionality.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cathy Zhang <cathy.zhang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kyung Min Park <kyung.min.park@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
---
 arch/x86/include/asm/processor.h    | 64 -----------------------------
 arch/x86/include/asm/sync_core.h    | 64 +++++++++++++++++++++++++++++
 arch/x86/kernel/alternative.c       |  1 +
 arch/x86/kernel/cpu/mce/core.c      |  1 +
 drivers/misc/sgi-gru/grufault.c     |  1 +
 drivers/misc/sgi-gru/gruhandles.c   |  1 +
 drivers/misc/sgi-gru/grukservices.c |  1 +
 7 files changed, 69 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2a1f7e1d7151..97143d87994c 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -676,70 +676,6 @@ static inline unsigned int cpuid_edx(unsigned int op)
 	return edx;
 }
 
-/*
- * This function forces the icache and prefetched instruction stream to
- * catch up with reality in two very specific cases:
- *
- *  a) Text was modified using one virtual address and is about to be executed
- *     from the same physical page at a different virtual address.
- *
- *  b) Text was modified on a different CPU, may subsequently be
- *     executed on this CPU, and you want to make sure the new version
- *     gets executed.  This generally means you're calling this in a IPI.
- *
- * If you're calling this for a different reason, you're probably doing
- * it wrong.
- */
-static inline void sync_core(void)
-{
-	/*
-	 * There are quite a few ways to do this.  IRET-to-self is nice
-	 * because it works on every CPU, at any CPL (so it's compatible
-	 * with paravirtualization), and it never exits to a hypervisor.
-	 * The only down sides are that it's a bit slow (it seems to be
-	 * a bit more than 2x slower than the fastest options) and that
-	 * it unmasks NMIs.  The "push %cs" is needed because, in
-	 * paravirtual environments, __KERNEL_CS may not be a valid CS
-	 * value when we do IRET directly.
-	 *
-	 * In case NMI unmasking or performance ever becomes a problem,
-	 * the next best option appears to be MOV-to-CR2 and an
-	 * unconditional jump.  That sequence also works on all CPUs,
-	 * but it will fault at CPL3 (i.e. Xen PV).
-	 *
-	 * CPUID is the conventional way, but it's nasty: it doesn't
-	 * exist on some 486-like CPUs, and it usually exits to a
-	 * hypervisor.
-	 *
-	 * Like all of Linux's memory ordering operations, this is a
-	 * compiler barrier as well.
-	 */
-#ifdef CONFIG_X86_32
-	asm volatile (
-		"pushfl\n\t"
-		"pushl %%cs\n\t"
-		"pushl $1f\n\t"
-		"iret\n\t"
-		"1:"
-		: ASM_CALL_CONSTRAINT : : "memory");
-#else
-	unsigned int tmp;
-
-	asm volatile (
-		"mov %%ss, %0\n\t"
-		"pushq %q0\n\t"
-		"pushq %%rsp\n\t"
-		"addq $8, (%%rsp)\n\t"
-		"pushfq\n\t"
-		"mov %%cs, %0\n\t"
-		"pushq %q0\n\t"
-		"pushq $1f\n\t"
-		"iretq\n\t"
-		"1:"
-		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
-#endif
-}
-
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 extern void amd_e400_c1e_apic_setup(void);
 
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index c67caafd3381..9c5573f2c333 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -6,6 +6,70 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 
+/*
+ * This function forces the icache and prefetched instruction stream to
+ * catch up with reality in two very specific cases:
+ *
+ *  a) Text was modified using one virtual address and is about to be executed
+ *     from the same physical page at a different virtual address.
+ *
+ *  b) Text was modified on a different CPU, may subsequently be
+ *     executed on this CPU, and you want to make sure the new version
+ *     gets executed.  This generally means you're calling this in a IPI.
+ *
+ * If you're calling this for a different reason, you're probably doing
+ * it wrong.
+ */
+static inline void sync_core(void)
+{
+	/*
+	 * There are quite a few ways to do this.  IRET-to-self is nice
+	 * because it works on every CPU, at any CPL (so it's compatible
+	 * with paravirtualization), and it never exits to a hypervisor.
+	 * The only down sides are that it's a bit slow (it seems to be
+	 * a bit more than 2x slower than the fastest options) and that
+	 * it unmasks NMIs.  The "push %cs" is needed because, in
+	 * paravirtual environments, __KERNEL_CS may not be a valid CS
+	 * value when we do IRET directly.
+	 *
+	 * In case NMI unmasking or performance ever becomes a problem,
+	 * the next best option appears to be MOV-to-CR2 and an
+	 * unconditional jump.  That sequence also works on all CPUs,
+	 * but it will fault at CPL3 (i.e. Xen PV).
+	 *
+	 * CPUID is the conventional way, but it's nasty: it doesn't
+	 * exist on some 486-like CPUs, and it usually exits to a
+	 * hypervisor.
+	 *
+	 * Like all of Linux's memory ordering operations, this is a
+	 * compiler barrier as well.
+	 */
+#ifdef CONFIG_X86_32
+	asm volatile (
+		"pushfl\n\t"
+		"pushl %%cs\n\t"
+		"pushl $1f\n\t"
+		"iret\n\t"
+		"1:"
+		: ASM_CALL_CONSTRAINT : : "memory");
+#else
+	unsigned int tmp;
+
+	asm volatile (
+		"mov %%ss, %0\n\t"
+		"pushq %q0\n\t"
+		"pushq %%rsp\n\t"
+		"addq $8, (%%rsp)\n\t"
+		"pushfq\n\t"
+		"mov %%cs, %0\n\t"
+		"pushq %q0\n\t"
+		"pushq $1f\n\t"
+		"iretq\n\t"
+		"1:"
+		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
+#endif
+}
+
 /*
  * Ensure that a core serializing instruction is issued before returning
  * to user-mode. x86 implements return to user-space through sysexit,
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 20e07feb4064..3abc1316f91b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -16,6 +16,7 @@
 #include <linux/kprobes.h>
 #include <linux/mmu_context.h>
 #include <linux/bsearch.h>
+#include <linux/sync_core.h>
 #include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 1a0139d9a34b..e76c1ddd35e7 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -42,6 +42,7 @@
 #include <linux/export.h>
 #include <linux/jump_label.h>
 #include <linux/set_memory.h>
+#include <linux/sync_core.h>
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
 
diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index b1521112dbbd..723825524ea0 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
+#include <linux/sync_core.h>
 #include <linux/prefetch.h>
 #include "gru.h"
 #include "grutables.h"
diff --git a/drivers/misc/sgi-gru/gruhandles.c b/drivers/misc/sgi-gru/gruhandles.c
index f7224f90f413..1d75d5e540bc 100644
--- a/drivers/misc/sgi-gru/gruhandles.c
+++ b/drivers/misc/sgi-gru/gruhandles.c
@@ -16,6 +16,7 @@
 #define GRU_OPERATION_TIMEOUT	(((cycles_t) local_cpu_data->itc_freq)*10)
 #define CLKS2NSEC(c)		((c) *1000000000 / local_cpu_data->itc_freq)
 #else
+#include <linux/sync_core.h>
 #include <asm/tsc.h>
 #define GRU_OPERATION_TIMEOUT	((cycles_t) tsc_khz*10*1000)
 #define CLKS2NSEC(c)		((c) * 1000000 / tsc_khz)
diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/grukservices.c
index 0197441a1eae..f6e600bfac5d 100644
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -16,6 +16,7 @@
 #include <linux/miscdevice.h>
 #include <linux/proc_fs.h>
 #include <linux/interrupt.h>
+#include <linux/sync_core.h>
 #include <linux/uaccess.h>
 #include <linux/delay.h>
 #include <linux/export.h>
-- 
2.17.1

