Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B5723E21B
	for <lists+linux-edac@lfdr.de>; Thu,  6 Aug 2020 21:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgHFTZv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Aug 2020 15:25:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:17834 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgHFTZv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 Aug 2020 15:25:51 -0400
IronPort-SDR: S93U1g4Kzx9e9Bladk0irKIg5lURiFrJrPoJOFr+7L/Am/fWtajNRexhSYKivPLTX0qsKJZ0V1
 x2ixX9CuN9eA==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="150637117"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="150637117"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 12:25:50 -0700
IronPort-SDR: nVMEfMzQrFS2qrV8CO5TL2tsnf0ZZDvw2SEgJxnRR7yUkRFScyeLZ6jWA7IcaFWboeuR1ClA8t
 7LrGnk3/ZCVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="323534422"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2020 12:25:49 -0700
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
        linux-edac@vger.kernel.org
Subject: [PATCH v3] x86/cpu: Use SERIALIZE in sync_core() when available
Date:   Thu,  6 Aug 2020 12:25:31 -0700
Message-Id: <20200806192531.25136-1-ricardo.neri-calderon@linux.intel.com>
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
Reviewed-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
This is a v3 from my two previous submissions [1], [2]. The first three
patches of the series have been merged into Linus' tree. Hence, I am
submitting only this patch for review.

[1]. https://lkml.org/lkml/2020/7/27/8
[2]. https://lkml.org/lkml/2020/8/4/1090

Changes since v2:
 * Support serialize with static_cpu_has() instead of using alternative
   runtime patching directly. (Borislav Petkov)

Changes since v1:
 * Support SERIALIZE using alternative runtime patching.
   (Peter Zijlstra, H. Peter Anvin)
 * Added a note to specify which version of binutils supports SERIALIZE.
   (Peter Zijlstra)
 * Verified that (::: "memory") is used. (H. Peter Anvin)
---
 arch/x86/include/asm/special_insns.h | 2 ++
 arch/x86/include/asm/sync_core.h     | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

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
index fdb5b356e59b..b74580413a0b 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -5,6 +5,7 @@
 #include <linux/preempt.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
+#include <asm/special_insns.h>
 
 #ifdef CONFIG_X86_32
 static inline void iret_to_self(void)
@@ -54,7 +55,8 @@ static inline void iret_to_self(void)
 static inline void sync_core(void)
 {
 	/*
-	 * There are quite a few ways to do this.  IRET-to-self is nice
+	 * Hardware can do this for us if SERIALIZE is available. Otherwise,
+	 * there are quite a few ways to do this.  IRET-to-self is nice
 	 * because it works on every CPU, at any CPL (so it's compatible
 	 * with paravirtualization), and it never exits to a hypervisor.
 	 * The only down sides are that it's a bit slow (it seems to be
@@ -75,6 +77,11 @@ static inline void sync_core(void)
 	 * Like all of Linux's memory ordering operations, this is a
 	 * compiler barrier as well.
 	 */
+	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
+		asm volatile(__ASM_SERIALIZE ::: "memory");
+		return;
+	}
+
 	iret_to_self();
 }
 
-- 
2.17.1

