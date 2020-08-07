Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9082523E645
	for <lists+linux-edac@lfdr.de>; Fri,  7 Aug 2020 05:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgHGD2x (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Aug 2020 23:28:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:42799 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgHGD2x (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 Aug 2020 23:28:53 -0400
IronPort-SDR: 1yj1qdaEnfZxoBT2AGV1VeRA/MfhZxlf7rprVnG+pqUtRFRzrTkA5d6TfhjeKlGhBIM8IJffyr
 eGFXwhC57oXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="152954956"
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; 
   d="scan'208";a="152954956"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 20:28:52 -0700
IronPort-SDR: 0E9cD/H5fx6Fo8etzqI3DOSq93r7jaZixsz19Qs2x+B5XHvjWPDTEOoPHMV5YNll+efx/om4Hx
 lwksviia0Z3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; 
   d="scan'208";a="468084410"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 06 Aug 2020 20:28:51 -0700
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
Subject: [PATCH v4] x86/cpu: Use SERIALIZE in sync_core() when available
Date:   Thu,  6 Aug 2020 20:28:33 -0700
Message-Id: <20200807032833.17484-1-ricardo.neri-calderon@linux.intel.com>
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
This is v4 from my three previous submission [1], [2], and [3]. The first
three patches of the series have been merged in Linus' tree. Hence, I am
submitting only this patch for review.

[1]. https://lkml.org/lkml/2020/7/27/8
[2]. https://lkml.org/lkml/2020/8/4/1090
[3]. https://lkml.org/lkml/2020/8/6/808

Changes since v3:
 * Reworked comments in sync_core() for better readability. (Dave Hansen)
 * Reworked the implementation to align with the style in special_insns.h.
   No functional changes were introduced. (Tony Luck)

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
 arch/x86/include/asm/special_insns.h |  6 ++++++
 arch/x86/include/asm/sync_core.h     | 26 ++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 59a3e13204c3..5999b0b3dd4a 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -234,6 +234,12 @@ static inline void clwb(volatile void *__p)
 
 #define nop() asm volatile ("nop")
 
+static inline void serialize(void)
+{
+	/* Instruction opcode for SERIALIZE; supported in binutils >= 2.35. */
+	asm volatile(".byte 0xf, 0x1, 0xe8" ::: "memory");
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index fdb5b356e59b..089712777fd9 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -5,6 +5,7 @@
 #include <linux/preempt.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
+#include <asm/special_insns.h>
 
 #ifdef CONFIG_X86_32
 static inline void iret_to_self(void)
@@ -54,14 +55,23 @@ static inline void iret_to_self(void)
 static inline void sync_core(void)
 {
 	/*
-	 * There are quite a few ways to do this.  IRET-to-self is nice
-	 * because it works on every CPU, at any CPL (so it's compatible
-	 * with paravirtualization), and it never exits to a hypervisor.
-	 * The only down sides are that it's a bit slow (it seems to be
-	 * a bit more than 2x slower than the fastest options) and that
-	 * it unmasks NMIs.  The "push %cs" is needed because, in
-	 * paravirtual environments, __KERNEL_CS may not be a valid CS
-	 * value when we do IRET directly.
+	 * The SERIALIZE instruction is the most straightforward way to
+	 * do this but it not universally available.
+	 */
+	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
+		serialize();
+		return;
+	}
+
+	/*
+	 * For all other processors, there are quite a few ways to do this
+	 * IRET-to-self is nice because it works on every CPU, at any CPL
+	 * (so it's compatible with paravirtualization), and it never exits
+	 * to a hypervisor. The only down sides are that it's a bit slow
+	 * (it seems to be a bit more than 2x slower than the fastest
+	 * options) and that it unmasks NMIs.  The "push %cs" is needed
+	 * because, in paravirtual environments, __KERNEL_CS may not be a
+	 * valid CS value when we do IRET directly.
 	 *
 	 * In case NMI unmasking or performance ever becomes a problem,
 	 * the next best option appears to be MOV-to-CR2 and an
-- 
2.17.1

