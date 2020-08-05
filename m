Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E22423C34F
	for <lists+linux-edac@lfdr.de>; Wed,  5 Aug 2020 04:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgHECL1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Aug 2020 22:11:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:55732 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgHECL1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 4 Aug 2020 22:11:27 -0400
IronPort-SDR: 3CoqdszJAmEkmZm16I/Z4L0T/QtF9f57ymX4mbDM2DyIfHaeFSp+U+1JTA1ScaBsLrj9BYID69
 i/kqkY2wELxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="132527039"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="132527039"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 19:11:26 -0700
IronPort-SDR: 7YZv9kSyXHYI1/6wKsTsJNloUdG9Cga/wALKClNATycnIJE6k2WjwseoQyZ1ZcyItT6NMQwClN
 hE46hxDjbpYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="322962027"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2020 19:11:26 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH v2] x86/cpu: Use SERIALIZE in sync_core() when available
Date:   Tue,  4 Aug 2020 19:10:59 -0700
Message-Id: <20200805021059.1331-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The SERIALIZE instruction gives software a way to force the processor to
complete all modifications to flags, registers and memory from previous
instructions and drain all buffered writes to memory before the next
instruction is fetched and executed. Thus, it serves the purpose of
sync_core(). Use it when available.

Commit 7117f16bf460 ("objtool: Fix ORC vs alternatives") enforced stack
invariance in alternatives. The iret-to-self does not comply with such
invariance. Thus, it cannot be used inside alternative code. Instead, use
an alternative that jumps to SERIALIZE when available.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cathy Zhang <cathy.zhang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kyung Min Park <kyung.min.park@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
This is a v2 from my initial submission [1]. The first three patches of
the series have been merged in Linus' tree. Hence, I am submitting only
this patch for review.

[1]. https://lkml.org/lkml/2020/7/27/8

Changes since v1:
 * Support SERIALIZE using alternative runtime patching.
   (Peter Zijlstra, H. Peter Anvin)
 * Added a note to specify which version of binutils supports SERIALIZE.
   (Peter Zijlstra)
 * Verified that (::: "memory") is used. (H. Peter Anvin)
---
 arch/x86/include/asm/special_insns.h |  2 ++
 arch/x86/include/asm/sync_core.h     | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 59a3e13204c3..25cd67801dda 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -10,6 +10,8 @@
 #include <linux/irqflags.h>
 #include <linux/jump_label.h>
 
+/* Instruction opcode for SERIALIZE; supported in binutils >= 2.35. */
+#define __ASM_SERIALIZE ".byte 0xf, 0x1, 0xe8"
 /*
  * Volatile isn't enough to prevent the compiler from reordering the
  * read/write functions for the control registers and messing everything up.
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index fdb5b356e59b..201ea3d9a6bd 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -5,15 +5,19 @@
 #include <linux/preempt.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
+#include <asm/special_insns.h>
 
 #ifdef CONFIG_X86_32
 static inline void iret_to_self(void)
 {
 	asm volatile (
+		ALTERNATIVE("", "jmp 2f", X86_FEATURE_SERIALIZE)
 		"pushfl\n\t"
 		"pushl %%cs\n\t"
 		"pushl $1f\n\t"
 		"iret\n\t"
+		"2:\n\t"
+		__ASM_SERIALIZE "\n"
 		"1:"
 		: ASM_CALL_CONSTRAINT : : "memory");
 }
@@ -23,6 +27,7 @@ static inline void iret_to_self(void)
 	unsigned int tmp;
 
 	asm volatile (
+		ALTERNATIVE("", "jmp 2f", X86_FEATURE_SERIALIZE)
 		"mov %%ss, %0\n\t"
 		"pushq %q0\n\t"
 		"pushq %%rsp\n\t"
@@ -32,6 +37,8 @@ static inline void iret_to_self(void)
 		"pushq %q0\n\t"
 		"pushq $1f\n\t"
 		"iretq\n\t"
+		"2:\n\t"
+		__ASM_SERIALIZE "\n"
 		"1:"
 		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
 }
@@ -54,7 +61,8 @@ static inline void iret_to_self(void)
 static inline void sync_core(void)
 {
 	/*
-	 * There are quite a few ways to do this.  IRET-to-self is nice
+	 * Hardware can do this for us if SERIALIZE is available. Otherwise,
+	 * there are quite a few ways to do this.  IRET-to-self is nice
 	 * because it works on every CPU, at any CPL (so it's compatible
 	 * with paravirtualization), and it never exits to a hypervisor.
 	 * The only down sides are that it's a bit slow (it seems to be
-- 
2.17.1

