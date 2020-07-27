Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEC222E4F5
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 06:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgG0EcN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 00:32:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:24190 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgG0EcK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 00:32:10 -0400
IronPort-SDR: SxPV2w6bDrGA301NKwzSYG2q1+PZwnA6eW9Gt4T+ogs+Gwjx306e00WEsqt/huIIKycVBgP4MJ
 ryAvvEuOShMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="131016895"
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="131016895"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 21:32:10 -0700
IronPort-SDR: ixN6CYhk1cReiK28BiQnrsuFeTwrdYoA4YK2Af/XEbXHW/kb71rlPfH33q4Kgf9Gw5OX8fOgG+
 XRk08KSPr46Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="329550045"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2020 21:32:09 -0700
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
Subject: [PATCH 4/4] x86/cpu: Use SERIALIZE in sync_core() when available
Date:   Sun, 26 Jul 2020 21:31:32 -0700
Message-Id: <20200727043132.15082-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The SERIALIZE instruction gives software a way to force the processor to
complete all modifications to flags, registers and memory from previous
instructions and drain all buffered writes to memory before the next
instruction is fetched and executed. Thus, it serves the purpose of
sync_core(). Use it when available.

Use boot_cpu_has() and not static_cpu_has(); the most critical paths
(returning to user mode and from interrupt and NMI) will not reach
sync_core().

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
Reviwed-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
---
 arch/x86/include/asm/special_insns.h |  5 +++++
 arch/x86/include/asm/sync_core.h     | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 59a3e13204c3..0a2a60bba282 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -234,6 +234,11 @@ static inline void clwb(volatile void *__p)
 
 #define nop() asm volatile ("nop")
 
+static inline void serialize(void)
+{
+	asm volatile(".byte 0xf, 0x1, 0xe8");
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index fdb5b356e59b..bf132c09d61b 100644
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
@@ -75,6 +77,12 @@ static inline void sync_core(void)
 	 * Like all of Linux's memory ordering operations, this is a
 	 * compiler barrier as well.
 	 */
+
+	if (boot_cpu_has(X86_FEATURE_SERIALIZE)) {
+		serialize();
+		return;
+	}
+
 	iret_to_self();
 }
 
-- 
2.17.1

